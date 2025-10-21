Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAAECCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 07:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB6SK-0003QL-C1; Tue, 21 Oct 2025 03:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vB6SG-0003P4-GW; Tue, 21 Oct 2025 03:06:48 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vB6SC-0004xA-Ay; Tue, 21 Oct 2025 03:06:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=volV3DA4DbaKcaWM8Orf2LW2/R7N5Rgs5ksEx/ruSsRWSjQelYC9sC+ZN+f7h+UTC9QTOEscwygnsYTNt/36Ce93uxM753dM//ODePUCTZsLGOJvG9e555kb0N/7cgJqEd/O/KZTl8tF0SityKK9UICX2yVeGIlXO47kcd9a0jNrX5mxbSyuzjdKXxurBMxMu407qjeOTKPhAsrlchFjFn87SHYTmJ2XEUsxQudP7Wy8d0mRy9l6BdOhisNZKEeUf/CKPqbKZ9z8H9nWr8XeSvKYwRoXSaqnkY1Kn60P4G40n2MQGJYxc9YZz2vlEnWwKx1LvgDzJoU8AaRbr1EawQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBZtKd8+t5V945c40ulLfbatUonF4inz90IhgkvIkGY=;
 b=ip22fjFSkEPPD6z9kQQ6sNblwcvDY6co14xx9fECI8g1KNNrmS2jK+wEWb09ZMUoG/i/KOyzo4S0+qPnPKDwNwJ2X9vUXzd8VaDunLle5pS/BP3Kt0Nx4msPAhDFpdV4TDZafhCHepr2dfoOw1g8/PWqPMhyehrDquBfhKIv9yJ5yXqAiN5w35XiEhj/OZPIJi3vh2ryh+rqGHEbrnHny1+qg00Vjw3vTnjvU3HGIPAtBcxU45R+WqJaSPzoIPr5uFLPQ/pbsrDy1uOVAwdtNuN8DOK+IpQxqHnezEDoSkytUQOGNUej01nrKdlBek0ZxtQ9RB/q3zcVnYt428oR8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBZtKd8+t5V945c40ulLfbatUonF4inz90IhgkvIkGY=;
 b=hQ5r6ghVvspsxt8FLSgc+Ze/qNK8MnN7g82oBbY0UKqw6swDc+x6gkYAX6kxwmcI0f7i7v2lXkcCAO8c90Row5YwdBD+HbWZieEKO1ZMBe1vbO5pIREUgxTwDkjZshUMhA16hwxYeSdza5thpdXJRb8KbeShENRlAl1JQqpu4vRq4yfKBKn/muwnFM8CD74A7P/CVfYRYPgwJb2Oe3+M+e/tGext2qPICxJwI/PXgYXKYe0iYs/LnPc3NbzQJTOAfd5H72mr9aKeZ+UHpY3InZuzVMOv3DJY1wZEohBEvEuj7zo6oQE7m4HYsOfgsptWG2hoskzEIrHMwzyyFoCblg==
