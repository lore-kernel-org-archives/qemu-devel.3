Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412EDC88E45
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x526t-00071c-V0; Fri, 11 Sep 2026 10:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1x526W-0006jN-8R; Fri, 11 Sep 2026 10:19:50 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1x526L-0004A3-Sq; Fri, 11 Sep 2026 10:19:42 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BCh73Z004871; Fri, 11 Sep 2026 07:19:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=TGqXWyMjuyIrlax5rsiRzIwT9OEX71JZ2aeHJhTXW
 oQ=; b=g4tah6z7x6fMgCWw5kqSAH7m6UIymVbLsacOn8GYvEoznqwu7Hc67o3nZ
 IbJ3WfudWItXo7xE6gBgMG1CbRLx20G3a7pwaQtDNd3MZRJ4//RFDWWwUaPCRHq+
 //0TeG7Pi5Q+b87ANMr4V49mC/Ngw4nMcSroFE/I/YqqYGidsHTEORxYtm6Zo5rK
 Qyy9iD/Fe9n0OW3Nm+W+ivf+jaVseIB6aYXXy6PsQJW21x941J6u0gBbaBDjpSh8
 ocmWfsg/bWlkMyjJbJ5JRfbYEKsjF/lETuIsUbLfPyZuIDo2qKn4larJWfta48QS
 iil+bK3LyDXdXT/twQ/Jio5ctJLgg==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022087.outbound.protection.outlook.com [52.101.43.87])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gkd0157s2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 07:19:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOULTfDYe9kTClb13bteuKJLyln4jrj3OPG2XXTyN+6w0dpnBeRMWwPE/LiPFlLmnbQ0pyNBR/RUNAomSfafqVSx+VhG40zm/3B+BDkk/p6zw3QdqTbNe2BjtQw7TpSDotnajg02eM9Fm6IJyJAmreiZ0ZpFLod5FNs9ESkw1xee0SqLDIpDgVX8dQZ26HtEvJPf49EezrXrp3/LDjv05+9QsDU2+puikJbEs0SmFW0E5Bg0xT0qV3Byx5pe84vnYA8YJR6+IamIlKywPESWZkKvdMeVlKJ3uqwj5PhGON+S0ie/QX7G4Dz6HGhQv+Fk/lE5wQHsmPx6cOlD8fRGgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGqXWyMjuyIrlax5rsiRzIwT9OEX71JZ2aeHJhTXWoQ=;
 b=wSg8czlQY1TsdQLWVx//UwivmRuQFJxWEzgnGOJCT/BV4jqhbpsO8pUyXQOTA34XTwGpDTNnFh5rQ1xBmAVOPVSjqR3ndz+clcY426/EnGV9Ga3PlFJO4Fpk+phhZImW2qDePpDlWxhGdTc8prws8fKHu6hwuHgmUfABvUNXUISagajxZnd7guT7Q61uiGDawiaB3zdk0Chw1o6JpaotSqGL2zQn3YeJu46ACl9CVMdeQP+yyNoMcjsOFKgOE30x50z8Qpj01kIYlRuQ+N45SwPoDK7fnVzPsLLU6tNibU+Jq+XXY7P/N3WldkY9iXzn3155eflMkLOLt5vGVm9hXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGqXWyMjuyIrlax5rsiRzIwT9OEX71JZ2aeHJhTXWoQ=;
 b=W4lClKdL10eroh0Qvo8jBAXInK0cBibExBqiitg57jPy57+0iJYYr1ifo5hDhawGR2DGJc2e2aciO/Aud8xvULbnt4npqWFs4t6T76cNUeb6qHvmII54o7WcGuWhkM0+XKN8gzL/j6sekLUki3q+Ip1fiesYkPkDKyI5Tz+wP8lMkI2kDELxw+n0RIX8LMFxUiQMaD/Cvm6xOYIGGmGsTDzcZZECQoCmycYX5pLSeo5XUKUV/eOAtr4KTrqDqzPQ4Uu1PsVy2/DttvGSCrbCfy0pQW1LQnaGphqYb3lS+4noPH2KhXns1gJ1OzY/h8XWj92FiVTtDK5iH9U6CTEW2Q==
