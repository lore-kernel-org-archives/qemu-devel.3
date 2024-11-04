Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2105D111A0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 03:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7nW4-0002yX-Sf; Sun, 03 Nov 2024 22:12:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7nW3-0002y5-Cx
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 22:12:31 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7nW0-000347-Nd
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 22:12:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730689949; x=1762225949;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mWpQeFuBLKu3tfwGRS4IXsbGyZagGK4XqxoORAisP2E=;
 b=OrlUM6Ahcvs9h2y8BVo3YfxxpuHx1rUOGx4e8S2j7fhpZlEICNFW82p8
 kkTY/G1lOxWZm1tYe9lcejJ1NJ0UJkEdMS1i6inaH7+L2DdIpxdfW6Xzo
 4xN58S4UJHVFJ6ANmR7bo8m5xM0tajh7GZZAppk4ZPU7CG+QbnFrT1OAi
 hPt4D/6kdd8xDn8jTTLe02B+oBxS5gNJsRA+nIf46aOGDWwiuv5M9e45J
 evq6Qj4LpfzVk7SJcDSIbOd7h552FX2OQGBeanVkBvKllIJi1qLWCapwG
 zsMScZEJ/QdDq3LyV/odLfvEsyyN3AyBAE0PQkdGJIASq+uWQk+Ebk4nq A==;
X-CSE-ConnectionGUID: skbv2rMUQaeJ4TTezbggng==
X-CSE-MsgGUID: gkpbdObiScSYegI2E3Ihig==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="17992471"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="17992471"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2024 19:11:48 -0800
X-CSE-ConnectionGUID: NCp9Ab2nTjasoZ7OWr/JJQ==
X-CSE-MsgGUID: Luz9HUwZR3+BSyp/Q5lljA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="114312213"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Nov 2024 19:11:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 19:11:47 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 19:11:47 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 19:11:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C07ffXcycNROM/4XoWxrU2dAfyiCSoLfQ37aztdhZH7BUpuRwsl+UTGH9MQiGW5I1KXAUYGyHj6KdH34Xo4YfD4oXHJRBhiOXFsD0tGHH50F/98EVF6KkTRO4bE46x70Gai1pSC0K18Voa9JRJxxXM6iif0XXCVFr1cmPi1K+Vr0wQu7udsq0y948/tPO8uQRG8Iwb/L5/aUh5XzKvoz06E8y8t2YmkAGmgJnaFGUh+sUFkh1x9GWCVJYMjU4JaXAlrEdZe+kvZx7xwFpSP+WWxS14DPxGAuGeRhLU3x4XxARqjuk+n9tx7zALIwf97n+ay7Q9exCL0Dgz9qL2kKNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VCt9g/wxyHz7L+sdWqVx8adD8kjuW0/AHtd2NArUsM=;
 b=Ne92XRGIeazy1iUbau3onG/laeT+FkLoK1VHN9xi0W7Pt7eMoCVcTN5hr5rO85Pa6jfogY32UnVjCwPmm570Gaes/uBTkFghB47FunPs/CKbMXyrF6xRMoDglbfkS6Fr0TDwLzIxIDcpeIZ3wiYLgend7qSPT18Hgkqe0PoLmG6yE8+IXXYgHsHFPHrEhJyrq5WQhYua7MVzTsqzic3sctTR9+zcZXC6fSG7cbJZVm4fs77dfhLqdQlTyPt+rIPbTyPdD/Yn2KGgvTAMbl875I2TNDmi0oFzUZQTqSdWS0I06hps1/q39641mMbXSSjU9uMN3oFrVjRoXA9Z7kYMlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB6495.namprd11.prod.outlook.com (2603:10b6:8:c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 03:11:45 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 03:11:45 +0000
Message-ID: <74b6f85d-f5b5-48da-8bc5-bfe721250687@intel.com>
Date: Mon, 4 Nov 2024 11:16:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/17] intel_iommu: Set default aw_bits to 48 in
 scalable modern mode
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-15-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240930092631.2997543-15-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0134.apcprd02.prod.outlook.com
 (2603:1096:4:188::14) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB6495:EE_
