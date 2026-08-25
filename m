Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CD7C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 04:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyijn-00072n-DZ; Tue, 25 Aug 2026 00:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyijl-000722-15; Tue, 25 Aug 2026 00:26:13 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyiji-0004e9-Us; Tue, 25 Aug 2026 00:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1787631970; x=1819167970;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=U7ItA47pDTY6nwhPEU85E00qAXoKb7KrLcKiVLKclik=;
 b=LFKJJ4ccvX0ha9O+FNg0e+GkrGg1vUd2655cBLkYiiSVodAujSzRBE3R
 iLRa80hY0zvPlsCPT7+kGD8bhi8lZRr135gtvXwiRQH4OKTfWLOMd8TmF
 OUbCdzLCCaj2sO6mnXOIKJnqhcMDoDIkKPISGrSIgpZxIKdthnfzrGe8w
 bwSRRuWLjblVo/AjAwS2nkG8LqGjvk7fB6Wc3cHkey42WFuNvY+zJVWRD
 XywRXZmGQtL7+uslNnJrIJMbLHZfcz1l3k03DX975yguU84phE8UooyDm
 rVzGRiLxqkbU+oUFtdgjEghZpyPICNm3zGQ62Ty5ybzx5uxFifZ/EnMKB A==;
X-CSE-ConnectionGUID: CUZ6atJfRneU9bHD3j+PVA==
X-CSE-MsgGUID: 67A0rs6pQ8GUgOHm5LikOw==
X-IronPort-AV: E=Sophos;i="6.25,242,1779120000"; d="scan'208";a="155117247"
Received: from mail-northcentralusazon11013025.outbound.protection.outlook.com
 (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.25])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Aug 2026 12:26:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EhhlwhZ3KXQAxqz05ReRVeWIV2Q+NzHsRXfrFu7V61Rl4eN4K42zRswFDq8UnSVCq9nXNKIyLSSwasovAfRkdDW5Hjaq5MzUYHBwPgEyBY77K8M1QIQK6Tkxj0GezHOgMwhegOQPgquZlj6V7QdWRx2OailkoBotf/XUXWI+4vp8W1i3Hgl4xEPXVnqTuublDbChoQTxI3CIDj0sFvpGWCg1aP5ghgn3CF8Ih/LACapK7oiJGS4/u/6nBDBHbjCLXtdEvO3KKHFSc6vqc1hPh6Smwy+1AHl3UzoBVrCE79gcy00Yig+s13/MPUL1LiXUIrUnnMco4gDmasWEcS3E3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7ItA47pDTY6nwhPEU85E00qAXoKb7KrLcKiVLKclik=;
 b=mB1crV19sLhDa/5w+tDrlzrX0apWzbggoM4VMFYs2ceUtKCRc9r/r0/Rc1Levzoi6tdsa76Q+ci4h+p1U3M+2434FsJwh95LYaS/xuYJKqC11eA4UpGRtuviKjwnX8u7dwbL8FDqw//V8dHZPmnx2BxhPOxOUh8/owiS9QltPHyzpD3haZbSdGjb+XzuT+OVXmZ1G+NPPDdtGjbGcWhNh6Vu1nk/H4PfT8e+QyyjwZ1GjNaiW+I0UNYELl6b8sQfoSZKZcD7+psRFqB2WfkeBWX/p7oMdw9bEMYEqg8HaW1vxma0IF+EDcnRUZ7Q84DexrkCyr6OJraS6u5qqmVrfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7ItA47pDTY6nwhPEU85E00qAXoKb7KrLcKiVLKclik=;
 b=m2bei4SFPVFDp3L5K+vle1Y/duZ/2HGA7h9SRU+7Z9BA6ZmWIWw8xPIOHvOCOXZG3CMgfpIznWMTUB8nkFZru63q+a+Ao5etGaqlT4plb8MpfO/sF7CjChJ7Ord1dfmK/NqqfeKFIeSbyYK8kOoY5fggOQ4eccTckURRV45Dt7Y=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by MW4PR04MB7203.namprd04.prod.outlook.com (2603:10b6:303:7a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 04:26:07 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 04:26:07 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "max.chou@sifive.com" <max.chou@sifive.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2 1/6] target/riscv: Add cfg property for SiFive int8
 matmul extensions
