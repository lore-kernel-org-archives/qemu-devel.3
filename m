Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8F1107760E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 19:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2wPp-0007Nj-Hl; Wed, 18 Mar 2026 15:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saarnio@qti.qualcomm.com>)
 id 1w2wPV-0007MW-U3; Wed, 18 Mar 2026 15:18:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saarnio@qti.qualcomm.com>)
 id 1w2wPS-00004q-Q9; Wed, 18 Mar 2026 15:18:29 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62IFgowh1788931; Wed, 18 Mar 2026 19:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:message-id:mime-version:subject:to; s=
 qcppdkim1; bh=crT9tmzuCm/zn9DeYRv2dyL5g4dITVeXkI5pE1Xqp7c=; b=n5
 tBDzjVtvhRlXHv3rMrIzkk4Lm66ioF/6JD1kLP9SG1bAo0x/dIAYZGJoFWSQcIul
 KcNKTF/VDvIL+f1zydTTo2d/pag7iiR0SEBrLnip3l49cMoH7b22+j1SmSTczSyC
 WkSCZFJ6nFvf/6UWzvz5CKk3J24VZBWWdFJwSThtIWmKwU9A4954A6Mtlt2BNRgU
 xAi1SMxNjf0GmFpG2tNNpxQIOSwSPXhilPT4dL1Q7i8k7u0OOQhWGrNLtqDpIxhL
 fqvZ0qIjxPPZPoGswoAc9cuy1xrYiWzLQY6/QEHDMLMc8ZhE729Gqyz6AWorqkg0
 gmVSYx817iir3R6P1fpg==
