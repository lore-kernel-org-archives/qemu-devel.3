Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90AAC44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm9Yz-0008BY-8F; Tue, 21 Jul 2026 08:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wm9Yw-00089s-Bp
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:27:06 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wm9Yu-0004nN-RC
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:27:06 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LAR8p23215302; Tue, 21 Jul 2026 05:27:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=EE8e9cR66Xp2sTSYFoivVnsPw5pxojt0t2Jiz+ike
 rU=; b=gqw2jBe2QtBRAsUttiwvPbU8rWMU87c+3DkQuD9DaUoNqtcRdWqcsDHpr
 xfmUtTm4oKas0vQyxTSA2CgX3oq8HuE98rhrR/hCJmxLn7sRBKWcf1ZMZUDAzY1V
 hizb+PFqrdoFgKty/y6fXUTim5xXUiFdV3N8fMmQCQKwJzpTm43VI4KvrM5HFuHi
 Lj/RfD0EOPIWWSlhdcUZoBLPYwjyh3z/TpNd6uR04ewq8GfVRG3+0OXdqazjC1t9
 UXByGMo6Xc6cVg/TGRqlUuZWSymvymeAiNPA7JX5keP/qE9BgVZ6/rscc/wXNR6w
 p4+4AayDz4zlxOM7ffQZYvyn0QniA==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020105.outbound.protection.outlook.com [52.101.46.105])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4fg8eeebs7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 05:27:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7f2b7gjGXbd/P15l5w7VW3987u4+OBN+7nYZgE473dMj8rhIfCjQUn5JmoML8+4oMNhOZoZXwo46iOykc/OozyRErnCuLuQBdOXGqn4Rwky/hdnSxNN0R3Mf4jWc2D1GZf/pO19nJCL/JqI8WSJE4tA+EriVBkE8zOiVYKlsgSF4k+K+JR+pkaJmKOiIddugrByy9ZBOYGpENE+pLcTyHWh61RBM54sA9Vo9+bHVke7WuqkavcUMe67qhco+eIRinN1yX7ovx+8S+W5JXwlBjHMZK5xB9UCUuCR5KBL3RSuSgeRT/Miim0+d109ZSaydKPGeAcr2BKypJVIrUd0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EE8e9cR66Xp2sTSYFoivVnsPw5pxojt0t2Jiz+ikerU=;
 b=yqYcYHzXGtxEcr6mYWf4jIOssGg9ur1bqBkAsyyjcKZsjuTd73iwLBadn7kpeZvxdbIGrLx8fwEE1tNY+VKbJ1P94LVIuhSmSwBwEmAe5SNCbRhKL8Z36OW06rgSXEtFAurLcg++x+9LXHvVjAFnIg3YDtLFxrc7Rjx1M+3w8kBkNg/r+EJI1imTVY/QJgvWru/Hr05qZCHnizRkLPrcWKtLTt8xCIwqEAIfEBMgC37UqYmoiyX2UaWXjoC7xZj4VaoyXmigGgzdJWa7yZJHb+xoUnNV3FTb8Na9H9fBTdkevnh31qrce5PVCRNRWMCSKCHA0t2Z3brxaiCXf3pKSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EE8e9cR66Xp2sTSYFoivVnsPw5pxojt0t2Jiz+ikerU=;
 b=L+Tt5zGJlN8CMXUNNfzMpgme4dAJpQrDA8e/SQjszBWfrRT7t/Bg4ewC6LYu983zXTt27E84+GX+qwbF+7dTQn6hcH2h6r0JXR5z+1UrP0MslDGUQxw2XMaSOs6eTH+/QFUkIqJdw9scfVGU6OewJbIBAV+eS9o1ZXM/5A2YQOzc9dMPLccK9cU9PHkCvqbkHhPzG5O/KD44HJ7qhDmDYXd5LLJyDF7GJRD+HGbYgptqTbTi5TLjN7kU1hWBXEJGqdkiiKNi32BrZ0nEncYPkPLCMSJhqOw0IDYf+coRFlv3ZEooE7i7A6FxUUCjxEc6DAaYaKkEBBrb5iz07GRkkA==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by DS0PR02MB10249.namprd02.prod.outlook.com (2603:10b6:8:1a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 12:27:01 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%7]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 12:27:01 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>, "clg@redhat.com" <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: [PATCH v3 8/9] vfio-user: vfio_user_device_io_set_irqs: prevent
 buffer overflow
