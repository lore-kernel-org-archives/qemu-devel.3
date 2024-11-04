Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDBBD111A5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 04:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7oaT-0000JV-S3; Sun, 03 Nov 2024 23:21:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7oaR-0000JF-PP
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 23:21:07 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7oaM-0001kW-As
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 23:21:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730694063; x=1762230063;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iW2497wAPUCdB1TVFCUXqN7Tinzlt+J36bVuDkl+N38=;
 b=mzfx8sGvSXSjtoHtpb6EY9NFIUmaYOJ+KeG8pLHlCi4V6SWIj+bJxGAw
 a3dcj7RyrXjKZSpd4cW60dt2+jGEL94jwlPcLs6DLKrePI/g6PFLRVvqL
 FX8WAVlin+ZAJacL+CFEcsFBufyrXd5CZyPgum5oiOeFlzFE4wI9+luvN
 1t4KCgRZKT22c7Re5belovkSeiIA+RW/yocKxgR9y1CorvI+sCQ4P7XmR
 wjBEmozQEPsSeged3x1KPnDTqIE/va18pTwdNZUcolqVgi2j4x64jCjNA
 bpRv0kAJ05twrWCar+jclbvWJ5hIVt2vg2dVWdNWiP0gfrrPbIAjehxvp A==;
X-CSE-ConnectionGUID: RulQnAraTLCLNG2UafD7Pg==
X-CSE-MsgGUID: 6Zynm0ZQSjqfKQsPsRWtkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30153963"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30153963"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2024 20:21:00 -0800
X-CSE-ConnectionGUID: y+xqZwUdTaaD3qhr6ZFJPg==
X-CSE-MsgGUID: BeZEVMNaRuiOERpdxGNBaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="87469433"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Nov 2024 20:20:58 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 20:20:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 20:20:57 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 20:20:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tucq+jUQbB2sc4q0DBnQjFSy4x7UpKOvxQjzv3j3jQHCiBhRYsScZZP/az05kSxLP399AA8zcuuWEo22jJAPN+uSlehVz1Q7WKG8RxuM2Fwj8TVRDMkNQrbSo/LJzrTOhineuDSlLxRzyAILud3pa4CCXu5OhorDMwFKBLShlXOr9tP+EuWTK94CXG5pDTlLmiwuWFKG/Mxbsk2NjTOD0n7DRH4V6C7j/UCKCTQev9UJWd5iiLnafIc3m05F/8zzfqBz9FPKd9Ipq7rI/xKNo3z25dBUtkR4CQAoPkq2L0KgrZ9pzNsyKh/QPk1NrUDjk9oONarLtOMH3kXYA5ecAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uWSN8FUwBTkV8wkK0wphWls2tBmiIdwtFFQAWWfem4=;
 b=Sz9Rgn7Qtdr9xjlKHVhbbwQb6oPhQW1K4Xrd2U6bB5EKuvPHb6ruBaJxNNNTpxU6/qYAZKZiyt8+eqZI601Phx90iWhpmOZierYGT2z0RVdVvceQWqsz+knx0OfX0k2YAXmsPSy9kOgoU0mLlSabh3mApd/kSVLxUZpthflj6CZnIhRwBtqtNql+vqUReWnr5nsfrgpZGtLBgURq3mNXS3vIqCnmNNDaq6q4QIB5QPIwTviyYk0qyF020scUp7AvhhTEok3hH8tBMVzkXP1UJ5zrwONfNRFjahc9BOfujUw8Jj3t8gkmxKec+Pbc9dbfCjtOPzZlCQwlcyVQ5rQLCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB5199.namprd11.prod.outlook.com (2603:10b6:a03:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 04:20:50 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 04:20:50 +0000
Message-ID: <5cbe6426-e64c-45f1-b276-c7dbb70ff3ed@intel.com>
Date: Mon, 4 Nov 2024 12:25:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/17] intel_iommu: Introduce a property x-fls for
 scalable modern mode
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-16-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240930092631.2997543-16-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB5199:EE_
X-MS-Office365-Filtering-Correlation-Id: 640c9ec2-644a-4fd2-130a-08dcfc881038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmdrVU9yOGxqYjNnUGU5S001S3dvMXo1cGRoL3EyV0lKdEx5d2dQenZFMk5B?=
 =?utf-8?B?QU1jaFRENmtlVng0c1oyejRkbEJ3bDk4aE53SGJKTXg4dk9yb1QxVlRJcnJj?=
 =?utf-8?B?dm00L1Z6bUV0MWZZdTZDNVg3MWVnaGV4VGJrdDhpeVlNS1Q5WFR0MEh3NnlK?=
 =?utf-8?B?U2h3OWJtT095SUI0THdNbkgwd3FrQkhsS2dwMFlLZTNYS0hSbnFRMHpWYTlT?=
 =?utf-8?B?OHc3WkxwUDg2ZjUzQVhCRGU2YVplWUI0L1AwVTJJZlRsYW8rRkY0b0JpYXcw?=
 =?utf-8?B?VVNpUHp5VGhyUnV0b0VXaUFxOXRyc2orY2tOUGdFVytBQTVlR0luUjFMUHRy?=
 =?utf-8?B?MEJqSktOU1d4TUpzb3l5REJDWndWaDZ2S3FWVmVLVy9sSnBVeEFNbE9wRWFJ?=
 =?utf-8?B?MW92MjZRck56VngxUHZjMHlQTXo5RTV5ZW9acWltRi95djF6dFJOeFBweFVV?=
 =?utf-8?B?K1lReTRqVlAxRGlSUTJqd01JY0lpTzB3TlpUSjlmL3oxTUlLT1l5SWFPdXJ5?=
 =?utf-8?B?cnl5YVkydU52ZDNaTDNEcjVVaVMxRGQ4bDZmWVBWRFV2VnMyTzRjVXovNFd2?=
 =?utf-8?B?ZmFMTEs4eWNpNjVnSElRbitXY1ZYeDY4MmtjVVREbFZmQUFWQkZuRkRFeXUx?=
 =?utf-8?B?VENHSkpKYi9HcDFxenBQMGJIZGtPbWRzdkpydi9YWnFXYmY4bkJVekUyMG1P?=
 =?utf-8?B?cEdzT3VxRkMyK0tSdjdpZUY5dE5udzZjVVdRb09aZVFnUWVJUUpLc3RGUmtW?=
 =?utf-8?B?dnF4dWhJeW1RQ3BsYVlmMWw4M2ZTby85Sy9pdml0c1BQOEJmMENtL3JvUUI0?=
 =?utf-8?B?T0NRVzlhNE50YytQbVJRWFpFUmpHcEJRTlgvVVFsdUg3V1RIbyt1RTJ2SGtS?=
 =?utf-8?B?UDNJTlFxa0s3UWwvTmZHcVZKaVlrOUpGZkdYd1Y5Qy9ndy9COUoxMS9VOFFu?=
 =?utf-8?B?UWFsUkRkRnZVVHNSLy80UlJjZ0RNU2djYWlUaER5ME85a1NSTm9rdEFFdzVu?=
 =?utf-8?B?OW9UZzFLQWhCNTJ0YmE1S1RybWtCcTlQTit2NWdXRm4wL2NXeDNBVC9GNDJV?=
 =?utf-8?B?VitzeW9aQzJHK2hYemM1QWdaSnlDVjBocTQwOURkWEdjQzVvRXYyZUhVcThF?=
 =?utf-8?B?NVNsakJ1cGh4aVRIWU8rNnkvUHpyVUVQbWZ4UWdNdE1SeTZMMnY4UEs0cDQw?=
 =?utf-8?B?QW9vU0dZYzY3ZXNtbmVaTU9OTjl4YUx3V0FveWZKbVdUWFlkZDNCaE9TTXl2?=
 =?utf-8?B?RUlGYVBNQmt3bmJYUjluZjBDVXRyWDNKRXBsTWtpZHp1TzdWS3k5U2EySHpn?=
 =?utf-8?B?QWxGenRHcWYybVlEekJERUwrRTU5UXk1RGZCVlorNlNiUDM1TEorU1dRamRI?=
 =?utf-8?B?cUQ1d2tSS243NE9SVjNTc3BxaVN5OUR1ckFEVFBnRFk0UVhjMUZkMjRLQWdR?=
 =?utf-8?B?VEo1WDZBVDVuekpubXl1UzduTUFqTXdwcjQ0bTdkbEtHcFZPQS9jVmRyMWda?=
 =?utf-8?B?UDdnbzFTcDRJQTBFT1RWRnhuc0ZHa3AyUStxVVFSZHZuV1N2RVhaVk9PUTFx?=
 =?utf-8?B?SVk4dHZ4RW9VU3hhSzB1SGxhR2JSVUxVMnVpdFR1NC9FdVdyeUNFR0ZiSjRU?=
 =?utf-8?B?ZzQ5Zis2Rm1ka1NHRG53dVpscktCcnVtcnRLQnF3MkJrUG1ycGd4S0NZRkhZ?=
 =?utf-8?B?YmZKam11ZmZIQVA4K3NmR0RkRUZUekVpZWxOdjZGZ1hkQnJwL1kwVlJ0SWNT?=
 =?utf-8?Q?PePffg59tA+TUv8NjiOwNy0bafmACheqqfKvcqk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUlBU0N2MXZrc1dHMy9IN250QXN2c1dPOXlGMFRpajdGcjVmc1R5bDFFVkpI?=
 =?utf-8?B?QjlGU0VWcGpEczM2SE1XNTh0N1I2OUJ0eXlXby9qMDJSODE2czg5MHMxTTlH?=
 =?utf-8?B?cEU4RzR6d1ROdXJTZ2RxV1lEbm1POEFyMnEvdksrZzEwbzBLbWc0VmRZeito?=
 =?utf-8?B?WDA5OTAwa09sWmJHRU5Da1lCaTBFZHlmT2dvRFNsTnlJckZENzZlVmh3b2hF?=
 =?utf-8?B?SEk1Szg5WTYybGJQcUNEWTBmMDB2RHhYb0JkSHFKN0FnRnduQ0RrVG1kS1NG?=
 =?utf-8?B?UWd0OWNWTUw4Q29ncWxVSVg1TTE2ZGFiZStiL1NDbUQ2WjVRT1FNMHJBc004?=
 =?utf-8?B?RnZpVHJ4LzRvNkIzaFBpaWJGdGx0TUs3dGNIMEl6RTg1dFVwVCtWUnVyU3Rr?=
 =?utf-8?B?ZVUxMTB6UHhIZkovY2tiWHBnMlBNRVF1UEVsc0RLQVNJZ3orSmZmdS8wcVc4?=
 =?utf-8?B?ekxjSjV2VVlPR21CSXBZaXhmTmRFeFU4cXhlL2QwSjdZenMwQ09XbEZ5TERR?=
 =?utf-8?B?ODk4MVZ2ajR1V2lUYVFxdHJKemg1OTB4VXJycFVPSVVIWEljRERQNy8zRFVQ?=
 =?utf-8?B?RDVTT3UvVEc1R2JpOTQzRElVaWdjZ2xvSTNkMkJKMG1IMGU1MkIydzBISElK?=
 =?utf-8?B?UFVPU3R0VzVEK3lIdkN2QUxQVFJ6NnZzc2d0V3JHbXhsYnhkclBIYXlYOEQy?=
 =?utf-8?B?RkZKVGVFQThmZitCRzQzM2pNK2hVYWRHeTFLSTB0S3RjTFN1S0dsTlZxUERS?=
 =?utf-8?B?UHNxcUE5dG93SURoeUl1Y0lBcTNyeTRiQWJ6QVZIS2tVMW1mWXFjQUZ4L1l4?=
 =?utf-8?B?REFmNm52cFpCVzJaVlB5VmJMWEExWjJpeDdPTnBrSFc2cEp4b2ZrVTBVbzlJ?=
 =?utf-8?B?M2tsR081Nk9WT1VQbTNGNm9kcncvM2VnSGt2OEdjOFRTRXhvanplb0VJU2VJ?=
 =?utf-8?B?OElLaUdyT0VZaVVFNm1yb3ZpdElZQWxYNGdaZ2t2ZnJzaHJabGxqdFE3VGg2?=
 =?utf-8?B?dS91TnlxUSt3R2RGS2xCOEVPUlIyRGt4OGt0UVpDdTVRaFJJM25aNGNGMS9s?=
 =?utf-8?B?Mjd6cStiTXU3VHJBVWxqSlBaNmUrM3BNcCt6M2QxaTM4MDBwYlRFalBqRENy?=
 =?utf-8?B?Z3doYW9xVFRuYVN3eWNrNWxvalRlVW1mUzB0UHdDczhXTzhlQUNrL2s4YnJ0?=
 =?utf-8?B?R0swK2w0VUJDV0MzYkxjT29HZDBLRFdjWXdVZGNGN1JjTTFxQXhwMXNpQ3Er?=
 =?utf-8?B?Qnc3cTZxZXZFY0tkbDg0UFpYRndEUVFGb3U2VElUa3dSbWl2QXpFZ3crajhz?=
 =?utf-8?B?R1hiSkJFamRieTBHSjhmcElWZDJrcUtoZGdScEpCQXJZRENraGVzbjFmRnBF?=
 =?utf-8?B?dVNrZXlNa2RKaGFudVZFN2o4NnFsOHBEM29uMENpNG5FbDRPTFNKNFltTVdm?=
 =?utf-8?B?Mkd4RUdYOXVwZEFYOWkzcHNIU2ZXMDVkRVpSQXFFL1hicHJueUVjdUFxVmdC?=
 =?utf-8?B?UU4yOGVDdVlhMDJabGNUT21vdVVtYjEvek0zUmNhaVV4UWp1c05UZnpwVDNt?=
 =?utf-8?B?V1ZTN2NZaFZxbCtmeTJBUTdjck9lNDU5UGFUZmwza21rNi96SlJacy9JK1ZH?=
 =?utf-8?B?Uk9ldnYxZGVWbFRlWTRQYzBRZ1ZBaHNiVGpBbGtnUnBucUxKSWh1TW4xVzJE?=
 =?utf-8?B?aEFZNUE3NVhiaTg4UWQvb3FRNlVFZFdZa0RkT1NNcnk2Ynk0QkZudFRobEQ1?=
 =?utf-8?B?b0dyOU9OOGdJckVnbVVrMmdqbGtoTy9YSXJtSEpGeityM0ZPMTF3ckZ3eE1L?=
 =?utf-8?B?M0xUSjBId0EwVVZVcVFVdmpPdVpaSzI3RUJRRU5VWStndWo3VmhTQjFLK00w?=
 =?utf-8?B?V2s2ZHNjM1BtQkdBNFJ0aXRrSFdJNDVuTE1nUS8wS0kxNDZpWHNLcVZsc3di?=
 =?utf-8?B?aExyQTZNTlJNbU16dEs0UTBoMVZ5V2k4S2kvM0xTb0NaUmcyODBaeFk5c2Nt?=
 =?utf-8?B?MnEycktkRXRlSlRMQ0QvLzgrdys5eTc4bXFvenpVK2dVQlNYMVRiUWZPNHpC?=
 =?utf-8?B?WDFKbU5URHNOWFFBVDhtMWtCbFhmSDZnMmFENFk4SWk2ZHdDbHp2dnNpbFpq?=
 =?utf-8?Q?zRZw2wapllWBpVtmPmyUJoDwc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 640c9ec2-644a-4fd2-130a-08dcfc881038
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 04:20:50.1248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/O2asoRqc0wmXGoiRDhemAWctvijJ7UFObwQlC9JRgmyia3K0vuOn1QSkg/Zpc/OnOH9vRMJmwAIs5O3eKD5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5199
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 2024/9/30 17:26, Zhenzhong Duan wrote:
> Intel VT-d 3.0 introduces scalable mode, and it has a bunch of capabilities
> related to scalable mode translation, thus there are multiple combinations.
> 
> This vIOMMU implementation wants to simplify it with a new property "x-fls".
> When enabled in scalable mode, first stage translation also known as scalable
> modern mode is supported. When enabled in legacy mode, throw out error.
> 
> With scalable modern mode exposed to user, also accurate the pasid entry
> check in vtd_pe_type_check().
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Maybe a Suggested-by tag can help to understand where this idea comes. :)