Received: from bn1pr07cu003.outbound.protection.outlook.com
 (mail-bn1pr07cu00307.outbound.protection.outlook.com [40.93.12.7])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cykqeusk8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 18 Mar 2026 19:18:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sa59vSOTzU89aPZTW0gw+SeU83TiEHUiLNilSCLhs4/iAeyKPx4Xjebi2wtvkANJc4539KF69tK10e5n00NWkBCLBveFGtJ57YXvIV2vEpQqZ/MZkiO+gGTHgjy8TlsPf/hDk2xnF44nDFYkm7BsyPmLpslKo3RMIkLBAI1IQUM5s8biy7V3ubV03zc0llXv5N7/7+OjShBL6WmstIpsOr0+weP62JY2UaRZS+1xjsm1p0RXZPY1CTSNK2r9tL+cfBBEzbR7Nc6BzSnGuP5I8C0AB3aEfxNAv115YeJIvSgooCOCjcxZ/wrG9DGMSehhV2iZHv1nTFh3Du+7BNSsLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crT9tmzuCm/zn9DeYRv2dyL5g4dITVeXkI5pE1Xqp7c=;
 b=hfbCtx8kHOmegZHwIw+/CySyuKjP83bBbjuYIKDoZnL0qz7fap3jXEgRT/ZjRgjaG06wdaR/ee13dcQSxGrycu49CCaPKSPODHKvc2N93LQE/N5xyzkD1APqEfxAmUSkt2xsI+Ac5zKdp3+XMMqp9PlTRXFZPV1wQeKzN+5zz290KcbDNqEaLBK5lzKtq8PPlp63T4kZLA8rlKc9LWawqQyaoNcpKGYvgg/C0U3zUjqXLsLW6ZNwBp4wuelOTuIdSiDxJn/PgyQsKlkn05YbQpyyLmSsUsKYvqEh6MCKJKOaoEbTfXrFU0nCjmNxB6GRoGx0XsoY318amO7f8urCMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from MN2PR02MB6622.namprd02.prod.outlook.com (2603:10b6:208:1df::21)
 by PH7PR02MB10158.namprd02.prod.outlook.com (2603:10b6:510:2ef::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 19:18:20 +0000
Received: from MN2PR02MB6622.namprd02.prod.outlook.com
 ([fe80::6dd2:4e81:dacc:f239]) by MN2PR02MB6622.namprd02.prod.outlook.com
 ([fe80::6dd2:4e81:dacc:f239%4]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 19:18:20 +0000
From: Steve Aarnio <saarnio@qti.qualcomm.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: [PATCH] meson.build: Add --enable-use-pdb option
Thread-Topic: [PATCH] meson.build: Add --enable-use-pdb option
Thread-Index: AQHctwlOUrDdM9odpUWgzwqG2/agng==
Date: Wed, 18 Mar 2026 19:18:20 +0000
Message-ID: <MN2PR02MB6622718572E2A2B5E4EE3C039B4EA@MN2PR02MB6622.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6622:EE_|PH7PR02MB10158:EE_
x-ms-office365-filtering-correlation-id: 37773954-d4a2-42ea-e1f0-08de85231dee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|38070700021|8096899003;
x-microsoft-antispam-message-info: Q9ekXXQ68qrvBiXE/E6yuBrFrvmd6lKLFuc9KGsaN7OMsiTx5y0u1M6mSnoKNO8Laarc9dcR5LUnGItnp43k1Gcp2Q/yS3a5wNMlMapznFabwW7b4DpLKBgMwKdFee72JhHJsAnfXnIlI4a6PlIThHCln0hIyMii0TPKIMUpfFjIlB7LUr/S7wN4m1I4a1Y0RdkfiCRPTx5O7WCLiO7jk2Rmiir4oEi6Kt7seOLQRUBhaG2h2FM21bb1Veot0Q/Zpiu6HP6yKesFd9hoKVWtURP9l6Wpu3DQ0k82kxQZmWYs1oL8P3r+sBf18TXZ8gJpvpfz3Yfd3021/E5bU2WoZ1KEZLewf/ZvlYrWyrjDH/0a9tziU2N2lXyKhmmcYsxG7r+FQOhVvT1rRQp8gnt1/f15z5VjFNMAOG9Q4keeH1zXlHO41mm5Nie2O8RgoGsDkHlK6mG9GPsAlWcn8kOXfA4gcjk8m58zWFvRBAiv59SlTo73v5A3QH/c0tSeFH6KgQFQ4C2dEbLgjb8NitohYn4RG7NN2TN+43dDhPmclbakc7bgmQFKQO1QWFgzkf03tyHCpz/UG9tbpXZ51mqYR38zldyx//DD9T2l0xU/f4h1BCg9IAj1KSSuZCTqqZsye0kjHH7tvJ45rguqgSExlmXDUE4w5qM0b9Te9NiTaRDd3V79HAumQGj71JlMmmuHc2e4nzMOVJr/y/nPUjFWV7su/LjfDbM/X0Tgi2vDL29sviVFyByJYRe6Ja7JZmt7FUy5lEhgdaVRvDe0YdcfbJWETTss3i4USnwDdnlSFFo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB6622.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(38070700021)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JQP1Sy1apRK9FAcRjea/Fwk4chU1QgZSJ63BPA6d7WniGS/yL/pX1rV12u?=
 =?iso-8859-1?Q?BnMXc7cseNxMrpVKQEYan5VnTsSNOEESNIxyFElnTcd13T+uhk4WVLRkf3?=
 =?iso-8859-1?Q?Wfn80Dto05xwqLD6+s+7nau2GCohETHlvJ2OTKXThFJzwFRSCOUtMr4WmQ?=
 =?iso-8859-1?Q?X2Z79+UpiwTbOzjLPZGJGHD0nEl8pZEo53FTjbdKH99Xotw90ncTmLgUzI?=
 =?iso-8859-1?Q?9+TvpBzT5YUlEmqphqlEKUaJV/EFchntvNP963Kmnr4DzeCiSwthhf0o3Q?=
 =?iso-8859-1?Q?6mBIOOdoLHssZngJ0OXfDafH9P+7bG3jsL0o1+qypxv1dx9+J/IiJNp56a?=
 =?iso-8859-1?Q?2zgY/2ad6shrqiNeChPv33LjR/kTG4bsIdS4Z43PNtP9A6YOcfb1CORUq5?=
 =?iso-8859-1?Q?rg+g26mebiFtmvuZs5/VmYCqQqCtLynASv7yHcjWDku63KXBviwmJKckjR?=
 =?iso-8859-1?Q?WsIdWDbmXwegDP7N+Q5JjZ6lV5tDRu7kqpisTIsRjvQZSZ/NROp9xn8Yd5?=
 =?iso-8859-1?Q?jYkHkiH8yxhxGbO82otEzEwcMJOeKli5hCqJWKPcPbSY5tvln0ieQNep6i?=
 =?iso-8859-1?Q?PYhaQjGPK5AtbgFFGbTLvQCk/sabLj9i2Wqcse6RQQP0PsK2ROypPJjmlT?=
 =?iso-8859-1?Q?wBP4cJvXNUv70GbmitxP/otdgiQTgFQXY8iGON9kkGNSrSjZjbHKQqgLvW?=
 =?iso-8859-1?Q?I4vfLNZvjuu7A5revlHhzNRK+fGWvCrxIrMNAXx5cWIS9h12IZcztjXPFK?=
 =?iso-8859-1?Q?mv7vAEOk+djSlTRcUYZFqeoYtWcnGiPqZIm7K3A7n+W6SJV1vvq+MfLNyI?=
 =?iso-8859-1?Q?NgHKwFbdwk0oFKiEdIM3ccKcheyX+yTEjY0jPemLAXRpB1kg7sFrJYJCbC?=
 =?iso-8859-1?Q?iGFapHeut8obyujCfQcUE1veWLwolXV0VveaJ+9skFuLuwxVh7i4vJ9SJ+?=
 =?iso-8859-1?Q?2lqgGh/hfUwbb0ezNnl+THktarmOdoeIn8Pm7RZlLqqWm+6unOPXFT0KHB?=
 =?iso-8859-1?Q?3yIxDfCtSewa5FEc+3ioDNPJ4KS6oGom6e0pxlFqgFqcFtXKI9B5oJRMim?=
 =?iso-8859-1?Q?pve+GlQkSVjCOdikffUrTvobdRjc8aLVoZU/lBS2iViWAfZxGgWG2S2e0G?=
 =?iso-8859-1?Q?assL+GOKFy9Xtf+5eM2pNL708lfVQpUB9JreU2YXEGlerdH2tO9/HRJVsf?=
 =?iso-8859-1?Q?JMKIpdGghD9ofRFNSRXjhT6z6evgElr3+hjTWw5c6PzBNR9zYtztL5jPjc?=
 =?iso-8859-1?Q?ZgDwtkIcwm1Z8YyXPhaN2WyP3Mo2oN4mcvIffJ2cySZI6jk5qxypV33Z3n?=
 =?iso-8859-1?Q?Cm06kEPfptIcZyIbtDL+zGEjuzIYw7ZzPVKPP9MKVW6nphClmTPlmk+H5f?=
 =?iso-8859-1?Q?5r6QQRJI65PKhLSIPEYMFsMxVUFsHOG6TS+Fpdl55ogHShnqDZfwC60w6a?=
 =?iso-8859-1?Q?xE4bGZ3ZPG1MJpLWknUid9H/03PTUWe4YpTcE8YZ38eh7J18yWx79uCnBf?=
 =?iso-8859-1?Q?3SGLI710qyBESwMjp6gCQyX4q5IDHLSN6mBJw7Ad6GFTqt6AvELfDKPiA9?=
 =?iso-8859-1?Q?mnCYht3kXjTapv7QESyw7BTb8e+qTAjZrhK50/4bNeVEw8GFjIDC/V+92Y?=
 =?iso-8859-1?Q?zkOU0wLdL2fKJ+xpJ+rVlwd0b9mUnlfjryjCbALfZ0qR+zS44i0K5h2By9?=
 =?iso-8859-1?Q?CjUdKjVzPlcJ0PrHzL4VvTywKo5wEepB14d+a2dAeG5LQFae+qjArju8XG?=
 =?iso-8859-1?Q?5Joo1pNWLx8tYLwQ+e1SncHavj1RF0AUWPjAiCim2kVDiGV43i+lKFJGI8?=
 =?iso-8859-1?Q?9l7IgdUj4w=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MN2PR02MB6622718572E2A2B5E4EE3C039B4EAMN2PR02MB6622namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: u5RR4Os6eGC6L3m2gmUvCAN9U3ytm84riHKgNkJ/on8GaSl9Wqkv/1PRzK6I9pAlU6iTOE9HqNftq8OXXxGgr7TowYJ2zEPmcH9y76ZnxbGEIvpuMujrQ004vcbJStLrcYBuVfHvvwAVECFE+is7J0tb52l5zJszkhOS1okgpJ0iwn5noNwwf6sGc8vuKq5bqfPXvGWkfUzWd+xVzXR8LSPH4stOCpQotf/LPMPCMDMvpRiN8fvh/QCAGVCf24VI3g5QtirsajG8LOo9O/xrdLkuNGNk+LDntFQGBYWUjDWFkUqKDsGMjWXVqtradUUqtcgh6bUxFHPp1dGUh9/RNQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wV7j5fAZLOb1qkyd2zqMC+XR2zTJTbIKz8EqxuqbKndlI+QkXT/Ks9VWOw0nJIvGpHDuth0pEm2/VS0QmZ0QOkjg4jaQaeY67qZO4plFKj0UYk+P4/jR2NfajIpZTd0mQL65IA0gaL27ZbOfbi7rQBKe6WukqS3H5Ps/GuHW0BpZwpFfqYstoFebye/QeYv5oMWvtyPhlmtNPbTfPiqYjWV4u66oIGOAXoJ6FHZERYn4QcFp0iIJucsi8BiwOxUIFvinAFCS7OAmhCd9WogUx5LQL5h/7qZ5+QoM4OurcOZV2+R5xNv8cnah9Cax0J+GNcO9lyKJt2J+F5nOYnzDS5yEyC1GdKAXTXPg53C1/+9sUuyAa/qY0DjnN0HkZLZAOEfKZyUljUo+ePr3tZXo+BhfsUFsBCZ+idKARu9iYVVLvXs6/mataygr2P8BUhitxFBJ8Bh3D+xuizeWwiRIL4EOiakEAI6yGeNW9KYLi21tKFnVf7DbJJgt1YIoZBkEcWrCNIJnSt1e+g8DFoHB7ZbmAAu74X5vV8skzSkqQ3d/0JPlJISVOIb5twAifrjrZFmszYyM2oPqmSGg+DJP/zIldpsd1MKCiJTRf5JG6wZ6CdU1djvjvd858k7N23+s
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6622.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37773954-d4a2-42ea-e1f0-08de85231dee
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 19:18:20.5413 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QP13LQJtWDLXlNGPRdt7WTKgDu4raTHti5H2vWnzY4GdBSfgChNHCs3ocBJtj0k2hYyvomHkQh6wV0NDypnSfEac1WDtsl7hHJqbmz1Gawk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB10158
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDE2NSBTYWx0ZWRfX66ucIJQDC+r9
 JPRXdVMT6HE8kcaUPEbvelggfBQFt0cGhhGkCTDu4b3vp/PwK2F6AfZLwf5qn2Qfzls9XM5j60T
 0BmumaSRKGHpZkorUcu4FcViwmDycjHi1zeeJTgRel1zW6gJBMWhB1/yCBXnynVS4f7hLHAVVBt
 RkluDUX3EOIhjOZntwsp5zuSA2KS6nJ2LR6gbyaz7pp94fax1X3TDiTgvgfAE049BPBkj+PyXyL
 r4XuYQj2jk9HJU1+WQPI6KIA3uqROR/glCDEovm74dcdJj6SlIu0/4erVRdSeDUlJ1nddDTOnzE
 +LhW30bkzhkN8pXm52LIIJXsOER2c00MAr5U1BVMGrjVqjtTAxvnM4KlrtNiICZEI1Hi3rWCIOW
 jc2aKHEbkIHGSp6ibuFXyBZlylUDPLELYzIZGb1DnBLHpkSZcCeWY4aFEVuT6vbOJKCVFOSObC/
 Kn2S68dXYeW5K2f/2Zw==
X-Authority-Analysis: v=2.4 cv=Cd4FJbrl c=1 sm=1 tr=0 ts=69bafa80 cx=c_pps
 a=EaDl3aPh6j9cByxWTcQcVQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=NVi2nPTPkhjdRQwViucA:9 a=wPNLvfGTeEIA:10
 a=0Zm8o7c_cY3EVxrlXAQA:9 a=5wYiQ0IyWdyovKME:21 a=frz4AuCg-hUA:10
 a=_W_S_7VecoQA:10
X-Proofpoint-ORIG-GUID: hUV2iOA5uAZgF061QLqvagRQszWANk7X
X-Proofpoint-GUID: hUV2iOA5uAZgF061QLqvagRQszWANk7X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180165
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=saarnio@qti.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--_000_MN2PR02MB6622718572E2A2B5E4EE3C039B4EAMN2PR02MB6622namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

This option will (attempt to) modify the QEMU compile and link flags to
emit PDB symbol files rather than the standard (DWARF?) symbol output
from gcc/clang.

This enables using native Windows debug tools (Windbg/Visual Studio) for
debugging QEMU.

Signed-off-by: Steve Aarnio <saarnio@qti.qualcomm.com>
---
 meson.build       | 5 +++++
 meson_options.txt | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/meson.build b/meson.build
index d7c4095b39..d27581e0c2 100644
--- a/meson.build
+++ b/meson.build
@@ -692,6 +692,11 @@ endif

 qemu_common_flags +=3D hardening_flags

+if get_option('debug') and get_option('use_pdb')
+  qemu_common_flags +=3D cc.get_supported_arguments('-g','-gcodeview','-gc=
olumn-info','-fno-omit-frame-pointer')
+  qemu_ldflags +=3D cc.get_supported_link_arguments('-g','-Wl,--pdb=3D')
+endif
+
 # Collect warning flags we want to set, sorted alphabetically
 warn_flags =3D [
   # First enable interesting warnings
diff --git a/meson_options.txt b/meson_options.txt
index 31d5916cfc..b1f3250d5c 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -372,6 +372,8 @@ option('debug_stack_usage', type: 'boolean', value: fal=
se,
        description: 'measure coroutine stack usage')
 option('qom_cast_debug', type: 'boolean', value: true,
        description: 'cast debugging support')
+option('use_pdb', type: 'boolean', value: false,
+       description: 'use pdb symbol format on debug windows builds')
 option('slirp_smbd', type : 'feature', value : 'auto',
        description: 'use smbd (at path --smbd=3D*) in slirp networking')

--
2.53.0


--_000_MN2PR02MB6622718572E2A2B5E4EE3C039B4EAMN2PR02MB6622namp_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
This option will (attempt to) modify the QEMU compile and link flags to</di=
v>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
emit PDB symbol files rather than the standard (DWARF?) symbol output</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
from gcc/clang.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
This enables using native Windows debug tools (Windbg/Visual Studio) for</d=
iv>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
debugging QEMU.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Signed-off-by: Steve Aarnio &lt;saarnio@qti.qualcomm.com&gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
---</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;meson.build &nbsp; &nbsp; &nbsp; | 5 +++++</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;meson_options.txt | 2 ++</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;2 files changed, 7 insertions(+)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
diff --git a/meson.build b/meson.build</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
index d7c4095b39..d27581e0c2 100644</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
--- a/meson.build</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+++ b/meson.build</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
@@ -692,6 +692,11 @@ endif</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;qemu_common_flags +=3D hardening_flags</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+if get_option('debug') and get_option('use_pdb')</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp;qemu_common_flags +=3D cc.get_supported_arguments('-g','-gcodeview'=
,'-gcolumn-info','-fno-omit-frame-pointer')</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp;qemu_ldflags +=3D cc.get_supported_link_arguments('-g','-Wl,--pdb=
=3D')</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+endif</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;# Collect warning flags we want to set, sorted alphabetically</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;warn_flags =3D [</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp;# First enable interesting warnings</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
diff --git a/meson_options.txt b/meson_options.txt</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
index 31d5916cfc..b1f3250d5c 100644</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
--- a/meson_options.txt</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+++ b/meson_options.txt</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
@@ -372,6 +372,8 @@ option('debug_stack_usage', type: 'boolean', value: fal=
se,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; description: 'measure coroutine stack usage')</=
div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;option('qom_cast_debug', type: 'boolean', value: true,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; description: 'cast debugging support')</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+option('use_pdb', type: 'boolean', value: false,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; description: 'use pdb symbol format on debug windows=
 builds')</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;option('slirp_smbd', type : 'feature', value : 'auto',</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; description: 'use smbd (at path --smbd=3D*) in =
slirp networking')</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
--&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
2.53.0</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
</body>
</html>

--_000_MN2PR02MB6622718572E2A2B5E4EE3C039B4EAMN2PR02MB6622namp_--

