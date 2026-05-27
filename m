Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDD2CD5BD2
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 00:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS1sB-00089V-P0; Tue, 26 May 2026 20:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6009f06ea=Alistair.Francis@wdc.com>)
 id 1wS1sA-00089I-II; Tue, 26 May 2026 20:11:46 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6009f06ea=Alistair.Francis@wdc.com>)
 id 1wS1s5-0000aF-TV; Tue, 26 May 2026 20:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1779840701; x=1811376701;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=qMHslP3zXN7WH6dLL+5I/eQ6b9OOMHAIgdRaeO+SMD0=;
 b=b20mJgXj5+ai6PGbGsHgfVXbNWlSZVP05/J74WJjQGgNl1S07jVu/WrA
 puKhrZ/cv9bv+ykIhofTL2guViu9lHNwBP6TbiMJ+LM+C26mIB5kY7dyr
 UtPl/1gbOwvTKsmLw0pIDARlZA5RfakG6VulzcGY+li5JeYw2WCA3tIPh
 8T+5+6TV2FUDNpwgSVoa3c4bHE+mtt7zR9JZnpgqYJm9xNzsEkq5Dd3El
 +m06ufXa2PxOWmr40OpEJhg0wMIfTlq4DaA9j4bVmmZFNRDv136tf0EW7
 kjtn+IO8wVHG19rbhWw/v4X7ODhoAviOvs7BrCreH6MFMfNxVGrJfDuec w==;
X-CSE-ConnectionGUID: vyJgmM6VR42wlSRNcalcCQ==
X-CSE-MsgGUID: og9OjWtxQ4Klbfl4/+Fd5A==
X-IronPort-AV: E=Sophos;i="6.24,170,1774281600"; d="scan'208";a="146882407"
Received: from mail-westus3azon11011005.outbound.protection.outlook.com (HELO
 PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.5])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 May 2026 08:11:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BieqYKgD1IlCW1FdjGf425AXC1un0H7I1CsfCtHaZcy85Q2jqbPfZz4eVRKNR0L//IuqLBQ6yawPwkm49bQ/5WdzvHwt/nkisUvx4AURsoK1UePg49VT/EOPjo/dWeg4mFcHixOaXITJ4uFCzu0Z2b1t3LLcYGywL2lvpzYvdZOKY0Y/JYmorrZ0LjoFFcdRDH3451sgtPqtWEAaoX5bTccC0nESF6Zw95o8E33wjmwje8u0TEGHpHOWAyJcja+Yc+U0q6iWMHfg0dUcuHwl2FxRUQw76NM7CU2iqNQpeC3egqrMphdgZoBdkxxk1MeauNg6DnlGOtZzh+L/pWKngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMHslP3zXN7WH6dLL+5I/eQ6b9OOMHAIgdRaeO+SMD0=;
 b=xWO5ILRSeIsTXxKi+oihoKehfzpr6GwO/JICugP3DSlKgxqzbhH1UZf0xwsTfSRpQtvE9wPHLXWWAMYprFJSCJ3USEdf7mvmOVCwScJjukByu/zcXRVW6lQgySQ3ji4ExiL+fWEaXurQebPxpBV1SJOcL8XYfkCI0wIR0X5qpXSqK+uCPAMWdXzY59SktiRCGlFg3pzJel43nCdZ+uo3UsmEoBlgX+xWbB7c3PynGj8YOpw+XemO4i3GZGNGBQYhnTkrsqbwW2dNnPNK0kXr9GS1cRGatgY8FgDV0MxSv5QAM9n/T5H8yniJh+/OqFPRLwVgXFeTV4O46r4ny6sVag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMHslP3zXN7WH6dLL+5I/eQ6b9OOMHAIgdRaeO+SMD0=;
 b=Tj7Zvl4f346zGC8l7gDt5vLDh2oEfk+YqGWKjgCI3CtUGBAm87nYu1RfqDa2N+3cBAjVvfbqA+Br67WRXP+eFkBhf3eyYNbRl6XQ2f6dp0o4Y7eEeE24t/yN3wSHuvOPAxM5gPmJPpx2HKne42wjIIAHhgUOpx9noUChayLN7M4=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by CO6PR04MB7876.namprd04.prod.outlook.com (2603:10b6:303:138::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 00:11:36 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 00:11:36 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "fritchleybohrer@gmail.com" <fritchleybohrer@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu.zevorn@gmail.com"
 <chao.liu.zevorn@gmail.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2] target/riscv: Reject Svinval instructions in U-mode
