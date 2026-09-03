Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81414C61DD6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 01:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1whn-0000B6-2u; Wed, 02 Sep 2026 21:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1whm-0000At-99; Wed, 02 Sep 2026 21:57:30 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1whk-00045Y-3K; Wed, 02 Sep 2026 21:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788400649; x=1819936649;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=SSUeDTUWtekWFTYLBNz3E2aDce7XODWQf1mjPQfRevo=;
 b=ZzBpDZrcm9cVEvIkuMj0i52Kjt+OHiSf45HhbBRpzZwZ+X2wxUntK4+J
 O/vq/TrtEK7KDhkMvaCTcpiWwmbOUraDMSxaVuR4mUH5MWnKzTwkhxmPk
 RDlwbRRadBjikPPhCba4kcZguR7rSO0RXzYM4o8mPOAqh2M/RogtvXzIS
 mdv9ivcD0B54sW4zjnZfA7r2Zzs0JubwZduhJGyhq2TbyGdwqqQUWiGYd
 3TheKzNuc+K449p6Ve9Y+DvQz4xW7ErVfh/9ueuU96YrHJsgT4ixl+Yne
 lMQfBplkcoFUeKWzy2TfA7Zacy4dZlxhqIchIj0EuTWxGr0M0RsPj2+L8 w==;
X-CSE-ConnectionGUID: ftMtj45vSrqpo988WaikLQ==
X-CSE-MsgGUID: sDIY2428QyaDT+bBVaxeyw==
X-IronPort-AV: E=Sophos;i="6.25,258,1779120000"; d="scan'208";a="153875366"
Received: from mail-eastus2azon11010060.outbound.protection.outlook.com (HELO
 BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.60])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 03 Sep 2026 09:57:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dT6EOcs5bgONvpaIhedkMn18x998EPyGNQg4J98ZdDdKJPIEI4iRFipzCJ9yexeD7HlqZvpsnuAHQHd52mhBMrTLm4fzZp0YcUE7H8FIvcfICemGLB3Wj4zoWW06InayiVWHQR/Z4knvxY+twVJ/WgDAqbl93DbKOUGdiVg7LroUvl8QnRrM1iJqCdDNzRSblNhODY55AyPmJmFsVMz1hOj8vAmlwsA+729ijnSBBJNtNe55XKRZQipJ+eI+nEG7Pb3s7Mdb6HCWvVxBqXczrxK8XgBOT05uIt1IyC4p8d1+JaI3iZVLVMZlNUSW53Nauf4TznHT0E4HJIKj8EfvSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSUeDTUWtekWFTYLBNz3E2aDce7XODWQf1mjPQfRevo=;
 b=db77eZ1MAqNfxmxcIKz1ZANsoeOZc5xb3PTNOotwDl+EjZbaNyBzirs3ygBREVbmu87AucG+rQf2haUicvaeJMJIey2LHtaP6wgu92u0hsTKC1SzjkiEVlMPsZCZ4+BxbLsVoyGOO/BHmtf1jhPPNa9YcNZ3LTBlYI/y2xvsu3GBMRlZ6aQKSYiFeu9N6ExgqToHEi/gq5TDHQJwOSSF9jritIKcKQKwWm18PAmIag99+QAbShKJHRuznn5815T08VatJQ+M/j+V/4Zn8lCcL5GTuYQGdtEl+4vRyYHga6NNT8Xkye2eq4seCGgQDwMngONt+XqABbGwwzfcIUFh1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSUeDTUWtekWFTYLBNz3E2aDce7XODWQf1mjPQfRevo=;
 b=WzkansAhvzduQ1IKLZg6x7kzKR11iV1aD4ytRkbiaGa/NZ3VSZY87fPDcSh4MeR3IFUBl3jib+LfEUqcE3te076ise6X0HAmRuDe6PmFxZDsDErflGdSAK/lSxxMRNFfmzPr2zYI883tcOUclburmBytr9ROj8U040cK1VynoyQ=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by IA3PR04MB9355.namprd04.prod.outlook.com (2603:10b6:208:515::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 01:57:23 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 01:57:23 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "joel@jms.id.au" <joel@jms.id.au>
CC: "npiggin@gmail.com" <npiggin@gmail.com>, "mpe@kernel.org"
 <mpe@kernel.org>, "portias@oss.tenstorrent.com"
 <portias@oss.tenstorrent.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "clg@kaod.org" <clg@kaod.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "asrinivasan@oss.tenstorrent.com" <asrinivasan@oss.tenstorrent.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v2 11/16] hw/riscv/atlantis: Use local reference for
 system memory
