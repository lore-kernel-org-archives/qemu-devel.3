Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBE1C7EE2A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 17:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVCgF-000637-1Z; Fri, 27 Jun 2025 13:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yunpeng.yang@nutanix.com>)
 id 1uVCeS-0005hL-EK
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 13:14:12 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yunpeng.yang@nutanix.com>)
 id 1uVCeP-0000Mo-Ne
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 13:14:12 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RBLW30023185;
 Fri, 27 Jun 2025 10:13:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:message-id:mime-version:subject:to; s=
 proofpoint20171006; bh=nYSSK+X9c2IDxQLR6TMR93S0r68m0Nt+zBHtr7eCL
 xg=; b=zVvlbRbMfwE2rlzOtxPw93/PdBvdeewlE4bBKzry29ql3PUsB+1KsNRdd
 nXf5Tt3ULpwWNbCMo+LFMRyFgpGh3LVHNa+YzNsY/ddFtduYkueglEEVy21Ed3NA
 cI/ifsFymzi5XOo+p+8H7X1RN1aQT/w+VwOZEYJCTWnkwyMis2zPTcwA+M9QLuCD
 RuIrl7D5GRreCUwXy3DI+L3lHYY+ZecEo30dWQxKjhLnMOhpL/4RPmpXQjx5cR0g
 cQGVeUFSwXlevefTqJG0pEqtNEizQcke9EeWTnZSdkjq8YkTOO+A5kEOU8cEn2Aa
 dJ/QTwEwIXMYjfSCpXaAvSAgKgFFA==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2111.outbound.protection.outlook.com [40.107.220.111])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47dva0pu77-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Jun 2025 10:13:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMVxlzvpKWjMMLMuIqjKdXJ0xXy1k1xQi+QdHszsRXwiQotFzjwUFI/4PPQKE6AjwoWqMZYF0exT+LQ5QU50ZT2hAeamW3rEZVvp0wnKmLp+r62gd3MfQyGvlDhABFf4ucC2wH+c49nmEa58qvrX8Tspb1Y1+kh+yaOXdv0KJav+8GlFbx/s86VwpKoprO6hbDdm+Guaz8KDtUBnhWoLDqbOiwBxkPXy0meoVzIemKbrHhFvBd98cGQg2xVhrJU6Fcy55u6A2oLz2muGcmWP47SOWUx7UsQeGjOzoMa/pagyaE4poqxu5AmWSLbb2wVLgCIGyzunlgRNB7bg0xMOdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYSSK+X9c2IDxQLR6TMR93S0r68m0Nt+zBHtr7eCLxg=;
 b=e8nwMVTD98cktNw/QGicbytbiUqhpIoUSsFJ8PWt8f3f0FYptAoyfj+NH8P+kzcMAZAO3DxtfiHpt3q/Oqk23kX5HR8/NU+3Rb0tW9/2gqvFSQWKphMh/hD+vVmR/a3BTyjE8YuozHrlzWa5Vm+PsmwvWbX1YXSZTRCH0pEroXoeYdZlgldWgI0EwvZabDPxJW4ZajYNpSCJj4vaco/pcDGNW1w1wpqywjEEKcOlCH1pzb2/4An1bKGUZ5CGewGM3O4A0EsvtYujJUqf76oIjRTSj9ci89JdqfRxfDeYd0d22IK3/wWChk5l6T+vqjYMhFc6NSmu1cUfemPMrRYBKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYSSK+X9c2IDxQLR6TMR93S0r68m0Nt+zBHtr7eCLxg=;
 b=WZM+YRiGgUEZejtw7boRIW88YYnGSmF7ljR1Og4xY1ybRnOYoG83qQopZdMi6j63aLarXrEdQDmqNHHf/nhvDBSKF8+6MIVzZgeDX+ubSnotOW8N5I3PSZPv9FJMFOzo806EgH9aGpUJxg4kp1c6kj7mb74eY7G2R4uGwiUZInTFJ5eaOXF+55m0BW/hIbbIQFIBginpkIgzLtpNpRqmpdjXuaUkxwTxn2fPi5/i6L2DBxL3ZhqzaCsRDBVDXRiuPsTswiOfyAn3P3v6SmmgGeukQxmX/7UVzGAb2JbkXndcO2r4ZHtPUlTT31UBQV5nkaaoT1jL+I1iDQJ35I2VzA==
