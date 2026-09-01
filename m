Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41821C61DE4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 05:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1H6n-0005kh-Cb; Tue, 01 Sep 2026 01:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6977d653a=Alistair.Francis@wdc.com>)
 id 1x1H6l-0005k8-95; Tue, 01 Sep 2026 01:32:31 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6977d653a=Alistair.Francis@wdc.com>)
 id 1x1H6j-0007gT-A9; Tue, 01 Sep 2026 01:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788240749; x=1819776749;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=udAB3Emw3mBvsYH0w4vykVU/enVVfyPL8LJKYBz93+8=;
 b=qYCvloWxR6ZF5xFC8B8aWTPnmOyWwprytPCZTcToTlx703NrE31cWgp1
 5oV6Ey7knZKKLkUkztXDnS+wk2sx9Cbw9Ra3yuokgncv+tizSxWvn4XiG
 T7THiK5dO6XstP7vc5eRcV0P9DagRkNXa7tasDS3xZpleGvNHRdo9VWK8
 zuVe6deH/awDJHeHJkY+oclodU7qL9dgmh+qqvOKFZ7lj63bAU3kVhvE4
 afK9fQtLOINMGZz/TEloxpPvAOULrZL/Y1/9lQVjct/tO7OsmCYytLwvR
 OLabC5+kSfeMItKhTmbV1CJA3k3zRKdRQzM4wycFNt/6DR9Ja4nC/12Jb Q==;
X-CSE-ConnectionGUID: vlTjUWUxSrK1nJCeuIkmvQ==
X-CSE-MsgGUID: kjIRMkFeQ2K6PKcdJx7iaw==
X-IronPort-AV: E=Sophos;i="6.25,255,1779120000"; d="scan'208";a="155594604"
Received: from mail-westcentralusazon11010067.outbound.protection.outlook.com
 (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.67])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Sep 2026 13:32:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llmAo+2Rj0YNqRfMhQkhJtMKyyoGytjgc+X+vCK3RGPsXUKxSTR9qaESGtfHt4TZPVUM1YKSIp0yHjTbdOhysbJNJLVY7Prnx0TtzdrYr0q2mcQEYck5EAKN/sdG2Aa5A2AmKhwUD9qd3+KU4lm7vzpvAzwywI8ExUQhVCbp6Uioy0lmLyqNbTbdV7bcXwH8Fm2+Vg9raDqbUVQgbVVEDBeIdyyP1gEbQuksO+9j7yF/Hpa7g7dcGxFSz6QMJ5n/7j1nSaNPjSsvWvpC20vRGlURLMc4I5hgBOg9CfkCznyRJAjA7it8BcPbwzpA8VxyRTX3r7YMasU9IG+dKegcZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udAB3Emw3mBvsYH0w4vykVU/enVVfyPL8LJKYBz93+8=;
 b=tt1Yf1a3t1q4sGXWgLHkBgPt5KLIvIGmXTfTCQgFLlEgmywXv0+dRKh8c4wkeB+elQzxu3WEF4bv3jBANBWTsyERrwSGkc0i229F1lqrw0yHJF6mSeXGmkssk584ad6Yjrzd70/cqKeDloUlF6K0x12ENPEx9kLWdxmuB8b2LePrV+knSBdGhfhdBC41ELVlM6jmHOCBDsOKfMeTtj4ZVNOz/IlJIR0V1WXoWj4Q/dHWzg79dzbQykS90EkKxES9YasdWzkKTsNHBIVfwn5rzw0pOLydf33eAKy4hyPk1ErRJRNitCXoOkms+IM+wq1Jy9ul0W7hZVfFmGw8cP3c6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udAB3Emw3mBvsYH0w4vykVU/enVVfyPL8LJKYBz93+8=;
 b=y3fkAnL1GUhkQlpjtGb8GpheXvag6jea0PdrLCgOlnwHRxYzVLKyH6MeIx8xrdnAEfvNENMQ7J8C7hpy0RxyZyrnhILhySB/UhM96qRXl2kS+3k6pBiG4KFcCR5fveen2NdbZCX4QViovWM5d0vjOPDc32kfnFVXrAp/v2JAE10=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by PH0PR04MB7302.namprd04.prod.outlook.com (2603:10b6:510:1d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 05:32:23 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 05:32:23 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "mjt@tls.msk.ru"
 <mjt@tls.msk.ru>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "laurent@vivier.eu" <laurent@vivier.eu>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v5 00/15] hw/riscv: trivial code dup work
 (riscv-server-ref prep)
