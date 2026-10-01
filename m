Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A414CA5FC4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 01:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC5u1-0005vE-8x; Wed, 30 Sep 2026 21:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xC5tm-0005ty-6K; Wed, 30 Sep 2026 21:47:50 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xC5ti-0007WL-Ln; Wed, 30 Sep 2026 21:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790819266; x=1822355266;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=9FNw/1PbUD3s4pXbt/cTmZa8EmptEpueo32EgJkh0+E=;
 b=ZO0s/WU3O4yDy4f3AoRtX2h7FLR/z1VStPDetk5s58V+yiUXmGTG7f31
 qYbiuWm3h1jse0UDDTi+yUpxvYas1BqDR7BN+MoIvK5cxY50OMbdNvwZd
 bOQSemdjdNlJmFd1OaMgphy8KW6voyYkYscV0fi4rQYUzIffDdZ3Fgr0+
 2C8SU1QHjvxGeiN/7jVaJHNzcdEiyFOjxZ3qnMIWocUWzNIKODnFqwM9F
 tTYV5WZ1qFbN0nCtibl4aO0/nEhorxwqLlhwz5d+hzs5+iUjRf6W7IreM
 /XTaxShB5+sfk9gusjhLEuPoP4LroaQRLWVAXwR+t7sovogA5+P1Uejdo Q==;
X-CSE-ConnectionGUID: m7X/z+izQCGuiAsmOXPfzQ==
X-CSE-MsgGUID: WoxTCxfURQye4tcLQbu7Rw==
X-IronPort-AV: E=Sophos;i="6.27,133,1786982400"; d="scan'208";a="155393176"
Received: from mail-eastus2azon11010002.outbound.protection.outlook.com (HELO
 BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.2])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Oct 2026 09:47:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdaS0y6XZ9RN3UW7VboopF7PPlwxyFRGfub4HJICg7h2usFKv9OqPdn8FiO2JzY3pGyA3skUjPKNWlh8FMqEbMT2Le12upH2D6TmG822wErhXC6dvOJRWghm3cQ3HdNl3KtFqpLj3iENrvrOE/PyHMUTA8fXJPfbYkQdhZJycdHrnEZovIrsoX7cgjwNGWncMedhiHjA5u9qTeijrXMRTQSF6dCiq2HpLGM/q4AKZNl/qbc3GJ92CVjKzUknPnTIXEShbOBtctCrbgcMMrBFeruPc4DBuV6ZNcZJ7gyh8kHKTWEgEzrEolG3JT4+nCCNcXiyZ9DL2P4vanun2BnMNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FNw/1PbUD3s4pXbt/cTmZa8EmptEpueo32EgJkh0+E=;
 b=l4wIXWpVLsFyaoYzD1PFlbwRti3G5PNhGiW7y4CHJVM77MwwqqzA26KjqxHmndLNWBmBNgk92hCUNeQt71M7r9fTY7VFiO1TM0WdsMo8D44ESzMLxrnp4RGVKnyvWFGecYVid59W3tr0nGhC6han1dlvDFOQ0baeH38393AfMw9HKx3PhnIojY49eLwfRLNTUeN7QGvDeAz/zp9obYh2S+bD4A8S6wjZspnRjqdO76e91ywwVj7m1ApHQYjWuHfo6IZV/4sdwvGy26R5AGfqvTP0cQxXT+pFkjJq4a523XvopAP7QADP1LpqOGmcBdSOOdfNO+DyavTF2A1+J8UCEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FNw/1PbUD3s4pXbt/cTmZa8EmptEpueo32EgJkh0+E=;
 b=LBNBLW8amOXrecdLDegibwi+Gs5WCrkghq0MUSh29ZS0DIUDjKbxa26RZmf+3DCmnuRVXAB84eH0aoSciOeHNoeIzn/20wTYwJWA97KdN85Y6vCU+HonzqoBKfM29jxzVzCUeTVMahOsay432tLEEX/eazS+FxIqw4Iz3hhnYQU=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by CO6PR04MB7811.namprd04.prod.outlook.com (2603:10b6:5:35e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 01:47:40 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 01:47:40 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 4/7] target/riscv: Have riscv_cpu_set_mode() call
 riscv_cpu_interrupt()
Thread-Topic: [PATCH v4 4/7] target/riscv: Have riscv_cpu_set_mode() call
 riscv_cpu_interrupt()
Thread-Index: AQHdUQOI/4L7AlW1WUSo3uW6THOUDLbn66eA
Date: Thu, 1 Oct 2026 01:47:40 +0000
Message-ID: <263b1f7e081cc366d08e97184738be934bc75a1f.camel@wdc.com>
References: <20260930174508.81497-1-philmd@oss.qualcomm.com>
 <20260930174508.81497-5-philmd@oss.qualcomm.com>
