Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7C3C61DC4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 01:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzlWT-000768-J8; Thu, 27 Aug 2026 21:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6935b7a9c=Alistair.Francis@wdc.com>)
 id 1wzlWS-00075o-QZ; Thu, 27 Aug 2026 21:36:48 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6935b7a9c=Alistair.Francis@wdc.com>)
 id 1wzlWR-00036e-65; Thu, 27 Aug 2026 21:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1787881011; x=1819417011;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ujcuRHgdmsK0A6wLpQM8lji7FIX/wosgeh8HJhE5Mi0=;
 b=ll8tC9B7ZhKghvbADYvUAHB4UbPU3efcQ5BTAIH3kzHW7f3JTDgQzEts
 9qrfYfPpynxN7C1BWie/fdHwwywg5aBLLuLBzqfOkSjcTMUEzGhZKvCQe
 ywZ48HH4pRorykpLGeKmFwSDmOG7WCEAvnjVvmeriN1N494KjJatmlx8G
 VjsBgHaX6p0rGk1NeUwl8I0XAKRUdWyreM4gsLHhWQajlD1du0d1joNQo
 drtSx3hg9hrpAgePy1045FA8G+YfVq4vVH+GOwD0lcvrVZ2JwKT/qg+V6
 3WDjOSJCqE1Z82CaeTgIO1c4CYAhtUqJlQxmHotj+5JZppZPih0lU1juR g==;
