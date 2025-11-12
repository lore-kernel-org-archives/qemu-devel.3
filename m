Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05601CCFA18
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 01:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ03H-0006fV-O7; Tue, 11 Nov 2025 20:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vJ03A-0006cV-Gu; Tue, 11 Nov 2025 20:53:32 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vJ038-0002GF-1C; Tue, 11 Nov 2025 20:53:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifj7szt54flDM8k1A0RhtbFNix9pRFP7rvyvSiA0JuuwOoKyZBVO0jJrHndmYFOZaXXsW9swzm8qRzJN2VHBTdUYAWVZlrsAr/CJhdiFyA8SVaYwYk35gbDxauN8261QreaAoo1slSWqYED6YwzDJn422TQt2+IwlgccFBegLTo6AVJCRfAPQiOAGYfMXXnbYW7HF3YDKYBeYRNQ0xUujRJv2hbAyXmlhCMbKOxOr7t1nVIad9oXlI6IslnnVLRFuwMvsniVAwogN1JdIyVo7wh48QbC75bxH1BO58zNkuG0YBpViY8DCLaS/KoD1Umi9KG2CejSwo2LSq6tIu2KsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+40KJFWSu1vImbArSKjhMbyf70g0kfl0gTuIRwmHVk=;
 b=dxd+bZhne9+lXkCRVi0OyfyuV2hxIUg+aA8nnZ7UeIxtp1UkwQBAVeegInHnq+tlmlli0npTP84K3PONZJCodzISwiOnr7VYhjc9ULgmtiUh7t8bJ7Xh2RJLeMfg+tmQ//etADVKVr5iHa6xePMJu+jgXcmvp0UYI5cRYvM13BI/CNoE/vKAucbTXQIBnvGnJALfcBEN31ahWuN5azP7Znzb2bh9Z0o0eTPhCFnlj7mdO1p97PbddPkm0z3mSRoza0oPcv9SKmT3+OIjKRVrFPkOtS1GMIWjK2fbfl5mpQSYC1kYR50pXPcE64Xoh6hphs47oFtSXkS1CheX5pfsXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+40KJFWSu1vImbArSKjhMbyf70g0kfl0gTuIRwmHVk=;
 b=EAJYZUcrE782G+yb/bvz/8Ui3OxtjsrYgBXou6T5ACQtVzQUJI3947I2vHQHPv1ufZFQEWPgK0N5kIbtwZIewMiBbhlxAla9eL0nuT2msSDVVKTs9CFAfgYNTTJZiFwG8i6agRAYG6skhSx+rpGAB80zFM2fbrBVM6V3BHR3ZS4Wsh23dwggEwVEIX8by7OUCjKGLHLfi5AxmS9BzCqOBZFFPt9gOK5tpEeU6IpTVwMWrQPZCHIksrGURx/zljjtTV/7MVPaI1BgoRbc+scTtycoW7mdyKgKh7eQwnSGcPdXp0up3m8Otzp4l1IJYa+NLn0zv0ivaMtHA1fZUbSmWg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6579.apcprd06.prod.outlook.com (2603:1096:820:f3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.15; Wed, 12 Nov
 2025 01:53:19 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5%3]) with mapi id 15.20.9298.010; Wed, 12 Nov 2025
 01:53:19 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: RE: [PATCH v1 09/12] hw/arm/aspeed_ast10x0_evb: Add AST1060 EVB
 machine support
Thread-Topic: [PATCH v1 09/12] hw/arm/aspeed_ast10x0_evb: Add AST1060 EVB
 machine support
Thread-Index: AQHcTvpJZgcmMrohVECXi7UA2tDIq7Tt0dkAgAB90cA=
Date: Wed, 12 Nov 2025 01:53:19 +0000
Message-ID: <TYPPR06MB82069216568E2B8EBA70759AFCCCA@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20251106084925.1253704-1-jamin_lin@aspeedtech.com>
 <20251106084925.1253704-10-jamin_lin@aspeedtech.com>
 <a589c937-33bb-4647-9282-d9d1e2c15131@kaod.org>
