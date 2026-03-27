Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4ECF532CC
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 04:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5yj2-00025K-1x; Fri, 27 Mar 2026 00:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w5yiz-00022h-GU
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:23:09 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w5yiw-00058W-To
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774585387; x=1806121387;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IjvUjwt7IRdg1S0UAqGVSTMBYYBsrlKDJMQuq3Wx8Tw=;
 b=iogcQyDNc9VqwuRJLisTiJVfce1/nD98oymv7aqVqB9sS6jURA/11sYD
 Xyh7x6uFBv1EspyywBQBetEmXzYQsmWGYgG7U74lGo2QwSxn01oQDyE4g
 wPqDSzg8D5Cl02K2l2Ofy39KX8gtILJYu86sI+/CIeNdR9Bz/pFSxQgau
 Ciw9y4WdhYXlVbUgKhSG63hBUDO/lqahB9AcrqXlc84UCIYxmb/lCCIt1
 m6uqBBL6af921Ua4yxKSLUE6U56LVQj1Arq+59c3aHReKRF2U+fr75N5c
 1l91kjqsgULJdtAYWUrF8IVrX+T6KuHt11NExZg5K0ZFuBDevXBgviank g==;
X-CSE-ConnectionGUID: +1UkaaSPTSm/Gys3k8zKHQ==
X-CSE-MsgGUID: LGwR1zr6Ryqc82Lwa0UPCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="101115041"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="101115041"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 21:23:05 -0700
X-CSE-ConnectionGUID: jf6ymU84SPqENKwH4YrlVg==
X-CSE-MsgGUID: CcPOnhlcQhKa/L0G3yLeuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="221890063"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 21:23:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 21:23:04 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 21:23:04 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.26)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 21:23:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mR4JzfLmtuWegOelHeimmX5eBwq4TOs90AQTLEtrN/lKVzvtQC6fXD7P8jr384Q+ZgTZmqcVyQ9YiowBT+TKld7thcNatOoAu8LEE4KBuN10tsJqtl7rMvaTTao7dPvtSlgPg0wdN5m/odzdOZQsRiApm54dOxm4iEYLSy3Zl1sl5g0+G0RyaXmPfCal6uD1a5Tbg5EXHy8XTwx+zSRONtiKAgHdLl99UyWrsqJJgNatlJkgQgzPAxucZYXBLYU2zob0mVRAYkqqhr1lLaiRrSpM7KNo+T6p34H9bnIfr+7XV1R1TEqkux+F8W7ake9P2g+A1ZwJmSkQEnjYmYbatw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Y0cgH5uCFyETrf3Q46hSGCo32RyXsEhaEUG74x2FV8=;
 b=L2Dx3od8l2igYfBL/rkYG5vav7g6ouQDG6riVwwcqXK9bY9WKK3nvvq9RpHN5mUIVxu/jLkr7KqAdqXwPoS+PqZFMVPnnrOgZDFESwhChW8SOVQySAIV9aJrIeWOpLj/XuawHUkF1W7zj/58TU0sDzkKl0PKf15NBWH+5bjffVnnPWNGfaeYLmpZgS8w0L11/vYC2MfTJ0dhu40HhrlvN+G5bpNUJrr7QcWbdr01fERZLDdNRw+lLJIvjK4vw0SxtByQkv5hutE6Jf0pBkXzQRusx0ZmTIeLpkCb73lBCeA7QPxyodrtJDNjjugk+VGQxE6vOJ0r8VPP7p7KJiicWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SA1PR11MB9614.namprd11.prod.outlook.com (2603:10b6:806:4c4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 04:22:56 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 04:22:56 +0000
Message-ID: <1e76a065-3155-4a1d-9d9e-38a90594fcd2@intel.com>
Date: Fri, 27 Mar 2026 12:30:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] intel_iommu_accel: Handle PASID entry addition
 for pc_inv_dsc request
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-8-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260326091130.321483-8-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0057.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::16) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SA1PR11MB9614:EE_
X-MS-Office365-Filtering-Correlation-Id: cffef964-e9ce-484b-b131-08de8bb88539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|42112799006|366016|3613699012|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2o9TRWuidl4SHp7c+gw/60SeSg6v+MoxaTDMLL1k/P69mfGopQAXZtmg34q4zeLk0QRgMKMPcEvh2Mp+kTcO/liLaRENiPT5t1CbtwgoQ2azYWyYtZMLImz5ZZAQamR6sqkkL5oX8PMHOmujLSu7fcSa03gQ3xOTCcFKfChmwWW51t1YJKod/f/kdwgJj0+GNiWus0XxytSvKMInFMKy45mB7nYmHKK0l3xI/tejYcnZzFM1OvwBX6BBlV31Gt+95/xk8IJo615HOyJvXtlk/BNGbBRw9jnOtU5C0K8FuXR+AU2Z9/mw/adEqKpEeZ9BJNNP+m2BcFLgaqOrBGclkRcjtz/JfOLxNSP4c6l6SfX0eY54YkB4oPTKoMTv0kRk2GfdwpaZaHc8bxe+qVKeicoSeXZAV6jXFNtFSRiYSxTcTa9qNG4OAbYgeV0mYqzlCLZNi1DLucT3wz1QR7geT9owBlwGo9mHzM+nrmH31HAe9VgxWT0brqvWxFFrgd86QROys0f3cSdh+dcP8YAIVdc7F2CmA2HQOZcTpOoUnuwtC+FTqsE6gQGw5nF8NgCAIdMyLGAfsBNuuoBkapTydNqNQDzO8ZZCfNosYQjvvykBdXu+IzkgCkoYA0Ss7INDYXM6EhPmaH5qMEPV28GpWWh9mtU4572hVR0D9uszZNPaQ1DNxUaAQHnZ4skbviq1f/cFgpZm2rtgOog+884/7WEiUSZrWx+3hzEf72vjkEsEksa+obPrnFumDmYp5WnDXupYwaJH0UhVfRZGpNlNp9tWD63yTP+8Gx/kOw9iK+I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(42112799006)(366016)(3613699012)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGc2bHhqdm41bGNEM0JUbUF6L3VuY21QNXpxMUhjYmMxcS9DSHhVai93aDN6?=
 =?utf-8?B?U0w3YU00cVV3bXdtbDJHaTVIQ3h0TURnMWlFelFwMHFyUVdRSm9zUVZscEZU?=
 =?utf-8?B?Y29ZbHNIWnZFaEhqUklHY2srUHl6cmtVOTlOU0lZSUF4VFREbEplUGZ6UllC?=
 =?utf-8?B?K1QybjZ6UkVQRTZLR080NW9JaTZ3NlYvS1k2R1NkZDdCdXdSTCtYTTNFWVRv?=
 =?utf-8?B?OGNKVm0xZ2tRWEJMNlVqSCtFYW5ReHlYTVI4TUlBa3hWQVVKdCtuTTQvTHlS?=
 =?utf-8?B?ZnlnVWx1clZWTE1uN2E3dDNiTjFMVjAySEhCOG5KU1FKcUlRMTF2UHRnc2Y5?=
 =?utf-8?B?M2xiZEZuQ3NyM2JadTFFMUNUbE01MllHQkNIVEVqUFZUekRpZy9GVmlMeHBL?=
 =?utf-8?B?SWR3VW1VWmxudzg5RkxiM25XbDBNb0JxWXJDK3J6WkN5TlhXVHdCb3RvMmo0?=
 =?utf-8?B?aUVjZ1FmaHhML0VFdmRzcEt3dDljQ3RxOW9wWXFiL0E5ZmNpSDB5aEdxdjV3?=
 =?utf-8?B?d3RkYk5POEU5ZTkvUXdWMnppYkJ2UWpOZ2U3NkhHb1ZiSTVPbXlPbGFxUEV2?=
 =?utf-8?B?MDAwcDI5OWM1UjQzaHRFcWFvZjV2Mk5wQkdqNytTZnZGZmVVbW1UZVRaZ0ox?=
 =?utf-8?B?UHJPU1FLTTlXSHFRSXhyN0tid1V4c0t2Mm1pQUxWNitIa3VzZG80ZXNEMjY0?=
 =?utf-8?B?amlDd1VveWZ2cjFJdlRLZkxia0RkRDR3VHVGOXJ5WDA2WVhqREhGVC9qc3Jm?=
 =?utf-8?B?azJzV2dIY0oxUlBrV0ZJZTd5Y3VMc3lOcjRGQ0dkUml4bjR2N1krenF0TkZn?=
 =?utf-8?B?Z0IreFcwRmU0RUMyTUlDT0ovSzFBZVhqL3MrdmNrYVR3QlJveXJJcjFnUWE1?=
 =?utf-8?B?QlczUnpJcVZtNi9vTFZHY3FSRCtpbWlQbUw2WkNOU1VoSmNvdUVRWlRBUUtF?=
 =?utf-8?B?czB2c0o4RHBNMWlOWUFkcGthWmxUTERjRDVzMWJYY05Cd2gwK1hVSkxLcXd2?=
 =?utf-8?B?TG1QNzRERGxDMm1pQXVuUlgvKzRPWWp3bGdNOVNvdG1aQyt2SVlBWDdoRFR5?=
 =?utf-8?B?QTFDRkw3eDViSjN4MzlFUUUxTGZVR2s4ck1vOEpmWVp6dmZ5bHA0YnoyZjQ2?=
 =?utf-8?B?MHQ1Qis5cHBjQTRTTS8vZXJsWUR0U1laaHBNQlJrSVBTdUdQMTlMQitCV3RB?=
 =?utf-8?B?eVMxWWhNOWJvdms3YkxxalhHd1M2b2V5aUhTbWt6Y1lQZFVYbThWNGdkUnAx?=
 =?utf-8?B?K0MwV0pRNVZnby9Pc1ZqWnNjYWJpdU5IbkZqRTZhcm5BNjlQZzlTV0hkM3N2?=
 =?utf-8?B?VERURGdtYkdrMkdra0RFVkZvTFRFM2tacTBrcTVkR0JkRGRaVjY4dW81cXJo?=
 =?utf-8?B?TVZXTGlwMlVRMzE1L1N3VU9EMTZjMnVlcVdqSDA0KzZoSXhLaVkrNncvSnVj?=
 =?utf-8?B?MkVkK3Y0MjJyKys3WHhOeHRySEw3Nno1UGFQc0pab2VmdW13RjY4bWpkbUVv?=
 =?utf-8?B?K0I1M1JFbGJmOGc0WGcya3I3YXppVDU2QllzM2xIbnpVSkRXLzlxRXZEMElY?=
 =?utf-8?B?TGNNL05YMlkvZzlYQk9HYVVreXlLRWdyNCtHdXA3QmpManF0OG1DT0xQQmUv?=
 =?utf-8?B?ZFhJUENuS0RZWExDTGxmM2xwV2pWcW5HTUV5dlIvdDFSaVVoUWNOd2lLcFU1?=
 =?utf-8?B?K1dPam1RNEx0eGprK2pwWE5Ta0RDc0JFQk0ybTBPeXlrNjZ0VzFUOGNCZERO?=
 =?utf-8?B?RlgxRmY3TlppdTdYdldBTmFOMWZJeG5ZR2ZrY3ZwbmxHa01qOVlxZ293Wjd6?=
 =?utf-8?B?cGVQMjlFZHgzTmVJT2ozQXNGZHlVWXRtN2g4V1hmbUE5czZFdW8ybFFuWDA2?=
 =?utf-8?B?SzJoOUhoeUp0S2M0L1dqR05EMWtvRUFaV1pEMTJhQ1I5bXBXTGFIY0IxU3E4?=
 =?utf-8?B?UXUwbU9PbGdlcUJidXBBcVdzSVB1R1hLNkFnbng2YWVhNUkrcUZMVWh5SnRG?=
 =?utf-8?B?MjZHYVhPcmQ3M2htNSszdXFZckxQMnRwUWNrK2xUYXdvVHBmZzdoMkZOM25Q?=
 =?utf-8?B?L3BjTXp5aUZxL3BmWW1IeWxhUTRqTnQwb0ZGZmMvWU5WczB1OCtRV0t2dEp2?=
 =?utf-8?B?Mkt4bDhJblNoT2lGRDR1a2FKbHlKSUxUQm5IVmIxZ1ZvYXRpSXV1dFZGQ0FS?=
 =?utf-8?B?SGI4R2h5UkVyeHY2enhaR08rY3lwdlhoYTQ2VjhSTXpEVXpWRWNMT3V0K2pX?=
 =?utf-8?B?WkdjZGxCMm1ZdTZieU4zZC9mVjRnTEpDS2gzQkt5Sit4RzhLSHk1SlRaalVm?=
 =?utf-8?B?QUp6dzE5bmpZemdKbHhLWVFNdzhkWlE3NUFKc2ZEb0p1eWsvcU9KQT09?=
