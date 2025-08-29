Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF982CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN3U-0001bd-JR; Sat, 30 Aug 2025 10:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urpD2-00083Q-QL
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 22:51:26 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urpCu-0005ut-P2
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 22:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756435877; x=1787971877;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=w4EatWu79LWkXG2DN6ere9nJZjE91GI9Uj5dJX1BfvQ=;
 b=SZpemSE+YIdHxfGsGqyvz9D5XlEh+3XWc34Dt7moCS4C/tnuFJrClcfb
 Qm0Ou/vaA7/2mnEPymF5m1H65W83X53oqg4qfo9laChqRUAipDjjHn0rs
 dXV6SslIh1wd2R5NHIfIPoBZRoDNypS0Iq4bD+aMpu3uGJ1pErRrwKVKM
 k4LSw7yz4madfxZLAgouQXLIUj3OaIMOgZ1NcoyHDup4HVxSdjYD7Erkb
 cZfORf6Zeztp1D/nnPlXO/hRSERzxrXCV9vM7USWFjAKOORW8cktQScDj
 pac+cx8QLZdNDUmR3Lv3l67+TCdCyJP1TrsoZV82DUyQIN9aFdh11k4+1 w==;
X-CSE-ConnectionGUID: LIo3Wv8iRnqnTuWIa6Yl2w==
X-CSE-MsgGUID: 50B6Lt+lTxyInLfthp+rnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="76171291"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="76171291"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 19:51:11 -0700
X-CSE-ConnectionGUID: veMkq1gxTQC+OuAvJ0QS2Q==
X-CSE-MsgGUID: c3mP5LDdQLOQFjlRjNgc2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="207412831"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 19:51:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 19:51:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 19:51:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.85) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 19:51:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8AylLaX0enxayOxf3f11Bl/g2Zl1X2o7Cb6PV05nKTMHrP+eFwbi4eeLJxba0p1MPdDUbFWfeFnUyByvyxHg+oCygVbAQ7nHV18JGlcMKBvDkc0vBnqU6TsybVzaeT2s08EXk0RnTNBmQazVMnpTEcd97gCUbuaXx6jGEYHbVI9kU7vvsaBn0f4CC61zx/b39aTR7w+Aq09hoaZxXw7Cshquh3bi3rL8xCGRjgU+v+SVsPfHTIlpbxCHZLTA9alCojdP16QrR3CtidDddTtX8vENZubXFvu8yyTESyct9DGl2N9nmJEWR0TOQgI72OwoFmsbXNMlp7r3gs5kCR2eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGTm7FHB491LyzWBgVR3DBi3n0qmuuQcgKp9fbPe6FY=;
 b=J1rPuARhoQwDKtab4n+IS6VYLNeYxoA3GDrGakuO/n8FML+G5SymnnnvNe2TejXnsrsYVJKZ5NRGZYjpuu39bbZwJMtpbBR1xw3E9jeuFu6sDaZce2zqqcQjDJ7fuN/CAk8TSpvXW6SZ/IBCFyRz0NvkmGJpyeNsf3CgPH0wDDP6o7EV6v2HJJKeAaPboxorxZ/o0Ilvu8mNj2Ya5Ftz5uiMF7dokTp3cczacmcpBtEx46VskvPAg6fc+c42RxtFM1O/FSyLvMnl+thdXAu4ds7ArH3zN3mvdnAWgRQ4AXpji/gC+SwdK6SH+ap4Ea+bDVYARkoIx55dykxj/649/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by SJ5PPFF8B526086.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::862) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.18; Fri, 29 Aug
 2025 02:51:07 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 02:51:07 +0000
Message-ID: <7bbc171f-6e53-49df-91e5-49f0378da8c0@intel.com>
Date: Fri, 29 Aug 2025 10:57:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/21] intel_iommu: Introduce a new structure
 VTDHostIOMMUDevice
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-8-zhenzhong.duan@intel.com>
 <05dac745-f612-4556-bd99-9de32ae63ccd@intel.com>
 <IA3PR11MB91364B6A01BCCEFF73F7B589923BA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB91364B6A01BCCEFF73F7B589923BA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|SJ5PPFF8B526086:EE_