Thread-Topic: [PATCH v2 11/16] hw/riscv/atlantis: Use local reference for
 system memory
Thread-Index: AQHdOO6+e2Pc/n91XkSnLysy+nMobLa8HUAA
Date: Thu, 3 Sep 2026 01:57:23 +0000
Message-ID: <a9eec42b3677d9f865cb0a8412bf9b3d975c4640.camel@wdc.com>
References: <20260831021500.82565-1-joel@jms.id.au>
 <20260831021500.82565-12-joel@jms.id.au>
In-Reply-To: <20260831021500.82565-12-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|IA3PR04MB9355:EE_
x-ms-office365-filtering-correlation-id: b2ee6209-3c7e-44c7-6d96-08df095eb281
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|19092799006|366016|1800799024|23010399003|10067099003|18002099003|22082099003|4143699003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info: foO+TopW4xftpSn3cbHXgjuV4V5M53MDlZz0N2kIFhUcBI4zFG3jP0wjqVHYbnOP3qLi9/nk5a3VxwQczJkb/EjyB+5wV38awVpAWx5qF4gedq9Gt4UwQ7SOSIyNpnIQekS1odyDjKurXWDJx3obtnG32Vt30JVLSOGQ6CILlAPENnTjSkGyeY6Ha1zjteckFF04C8yctPOKtSamYlSz8drIVp/ZAn8/y88+SJuDk0KOUQSWY0PnyaoJqtlmaoUd4k46iChOUw9oIuq89MT+KQKFvA+Zaqb2Jpjg7Fjcrnu2M8KEPk1LjXUipA2YaVTMfwd6aP6XtIcQ959HKaBmPNAyUTr7qf/oRn6nVUjnpvcu4+pBcyvyA+EKH6DdE+gYXHoyXEl1dLEeGPE14sbHszk9a4C0QwomCcr6ua7zHMIkfN3I9VhTUw37g5uclw8U7gdI+XpVCba1nMpdazrz1wskBryCZ+8YJ9tKuvWzbLyhy28RKIvapeVgEIEEBfsvfqJtXZz60aNety3RewkKbD5zW1J9dL9Ee+z6YPMLRo/i6N1SbFOS8bVOUGgaGSIFfHQ2YV+XxS64CGvwPhCM0OMCBshLC4+tsAvPf0z2AgQF/nGHdzbVTIJY1TuA5Apu10sBnKHzix+MWzfqfOfFPJ61LFft2KtoPW4RxL7Qmowmv/O72LXmhuBg1XbIv2jiquzt7h6D5MrRMOFu/r35rgWoL/UZ26YFOgdF0xobVSs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(19092799006)(366016)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmdiQzVNK2hsb3hkTHRpVks2Y1VjWFRScE9RS0UxUUZRRjN6NEZPd1Uzdjlk?=
 =?utf-8?B?Uk5RV3I1dENjdmdYaUxjdG9SVjExM0F4d3MvQ2NLaHcyM2tHOTYyT2paVC9H?=
 =?utf-8?B?akJpcDNjWWxiSEk1TUdFQXhpZHAySlRQdStxVmlRaTB0clNYWEpGOEFOV0F6?=
 =?utf-8?B?R205S0o1aHhNVkgvUWJLWXFzYi83NGE2K1ZRTHJSdnpjQnMwTXpQaGgyb2Mr?=
 =?utf-8?B?RWFGNlhYRzdWMmZPblhCSmJ3a3dxdXZnUUhLNU1uUEdaZU1qNDlyQ1Bmay9w?=
 =?utf-8?B?UXF4bkpvenBwM2xET2MxeXRJRTJLZm5OQjdmQktFd0drTndXZUozaUN6VENh?=
 =?utf-8?B?M0Uvc3l1bWtRM1g5M2VFTFhUdEpGS0xnVGUwSTZHNmRIN1l3UVZldEliMU9Q?=
 =?utf-8?B?aGQwMUNwdWlvMlZnemhEWEF3ckR5V1NEMlVOb2RCQ1JpMGRGb0xna3hDL3F5?=
 =?utf-8?B?bGVPSnRVbWNTZWtSM1hsWmVYaW9Lb2EyMGV4aEdIZXRocG9NSGJyNjVIcyt3?=
 =?utf-8?B?cCtLbnJ0WCtJQTNlRU4xb2d2aVdZbU1Ed2FhdmczRldBb1V4WCtDcG9oajkr?=
 =?utf-8?B?eEx1bjQ4a3ZlUkhCbXE0TFJHWlpTeGYxaTZOWXh5cGpPcGJHNjd6Y21BRlpD?=
 =?utf-8?B?MEJSRGNZWUlLME43TjcwRkllYklSTGlkbVZSdzFZSm80ZEtOMldoQi80OG1F?=
 =?utf-8?B?LzF0UTZVWDdTSVB4UjBXWFc0djVJcWJHalBTaE9adjhYUXlRMmFRR1ZHTWpi?=
 =?utf-8?B?SFVHNDF1UkNLRHZkT05uMDNkeFdrVW4zRE5qVThMdUl5UUQvWEdpS2VHRkNB?=
 =?utf-8?B?ZHNjVDlrTEJYM2JyWVRyQjMzU3UxVzlnNnpzSld6MlJ5Q04rV09mQWVGc041?=
 =?utf-8?B?Ry9NWkVWa2ZZZXZmZGh5aGZyelRNVTYrcXEwWXgrU1pKTHd2UkttMXJ0ajVs?=
 =?utf-8?B?L0RYbThwOEFlckx5UzNLcGN2dFhMdjJQK1FCblZIOHA3Rmt1OVBxdVZ0STFC?=
 =?utf-8?B?T3F2RTQzZjlRQlQ0WEl4WTJYc05FT3RqSFJ3LytwVVRxMWhxbWlHY0VHaTNh?=
 =?utf-8?B?STN2YWhnc1NtNWZZYS9ZeW1STGNBVG9Ddy90ak0xTy9ualVSQ2FtbXJ6RUhQ?=
 =?utf-8?B?ZVBzY3htbXhrekxKVkpiWDdqSnk0QXFQcHZ1VHVJQ0dSZ05XcXg3cjVTblFC?=
 =?utf-8?B?em5uRExRRDFVQWVuclhvT1cvZlg0empKR1RFV2lDbUR4U0E5dFViREJnU2hp?=
 =?utf-8?B?L2IyWWszYnk4M3FSZlVtVVhoZXUwSnp2MktTcXh6amlyRDM2QzQwSmhYek83?=
 =?utf-8?B?Q2w2dC9DbmExNzZlOUhNdnhlVTdkUXh2SjltWVV1dUJwT3NJSEdXVGd1bFVJ?=
 =?utf-8?B?ZkduMEYzZTFpSjhVM3Ftdkx6TFJQUlFpRjhuSTBhNzJtYzFWeERqU2xCYWQr?=
 =?utf-8?B?QklnSnlJalhCeTMxQ0ZScG5SVHAwVFNiNW1OYlRYL21rZ2VYcWV2Nnh5SVNY?=
 =?utf-8?B?dGtVZzAxd1lnOVNjUWNlMTR1UmxSM3hndUIreGFyaURlelJVK0VWaUpYVXR3?=
 =?utf-8?B?MC8zaUFZU0g3WTNkRVIvUTNuR3NpK2FyMGRpR1NOWktXUkZqZzEwb1NIU0ls?=
 =?utf-8?B?d28rTUJ4eEdmWFQ4VEtyM0VZcUhHdFpxRXhyaVhoQnJxU2s2eGRtNzNudGkr?=
 =?utf-8?B?bGUwMk13cENwc1Bha2tBeHFuRzJOY2kzeFBmVW9xSmN0RFpJQ3RSOTlwN2hw?=
 =?utf-8?B?emFqRTJTZk4zdVgvaWZmU3ltNGlYaFpCaDJXOU1JejZSdG5RVWxsRGUxRGlq?=
 =?utf-8?B?SldQelNCd0hUdVdpS0dRdkJNUU9GdER4SCt1YmUrZ3pUNGZjRENWVVBaaXJF?=
 =?utf-8?B?d2hYOHY1bUVzU1JvWXgzTzF1Mk1IQXJOaUJucTREaklZR2pSdm9OMStFL1NZ?=
 =?utf-8?B?Q1FCNXRXcWlrRDNabFpvODUyUEZRREhOeWJ5Q1cya1A5UmU1ZDVHUFFUeVRB?=
 =?utf-8?B?MG9qM1U5SkR4TzBEWVNCSHhuQUs5QVkvOW5UMmZrbGh0Q2VoazRXbkl4V2xY?=
 =?utf-8?B?RWtlRnczUVJ0dlZLTk9BRnFhdFVCMHN4cnpSemJOWXoxdTd2aGhHcFBFT2tB?=
 =?utf-8?B?OGZTUXhxQUZ3c1d0Sy82Y0Fxb0d2MHVtU2RQNmk2dm1UMlEvVHROOTB4ZlU4?=
 =?utf-8?B?VVdlU29ScElJeE9LakZhVW1yRGx6V0kxQjdmME9zZ1dlYXhMaW5PdVVJTkJP?=
 =?utf-8?B?bnJnTm5YNHhWVjRCTHF1VzZ4WmNDMFpmMGJTM1ZnY2ZQaUtWS0ZwVkxETm1U?=
 =?utf-8?B?WEIyV3FKL3lzcS94bjVaT1JJa2lHajcrYlFvQ0tjbS9SOE5SY295b1F5VE1y?=
 =?utf-8?Q?5QsymXJq05SwpFrImSpOV19Xu02RlJiyYRMbOceelGhcm?=