X-MS-Office365-Filtering-Correlation-Id: ac97bb10-7910-4c22-cedd-08dcfc7e69c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2RmMVRKMkRtNkQ3Nmd0RFdIU2g3UFE5eG5sYkhCL3N3OFk2QldZR0tCakt2?=
 =?utf-8?B?bUFkdFdQWi81T2h3YXNXaWV4bXJ6OXVGNU52MWwzZHRlRDBod3JrVkpGYmVz?=
 =?utf-8?B?dzVGSDUybkNvdU1EcWgrN1pVVDVxZHBkQ0s0bjVGVGNOdmhWbG9TaE4vVURU?=
 =?utf-8?B?eUg1VjNFQ2w5V0NtTHVnVVUxMXprZHErNCsyeGRWdjYyVklLd2t4a1k5OS9w?=
 =?utf-8?B?ZHZENUk4VTczdXJiSU9lUmF1MFFqOVlKSWdSMXVkT1hNREVQZUhMUUxDMWli?=
 =?utf-8?B?UnFXd2EyTWZEM3VWWFdkd1Foa2JQUFVPZlVuWlRVdjZaUnZTUDNGNXJOWGdM?=
 =?utf-8?B?ejdzU1NnVFZEeVIwcjlVRjRxRHZsVkw0L1hxMzluUGI2c2hPT2hJbHM0SGxu?=
 =?utf-8?B?T0NXZWRVSjZqUVptaG51alR2WHFkUGxrN1FVQkFTNnpBaStJUDcvMEJ1cTdF?=
 =?utf-8?B?VTBES1hlRExHZmdSWFBrQ2llWVIvUHVEWis4NHdYNGpBQUd6T01FakUwUUNv?=
 =?utf-8?B?OXZYNEJwdXJFaURXWUt5MU53d01oU2FCc3NqKzNheDduOUZEUnBOc1lTbDVQ?=
 =?utf-8?B?KyttWitoSTRId2pHQUJ2ZmtTUTZMcHdtdHIzc052QnROL3cxc3RMWkxZZkY1?=
 =?utf-8?B?K05TSzVRSUViK3NidnE4dWhyZ1hKOTBueU5hSUlvVFh6NHJpVjE5cW1NYlJt?=
 =?utf-8?B?b1FpRVZLTXB1c0Q3VmF6UlY2dFVhT3IrZnBNTDRWMTd2QWJ4bkNhWWlJeFNz?=
 =?utf-8?B?ZnN0bkxwT3VwUzFyV21RcjFXSkt0SHd4dTUydSs2MEE4SitZZmpRUzNHOGxW?=
 =?utf-8?B?TlNsa3FMajRhRkcxc01GOEYyc0cxL2ozUGJkK3FUbjZqK1hEOTFjNEpPWlRj?=
 =?utf-8?B?NlhVeWFmN3g4TmoyNXVFMHp5aHZxT09FSGpzWlRBV3BVc0drWnNZeUdSRTd1?=
 =?utf-8?B?dkFkcDhydGxnbnhORzNsVXNXNTRDMTJTRTRHZTdQdUZPdW5Rd3IxYllTa1Js?=
 =?utf-8?B?MXlHanNDSE1hMjJJNlVBeVhPNGxzckN0OWd6aFBiZVlyenZoV1kwTWpJN1Fn?=
 =?utf-8?B?dUl0eWtIS0FvLzYyYWoyTjBOVEVERUkwanJIN0xZY1ZFNmczbmNuT1M1UWs4?=
 =?utf-8?B?SmxiQU5uaGhzTVUwMEludmNtYjdWK3JUN2hJWEZodUFtMG82eDR4MExuVURa?=
 =?utf-8?B?NVpRa0RJbFVuZFlTQ3dOL0ZSZFBmbW5FMHdPdGJldERWWVZIbUovelQ4UWgx?=
 =?utf-8?B?MWpZVFNCWjU5Q3ZmRlBhWDdNVVJMUDJYZXlRN1ZlVnhVb01HYTRxSjVkYWVt?=
 =?utf-8?B?dm5QcTNZeFFiR01keTJsY2g4dVp4NGpQZTFSRURkYis1RUNTRkZWMGIzK25U?=
 =?utf-8?B?MUU0OFlwOS80N1I5L0Q0MlY4QXg1eXFDWjVVdGlEUTVsUjhDaHpBb3RDTHYy?=
 =?utf-8?B?d25NK0pmazIrZVRERUVtYjZOemZwNXpuSnBhYnZlc1l4bXZQdXNYUm9yMDBt?=
 =?utf-8?B?bE04M0c4M2JiU0Q1UmNFaGNLREhHQTdYQjBYbFhhcFprdjJDV29rbnh4K3BW?=
 =?utf-8?B?TytHdjRoQ1VrWk5UckQ0WU15eE5nd01MVTNyUHkyWWxCVGlxVDNuUUpDS0xw?=
 =?utf-8?B?MTZSQUVCTTRlTXUvbVdwUW8yN2FTajZrS0R3UytvR1lwWWhSREhHRjZkZVJT?=
 =?utf-8?B?UGhBSDdpclJobVhOS3IrVnc2aWxlOFlHVkpTUnVYNFFpVlpLZ0pGOC9KMlpE?=
 =?utf-8?Q?y7pp7tQvMrZ4Mz4GsOjoNC4G7pIdddAhWHVokoV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmlJSlhBR29YWDFMSHFoWUdLN1pFZVVzU1RERFdlN0dvdTZXSjBQZU9iZjc3?=
 =?utf-8?B?a0wvdHZDSTRYNWlwbXAyQ25vdHZsTjd2RHZHc1dGalhCTnl5bEY1Y0IzUHZr?=
 =?utf-8?B?VGlmNHoySnZUR2IyWkJUYmdQMkZwc3k4enlXRW5UOW5XYWV6cnQzZnRPQ09C?=
 =?utf-8?B?RGVHY1I4bkpMNGJRdzA3ODMwQllEMVNrWllnSWxRcGhwQUNraDlBTnVJVUNq?=
 =?utf-8?B?ZWpCNGVyaHpsaWd5SXBHRDFBaWxJd2pEWHJySzFVSFppTzNadzN4eEl2dXNv?=
 =?utf-8?B?b0REazgxdEZBdUg5dHp5ZXpzZ3NNN054Z21wN3BhRVJPUSs0ZTByQXdtZDRz?=
 =?utf-8?B?MU9iQU1HNURvRTBZR05sZWxaQzZhNlJ4NWh5ajF5RGR5bU93Zy9POGVxeFg0?=
 =?utf-8?B?UnIzS042MnVUR3dDSjBRSkZoQ01mQ0J2UHZaNENmc3JEMmRKYTlBb0g4aWJB?=
 =?utf-8?B?NytXbGY4aE5zZVFUY1FGbTJjc2VvV2w5NkN1d29sYWQzN0hCL2xzZ09Bc2tk?=
 =?utf-8?B?VGJzN3FDY2JRdm5qeFVBVzczRTNKcnIwVkE1STJXejFnanRHNlgwNXd6T1Nx?=
 =?utf-8?B?d3k2cXRLOHhvME91b3BZbi9pWXorUERqZkZZOUFMdWhXZkhWMXZ0YWNSbHgx?=
 =?utf-8?B?ZW9OQjE3MEhmbVBFQzNSMHRjRjM3akVGbzlUR2NrRWJkUHY3NjI1bFpIU2xK?=
 =?utf-8?B?M3pVWDNBd0QzMzhsU2lKM0FMUVFkNDhrSXZWNDN0TkZrak9tT2NHMlFYclp2?=
 =?utf-8?B?T1lWWXBQVWdKckNqWVFOdnREazkweGw2cG4vTFJybUVMbTRYM3JXcTJTb29y?=
 =?utf-8?B?d3hiMVBPWGtIeGpIZ3lxNTNBTk1CMlR3enYrb0dCb25uYzl4WEFhQ21YY3d3?=
 =?utf-8?B?MFdFd083ZXNUSTJzMlJoREhIajF1b05MMUhZenY0V0NqMUhkTlBVdEtBb1cv?=
 =?utf-8?B?em5YK2lHWTdVSVlFWXVPakJ0SlM5QlBHeU9ZNGVoKzBrczhpOXo1SGhBdS8z?=
 =?utf-8?B?NWRoYnRvZTVnUUtxZFVEYThMMTNFLytHQUcwbGE5Nmx1azJrZEE2UE9Kc3lI?=
 =?utf-8?B?V0lKdlJlMjgyN1J4OE5Vc3RPR0VaQzRxeFQ1RHJKV0FUdEVOY2dEdjFUR1Jl?=
 =?utf-8?B?M25CUmpIeTlWVWFLNjE4OUtKdUFITE5WYm1MN1VBV2hrWjFHK1M1OWtLR0dF?=
 =?utf-8?B?VTB1amI2MHpXdDBsRHV5TUxidVMvTHZsK0NmV1JYT1lmV2NoQm1UNFFvU2Ev?=
 =?utf-8?B?RjlmRlZMREZ0U2JhakpmVnVIU2Z0UE1Wc3ZnQm52NFZ3S3A2WVdRY3Q4cVNy?=
 =?utf-8?B?MExZMmc2dkxCRVk5M3R5aHJ1cDhSZkZpM1h0eXlycyt4VzhQRVI0bVlWaEU1?=
 =?utf-8?B?aWVpSlVnY0QzcVVUb3o1WjkzSzVISUwwMXRzU3p3QzRPZ1FLNytENjRMSmtT?=
 =?utf-8?B?a2w0NnFJWm9oekNTZzBiVmZvRjJKTldrNUFXSCtuK0VaZmtDcmo2dnhjM1pu?=
 =?utf-8?B?THoyb0Q3TFNEcXo0bzY5dVVWYnhjMjZtZS9UdXN4VVFkQ0xIeXZCdytRK09s?=
 =?utf-8?B?S0hDY05rc084eUNNaWN6SlN4ZkFMdDNNUFEyVk9zUUpVY2tCempXUkM2TnZM?=
 =?utf-8?B?Ujg3ZzFDbWNNc0N4emdJRkxjNDBKa0l5UXFTcm5mUmtYN3dZZGUyVG1UNHpI?=
 =?utf-8?B?ZmFWUUoxdVBwYWtCV0xEWURab1hjVldnMHUyZC91WUhXanc2N0FBRUlLUnRw?=
 =?utf-8?B?UERqU0hJM1p0VkxjV0MrYnJNR2Z1MDJkNEw2YzY0TWExVGR3M1ZtdHB3Y1pq?=
 =?utf-8?B?SVFzTm5ybTJ5R0ltelhiK0lWNVVIdyswWVFNcU41dyt1QUp0WUVsMnhCSmlQ?=
 =?utf-8?B?YjA2RlZwaXZNODRhODBWdG9xWEVURHN1bE5Za0pKZ1owZ3k2b3JXQmhiYmxY?=
 =?utf-8?B?c0hIUGsrODdVQmtuczJaay9hRXpmUmdjRTVtTjlwaEdET3lFa0tXU2Y4QWhh?=
 =?utf-8?B?ZGszNkJRSVBsVTBnMlNWNWRoZkZsMHRCbG52dnBkdFlXV1VLd3UyV1hMd2ov?=
 =?utf-8?B?c1dySFVhK2RtTFg1a2lZWXJJbTc0T1lyUXpkeE5UMGlxUVFQcjUvRWFlYUtw?=
 =?utf-8?Q?GWRqxeU/2ivZbj21eAoXeP694?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac97bb10-7910-4c22-cedd-08dcfc7e69c8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 03:11:45.3744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yY6jP6bwAdedNYz6pX3ruzILcqce3htb9568IJ4xzcFIGAUgnxTf26Y17cL8DcAkEHLifg9t9w/cGJpogcZ7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6495
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16; envelope-from=yi.l.liu@intel.com;
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
> According to VTD spec, stage-1 page table could support 4-level and
> 5-level paging.
> 
> However, 5-level paging translation emulation is unsupported yet.
> That means the only supported value for aw_bits is 48.
> 
> So default aw_bits to 48 in scalable modern mode. In other cases,
> it is still default to 39 for backward compatibility.
> 
> Add a check to ensure user specified value is 48 in modern mode
> for now.

