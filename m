Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716BFCD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 11:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNU4c-0005Qq-2E; Thu, 14 May 2026 07:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wNU4X-0005Qa-M5
 for qemu-devel@nongnu.org; Thu, 14 May 2026 07:17:45 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wNU4W-00088M-1A
 for qemu-devel@nongnu.org; Thu, 14 May 2026 07:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778757464; x=1810293464;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BGwAFm6ZWJUZ1xqrSELWgBZf8zHQz+YFvB5KtRc92Ps=;
 b=mX4GpDJfIWxZcXjjZ7nw2z4NPVe3JGw8D/1PoeniPQF9DsoqjEOrbuH/
 39W/+vcELrO5Eo3RKx82byI6HfpYFiiuk66fm4SRFWF0BoBiuj005/Ki+
 cHLYK+8Aymj/dyMOK/lP3ez084O659fo4WdpK8u+KL6ziix938UMw0d5k
 psZLdi/pxgkDVW3sqSWTxnoz/S5qjAeC9uhuZ3KvPScElSEdzmGNsX27T
 5q/bOWbXUENx2SitJyS7JzTusmtFl3V+fRTXCQbgk1430eKYmmichkVg9
 I0iBMCQONodM3/1o25nML9slp11acKosplMISo4CRVdHAoS1xFZ82Y/Xf Q==;
X-CSE-ConnectionGUID: WHZOCu7USZS6iZHUxxG1WQ==
X-CSE-MsgGUID: Ty8kTU9kRTi8F+/IV33TYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="102367588"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="102367588"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 04:17:42 -0700
X-CSE-ConnectionGUID: YwjvzDpXR5CWmsLmPqM7mQ==
X-CSE-MsgGUID: DnfP0OQTRCOrrsC8V44axg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="240194800"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 04:17:42 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 04:17:41 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 14 May 2026 04:17:41 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.67) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 04:17:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LumLLsFyny2VV4LlDFbWUnaMrU2MbqQIurPtGBlEDIcAftvNZ3iOKHbBlB5n5vBYomN2kjLF6xkevKl1dWv9sgRZ/yatVJNQH+2QcXNKMnVs1Vk7Cem7b9zOHu+q7rvLxtBUQ6qy8xv0Acdcy7zMGL8kWdTmQb6Tllr48+0mFoND759zTly6CpuK7fJEXMdluIH1hgxpPCN1jjDzeLnJAQglgtvso+mr+2hLtR5HGX5Y//6pZgUDD5PDE2hhcvede0J7GBqryZSA9OBtVXmcDBU+M0pBWGUAOcTZSeNYGjO92lAgLUz54syZrhX6IQjqQia/cOYrLXgHx1CfKtKOKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1/TwTJnaW+auYcMQyoF2ouqle6++8+Jmtwt0UqmSbQ=;
 b=fO4YFgP+OlN1v+QNMl0JvRKd6C38oIaBAWphwyhLeSIyk+sjozP36DxWM5F+DZYAMraGfpEeNirn8XNmDY2V9d+A96tNkvpm19cU6jD8jSkiu1m539SOKbPydnNJhTw/IdidLJVUXlh6uBPTabiU2En1F6OMowneXNm7iLFXYSsd80/buj9Ylo2JzKFp73DbhgIHiQeaIj6+18bQT7i5oKHtCBnB7eeWZz1sCmDm7ATNJLVQ6UUQBoCCrFVlJxrXhQkvPvrzl7aJmpyMsDnUOXaxdGq6XK6rI/8+I7DCYNx7v1JhOxuyUOB59txRZAda33zvfFwxcukF3GpBytrJow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by EAYPR11MB9588.namprd11.prod.outlook.com (2603:10b6:303:2c2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 11:17:38 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 11:17:38 +0000
Message-ID: <72d631cf-bc98-414c-826b-a39f947d0efc@intel.com>
Date: Thu, 14 May 2026 19:25:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/15] intel_iommu: Expose flag
 VIOMMU_FLAG_PASID_SUPPORTED and VIOMMU_FLAG_WANT_PASID_ATTACH
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
 <20260509040819.1044702-16-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260509040819.1044702-16-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0030.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::15) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|EAYPR11MB9588:EE_
