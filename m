Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50C6C30653
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 03:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPZG6-0001SP-Tp; Thu, 04 Jul 2024 23:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sPZG4-0001Ry-6D
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 23:05:12 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sPZFs-0000mA-4J
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 23:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720148700; x=1751684700;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jZjgtnyI2oER8tehobNyi9Rw3l4c/5JtHRgJgr7S0Dc=;
 b=lr9JhXLPGAy5CauDNlxT/bCJk2q8uT9r0RwT4rEyLkl+HUpHbAB8VGxx
 9soSzGrp5ZXkgE6JRey2csWb4mUAivYQKwJ2BR/ThbM6MSzlXOhUOC+CD
 k8v6eSKAsL51/vdi7zzhEkHkm5jTlDdkrfOxgs2x3FdgBV2Mz6CZvCy20
 vgZUR5VWkKIXF6Xwe9FjkEMiHIIM7ky6kQysVG6lTNdC9d4FYhKLqsAhY
 xtPS7SzwkXyggYXqEQ277EtxSSBVe26d8Vnqrgo+ROOrjMTCJnp+EVXnC
 Tmad2ozq4sXjBWlzUe0gfcngakH3c3ItJsDgMZNX1SupshDftG4DM9epk Q==;
X-CSE-ConnectionGUID: 7sZjt6nVRf2KqaokygDXpg==
X-CSE-MsgGUID: 6qOx4ieRTqq0qSl24fWSuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="21299103"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="21299103"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 20:04:58 -0700
X-CSE-ConnectionGUID: 0YkenhjnT/aN8AiJ0QYkaQ==
X-CSE-MsgGUID: KykI1/uZSMS9MsWLqCRbhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="51079889"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Jul 2024 20:04:58 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 20:04:57 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 20:04:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 4 Jul 2024 20:04:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 20:04:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvzNH+hRJEzZbWXtKM0OEF3hzb3izdOpvOdUPWhdJdxdHLbUGX1hTnjZYwEimwWObaltmAQu6w/lyCEDx+pwSL+OG8v7lVDphNZ1s81czi/qVznsOJRCRbTV9feYoHM2kXthwz+P1P61g/vCT3C9JDU0w2Qefe2tzYK6BuEF1QA+v3l1n1H5VfmqPQRtUbAwsRTh5R79N2buHuRweAlF2UYiFCgA75pUvOeg12pk5dO7FUzCJOgA1E0nUf6GY8cjhMP1R1S4yVfmFJ2Urp7uocPwavRve5AJ46S5bRQpJ1XVlkzQqPEFcsrDdsqzwWfGru2nx/YceF07TqxcRkP8TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/YIWrfq04Que61WgFFvIcENFNT4jG6QH4auj9okFrI=;
 b=gRb+cFKb8tawFFRqkImkFCrWasz3rHjYQpURAe9AoWFcPpDWg597UvTgCjxmt9Kp4I9E2VaXJ0RcAxthM4to/pNEng6u0R8YKaawhc9hHTCUXFP4E8/sEPSs0ehjIXJngMjoTWz3GILI6ZXV1ThfCvN4wj/xwk5R6bHr6tKu0dZaE3+bDYliNVmTYD1ngl9gdg0kJIBaVqhIfqDxBya+a3AS02fPeNHY8Zn4NK+uOe3Mc9jU9oai9hyDXJiYH3MFbcZEDX4HmymqqOya6sarBprmqEB4a2iWqYS3Rz4lg43qscKxzzeROGU0nmwayuKzI9uu2LzlpxR1JyX7cVbLHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW3PR11MB4732.namprd11.prod.outlook.com (2603:10b6:303:2c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.39; Fri, 5 Jul
 2024 03:04:55 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7741.029; Fri, 5 Jul 2024
 03:04:55 +0000
Message-ID: <5a667dc6-b77b-4a2b-8871-b5e1160f25e3@intel.com>
Date: Fri, 5 Jul 2024 11:08:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] intel_iommu: fix FRCD construction macro.
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
References: <20240704151220.1018104-1-clement.mathieu--drif@eviden.com>
 <20240704151220.1018104-2-clement.mathieu--drif@eviden.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240704151220.1018104-2-clement.mathieu--drif@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW3PR11MB4732:EE_
