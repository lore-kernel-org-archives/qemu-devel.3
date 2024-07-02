Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47C3C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 13:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOdN7-0007je-Ck; Tue, 02 Jul 2024 09:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sOdN5-0007dX-97
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 09:16:36 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sOdN1-0006a8-PZ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 09:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719926192; x=1751462192;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mvCvUxRkdRbNGCjjesoJdnMYpvIA6OmPkpm2HiVGBQ4=;
 b=co7q2xp+s9OnxtjOMvji6Do1cTyCIaiKcmYcRTomDArjSZxcbKKcZ4Pz
 vWCk5uhR2iu4drSSRu/UG5v/h95bDBHwJYVgqHED1RpIV5da6X5V7mSqp
 L6e5pnhEoO7c+OJub7s5TjNzppWOU8Ts6RNrtbDUyjmpEQDiZKmghrsv8
 xBRHKfYz2T6iIE74KasHeNY/JNXX9cCupY1O+UqY1fwV+wCTvX+L2+3hB
 rgT6xBp/h8638ljc/M+QnD/d1CMaoPpWSwLUd231NGnRMcBgFCSsrsEa7
 ntt85rGfLyBIteec8BwVHbo8twJ/QYoSYKFDqazFP0vOVssNC9reuddWO g==;
X-CSE-ConnectionGUID: Wl1MqcB5QsWRR8z202RCWw==
X-CSE-MsgGUID: cLpedPHaQUqn2us/zNcl/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17222217"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; d="scan'208";a="17222217"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 06:16:29 -0700
X-CSE-ConnectionGUID: Am9CpdPbTluaUPIXTHUTFg==
X-CSE-MsgGUID: 9b3xazC5QimJbaxX75homA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; d="scan'208";a="50517886"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 02 Jul 2024 06:16:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 06:16:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 06:16:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 06:16:27 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 06:16:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOEYEc/FNsvG7odHo1TYg86RsJlwVGU/ILNDxs3vGWtMqIG1KX5lFqpbBDE/a8ljhIPfXMq1cDLjJc5WyN6KRNMeYqxRz32THsmgP4JNWgt9jwkNx0iKjg2l0+0mnfJKmHXRtRKWmK8LAfpU3j+QA0GT69W2TWFIxhgr+hsN0tzdskWbfvOSbaQQ32zEWU9NB1yZND1vrac3kkJ/fLIkbndjl+uN/1kJBcsD8SjAOkW/3r5VAKmQMbk7zkYsarlFIYp5RP0fb33tdMaRODG1ISAUVGRxvLmQ+1xnXe80PtTgzFPjQNWRTbb+RHe55tCDQjfu/+FnVWEybXditTmSKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4T9d+Zx5v3kwEKSk4JInZyLaS/7C9VHqJ+yZscbGIQ=;
 b=kNJ3bGRD6HEqpjcW17Ece8jfdcFQcmhV7e3sGaRPH9sju45JglXPTXgjevDuEWjdZ1ytPExjtApB23TldbjnTXu2/g/OSM+NRRGW4+abuuvYZ9cT/Jjyp4YtIbZlm6I1mFawGCzcEcIV2NORgXHkbzHzjtg8iIOUX6QFx1CSfSE+jEOGgerI0iWx4WFhOU7ki2TsJif4P7+cXWWhU+gbfFaOzFyQh7i7SCIxQhzyy66gQEdUKdPfIzjEw9lOBWOkqZj9gieRtk1yrOtNpoSklbj4KZMoWk5/Pc5F8OKEmJzYh6yBdQ5qjvSFEVlr98HONdpJGHGBeLLPcpsOWLzQEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB6929.namprd11.prod.outlook.com (2603:10b6:510:204::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Tue, 2 Jul
 2024 13:16:25 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7719.022; Tue, 2 Jul 2024
 13:16:25 +0000
Message-ID: <4f9a68ce-61d8-4412-b7cb-c574da6982a7@intel.com>
Date: Tue, 2 Jul 2024 21:20:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ats_vtd v5 02/22] intel_iommu: make types match
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
 <20240702055221.1337035-3-clement.mathieu--drif@eviden.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240702055221.1337035-3-clement.mathieu--drif@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB6929:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f9f33f4-0d6e-4fef-08fd-08dc9a992c9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlJCME5GVVQ1MGJwbjcxcjVvYnF1d2FHVHlaNUpVY3ZIZTh3Z2x6N3hBWGlE?=
 =?utf-8?B?SzhYVU9pVnU1T0ZESjRxQVkwdHhjUUMxMjNTYTdhWnhtSVhCbG9lZW9FNWRz?=
 =?utf-8?B?TnhEbnN2cE9SWlc1bUQ0YTI0TFN6YUF3eXgrV04ycjcvZEVuVHF0WVlsQzhJ?=
 =?utf-8?B?bCthem01MDlYS1VKa3E5VmcvM2podnZEK2lvYkRYd0dCSlcrYjRlTy9kaHN4?=
 =?utf-8?B?RHN5ajhUOERiQ3lFZE9CdW5tSC9tekNXQWlmZUVQT3VTQ3dkeElIVlI4TUZy?=
 =?utf-8?B?aVlveFl4S0dDZzFQL0p3Vk8rVnZYQzFWd0I0MnVNcE1DVnpvR21Cb0EwWkR6?=
 =?utf-8?B?QWpPRWFLbHIrUjZRSzluN3pEWnMvQ1ZGYnU4cThRWEtTK3lXQzUvU1JaVVY2?=
 =?utf-8?B?a09kbi9VeXVkRy9XTnVJalBzM1NsOXpsMWpZY0pNTzNvWHVtb0ViSS9nRDRu?=
 =?utf-8?B?WDRUem9uV0NtVFRlaDA3cDhJZEg1aHVHNkZwdnI1VHdOTWtSVlJvaTZkakhK?=
 =?utf-8?B?Wk51djBkdlhNRVUydG1PTVMwOStHSnFFUVZXaCtDejZneCtIcncwamVDT0Mr?=
 =?utf-8?B?aU9hQWUrQmM2aW8wNjVvbTBlYm5tdXVpS001ay92VENxVGNWMXJNeE9jcVZ6?=
 =?utf-8?B?WEZtNzJKaTREcGdXU28xWVpaeHBESXYweXRRNlFsMVkxaklhVVZSVXoydHlr?=
 =?utf-8?B?ZUhmYUpBTmlhL0FFeVQrWW1lNXl5UnpYbGRPVHlHVEtOaHN2aStYZVBoVEFt?=
 =?utf-8?B?SldzbG5rbHF6OVdTb2hvTkhDUW5URTQ4MmVSY1VmMkZUcEUrWHJRRGdjcllk?=
 =?utf-8?B?aUVJelFXQzZma0ExbkMrdEF5SnNlT3N6azhTVzVRTDZ3MUk1eVVrZUZDL3dj?=
 =?utf-8?B?LzNBU0ppM3pWaG1iVVZQQi9RVTNEcDIxSCtCVUQzOVVwNW9iZ1RVWmxsc0Y0?=
 =?utf-8?B?RWcrZ2orNkpsL1ZBMk5rc0lXRjdzaE4zM2hLYzRWb1BkaE9DVWdRSmZCTlFE?=
 =?utf-8?B?QUNuL0NIZnYrTU4zS0szaGZvSCt6cGJHNzZOcktITTU0NUJNMXRZLzM1Qncy?=
 =?utf-8?B?Qi9lNnREb3lNQW5Sb3BMTktqMzMxS1J4YWZ4VDZJd2JGYjlONkh1MTdBcDQ3?=
 =?utf-8?B?a2xCNzY3MGZJS2JDMGZIcEZ1RUw3YTV0RVoxYW52VjU4cmVvSVlMMXYwb2lR?=
 =?utf-8?B?VnoxOFROdDc0Wms2MmRMMXc2bkN1a2JYRlVLNDY5aGxQRTA1NmtJNVlDb3lT?=
 =?utf-8?B?OWtuQXQrYWI0RDdkY0tlOWFvMThuS2dHYzZPSC9hRlVxODE4RG9OZWYwcUdk?=
 =?utf-8?B?NThoWWlFVVlxYUMxeDRMRDE3SUdHRVBrTmtBRU9XT0NnbE1oWmQvOHdKc01a?=
 =?utf-8?B?akJkWHRKSnQ5ZkdUcHZURzA0elpNeXNlRkVlNlZ2RkdXOGFTOWszVXNHR3dl?=
 =?utf-8?B?VnFkNHMxTnZXSjZkeGlmVjJ1U1lua0J4d3J6WjQvdUEybEkxNmprMEJLd0x6?=
 =?utf-8?B?SkpESUp6ckt0NFN0cVJPQVJEU3RBZGtNV1hhQWRxNDN2M1UycDQySU1PR0xp?=
 =?utf-8?B?V3Jpd0d1UWJTczBLaWF4OGY4NUFSbDUxQzAySUFkZGh3bVBzcDFoRElIS3B6?=
 =?utf-8?B?Ti9RVE44bFlFbjVQV2wydWZvY3hzTUxsMCsvWlZyOGI0VmFOMnE0Zk43eGJ4?=
 =?utf-8?B?T0pERHJmbW5CSGZQMFBGa2NDcFo5dUZwVWpBbUViWmlRL3ZSbmY1UnRpTFZm?=
 =?utf-8?B?WEdIV0ZOVnZ4Q0Q2VnNEVHdwaVRESHdJZm1uTDFHYzQyR2ZWUUY3RTFLaVZ1?=
 =?utf-8?B?RW92ZEk3RTRja2NBSUovZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWpSMDJ4ek44MGFuZ24vQUxUT0o2ME9Ddm1GSVNRQXpKaU9ZbUJVTGdadnhO?=
 =?utf-8?B?ZXpLbkl0cFpQNHlnbkNWRWhGZWRkbGJ4M3lvNVJ2YTFaK0R6ME1vTTV6K01v?=
 =?utf-8?B?Z1oxWHg0TkswVzJZdzZIN3Y3MXVXTjJDVTJ4NG9KK2hPeFJLaEtGbWFUZkdN?=
 =?utf-8?B?MEpHcE5tbFI1YThIRStXZFdjZEhQSmhaRU9TNWhoNlRCSEQzdTNvdDBuWW8y?=
 =?utf-8?B?RENEYVdrNm9tV0JKdEhIMjl3L0lLc2U1QlpBSUVzR1JIWXg3R3M5TVpIaFVv?=
 =?utf-8?B?TVlxZGNwYTdBcnpicHd0NTF0dkFZbTFmdzNja1VXbGtsVldvaWR1MTNwOWMv?=
 =?utf-8?B?c2N5OEJsUW5SM2IyWUZOMThtQ3EzNTJmZlAxTUZjcXlCVDByZmJBeHFMTFVQ?=
 =?utf-8?B?dUZpWWs3VWtjeTkyRVh6ekw0em9vVDJHeEVQZ1J0TVhMajlUdzRUZlc2a1h3?=
 =?utf-8?B?OTl6M2kwVWdWUGRBT0Z3WVFzTHhia01jcU14T1l4ajBNVVB5SjRzcDU4N1lQ?=
 =?utf-8?B?OHlqbk9Ja0ZVTktVck9pN0VkYTdQVGtya1lXSzVxSVhxOFNWT0Rpek4wdVN4?=
 =?utf-8?B?VzcvU1lUZ0M5T05uOXpNYXZMMHRLR1MzZjFiaWpGSjJFK1VVYkRneUUrRldo?=
 =?utf-8?B?RHVvQUIyenZCejliZ0lmN1JMMTJicllBdWNQcDQ4Z3VESGtVU1VtMFJ1dWNj?=
 =?utf-8?B?ekhsWFg1MklPM0JNNUdjUkRQbmtNUDhpcFNlMHJ5N3RGK1ZpclZkdmk2Q2tM?=
 =?utf-8?B?c0RXbUZBbEZCa05MQzY3bG5JWlROOWZ3M1hQTlZTUG91b1NYNmkrZHQ1TGNm?=
 =?utf-8?B?NlBRQ2F0VUQ2aTBhWVZqTDFCdWo2VG9vWkl2cGEyR3pzUEtIUjJCeXQvTm9E?=
 =?utf-8?B?K2pPK2RHVXhBRVVQbTdNZS8veDNFU3VpdHZDSWo4ekdhZlNzZHpwcWdjdndT?=
 =?utf-8?B?OTlZdGVZMHRtZ1Nzb3p0SWZBaGlrOWZFQ2RqSHd6ZmlKRHhBK3VZc0k3S3Iw?=
 =?utf-8?B?MnplNHFrV1Q2Y3lZWWV5ZDVoYXUzSTd0UHdQcG9YZ1FuaTdFWjN6dEdHRGlC?=
 =?utf-8?B?cktpSFhPb09lT2NKakYvelJjUWxhOUIxQk9HNXRUV1YwSzBBM0NCUjBFelhH?=
 =?utf-8?B?RzV4ZXhadllEZkc5dWJqOG0rLzZvUHc5UTNlc3VtcXU1T0RRNllFTmM5RTQ0?=
 =?utf-8?B?SHd6ZTd6WGlwZi85Qy9qckVuMGVsVW9wWlZYNGkvU0N6QkpaZUczYmZESnZp?=
 =?utf-8?B?NjBxdkZaVitjcHhIZUg4eDRkVnJsVnFSZTJUbERNblFjZWFMd3JaYmwxaXVC?=
 =?utf-8?B?blY2YmRsMC9NZHlRbG5NYVBGR0tiRGREK2ZrSWZFZW54ZUxyWjFXUUVWRU5l?=
 =?utf-8?B?Wmt0Nzc4UzAyNVFreG94Si9VSjJZWllXTVBiKzBidHpHdnlpOVBtTDhUUUFR?=
 =?utf-8?B?MVpnS3ZKNGdBRmMySTQ1Z3VnZEpHVGdlemZyZDMwSG9PeWFtdXNkSVFaeWtG?=
 =?utf-8?B?MEprTlUwazdnRVh5QmU3SnlQaDVVOEZCZDd5MnZHL3FBdkNaeTdTaFl1dkpJ?=
 =?utf-8?B?WG0yNU1qWWtwV2dmd3YxQkN3QWZMR2VDaitZMmN2Q0xGY3I4amFLTnBlQXFZ?=
 =?utf-8?B?aER3d0Y5bHgweXp4YUZPdTFpMVliRTI0WCtTVHpFSjNsTERlanRvUzI5UjFJ?=
 =?utf-8?B?dlhrUmR3QjY5dXNBWmxPZ3hpSmcvSmpXRkhsM0s0L1NBSTdmK09QVHZMNUx2?=
 =?utf-8?B?OGtQbGRFMVBlVTZiQ2o5ZkI0dU9idzVsd3huZk94ZHo2cFhWR0YyNkVhZlE1?=
 =?utf-8?B?QUVtZ1lEL2FlM05sdzh4Mm5uLzlPdE9qemtjVTk2c2czVDJOWlZvTTUvT045?=
 =?utf-8?B?Snh5U092aVY4TFR6Y3BXWHN0OWtOeXJFUzRFR1Q1NGpFU2Q4S0RNVDhVTWYy?=
 =?utf-8?B?R1R0WmVMQU13bkZBazdRdzhzeXJBQTlCTDJjM3RrcmhJS0c0a0EvWUdjQWpH?=
 =?utf-8?B?Q0VtK2ZPbEZ0NzFYQWVsZExPaFMxU3pNMkw3RDRXaWptbXk3SG9oRHlqODUy?=
 =?utf-8?B?UUsyL0FYa2RZRnNlSDAzZVVVK29BeUVkUW03ZGRCT0NqUmdFT2JlMjNRMFVs?=
 =?utf-8?Q?mZZwAG8dIRd5RJI/kJq1RZ+RT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9f33f4-0d6e-4fef-08fd-08dc9a992c9e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 13:16:25.2638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhQSHVUXZKQ0LTFb1wyxNrD42zYvVOBB5c8MHWVDWv52zPIsAMsCJ5ZiP4Qf3WEibJvTL3L8FTXd1IqoZxpo9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6929
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 2024/7/2 13:52, CLEMENT MATHIEU--DRIF wrote:
> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> The 'level' field in vtd_iotlb_key is an unsigned integer.
> We don't need to store level as an int in vtd_lookup_iotlb.
> 
> VTDIOTLBPageInvInfo.mask is used in binary operations with addresses.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> ---
>   hw/i386/intel_iommu.c          | 2 +-
>   hw/i386/intel_iommu_internal.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index c3c0ecca71..c6474ae735 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -417,7 +417,7 @@ static VTDIOTLBEntry *vtd_lookup_iotlb(IntelIOMMUState *s, uint16_t source_id,
>   {
>       struct vtd_iotlb_key key;
>       VTDIOTLBEntry *entry;
> -    int level;
> +    unsigned level;
>   
>       for (level = VTD_PT_LEVEL; level < VTD_PML4_LEVEL; level++) {
>           key.gfn = vtd_get_iotlb_gfn(addr, level);
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index b19f14ef63..bd20746318 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -506,7 +506,7 @@ struct VTDIOTLBPageInvInfo {
>       uint16_t domain_id;
>       uint32_t pasid;
>       uint64_t addr;
> -    uint8_t mask;
> +    uint64_t mask;
>   };
>   typedef struct VTDIOTLBPageInvInfo VTDIOTLBPageInvInfo;
>   

-- 
Regards,
Yi Liu