X-MS-Office365-Filtering-Correlation-Id: a500e916-818e-4a50-254a-08dde6a6e6a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|42112799006; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2o3cW1SajVPQUdOenVJY1ovMVR0T0VsWGhKVmNhWUxESk93RkxteGV5TGRT?=
 =?utf-8?B?d20wOVJjTGdzdnN6SlRTcVNuMXU1TWp6RUxiOGNQZ2RhWjJpbW4wQkZhRjQ5?=
 =?utf-8?B?SEJ4ZnZOakNoUlcxdjZ5TFJMSlFER3h4S3hpRmhWbHIrSTJFdVArYy9PWUow?=
 =?utf-8?B?YS9rMXB5dFZmZkpmT05rRUdvMDhVN1N6TWNVN3BRcU5FdUNYRGRQWGJNOEpl?=
 =?utf-8?B?RWRCNkJnY080MlIwdk5aa0JYTlk1NVJraW1JY1hyY0p5cnF6NTF3L1NkTHdw?=
 =?utf-8?B?RzYweHV1M3RMYlhyclE0dWV0a2hOV0JvQ25ZanJPQnl3cnp3UU4yOXhSeTdo?=
 =?utf-8?B?TGlWaEl5NndyWnQ1ZGhFNnc1TmJ4Z2pnMjloUmF1WVRPR1MrM0lXTHBJOEI3?=
 =?utf-8?B?UEZDN09FY3BvZjViU0hxRUdjTjMzVHdQOVEzbjI5K1lXSnkzb3NBVkVhUmFv?=
 =?utf-8?B?blRiQlBRODJ6dGYzd2s5NGlDeEFNRG4yVFlzUFJHeHZNYlI0WmVCNG9ISWE1?=
 =?utf-8?B?VlFubHdMcCtMKzRxUUNlTjR2WG9zTnBXTzUvMDBSVGVFYzhiQmxoeVNmV2ov?=
 =?utf-8?B?dEl1eG00TzlRMzRMOUhhbHlzUVBMdWxrVGpndThlejBHOVdVYnlOci9Fa2wx?=
 =?utf-8?B?YmFFemdZd2VLNHExOG9LTGFYNkNSNnkrY21OaE1YRTZvU0ZMT3VpWUZHcWxq?=
 =?utf-8?B?Ti80bVgzUnRZSkY5RE5PWlUyVzA4ZCtFZGxlSDVCeWVzZ0x2ZXVtZytDZWZs?=
 =?utf-8?B?NmlXQ2VkN1RUQzBCc1NvSW5TTWowZzJITkcvZHFXbXppenpQd0FqbGl0MWcw?=
 =?utf-8?B?SXlrTS9RQlVGQmFCVGZneVNTcEVQdVF0QytBMDFZc1k2Q2ZEdEc4MmdnRFRs?=
 =?utf-8?B?bEIzZEd4OVdwVHJTUWVaTWpuYWhuc2IvUmJZK01vcytBbGk0MTN0RnNuMis1?=
 =?utf-8?B?SG1GSXE0VDBjaGRYWmRqWU05cytiT3djS0F1VW5wb3kraXZjNW0xQUZvLzlt?=
 =?utf-8?B?akFiSVFaUEdXMVZwbnRnYStSY3c1WExnVDczU255NzkyMEtMMGN4ZHRQSit4?=
 =?utf-8?B?YnZrcWZVc213T0FTZklkUVdycHd5UmtNVU9CL29yNytaUWNyY0lCZUZOOGVP?=
 =?utf-8?B?aEp4TjQzZHRqb2psMHJiOUMzNVEvNUU4Ym5HN3VweU9rSHQ4c1ZxTXY2Z04x?=
 =?utf-8?B?M3pmOVhMSVhNQUFNZzZ1Z1dva2REdDdpODFaWlJIdnNrZks4QWNMbGFva1JW?=
 =?utf-8?B?NVZhVHVRMW5NUlFZVndPRDJSNW5jNkRiWmZVc0FqU2NGUU15OFVaNDFiY1Zs?=
 =?utf-8?B?dUJtbXlBR0NuYU5mK2FTOWQrMmorTWVTWTI1NXJ0RWVjOGt4QjJCS2FCRG9n?=
 =?utf-8?B?aTNJY2N2M3RtVHFjWWU0RzVMUVFHWjRINStreE12cy9pSkhrUlUzdWJJQWJr?=
 =?utf-8?B?dUQ0MGI1S29UZ0FWZzlDVmRGTm5yNk1TcGV6Z2U2OW1INHZIczcyeHhudDVK?=
 =?utf-8?B?bTVudmdVWVBPM2NzYjFVM2VkbWdjUm1EVkRMNGNJYnpOYVZabHlnZk9ublVB?=
 =?utf-8?B?SS9EYmJYdnFZWm56anJMN1B0U0lmTTVqNFFJZFFSSVlrb2JtYW1wSkpaR2RG?=
 =?utf-8?B?TjFkNGZWTS81NjhoRUQxWlJlWTVnWmNaRUdVckFNb1Uwdk13YmFLRWQ0d0Jh?=
 =?utf-8?B?TTNFUGRZMGh6OStsZ3Nram5qTTIxaE4xMzRTTG1MUmJqeHRNeTJMTk1OM1hS?=
 =?utf-8?B?VDJGQnp5TnBOQ1BvTTl3a1QzNW5HZk9BQithSXh0N0l1SWxVZlNyYm9zeEpE?=
 =?utf-8?B?bDlZNmVQdkFDL1NsTnc3bFUwdTJFTVNqeU1pV0lQcjAxZlloWXY5V0FaaUFM?=
 =?utf-8?B?OTJXMjR2OEtPaXdhbG9SR3V2bXpGTmRTQ21ZeUVRZkJqai8vVk1kLzEzRWtB?=
 =?utf-8?Q?YUEwG+hLjnI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(42112799006); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDZSSER4MlFUMXd6U2VPL0RIeDNYRml2TFJ1NnhhOFE0ekNNQWRiRXIxb09P?=
 =?utf-8?B?U09TY01aMGdFYUxjYk9kNkhYc2hJUUYxUitkT0dEVXErbnN0bGs2TWg4amlk?=
 =?utf-8?B?Rk5JNUZBOXZtN2pvWkgzNmQ1SEFQbGw4L2RhU2l2WWJlZ3NyQTdHKzk0eit1?=
 =?utf-8?B?V09USlZ6TmM4RVRqN0xvTXFuSldwYklrYUxvUk9jWDRNN1lpVllwbzVBR2hU?=
 =?utf-8?B?ZlpSL2svZE9UdEFycTJ0dkhtSXhPaHZDL2xsM1crSkdrUU1SQkpac1cxN0k2?=
 =?utf-8?B?emZYRDc3dnpmYzIxMlJDNDAvZHp5VDhrY0l2YWUrTWZSMG95OW5RU3d1Mzlk?=
 =?utf-8?B?MWxyYytrbmJNTU0yUkVNeC9QNnhjcXpWdko4ay9zTkVVenNwQWFpZnJlOTZm?=
 =?utf-8?B?ODgzMGE4Nmx6anR4UHlNM0V6UndmckQvRHhpdXBpUEU1cEdZV0owM0VFTjQv?=
 =?utf-8?B?eFhCV3lBcS9Cek1RM0dxTkdTVjBIUitSMEkvZWN5anhFNUJVY2pJZDV4d244?=
 =?utf-8?B?NTEyRVdpNXM1S1I0aUxPdGJzanpCbFUzbjNtNGc4Rk5oYmFtand6bFRGckJr?=
 =?utf-8?B?Y2Q5VytkaGk5S0RudmtWa2pvWWRZZ0MvcFQvMHM5bVFnUWlWQ00yY25VZEdk?=
 =?utf-8?B?VzJqL3kvSitlangvNWpXcE1ycFJhOFZVRHRSaU9UZ05QYlpQWnVBMUdZNnNZ?=
 =?utf-8?B?NktwcGxQZWpuMzZpZG5pWDlQRDdrNDFQUDk3L05EM0V3aEVDTVBlWUFMeStM?=
 =?utf-8?B?OCsycDNJOUkxMlcxVGNNeXBkQXk4anp4WGtkcVo0UG03cVB1YnVmU05iTmRS?=
 =?utf-8?B?UVNDZGEvclV2dUNpNE15NFRMc0VjNWc0MkdWb3A4MkhiYWZTNVJDRDlJSmRI?=
 =?utf-8?B?L3U0WmRncUYyWnV1bGJ0dDlmL2ZZL0tEem15YnVXek5jMHNwSVczbDdRVXNL?=
 =?utf-8?B?T3F0V0RrcUw1YTRjTThKcHp1NTFJbGR1b25JODNpN0tXeElEOG8xWEtYN2ov?=
 =?utf-8?B?MmlqY25waEYya2h5VWlsMDVMS3ZjTHp1Q2s4RTFkMFhYUlVRaGVWNDVjZTZ2?=
 =?utf-8?B?N2JqRlFkN0tIUytJN1N4alZTTUgwYkdWbEU0Q05sUHpLcDlOcEQ1bWE1bHRC?=
 =?utf-8?B?NDBYS1ZZRUVvYlM2UkJ5ZkhqYlRGWG5JV2wvSUlwMUNrQ0JhdElVT2xSZ1Jh?=
 =?utf-8?B?bjhGUmVUUmZLaldPeVUyVldPQksvTGhpamZ5L2IvM0tGVHBLNDVLMDBBMjY3?=
 =?utf-8?B?Zld6TngxcXV3S0l3MkNPSFZNbzBydlZGNEdETnNraUJjbVlUVzNhMUNoNFFK?=
 =?utf-8?B?VDlaWURVd0czZkZDZlRWblM2WXhsL3AyS2lZaGkwY3pmaCsvdmVhek9keHBP?=
 =?utf-8?B?Rmd3Z0hKVEw5Z2R5bDJNT2gzSmQrN0tYNkhOa1VNeFFaK2JQeFUrdFR2N1Iy?=
 =?utf-8?B?MDhCWEN2djVKS1dBdE9GQzZiTFFHU1JOZDAyak5iYi9vTHdraUtjVEpaNGRp?=
 =?utf-8?B?cXlqc1ZaazFlY05KYXRJZFVJdjYwb05WMDdsWG5XWG1RSTlNUXRIem4vM0Jj?=
 =?utf-8?B?SzJ0TnFWQTNDbDR6NEtzai8xbThheUFiMFVvMkJjWitpYTVOZXZtZFRCczlT?=
 =?utf-8?B?MFJYYXZSZFJzL3lDdlhPcmx4YnNLTU4xWkpXd1dFZGFuZS85VXpjWXBWQ1hq?=
 =?utf-8?B?c2k1Ulp1aUYrUnl6U2NMemxwUjVoUUxyc2FmZ1JHZjVJUEcwSXFaN2huK2FB?=
 =?utf-8?B?T1N5QWFKTGdKTEs4RWlrWUMrV2F5M3VFWkxkcGZIK3NCUWI4N1V6OW9KMzdm?=
 =?utf-8?B?dEJhWGZVSlpvWjNaZjFQdklYNEpTa0JWSnlHWU4rZWFMMTZUV1dzUTAvbGcw?=
 =?utf-8?B?UXBjM3JjTjA2ZmFVQTR5MDN3KzZhdFpudXpqM3dEUHBGOUZZNkYwTnJOa09i?=
 =?utf-8?B?d3ZucURib0xHNm40UStGdTFqRlV2NmVCZXZoL2hrKzYzc0I0ZGRlRHo5c2hZ?=
 =?utf-8?B?V3lxVDlMNzJ1VVBIZW54b3RNUFVNK1B4dEo4QW43eVlyNUxOdzhsbjJTSVRP?=
 =?utf-8?B?MGhaTVA3d0FyNXhuQ0FOMnpmSlZCRHZCMGNNSTY4cVlHeUNSL0FYMnVUcWpU?=
 =?utf-8?Q?hHXOLKELFMFl7yiD/hDxLiL7Z?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a500e916-818e-4a50-254a-08dde6a6e6a2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 02:51:06.9199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4NeiewwWGIj0TxbnMU5JPjncnA569pvkfyMvX0w9aufsOF/sog4h4HHmxylu53aHFt3/QatKG1rh6hTSH+fQ1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFF8B526086
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/8/28 17:17, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH v5 07/21] intel_iommu: Introduce a new structure
>> VTDHostIOMMUDevice
>>
>> On 2025/8/22 14:40, Zhenzhong Duan wrote:
>>> Introduce a new structure VTDHostIOMMUDevice which replaces
>>> HostIOMMUDevice to be stored in hash table.
>>>
>>> It includes a reference to HostIOMMUDevice and IntelIOMMUState,
>>> also includes BDF information which will be used in future
>>> patches.
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>> ---
>>>    hw/i386/intel_iommu_internal.h |  7 +++++++
>>>    include/hw/i386/intel_iommu.h  |  2 +-
>>>    hw/i386/intel_iommu.c          | 15 +++++++++++++--
>>>    3 files changed, 21 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/i386/intel_iommu_internal.h
>> b/hw/i386/intel_iommu_internal.h
>>> index 360e937989..c7046eb4e2 100644
>>> --- a/hw/i386/intel_iommu_internal.h
>>> +++ b/hw/i386/intel_iommu_internal.h
>>> @@ -28,6 +28,7 @@
>>>    #ifndef HW_I386_INTEL_IOMMU_INTERNAL_H
>>>    #define HW_I386_INTEL_IOMMU_INTERNAL_H
>>>    #include "hw/i386/intel_iommu.h"
>>> +#include "system/host_iommu_device.h"
>>>
>>>    /*
>>>     * Intel IOMMU register specification
>>> @@ -608,4 +609,10 @@ typedef struct VTDRootEntry VTDRootEntry;
>>>    /* Bits to decide the offset for each level */
>>>    #define VTD_LEVEL_BITS           9
>>>
>>> +typedef struct VTDHostIOMMUDevice {
>>> +    IntelIOMMUState *iommu_state;
>>> +    PCIBus *bus;
>>> +    uint8_t devfn;
>>> +    HostIOMMUDevice *hiod;
>>> +} VTDHostIOMMUDevice;
>>>    #endif
>>> diff --git a/include/hw/i386/intel_iommu.h
>> b/include/hw/i386/intel_iommu.h
>>> index e95477e855..50f9b27a45 100644
>>> --- a/include/hw/i386/intel_iommu.h
>>> +++ b/include/hw/i386/intel_iommu.h
>>> @@ -295,7 +295,7 @@ struct IntelIOMMUState {
>>>        /* list of registered notifiers */
>>>        QLIST_HEAD(, VTDAddressSpace) vtd_as_with_notifiers;
>>>
>>> -    GHashTable *vtd_host_iommu_dev;             /*
>> HostIOMMUDevice */
>>> +    GHashTable *vtd_host_iommu_dev;             /*
>> VTDHostIOMMUDevice */
>>>
>>>        /* interrupt remapping */
>>>        bool intr_enabled;              /* Whether guest enabled IR */
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index e3b871de70..512ca4fdc5 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -281,7 +281,10 @@ static gboolean vtd_hiod_equal(gconstpointer v1,
>> gconstpointer v2)
>>>
>>>    static void vtd_hiod_destroy(gpointer v)
>>>    {
>>> -    object_unref(v);
>>> +    VTDHostIOMMUDevice *vtd_hiod = v;
>>> +
>>> +    object_unref(vtd_hiod->hiod);
>>> +    g_free(vtd_hiod);
>>>    }
>>>
>>>    static gboolean vtd_hash_remove_by_domain(gpointer key, gpointer
>> value,
>>> @@ -4371,6 +4374,7 @@ static bool vtd_dev_set_iommu_device(PCIBus
>> *bus, void *opaque, int devfn,
>>>                                         HostIOMMUDevice *hiod,
>> Error **errp)
>>>    {
>>>        IntelIOMMUState *s = opaque;
>>> +    VTDHostIOMMUDevice *vtd_hiod;
>>>        struct vtd_as_key key = {
>>>            .bus = bus,
>>>            .devfn = devfn,
>>> @@ -4387,7 +4391,14 @@ static bool vtd_dev_set_iommu_device(PCIBus
>> *bus, void *opaque, int devfn,
>>>            return false;
>>>        }
>>>
>>> +    vtd_hiod = g_malloc0(sizeof(VTDHostIOMMUDevice));
>>> +    vtd_hiod->bus = bus;
>>> +    vtd_hiod->devfn = (uint8_t)devfn;
>>> +    vtd_hiod->iommu_state = s;
>>> +    vtd_hiod->hiod = hiod;
>>
>> how about moving it after the below if branch? :)
> 
> They will be used in vtd_check_hiod(), so need to initialize them early.

got it. it's needed by following patch.


