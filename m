Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21A0C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3y7l-0000nG-Ra; Tue, 08 Sep 2026 11:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1x3y7g-0000iT-HX
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:52:36 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1x3y7c-0008Ex-NG
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:52:35 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688Eh6iu3514602; Tue, 8 Sep 2026 08:52:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=wiFFRE6+ON8aeTW3VlDC2hQimoGkEyiv84+mAQ+Wt
 0k=; b=Zjfl9O6MGm0EBr/Qvkb51s6/BaGrct5Rzj/YpAOVm7ZQGOim33H5oFQYg
 7ZGTdL9OqJ5Kvk5sbUrSSfrl3fPwT2uCk+Dg8Wv2MzB87ZDe+d9GFZQpGp2JJEra
 tALI9G4/MWwfl5ZNGup2OwVJucPC8qMEQbD3wx59hUnZ3oQbtjBIZPzzUHhGQqre
 aBFn1wP4Ol0uggYSWwQGjTFs5+lVk98ggfeBi/f37ppMLqE127RQNBnS5A25wXE0
 T9745cGf8XTmxKWmzKt458G7veDmn0PJaMWZeZwgo4Hy5mxRZpxsTEq1o1ZYwh31
 ItwSscW7+ruR/WrZgxE+iXY5ZMDvQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021081.outbound.protection.outlook.com [52.101.62.81])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ggh6ex0sq-4
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 08:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXRvNrzHbTAYntgUCV0R83anvrZgMyOxgsmfYICOsnJmLPhblNZW1xlU7irNJi1qZZVjBHi8yT9pr2QMCTC0sjRMlH07vlmrJZZDitKmiUAPYdnyCxEey5l47grv4cn83TfiHiGD/fN+74+3Puf6PDLWT87iSlQtL39F9vO3nE48GorLfo2eQV5+Oj+EDNYnwohUmdfQ2nMBVsYN7bHOhgECHdCfpFI3sYDwNE27zX8Wy1gVWTFsVRnoQMC7s3VWWpXj5xgRam+fvgF2OUfwmfhf7XOcAex1OJ2G+TuMiQeg78WuwrEfJc5Spb0H2x+87P79osPkg7rgKGhG94zdpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiFFRE6+ON8aeTW3VlDC2hQimoGkEyiv84+mAQ+Wt0k=;
 b=yRgW2knDUHSbuzEN8gTUBySGULQ4dcIZgc98utdZVeTQh7WSC+eOfzw1tf7nTEqYq48ZuXC2TpSl4VU1rhN7jq7OuQX0euFxyid9RRt/kqnTxP9qMx6iBmUyZ79UCIUfDsAS63+t6YcotFqpWezzOY79Hl06rnxMrbKPwO+dDXfBv54EfEuDC8+d1l9wxR2jcBgkvYofOUDgT5Vx+cz2RAmf2mCGtzeUaqTlICk26bBEPZuPmZ7ToiXIWVa5jRsLMo0DNWTjX4CeExQY7KFLyvGDexKH+9NlCEi485AFQTcf2AtG6JRgJGcmtxIjLj3cv0TVFxig5D7ncWQVBpDznw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiFFRE6+ON8aeTW3VlDC2hQimoGkEyiv84+mAQ+Wt0k=;
 b=TJrBgHPBMGiKfYOFW39bwynCsZ/o6+/jeUFTqov00SXobCUUgY9SWm+SuF4gKt6mQ/VAolHpyzXvNBfvcxeCNHbnd/X2vfgiBV+HSvgCaqeISsIZxMcry+u7hOrHBM1TlyATXU6dCu1LKxyHIF8u6sB+f/LNXHbK+JqXvbUujC4wcFZdYP/2egNWneF8oH5JomMPh/fLpAPXHenr0aWKsPotOFA/SVtApOraCwfTFYxcxFJULlDg/stxF6xTx6eetAA8SQXeZsoSlJ/iqTKcz1X3jtwtPC3w0ZqNVZBhXf9v5M73JtIWihEpi17qhp0tm1uk/tRdGdHG1zIsz78VVw==
Received: from SA1PR02MB8368.namprd02.prod.outlook.com (2603:10b6:806:1f3::18)
 by BN0PR02MB8064.namprd02.prod.outlook.com (2603:10b6:408:149::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 15:52:26 +0000
Received: from SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2]) by SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2%3]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 15:52:26 +0000
From: David Vrabel <david.vrabel@nutanix.com>
To: David Vrabel <david.vrabel@nutanix.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: [PATCH v2 3/4] hw/pci-bridge: Default the generic PCIe root port as
 Gen6 capable
