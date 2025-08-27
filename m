Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4365CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 11:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urERd-00054k-Gf; Wed, 27 Aug 2025 07:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urERU-00051t-Db
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:35:52 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urERM-00040F-JV
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756294544; x=1787830544;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LY3HJXkmKvE+rBhFMQoww+twxhk/hls0JBtYE7ghWlE=;
 b=jTWbIenHfQZatGt69zoFcECm7GI7cOSs8YQ54Ve7KaCaWuVB2MXsktVT
 PiEs6DKxQ3fvmj3M3C9mygUa0+ix9Fl3FBD6ePk7H0tUWzw+kHIXEjqPs
 8D/jcqZW2VHF7hxv6pJ6wNHeBIRt5uFWMiciPK/yfgGuhWwL8BiiUg/GO
 4SehnHD/YtAy3djIj/xp1MtMfr/7vFDVP54Db06XjDbmVeqtaV3i+MUZ6
 H24RG4Ib5qCD9lNQIk9chawPbcytTjGKDzgVORBHHQX2OZNulGi00iYOm
 AsYVkHWcmFLSU1VIRUlol/iQoDRcqDYN5usrrof2a9JRp3p9qe3AAG7Q4 A==;
X-CSE-ConnectionGUID: CPmd/v8+R62AQ/6n2Md5Dw==
X-CSE-MsgGUID: dSzpvO/qQpKyZRsuzg8XHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62382925"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="62382925"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 04:35:39 -0700
X-CSE-ConnectionGUID: 0QWuUmtdTz+r8qmyyzI8Nw==
X-CSE-MsgGUID: raS47Nu3Rqat+CaVQ5vltw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="169421642"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 04:35:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 04:35:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 27 Aug 2025 04:35:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.78)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 04:35:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ug4gzk6BG75YC+lmeyJIn+Y7TuRJGmMBGsb3koJwm+Ad6NE5UAu2MSLfUQYnNUBIc2LPT1UsV0QR3MYT80KZ3ctOBhytTSKl1isyPDvh0ZS15btqsYGOKTr9ghVCns1+Y07GUR55c651qu7ywkkCKzErxHLVS0SLJhc03CPT7MQRMfv2KHcQRxzKS9+a0k2Y5gnMLe1O3N6Xvjwl2YF5n4rgq9xyeknOuH5swyfLvcgiMAJvrkGhhU1U1pqcxmpqTM7ysMYmxTbjiUQXyT6CFLHdKRZfHwSJGRsPcZJLflUr06bE8wPaBFSDDIi7VZIqGdfg1raCBs6uWGofxj5Zcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWT9RcKBP3402SdIiKq6bMOsPsq/rYMDmckV1Z2UNgg=;
 b=iJmTY+cPBimueCWGTFVkUex+W4UXYBTMKqU9XviJmUomiiDMfPI4VjRdX6xN4qjYOy7S/5BFfv0tmU8dMRewNmvCkaBNM7Y/ej+cFKi+PoBA23fGCLIsj9fK4jKLldySQHCeCqunVwjpJNE5hNiuv/PsuMspqDImQ9iPCD2EalDsONd42yItlX50YUMR2hypbnuxpYiZegoUuTHOXuLZ84mmT/TwcUnWkE2BsBGFG1dxXeUBrrI/W0Y0eDL3hdDW7PqpCOUszceSyKAj7oRCdFMmLxAgNeFxGaNf6dh/ii8rt17GIa6rfh32jMvZ675XYda6lwrM8bKe7buBBA3uBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by BL4PR11MB8846.namprd11.prod.outlook.com (2603:10b6:208:5aa::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 11:35:36 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 11:35:36 +0000
Message-ID: <ce1f61db-5746-4ae4-837f-237e9aa5de1c@intel.com>
Date: Wed, 27 Aug 2025 19:42:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/21] intel_iommu: Check for compatibility with
 IOMMUFD backed device when x-flts=on
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <chao.p.peng@intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-9-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250822064101.123526-9-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|BL4PR11MB8846:EE_
X-MS-Office365-Filtering-Correlation-Id: c2784aa4-a69b-40ac-1ac9-08dde55dd6f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|42112799006; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGJnVHo2UnJTQ3lOSUdlbWdFb0hIQTdtTHNZcldCQTh6V1djZkxPUlI5Y3lR?=
 =?utf-8?B?dWxaakQzLytYcXdKU2h3K09BRUJncmlrMEg2aHdqTGtkaW9mdWlMUE5zZjVT?=
 =?utf-8?B?ZHgwemRmOXJ5bDdCQUVzY3lMOTZDQmFERi82R3k5SDJvVDh3eEFyMUw1UVdF?=
 =?utf-8?B?d2NMTHFSTXc5VElZWUQrTU5LVzBuTm1oUGdwT0FYYkVvUHE3RTVMNmtRMk1Z?=
 =?utf-8?B?RUlTR3hnTXZ5Z05ERzN0N0V0ZExCQVFLU05aNVVzV0poSTd3aUtZNmgyOS9m?=
 =?utf-8?B?ckQxTUxDRHpqWDRUVUJPTVZhc3F4cVlpbGEyYVl3VFY1RUZiWGxhMVFReTA1?=
 =?utf-8?B?aU9HOWdBZUc1SVpzbHlpcVZ6aXBjR0hjOUFyTllLMjdZeGNBekwyeXhCblJQ?=
 =?utf-8?B?ZXY4aTVHQUMvNUhJSzc1U3IzZWI2VmZYUnZFUEZ5ckQzcWFxNEd4WHBmemtZ?=
 =?utf-8?B?LytCVXlIOW9RdE5MektiRlNBZlRrZzNBU25XWkJ1Nld2dHhhMGEwQ3ZqK2ll?=
 =?utf-8?B?ektKTXlna2l5eU14WGo5bXJ5YWtDc2t6cE9WMUFZbzY1RE44TVJuKzJqbkVz?=
 =?utf-8?B?dGd4VDIyOS9IRnh6WDRrVWI3NUc5UUdvTnAvWmZKWkR0RE9uOWNVd1BPTUk4?=
 =?utf-8?B?a2xWNW9scmIvTnpralhFMUpWVXk2RHZ3NHY0Wk1TeUtCL09lTFdENFJoajRQ?=
 =?utf-8?B?K25KTEQ5b0RrZ3ZWKzA0dVlvZERQSnBpVTZpUmZvcXVsNENhdld1Uis5Vm9B?=
 =?utf-8?B?enlhTEp5SFE5YVYzMU5xS2ZIc0xZejBDQy9hY3RLQ0hKekg0SlBnN2JXbm5o?=
 =?utf-8?B?OVBYVG9vS1ZNRlJnNFJMaWZtUVZyZmtjN2crMGtZZjBZUzNqVEkrVGxUd0xO?=
 =?utf-8?B?eWp4bE9IanBISUN6MlZZV2Zyb2xJb3B3T0Z6L29SWTVXOGU3cHVBWEhTdkVK?=
 =?utf-8?B?dTYySEIxOVBBSTY4OHRPNzdjNFdPNFhCejZFU0lZK0s3dkRHRGcrcmNSa2hF?=
 =?utf-8?B?WlVTWUlWYXB1MHA2dFIyNEdnbDlMTHk3RnB6UUVrdFcxYnRnOE1SdVZmOCtG?=
 =?utf-8?B?WVI0TTdXVytvVS9wdEZRdWQxY3E0Ymljb1NZUHRzcHpCOGljeGszcjBDa3lJ?=
 =?utf-8?B?SUpPNHdBSTFMd0tkeXA5emFVMmk5WGlHOHl0SjBRZ3pKdTR3cGxYdEoxU25E?=
 =?utf-8?B?M3ZvNFVnaVNMLzBnNkNMMVFiYjBiMXdyb2dFR25uRUY4aHdNNG1EQmtlTlNy?=
 =?utf-8?B?L0pFY0FUUmVkVzAvK3dzVVFuMDJvT3dGeU5WQTJiTlh1SXAvR1RKcm1IRGFJ?=
 =?utf-8?B?MWFpY3FNRDZIS2RMVmhEd0Z4RzI2ZndqYWFzQU5mQ090cG15RUtPTDREQ3Vu?=
 =?utf-8?B?Wml1NHVGb3AwMExCdEo0TXJqQzc1bVk5RytHTUpXUVRWUEE4S0dGYmtuZVEx?=
 =?utf-8?B?Q21ZMVdVOHlOQ1I5b3NlQVBrUDE1SjhOUEVYaUxDUWM3d3RQeFRQVWhHcGdw?=
 =?utf-8?B?ZHdBVWYzbElBRDVjZTlTWW9BdkNYZnQrdVJOOTgzVmVUZXY3eHNLZGFuTG1n?=
 =?utf-8?B?SjBKSEhFZUZOQVlZWmloNWI3WWJwRUNvdTY3Z2pNUHZrSWtFWTZvRlpmWS8x?=
 =?utf-8?B?b3ZicEppT2cvbWROcVNHVmt5bHpLZjA2TVpHUkVYT3BOY2d4V0grOElCdE9a?=
 =?utf-8?B?MGJhSzI2VllPTzNMVTcwV3Y5Y2J1RWNua3NKK1pRaWRHVUhxL2FyUEJES2Zh?=
 =?utf-8?B?T1AwZk15Zjg1SVRnWFdZbXNKdDR6b053ZWl2RVgxWWFlQlFHREVUTnFsUWhM?=
 =?utf-8?B?Yi82STFrOUx5MmhKVG1CSFB0SFhNMnB3V2dxbXM1dXcralhrbUxleS9Kc2Nh?=
 =?utf-8?B?a1lsbVRURTMwZmc4UERPb21JWDBUZENpeURBTDZWem1PbjNhdzBPOW80VHVl?=
 =?utf-8?Q?bo9FkrKcKN8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(42112799006); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTRtU1YrYmNtelA1TnJuMVlCc1EvekdaODMrNGxQUzV1UUhSbWJ6MnVyWmdQ?=
 =?utf-8?B?bzJicEE1RmZpTkh2UnNvcUdWa0IwbTR6ZnB1bUN0TnpGWndoUU0vMEkwakJl?=
 =?utf-8?B?M3QwdlNnT3Fud3hJMlU5MlFCNzR1a1VSRzhzWm5vZm1qbi9CNlc0MEpkUzMy?=
 =?utf-8?B?NVMwbElVRSs3YTNjS2E1NjVXQVZ5YnovTXZTNlBYNi9ueVFabEZ4ZzNxbXov?=
 =?utf-8?B?Q2lncG14U3NUT1RHc2RVMWJZK21lOXcyKzVYdzg5MWc5R2MwWnoyZUY2a2tI?=
 =?utf-8?B?dXBYWlRhR0RrNk5KSFJmYkczRGRNMzlRQWdpS3BOYSttQU8yYWJHNnBsemRS?=
 =?utf-8?B?UU1RUkF0bmlRWk5SSThWY2JRTjZ6MGVoQ2ZaSUg3Tkt3aTlQSkMzTTBNc1hv?=
 =?utf-8?B?WkR4ajcvMWVCUk11REw2YUpIUXVxV2tNZzZXaE8wbmFpMXRITklHQVoxTDNo?=
 =?utf-8?B?ZWYxZXRPa1QzaDdJUzJucUtDWUlRVmhaZEVCTkVvWk9oVmllcHE3c3p1T1NE?=
 =?utf-8?B?UmZndUlla0wzKzkycnFaSmhnYjNRZmlhTWRSdUFQNFhkcG5FN1Z5d3hRaDFJ?=
 =?utf-8?B?NVNaOTZEUzYyOVNOeW9RS3NnS24zNmxUcjdDL2JRTGNPMnBYWnB2UEQxdzg4?=
 =?utf-8?B?TjFnUkJ3MmFmaXEyelZOQmVobFd1S2JRdEQ0Qm5pM2h3ang3Qjh5NEoxOTY3?=
 =?utf-8?B?WktxTFI0NStDRFRKOFg5dWxMSEdKRnMxM1VZWW81cWRFMmRzZHJCVmp6SDRU?=
 =?utf-8?B?SkNEUzFTMDdpemFDYnc3cXFZWGNiSEFUUlE5aVlXNUIwY0ZiTERlSEhmb1ZQ?=
 =?utf-8?B?VVZWa0g2Wkt3NVk4Q2ViQVlpcFp3ZjdkUVlNSUE2QWZrRllITTdwZ0JZQ3RC?=
 =?utf-8?B?UXcxZzBJL3JMZnQrZUN4L0pIK0JuRndHeTVoeGVIOHR2L0JqNUJKZTlwME1L?=
 =?utf-8?B?N2pjUFpiNVMxREJpZi8zaFRYWEUzc01jSzN1YzNLQzlmdzc4MFNKQVpycTgx?=
 =?utf-8?B?QzRHMlhhZVhFUjRITHF1elE0dzNhd3VMZmlTN1MzRVE4NVZ3WUlSN3FDUFc4?=
 =?utf-8?B?SkxsRnVuWDFabWdoZ2ZLeXNhVHdmelYyNEhQWnNTSCtBdzZySXA3V3U2clY4?=
 =?utf-8?B?LzNiUk50SWJJU3NhMUlMa09taVYyeDVLODByMUJiWnMzQTEzMlVtc1I4cGJ0?=
 =?utf-8?B?Vk5uOHhzaU84aTN3T1FoaEVIR0NVMVhVcW93WHhKWkVEQlFaTjkyTm5FYnpl?=
 =?utf-8?B?RitMeUd3MStqbXRpeDI4Vnhrd3BUWXRacDV3SjdITHFkY2N2L3pKcjVGMEw0?=
 =?utf-8?B?aDVWV1VmcGpXbGZyUUtHSkZncEdJMmsrbDY1VUJkMFh0RGtWc0ZQS3BVdVJ4?=
 =?utf-8?B?R2RGS3lyWUUyZjA3VktQN0xqR3NtTVVyQUFPb2grcXZnTndnUmcrZG9NRWNU?=
 =?utf-8?B?WUxpb20rVHByOTJZQ0dXVnVGRG5DUkxrWVcvVWFyTWc3aVpkWC9HZkxPSU5Y?=
 =?utf-8?B?dVIrdnRRdHU2WXI0cklSYngxdW1XdkdWU2VBU05VQ3Q4Q1RaRGptNTZSSXlj?=
 =?utf-8?B?RlhiQ1F6YzNaa0g2am9NTE1teDRiejFRZmRNZGNTeDhYODNkVlpnZCtZM0ZJ?=
 =?utf-8?B?aGNaNFYxaHRFN0Zjb2Rmc21YYkVuOUN0SHJ3VFY2K1RTd0RRV1pWVk03VS9V?=
 =?utf-8?B?ckpTNkFCTEFmeDV3MFRHZENDSnlDQUZqVm1VaVRQMEVBMGgraWRZOWR5NDE1?=
 =?utf-8?B?SFpEeHRUb1ZqTjZrbytNeVJXYzlmZXFqRUpsaXE5cjZyQWJqSSsxSkUvSnhS?=
 =?utf-8?B?SWtUUG8yL1BEbGszSS9ZbEdvQms0Q1ZNalhxWmV6bHIyV1lEUFliUy9MMTZW?=
 =?utf-8?B?dHlBSFp1UTdSL1NyY3dEdFlUZGtkSjBJZUlRd3hjK2NKM2EyemRPZUxkbXZs?=
 =?utf-8?B?M01KNUU1WXBkclVRT0psSVRCLzI1NmdHcVdhTzdtOEo1VG9WRCt5WnRQRFBU?=
 =?utf-8?B?TnFzVFFVeWRzUTRualZQc3R3NHgybzJxMjFrazd0N1BOd0plcktWb0ZRUG5R?=
 =?utf-8?B?QVBJVDVVa2p4L09QRnk1a0dsRnR3YXJHUGhjUVEzR1VlZE11Q21Sb1dRTzNO?=
 =?utf-8?Q?xewH6E2ruUeUg8QsFksK7rxHi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2784aa4-a69b-40ac-1ac9-08dde55dd6f6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 11:35:36.0314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yL+k/3e/ROhwFsfJOqGS9qFXh0JMewMsICTbPWZm9xl44ZSreVdC7+Z83teTgdAaiPu/F4+U8ovBf0R8MjlMKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8846
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 2025/8/22 14:40, Zhenzhong Duan wrote:
> When vIOMMU is configured x-flts=on in scalable mode, stage-1 page table
> is passed to host to construct nested page table.

