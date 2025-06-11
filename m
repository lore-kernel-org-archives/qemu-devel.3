Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10275C61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 09:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPI4e-000400-4H; Wed, 11 Jun 2025 05:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uPI4c-0003zI-Gn
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 05:48:46 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uPI4Z-0003Sy-RG
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 05:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749635324; x=1781171324;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mFKTojqrKf5t5QiC07rg3fwVhCP86Sscd4ow6XwqzE0=;
 b=MqcKTvdVrUsPdfqal2dQP1hpSF6ba2tCRqBGcu6a6FR9bMVR7XARP9+m
 bzHy3C3u+wbwE7rfK5W99GzxMRYZg4mkUC7QHbHsxAAwq9Y1PmfmleqG1
 Rl41ddIgirx5STtXCKJ0VR/WMoA7P2x+xUVG8zBuvVFmm14IzSEd2w4Mp
 MBtolhKx9zEUnRMgvvvdZSEbGdQY4EReGAhMeGdw3Igv5g0B/DZqyMOjq
 TPQIxlH5y+WwHNe0aHPrfA2xzNR4Y4FBaR+UTbhQEsMg7dac/p97FMV5u
 ORZKGPlCuC/DCUiOQqrZmT4T9c/4pxskNoZRCd+9Z5WZgSGN0U1jFZ53M Q==;
X-CSE-ConnectionGUID: uKJR4rAXTzeoDiLOrzFgTQ==
X-CSE-MsgGUID: ZgUE/TPpTlKnKTIQylaBDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51909875"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="51909875"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2025 02:48:40 -0700
X-CSE-ConnectionGUID: v90eCU05R8SPUZ7kIehNvg==
X-CSE-MsgGUID: G6RJZ3rPTgi4tmfFiVpqwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="147136515"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2025 02:48:40 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 02:48:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 11 Jun 2025 02:48:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.57) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 02:48:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHvkLoV/wt2uAl+LcuMlDqaGwEEpPz6TqmMJjXVSaTXB4JtcbUC7BVyGVHpcDWg5eoVEop3RCfWKQPmhiDOeY8B8inQ6V4psQl52hRZv00F2dL0i8LUEph4JmWPsAOR9j3pUsJghVe2JErV3NvpxN8YZYFCikHxyhHIwr7+9zrTMJedXtnU6+loeLLgn7rqWkytbj+BzZbGXcJAPN9HQ7VPfaiHwD7+bmSBC3snuZKHlgb4JQWbzUKcLAoWWvdAoLzjId1oMsuX5k0RC1sjbswOh4hIn8zj0N0yJ/DyMUnyZBfNPRIPbz6spjnKwoKwgMU0KjN9zo1f3f2wgxK9q0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYKIUrtUvLCHtjkyrI9a5be2bbjZEd95x/GUk+4xJs8=;
 b=PhQ6S1iJV6fy6unQ1BFdKZsUvKSJffMnOslouEPKaLOt8rj5CAZDcNodaE0OSuXh8WpcufEHCF/7kJEnnRCMNknKh63iuzQaSHMkAe8FcS0WziVaBZqbgohXwQD/VP0nUMdF+gs3tQ3bC3am4AWHV52VtyZnbTpUAqRpdnUZjTv4ERKmJovchAaG7rFuoBv2eC1gUGrQt7SodeS95wSswSxBfd0EZAjP6lm30zBaRiQd7T7bBCjUTJCaMAf2Pg2zoWdBNMitvIijsPuDKCwMbxiThYG6M+iaxEQ60+SEjb4Imc39LtXzVgQH0PK5hxgbJiYi6pKAvMyGpI9VHaYqJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW4PR11MB5821.namprd11.prod.outlook.com (2603:10b6:303:184::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Wed, 11 Jun
 2025 09:48:10 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%7]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 09:48:10 +0000
