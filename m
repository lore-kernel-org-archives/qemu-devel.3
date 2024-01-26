Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F00C47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 15:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTOKF-0006mL-Rd; Fri, 26 Jan 2024 10:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rTOKE-0006kp-FQ
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 10:41:02 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rTOKC-0008O9-LG
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 10:41:02 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40QEMbEK021395; Fri, 26 Jan 2024 15:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:content-type:mime-version; s=
 qcppdkim1; bh=H3hc69dzb4sCahEB0EQZh+l/wxVusNl/x8U1ufetPLs=; b=Mm
 eaxtw3A2GLDux+uAiZBUFfJusWPIeCd1iLDF8cAV7xuHpatT4Z4Mq0P8W6kRfUCp
 XRMrQvRt+tjjNcr0QbHLGaZpkBZKLUH+9eKMhIRDP99+etyknGtjP1q1/4kBuIRP
 63fnjtUo1XP+UQ53Vn35Eh0k780C++x+KefC8WWyKeKT+QcJinWTBoG/QFuB/EUQ
 gOltKF8bR3u+F0psIQcavWTBiS4QKnTqSAyWJtF5nGRzUykvHV0y4/PtmzsDdP5H
 Jbt7B0qkWWsokKAyfVpBGItpu771t+SM84Urp+bc0W0m/5NjVxQIt3c2GiJ3zgBI
 gKJUnR4B/Lx4DrVpSqPA==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv1q59r76-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jan 2024 15:40:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNKro7ig7sXjTHNJnSyUN+9mOyMJUaocNwvCZEjcwPpCiJO9cugm1GHndBm9UP7yM2BmRJnBHNuafhUeYyEwIrkVYqVpYbVpOxd8uc550wLvNg6U1lp4oDWMCPfmsuj4DEMqriORI7GtbGJd3Mgw9jyOzB1rl5lYwwrDK3ZdNgr5gHqV01QRLnJm14fPb1bS7mqO20ts+3ZJJEPymK0W+4HsiEjxXSGif6eUJh2UK4J0A1EE7XSQvK5H41uIQ2Vsp0dwIS6QTc0pYUZBR21JCvsU6t35j0FZ3Oz+/ghmh4h5FIuHnsyH25byaZgn2YLZGF21Hj1BlR4byf1O0TnCVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3hc69dzb4sCahEB0EQZh+l/wxVusNl/x8U1ufetPLs=;
 b=RvBA5nItCdf9iemRTFSCA16n4iOXR2JETr3/1TLHD030b6DrbYcrjacU79J8GXM9Vda4PCoBxcWL5p7PQJyEKsgniPSDHiOfN5RH3ibuko8F0iKHGtYixffI9209HaWDYS4ijEc1koy5Z/3mDJlTs62xuZldSMO//BjGwIysJLpSWDEoaB3KuxSHubDn504oXH0KxiaLnHZPOiqxaLh+b5NwNw8YyUkmpatOw8ks535w7jv7ya5ZGUO4a5JBFVrJdJ7LMPK0OlbM/eJa5pkn3LAETzRKqIE2p8JmUp/sEzioqUHBHriHHVLI2bbzc9L7EUcoRlWfjlZ4vYDp1IPctA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 (2603:10b6:610:1c2::10) by BL3PR02MB9010.namprd02.prod.outlook.com
 (2603:10b6:208:3b9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 15:40:54 +0000
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1e37:59f7:9ae:2058]) by CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1e37:59f7:9ae:2058%6]) with mapi id 15.20.7228.026; Fri, 26 Jan 2024
 15:40:54 +0000