Received: from KL1PR0601MB4196.apcprd06.prod.outlook.com (2603:1096:820:30::6)
 by PS1PPFF8B9260ED.apcprd06.prod.outlook.com (2603:1096:308::26f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Tue, 21 Oct
 2025 07:06:36 +0000
Received: from KL1PR0601MB4196.apcprd06.prod.outlook.com
 ([fe80::13a8:12fc:7753:8156]) by KL1PR0601MB4196.apcprd06.prod.outlook.com
 ([fe80::13a8:12fc:7753:8156%6]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 07:06:36 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 "'qemu-arm@nongnu.org'" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: 'Andrew Jeffery' <andrew@codeconstruct.com.au>, Joel Stanley
 <joel@jms.id.au>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Patrick
 Williams <patrick@stwcx.xyz>
Subject: RE: aspeed: Split the machine definition into individual source files
Thread-Topic: aspeed: Split the machine definition into individual source files
Thread-Index: AQHb4PvonkQ5WUYo0k+UuuoQJWjdG7TEwxGggACgzwCABzH94IAAUq2AgAAAUoCAAAbrgIAAAHRA
Date: Tue, 21 Oct 2025 07:06:35 +0000
Message-ID: <KL1PR0601MB419671D3A296A0B12483EADDFCF2A@KL1PR0601MB4196.apcprd06.prod.outlook.com>
References: <e2df1ff1-3ce4-4233-b32e-2bc680725c71@kaod.org>
 <KL1PR0601MB41966988C6264D25E6782045FCE9A@KL1PR0601MB4196.apcprd06.prod.outlook.com>
 <965c2eb3-639e-4792-bd8d-f47682099601@kaod.org>
 <KL1PR0601MB419628CE287BDF2715845C4BFCF2A@KL1PR0601MB4196.apcprd06.prod.outlook.com>
 <d51ad87c-8076-4f86-b9ed-388313ae9e2d@kaod.org>
 <KL1PR0601MB4196F40949678039B771F610FCF2A@KL1PR0601MB4196.apcprd06.prod.outlook.com>
 <779258ba-20f2-49ea-abc5-790db8162742@kaod.org>
In-Reply-To: <779258ba-20f2-49ea-abc5-790db8162742@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4196:EE_|PS1PPFF8B9260ED:EE_
x-ms-office365-filtering-correlation-id: b5cd6060-f8ff-4314-0c2b-08de10705fa2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?aGk1R3RaTEVnelZSd0JWZEVEa0FJVmJJWDRaSHBwN2wwSXlWOVlwY0Q2NTBo?=
 =?utf-8?B?QVRoZWJ6bndzRlJWL3JRUm9XMTlRRlFZRVBWS0s1bFRXbTlaM3ZCQnFOQ2ww?=
 =?utf-8?B?TStxL0s4RDFFYXoyV0R4blVmMS9RZHJyUk1LUUtyai9GL0sxL1hkQWNxUjhj?=
 =?utf-8?B?MHNvcktxVWNZRG9DM2VCMnY1TEZaRE54VGZXM0dvY2lhZG5oa1lwSnYrQkpo?=
 =?utf-8?B?aGpONUF0aHdqZ2d1cFAyYjNDcldKSkN5aytWMkxYak8wdXBONXdzcjNBTzR0?=
 =?utf-8?B?OVNFQVNWWlg2MTZqQ1U1U28zdCtPS29STHlPTmhrWVZhMUEyR3VOUVRPRTh2?=
 =?utf-8?B?QVNDSUhob0MrNUp3TE5tSDNIclB0dVU2VEJ1bll1Uk05QVVFNzltNitmZHhL?=
 =?utf-8?B?cEw2K0xBcFExOXlIQnQxTkY3U3BvWm1hUTltYVZQTW9pZEd0dU9MdjhkejZ2?=
 =?utf-8?B?WlJrTG5RajZySytybkgwOEF6czJCV1JWVDJPMVdKdUx2QTF1ZjZwMFd5bVdK?=
 =?utf-8?B?WlQyTTM1VU1XdlU1V3p5MkRQdkswNUxwMVNsNUYxRUpwa2k5ZkZnVFF3Q29D?=
 =?utf-8?B?dHU1SG0vR1RwaG5tTExlYnZZY2JibENUTzVPMmQ1eVVwMWlUWFVtK0wxVkFF?=
 =?utf-8?B?aHpPQmJ5UjhIMDNtSHBncFVvK2M4UFlHTWRURkN4NWxmSERhc0lNS0dDT1Ux?=
 =?utf-8?B?OWFqYnV3UHpCbkhqcXJ2SGFSQm9rMDFDNEQ5cnoxa2l3Zmo2Yk5wM1dSdnJH?=
 =?utf-8?B?MEE3am52TjF1dWVjNjQ5d3U2cVo2SVdnU1JPdDZVLzNOaVUzbzlkNGdOdUZo?=
 =?utf-8?B?NUFmNTdyaUZCT3k3QTVoL1Z2TE9qYVdHOWR3YUZKbWRESUQwWnV1WmZ5TTU2?=
 =?utf-8?B?YjZ0Mi9MTlFHcm9YeWNmUXI3cTV2N2t3cE1sNGpGYkVCTVMzWDM2NTgwR09L?=
 =?utf-8?B?c0QyQUtRbUxRODJqNlRJV2NuV3pYQ2tCOUVmeHJBWUp3aVExMi9lVmdjNkhk?=
 =?utf-8?B?Y25BZy9NZGM5V2VsT0sybXFQK2lGN3RmcXVrdkxqSm9jTk9ESTYwWUNjczdH?=
 =?utf-8?B?NHJIb2dsS2J5Yko3ZVRtK0haYUJIUndIb0VyS0E1aXdrNWJFU1hVbTF2cnl5?=
 =?utf-8?B?cWtLdE82VHhqVlNlSTlyTmJyeGZQNlNLVGcxK3NSbWd3Sk9IMG5pa05SNFAx?=
 =?utf-8?B?dHhNTWFpZHZXOE45WW9yWmhTSWhXV2orcXU5bXhaMjNtNWxBOHc3VExPVllM?=
 =?utf-8?B?Y1dPVHBoNjhWZjFXeXhnYjYrMTJsNFRqQ3VDd3R3Vk90enVsSEdIOHFOMEdm?=
 =?utf-8?B?eUU5bWw2clRGWHl5SzQ1ak04S1JnQldKb0FpUzdhWGZHeUFrUHFUekI5dllI?=
 =?utf-8?B?ZjdVNnpMU3hoVXZaRlZLUDVZWVRSY0hqQVc0V09TVy9KQTI2L1VRbGJXNStS?=
 =?utf-8?B?ZXlldFBuZk1GNk1UN1IyODlhQ0RCK1hBRkpDRUdHUEdSMXcxMUhDOGNFdkhQ?=
 =?utf-8?B?dURSZXF3WWx3R0xGdmoyNk5Yd050aEJaRStaVDNleW5UUWN5RkFCRG1pVUlS?=
 =?utf-8?B?UFIxU0tKVkcrQVBKbk05WXJ5RGpOOWlZYlJzY0JrQWVJM0d5b20rY3FXVGVl?=
 =?utf-8?B?dFhNc21wOXhURXc3RUl6bDNtbUxtV1RFTy9qSVpubXJ5Yk5DY29xRkU4VXBI?=
 =?utf-8?B?dUpranlNT0w1eno2ejBqMk10Ym1UQUdKcmRlV3BSZHNhUFhWNXNwaFdDWUR4?=
 =?utf-8?B?Z2xDT1l6aHZRUElPY2lLNGxqUWRNMkcyaDUyV000MGlKQ2RhS1QvcUc3RTcw?=
 =?utf-8?B?eURrWEtlUjZFdDVYMForWm5zM1BVajloZ1gzdmZJc3lZVDJ3djNTdE55NXBU?=
 =?utf-8?B?RlU3WGdCWlBOQzFCanJQQWVLUmZqM3hTRDc4K2poZjdaeGxwT3hBTVljajZi?=
 =?utf-8?B?eEZVNC9adXo3Rk85b2NyQzNtTGZKYnd6RTdIa25FM0dUUU1VWHp6SDYxV2hV?=
 =?utf-8?B?NkdLVVU3RWsrUmR1T001cGROV0lqMVZqYWZpZTFjbVYyWHY5eHFiRjJYL1Vi?=
 =?utf-8?Q?OpLAhb?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB4196.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0h1NGM5ZXNxTWd3S3lCeXpMU0toVWhKVHVZeUhMU2JEOHdXYlJYUHU4SDFB?=
 =?utf-8?B?dFJNQm55NVp1eThUcWdqQkxZUlcrU3J3TFQ5Vkw5dktraGlSUjFkeTdiaFdL?=
 =?utf-8?B?cm5ZY3lPb1ZycldCbzU3OUk4OTFxMFYrRFhpYzRUQysrUVpCckZVVWpzNmtw?=
 =?utf-8?B?T0dEYm9XWEU2bXR2T1RTbCttZXArYUVJaWF1K1hPcjJUdlhMR1BzandGWjVq?=
 =?utf-8?B?c0JKdU5yQjlzSFVKVnM2QlFEM0kzZEV3NURMQlJMWVgrOTZzalBJNGRRY2M0?=
 =?utf-8?B?cUErWEhESml4a1VvMFNiS1ZyUXFROXMrSW94MERNdC93Zk94M2J4blhGLzFD?=
 =?utf-8?B?T1pBeE42U2xwbjJlUnNkK2ZJR3h2eW1ZT1FaY2hxMGkyc0xOL3ZBSjhpbFFR?=
 =?utf-8?B?WWFsbk96UFZtcml2M1h1Y0R4anVoMHBaVmp3dlRZQi9KNVQ4NVhRU2pxWS9F?=
 =?utf-8?B?cEk1Nzhrdm1PZkJudVROeDlBYlVvZmFEUnBZQjZkbkZYa1RJVEc1Q05tMURm?=
 =?utf-8?B?U0FDUnBPZ0pEVE1KVzRCMzFLaWNzZzllVDJ3N3VycmpBN0Rhc0tvcVNhUE1Q?=
 =?utf-8?B?NjJvRWpGcVFsZFlSQ2RYRjBjd1MyZEl5SzVQengyYXRVc0lveDQvZHphQnE5?=
 =?utf-8?B?aXl1UlNNVXFrNWFMWWpLNktNbnZkY1hadmRIcCtMMFdhUEI1aEhVRWhqUFZP?=
 =?utf-8?B?dkVQZHpad3J6aHlmWnJkcjZUUnhCYkRRSzAxbTl0STUvbjhObXJ4OHdTNmJs?=
 =?utf-8?B?UkZpbjFMa1hTUmRXcTkzOEJMZEZWby9vbTJzNm8yeWFDUG04dENEUlJabHMv?=
 =?utf-8?B?VG53STFmelE1c2diaWpEM3VXbGtRTC91QmZxb1BTRlE2UFJqVW9INE1wQ3FJ?=
 =?utf-8?B?V1NoVWIrWU0zb25nSXVudDliKzBDaENPODFuRW5GczJzbVNYTVNMRms5ZGFZ?=
 =?utf-8?B?eXJ2U3lTcEVRbnVHREFBa00xZHlJL3J6MXl4ZFR3SEw4eFBrL1NUSDFLMXpw?=
 =?utf-8?B?L0wxejROdXZYazZIV2dKUHBkOUNJdjNzRFZRd3o2dDgxbmt5RnpUNE4vWVZk?=
 =?utf-8?B?RmRiVUN1SVR0ZUM4YVlEVHhLUERLQ2k2REZrT0FodTZSUmM3TW9SSlAyVjJ0?=
 =?utf-8?B?VDkxa0RHellwMTNJOUFLc2FLdENuMzFzWXFYZjhnenJ4KzJ0UTN0RWRxY0FP?=
 =?utf-8?B?WGlTakMxWEdBQ052dFIwaHBDWnFsVnVvWWNOQnFTeDdJcnpLMk54djhKd2Jx?=
 =?utf-8?B?YkVvZGRkVTVua2txdmliNXBSL2U4N0FpS3ZSR01FN0VsOFJya1R4aHhKTG9M?=
 =?utf-8?B?Um1NSG5XM1Rpa3o4YWxvQ01RMk5PckZ2azRleVhUTTlwTkw3TkNDZ3VzMlkx?=
 =?utf-8?B?OGVMUVo5cFlxZTNpaDdHZ01yb2Q4cWQ4TEVVaGxGc1lMWmY4dktYRm1MU29N?=
 =?utf-8?B?TEs1bGZnYkV3bERJeSt0WUk3Q0orT1lkQjZvNHJoaUxQOEFqSFBaRjlONU5W?=
 =?utf-8?B?SmczazJIQTF5ZStId1k0bGNIY1ZrcmpneFFucE9Bc28zelJueURNbkVENkl6?=
 =?utf-8?B?Z1Y2QlVUZmViZDNSQXpTTnIwVG84R1B0MTdsSmVIM2QyZmVpVnhXZjlVUjdO?=
 =?utf-8?B?UHBKNTZPYWhvUGx3RmZWRmczaHM2cmNTc1k1bVNNcDhkL2Z1SCtHNnkxK1da?=
 =?utf-8?B?cHdGeVNmbDN6R1B2UXZoZDF4UWNYNmR5MzFjbXltdnhsVEw4ajBXc2U2YXp2?=
 =?utf-8?B?L2F1ZzA3NXNkdGFQK04vcWpVNG4zTG5LWTN0V2s0TURoS0xGNUhMOU1jYml2?=
 =?utf-8?B?V2dIZEw2UDA2UWM4TVhoOEZKcE9sS2FGVjZ3dy91Y25sOHZkVWlhUE04STM2?=
 =?utf-8?B?SGZXdExUeTY0MWNNbmpUWG1wMW9JeVdoRC9PL3RSeHFMby9MNS8wSnNpYS9G?=
 =?utf-8?B?dGZsRXAydWVSS1hyNFJSd0R3UUMvYTU4YjNUMUY4ZTNzaVVORXM0L3ZmbXU0?=
 =?utf-8?B?UE03bHZ2ZE90MkJDV0hqVmk1Umtrc08wYmNleVphODZhSVMzQmZZYWtqRzBH?=
 =?utf-8?B?TXdnRXhwc0dEbFpYR1ZIQkpUTFRJUldIQzlxMklWVDZjNFpKOE9vTUFDRXBB?=
 =?utf-8?Q?+sADkbpEMna/AlSGpn/sbjFg1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4196.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5cd6060-f8ff-4314-0c2b-08de10705fa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 07:06:35.9580 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hscVfGfX3+VEMRfXHJG4iwwoFrWGXoRWpwxQfmYWMg+w+3Dy5NTn2z5AcCiAxTB3FV1sGZoUSn5CWThZKa+mdwLMOTpo4lf0hHNtJ6kUc8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPFF8B9260ED
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KDQo+ID4+DQo+ID4NCj4gPiBody9hcm0vYXNwZWVkX2FzdDI2MDBfIGZieTM1
LmMgKGZieTM1LWJtYyBmcm9tIGFzcGVlZC5jKQ0KPiA+IGh3L2FybS9hc3BlZWRfYXN0MjYwMF9m
YnkzNS5jICAoaHcvYXJtL2ZieTM1LmMpDQo+ID4NCj4gPiBCb3RoIHRoZW0gdXNlIHRoZSBzYW1l
IG5hbWUuIERvIHlvdSBtZWFuIHRvIG1vdmUgdGhlbSBpbiBvbmUgZmlsZT8NCj4gT2guIEkgZm9y
Z290IHRoYXQgd2UgaGFkIDIgbWFjaGluZXMuDQo+IA0KPiBJIHdvdWxkIGxlYXZlIGh3L2FybS9m
YnkzNS5jIHVudG91Y2hlZC4gSSBhbSB0aGlua2luZyBvZiBkcm9wcGluZyB0aGUNCj4gImZieTM1
IiBtYWNoaW5lIHNpbmNlIGl0IGl0IG5vdCBtYWludGFpbmVkIGFuZCB3ZSBoYXZlIGFub3RoZXIg
bXVsdGktc29jDQo+IG1hY2hpbmU6ICJhc3QyNzAwZmMiLg0KPiANCg0KVGhhbmtzIGZvciB5b3Vy
IHN1Z2dlc3Rpb25zLg0KV2lsbCBkby4NCg0KSmFtaW4NCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4g
DQoNCg==

