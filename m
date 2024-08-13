Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567F1C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 09:05:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdnSI-00059W-GZ; Tue, 13 Aug 2024 05:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sdnSD-000577-KF
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 05:04:34 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sdnS8-0002ZN-OZ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 05:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723539868; x=1755075868;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vR7+oMz0uLO+b+4rw9VrdvuEit+oRs10dEjssC5/uXc=;
 b=U2/yChwYWVi0Tu05bPWXbbh1DDjHdf0uvjKUeKBcKPsb+qfbuL+Tzb2O
 GVzvwIaAcIv2Agf+ry4b4kOZKg+4SdPdlczE8BKSet0B7DG5w0Z46IP08
 tRegBn6VCp/59oZmAX/TTaoGrYzOQUjKEjRR85lfnNmd/t9ub46V3TWxK
 8w91+bx4jKqseB9Xx8R5f12B39EzConGCqhNbR0wf9L2qbwLidMoyiUlo
 m7bM+4cmzy+4Qiz22YC0tBKvDArYvULJRhnDY1gWZLTfamGU9eE8l94Ci
 mvLAVdTrpYXS5WtZ7u9Br1e+YXCPIlh/1PbSR/90MfcqxssaAGogGMRxs A==;
X-CSE-ConnectionGUID: WEKUGpjeSNKK40u/hSJ8rg==
X-CSE-MsgGUID: Z8h2x84TR5GzLDvTwQVpPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="24596997"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; d="scan'208";a="24596997"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2024 02:04:26 -0700
X-CSE-ConnectionGUID: trGyOU2WQ3+QX48Lxbwefg==
X-CSE-MsgGUID: dGuCP9RZQQG+LjCpJu4OCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; d="scan'208";a="81825693"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Aug 2024 02:04:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 02:04:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 02:04:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 02:04:24 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 02:04:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wk9YW1ctAFD+MwUqxMDgC1jrCp35P9VrV0x579745B5K+4En2WVko3rDGku4694dK9z/z3q+8KJjkVPSq7VCx97Ju78r5xl7EjPpKaepPhCCLO2VPR7LIUQ6uopLeiJcKuBh/HKAnaY0p5J2hoTATLhUrRTQuE+6yLEY4Ev3kl0QVkrlbw/cTdyimhbQXw3hCYsk5K7N0EQqSGe8AcFGUnEdJmrYSxriMdGXuHWzS81N466R6R1Woa6TNHiC1jXhAF2wHRqxGN5hukWDi69POW32WUiiXLokr+Xx0O/j7z1y1ywVD9022za+I6rhIZo2FfPNCDhI84EuMVgUhYNwEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNY81MFbxfCxrNXuhQ+/5ordwfHsTHYRwXBU+DB/zLo=;
 b=rDwmC1quQ0VyISGrvVwgeiacUPjMpRgqfNJiNASj6+p9PwZ1EeYyWagYvi1IPFdGhUmWUeQ+k0CO+3K2CsyQQqnkqcNybaw42nqyliOhvOr1KQ1L5rFqy/gg+VZJJfATYFUZkVsRRPXxP4TJn4EaUSt1VAbxkog9RJAeesqPcVjOwBqEERNxyYoVV4Os8mgDzxv2sfIJFd1kJvNiZ+ovfspK+PZ64yvd7ajbnW8kNhGP0cI1Xvh/oV5SfHkIQ3PvbRra6u/xF2m4L6FG/lC2Yhrm8dhImeAhFcqi6YFRb0bboAuZRh4m8Quh+zP8IjA5lvBOQ5b6XDVZGNfKc71LHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CYYPR11MB8388.namprd11.prod.outlook.com (2603:10b6:930:c2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Tue, 13 Aug
 2024 09:04:20 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7828.030; Tue, 13 Aug 2024
 09:04:20 +0000
Message-ID: <f5bf7999-e2dc-48db-a67b-54313723705d@intel.com>
Date: Tue, 13 Aug 2024 17:08:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] intel_iommu: Make PASID-cache and PIOTLB type
 invalid in legacy mode
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "chao.p.peng@intel.com" <chao.p.peng@intel.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
References: <20240813074410.2571369-1-zhenzhong.duan@intel.com>
 <20240813074410.2571369-3-zhenzhong.duan@intel.com>
 <6ecf7b78-fb47-47ea-944c-f94e889e7427@eviden.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <6ecf7b78-fb47-47ea-944c-f94e889e7427@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CYYPR11MB8388:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c60524d-d506-4ef3-20f5-08dcbb76eae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RU5FVVI1OWZSTnJ6Y1BGM05OZGNJN1pMaUw2S2JXUkVsMXBKREpPNVBNNEg1?=
 =?utf-8?B?djg0ODVWUGJIc1dhMnMzY3BBVVUxSUk2NVgzWU5GbHBhNVNiVU4wV3paZUVq?=
 =?utf-8?B?eWNtZXJzU3QxYm0rdDlTcGhnZU5pNzlOcExhZUgvc05jcGNweUFQSURTdTdM?=
 =?utf-8?B?UmRKT3JCS1JkbGg1ak5FN0lEd2hob0VicXRlR1NUVUdiTGVCdkkrNHF6bi9u?=
 =?utf-8?B?aXBQZ1VEUGhHd0JQQ0VYbFJ2OHhKZHNmaUpVOWc1QUw5V3pjcUhLVGlJYkoy?=
 =?utf-8?B?RURWWVZ1SCtXUTNoWG5MZEw3S0lIQ0JSc3ZWTE1LSEJtNEtsYU12NGZUdjBB?=
 =?utf-8?B?Vjhub0dEd3h3T2szR1AwblFKNzJRWW1xSnlnZnd2VCtZZXlXUWhrVTZzdi9W?=
 =?utf-8?B?cStUZ0lGelIyNDV1QTZ0enlvYTFDMWRkRFk2dDJYSXBpbS9JL3UwWWwweVF1?=
 =?utf-8?B?RWxKQkZPdERHc2RZNjc5WjkzYUdqMUR6NnNJWStMU04vc1VHYXFjMGtidjBO?=
 =?utf-8?B?YWNTUnBtenlTdHY4TmR4WksxTCtoOWVuKzVqMlVGa0JnRWJ3cVpUd3oxaTdW?=
 =?utf-8?B?TjRVRk1YT2p3N1Zsb3U4U1g2NkhZMUdqa0xQVEs5K2JPRUVPUEJzZEMvdkZ5?=
 =?utf-8?B?dzNQYTdpUmhhZTRwenVRczhHUTZ3VjBrTjlNRU1CSENJb2tYNTRxNlQxQ2tt?=
 =?utf-8?B?d3JpNjJLTkFRYmpqbDdIeW5RbSt0cWJ1SkFiK1BqVnR6K0NQYTFNeGJzSFF4?=
 =?utf-8?B?ZFY3cHRZU1M2cGExdGhvc3ZRakQrRTJvaVZCZjFyclBtV0NsOVE0ZDFoN21X?=
 =?utf-8?B?djhEK1VEWngzTFlBZFU4ZDMrQTdMdkpROGtLanhKajNOYWFnUHpmODZ4bEVi?=
 =?utf-8?B?UkdKVFVlcHNZaDhnUDdvRG90SWJPNnVXTU9hZW8rREtreVBkSDN4bEpFVVBs?=
 =?utf-8?B?N3o3UDA2OW1ISE4rWVdTZldtdEJMY0JaL0RGUFNmVG5oTGU5aU1aeDE4Si8v?=
 =?utf-8?B?UWJ1V1VhWG01SHZqTThZdmZaZ3VtVVJkd3RjNER1YUJOVnRDTW5yVEFxbzBF?=
 =?utf-8?B?MjNZYUNHbmZNb3pRNjFiazFmdFFiQnpsYVVhWHBRZjBqbk1tZGVGNGJTL3U5?=
 =?utf-8?B?TkU0U2syd3plMFRBd2t2dUVpOXZQYkxZSUF1OFhEL2kvV0g2M1pWQk1jZmg2?=
 =?utf-8?B?VzdDSDFveTVvTTNKamdyZER3Qng2ZVZIcENxOExGMlh3a215Rk12KzMvN29q?=
 =?utf-8?B?eVpXZ3pjYWl5OEpOWlJvNWRaYkNIcWRCNk9WUW5hWWtOR1VRMExBZG1vaHZU?=
 =?utf-8?B?UnhqaDlXWC9TL1NvdjNIUzVwVzUycVBJQkQyeVNwR3JtVVU1U0d2d0g5bFBl?=
 =?utf-8?B?alBUUnFRdUJhaVJJM1FCeGRDdW41dS9ETzZPTXNtOXcvZk5ZZHhkelRyQTVE?=
 =?utf-8?B?RTNhT1BZbXRJUGpGNmZUenNMeU5Za3FPZ0tRbTJlNC9rWGNTK0tZSFZETEVD?=
 =?utf-8?B?N3Y2NGIzc05IYkdvN09ieFhQK0QrVFdadGVwQi9YMUF2aDJsMmh3TFdyZVk1?=
 =?utf-8?B?MEo5cVRPajVqL1NsUHFvSnVpWWxaZjZiWDdvdndOZmhKNk1QSnRzL0JqQXhX?=
 =?utf-8?B?Vk5qdzcrN3laejBNeG1BT2RVUjdBRDRsYTY0Vnl5eENHYW80SEp2RC9vYnB1?=
 =?utf-8?B?S2ZwVDR3WmdNVFVyMEptd21YQXlMVUREVFMvS3pCbVJRYzB0ZWJ3NjhZc3Nq?=
 =?utf-8?B?RXVDUjZha0Q0UGY2K25vVDR6SUdGamV1QW9zYmdsTWJGTU1KemI1VzJ5bWtW?=
 =?utf-8?B?c0lwQTV0bUs3d1Y1VmVCUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K28rRml4czNYcVdUZWt2ZHhuQ3hrd240OHhPSFl5N1BwWUhjT3E0S1Q0K3lO?=
 =?utf-8?B?WGxhWnJ4RmJvclRsSEcxQS94OFJMcXlkNnRTcDJ3aUxlWEdFSFJXQWZicEIz?=
 =?utf-8?B?TlFQVE1pdWtZWW9iWDl2WjJlOFd5c2V4dFJWSXlRSHBVNFZOYXUvWWJYVDdv?=
 =?utf-8?B?VlRQbVBlQktlUTNqR1JlZ2Qyc3lDcENyVW9jYkc5QzJuZ1k3TWdPMWkrM3Y2?=
 =?utf-8?B?Q2N5UXZoT1YvMzRacmUwZ2hlbGVYTTdPVTZ6Vy9JVWYrNGVlYWlEN2p3dDg4?=
 =?utf-8?B?VnBzTVlqd0t4dldlY0EwcW82Y0VUak5ZOTZDZmE5ajBSN013OFBMUHBNRkJC?=
 =?utf-8?B?enBudFNQT2VsNjF4cnE5YTg5YzNSUjVjSW00b2U0L2RoYnZCeDlWckQxVHdn?=
 =?utf-8?B?M3BjaENJVFdvekxueE8wOG80TTF4V0EyenJkVHVhT2RLUjNFOHR6QU9WZzdH?=
 =?utf-8?B?TWJJOXFYV3hteWxLSnl6R0VaN1hIaDFmbU80bnNPdDhyVmd1cHZmK0hJc0t4?=
 =?utf-8?B?U1hXbFpyc3JYVUlJVWVPWGFsVnNwRXJHRS92eTlOT2lURXNLc3hrclc4dlBD?=
 =?utf-8?B?T3dzNmlmbEQrUk5lRUpSbi9uT0tta3VZR0pKdWhFL0hkNUpnUEk4M243VW9m?=
 =?utf-8?B?UmI0SFJFT3ZlTkR5SUtvdEVQT0drMnFTcEVKU3hubHM2NWdzNjJMWGZuclhM?=
 =?utf-8?B?ZHpzbXBMNGNvYmxQMFdVNVovNCtxK1J2cWdpMytpMFFFVjRqc0Y5NkxtaUk4?=
 =?utf-8?B?YUNoYjNvdXA5UHpGSjV1K1l3RTE2S2JINjg1SlNnRnFZNjdWa0luMjdXY2Jw?=
 =?utf-8?B?bTVIZHEvaVB3OUJFYk5jTFF3RWZOYUg0ZjhCSEtQZ1JlUEd1NitGQzR0Nkdr?=
 =?utf-8?B?YU9ZUjlOdndidis2em5pYXdOeGozM01pVjJzTDU5WVpCYkZhYnBHaUVLcU9H?=
 =?utf-8?B?c1JqeldBcGRnMW4ybDY2Y0pYdVhDQmNNWDlXdnV5R1djK3IrYVpydkhQU2xY?=
 =?utf-8?B?UGxrWnQ1M0E0L1RQVkVsazVQZU1sc3NEUGpSdjljRnRLUmhPOTJUZ3k2bjVw?=
 =?utf-8?B?VE5UeTBpYXY1TEhLSi96RGc5K0pMSVhqT0lwZnRvRElLYXQ3M3ErU0xFbGh4?=
 =?utf-8?B?ZzlzNFN4RHFyU3Eya0ZnSEFBR2w1bXZXL2pOb3V4L05YUmpHeCt1bHhWQ0ZC?=
 =?utf-8?B?ckxtWnppLzFoSE5KYVllSDJnK3hVWlhaaDI0UVBoUk5OSG1LNlRqdXJZcEFY?=
 =?utf-8?B?LzRRUXl1eks2S0Y3NStjOENZY1J4a1QzQkNRVGFoTXI3TXpxOVFlOVZucjl5?=
 =?utf-8?B?akljOG10dTFSUVFQbnV3S1VnNnQ3MHplTUNobjVjN2hvY0pTSC9oc2NZMUpW?=
 =?utf-8?B?YmpQZTV5eEhZU2FCS0k5QjZYTjBEL092RDFnbDcxeDJBR3R3K1p4NCtNSkVw?=
 =?utf-8?B?TFZqdmpLWFdaUXRCSE9hQ1lmNURVNjJVamNCcGZ4RHJ3RVlSVDdJM0lKWSs3?=
 =?utf-8?B?K2gyVzFvVmNLY1Zjd1hwUlVFSzBIb2t0YWtCVUlYZG9OMGcrNmRCaW1TQWkz?=
 =?utf-8?B?cjFQckx0TFFQeVRlWVJlTTdJWDE0S3VpOGtBelZuTFlPZitmNHNVWlNWRExG?=
 =?utf-8?B?OE9Tc1BHTEZZSkF2cVdEYTBLSHVTTnptSlBlMjJUSytHTnRuTzA4bHFGOTlL?=
 =?utf-8?B?L1JTSi9hd1RNNWU0WXNMZ3hUZXFwQ0F3bnpnMlUwTHVSVDBIUnpBSzNYNkwy?=
 =?utf-8?B?TmlFSFFJTDJVRkxlYTNLSXFGWnZyZ1VsUDBoS01OZUZyTjBmSlFVNnB6OTFX?=
 =?utf-8?B?YnJQQkVZOXJIdjh5RXkvVWRiYjBybGdiR3J0b0JmN2Z6c2FrZzJidjBURGRl?=
 =?utf-8?B?alY4YlZnRFE0VUJnU0YvOTErT3J5UkV6SC91VTJOVDFpQ05CWWdTN3kwRDBW?=
 =?utf-8?B?angxN01seDlHNWNNTFlNOWlyNGpVYTlrcVd2NjBsd3BKdGFNTkJpWjNiRnhP?=
 =?utf-8?B?WHFWdnNRQTdDdmx4bnpnRTlHQ3BpTzNHVTNjNi9MNUVNbEdlQUw0b0RRQTV4?=
 =?utf-8?B?a1JlRVZYZ05aSTRqcEZXczhCSEtUVXpCVUg5NzVCT1RBTzUyY1k1SlhMUmRT?=
 =?utf-8?Q?gHNK9Te5ruXX1CyZLBU58DZjc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c60524d-d506-4ef3-20f5-08dcbb76eae8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 09:04:20.4961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kb8Ia41YT8mqVfjmPuFVvQFQYA9pcoNtsf+KQwj2TVnSBwoHA9l+yF4A6oMFX2X5d5r6p2MtP1ZBe2Qq3GDXTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8388
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 2024/8/13 16:00, CLEMENT MATHIEU--DRIF wrote:
> Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
> 
> Super reactive!
> 
> Maybe we can continue along this path after the handlers are implemented.
> It would be great to make sure we don't process PASID related descriptors when not in scalable mode.
> What are your thoughts?