Thread-Topic: [PATCH v2 3/4] hw/pci-bridge: Default the generic PCIe root port
 as Gen6 capable
Thread-Index: AQHdP6oL9O9Mw2/ps0m1xjmZ4zrXdQ==
Date: Tue, 8 Sep 2026 15:52:26 +0000
Message-ID: <20260908155223.164787-4-david.vrabel@nutanix.com>
References: <20260908155223.164787-1-david.vrabel@nutanix.com>
In-Reply-To: <20260908155223.164787-1-david.vrabel@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR02MB8368:EE_|BN0PR02MB8064:EE_
x-ms-office365-filtering-correlation-id: dbe985c4-3b62-4a9d-3185-08df0dc12e5a
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|18002099003|22082099003|38070700021|56012099006|10067099003;
x-microsoft-antispam-message-info: asapG6vLV0t4D4YIPGIiyDZ5n8DQilP5TqNrscLW3Mto6guX16L4gCulmsJsDaY679bXe3nbjRKhn7vXHMa67/PIIHuJLHJHd/iTDHhO70ICqv0wIE7jxzsma6yQYm+W+/gr9qDFgTkOx/y392xJoIKrJwIFJn6hlSQhEg0GBxEf5l87KMN3Zw8hX41jyia7Rw8HZDK1BIFgaKs0KRqN9v5VABj2Dhr7i08ALko1iz8tmRcQaclngLAM3FoSrCdRO90xpcLiIFksKENdfInn3RiywOKy/kCMCMj5OERsoB///ZW8TFthe3s6Koibe5x49ow642oXHBajEBWmKpKeg0gF/iYhQzgXs2RJImF06tpDINQ8QrkYxfS6ljZYGBB8RAexQUGAgU8lj9q+oTZTpDPRTbxi9EmVZFVq3YTXCDhFuKdOz59lqanQRrkIpdLsbWt8Yb5RLyQH2MoCiklQkzNW3ZsXCuM6HXXeozhhidJsvYCltENESi8GnkqUtRI2nzggso1ZGBvQm8kysgNcVdyvXKu3d3EAdRJzUjS+rNN02rLpXkv0Ek2If0wRs/ufsQLOlURRR61Hrp35YNo0NYHVmre6fsHNZ6yoe8n6Bq9fLBZJIyiM/UABbE4qbJPBFPE3nYWSMMIFtDlpiI4k9P8qsiG99s9uqtaiaEwjYsO1KJsXyxV0+1t+2AyFsunkMu1RHjRAAlZWg/oWFYjD3pK1KQTTFMya6to3RiJdQZU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR02MB8368.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(38070700021)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Zg6qHGHdgdd0V4mINjx4Op3QdNqu86gXsT4+OuLvFx0leh+wh+ELolXqJz?=
 =?iso-8859-1?Q?K4ULI12CVH2HSp22q9XOzhoo4ZYAXc0nsZPnHcR1opoxPWAay7NYsu5ZNO?=
 =?iso-8859-1?Q?g792ZKmG99psZ0m4taQjIaOVzBuj5UgRnCOz0aiyGRYfWhOMOLV1zy3x23?=
 =?iso-8859-1?Q?tsIcxeBZHv+i5xLplqwv/KKL2yK2qR3K7NL72izHpdVpnJgLsQGYaoJaav?=
 =?iso-8859-1?Q?d+IMIouVgPFYLOKg8yN9dp84CjcP9xvdjPftiQT3jMcfMhyiGPWRt0Vz2G?=
 =?iso-8859-1?Q?XO88UtBXDAPxJPkSNXto+LLjK2MLjTPaU3nVp+Sc0JVtJz3cJS+5QCaAyg?=
 =?iso-8859-1?Q?p3PZGw6oVzEbyzZ727nGsthPcrw3ZO3wr296ne9zyq27JjolaUMgvpxVDX?=
 =?iso-8859-1?Q?IphEuzA+KMiJF7NDh4ktbS82nbTQ/FpnQM2lcFR6bVFoY1JIsxQQvOdbJ/?=
 =?iso-8859-1?Q?EYGkY30xYo9aDJFGDtjrAMLs/T2PFbO51ibqBIvWF+BG6yksgUmru1yMlc?=
 =?iso-8859-1?Q?q8RGzSQZjYO3X5glbggCvZQjht+NSnL9bZ9JTlbI/eaIwRGmkKum6ANzQ7?=
 =?iso-8859-1?Q?W/nO8xzEt8mPDcdT19cDqvwXb/VUUDt149RKkmp0qofkAXBwDO0BLzBVGk?=
 =?iso-8859-1?Q?cKbSfqJUxNs29yFXKQNcchzuMlBFrsWLMtMpgRvwV26ltApYIQ1wOfBbgK?=
 =?iso-8859-1?Q?hkZQ16ibi1KGE1wojCIDZUmDFnD5/ilmQgdaqieYXcBRW1FQxAWV4/jB5k?=
 =?iso-8859-1?Q?fUEJcxv814S2l5ee0C0i4hiYkfbOL05XhZwTSemDsL2xKZswCbdwwCaO+S?=
 =?iso-8859-1?Q?bHukPV8EMtYOJ4Xgy1jon7oJIs6TdoHdIfRVyI/AIQ5eLkS3T/HQg2sbCh?=
 =?iso-8859-1?Q?HMxwBdpfbNpPmwWeP+ruV8Z47VMymVLeAyUryXQuVVGiqjjOQEyOWfm8UV?=
 =?iso-8859-1?Q?fbmwAprZpp3SnI/JtuiSjF2Ht6+FewCb6ku5LhxyiA4u0kAeT/7I1kK/zC?=
 =?iso-8859-1?Q?6KLTr8spsGS8riSGtNEwV5bQfffsjNteVewI7PyCwVXLZw8D3KsflMQSeC?=
 =?iso-8859-1?Q?aKpJ14+sthcRbp97AwdgDKwhAHl4c6hhMeft54wr58SXbVAsgnZKwDKFpa?=
 =?iso-8859-1?Q?G+OcXnxv82b6bZsOpdfbTyGjVB2ljN8RPF9ss7s2eLoA2Ym9CuGnFlAjts?=
 =?iso-8859-1?Q?p5r0gG1tiZQpsiqk2qO5L8VzyrJ5U1AY0xfBO3kOVGtt/3RTXOWjIzYSF6?=
 =?iso-8859-1?Q?hEmNWro/sf8BVs+lAI0o6HrhjUxTF2mB4ovZDToBO9sTXS3M8hsGMqUjl7?=
 =?iso-8859-1?Q?T1v+qjLVwiCM6yeCvLmuIgTq3QQ42z3tA/90W61L1bBJAMPvn6j07FtPUI?=
 =?iso-8859-1?Q?G3Dj4c8Q2L31W/YIuxRqjpK54r69jMAbazhD/cvLJiIFxlrWXPb/Z4RQIR?=
 =?iso-8859-1?Q?6Pxr2oZyjMIzfhmlgFztG9dgECLZqGBs74VNPJ+YAmXxr9To5uLKt5Rn+I?=
 =?iso-8859-1?Q?0+mDTBU1tuar5fAFUovX2VEXgSdlgjO34jL1d3R2GoM84ax+gz3zz6V/8Q?=
 =?iso-8859-1?Q?6ZKLxhnPgvgAz8GvC+ZEqV/fl9ZD3JGXKfTkt9EZQkVNTBcRhnxjtt1jVD?=
 =?iso-8859-1?Q?D6yDndBRjHWWOsDiZm01sqivUxqUvfV9Cqu6UQUMRv8+J/nEPnorpgiAqq?=
 =?iso-8859-1?Q?B8Ptk9d2j3NPxuiXwy9FAvBW9GYR5zXqJTuhskuytYpiVf3au7I9Ws1bDx?=
 =?iso-8859-1?Q?42Ug0IOrWm/++xy9rZ3gjATtGZAOlfCj7GStB36BySI6DbYsAIC5OqfCmn?=
 =?iso-8859-1?Q?MvFdAwcPq4N2exnNw1aAoK/dslYMJWA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QP83+JjJy7s1WDIuTjig3ZWe08fvlhS9SwaR2jccQkXRzAJZoW4I9ovb/RvvxOOBGjXo3672cJ4OOU9SIx2hkY5DSwtQU5DhalUibqbm2idDXe+0WnVd/NFsP4mBj/lClxygy44zk5ZZmfgEjkWc8Kmdw8FjxVmoZNfkJSKf8O439OAl29M7A53HdiEFhLfAAXLBQRdqELX5EJ3gLasVBi971SYR8dkEBScjlECLUM3prywX/GZtZUj+w6lPCLx6QzDxroFyPjGwn0Ht5HV+S37TdmzrKGkUYurebqQ/ePZo9cpnCXq8R7L9tZVLfUp8Wq+TxNWTiY/IIYbMDyUGCg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe985c4-3b62-4a9d-3185-08df0dc12e5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 15:52:26.7102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l6ja07iWkClo9cVHIlOEOXObtzgput/5WZq55GX54hHtWpdtdMl21vMNoDOESC4vIfxbLB/Q0RLQKwmQr3TJ+703Nd4f2IdM0BaPfyfH5UA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8064
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE3MSBTYWx0ZWRfX7hKSSmfMVx3g
 hcbXU6ukahhPcVnfE4d2zkMG3dJAHaanmVlvflrWli9uqLy3Or/uaKURoCdyfKnzB4TYv0MGviu
 0ijnfxR8uFWkExxt8H5VJnEeKoFe54y+XE6gyOC7shzCgF3TFvQchYrAT/Ce+qhaJbNUq9c46+7
 u7bUYlHYVtvtUP9P7/01NyaggGbJOTzQzT1usiE7pSYzObkPSfq6n/m41IuJv0yjaQGWHAh480f
 PA3RGj9W0oKWTY3lMRub+hrZ1akmnqOedC+1i3/VgzfN5HiytUHh3xRmouKUFX1PWbu31QYuwGE
 bd/NzqSdbcZavsVvXDa9CzWDhmByEfHe19+4UgHsBC3pw1qQRKaCaU1/5d76atbgf/XOBG9Okl6
 R1Iqsn5qD5pgP290uEitqzDhU657e7kCR98UZHAqUQg7Xr8tp3h0o6VbaQ4G9uKG7Ze11oLxsSQ
 wh/Dypy3xfuO5DfFhVg==
