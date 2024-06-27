Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C19C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 02:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMfJA-00068U-2l; Wed, 26 Jun 2024 22:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@us.ibm.com>)
 id 1sMfJ4-00067X-An; Wed, 26 Jun 2024 22:56:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@us.ibm.com>)
 id 1sMfJ0-0002Qu-C1; Wed, 26 Jun 2024 22:56:17 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R2QimK024847;
 Thu, 27 Jun 2024 02:56:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:references:in-reply-to
 :content-type:mime-version; s=pp1; bh=ZU7W8M0vYbxeyWo1TxUn6VMPxQ
 TKnmA122w8nLeYOgE=; b=fFimR9tYKETQ3GzAREtNKT9IKjeuDFU7E7dVmyiGDe
 pc3RUSQFMXxt9QkCKNSjgNZIhVhZMW/JEJ17n0VajiaZVFTD1tdbOej3LU3AVLHN
 QNRb6l5A29WrKiJxrUnlK6xwBoXuLfGG3NAsvr37b9x+oB1w9ka7vfaYZVKQsW1U
 TzX++qyj4oVnXIBVUAuJmpMKCXirLyV5tgTuqPuKwb1rKsZ+HLvxbKs2KZ3YtDaC
 0aITDVXydx6zmvdjhkW0qHEW9C69lWFL1iB8U++J84r5Z3Xoh9RTRos79vqVUJuP
 bi9qXpI37/jDWZ2XYpQNrYAEZAd98olOhBPCfj2nIyDQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400wk0071x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jun 2024 02:56:04 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45R2u4ed012412;
 Thu, 27 Jun 2024 02:56:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400wk0071r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jun 2024 02:56:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpNmQTLopBGF7D+hp41i17HxDM5Pj/qXoYA7A4WlMaNGI1i6fezGmOs77srnXhxnrP7vzIyHX4SrxsAu/a09znY7vv9Z8pstBXYo6rc8FMpDER+8ac1XFpZMKw41QBAgq0P0xjqrVSo/bIjwcUHWxwBtl76F7Xq55xmx9LjwtQtFXUhj3owwOKPuLy/MJ9IMZRXlP9zGVB5hYLJSKN+QNUfpuqoi/Elb3y0olhGG4pdwdfEhCfFwTkRwFTAD3z5qgGoGIRfRNIXWnxv2NNktmNnB0QURwVR1GovvSmBbhJc8h8AtDRvaKpDVqRzSZ03lgNhfSL6yh9xq/1PAk6LwdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZU7W8M0vYbxeyWo1TxUn6VMPxQTKnmA122w8nLeYOgE=;
 b=NojyNtUCapPLzLcw2oYwrI1wbYKd7R/iDRrxB9x4e/p+MgQJ4wdqAcWO5un9MObemmiWCgSf3cGY4746u/jN/rr7pLLPYsm/j1hbk23mT3+Yckc88MwpR3EqJn+ewUkPbBYnZH4Q9Gde1pGksbdP+/QylC9zA0G3IZ0JCUXULNYfWp4/UZP90hGYd3BkGYjwaJ6EpUhdHfQoLo4TSfBM45fyytjna9RLI8dUsF/arp6QTmMncM5rSz0a3LEPeGFyNZr5El4GqzgAmhhL2/GyRt9XvviG7hUXZMdiERIlj2N4pyW6dtBZQEn7UwYjfBr6MImFjxVeh6VeDuYmkbQixg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from PH0PR15MB4720.namprd15.prod.outlook.com (2603:10b6:510:9a::6)
 by MN6PR15MB6001.namprd15.prod.outlook.com (2603:10b6:208:47e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 02:56:01 +0000
Received: from PH0PR15MB4720.namprd15.prod.outlook.com
 ([fe80::fdd1:5ceb:28e8:e1b4]) by PH0PR15MB4720.namprd15.prod.outlook.com
 ([fe80::fdd1:5ceb:28e8:e1b4%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 02:56:01 +0000
From: CALEB SCHLOSSIN <calebs@us.ibm.com>
To: Chalapathi V <chalapathi.v@linux.ibm.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "fbarrat@linux.ibm.com"
 <fbarrat@linux.ibm.com>,
 "npiggin@gmail.com" <npiggin@gmail.com>, "clg@kaod.org" <clg@kaod.org>,
 Chalapathi V <Chalapathi.V@ibm.com>,
 "saif.abrar@linux.ibm.com" <saif.abrar@linux.ibm.com>, Dan Tan
 <dantan@us.ibm.com>, "milesg@linux.ibm.com" <milesg@linux.ibm.com>
Subject: Re: [PATCH v5 6/6] tests/qtest: Add pnv-spi-seeprom qtest
Thread-Topic: [PATCH v5 6/6] tests/qtest: Add pnv-spi-seeprom qtest
Thread-Index: AQHax6gWAvl/0mKgBE6vpJUYIGkAl7Ha66Vs
Date: Thu, 27 Jun 2024 02:56:01 +0000
Message-ID: <PH0PR15MB47206C425A62330C36C06780E1D72@PH0PR15MB4720.namprd15.prod.outlook.com>
References: <20240626090528.812-1-chalapathi.v@linux.ibm.com>
 <20240626090528.812-7-chalapathi.v@linux.ibm.com>
In-Reply-To: <20240626090528.812-7-chalapathi.v@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB4720:EE_|MN6PR15MB6001:EE_
x-ms-office365-filtering-correlation-id: d56e876e-cf8a-4dea-50c9-08dc9654ad89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?eNJ8QRPuUQ+pegfJxOtc5dEcYgAKHeWj+5OpHvSz9u8PzZCjBQICULXsFg?=
 =?iso-8859-1?Q?K5wCvr8vPZtGtv5SnVMuzCHzJJLfcbBmfhQlO1Lt51z1x7nC4OrjQkwaKT?=
 =?iso-8859-1?Q?Z7kx+F+Rg6+tK3l/l18zjeDmftmELQ94qrb+vsDcea1JtMXNI2uUh85+CN?=
 =?iso-8859-1?Q?IiIS/U8iUlHb8qbEEA7IJuhKeueG6/u/Kjpz4YdP9RluK4tlGoZcBgkPJm?=
 =?iso-8859-1?Q?hNJ+yKx/h/8XYsM7b4T2/zW9KXiKK0rDtNHf7Vt+qnPt16AuYQAaIXjmIW?=
 =?iso-8859-1?Q?sKcFgs+8xJD4P/te0+qF3u33wB6LLCa65F6vm0dMp6Acda5Z19Ibpkq8Pw?=
 =?iso-8859-1?Q?rPaSWi5jmrNQCZSL6RANUJZapFwBgfJJk5x36C66s7JiwkiAtO6pXvBCYt?=
 =?iso-8859-1?Q?h58gHqtMkcbV3LGCUQEM3aw1VypowWmnl8wBHvb5NrOeYmqJ6S7th8L3qU?=
 =?iso-8859-1?Q?Ei8iJZ+BoIeuIVvwUHlo7lnaEPyZ89NhB3Jbo8ttOmWosUEH/tCFkjDniQ?=
 =?iso-8859-1?Q?8p4Dwpgy7TqmfHDLY2uj3ETgAV3q2gaQT5Vb4V3ItwD8kuqyelo2HH6/kA?=
 =?iso-8859-1?Q?OAeQwOJO0iZBgJQZRLaqJHrb+7P28d21vUOcytvpOpXTCEE7oPHXhwjcLe?=
 =?iso-8859-1?Q?HTZqC1fskT+Yes6ptSCy3beA395wN8f7z3PcKfMTgVsGwcnLj0UoVcBdnR?=
 =?iso-8859-1?Q?dxRvWF8gm1f6ADWXjJwzOi0XKuGw2c9dUdE9wdrsquf5lY4S4BPZnkAN2c?=
 =?iso-8859-1?Q?u3bjTHkhgggNy+eM7sjN9JEC/1o36MMLBinUZ0uHmlb1mdLiHuzQPw1yM0?=
 =?iso-8859-1?Q?rpVD9000NJHaHkDsSwRKTFlJA4Yj8fTfq+s4rXjLrh2Mf/NRh2gBi7zAnK?=
 =?iso-8859-1?Q?MyH5ciTUDgJw7AmV7+2HbEqmBA4QAEwMaJfioMsbRZ+UISaNrxJinz1Lqb?=
 =?iso-8859-1?Q?XbYdVgBKdoddE/8sz+8nENKoCnp/laOcNfelPEWIN03SOE5J+EmuWpZSob?=
 =?iso-8859-1?Q?Xku7YF/QbZ/RXZeVqfPntOlyJdAtrcRfktTZ0d2ZCNwnucueLB7hBPIxQc?=
 =?iso-8859-1?Q?YzaG94cH2AY/hRhdDZQ9AzqW7CQ8oQymre2vDigu75yWPowNgc2pncLw11?=
 =?iso-8859-1?Q?+xxYEHOuSuUmo3oeEqcXn7yd6m+3bznKAZdFtbkMRujI0eKs8I3bDDLcZi?=
 =?iso-8859-1?Q?2nkf4V1+BKKF/RlD748+qIW+xaMOlFZKr9dvQDHbaSxU+dVldZXHp20X3T?=
 =?iso-8859-1?Q?AsukYsWEjjqCTycPzDApA3r0oOtq6u77fuawzhmIRA5eUkrK+vIp2NBg2B?=
 =?iso-8859-1?Q?NHD4zBjELQZdg5b3UevHxQQuq1S8u/n0CWvcIPudwqkJslibwCxcJff239?=
 =?iso-8859-1?Q?UQ2PZpuzMqdwly3R92ITP6p3bqQNZBFu6O/Gj8QX0Rq4YfhL+AhegvOUPU?=
 =?iso-8859-1?Q?S+Sfh9MuMwt2h8h2uMDE/HBQ06CptusphHOsbA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR15MB4720.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FFzq/m7d+phMSFd5djCZ6lbB3vL1uVg9l27M7Y2ppHCfIPJ5l37LVN4xeE?=
 =?iso-8859-1?Q?j/V2vOBWMbc4F1jnPTIlbTLLaK+vCX/awqRBYlxfDaim6JHtQEUKcFYTeT?=
 =?iso-8859-1?Q?9/v9DQwWeYNwdzYd+Dxzsv67ET9F4YIdDMjxM4gLSdYn893MK4IvlM/JhC?=
 =?iso-8859-1?Q?Qr+x+I89g2W68VBCO/qnein2SH+8XeElYwcmVbr12/H9F/PO+9Uby5YGUI?=
 =?iso-8859-1?Q?eFmV+XDMFDw55cMtIixRlJdPKoK05YGfi0tFbvSDt7C327S99OA3lClbRj?=
 =?iso-8859-1?Q?CMaswSDC6CoXBtzkAwmcCnuvM/47v9Wp6ryZ6P2z8KDbIeV0l3rEtsD13K?=
 =?iso-8859-1?Q?K8BJ32FWv0JOWmrqs2SlkZ70PJLoYVYGO7dOJ3JIJl2Z/5T1Z9XMOvLmlp?=
 =?iso-8859-1?Q?AaqXBkMjAJ1FV69JKrJsHRWtmwE62BQx2sfUwW/bHBiXoatqCQxBhJaAju?=
 =?iso-8859-1?Q?pX3TY2/UrK+onS0J972IR1m62QT7NP2pq2s5+YwSsmGVSUItGgROl2Ptg6?=
 =?iso-8859-1?Q?C7ucII9X38f/XhFNuRYflhXUxlD6kyGQjRDLHFfJdBa+eJF9QvUfoSY0Pn?=
 =?iso-8859-1?Q?V9jybDAZNb/W/aUtJGUbbMVosk/apbNuaFUoVYfRNPvCnsy2Cn7JH0cRH8?=
 =?iso-8859-1?Q?cjWFod+kxwCTrkqBJX1diCS+SZY6Uj76dal3Te+FV2j7d5ZjWIUZyUNQns?=
 =?iso-8859-1?Q?wuOyoWFjFfqrkMKCimTCyjB4UWWoNIknHxQEgvG3IYZkD1w3nXRtRFgAoB?=
 =?iso-8859-1?Q?NzhuA2LYj55btCU028ECY/wUdLa6iYXyotrK0KRR0Bhfl6N/C/fBm+DrMR?=
 =?iso-8859-1?Q?l0kzSDLOHW/cr6WFptTTAhiJyOmFfoDS9vLIwOpQw0c0JUXeq1HJvn7etM?=
 =?iso-8859-1?Q?8LOLbjyLf8kHiZSOiyTdC+CQ2Bub/YKd3FWMkvQa6oKZK8Q+khWXN/6HMs?=
 =?iso-8859-1?Q?66BUV86qeFcHHE4eHDMuQnr0j66IS+OMgUtJ9Hw80IxHZ+LOjTfi5b3FOT?=
 =?iso-8859-1?Q?k8BDVAXNOCzESvO4FKQeO8BTKbyQ/lSHvmkbFc9pA8NpgO9pGdma+UdgtD?=
 =?iso-8859-1?Q?LlP/Vxe/7dhAE8onDKiJ9TXqYj6ylyL4Ke4zE6T6e75CL6DAGB0F+UXAHa?=
 =?iso-8859-1?Q?67iSb2Y6yV0KDPsVeadTtQzdxrRv1nr0whBYpbW0rFRimRyMTKRhJxEuvu?=
 =?iso-8859-1?Q?g74Ba3gJBF4SipS4m/pb7fV+MxCDnPf6x3MTAvV7W65jg01rCMaJ+6MSl0?=
 =?iso-8859-1?Q?GWIl07nuHX2agmcen6WFTFiSEEsZnZQum0lzLCjTkisSLb0bIcDvmQY0mu?=
 =?iso-8859-1?Q?6/gk0a0OlZAYTQXHAIXTFa7W8wBAUtbA9uzcc5SqdUwVDR4aUyqUNUALr0?=
 =?iso-8859-1?Q?7ksLs5UZGOe+bFtyweh92IMk1/mL47gC5ah/BslkK3siP08bU7446JCe1F?=
 =?iso-8859-1?Q?rteXAlNdTi0CSSLJ00rZMGKJL9mSFJRoOcu0wcqhaJwJidP1aoXYPCFo4N?=
 =?iso-8859-1?Q?5+pVKsJtIFWg4sJEF5pXKJPD/KjZ5I3xSJEFXytz3VGuD4fPjeK5hbwV8O?=
 =?iso-8859-1?Q?KWvQz8W+A2AHKLiOihOygqC1QFIGdVsUorTad9+oTEdTTWZHMQ2JUE8XV9?=
 =?iso-8859-1?Q?95Xiu+9qhrU04=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH0PR15MB47206C425A62330C36C06780E1D72PH0PR15MB4720namp_"
MIME-Version: 1.0
X-OriginatorOrg: us.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB4720.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d56e876e-cf8a-4dea-50c9-08dc9654ad89
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 02:56:01.2439 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WPthbohNelqL65pDvkJF5lFfP2J6gCKHmO2QtTCCXYmA5ZWGgH+q97YXJ1ik1wSzeV1ZUck8WFRXfYT+0TfHPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR15MB6001
X-Proofpoint-ORIG-GUID: inc5GuopIkxW0BZ1j5c8Sac-Fa3YArQ2
X-Proofpoint-GUID: 4Hb7_LKx9_xscRYhgOXdJ0z8tlGxxGPS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_17,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 mlxlogscore=927
 phishscore=0 suspectscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270020
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@us.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_PH0PR15MB47206C425A62330C36C06780E1D72PH0PR15MB4720namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> In this commit Write a qtest pnv-spi-seeprom-test to check the
> SPI transactions between spi controller and seeprom device.
>
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> Acked-by: C=E9dric Le Goater <clg@redhat.com>

Reviewed-by: Caleb Schlossin <calebs@linux.vnet.ibm.com>

Thanks,
Caleb Schlossin
________________________________
From: Chalapathi V <chalapathi.v@linux.ibm.com>
Sent: Wednesday, June 26, 2024 4:05 AM
To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Cc: qemu-ppc@nongnu.org <qemu-ppc@nongnu.org>; fbarrat@linux.ibm.com <fbarr=
at@linux.ibm.com>; npiggin@gmail.com <npiggin@gmail.com>; clg@kaod.org <clg=
@kaod.org>; CALEB SCHLOSSIN <calebs@us.ibm.com>; Chalapathi V <Chalapathi.V=
@ibm.com>; chalapathi.v@linux.ibm.com <chalapathi.v@linux.ibm.com>; saif.ab=
rar@linux.ibm.com <saif.abrar@linux.ibm.com>; Dan Tan <dantan@us.ibm.com>; =
milesg@linux.ibm.com <milesg@linux.ibm.com>
Subject: [PATCH v5 6/6] tests/qtest: Add pnv-spi-seeprom qtest

In this commit Write a qtest pnv-spi-seeprom-test to check the
SPI transactions between spi controller and seeprom device.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Acked-by: C=E9dric Le Goater <clg@redhat.com>
---
 tests/qtest/pnv-spi-seeprom-test.c | 110 +++++++++++++++++++++++++++++
 tests/qtest/meson.build            |   1 +
 2 files changed, 111 insertions(+)
 create mode 100644 tests/qtest/pnv-spi-seeprom-test.c

diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-seepr=
om-test.c
new file mode 100644
index 0000000000..92bc8a11ae
--- /dev/null
+++ b/tests/qtest/pnv-spi-seeprom-test.c
@@ -0,0 +1,110 @@
+/*
+ * QTest testcase for PowerNV 10 Seeprom Communications
+ *
+ * Copyright (c) 2024, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <unistd.h>
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bswap.h"
+#include "hw/ssi/pnv_spi_regs.h"
+#include "pnv-xscom.h"
+
+#define FLASH_SIZE              (512 * 1024)
+#define SPIC2_XSCOM_BASE        0xc0040
+
+/* To transmit READ opcode and address */
+#define READ_OP_TDR_DATA        0x0300010000000000
+/*
+ * N1 shift - tx 4 bytes (transmit opcode and address)
+ * N2 shift - tx and rx 8 bytes.
+ */
+#define READ_OP_COUNTER_CONFIG  0x2040000000002b00
+/* SEQ_OP_SELECT_RESPONDER - N1 Shift - N2 Shift * 5 - SEQ_OP_STOP */
+#define READ_OP_SEQUENCER       0x1130404040404010
+
+/* To transmit WREN(Set Write Enable Latch in status0 register) opcode */
+#define WRITE_OP_WREN           0x0600000000000000
+/* To transmit WRITE opcode, address and data */
+#define WRITE_OP_TDR_DATA       0x0300010012345678
+/* N1 shift - tx 8 bytes (transmit opcode, address and data) */
+#define WRITE_OP_COUNTER_CONFIG 0x4000000000002000
+/* SEQ_OP_SELECT_RESPONDER - N1 Shift - SEQ_OP_STOP */
+#define WRITE_OP_SEQUENCER      0x1130100000000000
+
+static void pnv_spi_xscom_write(QTestState *qts, const PnvChip *chip,
+        uint32_t reg, uint64_t val)
+{
+    uint32_t pcba =3D SPIC2_XSCOM_BASE + reg;
+    qtest_writeq(qts, pnv_xscom_addr(chip, pcba), val);
+}
+
+static uint64_t pnv_spi_xscom_read(QTestState *qts, const PnvChip *chip,
+        uint32_t reg)
+{
+    uint32_t pcba =3D SPIC2_XSCOM_BASE + reg;
+    return qtest_readq(qts, pnv_xscom_addr(chip, pcba));
+}
+
+static void spi_seeprom_transaction(QTestState *qts, const PnvChip *chip)
+{
+    /* SPI transactions to SEEPROM to read from SEEPROM image */
+    pnv_spi_xscom_write(qts, chip, SPI_CTR_CFG_REG, READ_OP_COUNTER_CONFIG=
);
+    pnv_spi_xscom_write(qts, chip, SPI_SEQ_OP_REG, READ_OP_SEQUENCER);
+    pnv_spi_xscom_write(qts, chip, SPI_XMIT_DATA_REG, READ_OP_TDR_DATA);
+    pnv_spi_xscom_write(qts, chip, SPI_XMIT_DATA_REG, 0);
+    /* Read 5*8 bytes from SEEPROM at 0x100 */
+    uint64_t rdr_val =3D pnv_spi_xscom_read(qts, chip, SPI_RCV_DATA_REG);
+    g_test_message("RDR READ =3D 0x%lx", rdr_val);
+    rdr_val =3D pnv_spi_xscom_read(qts, chip, SPI_RCV_DATA_REG);
+    rdr_val =3D pnv_spi_xscom_read(qts, chip, SPI_RCV_DATA_REG);
+    rdr_val =3D pnv_spi_xscom_read(qts, chip, SPI_RCV_DATA_REG);
+    rdr_val =3D pnv_spi_xscom_read(qts, chip, SPI_RCV_DATA_REG);
+    g_test_message("RDR READ =3D 0x%lx", rdr_val);
+
+    /* SPI transactions to SEEPROM to write to SEEPROM image */
+    pnv_spi_xscom_write(qts, chip, SPI_CTR_CFG_REG, WRITE_OP_COUNTER_CONFI=
G);
+    /* Set Write Enable Latch bit of status0 register */
+    pnv_spi_xscom_write(qts, chip, SPI_SEQ_OP_REG, WRITE_OP_SEQUENCER);
+    pnv_spi_xscom_write(qts, chip, SPI_XMIT_DATA_REG, WRITE_OP_WREN);
+    /* write 8 bytes to SEEPROM at 0x100 */
+    pnv_spi_xscom_write(qts, chip, SPI_SEQ_OP_REG, WRITE_OP_SEQUENCER);
+    pnv_spi_xscom_write(qts, chip, SPI_XMIT_DATA_REG, WRITE_OP_TDR_DATA);
+}
+
+static void test_spi_seeprom(const void *data)
+{
+    const PnvChip *chip =3D data;
+    QTestState *qts =3D NULL;
+    g_autofree char *tmp_path =3D NULL;
+    int ret;
+    int fd;
+
+    /* Create a temporary raw image */
+    fd =3D g_file_open_tmp("qtest-seeprom-XXXXXX", &tmp_path, NULL);
+    g_assert(fd >=3D 0);
+    ret =3D ftruncate(fd, FLASH_SIZE);
+    g_assert(ret =3D=3D 0);
+    close(fd);
+
+    qts =3D qtest_initf("-m 2G -machine powernv10 -smp 2,cores=3D2,"
+                      "threads=3D1 -accel tcg,thread=3Dsingle -nographic "
+                      "-blockdev node-name=3Dpib_spic2,driver=3Dfile,"
+                      "filename=3D%s -device 25csm04,bus=3Dpnv-spi-bus.2,c=
s=3D0,"
+                      "drive=3Dpib_spic2", tmp_path);
+    spi_seeprom_transaction(qts, chip);
+    qtest_quit(qts);
+    unlink(tmp_path);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    char *tname =3D g_strdup_printf("pnv-xscom/spi-seeprom/%s",
+            pnv_chips[3].cpu_model);
+    qtest_add_data_func(tname, &pnv_chips[3], test_spi_seeprom);
+    g_free(tname);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 86293051dc..2fa98b2430 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -171,6 +171,7 @@ qtests_ppc64 =3D \
   qtests_ppc + \
   (config_all_devices.has_key('CONFIG_PSERIES') ? ['device-plug-test'] : [=
]) +               \
   (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-xscom-test'] : [])=
 +                 \
+  (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-spi-seeprom-test']=
 : []) +           \
   (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-host-i2c-test'] : =
[]) +              \
   (config_all_devices.has_key('CONFIG_PSERIES') ? ['rtas-test'] : []) +   =
                   \
   (slirp.found() ? ['pxe-test'] : []) +              \
--
2.39.3


--_000_PH0PR15MB47206C425A62330C36C06780E1D72PH0PR15MB4720namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Arial, Helvetica, sans-=
serif; font-size: 10pt; color: rgb(0, 0, 0);">
&gt; In this commit Write a qtest pnv-spi-seeprom-test to check the<br>
&gt; SPI transactions between spi controller and seeprom device.<br>
&gt;&nbsp;<br>
&gt; Signed-off-by: Chalapathi V &lt;chalapathi.v@linux.ibm.com&gt;<br>
&gt; Acked-by: C=E9dric Le Goater &lt;clg@redhat.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Arial, Helvetica, sans-=
serif; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
margin: 0px; font-family: Arial, Helvetica, sans-serif; font-size: 10pt; co=
lor: rgb(0, 0, 0);">
Reviewed-by: Caleb Schlossin &lt;calebs@linux.vnet.ibm.com&gt;</div>
<div style=3D"text-align: left; text-indent: 0px; margin: 0px; font-family:=
 Arial, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"margin: 0px; font-family: Arial, Helvetica, sans-serif; font-=
size: 10pt; color: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof" style=3D"margin: 0px; font-family: Arial, Hel=
vetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);">
Caleb Schlossin</div>
<div id=3D"Signature"></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chalapathi V &lt;chal=
apathi.v@linux.ibm.com&gt;<br>
<b>Sent:</b> Wednesday, June 26, 2024 4:05 AM<br>
<b>To:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Cc:</b> qemu-ppc@nongnu.org &lt;qemu-ppc@nongnu.org&gt;; fbarrat@linux.i=
bm.com &lt;fbarrat@linux.ibm.com&gt;; npiggin@gmail.com &lt;npiggin@gmail.c=
om&gt;; clg@kaod.org &lt;clg@kaod.org&gt;; CALEB SCHLOSSIN &lt;calebs@us.ib=
m.com&gt;; Chalapathi V &lt;Chalapathi.V@ibm.com&gt;; chalapathi.v@linux.ib=
m.com
 &lt;chalapathi.v@linux.ibm.com&gt;; saif.abrar@linux.ibm.com &lt;saif.abra=
r@linux.ibm.com&gt;; Dan Tan &lt;dantan@us.ibm.com&gt;; milesg@linux.ibm.co=
m &lt;milesg@linux.ibm.com&gt;<br>
<b>Subject:</b> [PATCH v5 6/6] tests/qtest: Add pnv-spi-seeprom qtest</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">In this commit Write a qtest pnv-spi-seeprom-test =
to check the<br>
SPI transactions between spi controller and seeprom device.<br>
<br>
Signed-off-by: Chalapathi V &lt;chalapathi.v@linux.ibm.com&gt;<br>
Acked-by: C=E9dric Le Goater &lt;clg@redhat.com&gt;<br>
---<br>
&nbsp;tests/qtest/pnv-spi-seeprom-test.c | 110 ++++++++++++++++++++++++++++=
+<br>
&nbsp;tests/qtest/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +<br>
&nbsp;2 files changed, 111 insertions(+)<br>
&nbsp;create mode 100644 tests/qtest/pnv-spi-seeprom-test.c<br>
<br>
diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-seepr=
om-test.c<br>
new file mode 100644<br>
index 0000000000..92bc8a11ae<br>
--- /dev/null<br>
+++ b/tests/qtest/pnv-spi-seeprom-test.c<br>
@@ -0,0 +1,110 @@<br>
+/*<br>
+ * QTest testcase for PowerNV 10 Seeprom Communications<br>
+ *<br>
+ * Copyright (c) 2024, IBM Corporation.<br>
+ *<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+#include &lt;unistd.h&gt;<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;libqtest.h&quot;<br>
+#include &quot;qemu/bswap.h&quot;<br>
+#include &quot;hw/ssi/pnv_spi_regs.h&quot;<br>
+#include &quot;pnv-xscom.h&quot;<br>
+<br>
+#define FLASH_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; (512 * 1024)<br>
+#define SPIC2_XSCOM_BASE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xc0040=
<br>
+<br>
+/* To transmit READ opcode and address */<br>
+#define READ_OP_TDR_DATA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x03000=
10000000000<br>
+/*<br>
+ * N1 shift - tx 4 bytes (transmit opcode and address)<br>
+ * N2 shift - tx and rx 8 bytes.<br>
+ */<br>
+#define READ_OP_COUNTER_CONFIG&nbsp; 0x2040000000002b00<br>
+/* SEQ_OP_SELECT_RESPONDER - N1 Shift - N2 Shift * 5 - SEQ_OP_STOP */<br>
+#define READ_OP_SEQUENCER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1130404040=
404010<br>
+<br>
+/* To transmit WREN(Set Write Enable Latch in status0 register) opcode */<=
br>
+#define WRITE_OP_WREN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0x0600000000000000<br>
+/* To transmit WRITE opcode, address and data */<br>
+#define WRITE_OP_TDR_DATA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0300010012=
345678<br>
+/* N1 shift - tx 8 bytes (transmit opcode, address and data) */<br>
+#define WRITE_OP_COUNTER_CONFIG 0x4000000000002000<br>
+/* SEQ_OP_SELECT_RESPONDER - N1 Shift - SEQ_OP_STOP */<br>
+#define WRITE_OP_SEQUENCER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x113010000000000=
0<br>
+<br>
+static void pnv_spi_xscom_write(QTestState *qts, const PnvChip *chip,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg, uint64_t val)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; uint32_t pcba =3D SPIC2_XSCOM_BASE + reg;<br>
+&nbsp;&nbsp;&nbsp; qtest_writeq(qts, pnv_xscom_addr(chip, pcba), val);<br>
+}<br>
+<br>
+static uint64_t pnv_spi_xscom_read(QTestState *qts, const PnvChip *chip,<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; uint32_t pcba =3D SPIC2_XSCOM_BASE + reg;<br>
+&nbsp;&nbsp;&nbsp; return qtest_readq(qts, pnv_xscom_addr(chip, pcba));<br=
>
+}<br>
+<br>
+static void spi_seeprom_transaction(QTestState *qts, const PnvChip *chip)<=
br>
+{<br>
+&nbsp;&nbsp;&nbsp; /* SPI transactions to SEEPROM to read from SEEPROM ima=
ge */<br>
+&nbsp;&nbsp;&nbsp; pnv_spi_xscom_write(qts, chip, SPI_CTR_CFG_REG, READ_OP=
_COUNTER_CONFIG);<br>
+&nbsp;&nbsp;&nbsp; pnv_spi_xscom_write(qts, chip, SPI_SEQ_OP_REG, READ_OP_=
SEQUENCER);<br>
+&nbsp;&nbsp;&nbsp; pnv_spi_xscom_write(qts, chip, SPI_XMIT_DATA_REG, READ_=
OP_TDR_DATA);<br>
+&nbsp;&nbsp;&nbsp; pnv_spi_xscom_write(qts, chip, SPI_XMIT_DATA_REG, 0);<b=
r>
+&nbsp;&nbsp;&nbsp; /* Read 5*8 bytes from SEEPROM at 0x100 */<br>
+&nbsp;&nbsp;&nbsp; uint64_t rdr_val =3D pnv_spi_xscom_read(qts, chip, SPI_=
RCV_DATA_REG);<br>
+&nbsp;&nbsp;&nbsp; g_test_message(&quot;RDR READ =3D 0x%lx&quot;, rdr_val)=
;<br>
+&nbsp;&nbsp;&nbsp; rdr_val =3D pnv_spi_xscom_read(qts, chip, SPI_RCV_DATA_=
REG);<br>
+&nbsp;&nbsp;&nbsp; rdr_val =3D pnv_spi_xscom_read(qts, chip, SPI_RCV_DATA_=
REG);<br>
+&nbsp;&nbsp;&nbsp; rdr_val =3D pnv_spi_xscom_read(qts, chip, SPI_RCV_DATA_=
REG);<br>
+&nbsp;&nbsp;&nbsp; rdr_val =3D pnv_spi_xscom_read(qts, chip, SPI_RCV_DATA_=
REG);<br>
+&nbsp;&nbsp;&nbsp; g_test_message(&quot;RDR READ =3D 0x%lx&quot;, rdr_val)=
;<br>
+<br>
+&nbsp;&nbsp;&nbsp; /* SPI transactions to SEEPROM to write to SEEPROM imag=
e */<br>
+&nbsp;&nbsp;&nbsp; pnv_spi_xscom_write(qts, chip, SPI_CTR_CFG_REG, WRITE_O=
P_COUNTER_CONFIG);<br>
+&nbsp;&nbsp;&nbsp; /* Set Write Enable Latch bit of status0 register */<br=
>
+&nbsp;&nbsp;&nbsp; pnv_spi_xscom_write(qts, chip, SPI_SEQ_OP_REG, WRITE_OP=
_SEQUENCER);<br>
+&nbsp;&nbsp;&nbsp; pnv_spi_xscom_write(qts, chip, SPI_XMIT_DATA_REG, WRITE=
_OP_WREN);<br>
+&nbsp;&nbsp;&nbsp; /* write 8 bytes to SEEPROM at 0x100 */<br>
+&nbsp;&nbsp;&nbsp; pnv_spi_xscom_write(qts, chip, SPI_SEQ_OP_REG, WRITE_OP=
_SEQUENCER);<br>
+&nbsp;&nbsp;&nbsp; pnv_spi_xscom_write(qts, chip, SPI_XMIT_DATA_REG, WRITE=
_OP_TDR_DATA);<br>
+}<br>
+<br>
+static void test_spi_seeprom(const void *data)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; const PnvChip *chip =3D data;<br>
+&nbsp;&nbsp;&nbsp; QTestState *qts =3D NULL;<br>
+&nbsp;&nbsp;&nbsp; g_autofree char *tmp_path =3D NULL;<br>
+&nbsp;&nbsp;&nbsp; int ret;<br>
+&nbsp;&nbsp;&nbsp; int fd;<br>
+<br>
+&nbsp;&nbsp;&nbsp; /* Create a temporary raw image */<br>
+&nbsp;&nbsp;&nbsp; fd =3D g_file_open_tmp(&quot;qtest-seeprom-XXXXXX&quot;=
, &amp;tmp_path, NULL);<br>
+&nbsp;&nbsp;&nbsp; g_assert(fd &gt;=3D 0);<br>
+&nbsp;&nbsp;&nbsp; ret =3D ftruncate(fd, FLASH_SIZE);<br>
+&nbsp;&nbsp;&nbsp; g_assert(ret =3D=3D 0);<br>
+&nbsp;&nbsp;&nbsp; close(fd);<br>
+<br>
+&nbsp;&nbsp;&nbsp; qts =3D qtest_initf(&quot;-m 2G -machine powernv10 -smp=
 2,cores=3D2,&quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;threads=3D1 -acc=
el tcg,thread=3Dsingle -nographic &quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;-blockdev node-n=
ame=3Dpib_spic2,driver=3Dfile,&quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;filename=3D%s -d=
evice 25csm04,bus=3Dpnv-spi-bus.2,cs=3D0,&quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;drive=3Dpib_spic=
2&quot;, tmp_path);<br>
+&nbsp;&nbsp;&nbsp; spi_seeprom_transaction(qts, chip);<br>
+&nbsp;&nbsp;&nbsp; qtest_quit(qts);<br>
+&nbsp;&nbsp;&nbsp; unlink(tmp_path);<br>
+}<br>
+<br>
+int main(int argc, char **argv)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; g_test_init(&amp;argc, &amp;argv, NULL);<br>
+&nbsp;&nbsp;&nbsp; char *tname =3D g_strdup_printf(&quot;pnv-xscom/spi-see=
prom/%s&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pnv_chi=
ps[3].cpu_model);<br>
+&nbsp;&nbsp;&nbsp; qtest_add_data_func(tname, &amp;pnv_chips[3], test_spi_=
seeprom);<br>
+&nbsp;&nbsp;&nbsp; g_free(tname);<br>
+&nbsp;&nbsp;&nbsp; return g_test_run();<br>
+}<br>
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build<br>
index 86293051dc..2fa98b2430 100644<br>
--- a/tests/qtest/meson.build<br>
+++ b/tests/qtest/meson.build<br>
@@ -171,6 +171,7 @@ qtests_ppc64 =3D \<br>
&nbsp;&nbsp; qtests_ppc + \<br>
&nbsp;&nbsp; (config_all_devices.has_key('CONFIG_PSERIES') ? ['device-plug-=
test'] : []) +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp; (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-xscom-te=
st'] : []) +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp; (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-spi-seeprom-t=
est'] : []) +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \=
<br>
&nbsp;&nbsp; (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-host-i2c=
-test'] : []) +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp; (config_all_devices.has_key('CONFIG_PSERIES') ? ['rtas-test'] =
: []) +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp; (slirp.found() ? ['pxe-test'] : []) +&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
-- <br>
2.39.3<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_PH0PR15MB47206C425A62330C36C06780E1D72PH0PR15MB4720namp_--

