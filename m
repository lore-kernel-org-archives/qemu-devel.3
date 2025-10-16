Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE327CCD19A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 09:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9KZB-0000uy-H9; Thu, 16 Oct 2025 05:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v9KZ6-0000uP-FF
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 05:46:33 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v9KYz-0003fj-6R
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 05:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760607985; x=1792143985;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LjjTjeLQs/fm3xCGqBw2a+s02/J7OM/MFMQTzI3MVyo=;
 b=CuoEB1TSnKITyTm9TxQq30x4Hs1jpHVw8SxZjPuZW2geSjKXr9MUQsVi
 RvRUYHDdhZ1W7K5Xf8y3OEJlVS2lnelkZ/u+q4TH8YQ9804d57zIUVnoY
 0ZmdsIQRr/327a3r8BWohwUuMNvFGNiYoK4dFrOXB2lUf5gpk7+o2Q6f6
 58PI3jDRJizTcdsBiTU6XnyCbwAmCYhQhmUOTlMqS913K62h2nbLIS8ec
 qSbs3yZHFwIZTvgBQXnerQ0chuvUVmOW+ZB6h45FEB8PdJSJRYesVI+g8
 0DAB9fcsY/o1zeXHUbVVqYH2KONTKl1yEe/cyaSMC2w/fz7pQ4VV5PLoB A==;
X-CSE-ConnectionGUID: nCyBPoPMQEOVxq3F2GtMOw==
X-CSE-MsgGUID: tvjqXrLfQzKRyvbP41BwTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="66626343"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="66626343"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 02:46:21 -0700
X-CSE-ConnectionGUID: d8z3Tp7XTkSLz388ooIiJA==
X-CSE-MsgGUID: VUaI0dwTTP2vTDKCOAcHTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; d="scan'208";a="182396157"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 02:46:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 02:46:20 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 02:46:20 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.26) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 02:46:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCsK4j14TYQbQzyNggIBg+/zoDNhXeZ4lH5A1xodmmjo4EGkjFCzPBuVt67WmBTF+PSsf4tGVuhdKbOjQzlk/uoQMcfwZFdV0vj0pO227ITsPRfa7bqZwmCaMfTp+yi7XeqABgjY8+Y9SwjzgtDb3FkyvRPaN8mYxdhogyUBcmcPp0PDs+2a3cPF+dR+71kXEMVM1mcQrTO2Ybuye50MgH8IozztjyOR9BUVice5TgOa9chkd+nzuBDHVpdQ9Wl6HLEP3bJQ7mhGNCuP7KI5g1LaBmWD8bINtmus9Vp6zR1NJsfMMbAph42+4Tf70cV9Cwop8T5mxi9Qp0UrLMn8ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyQc9TwpcGf1J1w3xLsOSHg+fDAoCP7uPLvIh8/Ocl8=;
 b=sBWsbFJf2NPzQFB+shJgtHsS2d10Y6OMf9l1mOEopio8rbIDJHBG88sHRszf/K0HG2hqOGfED8aOP0paWmpAb5rlxHcmbgaT3knWNT6Kvr92OoubJ3zXd7Gt/3tIP+zp9/R8Qp80J4KbWYhr0BFI2QA5wdV9ph5tCJHCUtLPu1fHQ+w9xJ4BDfU9mZMWVva8PZgPdXwcTfH/ImSR6ZUzDrp7Ko4zByGT2ckPkh8aHkgcyuIF3yb/mZfclmWWd3e5lnESEjolMKkHCvFfRVATKZPbGCDgB3AfVg8IzGSIDX/2+Rt5740J+35G6KoXWbeoeA/3JtO7tE5iayM38+1LmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by MW5PR11MB5812.namprd11.prod.outlook.com (2603:10b6:303:193::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 09:46:18 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 09:46:18 +0000
Message-ID: <cf67c96b-21f2-47eb-b693-704c5657a2a9@intel.com>
Date: Thu, 16 Oct 2025 17:53:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] intel_iommu: Optimize unmap_bitmap during migration
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao, 
 Xudong" <xudong.hao@intel.com>, "Cabiddu, Giovanni"
 <giovanni.cabiddu@intel.com>, "Gross, Mark" <mark.gross@intel.com>, "Van De
 Ven, Arjan" <arjan.van.de.ven@intel.com>
