Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77917C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm9Yt-00087w-5f; Tue, 21 Jul 2026 08:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wm9Yo-00086D-TQ
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:26:59 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wm9Ym-0004lW-QB
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:26:58 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LARrlB3214231; Tue, 21 Jul 2026 05:26:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=kIhjSDyWXgODxSh6rsmmtigP+mPpXfoLiNOKyF/t+
 fE=; b=fi6ehpm4ribAb78xWKveTIZijRPOFvRe2oSbvFeahCKrh25is9n/8thZZ
 LqoJySF7OEY4mlMUBpclEAYPEk9m9S3D4E1zn09to/cDYXQNhR0t9Xo9h3tP5Kph
 gRHb4XTlgf9C6Htxn1+P7mhtBoKPi+lw6BCXnATkrDhvvNR2u0G0jTipH229gCm+
 nePiGAVHiR59dXEeuEPeZtsZoPWrLvWLyPTcypDDbsfvI37MypHT4YQeyFZQ2lF7
 u6lPlfxSevwhrg0LMDHPqBV/yMhfawZvCs/6ZSQQwsgLAK3QvuREcw8xxIdukPoq
 nbIE6JtSQqObNebNphO9bkaw/N4gg==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023093.outbound.protection.outlook.com
 [40.93.196.93])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4fg90xean5-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 05:26:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jp6O2XGHd/AKX04ee4INYAwe7tgSr4vkAUhIG8GJLU2nUZyirK0lhX8e/XD1gRp37XG7XOnoWOfYsskJlWyY1JZ9WRLw9IMEfNAXacBjSVB1+BxvKjp157rpRrf32mOkar43pqLUtQEhYRVkS4zK5vmmpFvSdw0+gNu0vtCuRXpspbl8e1HtrKA6CLaXJyKPlRpzHoaFr4QMP0oDD+vXZnXNRV3aLsJEbw0/ngoYxn6ZANmqEN7VOhsS0mZHoh7ozQ5jSxjE6lHj4o6UOrVO8lWZnPmeVMib79juLfUFMAYUWkuqPZApv8KLKBjLeofopKNux+Z4pNlb65jHmeiDhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIhjSDyWXgODxSh6rsmmtigP+mPpXfoLiNOKyF/t+fE=;
 b=dulfV7gdEHiSNapYKGTd3/EAeXTVuzwJ1dnAptgWcRqY47xPXaiV4KrEM6ayKycJZREyBq8it/eH/j+Z0vnpXB9o/pHv76jLuM73oCHSHKxN1bN+c4EOV2dCbhTZ/peo4++YWbyf/0Ip8P/elSJ6cKHtY/pLgpzGn3vl7+irX3kzKgVk+8k5lsZvpvQblgW2plENXnnDwvQqRawSZtbFHp701VDcT/qugVf2448JcJlbz7lsGhDk3OFqy6vp3pKWTSQevQ42hLnW3J0el+lrwcNAolMPjeVOFRJPZ6ANbOrhEz98tnfGexCYTsqMbdn08nI3SiFENII27i0jCGFNjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIhjSDyWXgODxSh6rsmmtigP+mPpXfoLiNOKyF/t+fE=;
 b=CAuG6DxXEHEXo9yt1T0V+IAE9ThMeY3r38+hqvqqYlodqZ5+Z3dXIOB3qH8k6ae170dW2xTw+zcQZQqyyEbujDjnB2yRdJRGpYKSCbjpQH6GSEA2UgTGwZ5mGvIXhFYuCXJ2Ly0uY+Ekb1/w+Xwva2qIgwOdrOXcJ0DusemPh7t6PMXkrYEsKehroYaaXWSL9GyeVNSWwB2LoUaYkk/yG/pBN7srmkS1R0bJhvSCHW97faND9666c1dAu0PmJ07QQxtEQT+27wbU5yOAi1VW0pr+vuKfjoSvMuzMO7Sm41mLpkKiCvPwKafZKKOgHeuxJ3zSAFYDvPZLi/Zo8qSbzg==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by DS0PR02MB10249.namprd02.prod.outlook.com (2603:10b6:8:1a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 12:26:49 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%7]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 12:26:49 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>, "clg@redhat.com" <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: [PATCH v3 0/9] vfio-user: validate server responses