Thread-Topic: [PATCH v2 1/6] target/riscv: Add cfg property for SiFive int8
 matmul extensions
Thread-Index: AQHdKoI9X71N5fSDL0Si6g+9J1+JV7auPqwA
Date: Tue, 25 Aug 2026 04:26:07 +0000
Message-ID: <f6f605e544204a41b5ffeb33c7e029b04f301d5c.camel@wdc.com>
References: <20260812174417.2468981-1-max.chou@sifive.com>
 <20260812174417.2468981-2-max.chou@sifive.com>
In-Reply-To: <20260812174417.2468981-2-max.chou@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|MW4PR04MB7203:EE_
x-ms-office365-filtering-correlation-id: f0b2383f-a7e0-4aa8-1363-08df0260fbbe
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|10070799003|1800799024|23010399003|366016|376014|56012099006|10067099003|3023799007|18002099003|22082099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: IZTbRjUKmRR4ENuwA3ozyEerQ9s5JJprfk+ae7NaVYMqXwENYvqx9UylOpzejREIn9Ne1t6GdeLU/QeHaf0RWRjeNKZdhVruTg7PXuk8pyEJc2f+NdSuV6v+rgp1Urq8/4azDUS8NLAi2fdrQ/csW7sTC9FfSTLlAukQV3knUgII1nwAiPbo9MmGv+ZBCKv21lvAYCudoUzFhPwowYkYn5QH7ZMlTv6rrmX+mI8iFrcLXMG8Mfg92dKcsIAFyJczV8fRE2InfFK7ON0nrClfLNUM5EsAx76l4jv1JOCDHkWMRD0qTik/cPt9oKIMTm6vVRoGU1LzD7C6rL1JOgJswG++rbxL0umpJZdilhoxisPXax1wDZ/OwT0WQ8ZVo6uMjM2sM1YHhmTSkcZzUWImIoVkfYjxW5iCL5M0xwd0wIQ3p1aPi1HIVvhxclA1jfVhjQYeWsX6KeWjni6TDZwnrANcKAIGCbUyUxEaVAUbjkt0F0vjxJ99BAHVQVvPUdODXRs4KZNgTWrjekN/eSadOP3ntBW0oBiRXJbmVBvm09Q3739D191DXc/9uvml35jNEQTNsvmkfErlMlyccX870gJBB8Tt/OGZkGnTmpopSqEOqEkZpBsFK0xHhg/raNROEbCml73GjQ8mpXZNjjrg8tY1VPZWeP4OmgFCNc03sPHkhY9Gb1AEGZPbXssMeNmoiuCAAjLI9wcJrGGpUst4vSEpDnCOMQWKdeLS+FBXpoA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(10070799003)(1800799024)(23010399003)(366016)(376014)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3B3NmQrbjJIbmVSUDdaTnFqanMrdWVTeDNzaFh5aU81MUVJVXBPd2EvZ1p4?=
 =?utf-8?B?NzBHY3BmRGZwRFQwNURXRmVlQTdnWUltRWV2dS9US1lWazgyTUI5MlFIK3Q3?=
 =?utf-8?B?Y2d4QjJTQ0lGeEhneTBqWHJUaU50WTZDVDJHYVZoSllWNm1BMXl5RjE1N08r?=
 =?utf-8?B?TzNwRWIrZmZTaGVmSTM0TGljRnpPWVRGK3pvd3dRUmQxeTdhaUlEblI3Z2NS?=
 =?utf-8?B?c3ZMMUpxNjdWQkQ4ZkM0eUlEU0QvT1Fwdk5MdDFsSjUzYXNSV0FyVlR6N0V1?=
 =?utf-8?B?N0wxT2lqdE93VWxibTRoVmQzVC9CTjNnc2NxbUpZeGJYQUVsVG41U0xHQjZR?=
 =?utf-8?B?K1krbE9EWGpjaGw4b1oxOWNHanFlODBzbjhYWmlaa1o0QmdnaWdMV0k1cDND?=
 =?utf-8?B?d1dXUzdrNzJ2bXI2amQyMVhFMDhIRFpLL2NMZWFxOVF0S3hrbDR1U2ZoeEh1?=
 =?utf-8?B?Z2JXczlVdUk3VVQ0SkpKNUNCc2t5UGI0QW12TWlyMUhpRmR2eFhXSDBMVkt5?=
 =?utf-8?B?WThxaTY1TmJqYStIUFlibWF2dkNNdmluMlhpRjkrb2MvVnlTMm5YS0NyQkpB?=
 =?utf-8?B?L0d1UVFRRE5VSHpCeUx1QS9YWXFqeHkrNnhRd0lzQXpSc0ROOGE1OEQ4OWVq?=
 =?utf-8?B?ZDRDdE5BVHYybG9vYWZ6VHhYMEhNTERpa0YwTEVlMEI3c2dHM2hDUnVwd083?=
 =?utf-8?B?dXBmMWFDcTFxc1p5S0dTSWxhQzdiL05mZVZ2V1VNelBNcnQ5NFdEa3A3MWRO?=
 =?utf-8?B?TWlpVko5ZGV5YnFKUU1yUlFQTlJkTEVLK2M0OW9UYnluWEF1NVVxbklpSi9U?=
 =?utf-8?B?aU1WQ25CVVBsY0Z0SkVCT2daMjFrVXlucVltM2Ewd3QxSkZiTFhNZTU4YXhm?=
 =?utf-8?B?N1NKNjBQRFd4WXJzOVJ1VjYzNXNFSHF2MnBJOEFrRnBBbkRNOHZucHVCVmx1?=
 =?utf-8?B?dVFnOEZBK2c3NE9lbnIrZU03NHJZd3BIYnVSYnBDZ3NDUDB2L0J1NlQ4ejl4?=
 =?utf-8?B?dWJXZXpEUW84TzJZdjdVUDc2MzdSTjNHa205TGdBL1pnMWsrUEg3SnBhWUFr?=
 =?utf-8?B?TE1MM2VjKzdicHlaN2xIK1Z5YXdyREk3WHVwS3dSeHpFd3dQcUlmNTJoZVZZ?=
 =?utf-8?B?aWI3bVdtVTlvLy9pNGJXRjdaTXF3QUxpZXhXTWN6K25DOU9Bd3lNSGQxcFVp?=
 =?utf-8?B?cGNOM3VnTnV6TWUvRDduaFRTQnRKTXBkSHNsNDFiVkY2Ly8yV1oyK2pLcDEr?=
 =?utf-8?B?TmxGWS8xSFdLZmFjU2pubzlXeDVBSngweStBNjlhYVV3RjlIWG1PTDViK0hE?=
 =?utf-8?B?ZCtzUEFvdklLNTRkR3lVWTMxOFZVeTdqR2J6ZnNzYXN1OHl2ZEhVdVFrTDAv?=
 =?utf-8?B?U2ltNGRCRjJoeEtDNzUybTJqRFNhVit6SHQvbjBhTlFhcjRKRkdBU2FkMzVu?=
 =?utf-8?B?QzVVTHFBSHQvWWxYUjZmempCZVNOQS9TOUlGc25xaDE4R1hUQmhiUHZBWDRl?=
 =?utf-8?B?U2wrc0U4c2pJSEY1VnEwS2YzVGJMT1hCSHFlcFhWSlU2RStBMzJ4Sk9GY3k3?=
 =?utf-8?B?dHFTNTEzNTVsZm0zc1dhTkw0VmNvWUJENy9rY3A3cEJPcUdKVFJMS0xJRVg5?=
 =?utf-8?B?Y09pSHR3RkM5QmRJb2pTbkNDS2Erb0t3WXd2RHFvWUJsSXNHaGZrQmFYbnV1?=
 =?utf-8?B?ekFDN3VtRlJoVTRPWjB5UlFGSlRhVkJZcGtHZVJWMUJySEFScXdNdFIwTjMz?=
 =?utf-8?B?a0ZZV0Z0dUJlRXdnT08wSkcxd1Y0TFNQYzBmNHUzUGlxZkZIbTRnaDRrMENv?=
 =?utf-8?B?NkxlS1ZnSVE0bWZhcmV6UzQ3TGY5RE12ZmVDMEQ3UXVXNTdjaGpRK09qcE9p?=
 =?utf-8?B?bFdBQzJobTljUnNDcGd5aHFVYTdCZlVEWXQ4dkplZ20xS29EQ1VvZzJBUTRB?=
 =?utf-8?B?THhERTN6SFBxMm56UUhRbU1uanpmcE1mWEJrcnFWT24xNyt4Rzh4TGNmdlFI?=
 =?utf-8?B?aWZLMHdZbXJBTW96ODd0WExMQlZENU4wRWhydUU2Zll4NzdKN3ZQVHVialpm?=
 =?utf-8?B?aU9iRHB6aEx0R0FibUErem16Nlp5b0NKWUJyT2k2MHlyVjdYT1B2NStWTmtT?=
 =?utf-8?B?ZWJWV1ZjM2Zpa3piekEvZ2VGU09rcjN5Z3NqVTA0akdxdVFTRk9JQXlmNGR4?=
 =?utf-8?B?Vko0YlVKdTFVZE51a3hlMmo5UmNBMkJ2V3NvUlQ4V0RQbTYvM0FWa0NRL1dX?=
 =?utf-8?B?bHl5dEZxTk5WWUdWWVhBTTZ2eGVJcjI2VXZOVkNGaDZVcVRZNEozazdWbi93?=
 =?utf-8?B?eWRDVGlpWHVpVWFQU2h0M0FVUS9RY3RmRVA5WHFTQ2lsQmlycVNCVVVya1lp?=
 =?utf-8?Q?tGfwps0iJWWPpKKTagen3MPt4ZxqYkqSa8ljXtU0wAntS?=
