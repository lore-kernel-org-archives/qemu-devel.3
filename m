Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA064C982ED
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 00:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8ofd-0003MS-Pg; Mon, 21 Sep 2026 20:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=718ae7c5e=Alistair.Francis@wdc.com>)
 id 1x8ofc-0003MB-1y; Mon, 21 Sep 2026 20:47:40 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=718ae7c5e=Alistair.Francis@wdc.com>)
 id 1x8ofa-0007Lx-B5; Mon, 21 Sep 2026 20:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790038063; x=1821574063;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=qtHn+W+GPHY8cFl021rCPtpBChUy4G3bq6XQ5P67GJE=;
 b=g+bBLR004+PTxYSGr6pmvAd+8KcA6Ff6vK/K+uqHnJ5wXJK5cu9p7PYt
 QlZ6hx6/eBBjFIOUTCOlazHmIG879RTnzQIEINQxNda0uxz27qOCiUZpx
 NmZmUXLUkf+THIjxbwfNNYwSTXFoLFkwK3DAVgNE7353WoXaYciDVdGF6
 M1hqRw2JvWF2hwojKiq3wMJLvOy4G5yInTc4w9S8Zyr1pJkhz60IASr17
 80qZWjEghh1ebr3jiLjFME+uKXbYXvVl6EGAG+mfLzNCY1Zmgm4WymGZF
 2fDkgM+abCB7N3Uym1c3qOnhk6T8boWDeqmjM1fsA5b9qtC72BVcDW4Cy g==;
