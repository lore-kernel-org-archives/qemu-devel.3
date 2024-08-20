Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7A3C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 02:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgEmq-0002Z7-Sb; Mon, 19 Aug 2024 22:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sgEmp-0002Xk-J8
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 22:39:55 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sgEmi-0003rq-63
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 22:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1724121588; x=1755657588;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ocQ/d5c8H4EYZ67ACnt0c21iL5XirdMCcm4FytVRbPw=;
 b=PCiD1eOAoOJtd+CI/4+zBKOvzV8dSnvVNfG4x0gOi8XGpFUIhIcqJeFx
 eIT1wH3PjaDZtMX1HI2OBn91v05u0jmLiE8WqaHoNKHLc7vuUVOXiaA11
 7F2bDz2J3pen9vMHhxJakbLXY9UeMokVLb2Nalond2k4257BoFyrHHu7U
 JYMr0A2CjkOdS6CidCglLmL/zDAQPsnpVYCPAQcEU88xXfjKeo67tgPvf
 MZqbgU3js5sEpck1QjhgB/jUEf5MGlNZ1T63t6wLQB3Hi7qa2Ms3fujRO
 AaG44ay6BNgyP8DZ7B7jkm44ftye+fp79ZK3CwzcBDfO8VDzkxpBe8iZn A==;
X-CSE-ConnectionGUID: YUmXjbe7TS+zhbwu5JjrpA==
X-CSE-MsgGUID: JI3/m7t7QbaYrvWCn8Y3NQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="39903813"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; d="scan'208";a="39903813"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2024 19:39:44 -0700
X-CSE-ConnectionGUID: 9nmoWc49TdSg1PGSlPRNMQ==
X-CSE-MsgGUID: EroUv+iqQqeK0pnox+wu9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; d="scan'208";a="61341717"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 19 Aug 2024 19:39:44 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 19:39:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 19:39:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 19:39:43 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 19:39:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xw+C1aedMl37gOC+BeZgzv3ZRzUGcYReFq9+gDgrj7bfFcAUFCpM5OLIVFm3e9mbPgVU7TiR2lciehIcKICkpunlHgc3RoERW+TcabeFJT02QpA82EG8APj5S2EmaXr7MuKvAOVN9dre+GPsLyG/F2zvYzCPCRoG2OhkIC9Cc0NMJ6o/2vQj7bAxUBZk5DjX7x/VqHyiZJNbrYoPoeXcpm7HuZLO71QEALTQGkdANsQx7OVOwPkMfbWyxLWph1U2efZvK4D1KcD75x8FKk1M4rOnDI/u6bjA3aY4MB3OQha+/cYn1tLdYs4Oax+g0mvO0Q7I1ooMLcw/hf4xulmKzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DK+jyGL3yNsWNLVt4kOBwskAL+dV2lgG4IUatgZ6/jE=;
 b=gdrkxx+9e6TLqPyLhiyqGaN6I/S8+TpNCjs8+DphIxMll0Hi6XrZmsa96McrCpJURtPU1LOfHk+cUMbiVq2eJORgj9I6Do0oUsCV8xSXjG+1vsuAJ2kGMuMQQKC4bNaMlpJI3/JpLWub6T7cVGHZngGhyD5B0+u2Sr1fDPANoKWKS0qPMg+5YH8qj8nORayNeRyyTDAYaOj1TkX9Ti+NDx0V/saCLl5xN38dcSb0JxWlXX60NLWPxSj10RgfWtHcjoFRgrG6GLdmS07JmeafuNbhFICkR5kRWDfJTpvQhNSAWlR5ynm8S+QqgXNlH7hC+2WUUnn87B0iu9K3lCFK3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Tue, 20 Aug
 2024 02:39:40 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 02:39:38 +0000
