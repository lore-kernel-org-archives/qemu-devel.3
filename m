Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EA9CF6495
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 13:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suuNY-0003HY-03; Sun, 29 Sep 2024 09:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1suuNW-0003H4-9m
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 09:54:26 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1suuNT-00014A-CY
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 09:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727618064; x=1759154064;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=49C7SMhXuWf3kmQqkCJiJbcnKudFqJBWvpt4Gtk+DOg=;
 b=ZMujEbwJLs19jPQe1FlomIoS9C1gXvBg3/G8j783Oj3uryhddYBZTB/9
 uh+DcoKDLoMj8272NEjLbVxMQYLlbceEUAHHRA5Kt40eP93K5W40WHtBl
 gtr1ugrBBsSrTxFMUp1pD1vPXdhRFTqKUwmACnvDmtV/sWQjl4KDyR+Sh
 9GMFXKT1gMLhKeN24+UMRn4v8EI/rmkN8kOdmH0lZbI8G2oSVdycb1Ug+
 Vx0ZrvMLTi/FBPE6abTaWrlvs2c2hQ081UtljVhx3wwGzP1G7xDpa8ky1
 wZ8UCJmizp/DTxlGToM0FMD9W3Wv8HjGYOOWSF8+fUR1WpW/s4SpWobSn g==;
