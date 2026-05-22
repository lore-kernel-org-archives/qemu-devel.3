Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AEFCD4F5B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 05:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQIIe-0002Be-3v; Fri, 22 May 2026 01:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wQIIb-0002BN-NU
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:19:53 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wQIIV-0001Qs-JY
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779427188; x=1810963188;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dKb5kVXr5C2/0K57ioCN74Bk5g5sW1kavj+nS8yUJwI=;
 b=Z6L14pKgrRW7PObBUkOa3NDNL6P6qoY5uxYmk1wDyLDKaHk905HZwYxL
 2nT9Zduuimi4P18nFZEYjKOIuiD2ydLuw49Z4z9cL4TipzSdh8GvcPLeK
 C3qjBxBc1jVbkVIsBKqcpBJfPjmaI9UjKWbZLtyD/QaligjgS0CNbkZZa
 AuvrPdLfMUCIZj0V7+LP56HhdbgA+IDvizDeAoEDPS565Q3OWxWUFedJf
 iEbvOHiDfcjGkZ0Z0zanFouQ0vlH+LGkzzzJD/Y+NwdgakL4plvLMh3a1
 VM+tLZqwSWYa62S4pX4iy7x1btYzogiWjsVH0WApeMXJvC+CNeHQOU0UK Q==;
