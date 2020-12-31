<%@ page import="org.jeecgframework.core.util.ResourceUtil,org.jeecgframework.core.util.SysThemesUtil,org.jeecgframework.core.enums.SysThemesEnum,java.util.Random"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="/context/mytags.jsp"%>
<%
  session.setAttribute("lang","zh-cn");
  SysThemesEnum sysTheme = SysThemesUtil.getSysTheme(request);
  String lhgdialogTheme = SysThemesUtil.getLhgdialogTheme(sysTheme);
  
  response.setHeader("Pragma","no-cache"); 
  response.setHeader("Cache-Control","no-cache"); 
  response.setDateHeader("Expires", 0); 
  Random rand = new Random();
  long randnum = Math.abs(rand.nextLong());
  session.setAttribute("RandNum", String.valueOf(randnum));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8;no-cache" />
<%@include file="/context/meta.jsp"%>
<title><%=ResourceUtil.getConfigByName("page.title")%></title>
<link href="${webRoot}/plug-in/desktop/css/login.css" rel="stylesheet" type="text/css" />
<link href="${webRoot}/plug-in/desktop/css/public.css" rel="stylesheet" type="text/css" />
<%-- <link rel="shortcut icon" type="image/x-icon" href="${webRoot}/<%=ResourceUtil.getConfigByName("page.systemicon")%>" media="screen" /> --%>
<script type="text/javascript" src="${webRoot}/plug-in/jquery/jquery-1.8.3.min.js"></script>

<script type="text/javascript" src="plug-in/login/js/jquery.tipsy.js"></script>
<script type="text/javascript" src="plug-in/jquery/jquery.cookie.js"></script>
<script type="text/javascript" src="plug-in/login/js/jquery-jrumble.js"></script>
<!-- <script type="text/javascript" src="plug-in/login/js/iphone.check.js"></script> -->
 <script src="plug-in/TWCA/clientConf.js" type="text/javascript"></script>
 <script src="plug-in/TWCA/TopESA3.1.0.4.20242.js" type="text/javascript"></script>
 <script src="plug-in/TWCA/TWCA.js" type="text/javascript"></script>
<script language="javascript" src="${webRoot}/plug-in/portal/skin/js/tab.js" ></script>

<script type="text/javascript" src="webpage/login/auth.js"></script>
<script type="text/javascript" src="webpage/com/gxcx/common/form_json.js"></script>

<!-- ace scripts -->
<script src="plug-in/ace/js/ace-extra.js"></script>


<script type="text/javascript">
$(document).ready(function () {
	
	$("#tab1").click(function() {
		$("#content2").show();
		$("#content1").hide();
	});

	$("#tab2").click(function() {
	    $("#content1").show();
	    $("#content2").hide();
	});
	$("#ca").mouseover();
	var init  = false;
	if(isIE()){ 
	  try{
		  //if(!doEkeyAuthShow()){
			  //隐藏CA 和 密码
		  	  //$("#CASn").css('display','block');
		  	  //$("#isShow").val("01");
		  	  //$("#CA").css('display','none');
		  	  //$("#passicon").css('display','none');
			  TopESAConfig();
			  init = true;
		  //}
		
	    //refreshCertList();
	    //refreshCspList();
	    //return ;
	  }catch(e){
		  $("#CertList option").remove();
	    //  $("#CAalert").html("初始化CA使用环境失败，请检查本机配置！");
	  }
	}else{
		//alert("CA登录请使用IE浏览器！");
		$(".NoticBox").slideToggle(500);
		$("#close").click(function(e) {
			$(".NoticBox").hide();
			$(".NoticBox8").show();
		});
	}
	if( init ){
	    refreshCertList(1);
	}
});

function isIE() { //ie?  
    if (!!window.ActiveXObject || "ActiveXObject" in window){
        return true; 
    }else{
        return false; 
    }  
}  


function loginCA(){
	
	 if(isIE()){ 
		try{
			var isShow = $("#isShow").val();
			if(isShow=='00'){
				if(doEkeyAuth()){
					//loginsuccessCA();
					 var form = document.getElementById("userCaForm");
	                 form.action = "http://caadmin.capitalwater.cn/ekeyLogin.do";
	                 form.submit();
				}
			}
			
			if(isShow=='01'){
				var cert = getSelectedCert();
				var signmsg = cert.signMessage("loginCA");
				if( signmsg!=null && signmsg!="" ){
					loginsuccessTW(cert.serialNumber());
				}
			}
	    }catch(e){
	   	  
	    }
	}else{
		alert("CA登录请使用IE浏览器！");
		return;
	} 
}