X-CSE-ConnectionGUID: dCkYJwQORoO/OmxJzU9u4A==
X-CSE-MsgGUID: pPVClIiwTPexGYDWLL2U8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="49230604"
X-IronPort-AV: E=Sophos;i="6.11,163,1725346800"; d="scan'208";a="49230604"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2024 06:54:17 -0700
X-CSE-ConnectionGUID: 1aVTrAvpRkizfF8k5V1I/g==
X-CSE-MsgGUID: n1dacdo3R8i/ZBGQCRFuqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,163,1725346800"; d="scan'208";a="110519623"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 29 Sep 2024 06:54:17 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 06:54:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 06:54:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 29 Sep 2024 06:54:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 29 Sep 2024 06:54:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkbVDtUFCCgjkM9mHUMcjNTyYl5MUf+4J75K++QT9hu6HOAD344LUl3rR/fBVTF1PMlseNJxIleLJBvamMVny4S/kgIJuEuClyOALyAvu+T2/IxqVqmhPmpz7ynLShwjNxLujCmJVcRVkvBQQNkzVZobsIT5VnUYXqIUqwtNnEwtQRRlC8St8HoYaEjafST70oJDUk3fH+YFVOCn6Rs2flMgYQjozBakRkoNLPPYOZDfvjJoeiLmdM0ABf0u3tR92OEOXatjFVjxpBaC7+06evB00FyalC5OdKJSh+gG4mRJx/X3JP1acTGkm0I+z/ULqBepiok9J1eiuATpn491dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdTyk2lGQESdU4DSZvOMJCOLmg6wr2uWaLJLfCy/RPI=;
 b=mkqDtG9W98K5SIe0WfimGeD+kNjy7T9JJn97DMy2VhdyO9Y57/tYyVveEgpmWCNPCG1gLZXyXSMQZzhopap3hzhpzSJ8BKWAwB1EYm6EgenOryGvQ5q7lR6cQbz5xETXGX8zedAcYwk+G/gZMRfKBFDDneW8LIuEp6DR+fovRR/RotsYddAjro0eQu1d7ED2+2w8CF86avf4x36lUqOEDCLQj44eUtkwuWxg657dgIzZuw7mJ9JHaGmRDBpR2Vvkd1jzhXA7vFXNUrV7NUUMd1bd1aki5QzRzDs6Pp/4GyxjrFIu+7ZbnRX7kSEEV66j0DR7yGK7sdQbw0Es1uNNeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB8116.namprd11.prod.outlook.com (2603:10b6:8:12b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sun, 29 Sep
 2024 13:54:13 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 13:54:12 +0000
Message-ID: <ff640034-e805-400b-a995-d06c888e9c90@intel.com>
Date: Sun, 29 Sep 2024 21:58:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/17] intel_iommu: Implement stage-1 translation
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-7-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240911052255.1294071-7-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 0108c07f-b087-4883-eefb-08dce08e32c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0hoekJGNmRvcHRGbUdlV3NjOXpxN3NuNCtVaXRFRkJaOFBjTVhieHlhbVZv?=
 =?utf-8?B?eHVkVFRiZTQ5UDJETVFpaUNlbXd2MXV4VGFPM3hyQ1gxZDJFQXR0YU51RlhR?=
 =?utf-8?B?cEYxVk5vSndWVGp1MlZ5L09rYnpHOGJuUG9VVEJhamNpZ2ZCaGJ0N25Jck5P?=
 =?utf-8?B?MXVwdlQ2Tk1DSTN6d1ZjRVFQcE9pSkxERUVEaERoWFVVZ1E4bVdyMFVVOUdR?=
 =?utf-8?B?bUM5alpGTzMvV25ETEJNTFBUQVUra3dMRXVtV1M4dnBnTTJteEYvYkNPY3pi?=
 =?utf-8?B?eCtEbml2OExNbGRPRWhNNU40MlFsZTB6ZEFjMlh1cWRYcVpyOTRHUk5IbnJN?=
 =?utf-8?B?czMxbFh1UmZwYlJqTFl4eVJzRHZaVDhOVTBjWkpNd1pDdXByR2ZQVDlTMWlv?=
 =?utf-8?B?anByejZZM3dLSyt0THpTVVpRUThTcUtpL0xFOXhhY1JNVm9CZFZpVURlTHFY?=
 =?utf-8?B?VVhma0NmRWphb2FkU0lkU3l6WkdVRVR6QSt1QmRMbWF0a0p0M3ZvQXl5bVI2?=
 =?utf-8?B?dWxiYUlLZklndkFGSDk0SVordFQ4VWJBQUFVaFZUSE5KS0RIQTlOTFdGdFNX?=
 =?utf-8?B?ajVtZ2RQc1lNL2hnM0RaWHlOZG1CaVlWaFhEa0hBSlZQRE9VVnNnWHliYmV4?=
 =?utf-8?B?RmxRYlBvR2ljSnUvTkVMMVpHQm5Beks3bzd4WU9SUW82WUt6K0lZbnFYNHRX?=
 =?utf-8?B?UVI4YmVCV1R5ZHI3SzU0SmhJaXJIUUhZVWhwZWJlVXQ5T1BtUW9ERjRJY2ZQ?=
 =?utf-8?B?dEZCT1FXTFAwWW5UMDR5UVltb2tiUDY2UFVYTXpzUTB6UTJMbnpvZGRxMkp4?=
 =?utf-8?B?N2crOGYzdEVpNjFjMDlBNTlkVnFuMU5qNmFlMHUwL2x5TlRIaXY5NGplMGZz?=
 =?utf-8?B?ZzIyRkV6MXpJWFVOdVZQb0JRcGpJNlZxU0wwaE1va1lNdldWQ3VxaVU5VCtT?=
 =?utf-8?B?SndlQ3lZeERFdDIyQ0U1WmRTYWQ0UXFBS05yblpzMkpacXNEa0VBYlU1dEZU?=
 =?utf-8?B?Ly9qOVZ5USsrKytrS2wyMXpveWFJTUtidktOcEswNmFtUFk3S3huakF3UE5s?=
 =?utf-8?B?NWYzc1BjSFhKZU94MmZaUWVmNG1ydExQYUFDYzVHWVpiR01rdzVpUE1Ya2kz?=
 =?utf-8?B?cGNYSkQzaXZFSHdOcDZMM1hoSlRRcWpwU2taUzQxVFd4V2ZUMENiNzV4cnFn?=
 =?utf-8?B?VnB2YWp0dkpUQXM4bFNyR040UnUxUEpMTGdFMGdCSjBrTU5NTWIrQXhQcHFn?=
 =?utf-8?B?cDd4SmNtQ3k2djNDZlhhekV1MWFMckdOR3ZvUnF1S0NMR0NPbHZEd081ZWUw?=
 =?utf-8?B?UVhrZkZvVUYvNjBEL1hNYVBYWFdZWUxDeWtwclhDMHlmZTM5cVludi94NjVK?=
 =?utf-8?B?bTNvZTBGVjBic1FnLzlvM011dVg4MldKVUl0eGFETEFUNXQrMXFidEFrc1E0?=
 =?utf-8?B?NWRhMUY2YUhMMFhQbXFvU0ViN2FOcmRwa0Z4empQY09uRXMzb2hJUVBZRnd2?=
 =?utf-8?B?TjAzVDVVZm1sMFMzSklJb1l1OVRpb0VtWUl5OFpNMmd4YTF1eTBQRUVYSjhQ?=
 =?utf-8?B?aVVXTUFvU1dxU04xMWtYSER1TkEyQnk1Wm8ydFlNTzdxVDRXdEg4SWZwMmFx?=
 =?utf-8?B?WW81OTFjWmtXWVUzdkwrTVVHR2Ntd1REUGs3eTlTWkdwbGl3MTFOdkt0N3hq?=
 =?utf-8?B?UmtPYnUwSFhuNzhpOXpKMlhERUl5SXRSQ0JMNExJTTN6L1l5M05KdFpnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlROc3p3K3F4MTIvNlYzZGpLdi94RVZLSnRZVk1vMHVpRU1wblJaZUxlTnA5?=
 =?utf-8?B?SzcyY3RWUnZDOVJXVmQ0L2kxRENPMFhsQUdDQW1sd0llYlhoOFYxNERITGs0?=
 =?utf-8?B?MEg0dW52SXhXNE9KdXRxcUVLaC80T1dNUFJOV3FKOWNRUThqQjlxQjN5SkQ0?=
 =?utf-8?B?MVVFRUp5RVpYK0t1eGtqclRJU2lrS29XUnUreWI3bllEN00veUZuNWY4U215?=
 =?utf-8?B?bmhqWkxIbkNkbi9OOTVkY3BsM2VJdWVIUjlWZUpDK2FpQWVIbmFSNWRZc2VP?=
 =?utf-8?B?RU56aHlrSE55UkZXQjZmbXU3Rk45SG1sYzYzRTlWZXo4aDVib0l6NmNaaGpv?=
 =?utf-8?B?Qzg4ME1wQ1pyQUJyYTlGTEtzTG1yeXVTbzh5S1dCd0dMVjhmcTdzSk0xY2ds?=
 =?utf-8?B?NnZBTXZEbG04bFlNMW9vZS8vcjZDWjdlbVgrbXZpcktWSkIrS1ZlS01MdnZY?=
 =?utf-8?B?U1lxRWx0akZHaExpSGxIOUdqTHJmeVZ5SUJqc1RYMEszbG1aNWFIMWJBMlBC?=
 =?utf-8?B?RWIzQnpEN0gxbjVxMWsxdXdtSzF4Tk5VbEpSR0lodVF5UVZIUzI1L2h0dUxq?=
 =?utf-8?B?bVV4bVhvUVcrVTg2R3BNVURkVWtKMGpYeDBsQXdSdE8zWDN4OSsrMm9TVmoy?=
 =?utf-8?B?SkE3MDFDRE1iWjJadnAvazZQTTd6TndUbXVWV3ZxTVE3dElEOEFyMU5ZSW5L?=
 =?utf-8?B?VHNGTWhzNzR2MFhPMEFjVzhsNkUzdFpiS1lISGl4bzlndVVCQkY3L1hRUTh3?=
 =?utf-8?B?OEtlQVJvY0Y3akxZd3VOZWc5VXh1SHIxbkZvbEFqM0FyZnpkamtHcUV6eTBZ?=
 =?utf-8?B?UjR6YjZ4WThzOEhiTHFkMkViUWc0bE5tUUpCRUJZVzdHVlF5a2RxYUo0NEdB?=
 =?utf-8?B?OE9KejJ1THp6a3RDcFhjd1NWNEMxb3lNUEs0bkZJUzRFZTNWQ0tGUlNBbGk3?=
 =?utf-8?B?VlZ4aXF5TE1KMFI0NG5MVDJVSU1rbVFSYWJobXFQLzlNa1FyZkx2QktnR2Mx?=
 =?utf-8?B?ZllhcWZPNHNRVFFUdGt2QVQwei9VR0Z1WWRTekJ4aFJWTDdabGQvQ2JTa3NJ?=
 =?utf-8?B?WkJSb2pGWVhhMnkwakNDMW1XUDR2RDhjSFV3bnlIYjVnc3NNRWcvOWREWExF?=
 =?utf-8?B?RHl1OWR2UEdSWFg4TEhRZENkdEVWamVNWEZyVllSY0tvNlA5N01zK3hDb0hO?=
 =?utf-8?B?YXFYQmtnTGRCdGl4ZkJwcEpoMTlQUy9tOWpzQ3VwVGlWWlRyd2syTm9JTzRC?=
 =?utf-8?B?MXN4a3FqWlNhamk0cVlzS1gxcVh2ZDBpekQ0RmNVVlZvYzZrVFZEanNZS2NG?=
 =?utf-8?B?eU82cHVVVmU5cEpKbEZjMGI4cjdNbzJNczM3OTc1RTRYS01wV05Ha09Ta3Zo?=
 =?utf-8?B?SXVubk1DRlEwWVdWVmo0b3lnVHJiR3REMDlFNklKWHQrMWJMZVdUSjRrYnAz?=
 =?utf-8?B?ZzlrcURXTG1tMitJSlI2U2RoWEJkVnVOOXpnVndObUlLUE92RGpSK29qWkFY?=
 =?utf-8?B?NzFtWm9hTTZIRHFCZnE5c0pkQ0pNUjYzWUJoTDdFU0hZN2FrblV6akJqUSt0?=
 =?utf-8?B?Tkp0OUpkZDMzT00ydnRrOVlnTmNjL21mdEF2NE52WnByNlBoVVZ1aGF3VEtq?=
 =?utf-8?B?UnE4d2ZQU1BDSmNFbDBTMElUeE9ENGlKWVdZVXpFY09Hcys2T1NWOXR2YjAr?=
 =?utf-8?B?Y2dYR3lvaVZMS3VwVFkxa3dyNysxckluLzhkdFJmaFR6U2F4TmU4SEsvM2NP?=
 =?utf-8?B?MDlacldyWmhhbWtiNHRDaXZYTDM1Q3JwSmZ2ckNnc2kvQkNKc01BaUJ2bkp4?=
 =?utf-8?B?Zy9HWXFZT2kwVUNwMFUzYXpuYW9BNzF2YXpnTStvVVlrRXFRTy9VS1d0UEJG?=
 =?utf-8?B?bTlxTWtOdzRDRTEvUlZ2cU5SbWs0N1FFOGtCQmoydUxQMjhocXQxUW5kS0VL?=
 =?utf-8?B?ZHRVbmpMZVdvL2Q5a1NCMVlJYnRSZFNsaWpYdDhXRXZZbEpkSmJQc0pnWkhx?=
 =?utf-8?B?MEpsUml1UHFnaUUwMjloZ00vbTQvZlpWZytpT1ZVbHlnVGlYWTVXZ1FxNDZs?=
 =?utf-8?B?dU9NbUpSeW15Yko2NmE4blhlRmEzckYzZWtKZW9lQ3J6eWZFdlgvNU9rYncv?=
 =?utf-8?Q?33+YiiWVVRC153hFZrR7DAI50?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0108c07f-b087-4883-eefb-08dce08e32c7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 13:54:12.4724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgBy7ON5N5Ib2g17qK7zQMU1RDpWjHNhudHnFhCQGCBsXpZaA/m7hqXDKFn56cRLXC9sVgHP+YVm0gxu4kK1sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8116
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2024/9/11 13:22, Zhenzhong Duan wrote:
> From: Yi Liu <yi.l.liu@intel.com>
> 
> This adds stage-1 page table walking to support stage-1 only
> transltion in scalable modern mode.