Thread-Topic: [PATCH v3 8/9] vfio-user: vfio_user_device_io_set_irqs: prevent
 buffer overflow
Thread-Index: AQHdGQw6PB1Wh1SdGkyrkEtghAsWtA==
Date: Tue, 21 Jul 2026 12:27:00 +0000
Message-ID: <20260721122643.30985-9-thanos.makatos@nutanix.com>
References: <20260720135823.21070-1-thanos.makatos@nutanix.com>
 <20260721122643.30985-1-thanos.makatos@nutanix.com>
In-Reply-To: <20260721122643.30985-1-thanos.makatos@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|DS0PR02MB10249:EE_
x-ms-office365-filtering-correlation-id: 76b4e46c-0123-4aa6-a467-08dee7235d67
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|22082099003|18002099003|56012099006|4143699003|10067099003;
x-microsoft-antispam-message-info: jAh3oMUbZCjDDxtW2jnA9NG5VxkpKifTE4geaWbCWrq3lphq6q9OyYxF+RBei85DaXaAy8ovdgKRsdOLHzD8pqIwTOyNSgpeuTv6tBHa7C1m0jqpZzgfVUVWw2IISwPsm+15y1wio31eHEsYR3nVRvrlVSBbL3Dbo7TqDMH73zME5Zl9RP/v+yr4UNr9yFvvFHNwhCX/zUS7z69W4SvSF7kJGUxJ2DYew4Do2LWUvVNnPsOGb7QRx+OrRFGJ9D0JG5C8efg8Ehn6XJ14lzm9bClqlO7pkU8SG3lmQjSTcDDcMlxEXmqYw+Lqa2ON/NYbUefX5a0vESGKwsq++/fIjROMbpQFsJDbVPBc9ZQ465EXocHSCmzFPZS/oZHSUYQyqAlQ6IjXxeZsYCHEi3FsirKhUYDpI/F/h/cF9xN8zzo8BVLnYmOjVdkY4Vzet9auLfhMtN45rOagxMCEwgPXT0PXmhPLaFgFE8KdiUq17OL7CbfSRrikoj4wlrB/xJSl+d/HpyRCDXN5jBfwX6cXBIpawBWre8GvA652ezPpyaxOAoNzhC4RTVRXohYt2N+VPU/ecFbmFxecEjIcwuW/oyLbJlC5VlYLh14/8XdmIB6Z5pisSTNvTtWogYuGCXhvJQbrjMwCeivzC0ew6QaZPo9uJDbAyESMIYfuPsbvDd6xFFMNqL/X8TZNUAdwMPmaAtTjI3sU4aoh8s/qa3i6gm+8esU9XMu/csQ9IQYSrSo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Vuo3gkJaeN1Gxlm+QWja1R3KDnPFJttOxV78Ntw+e6BleA1tQ96ZVNLyaA?=
 =?iso-8859-1?Q?RFZohoIefkkeZS4aUzheS2n7ybYESnU1nXbKMLKbRydQ9ZUWlLZl70KpTM?=
 =?iso-8859-1?Q?q+OBQ/u1konEg5Tju3pKejaclDk/3RCjpr7TjzFx3llu4tP393zCNyrU9B?=
 =?iso-8859-1?Q?7CUz3xOOybktdGsMq2jkFBqQhmmbNvk/U+97pTwPL/kMZO+pWilvNBi3Lb?=
 =?iso-8859-1?Q?bPXTbxMggrpa3eegzTc0dr+/YMeA0UonBrSIQIXvyT+dMY9/QRvWFt7Chc?=
 =?iso-8859-1?Q?fX2xCTcpKA+C2b8y3mY9jdYhGxY+vhFGtHORqwznJXlb7vNZe1d9TdgoEl?=
 =?iso-8859-1?Q?blOUGv9iiQZZ3i5DPGHPQhONYNQk6an+1vvF3YLok4ogcKmsnQ9+S+5mcc?=
 =?iso-8859-1?Q?I3/Hqs7mqOVBNj/ZGucWMNGchhzqwPBnnSMj2LLdz/aYO9smje9vbrF0mz?=
 =?iso-8859-1?Q?Hf+0JFFLFuoXXcX3tYnJXSsnNOdQabRkW/2m0b9RvZvaEpFX4S5GPoNFRu?=
 =?iso-8859-1?Q?R9FSVbJoXpGxoUkwaOPeIxqW2vXObaYVdVtMzAtq2/3/IXe3RYtWl7Td3e?=
 =?iso-8859-1?Q?U9kV0z27t3MsfUZdbAV+u+ecApSWLTheTeUAnhbKz5vsJ9UhP6+pizz+0L?=
 =?iso-8859-1?Q?GEpg3is6c+WHn39L+8zHtu4AcGyd72DO6eqgbGTfQNi1p6aWLU3JPLNp6f?=
 =?iso-8859-1?Q?5MFOF4csV/rvl3zuq478gJb0qZWGAE+akFeVKV66zjKyETyET07eC46GAX?=
 =?iso-8859-1?Q?wyr/GpX4Go8NC1V6xZnwJ725R5bSVV7BCAB4xfrImuSz3NKoOQVC5Ifcq+?=
 =?iso-8859-1?Q?Iw3rX93Rxxypx/isbFlQZAhHIjaXk6XvsiGD2m8DIHpsJC6x3C+nEDEK6E?=
 =?iso-8859-1?Q?NI0Q907bBGCXwg2sgZZSYH5t3nfCMihOxC3bKjKN4urKOJY+T2FBZDLUmE?=
 =?iso-8859-1?Q?phZpKu/6zjlDgD8jd+ohg1kJ3DIfhdmqB7H/88+CoomjX6CeCbybkRnqYD?=
 =?iso-8859-1?Q?eEjTMITTHwBoaSh/BAqhHtdqFlvqlZ1ByQiPH7boNpRAASrDYrajDNftwi?=
 =?iso-8859-1?Q?rMymWgx1mDkDCQrlv9GjtiJvBnIVBP+miul4UyU5F6vXqCIX8CD0NFsxV3?=
 =?iso-8859-1?Q?3HeFVyyN3KR1ybHbT9t10tKSKclSv0MQj5hoe9xczyNChEvSBME+IuiCRO?=
 =?iso-8859-1?Q?tcfjI5vstAJq4/7WiUjQRRNAEDvtNMn3Qnw2LnEK7Ei3g3Inx7aHnhJfZQ?=
 =?iso-8859-1?Q?MTbTlD1Dgao8BNQ4nPf9EncQaQVrTwm7BUHvR+k83Gh0qSCIYBwMJ/Bhl6?=
 =?iso-8859-1?Q?tamT18YJLmA/iDYwjDoFq1s6BxF12K69hQEg2j4dxKOoBINVmfuzC8Sis2?=
 =?iso-8859-1?Q?iJvYOstW4gOAHziqJKd/f7jOC/RuxD1xOUSGxXXxqkeCGTZCu8Q2q3WehM?=
 =?iso-8859-1?Q?uwnktWSRmFhbODjquZuAX/Xr7CUJrA7Xeb3+ifyPro5yOJLhnomNXPsEAb?=
 =?iso-8859-1?Q?Q8R0+aZgMj2+dwyeiQ5uu9asrPsmsmPrZuqhmkmTEswtDrngbClNZ6LM8e?=
 =?iso-8859-1?Q?m01At/JKH121HOvFZzEtIVtCpe+EIc2GR4VcAbtss+3FILUo6manK5HVEk?=
 =?iso-8859-1?Q?IbciHf+6WY1zmuVjbb/VWdYMCRQnAr4rcMb1TaHAN+7jgKKw+9ceSk878u?=
 =?iso-8859-1?Q?lcW5zjxXetbn9zpfFF8N6wf1sVuf+S/8ZsoaymNxw7b6nolRQYw70pX2nI?=
 =?iso-8859-1?Q?1L8LwftjQ1+LEeZU8THSFeEIKS2Xs4k2SEzB8nrxx1zd2SUsU1hqoh4HRD?=
 =?iso-8859-1?Q?MYS5njOVhVluLJjYjuKchl6pPEEK9X8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: g6+XdAUTIvfHKxeNYqw07ko+EqcRrvOhtDoDVX8XHAUClc+tKBjuJZsPOm9Dk+RKUpygg4JCwlkmEar8B+DoQi8sj3bi7hQa+mR2EwPTR4G+vfNW3hnxE4cD75DpAk/sVAIyebSJ2CR3Zuz/B3V5NHqoSjdA1kY53k1+9xECUbJZhTlJaXvJ2WNj6t+9O7pzLp6+mqeD/o3JTFju5ydyspRtlHUsWWcEPdglTesyfwRZBATq2gfTAKKg1FVUopbBTwW9YiBVsH6oBkZmCrvv6VEROhUSkECkPpwUJpXNxozrsKqmY1a6glk4UtlE/kLkroOXt+HykO/X7Gwr53O6fg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b4e46c-0123-4aa6-a467-08dee7235d67
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 12:27:00.9104 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +bYHLXTjR0ej8zsfhd0WE9D2H3ZyBeEyWIYfMeOuVqr1dYe3Tru4CAVSFjUhmmRNgwJmqKNmU8regNoRUqamfDtt7DoPjnnJOxzCdUkgRdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10249
X-Proofpoint-GUID: DgWjgiCXMDLp6VgudI5aShlNSvHeozyf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEzMiBTYWx0ZWRfXzAIwybAw0Kwp
 aaBW6sFDWzW0QEiO3617dkPLPufMcKTI9Wn0+AOyhhNLtJbhXw83PlA4wqVJ5ULz4GZ4gdbYasH
 MdXblFCtJy1ODjCHQzC1aXz/iLQsLMo=