References: <20250910023701.244356-1-zhenzhong.duan@intel.com>
 <20250910023701.244356-5-zhenzhong.duan@intel.com>
 <bc51d154-be8e-47d7-abe7-bcb9f93a7348@intel.com>
 <DS4PPF93A1BBECD1A86879EBF071C6D09D792EAA@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
 <74930e82-62f7-4b4e-8bdc-217142586dd3@intel.com>
 <IA3PR11MB913676B74FF4A6B74F4959D992EBA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <f6317dfb-4f04-42e8-8350-b47004c64f70@intel.com>
 <IA3PR11MB9136AEE8F0C3A989C964E35092E8A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <9fabdf4a-a781-491a-bbd2-40e51462b8e7@intel.com>
 <IA3PR11MB9136B2CF78F1473BED36E1B492E9A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB9136B2CF78F1473BED36E1B492E9A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|MW5PR11MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: 204c2fb9-e2ef-443e-a3df-08de0c98db0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|42112799006;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnA1Z2VCNWJrT2djajg0VHViUm52T0hrQmo1bWppTTBMMFFWRCtuNnd0cjk1?=
 =?utf-8?B?dG1wdUswdDcrUWVKbFlsVlI1bGEyTDhDVjhvc0xXSVNDU2JEaEtmeW94UGcy?=
 =?utf-8?B?VmRaazltakpCd3Q1aWlqQkpEakp4N2tHNHJnM0c0LzRuUFp5eVB1ekxmL3ZE?=
 =?utf-8?B?UzBIa3B5em84dUNjQU9jRDZUd0FuaDJwdXBpc1NKdXVIdlNsWU5aYjZFQkxM?=
 =?utf-8?B?amZOYUY2SnkxUXo5VkZmRG5udllIU3N0R3NXeU51dkszVUQyZERFN3l6akdF?=
 =?utf-8?B?THlSalF5Nm5yVEQybm5talhueDQvcWdRRHVRQUZYT1gvQTV1bm1HYjZYc0VG?=
 =?utf-8?B?KzVMMk0xNk01UmJ0SU9MdmUyd3pSVm1zZjBxU0o0Mmg0eU94bXd2NU8yZ1Mv?=
 =?utf-8?B?N2plUldHbmE1eGRZbkoxMndIZktDUUh1Mzg3VWFENGZYaEZRZEo4cG9hSG9t?=
 =?utf-8?B?RGUzL1pLUnBtV1BTUjcxMG1TTmZCVjBteVpNTGRpTmxjNStMUjVNdnhITml2?=
 =?utf-8?B?cVkrN0lnSWsyUVRqN0R5UmMyUjVYYjM4YmFTKzFzV0k2L25sYi9nU1ZYOGY5?=
 =?utf-8?B?STRuYy9Dc3cwRm0vR0RiSUluTEFrV2plSFpvMTR4T0FISEYrbGc5aTJmMWtY?=
 =?utf-8?B?YUhHSC9rZW5zcGhSZnI3Y2tiV1hMZlVYYS82TThDeWp4OWQ0NWNQbjVmN3dh?=
 =?utf-8?B?eTJkbitKYkxpWms5WENFek9Kd1JudCsxWTNiWmFpOStlNlJtb1FiWnc2czFK?=
 =?utf-8?B?dzYwS0pHUmhQWWQzR1k4NXNCUnNhNGhRejJrcksrV0NyS28vWkZLUXM1dWNv?=
 =?utf-8?B?Ti9LRzJna3JUcFhxd0M1UGdxQ2Q1RVZLallPT0RISlFoZytYcU03Z3ZwRnB3?=
 =?utf-8?B?Nkl4L2wvdmdDaGtWbDRlRVZ4bmpPN0s1czN0RzBtMDYwZXRLY3MveGI3UlJV?=
 =?utf-8?B?QThlelVaWUtNcWQycDJ5ZWhjSUdBdTM3ZW1JTEV4dUxaeUszUVNMNDNFVlVG?=
 =?utf-8?B?K3BVNWhqb3ptaWQ2UWwzUGJudFcwMUJPRG8raWRrb2J6TmN4RGNKNk43S2ZD?=
 =?utf-8?B?UWdGZnp5M0Y3L3B0a052allLLzEvY2pkdVoxREgrTlIrWXUzWE5JZjF1NU5P?=
 =?utf-8?B?VWduSGttQVJRcFlaSXhTWGtXMFZMOHFxenlUNWtDY1RvVTFuZ1Y4VG9jU1JS?=
 =?utf-8?B?eUtJS3BZN3MxcUhOYjBxL25pbDhlZ0MzSGJoM3RqSWJNWithOGVZMnhvR0Fo?=
 =?utf-8?B?VWVnWlYxZUNUUkRCcXRLbFJBcWo3clBqeTdmMGpTT2M1SGhESEpFYzJ3OCsv?=
 =?utf-8?B?S2g5U0VsaGVkL29BOTNwbXdndzRGYk5BTmF5d2RqUHFabUpMcFdKTm9LbkVB?=
 =?utf-8?B?NHNTZ0VpQWt0R1V0a3lyc3c4NE8yNWxBdTNOa3R4QnN1S3I3OG1HOE1MREYv?=
 =?utf-8?B?cE1hTGdPcCs4RGRyYTM4WTZublZhM3dOQUpvY2h1dDJCVnUzbk12a1Z0MC9u?=
 =?utf-8?B?U2RqSFZHbGhmNk90c1ZxUEl5bW5oSHp4NDZPYkd1TnhWU2kvZ09NSlN2SDFM?=
 =?utf-8?B?K1g4azdTaUR3dFRiWEhXbGZKeUFsbUpVTTAxRUZCcGovR0xDbHFka2tUOEJq?=
 =?utf-8?B?Y1lJbkIvR0N4VGhNZVFXTSthS2N0RGc0bjVmUDh2MUJqdFN4d0p3WlhrRWFM?=
 =?utf-8?B?U1BKVlNOcFFXZGs5MSsrazVCdmlFOWJYUDJPa3hDVWNLYk9xeEdkZGRLSUdK?=
 =?utf-8?B?amJmS01RYUdFQlhueUF4Wm41R2NMaUV6czgzRnZ6cXhYeUpseThnUGRSK1R2?=
 =?utf-8?B?dEJDeWpZR1dycFMzWEMzbTQ1clgxVldIYlQxYUh6MkQxUnBsQzZDVk9XaldF?=
 =?utf-8?B?RC9OdXl5VWF3TmN0NXh4ejE1N0R3eGZRK1Rkb2hzRjArNk9xL0RzWXZ0cVJU?=
 =?utf-8?Q?BVndrtWd+d7aMeW+3ZdGdJMnzx3FQT5w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(42112799006); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE0xZnF0RlJKUkpJSHdUVnJDRlJKVDlrekNRWFdUMU12eW5qc3JvVHp6Z1Rw?=
 =?utf-8?B?aXl6bDZ3UjQ0cGoxbVk3ZHg1d3BmNHhaeWhub0t1K2JZdjlVLzNrSXJVc2Nm?=
 =?utf-8?B?ZXpJTWp0Nm5tNnZxam5WOTc3NGFJN0FmTnplU0pITjRnN2RRNGJyRUpJKzAy?=
 =?utf-8?B?RWV6S1RFM1pManFlWEJyVHZ3WU90K1dwRVVESjlFOUtsaVIvMmUrbnUwQi9s?=
 =?utf-8?B?N1ZmcTlpakxRR09kUDBFWnBrTnl4QWJ1T2xycU8wV3ZKYkk2TXdVTUZqMDZs?=
 =?utf-8?B?MFRFQTVzT3djeDJkdlp3NUFhQXdHOFZid3JKNkVTdTMrTWF5Z1ZuZVB5Tjh0?=
 =?utf-8?B?VDZDQXlubXpXbDJUTms3dzdZWHJlbE4xZ3B1WUpPQWdpU3BmNU00UXdmRS8w?=
 =?utf-8?B?MnVsdk9PVEJEQ1pmK1FXQmRJbHBrWllrM3AxblpxdXR4WXg3V0NRWXVkcVk1?=
 =?utf-8?B?Q1hmOUhMOXYzQ2NyenRCajVlNnhUdk8zdGxwS29zb2svUkx6STRHdE5tQXZ6?=
 =?utf-8?B?dzgyUk9ZZnI5aDZ4Ymdma1NjNWprYUdKblhvWWpnaDNuQk5LV0dyNEtPMVpt?=
 =?utf-8?B?MHdBbEtlK0J6SEhObXBNNk1OTU5CbERTMW5LaFhCWDE2eXpyZ0xIZzQ0YlFr?=
 =?utf-8?B?SnRsOU0yQWRJN2tnYUxmWWdqQ25teThtdGhzUCt4QjJyRDgwSXdabWtzZkdY?=
 =?utf-8?B?UmxmczVJQjFBSjNiSUtZSUJBYnJBUWg0NnRreGg0SkZ1YlBGV3gxVDJIWmVu?=
 =?utf-8?B?TndkOG9oc2RkK0ZpTHBnTStoZ1FGVXJ6dDV4dnVoZHNvU21pM3E0bDFFZ3NG?=
 =?utf-8?B?K016NFRWQXYxbmFpWHVZM3VoeUo4SW0xREYyL1hQSEp6NHh3cG1pMmszekQz?=
 =?utf-8?B?NHVaWHp3TjFPUzBqTGw1OW9yYUZOZkZnS1hJeUxSTU5Wcndrd2swVFg4QUJC?=
 =?utf-8?B?QVEwVTJneWUxUGZCTjd0VkdrWHROR3hPd0JrN3R3aEtqZ2pwanBkQm0rZ09n?=
 =?utf-8?B?OWg2bVkrVG9pVk5temtjZWJnVFFrUkJmUGlMOWlYR0JUUGpURHB3T3lqTzgz?=
 =?utf-8?B?eDNIeDlhU2dkVllVYTZTY3ozS3JIVjVCblVIWVE1TTl1bnZobHZSUjJBdi92?=
 =?utf-8?B?QVNRM0xERngyS3VwbHBFcmxWWmlNQUZvNWx4ZG5lS2IzUnExeU9OdHhKTGJP?=
 =?utf-8?B?SlJzendmZ2lvMDJrczJVMU1TRTVyVXdJemFZVVA3Q1lucnZxS0k0OEdBTGE1?=
 =?utf-8?B?L3pmaVZoMzVHNyswVTV2ZEsxVEpFUENPSU42K05vbUIvWEFqK2RnU01scEZN?=
 =?utf-8?B?OVFQV1FvWWlXUmZBV2pTMExKR2U4TUxOc2xJeFZoWjdsM3o2L21lVUFVMEQv?=
 =?utf-8?B?WFU3cEN6WVJHQnJReTgwNFBCWENjMEpVWW9oRWhPbVlnY1lZaWlKM241Y0VF?=
 =?utf-8?B?Q1R1US9UUkhDNXlQbmI4RW5ZVWVHQktEYzRCS1M4WTZmL1EzU0VKOWQvTnl0?=
 =?utf-8?B?bjhtTVNzT2p1Mm1xQjVqK2J2UU1CcDBaTjZrY2RrSCtONGFISktIYjNhZWt5?=
 =?utf-8?B?VXFjM2JqaWIyU296S2RmdTNseG5sZ2gxYUYvbGMxM252SjZCRFVJYjVROG1Z?=
 =?utf-8?B?S0V2Z3NDZnU3WEswM1VvUDMxRGkvVVFhQ1FkbThlanZ4b1ZtUmJBQ2s4RFMy?=
 =?utf-8?B?S2VXWXpia3JZbWZYaGZDaW1uemJKNkZGaUZMcFFqTHBCdDh1L0p5STF2VWY0?=
 =?utf-8?B?dkpCSmJKZTdkcFVLdkRURVg0aHFqS0l0d2pIM0pObG1VNk1iWFVyWloyaFBt?=
 =?utf-8?B?Rjc1N3BTdDZxWGVFN0YyTVBqT0htYjBFcXc3aTZXRTd5QWkyUXRFOVRIMHVI?=
 =?utf-8?B?bHFGWHRYUkpZSldNL3pwM2NTZTUwNEp6K2FWaytFQ2lYWkdqVnFWWFNwM21J?=
 =?utf-8?B?M0pqTXdKVk83MGg2a29mMmIxbmRQbHRPRnlXS1Y3bUZHdXlLN0d1VGFrTHAw?=
 =?utf-8?B?OENtRlNFcy84LzhxQnczVExxYTMxZ2tnQUs3dW01WlJVMW13U2dKbXhEYU5K?=
 =?utf-8?B?anNDOWkzdUNscUhNYU83dkZqbktSWmZ2TUZwQ0xNT1lHTUdYYmxkRjZXOXI4?=
 =?utf-8?Q?oF95aL3zaKW1Gx8Bwy2qdlgnj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 204c2fb9-e2ef-443e-a3df-08de0c98db0c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 09:46:18.5778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YVUymG73/26GDVFIW0Rku0iATXVz46rrrEA3Gq3p5ud3PG6lCyVvWXPvREGDlKcijQatFhCsxrkVvTYJFgRHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5812
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/10/16 16:48, Duan, Zhenzhong wrote:
> 
>>>>>>>> how about an empty iova_tree? If guest has not mapped anything for
>>>> the
>>>>>>>> device, the tree is empty. And it is fine to not unmap anyting. While,
>>>>>>>> if the device is attached to an identify domain, the iova_tree is empty
>>>>>>>> as well. Are we sure that we need not to unmap anything here? It
>> looks
>>>>>>>> the answer is yes. But I'm suspecting the unmap failure will happen in
>>>>>>>> the vfio side? If yes, need to consider a complete fix. :)
>>>>>>>
>>>>>>> Not get what failure will happen, could you elaborate?
>>>>>>> In case of identity domain, IOMMU memory region is disabled, no
>> iommu
>>>>>>> notifier will ever be triggered. vfio_listener monitors memory address
>>>>>> space,
>>>>>>> if any memory region is disabled, vfio_listener will catch it and do dirty
>>>>>> tracking.
>>>>>>
>>>>>> My question comes from the reason why DMA unmap fails. It is due to
>>>>>> a big range is given to kernel while kernel does not support. So if
>>>>>> VFIO gives a big range as well, it should fail as well. And this is
>>>>>> possible when guest (a VM with large size memory) switches from
>> identify
>>>>>> domain to a paging domain. In this case, vfio_listener will unmap all
>>>>>> the system MRs. And it can be a big range if VM size is big enough.
>>>>>
>>>>> Got you point. Yes, currently vfio_type1 driver limits unmap_bitmap to
>> 8TB
>>>> size.
>>>>> If guest memory is large enough and lead to a memory region of more
>> than
>>>> 8TB size,
>>>>> unmap_bitmap will fail. It's a rare case to live migrate VM with more than
>>>> 8TB memory,
>>>>> instead of fixing it in qemu with complex change, I'd suggest to bump
>> below
>>>> MACRO
>>>>> value to enlarge the limit in kernel, or switch to use iommufd which
>> doesn't
>>>> have such limit.
>>>>
>>>> This limit shall not affect the usage of device dirty tracking. right?
>>>> If yes, add something to tell user use iommufd backend is better. e.g
>>>> if memory size is bigger than the limit of vfio iommu type1's dirty
>>>> bitmap limit (query cap_mig.max_dirty_bitmap_size), then fail user if
>>>> user wants migration capability.
>>>
>>> Do you mean just dirty tracking instead of migration, like dirtyrate?
>>> In that case, there is error print as above, I think that's enough as a hint?
>>
>> it's not related to diryrate.
>>
>>> I guess you mean to add a migration blocker if limit is reached? It's hard
>>> because the limit is only helpful for identity domain, DMA domain in guest
>>> doesn't have such limit, and we can't know guest's choice of domain type
>>> of each VFIO device attached.
>>
>> I meant a blocker to boot QEMU if there is limit. something like below:
>>
>> 	if (VM memory > 8TB && legacy_container_backend &&
>> migration_enabled)
>> 		fail the VM boot.
> 
> OK, will add below to vfio_migration_realize() with an extra patch:

yeah, let's see Alex and Cedric's feedback.

>      if (!vbasedev->iommufd && current_machine->ram_size > 8 * TiB) {
>          /*
>           * The 8TB comes from default kernel and QEMU config, it may be
>           * conservative here as VM can use large page or run with vIOMMU
>           * so the limitation may be relaxed. But 8TB is already quite
>           * large for live migration. One can also switch to use IOMMUFD
>           * backend if there is a need to migrate large VM.
>           */

instead of hard code 8TB. May convert cap_mig.max_dirty_bitmap_size to
memory size. :)

>          error_setg(&err, "%s: Migration is currently not supported "
>                     "with large memory VM with approximately 8TB memory "
>                     "due to limitation in VFIO type1 driver", vbasedev->name);
>          goto add_blocker;
>      }
> 
> Thanks
> Zhenzhong

