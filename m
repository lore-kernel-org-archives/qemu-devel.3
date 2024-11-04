Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522CED1119C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 02:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7n6f-0002uT-34; Sun, 03 Nov 2024 21:46:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7n6V-0002m2-QZ
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 21:46:07 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7n6T-0000XH-LD
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 21:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730688366; x=1762224366;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1Y4MlW46qt4vDofGTCZ0bgoPL4SbtDZCcpn50BUEmXE=;
 b=EeD+qGXBL8jHV5c68U4NmIYseDzPA7gzLqdrrwVmTJZ2FNMnYWdLYN3V
 l8xwwoIIE9u62c44n1Z1ravG64bwzG0s+FsLNPLO4yHQyh2MQm8eSZiSl
 MmRPF0XFnvgtDCRZCFSSmEA4QEnxO8enEornJ+AFCPs7/1pCAYPxe9bXU
 3U8eDGjjHtIBZMvjHBRUtCkthRaXN0mxEezUy/oZA5U2TllLfxG6NInOD
 nqHwMDqRcQ45BJpzqJBKO6zkfQOKCILypIGXkj3HxxBCfgYBuAyhvQE8u
 rpPYZv9wuATp6037RY77r4a87KznOKUpC5TlcO84ZAxympmeS4ScCp9ls A==;
X-CSE-ConnectionGUID: FYkUvB2TSACacsk4XqqNgw==
X-CSE-MsgGUID: /DKtU7u5QGOv8d4O0mFQGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30225201"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30225201"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2024 18:46:03 -0800
X-CSE-ConnectionGUID: a6g9jAUSQbSwFmjH918dbQ==
X-CSE-MsgGUID: fNwX1aS9TsGOH6gb/7j6mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="88279810"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Nov 2024 18:46:03 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 18:46:02 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 18:46:02 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 18:46:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EyaRY0mOM2mtn0jl0L+nBVXxWAxX8tubylrXFJSTjgPRMm657NEQZbAxfkKhTo5yizbcMrsZciLSI8Xf9zSC1bfap0HF7ElrzVRI+01szT3wchAlrCKWYvfKJwbaxuMBdH3F7PgpNnZrU1vNKzN9n+YXpmo9IiZ+05CHiv/4tNNaBfJ/gxsOROHptyAIjFVSCF/AOoiphYJqEkoQnz9UoUm1VS0h/ypwTgwOWO/KSygJIKMCwjfYabM3a7W2XagrBMJ4/b2+/L+MH5VcJjytDiVA6upNZ1kB012m+79+kielMT8+KPXrqccLA3z4qvHhyBzphHP4t4l77nLbgKEpTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vc2JCPiLzxaMyqe7RsdgmxQZT8YO/AL6s+SUfx39yRo=;
 b=cnwkezpSuHVS/dBQ38ndvvVCxzKVf6EWIyuGePZMj9Hnn18iexrcPB8dV6+xBSukC9pVUKGrSAYEB+O+bMFMPUgKT+GrlYJgWd5Dr7Ft4I45oe+DeHG+fu9kIYZgiBlfu1bdkpf0FdPZmC/24WloFXmaKFAkce3FePdgzBwQ/vM/tOVv8yMV4H+KaIi3VIbFsmcuti6sqcmWfT2P0eNA1Rwd0bz3qK5Q7xMV38/UWFXDVIy45gfgbxB5ILlx1bj/OOtR2vV2GcXo7O/WY6oEbBy0QHCDB5vKKwQbxAWGOOoEZVQarTJoLc8k6NhKsEf0Cfmq3p/ObaNJP/J9LyqN9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB5070.namprd11.prod.outlook.com (2603:10b6:a03:2d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 02:46:00 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 02:46:00 +0000
Message-ID: <39a88bac-ce24-49d5-a6e8-9553a48983a8@intel.com>
Date: Mon, 4 Nov 2024 10:50:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/17] intel_iommu: Flush stage-1 cache in iotlb
 invalidation
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-10-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240930092631.2997543-10-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0208.apcprd06.prod.outlook.com
 (2603:1096:4:68::16) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB5070:EE_