Thread-Topic: [PATCH v3 0/9] vfio-user: validate server responses
Thread-Index: AQHdGQw0Cg7+AyhUgkGbYOF7hhB0IQ==
Date: Tue, 21 Jul 2026 12:26:49 +0000
Message-ID: <20260721122643.30985-1-thanos.makatos@nutanix.com>
References: <20260720135823.21070-1-thanos.makatos@nutanix.com>
In-Reply-To: <20260720135823.21070-1-thanos.makatos@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|DS0PR02MB10249:EE_
x-ms-office365-filtering-correlation-id: dc9a0fe8-8473-4b2c-c18c-08dee7235694
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|22082099003|18002099003|56012099006|10067099003;
x-microsoft-antispam-message-info: vPSQr4+ACkYLTy6bYAdoqHLQ7GTIy4V0wQEdUrvJpdAcFxZWbItvq8kcxICIV+r10LktVximKH7evNlO+pPHtvtsJgqVVlyElXWYBMlAjQ402FViqY3/tYi0wi7YAT30viLrNE7p7XhDBJKXE0YFp+1LWhUKtI8ZTk0KekMDpjLD1N36KwKUPYsRqi4C7yPDAN4p2DL7Yi06rn5q1XsTmb9nW0AG/h8mIpJbRSE/V4ettkS7pZztgyYIePRYuUS03f6xDWliu7nDfZBjWACVDZ56YQbjIPj/r5+2HT/G1znvjxAgheJz9jJANMXepEz5G0p2cVhnpfzj0vIi3fsSabQSx7SEfn5FvalKTGd0xb8A+o4LVzNn11Ob0dq9bLpY9rCHVeT6e2n3FD1HeF3jqFy3Q6rYHBZXVK3nC7wgeQMKzt4iHGsuL2j/afHp7u/z/gM/gUX0hgNX7QKUpxdUjZFZUtKz1n+2ZKV4vj1AhrEQAxNu5d35RoWbzZ/Miye5355Qs7IGVj2k/BMHHF8GHNs1pNPBnDM6Hrh0mvllGSfK7dtwKw55D607gdzq+Oaa3CV54dbLYBvCCk8EILosOisOjKGrLxVrD03cTkN8Kk7W91pJtJxAELk0mH5b7wZp4dGwB3NjJj0aZt2znnN7FzA5KoTUVTpyNV3DH1TuN1C4rgTqpb/QX5Gw1U4SPlSI2yMYP2Kst7ljuo/eWZLJUchShKIeOQZzuA3zLYApfGk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?16krCDzRZn3a/WsT5zGyHdkLrgO70zXAW7DlTTM79rNH1Cr7pHOYESgSjA?=
 =?iso-8859-1?Q?SpFHLGiQS5qwCutjA4OSIPJ5ZTJBQS5ff30iXeIYrSCsg+Y/Lnzezd6+ET?=
 =?iso-8859-1?Q?GLGrteGssUaGtFwwFtOt2yZAnCDqR/JDdR/cwMsKKVy1HyK23Vu946Y/oZ?=
 =?iso-8859-1?Q?exXOg2aCkxN27XcEDQsKL17X3cTAFnZ8+16BFxX4M2BbKhcSbeshYIC3lw?=
 =?iso-8859-1?Q?9d8IQbF3NCmTrQyAbIg0FmJsKTRFydTPbqDbTsi0JhP8GalwGCZ5T6w3RN?=
 =?iso-8859-1?Q?G91yJRF/yOCxnyekj/5JZAXsmT+VqfwMUh7OK+6L2B7gLGtRBeMUMwenEI?=
 =?iso-8859-1?Q?9YNZ2C4u1E7foKt8ZOSp7v33gzuUXQzH6WJse1x7e7N2K1cgS84zjpuEsB?=
 =?iso-8859-1?Q?XK2YOklT645PBsuRyY4Aj46gR54mvwFzT/4maYXXXi+V9p88I1YLTtTy1V?=
 =?iso-8859-1?Q?B63XmEJyKCXNM+xhy3gYxnhNKajmNvmp+CA3wyGTz2awAQQsU2L27knYiY?=
 =?iso-8859-1?Q?Gua7WHlGQIWDJYrsrUkQksE2qCS7AH/h0R0/tWfmC5xNrOkhv8ivFT4HFL?=
 =?iso-8859-1?Q?VGD9IgJRSb3LAIznvMtZ6T0YtbXG4xt4oDgEKxaO7cntR2XVLcGZr8laRX?=
 =?iso-8859-1?Q?B9ef1Mr5r+bdyldY4KI6nO5omY1eIiNgr1fDT3b9wbawZcBKWAthm31lKu?=
 =?iso-8859-1?Q?8numQLwYONUdh6TgS8RZ+eVPDrQj6lClpvAZtB/8D3NbtZhCOYVphrF0sY?=
 =?iso-8859-1?Q?6QFWBUMaZcWjgeJTxFUGsp3G8SYQfqHMp3FWOnWqkbX93mVDuy+TVt9yOv?=
 =?iso-8859-1?Q?JH/JvbS7hZKti0JRx/Blu8uvrQfftwqt+44JOcsX/SuexJQ0rulGdt4DcO?=
 =?iso-8859-1?Q?nvKvIF2Ks1jQs2DvlZ7yAxy/bj6bEWPrCk/InIdDsYSalmKxdCcofGhdLJ?=
 =?iso-8859-1?Q?EsZkShjMJmQuKH3Y+Kx5y4DtY9mY97/xkaBZVMw16h7hEgNECpdI6yHZBt?=
 =?iso-8859-1?Q?ndB4jkiFOy/gAK3e9blK3RmGekPRnUeXC/U6nf1Kdy4bI2AveZEWoZiJ2u?=
 =?iso-8859-1?Q?X44i0ZxetW+MkCiwXqWWmfi7cIO5sppYAoPRe7XNo1jPhS9HQjQ0ooWyx2?=
 =?iso-8859-1?Q?kxkD8aXacJnVoHmEJTNvbgewf1/dodeqryF61P1Msn1iaoExRsg1hmhrMj?=
 =?iso-8859-1?Q?fLP+TTLSJhMPmzRRruyLcFijQT8UuR2ufuR5gyuSamG6Wrf2dU/DXkOg8f?=
 =?iso-8859-1?Q?b5cnZrZDrwbTInPpi/pEF8gGNzjKJkn7Fu72DYYngJkeBAjPZ//71Mcf0N?=
 =?iso-8859-1?Q?2CaU3FryUY4dV+eAlS5q+Mlz0eSpLHH6xG7ttVgDJiaEbs2tDRi/jTikkz?=
 =?iso-8859-1?Q?wVmtqlJ4pasiYf+74hqX0dyuH7mWK7yj9ws3Takd4mOXn789sXRBByDQBA?=
 =?iso-8859-1?Q?d/nrRWQLF3Y0wGGJ58xhMuAV/eiowEEkIHWTJXSVPgbXlY24hKQ2xpOF8k?=
 =?iso-8859-1?Q?6y6BbJ1PDnqPAcYsDBmRAhMawqq/IBkXBFBNHdp+YfLkNF8Qbm7kPp9xPy?=
 =?iso-8859-1?Q?juM5pcAhZQOcT9+Jlxh8rZcXyvCmq2hEoz2XLZesid//R1kir9awU/apew?=
 =?iso-8859-1?Q?F85RS/YcyO0Jc6d8m5jk8d/EzqjJUtrqdueEBCGeuAzC0p8H3HA/o0tv9U?=
 =?iso-8859-1?Q?YCl0pTT/Yju81qX7xG1DF7W605urNitJFkj0Z75/jvOkOXwtQFGO2R+q6R?=
 =?iso-8859-1?Q?YxZ/VUUsfpORqBp/2udb/nNwreBawvHr+lXAlHDalYlasb7JjS9X/c0N/L?=
 =?iso-8859-1?Q?gP0eW4kADvbquVSBctdb10nkM2dw4Z8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: brc4Ay9J96/zExx17lNNdh4kWfojMrzWdjSRj7FA5RVMOujlmCvJghu3vd1/FXN0eFgoIxO5Org2rvada1Dw6LGQR2ycMxZs5dQus/xIf9f+T9DRloJLSsfoEs5TipXMhndQhPeKvnOFMmBzflulpE9uh4r+tmyei4gXG+LMNA/aKE80TFFdblPneKw9yPangXG0mgnFE97zF28hvDuJK1s3qyMQVTB5H4xJcgLL7n7MkftDiB4J9z74RKv1twrwSGk0m20cKb1DBelQnZfHuOWVQVTdEmKkzNK38GThjP8MSRQJQRy0sOVYMFnaTbI6+1bX6CfQkne2ONaIAJYOtQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9a0fe8-8473-4b2c-c18c-08dee7235694
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 12:26:49.5317 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hIYfFrWo+BdEvrEs3icS+zts8B69J4jlOpxc2T4Z7+2JM1yOl2SNP5Wa5ormKZct+G8XtqSrMkiUBw8dwlf5piDOubg0ZbvhbtYm7bscY9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10249
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEzMiBTYWx0ZWRfX3wdkn2Mzprdo
 Q4ii/mv3hlwJSetmNMahnSl26g/jCHSKoqc1hziWOO+8ChuqmJjPSn9tPCKiQL1Z2BgyPF6eVnN
 FDrd7ZK1bogQiJx8h6BLubSewHaP5WU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEzMiBTYWx0ZWRfX9zPDQWrPamIU
 A2QLmj6S3LTYtSk5y3Y0W3a28LpX1+wYjWTpBbcVlv7e0J2j5pWyjaOrjEcc4l/pSwGvdDdjR1R
 RGR2beLBfM5mg2xMTS+FTDeSPD39N8ELzoxh+uKtqtItbWwO54qzUELBvp9gapO7QQFGTlrH+1T
 WpfLs85bAf7DCUxoyzrBAp7AK2/vCt1PavqkIrLrSrXHVCszjHbRwkALIwWSpZPyH2YrsELcZ69
 2KIuHO/RDW5LyGPZlPRDiD/WxMarGsKMPcWdFRo6KpH0RkjVgci+YfCOELXSus6FJ0+02Bhl/J8
 fhc29KCjMdfSFyLSV2Bkzx0KrxmmpKLRPHx9gjK/rmw3H5aoCS4lA6N4gPuFSadM52YpYZih3Nw
 30S8d8fL170jEchA0w3QGymEO95jNjfydNlmGBzb08N0gfcWuGvcXLGTwy5QT0pjhbo6F1aBTwf
 /IXOzV8YOxiqAYb9R9A==
