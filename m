Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2F2C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 09:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfyI6-0003yS-NQ; Mon, 19 Aug 2024 05:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sfyEs-0003Ll-Dx
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 04:59:48 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sfyEg-0000CO-Oq
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 04:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1724057975; x=1755593975;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DnJruEYJcUZ1J2NQ27wXwnlMXzmPwbPc/UH48dym/84=;
 b=ftHkF82JoUxr40dwZnFY+Ej5kh/09TmdjeM7pva+RNfp091f/Y88Sk9p
 KXZUWR6dwCI96K38Lngqt5wjnRrJdAaqY+NYJh1acJ5wVkyA9NU4oKq14
 fwkhazUZUAod1+Povx4Jd9W7YVBi/YJ+dvcU5oqAHULv7Es+awpBD4/1a
 ++3kcXKAn98Wim3WF3VdRfMGswwEsDiRPSArdkEwHtrwpIyjkscw5pokP
 KlI5cIenywH0IKrH3YbKL+8vo9ubOjWnmxF7IR3rLjulT3VYR19sqNlx8
 xMmgjmVmgAcyWLPWYPm7Q7Sjrxgl6azOaTq7IqEctADSZlfvtsyNY1mlY A==;
X-CSE-ConnectionGUID: uI01PogGSTSQwroGSzbbIg==
X-CSE-MsgGUID: dK05DexoRXGOCey23ilbtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="33444042"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; d="scan'208";a="33444042"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2024 01:59:16 -0700
X-CSE-ConnectionGUID: yw82V4mVQhisxNMux/m3Ug==
X-CSE-MsgGUID: orr3I1EwTEy3RY8i4uJG5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; d="scan'208";a="60148374"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 19 Aug 2024 01:59:16 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 01:59:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 01:59:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 01:59:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BULjVYha3PNNUFC2O5mILiUDXDvgz6gq9raBkUHCXL5/ZiXiKZGwbfaGD1cOz/Jwy3d0+1kx+56wJppkc9b/47DMqs1cwp30ttrJHnBCvWsGmFzhxbyKY1mhxJfnLOA6ZrkwiVYZx+XRUcKG8eRdriKzs6gn8CqZw6NoL+R3+j5SvqSRfKaMUtZZ/PsdrQz1QPUaDOElC6Frc8E0WTodqW0SN00j76d6LnnlqNs+jFGtsQO+CdPagTwMi4fkvN3DWBIIsvfk0ncNYYKKDoWI/bzx8qkp3cxeAlCE2W145WAFHGDd8zkYfa3dp4yJG3kX7iAXxyBmbkGw1j+j7athuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dzbXW6u/ntm6YDsgeflO0oZCrvHC27XM7M9IkTIpk8=;
 b=bw/XQMA9AkWuFNiGC83cj7xFiJkrISX5gfjOS6n8daOpAv7x/T4VkUvVYfXs2CnX0q9ii6uDk9PncwzsK9kuiCmZzG+FECXk9l9mYvdXlsNkO8qpOxrOvDaH42iP0zoPRs6zR5gx1XiAAdKrHG+x4IguLn+2F2mNsl/if1WE062rf3qqW5gcrrG7RO7ZRKvieVbrVDfSD/nc+CZdF1Pi19ojCjuoSkIMnRunaSkbU1RMPRBSzk8CxKRRioTOtv0j0+tYYJPGv1y9moWmUs9/KmGfPZcX3Y0Lopx9i+i0MkTry3lzmfoim3hT3Ys1wSTOhq8cUToB7FUEBwyVox3aMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB6550.namprd11.prod.outlook.com (2603:10b6:8:b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 08:59:12 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 08:59:12 +0000
Message-ID: <8fa345f2-09f6-43fd-b520-d19dfc94501b@intel.com>
Date: Mon, 19 Aug 2024 17:03:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/17] intel_iommu: Flush stage-2 cache in
 PASID-selective PASID-based iotlb invalidation
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
 <20240805062727.2307552-5-zhenzhong.duan@intel.com>
 <2ba9a72a-c68e-4352-90a2-918994f9357d@intel.com>
 <SJ0PR11MB674467998E806C63373E8DD192802@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <SJ0PR11MB674467998E806C63373E8DD192802@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM4PR11MB6550:EE_
