Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E705CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mpb-00039A-Aw; Thu, 16 Oct 2025 08:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v9MpZ-00030K-ES
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:11:41 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v9MpN-0007RA-E0
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760616689; x=1792152689;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XOGNPspdyKIJIjHayRoQCJxzv0N9mJbyw9HyMEDd22g=;
 b=TDeXqv21LGhiXvgKnEjQxyf26vmpon+BTnFeTig2qCMs9C25MyDzH5tQ
 fxR7eepY62jv3Qkzfn9FzoRttiW8Xg1YUqjHaQApBEYEj1P9q4htH5Gnq
 7bBPt+bibcrl5kEHbL0YCF2hl0SLJ3kE6rx5C7oUbt0w+/NC2SCgxeVpS
 1ZAQTnzf/QZGl+LUPsanontznKgkaF5JbA+pHRKJutxj/COqOiShg8Q3u
 TYQV6wv7ze3nTzPU85xA6vEeV7ZtFNe/zwbakRU6heHVaL8MoVAxNmmhv
 N3yP9V5x5RoX5OkJ1ChBfp02aXS74tw53wusEbgPHoo/vgI/lCcGxcswx Q==;
X-CSE-ConnectionGUID: NcIIZVVNTS+DWcNI5PZKBQ==
X-CSE-MsgGUID: ZUXGxXRsRvWxxu6YywWWWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="73407259"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; d="scan'208";a="73407259"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 05:11:22 -0700
X-CSE-ConnectionGUID: sYcpwiHdSOek3pAM8bbiAA==
X-CSE-MsgGUID: HE4zAMGHTey3/YLRXaA52w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; d="scan'208";a="182008923"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 05:11:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 05:11:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 05:11:21 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.3) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 05:11:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6PAUNjkLy6uXLEv9Gfc4uxN7VT7eCIGSAL8WMc0qT9BSfru36oG+B+KPghU6FebKpHtHE1Yqgf6eUTJ3Nl8mH5NEWsqh/pJXQvMF4gHs53TxdDYXpuPyP/uVzmBjrYay/DGzntEfe3yoG0eU0gf3Hq5v1dvPkCRRlryZdBkHcSqh/TTWwg2Kcf0YIici78OGVa+ihPx/r9fMPDNWnarabPOY4DQY1mzMSkC1O95qYXjRcu/90rSMo3e+6NwTYmn3kmuw4cQdL2LHNQtYL8mvGrHaDuKZbwLCcJIc9hU/xB4uO78mt2dfXz5ckSV5ycRNB0rJfR9uH30iI2eMWJH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvDOew1dkoZZzZhHzs1FSAFRitCCOGDy3WEDML49vKU=;
 b=rVLGM/LX1GSjDI183PXbuIzcWtCvlR7RG7I9ljAvfG2qXn1AZ+ZcRVGnGApSwh+5BoNg8jIwjKcuowCELWGQHkQFfJF2jhol4o+NKCqI/MDcXBFRdCC3zN9i/8yAAwHz18CNtnMN5Tv43a4AJsXaz3gyqX7law0TNX8uSoO5ZSG+z8Qb2qNqnL/sI2apRO1Br0E1/AukbB43BkIh1Ih10A9VdzgrwxbSBzb9m2O7AAxsFW+cM39J5eAU/xqO8Axf5dgcrDxGw4fgHNXRy68TkhjSKQgDOfsCctJDBLY+k71TjSttXwMfaulNzxsKbbMzGgU91rnX2Q1WyLCQ3zoZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by PH0PR11MB7168.namprd11.prod.outlook.com (2603:10b6:510:1e9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 12:11:19 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 12:11:19 +0000
Message-ID: <4205373d-b583-4d6b-8004-d86e51082375@intel.com>
Date: Thu, 16 Oct 2025 20:18:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] intel_iommu: Reset pasid cache when system level
 reset
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <clement.mathieu--drif@eviden.com>
References: <20251016074544.377637-1-zhenzhong.duan@intel.com>
 <20251016074544.377637-3-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20251016074544.377637-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU0P306CA0015.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:17::19) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|PH0PR11MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c80aecb-e414-4849-6d2c-08de0cad1d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|42112799006|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGRybkkwdTYvc2t2UUJncjFFVEFSQnAwaHlwUC96UTlkNDJHN1JpdWRXbVpG?=
 =?utf-8?B?MmVqaW94MnRpbExyaG1MUGVMRjgzV2xBa0pFRXUxdXdOSEwxbkF4NFA3eGZO?=
 =?utf-8?B?ZWJqZzIvYkRlUWhaQmc5ZkpDcTcxM09MSTQ1cFdhQWUvTjAxN3k1QmVOQVhi?=
 =?utf-8?B?SXc3QlA4Z2djdlprNUozQkpDSlExQUdnS1FoekZQZG5kRTh1UUducVdRWmZE?=
 =?utf-8?B?Wms4VTAwcmFZb2NZbkoraWFlZEFHejcySkxsUG5SQUx3VkV3MGFyVm4zakFy?=
 =?utf-8?B?UG9pQXFxTEhwaTZ3UldBU0xTSkdoOTA2cmlPMGFsanVzdGlwWnVkKzZ6RXJO?=
 =?utf-8?B?a0MzdStpK2c3YytGRVVScnB6L014MVJHYWZSMVd0Mnpjbm1aWmlVUndmbUNC?=
 =?utf-8?B?OGZ1RGsxQnJuMkovNEFuSHZwSkdIQmo5Tk90aEg1YTJoQzdES0hvVUtqWFhr?=
 =?utf-8?B?NW1lMHUyWG56Ymdxa1BpZmxCMkN3MWhXbXZxSmJNL1RhTWM3V3RUV2hNMVJZ?=
 =?utf-8?B?TnMyYWRXSVJjYXArUXVxWFduZERnVVp0elZKOW1WWldPSnhIZlZ4NmhpVDNz?=
 =?utf-8?B?MGxYak1mQ2lIU3grSVVFMFYwZDZ1MVV0K0RCd0NyaWFJc29ZL0dyN2FXd2Ju?=
 =?utf-8?B?ZFgvbXUyVTBLU3RDakkySDF3WGQxYTliT1Z5TVJRL0dhNHdRT2NFK3RWL21j?=
 =?utf-8?B?eXkwQlJtbG5RQUF1dURWaE5oQXRDNWxRTWc2aUVUcUhBUzJWcXBoRThzbEcw?=
 =?utf-8?B?TFR2VWNtY0VDTG5OOHN6ZlZDT0lkb2xuc0RJZjB3MWtIQkdhck1LcStjei90?=
 =?utf-8?B?b3pzSVB4S3Zra04vdis2c0xIYVhqN3pUMFB5V3IxejBQbjJZbldPeVg4ZFRp?=
 =?utf-8?B?Rys1NEsyaDhFcFVyTDdZWFZETTlCV1NzNkRVNXRlQkIxV2RMZGkvaFJSYjBl?=
 =?utf-8?B?UC93NGFEMExnaksvL1pTaGpYRGhqeHhTQUdNOUtCUTM3eUJFdllYTzhjMHVU?=
 =?utf-8?B?Z2M4OTFBOHNvbjVPSjZsczM3dWJ4ZEVucEdaM0RXQU9GQjlEL01Dc2x6aW5B?=
 =?utf-8?B?OFUyTklNVXNZUUNKdWwreUI0N09sZmJ0dFEycFV6OVgycmlBWkFmL0JxV0E4?=
 =?utf-8?B?amx6QURKdzIxeitaS3g3UEFaUUpUeGk3d2htS1M1UHlWaUZpVmgrbmFkTWtI?=
 =?utf-8?B?ajJBdkcvcjBvUXNuZUkwbDZCUWFFVGFUVmpkbWZkUU54MW91eEtWWFp2VDEv?=
 =?utf-8?B?aTNaVXNSNEgybFhmbTB0RTNRK3ExNkVXK1MxTWU5Uk80WFpkMlFnYWRFbjlj?=
 =?utf-8?B?RXRtcFd3WVBhVUszdWZFckIrK2VYbGRKanR5ZEFhVmxZL1ZtZloyQ2hzVjUr?=
 =?utf-8?B?Rnk4bHZJVG91UEZWUnlNaDF4eWVEV1pMYmJ4ZHlaM1VRUWQwaW5GOVZQMjBj?=
 =?utf-8?B?RjRuZzg4VDBVc3dNazkzM2svVWhSOWwwNlcxd3J0MUxWelhPU2NjY281TEMz?=
 =?utf-8?B?VGVmMUxJb0o1QlVxalJMbmJSVEd4dFNXYXUxVldQOVJNS1pUbWFHeXZUMC8y?=
 =?utf-8?B?Z2IwVCtIZnh4bzZQSm9yMHBWVEtPUDZ6UXFkRVJRSytaZDRSSzdjajZoNmdE?=
 =?utf-8?B?TjY2Vk1paTR6bmZVNHBZZGNVMjArUGFOamVyM3VudTFXeGQzeFlzL2QremRQ?=
 =?utf-8?B?MktHM09kdnF6TTRsU0hUQU9QUnRRN0g1T3Bwck5GQXBrcGl6a0NCaGlXMEJp?=
 =?utf-8?B?OXJyYTdpK2tCakxPdXoyZmJRdUR5YTZKdVBHenFiVmNSR1dxQmhBei9BUVFI?=
 =?utf-8?B?cTQrMTh3YnR4NlUzMFc3dkJSL1d4ejdHM0UwQ2UyU3pxZnlyOWw4VEtKVkpV?=
 =?utf-8?B?SGF6enF1dm4rZytSZHJKQUJ4TXU2V2lSSHp0ZnFrS01qM2RXUHlLcGRJZmZH?=
 =?utf-8?Q?mtSETCEkUB0nrTHlDkP+0lrTKp9+ov6i?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGx5bGdERGFLVE9PS1c3RkFyNEdHMXkzM2FBZnJrdHFVQVhPQkxOakRaN2cw?=
 =?utf-8?B?WExucit0Rkt4VnBsNTR2UG5YNS8zbHJKd3NSL0U1UGRVOUFRTlpwR3M0Z2h4?=
 =?utf-8?B?cEFSeWVpUjEwTnFEQmlIK1JMVmdmR3RvT2FpRFhxZmdYTUl0NmEyejF0cEFy?=
 =?utf-8?B?SlZheUpRek8yejNOVFZSL0d6b0Zvb09kY3EwZ0t0eUdoU2FRZHowSE9tZlJh?=
 =?utf-8?B?UTlhcXh5djVlUEdJeW9UN0ZlRWVQSkFMVmJQVEg4eW9mZW1STGtnMzNYc1hy?=
 =?utf-8?B?a25RTXNwWFFYbFc3UEtORkhmbmtwaWJtSUNqZjc3WVI5dFlPVit1cEY1bWlM?=
 =?utf-8?B?a1llS28yck0wbXhXVU9GYktYRWdhNngyOHgrc0R1VFhGQmxKanFoSHJyeHJ2?=
 =?utf-8?B?YWU5b1RpQ3ExRjMyVTRDOFFwM0xxSG5XOXJ2dHlDcHJ2cVJsakdlT05SOUty?=
 =?utf-8?B?NlREV2pjWDBGMTI4S2JlZitKVkppbWpidzdwbjhxL3REdlpnWnl0cEFZZlF3?=
 =?utf-8?B?SnJzSksvWDlIRGE0ZmxIa2dKWWcwT1dmTHArYTJ0dVptVVA2QW9MM3QrOXNU?=
 =?utf-8?B?Rm5WUWtOUkdOWkkxNlVOMDc2ZkhYUkZQM205dGhOQkFHSTFXK1VxZm1SNW52?=
 =?utf-8?B?Nk44RWFIY09STVR2eFd4VjRJMTMydkROUWx3cnJ5M2orTlc2cWVnVTVKTTBZ?=
 =?utf-8?B?WG84Z252VTJGL2FVczNnaURkT2RlYWQ0V2NTUkNQZDBiR0tEUDNlMEY2UHRr?=
 =?utf-8?B?ZUJPRG9IOE5xZjdHUXdnVnk0NERRMXJabk1BMTlOWUpsT2xMbHdtbGNjazh2?=
 =?utf-8?B?ODhPbzQ3WThRd1RZMUN6Q3lyRXhkY3JwVGNvRWMvMWdaWHorTFQ3cmxPZ2hO?=
 =?utf-8?B?VEllRTQrVHAwZ3RZalhrczl4S2k0TzJSTjh5Z3VaMXRXWThVTG50V2dtd3Jk?=
 =?utf-8?B?SjJmMEZsa25tUFVRQlVNUzNGZVd6MGxSWmoyTW1xRjFlcUpZRGQ0a0RIMzJy?=
 =?utf-8?B?TWlDWGxrZFRjVGtwZ0NhTHVJcEtCbkJkZkZwZ3UzdkpZNFJjOG9XWHI2MWRr?=
 =?utf-8?B?T29ZZm12c0NzSTI3Mk1yQkNwSTdIeGY2ZnROeDFkeDJpR1BhcHlqcnNaSWhR?=
 =?utf-8?B?aStzTnE4WWdkcEFuRUwxaGd5eHF1bDVrZ3h5WUkzd2YyOW1TdEtvRk9YWlRL?=
 =?utf-8?B?d2hiQTB4WUgweEVDdTBhM1BZclAvWGc3WElrRnhZR2lHc0FGSHFlYUpJZVpU?=
 =?utf-8?B?NEY3Z1VyZ0xmdW5UYWNUVVZUM0RlVTZ0d2M4S0l4Q0c1OFFIOHgwRVhmOU1a?=
 =?utf-8?B?TEQvakNCOGRGdUVIUlFQcnJiYjBkQTIvMWZJbmtoRnQ1WGxzYVh5V3BnKzU1?=
 =?utf-8?B?c3puanoyY0VPTG1DNlcvL3QxaEdoNDlCT28zMzVmNzRub1pWeU9GNWZxR1NO?=
 =?utf-8?B?OHNvbVhVaEJFMUdUeFBuWU5vSjJZOHNaU2o5UHRKWnllRFRiaDlHSDA4OWdQ?=
 =?utf-8?B?aFNBbERJekNLenhzZS9uQndjRjd2Z1JmK3Z2Vlh1TWlmc3diZXNUMUUrb29N?=
 =?utf-8?B?U2MrbnNWU0NOdTlSWGlQeG5mOWVxVnFYczUwM2h1bEhQcGRDeWlxL0dlRFZN?=
 =?utf-8?B?R2xWb1Y0emtoeUwrTk9RdjJTc0dDQStBemovUS9KdkpZOUxDR3VKd0g2Sjgx?=
 =?utf-8?B?dlcxK0lRMUkxLzRCNzYzTjlrcmltN0dQeTRkM1ozZ2Q3YmhFQjB4ZHFCeWpx?=
 =?utf-8?B?SE1ORmorZWkycGNSQ2NqVlE2RWZiNG11T3BsbnFXeXRrTm40U1FRWUN3MzhD?=
 =?utf-8?B?MThUVmwyM202VXd5QjN0ZERVTnp4K2MwNG5CaDVWZklBelZXVkxGWnF1SmlW?=
 =?utf-8?B?aCs1dllLU0paT1g1WUI2bmhRM0ZPQW00TUlGWUlmcHRMSTNlOHUwUFBFc3ZP?=
 =?utf-8?B?cmltaW9NaXVJYmwwZVVsYncyU3dXVW1JMUVRVFNHakdGT3pscDZwRTJBZUxL?=
 =?utf-8?B?ZCtGczlWb0NrMHBPRndpZmVVM1VOSnJyQWNrWW44MldKaUNNWnhTaXgzWnNG?=
 =?utf-8?B?b1YzNDhyZTl4bHk2cHZhcFNCNGE4OXhnNk1TK0tkMFFKZCtmTkpHWVVnaHUv?=
 =?utf-8?Q?o5E62dAUwaiobBROsIyIByq0Q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c80aecb-e414-4849-6d2c-08de0cad1d3c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 12:11:19.5639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFDmaPwSYZRPmBCTnW5yCx5aaANFP6/ptUd2v1psxc+Ab0hyLtSjqD3pojqqFoR6Zz4bawi90N+wyptPYJxYmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7168
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2025/10/16 15:45, Zhenzhong Duan wrote:
> Reset pasid cache when system level reset. Currently we don't have any
> device supporting PASID yet. So all are PASID_0, its vtd_as is allocated
> by PCI system and never removed, just mark pasid cache invalid.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu.c | 16 ++++++++++++++++
>   hw/i386/trace-events  |  1 +
>   2 files changed, 17 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index c47f13b659..07bc0a749c 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -87,6 +87,21 @@ struct vtd_iotlb_key {
>   static void vtd_address_space_refresh_all(IntelIOMMUState *s);
>   static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
>   
> +static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
> +{
> +    VTDAddressSpace *vtd_as;
> +    GHashTableIter as_it;
> +
> +    trace_vtd_pasid_cache_reset();
> +
> +    g_hash_table_iter_init(&as_it, s->vtd_address_spaces);
> +    while (g_hash_table_iter_next(&as_it, NULL, (void **)&vtd_as)) {
> +        VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
> +        pc_entry->valid = false;
> +    }

do you have any special reason to use this version? To me, the prior
version looks better. I think global reset also need to be followed
by switch as and as sync. right? The prior version supports it once
patch 03 is applied.

> +}
> +
> +
>   static void vtd_define_quad(IntelIOMMUState *s, hwaddr addr, uint64_t val,
>                               uint64_t wmask, uint64_t w1cmask)
>   {
> @@ -381,6 +396,7 @@ static void vtd_reset_caches(IntelIOMMUState *s)
>       vtd_iommu_lock(s);
>       vtd_reset_iotlb_locked(s);
>       vtd_reset_context_cache_locked(s);
> +    vtd_pasid_cache_reset_locked(s);
>       vtd_iommu_unlock(s);
>   }
>   
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index 298addb24d..b704f4f90c 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -24,6 +24,7 @@ vtd_inv_qi_head(uint16_t head) "read head %d"
>   vtd_inv_qi_tail(uint16_t head) "write tail %d"
>   vtd_inv_qi_fetch(void) ""
>   vtd_context_cache_reset(void) ""
> +vtd_pasid_cache_reset(void) ""
>   vtd_inv_desc_pasid_cache_gsi(void) ""
>   vtd_inv_desc_pasid_cache_dsi(uint16_t domain) "Domain selective PC invalidation domain 0x%"PRIx16
>   vtd_inv_desc_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID selective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32

