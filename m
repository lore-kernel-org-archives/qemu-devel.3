Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3789C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 07:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPG6S-0008Q1-HI; Wed, 11 Jun 2025 03:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uPG6Q-0008PT-8p
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 03:42:30 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uPG6N-0004ux-Ve
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 03:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749627748; x=1781163748;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pZVFSLXe627U7OY5tP6GsMtgklTGbEl4shVasunwSAE=;
 b=NxPr+dGrHXYAHHqiNKAAuLqbO3Xw2C9L4bGwXePlWamsezGzahiNfeV7
 kSCmjJIrwFMoPyAzvVzSdFzlgnDTHwhx9rnJZJxfYRalKb11fYbDpEel6
 Ma4+4YfMKT7XpvfVovylUZn2LDIix11ZWUIgGoF/epdDQU4z1mYlWXJP1
 OJRYFSABZgCC3ULnPQz2MNnM3pFGYPwQNXk81afkhYaTqilPAU1nmXDN7
 IOcM+nE/BtEtz61N3jluDoKdGZbWTVpM2Yaj/ZgNXbgwsf+RDKqCdTp80
 rFhVSRmHQMfFlPpsf5GOLLM/inMVYAzE9oE9OWHnq6vwN7uHoUs4Rt0je w==;
X-CSE-ConnectionGUID: 1hvgal2hSKad+U3h+IYQjA==
X-CSE-MsgGUID: fizEgp97S5eae4fgPLe1IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="54389164"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="54389164"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2025 00:42:14 -0700
X-CSE-ConnectionGUID: d2oMckSjRjmINC7Hj0MrzQ==
X-CSE-MsgGUID: ekQFdWk8TeqBTMlo2uwV0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="150934179"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2025 00:42:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 00:42:06 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 11 Jun 2025 00:42:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.64)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 00:42:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhOO5WIyl/ysOrke8CSlFtzb2uqsy2ae1JyTP/B1IhniX6QZgHRZ2lFMMwjjDjnP37053psZ6Szyn7yOCrbsPgqIGEsvCld32chdXspVXp2gq0om7WqVREh5niWBF74UBMiSUkoI4kOjY68UZNxHlzVJaAnZLvs5PYKljQDiDqzGi1fJG/0BO03aB+IYlyWX/NmTKR/JtwwN6vIEgaaNFxxlA+qOfrxVxT2Sg+BdaKeHg/ZSDClDBJ3W1G8ah3cI2LfI/5FuDngEdFEu4w/IBbyjA1hyBIc3UBn7MDZXaw55ihFGHwt9Ph3NCFnSVClN/rJ+nFrqPx+CI/MQfx4PLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWzgiP5QPfTKcqpFuVyH1VTnTIY6a3g/iefeLIhpcYU=;
 b=myb4touC0n4de9e1IkJPaSrPqh4ch21FFrvTBdvkvNnSuo1zmqVjb6FqEyTtIH4rVgX8XcgUZZYJddfqQMAoezjL+8SLahuoybX575MP5YtTSSQJmfPr1EHV3wGzGPOXJk12tnBGP8ngIRnArO8W/1j4khLmJYQkbgKW6ijkpF6JHExz9v6s5DEEQ+A/Qupib7h86inPrh8iZCJjMbBcg3WzowDX4jdgI42cie6j3hrwWZJvcKSRVOze8jTbFuB0l+BTUI0bT5TUj+RSRY5LWI+uZ/XVmYufIzQPAq0U9Mn9Gzec/1f250dxR2XW2zANsPGKLhD8G2+U1o8wx9rZgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB6148.namprd11.prod.outlook.com (2603:10b6:208:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 11 Jun
 2025 07:42:04 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%7]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 07:42:04 +0000
Message-ID: <a36077a1-9eee-4c3b-9365-1b7a9dac3b41@intel.com>
Date: Wed, 11 Jun 2025 15:48:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/15] intel_iommu: Optimize context entry cache
 utilization
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20250606100416.346132-1-zhenzhong.duan@intel.com>
 <20250606100416.346132-3-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250606100416.346132-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0098.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::39) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA1PR11MB6148:EE_