Received: from BYAPR02MB5029.namprd02.prod.outlook.com (2603:10b6:a03:61::24)
 by SJ2PR02MB10098.namprd02.prod.outlook.com (2603:10b6:a03:555::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Fri, 27 Jun
 2025 17:13:47 +0000
Received: from BYAPR02MB5029.namprd02.prod.outlook.com
 ([fe80::3158:6137:fd0f:d590]) by BYAPR02MB5029.namprd02.prod.outlook.com
 ([fe80::3158:6137:fd0f:d590%7]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 17:13:47 +0000
From: Yunpeng Yang <yunpeng.yang@nutanix.com>
To: "minyard@acm.org" <minyard@acm.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Mark Cave-Ayland
 <mark.caveayland@nutanix.com>, Jonathan Davies <jond@nutanix.com>
Subject: Add support for retrieving fake LAN config from `ipmi-bmc-sim` device
Thread-Topic: Add support for retrieving fake LAN config from `ipmi-bmc-sim`
 device
Thread-Index: AQHb539cPoDAP+0h/UiqkFcjX4CXjg==
Date: Fri, 27 Jun 2025 17:13:47 +0000
Message-ID: <BYAPR02MB502953334AA7CE0A695C373C8545A@BYAPR02MB5029.namprd02.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB5029:EE_|SJ2PR02MB10098:EE_
x-ms-office365-filtering-correlation-id: 4ed77a18-693a-4f62-abec-08ddb59dfac7
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|38070700018|4053099003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?lbfrzpZB+/tpZYLfP7CAj7wyEFAMcwWj5iPcbsA0YWjhbTZyO7taSyZZG3?=
 =?iso-8859-1?Q?0ChPzXBgnyPjLyLvDVZhCrlJfxnGVcTSOxzkmwDbyLdNnmbhJklSoUg55e?=
 =?iso-8859-1?Q?AvolcEJ5qCF1oHTd9eir1f6PUdG1ZUnKwIlQzpGgp88kwKOZMNptFfbI3e?=
 =?iso-8859-1?Q?eeR0Wj8o7UZqLGygI0t/nOULlEz+101a9WoammtE4MYvw9SeCk5xo96fWP?=
 =?iso-8859-1?Q?L4GN41CGoCebAeYqw5oW8GzWgSUaFn+OJ4fury+VuCai9O2b2mO4M/c6XS?=
 =?iso-8859-1?Q?H5Fwpp4gAku8YD1hoV2XmC1FbL4A0vAD0C5jbDOROLR1vHEquHdUUmkLtw?=
 =?iso-8859-1?Q?Y8uI6uDIcvI97Wm06X+6JpU0szCBPYAtpjKLNbIXyr2AGfXYtPekrkXUSY?=
 =?iso-8859-1?Q?MylQsF7LQdiTFSAm6LoZ6eKj2FwOqp7caOUg0P7mHm2yr02hHRORNM3oeG?=
 =?iso-8859-1?Q?NF2PQjPRR9DB3R5HCSq26G1aRe4RPGwYrOHzB/Ge4OikablFJx/rydbb6i?=
 =?iso-8859-1?Q?SBkenMdyAeRQ9H2tY9GhFsPh/j72loKtTeH/EQR9QlaQORnLd37Wt/voy/?=
 =?iso-8859-1?Q?a7tNk7weWuEZbvYviFRUxHftNCcrpCqKF2MQwa3wM4QYtZ0rU3M/6JHInk?=
 =?iso-8859-1?Q?abpOnUsCRNF2UOJEFFkHpkcyVGW7IFjfHehsYAmhrUudN9YOLtMM/5QpEI?=
 =?iso-8859-1?Q?7Ik045vBWPACkTP7xcriD/fIMr1C2ufTdlfLklVEtQBAVVuEfJQlOcNDP3?=
 =?iso-8859-1?Q?fA433i3EoXEiyW6+AIMOLOibr5Bzh4ANPbsfI3CsCwoEyqXhW4ZBzwVpLU?=
 =?iso-8859-1?Q?VIXTIWL1UXZ5YSL2rlo10V1hMCWgDhtl9kwzqZJOM+SxueW3Z3C2JisDEG?=
 =?iso-8859-1?Q?PGCtLJXgGbKSHlDI3XnZKMxeFUGPGGXMYCGyvjPFq70AbwwlMTndMI0HFY?=
 =?iso-8859-1?Q?xnZektNZC5A2cj6qSjaYCKkVLV7dDAXwBZkDhmQM5HhiSDKhpEgayhoUbv?=
 =?iso-8859-1?Q?NwYR/AltyyRnkYNMDJenmQ5dT3WgYNJU83RWNBP1uMFAgVnkDC6AqBVTLP?=
 =?iso-8859-1?Q?Bxjfq26u82wDnHhFDVixzsgeK+lsL9fnVzkVRFvRZLIVr+6ZYGQl4dCEgG?=
 =?iso-8859-1?Q?ToXDcmuncHUaPkyp/9tVasVw8gfBr6dLh8eQMOw/LY2VewnDsRPTk1/yLN?=
 =?iso-8859-1?Q?f+mmjYBXUmQpx+mHwMm65C32OQxPteMtnvkOnJX3gwDFSu+BgyFU07H2Y3?=
 =?iso-8859-1?Q?/dWROBgDgvWjI6aQIiNlcZ+pnOIm2dzWwYYSg3aqfSILcg3LfBd5gvygn2?=
 =?iso-8859-1?Q?tXmqhw6avjDZkdzjltTNHJYrIcrQd5/vr+rBgG3E5nr/yXUFe7Aes4NHNu?=
 =?iso-8859-1?Q?U4f8Tky9IFMMW0tmeux9mm24TPFU0klco0ceWsohaF77NQ0USXqmcnOB63?=
 =?iso-8859-1?Q?9YzNc9xGEULqN0ibxqZSx5VlQs2p7WN9mMuMZmAY34e4peAhIaTrHytGpC?=
 =?iso-8859-1?Q?kHjADHRIrYvS5ivJo6qGS7F1oYoScIA1+XFwpduDXuhg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB5029.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700018)(4053099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PosMjQ6bWTmU6yccN13gdxjr2wf1Mf9c+3AgwftJR6WipC6k/zOC5Khhfs?=
 =?iso-8859-1?Q?m1GNC3s9BqptF7IurcwfkpOoz+behbjv+BmiMVpDcKleEpm0sZO1UPxNzG?=
 =?iso-8859-1?Q?JJ7qUKvudU4sfGaiIdWFxXoN2k4dOXU8xvZoaZ0XVmY6UaiS2y40Ay1MOr?=
 =?iso-8859-1?Q?wSvt8ugU0Z11T92AV7wHOTtRS4zbwdB3pn2sh2ONjS+Mc4yXKklOkmUecK?=
 =?iso-8859-1?Q?Snjat/KUoCLMjZJNhUIFU1ZI5NnAu7TvqZ8ufUfCUyD7MUVUm1yza3j/j5?=
 =?iso-8859-1?Q?HQsxZQ77TEPgBRwwFvSN54v0lnzuyPvv712/5JbaXUzHMMP9nHBFKw+CGW?=
 =?iso-8859-1?Q?2BkrJUlbdQ1qZyKWvQpCOdKyUOvQUN7j7TeGzI/I5e73Xm6w0Gv5b/p0CU?=
 =?iso-8859-1?Q?C/o+cNmOuP+ObT0Z6Nd2ueXdtcPOuRX9RLe4xjpLIxcnuE6rb5twwojzON?=
 =?iso-8859-1?Q?p2hAwI4c1G8ZXIMNAnDcOFaY34ROpsqgFuocBuDBhcww4FSMDv4QXX9+pZ?=
 =?iso-8859-1?Q?S5BRuI2kh4/93WoQTw7YkIxaWVzCVOR3yaBAH6ubGB3Rf6DYU4LERF97Z4?=
 =?iso-8859-1?Q?lCfpCWbU+PUpdlEYV5FdIl+YiI7r3rWMP4R/zdCECS4Xfvb2qEJUeFNdqW?=
 =?iso-8859-1?Q?wT4i+mqujIH3wdpKiNi/Cp9BNRqrqVn47lko4LQlW7VpzHZCyJdUUdJZPw?=
 =?iso-8859-1?Q?Kpq5XSC1c1ef1+ozKwma9ct6aKyzDMyzgGulKJy052PAI2Krly4SglXCzX?=
 =?iso-8859-1?Q?tbhBVItc120SJtDAbqvcqwDd/LALwoPtvViYj+lLNWaiQLOz2ptkYqdIl4?=
 =?iso-8859-1?Q?8fpXtO1dkJDrwXTWmn3kLuOytBi+KqdeX4b4SHM50VeLFBsZq1mhuPlTOA?=
 =?iso-8859-1?Q?IWi2VtC5wjDpdwu2NDfd+LVK2ppVgy1gTvcfGYoFiBP8SCk7CIfNWcQEjH?=
 =?iso-8859-1?Q?ES0YvsvwfbO+nEy/al0P6sQF6gXMol8ZmVAvfNiZ0CoDGJwt2G7TAvFCq7?=
 =?iso-8859-1?Q?DmBPnQHzdhKSCmnC54cUM3R60hbHWMqwM7/5oh39qEwTArSAHtQJyft8FP?=
 =?iso-8859-1?Q?HYDpqgLypNK8xVICCQ04n/p8RSes4axwk9az86nKPD3ShUydvOb6CD4lQt?=
 =?iso-8859-1?Q?rJsL1irOZler8EoWOtOTiknUr2sHgJv4cwUqfvsqOsbreIPE0VZHerarrP?=
 =?iso-8859-1?Q?QHhXtxC1NWt/MVwnKwScRL8gM6uRWV4Bs6dF79obxHngHzMeaUOutcDBuI?=
 =?iso-8859-1?Q?vFKaJYYTuGCpdfpDYWYc+BMJbv0wCtGC9JiT1uPtQQF6JLykDnsXB1Ncmk?=
 =?iso-8859-1?Q?6r1qRhMe6TRCR4bEKNZiPwwa1gAjKqTlPqgQQRjXeusMU5Mmv6sMURvlOA?=
 =?iso-8859-1?Q?TOOl/slz4IgKyl6GY5hs/GA9mQYruF0WekJgLfWzfwEosDB5iUBKteXFq9?=
 =?iso-8859-1?Q?gXIWQEf9xzwEA0EIN8rPUDQvwHlBqQe7bI3x6BzpE8X3AsGdicNhHhUbtg?=
 =?iso-8859-1?Q?05b2SFRybvTkjPDXhqnvQXdB26PPwnEXcIIq21jYm9pAZzDXyhZyXfoL6q?=
 =?iso-8859-1?Q?4fAO1wl4oRtLNESViOeKIPe+1Eu76dWJ7XTbpVYUO74HTQsUaSFPR849ew?=
 =?iso-8859-1?Q?ns1M+WaaksWCWbhJ9mQGALUHAGoI+IuoDc?=
Content-Type: multipart/mixed;
 boundary="_004_BYAPR02MB502953334AA7CE0A695C373C8545ABYAPR02MB5029namp_"
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5029.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed77a18-693a-4f62-abec-08ddb59dfac7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 17:13:47.8016 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ZO/m/MxRJfIUx6hyjY+Gz77XIOULGI2bE/VU6bGFuYJ4lBbvKzcKIp7k1KGg9VtKYNpq+TiSLL/dWG01WA1xh0a6KnYBiqlMF18Z91zIBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB10098
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEzOSBTYWx0ZWRfXwCD776aHQ+WS
 U4I8vZqWJNyQUJ2xuhdhehYAszgjZdVmRa2gUJqcKD4CqBkHtjhVvGI6GOu6Wra4Mmm/DPO4ilx
 +muoFEkAtX+0BLyOcctYt2gtYlbd1AkgWAltnaQH2hdTPb6ANiGowbt7dqxu8wh+GQ2A3odkhuF
 ov1x17T0NrCqVP1S8So2Zn5TdHMbTVgzV8Ass1gymrr5/TeXgCjVCCeQIA0DQVoJ1L2OuTR5Ycy
 ZSzs+AGgr7c/yW8bTuWi0HcZqoCh4wluUfcxAKfrc7SgBjT+Q+r3BKdtQSvnP+baQim6P4EMh41
 n6JG1MEuFovryN/jqeIYA4jw1EiZ/M0Tfkn3/KdgrgpeODNHtS6Rf+e806W6yK5WOBwX2FoB1Yy
 IH9SLzRpkWsM+9dmEAGxEFwBq/wINM6L8+OEHWsvRSlpzAclnSqgUG691O/nqVkP7RmhN5fl
X-Proofpoint-GUID: AWI8nabcRvGeqZ4vDe-737-D9F-UKtP9
X-Authority-Analysis: v=2.4 cv=Qohe3Uyd c=1 sm=1 tr=0 ts=685ed14f cx=c_pps
 a=EAC/UdV2w3Vk3F7KeXBmxQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10
 a=0kUYKlekyDsA:10 a=7hTzruCEouem90z8dKIA:9 a=wPNLvfGTeEIA:10
 a=aRBo3qnOE0CTwWldQekA:9 a=HB-8fNE89Ua2oads:21 a=frz4AuCg-hUA:10
 a=_W_S_7VecoQA:10 a=d9HZ8YeEqRHYuS7IAO0A:9 a=B2y7HmGcmWMA:10
 a=zY0JdQc1-4EAyPf5TuXT:22
X-Proofpoint-ORIG-GUID: AWI8nabcRvGeqZ4vDe-737-D9F-UKtP9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=yunpeng.yang@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 27 Jun 2025 13:16:01 -0400
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

--_004_BYAPR02MB502953334AA7CE0A695C373C8545ABYAPR02MB5029namp_
Content-Type: multipart/alternative;
	boundary="_000_BYAPR02MB502953334AA7CE0A695C373C8545ABYAPR02MB5029namp_"

--_000_BYAPR02MB502953334AA7CE0A695C373C8545ABYAPR02MB5029namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Corey Minyard,

I hope this email finds you well.

I'm currently adding LAN-configs-retrieval support to the QEMU ipmi-bmc-sim=
 device. And I hope to merge the modifications upstream after it's finished=
. Could you please check the attached patch file of the draft code and shar=
e your opinions and advice?

In my work, we need to run tools like "ipmitool lan print" on a VM for test=
ing purposes. However, QEMU internal BMC simulator device (`ipmi-bmc-sim`) =
does not support retrieving LAN configs from it. I have to implement two IP=
MI commands so that the device can now work with ipmitool. The LAN config v=
alues are faked, but for testing purposes this is not a problem. I believe =
other people may also have the same need, so it's worth getting merged upst=
ream.

The fake BMC LAN config values are currently hard coded into the code. My p=
lan is to add a parameter to the device, which is a file containing user de=
signated values. The device then reads the file and returns those values as=
 LAN configs. This is similar to sdrfile for sensor data and frudatafile fo=
r FRU data.

Looking forward to hearing your thoughts.
Have a nice weekend.

Kind regards,
Yunpeng Yang

--_000_BYAPR02MB502953334AA7CE0A695C373C8545ABYAPR02MB5029namp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hello Corey Minyard,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
I hope this email&nbsp;finds you well.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
I'm currently adding LAN-configs-retrieval support&nbsp;to the QEMU <code>i=
pmi-bmc-sim</code>&nbsp;device. And I hope to merge the modifications upstr=
eam after it's finished. Could you please check the attached patch file of =
the draft code and share your opinions and
 advice?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
In my work, we need to run tools like &quot;ipmitool lan print&quot; on a V=
M for testing purposes. However, QEMU internal BMC simulator device (`ipmi-=
bmc-sim`) does not support retrieving LAN configs from it. I have to implem=
ent two IPMI commands so that the device can
 now work with <code>ipmitool</code>. The LAN config values are faked, but =
for testing purposes this is not a problem. I believe other people may also=
 have the same need, so it's worth getting merged upstream.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0=
);">
<span style=3D"font-size: 11pt;">The fake BMC LAN config values are current=
ly hard coded into the code. My plan is to add a parameter to the device, w=
hich is a file containing user designated values. The device then reads the=
 file and returns those values as
 LAN configs. This is similar to <code>sdrfile</code>&nbsp;for sensor data =
and <code>frudatafile</code></span><span style=3D"font-size: 14.6667px; bac=
kground-color: rgb(255, 255, 255);">&nbsp;for FRU data.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 14.6667=
px; color: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 14.6667=
px; color: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);">Looking forward to he=
aring your thoughts.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 14.6667=
px; color: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);">Have a nice weekend.<=
/span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 14.6667=
px; color: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 14.6667=
px; color: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);">Kind regards,</span><=
/div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 14.6667=
px; color: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);">Yunpeng Yang</span></=
div>
</body>
</html>

