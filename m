Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179FFC83F34
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 10:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ue9qW-0004VV-L7; Tue, 22 Jul 2025 06:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1ue9qU-0004Op-1u; Tue, 22 Jul 2025 06:03:38 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1ue9qR-000611-FT; Tue, 22 Jul 2025 06:03:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vndmuc6iRjzBzTaVJ7YAJUY1lwna9Ge0Dvjma4AJv2sVE1ERvGp512n82GJ0ozOieyO5l2A+HAI4tqaqzdKUBLfATId2FlUtcUluxtrI20DlXxsV2U636MksZhQnEAx8cDMRC1NT7IUYbWVGrVWM2e5L2V2ztYqbNpuaGeIvjqq5ylRfA/p1kX37tKwpTdOUIfun4X2pYOPpe0i3zmvi7xIoO8CeUopzan42u7XXdigH7zNCu/R/mZU0ktSc4n6aUxqtAVmL2gHgbb38EbiFEVglU3u/9OsrIfS8KwtLxoOZDBUg7vHBB6CUoH7rCSk9ar6A7fubGcmZYvD1YL2jWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeFW+NreOg78W6zsDmzSnnlKNtyqLAv7e+JL1C9ta9w=;
 b=B8T8ybj3AabLyBMjeK2yaNGiXX7d5KNJxxu479w1V9HPsfeG86WdEpRhIs4hQ2IH3HwsxYga3YK+bI5WJ8i5cG5dYHrOQktIr2e2OYA8klHA+0GaJP0y+gBkVtM0JPftk6BGrumNrhWnjU6Pl9EjaWuQ14F1B2HV4tRC/MxgawqMOpDygt6gMze1wCR3VIIUb471p+QiojUu7UamJGBv1UAtj+9PQSk9MQ0KMjcsHnXD1zO8LzXF4gshi019YM4HZoR1zR5grMwpqA7jN0OMXBy+mnWewTSvvF1LDIxCBgztRyw0Fc/4Inqt6/JcXhJtfZ2WTx2kdermtVr/b/WyAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeFW+NreOg78W6zsDmzSnnlKNtyqLAv7e+JL1C9ta9w=;
 b=f1LTzcM99u/UKHsg+SStX4q2BwSJ+Xq7X9iUuvSzVhNAR20fjNFszIO758k/DLkW2CiAATyyGn1+gim8b+2eJwmTFberUMS6tX/HezVkU85QngQGqFh7iyyQVNAwpCS5kUUC+jZAS62zHGj6ii6H6gJhb5zDB0DT1EOc9iIKDqqgSksNdKaJQLwQgRaFOd+Ytk4upXKrx3adxBkdCPvTMSC+9xSvydkDnXM7iOb3Q0QRTPnkFKi0VA+arwGgqR91S3WDFpfg1ZoRxcmQLcL0uMiBhEz4NjIK6+KoYVHi6zpge2IyO/IntNZxsce5NaD9OhmVmmEA8rr00DNkSzNkwg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SEYPR06MB6662.apcprd06.prod.outlook.com (2603:1096:101:176::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 10:03:27 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 10:03:27 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [SPAM] [PATCH v4 0/5] ASPEED OTP QEMU model: block backend,
 machine alias, SoC integration
Thread-Topic: [SPAM] [PATCH v4 0/5] ASPEED OTP QEMU model: block backend,
 machine alias, SoC integration
Thread-Index: AQHb781MUcZZn3YsUkOaaZXHCW7tY7Q9+f6AgAAE9MA=
Date: Tue, 22 Jul 2025 10:03:27 +0000
Message-ID: <SI6PR06MB763195F75B1BC99F175103B9F75CA@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20250708055810.2868680-1-kane_chen@aspeedtech.com>
 <200bd9bb-d33d-4f42-bb65-251048e8301e@kaod.org>
In-Reply-To: <200bd9bb-d33d-4f42-bb65-251048e8301e@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SEYPR06MB6662:EE_
x-ms-office365-filtering-correlation-id: 1e17441d-876e-4ffd-03cf-08ddc90700bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?VlM4aXJlUFV5ZVhDSGE4SFFmdk52NzBYUHEwdzBSNlc5VHErTGdXVGpxNWV0?=
 =?utf-8?B?d3RVRExXSHRmdHFweDFjQzhSNnhOa3ZLUmhaR05QZzh4bDFCakJQSXVXNU5H?=
 =?utf-8?B?QkY1YTRZcmRCQzY1ejNISnowaVZzY3MrcVdzK3g1YVA2eHVRNHZ6M3FsWkI3?=
 =?utf-8?B?Nk9EQVdBdm45VGFRM0tCVjB5cmpMelk2dHUyZmt5aG5iTkVGakZyd2dBWnVi?=
 =?utf-8?B?Wnd5Mk5FT3Bsb3ppSllibXl1dnhHY05sUjl6ZnZYRlczZWVQQ3lvK1lYcjhP?=
 =?utf-8?B?b2ltVlBYOFJxVTJ2aVQrMG5hOUUzRk5TbGszTUVLVFJLSTdHWjFwamVpL0d0?=
 =?utf-8?B?R0t3OTU4ZGZxSVZBdE83R3Y4TWVBVGcrcjZGUFFwQ3ZJNkdmS1ZKZ3ZtdTRF?=
 =?utf-8?B?ZXAxSXFZRHFMcjVtZ1gzR25ndWNQeFU2L2J4S2tPUmFpZEdQVGp0Nko5bDNM?=
 =?utf-8?B?WmpnNk5mb2RucWltY2RhQVBlbDJMOFVvZnVJQnp4cEQxQW5teUlDSHYwMnFa?=
 =?utf-8?B?ZjhrZGwwZUgydC9lQnQyeVU2RXYrWklEYU4yUmRka002aU5IVnBTeXhocUl6?=
 =?utf-8?B?ZUMxeEs4THVBODU3MFhSb2g2bE9uVjkxdnc1QUxhTk9DNHhTUzVYSlVxQkdD?=
 =?utf-8?B?ZEJLRnpPb3RvZUR3ekJpVGhTR24zUTZrd08rbGZTZjEvQVFpcTNlaDFwNGcr?=
 =?utf-8?B?bHRRbTJvUWhsYmJXTE1xY09yNXJVY1Z6MXRLYmNNSjQ3WEZuTDFGOXk1VUl2?=
 =?utf-8?B?b2VVdFVxMHlhb3BPdzdwcE5aVVdvZzhXcyt2d0k2SytKLy9XYlkzU2VZTm5L?=
 =?utf-8?B?S3lTRlliNEZvaUFMUURaR1FNVDBYT05uNGkrUEpodUlEc1BjMFZXMGJQeVRl?=
 =?utf-8?B?RSswcEhlMXhjd0dBdEJxNXllbkNsSjhUSUk2R2w1NWdhVGNocmRvMUYwSm1S?=
 =?utf-8?B?OHEyVmIrS0Q2SkVRWUxCNmx5akRZa0dLUWJ2bzVhLzRLZEl1eFVIdE1NMDIw?=
 =?utf-8?B?ZjdhRGpHTmhoM200cWZmVTBjMnEzUXJWLzMvQmo1MFh4YnB5QWpIVmNDdHht?=
 =?utf-8?B?MUtRY2RjMjRBL0ZCc3VzWGp5SjJXY05ZTlNydkJscUhxbW5jVGx6TWRsQlgx?=
 =?utf-8?B?ZksxbXp3STZKY1F0eUpvVEFGdGx1Y1lQVkV1MmQ0UHFZcnArRWFCcUlDYW9H?=
 =?utf-8?B?N0hmWmVRNTNaTndESEFJMmc4eTBYa3NuMGYyZjI4Rkx2ZjFvdFoveDhSVXdR?=
 =?utf-8?B?Y0ZJQVlZOEpzVHFWbDlSek9KZ09JYlBCYW9URWZCVTM2OUE1Rm5mWk1NcGk0?=
 =?utf-8?B?dGs3VXVNbkNQRHRpc25HY2JmOVV2MllPa1hoVHRRSW5adkEzVU1xWHpoUTl0?=
 =?utf-8?B?NEhheWFFTlJMaUwrTzVac25MeFFwMVpOT0hrMFUyTi83UFgzYytVQmJZMU1K?=
 =?utf-8?B?K3VIZ0JCRklyL1Rxall6SGVHeTJ1K2FlN2dCdkMreUdRR2piUUUwTE5abGNU?=
 =?utf-8?B?Ukp0UVNVdlM0ZHp4Y0tMdGJZWDQ4ZGs3aWNwNzhmZlRYTThxcE1ub29nOGJi?=
 =?utf-8?B?VFY0aCsvYS9XcDl5eXY4QVFNdUVyTngvTVV1azFyZUtDNkYvS2o3ZGVPaWsw?=
 =?utf-8?B?c2NpNXNMZS9oL2N5b0wra0dkSGpWOE9CSElwbkErTDFUaGNlVzF0dU1ocWk2?=
 =?utf-8?B?aXZGRFBDbHVVYnNsY0Jyd2dwZVF3amFiQklqQ0w0RTJmMnd5ZGQ5YTBzRE1C?=
 =?utf-8?B?SkRpM1dJeXJ5ZUVlRXA3SUtGc1VhTU14Y3p2WmZWNTM2d1BraklNZHFhcHA1?=
 =?utf-8?B?MVdnb0tlQUd3N1NGV2VuK3dnalE2RlJrWjdxbmhRVWE5dzNGem5pNUYrYWk5?=
 =?utf-8?B?WmR3Tm5YUzVGOFhXUkFublZqcks3YkdpSmVJYWdkOURGRThCTWRDclB0N3Bw?=
 =?utf-8?B?cHljYi9RbkdOTndIS3ZhNUZ1ZkpDTEFlbEQ1dzhrandveVlZSElaZ0dIK3Fu?=
 =?utf-8?B?TUZYdDJ5aGFmdmlKbHJKQ2IwTmxaY1FDRjZsamxDRE11bzl5WUU1WFZUQVEy?=
 =?utf-8?Q?q9uMQA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3BWenBmWWhRMzVaNUZLODlobkRWVU1yZ1ZVaUpSN2ZuUldNSVpjTno2Znl5?=
 =?utf-8?B?ZGxjc3lMUXJ1elFnYkxaMDVnREZFeTRURW1aeDIxNjh1SlQ1eWtvYkxObWFn?=
 =?utf-8?B?RGZ6QXhaVEhQM1ptZlVrOEpGZDJIcnpmWlN0T2JwOU1UUlJFWFdZckVXQlkz?=
 =?utf-8?B?bzNqM2ZXTkUzK3NDTU1waHVmTWd2bCtSQWxWaDljRnFERFpSU3lxem83Njlz?=
 =?utf-8?B?QmhvSFMxSkpKRDZ4bDlpVWF5VHpIVi9NUlQ4MGxqbnpNaVZVYWwwYnhZMVd5?=
 =?utf-8?B?dHcyTW1FUGkwNGhCTWtsblN1T1puTGhzYnZxcE5hTE9GMHpoSzZ2V05jRExN?=
 =?utf-8?B?SGErYWMxNDFmelV2cmM4WjJ6WEdzZ3BTZlhjVDhnWmk3eElJYVhZQ0VrQUUx?=
 =?utf-8?B?dW1Tc0R2L0p0Sk1oZkNVR1grRmkrTDVqSy8wZzRuWjZoQnkvSXJnSWQ5S1Yr?=
 =?utf-8?B?ZkYyT3NVanBYVGZ1cDFibjBiN0djNnhQaHZuQkNzcmpIV2N1cDY0b1VzK1Q0?=
 =?utf-8?B?bjlOMkQ3eGNZR3Fpc3h6bWJvSHAwTzZKSW1Gdzc1dU9HWFdUWjljUE1YeTJz?=
 =?utf-8?B?WTBSdnU4M2YxMkxIM3AzZEVZd1FzenUramIzQkFuZXUwSWQrTStWR2VXNTk3?=
 =?utf-8?B?STN3UnViaVhycUR0VCtsNmVMN0lMUDhhbG01b0pubS9WOU1TdXRaTFJTSFFa?=
 =?utf-8?B?dkcvQVdoRUFCWXp3RzBETmpRZjBDOGs5LzZoQTZob3NiYkkwa0NJcSt6OXhR?=
 =?utf-8?B?VUgrSzhUWSs4NFNaOWpHNUNvSndJdmpQampsdFVEcTlRQXVUdW45citmSWlo?=
 =?utf-8?B?N1IvODNWK2tTQXBhaVpQRWE0K2tCZDJpWjVYQkhSTURLV0tSZEhHRjdYTEU4?=
 =?utf-8?B?UVpHSDJla2h2YjVFZFNqdjBndk1aaVljVWZ3cXlTRDM2NURYTHovcXRsUzdh?=
 =?utf-8?B?Y21rMnRGUUZzL1ZaQmhaMDZmUk9pckVJSXI1d2pKT0ZUMFcxQ2RhM09FblNt?=
 =?utf-8?B?REZaMnpqOUNTVkJuTTlaVGZLRUFqZU1UQ1dXTExET3k1U0xmN2ZlTCs0Q2Fi?=
 =?utf-8?B?a0g3SUkzNzRjNzlFem81cTdnQ29MaENmTTZ1OTA2NExueFp1T29UUE9aZ044?=
 =?utf-8?B?SVpac1RxMVE4NThmOFJ1K1lBQjJhVjM3bUlyTVMvNnp6TkZSYUw1VTFPWFgr?=
 =?utf-8?B?SFplRjFscTdLUExhV0ZjWVQ4dmNUN3VzTHBRejdRY1FaOHJtUWxhbnpKT1Bj?=
 =?utf-8?B?amErcEF0NWpMcTJoK0ZBZld1R1NOcTkySFVJY2hER1ZyQ3B4QUxNV085aW84?=
 =?utf-8?B?Z3dPNVdtdnozam53YmJ4dmt4Sk1uZU5Ja0w3RUtBWVNDOEx5RlJxdUQyQUtN?=
 =?utf-8?B?VFVaQkNvSHpWWGtISE9UdmhrdFE1T2F0SWNzNW53Tmh0QW5VOGJ2dUhGaC80?=
 =?utf-8?B?Wld4T3ZxQ0NFZXFTYVp5cDZCQ1dHdVBBR3ZCZUxRMHJJYkVzMFBQQjhHTEtG?=
 =?utf-8?B?eXgwSVE2ZjB1RURJdUFsSFdUaUswOWoybmFMNlBOelFianNiWDVqeVVGTU1P?=
 =?utf-8?B?SlI3MDNNb1lEZ045QjkzeFloRGJsMzlBWE03eUxEQk1pOFYwVWg2b3o1VElV?=
 =?utf-8?B?QmxSZjk0OUxvaktaYVdPQmdTZkE0QVdwdHVjMklqVVlWVEhobUJxclJFZDhH?=
 =?utf-8?B?RDVoVDhwWmsrOXRaK29tZW9xd0JZcXFTNWczdkJCTHNTcnpTc0psdTMvaE5R?=
 =?utf-8?B?Qm5MWVFKZUVXaU0rdVRWaDRwZnY2aEVhenRFTTU2Tm5sZzVSSzlyaVFXeDJZ?=
 =?utf-8?B?U3RobnhGS25UYWZXK0ppaVQxdy9uRkNaajdYc3A3WW9sYTRZM3Q0cmFUNi9W?=
 =?utf-8?B?dTJvR2crMFhaaHR1bC9jbnNTSHRyZDRvd2VCVG1BWmNuc2V3anRaUHdjc25I?=
 =?utf-8?B?NVNCd2pjdkw1REdJNDNoYWZMYjYyNi9TczBXUU94Y3l2ZHF5bkRVN2VNOXF2?=
 =?utf-8?B?TExpMXB6WG1FNmJ4TkI3Y2QwN2k4L21xY2pFM0hEb3k3eDJJZmRvN2pNa0dn?=
 =?utf-8?B?YnYvTHpQZzJVbWNwbGphalpqRVB6WnREV0dKcU5ubTk2S0V1VUZZcTBQUURx?=
 =?utf-8?Q?faSD0HMvIchlJ3+A8tPTEy70P?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e17441d-876e-4ffd-03cf-08ddc90700bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 10:03:27.0412 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A2FZXS/gIbRBdLsExIijqCTOX7plLOUiC7MfnNzb5ZWhZj7vUSZP7pcF97viBl5O1/5tnntqaDwnVTZAUtWCda/NZcMhh7TzUpJXrVVDAlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6662
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYywNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCg0KSSB3aWxsIGRyb3AgcGF0
Y2ggNSBhbmQgaW5jbHVkZSBhIGRvY3VtZW50YXRpb24gdXBkYXRlIGluIHRoZSBuZXh0IHZlcnNp
b24uDQoNCkJlc3QgUmVnYXJkcywNCkthbmUNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz4NCj4gU2VudDogVHVlc2Rh
eSwgSnVseSAyMiwgMjAyNSA1OjQxIFBNDQo+IFRvOiBLYW5lIENoZW4gPGthbmVfY2hlbkBhc3Bl
ZWR0ZWNoLmNvbT47IFBldGVyIE1heWRlbGwNCj4gPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47
IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+OyBUcm95DQo+IExlZSA8bGVl
dHJveUBnbWFpbC5jb20+OyBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IEFu
ZHJldw0KPiBKZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBKb2VsIFN0YW5s
ZXkgPGpvZWxAam1zLmlkLmF1PjsNCj4gb3BlbiBsaXN0OkFTUEVFRCBCTUNzIDxxZW11LWFybUBu
b25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVzIENDDQo+IGhlcmUgPHFlbXUtZGV2ZWxA
bm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT4NCj4g
U3ViamVjdDogUmU6IFtTUEFNXSBbUEFUQ0ggdjQgMC81XSBBU1BFRUQgT1RQIFFFTVUgbW9kZWw6
IGJsb2NrIGJhY2tlbmQsDQo+IG1hY2hpbmUgYWxpYXMsIFNvQyBpbnRlZ3JhdGlvbg0KPiANCj4g
T24gNy84LzI1IDA3OjU3LCBLYW5lIENoZW4gd3JvdGU6DQo+ID4gRnJvbTogS2FuZS1DaGVuLUFT
IDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+ID4NCj4gPiBUaGlzIHBhdGNoIHNlcmllcyBl
eHRlbmRzIHRoZSBRRU1VIG1vZGVsIGZvciB0aGUgQVNQRUVEIE9UUCAoT25lLVRpbWUNCj4gPiBQ
cm9ncmFtbWFibGUpIG1lbW9yeSBkZXZpY2Ugd2l0aCBibG9jayBiYWNrZW5kIHN1cHBvcnQgYW5k
IHRpZ2h0ZXINCj4gPiBpbnRlZ3JhdGlvbiB3aXRoIHRoZSBTb0MgYW5kIG1hY2hpbmUgY29uZmln
dXJhdGlvbi4NCj4gPg0KPiA+IFRoZSBPVFAgbW9kZWwgc2ltdWxhdGVzIGEgc2ltcGxlIGZ1c2Ug
YXJyYXksIHVzZWQgaW4gQVNQRUVEIFNvQ3MgZm9yDQo+ID4gc2VjdXJlIGJvb3QgYW5kIGNvbmZp
Z3VyYXRpb24gcHVycG9zZXMuIFRoZSB1cGRhdGVkIG1vZGVsIG5vdyBzdXBwb3J0cw0KPiA+IGxv
YWRpbmcgaW5pdGlhbCBPVFAgY29udGVudCBmcm9tIGEgZmlsZSB2aWEgdGhlIFFFTVUgQ0xJLg0K
PiA+DQo+ID4gRXhhbXBsZSB1c2FnZToNCj4gPiAgICAuL3FlbXUtc3lzdGVtLWFybSBcDQo+ID4g
ICAgICAtbWFjaGluZSBhc3QyNjAwLWV2YixvdHBtZW09b3RwIFwNCj4gPiAgICAgIC1ibG9ja2Rl
diBkcml2ZXI9ZmlsZSxmaWxlbmFtZT1vdHBtZW0uaW1nLG5vZGUtbmFtZT1vdHAgXA0KPiA+ICAg
ICAgLWdsb2JhbCBhc3BlZWQtb3RwLmRyaXZlPW90cCBcDQo+ID4gICAgICAuLi4NCj4gPg0KPiA+
IENoYW5nZUxvZw0KPiA+IC0tLS0tLS0tLQ0KPiA+IHY0Og0KPiA+IC0gQWRkIGEgJ2RyaXZlJyBw
cm9wZXJ0eSB0byBhbGxvdyBiYWNraW5nIE9UUCBkYXRhIHdpdGggYSBibG9jayBkZXZpY2UNCj4g
PiAtIEV4cG9zZSBhIG1hY2hpbmUgcGFyYW1ldGVyIChgLW1hY2hpbmUgb3RwbWVtPVhYWGApIGZv
ciBjb252ZW5pZW50DQo+ID4gICAgYWxpYXNpbmcgb2YgdGhlIE9UUCBkcml2ZSB2aWEgUU9NIHBh
dGgNCj4gDQo+IA0KPiBQYXRjaCAxLTQgYXJlIGZpbmUuIFBhdGNoIDUgaXMgdG9vIGNvbXBsZXgg
dG8gYWRkcmVzcyBhbmQgaXRzIHZhbHVlIGlzIGxpbWl0ZWQgYXMNCj4gZXhwbGFpbmVkLg0KPiAN
Cj4gQ291bGQgeW91IHBsZWFzZSBzZW5kIGEgZG9jdW1lbnRhdGlvbiB1cGRhdGUgOg0KPiANCj4g
DQo+IGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2plY3QvcWVtdS8tL2Jsb2IvbWFzdGVyL2Rv
Y3Mvc3lzdGVtL2FybS9hc3ANCj4gZWVkLnJzdCA/DQo+IA0KPiBBbiBleHRyYSBzZWN0aW9uIGFm
dGVyICJPdGhlciBib290aW5nIG9wdGlvbnMiIGV4cGxhaW5pbmcgdGhlIE9UUCBiYWNrZW5kIGZv
cg0KPiB0aGUgQVNUMjYwMCBTb0Mgd291bGQgYmUgd2VsY29tZS4NCj4gDQo+IFBsZWFzZSBtYWtl
IHN1cmUgIC0tZW5hYmxlLWRvY3MgaXMgY29uZmlndXJlZC4NCj4gDQo+IFRoYW5rcywNCj4gDQo+
IEMuDQo+IA0KPiANCj4gDQo+IA0KPiA+DQo+ID4gdjM6DQo+ID4gLSBTd2l0Y2hlZCB0byBvYmpl
Y3RfcHJvcGVydHlfc2V0X2ludCgpIGZvciBzZXR0aW5nICJzaXplIg0KPiA+IC0gU2ltcGxpZmll
ZCBxZGV2X3JlYWxpemUoKSBlcnJvciBoYW5kbGluZyBieSBwYXNzaW5nIGVycnAgZGlyZWN0bHkN
Cj4gPiAtIEFkZGVkICJkcml2ZSIgcHJvcGVydHkgdG8gT1RQIG1vZGVsIGZvciBmdXR1cmUgZXh0
ZW5zaWJpbGl0eQ0KPiA+DQo+ID4gdjI6DQo+ID4gLSBSZW5hbWUgZGV2aWNlIGZyb20gJ2FzcGVl
ZF9vdHBtZW0nIHRvICdhc3BlZWRfb3RwJyBhbmQgbW92ZSBpdCB0bw0KPiA+IGh3L252cmFtLw0K
PiA+IC0gTW92ZSBPVFAgZGV2aWNlIHJlYWxpemF0aW9uIGZyb20gaW5zdGFuY2VfaW5pdCB0byB0
aGUgcmVhbGl6ZQ0KPiA+IGZ1bmN0aW9uDQo+ID4gLSBJbXByb3ZlIGVycm9yIGxvZ2dpbmcgd2l0
aCBxZW11X2xvZ19tYXNrKCkgYW5kIHJlbW92ZSB1bnVzZWQgZXJyb3INCj4gPiBwcm9wYWdhdGlv
bg0KPiA+DQo+ID4gdjE6DQo+ID4gLSBJbml0aWFsIHZlcnNpb24NCj4gPg0KPiA+IC0tLQ0KPiA+
DQo+ID4gS2FuZS1DaGVuLUFTICg1KToNCj4gPiAgICBody9taXNjL2FzcGVlZF9vdHA6IEFkZCBB
U1BFRUQgT1RQIG1lbW9yeSBkZXZpY2UgbW9kZWwNCj4gPiAgICBody9taXNjL2FzcGVlZF9zYmM6
IENvbm5lY3QgQVNQRUVEIE9UUCBtZW1vcnkgZGV2aWNlIHRvIFNCQw0KPiA+ICAgIGh3L2FybTog
SW50ZWdyYXRlIEFTUEVFRCBPVFAgbWVtb3J5IHN1cHBvcnQgaW50byBBU1QyNjAwIFNvQ3MNCj4g
PiAgICBody9taXNjL2FzcGVlZF9vdHA6IEFkZCAnZHJpdmUnIHByb3BlcnR5IHRvIHN1cHBvcnQg
YmxvY2sgYmFja2VuZA0KPiA+ICAgIGh3L21pc2MvYXNwZWVkX3NiYzogQWRkIG1hY2hpbmUgcGFy
YW1ldGVyIHRvIGFsaWFzIE9UUCBkcml2ZQ0KPiA+IHByb3BlcnR5DQo+ID4NCj4gPiAgIGluY2x1
ZGUvaHcvbWlzYy9hc3BlZWRfc2JjLmggIHwgICA1ICsrDQo+ID4gICBpbmNsdWRlL2h3L252cmFt
L2FzcGVlZF9vdHAuaCB8ICAzMyArKysrKysrKysrDQo+ID4gICBody9hcm0vYXNwZWVkLmMgICAg
ICAgICAgICAgICB8ICAyMCArKysrKysNCj4gPiAgIGh3L2FybS9hc3BlZWRfYXN0MjYwMC5jICAg
ICAgIHwgICAyICstDQo+ID4gICBody9taXNjL2FzcGVlZF9zYmMuYyAgICAgICAgICB8IDEyMQ0K
PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICBody9udnJhbS9hc3Bl
ZWRfb3RwLmMgICAgICAgICB8IDExMw0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ID4gICBody9taXNjL3RyYWNlLWV2ZW50cyAgICAgICAgICB8ICAgNSArKw0KPiA+ICAgaHcv
bnZyYW0vbWVzb24uYnVpbGQgICAgICAgICAgfCAgIDQgKysNCj4gPiAgIDggZmlsZXMgY2hhbmdl
ZCwgMzAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiAgIGNyZWF0ZSBtb2RlIDEw
MDY0NCBpbmNsdWRlL2h3L252cmFtL2FzcGVlZF9vdHAuaA0KPiA+ICAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGh3L252cmFtL2FzcGVlZF9vdHAuYw0KPiA+DQoNCg==

