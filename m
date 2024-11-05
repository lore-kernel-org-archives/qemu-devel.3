Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97F1D1CA37
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8CxK-0001pA-1D; Tue, 05 Nov 2024 01:22:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t8CxI-0001ov-BE
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:22:20 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t8CxG-0000VV-74
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:22:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730787739; x=1762323739;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NSrQHSnxEGXi4LgJK+zfKg5HGoMkA0rReb6cM67HZnc=;
 b=GHw3h0pnpb4F9pZBkkhv75r2CMR1ucHHueiKL7VJ3IdAcMNc5UQhRDgn
 tXK6NA8zo9oIvo6RjpSde6uD977Sme7YbHN7++16cvAlxm0mYNOApXoFg
 qhdWFyG9y6px0xBOJy2L1a8Q59FxeUPozH+9V+NGyIdsuV533mvQqkpZR
 jAmkYmUA7vGreFPg4ctzhld3a7YqqL6jb90DDhSWFtCckfT2P9LQF4ggU
 Yb0bKxmwZzXgr7EP9rw2sutge+1pwy51tIw7cjzkfzrTWxB0Qtub4EwD2
 xP/QiiLrsBVmK/q2Iw/CsAC7GEU+fUpjDDZMyI1Ib4eJ+GYapDgPIFy7p w==;
X-CSE-ConnectionGUID: wUqHemNUSCa1D6faoeWNHw==
X-CSE-MsgGUID: lEmucDU+Rj+KlBnHHASoFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53081404"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="53081404"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:22:15 -0800
X-CSE-ConnectionGUID: dUAdiAwrR1OuVckt7nDjeQ==
X-CSE-MsgGUID: tMHUUzPPS1+EcVgb4mbVHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="114691245"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Nov 2024 22:22:14 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 22:22:13 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 22:22:13 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 22:22:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1A2a2RYx+Xz6AoSukpmiKDaPCzXpPoRuKYYBfzPOGARK22bQay/VUXVMqeouLNb0i0zICSqX/QqP4ZGW0A2FqRsmBtKEC0CCB7zjf+vRT0v1eQ5M9YqiR+F5gUakvk+DqGnDmx5RFxkPkkwwD36ahbg+C8vi3bOS9+0+SuUhn+8uzklJya7xg5NyXuLBHBtxcw1gKTkJpgB4wJJAil6b/tCD5zfVK/a6hnY5W11VY6Bg3Kn5kHSRTS3UxuR+unAf69V/qowTSNhNZKc993itKUe9JpZj9w9W1F6Lh4U7+11W3R/G+mOncL3aIRSg1PpSkh+5ttHbiJmBQchW7xoOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Y+87ZA7twHhEk49FBZwVZZ3bOOX0GEI3mJy4N/zs68=;
 b=lE1ql6//t/+ib4L6916bFdHSo3iblYc98S0vyyLTaFJIcnlKxbrACoIp0MlPMeA6Zn1q/Zv/AGEsqG9ME3qg7txBMyWY7eNtp7n4H22m6taklxWu5YSIg+i10zRCTJxsC8eG2NWWnIr557oHsHtsIbaboSYDlP4yMdlLC+rRNyHlsMznZQDnO4qXELr5MTjcy2cNo4MQyajxPedsMTNTGeE1w9JqkfH+VRgn4iRkz8cNZ9ZvhDDMcoZ9kkDm5mxa+ryMH79U4jT7nT5mU3zSMHNAWKr+n6g3ED2Y/LcGahGU7GxF85JwfOS+j5NCmx3htsPggaKsRjVaQ7SQs5mahQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SN7PR11MB6826.namprd11.prod.outlook.com (2603:10b6:806:2a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 06:22:11 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 06:22:11 +0000
