Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B57C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 07:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOuN7-0000Dx-UJ; Wed, 03 Jul 2024 03:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sOuN5-00006d-W8
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 03:25:44 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sOuN3-0002uC-7n
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 03:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719991541; x=1751527541;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=t7Z4aXtPVXsfbCY44kxRArRd2qJtoNx74OvgOWasoZI=;
 b=mgdzOHMiofIjJO9FkuLS0djCtr74ADCmf9HKvEj2wJDimwgjsuSJOqs6
 mKCEK8lyuIUTZDBoLyPHGiGjVn8SzC3+//gQv1IBzTAIfkJqMhgNE+Gwo
 2v2YKHtuvaQH3IgaM86PpFT8u7dikKY1aurZXlUMaOPPQ3JKqkYFCPobq
 JNyChfqw8ZOT9Hr9hFUgMUtNfA2ZbId/BaPdfYztSf2ZayDfIeJn6nPGd
 yAsKKzuCtA5uPVaqw6sQjctHsZ7TiJoHxao0Essy99X6Hfcp9v+XgE2Ed
 TBRpDQcotoE5wrHFGVLBptXD41R4UrnvsaLQGa6o/jgMZLWciVlpy4n7W g==;
X-CSE-ConnectionGUID: NCxJUneVS6Kf+jSGchRHpA==
X-CSE-MsgGUID: rmS1zlK8R/ODSXCi+OLusg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17041901"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; d="scan'208";a="17041901"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2024 00:25:36 -0700
X-CSE-ConnectionGUID: Ln5chEMRSYWvAuCtybd6jw==
X-CSE-MsgGUID: F13dvoDeR0uzS72343PSbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; d="scan'208";a="46069404"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Jul 2024 00:25:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 00:25:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 00:25:35 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 00:25:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9MKMtmFhQeB3wX0FHNIxmzhlMru0Qr8jxuL1+cjaKZ7qoFhWvFZzOeGtHXrAV39oe14sQWLyzmSDCKkUgENJKZYnGl6fixbG+dfhc3tfQW0Rl6Z8SoA7WKR+2ZvNgC90VXgVQYY1kJg/2/Ytr8dP+YOi+zyDOd9SDri5fiIKPhLbwz6iSWMKm9pIVpwe3GyGCOtKCrI+83G7cw1Qt7mzrIqnr0vB9GTrdCVWairM9UvXA8F3qVQRfRq8wZP/fg2IRs9hJFYtaGbgWyCP7YaKP4dMqdIcojdf91gROcMYOkq3QEhxDNwNyBvY5XEQR+j8UnuSFznZyZc9y92i8LkLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFRCtd6ViVPfaiojtsEFbRXm9CDY37VE/JKxKRpisSA=;
 b=eAqzPdMfRogdrhyXH6vRzi1P0QOiuPkuwISehf+jxc+04BZdY6Qtm9dkN7MikiolPG8Ztl9dDTFHEqSBTYka63/0vw5D/KfRTdscWX2pcP8RTq6w7KLDI73ETUwBqkvek3mDgtE0Vwnpy2X89wXYBWYAnwMB4pM63CjBDYVRf0fM5Lh6CWsb9LRcyJaWXs64CCTrITpIaSeDPrD8c4Gb05Yz5GkxCwuz0jaZP1O0YJXJvDWVDnG2ObAMT5EojZxakQGjbxpr12Oid3auUxtLKL6unTw7ZMI2nKJwncaE+QbkEgXhlCJPMr23taSjZ1JE8YoKn6Qi4cVh3PxB7Ik7Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB6422.namprd11.prod.outlook.com (2603:10b6:8:c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Wed, 3 Jul
 2024 07:25:33 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7719.022; Wed, 3 Jul 2024
 07:25:33 +0000
Message-ID: <6f94f4da-27fb-4f8e-adba-33a2f4c20fe5@intel.com>
Date: Wed, 3 Jul 2024 15:29:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ats_vtd v5 04/22] intel_iommu: do not consider wait_desc
 as an invalid descriptor
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
 <20240702055221.1337035-5-clement.mathieu--drif@eviden.com>
 <655835f4-dd39-4360-9868-57abb8f9a3a3@intel.com>
 <26c57107-3b75-46d0-9191-32bc7572fb26@eviden.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <26c57107-3b75-46d0-9191-32bc7572fb26@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: ba516551-054b-4ab3-e5f3-08dc9b31533a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzFqYlhMWWxaR0NmUWxvQ20zaGZza1h1RGMzOXpvazRXbDBKcWdiQ0kwRERr?=
 =?utf-8?B?T2tSdlRPczg3UkgxWFQ1ZU1iNk9UUnU3bXhIL2ZJY2NLZ0cwUDBJZmxsYms0?=
 =?utf-8?B?bkM5RHExMktmTG14VE9PelZFNGdWVkxNRUVGc0ExcFQ5RUlGU1RVaDR3MkFL?=
 =?utf-8?B?N3U2RTRNUmJHbE8rZTd6RG9Kc2ZKcnk2NkdWU1NFQVArckNLcHFDWThQQy9E?=
 =?utf-8?B?UngzWEhycnVtVis1elM1czYyZFB3K2dyb3NEUDYvTUlWMVVDQlVCeTJMSEUv?=
 =?utf-8?B?VDRjRnBIS0RUMzUrbU1hQ0F2Ym5CeU1zNDBJUmM4K2QrcUw3dTcraEgrRVNt?=
 =?utf-8?B?RWh6TUZrKy9EeUJwUVF6R01UL2xkcmFVekNiYmRQY3l3a0JNeXBwZjMxQ0o3?=
 =?utf-8?B?bDNyWFdrQzl4ZTZYVzZIZzBkZnVIWTZFZHNRbU1VZ2RVTENLaExGbkVhVFhu?=
 =?utf-8?B?YTBBSnR5SzF4Mm5OVlFyam5TV1pRdTRXbU1oK3c3OCtFNFhxUkFiTzB0ak9N?=
 =?utf-8?B?OHZ0clRYTHRiQ3FwUUUyRUJ3Q2dKWUwwR25ueXY2U21PeCsvek1adFREU0ZG?=
 =?utf-8?B?UjBQMjNialRMR0gwM2tiYXM5ZHZpV3A0WVBuV0RTa2pwNWswcExiQ09DRDFI?=
 =?utf-8?B?NUZ4T0pkOG1qZ2lmdTdwek5neE5rZXJPcXR0UmdFcE4vZWFRL25tYWtmd1ZC?=
 =?utf-8?B?cGZSU3RXZXkxaWxWbEJkL2NJN0lENlcxSWpzVTZ0Qy90ZDNIRm9iY3hrQ2V2?=
 =?utf-8?B?dm5jM1JpN1BNOWJyeE9oY3phZERTRDB1aDVVSFNnVVNwMEFqV2JJc3RWMmtx?=
 =?utf-8?B?U2UyNjk3RnV5UU9ZWktpQTJOOThCbzMwUC81K1V6dGNrdU1WZ3NhVkt1UUtX?=
 =?utf-8?B?MHJOdnUzWnU3S0RrcmIwUTJySHdXL3dCcVdpYmNSM1VKNmRRQUdhNFY3VTYx?=
 =?utf-8?B?TUE4NllhaGdUOW5XYkgrcEtnZitCZTFOczBkeGF6OS9FTzRscjlBRFNvcWJV?=
 =?utf-8?B?NjlZNGtpTVk4VXFjQThCVlhSclFCbmJGb2dNZmkyendGdjZPamFkbktlVmtX?=
 =?utf-8?B?MUFxUEZMQnk5ejRFTUlmcjlhdXZkS2Faa090YitJRjUwTkV3MHRzR25CaGVJ?=
 =?utf-8?B?blRYNlcwSVk4UHkyd3BsRUxLYWk0VnZ5MFN1K25LQUJId0tSbjNvOEVlYW8v?=
 =?utf-8?B?WXhhT3kyMHB1SzgycStZYXI0YiswaDU2UTZ2VUtnYUJHY3ZSTTM3ZHZYR2l2?=
 =?utf-8?B?MytwcXZQRkVGMStDOCt6bzRtSGVza0JsY0huL0dGb2xvcWF3SWRpVUdrWUg2?=
 =?utf-8?B?ajJGSis4RERBQ1A4QlppamxGVjJ6YzN6OVNoeTl5OFpQV1BhMmVERGRnaGlU?=
 =?utf-8?B?WHZyZW4wSVdsdE54YWR4akhhMS9FV3BpaE9PMUZibmJCN29UcGFzWmVOS05s?=
 =?utf-8?B?d1p0eTJhejRlMzhOVlR1VXpHQVZOOENkZ3hydnI3eHFyOFBkek9ZRytiR1ln?=
 =?utf-8?B?eERub1RjNkpLUVRkM0lMTGZtM1FlbEJXNjNLSGVzQ1FUVjkrek5qYjN4OVRG?=
 =?utf-8?B?MUl4UGpxbFY3K2R6VkoyVnZkRnJJZVJ2VU5FWWNPSFpreGl0aHF6b3hPNVBu?=
 =?utf-8?B?UkVPWTZsNGhRYWdVcXBUYzVhdzUrdnBjYXZTRy92QzJ1N3Z5VTA4TFdEVmdl?=
 =?utf-8?B?OU96cHhaTlE5N0N4TWFBV0cxUHNSQWhqWHl5Yk1DOHQxNGhyNS83QVNKb3Yx?=
 =?utf-8?B?WGlDVkM0R2NHUE9mUG5mMVNGcWczTlFqYlpqdVVndHNDZE5yUUxzVTFZUys4?=
 =?utf-8?B?VVcvZ0VFY1ZPbDlLUTJrQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHJGMDFLMFg4TjV3S1F1YUE1UUZHektOR3RITG8yNkUzWHQyMWVIS1c4bHAv?=
 =?utf-8?B?RDhUeVpKREI4SkRoWHFad3lFaU1xOEhjMHJlcXdkRlBkVEMwS3NpWkNnL0pT?=
 =?utf-8?B?WlcxdTR3R1F3U3lIcWhVUEFjdnhWREFaN3lSVnE0ejBldWVOUDMzWkdCU3lW?=
 =?utf-8?B?TGlLd3FKczFPZnpEUTNWV1daeTZnZWNENjVCci9lRWxRRk9tQzZtSnR1WGdr?=
 =?utf-8?B?bHhuYnBpSG9UaDFJMVM2bWxvaVAwWVp4WUc2Nmp5NGtNTlVOekZ4LzZsS1d3?=
 =?utf-8?B?ZHd6Umg0dUQ2TlJZRzAxQ29vekVhVnFVZnZYeFFRc1VHZkwrdkx3R0kwNUpM?=
 =?utf-8?B?M2FMU2ZIOG1SeVNWNmVMcGJUWE1VUlZEQll3WVFnL3ltaWNzV3UyZXhUMEcw?=
 =?utf-8?B?OHNrenkrNGVBZjVSb1hTUkZWRDJhbWdpdTQ1bEVjNGQ2SjhuMHdiby83ZnRs?=
 =?utf-8?B?NVU3ZzBia24vWkR1djdZa3pnK1RaRmdvaVZKZEozeTZGL1VSL1AxN2lXTjVZ?=
 =?utf-8?B?SmpKY0tVZXlVTmsrZEVDMXZDU0hSTlRDaXJJSldGUWgzT25yVythVTYzcE5E?=
 =?utf-8?B?UlZiTkJ6MnJGL2VWS1o1MmZURXBuSktHQlRZa1lyNDhCb20rWTU3dXNzM3E5?=
 =?utf-8?B?QTFGWEt2cmZKYm51VHQ2N0NlRnQ4OHFLMm5pMk5uclNHM0lqM3lrMWF4Z1Mz?=
 =?utf-8?B?KzhjbHdkSFRaQk1uQnQ3SHJmc3RQd2QwSUl6ZFZrcHlxZTRSdVFVTW16TU5L?=
 =?utf-8?B?UkVJREIzRU9ZMmpRTUdBb3hraUU4d0kyeVNqMWZwV1BlVVlQMlNWeHVLVlVJ?=
 =?utf-8?B?TkV0MExnN3E3N3UybTNJeVlOL09mYXIzazNrY2RHc2hwOGF0aHVES3VxUjlI?=
 =?utf-8?B?N01GVlRoWUszVGFWSFc1OXM3UU00TkMrNG1Lcko4NXNXV0xVWk8zTHQ5aTVq?=
 =?utf-8?B?WDFVVElQdGo5Q3RHRk1yQ0VnSTllTjNVcUZnM3ZSdno0SExGU3QwaTdtMS9I?=
 =?utf-8?B?VkVVb21naWJ1T2R5S050SzNzNnU3ZVI5OTNUclBzdXdBcWNqalNOcjlzT1g0?=
 =?utf-8?B?Wmxjekxxc216ZU4zWjNxaFpjYUZMdVNkL0NjUzRDTTNRYzBic0hCUnJheFND?=
 =?utf-8?B?cENaTmdOQ2J3emk0UEx0bmFNdlZ4dUc5b3dBaWk1TERybGZxVEZCQnY0aEky?=
 =?utf-8?B?TTdwbU9NZE5jd3VGa201WEg1bUNhcTFadjY2VDdCRVFkWko2MjdYY1p1bjB5?=
 =?utf-8?B?Nm5FTHZGaEZrY2tlcHdPeTU1SFE4bGZFK3d3bHpWa3RibCtoSnJNVHpMaVhZ?=
 =?utf-8?B?MnhZMCt4cUJUWW5KZ2tGNllScUVpckdHbkhRK2RMVU53WGhOUnlxNDQ0anhR?=
 =?utf-8?B?dXNreGxJVkNMQjlqajNLOFBhMmRkYjB5aHpMME1oSHpzWkI2L2poTkl1U2s5?=
 =?utf-8?B?L045SzAwK1QydGF2TVZ0aHIwcHF4S2JWcytqcG9MRlFkbFdMRWtzcks0MUhX?=
 =?utf-8?B?MHkvWUlNc2p2b3FBc2xCcC9WeUVhRVE2TytDeUtnY2xWTXo1d2ppVmdiUUZC?=
 =?utf-8?B?R1loRytkL0tvZHRQSjE3ZFk5dHg1cHdLRy9id1l3d1gxZC80U1VHRnp0WHlT?=
 =?utf-8?B?KzZud2xhYjNRK1pONlBKemxnQ2lDQjZqZ0RiOUUvc2JkVTVKMXN6MjY1RGRp?=
 =?utf-8?B?Q3VSYzFzRktWSEZsQU5PT0tFM2M1aEFDcU5nSEhZQ1ZqU21vaTR0Mm9VK2Jt?=
 =?utf-8?B?RTYzZThPWHI5UVJqditGU3lEOFpxd0V3Ty9BamRnN1E3U1pld1o5V25LOStG?=
 =?utf-8?B?d2xoS3JZcU0rQlRuSExTTEUrRlpwdHQwOXhCSmFYSzE0Y1ZyR01IaVppcHkv?=
 =?utf-8?B?aVMwMGw2YmFGaVNHVWV6aDVGcHhGUGd4aXVjVWM4WXI4OXdYekpFcjB2blU4?=
 =?utf-8?B?VDRwalNBSkxpd3pUUHhGVDB6c1l1WUQvay9TM1JBbVBCbVEyYlFUNG11Si9L?=
 =?utf-8?B?ckoyT01aejlrc0NHT1VpSSsxL2ttZFE2bGlXVXlxaVlYcHJpVGtPTXBLeldF?=
 =?utf-8?B?ZHZFTElqVXA4dXd2QjJGYjZmWEJ0cjVzcG1yQTNWZGdWLzdNeE14MjNHREFV?=
 =?utf-8?Q?IHq8tOLRFyaHz4mDX/yie0X7F?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba516551-054b-4ab3-e5f3-08dc9b31533a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 07:25:33.4614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Spx7D510kNtdDrxIQxb3j2ctsTmQmoSYd1PQYMu44Wq1y0loBXCk+lakZ3DHp7cTMduQp4p4C6wG0tSFH38vPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6422
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19; envelope-from=yi.l.liu@intel.com;
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

