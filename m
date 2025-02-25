Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC6CC021A4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 02:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmkFJ-00012A-6l; Mon, 24 Feb 2025 21:00:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tmkFG-00011v-S4; Mon, 24 Feb 2025 21:00:26 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tmkFE-0005OY-7N; Mon, 24 Feb 2025 21:00:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740448824; x=1771984824;
 h=message-id:date:subject:from:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=JA/ezLx3bUSSnBbf1AevH9zgTr7RRtfJUK5uuUA/hVE=;
 b=C7sy6/pzLGPM8CUdG82oAezbWYqMLNtvYb5lyHNZUT8Rb+aLmf0YAoFw
 s6/TyQ6B4JzfHsPhshjhVZj6o7JWBdAdNVF173Gyg7OwYsnQHavAjAGzw
 9f+MVLC+p2dlMK9FBy7TbHhBSLA9pATW2MX2msT7Crcc3sye7xkd9Brkq
 38PVM0k/Gl3BT/CvYUrpZYPRc/lNB7a7yP8IZMhVM9H2cXnFavJLIn1FQ
 P8vVC2j6KDIzR66TN/zCg7SbxGDA8pFC92Ywco2aBcW9myuRCd/bNqBn0
 XyrVwHnIznxP4ym1EcZG2Hs1ZlE+PEA+W72ECjvAjDnL1OuTfd96MU2DM Q==;
X-CSE-ConnectionGUID: dC9OFf8gTxG/OiWVA5kvuA==
X-CSE-MsgGUID: al4SdqLdTZugEDajXzgC/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="44891942"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; d="scan'208";a="44891942"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2025 18:00:19 -0800
X-CSE-ConnectionGUID: 1kSfdffFRdSjiKU7PetgVA==
X-CSE-MsgGUID: 6grlvvViSrOsEZl7GoMxcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116736116"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 24 Feb 2025 18:00:19 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 24 Feb 2025 18:00:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 18:00:18 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 18:00:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBf5eoiV2LSuZE5B3r3WkSmP5Ptmy0ypT3HVQotjO5hCN8k0xW2qbM0XeJr2VVp4QA/QrDs2U1fFG6zlgIcz5O4Snx24TRzRfqUxRJyleEMyiVrLOVTUI4QLN4vM1frL25D3+AwtO+kPl/GyxPzTcVnh8t3XqsoptsxoABE23vOrEL4CiT6UmAXJ2PjtZutr6YqE1MT7129pWD/iB9kMCt9CMZaT1q0Jf6/I3HNnX3igAMVt6zBtHoPAnW0mfIXDgKFYqWdDi8KUR0B0bepjvXXAwWl2Njhd4VxldpXIxfO9s9Ba10qs7K0mjT7exBM7+TI60tjShLKT0J88F19/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJQvEbb5C35A4CmVp9WN+qkBZIlM1yGrUteNie/ZZ50=;
 b=Itn5hvphJGtKUsRFaYETSenC3H7V440iyNKM2YAZRXAFnSPX27Ht8rPBwx4wRNrSFaBpQLnwWlbeygZhNJKtNFUGnSbZpwSwoJaqbgZ5BHRjs4Tm7mehSKHVBlSVyTheq0zyZFVZBOZNVyv82lg5FmfOeexrbL2XJ/xeqJvvUU/F8FVGMaaUNJoBJHEimRqnrCY1nLm95b3K88Kg0I4lsE7ka7IY1Gg1ZtLXMRFVBzaqUWwkpSmLAEFhfA03evQYUKsx1pzOuZcscdEFldIzMJvx3SXhgn9qknb48pIsLJe6E16mZcdkDCysAZI8aEOJ3FmEWt+QxNjjnJIk4vSt4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Tue, 25 Feb 2025 02:00:13 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%7]) with mapi id 15.20.8445.017; Tue, 25 Feb 2025
 02:00:13 +0000