From: Brian Cain <bcain@quicinc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
Subject: KVM Forum 2024?
Thread-Topic: KVM Forum 2024?
Thread-Index: AdpQbaL6t0ro3+dOQmOR3FhJXVMcgw==
Date: Fri, 26 Jan 2024 15:40:54 +0000
Message-ID: <CH3PR02MB10247209DBB833215A21A606CB8792@CH3PR02MB10247.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR02MB10247:EE_|BL3PR02MB9010:EE_
x-ms-office365-filtering-correlation-id: 2379f59a-670b-4281-9e8c-08dc1e852ebe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uu+CbgB5k0lobW5W3UvWTNiYGfHC13Y4wXTAmTm/LGpTa4UCR/OpgVsGSCFkI2ux+IV6dLcEFky8f80n2n5P6zzQYJuXRyweavZGiFewDrtbX/ad4NAfTgtD3whar9zzxt5g/U9QhejCT5MpaLEp4h3N5pnhpnF9yXhnBIm0g0/Xrr0fdRTcpYTWKkB4yMeDnOofRZYXLyMZsC73t/Bi65CNqHb6z94D1CVN8zsn0qEIOJxhNljbvsg0jwhhBRbN8ZG24WU42tq9r4t0NXR+Cd9K/HJAlp/0pnWXyOyGdoYCwOhupzanwK+uNCabif6oeoa34B8QFojQBQI6JDVa9iNCG/meKDD7fLiBYGs0aUgI+OGlLDMn2myeafdgOo4Px/2kvGVxIgxfuM75FvVeM7jqWbBSS778LU5t6r+ZMJVce21Oxk4Tm240vsdGwDoUarbdfRs40K2U322u3xxYcCN/wABDFUxog7/KO0Ow2UoHWoxWYU0gRXvoORhv02F+KEBMce09ycbI6+j0919kPXBO92VnvCGTccoMFjDspafsYNeFCXBSUvrvalcSjPmJ2EYwP84iEGlZhmJFZ31ZEiTcQi+mrGG6LQIMoG5KxlM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR02MB10247.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(366004)(39860400002)(396003)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(66946007)(76116006)(66556008)(66476007)(316002)(6916009)(64756008)(66446008)(9686003)(71200400001)(41300700001)(478600001)(26005)(558084003)(33656002)(966005)(83380400001)(6506007)(122000001)(38100700002)(166002)(86362001)(7696005)(38070700009)(4326008)(7116003)(55016003)(2906002)(5660300002)(52536014)(8936002)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S2FF/ryomZdkgspsPpwrATnP783mvzisyzmwsLx7LEBWY1JWhpTCowU/qoof?=
 =?us-ascii?Q?ong2fSXETFnM4EXRWxUzi3RBzYsISETXI9mGS/M167nyUSTtuO6SZTX0BAHb?=
 =?us-ascii?Q?bJH54peYjMCuHp2PzFIGe8x5HaAiwy/lvH6UjkeKh6E6k+xoOAnNEdRQHl2s?=
 =?us-ascii?Q?p3+S/HAPC/ox1cvflp7267FvmgZE7lhMPspmcN//ud2BfjT0VSQhn8q7fm6n?=
 =?us-ascii?Q?wArlvIdqfWWv7fpBN1r8Gjt2uva0l2RaZi14giDI/B9Q9Ivnh+KTa/DWAEcD?=
 =?us-ascii?Q?vmllYMmpHK4N/yXNjHJhhpFRtw4y8+A6fwG4zel6L5+pNe4HB6+p6JmHAnpB?=
 =?us-ascii?Q?qeTQn/SiQXoJvzd7WiyYDtSr5mm9KVtntzkaeex1B89/45uLRA54YiSsc+z4?=
 =?us-ascii?Q?1uGsye3QWW8teG6KBRLzkafKp2tbDond5373owy/vy4RlhTyKtBI9R4Sb9qu?=
 =?us-ascii?Q?/FdtOXWmndf9fxADjLhpnzs7DIeHmszKXmzY7jIdlsSu0YQqG0chgleL6rdH?=
 =?us-ascii?Q?6yJjoWwW6uNuyNJy9+2z1ul1GI50fmyjOuMx+gvVzyQe32NK+rcs7dIBTUnv?=
 =?us-ascii?Q?G39bXazvHCauupsUOSHg8yCTI9hdpRKlrLelH/AE42e2Rs4+LoLZ9pLL7DZB?=
 =?us-ascii?Q?EJgRWUdHy9YWMUjF+pEHTrbqANRjahUxMOqnZIj1ydYZdlivcXe7B3BajOxh?=
 =?us-ascii?Q?i5lEdPk6WmuNAJGZ3vDP1UONmkiPvJx6n2D5KG2+CcbY/3eYF70jVwzIgbee?=
 =?us-ascii?Q?R5Yjhdv7ZMlaUwZHNDJwrl+rqBe3DnN90cFdkHEGRnWQBlFYD26Fmoso1y42?=
 =?us-ascii?Q?D6cRr8iBsrcPgLEDORr2W+kOJVAEjVnBr+sruEZu+ryuUoDzWXHT1iaUB3rS?=
 =?us-ascii?Q?EaWT5xcuo25a75Sfvi9uHZvqpmHcRHg7We0Lu1U0FG6r8k6WN+Atnv5WYkJh?=
 =?us-ascii?Q?cs1D3e+yct0pTVeeETgpkyfKTmz7E6TJZnCGHiNTMFB3exxn3Itd3PdAShcM?=
 =?us-ascii?Q?Adekw2Mo9MHd8uJBqU6zfXVbpUCZgge4RgOyK4hUgKSda3tpRX/SPb8h4LtC?=
 =?us-ascii?Q?223rqUAGsGN2YLB9QBqlXKjZEG6cawqWwItO+9H75yt3K3sVKc0+vWb3UAa1?=
 =?us-ascii?Q?rvDFoFdtjvz6Tu9jYgTaZT2YIo51CfC+PygRkOlmP/C0DBCeqRTMOi9/QfsG?=
 =?us-ascii?Q?zYJrl20P3Lqd9XMPCzzLxR63PcZ5py7yX7q4vd7HaGP8Qyo3oYYQFaXvKASb?=
 =?us-ascii?Q?uUYumxf26j2a2cItPGa+YkdqERpVD5N+5dusIiXbkeXbS1Mux22VDWqfxmiN?=
 =?us-ascii?Q?YEbejYVA1fxHO2e0sb7rwmOr8RtDXvNisFVjk9F3/lpQTDDvsPeBJ+yPIhnL?=
 =?us-ascii?Q?3Qi0Lk+sb7YNzkjRUM2YtbbzpqlSv4d9pFFzCUv6oPpUNgKWLAmu4yoGGz8l?=
 =?us-ascii?Q?bwOeD9En321LRhcaMUprglR2l52xCGn0SiPdb4sjVWe/MZUVOQtArgnCpNEs?=
 =?us-ascii?Q?BmOJqixU3s7B7Z+MT5t5jyiAuJ2xB4TkbsKiCjpwxPW11b+Cwe1E7UfN2sQW?=
 =?us-ascii?Q?iTCe8VPH1yb6lqoAlWkxpyaFazIYiFFh4GnT9UwO?=