X-Exchange-RoutingPolicyChecked: YMZyNiX95kLjvnghx9W+3TJa/rF2hYl3bd0sYtphHP04PGjDWryddshl12l4IKf72Fh6VHbDn6iKhp8rnexieldJPhtQL9N8ZA3W6B+cmJOI0I9XLalZ/zAoriNvuPI05dIhOGvv3p0s4++M8XX8Xar1az6Sqj2pK+FHHLKXHP0MKe/6xcac1L+dgp7xJWoRfnzRHslKL1B91K3doMKLF+++zg3EiIwAiZZCBCooWt6se0KVda+pEqSa0Qml9GI3amawou02yhgy/CBYn92VwfrOavBaEv2RtfS6k+p26Nl1zjnmRzxQ4xg00xch3VnoEwcbFBRFzpmPO4rN1lY/7w==
X-MS-Exchange-CrossTenant-Network-Message-Id: cffef964-e9ce-484b-b131-08de8bb88539
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 04:22:55.9944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: of5OSnF+iRXbEyfimA6brmF3Mi3/JZF9TWxQgNzPopRX76/BXn3Fg2mKI6Pcm1bpm4Fd/EmvtonnIDENlqTHWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9614
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7; envelope-from=yi.l.liu@intel.com;
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

On 3/26/26 17:11, Zhenzhong Duan wrote:
> Structure VTDAddressSpace includes some elements suitable for emulated
> device and passthrough device without PASID, e.g., address space,
> different memory regions, etc, it is also protected by vtd iommu lock,
> all these are useless and become a burden for passthrough device with
> PASID.
> 
> When there are lots of PASIDs used in one device, the AS and MRs are
> all registered to memory core and impact the whole system performance.
> 
> So instead of using VTDAddressSpace to cache pasid entry for each pasid
> of a passthrough device, we define a light weight structure
> VTDAccelPASIDCacheEntry with only necessary elements for each pasid. We
> will use this struct as a parameter to conduct binding/unbinding to
> nested hwpt and to record the current bound nested hwpt. It's also
> designed to support PASID_0.
> 
> VTDAccelPASIDCacheEntry is designed to only be used in intel_iommu_accel.c,
> similarly VTDPASIDCacheEntry should only be used in hw/i386/intel_iommu.c
> 
> When guest creates new PASID entries, QEMU will capture the pc_inv_dsc
> (pasid cache invalidation) request, walk through each pasid in each
> passthrough device for valid pasid entries, create a new
> VTDAccelPASIDCacheEntry if not existing yet.
> 
> PASID_0 of passthrough device still need to register MRs in case guest
> does not operate in scalable mode. So for PASID_0, we have both
> VTDAPASIDCacheEntry and VTDAccelPASIDCacheEntry.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