Thread-Topic: [PATCH v2] target/riscv: Reject Svinval instructions in U-mode
Thread-Index: AQHc6Zwwlj9USCvjEky5hv1fo5oVW7YhB4mA
Date: Wed, 27 May 2026 00:11:36 +0000
Message-ID: <cb2d8c8e2090c7063c0cfcaa160b41c280236c01.camel@wdc.com>
References: <20260522033145.17850-1-fritchleybohrer@gmail.com>
In-Reply-To: <20260522033145.17850-1-fritchleybohrer@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.1 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|CO6PR04MB7876:EE_
x-ms-office365-filtering-correlation-id: 814a203a-48a4-445c-4133-08debb848489
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|19092799006|6133799003|3023799007|11063799006|5023799004|22082099003|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info: BKu8uXaMd7Q6ZRTfQK8vwXR7MtpvizuqHQnveqSoxChm2v/jG3nd+r/hYfjngeJYYHrlSdObucGsuuR9GYnzidmimm67H1LcpQdygRACMmUqCtkHT/1AgfYp9P5QFB1ZZaVZCLu2HMt0qJuvbscmb49DLAZJgh/BW0qFtBKPtq7LPY0DEUZ2uwYRB3hz5jEpARC+T3J0ycASe4Pj2Y/TtedlYgYLpxh4XIW0n2wy9VDp0iegpJxa0/CGgDr4MWkLvd6L6Ggiz5oK39irK2jw9d00IBND4dHwPKAL4BByFlj1HqPQUm0RRZArQ9fq8JvUD2PB2XlsAPXhdd9g9M1g+8WNiJ7u7ydkB/y/zSgyB0Q2vQo2tpcbXhWY5JPMMJFIcQoxMAZFETdcOjdyscOFWI4R1of/QgZpsl83ZN0ebxU6x12Fxu3IBXHAyGLTRVpt7/8wEqygXlOOpVp0iv/idVEz6ioRGEr3jFgYAgwQKCV9bVUodTVOz5vPCoDj6ls9iaWCRklmu8764tD+1wEzjIWF+DHgkqiQHHrUWTqvAX2VvjR4PklSi1ce94zIcMYR3V9JKSjA0FajzvIxFopA1qgYrnUzpDcrPmybzY0PRDPsyPeMEuSJWPmh8G3s0LV/3F6l5or097jSIPqG4uhNC0jlrU8SVOxb8W7bfpFQxZ6Rr7IP6HZQ0pdcnxnLzRc01tuST/GHbgzp6a3/TN3cWB7ZLqBjwmSdBqxW5E4AJ7lx+OJOfRVXr5XHNNT6Wnd8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(19092799006)(6133799003)(3023799007)(11063799006)(5023799004)(22082099003)(18002099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1NhcjJnRmplVy90M2JnVDZOZDFtVmFlUzVDeWpWMmJid1FRd3hESlE4R2Fs?=
 =?utf-8?B?Sm1tNitLSzlLdXZTWGVjcVVBUEU5bU5zUE11SnUzU0NhdnRHTVZNbHNmVUR3?=
 =?utf-8?B?UlRScTBmMnZTWlk2cXhQaDJxWHo2OFZqelV5WlhkOXNpdDJlQVFhU2FtMEFR?=
 =?utf-8?B?azlMY3RjTGFuWEdOd3RORzZvWmd5c3JZZFlkMkJGTVR0cGJ6M3dJNjBmQUhO?=
 =?utf-8?B?aFQ4cDcvZGJ1Kzd4dGlDTUlLN2IyQ0Jxa1pYb21XY2I2L2E4VkFpYlkwbldG?=
 =?utf-8?B?Mi9PRnlDRkxLUHg0czd3V3JyQU1FLzBDbHdDSy96TUo1K1VwRFpmRWJLK0lp?=
 =?utf-8?B?VmF6M0g0SnF3VVo5c3BMU250VjFncnFNU0RCT2Y5M1A0Vnk1STIzYUh4TGxQ?=
 =?utf-8?B?ZTNtaW50ampEWkU3cW5KNGFsSHMwcjJBd3Y4ZzU1UUlaa21jaW9oQ3V4ODlB?=
 =?utf-8?B?SEpUbUd0Z3JZRlVKejZod3ZDZ25QUXRjUWRzaE54ZHlpRHpsbUxLRkpuSjEw?=
 =?utf-8?B?N2lORzhuNU04OU1POU01djFnQXRqejh5eldIZlVMNmYxdHkveU5VTWtlUmE0?=
 =?utf-8?B?N1ZkMVUrYkF0M0ZaWS9YV2docTFVN09GWCtjbmYzQUlpdWhqR2l5K01sZjI2?=
 =?utf-8?B?aHE3WXdCUllqaGZzQmVyYmt2dUdNSXd3OExpd29Ybno2Q2lEdFB4Ym9XZnI5?=
 =?utf-8?B?WENBMmtBMEJ6VjgycFVnenBiay8xNldnbkVCUVNKK2hGUnB4d1ZCclIveWNZ?=
 =?utf-8?B?T2ZyeGxSMkxiNEpwOEFnc1VxbGpDMUZTbnJhWEhxKzNtbHFzQiszQzZwTHVj?=
 =?utf-8?B?QzBrU1RUNFpKZjc4dDl0ckJoNkJDcHJZWU1kZUVHN1AvME45T3FlYXhIb3NL?=
 =?utf-8?B?d1FYeTBjM1lIOGMrQXJMdVUrNUI0dFN0RVVlTnhFU0ZEUHpBcFNub2IzKzVP?=
 =?utf-8?B?QXNZc3MyUEdoc0JwdXJRWmo2M21wcGlYRjZtaGJ2ZDNDd2ozeDc1S3NsRG5a?=
 =?utf-8?B?bFFkSzFGblJtc0p2SWgwbERSUm5tclZUSmNnRGEwSUo3MnpsQWNEZUp6TEFP?=
 =?utf-8?B?WWNPNy9xQnZoNW5lUm40WkJpWXZWcGgyWDZQUkxiSENuWVR3OHM0cm02Q096?=
 =?utf-8?B?R0pBSVFHM2RTTjhLUjRFY0RudXpocExzZmc1T0YyenVJc1FRRi9laU1zZEZs?=
 =?utf-8?B?aWh0eUo4R0xoT2VNVm0wNDZTNmxEQUtIMHJva20zckJMN1AxTkhxdkF0aG9F?=
 =?utf-8?B?dm1sdUc4QW1XVW1BbFpHMFVldE95QjFHd2FpOFdXcWV4c0xESS8zRlVmb0FR?=
 =?utf-8?B?RmNyWHBxV0FXZTlPYkVFQTA0RUNlQjNEZlkzaXBGM0trTXJWeEJIRjhnR0U3?=
 =?utf-8?B?OXZLSVlVVk1lWHl3c1pRQzB0d3hIU3J4eW9xdUlsRHdiTGNKOWd5Y28yS2VQ?=
 =?utf-8?B?d1hUZldlWHhFdnczSS9mY1NTeG8yU05mT041RFhFaW9sRDdXK0hZYnYzcjVS?=
 =?utf-8?B?ZDQvTFNQUHh6Z0Yvb1hlQUYwOVV3YnNHb2tPZThoVXVYd1A3VHVuVzEvQktC?=
 =?utf-8?B?SmpkUHVEUGQ0UkcyZlBaUFU4Z2FLaC9tSE9nWEZ3aVFTOGhiekZrZUIzSkdi?=
 =?utf-8?B?N29tbmorcDc2UkR4eGcwcU5VMUpqb3FZZzVlM2ZqZ3RCandhMldScytXZUp6?=
 =?utf-8?B?VGh3ZlMrS1J5cVU2SEtyNWprVHEzVU1VNmZCQlNsd2VQR1dzVzIyYzlYb0Vk?=
 =?utf-8?B?NkcxMkFRTm1LR2lxaHFzallseFdVV2hzN3dKN1pNbXlPa1huK0Y5L1ZoRHA3?=
 =?utf-8?B?bmVJUHF5eVBBZDhTbnRxeW5EWVIyRFVGR2xvMVo3TVF1WEtoTEpBWGVNUERj?=
 =?utf-8?B?bjRjeUthekVUcmhxV2RlNDRTZ1lXWmx1Y1IyQ0VHMXhPakJhUmFRNythT243?=
 =?utf-8?B?R2oyZ29WMm1KV0dNZUxWaUxTVVhCeVd1eUNTcHZZb3F2c2J4Wjd4cGtpWnRm?=
 =?utf-8?B?a2YvK29jRlUrZzZEWjhFVHQzdXVrdHhSOXJSRm9sS0F4R3lxOVNxWWo5RGZQ?=
 =?utf-8?B?czRoakdvamx5cUNTbW5hU0RzSEdBOUs1aERnZ3Ftb1VtUTB2WFAzb0U0aWM3?=
 =?utf-8?B?bHNrYTVUTVQ5YkNxYXhyYk01cTZCbmcyMlJoc0cveDRQUUZQOXZqNHlkU1hm?=
 =?utf-8?B?QzJteitRZ1NCM2krYlNERkw0cmdCMVluQ1AzMGNoaHl3Y3dqemRONWszdnQy?=
 =?utf-8?B?SERoTlhjaURETG9qa1g3MUVXZmNJb1hQbUZmRGFSTHJueU9lR3JWcmNoa2Zo?=
 =?utf-8?B?UmFvZ0p5dDd2WTNXdFdudHZmNFUxTjBUVEF5MFdzYzJ5UFlEdDZQQzRHSTZq?=
 =?utf-8?Q?oojL1PctiYALZgt3YiJmdqqjNt6/NHKgwnN497gA/D68W?=
x-ms-exchange-antispam-messagedata-1: cySIB6KMffTrImL/nRtArmodx0sOuK/U0SA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C90990CB2C98C749AAAF8DFEF25796F0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ma183dgKTbUpazwT9mIpBD13VOjX4ePCJhLw1c1IuBrADzeq1rnRzhnxBHzSKafWwWlOMEjv4oXg+FtaqZcDYIpRNeYl43UsbwgICoDlspaQnWrxps8ctRLOcGwdSmqg7nLWIZK1U9f8rgQdmPkd0JaYRObrjWQwRdIR1+CzrSfWXnJSiy0dnekTQp5LMW6/z+ZyrwWlsqMppt5ZIYAaq/mGRo6AssIGwcSb+Rp97ur2b+Kgr2b5bwQ48e8jS4Es8OSMSujSFtxytpPRGNUv6/4TYAZi9EXnKO5sp7kLaTXq28U97Ft9uO56jxSaBdl2jqQES2w7SQzKEVqnFLdLkQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4Tlq8RUd7VAKyPejtb2aUYu6b9JpMnPUSrPzA2buFGP9jyPajlBj2W4gPDCWrZUTQwtnk9Sxwr71aazQ0iK5IrijyxtAiM4Vq8zwESTR0db6lq+rfJlH8+c9ZhNcIlIVnzivbO512Cy9zVyt6xEUXVla2510n9OrdMi5qkrUe2HPd0FxfmHNz59abFdShR1euhb9W+Hn1bqXGQqA3mjYCVa7HNEZ3xsBYzlVulpsGmh0vJknFQlYpRsx6iAzzeWQjp673hZ1FmFV8cHFVSm6RKAYItanw9A2kHzlYlumNJpZ5nFP3hXRNzuj18xVpRlG9uQAcqU/TrR8v8qPdgMH3KKigL6pP9T6Sh6LBsszjB7CF/CWL9/bgvH/EzFntSNuLQXjaZrtf7LAAmU05Tg149Ts9JJ0Ql2xxHf8QOCj6THg7hUzWgVpZ9WavxottYWeeO5usQ6mE6gKQP+g+uLP+CHXk5X1vsk5bHbJkg1JY1K4MhxBK8LkpNTfc+xHiaiDpLcMcb728JsDxQocWiW2UIamYXDJdSW9RibG1FUaPyv/3dI5DWb1GcKBsF/aOnXMk5mthhCfUqT0hWQE8bH7BmmxzpQyHrjrAXXPbYHGdBDdBqVqEpTJni5UTsRHmgZm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 814a203a-48a4-445c-4133-08debb848489
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 00:11:36.6789 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tckBgaYY47NP47KiG9Wl5sa9w/XhNzJ2sROh0ytQuO4gS5Da0XT+fk0W3Syaf9SMku5JUTTqB1f661IRILyMx4w3SWLXiy+Jajun7wT0+sk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7876
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=6009f06ea=Alistair.Francis@wdc.com;
 helo=esa5.hgst.iphmx.com
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

T24gRnJpLCAyMDI2LTA1LTIyIGF0IDExOjMxICswODAwLCBaZXBoeXIgTGkgd3JvdGU6DQo+IFRo
ZSBSSVNDLVYgcHJpdmlsZWdlZCBzcGVjaWZpY2F0aW9uIHJlcXVpcmVzIFNGRU5DRS5XLklOVkFM
IGFuZA0KPiBTRkVOQ0UuSU5WQUwuSVIgdG8gcmFpc2UgYW4gaWxsZWdhbCBpbnN0cnVjdGlvbiBl
eGNlcHRpb24gd2hlbg0KPiBleGVjdXRlZA0KPiBpbiBVLW1vZGUuIENoZWNrIHRoZSBjdXJyZW50
IHByaXZpbGVnZSBtb2RlIGR1cmluZyB0cmFuc2xhdGlvbiBhbmQNCj4gcmVqZWN0IHRoZXNlDQo+
IGluc3RydWN0aW9ucyBpbiBVLW1vZGUsIHNvIHRoZXkgYXJlIHJlcG9ydGVkIGFzIGlsbGVnYWwg
aW5zdHJ1Y3Rpb25zLg0KPiANCj4gQWRkIGEgaGVscGVyIHRvIHJlamVjdCB0aGVzZSBpbnN0cnVj
dGlvbnMgaW4gVS1tb2RlIGR1cmluZw0KPiB0cmFuc2xhdGlvbi4NCj4gDQo+IFJlc29sdmVzOiBo
dHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS93b3JrX2l0ZW1zLzM0OTMNCj4g
DQo+IFN1Z2dlc3RlZC1ieTogRGFuaWVsIEhlbnJpcXVlIEJhcmJvemENCj4gPGRhbmllbC5iYXJi
b3phQG9zcy5xdWFsY29tbS5jb20+DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBaZXBoeXIgTGkgPGZy
aXRjaGxleWJvaHJlckBnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lz
IDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKgdGFy
Z2V0L3Jpc2N2L2luc25fdHJhbnMvdHJhbnNfc3ZpbnZhbC5jLmluYyB8IDEyICsrKysrKysrKysr
Kw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvdGFyZ2V0L3Jpc2N2L2luc25fdHJhbnMvdHJhbnNfc3ZpbnZhbC5jLmluYw0KPiBiL3Rhcmdl
dC9yaXNjdi9pbnNuX3RyYW5zL3RyYW5zX3N2aW52YWwuYy5pbmMNCj4gaW5kZXggYTA2YzNiMjE0
Zi4uNDYxNGMxNDg5YyAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L2luc25fdHJhbnMvdHJh
bnNfc3ZpbnZhbC5jLmluYw0KPiArKysgYi90YXJnZXQvcmlzY3YvaW5zbl90cmFucy90cmFuc19z
dmludmFsLmMuaW5jDQo+IEBAIC0yMiwxMSArMjIsMTkgQEANCj4gwqDCoMKgwqAgfcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIFwNCj4gwqB9IHdoaWxlICgwKQ0KPiDCoA0KPiArLyogVGVzdCBpZiBwcml2IGxl
dmVsIGlzIE0gb3IgUy4gKi8NCj4gKyNkZWZpbmUgUkVRVUlSRV9QUklWX01TKGN0eCkgZG8ge8Kg
wqDCoMKgwqDCoMKgwqDCoCBcDQo+ICvCoMKgwqAgaWYgKGN0eC0+cHJpdiA9PSBQUlZfVSkge8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxz
ZTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KPiArwqDCoMKg
IH3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBcDQo+ICt9IHdoaWxlICgwKQ0KPiArDQo+IMKgc3RhdGljIGJv
b2wgdHJhbnNfc2ludmFsX3ZtYShEaXNhc0NvbnRleHQgKmN0eCwgYXJnX3NpbnZhbF92bWEgKmEp
DQo+IMKgew0KPiDCoMKgwqDCoCBSRVFVSVJFX1NWSU5WQUwoY3R4KTsNCj4gwqDCoMKgwqAgLyog
RG8gdGhlIHNhbWUgYXMgc2ZlbmNlLnZtYSBjdXJyZW50bHkgKi8NCj4gwqDCoMKgwqAgUkVRVUlS
RV9FWFQoY3R4LCBSVlMpOw0KPiArwqDCoMKgIFJFUVVJUkVfUFJJVl9NUyhjdHgpOw0KPiDCoCNp
Zm5kZWYgQ09ORklHX1VTRVJfT05MWQ0KPiDCoMKgwqDCoCBkZWNvZGVfc2F2ZV9vcGMoY3R4LCAw
KTsNCj4gwqDCoMKgwqAgZ2VuX2hlbHBlcl90bGJfZmx1c2godGNnX2Vudik7DQo+IEBAIC0zOSw2
ICs0Nyw3IEBAIHN0YXRpYyBib29sIHRyYW5zX3NmZW5jZV93X2ludmFsKERpc2FzQ29udGV4dCAq
Y3R4LA0KPiBhcmdfc2ZlbmNlX3dfaW52YWwgKmEpDQo+IMKgew0KPiDCoMKgwqDCoCBSRVFVSVJF
X1NWSU5WQUwoY3R4KTsNCj4gwqDCoMKgwqAgUkVRVUlSRV9FWFQoY3R4LCBSVlMpOw0KPiArwqDC
oMKgIFJFUVVJUkVfUFJJVl9NUyhjdHgpOw0KPiDCoMKgwqDCoCAvKiBEbyBub3RoaW5nIGN1cnJl
bnRseSAqLw0KPiDCoMKgwqDCoCByZXR1cm4gdHJ1ZTsNCj4gwqB9DQo+IEBAIC00Nyw2ICs1Niw3
IEBAIHN0YXRpYyBib29sIHRyYW5zX3NmZW5jZV9pbnZhbF9pcihEaXNhc0NvbnRleHQNCj4gKmN0
eCwgYXJnX3NmZW5jZV9pbnZhbF9pciAqYSkNCj4gwqB7DQo+IMKgwqDCoMKgIFJFUVVJUkVfU1ZJ
TlZBTChjdHgpOw0KPiDCoMKgwqDCoCBSRVFVSVJFX0VYVChjdHgsIFJWUyk7DQo+ICvCoMKgwqAg
UkVRVUlSRV9QUklWX01TKGN0eCk7DQo+IMKgwqDCoMKgIC8qIERvIG5vdGhpbmcgY3VycmVudGx5
ICovDQo+IMKgwqDCoMKgIHJldHVybiB0cnVlOw0KPiDCoH0NCj4gQEAgLTU2LDYgKzY2LDcgQEAg
c3RhdGljIGJvb2wgdHJhbnNfaGludmFsX3Z2bWEoRGlzYXNDb250ZXh0ICpjdHgsDQo+IGFyZ19o
aW52YWxfdnZtYSAqYSkNCj4gwqDCoMKgwqAgUkVRVUlSRV9TVklOVkFMKGN0eCk7DQo+IMKgwqDC
oMKgIC8qIERvIHRoZSBzYW1lIGFzIGhmZW5jZS52dm1hIGN1cnJlbnRseSAqLw0KPiDCoMKgwqDC
oCBSRVFVSVJFX0VYVChjdHgsIFJWSCk7DQo+ICvCoMKgwqAgUkVRVUlSRV9QUklWX01TKGN0eCk7
DQo+IMKgI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZDQo+IMKgwqDCoMKgIGRlY29kZV9zYXZlX29w
YyhjdHgsIDApOw0KPiDCoMKgwqDCoCBnZW5faGVscGVyX2h5cF90bGJfZmx1c2godGNnX2Vudik7
DQo+IEBAIC02OSw2ICs4MCw3IEBAIHN0YXRpYyBib29sIHRyYW5zX2hpbnZhbF9ndm1hKERpc2Fz
Q29udGV4dCAqY3R4LA0KPiBhcmdfaGludmFsX2d2bWEgKmEpDQo+IMKgwqDCoMKgIFJFUVVJUkVf
U1ZJTlZBTChjdHgpOw0KPiDCoMKgwqDCoCAvKiBEbyB0aGUgc2FtZSBhcyBoZmVuY2UuZ3ZtYSBj
dXJyZW50bHkgKi8NCj4gwqDCoMKgwqAgUkVRVUlSRV9FWFQoY3R4LCBSVkgpOw0KPiArwqDCoMKg
IFJFUVVJUkVfUFJJVl9NUyhjdHgpOw0KPiDCoCNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQ0KPiDC
oMKgwqDCoCBkZWNvZGVfc2F2ZV9vcGMoY3R4LCAwKTsNCj4gwqDCoMKgwqAgZ2VuX2hlbHBlcl9o
eXBfZ3ZtYV90bGJfZmx1c2godGNnX2Vudik7DQo=

