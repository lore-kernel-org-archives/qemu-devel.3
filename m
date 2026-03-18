Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC94103E160
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 11:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2pO5-0006PA-Sj; Wed, 18 Mar 2026 07:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w2pNv-0006Nq-SP
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 07:48:24 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w2pNq-0008Mg-Vb
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 07:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773834499; x=1805370499;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cLQY3KDyh1D0dMm9QFV6zORjCVyC1jC3P+S3AMDwtd8=;
 b=TJFSzzi3bNlRt+RMhZTsONWojNgIaM2tuYQIV5xQwerpugz2hLfVZRyZ
 ERYX8Tp7v3EdnRBGnDjdENbi+qCjo5sKJShg2ujDzC16KB2d4U0skHImD
 KeM736vF/ad2KWHYxUCx5E0NlO3YCw7byqshIox/dSUNG078qYPSkvfJg
 jxyo3K/PYab+F17ujWfG7YhQj19cb9eC5j9ZHfiUOoHB8BlgiUAOU0Rap
 SUOz5Kud+BpwN1nTgxjtbMavf+HEvQqRWZqcbgGNr/DDQyj1I63xdU54J
 PtLAmqof2XX+TeK5D17IHMkkEbDttooHFgqiu4OaseeHEFaBCTLUJII1b g==;