perhaps togather with a co-d-b tag, otherwise this s-o-b tag is strange.
same to other commits in this series. :)

> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_accel.h    |  13 +++
>   hw/i386/intel_iommu_internal.h |   8 ++
>   hw/i386/intel_iommu.c          |   3 +
>   hw/i386/intel_iommu_accel.c    | 170 +++++++++++++++++++++++++++++++++
>   4 files changed, 194 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
> index e5f0b077b4..c5981a23bf 100644
> --- a/hw/i386/intel_iommu_accel.h
> +++ b/hw/i386/intel_iommu_accel.h
> @@ -12,6 +12,13 @@
>   #define HW_I386_INTEL_IOMMU_ACCEL_H
>   #include CONFIG_DEVICES
>   
> +typedef struct VTDAccelPASIDCacheEntry {
> +    VTDHostIOMMUDevice *vtd_hiod;
> +    VTDPASIDEntry pasid_entry;
> +    uint32_t pasid;
> +    QLIST_ENTRY(VTDAccelPASIDCacheEntry) next;
> +} VTDAccelPASIDCacheEntry;
> +
>   #ifdef CONFIG_VTD_ACCEL
>   bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
>                             Error **errp);
> @@ -20,6 +27,7 @@ bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as, Error **errp);
>   void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
>                                         uint32_t pasid, hwaddr addr,
>                                         uint64_t npages, bool ih);
> +void vtd_pasid_cache_sync_accel(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info);
>   void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops);
>   #else
>   static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
> @@ -49,6 +57,11 @@ static inline void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s,
>   {
>   }
>   
> +static inline void vtd_pasid_cache_sync_accel(IntelIOMMUState *s,
> +                                              VTDPASIDCacheInfo *pc_info)
> +{
> +}
> +
>   static inline void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)
>   {
>   }
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index c7e107fe87..d5f212ded9 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -616,6 +616,7 @@ typedef struct VTDRootEntry VTDRootEntry;
>   #define VTD_CTX_ENTRY_SCALABLE_SIZE   32
>   
>   #define PASID_0                             0
> +#define VTD_SM_CONTEXT_ENTRY_PDTS(x)        extract64((x)->val[0], 9, 3)
>   #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
>   #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
>   #define VTD_SM_CONTEXT_ENTRY_PRE            0x10ULL
> @@ -646,6 +647,7 @@ typedef struct VTDPIOTLBInvInfo {
>   #define VTD_PASID_DIR_BITS_MASK       (0x3fffULL)
>   #define VTD_PASID_DIR_INDEX(pasid)    (((pasid) >> 6) & VTD_PASID_DIR_BITS_MASK)
>   #define VTD_PASID_DIR_FPD             (1ULL << 1) /* Fault Processing Disable */
> +#define VTD_PASID_TABLE_ENTRY_NUM     (1ULL << 6)
>   #define VTD_PASID_TABLE_BITS_MASK     (0x3fULL)
>   #define VTD_PASID_TABLE_INDEX(pasid)  ((pasid) & VTD_PASID_TABLE_BITS_MASK)
>   #define VTD_PASID_ENTRY_FPD           (1ULL << 1) /* Fault Processing Disable */
> @@ -711,6 +713,7 @@ typedef struct VTDHostIOMMUDevice {
>       PCIBus *bus;
>       uint8_t devfn;
>       HostIOMMUDevice *hiod;
> +    QLIST_HEAD(, VTDAccelPASIDCacheEntry) pasid_cache_list;
>   } VTDHostIOMMUDevice;
>   
>   /*
> @@ -768,6 +771,11 @@ static inline int vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
>       return memcmp(p1, p2, sizeof(*p1));
>   }
>   
> +static inline uint32_t vtd_sm_ce_get_pdt_entry_num(VTDContextEntry *ce)
> +{
> +    return 1U << (VTD_SM_CONTEXT_ENTRY_PDTS(ce) + 7);
> +}
> +
>   int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base, uint32_t pasid,
>                                     VTDPASIDDirEntry *pdire);
>   int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s, uint32_t pasid,
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index b5d18ae321..451ede7530 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3202,6 +3202,8 @@ static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
>       g_hash_table_foreach(s->vtd_address_spaces, vtd_pasid_cache_sync_locked,
>                            pc_info);
>       vtd_iommu_unlock(s);
> +
> +    vtd_pasid_cache_sync_accel(s, pc_info);
>   }
>   
>   static void vtd_replay_pasid_bindings_all(IntelIOMMUState *s)
> @@ -4759,6 +4761,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>       vtd_hiod->devfn = (uint8_t)devfn;
>       vtd_hiod->iommu_state = s;
>       vtd_hiod->hiod = hiod;
> +    QLIST_INIT(&vtd_hiod->pasid_cache_list);
>   
>       if (!vtd_check_hiod(s, vtd_hiod, errp)) {
>           g_free(vtd_hiod);
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index c2757f3bcd..32d8ab0ef9 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -257,6 +257,176 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
>                            vtd_flush_host_piotlb_locked, &piotlb_info);
>   }
>   
> +static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
> +                              VTDPASIDEntry *pe)
> +{
> +    VTDAccelPASIDCacheEntry *vtd_pce;
> +
> +    QLIST_FOREACH(vtd_pce, &vtd_hiod->pasid_cache_list, next) {
> +        if (vtd_pce->pasid == pasid) {
> +            if (vtd_pasid_entry_compare(pe, &vtd_pce->pasid_entry)) {
> +                vtd_pce->pasid_entry = *pe;
> +            }
> +            return;
> +        }
> +    }
> +
> +    vtd_pce = g_malloc0(sizeof(VTDAccelPASIDCacheEntry));
> +    vtd_pce->vtd_hiod = vtd_hiod;
> +    vtd_pce->pasid = pasid;
> +    vtd_pce->pasid_entry = *pe;
> +    QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
> +}
> +
> +/*
> + * This function walks over PASID range within [start, end) in a single
> + * PASID table for entries matching @info type/did, then create
> + * VTDAccelPASIDCacheEntry if not exist yet.
> + */
> +static void vtd_sm_pasid_table_walk_one(VTDHostIOMMUDevice *vtd_hiod,
> +                                        dma_addr_t pt_base,
> +                                        int start,
> +                                        int end,
> +                                        VTDPASIDCacheInfo *info)
> +{
> +    IntelIOMMUState *s = vtd_hiod->iommu_state;
> +    VTDPASIDEntry pe;
> +    int pasid;
> +
> +    for (pasid = start; pasid < end; pasid++) {
> +        if (vtd_get_pe_in_pasid_leaf_table(s, pasid, pt_base, &pe) ||
> +            !vtd_pe_present(&pe)) {
> +            continue;
> +        }
> +
> +        if ((info->type == VTD_INV_DESC_PASIDC_G_DSI ||
> +             info->type == VTD_INV_DESC_PASIDC_G_PASID_SI) &&
> +            (info->did != VTD_SM_PASID_ENTRY_DID(&pe))) {
> +            /*
> +             * VTD_PASID_CACHE_DOMSI and VTD_PASID_CACHE_PASIDSI
> +             * requires domain id check. If domain id check fail,
> +             * go to next pasid.
> +             */
> +            continue;
> +        }
> +
> +        vtd_accel_fill_pc(vtd_hiod, pasid, &pe);
> +    }
> +}
> +
> +/*
> + * In VT-d scalable mode translation, PASID dir + PASID table is used.
> + * This function aims at looping over a range of PASIDs in the given
> + * two level table to identify the pasid config in guest.
> + */
> +static void vtd_sm_pasid_table_walk(VTDHostIOMMUDevice *vtd_hiod,
> +                                    dma_addr_t pdt_base,
> +                                    int start, int end,
> +                                    VTDPASIDCacheInfo *info)
> +{
> +    VTDPASIDDirEntry pdire;
> +    int pasid = start;
> +    int pasid_next;
> +    dma_addr_t pt_base;
> +
> +    while (pasid < end) {
> +        pasid_next = (pasid + VTD_PASID_TABLE_ENTRY_NUM) &
> +                     ~(VTD_PASID_TABLE_ENTRY_NUM - 1);
> +        pasid_next = pasid_next < end ? pasid_next : end;
> +
> +        if (!vtd_get_pdire_from_pdir_table(pdt_base, pasid, &pdire)
> +            && vtd_pdire_present(&pdire)) {
> +            pt_base = pdire.val & VTD_PASID_TABLE_BASE_ADDR_MASK;
> +            vtd_sm_pasid_table_walk_one(vtd_hiod, pt_base, pasid, pasid_next,
> +                                        info);
> +        }
> +        pasid = pasid_next;
> +    }
> +}
> +
> +static void vtd_replay_pasid_bind_for_dev(VTDHostIOMMUDevice *vtd_hiod,
> +                                          int start, int end,
> +                                          VTDPASIDCacheInfo *pc_info)

s/vtd_replay_pasid_bind_for_dev/vtd_accel_replay_pasid_bind_for_dev/

> +{
> +    IntelIOMMUState *s = vtd_hiod->iommu_state;
> +    VTDContextEntry ce;
> +    int dev_max_pasid = 1 << vtd_hiod->hiod->caps.max_pasid_log2;
> +
> +    if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_hiod->bus),
> +                                  vtd_hiod->devfn, &ce)) {
> +        VTDPASIDCacheInfo walk_info = *pc_info;
> +        uint32_t ce_max_pasid = vtd_sm_ce_get_pdt_entry_num(&ce) *
> +                                VTD_PASID_TABLE_ENTRY_NUM;
> +
> +        end = MIN(end, MIN(dev_max_pasid, ce_max_pasid));
> +
> +        vtd_sm_pasid_table_walk(vtd_hiod, VTD_CE_GET_PASID_DIR_TABLE(&ce),
> +                                start, end, &walk_info);
> +    }
> +}
> +
> +/*
> + * This function replays the guest pasid bindings by walking the two level
> + * guest PASID table. For each valid pasid entry, it creates an entry
> + * VTDAccelPASIDCacheEntry dynamically if not exist yet. This entry holds
> + * info specific to a pasid
> + */
> +void vtd_pasid_cache_sync_accel(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)