for passthrough devices :)

> We need to check
> compatibility of some critical IOMMU capabilities between vIOMMU and
> host IOMMU to ensure guest stage-1 page table could be used by host.
> 
> For instance, vIOMMU supports stage-1 1GB huge page mapping, but host
> does not, then this IOMMUFD backed device should fail.

do you have a list of what caps should be checked to ensure guest
stage-1 page table work on hw? I can see EAFS. But it is not yet exposed
to guest, so no need to check it for now.

> 
> Even of the checks pass, for now we willingly reject the association
> because all the bits are not there yet.

better call out it would be relaxed in the end of this series. Otherwise
it's a little confused. :)

> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_internal.h |  1 +
>   hw/i386/intel_iommu.c          | 30 +++++++++++++++++++++++++++++-
>   2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index c7046eb4e2..f7510861d1 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -192,6 +192,7 @@
>   #define VTD_ECAP_PT                 (1ULL << 6)
>   #define VTD_ECAP_SC                 (1ULL << 7)
>   #define VTD_ECAP_MHMV               (15ULL << 20)
> +#define VTD_ECAP_NEST               (1ULL << 26)
>   #define VTD_ECAP_SRS                (1ULL << 31)
>   #define VTD_ECAP_PSS                (7ULL << 35) /* limit: MemTxAttrs::pid */
>   #define VTD_ECAP_PASID              (1ULL << 40)
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 512ca4fdc5..da355bda79 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -40,6 +40,7 @@
>   #include "kvm/kvm_i386.h"
>   #include "migration/vmstate.h"
>   #include "trace.h"
> +#include "system/iommufd.h"
>   
>   /* context entry operations */
>   #define VTD_CE_GET_RID2PASID(ce) \
> @@ -4366,7 +4367,34 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
>           return true;
>       }
>   
> -    error_setg(errp, "host device is uncompatible with stage-1 translation");
> +#ifdef CONFIG_IOMMUFD
> +    struct HostIOMMUDeviceCaps *caps = &hiod->caps;
> +    struct iommu_hw_info_vtd *vtd = &caps->vendor_caps.vtd;
> +
> +    /* Remaining checks are all stage-1 translation specific */
> +    if (!object_dynamic_cast(OBJECT(hiod), TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
> +        error_setg(errp, "Need IOMMUFD backend when x-flts=on");
> +        return false;
> +    }
> +
> +    if (caps->type != IOMMU_HW_INFO_TYPE_INTEL_VTD) {
> +        error_setg(errp, "Incompatible host platform IOMMU type %d",
> +                   caps->type);
> +        return false;
> +    }
> +
> +    if (!(vtd->ecap_reg & VTD_ECAP_NEST)) {
> +        error_setg(errp, "Host IOMMU doesn't support nested translation");
> +        return false;
> +    }

this check may be already been covered by the sync in patch 05 as
the set_iommu_device op is called after attach_device. If no NESTED cap,
allocating nested hwpt would be failed.

> +
> +    if (s->fs1gp && !(vtd->cap_reg & VTD_CAP_FS1GP)) {
> +        error_setg(errp, "Stage-1 1GB huge page is unsupported by host IOMMU");

s/huge page/large page/ as VT-d spec use large page.

> +        return false;
> +    }
> +#endif > +
> +    error_setg(errp, "host IOMMU is incompatible with stage-1 translation");

s/stage-1 translation/guest stage-1 translation/

>       return false;
>   }
>   

with above minor nits done, the patch looks good to me. Hence,

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