--_000_BYAPR02MB502953334AA7CE0A695C373C8545ABYAPR02MB5029namp_--

--_004_BYAPR02MB502953334AA7CE0A695C373C8545ABYAPR02MB5029namp_
Content-Type: application/octet-stream;
	name="0001-hw-ipmi-ipmi_bmc_sim.c-generating-fake-LAN-channel-i.patch"
Content-Description:  0001-hw-ipmi-ipmi_bmc_sim.c-generating-fake-LAN-channel-i.patch
Content-Disposition: attachment;
	filename="0001-hw-ipmi-ipmi_bmc_sim.c-generating-fake-LAN-channel-i.patch";
	size=10007; creation-date="Fri, 27 Jun 2025 16:29:06 GMT";
	modification-date="Fri, 27 Jun 2025 16:30:13 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhODY1OGQwYzYwMjhjOWJkOTc4ZDQzZTg0M2ZmZjRjOGFiZDM4N2E1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdW5wZW5nIFlhbmcgPHl1bnBlbmcueWFuZ0BudXRhbml4LmNv
bT4KRGF0ZTogV2VkLCAxMSBKdW4gMjAyNSAxMTo0MDoyNSArMDAwMApTdWJqZWN0OiBbUEFUQ0hd
IGh3L2lwbWkvaXBtaV9ibWNfc2ltLmM6IGdlbmVyYXRpbmcgZmFrZSBMQU4gY2hhbm5lbCBpbmZv
CgpBZGQgcGFydGlhbCBzdXBwb3J0IGZvciB0d28gSVBNSSBjb21tYW5kcywgIkdldCBDaGFubmVs
IEluZm8gQ29tbWFuZCIKYW5kICJHZXQgTEFOIENvbmZpZ3VyYXRpb24gUGFyYW1ldGVycyBDb21t
YW5kIiwgdG8gdGhlIHFlbXUKYGlwbWlfYm1jX3NpbWAgZGV2aWNlLiBGYWtlIEJNQyBMQU4gY2hh
bm5lbCBpbmZvIHdpbGwgYmUgZ2VuZXJhdGVkIGZvcgp0aGVzZSB0d28gY29tbWFuZHMuCgpgaXBt
aXRvb2wgbGFuIHByaW50YCBjYW4gbm93IGJlIHJ1biBvbiBhIHFlbXUgVk0gdG8gcmV0cmlldmUg
dGhlIGZha2UKQk1DIExBTiBpbmZvIGlmIGBpcG1pX2JtY19zaW1gIGlzIGVuYWJsZWQuCgpJUE1J
Mi4wIGludGVyZmFjZSBzcGVjaWZpY2F0aW9uOgpodHRwczovL3d3dy5pbnRlbC5jb20vY29udGVu
dC93d3cvdXMvZW4vcHJvZHVjdHMvZG9jcy9zZXJ2ZXJzLwppcG1pL2lwbWktc2Vjb25kLWdlbi1p
bnRlcmZhY2Utc3BlYy12Mi1yZXYxLTEuaHRtbAoKQ2hhbmdlLUlkOiBJYTg0MWM2Zjk5NmQ3YTFk
ODVhZDM1MTI4Yjk5NzkwMzk3YmQ0MGQ3YwotLS0KIGh3L2lwbWkvaXBtaV9ibWNfc2ltLmMgfCAx
ODEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFu
Z2VkLCAxODEgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2h3L2lwbWkvaXBtaV9ibWNfc2lt
LmMgYi9ody9pcG1pL2lwbWlfYm1jX3NpbS5jCmluZGV4IDkwNWUwOTEwOTQuLmRhY2ViYjlkNzgg
MTAwNjQ0Ci0tLSBhL2h3L2lwbWkvaXBtaV9ibWNfc2ltLmMKKysrIGIvaHcvaXBtaS9pcG1pX2Jt
Y19zaW0uYwpAQCAtNzAsNiArNzAsNyBAQAogI2RlZmluZSBJUE1JX0NNRF9HRVRfTVNHICAgICAg
ICAgICAgICAgICAgMHgzMwogI2RlZmluZSBJUE1JX0NNRF9TRU5EX01TRyAgICAgICAgICAgICAg
ICAgMHgzNAogI2RlZmluZSBJUE1JX0NNRF9SRUFEX0VWVF9NU0dfQlVGICAgICAgICAgMHgzNQor
I2RlZmluZSBJUE1JX0NNRF9HRVRfQ0hBTk5FTF9JTkZPICAgICAgICAgMHg0MgogCiAjZGVmaW5l
IElQTUlfTkVURk5fU1RPUkFHRSAgICAgICAgICAgIDB4MGEKIApAQCAtMTAwLDYgKzEwMSwxMCBA
QAogI2RlZmluZSBJUE1JX0NNRF9HRVRfU0VMX1RJTUUgICAgICAgICAgICAgMHg0OAogI2RlZmlu
ZSBJUE1JX0NNRF9TRVRfU0VMX1RJTUUgICAgICAgICAgICAgMHg0OQogCisjZGVmaW5lIElQTUlf
TkVURk5fVFJBTlNQT1JUICAgICAgICAgIDB4MGMKKworI2RlZmluZSBJUE1JX0NNRF9HRVRfTEFO
X0NPTkZJRyAgICAgICAgICAgMHgwMgorCiAKIC8qIFNhbWUgYXMgYSB0aW1lc3BlYyBzdHJ1Y3Qu
ICovCiBzdHJ1Y3QgaXBtaV90aW1lIHsKQEAgLTI2Myw2ICsyNjgsMjggQEAgc3RydWN0IElQTUlC
bWNTaW0gewogI2RlZmluZSBJUE1JX0JNQ19XQVRDSERPR19BQ1RJT05fUE9XRVJfRE9XTiAgICAg
IDIKICNkZWZpbmUgSVBNSV9CTUNfV0FUQ0hET0dfQUNUSU9OX1BPV0VSX0NZQ0xFICAgICAzCiAK
Ky8qCisgKiBSZWZlciB0byB0aGUgSVBNSTIuMCBpbnRlcmZhY2Ugc3BlY2lmaWNhdGlvbjoKKyAq
IGh0dHBzOi8vd3d3LmludGVsLmNvbS9jb250ZW50L2RhbS93d3cvcHVibGljL3VzL2VuL2RvY3Vt
ZW50cy9wcm9kdWN0LWJyaWVmcy8KKyAqICAgICBpcG1pLXNlY29uZC1nZW4taW50ZXJmYWNlLXNw
ZWMtdjItcmV2MS0xLnBkZgorICovCisjZGVmaW5lIElQTUlfQk1DX0xBTl9DRkdfUEFSQU1FVEVS
X1JFVklTSU9OICAgICAgICAweDExCisjZGVmaW5lIElQTUlfQk1DX0xBTl9DRkdfQ0NfUEFSQU1f
Tk9UX1NVUFBPUlRFRCAgICAweDgwCisjZGVmaW5lIElQTUlfQk1DX0xBTl9DRkdfUEFSQU1fU0VU
X0lOX1BST0dSRVNTICAgICAgICAgIDB4MDAKKyNkZWZpbmUgSVBNSV9CTUNfTEFOX0NGR19QQVJB
TV9BVVRIX1RZUEVfU1VQUE9SVCAgICAgICAgMHgwMQorI2RlZmluZSBJUE1JX0JNQ19MQU5fQ0ZH
X1BBUkFNX0FVVEhfVFlQRV9FTkFCTEVTICAgICAgICAweDAyCisjZGVmaW5lIElQTUlfQk1DX0xB
Tl9DRkdfUEFSQU1fSVBfQUREUiAgICAgICAgICAgICAgICAgIDB4MDMKKyNkZWZpbmUgSVBNSV9C
TUNfTEFOX0NGR19QQVJBTV9JUF9BRERSX1NPVVJDRSAgICAgICAgICAgMHgwNAorI2RlZmluZSBJ
UE1JX0JNQ19MQU5fQ0ZHX1BBUkFNX01BQ19BRERSICAgICAgICAgICAgICAgICAweDA1CisjZGVm
aW5lIElQTUlfQk1DX0xBTl9DRkdfUEFSQU1fU1VCTkVUX01BU0sgICAgICAgICAgICAgIDB4MDYK
KyNkZWZpbmUgSVBNSV9CTUNfTEFOX0NGR19QQVJBTV9JUFY0X0hEUl9QQVJBTSAgICAgICAgICAg
MHgwNworI2RlZmluZSBJUE1JX0JNQ19MQU5fQ0ZHX1BBUkFNX0RFRkFVTFRfR1dfQUREUiAgICAg
ICAgICAweDBjCisjZGVmaW5lIElQTUlfQk1DX0xBTl9DRkdfUEFSQU1fREVGQVVMVF9HV19NQUNf
QUREUiAgICAgIDB4MGQKKyNkZWZpbmUgSVBNSV9CTUNfTEFOX0NGR19QQVJBTV9CQUNLVVBfR1df
QUREUiAgICAgICAgICAgMHgwZQorI2RlZmluZSBJUE1JX0JNQ19MQU5fQ0ZHX1BBUkFNX0JBQ0tV
UF9HV19NQUNfQUREUiAgICAgICAweDBmCisjZGVmaW5lIElQTUlfQk1DX0xBTl9DRkdfUEFSQU1f
Q09NTVVOSVRZX1NUUklORyAgICAgICAgIDB4MTAKKyNkZWZpbmUgSVBNSV9CTUNfTEFOX0NGR19Q
QVJBTV9OVU1fREVTVElOQVRJT05TICAgICAgICAgMHgxMQorCiAjZGVmaW5lIFJTUF9CVUZGRVJf
SU5JVElBTElaRVIgeyB9CiAKIHN0YXRpYyBpbmxpbmUgdm9pZCByc3BfYnVmZmVyX3B1c2htb3Jl
KFJzcEJ1ZmZlciAqcnNwLCB1aW50OF90ICpieXRlcywKQEAgLTEyMTksNiArMTI0NiwzNyBAQCBz
dGF0aWMgdm9pZCBnZXRfd2F0Y2hkb2dfdGltZXIoSVBNSUJtY1NpbSAqaWJzLAogICAgIH0KIH0K
IAorLyoKKyAqIFRPRE86IEFkZCBhIGBjaG5sZmlsZT1gIHBhcmFtZXRlciB0byB0aGUgYGlwbWlf
Ym1jX3NpbWAgZGV2aWNlLgorICogVXNlIHRoYXQgZmlsZSB0byBzcGVjaWZ5IHRoZSBjaGFubmVs
IGluZm8uCisgKiBJZiBhIGNoYW5uZWwgaXMgYSBMQU4gY2hhbm5lbCwgaW5jbHVkZSBMQU4gcGFy
YW1ldGVycyBpbiB0aGF0IGZpbGUuCisgKi8KK3N0YXRpYyB2b2lkIGdldF9jaGFubmVsX2luZm8o
SVBNSUJtY1NpbSAqaWJzLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50OF90ICpj
bWQsIHVuc2lnbmVkIGludCBjbWRfbGVuLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICBS
c3BCdWZmZXIgKnJzcCkKK3sKKyAgICB1aW50OF90IGNoYW5uZWwgPSBjbWRbMl0gJiAweGY7Cisg
ICAgLyogUmVmZXIgdG8gSVBNSSBwcm90b2NvbCBmb3IgY2hhbm5lbCBudW1iZXIgYXNzaWdubWVu
dHMgKi8KKyAgICBzd2l0Y2ggKGNoYW5uZWwpIHsKKyAgICBjYXNlIDE6CisgICAgICAgIHJzcF9i
dWZmZXJfcHVzaChyc3AsIDEpOyAvKiBBY3R1YWwgY2hhbm5lbCBudW1iZXIgKi8KKyAgICAgICAg
cnNwX2J1ZmZlcl9wdXNoKHJzcCwgMHg0KTsgLyogQ2hhbm5lbCBtZWRpdW0gdHlwZTogODAyLjMg
TEFOICovCisgICAgICAgIHJzcF9idWZmZXJfcHVzaChyc3AsIDB4MCk7IC8qIENoYW5uZWwgcHJv
dG9jb2w6IHR5cGUgbi9hICovCisgICAgICAgIHJzcF9idWZmZXJfcHVzaChyc3AsIDB4MCk7IC8q
IFNlc3Npb24gc3VwcG9ydDogc2Vzc2lvbiBsZXNzICovCisgICAgICAgIC8qIDMtYnl0ZSBWZW5k
b3IgSUQ6IElQTUkgRW50ZXJwcmlzZSBOdW1iZXIgNzE1NCAoTFNCIGZpcnN0KSAqLworICAgICAg
ICByc3BfYnVmZmVyX3B1c2gocnNwLCAweGYyKTsKKyAgICAgICAgcnNwX2J1ZmZlcl9wdXNoKHJz
cCwgMHgxYik7CisgICAgICAgIHJzcF9idWZmZXJfcHVzaChyc3AsIDB4MDApOworICAgICAgICAv
KiAyLWJ5dGUgQXV4aWxpYXJ5IENoYW5uZWwgSW5mbyAqLworICAgICAgICByc3BfYnVmZmVyX3B1
c2gocnNwLCAweDApOworICAgICAgICByc3BfYnVmZmVyX3B1c2gocnNwLCAweDApOworICAgICAg
ICBicmVhazsKKyAgICBkZWZhdWx0OgorICAgICAgICByc3BfYnVmZmVyX3NldF9lcnJvcihyc3As
IElQTUlfQ0NfSU5WQUxJRF9EQVRBX0ZJRUxEKTsKKyAgICAgICAgYnJlYWs7CisgICAgfQorfQor
CiBzdGF0aWMgdm9pZCBnZXRfc2RyX3JlcF9pbmZvKElQTUlCbWNTaW0gKmlicywKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdWludDhfdCAqY21kLCB1bnNpZ25lZCBpbnQgY21kX2xlbiwK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUnNwQnVmZmVyICpyc3ApCkBAIC0xOTcxLDYg
KzIwMjksMTE4IEBAIHN0YXRpYyB2b2lkIHNldF9zZW5zb3JfcmVhZGluZyhJUE1JQm1jU2ltICpp
YnMsCiAgICAgfQogfQogCisvKgorICogYnl0ZXMgICBwYXJhbWV0ZXIKKyAqICAgIDEgICAgWzdd
IHJldmlzaW9uIG9ubHkgZmxhZywgWzM6MF0gY2hhbm5lbCBudW1iZXIKKyAqICAgIDIgICAgcGFy
YW1ldGVyIHNlbGVjdG9yCisgKiAgICAzICAgIHNldCBzZWxlY3RvcgorICogICAgNCAgICBibG9j
ayBzZWxlY3RvcgorICovCitzdGF0aWMgdm9pZCBnZXRfbGFuX2NvbmZpZyhJUE1JQm1jU2ltICpp
YnMsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDhfdCAqY21kLCB1bnNpZ25lZCBp
bnQgY21kX2xlbiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBSc3BCdWZmZXIgKnJzcCkK
K3sKKyAgICByc3BfYnVmZmVyX3B1c2gocnNwLCBJUE1JX0JNQ19MQU5fQ0ZHX1BBUkFNRVRFUl9S
RVZJU0lPTik7CisgICAgLyogVGhlIHJlcXVlc3RlciBvbmx5IHJlcXVlc3RzIHBhcmFtZXRlciBy
ZXZpc2lvbiwgbm90IHRoZSBwYXJhbWV0ZXIgKi8KKyAgICBpZiAoY21kWzJdICYgMHg4MCkgewor
ICAgICAgICByZXR1cm47CisgICAgfQorCisgICAgc3dpdGNoIChjbWRbM10pIHsKKyAgICBjYXNl
IElQTUlfQk1DX0xBTl9DRkdfUEFSQU1fU0VUX0lOX1BST0dSRVNTOgorICAgICAgICByc3BfYnVm
ZmVyX3B1c2gocnNwLCAweDAwKTsgLyogc2V0IGNvbXBsZXRlICovCisgICAgICAgIGJyZWFrOwor
ICAgIGNhc2UgSVBNSV9CTUNfTEFOX0NGR19QQVJBTV9BVVRIX1RZUEVfU1VQUE9SVDoKKyAgICAg
ICAgcnNwX2J1ZmZlcl9wdXNoKHJzcCwgMHgwMSk7IC8qIEF1dGhlbnRpY2F0aW9uIHR5cGUgIm5v
bmUiIHN1cHBvcnRlZCAqLworICAgICAgICBicmVhazsKKyAgICBjYXNlIElQTUlfQk1DX0xBTl9D
RkdfUEFSQU1fQVVUSF9UWVBFX0VOQUJMRVM6CisgICAgICAgIC8qIE9ubHkgYXV0aGVudGljYXRp
b24gdHlwZSAibm9uZSIgZW5hYmxlZCAqLworICAgICAgICByc3BfYnVmZmVyX3B1c2gocnNwLCAw
eDAxKTsgLyogZm9yIHByaXZpbGVnZSBsZXZlbCAiQ2FsbGJhY2siICovCisgICAgICAgIHJzcF9i
dWZmZXJfcHVzaChyc3AsIDB4MDEpOyAvKiBmb3IgcHJpdmlsZWdlIGxldmVsICJVc2VyIiAqLwor
ICAgICAgICByc3BfYnVmZmVyX3B1c2gocnNwLCAweDAxKTsgLyogZm9yIHByaXZpbGVnZSBsZXZl
bCAiT3BlcmF0b3IiICovCisgICAgICAgIHJzcF9idWZmZXJfcHVzaChyc3AsIDB4MDEpOyAvKiBm
b3IgcHJpdmlsZWdlIGxldmVsICJBZG1pbmlzdHJhdG9yIiAqLworICAgICAgICByc3BfYnVmZmVy
X3B1c2gocnNwLCAweDAxKTsgLyogZm9yIHByaXZpbGVnZSBsZXZlbCAiT0VNIiAqLworICAgICAg
ICBicmVhazsKKyAgICBjYXNlIElQTUlfQk1DX0xBTl9DRkdfUEFSQU1fSVBfQUREUjoKKyAgICAg
ICAgLyogMTkyLjAuMi4xICovCisgICAgICAgIHJzcF9idWZmZXJfcHVzaChyc3AsIDB4YzApOwor
ICAgICAgICByc3BfYnVmZmVyX3B1c2gocnNwLCAweDAwKTsKKyAgICAgICAgcnNwX2J1ZmZlcl9w
dXNoKHJzcCwgMHgwMik7CisgICAgICAgIHJzcF9idWZmZXJfcHVzaChyc3AsIDB4MDEpOworICAg
ICAgICBicmVhazsKKyAgICBjYXNlIElQTUlfQk1DX0xBTl9DRkdfUEFSQU1fSVBfQUREUl9TT1VS
Q0U6CisgICAgICAgIHJzcF9idWZmZXJfcHVzaChyc3AsIDB4MDApOyAvKiB1bnNwZWNpZmllZCBh
ZGRyZXNzIHNvdXJjZSAqLworICAgICAgICBicmVhazsKKyAgICBjYXNlIElQTUlfQk1DX0xBTl9D
RkdfUEFSQU1fTUFDX0FERFI6CisgICAgICAgIC8qIDAyOjAwOjAwOjAwOjAwOjAxICovCisgICAg
ICAgIHJzcF9idWZmZXJfcHVzaChyc3AsIDB4MDIpOworICAgICAgICByc3BfYnVmZmVyX3B1c2go
cnNwLCAweDAwKTsKKyAgICAgICAgcnNwX2J1ZmZlcl9wdXNoKHJzcCwgMHgwMCk7CisgICAgICAg
IHJzcF9idWZmZXJfcHVzaChyc3AsIDB4MDApOworICAgICAgICByc3BfYnVmZmVyX3B1c2gocnNw
LCAweDAwKTsKKyAgICAgICAgcnNwX2J1ZmZlcl9wdXNoKHJzcCwgMHgwMSk7CisgICAgICAgIGJy
ZWFrOworICAgIGNhc2UgSVBNSV9CTUNfTEFOX0NGR19QQVJBTV9TVUJORVRfTUFTSzoKKyAgICAg
ICAgLyogMjU1LjI1NS4yNTUuMCAqLworICAgICAgICByc3BfYnVmZmVyX3B1c2gocnNwLCAweGZm
KTsKKyAgICAgICAgcnNwX2J1ZmZlcl9wdXNoKHJzcCwgMHhmZik7CisgICAgICAgIHJzcF9idWZm
ZXJfcHVzaChyc3AsIDB4ZmYpOworICAgICAgICByc3BfYnVmZmVyX3B1c2gocnNwLCAweDAwKTsK
KyAgICAgICAgYnJlYWs7CisgICAgY2FzZSBJUE1JX0JNQ19MQU5fQ0ZHX1BBUkFNX0lQVjRfSERS
X1BBUkFNOgorICAgICAgICByc3BfYnVmZmVyX3B1c2gocnNwLCAweDQwKTsKKyAgICAgICAgcnNw
X2J1ZmZlcl9wdXNoKHJzcCwgMHg0MCk7CisgICAgICAgIHJzcF9idWZmZXJfcHVzaChyc3AsIDB4
MTApOworICAgICAgICBicmVhazsKKyAgICBjYXNlIElQTUlfQk1DX0xBTl9DRkdfUEFSQU1fREVG
QVVMVF9HV19BRERSOgorICAgICAgICAvKiAxOTIuMC4yLjEgKi8KKyAgICAgICAgcnNwX2J1ZmZl
cl9wdXNoKHJzcCwgMHhjMCk7CisgICAgICAgIHJzcF9idWZmZXJfcHVzaChyc3AsIDB4MDApOwor
ICAgICAgICByc3BfYnVmZmVyX3B1c2gocnNwLCAweDAyKTsKKyAgICAgICAgcnNwX2J1ZmZlcl9w
dXNoKHJzcCwgMHgwMSk7CisgICAgICAgIGJyZWFrOworICAgIGNhc2UgSVBNSV9CTUNfTEFOX0NG
R19QQVJBTV9ERUZBVUxUX0dXX01BQ19BRERSOgorICAgICAgICAvKiAwMjowMDowMDowMDowMDow
MSAqLworICAgICAgICByc3BfYnVmZmVyX3B1c2gocnNwLCAweDAyKTsKKyAgICAgICAgcnNwX2J1
ZmZlcl9wdXNoKHJzcCwgMHgwMCk7CisgICAgICAgIHJzcF9idWZmZXJfcHVzaChyc3AsIDB4MDAp
OworICAgICAgICByc3BfYnVmZmVyX3B1c2gocnNwLCAweDAwKTsKKyAgICAgICAgcnNwX2J1ZmZl
cl9wdXNoKHJzcCwgMHgwMCk7CisgICAgICAgIHJzcF9idWZmZXJfcHVzaChyc3AsIDB4MDEpOwor
ICAgICAgICBicmVhazsKKyAgICBjYXNlIElQTUlfQk1DX0xBTl9DRkdfUEFSQU1fQkFDS1VQX0dX
X0FERFI6CisgICAgICAgIC8qIDAuMC4wLjAgKi8KKyAgICAgICAgcnNwX2J1ZmZlcl9wdXNoKHJz
cCwgMHgwMCk7CisgICAgICAgIHJzcF9idWZmZXJfcHVzaChyc3AsIDB4MDApOworICAgICAgICBy
c3BfYnVmZmVyX3B1c2gocnNwLCAweDAwKTsKKyAgICAgICAgcnNwX2J1ZmZlcl9wdXNoKHJzcCwg
MHgwMCk7CisgICAgICAgIGJyZWFrOworICAgIGNhc2UgSVBNSV9CTUNfTEFOX0NGR19QQVJBTV9C
QUNLVVBfR1dfTUFDX0FERFI6CisgICAgICAgIC8qIDAwOjAwOjAwOjAwOjAwOjAwICovCisgICAg
ICAgIHJzcF9idWZmZXJfcHVzaChyc3AsIDB4MDApOworICAgICAgICByc3BfYnVmZmVyX3B1c2go
cnNwLCAweDAwKTsKKyAgICAgICAgcnNwX2J1ZmZlcl9wdXNoKHJzcCwgMHgwMCk7CisgICAgICAg
IHJzcF9idWZmZXJfcHVzaChyc3AsIDB4MDApOworICAgICAgICByc3BfYnVmZmVyX3B1c2gocnNw
LCAweDAwKTsKKyAgICAgICAgcnNwX2J1ZmZlcl9wdXNoKHJzcCwgMHgwMCk7CisgICAgICAgIGJy
ZWFrOworICAgIGNhc2UgSVBNSV9CTUNfTEFOX0NGR19QQVJBTV9DT01NVU5JVFlfU1RSSU5HOgor
ICAgICAgICB7CisgICAgICAgICAgICAvKiBCZXR0ZXIgZm9yIGBjb21tdW5pdHlfc3RyYCB0byBi
ZSBjb25zdCwKKyAgICAgICAgICAgICAqIGJ1dCBgcnNwX2J1ZmZlcl9wdXNobW9yZWAgcmVxdWly
ZXMgbm9uLWNvbnN0ICovCisgICAgICAgICAgICBzdGF0aWMgdWludDhfdCBjb21tdW5pdHlfc3Ry
WzE4XSA9ICJwdWJsaWMiOworICAgICAgICAgICAgcnNwX2J1ZmZlcl9wdXNobW9yZShyc3AsIGNv
bW11bml0eV9zdHIsIHNpemVvZihjb21tdW5pdHlfc3RyKSk7CisgICAgICAgIH0KKyAgICAgICAg
YnJlYWs7CisgICAgY2FzZSBJUE1JX0JNQ19MQU5fQ0ZHX1BBUkFNX05VTV9ERVNUSU5BVElPTlM6
CisgICAgICAgIHJzcF9idWZmZXJfcHVzaChyc3AsIDB4MDApOyAvKiBMQU4gQWxlcnRpbmcgbm90
IHN1cHBvcnRlZCAqLworICAgICAgICBicmVhazsKKyAgICBkZWZhdWx0IDoKKyAgICAgICAgcnNw
X2J1ZmZlcl9zZXRfZXJyb3IocnNwLCBJUE1JX0JNQ19MQU5fQ0ZHX0NDX1BBUkFNX05PVF9TVVBQ
T1JURUQpOworICAgICAgICByZXR1cm47CisgICAgfTsKK30KKwogc3RhdGljIGNvbnN0IElQTUlD
bWRIYW5kbGVyIGNoYXNzaXNfY21kc1tdID0gewogICAgIFtJUE1JX0NNRF9HRVRfQ0hBU1NJU19D
QVBBQklMSVRJRVNdID0geyBjaGFzc2lzX2NhcGFiaWxpdGllcyB9LAogICAgIFtJUE1JX0NNRF9H
RVRfQ0hBU1NJU19TVEFUVVNdID0geyBjaGFzc2lzX3N0YXR1cyB9LApAQCAtMjAxNSw2ICsyMTg1
LDcgQEAgc3RhdGljIGNvbnN0IElQTUlDbWRIYW5kbGVyIGFwcF9jbWRzW10gPSB7CiAgICAgW0lQ
TUlfQ01EX1JFU0VUX1dBVENIRE9HX1RJTUVSXSA9IHsgcmVzZXRfd2F0Y2hkb2dfdGltZXIgfSwK
ICAgICBbSVBNSV9DTURfU0VUX1dBVENIRE9HX1RJTUVSXSA9IHsgc2V0X3dhdGNoZG9nX3RpbWVy
LCA4IH0sCiAgICAgW0lQTUlfQ01EX0dFVF9XQVRDSERPR19USU1FUl0gPSB7IGdldF93YXRjaGRv
Z190aW1lciB9LAorICAgIFtJUE1JX0NNRF9HRVRfQ0hBTk5FTF9JTkZPXSA9IHsgZ2V0X2NoYW5u
ZWxfaW5mbywgMyB9LAogfTsKIHN0YXRpYyBjb25zdCBJUE1JTmV0Zm4gYXBwX25ldGZuID0gewog
ICAgIC5jbWRfbnVtcyA9IEFSUkFZX1NJWkUoYXBwX2NtZHMpLApAQCAtMjA0NCwxMiArMjIxNSwy
MiBAQCBzdGF0aWMgY29uc3QgSVBNSU5ldGZuIHN0b3JhZ2VfbmV0Zm4gPSB7CiAgICAgLmNtZF9o
YW5kbGVycyA9IHN0b3JhZ2VfY21kcwogfTsKIAorc3RhdGljIGNvbnN0IElQTUlDbWRIYW5kbGVy
IHRyYW5zcG9ydF9jbWRzW10gPSB7CisgICAgW0lQTUlfQ01EX0dFVF9MQU5fQ09ORklHXSA9IHsg
Z2V0X2xhbl9jb25maWcsIDYgfQorfTsKK3N0YXRpYyBjb25zdCBJUE1JTmV0Zm4gdHJhbnNwb3J0
X25ldGZuID0geworICAgIC5jbWRfbnVtcyA9IEFSUkFZX1NJWkUodHJhbnNwb3J0X2NtZHMpLAor
ICAgIC5jbWRfaGFuZGxlcnMgPSB0cmFuc3BvcnRfY21kcworfTsKKworCiBzdGF0aWMgdm9pZCBy
ZWdpc3Rlcl9jbWRzKElQTUlCbWNTaW0gKnMpCiB7CiAgICAgaXBtaV9zaW1fcmVnaXN0ZXJfbmV0
Zm4ocywgSVBNSV9ORVRGTl9DSEFTU0lTLCAmY2hhc3Npc19uZXRmbik7CiAgICAgaXBtaV9zaW1f
cmVnaXN0ZXJfbmV0Zm4ocywgSVBNSV9ORVRGTl9TRU5TT1JfRVZFTlQsICZzZW5zb3JfZXZlbnRf
bmV0Zm4pOwogICAgIGlwbWlfc2ltX3JlZ2lzdGVyX25ldGZuKHMsIElQTUlfTkVURk5fQVBQLCAm
YXBwX25ldGZuKTsKICAgICBpcG1pX3NpbV9yZWdpc3Rlcl9uZXRmbihzLCBJUE1JX05FVEZOX1NU
T1JBR0UsICZzdG9yYWdlX25ldGZuKTsKKyAgICBpcG1pX3NpbV9yZWdpc3Rlcl9uZXRmbihzLCBJ
UE1JX05FVEZOX1RSQU5TUE9SVCwgJnRyYW5zcG9ydF9uZXRmbik7CiB9CiAKIHN0YXRpYyB1aW50
OF90IGluaXRfc2Ryc1tdID0gewotLSAKMi4zOS4zCgo=

--_004_BYAPR02MB502953334AA7CE0A695C373C8545ABYAPR02MB5029namp_--

