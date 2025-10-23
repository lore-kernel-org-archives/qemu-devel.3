Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C85CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBts8-0003cI-PK; Thu, 23 Oct 2025 07:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1vBts4-0003Vs-7v
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:52:44 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1vBtrz-0002X3-AC
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761220359; x=1792756359;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HjSO3Biaj0oOSUZ3VsRUhhAlaT0BgFHdtxUXN//zrWo=;
 b=eeBU48dEWOAmESmocC4Srac9AtIbCLiIwNrFqvMwgWxGoKtOQN6dJfNn
 iT39ZuGew/DRxCHfk2ABV7zYE8jGqPQyquAUkjSDEXseuy0i2xwEmJhG5
 KZCDTV93rqSdaFZNK8oRbFdbedABiRbho3O4GxghcUE12QbvxxUZYXE4P
 +WZN2AxZT/zcK/HKkgxf0oGY3K2BsC21igFjmvcNSUpbtCa/xC2TkSEbV
 qoDPG8ZZv0wYRWyc0SDAHWBqy4VCZdk9XRk5D2bHsCJAbD2tJmLbyM/bz
 O42yvfkrrAan9DltMP76/xOB4igf+OwPWwnHqGO+n07SQtTuECWR9Utmr g==;
X-CSE-ConnectionGUID: b+yO3n3kQhipjvk6d9o5yA==
X-CSE-MsgGUID: Xscw+N4+TmS4axzuSm0SVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73677201"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; d="scan'208";a="73677201"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 04:52:35 -0700
X-CSE-ConnectionGUID: iPTqBXe3TA2zbVuyeUcCqg==
X-CSE-MsgGUID: Xi+MRTHMRBqcE+F5yIsPJQ==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 04:52:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 04:52:33 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 04:52:33 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.24) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 04:52:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6kbrfLR5KFAfmgQJ7HkvJRhIKpJFHoAXRduiU4QlpgfB5BNXvDkVK+P2thVcGn0dHGwpFe2ZT5YEn/nGJtrG1yKHLPfGTAIqE9VCT+AzmpkHZX3Hm1UEoHl5BjFmhnnESUfZMZxOCK/ohrKYTv9DP8ZBKa0pAvw3HkuUk9aucqPr8Qtuf/g96TfdYocfnBVYcw7BqYIiLe7I/XClqX32LawV3fMIgqxcvRhmW53pztofcyskH9uXDHncjnREBb7EVHemNcm1NZ6TGtF5H5MECx32T82A1XY7L92RH305fkeNVUogoVeluKi2lebTRMMM2LdSpm4QbCQkNGwF3ohsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUDFq5VBRM/sJa7RYsT0anWYk4ii6p8KoVLurSq8sOw=;
 b=cO9hHignUvPGA89evY9rGvE9ivaRKhxU9wJ49klnbeyzuGEJuS2qSJCn2d7w/fKPKGyVrJDRqhjFv454hP9nRvk7/weuEeeODH/q/FkkFz9mja4eqO3lnjGVmy7g6kWab97/ASuec4vFkicQPQlFNMfkTtOeCU799CXwR7KT4ZONo/kDhK9WmWKdo+WDsvF6sxqqYoKGWMc/RTWYwi1FXkPtwCuKVINmuG8YMZkmTf+iOY1aCjoIT/ypELuIcpi71oxpQ9biK3IXIMC3pSEDix33pYPhzaSdyAtBBmFBI0KIWMzzj5ybmaCd8uhsZ7VcwYK0a0PyF55/ohrCzBURCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 CYYPR11MB8308.namprd11.prod.outlook.com (2603:10b6:930:b9::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.13; Thu, 23 Oct 2025 11:52:27 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 11:52:26 +0000
Message-ID: <ef16f86d-c899-448f-863f-0da872a354aa@intel.com>
Date: Thu, 23 Oct 2025 19:52:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ram-block-attributes: Unify the retrieval of the
 block size
To: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Alexey Kardashevskiy" <aik@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Gao Chao <chao.gao@intel.com>, Li Xiaoyao
 <xiaoyao.li@intel.com>, Farrah Chen <farrah.chen@intel.com>
References: <20251023095526.48365-1-chenyi.qiang@intel.com>
 <20251023095526.48365-3-chenyi.qiang@intel.com>
 <ab265378-6e08-480c-92b5-640f84bc6706@redhat.com>
From: Chenyi Qiang <chenyi.qiang@intel.com>
Content-Language: en-US
In-Reply-To: <ab265378-6e08-480c-92b5-640f84bc6706@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0076.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::16) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|CYYPR11MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: 3309d180-364c-4c14-805d-08de122aa2e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U09pR3cwY3hVQnZ2MGY3bkxkTDJvMUFWQzkrbmNGQUhneEhlVVNtTGhoQnhS?=
 =?utf-8?B?Kzd6WDlJdzJKS0NWRXZwS3dValdjUFVFOXR2TEVhdUEwT21lVEd2TkU1SDRM?=
 =?utf-8?B?N1dHWDZCNThxYzQrYU5tZDFxdkpjaU9VWFV1Q2FXd25IdFRoeVpuYXl3RUx0?=
 =?utf-8?B?emwvSUNDaDduWFlVSGhDcndLVkZodHpla3JhRXFUSVYxaDd0cmNXYVE2MXpi?=
 =?utf-8?B?eFVTVU9kS1lVYWhaSUJ2K2lYSE94SDNuRkdnVkRQMWhFL0svQi9iQVNZZEox?=
 =?utf-8?B?dVBUR2hiemVCeUViWjJkamhCMnBFZldScXNkYllOSHpiWjR1QzBnOWhnaGdh?=
 =?utf-8?B?aTF5WDJHd05HOGdzdzVZNlJKajZySGFxTk5iRWZiQk9WNDBnTkQ5L0E4YTdK?=
 =?utf-8?B?a1llVXdEMnJqNXNTWC84bDhCUVRpL3Q2N2FmSDR4NXU1SkhNVVNZUm92bk1Y?=
 =?utf-8?B?RjhpbTdLckd3UlA0NS9HbWY4UWNjL1gyQk8xUktyb1BLOTZPZjBtQU43YVBS?=
 =?utf-8?B?amVIKzB2MUdNOTVDUDJlUDNzMmRFeGdJYm0wd1MrOUlvZEVjejVwaGNVWFpt?=
 =?utf-8?B?Qm1yMzF4U253V1FyaTdEbmo5QnBVWkI3K0VkRUczd04ySnZUU2ovcndkRWtI?=
 =?utf-8?B?V1lKWnBwKzEvOWNxSjVLcktEc21wbUNyM0I5Y2tRMWt6am1TQng1Ny9odVZv?=
 =?utf-8?B?QmUrSEZtQThNcVYzQ3RQTGVKL0dyQnBLK29ENDBNWHJUdWc2SHhCTFZxRWk5?=
 =?utf-8?B?NStCc3RjdTZMQWFZNnpPMEdvK2tKU05JV0kwbjRuR3FjQXR6MGV5N05weWw3?=
 =?utf-8?B?TjZmTVpkckhkSlVXNW5SZzVrZEMxZGNuK2luOCtJU3NlK08yTzRxdFNqTklY?=
 =?utf-8?B?VGVzenV4bjMycGVHQk9Sc3hBK3oxaWRlQ1JacVUzMzlOWHlLTk4xV0V2UkxM?=
 =?utf-8?B?eHpGandLRXF4Wlp6S3lzMFFJbm9oSkNZOEpYTWNvNWNpOEhkbVdUd3lBOGFi?=
 =?utf-8?B?ZkMxTHhMaHdZL2FZRHhMbUM1SldnZ0FLZU5hc0lmUUxiTWdMak1hOE5kczZQ?=
 =?utf-8?B?b1huQVIrWXhYZk03NHJKUTBWTWxNcUE4M2piWXhQNjdoZjBPZFZBcXh6RU1I?=
 =?utf-8?B?YzlwODlpNnA3WitERm1SK2hQRUpNUzFSMUljSzFkZ09FbldrMUZNT2hTRVpC?=
 =?utf-8?B?VzZIUmJVNEFjL0VnTi94WHYwYU9ZYWdNUWNuWVFkVGVrelpVM3Z3TVZveHk5?=
 =?utf-8?B?YllMNXJBSEdyN1FYeEJ2eEtZZGdTN0o4c084a0tYV0ZOWGh5b1BJa2FTejJr?=
 =?utf-8?B?Wkc5N0xIdkFqcWladUk5SVo5a0NRU0JMSTd6S2NMakU3QmdBSzN0YVhQOGlC?=
 =?utf-8?B?V3R6UXdqYTh0SmF6bjRUd3ljby9YMDJiREdzVmxRRUQ5emhLTkpsQzVLcWVP?=
 =?utf-8?B?UEJZRkNpajkzdnRvZ3hBenlhckcrbGZYVHBWQlg5a25FVVlaYW9MOXAycHRt?=
 =?utf-8?B?WDRCWGJEUXdnVTZaYWxDUUhvY3dpL2lzeDhLTGFKWm1JRnAvQzh3Z2FJUjQ3?=
 =?utf-8?B?aXg5V2dpNEZjUTQ0TjBBcVRUODcweVdtS1luem9PS0hNendwSlZxazBOODJo?=
 =?utf-8?B?NHVPNitib3N4ZlJOVGF6ZEx4S3V6MFU3NHpLVlVWM1cwNjNmOXAvVUtDeWtv?=
 =?utf-8?B?dUx4bE1yNGZFa3A4b3F2ZTFhVTBJaTdQZ252TDdtTmcxekJrd2JuenNtdE01?=
 =?utf-8?B?U0QrNkZ2c3Z0bjFnUE5yR0xsYlNGb2RyMlhyZTR6Q3V5bXBFVWh3bThqUDZU?=
 =?utf-8?B?azNFUUY1VmU1NWlyMEg3cENkVFlFUUFFajFEWEExcFhBMHkrMmRyUks1WFJM?=
 =?utf-8?B?bnFDbUpzb1pYemZsUTVVSGZrWmVIMDNpT0RsL3JmM1hEWWVxMm1CbVFPZ3VV?=
 =?utf-8?Q?EPSNsewQ+qb2yddRJhjuR4O232kHPxr1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG9XT1FqNGoycUtEMVh0M2ljS1d1ejE1dURDN2w0Nmh5ZXdjYm9hWlc3K2NC?=
 =?utf-8?B?QkVtbzNsNUxrSUUzM0pXVHp1WU1XZCs3NDFTYytwMGs3d2ZndnIxc2xmQlNp?=
 =?utf-8?B?WWtQbzlENUlnOXpPNm5UY2M4RDhYekRPcjllOGVqWE5Sek5KK3JqWW9VVlFP?=
 =?utf-8?B?dVdId21Wc2llT3NjVThVVEFyalV1QmU3Y0dsTk5YK3NGcCtELytscitLcVBI?=
 =?utf-8?B?Vkc3bmdyNldVRThXcFRuYmczNFV2V296RUx5U2tSZFpCWENnemlPUkt6Q29L?=
 =?utf-8?B?ZnMrMHNEd1ZVSlkyYS8vYUVRRUhaNnNEM1B4TjNwTVpickx3aFZmSmJuMU5x?=
 =?utf-8?B?dHRaVVhOZW9tWExONHh4aFo0T01XeVp2N1RJN1QyY1dJUDVmS3VtLzdUVElH?=
 =?utf-8?B?Z2FpMXUrVVZJelhHbXZRRWROS1E5MEpPN3k3bjdsa2dIQUZRRmxGZDErUnQ1?=
 =?utf-8?B?U0svQk1aU1dPWnRCOHhlN3JSMnVzY09RZm5BelZFRXR4b0ora1p1eVlmU0s1?=
 =?utf-8?B?U2tKaGNBN1hiRDZpYUVqcmM2YnBHd1l2Y2tIUVQ0cTNCU1l6V2hXNjF6T2RI?=
 =?utf-8?B?Z2w5WnBMZnppdTdzd2s3VWEyaTNBam84bVZwOEVSZ2JPMWhSVW9TemlJRkF6?=
 =?utf-8?B?bTdDYUpkRVpGNVJWMkUzV1loMkdkaEJ0R29aN1ZjTWhVdlRvc3BINjVOeWM3?=
 =?utf-8?B?RGdkTloxY1RPdlUzNUx2R25mWExhQUdieGVRb1RUSTM2YXpxTm1SZk5rRmNy?=
 =?utf-8?B?c1BPRWFzV0tRTHdkaDJ4c2tqQkFLSHJrSGhrQXlLcUI0VS95cU01VEhiMGl6?=
 =?utf-8?B?WTQza29rQTRHWHBkUTFVOUkvZWxwNlJ2U0VhQ0N2cVUzQk53eVd1RjlMV05q?=
 =?utf-8?B?VWhFa1BWZ3Q4UU1oS0w0UFRtalR4M1A4dzNncFdUcXg4QndpVTkzVEFsWlFJ?=
 =?utf-8?B?aUVDODNaVDdmU1BlTWM1cENtSXQxYXJxUGJWRmZBWnBmYUtOZlRLUjJmVnky?=
 =?utf-8?B?T2RDbzVaMGpzdnE3VUV2eTN0MnJnWGdDM3FCMmp0ZFdpdVE2QXVnVjExMWM3?=
 =?utf-8?B?d2dDTG51cm9mWHBVTDRLcGljTmRYSnkweG1wWmVsT2NNaWw2TU41TFNCU2E5?=
 =?utf-8?B?T0FXM0U5RTJwVVdSSnFZem15OGgrKzlFNEVncHFlTldGOHVBdE5venYrckhk?=
 =?utf-8?B?bDAxOFlGOGxkYzlrTzJDaGVDODZZeDNDOGNScFN2YlMvT1N6WEROVHp1NGlv?=
 =?utf-8?B?R2ZzdmkvaFo2N2ltSkh1bzY2WThiQSt5U2txOFB5SUtrVStuUlVIN0RPM0xL?=
 =?utf-8?B?VE94bnR0b0pGaUExc3dRREdjNnlkbjNiaUt2cU92dVFhVXNaMmFxN09kRWs2?=
 =?utf-8?B?MDJ6dHNrM0xmNzI0Ri8wSTNtRXZQT0R5V3VRbzhpazQ5ZUFqZnN1RFJWYmZV?=
 =?utf-8?B?M3U2bmZXSExoZG5iaEJZZWFITTJWZ053QkN0T2Y4clBVbVhtN0w5Snk4UmNY?=
 =?utf-8?B?SG9wN0xiTmZhQWZVaFFvYXg3SWFzbGRYTHRsNkhuMWp4bVF2SUZLQzJpWjhq?=
 =?utf-8?B?U0J2UURQdERtZHBjYkxHby9Hdzh3dWFxMUxCSzVjQUp4NUtmTjRPSEV4a3JJ?=
 =?utf-8?B?SWNhdm5TaUNKOENNVEprdjJqMlFGWUs2emRod0dhM05kNVBiSzFwTDlQeVc5?=
 =?utf-8?B?b2hTM0lweG4wWjlJb3VnMXpVaDBYUkU0RE1kY1V1Um1PaC9mT0VYYWFXampR?=
 =?utf-8?B?WUMwbENDSWE2Qy9BQ284R3RkWTBicGk0Z0VkSnc2U3hEWU56NENKRXMwdlpN?=
 =?utf-8?B?dGFoWlgyYTRJcXZkeVhpUkVjdU13bGw2WDJzelZBS0hBcldWNnpBeEZNODR2?=
 =?utf-8?B?OGttQ1crVHpZbjl0WkNXTjA0VVpjd2xxYUJLZ01qQytubXdGN3lkZXllZ3B6?=
 =?utf-8?B?MGZTSmo2ZWVqZEtiWnVmZUg3WERxcjlOalhrbWlVYzREdTJkMXhkVTdUS2lx?=
 =?utf-8?B?K0dWbERzWXV4eStqbWY5TXVneFhDNFo2U2JZbExmTHM5LzAzQjhqa3FJYlZM?=
 =?utf-8?B?U2N2TDhrdm9aVzlHQ2xnQ2V1RW9hMlVIUEl5aW5NTzBnVFYxSDRZQVhESCtP?=
 =?utf-8?Q?AbT72zLSBwat5PclMb3XP3RwR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3309d180-364c-4c14-805d-08de122aa2e1
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 11:52:26.7543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HfxOavZTo4O0AbTRiE1BhEd24daesUl3xcj/S79SPq/L0BhPlf0OdGdmNJlX1VTyQvJl+u29CFrrWpRg2BirJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8308
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 10/23/2025 6:17 PM, David Hildenbrand wrote:
> On 23.10.25 11:55, Chenyi Qiang wrote:
>> There's an existing helper function designed to obtain the block size.
>> Modify ram_block_attribute_create() to use this function for
>> consistency.
>>
>> Tested-by: Farrah Chen <farrah.chen@intel.com>
>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>> ---
>> Changes in v2:
>>    - Newly added.
>> ---
>>   system/ram-block-attributes.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
>> index a7579de5b46..cf8f5f41966 100644
>> --- a/system/ram-block-attributes.c
>> +++ b/system/ram-block-attributes.c
>> @@ -390,7 +390,7 @@ int ram_block_attributes_state_change(RamBlockAttributes *attr,
>>     RamBlockAttributes *ram_block_attributes_create(RAMBlock *ram_block)
>>   {
>> -    const int block_size  = qemu_real_host_page_size();
>> +    const int block_size  = ram_block_attributes_get_block_size();
> 
> Double space before the "  " can be removed while you touch this.

Oops, so careless I was. To fixup this patch:

===

From 3c224dfb946feccf6f94af8aa1068cc72bf5ddc7 Mon Sep 17 00:00:00 2001
From: Chenyi Qiang <chenyi.qiang@intel.com>
Date: Thu, 23 Oct 2025 19:43:52 +0800
Subject: [PATCH] fixup! ram-block-attributes: Unify the retrieval of the block
 size

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
 system/ram-block-attributes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
index cf8f5f41966..fb7c5c27467 100644
--- a/system/ram-block-attributes.c
+++ b/system/ram-block-attributes.c
@@ -390,7 +390,7 @@ int ram_block_attributes_state_change(RamBlockAttributes *attr,
 
 RamBlockAttributes *ram_block_attributes_create(RAMBlock *ram_block)
 {
-    const int block_size  = ram_block_attributes_get_block_size();
+    const int block_size = ram_block_attributes_get_block_size();
     RamBlockAttributes *attr;
     MemoryRegion *mr = ram_block->mr;
 
-- 
2.43.5



> 