X-CSE-ConnectionGUID: Ijo3hU9eR5yMRBQquVNO7g==
X-CSE-MsgGUID: oRRrUm1+T2K1+9IegoJvIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="97929034"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; d="scan'208";a="97929034"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 22:19:45 -0700
X-CSE-ConnectionGUID: dwbZ54ApRVuU7fIaHETCrg==
X-CSE-MsgGUID: 0JmebnACRkqymDD2ICPaag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; d="scan'208";a="245848851"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 22:19:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 22:19:43 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 22:19:43 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.3) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 22:19:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alGVToQeE6AsOyCYMeIRBVaqYZbndbt3ZHdmIJByWoittJRyNAQUPB1swjReyey+8DR5+iKXrX9VkZcCp7igLkg6Ffp9eive0kx4q49EXGxb1QGKh2/TR5xHSQHEU/XafaT/MCaxXnrABHXxPaVJ+eC9GQd2RMedz9G1oILmY9M4YWuUsAlQlzyDiTHDM52+zuKwZ8+JYaHM16S6SkUjezsw7s0SNT3UWrqDRjuAxEHCQbbhw9wQxbsdkYj8jle56EIlwdpkgL0cHDUGAm2mhUVkymphPiHHV6a3FAtifvjeh+9wcgRVCYgA48YPmXtDsMPYsXBe1NX/lJIXzXWpUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXdfwXMPiJVGmG8NfuajEOzR4UGDoCHPLNXO9OP9c14=;
 b=RaPKSqp6JPQW+Yy2Mpt2cYkLPdl2Ufv4p4oXSP0+GeHhwqrAQF5OFHvRvm5fOpphOcSrgbEIfvlPbnt3EYVF4+zbChgEUv0peFBWrPyW7RmNV6hSooCPwfpfwRaLM4t/zB6F+7a58MZhc1qLNtORbDXHZ8QVef0FYCthCGlY2o/XDb4nN6Hhuo/LNqkCYj+EPV3aYvjLA1nuBzEESoo/Jh8+at5cKigXHLmiH/qchyPaWWi6s0z7pbNbcF19SwCBjFir0OJDzw+S3BZ/4/gZt/vFuEpi+yUCjMRkcnnA3q8exDh4K6mQKay6jf35wfgYVfvbmNw6n7g5Hry2ENo8XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by PH8PR11MB9534.namprd11.prod.outlook.com (2603:10b6:510:39f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Fri, 22 May
 2026 05:19:40 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 05:19:40 +0000
Message-ID: <1d15367a-d28e-40cf-b051-6c047392a3c9@intel.com>
Date: Fri, 22 May 2026 13:27:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/15] intel_iommu_accel: Handle PASID entry removal
 for pc_inv_dsc request
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
 <20260509040819.1044702-11-zhenzhong.duan@intel.com>
 <829fcf6f-39e4-4d21-9f08-2772c0813c32@intel.com>
 <IA3PR11MB91369A610C7F2DDEC9F2D5BD920F2@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB91369A610C7F2DDEC9F2D5BD920F2@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU3P306CA0002.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:15::20) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|PH8PR11MB9534:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de55685-ccd8-4bff-dbfe-08deb7c1b966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|42112799006|376014|11063799006|4143699003|3613699012|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YseKy7hMPl1ZtuQvrgcXiSpUdkvl0ZkXr+ySFmOvT9L3nzvSnY8vqWvKDhC/50NW14hvBiq0vpCjeLIp8xvWFjcnkazpLd7ENvidtp0cb6aCDxOJnwuXePLS6mI988u1DgVzO1wfOC9mfPilLJloscPba/XY40+diHTzdJQlAGPtV0hUHcqsecJ93iG+RVhhfNTBlSYwuq4kQ4kX/qnPNaRP29uXBWeL6YvC39JNdA0wtFmLYUonopJHwEGOLkD+9vpxvSix8fsjOAzaN+hbmL6pAK2uaPWlFAKNjVZj5jysVI5jjzttj5GyPl7i7Ybh6gWyk1P9foncbWAPIxngwmQ0VNnTjtTLZ+xdc9RjTrUS8cNKunXN3m/wx+w3bvTGVilMdabnfGrY+Hh3vweaxLkxTOtUXuE2X+/FDv3O2xCgvrHLn6L/bi80gZwNjscGjMWqHKaoYZjuFnpeiQjevsLl21FlM6b0R1n8BgeBc/0HPbANB30z7fKCOtgBG9BPa8GHhXhjCldf6vDOYnFB4ACM3sUdLTokVGo+1JNpaV6ZwZpYvQVW4BIagjXyWm5ZUSOuhW91dqbIkFIIyK2NOWpnmqB+fkWXneyjBv1VPUHXY1UQPp1pgsQQAJIT3uDjDZJLWxbbikpTmQSZhpttILUPlUWOYNJ4m7pJA8Yec4/uAVQuQDHGNGy0vVCfQYDwXMc15LDJdOSXywsoyV7k4/8CQf/C5fPC7wGaSjRTfiik7bJltbfMejM7kxn9UXUS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(42112799006)(376014)(11063799006)(4143699003)(3613699012)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUdTTU5GbUdOdHhGNVdLOGh4TkpRNXdydEx5bGhFL0JwWWdwY0pzcjFoSExJ?=
 =?utf-8?B?ZnZyU291THFJanpDK1lrZCszejlodTJVcWlhcHQ0K2JGU2lxVDRFc3dqRkND?=
 =?utf-8?B?aVZmbVlyMWVIb2p0MXU5Y0E4ZWp5WW84bWEvK2FIN1hBY0ttLzRURUQzTmxw?=
 =?utf-8?B?MERuSEdGbEt1VDNMNi9kMURLNHhmdjFJWUtHOTAwQ3gxL0pOSEdUcGVicVU2?=
 =?utf-8?B?NzJldzVtVnVGbmE2SHdNanp5Mk8rNkFUTWlOOVRDZ2Z2RUh4amJBS2Juc2cr?=
 =?utf-8?B?dUovSThqM3pNKzlvOVdFemlGS25HaU5EZ0Fadm01dmkyeEIvcmd0ODJDc0hN?=
 =?utf-8?B?Tms2d1Rua2liNURwWlh4NjFiVW5ZbHRSYU45dXN3M0JPZUtCVUtUbXlDWXph?=
 =?utf-8?B?OWp3Y2tCUGRZeEhCZ2ZCMzZsa21rSzNZcFl6YzV5QVpNM01xUW93WDFVSzBu?=
 =?utf-8?B?b1NOQWVWOU1jbFZQTk5YclNUYmFpYVNZS1ZOclR2QmVNcWplT3hqZjg0aW9r?=
 =?utf-8?B?aUNIbnNPUVRab3pDSUFJYnNzbjlxMlZFQXdkVDZLMFZxcUI5emRtTVVDUmR3?=
 =?utf-8?B?VTNNQ1NodE4zQWZzRitmdDhaVHJsblk0Qyt0aUZjcy8yVlMwRGY3SmU1Z0pa?=
 =?utf-8?B?cTh0VFBlNFZkUlRRdXpMYndRL0hMak82VC9uczFIRVhnSFhhVjRwc3Q3eEZl?=
 =?utf-8?B?bWhzZkJxZmtOaDB4d21DNlY3b1dmakErQUpmWFlQcFAzanBIcCtCMldqMkZv?=
 =?utf-8?B?WEpMQk1xTm9aQ3JIUStaSllmRXJBOHpnQ2lDSXV1R3FpV2YwUlFQaEpPY0Rp?=
 =?utf-8?B?N01lS1lnZEpYcDZ2bTBuK3JOMDhyL2dhMGFpaGdkTFpUeFBwSzlCSnpiVnZ5?=
 =?utf-8?B?N2RFRWVHakVCVDBlU0pQM1p5QVZJNWlxay9RQzgxRnZFK3lQS1piZGt6elor?=
 =?utf-8?B?cFVBWXpzbUpOQ2Z1YVNETGFhKzl0eWZVTzQzcHlpOTlIQkdHT3hNUDRZZDcr?=
 =?utf-8?B?MHM4dmhEWGUwaGk0TnFxNWFCNDBFUmU5Q3BMaVR3UEkrRURndHJOMjlGRHFl?=
 =?utf-8?B?VXl4b0hRdy81bE42Q2RBMzhneVRCblJwY3R5Q0JZaHFxLzRZeEtodmVvVHFy?=
 =?utf-8?B?L2xZek9HODc0b1d2RG0vMlpscnpvcldDdTFHSUhjUTJEeTl1dEU4S0dVK0hN?=
 =?utf-8?B?VG9sWmZkNlZYYlN5RkRNVW1haE9LVlJmTEluUmZ3eHlGdUg3ZkllMGM0dXNj?=
 =?utf-8?B?SXEvZU9ybXR5Y3R5ME0xbTBOQU4zUEdFUVhRUkE2Q0laZW9VS2RGT3Vab2sv?=
 =?utf-8?B?OTN4N1dlNVd0eXVYVGE1a0xaeE40YUFLQjNlTUowY05BWWM3UFFlWXI5bkZL?=
 =?utf-8?B?ZXY5Q1h0NXloRUhPMmR4dC90Mld5Vy83RjBsZ1FENnBmUWsybDNydHliUXlx?=
 =?utf-8?B?cnBTcUhRaWloZEorTmpBVzFpcDBZdmNKVzVvRk9aTFFDVExLZnAvdzNha0or?=
 =?utf-8?B?NEZhbmpJN3lsNzVTNW9PSmlub0FXaENqSVNpZzM5ZnR2d20zbytySE5CR0RH?=
 =?utf-8?B?b1VJZ09NUmVwRjU5dSs1djc2eWpDWXlUSHFvZ1o5cmsvZ2J5SkpuaHR4dDZN?=
 =?utf-8?B?NE5kL0JIUFJqMStJcXhTd3JSRDNBNkc5TEdpbG1Obi8yOElSaVl3M3FGc1Rt?=
 =?utf-8?B?QkFuSDhjY1ArZUljTVEwL2FubkUyR0h2ZDNlVUpGdzhORzlOQjAwanRXaU1h?=
 =?utf-8?B?aTZKOFpSZXlhaFlYRkJvdVFvWDNTTnhSVnVmTnlvREh3ZGlyUS9wbkxIMnJC?=
 =?utf-8?B?R0hHTGp0WjZNcDVUZjQweVgrbTcyeXBKejBPTEtpeFVDdm44SVZZZnhWQTcz?=
 =?utf-8?B?U2xXWXNTN0wrWnFWR21rdys3SDBxamQzakg3S2ZGN2s3WDlRcWF1QkRqY2Ey?=
 =?utf-8?B?clNkM1VCRks3K3NDY2xUNDllTkhxRUd4ZU9pR0I3OTdtbmc2T1dXNWpldlMx?=
 =?utf-8?B?Y1A3UzM5T3NpNHJkMmNwYmFWd1RSTEJuWndyS2xCMDM4blJoZ0ZiWnVOeDhU?=
 =?utf-8?B?ZTBIZTNobVp6MDMzQ1VIY0VzeEJhc1NtQ1F6WWZ6T2RwNU8zbzYrMC9OSGMv?=
 =?utf-8?B?R3ZjWElZWGZiK3J2Ky9TNHZCUHBhb1ljYkFlUWtnSE1hSTc1MlRabS9KZWZ4?=
 =?utf-8?B?b1BvdDVDNWJGejBqOFlRL0lTbDNiZlpzVncxVTg0b0JuRUc3NmhCQTZqQnJa?=
 =?utf-8?B?OTB5TDBISlFNYVlXL2FMeG5EcWFaYUhWRFQyeUt2TmcwcEViSWxJY1BScWpV?=
 =?utf-8?B?V3I1anhIYWsxSisyTk0zRCtvUlFYVnFmQUdCYzQ5Q1VTNDBtOVJyZz09?=