X-Proofpoint-ORIG-GUID: DgWjgiCXMDLp6VgudI5aShlNSvHeozyf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEzMiBTYWx0ZWRfX77Q9YQKxZhfl
 3P8VMVjJDWDVIteXz5x7WN/6HqdELGdlw8HAFIWq9M3AdE4FkTtgqfkj8W99+2PFD605fwyp8EK
 5CNhGEyAKzc9/UXwnfpk06IVEKZJy3nENOuPqvyCa9jYGGYD7S+pijeKzMRKiumObfxuh/MMn30
 1es1bZ1EC+rn+q3/4rEgxhjGBHlWPJVt5Hi5vtl4SsyxCAzVl4QOtgek3fnQVjxL3xNrPsV7Rtt
 /xPEdobIeUceLEr8y9KQSMsOiDubGT/4tM+FXF3v0DN2MI4iWDKjKJQ/Fm+12D9+3nX2Szn3L5a
 NZOM1MlkyfsY8wFusRoxZ5zKgmgmdrxHNkanZvWLQsrHCloGwLdXyOKC2e8Wr5ZqIyj1Vm/Ag2y
 zyXrk9omQQ1CA10nIRQmBWaQZ52P5o8/40v10jnzwJit6nmS9irdSRhVyGqvPS5+utGusI/TFL5
 sKC7FPv0imxn3MtFBeA==