Received: from DM6PR02MB6172.namprd02.prod.outlook.com (2603:10b6:5:1fe::18)
 by SJ0PR02MB11781.namprd02.prod.outlook.com (2603:10b6:a03:402::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 14:19:30 +0000
Received: from DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd]) by DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 14:19:30 +0000
From: Hugo Komatsu <hugo.komatsu@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Alex Williamson
 <alex@shazbot.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Rafael Castillo <rafael@trfs.me>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v2 5/8] vfio: use io_ops abstraction for migration related
 ioctls
Thread-Topic: [PATCH v2 5/8] vfio: use io_ops abstraction for migration
 related ioctls
Thread-Index: AQHdQfiPVuNgV13eQkaje2LnXJ8GtQ==
Date: Fri, 11 Sep 2026 14:19:30 +0000
Message-ID: <20260911140710.2348139-6-hugo.komatsu@nutanix.com>
References: <20260911140710.2348139-1-hugo.komatsu@nutanix.com>
In-Reply-To: <20260911140710.2348139-1-hugo.komatsu@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR02MB6172:EE_|SJ0PR02MB11781:EE_
x-ms-office365-filtering-correlation-id: 8ef30d36-b82c-4c6e-2a13-08df100fb1f2
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|38070700021|6133799003|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: jMvVFfhiK+LwzZFYwhXIGBsvWNQgnz0T2TTTLcKt7NXiKV4rW37XMTANWvnIwqFkX3L1BN13FOeC/CNUU1Ww4ZEddW4KXPticnyXEE7qyf9hafrz5KsoceuzxqVLFT7P3FpYJvHfF52i4RnYMSUPllvdMc2brQXOstBkjoOqL0/xNIwI43WWpIHnybJ8l9nPkq2O7n1oL/jiqUDj7HkHzBR64KII+rJzCi3nx4Y3CYA45zYhD0wbu7MlGxqqvFCqmm6WXwaIHfpHr4nc8ldkTwjMzfuLn4RwDJGpRmEUjHl6VCw64rjSR9YWEVKD4Y/+fDAh9oZ+mU+ryieEMrV0kr7BxadbPx9mVjzjBPaNY4PMdUgItvIokAG4vxWW7sKBJ/j30I7fxxdcSGzviaqk86H+vBn+8xIfoa/2RB33TMG6ItyIULlR9gF6KuYlydJ74NCdQgUdiuQU/E6halqYbAIvM9YqEf+5YPrFffO+oE4Eq8qGswYdq2adEAXwxV+5sYzsQ1cyAW2KsbWxQLaUsM5liG3TKy1ozwFO86BeSDE7U8CBZKSfEDMb7o9MiSRohc0+jCSbugH7FcBJKMjt82Ugv4kOk7uKSCd9hXtm3BgDWqzveSNHD37FkIHsTVYWT+BIiTDdTKJIoSSTgahNFJUaDRWNpXpj0Ll9Pc7I/Vy9l8iSixBiLCZVjkvHUy0IOgtJcqc9xuJXffoY1ve18/w9XfSQzHBU0eVs1dbcT8I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR02MB6172.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(38070700021)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?d9eZdBZqB7Ri2zoaLU7v2Vx+CVP80Yu/zHQd+D14l0qqnOKYSWZ53eiHEj?=
 =?iso-8859-1?Q?OP+QPP9nmV9dilXVU89lVHieg1ICNWxRbMqR9AYC5ueEtgB+ctxrqpeAt3?=
 =?iso-8859-1?Q?TwZOTTAMw5RbJexflhyr/Q/oXqv5rgaJHMpelvmeZP9v1Ywl0kvNRPzJQl?=
 =?iso-8859-1?Q?1bLlX8g5nffgFkjXZ2Fb3UvBgRoG3SnCtjy8CbNK0Mflpsr2ebn/z8AGBO?=
 =?iso-8859-1?Q?mQc6/J9QKpRS39DumoHBVpYj7Tg0pNcikR1Bgtp2E1xfvI53NrI4DrFeIz?=
 =?iso-8859-1?Q?+7jqhpAiVYNaPGeUQ00O3H5N8x+8vidVuR4VfYs5eHohoqdy+nB+Ns+H2J?=
 =?iso-8859-1?Q?+1dRU6lWsH23QNBrQk86y7FW7eDn94LgfllGSaJ6Fmvc2qNRsczTx49s6s?=
 =?iso-8859-1?Q?iTwZ5N7AFUDy84MnLUf2U4PW060fqsEqGMHr4OC5AS8N27y98jsn1EMgHV?=
 =?iso-8859-1?Q?zGYYgHoV+IKAIUXyYSPiXkhBD0I2YilGo8xvtLPPE0M9LjujTY8pb8zWPS?=
 =?iso-8859-1?Q?lebYDSS3HjdjPKthr5N5TTmSADQGVxF8ARuNb76KBOgOdjLkTf5P4t3irs?=
 =?iso-8859-1?Q?2TEjulw04rN/1T4jZN2WBghXPoA9ZwLMZfjkS49+j0+0YcmfNtuk9UGrxs?=
 =?iso-8859-1?Q?+BGOQJGP6lwXkecXaq8Hnjn5OtY5qibWC4MfFT1WUG3JWpbLEFLHzncCdP?=
 =?iso-8859-1?Q?1zE1SGAdGt1wwNhD1nnfNEXP5PxcFN54hbO4qUZWQ2MW2JpjSSQT/jBpgk?=
 =?iso-8859-1?Q?bhi6ueZn7VDKZsCQibuKyCocqgKHekcq4wopCti/LSqfbHR0VxDvc4vWLB?=
 =?iso-8859-1?Q?kgybk5AJlHD9ixDS79kknNqYjoQBref6dAdXNVDANHitZKmAwDNC6QuzWv?=
 =?iso-8859-1?Q?9nzpszQmU5KMyOXq+i/8oEX3le69/4AdR1/rFanRrINJS+aoGxmKNepJn5?=
 =?iso-8859-1?Q?yicZ4Mn9/AhISkHGI7gnXdJjDp00/JL52E4nzg3x9JmWfxgaxCiGfoIJjb?=
 =?iso-8859-1?Q?UJDmYtwT1rKYv7YYVDbZrvAIhQ7X8/y28h41SHgYTmbwlmWb2XfDaSXXQR?=
 =?iso-8859-1?Q?S0lcdlUB5bkQOpgf5vb+KbS2caeRLKypDFE9RqAUnjoqAABAjZrmvn79zg?=
 =?iso-8859-1?Q?chcKi3GRpTd+IYsj7YtM9hf6X0VuKaUToMruH7lOL/8hUlzk4hqAsNUxZ8?=
 =?iso-8859-1?Q?ylHDomJYHSQ1OyGdA+rNeCc09Yzm+FNXsy5DmZgJ18/nfWpTOH5hOvZ7ZT?=
 =?iso-8859-1?Q?cl6iZ2ujXQ9iOSgEo9xpk/MCv2hLzTFz37FcbL4JJrLtqwhICM52JHE5wk?=
 =?iso-8859-1?Q?TkTEMhhoYrgwpyW7r6QEgJIUMrGD1IZrHVUka1BvgMpu9zbyq8Vyde9MUv?=
 =?iso-8859-1?Q?uz1kaAagV9a82dZ9dySF06UdI0Gw1G1VRGAL3mlXpdheB7dxYaQ8zVoaQQ?=
 =?iso-8859-1?Q?pU4r6ezp+TydH+2zYzRhTHXrvPG6zj5h854avxW8rS6//u6bcSQLtmoRX7?=
 =?iso-8859-1?Q?tVuDhl/FIYWTstLS4lEI3+ftX1XC8XyzPt9Hduiza7vSpNu6FyExVfPjSj?=
 =?iso-8859-1?Q?4ZzODsJUZ/vSVf5SfE8YDobO8QXL09LfM1Orxfvf1UTjwCAXtgAOtQRHxR?=
 =?iso-8859-1?Q?Toy0TJHQtguz3IbJvO/gzaPnJacT3pr5W2nbVCPOm397sD4l5BfYuQuSz8?=
 =?iso-8859-1?Q?c4U+hUI4uBU6qi1c8hUXj7RHPHIvrXxRNsVYN2hB93TlGQfbFHr/AND00a?=
 =?iso-8859-1?Q?4jogc+Qs0KZO3xK2fp897nhV6X0IOLsHwD3HKjrSo8lAwOouYLVMjMvAVW?=
 =?iso-8859-1?Q?H3GrmGi7z6NX3zNLxwaXUxxji5NAeDA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: zmHTqcXWudZ6fb5WHJ6kcL+0cewQam0xFneTi3LODeRNsezcTHCO0BtL4IM1M+A9qx461S4Z4QzRB9XXcjVz7DUqVPh7BAoZvt1yiyw2l3nyM+YEORd94zh5AbiTNyTacI2S6VipZWxE+Ur3+Y3H2dJXE28/vtg0EEBzmFTdLLzigVPw6dTygF/2yNhL/ekmYqbi919peoxKwkHZeRNKw4m/HdEkcokvlTXv873d2tvHzzosnLUmFEY0BostGVhNecnmjG9V7U6/n9kHbuY67uLOBExCQpxTJ8n0nXDj8VRbS4sAEpi/42PvZbwFglKcYfn70YSI8++ku8BeYp2Y8w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6172.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef30d36-b82c-4c6e-2a13-08df100fb1f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 14:19:30.5362 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T9qpptKpXU0+gwwuJpoHA5ik0PDqDiL07QWJ8+QwVk32vuLCRvXkthe2vudnKYSRjYIjQUeBSySYnhD6a+IhbI9vH/gMK/iuRsfSgxrVwAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB11781
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIwMCBTYWx0ZWRfX/YYXa4O6/ueH
 FbI7jpCJ3iF4+tQrwSn3Si38KcPyICuS9eIMLE/ImjMVj5yFRKhRW8nRoexK4f9QVbyuQhwHD59
 r/ZEL0R9krOreh+64r29WBQ7Osse3qMOCRwOF0tgZUN+02LlVVEbqRZi9cG80BPzGlv5rQCVh5X
 nO/JjdecAUNol4Yx8hiVMyFkN9FXwuTlsPBvTdiLwaLRQ92o5G9BVUHB2pm2/Nxh7p/tT4rLXSq
 v7nAbsbb87aYJ8J29rd4phq40CrBIRUHI7YHuM7pRREF+V5+lqlGe8br5XpF8Oj/zCD4gjqOu0k
 H6M35lVtI0MmSn82ATN1v8v0O3+ruwbRuDHTs5acKCGwm2RXSuOEcfUzuvI1DokVOXBjxIgtYcR
 ACbWHnh5V/Aq7SkgOobVMZ3BuXs6RhighI2aTxHjwxOJz2p8eaTiJ/fXXYZGfLcRKt/T2tv1Y5D
 WPMiRZe8QFvuyOttS8w==
