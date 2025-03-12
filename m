Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA04C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 09:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsISI-0000tZ-32; Wed, 12 Mar 2025 05:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tsIS7-0000k7-F8; Wed, 12 Mar 2025 05:32:39 -0400
Received: from mail-psaapc01on20704.outbound.protection.outlook.com
 ([2a01:111:f403:200e::704]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tsIS1-0008GX-Pr; Wed, 12 Mar 2025 05:32:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCHM/ixH37nHIdgFPv4QjG+HNQgMrAUqp1s7QJZ1Ii7TShjlknh6Rmku4kQj/oE3lpeo7avcM5ISNR5AL1iHFaOt956zrb7WtDiZKsHlwibihMzoe1lX3kXwG1WvYcdvGMIl3xEqc4H4kKmfmNUOAfen5Fuxbt4I80FWUDB7ATLxtj0pgGzGpp+kml8rR/1aymPtf0gem7Qiau1FX6m3IDUbCi01wmf4gqstAP7x7mBTzWkTN/odKl9NQevtGDAvGnkZy+tqWywRmMZfPKPDVQN1Y9daYUK50wRanI9OnScIHTIeEEubYTl9FQND9Y0xCtNyNVVCMqFllut7u0GK+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZsBF/7ddoqYcROzkD8NPuj55eGX65CGwPXU5H7X7mI=;
 b=wd7WUFQjILNYLz3+qvMfrAYtw3XY9XxLP2kV/IfUCJmB3D3uVUBuy0+5vNzBB8pIM1OUFPHZIpGn66FQKyW/j6FwtZj2CcLh8pg8LgUnq55/HnkhEKiAxKTJwzt7kjGo+fW6OI2YiXehnt1a+MaXRvSbjCH+Vc0v0Nb2PDdRA6AN1c+N/Tgzdp1PbX/6ceFXHJKcMlDxMH6mVRXUvv/9hsiqpasRcZI1SrMpP9e8gS8qvJMylZVHtqiwX2jT/FxgJq0ttU5nW299mMc4fkYI1Lg2auwDMSUNwdRcy5pl9fY8M7STWCDnnQeAACpdHzoFme3ign0en46bGCtzJ52EOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZsBF/7ddoqYcROzkD8NPuj55eGX65CGwPXU5H7X7mI=;
 b=Gqi7GCO7a+RG0ot4vGtrOGYYaZh4B4/mqRmVWkkpKanwypmgmbgEoQJiYqwznCNnsnvvlpwZPIGJLVhZF6PZud+poPsjK/+ALLvldtvL+KohtDLqKk2c3ePMr6GAz9SENDe5pb8vRL1MCipoTa+KEto1Cy/5133scmlEuKirSNuXKT/j/3uOBBxXm332antV9LTus/eTusXM37fJK3ZuuHoDbitOA2W3qk7fLfWANSGnOJveJTTj+N9ukZJDPCmC/uf3WqarfRQmbJh4YDvHpAUwQdQrXoyQtjDXBXmEeyX9+ARdAq9f5ha/lTL0i3vBjdfdVKITIDwhWQSbYicukg==
Received: from SEYPR06MB5037.apcprd06.prod.outlook.com (2603:1096:101:51::5)
 by TYZPR06MB7282.apcprd06.prod.outlook.com (2603:1096:405:a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 09:32:15 +0000
Received: from SEYPR06MB5037.apcprd06.prod.outlook.com
 ([fe80::7c38:ebde:a05c:8196]) by SEYPR06MB5037.apcprd06.prod.outlook.com
 ([fe80::7c38:ebde:a05c:8196%3]) with mapi id 15.20.8511.025; Wed, 12 Mar 2025
 09:32:15 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v4 0/4] Support HACE to AST2700 (resend)
Thread-Topic: [PATCH v4 0/4] Support HACE to AST2700 (resend)
Thread-Index: AQHbh1rG/7jCr59pB02FklenV0ziUbNvUoWAgAAAvqA=
Date: Wed, 12 Mar 2025 09:32:14 +0000
Message-ID: <SEYPR06MB5037484B224FD0F3DE53B117FCD02@SEYPR06MB5037.apcprd06.prod.outlook.com>
References: <20250225075622.305515-1-jamin_lin@aspeedtech.com>
 <675766c2-4015-43e8-b070-d58f2cdd23e7@kaod.org>
In-Reply-To: <675766c2-4015-43e8-b070-d58f2cdd23e7@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5037:EE_|TYZPR06MB7282:EE_
x-ms-office365-filtering-correlation-id: 99e91991-5b9f-4784-b55e-08dd6148c643
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?WWRNYW9ublNPNTJmcmhJVDdpVE1DNk43ZXlnbFF2dEJtMGdBdUcydHhkTUU4?=
 =?utf-8?B?a25qa01vR1NPTHJHb01wSEJjM1EzQzhlTCtyZDFpbTUrSmtwOXRaQm8yeHBs?=
 =?utf-8?B?NXJ4dFh5NTM2THlRMFk2UmpDdHJtcmdFYVFWQUJYK2lWNjFadWgzN2Rkc0RS?=
 =?utf-8?B?VlRweERWSlkySmJJTWtiZHA1bzdoRTBxYUtiK0JMNUlISzRHZ0FDS08zM0F4?=
 =?utf-8?B?SkJ2UmRIaWQ3MnkyL1FsbzNIVDJyYTNCOUFXTEJWU2N5MjR2SlM3Zk51ZENY?=
 =?utf-8?B?QW5ZcHZGdE5yZjVSYlhCWGU4SENSMnNaZEppRVQ3Mm1sRmtOZWhSL1lVQVBK?=
 =?utf-8?B?YTlSeHp5Z1BzOG4zQmlWUElNRmsxZkdQM1UyTjd0OXFRMUNvaGxBcTlybnRw?=
 =?utf-8?B?WFJYMHVnenIxOVd5OGs3eURzaHhQNnhPM2VXYldaT1N6dTdOMzQ2MkxGbDF5?=
 =?utf-8?B?elkzcjBiMG1FRVFURDE4S3lUUVptLzQva1VxNlRoVUpPdmxYemd3UCtpemV3?=
 =?utf-8?B?c1NNT3R3VytwNVUzY3hTeGJNYmJydlY5OG85OUIzTjBzQ3FrNk5XS05IQ2Ny?=
 =?utf-8?B?MXdIdWtvaXZheEpLdTIzd0huLzY4T05WcXN5WS9pUkVJUXBUbE5ZclltLzU0?=
 =?utf-8?B?UGJjRG5xSmFTendraFJEdk1GdE5CeWxnM0xUVHBoZEtwKzYvTU1NaFZ3Y0hn?=
 =?utf-8?B?ODVBOHYvM0EzN2NLamFKbFprZ3dWWWY3OFE2NThOM0RJNGRzYW1NbjE1aWZH?=
 =?utf-8?B?ZmNuSFkyMk5pOXRHOTNLNXV5UjlDVlJub3ZaV0ZiajFGZmNZQlJBOHRuUFA4?=
 =?utf-8?B?eEpEczZzcTZaS3FTWXlLRXVuaytjSWE3OC9sT1ZWNm84dzRWRGhVdWx6LzBJ?=
 =?utf-8?B?OUFSaXNHQkpDSjlmMzhOTzA0Y0FaTEpOdjlyTExHU1VITW1GdHFNSURpTWNj?=
 =?utf-8?B?SVcyY1gvRTYweVc0ZStoZ1E1VExFMzJkMTVjanlqcG5lRnVRdXdqeHoyUXpU?=
 =?utf-8?B?Zk52aWl3ZFIxemxJRWRvNWd3d1FCdnFrWVJXSmlCOWlGY0xiTENXWGliNlY1?=
 =?utf-8?B?TXYxNHJBbnFwNVVlVUp5MmN1OXlXVlBlT2lHM2NDVW9SSGpmRHhaMFlqcFVv?=
 =?utf-8?B?TUkxaDdiTVBiak9JMzZTNndiL29xMC9VSDJQSWFoUXA0UnFOMDNzT3BuZWpl?=
 =?utf-8?B?WDRnR1EvZGZLQ0R1NjJrTU9lQVFNRk0ycEVrOHVhejhJeVVsU0ZSbVp5Qlhr?=
 =?utf-8?B?dGNJU1BDVE9LNFpWcEpkaHB6TE95bTE1TjlWSmFLR3BxRjl3VjBQZWdMcHRk?=
 =?utf-8?B?Z1Jkc0FjRUNMdzdRbHM1YkUyTGxxWUpLY3VJWkFPWHJWVmdmKzBjRm1XUExv?=
 =?utf-8?B?a2ZZN25NNmdVbi8vcjhwM2kzR0c5NkVhd1c4M3ZkelZRSUMxeHo1aWtxOGI5?=
 =?utf-8?B?RDI2VDNDTHNsSHNsb2hnK3Z0NHMrYkRkUWxiblphWGpUMXZ3bDRpb1NRaFVp?=
 =?utf-8?B?U1Uzb3U2citVeG1FMVNYRjU2NFVEYXRYcUxEOWNrNUhyZVNNTnU3ZjJId1Vk?=
 =?utf-8?B?NG1GZDZpRzk0UVJEaGJFWVFJUk5OYkpiRk9FUW5Qa1FkNGZpRkV5Y0Yvd1Zx?=
 =?utf-8?B?eUNIZFo1VFFTUkVLVjZzK3duTnJkUE9hc1BJRXdKMC9nYmI1eHJPOHpqSWI4?=
 =?utf-8?B?aXFSTG5Pa3JCaEs4OGY2Z0dYVDhub1B4ZW9PQzVxeEpOK3hvTkt3RGNnaGY1?=
 =?utf-8?B?V2ZtRkozelRMWGU3WXAyK3o1VzNmOExZSFczcU82Y1JOalRYQTBPbVdmcE9E?=
 =?utf-8?B?R3BIU2RaN3daZnExeCtqSHVTM01hN3FDbFYvVkVMb2h3YnFnbGJsQmFIc0ky?=
 =?utf-8?B?WENIRDVQSUdjK25VZy9ZczZ1SWVwRHlORU5zRzVoUmJDeEpLUGg3N3Y1UURH?=
 =?utf-8?Q?jA5xn0GmlNtWEDkbN5VD71HGJQMSXNpk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEYPR06MB5037.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTZ3eENFUTBjeHpEUWl2Q0U0RGFVS3ZEeExKU1FKMDFyMDA3NkovT01Wek8x?=
 =?utf-8?B?dnJHb1diMHhmL2J4b2F2dUQwS2tKYjBENVNVL1pjS1ZmZHdHczl3dDZublUw?=
 =?utf-8?B?K0V1RTh2NG13SVVxeTNaQmtWTFZwRDVEdE5uZkF2VVFjVlErUzBtNWFrcUtX?=
 =?utf-8?B?cXR5TTFXQzhwV0lmRU84MjNuRUJPZjR4bngyOWNHTkRvRUw4TTZiTVlZV2lo?=
 =?utf-8?B?Q1Vmai9LendPTmZVa1dWYjVOSWNmNVMvL01RT0hKckxxMTdtaEFmMlBLVG4x?=
 =?utf-8?B?dEhhdU5RSDhDbUZmZDdYN2pTcHBpUFQrM3RIRUZkckdZRUZaSThEeWl1bzl5?=
 =?utf-8?B?S2Y3Z3NHZDQ0WmlHRm00eGFNY3Z6ditSbGZJTSs2dW5tblNXWW90d3p2WFQw?=
 =?utf-8?B?dUVZTlZuTG1SWThJUzVPZk80Kzd0Ri8xTDJpYmw5b2tURnhsNWpWc1lvNTky?=
 =?utf-8?B?YWJKTGJwaXdyN1Y3ZlAwUWtQSFZSWUZvL2tzL0xzVjd3MTcvYjNsckVsakln?=
 =?utf-8?B?Nmw5aHJueVc5ZVowVDRuSjJZNndDcFR5bGpmN2lOOWFidjlyTlJ3QjJ4NVp1?=
 =?utf-8?B?U0pITENJc254ekZDYklwb210RFRDTlpXUktYK280dkx6VCtTWmxmTTd1b3Fh?=
 =?utf-8?B?d1l0SjV6Q2Q0NlY5UStnWUZPZ1hkMm15eGdycVo5RWtlckUvcUd6MWd2R0lj?=
 =?utf-8?B?RXFaK0ZRTWZVUDMyeXd6cURYN2dsSGdlUEQvZUlXeGQxWUJ2c3JkM0ozUUxD?=
 =?utf-8?B?UGpFbmczQ3VJWHVKQVBDVXg0NEttVnNUUm4vTjhXUENIZmZkUm14SUE4dUNk?=
 =?utf-8?B?VDMvU1hMdGV1aFZsZUUrUmRnR0hrdmNLSGhqMGJOd1NmV2xxTUtVVVBTbXJs?=
 =?utf-8?B?YUlpRzhpRThvbGdtdkExMThYQkNUK2c0eFRpamc5KzM1QW1jZUUyRG1yQmJU?=
 =?utf-8?B?d1E1Uk40b1p5bVo3ek0xZjB6L0hPcnFIcTltU3pzOENUR2J3cERkVEttd0xt?=
 =?utf-8?B?dVhEeis2ZEE0M3p1YTBPY2k5NURlN1JXMzJkYzdZd2N4RW1OSmhRRUJxVWlI?=
 =?utf-8?B?MzdZOUp6ZHRZNWVWWHpmaC9KWm9JSG9PMTBLZGVxVzdQWUIwY1ZabGZZS0cw?=
 =?utf-8?B?OFJodXEvQzFHMWVsWXAzVnprb0xtR2Q5QWRTSGVTTUJ6cWVvVXRkY2plRmtk?=
 =?utf-8?B?SldYOWhwMDJPK2EyR3hnVjZSTmQ0NUQ2eE56OEtRbG9KeWlDMUdzNkxzUGRp?=
 =?utf-8?B?RE83MzNGbmJHTksrTFo2Ry80R1dXa0VIZUxMaHVCMmRDSVVhSDRHdDBPYnRw?=
 =?utf-8?B?VWZBcW11Rjgyb0xGUm52S0ZHMWJCZGc5VW53bGduTnNON2hyTEs0YmhpNCtS?=
 =?utf-8?B?RWRLNnhkL3liRGpQQ2RieXNNK1pRMjlIdWFOdGxBSjhzMW1LUlduaVBYV2FM?=
 =?utf-8?B?eGNhaGdKQ1ZEZzVYRXJ0YTc3Q283a3ZKNnAvbSt0WGVRZnMvSm83Q0hlWDRQ?=
 =?utf-8?B?cnpIb3NMU1JIUFYvYmVkRkN2bnJvQ3BoUnJYOG16WlN2dDB0R1hqT0VRVnVz?=
 =?utf-8?B?U0xuSWtucFc5WEE3T2FtdXh0SkkyTUdTOXRzWHY4anFscTJaVWRPaHJ3OFhI?=
 =?utf-8?B?SjRaem5KV3AwbWRlRldQWUwvTDgzYTJ5dUliRXppK3F3bWxaSkVBRFViL2lt?=
 =?utf-8?B?RGhaSm9xTW5ld0t5dEkvQXNhQzVGQjg3WHl6WVB2cU90K0ovdU9GTVhCVlBk?=
 =?utf-8?B?QlpMRThua05uWTBCMDYrSWszQmxPaGZaZ1ZEZmo1eWRRUklqTmF1Skdnb2hD?=
 =?utf-8?B?ZXc1UU13dXAvQVI1U3poYStUeXFvNmpHZWQvTEVDZ01qVUJ4dE40VUt0ZGpi?=
 =?utf-8?B?SVQ5SGZMYWhBSHF3akZkUDU5aElXeERKeEtmTG04WUcxQ0w0Wm1XVENmUm83?=
 =?utf-8?B?NEhBWkRZTG9WYVBJWCttUHlycnNHY2laNzBpWUZoUlB3aFdrM2s3M3YyWDdj?=
 =?utf-8?B?eVBzY1I4WjJpMzJIcFVKMXVqS1VDb0dpVVAybm8yd3Z1cjZjZFpXZE9DLzZv?=
 =?utf-8?B?djVXWDZ1RjlhRlJlT21pZ0Q3ZC9SMER2b1RYb0gybkpSSll5eXpKMVY0UkZj?=
 =?utf-8?Q?thPNOeR//HBt2EcnWOC1Oj1CP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5037.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e91991-5b9f-4784-b55e-08dd6148c643
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 09:32:14.2405 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PLvZQiI/6WtO1EFy5+JK84fvNCLmAlx19ODFmM/OZZm5kdZZILASZpmy3TrRTLJgKHjiE30UVWazzOEcpPtvumQ3w/8gL9qEyvdlpfZra2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7282
Received-SPF: pass client-ip=2a01:111:f403:200e::704;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

SGkgQ2VkcmljLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEPDqWRy
aWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMTIs
IDIwMjUgNToyNSBQTQ0KPiBUbzogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+
OyBQZXRlciBNYXlkZWxsDQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBTdGV2ZW4gTGVl
IDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPjsgVHJveQ0KPiBMZWUgPGxlZXRyb3lAZ21haWwu
Y29tPjsgQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT47DQo+IEpv
ZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+OyBvcGVuIGxpc3Q6QVNQRUVEIEJNQ3MNCj4gPHFl
bXUtYXJtQG5vbmdudS5vcmc+OyBvcGVuIGxpc3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZQ0KPiA8cWVt
dS1kZXZlbEBub25nbnUub3JnPg0KPiBDYzogVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2gu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDAvNF0gU3VwcG9ydCBIQUNFIHRvIEFTVDI3
MDAgKHJlc2VuZCkNCj4gDQo+IEphbWluLA0KPiANCj4gT24gMi8yNS8yNSAwODo1NiwgSmFtaW4g
TGluIHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGlzIGZyb20NCj4gaHR0cHM6Ly9wYXRj
aHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L3FlbXUtZGV2ZWwvY292ZXIvMjAyNTAyMTMwMzM1MzEu
MzM2DQo+IDc2OTctMS1qYW1pbl9saW5AYXNwZWVkdGVjaC5jb20vLg0KPiA+IFRvIGV4cGVkaXRl
IHRoZSByZXZpZXcgcHJvY2VzcywgSSBoYXZlIHNlcGFyYXRlZCB0aGUgSEFDRSBwYXRjaGVzDQo+
ID4gcG9ydGlvbiBmcm9tIHRoZQ0KPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2pl
Y3QvcWVtdS1kZXZlbC9jb3Zlci8yMDI1MDIxMzAzMzUzMS4zMzYNCj4gNzY5Ny0xLWphbWluX2xp
bkBhc3BlZWR0ZWNoLmNvbS8gcGF0Y2ggc2VyaWVzIGludG8gdGhpcyBuZXcgcGF0Y2ggc2VyaWVz
Lg0KPiA+DQo+ID4gdjQ6IFN1cHBvcnQgSEFDRSB0byBBU1QyNzAwDQo+ID4NCj4gPiBKYW1pbiBM
aW4gKDQpOg0KPiA+ICAgIGh3L21pc2MvYXNwZWVkX2hhY2U6IEZpeCBjb2Rpbmcgc3R5bGUNCj4g
PiAgICBody9taXNjL2FzcGVlZF9oYWNlOiBBZGQgQVNUMjcwMCBzdXBwb3J0DQo+ID4gICAgaHcv
YXJtL2FzcGVlZF9hc3QyN3gwOiBBZGQgSEFDRSBzdXBwb3J0IGZvciBBU1QyNzAwDQo+ID4gICAg
aHcvbWlzYy9hc3BlZWRfaGFjZTogRml4IGJvb3QgaXNzdWUgaW4gdGhlIENyeXB0byBNYW5hZ2Vy
IFNlbGYgVGVzdA0KPiA+DQo+ID4gICBpbmNsdWRlL2h3L21pc2MvYXNwZWVkX2hhY2UuaCB8ICAy
ICsrDQo+ID4gICBody9hcm0vYXNwZWVkX2FzdDI3eDAuYyAgICAgICB8IDE1ICsrKysrKysrKysN
Cj4gPiAgIGh3L21pc2MvYXNwZWVkX2hhY2UuYyAgICAgICAgIHwgNTUNCj4gKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystLS0NCj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgNjggaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiANCj4gVGhlIGtlcm5lbCByZXBvcnRzIGEg
bG90IG9mIGVycm9ycyB3aGVuIHJ1bm5pbmcgdGhlIGNyeXB0byB0ZXN0cyBvbiBhDQo+IEFTVDI3
MDAgQTEgU29jLiBTZWUgdGhlIGZ1bmN0aW9uYWwgdGVzdCBsb2dzIDoNCj4gDQo+ICAgICAgJCBn
cmVwIGFsZzoNCj4gYnVpbGQvdGVzdHMvZnVuY3Rpb25hbC9hYXJjaDY0L3Rlc3RfYWFyY2g2NF9h
c3BlZWQuQVNUMngwME1hY2hpbmVTREsudGVzdA0KPiBfYWFyY2g2NF9hc3QyNzAwYTFfZXZiX3Nk
a192MDlfMDUvY29uc29sZS5sb2cNCj4gDQo+ICAgICAgMjAyNS0wMy0xMiAxMDoxMDo0Miw3MDU6
IFsgICAgMi4yMDY4MzFdIGFsZzogc2tjaXBoZXI6IGFzcGVlZC1jdHItdGRlcw0KPiBlbmNyeXB0
aW9uIHRlc3QgZmFpbGVkICh3cm9uZyByZXN1bHQpIG9uIHRlc3QgdmVjdG9yIDAsIGNmZz0iaW4t
cGxhY2UgKG9uZSBzZ2xpc3QpIg0KPiAgICAgIDIwMjUtMDMtMTIgMTA6MTA6NDIsNzA2OiBbICAg
IDIuMjA3MzI4XSBhbGc6IHNlbGYtdGVzdHMgZm9yDQo+IGN0cihkZXMzX2VkZSkgdXNpbmcgYXNw
ZWVkLWN0ci10ZGVzIGZhaWxlZCAocmM9LTIyKQ0KPiAgICAgIDIwMjUtMDMtMTIgMTA6MTA6NDIs
NzA3OiBbICAgIDIuMjA3ODk0XSBhbGc6IHNlbGYtdGVzdHMgZm9yDQo+IGN0cihkZXMzX2VkZSkg
dXNpbmcgYXNwZWVkLWN0ci10ZGVzIGZhaWxlZCAocmM9LTIyKQ0KPiAgICAgIDIwMjUtMDMtMTIg
MTA6MTA6NDIsNzI1OiBbICAgIDIuMjE5MzQyXSBhbGc6IHNrY2lwaGVyOiBhc3BlZWQtY3RyLWRl
cw0KPiBlbmNyeXB0aW9uIHRlc3QgZmFpbGVkICh3cm9uZyByZXN1bHQpIG9uIHRlc3QgdmVjdG9y
IDAsIGNmZz0iaW4tcGxhY2UgKG9uZSBzZ2xpc3QpIg0KPiAgICAgIDIwMjUtMDMtMTIgMTA6MTA6
NDIsNzI1OiBbICAgIDIuMjE5NTExXSBhbGc6IHNlbGYtdGVzdHMgZm9yIGN0cihkZXMpDQo+IHVz
aW5nIGFzcGVlZC1jdHItZGVzIGZhaWxlZCAocmM9LTIyKQ0KPiAgICAgIDIwMjUtMDMtMTIgMTA6
MTA6NDIsNzI1OiBbICAgIDIuMjE5NjUxXSBhbGc6IHNlbGYtdGVzdHMgZm9yIGN0cihkZXMpDQo+
IHVzaW5nIGFzcGVlZC1jdHItZGVzIGZhaWxlZCAocmM9LTIyKQ0KPiAgICAgIDIwMjUtMDMtMTIg
MTA6MTA6NDIsNzMzOiBbICAgIDIuMjI0MzQ0XSBhbGc6IHNrY2lwaGVyOiBhc3BlZWQtY3RyLWFl
cw0KPiBlbmNyeXB0aW9uIHRlc3QgZmFpbGVkICh3cm9uZyByZXN1bHQpIG9uIHRlc3QgdmVjdG9y
IDAsIGNmZz0iaW4tcGxhY2UgKG9uZSBzZ2xpc3QpIg0KPiAgICAgIDIwMjUtMDMtMTIgMTA6MTA6
NDIsNzM0OiBbICAgIDIuMjI0Nzc1XSBhbGc6IHNlbGYtdGVzdHMgZm9yIGN0cihhZXMpDQo+IHVz
aW5nIGFzcGVlZC1jdHItYWVzIGZhaWxlZCAocmM9LTIyKQ0KPiAgICAgIDIwMjUtMDMtMTIgMTA6
MTA6NDIsNzM0OiBbICAgIDIuMjI1MDE1XSBhbGc6IHNlbGYtdGVzdHMgZm9yIGN0cihhZXMpDQo+
IHVzaW5nIGFzcGVlZC1jdHItYWVzIGZhaWxlZCAocmM9LTIyKQ0KPiAgICAgIC4uLg0KPiANCj4g
V2hhdCBpcyBzb21ldGhpbmcgbWlzc2luZyBpbiB0aGUgbW9kZWxzID8NCj4gDQoNCkN1cnJlbnRs
eSwgd2UgZG8gbm90IGltcGxlbWVudCBIQUNFL0NSWVBUIGluIGFzcGVlZF9oYWNlLmMuIA0KaHR0
cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L3FlbXUtZGV2ZWwvcGF0Y2gvMjAyNTAy
MjUwNzU2MjIuMzA1NTE1LTUtamFtaW5fbGluQGFzcGVlZHRlY2guY29tLw0KDQpLbm93biBJc3N1
ZToNClRoZSBIQUNFIGNyeXB0byBhbmQgaGFzaCBlbmdpbmUgaXMgZW5hYmxlIGJ5IGRlZmF1bHQg
c2luY2UgQVNUMjcwMCBBMS4NCkhvd2V2ZXIsIGFzcGVlZF9oYWNlLmMoSEFDRSBtb2RlbCkgY3Vy
cmVudGx5IGRvZXMgbm90IHN1cHBvcnQgdGhlIENSWVBUTyBjb21tYW5kLg0KVG8gYm9vdCBBU1Qy
NzAwIEExLCBjcmVhdGVkIGEgcGF0Y2ggd2hpY2ggdGVtcG9yYXJpbHkgcmVzb2x2ZXMgdGhlDQpp
c3N1ZSBieSBzZW5kaW5nIGFuIGludGVycnVwdCB0byBub3RpZnkgdGhlIGZpcm13YXJlIHRoYXQg
dGhlIGNyeXB0b2dyYXBoaWMNCmNvbW1hbmQgaGFzIGNvbXBsZXRlZC4gSXQgaXMgYSB0ZW1wb3Jh
cnkgd29ya2Fyb3VuZCB0byByZXNvbHZlIHRoZSBib290IGlzc3VlDQppbiB0aGUgQ3J5cHRvIE1h
bmFnZXIgU2VsZlRlc3QuDQoNCkFzIGEgcmVzdWx0LCB5b3Ugd2lsbCBlbmNvdW50ZXIgdGhlIGZv
bGxvd2luZyBrZXJuZWwgd2FybmluZyBkdWUgdG8gdGhlDQpDcnlwdG8gTWFuYWdlciB0ZXN0IGZh
aWx1cmUuDQoNCmBgYA0KYWxnOiBza2NpcGhlcjogYXNwZWVkLWN0ci10ZGVzIGVuY3J5cHRpb24g
dGVzdCBmYWlsZWQgKHdyb25nIHJlc3VsdCkgb24gdGVzdCB2ZWN0b3IgMCwgY2ZnPSJpbi1wbGFj
ZSAob25lIHNnbGlzdCkiDQpbICAgIDUuMDM1OTY2XSBhbGc6IHNlbGYtdGVzdHMgZm9yIGN0cihk
ZXMzX2VkZSkgdXNpbmcgYXNwZWVkLWN0ci10ZGVzIGZhaWxlZCAocmM9LTIyKQ0KWyAgICA1LjAz
NjEzOV0gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tDQpbICAgIDUuMDM3MTg4
XSBhbGc6IHNlbGYtdGVzdHMgZm9yIGN0cihkZXMzX2VkZSkgdXNpbmcgYXNwZWVkLWN0ci10ZGVz
IGZhaWxlZCAocmM9LTIyKQ0KWyAgICA1LjAzNzMxMl0gV0FSTklORzogQ1BVOiAyIFBJRDogMTA5
IGF0IC9jcnlwdG8vdGVzdG1nci5jOjU5MzYgYWxnX3Rlc3QrMHg0MmMvMHg1NDgNClsgICAgNS4w
MzgwNDldIE1vZHVsZXMgbGlua2VkIGluOg0KWyAgICA1LjAzODMwMl0gQ1BVOiAyIFBJRDogMTA5
IENvbW06IGNyeXB0b21ncl90ZXN0IFRhaW50ZWQ6IEcgICAgICAgIFcgICAgICAgICAgNi42LjUy
LXYwMC4wNi4wNC1nZjUyYTBjZjdjNDc1ICMxDQpbICAgIDUuMDM4Nzg3XSBIYXJkd2FyZSBuYW1l
OiBBU1QyNzAwLUVWQiAoRFQpDQpbICAgIDUuMDM4OTg4XSBwc3RhdGU6IDYwMDAwMDA1IChuWkN2
IGRhaWYgLVBBTiAtVUFPIC1UQ08gLURJVCAtU1NCUyBCVFlQRT0tLSkNClsgICAgNS4wMzkzMTVd
IHBjIDogYWxnX3Rlc3QrMHg0MmMvMHg1NDgNClsgICAgNS4wMzk1MDVdIGxyIDogYWxnX3Rlc3Qr
MHg0MmMvMHg1NDgNClsgICAgNS4wMzk2OTddIHNwIDogZmZmZmZmYzA4MjVlM2Q1MA0KWyAgICA1
LjAzOTg2Ml0geDI5OiBmZmZmZmZjMDgyNWUzZGYwIHgyODogMDAwMDAwMDAwMDAwMDAwNCB4Mjc6
IDAwMDAwMDAwMDAwMDAwMDANClsgICAgNS4wNDAyMjZdIHgyNjogZmZmZmZmYzA4MGJjYWRhMCB4
MjU6IGZmZmZmZmMwODFkYWM5ZDAgeDI0OiAwMDAwMDAwMDAwMDAwMDA0DQpbICAgIDUuMDQwNzAw
XSB4MjM6IDAwMDAwMDAwMDAwMDEyODUgeDIyOiBmZmZmZmY4MDAzZGVkMjgwIHgyMTogZmZmZmZm
ODAwM2RlZDIwMA0KWyAgICA1LjA0MTQ1OF0geDIwOiAwMDAwMDAwMGZmZmZmZmZmIHgxOTogMDAw
MDAwMDBmZmZmZmZlYSB4MTg6IGZmZmZmZmZmZmZmZmZmZmYNClsgICAgNS4wNDE5MTVdIHgxNzog
MjgyMDY0NjU2YzY5NjE2NiB4MTY6IDIwNzM2NTY0NzQyZDcyNzQgeDE1OiAwMDAwMDAwMGZmZmZm
ZmZlDQpbICAgIDUuMDQyMjg3XSB4MTQ6IDAwMDAwMDAwMDAwMDAwMDAgeDEzOiBmZmZmZmZjMDgx
YmE1NTVjIHgxMjogNjU3NDJkNjY2YzY1NzMyMA0KWyAgICA1LjA0MjY4NF0geDExOiAwMDAwMDAw
MGZmZmVmZmZmIHgxMDogZmZmZmZmYzA4MThmZjA0OCB4OSA6IGZmZmZmZmMwODAwYTM2ZTQNClsg
ICAgNS4wNDMwNzddIHg4IDogMDAwMDAwMDAwMDE3ZmZlOCB4NyA6IGMwMDAwMDAwZmZmZWZmZmYg
eDYgOiAwMDAwMDAwMDAwNTdmZmE4DQpbICAgIDUuMDQzNDYxXSB4NSA6IDAwMDAwMDAwMDAwMGZm
ZmYgeDQgOiAwMDAwMDAwMDAwMDAwMDAwIHgzIDogMDAwMDAwMDAwMDAwMDAwMA0KWyAgICA1LjA0
Mzc1MV0geDIgOiAwMDAwMDAwMDAwMDAwMDAwIHgxIDogMDAwMDAwMDAwMDAwMDAwMCB4MCA6IGZm
ZmZmZjgwMDQxNWU3NDANClsgICAgNS4wNDU1NDRdIENhbGwgdHJhY2U6DQpbICAgIDUuMDQ1Njkz
XSAgYWxnX3Rlc3QrMHg0MmMvMHg1NDgNClsgICAgNS4wNDU4NzhdICBjcnlwdG9tZ3JfdGVzdCsw
eDI4LzB4NDgNClsgICAgNS4wNDYwNTJdICBrdGhyZWFkKzB4MTE0LzB4MTIwDQpbICAgIDUuMDQ2
MjI2XSAgcmV0X2Zyb21fZm9yaysweDEwLzB4MjANClsgICAgNS4wNDY0MTNdIC0tLVsgZW5kIHRy
YWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0KWyAgICA1LjA3MTUxMF0gYWxnOiBza2NpcGhlcjog
YXNwZWVkLWN0ci1kZXMgZW5jcnlwdGlvbiB0ZXN0IGZhaWxlZCAod3JvbmcgcmVzdWx0KSBvbiB0
ZXN0IHZlY3RvciAwLCBjZmc9ImluLXBsYWNlIChvbmUgc2dsaXN0KSINClsgICAgNS4wNzIxNDVd
IGFsZzogc2VsZi10ZXN0cyBmb3IgY3RyKGRlcykgdXNpbmcgYXNwZWVkLWN0ci1kZXMgZmFpbGVk
IChyYz0tMjIpDQpgYGANCg0KVGhhbmtzLUphbWluDQoNCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4g
DQoNCg==