> ---
>   hw/i386/intel_iommu_internal.h |  2 ++
>   hw/i386/intel_iommu.c          | 28 +++++++++++++++++++---------
>   2 files changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 2702edd27f..f13576d334 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -195,6 +195,7 @@
>   #define VTD_ECAP_PASID              (1ULL << 40)
>   #define VTD_ECAP_SMTS               (1ULL << 43)
>   #define VTD_ECAP_SLTS               (1ULL << 46)
> +#define VTD_ECAP_FLTS               (1ULL << 47)
>   
>   /* CAP_REG */
>   /* (offset >> 4) << 24 */
> @@ -211,6 +212,7 @@
>   #define VTD_CAP_SLLPS               ((1ULL << 34) | (1ULL << 35))
>   #define VTD_CAP_DRAIN_WRITE         (1ULL << 54)
>   #define VTD_CAP_DRAIN_READ          (1ULL << 55)
> +#define VTD_CAP_FS1GP               (1ULL << 56)
>   #define VTD_CAP_DRAIN               (VTD_CAP_DRAIN_READ | VTD_CAP_DRAIN_WRITE)
>   #define VTD_CAP_CM                  (1ULL << 7)
>   #define VTD_PASID_ID_SHIFT          20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 068a08f522..14578655e1 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -803,16 +803,18 @@ static inline bool vtd_is_fl_level_supported(IntelIOMMUState *s, uint32_t level)
>   }
>   
>   /* Return true if check passed, otherwise false */
> -static inline bool vtd_pe_type_check(X86IOMMUState *x86_iommu,
> -                                     VTDPASIDEntry *pe)
> +static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
>   {
>       switch (VTD_PE_GET_TYPE(pe)) {
> -    case VTD_SM_PASID_ENTRY_SLT:
> -        return true;
> -    case VTD_SM_PASID_ENTRY_PT:
> -        return x86_iommu->pt_supported;
>       case VTD_SM_PASID_ENTRY_FLT:
> +        return !!(s->ecap & VTD_ECAP_FLTS);
> +    case VTD_SM_PASID_ENTRY_SLT:
> +        return !!(s->ecap & VTD_ECAP_SLTS);
>       case VTD_SM_PASID_ENTRY_NESTED:
> +        /* Not support NESTED page table type yet */
> +        return false;
> +    case VTD_SM_PASID_ENTRY_PT:
> +        return !!(s->ecap & VTD_ECAP_PT);
>       default:
>           /* Unknown type */
>           return false;
> @@ -861,7 +863,6 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
>       uint8_t pgtt;
>       uint32_t index;
>       dma_addr_t entry_size;
> -    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
>   
>       index = VTD_PASID_TABLE_INDEX(pasid);
>       entry_size = VTD_PASID_ENTRY_SIZE;
> @@ -875,7 +876,7 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
>       }
>   
>       /* Do translation type check */
> -    if (!vtd_pe_type_check(x86_iommu, pe)) {
> +    if (!vtd_pe_type_check(s, pe)) {
>           return -VTD_FR_PASID_TABLE_ENTRY_INV;
>       }
>   
> @@ -3779,6 +3780,7 @@ static Property vtd_properties[] = {
>                         VTD_HOST_AW_AUTO),
>       DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
>       DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
> +    DEFINE_PROP_BOOL("x-fls", IntelIOMMUState, scalable_modern, FALSE),
>       DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),

a question: is there any requirement on the layout of this array? Should
new fields added in the end?

>       DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
>       DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
> @@ -4509,7 +4511,10 @@ static void vtd_cap_init(IntelIOMMUState *s)
>       }
>   
>       /* TODO: read cap/ecap from host to decide which cap to be exposed. */
> -    if (s->scalable_mode) {
> +    if (s->scalable_modern) {
> +        s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_FLTS;
> +        s->cap |= VTD_CAP_FS1GP;
> +    } else if (s->scalable_mode) {
>           s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
>       }
>   
> @@ -4683,6 +4688,11 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>           }
>       }
>   
> +    if (!s->scalable_mode && s->scalable_modern) {
> +        error_setg(errp, "Legacy mode: not support x-fls=on");
> +        return false;
> +    }
> +
>       if (s->aw_bits == VTD_HOST_AW_AUTO) {
>           if (s->scalable_modern) {
>               s->aw_bits = VTD_HOST_AW_48BIT;

-- 
Regards,
Yi Liu