X-MS-Office365-Filtering-Correlation-Id: 52f86d85-fc11-4751-669b-08dcfc7ad0ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjBxckVyblZ1L1BVTGg4b3d0MjErTUpyTUFoNzFETXRBYnVEQjlxU0dlU2Qz?=
 =?utf-8?B?TTdDelVhMEh0OGtVcWYwQzIrcGxRMU1ydnpQNFNrZUNUWnYzTmtzOEljcEJu?=
 =?utf-8?B?ekNjaVNVWDlyMFVyUERLSldLd2NSelVxQzRoaXdIMFRFOWFBMXdOZXlrUitp?=
 =?utf-8?B?MlNKaW9jb0UvQUUyZEsyanBWM3ZIWnlqelhrVUNpeSs4c1Q1N1ZkSlJpczJU?=
 =?utf-8?B?dThvNUQ2OXBIRG1MQkd2MlorL3NFdVo2bkRuR2RwS2tuanJ0dFdzaGJsd3Rq?=
 =?utf-8?B?S1RKeHEwU2htT2FqaVpqOEdmQUk1YUYzMUhoUW5sbGNqTUhCMVZ0RlF6Mmk1?=
 =?utf-8?B?YU5uUGsrM2tTTGVGNE1oNVFiMHJmVk5zQUhPSUdJR3h3SVJBZm16K3ZnM3Bn?=
 =?utf-8?B?ZmFrVmE5Rll5SHNyUVQ0c3BUWnh6ZWdXUEZXWkNPQ0xzN2xPM2Mra3VaUXEw?=
 =?utf-8?B?UDhES2tYd1MyUkZ5emhZNkpqa1RQTUlRWDVUVUJkMWdWSUkydFdXeFBQcitH?=
 =?utf-8?B?WWYrVUtSbm5xenNIL3BKRitoRS9xOUI4OVBWbHRzZTVFYXovVWloQmIwVHo4?=
 =?utf-8?B?M2l1aWk5THpMMVRDUjVmcmxYTmpFbEw3S245TUlRR2NhaHRKNEJGeUNMWVh5?=
 =?utf-8?B?aWhrQkNxMUY5bkRZd2Z0QVN2TXkwWjR6TVJ0MldIbjRWRlZHSEdMMzZpamFk?=
 =?utf-8?B?VHBxVFd4NTZOeS95bTBZUlVjcitTTDJ4Qlo5cEhscnJVUUZrQTlvU1ptNVln?=
 =?utf-8?B?UUhmYWhVZ0ZjZ0JKZmFXRXVtaFZhR01YcWhrS3RqZ0VMajFwU0lMMktzSzlz?=
 =?utf-8?B?YUJUQVlQc0F1dUd0S0dSOVpndGtDUEZJZmxxRmZRT09Ja1RmMDZRQXNkQXlG?=
 =?utf-8?B?UFNpV0x6YnFncTJIWkVkWUNSaFEybmxsWkFzZjZYZ0RlVUpJZWgwRWlzRWNM?=
 =?utf-8?B?bk9ub2pJU2VLMlhJZDFSNWxsRlZJaWVVR1h3SDZnKzM3NGFnUE55UDdtZFF3?=
 =?utf-8?B?Y2VxVnZvUTZTNUN0VEZ5dzVidnlDQTJ0UU1lZmxlRVl5QjJkamFkZDBuWXBq?=
 =?utf-8?B?cHFzeGlhcGZrazBHaERvbDF3QmxsMlBIWUhJdnpLQk1HN2NsQVlrTTlQSWFz?=
 =?utf-8?B?Ykdwc0d0c2RxRXUyWFF3NVlVVTFBQkJCZWI5RzlONUJDNGFJS2FCK3h0SGJm?=
 =?utf-8?B?R1JHZWFYeitEZEVnT2pQUWVNN2JneFhIQ0IzK3h6aG9zR0diQkkzQVFsMmpP?=
 =?utf-8?B?bFZxQjJibHVhVXdOaTZ0NXZGa3VYVDFUWHBQeklGSlFTV0ZzemxiRzFVTlFO?=
 =?utf-8?B?VFFXYVFYZVpuL2tNbVl2K2pKQllHWGR5ekp6OGt1TjdiT2RmN21yRXRwNk5I?=
 =?utf-8?B?d3JNekI1em5WUW81OWZuRmp6MmFUMlcwNmxUQXBRZWFYdnE1amJPdGxYbHZq?=
 =?utf-8?B?enQxUkkyMVRUeTdza0lKSFZ5SjVGdDVReVMxeEE4bytrZUZoU2llcVBYclRZ?=
 =?utf-8?B?OFlwYjdFRmNEaXlNWnZrYTVxRE81cFYwZ0todHhvZnptMDc1UXhGbGgrdHZx?=
 =?utf-8?B?eUlVNHpSN3RpNW5yaVdKdWtxUTBJSzN6bFEzeDM0bE9NclN2aDl5WHEwdElx?=
 =?utf-8?B?TnJ6WnMyK2Q1bm5kUFJxRGNHY2JVMyt0OXZHRW1NZkdIU3ZpLzE2NWJyck8z?=
 =?utf-8?B?eFU5ZmZZS0ZQcnd1MWVHalljeWJhWkZ1V3dSWGFFWjFiTHZUNXhhU0ZpTXVx?=
 =?utf-8?Q?U6gYsXmmy4nhdxhlWs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXBJVWROY2dxSmlEMTZRQWx0T3pNeXNXOTBvT0Z3Y1hmUTFpWEpCSlJGVmw5?=
 =?utf-8?B?Y09Fa1VJUENzZlNuelBVRGhSRFJCQlZXOFl2YW9tblRZU044MEhDQVk4c2xk?=
 =?utf-8?B?YTJwcTVYRlhVdnAvR1pYb2dadjNsdUlFVUxzYkY5SVVDSEdmWDlQd2V6eGZM?=
 =?utf-8?B?TmRIMlhzK2FyS0RSVGpyQi9VV0RVdzRlaUY3anY2eER5Y3IzQmFUM0taQWl2?=
 =?utf-8?B?RXVScnBBZ1lMYzk0dDdvVXR4d0lFbXRvQVNZK0x6K0pZMGhLeHJTL0xQcWoz?=
 =?utf-8?B?djZFMFBtVGllYmEzQS9id05pOGxEVkREbi9EOTJqWk1KeC8zTndZNnZnb3pu?=
 =?utf-8?B?K1hlUzVnTWYycmhrUXlOZzBHSXdOaFJLZkNXSGZxc1JCWk5Zbms2V2Q4L1VU?=
 =?utf-8?B?L2FsOEpPUFJhMUN4OXlzVlFLNVptWkYwcGxBbktxZWlMQ0RQTVhnbU83ZnVo?=
 =?utf-8?B?SzRKOHpKdUluNmhTMUdhZzBNYzVGeUtGMi9Ubm1GL05xc1B3Mm12bjQvdWUr?=
 =?utf-8?B?L2xORGMzd3RhdTdnQ2FUSlFHQjZndFoxak1NMTFJVmV6bkJzb2ZwQ0d5TzhI?=
 =?utf-8?B?eFdYVm9rZGM2NzdBOGxXMGVNMWpLTTJFQmlNTDF1Qkx2eVVTdUhWZEt1b0V5?=
 =?utf-8?B?NkRtRjIzRk9jMVJmYjkvS0pXMnA4SnlhQUR4Q3dPZ0VWajhNRVhhTWVMLzla?=
 =?utf-8?B?TGlDT2REREJTL1c3YnYzT2NPdnpjY2FMQlRpN1FnSXdYdGJhUDZ3aXdBUkYz?=
 =?utf-8?B?ZGdmMWxWZHdSYjlqSE9BOXJjSDVGNk9xcVdpSnlMTzhrbFNZT3U4UUw3cnha?=
 =?utf-8?B?clFQSGJuZWdDdWlNeEtyZnpOeWZySk9OYUtGbXNhaFNndHNDaGF1bXMyaGVp?=
 =?utf-8?B?Vm9LaWdrMUJOZEJUbTRBRit1NWRaNWtGQ3JsenBFbXIybzVsWkgvVGNlK2pU?=
 =?utf-8?B?KzZHb2hNU0NzUVZ2QjhPc2FwcTNGNzJLT3VNaE40U3Ztd2RqeGswRW1LaGFq?=
 =?utf-8?B?SkE2Mk5mc3hYVmRhVUtJR0JOYTRkRFQvM2pvM0ZJdDlvWlhmUThyNUZvKzNh?=
 =?utf-8?B?STYzUUJpZGJ3TjhBR2VwOFBic0JLejYwYkpxTCtyd2FHb2Z1WUlzLzFhUzJn?=
 =?utf-8?B?d0xMZ2lHbFFrNHowOEVGNUliTjZBeGVjMDhSTk54bFFpaERUdWRtNXAwVjhj?=
 =?utf-8?B?RHZOUzJnQXViM0tVdWljZzh2ZHFUNWVPdXMwZmo2Z1ZtZGttVFQrU3RsVG56?=
 =?utf-8?B?cXpCaDVUT0w2bERoOFF1aitqZjRhelJoWDhyUk5xaUdjdlRzckFOWGVKbUpx?=
 =?utf-8?B?R0F3VkNKT2JwL1J0U1A4U2FNT3VjLzY2SE1BbXBuU1dRVStxZmdoMnZPNmdW?=
 =?utf-8?B?NCt4UlNaNGdsT1JKS2VYVHFjUW1UNlI2Tk5ieWEwRmt4NWEvYmVyZzZERHZC?=
 =?utf-8?B?YlhhdVlNWmxxN1F3eUNTb0xnRW0xTHBUWFVEb3dZZGJialZFVWZ5KzRubDQ3?=
 =?utf-8?B?NWxRM0JaL1Y5Si9tQ3ROY3lTOGFqaStFQnJCUWxFVmkyT2tPOExSZmZCbXNI?=
 =?utf-8?B?L3o1bnBURko0RkZUbUxhQnBiQ21RNWhuYzZ4VVQwVmx6SW84S0FLRnkvV3Mx?=
 =?utf-8?B?WkdnMmZ4SEREQ2l6SThNNmFsUGlESldyVS9KQW1SMW1NVk4zVkRncHNZam0y?=
 =?utf-8?B?RUh2bWxreUdudUlzQ1lTa1A1blAvdjRFUzBiMjJUK0JVTjdrSEpKZU56UFdW?=
 =?utf-8?B?VW5NL3hsWjJ0ejBPSXJFSHJWYkdVTEtHbEoyVXpxb1FhTDFsR2NDeHJJbGpU?=
 =?utf-8?B?VXlzYThROUVhWGRVeGpCeUg1UDkzK2sxNkVIck0zd3hLcWhMYWpiV2E4anpY?=
 =?utf-8?B?SGtmRHNUQS92Mmc3a2crTHlvTmZBV3FvSEl0R04zV2ZWZThhdjVRRERuczNk?=
 =?utf-8?B?U3lnL1VCdFF3d05MUzhvWUJjRml1RENJNDJtRWozY1pSc2FzMnB0QWhxSmUy?=
 =?utf-8?B?UW13cy95MU0vV3pRT2VVaE1oc2p1M091eDR0aFhvcEdET1k3R3F2OHlFTHdk?=
 =?utf-8?B?RExvTjJ1aHprOExOYk9GTWl0YVRhdmVMTlk2RUo0VUtudkhqNXQ1NVdOa1Ir?=
 =?utf-8?Q?SWNiR3D6iL3qFSkuNdTszVfDj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f86d85-fc11-4751-669b-08dcfc7ad0ac
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 02:46:00.0414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEZfN3t6edERo29KYaRhlruR6Y6oIBL6BFXH+slCd9EZVnqu9/ndfYlXOrRLdbmbYaH+IdQpCByhL83+RVMCPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5070
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19; envelope-from=yi.l.liu@intel.com;
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
> According to spec, Page-Selective-within-Domain Invalidation (11b):
> 
> 1. IOTLB entries caching second-stage mappings (PGTT=010b) or pass-through
> (PGTT=100b) mappings associated with the specified domain-id and the
> input-address range are invalidated.
> 2. IOTLB entries caching first-stage (PGTT=001b) or nested (PGTT=011b)
> mapping associated with specified domain-id are invalidated.
> 
> So per spec definition the Page-Selective-within-Domain Invalidation
> needs to flush first stage and nested cached IOTLB enties as well.
> 
> We don't support nested yet and pass-through mapping is never cached,
> so what in iotlb cache are only first-stage and second-stage mappings.

