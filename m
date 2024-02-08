Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D74C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 21:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYC3u-0007uJ-F1; Thu, 08 Feb 2024 16:36:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.schmitt@starlab.io>)
 id 1rY9zg-00037R-0i
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 14:23:32 -0500
Received: from mail-dm3gcc02on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2419::700]
 helo=GCC02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.schmitt@starlab.io>)
 id 1rY9zS-0002rr-RK
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 14:23:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWvcJr9dwZqWdK+Q3ABRZC20h/lcAZZPFRjKJtePvsWU8mPBQKXyHa9semHyXp56edOv8z31axRAXFlbDa2GdoPuDeoVzlV8pGYnV5eIr9h7OTjT5vF7thGTq1ZdJdpnjkgfLiQZ9bP/Fhsunnkpi+uk8ZLJVjVm7s9djZu3zlA0ASOq24xyN1VwuDRveIFnf7E+5/5Q81v/49Gh8mxWfxPlNPb3cfaumkzdg+IfqT38yuPUFn/AXt2/IVZSrYOQBN2ZPoS4O2fEhmHBJWYZwJt5PbeygPFKtwCgvl0xmQys/O8U5xd2Tky1uTUv5o5EwbaE6zHBRPVlP8YDjeUBBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pt1twt9qFcdwlA4ssYjybrxGFwi1ZbUCFRlpCExihoM=;
 b=hjodr7axi/QfvqCZdyCoM/Ccihn6/1RH958T6oVptvhZpcOjJ4iWxEuVGhRxRP/z6uU5c7oPny9kSZmBauya1Ud8S56jnOkOEpfoRv92H9uISVSYMYMmo7lNamp5GF5YeTs9xcZx6kn9oKeCi/00I2eK4iDqvLonDLyVJjfFgppQl4KRgs2nns8tATs4tVa/u83cWws8FNQnOesZGLhfUCOI2ObdRPzluq13hwfPwyebILtfLyflc0wUeOSHx6y8UUfHKyEGmj26ETPkfmZtvr6XeyRFILTfHyCHYsORsQ6QovP9XCTr4T+NW0gj550pXi0mYCDLB5A/fa+BG+mlPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starlab.io; dmarc=pass action=none header.from=starlab.io;
 dkim=pass header.d=starlab.io; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=starlab.io;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pt1twt9qFcdwlA4ssYjybrxGFwi1ZbUCFRlpCExihoM=;
 b=SG8VF7mdSqYIsIs6Ik83Bs/pDd1f6m9HqM05zMT0sDtjNz8K6OV994+3tftkSdqpT/5o9pmh7FIq7ayENUtVh+MRMcVz+uFd4owDhmrFjdTSh8xJB/RTNrb4vB3qnlmfbgilIsQ+JriHRRRXVO0Ohx0h0RPBX+bC2Pk5RgkmrSc=