I think it's nice to name it as vtd_accel_pasid_cache_sync().

> +{
> +    int start = PASID_0, end = 1 << s->pasid;
> +    VTDHostIOMMUDevice *vtd_hiod;
> +    GHashTableIter hiod_it;
> +
> +    if (!s->fsts) {
> +        return;
> +    }
> +
> +    /*
> +     * VTDPASIDCacheInfo honors PCI pasid but VTDAccelPASIDCacheEntry honors
> +     * iommu pasid
> +     */
> +    if (pc_info->pasid == PCI_NO_PASID) {
> +        pc_info->pasid = PASID_0;
> +    }
> +
> +    switch (pc_info->type) {
> +    case VTD_INV_DESC_PASIDC_G_PASID_SI:
> +        start = pc_info->pasid;
> +        end = pc_info->pasid + 1;
> +        /* fall through */
> +    case VTD_INV_DESC_PASIDC_G_DSI:
> +        /*
> +         * loop all assigned devices, do domain id check in
> +         * vtd_sm_pasid_table_walk_one() after get pasid entry.
> +         */
> +        break;
> +    case VTD_INV_DESC_PASIDC_G_GLOBAL:
> +        /* loop all assigned devices */
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    /*
> +     * In this replay, one only needs to care about the devices which are
> +     * backed by host IOMMU. Those devices have a corresponding vtd_hiod
> +     * in s->vtd_host_iommu_dev. For devices not backed by host IOMMU, it
> +     * is not necessary to replay the bindings since their cache should be
> +     * created in the future DMA address translation.

above words can be dropped since this code lays in the _accel.c.
Instead, I think you can add words like "Loop all the vtd_hiod
instances to sync the "pasid cache" per the guest pasid configuration."

> +     *
> +     * VTD translation callback never accesses vtd_hiod and its corresponding
> +     * cached pasid entry, so no iommu lock needed here.
> +     */
> +    g_hash_table_iter_init(&hiod_it, s->vtd_host_iommu_dev);
> +    while (g_hash_table_iter_next(&hiod_it, NULL, (void **)&vtd_hiod)) {
> +        if (!object_dynamic_cast(OBJECT(vtd_hiod->hiod),
> +                                 TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
> +            continue;
> +        }
> +        vtd_replay_pasid_bind_for_dev(vtd_hiod, start, end, pc_info);
> +    }
> +}
> +
>   static uint64_t vtd_get_host_iommu_quirks(uint32_t type,
>                                             void *caps, uint32_t size)
>   {