X-Authority-Analysis: v=2.4 cv=Itgutr/g c=1 sm=1 tr=0 ts=6a5f6597 cx=c_pps
 a=b2ykEmuCBAXBKoHv9pAjeQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22 a=64Cc0HZtAAAA:8
 a=3Gl3HxEscEPlAirTM4IA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

This isn't in practise a problem since irq->argsz is not=0A=
externally provided, it's a good hardening step nonetheless.=0A=
=0A=
Fixes: ca1add1696 ("vfio-user: implement VFIO_USER_DEVICE_GET/SET_IRQ*")=0A=
=0A=
Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>=0A=
---=0A=
 hw/vfio-user/device.c | 5 ++++-=0A=
 1 file changed, 4 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c=0A=
index 8feaa56875..daac0e21b6 100644=0A=
--- a/hw/vfio-user/device.c=0A=
+++ b/hw/vfio-user/device.c=0A=
@@ -293,7 +293,10 @@ static int vfio_user_device_io_set_irqs(VFIODevice *vb=
asedev,=0A=
      * Handle simple case=0A=
      */=0A=
     if ((irq->flags & VFIO_IRQ_SET_DATA_EVENTFD) =3D=3D 0) {=0A=
-        size =3D sizeof(VFIOUserHdr) + irq->argsz;=0A=
+        if (__builtin_add_overflow(irq->argsz, sizeof(VFIOUserHdr), &size)=
) {=0A=
+            error_printf("vfio_user_set_irqs argsz too large\n");=0A=
+            return -E2BIG;=0A=
+        }=0A=
         msgp =3D g_malloc0(size);=0A=
 =0A=
         vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_SET_IRQS, size,=
 0);=0A=
-- =0A=
2.34.1=0A=
=0A=

