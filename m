Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A762D31A2A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 09:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfwzl-0007sf-V9; Wed, 14 Jan 2026 04:16:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vfwzR-0007pO-DJ; Wed, 14 Jan 2026 04:16:34 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vfwzO-0005oa-JO; Wed, 14 Jan 2026 04:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768382191; x=1799918191;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=F17lSn5SBh0VHJlMaaoaoIYosJCGusxRwnzqAQI2wA4=;
 b=ht5Ms71M8ghSk3TMYV+0DQgQ8AEnl0RnHbM+kxv72++zx3t6D1fgOn9Y
 HiLHfJEpZkLuCGq9cFpHXOHwaVVvPBK8KvWI6mSXVJtQURkajK4jpJ8Y+
 H3caq5Kt7ANG4zcQfAJxB2m7gYCElDq7rt8QCjxVDx7OopD39Hq500pNo
 qnXt7k5Tp0L5fH1FE2Upp9Ko6oKn8WoBGIBI3Qepq/kyttXKxYagc2364
 VEeSc9LhwRkTj/3+VzzWO9bADe75+gQHITjMQJctludzbg3HjwYJuMoID
 5Xn082DhrTZtlQq8yKkexCTpPnTcbxB+AUVQgkW9P8wFuxynVlp9ZohV9 A==;
X-CSE-ConnectionGUID: 4ad0l6ICThO+AsdcwdqUFw==
X-CSE-MsgGUID: JGEqatH1TbmeoTcaL68vOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69586390"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="69586390"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 01:16:24 -0800
X-CSE-ConnectionGUID: dry4Yc2dRzqOESg42zoNfA==
X-CSE-MsgGUID: 6KE4RsdhSi+wOvwb/OSuLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="204413662"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 01:16:24 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 01:16:23 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 14 Jan 2026 01:16:23 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.56) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 01:16:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DA5tc+JUBFnWUijbivkg+NhS2igLB2f5QiDxW3r9yiPyGoLmQWCZBO3o5Lnb40/vn6u1GnzTPSO0s9s7Yj7njZNffPXIaJVMTib2t5qKPcDpuhK59Dgs4CoU1K94g53C+Xuj6jOfnfJOwaZMMFDaDEh4DE15QyCTf/uDxBMCiT2zTE5N6ZuXZD9Q0wtO8sFupXpa/AF2s3tIB2KtF5qgorAIzDBRJnZQavUNLk8X6rKoyPhNf3IWyJaMiu5ceOcUtyEwQYYgzOwSlxTf9B/uUVg+0fX2oMii46RTDoCUFjNRts8ZoNKdS2y4ewYkcxJnUHaxcIg7FrpMF6ZFfYWvfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tadr2Jskx44s8aKLaw1rLdQ6oe656o6SeZE3buXzco4=;
 b=UkblsVpWtq7olldixoovMokq5rGgnzU5nbD4hVXPeLuwy2fnbz6bCNJdVGOMOYZrCoT8OS+DbAxDZOejm2H/aK2EPjJ6YiCM4YIGg+alw8fgGI/qbKwF5p4nzWFvzA0aC45oLwiaRK3MLUdLmfu8l3JZ4mp89wUpXVGTypy434KFxwqvMb2EupQaovYI23CcdvlrEa6x7hny/mYWljZB4olVUJCwPoo4jCQPEonBFOmrnpUW+4AM68fPBet/4rOUC/5M6p/OTbjX+NL7yCDy9uspNbA+ICGJpB+BJgWRZlgM5FzhXSYHb3PtBmG5xKRmVbvfdkt769xh6A6U/DT0ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by MW4PR11MB5911.namprd11.prod.outlook.com (2603:10b6:303:16b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 09:16:19 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 09:16:18 +0000
Message-ID: <2fc6c3fe-68d9-47b9-9336-8086b372eb9d@intel.com>
Date: Wed, 14 Jan 2026 17:16:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] hw/vfio/region: Create dmabuf for PCI BAR per
 region
