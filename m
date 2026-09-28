Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D94C9832F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 03:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB24w-0002lv-VO; Sun, 27 Sep 2026 23:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=724888370=Alistair.Francis@wdc.com>)
 id 1xB24o-0002kg-QT
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 23:30:51 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=724888370=Alistair.Francis@wdc.com>)
 id 1xB24n-0005JI-3c
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 23:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790566254; x=1822102254;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=U9NBWDnSVElj3nYnfGXyN2N+lKvLUP6UKUk5qXJ5BFY=;
 b=QrMpg9LPzecUiBOovGUvRXmUAFGtJ2Be75wB2kAdHmGPANhzgThOhyXS
 0o0gwSUpmvo4uDNvVBFdjCvwB9jDeh7lMzx9t3nPTR6tuqrS+8cwCPeVN
 kArBhAt+o4ZhIkNMaaM3gKK3VjPLHnuEv1TZyNB0nJE76bH1Ik0lJrOUS
 HghgVFMmjD6yXZCYlZJSfzjZ8m7ff2KZatr4HBJ+2kKW9o+fhvPDTMCi4
 KfBA+++Bj4KZk9v1ceN3/RyuAwHyxPgE/rx4Cvfq8en05WgtTxqlFqpBg
 s+x+K1fS6AT8Wc5qs1K2IpRZoLO031q68UmvgjlTX1grLiQFFKvbwnsFi A==;
X-CSE-ConnectionGUID: L7ZyJ0RsTBiER+2dn2SXsw==
X-CSE-MsgGUID: g7YeFQ2ESmKJnyW9rqurbQ==
X-IronPort-AV: E=Sophos;i="6.27,127,1786982400"; d="scan'208";a="152491866"
Received: from mail-northcentralusazon11013021.outbound.protection.outlook.com
 (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.21])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Sep 2026 11:30:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUTmaHCoKGyrIJbPxGMdHhSts50mHx5N1LJubJ/uihVdCqyWAj6aKAiAD0nHfJQXPgwhZMrkUnSB0EAUnE0GM7Woy30o3UiaYkPF2sBv6QSDZPlXVzu4Iei94AMFJrlD+Xoj93wu5KBzdSZhckD9Quwq4+wKX78tUHINXzycNef4YhKbGhv0Abn+xh8xHoywC055Z3fCAnNPRXNxQ7isObjLL8IF2XiT926fpn7wlL1PVpWI3ieYG765FlkhQiD/+O65t1m+IDUjBTeQIPA/E0RKTYdi6vtRILhReA5Bp/eoPIp1ZD9KS+nM6LckrH0w+1NnYmiB3WIvEJTAcDdyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9NBWDnSVElj3nYnfGXyN2N+lKvLUP6UKUk5qXJ5BFY=;
 b=Wps64ZBpEImIdgopU9Bc+jM84SgrjcC+SHs4/g3c15nMk88tVjr9WIWCoZMlJa+HGDHx3CUCj4ZiQU3Ya8sSSgs8UK73M4CbYH7DYqHhvzgjezVRVQB7F/m6Pt8UsbVVOMfRnhlbOVKzyAumA0Lhk/rtiCQumBRPBmESAEk9Kt7EtYRXBkHDx3UIXfUh0mWyX2B7a7fcXGohQju3zZQNQseZhOmp7UadGxzocaAWyLSy/DUD1KlAUEM4SydbQPyUjL68XK960dlNTnasiLTDDpE9D0dQkbjL4t92GsC5eZVpSTI3V+nksAeVyroj0RIvmmuOz6FjrEOU/LjP2kuJcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9NBWDnSVElj3nYnfGXyN2N+lKvLUP6UKUk5qXJ5BFY=;
 b=qOCUQIom7ZM5DosmmfmXdBJx5IvjKk5stYgL5pURUkwS/IpPzGk5cF6Ct21bNKN/fZ4/1CqYxheUjRMQ9KleaXo2zWkLj5RxDxLh+5BnkMLMd7bj15Ho0tKTkZHKWD3DRo6HwPYz4JW1bWhz/pu3YPZuoX6f3Dizf30CNmuXJ3E=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by MN2PR04MB6366.namprd04.prod.outlook.com (2603:10b6:208:1ac::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 03:30:45 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 03:30:45 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "max.chou@sifive.com" <max.chou@sifive.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "philmd@oss.qualcomm.com"
 <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v3 03/11] tcg/riscv64: Rename uj-type to j-type format