function loginCACert(){
	debugger;
	 if(isIE()){ 
		try{
				if(doCertfileAuth()){
					//loginsuccessCA();
					 var form = document.getElementById("loginForm");
	                 form.action = "http://caadmin.capitalwater.cn/certFileLogin.do";
	                 form.submit();
	                 alert("12222222222");
				}
	    }catch(e){
	   	  
	    }
	}else{
		alert("CA登录请使用IE浏览器！");
		return;
	} 
}

function loginsuccessCA(){
	var appId=$("#appId").val();
	$.ajax({
		url : "loginController.do?caLogin",
		data : {"cert":document.all.cert.value,
				"random":document.all.random.value,
				"appId":appId,
			   },
		type : "post",
		cache : false,
		success : function(data){
			debugger;
			/* var d = $.parseJSON(data);
			if(d.success){
				var user = d.obj;
				Login("","","caLogin",user);
			}else{
				alert(d);
				console.log(d);
				alert("该KEY没有绑定任何用户,或绑定已过有效期！");
			} */
		},
		error : function(msg) {
			alert("登录失败！");
		}
	});
}
</script>

</head>

<body>
			<div class="NoticBox8"> </div>
			<div class="wrapper NoticBox" id="divId" style="display: none">
				如果使用CA登录平台，请使用IE浏览器122112211212
				<div id="close"><b>关闭</b></div>
			</div>
			<div class="loginlogoBox">
				<div class="wrapper  relative">
					<div class="loginlogoLeft">
						<a href="<%=ResourceUtil.getConfigByName("page.index")%>">
							<span><img src="${webRoot}/plug-in/desktop/images/logo.png"></span><span style="padding:20px 0 0 15px;display: inline-block;"><img src="${webRoot}/plug-in/desktop/images/logotext.png"></span>
						</a>
					</div>
					<div class="logintelBox">
						<span>010-81136388</span>
						</span>

					</div>
				</div>
			</div>

<input type="hidden" name="absolutedPath" value="<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"%>" id="absolutedPath"/>
<input type="hidden" id="initPath" value="${webRoot}" />
<input type="hidden" id="CAWebAddress" value="<%=ResourceUtil.getConfigByName("CAWebAddress")%>" />
<input type="hidden" id="CATradingPlatformDn" value="<%=ResourceUtil.getConfigByName("CATradingPlatformDn")%>" />
<input type="hidden" id="authCode" />
<div class="loginBox relative">
    <div class="wrapper relative">
	    	<div class="loginRight">
	          <form id="loginForm" check="loginController.do?checkuser" action="loginController.do?login" role="form" method="post">
	          <ul class="loginInfo" id="content1"  style="display: block;">
			          <a class="loginIcon" href="#" id="tab1"></a>
					  <div class="CAname"><span style="background:url('${webRoot}/plug-in/desktop/images/caicon.png') no-repeat 0 0px;padding-left:25px;">CA登录在这里</span></div>
		          <input type="hidden" name="authType" value="1">
		         
		          <li><b>证书登录</b></li>
		            <li>
		              <div>证书文件</div>
		             <input type="file" name="SAFE_FILE_CONTENT" >
		            </li>
		            <li class="passicon">
		              <div>密&nbsp;&nbsp;&nbsp;&nbsp;码</div>
		               <input type="hidden"  name="userPIN" value=""/>
		              <input type="hidden"  name="random" value="<%=randnum%>">
		              <input type="hidden" id="appId" name="appId" value="<%=ResourceUtil.getConfigByName("AppId")%>"/>
		              <input type="password"   name="cert" id="cert" nullmsg="请输入密码!" title="密码" class="form-control"/>
		            </li>
		            <li class="buttonBox">
	             		 <button type="button" id="login" onclick="loginCACert()"><span>登&nbsp;&nbsp;录</span></button>
	            	</li>
	            <li class="textBox"> <span id="ErrorMsg">
	            
	            </span> </li>
	            
	            
	            <li class="jiaru">
	          </li>
	          </ul>
	          </form>
          
          
          <%-- <form id="userCaForm" name="userCaForm" method="post" >
          <input name="getcert2" type="hidden" id="signCertIndext" value="0"/>
         <input type="hidden" id="isShow" value="00"/>
         <ul class="tabCA" id="content2" style="display:none;">
         	<a class="CArightIcon" href="#" id="tab2"></a>
         	<div class="CAnameTitle"><span style="background:url('${webRoot}/plug-in/desktop/images/lock.png') no-repeat 0 0px;padding-left:25px;">普通登录在这里</span></div>
        	<div >
		           	 <li><b>CA登录</b></li>
			       		 <li id="CASn">
			       		 <select  id="CertList" name="usrCaSn" class="form-control"></select>
			        	</li>
			        	
			        	<li class="CA" id="CA" style="display: none">
			        	<div>C&nbsp;&nbsp;&nbsp;&nbsp;A</div>
	            		<input type="text" autocomplete="off" value="请插入您的UKey" readonly  class="form-control" /> 
						</li>
			        	<li class="passicon"  id="passicon" style="display: none">
			        	<div>密&nbsp;&nbsp;&nbsp;&nbsp;码</div>
			        	  <input type="hidden"  name="random" value="<%=randnum%>">
			              <input type="hidden"  name="userPIN" value=""/>
			              <input type="hidden" id="appId" name="appId" value="<%=ResourceUtil.getConfigByName("AppId")%>"/>
	              		  <input type="password"   name="cipher" id="cipher" nullmsg="请输入密码!" title="密码" class="form-control"/>
						</li>
			            <li>
			              <button type="button" id="loginCABtn" class="enterBtn"  onclick="loginCA()"><span id="usrCaSnSpan">登&nbsp;&nbsp;录</span></button>
			            </li> 
			            <li style="color:#ed5f5b" name="CAalert" id="CAalert">${alert }</li>
			            <li class="attention">
			              <h3><span>请注意：</span></h3>
			              <div>若您的电脑尚未安装USBKey驱动程序 请点击<br />
			              <a target="_blank" href="${webRoot}/PortalController.do?toolsDownload">
			              	这里</a>进行安装。</div>
			            </li>
            </div>
          </ul>
          </form> --%>
        </div>
       </div>
        <div id="imgsDiv">
					<div class="picDiv show" style="background-image: url(${webRoot}/plug-in/desktop/images/loginimg.png);  background-size: cover ;"></div>
		</div>
     
     	</div>
