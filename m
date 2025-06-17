Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48354C7114A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 06:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRQHT-0007q0-Dw; Tue, 17 Jun 2025 02:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uRQHQ-0007pj-UJ
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 02:58:49 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uRQHG-0006UA-Rn
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 02:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750143519; x=1781679519;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SWSQNLIEnzSS7xDWHQilRkx1V/in7WMi/qSzgmouJ6k=;
 b=kMhpAr2BeFP2naIQAEYlxEufKY+Wi+v2etUwxk3o/WtvDeXp0inFswQs
 8nn6zUZxSDc4kWnAGZrLs1LixlIu9JlgMkzyXQkUgzekxzZr6yiy2u6eB
 dbGgUAPWUVgSxp44LZihjl8Xe63Q/RdhTpxsn1XrE5BXYlyTkM8mtyf51
 ucFnbrLF78/KkMgIhUk8Cz+47dmp1CRTRNRXAPraEbhuthtgiRQrO3mS2
 inhUoW/uRK6oGI0eiXMhcOPqc8M+j3WcOthg8cmj9W8yd/Fqv+PC8H8VI
 OjNS38TWKoXlLjuE4X0wAoGwLmlZRbt2c3ZHjEfyr2pjzLLrWKcbUflSV g==;
X-CSE-ConnectionGUID: OsirUbzKRmaSndVbVPqkxA==
X-CSE-MsgGUID: aQx/5vvlR6CM/Pen8JtvQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="74837825"
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="74837825"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 23:58:35 -0700
X-CSE-ConnectionGUID: fL29322bTPSDo3tczs/uDA==
X-CSE-MsgGUID: q2cp6EaCQBq9DFWB+8o/8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="148526469"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 23:58:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 23:58:33 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 23:58:33 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.81)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 23:58:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPPjWmpgE4lhDBGivne1UerOZQ90buPVBOzmFz5nFameMRlN64c6QyCWmlLEqRo19HoIICqfw6zv/mljgKHOpx9V/Ys7dkHAAbZO02mt6bY4LbMeb2EkuFRU9JSP0QIMfcG5SrRCD6EJ+kbJWXTnMu/p6OjaglD83hd9j9yDJBPrZqnpibzVOBoMROEzd52NWZfH7JqvE6m6vp00DFAjqQUHXBrLFr5RqpPaZSwQFLQHZqsW7yE4EkWYuGcU1QjF+1gRbFKkTpq8GJhkc4OMNnUZDJ+Rfdf3RBgwJGiHQP0tOSppvdHGJu9ENkPeJwUx4N/mzNAfBte5VUx3i0+lUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mnaKzLb7PmusJUKmHXlx/feUgr7A9W//h27RMjkrN8=;
 b=JJVw8nJs94xRH2dWv64l/38WRYbu7NCT/BNnEN1WPGRN3Quu2Ah31vUIKlhwMb4jt+2oOJmAgxTXfNG1frKuL/YTBiBjv/dxDDukm7k92OJIaKERm/Diw3zAYbUcvazE/9B5QwrrXUPqvgEQ/G8p9R0HwINQM5q0oumXhSOVq3op046/A9ZXmx8IbrLUAcrK8f/f/I4qb+jl4fUsZis1HRYIt5qTVcMvkLdWGyqZWKzImOOkFWOSUpQCDt0nOeYsvwwABrL+ydFl4LcATYQB8H1uA6tnj2AZ95OB9ug11PytqJXOS1zGKAg+ml7e+8ZdQcs1FPPpOtd+7OeTTBUQbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MN2PR11MB4663.namprd11.prod.outlook.com (2603:10b6:208:26f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 17 Jun
 2025 06:58:24 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%7]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 06:58:23 +0000
Message-ID: <7dac9a3f-8176-4f17-8f8d-61594bce1653@intel.com>
Date: Tue, 17 Jun 2025 15:04:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, Nicolin Chen
 <nicolinc@nvidia.com>
