Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681E9CCF9E9
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 09:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stkl3-000673-Jy; Thu, 26 Sep 2024 05:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1stkkz-00064i-UM
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 05:25:54 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1stkkx-0001XE-Bu
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 05:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727342751; x=1758878751;
 h=message-id:date:subject:from:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=roFRoDLMsl/gO1NXRfu9vt6P8IwmdVVwyLNZbD3sqJ0=;
 b=JOyPgatAk1nUwucLY6D3x/odmbglvZ44LOJ5MhvjxW0TTNPp5kyFCt4T
 o1hrcZi2vVWhmNy+Isfmx2ylkzvFIeyeLRmVq1XM8l6oVkPyBoSiTN6xj
 Hj2HpjTvpXu7SVhYLQoI8TgzckWvqNOa+W1JXFRGiFtelc9GcmH1B1elj
 qwMmK5b2AFt9uM6R/A0PWZtrNowAFS/viWAa54UMjhkg2m22ZHuYp4IWk
 Virzzad21M0hB9xksfye9ycPhccn1iP9Q9VUTGK+1E03YbnjGs+9vTKOl
 6iM8WeRqKPe9NVRcKtooJtej1h1n3+lWdIqKl1PbUq8HpUmXFOLydmv9P g==;
X-CSE-ConnectionGUID: BtZJT5iUShGx0b7BVY9VZQ==
X-CSE-MsgGUID: 7uL6goaCS/CAl3IGJGcoVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26521079"
X-IronPort-AV: E=Sophos;i="6.10,260,1719903600"; d="scan'208";a="26521079"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2024 02:25:48 -0700
X-CSE-ConnectionGUID: exjL7otvQ82wHbimcRrgrA==
X-CSE-MsgGUID: EeRsHhY3THCKQ054zycIpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,260,1719903600"; d="scan'208";a="102854140"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Sep 2024 02:25:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 02:25:47 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 02:25:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 02:25:46 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 02:25:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTGEUgjxcZeQKfuKLEOb/5b5390UcsIKDIytaStugLT6Wm3cKBmQ1Jl4i/eU9vWNNFmFSmAqN6wKYwmnAeKjuV+51Agwj/T5iRUTqp8MzMoGZke3OaHW24VkGm5eExn8Oz0MtyPhsV7xma4z3EokhjdB6PekTvtUYwKjgLE+Ply5yL0vaR+uuBwuM41gwwebswjqbhSzSJhBpaKHsdQQhx064t2qM7oaz9+DkerVd0OsEnyEXeiroSiTbUT2sl02iWGQ9+W7WhgrWqZbsyJuP9rFdQ4r5a7bbM3+OyKQhrbxpl8O6vrKKkcBNIDOJxOr6kG569hoe3AjFvlAMoThLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnERINRhlw+duqz+NjWitfbTD61SHKSvVGMrbT4LrOI=;
 b=pR6ud6W1KR6nuodR6koAb0mscJ4E1wPS3kVctW5UktK5IzgkRP6K7KllsSDw5byGfxWYz1RzfXIHFN6mkfdH7vKUPFC3Y0fSjMAuZLpogYpfO160tSxTEGksL5Aw2FTCc5/hQCpBUZy5xNG+c4kcycDPljHQi1lvbk31JK1fqTjHS3WSagOEcVRV5WQ65xr8jUSGRhlaLKHHbABb+pmhEh8nfDRWAYGyp+TxPCbjDLtXvmOXSPpkwrhNwcJKrM6cSsJqVMrsW/GaALb3YcKEOxPdNno6wp0Y4xAY2JTIFwE0QXta6iUqrv3cqGkGoKxzFKBtopPoW+PppS0mLF0NVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MW4PR11MB7079.namprd11.prod.outlook.com (2603:10b6:303:22b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 09:25:44 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 09:25:44 +0000
Message-ID: <8627040a-69cb-0d07-5010-58eaf348cb5d@intel.com>
Date: Thu, 26 Sep 2024 17:25:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 00/17] intel_iommu: Enable stage-1 translation for
 emulated device