<div class="logincopy"> 
<div style="line-height:30px;padding-top:0px;color: #282828;">北京首创股份有限公司 版权所有 京ICP备06018296号 京公网安备11010502030310号 </div>
</div>

<script type="text/javascript" src="${webRoot}/plug-in/desktop/js/jquery1.42.min.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/desktop/js/jquery-2.0.0.min.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/desktop/js/bootstrap.js" /></script>

<script src="plug-in/ace/js/bootbox.js"></script>

<script src="plug-in/ace/js/jquery-ui.js"></script>
<script src="plug-in/ace/js/jquery.ui.touch-punch.js"></script>
<!-- ace scripts -->
<script src="plug-in/ace/js/ace/elements.scroller.js"></script>
<script src="plug-in/ace/js/ace/elements.colorpicker.js"></script>
<script src="plug-in/ace/js/ace/elements.fileinput.js"></script>
<script src="plug-in/ace/js/ace/elements.typeahead.js"></script>
<script src="plug-in/ace/js/ace/elements.wysiwyg.js"></script>
<script src="plug-in/ace/js/ace/elements.spinner.js"></script>
<script src="plug-in/ace/js/ace/elements.treeview.js"></script>
<script src="plug-in/ace/js/ace/elements.wizard.js"></script>
<script src="plug-in/ace/js/ace/elements.aside.js"></script>
<script src="plug-in/ace/js/ace/ace.js"></script>
<script src="plug-in/ace/js/ace/ace.ajax-content.js"></script>
<script src="plug-in/ace/js/ace/ace.touch-drag.js"></script>
<script src="plug-in/ace/js/ace/ace.sidebar.js"></script>
<script src="plug-in/ace/js/ace/ace.sidebar-scroll-1.js"></script>
<script src="plug-in/ace/js/ace/ace.submenu-hover.js"></script>
<script src="plug-in/ace/js/ace/ace.widget-box.js"></script>
<script src="plug-in/ace/js/ace/ace.settings.js"></script>
<script src="plug-in/ace/js/ace/ace.settings-rtl.js"></script>
<script src="plug-in/ace/js/ace/ace.settings-skin.js"></script>
<script src="plug-in/ace/js/ace/ace.widget-on-reload.js"></script>
<script src="plug-in/ace/js/ace/ace.searchbox-autocomplete.js"></script>
<script src="plug-in/login/js/login.js"></script>
<t:base type="tools" ></t:base>
<script type="text/javascript">

/* function longinUp(){
	
	$("#langCodeSelect").attr("name","en");
	$("login").click();
	
} */

