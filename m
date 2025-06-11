Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0779EC677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 07:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPFgE-0005pN-Np; Wed, 11 Jun 2025 03:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uPFg1-0005oe-Fa
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 03:15:14 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uPFfy-0007Nk-Ku
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 03:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749626111; x=1781162111;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8QWaw+CGzLcLzCSljrthnqhTEpi+fO0ndf2jVLMaAdU=;
 b=QAlhBTOPZ0kIFqfFpSOmCG8I1w8rHivumyZ8aK39NuV/XL8s8ZCb1xeW
 zwfIrlAK+T0l1toTPYbLMpEv4DW6s0hLg5cR8/rfPUR7VcBjSCYTxdS1C
 Fm1ycArwk4cBQyYvgdsjmx3R8Ud0qJ1iSlF7tX+ioPTEUwrerGfm3ER9Z
 XLFgMdmXqoTTX7RxJfKR59GiFBxjycnI1kXuyT/DYE7rI6A1wN2cv8MpX
 Wo2J405xGr0drmaw9UlE1nJaFViXyDFYu5wB7ZZ2KYqz+Zru4O0SWtK24
 5uXB0o5xBVl2eqmOJYzP/BCXybfSozBARzjmrdOA0Q8uSM0xK+rvIK9td g==;
X-CSE-ConnectionGUID: BjUZrBLYQBCWeukGCEOodQ==
X-CSE-MsgGUID: siildlkyQfG/cj5z11ZTaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51673493"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="51673493"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2025 00:15:03 -0700
X-CSE-ConnectionGUID: bYkyoO+ZTKeWhfy+mf31fQ==
X-CSE-MsgGUID: ja/DomrRQkOMWFZDrCcczQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="147448709"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2025 00:15:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 00:15:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 11 Jun 2025 00:15:02 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.45)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 00:15:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRglHmz+F2K0/Gp3dfE2uyYGiNUkNqsmpm+OwJP+07M6PuceISL3oAi6OyuVQlpFhTmlXfomTaNwDbh5ZqO1DLfzczj0xteYmzLR1EE1xQRes5OU40w4EmYgcuJJ3Qd59pa4zieVXnclH2Gdq7QY0VMPFiMo6e0daIsZKS+a2IoRd02FwKO9k7XcgyKyE5aocopua0U5cvdyO/EM8kWVkoesZ/VJVsI0Ew9gvRTBKlQqTBW8GknVKRbcHc2BTuQOvSYJsN3Jh2VGsl0hIdS5S0QAp6BQqXKTWbHWDqodqBjS9P21/7nbV534uO6mSmSG6W55naSTuuoDdQQOPO6mXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZebrufnRgcpqjNh/yZoqUyoXM0ScH5FGza+IUuBQZ/4=;
 b=Xzhbk2joB36Oj4kkhPI2PZMWHfDD+TM/aVjh9Ws/v9Id2nUUn41Y/GXpXIAcTVjQCUdRVrkEN5927SUUqAGpierUwnA+AGLenDV6sv02A8zbO56xsavJUrWKLFG9q8ZnATDynWYU4ziz090pqtz5gml9n3DhZ64CtiJsb8SSpTD5h/5DyArn+4wEKGE8sXcDXTdmfsiedX/wV+hVI0xqHJLnGcnNrNWKWl85I7suHdnyQ7V3f7DyYUmshphQS/P8c/R/YOh/4NbhWiPN3NUw4qiAOdjOYB0DHLKaF/rN3BVLScihCIjhb7vqiI9V8K+Dq8/1TC/Pl9VXditVLub4Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by LV8PR11MB8557.namprd11.prod.outlook.com (2603:10b6:408:1e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Wed, 11 Jun
 2025 07:14:54 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%7]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 07:14:54 +0000