Message-ID: <798702d3-82d7-42c2-ba71-e93eaea29f58@intel.com>
Date: Tue, 5 Nov 2024 14:26:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/17] intel_iommu: Introduce a property x-fls for
 scalable modern mode
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
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-16-zhenzhong.duan@intel.com>
 <5cbe6426-e64c-45f1-b276-c7dbb70ff3ed@intel.com>
 <SJ0PR11MB6744F2BFCE29E91D6180609292512@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <df02d9d4-3a54-449f-8d99-cca10bd28cf5@intel.com>
 <SJ0PR11MB6744C2B6BF0942C17720B23B92522@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <0780dca7-d5a7-4554-abf1-0cb92d49a2a1@intel.com>
 <SJ0PR11MB674438005FA244B7CD16278292522@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <SJ0PR11MB674438005FA244B7CD16278292522@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0199.apcprd04.prod.outlook.com
 (2603:1096:4:187::13) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SN7PR11MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: f56a0f28-8cd1-46e6-a9bc-08dcfd622e78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2NwSmdTR0dSMm9rbUlLMExTR2VSdDAxNG51MUdySTRKdDQ3dTNrK21GYUo0?=
 =?utf-8?B?bm5HekV6dXhXSXJCS2RDVFcrUzNzMFd3cFFUaDFjNWQwbFJwaGRCM29aT3d3?=
 =?utf-8?B?L0RpWHFkRzgvemVBcGZDREJPY2d0cFBlOHYvYmREczMzdXVJbG5UWG5TRXk4?=
 =?utf-8?B?TGhVbjZFVUtWNGdKNTNjVXZQVlJNUTZra3lVS21TK0Q3NG1udEhIZHg1bHVU?=
 =?utf-8?B?MGhEdjNIb1hEUFJMS3Jobm1kaVpvV1ZMWmZwNjlPYjl5OERoa1EvUitseDgv?=
 =?utf-8?B?OTFWOHdLcHFtSzdNMG9YT2ZaeS9tSGl3WSsxU2toSGl4ZkVxRmJ1TWVPRUor?=
 =?utf-8?B?TTdzSG1LdTA0S0N4UHpMSnRoenhOdHNEY05xc05nOGFJOWV4SHBNdDFYN3ZD?=
 =?utf-8?B?ZXRYTTI1eXFYMDJnVUY5bmZMMGJDRlM1YU9yWTh6b1k5SlUyQnVSRjBvdjlj?=
 =?utf-8?B?QkpHeTNEV0c0RzIxekVGTFN3SVhLelhmK000WkJhcGxyZEdGdXFyTHgyWmc3?=
 =?utf-8?B?Z2E0dEFlNzQ4d1pZRFRHbFUxaWdVVEwrRlFqOGtrM1ZESGhYNXBJMEoxSWRF?=
 =?utf-8?B?WG1va3lYdkVDL0NOQ3M5Y0I5T2o2UFM1aERoQmxnZGhCUFBRS1Q1U1VHQkpz?=
 =?utf-8?B?YW5xMXROUXZQaW1WTVk2VE1Ed0dUWjZXRVdZMnZXYWE4OXRJd21Ba0xkZ2FG?=
 =?utf-8?B?YlpaaGZCWGwyTUNld0xic3NDM2ErVmVOcllZZ0YrcnhiZHRaR3NGbE1majVh?=
 =?utf-8?B?RjRmUUtZSlZ3aW4yaXFDbVZlbWRpZXAvUnhyQjJTZnRFZy9TZHpwLzJQRU9M?=
 =?utf-8?B?c25OQmdVQmdpTVhPaGc3ODgwSnZOQ0JjaG10Z2VsYjlpWCtkODJIelJSTkNG?=
 =?utf-8?B?U2ZlVVoyRHdtY3FjSlRsQmduc2ZnVHBlN3JacUZ1M1E3d0daMGYzUUV1bGo2?=
 =?utf-8?B?UUtpMFgrdVhPYVpGSnhTeWhyRXg1MlBXdHhRajNNUExzNzdHVDZWZjRNNG5w?=
 =?utf-8?B?SXMzMlpoZmJnMGlTNDE5Tm9ja2dVelRQTG4yWU4wTFIzaWJFSjBRTXNBMnJz?=
 =?utf-8?B?dGtReXFuK01oVXlXOHJLRlUvQVRKK3RRQ09pYVp0RlQvSkVjUG12a3JOak03?=
 =?utf-8?B?WnB5R0FMYzdKZkRlTUV4VnFmMWNlNkRCMnZ0VlVCTis3a0pMVGxXaGZHVHcz?=
 =?utf-8?B?VFA0UGo0UHp0VUlUNUVTc0RMN0lUWWw2eUEvbVA2bkZOekU5SzNTbW9rZWlq?=
 =?utf-8?B?N0w5LzB4RkNNRE5YQm9NR1BVQnlLYXFmVWFiRmJPdG55Wm5WVnBsUU9vZit0?=
 =?utf-8?B?cjRjZGo2NWpiRm1xZ2I2SjZTbjg2OXpYbWxJdjMzeFVIcXNUVjd4bnduajZW?=
 =?utf-8?B?dWVUekl4YzhubkloNWNEN3BRZktMVkZYQ0VoU0pOQ1djL1h1K1RsTkVZblJz?=
 =?utf-8?B?K3lLZkJ2YSs4UVdRVHpPOFk0c0ZnMzYxY2M5UFhtejA5cjVyaHUwMFFSV0s2?=
 =?utf-8?B?TzcxSDU4MkpwS2JFdGlJb2RFK3B0NEJ3U2JpTk5oT2x5OVFpSDl3bXlxZUtS?=
 =?utf-8?B?RU5ubm1pRXR3WVlYV3J6SGxVWlJ4R05pekxIOXhETHJsY3FhWjJKbmgvbmJ1?=
 =?utf-8?B?TnEwY0ZPdFNia0JwQzlhQWZvTUJjWTMxZDB1MisvMFUvTk5tWlBwcDRZMUFl?=
 =?utf-8?B?TTRhdDRyNk1hbkZvN2I1UFpobHJuRXhGT3FtZGpwTkJ5WlU5ZVprZVVIemZ2?=
 =?utf-8?Q?ORvN75C5PiVfVlnFFdw6QQTekfikog/zTimuVQ3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUNaUGRkS2hkQ0ZYQ1JlNHpvS1JIWkkzWk1WL0s0UnhjSHlmK1IyMGFPVnZI?=
 =?utf-8?B?SjErWUovQzZ3bTljMkR1N3ZNNmF4cDRMWFc4aGp4cFNPL1JUc016OEpzODVR?=
 =?utf-8?B?YXpkdTk3NVhBRXZOd2VNdSs4YjNUWk4xczVyak9HWURML3VZQlVuTjhuV3dr?=
 =?utf-8?B?VC9BN2FZTGVkTDZHWDBwdkxORmpGYW4xTDNLTUQrZlJYQW1PSC9hT2JJUW5X?=
 =?utf-8?B?aCtmOGd2S2NzaUxhZE51VW81bHJtTDZVdlkxbUpMcHRFdkYxbkM0TFRHTjNt?=
 =?utf-8?B?aEs0N2NvdTVaUWJ3cU9xa2hhZFQwT0RaZm5zSW1NS2s1eXJMMS9HYXVPb0dY?=
 =?utf-8?B?YmxGM0hrRlFMYjZVUE9YRzU4NHhvSTF0WE5ZbVIvaEVZMFJRV1h6VUdvTWYv?=
 =?utf-8?B?TVY2Y1luayt1NjAwMlpHY1YraWJQakdqM1NzcGFOOGsweFpmQjhLREU5eDhr?=
 =?utf-8?B?eCtvR1d4cGRteEMvQ0tpZWpMZmFVUlRRRnhJYXhaQ05Ldlg4MHJ0U2dhUlFF?=
 =?utf-8?B?TnJ2N1ZWMkpSam9yeFdDK0t2KzdpSU41RCt2aXBKejRPbk1zTkhQaGhEcVg4?=
 =?utf-8?B?MWIzL3NDVXdiT0YwVFVuYUFoRUFuTFh5WS9pUVJvT1FCclBCN2JPbmVpZWFx?=
 =?utf-8?B?VUNtcERBVVAxRUhBZlllb0ZLc0FYaW9VWVpkMjEzY0Z2RzRhUTlrc1FvMklt?=
 =?utf-8?B?aVZLMTFuU0s0OW5nKzZLODhSbWo1QmUxcUJBUmsxTWh1Y3UvZ3VyVWpUQzBM?=
 =?utf-8?B?ZHNDS0RZc0xuRVVqVEl2MVVuUW5qbkExam1Kb1IwR1o4ek1qWkViZ0ZiYzA0?=
 =?utf-8?B?QjUyclp1Z2RnaWd2TDc4eWExQzF6aklPZzBwQW1RSWJPQ25FSkcwOEx3aWpo?=
 =?utf-8?B?OG5YMGtRbDlIRG5hOUwrK0RzQk04OW5pSEpDR1FrQ1ljeEZodGxjVDV4cW9i?=
 =?utf-8?B?Z3lMbzdIc2RlOFg4TE5XZEtXZThXVVBPZitlQ0R0eVZaRmlIZ01PN3VjWWRv?=
 =?utf-8?B?dEdxaFVqc1dXOGpYTHorcHJGYlA0Y3F4MXhTaENEZHB3bTRmaXNvT0NOV2l3?=
 =?utf-8?B?dnA4VDdnSUZUK0F1K1hndjQxdDh6WXNhb0ZRL0xqNGRJYk5pMkhCZWdYUGZM?=
 =?utf-8?B?VWZJVVNKaTNlcGs0YmtUdnhpa01FRTlWRkJLRENnN3ZqUG5xVjM3Q3E3MVY0?=
 =?utf-8?B?ak9MQnA1RkJrY1hWSHpveVFZVDhKVzVQZ1VqWEswOU51RDVZWmVHTmJBSyty?=
 =?utf-8?B?TUdwVFRxcU5LM1ZkYTBYN09INFVhNE9lTlVad09yR3VkeHprT0JhNnNsajR2?=
 =?utf-8?B?SnZsRnFWeE56blpRM2tzVGpuNHhwMFBwY0VId1FxZHhISEMzenE2b3c0ZXR4?=
 =?utf-8?B?Kys5aERDek5KZnRXK2pKeUgwL1U3Q2lEVVA0VHYrZFhJU1BvemdMaVhHVGcy?=
 =?utf-8?B?QnVLY1BPNUtwd0dwYUxQcVdzVWZBbVFJNzF0TkFlOG9yYWFxakg2SEZ0cGFm?=
 =?utf-8?B?Q0cySVNoTEhzaE1JM0JzMVVncDBZVkdDL0lFbHlpKzFaaFo1cFBJMlVQdUNl?=
 =?utf-8?B?RTlpNGxxWm01cmtPL08wWk5IcVpoeHRZU0xwTmxuY3liZmd3OXM3bWJONDNI?=
 =?utf-8?B?WkJtdVB0N0FwYjhTOGxCRTJsV1oxMkZYbUdMQ1k4WVJpZVYyNkV2YjlCYzFt?=
 =?utf-8?B?MzlXNWhGQTJ6SHFGZzhpYWZjRFZYZVNyRnpmbDRZRVZZcnBzSEM1Z3dmS2tR?=
 =?utf-8?B?TEUzR2hsNEE4dHphWlpySDY0UDM0S1djTER0NUZ4TjBySTNSRS9lemEza3Fz?=
 =?utf-8?B?d2VPOWIvNi9lNUdtTW9td01aT0NMOFRudi9Rdjd1M0E2eE1JNDlkR0xhdUR4?=
 =?utf-8?B?djBvQzdEUmwrMkhjaU1qYTdOeUFpbG5tNko0TkNvSXJQZEFpbVNyKzMxMXdS?=
 =?utf-8?B?ZDRmY0QxdTQ5QVp4eTF1YWdHZkZjYVhBaE9aQTl4RkdKUkhIck1ZaGIyWkxW?=
 =?utf-8?B?MHhoTUQ2TWFYSVZtYWNUNTZscm54Vkp2WGswR1VmK0U1clBrKytUMS92L0o1?=
 =?utf-8?B?ZnB0YUZUTmhacW5ia0w2MUp6T0U4czBORElIa1IzYk5jS0pMZnQ0TDVXQTd5?=
 =?utf-8?Q?fnKNmWSZRhrF3NDDGgEGnZUa1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f56a0f28-8cd1-46e6-a9bc-08dcfd622e78
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 06:22:11.1438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zD/3jNTvw0wb9dWbcu9lebFvU33YUK4sBWfg0GPS7iBO4pE3xfLu2j8SiORGsNieaqjchKJGf9nlrh6bNExIXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6826
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9; envelope-from=yi.l.liu@intel.com;
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

