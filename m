Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BFCCA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 04:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC8Q4-0008HQ-4I; Thu, 01 Oct 2026 00:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xC8Q2-0008HC-6n; Thu, 01 Oct 2026 00:29:18 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xC8Q0-0004aP-F3; Thu, 01 Oct 2026 00:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790828956; x=1822364956;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Zf+N/hOxkL9wGWyilbo//DrHB+ycDdQqlBWVvQgtRGs=;
 b=fueV5r9Ti6n8CjByBEzP9Z4TrU1moKTIy1mo5c6UXQiGSi6cq0cF1aHi
 JmZzlMd0Q9mGJt84ucpKzJIqoTwwQqyHY7bWBjo7Q59vnqypI/fpw++yb
 LTT4jvSyLAE/vmQ8uFcMcENI0AlTF7Fi9062bJyPZXwg4nHMI7fyC46WC
 4ulO9wykNaEcNxPYfOOOzb6FXYOpFLoQTvHqDOy3se9myWFgqA7lcXSap
 Qpn/EXE0I7/cJ2Ps/cpo6Wu8F6VfYLcfvuRSG5YehHXqGJkvH+uuI1b7u
 covNdgVYXFTT4/Dp7A24hFGqAMKaOyphr0sAT/8K7H6/5xftvRzfsQT1j w==;
X-CSE-ConnectionGUID: ld84A5zKScy/Hdvlhzph7g==
X-CSE-MsgGUID: uYr36WS0QgiCpRJJ64wQyA==
X-IronPort-AV: E=Sophos;i="6.27,133,1786982400"; d="scan'208";a="152782577"
Received: from mail-eastus2azon11011019.outbound.protection.outlook.com (HELO
 BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.19])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Oct 2026 12:29:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRHVCkGNeThrOXY/0gugkCkVACxepwxPNCo++FcL95HQFCqYPffrklV/uqyucqmw6eXpnzlmvTZueNIBntFa1ycXK/XgkslJ2ufGlIEb9Xkb+v9FarCPU/dm1lqT3E+gZLWYVFHwvdZaLzpFTuqEzo9x36zZtYHLg2M0yiNoj2WCw5Xse8kvq/yVItW1ZrydXUfbh8p9vWc3YdU4PvoQwHrf35hiluZttPK0Mhbs0rh5Y5djrVMlBo+8Kz02gvIv/fDD03rE2WvmrdoMM8wO48xibD7jV2Dw9/7BV4WB+l1OT3Hb0bW6oClUVLJreYn+MDCxIXKC4H13x5DB2dlGqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zf+N/hOxkL9wGWyilbo//DrHB+ycDdQqlBWVvQgtRGs=;
 b=yLV4vba+ivEH8PvamWd888ct079biHtHNBeTWgGQeZ7fWJLtpaS/wcraT0UMXFSAqRN/tBzM62e+ttVoH8ylNsI7q/ICLnRTPLsiUykgUortiuciztIL97aXACt/FYArqSVeYSdqejBq21qzZYQFVcEIJNZXhG72Ta3ChXuX2pY9buvxCIHjeoSoujMmZ+KwHGGL0EQ4OnpGTc0UAcBkql+DHFQ1noWyRiZshbgiDCzplMC+oqVZE9RazA7sAzmFxkKio1hMAMl30FT7n4AUTfwrZFDcUCONf8a2g7cjATJYpWGzqZ6xhtm6VJugVyWGbfMqdUtAerpXAFD9J0otxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zf+N/hOxkL9wGWyilbo//DrHB+ycDdQqlBWVvQgtRGs=;
 b=MUmsRXXIGOCkqfwOS2VU3ZUJOPj8xJEBgde3LKdqfm82E8tiCawTG2BZXfW7KO0xsi8gzgYQbMzkOfc9TGz7259qzjSEEhB1yJp73RCM0APnR9scYeb2mxcAxn36uoMoltA69npvx/kecngJtP/5By8UygnSKneNlSFkDIG8kPw=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by PH7PR04MB8554.namprd04.prod.outlook.com (2603:10b6:510:2bb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Thu, 1 Oct
 2026 04:29:10 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 04:29:10 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 0/7] target/riscv: Make MIP accesses atomic and BQL-safe
Thread-Topic: [PATCH v4 0/7] target/riscv: Make MIP accesses atomic and
 BQL-safe