To: Shameer Kolothum <skolothumtho@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <alex@shazbot.org>, <clg@redhat.com>,
 <cohuck@redhat.com>, <mst@redhat.com>, <nicolinc@nvidia.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jgg@nvidia.com>,
 <kjaju@nvidia.com>
References: <20260113113754.1189-1-skolothumtho@nvidia.com>
 <20260113113754.1189-5-skolothumtho@nvidia.com>
Content-Language: en-US
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
In-Reply-To: <20260113113754.1189-5-skolothumtho@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0036.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::8)
 To IA3PR11MB9136.namprd11.prod.outlook.com
 (2603:10b6:208:574::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9136:EE_|MW4PR11MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: 85136efc-ae2a-427b-cad8-08de534d9385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3I4Q3lQM1RtSzRrOGFRZFJRb0ZGNXRIMTVCVXNlZW82VkZNNVV4YnhmWnlW?=
 =?utf-8?B?NDlVb3R3L3lZajl4ZU9FWlEwYm5jQ1EwclhjYW1Od2tPcVZBSndxRlB0Sytj?=
 =?utf-8?B?SUhuS24xOUZyM1lFZ3NyblJlSTF4WHlsRHh5M2xDaG5nMEpKREFQc09uM3VI?=
 =?utf-8?B?ZVYwcDljT05rOFcxbXZOVHhLQnI2WUhPaGM5YnFQWWVSdTNsK0pEL2ovamVW?=
 =?utf-8?B?VUgvZ0VnYVN5cjBUdDV3N1ZVU1d0bUNNSWhiL05VN3R5akcyL1ZlM2xPVUJG?=
 =?utf-8?B?Q0oxNy9mY1p6UzlwTDRwbDhBYVhKSEw3bkZOMEJWRmdtVFdXdlVHQ3hjTVFn?=
 =?utf-8?B?MkZVYWVlMGR5VE9aR210SkpUMFJpVE9aajlLNERmK1Z2c1FxNm1UYUROWHZy?=
 =?utf-8?B?UUtCRFlrTDdLMHpHZ3JmeVA1ektkOFlDMTRELzU5R3JJbW5FLzkvUlhrWEhE?=
 =?utf-8?B?Z2lhZzFyYWVMc1BDTjY4T0xTenJ0ckxkY0NFZUptRGc0elFnUnBDL01rcVlL?=
 =?utf-8?B?c2hGczJNZU1WYzEyZTlDSkl4bWlTNFdaRlJDVHFFdHFOZ2R0VFBjSjhIdXo1?=
 =?utf-8?B?cHBHU3F5bEhtY2hGSXlKenREQmF3K1AzV28xR2dOSHhmdEVkaWg5MkRwMk1D?=
 =?utf-8?B?dXpLWGhnbWprRjQzTEpNeldkWk0xd09PN0ZyRE9TaUVwd2RBVHBoMWFMVDZR?=
 =?utf-8?B?RTlaNFRxV0pTMlozRWt2czVUVVJvN0tPNyt0QUVwK0pZVUhYMFo5WDNETnJH?=
 =?utf-8?B?ZThqQVJoZVVTT1hjeUFNblJvQ1ZLVHVKRUlMT2xLdjZwK3BONUhTSVo1djlR?=
 =?utf-8?B?K3dqWEFUVWhoR2cyVXRUdzYrRmUzSC9EVmdqb0VaZERJUjRnWTVjQVE0M3A2?=
 =?utf-8?B?THUyeVRSK2JrRFk0MGpsaWpzamp6dml3N29MUm1QZUFLbGRMM254UkJVMmY2?=
 =?utf-8?B?bzI2S0dvT2V5TjR4VkpYM0FnZDJVLzJnMnRheWltSGNyK0pmZXlHNjNXUjly?=
 =?utf-8?B?NDV0MmJXRitkZ0VXTHY2WEpwUkZRNjN3S1lDeXV1Y2lrNVo3cC9JY25QZ3hZ?=
 =?utf-8?B?RzdxVW9SV216MmV2M05teTdzZXdoMWdMMUtQTlhrRjJxSTZ0SGt2cTRaZjcw?=
 =?utf-8?B?NkRZU3ZiS0Y2dTJiaUx0WVBGb1hZeWlKY2t3a1B2eUFaYllsWDZTaVhjWkkv?=
 =?utf-8?B?ZDkzZnYzWVBldHBLQS9XZEhJUEI2NlJiRUV4VU5USzNqSGhUa1IrZTJnSFA4?=
 =?utf-8?B?eEdhV2NTZTdVTDVQTmdSUWxNWjFheVM3dEJUK2xHUzVMRzh3d1U4RXZyc0Zi?=
 =?utf-8?B?RUhsaWgvNHpzVDdrM3RQZjd0Y0x6MHRDeVJLU1kwblBpVk1VaGFqTDdTYWww?=
 =?utf-8?B?MTY5UDh5M2NzM3FUSkhjOWFZUURrL3l4cGo0aURxbk1Mc1lLc1VJb0FwcDFK?=
 =?utf-8?B?VUZLT3hVN3c4NmpLdHBOVmdZZTN0Y1Znb2YyQ1VHTkx0TVhEbWRRdGxoNnlK?=
 =?utf-8?B?MmxiN1hQWlI2WjI1RkpiemNKN0xYaTNMeVhHZ0FybGhCV3ZNRVJXN3E3bDNH?=
 =?utf-8?B?Um1BTnNBUEZ5dlI1b2ZlcFNpa3BzZVZWYUFKQlprUC9OVXJ5d0E2d0UzVS9N?=
 =?utf-8?B?bGtxMmVQSmNNd21hdUhGRjBveFVzb1g5eDRqd1drcjFib0Z2SVVac0c5Vjlz?=
 =?utf-8?B?cFcxN3BPcklvcExVZGppaWpRTHNHOG8zZ0dKaTVKanNwaHJXbXZ3WnpwNG9O?=
 =?utf-8?B?YkRRT1h1K2tEaGtYNzhnSjN5NUF6cHNlSkYrQTQ3S0x6RTNmRW1mTFgzT2FG?=
 =?utf-8?B?c0NmQUJCZkxpdDM3bUQrSndEU0V6cTFnVWJDU1owWWpiNDR0bzZ3UnI2SlRP?=
 =?utf-8?B?WDZvc3RCYTd1RkZHOVBVT3Fxb1B3UUgwMjJTVytrQVpXdzlNTGJpaXM3N013?=
 =?utf-8?Q?aLjHzyeEhxXGIIcnfFg1T69Bgt1Q/kL7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akhyK3Fobm84SU4vNmZZWC9xKzd1QVFwQTVEVFk2SFkxTXR0UUFjMzFSREZF?=
 =?utf-8?B?ZjhUTEdJbzJIbitZc3ovUEdXWS9nT3pzQjdhNmJrL3o0Ry80WUlsSUU4ZnFV?=
 =?utf-8?B?R3dBN1htRzZ4clU5TmtTTUpoTFZRUDRUb2l5MWcwZElEQ2xqZlFjdnkxN3dt?=
 =?utf-8?B?R0JIMTl0aHpLbTcwS0VQalExaE42QW4zWWtGMU5VcE1hbjJ6MTdOVHB2U0hi?=
 =?utf-8?B?SGhZSSs4aGc3aW1ZZWNKL29abW1Ga0N3cWw4UTVneEhzVUNOa1dtcS92emxv?=
 =?utf-8?B?MkloTE9mN29QdlZ2ajFTMDdUM2hWS3lLM2pvVGxPeXJScGZzdFd0eU1aT1Jl?=
 =?utf-8?B?SFZKMmo2WXVIZHkzNlNNQ25pRzRyUzdjbGdCa3RmdzE4cjkrckkvZnFHTUx3?=
 =?utf-8?B?TXdKRUM0TFZMTUkwaWFYL1RLUThjazFzeUZRUXpoZm12TFBBSnJBSlRRR0NF?=
 =?utf-8?B?bXhaanRYRU52SnJGSXBUa0pOcWE5NzVoMUZJRVZEdkVYVFpidnR2dmJ6Zy9M?=
 =?utf-8?B?VW5PRC9RZ1hJcTZhcDI2Smd5eHUvR2YxdHBJejkvNzNDTi94VzFiVy81S2ha?=
 =?utf-8?B?Vi84YkVCUldta2xrRmQvSTJUWmw1ZjU4OFJVNWo1S2JjVWc0TVVYa0piS0xj?=
 =?utf-8?B?YVlrbFBPQ3NtaTlJNkhsQjNaUHVQT1R5cG12YXhZS1gxYnRUc3U2KzY3ZjZ1?=
 =?utf-8?B?c21kZ3kxTkcrSHV1TG1CYjFVQU9LT3R6eG1WWmFMUFpaS2cvazVDaTEwY1h5?=
 =?utf-8?B?WDhLdExhRC8rYXppMHY2YlB4WWNGMmU3eUJHci95MnlZMkc5VklDNklFTWU0?=
 =?utf-8?B?UlJTQ2hpZHFZQ01UblQ5KzRlKzJQTnB0Vk5weWg5T2piTHBUVmlBd296YXpW?=
 =?utf-8?B?ZXIvQm4yV0wvTG5oSFFBSjk5ZzVkLzZ3eCs4NkJMSGNSUlp2QVBKWkxubS9s?=
 =?utf-8?B?WWYwZ1MvSVhqWnc0MTROZ2I0WTdtZnNQOFFEc1dxZjRTRHpYbnhvOHByckZJ?=
 =?utf-8?B?WnJya1dMU2tiV0J0MEtHeGsvK0d0b2t0ZUVxeGY5Y05GamYxQWNoKzVFdXRs?=
 =?utf-8?B?ZndpeStuKzdFQytOMXFHRXpZNnJnTEVTMDRtQ3VRam9kQ3EwamY3WElRbm0z?=
 =?utf-8?B?RUJBNEdUNk02YVNxZFF5M29PZzlHWWVSSG9qVVJPUy9xZ0JYZ3B1NEczS2VN?=
 =?utf-8?B?U1ZOZXE4RFNvSGJaeUR4MmdCZHZTdCtRano0OVVZekJKZ0pSU1pDQ3NNUWxH?=
 =?utf-8?B?TzZ0R3VzMGwrcE5rMytqZzVxSm50ZzltVDdQTWJ1TnpYK3JLMlRldXV2dGI1?=
 =?utf-8?B?TUVxOFRrZzlGMDRqSTJDbSs2OUlIL1hpb2hQYzhIK2VEUU1xQ2xwMnloOXZj?=
 =?utf-8?B?NFpOYlREV3VSQmVsNHJSNUsxU2dnd21LRklneVdVOGhKNVJzQi9XSkM0SHV4?=
 =?utf-8?B?Z2ZHRllvUnc2S0RYbWJmWU12cGdpQkMwLzYvczFiTzZkdHV3NG5NU0IrYnMy?=
 =?utf-8?B?N3YwS1hhR1NUcC9SMFYzZXlQdmJPeldSUHRZVDBXRTBOTmlPRFJSSTE1TUZF?=
 =?utf-8?B?eStjcGFJbUZySjNQdHYvdkdRLy8xenNkTWlsVTZmVnRnNTJGUHo3Y1FNbkd5?=
 =?utf-8?B?T1VZTml5ZUo5Mzd4TnFRMFlsN25Lck8xRTQzcFhxSEQzQXBlMTJOU1ZWYUZh?=
 =?utf-8?B?OS9JWmU5OWNSS250UFdVNDhQeUZhU20rcC9lc1dBS0NUVG5IeXdvUFl4Vnpp?=
 =?utf-8?B?b1E0d2ZmM1lNZDFQRUtjUXdaMlZlQ3RmdkNoSTVyalQ5c0FaQWdQK1ltOWtx?=
 =?utf-8?B?WVVBanBkdG1VWWkxSG9nRGtqMUxudGZuRWJQMGpWSmEwbmF0aldqcElwTjBl?=
 =?utf-8?B?YTBPRTY4Z29tTnd4OWlncjNZbEh4S2xSckdpSDRwTlJNbit5QTNOSnV3S3l4?=
 =?utf-8?B?WGdjVlBicGR1a0pSMDhzdHdKSllXSU5RWVpMVS9HbWRZY20rM29rdzE0Qmpw?=
 =?utf-8?B?UDVka2hSR0xUa0UySXNCdTZ2WmZwZi9oVTRmOXg0Nk9vUmQrc3NvRzBLZDV4?=
 =?utf-8?B?a3N4M1NtN2ZQc2x3NnI0Uk1JVk9kQU45bE9wc0Q4ZWk0NkkyL20xa3NiUnFT?=
 =?utf-8?B?ekl5Rys3YU1Od3M0Qk84NThrWjZGcWFveFgrc2lLUHMrM1lqVnNEQTJoYlRL?=
 =?utf-8?B?TzF3NHBVbDc5WmV6RC93TWFOa2dqd1AzVTBkbncvT3ZOTHhlbnl0OWlVY0Vw?=
 =?utf-8?B?N1RrRzlLQ3RnVWtVSmxOaHJtZ09UbjhHeWFKK3FzVFFhTVExS3dpVE0vZlVK?=
 =?utf-8?B?dkRSQlZCQ0VBOGttdUxZM3ZXQi9tekFUSHF3c1VvTDVkN0tFdlpjam9zb25u?=
 =?utf-8?Q?lo4Io+/cRBsJu6SI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85136efc-ae2a-427b-cad8-08de534d9385
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 09:16:18.8644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1t0ADV0eHwOk3pP47YntF6LAgZudB2pFMH4gDSE+GFJ4/XyHX1jlS8cE0oGjr3POYU9F25psG07INNHyCJd++DtSplmXaOIlaNEPKjawLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5911
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 1/13/2026 7:37 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Linux now provides a VFIO dmabuf exporter to expose PCI BAR memory for P2P
> use cases. Create a dmabuf for each mapped BAR region after the mmap is set
> up, and store the returned fd in the region’s RAMBlock. This allows QEMU to
> pass the fd to dma_map_file(), enabling iommufd to import the dmabuf and map
> the BAR correctly in the host IOMMU page table.
>
> If the kernel lacks support or dmabuf setup fails, QEMU skips the setup
> and continues with normal mmap handling.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   hw/vfio/region.c     | 69 +++++++++++++++++++++++++++++++++++++++++++-
>   hw/vfio/trace-events |  1 +
>   2 files changed, 69 insertions(+), 1 deletion(-)
>
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index ca75ab1be4..8476a54dda 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -29,6 +29,7 @@
>   #include "qemu/error-report.h"
>   #include "qemu/units.h"
>   #include "monitor/monitor.h"
> +#include "system/ramblock.h"
>   #include "vfio-helpers.h"
>   
>   /*
> @@ -238,13 +239,53 @@ static void vfio_subregion_unmap(VFIORegion *region, int index)
>       region->mmaps[index].mmap = NULL;
>   }
>   
> +static int vfio_region_create_dma_buf(VFIORegion *region)
> +{
> +    g_autofree struct vfio_device_feature *feature = NULL;
> +    VFIODevice *vbasedev = region->vbasedev;
> +    struct vfio_device_feature_dma_buf *dma_buf;
> +    size_t total_size;
> +    int i, ret;
> +
> +    g_assert(region->nr_mmaps);

It's redundant as you have the check in vfio_region_mmap(), it's trivial.

> +
> +    total_size = sizeof(*feature) + sizeof(*dma_buf) +
> +                 sizeof(struct vfio_region_dma_range) * region->nr_mmaps;
> +    feature = g_malloc0(total_size);
> +    *feature = (struct vfio_device_feature) {
> +        .argsz = total_size,
> +        .flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_DMA_BUF,
> +    };
> +
> +    dma_buf = (void *)feature->data;
> +    *dma_buf = (struct vfio_device_feature_dma_buf) {
> +        .region_index = region->nr,
> +        .open_flags = O_RDWR,
> +        .nr_ranges = region->nr_mmaps,
> +    };
> +
> +    for (i = 0; i < region->nr_mmaps; i++) {
> +        dma_buf->dma_ranges[i].offset = region->mmaps[i].offset;
> +        dma_buf->dma_ranges[i].length = region->mmaps[i].size;
> +    }
> +
> +    ret = vfio_device_get_feature(vbasedev, feature);
> +    for (i = 0; i < region->nr_mmaps; i++) {
> +        trace_vfio_region_dmabuf(region->vbasedev->name, ret, region->nr,
> +                                 memory_region_name(region->mem),
> +                                 region->mmaps[i].offset,
> +                                 region->mmaps[i].size);
> +    }
> +    return ret;
> +}
> +
>   int vfio_region_mmap(VFIORegion *region)
>   {
>       int i, ret, prot = 0;
>       char *name;
>       int fd;
>   
> -    if (!region->mem) {
> +    if (!region->mem || !region->nr_mmaps) {
>           return 0;
>       }
>   
> @@ -305,6 +346,32 @@ int vfio_region_mmap(VFIORegion *region)
>                                  region->mmaps[i].size - 1);
>       }
>   
> +    ret = vfio_region_create_dma_buf(region);
> +    if (ret < 0) {
> +        if (ret == -ENOTTY) {
> +            warn_report_once("VFIO dma-buf not supported in kernel: "
> +                             "PCI BAR IOMMU mappings may fail");
> +        } else {
> +            error_report("%s: failed to create dma-buf (%s): "
> +                         "PCI BAR IOMMU mappings may fail",
> +                         memory_region_name(region->mem), strerror(errno));
> +        }
> +        /*
> +         * Return success as VFIO region mmap succeeded and dmabuf is optional.
> +         * P2P DMA or exposing device memory use cases will not be supported.
> +         */
> +        return 0;
> +    }
> +
> +    /* Assign the dmabuf fd to associated RAMBlock */
> +    for (i = 0; i < region->nr_mmaps; i++) {
> +        MemoryRegion *mr = &region->mmaps[i].mem;
> +        RAMBlock *ram_block = mr->ram_block;
> +
> +        ram_block->fd = ret;
> +        ram_block->fd_offset = region->mmaps[i].offset;
> +    }
> +

