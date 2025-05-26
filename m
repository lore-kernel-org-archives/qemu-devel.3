Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B26AC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 12:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJX89-0000Mk-9U; Mon, 26 May 2025 08:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uJX86-0000Hw-U6
 for qemu-devel@nongnu.org; Mon, 26 May 2025 08:40:34 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uJX82-0002nD-9r
 for qemu-devel@nongnu.org; Mon, 26 May 2025 08:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748263231; x=1779799231;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ynItXKA4SuBuSJpShhnaSv+JbUE4Szdk08/cB1tjX8Y=;
 b=Upqc8w1kPVRqCC3OtsOc5oq/TDwo5WaMwboVmCdVhXJ50p2MPSV+Ckkh
 VEKwFYNOispKFhSeOQy56XYwYmvLMEEyVqC3lFMSRrvpZLLsRe99BiBA7
 bvUEvzCAb7oZ8Nv4j7D/Ak67KxOTa6dCwL9Odnptj968TsNRlQJUpQyv4
 H5DNs7pwLw7bmu0Ll8Nz8Mjc/jBSRH791gfKcdDmNSaeeC0NTXjOZmVar
 BQmrCPCBhKCKBa8qagDxzssYdUQB/8T4Li2IA17IyXZZhQnhZ3tBZSyO8
 XcsUEAjf27RxR6iMFoJiA28+mHXee0evUq8w4u6yWVs/lEFUCuqGTtiXh A==;
X-CSE-ConnectionGUID: ORvVdZ3pRkqMlRCN04+EcQ==
X-CSE-MsgGUID: y/opwuWWS6Khyb+IA/d5JQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="50239645"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="50239645"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 05:40:26 -0700
X-CSE-ConnectionGUID: 7GNfq2dbSDKGruMu76R5Aw==
X-CSE-MsgGUID: jzPTO/GIShCYZ5Itue0zAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="165547212"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 05:40:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 26 May 2025 05:40:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 26 May 2025 05:40:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.42)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 26 May 2025 05:40:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsrWKb2sIHoC2u4NXu95q4IepNc8301fjWs88NDE7OhaRFIdzFewjq/KPyqLTyRg6m8hIq+L49r5xbCLcI6bhWKZZvDHb+dVuGEmpLsaClkOhCICsUnGMIvd0rsvRH6g+i7ShlL2DSfjtJ7AUuKkmq47Y3TO4DRcurEthkWCKOGKrv2+aTwiHTe+bHh8uRcKlwtO/x0zUOPIwdYjNIjcZ45g2zUllg6fvwpNxPIoPFKDgMkezQ1L4UIeT/qMFtSqT4lRVhB25psE2QrQsbUpHrjbwwVc5VvujRDVxn68TRMEd3OVM/m7y64DXtNKCaIhEiO18KHoeAR0M0hKJUcFSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MwG+r+H04SToeGiWdvPRbysIGcssrmt7Cf/m9oZLL4=;
 b=QevamLMkMZwQPTrZDWKmRF0f5GokJMKvAJFJcp9xEJXmZaBjLDdwZvJQHqVjJ0TknVEwyM/BijO/CRkiRqnfVgmEZtMlWU4GJOGev2Az3Q2e0/Yde8F3LPwG0WWuaUSI/Gw+O0b1TKM4B5C1r7dN1bZwPlAtWL1Xq8KLsRzYDTQGeIcBlwxLKI9A/dYeL+pqKOOGVmShTMvo1sxmGtnFasn3nUXpgm2DuIU5dGRNij3/qG/R+QudGhVAo3Nax89hpdCKfVBA7BvvUD+0J5l2CpwyDyoqtJkIyPMqoV6tDu3ZNuOITDB8fW8u+S3Yp6ow2XmSnBtosKAzOPoTdc7jtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 MN6PR11MB8242.namprd11.prod.outlook.com (2603:10b6:208:474::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Mon, 26 May
 2025 12:39:55 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%4]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 12:39:55 +0000
Message-ID: <7d0257d5-2b2f-445e-b80a-686a2512408c@intel.com>
Date: Mon, 26 May 2025 20:39:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/10] ram-block-attribute: Add more error handling
 during state changes
To: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>, 
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Michael Roth <michael.roth@amd.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, Williams Dan J
 <dan.j.williams@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Baolu Lu
 <baolu.lu@linux.intel.com>, Gao Chao <chao.gao@intel.com>, Xu Yilun
 <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
