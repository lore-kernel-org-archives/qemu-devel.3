Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB761CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 11:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNU8u-0000Q0-AE; Thu, 14 May 2026 07:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wNU8t-0000Ps-J8
 for qemu-devel@nongnu.org; Thu, 14 May 2026 07:22:15 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wNU8r-0001jz-OR
 for qemu-devel@nongnu.org; Thu, 14 May 2026 07:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778757732; x=1810293732;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=l0qSfFFPq9/THOzJkdl7UtjdQwen/N6p/2isca9T3tw=;
 b=cV0vWj67P52XG8t5dmFHq/iq7ZB8cYJuY05CDmDjUFt3E84lwqhZ5MI1
 KORSzspzM8mfch66iPFTlCGsScvIrvDK9ajndmhl3kbY7OyD410qBwqlU
 IVkI0WTEN20VTKs2owz/B3CUMfoHKvKIfMDcEJFUl3JtjQXqC7RHIF1it
 WcZtbzJAL3N2yNhVY3095ihWk8lyvD/7miVB4XyEah6mHhZ+9E8JUl6qX
 yxayFc2cFuoiJEJgZ5G6CpRukpCWgtntgadJuyjbZwWAVPgO2e5CcXpc0
 Z9lrpMIbuZvYBkTk2TvAC0fRGMBaHZ7UhZfhnW06plMMGYnP0eIojtkCa w==;
