Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE892C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 05:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siSKx-0001yq-3b; Mon, 26 Aug 2024 01:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1siSKu-0001xa-Na
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 01:32:16 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1siSKq-0001HE-54
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 01:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1724650332; x=1756186332;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=POB5yarhFVdWwcoOKKy818ikrLWS/bH5tIXSEHRLkPs=;
 b=dxIS9qRI/5sLzw+ridtfd/KbAFGMrqSMWM84ZJzm7fjIk1Y26+kvuZ5H
 L51VlgY+N5QMO7pdgqggZ69170DVE4g4ronLlkIjDA6vjd1VomkbDQ84L
 yBbZSwz8WsqyDoKX2ELsS3oGr+q6goQlMmoRx8FjqoKDTDgPr+W9LsOZe
 YnrV7fjf7h6ztHGux2Z7Ha8XbA653wYKh/gwH/ts7KjTbDpqknYSuzR8e
 ZpXpz22oxjVb2pdzh39HSwvZZWVajPV9heWPVmszJpZf+FG+EHcefS9cR
 xLXYZB19NFEFaMVrND599lUwQWRml//G7k6HN84WPUv0Ae3p2eUhWKFhf Q==;
X-CSE-ConnectionGUID: l6DTLMVuTmKWRceDkXiQmA==
X-CSE-MsgGUID: 7f3w5dRLQLqZUsO15PPqdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="22575368"
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; d="scan'208";a="22575368"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2024 22:32:09 -0700
X-CSE-ConnectionGUID: WCnwbj3nRwiN5GYMQGJwkg==
X-CSE-MsgGUID: XqiprmIFTXuT5xus/nW2rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; d="scan'208";a="62443616"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 25 Aug 2024 22:32:09 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 25 Aug 2024 22:32:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 25 Aug 2024 22:32:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 25 Aug 2024 22:32:08 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 25 Aug 2024 22:32:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ebm8NqWxFZ1TcMIbftMtsU3pXjjPSWKJ7rIxQH+/QAnpyM4HfAmUB8Q/ui2IrCsH6r4s5DeMKKUzM/oO5aVanKAxjALX5m/cIuYb7uNaXzzYPrMFZQ3GqUdxQYX8cZsh30l3Xxa6G0IcG8uATuOA+lxivl7q/Fkh64BuA8J06mU5ezPcXdcXQeNRMSSxhQjP7YrM5W37OVblINMHs/7C4kp1lcwIRYX0HHBs6+ADNL1PMBgNIJ7I3LXWcyoL2duD7Wuo3j2eBlTOHKdMlHAzdeGSkXYpy0ClytNmzHOTdnEUruYGPHeWKwV9b+T9Lnn5qJlin6oMraJaTad4VyVf6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+n8yUwYwn205JVTxN/D1G/Jq4eqHtTqtpBgptPlcRf0=;
 b=uUwFdPegGGVdWhOn++/lLKNgGCaj1iy5IT+UTaBNHf+hZXnFCrdnPiJBtjZwU4ODRxoIRqZILb+/4a67bJA4xDPH/sH/KAnuI35SOoAdLKVMc56oF6Myscfo55uDqdohjHqU2W15mTRGQ0xHw9ASQTZpiDYQfbuiNhGpbTHyjNapuwnqIMpytfuSaQ306/PYSKcm4OMQ9j/eaK8LMtILo21z7Tdf1qNFv+t59tcDpbz7MSDvleVwPFYPNAIW2lHTGv7Z510ZlwI1CH8FJZFRI51cv8ZqNIEaAstKIxNFqH0aaGpmtRfWb+b6b7fgbrcBCypVX2ClwrpfN8Kdwd/i4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7009.namprd11.prod.outlook.com (2603:10b6:930:57::12)
 by SJ0PR11MB5071.namprd11.prod.outlook.com (2603:10b6:a03:2d7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 05:32:06 +0000
Received: from CY8PR11MB7009.namprd11.prod.outlook.com
 ([fe80::7ebc:871a:bc7f:1eed]) by CY8PR11MB7009.namprd11.prod.outlook.com
 ([fe80::7ebc:871a:bc7f:1eed%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 05:32:05 +0000
Message-ID: <841befb6-5ce1-44e5-890c-4e60fcbd4fa6@intel.com>
Date: Mon, 26 Aug 2024 13:31:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/8] rust: add crate to expose bindings and interfaces
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
References: <20240823-rust-pl011-v8-0-b9f5746bdaf3@linaro.org>
 <20240823-rust-pl011-v8-6-b9f5746bdaf3@linaro.org>
From: Junjie Mao <junjie.mao@intel.com>
In-Reply-To: <20240823-rust-pl011-v8-6-b9f5746bdaf3@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0174.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::30) To CY8PR11MB7009.namprd11.prod.outlook.com
 (2603:10b6:930:57::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7009:EE_|SJ0PR11MB5071:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf81e36-f093-440d-e3c1-08dcc5906bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mk1TNnpKQzZ1bk1Ma3diWi8vaHBoN3d1Y2NCNGRNTWp6aGxCTjhRQXZxNnJk?=
 =?utf-8?B?M2Y5L3Z3U0oxcXJKTmFaMXQ5ZTdDWkNiTFF2c1I3K3E2NzhVS2d6YmQ1ak9F?=
 =?utf-8?B?cmJhaXl6cGplRnllTlZaUTQ1TDJDUm15MzdsRW5CbkN3NUt1WW52SGtjeDh3?=
 =?utf-8?B?cGFFdDY1NDY4cWJiVzZnWW40WUh3ZVBsZ2ZjZzhuVjhGckVJa255MTJXUkQy?=
 =?utf-8?B?aFhieHlNeXY5aVA5eS8yYWtJTXlUQXlTQTV2VndaZFJBLzZSL0lERmNiNzRq?=
 =?utf-8?B?RDk2MHBJYWdTZVFZclJaK3RRdG8yVk5FVTQ1K25UVHhOcjJkUHEzNHVKVEpV?=
 =?utf-8?B?cEI1QnczSHdjUlNJK0ZYeWVKYm1ISVFSSGFKRzE1aVBwbWdnbVBPZWMvcnkz?=
 =?utf-8?B?ZHNwM08vWFR3NGZUVDRDS28vUnd1c0VYOHUyeFlZMnM3dkpzWlB6bW5Jbi9U?=
 =?utf-8?B?bkhrekRsWkJpa2R3Yk0xQ0lrNzd0OEpBT29uNE1DTTJEOGJyUGtqbU9LY1NJ?=
 =?utf-8?B?RUVnVytXMFVRbjVrK3pSOXFuaXdRSXRWNXErT1dQRkxFNHk2OWRZR2Zia0I3?=
 =?utf-8?B?eVpCS3RYc29HNGtCQVRYQjhMcWdXdHFRUUUyQjRvbWtJd29USFlUN3ZkQ1No?=
 =?utf-8?B?S09BZGJnaU0wekNETTJCOGtWaHhNeUxpQVZ1OGwyRUV0U0dRcXVyOWdic3ZG?=
 =?utf-8?B?MVFpSkR5K1oxVDdnUy84T1p5NlJjVFU3eTVhdnRIQ2RDV3FpTE54aU8wZkUv?=
 =?utf-8?B?dGRtblZjc2tSMThnUC80cEZtd2wxTnRDRjJNUUhBdjJTdldTZTJXRU5WcnNT?=
 =?utf-8?B?OEdrdHd4MzBXTUhXeVlGeUt5bGRJS3Raa214SjBKa0plRzNxSGF4VDRERmdP?=
 =?utf-8?B?T0x3ejdHU1RScTlseUVJb2Uwa3g4aGp0NXJPK0tYQXBCU2wvdEluRHZBVDNx?=
 =?utf-8?B?bkQ1aUlWbjU4dWd5RTllMS9VaG02SE4wRnBtQUQxSGRYOW52ZWYvTkpRZitS?=
 =?utf-8?B?bGxyaGZTVUVJcWF1R1VvVW5DcktDb2hUZ1FtYlNkQ1BzRlRhTjJ6NU81bTJE?=
 =?utf-8?B?bXh0Q1hWK0tVbzZSUzV2YzJlblBuWXRCaXZLeGtPMjZZcEsyVWpPd2VCcW1w?=
 =?utf-8?B?c3lxckh3L2kySE13Zm5yVlU1VlIrNXVENWl1YkVMb2JiYUpSdGcrUkN0WC9G?=
 =?utf-8?B?YXdpSG1CNUQ2dklKMEhqMTJWd1dnV2x5VEo2WVYzbVp4dnRIdzBNbEJhMkJk?=
 =?utf-8?B?NWJZVnRuWGhrbTBmbXJhZ3FmOWQ1NE0wZ245eWlZcmVzL2hmUXBiTjJiWFp5?=
 =?utf-8?B?R0ZBbnJGcGJnMmIyTXBxa1hmbDY1cXRwY096S3FSTEhZdlpOaXk5YmovMHBQ?=
 =?utf-8?B?VmZ5cmxBcTV6OW9VaGMxdFlyNHB4Ymx1UHFpbjRpRk1yVzAxRzVEbVBUQjlo?=
 =?utf-8?B?Z1hDelJZd0h1UFU1LzgzcXRyWjcyZ1d5cXRVTitKL1dDdDBobDBhTzBidXFE?=
 =?utf-8?B?UDJnVzNXbVlQeU1LaDRYUmRnMDRWNzV4cEtiK29vUG5LUFZOUGs3NG1BY2c1?=
 =?utf-8?B?R3RQbE1zeFJDajdmdUlLWElnZ1c1VVhCM0xmWUMzZm1ndkNPY09zZldmNFRn?=
 =?utf-8?B?enlGSTJTaEwyM1dvYU15b3FxUGJtVVBsYURkUUZyTDFUS3U1QjMxaVduaW1j?=
 =?utf-8?B?elJCSXludStZZk9uSnZCZHkrV1YrMlJtZ0RQbUY2T1IvTG5XYlFLV2JlaWdT?=
 =?utf-8?Q?FF9CPr9dayk0elIC2Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7009.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDExUFlyczdlVmVvNm1KWDlwMk1WdjNpMU1RenZFSGFBTzBsQ216YVhPejgx?=
 =?utf-8?B?ZnlqdlRFM3hJeTdOUkc0NGtaWGhCc0xhTExmWUdMemlGcloyT210cDJyaG1x?=
 =?utf-8?B?UktMcnJrRVlZRzg3bC9kcG9UcmgyVmU0N2xBdVJkRmh2TDlKeTJBTWZDaStw?=
 =?utf-8?B?U0x2YU9vQTZPYmRYRGQwN1R0dFY4OEI2ZlFuaDlKV1doZlhGcWZGOWk2MGVT?=
 =?utf-8?B?cjhSalQ3dEczTHhjLzJjZ0tXRDlvM0N1VE1IODdtTEh6T2F5UWljY05jcXVZ?=
 =?utf-8?B?NitnQ2gvdnh3ODZIc2hVWm1xdlVlcmdhNWRhbHEwNzRoWDBsTjdhYlUySmVJ?=
 =?utf-8?B?bHRQMkhDUjJaaTVXaFZ4T0VXUk85dWZLOHJUOGhnd3BCYXdjY2Z5YUpXbGJt?=
 =?utf-8?B?OGxobjBQcnNxRXk1MjZUSEE4b1dvUmJXeGx1SjJZY0xEN0lPUEt2cU1rWXo4?=
 =?utf-8?B?azZlRFNmWEY3ZW4xSnhvbkh3My9aaklLYXZCSklNYk9KNXVXTDZiQ0NxMVV5?=
 =?utf-8?B?ZXc3NHlCcU1IZlE1cm0ySEVCa1hPMkY3VXZwWVVkYlY3Zmw2VkpPaWRGc1lO?=
 =?utf-8?B?cWlDL2hTS3VGSE9pb3BDSlFyci9iQXUyak8reFZyQmlCM2ovRU1PUFMrNUVU?=
 =?utf-8?B?Vjc4Mk4xRDA2d1pGdWtvWCsxNnBTTmZHcjh6MzFWOEo4RHczWi9VQWY4Nzd2?=
 =?utf-8?B?azBmMEY1MkMrOWxnSExsWWtrRzdpU2JhNmo0bGtmc1hicVlXangzK05hSkEr?=
 =?utf-8?B?MzMra0NLRTMwMEdDRHVDV3BzeHczNlQrYVB0bDM4c3lCNjA2ejdMWkdRV2Rx?=
 =?utf-8?B?UTVHTk9QV0tTZ2l4clo3QjlVRUpoa1FoRlFHenVCTGsxVld2bHFqK0d3ZTU2?=
 =?utf-8?B?RzhTd3JWb0pFSXc1SFYvQkJrWTVnVk1hRmZOTXcrV0hEM1dXSTZwZy90c3JM?=
 =?utf-8?B?Q2NQdnJpY0J5eGxRQkdsWmFxMmhXcjJCaGRyM0NBaVRXNzU3MW5mSWo4OHkw?=
 =?utf-8?B?VjJHMFdNZ1EwdTc1WWUwa2o0UWlMeHhPS1V4WEZFUnQ0M3BtZS9Nek5rbUFa?=
 =?utf-8?B?V09MYTVWNTBuTXU4OGhEOEJqYWNqQjNUQkhHemlWdVJaSVV1dDFoZmIzaTBW?=
 =?utf-8?B?SUVBUW9YTTV0dDZ2SHNtL1NQQUMzYlVBbmRYZWZjRXJ6T1BPT3IrdVNwZnNq?=
 =?utf-8?B?blBSTDN5SndLZzBBblY0L3h4ZVcxMjNQcm5kbTdYN2dGK0UzbHhYRE1XcWs3?=
 =?utf-8?B?dFpTTXRuUVdVV2piWS9rSFU1Q3p0WHFkRXVTU1NZd2k2OHEyMWpLZzdBa0tC?=
 =?utf-8?B?OHIzVHd3RW9odVd6Si8wb0JpWVdtRzNZdHZGY3JSQlN2cFBvOGxFVTZ4dEhn?=
 =?utf-8?B?aGF4cDRnVTFyUnZzVkRaOXQ0L09Dc25VZG5hUHBmck5JaWtwbTF2USs4c1E5?=
 =?utf-8?B?b1dkMTRzaGh0bXArRStyS3BUeUhpZlhjNUFoQWZuclQzZnpIR0hqV1l5WDBU?=
 =?utf-8?B?YzBJbWJvSHhmd3hWbWxibUJpVHM2R21GTk1YdXQwZFVKLy9mYXBsN2hMUGIv?=
 =?utf-8?B?VUh2S1hSV2oybkRJTitDSlM2KzFWME5ZZlBpT0w1YlY2RzZZU2Faemhtalhq?=
 =?utf-8?B?eFNxd05tY1dUWUpIR01wL3RtOXptbkE3TlFEc2JhY0w2RytLS0xjQ2RrS094?=
 =?utf-8?B?SlF3OXh1c1d4UVdNQmh2QmJOQVNMUmxVN1NVQnBtdEtMakpHZW9wZzFtMURD?=
 =?utf-8?B?OEM0ZUw2TW8xUERHc0EreWZENFhpK2lydkxxUUxxck1PSmp0Zi9qYXNPVVdR?=
 =?utf-8?B?TUlGdjJiUUJWbWJRS0hQK2JJYmYydWJhczg3OWdrNGRuODZkNlJkUTJ3RENM?=
 =?utf-8?B?anBoTzRPcTVWV3VDdHhYSjBQd1J1KzVOSCtXREFDZ2VTOHY2alZNaStwQ3Vn?=
 =?utf-8?B?bGVTUGlobGtYNEZwcXJGVU5GRkhkUnZoUW1qWFlGdTdQWWlMSElyMENLUUZO?=
 =?utf-8?B?UTcxRWNqOUkxOUI0VVo3TUtGdmpOWlN3NEZjRU5DVlM5d0t3alBkMnk1TUhF?=
 =?utf-8?B?bU1RWjUzOElieHNrLzY1U0VVa2FJaW1GZjUvby9BSGNnMGxkdElWeXBFVlN4?=
 =?utf-8?Q?jTKcRAsgRKLzBBZYKDZ71/Zqj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf81e36-f093-440d-e3c1-08dcc5906bf3
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7009.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 05:32:05.7790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ri0vjlBJTheZDHpQ4fNX280Nh2ZMrIVSmxN3KB2Pb9mG22TmArXB8EJvfCEZ/SLFkgH5GAc8FdvsRJ2U+yNRcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5071
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18; envelope-from=junjie.mao@intel.com;
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

On 8/23/2024 4:11 PM, Manos Pitsidianakis wrote:
> Add rust/qemu-api, which exposes rust-bindgen generated FFI bindings and
> provides some declaration macros for symbols visible to the rest of
> QEMU.
> 
> Co-authored-by: Junjie Mao <junjie.mao@intel.com>
> Co-authored-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Junjie Mao <junjie.mao@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   MAINTAINERS                       |   6 ++
>   rust/meson.build                  |   1 +
>   rust/qemu-api/.gitignore          |   2 +
>   rust/qemu-api/Cargo.lock          |   7 +++
>   rust/qemu-api/Cargo.toml          |  26 ++++++++
>   rust/qemu-api/README.md           |  17 +++++
>   rust/qemu-api/build.rs            |  14 +++++
>   rust/qemu-api/meson.build         |  20 ++++++
>   rust/qemu-api/rustfmt.toml        |   1 +
>   rust/qemu-api/src/definitions.rs  | 109 ++++++++++++++++++++++++++++++++
>   rust/qemu-api/src/device_class.rs | 128 ++++++++++++++++++++++++++++++++++++++
>   rust/qemu-api/src/lib.rs          | 102 ++++++++++++++++++++++++++++++
>   rust/qemu-api/src/tests.rs        |  49 +++++++++++++++
>   rust/rustfmt.toml                 |   7 +++
>   14 files changed, 489 insertions(+)
[snip]
> diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
> new file mode 100644
> index 0000000000..ab95d0d5f7
> --- /dev/null
> +++ b/rust/qemu-api/src/lib.rs
> @@ -0,0 +1,102 @@
> +// Copyright 2024, Linaro Limited
> +// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#![cfg_attr(not(MESON), doc = include_str!("../README.md"))]
> +
> +#[allow(
> +    dead_code,
> +    improper_ctypes_definitions,
> +    improper_ctypes,
> +    non_camel_case_types,
> +    non_snake_case,
> +    non_upper_case_globals,
> +    clippy::missing_const_for_fn,
> +    clippy::too_many_arguments,
> +    clippy::approx_constant,
> +    clippy::use_self,
> +    clippy::useless_transmute,
> +    clippy::missing_safety_doc,
> +)]
> +#[rustfmt::skip]
> +pub mod bindings;
> +
> +unsafe impl Send for bindings::Property {}
> +unsafe impl Sync for bindings::Property {}
> +unsafe impl Sync for bindings::TypeInfo {}
> +unsafe impl Sync for bindings::VMStateDescription {}
> +
> +pub mod definitions;
> +pub mod device_class;
> +
> +#[cfg(test)]
> +mod tests;
> +
> +use std::alloc::{GlobalAlloc, Layout};
> +
> +extern "C" {
> +    pub fn g_aligned_alloc0(
> +        n_blocks: bindings::gsize,
> +        n_block_bytes: bindings::gsize,
> +        alignment: bindings::gsize,
> +    ) -> bindings::gpointer;
> +    pub fn g_aligned_free(mem: bindings::gpointer);
> +    pub fn g_malloc0(n_bytes: bindings::gsize) -> bindings::gpointer;
> +    pub fn g_free(mem: bindings::gpointer);
> +}
> +
> +/// An allocator that uses the same allocator as QEMU in C.
> +///
> +/// It is enabled by default with the `allocator` feature.
> +///
> +/// To set it up manually as a global allocator in your crate:
> +///
> +/// ```ignore
> +/// use qemu_api::QemuAllocator;
> +///
> +/// #[global_allocator]
> +/// static GLOBAL: QemuAllocator = QemuAllocator::new();
> +/// ```
> +#[derive(Clone, Copy, Debug)]
> +#[repr(C)]
> +pub struct QemuAllocator {
> +    _unused: [u8; 0],
> +}
> +
> +#[cfg_attr(feature = "allocator", global_allocator)]
> +pub static GLOBAL: QemuAllocator = QemuAllocator::new();
> +
> +impl QemuAllocator {
> +    pub const fn new() -> Self {
> +        Self { _unused: [] }
> +    }
> +}
> +
> +impl Default for QemuAllocator {
> +    fn default() -> Self {
> +        Self::new()
> +    }
> +}
> +
> +unsafe impl GlobalAlloc for QemuAllocator {
> +    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
> +        if layout.align() == 0 {
> +            g_malloc0(layout.size().try_into().unwrap()).cast::<u8>()
> +        } else {
> +            g_aligned_alloc0(

One more thing: g_aligned_alloc0() was introduced in glib 2.72 [1] but the 
current glib version check in meson is >= 2.66.0.

Glib 2.72 still supports Win 7+, so no increase to _WIN32_WINNT is needed for 
this version bumping.

[1] https://docs.gtk.org/glib/func.aligned_alloc0.html
[2] https://gitlab.gnome.org/GNOME/glib/-/blob/2.72.0/meson.build?ref_type=tags#L509

---
Best Regards
Junjie Mao

> +                layout.size().try_into().unwrap(),
> +                1,
> +                layout.align().try_into().unwrap(),
> +            )
> +            .cast::<u8>()
> +        }
> +    }
> +
> +    unsafe fn dealloc(&self, ptr: *mut u8, layout: Layout) {
> +        if layout.align() == 0 {
> +            g_free(ptr.cast::<_>())
> +        } else {
> +            g_aligned_free(ptr.cast::<_>())
> +        }
> +    }
> +}