CC: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-16-zhenzhong.duan@intel.com>
 <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
 <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
 <aDDk1NYwJXaAdUQI@Asurada-Nvidia>
 <29f5f434-1fe3-4b5e-91d1-f153e1e98602@intel.com>
 <aDSmcvZ08jNOSr05@Asurada-Nvidia>
 <SJ0PR11MB6744340B889FF65D3BD5B8459267A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <f6baaea1-a60c-41dc-a9a8-d2389ed14679@intel.com>
 <IA3PR11MB91365922FBD407DD25E382C39270A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aE+68E03aAXEynBd@nvidia.com>
 <IA3PR11MB91362B306AA38B1180E3FC5A9270A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <ca05ae62-d946-41d8-bd77-60be67a246cc@intel.com>
 <IA3PR11MB91363EF9EE3E6E4EB69FE4769270A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB91363EF9EE3E6E4EB69FE4769270A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:196::23) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MN2PR11MB4663:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a25766b-8c4c-492b-e26e-08ddad6c5a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjVRbzVuSlgvcGtsK0VkWjErcDFHS1FhbC9kOVJONUNjbU9WcExVZzMzR091?=
 =?utf-8?B?emJUbkJ5SWZUd2F2cC84d0dueW8zK0lUMjQ0cXJreUIzYWExVHhHZXg1WFJ6?=
 =?utf-8?B?T1lheDRPVmkyRlFyekQrcmgxSVhBekpYSGFIcm13UWgvRVVNK1ZseTFXeU9j?=
 =?utf-8?B?T01wbzNtMFFGQ2gxNHhES0N6WmptWmFvTFl3NElEblhUVmgwRzNVK3hsc0Qx?=
 =?utf-8?B?QjU2ZjZRNHhrWEhvL0VYNE5YeFlLTmtjWUg4WExwTXdIRkswRWpxUGlHNkIr?=
 =?utf-8?B?L1pIaHdDTU1sSHpVSlIrVENWTVJuNXBPRFR3WTdWSGhIYmY0Qk5KSmNtOSt1?=
 =?utf-8?B?QVdWRDF0My9MWDBVZWVJTThkcEJtblRYVVdEK09PQ3BwSjZndXhrTlJxWW1w?=
 =?utf-8?B?eXN0M1U3dlJoVGZPanlvZkt1SDZJOCtmRUx2cVFKakNNbDJLNHJ1NlU0TE5D?=
 =?utf-8?B?NS8zWUtpNGNIWWxCbmFvNHVEQmkyWHBkZHdkb1h6UnFYYmpFcVFFRXlVeCtM?=
 =?utf-8?B?dXJDTXZBWkJaSzE0OGlIZG93V1FXY2FUdUFZYUJnZDRMdWJ1V2tXc3dkTGRl?=
 =?utf-8?B?L3pKc1VMMHJwOGxmeVM4UnU1Z3pYVzhBWW1TV1FWTFBObzNpc3gzaWFqR0ho?=
 =?utf-8?B?L09BWUI2WHN6UCtrK3o5NEM3TXBGOHhNTEhYRWgvSDZ2WXgzMlRoekwwWTNC?=
 =?utf-8?B?R2dEUXQ4RjFwWVpuZzc1VSswSTJCOVpmeGI4UHkxYWJ1SVFRNEtuZkpiQ0pP?=
 =?utf-8?B?dmlKSTJKT0I1dmtRMjl4Qi8rVlJiWUdmR3phSmlWN2ZRdi9nMklpZ2RMSndI?=
 =?utf-8?B?UTdRd1lxb2hrdjdiTmtBTkV0djNodldCSmFIUUhFeGtKTFFHR3YvdktzWnJD?=
 =?utf-8?B?YWFBczJHN2FqRGY3MmY2LzVlZ3FKK292QU9GY2dpdHpSekZkRmZZR20vbWtY?=
 =?utf-8?B?ZXBQYlVodno4OExyMFd4a2lXeFRoVm15REs3eWlwN2JtY0ZnalNWWWRHUnV4?=
 =?utf-8?B?R25rQkxCbVpUQzhmanhwSmpJNU1ZQnlUaFZHU044Q1BvQk0zMjZjcm9Hc2My?=
 =?utf-8?B?aUUyRnE5bm9VaWlib3RMZDBLWmtGMWg3TXowSVVNOUJ6K2pxcnNjVFRrV3k4?=
 =?utf-8?B?WkY1QmYyOTBOUE5uTHJPaTNWY2NscGdyZXhpY0xSeWk3eVFhNDllUjZOU3lY?=
 =?utf-8?B?c3lPU05IMWh4eGtvN3kwa0VNV0xsdXZMMHdRTGl1eDZwUnFFWStzZlJoVGJ1?=
 =?utf-8?B?RHIralUvNVVwcXNPN1RMN2grMzdYSERGQnB2aldjVFAyTUxyTHdkNnRSUUVz?=
 =?utf-8?B?ZTVKTU80SEkrYkVmWFRlejErTUw4ZTZnYWREd0JUc2o0UHhCN1hGaXNiUU9F?=
 =?utf-8?B?QjkrYVFSS0RveU1pZVZUSkR0ZVZnR2xxQ0t6OTJabWVUVE5qdmhBR2U4RC9B?=
 =?utf-8?B?bjZDZnhkRzd2eEE4QU56NUpmckc4RjBuSWhEaFI5YXZnMFFGYUFETDdJVFB5?=
 =?utf-8?B?NjM3YUFnWFhjK3FwMXVmUE83SnhKV0pCTXJkWHkxRGdLNTMrSk1RTzFWbEZW?=
 =?utf-8?B?MzFlU2pra1dZamxSK3l1N1VBbjNRd2QzQithRzVvdUlYUlhmcitNK0FWUHE1?=
 =?utf-8?B?aDErMlA3TGdFNlIwaHpYQlJmRGFtazk4NHlDZEQvR1B6SVNzR0UxSXNieEZi?=
 =?utf-8?B?cGJJZ0JpWWE2ejRCR2NNRFpUb2JvNHBTQXZsVDJYRGV6Y0hCT3hjOHpjb2FS?=
 =?utf-8?B?R3lONlhCUHBNdlArcTlUS3gwRU9jVFVBMFV4WkVybkJhcDlxbXRlbzlOakRZ?=
 =?utf-8?B?RVdDYmxOMnNZR21WKzJ2cnRtaUpjZFgybFlQblZqbmlMaFJ1dHlzN1dFSWZC?=
 =?utf-8?B?SkdUZzBOVjFSZngzRXhwMStkR3JLT0tkSURQSHdWV2YwM1BGcWcxS1dxTDZB?=
 =?utf-8?Q?+VbihI3/SYQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3Ztd1J5dDdtclpGMldkNzVHWFY4dWwvTS8ydy9MMW85VVBrQVJ3SXRrbWJF?=
 =?utf-8?B?SmhIRGhMM2d1UzVQNkUvSnc4ZEhUbkIyWTZSeVIxOHJnbExyNmRMZ0ZVN2pI?=
 =?utf-8?B?MlIrNFdZdktuWDc4MGFUUyt0cUxxWis4SmtEUE9ad1VXbkU0NTZOdGJ6VDdY?=
 =?utf-8?B?TGtsWHU4Qll3NUFjUTdFSWxuUjhBb0x0K01pTDIxRUNGcGxLaE9YUmZ6OVVr?=
 =?utf-8?B?K3M4RXlVNytaeXRyT1JDcWh0azZSbUhqWUw3V3FySzlhQ25zTEp5R2UwNGN4?=
 =?utf-8?B?M1luY3hPV2crb0RwblIzZ2tlbEdvY0h5eEFBYzJXQXJoQXMvRmVZZS9PTW1r?=
 =?utf-8?B?L3cvQlNzSkM4NDVHd3EvMlh3S3R1bmx2RlJwd2drOVIyRGZsSGFJb2xBOVYv?=
 =?utf-8?B?b1FITnFRWDZYbEJKbjBDS3hFVmlOd0hWWTMyVUlNODZPU2FDSXZtaVlEMkZI?=
 =?utf-8?B?R0VpejJiS2U3S1BXWDQ0Y0REVVRLK0JOYlpKSnVNaDNxelJ5OGRqL0NXbEty?=
 =?utf-8?B?TFdDRnN0alFmVjM2YkhVYi9QSXRWZk10dEp0RDRFN2NETHkxKzAvN3VuVHlW?=
 =?utf-8?B?MUlldW83cG10VUxCellPOWY3Ujh0ZnJ6NkwwYSs0eDJESDFtdEE4SG5GSUhL?=
 =?utf-8?B?VU1hMDA0UTBWWGlGTmJ0NHRZemphNGZsaGNMTVczV21sVjRTZnd5RHFwc1gx?=
 =?utf-8?B?ZmJCYWxIWGJnbkJ6ekc1MzdmT3cvUmZ6dXNjVUxtQkRmQ0htUlZuRTk4cSts?=
 =?utf-8?B?cHdjM0M1UFpENDN3TEVORzRyWURRRWJUVnhxY2t2YnJIenBkQ2p2R011VUlW?=
 =?utf-8?B?Tk5MTVJudWhVUTlFTTFEK3NtUHJIVXJManBOcjU4YkxzNFFPeVNRcWowT2ov?=
 =?utf-8?B?dE15OW5lZ0EvcS9maHEvUWloYkhOempwOTlKK1lVTy85V1BXMFJpSGV4aFRO?=
 =?utf-8?B?SUlVaVVReHdtNUhaUWliRk5oM2ljQUlsZ0FJK0Vmb1VSbkRDdHpXc1A5ZHMz?=
 =?utf-8?B?RE8zQ0VmcmJJOFFRc3RpNDhQY3Zpc3ZUamdNTW9mL3VCWkx0UHNDT1FNS2o0?=
 =?utf-8?B?S2xkUjFTTmJZYTY4SVZBNjFoUjVmd1NnYmx1RlJMNWVORFgzQjVrb29scnRy?=
 =?utf-8?B?L0JORU1KWHBBWE9rdHJYSU55amVrbnE2cXZINWZRWWxaYjBtMEtFdm1IczBF?=
 =?utf-8?B?RXJPNldkV2MxOGZFWVNDbkxFRjlPM1hheE9nOStBcU5ZaERCSm5kZXFmUm9o?=
 =?utf-8?B?VU5tbHdkVlFQQzYrcUZQTlN4M0h1SDhWSVlqVHo0V0szMlFlTHhzU0tGdXIz?=
 =?utf-8?B?VEtzS2t1bk9tOUFvRmZuaVpuanFoNXdMWjBpWjJ4Q2hNcnN2SG1yaWRuY2hR?=
 =?utf-8?B?c1hmUVhZM2IzNlVHalVhdkI0bGZXZzdzOTNNTnIxcE1vSW1NdU81Rit2NTJo?=
 =?utf-8?B?eVlodUQwSzZSN2pKT0ozMVlEWmNIV1JQeEFhVHUwbC91YjdwNGk2cytCOGZP?=
 =?utf-8?B?WkhaQVBrSyt3aXE5MkRsSnpreHlNcVI5ekZXbzBpaFNUWFdwMW9rRktQeFIr?=
 =?utf-8?B?Y0txUzdBLzhMcldsSEV6aS9WUEx5UW9vT1hTMXEzRWQzRTJQSDBIam1GMlRr?=
 =?utf-8?B?VzZGd081Y2Y5dnVBYXlBRHF4WEVPMzlxYVEvMmQ4ek9kVHZCdzVETURTQXRx?=
 =?utf-8?B?bFl1ajd4UGp3SG10WHJFc1FUc2hFRS9MKzBJaXlDT2xKYnRBdGpaWlNoeUgr?=
 =?utf-8?B?bktGNG9KK09oK1JJS015R1NwaDRBeW9jVnVmZGxPN2w0Q1llYUNQVVlDdlU0?=
 =?utf-8?B?Ly80N3JsTm5ZTFZXZXROTGp4YmJwZVN3SE96SEZrVEdDSUhpNFZ2b2xMdzdE?=
 =?utf-8?B?bjVuQWQ0QWYxOTJ2N0xTUEg0aEdUZXpaQmt3L1lTbjhnenpRUzR1Rm1zUldD?=
 =?utf-8?B?cW1WT3Z2UGJ3R2d4c1MvOW0vSjFCbXZVb29jbCttalFyL1kwNTlQVXZpL1hu?=
 =?utf-8?B?YnNrL0V1ZlpjYUxtbURvWVlvakZzMDVORkhPcm9CR1NiU0s5MEhTVU9pSU8r?=
 =?utf-8?B?N1FQQlBYREFyZUdzaXh0ekJhMWN3MzVXRTU4THZrUXNCMDNmSjJnYWlMTWJu?=
 =?utf-8?Q?rbzSk/12RELReujzpOY6aoJAd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a25766b-8c4c-492b-e26e-08ddad6c5a27
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 06:58:23.8431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UdONTp8reDB4pySYilVps56bX4hEVeNP61jV3avn3jWZi9SlJzPIZXb/f7vroiImDpzcdECiAg8oFKbdn3TQGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4663
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
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

