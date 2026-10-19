Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E926CCF2D4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 02:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIdZC-0004lt-5T; Sun, 18 Oct 2026 22:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xIdZ8-0004la-76; Sun, 18 Oct 2026 22:57:34 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xIdZ6-0004PX-Je; Sun, 18 Oct 2026 22:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792378652; x=1823914652;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=3boix3VXjHMFvAgNgFowNyYrQvIhJoZA0vcWWwmvLYw=;
 b=LRtW8HsNi/q8wTwA0FZZ8LzmM28L1CT5mF0dYEpeHdN3/WuRZaMYKmMH
 SESfQeCZNLLRXIMczGBFrCze91Bvq7bSWBafes7yUKZmdSI0MsJbxDEM1
 uRf2+jJr7OwkaP5hKkYx7TzGcgSQCEe03kPFESPzhAOp4V2FTWEdbdioq
 vs/qBRIFyqka3QCXuJj6nIHOvTvyiGiVqTecl1vqvjun0b6c3I+bInQUd
 TiVL1QXzowrgDEJRTYxj4CDNJca9O+yWjQv5yvZp0CYb2DHAtTqtSmyfz
 p8+djTe/BqVfZIm+bbHPR+X3NxRsYtvz6gG7XBa51whNs7k6TrLeX+mED A==;