x-ms-exchange-antispam-messagedata-1: UlXIrbYjQpcJ8ePFmnrnhmqseCWcIxQ8VtU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A48DE93683BBB24FB6530E144F616C58@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 5Kv3ALQf8/OtGMbl8dOFnFuVsGza5yfKRp9xVY3HIOF4ee218vDMUcDqyB2CFFr7po08Arr2kahjMomi2KqiRo0cbPsqobw5lWUI0tSpjYU03laY5CdIXJQwEOQXLs4uI2FsUTLgJXFanE2V2K4lpv5GlJC5KJaPYw7BfbshkoILAb7Mg3o8mujPtMeOf3JmXqSl4wjKirzRLAncqzSuCTmmG+Uq37fa9XWhOikAiEbsKwLNmGPJYQUgxbZeG2MEEBDQ6oOrIHIC+lFRAPF49c6iXiLKwZ+BZuzadJgah8OL7/rfkM62bVHn6UEnN0SyrjkMWjq/NRUXrhJpo7TpHw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LiV5pZ4hVBkfypga8Gr1gvg1ygwp6QDc0duiGq4g1Ff1/iR/hrt5OENEb63LXV5RxSpneWzfktGZk0yNvxnzTPQfhUu4xyICWYaPdK20np2+Y9B6md2EN8od8BVQLY36oe4WWmwElYKQxokAhL206DR3a5XzwX5IbIXa6P4aRucRnsfOhtrgoQoCndiPZ379QwGYu9Dyir8KfwM+vi2iaXhnO4AUnBqOnb4TyOfD/SywpOU+a/yf1kOOAIt57V9kXN2VYk5cJx8KEiGWuPCXADQTpM82Kp/N///sNW4WRWSi2xM03ZiogIoNwtY34Sq7to5CZjXmUfcfnMySXgxoz/dywM2272WXoABxtYn3dsTmf4veuPOaJ0litSKChYkjcOSfX7RQtrLmAWBmmyDjqi0CFwNl7LnuaNFe18NVkiEdGXXw9M+sv5b4nVHJqTHLs7guHOb+LAMPpvvHzP2qt7ZRjiJXE4pp6s+WGDqq15NQPyeO9rgz5VV4aB/3iRBy+JY6CuK1E7HEpnc5nBsvsNTcgeev6cqV0okiIGueZXERdoJykhCKjIZyF2ZF/u/C5vdG6bZNeaG7EsL9exTaxZdWT7ta7p65+Y93ZdAt+4nU+Vw1M07UVxd2bK+vZ4JX
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ee6209-3c7e-44c7-6d96-08df095eb281
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 01:57:23.5899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ADU+2audFyMAJTB876n/ShEaEUM08ejJPuo83Blr08x+BaRUG2XtCGsPr3nkk1grtWblVQxFP4ysk9pr0/xm+OjvWQx1aaMbfkvz2mx7EM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9355
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=6997dc6e7=Alistair.Francis@wdc.com;
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

