import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String result = 'Click send button for check the result';
  String request = 'Click send button for check the request';

  _callWsdl() async {
    String soapReq = '''<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:cti="http://cti.cakrawala-techInc.com">
   <soapenv:Header/>
   <soapenv:Body>
      <cti:ping/>
   </soapenv:Body>
</soapenv:Envelope>''';
    http.Response response = await http.post(
      Uri.parse('http://emas.telkom.co.id:8080/dava/DavaInterface?wsdl'),
      headers: {
        'content-type': 'text/xml',
      },
      body: utf8.encode(soapReq),
    );

    print('Request :');
    print(soapReq);

    print('Result :');
    print(response.statusCode);
    print(response.body);

    setState(() {
      result = response.body;
      request = soapReq;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter WSDL'),
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Request : ',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                request,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Result : ',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                result,
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _callWsdl();
        },
        tooltip: 'Increment',
        child: Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