X-MS-Office365-Filtering-Correlation-Id: 1698489f-4dfa-485e-5457-08dc9c9f3ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXZ4VklaL2hPMThGbENZZzZSNG9oRnJJUlhacHdXQzZHZ3dpR1kycmZFOVZR?=
 =?utf-8?B?Lys3T3BSc25xdjVwamlVc3V0QzBHbnU1Wm04aGIrZG9UdkNCZTRsVHE0SDJq?=
 =?utf-8?B?UE5DSGxOb3lJeCtuN1F0UUkzdzRCMW96a0MwQzdBUkh4WndyYWxYbG54U3JU?=
 =?utf-8?B?dDBMcGhsWmw0UmViRStHUEZQWTF1WmpRNnNrWU94dXZYdmJjTUZaWDY0bmd2?=
 =?utf-8?B?VVhZbGF3TEgwc0JYWE5naGZFa0crQzFPQVFwVEFGMm92dDlmUVhTSzZNb1Zn?=
 =?utf-8?B?ZXJLSjUyN3ErTEtsVWYzT091djA5T1VRaWlvYmtnZ0tRY1gwQUF5ZDVmS0Fu?=
 =?utf-8?B?YVZWWnplNFAyTG42SUVpek9iOGU2SkhlU1Q3ZXhia2FLeHFmTVYvSFRKUFdx?=
 =?utf-8?B?eVp1QTk1M0RqWmswVjloTnpjSGhaMEpDZGdkVHQxUmRWeW50bWgrV1RkRzJ4?=
 =?utf-8?B?NVFkQmFlRUtRZXRuNTBxNitKamZNSG9SaDVqZFBwMUlMLytoOE11K04zSlVD?=
 =?utf-8?B?RlZmb2F2V1JqRnBjMk9vUXFuZkFxL3FQS0c0bk95Q2h1akROam5UK2h5Q0FX?=
 =?utf-8?B?R0Q5WlpOUzRyWDZNU3NtMHdXMXdIMG9yUE5pa0JGV3RMZVBGSDFxeThNa0I2?=
 =?utf-8?B?YWxXMEoxSEIrNmNGT2gvWS85djRUWUlQS1liNWJwdVVOQ211MkREZ0V1RVd3?=
 =?utf-8?B?YVNjQ094L3dITG5DeWRtT3p5OTduRXNsYWpYU2NNK0k0OGVrWDZWcXk2YWQ5?=
 =?utf-8?B?c096bXpQeHJ5ZkszTnVkNHVPU3R2ZUhNTjIvM0FOcDhid21CVEZvaWt3c2VI?=
 =?utf-8?B?Yzg0MW5yMXpJTGFWbTM2dVNRUjh5YkY4WHhGUkVkRXcrYUQvSSswa2JTWkdO?=
 =?utf-8?B?TlJlL0pkOHNBQ0M0YkNacklza1FzZ3ZDdlI3a3Z5Wm8xVGVRMDhCMUZhc1hW?=
 =?utf-8?B?VU5qMHZ6aGM1ZE0wQnBhRnFDYWZUWkdlUlhNUFI1NnRIejY1RHcrRGY1S1Ny?=
 =?utf-8?B?NjdFREYrQjZBeXhNaDJ6TS9UWVFkdFFOOWVzWEZObFcwUEFwNjhsbEcyWW9U?=
 =?utf-8?B?TVZWSkJkMmQ0ZDZaTmVBWmhFSjdHYjZ4RWEyVmkwck5DeS82OXhVcDh2amxP?=
 =?utf-8?B?ZjVXaG9rNFpLamZBaDlZdG44QUlZYXNsb0ZudE9UNmN3THoxaVRrWkZCTmQ1?=
 =?utf-8?B?NXFNTmxSemZPR2JEQ0xpODF5N2R6bnVNaEpDKzRGcVI2ZW5uVkVScEc0TEVC?=
 =?utf-8?B?WUhwU3VhditNVnBWUTRFY2oxMjIyU0NrQWRoZmY2QmpuR3V3dklEWi9UWW9t?=
 =?utf-8?B?THRFZkFYMHlLRlhLa1oyRDVuY3dVbGNZS0pUMmhMcTNDZzQ1bmFVaXVGUy9Q?=
 =?utf-8?B?N1dDdVlPQWdqK01xR1A2b051aGxSUURaMHhBSXhOdXAyeHhOMS9ySzk1Uzg0?=
 =?utf-8?B?ZE5LLzRacXJBUHp3TkFFTU1lTmJEbDI0eHozcUsybUM4empOOXVZUWwzRDZT?=
 =?utf-8?B?dW5LNnZ2RVl4UTc0Ym5sS1JHQzE4T1haWkdLVUw5TzdzUGVwNnBKaThVb1lv?=
 =?utf-8?B?cjNjUENBR2NUYnJhRWpqL0h5WUVRbHNXdmpyK0ZTM0hNOUYrZzkwakREalVL?=
 =?utf-8?B?eDB5dXVBTzRkUXJXUFBVSlBQaGJBcjZnT2JiY1lVOXNJT0ZOclNzTVJoR3k3?=
 =?utf-8?B?RDhTNzJHQzNJUGFBK0MvNENaaU8xMTg1cnZLVXFwZDFzVDZYSkpnNHNZYmYy?=
 =?utf-8?B?TkhGSXFrV1NqQnYzdi82Y1JOVEM0TnRHNGw2aGNZMjh0cjZIZWtwTDE0L2VS?=
 =?utf-8?B?N0ZuQVNKRE9uazMyaThIZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGR4NzhxcUlVU1RxbExpQ0ZiRmswZC9wWmxEdmZ4NEloVjZDUTFZRitQWGt4?=
 =?utf-8?B?dFZRd2gwaDVmejJKLy9MZlZGc0tNVFRYcGI0MU5tN1hlTUo4UktEM2Y4bzZN?=
 =?utf-8?B?NHhnT0NmRTdYL0JnOGtOZVlXV0FJUHUxend3eC9RdDVEQzZwTDhwVWVJUVNO?=
 =?utf-8?B?SEh1U1VIb045QzBpcTRBeEMvTDFxSWVWUG1Xa09EdU1VaU81QklMemdHdkdU?=
 =?utf-8?B?Vi9jK3N2Z2E4TlhPSlFod3ZiS0N4Y2pnb0tNSUpIdWF0d2QyWHgySjl6eVhj?=
 =?utf-8?B?Q3h2Wmc1YlRFNmtLRkc3QUdhRHc0L1I2UFZLWUJDMFlqRHpkYldVWkRUazRN?=
 =?utf-8?B?TS92S1FGNDJTVk1KYkxJYUc3dzZ4V09SbEVXSExkVkVhQzNmcVZ1Nmpmd2l3?=
 =?utf-8?B?aHhWbW54T2ZOMExTcm5oRjhiMWJySFZUbm1TYlloUVlyMXZKaW5TNHR1Ungz?=
 =?utf-8?B?QzA5VkdMOUV5YUJkekl6NlI1L1dXYVFnZ25GdE9ESkc0bm53emtTTEN2YWxq?=
 =?utf-8?B?b09DVjludFRHU2pIa0hNakVFNVBnSHNlb1E3R2NVc3JqMXkyT3lkUHdnc3Ux?=
 =?utf-8?B?dFRtZlhjc2U5Slp6bUdtRmxOWC9tMlNLdWFpWG1vZVRRNFJSdUp3RHNGVnAv?=
 =?utf-8?B?VjNnV21CNjQwSS9LOGphQ3V5TndWWTlzZkwvM2xPNFlHQUVNRzNGNzJkUG80?=
 =?utf-8?B?d2gwckRGWFNlcnJIaWFicDNQMnE4dlJLOHlrVitnTlVmRDFIVmtvWkFvbEVQ?=
 =?utf-8?B?alNzWHNWNzIxajhlVy9iemJZbnkyZjdQUyswNDU2OVRIOVBDN0orblhHbm8x?=
 =?utf-8?B?WUJ3OUpuRVV5MnlPa1FpakhVeUt3SG9iUklYQ3Qrc2tDd3Nabk5Rc21za1kr?=
 =?utf-8?B?M0xVR21qeVJIRXY3aDBVZG1hNHEycng4OGlGZHowbzdPT2ZNVzByYktOSncz?=
 =?utf-8?B?OFhLQWMxLzc5MDF0T2dQWCtuVUNFTStpQm54Y3huVXpwRGQzNG0wZmlpdGpI?=
 =?utf-8?B?d0p4ZTV5Mlp2S1lsK3hSR05YajZyZ0lZTE9LaW0yZzd1Y2hVSWluRExrczRS?=
 =?utf-8?B?YzlNQnp1WlJydHdpejFScjZNd2NnR2xWQVlLQjdUTDRWclBFUENwK3lpU05V?=
 =?utf-8?B?N1NNelliQkF3WjdvNm1FcG55Y1FHT2ExWWpFRkxhVUFCN0FaQkJHZ05jSFN5?=
 =?utf-8?B?a295ZFljdTVOL2JRVmtlVW1ZeDJLUXRPRTQvTVV0T2NTTURjaXArcndscVJG?=
 =?utf-8?B?WWl0VDFaTlNDVHB6dkQ4LzFoMWhnTG01TDdaek5tVE9hd0xncTFOR0hYbUlO?=
 =?utf-8?B?UEVkRFYrOFpFd1p4YkVkQUFmKzBVZXVlNENFQi83S0ZvNzgyLzFaSVB2bkF2?=
 =?utf-8?B?aGEvZEJNTHB3d054bjh6K2plSzIvbk9reExWLzYxQ2c4SytNU25aNWxMSG11?=
 =?utf-8?B?T3prNU1hQUQwclNENElhZmZnVlVmQVZsMXdJWVpReSt1aFcrdk96ZEFvcTZR?=
 =?utf-8?B?K1h1Sk92NWRzbjRGNG1sVkF3K05UeWY2MmN1aWRCVHVmeVNWRFFHeW5WbnJm?=
 =?utf-8?B?aEhmYldReWdGcjdnS2RBSEFGZlkvRnZYZ1oxaGZINGRVb21PRzNCWDI3dTJk?=
 =?utf-8?B?MzZxTG9KTWlXVXpTU2tOUHdEU2lVdldlazdFOGZzUkhBcjJ5U0NvNXBLcXBJ?=
 =?utf-8?B?OTRqRWJLeWc0K3NueWRPVy9PVmh0OGpzeHllbWt1dFpLYm80QW9NaEFFaXla?=
 =?utf-8?B?TTZPZGVGZFRubThLcUZEL1hXU2p1MUdhMG5XZ0xkeC95cDNtMHVZWjZ2LzVZ?=
 =?utf-8?B?TEN4Y1Y5d2MycjQzM1M4WGJHa1hLT1pPOExiVnFGRExrNWorbkZOWEJQWjFm?=
 =?utf-8?B?Q2cxZmkxZTFISVI1RTU2VUtXcXRvcFZ5ZDAyekkxSm5GSlN1R3JTbkZ2bFkx?=
 =?utf-8?B?TVkwZkljY09hU1pvWG1UR3hLV29nUXFqUUZwM2RrTEdHUlBDNnRNL0pZYWxa?=
 =?utf-8?B?MURCaUM5ZDRQLzAyQjJ2U2xxcEo2bE9JVHBFRm12bkU1amN4SlVDNWlxSmlH?=
 =?utf-8?B?bTdnSUhuUWtCYmFraWtZK2lhZ2t4eFk0WHdkdVFMcTNOcERNdEQ2ajJJZjZx?=
 =?utf-8?Q?1bddj2CgCZwLmmRrRoZ9ZDyjV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1698489f-4dfa-485e-5457-08dc9c9f3ed4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 03:04:55.0462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hItyAdymyeiJZGFIAXQCeC+ExKRkzzwB/IB3PG6VEHaZ2rjX9zVSjTjJQT83lnfgcBGp+Eo7A/w4AdFmeQLsrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4732
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 2024/7/4 23:12, CLEMENT MATHIEU--DRIF wrote:
> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> The constant must be unsigned, otherwise the two's complement
> overrides the other fields when a PASID is present

I'm not native speaker. But it's better to see a "." in the end
of the sentence. :)

> 
> Fixes: 1b2b12376c ("intel-iommu: PASID support")

you need more digits per the result of "grep Fixes 
docs/devel/submitting-a-patch.rst".

docs/devel/submitting-a-patch.rst:add an additional line with "Fixes: 
<at-least-12-digits-of-SHA-commit-id>

> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   hw/i386/intel_iommu_internal.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index f8cf99bddf..cbc4030031 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -267,7 +267,7 @@
>   /* For the low 64-bit of 128-bit */
>   #define VTD_FRCD_FI(val)        ((val) & ~0xfffULL)
>   #define VTD_FRCD_PV(val)        (((val) & 0xffffULL) << 40)
> -#define VTD_FRCD_PP(val)        (((val) & 0x1) << 31)
> +#define VTD_FRCD_PP(val)        (((val) & 0x1ULL) << 31)
>   #define VTD_FRCD_IR_IDX(val)    (((val) & 0xffffULL) << 48)
>   
>   /* DMA Remapping Fault Conditions */

-- 
Regards,
Yi Liu