x-ms-exchange-antispam-messagedata-1: VoTDaXONEs9J9r4NqrEe7hAUV7NVTwVjoBE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC40B291B239E049A7CC7149DB5A806C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SjS5FtjsZwd9RVjRh82bVt2+rAuqsmp5GdIBPZHAvNn9YNzZuAd0oUhSb/2OjsHyRstQG3km5RSnvv+PaDqtyzeqxNxO1UbGxUFeAzEuc1fBHLiS3e2T5Qsl5K+jlROvv5K1MRTM7u2CAzi2YYD9Z1SS13DjYIACkkfNY3bLzHkD9wxyGHVModsbmJXyCYKInDqntpyGHYEk+rVeBvPPJi/nRiWMxSD3eT1cMRMV2upBMXP4wRNmrnJCPsIqUulsAa9cq2UxQlKjI4kh95/xZ+ZdUtQ4ywOjZxWMa48G1BJMfHmoArz6njqzQITkdUyNJQbe9pUSkasut2L2sr2Xow==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: p6WeGsMegaNFpkgj78bUd0ywVCBhH2tcM8bEvYBa0h1jb5dARB3AL3iT4PnskQ2uPTL4agE7B6QxJPJmDCkSh0G7k/0/fB52HgFTuuxuBEvsI3jE6xqZCWpBr+PrfC8hNonAnmk+qHbg0Dx3zu/yjveIZqvp2DYV3I9mO1H1BcJFketOcAvDP6UcZqo7Sg3dYWHPC1fjApnC6rEYdZDZIoLFqEQm1P5vOpvhbjVvp2edO5cVk4QkBpbhgcJxBi6rPPcB3Y6Xd7iTqNYanv7++pOLRuRblW4jO6A+32b7REu1HDGKKLdpBitTICZlCmagSrhj9T9ebwArah+Wn7Y6IzMtjlpQi0xpj2WfF3LZlCdhXFTsBMHyNOjkBAgPAv6Ssaqh1JeCYwU8Bs69sGC6Fvk4gH2hmgmf1nC2oejS/G+CmjWswwZ1f++69TSr4k/7KaN4Gsxoz4ks2zEPAbtBsuQ5P0N4ZRbETDcP7U1e/XScQnigQzmm2AssBq/dDghrgNWw1PuPXMXyFqgCD4Krq0DMfJw/dge98Lyp+X8RvwEjUmt6EUJL0RiAcfWsbbyASOQOeYNOqIlWRprE2lhUZxWzw1aC3qRgFGSQdhNnoUGo1GQVNdpRPeDNGOsJ7UIV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b2383f-a7e0-4aa8-1363-08df0260fbbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 04:26:07.3149 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bpG6HZ9UPMgeSkWgf3uhNV5Fd8V5xjglPSm5EcRK8cwQ9V0XLwjBawoexVz4CN4/wfg92hx6vUA5f/JEUi7+SFK2xyURjOrcbei8DKnwtYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7203
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=690dc056c=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