Content-Language: en-US
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <yi.l.liu@intel.com>, <chao.p.peng@intel.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
In-Reply-To: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To SJ0PR11MB6744.namprd11.prod.outlook.com
 (2603:10b6:a03:47d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB6744:EE_|MW4PR11MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: 77764f8e-688c-4cb5-55ea-08dcde0d3295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZzluL0VxU3RHRWRQbEhHMmlFWXVldko3RHlKUnhmR3BHR0srSkpDaVphcXBa?=
 =?utf-8?B?UEZqRkJuV3poa3dMMytyOUxURS9QYk9Pa3pjaXJNUkdOQUNhUTFDREE2UjQx?=
 =?utf-8?B?NmMyVlVUaUdoNis2SlQyWU9JK0V2S0NvMENEdnlXQkp6VHhnSzJoYXdCRklD?=
 =?utf-8?B?WVlpQngrV0YrQ3llVVc0SzBVSHZ5dHBEL044eXY1WWYveExVWmd1OHBvYWdi?=
 =?utf-8?B?N0g2bC9pWEFVNmJ0QnpETHYyVzNac01SUTRVRDR3Q3YzWDZhSFNyVkswNmJ5?=
 =?utf-8?B?ZlVTNGVUTkY1UldjN053a20vQ0lrdnpGSG9HZC9wemFSQzBtcmkxbm03RDdP?=
 =?utf-8?B?ODFwTnVWQjY0ZGdlS3RqTDBsSHRwVCthcmhjVkthQzRQNUVKbklOVkU3NWpI?=
 =?utf-8?B?WVlJRS9uRWxnWFBQZmt4TzFIMHN0NlYwRkpRdU5BSzNSQmlqSzRINGZoNldx?=
 =?utf-8?B?aUFNNUF0K05UK1l4aHZIZGtpdTB2dlBWcE1uMDRxM3N0SFd3bUJqOEh2WThT?=
 =?utf-8?B?UTM5c2lYeks5QWxoOW1TaUg4bXhZRkNQUUJVZnhxbGpXakZaaHBLbWtuT0tl?=
 =?utf-8?B?RitlVFlUaWRaVGxLZUFlR2xJSG9QQmN1WVJ6ZG1qcE9NaHR6WWJWRlR4SDRJ?=
 =?utf-8?B?Vm5JUlFnSEZzOGUrWHBCKzBnRHlLeHg5Y1RhTFJkaFlhRW5CTTJhSnE3M2pF?=
 =?utf-8?B?ZklYaEtSK0JMVDRJT1RKc004Q0FyWktlSjFwNUl2NThJZ21wWFJUVGdwMXdZ?=
 =?utf-8?B?ci9OSG83dExNM0RHOFVMSjIzbi9ONGFFa1o4WGthS2hxZ01QNWFKYWZ6SDY3?=
 =?utf-8?B?dnRFclFXTnpuY2ZYOWthbnNaTzQ0V3dvRmk0eHZUdnBZMFBIbGsxWW8wMjdm?=
 =?utf-8?B?UG9PS0xzeWF6WG5lcnRlNFJ3cDMxZVlRQXJJaTlrWUV3MXZCV2FmTmFCZE83?=
 =?utf-8?B?RnVsNjJkSGJRYWg0WkVFMGRKZ3J5T1VlRWZMT3k3M1BDQVRGczJPR3ZHS2FV?=
 =?utf-8?B?Z0lxZ3JRcDY3S3k2UThMS2Q1c3FvOVZ0NHdSSWJ3L0QvaHpBN2RBaGtUa2hT?=
 =?utf-8?B?VFZmYWVtR3JHNGZwM2FpeXFVNG9BN2pqbzB6Y05Cd0UwZzZ6Znc4N0orK0dn?=
 =?utf-8?B?K0JSaHhqcGM5d295ZEV1T1FYeHl3dHk5dmdIREczMDArT2tGWThUMTBHZTl6?=
 =?utf-8?B?eE5zaCtxZE5iUk5ZRUhNSnhHQytUZGZ2b0hxSHdHR0p3bGZkNjRPRlgrblhi?=
 =?utf-8?B?d0dHOGYvd2VDOGdRdkdQVjhWRGlkVDROaVArWjBtR2hLQzNCNzhxSFMrOGts?=
 =?utf-8?B?VUpCLyt5b1o4eWl1Tm9uRld4ckFETGVnL2gwMVgrUDZ2d21JV1NCU3VUbUlr?=
 =?utf-8?B?dlVlZEpnMGJUbGlJV1JRQi93UDNIZHZtVnBYcEl0dms5a21SZHB2QVUranBV?=
 =?utf-8?B?d3FvUmNIcXJ1a1I5Y3F0bVJqRko1ZE80TUplR1hjU2ljVWp4b2NkSllYaEFG?=
 =?utf-8?B?RjIvdkltSUJPOTdsZS9nWDNFTDloNlhlbVhPTTMzUnBGenZqRVNqZk1JWURz?=
 =?utf-8?B?dlUvd3ZlVExwMmpXUFRDMkNwLzYvaDlJODY4ZXg0dHRpUXNVQmJ0UVpyWVMz?=
 =?utf-8?B?YytwUFh6NE5VanBiK01keEJBdmk3bFVPeHkyUFg1bjhVdlRuMytCMy9wWG9Z?=
 =?utf-8?B?a04wcHNKYVArNisrNzhkRFVPRU9ac1NUdWdod1MzUzBIb2VBN1cxbEQ4dmc4?=
 =?utf-8?Q?/OWPYorlM/OYxTe094=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTJyWEsxQ1dYc1lzZFFCMU5FSFpKUk1rbG5Ua3FKNXpNb3BZVVFSdk5kM2ln?=
 =?utf-8?B?eUU2bVZkM3pxWkhaZ0dwRlJLd0t0Wjd6bW5OcDh5MTBRazdsTGZERjdDS2cv?=
 =?utf-8?B?cFhmVlVaZHhIOTk5K2pxTmtkM2Fla3UvdS9hR1ZHbGIvZm56T2ZTblk2Z0lX?=
 =?utf-8?B?R0RhT0RLYjNKRWxSM2VqRzNKQmRWT1RVa2drYXZNQXZ1VExOVitOejJoMTU0?=
 =?utf-8?B?cFNUSkVjTGx1QzZQcGhFdDBFam02Y3FPaFpUSFdoYkFBTEhtdldpL0Q1bFZV?=
 =?utf-8?B?TVNlaldPQ1E1L0dPLzlxdWVKZlJGdDFMalVoS2o5cE42YlI4OFhBeGtMZXdl?=
 =?utf-8?B?MjVLV2grUlBvWWl1RWtjSDJpQlhrZEpUb1kwb0tjQWNWNTc2TFd1R0RVSGFn?=
 =?utf-8?B?cFpYQVdDNDhqN2NtRU1EeENSbVN0aU9MQnhubHkrTGs2cTNGR1gwRmV3OCtn?=
 =?utf-8?B?TjExVTdGdENkbm5sNHcvWFlIODF1SDk3Z05WeVhGdUMvRzVLRDVYVzJoQXNF?=
 =?utf-8?B?VU4vOUNJYm5aYUtlNXdERFRYMU0wT0FRYitZM1BpeFJFb2dCMXB3TnZqQU9P?=
 =?utf-8?B?Zk82MFhiSDd4ZmZNY29XWnd1b1M5NVRrY0k1TDQzT2hZRG1WYzRiU1V5Y05X?=
 =?utf-8?B?VHFMaEU3dGhsNmNlSWpGdDNQNURJVUxxMXhxZlhuamhqUUtpRE8zSmxqTU01?=
 =?utf-8?B?SlYxQmkyWGloWUhQUUE2dlpEalhHUy9wNllkcWdZdDVIRDVQN3lvSDY2djJK?=
 =?utf-8?B?R0cyWW9YY3FHUHZrNy9ScnBGSTRaVXJLNVR5N2NVZTU5RTFtbHp5empjVk1L?=
 =?utf-8?B?TEpoVlhUbU5BbEFYaVlnWXZBL0pnTFlEenJYbHlnQzFFTTR5dXluY2pLZTc5?=
 =?utf-8?B?MmNPcTMybU5nbWx1ZUdOR3ZxNUpURE84MnphTklrNm1JWTMzQmx4OUlOcVFJ?=
 =?utf-8?B?VUIrb0xBSmxzZTZGeDJCaUlObXkvKzRnMTRiMGhmazBJNHBKR1VGZW1GVWU4?=
 =?utf-8?B?bUdxcnFhUWczdWtDN2Z2TzNaV3Y1VDk3bXF0SVJ4alpGU2NodHliU3Fhb1g3?=
 =?utf-8?B?dzFVRW9scGVmRHZqamx5WGVBZnVmS2ZtSWtuVmpLdDJaUU1wMEZWY0hJZXBS?=
 =?utf-8?B?WXlNOTNORFlrbHdhcmFVamJPTVdpSFBBVDNDV1ptbTVRcWhoQk84YjVIZUZh?=
 =?utf-8?B?NEc4WHZwcFJJWUFVUjFTN3BhTDBpQTNjbGRKaVBheVNoT3ZnZXVza1VXb2xW?=
 =?utf-8?B?TjRDeHBHYXg5K25ybVM1d0JGamovRUpoQzV4MytrbEZHelhTNmxUQy9ucGdV?=
 =?utf-8?B?Y3p2VmNIYU52Q2dyRXhIdEhaTUtyejMrTU5EOXNLQVVkUGpKOFdXb0xSM240?=
 =?utf-8?B?VUV1TzNhdXlHL0M5cFpkeklYWjAxNXNFSkp5eVZ2R1JTUmNMNnpDQllnUWR4?=
 =?utf-8?B?Q0ZmTFg0WTJ5Q3lyVkRjOWVkNWYxSStvR09pT01LSFR2SUprZHd4dlZXYXhZ?=
 =?utf-8?B?Sm1KR2p3OUtNcWlIdExZaGVsK0VQMENENGZVZzc4MDZ6TGJTUnRDSTFLaEhU?=
 =?utf-8?B?dEM1TmtaTmMzdUpobmJNYVk5czRNbEhNV0kyQU9jSXMrM3FWUGZqUUZFNE54?=
 =?utf-8?B?bTYybU81M2EyelNBblZpUVdsdWxURUI2VHJiTTdGZEdTeXJWNjd1WktrRXlm?=
 =?utf-8?B?eEkvdkVLUkh5VDd6MjFoZEVrcnNGczk1dkloT1p4L09YUEZIM1pabzF5cnJz?=
 =?utf-8?B?MFdDS2dCV3FIdFE2R0p5L3VTaDYrK1Z6d1BIeTMydU55RDZpMEpkMHhHMGli?=
 =?utf-8?B?ekVPN1VWVWNaQ0FDMmxTT3lxb1VXdFhxbkMwTW8vbEErN1lFaU9uc3JVdDlS?=
 =?utf-8?B?TGdHS0RzQ2FVL3B3NE1XaDIvRi9rQlZDRFBhcDRhTzIveWwrcUNxZW5jUWpz?=
 =?utf-8?B?SytPNHF3QWhweDFKcW1qemRqZ0VBSEIvRXY3RHZ0cVhYRHlWcjJEb2R5bTBt?=
 =?utf-8?B?RVpiRFI3ckpIY0luMFY4TTBXcnM2ZGt5bVc5YmZ6K2JpVnFrd1hFSGM5emxF?=
 =?utf-8?B?RGhETU9rUG5NVEMxVXp0dTh6TTg0dzZFNnlFUWJaTExnQ01oaGRhM1hsc0Zv?=
 =?utf-8?B?MUE0U1hoUVVmcWcwYU1sRWVKb2xIQ2VIU25GWGRwR1JML3l3UEEzRmFqUnZE?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77764f8e-688c-4cb5-55ea-08dcde0d3295
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 09:25:44.7093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJ+/Qqj7ttRxRJqsOLIFVLCTR224VxPFra2m+1D5O/E634QRT/VK+Q9SsafTt157dvDBRhV5Zfg2cYoY5y8BfRF0CVZMj+G3XPGalSgMgRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7079
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.216, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Hi All,

Kindly ping, more comments are appreciated:)