X-CSE-ConnectionGUID: xRZ08MiDSC6LnV0kQj1oWQ==
X-CSE-MsgGUID: gNPEMxkbTJWHq3Tbti9dyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74584809"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="74584809"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 04:48:13 -0700
X-CSE-ConnectionGUID: seGy6n63QDSnyT7Kdflcww==
X-CSE-MsgGUID: +tvqhgIMRZSwBseQRZnwMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="227072777"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 04:48:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 04:48:13 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 04:48:13 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 04:48:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkOKJIfKd3uEYt52s/PlZvVG8/UI6Q3+BO6XPDpj9DTLELXwL67c9RgdSNzGsK4HHd9rowKptkWgU1Qm2K5rp38PkrZbWemKSYoNorUHOhmx3ivEspZsx7EVytFHDZCiCa+hpDwAlLIeUxkhWVQpudZS3IrpuFaTGshl2bjvinm4iZKcYz0K/dN0TpWUb7jTrTX7EZEWamLZrL9hlvvxUT2/ljfFJoIOsSoTYGPCQTHL2zitaxVpSEmzeJv3UnPrLfwzefVmqsHpFccJS4MzC7AmPwuQkDC4aOdMuLEJXDLXWIMduPqm+5DPusW+uYH6s1EJMCBPMDuybaeRQZenJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3fj1MAA/rjm3yO4Agyk7P3LBjrziBhQ47D0s9ocgX0=;
 b=hSs42qyYQCAqBt5MmFxGWK/ZNelxNUIodPerzi2yvsPVrpmscKJhzCb718aoEkMy4yh7otQnTF+cRWPLnDqww04BlmLlFAlmDLeZ3sxq9xyv2jn5+P0tLGYFfkdm/YFSMWt+IIPyGU50G9gvd4nhIxX4e0T26xQq72ARI9gHoUU+ft7moz79Mv1zeV/jq9hDhWbVC/QzAVQ/xx3MDT/C+EnvcCgv5ADmcnLDHxm7IGd7JUCERZKPGd/C/pTxp8bw/JCyP0L/xHCT6AsDSjXC1Yy3XTqwwmZd2HnW3Ly+fUeW6tff3eoolUlTQNu0wM0A+hPr/nQRX/w9EvUoTUUZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by DM4PR11MB7206.namprd11.prod.outlook.com (2603:10b6:8:112::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 11:48:08 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 11:48:08 +0000
Message-ID: <4eca81a6-c32f-432f-bdcc-fdb6fa6425b4@intel.com>
Date: Wed, 18 Mar 2026 19:55:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/13] vfio/iommufd: Extend attach/detach_hwpt callback
 implementations with pasid
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-2-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260306034409.184873-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0110.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::14) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|DM4PR11MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: 07cc03ef-7f19-4bca-fe28-08de84e43925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|42112799006|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0kjkBq2z3Ch1QQD6JIBpWQV+qLtBhvBQHFicRXGlb4zb+NcRgMLa0fcLS4RcsPqLw1U8T7oRvBXPj70GvNE3zhb7hQ7GCtu2UH1ZLNzjS5+OaHxIIJoO/aIpC4mhR4IpdvxDXMjEf4vYln6cV8nVqODwEMRiPqxLwkKNwkhTL/65a3cEvZyRPX5PEcpl7pRWOipjEb2lqu2+UiC9dmoHq8hTJGHFcg1Yn7LsLH150P1ZCa1FMYwrsHBcdygYNjWPeWNIOwZYvE+qnU+FVPGbI1ZpL3hQI1AewC8QAnEctaarL5JWxBSz+SVDoULYZcC2QDblEpckGaHVVpcfGrKBSb7cBILX/JeHbDc3obFDig/VBa3LWtMDfDHYtU5QwooCC5O7AEEAQxc0mWJuuOfTzKaPMUlCbXj1XC3OmBU+wSDU+1Q81lA06DRwzsmAxiTouolKN2uBmSKGku4OxRo5Wt++FHy9xOrTQBCVR+E5l5hw4sg5cbPsTtkN1fAMumBllN9XZIr66AIDg1Y/0quEnuyxOYQvYn0cNusc+dKNKx4FNZtKtbPJCubkN2OmvBu/nql+EcXT1xkLmrgq3qo57FdXXz54V82h+iXglhX4GV2uNkfAtyHBN7AT9hqn5hdOp6bkuHLT4XeGSf324FGaA4sD9hi5E7clM5ndZ8A1qa0QYk0gqK0xr5POQhMvOHLByOEsaOgD7XCCh2ffMckntrum+MwZlQBQt3SGGmByerw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(42112799006)(376014)(7416014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cURwczFZbkZhc2xrNk9CRkc0RXV5dVI4VTdSc2VVakRBdnp5TlZFZElFWi9C?=
 =?utf-8?B?eHQyV3NHUkpET2hMZGhrK0g3TUtySVBjaHFqZzQ5eFhjTDh0Z0hYSjk2dVd1?=
 =?utf-8?B?ZEVSOUYxRThNYm8wdGE1cGlQUGFPQ1J1cjliQ1lKODBMSDQ0RVVEVmIrN2xH?=
 =?utf-8?B?L1EzcGllVkhQV3VXaFlQblRBaVVST2lmSjRGcW1ObFJPd2ptTFBDeEEvZFVi?=
 =?utf-8?B?b2NIQTByV3d6WWNUVXpoNVQ0SXF4TE13MmgwUEtiMVZNcUY5YjNBZE9mRnBa?=
 =?utf-8?B?Wmt6M1czUy92YzJUdkJiaFczaEdxWklVbnl1UUt6WnRXcHJ5NnBuTU9VT2pZ?=
 =?utf-8?B?MG1ZRnV1d1JNZHJPWmlyVng5STJqL0pKLy85WnlsUm8xOFM5czh1eHNCdVpG?=
 =?utf-8?B?aWFvL1hsdXk5RnVmS2FORjB1eElRSlBrT2Y1RGNsdXRDRWV5Ryt3dVFnY2Rw?=
 =?utf-8?B?OTVtMXN3dVRFSklGNVp5b0h0cTBFRGMwbkVuUHdNRDZmK0UzRlpRKy91bldV?=
 =?utf-8?B?dHArUlRoYVVTMm1LMHBtcWsxVm56Q3VNL1BRVzZVK0Z3cXFFc25mYXB6Wi9U?=
 =?utf-8?B?OCtpcC9BKzVsZ0p2M1FGNU8xQmFScm51dkloWWxzWGRUdHV2MHVGMmtsemFz?=
 =?utf-8?B?MXgwdVc2Tm5zNVJKVmxaK1lsWXJBTUtsVlc1cXBTa3NzeDFZeVR6VmdDdytY?=
 =?utf-8?B?M0VBaXNDeThnLy9GaGxFbjFNSjRwM0JVRG5lNXVCWVZqRjdqV0xUSk5ZYVF5?=
 =?utf-8?B?SytwUlVLU0toK2lCTVFuTkE4NStMejEwd0pLRW1NWlkrVFJJODVFVDFQN24z?=
 =?utf-8?B?enQzV0RoWDcvb1BvVGRGcnpDdjRzQ1lTcHZNMExybVBhdmg3YjZ6allQRmhl?=
 =?utf-8?B?ZEF6dEhxbHJOR0RORUpWUEZQaHQ0cm9QTFRLSTA3bmNuSXI1RzN5Q2dVWEt4?=
 =?utf-8?B?YmdRQldyT1NGMzlGMnpiYWRDVXdaUlJ1SnpQNmhpRDJYbUM0L1QxbVlpS25T?=
 =?utf-8?B?R01Xai9DaW1pMWFEOGM1MExkUnozaHZMTXc4dEd6QXdhWE85WUVMQVVObzdr?=
 =?utf-8?B?akQyejV1dG8zSmwvT2d4VkhxbDh3cG9SYnVmWXJMcUFSU0VVVXltTnJuTFRV?=
 =?utf-8?B?MkZTY015MzFKTHBEblMvcXNuQzVWNGx6QlBsaHI3TmJkT045clord3E4TXNC?=
 =?utf-8?B?OW8vNm9jOWlJdGtNMitucStYMmJnUU9DbS9VamNTTXJQbGRRUGZlWE1kQXNk?=
 =?utf-8?B?eTZ5cDFybngxSGVOaDVnS0tRd2JYMDEyak5RYnNJQjJaTVNxZ1k5cVJzRUlr?=
 =?utf-8?B?THZlVzFYZTVVSnMzZmR5L3ltckZpbkRJTTYxcGtYcXdWVXllcUFaSGsraXhE?=
 =?utf-8?B?TFpoNUpBS0h3L2Rra3h1M3hiQUFyYzNwbENpMnJiSnFvU2dHbDRjNEErRHht?=
 =?utf-8?B?NG5QcnFKQnB6STVRRitJYnhyM0JiRUpma3k2emxxRE84V1BOQ2R4UWpoZkkw?=
 =?utf-8?B?dUlFWDBTZHdDaXRoeE1JbTFOckw5NnhQZmt3dCt1MWFiRVFsN0Rad1BidSt1?=
 =?utf-8?B?a2I3TkpReENHMWRCTnJUZ3g2eXU0NnVrd01CTkRGZkNqV2JubzQxUTEvUHRV?=
 =?utf-8?B?ZDgwUHl1TUw5OWI1ZDBOcnBKUHhYcjdDZUM5RHRscVJsNDJKa2k4MGViUzM1?=
 =?utf-8?B?ZFR4cFRxbDZ4clZpNFM3RThRNTRNelFUR3FrVjJ5eGZjeFN2bC90b3R4Vi9k?=
 =?utf-8?B?UzM0bzVDWDkvcVJ6T29McnpTdDdWbytGanFVMHVvWmNkYkpITHhKRmI5blRp?=
 =?utf-8?B?YWVUMmJ0VGhkRUVZNjRTeDhZQVVMTEpHbStyaVlrUmI5Yno0dUN1d3ZWTmlG?=
 =?utf-8?B?enVDRUZISWZpekFuekpwUVJOeklPV3E4UUpjZlZrdTFuY29FNFFRY0dSUTJk?=
 =?utf-8?B?NmxEV0tZRnIycXpSTG44MWVVTHBob0o5YlZnQWpDNmJIeDFvZVNWUnFMQlZU?=
 =?utf-8?B?cnlTYzJKUWZadlg0STdJOHg3SEFYby9KZTBTYmRMcEYxamNuMkhvTWpCeVNm?=
 =?utf-8?B?eVVxUTYyTkZVZS9zaDdVUVFUOGxHa1FwbWY2RkZHVjI5djU4eTIwMjNsanJz?=
 =?utf-8?B?d0gvRUlNZnBKUnY5eTlPaEw5WEF0TVNZcy9FZ2JFTkZyWk1GZndmb3N4N1VH?=
 =?utf-8?B?aTZsT29oelE2VHdUaGR2ZUQxMzIwU3dNUlJhV2VjZ2NpR0s4UkpmakRVaDRh?=
 =?utf-8?B?ejU3OXo5cUE0VDdBTzJwV2ZqdkwzTld3cVR1SGR3Ym9ONlRNM09pd2VKZWdF?=
 =?utf-8?B?TDIwNGtEYmIxRFZFMkEvUm5wNDBHQXhnamZESXc0OEd3dkNzV2Fkdz09?=
X-Exchange-RoutingPolicyChecked: cdYe5Izbd7spgDSE3jzczDRBXu0ePWl8mGRuELMZpS8PtNe3R2empIZgS6yp0IBKBUEzniThqNwUayUowDJOC+llDWOSONEqYi1dkCkZqYUhG4CEhUfJc1NxUrXTBZb5xs+UOSHiSME+gs/Q2+7HmxzL0zkAuG500kt4ESlIEbLHz0wa8VWXoZlvG6+8C1NFLNJB3yiWI6t+OwiQWOh8NEfT4WMMkt59CBg0MIJjtyzZ+r3gEcVPqig9VvEUllNt+rphJLjyXAD6WdwtCbrRlcBbX0cY0H0HuiOxnjV3kdyX9fBxCik2tDwWiEWnln/kf9bEnDRdOznX5pcGIx4rUg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cc03ef-7f19-4bca-fe28-08de84e43925
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 11:48:08.3961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4ArRDPrLwO/O9mJEXZPXPdQIm+pxaraQ49XdxVkB0Sggvswfh4kSoBwl8/JIpwIuAyfHv7v1k8vhWqqM4mghw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7206
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

On 3/6/26 11:43, Zhenzhong Duan wrote:
> For attachment with pasid, pasid together with flag VFIO_DEVICE_ATTACH_PASID
> should be passed in.
> 
> Define IOMMU_NO_PASID to represent device attachment without pasid same as
> in kernel.
> 
> The implementation is similar for detachment.
> 
> Suggested-by: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/core/iommu.h |  2 ++
>   hw/vfio/iommufd.c       | 44 +++++++++++++++++++++++++----------------
>   hw/vfio/trace-events    |  4 ++--
>   3 files changed, 31 insertions(+), 19 deletions(-)
> 
> diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
> index 86af315c15..bfcd511013 100644
> --- a/include/hw/core/iommu.h
> +++ b/include/hw/core/iommu.h
> @@ -28,4 +28,6 @@ enum host_iommu_quirks {
>       HOST_IOMMU_QUIRK_NESTING_PARENT_BYPASS_RO = BIT_ULL(0),
>   };
>   
> +#define IOMMU_NO_PASID 0
> +
>   #endif /* HW_IOMMU_H */
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 131612eb83..b4c5e81b1d 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -21,6 +21,7 @@
>   #include "qapi/error.h"
>   #include "system/iommufd.h"
>   #include "hw/core/qdev.h"
> +#include "hw/core/iommu.h"

nit: move this line before qdev.h. Other parts LGTM.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

>   #include "hw/vfio/vfio-cpr.h"
>   #include "system/reset.h"
>   #include "qemu/cutils.h"
> @@ -302,43 +303,48 @@ out:
>       return ret;
>   }
>   
> -static int iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, uint32_t id,
> -                                         Error **errp)
> +static int iommufd_cdev_pasid_attach_ioas_hwpt(VFIODevice *vbasedev,
> +                                               uint32_t pasid, uint32_t id,
> +                                               Error **errp)
>   {
>       int iommufd = vbasedev->iommufd->fd;
>       struct vfio_device_attach_iommufd_pt attach_data = {
>           .argsz = sizeof(attach_data),
> -        .flags = 0,
> +        .flags = pasid == IOMMU_NO_PASID ? 0 : VFIO_DEVICE_ATTACH_PASID,
> +        .pasid = pasid,
>           .pt_id = id,
>       };
>   
>       /* Attach device to an IOAS or hwpt within iommufd */
>       if (ioctl(vbasedev->fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data)) {
>           error_setg_errno(errp, errno,
> -                         "[iommufd=%d] error attach %s (%d) to id=%d",
> -                         iommufd, vbasedev->name, vbasedev->fd, id);
> +                         "[iommufd=%d] error attach %s (%d) pasid %d to id=%d",
> +                         iommufd, vbasedev->name, vbasedev->fd, pasid, id);
>           return -errno;
>       }
>   
> -    trace_iommufd_cdev_attach_ioas_hwpt(iommufd, vbasedev->name,
> -                                        vbasedev->fd, id);
> +    trace_iommufd_cdev_pasid_attach_ioas_hwpt(iommufd, vbasedev->name,
> +                                              vbasedev->fd, pasid, id);
>       return 0;
>   }
>   
> -static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
> +static bool iommufd_cdev_pasid_detach_ioas_hwpt(VFIODevice *vbasedev,
> +                                                uint32_t pasid, Error **errp)
>   {
>       int iommufd = vbasedev->iommufd->fd;
>       struct vfio_device_detach_iommufd_pt detach_data = {
>           .argsz = sizeof(detach_data),
> -        .flags = 0,
> +        .flags = pasid == IOMMU_NO_PASID ? 0 : VFIO_DEVICE_DETACH_PASID,
> +        .pasid = pasid,
>       };
>   
>       if (ioctl(vbasedev->fd, VFIO_DEVICE_DETACH_IOMMUFD_PT, &detach_data)) {
> -        error_setg_errno(errp, errno, "detach %s failed", vbasedev->name);
> +        error_setg_errno(errp, errno, "detach %s pasid %d failed",
> +                         vbasedev->name, pasid);
>           return false;
>       }
>   
> -    trace_iommufd_cdev_detach_ioas_hwpt(iommufd, vbasedev->name);
> +    trace_iommufd_cdev_pasid_detach_ioas_hwpt(iommufd, vbasedev->name, pasid);
>       return true;
>   }
>   
> @@ -359,7 +365,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>       /* Try to find a domain */
>       QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>           if (!cpr_is_incoming()) {
> -            ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
> +            ret = iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, IOMMU_NO_PASID,
> +                                                      hwpt->hwpt_id, errp);
>           } else if (vbasedev->cpr.hwpt_id == hwpt->hwpt_id) {
>               ret = 0;
>           } else {
> @@ -432,7 +439,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>           return false;
>       }
>   
> -    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp);
> +    ret = iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, IOMMU_NO_PASID, hwpt_id,
> +                                              errp);
>       if (ret) {
>           iommufd_backend_free_id(container->be, hwpt_id);
>           return false;
> @@ -485,7 +493,8 @@ static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
>   
>       /* If CPR, we are already attached to ioas_id. */
>       return cpr_is_incoming() ||
> -           !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
> +           !iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, IOMMU_NO_PASID,
> +                                                container->ioas_id, errp);
>   }
>   
>   static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
> @@ -493,7 +502,7 @@ static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
>   {
>       Error *err = NULL;
>   
> -    if (!iommufd_cdev_detach_ioas_hwpt(vbasedev, &err)) {
> +    if (!iommufd_cdev_pasid_detach_ioas_hwpt(vbasedev, IOMMU_NO_PASID, &err)) {
>           error_report_err(err);
>       }
>   
> @@ -919,7 +928,8 @@ host_iommu_device_iommufd_vfio_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
>   {
>       VFIODevice *vbasedev = HOST_IOMMU_DEVICE(idev)->agent;
>   
> -    return !iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp);
> +    return !iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, IOMMU_NO_PASID,
> +                                                hwpt_id, errp);
>   }
>   
>   static bool
> @@ -928,7 +938,7 @@ host_iommu_device_iommufd_vfio_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
>   {
>       VFIODevice *vbasedev = HOST_IOMMU_DEVICE(idev)->agent;
>   
> -    return iommufd_cdev_detach_ioas_hwpt(vbasedev, errp);
> +    return iommufd_cdev_pasid_detach_ioas_hwpt(vbasedev, IOMMU_NO_PASID, errp);
>   }
>   
>   static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 846e3625c5..764a3e4855 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -182,8 +182,8 @@ vfio_vmstate_change_prepare(const char *name, int running, const char *reason, c
>   
>   iommufd_cdev_connect_and_bind(int iommufd, const char *name, int devfd, int devid) " [iommufd=%d] Successfully bound device %s (fd=%d): output devid=%d"
>   iommufd_cdev_getfd(const char *dev, int devfd) " %s (fd=%d)"
> -iommufd_cdev_attach_ioas_hwpt(int iommufd, const char *name, int devfd, int id) " [iommufd=%d] Successfully attached device %s (%d) to id=%d"
> -iommufd_cdev_detach_ioas_hwpt(int iommufd, const char *name) " [iommufd=%d] Successfully detached %s"
> +iommufd_cdev_pasid_attach_ioas_hwpt(int iommufd, const char *name, int devfd, uint32_t pasid, int id) " [iommufd=%d] Successfully attached device %s (%d) pasid %d to id=%d"
> +iommufd_cdev_pasid_detach_ioas_hwpt(int iommufd, const char *name, uint32_t pasid) " [iommufd=%d] Successfully detached %s pasid %d"
>   iommufd_cdev_fail_attach_existing_container(const char *msg) " %s"
>   iommufd_cdev_alloc_ioas(int iommufd, int ioas_id) " [iommufd=%d] new IOMMUFD container with ioasid=%d"
>   iommufd_cdev_device_info(char *name, int devfd, int num_irqs, int num_regions, int flags) " %s (%d) num_irqs=%d num_regions=%d flags=%d"