this is not a simple check. I think your patch makes an auto selection
of aw_bits.

> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
> ---
>   include/hw/i386/intel_iommu.h |  2 +-
>   hw/i386/intel_iommu.c         | 10 +++++++++-
>   2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index b843d069cc..48134bda11 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -45,7 +45,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IntelIOMMUState, INTEL_IOMMU_DEVICE)
>   #define DMAR_REG_SIZE               0x230
>   #define VTD_HOST_AW_39BIT           39
>   #define VTD_HOST_AW_48BIT           48
> -#define VTD_HOST_ADDRESS_WIDTH      VTD_HOST_AW_39BIT
> +#define VTD_HOST_AW_AUTO            0xff
>   #define VTD_HAW_MASK(aw)            ((1ULL << (aw)) - 1)
>   
>   #define DMAR_REPORT_F_INTR          (1)
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 91d7b1abfa..068a08f522 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3776,7 +3776,7 @@ static Property vtd_properties[] = {
>                               ON_OFF_AUTO_AUTO),
>       DEFINE_PROP_BOOL("x-buggy-eim", IntelIOMMUState, buggy_eim, false),
>       DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
> -                      VTD_HOST_ADDRESS_WIDTH),
> +                      VTD_HOST_AW_AUTO),
>       DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
>       DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
>       DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
> @@ -4683,6 +4683,14 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>           }
>       }
>   
> +    if (s->aw_bits == VTD_HOST_AW_AUTO) {
> +        if (s->scalable_modern) {
> +            s->aw_bits = VTD_HOST_AW_48BIT;
> +        } else {
> +            s->aw_bits = VTD_HOST_AW_39BIT;
> +        }
> +    }

If the default value of s->aw_bits is still 39, you don't know if it's
set by the admin or the orchestration stack. This is why you need
to change it. right?

> +
>       if (!s->scalable_modern && s->aw_bits != VTD_HOST_AW_39BIT &&
>           s->aw_bits != VTD_HOST_AW_48BIT) {
>           error_setg(errp, "%s mode: supported values for aw-bits are: %d, %d",

-- 
Regards,
Yi Liu

