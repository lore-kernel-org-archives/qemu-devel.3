Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07046C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 07:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Q1K-0004Yq-Gt; Wed, 09 Apr 2025 03:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1u2Q1H-0004YQ-5L
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 03:38:47 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1u2Q1E-00048n-6A
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 03:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744184324; x=1775720324;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sXIOpMsp4L5NB/zYkuOtAm4GdM6gOk0P2F8Aj1hly90=;
 b=fDsaGB7RSjdKVQI95rODrsKF6uMLEvD/iXqPXPLw6EFYPG5mSmtYE+vh
 Ha3nSnbPNGVc2kDTj1KqGKzmUCGchmL/hOaNDz63WFcE3CzYvLg8/uum8
 Y0WJOlR4kZN0zWKrHEcMKPWCGViCjSmRnwzY6NVgC07sjtxHr/sD3EMHf
 l1TcplSc0XPOjPosx57ILT7Nyx7CisxqTuxhxNLMjJWPbER/Ah9t4+9ba
 ljqWzn45tCaeJLrxYFuk7hvxvwcukTb6LggAmAOBQ7CMqsx4eNhovVs74
 f+yF6sB/s9S4WEHyOGwVE2/An7dlxLHo24Ksw01becDPHThPo5Q0P5ahY A==;
X-CSE-ConnectionGUID: NHpGFWTlTvW+eM5pMw2Jng==
X-CSE-MsgGUID: hWvyn1/BQXGPdQBPVE5pHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56311249"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; d="scan'208";a="56311249"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2025 00:38:40 -0700
X-CSE-ConnectionGUID: 0O4xbVOYR46rAOkPIuxvpA==
X-CSE-MsgGUID: C2JOgfJuQz+aHZ/LTvNMag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; d="scan'208";a="129451450"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2025 00:38:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 00:38:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 00:38:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 00:38:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiQId2ZWZngrp6uabxVa4bR3UJ/gJchysSl4mx3qBRNllUT39gU0WYIjsHrDFZ3igvcwTZlAh9S1Pc3+DcpCnsrMs5WQFrLNDKrkrfFGV4s6IYwAA8XVskGKT8ILHC/42eyS1LuihB1hwNvzCt3y2B/YUSES0Vu04fFNBCOHNUxccDkE8ofuNZa+qbVslkcqJOFtJpV8qmOhKU1d0khXleSH4JxE6T1CUgOP5OAw7z3maQY9i8GGmy/ejFqnB33RcTbnNm3VvBaMPji5NxzLufnXEQ/DngUsDIidhMBXrhCFKZbBubaIxMHpWn6hPTHMW7nrOvS0mmLoo2H2G+PNrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mprwJqMwyz3JPBZekaXMIoFQ5o9JBTblGt+fuz3hTc0=;
 b=Szz/lv+Rug1JFGbbj7t1c4nnhh6EPI2xwMd5wkTVab4kJsXwVOfjHLaIFPfP/g1rqJeBGeop2BTFUToCPxLMWrtU3y6HmbH79cIbBpJ6swYyYxuIPfmZANfM6ZrNtZGOgJzgFMpTcIfdOfkfaKleO1YiNKi1U5z5imnB5DgyLxyLxB0kdeXjTYqoxCgmaicE98gGZ5ylg6XhUVhPCOyEtUIDuYAXSMppV9RPxAtCHjTkPWqT/+lp+16fL+dmw53NZMh4JJRz98ro2zixb5fhmtqpMFaH4KbOjb0ptqkHPNchNFFCK4NzlM/yZNHLDhf+LIlPYRLPtR11EjChyRvp5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 SA1PR11MB8394.namprd11.prod.outlook.com (2603:10b6:806:37c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.20; Wed, 9 Apr
 2025 07:38:36 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%7]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 07:38:35 +0000
Message-ID: <1abb7ade-eefa-43e6-8f3e-7ef639bce139@intel.com>
Date: Wed, 9 Apr 2025 15:38:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/13] memory: Export a helper to get intersection of a
 MemoryRegionSection with a given range
To: Alexey Kardashevskiy <aik@amd.com>, David Hildenbrand <david@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Michael Roth <michael.roth@amd.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, Williams Dan J
 <dan.j.williams@intel.com>, Peng Chao P <chao.p.peng@intel.com>, Gao Chao
 <chao.gao@intel.com>, Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao
 <xiaoyao.li@intel.com>
