Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CD5C52D6F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 12:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc2Rw-0003Ds-GM; Thu, 08 Aug 2024 08:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sc2Ru-00036J-E9
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 08:40:58 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sc2Rs-0007cU-CN
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 08:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723120856; x=1754656856;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=e1w0Dw8cacJ/NxSpQ2V3diuT4xBsU2qBfercdJkBKlc=;
 b=j9Nvj10gLDhsNwUZb0I6XkBPOG6MlORr3tWdfi9aTagxeohWx/uyA0c3
 ubp8kbgJsL88Ppb+7IWvCcSmm0F/cPcHWizNQ4yuCMKQJmtZd9+XStuGF
 w3GoPd/H6+uNAnbdfLLlx0BiV8V9RtJjODf+K3flzlSnoJXgkbUEl3FOF
 dngxbDp679vUDOdvpn4aU3BP5wn6RgQ6GnUSPYiPD67eOJ+3vRQdD4y8Z
 tAdhZ4mKPeEbOEw1hnZvBZuuir1JIEzHe+Sw64+UYtcegVNdhOjLr/jSg
 FNZFEXR1hya2OhyfdSts6gGOA0gSu/qQSBnvKNKBtweqGdvBG4X45tEAQ g==;
X-CSE-ConnectionGUID: She935s/Seu2cw/L+Q1PWQ==
X-CSE-MsgGUID: 2BLxbN/VTPmmONrRq5Y9aQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="24151313"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; d="scan'208";a="24151313"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2024 05:40:53 -0700
X-CSE-ConnectionGUID: gPUROLo0ToKn1Pr5M/U1EA==
X-CSE-MsgGUID: NBVMQqYET+q9NG/ExtvG4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; d="scan'208";a="94749309"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Aug 2024 05:40:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 05:40:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 05:40:52 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 05:40:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWaJ6EzcLDvlqpDVYphgIgTpEl7DCEWNSew4gfQT75T2Mh5ELAAfWq9zcZWDjc8O8pXcXFxN/g4MvMXVIMK4nR3BxRN3ouD4L1wMyByovImTvDtPxuHjOD437AklKz3uQf9lSXGe78Vft8Rtwhlp/8Holf0VuJjeUD2ErkUMyhhnoWnS7Dy6vAJ1jDa3fkVNDReZ50R3E9sZDNKXHgFitcCvPBULGuZEztcBx86CGG0JeyTtT6b0JaJr3Nd2qPmUFpqkfvCl9Wv5F7CZwwnCpnvs2vnqWk//r+gkGQ3gF2szTeIEnHpFdS5XVo2znZEyDxuwDQDJGEODGwz5OVsDNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQi0jNhOFi4nEy7E9ik24RFvTfgJX/G0uIBX+9weNJA=;
 b=rDaVFZygk4Y7ft1FeLsJE7490LbEXmr5f2iDejUie4qalvG+wB/tGwSbxibkG2nqf+09REKWdnyaCGWhrrLOHiAp4jExV0IdFCNBnkaCuarKvt+Qra/XFYWsYQXH+VzHTYfD2OlAJeVORVgbDyUcP3hVDlxqnSIJRO6HOGSUJxelV6jma/q74aGeGmWG5AMo3UBU1N2ZoFko7GS+xO9mVU7X3AQFhBQFhvVnmqKdzWMyxD54xodlPzz1JHDrpbsjpEUOegaygyvu0Gg+vIcVRHuAxNmbuZQj2KtHbiyLEeXpUtk2kqzp7/bsbVHPkUhJIMtXcVD0rC4ljJ04yKNLRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MN0PR11MB6182.namprd11.prod.outlook.com (2603:10b6:208:3c6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Thu, 8 Aug
 2024 12:40:48 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.7828.016; Thu, 8 Aug 2024
 12:40:48 +0000
Message-ID: <ecfaec89-bdfd-0512-b9e4-d2dc237a9c56@intel.com>
Date: Thu, 8 Aug 2024 20:40:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 04/17] intel_iommu: Flush stage-2 cache in
 PASID-selective PASID-based iotlb invalidation