Received: from DM6PR09MB5288.namprd09.prod.outlook.com (2603:10b6:5:260::16)
 by SJ0PR09MB9434.namprd09.prod.outlook.com (2603:10b6:a03:461::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Thu, 8 Feb
 2024 19:23:10 +0000
Received: from DM6PR09MB5288.namprd09.prod.outlook.com
 ([fe80::dacd:ff7c:a6b5:7c65]) by DM6PR09MB5288.namprd09.prod.outlook.com
 ([fe80::dacd:ff7c:a6b5:7c65%5]) with mapi id 15.20.7292.010; Thu, 8 Feb 2024
 19:23:10 +0000
From: Richard Schmitt <richard.schmitt@starlab.io>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Unit Test Aborts when building with -ftrapv compiler option
Thread-Topic: Unit Test Aborts when building with -ftrapv compiler option
Thread-Index: AQHaWsQLJyaTyHOpzEGfB6zmP6vQVA==
Date: Thu, 8 Feb 2024 19:23:10 +0000
Message-ID: <DM6PR09MB528878EFFA4532FF15D778DF9C442@DM6PR09MB5288.namprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starlab.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR09MB5288:EE_|SJ0PR09MB9434:EE_
x-ms-office365-filtering-correlation-id: 4f813e7e-1ab5-4cf2-7687-08dc28db62f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JH68tEBZNC5LvPrH6/e4FBw8ZdjLr4arUUQ7Yuw/GTqQ0SRi1mtDXUsWJs224Bea/ViRvobhckoECnxKB7o16cGfZ1LYPBIQZHQQjtePxFNtKhVu3g0sDHxd38yC5ezWB2UpVXMrKCK1g5KsIwgu7iHN54VIN6e0vRvCpnkt/p1MqyCJoBIxuUvq+TNf5VS/uJEq0NnpNjKs7+s3UIzPywfoOHxYSS99wlJaEsCTgObcY3P92t08+s4nAy6C0iAyNJiAywpqhWyQUE9ECDMwVHe7pc1NCjQclvR5TSsF1PElFd/3Bi5O7pqcT+efY0K/Z4XubdVNKsh1M8YIatigRfXKFUrOnWcEGVh3GTbWm6hAJQPQ5XroSA2E2Yc/yIwpSjyAnFWXvUGd7BgrW5j4v6bNRUElyfGJyHEkHEXAWV83lPEWTjfDLE4IxTuZkklHubOnNoDerhqKYIxByt0WiS7hWhxfjeeiUxqfGAWKEM3bYPZBQ1wjqkvMqpxYjEjBmnU7MMNr43knyyGXPesaE6FnIVAbTKyzpk7x0EqFbTInimpbd1SE+INiXQ6lNODN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR09MB5288.namprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(39830400003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(41300700001)(41320700001)(64756008)(2906002)(66946007)(508600001)(38070700009)(9686003)(8676002)(91956017)(66556008)(86362001)(76116006)(71200400001)(7696005)(44832011)(26005)(6916009)(5660300002)(6506007)(52536014)(66446008)(33656002)(66476007)(38100700002)(99936003)(8936002)(55016003)(122000001)(579004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?EB4DyfVfGSBWwfCNg10qOaM8pnIh74Yghhs7+qAcp5xgPmfFHGtcnW+w?=
 =?Windows-1252?Q?ayRGHyf3vWaC1QOoePEax271Ap3/XJXaspI2wSvwmqoYITEKCoNL/MIW?=
 =?Windows-1252?Q?1zXmSPv41uPf/UhqUPTt+o+yP1SNDFICC3cJzkKho66/mNoCRuCrHnEX?=
 =?Windows-1252?Q?jWLPW+gqIxVM/jirAZaPjVdwVc/6a/c+oqhWTRoWnsYnut6a1uuVIG72?=
 =?Windows-1252?Q?BpjOGOPyWWBjp+czuy6kn4MLfK+2j4n2EIe1cRWnxbuj8tcXubW5dCrg?=
 =?Windows-1252?Q?54TLluKHBep4TknPjxBYWqgLk5H36oiYLkeiNe5LzEXPzdz+lsDxR4yN?=
 =?Windows-1252?Q?tufLo77ZU9u4ZezHkRO89InYCNCy2ZNTtscC3RYt2OmQCurM/zrcoUNS?=
 =?Windows-1252?Q?5N7DgMuThA0yDBmZpMFbp43Be1YIgEU6T/5ZuHa8LgpdGvX+Si2rRwoF?=
 =?Windows-1252?Q?E0GUqrAeANhz0lrJO3tdJhhtJdI308vUYuju1GDgK/+In2CbsLiRfUPV?=
 =?Windows-1252?Q?w8dIgeTRvRNqDDl3MDCAmG0MOA1joLiqcu4fnr2m0hg2hdnqMssME4IU?=
 =?Windows-1252?Q?TVczZS4TawMICA9KLZM2cBhhrCOYHJ1I8Db8mwayEqniYm0E0QK+7ir6?=
 =?Windows-1252?Q?LGrCbGryHKXuG7Hu6poz8ZEU1QslkaNamshPePfMXgURNSc36twCoc9q?=
 =?Windows-1252?Q?bZDQ5bgaFgsBSD7nBJ+CO743WQSija9djuoKoCNKFV1G3POfUHWMVgL7?=
 =?Windows-1252?Q?Q+jYZNs/zP/D/TyWxPJVx4P1yokF9ptoIfVs5C9MxQb5POC96uSJf/Uw?=
 =?Windows-1252?Q?BbF52ti/d1ZJLpBVFGOES1hEt+qzrOgeGm4OQFvqZBgBvrQJ7LOrj8gT?=
 =?Windows-1252?Q?Mp8v4tlVltdBVNw1SEUKDXrjDkR2wihb+WnaNfSeOLT1r1xSIkF4uNrP?=
 =?Windows-1252?Q?fV6OHH4eKjXkdDuLBBJtLXOHfaEQFjz+Spac+pepTwgGZ1eHH/HjpKJw?=
 =?Windows-1252?Q?hPVyBdpAYZ24ZvhVi490fDnqFcf01BUu7kHEpiN4fSnob+mI7wMETVVQ?=
 =?Windows-1252?Q?p8lfCPbii4sF+4+giWYne8X6LMukYH4ADk87sO5uhXJef8BM1okLWl3y?=
 =?Windows-1252?Q?hAJERS7bAAh0biW/gbHGZuWLkxdUgfXxF/5lgsb2M8ugoVa7wTIX6uXX?=
 =?Windows-1252?Q?QekVTQAHl9ih+WBkXaKKHL31X+WgF3q/mIj7uBpIZ7brJPnNyRuLESbX?=
 =?Windows-1252?Q?TUVqBp3uo6EwqK1JfHgowxhyoKAdpINHvJ/4cppkrKuf+UE078QpwPXj?=
 =?Windows-1252?Q?eSfKavGzUK3aBEQVrxee8otWuYZeQmWY6zvI1Km0JwWZEj7MZCf+pAM/?=
 =?Windows-1252?Q?wMTCwgFc8Rrmw3jHs+TvxgNb76UctHc2wDohIbeMjt7H9ykRi+gbrk5Q?=
 =?Windows-1252?Q?IUpgyRw9bIGWvzyhjuQYhbujgf6KoVj+6h0xCEjP6re9969pBb3IJEgG?=
 =?Windows-1252?Q?216BB7nKyb45JIhQL9UMPxP+DSFInAddFhizHkwFUNgqAyS6N8wI+EZt?=
 =?Windows-1252?Q?VgUg3sci8feTmWfo+ZO6VkzMqWoFaBzCL6OG/HmWtwOmGPLggjbSYRUV?=
 =?Windows-1252?Q?tlHPy89GpJxvjVL2JzUY+yDBwjcwEqy2HoQDYa9G1vz2hAO/u83/32Cn?=
 =?Windows-1252?Q?kLlsBzuCMizmiEye+RsM9ODfUx5jjaa5B96jpvoDM3o6rT6TV0SjUVyg?=
 =?Windows-1252?Q?IkVDabOEUteUAJLdayo=3D?=
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg="sha256"; 
 boundary="_B0E2652B-B7D5-8145-82D6-EC6A23F37DDA_"
MIME-Version: 1.0
X-OriginatorOrg: starlab.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR09MB5288.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f813e7e-1ab5-4cf2-7687-08dc28db62f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 19:23:10.2667 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5e611933-986f-4838-a403-4acb432ce224
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR09MB9434
Received-SPF: pass client-ip=2a01:111:f403:2419::700;
 envelope-from=richard.schmitt@starlab.io;
 helo=GCC02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 08 Feb 2024 16:35:59 -0500
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

--_B0E2652B-B7D5-8145-82D6-EC6A23F37DDA_
Content-Type: multipart/alternative;
	boundary="_942E6F67-D651-AE47-B63A-A0A4163A4A42_"

--_942E6F67-D651-AE47-B63A-A0A4163A4A42_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

=EF=BB=BFIn an attempt to build qemu with hardened gcc compiler options, we=
 specified the -ftrapv switch rather than the -fwrapv switch. The switches =
define the behavior of integer overflows. -ftrapv causes an abort on intege=
r overflow, -fwrapv causes overflows to simply wrap without any error indic=
ation. Wrapping overflows can result in unexpected behavior and therefore, =
hardenened builds typically recommend trapping overflows.=20

The abort occurs when running the =E2=80=9Ctest-string-input-verifier=E2=80=
=9D test and begins at line 129 of the source:

v =3D visitor_input_test_init(data,=20
=E2=80=9C-9223372036854775808, 9223372036854775807=E2=80=9D);=20
check_ilist(v, expect3, ARRAY_SIZE(expect3);=20

Where expect3 is declared as:=20

int64_t expect3[] =3D { INT64_MIN, INT64_MAX };=20

The actual abort occurs in =E2=80=9Cstring-input-visitor.c=E2=80=9D line 20=
9:

*obj =3D siv->rangeNext.i64++;=20

The test, as coded, will generate an overflow. Using the -fwrapv compiler o=
ption hides the overflow.=20

My question, is it the intent of the qemu community to rely on the overflow=
 wrap behavior or should this be considered an issue and added as such in g=
itlab=E2=80=99s issue list?=20

Rich=20



--_942E6F67-D651-AE47-B63A-A0A4163A4A42_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="utf-8"

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta ht=
tp-equiv=3DContent-Type content=3D"text/html; charset=3Dutf-8"><meta name=
=3DGenerator content=3D"Microsoft Word 15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:"Aptos Display";
	panose-1:2 11 0 4 2 2 2 2 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style></head><body lang=3DEN-US link=3D"#467886" vlink=3D"#96607D" sty=
le=3D'word-wrap:break-word'><div class=3DWordSection1><p class=3DMsoNormal>=
<span style=3D'color:#212121;mso-ligatures:none'>In an attempt to build qem=
u with hardened gcc compiler options, we specified the -ftrapv switch rathe=
r than the -fwrapv switch.&nbsp; The switches define the behavior of intege=
r overflows.&nbsp; -ftrapv causes an abort on integer overflow, -fwrapv cau=
ses overflows to simply wrap without any error indication.&nbsp; Wrapping o=
verflows can result in unexpected behavior and therefore, hardenened builds=
 typically recommend trapping overflows.<o:p></o:p></span></p><p class=3DMs=
oNormal><span style=3D'color:#212121;mso-ligatures:none'>&nbsp;<o:p></o:p><=
/span></p><p class=3DMsoNormal><span style=3D'color:#212121;mso-ligatures:n=
one'>The abort occurs when running the =E2=80=9Ctest-string-input-verifier=
=E2=80=9D test and begins at line 129 of the source:<br><br></span><span st=
yle=3D'font-family:"Courier New";color:#212121;mso-ligatures:none'>v =3D vi=
sitor_input_test_init(data,</span><span style=3D'color:#212121;mso-ligature=
s:none'><o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'font-fami=
ly:"Courier New";color:#212121;mso-ligatures:none'>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =E2=80=9C-9=
223372036854775808, 9223372036854775807=E2=80=9D);</span><span style=3D'col=
or:#212121;mso-ligatures:none'><o:p></o:p></span></p><p class=3DMsoNormal><=
span style=3D'font-family:"Courier New";color:#212121;mso-ligatures:none'>c=
heck_ilist(v, expect3, ARRAY_SIZE(expect3);</span><span style=3D'color:#212=
121;mso-ligatures:none'><o:p></o:p></span></p><p class=3DMsoNormal><span st=
yle=3D'font-family:"Courier New";color:#212121;mso-ligatures:none'>&nbsp;</=
span><span style=3D'color:#212121;mso-ligatures:none'><o:p></o:p></span></p=
><p class=3DMsoNormal><span style=3D'color:#212121;mso-ligatures:none'>Wher=
e expect3 is declared as:<o:p></o:p></span></p><p class=3DMsoNormal><span s=
tyle=3D'color:#212121;mso-ligatures:none'>&nbsp;<o:p></o:p></span></p><p cl=
ass=3DMsoNormal><span style=3D'font-family:"Courier New";color:#212121;mso-=
ligatures:none'>int64_t expect3[] =3D { INT64_MIN, INT64_MAX };</span><span=
 style=3D'color:#212121;mso-ligatures:none'><o:p></o:p></span></p><p class=
=3DMsoNormal><span style=3D'font-family:"Courier New";color:#212121;mso-lig=
atures:none'>&nbsp;</span><span style=3D'color:#212121;mso-ligatures:none'>=
<o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'font-family:"Apto=
s Display",sans-serif;color:#212121;mso-ligatures:none'>The actual abort oc=
curs in =E2=80=9Cstring-input-visitor.c=E2=80=9D line 209:<br><br></span><s=
pan style=3D'font-family:"Courier New";color:#212121;mso-ligatures:none'>*o=
bj =3D siv-&gt;rangeNext.i64++;</span><span style=3D'color:#212121;mso-liga=
tures:none'><o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'font-=
family:"Courier New";color:#212121;mso-ligatures:none'>&nbsp;</span><span s=
tyle=3D'color:#212121;mso-ligatures:none'><o:p></o:p></span></p><p class=3D=
MsoNormal><span style=3D'color:#212121;mso-ligatures:none'>The test, as cod=
ed, will generate an overflow.&nbsp; Using the -fwrapv compiler option hide=
s the overflow.&nbsp;&nbsp;<o:p></o:p></span></p><p class=3DMsoNormal><span=
 style=3D'color:#212121;mso-ligatures:none'>&nbsp;<o:p></o:p></span></p><p =
class=3DMsoNormal><span style=3D'color:#212121;mso-ligatures:none'>My quest=
ion, is it the intent of the qemu community to rely on the overflow wrap be=
havior or should this be considered an issue and added as such in gitlab=E2=
=80=99s issue list?<o:p></o:p></span></p><p class=3DMsoNormal><span style=
=3D'color:#212121;mso-ligatures:none'>&nbsp;<o:p></o:p></span></p><p class=
=3DMsoNormal><span style=3D'color:#212121;mso-ligatures:none'>Rich<o:p></o:=
p></span></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>=

--_942E6F67-D651-AE47-B63A-A0A4163A4A42_--

--_B0E2652B-B7D5-8145-82D6-EC6A23F37DDA_
Content-type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCHY0w
ggXZMIIEwaADAgECAhB/qmJGB1HF4pbsnuKam6xfMA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDQyNTAwMDAwMFoXDTI1MDQyNDIzNTk1
OVowgeIxCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJEQzETMBEGA1UEBxMKV2FzaGluZ3RvbjEWMBQG
A1UEChMNU3RhciBMYWIgQ29ycDEzMDEGA1UECxMqSXNzdWVkIHRocm91Z2ggU3RhciBMYWIgQ29y
cCBFLVBLSSBNYW5hZ2VyMR8wHQYDVQQLExZDb3Jwb3JhdGUgU2VjdXJlIEVtYWlsMRgwFgYDVQQD
Ew9SaWNoYXJkIFNjaG1pdHQxKTAnBgkqhkiG9w0BCQEWGnJpY2hhcmQuc2NobWl0dEBzdGFybGFi
LmlvMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArWlFtt/7FjSKMLOD5O1o8zUgocZh
usIUFbU/nOeIKUeXalSb/KY2hji6bvj6pJym1OeGqB91Ddkn8khYOXgr3SKuGVng8pDbao8qPwQj
JcT7ILWkdzdNwuSP7IdOtZJ86s+a913l08I0MgDVN03WfeANHwECGrWrLyzbugbkYxvev0ZNq5mI
EtktjvK6ubfSlJjShPpTHeZdqs5YF71gGHN+aCdtsarijEXkC++vO6KS6oX170Kl6t3FF010JGaY
W/IHTykSsiRgKFnteU7RA5N3pkv42uzNUlBO+vw23Cgx/kZYc/mkOqrWA+AYX6fIEnHTyGx051DV
ePo2whhrawIDAQABo4IB0zCCAc8wHwYDVR0jBBgwFoAUCcDy/AvalNtf/ivfqJlCz8ngrQAwHQYD
VR0OBBYEFHsz/60gnXpOm12IX7VluPJ2C0Z4MA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAA
MB0GA1UdJQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjBABgNVHSAEOTA3MDUGDCsGAQQBsjEBAgEB
ATAlMCMGCCsGAQUFBwIBFhdodHRwczovL3NlY3RpZ28uY29tL0NQUzBaBgNVHR8EUzBRME+gTaBL
hklodHRwOi8vY3JsLnNlY3RpZ28uY29tL1NlY3RpZ29SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFu
ZFNlY3VyZUVtYWlsQ0EuY3JsMIGKBggrBgEFBQcBAQR+MHwwVQYIKwYBBQUHMAKGSWh0dHA6Ly9j
cnQuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1h
aWxDQS5jcnQwIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3NwLnNlY3RpZ28uY29tMCUGA1UdEQQeMByB
GnJpY2hhcmQuc2NobWl0dEBzdGFybGFiLmlvMA0GCSqGSIb3DQEBCwUAA4IBAQAcupFauIxv6nY3
dIME+z350mRdWuKJ10Q97fgPlhBKGLHgXFGpzEZi1GzS8pxNqz3PuCGRnpWmTckgriV94SFVyQv2
4IacBW1kpyr0zuDnJ0raHOXT+17aBxMvZdD/pRBVkO1b7tjZyDephr7OMMDS/HgT4f1XvWClQ6ch
mjoYjeM0SyCgVj4tU8dFOCnoam0I/6n9oF5Aa9NRHo2mDZ9ujT7Rj5DtYjMwmid+LYj2EIk6wwtA
sbFffFSbc0V8z/+BOtSgx43Zso1mAFO4oO9zcj0zHbQjfX3p/4E7sI0voZDGwhGvV/PdtcB2syY/
wDXKz2V+QLVtIrllKWXKDSrAMIIF2TCCBMGgAwIBAgIQf6piRgdRxeKW7J7impusXzANBgkqhkiG
9w0BAQsFADCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4G
A1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTAeFw0yMjA0MjUw
MDAwMDBaFw0yNTA0MjQyMzU5NTlaMIHiMQswCQYDVQQGEwJVUzELMAkGA1UECBMCREMxEzARBgNV
BAcTCldhc2hpbmd0b24xFjAUBgNVBAoTDVN0YXIgTGFiIENvcnAxMzAxBgNVBAsTKklzc3VlZCB0
aHJvdWdoIFN0YXIgTGFiIENvcnAgRS1QS0kgTWFuYWdlcjEfMB0GA1UECxMWQ29ycG9yYXRlIFNl
Y3VyZSBFbWFpbDEYMBYGA1UEAxMPUmljaGFyZCBTY2htaXR0MSkwJwYJKoZIhvcNAQkBFhpyaWNo
YXJkLnNjaG1pdHRAc3RhcmxhYi5pbzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAK1p
Rbbf+xY0ijCzg+TtaPM1IKHGYbrCFBW1P5zniClHl2pUm/ymNoY4um74+qScptTnhqgfdQ3ZJ/JI
WDl4K90irhlZ4PKQ22qPKj8EIyXE+yC1pHc3TcLkj+yHTrWSfOrPmvdd5dPCNDIA1TdN1n3gDR8B
Ahq1qy8s27oG5GMb3r9GTauZiBLZLY7yurm30pSY0oT6Ux3mXarOWBe9YBhzfmgnbbGq4oxF5Avv
rzuikuqF9e9CperdxRdNdCRmmFvyB08pErIkYChZ7XlO0QOTd6ZL+NrszVJQTvr8NtwoMf5GWHP5
pDqq1gPgGF+nyBJx08hsdOdQ1Xj6NsIYa2sCAwEAAaOCAdMwggHPMB8GA1UdIwQYMBaAFAnA8vwL
2pTbX/4r36iZQs/J4K0AMB0GA1UdDgQWBBR7M/+tIJ16TptdiF+1ZbjydgtGeDAOBgNVHQ8BAf8E
BAMCBaAwDAYDVR0TAQH/BAIwADAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwQAYDVR0g
BDkwNzA1BgwrBgEEAbIxAQIBAQEwJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdvLmNvbS9D
UFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2NybC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xp
ZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCBigYIKwYBBQUHAQEEfjB8MFUG
CCsGAQUFBzAChklodHRwOi8vY3J0LnNlY3RpZ28uY29tL1NlY3RpZ29SU0FDbGllbnRBdXRoZW50
aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zZWN0
aWdvLmNvbTAlBgNVHREEHjAcgRpyaWNoYXJkLnNjaG1pdHRAc3RhcmxhYi5pbzANBgkqhkiG9w0B
AQsFAAOCAQEAHLqRWriMb+p2N3SDBPs9+dJkXVriiddEPe34D5YQShix4FxRqcxGYtRs0vKcTas9
z7ghkZ6Vpk3JIK4lfeEhVckL9uCGnAVtZKcq9M7g5ydK2hzl0/te2gcTL2XQ/6UQVZDtW+7Y2cg3
qYa+zjDA0vx4E+H9V71gpUOnIZo6GI3jNEsgoFY+LVPHRTgp6GptCP+p/aBeQGvTUR6Npg2fbo0+
0Y+Q7WIzMJonfi2I9hCJOsMLQLGxX3xUm3NFfM//gTrUoMeN2bKNZgBTuKDvc3I9Mx20I3196f+B
O7CNL6GQxsIRr1fz3bXAdrMmP8A1ys9lfkC1bSK5ZSllyg0qwDCCBdkwggTBoAMCAQICEH+qYkYH
UcXiluye4pqbrF8wDQYJKoZIhvcNAQELBQAwgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVh
dGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRl
ZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUg
RW1haWwgQ0EwHhcNMjIwNDI1MDAwMDAwWhcNMjUwNDI0MjM1OTU5WjCB4jELMAkGA1UEBhMCVVMx
CzAJBgNVBAgTAkRDMRMwEQYDVQQHEwpXYXNoaW5ndG9uMRYwFAYDVQQKEw1TdGFyIExhYiBDb3Jw
MTMwMQYDVQQLEypJc3N1ZWQgdGhyb3VnaCBTdGFyIExhYiBDb3JwIEUtUEtJIE1hbmFnZXIxHzAd
BgNVBAsTFkNvcnBvcmF0ZSBTZWN1cmUgRW1haWwxGDAWBgNVBAMTD1JpY2hhcmQgU2NobWl0dDEp
MCcGCSqGSIb3DQEJARYacmljaGFyZC5zY2htaXR0QHN0YXJsYWIuaW8wggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQCtaUW23/sWNIows4Pk7WjzNSChxmG6whQVtT+c54gpR5dqVJv8pjaG
OLpu+PqknKbU54aoH3UN2SfySFg5eCvdIq4ZWeDykNtqjyo/BCMlxPsgtaR3N03C5I/sh061knzq
z5r3XeXTwjQyANU3TdZ94A0fAQIatasvLNu6BuRjG96/Rk2rmYgS2S2O8rq5t9KUmNKE+lMd5l2q
zlgXvWAYc35oJ22xquKMReQL7687opLqhfXvQqXq3cUXTXQkZphb8gdPKRKyJGAoWe15TtEDk3em
S/ja7M1SUE76/DbcKDH+Rlhz+aQ6qtYD4Bhfp8gScdPIbHTnUNV4+jbCGGtrAgMBAAGjggHTMIIB
zzAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUezP/rSCdek6bXYhf
tWW48nYLRngwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUH
AwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0
dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGln
by5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmww
gYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0
aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcw
AYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wJQYDVR0RBB4wHIEacmljaGFyZC5zY2htaXR0QHN0
YXJsYWIuaW8wDQYJKoZIhvcNAQELBQADggEBABy6kVq4jG/qdjd0gwT7PfnSZF1a4onXRD3t+A+W
EEoYseBcUanMRmLUbNLynE2rPc+4IZGelaZNySCuJX3hIVXJC/bghpwFbWSnKvTO4OcnStoc5dP7
XtoHEy9l0P+lEFWQ7Vvu2NnIN6mGvs4wwNL8eBPh/Ve9YKVDpyGaOhiN4zRLIKBWPi1Tx0U4Kehq
bQj/qf2gXkBr01EejaYNn26NPtGPkO1iMzCaJ34tiPYQiTrDC0CxsV98VJtzRXzP/4E61KDHjdmy
jWYAU7ig73NyPTMdtCN9fen/gTuwjS+hkMbCEa9X8921wHazJj/ANcrPZX5AtW0iuWUpZcoNKsAw
ggXeMIIDxqADAgECAhAB/W0w/KPKUagbvGQONQMtMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xMDAyMDEwMDAwMDBaFw0zODAxMTgyMzU5NTlaMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAIASZRc2DsPbCLPQ
rFcNdu3NJ9NMrVCDYeKqIE0JLWQJ3M6Jn8w9qez2z8Hc8dOx1ns3KBErR9o5xrw6GbRfpr19naNj
QrZ28qk7K5H44m/Q7BYgkAk+4uh0yRi0kdRiZNt/owbxiBhqkCI8vP4T8IcUe/bkH47U5FHGEWdG
CFHLhhRUP7wz/n5snP8WnRi9UY41pqdmyHJn2yFmsdSbeAPAUDrozPDcvJ5M/q8FljUfV1q3/875
PbcstvZU3cjnEjpNrkyKt1yatLcgPcp/IjSufjtoZgFE5wFORlObM2D3lL5TN5BzQ/Myw1Pv26r+
dE5px2uMYJPexMcM3+EyrsyTO1F4lWeL7j1W/gzQaQ8bD/MlJmszbfduR/pzQ+V+DqVmsSl8MoRj
VYnEDcGTVDAZE6zTfTen6106bDVc20HXEtqpSQvf2ICKCZNijrVmzyWIzYS4sT+kOQ/ZAp7rEkyV
fPNrBaleFoPMuGfi6BOdzFuC00yz7Vv/3uVzrCM7LQC/NVV0CUnYSVgaf5I25lGSDvMmfRxNF7zJ
7EMm0L9BX0CpRET0medXh55QH1dUqD79dGMvsVBlCeZYQi5DGky08CVHWfoEHpPUJkZKUIGy3r54
t/xnFeHJV4QeD2PW6WK61l9VLupcxigIBCU5uA4rqfJMlxwHPw1S9e3vL4IPAgMBAAGjQjBAMB0G
A1UdDgQWBBRTeb9aqitKz1SA4dibwJ3ysgNmyzAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/BAUw
AwEB/zANBgkqhkiG9w0BAQwFAAOCAgEAXNR8Dc/3AX1BmWUMc8VSn8v4z5kGfxvaQxWfngJVV5YU
8VI8J4eUKO0fOgE3onb8U1DAhJvGa066jCFPoo5VYpHzaRXYvIjjxKoL/e+o6UtVKgYgbVV4KRnu
XzBcSyQRVf8kmm5eKivuC02ff/cBOJQUlUMHCftgqe4cqxKMoJpep5hqWW2LPwj7yNFFrxgVZJAS
D3MoLsXiJE78WOzw9EX+IrPrL47S2UVhBcGXb6h2co+LjDavvw0FznGN5qZvH2ymcWLF2NCDcgzx
ZxGJDJwTTHI037zVcd+qcd3huWyMPBJdZdq9VxK2Q2v/5d5NZhFRz5mu7Be26HGRjN5J/t01caIV
J5Qcz2HjJrtvo2clIV3m3R0LLmgbO4Kv7INnhdSYUXSxuZmAif9/eBlceUpgLpJArkw3KizJx2LI
Dl33NlvK4CUlAbTdGgecdwA/0NzV7D3U+rs/zIXWb3+pLd+5Avf1l5q1NdrDZ7CHSqkoniOO/1wn
a+GwT/MH7gAu1FmHy1JBler0R9fuZEFVfI1ZApXdYp3Cue5aKHSEpZu3kMcMB9/1iTZ0MtYowbCw
C+CcTMMc1vzjabVHRoEvooKr02NEcMSN/y0zuq2Pe7VwiK4+Gc9AKNj8yJC7XZki9VLmWMUfiDFD
7ogd18aOPENqHacY3n09FvFi+cqQqP0wggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0G
CSqGSIb3DQEBDAUAMIGIMQswCQYDVQQGEwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UE
BxMLSmVyc2V5IENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMl
VVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0z
MDEyMzEyMzU5NTlaMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjAN
BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+Jhwp
KirSzZxQgT9tlC7zl6hn1fXjSo5MqXUfItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX
2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeWQcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabP
i2503nn/ITX5e8WfPnGw4VuZ79Khj1YBrf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5
h36bBJMxqdHLpdwIUkTqT8se3ed0PewDch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwID
AQABo4IBZDCCAWAwHwYDVR0jBBgwFoAUU3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA
8vwL2pTbX/4r36iZQs/J4K0AMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0G
A1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkw
RzBFoEOgQYY/aHR0cDovL2NybC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRp
b25BdXRob3JpdHkuY3JsMHYGCCsGAQUFBwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51
c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJTQUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRw
Oi8vb2NzcC51c2VydHJ1c3QuY29tMA0GCSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFo
jADdF9d6HBA4kMjjsb0XMZHztuOCtKF+xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou7
4TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx
4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA
6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiX
u09sMAviM11Q0DuMZ5760CdO2VnpsXP4KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dk
iPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90
SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQOZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6
JzPFf9pLkAFFWs1QNyN++niFhsM47qodx/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ
0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i5ZgtwCLXgAIe5W8mybM2JzGCAwUwggMBAgEBMIGrMIGW
MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxm
b3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVu
dCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhB/qmJGB1HF4pbsnuKam6xfMA0G
CWCGSAFlAwQCAQUAoIIBKjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEP
Fw0yNDAyMDgxOTIzMDlaMC8GCSqGSIb3DQEJBDEiBCDZR3osuWofaEdvp9l84Gi6V9W7wZTRilgu
t3QwaVYzkTCBvgYLKoZIhvcNAQkQAgsxga6ggaswgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGlt
aXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1
cmUgRW1haWwgQ0ECEH+qYkYHUcXiluye4pqbrF8wDQYJKoZIhvcNAQEBBQAEggEAkTSbF5ZEFci4
RQuCaDmV9OIohoyJT8q0R3mxd62/rmL8ZEhSbZ8tM5KbcHxbgbBRs6EsAEig9y9C24Ld9+gFLNUN
BQ1Gqa3631xE33lX1e7wG66UB2MNzvVPM+T99Xpm9mNrx6vSN7FhFDKZS8PjGKVeSIrmVTbdPaQM
Xq0XUiP35UlHkpBgrgK7BTkGiKISyJAXwEU3uuaa4CJ1QaFwlWdKA9oMhFf7ck80C0AyHq9Y4cPb
bKWTFXuDFnnGpOvtRFj98G/EwVa+IBQyn6MHBzeTJxjrQRWowIAUyO8QCvl3jiNmxnrkh9wNNdJu
NiFbXP+FNiYgi/iNUjtyBuXDAQAAAAAAAA==

--_B0E2652B-B7D5-8145-82D6-EC6A23F37DDA_--