In-Reply-To: <20260930174508.81497-5-philmd@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|CO6PR04MB7811:EE_
x-ms-office365-filtering-correlation-id: 0f8f020e-5218-456d-d6e0-08df1f5dfa83
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|10070799003|19092799006|1800799024|376014|23010399003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: IBKIRAWBWEwoon3KsMAIou8r5ui/5c7qfoZJFfX01jSn0L/Dq70Qijy1G8NzIMAj86bnUb/I+le+VeGpIP6FWNQ7npZ/EUG49tpKfRvFaPQJLpWfh9Dml/yb9fSCIEvgXfU7DEe34HWN/D2JVcWH4sfdq1g+xB6YZkG0UkNnrkCXUZG2zT/mHFM3HSn4kKRJOGJ9VNbOdX4JWXO8jd1rL+6gf1nRCed3d70UpVfMUxEqTy/USOInRYuSfhEsn8/olqJgXXytCyZHvntK02220X5+/aGzHjRNhJMKK9tMEa8bWE8QEQq3kSj/x8F8o8+wBO7DT7tzMfvR+rC+RJZtoDhGQVD85OUOuyK/vVSFKYMd9RJs1qGGZ+qjXphmoH7F4Q4qulYmPBdjTPTn8MgVehVt1JNT1o7mEpkOA785KhchlWyRWn1AsRl7GFkGd0LF7tqAiQcn+q2qOJ5vcqkERznbgnswcuWk9VfvEYChIqndAE2Ae2WEHCOXKS2ZGuxwdbOB5cGmdlFCAHoei5jYnwfoVmtG8Vhe5xa3RfSrAF6tt8Uk5J6PUF0o6yFusSqRyvqTdRtEP8SLVHtkblUKO9tM5SasvN272Ul/U2VAGHtc8TpmESfLlID7pXTgn9IBIHHsdZ+Ht4mAd+wdDm9RBIXbmHISbe/LBGivDJ9HcJbpnJwJ0yxZrSMR8zQvkkkEzP9YOgzEvznyJWqknie4EZeChPFaZOBuu0nt365+A6w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(19092799006)(1800799024)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUFzUlZ2ZFpXQXRVNjRjcW1Iby9FaUduWkpaejRxU0RJNHRqNUoxWXVNR3BP?=
 =?utf-8?B?cmdtMUtybk5yRXVEVFVtNEVoSVRmazZGeW5RRzBqK0FUMFN4OEVOK3N3R2Qy?=
 =?utf-8?B?MmwrTWNieEpURW5sMTlETmtQK0RHT1ExTlVNcndSbkoreEk2VFVKWWFvYllQ?=
 =?utf-8?B?STBVZVFRNVl0bFN2akg2OExpQmt3c0RSbUV4cDNWWXozTG5YYkg2a1FpcTBR?=
 =?utf-8?B?SVZBK1RuTEU3UjZST3d6VHd4aXdobmV5MGlkUGlGRG52OTNqYkg3ZGplcFpD?=
 =?utf-8?B?YXBsdURYazlzZFJQVlpzVmxBQVhsaTlYc1VoRVBOYytLZy9EQkFNUmJKc21u?=
 =?utf-8?B?K09lQkhXaWtDMkhDbUp2Y3RjNU9ObWxTL0VKN2psdUduay94VXdiT3BHRTdW?=
 =?utf-8?B?bkpXSGhJc0ZyOW9SRlJ2Q1I3WHBDVHRNV01HNElhVkd0MTVzRlMzM3UrMHZV?=
 =?utf-8?B?S1NkbURxRGtXQWZFSWVyNGY2ejlrQnVLY3JIYldMQUpVKzRZVGdCanNaMUtl?=
 =?utf-8?B?aHByL3l6V2VQM0l4Z3R2WVpLMklaUXIxdTlGTW5TUEt4b3NBWmowb0FSUjdX?=
 =?utf-8?B?UVd0RUc0K3hFMW1hOWxOckw0TE9nQmZaWFlDVnhvTHRpaGI0YXk0TnFmdkxR?=
 =?utf-8?B?V1FKalBHZHBtSFV1UkF5Z0x0aEw3OHd4UEpmZkZWV3F1OTJ0dUVISEltNndm?=
 =?utf-8?B?YzZNTDlydXFQd2tFSjg2NHUxdmREOFBMTWcyUzFlK0ppbFdwakVoSVRRdGNk?=
 =?utf-8?B?Q2ZRQ1Q0ZFo0cGlvUkhCcVBrdGNwa2hBcFkvcVB4dTZKb3pOWkJkbisvZkVF?=
 =?utf-8?B?RFdIcndkOENkMGdndVlxSnd1YkxsSlBvc09vZ2JlbnlJd1NVT1FON1Y1MlNv?=
 =?utf-8?B?RzZSOXVDZ2pBM3Y1SUV3cHdYQjRsQ0dWcWc5bG1lYkV4cG52Qkx5dzY5MXpU?=
 =?utf-8?B?QTdpSDBVdHpLeUgzZWJ0MEJtZ1RYVStuMC81ajJsSUhYN3RKZndtb1pJdnBI?=
 =?utf-8?B?ZGMvdUFhMU10VkxJMFVhbnNWTndVUzlpUU82ZitnVlBDay9ZSC9RZmltaTUx?=
 =?utf-8?B?cUc2WnFhQWNBMjFyS2IyOWp0VHRpWi9menEzeDYrZG1EWEdtcEpaaFdjTU1J?=
 =?utf-8?B?YTBsYnIvY2xRa0lKbXdOYkhnYkhjZ1B1TW9SYWd0Y04zQXM5U3VKNllmK2Zw?=
 =?utf-8?B?V0NXcCtaNDdHMGtqcFF6UGNSUFdRVk9GZldEQmI1T3BCaGVjNlFjMG8zWUlq?=
 =?utf-8?B?ZEpkT2VOV0FCNHdndUx2NnVrU0JQNm5Kbk5mQUNYNXdvL1N1K0hkd1BldlRo?=
 =?utf-8?B?M1BrT2g4bnREMUFNdll2VGV4VmVySEFvSTVyVWJvMzFTbGxEVVZ5Z2V4S28v?=
 =?utf-8?B?TUhvWlhNWEFoQ1I4d2VpSTU5cjFuRVRsWGNSeUY4WXRVWU9rOHhTWWh1SFJV?=
 =?utf-8?B?cUZIVjZOZlY3RG8vcVExTjczTWNrUDVPVHVIdWMxMXlFYjhjY0FEOWpiTTBJ?=
 =?utf-8?B?cUhNdDE0bzg3cVVUemV6bVZmbFpWZm5TUTdUL0FlTVJweDV4MVNSZHBJVkd1?=
 =?utf-8?B?eGdtTDZYRlVzUHY3RkhCTHhYMWVjbnA5OWVIOG0rME12SVVMelpvMzRXS3pX?=
 =?utf-8?B?K25vVTExbDFLaml3SzM4SDY0SEhJSzgvSWcwdTEvSUExRUhBZlBYY3BaN1lR?=
 =?utf-8?B?NDdKZU8wYWR5K1lVenBRWjVjRTh3SEhNNFp6U0ZrQjAxS2cySnAzVHV3eUlT?=
 =?utf-8?B?UzFidWZpWTJJVWFaNkpZV3ZBMFl6eTJPK1Y5cmVKRThkdDVVZWtESiszcnJC?=
 =?utf-8?B?cnAycFZrcGdnOVhZTUl2bExoZVcxbVQvK1lkMWNqTWR5a0NBUmpYUXRZY0VL?=
 =?utf-8?B?VjlQYUt5VkVQR3RoNSs0OWgya3lGcFlLV3NCYWdSY2lrR0thdm1YQjRWRU56?=
 =?utf-8?B?ZXpWZDZCdzRYNlZRd3NqaXY2RVJYdmRjL05pYnJ2SGNQZWJ2QUl0UVQxcVY0?=
 =?utf-8?B?eTNENXcwN25GS3hqeEM3RG9JSmJNV0pZdkpkcW9naGVSL09qUHlkR2h4UG9I?=
 =?utf-8?B?amlqdHJHd1JLRnRIb254U1dDSVJ0N24ybmZ3TlVBSGdvZzlId3dEamd1Zlkz?=
 =?utf-8?B?Vmk2RGtTUi8wVklzNTNUeEJQUVI2Umhhd2hpN0dGWjJsQStSK3BndXAxbEZv?=
 =?utf-8?B?bHhRbHFNZHhreGZCemQvazZGV1hoN3NtT05lUC8wZjlORitvdFF6YU5ON3lP?=
 =?utf-8?B?ZnJCSnJaTm0zUzh0RERKcjgveWtXUS82dHlhMTZKQ0FxU2o5dGZSZk4wNE9F?=
 =?utf-8?B?TEFCK3pJeVNReC9HOFRSbm5XMVloQjdnYlFHazNYMUdncE56ODJDVmV0WVlz?=
 =?utf-8?Q?lMcvFK1hA/+0ZnVFgTHtaZ5Bta9diY+J8h906JYLh+8it?=