Thread-Topic: [PATCH v5 00/15] hw/riscv: trivial code dup work
 (riscv-server-ref prep)
Thread-Index: AQHdNy1V/2XxBALB90aPmTi8n8f1Lba5OCqA
Date: Tue, 1 Sep 2026 05:32:23 +0000
Message-ID: <b7aea9677520072668b4da5b0232e73193baa340.camel@wdc.com>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|PH0PR04MB7302:EE_
x-ms-office365-filtering-correlation-id: 003c3623-6c8b-40f9-8896-08df07ea6659
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|19092799006|10070799003|366016|38070700021|10067099003|5023799004|11063799006|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: XLS588jRjZPZ8qMbHjdu+mEPS6B5IgMkpqQyBevi1kwCNTHIRenaNh3Vmw65EqLuvuqk3gQ6R/hoWoS+u4tynbdZYmzWCkfvbjU/N8IAvXcXII8Mos01iNQz5KUq0ke+o4yHyDIh4pDG0fa2cumdVz9HY/GsTNcVS/rds7BcezrNmBrkoGE/9ulVTEWx6Kzfq6qkzfVLD95e4/D47gHoXF1DXNyPbM+d7XvwiUs4myZDnREjAxqtEoss/yPL0D8hSw1IUglRSlb6oDgslv2OMmBC4j1WZeemt/KiSnhOJVWvcPcYqMPNgoBVMxqBEIQxDkw9WP3Ixu9+kOsEv6iEULAn8OMOHM64HIR5+1BuljzxadxcJOE8FN9iXeCdg1PZEHCBpKgwHG3mDYzpdtWjzK/uX+UShx5ZhDzoAm5xxgKiSVtLtDfTgRJnAPIA+TOe+5nzLmazwQBZDUL6rlct0T+Y13db1uYL0wLVGTYm7gtMNtsfk4kHX0g5BUDyWHo6Yfvr1gSduPqkPp9oaXjHX+NJjgd3Xc/hQxG7k2gCdEf6sHGOKslCvc2C1mzMRFTamHspOXKSoSp3DvkCLdGr5Lta1ujLxOIWuKgzCdtYHDMvXfXHjIpewfzeJUO/yyXwJLqklq3TTUxm6GfCr/yebk/x2WP5CDblSmFGEyRHyvmbwUHxDEoMYoGLi3YTyYCicbXx1dINf0G1Hbsb3wJ5RZmCXRevFnNDe0s1tRBTtww=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(19092799006)(10070799003)(366016)(38070700021)(10067099003)(5023799004)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0JnckVad29vMEFkemhCdDdoaDh1cVZlZFFyYkRPUzdKSDVrd0FVQnpjWkZh?=
 =?utf-8?B?cmdJT0ZiZW9keGZUQm5TWkZiNE9pbGZJMlJNWUJkdU1DeVpEZ2tNZmNKZmxl?=
 =?utf-8?B?VWttZksyT2ZVSXZYNThaNEtSQ0Q2SGUrdnhVeXA5UmV0OFNvd0xHTlkvSnhL?=
 =?utf-8?B?emFZNzBFa2JkVlM1UTRQMFZQelhBUzlPUzNIN0J2QkE1Z0RpVzFhVnBCZ1pD?=
 =?utf-8?B?bmRVeUtRelorVi9WMFhLelk2aVlsWW9aKzZWTmhMVEJVUzB6NDlDeG1Jb1hw?=
 =?utf-8?B?VkYveW9sZVdET3FlV2V3UEVVTzVjeVhLRExiU2NnNTNmUEI2T1lQYW8rYmxu?=
 =?utf-8?B?eWRsZHY0bzdOakpGclRsS3prbndwOU00dWpodEJxVkxudEVWV0tUamdtU2xY?=
 =?utf-8?B?RUkxQmRLeFlGY2R6WUZac3FmR0g4ZElObk9ndGhEQXo5LzFQc2RwZ3c4UzFt?=
 =?utf-8?B?WTBmdFEzaWVRalNzRk1oQUxuaFQzYW85cHVYc202RGRuMTVUWWNUYjFCR2dy?=
 =?utf-8?B?Y3p3b3dpSDBuSklYYlRQZzlvaFRDdVZ5cC9ZK3lOQmRYbTJYeEV1amlmcTZy?=
 =?utf-8?B?M21VdU9jSC9zSW1SK1dKUU4yKzdOUXplamkxbjVVZ1cyQVFXUGgwYWpWcDNo?=
 =?utf-8?B?MVkxNUlqTVBGdnFWaHZJeUlMMndFeENBemsxMEo3RmZCYzRGN3dYeGtIRkVq?=
 =?utf-8?B?Y3dsMW1FamJSSkcyVXRYK3h5eGVVbXE5MFFzeDRzSlhPeER2VW12YzdiRytF?=
 =?utf-8?B?b29RekczeFhseHNjMjV5ekZQUk8xUHZsaHA4V2pVNFd5dFRNSnNLZjFEN0o1?=
 =?utf-8?B?MEhZVHdJZWhYdVBoenl3WHhtNlA1bTdnRU1aT0JtSmJnRFJZdzVJR3N2ZWpF?=
 =?utf-8?B?NDFFVzkrU2U5eFNEQy9wQVUrZG53NTZqd1NXSEhyd3lLM2h4UHFmb0phZ2xG?=
 =?utf-8?B?OVhVUWQ4TWpteFdyY2hXTlAwUTAwaFF1VVlORldyRDV2RFdqTmwzVmF0WlZu?=
 =?utf-8?B?ZTlCY2xvS3pzNmRRMG1RRWZKS0V0SVdGamlBRnZNRE9mOFFRbWE5R2NVdElN?=
 =?utf-8?B?QVFreXlGbTdtQkxYNXNrRHQ3VFhONmEzTXhhaU5nN1VZUTd1N2ZMQ3UzOFhl?=
 =?utf-8?B?bzI4cWZwelIvT0sxWWlDL1ozajlvUXhmUkpWM2hneVBuWTJKOXNNaHRxWjJh?=
 =?utf-8?B?czlCTWFRWFllVGpDWlF4YVNCOW1EbGJFYVdqbktaMTlGUGhpS291N1RkRFAr?=
 =?utf-8?B?L25oTmZYc1pRdGtueGZPaGFVL2xockFvUFQ3NERhWDc4N1lvSWVkTmR3bHM1?=
 =?utf-8?B?MEVVS2pjZ0l6WmkreHBzK210NS9lL0xyZmJqOW5qeTlDZEpxazU1Y2pNTDVx?=
 =?utf-8?B?Sml5blYrdXdSQmxSRStveHBIZC9FQ0ZJd3dNOWw0eWhkdk9tZGJ2eTQvUnQz?=
 =?utf-8?B?bEpzVldpSTY4eTVvaEVuejlkMU1YTWxDeSsrSUNwajRCWDgwaXBvZ0tCQ3p6?=
 =?utf-8?B?VGJxOE5VK0w2NUoyZEk0bzJSTWRJYittY2R4ZUFmSmM2TXZNSlJpcWE4cmpu?=
 =?utf-8?B?NVREaE9tbWRhM2dnQWVhdzVmTThVNEJBYnMwazRJbnNIM2lmSjRZdXZjQStR?=
 =?utf-8?B?NXNDQW5PRm9GU1FzKzVjUlhHMHQ4QVNtRTlZQURBNzd5RXlaWHJWN3VDT3Bn?=
 =?utf-8?B?cytHdThpNU4rQVJEL2d6SEJpR3c2TWVxemV0ajZoOE43WFhNT1NZcndFNmVj?=
 =?utf-8?B?WWo5dmRjeURWUnNuMjVvNDJGZjRFVGpMMFA5cEVLTDdBKzJDN2NCa0VDN01K?=
 =?utf-8?B?aUxSWjlscittUTY2ekcxcG5icithUDVXc2Y4bnY3b3Z4ck1oYWFnZ01oOEsv?=
 =?utf-8?B?MGhYSkl2NituUFBlZTJjNUV5eWx2WVg5YVFjc2UrRy9vR0tRQUsyL0tqQXdr?=
 =?utf-8?B?YzVSVnRPcmxBYkV1cHNrcHlTZ1NOeWVTazF6VFE0aTZTY3ZKeVY4aUVXZ1Ur?=
 =?utf-8?B?M2dnTGdvUU1qaEhCcFVtZVVMdGF6YkwrWkkxcUQ2V2NlTGNWbXhaaGpyejQ1?=
 =?utf-8?B?VWFES254bmluSEFXSCtMR3FpTndnYW9EdDJaOVdyTFNGU3ZIWmZhaC93dHBJ?=
 =?utf-8?B?WkxlcmtCWHpDMXl3dlVlWTBRUmVRMndjUGtNU2RsOXhpdTBzdmFIN1ZzaGho?=
 =?utf-8?B?Wm0vNm9YR01mUmVCUGl4Z2VqSlE0N1loMUJHbk1yQkV5QityRmx3R0o1OTNM?=
 =?utf-8?B?NzVlVEpTUllQb2podmJ6T3dWbnlJMWowa2xxSHgzdWdXNW83a3Uwc1E0R2NW?=
 =?utf-8?B?Y1dqUFRTUGc4dkcrbjVVZnVUNDZYcUpacFc1ZFBndCtBdDNzczM4NXVmR2d6?=
 =?utf-8?Q?/RUQZZNr7R0XIF76YFSr4Nhbjx2cd9ASJIwRpv68lXhZM?=
