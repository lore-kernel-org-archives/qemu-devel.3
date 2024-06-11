Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C59C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 06:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGv3K-0004a3-S5; Tue, 11 Jun 2024 02:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.yuan@jaguarmicro.com>)
 id 1sGv3E-0004Xi-OH; Tue, 11 Jun 2024 02:32:13 -0400
Received: from mail-psaapc01on20702.outbound.protection.outlook.com
 ([2a01:111:f400:feae::702]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.yuan@jaguarmicro.com>)
 id 1sGv3C-0006Ng-Vl; Tue, 11 Jun 2024 02:32:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQZQZN6+UjWsyUIpC7wZjuh5XuXVH3lnt5TkmqUXTy/yd9sUR0lmmfx/7lx+oJrjTVFT3FnC/UmymEhr841swVjJ8GLJBWICGEUPbn9/p9Kd0MPyIDkbbv+lbjXa5ZNlWYBoc1BEcPAT0xKlev9mfFSuGJYAaOWLSFWgno0E12zkGJUEW/mJWBOy9UhFMLV4KA5k9xUe+3iR/rz8ijWfKfaMEkesDTgXUu2GEz+WoTOUjuEEL8+mjh6TZsiTCG11LP2Ug3//y4FOOXvwkdxngIe2J22j8LmlejxeFkprawqCFphSjoxCZnhb2+OncNwO6kHwWAlNMDHvuiZr7MFUHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v60ord8rOaf0hP8lnpo9a09/AzLmPHSDzc6wuqHzrYU=;
 b=jg+R96Ib1GWic8xe0LBYaL6ZSkHktq86yllay+mn4gBaz95BoSyiLVipGiBPPkJB6gjkJLeSoTAniIlUGNg1cgRP1hgeLISDtXWhL5CsFOyr2uE/qe41ZkIepuD+/+LCvFb9B8Cn1ep1YyMX0gfZpDJZ8VZ5S53tsZGFOsdaZqCZtEXiDteeq5XeYOcASxzmWJSaODc/w4bMxGmf1hG3qkEqeTzwHW3hWUdjRdDcj9G7S/2CaExFnRLK0LsgPd2seRDZsf3IQBC1ObL2x80JQpM/amV0c3KMg4JXQ9Fw11WVOAWSNT4eku7KhN3Ovz0f1aM9MoKlj/yX7ES3lHUSGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v60ord8rOaf0hP8lnpo9a09/AzLmPHSDzc6wuqHzrYU=;
 b=jwesBvW+CMXBHL0SZ2avGkIX4EQ2FngWdo3UCL0B7oq560E/Jxhm0ZqY4H6DRqrcmFxALsV/57PKMOlzHrIaXbBK+13FP98xsGZjk9ycCd3LZDIo1Vn+xEyYW51L+ORUu9Ovew2HTlrxM9YDRfeupw/2kg7r+apRdbb7swkbZ79G3rj5/3R+nEZ4SQw+WW5xzGhVDWz67rqKoUU7Q9XCxj5eJUS0+wSG0v/R1eeqBTQdDFaKMvPQ352aEwhz4Ek1eK9CqiFXDWhNcXY+YkjtCwA9aG4BSIpzLnUFeiZCCC5puhxw4K8dbR5DclqxuRarp3DvuhWSmodWcmqhYNU6vw==