x-ms-exchange-antispam-messagedata-1: C5ErGM94mqxxa7rJBukycsvVPFDwOujj9tc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88ADE1E9452F2B44B6A7FE48EFFA8D9B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: w9Qg5OoUeoYddoov29R3MADAbHzN3hng4ly8KTrus2NJnLrfaaTkISAXYxt41v0EJTE8XoMzC5WwGQ3zTc/7ypFsClsLgkjup33dJRAh+gPYOMysB74KFq8L6sHZ+3YyiLMcKd8Az7Bo1f+AaaFUq1iI2z4jYMR4Me0gGXVeNqkCZRPieqIElERj+cIzwK1dPyV94SJRqZHS43Oy0wqAfhcaRjCUKQ9kUJ7O3PJQeP+AKdetF7AV++Ir/efRKOR0rFKWppK9nA2YIY20sCfmaRbI8ZSUw52+JypMjnmoka+fSsPGWiBcmQTSINTMvcTZqo8oxzTry6vQ3tJDwKnClg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AH8u2Br6gg1Yz2bg8t/rHkjbzW1CFB1SuNFp+eGKG5ugc8hMdC7TFqV4h3f27VAjOaueBgeb/tLSZ0ZDkwqvu4vniHJD/l2++kB02WhIk415xVXdV8y1ydLhGWe5bx13vJKmmtoQOEMpC+0H6HDdkyLF5zsr7Xtj5OHnD4Lo0tdljD7vEXBITDCPklj9PjOAxYcJ6LRm0tZbD517ErCZCIrCxvigwSODi3T/1I/kIEnMB199ExmrlsVLsbnefBWSOtctkK19ILj1PLu5hw/LMr+07VOARvd32M3pHSe0zy9UmLONFgDAhNGwN1eo29JSHpOZt95T8KiQ6sj6vVPNQpO48LQq9Ny8T4Dvr/cgNxn+aX4NDzlDsEXpCIrnnFDEiMsrk73QwWoRnLv4dGNVBIFqvUWrusE6MTLSrZRTGQfoGhsF5mGRHt0MCjf3t/6g+0y4/wpdNSZGK5fDN8IsaGXHEXBQocgR7fUtPswsWAORQWBT7zaF4pEkptrgN+d1kz0GJ7UVuCBI9Yu/jSP2f/bgzH73BqNht4juQlrpFiyP5fds/WYgqYh1H1/HDsrQiAGUTBPCTsHYCGnldMtWPyypjSzXVojufzFBsCkdQ3CFurmi1EoYI+ufeL7czTmb
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8f020e-5218-456d-d6e0-08df1f5dfa83
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 01:47:40.4751 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WkzPEKDRmtwLm0Lr8qBk4mSRTWRYO1TjlbeR8RZ9XgPlRimHW3dgF6xGlB2sqlgDnTVPjOyl7tqn573KdfeZOQkyjBmafFRPUTncB/hO+iY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7811
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=727d860e1=Alistair.Francis@wdc.com;
 helo=esa6.hgst.iphmx.com
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
qSB3cm90ZToNCj4gcmlzY3ZfY3B1X3NldF9tb2RlKCkgb25seSB3YW50IHRoZSBpbnRlcnJ1cHQg
cmUtcG9sbDogdGhlIG1pcCB1cGRhdGUNCj4gd2l0aCBhIHplcm8gbWFzayBpcyBhIG5vLW9wLiBD
YWxsIHJpc2N2X2NwdV9pbnRlcnJ1cHQoKSBkaXJlY3RseS4NCj4gDQo+IFN1Z2dlc3RlZC1ieTog
UmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNpZ25l
ZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAb3NzLnF1YWxjb21tLmNv
bT4NCg0KUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2Rj
LmNvbT4NCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gwqB0YXJnZXQvcmlzY3YvdGNnL2NwdV9oZWxw
ZXIuYyB8IDIgKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvdGNnL2NwdV9oZWxwZXIuYw0K
PiBiL3RhcmdldC9yaXNjdi90Y2cvY3B1X2hlbHBlci5jDQo+IGluZGV4IDA3ZDkyMjI2NTI3Li45
MWY1ZWI3MjkzMCAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L3RjZy9jcHVfaGVscGVyLmMN
Cj4gKysrIGIvdGFyZ2V0L3Jpc2N2L3RjZy9jcHVfaGVscGVyLmMNCj4gQEAgLTg4Niw3ICs4ODYs
NyBAQCB2b2lkIHJpc2N2X2NwdV9zZXRfbW9kZShDUFVSSVNDVlN0YXRlICplbnYsDQo+IHByaXZp
bGVnZV9tb2RlX3QgbmV3cHJpdiwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKg0KPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIFRvIHNvbHZlIHRoaXMsIHdlIGNoZWNrIGFuZCBp
bmplY3QgaW50ZXJydXB0IGFmdGVyDQo+IHNldHRpbmcgVj0xLg0KPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAqLw0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByaXNjdl9jcHVfdXBkYXRl
X21pcChlbnYsIDAsIDApOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByaXNjdl9jcHVfaW50
ZXJydXB0KGVudik7DQo+IMKgwqDCoMKgwqDCoMKgwqAgfQ0KPiDCoMKgwqDCoCB9DQo+IMKgfQ0K

