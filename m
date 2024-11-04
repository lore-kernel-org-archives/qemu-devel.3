Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4749D1119D
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 02:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7n7O-0004iB-Fn; Sun, 03 Nov 2024 21:47:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7n7D-0004fY-HH
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 21:46:55 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7n7B-0000bl-80
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 21:46:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730688409; x=1762224409;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Dc71Xkm1mUlZWIdF8Z+iNsxqWvft5bAfylxK3FOYDto=;
 b=jCJFuPntV+IWcWI8x+euOu2T6zOurLdr51g3vXvqiDxeSlcixu9zODTz
 G1VrNI+EvTWdjwikGoPJNKRpxpz4hUgs8lAhJlbjqmUMEEP9qyr2D4J/3
 BeDi09nyGmFusQ5e2NybyJl45LDtnUm8D0e9P/m4xHqfFLh9Nr/9fvtyn
 Sn7zUauoDs76vurVuJIzFKs+n5TH4Q7lnlmBfrU/tJRYw2FQMs8S54SZ9
 tpl+WeEUTt3HulrtKXEwTfAivCdkDzMpMzGy2gMxuAVShciYqI6q9YRPM
 nZUnnhLgQ2I0Puu8fnePuu2xPJEX0HLcK2d9An1uYkx+LzCvsQAGFpza5 w==;
