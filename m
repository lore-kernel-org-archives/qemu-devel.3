Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB75FC52D6F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 12:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc2Jc-0002jr-62; Thu, 08 Aug 2024 08:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sc2JY-0002Ww-Qo
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 08:32:21 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sc2JW-0006Yt-RB
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 08:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723120339; x=1754656339;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3WoGs94Sin5P1CqinDZIApCM/tcHoid5QgLL/g/qtXg=;
 b=SVBvj0/ERZZswbTZtoIPZrrkDo+ZbgoHI2upwNoMRWaCPePRyOv+QKif
 10iZHmfNLDqI/PpHrc8QdENvoUmXRSJ26IorQ+020gW8otgAh4PNrI8BN
 cqSeWUx0Z7xTV49CJoy6EHpriOB4a2jqwJrxeV3K9/XXB1MWFoZObjCAH
 mu1HEcHdQ9rGFsET9eIPDBWNAF+SOKkt0xgMMnTXjtdAX/6tnIeu02BOu
 jfE4AbRnENGPS6ZTjgb3gSc3/mHZEnK26QowkhGFSt22WhD+QIrVlJm3P
 hdUlBNa05833aX3ZRtsCdlSB/R6GeIuDxhRxbmu/Yo2vpI2UnLrcQzL1R Q==;