Message-ID: <b654e79f-c3b1-48a1-81cb-b4cdcbfe2a8d@intel.com>
Date: Wed, 11 Jun 2025 15:20:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/15] intel_iommu: Rename vtd_ce_get_rid2pasid_entry
 to vtd_ce_get_pasid_entry
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
 <20250606100416.346132-2-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250606100416.346132-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SYCPR01CA0017.ausprd01.prod.outlook.com
 (2603:10c6:10:31::29) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|LV8PR11MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: 00f64888-6040-49cb-135e-08dda8b7a9d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THpQaytKUWZaMG9TcFdmWW1sclJKM2ZYUVgyb1NZMFFrVGJvQkpYcHVwcFQ4?=
 =?utf-8?B?SFczQ2p3UUh0cWQ2cy9ZdWtYSmpFOUpZdEd5UjJETFV6RU1CSU9ENHFPVngy?=
 =?utf-8?B?Ky84TEVHNW5oSkJZL1JMaEVLUlRJSExvWEJ5RlRZbkNYN0hYV1hBY2MxT3dL?=
 =?utf-8?B?VFVSekxHQ0Q3NnVSVGRJS0JwZm5DMUIvYzVsenREc2dCWGgremZzK3FVTkFy?=
 =?utf-8?B?R3c0YkN4Z01rVnJJYXdCb1dvUlQrNFNuMm1LMFVKOHNmRnVoNVhIMVFGVUNO?=
 =?utf-8?B?YWIwUndQSXpvL1FjVTgwdDFQaW94MThMMHZCbjVHM085MG1NbVFRQ3prQ2Ji?=
 =?utf-8?B?dnYrTGI0dEF6UjVaY2owUEFkS1BtSVFiRjYxTHd4TlFPMjY3ak1VRnBMNmxM?=
 =?utf-8?B?YWpBblRSV3UrY3hjN3lFRUxGaE1CUTlxRFZpSFl6Q2pLMjdEQVJKUmRiendq?=
 =?utf-8?B?T2FscW9IVkRHUG9ZNGp5eWJFWjR0T01udHljRVhoT0xPTnA4T29tTjBCQXB1?=
 =?utf-8?B?OGRBSFBIRnFPS1l2SndoTVdkWVZlOHdKZm81UFU3R3oxcTVIRDlwa09lWDlZ?=
 =?utf-8?B?dFYyc3B0My9xNEVQQ1VrdFArRkJ5S0x6UjFMY2Vxd3ZRakNGdTR2K3plaEFz?=
 =?utf-8?B?TU9TOTl3dit6Z0hxRDRsR3BobEtvWm5JNnp6TnkwaERjUXNNejJ6S09wL3BP?=
 =?utf-8?B?TDJQRzVBc21aYUtYL2Nma090RlkzeWRWV21CRjYvNTJCQWVOTlk5azZUVkQr?=
 =?utf-8?B?cUJTNzZxRGE5Z0tOaE1sRm9ncGk3QkZHYW5sSFpLSXdaa1FMNTE5M3RFNzJn?=
 =?utf-8?B?YWFRSUpZSWEvREF1OXRWYnB3YmVMYU9jYWt3VGtCYTJ4aVNqRUIzcG00Mk5K?=
 =?utf-8?B?amlIK3FMZ01BdmRjaXZIY3FGSXdzYUlaY2pGMGJYSi9LRmZRbGNhd3lKaXNQ?=
 =?utf-8?B?ejVxcUswUUtiS2FoRVNkdGYzNXZzSXdTRExJNHp3STNUb3FDMVh0dSs3Si81?=
 =?utf-8?B?b2VEeUE3MktaT2FQYU8zQWJrRmp5cWc0ck44U0wva1NDanBMcEJBenIvR2kw?=
 =?utf-8?B?eGVvMldIS3VRRjZlVno5QytPVXlISDVMOGt0amJRQUVQcjhhdVJZNG8yNmpk?=
 =?utf-8?B?WVprMG40S25yRUNTRWNHbXRXNTFHQmJGZ3hOUDRMOWJWeVU0c3F1WExVTUlX?=
 =?utf-8?B?WXppMVV2b1NTM1lFNUphVkxLY0NXa0ZvRlNlNlFOR3VtbEVkdXo0T0tzM3dH?=
 =?utf-8?B?RHFFYmFjVlp2aW1nSHRVL2ZXQlczcCs3RkIycVo5V1FVMTF1dkFPMFErTWJO?=
 =?utf-8?B?Ykg0N0dKY2NDMmxjbUl3dmNxeEZGanFScHltamlHMENQa2h5d3IwdHBMcmg1?=
 =?utf-8?B?Yjlwd3M3Smova0UxOEtxaUROczhLMnJyM1lhM0FCaEtuaHZDd3E0dDkwaVZD?=
 =?utf-8?B?S0Vjck05K1BJVHM4VENaVGlYbVJxbkE5TzdPbWR1RitBL1IwVElZcDY5eXhC?=
 =?utf-8?B?SWZKZ1ZIUlgrUWJaVjJXVjh5dWhCY216eVZ3ajhscjV5bkZ4Q1c0cy92NmZt?=
 =?utf-8?B?eDhUSlNNMEoxYjIwdlI5TGhLd2xlejQ2eEx5WGJ0QS9JOTZBMWVJeThUVFhk?=
 =?utf-8?B?ZG5rSG9QYk94L00vRGVMUDQxdS94OFJDSVNvSmdWYTREdkYxYVYrOVJaYnZT?=
 =?utf-8?B?dHltS0lXNGNtNGduK3o3K0ZkTHdxRUYzUUpDYmprclJJRlNVSy9UeEN6TTdo?=
 =?utf-8?B?SldSUDZBdkxQQUkxNVBucEs1aXFOT29aTjFGSms2a0g5NUVEeGJydnZ3VU1q?=
 =?utf-8?B?NFJRWjNTWDE3QWhFTmowLzhBTHZ5R2ZIMmZLVmdkcTVWT2NFZjVnelo2YmJt?=
 =?utf-8?B?cHFoRkpab09vMFFud1RMUmJyWGIzMTRIZ3hSeXBXcEdXS1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUxTbC9aUHZobFdLZVFkVGY0TlkvakdBbWg1ODRqSW83M0dmOThjclRqM2hL?=
 =?utf-8?B?ZEtIMUZnaGsxWnNPNFVwcmJwQktqVHdreEN1S0FuUElyQnByZS8rU2ExREk0?=
 =?utf-8?B?L3pLSXFnaWhJVUpqNVBaUVFxdEc2MGNmdTk1Q1VLSml1RWpEeUlZOEltTGZV?=
 =?utf-8?B?dWd4Y0tGdjlRUlhhL3dZVVE3aUZjS3lDYkx1a0dtYnNuRlcxeDNVaVNiZnBC?=
 =?utf-8?B?UXEwaFpOVEk2NkI5b2tkcE5HUVNxeGcyYnVwNmNlRzFqTkZRSHU1OTAzZUQ1?=
 =?utf-8?B?MkxoNzh4anFlTDVTWVU4eThGZnJBak9pZ21wcnAvUmdSUkM2QWc2VDZVSGhR?=
 =?utf-8?B?eU5nTUs4Q2ExK2ZQdFpaYnNGZ3crRGc4dElxRnZzc3dZV2o4MllCejFiTmgv?=
 =?utf-8?B?NVFjLzg1N09sNW4wb1kwbk1BTUtJUzIwWUZzZUdWVG8vM2crT21oVFFmSTUx?=
 =?utf-8?B?U01ocy9hVFFlOENqUzR2OVR0ajYxdUk5aUMvcUd2THMyTHlaK28vYmUyemlo?=
 =?utf-8?B?RWlRK1dUQlpFb1V3Sm1GaXJjdE9QakpXYXF1emVxUXg4dFhDK01qZmVPa29H?=
 =?utf-8?B?ZTdKMUlxNWtuWUxEbEtBTjl6RjNlN2REV2c5SjRKeWplNjVzcWdNSVE0Yzdt?=
 =?utf-8?B?VUlWb2o2MjNPdG5SMDlIT210VFRZa29EUlYxUWpydy80b1FIWWorZTVadndI?=
 =?utf-8?B?R0FQcldISEVPNmJ4KzN3QXJjMmFXVWN2Z2pyL29senFMamlSamVFUWo3L0lm?=
 =?utf-8?B?WFFGdWtKWVYwNDVNelNkOU14ZVBHeHhhTURBaTZpeVNTWURXbFJrVlpYQ0dH?=
 =?utf-8?B?ZmJsZS8vSy9IQ2N6aytpSTYvZEJ5T1F2dEVKS2hETXZlaytSVWlzTWFDLzl4?=
 =?utf-8?B?cTdISVdINXpSTjhlWVZESUNPRGh4azgrR3hpTit6UDVDQkMrQ2ltbkJEYzE0?=
 =?utf-8?B?SFVnTk9sbVlzSUFtb01sNlc0OXVlaDB4SFNRaGdiV2hxckQrSWlJTVlSb0J0?=
 =?utf-8?B?d0dEandYZnlmVXhzZjBGd2JoYWlpYXpXd1FVV2N3ajMwdWpvaEpicmFlbG4r?=
 =?utf-8?B?N2g1QS9nSEowMmhvMld3VTY4V2xKT1BEbW1LZklWVEJPMUtaT2drelp0dm9F?=
 =?utf-8?B?cUxnSmFYRWRaRG5CTEJPcFlTUmI4WWdzSHZxdlppWEdWNDBOQ0FjNjFKSkRG?=
 =?utf-8?B?L3F5aSt0cmZPR1NKUjE1bGtqWjlFWnVoam94MENKOWZKZHdiSHlMVjcrQmVl?=
 =?utf-8?B?cDJSdWQwTnNTSW1kNU5RSVlPeTBUNTBxL3lOaGJKZW9UQ2xGd0svUHFGcmJZ?=
 =?utf-8?B?RGxTWVJhRlorQkNRUUFyQkFubTVqRVh4WUJ1S0kwNW96M0xkY3FYREFLR0ZT?=
 =?utf-8?B?NDErbmZuZyt4UnExcllEU1RiR3ZmSnlGQU5CVHFUUzdiRkRoQTRBVWZGaTZj?=
 =?utf-8?B?MzFRYVN4RFp5MWlWMkJNUHJrbk5pbGp5NXE1M05aeStPNGJ2VlFIa1FkOSsx?=
 =?utf-8?B?V05Jd3Jsanc0S01nT0Q3MmdJSUMvRitqQXBIblZ0cGhDTk45L0xpL3FiS1hh?=
 =?utf-8?B?Q3ZmT0srUUl6WVc0TmV2cHRIVS9vRHF2cVpNMWRXTEk0NmU4VW9Wb1k5aVQz?=
 =?utf-8?B?SFVCY245R0JGSXpEb2xkQVFXNG5hODlSaXFOcW55Slh4UnQ4U2tOeFRrN1hl?=
 =?utf-8?B?S3NOejcyNUJlSjRDeER6R2sxRjhiMU4xaTM4OFhrUnJiU1ZyYzZiZUlDUTJy?=
 =?utf-8?B?cWtPU3hPZ3FLQ2t2VzRGQUtXdDdGTWdNa3RyTy9nUnRwL3hJWnBmWFpNd1BB?=
 =?utf-8?B?bS9RY1VPMDVOT0ZvdTArRGxadE44N2N2UHJEZW9PTTdMYldlbkZYbkV2dCtM?=
 =?utf-8?B?RVQreHBOK2NFYUQxTHF6Znc4eE5sSWZpbXA4NXdFNnFRd29ueVgvWi9FQmNV?=
 =?utf-8?B?cE1wbHpEclJrUHY2UHY0cEtNSWEzMVNNbEtoS2NwTzRNVSs2U2pwY3V2U09V?=
 =?utf-8?B?RWtKV1J4a2c1aU5sMFVjbUxKakhYN2xuMUdYYTRqWUVwRS9BZTU2T3dvaXdN?=
 =?utf-8?B?RmpIdE5Rclh2cVZIU0JJUFI2NmxyNkh2UGhkVmFQVUJsdlJKNlhvQWt0bTI3?=
 =?utf-8?Q?6ChbVRLyvhTnL+3yX7Iy2aOQi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f64888-6040-49cb-135e-08dda8b7a9d6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 07:14:54.2020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5aqEATQl2Ae3Lw5mAiGqsmEwLWK2v12pL2IsKAuR1q00/SGLJ2MB+1899GxSIWTt+VKDOTuvhnVbh/j+ZfQKRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8557
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17; envelope-from=yi.l.liu@intel.com;
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
> In early days vtd_ce_get_rid2pasid_entry() was used to get pasid entry
> of rid2pasid, then it was extended to get any pasid entry. So a new name
> vtd_ce_get_pasid_entry is better to match what it actually does.
> 
> No functional change intended.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
> ---
>   hw/i386/intel_iommu.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 69d72ad35c..f0b1f90eff 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -944,7 +944,7 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
>       return 0;
>   }
>   
> -static int vtd_ce_get_rid2pasid_entry(IntelIOMMUState *s,
> +static int vtd_ce_get_pasid_entry(IntelIOMMUState *s,
>                                         VTDContextEntry *ce,
>                                         VTDPASIDEntry *pe,
>                                         uint32_t pasid)
> @@ -1025,7 +1025,7 @@ static uint32_t vtd_get_iova_level(IntelIOMMUState *s,
>       VTDPASIDEntry pe;
>   
>       if (s->root_scalable) {
> -        vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
> +        vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
>           if (s->flts) {
>               return VTD_PE_GET_FL_LEVEL(&pe);
>           } else {
> @@ -1048,7 +1048,7 @@ static uint32_t vtd_get_iova_agaw(IntelIOMMUState *s,
>       VTDPASIDEntry pe;
>   
>       if (s->root_scalable) {
> -        vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
> +        vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
>           return 30 + ((pe.val[0] >> 2) & VTD_SM_PASID_ENTRY_AW) * 9;
>       }
>   
> @@ -1116,7 +1116,7 @@ static dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
>       VTDPASIDEntry pe;
>   
>       if (s->root_scalable) {
> -        vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
> +        vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
>           if (s->flts) {
>               return pe.val[2] & VTD_SM_PASID_ENTRY_FLPTPTR;
>           } else {
> @@ -1522,7 +1522,7 @@ static int vtd_ce_rid2pasid_check(IntelIOMMUState *s,
>        * has valid rid2pasid setting, which includes valid
>        * rid2pasid field and corresponding pasid entry setting
>        */
> -    return vtd_ce_get_rid2pasid_entry(s, ce, &pe, PCI_NO_PASID);
> +    return vtd_ce_get_pasid_entry(s, ce, &pe, PCI_NO_PASID);
>   }
>   
>   /* Map a device to its corresponding domain (context-entry) */
> @@ -1611,7 +1611,7 @@ static uint16_t vtd_get_domain_id(IntelIOMMUState *s,
>       VTDPASIDEntry pe;
>   
>       if (s->root_scalable) {
> -        vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
> +        vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
>           return VTD_SM_PASID_ENTRY_DID(pe.val[1]);
>       }
>   
> @@ -1687,7 +1687,7 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
>       int ret;
>   
>       if (s->root_scalable) {
> -        ret = vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
> +        ret = vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
>           if (ret) {
>               /*
>                * This error is guest triggerable. We should assumt PT

a typo. not related to this patch though.

-- 
Regards,
Yi Liu