a typo. s/tansltion/translation/
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Co-developed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_internal.h |  23 ++++++
>   hw/i386/intel_iommu.c          | 146 ++++++++++++++++++++++++++++++++-
>   2 files changed, 165 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 1fa4add9e2..51e9b1fc43 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -433,6 +433,21 @@ typedef union VTDInvDesc VTDInvDesc;
>           (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
>           (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
>   
> +/* Rsvd field masks for fpte */
> +#define VTD_FS_UPPER_IGNORED 0xfff0000000000000ULL
> +#define VTD_FPTE_PAGE_L1_RSVD_MASK(aw) \
> +        (~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
> +#define VTD_FPTE_PAGE_L2_RSVD_MASK(aw) \
> +        (~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
> +#define VTD_FPTE_PAGE_L3_RSVD_MASK(aw) \
> +        (~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
> +#define VTD_FPTE_PAGE_L3_FS1GP_RSVD_MASK(aw) \
> +        (0x3fffe000ULL | ~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
> +#define VTD_FPTE_PAGE_L2_FS2MP_RSVD_MASK(aw) \
> +        (0x1fe000ULL | ~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))

May we follow the same naming for the large page? e.g. LPAGE_L2, LPAGE_L3.
Also follow the order of the SL definitions as well.

> +#define VTD_FPTE_PAGE_L4_RSVD_MASK(aw) \
> +        (0x80ULL | ~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
> +
>   /* Masks for PIOTLB Invalidate Descriptor */
>   #define VTD_INV_DESC_PIOTLB_G             (3ULL << 4)
>   #define VTD_INV_DESC_PIOTLB_ALL_IN_PASID  (2ULL << 4)
> @@ -525,6 +540,14 @@ typedef struct VTDRootEntry VTDRootEntry;
>   #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
>   #define VTD_SM_PASID_ENTRY_DID(val)    ((val) & VTD_DOMAIN_ID_MASK)
>   
> +#define VTD_SM_PASID_ENTRY_FLPM          3ULL
> +#define VTD_SM_PASID_ENTRY_FLPTPTR       (~0xfffULL)
> +
> +/* First Level Paging Structure */
> +/* Masks for First Level Paging Entry */
> +#define VTD_FL_P                    1ULL
> +#define VTD_FL_RW_MASK              (1ULL << 1)
> +
>   /* Second Level Page Translation Pointer*/
>   #define VTD_SM_PASID_ENTRY_SLPTPTR     (~0xfffULL)
>   
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index a22bd43b98..6e31a8d383 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -48,6 +48,8 @@
>   
>   /* pe operations */
>   #define VTD_PE_GET_TYPE(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_PGTT)
> +#define VTD_PE_GET_FL_LEVEL(pe) \
> +    (4 + (((pe)->val[2] >> 2) & VTD_SM_PASID_ENTRY_FLPM))
>   #define VTD_PE_GET_SL_LEVEL(pe) \
>       (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
>   
> @@ -755,6 +757,11 @@ static inline bool vtd_is_sl_level_supported(IntelIOMMUState *s, uint32_t level)
>              (1ULL << (level - 2 + VTD_CAP_SAGAW_SHIFT));
>   }
>   
> +static inline bool vtd_is_fl_level_supported(IntelIOMMUState *s, uint32_t level)
> +{
> +    return level == VTD_PML4_LEVEL;
> +}
> +
>   /* Return true if check passed, otherwise false */
>   static inline bool vtd_pe_type_check(X86IOMMUState *x86_iommu,
>                                        VTDPASIDEntry *pe)
> @@ -838,6 +845,11 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
>               return -VTD_FR_PASID_TABLE_ENTRY_INV;
>       }
>   
> +    if (pgtt == VTD_SM_PASID_ENTRY_FLT &&
> +        !vtd_is_fl_level_supported(s, VTD_PE_GET_FL_LEVEL(pe))) {
> +            return -VTD_FR_PASID_TABLE_ENTRY_INV;
> +    }
> +
>       return 0;
>   }
>   
> @@ -973,7 +985,11 @@ static uint32_t vtd_get_iova_level(IntelIOMMUState *s,
>   
>       if (s->root_scalable) {
>           vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
> -        return VTD_PE_GET_SL_LEVEL(&pe);
> +        if (s->scalable_modern) {
> +            return VTD_PE_GET_FL_LEVEL(&pe);
> +        } else {
> +            return VTD_PE_GET_SL_LEVEL(&pe);
> +        }
>       }
>   
>       return vtd_ce_get_level(ce);
> @@ -1060,7 +1076,11 @@ static dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
>   
>       if (s->root_scalable) {
>           vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
> -        return pe.val[0] & VTD_SM_PASID_ENTRY_SLPTPTR;
> +        if (s->scalable_modern) {
> +            return pe.val[2] & VTD_SM_PASID_ENTRY_FLPTPTR;
> +        } else {
> +            return pe.val[0] & VTD_SM_PASID_ENTRY_SLPTPTR;
> +        }
>       }
>   
>       return vtd_ce_get_slpt_base(ce);
> @@ -1862,6 +1882,104 @@ out:
>       trace_vtd_pt_enable_fast_path(source_id, success);
>   }
>   
> +/*
> + * Rsvd field masks for fpte:
> + *     vtd_fpte_rsvd 4k pages
> + *     vtd_fpte_rsvd_large large pages
> + *
> + * We support only 4-level page tables.
> + */
> +#define VTD_FPTE_RSVD_LEN 5
> +static uint64_t vtd_fpte_rsvd[VTD_FPTE_RSVD_LEN];
> +static uint64_t vtd_fpte_rsvd_large[VTD_FPTE_RSVD_LEN];
> +
> +static bool vtd_flpte_nonzero_rsvd(uint64_t flpte, uint32_t level)
> +{
> +    uint64_t rsvd_mask;
> +
> +    /*
> +     * We should have caught a guest-mis-programmed level earlier,
> +     * via vtd_is_fl_level_supported.
> +     */
> +    assert(level < VTD_SPTE_RSVD_LEN);

s/VTD_SPTE_RSVD_LEN/VTD_FPTE_RSVD_LEN/

> +    /*
> +     * Zero level doesn't exist. The smallest level is VTD_PT_LEVEL=1 and
> +     * checked by vtd_is_last_pte().
> +     */
> +    assert(level);
> +
> +    if ((level == VTD_PD_LEVEL || level == VTD_PDP_LEVEL) &&
> +        (flpte & VTD_PT_PAGE_SIZE_MASK)) {
> +        /* large page */
> +        rsvd_mask = vtd_fpte_rsvd_large[level];
> +    } else {
> +        rsvd_mask = vtd_fpte_rsvd[level];
> +    }
> +
> +    return flpte & rsvd_mask;
> +}
> +
> +static inline bool vtd_flpte_present(uint64_t flpte)
> +{
> +    return !!(flpte & VTD_FL_P);
> +}
> +
> +/*
> + * Given the @iova, get relevant @flptep. @flpte_level will be the last level
> + * of the translation, can be used for deciding the size of large page.
> + */
> +static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
> +                             uint64_t iova, bool is_write,
> +                             uint64_t *flptep, uint32_t *flpte_level,
> +                             bool *reads, bool *writes, uint8_t aw_bits,
> +                             uint32_t pasid)
> +{
> +    dma_addr_t addr = vtd_get_iova_pgtbl_base(s, ce, pasid);
> +    uint32_t level = vtd_get_iova_level(s, ce, pasid);
> +    uint32_t offset;
> +    uint64_t flpte;
> +

do we need to check the iova range as well like the SL path?

> +    while (true) {
> +        offset = vtd_iova_level_offset(iova, level);
> +        flpte = vtd_get_pte(addr, offset);
> +
> +        if (flpte == (uint64_t)-1) {
> +            if (level == vtd_get_iova_level(s, ce, pasid)) {
> +                /* Invalid programming of context-entry */
> +                return -VTD_FR_CONTEXT_ENTRY_INV;
> +            } else {
> +                return -VTD_FR_PAGING_ENTRY_INV;
> +            }
> +        }
> +        if (!vtd_flpte_present(flpte)) {
> +            *reads = false;
> +            *writes = false;
> +            return -VTD_FR_PAGING_ENTRY_INV;
> +        }
> +        *reads = true;
> +        *writes = (*writes) && (flpte & VTD_FL_RW_MASK);
> +        if (is_write && !(flpte & VTD_FL_RW_MASK)) {
> +            return -VTD_FR_WRITE;
> +        }
> +        if (vtd_flpte_nonzero_rsvd(flpte, level)) {
> +            error_report_once("%s: detected flpte reserved non-zero "
> +                              "iova=0x%" PRIx64 ", level=0x%" PRIx32
> +                              "flpte=0x%" PRIx64 ", pasid=0x%" PRIX32 ")",
> +                              __func__, iova, level, flpte, pasid);
> +            return -VTD_FR_PAGING_ENTRY_RSVD;
> +        }
> +
> +        if (vtd_is_last_pte(flpte, level)) {
> +            *flptep = flpte;
> +            *flpte_level = level;
> +            return 0;
> +        }
> +
> +        addr = vtd_get_pte_addr(flpte, aw_bits);
> +        level--;
> +    }

we also need to do the below check like the SL path.

     /*
      * From VT-d spec 3.14: Untranslated requests and translation
      * requests that result in an address in the interrupt range will be
      * blocked with condition code LGN.4 or SGN.8.
      */

> +}
> +
>   static void vtd_report_fault(IntelIOMMUState *s,
>                                int err, bool is_fpd_set,
>                                uint16_t source_id,
> @@ -2010,8 +2128,13 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>           }
>       }
>   
> -    ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &pte, &level,
> -                               &reads, &writes, s->aw_bits, pasid);
> +    if (s->scalable_modern && s->root_scalable) {
> +        ret_fr = vtd_iova_to_flpte(s, &ce, addr, is_write, &pte, &level,
> +                                   &reads, &writes, s->aw_bits, pasid);
> +    } else {
> +        ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &pte, &level,
> +                                   &reads, &writes, s->aw_bits, pasid);
> +    }
>       if (ret_fr) {
>           vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
>                            addr, is_write, pasid != PCI_NO_PASID, pasid);
> @@ -4239,6 +4362,21 @@ static void vtd_init(IntelIOMMUState *s)
>       vtd_spte_rsvd_large[3] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits,
>                                                       x86_iommu->dt_supported);