X-Proofpoint-ORIG-GUID: -Joj7UYUdhWabi5HGhO2XC_fqufzPWIz
X-Proofpoint-GUID: -Joj7UYUdhWabi5HGhO2XC_fqufzPWIz
X-Authority-Analysis: v=2.4 cv=CfY4Irrl c=1 sm=1 tr=0 ts=6a5f658f cx=c_pps
 a=0mOrEJ06uaCo+Tyi64Ng2Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22 a=HkYWynaxqMIO22tOQZkA:9
 a=wPNLvfGTeEIA:10
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

This patch series fixes some bugs where the vfio-user client doesn't=0A=
properly validate information returned by the vfio-user server.=0A=
=0A=
=0A=
Thanos Makatos (9):=0A=
  vfio-user: vfio_user_get_region_info: prevent buffer overflow=0A=
  vfio-user: vfio_user_get_region_info: respect max_xfer_size=0A=
  vfio-user: vfio_user_get_region_info: reject unreasonably short struct=0A=
  vfio-user: vfio_user_get_region_info: prevent excessive malloc=0A=
  vfio-user: vfio_user_device_io_get_region_info: fix capability check=0A=
  vfio-user: vfio_user_device_io_device_feature: prevent buffer overflow=0A=
  vfio-user: vfio_user_device_io_device_feature: prevent excessive=0A=
    malloc=0A=
  vfio-user: vfio_user_device_io_set_irqs: prevent buffer overflow=0A=
  vfio-user: vfio_user_device_io_set_irqs: prevent excessive malloc=0A=