T24gTW9uLCAyMDI2LTA4LTMxIGF0IDExOjQ0ICswOTMwLCBKb2VsIFN0YW5sZXkgd3JvdGU6Cj4g
SW5zdGVhZCBvZiBzeXN0ZW1fbWVtb3J5LCBhdHRhY2ggZGV2aWNlcyB0byBUVEF0bGFudGlzU3Rh
dGU6Om1lbW9yeQo+IGluCj4gcHJlcGFyYXRpb24gZm9yIHRoZSAtPm1lbW9yeSBiZWNvbWluZyBh
IGNvbnRhaW5lci4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlk
LmF1PgoKUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2Rj
LmNvbT4KCkFsaXN0YWlyCgo+IC0tLQo+IMKgaW5jbHVkZS9ody9yaXNjdi90dF9hdGxhbnRpcy5o
IHzCoCAxICsKPiDCoGh3L3Jpc2N2L3R0X2F0bGFudGlzLmPCoMKgwqDCoMKgwqDCoMKgIHwgMTkg
KysrKysrKysrKy0tLS0tLS0tLQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCsp
LCA5IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3Jpc2N2L3R0X2F0
bGFudGlzLmgKPiBiL2luY2x1ZGUvaHcvcmlzY3YvdHRfYXRsYW50aXMuaAo+IGluZGV4IDY0MjQ5
MGQyMTc0My4uYTI5YzY3YzFjZmNmIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvaHcvcmlzY3YvdHRf
YXRsYW50aXMuaAo+ICsrKyBiL2luY2x1ZGUvaHcvcmlzY3YvdHRfYXRsYW50aXMuaAo+IEBAIC0y
OSw2ICsyOSw3IEBAIHN0cnVjdCBUVEF0bGFudGlzU3RhdGUgewo+IMKgwqDCoMKgIE5vdGlmaWVy
IG1hY2hpbmVfZG9uZTsKPiDCoMKgwqDCoCBjb25zdCBNZW1NYXBFbnRyeSAqbWVtbWFwOwo+IMKg
Cj4gK8KgwqDCoCBNZW1vcnlSZWdpb24gKm1lbW9yeTsKPiDCoMKgwqDCoCBSSVNDVkhhcnRBcnJh
eVN0YXRlIGNwdXM7Cj4gwqDCoMKgwqAgRGV2aWNlU3RhdGUgKmlycWNoaXA7Cj4gwqDCoMKgwqAg
RGVzaWduV2FyZUkyQ1N0YXRlIGkyY1tUVF9BVExfTlVNX0kyQ107Cj4gZGlmZiAtLWdpdCBhL2h3
L3Jpc2N2L3R0X2F0bGFudGlzLmMgYi9ody9yaXNjdi90dF9hdGxhbnRpcy5jCj4gaW5kZXggYzQ3
MWM3Y2ViZjEyLi4xYzc1ZmI1ZDhkNTcgMTAwNjQ0Cj4gLS0tIGEvaHcvcmlzY3YvdHRfYXRsYW50
aXMuYwo+ICsrKyBiL2h3L3Jpc2N2L3R0X2F0bGFudGlzLmMKPiBAQCAtNDgyLDEzICs0ODIsMTQg
QEAgc3RhdGljIHZvaWQKPiB0dF9hdGxhbnRpc19tYWNoaW5lX2luaXQoTWFjaGluZVN0YXRlICpt
YWNoaW5lKQo+IMKgewo+IMKgwqDCoMKgIFRUQXRsYW50aXNTdGF0ZSAqcyA9IFRUX0FUTEFOVElT
X01BQ0hJTkUobWFjaGluZSk7Cj4gwqAKPiAtwqDCoMKgIE1lbW9yeVJlZ2lvbiAqc3lzdGVtX21l
bW9yeSA9IGdldF9zeXN0ZW1fbWVtb3J5KCk7Cj4gwqDCoMKgwqAgTWVtb3J5UmVnaW9uICpyYW1f
aGkgPSBnX25ldyhNZW1vcnlSZWdpb24sIDEpOwo+IMKgwqDCoMKgIE1lbW9yeVJlZ2lvbiAqcmFt
X2xvID0gZ19uZXcoTWVtb3J5UmVnaW9uLCAxKTsKPiDCoMKgwqDCoCBNZW1vcnlSZWdpb24gKmJv
b3Ryb20gPSBnX25ldyhNZW1vcnlSZWdpb24sIDEpOwo+IMKgwqDCoMKgIHJhbV9hZGRyX3QgbG9f
cmFtX3NpemU7Cj4gwqDCoMKgwqAgaW50IGhhcnRfY291bnQgPSBtYWNoaW5lLT5zbXAuY3B1czsK
PiDCoAo+ICvCoMKgwqAgcy0+bWVtb3J5ID0gZ2V0X3N5c3RlbV9tZW1vcnkoKTsKPiArCj4gwqDC
oMKgwqAgcy0+bWVtbWFwID0gdHRfYXRsYW50aXNfbWVtbWFwOwo+IMKgCj4gwqDCoMKgwqAgb2Jq
ZWN0X2luaXRpYWxpemVfY2hpbGQoT0JKRUNUKG1hY2hpbmUpLCAic29jIiwgJnMtPmNwdXMsCj4g
QEAgLTUwNCw3ICs1MDUsNyBAQCBzdGF0aWMgdm9pZCB0dF9hdGxhbnRpc19tYWNoaW5lX2luaXQo
TWFjaGluZVN0YXRlCj4gKm1hY2hpbmUpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmVycm9yX2Fib3J0KTsKPiDCoMKgwqDCoCBzeXNi
dXNfcmVhbGl6ZShTWVNfQlVTX0RFVklDRSgmcy0+Y3B1cyksICZlcnJvcl9mYXRhbCk7Cj4gwqAK
PiAtwqDCoMKgIHMtPmlycWNoaXAgPSByaXNjdl9jcmVhdGVfYWlhKHN5c3RlbV9tZW1vcnksCj4g
K8KgwqDCoCBzLT5pcnFjaGlwID0gcmlzY3ZfY3JlYXRlX2FpYShzLT5tZW1vcnksCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdHJ1ZSwgVFRfSU1TSUNfR1VFU1RTLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRUX0lNU0lDX1NUUklE
RSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBUVF9JTVNJQ19TVFJJREUsCj4gQEAgLTUxNyw3ICs1MTgsNyBAQCBz
dGF0aWMgdm9pZCB0dF9hdGxhbnRpc19tYWNoaW5lX2luaXQoTWFjaGluZVN0YXRlCj4gKm1hY2hp
bmUpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgVFRfSVJRQ0hJUF9OVU1fTVNJUywKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBUVF9J
UlFDSElQX05VTV9QUklPX0JJVFMpOwo+IMKgCj4gLcKgwqDCoCByaXNjdl9hY2xpbnRfbXRpbWVy
X2NyZWF0ZShzeXN0ZW1fbWVtb3J5LAo+ICvCoMKgwqAgcmlzY3ZfYWNsaW50X210aW1lcl9jcmVh
dGUocy0+bWVtb3J5LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzLT5tZW1tYXBbVFRfQVRM
X0FDTElOVF0uYmFzZSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVFRfQUNMSU5UX01USU1F
X1NJWkUsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDAsIGhhcnRfY291bnQsCj4gQEAgLTU0
MCwyMyArNTQxLDIzIEBAIHN0YXRpYyB2b2lkCj4gdHRfYXRsYW50aXNfbWFjaGluZV9pbml0KE1h
Y2hpbmVTdGF0ZSAqbWFjaGluZSkKPiDCoAo+IMKgwqDCoMKgIG1lbW9yeV9yZWdpb25faW5pdF9h
bGlhcyhyYW1faGksIE9CSkVDVChtYWNoaW5lKSwgInJhbS5oaWdoIiwKPiBtYWNoaW5lLT5yYW0s
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAwLCBtYWNoaW5lLT5yYW1fc2l6ZSk7Cj4gLcKgwqDCoCBtZW1vcnlfcmVnaW9uX2FkZF9z
dWJyZWdpb24oc3lzdGVtX21lbW9yeSwKPiArwqDCoMKgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJl
Z2lvbihzLT5tZW1vcnksCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzLT5tZW1tYXBbVFRfQVRMX0REUl9ISV0uYmFzZSwK
PiByYW1faGkpOwo+IMKgCj4gwqDCoMKgwqAgbG9fcmFtX3NpemUgPSBNSU4obWFjaGluZS0+cmFt
X3NpemUsIHMtCj4gPm1lbW1hcFtUVF9BVExfRERSX0xPXS5zaXplKTsKPiDCoMKgwqDCoCBtZW1v
cnlfcmVnaW9uX2luaXRfYWxpYXMocmFtX2xvLCBPQkpFQ1QobWFjaGluZSksICJyYW0ubG93IiwK
PiBtYWNoaW5lLT5yYW0sCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAwLCBsb19yYW1fc2l6ZSk7Cj4gLcKgwqDCoCBtZW1vcnlfcmVn
aW9uX2FkZF9zdWJyZWdpb24oc3lzdGVtX21lbW9yeSwKPiArwqDCoMKgIG1lbW9yeV9yZWdpb25f
YWRkX3N1YnJlZ2lvbihzLT5tZW1vcnksCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzLT5tZW1tYXBbVFRfQVRMX0REUl9M
T10uYmFzZSwKPiByYW1fbG8pOwo+IMKgCj4gwqDCoMKgwqAgLyogQm9vdCBST00gKi8KPiDCoMKg
wqDCoCBtZW1vcnlfcmVnaW9uX2luaXRfcm9tKGJvb3Ryb20sIE5VTEwsICJ0dC1hdGxhbnRpcy5i
b290cm9tIiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcy0+bWVtbWFwW1RUX0FUTF9CT09UUk9NXS5zaXplLAo+ICZlcnJvcl9mYXRhbCk7
Cj4gLcKgwqDCoCBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb24oc3lzdGVtX21lbW9yeSwgcy0K
PiA+bWVtbWFwW1RUX0FUTF9CT09UUk9NXS5iYXNlLAo+ICvCoMKgwqAgbWVtb3J5X3JlZ2lvbl9h
ZGRfc3VicmVnaW9uKHMtPm1lbW9yeSwgcy0KPiA+bWVtbWFwW1RUX0FUTF9CT09UUk9NXS5iYXNl
LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgYm9vdHJvbSk7Cj4gwqAKPiDCoMKgwqDCoCAvKiBVQVJUMSwgdGhlIHNvYyBj
b25zb2xlIChVQVJUMCBpcyBmb3IgdGhlIGJvb3QKPiBtaWNyb2NvbnRyb2xsZXIpICovCj4gLcKg
wqDCoCBzZXJpYWxfbW1faW5pdChzeXN0ZW1fbWVtb3J5LCBzLT5tZW1tYXBbVFRfQVRMX1VBUlQx
XS5iYXNlLCAyLAo+ICvCoMKgwqAgc2VyaWFsX21tX2luaXQocy0+bWVtb3J5LCBzLT5tZW1tYXBb
VFRfQVRMX1VBUlQxXS5iYXNlLCAyLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHFkZXZfZ2V0X2dwaW9faW4ocy0+aXJxY2hpcCwgVFRfQVRMX1VBUlQxX0lSUSksCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMTE1MjAwLCBzZXJpYWxfaGQo
MCksIERFVklDRV9MSVRUTEVfRU5ESUFOKTsKPiDCoMKgwqDCoCAvKgo+IEBAIC01NzAsNyArNTcx
LDcgQEAgc3RhdGljIHZvaWQgdHRfYXRsYW50aXNfbWFjaGluZV9pbml0KE1hY2hpbmVTdGF0ZQo+
ICptYWNoaW5lKQo+IMKgwqDCoMKgwqAgKi8KPiDCoMKgwqDCoCBvYmplY3RfaW5pdGlhbGl6ZV9j
aGlsZChPQkpFQ1QocyksICJ1YXJ0MSIsICZzLT51YXJ0MSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBUWVBFX1VOSU1QTEVNRU5URURf
REVWSUNFKTsKPiAtwqDCoMKgIG1taW9fbWFwX3VuaW1wbGVtZW50ZWQoc3lzdGVtX21lbW9yeSwg
U1lTX0JVU19ERVZJQ0UoJnMtPnVhcnQxKSwKPiArwqDCoMKgIG1taW9fbWFwX3VuaW1wbGVtZW50
ZWQocy0+bWVtb3J5LCBTWVNfQlVTX0RFVklDRSgmcy0+dWFydDEpLAo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAidHQtYXRsYW50aXMudWFy
dDEiLCBzLQo+ID5tZW1tYXBbVFRfQVRMX1VBUlQxXS5iYXNlLAo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzLT5tZW1tYXBbVFRfQVRMX1VB
UlQxXS5zaXplKTsKPiDCoAo+IEBAIC01ODIsNyArNTgzLDcgQEAgc3RhdGljIHZvaWQgdHRfYXRs
YW50aXNfbWFjaGluZV9pbml0KE1hY2hpbmVTdGF0ZQo+ICptYWNoaW5lKQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVFlQ
RV9ERVNJR05XQVJFX0kyQyk7Cj4gwqDCoMKgwqDCoMKgwqDCoCBzYmQgPSBTWVNfQlVTX0RFVklD
RSgmcy0+aTJjW2ldKTsKPiDCoMKgwqDCoMKgwqDCoMKgIHN5c2J1c19yZWFsaXplKHNiZCwgJmVy
cm9yX2ZhdGFsKTsKPiAtwqDCoMKgwqDCoMKgwqAgbWVtb3J5X3JlZ2lvbl9hZGRfc3VicmVnaW9u
KHN5c3RlbV9tZW1vcnksCj4gK8KgwqDCoMKgwqDCoMKgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJl
Z2lvbihzLT5tZW1vcnksCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHMtPm1lbW1hcFtUVF9BVExfSTJDMCAr
IGldLmJhc2UsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN5c2J1c19tbWlvX2dldF9yZWdpb24oc2JkLCAw
KSk7Cj4gwqDCoMKgwqDCoMKgwqDCoCBzeXNidXNfY29ubmVjdF9pcnEoc2JkLCAwLAo=