x-ms-exchange-antispam-messagedata-1: Q5nIAdEIywWsEJ70ZgX/c/XdIlUddfsTMHY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C35A5524E94004468DB2AA8D385B702F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JTqRZj/nasBRsQXzAUo8KT+KDzqDXYFwJcSB2hO76wluBl50e2YNUa3nthE816ahEzwZ5oUFVK0ms70sKHFV9n2OR7gPksgsICY4fRXVw4AMui4gGKqi4YB2/RgO+HXK+eQdr/MSZBCvcE0UR/oFcE5SCGRCL2j0eVE65qLq/gtabSiAbZArIDZSI4AzZn70RiuFvcUN2fjtD7XN5OOb/0dn6V6FIrxqKkZzaw6t4iBhgMSQwv78DgtMOZz2bcyRAskfQMdc/4HoxrLio8bWkmBmingZXPqTQtoD5Dkwcbu5odMjqQl500bptoNdTTGGxmOzYi4wDZcllrVZwrb7jQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: U7dCNLTuEKwfKrO1HifWQmpJe5fGbRSF1FS3B2m3tMk7lXH6p/++0q+K+TEtJIhY1Kiwqq5s6Pd97WdPeDkhlFhhFCY0ccDNTBubLHtzc62ScNgx3wn/4+BIr6t6hKDAxNU86O6PT0Zo9J8R620WW1NavQDx2njQL/esDjJPSCpCWSHP8xCglD5FPRK4PPpxu4gm08vBN70FaxVV5FDBlGMZnclfAE4CjUMcpVLXOZG6iwyoih15EppPOqQXaltGuNNI+oGoEc7XGBFHMMCtc6YOGUGbiHteYbQppofkL1OB5HVZuwg4wyPdDcKcfytz6gk/NHxe2IqP6lqy40ZISgscuamhrEBwKZx9eTB2ChcueGKSXCcEn2zgOvcFjrNgXLlRaQUxxx+LeEqeeQJLZNnc0Me8Z0gB78bfqyVj5Ak5dY8ge3mlJrfr6a41fgxFZ4RVPHm16wPP1NvDiGP2piV+VbkoGsh05lAJ0NYSvx5+CtSu2Bqk6evu+tNnJglRS9x4VSeFCUBBFplhng9xruliImvguj+0hBNxTjYia2yMFQZ/MlV1Ic9ajXDIT9LBv76l2ruTEBahFt2fxV+84043isd1R2zrOMOAWctyLObOEviGXjQvTplG3lqJpu9c
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 003c3623-6c8b-40f9-8896-08df07ea6659
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 05:32:23.0178 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VJSkbLfWOkCmeuZUsFvYU+xYNWVF6W7NP19czt1TOc6QaPXHyjvHjwOaRCXroA+Xy0+nAEmbiwl96DsVN++Q51Asw/ia8cGnOPlKA8dsBTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7302
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=6977d653a=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