X-Exchange-RoutingPolicyChecked: punQuQpLURiUwUr8BBIqOOqWKDiW5JXe8KwP+N2zmuXjlOwtBGZRAIdwkBrYm+ZI08f37wkX9ytvFFNC/+gVyr/4p9jtgVNlXvwd0DMMyeDfNl7TmkL+n+ot5ysmVmHZumcxpv7qvoAjKrWbXMLrsP1dpt6wNuUq90A5ANVPiJpev3oM+JmMyyod3gKBJqh3xsXhRyZCg6+BDCObkznizTo21mswXHVBRBOITiIwfNeH0lKK4vQQWTrrCs6c6Jfesv6Lio0e/lGikFRlpTlRnJ3habPwS9EPXKkllHxUrS3tZ0jndUhinxtYrm/CqxDsm+3zIJSPRp1/JiMJB28Z9g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de55685-ccd8-4bff-dbfe-08deb7c1b966
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 05:19:40.4090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSpbQRNYWmkNcAHv2ARZwDaHvyItbFLC8NgbGm69YAlDY6qCKQISb2Etvg0MGUXDyLTRwppVF/geYC3wqdfs+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9534
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8; envelope-from=yi.l.liu@intel.com;
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

On 5/22/26 11:07, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH v5 10/15] intel_iommu_accel: Handle PASID entry removal for
>> pc_inv_dsc request
>>
>> On 5/9/26 12:08, Zhenzhong Duan wrote:
>>> When guest deletes PASID entries, QEMU will capture the pasid cache
>>> invalidation request, walk through pasid_cache_list in each passthrough
>>> device to find stale VTDAccelPASIDCacheEntry and delete them.
>>>
>>> Co-developed-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> Tested-by: Xudong Hao <xudong.hao@intel.com>
>>> ---
>>>    hw/i386/intel_iommu_accel.c | 80
>> +++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 80 insertions(+)
>>>
>>> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
>>> index a66d63b4c8..82bfbdf484 100644
>>> --- a/hw/i386/intel_iommu_accel.c
>>> +++ b/hw/i386/intel_iommu_accel.c
>>> @@ -16,6 +16,28 @@
>>>    #include "hw/pci/pci_bus.h"
>>>    #include "trace.h"
>>>
>>> +static int vtd_hiod_get_pe_from_pasid(VTDAccelPASIDCacheEntry *vtd_pce,
>>
>> this helper is tricky. vtd_pce already has a pe cached, then why need
>> to do this?
> 
> It's used on pc_inv_dsc handler path, vtd_pce caches old pe, we need to get refreshed one in memory.
> 
>> I think it's better to have a helper receives s, devfn, and
>> pasid instead of accepting vtd_pce. btw. I think the intel_iommu.c
>> should have such a helper. is it?
> 
> In intel_iommu.c, there is a helper for vtd_as:
> 
> static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
>                                              VTDPASIDEntry *pe)
> 
> so in intel_iommu_accel.c, vtd_hiod_get_pe_from_pasid() is added for vtd_pce.
> 