X-CSE-ConnectionGUID: kZflMn1SSX6oUsr4Sb7H0A==
X-CSE-MsgGUID: AXLomVFKQ8avivrJyMrmug==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="30248067"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="30248067"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2024 18:46:46 -0800
X-CSE-ConnectionGUID: yExsxiLUR3u7El6aajgYiQ==
X-CSE-MsgGUID: HCIhdO10TSy7nZmVkQpr7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="88652801"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Nov 2024 18:46:46 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 18:46:45 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 18:46:45 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 18:46:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfqGED/7wiQcUZ565yLvYCBsVXVSvaMCnHP0RhVpVlSeHDpBXboWT/avNZfw8MeW0+065PH6cF7zsR5Mv/gB0yO+hkheNDn40mFFqjoC9uVohVZcXA9iceZTZIsclZlazQrmzNn1theb4Yv9Gfs9QcIjAFrWpu/YygFH0Br/4rMzARokDpq0VSm2hyrG6ciBF4VFUsX4raXSCULLSxSAKz81RKx+rrB4j00iFEteyyGxCXQgXK/RzDwrhtmX/c4yJpq1GzmiaKl4xWFc8iYgzCjLA9688B0SelDhagCZXw+3IpNXWVIduFScf7WHAKL8cjRm3pHOq2IAC89m2+FrTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qe6UixDRFGXC+SttS6v/qYpgiJr0tjlvqzfl8Wea4zc=;
 b=A5PiKVkb1VoqavxhfJ4Yv8SZxwbeAcqu6nZSZmAcsxbcPr9NoUNH1+tw1Luk8AvJ+k2X5iJb3WZpuxqGuwAnHR3kVRPNE/Jhpiv/wMDEoM9lRWuPNXlvfXJ3dvshPPOtYXePR8U8atcdM62gKeuNksK0ZqdCSpqucC3/ze8Cqx5MKoMSOFsWTobzTtiKhFJXbpjjCltg+WzF1bhcJkOEVjM5+dPKmag+m3gu1OIW787K220hb+aiASQWb6nqnyw3hHmVteOdQseVffDLBndFsowDlPgoiwtbYml9qMidBFS9ywI2GXAsEloG6pZW51WugpLBUk9gOUuj7uVgkkqsxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB5070.namprd11.prod.outlook.com (2603:10b6:a03:2d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 02:46:38 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 02:46:38 +0000
Message-ID: <232e776b-2fea-40dc-894a-5df80434fd61@intel.com>
Date: Mon, 4 Nov 2024 10:51:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/17] intel_iommu: Add support for PASID-based device
 IOTLB invalidation
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-13-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240930092631.2997543-13-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:3:18::36) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB5070:EE_
X-MS-Office365-Filtering-Correlation-Id: 5828e507-6e98-430f-6d77-08dcfc7ae787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFd5SnRTTVl4UlVzOCtJOGxXMDhYU0Y1UTdvL1JCc1ZkMmc2clF4UmhsdXFv?=
 =?utf-8?B?Wkx6Sk5aMlJBbGlzOVJmTGVuRWJpQVpOQ0V5UEt4V3cxbVR4czQvangySEhS?=
 =?utf-8?B?OTgwS2dyRDNER2tBcENKZGoweDRZMzcxU3RaK2JlKzVPOGdYK05FeUxtOGRE?=
 =?utf-8?B?dWh5aTE5Yll3Yk5FWWtPcERFR25JOW9yMWdjQVJScGVzZjQ4MUloVkxXMGRi?=
 =?utf-8?B?VjJnOXR3Nm96WGZHUEZjenNtUTN0M1RaKzRlOFE1U3pydmR3a0Q2RmNWdTh1?=
 =?utf-8?B?Q0lacHNnaXlHcHNuZWJhT1NFd3FLNXBZUzl6ZldmYVRVQTVsN3ZLdittSmxF?=
 =?utf-8?B?U2oweUx5Q2ZrMDZyQ0tUM0R4WEtYZ3A3M3ZqeUNPUjBjVGV0aG9MNFQ4Qy9X?=
 =?utf-8?B?S050aXVPTnQ1K1FqNnFpOGhIbEMra3FtMmF0d0dhQlQrMjdlcFRydGpGV04w?=
 =?utf-8?B?Yi9IZFlRY08vdW5Eb1FCYW8vUEtTQUJaUVB4RmU5WnhIRzdlRW1ySkkxU0RB?=
 =?utf-8?B?cFlSeG5pNTR2TVI5TFlsdTE4UmgwRjNSeFpEUk81Qkt5Vnc4Zk5yN3ZZM3Rz?=
 =?utf-8?B?TnMwUUVWNHZueGN2UHFQZjZXbTdZdTVETm9PYnRXWjJXKzQxS254NUV5eEI5?=
 =?utf-8?B?L1JIbVdxWnczNlJFQ1o2UzdqTTZlRjgvYWVCVGk5Z0E0anZoMVMxM3cwVGJj?=
 =?utf-8?B?MFRoSUtqS1ZYdlhQcVFhazJtdnJOVEVKVDBQM0JOMkQ2WUZlRnhiU3d4TDha?=
 =?utf-8?B?ajVnc2IwSjQrUDVqK3B5eEk1Z0Qwa3QxOXNSZm5pTEg5UjZ3d1RYMGJMeElk?=
 =?utf-8?B?WUE2M0ZISHVPY3Z0SEhxckFlcHIxWHgwQXoxWFFJYzBiRUQ2YTRPeFMzMnhB?=
 =?utf-8?B?aytMeXZkYTBFOTArUUE0OGJJdTlMd2Z6L2JSU1daTWJHSlFsZGo1bVh2OWIw?=
 =?utf-8?B?MVEwVmZqQkhrNEtDbzVsLzU3ZThIOHlUZzJFTkVqK0VZcmV6VDMrSHdtWHBG?=
 =?utf-8?B?ZWRVU2VzWmV2RGE5MUhpQjczdElScGlzc2V5eWZia0lHcVc2cUM5elBheFhw?=
 =?utf-8?B?T3pQODVDdllrVWg1SW5sbE1qY2xOQklycXZUMmg0MmJMb0kyb2dmMERUOG9Y?=
 =?utf-8?B?bUZsRXFVNXhQLzlqTGkzYUQwSXk4UmZlQ29DWU1rekdRSVlLdy9FcHNvV3Ux?=
 =?utf-8?B?S1pNNkFRSkZrN096cndEOFlBbGF5WFh1RjIyekhqSlFnZGFmVHhscVhjOW1t?=
 =?utf-8?B?L01DUlF4VTRBL3ZxY24rL05nZDh1RWtOWkdTU0MzdWhWTzlWaEZERHRzNi9p?=
 =?utf-8?B?Z1pMSDI4Wm9ERCtlZkxmaVVDb3lKbUNIbm1xeElIUUFZYzh6UkJxYWlwczgx?=
 =?utf-8?B?N3V4OWh5TTV4OGtOMVBmVVFTVjRicnBEWkJ1c1pKNnZhSVZBbTQySzFyVGRm?=
 =?utf-8?B?UTB3Ny93OC9lSjR2MkNRN0JXWC8zQUNsbksyeHNxOE10bmxXWUFlcWlENzlr?=
 =?utf-8?B?Y3F1UVBVaGJFUXpUemVuNkhSbXJDMi9QNjh1QjFqSi9yZ3ZWdG9FK3BSUm50?=
 =?utf-8?B?N2F5OENXQ1FNWHBRbmtvUnlHYUtTQnlEL2h0dEY5S1hrOGZldlFOU3RReVpO?=
 =?utf-8?B?eituZkpKWkg4dERiTGZXRVhUSmtHYzhqMjNaREdvRGVjcTRHZlgzTG5YSUlE?=
 =?utf-8?B?QTByL3N6eG5pNDlVN3ZyazJpME01SXBpYm55YXN5ZGljYzNzdTFQSit5cUhU?=
 =?utf-8?Q?oNV+81KS3596YttOSn3jpaVMNScd1BVA2+NIXtj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1UxM25VSTkzQlY4LzAvbzRLMzJ0d2FxQUxkZEh6RFFnWWJLT3c2bVdCVWxq?=
 =?utf-8?B?SlE4a2VYa3dvellJR0p6NjBCckNYUU1yUmdHWmtxV0x1VE1DOFdVa0lab1Vj?=
 =?utf-8?B?NldIekUyZk5PZzI4MFJ4OWlzak5TaVBrOUxDTkxkZyszYURGTkVac3BmZ3F3?=
 =?utf-8?B?RjQwZHB4VnNUKzIrZlBvU0dZODlWZ1hUNFN1TzJCM1lrWXB5UEllNFRSejJL?=
 =?utf-8?B?dnA2V1ppcHcwSEtHcDdvSFZ5QWxDT04yenVBUGk0aStHWnFUZmVQOUFhSklQ?=
 =?utf-8?B?TmVFc1RTU1pDbUdGS2kxd2oxM1lTR1hTcEJJcWVGNEFoN3ZZOWxuM2ZOeklT?=
 =?utf-8?B?T3BMTVZZWk5DZWwyeVNLYjJBVUQ0SW1HNTkxM1hnOHBWZUdEaGhTcmFiMmNL?=
 =?utf-8?B?c2x2ODQ0RVlPWjZiTUdyTzNiZmxwcTEzY2srZ2lseURON2hReXlMT0tUejBN?=
 =?utf-8?B?Ykc5SU56OWR0d2pCbkpEajZPemdIaGZRaVB2UWZwZTY0SEVDZ2l6ZnE2K1gx?=
 =?utf-8?B?aDB3d2RJUkN1TDVmRXNjcndMK2FVMzhRejkxUUxMMXllZ0JPa0pqNy9qZ2dE?=
 =?utf-8?B?WnM2RUtLSS9DZTVYTm1RMytPdjJoODgvY0w3U0JsVEpQbGVxR2ZiMlY3NGJl?=
 =?utf-8?B?SjV0aGt3bFdna1JqQ1pBSGdwcDUrdHQ3dnk3SFljWFNFNHU4VmFUeHNvbG9z?=
 =?utf-8?B?a2tyT1Q4WG1HQlRhbFhSL2M4NjdBdEd2eWNpdTFkTjJPVThxTjV6KzNoVU1j?=
 =?utf-8?B?OHRlem5oVGlRT05wNjlwNDFxRnBCcHJ2SHB1UXQzcExYZExsMnpLelpVNHB2?=
 =?utf-8?B?ZGc1aDVuMzFCV3lXQkhiSnZFenp6ZmlCQmRpcVNmdmtrQWQzYmkzcW5ZbE0x?=
 =?utf-8?B?NitObGNZUXFRZk1aZzByS0ViUktZelUxa3RyVnhlTXA5aWl5UVpoTlg5RW9k?=
 =?utf-8?B?SFZwem5NNFk2eGdxSk9sTjlTK1dyZU1HSmxnNDRNT0N0ZWVIL3lqYnEyQm54?=
 =?utf-8?B?M1czVFdraFFhU0lRTVB2c1dXWG9TdUdhVjhVK2N2cXRyTGZYdEhwOXR3Y0NH?=
 =?utf-8?B?WGpWTEdoRmJkZEgwT1hQMkZuQkVYRTRYejFZY2ZqTnRiWVZrbHRPaVRXVUtP?=
 =?utf-8?B?WFhjU1o0aDhWYUQ1SmE4aGdwSzlGRG1yVnMxQjZlVUJyTlZhdWx3cDNqc1Z2?=
 =?utf-8?B?Q0MzZkY5SEJ1S3JXTXhFQ0syREV1NHlwOTlZd2VWZU4vVktOVDczTEt3c3hz?=
 =?utf-8?B?Vy93UDJXYjFjQU5iazFqN2I0Tms1Yy9mU1ZkNVkvUTFobEMrWHlNT2s2aEMv?=
 =?utf-8?B?aCtOa1VWaFlLSE1ZOVp5WE1pTVU0TDBYZFBzbjNoMGphRFhUeWx2UWdQSDNT?=
 =?utf-8?B?cHJlYVBZRWI2em10UWZyWDNpUkhIeDJ1VVVQUHQ2dXFmcVhqMHdybnRxL25E?=
 =?utf-8?B?WklHVVZiOFpIY0d6SUJ5Rk9nWFFOLzJFbmV5VU00WVZ1VFo3S0tTQzlrUXUx?=
 =?utf-8?B?OEY1cjhTQ2JYcy9KcThRZ3JrcU9abHd2ckN1MDh3NFoyK1pzajJKamJFYjJl?=
 =?utf-8?B?STVycDlJUFhuUUpCQmQ5L3lrQjJpWTJoM2FDdTJNY2ozMnkzY2U3c2J5WXNI?=
 =?utf-8?B?V3ByZWg3UVM0c2MramswcWRQb3JVT2tkMVdzU1lPcDhpd1FSaTBnUUpFRlZi?=
 =?utf-8?B?TVN4S0s0dlk2NEg3UHh5ZHZzNEJ4WWpiYmx5L3RPYnQ4TzRtZDVLZnRCbGtB?=
 =?utf-8?B?OVpPR1RRcWJNaFlxSjFTTlphZmNTams4VFZPbXVlbnZOd0x2MVJEM3hqZllI?=
 =?utf-8?B?NXNvbGowdW1uV1dQeFVpdHpCT0hvdHRnLzd4alFCamM4L0tXLytyWmRrRnNN?=
 =?utf-8?B?dURIbVdJb2JnMUNJUGZsN2tJNVNwSENLellGSzlQSnhyMVBsMjcrVDBuWms2?=
 =?utf-8?B?VGlxa0RTSk9Nb1BubmVUcFhEYWRnc3dwN0liZEVmTGRlMGNHejdDRWl6NzVM?=
 =?utf-8?B?S0Zjc1FDMjRMNUNhQnpqaUxDNTRiTWpnMWZqeldsbmdJZXZtcVhOQXdnc1BP?=
 =?utf-8?B?eDVOWHFWZUJaUlF3VFJFQU1IYXJ0RWh0cmdnODY3eDdmTXNqSjdocEFvcjJ4?=
 =?utf-8?Q?X1e85gcZ9HYCWAUzdP4LBdx05?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5828e507-6e98-430f-6d77-08dcfc7ae787
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 02:46:38.1650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxp3qp8+OxVPFLOM8WdpGPMTzvi3Q+TknErBLgzZ+eemk9uQoY6FYHVbLXaxfYbtI6+NMUgk9HRYYorikY3XKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5070
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_internal.h | 11 ++++++++
>   hw/i386/intel_iommu.c          | 50 ++++++++++++++++++++++++++++++++++
>   2 files changed, 61 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 20d922d600..2702edd27f 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -376,6 +376,7 @@ typedef union VTDInvDesc VTDInvDesc;
>   #define VTD_INV_DESC_WAIT               0x5 /* Invalidation Wait Descriptor */
>   #define VTD_INV_DESC_PIOTLB             0x6 /* PASID-IOTLB Invalidate Desc */
>   #define VTD_INV_DESC_PC                 0x7 /* PASID-cache Invalidate Desc */
> +#define VTD_INV_DESC_DEV_PIOTLB         0x8 /* PASID-based-DIOTLB inv_desc*/
>   #define VTD_INV_DESC_NONE               0   /* Not an Invalidate Descriptor */
>   
>   /* Masks for Invalidation Wait Descriptor*/
> @@ -414,6 +415,16 @@ typedef union VTDInvDesc VTDInvDesc;
>   #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI 0xffeULL
>   #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO 0xffff0000ffe0f1f0
>   
> +/* Mask for PASID Device IOTLB Invalidate Descriptor */