In-Reply-To: <a589c937-33bb-4647-9282-d9d1e2c15131@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6579:EE_
x-ms-office365-filtering-correlation-id: 154fca44-8170-4a01-7d17-08de218e40fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?aUl4VEUyYmVnQUhHTU8ydlVvcDBVaEVVMU1oZ0NrL2ZUM2tvS2hRcFFOenpV?=
 =?utf-8?B?Z2pLRlJ2djR4M2E0UkNoWmtJRFRWc0dkN21lL1l2YS85VFdEZFducmZFc2cv?=
 =?utf-8?B?MGIzRjR4UWdabHRrK1Jkb2hNcjhkNzZGc1lWd0QwK3Q3c3JLZ3M1b3FHRHpN?=
 =?utf-8?B?VzBFaDVKTFEwSVhteEF0S0NUcHZ5SWlIQXpWWFdBNEMwQUpka3ZNdHBjUG8w?=
 =?utf-8?B?a0tWQWRqSzRFQ0ViUDdHcnZEZVI5MVUrVHBCZXFvekZMZGNHRFF6WUFHd0Iy?=
 =?utf-8?B?U05nUUdPRTFSNHh2Y0xlbTB2OFF6VWJoMm9pTWY2ekpPalJva2FBd1h4UU5o?=
 =?utf-8?B?NWR4TGZPWGwxRmdoOFBWMzFpMzVLaCs1VGFiZTdZK3dSamIvKzBya29MOWVU?=
 =?utf-8?B?U3ZkRlBpNlRTVjZHS2VzV0pBRExRbXBqeUdYdGxyNFl3R3pvWkplZTNiUVNK?=
 =?utf-8?B?SUVkencwbzh2Y0diaG5ma0xVTlladTdmd3lUWUFKQzIxK0tOWCtWQzlZVFp1?=
 =?utf-8?B?T3FuOVVJcWtReE5wdytSNHlGYjJvSW1sb1NndGxkV2YxRzN0aUpMb056clRU?=
 =?utf-8?B?cDEyRXV4ZFo1MjdxMTFNQXlUVUR3S3RlSnpIYkpBQ0M3QUEzRE14Q1VDMDhU?=
 =?utf-8?B?NUpTb2s0S2lZYi80cXU2K1ZDZnNtYXNLRUF6VDZEVSszOWdrNWQvdGx6eWVL?=
 =?utf-8?B?aXNZVlBYN2F6RTZ5NXJTVC9UVTloZGRsamxTTmtGL3hWaUJHZkVqZEk2eW5a?=
 =?utf-8?B?UWo4S2lsOWhtSGROQ1BQTU9Eb0J1V3l3MTBpWjk0eG9wRDJvS1lSN1hTZXFx?=
 =?utf-8?B?L21pemdhQ2RlV2x5Y0pXa01lRVpQUFV5RHA4QS9SR3dXMVZJZno4cDg0dzUy?=
 =?utf-8?B?ekp0ZGJWVDJyYTFyK0FUaTkyZkpEV1hQc2dZbkljNjBiOGQ0YVhHWkZIOFhC?=
 =?utf-8?B?S0lVR2tleFlId285SEVjMkE2ZUN5a081ZGdZa1l6SnFPZjRIRHU3dFl4Mngy?=
 =?utf-8?B?RGlXZFN1cDRYbmRmUzVuUTk1c2VBd0ZkR2V6aU1YRlJqOWdnQi81eSt5cXVE?=
 =?utf-8?B?Y0w5bHhBaDBlZnQ4SUk3Y2RTUVRuQWE2ckRMQ0lnNGx0dGVMOUxzQ24zM1h4?=
 =?utf-8?B?NzlDV05hUFFzc0NWS1loVmJ4VE5PTHNtZFhVV0tDdC9FU21meFZJajc5czBS?=
 =?utf-8?B?QmF3MHpVRU1Wb0NVWVBWY1dBQkhZZzQvbjlBQnZSaDY1UFBMbnhPemlPTjJu?=
 =?utf-8?B?Q0VwTHNZOWVvZWQrQ1c4ZE5BS1JPRXFibmFjTlZQVWRDaGk5TWJQNm5DcVRu?=
 =?utf-8?B?dWJKOWNaMzRqUUNNaWhlSDFxRHdHSEpQZEcwQ2hONU8xNWMrdGt1VE1veFB1?=
 =?utf-8?B?L2tjRXAyNy8rdlBPK0VZbURGQTU4Y1djRUtmWERldTZyUCtuM1pLaDdvdlM4?=
 =?utf-8?B?QkJXRHowYXRxNlNoOHBGYzRDODJic1hhQTlIeGkwRVg3Nm8xMkZkL0dGbDZp?=
 =?utf-8?B?Z1lrR1kweStZeUI2c0RsTEFmbFVJTFVMdnAvY0FCK21LNERncmxkeXlMakln?=
 =?utf-8?B?SHhQd3JxekR5cHo0OUZubm9mNVd3ZVJBQTJLQU1CUjI0TDFKeWZxY3NvNVNK?=
 =?utf-8?B?MVBGcVA5WWdJVWlud084YzhydHkrdnhuZVdKN1grdUhYKytHUmtwaHhjOG5a?=
 =?utf-8?B?WTRpYkN0OUkyOWRiaU50cmc5enNKblN1TmVWUjNrYStKSGpnQUplcTQ3cm9r?=
 =?utf-8?B?akdORTR0MzBBcWNyRTlNd0dXN28yTUgrQk9NNm9RNXpTK0kvZDVYUDFjc0FU?=
 =?utf-8?B?c2RWOXRYcWsvQllyQnE5UWRWK1BwOTQrTDhyZzIxbURtZXpDV1VkL0dZWXI1?=
 =?utf-8?B?QnlrZk40N25sVnJVZkpBaktoNUNzcHZDNWdsQ1hWaFQxQXpPc3BoN1kyOUo0?=
 =?utf-8?B?MHRyTEhaSGZVVFkzdTUzNXR1ekw5VHYrb25ISEhGTWp6a0FieGRrT1Avbm1K?=
 =?utf-8?B?UW93cnU3M2N5ZTROL1BjZmtoNStROGFLR21yNHRMYnl1SkxhcDFuREhIV1VW?=
 =?utf-8?B?R0kwWFpYWmpuZ3pIem83QVZPWXRkdjM5ZHJEZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UCtUQzUzTEhaU0MzZXhMZnM2ZDZCUnJJbnZiOXhSTmlSWC9JRDlpeE4xUHVz?=
 =?utf-8?B?dDNOUEVYeVlIbnFsQ3k0NkZ1Qklnd2FQSUtDK0QxYzY4NWM2ZkxTZzlsdkt2?=
 =?utf-8?B?aXhZQUJucmNsYzFORC8vZnFPM25MVEFNTktaa3VjU3M4N1dQRHEzMzBJNk5r?=
 =?utf-8?B?ZkJKc1ZUQzhsNlFNYU9CMjBVek05SjAwVHFvdVA5ckE0UHp0bERzRGpxcGpO?=
 =?utf-8?B?UXppdUFOaTBsWXFqbzFTazZpS0FUNU5EYVZQT1JZaXJub2pETUhKVS9vd0wx?=
 =?utf-8?B?YnN3MEZiaWlFb2RQdEt3MUVhQ1FoWXowcWRMMW9WbE94ZGpWOVcvdGkwRkdx?=
 =?utf-8?B?ZDRZZnNlM0ViRHNRSW9QZ1pjMmJXT3JteWNKemF4aDBaNTcvbmVTbFAxdGtF?=
 =?utf-8?B?OXUyQk9OS3FKTjlsRnV3T0FzUC96S0pDcTBtN2dYN3JYQ25LMlFybHNaWlpH?=
 =?utf-8?B?M1hSMG80SVVyY01LSWdUZVZndGlRQThTN0NySmpGcmpTTzVSazlFbmhNbE9m?=
 =?utf-8?B?TktPWVc1ZjI3OFhUcGdYWGc3L0tFeElyOFlwbkdpOE84bUlCNTY3TTI2NWVs?=
 =?utf-8?B?MHBrZ0xNMzVjOU9NT1Rld0hiZFA4Uy9nUW94Zm9XcFZhTW9GWW1CZ1JseCs5?=
 =?utf-8?B?T0xOdW45UnVKRnVsVExkNmp6QmtrdU1EV2FMekcyUTJkcmMzL2V1aHZSVVAw?=
 =?utf-8?B?cE1xQ2RwN0NYQ0dFVzloOGNrRHlhR0FWMHErcGF3aWxVdzJzb2RYKzRXZ3dD?=
 =?utf-8?B?aVBhRDUycEYvbUZKUm5xVEhBQVE5RXc1ZFIwWWRXbDFSMFp4WmVsTnZSMVlZ?=
 =?utf-8?B?Z1hxelNRL3p4YVJqMlo4LzlsYk1NTUc4UDhyeTJnVitVS3A0bEhSdDVjN1pp?=
 =?utf-8?B?K2xKRmx3Kyt3LzMwOG5IbTNkazhTVThUNkpYdmpVWHUwL1BqTFRXajdjdTZR?=
 =?utf-8?B?MTZWQ3ZDTXlmMDZZZEs4TXNPcFRYNW5PMEZZQVErTDZERG4vTFpsRFc4dnZK?=
 =?utf-8?B?VFRWWDBMWGFVckpQWnpSUWtOcFNaL3VKanE2UjVVbTdzVWRFWTJReGRKelk4?=
 =?utf-8?B?aGVPU2hiS2E3U0E2c2dza21WTEMxUkVGZ3FxRVEwR1ZLOGM1ZHJ0aHF2QkRk?=
 =?utf-8?B?QjhRdGJjbWt2WURaU2N0UDJJV2NnVkVVM3owbUFUdnN2RWFCUVNwZVpKL0hI?=
 =?utf-8?B?MHdjMVdIMmljYVhlRnpHa05WaXY4d05PQmpEdm5iaWdPSUhLSS9ycWNUSGlI?=
 =?utf-8?B?T0VsNnJ2RWhsT1gwWm56QW1CNDFZQjd0WEw3UTBuTXZGb3h4aThBVXpSYnUr?=
 =?utf-8?B?MDFLSTJ2QUVkeXRGbmMvcllpZWU2bVdwYzloSkZCVENiVnZNc1dhKzFYeW01?=
 =?utf-8?B?TDJobDBLeTNKTlVUQ3htN3R6MUlNbzFuOFlMQmpMU2hFb2w4VFZVOVJhazU1?=
 =?utf-8?B?VGlTSlZhMjViUUk4aVZ0ODdNQUtJYUQ1VFZhWVRWQkFEVUVaUlZySG5ldjla?=
 =?utf-8?B?MEljTTNubzFOTVBsVllMRkdnYVNHeHBvWTZ0UXhubi9nV09JTFpQQk9Iazc3?=
 =?utf-8?B?KzRoejJFNVpRQ09sT0tNejhaWmVmWWh4cHc2Lzk5WXpqQ1ZKd2FGb05weWo5?=
 =?utf-8?B?QTVjKzZQaWVCNkpWbnUrTjloZlhIeGxPTDdxVFVFQ2VERm10b0JwWnp6RFhk?=
 =?utf-8?B?bkVDYjNyMHFaRnJqMXhaa2w2SWlXZE56WTNoaStQZjR2Vng3MHdqZ3hBZHlu?=
 =?utf-8?B?OHRyOGtMbk5Cb3JPekhtZVFlUU9ydER0OE92WitaeEdOTjg3LzFKM1BBVlZn?=
 =?utf-8?B?NWJ5M2pXUmY1ZXA3T09FT3ZicW5aOGNSd2sxMGJaUTV2eHAySlZVYlcraHhL?=
 =?utf-8?B?Qm5wMG1GZWNLZjZwam02a2lnNDZ2SzJUOExVVmZUT0hLRGZ2eGhlWlBjWGxn?=
 =?utf-8?B?MXF4TS9XNHF0VFMzS3hCK0FhMWdhWjVXQUJ2MDcrVjFtKzhoUGhDRWxLWUNQ?=
 =?utf-8?B?OEczVVdlVUVMM2hSZ2N6aDV6VDZYVjljWFkxM0VsTHhzUXppVVV6TFJ2RFQz?=
 =?utf-8?B?UU5EWHNYa05pWEdkSmVqZ0djdS9PVzllenlUakVJczhaNkJXZTJoNlcxRmwy?=
 =?utf-8?Q?VVlubygaK9gj67g+GUSrfkq6t?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154fca44-8170-4a01-7d17-08de218e40fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 01:53:19.2290 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JpwuFK5HqHHC1oe6P9bPyGUu6ecRVG20Znzu97ukei5ZmsGRxfE6AkyzbhHDIMgBwHUEotl8u01X14VeVOeazv/Q8YUJRi3lkZ2MT7FDGkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6579
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

