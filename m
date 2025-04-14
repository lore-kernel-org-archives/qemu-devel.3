Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B0BC3601E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 01:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u48Zh-0003rR-H8; Sun, 13 Apr 2025 21:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u48Zb-0003qa-33; Sun, 13 Apr 2025 21:25:19 -0400
Received: from mail-psaapc01on2108.outbound.protection.outlook.com
 ([40.107.255.108] helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u48ZZ-00033j-8W; Sun, 13 Apr 2025 21:25:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpjfyH1Sc+jfn/H8iIzjaU3HfAwIky0svRvwefquWaNhbk0D75JOhHMr8IOI3GhtQknWqD/fIeBOgIgv5w5W2hWed0PkXp+fzkWJizfSsDaZ7677zUfmQo4ydxsi98bwbwfikUWPBRTXTe8D3eaS7y41dATzNfNn+8hUV6kw8mXC92uJ2nGC0vGZ2FlavxUJybjj8oJ8y70x4Pqu7uRivlt3B7ha2SIAimyGVsF7gAaajADIi2Qc3279C8WXh1mA5M8m85JgjbAIX2HIt4mJk0ErzryMUOC1jnQSMTAdQ7jRQRQrAlHSt+x4IjVAVsbbRDAqe+wfXkJ19K4GonVUqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=157oRdO02CClYq1a+SOlSkg+xVJgW09E0Mo0bv2rciw=;
 b=ZgQ6vydnY7AqI8wzlTBviPBqAbFyLREx0dYbUfxIkgaHZmGtYac5Pk9/kOe2SlUKpSN9nDIFkySAb3Icj3jQkgdw+fLy/YoozfAfvMWgj2mJSYwfjAgoEnb+gk455TpBADAGeXmN9E3drySpK7eZAYcdRDY9HnSAGLIIR8+goHtJfrzfEUbH2ahGfaZ43Nxes/DPeE0zOcDBGmr/i5bA8cGHe9M+Et1uOuWEaMPqMK8C6RlZB61Z8sVEB1Xd5aPzvyBE3nUQh++ADQdiHzTKfBO7H5w6a2B1K4APrsZucWn+m149IjMT7tmOzZPnSOhyw5sinZqh2NTI28nmbQtHbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=157oRdO02CClYq1a+SOlSkg+xVJgW09E0Mo0bv2rciw=;
 b=JU52yj9oZ12JGORlR0HEYjn3EJS9T1iWgh21g2K2QV0+x1PvCDOO65Pg1T78N3QDWJ48V7yGuQXc+/Gu9EN6QrgexwvJzNzI7+teeCxDmRlVllFBNmjKBRqPm4IvppfUE5lPfeK683s4HQN6BORmZc4lleAehUhmBXwYXhLAmajp6ysyAfU0A0aE7h9EJOn7jNlsFXSAxpdn4wAlYlLA/FJfR0tCJcuQ70vdXV5N5o0je3b2lf29bxfFufHnr6bf4LSvz2/x0iaC9wliQD07ayZ782forgkrpqlKTnGrMu7bmbYrHBTNBxWsjeBJzD1TwLmn7SKZStr/QC9Qwd04iA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYSPR06MB6716.apcprd06.prod.outlook.com (2603:1096:400:470::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.31; Mon, 14 Apr
 2025 01:20:02 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 01:20:02 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v2 00/10] Support vbootrom for AST2700
Thread-Topic: [PATCH v2 00/10] Support vbootrom for AST2700
Thread-Index: AQHbqcG4bE7I0lawpUCeffP2o9lbIbOensyAgAPDteA=
Date: Mon, 14 Apr 2025 01:20:02 +0000
Message-ID: <SI2PR06MB504170C096123632C5C87B06FCB32@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250410023856.500258-1-jamin_lin@aspeedtech.com>
 <d44e6583-c9af-4216-b715-aa4aa8968048@kaod.org>
In-Reply-To: <d44e6583-c9af-4216-b715-aa4aa8968048@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYSPR06MB6716:EE_
x-ms-office365-filtering-correlation-id: 0f309468-970b-4afb-ee7a-08dd7af27b11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ajREVlZQd0NuZ3dDZ3NGcGtnWmtCeEJjRUZ3YW14Ym00YlZFMmVkdVRsbDF5?=
 =?utf-8?B?VjA3a1hTWmZxMUNCRU8wSmNHVmEwMGpoa0laaU1rdENiYmQ3MUIzM3BoeUp4?=
 =?utf-8?B?VmlKaW1uQUpkSC9hcnRDUEFleXNFNDMwSHlLdCtqaVBUQlEvVUtVZ0ROSk5o?=
 =?utf-8?B?TkFuMGFCRTlGQTBxZHNldVh1bU9Tc3Q1Zkdvai9qbEZHQUhleGVFNGtVcmIv?=
 =?utf-8?B?SHB3Wm1YOEZHM0Vxa1dVMkN1akQ3ZnplaWR2Q251a2x0OXQ4TW9MTWdiYzN4?=
 =?utf-8?B?YVVyQVh1RVRpY3F2VUV5Z3ZYWmNRQkRiS1JPVU5mdGFjY0tEK1ZzOE5wSkt3?=
 =?utf-8?B?TXNwS05nbHprR25uaUV5NGxCM3RPN3VobWhnN3dJdjVJT01OblNZVnY3M0Vx?=
 =?utf-8?B?R0ZYaDBMRURNUytJeUM5SU5vRk5sVFBkUlFBRjdQSlNFd01jRXYyUE1aSm1K?=
 =?utf-8?B?TnZjVHNEcFRiN0tvcGtvUlVoWksxVmc0RmtJbjVHc3ZPN0kwY21qa3d1ODF3?=
 =?utf-8?B?Tkg4M2Vxb2FscHBuaDJXeURDQ29mVmpwWlZDaTNUNVpSN0xEdk5NTEZZVDNG?=
 =?utf-8?B?ejdaWW8xMUFISTcvOVRCc2gyVmpnNk9nZjdFV1lOSTRkYzVTOWhGSXdEYnlP?=
 =?utf-8?B?T1JNNUZCZGtBSm9LcnNTdkdNbWdoSkpNdU1oZnorbENIVmxMYkhLWndDQUFv?=
 =?utf-8?B?UExFMUdxU1RiMk5MMkxhMVFuRkl0TW1mdVh3Tysvd080U1RFZjRmVkNMOUJz?=
 =?utf-8?B?QjlLaTJFK2VmWWxDWFh1eVBneW5TUEtHZ2JmVDUrWU1vWEtiSFpVVERjWk81?=
 =?utf-8?B?dDl1MDhlNzNIb1dkN1pHejNBNXM3NUgxNUk3NDlaWS9waXNWVEhneXE3eHpB?=
 =?utf-8?B?WTNkei9SVER3VXhZdDh2dThUK1pOS2NoNjNTRnUzeTVrUlIxVDc5dGZGMG1w?=
 =?utf-8?B?c1pyNzYvK1dZallabW1IWlFRRGN6czlmVy8rcFh2RFNNNDk5TCs0dmtmYjJZ?=
 =?utf-8?B?R0JDck1PUzhxb1laRFhmbFZzZm5TRUorWGppeGVSTWU5NzMwSzFqY1IzUzJO?=
 =?utf-8?B?N0tMd3J4OENkUFB1VWFVMTBrQ2c3Q20yWWpiTnBPeTRrZ3B5OFY0Q1NPVmZL?=
 =?utf-8?B?N2J0WFhlV0xtakIyK2s3eFNnTlpmQVoyTEJLSW1jWjRHbmQ2ZDZzSktJZm56?=
 =?utf-8?B?RkN1dHJIVWUvRVhaQXhKMmtlZGRFSXVwa2dVUVk0ZERuNi84a0lqTVdsM29i?=
 =?utf-8?B?MXZQSXRjcHVLZTBDWEd1SDBrYlVGZVZtQlpGRFMzSUxzQXBYSnoycVVSYkNn?=
 =?utf-8?B?SC9wTldtek9TUzlCdlFTa1ZDWWUxcHFkR2pqaGR3cTVRWTZHSjJLVVVmb2J2?=
 =?utf-8?B?OElBT2NkcHdwUVpLcERueFh0dG13RmEwT3Izb3czc1JBdmFUYXhxOWNTbERE?=
 =?utf-8?B?L2E0UkozaWZhaXlmenVXODZxWkV6VDYycHoxNmFoM3FmUjZrTHlzWXphZVA4?=
 =?utf-8?B?c0FUOWE0cGs3ZXQ4aUd6Z3VrVXg1TEJOQ1FRM293MEZCYjgxQk1WYU82cDh2?=
 =?utf-8?B?QU8vREdpNG5PcDlIY0krR3NJTnZnTitBT3dFaUU1Tkd2ZCtFL1hQSjFuTFhw?=
 =?utf-8?B?aUlVcm81THFHczgrU0dsNmYzNzRjelF0U3UvcjRrM0Vpdmh1THFtZU9kdlMw?=
 =?utf-8?B?dHd4c2NDYlFpWjJuYUUxUURUL3czeHFwbGVFY2p3UmlHTWFsWWUvUnhlTFV5?=
 =?utf-8?B?Ym5wT2VDWDR0VjRFek50cUtEQWErbldLckRTRGp3SFFLV0sweVJvTzFZRVdR?=
 =?utf-8?B?Uy9TQ2xZRHp6LzZEREx3YW95L2ZWemtBNnZoNzNaYS9VWk5sRTgzcG9GZk9m?=
 =?utf-8?B?c0U0T3NLN2VuTjFOVjZQRjQ5bi93Ky9WTk9Od0J1SEpkNEZvMkZpeTdGc3FK?=
 =?utf-8?B?RWJRcWw3MXVxYnFnY0tTYVFvc2tobXh4Y3UwbjZTN2VwK2JHbnVlcjhTdHFP?=
 =?utf-8?Q?AD/xaYPdXLX33cLj1fxJRkLLHsdqJQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3JIZ21JSDVRYzRVN09sNkI2dE1pNzJCclR0aGRSUzQ5ejdWWFkyVTdVQlVm?=
 =?utf-8?B?enh5S0hhdzhCVEJxQ1NsSmxmcGl1azR4eHJjUUVCWGtVWS8ybXpldGZXaEMy?=
 =?utf-8?B?OStaaWhKalRsVnFadkEvRFA1UlFMaG92R0lBRzlKMDdZMGMzNzdkclVHQXdQ?=
 =?utf-8?B?MXkveXp4elYza1dxNmtYbzJQRDYyb0xrVXBlRjJMQlhTTzBudmh0dkxrVkxB?=
 =?utf-8?B?WmsrVExMa253RDBIWGhEcGVuQjBuU1ovelFCSDVnYTB2eDNSZkVLdEdpWm0z?=
 =?utf-8?B?RjIzK24xSU1OSkxEQ1dxMTJ6OGt4K1BlTk44Z3BzcGZBRmtqYSt2K2ZRWk9D?=
 =?utf-8?B?MUtFTHhTMHVxdE1mUjhvSkxVeVp3N3FzVUZGc3c0MjRJa2ZuektWTWlqemNx?=
 =?utf-8?B?V1dQNWxOMmhkVmNER2V0REx6U1NlR3dQRmVNdjJESzlVWmQwck05YWdTTTVR?=
 =?utf-8?B?UXlpaU53ckJTTHRGazFMQkU4ck1SVEliRGw0OGRpajh1WTVNNVFLUlVzcFUx?=
 =?utf-8?B?SHljcmoyWW84RHdYTGRWZkxYSXpFQXc1cEVUdzIvTjcrNG5zYzNMbWhGV0hz?=
 =?utf-8?B?N1V2bVVNYlBBV05aRStYN29FbldmQkRSV1k4OG9lQVIvN2xWVEdYTFN4ZWlP?=
 =?utf-8?B?NStZdHRDTlQyYWE1ZUt5OVBYai9XSnZ0TTJwSzZVSDlXcCtqM3NidXhiWTht?=
 =?utf-8?B?d045M0drVXMzRDJHc04yWFhMbTJBWko2RjZiU08xOHpETUgrR0trWVRseklx?=
 =?utf-8?B?S3E2TWtoTjdscHc4aHZ4WEpMRW9DNysrOW1rdDVnR1U2R216VGVEaUVZVnBC?=
 =?utf-8?B?RzdMOXFlK25GSHM5NjVJQUhIeGlndG9XWENvUHRydFo0RUxJVUNua2tnS1U1?=
 =?utf-8?B?SnU4WkdvbGNuOWM3bGd2dFZIcVJxNngvZUlEL25admQzQS9xNHYwUXRBak1P?=
 =?utf-8?B?ckxpY3NhRXhTVmx5dlJDRTNqZTZwaThEa0xMQ3p1WGtETW04L0FsZzVXYXlN?=
 =?utf-8?B?cGsvcUU5Q0ZsaGNaSGg2dTdkLzNUQWJzQkZ4Q1FsUDZPV1R1WDdwMFJndjlE?=
 =?utf-8?B?TS95dlNQZkpxcWRGYSswVCtxUkJRbE1mQ0djOHdvSXlxeExXRXdvcU5EMS9G?=
 =?utf-8?B?cFhSYXY3MzI2MWUweXFqajJ5V1IrQkx4WnZNZzU5WlZIZTIydDlMaHFMMW9n?=
 =?utf-8?B?UDZXT05sNUlWNUpOUVllbHE1N0tVZFNYMG50dy9IYkJQR05FOG1XdmJXTHBQ?=
 =?utf-8?B?NHlNamVTZzBndkxHYWpFVFh2aVhkdXVmWDk1elBXS3JHVVdTbnpRUUtadW1u?=
 =?utf-8?B?VmFQZC9sZk5RNDFHdnczTy90V0MwOWVhTEUvYzZzQmRnRVQwQ0d4YW1LZk5R?=
 =?utf-8?B?NHFFRE0xM0ZkK2dtNXBlUG5zYzMyaWdxNm43RTlmbUs3QzdMWTJydEFrc2J5?=
 =?utf-8?B?TExxMndTWWU5S0FYZ1ZCZm9hR09hVW5KL1pUNjF5dCs3aGVQbjhGMEhCVGhz?=
 =?utf-8?B?VmpvaytRc2VJUWU5TTlFTWg4UG9wWlk0MXV3NXRuSnk0QWVlenV3RFRrTUMv?=
 =?utf-8?B?TU96VHdNSFNMYk0xVUMxcUN6cUx1S0JnQy9UTXQ3UGUrTEgwWkx3TG5iZ1Rt?=
 =?utf-8?B?VjNKOWNnRnZobUFBZDR6VHphbmEzUlQ1K2JSdllodktUU2ZRcm12dGFtZUxX?=
 =?utf-8?B?eTlVOEsrczVYYVFjTWpNWlhFY1FwUGU4NWFFdWJyMEQ2bFkvek5qNFlCR094?=
 =?utf-8?B?TXBwNzQzeTlrU0ZQdmErSFoxZkNxaU1DRFVJRThZNVNQRitRZWFic1VVekg1?=
 =?utf-8?B?bXdoQWlSYjBrTEJZYUw2emtIS0taakJSaWRKQjA0UzJYNzNZZDN3VFhjdkFW?=
 =?utf-8?B?Y2VWbFRBWmwzb05HdGxIdzdBajh4L2ZsV0RmdkgvS2k0UWhzOE5vb3N1KzRP?=
 =?utf-8?B?N2tjL0VqdXJ2MmdWRDBmYm9HS3dyeDVwVkEvZXAwemxiajBWRFgrMUNqaTZT?=
 =?utf-8?B?d29MK05wWWRxRzA5cmFSTzIyZGxOSmt2UnhFRXNHeE4yckNILzFheXlkWDFH?=
 =?utf-8?B?Um9yNDdJb3E0R1hpM3RQMkFZaXdRNGxlTEhVOVNhVVA2bDV6SlY1bHVpTnAx?=
 =?utf-8?Q?RgT4MmyJk3QZ10DvZc33evMeh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f309468-970b-4afb-ee7a-08dd7af27b11
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 01:20:02.1426 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SqnPnOGfBiic/EkdGjqx9/w8kbeFZ2XavX6syJ29h38YXrl5GfBEjg87OTGB3vCiQPTIqoWnVtxZXCtJ+LWCt8L/XjxpAB8r/l6r7r/2MHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6716
Received-SPF: pass client-ip=40.107.255.108;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgQ2VkcmljLCANCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAwLzEwXSBTdXBwb3J0IHZi
b290cm9tIGZvciBBU1QyNzAwDQo+IA0KPiBIZWxsbyBKYW1pbg0KPiANCj4gT24gNC8xMC8yNSAw
NDozOCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IHYxOg0KPiA+ICAgIEFkZCBpbml0aWFsIHN1cHBv
cnQgZm9yIEFTVDI3eDANCj4gPiAgICBUaGUgcHVycG9zZSBvZiB2Ym9vdHJvbSBoZXJlIGlzIHRv
IHNpbXVsYXRlIHRoZSB3b3JrIG9mIEJvb3RNQ1UgU1BMDQo+IChyaXNjdikNCj4gPiAgICBpbiBB
U1QyNzAwLCBiZWNhdXNlIFFFTVUgZG9lc24ndCBzdXBwb3J0IGhldGVyb2dlbm91cyBhcmNoaXRl
Y3R1cmUNCj4geWV0Lg0KPiA+DQo+ID4gICAgYXN0Mjd4MF9ib290cm9tLmJpbiBpcyBhIHNpbXBs
aWZpZWQsIGZyZWUgKEFwYWNoZSAyLjApIGJvb3QgUk9NIGZvcg0KPiA+ICAgIEFTUEVFRCBBU1Qy
N3gwIEJNQyBTT0MuIEl0IGN1cnJlbnRseSBpbXBsZW1lbnRzIHRoZSBiYXJlIG1pbmltdW0NCj4g
dG8NCj4gPiAgICBsb2FkLCBwYXJzZSwgaW5pdGlhbGl6ZSBhbmQgcnVuIGJvb3QgaW1hZ2VzIHN0
b3JlZCBpbiBTUEkgZmxhc2gsIGJ1dCBtYXkNCj4gZ3Jvdw0KPiA+ICAgIG1vcmUgZmVhdHVyZXMg
b3ZlciB0aW1lIGFzIG5lZWRlZC4gVGhlIHNvdXJjZSBjb2RlIGlzIGF2YWlsYWJsZSBhdDoNCj4g
PiAgICBodHRwczovL2dpdGh1Yi5jb20vZ29vZ2xlL3Zib290cm9tDQo+IA0KPiBJIGRvbid0IHNl
ZSBhbnkgdXBkYXRlcyBvbiB0aGUgdmJvb3Ryb20gZ2l0aHViIHJlcG8gZm9yIEFzcGVlZCBTb0Nz
LiBJcyB0aGUNCj4gdmJvb3Ryb20gY29tcGF0aWJsZSB3aXRoIHRoZSBOdXZvdG9uIFNvQyA/DQo+
IA0KSSBhbSB1cHN0cmVhbWluZyBnb29nbGUvdmJvb3Ryb20gdG8gc3VwcG9ydCBBU1QyN1gwIGFu
ZCBjb2RlIGNoYW5nZXMgaW4gdGhpcw0KcHVsbCByZXF1ZXN0LCAgaHR0cHM6Ly9naXRodWIuY29t
L2dvb2dsZS92Ym9vdHJvbS9wdWxsLzUNCg0KVGhhbmtzLUphbWluDQoNCj4gDQo+IFRoYW5rcywN
Cj4gDQo+IEMuDQo+IA0KPiANCj4gDQo+IA0KPiA+IHYyOg0KPiA+ICAgIEFkZCAiSW50cm9kdWNl
ZCBBU1BFRURfREVWX1ZCT09UUk9NIGluIHRoZSBkZXZpY2UgZW51bWVyYXRpb24iDQo+IHBhdGNo
IHRvIGZpeA0KPiA+ICAgIGJ1aWxkIGZhaWxlZC4NCj4gPg0KPiA+IEphbWluIExpbiAoMTApOg0K
PiA+ICAgIGh3L2FybS9hc3BlZWQ6IEludHJvZHVjZWQgQVNQRUVEX0RFVl9WQk9PVFJPTSBpbiB0
aGUgZGV2aWNlDQo+ID4gICAgICBlbnVtZXJhdGlvbg0KPiA+ICAgIGh3L2FybS9hc3BlZWRfYXN0
Mjd4MDogQWRkICJ2Ym9vdHJvbV9zaXplIiBmaWVsZCB0byBBc3BlZWRTb0NDbGFzcw0KPiA+ICAg
IGh3L2FybS9hc3BlZWRfYXN0Mjd4MDogUmVuYW1lIHZhcmlhYmxlIHNyYW1fbmFtZSB0byBuYW1l
IGluDQo+IGFzdDI3MDANCj4gPiAgICAgIHJlYWxpemUNCj4gPiAgICBody9hcm0vYXNwZWVkX2Fz
dDI3eDAgSW50cm9kdWNlIHZib290cm9tIG1lbW9yeSByZWdpb24NCj4gPiAgICBody9hcm0vYXNw
ZWVkOiBFbmFibGUgdmJvb3Ryb20gc3VwcG9ydCBieSBkZWZhdWx0IG9uIEFTVDI3MDAgRVZCDQo+
ID4gICAgICBtYWNoaW5lcw0KPiA+ICAgIGh3L2FybS9hc3BlZWQ6IFJldXNlIHJvbV9zaXplIHZh
cmlhYmxlIGZvciB2Ym9vdHJvbSBzZXR1cA0KPiA+ICAgIGh3L2FybS9hc3BlZWQ6IEFkZCBzdXBw
b3J0IGZvciBsb2FkaW5nIHZib290cm9tIGltYWdlIHZpYSAiLWJpb3MiDQo+ID4gICAgcGMtYmlv
czogQWRkIEFTVDI3eDAgdkJvb3Ryb20NCj4gPiAgICB0ZXN0cy9mdW5jdGlvbmFsL2FzcGVlZDog
VXBkYXRlIEFTVDI3MDAgZnVuY3Rpb25hbCB0ZXN0IHRvIHVzZQ0KPiA+ICAgICAgdmJvb3Ryb20N
Cj4gPiAgICBkb2NzL3N5c3RlbS9hcm0vYXNwZWVkOiBTdXBwb3J0IHZib290cm9tIGZvciBBU1Qy
NzAwDQo+ID4NCj4gPiAgIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgMSArDQo+ID4gICBkb2NzL3N5c3RlbS9hcm0vYXNwZWVkLnJzdCAgICAgICAgICAgICAgfCAg
MTggKysrLS0tLS0tLS0NCj4gPiAgIGluY2x1ZGUvaHcvYXJtL2FzcGVlZC5oICAgICAgICAgICAg
ICAgICB8ICAgMSArDQo+ID4gICBpbmNsdWRlL2h3L2FybS9hc3BlZWRfc29jLmggICAgICAgICAg
ICAgfCAgIDMgKysNCj4gPiAgIGh3L2FybS9hc3BlZWQuYyAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAzNw0KPiArKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICAgaHcvYXJtL2FzcGVlZF9h
c3QyN3gwLmMgICAgICAgICAgICAgICAgIHwgIDIwICsrKysrKysrKystLS0NCj4gPiAgIHBjLWJp
b3MvUkVBRE1FICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNiArKysrDQo+ID4gICBwYy1i
aW9zL2FzdDI3eDBfYm9vdHJvbS5iaW4gICAgICAgICAgICAgfCBCaW4gMCAtPiAxNTQ2NCBieXRl
cw0KPiA+ICAgcGMtYmlvcy9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgIHwgICAxICsN
Cj4gPiAgIHRlc3RzL2Z1bmN0aW9uYWwvdGVzdF9hYXJjaDY0X2FzcGVlZC5weSB8ICAzOCArLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgIDEwIGZpbGVzIGNoYW5nZWQsIDY5IGluc2VydGlv
bnMoKyksIDU2IGRlbGV0aW9ucygtKQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHBjLWJpb3Mv
YXN0Mjd4MF9ib290cm9tLmJpbg0KPiA+DQoNCg==

