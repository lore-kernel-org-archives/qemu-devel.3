Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9645CCF2D1
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 09:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhlY5-0004My-8N; Mon, 19 Jan 2026 04:27:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1vhlY3-0004MI-Gs; Mon, 19 Jan 2026 04:27:47 -0500
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1vhlY1-0006cB-Tu; Mon, 19 Jan 2026 04:27:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyDoc83q6nXHaytnl5QRmv5Z3uBLOu4kvD96D4CrSzAZSCEdvldHcfNzbvFvDHK0OBbALvrkMB+l7ChhTsZGrDsjlkjQlAaruV6EgLw3Xu9ucFzxzgH8nmNnFXISmGv9lhPNHrBxrXLtHPu86b17OEWZSh6JX7R2Ql6rHxpGxVwyun5ZTws/TRXz2jPRHPegaTNOGkUw9ndnU+huv8NrWrwOkAVoij9mLskJzSst8YmVtTJxJFIY13fhDCIOMLpv7PS/nYu5i7QwP2Hc6HGGVEl3xg6qzXM9ftSN3wJGkhXrCoedyeFT1CLbM06r4g0upXL1t7MY0uDSvfhtzaRz5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPjtV7jSBvKxVU7xG9iaSF/TVx3XcnrQSaWrR46g2CQ=;
 b=u5qJrMlfGNpKdBOoJvUJxwgQJr9XtIEPH1dAZTxwQDg6CfQ6OWPsp2Z0/3PpUNNac0k0yVO94P0/73lDPkAI0/svPhBSkiPDuOU5tB35qk28YGONoC4K0AlpHpyJ6reMZQrQmNw6etX/gPXB2OFTCr1T7OWpP+LFiKksmsT4cJs+Y408ZPKKxFnSaAO9yhhPNMra/RpXwA6BuCw2PZhQfvedt825TE51T7f/UVRuU0zmk2h/AtG1zBp47A3sXBcPzhrYh4VowbuYTxbszuz/yTcmUKZfg/zxGb3x5ajkHTTVJJR8NC2WF+ptBWiKDJYDqcs487AI/XQUWGn9GCbFTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPjtV7jSBvKxVU7xG9iaSF/TVx3XcnrQSaWrR46g2CQ=;
 b=RjhrlaZN7U8OMWTWgGtIjo31XbtTARPwrj4pTi/J8rU5XzSDPxVSsiu0TpIIDIkSEiJmR64VgZCNfvMDjpflv9Ib3jBFPi7Ko2WD3cAN0TcPJsRzONTMedPWR5Vv6+EfNTzT/KQwLeKqrvNQua9VG1R32yy353XPqps9w55nwoDaDzQsp+48I2zlKiKKggFGjhaB8FAgDvVnk8uYmS+LDB6IfHDXlQZgvgRRgiy7QVnAXtDiah6MgZ3u4uYhuSsCEJGVm4JStaa41lElPJHvjLnil+Cl6AVwjyGgoL9QDNOjd0a/VUru9vli7iMfgTis7c1fsgEuzgWerWxRfPgrfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS8PR08MB9868.eurprd08.prod.outlook.com (2603:10a6:20b:5ac::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 09:27:41 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%3]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 09:27:40 +0000
