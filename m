Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F0DC5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 08:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siVI5-0002f4-FB; Mon, 26 Aug 2024 04:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1siVI4-0002eT-1D
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 04:41:32 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1siVI0-0006ZW-EA
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 04:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1724661688; x=1756197688;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8hfq/QywvfVWawa+RIphyt7RUu/2lg2sM9mS1VlQnbs=;
 b=eBxDA204uYBY2/0NlQaO+ETILX4r0b+bvGAv7kdyxY2hXOsVndfyVAvZ
 mg71LI6ro51QxO5zH6uUNzgXmJAhLaHFWW54shRk8qvXpd+UDP8p1hrfb
 aw9Ri2W2jlKhuGUXfKbmF12wiGm/QxJspayNvqYjwEe/aDnk1e+H1OxDq
 cy3OIG0wN40IR4MZ27UEf7HKgS1TpIAHPGmOW+LKwpcAqJkUpdoDiUJS5
 PUR0vAWRSZjPp5zEnANfgCzdGKknAdTqlnHzDgEZdt/7y8XWIETnP+pcz
 Y5joNeVGaIR3EAQyyT2sfFR6IznUR6qiSZ6g591Kh+HLJ4UIG2tVwEgpV w==;
X-CSE-ConnectionGUID: 62OVFra1T2us8Ieu0Xxv9g==
X-CSE-MsgGUID: M8qt/QZsQ3SIRdFlkYJBbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="33636124"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; d="scan'208";a="33636124"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2024 01:41:24 -0700
X-CSE-ConnectionGUID: ErMzHerZRLuUwChs++nsAw==
X-CSE-MsgGUID: tw6+C+13Rh29buwkkDobNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; d="scan'208";a="62137845"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Aug 2024 01:41:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 01:41:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 26 Aug 2024 01:41:24 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 01:41:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKPxTMc0z5NWk1O0W77nFIl3v148zqKIeMkkdElGJwp8S7GXMsJs0u/RYwusCRvDy1sIqnXiEnVa/hJutIRlS3MCggbd+qbLGM9dF4y/0e5SubMKqv7GgrKCWPqz5L18GBjGzzZbn+NZHI1p3rUvwSOPITLF9syK8ukq6bXyzy89HmXEZ1R/KIk+dvsvthjZrtha4x10h/UCPtHsaLKLuMl/WVgr9QWnfIlac1sIWW1QyK8P3Ele6VoWN5T3HU3EUgiANfTi+Aqfynh7T2I3BnHEXZ+jCuOmZTANLyPZ43MYGPULD4UqxBPckwYTZUDyZGptTnTg6rrVS44xe+wZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ou6KqAQrNC4/wZkPNNhlLViCLPdBe7qsgnlTen+IF9w=;
 b=SOVFNdGKIGAy/jaySHO3FtcMHaS9SWn02s8vz/oJj1p3tLhna5X983Hl3GUfF4U2q4nO1Z99k5cALa4y+q/piUH7qP6Egqn2b1L/ubqF8GlGZ+ZjmI4fkyLjCehigHRcrXoevTx7o5TJ8n8cSbcKrPykWCf+5eFRWL8Tv+o7KV4MoWRt4gPm43ZPrlUPqTZ1yLnkuJKHu2PnPMXd9weda5UIYupTO6npr7cbcJS7gFqSjSBOBcF6t84tUPrhdl8XfbSm2aub7+zhYkGhpG2QudI9q2jpVVa8zL8MGE9JW+VBz2seGV1VlvV6avc18qO/kFeNGAyyzMBI5wMPpL/aiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7009.namprd11.prod.outlook.com (2603:10b6:930:57::12)
 by IA1PR11MB7366.namprd11.prod.outlook.com (2603:10b6:208:422::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Mon, 26 Aug
 2024 08:41:16 +0000
Received: from CY8PR11MB7009.namprd11.prod.outlook.com
 ([fe80::7ebc:871a:bc7f:1eed]) by CY8PR11MB7009.namprd11.prod.outlook.com
 ([fe80::7ebc:871a:bc7f:1eed%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 08:41:16 +0000
Message-ID: <38860145-c338-40ee-b1e1-1983dab77695@intel.com>
Date: Mon, 26 Aug 2024 16:41:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/8] rust: add crate to expose bindings and interfaces
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr_=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>, "Pierrick
 Bouvier" <pierrick.bouvier@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
References: <20240823-rust-pl011-v8-0-b9f5746bdaf3@linaro.org>
 <20240823-rust-pl011-v8-6-b9f5746bdaf3@linaro.org>
 <8570704d-7cc8-460f-940e-4bf626972465@intel.com>
 <itblf.by425lac4ow@linaro.org>
From: Junjie Mao <junjie.mao@intel.com>
In-Reply-To: <itblf.by425lac4ow@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0205.apcprd06.prod.outlook.com
 (2603:1096:4:68::13) To CY8PR11MB7009.namprd11.prod.outlook.com
 (2603:10b6:930:57::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7009:EE_|IA1PR11MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f0be4a-89ca-4974-f18c-08dcc5aad9aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTR3VW04NzlCRHFQSldNTWhlV1lSQkJmU0tFZDFXVE9TZXRqcEdGMWNibHls?=
 =?utf-8?B?cG5RdkpYVGlLYzFYdC9qSzU2eG9nS1hFU2NFWFpLMXRVc2ZiZmJRUHpVbUxI?=
 =?utf-8?B?ZklrWlBYUEZoU0VaRFpHUHF5VGJFakpVSFhZeFZKSXFxTFFEQ092VUQ0dFlE?=
 =?utf-8?B?QzgyNlFsK2RVSjJ3M3pLeExSMnk4MTlWdTh4ZXFaSytrM0ZsdUJZNWlWV3Rj?=
 =?utf-8?B?d2szcnJpcmdNZzlJSWtSdVRmWTlCbGU3S0R5WCttWXozRlFDZFljdmpndXBU?=
 =?utf-8?B?QjlzbkU2TGYwR3BZb0YwREN6VGV6L211N3IvUG55dm81ellXT3ZnMTdyVnJ6?=
 =?utf-8?B?VE9aTU1xMXByRHZHUGdZWHdyNTMxTDNxVE9kOUpVR2ZKaUE5eWVpME04ai8y?=
 =?utf-8?B?OERpM0xTS1BPSHNaTnhsQ3hITWk4T0NVbGp4SGllZU5nMFZrV3pBdUQrWVlw?=
 =?utf-8?B?bFQ5bzIvZUtDL05Sbng2cXFIMGVuOUVudVpENGFaOFJNQjZ1WUV3QURJNXU4?=
 =?utf-8?B?THRFU2ZZRGVFSVJ5UWNCY2c3Q084ZWdMNEN0NS9NUittZEVyR0RvL3VQaHY3?=
 =?utf-8?B?emZ4c1hrVzNGR1IrVkF5aVBGUC9qWmI5elVkSGJmZmxBOFVLcFlrdStVS1pI?=
 =?utf-8?B?MStyazVMUVJ4c0FkNXNtVjIreHMvR29WMDFoS3gvTlVmWjhYKzNSbkc0cVVK?=
 =?utf-8?B?MWtZenZheldwZmJWdE02dWlVUHRLVkVLbWNXcUhXWnhTOE9TSVY5aGsyd3Zk?=
 =?utf-8?B?UHM0UkxuWG1lWkdJOHFlZG4zUlBBLzJkWTVGSGNLK1NxWUpVOXd2QTFFUTlu?=
 =?utf-8?B?cnlmblhSUUVXaHVWUElQakJOT1gvUCtyY21pMjg0VExSWGt1RGUxaHV3aWFZ?=
 =?utf-8?B?NUFCeUJMdlo3blhHaUgwZHBZRk42MVdOZ0l4MVp0amloOWpZc1NrUGFSQnJG?=
 =?utf-8?B?RHpYRnRKVEdCY2lHRnhkUExvVXJZMTIwdDF1bmk1bHg2ak03MTJ5cWpWL3FB?=
 =?utf-8?B?eksxZXdwbzJlY3VxeTJ4d1E0MnJvMWdFT1VMeHFyWG5zelhnQW9aWEVPZVcw?=
 =?utf-8?B?blU1R3ZNWlI4dDhJdmpCV2lOa0NISHBWT0cxV0VsN1F3SnkzTXE1TlA5MnI5?=
 =?utf-8?B?c1JackpxSEFqVjl6NTIrTG5XM1lKVlZ0a3RVai9rc3BpdUJoR1Q0N25NTG1N?=
 =?utf-8?B?N0J0YVE5R01GeXNXVnRBUFZjRUExZjhTWHcxbU5DK0J4aXpQUStkN2Z5QzdN?=
 =?utf-8?B?OGJHNHJxTkVUTm00V1pUNE5BNnVUcllMTzkydXVPRmFZQzZEK3VxWGRqY1NS?=
 =?utf-8?B?VWtEc3pHbnFpSkFuOU5ZSkF3b2pqWi9wNXFXcVVwK1dySXF4NVVtT3JIU3NI?=
 =?utf-8?B?YXlHWThWYUd1YnM0V0JkYXBNUkNPZ242NDRDWHBDMTNrc0RzTnBvUHJGR3du?=
 =?utf-8?B?VEdrUWZLbXlCTC9VeVNhNFBmS3M2TEJLK1dHdlNudjNWa0FwNlNHU0Y3aVV5?=
 =?utf-8?B?bG5wSE1nSENoQVo5S1pTdWdiWC9mRS9aSDVKcWxZSzhhRWxTSFRjV3FMWWFp?=
 =?utf-8?B?TG5DY2lyVEcxOTFYSWFWeWgxcEJNeVNqQ2l6M0g4MEkzY0dYa1JsaWc1M2Ry?=
 =?utf-8?B?OEZmcElBRjB4Q0M4eFpQMmd5R2hTV2l4bWFsTGZ4TXVwWkxaNERvRkF5NmxM?=
 =?utf-8?B?WnFkQmdKOVUvb0Q0cFFoUDVYSERJWldGYkVxc3FxcnZDVXp5Nk04a3BDbllE?=
 =?utf-8?B?R1NxbldzMElYSkpIY1JIenVSTDJiaVZSa09pdjMzTWZISkRTSnNVcmZycStn?=
 =?utf-8?B?VTdNei84dnJQbUEyWCs2dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7009.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUVtM1JQVkNXTnlGUDE3ZllXNUpmU1RxdHlFeFpIbVBlenZEaEQ1eEF5NVhN?=
 =?utf-8?B?NnJ2OHhoUE5nTXpDM2gyNDhHZTlKcEhsS29IbFA4ZnlONFlrWmJqVmVONGhM?=
 =?utf-8?B?WlQ5c2c4SGE4ZDZ6bUV3N1FsbW5lYXdObUFzR3BwU291Tkl0KzFqOE4ydkUz?=
 =?utf-8?B?M1YwemlxM3J6K1ZRWWhPSEZNTDVDMjF6ZnU1TGxiT2VZU1BTWWwxanRQa3ZN?=
 =?utf-8?B?akQ3OTZMNVI2T2cwTmErWWxhcHZJSjNoYlhRVUxFMHljTGlTVlhmOXJPZFB3?=
 =?utf-8?B?RDM0RjFiMzdIZXRlNmN2M3NNZ05aSkFiR2NlNFl2aG1FUGV4ZmlWTHkxU1hN?=
 =?utf-8?B?NlRSVEU5aXVxYlc0YjdQTGFwaUV3TXJyWnFFN1BpanVmamJuQy95aW95NzVl?=
 =?utf-8?B?dTRVcjJMb0RWMzZGS0FNRGlqNGxRSWZqbEJaNnVtR2NtNVdoZVIySGQrTXpi?=
 =?utf-8?B?QkVBSWppZUNlajlwOGZSY0JUdzFvT3RTbU1FQWxtR0NMU05kdVFKY0RHYUFN?=
 =?utf-8?B?am43cGVkdmRTa2puMjNUZnhWRFEweHJBTkRibnpIOUtDNWx1YjBPTldnNEVF?=
 =?utf-8?B?b0xWRjBvNGdIbU1XZnY1OFovamRVajU1VDRUL3NXenRVU1Jsazg4c2k1SW1t?=
 =?utf-8?B?R1FmK3VTdnJJRUpDY3RUdDdEQXV4Znhyd2JZZkwwVTlaU08wekpaMS9CQ3Jh?=
 =?utf-8?B?eXp4WHlFdytocUQvTEdzbUNWbThGRkJWemp5NVcwQWFsTDFzL01weXI1VkVw?=
 =?utf-8?B?THMyNEtBVmJEUmswWHZqZTZWUi9WOW9abWZ4NHNpZWlVenVyK0NseW1QcVo0?=
 =?utf-8?B?U212WGRsRm5aS0s0ZERLQVQ3aXpZU2EyYTB0U2VjV3AxZncwdm85ZVdROVVD?=
 =?utf-8?B?em1kQ0t1WTJRY0dUMXhPOXRmanNKMHROZldtakNtMEkxRDM1elU0eXRXcXpZ?=
 =?utf-8?B?UHVJQSt4UDZXalg0anlWNnJTcDIxWDlqWWZYZDNVVHBxUlFPeUhONVpWOUdB?=
 =?utf-8?B?UlU1OG01a2hpMVZOeUlnYTdpbnhFZit2UlZuOHp5VUZOQkVmaTM5ZmNCblU3?=
 =?utf-8?B?dkIweFkxV1A3VExpZEQrZ2JjZ2pIR2g5STNwekRMa0h6c1E2SEFTMGQ3cUpO?=
 =?utf-8?B?NzNlTDBqNnlZYTNjSUEycnRUVmZlQWV3UmZRTHk1clJSU2FTdmJiczhITW02?=
 =?utf-8?B?Ymo3K0lnN2JYMGU4YWNZSGNqK2R2d1RuRmp6ZG82dHlRTDNFUi8wOGNDcTZE?=
 =?utf-8?B?d2U3YVJJNERoeUJaandYcklGOUZkamFCYlFhNVRvdUJGMk41TjNZZEl0NTgx?=
 =?utf-8?B?VUcvS3pEbHROTzlhOHplaFZoTGZDeUVaVmNIeEFhcFhVRk0xa3BxY1ZqdWo4?=
 =?utf-8?B?NnRYVEhrWkU0OXlYTDFETVJmSnVNNGFHMThlTGY2WWVpbkc2MllJVzRlbHZT?=
 =?utf-8?B?djBLS2J1QzBIL3dDV2FmVk5jS2lzRzdVSnZUQ1hiR2dYWDBOKzdpYWhiQVhM?=
 =?utf-8?B?ZXU2RmNValJyQTZFU1loZ29UZ2tzd21OOXpnSVpvL3VYMGhQQ0pPdnZvYXJw?=
 =?utf-8?B?aktaaTlkVkt3Q0lKMWVTNWF0eDRvN1M3TWFnVm16WnNBb29nSHl5eDRQQnFE?=
 =?utf-8?B?TnI2K3lLN2YzNzVIMEZRVmtzVG1CVElyMHltaEJZbFRLYjdBcUdUN014ODI1?=
 =?utf-8?B?VzBWa0NVL2FCTFptM3NHYU1GNVQwdGo1a09NZWd0LzFRV2dlV0dEckhHV1Z1?=
 =?utf-8?B?ejYySCtSWXlCMGxIOE9HdXAxbEpJQmpzNUJzN3ZtUkQrRDd5Ky9JL3dQUG5T?=
 =?utf-8?B?Y3J1QUIzemx1Qms2azQ4MUdLWG1YaDNDSThVNXpLdVF5aWpkWXA0VjBVRGd1?=
 =?utf-8?B?YWRwNFlSWW1LR1dTdkh0ektTdmdreGtrOU1EbS96V0d1UEdGSlN1eTI1K2VE?=
 =?utf-8?B?MEtYNzhPbTVLb2JWMEUvQUMyaE5wbWs2ODJONXUrRnozZlBuMFM5ZHJaQXZL?=
 =?utf-8?B?a09FdmdyNDk4cS92RmNHUExlVmtHT0JmOEFYNHV1RU1xczNIa2I3R3BaOUJP?=
 =?utf-8?B?Ym9FZjZrZWdNTlZBSHJsWVh6dzJGNUt2VGhiQ0o1ZUxhc1NDMnlpMzArRUov?=
 =?utf-8?B?VE4zUTBJd1ZHNjJmM0FrMmdndkx3bXVPdUltQndrRXZYQjhlUHZJemUvM2dQ?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f0be4a-89ca-4974-f18c-08dcc5aad9aa
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7009.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 08:41:16.7575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ox+lFiymT5MiiF6zOIEPk/7BpRpVxGlF8E5a/cgcgTeFyCimjw+2epjOhJHa5zev5mBG5zFN0QT+6iND5Ev7pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7366
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11; envelope-from=junjie.mao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/26/2024 2:12 PM, Manos Pitsidianakis wrote:
> On Mon, 26 Aug 2024 08:03, Junjie Mao <junjie.mao@intel.com> wrote:
>> Hi Manos,
>>
>> On 8/23/2024 4:11 PM, Manos Pitsidianakis wrote:
>>> Add rust/qemu-api, which exposes rust-bindgen generated FFI bindings and
>>> provides some declaration macros for symbols visible to the rest of
>>> QEMU.
>>>
>>> Co-authored-by: Junjie Mao <junjie.mao@intel.com>
>>> Co-authored-by: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Junjie Mao <junjie.mao@intel.com>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>> ---
>>>   MAINTAINERS                       |   6 ++
>>>   rust/meson.build                  |   1 +
>>>   rust/qemu-api/.gitignore          |   2 +
>>>   rust/qemu-api/Cargo.lock          |   7 +++
>>>   rust/qemu-api/Cargo.toml          |  26 ++++++++
>>>   rust/qemu-api/README.md           |  17 +++++
>>>   rust/qemu-api/build.rs            |  14 +++++
>>>   rust/qemu-api/meson.build         |  20 ++++++
>>>   rust/qemu-api/rustfmt.toml        |   1 +
>>>   rust/qemu-api/src/definitions.rs  | 109 ++++++++++++++++++++++++++++++++
>>>   rust/qemu-api/src/device_class.rs | 128 ++++++++++++++++++++++++++++++++++++++
>>>   rust/qemu-api/src/lib.rs          | 102 ++++++++++++++++++++++++++++++
>>>   rust/qemu-api/src/tests.rs        |  49 +++++++++++++++
>>>   rust/rustfmt.toml                 |   7 +++
>>>   14 files changed, 489 insertions(+)
>>>
[snip]
>>> diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
>>> new file mode 100644
>>> index 0000000000..4abd0253bd
>>> --- /dev/null
>>> +++ b/rust/qemu-api/src/definitions.rs
>>> @@ -0,0 +1,109 @@
>>> +// Copyright 2024, Linaro Limited
>>> +// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +
>>> +//! Definitions required by QEMU when registering a device.
>>> +
>>> +/// Trait a type must implement to be registered with QEMU.
>>> +pub trait ObjectImpl {
>>> +    type Class;
>>> +    const TYPE_INFO: crate::bindings::TypeInfo;
>>> +    const TYPE_NAME: &'static ::core::ffi::CStr;
>>> +    const PARENT_TYPE_NAME: Option<&'static ::core::ffi::CStr>;
>>> +    const INSTANCE_INIT: ::core::option::Option<
>>> +        unsafe extern "C" fn(obj: *mut crate::bindings::Object),
>>> +    >;
>>> +    const INSTANCE_POST_INIT: ::core::option::Option<
>>> +        unsafe extern "C" fn(obj: *mut crate::bindings::Object),
>>> +    >;
>>> +    const INSTANCE_FINALIZE: ::core::option::Option<
>>> +        unsafe extern "C" fn(obj: *mut crate::bindings::Object),
>>> +    >;
>>> +    const ABSTRACT: bool;
>>> +}
>>> +
>>> +pub trait Class {
>>> +    const CLASS_INIT: ::core::option::Option<
>>> +        unsafe extern "C" fn(
>>> +            klass: *mut crate::bindings::ObjectClass,
>>> +            data: *mut core::ffi::c_void,
>>> +        ),
>>> +    >;
>>> +    const CLASS_BASE_INIT: ::core::option::Option<
>>> +        unsafe extern "C" fn(
>>> +            klass: *mut crate::bindings::ObjectClass,
>>> +            data: *mut core::ffi::c_void,
>>> +        ),
>>> +    >;
>>> +}
>>> +
>>> +#[macro_export]
>>> +macro_rules! module_init {
>>> +    ($func:expr, $type:expr) => {
>>> +        #[used]
>>> +        #[cfg_attr(target_os = "linux", link_section = ".ctors")]
>>> +        #[cfg_attr(target_os = "macos", link_section = 
>>> "__DATA,__mod_init_func")]
>>> +        #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
>>> +        pub static LOAD_MODULE: extern "C" fn() = {
>>> +            assert!($type < 
>>> $crate::bindings::module_init_type_MODULE_INIT_MAX);
>>> +
>>> +            extern "C" fn __load() {
>>> +                unsafe {
>>> +                    $crate::bindings::register_module_init(Some($func), $type);
>>> +                }
>>> +            }
>>> +
>>> +            __load
>>> +        };
>>> +    };
>>> +    (qom: $func:ident => $body:block) => {
>>
>> This arm looks duplicating what #[derive(Object)] is for, while both have 
>> their strengths and limitations: module_init!() provides more flexibility on 
>> the registration function body, and #[derive(Object)] is much more convenient 
>> to use.
>>
>> Complex registration functions are not rare, and thus the Rust APIs should 
>> ideally have both strengths: clean type declaration in most cases, and full 
>> flexibility when needed. In the current codebase, we have ~1080 uses of 
>> type_init(), with 750 of them having a registration function as simple as a 
>> single call to type_register_static() (disclaimer: those numbers are collected 
>> via brute-force searches and may not be accurate). More complex cases include:
>>
>> 1. Registering multiple types (e.g., multiple models of same device) that 
>> share the same data structure, e.g., hw/misc/aspeed_xdma.c and 
>> hw/xtensa/xtfpga.c. There are ~200 uses of this kind in the codebase.
>>
>> 2. Use domain-specific registration function, e.g., ui/egl-headless.c, 
>> audio/ossaudio.c and hw/virtio/virtio-net-pci.c.
>>
>> 3. Other device-specific operations, e.g., hw/net/spapr_llan.c.
>>
> 
> This is why I left the decl macro, I was prototyping this series with a second 
> Rust device (that is not included in the patches) and I needed more logic in the 
> module init.
> 
>> My rough idea is to define a proc macro around an impl block to collect 
>> constants (type names, parent names, etc.) as tokens and callbacks (class 
>> init, instance init, etc.) as functions, from which we generate TypeInfo and 
>> (optionally) type registration code. As an example:
> 
> Do you think we should not use a trait to define type info at all by the way?
> 

I'm not sure, to be honest. Traits are a great way to specify a series of 
functions and mostly fit our needs here. I'm still thinking about how a 
trait-based approach works for multi-model devices where multiple TypeInfo can 
be defined for one structure. A naive way is to define one struct for each 
TypeInfo, which should work but does not look perfect to me.

>>
>>   pub struct PL011State {
>>     ...
>>   }
>>
>>   #[qemu_type(name = "pl011", parent = TYPE_SYS_BUS_DEVICE, (abstract)*)]
>>   impl PL011State {
>>     #[class_init]
>>     pub fn class_init(klass: *mut ObjectClass, data: *mut core::ffi::c_void) {
>>       ...
>>     }
>>
>>     #[instance_init]
>>     pub fn init(obj: *mut Object) { ... }
>>
>>     ...
>>   }
>>
>> The proc macro then generates a TypeInfo instance named TYPE_INFO_pl011, with 
>> optional callbacks being None when not given. A registration function will 
>> also be generated unless qemu_type! has a no_register token.
> 
> Maybe this too can be a trait method people can override with a blank 
> implementation to avoid registration...
> 

Agree.

>> Devices can still use module_init! to define their own registration function.
>>
>> The class_init callback is specified together with instance_init because it is 
>> common for multi-model devices to provide a different class_init even they 
>> share the same class structure. Refer to hw/misc/aspeed_xdma.c for an example.
> 
> Thanks I will take a look. QEMU Classes are a bit complex indeed.
> 
>>
>> What do you think? It is still preliminary and the example can have 
>> grammatical issues, but I can try drafting if you think that is a good direction.
> 
> In my plan I wanted to eventually have all these callbacks available to Rust 
> code via trait methods which only take rust references instead of pointers. Then 
> the proc macros would generate extern "C" wrappers for each of them, make a 
> typeinfo declaration, set everything up. I like your approach too. Should we 
> wait until we have an actual device that requires redesigning this? We're free 
> to change things anyway.
> 

Your idea looks promising, too, esp. the "take rust references" part. It may be 
difficult to figure out if a callback should be None since the trait will always 
define a default, empty implementation, but the performance overhead of calling 
empty constructors / destructors should be negligible.

I agree that we'd better try a variety of device types to better understand 
different use cases before we conclude on the API design. I'll also try 
prototyping some device for a deeper understanding of the current APIs.

---
Best Regards
Junjie Mao

>>
>> ---
>> Best Regards
>> Junjie Mao
>>
>>> +        // NOTE: To have custom identifiers for the ctor func we need to 
>>> either supply
>>> +        // them directly as a macro argument or create them with a proc macro.
>>> +        #[used]
>>> +        #[cfg_attr(target_os = "linux", link_section = ".ctors")]
>>> +        #[cfg_attr(target_os = "macos", link_section = 
>>> "__DATA,__mod_init_func")]
>>> +        #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
>>> +        pub static LOAD_MODULE: extern "C" fn() = {
>>> +            extern "C" fn __load() {
>>> +                #[no_mangle]
>>> +                unsafe extern "C" fn $func() {
>>> +                    $body
>>> +                }
>>> +
>>> +                unsafe {
>>> +                    $crate::bindings::register_module_init(
>>> +                        Some($func),
>>> +                        $crate::bindings::module_init_type_MODULE_INIT_QOM,
>>> +                    );
>>> +                }
>>> +            }
>>> +
>>> +            __load
>>> +        };
>>> +    };
>>> +}
>>> +
>>> +#[macro_export]
>>> +macro_rules! type_info {
>>> +    ($t:ty) => {
>>> +        $crate::bindings::TypeInfo {
>>> +            name: <$t as $crate::definitions::ObjectImpl>::TYPE_NAME.as_ptr(),
>>> +            parent: if let Some(pname) = <$t as 
>>> $crate::definitions::ObjectImpl>::PARENT_TYPE_NAME {
>>> +                pname.as_ptr()
>>> +            } else {
>>> +                ::core::ptr::null_mut()
>>> +            },
>>> +            instance_size: ::core::mem::size_of::<$t>(),
>>> +            instance_align: ::core::mem::align_of::<$t>(),
>>> +            instance_init: <$t as 
>>> $crate::definitions::ObjectImpl>::INSTANCE_INIT,
>>> +            instance_post_init: <$t as 
>>> $crate::definitions::ObjectImpl>::INSTANCE_POST_INIT,
>>> +            instance_finalize: <$t as 
>>> $crate::definitions::ObjectImpl>::INSTANCE_FINALIZE,
>>> +            abstract_: <$t as $crate::definitions::ObjectImpl>::ABSTRACT,
>>> +            class_size:  ::core::mem::size_of::<<$t as 
>>> $crate::definitions::ObjectImpl>::Class>(),
>>> +            class_init: <<$t as $crate::definitions::ObjectImpl>::Class as 
>>> $crate::definitions::Class>::CLASS_INIT,
>>> +            class_base_init: <<$t as $crate::definitions::ObjectImpl>::Class 
>>> as $crate::definitions::Class>::CLASS_BASE_INIT,
>>> +            class_data: ::core::ptr::null_mut(),
>>> +            interfaces: ::core::ptr::null_mut(),
>>> +        };
>>> +    }
>>> +}