X-CSE-ConnectionGUID: zD1gbZC7Q5ObC3pTmjEjGA==
X-CSE-MsgGUID: TfnFNKReRBCpMuZl0U8eaw==
X-IronPort-AV: E=Sophos;i="6.27,166,1786982400"; d="scan'208";a="159365842"
Received: from mail-eastusazon11012071.outbound.protection.outlook.com (HELO
 BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.71])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 Oct 2026 10:57:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O75qa80VNnM0PfRjUSW1EVMbSMoG63FoBMzaAlsWSNjRmZnSX7HPM3pJ7W8JR8348+jPexOt3uvdGMF02bWs9JxYiOnF3P9nz/lkXUYnDApBL0Ry5K48vsnSC/8NhEtSrWYKXuU4k9sTDreNFWwOv0AWS7JCn8/XtpcTxisNoFLD74vLpPXO6jhfdDR7TT2GH9UM8Z1PZF4z7N40pVci0htG8TIV77hkWjTyuhhO67N12oR/5zvPiRP1VfIGLyf9nW9tRrXeSr3n6QmT/BAKNur4JoTD4YWwC+thj/Rk1pQlu5To07dHzDm0lGY9fxkz+dqURKxRpCCXSk22bkyXNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3boix3VXjHMFvAgNgFowNyYrQvIhJoZA0vcWWwmvLYw=;
 b=M0YJ4/WVqYM4a9riWrTlhDAZYYNFxJp+P/QT73Jun9as54/S45F+sF5xZ2aCl0KanEkzxo8NpV0RC0b2UB7sfcHx9QZGRAvlH6fYEfAmdIUODUyIjJceB7c/H68B26exiaIrkq9T55ZoBAesMsxR++I9Q+j6c8ahEQMzXzNpUzDDIIfiOJJ7txPiKBX6BscVT8l1VcKU2UpUW2Tz98BWgxJwQQZoECdFDWxuTewhbesqfZ9B3rYGsY2zCdazGfF9wIbhnNhKdX5gOiBbeyS87lSGnFxSnhw8jxjuQEyx+l+wH+LgpkbMij4DHg2g4hLwK+3Nfd/DSmiaBSkqY95pAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3boix3VXjHMFvAgNgFowNyYrQvIhJoZA0vcWWwmvLYw=;
 b=RROefKEvY14kp8geT0HAro/iUQRB1tjiz6CT3PGS4zDV5qXb/cxRe9l7bLVLmfz6eCgWiQcctFLsUaEvznAEaDFFqo9c7GJ2dJ1E1dOd1Qq9tT7n1pJ9QcbekJBCIJbEq/klxj6ZmXEw1WkFrpr71dnz9fBeL83rokeB9v2VVsg=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by CH2PR04MB6789.namprd04.prod.outlook.com (2603:10b6:610:a0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Mon, 19 Oct
 2026 02:57:26 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 02:57:26 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "portias@oss.tenstorrent.com" <portias@oss.tenstorrent.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "mpe@kernel.org" <mpe@kernel.org>, "asrinivasan@oss.tenstorrent.com"
 <asrinivasan@oss.tenstorrent.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "npiggin@gmail.com" <npiggin@gmail.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "joel@jms.id.au" <joel@jms.id.au>, "zhao1.liu@intel.com"
 <zhao1.liu@intel.com>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>
Subject: Re: [PATCH 01/12] hw/riscv/atlantis: Set valid_cpu_types for Atlantis
 machine
Thread-Topic: [PATCH 01/12] hw/riscv/atlantis: Set valid_cpu_types for
 Atlantis machine
Thread-Index: AQHdXFPaQ9kh439yv0egk0EqsRGFvrcEMnuA
Date: Mon, 19 Oct 2026 02:57:26 +0000
Message-ID: <ff985879c4e38907ed4dace991b3e046611698ae.camel@wdc.com>
References: <20261015031804.2406055-1-portias@oss.tenstorrent.com>
 <20261015031804.2406055-2-portias@oss.tenstorrent.com>
In-Reply-To: <20261015031804.2406055-2-portias@oss.tenstorrent.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|CH2PR04MB6789:EE_
x-ms-office365-filtering-correlation-id: 1ce02444-5303-44be-65e4-08df2d8cb528
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|7416014|376014|1800799024|23010399003|366016|10070799003|10067099003|18002099003|22082099003|11063799006|260925021911599003|260925021311599003|260925022911599003|261009223027099003|4143699003|38070700021|56012099006;
x-microsoft-antispam-message-info: 5wDwZUfWYGtDhzpo0L2pT3yghd+8etrS9FYvzSjwTW5LnYNxrkGBeJcjQubfezUsb8lEeVkWaVAuiIpKhTq8465S+QhNzJqO07xVKEUh00GOSCuJhKxIwhvsK4YsDO4PD/6LxBFKoa0DszAGXhYqR7yDIGoOHxfITOIEGXnDrXRz50RrhXXypaEc2SWrEh86pu+TEtE3LYmNp9Mk3BQNf3tvGM0xmtRP5IGrrrNBug+2Uus+nLeKRdrN9JV5jZkGQMxoR0bvul24sxazhiPHBTWpYG1z90TLSSFbqXRKDzPOZkEw1JKsPOC4rZlN8A7pp5G4FM23iRu2Eo3y5Hau9lR0ijUkqvF9A7PT7ZO0DBB0mvhlAwPHecAkSeoW5OVsk4dxzlfDZXLlBH3q0xfbocOTeB8lwai8gCYSZgQ1RiXyhfva7tonf3OTWSXwuuIxic75wAOGSGxAiiMDYC5jza3e8BobvgWly3ygqxIAlfn2aFPQWsTQ3WtK9urxH1V+vvujIUWvZ6FLidE3liuaXXalOgc8o7gnBq+Hc56cNZtEOrvJIZn7uqIR7laihkmY/hhVuLgyv6wgW45SDhVrwZ4lPamYKcXHTs/1hD9K5hJjGr5yWN/Ob1S6STHNgH3U8n5raupp3/+NOSYJ96XrCcOqiXY5HMZ6Kesxuc4SIgg1ZDLE4JjfPr4pd42c+jBfaQDJdkDOKj5YS2k9glqcuw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(23010399003)(366016)(10070799003)(10067099003)(18002099003)(22082099003)(11063799006)(260925021911599003)(260925021311599003)(260925022911599003)(261009223027099003)(4143699003)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUZheTRzbnZTdTZNcmtoT1hZOXRZOHZ4Q1UyUWVlOFp1WUljMmlOOVBZQ3FS?=
 =?utf-8?B?UFQzNXo2WERrczJEZ1hsWitralJ5eDU0L0hFbFVOK0ZaNTNSMXRvbGpxNTRZ?=
 =?utf-8?B?UTlIeFRKNW9oKyswNm9xWURua1lpTnRTbzgrL1hzMVhzZzBNUkYyTjNzSWlj?=
 =?utf-8?B?bTJJT3ZZVDlDY1Y0NEN3S1RKS0dhc2F3T1huZFJnc0hHMnE4MUpTWGZVT0lM?=
 =?utf-8?B?QW1ibnZzRGJRbTY3cFNENzYrMUxXZkJRY0NLQlNpZThydWlUV01HRVlFT216?=
 =?utf-8?B?dGphYUNWWm9jZTgycWI5K1VwZW53TDZJVGhwQmpGcnNkOWZzeGJsZlVhTU11?=
 =?utf-8?B?V0JPNTh2b216NEpNNzNoQkxJQ0ZNN0RzQUp3cEFwZzRPTHpicVdHZ1dCYzl3?=
 =?utf-8?B?aU1ISU4xSHlXYnFHN1dsd3lZMnBjMm1pUlZnUWU4QlpMRE1rRURSaStaRHVX?=
 =?utf-8?B?cVUzbXJvV1hxNHVnWENkWVZYMUlYK3drb2xuMzQ0WHdpWUF4SkJnbU1vd1gx?=
 =?utf-8?B?NDB4ZGltbU96c244cUdDc2gzOEMxNElDNlN3TEx1SGFwcW5HL2RQUTdtQWV0?=
 =?utf-8?B?TnYxNnNhdS93OEg2U1Q4eFJndktETXkzKzV3SXpiYlFvYmVwZzdvekR2MjlS?=
 =?utf-8?B?REtzdHV4MmtYaHRyL2l0aW1kbUxvcGlJQjBsY0d0WGNtdFlIY0c1MzVXYjI5?=
 =?utf-8?B?MzIzMUZxQzBOaEl1Q0hFY2o2aVk1dFp6NzMxRndlcWZFbFdvZVY5TG9LUHZQ?=
 =?utf-8?B?bnRmYWFWRW4xL3NCQlJ6blpjR29ZYVFEVlUxS3R2T0IxN2EyMFdhekRNMTRH?=
 =?utf-8?B?NXV4Qmp1RDdJWGFMem9mY3V4M21sQWRCSHBFRXgxeUtCSUovUnJlWU8vNzZC?=
 =?utf-8?B?NXdRWldLY0hXVUtmcjFFaUZkY0NoZVFTR0NhdzRzNHM2RWxidWE4TjE1UDNl?=
 =?utf-8?B?bllWWVdZWkNvY0ZSWXNUTGkrV0VIQ2tzUkNBaC9DY00wUDlKNDd5MUxWYjVU?=
 =?utf-8?B?TlpQWG1FeVlMUW50RFRQYjl6VDFtcmVEa2RPTTA4YVVFNGh2MnBsbXRsZjBi?=
 =?utf-8?B?Z0htVkpCSlozbEFDcE45UCtjR3h4Y0ViNGQ2dG1VV0ZFWXpEaU92L3NsbHhS?=
 =?utf-8?B?SjBYZDNmS3NJV01sUGR1S3FXNTJhZ3F5Skx6emRlMXlmeVA2YnRORHlZSTlU?=
 =?utf-8?B?WVYvbFM4Q1pWb3I1L2xTR1FDM2c4eURpYnZIeFZBcVFxWnV1Q1hiNjU3MG1K?=
 =?utf-8?B?L3BTTWtIYzIwbmUwNFNndW9KVFBWR0RWUW1haktTUjBNbzJBWm9ycWE3bHFy?=
 =?utf-8?B?cSswMk5KUEFodXBGdzluMVR3Tk1XaXNuV3M4YUJCNEdjNngybDFsZnNDSkhI?=
 =?utf-8?B?TVdvV3hUM2FROFVKVVNqa2lYV2lXYUI1TkZ5KzVqaFhVQm55b05pUW0wTk9E?=
 =?utf-8?B?QTRNQ3RYR3dCdklHVHBleWtMK2FsK2UrY2dZSjQ4TXBBU2NpL0wyNjB3eUdX?=
 =?utf-8?B?TWtWWlFDandEMUc5dDNPRUJKMjU0aXJBSTlMTys2anJESHN1ZW93VUxmUzAy?=
 =?utf-8?B?b09pTlJDaWFQRUVwL2xFYUJEdVp2OVhrdGxaNEs2ZTdrcWQ3aFVHamV4c0sz?=
 =?utf-8?B?OEg0UHl2YjluTUdxS052UjB3Ympoa0kvRWh1d1MzNFQ3OWNyUE5yNDNrQ291?=
 =?utf-8?B?M1V0S1BCL0xEOUlZQmxmdUxIVFRncHIwb1VkVEFyNWV6N0l0SXNhVndTa1Bs?=
 =?utf-8?B?QUtnTVJmWitpZVdjVjVPSlV3K0pUS1doeDVTMFgzWTEza2tUSzMxTjRKeng1?=
 =?utf-8?B?U3crN0UzRkllbXZrWlNmbS81MjZlMWZwd3hxdk5wUmNXSDR1SFNrZlhtT1BL?=
 =?utf-8?B?TFg4NkQ2dVUwUkZUYjNVNG9Za2VFOW5zZFF4L2FRSmNpaXllTkN6dHQvK3ZM?=
 =?utf-8?B?L3RzalFoNU8rYTBiMDFoSEdocU9XQlVaY0NTVGszWkRVeE5PS2xZcklvZGlZ?=
 =?utf-8?B?b0FVdi9zV2ZOYlVwdUowaFlXSHU2VHpBRGJ1U29aZVljZ0ZJQ3lXSC9rZUZT?=
 =?utf-8?B?QnI0ODk4QkZRVFZ0Q2J5azBiWXVhZTBMRytKN2N2cWNkZmpnbkVUczgyQVBo?=
 =?utf-8?B?Q3NNVlRrVTVLenl4eE1RTDVzbUloaUZpbTJlVWttaXlOV0w2MlV2bWJvaDBs?=
 =?utf-8?B?QXRKdHlUTG9tSG12eDNrUWY4M0xuaUdmbWhkMWdYRGxTeml4aGkrZitSd25u?=
 =?utf-8?B?VHRHTUlGWm1WcnhEOUk0ckplVmduR2ovdE5odXZKbUhQVlkxZ1dTaWRjcnQ3?=
 =?utf-8?B?cmliRi9xNDF6VDRSWDVhdURxenA4OVlkdEwrTWpPejM2U2tMQzNNc29Xbloy?=
 =?utf-8?Q?L+mQLmTow1Ppjb/fjMk8FuXd7T5r4iDASUWoxAhlyLAuP?=
x-ms-exchange-antispam-messagedata-1: S7PgFa5JTvrlzMha7+yjTXKCFUfrM0bw2hA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EAF1B40A0513D4D8C984B25CFEF28CE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kfsj4iiMB7mzP7pGG55ICi6cgPsI9mhOUGcPdmjnXBLOSOdUE3RpqciNKrBGfx+R9LPY12h9kXfGvFJVIg6NLcR2Mjc1lTA6arv116RVwY82RDD3hKZ9KtPPOd4Y8G0swbrQ1RHdsT+cZG094Fmbi11F41VZAig3wm/zvIe5RSxWtKzZsgAF75VSRxcxHP3U9M5cdfsES0eBypFDBrsASAsnsgR0FFx6wthHt4t+VYpoA9RQq7DORN6HnPxxuFM/TpbmwPn3jE+IS28Xcn3/HaTLSbVgvxPXk/0BLLrDVfA+S5VOC5YsMeYQznpeXpUgAU4/soqdlLYa5UFt4JGeDg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cbiFFfQa1b5TTnFYc22BrVVZtANDqu94Kp6VqgeHBjlKDy7bZRYz4HMWDuRqILHGnFD8F64NDBXoEFWFzCl2juJnJC9+qHAywWitOo0z6+V4GuDkqvNd8+ZhSy5yCMsNlobbNaq1Vzyf/B55i7Wfhro/jq71P6jgXGAc+1LDICz1RNBeb+eLF4f0qw7rJM7GCcnT9CdXDRKs2jrh/ehWsT3JLufo+CqYjX85kqHL6Wy6kAY4Lnl/HhHiuVap8gSU3ujaQFzn/zdd1id1+/lpM/mNt0evbDOfq0nqHNOa1XDwbnhZ2yErGv2MGTl+ynYKS/dLOJhBKkNcXl6eJb3cPyrA7dw8EMobY5WYfWQ1iy7RqU3BH4DB23YQSeip6CI3CO6JC6me9w20pYKULpLFYXpYz6xG67DWxIW7JQIKIO/REUn8Reci7P3hLZBtWnK8a+QOugYyK++QxGRul74RouGxqEes8/1I0nCwEOeLXk7Y+kIoNd6N61lDSlLOpBpupofKPKDfT4xcFZ3DHJ0OROCP07HTLeGxTid6gGMwtLtHXeuRgVFjvJ3m23xcH4yfg+sCk9/BU8coqs/J8CtR5hddImU4WHEMEwqvRrWprGZmUsojnoJqGG+RnU8UikIM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce02444-5303-44be-65e4-08df2d8cb528
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 02:57:26.7622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LKQR99W3jtQX06+FHM1GEHJAmO8hJ3N5C2nl13PFFcaN6A4XXuSqcbesotf3ouaeKheLS82zAw5bMHVJSvdWJub5qR82QzLq9g1KYcPMUk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6789
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=7454c2a62=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
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

T24gVGh1LCAyMDI2LTEwLTE1IGF0IDEzOjE3ICsxMDAwLCBQb3J0aWEgU3RlcGhlbnMgd3JvdGU6
DQo+IFRoZSBBdGxhbnRpcyBtYWNoaW5lIG9ubHkgc3VwcG9ydHMgc2V0dGluZyB0aGUgY3B1X3R5
cGUgdG8gYW4gQXNjYWxvbg0KPiBDUFUuIFNldCB0aGUgdmFsaWRfY3B1X3R5cGVzIHRvIHJlZmxl
Y3QgdGhpcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBvcnRpYSBTdGVwaGVucyA8cG9ydGlhc0Bv
c3MudGVuc3RvcnJlbnQuY29tPg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxp
c3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoGh3L3Jpc2N2
L3R0X2F0bGFudGlzLmMgfCA2ICsrKysrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlv
bnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9yaXNjdi90dF9hdGxhbnRpcy5jIGIvaHcvcmlz
Y3YvdHRfYXRsYW50aXMuYw0KPiBpbmRleCAzMTFkZTY0ZWRhLi5lYzUyZmFmMTdmIDEwMDY0NA0K
PiAtLS0gYS9ody9yaXNjdi90dF9hdGxhbnRpcy5jDQo+ICsrKyBiL2h3L3Jpc2N2L3R0X2F0bGFu
dGlzLmMNCj4gQEAgLTc2LDYgKzc2LDExIEBAIHN0YXRpYyBjb25zdCBNZW1NYXBFbnRyeSB0dF9h
dGxhbnRpc19tZW1tYXBbXSA9IHsNCj4gwqDCoMKgwqAgW1RUX0FUTF9ERFJfSEldID3CoMKgwqDC
oMKgwqDCoMKgwqAgeyAweDEwMDAwMDAwMCzCoCAweDEwMDAwMDAwMDAgfSwNCj4gwqB9Ow0KPiDC
oA0KPiArc3RhdGljIGNvbnN0IGNoYXIgKmNvbnN0IHR0X2F0bGFudGlzX3ZhbGlkX2NwdV90eXBl
c1tdID0gew0KPiArwqDCoMKgIFRZUEVfUklTQ1ZfQ1BVX1RUX0FTQ0FMT04sDQo+ICvCoMKgwqAg
TlVMTA0KPiArfTsNCj4gKw0KPiDCoHN0YXRpYyBJMkNCdXMgKmkyY19nZXRfYnVzKFRUQXRsYW50
aXNTb0NTdGF0ZSAqcywgdW5zaWduZWQgYnVzbnIpDQo+IMKgew0KPiDCoMKgwqDCoCBhc3NlcnQo
YnVzbnIgPCBUVF9BVExfTlVNX0kyQyk7DQo+IEBAIC03OTIsNiArNzk3LDcgQEAgc3RhdGljIHZv
aWQNCj4gdHRfYXRsYW50aXNfbWFjaGluZV9jbGFzc19pbml0KE9iamVjdENsYXNzICpvYywgY29u
c3Qgdm9pZCAqZGF0YSkNCj4gwqDCoMKgwqAgbWMtPmRlZmF1bHRfY3B1cyA9IDg7DQo+IMKgwqDC
oMKgIG1jLT5kZWZhdWx0X3JhbV9zaXplID0gNCAqIEdpQjsNCj4gwqDCoMKgwqAgbWMtPmRlZmF1
bHRfY3B1X3R5cGUgPSBUWVBFX1JJU0NWX0NQVV9UVF9BU0NBTE9OOw0KPiArwqDCoMKgIG1jLT52
YWxpZF9jcHVfdHlwZXMgPSB0dF9hdGxhbnRpc192YWxpZF9jcHVfdHlwZXM7DQo+IMKgwqDCoMKg
IG1jLT5ibG9ja19kZWZhdWx0X3R5cGUgPSBJRl9WSVJUSU87DQo+IMKgwqDCoMKgIG1jLT5ub19j
ZHJvbSA9IDE7DQo+IMKgwqDCoMKgIG1jLT5kZWZhdWx0X3JhbV9pZCA9ICJ0dF9hdGxhbnRpcy5y
YW0iOw0K