SGkgQ8OpZHJpYywNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDA5LzEyXSBody9hcm0vYXNw
ZWVkX2FzdDEweDBfZXZiOiBBZGQgQVNUMTA2MCBFVkINCj4gbWFjaGluZSBzdXBwb3J0DQo+IA0K
PiBPbiAxMS82LzI1IDA5OjQ5LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gQWRkIGEgbmV3IG1hY2hp
bmUgZGVmaW5pdGlvbiBhc3QxMDYwLWV2YiB0byBzdXBwb3J0IHRoZSBBc3BlZWQgQVNUMTA2MA0K
PiA+IGV2YWx1YXRpb24gYm9hcmQuIFRoZSBuZXcgRVZCIHJldXNlcyB0aGUgc2FtZSBNaW5pQk1D
IGZyYW1ld29yayB1c2VkDQo+ID4gYnkgQVNUMTAzMCwgYXMgYm90aCBTb0NzIHNoYXJlIHRoZSBz
YW1lIGNvcmUgcGVyaXBoZXJhbHMgYW5kDQo+ID4gY29udHJvbGxlciBkZXNpZ25zLg0KPiA+DQo+
ID4gVGhlIEFTVDEwNjAgRVZCIG1hY2hpbmUgaW5pdGlhbGl6ZXMgdGhlIGFzdDEwNjAtYTIgU29D
IGFuZCBzZXRzIHRoZQ0KPiA+IEZNQyBhbmQgU1BJIGZsYXNoIG1vZGVscyAodzI1cTgwYmwgYW5k
IHcyNXEwMmp2bSkgZm9yIHNpbXVsYXRpb24uDQo+ID4gVGhpcyBlbmFibGVzIFFFTVUgdG8gYm9v
dCBhbmQgZW11bGF0ZSBmaXJtd2FyZSBpbWFnZXMgZm9yDQo+ID4gQVNUMTA2MC1iYXNlZCBwbGF0
Zm9ybXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3Bl
ZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGh3L2FybS9hc3BlZWRfYXN0MTB4MF9ldmIuYyB8
IDIzICsrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMjMgaW5z
ZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2FybS9hc3BlZWRfYXN0MTB4MF9l
dmIuYyBiL2h3L2FybS9hc3BlZWRfYXN0MTB4MF9ldmIuYw0KPiA+IGluZGV4IDdhZjJhNzc4NjUu
LmEwMTM4NWI1NDMgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL2FzcGVlZF9hc3QxMHgwX2V2Yi5j
DQo+ID4gKysrIGIvaHcvYXJtL2FzcGVlZF9hc3QxMHgwX2V2Yi5jDQo+ID4gQEAgLTk2LDEyICs5
NiwzNSBAQCBzdGF0aWMgdm9pZA0KPiBhc3BlZWRfbWluaWJtY19tYWNoaW5lX2FzdDEwMzBfZXZi
X2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKm9jLA0KPiA+ICAgICAgIGFzcGVlZF9tYWNoaW5lX2Ns
YXNzX2luaXRfY3B1c19kZWZhdWx0cyhtYyk7DQo+ID4gICB9DQo+ID4NCj4gPiArc3RhdGljIHZv
aWQgYXNwZWVkX21pbmlibWNfbWFjaGluZV9hc3QxMDYwX2V2Yl9jbGFzc19pbml0KE9iamVjdENs
YXNzDQo+ICpvYywNCj4gPiArDQo+IGNvbnN0IHZvaWQNCj4gPiArKmRhdGEpIHsNCj4gPiArICAg
IE1hY2hpbmVDbGFzcyAqbWMgPSBNQUNISU5FX0NMQVNTKG9jKTsNCj4gPiArICAgIEFzcGVlZE1h
Y2hpbmVDbGFzcyAqYW1jID0gQVNQRUVEX01BQ0hJTkVfQ0xBU1Mob2MpOw0KPiA+ICsNCj4gPiAr
ICAgIG1jLT5kZXNjID0gIkFzcGVlZCBBU1QxMDYwIFBGUiAoQ29ydGV4LU00KSI7DQo+IA0KPiBX
aGF0IGRvZXMgIlBGUiIgbWVhbiA/DQo+IA0KVGhhbmtzIGZvciB5b3VyIHJldmlldyBhbmQgc3Vn
Z2VzdGlvbi4NCg0KSSB3aWxsIHVwZGF0ZSBpdCB0byAiIFBsYXRmb3JtIFJvb3Qgb2YgVHJ1c3Qi
DQpUaGFua3MtSmFtaW4NCg0KPiA+ICsgICAgYW1jLT5zb2NfbmFtZSA9ICJhc3QxMDYwLWEyIjsN
Cj4gPiArICAgIGFtYy0+aHdfc3RyYXAxID0gMDsNCj4gPiArICAgIGFtYy0+aHdfc3RyYXAyID0g
MDsNCj4gPiArICAgIG1jLT5pbml0ID0gYXNwZWVkX21pbmlibWNfbWFjaGluZV9pbml0Ow0KPiA+
ICsgICAgYW1jLT5mbWNfbW9kZWwgPSAidzI1cTgwYmwiOw0KPiA+ICsgICAgYW1jLT5zcGlfbW9k
ZWwgPSAidzI1cTAyanZtIjsNCj4gPiArICAgIGFtYy0+bnVtX2NzID0gMjsNCj4gPiArICAgIGFt
Yy0+bWFjc19tYXNrID0gMDsNCj4gPiArICAgIGFzcGVlZF9tYWNoaW5lX2NsYXNzX2luaXRfY3B1
c19kZWZhdWx0cyhtYyk7DQo+ID4gK30NCj4gPiArDQo+ID4gICBzdGF0aWMgY29uc3QgVHlwZUlu
Zm8gYXNwZWVkX2FzdDEweDBfZXZiX3R5cGVzW10gPSB7DQo+ID4gICAgICAgew0KPiA+ICAgICAg
ICAgICAubmFtZSAgICAgICAgICAgPSBNQUNISU5FX1RZUEVfTkFNRSgiYXN0MTAzMC1ldmIiKSwN
Cj4gPiAgICAgICAgICAgLnBhcmVudCAgICAgICAgID0gVFlQRV9BU1BFRURfTUFDSElORSwNCj4g
PiAgICAgICAgICAgLmNsYXNzX2luaXQgICAgID0NCj4gYXNwZWVkX21pbmlibWNfbWFjaGluZV9h
c3QxMDMwX2V2Yl9jbGFzc19pbml0LA0KPiA+ICAgICAgICAgICAuaW50ZXJmYWNlcyAgICAgPSBh
cm1fbWFjaGluZV9pbnRlcmZhY2VzLA0KPiA+ICsgICAgfSwgew0KPiA+ICsgICAgICAgIC5uYW1l
ICAgICAgICAgICA9IE1BQ0hJTkVfVFlQRV9OQU1FKCJhc3QxMDYwLWV2YiIpLA0KPiA+ICsgICAg
ICAgIC5wYXJlbnQgICAgICAgICA9IFRZUEVfQVNQRUVEX01BQ0hJTkUsDQo+ID4gKyAgICAgICAg
LmNsYXNzX2luaXQgICAgID0NCj4gYXNwZWVkX21pbmlibWNfbWFjaGluZV9hc3QxMDYwX2V2Yl9j
bGFzc19pbml0LA0KPiA+ICsgICAgICAgIC5pbnRlcmZhY2VzICAgICA9IGFybV9tYWNoaW5lX2lu
dGVyZmFjZXMsDQo+ID4gICAgICAgfQ0KPiA+ICAgfTsNCj4gPg0KPiANCj4gUmV2aWV3ZWQtYnk6
IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4gDQo+IFRoYW5rcywNCj4gDQo+
IEMuDQo+IA0KDQo=