Received: from KL1PR0601MB4891.apcprd06.prod.outlook.com (2603:1096:820:ae::7)
 by TYZPR06MB5051.apcprd06.prod.outlook.com (2603:1096:400:1c8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 06:32:00 +0000
Received: from KL1PR0601MB4891.apcprd06.prod.outlook.com
 ([fe80::8950:42de:2354:91b2]) by KL1PR0601MB4891.apcprd06.prod.outlook.com
 ([fe80::8950:42de:2354:91b2%7]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 06:32:00 +0000
From: andrew Yuan <andrew.yuan@jaguarmicro.com>
To: Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>
CC: "luc.michel@amd.com" <luc.michel@amd.com>, "alistair@alistair23.me"
 <alistair@alistair23.me>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGh3L25ldDogY2FkZW5jZV9nZW06IGZpeDogdHlw?=
 =?utf-8?B?ZTJfY29tcGFyZV94X3dvcmRfMCBlcnJvcg==?=
Thread-Topic: [PATCH] hw/net: cadence_gem: fix: type2_compare_x_word_0 error
Thread-Index: AQHauAFEOQ7GdOLLmEKNogHiM0xNN7G6o72AgAd8lwA=
Date: Tue, 11 Jun 2024 06:32:00 +0000
Message-ID: <KL1PR0601MB48912BAF85B1431ABDF3EA05E3C72@KL1PR0601MB4891.apcprd06.prod.outlook.com>
References: <20240606095952.2133-1-andrew.yuan@jaguarmicro.com>
 <CAJy5ezqq51bJG4O9HA-Pv4sw9rYqGdFW-EezCRPfDbTx=9SwyQ@mail.gmail.com>
 <CAFEAcA8fSS-qt6KmN_06uEMXddjbqjATh-FkUJVSrPuiu50+PQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8fSS-qt6KmN_06uEMXddjbqjATh-FkUJVSrPuiu50+PQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4891:EE_|TYZPR06MB5051:EE_
x-ms-office365-filtering-correlation-id: fc923efe-9188-4409-cf23-08dc89e0334a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?YWNMS2JvTERkOWJReU1nNk1LUjZjenRqRHFvbW9maFVkdC8yaXdoaU9EVCtl?=
 =?utf-8?B?dXd0aEJaNkYzbisyTEpUYWJ2Q3l5UVlCTmcrenB2Zkc0L1U0SHJaNmpycGRw?=
 =?utf-8?B?RDlQdTJvZnZmUGl6Y3FzUDhCOUZtWVkzeWpHcHJ0R0pXSE1HYTNDdlhQV29M?=
 =?utf-8?B?SUxIUjZyaG1aNjkzanlpUC96Q0g1ZUFyYzVvd1YxdlliT201VnpJdnpNQURq?=
 =?utf-8?B?OTZPVWtWN2szUVNSZ3A5dVAzNlFEK2YxeUVSNHJId2Q3bDl5SkVZRkErMFRB?=
 =?utf-8?B?Q0hSUGE4cEIxZ2ZqOXRQM3F6S0N1ZVhjVEpCNzQ4U2NHYllHc1pmeUZWUjRT?=
 =?utf-8?B?K1g0WFNaWlFqQ2R3WlZOV3M1cHlybWt3SVBxSlZ4YURVQVBHNVV0a1c3UW1X?=
 =?utf-8?B?TlBUNlB1bjYrSVNOZHdQWnpuSTFianBWeVg1ekNXT0xzM2RJV3c1QnR5NEM0?=
 =?utf-8?B?cDQ1NGQ1LytBM3pWNisrWWNMTlR4V1hlQXZ4TDN2Z3VhaXp1WTVGUEQzMTg1?=
 =?utf-8?B?YjQ3TFZrbFd1bU5LWjdnTUNEMXNRK1dKRkpaMFVhaWg3dDV4dkdJT3pPMjBl?=
 =?utf-8?B?L0dpYVBVV1FEbW1NSU1PZVM1MU9mamtEUEJ4d3R4L0d6bWpubDdEM0RZQTho?=
 =?utf-8?B?SFYxN1l6NVgwdDhQelF5VU5qbklUaWIyYmZBeUhZMzRVY3pETWhMOVRDNlZy?=
 =?utf-8?B?MFRSb3VyUmZrYkQ4TVloWENPM0JlelVlcUY5RFI0d2lWZTU2N1hmQ05CNndl?=
 =?utf-8?B?NU95TnFLaVRRY0hjM0pIRFU0QzRYTERIYVhlWjdHeFBid1VuckRWdXFYU29x?=
 =?utf-8?B?b0JJTTNGeEpWV1k4MTBkR0M3aGgrVkVtejh5c1hGTXZMRUNESk04alZFUGc4?=
 =?utf-8?B?cDg4TGU5QTlwbU5ZZkxPK2V2QkR0aSs3UTYrNnVsSXhKN0R1b29OcTJTc0Fl?=
 =?utf-8?B?QnhqOEdIbnJKTFZwSTIybXI3eHV2Wk9FTXhDOWVDZzZ5bU1aQ04rOGdjTThH?=
 =?utf-8?B?NUduaEcrcnpPQWVtWVMyZ3crN2hPR1FnWEIrT3FKZDdpSE9ORXVvTndrZ2Jj?=
 =?utf-8?B?Q1F0R2liSjZHSkllY3J2OXl0Q3hNNzhyOHJVL0hPL2MxME1iblptTjdkeE81?=
 =?utf-8?B?NUZwVHl1dGxrSVhPOGtnSnFXT3FGbUlWWjY5R0hRYlArTStzYWR1d2dSZ3ha?=
 =?utf-8?B?dk1YQzVjN2J2S1NSWHFXRXRFWTJWcWsySDF0TTd1RWNjNzJlSWJNQ2QveHUv?=
 =?utf-8?B?TyswR2lFNit0VXBqaTc1V0dHUmh2Z1VUTGFyNkVzZnhrZ2hWNm5vbEFMQVV0?=
 =?utf-8?B?Zk84Z1ZwQVN5TktILy90dmNBbTgxcnorc0FLU1d4eHI1STJIWjhvd3VzOW5W?=
 =?utf-8?B?eHQzWkNDNkVZOHhMUk1vNG16Q21GV3gyYUVuM0lkWDZCWFlzd3p5UzNoSmNh?=
 =?utf-8?B?bXVuM0FRbGd0bTB2eVJFU1ZaWlhISkNwLzFOMmNubXExOURxeVVHaElZNWhh?=
 =?utf-8?B?NFh3V3k0T1g0MnhmZytRTCtyR3l3d0hvV3k4NnlORWZ3VGU1Ni90N1I0WUtH?=
 =?utf-8?B?WWF0anNSOUx0cVlmSzRUM0llQUxxU1JQQnRyN2h4NzI2OHBIc3NJTFVOSkxj?=
 =?utf-8?B?eEhDeld6Y0FyT2NXSnkwVU1PV3B5VVJlTGlUbm9zQzdYZ2VlNmVNVWRWOS9B?=
 =?utf-8?B?ZzhZRk5pMU82VkFoZjFmR0ZadFlBZG9lbDI1blREdTJxVHJGYkVwSGVBclZo?=
 =?utf-8?B?KzNOWm5mMHg0ZXQ2YkRiK1M5dDF4eWxTa2ZGVUVuOWpxSEttZHNURktpa3RB?=
 =?utf-8?Q?I3ZKHZb5OgCsUQElPVlU+csZPTsJx785sbzYQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB4891.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L016aG1Ba0tCdlA4YjJhZjBNQ1BwcE5RaWhzQVAxaDBYTDBuU1F3UEg1L20y?=
 =?utf-8?B?UWl6eGxtOVRLV2daa1VIckdKcDdISnNpOTQyYnNwblEydXMwdmlvemtRSXlo?=
 =?utf-8?B?UXkrZ003SlZTWnBJRTZ1bUNFRjZXNitzUTZNMENLcGpVRVRxeHVwUEdQcVhl?=
 =?utf-8?B?b3R0ZXBSQ3A2TW9rTXJoZzZTdjZIdDFEVDNja3g1ZDBodm1GTnRSb1F0bUNP?=
 =?utf-8?B?eHg3NkpHQ1RrYjI0TzdOT2dackk2MTdjcWtubXZES1JaTk1zMFNpQWZGMTFh?=
 =?utf-8?B?WDdUQ0trOHJoRHF5M0d6OEplK2RPU0xCTHBtUkR5d1BLVFlEckp1cStHTnFs?=
 =?utf-8?B?WGxtWEtkT1BxMktEZnU1UE1xM3FiZ29KR2xpTFUwRjBicnQ2ajg5aHFsakdG?=
 =?utf-8?B?ZnRJa0J2T3hjbDJZanB6Y2wzSmNmZDJ2dWpJVXVxTzJPOWlWV3RZNE1SbHpG?=
 =?utf-8?B?a2Zwd0czUVFaS1BTN254bERLbWtTM3JaS1BWZGtyYUpRU1hQY2FZNHg2SGF2?=
 =?utf-8?B?aDFEZTFzZFBMU3NOQXVGK1hZWjl3WDRncFZSMnd3eDRZMkhWcnpZNVU3VzJj?=
 =?utf-8?B?ajNmTnNwNXJlNkE0TGZTbnRidTIybDBYZFlSczBia0p2bDUrUTZNQVpTcmxa?=
 =?utf-8?B?SGdXa1d5NkNQenl0bVQ5MVRFUjRQVnZpK29qb2g1cjdITHFpWmFwRXNSUDNy?=
 =?utf-8?B?U2Q4TStyK3Zac01VMEFkUXMrYlVCaSszTzVES2I2T2QvWUxMR25Cdm5raG9N?=
 =?utf-8?B?NU5RWXYxMnQ4WDU1N2doZW9PV1dudkhLRDFYemlXd1YyYzhJUnc1MEtvaTM1?=
 =?utf-8?B?TFdsNGljUlFCMkN6bkgxYit6czl5RjdVZ2Z6ZEJzS0FBUXlyTFpQOVhZOXMy?=
 =?utf-8?B?TWVmeHoxT0VPbm1MYysvSE56UERVTmNPTmM1b3VxMkY3R1M0LzBqV2N1MWdT?=
 =?utf-8?B?b3ROcEpxRFNVaGY2c2xpMXpPMWd4QzY5d3NjWFJuNHBwbTF6eTNLRUY2UStR?=
 =?utf-8?B?cVlvSEc5dGFQSFk0NGF6b1h0NlpzdUJubnlCcUtYaHZ6bm0wNFByVmtuNGN6?=
 =?utf-8?B?THJRZGZHUEV2TXk3Wms3QmpaVjQ1NEZPQ0x5VzhSQU9EdlJsM0hGMlJxWHI5?=
 =?utf-8?B?dDhYQmgrejYyUDU5WCs2RmJBUjVvY3RWbTErQUtNN1lndGptdVdpZ2FaZHdF?=
 =?utf-8?B?RlgwcEMyVWlhNTQxMXgreWtrYmxDOGloa1JGMjZub2dyNUhlN09ndzVSTDg1?=
 =?utf-8?B?NkJ4b1c5WitSWHJLYXdxbkt5bXlUeEx1VmxBRWRCa0w4MjFFU2lmU013NFBG?=
 =?utf-8?B?bWlkMnd2U01XRkdsUytYSG12cWlSanQ4MVVIZmw2WVlTSENmSkJ6ZjJKUFF0?=
 =?utf-8?B?RkxuUmRFQ1pjUkhyY0x3T04wU1pqQVI4dlhYOWdkTmJyWGZvQUVzeTJCN0V0?=
 =?utf-8?B?OFQyeHZsaDZPWFZGY0hIT2hQT3B4UWFsY2xNdis4Y3d3d0xzVmpjY1p2VHpX?=
 =?utf-8?B?NlM2QUFqdWU2Q21TMU5sd3d2UFNubmlQc2VHeXdQeGU1MHE0UDNTb2MrUk1Y?=
 =?utf-8?B?ZXdoQkZWMDRkN05PcmI3dE5LTXN3RE1hRU55ZXc4amxyMVBBY085TlJzcG9h?=
 =?utf-8?B?VXArQjVYSHVTRVNvL0k3MVpWN1NMSmR4T1gvMGxieW9jUFM4QlBOb05zM0Rj?=
 =?utf-8?B?bm4vMEcxdVVnSFNXRENLN3lkT0kzc1NvRWRRVmtjckdvVXY5bzlBSWNUaGRo?=
 =?utf-8?B?b1NmeS9pQU9WQk9abVdoc2Z2SENOdUVKaWZ4MDM3QVprcElJLzJ6ZnIvaWRZ?=
 =?utf-8?B?WU1nWVlraTYzYWpPSU5weFB6UnRzZ1ZtTC9HYXUwMllvMXliOVoxQ2ladk1R?=
 =?utf-8?B?R1c2RndKWkJ5TzE5cmxKNWdPaU5iYzNkaHNKdUdzeDVxMUlhWmpGdFR4bzND?=
 =?utf-8?B?OWRCcFV4M2dDQlZESVg5cUhBK1ZlM0ZPK1JSczI2S0FTQ2FHTjBoR3ZON2F4?=
 =?utf-8?B?VEJiMy9GSFFvTnRtOFA0cWZvMzJaSWprTmtGSjNjTjVBY0hVaHVJMnd2NkpE?=
 =?utf-8?B?bnZBWWFoc1VOS2djNCs5SVBnMHJyVzRXZEVjcXJEZzArY3NFTmtGRnFONzgx?=
 =?utf-8?Q?w6oqKCwWmwS8V9xNhGyIBjfSf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4891.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc923efe-9188-4409-cf23-08dc89e0334a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 06:32:00.5488 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zL+t0gTpclnO17u8jcOqZefgU4CVrDmpIu+WTC/MzvE7G3PVidFmS2iksJBurHE2J2xcmW9lk8skDgP1tA/wEDJMw2/MmVR09zuEVXwWfYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5051
Received-SPF: pass client-ip=2a01:111:f400:feae::702;
 envelope-from=andrew.yuan@jaguarmicro.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

WWVzLCBOZWVkIHRvIGNoZWNrIHdoZXRoZXIgdGhlICJvZmZzZXQiIGV4Y2VlZHMgdGhlICJzaXpl
IiBhcmd1bWVudCBvZiBnZW1fcmVjZWl2ZSgpIGluIGdldF9xdWV1ZV9mcm9tX3NjcmVlbigpIGZ1
bmN0aW9uOw0KDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogUGV0ZXIgTWF5
ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPiANCuWPkemAgeaXtumXtDogMjAyNOW5tDbm
nIg25pelIDIwOjA2DQrmlLbku7bkuro6IEVkZ2FyIEUuIElnbGVzaWFzIDxlZGdhci5pZ2xlc2lh
c0BnbWFpbC5jb20+DQrmioTpgIE6IGFuZHJldyBZdWFuIDxhbmRyZXcueXVhbkBqYWd1YXJtaWNy
by5jb20+OyBsdWMubWljaGVsQGFtZC5jb207IGFsaXN0YWlyQGFsaXN0YWlyMjMubWU7IGphc293
YW5nQHJlZGhhdC5jb207IHFlbXUtYXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9y
Zw0K5Li76aKYOiBSZTogW1BBVENIXSBody9uZXQ6IGNhZGVuY2VfZ2VtOiBmaXg6IHR5cGUyX2Nv
bXBhcmVfeF93b3JkXzAgZXJyb3INCg0KRXh0ZXJuYWwgTWFpbDogVGhpcyBlbWFpbCBvcmlnaW5h
dGVkIGZyb20gT1VUU0lERSBvZiB0aGUgb3JnYW5pemF0aW9uIQ0KRG8gbm90IGNsaWNrIGxpbmtz
LCBvcGVuIGF0dGFjaG1lbnRzIG9yIHByb3ZpZGUgQU5ZIGluZm9ybWF0aW9uIHVubGVzcyB5b3Ug
cmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCg0KDQpP
biBUaHUsIDYgSnVuIDIwMjQgYXQgMTI6MDQsIEVkZ2FyIEUuIElnbGVzaWFzIDxlZGdhci5pZ2xl
c2lhc0BnbWFpbC5jb20+IHdyb3RlOg0KPg0KPiBPbiBUaHUsIEp1biA2LCAyMDI0IGF0IDEyOjAw
4oCvUE0gQW5kcmV3Lll1YW4gPGFuZHJldy55dWFuQGphZ3Vhcm1pY3JvLmNvbT4gd3JvdGU6DQo+
Pg0KPj4gICAgICAgICBJbiB0aGUgQ2FkZW5jZSBJUCBmb3IgR2lnYWJpdCBFdGhlcm5ldCBNQUMg
UGFydCBOdW1iZXI6IElQNzAxNCBJUCBSZXY6IFIxcDEyIC0gRG9jIFJldjogMS4zIFVzZXIgR3Vp
ZGUsIHRoZSBzcGVjaWZpY2F0aW9uIGZvciB0aGUgdHlwZTJfY29tcGFyZV94X3dvcmRfMCByZWdp
c3RlciBpcyBhcyBmb2xsb3dzOg0KPj4gICAgICAgICBUaGUgYnl0ZSBzdG9yZWQgaW4gYml0cyBb
MjM6MTZdIGlzIGNvbXBhcmVkIGFnYWluc3QgdGhlIGJ5dGUgaW4gdGhlIHJlY2VpdmVkIGZyYW1l
IGZyb20gdGhlIHNlbGVjdGVkIG9mZnNldCswLCBhbmQgdGhlIGJ5dGUgc3RvcmVkIGluIGJpdHMg
WzMxOjI0XSBpcyBjb21wYXJlZCBhZ2FpbnN0IHRoZSBieXRlIGluDQo+PiAgICAgICAgIHRoZSBy
ZWNlaXZlZCBmcmFtZSBmcm9tIHRoZSBzZWxlY3RlZCBvZmZzZXQrMS4NCj4+DQo+PiAgICAgICAg
IEhvd2V2ZXIsIHRoZXJlIGlzIGFuIGltcGxlbWVudGF0aW9uIGVycm9yIGluIHRoZSBjYWRlbmNl
X2dlbSBtb2RlbCBpbiBxZW1177yaDQo+PiAgICAgICAgIHRoZSBieXRlIHN0b3JlZCBpbiBiaXRz
IFszMToyNF0gaXMgY29tcGFyZWQgYWdhaW5zdCB0aGUgYnl0ZSANCj4+IGluIHRoZSByZWNlaXZl
ZCBmcmFtZSBmcm9tIHRoZSBzZWxlY3RlZCBvZmZzZXQrMA0KPj4NCj4+ICAgICAgICAgTm93LCB0
aGUgZXJyb3IgY29kZSBpcyBhcyBmb2xsb3dzOg0KPj4gICAgICAgICByeF9jbXAgPSByeGJ1Zl9w
dHJbb2Zmc2V0XSA8PCA4IHwgcnhidWZfcHRyW29mZnNldF07DQo+Pg0KPj4gICAgICAgICBhbmQg
bmVlZHMgdG8gYmUgY29ycmVjdGVkIHRv77yaDQo+PiAgICAgICAgIHJ4X2NtcCA9IHJ4YnVmX3B0
cltvZmZzZXQgKyAxXSA8PCA4IHwgcnhidWZfcHRyW29mZnNldF07DQo+Pg0KPj4gU2lnbmVkLW9m
Zi1ieTogQW5kcmV3Lll1YW4gPGFuZHJldy55dWFuQGphZ3Vhcm1pY3JvLmNvbT4NCj4NCj4NCj4N
Cj4gTEdUTToNCj4gUmV2aWV3ZWQtYnk6IEVkZ2FyIEUuIElnbGVzaWFzIDxlZGdhci5pZ2xlc2lh
c0BhbWQuY29tPg0KPg0KPiBBdCBzb21lIHBvaW50IGl0IHdvdWxkIGJlIG5pY2UgdG8gYWRkIHRo
ZSBtaXNzaW5nIGxvZ2ljIGZvciB0aGUgDQo+IERJU0FCTEVfTUFTSyBiaXQgdGhhdCBleHRlbmRz
IHRoZSBjb21wYXJlIHJhbmdlIGZyb20gMTYgdG8gMzItYml0cy4NCg0KSSBoYWQgYSBsb29rIGF0
IHRoaXMgZGV2aWNlJ3MgY29kZSwgYW5kIEknbSB0cnlpbmcgdG8gZmlndXJlIG91dCBob3cgd2Ug
a25vdyBhdCB0aGlzIHBvaW50IHRoYXQgdGhlcmUgcmVhbGx5IGFyZSB0d28gYnl0ZXMgcG9pbnRl
ZCB0byBieSByeGJ1Zl9wdHIuDQogKiBUaGUgZ2V0X3F1ZXVlX2Zyb21fc2NyZWVuKCkgZnVuY3Rp
b24gdGFrZXMgYSByeGJ1ZnNpemUNCiAgIGFyZ3VtZW50LCBidXQgaXQgbmV2ZXIgdXNlcyBpdC4u
Lg0KICogdGhlIGNhbGxzaXRlIGluIGdlbV9yZWNlaXZlKCkgd2lsbCAoaW4gdGhlICJzdHJpcCBG
Q1MiIGNhc2UpDQogICBwYXNzIGl0cyBidWYgYXJndW1lbnQgYXMgcnhidWZfcHRyLCBidXQgaXQg
d2lsbCB1c2UgYQ0KICAgcnhidWZzaXplIGFyZ3VtZW50IHdoaWNoIGhhcyBiZWVuIHJhaXNlZCB0
byBhdCBsZWFzdA0KICAgR0VNX0RNQUNGR19SQlVGU1pfTVVMLCBldmVuIGlmIHRoZSBpbnB1dCBz
aXplIGFyZ3VtZW50DQogICBpcyBzbWFsbGVyLCBzbyBldmVuIGlmIGdldF9xdWV1ZV9mcm9tX3Nj
cmVlbigpIGhvbm91cmVkDQogICBpdHMgcnhidWZzaXplIGFyZ3VtZW50IGl0IHdvdWxkbid0IGhl
bHANCg0KV291bGQgc29tZWJvZHkgd2hvIHVuZGVyc3RhbmRzIHRoZSBkZXZpY2UgbGlrZSB0byBo
YXZlIGEgbG9vayA/DQoNClRoaXMgaXMgYSBzZXBhcmF0ZSBpc3N1ZSBmcm9tIHRoZSBpbmNvcnJl
Y3QgYXJyYXkgb2Zmc2V0IGFyZ3VtZW50IHRoaXMgcGF0Y2ggZml4ZXMsIHRob3VnaC4NCg0KdGhh
bmtzDQotLSBQTU0NCg==

