Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78887C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 12:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdqIg-00075p-5n; Tue, 13 Aug 2024 08:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sdqId-0006vs-Gc
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 08:06:51 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sdqIb-0006xR-26
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 08:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723550809; x=1755086809;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0ZaJXed+XUEzHr+7hn5LWoBQ6oEN40otN8QMQu4v31g=;
 b=acFX3bM1ZtdMzZpIK13sX8zPzaRvk8Qr3mTwbzm5Pofp1yjIBMIuKp+7
 eA893agZhtHjgGhjbXWIa/UsBxMo7vewN1fLFnAjI1bK7g5R/VUcSp8Kz
 5+eggCxBKDlOdHv5XeoEX0xQO7O3MCGxJL2Ux+oQ5+NZPmx4RPTnTN2M6
 cW/aoRoqrzSoO96FaQvJnSAyksZGVFvKiB+A4clakJWOjXcPOkSyo0DE0
 BP4dc9DkyrJPGpyFj4YWlpczGvYm/2cAFtUMMu6HYl5drUfDwtnUamLi6
 Kxw2Dk53myfsG61rluj4poOEBxjnNeMCI83KpclECrRYVBoFWDNBitdxK Q==;
X-CSE-ConnectionGUID: QLCZD4AqSpCmahQaCnj58Q==
X-CSE-MsgGUID: xz0hD0VQSY+cHVlnkxcRoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21852636"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; d="scan'208";a="21852636"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2024 05:06:45 -0700
X-CSE-ConnectionGUID: hY9f2UPnS8mCj1AXqeSAzg==
X-CSE-MsgGUID: 0RDcI+NLReW1e6H1USb7Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; d="scan'208";a="63328536"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Aug 2024 05:06:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 05:06:43 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 05:06:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 05:06:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZI6c3JRNNpiyOQEDRhVetL2dn/7lkz+pSCNQsOHQ0xiUIcVOXTQ4Qh7WCupllVmD5cnSWpfhohU3rVKRvB9l+avCVSEbvZAq4znrqgmoWRy+Dhn5XsOuhOG8E2BSqSl6klPdIQoboGzu15ds+2C8hTDO3fRsCdMGhDo5PbDZMtuVRn4GBjNQB0dDctaRhCRhKsgvn1vFEIBW89piBgNqY5aWw0a5RA7L6Bt1Ds1VwHVpVHxHQGY4YlVvj8vo8E0mfC7uK8ERBQyTm6lxo1aEr4eThK9EJn0B9lpLt0o2jOXcIUVpp+MU+sKTFwU81LXQHYoB9fVpd3eT3yqwxHBoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epx93cLqfUZ8JQedqOfz446x+jlhxBZnKC+aLws+7ig=;
 b=jT58qSNQDIlaZxnuLKadBMmYrMovFUvIsEHc4Dl2Pf6yB0dTdlI1FV6Vf/rPWb215yb5kYQlpDEwX2eEvhM324kyf4/vifqVJWCFFZZEjXGFwEu4inARM1dH7AmqvDUBzi/UuNpq7w5P7EyfEKq+m532WwREgJ9ZMrm/jzMxTHISg5FyBBqnTgb8OWJVOQ5MmVKcHPjOWzjoLo5Bk7IXl/qzvO9fxtsIFCP3d2SSYZkn4H1ErzEqjrkCC1TU014yzE2F3fTxL6nN6ShLEeKwD7Ha5CJZjTzgiNeT3KMTVZRSasPCDIcXUtQNMtKkuE00G7bGFf+wQ7Xafi4pjDnHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH0PR11MB5000.namprd11.prod.outlook.com (2603:10b6:510:41::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Tue, 13 Aug
 2024 12:06:34 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7828.030; Tue, 13 Aug 2024
 12:06:32 +0000
Message-ID: <94e10132-a2db-4eff-afa5-cbf9d0c5fc01@intel.com>
Date: Tue, 13 Aug 2024 20:10:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/17] intel_iommu: Make pasid entry type check accurate
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-3-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240805062727.2307552-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:3:17::23) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH0PR11MB5000:EE_
X-MS-Office365-Filtering-Correlation-Id: 25735022-20b8-424d-d864-08dcbb905ed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDcrb0RKWEhVRzZ3dGt0bkpJMDNNWi9ucmpjdys5U3JsZzErc1BGbTdXUFpl?=
 =?utf-8?B?V3RoVG4xeFNVY1FxaUg2eFd4a0dTcVZIaTBEUFdMM0FnSllSRENZNEhscElP?=
 =?utf-8?B?T21UWCtxSWkzYWVRb1FuOTlOUnhjN2wwZU00aU9tbng1bitWOUtNSlBINkFw?=
 =?utf-8?B?Z1ZudjluS0ROUncxNWRXRng3ZldBY005bEIydStXcHhYcjFuL2RnUkh3NXpi?=
 =?utf-8?B?TFg5akdkeDU1dUtqS01Id2dMR0VKSC95UWpFSmI1N1ZGTFZ0WmxJa0cxR1g1?=
 =?utf-8?B?aGR5eUQyS0VQUXg5WkdZdzIwSWNBOEJpdTdXY3IvN0JPdmpZV3NHb3BiTHlz?=
 =?utf-8?B?SDVzeUJaanpiNjlyNFVaVmJNRkp3VUJ0VVIwUWRDNGRYb3J6VDU4UXFUNzNa?=
 =?utf-8?B?d1FqaWsrZU0rb3I4MERXdXptT3FCWjhXZS9rS1RPOFpOWGxDVktqRzZWa3lr?=
 =?utf-8?B?SmNLQkhpeTJnVVAycUFzbjRFRjl5VHF5dnV2aElzK2dPVk9sZ3U5T2owTTV6?=
 =?utf-8?B?Zk15YkJHOU14Vk1sbVJvUnZRdnlLbS9scVhaYUhGek4zRUFGbDJxOGc0djNB?=
 =?utf-8?B?Q0tSVzg3UHI4NVhjMzNLZmYyZGFGTTZYMHlSK1BxRWZpUkROdTlNbHJxY1JW?=
 =?utf-8?B?ekdlbEdqblYvSUtXenJteVBkdm9EbjFWRGxRYzlzQ3pIN2dtdWJML0FUai84?=
 =?utf-8?B?c0dzVDRVbWhrM3YvU0FldTZzcTY2UzN6L0pqbys3dUFBNTBMd1hUR0hXaTB3?=
 =?utf-8?B?Vk1DTDJtMHNUT3BMYkp6QjBBZllud2NzOEo1c2hXSEpuT2tmRU80VXhuWFJS?=
 =?utf-8?B?YnkyemticEZxc1JYZTY2NUtFOVludlM5eUt1aDFsSFRaeWZ3TXFva2pkN2po?=
 =?utf-8?B?K2VFdGVxL205ckx2U0ZERzNNMnBlOENHdzJMWFBzSUdMNEU2Z3lxd3lENnlG?=
 =?utf-8?B?S2k4bFpqRXpHUEdndGV4WmtMelp5Rm5YN1VvREMzRC9JSWlWVngrVm1PbGVk?=
 =?utf-8?B?UzlJU3JpSXlJRlhvSjlyZExpU3c5SEJtM2hoc3VZY3d1NSt0dThORkdpaHpN?=
 =?utf-8?B?dDQzc2hVcU02cHRYV0ZlQ1AvRGZDa0piaVNxY0dMRUtJVUQ4Vkk0Q2s1SHds?=
 =?utf-8?B?ZjR0UXREMUVOKy9JUHZ5cmFSNHZSemJlZTBMY3JKYkNGaFhYQ0hKV3V2NjlC?=
 =?utf-8?B?dTAzeVk2QkdWSTc3d21kNUtGNjZJMDJPQmJNMmxWMXVoRXFzcFVjUUlJcmVp?=
 =?utf-8?B?cnlHdDJRRWZnVkcwdVV1aGNzMTRtM21MY21yV0l6TzRtbUU5YkJ5eFo2UkdC?=
 =?utf-8?B?bkgxdVpwTDY3RGZTUEt3TkVoQTkwTXdUeDlCUlFQckZaeWdCNW5lZjE4QXBP?=
 =?utf-8?B?VmpoaWk4OUphVXJWcGhwUnJDRjlYV2JyYi85NXpzNE9VUGU1SHp4THg5VUpn?=
 =?utf-8?B?VDJEQm5SWjY2UVNBUmd2TTc2K01QUnlwaGd4YWg3WnJGSmRxYUUreUJuc3pK?=
 =?utf-8?B?ZmhDSCs4c3dHSThMYmRUS3VFNzEwcDlDREdoSGEwZDFnemtuNnE2STg2dEVj?=
 =?utf-8?B?dFhRVFBWZ21kbDF3cGRCODk5dXAxUTFveHR0OU9HQTdldW9rU2lDaXJ3NnZI?=
 =?utf-8?B?ellZVWtnMFpDd3l2alM4Zkg0NjAwY25CZFN6Vnl3eE9rRGJaSnh3U2gvZzlh?=
 =?utf-8?B?Ui9EQ2c5dmNNb3IzTkNvNjRqblM0OGtOOHB0Vy95anRkR0tLaGQrS05JdWV2?=
 =?utf-8?B?YUR2YUNmNS9QbXlid0xFcUs3ZHdwVlljWjdaRm5ESjduMGZVRE53TjhsZlFz?=
 =?utf-8?B?TWJTQytudC9yWm5XU1FJQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmFwNTNqZzN0MU9tS3pxbTQyZGhLb092ZkF0UU9DVE5OdmFNVjAzblIwU1FE?=
 =?utf-8?B?ZWpPM1ROMks5ZmUwNEpRdGVsUHlqRXh3aE1EazV5TWVoclRuL2Ftd1Z6Rk5H?=
 =?utf-8?B?UHUxdlFJZ3FieFlDeDhuU0w1L2ZJK0tMeHlldjEyRjFqcUo5NWtNWGpHOUo3?=
 =?utf-8?B?NUVKbkdOVGtSUElpd0p2bSt6Z202MkQ0d1VBU3VabzlTaVVPYWdyYk5WZEE2?=
 =?utf-8?B?VWQ3bjRaZllmbXFwSTFSRnVvd3F1M1pwbTJhMVZaT2x6RlBhblFoTW55L0hT?=
 =?utf-8?B?cHVyR0hkSmVodkFxQW1Ca3VuWERYa0NyNGpLV1ppdEt4ZVJhYW96VlRhV1Ey?=
 =?utf-8?B?RE01OE5GV3BiRmpIVERCR2lSNTk1T3M5RnhwYW0zQWtNU0hBS3ZVU0NMUmNj?=
 =?utf-8?B?NDRFK0czeklQQXJxVjI3TitIVU5zdkZQUkg1enNHbFkyMnY2STdhbEJFYnVu?=
 =?utf-8?B?dE1uUHVNNmF5MlFhOHBRNHZlZFVTbTk0Z3E5MjJCbzlNTHIweHBUU2k5OHlO?=
 =?utf-8?B?TWIrTW1LN0R5UnRwUTVETVN5UjNPTmJsSkdpck93UG1sRXpDMnlvdWI2NS9I?=
 =?utf-8?B?cytNZTJXOFdrbGhmT2RDSU9UVnJmTHlVbjdEUFl0amJ4c0ZTUzgyaVZudkJz?=
 =?utf-8?B?MjBhRGRHY3dMcVJSeVRyY3FkbngwQkVzcEVNZFF6ZU1FczVMSHhJK3hTL3lK?=
 =?utf-8?B?U3FDM212TXZCcFdJajEwYStPeVBkaFQ0UXpoMU4xNjQrSlRyTU5EZVFrNFVP?=
 =?utf-8?B?WkFWSWtQaU1JRjhzSW5ySytQUFd2bWFIaXlpdGFoSW9SWmRuNWcxa0l4cmJV?=
 =?utf-8?B?WEV0QkozS2VHY3hEeDdNa3dXbXgraE9PcFRsK0NiY1lxYkdRSzNqWGtlRTdl?=
 =?utf-8?B?UGVPRTJXYktrZ2phMXVDTFQ5MWdUZVZBY1ZpWWtvY3Z6US9xZnl5cys2eGtT?=
 =?utf-8?B?Z3NIWWQ4MDJBQ3RJWVBham9aWTN5VWZJYnJkQzBOMDhGblAyRXBadWdiOUlJ?=
 =?utf-8?B?TlhZY2pzRUtMaFpsL3N5QzVQVXRYOThWZFBFWWFNcnB1YWZwbWUwQk1vUEZh?=
 =?utf-8?B?WkdTVVBGbmQvVkZ5V01PeXh3R2pJTmhVandzem03UjM5K2gyTTdHQitQWDRr?=
 =?utf-8?B?ZmQzMHdyQXZJa2xaN0ZUVk5aejlQRzB0TzRma01uZnFnNExRS1RyOUp1aVU0?=
 =?utf-8?B?SXpsdjZJb3JpQ3FMbUt4K2sxTk1DbC9EU1FzWWxTS1NkWE5OVGtNQmtCMlJj?=
 =?utf-8?B?ZWUrQitONFFJdjF4OXpva2hpRCtreW52N1ZiVm5ZWjc1SmgxRHA2bHJseUtV?=
 =?utf-8?B?TnVmblhqalF4T3hCU1lWenZpTDRaU3g2MGc0M0pKc3lOMWV1elFrMzlDRzR2?=
 =?utf-8?B?ZkptNmJYWHIwaUJ2bSsxK1hyR2I5R1RkeDVYQW1tQzlEQlY3QkVRaW96REFZ?=
 =?utf-8?B?elE5ZERQQ2ZRRk1HRk1PalZzbmJzSWRwM3VDN2tVMitFRUkrNmt0cXFRbFE0?=
 =?utf-8?B?MzkydzlQaWo5RitjakVjOU5vclJSczRLVmFkc241S1FmOGhxbUZnaHlvTDZR?=
 =?utf-8?B?ZmFwWWtHT0FmdTVOeHV5ZThYVmZCY0lyZHZBcEtLZFZCZkpZL2c4Y0k5QTky?=
 =?utf-8?B?WVQveFZnZmJ6ZjFuU3pxN3RuOW9XM1ErbEpGeEwxN2VkanJIZ2ROUUVocjBj?=
 =?utf-8?B?bjJHQjlVdUFncFUwOEZmMVBpN2F0aEpVUHdIUlZVSUVqYnZzQUdLYXBOZndk?=
 =?utf-8?B?QUh6SS9lTFdvaGdsMnVWOWZzRjJMa3JDMEp4d0dSZmJWYWliMFVKcUN5Kytx?=
 =?utf-8?B?bng5c2diL1R5Q21hRVdOUGR2QmZKM0U5K2lqbnNVeEhpZ1dzM3o5YmFpU1lz?=
 =?utf-8?B?ZHF2bmo5ZkJYUXhXbitZMHpwRU1hWHcrTWEwSWdvYUQrbWpxNm5wdnJXeTFl?=
 =?utf-8?B?eEQvTlF1ZEVMekZNMVpVeGx6OWQ2cmU5WGhqUEIrVld6bU00OVBEU3EyUTFH?=
 =?utf-8?B?aHFETWsyRVpia3Z3UmllK05SeS9USnkxaEhjcWJZcUpobEMyNldYdU0zOHp3?=
 =?utf-8?B?NTB1OFNkMXFGKzFKelF4Z2cvbjVEMVhEa1dFRW9QY3hTTHVUcnZtTFJkS0d6?=
 =?utf-8?Q?xSsV4CoizNaTuv/lOlXMJHd46?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25735022-20b8-424d-d864-08dcbb905ed3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 12:06:32.3934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hprxHwl3WGp7a9VB4ePK/LTLCLT4Vre716afOrcLQlyZpmyl6PxACYoG7/Q6Kt5tzeqQyYdy3yjOI3BcHw60Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5000
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/8/5 14:27, Zhenzhong Duan wrote:
> When guest configures Nested Translation(011b) or First-stage Translation only
> (001b), type check passed unaccurately.
> 
> Fails the type check in those cases as their simulation isn't supported yet.
> 
> Fixes: fb43cf739e1 ("intel_iommu: scalable mode emulation")
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
> ---
>   hw/i386/intel_iommu.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index c52912f593..e3465fc27d 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -759,20 +759,16 @@ static inline bool vtd_pe_type_check(X86IOMMUState *x86_iommu,
>                                        VTDPASIDEntry *pe)
>   {
>       switch (VTD_PE_GET_TYPE(pe)) {
> -    case VTD_SM_PASID_ENTRY_FLT:
>       case VTD_SM_PASID_ENTRY_SLT:
> -    case VTD_SM_PASID_ENTRY_NESTED:
> -        break;
> +        return true;
>       case VTD_SM_PASID_ENTRY_PT:
> -        if (!x86_iommu->pt_supported) {
> -            return false;
> -        }
> -        break;
> +        return x86_iommu->pt_supported;
> +    case VTD_SM_PASID_ENTRY_FLT:
> +    case VTD_SM_PASID_ENTRY_NESTED:
>       default:
>           /* Unknown type */
>           return false;
>       }
> -    return true;
>   }
>   
>   static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)

-- 
Regards,
Yi Liu