T24gVGh1LCAyMDI2LTA4LTEzIGF0IDAxOjQ0ICswODAwLCBNYXggQ2hvdSB3cm90ZToNCj4gQWRk
IHRoZSBDUFUgY29uZmlnIHByb3BlcnRpZXMgZm9yIFNpRml2ZSdzIGN1c3RvbSBpbnQ4IG1hdHJp
eA0KPiBtdWx0aXBseSB2ZWN0b3IgZXh0ZW5zaW9uczoNCj4gDQo+IC0gWHNmdnFtYWNjZG9kOiAy
eDh4MiBpbnQ4IG1hdHJpeC1tdWx0aXBseS1hY2N1bXVsYXRlIG9wZXJhdGlvbnMNCj4gLSBYc2Z2
cW1hY2Nxb3E6IDR4OHg0IGludDggbWF0cml4LW11bHRpcGx5LWFjY3VtdWxhdGUgb3BlcmF0aW9u
cw0KPiANCj4gQWxsIGluc3RydWN0aW9ucyBvZiB0aGVzZSBleHRlbnNpb25zIHJlcXVpcmUgdGhl
IFp2ZTMyeCBleHRlbnNpb24NCj4gdG8gYmUgcHJlc2VudCB3aGVuZXZlciBlaXRoZXIgZXh0ZW5z
aW9uIGlzIGVuYWJsZWQuIFZhbGlkYXRlIHRoaXMNCj4gaW4gcmlzY3ZfY3B1X3ZhbGlkYXRlX3Zl
bmRvcl9leHQoKSBhbG9uZ3NpZGUgdGhlIGV4aXN0aW5nIHZlY3Rvcg0KPiBleHRlbnNpb24gdmFs
aWRhdGlvbiBpbiByaXNjdl9jcHVfdmFsaWRhdGVfc2V0X2V4dGVuc2lvbnMoKS4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IE1heCBDaG91IDxtYXguY2hvdUBzaWZpdmUuY29tPg0KPiBSZXZpZXdlZC1i
eTogRGFuaWVsIEhlbnJpcXVlIEJhcmJvemENCj4gPGRhbmllbC5iYXJib3phQG9zcy5xdWFsY29t
bS5jb20+DQoNClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lz
QHdkYy5jb20+DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKgdGFyZ2V0L3Jpc2N2L2NwdS5jwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyICsrDQo+IMKgdGFyZ2V0L3Jpc2N2L2Nw
dV9jZmdfZmllbGRzLmguaW5jIHzCoCAyICsrDQo+IMKgdGFyZ2V0L3Jpc2N2L3RjZy90Y2ctY3B1
LmPCoMKgwqDCoMKgwqDCoCB8IDE2ICsrKysrKysrKysrKysrKysNCj4gwqAzIGZpbGVzIGNoYW5n
ZWQsIDIwIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvY3B1
LmMgYi90YXJnZXQvcmlzY3YvY3B1LmMNCj4gaW5kZXggNWE4MmU2NTYzYmYuLmU2NDNkN2M3YWY3
IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3YvY3B1LmMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2
L2NwdS5jDQo+IEBAIC0yOTgsNiArMjk4LDggQEAgY29uc3QgUklTQ1ZJc2FFeHREYXRhIGlzYV9l
ZGF0YV9hcnJbXSA9IHsNCj4gwqDCoMKgwqAgSVNBX0VYVF9EQVRBX0VOVFJZKHhtaXBzY2JvcCwg
UFJJVl9WRVJTSU9OXzFfMTJfMCwNCj4gZXh0X3htaXBzY2JvcCksDQo+IMKgwqDCoMKgIElTQV9F
WFRfREFUQV9FTlRSWSh4bWlwc2Ntb3YsIFBSSVZfVkVSU0lPTl8xXzEyXzAsDQo+IGV4dF94bWlw
c2Ntb3YpLA0KPiDCoMKgwqDCoCBJU0FfRVhUX0RBVEFfRU5UUlkoeG1pcHNsc3AsIFBSSVZfVkVS
U0lPTl8xXzEyXzAsIGV4dF94bWlwc2xzcCksDQo+ICvCoMKgwqAgSVNBX0VYVF9EQVRBX0VOVFJZ
KHhzZnZxbWFjY2RvZCwgUFJJVl9WRVJTSU9OXzFfMTNfMCwNCj4gZXh0X3hzZnZxbWFjY2RvZCks
DQo+ICvCoMKgwqAgSVNBX0VYVF9EQVRBX0VOVFJZKHhzZnZxbWFjY3FvcSwgUFJJVl9WRVJTSU9O
XzFfMTNfMCwNCj4gZXh0X3hzZnZxbWFjY3FvcSksDQo+IMKgwqDCoMKgIElTQV9FWFRfREFUQV9F
TlRSWSh4dGhlYWRiYSwgUFJJVl9WRVJTSU9OXzFfMTFfMCwgZXh0X3h0aGVhZGJhKSwNCj4gwqDC
oMKgwqAgSVNBX0VYVF9EQVRBX0VOVFJZKHh0aGVhZGJiLCBQUklWX1ZFUlNJT05fMV8xMV8wLCBl
eHRfeHRoZWFkYmIpLA0KPiDCoMKgwqDCoCBJU0FfRVhUX0RBVEFfRU5UUlkoeHRoZWFkYnMsIFBS
SVZfVkVSU0lPTl8xXzExXzAsIGV4dF94dGhlYWRicyksDQo+IGRpZmYgLS1naXQgYS90YXJnZXQv
cmlzY3YvY3B1X2NmZ19maWVsZHMuaC5pbmMNCj4gYi90YXJnZXQvcmlzY3YvY3B1X2NmZ19maWVs
ZHMuaC5pbmMNCj4gaW5kZXggOWViNDdhZjBhNzYuLjczNDQ4ZmFiNWU3IDEwMDY0NA0KPiAtLS0g
YS90YXJnZXQvcmlzY3YvY3B1X2NmZ19maWVsZHMuaC5pbmMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2
L2NwdV9jZmdfZmllbGRzLmguaW5jDQo+IEBAIC0xNTYsNiArMTU2LDggQEAgQk9PTF9GSUVMRChl
eHRfeG1pcHNjYm9wKQ0KPiDCoEJPT0xfRklFTEQoZXh0X3htaXBzY21vdikNCj4gwqBCT09MX0ZJ
RUxEKGV4dF94bWlwc2xzcCkNCj4gwqBCT09MX0ZJRUxEKGV4dF94bHJicikNCj4gK0JPT0xfRklF
TEQoZXh0X3hzZnZxbWFjY2RvZCkNCj4gK0JPT0xfRklFTEQoZXh0X3hzZnZxbWFjY3FvcSkNCj4g
wqANCj4gwqBCT09MX0ZJRUxEKGJpZ19lbmRpYW4pDQo+IMKgQk9PTF9GSUVMRChtbXUpDQo+IGRp
ZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvdGNnL3RjZy1jcHUuYyBiL3RhcmdldC9yaXNjdi90Y2cv
dGNnLWNwdS5jDQo+IGluZGV4IDRhZjVjZDljNzMxLi5jOTAwMjNhMjEyMCAxMDA2NDQNCj4gLS0t
IGEvdGFyZ2V0L3Jpc2N2L3RjZy90Y2ctY3B1LmMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L3RjZy90
Y2ctY3B1LmMNCj4gQEAgLTQxNyw2ICs0MTcsMTYgQEAgc3RhdGljIHZvaWQgcmlzY3ZfY3B1X3Zh
bGlkYXRlX3YoQ1BVUklTQ1ZTdGF0ZQ0KPiAqZW52LCBSSVNDVkNQVUNvbmZpZyAqY2ZnLA0KPiDC
oMKgwqDCoCB9DQo+IMKgfQ0KPiDCoA0KPiArc3RhdGljIHZvaWQgcmlzY3ZfY3B1X3ZhbGlkYXRl
X3ZlbmRvcl9leHQoUklTQ1ZDUFUgKmNwdSwgRXJyb3INCj4gKiplcnJwKQ0KPiArew0KPiArwqDC
oMKgIGlmICgoY3B1LT5jZmcuZXh0X3hzZnZxbWFjY2RvZCB8fCBjcHUtPmNmZy5leHRfeHNmdnFt
YWNjcW9xKSAmJg0KPiArwqDCoMKgwqDCoMKgwqAgIWNwdS0+Y2ZnLmV4dF96dmUzMngpIHsNCj4g
K8KgwqDCoMKgwqDCoMKgIGVycm9yX3NldGcoZXJycCwgIlhzZnZxbWFjY2RvZC9Yc2Z2cW1hY2Nx
b3EgZXh0ZW5zaW9ucw0KPiByZXF1aXJlICINCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiWnZlMzJ4IGV4dGVuc2lvbiIpOw0KPiArwqDCoMKgwqDC
oMKgwqAgcmV0dXJuOw0KPiArwqDCoMKgIH0NCj4gK30NCj4gKw0KPiDCoHN0YXRpYyB2b2lkIHJp
c2N2X2NwdV9kaXNhYmxlX3ByaXZfc3BlY19pc2FfZXh0cyhSSVNDVkNQVSAqY3B1KQ0KPiDCoHsN
Cj4gwqDCoMKgwqAgQ1BVUklTQ1ZTdGF0ZSAqZW52ID0gJmNwdS0+ZW52Ow0KPiBAQCAtNzk0LDYg
KzgwNCwxMiBAQCB2b2lkIHJpc2N2X2NwdV92YWxpZGF0ZV9zZXRfZXh0ZW5zaW9ucyhSSVNDVkNQ
VQ0KPiAqY3B1LCBFcnJvciAqKmVycnApDQo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPiDC
oMKgwqDCoCB9DQo+IMKgDQo+ICvCoMKgwqAgcmlzY3ZfY3B1X3ZhbGlkYXRlX3ZlbmRvcl9leHQo
Y3B1LCAmbG9jYWxfZXJyKTsNCj4gK8KgwqDCoCBpZiAobG9jYWxfZXJyICE9IE5VTEwpIHsNCj4g
K8KgwqDCoMKgwqDCoMKgIGVycm9yX3Byb3BhZ2F0ZShlcnJwLCBsb2NhbF9lcnIpOw0KPiArwqDC
oMKgwqDCoMKgwqAgcmV0dXJuOw0KPiArwqDCoMKgIH0NCj4gKw0KPiDCoMKgwqDCoCBpZiAobWNj
LT5kZWYtPm1pc2FfbXhsX21heCA9PSBNWExfUlYzMiAmJiBjcHUtPmNmZy5leHRfc3Z1a3RlKSB7
DQo+IMKgwqDCoMKgwqDCoMKgwqAgZXJyb3Jfc2V0ZyhlcnJwLCAic3Z1a3RlIGlzIG5vdCBzdXBw
b3J0ZWQgZm9yIFJWMzIiKTsNCj4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo=