$("#but_registrat").click(function(){
	document.location="departExtController.do?registrationfirst";
})
  //验证码输入框按下回车
  function randCodeKeyDown(){
	debugger;
	  var lKeyCode = (navigator.appname=="Netscape")?event.which:window.event.keyCode; //event.keyCode按的建的代码，13表示回车
		if(lKeyCode == 13){
			checkUser();
		}else{
			return false;
		}
  }
  //验证用户信息
  function checkUser(){
	  debugger
    /* if(!validForm()){
      return false;
    } */
    Login();
  }
  //表单验证
  function validForm(){
    if($.trim($("#userName").val()).length==0){
      showErrorMsg("请输入用户名");
      return false;
    }

    if($.trim($("#password").val()).length==0){
      showErrorMsg("请输入密码");
      return false;
    }

    if($.trim($("#randCode").val()).length==0){
      showErrorMsg("请输入验证码");
      return false;
    }
    return true;
  }

  //登录处理函数
  function Login(orgId,rolId,caType,user) {
    setCookie();
    var actionurl=$('form').attr('action');//提交路径
    var checkurl=$('form').attr('check');//验证路径
    var formData = new Object();
    if(caType=='caLogin'){
    	formData['id'] = user.id;
    	formData['password'] = user.password;
    	formData['userName'] = user.userName;
    	formData['caType'] = caType;
    }else{
    	var data=$(":input").each(function() {
    	      formData[this.name] =$("#"+this.name ).val();
    	    });
    }
    formData['orgId'] = orgId ? orgId : "";
    formData['rolId'] = rolId ? rolId : "";
    // update-begin--Author:ken  Date:20140629 for：添加语言选择
    formData['langCode']=$("#langCode").val();
    // update-end--Author:ken  Date:20140629 for：添加语言选择
    formData['langCode'] = $("#langCodeSelect option:selected").val();
    $.ajax({
      async : false,
      cache : false,
      type : 'POST',
      url : checkurl,// 请求的action路径
      data : formData,
      error : function() {// 请求失败处理函数
      },
      success : function(data) {
        var d = $.parseJSON(data);
        if (d.success) {
          loginsuccesson();
          var title, okButton;
          if($("#langCode").val() == 'en') {
            title = "Please select Org";
            okButton = "Ok";
          } else {
            title = "请选择组织机构";
            okButton = "确定";
          }
         
          if (d.attributes.orgNum > 1||d.attributes.rolNum > 1) {
            $.dialog({
              id: 'LHG1976D',j
              title: title,
              max: false,
              min: false,
              drag: false,
              resize: false,
              zIndex:9999,  
              content: 'url:userController.do?userOrgSelect&userId=' + d.attributes.user.id,
              lock:true,
              button : [ {
                name : okButton,
                focus : true,
                callback : function() {
                  iframe = this.iframe.contentWindow;
                  var orgId = $('#orgId', iframe.document).val();
                  var rolId = $('#rolId', iframe.document).val();
                  Login(orgId,rolId,caType,d.attributes.user);
                  //this.close();
                  return false;
                }
              }],
              close: function(){
                window.location.href = actionurl;
              }
            });
           } else {
            setTimeout("window.location.href='"+actionurl+"'", 1000);
          }  
       } else {
          if(d.msg == "a"){
            $.dialog.confirm("数据库无数据,是否初始化数据?", function(){
              window.location = "init.jsp";
            }, function(){
            });
          } else {
            showErrorMsg(d.msg);
          	return false;
          }
        }
      }
    });
  }

  function showErrorMsg(msg){
	  $("#ErrorMsg").html(msg);
	  $("#randCode").val('');
	  $('#randCodeImage').click();
    //tip(msg);
  }

  function darkStyle(){
    $('body').attr('class', 'login-layout');
    $('#id-text2').attr('class', 'red');
    $('#id-company-text').attr('class', 'blue');
    e.preventDefault();
  }
  function lightStyle(){
    $('body').attr('class', 'login-layout light-login');
    $('#id-text2').attr('class', 'grey');
    $('#id-company-text').attr('class', 'blue');

    e.preventDefault();
  }
  function blurStyle(){
    $('body').attr('class', 'login-layout blur-login');
    $('#id-text2').attr('class', 'white');
    $('#id-company-text').attr('class', 'light-blue');

    e.preventDefault();
  }

</script>


<script>
	function goquestionpage(){
		window.location.href='PortalController.do?retrievePassword';
	}
</script> 

		<div style="display:none">
			<jsp:include page="demo.jsp"/>
		</div>

</body>
</html>
