Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49DCC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 06:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR41w-0002UJ-L1; Tue, 09 Jul 2024 02:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sR41u-0002M0-N3
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:08:46 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sR41r-00067d-MT
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720505325; x=1752041325;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7GNOPT7SDxKhM/4LS6d4MaUKfS2Brsn+EjAwge9ejOU=;
 b=j91XqCnw3NllbTmJoz7E1Ytl5J5GZM5NEh/hXYxmbEm6IXCS/8T2RHtZ
 ysFOd95Ef5hXBrJINDlr58eSKhfMuwmi05U248fD/YNVWdck5ma+SsKPk
 rA0gzKpWTOgp8EUXl4qEFRB15nur+QpJwhfmKfmQFW1OpH74RpU5DhPOX
 He6c9rkWruYUXFr+++rGo/6TUZE/3XSz55Ky1ksGA8/EISrTPFRdrF/2q
 3vrIK2fn0rHFvtI5/DYvLtM1lqWcOYkFIbclovgqMJS2qq6nUyilhIK1W
 GVQrKjOvrb9CGXqloPWZrmQTGv4Knp/JkxYbNUL6xjZQ1PCIXRGYUPwUp w==;
X-CSE-ConnectionGUID: oJyKbc6rSOeDveAzqxUrmw==
X-CSE-MsgGUID: +2+cfFIuRhW1rWwqWaya+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17442797"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; d="scan'208";a="17442797"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2024 23:08:33 -0700
X-CSE-ConnectionGUID: ukXB5JEXTfesvuhPpYtn+A==
X-CSE-MsgGUID: ks32rFuiSRKKEc4NVcK7IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; d="scan'208";a="85284578"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Jul 2024 23:08:33 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 23:08:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 23:08:32 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 23:08:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKuxLRvEbUOoepgP7yrWP9l7L1Ukyz4MaE8ps3br9FWR5Q1SVLSaHi+gC+e/NV4yJIC3PfmPNZ75XvkyHEgykI2QFKBSAqJ9VrPhVRRelXZxAg1lC1trX6PbeeYfFgNLxS7NNx7s7oo7QHZNviH4JFrm/yrbGOsmiS23jfUI87h9Wu9h+No896cO9JC6y8mjE4DqmsMI4T4uIH129kaP6hPxRO483yn32GrF1BpiHa/ai9avFCFbwwE1j/TdiCix+XTsPs4j8MqhBEQ1Ouzl1TYkFwpalL3hgwnXrFabPCTWQL44iXbqlDlNlggox0AoLqcDCbkN+G2C3HkmaFJAeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mseredx+LBGS64jrQosFgIsgAPcrHKbEYjig20YBQlE=;
 b=XyuEsJv+Qha/+zgVCPuC4ryNM7ofIsoj4MCpqe4kWPQXikw+nMDGpPqAez5j3mGRQjELDslmRdhkqHBXKJMSbFtm6fzZJlbE/C9Dn6W0Lnlye39OuvNRDd/8NPYWqV0vdupKP0AhCa40LI/GjRT51IAvweg4dVRcLN99z2RWZ2d/zO8/YLi/S4KHyZDwKQdnxPKp/5jhrIA1MzDxFe6cczn+eJk3/Yochfn8TEvSgvCcNyfGzP6P7oU6ff+wkLikCxc08OXkyaV9s1K7hl6SgpclAzUDfCh+ldAY7RkJAgQEd6yduQv/7BS9yGcrRtzluKnUccVeCN9vIgp82JaI2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 06:08:30 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 06:08:30 +0000