X-Authority-Analysis: v=2.4 cv=H5hOUOYi c=1 sm=1 tr=0 ts=6aa40df4 cx=c_pps
 a=LzkVVAj3Rd1zMMBobGGGjw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22 a=64Cc0HZtAAAA:8
 a=jhpVBWEyHgyra-DUs_sA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: vnfDyxVqtkAAMPvQ-bNctz_Yo6x_oHLI
X-Proofpoint-GUID: vnfDyxVqtkAAMPvQ-bNctz_Yo6x_oHLI
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIwMCBTYWx0ZWRfX1iJT52nfaGoH
 0xgPQ2JdpiTSJB/E3woQxTF6Uvz3VduA3SH54AjKix5MfPbB6QxrQzB7XfRcNrHcO4AczuvKeTd
 AJ08R2ns79FPcgPhJMDuMl9YhwVd0y8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_04,2026-09-11_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=hugo.komatsu@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The generic VFIO migration code in hw/vfio/migration.c issued read()=0A=
and qemu_file_get_to_fd() directly, hardcoding the kernel as the only=0A=
transport. Route these through the VFIODeviceIOOps table so an=0A=
alternate transport (vfio-user) can supply its own implementations.=0A=
=0A=
Add three migration slots - get_precopy_info, mig_data_read, and=0A=
mig_data_write_from_file - and guarded public wrappers that dispatch to=0A=
the selected backend. Implement the kernel callbacks around the existing=0A=
calls. vfio_query_precopy_size() and vfio_save_block() now take a=0A=
VFIODevice so they can call the wrappers.=0A=
=0A=
This is a pure refactor: the kernel path is unchanged.=0A=
=0A=
Co-authored-by: Rafael Castillo <rafael@trfs.me>=0A=
Signed-off-by: Hugo Komatsu <hugo.komatsu@nutanix.com>=0A=
---=0A=
 hw/vfio/device.c              | 64 +++++++++++++++++++++++++++++++++++=0A=
 hw/vfio/migration.c           | 37 ++++++++++----------=0A=
 include/hw/vfio/vfio-device.h | 45 ++++++++++++++++++++++++=0A=
 3 files changed, 127 insertions(+), 19 deletions(-)=0A=