References: <20250407074939.18657-1-chenyi.qiang@intel.com>
 <20250407074939.18657-2-chenyi.qiang@intel.com>
 <90152e8d-0af2-4735-b39a-8100cfb16d16@amd.com>
 <47b04426-73c7-41d9-b7b7-ee2fa40886ae@intel.com>
 <0045ea05-3af5-4f07-84d5-546b0bc8bb91@amd.com>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <0045ea05-3af5-4f07-84d5-546b0bc8bb91@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0045.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::14)
 To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|SA1PR11MB8394:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e652e9d-e569-48ed-eef8-08dd7739892c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWJ6RlFIcURjM21tdVA2dGh5bHE0VWlyOXdtR2ROSXFkTkdxRUErUGk4WG95?=
 =?utf-8?B?MUcrb0lUbWdYdjNQK0UxUUg5eWhTS2RxQjZkT1JjQ0pHbkxHdk9JYTZjZUxB?=
 =?utf-8?B?cXBYL05UeHk0d3krUGJTUzBEVmlsLzBjMUJDUmlYL2dJYzBCaU91TUZUN29l?=
 =?utf-8?B?OUh4amdYTWQ1VCszemVMb1k2OVFNTmtTK3dGS0FOelV6MDdNRWZQTkkrM1Vh?=
 =?utf-8?B?K2g4aEVQTVFVd2NnQUF4SnpsK3k1VC9ZUEEvbEQ1eHBzN3g4enFsQVZRZUF2?=
 =?utf-8?B?T095TkNscWdDem80azBxaEp2bnZMMjJtNVYvNE9OK1gyWTFVSkNuR3ZTbldC?=
 =?utf-8?B?emVlcXNmUzNyanR0ajhaOVEwK3N6eTNldFZIWStydmJmMWE2YWpKVTZZcFhp?=
 =?utf-8?B?cmxrQ014cHdkVXJvUVRFWVQ4aiszYUk0K1BkOEM5NkpvYmVPV2tmaUNKUEIz?=
 =?utf-8?B?Mnk2T1JTeVJGdkNnaW1ZdGIvTlBKd1o1Z3Q5dzZvMHViL0phT3B5SHIrVmRq?=
 =?utf-8?B?RWZwcmZCUzRDbWNTR2RaeHU3VEtzeHNRaVI1VXR3SFlodlpGZ2Q1VlRqMEVa?=
 =?utf-8?B?b2xEZ0Y5NUJvand3aXN3aG1odlkyeVRDZVU0VVdqemZxMmgvSytzb1BaOGcz?=
 =?utf-8?B?bk1zK0hkVUprS0tpbXdOR2ZOU0hCdjBSS1dOMXNYaGJCeGpoYmJyeldDK1dC?=
 =?utf-8?B?Vk90SDZiZlUvbXMzYmg2QkxhOS8yNmxSbFJqU2xvL3JWUDYveFdxVDNWZFcy?=
 =?utf-8?B?WnI5aCs2bmRSWXQzMi9EeDN5Z1lQU0k0aVdYR0VLQ29teG5qSlo3U2hYNWxy?=
 =?utf-8?B?TlFMcDFtYk03MGhpeDlGWkltOFpONTJXaTNvMnlnUUUxRHF0a1c0bXZuNWlZ?=
 =?utf-8?B?UEhaMEtISHU4dmE1cG1UNTkxM1kyY2dXelBTZExuVHlkaXBubTJRd2p0dGor?=
 =?utf-8?B?Mm9UcDU4RTlkSXdNajJxdkdPclVkNEdCb2pwOWNWS05OVUlkZWlkSXRsMW42?=
 =?utf-8?B?T0dSMG5uMnp3a2U2NGJqcVdxRU5JR24vV3BlYVpQMk0ySDA0RjFUMXFDbmd0?=
 =?utf-8?B?OW9JcWpCdk5LNENISkpBdDA4ajV3Wm5ObXpmbm4zN2pVTWNlZTVCOXBJallr?=
 =?utf-8?B?VnB4NkVYZTBnMVI1OXJpaC9ReUxHUGtUNlV0c3ZTMDJwV0xGS0R6M1N6L2FO?=
 =?utf-8?B?amY5T0d4ckhFYUo2dldPSjVhdUZHOHpMV1pQMkRFZldPeDFHMmtyN0RITk9F?=
 =?utf-8?B?UW93OEJLN2tQN0xjRzBRMVY2ZnorQmVFb1JFbEYxM2JBM1BvdVpCWTR2aHZO?=
 =?utf-8?B?YzZ3WW41NVZINy93NnVneXJZeEQ5MnhVZ0U4dHNXREJRdnVwK05TZHYxRVZI?=
 =?utf-8?B?L1BaandwZVJYY1pETU5ndmZodmEzcmJCR09mTWlYZUd5UzlBT1VrOUpqNnJJ?=
 =?utf-8?B?OVBIZlRicG43NWs3ak1QQXFoQmsxVzUxOHhRbWlLYW83VjVjQTBydmt0N0VM?=
 =?utf-8?B?SE5pUDVmdWs2YzhNS2ZlbGhpY0g5Mzl5QytVNXdsRWs0elhraUVtSHV1enVO?=
 =?utf-8?B?TzVUMnlpN2lTS0lzWXFMa1Nqa25RSTRKdUZKd0c3d09MWHNKdHdyUnRDTUNS?=
 =?utf-8?B?dk42WlRBSmt4ZTlFOElBRXpsOUQvWkRZWEZIK1E0VjV3eWZjY0ppZEFwWC9o?=
 =?utf-8?B?Tk5rUENhOVpxMlNyQXRNUktkbHg5R3FtcWFrMFhJY0NSTXF5d09lUWRINnB1?=
 =?utf-8?B?WXFBd08yZC8rWHVTTFVJR0RJMzFZOTZFNWErd2NQcWd6TEdiVU1RaGdHRFMz?=
 =?utf-8?B?Q2xWci9CY1JiTXBpd3ZQQlFPbjV6Tm1kcHQxYXZSSTJPQTI5Y2Q5OW5DT0l5?=
 =?utf-8?Q?rJx5rbncYNXA9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjdWZTFUTEdKWUVsZHRTTlFzNlFMQk9GNzE3RHpwMGg2RmZpY1ZlVlZVUENX?=
 =?utf-8?B?WjRLazRSRzQyS2JKS1NKejlvVHNZMjNoV2JyYjMwQTg2TjRVSjYvRU9kcitD?=
 =?utf-8?B?TGwwVUVvTEowbm45ekVpSEJmZ1RqMWpTRmM3VzcyOXVYNXVIdHgyUlhtWWVr?=
 =?utf-8?B?WVlUc1lvOTRBQ2Nldkc0VVIzQlNEN0RTQWtxcDVQNTF1eUoxYVhlNXNOT0Ji?=
 =?utf-8?B?bFRVUDE4c3F4VGMvVVRkTENZanUzdUJBdXJGb08yQ0JuMmg5azRsdEhDTzZN?=
 =?utf-8?B?VUxUUlBYQlVJazQyRms3MlhSamxxUUFNaXZOTy9RZHZYRmJaSTUyeHVxWU0w?=
 =?utf-8?B?SGVVZ1pRa2xFOHBYWExhSm9nUmRJb2pScXU4SXBqVGs5KzdiOHFQYjBjK1hD?=
 =?utf-8?B?NXZrL001dTc1TEhtTkZoYStQRVM5VnpRd2NCVStoNVliYzdHV014K1Q0dy90?=
 =?utf-8?B?anlVSjBFUHpmeldoa0lFVWlxNWpOd1kvQ2Y2eXJXMGFsVzZoMUdzczBPT1dN?=
 =?utf-8?B?RG5SS1VxdWhCa2FEUjc1ZDBVUEM0Qnl0NXdzRHFwYXN2aUVwNjd5M0hncUZB?=
 =?utf-8?B?d28rUHpLT0Vack5CaUMyUFBVUkFhcVVtS1hmMy9maDc5MmNaNy9NSHRvTjZk?=
 =?utf-8?B?Y2xrZnE3dUVPbWJ5dzdzVmdJS2d2OUVwd0ZOb0hEajdRRE5OdkdwU05qV2ov?=
 =?utf-8?B?dnFtdkc2ejBtWmo5dDNVNE9RUXgrUlVUNFVCaXE2V0UwUytJTWgrWWFtZEMw?=
 =?utf-8?B?alVvQ0ZacHlSMGw2eFhjRU4zQ0JYU0QxdFJiekExNFlQMDd3Qk9XK3NRTzRL?=
 =?utf-8?B?KzdCWnlFSFFiMGF4L2RGZTNBbzZ6UEFhRUZVS2tncDNpbis5Z0drMWtYTkh6?=
 =?utf-8?B?MzcxWWtvSTZhL0E1MXZ3aVhTSUIveHZ5MG1rUEdnaTZKZ2poOHpueXBOVVdX?=
 =?utf-8?B?Q1lHUEdLZU9LNnd3Vm9WZUh5ZEhnenFDMnhsRklSY3hBWjl4R2NIN1BHYjJC?=
 =?utf-8?B?UXErWWU3UkZ1ZXJtazhvdlZTWjBhUG1YUFNOKzl1UnUxczluVlFpN05jNHhT?=
 =?utf-8?B?YjFXMFJHOHM3ajJLQUtFZTJRS0VGcmtJZHI0N2dwa1dlanlZeG1FYVRJamxX?=
 =?utf-8?B?ZEpsbHIveWcxV3RqRmVUeUIrQ1pMUk1mTkVGbGZVenJxOVJ0MnVTRGdtb2Jn?=
 =?utf-8?B?TzAwSUpwMjlSM0syc2M4dVBkTXRvNUxGeHF5bC80akFSOWo4UlJkeHlLTWcr?=
 =?utf-8?B?eWlvenZrejNIQ0c1SjA0b2R5L0VWQXpGM1dnMmc2NHNJZStjNTlGY1dXME1Y?=
 =?utf-8?B?V3RPSEMyaFYrbkRCZ1p4TlM1UmdBRkhickR3WituYTdlcnNZdFlQY3lqbGxs?=
 =?utf-8?B?bFJ1VUJVbG15NHRINTJXdXZtaW5KYmpMelNSeXV4NEo3WDg3WGJEQ05CZlZ0?=
 =?utf-8?B?Tk4yMGFyZzY1bTE4d0kzc0RaeE5QNDdEZ3FMMDl2Wk9mekMxdGZNNStKWUdk?=
 =?utf-8?B?YjZDdE9sUG5oSkI5MS9RSnJvTVQ5WXBqOUNhZWJXVlhaa25tNHF1R3JQTm9B?=
 =?utf-8?B?NXZySEcyeEMyalZaaVV5NkxuYzdNcVpzYmpoYkhHSkhsMUMxWW42MXhac21X?=
 =?utf-8?B?d2JHeXkxQy9rUkg3SElSNk1NdmM2VWpqcVNGa2ZYZXdMNUpNQ2Urd2plWG0r?=
 =?utf-8?B?NnM4V0tyQy9MRitLUG9OdmRzWWRWVWpocUZ3OWJvYUhWd0JWVXJKaHBQM1BQ?=
 =?utf-8?B?YkQyRGE2cGg2K2V3K3VuSXpmbE8xLzhrcGI3Nit3T1ljandkb1d3MkZWTG5C?=
 =?utf-8?B?dmFXSU5xa2JEdnpOeEtpUENQWExEWERTSlRJK29nVXNxSURGVkRUTzB2L043?=
 =?utf-8?B?eEFkSmJnaXFkZEYvekt2eCtJeVBLa0pwSytIVDhXdDhVVW54OUR4a2JBTGdP?=
 =?utf-8?B?VDQ2cFRaOWg3NzdwRHhCU2lVSjMxT3dsSnUyVU5jY0tMd2d0QjRrS3VqZnJV?=
 =?utf-8?B?SEg0cnRLUG9MUmx1L3ZDcWc4YS9UaGhDSFJOZ25JOHBCOWpucHlHSTRUelAx?=
 =?utf-8?B?UlJNZTFGdkJYbzQybXZsTXVZNmF3OWFJbkIrejBjOTBvWmMrNThSY3hGZVE4?=
 =?utf-8?B?U2QvVmJldXVKWlpWZjlpYkhuenVzNHhSakhFTFRicFBOeEdOMTROMEZqTXp3?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e652e9d-e569-48ed-eef8-08dd7739892c
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 07:38:35.7969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5T9GiRWBv9RBNZP0hSnXSljeULl20rrWeiIZuf2LI1GbUX45L66sZbTDoV/id9A1CMps9RkeI6WRi/gU0Vg8ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8394
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 4/9/2025 2:45 PM, Alexey Kardashevskiy wrote:
> 
> 
> On 9/4/25 16:26, Chenyi Qiang wrote:
>>
>>
>> On 4/9/2025 10:47 AM, Alexey Kardashevskiy wrote:
>>>
>>> On 7/4/25 17:49, Chenyi Qiang wrote:
>>>> Rename the helper to memory_region_section_intersect_range() to make it
>>>> more generic. Meanwhile, define the @end as Int128 and replace the
>>>> related operations with Int128_* format since the helper is exported as
>>>> a wider API.
>>>>
>>>> Suggested-by: Alexey Kardashevskiy <aik@amd.com>
>>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>>>
>>> ./scripts/checkpatch.pl complains "WARNING: line over 80 characters"
>>>
>>> with that fixed,
>>
>> I observed many places in QEMU ignore the WARNING for over 80
>> characters, so I also ignored them in my series.
>>
>> After checking the rule in docs/devel/style.rst, I think I should try
>> best to make it not longer than 80. But if it is hard to do so due to
>> long function or symbol names, it is acceptable to not wrap it.
>>
>> Then, I would modify the first warning code. For the latter two
>> warnings, see code below
>>
>>>
>>> Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
>>>
>>>> ---
>>>> Changes in v4:
>>>>       - No change.
>>>>
>>>> Changes in v3:
>>>>       - No change
>>>>
>>>> Changes in v2:
>>>>       - Make memory_region_section_intersect_range() an inline
>>>> function.
>>>>       - Add Reviewed-by from David
>>>>       - Define the @end as Int128 and use the related Int128_* ops as a
>>>> wilder
>>>>         API (Alexey)
>>>> ---
>>>>    hw/virtio/virtio-mem.c | 32 +++++---------------------------
>>>>    include/exec/memory.h  | 27 +++++++++++++++++++++++++++
>>>>    2 files changed, 32 insertions(+), 27 deletions(-)
>>>>
>>>> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
>>>> index b1a003736b..21f16e4912 100644
>>>> --- a/hw/virtio/virtio-mem.c
>>>> +++ b/hw/virtio/virtio-mem.c
>>>> @@ -244,28 +244,6 @@ static int
>>>> virtio_mem_for_each_plugged_range(VirtIOMEM *vmem, void *arg,
>>>>        return ret;
>>>>    }
>>>>    -/*
>>>> - * Adjust the memory section to cover the intersection with the given
>>>> range.
>>>> - *
>>>> - * Returns false if the intersection is empty, otherwise returns true.
>>>> - */
>>>> -static bool virtio_mem_intersect_memory_section(MemoryRegionSection
>>>> *s,
>>>> -                                                uint64_t offset,
>>>> uint64_t size)
>>>> -{
>>>> -    uint64_t start = MAX(s->offset_within_region, offset);
>>>> -    uint64_t end = MIN(s->offset_within_region + int128_get64(s-
>>>> >size),
>>>> -                       offset + size);
>>>> -
>>>> -    if (end <= start) {
>>>> -        return false;
>>>> -    }
>>>> -
>>>> -    s->offset_within_address_space += start - s->offset_within_region;
>>>> -    s->offset_within_region = start;
>>>> -    s->size = int128_make64(end - start);
>>>> -    return true;
>>>> -}
>>>> -
>>>>    typedef int (*virtio_mem_section_cb)(MemoryRegionSection *s, void
>>>> *arg);
>>>>      static int virtio_mem_for_each_plugged_section(const VirtIOMEM
>>>> *vmem,
>>>> @@ -287,7 +265,7 @@ static int
>>>> virtio_mem_for_each_plugged_section(const VirtIOMEM *vmem,
>>>>                                          first_bit + 1) - 1;
>>>>            size = (last_bit - first_bit + 1) * vmem->block_size;
>>>>    -        if (!virtio_mem_intersect_memory_section(&tmp, offset,
>>>> size)) {
>>>> +        if (!memory_region_section_intersect_range(&tmp, offset,
>>>> size)) {
>>>>                break;
>>>>            }
>>>>            ret = cb(&tmp, arg);
>>>> @@ -319,7 +297,7 @@ static int
>>>> virtio_mem_for_each_unplugged_section(const VirtIOMEM *vmem,
>>>>                                     first_bit + 1) - 1;
>>>>            size = (last_bit - first_bit + 1) * vmem->block_size;
>>>>    -        if (!virtio_mem_intersect_memory_section(&tmp, offset,
>>>> size)) {
>>>> +        if (!memory_region_section_intersect_range(&tmp, offset,
>>>> size)) {
>>>>                break;
>>>>            }
>>>>            ret = cb(&tmp, arg);
>>>> @@ -355,7 +333,7 @@ static void virtio_mem_notify_unplug(VirtIOMEM
>>>> *vmem, uint64_t offset,
>>>>        QLIST_FOREACH(rdl, &vmem->rdl_list, next) {
>>>>            MemoryRegionSection tmp = *rdl->section;
>>>>    -        if (!virtio_mem_intersect_memory_section(&tmp, offset,
>>>> size)) {
>>>> +        if (!memory_region_section_intersect_range(&tmp, offset,
>>>> size)) {
>>>>                continue;
>>>>            }
>>>>            rdl->notify_discard(rdl, &tmp);
>>>> @@ -371,7 +349,7 @@ static int virtio_mem_notify_plug(VirtIOMEM *vmem,
>>>> uint64_t offset,
>>>>        QLIST_FOREACH(rdl, &vmem->rdl_list, next) {
>>>>            MemoryRegionSection tmp = *rdl->section;
>>>>    -        if (!virtio_mem_intersect_memory_section(&tmp, offset,
>>>> size)) {
>>>> +        if (!memory_region_section_intersect_range(&tmp, offset,
>>>> size)) {
>>>>                continue;
>>>>            }
>>>>            ret = rdl->notify_populate(rdl, &tmp);
>>>> @@ -388,7 +366,7 @@ static int virtio_mem_notify_plug(VirtIOMEM *vmem,
>>>> uint64_t offset,
>>>>                if (rdl2 == rdl) {
>>>>                    break;
>>>>                }
>>>> -            if (!virtio_mem_intersect_memory_section(&tmp, offset,
>>>> size)) {
>>>> +            if (!memory_region_section_intersect_range(&tmp, offset,
>>>> size)) {
>>>>                    continue;
>>>>                }
>>>>                rdl2->notify_discard(rdl2, &tmp);
>>>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>>>> index 3ee1901b52..3bebc43d59 100644
>>>> --- a/include/exec/memory.h
>>>> +++ b/include/exec/memory.h
>>>> @@ -1202,6 +1202,33 @@ MemoryRegionSection
>>>> *memory_region_section_new_copy(MemoryRegionSection *s);
>>>>     */
>>>>    void memory_region_section_free_copy(MemoryRegionSection *s);
>>>>    +/**
>>>> + * memory_region_section_intersect_range: Adjust the memory section
>>>> to cover
>>>> + * the intersection with the given range.
>>>> + *
>>>> + * @s: the #MemoryRegionSection to be adjusted
>>>> + * @offset: the offset of the given range in the memory region
>>>> + * @size: the size of the given range
>>>> + *
>>>> + * Returns false if the intersection is empty, otherwise returns true.
>>>> + */
>>>> +static inline bool
>>>> memory_region_section_intersect_range(MemoryRegionSection *s,
>>>> +                                                         uint64_t
>>>> offset, uint64_t size)
>>>> +{
>>>> +    uint64_t start = MAX(s->offset_within_region, offset);
>>>> +    Int128 end = int128_min(int128_add(int128_make64(s-
>>>>> offset_within_region), s->size),

[..]

>>>> +                            int128_add(int128_make64(offset),
>>>> int128_make64(size)));
>>
>> The Int128_* format helper make the line over 80. I think it's better
>> not wrap it for readability.
> 
> I'd just reduce indent to previous line + 4 spaces vs the current "under
> the opening bracket" rule which I dislike anyway :) Thanks,

I can make the adjustment for this line. As for the previous line which
also reports a warning, do you think it needs to wrap?

> 
> 



