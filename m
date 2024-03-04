Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED66C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 06:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh22q-00021v-8h; Mon, 04 Mar 2024 01:43:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wucf@cn.ibm.com>) id 1rh22n-00021U-Tr
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:43:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wucf@cn.ibm.com>) id 1rh22l-0001jb-Mt
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:43:25 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 4246RXsS007228
 for <qemu-devel@nongnu.org>; Mon, 4 Mar 2024 06:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : content-type : mime-version; s=pp1;
 bh=cXVpQTaVDl+yLsrqzmYb7eacOAHM9t0py6jrtqEYxMQ=;
 b=njh4fQpv1KCdjQFfdXihtDNODPKU0pqhXT9fnyCPJikKedXA5uMcvvEp0t4ZhOOfy7jw
 fZDtIGUjkWkfbjDQMhgt/QwBLhbz/UeCQEPfW3Hc7Anrn1w2pJy44cbGPY6BmEPzdMmN
 wUriY6JDNmXefMJJt3iFVaqJhi92w705edrWjbgKu7yJV3cg4PjBtLl4Lowfj3mhOvG3
 UCAlxhqD6E8R7UVA1DcZ1380/MFhqfdsFd+rpXrEX4gzq4307GVLuo2PVTAL/ihOJo3f
 EcnRCNG4dyH8ljsJBePl1yIDaq6hZpyd7M/1LcIim69KAc909mk4xiWEj9h+VTOQ6ok9 Qw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wn921rcvs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 06:43:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wge4CBhNdMBq7WmkEUighfwrFesNgIWavU3siGPAbqHGdOcikQE9n2T22JzOmO2OZuaKf9yksiKrnThZXyPQOi4US5fbW1KzeKIO4YYVoPYa4yZvkP5b5F5Ca69SLUKhK5CHoR+pL2OFv3G2yfDM89XRLNPG3H8Y2tKvJBrJbt3Pi8tQE7FhlhXuHl+xPyD0dfXiNil6lNbab7aWV/hYLSKqaffn/Snx+WOhGFIGTWg8L1Zblzxyu4SJ8DTJZtXAOJ5n7dRgr/shX0YfrO1naZ/w8232W/Ak0+0W4go/do6Ae5+ASEzBS5tjir2OT9BCD2ByCnIcDsRC3ImUILYWIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXVpQTaVDl+yLsrqzmYb7eacOAHM9t0py6jrtqEYxMQ=;
 b=OU54RG16bP9CzqewBmr9e7c224dLyjzhsApapTab5qbmAAAkHPHfsx5ZLoeFrjtlqBnWL+CJT/AoEB2BLTTOaPmQUyyo+bsxtNNnwVNbbDuQdjCaJtdkA2URGZTME20DBo4VHnuYtyCFQs6opzXeaKvsjH81JEbgryyni+2fmus4IDXZuLesBl3LOXJtq1fmsJ5q9+k358oZ2k4tPgxIRNgu8AOjGfo1Kv/FBz/Y36LckpcVVAoe6vwZq7kfQT/q1vHj2sjTuzJLf5MD36/R22cGkhbsQv2of9knHnc4ipTqSqX/XVaKAh5LomfhX2CF0IvSaLg3PHdv5QVwet144A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cn.ibm.com; dmarc=pass action=none header.from=cn.ibm.com;
 dkim=pass header.d=cn.ibm.com; arc=none