X-MS-Office365-Filtering-Correlation-Id: 75332e16-757c-44a5-9ec6-08dcc02d3205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFVzeDMxMnRKckg2TUhvY3NHY1pJb2FnR3FqQ0p2SFRINUQ4MjlyQ1ZwRnl2?=
 =?utf-8?B?ZjdMOG12Z0paN29sRGhqOGxIYmZlTFdERlFibHJTdVNuSUZFYnpVRWdpNnhT?=
 =?utf-8?B?anhWT01qMytzazRtWVU5LzY3WWpFSStwN05va0laNWVoanNZUHd6clV2eS9G?=
 =?utf-8?B?SlhnTTRKSmZmMDQ1azA2MWF0WTZ6ZExuMGVNRzBPcC9rdjlWTG9QclhwUU1V?=
 =?utf-8?B?UDY4Y216V203M2E1SWJVSjhGWDduVFJvMEJwazErYjFUTWZ5Z3V6elRHTmUr?=
 =?utf-8?B?bzdjZ0dEMFc0ZzJ3SUJBbmRsdGZHb3ZFbkl2TUU2MGI5dmFpNjhvdGNKSVgx?=
 =?utf-8?B?bk5UUlNMc2NENkNVSWZPSXcrdnV5blMrRmxDd0t6bGlsbzVOdVVERVF0dkpT?=
 =?utf-8?B?Um02QStILzE3UEM0YzMxNW5CZzZ0U1pQMTlvVG5Nbk44dUE4VS8zUTlaSzVz?=
 =?utf-8?B?SWdIRHo0eUF6aTVaWnUvNGt5YzlvNTZWa0YzbGtjZkN5N2ZGSmFwbXhrbXBZ?=
 =?utf-8?B?ekRydkp3cHg1ZTYzZVpYRzN3MjhlNUU4U2hFS3puTSt1NUtHZGpYd0x0SDM0?=
 =?utf-8?B?NHNSTkFRd1ZaaHFsZllmdkNBdkE5SXEzZ3hmblVpLytpaXRzQyt3MmtFYVY1?=
 =?utf-8?B?S2pUc212NjRHRGJaRVJUZCtrQjNnc3hwYi9JR2Q3V2htRVQvdWJaTTZwTjV3?=
 =?utf-8?B?N1duTmtSL2xHb2trVWFHWFU5OGhsZmxpaWNzRmhsSDFJYUxoUUVoMzg4bE16?=
 =?utf-8?B?TU1mTGhVMHRBanZRSGQ5WEt1OHRmekdBVU5oeEx0eVZXdUxaWWZPNXgxbStR?=
 =?utf-8?B?RTYxWThGQlQ1NldlVzd3WVNPMXErZXRpTnFtbmE5ZU9WTW9mcXBnUXFXaGh1?=
 =?utf-8?B?N2hRZTNmYXR6K0czSC82UFJYNDNUcjRQcGZuTUNqS2pwZnJNczFzNnJsbEcz?=
 =?utf-8?B?VUJ6UU8wTkRwdWs0dVZVa0cyK2o3S2tKZnJHVTFyTHg2R0h5bFN5c2NXc0pw?=
 =?utf-8?B?NWhDMkN2R0RXdkhHL2htbmVKSEY5Zk9iYndQU21mSzN3aHhuTVI0SlhSZkIz?=
 =?utf-8?B?WDBtU2o5VldKeDBOM1Mvd21sSDM1akxOWlZXTDZ0bU15M2VCaytPZGRiY3lR?=
 =?utf-8?B?aWxoc1M4Mnl0UTlNZ3cvK2VOSE9BTjkwZk5icWNReDFxQkZGZFFpWWp3Ty9a?=
 =?utf-8?B?VC9BWnY0cGtXamN1ZHhtY1h1enpIZ3d4YnZRYjhsK0h4SHdPc3I2bDU3WmZH?=
 =?utf-8?B?WnhuSVZNejNOanpUcmhpd1pJNU9vVnVRMEUyMjRRcTN3UWhhSmY3U1p5QVNK?=
 =?utf-8?B?VGJ2SHhNeXNyWUN1elJmTmlNOWR5TGsvb2wyRDdVTmUxcmpkc1pIcXFIRVIz?=
 =?utf-8?B?SnFoS1hXSGFxMkN1RHY2RDFQVHhFWWt0SUtQektVcjQwMnpqL1R6bWgzMWYx?=
 =?utf-8?B?M2pvSm1Cak5SczZjL0Z4eW91QUdQRmpJVkN1K3kyMHhOMVE2a2lET0dBRXRC?=
 =?utf-8?B?dE9CMjh0SmROYmY2VlFhQ1ZTRkxyall3MUd3UXpBMkFlVlVlTzJIKzdsVkh3?=
 =?utf-8?B?YU80M1U2Ym5USmp2R1lHeEg4T3NERTRIYXJWNVRtQlkzMmNkdjNIQ2N1OVpw?=
 =?utf-8?B?ODBaakNtUWljY3pnVnJQRllIL0xncWtNclBFNENlVHkrbkEyeG5wRGJzU2RF?=
 =?utf-8?B?NUFYRUdBa0c0WEQycENxTmV1V0E4bEo3SG44UEdwSEdkQ0JDbXNYczcxRCt1?=
 =?utf-8?B?dDUxVDQ4N3dMenpDQ29lUGtkZTdDZm1zeFU5bmdaSXdmeXF5ZlBjT1M2NStn?=
 =?utf-8?B?azJlalJ6T29qUUhhdXFIUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3NONzhlc1pzbFZqRW12cVU1bU9tcUUvWkxmdzNZTlVTU1FIaURWTUhsdFV6?=
 =?utf-8?B?WXJnbWRzQVB0N2txZ0I1ZSt4cTVwb2QxaStlT3hYVTdPcDhyZSs5L2dCc05U?=
 =?utf-8?B?TmJKQUFER1FuMThRS2k4N0d5ckZIVndGL29QaFg3aE9yeXd5dGRHNUVWSGVm?=
 =?utf-8?B?a1E5SWU2ekFXZnNta1BTMUdMQjAvUm5oQ05Bd3NabmN4eGNZWnhvZDNZSWxG?=
 =?utf-8?B?bEhsNVFqQk80WEdQSllPcGpHb1hJVEVJV2x3MWhqUW03THZHbWN3WC9KUzVZ?=
 =?utf-8?B?MWlQUkVPM1o0YmJHUWNyNGdxaEZFVHBqRkNyTnBTM1RDRlVDaU80K2djTUVJ?=
 =?utf-8?B?emdXMXBzeEEwMW5IeW01aHltUHNrTm02MGxUcXpNYkR6QVJoSEZneis3b0lG?=
 =?utf-8?B?SThqOFlWZVpIZEFHUlBiM3hLbXFqTUpvWmsvMWUvYlVMLy9xODFvYU5lS0hF?=
 =?utf-8?B?cUpUSENHVjk0V0Q5dHI3OC8wZW9OUEFNZTZzL29aTjRMUGZGNnliZGdVQWpq?=
 =?utf-8?B?a1RWUWF6UHNQc0Vic1N0UFNqQ0Mwa0ZCRUpJTFh3WTB5ZkdxOThvT3BmRHBK?=
 =?utf-8?B?TWtSR3JHejVSMC9xZDlqdG10a05yTW5ZNzhqZTJ6T2Q3cGtaeGpHdXRRdFk3?=
 =?utf-8?B?aU45WS9lbUxpQW83NlE5Ni9yRU00bVRrbm1ZNlc2VVZhSm0wL3M3amZlZnhx?=
 =?utf-8?B?UVdtc29iVCt1MUU1ZmhLbW5DZjNrZDR3cDdYMktoTE5Xb3dzck92S3F6MnQz?=
 =?utf-8?B?cUxzbWdIcGd4V0M3SjdGQnlkSS9TUGpBY0kwUlROUkdTZFlvSEo3MFd5b2x6?=
 =?utf-8?B?ZlNsbW4zUjcwUHIzVmR6bGJYQmV6dXZQV0tKaGdhZmFFd3p5ekU3NFhtbjdR?=
 =?utf-8?B?RTVYM0xSR21XNGVRdnEwSmtVOWpRQkZFdkIzenBGRkdVZXZBRHh0a0ZDd2NN?=
 =?utf-8?B?WFJWbk5lMWpJWGNwS3NnRjdQMTlpRUd3dDZLV1hUeGFBV1drU3RWMU5TNjd1?=
 =?utf-8?B?cGlTd3ltbXJabTFKdHNCQWNEdFZNeTRxdWJCWFNGb0dsRHdPVE9mZEhlR00z?=
 =?utf-8?B?alBkU2toQkNGdkk2cFlGOGxzRHhTMHloSURLMkcwb05UWG9aUDcxSE9ZSXho?=
 =?utf-8?B?aFRvam1tdHFiRUVrVjQ2UThvcFc4bXBGZ0lIQS91V0trcmRQcVV1Tm5vVVlq?=
 =?utf-8?B?RG1KLzlIeXVGU3ZBTW0xY0tNRWp2Yi9SWnFRYlU2cG5RMWFEczBxTk05amZs?=
 =?utf-8?B?SktMR1BFcVJZM2trNXZSdXhtRURSZTJWb3ErSDdOU0RaY0pwS2VaVFVBdEhk?=
 =?utf-8?B?d0VrOHpkZVhMNThKekFNQlJ4aGd6V3R4T3JsdDZsOHgrbklLM0hYTjY4QnpU?=
 =?utf-8?B?clVvQ2h3My9BQmF1TEhmKzZmajRFd01iR3FpMTQxMGYyQ2NjbUJuWENiUlho?=
 =?utf-8?B?bitZLysramNmN1g3NWczTFoxK3RKekM0d1lDeHRxa2tSRU1uYkdRd2FCKy9n?=
 =?utf-8?B?cFlEeXdCeXJPMTA1UGJ5VDRlT2Rtd2JTRTVjcDFGTDhFTGJaWS8yd2p4MlpC?=
 =?utf-8?B?UW1iYkhNMEl0cUhwbnV0OW9SYi92YitHQ1VmYzIySDUxSGttUXFLektYUnFK?=
 =?utf-8?B?UWxsc1VDandGYTN6T3NVeVp0M1g1b1BZQXpab0ZOOStqOWoxNnB3YnQxRS81?=
 =?utf-8?B?cFZzbXE2dVNPMll6ZkczSWptdFp2dTBoS09HUFN6YnQ0TnlrSXhFaEJQOG9D?=
 =?utf-8?B?eHhQQkxmVEJMZktsUnRvRmtYa01KSHJMdjM3dVo1S3htaEhza0NVbWlmdzI2?=
 =?utf-8?B?WVlVdkNIcXlIMDRoQWxOVUp3cTV2ZEJ1ak50d2lodGtMcElMQXJPWUo1RDk0?=
 =?utf-8?B?MlZqRDV1aHRjOTBwM3FMdzR2a1pYVXl3bkZFeURma0hyQS9ZQkZPUmxoSVgv?=
 =?utf-8?B?ZHkrYkRDc2dDbVFFdVJJblNEeXZBckhoeVVzNE9paDRaVUtrVmpmOCtFSXQ1?=
 =?utf-8?B?NTFtL3dWcUZ2a1RnYUVtZ1RIN3ZOZEJGSnd1WUdIYWFFMkRpRlkxUWxNOTAw?=
 =?utf-8?B?dUx4RzFuUzJsZUloZ1J4RCtsTG0yb0lHVzErVUkvL0FjL1N1eWFBQ0NJN21V?=
 =?utf-8?Q?JjN5zXKMcEFYyBEXij9LwrgXg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75332e16-757c-44a5-9ec6-08dcc02d3205
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 08:59:12.6234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUunhlpwUWBOUMAy1GE6byEEr1hZGCnFdmGoaD95fzdrHOan2CE5iYGGN3tGAj3vXpn52vrkUWSVPwy8inwjhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6550
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On 2024/8/15 13:48, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH v2 04/17] intel_iommu: Flush stage-2 cache in PASID-
>> selective PASID-based iotlb invalidation
>>
>> On 2024/8/5 14:27, Zhenzhong Duan wrote:
>>> Per spec 6.5.2.4, PADID-selective PASID-based iotlb invalidation will
>>> flush stage-2 iotlb entries with matching domain id and pasid.
>>>
>>> With scalable modern mode introduced, guest could send PASID-selective
>>> PASID-based iotlb invalidation to flush both stage-1 and stage-2 entries.
>>
>> I'm not quite sure if this is correct. In the last collumn of the table 21
>> in 6.5.2.4, the paging structures of SS will not be invalidated. So it's
>> not quite recommended for software to invalidate the iotlb entries with
>> PGTT==SS-only by P_IOTLB invalidation, it's more recommended to use the
>> IOTLB invalidation.
> 
> Hmm, when pasid is used with SS-only, PASID-based iotlb invalidation can
> give better granularity, (DID,PASID) vs. (DID) for IOTLB invalidation.