X-CSE-ConnectionGUID: kQfYTriBTeCuAb3ouPD5uA==
X-CSE-MsgGUID: HvYZ5U1/S+STsxLW8RWEBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="43761560"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; d="scan'208";a="43761560"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2024 05:32:17 -0700
X-CSE-ConnectionGUID: 1iPSi+X0Tdya80VvaK5wdg==
X-CSE-MsgGUID: hvGPhsW/Q++yQp23JRB5Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; d="scan'208";a="88112048"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Aug 2024 05:32:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 05:32:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 05:32:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 05:32:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 05:32:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrVfqnSNPktsnHiTt5lm8Cl4XTKO1c/94xhcpN3sc0WNB1ANEdkeib1oO5/AXb2qHsTDkZYe0Vqv0RnqNbYlf1i/Gmd1ZhXbj75EODWLTRQ0/9pJefIsEMI5HZuDvGqZ0iR4wbPnNW74ldg/Mn8W0i6FwxAvRKmxKOUUNBZ+ZPExKJ1ink7y5rupZm8nXnn1KwM+dWJyb9+Ua49wo1RWW2C0dZMj1INuKMKPhHq6T677YzOeMvDiDm3slZCztfL0rtgNT6QxG+BDBbqw62ieUKX7VqC4YBjtCjhtrMd6ARFJDVlnzYdzHUHzRVDBOxGhUFbyln6Qb+UOUhSRCoUjrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPcipCgjDwHz1uxg3XD7KR0PG6cN7/NwXwCOifbIKRs=;
 b=VRD9H+JOiDRLMSsIEEVbUsYCQvyt7L8Ah9YRwDRoT0wNVyR7zXs4VMmr2bZGm1szzShB5ZlsfVd0XyWD2qyS/Aq7h8tzx+iZ+J3k3g5qA5G/I15T2bwwMk5tgJbcX+Z4GHkFLBJXrOOaGEpA/0du+svUqI7K04iUs3K6XusVy/TP5voIe84QkxEaQ9cNqRZqeDM91Nfj/esOre3oj7mv91j6ovpyQWbU4suYh4ev2kEznnVLg6FTUMkDRhXjLDJQTYxfPRuRyJ5nB0iWY3zIwLlLjsIxJpGh+mKNzml97SyrIY8MCsrFsR/magkb4DNI7SQnlT0mpMnVp7Klx/DI2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB7449.namprd11.prod.outlook.com (2603:10b6:510:27a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Thu, 8 Aug
 2024 12:32:12 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.7828.016; Thu, 8 Aug 2024
 12:32:12 +0000
Message-ID: <9ae22a85-9bf5-3d45-2d19-c3371aecf42e@intel.com>
Date: Thu, 8 Aug 2024 20:31:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
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
 <20240805062727.2307552-4-zhenzhong.duan@intel.com>
 <cba7ec79-e2db-4919-a1ea-553ed20e0e2b@eviden.com>
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
In-Reply-To: <cba7ec79-e2db-4919-a1ea-553ed20e0e2b@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0208.apcprd06.prod.outlook.com
 (2603:1096:4:68::16) To SJ0PR11MB6744.namprd11.prod.outlook.com
 (2603:10b6:a03:47d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB6744:EE_|PH7PR11MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d2fab1e-18f1-4550-12c1-08dcb7a620b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1hsMGVDb1BCMXRrZUxJSGk2cnZOVnFhNmlhVVd1anIvbi9Ma3ZoNEM4TFFh?=
 =?utf-8?B?TjR0UkxaSHlESlBhZTFwbEM2QzU3SnFaQjJTM2svVkYvU0cvcWNHamloNTNq?=
 =?utf-8?B?TFRMdUNObTNMN1RmV3BsVHBBN1E3MmFzcWpkUHB0aUlZNVVnR0NRYlZTL1d4?=
 =?utf-8?B?RGhUSmFIbkNKSDdNOXZNdWVaKzUxV2MvOVdQV25INENjZERkdjJxOW8wTTJn?=
 =?utf-8?B?bFFMSVo4eHRLQ3FsZFd4TDlrRDlpaVlRdGY1c0dnMmlCTk5aWE9kK0VRZWd6?=
 =?utf-8?B?QzdSYW9DeDZOMWI3NVhHZHdjU3pkS3ZpcnRyK3d2UkJtSjgvMW53ZE90NDEx?=
 =?utf-8?B?c055RUdXWEZsM0Jyd21LSU5TcEJuSWpUZGYzL25vT2FvdEludEtJbXg1SUo5?=
 =?utf-8?B?UlVQREFHWDVVeHJndGxWZzhIVmhKRUJoSlNmaDlwTXRCUzRrV0dRYkZCYlVp?=
 =?utf-8?B?NTJSSCtwRm1IeHA2aml6Y2Z1aU94K2xBQzN0K01XTU1wU0Nqd3dIVHU1ajVC?=
 =?utf-8?B?VGF0OE5YWTFxbUErZm1rZS9QdERwcjR2UGkrWnBRbXNEVGFDbmsySmZ1Z2du?=
 =?utf-8?B?R2duWitGREs4dkw1QmZnbEFoNmxKa202djlOaC9Fb1pzcnJZdC90U2wwVnBJ?=
 =?utf-8?B?VzJxZnZEM1ljVW80QmdHTW1ONlRENTF0QWdEcVNTOFpWWitsQXBtZnZ3QnVr?=
 =?utf-8?B?Vll6cmYxVnFOOXZScCtpN0JvM1ZBbDJLUmZxR2wvN1B1bnNCVDcybjlNc0p2?=
 =?utf-8?B?NEl2N0l0NHErb2RPUlU3ZFJpKzU5M3JpYm5pTGI3WElFL2hodFhiODF0RWJ5?=
 =?utf-8?B?SHpidHlKWnlLSGwxWHFyWi9QR0tVSTh5T1RjSGJuMStiRHJOMXUvc2xWemVO?=
 =?utf-8?B?aFVYTi9EQWxJYmVVaHpJbmtmSG1BN0tvdnA3eFZMaER3K2Rua0lmVVRSc0xv?=
 =?utf-8?B?Y1duU1d2UlAvaWMvMHNzZDRMVmhlL3RjMERSWHQ0MTVJUk1lMEFVL3NBNjZ1?=
 =?utf-8?B?TTQzc2s4U1lNMloxYXlsVmxwc3E1OUZ2bmVuNzRua3B6OVgvNUVHMG56bWV1?=
 =?utf-8?B?TU5kaU56c3A3ejFHK0krTkJ1ZlFaRDNaNmcreUh6cVFoMm9EdmFERzU0ekZD?=
 =?utf-8?B?NVlyNVl3bGIzR2lDcnpMNHl6L2lTemtrZXBDU2U1Q3FMN2R5cU01cmdxUFZs?=
 =?utf-8?B?dVBPMDRIMi9lYmx6NVRaWGN1THIvUEhTUXZXNE1SM2RweDlZQVZKelVuMEN0?=
 =?utf-8?B?ZGN2OXVsbTIrcThBSjVobGdJcVhBQWFBRXQwRHZlZmphZTNOTjNaQjZQSU9B?=
 =?utf-8?B?RmVPQ1dwdWpHSldBZGZ6OFZFbitkUFdZUUdkTTV6bzA4RnFqb1JuQmZOcmxj?=
 =?utf-8?B?K3oxZ052WTdnd1NNK2J1Ni9rWUxlVGlSeUVIT3FybkhCaGZjM0o2OTZobFZL?=
 =?utf-8?B?WWI4cW04cUVBZnZ4UXlXWWtET3BSU3NwcHlhb3VQR0JqbFN2UzlPZnJrOS9K?=
 =?utf-8?B?bHFZbnc1R2ZQR1FGNGIvbmRVMVpjWWl5TXBTSk0vRHVtcldzQndLaWtoYXRv?=
 =?utf-8?B?UlZuNldieElOaE5WOVBCckQ0RTBzSTZiMmRlMVNpdnBJQ3c0S2RlbnpRQWNS?=
 =?utf-8?B?ckdqd2h2TEI0UXp3dXQvVHlTa0J0K2ptUlMxdkF5NkNWVWxSaCtoRFRPZXVk?=
 =?utf-8?B?bllVcnJvdnNiMVpyWkFYbzBmOVlXdUU2ZU9ZbUpsRlYwc29IWk11RWlrZVBM?=
 =?utf-8?B?M0FTQmswbTZYVzUvNUljclJKVU91ZVlrQmh3QWY0djBaUEwyYjNXNGkwUmxu?=
 =?utf-8?B?ZmF4bHdQd25odXgwVU1CZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXlJYVZlaG1PcTJnb2QxdkRuR2VzNUlSMEJCNlhQbGkzYjB2Y3R0R0NESDE5?=
 =?utf-8?B?QmkvcnZMU3NhdDVaVzVrYXRVVWFqeDRqWHVlSFEvK2FMM0tFbzVJQ21nbElW?=
 =?utf-8?B?ODFQL3hXM3BKdHU2WTNjVTM4KzBnbG1wWEtvY0NEbWNHT3N3MEdtc3FFdzJp?=
 =?utf-8?B?cWp6SzNRKzk4dmpGSjJpbVNjTkRoZU9nc0swLzI0SGRKcU5oYk5hNTVZbFdK?=
 =?utf-8?B?MWNxRlZ6VjdQbFlnNnVPbjk2Uk5FaTBsRzluVmVaOVI0VWh5Q0hvdk5sd2ZT?=
 =?utf-8?B?QWVNR1hOY2g0MGFCME9wSjZLblVsT2FhcG1vVDBsVTF2b1lqUHpuMGI4cG5v?=
 =?utf-8?B?LzB1MlJiQUxhcXpzc1lzUzJLV0M2UmJSRkFqUzQ1a1FPMU5ZNTk4ampML1Ni?=
 =?utf-8?B?MHlNZ2tpZXBHT3YrSm9LdU5KS3RIM0t1dDJJcERJbURVUXBPSDk3YVVHRThr?=
 =?utf-8?B?ZU9lSkZ0VHZFNlN2ejMybVN1dUR0M3BEeThOdGpneGRIakZOSE1DN05ESngw?=
 =?utf-8?B?MVpQdjVEakkrc1Axb3V6cVhjTTRXQnVleWE0TnZyclpyT2JuVFcwc3hRUUFO?=
 =?utf-8?B?cWZDKzk1cEw3U3NRcU1rZlNKRVZYdnlPOXB6RTI1Tkl1b1JkbUY4blgyQzJP?=
 =?utf-8?B?QjZkR09PU01kUG9TNU1zTlkzTTlER1hVSFdDK0tBR3lWOTk1RGp4ek5EUGhi?=
 =?utf-8?B?L2NRTVpKeWJpYm41bEtNbFBOSk5STXQ1QllHZmh4KzY1SWRTUmZXSDhURWFH?=
 =?utf-8?B?QUlGOTVENnRiRDFjZE15SDhKbXVCMktoYmZRVGt3Qithc1RybnRSR2lTRjZv?=
 =?utf-8?B?SEhRYzZteGVyWVB4Yklla2NtTC85eGdvTGhTYlRUOFV5Y3JWV25sZXdCUDRn?=
 =?utf-8?B?SlRwdTFYVE54UWFTTGRmMnN0N0xrdncrUnh4L0FlWk5lOUYvQW1RODhTemg2?=
 =?utf-8?B?aEsybEVTaGoxMnRWUnFaaUltNjRaVXIyMVN2b2xNSE1zOXV4RE9sSGlwY1Fz?=
 =?utf-8?B?TC9LRXAyVDVydWFVZjcyRllmY1MrZ2wzSE85NmNSY2d2NGdhZlhhMWpJa3Z5?=
 =?utf-8?B?WXM0TThmQ1NzWStxRHhTRDM1UmJXbTdtOVVINnZyYURSWWp4Y2E3T1Y3Yngz?=
 =?utf-8?B?ZDFIZmpxUDB0bEFqMG1yYmJKWS91TDdOVnRGNkI1UFcyc0dYSms4THJ2SE52?=
 =?utf-8?B?dTFEMlVDeXU0akhWcjZuQWVieHJnQkUvY3ZGbXZTRGl3V0JKNHZTd3VEWWdx?=
 =?utf-8?B?ZllQYi9wbFVJanZINm1oeTM1UURqREZGUktpQ2d4VDNlaUVwVDE2NDNGY2t6?=
 =?utf-8?B?WGxEZU1haVp5MDdtWndBNHpzVjFnSmFpV1lqSURTd095L3VVVkVYaTRBZEND?=
 =?utf-8?B?TkRrWnNCRkNxTVJ1TVRrQy9mK2UrdmlpNDVkNFVnN0c1bGFRTjlUbDhKWnJs?=
 =?utf-8?B?STgvSkJZUEpzeEhyY0tWSThLcWdTbDNuWERqZG9DU3BqL21NaEhtRWQyQ3pD?=
 =?utf-8?B?SEJiUFUzTmtlN2Rna1oyamU4SkFoT0N4clNwS1ZEamRRa1owV3UrSG9WVmhW?=
 =?utf-8?B?V2EzSnhpdm8ydFpKNWtLREF3bit0aGc3Zkw4UGxncXQxalRYZjVNTTMwWFIy?=
 =?utf-8?B?MzM5NGkzMWhZbnFzdG9oYjZ2cXBwOTltT2trMDhLcEY3TG5WNWhNemVXdEdh?=
 =?utf-8?B?dEJlOUhNZzg0L3gwRVVHZ2ZVRWhmSnNYeC9HVWowVk5ydkVwSmZKWnVTUERJ?=
 =?utf-8?B?R0lsc3gxcDY3R0hpalBzT3RtSFdscnJMb05QRUtQbjhma1c4NWV0bGw1NzNk?=
 =?utf-8?B?eDVPcFBFczJpcXhLa3JpZ3cxeEdXejF4Q3FEMEFHNVVvanFwY2VoZUhaUlhI?=
 =?utf-8?B?S1ZvTDBYcFhjWG9mbWNoU2VXb0FJUWpVdFBQaUxPUHFwcFNlNmZIQXNyZkFa?=
 =?utf-8?B?c3lRRXp5Q3djQlhPdk1KZTNGRTFnOHlTdzE1MGJoSmRCL0NsYjFaNjVlN2NU?=
 =?utf-8?B?ak05dTdiUU56OGVZeDMxYytMZldhT21ibjVBQk8wdFJ2cWl1ZXI5WkJ6YUd6?=
 =?utf-8?B?WWs1Z2NMU2RleXE0YlhiTEtFRjVQcGZOWE55MFBRa1dOclJSa1VucWlCeERk?=
 =?utf-8?B?UGx1NGpWNWFPSzBmR2ZiYmtkTTZRMDVxa0daNEc2eDFjWVE0ekJXbUlRYStF?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2fab1e-18f1-4550-12c1-08dcb7a620b1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 12:32:12.1607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NUp9vSzwL584Nk9uhre19LK4ogT9BLvQOYIRPYvJvexqEQk16ZATVycHp4ysXyGhjio1jPdB7cu7ayoAhrYLA4tR0/hQjMqxqgUa0so6ye8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7449
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
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
>> Add an new element scalable_mode in IntelIOMMUState to mark scalable
>> modern mode, this element will be exposed as an intel_iommu property
>> finally.
>>
>> For now, it's only a placehholder and used for address width
>> compatibility check and block host device passthrough until nesting
>> is supported.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>    include/hw/i386/intel_iommu.h |  1 +
>>    hw/i386/intel_iommu.c         | 12 +++++++++---
>>    2 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
>> index 1eb05c29fc..788ed42477 100644
>> --- a/include/hw/i386/intel_iommu.h
>> +++ b/include/hw/i386/intel_iommu.h
>> @@ -262,6 +262,7 @@ struct IntelIOMMUState {
>>
>>        bool caching_mode;              /* RO - is cap CM enabled? */
>>        bool scalable_mode;             /* RO - is Scalable Mode supported? */
>> +    bool scalable_modern;           /* RO - is modern SM supported? */
>>        bool snoop_control;             /* RO - is SNP filed supported? */
>>
>>        dma_addr_t root;                /* Current root table pointer */
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index e3465fc27d..c1382a5651 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -3872,7 +3872,13 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
>>            return false;
>>        }
>>
>> -    return true;
>> +    if (!s->scalable_modern) {
>> +        /* All checks requested by VTD non-modern mode pass */
>> +        return true;
>> +    }
>> +
>> +    error_setg(errp, "host device is unsupported in scalable modern mode yet");
>> +    return false;
>>    }
>>
>>    static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>> @@ -4262,9 +4268,9 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>>            }
>>        }
>>
>> -    /* Currently only address widths supported are 39 and 48 bits */
>>        if ((s->aw_bits != VTD_HOST_AW_39BIT) &&
>> -        (s->aw_bits != VTD_HOST_AW_48BIT)) {
>> +        (s->aw_bits != VTD_HOST_AW_48BIT) &&
>> +        !s->scalable_modern) {
> Why does scalable_modern allow to use a value other than 39 or 48?
> Is it safe?

The check for scalable_modern is in patch14:

if ((s->aw_bits != VTD_HOST_AW_48BIT) && s->scalable_modern) {

error_setg(errp, "Supported values for aw-bits are: %d", VTD_HOST_AW_48BIT);

return false;

}

Let me know if you prefer to move it in this patch.

Thanks

Zhenzhong