On 2025/6/16 18:16, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
>> host
>>
>> On 2025/6/16 16:54, Duan, Zhenzhong wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>> Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table
>> to
>>>> host
>>>>
>>>> On Mon, Jun 16, 2025 at 03:24:06AM +0000, Duan, Zhenzhong wrote:
>>>>> Hi @Liu, Yi L @Nicolin Chen, for emulated/passthru devices
>>>>> behind the same pcie-pci bridge, I think of an idea, adding
>>>>> a new PCI callback:
>>>>>
>>>>> AddressSpace * (*get_address_space_extend)(PCIBus *bus,
>>>>> void *opaque, int devfn, bool accel_dev);
>>>>>
>>>>> which pass in real bus/devfn and a new param accel_dev which
>>>>> is true for vfio device.
>>>>
>>>> Just =y for all vfio (passthrough) devices?
>>>>
>>
>> TBH. It's a bit hacky to me in concept. It may be more cleaner to detect
>> and block such topology.
> 
> OK, then we don't need get_address_space_extend(). Will do in v2.
> 
>>
>> BTW. @Nic, I suppose nesting vSMMUv3 does not have this concern since
>> you will put the passthru devices under a separate vIOMMU which should
>> ensure that the emulated devices won't share AS with passthrough device.
>> right?
>>
>>>> ARM tentatively does this for get_address_space using Shameer's
>>>> trick to detect if the device is a passthrough VFIO one:
>>>>
>>>>      PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
>>>>      bool has_iommufd = !!object_property_find(OBJECT(pdev), "iommufd");
>>>>
>>>>      if (smmu->nested && ... && has_iommufd) {
>>>>          return &sdev->as_sysmem;
>>>>      }
>>>>
>>>> So, I guess "accel_dev" could be just:
>>>>      !!object_property_find(OBJECT(pdev), "iommufd")
>>>> ?
>>>
>>> You are right, we don't need param accel_dev. Below should work:
>>>
>>> object_dynamic_cast(OBJECT(hiod), TYPE_HOST_IOMMU_DEVICE_IOMMUFD)
>>>
>>>>
>>>>> Vtd implements this callback and return separate AS for vfio
>>>>> device if it's under an pcie-pci bridge and flts=on;
>>>>> otherwise it fallback to call .get_address_space(). This way
>>>>> emulated devices and passthru devices behind the same pcie-pci
>>>>> bridge can have different AS.
>>>>
>>>> Again, if "vfio-device" tag with "iommufd" property is enough to
>>>> identify devices to separate their address spaces, perhaps the
>>>> existing get_address_space is enough.
>>>
>>> We need get_address_space_extend() to pass real BDF.
>>> get_address_space pass group's BDF which made pci_find_device return wrong
>> device.
>>>
>>>>
>>>>> If above idea is acceptable, then only obstacle is ERRATA_772415,
>>>>> maybe we can let VFIO check this errata and bypass RO mapping from
>>>>> beginning?
>>>>
>>>> Yes. There can be some communication between vIOMMU and the VFIO
>>>> core.
>>>>
>>>>> Or we just block this VFIO device running with flts=on if
>>>>> ERRATA_772415 and suggesting running with flts=off?
>>>>
>>>> That sounds like a simpler solution, so long as nobody complains
>>>> about this limitation :)
>>>
>>> I plan to apply this simpler solution except there is objection, because
>>> I don't want to bring complexity to VFIO just for an Errata. I remember
>>> ERRATA_772415 exists only on old SPR, @Liu, Yi L can correct me if I'm wrong.
>>
>> hmmm. I'm fine to pass some info to vfio hence let vfio skip RO mappings.
>> Is there other info that VFIO needs to get from vIOMMU? Hope start adding
>> such mechanism with normal requirement. :)
> 
> I can think of ERRATA_772415 and NESTED capability. NESTED used for creating
> VFIO default HWPT in stage2 mode.

yeah. NESTED should be a hard requirement. VFIO should allocate hwpt with 
nested_parent flag.

-- 
Regards,
Yi Liu