X-MS-Office365-Filtering-Correlation-Id: cb1a224a-667d-418d-8aa4-08dda8bb758b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c01rdWpXYTVGL1hRYVNCNE5WYTQySHREeEVtOUhtVW9SUFcvU1Rua25ySGlW?=
 =?utf-8?B?c0hjYWJGM3k1Wmc4Q1ErVndoZXpLYU53bmRwUVY5QUNud0dxRjM2UzYzcGpr?=
 =?utf-8?B?L3BWaXFjNWdFejRvVU4zNDdHbzZPdXMrcUREdDlFUmxtaHNWeHc2NXRXd0E2?=
 =?utf-8?B?N0ptcm90VXlzb1JnRUhKR1VaL09RaFFabGkweHowc05PQnBDaFA1cUxMS1hU?=
 =?utf-8?B?UGhFeGdvQzVwb1dBZkxKUk9pZEtlZWNhbFo2eGYvajRvaTNXY291anhXbVpq?=
 =?utf-8?B?VkNWc3dRd3J6VFZzTWROZFU3OTB2YlR6OEVtUHEzbXVRYkZjbHB0bksvbHQv?=
 =?utf-8?B?ZC9lVUJUVjNWNXZYYjhkQmZkRDNsSmovWXNsMnJjODZjSHJpUUt3NTJQamRG?=
 =?utf-8?B?NGhzNjVTTG1uUnB2SzBFZzI3SjJVMjUyd1ZLSU5QeVJ3UEk0ZC9UaEJjR1Fz?=
 =?utf-8?B?eUFaemFMZDVTNGpmbDNzMlMyTldrdjUyVFl0RFkzcWZqdW5uaUlzR0hzN2VM?=
 =?utf-8?B?bkZPdGl5azhZMVgzUEZ3OFdNRDRqR1FWbm5YUnoyKy9lTnZZbjVZeld1dTR1?=
 =?utf-8?B?QjNuWkZ6ZnZ6RTVNTmJPZHZiL3dUSlhNeTBPK2hkV0VaalJwWWkyS3A3Wm5B?=
 =?utf-8?B?UHhJUW1Ldk9Bbi80dGpFMXBFREN4RllJRFV4Tis1MjNQemVCR3BTU0NEbklD?=
 =?utf-8?B?cW5IdWZyNHRnNVhCTXVRNFMxRlgybXNJb2xzNm9CNHhNVCtWOW92cnNaSStS?=
 =?utf-8?B?QnVINTZ5YnlrK3RSYnBIU1ZHM2dJMGZtM2VJbzZZell4VGY5WSt2eUs5ejl1?=
 =?utf-8?B?WlJkT3JJbEVody9BVnhzUXF3cjBDcmw2WlhRMlZycUdubkRzaytiYUF6Y3B5?=
 =?utf-8?B?b0h0ZVRKYWdod0N2SklMQWZjc0tRRDNueDNGUXlWUkg3dHkyVjkrbGx1eGlX?=
 =?utf-8?B?RWdKOE9NNnpvSUxDQzAzUCsrYlpPaDdRczlQYXNrVkpuNHF5cXQzdk9SWDVk?=
 =?utf-8?B?QzJ5aThWT3hxdXZEQzE4Qi9OWWFPS2NFcDdneWRJNVp6L2Y4Qk5mQWZLL1Rt?=
 =?utf-8?B?Nys4eHJZaXZJVmFadHRxTDF6M083T2VPM3BPNEJyMmE0dUI5bkN3NGp0ZlJF?=
 =?utf-8?B?azNwd1NDazk0WmRRL3MvTzJzMjUvTjBKSWVjUWhSdW8xZ3IxQnNPcTlINHQx?=
 =?utf-8?B?cUNZakovU1QzdWhOVi9pMExBT2pJSjVvM3V3Sm9jNTdEbEJSNWdBekFBd1pK?=
 =?utf-8?B?dG95VUVyd0thWlhhSjNOMmJqZVI0WU9SaGpmSXpkZVVNT2RwRkhPaG9sSGV3?=
 =?utf-8?B?c0kvQVNiTGtFVTFIaHdwYVpFa0ttYkNsRENOVjdPcTBvazVya3N5RS81RVhp?=
 =?utf-8?B?ZUdFcE5iUG1QaFNhdkdyUjluNHUwUXpXeGJvUzdSNGV4U1NXVHh4SWNZaktl?=
 =?utf-8?B?aUtNa3VPMVFxQURTWVhvTFdFZE0wcCtielF4OGhvMlJOR0UwTVp5a0RXQ0N3?=
 =?utf-8?B?VGpsaVZjZHpmK0laN1hOcVFHWm5OZ2podWgxcHdsUEZkRkd5a3RRTWdmRmYr?=
 =?utf-8?B?Myt6MHl3OXp0VmdYUVlrWGFNTXYvNGh5M3lOaEdXcE9ZRWNXaUpqZXhmWnpn?=
 =?utf-8?B?WnBIWkZrOWZWNlFzVVlNK3B5NFAxMmZqTENnL0htdW9pOEJEc042MWZ0d1Nw?=
 =?utf-8?B?NlFNSEdYcjV0b01Mem5HSnRFOVBCakVlN2FwWkZXc3Q1SmtvQlNZeVRDOTBv?=
 =?utf-8?B?ZUV1MEVIb09Jd1VQK0tjdFJZaWNXRjdlMkd0bzlNVjVjT2FKdDF1TTdWeXZP?=
 =?utf-8?B?clZuZEdWV1BCb2JMVWpJNUhzeDVacGsyTlJialE2aUR4TG5zb2RETHB1aFpF?=
 =?utf-8?B?b2FxVzd0eUNrZVJES3RCZ0VVTVN6bkQrNTFDdHYwSGRZM1RRZnVCL29CSmZE?=
 =?utf-8?Q?pc4VO4867EA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STZlRlFpNGtOdXZKK1ZVUUJJY091WncrTysvdkRjVGFJY1lIeGFUNnE3ZDl1?=
 =?utf-8?B?dlJWNS8vSmtYdWQrZHlSTHhMdDZMUGtzWTV1aDZ0SlltSSsvZDFYbUJxNUVD?=
 =?utf-8?B?b0RYeFNMVlpkRGw4TlFqeGphUWZ1czJRMWpUTy9SNk4rMDBTTDRqV2hKZ0or?=
 =?utf-8?B?MjZGTUxZbHRjelEra21iZDBzRnY4MUJjQnh2dy9GQW1JTWtuWHRjb3Y0L090?=
 =?utf-8?B?Wm9LalJDQnhrMzlUbjR3NkdtOW9rNld3UHVOZTV6MU9mVGFlWXBId0JXelp6?=
 =?utf-8?B?N3BUZTFCTzh3aWorNm1FRzBzT3phMEg2Z203OTRGb1c5TmpYNkpnR3V6WHhx?=
 =?utf-8?B?a0RCbUZXQm1GbERCZ1g1N1lQSythT0llRWk0NFJ3bEZLNFBSK1lCa2JlVVFq?=
 =?utf-8?B?bTQzOGlLZG84V29aclpPZGJkRlB1cUt3YzJwcHpYbnU1aGpuYWVBUmNvVEJO?=
 =?utf-8?B?ODMrMWNlQ09sSTZteWVKbnh6eUY3dURxSlZnZW5qVEozSXRRSlcyZ3EvSjFm?=
 =?utf-8?B?N0FrK0tYcDVrM20rMnJmNlA0cGUrUlF0ellicE1KdmlQRnAxcURmcWVsWlQw?=
 =?utf-8?B?Q3FNZzVXLzB0T0NMemhOcXhNSnprUWp4SEtjQXpibEhKYVIzRlBKRmhTdkFM?=
 =?utf-8?B?L3F6cVdyWnRIMnAzUElHMll6SkZWVys3OENLNk5SQ2kwYmFSUzN4UjRIQkZp?=
 =?utf-8?B?aVhBYVNzckpqb0hza3Q1ekpQemkwK1p1eDJkOUdSMWtKMVpISy9aTjBhdklD?=
 =?utf-8?B?VVc1RGpWT2pPdzE3b0FxMlg5cFpJUDdQaGNsbmVxTmtkRmJQWnJveDRoRndj?=
 =?utf-8?B?UFZjdElScHVsczlRL2VWdTdiaGYxNzJxYjBjMld2b2xFMXpLTmt1amdmeTh6?=
 =?utf-8?B?bjdlWmpGelhPdldKVzN4anMzY2hMVWZNdkdwUTlKQlVoL05qUlcwV01QVVBZ?=
 =?utf-8?B?M1drSVVQUVBXOU92MkdmQWtQRjVuUzVsV2NxeS9VcWlaMmJsd2E3VGRQQTNO?=
 =?utf-8?B?RlVnTGhNdi9uN3k2OGQzUnI4cVBMWUZKTGM5OFZUZkJrTGltaXhQSStQeVZi?=
 =?utf-8?B?aE82WmJZVlNPRmtuNHRuZEFLZ3pjZHk0ZUZUZGhNRGZ2UEJXczFXQUQ5cVJ3?=
 =?utf-8?B?ck1DQUhMeXNoalN2TTVPU0NHVThaRzFib1ZVT3dXZ29FdjhmRDI4UUxjWldt?=
 =?utf-8?B?OC9waGs5VVlBTzU2ZlcycjFCL0VVZk5QbUk3TlVKL3dxcXFkTkNtdE9reUVh?=
 =?utf-8?B?Ri93RitySkhiS3dxSmtKMUNUcUtXeWx0Um0xVmJnOXFJMmwxcWZkWk11ZDBK?=
 =?utf-8?B?RHFwREVaV2JJZkpnWWJnZjcxSmNBUHhuUzkvRkRLWHJVNWREMkNtNXFQL0V0?=
 =?utf-8?B?aFRQT21EWHV2aEUyNUhZb1dEd2o3aHlJMzU3SGk0WXZuSlE2MVNacFVGcVcx?=
 =?utf-8?B?cFF0OCt0THA2T21yVUlTazJXU2FwTmtZK3JGUHhYbnV3eW9oNkd3VU96L21n?=
 =?utf-8?B?S3N5VjB3R2JTblVtUmlnYmRkV1k4MzNSS05TSUpsbGUrSWdwMVZFekJkNFB6?=
 =?utf-8?B?NzNQT2Q3VWdnYkFtazZzSFJCRkkrM0RJVW9QaEF4SzBkbEZ3d2p3ZUN0RHpq?=
 =?utf-8?B?NlpoZEpJMzlPaDdjaCt6UVVYZmN3SHMzcVJyeWMzU2dvT0RjWG1sSUtxUTYx?=
 =?utf-8?B?ZzA2NG4xOHFYVEgrU0Fqck9sMjduS1RmWEo4NVNTdU9IMFozVnR2eFVDdzYx?=
 =?utf-8?B?Y1c4TStHVmZ4eUpGVUNMTjB3S3lVcFc2Q2dFVDNlZjBGenE2eVRsRG9BYWtB?=
 =?utf-8?B?MlUwaCsyaDJVSmFEZUd2ck5tWnNwNkx5NlJqRzNpemNNMU5QUVBoTTN6SWFV?=
 =?utf-8?B?eEVyOEF6ZVJUSk51cGlUSm9GRTZBVGppcXl6cTRoOHRzci96T1dMOVdBK1dm?=
 =?utf-8?B?WFdnb1ZTRGMrdm5hcGx2WWdOcSt0WnQ4Ulk5d2Y2RVowR05NYkFJS1hrS2VU?=
 =?utf-8?B?bzRlZWdocTVZYXpmLys5VkN4YzMxQVZ6cGp2eGZPVFVkWmxTMXhzLzRObmMx?=
 =?utf-8?B?bGNwbng5OHoxMWpmNnpoT1JKZUttcGhUc1JIQXFtUHJDR2VUN0ZMWWhPN0w2?=
 =?utf-8?Q?VuorDp7IijMFYHz/9oaK9jlgo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1a224a-667d-418d-8aa4-08dda8bb758b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 07:42:04.2242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DbWXrwElX1pJegtDCZhMVLkw4hEUQUbLb8nsror2ESNSOaJAgLpm5OD8iV0lKKFPVBp6rLoZwrznUD5gKWwMRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6148
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13; envelope-from=yi.l.liu@intel.com;
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