Thread-Index: AQHdUQN4Vbk6kkrxd0yFyviegU7b0rboGMaA
Date: Thu, 1 Oct 2026 04:29:10 +0000
Message-ID: <bed07b438ca5d955d064d025d2c55e353126d549.camel@wdc.com>
References: <20260930174508.81497-1-philmd@oss.qualcomm.com>
In-Reply-To: <20260930174508.81497-1-philmd@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|PH7PR04MB8554:EE_
x-ms-office365-filtering-correlation-id: 4331edf1-5ee8-463b-b6c8-08df1f748a50
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|19092799006|366016|10070799003|23010399003|11063799006|10067099003|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: Y2odYx/PaRgtbdJZT4LpV3D0+twn0SKUvCFMkusV9bnXP7zdqIpXDhnnJ8nk31318lQyMyIWms63/5hpsvjCGcFlFT1bwJ9ZFk4OOZbu9h7CDYXZqf6aqHeQJH37nRGylICbJbYwm8KGICgKtQG6jNxKMKNq6q9U3IzYHITa8aPpS5dfyQ2jFuVSWYRoaUpb6Hdakq021qyLpXiXnLzWgDfiQVWvVgdi4V6mGGBMqj9pF9JX2QCe6NE+QgDB/jn2FA25cZMtCRliyb8GMjeCOadXWktKdMhKFvrSUXElPxid8v9eK0fb8FPa1iS7eH4baeTBiPIZV68LwEY/sp77oIZjesiYmWKqBz7Rg19XdeQBhFzVBI/rd6YNkIjIX6NuZbv+O+10haBb6XhtFM6jvdzwFLMDwisVxBIMG6PaBuUrsh1XdmozISfgvHtCPpddPDl/RZjclZUTytvwOls9lfVLgcPjKo3V7QmipRCNrwf1kTIX9q64VleR3y52La6EjL22GR/bZn1Fo0MNKsAhfB1f3Oyy/mVi577OA8+Vc057E6ahB/UyepO5I9P3hesJli8D35cWFJxuC050OahAAqenr7+dNoAWlCJ4BUdlGcY01DXdsG6/MTsFc7jY0o7xIIesqckdcHcw/lIUXCsH5aK3nwcnq6OcTd+QeIIwDfg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(10070799003)(23010399003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UURuZklzekN2VkpscDBGaVJTVk03RFdxL0ZCUTdQTU4yY2xxZVhPUy9EOXMw?=
 =?utf-8?B?Tzh0VEs1b2lrMktoTFZWSUplVVg0QUNPOXNkeU5uOTl0RW1iUmxzbWprNnc0?=
 =?utf-8?B?UVJQOTFpQzh2UmhFTWVDcWxMUVdPZHlmYkFibHZVdWFjV2hhK2ZRQk54U2Rj?=
 =?utf-8?B?clA5ZHpIWDRNbmhCYjlrV010U3c0cTZJSDJpelpERWROYnJISzdrRlVUUCty?=
 =?utf-8?B?M2lQVHp0bWNLT0h5SjNhK2RDZHIvUkJ5S051TDlvMUVsSXR3YUd0LzczejMr?=
 =?utf-8?B?NWcxcEtkd0tPTTE4VC9CbThIUFNDVUNncmhLTVcvNVFneXp4Y1A5STNPOXND?=
 =?utf-8?B?am4wZHpoWlg3dEg4SGl0NERiWDI0SzhaeHluOUpkTTV0WnQwMzllNVdXazdU?=
 =?utf-8?B?V1ozdWpOYW95MUl1MWNEcUxDMXJoWEY3aWJjSlFyanlUVHZ3eGNQSTRFY1l3?=
 =?utf-8?B?RU9QeXFjaTNmcWRnQ3dyRWRaR1BkWlJwcDloVDFWQkxGSUJxUU5kUEJmaU9l?=
 =?utf-8?B?S3Z1bVVtZzBqVXFkdmpIT0FwdGJHeHlxTmVUb1JIbjVVZ1JXNVMvTXBlQU9P?=
 =?utf-8?B?cHgxTWVlYW9BalI3SXNwTEhiTzI5Y3FFY1BzYlo4bU9XRm5raG83em1CYnZK?=
 =?utf-8?B?M3NjVk9mVXJqWmpzTEo2SGRiNFAzOEFPcC9jcUgwR0J0QjBjMHhrcitDcU5x?=
 =?utf-8?B?WVpZaTA3U2xKQmtOdU51Z3A4WXFjRmpxWkZhRmJYRnZIdnRDbkhoRFNTMlli?=
 =?utf-8?B?Y0xNM0ZDS245ZTBNNjBaaUNOSEx1WDdiRkNmblZ4MnQ4TGpPZUdmVHNIWFFG?=
 =?utf-8?B?Q0pyclJkZzdDU3pvOHFHMms4N2VhOVRhZjVabUhBZUFXYmliNG9pOVBsS2dT?=
 =?utf-8?B?VEo1RTJKZFhlS05JNjR4YUQ1QitwZWlRZ1hxMis2R0hBZVorNTQxK0FiWFUv?=
 =?utf-8?B?R0RvdVJRakI5S2JjMVNuVkh4TFJ4cHdZSEtjRWpVK3M5RlJsOW9yNzg5MWhC?=
 =?utf-8?B?ZlJJNTVRN3cyR0JrdGJycG8yZFpGU2l2RjkzN3M1c1VSck9QQUR2WGNudTcx?=
 =?utf-8?B?MGkzbUR0NGQ0T3Bra1FacmxrUm1qUkJNa3FFOTlFRWY3TDNEWVZkTGoxcDY5?=
 =?utf-8?B?dFFjN1A5dkhiTDlld1lNRzd2ZkZMZFBUVnhRV1U3R2NYRlVBbGRmT2psMGZY?=
 =?utf-8?B?L0dEdFhLQytDT2pCbnlveWJFeFgvek9ZSlpVbWprbFlpUE1CUENnZVcvOEtr?=
 =?utf-8?B?SUVhR04wa05RMGtDT21ZK1JCOEtnOW9jT0t4czhsaS81M3RVV0xETm5sOFNQ?=
 =?utf-8?B?dUtVMG1iZXBFOGI4eWpscCt5RDRFRmFYcUdVejVUTG9NSTZnMERRU1BYR3lV?=
 =?utf-8?B?OUZ6dlFENmVzRU9ablNhK280VVRnYTlySUNmbUtPY1A2b0J6WVNxU2J5S1ho?=
 =?utf-8?B?cXFoRjF1ckVGTjNXMnl4a1dLZ2ZsOWhqcDFwaEVyOE5FdFBLUGVsdjdyRVJ3?=
 =?utf-8?B?ZllQN0lFaGc0WlJ6NFErSlhSNFBEU1RLN0FtN0lUOHJQMDczOG9tcmpsQW9I?=
 =?utf-8?B?V0dKTWZCbzh3dGlPQWVyWlFkYkNuREQrR3pBU092cGgxU0c3OWVWdWJzTmcx?=
 =?utf-8?B?VHUzaWxrYlc0Tm5YZVNnbWZGQVl3UWZ0VjYwM29FWnFKV1haZWlobms5aHpp?=
 =?utf-8?B?YTlSNkRZNUtVK1RRR3d0UmtURHl3aUh2UmQ0MHpNS2NvbVBvSjhuM0VHUTZr?=
 =?utf-8?B?RzFPK2xPYWZHbFhhK0FoUzZtRkc2QmF5Uy9vREQ2b2M5UmlHMWRtWlFRSkxV?=
 =?utf-8?B?b3FuR1dVeEQ5NWVCNThPeHd4MVY1TkFzTmpkYVU4aGxXbUFSVCtHSjJkUGhr?=
 =?utf-8?B?VkQrSXVRbzVCNDc0Wm5jV2RJSGxTdWtvaStUNVRVdm5FT1hLRzlBV1VLY3BN?=
 =?utf-8?B?Qy9rcDFKSW1jRDNPM3laM3hIZmMzQ2xFSFVrYk9JUnNCMzR3TmkwT2twTUFq?=
 =?utf-8?B?ZlFtMFZkaDZ3aHFaMG5ic01FMWxaWWYxMm13eFhwWGhBSnU4bTA2VEtxb0Iw?=
 =?utf-8?B?eGx0NkdtYThrZHZyUXhRSVhvci9wVkNiSW5HdGJFdml3TFRYazFHWVJ1U1M3?=
 =?utf-8?B?dzh2K2gvUEE5ODZUekcxemp0MWJjZE9YOUtrZHJJbTY4N2pVTFJjdjNPV3BT?=
 =?utf-8?B?M0g2YUNMQ2lMQmR3RmxGU3ljT2RKMUh2VU5rZDhCSzRRMnAzVWxFUS81N2x1?=
 =?utf-8?B?bkJlV2JiTGMzT2NIQ0R3K0wxS1JtNW4vQWNWbnBuc1hDQkpEOVlaclNWR2Iy?=
 =?utf-8?B?SU5NellwK3hNT2lXTThxODQ5Q2RrWWwxaVM4RXBUemtlWDFqdE5DcVdWVVE4?=
 =?utf-8?Q?ixMua4OjVAyBK0KyGDXEZmQevacx3uU7d5Nh4uj0tiVjt?=
x-ms-exchange-antispam-messagedata-1: QShup8vz8w60EhQufv8FabTkFH4zG0BQZUI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC4919F4CF47F94BB292E40E587864CB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gn3sP8xXI61/gIJuRtiLxCBQKQjeN5/Y+FPA+knj3Gbm7Va1QME7P6zpjhkkktomuoQxCcVlS86yfc24meF7DrHEV9+CHCqLvd9QzuF3CdAaE/A8mcXtn9jZH/cgfN75tBuDgjGrN1iR3RIfqbrE+eWkPV83xBhizG8myzGRfgSklUVEbfDTZKtIHBAKRNjx3Ip/3bVhSmgmXXYuZ0+kprHCqgnIXwX6KcKRDDIznX1+vyZCnW7O4ulyA24TkxhAIAYL6Gz6aecz46kP6FuuowqF7UUjudRLgr5Ph3eSjH+8O7ka7wg2uT5vtQ/U7n25lvE972yOBOOC0l2Ac4Cq9w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: diQ7yTo/60jxTZXBkytmfowr++R4PYF2+2q3ngmiJBA8aBHZw3uQsy0kzltHHWEoT5RGbKvnQK5L8+MRW47X5tSCagvMVObXoDHAz1GB3qQXDKbVGuqwgzqUfLs0K4l+9K1xDoNaM8piWnbHX+QeVMlX9aKx+XZ0ypAFBudxRO5I6YW4qDm1ZZsTgJZDld6PxFNJF+XLxJezc4IuceyJ5x8LRKT9PnA7FQK9wX6SK+3oHSLklJRtH7aou+6KHmPXr1PQM1lqagRomKK7CJYEO0JqsU2Bqn78x8LW6X26JyLdqV3Lae8lDevFuMFP4dQ12SbvYjbJa2OFxn+Bx9fBEbjzXG+sW3F/0i4K/V11ibtTeror5le/7q9V0UT/DkArfQrIm+XqZukhBQ9TC1mfmj6u+34MtEBf3YBQ8K2+nBz5L3ObXBEl23j6x8vH2+FEGHdXF5NXX5+LPaYgPfx8a8Bmdk9s4Xlai4m/+yGXomGJdHslbzwUsy+XZ9cBZ2/PkMq/r0aNe3d2+PbRw1RxH7hxSHhCnNL0Fujje1UIjPZHXEHVPSQiVX1bYEFW7HYL4xcITJQ0ZRA5AyPxhzAJgWOUgYQo9T2nhnEctnHEAaJs+JHLVKc3mH8s4bvKfIWV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4331edf1-5ee8-463b-b6c8-08df1f748a50
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 04:29:10.6866 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3rNLMzIId+b+7SyvDDsQ6N4V2OgLuBi5JViI6QPDr7oXW5Rbcx+oSmlxEkvHQ8bb0SQscfrwfeviFLp1sjQ3uyYDt0euVt9sM/0UNWQnnBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8554
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=727d860e1=Alistair.Francis@wdc.com;
 helo=esa4.hgst.iphmx.com
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

T24gV2VkLCAyMDI2LTA5LTMwIGF0IDE5OjQ1ICswMjAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToNCj4gUklTQ1Ytc3BlY2lmaWMgcGF0Y2hlcyBleHRyYWN0ZWQgZnJvbSB0aGUgYmln
Z2VyIHYzOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYwOTIzMTcx
MTE2LjMxMjc2LTEtcGhpbG1kQG9zcy5xdWFsY29tbS5jb20vDQo+IA0KPiAtIDEtMzogZG9jdW1l
bnQgcmlzY3ZfY3B1X3VwZGF0ZV9taXAoKSBhbmQga3ZtX3Jpc2N2X3NldF9pcnEoKSwgYW5kDQo+
IMKgIG1ha2UgdGhlIGRpZmZlcmluZyBUQ0cgKE1JUCBtYXNrKSBhbmQgS1ZNIChJUlEgbnVtYmVy
KSBhcmd1bWVudA0KPiDCoCBjb252ZW50aW9ucyBvZiByaXNjdl9hY2NlbF9zZXRfaXJxKCkgZXhw
bGljaXQNCj4gLSA0OiByaXNjdl9jcHVfc2V0X21vZGUoKSBjYWxscyByaXNjdl9jcHVfaW50ZXJy
dXB0KCkgZGlyZWN0bHkNCj4gLSA1LTY6IGFkZCByaXNjdl9jcHVfZ2V0X21pcCgpIGFuZCBtYWtl
IGl0IGF0b21pYw0KPiAtIDc6IGRyb3AgdGhlIHplcm8tbWFzayBjYWxsZXJzIG9mIHJpc2N2X2Nw
dV91cGRhdGVfbWlwKCkgYW5kIGFzc2VydA0KPiDCoCBhIG5vbi16ZXJvIG1hc2sNCg0KQXBwbGll
ZCBwYXRjaCAxLTYNCg0KQXBwbGllZCB0byByaXNjdi10by1hcHBseS5uZXh0DQoNCkFsaXN0YWly
DQoNCj4gDQo+IFBhdGNoIDcgd2FzIGRyYWZ0ZWQgd2l0aCBBSSBhc3Npc3RhbmNlIHdoaWNoIHN1
Z2dlc3RlZCBjaGVja2luZyB6ZXJvDQo+IG1hc2sgd2FzIGEgbm8tb3AgYXMgbm90IHJlYWNoYWJs
ZSBzbyBJIGFkZGVkIHRoZSBBSS11c2VkLWZvciB0cmFpbGVyLg0KPiANCj4gVGVzdGluZzogQ0kg
cGlwZWxpbmUNCj4gDQo+IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpICg3KToNCj4gwqAgdGFyZ2V0
L3Jpc2N2OiBEb2N1bWVudCByaXNjdl9jcHVfdXBkYXRlX21pcCgpDQo+IMKgIHRhcmdldC9yaXNj
djogRG9jdW1lbnQga3ZtX3Jpc2N2X3NldF9pcnEoKQ0KPiDCoCB0YXJnZXQvcmlzY3Y6IENsYXJp
ZnkgcmlzY3ZfYWNjZWxfc2V0X2lycSgpIGFyZ3VtZW50cw0KPiDCoCB0YXJnZXQvcmlzY3Y6IEhh
dmUgcmlzY3ZfY3B1X3NldF9tb2RlKCkgY2FsbCByaXNjdl9jcHVfaW50ZXJydXB0KCkNCj4gwqAg
dGFyZ2V0L3Jpc2N2OiBBZGQgcmlzY3ZfY3B1X2dldF9taXAoKQ0KPiDCoCB0YXJnZXQvcmlzY3Y6
IEFjY2VzcyBNSVAgYXRvbWljYWxseQ0KPiDCoCB0YXJnZXQvcmlzY3Y6IFNraXAgcmVkdW5kYW50
IE1JUCB1cGRhdGVzDQo+IA0KPiDCoHRhcmdldC9yaXNjdi9jcHUuaMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfCAyMSArKysrKysrKysrKysrKysrKysrKysNCj4gwqB0YXJnZXQvcmlzY3Yva3ZtL2t2
bV9yaXNjdi5owqAgfMKgIDYgKysrKysrDQo+IMKgaHcvaW50Yy9yaXNjdl9hY2xpbnQuY8KgwqDC
oMKgwqDCoMKgIHzCoCAyICstDQo+IMKgdGFyZ2V0L3Jpc2N2L2NwdS5jwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8wqAgOSArKysrKysrKy0NCj4gwqB0YXJnZXQvcmlzY3YvdGNnL2NwdV9oZWxwZXIu
YyB8IDIxICsrKysrKysrKysrKysrLS0tLS0tLQ0KPiDCoHRhcmdldC9yaXNjdi90Y2cvY3NyLmPC
oMKgwqDCoMKgwqDCoCB8wqAgNiArKysrLS0NCj4gwqB0YXJnZXQvcmlzY3YvdGltZV9oZWxwZXIu
Y8KgwqDCoCB8IDIxICsrKysrKysrKysrKysrKysrKy0tLQ0KPiDCoDcgZmlsZXMgY2hhbmdlZCwg
NzIgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pDQo=