Thread-Topic: [PATCH v3 03/11] tcg/riscv64: Rename uj-type to j-type format
Thread-Index: AQHdQ90phz9Frv49kEq7q0RmmVBWiLbja8IA
Date: Mon, 28 Sep 2026 03:30:45 +0000
Message-ID: <4204fdadd353b1808ef8a9def9a68dab39b44851.camel@wdc.com>
References: <20260914000814.785155-1-richard.henderson@linaro.org>
 <20260914000814.785155-4-richard.henderson@linaro.org>
In-Reply-To: <20260914000814.785155-4-richard.henderson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|MN2PR04MB6366:EE_
x-ms-office365-filtering-correlation-id: ae4e491e-73e2-439d-f4f9-08df1d10e1c7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|19092799006|23010399003|10070799003|38070700021|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: +DNO61Fim8xihodXCH624bqku1cmFfUnmS2XWGRLEszZTnmDZoa+eADi3s+wNSBPa8HLDXJGs98SCOphVNls9CJxWNg6imRUbmRu+0nJe1GIoGKUtdUzgJHpof261qHyrbAqxmKCaGdfhQ+rDUWkyMgAUjphzCv0HdLWV4H13vqmLSMnuC3F0eOT257J0vgxvE4AVGUowSQoM5fA+T+Jif4EQbglSLsdyiKEXNChIIN8Q5GBOAMifiQ+oFP3Rhdm/qxlv3A1g/tWmlyMt+i16vxmGGgP9Pa3pAKX3XLSLobLxBvWglG1o1Diq3vk24AD5JmvP8SDFrK3JdprPI4E+7vMukWs/BXlA0TuPxNl/h1hw6OoRPj3ur4oOkkla/jszbNg0Pn1g7aP9LM0sHsXmHJBxCel06qiIG8rBQYkSXpCqee112zkTd6ir2vhLm5GtJD0NUYY0i2MWLtpzrIxp4BMueZ4hdlvur6PetXnQmsf44P6w3TTSiNn8B+xI9IB9ZEwIf2fndEW4WfK31PvFrTTbFzQcKDTN7Wm2J7u0avKIgBA0yhpKtSgEhF4xTezcbkQZRi28/O4K6oeWNimHLYeDaLF7yHrtLFxGqF4bXBeC0LmLPvt1d3dZGG3fQeVzMiKHTnnQOmPCTQr7SajLU77RQ3aqLBZmq042M4aBoizI8J/KjJO3xJ88W1wZP1aswFht0a9376qLW/lM1JZpG1QD8GnIqrD0hLQS7WDuEU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(23010399003)(10070799003)(38070700021)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTJSbXZxNGNqTU1HR2hsNDJ3Y2Qzc3NTd3orZmdJQ21NcU1Id0p6alVZRFNa?=
 =?utf-8?B?QUN3N3lyaTdMcE9KZHZPSEdTdnAwOHhQZlBReklhbUw3akFiZ1JsYzYrWlNF?=
 =?utf-8?B?WHNiQzJHUGwvbE9Ga3VMemppLzFwS0l2bHQxRUc5QWFRTWdHYnRZZmFzUmxT?=
 =?utf-8?B?bWNmV3dtOVp2N0xwMDdkUkJwVFg0ZkEvY05ReW44cGZYZmN5SG4xNG1rdmc0?=
 =?utf-8?B?MkN6QTZsUmVGbWphYkI4WWNLMkR6VG9ZSzRFdmd3WGREOFZ5a1l4L3pTTm5Q?=
 =?utf-8?B?L0psZE1haEpUWElMMmRxNHQrSGV6Z1cvWGpYVDY2THcyTVFzZFRFdGQzc0VH?=
 =?utf-8?B?T3RNSTh6N2lEVS9QWGdYZ0tCMmh2VTJ3ZUNjaVJocEMwMmgrWUlPUnhVTkNG?=
 =?utf-8?B?KzlYUnk4a01BYzl3cHU5L0UvQi9UYlU3Sm1SQVNWdFh5ZENodDdrK0FrMzFP?=
 =?utf-8?B?a3dEb3hTZ0dEcWVseXFlcHF2MC9aZk8vc0RCK2lwckxBN2hxWnNLcUlZUzFu?=
 =?utf-8?B?YnZxOStrZDRYOGRTQVdIdk1xbU1jejRmaXg5T0pEeTRGNm1jRnBUc1dKd2c3?=
 =?utf-8?B?MitvVkgyUzkzbUZQTng5Vk1VbVFBOHhBb2tjeEJ3LzltUmJWK1BxNUhXVWJs?=
 =?utf-8?B?dTE0TklyV1hnbnFpMGRZS2daMExORWQ1NmpmZFVIRERuSmh4REVDTFQ2V3B6?=
 =?utf-8?B?NUVEOHowdzVWeTluN09XZXE4TCtQVTkyZWNJLzI3OURuUCt1NkpWOGZtM0My?=
 =?utf-8?B?NW9sQnU5UjM3QUYwZ2MwUnd4SVZ5RlBUR2dTUWUybEhIVm44eStkcHQrdkJY?=
 =?utf-8?B?czFHZzEyQlBNTkdoZGJDN2FsUk5CSGU0RDF0eUVyQUU4TTV1c1FIOUhqTnVw?=
 =?utf-8?B?Lzc1R3M5UmFjbFEybWQ1WU9TaGtoMllYZ3RrV1NZRnZMMXNHZTR4blIyZDZo?=
 =?utf-8?B?TzkwMTFyY1BZREdnZEN4bWh0clNQM200U080dk1hOVJ1azBMU1Rjb0tuTUZ1?=
 =?utf-8?B?L3dLbXVPNzBOamhLNitHMWNDS0VkVTlOeDc0Vkh4eDFPN2RiYVoxZ2VyRytW?=
 =?utf-8?B?d21JUnVIekEwWUpTNERjMm9uUkRpNlJpdzUzUGxnODduUGN5Z3ZGWTN0aFpr?=
 =?utf-8?B?ZHNiaGY4dHl2UnYremV1bjBVR1ZkV2tDK1p3TEM2VXl5VmQyRTYxSEd3S1Qx?=
 =?utf-8?B?OVVsTGJpc3Zmd1Z1RUN4WTkwMG42Zm9KNmx4Um1jVTB2V0o3VWxqYlVmcFRS?=
 =?utf-8?B?bkZsS0NmL0hLQ2dEYktmT0pyNm5RbTNqWjVFLy9WOG83cUhpeU1Td1NGSjdq?=
 =?utf-8?B?QXltVm15SlV4OWh1cCtpYm51ak8wLytzbWNsR3NUT0dmZGlLK0xoYlNWRUtH?=
 =?utf-8?B?dE5kUjRQN1dXSVdlSzlSUW12Q3dudGZWQndENlp6NHRQcHl5WGQ5cStoWmFI?=
 =?utf-8?B?YTNLc3FjZFk1SDZDdGpXUmRmUndRWUFBak9STTVDbHJGMDVnN1hHdkZFM3VG?=
 =?utf-8?B?cnhDQWN5dVJRUU5EcEZIc2tIRUFBaWVCSkFueWdsdmV1aVZ2MmNzRU1YNVJX?=
 =?utf-8?B?VEN4YmlRUXltMXR4N0V0SWVQT3UwV0FnT0RxSG16SjVhdzVYMGdoRzRpcklS?=
 =?utf-8?B?S2R3L2NVL1A5czRvQVJRVGd3M2d4QnFLbFhtNFpvT1ZlRzlxVm9ody9Xa2FH?=
 =?utf-8?B?Y04rRXVpekFBamNnR01hRUxEdTgxam1oZjR1QUI2ZFNSdjl5WXJscmxsNVpr?=
 =?utf-8?B?L0R1enA0U3pDWmZLbkt6TnVZMTBzUmJmY29MTkJwU0JMeFdQakRSN0dUUDhF?=
 =?utf-8?B?alpXcXNQbWJSOWxKV29YWjNYRzRKaHczWUJTakVYVUc5bUs4STVvN1IwbVZG?=
 =?utf-8?B?V3E3SmFpZG1pVnRTVFBOeGlzMDBZS1BGMXoreitkTng5RzIyTTRDaVZ6YVRR?=
 =?utf-8?B?TEM3ZnlkaEdJUVlaanNEVmJOSUxpdlRnb1cxU2hERVNwQ0txN2EvMjRWaXNP?=
 =?utf-8?B?cVhRSkZFNTNzM0ZXZGtUN09DcnBTbnl4YkxVbG8wSHVJNG9pRjRpU2x1bXls?=
 =?utf-8?B?KzkzYjRMcWFKUWdKbThhZXlXUzRzSXMxb2hDWklMSklwRW84eFJ4bTZsUklI?=
 =?utf-8?B?Z3VFRVlnUFJFaE9NRE9oVnVVNlZvQTF2bFJjb3FTZ2FOeXlQUFFMV0FqMVBV?=
 =?utf-8?B?T0ZUaEYzdG9IZCszcXVCY21HN044R1ovbUY4ck16eEx5QWlWem4ycm9nWFVs?=
 =?utf-8?B?a2R5MTlCanhBWklVM0JlSWJEQUxDTVVPenFGaDhjaGlRcHJ5SVYrUGY1aENo?=
 =?utf-8?B?SmFFdWhJNmtranVEdHJYTnFuWWdyNVRWZjdjVk1aRkRxQzd3TVkvN29udnE2?=
 =?utf-8?Q?uxwqtFSRg3oezpVAj3LSI/atJ1tITnUmz9KckW4S19Qqs?=