Message-ID: <6bbc4632-1234-4f6f-a621-d5f8a1a27bcd@intel.com>
Date: Wed, 11 Jun 2025 17:54:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/15] intel_iommu: Introduce two helpers
 vtd_as_from/to_iommu_pasid_locked
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250606100416.346132-1-zhenzhong.duan@intel.com>
 <20250606100416.346132-6-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250606100416.346132-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0089.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::29) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW4PR11MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: cfbc2b66-8933-430f-cf69-08dda8cd12f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjZqd2VGbWVTaWI3STNwN0hreHZrWlBvTDk3dld3Tmt1TkZUTjQxaGNic0xT?=
 =?utf-8?B?VXpweExRTnRqazFtZVluSlRNdGwrSUdxcTFGK1VvNE95RW43T1hvV2lEVkNy?=
 =?utf-8?B?MFBuWjY0dE1palRtVWhXMEJPcFdHbTh4N2ZtdHdpM3RmRFBqYXIzR1QzaHh6?=
 =?utf-8?B?YTkxL1lIMzVsNjFWZWNDazlFNGlaM3RVSFVtbGUvbzN5Q3FtRW5RV2tLRnRV?=
 =?utf-8?B?THdCaTZVdWJhWU1CZ0MveEFoZE5YWUhJak03eUJ6RGlHUDRmVkxERDhhVEFO?=
 =?utf-8?B?T1pXbmNvUE5GLytIdlVCa3Jsazl6elZqcUIzQlFyaERORisrTzArR2JxVFhP?=
 =?utf-8?B?MVY0c1FqaFpvWDF1SmZlcU1zdXNIbExhMVNHb0JxZlVNVGFaR3MwU0h5eHdI?=
 =?utf-8?B?YzRoU2xYT2xiZDg2Q1ZkT1lXTXFaSllhaFNDd0NVbGRyeDcvejJPS3l3dU1W?=
 =?utf-8?B?dkNUZE81YjdrOHc1NzMrcTBteU02SE5zOVlNdHJxdFlleFhmTThuT2llK3ZI?=
 =?utf-8?B?S1lsZjFDQ0VMa3liMXl1MENLSnhyQll0SWNkb2dQcXJvTnZoK283TUZFRHRC?=
 =?utf-8?B?d2VKb0ptVGlwQUtiYXQ0ckxpcnQveU1rSnJEWU1HdXZMaFNuNDNTSXB1c3NK?=
 =?utf-8?B?UUFGTUZCaktnMTVlVk1RRXlEM2U5S2RaWFdzY1hJZ29QOFNzdUxnOURZQWd6?=
 =?utf-8?B?dzV1STJJSjJFMFBxUFlLUWIvUnZQc29OVllVMVBRV1N4MGNPOWRFUzA3b0VD?=
 =?utf-8?B?MGYrbngyWU1iSnVPSTZtb01nZVl1K0U1Q3V4YVZRSVJ4akt4K2tmY0I0U0RC?=
 =?utf-8?B?ME9qbFRueEZNN3AzbkN0VmlvWFVHREE1Szh2eHdmL3A3YzJCb3NVQUtLWjUr?=
 =?utf-8?B?VDBwdzY5Z0JCbkN6MURSbjFKS0ZJUlB4dm1oWlJjdzZZeHd1VU9sMG5vL0ZC?=
 =?utf-8?B?dlBLZFh3dS8zSkFyWVJXVXJVVVRaRnR1RHNjUVpiM3VsQk11c2g3WXZiMUFE?=
 =?utf-8?B?WktqS2xIS2l1SHlPbGYyU0hmcTJsSm55R0M4Y21tWDRXUk8vN0tBMnd0QXAy?=
 =?utf-8?B?VE01d3NiTmhPblZRTktnZFJoTXRyb0dMVnNlUDFySzJsVUJ6SWFVV2ZzNTVv?=
 =?utf-8?B?K0hZSktYNWZTa3U3bEpVU05qZVY5bjVIZHVhU2JQaTBzN0NJRm9TWEtKQ2xH?=
 =?utf-8?B?MEVoVkxscXh3OTJDdUk3ak9qdG0xblRJd1JOUXhNR2xvM0FtT3hCa0xiRllQ?=
 =?utf-8?B?WWJPQXBMa0JDbzc4V3JFekRFSkhmSUtrQ2pzTVZ2aTFGQTJDTzBvdkZPQnZy?=
 =?utf-8?B?T2xkeW9KOE94U28yUjNEOWhCbjJub2cvSnBUQnFaNlJiVEJmb001ZzZ2Qy9B?=
 =?utf-8?B?ZVBFbVJEbGVzZWZYQTNENGs1dnZjcEFCZTNqL2gwR0xvcXUyZHViTndRVmxB?=
 =?utf-8?B?Ny9QaFpZV0ZFWWE0TWVRZmFaSkZDZ2NSbEx1eTA4NWs4SHF1TVNaYWFaZ0tm?=
 =?utf-8?B?WnBEY3E3MkEwdW9GTWZwYXlsdDZQSHlxSnEzVmYvNEtQTjNHN3FNbTlOaDNQ?=
 =?utf-8?B?dnNEcXN4TEdObTN5WUNjaGJqV0ZoUmZtek1pU1hRQkthdUdRS0Z6ckdBQ29X?=
 =?utf-8?B?NjBKemtVS3NFVlNIWWNvZm5Rb1B0SkgrU3d1M280VUN1Mkt3dEJZa0FQaWwx?=
 =?utf-8?B?d0dKTTJCTVE2ZEhiSng2YmtpNmxOTEdsV2czK0F5TUR0VmQyUllzZmhYOVhn?=
 =?utf-8?B?TTVZRkZkOERQVlNWSk90cTdZeWFxK1Rya28wYmx4VnkyS3dZU1RDc1VQWGJP?=
 =?utf-8?B?UEZJeWpITlZxRC9xMjQwNDcwQkZCNnJOY3Bpb2NHT29acnVIeU1XTUwzNVRm?=
 =?utf-8?B?MXRDTDVscldXb0E3OWY2NW9VS0NxcjVqTldteFB1ZmxieExtUFJIaHMxMVBT?=
 =?utf-8?Q?DlCd3ysqem0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlBuVTdDOU9ER2RQNWNmV1JNNDhhWEVpRit3TmNmUHd4bUE4dWdtRjBacjlF?=
 =?utf-8?B?YSt4em43RUU0NnFDZFVwK3I2OVYxa04zWHBSUS8yemdyWVVNbTI0MnVWdVB2?=
 =?utf-8?B?cnRscStkYnNNRExQM1R6NGlRUUVzZ21BSTcvRldWZFpoMmE1S3pSMmJiSHFz?=
 =?utf-8?B?SlFMTGJTMVJjYXdzQlQvSzNYVThRWk9JSVh1MVRzZ0Zub096ZnRrcENYcWpp?=
 =?utf-8?B?V2VwbVRvUEk0d1o4QUhmcWlvTFl1cENOWFhEaE5VdmY1eDBhMXMzOUc2VEl1?=
 =?utf-8?B?QmZVbC95anFhYzFucXlhT0FNU1ZFUEh5M1hBeVA0bnFmMU45VThsUWpqQmRW?=
 =?utf-8?B?Y3pDOGliSVYxbWNWaWJGblMzR3diS2RRNk5qcWtScVIyekhTSkJFUTZkQ011?=
 =?utf-8?B?UXhibkFia1loUldzRHdrOFFzcmkzMXQvdi9SNGFwZGVRakhhNld5Nm9uSVh5?=
 =?utf-8?B?UzhsUWlQaWluaVM0bzRuVTd6eVhvOW1qejBmZEFFUHVJZnM0cStrZ1N0OGdw?=
 =?utf-8?B?WUUzWWRHdzRCZmR4TXY2SFVqbmZxK3luOWZveWdWd2k3SjdrcTRnL0lxdFBQ?=
 =?utf-8?B?cnUwM1VCRVRoUzBhTlIzQWtmOGhxd20rRHdBaGVUZmxwajZ3TzIvd0grOStk?=
 =?utf-8?B?eE1UazRQUlYwdFJzdDIyNGtKaGVNWlFzYjRCdUpSMGJKRENGTnJpVllvM2Zr?=
 =?utf-8?B?S1FkaUdWcnpoYWIzeXQyOVNkQjMwQUdZakVvWHo0MnRWQm9ISXo5VFRmOUI5?=
 =?utf-8?B?WVI1R2JZUzE1R1doaE9HZUQ2SWs0UWRLR21pdTJnRmRLRm9kaFJSd2dROVdU?=
 =?utf-8?B?WXdqMWt1VmVqdkpzdzJSa2wyd2tyRnVqVXRBdmlEeE9GSStBbDQ2MWp6MGt3?=
 =?utf-8?B?b2taRXlNanFIYnlFSW1CTmgxSTdxOFM3VzZ2TVJhRittZkdweTRCako5R1My?=
 =?utf-8?B?cklTczR1SXk1UXJEZjVGWUhlLzNEMTlLemppOEs2VUQxWVRTNWtVQkt0TENr?=
 =?utf-8?B?eVlJcUpkb0dhcHZMdGJadEJvZ1NYblduNHJtVzMrMk5BSVpuR00xMXoyYmh2?=
 =?utf-8?B?aWRha0NlSHFqa3dIdHBoNkdiamxEVkw0YjZPZGtTTmFHMExXcnMzRzNyeUJ4?=
 =?utf-8?B?VE9YS25hSG53Z0oxbDdmZE1FdDN1aWxtRUhWOVVXWkxhajkvbGM3OFRybkQ3?=
 =?utf-8?B?MkNwb25QU2k4Z05JM2dSYk1wejZsYUtNQmhkcGpFUlNVVUFQQ29iSjhNZkZ6?=
 =?utf-8?B?bi8rKzZCK1NCU1o0ZDR6bnJwOWZ4bWJGZC9HQXJKZVlzODNrWEE3dUJzek1W?=
 =?utf-8?B?L0lQbXBDMUgzdFZRcW1USk1hMi9Wc2hQWURteHZZRGhuUEUrZWxtMHA1ODB5?=
 =?utf-8?B?c3pMck9jdGdDMUR3bVFCbjFYRkRCUWk0bCtVd0wyUVBBYVBiTS9IbWhIc2hX?=
 =?utf-8?B?N21qVmhyRldEUUVmSHFqbGpkNTU4aHZGOHBHUHZaY0huMUc4WFNHd2xaRklT?=
 =?utf-8?B?Qk1hZGdxSGx3YjdUUkNoejhGUXBmZkxuYU1PeVMzbFo3Qk8zUnFOUGRRUnRl?=
 =?utf-8?B?S3FrS20rQ2RueDdiOWlMTkNVaFh3eFg5OXVTdDg5ZTcvV3BUMFRpZWdtZ2l3?=
 =?utf-8?B?LytmbFJBNm5nOW94U1JvOSs2ZUlYcE9Zdk1La3QwSGhXbHc0RnhnNEdlZUgv?=
 =?utf-8?B?TmJvc01zMDhOZ08wcDFxdFo2RExreXh2ZUpWWUtSRDE5VHpqNkoxdU9VLzhn?=
 =?utf-8?B?SzhoYXUxRDE3ZDFtNU1SeTdCN1VzMm94N3lMOStIRjVEUkFmSUgzL1dOcERq?=
 =?utf-8?B?emZNdVJYeW5BZDB4Y1JXVm5KQkIwMXRHd1k4ZWNOSnM1bEN2a0RURHlWaUFv?=
 =?utf-8?B?YzVBaDNlcmtaQ2RoaERseS80Mlg1Skg0YVgyRjhLQVdRcGsvZ1pTU3p2R2tE?=
 =?utf-8?B?aWZ4SDFYWVAzM2FLL1ZxNzVtNmFRbXdnU0diRHZSV1BMTjhNNFJicmVjc0tk?=
 =?utf-8?B?ZmFkQysrQk0zMnAwWERXN3NRS2VjT0JCYmJDeWF6M0JhaTJsZEFranZjQXFx?=
 =?utf-8?B?VHZ2Rys4R2hWSnNEY0ZxeXVUcHlweVJoT2lxTWpieEZ4ZWRzUElzL3pyb2NT?=
 =?utf-8?Q?qE0F3S+a3p111VQLWbxO3cuGI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbc2b66-8933-430f-cf69-08dda8cd12f1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 09:48:09.9716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Qoo5rk56IiaA/CrJHFwmgAltR2gHxrOm5Ifr7uU6Ea+9/AIGZMa6b54e2TOvTE9f+Lr1gqenH9Q+StUOj2YXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5821
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
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