On 2024/7/2 23:29, CLEMENT MATHIEU--DRIF wrote:
> 
> On 02/07/2024 15:33, Yi Liu wrote:
>> Caution: External email. Do not open attachments or click links,
>> unless this email comes from a known sender and you know the content
>> is safe.
>>
>>
>> On 2024/7/2 13:52, CLEMENT MATHIEU--DRIF wrote:
>>> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
>>>
>>> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
>>> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    hw/i386/intel_iommu.c | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index 98996ededc..71cebe2fd3 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -3500,6 +3500,11 @@ static bool
>>> vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
>>>        } else if (inv_desc->lo & VTD_INV_DESC_WAIT_IF) {
>>>            /* Interrupt flag */
>>>            vtd_generate_completion_event(s);
>>> +    } else if (inv_desc->lo & VTD_INV_DESC_WAIT_FN) {
>>> +        /*
>>> +         * SW = 0, IF = 0, FN = 1
>>> +         * Nothing to do as we process the events sequentially
>>> +         */
>>
>> This code looks a bit weird. SW field does not co-exist with IF. But
>> either
>> SW or IF can co-exist with FN flag. Is it? Have you already seen a wait
>> descriptor that only has FN flag set but no SW nor IF flag?
> Yes, my test suite triggers that condition

I see. Spec indeed has such usage. Please add a comment for it.
Since it does not need a response, so QEMU can just bypass it. Also
please adjust the subject a bit. It's misleading. Perhaps

"intel_iommu: Bypass barrier wait descriptor"

Spec CH 7.10
a. Submit Invalidation Wait Descriptor (inv_wait_dsc) with Fence flag 
(FN=1) Set to Invalidation
Queue. This ensures that all requests submitted to the Invalidation Queue 
ahead of this wait
descriptor are processed and completed by remapping hardware before 
processing requests
after the Invalidation Wait Descriptor. It is not required to specify SW 
flag (or IF flag) in this
descriptor or for software to wait on its completion, as its function is to 
only act as a barrier.

>>
>>>        } else {
>>>            error_report_once("%s: invalid wait desc: hi=%"PRIx64",
>>> lo=%"PRIx64
>>>                              " (unknown type)", __func__, inv_desc->hi,
>>
>> -- 
>> Regards,
>> Yi Liu

-- 
Regards,
Yi Liu