x-ms-exchange-antispam-messagedata-1: urQh/3E6DCPqkNL4T6e6klM4zi5wPSM/5uY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18DB64D1DD7EEF47B26EC86384C49F64@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: he2zthW7aZj3OeOkUtXBcL1TS3KH0Rl/otrIih0l8B6eOR9kFCC6bb9HCKzTV43t+oWwtDNuwIwXZO7NxZoAnn9nK6CUvrL4OMQVb7kiB7SB8R3veqG8Yl5J/tGP7Ydipt6CruPji8Kx7dGZl0qpxG6ZP11ackw9mIyq9z0AUWy5EdXC6eTmIbkK9qAJtyYFIPdccb/s/x6MEL00XerWBKY6CYNjShA4MalpuyPt7hfjVaVePtB7bckC43jYKUG4hZorLrcFTSF4UktOKsAPyRksOd/iLt8Y4cHdxLKHLu/Nl4PexXCeXchvJoJWNRGBh+fzi5hw2HwPBUMhmnwlug==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gzI6Z+QeMyGkvUkgBbzkGJMgg/HY4qf6vZI5rIH5pHFvbefDXZTIVlbbeiFnBgokk5QJfZDj4njGtyRNju0F5jridY4eyIXk0ajjz1Y+bnvLyGv8US2B4bi56MSx9o60UgZycLue70DmEjK8wikV5FJwg1B195DQpm9ByPMGfP6BQNycnNxX3HmhnqAUVBLDHnkfCZNnjIhPs5K9T3KfVgmlv56psQLwv9tOkvFmKQghvOs6lAszTTc9vVH5Bu9m609Mb1wpdsuXTzYppzaPX0PLj9FDNu9NN/HnNniBVFfVLFCT5/75nm3IF95Zm9q+IFJ33C7S+I1LTVGUPLn6jY4nIFfOHcpr3aZwH2wXwOyFGwzPQq5oHtSxvZZyRwkZhYwg4N3OTkWKofVt7M6CDQ2oT4t7xwXglooDFxAkke1F/EDOI7lLRYvJBdKYMI6GyP56WRuBfylFJcYpdqDmZYzabQYeXoQInUOuuWTkU7NtcE8yFp6S0vKB/ulWF6ANVw7KlWmbcovO/9A5iI1q6nH6fKA5hGmGUmUwjzxFMGfDg6TRaOUmIaYaBDrny8GRxEusNv0CdhB1OH6YltZ1Zr35VEU0w5Omuq/BQNz2Ft8nbNW0ergJKKwcf7uwqOai
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4e491e-73e2-439d-f4f9-08df1d10e1c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 03:30:45.4528 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dd9oWEKmVFI4bbQeqWxgpq++ggK9zFU8FuQ/rWkRx5VK/TzNG8RRdcl3uj6+OMwyACcNA86kCZen3SU9qseXssenjWuKQ5YBy2CfG4NRrU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6366
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=724888370=Alistair.Francis@wdc.com;
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