got it. VTDAddressSpace also cached a pe, with a closer read, it's
tricky as well. Could you refactor a bit? e.g. avoid using the
VTDAddressSpace as an input.

> 
>>
>>> +                                      VTDPASIDEntry *pe)
>>> +{
>>> +    VTDHostIOMMUDevice *vtd_hiod = vtd_pce->vtd_hiod;
>>> +    IntelIOMMUState *s = vtd_hiod->iommu_state;
>>> +    uint32_t pasid = vtd_pce->pasid;
>>> +    VTDContextEntry ce;
>>> +    int ret;
>>> +
>>> +    if (!s->dmar_enabled || !s->root_scalable) {
>>> +        return -VTD_FR_RTADDR_INV_TTM;
>>> +    }
>>> +
>>> +    ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_hiod->bus),
>>> +                                   vtd_hiod->devfn, &ce);
>>> +    if (ret) {
>>> +        return ret;
>>> +    }
>>> +
>>> +    return vtd_ce_get_pasid_entry(s, &ce, pe, pasid);
>>> +}
>>> +
>>>    bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice
>> *vtd_hiod,
>>>                              Error **errp)
>>>    {
>>> @@ -280,6 +302,57 @@ static void vtd_accel_fill_pc(VTDHostIOMMUDevice
>> *vtd_hiod, uint32_t pasid,
>>>        QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
>>>    }
>>>
>>> +static void vtd_accel_delete_pc(VTDAccelPASIDCacheEntry *vtd_pce)
>>> +{
>>> +    QLIST_REMOVE(vtd_pce, next);
>>> +    g_free(vtd_pce);
>>> +}
>>> +
>>> +static void
>>> +vtd_accel_pasid_cache_invalidate_one(VTDAccelPASIDCacheEntry *vtd_pce,
>>> +                                     VTDPASIDCacheInfo *pc_info)
>>> +{
>>> +    VTDPASIDEntry pe;
>>> +    uint16_t did;
>>> +
>>> +    /*
>>> +     * VTD_INV_DESC_PASIDC_G_DSI and VTD_INV_DESC_PASIDC_G_PASID_SI
>> require
>>> +     * DID check. If DID doesn't match the value in cache or memory, then
>>> +     * it's not a pasid entry we want to invalidate.
>>> +     */
>>> +    switch (pc_info->type) {
>>> +    case VTD_INV_DESC_PASIDC_G_PASID_SI:
>>> +        if (pc_info->pasid != vtd_pce->pasid) {
>>> +            return;
>>> +        }
>>> +        /* Fall through */
>>> +    case VTD_INV_DESC_PASIDC_G_DSI:
>>> +        did = VTD_SM_PASID_ENTRY_DID(&vtd_pce->pasid_entry);
>>> +        if (pc_info->did != did) {
>>> +            return;
>>> +        }
>>> +    }
>>> +
>>> +    if (vtd_hiod_get_pe_from_pasid(vtd_pce, &pe)) {
>>> +        /*
>>> +         * No valid pasid entry in guest memory. e.g. pasid entry was modified
>>> +         * to be either all-zero or non-present. Either case means existing
>>> +         * pasid cache should be invalidated.
>>> +         */
>>> +        vtd_accel_delete_pc(vtd_pce);
>>> +    }
>>> +}
>>> +
>>> +static void vtd_accel_pasid_cache_invalidate(VTDHostIOMMUDevice
>> *vtd_hiod,
>>> +                                             VTDPASIDCacheInfo *pc_info)
>>> +{
>>> +    VTDAccelPASIDCacheEntry *vtd_pce, *next;
>>> +
>>> +    QLIST_FOREACH_SAFE(vtd_pce, &vtd_hiod->pasid_cache_list, next, next) {
>>> +        vtd_accel_pasid_cache_invalidate_one(vtd_pce, pc_info);
>>> +    }
>>> +}
>>> +
>>>    /*
>>>     * This function walks over PASID range within [start, end) in a single
>>>     * PASID table for entries matching @info type/did, then create
>>> @@ -411,6 +484,13 @@ void vtd_accel_pasid_cache_sync(IntelIOMMUState
>> *s, VTDPASIDCacheInfo *pc_info)
>>>                                     TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
>>>                continue;
>>>            }
>>> +
>>> +        /*
>>> +         * PASID entry removal is handled before addition intentionally,
>>> +         * because it's unnecessary to iterate on an entry that will be
>>> +         * removed.
>>
>> how about below? :)
>>
>> /*
>>   * The replay path inevitably needs to iterate through existing
>>   * PASID cache entries. Since cached PASID entries that are marked
>>   * for removal don't need to be iterated, we intentionally handle
>>   * removals before additions to optimize the replay process.
>>   */
>>
>>
>>> +         */
>>> +        vtd_accel_pasid_cache_invalidate(vtd_hiod, pc_info);
>>>            vtd_accel_replay_pasid_bind_for_dev(vtd_hiod, start, end, pc_info);
>>>        }
>>>    }
> 