References: <20250520102856.132417-1-chenyi.qiang@intel.com>
 <20250520102856.132417-11-chenyi.qiang@intel.com>
 <6b5957fa-8036-40b6-b79d-db5babb5f7b9@redhat.com>
 <1674a16c-e4fb-4702-a21d-9c4923528b2f@intel.com>
 <f2e8c15a-cbb9-4d17-9ee2-87567e36e8ea@redhat.com>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <f2e8c15a-cbb9-4d17-9ee2-87567e36e8ea@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0101.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::17) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|MN6PR11MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: 6866d816-ca6f-43c6-467a-08dd9c526b19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUlGeDZZdUs0eGptQzZURWJRTkFtdW5BNHloMWllZWZGTXJ6ZVdqR3hnUUt4?=
 =?utf-8?B?T1Awa0szeFlMdzgxVlZ0MjlzWG9tRnh5cks0dG5iUkZXNkZkSDYrYVJ3dEwr?=
 =?utf-8?B?U1BaSldJb1JPT3ArTk9wNE1RVCtzdnhMQVlhME53Z3E4allLdWN5NUg0dE9W?=
 =?utf-8?B?MHZ1WXNiWUJ0bUNERVRITElQRUdwWjRSU0s4bEFIbFNWbWhUNnFvTUw5bEwy?=
 =?utf-8?B?aFFTYmloRW1zVzFCNW9MSGUyNmpqRzAwMnBMckJLTGhIRWdzTTJLZkExSEdO?=
 =?utf-8?B?b09GaWMyNnIxMTZjQ3NYYU54NUJZK0phMXFVNUpYUnBOdWlLUmpKUU1uUHE1?=
 =?utf-8?B?Sm1SWlFTQVNneFBGcHB4V2JmSGVqZkRBMWxRdXJyZnRtNFlYbUNiODdCazBh?=
 =?utf-8?B?cGZtZHVyaC9ENlc1M2t3bi9HWnkzVHlucHhncXlaZTBMVjZlVTVBNGZNWWhN?=
 =?utf-8?B?S0R1clMzVGQ5TTB0NFdaQzVWWFFuTFBkY0VRblJla29RckZobWR4VUpRK1M4?=
 =?utf-8?B?d1RyMXBlZ1NCTlp2dzZ1UGVEemxaMFgwRFFmbExpc01iaVMxa0gyQ0w4b0pG?=
 =?utf-8?B?dEJ5YVlkSGJuVTNPZ1gvZExpYXNjSXVHVExUdmp6RjQ3QlM2YlNzQXptMHZ4?=
 =?utf-8?B?bnh0TWpTbXozM0txTm1jMVRtQngwaUpNOHZqUGhMUVJqWkgxNjg3SEFqREtj?=
 =?utf-8?B?UWZoTUFCZXVxUFlxWGFWTHJMUmR0Nm9CWVNUTmtFTG1vK0dRVWN5UVZFN3FS?=
 =?utf-8?B?MmtjeitXVGhGZ0xUYzU2MFJjRGdlU2h2N28yalFvYXFQWnljbjNWdm9JaXFL?=
 =?utf-8?B?dk9EMHl6RUVYVjIwSVlSYy9jZWhPaUdGQ2FSOFY2SDFFMitwT2xsODl4bHNq?=
 =?utf-8?B?RE14ZFpmSjdTWFNFUWJOa3RGbWxVSmR2Q1p1WkpSUHUxN09UMVh3VmRVMncz?=
 =?utf-8?B?MjNqMWljQkZwd0UreUNGN1ZoSVNIN0dMU3ZjT1A0Sm52b3dpQnM2ZkxYQVVN?=
 =?utf-8?B?UjU2K0huZGJESXlrRHlSbzhCb3krZ3dCdmtsUnVISkJJV0RIdmVXNDFtOGhP?=
 =?utf-8?B?SlJ2MHNUdFNYZzRnNS9zTjJxT1ltKzJSRXYwYnN3SGsrYkpxTjdPK2FXVnps?=
 =?utf-8?B?WkJzTVE4SzRONVpkVTg5TnEvZjREeTF1RFFkM01MblhQaU5TNFBsQzY3YTdi?=
 =?utf-8?B?Rkhwa3NhcVZDK2Q4UmFuT0xhdlRzc3ZNajNzdm82Vk1hWDFGZmJpYkFoUWZt?=
 =?utf-8?B?RkdFM25ZYXEvcS9NV3psRkRPcnJ3RHIxa0pjZG9QamFPNlIvU3hTWWh0VFlH?=
 =?utf-8?B?d0dITlZNZFE5Rk9FRVFXZzAxRDZGK3lRVFNzNFNrc2RCU0VqdkluYWNzREZ6?=
 =?utf-8?B?SEU4Nk1kYTI3cDNvTnBEMEZYbk5pSEV3K0p1a3phWi9YWGlrZ1ZhUXZ6OVNa?=
 =?utf-8?B?WmR3emNpQXRNNm5vcitPb3N2aVpOeWpqWTZ4bC9aWlhzNFFPS3k2cEg0MkhN?=
 =?utf-8?B?QlBYZVJUWm1xQWFEcGhYcW5rbnNNVk1kNy9rQ3AxUmtuZ0J3SHpkWURwYkNO?=
 =?utf-8?B?RFNiTjJ1MEtOMk1hREJ1RkYvTDJ2eFh5c3QrVlN2U21VU2p3cU1EVGRzc0N5?=
 =?utf-8?B?akhSNmdPQU5NYUE5WjlOQTEyNk1JclUyU1VyWkpnN0ZvY3NzVDlXcWJOS3pz?=
 =?utf-8?B?bS9sN01oeSttL0VVWXczUWw5WnpoRkRiOTFFYi9qWkE4YjM5akp4U1B1ckg5?=
 =?utf-8?B?RzRhbVZIYnhIaFJ0bVpIbmg5dTVJKzNnWEJnNlhWbkhKL0svMmFIVHp5MFZk?=
 =?utf-8?B?U2ZSTStCU2lDWTRxNE5kUFdNcTh3a1B3ODF1NXJhRGR4ZDROSWRGeVNxM082?=
 =?utf-8?B?N3NsY2pnR0lZRVBsUzUvYmpqQVZVc0FDclVmbVdBeWJZK1NoN1hEYXZ5RmQx?=
 =?utf-8?Q?V1lxELX446k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFRXRjZUYVlmKzg1NFVRZFBEcStja3h4SWFNMElDRTVxSUZPWkgxczFtTGNW?=
 =?utf-8?B?c2FjbEoxZlRwMmtKSTRFemZXSmdzRTM4ZnI3Z0VYUStmenJieXUzeDdjNkFG?=
 =?utf-8?B?eC9Bc1ZNeFVKbmVtdkhxbnk1cW5HU1Z5enlEU1FHUVBoTldlQlZ3RDAvSE4z?=
 =?utf-8?B?YjhzOVFGVXF0MWhPbVZHZ1ZyTEFwby9Wc0xFRW1JbURGSFV2a1lSaUM4TlVZ?=
 =?utf-8?B?NDBQY1pGS2tlMnVBUVE5R1RhaUtDcVVQVmhqakswcTR4MCtsMjArZnpXaTA0?=
 =?utf-8?B?UmhZdFdSUEMwQS9TbGdoVy9WUWVETTQxQkp3ZDJaTlNJTDdBeXI4MzA3YU1s?=
 =?utf-8?B?YU5WSFFGWnNaOGJLVGRPL0t0R05YNExFNUdPOGcvNDVaUVlhN0J6UmNqMTRB?=
 =?utf-8?B?d2d3MFI0SFNFd1FHYkU5SG1hMnJEUjI4OEduUmhWZXdUNDNnMUNZVkZFYXgx?=
 =?utf-8?B?Q3hlTkpVNFY3VFQzdXZiNG8wanExQ2RMQ1FWeVNxVkF5ZWxWendnSkVJWmJn?=
 =?utf-8?B?S2dVbUpVSU9sdXB0a2N6VjBmK3FLMC82K21GUkhKUUNFcnVlTm1TY0NMR0Zo?=
 =?utf-8?B?ZUQ4aTdVRHZmR05MRURqYXRMamZsVDlFWUJ2Um9PZC9oaGJwU1RFbGpoNXB3?=
 =?utf-8?B?TDRrTnBqQkRkVFBDZFNxK1ZVd2NmK29tMUF3NEEvbzI0WFNYdG1Xd05ycjZ5?=
 =?utf-8?B?ck1Hd1E2N3BvbjIzTlFMeExNdUtxT0NWY2Q1RUFIYzdrcVRRTVlWcjVBalNj?=
 =?utf-8?B?WStjQUF3YWR2MUVTMitYeDQxM0JCODZhQ21laGdldU12UWFPcHVCaHNpaTB2?=
 =?utf-8?B?c09oSFgwaTRZa2xWbFQrVkRNTW42RktEZDRmclVIeTVac0ViYktDM1BXYkJo?=
 =?utf-8?B?cEdRaW9USXVDbThXZVBNZ1JDZWRaU3o5SDNjbGxzUVdFRlNpNkFlRWJvRk0v?=
 =?utf-8?B?aVRSdEx2WE9INStxa0RtOGJtV21mQ09jSGhsdVZIczlyQlA4MGVDNlBId0pO?=
 =?utf-8?B?SmhTSTd3K3JBc3FscTRjNUU4WEJtMXVYZ2RLZGR5TW5tODJtZTRiNEpacjFu?=
 =?utf-8?B?NEdmTXlZVy85dVVXMERvRHR5SUNrK1F3UzNNVU5RVjJmMWgzdVMvUXdybC8x?=
 =?utf-8?B?MGcrakttUjR3N0pGaHlnNmRKZUtnbmNEYlE0d2YyVGg5ay9ibWJZb2VmNDRx?=
 =?utf-8?B?VHZqa3Z0Uk1ocmFadVEyM2hmZ3NtZDMrL3RsRnorMHUvK3BXN1RFbXN3aWll?=
 =?utf-8?B?ZkUvK3AxZXhFcitEZ3NkMzBGSDBCa3prVW1lY2R0MHNUTFBHeEpNQUE3Q0hO?=
 =?utf-8?B?Mm9OeTNxbytQK0RGOXJIOWsyVzk2bklYTllscXlRczBLMVVvVHZydHF6M1Jj?=
 =?utf-8?B?emtmTStjS1Fnc0RHdGJBb0luNVhacXBEbGVWeWdNYnVkeFhtamdzaDcrWDJM?=
 =?utf-8?B?dFhwRzRrdkh0WGdKWXBEVHB1WVdjaXB4ZzFkWVNmNGpDRTB6Y1ZlbUFQNk0w?=
 =?utf-8?B?MWd4Y08xSHd4SkhrK2JyZU9CSGxBKzlwekxwc1dTd044V1ZxMW5RamIzN0Zh?=
 =?utf-8?B?T2VIREIrWWJyZXFJekNWNTBWR2FVU2ZDcHg0cTFJVGVtQjBJbHViOHV6d0g0?=
 =?utf-8?B?SzI1b25BL0k2T0RnQUZOaDR4Vis2WXU0Qk12b1lnYkIvVVhRSHpBOVFDM3VM?=
 =?utf-8?B?R01hTm1VL0lzRW84M0xoQ1Q4MXBXS0UybVUyUU02K3VITzJuZllkWllVVG00?=
 =?utf-8?B?c2J3NXl5TG1WckVuQXo5M05pSGxTTmhyb2VJd0ROOUhkZFdHME02alNQU0Zv?=
 =?utf-8?B?VEtNN2FLeWZOb0owRjNCd24rQzhxa1BGVXptOW03dzd4TW1nUXNmcXJiL3hk?=
 =?utf-8?B?MG85QnR6VjdHL3NGcVBQRXFnZmFFZ3RNL21vRDY5S0djekd6UGxjbGhWcDZi?=
 =?utf-8?B?NnVOcnZFVjI1SDR2T2FBNjFGVW5NZlBTVyt0N2V3bGJjWmtiNkVnSDJ0Wk1x?=
 =?utf-8?B?ZE9xNGc4RVZNYUNhUXp1WHdIUDdsYXM5a2JPSzV0UExjeTdNU2d0M0twcGFU?=
 =?utf-8?B?UU5OaTNXTFhxOElISmhBUTBYVXVoWHNHaUc4V3VjSmNkUWxrWlVWQ2o1SlFo?=
 =?utf-8?B?cit0cHcrTFZKWDlBQVBZU1FFMjdOYTZVQ0gvL3NnVHJDQU1vdmFpZFovRDQz?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6866d816-ca6f-43c6-467a-08dd9c526b19
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 12:39:55.7530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GrLItiulmBZlqDqCT7kj1+kENT9ggNumrb897lPQ4SjyHL7bxwUMKRIoL/gRJ7AxjlPexYPsT9wxpAzWpkZKPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8242
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
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