Received: from PH7PR15MB6503.namprd15.prod.outlook.com (2603:10b6:510:304::5)
 by SA0PR15MB3821.namprd15.prod.outlook.com (2603:10b6:806:8e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 06:43:19 +0000
Received: from PH7PR15MB6503.namprd15.prod.outlook.com
 ([fe80::f3d3:ce2a:4ed3:3ea9]) by PH7PR15MB6503.namprd15.prod.outlook.com
 ([fe80::f3d3:ce2a:4ed3:3ea9%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 06:43:19 +0000
From: Chun Feng Wu <wucf@cn.ibm.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Does "-object" support structured options now?
Thread-Topic: Does "-object" support structured options now?
Thread-Index: AQHabf2hpXTetJLRaU+zSXGLjQwKCQ==
Date: Mon, 4 Mar 2024 06:43:19 +0000
Message-ID: <PH7PR15MB6503236A69BD173E62FC6791F7232@PH7PR15MB6503.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR15MB6503:EE_|SA0PR15MB3821:EE_
x-ms-office365-filtering-correlation-id: ddaa3b44-ed7a-40d2-29cc-08dc3c1660d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YD7AKsHLfGDCO1wUud4MreXe2qOviTjPRHugWjM4ieuklUF2fZDtuMGtmYKGE21XPprHYiKUNGbZAJhyKNbOziKXnM1AjrvaNGWKpaBRlvxJhglbUX8M+7bs1lHItxuf9j+gj2dsj+fRxjXykUEQ3evg3wZvBnPmL/dR2ClFWOJ9Klmezje2qmvcm6GfoZAKCR3UHqXpY41roqum4klUumsPkQemZloXTkkTyBduXSJKCOmUlBmcev5ujG128121DuMKEynDeB9GMldz7gNqs0Dg2eNf7GA2fJX5I4mIAAHQVHpufFpjwuD06pZnbm3kgJhoC+x7C3G9azw172OqcssZjmiHfix4qc3Jejp6jYNGWeYWO0iq0H2V4+Mzj3f2WR1tdnHf1q2IPEucJNZ9RHDMix2PyK3UkKc6AOB1S9kIgVlKZVXIb1s7MHCGEK5Eb96My2lh2EgJxXHuA/xVGC9hOx0rPZkOPTnXARHNqz2/2LVL9P4wCbYKuns0lBa818UHtb8GNvSv8KMaY1rhs2u7q8To8GreBvTJrWtiSVtesrpLD2cc08h0WxmzpUSS8JEWv1G1pHBwxtPY1D9+Z56QUcU5zldaj1a/nwj670O7wQI0qJ0Zvx4Ut22RGoY6/fMdxZCPFZffGkcKqA6HwHnOxWjF5TRnpNkUqLRUIes=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR15MB6503.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?+BbOixCqfsdGxy+gnUjpW6iEdz9tUoITbiLXUKh6V3l1nzou95Zqxypi?=
 =?Windows-1252?Q?QjdC3G9yoNuDucF8oPB2Mq9kFTNJHzcCJQzLxxM1LP/XbWwAh+cHvhjp?=
 =?Windows-1252?Q?iUgBcikffxOqkNGZ5Jya0zoOLwkzGZLPQC2CUE+KDjG+RMbf8CI7SLzG?=
 =?Windows-1252?Q?g8sMbxn56CUBW2CKRfSQlp1LCfbQj3f4Sed+jBx4sxIlby0q3IO9LvV3?=
 =?Windows-1252?Q?GOjczUJHGuosLHk3UzKGyPp3D0O9zrwfnbR4S2HnenrLHcdmc/bjgyej?=
 =?Windows-1252?Q?8UzCRi+0pkCEGmvMkAKhTC0o+eineHZe7mgvF5jlYljzwOelLQ/NTRyl?=
 =?Windows-1252?Q?Fn26huCKfYa2OiHeroAiphEtB7KoZ7HmcS8A3uKWqLDtJW8dqeVjq5GK?=
 =?Windows-1252?Q?mLcswOZ41qtCsYdzp16zV9Uve25d1xBUugrFEu6/oVxyVrguyqjupAbL?=
 =?Windows-1252?Q?p90lu9aSl9SfeapOCQdg/LwwuTelzne5Wox1x1M3UIrJFgOzV7bkvbxf?=
 =?Windows-1252?Q?VYZNBerW9O/DhSjR5diYD8juiLyY8edJdQacSOMETHsIkR5gOsemvK5H?=
 =?Windows-1252?Q?oFPavxuCe7iUhN/aT0dnx/e7DRH/xprD8xosUIlBfosBvLvdBxOzfpdk?=
 =?Windows-1252?Q?BOLpppSu27DYWj6ZoWYksevZWatIj4qK84Q1UfI8SJzUBwN89tBIpJEu?=
 =?Windows-1252?Q?hr61laR774YOUbSyPxwQylDug646HMDMvATdRXcsuVhnUL/uroFUeJ6M?=
 =?Windows-1252?Q?lWuQTiAoqf8t4zTJsSTlj+sioeUvs2XSZhNprdGxsIWAr9xII81O1ayj?=
 =?Windows-1252?Q?pEJ0Xgit9X6Ix4W4bl7ITvijGjABA88rmzCv+5DmryOKTfCGtv9P9DSm?=
 =?Windows-1252?Q?NB+RCAVJQZI3aiJC0qAhfv26CyTIW4/59/D5aZ/pjcwOfpsADDYps/Sz?=
 =?Windows-1252?Q?LwXNMkpW7oLVAdY690beSexGa8cW9uPsj91Xq2/CmwFdPaWS/NU1Kopv?=
 =?Windows-1252?Q?GcV1+ceMu/7DlVdfqO7bfqEu8dtVUN8AhlsdQ7ot+b3BtZC7bhjkoeSK?=
 =?Windows-1252?Q?Ac+vMPA2SUP8jTvQH3WTrlfmh3rvln9GMBG9UgF0eE3h2uVr1afK2BlI?=
 =?Windows-1252?Q?Tyd/RaAH6LanPHz92KnlizIWvzsQXL+fTxrjkpAtonI6ow/Km4sjx+X8?=
 =?Windows-1252?Q?CSzd/7PB8MKdDbQltQLwdPXLx1X1NOtbGhQ9dXJ+B3iFtOKWlSayJDJt?=
 =?Windows-1252?Q?ZelA/9WCuzG2CQ/ZYr3w1Ur9pgq2EqZ0XoKHbSue+CgGKXASMuiI1QfM?=
 =?Windows-1252?Q?28n0ZvZ5H/G+/y6jtnu24c7BbO0F/CxZ6G+kFKKbtstVw9+8gwQi9xqv?=
 =?Windows-1252?Q?R3zyksXVsrs/NAC2Jv5+UM6fSmMo7lPoWdiQ24fEhW6OD9AOHjDmIWJr?=
 =?Windows-1252?Q?FUqoBpyrV0QMhXpE5j1FNIYFCLJE3qZZlG+uAYADAYSfKL/HIxnJWn6j?=
 =?Windows-1252?Q?KkYnSG1EF+x5yTQoss1y8+jSqDcnMLccV60EEKVlQ+L4s47BmIRsYA3k?=
 =?Windows-1252?Q?Z+7E8rvtVd6P30HmPCV3me/19HUPbosZfWFebyxytVn0mFF3DvOOf6T/?=
 =?Windows-1252?Q?bz6Cs9Ag4UpNWjJ/UiN3ms4gsVBV4QUH++wDDhhgUVnETqeNZ3/hgOIS?=
 =?Windows-1252?Q?3HOTfJmvrj5B50xjakmMQ8D5y1tlnwuB?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR15MB6503236A69BD173E62FC6791F7232PH7PR15MB6503namp_"
X-OriginatorOrg: CN.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR15MB6503.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddaa3b44-ed7a-40d2-29cc-08dc3c1660d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 06:43:19.0718 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KTmR2iPZIyYZJV4Cvba0fwIS6h8KEq9a4C0FSweHzVOvO5LnO11ToGPU+9H8bDmB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3821
X-Proofpoint-GUID: cFAcOkVsGAKhPARnfVsGnmSUY8rj-TOL
X-Proofpoint-ORIG-GUID: cFAcOkVsGAKhPARnfVsGnmSUY8rj-TOL
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_02,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=866 malwarescore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040049
Received-SPF: pass client-ip=148.163.158.5; envelope-from=wucf@cn.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--_000_PH7PR15MB6503236A69BD173E62FC6791F7232PH7PR15MB6503namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

I noticed that throttle-group can be created with =93-object=94, however, p=
er qemu doc(https://github.com/qemu/qemu/blob/master/docs/throttle.txt), =
=93-object=94 doesn=92t support structured options at that moment:

=93
A throttle-group can also be created with the -object command line
option but at the moment there is no way to pass a 'limits' parameter
that contains a ThrottleLimits structure. The solution is to set the
individual values directly, like in this example:

   -object throttle-group,id=3Dgroup0,x-iops-total=3D1000,x-bps-write=3D209=
7152

Note however that this is not a stable API (hence the 'x-' prefixes) and
will disappear when -object gains support for structured options and
enables use of 'limits'.
=93

Does anybody know if the latest qemu code still lacks of such support(struc=
tured options for -object)? If so, is there any plan to support it(instead =
of non-stable API)?


--
Thanks and Regards,

Wu



--_000_PH7PR15MB6503236A69BD173E62FC6791F7232PH7PR15MB6503namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Helv;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-CN" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Hi,<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">I no=
ticed that throttle-group can be created with =93-object=94, however, per q=
emu doc(<a href=3D"https://github.com/qemu/qemu/blob/master/docs/throttle.t=
xt">https://github.com/qemu/qemu/blob/master/docs/throttle.txt</a>),
 =93-object=94 doesn=92t support structured options at that moment:<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><br>
=93<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">A th=
rottle-group can also be created with the -object command line<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">opti=
on but at the moment there is no way to pass a 'limits' parameter<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">that=
 contains a ThrottleLimits structure. The solution is to set the<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">indi=
vidual values directly, like in this example:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbs=
p;&nbsp; -object throttle-group,id=3Dgroup0,x-iops-total=3D1000,x-bps-write=
=3D2097152<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Note=
 however that this is not a stable API (hence the 'x-' prefixes) and<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">will=
 disappear when -object gains support for structured options and<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">enab=
les use of 'limits'.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">=93<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Does=
 anybody know if the latest qemu code still lacks of such support(structure=
d options for -object)? If so, is there any plan to support it(instead of n=
on-stable API)?
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-ligatures:none">--&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-ligatures:none">Thanks and Regards,<o:p></o:p></=
span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:Helv;color:black;mso-ligatures:none"><=
o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:Helv;color:black;mso-ligatures:none">Wu</span><o:p></=
o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_PH7PR15MB6503236A69BD173E62FC6791F7232PH7PR15MB6503namp_--

