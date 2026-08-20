Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C217BC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 05:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwv3B-00058w-JT; Thu, 20 Aug 2026 01:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=685c7dad1=Alistair.Francis@wdc.com>)
 id 1wwv38-00058d-A1; Thu, 20 Aug 2026 01:10:46 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=685c7dad1=Alistair.Francis@wdc.com>)
 id 1wwv36-0006nc-CP; Thu, 20 Aug 2026 01:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1787202644; x=1818738644;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=PlHC3aVTUOmXlKDs1gflhK8P4eEap8pdG3zQ5TAC+to=;
 b=k0LBmDz5bT+Mm69BboGTZPu1jPT7x8pTs9EB7ESTGGklT2++pHx2ubjU
 IRYdNuy4wNVaZfIyeLrEO86LElycay/twzbJDmfJm7z3Yv6KHrwc2PQSI
 Elztpi/zKbPfq+YCSIjzLPedR2ndHscNGVxE+uEYsC6uLb/7RymPx7pwL
 G9ICXVlc1OA1xiqTFbcA0JM5/XAUmaL1tEmBMT4t38UCXobn8ieRw1wMC
 s+S0TXLrlJEyLyaZOfv9/o8ZnoelNOz2FKfOe5hKzwJHWVRJ+e1++cBUn
 pnYhQKpTfPDxDMhXQTKsykaz94LF1RXjGGOBcdL6Mg8lNMsZILeYDcTca w==;