a side question, how about cache paging structure?

> Add a tag pgtt in VTDIOTLBEntry to mark PGTT type of the mapping and
> invalidate entries based on PGTT type.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>   include/hw/i386/intel_iommu.h |  1 +
>   hw/i386/intel_iommu.c         | 27 +++++++++++++++++++++------
>   2 files changed, 22 insertions(+), 6 deletions(-)

anyhow, this patch looks good to me.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index fe9057c50d..b843d069cc 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -155,6 +155,7 @@ struct VTDIOTLBEntry {
>       uint64_t pte;
>       uint64_t mask;
>       uint8_t access_flags;
> +    uint8_t pgtt;
>   };
>   
>   /* VT-d Source-ID Qualifier types */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 99bb3f42ea..46bde1ad40 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -305,9 +305,21 @@ static gboolean vtd_hash_remove_by_page(gpointer key, gpointer value,
>       VTDIOTLBPageInvInfo *info = (VTDIOTLBPageInvInfo *)user_data;
>       uint64_t gfn = (info->addr >> VTD_PAGE_SHIFT_4K) & info->mask;
>       uint64_t gfn_tlb = (info->addr & entry->mask) >> VTD_PAGE_SHIFT_4K;
> -    return (entry->domain_id == info->domain_id) &&
> -            (((entry->gfn & info->mask) == gfn) ||
> -             (entry->gfn == gfn_tlb));
> +
> +    if (entry->domain_id != info->domain_id) {
> +        return false;
> +    }
> +
> +    /*
> +     * According to spec, IOTLB entries caching first-stage (PGTT=001b) or
> +     * nested (PGTT=011b) mapping associated with specified domain-id are
> +     * invalidated. Nested isn't supported yet, so only need to check 001b.
> +     */
> +    if (entry->pgtt == VTD_SM_PASID_ENTRY_FLT) {
> +        return true;
> +    }
> +
> +    return (entry->gfn & info->mask) == gfn || entry->gfn == gfn_tlb;
>   }
>   
>   /* Reset all the gen of VTDAddressSpace to zero and set the gen of
> @@ -382,7 +394,7 @@ out:
>   static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
>                                uint16_t domain_id, hwaddr addr, uint64_t pte,
>                                uint8_t access_flags, uint32_t level,
> -                             uint32_t pasid)
> +                             uint32_t pasid, uint8_t pgtt)
>   {
>       VTDIOTLBEntry *entry = g_malloc(sizeof(*entry));
>       struct vtd_iotlb_key *key = g_malloc(sizeof(*key));
> @@ -400,6 +412,7 @@ static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
>       entry->access_flags = access_flags;
>       entry->mask = vtd_pt_level_page_mask(level);
>       entry->pasid = pasid;
> +    entry->pgtt = pgtt;
>   
>       key->gfn = gfn;
>       key->sid = source_id;
> @@ -2069,7 +2082,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>       bool is_fpd_set = false;
>       bool reads = true;
>       bool writes = true;
> -    uint8_t access_flags;
> +    uint8_t access_flags, pgtt;
>       bool rid2pasid = (pasid == PCI_NO_PASID) && s->root_scalable;
>       VTDIOTLBEntry *iotlb_entry;
>   
> @@ -2177,9 +2190,11 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>       if (s->scalable_modern && s->root_scalable) {
>           ret_fr = vtd_iova_to_flpte(s, &ce, addr, is_write, &pte, &level,
>                                      &reads, &writes, s->aw_bits, pasid);
> +        pgtt = VTD_SM_PASID_ENTRY_FLT;
>       } else {
>           ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &pte, &level,
>                                      &reads, &writes, s->aw_bits, pasid);
> +        pgtt = VTD_SM_PASID_ENTRY_SLT;
>       }
>       if (ret_fr) {
>           vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
> @@ -2190,7 +2205,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>       page_mask = vtd_pt_level_page_mask(level);
>       access_flags = IOMMU_ACCESS_FLAG(reads, writes);
>       vtd_update_iotlb(s, source_id, vtd_get_domain_id(s, &ce, pasid),
> -                     addr, pte, access_flags, level, pasid);
> +                     addr, pte, access_flags, level, pasid, pgtt);
>   out:
>       vtd_iommu_unlock(s);
>       entry->iova = addr & page_mask;

-- 
Regards,
Yi Liu

