Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0791CCFA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 02:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIHHV-0007Ie-3U; Sun, 09 Nov 2025 21:05:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vIHHS-0007Hb-PY; Sun, 09 Nov 2025 21:05:18 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vIHHO-00088I-Dc; Sun, 09 Nov 2025 21:05:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyWUC5omy39vxCZWTGdAcPlG5LpywaR43eWcyN1QhmJQtnAd+4TiKOTsq69nHcez16GB7/+0F+x9EM5VDqy1ev6+DHO+XY0osARrgA+WNBvAKyq3STOOIflpyzrTuvoYNRV2rOthmgFUAieQkvVNwJ+Xept7SjHEClTkYn13Ta05PA2ZQ2z3KH+A8Q1FZ8xGMmK+ryijvo70agvLwESc7x6QzGJYaUh4OOEJoUPfmFbMbQO/Z/PavdNOsM6BQEXQR9C+zEe7GpBKXaZePIq3PLRMCif+2Jxabs/e+lasJHR7QWoy4HUIdwYjqsHfEDUA1cVPpnKSHu7a3HOm9BQdSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MER8BnCceL/AbjUep9etc6820s9eLMQb4I8dQAfB1q0=;
 b=tkMkM292c3kBztqxqDf64G3gcm5pPhmsDnfZcwuIAK+URcUUFt2MnD9awF7XE06lo6su3g+K6ccesATBbMC9UmxV8k1cV/SoMTfH+9bivOgQ9Xub+h1O/7hrNctRrmynwOd1vVmzraqND9DWazbxvTKOSZouijZ1rRL8ANYdZxX5xQxoQXA49NdjKzD5W3MegvM3KAQX99wokS54SoMyJakCPEBGphOOfiEGD7ZX/Q2obSucBc/bIgUKJEY5k+uufJL7Vm91aCrCle5oEM3mbDbVGBh01DnyaK1gdrbL6I43FbAjBspfjRT3NqmGIKv5q6Seh6YVYlkLUyYkAKwMdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MER8BnCceL/AbjUep9etc6820s9eLMQb4I8dQAfB1q0=;
 b=oYEmLX/NZAjbRb/SgKn2txqxLPcbERzRBeNsfQLTUQOjg4Crq2uC0OpcobDuGPgUpChPWyoni9KLUAFJEBpbbuptgeRjLZS5E5mDYPI+2ZOKrjDf/UdWTeJiq9GwTrw9oQA0qVDe0NklxsXhvQ9w/7439XS+VzxUL/btVgLIhqQShCZQZ1SxnPWaJN1HAg0Owi6IwIN6HnqRa+VA3TnO3S5GOkoiZpYm1ha6P6manoVKfL42r1lDhMe63taSgIUjzsTJsm9P9shqSsmETX6msZ5iQsaGwhvBG8SaBRbRcha1H/iuXAk13eZmXIXyIbCmN/nWQ5wVMSDuC3QXw16hVg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB6405.apcprd06.prod.outlook.com (2603:1096:101:130::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Mon, 10 Nov
 2025 02:05:01 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5%3]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 02:05:01 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: RE: [PATCH v1 01/12] hw/arm/aspeed: Fix missing SPI IRQ connection
 causing DMA interrupt failure
Thread-Topic: [PATCH v1 01/12] hw/arm/aspeed: Fix missing SPI IRQ connection
 causing DMA interrupt failure
Thread-Index: AQHcTvpFVs+AvAAOZkiSFPtxBQrrhbTm2nuAgARTl5A=
Date: Mon, 10 Nov 2025 02:05:00 +0000
Message-ID: <TYPPR06MB82068E2A0D28AC49FEBEB479FCCEA@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20251106084925.1253704-1-jamin_lin@aspeedtech.com>
 <20251106084925.1253704-2-jamin_lin@aspeedtech.com>
 <f8a8d21a-00bb-48b1-984d-ef7e4aa393f2@kaod.org>