=0A=
diff --git a/hw/vfio/device.c b/hw/vfio/device.c=0A=
index b2123a0443..ddd7508359 100644=0A=
--- a/hw/vfio/device.c=0A=
+++ b/hw/vfio/device.c=0A=
@@ -30,8 +30,10 @@=0A=
 #include "qemu/units.h"=0A=
 #include "migration/cpr.h"=0A=
 #include "migration/blocker.h"=0A=
+#include "migration/qemu-file.h"=0A=
 #include "monitor/monitor.h"=0A=
 #include "vfio-helpers.h"=0A=
+#include "vfio-migration-internal.h"=0A=
 =0A=
 VFIODeviceList vfio_device_list =3D=0A=
     QLIST_HEAD_INITIALIZER(vfio_device_list);=0A=
@@ -576,6 +578,34 @@ int vfio_device_reset(VFIODevice *vbasedev)=0A=
     return vbasedev->io_ops->device_reset(vbasedev);=0A=
 }=0A=
 =0A=
+int vfio_device_get_precopy_info(VFIODevice *vbasedev,=0A=
+                                 struct vfio_precopy_info *info)=0A=
+{=0A=
+    if (!vbasedev->io_ops || !vbasedev->io_ops->get_precopy_info) {=0A=
+        return -EINVAL;=0A=
+    }=0A=
+    return vbasedev->io_ops->get_precopy_info(vbasedev, info);=0A=
+}=0A=
+=0A=
+ssize_t vfio_device_mig_data_read(VFIODevice *vbasedev, void *buf,=0A=
+                                  size_t buf_size)=0A=
+{=0A=
+    if (!vbasedev->io_ops || !vbasedev->io_ops->mig_data_read) {=0A=
+        return -EINVAL;=0A=
+    }=0A=
+    return vbasedev->io_ops->mig_data_read(vbasedev, buf, buf_size);=0A=
+}=0A=
+=0A=
+int vfio_device_mig_data_write_from_file(VFIODevice *vbasedev, QEMUFile *f=
,=0A=
+                                         size_t data_size)=0A=
+{=0A=
+    if (!vbasedev->io_ops ||=0A=
+        !vbasedev->io_ops->mig_data_write_from_file) {=0A=
+        return -EINVAL;=0A=
+    }=0A=
+    return vbasedev->io_ops->mig_data_write_from_file(vbasedev, f, data_si=
ze);=0A=
+}=0A=
+=0A=
 int vfio_device_get_feature(VFIODevice *vbasedev,=0A=
                             struct vfio_device_feature *feature)=0A=
 {=0A=
@@ -598,6 +628,37 @@ static int vfio_device_io_device_reset(VFIODevice *vba=
sedev)=0A=
     return ret < 0 ? -errno : ret;=0A=
 }=0A=
 =0A=