Content-Type: multipart/alternative;
 boundary="_000_CH3PR02MB10247209DBB833215A21A606CB8792CH3PR02MB10247na_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: l4SZ2ygOmUc/ozUTAPoyHfkIi9KD3sw2OKUdfykPW3d1Z67qaLAW/CykpBnW/z/v4CLnrkxnij2l16+zYmUaa9JYHfFbWPQHZjAyF2ZemPm6WaiBxaZ5w29ZTmwhqT88xksojWt3j88vMkoRrSAOW6ppalhofai9NGacitvHUJbL/7cmlwsWoR56Hj2qW+jY+gG0UvqtEkGoeYrPFRL/0oTrbvNXxUnhO74cwCeF/9Me/GyGjocj9TQ5+p5OSFMotjKTdqvnRWN9JzXWeUOj5bE+f1LvRKepZ3t2ovywG9zPKhb31U85jfcItMZ3veDJmAG/RLj6ZpFG1DyPs7fKHdCnyNTu1sMCuRu3yR+SgiIxaglIV8IpXRy7XckvSNw52qTauM3qqIUuhBoAlqEUp6fLM5nqu9kapwp3br98PZmuB9OipI52Ea/9LAUDJMsOjh6LUrw5G3RQbJNuRRRffMHwe4uYmhVSht6c4UMBANNepkozW5l7ZlG4agNihwKdqP8pdRX+KZlvMqMt4ZgcBtQ0eJcZUJmZTT6poZA88jRUQOj+8WKSNyuL5DNBzCsBxwIKrude6b5Rrgvpka1r+Vp8NSPHp6Xm2IRfM2DDxmG3WVaoTHxLkBducYwm3xbC
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR02MB10247.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2379f59a-670b-4281-9e8c-08dc1e852ebe
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 15:40:54.3289 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: afuvtkZaouFsyjiQVyIctKz091iGEWtUTGdkciHaUYbpJyhWJz7S/wA8Cs/u5rYsYzA4UkBkLPXHgpKP3Ob9gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB9010
X-Proofpoint-ORIG-GUID: eb6IsyvC-eJjEACfKivHrWeaWwgcBf0i
X-Proofpoint-GUID: eb6IsyvC-eJjEACfKivHrWeaWwgcBf0i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=435 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401260115
Received-SPF: pass client-ip=205.220.180.131; envelope-from=bcain@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--_000_CH3PR02MB10247209DBB833215A21A606CB8792CH3PR02MB10247na_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

All,

https://kvm-forum.qemu.org/ shows a plan for "Spring 2024" - so that's as s=
oon as ~mid-March or as late as mid-June?  I'd like to understand if we thi=
nk that it's more likely to be later in that range?  Last year was mid June=
 I think? So should we expect something similar this year?

-Brian

--_000_CH3PR02MB10247209DBB833215A21A606CB8792CH3PR02MB10247na_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-ligatures:none;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">All,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in"><a href=3D"https://kvm-fo=
rum.qemu.org/">https://kvm-forum.qemu.org/</a> shows a plan for &#8220;Spri=
ng 2024&#8221; &#8211; so that&#8217;s as soon as ~mid-March or as late as =
mid-June?&nbsp; I&#8217;d like to understand if we think that it&#8217;s mo=
re likely
 to be later in that range?&nbsp; Last year was mid June I think? So should=
 we expect something similar this year?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-Brian<o:p></o:p></p>
</div>
</body>
</html>

--_000_CH3PR02MB10247209DBB833215A21A606CB8792CH3PR02MB10247na_--

