Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3210EC0218A
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 02:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdgNX-0004NT-05; Thu, 30 Jan 2025 21:03:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mmorrell@tachyum.com>)
 id 1tdgNV-0004L1-6D
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 21:03:29 -0500
Received: from mxa.tachyum.com ([66.160.133.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mmorrell@tachyum.com>)
 id 1tdgNT-0005h6-6Z
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 21:03:28 -0500
Received: from mxa.tachyum.com (localhost.localdomain [127.0.0.1])
 by mxa.tachyum.com (Proxmox) with ESMTP id 9B9931E76E7
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 18:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tachyum.com; h=
 cc:content-type:content-type:date:from:from:message-id
 :mime-version:reply-to:subject:subject:to:to; s=dkim; bh=0t5Jwpy
 AY4cRlBXX81QUB3goyHNS4ORGA+fldBxHj84=; b=sA8/P4unusi1zbDMe/KE+h1
 521uTNCaemQbNY36pIKk5V/igHJHQal4yHVy0o+qzxHut05PnRAcEJbz5fy0u4ch
 +wIBqcOqiW00De/KqbO1K/TWfOj9XcTGbFTfnuwcucjoFFpsHPnkA3WRcfbT0TOv
 jotSR4PYyOo6V2xJTC5WeRKtHQ/KvlLpVOiRUndqfYQixe/d2FNU/ZEFLgW5lFTk
 btsBsu+//+FeP1rLYb2nENAx3jEkV4d+k1Z7G5jxAmeRNGaWb4P0S+p/+2qz0DhE
 Big+q92DaHtLuMyhHOFoBtyIRAmD/29RCOZNOpEVfvVLITojYQ4t4xciyjqeGAg=
 =
From: Michael Morrell <mmorrell@tachyum.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: x86 denormal flag handling
Thread-Topic: x86 denormal flag handling
Thread-Index: AdtzgjdbXE/Z+ZiSQg21Zmjyx/dbHA==
Date: Fri, 31 Jan 2025 02:03:12 +0000
Message-ID: <96e999333e9b49fcb60f051a29d41c83@tachyum.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: multipart/alternative;
 boundary="_000_96e999333e9b49fcb60f051a29d41c83tachyumcom_"
MIME-Version: 1.0
Received-SPF: pass client-ip=66.160.133.173; envelope-from=mmorrell@tachyum.com;
 helo=mxa.tachyum.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--_000_96e999333e9b49fcb60f051a29d41c83tachyumcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I've been following the recent changes to better support denormal handling =
and I don't think they are doing the right thing for x86.

I tried a simple program to convert a denormal float value (0x1.0p-127) to =
a double.  With the default of DAZ being 0 in MXCSR, x86 sets DE, but QEMU =
doesn't.  This is the opposite behavior of AARCH64 which sets their denorma=
l input flag when it flushes a denormal input to 0.

Here's what I tried:

#include <stdio.h>
#include <immintrin.h>

volatile float f =3D 0x1.0p-127;

int main()
{
    double d =3D f;
    printf("Converting a denormal float to a double %s the DE bit in MXCSR\=
n",
           _mm_getcsr() & _MM_EXCEPT_DENORM ? "sets" : "does not set");
    return 0;
}

When run on a native machine, it prints:

Converting a denormal float to a double sets the DE bit in MXCSR

But when run using QEMU, it prints:

Converting a denormal float to a double does not set the DE bit in MXCSR

--_000_96e999333e9b49fcb60f051a29d41c83tachyumcom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">I&#8217;ve been following the recent changes to bett=
er support denormal handling and I don&#8217;t think they are doing the rig=
ht thing for x86.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I tried a simple program to convert a denormal float=
 value (0x1.0p-127) to a double.&nbsp; With the default of DAZ being 0 in M=
XCSR, x86 sets DE, but QEMU doesn&#8217;t.&nbsp; This is the opposite behav=
ior of AARCH64 which sets their denormal input flag
 when it flushes a denormal input to 0.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Here&#8217;s what I tried:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">#include &lt;stdio.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">#include &lt;immintrin.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">volatile float f =3D 0x1.0p-127;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">int main()<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; double d =3D f;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; printf(&quot;Converting a denorma=
l float to a double %s the DE bit in MXCSR\n&quot;,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; _mm_getcsr() &amp; _MM_EXCEPT_DENORM ? &quot;sets&quot; : &quot;do=
es not set&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">When run on a native machine, it prints:<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Converting a denormal float to a double sets the DE =
bit in MXCSR<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">But when run using QEMU, it prints:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Converting a denormal float to a double does not set=
 the DE bit in MXCSR<o:p></o:p></p>
</div>
</body>
</html>

--_000_96e999333e9b49fcb60f051a29d41c83tachyumcom_--