+static ssize_t vfio_device_io_mig_data_read(VFIODevice *vbasedev, void *bu=
f,=0A=
+                                            size_t buf_size)=0A=
+{=0A=
+    VFIOMigration *migration =3D vbasedev->migration;=0A=
+    ssize_t ret;=0A=
+=0A=
+    ret =3D read(migration->data_fd, buf, buf_size);=0A=
+=0A=
+    return ret < 0 ? -errno : ret;=0A=
+}=0A=
+=0A=
+static int vfio_device_io_mig_data_write_from_file(VFIODevice *vbasedev,=
=0A=
+                                                   QEMUFile *f,=0A=
+                                                   size_t data_size)=0A=
+{=0A=
+    VFIOMigration *migration =3D vbasedev->migration;=0A=
+=0A=
+    return qemu_file_get_to_fd(f, migration->data_fd, data_size);=0A=
+}=0A=
+=0A=
+static int vfio_device_io_get_precopy_info(VFIODevice *vbasedev,=0A=
+                                           struct vfio_precopy_info *info)=
=0A=
+{=0A=
+    VFIOMigration *migration =3D vbasedev->migration;=0A=
+    int ret;=0A=
+=0A=
+    ret =3D ioctl(migration->data_fd, VFIO_MIG_GET_PRECOPY_INFO, info);=0A=
+=0A=
+    return ret < 0 ? -errno : ret;=0A=
+}=0A=
+=0A=
 static int vfio_device_io_device_feature(VFIODevice *vbasedev,=0A=
                                          struct vfio_device_feature *featu=
re)=0A=
 {=0A=
@@ -678,6 +739,9 @@ static VFIODeviceIOOps vfio_device_io_ops_ioctl =3D {=
=0A=
     .capabilities =3D VFIO_IO_CAP_DMA_BUF,=0A=
 =0A=
     .device_reset =3D vfio_device_io_device_reset,=0A=
+    .mig_data_read =3D vfio_device_io_mig_data_read,=0A=
+    .mig_data_write_from_file =3D vfio_device_io_mig_data_write_from_file,=
=0A=
+    .get_precopy_info =3D vfio_device_io_get_precopy_info,=0A=
     .device_feature =3D vfio_device_io_device_feature,=0A=
     .get_region_info =3D vfio_device_io_get_region_info,=0A=
     .get_irq_info =3D vfio_device_io_get_irq_info,=0A=
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c=0A=
index 25acb6dca4..257f9253aa 100644=0A=
--- a/hw/vfio/migration.c=0A=
+++ b/hw/vfio/migration.c=0A=
@@ -247,10 +247,9 @@ vfio_migration_set_state_or_reset(VFIODevice *vbasedev=
,=0A=
 static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,=0A=
                             uint64_t data_size)=0A=
 {=0A=
-    VFIOMigration *migration =3D vbasedev->migration;=0A=
     int ret;=0A=
 =0A=
-    ret =3D qemu_file_get_to_fd(f, migration->data_fd, data_size);=0A=
+    ret =3D vfio_device_mig_data_write_from_file(vbasedev, f, data_size);=
=0A=
     trace_vfio_load_state_device_data(vbasedev->name, data_size, ret);=0A=
 =0A=
     return ret;=0A=
@@ -369,20 +368,20 @@ static int vfio_query_stop_copy_size(VFIODevice *vbas=
edev)=0A=
     return ret;=0A=
 }=0A=
 =0A=
-static int vfio_query_precopy_size(VFIOMigration *migration)=0A=
+static int vfio_query_precopy_size(VFIODevice *vbasedev)=0A=
 {=0A=
-    VFIODevice *vbasedev =3D migration->vbasedev;=0A=
+    VFIOMigration *migration =3D vbasedev->migration;=0A=
     struct vfio_precopy_info precopy =3D {=0A=
         .argsz =3D sizeof(precopy),=0A=
     };=0A=
     bool reinit =3D false;=0A=
     int ret =3D 0;=0A=
 =0A=
-    if (ioctl(migration->data_fd, VFIO_MIG_GET_PRECOPY_INFO, &precopy)) {=
=0A=
+    ret =3D vfio_device_get_precopy_info(vbasedev, &precopy);=0A=
+    if (ret) {=0A=
         migration->precopy_init_size =3D 0;=0A=
         migration->precopy_dirty_size =3D 0;=0A=
-        ret =3D -errno;=0A=
-        warn_report_once("VFIO device %s ioctl(VFIO_MIG_GET_PRECOPY_INFO) =
"=0A=
+        warn_report_once("VFIO device %s get_precopy_info "=0A=
                          "failed (%d)", vbasedev->name, ret);=0A=
     } else {=0A=
         bool overflow;=0A=
@@ -425,18 +424,20 @@ static int vfio_query_precopy_size(VFIOMigration *mig=
ration)=0A=
 }=0A=
 =0A=
 /* Returns the size of saved data on success and -errno on error */=0A=
-static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)=0A=
+static ssize_t vfio_save_block(QEMUFile *f, VFIODevice *vbasedev)=0A=
 {=0A=
+    VFIOMigration *migration =3D vbasedev->migration;=0A=
     ssize_t data_size;=0A=
 =0A=
-    data_size =3D read(migration->data_fd, migration->data_buffer,=0A=
-                     migration->data_buffer_size);=0A=
+    data_size =3D vfio_device_mig_data_read(vbasedev,=0A=
+                                          migration->data_buffer,=0A=
+                                          migration->data_buffer_size);=0A=
     if (data_size < 0) {=0A=
         /*=0A=
          * Pre-copy emptied all the device state for now. For more informa=
tion,=0A=
          * please refer to the Linux kernel VFIO uAPI.=0A=
          */=0A=
-        if (errno =3D=3D ENOMSG) {=0A=
+        if (data_size =3D=3D -ENOMSG) {=0A=
             if (!migration->event_precopy_empty_hit) {=0A=
                 trace_vfio_save_block_precopy_empty_hit(migration->vbasede=
v->name);=0A=
                 migration->event_precopy_empty_hit =3D true;=0A=
@@ -444,7 +445,7 @@ static ssize_t vfio_save_block(QEMUFile *f, VFIOMigrati=
on *migration)=0A=
             return 0;=0A=
         }=0A=
 =0A=
-        return -errno;=0A=
+        return data_size;=0A=
     }=0A=
     if (data_size =3D=3D 0) {=0A=
         return 0;=0A=
@@ -599,7 +600,7 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, E=
rror **errp)=0A=
                 return ret;=0A=
             }=0A=
 =0A=
-            vfio_query_precopy_size(migration);=0A=
+            vfio_query_precopy_size(vbasedev);=0A=
             if (migrate_switchover_ack() && !migrate_switchover_ack_legacy=
()) {=0A=
                 migration->request_switchover_ack =3D true;=0A=
             }=0A=
@@ -662,12 +663,10 @@ static void vfio_save_cleanup(void *opaque)=0A=
 =0A=
 static void vfio_state_pending_sync(VFIODevice *vbasedev)=0A=
 {=0A=
-    VFIOMigration *migration =3D vbasedev->migration;=0A=
-=0A=
     vfio_query_stop_copy_size(vbasedev);=0A=
 =0A=
     if (vfio_device_state_is_precopy(vbasedev)) {=0A=
-        vfio_query_precopy_size(migration);=0A=
+        vfio_query_precopy_size(vbasedev);=0A=
     }=0A=
 }=0A=
 =0A=
@@ -738,7 +737,7 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)=
=0A=
         migration->event_save_iterate_started =3D true;=0A=
     }=0A=
 =0A=
-    data_size =3D vfio_save_block(f, migration);=0A=
+    data_size =3D vfio_save_block(f, vbasedev);=0A=
     if (data_size < 0) {=0A=
         return data_size;=0A=
     }=0A=
@@ -778,7 +777,7 @@ static int vfio_save_complete_precopy(QEMUFile *f, void=
 *opaque)=0A=
     }=0A=
 =0A=
     do {=0A=
-        data_size =3D vfio_save_block(f, vbasedev->migration);=0A=
+        data_size =3D vfio_save_block(f, vbasedev);=0A=
         if (data_size < 0) {=0A=
             return data_size;=0A=
         }=0A=
@@ -975,7 +974,7 @@ static void vfio_final_precopy_reinit_check(VFIODevice =
*vbasedev)=0A=
         return;=0A=
     }=0A=
 =0A=
-    ret =3D vfio_query_precopy_size(migration);=0A=
+    ret =3D vfio_query_precopy_size(vbasedev);=0A=
     if (ret) {=0A=
         error_report("%s: Final precopy reinit check failed (err: %d)",=0A=
                      vbasedev->name, ret);=0A=
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h=
=0A=
index 6dc596c9fc..f0add3fd84 100644=0A=
--- a/include/hw/vfio/vfio-device.h=0A=
+++ b/include/hw/vfio/vfio-device.h=0A=
@@ -202,6 +202,18 @@ struct VFIODeviceIOOps {=0A=
      */=0A=
     int (*device_reset)(VFIODevice *vdev);=0A=
 =0A=
+    /**=0A=
+     * @get_precopy_info=0A=
+     *=0A=
+     * Get information about pre-copy migration data transfer progress.=0A=
+     *=0A=
+     * @vdev: #VFIODevice to use=0A=
+     * @info: pointer to struct vfio_precopy_info to fill in=0A=
+     *=0A=
+     * Returns 0 on success or -errno.=0A=
+     */=0A=
+    int (*get_precopy_info)(VFIODevice *vdev, struct vfio_precopy_info *in=
fo);=0A=
+=0A=
     /**=0A=
      * @device_feature=0A=
      *=0A=
@@ -268,6 +280,33 @@ struct VFIODeviceIOOps {=0A=
     int (*region_read)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t s=
ize,=0A=
                        void *data);=0A=
 =0A=
+    /**=0A=
+     * @mig_data_read=0A=
+     *=0A=
+     * Read migration data from the device.=0A=
+     *=0A=
+     * @vdev: #VFIODevice to use=0A=
+     * @buf: buffer to read into=0A=
+     * @buf_size: maximum number of bytes to read=0A=
+     *=0A=
+     * Returns the number of bytes read on success or -errno.=0A=
+     */=0A=
+    ssize_t (*mig_data_read)(VFIODevice *vdev, void *buf, size_t buf_size)=
;=0A=
+=0A=
+    /**=0A=
+     * @mig_data_write_from_file=0A=
+     *=0A=
+     * Write migration data to the device, reading the data from a QEMUFil=
e.=0A=
+     *=0A=
+     * @vdev: #VFIODevice to use=0A=
+     * @f: source to read the migration data from=0A=
+     * @data_size: number of bytes to write=0A=
+     *=0A=
+     * Returns 0 on success or -errno.=0A=
+     */=0A=
+    int (*mig_data_write_from_file)(VFIODevice *vdev, QEMUFile *f,=0A=
+                                    size_t data_size);=0A=
+=0A=
     /**=0A=
      * @region_write=0A=
      *=0A=
@@ -299,6 +338,12 @@ bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODe=
vice *vbasedev,=0A=
                                                 uint32_t size);=0A=
 =0A=
 int vfio_device_reset(VFIODevice *vbasedev);=0A=
+int vfio_device_get_precopy_info(VFIODevice *vbasedev,=0A=
+                                 struct vfio_precopy_info *info);=0A=
+ssize_t vfio_device_mig_data_read(VFIODevice *vbasedev, void *buf,=0A=
+                                  size_t buf_size);=0A=
+int vfio_device_mig_data_write_from_file(VFIODevice *vbasedev, QEMUFile *f=
,=0A=
+                                         size_t data_size);=0A=
 int vfio_device_get_feature(VFIODevice *vbasedev,=0A=
                             struct vfio_device_feature *feature);=0A=
 =0A=
-- =0A=
2.39.3=0A=
=0A=