nit: s/Mask/Masks

> +#define VTD_INV_DESC_PASID_DEVICE_IOTLB_ADDR(val) ((val) & \
> +                                                   0xfffffffffffff000ULL)
> +#define VTD_INV_DESC_PASID_DEVICE_IOTLB_SIZE(val) ((val >> 11) & 0x1)
> +#define VTD_INV_DESC_PASID_DEVICE_IOTLB_GLOBAL(val) ((val) & 0x1)
> +#define VTD_INV_DESC_PASID_DEVICE_IOTLB_SID(val) (((val) >> 16) & 0xffffULL)
> +#define VTD_INV_DESC_PASID_DEVICE_IOTLB_PASID(val) ((val >> 32) & 0xfffffULL)
> +#define VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_HI 0x7feULL
> +#define VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_LO 0xfff000000000f000ULL
> +
>   /* Rsvd field masks for spte */
>   #define VTD_SPTE_SNP 0x800ULL
>   
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index a1596ba47d..5ea59167b3 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3020,6 +3020,49 @@ static void do_invalidate_device_tlb(VTDAddressSpace *vtd_dev_as,
>       memory_region_notify_iommu(&vtd_dev_as->iommu, 0, event);
>   }
>   
> +static bool vtd_process_device_piotlb_desc(IntelIOMMUState *s,
> +                                           VTDInvDesc *inv_desc)
> +{
> +    uint16_t sid;
> +    VTDAddressSpace *vtd_dev_as;
> +    bool size;
> +    bool global;
> +    hwaddr addr;
> +    uint32_t pasid;
> +
> +    if ((inv_desc->hi & VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_HI) ||
> +         (inv_desc->lo & VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_LO)) {
> +        error_report_once("%s: invalid pasid-based dev iotlb inv desc:"
> +                          "hi=%"PRIx64 "(reserved nonzero)",
> +                          __func__, inv_desc->hi);
> +        return false;
> +    }

Echo the prior comment about the check to the higher 128 bits.

> +
> +    global = VTD_INV_DESC_PASID_DEVICE_IOTLB_GLOBAL(inv_desc->hi);
> +    size = VTD_INV_DESC_PASID_DEVICE_IOTLB_SIZE(inv_desc->hi);
> +    addr = VTD_INV_DESC_PASID_DEVICE_IOTLB_ADDR(inv_desc->hi);
> +    sid = VTD_INV_DESC_PASID_DEVICE_IOTLB_SID(inv_desc->lo);
> +    if (global) {
> +        QLIST_FOREACH(vtd_dev_as, &s->vtd_as_with_notifiers, next) {
> +            if ((vtd_dev_as->pasid != PCI_NO_PASID) &&
> +                (PCI_BUILD_BDF(pci_bus_num(vtd_dev_as->bus),
> +                                           vtd_dev_as->devfn) == sid)) {
> +                do_invalidate_device_tlb(vtd_dev_as, size, addr);
> +            }
> +        }
> +    } else {
> +        pasid = VTD_INV_DESC_PASID_DEVICE_IOTLB_PASID(inv_desc->lo);
> +        vtd_dev_as = vtd_get_as_by_sid_and_pasid(s, sid, pasid);
> +        if (!vtd_dev_as) {
> +            return true;
> +        }
> +
> +        do_invalidate_device_tlb(vtd_dev_as, size, addr);
> +    }
> +
> +    return true;
> +}
> +
>   static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
>                                             VTDInvDesc *inv_desc)
>   {
> @@ -3106,6 +3149,13 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
>           }
>           break;
>   
> +    case VTD_INV_DESC_DEV_PIOTLB:
> +        trace_vtd_inv_desc("device-piotlb", inv_desc.hi, inv_desc.lo);
> +        if (!vtd_process_device_piotlb_desc(s, &inv_desc)) {
> +            return false;
> +        }
> +        break;
> +
>       case VTD_INV_DESC_DEVICE:
>           trace_vtd_inv_desc("device", inv_desc.hi, inv_desc.lo);
>           if (!vtd_process_device_iotlb_desc(s, &inv_desc)) {

-- 
Regards,
Yi Liu