=0A=
 hw/vfio-user/device.c | 54 +++++++++++++++++++++++++++++++++++++++----=0A=
 1 file changed, 50 insertions(+), 4 deletions(-)=0A=
=0A=
Changes since v1:=0A=
- added 'Resolves:' in patches 1 and 5=0A=
- added missing SOB from patch 1 =0A=
- removed reassignment in patch 1=0A=
- added a new patch to address the same issue as in patch 1=0A=
=0A=
Changes since v2:=0A=
- expanded cover letter=0A=
- added 'Fixes' tags=0A=
- improved check in patch 5=0A=
- removed extraneous new line in patch 6=0A=
- added patch 7 and 9 with same check as in patch 4=0A=
- added patch 8 with same check as in patch 6=0A=
=0A=
Patches 1-5 address issues introduced by:=0A=
   667866d66620 ("vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO")=
=0A=
=0A=
Patches 6-7 address issues introduced by:=0A=
   e2358af5838d ("vfio-user: support VFIO_USER_DEVICE_FEATURE")=0A=
=0A=
Patch 8-9 addresses issues introduced by:=0A=
   ca1add1696 ("vfio-user: implement VFIO_USER_DEVICE_GET/SET_IRQ*")=0A=
=0A=
-- =0A=
2.34.1=0A=
=0A=