On 2025/6/6 18:04, Zhenzhong Duan wrote:
> There are many call sites referencing context entry by calling
> vtd_dev_to_context_entry() which will traverse the DMAR table.
> 
> In most cases we can use cached context entry in vtd_as->context_cache_entry
> except when its entry is stale. Currently only global and domain context
> invalidation stale it.
> 
> So introduce a helper function vtd_as_to_context_entry() to fetch from cache
> before trying with vtd_dev_to_context_entry().

The cached context entry is now protected by vtd_iommu_lock(). While not
all caller of vtd_dev_to_context_entry() are under this lock.

Also, the cached context entry is created in the translate path. IMHO,
this path is not supposed to be triggered for passthrough devices.
While this may need double check and may change in the future. But let's
see if any locking issue with the current code.

> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu.c | 36 +++++++++++++++++++++++-------------
>   1 file changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index f0b1f90eff..a2f3250724 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1597,6 +1597,22 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
>       return 0;
>   }
>   
> +static int vtd_as_to_context_entry(VTDAddressSpace *vtd_as, VTDContextEntry *ce)
> +{
> +    IntelIOMMUState *s = vtd_as->iommu_state;
> +    uint8_t bus_num = pci_bus_num(vtd_as->bus);
> +    uint8_t devfn = vtd_as->devfn;
> +    VTDContextCacheEntry *cc_entry = &vtd_as->context_cache_entry;
> +
> +    /* Try to fetch context-entry from cache first */
> +    if (cc_entry->context_cache_gen == s->context_cache_gen) {
> +        *ce = cc_entry->context_entry;
> +        return 0;
> +    } else {
> +        return vtd_dev_to_context_entry(s, bus_num, devfn, ce);
> +    }
> +}
> +
>   static int vtd_sync_shadow_page_hook(const IOMMUTLBEvent *event,
>                                        void *private)
>   {
> @@ -1649,9 +1665,7 @@ static int vtd_address_space_sync(VTDAddressSpace *vtd_as)
>           return 0;
>       }
>   
> -    ret = vtd_dev_to_context_entry(vtd_as->iommu_state,
> -                                   pci_bus_num(vtd_as->bus),
> -                                   vtd_as->devfn, &ce);
> +    ret = vtd_as_to_context_entry(vtd_as, &ce);
>       if (ret) {
>           if (ret == -VTD_FR_CONTEXT_ENTRY_P) {
>               /*
> @@ -1710,8 +1724,7 @@ static bool vtd_as_pt_enabled(VTDAddressSpace *as)
>       assert(as);
>   
>       s = as->iommu_state;
> -    if (vtd_dev_to_context_entry(s, pci_bus_num(as->bus), as->devfn,
> -                                 &ce)) {
> +    if (vtd_as_to_context_entry(as, &ce)) {
>           /*
>            * Possibly failed to parse the context entry for some reason
>            * (e.g., during init, or any guest configuration errors on
> @@ -2435,8 +2448,7 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
>       vtd_iommu_unlock(s);
>   
>       QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
> -        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
> -                                      vtd_as->devfn, &ce) &&
> +        if (!vtd_as_to_context_entry(vtd_as, &ce) &&

this one apparently is called out of lock.

>               domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
>               vtd_address_space_sync(vtd_as);
>           }
> @@ -2458,8 +2470,7 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
>       hwaddr size = (1 << am) * VTD_PAGE_SIZE;
>   
>       QLIST_FOREACH(vtd_as, &(s->vtd_as_with_notifiers), next) {
> -        ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
> -                                       vtd_as->devfn, &ce);
> +        ret = vtd_as_to_context_entry(vtd_as, &ce);
>           if (!ret && domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
>               uint32_t rid2pasid = PCI_NO_PASID;
>   
> @@ -2966,8 +2977,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>       vtd_iommu_unlock(s);
>   
>       QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
> -        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
> -                                      vtd_as->devfn, &ce) &&
> +        if (!vtd_as_to_context_entry(vtd_as, &ce) &&
>               domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
>               uint32_t rid2pasid = VTD_CE_GET_RID2PASID(&ce);
>   
> @@ -4146,7 +4156,7 @@ static void vtd_report_ir_illegal_access(VTDAddressSpace *vtd_as,
>       assert(vtd_as->pasid != PCI_NO_PASID);
>   
>       /* Try out best to fetch FPD, we can't do anything more */
> -    if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) == 0) {
> +    if (vtd_as_to_context_entry(vtd_as, &ce) == 0) {
>           is_fpd_set = ce.lo & VTD_CONTEXT_ENTRY_FPD;
>           if (!is_fpd_set && s->root_scalable) {
>               vtd_ce_get_pasid_fpd(s, &ce, &is_fpd_set, vtd_as->pasid);
> @@ -4506,7 +4516,7 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
>       /* replay is protected by BQL, page walk will re-setup it safely */
>       iova_tree_remove(vtd_as->iova_tree, map);
>   
> -    if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) == 0) {
> +    if (vtd_as_to_context_entry(vtd_as, &ce) == 0) {
>           trace_vtd_replay_ce_valid(s->root_scalable ? "scalable mode" :
>                                     "legacy mode",
>                                     bus_n, PCI_SLOT(vtd_as->devfn),

-- 
Regards,
Yi Liu

