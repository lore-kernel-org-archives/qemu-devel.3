Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC0EC52D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 11:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seCeO-0008D2-7Y; Wed, 14 Aug 2024 07:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1seCeM-000879-PM
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 07:58:46 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1seCeK-0003d1-9z
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 07:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723636725; x=1755172725;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xJTnpU2e75vwzgj07cqccRrDgxkeitOwse1IWm7dZeo=;
 b=UWpSvoQns7i/eimS22kzQBEbpHbTX0c0TQ2k0Qutnt2QFz3hI9DgMXB6
 IG55aHVGjxuNV1Slh+KMmi926/mmuoH6vms6IyDLS2X3Omp8cHMGl9feB
 Tkcu7SmqaJHo6SKGDaZ9L9zKUYRyaglccbqI8u9nMVtMQfbyHJWwqBAds
 zfm3UElOaTGVNnfqUCzpe0PjdOSzq6OQCswSMsi+olc7qQA/+evPiccLL
 muP1TX5YnEoXgH3n3mBV/reEmx/IL+7iY9y5tQcS9optcFC3y/aJgxJXD
 Jrlgp1zRe/4gm8Ue2Yyupb8xpSTWEKyLC9PQgNG8v/nqjODY+1IumooQ0 w==;
X-CSE-ConnectionGUID: 0qbvRmdiRNy39W8p7GMHCw==
X-CSE-MsgGUID: oeGFk+psT9eNbFUWuXywKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21985913"
X-IronPort-AV: E=Sophos;i="6.09,145,1716274800"; d="scan'208";a="21985913"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2024 04:58:41 -0700
X-CSE-ConnectionGUID: RgtvO/6VToqcblqy7h9YvA==
X-CSE-MsgGUID: HJ12mmv1TSqJMWF6HL7ycg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,145,1716274800"; d="scan'208";a="63392547"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 Aug 2024 04:58:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 04:58:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 Aug 2024 04:58:40 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 Aug 2024 04:58:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpI1uxBc17fE6k37DCP4cMMRc5hgfQVrdKc3CT6+OQfYfsMjAv98hV68YdSAF8BVuggrOJUJ3nkcNlJzZbQ+z3AcRVMNgKHzhcOhqEe/SiUWB9gDxfxgmBVwo1QBEwRkcRlD67EsAGFKcAQe53QaWeEoj3WJ0QtmVsu2xuE1DEQY4P0WmSzYAJozBSdkbEe6rB44aUT/QDz1V3TqD1gD9KVNTlyUE8jqbOJfOFeisijwO6Dy+rB47ouaTZuilEB0nKsrJ6zUyHQ9l03GojWYDC0iaO80V2bCTaBIysYDtFeYvgjMWWtlu7ilZZMgAl5hA2HW7H1y4P24SPiEjTG6RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W41oPSPiCRDy5XfYZiMR38KzsxC0r0CB00Tmnp53FVE=;
 b=LvHFnMq1z+DWVoe6c4RJHc5BY18clsRnySuvSeF6mbE9TxOld9mGWjGhHDF6pvOsyAujzefajXCD4uNblwy+KoP2B2pKPYkPZZi0jgH1Pw7kXTEU+sBsCnOk0nvUD4ugFMVcNJ7wJi7bniol4SDby9kLkDZwF0qe0UoofTDBVMSjfBeeUky0n0juhPpDSL+xuLej+hd6/qM/lE+6CuAEUmtly82gZpKcTs4bTgU/P2YvHirvI6bpTAd/3i4uhGtJChT4JdRAPyI64K5EyStAUTyebQioa0y7H/TS1nrfIrBhBgJeRJMf11UFPCh2n8g4qpv3zdEcIBxs5moApI4WIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA1PR11MB5945.namprd11.prod.outlook.com (2603:10b6:806:239::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30; Wed, 14 Aug
 2024 11:58:33 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 11:58:32 +0000
Message-ID: <ea60177f-697b-40c0-9f70-b3ac56e88e06@intel.com>
Date: Wed, 14 Aug 2024 20:02:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/17] intel_iommu: Check if the input address is
 canonical
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-8-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240805062727.2307552-8-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA1PR11MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 23812605-2784-4047-e88f-08dcbc586b78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: BZeGJFdgjdA/UstRnGwQok7Kbd/rOTJ3EdVEA5SfiWa+bLe5+f0xOO0S/Fr+1RaL/HnHI8mYo62Lor0gdP1PNMF5aRDsiIBUR2CYHR1zD10bwUkA4GFeMtsKTjkLD2YJyqN58+b7OWXwTAORoPef4UUmimgkDKprkpU7wGaO8uRYA9Q2ARhliAc2IaeBTu32QVKV26VlyiUEmlV/e7WLckUfAbeqBWHeQyQr42501lv4ase9A/qbKpHpyI4sos/0qrkLXe+11bl6FTFhk+h7bMd/159/Zl4lxGztZhi53XH9EjXt5/XYlAOinlamzT6S5dk8P7r4lkfbwYquvVzjxRnfv6PhBKJ59zTqV64CxBSsqJtcpFqer2x5K+8ySq2h0tQL+ZUnGlxhhT7LD6QC/2Dl1F4Ee5U8DMe8Jmx3G/pSKfmKjDTn0/ST/cLYYVeCVNr9NiLyPybMOgMOPjBMJnrXSfDxzPGyK4bcCz49yTgu7B9yM9wdn+qCgbHYahRl16JT8YizZ3w8414N5gdNMIgI235cuxVIfSVLhOQv4Mnvtw1BJDLLSVULqGgOzMdAVZCgnQYzFv3zOt44RF+6nlear1pO1V6hCaAGcs7CmBzcjy/Ej6eEGgyu68MWPoGN1FAeB6YuVSRRb87QK+t+0R5+PA9KcO2vzPiIUcbRUx8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WldnUmRyVXdiM3d4bjVRZFlHQXV6RGxnbG01eHg5YlJQV084aXdVMnJPY0tB?=
 =?utf-8?B?b0U5MmdlWHhDUXhabDhDeDU4YkMxQmM0YW1tb3ROWUVEMVVOYjdoeDI0Mmxi?=
 =?utf-8?B?d2E3MGxta1Q5QkhsZ0liV0F0Ri9HOXdIemg1RnRUbzdnbDRYc0tnVXJiQklF?=
 =?utf-8?B?NVYwdXg2TWVzUFdDRUtoQWVZZ0VUcWVVWnVWQWVDeDZPNHQyQUVJenE0ZG9O?=
 =?utf-8?B?bDRDSEF1NTNqMjdCRkVJbEpxSDhoU21tUTcxVExxREt6cVVGL2grYkN6QmJI?=
 =?utf-8?B?K241aVI3MlA1bHNXcmhXZnZZTENCSHFXTzQrODNoOEJMbVFrWUgyV3R5bzFE?=
 =?utf-8?B?Z0owU215VFN6aUowdytlekNNNDVnOFdUY3hIWHFGaHU0OXRCemtPUG8rZjha?=
 =?utf-8?B?WnFCSXVteDNVV3R1b1pSeTJaZU1RMTlCTXd1VmgwWVFRTS9xT3ZHMmxiY2Mv?=
 =?utf-8?B?V3lFSy92eVZGcUI5RFljWVBOc2tEcWV1UFhLTmZpSm00RWdPZXJMMWtORTM5?=
 =?utf-8?B?S3BWeUV6SUt0ME1UY01CcGtBNWxJYkEwblE5eWN1cDR1blNCQmtYVTBoYStY?=
 =?utf-8?B?aVAzSVFUdnRXak52dUhEZWJJdi9sVGtqNEwwVkR6bENsdnlyUFVIM3dXcnI1?=
 =?utf-8?B?NTZ1VjJwVnhZc1Z5TkpwZGU5VHY1ZXdQTE9xNjBTUytLcFVMNlgxckhMT1Er?=
 =?utf-8?B?cXg1TUcrT0dzMGZDblUwdHRraHBSblQrMEZsVFl5aTVWY1Y4K21JR2lLZWpm?=
 =?utf-8?B?ZnpUYk1FMGVIQU1FdmRDdW10NUhtR0tlR0s2MjJlMkcxbUEwK1VtdjRhMEht?=
 =?utf-8?B?TFZrb1EyWFdHSTJkUUI0a3VhaVNxWUEyWVRkUWxrMzc4eElqWGVsb3VYTnZQ?=
 =?utf-8?B?YlRsV1BQbmxlSTI3cWF3TFBoNDhHMllqVHhPdDBEc1dmSG9jY1JQRVdEbHMv?=
 =?utf-8?B?MUZORXlValQxMWhyYzVUZ0NEVjc1N25MSzM1K3ZSUmpZdm8wckZ0cXpsa1dH?=
 =?utf-8?B?K214TGZ3ZFVDbWNPZUE5QVpVNzZ4MEJFNXNPQTdvZzdpSmNWeWtTa2h2T3RZ?=
 =?utf-8?B?elp5dU9zOFlaZnFsOTBneExLWmdqSWhmbnVwOG1nRTB4YmJSRk41TXcyRmhJ?=
 =?utf-8?B?dlBjY2UwR1YzcGxpT3VsaGRpVFVCUWZRd2thWXVWSERwTS9MTktRamFJbkxs?=
 =?utf-8?B?TmROMEdUdEFQM3RkTXFPeEk0ZlpNSFVVRFJ3TU1BejE0SFlXWU1LbStjdExX?=
 =?utf-8?B?T2VzZVk2MUI1K2tQWTZzK0xKUDBpNUFFc0piS0xiYkJTWFQvcXB4dkxYYld6?=
 =?utf-8?B?TVRCQ1NpWnRSd0tCS0U1ZWlVa2xJM1pUdHJuUmJCbHA1ZVpjZHRoUFNnTk9l?=
 =?utf-8?B?ckIrUEdZQVBQeVAvWmY2Wjh4c1VvdXBqcWlEVk9OYWZGMHhZaVUxOThpWXBm?=
 =?utf-8?B?bkFTMXI1eHcwbE55dVpkeWtPYkVITUlsamUxblpDUE50NXZkTURzWnJBZGJl?=
 =?utf-8?B?cmZBZmVzamFPMjVlRlNKWUdEcXhicjYzZWVqV3NzVHhmdWRTWmt1Qmk1TUxX?=
 =?utf-8?B?bStXWU9vQXFiUVYzeTZ3WG4yd3dnU29uRG05T3JISGdnZzJFWTZGQ29jWFhV?=
 =?utf-8?B?MDNXL2VhbTkzUVhhTHNxNlowNjc2dzQycjhvRTRHQmZVVnhCcHhFS2liaTdp?=
 =?utf-8?B?dUxMQVdseUl3R3RjdXFCNXpHaEdSMnV5NTdMZG16YSs0eW1XZFlCUk1sYUM3?=
 =?utf-8?B?aVVvM2FKWDJsZUxkQzBZRjRBdHBZOTlFenFWdFRPc2JxeFovcE9EZjZJMTM1?=
 =?utf-8?B?Zk9vMWQzTVlwTWVCNm9SWlRqU3dNaGF3KzJib3FWTkhCR1djc29QUjA3Szlu?=
 =?utf-8?B?MVlIQm1kWmdqaVdScG5xeWEwdUdYMEsrQ2UydFhpWWlqZEhkRzYwSUh6S3FV?=
 =?utf-8?B?UDFUNVZzYU9rbS8xbWIyU1djZ1cxYlhQL1ZWVUVWOExVcUNLbHdESkErRkJj?=
 =?utf-8?B?MjBFVUlQbHhTcjN3SkJoRDNEUFhsQzcrWk5DQUhrQTFvVkR1dXFHOEdleTZa?=
 =?utf-8?B?MzR6VVIvbUpuVVF3M1NPN2RSeC8vbDJhTzJyRDUyVHFpc1ZFK01aRTNaenFx?=
 =?utf-8?Q?I7CckPwQKyiGAsDO3iIBqwTI1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23812605-2784-4047-e88f-08dcbc586b78
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 11:58:32.8934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MROyJ0ExsslpfW/P6ziQSqERiWeDC8EmC35Q1aXSfHbcPK0SSI45cO6zqd8AyOM/jqcb9mhm3F2Ah/9zDDYWPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5945
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.135,
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
> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> First stage translation must fail if the address to translate is
> not canonical.
> 
> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_internal.h |  2 ++
>   hw/i386/intel_iommu.c          | 21 +++++++++++++++++++++
>   2 files changed, 23 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 51e9b1fc43..668583aeca 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -320,6 +320,8 @@ typedef enum VTDFaultReason {
>       VTD_FR_PASID_ENTRY_P = 0x59,
>       VTD_FR_PASID_TABLE_ENTRY_INV = 0x5b,  /*Invalid PASID table entry */
>   
> +    VTD_FR_FS_NON_CANONICAL = 0x80, /* SNG.1 : Address for FS not canonical.*/
> +
>       /* Output address in the interrupt address range for scalable mode */
>       VTD_FR_SM_INTERRUPT_ADDR = 0x87,
>       VTD_FR_MAX,                 /* Guard */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 0bcbd5b777..6121cca4cd 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1821,6 +1821,7 @@ static const bool vtd_qualified_faults[] = {
>       [VTD_FR_PASID_ENTRY_P] = true,
>       [VTD_FR_PASID_TABLE_ENTRY_INV] = true,
>       [VTD_FR_SM_INTERRUPT_ADDR] = true,
> +    [VTD_FR_FS_NON_CANONICAL] = true,
>       [VTD_FR_MAX] = false,
>   };
>   
> @@ -1924,6 +1925,20 @@ static inline bool vtd_flpte_present(uint64_t flpte)
>       return !!(flpte & VTD_FL_P);
>   }
>   
> +/* Return true if IOVA is canonical, otherwise false. */
> +static bool vtd_iova_fl_check_canonical(IntelIOMMUState *s, uint64_t iova,
> +                                        VTDContextEntry *ce, uint32_t pasid)
> +{
> +    uint64_t iova_limit = vtd_iova_limit(s, ce, s->aw_bits, pasid);
> +    uint64_t upper_bits_mask = ~(iova_limit - 1);
> +    uint64_t upper_bits = iova & upper_bits_mask;
> +    bool msb = ((iova & (iova_limit >> 1)) != 0);
> +    return !(
> +             (!msb && (upper_bits != 0)) ||
> +             (msb && (upper_bits != upper_bits_mask))
> +            );
> +}
> +

will the below be clearer?

     if (msb)
         return upper_bits == upper_bits_mask;
     else
         return !upper_bits;

>   /*
>    * Given the @iova, get relevant @flptep. @flpte_level will be the last level
>    * of the translation, can be used for deciding the size of large page.
> @@ -1939,6 +1954,12 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
>       uint32_t offset;
>       uint64_t flpte;
>   
> +    if (!vtd_iova_fl_check_canonical(s, iova, ce, pasid)) {
> +        error_report_once("%s: detected non canonical IOVA (iova=0x%" PRIx64 ","
> +                          "pasid=0x%" PRIx32 ")", __func__, iova, pasid);
> +        return -VTD_FR_FS_NON_CANONICAL;
> +    }
> +
>       while (true) {
>           offset = vtd_iova_level_offset(iova, level);
>           flpte = vtd_get_pte(addr, offset);

-- 
Regards,
Yi Liu