VT-d spec has dropped TM since 3.2 (2020 Oct). May have a patch to drop it
in vIOMMU as well. :)

Change log in VT-d spec.

"
  Remove Transient Mapping (TM) field from second-level page-tables and 
treat the field
as Reserved(0).
"

>   
> +    /*
> +     * Rsvd field masks for fpte
> +     */
> +    vtd_fpte_rsvd[0] = ~0ULL;
> +    vtd_fpte_rsvd[1] = VTD_FPTE_PAGE_L1_RSVD_MASK(s->aw_bits);
> +    vtd_fpte_rsvd[2] = VTD_FPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
> +    vtd_fpte_rsvd[3] = VTD_FPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
> +    vtd_fpte_rsvd[4] = VTD_FPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
> +
> +    vtd_fpte_rsvd_large[0] = ~0ULL;
> +    vtd_fpte_rsvd_large[1] = ~0ULL;
> +    vtd_fpte_rsvd_large[2] = VTD_FPTE_PAGE_L2_FS2MP_RSVD_MASK(s->aw_bits);
> +    vtd_fpte_rsvd_large[3] = VTD_FPTE_PAGE_L3_FS1GP_RSVD_MASK(s->aw_bits);
> +    vtd_fpte_rsvd_large[4] = ~0ULL;
> +

this looks to be different with the SL large definitions. Is it necessary
to set the [0]/[1] and [4] as the large index should only be 2 or 3?
BTW. Before patch 16 of this series, it's unclear whether FS1GP is
supported or not, wondering if you want to add the 1G related definitions
togather with the FS1GP support in patch 16?

>       if (s->scalable_mode || s->snoop_control) {
>           vtd_spte_rsvd[1] &= ~VTD_SPTE_SNP;
>           vtd_spte_rsvd_large[2] &= ~VTD_SPTE_SNP;

-- 
Regards,
Yi Liu