Message-ID: <22c3b127-a521-43de-a34b-ae4ba39af35b@intel.com>
Date: Tue, 20 Aug 2024 10:43:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/17] intel_iommu: piotlb invalidation should notify
 unmap
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-14-zhenzhong.duan@intel.com>
 <1a3d2c06-1c73-4b4d-a531-bd39007088d9@intel.com>
 <SJ0PR11MB6744CCAD824F111844C5A087928C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <SJ0PR11MB6744CCAD824F111844C5A087928C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|LV2PR11MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e9be6dd-0c02-48b6-31f9-08dcc0c155ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2RLaUQyakdOTHRFU3VJR0xRR1hURllISkk1aWxicURxY3J4Sjd0cnNpNTd6?=
 =?utf-8?B?eDI3anlhbnJpNlZnZGJuMmhadVZCRmo4aTBGdTYzWVBoNk9IU2I2dWxRYkJO?=
 =?utf-8?B?enRBeHRna2dZY2tJV1hSUlRNTXFaUTJ1R013d2c1UHI4OVBManluZ09lQkll?=
 =?utf-8?B?OVlwSXErNFk4NXRDUmNEQUU1RlJCaEY5T1p3RHJadEVsUDlHOVJjbXZINEdq?=
 =?utf-8?B?TXJTbnFPV0xoU2x5WUhvZTVLQWxXcXNtSVpDZGFxNEtZQndtcmpCUjYzaC8z?=
 =?utf-8?B?MGpVQkR6dTVZc1g1OFAzWmFKU0w4NXRUNE5saGtHaEhOSC9yai9JVlBtRlhJ?=
 =?utf-8?B?Q3hFZENLbUtVV1B5R0c2YkRZS3BXY2QzSzd5K29IT2kxT3dKZldCNHcwTW50?=
 =?utf-8?B?b1B1UWRjcVU1NG1TL09GTFJIeG9KaUdaTmRvdEpmS2JuUWloNWtCYSs3Rm93?=
 =?utf-8?B?blBPdEtBNG5vYlhQdUljdkZOOWhPUk5IMFVLWjE1bVUrZlduUWowMzE2WU9H?=
 =?utf-8?B?RHdKRFNleG9XNC9aejBCbzZQL2p3Y1pXSGpiZk1QK08rbDJ3Q0dhMDVjZmM5?=
 =?utf-8?B?cU16eG1iSm9Fek42OGV3SmpCa3FWdkRIcWhpOU1sTXp4UytKcTVGa3ZVYm45?=
 =?utf-8?B?WXBEVkZ1WXpXaHpwdlhVaGNnUG1GNXBRUUpvVmJyY21JMTFyZXVqREE1aTFN?=
 =?utf-8?B?VUFJR21IVTVDbzN5UmppNlJrSzQ2UDFDcWZKU2hvK0RmSGx2aTQwNzNkMFpC?=
 =?utf-8?B?a2poQ0F0Q2xtUkdsci9tZTE5ZzFLN0lIY09mOHVtRFlBb050M2xrNWxCbXF0?=
 =?utf-8?B?akpPalVvMjJpakJ2Qm5BZTNWRTF0THdJOU53bU9EaER2ODNjUlN3SHJiVDc1?=
 =?utf-8?B?bjJHdmdCamNCVFZZNVpHajFKSERqbXZVMGprazNpVDdZQ3RWNitPdVNkZm1n?=
 =?utf-8?B?S0I5K005V2dhWmlpcWIwYStndDJwSCtZbUU3SnFhcXF4UnFRS25rbnJDNEFP?=
 =?utf-8?B?U0h5b3JKOFRuT2Q2MVRpNGt6S2FNbWthRW42L2JXajl0UkZCbzNNOFEvem9Y?=
 =?utf-8?B?cFFoelNaZU5SWUQyT20vOWU5Y0cycEpXZFZjeEl6T2ZaZVhLd1h4Vm5oR2M0?=
 =?utf-8?B?amdJTTJMdHFMc0orRnByek5XVVZ1alcvZ05xNGlMWmsxWEFWN2NKS08zdjkw?=
 =?utf-8?B?L2ltcWhSNEdsZko5VzRpTU1UZnRsMXF6Znd1RmRMV0M1SHFFUDkzQ01qcFJJ?=
 =?utf-8?B?Yy9wdDhidDcyNU1RYVNiZDZyZC8rUDJESFhnc2oxN21xd0F0SSt2NzZ0T1dj?=
 =?utf-8?B?M1ZzcVhaQ3FzU090VDBOZHlYZjQxTjEwaFZjdTFYcnk1T29nQjZpUnYxSjcv?=
 =?utf-8?B?aTQyT2pva0dJdWVpT1JINmdvM3BoN0EzRTlDVG5oUHBsQkkyeWV3TWVYc0Zr?=
 =?utf-8?B?KzYzb21HcVBPS0N0b05wOFlzMnFpSWkxcWEwZmF5Mk5iTExTdHhGNk4yVlFx?=
 =?utf-8?B?OE5kcVd5NmVuNVRDR0hjR2ZCWVNOaVM3Tk5iTGNvS01hODM0N2E5di90MUFP?=
 =?utf-8?B?aEwwUEJ6ZDZZTnJKVW9ZSUNyUGJkRmVQMlRXRHZTaGJvZFhjYXR6TXBVQXht?=
 =?utf-8?B?cEFoRDZHVk5SdnlMMDJQQTZ6OGppMStEbEw2U2pIamcwUzRvWWNEcStXMW4r?=
 =?utf-8?B?UW1qNCtWWlNHUC9EOHl6em5zNVlmU3JzV24vcWFtRGh4aUhOOS8zTUVrODl0?=
 =?utf-8?B?UGFkU0l1S04zSEtaWlFFN3lzSWt5STRvZUc1SC9kZlZyWVhubkNqUkFQMmwz?=
 =?utf-8?B?YlNyQnNNYkorMFhOSytpQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1V0WGVqNEpwYkpHN0dKQmZLeUFpRGtNWGVKR2UwODRDeUR2K3k5UXZ4Wm4z?=
 =?utf-8?B?RmJyZTlGcnlYS0hmTlZ3N1pyRmRQOGdLRmlzcENZQ3IvbnpyeFlpbUE4RkFq?=
 =?utf-8?B?R2hzeGRhK3Rzbjdpd293Qzk4NTNmbUUzRjJ6d3NIZ3pVdS9rT1BHL2xEOS9G?=
 =?utf-8?B?VXdrR1VrdmFCcHlJSEVSQ245Z3JLSFFHUzV3RENBY2MvQmV5aUVObWN4UmF4?=
 =?utf-8?B?L1BjYWtPbGVCdGhPL3RFakJQZzBCZkhFZWNDTFZEa0FocUN4MkVTWUNlSnhQ?=
 =?utf-8?B?NWJZNG94WmZQZDhvMUtVUFJzQmZzb3o2alZRM2hJVWJJUnI2ZWxCb3laZkV2?=
 =?utf-8?B?VURrdVltNXFQazl3aTNqNlR1VmdHdExFT05UanpycWQ2ZXNCNTRuZ3BkcHgz?=
 =?utf-8?B?ZnNSVjdJVEFsQVIvSjdINDFEaVJSanhQNHBvbi93azl1empvVjA4TjRUdEJ3?=
 =?utf-8?B?T2htck5GWGpFTVJaMFNOT2xhd1Q1TVp5M092Tm12Rmd6SG16NHMxZllvaURJ?=
 =?utf-8?B?c3JPanUxQU9taExoTlJDSXJXQ3ZMNDF4Si82aC8zT01DRGxBQTVZbWVaeHBR?=
 =?utf-8?B?eGpmRWNkcys5VTJlbFdIanVwcXQrT3I4YUNFWE5zYlR6NUt2MnhmbnRKa0FP?=
 =?utf-8?B?VWRDVVN0ei9hQWQrMVNIMkVZVkgvQmNOUlMvYVpMbENnV1pPaWNVWlBZb1Qr?=
 =?utf-8?B?dCtTcDU3TVZqelcxakRwTlN3eFY1SHdvWU0yNHFWMDF0ampzVzhWQUptV08r?=
 =?utf-8?B?RERhYmFCS3k3K2dvUWdsV05IRTBQRWhxKzNDMFlURGlLa3VhaGRTUjNncnpV?=
 =?utf-8?B?aEFmcE0yRis4MFNRcFRnL1pRSDgrclI5NmtKRkg3Y09xSVpDak42OFBxeExn?=
 =?utf-8?B?ZncvRW5lWVJ3YVFENDlCL0FGUWx2RWRSYnRucGg0dG1RVmp0SGNsRGY4RC9U?=
 =?utf-8?B?enFQdU5pWWJGL3ZtUlMzcWZ1MWovZlZJSUV4N0tWS0I0WnVhSUtXYjVNNmJ4?=
 =?utf-8?B?aDAwbURJSEpQTTUwTG82VHNPYWlyVXZuZklXYVdrSGVjV2Y2REg1UzJoZFhY?=
 =?utf-8?B?MkV2U1lUOGZXUTdkZFM5RVN1cWlaOHdJUHRCc25mdnhwTldIM1p6K1VRVUJQ?=
 =?utf-8?B?a0JSaDdrNGlNd0JzNFVJbmdqdVl1clU5cS9pakFDdWF0QjQxdGl4Qi9yNEY5?=
 =?utf-8?B?MkNNbHlyWHFYNnFWZVRMOG5kcUpwUmhuTFdCSFlRaVY3U3RPTHV2VEhCZi9n?=
 =?utf-8?B?ZC9wZExXWU51R2I5SXpKUWpXNEVmVDlUVi9wYWhJSjVTOUNvVWpqdThiS2ZR?=
 =?utf-8?B?N1FNUG1BNWtKZXlXT3J4SG15eExPSUVlcno3WUhXTmM5alpzVDZORCtxZTVm?=
 =?utf-8?B?VFhEdVpzSktQUGFDTFBZdDhlc3F3bVEyRGpRTFl5bTFaSXlJdTc5ZmZyRldR?=
 =?utf-8?B?dVNEbGFTL1FVekZpTk9kQ08rSjhyS3N3cUhsU0Z0ai91ZGxNZUx0SVdJczdS?=
 =?utf-8?B?ZC94TFp5WldWVUtLcmR3T2FaSGpHVktxekFrWTdvZEtrRWFZRTNIQ2FIdzd5?=
 =?utf-8?B?ZTNnbE1rR2VrTXNGazVLbUdCMlBGK21odW5SeUJMUWVoT2FVM1dkYUFDRXZN?=
 =?utf-8?B?cUIzQVJpS1dLVlNxWlUxQ3hvYVhiRHAwTEwrQTgrVVFoVldyVjBuT0c0Ym51?=
 =?utf-8?B?VjFFcU9iUTh2NkdNQzFOOWR3RXhsYllRdVBwZmNDMDBKcDl3OHY3Z0xERWU4?=
 =?utf-8?B?WXZnSytYZ1Q0YmRaSDk2dk9oSm5xWGJrMFZ5OWROVUhXa21VM1h6ekdGUmVn?=
 =?utf-8?B?R0JpNmZVOFcxQXRzQlUrcFlEeGsrMVFQZXd1YWJrbUhMRDJadTY1dHRSRC9y?=
 =?utf-8?B?b285ang2U1hrdXpQWHNqQ04rbkY3QkN4ZkUvL2poV2FaWk5QT2xUdCtEZno5?=
 =?utf-8?B?MFBJS1hnRi9EOXF5a2JNbzY4d0RCT2RKOStwZVhWQzVtK0FRMWZRVUdEMUhO?=
 =?utf-8?B?K1RwTTZkOWRpa1ljeUxMdlJSckNmQ2xuVmFkTVQ2OGlyYlNvQlZRdUxTdkpG?=
 =?utf-8?B?N2FVTVNPd3I3NlhENE0yMmFCemZIVWEzcEtOa3JjK0crb3pHUHZqc0tDQkdW?=
 =?utf-8?Q?G4G6hLnbFcUq2A/v0EIqpnvW5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9be6dd-0c02-48b6-31f9-08dcc0c155ae
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 02:39:38.1750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DGcav/bMUQQqWpUzgbvDfu4vF+Jo8qDpYHgD0w4ELCqUbfO6T/Y9Cc1EQMhu5QzVXR71MPazzQPLEtfZLinmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6070
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
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

On 2024/8/19 17:57, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH v2 13/17] intel_iommu: piotlb invalidation should
>> notify unmap
>>
>> On 2024/8/5 14:27, Zhenzhong Duan wrote:
>>> This is used by some emulated devices which caches address
>>> translation result. When piotlb invalidation issued in guest,
>>> those caches should be refreshed.
>>
>> Perhaps I have asked it in the before. :) To me, such emulated devices
>> should implement an ATS-capability. You may mention the devices that
>> does not implement ATS-capability, but caches the translation result,
>> and note that it is better to implement ATS cap if there is need to
>> cache the translation request.
> 
> OK, will do. Will be like:
> 
> "For device that does not implement ATS-capability or disable it
> but still caches the translation result, it is better to implement ATS cap
> or enable it if there is need to cache the translation request."

sorry for a typo. s/request/result/

-- 
Regards,
Yi Liu