Message-ID: <ede5f232-78b6-4a2e-b61a-ff2b56bd2ca5@intel.com>
Date: Tue, 9 Jul 2024 14:12:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] intel_iommu: fix FRCD construction macro
To: Jason Wang <jasowang@redhat.com>
CC: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
References: <20240705105937.1630829-1-clement.mathieu--drif@eviden.com>
 <20240705105937.1630829-2-clement.mathieu--drif@eviden.com>
 <c8bd5b18-9e49-44f1-a1d3-05bd02a91bc5@intel.com>
 <CACGkMEvwBvjRQ5tpJLCHRfL6FRQHEGrT+FD2v1GpAmt5EGJzhQ@mail.gmail.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <CACGkMEvwBvjRQ5tpJLCHRfL6FRQHEGrT+FD2v1GpAmt5EGJzhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA1PR11MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e5be16-4b7f-4e19-2b06-08dc9fdd8def
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnVtazBPRFQxT2IzUURmM1NKUWFpLzErS2tOa3RoZ3ZYc3BpQ2tjeUp4VHFW?=
 =?utf-8?B?QkJWQlRSNkpwUkVqdjdTUnlaakZpM1haSFlrRWMrYXQxWXJOMjJZczFKZUxD?=
 =?utf-8?B?UVpEZDEvY0dkZzdZT1doNzNLZnF2N2RMWjk5VytIb2VZcnI2ekp6S0VrOEta?=
 =?utf-8?B?V3ZSZllMaXJtQVF4ck1yZ3RNZUdHR0NKMktwbFRaVHZsN1k3bXAxQWV6NXdY?=
 =?utf-8?B?ejN4VXhXS2VsRWQ3OHRnbHNIYWJVZGJIWFRxZEZjVGlJVkdiYTNXT2FVdDRJ?=
 =?utf-8?B?MS9MYUtienRUMVJ1WDVuRHpNV2RRM1J1MUVkZXBtTVN2S2FvYWZpVXBMTWVh?=
 =?utf-8?B?UVdDaHBFbHNCUWZKeWFHYjZmVjRiMmFJOXlpazVCMGQzOHBoenlpV2JiSjhw?=
 =?utf-8?B?b0o5ZUFYTy95U2dqMlh6QUk2c2RVSG13ODFna3ducUk2WW9sdXdkbnZoN2pV?=
 =?utf-8?B?RFRuSGpmQ0ZBMnh3a0kyY3lIbXJKZjU2NzdVVG9sSDdMZlYrYmYwby9vRE8z?=
 =?utf-8?B?MVYxSlVSYmNFUUNkcnI1Vy9uLzdWNmxhQjBQT1BxWnRtMG1DYmVrUUJaSHRs?=
 =?utf-8?B?dVRHaDJzd2NURWpTQ0EyUXpMN1dyK2lCZVZmcnQ2MFFGZFNzQWNycXRsSmNE?=
 =?utf-8?B?ODBDM0VGVnZOU215dFAwZHN4U1RTaWtid2Uvc1JQZ2NseHgyUm5oYjI4T2Zl?=
 =?utf-8?B?ZFNjcmZVWE9vRVR4cTVROWVRTmxzVDFoeUVpTkRtbE4rZFRKbytGdGR6QStn?=
 =?utf-8?B?RGk0TVhsRS9WSUw3c0k2WmM4bnlHeHFab2VtSEV2ekExc2pWcElHWnA0NG5N?=
 =?utf-8?B?emEvbm83ckZMb1R3WnN4S3BWVEZwVFA0ZEtiS09sR1B6TDRLZXEvSDJGejNa?=
 =?utf-8?B?TDl6c0FRMEVrN0ZtSzlOYnlnOTNtOFpSblIrQlh0LzhLTjZsVU5GVFlpN1Jx?=
 =?utf-8?B?YjFmY0l2ZFJldkYyNC8zQk1iOVkvdEhhZkVNOWVlbFlLTmpaQWxJaW5sK1pi?=
 =?utf-8?B?VU9nWEEvZldZZ1lQZlhacXRlVXdrdDZ5T1h3WStvUVNzSWg4dDNianFMQzhB?=
 =?utf-8?B?UTlCTVhJZ2paT21nYUhOQnhld3J3cEJrV0VLUjQvSzFsNG56UHVOWmFoZTU3?=
 =?utf-8?B?bWRHYmloUEE0d3cwc0ZRMERYZlByNFpIMTU0ZERmcDVNd0dDWXBpMVZIOVV5?=
 =?utf-8?B?NkdkSy8ra0lyQmZqSE02eDBVTi95d0JsYUw4WTdUTXBTZGhHa25LaU1Tcks5?=
 =?utf-8?B?VVNIUUNFYXFzTjdPYU4rc3Bxa0d3cldsMW9RSG9IYXpmUVlObGNRdVFQM1VU?=
 =?utf-8?B?RE1PVWl0TGh6cFdmVm1rME96RlZXRC9jeWtyaG1XNWtSYk1yUG1RSVh0b1Ey?=
 =?utf-8?B?b2Y4ZHdmU2RrUld6ekFZMVF5RmtUZHFLelc2L0xzSTROOXhiTFZNaVdaUWNq?=
 =?utf-8?B?KzBvNFRYMHlya3JtYXdDU29NOWd2TmtHakpTQ0xaa0tXczNlVFNBVXFhaDhC?=
 =?utf-8?B?eE4rdE5OUGRnU1BaRE5XRzdyR25WSXFyMm45a3djNko3RHNlazBiV1psRWtz?=
 =?utf-8?B?OFVDNWlBY3AzMmVFUUp2NHh5cU12ZFlWUDFFWVZEQWhFMFZrNUwwTE5icDdQ?=
 =?utf-8?B?eXZjaEg1RjR4R2JXNElsYng3TmVwN1dkK3JZN25YSGJ5REJ1S1dLb2ZsWEhW?=
 =?utf-8?B?bGY1L1drT3lsenBhcmhzU2hiMDk1MEVUa3BLZmJUa1p4VnN2VkJXblk4UFJh?=
 =?utf-8?B?NkY4REVYVmtVb0tNT1ZNVCtNNTZRdFJwcUhQazBCUXJpbll2K2lqdFlZRHpa?=
 =?utf-8?B?ZWRZQ21tRzR0cmc2NVBHZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWxzSUozWC9ZNnhvRUxteDFJVkF6akFnRHErbEsrRzY5VmVPTUZhTDhMd1Rn?=
 =?utf-8?B?ckZmY0pBNytxWlE3QWZNT1NkOGZuMWtnR2RzZlloeGNhMEFvZG1GeFJZd2pJ?=
 =?utf-8?B?bVhOWUZkc2x3KzMvZnpDanJFdEJTVmZTLy9sZmlaLzNZelJTSVNuN3Y2V2Rq?=
 =?utf-8?B?UWYwUVBIOUE1V01lTytFckg4KzFuazBGdlNGV25OR01GMGNkcldOcGZkbDBD?=
 =?utf-8?B?dFY1S1JPZEh3MTFzY2R6ODh4MURnMTExRy9aMTkwVXhwN3M1UldLMDJLeW9q?=
 =?utf-8?B?T3g4Z0JGYktMRVNmQWdXSURxcktKWmxwNVlsMkJqZDJwMG1Sd3A5R0UxamVk?=
 =?utf-8?B?eDRZTXJXa00zaWk4QUppZklwOHQ2WWtjN3FLS3lWYk9qaTZiZXBqVVFJVys2?=
 =?utf-8?B?YlREMGt6YmRKTXo4cmhtV3pMZ1puYjJhRWg1WXBlUkM1c3FFVFNBeUJMcFQ0?=
 =?utf-8?B?Wk8zbS90alFYejNVQjQ2RTN6Rmd0QU1sdGUzUFdZTDd1UVpDYkpvWTB4bk45?=
 =?utf-8?B?aHRBOTU5aHdZc3MzZUdZYnFGSEdBQ0lpVzRNcTNXamNpcnJUdXUwa0U1M2M2?=
 =?utf-8?B?eHROT1BlTndONkQwL2dkS3NNRktnaG9hb1BLMTU4djdZbkdEWkpvUUFEek0w?=
 =?utf-8?B?Z2gzWllyUE56dmdyK2hRemdha3VjYy92SlNucHlrbWVJZUNheG1wNFdrb2hI?=
 =?utf-8?B?UkFYSHBvQW85YytTUWVCclJYRC9oeU9SeitjcXB0alNrUG41QkYxeDVQSFBh?=
 =?utf-8?B?K2FMQ0UwRFJUcmlhbTY2a3VIMFNWUDU5NXFxV3E0VkJ1K2VRNVpqTjNIejVQ?=
 =?utf-8?B?WSt5U25nd3RiUXZXdlZWNmsyS001U2JQVUY4OFhnVW5MWVhLRGFWZ01mS0Z3?=
 =?utf-8?B?YTAvd0pTaE9aN04xbkpvdnAvZWlEQkprNDJqMTdJaTArTTNTWjR1K1g5a2lJ?=
 =?utf-8?B?c1ArT2tORVl0Qkg0WG04U096eFI3eHBna2FFa2dhaHk3TmcvWmxTNTZRVnVm?=
 =?utf-8?B?ZU9BdzUxUkZqbUp6Y1FjU3lkck5kNGYrVVN3NVlwK0dNVlZQZEx4cVRraVc0?=
 =?utf-8?B?c1krQm95UGJIL2lGMXJpVXVuUUw5dG4wS3Zla3FsL0ZFK0svRjM0UXl2VkV1?=
 =?utf-8?B?UzE1Zzg2ZzVXTld5UnFMK0MzYmdJVWFreFRDTUcvMVRxTzJZY1oxN1E0bUo4?=
 =?utf-8?B?enprZUJZOC9SY3VRVnpHY0RVYWl2K3BER25NUStlRHZEaWI0MjNrakQ5UktB?=
 =?utf-8?B?Z1Fwamo0REdxMENvRitUNTBuT0JXL1BROVljcmZobHRuVCtjZFRqeWt4WVJp?=
 =?utf-8?B?TUJKWXhtMUo5VkNxdDJBWm1uenN3ZXdUZ2JBRjE1bWt5Qk5QQ0hiNkZWTkFa?=
 =?utf-8?B?ZCtXcERQVGlvVlUvT1doOWVrN2tmQVBpaFdraWl2OXFUZ3NuNE5vT3pqUXZp?=
 =?utf-8?B?UDViWk1rSGJtalVxaGRHNHVIbjgzRmlzeFFaZTVyWlM5MGZNNXcwNHRZemtL?=
 =?utf-8?B?SjNIa21wQkczNTRXYjR6MG04M1hWRG9veHB0UnhObGVCeTVhdVVYWE5DVnBa?=
 =?utf-8?B?MzdxVlk2TGkvMkNqRHdqNDVFcFY3b1BuNkVCQTF1QWFXVHlEOFg5eUE3ZXBv?=
 =?utf-8?B?YmZyVXJMQmhjcDlzWUYrZTU3Z2RZM1JKWWVCa2JFNkpGaUNzSlBhaXJ3UnpR?=
 =?utf-8?B?MVpTZGZtaFlLdnFUTVdueDRiNmdaTllNWkZ4bU9YZGRGRi9mMW9xNkgvT1pm?=
 =?utf-8?B?YWlpOWNqMS9sR1pIMTN5ZWUwL2oxbEhNNDkwYkhGTlhLL3RUQlJISk1mOWQ2?=
 =?utf-8?B?YkQ2Sm1URFRXSDVqQXQvbS9aQWQvYTE3YlF6dzJFN3dOc3dpOGttR3dBNHcx?=
 =?utf-8?B?ZXRGY2IyUGYySzZzeUt0R1VIN2dyNUluRzd5N2hKMnRkazgyamVIN09TMUhD?=
 =?utf-8?B?QkJkRCtxRjF2VDBEYjY2OUkrd1IwTCt4NDR6R2drQ3B2cVQ5anhqWEY1cUV5?=
 =?utf-8?B?eGVrcGpLU0w0aFF4Z3B0bCtjZEZlTElYcXVMOG03MlRRYnQzeXBTQXNpdDc5?=
 =?utf-8?B?S0FuN2RoRStGUFRNLzE0dDhDYUZUdzdjSTRBYjVMWDV4dDNCRFg2L3AwQWtx?=
 =?utf-8?Q?yqTDsYGHNOKJm9AOgk0gbRWze?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e5be16-4b7f-4e19-2b06-08dc9fdd8def
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 06:08:30.0281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8rhcgRmmnQJb7zdNLoASl4qgLw/pQwtTxYJc4E5C82I/cpS+2f/7yg8Mrln0+IxsPTK1W1mFp51+DuSaM1D77Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7198
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 2024/7/9 10:51, Jason Wang wrote:
> On Mon, Jul 8, 2024 at 3:04 PM Yi Liu <yi.l.liu@intel.com> wrote:
>>
>> On 2024/7/5 19:01, CLEMENT MATHIEU--DRIF wrote:
>>> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
>>>
>>> The constant must be unsigned, otherwise the two's complement
>>> overrides the other fields when a PASID is present.
>>>
>>> Fixes: 1b2b12376c8a ("intel-iommu: PASID support")
>>>
>>
>> The extra line behind the "Fixes tag" is not needed.
>>
>>> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
>>> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
>>> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    hw/i386/intel_iommu_internal.h | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
>>> index f8cf99bddf..cbc4030031 100644
>>> --- a/hw/i386/intel_iommu_internal.h
>>> +++ b/hw/i386/intel_iommu_internal.h
>>> @@ -267,7 +267,7 @@
>>>    /* For the low 64-bit of 128-bit */
>>>    #define VTD_FRCD_FI(val)        ((val) & ~0xfffULL)
>>>    #define VTD_FRCD_PV(val)        (((val) & 0xffffULL) << 40)
>>> -#define VTD_FRCD_PP(val)        (((val) & 0x1) << 31)
>>> +#define VTD_FRCD_PP(val)        (((val) & 0x1ULL) << 31)
>>>    #define VTD_FRCD_IR_IDX(val)    (((val) & 0xffffULL) << 48)
>>>
>>>    /* DMA Remapping Fault Conditions */
>>
>> It might be fine to squash patch 02 of this series into this one. @Jason?
> 
> Not sure, we may need this for -stable. So having a standalone patch
> doesn't hurt.

I see. :)

-- 
Regards,
Yi Liu