Message-ID: <16cb9605-ba4c-441e-8709-369a37655b4a@intel.com>
Date: Tue, 25 Feb 2025 10:00:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] system/memory: Allow creating IOMMU mappings from RAM
 discard populate notifiers
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: David Hildenbrand <david@redhat.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, <philmd@linaro.org>, <peterx@redhat.com>,
 <pbonzini@redhat.com>, <peter.maydell@linaro.org>, Alexey Kardashevskiy
 <aik@amd.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
References: <20250220161320.518450-2-jean-philippe@linaro.org>
 <20250220161320.518450-3-jean-philippe@linaro.org>
 <0d761daf-174d-487f-80fe-09b04902006f@redhat.com>
 <75d90f78-151f-4169-84f5-cc3c13180518@intel.com>
 <ce2306f9-19a4-4979-80e6-29b1e8a92318@redhat.com>
 <108be3a5-cfc1-4268-a913-3a41d1e4451f@intel.com>
Content-Language: en-US
In-Reply-To: <108be3a5-cfc1-4268-a913-3a41d1e4451f@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|MN0PR11MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: a8194f0d-305e-4d80-2183-08dd5540244c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXVkY3I4QVVVNTA0d2tCYnJNTGRzbFpqSzJEdkN5WlJYOElDZHEzVUFhbk0y?=
 =?utf-8?B?c01DRWZhNHZWc3pBVFB6b25PbHdmRURWZWJFanZyK2k2dzR1MC93cTZnM09O?=
 =?utf-8?B?citmSy8zQ09aT2VnSW9PbDF0YXV5YVIwMXRSSFVFSGs1YjNBU09LcDBMc1dF?=
 =?utf-8?B?MmVzOVVYWGUvd0lrUFFLYkIyU29acTAzK3haSmVxNHJhUkN0eklxOVdnblA4?=
 =?utf-8?B?OG02bUVQQzlQR3VFVlJSMUMvMkxLVGhodGZRMVRpMFJWU0pNY0ZlZ3JkVUlI?=
 =?utf-8?B?ZlFwbWxudU5BZUdXQ3pVWndkdThwY3dBUjdFWGhJbm82SU1Rc0NmVlpPcUps?=
 =?utf-8?B?d3QvaDJFYVpXSERzajBOMmdJOE0vMUVoU0ZGckRtVlVwM00rQ04rUERJc05D?=
 =?utf-8?B?WnNVcllGMWFhWnJXNlg2bXlLSVlzUWQweExid0hsNUVabWNyNmFCTjhac3Qx?=
 =?utf-8?B?Y0NEY1JzSUdTWmd2Qmd3R2hWRVRCMVdueDcraFJOQ1lPaGhSeDVxS2lPTjk3?=
 =?utf-8?B?VmdjdFBLeXNPN1c0QURGMFpkZmhwLzh1YThXdE1YWnRrZ0gxejNhMHZRU096?=
 =?utf-8?B?akk1Nlhpa3hGMWlqdjl4MVBFc2lUVGpsL2xYQXJzVTUvRGF2elNuTUZyTlFU?=
 =?utf-8?B?TllIY1BMOWV0eHE2cTcxdGc1TWVCcUx2NGJ1dzAzbkVMVDR2MUplZzlJYU5q?=
 =?utf-8?B?TzZxa0pna3o0cjhlK0NCdVlIZGtwUXE0SE1LSkZVT2g2QU5EV3BUR3FQay9J?=
 =?utf-8?B?cEY4NFhhRm5jbGxXSXdLMEVVRUhYUVljNzdiQlJVMGx4SEpRZnpOM09oM0FY?=
 =?utf-8?B?L2szQmpQZlFlZUJyTXRvb2drVG9CdmlUM3JQY1krQThrVlFoak15VXd3ODZZ?=
 =?utf-8?B?bTMzRjlXWjBJL25IQitQVkFNSTRGUWJmeUNDdE9Ndm81RmdGUWtIUWthd1kw?=
 =?utf-8?B?TFB4MWV2ajVvd1l5K0FsTkZOSm9RTFNEeUNLemJhWDJXWTBWTndFdHpSakVn?=
 =?utf-8?B?Q3BTSTJXQ2ZWQytXN3MxMWw4NlRQVGc1VStHc2lSeXBKdVd1em1ZTkZCa0Vi?=
 =?utf-8?B?by8vbXdlYTlFNEsxSHl5MHoyYkY3MmdHR2dEMjFXMGZ2NmdZYm9IdGlaa2NE?=
 =?utf-8?B?T3E4Y0F5M0RtQ2Q4TUFDWUNxOGg3ZW9tY1huYkZhc1RnbnpsRUsxUFN6NXFm?=
 =?utf-8?B?cXI1UnZ6WGs5R243QU0zR1VCcGE5NzJFaG9nQk4zTVhQMVZGa09QZG5nT3hP?=
 =?utf-8?B?T1hxR2hPRUNJNlc1ZTlBWU5PQ3JqczlXalFwZGtNMEt3RlhZRXhlRS9KMFpq?=
 =?utf-8?B?YTJkeU5Yb3NWUFB0ejAxMEdnS3RnNWpmaTZRK3pVUEFteEhLTlp3Q0FMRXFi?=
 =?utf-8?B?VytCZDNrQlJJWC9qZFg3TXZFSlB2RExwRGsrYXFEL2NIOVNyalZBZTlzR2d5?=
 =?utf-8?B?RW52Z1hGeFZLY1NpakNpbkJKOGdYbHNBZmRQSllmRW1ic0FIRVA3VERxY2oy?=
 =?utf-8?B?dUtaSy9XRHJpWHZFZ3pGNVBNdnI4VU1Ma2lpNzFEbmwwU2FveTBpSFVVVkFu?=
 =?utf-8?B?K3ZqTjNUVjQzQ0VwRURtNFBaVmdLMTEvY1ViUC8rY281S1J6K25heFpIUS9i?=
 =?utf-8?B?Ni9EdFpzMVJmbmJZSGZYdURaZWNvNGhnVUxZajJRNFhSOUdvY3FjaU5VN2hN?=
 =?utf-8?B?L3p1anIwSVM5akM2KzY2c2lWTHYrY3d6MWk5aDBDUy9ZQ0ZXOXdkZzVxNmQ4?=
 =?utf-8?B?UGhSelNHU1Y1OE15L3ZQak44dHRLUDNnTjhZVGowK1pvSjdJQk9CVk1WRjU2?=
 =?utf-8?B?QWhjOVRVREIyTXBrOUZXMWRFMG5WNkdTKzRuU3k3N0RBbnUvZXp0UFlGbGRY?=
 =?utf-8?Q?BnzvL1eTE0sFK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWhydmFmMWpCYTJRUFNab0ZreURIdzV5WkFWbENMekpSaU4vejZKZWw0ZUlP?=
 =?utf-8?B?ZXNFWEo3UTJmMFpLSUlUV2xGZlBJVGFNTTczMndJSDNuSmhJVmFOdit0eEdK?=
 =?utf-8?B?N0hyRWtDblEzYW1ReS9WY0U0UEpueTBNM0Exa2R6Z2J6OWlvbWgwZE1WYzhI?=
 =?utf-8?B?OVB4VmtVaU1QZUtENUpEQXY0QzIxOU5wTURPUTFQdFpkSWt6VGJqd1pMdVlx?=
 =?utf-8?B?NktmVVJnT09FWEJYc0ZGd1paZXdYV0x6dGk1OWJVa2xGVVI0alhlQWtIOVRC?=
 =?utf-8?B?NGovVmQ4SVhlMGNXVlFGc1FnRUZZdFR1RXgvMUp6aDFNcXh0WGFvMm1NNXE5?=
 =?utf-8?B?T080WGJVeTdnL1llY0Y0RGJETUF4QzdZMVpJektLQzBqa1BVcWdsZWE3dlJP?=
 =?utf-8?B?UHlIRkgreUQ2Tk5QWXlwRFhqSjJmZzFmL1JSdHNNUkxYbjF6QzA2dEs3Qmx6?=
 =?utf-8?B?em5ZcnRhcHRzUWkrdGc2VUhRTmpiRWhzS3RQYmQ0Nzk3UlNUeWlPL0RsczJX?=
 =?utf-8?B?WVdMOTIyODFlMlhybFdlUi9MZ2haR28rdzYvOHZobjdzbDMxMm1aV0ZPV1Zn?=
 =?utf-8?B?cm9PN2M3N0pzcXR6V1RRZkRCK2o4WHhmeHR6ZW1VUWxMV2hLQktpcU5yZ0tP?=
 =?utf-8?B?ZEI5Zjh0N0hoVGo5U0FXVHFOaUZROExKV2JJcjlCVjZodFgyTlBZQkh0NU1j?=
 =?utf-8?B?Zmp1TE9MbnRUaGNuSzZCZjU4QjBIS0JIYWV4QjFQbXRxRkIzVnl0a1kvTU9B?=
 =?utf-8?B?RnFQcUhZQ0tLS1V0dzlmbEx6WWx4ekJWVG9EMlVVVWtXZ2xuUU1jeVZCOWFS?=
 =?utf-8?B?cFBkQXZOR2xtMjErL3Y3MnAyWlRVQ1lTL3l1R252ZnRQS0Y3bmdMSTJGK0V2?=
 =?utf-8?B?OXFTc0xmaHRPYnpPdHFDZXUxdWE4ejZHbzZlN0dWY1B1OHlsbnFDUXBtSDZh?=
 =?utf-8?B?YWVXZHAyWnJtVmE0K25OV0orZEh3OHREWWgzUGFPeE40K0gxZVg1OUVMRG1N?=
 =?utf-8?B?Z1ZsUXlUTXgrVEJpbEVzUUNJMklXWUhBUUpNRDZoeDhEY0hoSm0zQzZFK3l5?=
 =?utf-8?B?YmxlTkJNU0RGTW05djN2cnp3UTl2VlFKWXpuMmlCcEVXZnFqcEtUUE1NaUtZ?=
 =?utf-8?B?NXQyWmFPZWZtQlY4bEZ3YmtRcHFZY2VJTnZCV0xEOTliQ0x0aThLNDF3M1dz?=
 =?utf-8?B?L1k2bGc4bStyeXN5eUhpYTBvQlBKcml0SHZZQlN3VkVPSXRzbGNqNlpwWWtl?=
 =?utf-8?B?WjJ1U2p3aTFQNmdYQm5hdW5qT1JIMGFaQytqMHF1QTBHclM1MnA4Y1F5Y1Vu?=
 =?utf-8?B?KzN5b1gxNm1QZGZxMnEzZE9pUFBuV0VHczFCcitSYlgycnBFR2l3NzF0S0wz?=
 =?utf-8?B?Z2JDOStWWE5YdEZ1TEhQbllMU29JRjVCais0eWRQVnRLUXI2ZTF6WjhFcVpx?=
 =?utf-8?B?emtGVWsrZ1poQlhDZWh1SnEzeUVuR1B2eFFsKzd6NXpYWllqK3h2VTdkdzZP?=
 =?utf-8?B?aGFoTEZRZXBIempuUWk0bC84YzN3VVlzaHNJYlZRL042TGgxRTk5aG5lVVZZ?=
 =?utf-8?B?MmZLQmpvK05HejBvKzhGZ1hibjNhUFZDN25MNW1wTUh4NEppNmtkNVNvY3NH?=
 =?utf-8?B?MHF2WnV2Q2s5RHNZT1FrSkVGWjBBT2FtWi9jMG9DbjZZWW1ZUmlXRklreEgv?=
 =?utf-8?B?S1dma3FVRlVNaG1RZWZaUWpqNnhFNTNuTjR3QTk0TVlvN1ZqRHhIOTA2cEJ1?=
 =?utf-8?B?aFdHbjZZNWVlTUhmWXdiYzFtSERvcFBZRTFBZm5WL3M1aG90Y1hoV1pZTnJX?=
 =?utf-8?B?cUJ6dDcxRzRlZ3d1d2FwSGlLV1d2K3I1cllTVnVGTG9XMk1Xc3hPcGhVS2pO?=
 =?utf-8?B?Njk4a1MwL0hpd0I2eWtPM0VlcHR4M3ExV1UrRUVpbXE5eTlCc0FtbDdYMi9n?=
 =?utf-8?B?TWcxdS9Wa3NESFZZOVhYVnNkQjdpb1dOSWQ0N1RITjNCa3dsbEVFTkRVc3Mw?=
 =?utf-8?B?ZzQ0MDhZWnJFdkgwcy9vV09VeGdmKzA1MW5sSFBoVGV4cm9tbFpBKzgzdnNY?=
 =?utf-8?B?N3p5d1dXWDZ0UDluMjdnU0FpRGtCazRZcTJMMG1pRkhVOWZJU0JhQTlSUG5H?=
 =?utf-8?B?dE5haFRmWmlmTWc3RTZhcDVKcjIyZUZ2QmhNWmdpbFd2YVpJdDFzNit6WXcv?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8194f0d-305e-4d80-2183-08dd5540244c
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 02:00:13.5513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSg48bujd7sWYEfI8IVy1raonjaGfiZg2wH/Zt5tfLne5fm3o5KD+tzbjXgnk8z8CgAQA7ir3IDyC2doYy+Y4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6059
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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



