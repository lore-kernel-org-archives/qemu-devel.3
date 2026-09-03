Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1714CC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x27BZ-0004uu-Jw; Thu, 03 Sep 2026 09:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1x27BX-0004tv-KJ; Thu, 03 Sep 2026 09:08:55 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1x27BV-0007bC-0E; Thu, 03 Sep 2026 09:08:55 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683B08kU135535; Thu, 3 Sep 2026 06:08:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Q6hekypY2LJ/ySKwbHBbrCgmvIjmW8XLx6zwnZScV
 mE=; b=n2IiFY9fWfFPKUKa86P5ZIjD67nluMioJ6I1NTMxgkEORzZJOolph71uu
 z6tmlTbAKMgpo5juOwMf4j9O1HLUsRN0HjSBEPKOaZVkvPFwPkYgcWDyk4KmCNhH
 BpfEeyMUWWnmSvGxXcS5uezkH7aIVAQBF+DlhXr3HQSPI5hDcP44o52QOe/vsR5Y
 HHyFA32BDMR97vM5KgV+Etr6syKDX4fkA3gtpUbzBslpOc5IjVPIyo9o8G1hGc42
 4GMXfviKlltT8Nd6CF+3TNhIT7jYylciVC9IcHzb1BVZNDJwZ/866/ryDRvD4ANe
 6d/iwQpyjGELAA2ukcfusC/Mr7CgQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023129.outbound.protection.outlook.com
 [40.107.201.129])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4geduy415m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 06:08:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBnEBLvwgo4X/YicZ6MUh50R5i6EIqAKyvZohQCo8x53F9ZxfQhUfDfD3V5iNttNYqHem5IOunt9FSZnRp9PrqdL5XOxIgVcUOjwYtCEnnZbkjCHpM0UUqLK7WAycROP/0aLaPs5O8YQEKTSgX72zfpIJ6nDC1peyncH6vciyA3R67PV7maDNFAqyiYtyYWO+M8Kdo+gbcMSyLGts6cv0VlxV1Do07dEKo/wYZrAd7V1p+rMmpR3krOws1wG4e8VGn9gOGFsLAmC/cNShzmAe9aR78EsquGTzx/WUQG9b8qy+lwer9i5RmoYdN4vLWYdo6J01O7ZZmrVJImvSZ/cwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6hekypY2LJ/ySKwbHBbrCgmvIjmW8XLx6zwnZScVmE=;
 b=E80gwmxxzkrOF5EQ2GPA913JXqvD/mYdvP98V+IAAHRQLRsAF/tqpVANUoGhmdQgyBcGYehFmmEiOeMeJpUgCxzNt+mbqHxXVQgCCxnkYUffOtutfOyLvHsghyAhIH4TLjT3xnstXOHYsLlsgz4qre2QjKVYdaG4uUUnjPWTxHjKffroWw/6C89CckX3dIx6PXv/eIEB7deWeASsUMSV3DhczXlUAf5GYc3HUKHJxFP2ctvEM4X/wd2dGOz6JVh9I6ssLb+RvNzD420pMMM/VJ8fGv+57Ugxj1gmQ10IPwDUHqhE1JXIAJFkMuSBKIf4V7PjuYvg6DRYOh2hkXidKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6hekypY2LJ/ySKwbHBbrCgmvIjmW8XLx6zwnZScVmE=;
 b=zDlo91okCFJF62KzCLmjXdUs4TWANdiJeE++LFuiELtGuqJ7tmdFCjIt00/+zH68ehRf8zIiMlO/Oh1oEfp7B/u6hRX4ybY/SrwNQQ3zb9Mp48tIbRKJTiRv1IKK1WHy1LuEKxnF0gkLpJO2M+BUSaa3WOP8stN6XzDJBHg4TqHV1jGBq8Bm36i4HpVx+Gm68YugTihYtp5GCK+Gb1gsjKCUg4r8LYGHa0/Lf8P1zvZfFGMLWU5SHB6RrcOZLxtbv/lDTlgay0xO1F3qNRLG0+to3nv9wrCOzRp5tiLX70Or+LBkN9wP7Bg0Gs1euUSUJ41578/8Ra+knWw59dscvQ==
