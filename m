Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDA7CA0FF2
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbNU-0007tI-El; Thu, 28 Aug 2025 08:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urbNS-0007rs-1y
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:05:14 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urbNO-0006HU-8h
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756382710; x=1787918710;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=f0JtJNCiu23D2gc1HjXQ+bNz4DLWzwSCovgup4ENt0U=;
 b=Bi7hJ33beqH+QNJYzcKnRwZ/o3kljPKSWWp2xZkungsfhyXXMIxPkXWn
 qR2LNLiU6oR4gsOQ5LppBK06GMOJWWY+YwBq04FpAWKwsL4A+NYGXZXOk
 QBsYAQv7m02qJS4NDRWqTuBzSjSTWu7tHOYDlscSrv5q6rHSS1zkeUJZ0
 cbTQIUiPGkDQA/himU+yRqESXQFoXjhGrOXdasUxTV+SAK2DiK3ZAtlkO
 mN0LjfYre4G+zaqPCLvMu7PMN9dolKawj+V9l/bRMgTHqMvvIHCLZjyph
 2BJfafdbc4Y1C+1JQbFgyr78AmePlPsC74f/vbPyTIf0MeAu9Wq3OWymN A==;
X-CSE-ConnectionGUID: DzOEuAj4RDiEcaRFdC7hkA==
X-CSE-MsgGUID: 5pzPS0R5SeKViaGdlWeY3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="58358591"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="58358591"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 05:05:02 -0700
X-CSE-ConnectionGUID: F1MLxWl8Temwr7n2NTjQ6A==
X-CSE-MsgGUID: 83jqxBb5TKurtAjDUgGhOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="169997187"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 05:05:02 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 05:05:01 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 05:05:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.76)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 05:05:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6kIUhvAZIPCoaCpidfmSoL/yTik/VcJjOPa8fyi4SKbEUQIVoz40uzamgZkECzKGobIG4nGINkNuxSbg5HuMkYd+ztu6Q2Mf+s/T4s26GA9LTiIG8nLswSAkJd894xWj8iKYSKL/7AlYUhQVEh/FiBbFfI3+0qyHI0NmaKm6xb9Poiu9Wk3JHs6e/LwG9e2Qa+I/UUyIGMRgaLq9RiCpMP+O/BsHo0F6L+hAWhou8Kd/H6ogiliZ8tYZ7z60YlUlsDvt25TFH0tK4Rdp7zt6ufB1gtrv65j+yDpdlZ8fg7c9wIIOT35aGH3VpJFtSETmWGswAGNqV5ZcxfeflhlDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHdmrw/OnXFqEXIpu+pFlOETxMDV9nsiso4dXYsN2HM=;
 b=Y6mUTs4UVCgL57upUUbXA35ekXzthg7TKuG///SbhfN6oYlPIiAhv6HOk/CvubGG42h3umKTddV9yoqXSTpp2nJGsIRZjBxto78vx4/ShYgYFnHjvL09l92TZEDjeceXgoT4hCW467XP1t6n3vGEb5SwKiTeX9GkbN/TdpHJlJnCqEXUyBpBlpikeMoGtFnx1yb0mZMEtrCi3urODUIqssot8a5lL6/Ml8xqNkDDEB+gH/2ESi1scVN0Q3K2oLzAdMIuMjZ+hpXYUsK48aBlzPcU21dLwG64/le6wObyjbEpepQoGvhk/j6FJ54iWimoNVjO7LXYjdQP/oieJaiEZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by SJ5PPF1A7C623DA.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::816) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 12:04:53 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 12:04:53 +0000
Message-ID: <4a03da89-512a-43c6-878d-435c1108e001@intel.com>
Date: Thu, 28 Aug 2025 20:11:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/21] intel_iommu: Propagate PASID-based iotlb
 invalidation to host