On 5/26/2025 8:10 PM, David Hildenbrand wrote:
> On 26.05.25 12:19, Chenyi Qiang wrote:
>>
>>
>> On 5/26/2025 5:17 PM, David Hildenbrand wrote:
>>> On 20.05.25 12:28, Chenyi Qiang wrote:
>>>> The current error handling is simple with the following assumption:
>>>> - QEMU will quit instead of resuming the guest if kvm_convert_memory()
>>>>     fails, thus no need to do rollback.
>>>> - The convert range is required to be in the desired state. It is not
>>>>     allowed to handle the mixture case.
>>>> - The conversion from shared to private is a non-failure operation.
>>>>
>>>> This is sufficient for now as complext error handling is not required.
>>>> For future extension, add some potential error handling.
>>>> - For private to shared conversion, do the rollback operation if
>>>>     ram_block_attribute_notify_to_populated() fails.
>>>> - For shared to private conversion, still assert it as a non-failure
>>>>     operation for now. It could be an easy fail path with in-place
>>>>     conversion, which will likely have to retry the conversion until it
>>>>     works in the future.
>>>> - For mixture case, process individual blocks for ease of rollback.
>>>>
>>>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>>>> ---
>>>>    system/ram-block-attribute.c | 116 ++++++++++++++++++++++++++
>>>> +--------
>>>>    1 file changed, 90 insertions(+), 26 deletions(-)
>>>>
>>>> diff --git a/system/ram-block-attribute.c b/system/ram-block-
>>>> attribute.c
>>>> index 387501b569..0af3396aa4 100644
>>>> --- a/system/ram-block-attribute.c
>>>> +++ b/system/ram-block-attribute.c
>>>> @@ -289,7 +289,12 @@ static int
>>>> ram_block_attribute_notify_to_discard(RamBlockAttribute *attr,
>>>>            }
>>>>            ret = rdl->notify_discard(rdl, &tmp);
>>>>            if (ret) {
>>>> -            break;
>>>> +            /*
>>>> +             * The current to_private listeners (VFIO dma_unmap and
>>>> +             * KVM set_attribute_private) are non-failing operations.
>>>> +             * TODO: add rollback operations if it is allowed to fail.
>>>> +             */
>>>> +            g_assert(ret);
>>>>            }
>>>>        }
>>>>    
>>>
>>> If it's not allowed to fail for now, then patch #8 does not make sense
>>> and should be dropped :)
>>
>> It was intended for future extension as in-place conversion to_private
>> allows it to fail. So I add the patch #8.
>>
>> But as you mentioned, since the conversion path is changing, and maybe
>> it is easier to handle from KVM code directly. Let me drop patch #8 and
>> wait for the in-place conversion to mature.
> 
> Makes sense. I'm afraid it might all be a bit complicated to handle:
> vfio can fail private -> shared conversion and KVM the shared -> private
> conversion.
> 
> So recovering ... will not be straight forward once multiple pages are
> converted.
> 
>>
>>>
>>> The implementations (vfio) should likely exit() instead on unexpected
>>> errors when discarding.
>>
>> After drop patch #8, maybe keep vfio discard handling as it was. Adding
>> an additional exit() is also OK to me since it's non-fail case.
>>
>>>
>>>
>>>
>>> Why not squash all the below into the corresponding patch? Looks mostly
>>> like handling partial conversions correctly (as discussed previously)?
>>
>> I extract these two handling 1) mixture conversion; 2) operation
>> rollback into this individual patch because they are not the practical
>> cases and are untested.
>>
>> For 1), I still don't see any real case which will convert a range with
>> mixture attributes.
> 
> Okay. I thought we were not sure if the guest could trigger that?

Yes. At least I didn't see any statement in TDX GHCI spec to mention
such mixture case. And in TDX KVM code, it will check the start and end
gpa to have the same attribute before exiting to userspace: (maybe with
the assumption that the whole range shares the same attribute?)

vt_is_tdx_private_gpa(vcpu->kvm, gpa) !=
vt_is_tdx_private_gpa(vcpu->kvm, gpa + size - 1)

> 
> I think it would be better to just include the "mixture" handling in the
> original patch.

[...]

> 
>>
>> For 2), current failure of memory conversion (as seen in kvm_cpu_exec()
>> ->kvm_convert_memory()) will cause the QEMU to quit instead of resuming
>> guest. Doing the rollback seems useless at present.
> 
> Makes sense.

OK, then I will move the mixture handling in the original patch and
still keep the rollback operation separately.

> 