But you may need to submit multiple PASID-based iotlb invalidations as a SS
page table can be used by multiple pasid entries. From this pesperctive,
issuing a single IOTLB invalidation is simpler for programmer. And this is
also what VT-d spec recommends in
"Table 25. Guidance to Software for Invalidations".

In fact, for leaf modifications, the iommu driver should use the
page-selective granularity instead of pasid-selective. However, the line
3/column 2 of "Table 21. PASID-based-IOTLB Invalidation" says it is NA to
the iotlb entries with PGTT==010b.

> 
> If non-leaf SS-paging entry is updated, IOTLB invalidation should be used
> as SS-paging structure cache isn't flushed with PASID-selective PASID-based
> iotlb invalidation.

yes in concept.

> 
>>
>>> By this chance, remove old IOTLB related definition.
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    hw/i386/intel_iommu_internal.h | 14 +++---
>>>    hw/i386/intel_iommu.c          | 81
>> ++++++++++++++++++++++++++++++++++
>>>    2 files changed, 90 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/hw/i386/intel_iommu_internal.h
>> b/hw/i386/intel_iommu_internal.h
>>> index 8fa27c7f3b..19e4ed52ca 100644
>>> --- a/hw/i386/intel_iommu_internal.h
>>> +++ b/hw/i386/intel_iommu_internal.h
>>> @@ -402,11 +402,6 @@ typedef union VTDInvDesc VTDInvDesc;
>>>    #define VTD_INV_DESC_IOTLB_AM(val)      ((val) & 0x3fULL)
>>>    #define VTD_INV_DESC_IOTLB_RSVD_LO      0xffffffff0000ff00ULL
>>>    #define VTD_INV_DESC_IOTLB_RSVD_HI      0xf80ULL
>>> -#define VTD_INV_DESC_IOTLB_PASID_PASID  (2ULL << 4)
>>> -#define VTD_INV_DESC_IOTLB_PASID_PAGE   (3ULL << 4)
>>> -#define VTD_INV_DESC_IOTLB_PASID(val)   (((val) >> 32) &
>> VTD_PASID_ID_MASK)
>>> -#define VTD_INV_DESC_IOTLB_PASID_RSVD_LO
>> 0xfff00000000001c0ULL
>>> -#define VTD_INV_DESC_IOTLB_PASID_RSVD_HI      0xf80ULL
>>>
>>>    /* Mask for Device IOTLB Invalidate Descriptor */
>>>    #define VTD_INV_DESC_DEVICE_IOTLB_ADDR(val) ((val) &
>> 0xfffffffffffff000ULL)
>>> @@ -438,6 +433,15 @@ typedef union VTDInvDesc VTDInvDesc;
>>>            (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM |
>> VTD_SL_TM)) : \
>>>            (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
>>>
>>> +/* Masks for PIOTLB Invalidate Descriptor */
>>> +#define VTD_INV_DESC_PIOTLB_G             (3ULL << 4)
>>> +#define VTD_INV_DESC_PIOTLB_ALL_IN_PASID  (2ULL << 4)
>>> +#define VTD_INV_DESC_PIOTLB_PSI_IN_PASID  (3ULL << 4)
>>> +#define VTD_INV_DESC_PIOTLB_DID(val)      (((val) >> 16) &
>> VTD_DOMAIN_ID_MASK)
>>> +#define VTD_INV_DESC_PIOTLB_PASID(val)    (((val) >> 32) & 0xfffffULL)
>>> +#define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000f1c0ULL
>>> +#define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
>>> +
>>>    /* Information about page-selective IOTLB invalidate */
>>>    struct VTDIOTLBPageInvInfo {
>>>        uint16_t domain_id;
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index c1382a5651..df591419b7 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -2656,6 +2656,83 @@ static bool
>> vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
>>>        return true;
>>>    }
>>>
>>> +static gboolean vtd_hash_remove_by_pasid(gpointer key, gpointer value,
>>> +                                         gpointer user_data)
>>> +{
>>> +    VTDIOTLBEntry *entry = (VTDIOTLBEntry *)value;
>>> +    VTDIOTLBPageInvInfo *info = (VTDIOTLBPageInvInfo *)user_data;
>>> +
>>> +    return ((entry->domain_id == info->domain_id) &&
>>> +            (entry->pasid == info->pasid));
>>> +}
>>> +
>>> +static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>>> +                                        uint16_t domain_id, uint32_t pasid)
>>> +{
>>> +    VTDIOTLBPageInvInfo info;
>>> +    VTDAddressSpace *vtd_as;
>>> +    VTDContextEntry ce;
>>> +
>>> +    info.domain_id = domain_id;
>>> +    info.pasid = pasid;
>>> +
>>> +    vtd_iommu_lock(s);
>>> +    g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_pasid,
>>> +                                &info);
>>> +    vtd_iommu_unlock(s);
>>> +
>>> +    QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
>>> +        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
>>> +                                      vtd_as->devfn, &ce) &&
>>> +            domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
>>> +            uint32_t rid2pasid = VTD_CE_GET_RID2PASID(&ce);
>>> +
>>> +            if ((vtd_as->pasid != PCI_NO_PASID || pasid != rid2pasid) &&
>>> +                vtd_as->pasid != pasid) {
>>> +                continue;
>>> +            }
>>> +
>>> +            if (!s->scalable_modern) {
>>> +                vtd_address_space_sync(vtd_as);
>>> +            }
>>> +        }
>>> +    }
>>> +}
>>> +
>>> +static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
>>> +                                    VTDInvDesc *inv_desc)
>>> +{
>>> +    uint16_t domain_id;
>>> +    uint32_t pasid;
>>> +
>>> +    if ((inv_desc->val[0] & VTD_INV_DESC_PIOTLB_RSVD_VAL0) ||
>>> +        (inv_desc->val[1] & VTD_INV_DESC_PIOTLB_RSVD_VAL1)) {
>>> +        error_report_once("%s: invalid piotlb inv desc hi=0x%"PRIx64
>>> +                          " lo=0x%"PRIx64" (reserved bits unzero)",
>>> +                          __func__, inv_desc->val[1], inv_desc->val[0]);
>>> +        return false;
>>> +    }
>>> +
>>> +    domain_id = VTD_INV_DESC_PIOTLB_DID(inv_desc->val[0]);
>>> +    pasid = VTD_INV_DESC_PIOTLB_PASID(inv_desc->val[0]);
>>> +    switch (inv_desc->val[0] & VTD_INV_DESC_PIOTLB_G) {
>>> +    case VTD_INV_DESC_PIOTLB_ALL_IN_PASID:
>>> +        vtd_piotlb_pasid_invalidate(s, domain_id, pasid);
>>> +        break;
>>> +
>>> +    case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
>>> +        break;
>>> +
>>> +    default:
>>> +        error_report_once("%s: invalid piotlb inv desc: hi=0x%"PRIx64
>>> +                          ", lo=0x%"PRIx64" (type mismatch: 0x%llx)",
>>> +                          __func__, inv_desc->val[1], inv_desc->val[0],
>>> +                          inv_desc->val[0] & VTD_INV_DESC_IOTLB_G);
>>> +        return false;
>>> +    }
>>> +    return true;
>>> +}
>>> +
>>>    static bool vtd_process_inv_iec_desc(IntelIOMMUState *s,
>>>                                         VTDInvDesc *inv_desc)
>>>    {
>>> @@ -2775,6 +2852,10 @@ static bool
>> vtd_process_inv_desc(IntelIOMMUState *s)
>>>            break;
>>>
>>>        case VTD_INV_DESC_PIOTLB:
>>> +        trace_vtd_inv_desc("p-iotlb", inv_desc.val[1], inv_desc.val[0]);
>>> +        if (!vtd_process_piotlb_desc(s, &inv_desc)) {
>>> +            return false;
>>> +        }
>>>            break;
>>>
>>>        case VTD_INV_DESC_WAIT:
>>
>> --
>> Regards,
>> Yi Liu

-- 
Regards,
Yi Liu