X-CSE-ConnectionGUID: 71TydwuRQ1+ze6EbQ7LUKg==
X-CSE-MsgGUID: 8C3owP+wQi2Zg6w446E2gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="83312128"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="83312128"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 04:22:07 -0700
X-CSE-ConnectionGUID: tY7kG1N7QemUUr/aLYiDOg==
X-CSE-MsgGUID: c+kTEqf8TLK7v7Y4pU6Osg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="276440923"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 04:22:08 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 04:22:07 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 14 May 2026 04:22:07 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 04:22:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IC/xLd5Tga0XE9I5F3jFBE+xcf9PKUXv5rXxeyyKBadzhEi5H7gcmZKyDdRU/jiedZ6kLYE0vubMppAUQpHKXro5CvDBLtZZv6h7RZ5teTVezJJYSlUaxFI5beJXd29e9VgndKJcglRSaQ3+SGBW/9ty1zF/UseY6R0/dZSQbQqRnAa1HXlzPcpLO7seEaVie3IQaEgDJhQKuq6qeO7vg12IxaDwhfONkKDESqcoOteXeEGj+UlSKYuPdgJJ9XJ0VsIhII+U3hfdY5+CFsT8cySPTrtLaWLfPVm0InKv+d+s3RlWESvyCrJomtnqISHu/iDBgi6d37vNNWXeyB0SIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QB532FV/7bzAj0avZdEH4kn0fSZsxmvde2GDTYQgESM=;
 b=JFHmN1D1atyyZrC/Fnl/j/jXfFUtXx1RuxgYmwgPhFFtaVYDFdKPeOHa5phFdR5arX8PaxqlJCQhrWalraA8F7ZeWDGg7A1FR9KR5TJoUWLt8umJ/DITq1ovVB9CFNMFRatfcdvoSX2T6vNo61/Z+Er2kFoQNLl3Eza20WhH1O3MfiP/b+nIwLXKnwUxLoJL6tuG4Pn4t488FIoJEb6aU/9syMTmthNJniiTQ5IapEVmQwB6+DmpL8IAjBNhBhWoSSAuJZjWaM5+n207g/uO/D0fEu/DrMXr2c0cl60NVnkiSVtBz7hlXEtkS23QwnEc5YoCskCL7xeMqD1E5Ttg9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by CY8PR11MB7948.namprd11.prod.outlook.com (2603:10b6:930:7f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 11:22:04 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 11:22:04 +0000
Message-ID: <b95e30d8-b907-4edd-9f74-df183bf1a898@intel.com>
Date: Thu, 14 May 2026 19:30:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/15] intel_iommu: Rename pasid property to
 "pasid-bits" and define it as type uint8
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
 <20260509040819.1044702-6-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260509040819.1044702-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0024.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::13) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|CY8PR11MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: df97eced-0fef-4a6b-f286-08deb1ab0695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|42112799006|11063799003|4143699003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ke96kKVNH+Q6r1cBLh7GcIDzbq1PO0rdLeV6Mpv0JoFvQOzLVQ8rQW8WmGpLAn5UH6kMZvoiR/4gDp4TDW4c3QTbP9RCq11X94SA3pahaszrCVYKrpGO+sglpCy1p2cHIV3hwzjgT27epf+ZvafLyrEZh86R3fOQ59nAwx1IA9FBU1c+yKS+ZOt6woxBttc/FuOZfpZOzO3cvWOkAg2o3LZpZ8eLIazvk8mkYBJO6bAPGncDe/6QMHUCAXuAqW7/QB5DhnDcWP28i2OwyozCEVpT8CendEFv8HSuGC9my1DXe8NmLguSswTs1MAcfGGJ7X8mOtLSCON2M99+vBUgFyGtFPazu9m7KuH7m109wcWBGJsP5LYnr3nBQF4aziVumgtnJyZ2eIr0LaUFey09OCr5mDtwfxBfao0mtpKPGYLoKhlMJGx3m6rKDRp+YOhw64ajd4XpQLTvoRjTsYuHOu1+MEe6PuWnUN3ZDCO4OrdGcFDJZlzRr0m+8gM7T/aDUZquh9+3HmLT6VJK6egNBHcLj6bwvHrQ6N2mheM3Zxb9oatrhpsPBdM3MwSxyyIJJr0zaek3WDyPyPQa2tIB5x2kaR5iq4HV8EDspnmZtVhH4vmgPDCykc+NgUxgclJKRQEgWFlyMB7ykOXcUJnPSvsfmJfzGe9ffKVJBQ8H5IXYcGVKOFgZPrQvfqzzfoXa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(42112799006)(11063799003)(4143699003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVZ1QlVrZ1lYRFFGeUtBWVh5MkU3MXEvVVFoQ0FGZ1hCUFZXZzNYQmtZOXFN?=
 =?utf-8?B?OGZUKzFMRm0ydDhQcldLSmJpTUhDVU93VjdDQThBMXRMckN1MVE4RTdnWDFL?=
 =?utf-8?B?Uk9HT1ZkUUp4UmhXWkFoWVdHL2RtVVNVN3ZEWjlRRTFXdG9pemRTdE1XV0xL?=
 =?utf-8?B?TmZ0VERYZ3U3b2VDeVVLcFN0QXNMaHVDVEVrMWJPbDhkcVVYdFF0dVJqSVRO?=
 =?utf-8?B?R2pjQUtQckM3ejQvMnphSFUvZ3UrcFREQXowc1BSSTJEUTBuYVpDR3NUU282?=
 =?utf-8?B?WGs3QkVNMVdUZWVGd0ZJTWVQZFFpYUp5eDRiOHVGdlF5RWFIY3d1ZXd3bHh4?=
 =?utf-8?B?d05yb1hRTjU1anJwbGZHVnZZajV1L1pEOHBxN0FpUGsyNmpjbGY4WHpWejFz?=
 =?utf-8?B?WWo3dHU4ci9vT2VGUjVXZFJ1TFc2RWNuWW1RZmtBV3Y0S3NVSmxmUGF1QjN6?=
 =?utf-8?B?WmRYSUVFbnB4TjhkdmNReVRhQkFmOStDS1pVR2taYTQwbVBnUGlHamVEUllI?=
 =?utf-8?B?VldyM0tqNVE2dkZWQWZqbVFLOTh1Q0ZOVzgzejkzZVU5S0N3K0wyQ0pwTG1O?=
 =?utf-8?B?WTRYOVlZeU55aGx0ZWFwaGVXNWhwT1MyUy9vcnRYZ1RJK1prWG1mVGNJbU1V?=
 =?utf-8?B?T0k3QjBoNEg1U1NZMC9ZMEJhTVhaS3NWbURCaklaOGdRdGtvSUkxVG5JM3lp?=
 =?utf-8?B?eExRRGF5c3JTMS94eURJZlBuclArUVo0Y09obUtDbE45RlVscnRSQW1FNUZm?=
 =?utf-8?B?OHVwbVgyc3FaTjdYWFl1S0RTUk1mMWk2QUNmSUNhbW1BYWFaNS9GT0dFZEVV?=
 =?utf-8?B?ZGEvTzgrdUk2NUFPMStMU2cyS2ptWnd5VGwvWlBNR05qL0lBYmZqR2RoSXow?=
 =?utf-8?B?cENBNy84d3FEMFYyMERPV3BvcS9VVjdqeEE1TlBhNHFsQlp0V3FBQm95TzZx?=
 =?utf-8?B?M2wrU0FNanFYdUM1d0phTHB2SWVKV2RKVFN6RlVDVklTeC9zNEtTUkhONHQw?=
 =?utf-8?B?QTAxM0thMTJ5MnFVbkQ1enV3VzZ1QmJvRkxBRFdoMmNlZ3lQNXRkQkxUYXRI?=
 =?utf-8?B?ZlMwalRVTGhYWVlNd0NGbHRNVDgweXhMZG9JTnJicDNVVitRMzg4Q0NaQ0oz?=
 =?utf-8?B?QlMxc1B4YklQVkNobnJEOC9EUFduMVF4aHRLVDBhaDZhTTZJNkRHUElmQnlU?=
 =?utf-8?B?M2VtR3BseUtWV1VLUTlTZDNOeXFiSzMyZ0dyWTd2Zkx2NGVQZW9wamJQN3JG?=
 =?utf-8?B?bGIrWFJMbkh3T1hSOENFZk9IRjlVV3lrLzAvRDZjTW0rRGVLYS9rbVMrOWN1?=
 =?utf-8?B?dGRZQTZ5Z003SEtmdW81bXhkVllzUEk5K3ZRUCtMaGdWSWRYS083clV2bE90?=
 =?utf-8?B?bHJDZk5ucVdlVGpnVlFtaHE5RGs2WWFhdVA3Z1FONnIrUXdGc1pPMHlZRlJG?=
 =?utf-8?B?Mko5NGtiZDFRWWFVRi93SFc2TkhvaDQwRXRTVEpYOW1iQnlWTWlCSVh1Y3kv?=
 =?utf-8?B?TGUyMjZTemtjSnlUSUZjb0VUbkluTjhMZjNma2NKUWtBSWZDY00yWkRxSmli?=
 =?utf-8?B?cHJFc1hGd2h5QVNZYkZySjBYM0I5cUZYWjNaMVRCM05xaHVRZThKeEdBbExO?=
 =?utf-8?B?N3U1djlwNkk3amdqUTVGL2xVcEJSanZRZWptbG9VRW5HSHdJNmZsSDQ1bEZm?=
 =?utf-8?B?akFYOWtrNDhGNW9rUDc2ZDJxRFV4L2l4US9aU1RpYmtmZHBMWHpKSjc2Vm5B?=
 =?utf-8?B?ZFF3dlRlYk5CTDlxWTdINUlwcHYwb3lOY1I4eVdCa3B3ZXBUVkJ3NnpHc3R0?=
 =?utf-8?B?b0U4d2ptUWlSODBqUUluNFA3aFgzbXlMUExwVis2dlc4cEpkYzNPNEJJODBT?=
 =?utf-8?B?c1U4aHJTTWp1MFFCNHlBV1hVTlFyclRKN1V4WlpxOWxCNGZsNFBETDlYREJh?=
 =?utf-8?B?TjZ1cFBTRS8wZHp0S2x4TjdzTitKYTFPZ2prRmtXbWxtS3JGVU9rSkg4L1I1?=
 =?utf-8?B?ZDEweGR1VGUrT0lsbUorRTJVZTZzdXgvV2tEejlYOFR3VGFnZW1od3VVTWgr?=
 =?utf-8?B?U011TnZ2NWlKKzdobGdxK0JWeG81QnBRUTdRRmFpUXBVUjBnb3RTVE5Ud3Bq?=
 =?utf-8?B?U3VBOUdLcGQyanczNGMvcGVOSXhjQWMyRWsxbFlPdWkraG9CRU80UmJ1S1ZO?=
 =?utf-8?B?OEZyZkZCSHVPdmZUWnVmQTQyRWxTZWdLSjZYSFl0UW52L3RvT1VYQ3dwQjVJ?=
 =?utf-8?B?YzNMekczNFExN3dRY1c3YXlNNVVmMTRQRlhpMmdkTGNaZ1hsaE1WcFgvbUU3?=
 =?utf-8?B?SXNUTFZRK2k3WFlPZU9yTmZZUHNlU2JNc2o2ZDhqTC82ZTlqMS9rUT09?=
X-Exchange-RoutingPolicyChecked: TAE680znXf2qf9umirod0r7QyQXhBYtCximcURp1SlvtO3nxdxu1mHNy8XiUF8OqZefxp/O/L9zfsjvt7Moyc0FctkItz/YYOZyoHqe6HaIODm41HAB4JcahXmp42eWgLwpeta2Nl8vgXypg8N3ga7b0mmcilpqR1hzDpzmcy6z5KXl8u1+PjlHlR3l1sW2q93uRhGc2/F78pfdS0YMnUzkZnO+2UdzKyusIDJ5ohIM23+7nCwo/cIgf1N5ZHBjeqZQGQj7S1jkhWZcChO89kXsjhLCmkOTvaTcLqOBNZbQSSBHMDQlB/ae49oi4joZfbo73NSnxUze2N+MAU9ky+Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: df97eced-0fef-4a6b-f286-08deb1ab0695
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 11:22:04.4808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/Vjy47DhtLM4VhaNzIY5OQj7jDmlnaBB9318TWENT7KYGtpOfJp7KluNazPTtoMf73YuiAuQ2kNqD0n0tgH2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7948
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 5/9/26 12:07, Zhenzhong Duan wrote:
> 'x-pasid-mode' is a bool property, we need an extra 'pss' property to
> represent PASID size supported. Because there is no any device in QEMU
> supporting pasid capability yet, no guest could use the pasid feature
> until now, 'x-pasid-mode' takes no effect.
> 
> So instead of an extra 'pss' property we can use a single property of
> uint8 type and named 'pasid-bits' to represent if pasid is supported
> and the PASID bits size. A value of N > 0 means pasid is supported and
> N - 1 is the value in PSS field in ECAP register.
> 
> PASID bits size should also be no more than 20 bits according to PCI spec.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> ---

LGTM.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

>   hw/i386/intel_iommu_internal.h |  2 +-
>   include/hw/i386/intel_iommu.h  |  2 +-
>   hw/i386/intel_iommu.c          | 11 +++++++++--
>   3 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 11a53aa369..db4f186a3e 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -195,7 +195,7 @@
>   #define VTD_ECAP_MHMV               (15ULL << 20)
>   #define VTD_ECAP_SRS                (1ULL << 31)
>   #define VTD_ECAP_NWFS               (1ULL << 33)
> -#define VTD_ECAP_PSS                (7ULL << 35) /* limit: MemTxAttrs::pid */
> +#define VTD_ECAP_SET_PSS(x, v)      ((x)->ecap = deposit64((x)->ecap, 35, 5, v))
>   #define VTD_ECAP_PASID              (1ULL << 40)
>   #define VTD_ECAP_PDS                (1ULL << 42)
>   #define VTD_ECAP_SMTS               (1ULL << 43)
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index e44ce31841..95c76015e4 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -314,7 +314,7 @@ struct IntelIOMMUState {
>       bool intr_eime;                 /* Extended interrupt mode enabled */
>       OnOffAuto intr_eim;             /* Toggle for EIM cabability */
>       uint8_t aw_bits;                /* Host/IOVA address width (in bits) */
> -    bool pasid;                     /* Whether to support PASID */
> +    uint8_t pasid;                  /* PASID supported in bits, 0 if not */
>       bool fs1gp;                     /* First Stage 1-GByte Page Support */
>   
>       /* Transient Mapping, Reserved(0) since VTD spec revision 3.2 */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index b784c5f10a..cf275b496e 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4203,7 +4203,7 @@ static const Property vtd_properties[] = {
>       DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
>       DEFINE_PROP_BOOL("x-flts", IntelIOMMUState, fsts, FALSE),
>       DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
> -    DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
> +    DEFINE_PROP_UINT8("pasid-bits", IntelIOMMUState, pasid, 0),
>       DEFINE_PROP_BOOL("svm", IntelIOMMUState, svm, false),
>       DEFINE_PROP_BOOL("stale-tm", IntelIOMMUState, stale_tm, false),
>       DEFINE_PROP_BOOL("fs1gp", IntelIOMMUState, fs1gp, true),
> @@ -5045,7 +5045,8 @@ static void vtd_cap_init(IntelIOMMUState *s)
>       }
>   
>       if (s->pasid) {
> -        s->ecap |= VTD_ECAP_PASID | VTD_ECAP_PSS;
> +        VTD_ECAP_SET_PSS(s, s->pasid - 1);
> +        s->ecap |= VTD_ECAP_PASID;
>       }
>   }
>   
> @@ -5586,6 +5587,12 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>           return false;
>       }
>   
> +    if (s->pasid > PCI_EXT_CAP_PASID_MAX_WIDTH) {
> +        error_setg(errp, "PASID width %d exceeds Max PASID Width %d allowed "
> +                   "in PCI spec", s->pasid, PCI_EXT_CAP_PASID_MAX_WIDTH);
> +        return false;
> +    }
> +
>       if (s->svm) {
>           if (!x86_iommu->dt_supported) {
>               error_setg(errp, "Need to set device IOTLB for svm");