On 2025/6/6 18:04, Zhenzhong Duan wrote:
> We already have vtd_find_add_as() to find an AS from BDF+pasid, but this
> pasid is passed from PCI subsystem. PCI device supports two request types,
> Requests-without-PASID and Requests-with-PASID. Requests-without-PASID
> doesn't include a PASID TLP prefix, IOMMU fetches rid_pasid from context
> entry and use it as IOMMU's pasid to index pasid table.

When reading the first line, it makes me thinking why need the helpers
since there is already a helper to find. The key is the later part. We need
to translate the PCI_NO_PASID to ridpasid.

> So we need to translate between PCI's pasid and IOMMU's pasid specially
> for Requests-without-PASID, e.g., PCI_NO_PASID(-1) <-> rid_pasid.
> For Requests-with-PASID, PCI's pasid and IOMMU's pasid are same value.
> 
> vtd_as_from_iommu_pasid_locked() translates from BDF+iommu_pasid to vtd_as
> which contains PCI's pasid vtd_as->pasid.
> 
> vtd_as_to_iommu_pasid_locked() translates from BDF+vtd_as->pasid to iommu_pasid.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu.c | 50 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 50 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 796b71605c..112e09e305 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1617,6 +1617,56 @@ static int vtd_as_to_context_entry(VTDAddressSpace *vtd_as, VTDContextEntry *ce)
>       }
>   }
>   
> +static inline int vtd_as_to_iommu_pasid_locked(VTDAddressSpace *vtd_as,
> +                                               uint32_t *pasid)
> +{
> +    VTDContextEntry ce;
> +    int ret;
> +
> +    ret = vtd_as_to_context_entry(vtd_as, &ce);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    /* Translate to iommu pasid if PCI_NO_PASID */
> +    if (vtd_as->pasid == PCI_NO_PASID) {
> +        *pasid = VTD_CE_GET_RID2PASID(&ce);
> +    } else {
> +        *pasid = vtd_as->pasid;
> +    }
> +
> +    return 0;
> +}
> +
> +static gboolean vtd_find_as_by_sid_and_iommu_pasid(gpointer key, gpointer value,
> +                                                   gpointer user_data)
> +{
> +    VTDAddressSpace *vtd_as = (VTDAddressSpace *)value;
> +    struct vtd_as_raw_key *target = (struct vtd_as_raw_key *)user_data;
> +    uint16_t sid = PCI_BUILD_BDF(pci_bus_num(vtd_as->bus), vtd_as->devfn);
> +    uint32_t pasid;
> +
> +    if (vtd_as_to_iommu_pasid_locked(vtd_as, &pasid)) {
> +        return false;
> +    }
> +
> +    return (pasid == target->pasid) && (sid == target->sid);
> +}
> +
> +/* Translate iommu pasid to vtd_as */
> +static inline
> +VTDAddressSpace *vtd_as_from_iommu_pasid_locked(IntelIOMMUState *s,
> +                                                uint16_t sid, uint32_t pasid)
> +{
> +    struct vtd_as_raw_key key = {
> +        .sid = sid,
> +        .pasid = pasid
> +    };
> +
> +    return g_hash_table_find(s->vtd_address_spaces,
> +                             vtd_find_as_by_sid_and_iommu_pasid, &key);
> +}
> +
>   static int vtd_sync_shadow_page_hook(const IOMMUTLBEvent *event,
>                                        void *private)
>   {

-- 
Regards,
Yi Liu