T24gU3VuLCAyMDI2LTA5LTEzIGF0IDE0OjA4IC0xMDAwLCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90
ZToNCj4gVGhlIGN1cnJlbnQgcmlzY3YgZG9jdW1lbnRhdGlvbiBjYWxscyB0aGlzIGotdHlwZS4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNv
bkBsaW5hcm8ub3JnPg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIu
ZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoHRjZy9yaXNjdjY0L3Rj
Zy10YXJnZXQuYy5pbmMgfCAxNCArKysrKysrLS0tLS0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA3
IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGNnL3Jp
c2N2NjQvdGNnLXRhcmdldC5jLmluYyBiL3RjZy9yaXNjdjY0L3RjZy0NCj4gdGFyZ2V0LmMuaW5j
DQo+IGluZGV4IGExMGI0MzNmMmZmLi5mNzdmZGVkMWRmYSAxMDA2NDQNCj4gLS0tIGEvdGNnL3Jp
c2N2NjQvdGNnLXRhcmdldC5jLmluYw0KPiArKysgYi90Y2cvcmlzY3Y2NC90Y2ctdGFyZ2V0LmMu
aW5jDQo+IEBAIC01MDMsOSArNTAzLDkgQEAgc3RhdGljIHRjZ19pbnNuX3VuaXQgZW5jb2RlX3Uo
UklTQ1ZJbnNuIG9wYywNCj4gVENHUmVnIHJkLCB1aW50MzJfdCBpbW0pDQo+IMKgwqDCoMKgIHJl
dHVybiBvcGMgfCAocmQgJiAweDFmKSA8PCA3IHwgZW5jb2RlX3VpbW0yMChpbW0pOw0KPiDCoH0N
Cj4gwqANCj4gLS8qIFR5cGUtVUogKi8NCj4gKy8qIFR5cGUtSiAqLw0KPiDCoA0KPiAtc3RhdGlj
IHRjZ19pbnNuX3VuaXQgZW5jb2RlX3VqaW1tMjAodWludDMyX3QgaW1tKQ0KPiArc3RhdGljIHRj
Z19pbnNuX3VuaXQgZW5jb2RlX2ppbW0yMCh1aW50MzJfdCBpbW0pDQo+IMKgew0KPiDCoMKgwqDC
oCB0Y2dfaW5zbl91bml0IHJldCA9IDA7DQo+IMKgDQo+IEBAIC01MTcsOSArNTE3LDkgQEAgc3Rh
dGljIHRjZ19pbnNuX3VuaXQgZW5jb2RlX3VqaW1tMjAodWludDMyX3QgaW1tKQ0KPiDCoMKgwqDC
oCByZXR1cm4gcmV0Ow0KPiDCoH0NCj4gwqANCj4gLXN0YXRpYyB0Y2dfaW5zbl91bml0IGVuY29k
ZV91aihSSVNDVkluc24gb3BjLCBUQ0dSZWcgcmQsIHVpbnQzMl90DQo+IGltbSkNCj4gK3N0YXRp
YyB0Y2dfaW5zbl91bml0IGVuY29kZV9qKFJJU0NWSW5zbiBvcGMsIFRDR1JlZyByZCwgdWludDMy
X3QNCj4gaW1tKQ0KPiDCoHsNCj4gLcKgwqDCoCByZXR1cm4gb3BjIHwgKHJkICYgMHgxZikgPDwg
NyB8IGVuY29kZV91amltbTIwKGltbSk7DQo+ICvCoMKgwqAgcmV0dXJuIG9wYyB8IChyZCAmIDB4
MWYpIDw8IDcgfCBlbmNvZGVfamltbTIwKGltbSk7DQo+IMKgfQ0KPiDCoA0KPiDCoA0KPiBAQCAt
NTk3LDcgKzU5Nyw3IEBAIHN0YXRpYyB2b2lkIHRjZ19vdXRfb3BjX3VwcGVyKFRDR0NvbnRleHQg
KnMsDQo+IFJJU0NWSW5zbiBvcGMsDQo+IMKgc3RhdGljIHZvaWQgdGNnX291dF9vcGNfanVtcChU
Q0dDb250ZXh0ICpzLCBSSVNDVkluc24gb3BjLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRDR1JlZyByZCwgdWludDMyX3QgaW1t
KQ0KPiDCoHsNCj4gLcKgwqDCoCB0Y2dfb3V0MzIocywgZW5jb2RlX3VqKG9wYywgcmQsIGltbSkp
Ow0KPiArwqDCoMKgIHRjZ19vdXQzMihzLCBlbmNvZGVfaihvcGMsIHJkLCBpbW0pKTsNCj4gwqB9
DQo+IMKgDQo+IMKgc3RhdGljIHZvaWQgdGNnX291dF9ub3BfZmlsbCh0Y2dfaW5zbl91bml0ICpw
LCBpbnQgY291bnQpDQo+IEBAIC02MzMsNyArNjMzLDcgQEAgc3RhdGljIGJvb2wgcmVsb2Nfamlt
bTIwKHRjZ19pbnNuX3VuaXQgKnNyY19ydywNCj4gY29uc3QgdGNnX2luc25fdW5pdCAqdGFyZ2V0
KQ0KPiDCoA0KPiDCoMKgwqDCoCB0Y2dfZGVidWdfYXNzZXJ0KChvZmZzZXQgJiAxKSA9PSAwKTsN
Cj4gwqDCoMKgwqAgaWYgKG9mZnNldCA9PSBzZXh0cmVnKG9mZnNldCwgMCwgMjApKSB7DQo+IC3C
oMKgwqDCoMKgwqDCoCAqc3JjX3J3IHw9IGVuY29kZV91amltbTIwKG9mZnNldCk7DQo+ICvCoMKg
wqDCoMKgwqDCoCAqc3JjX3J3IHw9IGVuY29kZV9qaW1tMjAob2Zmc2V0KTsNCj4gwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gdHJ1ZTsNCj4gwqDCoMKgwqAgfQ0KPiDCoA0KPiBAQCAtMTk1OCw3ICsx
OTU4LDcgQEAgdm9pZCB0Yl90YXJnZXRfc2V0X2ptcF90YXJnZXQoY29uc3QNCj4gVHJhbnNsYXRp
b25CbG9jayAqdGIsIGludCBuLA0KPiDCoA0KPiDCoMKgwqDCoCAvKiBFaXRoZXIgZGlyZWN0bHkg
YnJhbmNoLCBvciBmYWxsIHRocm91Z2ggdG8gaW5kaXJlY3QgYnJhbmNoLg0KPiAqLw0KPiDCoMKg
wqDCoCBpZiAob2Zmc2V0ID09IHNleHRyZWcob2Zmc2V0LCAwLCAyMCkpIHsNCj4gLcKgwqDCoMKg
wqDCoMKgIGluc24gPSBlbmNvZGVfdWooT1BDX0pBTCwgVENHX1JFR19aRVJPLCBvZmZzZXQpOw0K
PiArwqDCoMKgwqDCoMKgwqAgaW5zbiA9IGVuY29kZV9qKE9QQ19KQUwsIFRDR19SRUdfWkVSTywg
b2Zmc2V0KTsNCj4gwqDCoMKgwqAgfSBlbHNlIHsNCj4gwqDCoMKgwqDCoMKgwqDCoCBpbnNuID0g
T1BDX05PUDsNCj4gwqDCoMKgwqAgfQ0K