X-CSE-ConnectionGUID: dwtgXOnuR4Wa+qCg5VlQeQ==
X-CSE-MsgGUID: iavm97gASUWybrR3Z+JqJw==
X-IronPort-AV: E=Sophos;i="6.25,232,1779120000"; d="scan'208";a="149707274"
Received: from mail-westus3azon11010062.outbound.protection.outlook.com (HELO
 PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.62])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 20 Aug 2026 13:10:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tG8Vdx+cRFsbtZoPZHo0wllO/1cuG23/sw89/sBkAt9X9I36YWP79NNFkozJNysVf1ntbUuFBKCyrFQO0DkCOX36Jv54EuzutYUx/HevZEy9VvVZKmd7KAIg6rRPOTltjUx8u96XqPSBcX7HRIh+LMrzGmtXytAHkQnA/YJWp9Lv/oDHqvXStx3hBCDCpstKFzFOu6TqbonBJEAWviGO6One03S6YrQG2t9CANS80x77ZA+brseGSZCTLuxnZyX4BIdYL8VGWK5rcNiBGCJRv5/ItWmO6kSXwp3NMv91QlgddaljbuZl78zLuZ9eM6uv2xGQtwLszw+RI1rLvqx/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlHC3aVTUOmXlKDs1gflhK8P4eEap8pdG3zQ5TAC+to=;
 b=y9Wx/CZUlFZ8bvZuVZsyifIWIoOlHz7U5flm7YKxLNpYGF2m6lGbVPzH2onXOQ39oDg3sSWMN1wdp7opCjge4Icjx0kU18jN1xnlYFp8I4oSsFS8LCOHgfJSc3JqkqSYt6lf5+0c4QT1clWPIXyrOlcM8ehN9UYKuBe7fp/WaCaRlvdp9mPtm5JCnWqg15eXH0MFf/LEsrIUTUWrpegWEj/VwrWRO3lpdxIYmMz/O54ilKksDXV9/vQZl45xV98jQT3mznjPaPIW0qYK01oNnpHSRR3ET8RNqGjlKJSSlJSMDpYNnK6u5mIQaa92Qo8npspF11jwqjHB/9274id0+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlHC3aVTUOmXlKDs1gflhK8P4eEap8pdG3zQ5TAC+to=;
 b=H434GtlYq2LSPd7VxfmEjdjnQqn5ubK2lryvzaGc0UEJmr7AhJHPebMcBmHFYuQuvjs+tOLriBTRTxCN/LYSB4xaFPnnsZdwNlfSXMb5okoKymUaDN2RV06e4egrbnsQfG9jIpk9bVZEwKGODk4zKBznG5t3FccXb6q4G/asJwo=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by PH0PR04MB994607.namprd04.prod.outlook.com (2603:10b6:510:43f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 05:10:40 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 05:10:40 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "liuxu@nucleisys.com" <liuxu@nucleisys.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv: Make Zcmt JVT loads endian-aware
Thread-Topic: [PATCH] target/riscv: Make Zcmt JVT loads endian-aware
Thread-Index: AQHdLiK2jfyfGGFOYU+C7lx9Ti0ChLamaDQA
Date: Thu, 20 Aug 2026 05:10:40 +0000
Message-ID: <b99f7ddf2a8e89c3648a9fdc13a0c3075b108835.camel@wdc.com>
References: <02050B1BBB8815BE+20260817083005.2392-1-liuxu@nucleisys.com>
In-Reply-To: <02050B1BBB8815BE+20260817083005.2392-1-liuxu@nucleisys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|PH0PR04MB994607:EE_
x-ms-office365-filtering-correlation-id: 537b64a9-06a2-4380-8963-08defe7960d1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|19092799006|23010399003|1800799024|376014|366016|38070700021|10067099003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: PopOdyswVCLLAvKqg88ZR9X8kLHDLshKAO+IRTruYx1rQIWgkxvpB2Bpl1t7Mg6P5XklBLIWeYr2hzOzHe8p9KPcmc2xSO2RiD4Tw7X/EU0Q0rmSVpi3v9Xli65L9kroT+F8UbqSeDItCn0Hv6S4XBlkCS2uKPjOui1XNlGgxUpFDuUCWHJNt5V2qB805IJN1j8RxamRLqJMuzCZvn/YG+N/JsUo4EoRJDTlhnDsa46YzoU9BksPFJxA52+vsnQt6L3hC6VKWNyVGTtXzFgX0tXH9vwCm9+tdJ+e+Y9xYRdjS3FcVJPYrCBTeOVx5gooJVXs0tXEq6Sh9Kb0u6uTiv63N7bQ9/qGN2uCbfHR5xGTm1WJUlmWBbc+fVK7M0Q3klhQyyCgUcEetq53ZUuoktiZe8IaonYp8VM16hfgM5NWI3Rd7dE0JUE4/Z+bE+arSZyXZNfvOin+OI2hSqPpdPGlHKft6qs4mctalbjL8/JkjfX3fsVOFhCop0rUpgF8nW982wmo8pCXJNP//a5N+xNPGuz6Cw7nZ8KoTfViY4OzZXIn6efUC5YY+uDfFX2SrAbHD8UwJ/YEl01L/ltqVnNFGwIiVAXh5fwbENhFKiMsmMV6OVs9bSrKsp6Oz4jE7j6oXeo8pHfN1PApNoBB2f/OpY8LGrMuvJ3JfydgfH3qPSJ8mEkLUCqSeRmVjyvCNZ5XiPTjSZ7IExQWO6gReruJPmXncEQXg9gqIHGHgAU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(19092799006)(23010399003)(1800799024)(376014)(366016)(38070700021)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEREaFJVNmF3RXZsakNXZEFwc0RHMFZvSE85a0xhak54M3NES3QzUExMWXpn?=
 =?utf-8?B?QUFiRjV3a3ZidkVLWGk3NVBrYjNQOWVaVlFyNkFrUTJ2U3BSN0RZSWMrRGZH?=
 =?utf-8?B?Z2dZM2tzYWh4MXFhdTBhY2hOT0h5bVptYlE1VU43RFpycURPNnZ3Y3VXMjJB?=
 =?utf-8?B?R2w1ME5HUnNFa3JXYzRXbHIvWFMzTS9FamJ6cmFFbEhSY0xpQktRUDBwWGU1?=
 =?utf-8?B?L1QzK2pINVJGQWlSQ0FDN0NtbTBuUGREekNtcTcrWHJ3Y05sZ3VJdDM4dGk5?=
 =?utf-8?B?emk4N09lR1ZFSllvMnZ3MGRLNnJ4OWJOaCtZelN3VWF4alkvY1JrT0luRThR?=
 =?utf-8?B?Y1MrTjJETlh2UDN2RUFzVWUwL0NBTUhaZWhaamlIOW1FZU81WEtLcE9lMCtm?=
 =?utf-8?B?cUdCakdhNlhHY0EzV0NwNWYvRmlhYnQxOWlGMmZXbkw0Lzc5MENjRldUNHQ1?=
 =?utf-8?B?cEhvdGdKcWNSSUwvZmNiODdKOS9SWWQyVUEvTFA4ZFJ3ZjNCQjUvT0t4SEd4?=
 =?utf-8?B?N1dCTSt6U1BXTSsyOGszYnl6SWprWERuSnZnV2VBSnFoQUQ5cGJoOXhvRUhY?=
 =?utf-8?B?Z0J5S0w5bGI5dnpvbndmU05kTDYzYWovTXFNM2RSSnJKSDZmaExlNTNma0Jp?=
 =?utf-8?B?TEZ0RlcxSXFaRWkxbDlXU2llUnF2SDRRR2JoeHNtbkxXY1pqNElMZVUzYzRi?=
 =?utf-8?B?akQ0c2VER0FxeGVzZmhJN2EvckcrckVJMDh5ME1yU0FrQlh0NmVBdjE5aEhq?=
 =?utf-8?B?V3N5NHA1UlV1aExmb3VORDJ2UFUzQVRGNmc4ZGpYa2MxTGhHdzFDRTA5RXZ0?=
 =?utf-8?B?RmE0dmpXbkFXZHprclVJZ2E0Y2d2OGFoa0tsWml5ZE1jS29TTWRmUDJzT1VD?=
 =?utf-8?B?djJ3WWI5RXgwTG9YWnpFZngxZlJUM3VBNTVlZTZxWmUxTG41cUdXekxhUmxj?=
 =?utf-8?B?c2dwQVJXWVVLai9yMHVsanFVTmJncmo0U0UxQU5qbXpSejBGcTdmYTh5MGdy?=
 =?utf-8?B?UTgyd1dEQ0tQZTRjM2FsUlJVVDZiajJCUjRYbWkrU0pSclhxVnVDWGltTmN4?=
 =?utf-8?B?Q3RDQ0NHOXlibDV5c0NZTlpQeEh6RVRFdGR3WGw1R2QwdkdER2hiV0ZCWEVy?=
 =?utf-8?B?VnpRUEhmaURYUEkvMkVEQStEVFVKOTFVeWZFOEZZYXRFZC95SU9JRDY5a2p5?=
 =?utf-8?B?bW5MbUJoRzNFTkpYWTdtVGNQRkhydXpsa0V5dEliR3ZjbzNpSWsxekxkeEs5?=
 =?utf-8?B?elp1QTlaZDE3VUd0ZzR4NEdnL3QycCtUQTllZmxrYjZaZG0vKzRRbjcxRCt3?=
 =?utf-8?B?VG9tdU9JRFhUT2hmRytPL2RuMWJIZ3YwbmlydmlSTkV6UGtDaTlXRnFHeTdW?=
 =?utf-8?B?ZkJzeDB4SEdGdWxOV0orSW5YalRZYTJMclV6ZWJtY1hITE55S2RhRjMzUTZK?=
 =?utf-8?B?c3M2L1ViZ3NMRm5tdU9jdkk4TGFjaStQZy8yV09hcmVLbitmaUp1NklWanNP?=
 =?utf-8?B?R0xCNDdDMTQzRkNKSmZucVM4RmhmOUp4NmpXdlgwbnNOUkZnMkQxYUZOaDUw?=
 =?utf-8?B?N25sWmNCanVnU0F0aFJtaFYzMDRyK2dJS21IU295d1BQYUgwOXBZNUROaDNm?=
 =?utf-8?B?UkFGN3M2MHo0dWk5MU9YSk1SOTN0azhMVEpSa0ZvZ0lxL0FocGxWclZLZ3Az?=
 =?utf-8?B?UnRFQmZoY2U1c21OL21oak1TcGV0R2FOWk9qTzVadWEzUmxuODZyTlVUVTRr?=
 =?utf-8?B?bWJrcTdSWEZLcE4zc2ZrQTRQY3c4ZElsaHZOL051YnBRZTlwSi9LK00xcjVR?=
 =?utf-8?B?UktIb2p5bkNjNm9iNjd4cWp1N1hucnQ0bnNHU0xkTkQ1U1JoejllOU5YQjRT?=
 =?utf-8?B?SUdSRWV1LzdhbDI5bUh5UGRzck5SdlFuclp3SFlJNHM0OVY3TWNUTmZZSThB?=
 =?utf-8?B?K0Y5dnBDTHliK3FvV0pwS2FObUJZTDFjbWMrRENQYlN1Nng0b1JTTXVCZzM3?=
 =?utf-8?B?c05aTHBhbWN3TU5tS2V0T0tQZWt6cmpJM0oyQmRNYm9SQnV2bFhINzRIckMv?=
 =?utf-8?B?L0RjZ3Zaa2RmY0VZRlVpRWJEckw1R21WMzA4L1F5WHRadVF2U3R0c3luTzlh?=
 =?utf-8?B?dVFGUnAwY25xdUpPRTJnYWdCWUphSXVTR2liRSszTDl6TkF6ZG9sMjd1bUdj?=
 =?utf-8?B?YUcrNnZxUW1sRTdnME5NSldqU2EzYVdwRm9obmJtRFljOHhWS2Q1VmpHV1NH?=
 =?utf-8?B?R1NjRjVrWE8rYlE3dUVxbGFpaEpoY1ZvU2hkTU5oenhxOHpBeittY0wwNVBJ?=
 =?utf-8?B?QjBUMEpvRmtwT1g4K0Z3eUNvSUxRb3BERk9VaFpsVlZMdjUraXJCZVVEKzl6?=
 =?utf-8?Q?kPOd31vdXeB/ZcHYBbkhKh4FZDAetkwA+KliNuFgGdYFJ?=
x-ms-exchange-antispam-messagedata-1: tHFm8DdsBfLe8d64EpDiLFvCEP79R7jQnGw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9FE6CE3A7AFB24CAABF07533604EDFF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: By8mJ0ZdTfxYpJuLmU3RT4mW2gT1GrQ0iJ485fyJ8pQdXX3KRSEvIIBXL7a9uHLYCGWGfFBL61ZtsqN9djAvtbqkWzUSE2Mi+4Cf7ML1Ex/f0J2PgOESL23JkSKoIIZIxmRXnnlsJa9YV0FH3SE1LIyuW4Sv9TZOdjmHG7k2o6ClXvSYss9WiIZNO93+ad4+zs1J8ra2lAyjJuNsFe5vudurtkb0Y0nIaHlVXT6vRFpnEigjS37+osq0RzW1uK9HbYZ9M1WdsAMowiEnnzhSNgohlHHaVqV+2l/DdC/3JQk3KLMABFVgGLWoe+PZXsFz/O082kJl7IfhcHjMI4H+1A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Tgt+NbpkCfYz7CE0sL0XO85S25fQe6iC/Lyohx43BBRos6fl7bh0MIt6YSZf4cLxaK7b6Lk5cBrmO6EHtl3A2T67BhHNQhfcNFVoYE3DkmmXh0rU2y+yX5lO0w/WmWaVltklwyAEq39XPmgXpdQXQNZEWhEtsOVIJbCmv7Pt4vCB1oyASaeWZwnJYS+3IZc0cJynBy6HOBBIsjX+EQS/uFDPaymkiP93CgykAYoJEZfUeNJSYq3GkwGYywVPb2CSznj9k0xX9OhcWutmJxzi8qpJFLOzCGieGrUgmJgfIrRfOzsffohJXIQBUYg+zQYs1uxkAqzyV24ocwbfFQvjMheGIwaS3ggO0mW2z735KkZfHs7+6xak4v0/gjXQHWzIZlgi3jAnb12abGuBhSjD+5Esq5tUcnMxWjOmLaW2oA2rv8/ga7xK7CTSgrsRJadP5qSU4tANZxhDM01rV+g8dCRCpNfNF9oxbpTPmyjjHcXzr4E3ncftbFgx3ist4Ub/DUIjR42FuZmxBOYIUQCrkoBp2SryeP1QKV1g6IMfwbQH4pzCl5WKAoiR/2xrqtarlzzOEH+ZNlC4I2Syo/+vdXBabGmyFYQHzXgLX5L4rBNGgUMpibFGmNWZ5YjY6vq+
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 537b64a9-06a2-4380-8963-08defe7960d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 05:10:40.1685 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OE04NRITfdmyOnWMYff5V3VGoBIBc+93hkpaReYba3cMzl3VFmHqigiDtCov1997W7/CmnoQnqt4SgWJpdHG3vbyTJ9zcbsVlzOOr3U69gw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB994607
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=685c7dad1=Alistair.Francis@wdc.com;
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

T24gTW9uLCAyMDI2LTA4LTE3IGF0IDE2OjMwICswODAwLCBYdSBMaXUgd3JvdGU6DQo+IFRoZSBa
Y210IHNwZWNpZmljYXRpb24gc2F5cyBKVlQgdGFibGUgZW50cmllcyBmb2xsb3cgdGhlIGN1cnJl
bnQgZGF0YQ0KPiBlbmRpYW5uZXNzLiBTdXBwb3J0IHRoYXQgYmVoYXZpb3IgYXMgZGVzY3JpYmVk
IGJ5IHRoZSBzcGVjaWZpY2F0aW9uDQo+IHNvDQo+IGJpZy1lbmRpYW4gZ3Vlc3RzIGNhbiB1c2Ug
SlZUIHRhYmxlcyBzdG9yZWQgaW4gYmlnLWVuZGlhbiBmb3JtLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogWHUgTGl1IDxsaXV4dUBudWNsZWlzeXMuY29tPg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIg
RnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0K
PiDCoHRhcmdldC9yaXNjdi90Y2cvemNlX2hlbHBlci5jIHwgNiArKysrLS0NCj4gwqAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL3RhcmdldC9yaXNjdi90Y2cvemNlX2hlbHBlci5jDQo+IGIvdGFyZ2V0L3Jpc2N2L3RjZy96
Y2VfaGVscGVyLmMNCj4gaW5kZXggMTViZjBhOTljOGEuLmM2YmE0YzFhNDc2IDEwMDY0NA0KPiAt
LS0gYS90YXJnZXQvcmlzY3YvdGNnL3pjZV9oZWxwZXIuYw0KPiArKysgYi90YXJnZXQvcmlzY3Yv
dGNnL3pjZV9oZWxwZXIuYw0KPiBAQCAtMTgsMTIgKzE4LDE0IEBADQo+IMKgDQo+IMKgI2luY2x1
ZGUgInFlbXUvb3NkZXAuaCINCj4gwqAjaW5jbHVkZSAiY3B1LmgiDQo+ICsjaW5jbHVkZSAiaW50
ZXJuYWxzLmgiDQo+IMKgI2luY2x1ZGUgImV4ZWMvaGVscGVyLXByb3RvLmgiDQo+IMKgI2luY2x1
ZGUgImFjY2VsL3RjZy9jcHUtbGRzdC5oIg0KPiDCoA0KPiDCoHRhcmdldF91bG9uZyBIRUxQRVIo
Y21famFsdCkoQ1BVUklTQ1ZTdGF0ZSAqZW52LCB1aW50MzJfdCBpbmRleCkNCj4gwqB7DQo+IMKg
wqDCoMKgIHVuc2lnbmVkIG1tdV9pbmRleCA9IGNwdV9tbXVfaW5kZXgoZW52X2NwdShlbnYpLCB0
cnVlKTsNCj4gK8KgwqDCoCBNZW1PcCBlbmRpYW4gPSBtb19lbmRpYW5fZW52KGVudik7DQo+IMKg
wqDCoMKgIE1lbU9wSWR4IG9pOw0KPiDCoA0KPiDCoCNpZiAhZGVmaW5lZChDT05GSUdfVVNFUl9P
TkxZKQ0KPiBAQCAtNDUsMTEgKzQ3LDExIEBAIHRhcmdldF91bG9uZyBIRUxQRVIoY21famFsdCko
Q1BVUklTQ1ZTdGF0ZSAqZW52LA0KPiB1aW50MzJfdCBpbmRleCkNCj4gwqDCoMKgwqAgfQ0KPiDC
oA0KPiDCoMKgwqDCoCBpZiAoeGxlbiA9PSAzMikgew0KPiAtwqDCoMKgwqDCoMKgwqAgb2kgPSBt
YWtlX21lbW9wX2lkeChNT19MRVVMLCBtbXVfaW5kZXgpOw0KPiArwqDCoMKgwqDCoMKgwqAgb2kg
PSBtYWtlX21lbW9wX2lkeChNT19VTCB8IGVuZGlhbiwgbW11X2luZGV4KTsNCj4gwqDCoMKgwqDC
oMKgwqDCoCB0MCA9IGJhc2UgKyAoaW5kZXggPDwgMik7DQo+IMKgwqDCoMKgwqDCoMKgwqAgdGFy
Z2V0ID0gY3B1X2xkbF9jb2RlX21tdShlbnYsIHQwLCBvaSwgMCk7DQo+IMKgwqDCoMKgIH0gZWxz
ZSB7DQo+IC3CoMKgwqDCoMKgwqDCoCBvaSA9IG1ha2VfbWVtb3BfaWR4KE1PX0xFVVEsIG1tdV9p
bmRleCk7DQo+ICvCoMKgwqDCoMKgwqDCoCBvaSA9IG1ha2VfbWVtb3BfaWR4KE1PX1VRIHwgZW5k
aWFuLCBtbXVfaW5kZXgpOw0KPiDCoMKgwqDCoMKgwqDCoMKgIHQwID0gYmFzZSArIChpbmRleCA8
PCAzKTsNCj4gwqDCoMKgwqDCoMKgwqDCoCB0YXJnZXQgPSBjcHVfbGRxX2NvZGVfbW11KGVudiwg
dDAsIG9pLCAwKTsNCj4gwqDCoMKgwqAgfQ0K