To: <eric.auger@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <mst@redhat.com>,
 <jasowang@redhat.com>, <peterx@redhat.com>, <ddutile@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-18-zhenzhong.duan@intel.com>
 <7d979fe7-95ba-4216-8cb9-05a047673e35@redhat.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <7d979fe7-95ba-4216-8cb9-05a047673e35@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9)
 To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|SJ5PPF1A7C623DA:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d60973c-73b8-49ab-252a-08dde62b18bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|42112799006; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGg2bFEzNnJMMDJJYktERnB3UHZyWm5nMEE2OU9RT0hGenlXRjlvb3ZPTUJh?=
 =?utf-8?B?YVBEdmZmbEk5S2cyNmVxWVphcHR2VklCZW9PQUhaZG9WOW9NUkRwVjJ4MnJD?=
 =?utf-8?B?RDBDazVxSTZ0RHh0d3dCVlhMWUU5M0V5bDM3enNPOGMrREQ5cEVsNUtVTWFo?=
 =?utf-8?B?b0VjaTVpQlBJZUlkSktMZDJBQ1pPZ0dhanBWQVE1RlhnUml0Y1NUcjFJSVJZ?=
 =?utf-8?B?enhWUkhzR0lkc3lmYUtoSStXVGgyTzVOT1NMU3ROTzNhYm5PN28vcXRuZUEv?=
 =?utf-8?B?dlNKcDZMdzU4dlYxRFJwR0ptNXptazd2MEQ4ZzRrejdkTzVZd1lDK3NUYVRH?=
 =?utf-8?B?Y0pzdndleSswbHY0VStseU9pRXR2MjJ0YkYvU0p1VHoya2phLzlKQUhkYlJx?=
 =?utf-8?B?WUFhTit1UGk4OWFBZHN1NC9GTUE0dEpPZXp1S1FPUzFoSVZRVlZYczNtOEg0?=
 =?utf-8?B?V3AzY3VieWVlNCthdFpBK1FFcW1KUjFOWWt1cW5BNW9XMVpPTFZqNG84YTRH?=
 =?utf-8?B?UFptdW5DdklsanFMNEI1cm4yZ3FpdHA0M3AzUGJ1ZkxPOWhJc29LQkNSdDdS?=
 =?utf-8?B?SGNMZ2FzNjh5ZVpEVGJjNkZKd25GZTJsWmcxcEhmWWx4c3liTUhkVFZuRjkw?=
 =?utf-8?B?MjZoQmdGYU8rbE45NTlyR0diSTY5d3hiYkR0d0JHNGd6M1JJcTlHbDZFdjZI?=
 =?utf-8?B?dzJWMkRHM2l6TTM0UlNNVGxldnVwN0REai9iYjFTUER2QVhVK2JZN05iY0Nn?=
 =?utf-8?B?aCtZVTdSVjNiRWNrQzFlN1VMc3dWSG1kUHNxRTR1RnEwK1E2TitVYUlxOWpB?=
 =?utf-8?B?NmJ2M2ZpUXdqOWZlbVZzM3hKOHRraFdiU1BPSURUczNzRnhEanY5NCsza1hw?=
 =?utf-8?B?L3NmTG9HdWlJWm85dW8xYjhxWVdtMUtsd2QyMFNtemFKYXpzM3ZhcXE4cnRB?=
 =?utf-8?B?ZlNWeU9VOUN2dTNjSy9OZ2lLLy9sVXJpeFBWWXBNTCszSWVVa3JhVk5rT2ZQ?=
 =?utf-8?B?bnNFc3MrandCZDVFbWQwVk8vOE5lQU9QdEh4eE52YnZpRE9zc1BWUVRHOElu?=
 =?utf-8?B?dmJRSHRVdXJMRmc0ZGQrZnl2cUkrYWRxUG9xYXhXK1VtVTFyRVhFYTFyTzMr?=
 =?utf-8?B?Z3BWcno0WU1zUDlHMGlMRUFtdm5NQmlhSUtUbnB6NXVHRlgwc1NRUWtqTTh6?=
 =?utf-8?B?Ly9JS21qbDZMUDI3UzJGMjlsOUZ1czlPakVMM0pXT3ZyT2t3eWJQV0VFL00r?=
 =?utf-8?B?YzRiMG01VG5TVW5xOGdrSTlQM0lubGJRZ2Ftc1VzczZjTisxM3hNU0NBN0N3?=
 =?utf-8?B?NGxoMExEU2pQZ2M4ZHcybjJQT1J1b2pudG1TaXlOMTVHUGJnTGNVNjZicG9I?=
 =?utf-8?B?Snl2cWtOaFhqMytob0Z0WnkwRG1UQWJjZUFBNnpIVW16aVBUQit0RndOaVJl?=
 =?utf-8?B?SjJTb1hRdG02T1NSTkp4K3J0VWFTRXdLRkRLSm53RjZUZUJHaU54KzJ3WTl0?=
 =?utf-8?B?VzdmVC9aZzZ2NmN0TGhrQklFdVJYd1V6T2pQVWhxRHNjYjdIYUVLM0pZSlI5?=
 =?utf-8?B?NlJydk1LRlpnZUx6WTllTmEzSk9jc3RUWktRZHpnN2RzMVhYUDZ3SVh5VEdn?=
 =?utf-8?B?N0hEOGFnamVGSUY0dFY3NUtnQ05QcVdMS1dJN2huZjJ4eENiRXNkSVFQU05Q?=
 =?utf-8?B?MHJoZWZoQzcvR3UyQlhwQUFqTFZQS2VjTTEyRmJIT2t2ZE9HYndPKzBwanBE?=
 =?utf-8?B?YUJmRkllc0xJWWJsUXNLcXFMWVhDZW5lQWg4MGtGNS8vMmZWK09lZHlsRisw?=
 =?utf-8?B?MzFnUUNRVU5lTzZ5YllEN3RMR1o2TVpCbStMa3czWVR3OGg3R1ZvT3RqTkhz?=
 =?utf-8?B?Ty95b21sU3RjQVNWNFlKUnJSVGVSdktKaE92Q29lR2NxYlM3b3RwSXpobU5K?=
 =?utf-8?Q?A8VlG5IvDTs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(42112799006); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm5nSWZ6OUFzSnV1d0hGemxvRDlTRmtvakxvQWluNVNkQXJXViszSmdNSlVE?=
 =?utf-8?B?UEgwQVBTT0hoYVEySWk3c1ZkVXE1amR5TU1helhpZ29LeGdERmkxWFBwTkdx?=
 =?utf-8?B?Y0FWZVA4dWFRV0EzSWJGMWhZcVhRRzBDdEM2Umk2V0d4bFJ4YnpyMDhzZkl1?=
 =?utf-8?B?dkRobXAyZjlpQmZIYnFiRmNjQUlLdEtCbkNDWnQ5bnBFSXcrcTBXTjN0WnJu?=
 =?utf-8?B?WVV3cnc1bTZjQXM0dmlNeUxBNzR0REJUeGc5eElmRFN3aitpdDUxVTRnckVP?=
 =?utf-8?B?SHFmZ2kvcndZMHltY3RxU09UWHJyZVRFSDVYV0Ftci9kdG1lMEt5UWQrSnBq?=
 =?utf-8?B?NEZhdk1XMUlUOFRaTnV6TXZSbHNhSkg5UG0zbmdXcit6cVQ4M0NybnA2czBW?=
 =?utf-8?B?Qy9tOHdWM3AxQk9MSUU1bVovc2cvdXRxdkV1QUFGT1Vvc05tUHF1OWJjUEFa?=
 =?utf-8?B?cEZKbUgwanJmQ1Rzd0xSakRZQVJ6eWdaMVlDNytPblE4dyt4cXBXbnNRNUt0?=
 =?utf-8?B?Z3k0MFp2aWJhOGorU2M3RnczZEVDSGRTQUE0dTIyTlVyY3lXNTRKMmQ1UG5x?=
 =?utf-8?B?UW9YcTNNY2t0MDF0Sld6WEZwUEtkWGRDbDBobDkyYy94WTN3RkVGZ0V6dEJO?=
 =?utf-8?B?ckF6eE5yWnNncEhodHBXeVU2eC8rV2J2MmIzSTd6U0hwS3puQUVpR1NBUjdW?=
 =?utf-8?B?VDhEbnpKWUdldnZFaUhRZ2UreXN3eFFURDVZUWtmQ0VybFdaUGtuaGxNOCtl?=
 =?utf-8?B?SVFBaFVGMkxvaEVzV0t5OVAvdnRURXBMYWsvZ1dOVndCaXpkZ2QxaktJN1I2?=
 =?utf-8?B?dHJvMjZwOFNCUzlGWFZyTnNqdWs4Vlp6eDc1RlhBWEVhZk5ZaVBLYS82NDMy?=
 =?utf-8?B?UjhqVUIyL2RDNmFmTUROb2d3UzhLczh0WWRFN0NuZUc2dHZKT1hDRnlBRmdr?=
 =?utf-8?B?MmdKc2lBNU8rdkh0aUVJRW1MbEJzR3BiaGlzOXJpT1RKZ2QrOWhsMjJqWEY0?=
 =?utf-8?B?NzJoeFVQNkt0TU8zb2JUVkFvb0RtWU9tWmxKZWgveXB3SjZBczdLYWdNVkNX?=
 =?utf-8?B?NGZuUnhPc3FLRDNNNVN4RkJmbE5BVjNhQVphaTJDckN6c3gwanpRVWM5ZU5i?=
 =?utf-8?B?bjAxOG1hcWpVUTZUNW96RmYrUkpDMHJtK2RTNVM1eVdON3YvNEJQODhqSWZZ?=
 =?utf-8?B?Mm1TaWlUOEE5a2MrVWJxMnhaRDdlUUZzelMxVHJDTHN3TjNzVkpLdmRhR0tz?=
 =?utf-8?B?Vms2dWJwQ1BaTG43cTZidVhyeTEwSTl2NW5aUjEvU29QVVFoRkNmRitCNzV6?=
 =?utf-8?B?SStndFhXejY4cFA1di9KTWFuWVlGYjFNOWNNRUExSHR4cG9PY2ZIZGdrajI1?=
 =?utf-8?B?cmJFRGlsc2NKSWtxNjl5WWxXUTAzekR1bUEveUVydUZ0cnhKZ0tIRE1NY3pI?=
 =?utf-8?B?RTkxMXRrK2xhekxHLzNhdE9iQTI2ZTFFeU4yM3VXT3dmZktDT28rRW85Q0FV?=
 =?utf-8?B?Z0hHcEdBdDNKWVIzb2UxdDBSUDJkZnY1N3RMK2FIYTlubTIyejJnSzExdjk4?=
 =?utf-8?B?cGpGNEF4c2hkR0lmTlZOVjNsemVmRkhQNlVtS25pdXQyZEczUjN0VWE1THZh?=
 =?utf-8?B?UmtPWjVVRTUrU09KV01pMDg4eStJc21hUldqVW1mQ25WYlc5OEFhMG9kall6?=
 =?utf-8?B?QVFqRkl5TTFQamxtRE5VejZWdWtTN2VWb3B0dzVrcHV6aDA4aDJEdkdpOUxV?=
 =?utf-8?B?UlordWVRME95WEV5aStMbFFubUU3SU1DRTBHeUtta0VwdUpTTmU4enhwVFVB?=
 =?utf-8?B?Yng1Rk9aQzVpQUxsbFVvQytmL0Z2dFQ3Q1FpdmlWSm5td0N5QTdrampZTWdJ?=
 =?utf-8?B?YVloYWl3QmxLdEZiVmdwRGhIY3VROWFDckNUT2QyYXQ0eER1TzBrSzdvWkVK?=
 =?utf-8?B?akFJTlFhN0wxaWVWWnZkNzBiYmU5UUlobktsRnJHZnVXRVNaYzFnL2VYbXNG?=
 =?utf-8?B?NWo5Nkt1dGp4bjV6dGo1U1duV2NGOEExNUw5cFBSSEtYWUNXTXJMajdNUUVx?=
 =?utf-8?B?ZlhjSG1INVY4RkUxWjFhdjh0UlBOUDFXRlFab0pjemV5bmY5Mk1qNEM1NXc4?=
 =?utf-8?Q?dZLumek97/As0J7U8uazopIJR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d60973c-73b8-49ab-252a-08dde62b18bd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 12:04:53.2498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFDDMzD0uVQC28YNJxh5iloO3+o0YdGSZucGs9p8iDlL4RyqkPv4/lkmrpShyai2ld/U0EWz+KQnP/1jF8gd1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1A7C623DA
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20; envelope-from=yi.l.liu@intel.com;
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

