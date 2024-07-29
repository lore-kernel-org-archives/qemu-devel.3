Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8ADC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 07:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYKuY-0007uI-2k; Mon, 29 Jul 2024 03:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sYKuW-0007s7-F1
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 03:35:12 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sYKuT-0006VI-Kp
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 03:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722238510; x=1753774510;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jTDkIi01UMcVgDlgPFzqblvBX8fbv8fWRj6ep9Cllmw=;
 b=FRNchgpi3VeMdsnKYyWbb+G+4hUyxZoKlO5d9oj+GV9BRXyaizOlEUb4
 f/yR1W1jq71cRlC19Y1+Z3JHW5HqWeE4I9bLvGjm78jVBwKpZBdOMfLUZ
 TReTGd1z0AQW1fZpxWAkJTvheHdC5zX0KEBDfrSfLJ11eSCSS+7PyiQP3
 PYXXXSQLKT18Zx2f6lfNzKRUKCba5yEynQT81O/LAR17cbOSQMmm2A7Og
 ujb890bpj+x5sYjFIAEDVSxmoGQXlLS4XNClp9BukM2YjMe2kzfOEPtwq
 8fmxY4X5XRAFf6ndRMAcgQU4tb+N1vXBU8YUwZdl6IBymnc4c384bU8gJ A==;
X-CSE-ConnectionGUID: DPkQt9b+SOyZ4sLk3FccXA==
X-CSE-MsgGUID: II+vzSjkQEaNQrG86avqyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="31370151"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; d="scan'208";a="31370151"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2024 00:34:58 -0700
X-CSE-ConnectionGUID: nshqtH2eQJ2QhxZ4O4YvCw==
X-CSE-MsgGUID: 2dPa6ripToOWyVObXH1z7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; d="scan'208";a="53848463"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 29 Jul 2024 00:34:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Jul 2024 00:34:56 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Jul 2024 00:34:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 29 Jul 2024 00:34:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 00:34:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjJe/zm/oqVt+mr4LkpdHTs2or3RkQt+5lj93curx/Z55xc88TL23s5AMiAnIjayEsA7UJGwIk5WBByVtsn1iicNEX2hvfoPzT32AB0HdDASamwQLx2SelPu5pE3t0yj5o1eRESQVEjnBs9F1roTXcOoOvgP4nSlUdGK+nuyrQQfcP8Q3uYOJbHjl3R1P6udDWNpUwLGC+A5S8rRon8bji2TjwNdcbJsavCdl/8H0oxEwAywG9BVTO6uvl1kJGDPcWGqpww6/dbk7wHCX3PYbTUN03DQMDfmKqoQM7clLmmqpXJDEObjZbOpk82oywsduVzm10AD/Lk13q+NvFlb7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7f2qEz3Gvic4GCv7W1SkPvmx58vbv+RzaGCAENv1Ans=;
 b=s/uUFw/MtRHBcdyyMbHIxp2IPlbkil3UqgCHpvU99mF6RAjnn+zuNYpbEQ0ZwOuBnOJAWSYJxQagAO7Qtqh/IupQs6/7PMK1bcMVcqH/RTXNlr7vQLrxksG3xx3maDs22h0ke+6mAf7Q49gXdlbHpjdXeFiSO2R/8oGbQ7/FmIsz6kRvZpE0C/BZKbTEPr8M5uytVgGbrZe+HI+OEZ14OA6OjZZDpv9DgzLgQFdGaf4Dwlo5F5PGNb23WVq4uLB6QQML40Wl4oTgchZq+isn9HMowQuAaZsfhdlWGV/Nz2cKxymNzuRi2zq9SFwE5MMJ5UB3uEMvoxF19ryAdRUq0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY8PR11MB7874.namprd11.prod.outlook.com (2603:10b6:930:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Mon, 29 Jul
 2024 07:34:54 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 07:34:54 +0000
Message-ID: <db972177-851c-4aa9-bd4c-777fe2b01ae3@intel.com>
Date: Mon, 29 Jul 2024 15:39:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/17] intel_iommu: Use the latest fault reasons
 defined by spec