Content-Language: en-US
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-5-zhenzhong.duan@intel.com>
 <d245008c-ef6e-4a58-bcbc-869aa4901cf4@eviden.com>
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
In-Reply-To: <d245008c-ef6e-4a58-bcbc-869aa4901cf4@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0208.apcprd06.prod.outlook.com
 (2603:1096:4:68::16) To SJ0PR11MB6744.namprd11.prod.outlook.com
 (2603:10b6:a03:47d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB6744:EE_|MN0PR11MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 2291cdee-43dc-4870-9600-08dcb7a75495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHRUUkppOU55UEdtVENFK1EvWkNPZjl2ZGZGN0hyUlJhWHlSMG51ejFKZGZn?=
 =?utf-8?B?QkJwWFlTbGNXYlBtQXJ3UzdseGc1bEI4UUpTemZHbC9WS3ZWQUg5SEZkSFp3?=
 =?utf-8?B?NDVFeXpjcHRtaE10bHc5cUQzN2xMRklJOEtWaTNkUDl3dis5Yy8wVXF0SUl4?=
 =?utf-8?B?TVVrME5VY1RrY0Z6OG9mSGZmaTV6VC9Xd3M3WU54eUpvT0RGcUlCdjRXdUd5?=
 =?utf-8?B?T0R1VFkyVTZmRmxmM0F0bjkyMjUvdTJSNlN2dFV4QUxPZ0lER1oycnY2S0c2?=
 =?utf-8?B?VHZYeWZRbGQ4cXZZS0d6ZmVrQnZBbUJsMVVFQUFQdEdsOXRteE9KajZkRXJk?=
 =?utf-8?B?Z0s4MU5BaE5TdkJEQWFraVhRRmNwaGVDc1BwY1hqbEsyTzEzLzdYYXZlRjlQ?=
 =?utf-8?B?andhWE9pWXpBSTY1Z0NmbHVrOENaY0Z0cFA5czdpS0c0a3dBM2M5M3I0RTB1?=
 =?utf-8?B?a1E1eHFhT1BsQTZ4aEVpR2x0VlptS05ZK0wwZU1iSnYycVNrVnVYdTdmY2Vp?=
 =?utf-8?B?SlMrajUxVTFtVmx6VGpLV2lkNDA3cnRqVDEvbC9DN3VacE1KeXh2U3dHOGhB?=
 =?utf-8?B?cGZzWW1IbkU5Q2ZxSGNhdFpaT0R6dW0wbjNjQXdFcXg1R0JXYWN5aXQ0Y05m?=
 =?utf-8?B?TFNPcDRzSzNIQUhIWEgrK3piOW1WM01EUnMreVM1SUlKS0ZSL3daSWRGL0pF?=
 =?utf-8?B?WnppMjdibTNiOXUyMWZnRElFMGMvYzFqeURzSkxQYWdScko5WXRqQ2ZQWk90?=
 =?utf-8?B?M3lDRWdFaFlVdHhIS0h4eE9GRVdoemNOWXZBREZJWUdDNVh3YXlTTm9wV2hE?=
 =?utf-8?B?VTR1MDc4Q0hGZUs0Ny9tS0tsTW91UEJqVGZka3R1N3ZaTGd1elNrd1NEUnp2?=
 =?utf-8?B?Qk1XNFRZYmJHTHdRSytTYldxQmpSV0hOZlhBRy9jbHJXVGZRSGsvdFhJbVJq?=
 =?utf-8?B?REtLcE5lQjhaOEZvQjFUV0dia0RnckY3ZW9laTQrcjBEeVMxZGFXb09RdUhk?=
 =?utf-8?B?NTV0TWZ1YVJlUDFuNzdDYnZiNVV5a0hEcWxBWmtHZVBGdi9uTW91dFlHSC93?=
 =?utf-8?B?Q1RhM05xSTJicDJwamxzQWtnNE1FMldCZTcxTUI0VTI5aDI3VkF4eGJ2OVlS?=
 =?utf-8?B?VHdjRXlTTHBqbU9VZ3Fjd2Q3ZndIdUk1QXdCOGhpV2RkQ3MvTitPdU9xMGxI?=
 =?utf-8?B?WFNob043Nm1pMWdORjFMYlIrSkllZWpaNjljWlhCSkxkc3hvdlFENjVZZ3hE?=
 =?utf-8?B?YmxVSVlLUzdGZkhaZG9EODMwK3hEaHVVclMvam9DRHJieUh0L0tuZ2Q5blNQ?=
 =?utf-8?B?YXFXbXY5UzNvaSt6SDd6STNvdGMwTDJwMGJSZGQ0QzRWa2JyY3dlNThmUFYv?=
 =?utf-8?B?RklUYm5tcElkTEZiSHNkSDFhaHZaTzlucmJ4QWZXNFFzVndrNGNlN1NWdEZo?=
 =?utf-8?B?K1Yrazh6QUwrVmhwS1NsVkM0d25rbWRYenBZbWlSQnBGUnd5R25GUS9wM2pH?=
 =?utf-8?B?dUk1UHVKaGlqQ3ZMa0EvdzBCV3lNUk1Md2Jqak5PWEJ5Q1ZLY3BhN2tMZDNo?=
 =?utf-8?B?Vkc5UDE5RXhOVGtCZldWcE1TMTZrT3RsakpQLzRya3o2K2d0b3hFNE5HMW8w?=
 =?utf-8?B?N2M0c2F2d2NxbmsxR3lLWHgrY1VrK3dJSFFJVkMzRnVzRXYrTVoyTEZ1ck5Y?=
 =?utf-8?B?Ui9XVjBqOEF1RDZzK3NDcnVkMnNFRlRqMDJkL0ZwVExVc3FJWXVPVVllTEtC?=
 =?utf-8?B?elZtYndhN1RKb0NENWgwQUNPQU1Dc1pwcDM3aFd3ZnpuQ1FMUjVYQjdGcVFM?=
 =?utf-8?B?dFc0dEJzbzVqcm9pcnZLZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGJCV0NJWkc4WWtRcnVXM1VLYStMWHQxdzY5bGNTNElUcWQzc0Rnd1J2YUZs?=
 =?utf-8?B?UFRxMkI3aUhsZHNNalQ5NjljODIzS1c4TkhvS0tTR0pkWmFveFQzS2NidEls?=
 =?utf-8?B?am1mODNrK00zZm1YZWxHZlVQdk8wYzY2emVDOE9KbzV2VUpleWExUU5KNWdV?=
 =?utf-8?B?aUlnMTVWWUNBdlIza3J4RE1wUUFIWSs3TlVaNkxKaWxxVWF6QWF3UGprdmVN?=
 =?utf-8?B?clRVaG5Ha0dRTXp5QXdiOGZkY3NpWTB6bXdxeU1uUXN3NnltUXZwMUFJektI?=
 =?utf-8?B?eE1qZFMzWDV1RnU2WDBzc3NrbmhiYmlJQ3grYjNud3J5b0tUUHF1cWt2Skls?=
 =?utf-8?B?Z0RtdGEySXdxNW9sSFQwaDBkVW1COG0waWZlUVN6U1A3dG1ob2xESlJVY1RC?=
 =?utf-8?B?MHdYR08xTjlkRy91ZFlpT0FyNndKczliUThRRS8vNE1GNnBoRks1UEsrM1Zp?=
 =?utf-8?B?MmwwY3FsU1pvSFJrNkVOdlFGYWdlZGtaWWMrRGZLZWFmVkEzZkNpdkxhUFF6?=
 =?utf-8?B?S051aG5xTGRvSEFvY0tldyt1UVFTeFNoMVVjS0hqOVN6U3dGZ2hZam9jWXlt?=
 =?utf-8?B?L3BNU0cvUjdJV2ZkVTFXNXpDTFdiRm9UY0pEeUZzUnM2WjR4L0RqRjFkV09F?=
 =?utf-8?B?bVRrREZibEtaOVI3TzltZXB1NnVSQktxK1lEdklOSXRhTVJFNWZueXBqY2RU?=
 =?utf-8?B?ZHhWek15ek5JWlZDZ09XeUdZTUN1QlBncUlDay9IR0YxVzFEZnR5eGJXUkhn?=
 =?utf-8?B?WjZwVmdGL1didXpXWjBPMnRXYkJLd1BCOE9INEFNcTczSlUxSW56dmRYajlV?=
 =?utf-8?B?ZllSU1FBT055TlY5dElDazlEY24zLzZvb1o0ckNjN2dOYVFmR3FYUjNrTEFk?=
 =?utf-8?B?MTg3Qk9IcUtQVG1ZUmppbDVSNTBCUHFGSXFhMWh2QWFCSk91SlY4NU52SmRn?=
 =?utf-8?B?SWpRbFRTYS9kWTRxKzc4SmFveVZnZUszNE10ZkVQblpkS2VwaTdrRUxmaldK?=
 =?utf-8?B?cGs5czdVNUtLeS9ma1JEUHBOR1RWd1dUV3p0U1l3QTAweUNZRlpNTm44QndH?=
 =?utf-8?B?cGxNMWR3M3RnS25Md01QWlNZZlFWMGcwVEE2dHhWTFNwaVVmWjYxQWxrWWtV?=
 =?utf-8?B?NHRqMGEvdVUxWkFKY1paREdlUXBCL3hqMjRabkdUWnJDTEVRS2hWZGxDcmc3?=
 =?utf-8?B?RDVsTWdBd2s0VDMyUng5OUxtRVk0RFN4eWtmNmxxQUZuOVE4Z3pzYkVkM0Ra?=
 =?utf-8?B?VkFlazRZNFk3NFFEWjNRMHByRVNsOEZQTzZNUTV2YjJNMHhmU0JCR3drcVYy?=
 =?utf-8?B?N1ZSWWQ3ZTl6akVtdm5yTklnaGhwbG5WUTBJTHVxVkhQM0ZTaC9wRnN5bWZ2?=
 =?utf-8?B?Ty9Mc0NjVEtYVHd4dVRzSDVDQkRsdE9ZNHM5K1E4NVJlUDVtc2VVMFMwNTly?=
 =?utf-8?B?YWZDSHgxQWZDb00ycW42eG9nbS9RbXFnTmQvdURramtTMm04enBoNXBLMlRz?=
 =?utf-8?B?dm5mVlZCOFc1QSs0S2tra1hoNzJxQ2pMaUNYSElMRjRQQXJKQzNSRzNPK29G?=
 =?utf-8?B?VU1sUTJSejQwSTNDbUhzcm1vTGtiTkgxT2JSVkVWSUNQRm5UVS9DSEhmNVBr?=
 =?utf-8?B?WkFlOGtzNDg2dUFVQVJHaE1QYi9BSEE2bGtkeXhMZGhGZzN6em9BWStiOGhZ?=
 =?utf-8?B?bGc2d0hKeDNQRERQckZqbnlaREtGVVhzU1BDdWlQck1NK1o5RjVJNnZFR214?=
 =?utf-8?B?WVBlY1dWZEd6bXk5UlB4V2c5eVEvNlUxSW5OY2dJc1VMNDFBUG16N1VZTElI?=
 =?utf-8?B?UDIyWnloY1lGc3NFdEUvZ3oreGZxcEVrZ2plMm5jV1pnelN5Y20vVEk3bC9j?=
 =?utf-8?B?bEhCb0lQQjRybU83OWZSZk93K2RFY3ZzNUFNY05aOWhHZ0VVa3VqemJycGhY?=
 =?utf-8?B?ek1LS3NMdUFoSDMyalpBZy9RV1VRVWIvTno2b1FjbHZML0pZUmRJamM0RXJr?=
 =?utf-8?B?TmtHU2xRTk04dU1SbGoyK0VjckcvWmRHUUtCNTNCUVJ5eTZzRlF4YnFhLzVT?=
 =?utf-8?B?ODhhMkNpWjRPemM4Vys0YUpRZG1SU2xKUkQ1SS9FZnVwa2ZCeldSREQxYWF4?=
 =?utf-8?B?NzJVckVXaE1XVFg3Y1Y3Y3gyTXpWUkE2bkcwQUhMMDQyYWtOY2ZyeFp5L0J5?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2291cdee-43dc-4870-9600-08dcb7a75495
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 12:40:48.7610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NQdnWyJpYnw0SZXsfJNauNU9FFM724IGJPaDYWP/Ub1eqK7aFp0cSn1NlctYrv9irJ2qWmF3YYO4vfj2M7+SGYHGS305gD8dAXxn/JU/O6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6182
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.427, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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


On 8/6/2024 2:35 PM, CLEMENT MATHIEU--DRIF wrote:
>
> On 05/08/2024 08:27, Zhenzhong Duan wrote:
>> Caution: External email. Do not open attachments or click links, unless this email comes from a known sender and you know the content is safe.
>>
>>
>> Per spec 6.5.2.4, PADID-selective PASID-based iotlb invalidation will
>> flush stage-2 iotlb entries with matching domain id and pasid.
>>
>> With scalable modern mode introduced, guest could send PASID-selective
>> PASID-based iotlb invalidation to flush both stage-1 and stage-2 entries.
>>
>> By this chance, remove old IOTLB related definition.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>    hw/i386/intel_iommu_internal.h | 14 +++---
>>    hw/i386/intel_iommu.c          | 81 ++++++++++++++++++++++++++++++++++
>>    2 files changed, 90 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
>> index 8fa27c7f3b..19e4ed52ca 100644
>> --- a/hw/i386/intel_iommu_internal.h
>> +++ b/hw/i386/intel_iommu_internal.h
>> @@ -402,11 +402,6 @@ typedef union VTDInvDesc VTDInvDesc;
>>    #define VTD_INV_DESC_IOTLB_AM(val)      ((val) & 0x3fULL)
>>    #define VTD_INV_DESC_IOTLB_RSVD_LO      0xffffffff0000ff00ULL
>>    #define VTD_INV_DESC_IOTLB_RSVD_HI      0xf80ULL
>> -#define VTD_INV_DESC_IOTLB_PASID_PASID  (2ULL << 4)
>> -#define VTD_INV_DESC_IOTLB_PASID_PAGE   (3ULL << 4)
>> -#define VTD_INV_DESC_IOTLB_PASID(val)   (((val) >> 32) & VTD_PASID_ID_MASK)
>> -#define VTD_INV_DESC_IOTLB_PASID_RSVD_LO      0xfff00000000001c0ULL
>> -#define VTD_INV_DESC_IOTLB_PASID_RSVD_HI      0xf80ULL
>>
>>    /* Mask for Device IOTLB Invalidate Descriptor */
>>    #define VTD_INV_DESC_DEVICE_IOTLB_ADDR(val) ((val) & 0xfffffffffffff000ULL)
>> @@ -438,6 +433,15 @@ typedef union VTDInvDesc VTDInvDesc;
>>            (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
>>            (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
>>
>> +/* Masks for PIOTLB Invalidate Descriptor */
>> +#define VTD_INV_DESC_PIOTLB_G             (3ULL << 4)
>> +#define VTD_INV_DESC_PIOTLB_ALL_IN_PASID  (2ULL << 4)
>> +#define VTD_INV_DESC_PIOTLB_PSI_IN_PASID  (3ULL << 4)
>> +#define VTD_INV_DESC_PIOTLB_DID(val)      (((val) >> 16) & VTD_DOMAIN_ID_MASK)
>> +#define VTD_INV_DESC_PIOTLB_PASID(val)    (((val) >> 32) & 0xfffffULL)
>> +#define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000f1c0ULL
> Why did this value change since last post? The 'type' field should
> always be zero in this desc

Yes, type[6:4] are all zero for all existing invalidation type. But they 
are not real reserved bits.

So I removed them from VTD_INV_DESC_PIOTLB_RSVD_VAL0.

Thanks

Zhenzhong