On 2025/8/28 18:00, Eric Auger wrote:
> 
> 
> On 8/22/25 8:40 AM, Zhenzhong Duan wrote:
>> From: Yi Liu <yi.l.liu@intel.com>
>>
>> This traps the guest PASID-based iotlb invalidation request and propagate it
>> to host.
>>
>> Intel VT-d 3.0 supports nested translation in PASID granularity. Guest SVA
>> support could be implemented by configuring nested translation on specific
>> pasid. This is also known as dual stage DMA translation.
>>
>> Under such configuration, guest owns the GVA->GPA translation which is
>> configured as stage-1 page table on host side for a specific pasid, and host
>> owns GPA->HPA translation. As guest owns stage-1 translation table, piotlb
>> invalidation should be propagated to host since host IOMMU will cache first
>> level page table related mappings during DMA address translation.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   hw/i386/intel_iommu_internal.h |  6 +++
>>   hw/i386/intel_iommu.c          | 95 +++++++++++++++++++++++++++++++++-
>>   2 files changed, 99 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
>> index 8af1004888..c1a9263651 100644
>> --- a/hw/i386/intel_iommu_internal.h
>> +++ b/hw/i386/intel_iommu_internal.h
>> @@ -596,6 +596,12 @@ typedef struct VTDPASIDCacheInfo {
>>       uint16_t devfn;
>>   } VTDPASIDCacheInfo;
>>   
>> +typedef struct VTDPIOTLBInvInfo {
>> +    uint16_t domain_id;
>> +    uint32_t pasid;
>> +    struct iommu_hwpt_vtd_s1_invalidate *inv_data;
>> +} VTDPIOTLBInvInfo;
>> +
>>   /* PASID Table Related Definitions */
>>   #define VTD_PASID_DIR_BASE_ADDR_MASK  (~0xfffULL)
>>   #define VTD_PASID_TABLE_BASE_ADDR_MASK (~0xfffULL)
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index 6c0e502d1c..7efa22f4ec 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -2611,12 +2611,99 @@ static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, VTDPASIDOp op,
>>   
>>       return ret;
>>   }
>> +
>> +static void
>> +vtd_invalidate_piotlb_locked(VTDAddressSpace *vtd_as,
>> +                             struct iommu_hwpt_vtd_s1_invalidate *cache)
>> +{
>> +    IntelIOMMUState *s = vtd_as->iommu_state;
>> +    VTDHostIOMMUDevice *vtd_hiod = vtd_find_hiod_iommufd(s, vtd_as);
>> +    HostIOMMUDeviceIOMMUFD *idev;
>> +    uint32_t entry_num = 1; /* Only implement one request for simplicity */
> can you remind me what it is used for. What 1?

the iommufd cache invalidation interface supports passing an array
of invalidation requests. For simplicity, we start with 1.

Regards,
Yi Liu

