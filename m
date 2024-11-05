Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8CDD1CA37
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Czx-0002gg-5X; Tue, 05 Nov 2024 01:25:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t8Czv-0002fm-SJ
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:25:03 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t8Czu-0000Zq-5o
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:25:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730787903; x=1762323903;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SP59iZK2+2kPzUEnf8ZXvfoKvVgxST4JpZwmW3F8pSQ=;
 b=KFnzescW+Cw+GCalip5jXhSfVPi1AuOTuZRt6cwlaBi0GWfS+ymQ8XdP
 jFtr/JDcnaoGuoGVgd60wL0ZXkbbHlssrYxVgKVRsmVlNk6xXjGljCrUW
 rhZJilAGrvH/0H+iFUZ7X9hhBmrcmMNRSidID6qL6MtL9j3leAicEbR7R
 QBmMCal2ZruVcn5YYfV1umMOpfcO7+quHot9Y1ehDxgaJUBKXbuRsIFzd
 Uh+InhkeDkSW8cX53PCaPBqYiO6Im1Xf7kedpQTv0G8tnl7oysBBrcOZF
 xqo9p/dmLwkZxVXBqhRInJ22wi9w+YEpAzrk4QrGxg9eP6ZDQOg2c6YJI A==;
X-CSE-ConnectionGUID: ho2UcQD4RmKpo0KSJgKREw==
X-CSE-MsgGUID: BWbvfzlSTeaQW/6Qym7okw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53081707"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="53081707"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:25:01 -0800
X-CSE-ConnectionGUID: gU+697GVS9a+sNgXPw94Jw==
X-CSE-MsgGUID: y6ZaeTcmT5KFTd+4W8C03w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="114691516"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Nov 2024 22:25:00 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 22:24:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 22:24:59 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 22:24:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cW+BQivy6dfuVSGhK+kC/lA40D8ToS2uxD/5y5uelCng2qAYyV9KI6f527kdu9/i/U5QCaykpBhDhvO3QA/Nov8whshwwxrbL1mnNEwrd0JMBQzAN+pXtz+aLKrekrPd6QnQthfHfK41osQy4RPycAhEzNkKUga9qxDZXr9UmSqzqM7Gzg85PGRQ4CEcTBYHCOBHHExbj9o5JWUgd0XsuQdhD6ZUC58G/dQSZ+e0Y21BhzvO7bcY657XumWzxfL3SoIxH5lGA/epFA/E6GZ1R84vlk6b0GUII4Lsg1BcLwB+74YC+g+5qmJhCrKTTu2QkrbuzNp7XbfreEJSgZ/9WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yhi/WATyAVRcOK7zTL82TWAGGb4Vt75VLlFqiag/bik=;
 b=pvqAFuOO7UTnNugDu+PldlrlNYOfyldUiRGvsNvzJvTlqxUb9z4f5rpKsHYwldXf7jVL7mGkWHg5M12EMqEa8noPClvICxDqB7VffiX6mX3irgIf3KPoYODurUXGSgO1HpRJxVbDAKYy92tzCZ7OcD3Ve3kpqqmID2KeLVULWd+ZahGrs9JmKZm9BX/VfwAPg9MDCiR/blHaOf09qRH1YF1/IYC81wpgQXTFjgY9yx/hk63yvtrUOQLp8kc0rW2yppS1zEM6YiBYhiLAxvifLd3TtkJ3WR5zR7SkV3ltydC8+yonEivTwEAYEoBPyWQ+675p+Xacs2XeG8VVJOoDuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SN7PR11MB6826.namprd11.prod.outlook.com (2603:10b6:806:2a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 06:24:57 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 06:24:57 +0000
Message-ID: <e74b140a-5030-4092-b83d-8e91756c2544@intel.com>
Date: Tue, 5 Nov 2024 14:29:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/17] intel_iommu: piotlb invalidation should notify
 unmap
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-14-zhenzhong.duan@intel.com>
 <2d2c2515-6a74-4e81-8ab5-0390aa59f6dd@intel.com>
 <SJ0PR11MB6744E7B5833C645A0E17A3F692512@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <SJ0PR11MB6744E7B5833C645A0E17A3F692512@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0162.apcprd04.prod.outlook.com (2603:1096:4::24)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SN7PR11MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: 8546e658-6f29-4a87-36c4-08dcfd6291b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TEhqUERjTlBoMFBnZVFCN2gra1NqVnZaZ0dQLzNiUFpYWmEyei9uamxlai9O?=
 =?utf-8?B?TklZZ1NtVWtkb3FQNWtlY0NIeGx1WUI4clZpTTJyNDNuWmxRemJmRmY0S1NC?=
 =?utf-8?B?aFYvamlDTHJvTFpvR0pIUUZUNDYyUFRnbExXYkdIVXlVUUE0UGFwM3BqK1hC?=
 =?utf-8?B?dXFaNzJidGtXWFhlZyt2VTU1MjNYdWhlWlpKMTgvM0FuZW4wUi9uajJQaGJR?=
 =?utf-8?B?dzF5a09VM050YlFMcDdUTE5POXkzbjZveElUb2FRV2tFa3BCVFdYb2hQK2JE?=
 =?utf-8?B?OHZNcEVmZWRrWmMvMW1MYThXWmpPdnlLVlBGaG9nNmhKM2xHamh2VUw4RDlm?=
 =?utf-8?B?QTVCRVpQUHBkZ20zOU5jUFBlTTFOcno3YzR2eTh2eUVESm93NzlNTHZsNzE4?=
 =?utf-8?B?YjZxM2hOM0p1SndkQTAvTHJ6UG5pb2V5djJjYllmd3NFNThOcGJocVdXOW9y?=
 =?utf-8?B?WGR5MXd0UlVHYng4cVRGTWQ0ODRrRVBWUDF5NG9oclMzTGhZem9ZRUloRGUv?=
 =?utf-8?B?VHFzd08zWEVuUnhKNi9oZGo5c1NLUU80NnlnZmkxcU1jQUdXVHRmYnVyOXFy?=
 =?utf-8?B?bHBQQ0JtV2ZoL1F6VTRrVUt3K1laUDA4MFFvbTBqdFh1b3k5V0JLaTZ4Q0tw?=
 =?utf-8?B?Q1g0MTNTTlk2ZVRGQzNuK01xOVYyN2VBS1ZXTlovS09wWlcxMVRYZ01qWE5X?=
 =?utf-8?B?c0lBOTdZNGFrT3hVenpWaDNSVXhkcTFPRE53SWNuMUZML2UyYlF5MWxPV2tW?=
 =?utf-8?B?UXVycWJXTC85SU1jRmxxSHBHbzJ4OGJ3dk00aHA5MnUvaVFrNVl5RjJrOVZP?=
 =?utf-8?B?ZzNaTnNxTnlhTk9OWFJVOGNBWGQzaWN4R1p4Zkp0VU51K2JYMnV0S0R0emdE?=
 =?utf-8?B?T0ZNekVwMHBzaXN1cnpNQ2oxUnZyWlRUZjBiQWFCZzhrclU4V2VsemI3bXRM?=
 =?utf-8?B?QjZWc3R5RlZ2MTVTZjJUWDZGdFdyd2E3dW9NSXRSZW9PNUJlV3Z5WUdSUmJl?=
 =?utf-8?B?S003eHJoYUlrWWxpUlVieVhmcVpuSzV2R1I3S1lPWjg4alVZb2lkNDd1eURC?=
 =?utf-8?B?T2JnNHdBN1M3aU9FRTd6WkQrZkluSDQxbURkSlJNOWIweWFQenhOQ0tnanc5?=
 =?utf-8?B?Q2RWMndQZkNubG01YkxUa3RnZEF2R3B1ZEN0dXJ1TnhTUDE1RG1yNDhCUWZK?=
 =?utf-8?B?M1E4SXA2d3pxR0dqQldyaHo3enUyOVg5WVNIVXdyRWV0ZnVOdlZPRFNFVW9w?=
 =?utf-8?B?Z2RvQ01yMlNvaXJQSU83c29rdDdPM3NFeW5ZS0NQeUlwRytRcHVRdEszc2lF?=
 =?utf-8?B?QzlOSC9PK0lybVg1TlhTYzE4MWluaFVHZWppOUVKNjJEaTB3MFlaRVdLU1hx?=
 =?utf-8?B?ZW5wVitkakJVdllmV1BseW9FVTR5TkVzRkFzVlFTaGxLVG5IYzhlUW00WjJj?=
 =?utf-8?B?dDFteFJXWWlTMnA3Q2tvbVNEUkdjbm5DSUc4aXpKUzQ3ZXg1N2c2TFV6Skta?=
 =?utf-8?B?M3RtVmlZYkhzamQ0aThzUDVJa0xPUWJhN3F2Y2p6ZkszSnVUQTZBK3M1L0U4?=
 =?utf-8?B?SWJNRTNDTHZhTU9Rd1R0cmZidzBEOFYxb08yUTdjdXZkeW4xS01VUEx0T09Z?=
 =?utf-8?B?ZEc1c0QvOTBiWmRMVE1zNG1tRjRzU0R2czZyT3M4bWpCS3djanIycmp2KzNK?=
 =?utf-8?B?UjlWNlJGbXBFdm85Q0RJVGUyekZldXF4NEFNME4rQm9wYjREY1N0YzlTdDFp?=
 =?utf-8?Q?ObtybKLEzFivHbBE2CvknQKiGK+a2tjDd6GdVyh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkVzcUVDRGM5Y0FoTGcyeEpaMm1ZQ0ttM202SUMrd08vN1BqcGJXR1RxbFhp?=
 =?utf-8?B?cUFoTzUrQU93cjBaM2VwdFpZKzNubEZVWmszL0tTcmFxYXMwMkNzVC8vbHRn?=
 =?utf-8?B?dXdUNzhORzBGd0tTS1QvYWR4VEEvRUd2ekVuRkNJNXpoN3pwakVnUGgzZG5q?=
 =?utf-8?B?OWt6cVRIeFMrVnoxQXBKcTBxRVp2SGhtdmIvZFI1WWU1K055VHllcm1WdE8z?=
 =?utf-8?B?Mkx4Z3ZidldrU0FTOVlTWVhmTDlBODJaQUdndXZHVXFHaEdndVZ6RU5LQVhv?=
 =?utf-8?B?aU9HSzNDdUxxZjhKbzdDVDJRWkU0WmVUeWlIcFZRU20wSFF4aTMrcVhWSk9l?=
 =?utf-8?B?OWtHSnNHYTVRTUJkMXREd2wzM1hvMUs0ME9SR2thZlRRcGFzT1NWTVZZNWVm?=
 =?utf-8?B?M01uM3dnY3hkSjErcE5RZkRLZnJwMEdGT2dMVmN5VFNuMlZzeG1sZ1VwbmVw?=
 =?utf-8?B?MVdlWFI1KzQvQ29QYUQ1dnU4M0FWTGc5SDBBOVprNGdrMzdwbGRqZ2dmZjNj?=
 =?utf-8?B?MUhuV3ZJa2o2YjJCN20rR0s1NElUeUVDOXQvdEFCMit1aHcwT0xnTFBHOURl?=
 =?utf-8?B?Z1Bldlhvait5a3ZqTHU5NUcwSjYvQjhWQjdJcGNEWCs0UjVISnR5a3BYZDdZ?=
 =?utf-8?B?RUxZZ24yK2pLSzdHdUIzNTNwREV6NFg3U3RTYTIyWWRJNUNSd1gvU1VBZThX?=
 =?utf-8?B?aE5UNzhuY20rUzJ0M0FoMVQvdmJYcDZCMitvT1BZdXpvbTRTWE1KM2o2VVUv?=
 =?utf-8?B?WkY1ZU5zT1N4SUxXcisyV3hzcUZndkpianZORHN6TThkekpvSFhGUlBGdUh6?=
 =?utf-8?B?eDFzMEpsSDdROGFiTjVZRUdxUktxc3NLMldpbmpyVVM5RitZUmFFbWhuYUFW?=
 =?utf-8?B?ejRXcHAwSkV0bkRQdHVJQnBlZjM0ZW02bmNSMEFiTE1JMy8xT3VGSkdqYWt3?=
 =?utf-8?B?MnQzSE1Jcy9Rb0I2eEt0RUMrZk9pV2hnRGUrd0M4SlZvQ2xuT09ITnkzZnNy?=
 =?utf-8?B?eEcrbkw2OTVxZmxmdnBWcGdhN1F1YVBCTDQ1T0NjdHIxeWQvZVdtcndGR0pn?=
 =?utf-8?B?aDk3MDlYQXNIY2xicGJxNlVNRlV4eG5NdnF2WjdWUTdINlBZU0p2YnNOUjdO?=
 =?utf-8?B?Z1RMYzhIUTN5ZUNsTEIwVVZjTFI2dnJwci9BdEdiSFpoRGt0MHdveTB4aUxO?=
 =?utf-8?B?K205ejQ3TWFHUS8vcTV3d1p3Q1BidlpLbks5Mmw1bXo1Qm9OWnplT1FXK1R1?=
 =?utf-8?B?bXE2bHJoaE92VHhKVmQ2VFV1dzBGZEcyUWhDZDE0WHpPb0o3YXcyOTJORDdu?=
 =?utf-8?B?dFp0ZVJDMktlV2JGdFFtcFRDOEFxNW1PR3pySmRGcDM2NWZMY0p5UEZuWTNF?=
 =?utf-8?B?N3FYS21WdmFTU25Ka2lteFp4eStJUXljQ1FocjFKMXY5dUhrZmdMeklXWUVx?=
 =?utf-8?B?ME1ndzF6eGw2eDlSdnkrYi9OcnhmNDlYcDdOYUJmdXRNWFdFblY1ZXN2SURC?=
 =?utf-8?B?VkQ3dzVsNDYzM3hHUVMvQkdFbExNdStUL0d5ejEwdDN6MVZqRHBFbldnaEVP?=
 =?utf-8?B?cUk0WlJQYXdWMEFsb0NEMWpPSGE2SXd0cnhYcnlyR0t0Slg4bEpyQ05PZktQ?=
 =?utf-8?B?Q05CL0RNdlFNU0ZZQ0lpU2VLYkNpL2R1dnZQdnpYeEdBa0c2ejJIWVp1dXdO?=
 =?utf-8?B?RDRUeklMVno2YmFxOG9LZ2hoYmFGbXVsZFl0cm95cVJwN0p5ZnA2cktNbzZN?=
 =?utf-8?B?RW9tQktsajJhQjAwQjc5a0svUVdzUkd2ajljdDh1b3YvekMvVXkrWFBQYjRn?=
 =?utf-8?B?ZVdMQXp2UWM2MEsvVW5kenhNZkE2WDI0NVFtQTl4WENUSlpQYnQ2QnE3RjMy?=
 =?utf-8?B?YWwwL0FwaVpWSFFZZU80aDFIYnJQeUxkV29hUElOT3YrZTVwUDQ4ckx6R0sy?=
 =?utf-8?B?UkJxci9SQUtLeDlaWlVwbERiZHZyRXppb1llVzV1VTUwWW5tUW1NZytZWTVq?=
 =?utf-8?B?WjJIS09JcDRLSDB2M3JUM1dweTlwY2t1enUrYXcwWExpcmJYd2RvNnJpd3Q5?=
 =?utf-8?B?bWpTZ2NET3pUNStqcEcxQThWYVBVS2h6VXpaa05WbGhNQXo4YmxoaE5VbG44?=
 =?utf-8?Q?/gP6yGG1/+QtgIqgYhAulGavW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8546e658-6f29-4a87-36c4-08dcfd6291b2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 06:24:57.3977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98YXAoflO9q1IpCPSnzaGxMwxnW2RkfHJWOPbopk0U14YULBd4j9vTGxyJqPxn3qfeFTvzvM/tZU/9PmeGP5+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6826
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9; envelope-from=yi.l.liu@intel.com;
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

On 2024/11/4 16:15, Duan, Zhenzhong wrote:
> 
>> vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
>>>        g_hash_table_foreach_remove(s->iotlb,
>>>                                    vtd_hash_remove_by_page_piotlb, &info);
>>>        vtd_iommu_unlock(s);
>>> +
>>> +    QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
>>> +        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
>>> +                                      vtd_as->devfn, &ce) &&
>>> +            domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
>>> +            uint32_t rid2pasid = VTD_CE_GET_RID2PASID(&ce);
>>> +            IOMMUTLBEvent event;
>>> +
>>> +            if ((vtd_as->pasid != PCI_NO_PASID || pasid != rid2pasid) &&
>>> +                vtd_as->pasid != pasid) {
>>> +                continue;
>>
>> not quite get the logic here. patch 4 has a similar logic.
> 
> This code means we need to invalidate device tlb either when pasid matches address space's pasid or when pasid matches rid2pasid if this address space has no pasid.
> 
> Yes, patch4 only deal with stage-2, while this patch deal with stage-1.

vtd_iotlb_page_invalidate_notify() has a similar check as well. But
it checks PCI_NO_PASID against the pasid instead of vtd_pas->pasid.
So it looks confusing to me.


-- 
Regards,
Yi Liu