Message-ID: <3a2ad439-f73e-4262-85b7-3509400387ec@virtuozzo.com>
Date: Mon, 19 Jan 2026 10:27:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] fix potential data loss in QEMU (missed flush)
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20251229161740.758800-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20251229161740.758800-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIYP296CA0012.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::13) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS8PR08MB9868:EE_
X-MS-Office365-Filtering-Correlation-Id: ef87104f-3d46-4d3e-43a5-08de573cfe27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnIvcnd5KzBRdWltT3NWY1NCalZIZURCK2UyMlloUSt2SjJBb3QvSm1VaitP?=
 =?utf-8?B?djEzWk5RZ21qU2dCM2Z4V3RORnRWZkwybnJXamI4NGNCWVlFR0kyR0FOSVRj?=
 =?utf-8?B?bTBlUWVFK0hIZnh1NTJGNkdwVVBoMFFHL2tsaGFuR0RwUUtJcnc1dVBVOWJS?=
 =?utf-8?B?N2JMNGtqaWhzM2IrT3pjTmJpM2dpRjRKallwNGhXZHo5ckNsZFpSZ3NaRE5Q?=
 =?utf-8?B?a2N4Uml0YkM2NkJMOEZTMmMwckcvazNPV3ExVlJLWGxuamhRZEZ1QWQ3WGdi?=
 =?utf-8?B?aVdZRXJjRlkwMHBqQzgySkJQM1ZVL1ZJSWdtNXUvWHc1SjJZeWFvbm5zbktM?=
 =?utf-8?B?dnY4YTA4OUhNMlViS25nSVN1YjVDdCtWK0w4Tzc3bzd3QXhmZGloOXUvTWdz?=
 =?utf-8?B?TUEyZlRzeGRJMExiY2NPbVQzcnlPa3J0bXViUXlTb3J3U1h4VGpIU0htK2Qr?=
 =?utf-8?B?c3RNem1neVpzRnpXRUd4UGdqKzFHQklvNkxnb21PaVpRN0xwd3IvTGNBVHlY?=
 =?utf-8?B?N1FuWUdFMXZrWmdaK2Z4WjZFZlEvNFR0d3o3WFZ0VWNPbE9yWUVjTis3YzhD?=
 =?utf-8?B?cXB5LzByZm8zQlF6NzFTYzJ1RGRrQjN1cHRyLzFOaGhjZko0UForcjNhQlpP?=
 =?utf-8?B?Y2lwaVNPaDdkcmRXa1pzUHQ2NXBIRElCNmFuemNRVHFUdGdNOEorck0yZ0E5?=
 =?utf-8?B?M2g4RDFFUklYVFJjSHU1SEx4MUF5dkNweGJGVlVYSDBNNm1UajFTSnJaUGxt?=
 =?utf-8?B?c291azBaU3A3UTFYS2NuU3FLTFpPRktZUWt2dG1Jdk85L1g3Z3daeWxWWUpP?=
 =?utf-8?B?L0VEaXBsbElDbWxocFlPaDNiZmZhY3BHcUZnMFRud3VwVXRQY1BJVkxPR0ZG?=
 =?utf-8?B?c0pkaUM5RWh1MXdDNWlzSFdXc2dYT0ZOVnpvcjZGQ3F6akRrRDFtanpBRTZD?=
 =?utf-8?B?d0NaOFZSdUNVSTA5VzR2KzJMc25GdUJXZTM0c0RGdHBiY3lZKy9GZnRWZmgv?=
 =?utf-8?B?MmZGWHVvYzZGckdMV0NHa29DMEdyaUJsdkJwYzJRNExnWkF1K2g1NGFSSXc1?=
 =?utf-8?B?VFdHQlRoNSsyRzRNbkp4U1ZJWDZnRy9NbFQ5a096TlBRTDNrdmg2SFU0ZjBY?=
 =?utf-8?B?amhXSlBpS3VJSE9obk1zNklkaVF0amwzRmtSaC9SN0NXOUpxbmJ4MTQrNTRj?=
 =?utf-8?B?VmZEN3NkZWlYcEZNb3JXbXI5citiQ296UDlnWUtJYTdXS0VQYUJWMDNkUzRG?=
 =?utf-8?B?Ym1xRHRsaFZzNDBCMGM1UDNvM3RXYUkyMGJIaHdQY1A1Snl4ZUthN2VQME1u?=
 =?utf-8?B?RTdiWmVqbGg2OVp5NTA1djRIb2creUVnbUdXc2RtK0xLR3QzK3ZtWE5jcjNv?=
 =?utf-8?B?ZUdrdXFqOHJZOHpKQ2p1Y1BIOXBENE51eldMaGRZaHltUTRrTG1RMGpJaDFM?=
 =?utf-8?B?YVRwYVpyUm9YUlhTM0Nka3RDd3lWalVCSWdHZkVOWStNZEgwOFhHb3BSNVpU?=
 =?utf-8?B?QjRmc3lZVUplcDJiNXFTcmE3V2p1UzZMMlZkL09LSUc2Uk5LMVdNZC95aWlr?=
 =?utf-8?B?OEZ0N2ZxVTIwdjFadW1WTjh0emo4S2VGTW80Q21KZkNBamxZSklRTjV6MSto?=
 =?utf-8?B?cEdwcmJWV2RZbjNVUlozTkFFdVlodzF3N3piK2NHOGRwa1FrNWYyTk1LZWpP?=
 =?utf-8?B?QlM5cUZQR0RpUHhGclo0UUNmTUtLSUxJa3p2UWNwS09hZ0lDSE5tSkM1L3pK?=
 =?utf-8?B?aEkza2dNeFRXY0VQZVMvS0RVMVA0YXJNZlVVb2ZlK1B2MURJNFpJOXBTeU9L?=
 =?utf-8?B?THl2ZlJ5TVh1VnJmMnVpdzNkbG1xUm44RXBaV3lVZ3hZTFNESnludVhWdzhD?=
 =?utf-8?B?QkpvdXIrU1FjRnRLM20wZWxOdFZDbVUyYXJSNmZDNm1SWDR3Zyt3eGZneUtH?=
 =?utf-8?B?dHFXaTF5dExiOHR3Mi9PYi9VY0tEWUkyZXVaWmhIV0szRHBWM2dkdkE4OWxj?=
 =?utf-8?B?ZWw1cUhiSVBVT3BRTFdYS2pmdEtUeEZSUmkySnl5VW9va3FrYWlkNStwbDVl?=
 =?utf-8?B?SUJ5SnFQL1c5QjZHUVIwNS9uOC93WjUwWWk3Ym5jM1VWYVZ6SGJWRlowMFJV?=
 =?utf-8?Q?kR98=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDBYVjhMNDJlN0t6emh6TllpeFozL2hRaDVlNVpHNGZ2c0N4b3laY2FmTFc3?=
 =?utf-8?B?TkpESEFQRVV2U3dYZXloaEFCRC9XeVBLeWpFaE5ZeUZjNDZGUW4wQlZybkRj?=
 =?utf-8?B?SkNyK1BtVWgzNjVMa1VkWE82L09OZXF3RlViODNWYklzNzdrY21FTjRTYnVw?=
 =?utf-8?B?dmdSK0ZJbzJLVktwNW42TmZET05PMDNXMU14SlpFRWVybTRQeVhpWjJ4cUYw?=
 =?utf-8?B?RnRPT2szdGVXSVp1OTN6dzFHNUlaNkxnYk5lSVJuQlYrQzdRU2lPY3JvR2I2?=
 =?utf-8?B?SjVaeGUzQ0taV2kxZW9JOXl0Q2VQUU1FeE9IbklYV2krTkZDa0JVR0FHNTZZ?=
 =?utf-8?B?Sk1pbGdXaXV6eStWTkhJY2hNVlB2cEtBQnlyTzJiWDNSai9rS0t4TGZZb044?=
 =?utf-8?B?NzdVSlFpTHdKNW00d05PaDllNFdETTdQUEs5Z25kS2ZxM0FnSktJVEp3aHMy?=
 =?utf-8?B?TG92SjFJcjhQYXBiTlZqWlA5eWs5UUl6VS94dkdoOGVGbDA0R2pNSXdUVUVB?=
 =?utf-8?B?UkR5cEY1Mjk4Ni9SZE5FRVVmVkxONzZVMnR3RVIyczl3dXcra2ZpYy9NWG4v?=
 =?utf-8?B?WUZzaDB3YkdGR3h3bmRpNzViTE5UZDd6RkNiZzhLcjlhOEhKUUdGd1hVZHdy?=
 =?utf-8?B?Q05JSlFmSEhzRUdqdGtMeXlCQm5xM2FvUzlpR0QyRENaMnd1d2lEY0V6UXo2?=
 =?utf-8?B?bStDSE4vbzlHd0gxaU1HNVkraWZMVGw2cExiazNkY2x0MmxOckI2N0FraDhJ?=
 =?utf-8?B?NDFHMkZHVit5U2h0L3RhTTR4YXRtek83MDkwMWFsb0JTSURBMUN4Q25ITU91?=
 =?utf-8?B?ejk5NnIzcGVNcExiYnhWVUhHWU4vd0FIOHVENStVTERjWGJQVFdUYUc3Zkk3?=
 =?utf-8?B?T1djOEZFdHBVSXo5UThjK2h2UkxHc21UcXFQc1FRSmZxMi9HNWgxMlBlbzAw?=
 =?utf-8?B?c1M5NU9IeHFKRi9WRWhNZ3NGeW1aay81LzZJS21kdVlFN1R6enE0U3NzalpD?=
 =?utf-8?B?U3kzZm1DQysrK2J4S3ZzK1QrdUgrK3NDdGs3VUYvOHFjTzZCclE5NGFTSXhV?=
 =?utf-8?B?MEdObHRZWWZxWWlpUkFUMW55U1V2b0duL1l0Q1lST0dySWF4aW0rOFJrYS94?=
 =?utf-8?B?VU5ZQndNOG93SUlnaTJSZG1HQlB6Y2lLbGF0Q1M0ZXVVblZXN0hyTjlVN2w4?=
 =?utf-8?B?QlRabktSQjEzRjlucUdwN3B1VWFEdkxjbHhEc2hxTDg3OXBKMUpiNXRIcFRC?=
 =?utf-8?B?T1Vob2VEekR5cDM3UytWbXZDbitOUFpXaXZaSU1ObTlwY1EyRGhhWk9HTkJs?=
 =?utf-8?B?WER4ekFNWEViMCt1M3dwRVM3SzZoOHRTVFU4VURhT3Z0ZHd6SnVYaUdUV2Jj?=
 =?utf-8?B?ZTJENUNNblcrSWZDOXgzQUlvMi9KWlVBU216eGl5c2R4K0IzWFpWMW5oTWRP?=
 =?utf-8?B?SnVqN1NKbmlwUm1mVlhRbGtLUVhjSENjY3k0eHptbjhyYUhEeEc0SnEwQkpU?=
 =?utf-8?B?bXI0RHhNTmR6U1hUaHowazRNVnl5T3lWYUVxeGpvNlVEekRPOHV4MThlc2gw?=
 =?utf-8?B?Y21RZDluVVhzNzdyanB4ckF6UG5vQzlFaTBBRUZVNGx6Y2NtM0MyYTNjeDJP?=
 =?utf-8?B?bVZDOUlSR2R4aldGNEpxY2lOZmJEbFJrSnNQTnp1TSsyMXp3Ri8xYjlPOWpl?=
 =?utf-8?B?ODN4WjFBMW8yT3lURjVGc2wwRHRDd09QTjJXejJrWmkwTmZaM2dnUGlJa2JM?=
 =?utf-8?B?cE10cEFEWnZkQXlvOTRwZStUZHpBY2dZaC9aU2FnTmVNTlBnVjR6TnlTTnFQ?=
 =?utf-8?B?UERQZDdISXBvVzJYT3RId242TWtzUkNMbkZHa3JtSWdqM0Z3dDZmZXdNZXJK?=
 =?utf-8?B?U3VFTTFSWWw3WmxGMzlqYTB5L0JyS1RkOENXZC9GekZJeUZWY0JuQWhZdUk4?=
 =?utf-8?B?ODdJRWprWGI2WllwRUY3N0JhSkxGQlFCOVE5a0o0MkM4TWVnQ2lFYWVhQlA5?=
 =?utf-8?B?RkNLVnlxZ2VOcGdEM2JneXQ4SmFHV3FENFp4MmNETHQ5eEVVT29GM0ZzSy9v?=
 =?utf-8?B?b3QxSWltcjFjc2R5RzlWNWhNVmtkWTVSRzJ1YzQ3NDB5Ym12TFdTaDZqT1Rn?=
 =?utf-8?B?aGtUQUZ2eWxUY2ZscHlSNGR1SnJVSWdyM09HeUR6YjhYME02Wk9CNTJ4UVRU?=
 =?utf-8?B?TTNNTU44ZHhaVDFUa294MHd6TE9xM0hxbk9YNkl1K3RNR25iRkVwclJLUGh4?=
 =?utf-8?B?Zm50UXloTEQ1UjJLUGN2OEg5MnFlbUhRUUVpTi9wYWdJSnRPendGTjh6ZDVk?=
 =?utf-8?B?QTdjWnJTR3Z5MTdWQkE3M2dhcDlrbzFabWo0dlh0ME0vRndJYmRzUT09?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef87104f-3d46-4d3e-43a5-08de573cfe27
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 09:27:40.8827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYUABYr6Zx0W5Q/uQy8TX1ajErGwMmIwNhDhgKzv5EMYo4LpCMIaK1EOnt+l/9l66kbV4qS4BXoL6nx407QObg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9868
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=den@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

On 12/29/25 17:07, Denis V. Lunev wrote:
> This series is a followup to my previous patch sent under
> "qcow2: add very final sync on QCOW2 image closing". Could be considered
> as v2.
>
> This series addresses two problems:
> 1. bdrv_co_flush() at the end of bdrv_driver_pwritev() and
>    bdrv_co_do_pwrite_zeroes() could be effectively no op. The problem is
>    that bdrv_co_flush() is optimized internally this way to track real
>    requests which were making changes in the image and without such
>    requests from previous flush() do nothing. Requests are tracked using
>    write_gen on BDS. This field should be incremented after write is
>    completed but before flush is called.
>
>    This could be considered as potential data loss if caller relies on
>    BDRV_REQ_FUA flag which means that such requests are really lands on
>    the underlying device, which could not due to missed flush().
>
> 2. qcow2_update_header() must actually write header with BDRV_REQ_FUA
>    flag as image processing on open relies on the fact that header is
>    actual and it is not possible to reorder header modifications and
>    image content modifications.
>
> Changes:
>     * added patches 1 & 2
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
>
ping