X-CSE-ConnectionGUID: JwPb5e0EQXGEvRXEDXoxOQ==
X-CSE-MsgGUID: lCFS9/AkQqK1uXMjzqC8Hw==
X-IronPort-AV: E=Sophos;i="6.27,115,1786982400"; d="scan'208";a="155264467"
Received: from mail-westusazon11012025.outbound.protection.outlook.com (HELO
 SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.25])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Sep 2026 08:47:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pI69aNNOXpgbTlUV55mTKlmPIRp0uKtmaFO3hm4XkpSHwccjWmMVXM8TfjDzZwPgwMgJfx2hxfFTfCeQmKk1fkmvLutjzCN68Emhmptr7o4UJ7GEMuf1o4s92QC2xn5rRG4sJVMnpQUXeG8qDxu++b48oHePSIsC2ORj8RI8PEk70Yt+AzZbQz2pFLiOW3pE0TecP3xAoHHG+txZ675B6ni5O+bOiPquNpXOkCp/pFlvTluXm/irtZp7tjpOAxMTaWTAbMpSMbbv0/4lKKvCKF1izU8ACzeu+i4LfJHEpySp06J6PuYUwEoHkK1rYMvhSqzW+b0V6PMMuspSvnVBPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtHn+W+GPHY8cFl021rCPtpBChUy4G3bq6XQ5P67GJE=;
 b=TMSPrfE62J6tS4qkNZsCb01Sv0Z97LRXy9sjuc6SgSAAB9QZdW3G+QcOgMXRsVsDbjOfFl0luiNfair+eKlwsXW26dHo9IPzIgyr8LNGuNuHwnZgRbszMkg15AppEQ1dENoNSO1LWVGmCV/AljX9sDAx8inmhFqEkmmWme5ynazAKxVwuLA0jVhmtKoW2FdrTcUsYGRH5vbS1tWL7fehs/EQWgvZKk2/gMzq/lHwNCtc9uv0hwNmUlb0A44CQOl9a8ViJgf3CFC0uiux49m2bb8MnuIFSIXjZiNrfYQAd4ykb5E5+UUnnJrlQPKDyVYOGYsTuLYoEZ+eJKh3cRO3gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtHn+W+GPHY8cFl021rCPtpBChUy4G3bq6XQ5P67GJE=;
 b=CBo8/azSMr294eAPe0VNC0XnQgKcs+3MfGN59TQsKZ6Q4FsG++JkbiGw0Aghps+3rjZFUzQPxXJf/G7fsm80uz3vffIgrp4iStBd/aqSzWHJd9FBBLuEhGTAUbotEsaKdk850/TtPvUfBUAEiIVrMZWACtRgi31Ja2kkTpp9yKA=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by SJ0PR04MB7342.namprd04.prod.outlook.com (2603:10b6:a03:290::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 00:47:34 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 00:47:34 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: Re: [PATCH] disas/riscv: Fix csrrs decode
Thread-Topic: [PATCH] disas/riscv: Fix csrrs decode
Thread-Index: AQHdQ+vdYJmb4tjJPU6prq4uQawLabbZ0BCA
Date: Tue, 22 Sep 2026 00:47:34 +0000
Message-ID: <c5a6a8e095330be0624fdfc286224ef58b36829b.camel@wdc.com>
References: <20260914015316.792751-1-richard.henderson@linaro.org>
In-Reply-To: <20260914015316.792751-1-richard.henderson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|SJ0PR04MB7342:EE_
x-ms-office365-filtering-correlation-id: c7fbaaa7-2233-4543-7302-08df18431796
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|10070799003|366016|376014|1800799024|23010399003|11063799006|56012099006|38070700021|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: MAX/VMEdhVHnXJRiZIXJDNN9Atzp5GbWD1s4poTMZ9X/0aiCJ/AYdkqJ04eVHR+5CGwIjYcEih/fS9Y74W+YncCqxMyb0Ky4gN444a9V67e4yGS1rf0O8VIQaOZPdQgbflzxl7/jIRrQcdLJcf7Z9xUEkpZDwpF1BrSOect7UtFcNDmORodH9Y1yv8pOz+WBBqP3Y1um3hrK2wK7Wy+viikYb+q0dEo/I57SD3R5QrkRxMkF9Ji4XxoAXkL//QPRtYyWCYmPobzuw6V19zCgI/HgXG8QVIch3+voFJIts3sWyMGd6atJIHVCMAkh7x1Y2EGEMHL+Ds6ME4JMrn02T+CGpfLo7Zijryb3l81BAp2Ll2I/70nzvxjCQIwp6zwSNnRelh/bKk1372EFxObHBJF24OqudaSW9qDKDFTDvEBmoJuGsjWy7pm0QAsvMTkzEbf8xgtIggrg7vIA2C6tCOwCrXv5nW8nuUS50arrAHkSP1uyHdzkul8DW5cGnOdVcISDyG7C13YcbCHTHNASvm50xLWx70EXrSSiYHeSeOoewJtxneDF5qRVATPsk+VCmPD/35PEFRD6ej0IRxW4rVEisWwjeV2gTcfFVqmmNEEPuGa4HoyVu+tcuUzl28YUHGobk06n9JFo8XEd6gP7YmFrrc8+2Z/R+kxkZCF6q14HKz3eJ4tGOvZTbBt8ialtGXv3LyWyJeDwSGtjGyoQOmB3JUe6NnG4wUv5dsC2MIo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(10070799003)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(38070700021)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzAyODlubmhlMmV6MWdicGxnYnB3YUpUTTVMRmhqYi9SdzNrRFA3RUcySGs1?=
 =?utf-8?B?eEs3RHN1TG9yUFZrT3lac1NxVXNmZys5ZDJBRnJSUDNmQThZUGp3OEJ2ek1I?=
 =?utf-8?B?bldXNDNwREx0QTQ0UFlOVTNnWmJsVXVMc1V0dWpsazJiNjhuZ0dQeWh3dFQ4?=
 =?utf-8?B?OThRRklkci9Ca2dRT216RWlSWGtXVW9MK2gzNHBId2plM0dhZk9qNVhrMmZ6?=
 =?utf-8?B?NmEyTGZOdFh1VkdEZDZSbFJvbzMxdHNCbWdEWjJUdWZrRXcwVGttd2x0RzUw?=
 =?utf-8?B?NjdiMTlRbHlDTzloSk9uVU9EcVo3bkR4ajlIRDIxeGFBUmU2dzUvOE1yZTY3?=
 =?utf-8?B?S0FYZmRmRFVuYkRWNWIxSFB2QjVZeTZodHhtdjBlMVVCbFBSa01BT1M2NDUv?=
 =?utf-8?B?eEIyYlcyYW1mbmVyTVpUWFRvM0pFcTEvNnJ6dnlPdkRKWmxqY0VZM1gzSnFs?=
 =?utf-8?B?WjNiT2NzUE5HWnFwUkJyWUpYZStiVGtEZkJhRFlnb2NiOWl6WTVqdmxDSU5U?=
 =?utf-8?B?K2VyUjZhMjJvZjJEYW5velFER0lWd0YyOVFIc2E0dDkrcTJUOEwxTmlzMnRi?=
 =?utf-8?B?UEg5RGZNbnBvZW5uNm03Y1dtOTFzWC9ZSkNjQUdIRGtlQU9BZXNTWGQ5a1Bn?=
 =?utf-8?B?c3ozRHlCNkdyaExSSit2OVBuNG9nWVl2SmdoY0phVGJZWWI4ZENjQW9nUndn?=
 =?utf-8?B?UzlsMHNIQ2d5cjdqbzJFK1prd2lUendXREJzRWJZMW9Ob0tlODNieWRmUkhV?=
 =?utf-8?B?TTNUdk8zbmEzRnpMNVR5OEU4NWYySlk3bHdncWVCUE1HNDV1NHU0WnpiaG9u?=
 =?utf-8?B?OUU5ZXErczd0TDdzeFBTRkN3MVVhb3ZLYlFYeGdSaWc5V3BsN2FFMEp6ajYr?=
 =?utf-8?B?d3RhSWpSemtmc2oxRW15d0RQSnZxNS9iV0NONUNlTmpMSndpT1MrZEZOUDNk?=
 =?utf-8?B?eDhKcURIM2J6Vk9Ca2tXM2p5RFZ1M3VqQW9GV2d4ZTlTWTF1cU42enNTZjcr?=
 =?utf-8?B?bW9yQ0dPUVpRb1JZeldmeklrcjM5QmNyT0VoTE9HUmh2SWxtL01kMXh2RjdV?=
 =?utf-8?B?emJrbmRmUFVjQW5QczRQQmlsU3dhMnNDUm5JZ1Z3OWhIWHFmdlh5eElpYktI?=
 =?utf-8?B?RWNBcmQ4OTlZS2k4NERIb0dyckdxSG93amwyM3RQL1ZLSmVrV08xSDU0QVlY?=
 =?utf-8?B?TVhLTFJ2Ukl3N05yK2FUQUd5RisxbGtLdllHMGRkNmV6WmFtTGFPdjA3aWl0?=
 =?utf-8?B?ZUV3b2U0NXVDd1VKMHFFVWZObUM2UGliYm9HeXNlRG9OWXo4YjBXUUJFOVZS?=
 =?utf-8?B?ZmE0YlZNQUhPRkRNMEFtY2ZVSktjS1VLUGlsK2hXUGthSm5USDJQd0xvTHBZ?=
 =?utf-8?B?c08wc1BGYmhVVDFaQWhlbjcxRWhDbkQ2aEoxS1JyZ21IY3pzekUyenlCS1RT?=
 =?utf-8?B?Y2tPQ0FadGdoK1lhdnhrbXJnNVZEKzJPTUNpNGc1OVFxektDekRYQ1VCdXhC?=
 =?utf-8?B?V01CeXZHWnkrVk1BNmg5Q1ZJR1pOVGVvUThwV3VmQjZ2TzBFNkUwelI3WHdC?=
 =?utf-8?B?VGNxZUxSUTBPQW9ORHRkanlTK0hWb3BtMXJONXpWWW9KV2hEcFVqU0VhVXR6?=
 =?utf-8?B?STFqN25kTTZTb3dNdzBRaDZQL2pWamdxbzU2Z2F1N3ZERUdpOU5UUFNVeVVv?=
 =?utf-8?B?emJkeXdNNXErSDVLYUlzZ3U3bTRCWHUzNlc3K0RlOHBBZDZWbGZNSU9UYkRZ?=
 =?utf-8?B?YXRjWXhvV1gza252aTkvNTNiaWo1b2V4Z05pQWNBWDNGRFc0d3JLRG9pVnJW?=
 =?utf-8?B?Qnl6Q1gzOVN0UmRuUm1ZeTJLYU9XSGhPdUh5Z0FvUUNXSkVQWDJwNmY3Rmw3?=
 =?utf-8?B?ZUROTzAvL2dkWElkckE1VHFyQWpydmRjek4yZjFxdVpSZVQ1ZTBWSTh2eDBy?=
 =?utf-8?B?NGlvTFVLMXFhalZvci9mNndoYXlrTnVRN1gyTFJhR0J0cmxVUG4xM3ErZEp6?=
 =?utf-8?B?d1NWRWFWWjYxVjNHdkJWUUg3V3RjejZtbFovd2lGTWRVRUtOQ054Y1JIaUs3?=
 =?utf-8?B?V1lSZGkwMS8yc2MxNlArK2svMzFIclZSZWRPUUFBNEY2ZFdwbjRKWHFyVUs0?=
 =?utf-8?B?ZGlWbEVLVURrcytINElGYVg0ZDliaW5FR1FWZlEzQ2FNM0hDdGxudVNYZUM3?=
 =?utf-8?B?cE1DdFhYK3dPTlRDZE9oV1dERDZOY215QVdyT1dqSDVBbHliU0hGWnluVE90?=
 =?utf-8?B?SGpldFN5Z1VUTzNyMCtaeEpySHBMZm1KTndKYlVDb0t4Y0lCWWtQN0JmMGFZ?=
 =?utf-8?B?RnpEbTZ1eWhMR0p0T2RYQWQ2NkkydlVETG9VUjEvVVVTVStpUjZJTG45eUgv?=
 =?utf-8?Q?/bqvYH89jOhhhWnAp1aZ4eVmbgpvXaayh419ovcFIhCBv?=
x-ms-exchange-antispam-messagedata-1: IWXiq8M0BAGiihH3ydIw4T/ZMgY0fPCUJ1c=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72A80AF10D210F4AA8E8D7D0178161E8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 3+Tz7NRrb/y0qCrym/Iu483BN8beIvJuQ15+c4pPfuXwXwchbnAMmL9c693KdlPS1HFHFaSrlBsK5N1tj8vK0NqR1haOpiBpHj1oQceGaR/brpuoI56ldPSqTrqOTuBsAtuJWH7SEeu1XzQag+6Lc3V/qXpdGcmYza1HJ3UY/HVKC9seBO3dopdkXw3qXRPhrxA6M67nlR5llgRSwT9mf4gQo9+ilaEQDL24n1orneWCaH3u3fAO3nU/xWqlQ+FphPmQe0jilCDAGVxvl0EY3qsTfTPRgj94kGpv41msdgsg41nn7FhCL1h9Qk8BNPE6KibCoFVSHlq2Lc0AU9oNfA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gZOMso6gzW1XHNa//DzjKpPRN+edClMkyj0EznhqRt7hOZop13IirFeR5hS0jPGCWpwecVB9R1Dodln0FiceIuzCo2WqpCaI1HGhWeWkY/igSsKiTCEhFR0zgnXAzSFowbKCpuPn2ugiclhYRUIUmgLl9s94Q+a7MQvNLF5t+Kt2hBmKNld3GYDF//wXHXI6bqKHIoBl2k0ogXvczd8JG6NGbAnEWek7OMpVGk7dTEczOB89FMV3Vd/EY/6Ek8NC+0DWL+2Ah+NFbbQuX1p4SuMaoqvXDHuTLagXsKD7g8TzPl447SSOWbsGOdumAQ7qTSCYdMrFzTpq6oZDwZQZfbuZ06m7E+SfQFa9iTFa1U5xTQb0Y6xcdI7DOF7Xu1WIv0W2SYHCwnKb6YhkJAmoxbh9ck93v2RZETdi8UtwTqnT5/Hxq/GOhUxGRyW/GjHiAEJ3pEmhVic+rPXE4bbqRm8k65FW6cSutpjePfDcSIm8JpH25MuyFRFARogmzyVNk+D79+HI+xeQLES5MZsk3TrW1jFy5uznhASsTyyxQ3/XjdnhOXkpmyI6rybmEaIFPsznveaCpGWVWCasi7yDpDbC98YJGtmYjHCJy38rZ4H2GdOl+Dr79FjmDeGKHNIz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fbaaa7-2233-4543-7302-08df18431796
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 00:47:34.6332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c39JBFVFhW58RC3RjVgBqNy7MgvOFdJI53WuSv77j8hnIkTcytL1w/M036YgYMUAULTajJVnJeWp6RftX8JkbxE3SGUApCxQnBWeV23NwKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7342
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=718ae7c5e=Alistair.Francis@wdc.com;
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

T24gU3VuLCAyMDI2LTA5LTEzIGF0IDE1OjUzIC0xMDAwLCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90
ZToKPiBSZXNvbHZlczogQ292ZXJpdHkgQ0lEIDE2ODU1MTMKPiBGaXhlczogNGZlYzk4MWYxOGZk
ICgiZGlzYXMvcmlzY3Y6IFNwbGl0IHJ2aV9vcGNvZGVfZGF0YSIpCj4gU2lnbmVkLW9mZi1ieTog
UmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+CgpUaGFua3Mh
CgpBcHBsaWVkIHRvIHJpc2N2LXRvLWFwcGx5Lm5leHQKCkFsaXN0YWlyCgo+IC0tLQo+IMKgZGlz
YXMvcmlzY3YuYyB8IDMgKy0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIg
ZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2Rpc2FzL3Jpc2N2LmMgYi9kaXNhcy9yaXNj
di5jCj4gaW5kZXggZTg1ZGJhYzAzNTEuLmVmOGI3ZmYyMGY5IDEwMDY0NAo+IC0tLSBhL2Rpc2Fz
L3Jpc2N2LmMKPiArKysgYi9kaXNhcy9yaXNjdi5jCj4gQEAgLTI1NjAsNyArMjU2MCw2IEBAIHN0
YXRpYyBjb25zdCBydl9vcGNvZGVfZGF0YQo+ICpkZWNvZGVfaW5zdF9vcGNvZGUocnZfZGVjb2Rl
ICpkZWMsIHJ2X2lzYSBpc2EpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBjYXNlIDI6Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm4gJm9wX2NzcnJzOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChvcGVy
YW5kX3JzMShpbnN0KSA9PSAwKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBzd2l0Y2ggKG9wZXJhbmRfY3NyMTIoaW5zdCkpIHsKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgMHgwMDE6IHJldHVybiAmb3BfZnJmbGFnczsK
PiBAQCAtMjU3NCw3ICsyNTczLDcgQEAgc3RhdGljIGNvbnN0IHJ2X29wY29kZV9kYXRhCj4gKmRl
Y29kZV9pbnN0X29wY29kZShydl9kZWNvZGUgKmRlYywgcnZfaXNhIGlzYSkKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgMHhjODI6IHJldHVybiAmb3BfcmRp
bnN0cmV0aDsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBicmVhazsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biAmb3BfY3NycnM7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgMzogcmV0dXJuICZv
cF9jc3JyYzsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSA0Ogo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChkZWMtPmNmZyAmJiBkZWMtPmNmZy0+ZXh0X3ppbW9w
KSB7Cg==