Thanks
Zhenzhong

On 9/11/2024 1:22 PM, Zhenzhong Duan wrote:
> Hi,
>
> Per Jason Wang's suggestion, iommufd nesting series[1] is split into
> "Enable stage-1 translation for emulated device" series and
> "Enable stage-1 translation for passthrough device" series.
>
> This series enables stage-1 translation support for emulated device
> in intel iommu which we called "modern" mode.
>
> PATCH1-5:  Some preparing work before support stage-1 translation
> PATCH6-8:  Implement stage-1 translation for emulated device
> PATCH9-13: Emulate iotlb invalidation of stage-1 mapping
> PATCH14:   Set default aw_bits to 48 in scalable modren mode
> PATCH15-16:Expose scalable "modern" mode and "x-cap-fs1gp" to cmdline
> PATCH17:   Add qtest
>
> Note in spec revision 3.4, it renames "First-level" to "First-stage",
> "Second-level" to "Second-stage". But the scalable mode was added
> before that change. So we keep old favor using First-level/fl/Second-level/sl
> in code but change to use stage-1/stage-2 in commit log.
> But keep in mind First-level/fl/stage-1 all have same meaning,
> same for Second-level/sl/stage-2.
>
> Qemu code can be found at [2]
> The whole nesting series can be found at [3]
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02740.html
> [2] https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_stage1_emu_v3
> [3] https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_rfcv2
>
> Thanks
> Zhenzhong
>
> Changelog:
> v3:
> - drop unnecessary !(s->ecap & VTD_ECAP_SMTS) (Clement)
> - simplify calculation of return value for vtd_iova_fl_check_canonical() (Liuyi)
> - make A/D bit setting atomic (Liuyi)
> - refine error msg (Clement, Liuyi)
>
> v2:
> - check ecap/cap bits instead of s->scalable_modern in vtd_pe_type_check() (Clement)
> - declare VTD_ECAP_FLTS/FS1GP after the feature is implemented (Clement)
> - define VTD_INV_DESC_PIOTLB_G (Clement)
> - make error msg consistent in vtd_process_piotlb_desc() (Clement)
> - refine commit log in patch16 (Clement)
> - add VTD_ECAP_IR to ECAP_MODERN_FIXED1 (Clement)
> - add a knob x-cap-fs1gp to control stage-1 1G paging capability
> - collect Clement's R-B
>
> v1:
> - define VTD_HOST_AW_AUTO (Clement)
> - passing pgtt as a parameter to vtd_update_iotlb (Clement)
> - prefix sl_/fl_ to second/first level specific functions (Clement)
> - pick reserved bit check from Clement, add his Co-developed-by
> - Update test without using libqtest-single.h (Thomas)
>
> rfcv2:
> - split from nesting series (Jason)
> - merged some commits from Clement
> - add qtest (jason)
>
>
> Clément Mathieu--Drif (4):
>    intel_iommu: Check if the input address is canonical
>    intel_iommu: Set accessed and dirty bits during first stage
>      translation
>    intel_iommu: Add an internal API to find an address space with PASID
>    intel_iommu: Add support for PASID-based device IOTLB invalidation
>
> Yi Liu (3):
>    intel_iommu: Rename slpte to pte
>    intel_iommu: Implement stage-1 translation
>    intel_iommu: Modify x-scalable-mode to be string option to expose
>      scalable modern mode
>
> Yu Zhang (1):
>    intel_iommu: Use the latest fault reasons defined by spec
>
> Zhenzhong Duan (9):
>    intel_iommu: Make pasid entry type check accurate
>    intel_iommu: Add a placeholder variable for scalable modern mode
>    intel_iommu: Flush stage-2 cache in PASID-selective PASID-based iotlb
>      invalidation
>    intel_iommu: Flush stage-1 cache in iotlb invalidation
>    intel_iommu: Process PASID-based iotlb invalidation
>    intel_iommu: piotlb invalidation should notify unmap
>    intel_iommu: Set default aw_bits to 48 in scalable modern mode
>    intel_iommu: Introduce a property to control FS1GP cap bit setting
>    tests/qtest: Add intel-iommu test
>
>   MAINTAINERS                    |   1 +
>   hw/i386/intel_iommu_internal.h |  91 ++++-
>   include/hw/i386/intel_iommu.h  |   9 +-
>   hw/i386/intel_iommu.c          | 694 +++++++++++++++++++++++++++------
>   tests/qtest/intel-iommu-test.c |  70 ++++
>   tests/qtest/meson.build        |   1 +
>   6 files changed, 735 insertions(+), 131 deletions(-)
>   create mode 100644 tests/qtest/intel-iommu-test.c
>