To: <jasowang@redhat.com>, <mst@redhat.com>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <peterx@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <chao.p.peng@intel.com>, Yu Zhang
 <yu.c.zhang@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-2-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240718081636.879544-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CY8PR11MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: b9bebbb9-b817-4dd1-5019-08dcafa0f027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emgvRjZRWTdHOFVBSUE5RlRibGhqc04rVmFLM0hSZDFaSmN2dHdnMGdNNVJP?=
 =?utf-8?B?THZEMmxwWnZ4Wnd5RjROK09ORmRsa1F2cVRaVVJxcFFEb2NkdjFmazhaTGpY?=
 =?utf-8?B?R1E5dlVXNEZoMU81MVd3bFlCY2xSbU1pZStLamlXNkdUZDk5MlZsdzg0dmNo?=
 =?utf-8?B?TFdCbUU0aGQrZ0VNcmM2SHVjak9pcjNDTzUxc3JRWDBVai9GblRPTW01dWhX?=
 =?utf-8?B?WXFYcUJlM3RhOWJyMmZoVnl2K2QxTEU3c3l5WjhPbm5FNnJNRlIvZVYzWDBB?=
 =?utf-8?B?Q0pzb3pQekx1SW1WZGlnM09FWTZuL1NEb1JUYUtlMUdmdlIxUkhZRlZaVUR3?=
 =?utf-8?B?WUJBV3lGTDdlTjJMSkZJN0dhL3ZsQnYySElpK0V0TjNQMHQxNTVQOEFuRGsv?=
 =?utf-8?B?T0VBZ0pLK2tYa1JtUkxrNXVGdmp1cDFBL05NcUQ0UnAxRTNlQ25IR1dMNHFs?=
 =?utf-8?B?KzNneGpiTUNSb2Q3aVlKc0d6dWgxTUtOWTA1MHdnQ1JOUGRWS3hJVndQMzRX?=
 =?utf-8?B?TlR4UmJvdkRESlNGSVlQVG12TnVsR202eHRrMFFFcno5b3BRWC96bVQ2cUdr?=
 =?utf-8?B?eDI2ak9GNUo1c3JUNXFwamY0TmxaTkJzTjNXR0NEM3ZNVnVKalZlTDhwck1o?=
 =?utf-8?B?eHIwWHA3bjAxUmMybyttMlM5TXBudG95blJrTUhCSS9BeisvS0FIUTZZTHhl?=
 =?utf-8?B?QmF6dVNkUUFKUDY1SGhaNnFrQXdMQmpqUE9KSGl1eGJWTWN1T2FSOTlvQk1D?=
 =?utf-8?B?R2E2Ty9hb09SN3djWTIvTWdWRFVxQXpBdWZDODFuUSs1eFhTQVp6THl4ZGV3?=
 =?utf-8?B?NEJXNFBVMXJOVDVMTGtXWmtQV1o1aUV0eDhMU3J1dkdONjNYR2tsUG9IWWdS?=
 =?utf-8?B?cDh2NWlRVUxQaHZSQ2tJZU14bHFuUVEzVk43cmxuQXlIeHNJb0FhMFBiR1g5?=
 =?utf-8?B?aXlWYXpxNGxpYXF2OVZHa0hjUFNKcFhNUHkwZjF0R3pnbm80SC8xSUtJa2N1?=
 =?utf-8?B?VWxmMzBsbDN6ci9TVVpyeGVMbDBvbzVUbUxKKzF0K2p3Rk9nb3lVQWIvL25o?=
 =?utf-8?B?S0R0b1JlQTJLczNzUlFZVlYrN2U5UHg2dC9sNkVqRVZRVFFLdzNhK1pNVjFu?=
 =?utf-8?B?bjIxRGpWWVJ3MHdjUnNYSUhWK1U4Rm1nUkFFYzAzeHRBRlNhZVVsNjJtOFBs?=
 =?utf-8?B?V1UyekhFbUNpVjRTM0tSbXFSWW9aazhNL1FPeFcwU1pXc2tQeVk3WlhyQ1Fr?=
 =?utf-8?B?dVBrNHVEWXFVL0k5Um9mbHRXcVlPQ2NBRDhzOUltWGpZV3hQWnRZV3dBMVJp?=
 =?utf-8?B?VFJyNDdVcWJSOGxwSDlzYkl6WUR0eWFFTWxhTWMrVmlHTlA3bmQwVDBIWHN2?=
 =?utf-8?B?UUN5RzFxU0REVFVwckZIZ1VYemxITTliTVJmMytaQkJyTWJmSU1ycGdYRzZG?=
 =?utf-8?B?RkJyM2hOSWZ5OUJtQ0JIUS9YV1NCL1lJQ1k4QzNZQS9DWmFqQitrekhoYjNK?=
 =?utf-8?B?LzFWNjllUWt0Vnc5VTlVQStOWWs1ZFRBOUM4eFJqbTE0ZFJSaWRTR1BveFYz?=
 =?utf-8?B?WnBGTURRUk92OU1vQzYxM3BmT3Z2QTk5NjVMZGRxS0pCY2JiVWYxWVhRVVF0?=
 =?utf-8?B?a05NQWtoU0dHRU9SMUh4ektiRTh2Zy9pVTFXblRjZ2tkWGtNZXJPQWxJM2Yy?=
 =?utf-8?B?NTM0ZVJoMHBRdmJBeU94KzRUbkU0ZVdyTVVrWjFSZGR0UkhsRE9LZzNBYkI3?=
 =?utf-8?Q?4G9OVFlXYPrKihgchi1nK/SB26f9/0XwjOKCmUo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1JKTEVxUUVHUFZEVnk4V2s5OTNxOUdXbG5VeHk0SU94MHlMUkw1TEpsSi96?=
 =?utf-8?B?b0JnL2IzY2N3Qk1Md09nU2NELy8xbDZmdGZRSExJT1lMSDdlbXArMEJCQ2dF?=
 =?utf-8?B?cmhNOW1PaFZsdEQxMDZ2V2kwZmlyYWF4dllNRHEzTU9HNXUveUxpVmpMTlZR?=
 =?utf-8?B?TXhHaFVXTnFlVEVGejBpMXp2RG52cmpHL3hBQXdpRVBMNzh4bWVMci9SOXFM?=
 =?utf-8?B?dlI0T1FZZkhOWXY3VzZKOVUxRXJxcTNUdWZHQURLbkJ5Y3pWOXNRZUMxTnBy?=
 =?utf-8?B?QnR1cTNEUUVyZW1TeDFCRExDOC9VQVI1ZWxYR3pxdU0vUkJ6cXFFVm0wUnNr?=
 =?utf-8?B?L2huVUNLUzc3OVh5ak1naG93UDFDUXNoY3VXTm9KSml5N21wZXVOOTdxN2Zx?=
 =?utf-8?B?NUVoejlHc082SGtHNDQ0V0dFMTE4eG41bTh3d3ptbTBYSnJFK1F3QllEa1hH?=
 =?utf-8?B?M2RjSU1yNUZQNmhGNC8yUDB2emE3cHNhRVFyOVlOb0hucktXdlVzdEpHTjhl?=
 =?utf-8?B?SXlmRzNwZlRCMitPeTVTVE5GS2cwY050a3FrckxjdUU2Z1d6UlBtK2JXTnha?=
 =?utf-8?B?UjBoVHp3R2MvY29CS1BSWThaUGVYeGM4M2hWVEZaZ1VvWVRpeXJJQnkvOWJD?=
 =?utf-8?B?VVZaU2xOckFkR2JiMUVNcUM1R29mMnlKcWlIbG53SEtvTmp2SHRjTXFleHJB?=
 =?utf-8?B?Y3publNZaWlWOVh4SG4zeHNPUTZLQkdLTUh5Mk5pTUZ0UkptL09IZzN6KzhR?=
 =?utf-8?B?M0pseHhQY3craGl1czgvMzVmZUNWNjdYYjJsV3UvYUZQTDFyTGdBaUdlWFZT?=
 =?utf-8?B?UVRsR3p4OW1qSUNzRnJjQmZxTHV2WTZKd3RVdGVLNGsrQmNTRjl6dWR1bnAw?=
 =?utf-8?B?SE9tRFd1Q3l0cDNtNjUxMzg0N1FHY1Z4SkZhMjZUVVRvRjNObzQ5T29vWlVD?=
 =?utf-8?B?SFc3RjkxRjl5Smk1aVA5enJzNUtZclBwNGtVT1ZUM3hpaUh3U3lTZGp3SE9a?=
 =?utf-8?B?bElhN3lCSU1MK21qYmZpajQxT0FwSXZGK0VTY1NjSW5rYklib1llVXYrVHJN?=
 =?utf-8?B?VkljL3U5VXgxbDdKR09neGQ1NXRleis2Y1Y4eU8wUlZ3Yk02WTgzb3NXY3gx?=
 =?utf-8?B?OXFESHQ4QWN0WWYrU0hBRnE1QjRjUGE2TTVwSURrMGdSa05TTGs3bmUwRzhh?=
 =?utf-8?B?ZGNhWFk4Qy9tYjNwSStScXQ2NzZUaVFGYTNRVEp0cUNTZVpVZDVUQjFHNHc1?=
 =?utf-8?B?L1RmbUUycEJlcjlwZWg3MERHenFFcHBiUXdJLzdUQ2pOTWRPVC9mMnlaV3RJ?=
 =?utf-8?B?N3NrdXc5UFJBNW1ITlZhYzgvcWI4SnY2ZkpxdTRxUGdaUC95Z0ZiTm11UDA3?=
 =?utf-8?B?cy8rKzFTckFqem1HeURsem45MTVOdWd4T1YyK1p1MVFqZEI5WXRYUWxiQUpY?=
 =?utf-8?B?VCtvd1dSMXJnSUYwVEVTck5Ucm5pVmVndjAwdzNHLzhKZDdIZUJRSlNWSDll?=
 =?utf-8?B?UG1pZEpKdnZuQUplTzhFTVVJTm90bW8xOWZ6UEVrR0tGNlZ5OEJjRHlUbkZn?=
 =?utf-8?B?RmxDYVRwNFB0eXJLRk1ZUUFLZ1VZMXdWazh1aFQ5ZGJHZVRKakJ3MnhiT3lP?=
 =?utf-8?B?c1FJT3RTcHdOS21WOUJtNi90My9MNWZSNnViM3RrQWZmSURGb1cwdW1GVXpX?=
 =?utf-8?B?bEs0VHUvaWhRc1VLZnJLVHVoVHFkdk9rT2ppL1dyVTRsV3FwSGVrbU85S0RO?=
 =?utf-8?B?RzVoRlRucjMxSGJvK0p5UENwN09qTm81eG91cHpoMDdJVG1aNHhCMG0waGtL?=
 =?utf-8?B?NlhlTENxWExNN05nNkF6QWVkTDFHRmhyWVpwY1FDOG9CS2FvRXZ2UWEwd0ZY?=
 =?utf-8?B?ZzdSUkpJTk1QOG93RExrNE8xZXNFZmhCL29GSjVEbFF2NndlVGU0dVU4QzBF?=
 =?utf-8?B?NkpGS2RJN1IxRDcyMlRWdFRTVmRidENJV2xyOVpOQ0RDYWNxZ2t4NTdZNSta?=
 =?utf-8?B?Q1Zvclgvemd6eW5oWklIUGlnZU5pUWs3cEhRbm96dEUzRkJ5NVM5Zk1WRVBm?=
 =?utf-8?B?OHY4ZUx2WSt6bEtvQWNxVElYWW1IalpYWkNFaXlNamVYS2tLTlMxUVN4WmNO?=
 =?utf-8?Q?u1/Kdz3XTGx0KpPzWg4FZIa1e?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9bebbb9-b817-4dd1-5019-08dcafa0f027
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 07:34:53.9612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OHLqCUSXjqpc8l7Z53u7wa1iQHwwYZKkl0kgUxhefoDjpBO9rtqxx6OIHRnQQS62lqvcTXijW0o39LFqyK0vcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7874
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 2024/7/18 16:16, Zhenzhong Duan wrote:
> From: Yu Zhang <yu.c.zhang@linux.intel.com>
> 
> Spec revision 3.0 or above defines more detailed fault reasons for
> scalable mode. So introduce them into emulation code, see spec
> section 7.1.2 for details.
> 
> Note spec revision has no relation with VERSION register, Guest
> kernel should not use that register to judge what features are
> supported. Instead cap/ecap bits should be checked.
> 
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_internal.h |  9 ++++++++-
>   hw/i386/intel_iommu.c          | 25 ++++++++++++++++---------
>   2 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index f8cf99bddf..c0ca7b372f 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -311,7 +311,14 @@ typedef enum VTDFaultReason {
>                                     * request while disabled */
>       VTD_FR_IR_SID_ERR = 0x26,   /* Invalid Source-ID */
>   
> -    VTD_FR_PASID_TABLE_INV = 0x58,  /*Invalid PASID table entry */
> +    /* PASID directory entry access failure */
> +    VTD_FR_PASID_DIR_ACCESS_ERR = 0x50,
> +    /* The Present(P) field of pasid directory entry is 0 */
> +    VTD_FR_PASID_DIR_ENTRY_P = 0x51,
> +    VTD_FR_PASID_TABLE_ACCESS_ERR = 0x58, /* PASID table entry access failure */
> +    /* The Present(P) field of pasid table entry is 0 */
> +    VTD_FR_PASID_ENTRY_P = 0x59,
> +    VTD_FR_PASID_TABLE_ENTRY_INV = 0x5b,  /*Invalid PASID table entry */
>   
>       /* Output address in the interrupt address range for scalable mode */
>       VTD_FR_SM_INTERRUPT_ADDR = 0x87,
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 37c21a0aec..e65f5b29a5 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -796,7 +796,7 @@ static int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base,
>       addr = pasid_dir_base + index * entry_size;
>       if (dma_memory_read(&address_space_memory, addr,
>                           pdire, entry_size, MEMTXATTRS_UNSPECIFIED)) {
> -        return -VTD_FR_PASID_TABLE_INV;
> +        return -VTD_FR_PASID_DIR_ACCESS_ERR;
>       }
>   
>       pdire->val = le64_to_cpu(pdire->val);
> @@ -814,6 +814,7 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
>                                             dma_addr_t addr,
>                                             VTDPASIDEntry *pe)
>   {
> +    uint8_t pgtt;
>       uint32_t index;
>       dma_addr_t entry_size;
>       X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
> @@ -823,7 +824,7 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
>       addr = addr + index * entry_size;
>       if (dma_memory_read(&address_space_memory, addr,
>                           pe, entry_size, MEMTXATTRS_UNSPECIFIED)) {
> -        return -VTD_FR_PASID_TABLE_INV;
> +        return -VTD_FR_PASID_TABLE_ACCESS_ERR;
>       }
>       for (size_t i = 0; i < ARRAY_SIZE(pe->val); i++) {
>           pe->val[i] = le64_to_cpu(pe->val[i]);
> @@ -831,11 +832,13 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
>   
>       /* Do translation type check */
>       if (!vtd_pe_type_check(x86_iommu, pe)) {
> -        return -VTD_FR_PASID_TABLE_INV;
> +        return -VTD_FR_PASID_TABLE_ENTRY_INV;
>       }
>   
> -    if (!vtd_is_level_supported(s, VTD_PE_GET_LEVEL(pe))) {
> -        return -VTD_FR_PASID_TABLE_INV;
> +    pgtt = VTD_PE_GET_TYPE(pe);
> +    if (pgtt == VTD_SM_PASID_ENTRY_SLT &&
> +        !vtd_is_level_supported(s, VTD_PE_GET_LEVEL(pe))) {
> +            return -VTD_FR_PASID_TABLE_ENTRY_INV;
>       }
>   
>       return 0;
> @@ -876,7 +879,7 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
>       }
>   
>       if (!vtd_pdire_present(&pdire)) {
> -        return -VTD_FR_PASID_TABLE_INV;
> +        return -VTD_FR_PASID_DIR_ENTRY_P;
>       }
>   
>       ret = vtd_get_pe_from_pdire(s, pasid, &pdire, pe);
> @@ -885,7 +888,7 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
>       }
>   
>       if (!vtd_pe_present(pe)) {
> -        return -VTD_FR_PASID_TABLE_INV;
> +        return -VTD_FR_PASID_ENTRY_P;
>       }
>   
>       return 0;
> @@ -938,7 +941,7 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
>       }
>   
>       if (!vtd_pdire_present(&pdire)) {
> -        return -VTD_FR_PASID_TABLE_INV;
> +        return -VTD_FR_PASID_DIR_ENTRY_P;
>       }
>   
>       /*
> @@ -1795,7 +1798,11 @@ static const bool vtd_qualified_faults[] = {
>       [VTD_FR_ROOT_ENTRY_RSVD] = false,
>       [VTD_FR_PAGING_ENTRY_RSVD] = true,
>       [VTD_FR_CONTEXT_ENTRY_TT] = true,
> -    [VTD_FR_PASID_TABLE_INV] = false,
> +    [VTD_FR_PASID_DIR_ACCESS_ERR] = false,
> +    [VTD_FR_PASID_DIR_ENTRY_P] = true,
> +    [VTD_FR_PASID_TABLE_ACCESS_ERR] = false,
> +    [VTD_FR_PASID_ENTRY_P] = true,
> +    [VTD_FR_PASID_TABLE_ENTRY_INV] = true,
>       [VTD_FR_SM_INTERRUPT_ADDR] = true,
>       [VTD_FR_MAX] = false,
>   };

@Jason, @Michael,

Do you know the rule of setting this table? I noticed it was introduced
since day-1[1]. I didn't see any history discussion on it on lore. So not
quite sure about the purpose of it. Per the usage of this table, it is used
as a filter when the iommu driver has set the FPD bit. If FPD is set, some
errors need not to trigger a trace which is mostly for debug purpose.

I noticed Peter had asked it as well[2]. But I don't think it was clarified
clearly. May we have a clarification for it here? BTW. I didn't see VT-d
spec has any definition on it. So it should just be a software trick. :)

[1] 
https://lore.kernel.org/qemu-devel/1408168544-28605-3-git-send-email-tamlokveer@gmail.com/
[2] https://lore.kernel.org/qemu-devel/20190301065219.GA22229@xz-x1/

-- 
Regards,
Yi Liu