X-MS-Office365-Filtering-Correlation-Id: 419196cf-3691-437d-6cb1-08deb1aa6819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|366016|7416014|376014|11063799003|4143699003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zooA7NKxqWW5dOxyUSn3ZI+UhSnTMqxgghyLPLdG1KN2ZMRZBPFQ0DimomZ9oyxdFuG7BYxDqd/VZimWgT/BaXF/y7OxtJYjg0QjJWQR+DrbLB+IT20Yi/gxC7m58ET4HhpIJ/Rc83mtAuRXdT8R3WKhCEltVR7PTdX2PNPWJuh3oJSXZNXpxODlvI93fZOqaaOF6+t9CC0GoXgyXvYpsuF0cFi3uruo3+vgo29XATfPJmvgvFjs70E1GoQ2b97TnCYZdOgFHyfHMNSgTRYXK88iRfgu44JUlcgi/hNpxwQq85l2k8HsdFzToaf9Og+I04GK5mE40jIH7JmDlLkLVfEDPNP1FVMwXmu2mseO3K0cDmwHxquEyFSpS6SIvpwi1tV1WGEBnPcVvLScw/4wk7Neb6L0H5wAJhlGkd5qYf3aoKZ10CzDAQB/mga2Of749FZhVNgwj4SP5mObRtveEsK4EJi3HD91RmsoVdzdpB6II6OkM0wsHAHHrlTarslHSMqmz+KciIHX/8/FOpWPb5B0w162p5q9pOuQ3rN5+0WAux05SAMVqkoeF4y2Oln0FbuJH0wIiqbsXZeBWm9JtPCP1cq/5zbCRwLc/ktm/DYD3ZDWNLBIcexw5S25vU/pieZ5Op/oKOtZRQbENjsMh98HMm/WJMpqiOuoYPcc1V9zZ6/J5vnhL++UClEiC68d
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(366016)(7416014)(376014)(11063799003)(4143699003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1RpN09SbkZsZ3NxbmNpVmlqOGlEVk00UWNFMUhBWm1BUm9Ob1BGelVGSkhp?=
 =?utf-8?B?b0JtalUrUWJpZUFkaExPdzdxQWtadGVNTG5ld2VhdVJGM1lzVzRqWVN0MGNB?=
 =?utf-8?B?WExHYlhZaGphUWdBMHZTNlZJS3IwRDRGNHRxLzk5T3VDcmZyYnM5SCt1SE1C?=
 =?utf-8?B?QmRXQXFNRUE0aXR2ZEZOWk4yajMxM3pQdFRadXYrZy9WMWJMeXpYbU5POE1S?=
 =?utf-8?B?R08xejJhK2NFTmFWQ0hPV2dkU3gvUGdrVERoWjk3OUxmZzVlemYxaFdoWjBz?=
 =?utf-8?B?cldNNW94K0N6WDdQeTVvTTNzVFFtMytPV3VEMUJzZmpjcGRjZEFQd3V6OVVF?=
 =?utf-8?B?emMrOXRLWmgzVjF2OHBqMHlTWElnd0w2dVNvd0tzQmVMTkZwZGJBbmxQbGVa?=
 =?utf-8?B?dzBvRUd2Mll5dXNMZmU2TkYwWFpMOWF2dnVadnNlZW9YN2ZTWklwRGpST2gw?=
 =?utf-8?B?MWJYUUd3Zk5RYzJBdzgxRll3aVN2VFI5WitxVFVJRWFCRXd4a2Y3MnZGSFNP?=
 =?utf-8?B?c3k2a2FLRWxFNHFBV05OS2pnVXlxcmcyWW1tRDFLMTNEZUMzZHR2S1VUM0VS?=
 =?utf-8?B?eEpWN2VlTUpSOU1xZXE3cHo1bStjTlBybWh3Syt5ZXBxeTJBREYwb282NCtn?=
 =?utf-8?B?Zm9aZHhFMmlNN2drTFNxQUdYaWhZN2FnaHYyNkRwOURxWWloQlp6aGFNMUVL?=
 =?utf-8?B?ZlgwUkdZbUFTN3dsamhLRDdyZjNMRnhFQ1hoZHZUSS9IYXFOcTRpOEZWZ1d1?=
 =?utf-8?B?QnJvenR4WU5UaTA0cnJkYUc5VXNyaVZzMGNBZ0U1b2FqcE4xM3hSTnhHZElG?=
 =?utf-8?B?ZzFGbUg2SjQvM2pXazZ5aDFLbzZDaGhmQjM0bUU3Mnl0bnhZdGRham41QUtv?=
 =?utf-8?B?bHFhc3luR21oS212akE0aDBwZkpLZSthMytCMzRPU0ZrbGZwRU9SU1BjaGxR?=
 =?utf-8?B?Sng3eU5LdjFab0lJdFNScmREUHdqbGpkMTZPMW1kc0tldDVOdkMyVTJIbHBU?=
 =?utf-8?B?ZHFlMTBtajZ6VGVLMDlMbUF2eXdGZkl4eVZ4WUV4S1ltODB2ZFNYdy81Q2lL?=
 =?utf-8?B?QlVQWFl2eEo1V2VUQ0d0MEQyT0c0WnQ4alM5OEoxWG4yOHZLRlMxMlZ6T1Y0?=
 =?utf-8?B?ZE5RUFB3SVJvNWtUU0lPbE93RjZhdE5mTWF2U1ExdFdQRzJ2bmFNZ1UxcDIw?=
 =?utf-8?B?STBzcC8rajJxdmpLNDJBcU9lU2xOeXpDQ3NsTytJcTNyMU9lME5JUnlJR0o1?=
 =?utf-8?B?V3p6VkJUd1BvUy9lYlNUM29acVJuQUlESnlMMFcvSnBZQjhkem01cTI1UjVl?=
 =?utf-8?B?N25EZ29tQk9kL2Z5anhoZUlHcVExMEJkU090RmdCVnFaVnErZUphZmhjaXp1?=
 =?utf-8?B?dWNPNEhtVlZxM1lpZDVPemhVUFE4TlNmbzExeDh6SjBoemZWRGxmb3g0emJY?=
 =?utf-8?B?RkFqc2g4Vk91QlpLNDRHQWYySXRHWEpjcFRKbEM1aFJMQkErd0FvbTJjcmNs?=
 =?utf-8?B?bjFwT3doY0YvUzF5WjEwcXFMVWE4dnBxTjUyYmRjUGV1amxlL3ZLWTlsSEI4?=
 =?utf-8?B?ZDJGZWlwWFg0dkhTdWcycG84amJ6MTBaOVNjcFQ5S0M5bk5IWGhvOHIvT3hw?=
 =?utf-8?B?N2JuL2w4WGpvaTU2eGRmdHhuUjVRU0N3NnI1cUZoSk90S3ZIVldkeUFseDZM?=
 =?utf-8?B?QmhTd0ZPaW9PSmkrb0dEa20vWlVSMUMzTzVpNGxUVmNtb0tSdnpEcWNHOHJn?=
 =?utf-8?B?WGttOU1sZ3VUd3V5QndNOUpQc3VFYkRqVStaaFdTVndpdEI3UGlIb3FjWTdr?=
 =?utf-8?B?bWZIajFMWHNCcy9nRTgrUmV1WDdLNDZ2eGNudi90VlhpdnpGbHU0TWh1cFpB?=
 =?utf-8?B?WWZ2dUJxOE93TGpudjBiMlc2NXJKek1mN2lJWmR1VnRTNkcxQlFjMGw3TUtU?=
 =?utf-8?B?d0haYjVSUW9EVHJPVlRDbzdjdUxLSzE0R0R3WlpibkJIVERRZFVZVFlVbVlF?=
 =?utf-8?B?dHRBNkE3SXQxaHNnZ0l3UFFxYUp3N1VzMDg5OXd0ZXRSRlRTOUJlY0VTNVRM?=
 =?utf-8?B?RWNTY2VzNno1bGd1aXl4SThhR1I3c0U1TThiYU51UCtnaDk4cm44L1lqVlJh?=
 =?utf-8?B?NlIyRk9lWHJ0SFdhN2Fkek0yMXNFOEpReis3dzF4K3RybE1HU3h1THJzVFdO?=
 =?utf-8?B?aHpzczVhcTVxaGV4TE8rdXFreHpEZE9UVENnWDV1dDdXdFp4RWhlcW83VUZD?=
 =?utf-8?B?aDlYYmoyQkpXNFlrSEYzSmpXMUNhVzNHeGtEellpb0dCWHJSWDJ3SUNDWDh3?=
 =?utf-8?B?NnpzVXBsVmVvTzFZbnd4QnRxZHExQ3pRWmppNGxjWFRNd3ljODdldz09?=
X-Exchange-RoutingPolicyChecked: hamHildYehzweu5SwPQDnkIxmwrjPmhrAFHj9v+xO9zdqnrQPtIGnZcRLlu+EqUqOrH/cmH1GSfYLKZ+7P5HKFHOqt1ee3y0Yt2S34Ni1/KglnPNgy9ziYFtFX6rK8ThIRL8QIa4Dxo/vBbhTcbqyuVgtKmQ9fiUgul4b9SlZNT6DBgdOe/8Sc3z5RecmcUGaB1HBUAY63BGAIVnF/aynVLrPHpKzK7spjKt7XTXjbmtnHoTaU4C/rqJMmo0OikDtsAFh/JB2H3mOti3cFQBWUtyeKKNStm1xZQnYSaV/bvcuYW18w0Z11SuR3FIVRVr9P+Wo2mPzw6SqqSb+9odsA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 419196cf-3691-437d-6cb1-08deb1aa6819
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 11:17:38.5870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfEZHGM0mBCQVqkBepl40wsDZ80km0Nq9PvtiNm37v5qHr7faXMwIiSyR2Oez/9ISif8iGHZr4Vk1oDoJxahDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR11MB9588
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9; envelope-from=yi.l.liu@intel.com;
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

On 5/9/26 12:08, Zhenzhong Duan wrote:
> VFIO device will check flag VIOMMU_FLAG_PASID_SUPPORTED and expose PASID
> capability, also check VIOMMU_FLAG_WANT_PASID_ATTACH to enable pasid
> attachment, without those guest could not enable PASID of this device even
> if vIOMMU's pasid is configured.
> 
> We don't expose the two flags when first stage is not configured as we

nit: s/first stage/fist stage translation/

> don't support shadow page table on a PASID.
> 
> This is the final knob to enable PASID.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> ---
>   hw/i386/intel_iommu.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 6067069e02..70546e91d4 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4788,6 +4788,11 @@ static uint64_t vtd_get_viommu_flags(void *opaque)
>       if (s->fsts) {
>           flags = VIOMMU_FLAG_WANT_NESTING_PARENT |
>                   VIOMMU_FLAG_WANT_NESTING_DIRTY_TRACKING;
> +
> +        if (s->pasid) {
> +            flags |= VIOMMU_FLAG_PASID_SUPPORTED |
> +                     VIOMMU_FLAG_WANT_PASID_ATTACH;
> +        }
>       }
>   
>       return flags;

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