X-Authority-Analysis: v=2.4 cv=I4hVgtgg c=1 sm=1 tr=0 ts=6aa02f3d cx=c_pps
 a=7ywGlyDdJUFJDTdbuALIzQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22 a=64Cc0HZtAAAA:8
 a=BlouRpKd5MmS78s8ARwA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: uxDqjkX8HWlI5qAPkaYo5X3kvp35v8mf
X-Proofpoint-GUID: uxDqjkX8HWlI5qAPkaYo5X3kvp35v8mf
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE3MSBTYWx0ZWRfXzlttyjGeVHAG
 urDBvv3OApo/hI9+u6Rq/lCflNOY6lwB2vUFAymfNGLQWJqBfJvhrGDbZJuddjVd2riw1Z4HlYl
 KeXGvwxHuIuCBfRDIdJFD2APG6EG2cg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=david.vrabel@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

As part of making virtual PCIe topology having the same apparent=0A=
bandwidth as a the underlying hardware, make the generic PCIe root=0A=
port support maximum speed so by default it doesn't appear to be a=0A=
bottleneck.=0A=
=0A=
This also makes the three generic PCIe ports (root, upstream, and=0A=
downstream) have the same link speed/width capabilities.=0A=
=0A=
Signed-off-by: David Vrabel <david.vrabel@nutanix.com>=0A=
---=0A=
 hw/pci-bridge/gen_pcie_root_port.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_ro=
ot_port.c=0A=
index d3ace7f0db..8cabeadac8 100644=0A=
--- a/hw/pci-bridge/gen_pcie_root_port.c=0A=
+++ b/hw/pci-bridge/gen_pcie_root_port.c=0A=
@@ -130,7 +130,7 @@ static const Property gen_rp_props[] =3D {=0A=
     DEFINE_PROP_SIZE("pref64-reserve", GenPCIERootPort,=0A=
                      res_reserve.mem_pref_64, -1),=0A=
     DEFINE_PROP_PCIE_LINK_SPEED("speed", PCIESlot,=0A=
-                                speed, PCIE_LINK_SPEED_16),=0A=
+                                speed, PCIE_LINK_SPEED_64),=0A=
     DEFINE_PROP_PCIE_LINK_WIDTH("width", PCIESlot,=0A=
                                 width, PCIE_LINK_WIDTH_32),=0A=
 };=0A=
-- =0A=
2.43.0=0A=
=0A=

