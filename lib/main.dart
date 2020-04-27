import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
void main()=>runApp(MyApp());
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<File> imageFile;
  pickImageFromGallery(ImageSource imageSource) async{
    setState(() {
      imageFile=ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }
  Widget showImage(){
    return FutureBuilder(
      future: imageFile,
      builder: (BuildContext context,AsyncSnapshot<File> snapshot){
        if(snapshot.connectionState==ConnectionState.done && snapshot.data!=null){
        return Image.file(snapshot.data,
          width: 300,
          height: 300,
        );
        }
        else if(snapshot.error!=null){
          return Text("Error Picking Image",textAlign:TextAlign.center);
        }
        else{
          return Text("No Image Selected");
        }
      });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.pink,
      ),
      home: Scaffold(
        appBar: AppBar(
          title:Text("Pick Image From Gallery"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                showImage(),
                RaisedButton(
                  onPressed: (){
                    pickImageFromGallery(ImageSource.gallery);
                  },
                  child: Text("Selected Image From Gallery"),
              )           
            ],
          ),
        ),
      ),
    );
  }
}