On 2/21/2025 6:04 PM, Chenyi Qiang wrote:
> 
> 
> On 2/21/2025 4:09 PM, David Hildenbrand wrote:
>> On 21.02.25 03:25, Chenyi Qiang wrote:
>>>
>>>
>>> On 2/21/2025 3:39 AM, David Hildenbrand wrote:
>>>> On 20.02.25 17:13, Jean-Philippe Brucker wrote:
>>>>> For Arm CCA we'd like the guest_memfd discard notifier to call the
>>>>> IOMMU
>>>>> notifiers and create e.g. VFIO mappings. The default VFIO discard
>>>>> notifier isn't sufficient for CCA because the DMA addresses need a
>>>>> translation (even without vIOMMU).
>>>>>
>>>>> At the moment:
>>>>> * guest_memfd_state_change() calls the populate() notifier
>>>>> * the populate notifier() calls IOMMU notifiers
>>>>> * the IOMMU notifier handler calls memory_get_xlat_addr() to get a VA
>>>>> * it calls ram_discard_manager_is_populated() which fails.
>>>>>
>>>>> guest_memfd_state_change() only changes the section's state after
>>>>> calling the populate() notifier. We can't easily invert the order of
>>>>> operation because it uses the old state bitmap to know which pages need
>>>>> the populate() notifier.
>>>>
>>>> I assume we talk about this code: [1]
>>>>
>>>> [1] https://lkml.kernel.org/r/20250217081833.21568-1-
>>>> chenyi.qiang@intel.com
>>>>
>>>>
>>>> +static int memory_attribute_state_change(MemoryAttributeManager *mgr,
>>>> uint64_t offset,
>>>> +                                         uint64_t size, bool
>>>> shared_to_private)
>>>> +{
>>>> +    int block_size = memory_attribute_manager_get_block_size(mgr);
>>>> +    int ret = 0;
>>>> +
>>>> +    if (!memory_attribute_is_valid_range(mgr, offset, size)) {
>>>> +        error_report("%s, invalid range: offset 0x%lx, size 0x%lx",
>>>> +                     __func__, offset, size);
>>>> +        return -1;
>>>> +    }
>>>> +
>>>> +    if ((shared_to_private && memory_attribute_is_range_discarded(mgr,
>>>> offset, size)) ||
>>>> +        (!shared_to_private && memory_attribute_is_range_populated(mgr,
>>>> offset, size))) {
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    if (shared_to_private) {
>>>> +        memory_attribute_notify_discard(mgr, offset, size);
>>>> +    } else {
>>>> +        ret = memory_attribute_notify_populate(mgr, offset, size);
>>>> +    }
>>>> +
>>>> +    if (!ret) {
>>>> +        unsigned long first_bit = offset / block_size;
>>>> +        unsigned long nbits = size / block_size;
>>>> +
>>>> +        g_assert((first_bit + nbits) <= mgr->bitmap_size);
>>>> +
>>>> +        if (shared_to_private) {
>>>> +            bitmap_clear(mgr->shared_bitmap, first_bit, nbits);
>>>> +        } else {
>>>> +            bitmap_set(mgr->shared_bitmap, first_bit, nbits);
>>>> +        }
>>>> +
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    return ret;
>>>> +}
>>>>
>>>> Then, in memory_attribute_notify_populate(), we walk the bitmap again.
>>>>
>>>> Why?
>>>>
>>>> We just checked that it's all in the expected state, no?
>>>>
>>>>
>>>> virtio-mem doesn't handle it that way, so I'm curious why we would have
>>>> to do it here?
>>>
>>> I was concerned about the case where the guest issues a request that
>>> only partial of the range is in the desired state.
>>> I think the main problem is the policy for the guest conversion request.
>>> My current handling is:
>>>
>>> 1. When a conversion request is made for a range already in the desired
>>>    state, the helper simply returns success.
>>
>> Yes.
>>
>>> 2. For requests involving a range partially in the desired state, only
>>>    the necessary segments are converted, ensuring the entire range
>>>    complies with the request efficiently.
>>
>>
>> Ah, now I get:
>>
>> +    if ((shared_to_private && memory_attribute_is_range_discarded(mgr,
>> offset, size)) ||
>> +        (!shared_to_private && memory_attribute_is_range_populated(mgr,
>> offset, size))) {
>> +        return 0;
>> +    }
>> +
>>
>> We're not failing if it might already partially be in the other state.
>>
>>> 3. In scenarios where a conversion request is declined by other systems,
>>>    such as a failure from VFIO during notify_populate(), the helper will
>>>    roll back the request, maintaining consistency.
>>>
>>> And the policy of virtio-mem is to refuse the state change if not all
>>> blocks are in the opposite state.
>>
>> Yes.
>>
>>>
>>> Actually, this part is still a uncertain to me.
>>>
>>
>> IIUC, the problem does not exist if we only convert a single page at a
>> time.
>>
>> Is there a known use case where such partial conversions could happen?
> 
> I don't see such case yet. Actually, I'm trying to follow the behavior
> of KVM_SET_MEMORY_ATTRIBUTES ioctl during page conversion. In KVM, it
> doesn't reject the request if the whole range isn't in the opposite
> state. It just uses xa_store() to update it. Also, I don't see the spec
> says how to handle such case. To be robust, I just allow this special case.
> 
>>
>>> BTW, per the status/bitmap track, the virtio-mem also changes the bitmap
>>> after the plug/unplug notifier. This is the same, correct?
>> Right. But because we reject these partial requests, we don't have to
>> traverse the bitmap and could just adjust the bitmap operations.
> 
> Yes, If we treat it as a guest error/bug, we can adjust it.

Hi David, do you think which option is better? If prefer to reject the
partial requests, I'll change it in my next version.

> 
>>
> 