Received: from DM6PR02MB6172.namprd02.prod.outlook.com (2603:10b6:5:1fe::18)
 by PH8PR02MB11926.namprd02.prod.outlook.com (2603:10b6:510:40a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 13:08:46 +0000
Received: from DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd]) by DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd%6]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 13:08:46 +0000
From: Hugo Komatsu <hugo.komatsu@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Alex Williamson
 <alex@shazbot.org>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Rafael Castillo <rafael@trfs.me>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH 4/8] vfio: route device_reset through io_ops
Thread-Topic: [PATCH 4/8] vfio: route device_reset through io_ops
Thread-Index: AQHdO6Vabc6l4bj+6Eqm5jrrBb4gUQ==
Date: Thu, 3 Sep 2026 13:08:45 +0000
Message-ID: <20260903130833.1437632-5-hugo.komatsu@nutanix.com>
References: <20260903130833.1437632-1-hugo.komatsu@nutanix.com>
In-Reply-To: <20260903130833.1437632-1-hugo.komatsu@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR02MB6172:EE_|PH8PR02MB11926:EE_
x-ms-office365-filtering-correlation-id: 83be81ad-7cc6-4a4f-8f46-08df09bc7ca4
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|22082099003|56012099006|10067099003|5023799004|6133799003|18002099003|38070700021;
x-microsoft-antispam-message-info: EL/htg5bVfsiBbVV4cSgq6CuCqY5Y3BYzmX56NqHNWzQqF5XM/GEfhAJGbBaKXSQOTJA4DKZ5k10LAlyYHF1HLJ0ST7Dh2NinlRHPPy7w8THub/0fkqL8ISAfaN/SINXYzNboDJPBfIcd6u6cTsTAbtKPfZjPv2jeIZbs4Ub02WN4e6pwp0oJ0/R8GOmnsYgvtBg/e3MAPUpe3kFXXP6hC+lboxOw7nmhoT1A33jss56kFCcVWkd4FPZh/TgGTajNf6DFG+AN93p4LiO4ItTsMnxxlfFepYInpNwNOb+kOpaNJg9Yfae4hk4ge8kXlxUijyBZP3EHk5H+WLgASlzhLK1VZG1rTD83f4nMva0oQhnsX1jaH1QNVeO/rA951VllzUlcAs4+zh1Ftwroa5ainhVvkieSpzIQysWFOwIh1oGnifAyhjpzp6EnlqgXbGK17GAXLSC5hK1vPOn+F4/3hbezZgGjWLhZzs3GPeyEAK5l3x76v9dikkDR9DJDh54ZxJLEn7IOmpNiy9PC0F5tZfg4x4CD6D5pbvkwLcM3ZsOh4sYi4wenFQsJmokoYvU75BjM3KZaEOv4EIYNt8qtb9tgBoX8Wdqa3aDeijM5hPbSOG9x0SCr66ziC1z3grB3/xVpuG5du3ufJ55EOzNQcs0XNja/xGXd729DWYNNLW0zEgmEN8PArdN095EqztIhc/SUYbRoHOJLtlycU42l24ReT9UuFspAcK7JEv/W0U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR02MB6172.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(22082099003)(56012099006)(10067099003)(5023799004)(6133799003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXA3c0JvOW1ETStXbm42NXhUOWJuS3BjOThrdFgxTjY4dHEzeVVkZTRjN1VL?=
 =?utf-8?B?SUFBQWdsVEt4Rjk4UG4yZnVvZ2EybCtaTjVyQlZlWGF1czRnTTdyTXJ1aVBF?=
 =?utf-8?B?L1A3SUovN1VsMUZCY2Mzby9QYnZIS0NsQTZCRGpRVFBFckF1SzVZUnRoYkg1?=
 =?utf-8?B?TUN5TW05TkJJRDNyUUpZem5aTG5heVZJZTdWK0pCM0xiZDZUV3ZSSFVZZytP?=
 =?utf-8?B?Y0NKQUdadjZDVnBtTzd0cmdQMmRRRHlqNGtVa1lZeFhNQ1g5Ylp5bFhvNVc2?=
 =?utf-8?B?SXhGSkdXOGdJckExZ2ZMSkovZjd1RytvbWRZb1doNHgvbHRHUHhkQkdrbUdj?=
 =?utf-8?B?VU1vVkJEdDR0OXBFZkNiTHg4LzBXRzF0eVBsVmx2bG5wb1N0L1Q0UTVYTmxl?=
 =?utf-8?B?MFNNWkVBV3VWakJQMDE0eXJ1WGpPMHBlcmoxdVJMVzdIaFhiR2V6eXBKTkd2?=
 =?utf-8?B?NTBFSXRmQ0lJVnd1WlgyOFZLTmpIdnVWb0VHVDZMRjk5dGVEOGRRTzZudWJ1?=
 =?utf-8?B?VmZlZnBnNHVXOWVzWGZ6a3FOWVRldXdMdjEwZFUzc3NabmxPRTJtc1VFSzYr?=
 =?utf-8?B?ZmpWQjBKdUtaN255TXRNVlkzVWpKRXVWVDk1aW9ESFVLOHVaYXBwTVFGOW5n?=
 =?utf-8?B?ZGl6Q0ZRTkxrSi9LTVFFdk1ubWEwZDhNWi9xb0h1TzNMMDUrbGgvYkxaMFpO?=
 =?utf-8?B?ejR2U2U4cDVUcjdBWHVUcU5DR0R2cWRNM0FCMXJkZGFmbWF0MDZsbjZ4SGVq?=
 =?utf-8?B?bGtuNUxVWXNOU1Ntc09TYTlkczdRSXdqVHZDUm5BUE5adnFYRENHai9VQ2ln?=
 =?utf-8?B?blZQbG1DN241RkpTV1h5WDlEWmZaV3RJK2JySTRKeC9oT0NuL2h5RU5GVEIz?=
 =?utf-8?B?ZFRVZnZXZTE2RFVxeEhEc3BHdFdHS3Y1Z2Z4WWVxeCtMRGdjTnhDU1R0RHo0?=
 =?utf-8?B?emxBOEpFeUczL0dTblpOU2dNZVBocGRWVGtubGNDUmxZWHovUTk2V2Fha1g5?=
 =?utf-8?B?eW5jRXloWUVLSmVta3psVExJWUYybTJLdHVycmdhTEJTb1d1b05FQXVENkxI?=
 =?utf-8?B?czR5TW1JVE1TTTE3SDI5bW5iblJYMVFuWW12WjV0Qk9UbVowS0oyMHljQ1p6?=
 =?utf-8?B?cjZSTlE1aFJuOWlsVXZhbjhnRHF1MEdlSURwNU93QVhyYjBQeDNKR3N2TnIw?=
 =?utf-8?B?TGxuTEtQanR1eENsS0xHUmZuZHlJalNXMnh3d2tVNWhpL3ZTNWVEb3p4N01E?=
 =?utf-8?B?Zi9sWDEvQ2s4QjF4TjIxSDJ0TXJSbXlwcmtpdjdWaHJmZmhadXZOYlVRS1ov?=
 =?utf-8?B?TGxta1lwWmJqc0w3R2J5dTFyUTdQQVY0SjlkMVgzVGJ4VWhFMDdnUHp4YzRS?=
 =?utf-8?B?MUFPaXVCRTdDeTh0OThrM2tHMW1ydjZFbGIrSlB4cEZyTGJZYnNheTExaC9D?=
 =?utf-8?B?L0ZnbytLcFhHbXBVRW5TNmlEc3dvY3poWGZHcDJmZVBSZFZYUTNhV0Jja3hF?=
 =?utf-8?B?SVBaMUlLb2NOOXJPR25wU3hpVyt3d2RQdnVsMnZDMUFyNWVpTUhoVGl4Zzlr?=
 =?utf-8?B?cVRyYWpMOHdvN0ppUTV5eFoycWxWNTFUdzIwY3NFTmNIcVI1alJpY2hodnY0?=
 =?utf-8?B?SXMzMU82b21BdlJ4KzZwL3ZTWGY5bndWYzcwaHYrcjJXMDZna1ZDekJ4UFdi?=
 =?utf-8?B?dmlrYkVMSDBWcllJL2xLNGROQzlRbk9HRDhmNGFDVi9Dc0wvcExaaXNhdDg0?=
 =?utf-8?B?U3hPZnJvb05GRVVRNFd3dEhnNjJXamJSYmpDSE9xVTRmcGRaSFpUNWtWd1hl?=
 =?utf-8?B?MGl6OVRyUm5MVXFoMG5PTjRzRkxqWWR4NmZoNkNJbms4a1VTQ0tab0o2Q0RY?=
 =?utf-8?B?aGZVMlhHNzBhTm1LbW9oV0hYamVzMlRNUXpIdWNhVysydElsb2F0ZFZsTnor?=
 =?utf-8?B?K2xTdDJ4SXdKTStvRCtvNE40b0ltOC9oaTdLREVrMEVwMmk1Z1hFZmJhZGtp?=
 =?utf-8?B?TENBd21WOU9yalJtdkNEdEU0VkxsQWlRSzh6SSs2ZnhkYm5aT0pxbnJDT1Rq?=
 =?utf-8?B?endXQWl3bFgvak9zR21tWVBOVzRUbmQvZG1HU2N6bWw3MUFOUkRJSmJtTll2?=
 =?utf-8?B?bkdKSndDVDV5ZDVMUlYxWktrYlo1V01vSjl0bXhPU1ExWndWbDEyMEdWMkV6?=
 =?utf-8?B?TXJxL3JaY3FmMjlkcy9KNEh2QVExaVBTZFArbkVtenB3bURpS2NZNnlzN0JQ?=
 =?utf-8?B?VXFxRDdqeERrbjJyVU1aa1I3WG5HV2Qyb3VwcUVGUkRrcm1tYWllN1N4MSs5?=
 =?utf-8?B?UlA4TVhkY2pOZUd5VDN2Zm1BaGtRbTRzMkx0MDUyUktweVkwcG4wUGNRb0xk?=
 =?utf-8?Q?kcdeT1BE74JQ1zb4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FQW6YHE+p9p3PE/TIMZg/XFavt2rpLLwRTveMX9AFH8ZLC71y6qAvUpDHewBHCKXZ/z4RfrJy63sXWX0wJ7RKs4sSV1u4Siy46BBYlXs2U8OlTM5/CxhpB6QOGcMdCdIDLpNtcaroIxeV97d/aPkCOsNHctVcFliGFybW1u+uE8rxNa7i2r7oPfqyMR98lMk7LcJarFrBGumb58oFOJJMp8xUjrQVPuAWLYQEN5/63Amp4bCUU+6+D9Ai7Ltv7naC6Lah932iKagPm8gJbp7Ys7PXlXjZgbBtEAUmXURMBHm8lMaLoG9zYPFD5KnQk7IseCWWBtlmAEYx35CFNBIMg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6172.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83be81ad-7cc6-4a4f-8f46-08df09bc7ca4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 13:08:45.9089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fkSFPYaOviMbIcbwfoCaRx3zIRjvLgIm8M7tIvpHLsIdfAJJ68FNMmU+Y0tGV9TO+WpmWCzRECcM/olUv7Xkg3ZmNMUUH+ZxRAp+zGK6x9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR02MB11926
X-Proofpoint-GUID: iL4VF1hjDL1TuuXHM_uxWE2IuKFcTElT
X-Proofpoint-ORIG-GUID: iL4VF1hjDL1TuuXHM_uxWE2IuKFcTElT
X-Authority-Analysis: v=2.4 cv=SpWgLvO0 c=1 sm=1 tr=0 ts=6a99715f cx=c_pps
 a=roYWoV4TocsuA6t8t8h9Ow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22 a=64Cc0HZtAAAA:8
 a=chM7D27z34fU7Nou4gIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDExMyBTYWx0ZWRfXxqDNtNT87QHO
 xr9/88sC/1+YgOyS+RNoNpp+eRFfbEm7Ijk72tKcpXgN8T/BCj92xtsWiuNhJqUFxca0YccsoIN
 ZUbdmOvLZP/ibSZQPtt+S3xezG5kR14=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDExMyBTYWx0ZWRfX67AhPtXy7uR5
 soePr2LLW+OIPJY/Nbz0EHr9tlqyX0ZRz2C3z9B3RnLYPwF1MTWyFrSzw7lmFoMWXPUJHTfbVzW
 QzuuXzWmr+/qFvSq/HnmRQhUFQ8BJthpgGR1mke+fZj694Ws1MdVLSkLqtDC1PLTE4J/QBEedh6
 THISNw8mnTumjKLBnwQCqMACYI5AcN+C5VPD7uLornYdHurWvn+D/1OSJxmhfANwOcC6BCpmhr3
 t5Y6oeipx3wPeFIesdB85BO2EmWLcOeUl7IsblKsFOnjX6Nynagqjrft/sfCaYaUnpuj64vlSMI
 bjUxKpwiHFrD1+aunEKDXE6roKkizkD0v/OX9EDEBTwtGAvNtgOfskdZtHLTnIM6Wtw3cq75//T
 LoGbV4Gd/BGa1Zv4gABuVTAbO5YqthNaFxDn0Ocxh1T8t1yso8Vu2xHatLsvAXB5Ww+/j1T/uWK
 zL/HWmN0O9G1U3ht5wg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=hugo.komatsu@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

VmFyaW91cyBzdWJzeXN0ZW1zIGFjcm9zcyBRRU1VIGlzc3VlIGtlcm5lbCBpb2N0bHMgZGlyZWN0
bHkgZm9yClZGSU9fREVWSUNFX1JFU0VULiBSb3V0ZSB0aGVzZSB0aHJvdWdoIGEgbmV3IGRldmlj
ZV9yZXNldCBzbG90IGluIHRoZQpWRklPRGV2aWNlSU9PcHMgdGFibGUgc28gYW4gYWx0ZXJuYXRl
IHRyYW5zcG9ydCAodmZpby11c2VyKSBjYW4gc3VwcGx5Cml0cyBvd24gaW1wbGVtZW50YXRpb24u
CgpJbXBsZW1lbnQgdGhlIGtlcm5lbCB2ZXJzaW9uIGFzIGEgdGhpbiB3cmFwcGVyIGFyb3VuZCB0
aGUgZXhpc3RpbmcKaW9jdGwoKSBjYWxsLiBUaGlzIGlzIGEgcHVyZSBwcmVwYXJhdG9yeSByZWZh
Y3RvcjogdGhlIGtlcm5lbCBwYXRoCmlzIHVuY2hhbmdlZC4KCkNvLWF1dGhvcmVkLWJ5OiBSYWZh
ZWwgQ2FzdGlsbG8gPHJhZmFlbEB0cmZzLm1lPgpTaWduZWQtb2ZmLWJ5OiBIdWdvIEtvbWF0c3Ug
PGh1Z28ua29tYXRzdUBudXRhbml4LmNvbT4KLS0tCiBody92ZmlvL2FwLmMgICAgICAgICAgICAg
ICAgICB8ICA0ICsrLS0KIGh3L3ZmaW8vY2N3LmMgICAgICAgICAgICAgICAgIHwgIDIgKy0KIGh3
L3ZmaW8vZGV2aWNlLmMgICAgICAgICAgICAgIHwgMTMgKysrKysrKysrKystLQogaHcvdmZpby9t
aWdyYXRpb24uYyAgICAgICAgICAgfCAgNyArKysrLS0tCiBody92ZmlvL3BjaS5jICAgICAgICAg
ICAgICAgICB8ICA0ICsrLS0KIGluY2x1ZGUvaHcvdmZpby92ZmlvLWRldmljZS5oIHwgMTEgKysr
KysrKysrKysKIDYgZmlsZXMgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvaHcvdmZpby9hcC5jIGIvaHcvdmZpby9hcC5jCmluZGV4IDZlMmEx
MjIzZWEuLjNmNzY1MmI0ZTIgMTAwNjQ0Ci0tLSBhL2h3L3ZmaW8vYXAuYworKysgYi9ody92Zmlv
L2FwLmMKQEAgLTI4OCwxMCArMjg4LDEwIEBAIHN0YXRpYyB2b2lkIHZmaW9fYXBfcmVzZXQoRGV2
aWNlU3RhdGUgKmRldikKICAgICBpbnQgcmV0OwogICAgIFZGSU9BUERldmljZSAqdmFwZGV2ID0g
VkZJT19BUF9ERVZJQ0UoZGV2KTsKIAotICAgIHJldCA9IGlvY3RsKHZhcGRldi0+dmRldi5mZCwg
VkZJT19ERVZJQ0VfUkVTRVQpOworICAgIHJldCA9IHZhcGRldi0+dmRldi5pb19vcHMtPmRldmlj
ZV9yZXNldCgmdmFwZGV2LT52ZGV2KTsKICAgICBpZiAocmV0KSB7CiAgICAgICAgIGVycm9yX3Jl
cG9ydCgiJXM6IGZhaWxlZCB0byByZXNldCAlcyBkZXZpY2U6ICVzIiwgX19mdW5jX18sCi0gICAg
ICAgICAgICAgICAgICAgICB2YXBkZXYtPnZkZXYubmFtZSwgc3RyZXJyb3IoZXJybm8pKTsKKyAg
ICAgICAgICAgICAgICAgICAgIHZhcGRldi0+dmRldi5uYW1lLCBzdHJlcnJvcigtcmV0KSk7CiAg
ICAgfQogfQogCmRpZmYgLS1naXQgYS9ody92ZmlvL2Njdy5jIGIvaHcvdmZpby9jY3cuYwppbmRl
eCBjM2RjN2MxOTYyLi42ZDUzMDdlNTY4IDEwMDY0NAotLS0gYS9ody92ZmlvL2Njdy5jCisrKyBi
L2h3L3ZmaW8vY2N3LmMKQEAgLTI0MSw3ICsyNDEsNyBAQCBzdGF0aWMgdm9pZCB2ZmlvX2Njd19y
ZXNldChEZXZpY2VTdGF0ZSAqZGV2KQogewogICAgIFZGSU9DQ1dEZXZpY2UgKnZjZGV2ID0gVkZJ
T19DQ1coZGV2KTsKIAotICAgIGlvY3RsKHZjZGV2LT52ZGV2LmZkLCBWRklPX0RFVklDRV9SRVNF
VCk7CisgICAgdmNkZXYtPnZkZXYuaW9fb3BzLT5kZXZpY2VfcmVzZXQoJnZjZGV2LT52ZGV2KTsK
IH0KIAogc3RhdGljIHZvaWQgdmZpb19jY3dfY3J3X3JlYWQoVkZJT0NDV0RldmljZSAqdmNkZXYp
CmRpZmYgLS1naXQgYS9ody92ZmlvL2RldmljZS5jIGIvaHcvdmZpby9kZXZpY2UuYwppbmRleCA0
ZjExOTU5NjMzLi5lN2QyOTM3MTBlIDEwMDY0NAotLS0gYS9ody92ZmlvL2RldmljZS5jCisrKyBi
L2h3L3ZmaW8vZGV2aWNlLmMKQEAgLTU3OCw5ICs1NzgsMTggQEAgaW50IHZmaW9fZGV2aWNlX2dl
dF9mZWF0dXJlKFZGSU9EZXZpY2UgKnZiYXNlZGV2LAogfQogCiAvKgotICogVHJhZGl0aW9uYWwg
aW9jdGwoKSBiYXNlZCBpbworICogVkZJT0RldmljZUlPT3BzIGltcGxlbWVudGF0aW9uIGZvciB0
aGUga2VybmVsIFZGSU8gYmFja2VuZC4KICAqLwogCitzdGF0aWMgaW50IHZmaW9fZGV2aWNlX2lv
X2RldmljZV9yZXNldChWRklPRGV2aWNlICp2YmFzZWRldikKK3sKKyAgICBpbnQgcmV0OworCisg
ICAgcmV0ID0gaW9jdGwodmJhc2VkZXYtPmZkLCBWRklPX0RFVklDRV9SRVNFVCk7CisKKyAgICBy
ZXR1cm4gcmV0IDwgMCA/IC1lcnJubyA6IHJldDsKK30KKwogc3RhdGljIGludCB2ZmlvX2Rldmlj
ZV9pb19kZXZpY2VfZmVhdHVyZShWRklPRGV2aWNlICp2YmFzZWRldiwKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZmaW9fZGV2aWNlX2ZlYXR1cmUgKmZl
YXR1cmUpCiB7CkBAIC02NTksNyArNjY4LDcgQEAgc3RhdGljIGludCB2ZmlvX2RldmljZV9pb19y
ZWdpb25fd3JpdGUoVkZJT0RldmljZSAqdmJhc2VkZXYsIHVpbnQ4X3QgaW5kZXgsCiAKIHN0YXRp
YyBWRklPRGV2aWNlSU9PcHMgdmZpb19kZXZpY2VfaW9fb3BzX2lvY3RsID0gewogICAgIC5jYXBh
YmlsaXRpZXMgPSBWRklPX0lPX0NBUF9ETUFfQlVGLAotCisgICAgLmRldmljZV9yZXNldCA9IHZm
aW9fZGV2aWNlX2lvX2RldmljZV9yZXNldCwKICAgICAuZGV2aWNlX2ZlYXR1cmUgPSB2ZmlvX2Rl
dmljZV9pb19kZXZpY2VfZmVhdHVyZSwKICAgICAuZ2V0X3JlZ2lvbl9pbmZvID0gdmZpb19kZXZp
Y2VfaW9fZ2V0X3JlZ2lvbl9pbmZvLAogICAgIC5nZXRfaXJxX2luZm8gPSB2ZmlvX2RldmljZV9p
b19nZXRfaXJxX2luZm8sCmRpZmYgLS1naXQgYS9ody92ZmlvL21pZ3JhdGlvbi5jIGIvaHcvdmZp
by9taWdyYXRpb24uYwppbmRleCBlYTY3MzQ4MjNiLi4xOTQxNjc4ZTI5IDEwMDY0NAotLS0gYS9o
dy92ZmlvL21pZ3JhdGlvbi5jCisrKyBiL2h3L3ZmaW8vbWlncmF0aW9uLmMKQEAgLTE0Miw3ICsx
NDIsNyBAQCBpbnQgdmZpb19taWdyYXRpb25fc2V0X3N0YXRlKFZGSU9EZXZpY2UgKnZiYXNlZGV2
LAogICAgIHN0cnVjdCB2ZmlvX2RldmljZV9mZWF0dXJlICpmZWF0dXJlID0gKHN0cnVjdCB2Zmlv
X2RldmljZV9mZWF0dXJlICopYnVmOwogICAgIHN0cnVjdCB2ZmlvX2RldmljZV9mZWF0dXJlX21p
Z19zdGF0ZSAqbWlnX3N0YXRlID0KICAgICAgICAgKHN0cnVjdCB2ZmlvX2RldmljZV9mZWF0dXJl
X21pZ19zdGF0ZSAqKWZlYXR1cmUtPmRhdGE7Ci0gICAgaW50IHJldDsKKyAgICBpbnQgcmV0LCBy
ZXNldF9yZXQ7CiAgICAgZ19hdXRvZnJlZSBjaGFyICplcnJvcl9wcmVmaXggPQogICAgICAgICBn
X3N0cmR1cF9wcmludGYoIiVzOiBGYWlsZWQgc2V0dGluZyBkZXZpY2Ugc3RhdGUgdG8gJXMuIiwK
ICAgICAgICAgICAgICAgICAgICAgICAgIHZiYXNlZGV2LT5uYW1lLCBtaWdfc3RhdGVfdG9fc3Ry
KG5ld19zdGF0ZSkpOwpAQCAtMjE5LDkgKzIxOSwxMCBAQCBpbnQgdmZpb19taWdyYXRpb25fc2V0
X3N0YXRlKFZGSU9EZXZpY2UgKnZiYXNlZGV2LAogICAgIHJldHVybiAwOwogCiByZXNldF9kZXZp
Y2U6Ci0gICAgaWYgKGlvY3RsKHZiYXNlZGV2LT5mZCwgVkZJT19ERVZJQ0VfUkVTRVQpKSB7Cisg
ICAgcmVzZXRfcmV0ID0gdmJhc2VkZXYtPmlvX29wcy0+ZGV2aWNlX3Jlc2V0KHZiYXNlZGV2KTsK
KyAgICBpZiAocmVzZXRfcmV0KSB7CiAgICAgICAgIGh3X2Vycm9yKCIlczogRmFpbGVkIHJlc2V0
dGluZyBkZXZpY2UsIGVycjogJXMiLCB2YmFzZWRldi0+bmFtZSwKLSAgICAgICAgICAgICAgICAg
c3RyZXJyb3IoZXJybm8pKTsKKyAgICAgICAgICAgICAgICAgc3RyZXJyb3IoLXJlc2V0X3JldCkp
OwogICAgIH0KIAogICAgIHZmaW9fbWlncmF0aW9uX3NldF9kZXZpY2Vfc3RhdGUodmJhc2VkZXYs
IFZGSU9fREVWSUNFX1NUQVRFX1JVTk5JTkcpOwpkaWZmIC0tZ2l0IGEvaHcvdmZpby9wY2kuYyBi
L2h3L3ZmaW8vcGNpLmMKaW5kZXggNDI4YWIyZjA2OS4uMTJmMjk3NGQxOSAxMDA2NDQKLS0tIGEv
aHcvdmZpby9wY2kuYworKysgYi9ody92ZmlvL3BjaS5jCkBAIC0zNzg1LDcgKzM3ODUsNyBAQCBz
dGF0aWMgdm9pZCB2ZmlvX3BjaV9yZXNldChEZXZpY2VTdGF0ZSAqZGV2KQogCiAgICAgaWYgKHZk
ZXYtPnZiYXNlZGV2LnJlc2V0X3dvcmtzICYmCiAgICAgICAgICh2ZGV2LT5oYXNfZmxyIHx8ICF2
ZGV2LT5oYXNfcG1fcmVzZXQpICYmCi0gICAgICAgICFpb2N0bCh2ZGV2LT52YmFzZWRldi5mZCwg
VkZJT19ERVZJQ0VfUkVTRVQpKSB7CisgICAgICAgICF2ZGV2LT52YmFzZWRldi5pb19vcHMtPmRl
dmljZV9yZXNldCgmdmRldi0+dmJhc2VkZXYpKSB7CiAgICAgICAgIHRyYWNlX3ZmaW9fcGNpX3Jl
c2V0X2Zscih2ZGV2LT52YmFzZWRldi5uYW1lKTsKICAgICAgICAgZ290byBwb3N0X3Jlc2V0Owog
ICAgIH0KQEAgLTM3OTcsNyArMzc5Nyw3IEBAIHN0YXRpYyB2b2lkIHZmaW9fcGNpX3Jlc2V0KERl
dmljZVN0YXRlICpkZXYpCiAKICAgICAvKiBJZiBub3RoaW5nIGVsc2Ugd29ya3MgYW5kIHRoZSBk
ZXZpY2Ugc3VwcG9ydHMgUE0gcmVzZXQsIHVzZSBpdCAqLwogICAgIGlmICh2ZGV2LT52YmFzZWRl
di5yZXNldF93b3JrcyAmJiB2ZGV2LT5oYXNfcG1fcmVzZXQgJiYKLSAgICAgICAgIWlvY3RsKHZk
ZXYtPnZiYXNlZGV2LmZkLCBWRklPX0RFVklDRV9SRVNFVCkpIHsKKyAgICAgICAgIXZkZXYtPnZi
YXNlZGV2LmlvX29wcy0+ZGV2aWNlX3Jlc2V0KCZ2ZGV2LT52YmFzZWRldikpIHsKICAgICAgICAg
dHJhY2VfdmZpb19wY2lfcmVzZXRfcG0odmRldi0+dmJhc2VkZXYubmFtZSk7CiAgICAgICAgIGdv
dG8gcG9zdF9yZXNldDsKICAgICB9CmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1k
ZXZpY2UuaCBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLWRldmljZS5oCmluZGV4IDg0NzI0MjBkM2Yu
LmE4ZmVkNTUwZWIgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWRldmljZS5oCisr
KyBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLWRldmljZS5oCkBAIC0xOTEsNiArMTkxLDE3IEBAIHN0
cnVjdCBWRklPRGV2aWNlSU9PcHMgewogICAgICAqLwogICAgIHVpbnQ2NF90IGNhcGFiaWxpdGll
czsKIAorICAgIC8qKgorICAgICAqIEBkZXZpY2VfcmVzZXQKKyAgICAgKgorICAgICAqIFBlcmZv
cm0gYSBkZXZpY2UgcmVzZXQuCisgICAgICoKKyAgICAgKiBAdmRldjogI1ZGSU9EZXZpY2UgdG8g
dXNlCisgICAgICoKKyAgICAgKiBSZXR1cm5zIDAgb24gc3VjY2VzcyBvciAtZXJybm8uCisgICAg
ICovCisgICAgaW50ICgqZGV2aWNlX3Jlc2V0KShWRklPRGV2aWNlICp2ZGV2KTsKKwogICAgIC8q
KgogICAgICAqIEBkZXZpY2VfZmVhdHVyZQogICAgICAqCi0tIAoyLjM5LjMKCg==