T24gRnJpLCAyMDI2LTA4LTI4IGF0IDE3OjM5IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gSGksDQo+IA0KPiBJbiB0aGlzIG5ldyB2ZXJzaW9uIGEgbmV3IHBhdGNoIHdh
cyBhZGRlZC7CoCBJdCBpcyBhIGZpeCBmb3IgdGhlDQo+IGFjbGludA0KPiBGRFQsIHN1Z2dlc3Rl
ZCBieSBDaGFvIGluIHRoZSB2NCByZXZpZXcuwqAgV2UncmUgZml4aW5nIHRoZSBGRFQgYmVmb3Jl
DQo+IG1vdmluZyB0aGUgYWNsaW50IEZEVCB0byB0aGUgaGVscGVyIGluIHRoZSBwYXRjaCB0aGF0
IGZvbGxvd3MuDQo+IA0KPiBObyBvdGhlciBjaGFuZ2VzIG1hZGUuwqAgUGF0Y2hlcyBiYXNlZCBv
biBhbGlzdGFpci9yaXNjdi10by0NCj4gYXBwbHkubmV4dC4NCj4gDQo+IENoYW5nZXMgZnJvbSB2
NDoNCj4gLSBwYXRjaCA4IChuZXcpOiBmaXggYWNsaW50IHNvYy9tdGltZXIgbm9kZQ0KPiAtIHBh
dGNoIDk6DQo+IMKgIC0gbW92ZSB0aGUgYWNsaW50IEZEVCB0byB0aGUgaGVscGVyIHdpdGhvdXQg
YW55IGNoYW5nZXMsIGFzIHN0YXRlZA0KPiBpbg0KPiDCoMKgwqAgdGhlIGNvbW1pdCBtc2cuDQo+
IC0gdjQgbGluazoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MDgy
NzIyMjYwOC4zMjk3ODgtMS1kYW5pZWwuYmFyYm96YUBvc3MucXVhbGNvbW0uY29tLw0KPiANCj4g
DQo+IERhbmllbCBIZW5yaXF1ZSBCYXJib3phICgxNSk6DQo+IMKgIGh3L3Jpc2N2L2ZkdC1jb21t
b246IHByZXBlbmQgaGVscGVycyB3aXRoICJyaXNjdl8iDQo+IMKgIGh3L3Jpc2N2L2ZkdC1jb21t
b24sIHZpcnQuYzogYWRkIHJpc2N2X2NyZWF0ZV9mZHRfZmxhc2goKQ0KPiDCoCBody9yaXNjdi9m
ZHQtY29tbW9uLCB2aXJ0LmM6IGFkZCByaXNjdl9jcmVhdGVfZmR0X3N5c2NvbigpDQo+IMKgIGh3
L3Jpc2N2L2ZkdC1jb21tb24sIHZpcnQuYzogYWRkIHJpc2N2X2NyZWF0ZV9mZHRfcmlzY3ZfaW9t
bXVfc3lzKCkNCj4gwqAgaHcvcmlzY3YvZmR0X2NvbW1vbiwgdmlydC5jOiBhZGQgcmlzY3ZfY3Jl
YXRlX2ZkdF9wY2llKCkNCj4gwqAgaHcvcmlzY3YvZmR0X2NvbW1vbiwgdmlydC5jOiBhZGQgcmlz
Y3ZfY3JlYXRlX2ZkdF9pbXNpYygpDQo+IMKgIGh3L3Jpc2N2L2ZkdF9jb21tb24sIHZpcnQuYzog
YWRkIHJpc2N2X2NyZWF0ZV9mZHRfc29ja2V0X2FwbGljKCkNCj4gwqAgaHcvcmlzY3YvdmlydC5j
OiBmaXggYWNsaW50IHNvYy9tdGltZXIgbm9kZW5hbWUNCj4gwqAgaHcvcmlzY3YvZmR0LWNvbW1v
biwgdmlydC5jOiBhZGQgcmlzY3ZfY3JlYXRlX2ZkdF9zb2NrZXRfYWNsaW50KCkNCj4gwqAgaHcv
cmlzY3YvZmR0LWNvbW1vbiwgdmlydC5jOiBhZGQgcmlzY3ZfY3JlYXRlX2ZkdF91YXJ0KCkNCj4g
wqAgaHcvcmlzY3YvZmR0LWNvbW1vbiwgdmlydC5jOiBhZGQgcmlzY3ZfY3JlYXRlX2ZkdF9ydGMo
KQ0KPiDCoCBody9yaXNjdi9kZXZpY2UtY29tbW9uLCB2aXJ0LmM6IGFkZCByaXNjdl9jcmVhdGVf
cGxhdGZvcm1fYnVzKCkNCj4gwqAgaHcvcmlzY3YvZGV2aWNlLWNvbW1vbiwgdmlydC5jOiBhZGQg
Zmxhc2ggaGVscGVycw0KPiDCoCBody9yaXNjdi9kZXZpY2UtY29tbW9uLCB2aXJ0LmM6IGFkZCBy
aXNjdl9ncGV4X3BjaWVfaW5pdCgpDQo+IMKgIGh3L3Jpc2N2L3Jpc2N2LWlvbW11LXN5cy5jLCB2
aXJ0LmM6IGFkZCByaXNjdl9jcmVhdGVfaW9tbXVfc3lzKCkNCg0KVGhhbmtzIQ0KDQpBcHBsaWVk
IHRvIHJpc2N2LXRvLWFwcGx5Lm5leHQNCg0KQWxpc3RhaXINCg0KPiANCj4gwqBody9yaXNjdi9k
ZXZpY2UtY29tbW9uLmPCoMKgwqDCoMKgwqDCoMKgIHwgMTY4ICsrKysrKw0KPiDCoGh3L3Jpc2N2
L2ZkdC1jb21tb24uY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA2MTMgKysrKysrKysrKysrKysr
KysrKysrLQ0KPiDCoGh3L3Jpc2N2L21lc29uLmJ1aWxkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgIDEgKw0KPiDCoGh3L3Jpc2N2L3Jpc2N2LWlvbW11LXN5cy5jwqDCoMKgwqDCoMKgIHzC
oCAyNSArDQo+IMKgaHcvcmlzY3YvcmlzY3YtaW9tbXUuaMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oMKgIDMgKw0KPiDCoGh3L3Jpc2N2L3NpZml2ZV91LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8wqAgMzQgKy0NCj4gwqBody9yaXNjdi9zcGlrZS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgIDMwICstDQo+IMKgaHcvcmlzY3YvdHRfYXRsYW50aXMuY8KgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoCAyMiArLQ0KPiDCoGh3L3Jpc2N2L3ZpcnQuY8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfCA4NjEgKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4g
LS0NCj4gwqBpbmNsdWRlL2h3L3Jpc2N2L2RldmljZS1jb21tb24uaCB8wqAgMzIgKysNCj4gwqBp
bmNsdWRlL2h3L3Jpc2N2L2ZkdC1jb21tb24uaMKgwqDCoCB8IDE0NiArKysrKy0NCj4gwqBpbmNs
dWRlL2h3L3Jpc2N2L3ZpcnQuaMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMTUgLQ0KPiDCoDEyIGZp
bGVzIGNoYW5nZWQsIDExMTIgaW5zZXJ0aW9ucygrKSwgODM4IGRlbGV0aW9ucygtKQ0KPiDCoGNy
ZWF0ZSBtb2RlIDEwMDY0NCBody9yaXNjdi9kZXZpY2UtY29tbW9uLmMNCj4gwqBjcmVhdGUgbW9k
ZSAxMDA2NDQgaW5jbHVkZS9ody9yaXNjdi9kZXZpY2UtY29tbW9uLmgNCg==