X-CSE-ConnectionGUID: mY1m2/TfT+eYKJTSBV7sWA==
X-CSE-MsgGUID: YBzUXSX3ThWvuhSAvpWzGw==
X-IronPort-AV: E=Sophos;i="6.25,247,1779120000"; d="scan'208";a="150226700"
Received: from mail-northcentralusazon11010024.outbound.protection.outlook.com
 (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.24])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Aug 2026 09:36:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHjxc31R1tf0dPe0xPMk6fgGBW/SEudWsjzpDNqUotOsPSjp41ofDk6VrqhYMwwNxgXBQR5WTWUKm0WlE2qZVYd+4a4YK531A5/waKWBKZLZgqlpF3Wi2/DoSz7mhhUpX6Yms+/Sb90ePNcJ3zy2QcAFL161iiJENN3ur5lvPIgqbtjT/cUraz4w1aujXVaFAR3vtSLAs3KJLMgB6TcnKGDfm+7Zmgh1RHy5SnkldWtf9nechiyEQRkPmqrxWJGCPlQJ2aO4zLQu/ytRextj270r+SbrINfIoZSgJWe5tD3X3qbRq7gnZ3Qqbran6sfgbMO57DSz6iI/3Tf0A2ahhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujcuRHgdmsK0A6wLpQM8lji7FIX/wosgeh8HJhE5Mi0=;
 b=GpmnKZ2ipos4yZRNRF4pppK3X5rvcoIjrcP8jWvDz8J6L7e8XIZYIBjfxaFOwTVe0YJn9046Noq8W2FEYfhGt+L+hNVMW33ebWZukZnGjf6xVuPob+GOVzjf/oxvxp9CXdSrtt35Ozc8uSQoLKWlZyY7lLZCTXU4G+HkVou9mzFr02jcBCPi5BaxN/8Df2kjpiEpMU3fTcxPESq1Chobjjg3mn9rYQZs465SjWcZypYpIhpE4cUtnSXBarfbM7/99QcU3bXiPCvyJFnfWgrrIITU7FlmV68bFlHFWS/0f+85mbmOfVHQ9FYrn2gzvdEQWiMyAYaDqqtEI7TxcCPVtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujcuRHgdmsK0A6wLpQM8lji7FIX/wosgeh8HJhE5Mi0=;
 b=lf1Uv+L3q0pvhIawROg1uevZtIHtX47s4tj07vkHf19eqC3HcTU7qTZRrOHC6BGZn1h0RewKAIeXCLwvWUXpEFiKMxlcAvWedMYT3YAgU3xIqLboZGJ9DYglCYWLHKAclQ144eL9/z8sdt3wrAJwYpT2AF18yAly6BvS5oTCu/k=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by BN8PR04MB6307.namprd04.prod.outlook.com (2603:10b6:408:d5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Fri, 28 Aug
 2026 01:36:41 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 01:36:41 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "alistair23@gmail.com" <alistair23@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
CC: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "xb@ultrarisc.com" <xb@ultrarisc.com>
Subject: Re: [PULL v2 11/96] target/riscv/kvm: Synchronize privilege mode
Thread-Topic: [PULL v2 11/96] target/riscv/kvm: Synchronize privilege mode
Thread-Index: AQHdM4xBSVTDQvYRM0WEE6CY/dh82raytDqA
Date: Fri, 28 Aug 2026 01:36:36 +0000
Message-ID: <a1e8fe2db1bdc696d1adda7ee9d8c5a0bbf3354d.camel@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
 <20260824054806.2790041-12-alistair.francis@wdc.com>
In-Reply-To: <20260824054806.2790041-12-alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|BN8PR04MB6307:EE_
x-ms-office365-filtering-correlation-id: bcf97747-ef7f-4618-03a0-08df04a4cf82
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|10070799003|376014|366016|1800799024|56012099006|10067099003|22082099003|18002099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: gAwUsTcnmUa6654YqGxkaE9JpnTO5ZQ4ZuGgzRrUkPU19MDef26MElYuEEiTHee7obmGGn2CBiH22Kkz8kYU9snKQPxQKvDJtf1vabg+9Z1ezMN9ZGLQNvNeT2ZQf/8n2pSLFe4CbTzWixyEfkpERCTor7wkEQJWTQR0R+VPHs07yfnj8x+qVYFAarQ6r8Cwbb/+WYo+CsrbQcBN9lGK8ZAwZBBGXvrtGVvs+S2EeLhUZoZqsvDgaGkYi/BTWWlbPkNZKGLqAzhQ+VrgBhNru6A/eeSUUbeCT7WW2/o7iilJi+jMO5oVjXmquvBgNE3dUaqhFAEEzSoEltefAgwhgUK8jToqZsjvSrjS/3XaE+oDgoVXWnlCuQcoLJVvf5AI0Y/ILAylp+utz9DDmOWe/HNyLEiRa84WkhWqLhnELJFFRhiPo2KPD3gH3ffogUubA2NvTLH8wYRSfd708ryj+rD8py+vao+GlBgthypaVynhI2oB8jvQ0o1cvVp6B7bXG/jAjcJpbAjaXvLtpaJTJeGX0V/BWMelQsqToYlgw/sxn6bq6WJN2eg4AssMv+heaRjIWRlSWKUqlSVym7P3aWvq6Imm1P/XXBe0Y1dHQrBGbYXBY7fNddaJCQUIt9UeTtXWtmIdDeZm+LJxdiYQUZXJvT63OknIzKP31fOd/sZLqXS5iBDECGkYw1i161SxhSRJMV3G3tUVmfDpPRU9kZot0F1gWj3hbVcXrOKOFPg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(10070799003)(376014)(366016)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjhhZ2x0cUxJRHZsKy85UmlsL2pPRUtCY0xWQmtOWXVIZDB5SUtVQ3E0YWd2?=
 =?utf-8?B?UzJFSjIraWZIZUxkOUh5ek5zTGJoZDJpRGRtYm5PUFNBa2lHYU9UaUpMbG0z?=
 =?utf-8?B?NXFwWU5qWitHR3ZYREdqQkFBU2lGK0EzcW0wNDRKS2ZhWVlDc1ZFUGFBdHdV?=
 =?utf-8?B?WGd1QlJRdVo5d20ycElEL2VIZlc2YlcvVDAxb3RvekFpSFVYcXNzOU4xQ1JS?=
 =?utf-8?B?TVJ5MXVvWWlGMWczUDNpT0lxL3djZlNYOXJQZnhIajVnTE5sZ1J5aDNZTG9T?=
 =?utf-8?B?a21EZ3J0UDIxK25rVGo5djVQQVV4cmliNjZ2dklFLzAyMGU3cmhZSTVVR1p2?=
 =?utf-8?B?aE5zVTc2OUcwYkJmQzR6bTFncFlMajNISjhqQlRmTzkvU2cybkcrU3VOUHI5?=
 =?utf-8?B?Qmk2WXp1eS9HNHVXR3lIdmNGL3BZa0RkMS84akNZQ0k1OUk1Rk15S1g2RG1y?=
 =?utf-8?B?SDVadHNsSS85bklyaWhmQ2o3OUc2UmwyTWJaQjlQU1hxMEFZbkxFcjQzVDF6?=
 =?utf-8?B?NVJZdWpZWGRuN3d6YzVublhqVnRZOFUrYXM4NHVmS0tJSE5ldVArYlB6SEdM?=
 =?utf-8?B?Zi9jUlZROUw3WjZTWW0wWHVPWmpQUUdBN2V5WVhxL3E0WjRRYStLd0dmbWxy?=
 =?utf-8?B?YVZZM1I2anpkV2V1QkROTG5ObVAvdC9HZ1lqWXVyVGNMZEpTSjhieE1aekdI?=
 =?utf-8?B?cW9ZVEhKYTIycWllWmdZL1Q4dG5PTjVmUDY4S1duR05ZTEVpSTlwd3VrR0Uv?=
 =?utf-8?B?cGpRRk03Z2t4M3QzQ2FlSWpOSjc0eTBhZXdRS0J6UjNXNXpoYjNJTk0xWXNF?=
 =?utf-8?B?a0IwdjhZNms4Tk9BU0hoTEhqRTdsREVxaFhTWDBqY0w2SkJYV3hQcUo2OGFt?=
 =?utf-8?B?RFJYVFkyT0V4MWZ3a2FWZzNkUzZNcWNVWG1ob2V2K1ByNzZNQmxaVjBjSWMv?=
 =?utf-8?B?M2tIYlVPM1c0RnlHQzdYWE05QmdrSllyWFRVQW1ZcXNFSFZEd1hmZWFpT3FJ?=
 =?utf-8?B?b3E4MmdwaEliVUhRN3hvc2k0ZVVYMlJ1eExpazdsbXFVOXlNQ0FYSWpURm9J?=
 =?utf-8?B?K05wR2FYWGozd2Mwc3JaNlRZMU1UQklpYWw4UTRJdEVsMVNTeFFSVHBqRTg5?=
 =?utf-8?B?dTFXMEFFVmtLM3JpOGpJZUlHWjYrRmt0a3ZxQTFJenk5UDluUGUySE9HYkhD?=
 =?utf-8?B?bHRIcHlhWUZMVERGVjdkTjdSam1IREFFeS9LZ3psOFFCeityS3pubmF4Uk5k?=
 =?utf-8?B?OVcwbitjeUdqcjA0VmJJTHZyM1BpajBnVEFybnN5THVaWnh5cGdDSVR2YWZ1?=
 =?utf-8?B?TXpXRUZiQ3czWHQ3cHA3TnN6aVVCQW5oVllwTjdFcjlhZ0dUQjY2OTk2MEVQ?=
 =?utf-8?B?V3pLNFRrREcwQ0xIcTFmSzJDbmQ4TXpqM0grRHNpWE9WS3kycmpnYVpraER1?=
 =?utf-8?B?cDlWeVljczNTV292RHUzMTlWcS95YU9EMkY5cUM0SnYwS1BvbnQ2YkEzdVlI?=
 =?utf-8?B?ekVMU2lzaDNNS1Uxc2pWQTZlVE45WEI5Y2IwWkFBTUpWOEhNK0t6NHAzZmNo?=
 =?utf-8?B?RzdCYWNxTWRZeWlLd1dBaU1tT2d4dVNWak5GaWp3eGhqYjVxVHV5SVZHTXBm?=
 =?utf-8?B?ZjlWU2krdmJsbGl2dnBDSisxajh2VHJ5eXNkaU1jeGE3WGkwcXFjMlExMkVF?=
 =?utf-8?B?eWFxSmowZG1IYTVaK0J5Y2luRXU1VDFuMnR2Q2JScmJDM3JTQ3dSYVQwMGU1?=
 =?utf-8?B?RUw2QlpGbjRST0JFbWVvQ0xEK3hLclFwRTNXNGlKMHc3VXJjVFFSUWU4Y1FK?=
 =?utf-8?B?aVRzZEkzTEhxdkN0cEdyUjc3MG82ZU1BNkJock93Y1FnNnZhQVVwS09BbGp2?=
 =?utf-8?B?bkwzY1VZVk4xd1pVMjZCWTl4bnE3eDB2c3ZrQlBXcUdYQXZNWE5weUlxbUJr?=
 =?utf-8?B?NmtlM1laRG1COVlad1JpVzJ4aDBjWmhycmV0Sk1BQm1zWjhWV2lyMFBjYzRW?=
 =?utf-8?B?UUZleW5hYitrcGVValduK1FlVWc5YlVsQkFlTFBMbkJBTWoyNzZXY3FpUGs5?=
 =?utf-8?B?RVVNKzF0MVB6SnJ5QjZNbDFwZXU0MFI5bjNYUDhoUzlyVW1oczhXQWhJUHVr?=
 =?utf-8?B?cWhlMU9EbDNvQzBORE1qellqempCK3hRWThaeWNvZFg2Qk5wMjlsL1FaOVQw?=
 =?utf-8?B?NTcwMDRQckorQkhXODhqRytYMW5JT1ZVRzkySWxRc2FDbzE0cVdmS0FIcHJN?=
 =?utf-8?B?N242ZC9JRURWN3NGY2phdW4xYzFTeDVvR2JkcHFXbnp0SHhPcm1YaG9zcnBC?=
 =?utf-8?B?dUVITVRPbENqL25rUkx1bDE1SXNBQ0hVQWNUSlI1ckhHQTdEUFZPUUlWMFRB?=
 =?utf-8?Q?Xay3C7bF8OaWT3BVVKIEiDleISKbqRsiS5A3pNLoD316y?=
x-ms-exchange-antispam-messagedata-1: k1QujpC/7X7kTicCPyvtfLUj/nlAJOD+dEs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11881E970756444584E1E634D0FD47BD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jno/PPqv2hgJm92I2Um9ws3AkaTVgYMiY4CUzV/jRNO6vXQVU59SNDT/6KHi+9hBLBw4O6hHomgUf9qpYXTul0X0ra2iuzTxPS6Q3B9SejB1lFs+wsxlhUXk9xXQ/XI5HiO1q/6KBDNlZlZj6ryVfE0g3MaU+i+H/i5qkC7zUq5hneJJRD53+5yAGbUnr0+nELRlEhM8xzmWjiPj4BDNavDwPz+M0ua00hAjO3ka8JA2yOhoBPaR4cjd2z2Ck1GrPECQ6qkFkTiXledTjnH3sHo+pGIYZ5EHXka+bNkZa73Ahe6qTMJ02sb0IczMLjfJrHJRK9tiAjZj64erMb/A7g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3Sp82bjQwRTTC7XSiJdL1A82mErsHj90NIpw352HKjLVho9I/Cg6UUiUK4kDs03embIF+FSa0MB6vlKzh0BxOMq0hYKr5W0G6P//PG0g+zXbaCTlmrim39E+xbHBYH2uhW3d19oXYnSB4pOC4fHLXnf1qp8rPDu2rjzUGI6H6gac3BiWpQ6qoUNQVQ3epkpn1icYkK5uYk35WEBdxW2ZlN5Zlj9eCbtIigO8K7mQnrFqD7hmUgi+Sl4UQgwTP5/rrEmyDZEip4KFvZPqf2QZZR+gM8xfM0ta366FdaZo0+0U5YZlKSDV4GFQaYWT6sO+9HUHgjGcnbzXVbukZp6Rk4uc4QiR7lxidI/zwhnQAxCo0l8YYiXKjeQeagvi6x7h0ue+Jj8qxlj7REFcQ7xSzmzund4KUhUBSNQ3ZNh/2IoO8vsk5d1Zc2VfeM4brbfUk9lwTXwBbX+sGHr463hv9Tlun8OHWYhJp5FftVKmxVaqLGhXfh9QIkGLlibvr27U0FfunQxc3EpybK8tMbLA/CwXLcvn7Lk2xZBJRhwuiMN91lMhwNd61KXH5FfanJS+yMIyUU9S2iIreh+X7buEssZ+5dDEnpD068T9+MNqw4S5v8YkyeLyCazYS8ebaEo7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf97747-ef7f-4618-03a0-08df04a4cf82
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 01:36:36.2194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RMnmWFzTGDYvYj4nLD1GMmziAgCoS+GU3nsFw06hc9vBZ9UVvAlL8Fnzrb7mmEv/j587gSds6eqOD7nZWIrcTBpgk2ZEqwPOVkND9edzy6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6307
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=6935b7a9c=Alistair.Francis@wdc.com;
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

T24gTW9uLCAyMDI2LTA4LTI0IGF0IDE1OjQ2ICsxMDAwLCBhbGlzdGFpcjIzQGdtYWlsLmNvbSB3
cm90ZToNCj4gRnJvbTogWGllIEJvIDx4YkB1bHRyYXJpc2MuY29tPg0KPiANCj4gVGhlIEtWTSBj
b3JlIHJlZ2lzdGVyIHN5bmNocm9uaXphdGlvbiBjdXJyZW50bHkgb21pdHMgdGhlIHZDUFUNCj4g
cHJpdmlsZWdlDQo+IG1vZGUuIEFzIGEgcmVzdWx0LCBlbnYucHJpdiBjYW4gYmUgc3RhbGUgd2hl
biB0aGUgbWlncmF0aW9uIHN0cmVhbSBpcw0KPiBzYXZlZA0KPiBhbmQgdGhlIGRlc3RpbmF0aW9u
IGNhbiByZXN0b3JlIHRoZSB2Q1BVIGluIHRoZSB3cm9uZyBtb2RlLg0KPiANCj4gUmVhZCBhbmQg
d3JpdGUgdGhlIEtWTSBjb3JlIG1vZGUgcmVnaXN0ZXIgdG9nZXRoZXIgd2l0aCB0aGUgb3RoZXIN
Cj4gY29yZQ0KPiByZWdpc3RlcnMuIFRoZSBnZW5lcmljIFJJU0MtViBDUFUgVk1TdGF0ZSBhbHJl
YWR5IGNhcnJpZXMgZW52LnByaXYsDQo+IHNvIG5vDQo+IG1pZ3JhdGlvbiBmb3JtYXQgY2hhbmdl
IGlzIHJlcXVpcmVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWGllIEJvIDx4YkB1bHRyYXJpc2Mu
Y29tPg0KPiBSZXZpZXdlZC1ieTogRGFuaWVsIEhlbnJpcXVlIEJhcmJvemENCj4gPGRhbmllbC5i
YXJib3phQG9zcy5xdWFsY29tbS5jb20+DQo+IE1lc3NhZ2UtSUQ6IDwyMDI2MDgwODEyNTE1Ny4x
MjIwNTExLTIteGJAdWx0cmFyaXNjLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQWxpc3RhaXIgRnJh
bmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpDYzogcWVtdS1zdGFibGVAbm9uZ251
Lm9yZw0KDQpDYW4gdGhpcyBiZSBiYWNrcG9ydGVkIHBsZWFzZT8NCg0KQWxpc3RhaXINCg0KPiAt
LS0NCj4gwqB0YXJnZXQvcmlzY3Yva3ZtL2t2bS1jcHUuYyB8IDEyICsrKysrKysrKysrKw0KPiDC
oDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFy
Z2V0L3Jpc2N2L2t2bS9rdm0tY3B1LmMgYi90YXJnZXQvcmlzY3Yva3ZtL2t2bS1jcHUuYw0KPiBp
bmRleCA5NzA2OWJmNTk3Li5mNmRkZDBkYjliIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3Yv
a3ZtL2t2bS1jcHUuYw0KPiArKysgYi90YXJnZXQvcmlzY3Yva3ZtL2t2bS1jcHUuYw0KPiBAQCAt
NjAzLDYgKzYwMywxMiBAQCBzdGF0aWMgaW50IGt2bV9yaXNjdl9nZXRfcmVnc19jb3JlKENQVVN0
YXRlICpjcykNCj4gwqDCoMKgwqAgfQ0KPiDCoMKgwqDCoCBlbnYtPnBjID0gcmVnOw0KPiDCoA0K
PiArwqDCoMKgIHJldCA9IGt2bV9nZXRfb25lX3JlZyhjcywgUklTQ1ZfQ09SRV9SRUcobW9kZSks
ICZyZWcpOw0KPiArwqDCoMKgIGlmIChyZXQpIHsNCj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBy
ZXQ7DQo+ICvCoMKgwqAgfQ0KPiArwqDCoMKgIGVudi0+cHJpdiA9IHJlZzsNCj4gKw0KPiDCoMKg
wqDCoCBmb3IgKGkgPSAxOyBpIDwgMzI7IGkrKykgew0KPiDCoMKgwqDCoMKgwqDCoMKgIHVpbnQ2
NF90IGlkID0gS1ZNX1JJU0NWX1JFR19JRF9VTE9ORyhLVk1fUkVHX1JJU0NWX0NPUkUsIGkpOw0K
PiDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IGt2bV9nZXRfb25lX3JlZyhjcywgaWQsICZyZWcpOw0K
PiBAQCAtNjI4LDYgKzYzNCwxMiBAQCBzdGF0aWMgaW50IGt2bV9yaXNjdl9wdXRfcmVnc19jb3Jl
KENQVVN0YXRlICpjcykNCj4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Ow0KPiDCoMKgwqDC
oCB9DQo+IMKgDQo+ICvCoMKgwqAgcmVnID0gZW52LT5wcml2Ow0KPiArwqDCoMKgIHJldCA9IGt2
bV9zZXRfb25lX3JlZyhjcywgUklTQ1ZfQ09SRV9SRUcobW9kZSksICZyZWcpOw0KPiArwqDCoMKg
IGlmIChyZXQpIHsNCj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+ICvCoMKgwqAgfQ0K
PiArDQo+IMKgwqDCoMKgIGZvciAoaSA9IDE7IGkgPCAzMjsgaSsrKSB7DQo+IMKgwqDCoMKgwqDC
oMKgwqAgdWludDY0X3QgaWQgPSBLVk1fUklTQ1ZfUkVHX0lEX1VMT05HKEtWTV9SRUdfUklTQ1Zf
Q09SRSwgaSk7DQo+IMKgwqDCoMKgwqDCoMKgwqAgcmVnID0gZW52LT5ncHJbaV07DQo=