If you have next respin, maybe cleaner to move above dmabuf related code 
into

vfio_region_create_dma_buf().Anyway LGTM,

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

>       return 0;
>   
>   no_mmap:
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 1e895448cd..592a0349d4 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -117,6 +117,7 @@ vfio_device_put(int fd) "close vdev->fd=%d"
>   vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
>   vfio_region_read(char *name, int index, uint64_t addr, unsigned size, uint64_t data) " (%s:region%d+0x%"PRIx64", %d) = 0x%"PRIx64
>   vfio_region_setup(const char *dev, int index, const char *name, unsigned long flags, unsigned long offset, unsigned long size) "Device %s, region %d \"%s\", flags: 0x%lx, offset: 0x%lx, size: 0x%lx"
> +vfio_region_dmabuf(const char *dev, int fd, int index,  const char *name, unsigned long offset, unsigned long size) "Device %s, dmabuf fd %d region %d \"%s\", offset: 0x%lx, size: 0x%lx"
>   vfio_region_mmap_fault(const char *name, int index, unsigned long offset, unsigned long size, int fault) "Region %s mmaps[%d], [0x%lx - 0x%lx], fault: %d"
>   vfio_region_mmap(const char *name, unsigned long offset, unsigned long end) "Region %s [0x%lx - 0x%lx]"
>   vfio_region_exit(const char *name, int index) "Device %s, region %d"