yeah. let's keep it in mind when reviewing the stage-1 translation series.

> Thanks
>> cmd
> 
> 
> 
> On 13/08/2024 09:44, Zhenzhong Duan wrote:
>> Caution: External email. Do not open attachments or click links, unless this email comes from a known sender and you know the content is safe.
>>
>>
>> In vtd_process_inv_desc(), VTD_INV_DESC_PC and VTD_INV_DESC_PIOTLB are
>> bypassed without scalable mode check. These two types are not valid
>> in legacy mode and we should report error.
>>
>> Suggested-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>    hw/i386/intel_iommu.c | 22 +++++++++++-----------
>>    1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index 68cb72a481..90cd4e5044 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -2763,17 +2763,6 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
>>            }
>>            break;
>>
>> -    /*
>> -     * TODO: the entity of below two cases will be implemented in future series.
>> -     * To make guest (which integrates scalable mode support patch set in
>> -     * iommu driver) work, just return true is enough so far.
>> -     */
>> -    case VTD_INV_DESC_PC:
>> -        break;
>> -
>> -    case VTD_INV_DESC_PIOTLB:
>> -        break;
>> -
>>        case VTD_INV_DESC_WAIT:
>>            trace_vtd_inv_desc("wait", inv_desc.hi, inv_desc.lo);
>>            if (!vtd_process_wait_desc(s, &inv_desc)) {
>> @@ -2795,6 +2784,17 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
>>            }
>>            break;
>>
>> +    /*
>> +     * TODO: the entity of below two cases will be implemented in future series.
>> +     * To make guest (which integrates scalable mode support patch set in
>> +     * iommu driver) work, just return true is enough so far.
>> +     */
>> +    case VTD_INV_DESC_PC:
>> +    case VTD_INV_DESC_PIOTLB:
>> +        if (s->scalable_mode) {
>> +            break;
>> +        }
>> +    /* fallthrough */
>>        default:
>>            error_report_once("%s: invalid inv desc: hi=%"PRIx64", lo=%"PRIx64
>>                              " (unknown type)", __func__, inv_desc.hi,
>> --
>> 2.34.1
>>
>>

-- 
Regards,
Yi Liu