In-Reply-To: <f8a8d21a-00bb-48b1-984d-ef7e4aa393f2@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB6405:EE_
x-ms-office365-filtering-correlation-id: 83a77c91-f6ea-4077-0208-08de1ffd8e6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|921020|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?M2RJblZrSWYzR25BY0ZtdlNhSVhNd2xRY3hQaUpIVVZ5T2tGSTJQRTNsU0w3?=
 =?utf-8?B?L1VzVGUvUWtiZjNNcmhVQWJvbDdzdWhpQjlkL3ljQTZpd2JVbVdFVW56dFh2?=
 =?utf-8?B?RFU3TGhHekJPRHdXNkp4cHZsWk9LNmhhdGpaRnAwc2E3d0p3RHI4NFRJM2VS?=
 =?utf-8?B?RGZTNmVrR0hQa0lTUXZsaXZyUzlZVkN2eVZLTGdGOG5ZY1p0M2R1MENZTkg0?=
 =?utf-8?B?NHk3OHpuaXZnczZEc2VScFdjdlViRUozTW04TXFqM3VTaGZJQlhUL05LVWdm?=
 =?utf-8?B?RDNQOVoyb2o5QzhPWGR4ck5KZFU4VGNRcUlyeVZEL3BOazlqVUVMdjNCZDhs?=
 =?utf-8?B?dFhLTWZUU3hTbkZ6VVFzYU96STRmd3hKQkd4Z2d6K3JvcGtMNEpIMEdnSzIr?=
 =?utf-8?B?RUFxZ1JzdHdVY1l4cHlFUlZLTVdkWXNLNlFCRDFYWVk3SXdPL2pib1FTMXNu?=
 =?utf-8?B?YmdqWDdMcTYwODJWSzRtTFltQUl1K0ZJekxmZHZhYzg2NU5ERjVPR0pPM0NO?=
 =?utf-8?B?dVNkdHQzcHJrTzZLRWlpaDZ3V2FMU3NMQ0FxSnlkcEU3ODM5eG5HOGxWNG1Z?=
 =?utf-8?B?bWx2d2dENzJ5S1d6TGVnMFFPa3p4OVMzZ25ZT0YwUlFWeXZOWEJxY0dZWWVp?=
 =?utf-8?B?SzVXVEErUWk1WTFVeVY4WHJ6bkl4aEhDVU5YbFZZRmdLRFUrcXhhVHQxUWN6?=
 =?utf-8?B?ZWRyVkttckladlJJemN5amhXTWhxVG1pNHhmN3lFdVRhR3pPR3dlRzB3Wld4?=
 =?utf-8?B?a1B3ajBmOGVYRVZpd1lPRUlTemI0MG5zUUVIRkpSSnZxU0lJa2FuV0VOajQv?=
 =?utf-8?B?QU1BcHpIOXN3a3FXT1pHOGdQUjZKQVM0eGhIZ1MwVk5VTlJlSWY0ZjVUdCt0?=
 =?utf-8?B?eUxZdHZORS85NC9BOHFxMkorM2hHdCtqL3lhS3llQ2s5d1ZzV2J5TXFWbUxS?=
 =?utf-8?B?TTFsT2padVJtMzhhWHZlK1dhSUI2Q1gvOWgxWjBWMVhEcDhnMWN3bU5KaVlB?=
 =?utf-8?B?QVdXR3p3aEc2ZnVIQlAyOXplNGd6SzB0NHpIY1J2UnAwK3NRSVNWdDR4QXBK?=
 =?utf-8?B?OE5RRDBuQnBGcVppMVdUbFZ6Y3JoTEUwSWZHcmZJcFRZamRkd3BZbjFnYXRy?=
 =?utf-8?B?aE9yWi94MXk4MFlLWnRmbW1ZMWRnWXRIY3Q1Z0k3NHViUlJsWjRRZzdkYVlm?=
 =?utf-8?B?WkVDNTU4VlZ0UFdleTIwRjZmcFJxNFFSeEx2eWZZSG9sZW1FY3F4UlJXMWdw?=
 =?utf-8?B?ZFNzcTBEL040SUhFVFRMRkQ2ZlI3SDVpcXpKN3ZuMXdtakduUkhqWG9kR2ZM?=
 =?utf-8?B?V3dYZFh5V1paZFUvckFBUXJJYlhDeC9BOHczKzZJR0ErZk1OSlN5bi9FZGRK?=
 =?utf-8?B?TGR5Y3Iya2cyN2hhN0pxVjdHMEVIbFJ2SVVyUUxFSE5NWXJNaXZTR0ovMzE2?=
 =?utf-8?B?WWpQQWZOeVd6anU5cEMyeUYxM3dJbGZlVzdUaWMrdy9yR1dERkE0NXJzZkFI?=
 =?utf-8?B?RlFaZGtBVnZhYWdhTDBuQzdxSUFlTkNjZ0NJUEFJamFGNzQyWVIvSUNicWVY?=
 =?utf-8?B?T3d1bnJub2U2bDRNQXg4ZjIxNjhyOGQybE5SNGhTUEUzM1BZQVEvYkpNalFP?=
 =?utf-8?B?Y2FoUjlWeDllczBKWnZYbTVuWHhrQUpIQ1huM2RQaFc1K3N1RzdBS3ZPb3o2?=
 =?utf-8?B?dVhIWFlmTFBCNFNCYlljQkIyMU52ZG9DWm1KRkNUMGl4c3lsRGRNcVRWcWhu?=
 =?utf-8?B?U1NDblpYVjcyWG9Eb3QyeVlxOVM3bUpJUzZxQnBYL2MxM2tJSmx1Ym9hYlNk?=
 =?utf-8?B?ME1tVENFL0ZUS1hWS05ET0pFYU1hMEN4SDhqNFlwWVhSc09PSjFjYWZiOHV5?=
 =?utf-8?B?UEpnR2hEaDY0NTIvTXd2SGFmZ2dtcE5DWEoxWUVNSUJrYU05OVNvREN6T0Jm?=
 =?utf-8?B?ZHRlaUc1U0NObjBvRXdYdVZqeE02Q1U4WlJuU0h4OTRnd3NJcG8zQnZwRGJI?=
 =?utf-8?B?VDFEaytCK3BmTkt1MXpYTjZneEFSM0JQaW44RitiUXl3VUVqOEkzRm5qcFdj?=
 =?utf-8?B?VW4vVlFEZ3FDUDRDa2Y3OG5XVHVtcWJ3L20xdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3dONDAvUnVOUnVOSWR1RTNRSmVyc1FEa010bCtsZ1FGS0dJNHJRQTFUNzIw?=
 =?utf-8?B?ZHN3K3pnWTNkRWdVZXNtNElaQWNpN1lSM3pMck5wWEl1cWtVWmRzNWt1ODEr?=
 =?utf-8?B?bkZXUjJoakdvU21Yd1FKaHc5UDlJUkRRRVh2YjV5enBLOGJab2pTYnN1OHNO?=
 =?utf-8?B?OHJsQlpocXJYMWlkY082UlBld2puby9zZmFNOVRWYnM0WDJrN1RXQ1VjZzcx?=
 =?utf-8?B?Z0ZLMGRKSDdDbDdRbmJ5OUF4TEFYcG5GTkFQQkNEQ3VxWHpKTUtIaEp1UjVL?=
 =?utf-8?B?RktaT0U2c3V5MVZZRkV5SWlqMDZpVlpEZFVxUFNsaFZMNnE1TnVjTzYyclRP?=
 =?utf-8?B?cVBnSjBjTm9CT1R3VGlMek9pQ00vS3A5ZG1MRWdaNkFWbTdLUWxyaEdiWmxS?=
 =?utf-8?B?a1g4Y0JWVjhmRUF5ZEsvTW5CamZpQWRmUW50c1JuVkhLNTV4Y09JL3Z2N2VT?=
 =?utf-8?B?RXk4ckFZbmh5WTJjZm9RQkFuaEVZSXo4THozRGdrZEFIazZ5QVpWOUxFVCtX?=
 =?utf-8?B?MHg4dnU2bzNza3IrQ1kvZXlpQVk4cGl0blk5WFlDVXM2ejNGWjNUZ2VvU1pW?=
 =?utf-8?B?WUxzQWRHdTFnSEl6dkJhaExJd1JjZ1FlT1NpRTQvdVViOWpOcnpRR3psbHl1?=
 =?utf-8?B?NmwxN0J2R2xkcE5MeFh1ZWc1M0FLeFZYZkxPc05HTlVmeGdZek0zVFMvK2tH?=
 =?utf-8?B?TEF3WFZlb3Y5ZlJ0MHptS3drZFFqaFZEd1pHQk1rUngxWHZnN2IzR2JMcGRs?=
 =?utf-8?B?YkthNjB1SXpVM2tuVzhtNFNjdGJydXBDQXp6bGl2Ky9zT3BpZjAzc01TMUEv?=
 =?utf-8?B?Tmtlbi90TlIyZWRYZXYyS3BwSWtBMytYSFJPeDVjS1ZPR3ZQeDU3emFpamh0?=
 =?utf-8?B?RSt5WW9MSzZQbDNXK2tyQUpEVm9JMmE4dXN2cUFaSVJnamxTVHdWTWg2dXFH?=
 =?utf-8?B?cHliMWxlZzJNcGlJQVhwd0pzU3EzQTg1YmQvMlFuY1cwY0lSYTFqWW9jKzZ2?=
 =?utf-8?B?NG53VFlWQWRZblFydmFzYXdIQVNQUnIvYWJYMlJGOXd2WVY5VWNLQWJ2QTFX?=
 =?utf-8?B?NFNpRmo1djB3QWlVUDNUY3Zta1hTSEFlMms3QTFMc2J2cDNSY2huNzkrcGRh?=
 =?utf-8?B?M1NJQ2ZBam02d2J2TU50bFBNOEFHSkgvQkkrQVB1RXlucXBKVDlJQmhBVjBW?=
 =?utf-8?B?S1ZZdEdMcGdqdWFWR2pTRzV2S3VUY0hHdFFDdnNVWjlhTHV4UEJHNEhrcXQ1?=
 =?utf-8?B?YWcreG16NWM5RzNCeFBjR3A0Z3hRVWNLOUo5aFltNW8yczF3azFCZjV2dWMx?=
 =?utf-8?B?NWZLT2J2VlJCaDhYRXB5bWxXU2dOSmNQSmhuTnQwemU4VDNhYnI4eTlyWWJ0?=
 =?utf-8?B?UHppdm90SWNMekRFR3A1Umh2ajdRY21sTTNQS3lyUDdUbG14Rm4xUTMzMDhZ?=
 =?utf-8?B?VVYybkJJYy9JNkZTTktlM0hrTFo5TUtsdWxKZHdla2F2QzlrUjlDUVdsZ3lX?=
 =?utf-8?B?bU16blRmcGJvdlpldTBLak1hNmxGeW83NHhOL3d0S21KV3d5ZThRWm83eTlq?=
 =?utf-8?B?YnplbXQvSDY0bWZnNytVMWRrRVg3WFErdnp6ejZxTmtMZ0tZcUpteDNDNlpS?=
 =?utf-8?B?bDllNzArSDVQcmtQVFFLeUJjSFFuQ1YraHRpK3kwMnBlRGJrbURlbXk3elpQ?=
 =?utf-8?B?L2RNTjJlZHJNcVB4NXJXSHZCZlVRbmhZcmM5ejBCMDExQzl5eEZDV0tKcjBB?=
 =?utf-8?B?VXZDdkNOYTgyWHpoU051NjZSNlJHQVlxbEg3YmlQRHcwSEpLUHZ5T2tJL0w3?=
 =?utf-8?B?eVVsaThFemJEWjlUZEhsMFB3RlFnaDRZdHBYMGxwcklscEJqaGZUaEVEKysy?=
 =?utf-8?B?bkxlMUJ1TlNTNDFXQk15KzN1eGIra0dMVi9sYWFrT2NYa2E5VXRTZ1pMWEk5?=
 =?utf-8?B?ZXhVeHdWLytyT2Q2RUk1blQ4aWpESmg2U3QxZHRtb1dLUEJ5eTMyVWsyL252?=
 =?utf-8?B?RDBqYi8xcmM3SlpiZVlFMTVSSW9iWVZIVWI4TUxNdnlPbGxxeTg0U3NFeXJz?=
 =?utf-8?B?K2wvRFFnbks0Z3l0SVovclVKVlRSbVd3dkIwWlRuSUhzamFLTjFYWUsxUUdO?=
 =?utf-8?Q?3mj9viVBwU9x6BQGq4vSdTemj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a77c91-f6ea-4077-0208-08de1ffd8e6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 02:05:00.9085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HsVlgfjej88maLi0uuVqpUHZK6avQ3sLDTcvsG6LBOrKvNG+QUUfXg2GaaRklCEv3C66pJ7IkfxTlWk5Kfxggn0Vei8GXE/5htQLRUWmP6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6405
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