On 2024/11/5 14:03, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Tuesday, November 5, 2024 1:56 PM
>> Subject: Re: [PATCH v4 15/17] intel_iommu: Introduce a property x-fls for
>> scalable modern mode
>>
>> On 2024/11/5 11:11, Duan, Zhenzhong wrote:
>>
>>>>>>> +    DEFINE_PROP_BOOL("x-fls", IntelIOMMUState, scalable_modern,
>> FALSE),
>>>>>>>          DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState,
>> snoop_control,
>>>>>> false),
>>>>>>
>>>>>> a question: is there any requirement on the layout of this array? Should
>>>>>> new fields added in the end?
>>>>>
>>>>> Looked over the history, seems we didn't have an explicit rule in
>> vtd_properties.
>>>>> I put "x-fls" just under "x-scalable-mode" as stage-1 is a sub-feature of
>> scalable
>>>> mode.
>>>>> Let me know if you have preference to add in the end.
>>>>
>>>> I don't have a preference for now as long as it does not break any
>>>> functionality. BTW. Will x-flt or x-flts better?
>>>
>>> So first level support(fls) vs. first level translation(flt) or first level translation
>> support(flts),
>>> looks same for me, but I can change to x-flt or x-flts if you prefer.
>>
>> x-flts looks better as it suits more how spec tells it (FSTS in the eap
>> register). :)
> 
> Got it, just double confirm you prefer x-flts, not x-fsts?

x-flts as most of the code use flt instead of fst.

-- 
Regards,
Yi Liu