SGkgQ8OpZHJpYywNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDAxLzEyXSBody9hcm0vYXNw
ZWVkOiBGaXggbWlzc2luZyBTUEkgSVJRIGNvbm5lY3Rpb24NCj4gY2F1c2luZyBETUEgaW50ZXJy
dXB0IGZhaWx1cmUNCj4gDQo+IEhlbGxvIEphbWluLA0KPiANCj4gT24gMTEvNi8yNSAwOTo0OSwg
SmFtaW4gTGluIHdyb3RlOg0KPiA+IEl0IGRpZCBub3QgY29ubmVjdCBTUEkgSVJRIHRvIHRoZSBJ
bnRlcnJ1cHQgQ29udHJvbGxlciwgc28gZXZlbiB0aGUNCj4gPiBTUEkgbW9kZWwgcmFpc2VkIHRo
ZSBJUlEsIHRoZSBpbnRlcnJ1cHQgd2FzIG5vdCByZWNlaXZlZC4gVGhlIENQVQ0KPiA+IHRoZXJl
Zm9yZSBkaWQgbm90IHRyaWdnZXIgYW4gaW50ZXJydXB0IHZpYSB0aGUgY29udHJvbGxlciwgYW5k
IHRoZQ0KPiA+IGZpcm13YXJlIG5ldmVyIHJlY2VpdmVkIHRoZSBpbnRlcnJ1cHQuDQo+ID4NCj4g
PiBGaXhlczogMzU2YjIzMGVkMTM4ODllMDlkMDg3YTk2NDk4ODg3ZGU2OTVkZjE3ZSAoImFzcGVl
ZC9zb2M6IEFkZA0KPiA+IEFTVDEwMzAgc3VwcG9ydCIpDQo+ID4gRml4ZXM6IGYyNWMwYWUxMDc5
ZGMwYjlkZTAyNjc2ZWIzZTM5NDlhMDlkZjlmNDEgKCJhc3BlZWQvc29jOiBBZGQNCj4gPiBBU1Qy
NjAwIHN1cHBvcnQiKQ0KPiA+IEZpeGVzOiA1ZGQ4ODNhYjA2MzVjOWY3MTVjNzdjYzMyNjIyZTQ1
OGEwNzI0NTgxICgiYXNwZWVkL3NvYzogQWRkDQo+ID4gQVNUMjcwMCBzdXBwb3J0IikNCj4gDQo+
IA0KPiBBRkFJUiwgdGhlIElSUSBpcyBmb3IgRE1BIHdoaWNoIHRoZSBkcml2ZXJzIGRvbid0IHN1
cHBvcnQgeWV0Lg0KPiBBbSBJIHdyb25nID8gV2hlbiB3YXMgaXQgYWRkZWQgPw0KPiANCj4gVGhl
IGNvZGUgaXMgZmluZSBhbmQgSSBhbSBhc2tpbmcgYmVjYXVzZSBvZiB0aGUgZml4ZXMgdGFncyBh
Ym92ZS4NCj4gSXQgd291bGQgbWVhbiBwcm9wYWdhdGluZyB0aGUgZml4ZXMgdG8gdGhlIHN0YWJs
ZSBicmFuY2hlcyB0b28uDQo+IA0KDQpUaGUgcmVhc29uIGlzIHRoYXQgdGhlIEFTVDI1MDAgc3Vw
cG9ydHMgRk1DIERNQSBidXQgbm90IFNQSSBETUEuDQpGb3IgQVNUMjYwMCwgQVNUMTAzMCwgYW5k
IEFTVDI3MDAsIGJvdGggRk1DIGFuZCBTUEkgRE1BIGFyZSBzdXBwb3J0ZWQsIGJ1dCB3ZSBtaXNz
ZWQgY29ubmVjdGluZyB0aGVpciBJUlFzIHRvIHRoZSBpbnRlcnJ1cHQgY29udHJvbGxlci4NCiIi
IkkgZ3Vlc3MgdGhpcyBoYXBwZW5lZCBiZWNhdXNlIHdlIGNvcGllZCB0aGUgQVNUMjUwMCBTUEkv
Rk1DIG1vZGVsIHdoZW4gY3JlYXRpbmcgdGhlIEFTVDI2MDAgbW9kZWwsIA0KYW5kIHRoZW4gdGhl
IEFTVDEwMzAgYW5kIEFTVDI3MDAgU29DIG1vZGVscyB3ZXJlIGNvcGllZCBmcm9tIEFTVDI2MDAi
IiINCg0KUGxlYXNlIHNlZSB0aGUgZHJpdmVycyBoZXJlOg0KTGludXggKEFTVDI2MDAgLyBBU1Qy
NzAwKQ0KaHR0cHM6Ly9naXRodWIuY29tL0FzcGVlZFRlY2gtQk1DL2xpbnV4L2Jsb2IvYXNwZWVk
LW1hc3Rlci12Ni42L2RyaXZlcnMvc3BpL3NwaS1hc3BlZWQtc21jLmMgDQpBU1QyNjAwOg0Kc3Rh
dGljIHNzaXplX3QgYXNwZWVkXzI2MDBfc3BpX2Rpcm1hcF9kbWFfcmVhZChzdHJ1Y3Qgc3BpX21l
bV9kaXJtYXBfZGVzYyAqZGVzYywNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdTY0IG9mZnMsIHNpemVfdCBsZW4sIHZvaWQgKmJ1Zik7DQoNCkFTVDI3eDA6
DQpzdGF0aWMgc3NpemVfdCBhc3BlZWRfMjcwMF9zcGlfZGlybWFwX2RtYV9yZWFkKHN0cnVjdCBz
cGlfbWVtX2Rpcm1hcF9kZXNjICpkZXNjLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB1NjQgb2Zmcywgc2l6ZV90IGxlbiwgdm9pZCAqYnVmKTsNClplcGh5
ciAoQVNUMTB4MCkNCmh0dHBzOi8vZ2l0aHViLmNvbS9Bc3BlZWRUZWNoLUJNQy96ZXBoeXIvYmxv
Yi9hc3BlZWQtbWFpbi12My43LjAvZHJpdmVycy9zcGkvc3BpX2FzcGVlZC5jI0w0NzQgDQojaWZk
ZWYgQ09ORklHX1NQSV9ETUFfU1VQUE9SVF9BU1BFRUQNCnN0YXRpYyB2b2lkIGFzcGVlZF9kbWFf
aXJxX2VuYWJsZShjb25zdCBzdHJ1Y3QgZGV2aWNlICpkZXYpDQoNClRoYW5rcy1KYW1pbg0KDQo+
IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4gDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEph
bWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvYXJt
L2FzcGVlZF9hc3QxMHgwLmMgfCAyICsrDQo+ID4gICBody9hcm0vYXNwZWVkX2FzdDI2MDAuYyB8
IDIgKysNCj4gPiAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC5jIHwgMiArKw0KPiA+ICAgMyBmaWxl
cyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0v
YXNwZWVkX2FzdDEweDAuYyBiL2h3L2FybS9hc3BlZWRfYXN0MTB4MC5jIGluZGV4DQo+ID4gN2Y0
OWMxMzM5MS4uY2E0ODc3NzRhZSAxMDA2NDQNCj4gPiAtLS0gYS9ody9hcm0vYXNwZWVkX2FzdDEw
eDAuYw0KPiA+ICsrKyBiL2h3L2FybS9hc3BlZWRfYXN0MTB4MC5jDQo+ID4gQEAgLTM3Miw2ICsz
NzIsOCBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfc29jX2FzdDEwMzBfcmVhbGl6ZShEZXZpY2VTdGF0
ZQ0KPiAqZGV2X3NvYywgRXJyb3IgKiplcnJwKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc2MtPm1lbW1hcFtBU1BFRURfREVWX1NQSTEgKyBpXSk7DQo+ID4gICAgICAgICAgIGFzcGVl
ZF9tbWlvX21hcChzLT5tZW1vcnksIFNZU19CVVNfREVWSUNFKCZzLT5zcGlbaV0pLA0KPiAxLA0K
PiA+DQo+ID4gQVNQRUVEX1NNQ19HRVRfQ0xBU1MoJnMtPnNwaVtpXSktPmZsYXNoX3dpbmRvd19i
YXNlKTsNCj4gPiArICAgICAgICBzeXNidXNfY29ubmVjdF9pcnEoU1lTX0JVU19ERVZJQ0UoJnMt
PnNwaVtpXSksIDAsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIGFzcGVlZF9zb2Nf
YXN0MTAzMF9nZXRfaXJxKHMsDQo+ID4gKyBBU1BFRURfREVWX1NQSTEgKyBpKSk7DQo+ID4gICAg
ICAgfQ0KPiA+DQo+ID4gICAgICAgLyogU2VjdXJlIEJvb3QgQ29udHJvbGxlciAqLw0KPiA+IGRp
ZmYgLS1naXQgYS9ody9hcm0vYXNwZWVkX2FzdDI2MDAuYyBiL2h3L2FybS9hc3BlZWRfYXN0MjYw
MC5jIGluZGV4DQo+ID4gNDk4ZDFlY2MwNy4uNGM1YTQyZWExNyAxMDA2NDQNCj4gPiAtLS0gYS9o
dy9hcm0vYXNwZWVkX2FzdDI2MDAuYw0KPiA+ICsrKyBiL2h3L2FybS9hc3BlZWRfYXN0MjYwMC5j
DQo+ID4gQEAgLTU1Nyw2ICs1NTcsOCBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfc29jX2FzdDI2MDBf
cmVhbGl6ZShEZXZpY2VTdGF0ZQ0KPiAqZGV2LCBFcnJvciAqKmVycnApDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICBzYy0+bWVtbWFwW0FTUEVFRF9ERVZfU1BJMSArIGldKTsNCj4gPiAg
ICAgICAgICAgYXNwZWVkX21taW9fbWFwKHMtPm1lbW9yeSwgU1lTX0JVU19ERVZJQ0UoJnMtPnNw
aVtpXSksDQo+IDEsDQo+ID4NCj4gPiBBU1BFRURfU01DX0dFVF9DTEFTUygmcy0+c3BpW2ldKS0+
Zmxhc2hfd2luZG93X2Jhc2UpOw0KPiA+ICsgICAgICAgIHN5c2J1c19jb25uZWN0X2lycShTWVNf
QlVTX0RFVklDRSgmcy0+c3BpW2ldKSwgMCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgYXNwZWVkX3NvY19hc3QyNjAwX2dldF9pcnEocywNCj4gPiArIEFTUEVFRF9ERVZfU1BJMSAr
IGkpKTsNCj4gPiAgICAgICB9DQo+ID4NCj4gPiAgICAgICAvKiBFSENJICovDQo+ID4gZGlmZiAt
LWdpdCBhL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5jIGIvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMg
aW5kZXgNCj4gPiBjNDg0YmNkNGUyLi5lMDJhNjc0YjEzIDEwMDY0NA0KPiA+IC0tLSBhL2h3L2Fy
bS9hc3BlZWRfYXN0Mjd4MC5jDQo+ID4gKysrIGIvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMNCj4g
PiBAQCAtODMxLDYgKzgzMSw4IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9zb2NfYXN0MjcwMF9yZWFs
aXplKERldmljZVN0YXRlDQo+ICpkZXYsIEVycm9yICoqZXJycCkNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHNjLT5tZW1tYXBbQVNQRUVEX0RFVl9TUEkwICsgaV0pOw0KPiA+ICAgICAg
ICAgICBhc3BlZWRfbW1pb19tYXAocy0+bWVtb3J5LCBTWVNfQlVTX0RFVklDRSgmcy0+c3BpW2ld
KSwNCj4gMSwNCj4gPg0KPiA+IEFTUEVFRF9TTUNfR0VUX0NMQVNTKCZzLT5zcGlbaV0pLT5mbGFz
aF93aW5kb3dfYmFzZSk7DQo+ID4gKyAgICAgICAgc3lzYnVzX2Nvbm5lY3RfaXJxKFNZU19CVVNf
REVWSUNFKCZzLT5zcGlbaV0pLCAwLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBh
c3BlZWRfc29jX2FzdDI3MDBfZ2V0X2lycShzLA0KPiA+ICsgQVNQRUVEX0RFVl9TUEkwICsgaSkp
Ow0KPiA+ICAgICAgIH0NCj4gPg0KPiA+ICAgICAgIC8qIEVIQ0kgKi8NCg0K

