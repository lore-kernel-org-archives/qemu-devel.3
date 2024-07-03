Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23FCBC30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 12:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOypa-0004Xv-LO; Wed, 03 Jul 2024 08:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sOyp2-0004Mk-MQ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 08:11:00 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sOyp0-0005OW-Mv
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 08:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720008651; x=1751544651;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kEQRv9qqPA4V3HTmL+T9/EDaKfgYdiMckK1+GDzT3bM=;
 b=TLazGhXYEzvUh/58uB2/KdXjwrAL/HeOmYNDJdyXOg29HpYQYN3EmY8L
 qfZy0VUKN8wJbElvKnenptubxbE2H90mtAnRoWV3X8d5RRxbCpDgQdQ+q
 C/Y0WtCITyO+Xmsthw5VKZ/HUZDLxbU39ddEtpo3DCXqCICkJyZIvndV1
 evZF8evsJRJIuSBeq06ik1uHsU5Y4N+aDbTHrRG3qw6NgVVcY3xZ8gz3X
 ROGk+fZQ76V8wu0hbHvxv/GXne8zLFLm//+etriCEHyxI8yVEP29deIpa
 rRmuupjvPCgZ1NuvCULb/y3Kv6IS2c7PyWvmFLSIlezT6IsFjNy2pqVu2 Q==;
X-CSE-ConnectionGUID: 9PMC63sjS5q33cbE95s9hQ==
X-CSE-MsgGUID: xcfKjlWDSWW1AQnONwvLFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27838942"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; d="scan'208";a="27838942"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2024 05:10:48 -0700
X-CSE-ConnectionGUID: 5140yM7HQ5q+KwLlFjsrgw==
X-CSE-MsgGUID: PnYi48tKSJKxCLp+GYLYNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; d="scan'208";a="50842551"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Jul 2024 05:10:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 05:10:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 05:10:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 05:10:46 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 05:10:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erXxCUqb1laY3H5A2yrok+Qj105xOpqu160zRHF7A30jScsAuWNbj7nFfpvx3VuvVc9wrZC7zTm0hDkzeRrfTAYjQeiiQLgopCqBqY8l3ffFEb2JBycr+KWRlBuTrTWQwU0OW+/H1ZxYB25UJrc/LfKh17yikFS9KZGxGfBtLMfSL+OouBbOJlZtC3YwibHidxKgVc07TAQhilnPCPBCoIE3KZoPbuW4IKpakwSfTZq8Qj1pgM1xOSUbw3Ia+N8/wQEkkRfKQVIUAIwRk81bEpZNgKBD3rkZFXRB40F4TiOq4e8OTC2wD/D/JeOUR8zExvtwwiCjtZKh42CQczjWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qo8T8kyIfbdxb0xNmhWSkPWMeWaeGXq3E7fz5vkQJX0=;
 b=eyRC7tLyblnkUEGYs1CUXsL9w070INvCJXq2wgdi5MX+dAB/M1pxcznSXv+NzQTXMbaYXM416rtkF6mCsrojLUq23az88X9a61nrdotSlQH4SZ2DMAtEtdhAD+3kqbAz5VAcOopCatCVPdGNrVCVACU6XvtKIIoTt9713dBjQHi42Xf6fuAWB+Oy/djZneI86NVZLLSO7I5Ukh2dKmZ1rkBLirGp0UINYFegwI3JFX9zee43xusgakH4XwluxptSCLJy4UBvX2RjppjKolFPAQTFXZM0gUiXfEK0zpBzH1CXyp7vFM6jbK8nuwzegTGvxLbzG6fCZYxYXBLYUvq6Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH8PR11MB6562.namprd11.prod.outlook.com (2603:10b6:510:1c1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Wed, 3 Jul
 2024 12:10:43 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7719.022; Wed, 3 Jul 2024
 12:10:43 +0000
Message-ID: <ca43f372-413e-4e3f-b4d9-26164f5cb7db@intel.com>
Date: Wed, 3 Jul 2024 20:14:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ats_vtd v5 19/22] memory: add an API for ATS support
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
 <20240702055221.1337035-20-clement.mathieu--drif@eviden.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240702055221.1337035-20-clement.mathieu--drif@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH8PR11MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: bc4278a9-9fa5-483f-53b6-08dc9b59296d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDl5QUoyVGszRUxlOU9kejNobCthQVM5cW8vemE5WGVJNkVJNHRTQVBnNVBv?=
 =?utf-8?B?aTNiRDl6TEpJQVlydnJXc0VLbVlTdTR6RENpR3dLK3R3TkFhaHJLSkpDVk1h?=
 =?utf-8?B?b1o1bjJMUUdUeUNPdlpoRFcxOFRzd2pEb0lpUWYvUnJORVc5RTZlRFBtNi9P?=
 =?utf-8?B?UGdIY0luMmcrOGVlQU1VMmF5OHZuSSttV1k2aUU3azBtTER0UkNuMG1xdHBk?=
 =?utf-8?B?N1BHbGx0cERVeERvc1NtQjBsMWNzdWxqY3Q5cUorZEJJbVMvWXh2cXV1WVBj?=
 =?utf-8?B?UXVrZjhzUFZtNmx3T1FsQ3RBWXJ3TTFrQS8vTkZ0UUc5eHFUcTZrNXZLNVFy?=
 =?utf-8?B?ZVVPdzdyUmd2MHdIQS9ZWkF4dWZpNzV4UU02eFJZNWcwK3BJK2pMQmwvSEc4?=
 =?utf-8?B?Rk5QU1lYQzFnRUtTSXNBWXVnN2VKUGZJdVV2aXlVR0Mwd1VKakNzYkg1TExY?=
 =?utf-8?B?NGF4ZkVHb2lKb0ZUOU9QdjR4bWFOVEovNDdUbksxeVVtMnhGS0tqUWJiRFo1?=
 =?utf-8?B?N0xLZGVZcWFnQWIyL3lYNFgwakFZUjVsMWRTM0tVNFVhSCtWNXNVeEdTR2xl?=
 =?utf-8?B?L3J3eFRkM0V2a2NOMXg5aW9ZWUlUSDVYSk52Tml5aXk2VGVUKzgxR3RjTnI1?=
 =?utf-8?B?VEpjbEVUVkVRVlVQY3lhR2s2eEorUm9ycktKbm9YbWpSbk5OcThEaVVwZ3BO?=
 =?utf-8?B?NHBoOVoreEFZN3hzZld3M1dJS0ovcmZpMDhrdnNHUVEwdjRSd24zYVZ2bGxU?=
 =?utf-8?B?ai90MFQzU1lRSmhzZGlmeWdZMGJpRCs5Q2MwN2ZFbkU5WXovTG1XL25HT2Vk?=
 =?utf-8?B?cDFkc3B4M2d4L2xpcEpLY0pIMG01cG01eXRWVTZnSTlnQ1c0cXp2cW1LeFFZ?=
 =?utf-8?B?elVQNVE4VVdvRVlmYjFkZHc3VThEbGcvaEFCUEhKc0RKaGRIem5LRHdROW9p?=
 =?utf-8?B?SEdTOGpuN3E0Mk5CWDRYV2FrcUw0NWlrRFM2TkpVOCtCdEx2d29lMEtCUndU?=
 =?utf-8?B?cVJ0REw3QkFpc1JtYWhnNjhoVzlaYXFkd0t6Y0EzTWFDQXJ6TldVWkFuazZx?=
 =?utf-8?B?TDg1bkw0Q1JLM3Yya3FqcTFnbTV6Qm5nMk1YdnZTaGlPYlBRMWk1YUdSU2dt?=
 =?utf-8?B?ZlVPZmdkOHpKTzJ1RW9kQloyZUdPR3RFVG1KdVBXb1pjbXh5RUVneXZWbmFW?=
 =?utf-8?B?ZTg4aVNTUkRpRklUbUVjL24yeUFiTXFGNVN1clErUDJkNWd2M05IZ1M3aHBT?=
 =?utf-8?B?TGltbHdDZmJvd1lNTThvYkIrNkJRZnV2UEx2S2d5SEgycVRnTTRYbFZ2allD?=
 =?utf-8?B?TkM5TmxYWisrNExjd3BCdGxHNjlranhWTGwza1RReXhQWmMrK0VnRDBFWlJl?=
 =?utf-8?B?NUxYOUlRbjZjNElZbUc0Mm44QVNqUHA2NG0yUGYvZ09XSTRtZUZCMW15VEpV?=
 =?utf-8?B?K0JQOW4ra2I0bnA3dDAveTlQeWZWOFFBbWNlSy96cU8rWkdjVjBPMnJqK1pl?=
 =?utf-8?B?dkEvcjJtdXZ5dnF5MUpwaW9VTittTVFTSEdjbDFucDJQY2s0QmNnUFAxMjFp?=
 =?utf-8?B?WlJZc3RPMVNOSkdHQ3JoV3p3TWxJSjJHSzlNRTRlcTB4OGNsaHNDR3J4bUpF?=
 =?utf-8?B?TDVOZ21aRUZQOWFDamk3c1JRQ1c0Q0VFVzRyN2pCWHdUeDl6VzBjZk1tdWRl?=
 =?utf-8?B?TS9EK3VJQ2F2WHJRQnF3TTU4WGZFTDFBUCtnL0ZqQlNmeExkU3RYSGhRZWdo?=
 =?utf-8?B?LzVLcHh5dnI1SlVzdWU3Wnhla3lGNWszRS9YUjdGNXNXK24rRkRqcDlONGo0?=
 =?utf-8?B?aTUyZFNrbUw4RHJlTEh4QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTVPakNXUnAwbVpFSEJQaXFwdGxHT0wyMlNtdkREOVp4ajcxNlUxRW9Db0Qx?=
 =?utf-8?B?ZmN1UndJTlhDZzBrZXVkemVXcEdzUTExQ1ZRcVdKYWViTSt5aEZCMVM0bnZG?=
 =?utf-8?B?OXIySWxHc25rclZwYXdIeU1KK0cwTUl1SmxaeHRPdUZrYms1QjN0OGd2TWpF?=
 =?utf-8?B?SkRzZlRTUnJkb2NMYXFEVmdsZnpkcklCRXhLZ2M0TzZJUHpiL3c5Vk0vL29N?=
 =?utf-8?B?clg1Q1lUK3Fhak16a1UvMGk4dFc3d0RZbmIwWUY5dmUvRC9ZNUhza1BXNTY4?=
 =?utf-8?B?WXY0OE1mYkovWTJDQUlLWlh0TnNtS1RKNzhpWEZObm5rcG1ucWV1SG15b3NF?=
 =?utf-8?B?dnZ1S09BNzdxRkNsME05WWJwa3ZmVE5HV2FEaDhZSkRINC9GQ2hMSVh3Zmg0?=
 =?utf-8?B?ZE1vVk12azc4WHp5dVlCelNhZWZsRlJ5ei9uaVZqTWlIYUM1SjNWeUU5VzQ1?=
 =?utf-8?B?TWZJcTllNkN6TW5maEorZ1lyZjdyVml0amxNeFNjVXRVYVUvSUU3MWJ4Szl3?=
 =?utf-8?B?VXpqWjJzWXM0MGpEaXlsMFZvYXpneis1ckg1TmdkdlRINVA1bkkrdDVUQWtD?=
 =?utf-8?B?T0V4dVliNTdIU0pESWtBY0F6WnJENFY0VmRuZCtEOEdlUmR2UTFUaVA3ZkM1?=
 =?utf-8?B?c1J3b2xuVFBtRStDOXRjWXB6UXUyTndzbjhUZFBFTHB1SXp6d2RQeDRrUmgy?=
 =?utf-8?B?VHZMS0ltOUJ6MjBNVm41MHE1TVdIdDZjUjZiaVBkbjZzRVY5S0NZNExwL3pM?=
 =?utf-8?B?TzlqM0Z2ZW00T3o4MDUreFR6QnNEaDVWTDFKV3dhQTdUWEZtUDFxZFNKK24v?=
 =?utf-8?B?YjMrdzRuVHVVQmNWQmdmLytKNVUyOG1hNGlSZnJjRFpGYVVIWW1pNk9TZ0o1?=
 =?utf-8?B?R0orckYyRE5NQjNrSnpTb3NVOFJDblpRY0FreFNsNFkxWjlGQWRKRFZYcWcy?=
 =?utf-8?B?ejFFOWRVVlhHenYwYyt2K09MSXBvNFFTUnMxMHJWek16Z1NoQzNVbjhGT2Yx?=
 =?utf-8?B?NURFNXdvYmxnbWJweHo5Qi9xNzNLaDQ2S3pmclIvYzdCSDVmVXRoZnZQaS8z?=
 =?utf-8?B?bFM3YnZmYTlNa3F5TUYveEs2MDI3d2tpTTMxWEVjNkhIUE9ISFY2ekx3OGR1?=
 =?utf-8?B?UFZXM2ttSG1LUGhia1ZFTEp6VjV5LzRaNWZiRngyanVkZlhFKzJKU3ROL2RL?=
 =?utf-8?B?eWMrdTNIQm5zaTV1UnhKN1BtYTJOd3FMWisxNlowcWJZbnA4NUMxbE1yS05Q?=
 =?utf-8?B?Z0k5MjluSm1TTW0rSzlsUWp1TDZvR29lRHpMRkJUc0JKRm5YS1pYMXJOK0Zp?=
 =?utf-8?B?dy9qREg2MnhpSUNCcmYxOFBWeXd2aEkxczJlbk9OZWJZVUZYRjVIcG1LM0Nj?=
 =?utf-8?B?YkRQSTBUaTFYRmVtYkpVTUpIWXRPZlRGNmNmUDF1eHhUQWF6YmZDWHJSWmZl?=
 =?utf-8?B?Y3NJMFg5L2NQYU5nai85OXc5WHhkcUJRbzB4NVY3MTdQWE45SEpyYlg3a3FG?=
 =?utf-8?B?RU5XVFhsNnhoaHhDZHVMSHhxSk12ZUYvYXJyWUM0aXhhN1lJbEpyd1kyVjdM?=
 =?utf-8?B?c3RiWGZUckpwWkR0dForTmtPOVQweU1QVlRhT0RRLy85ZFFOa2M4MG1wR09y?=
 =?utf-8?B?dlo0ci9XZk1mTE51M2ZyZ1d5Z3pickZoaEdoVE1nbHNkR1VjOVJidmIvSUJu?=
 =?utf-8?B?UDRUUDZMbDFRQ3pCK3ZLRXRSUWhkWCtpQ0l2RDBlbWlLRElaUG5iODJJakg3?=
 =?utf-8?B?Ri85U0MwM0VQOEx3M1pHWmxBNmVpb0tObzAza0hVNDRhb01La0tFa2pYRE91?=
 =?utf-8?B?KytIbTRvRGdnRFpTM2VDYU83cGExSG8xOXpWUzc2Nmlpc1FFK1pHL2hIakQr?=
 =?utf-8?B?YVJtakdReEZnN2ZWdWdDK2pGbnpRNllvMGE5UWtNZ1BqVXBWRGNyWWY4bmR0?=
 =?utf-8?B?YnYyYmI3UmZzL2FUcnFEQmZwM0RjZUJkTG8yVXJsbUZ2LzRiN0YyTDR2T3hH?=
 =?utf-8?B?VG9CTUVDR3BIY0FzV1Z6ZU0vWjFuQ2N6c2M2dDJmajlORDRobXlHcWZWVnQr?=
 =?utf-8?B?emZ5STNTdk1NT1puMTFsMkgyd0lJWHRkc2JkV0YxaE9hZjduYWl1aENhTVJY?=
 =?utf-8?Q?eVn3q8Lr32aQb2E8eMEgQacTN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4278a9-9fa5-483f-53b6-08dc9b59296d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 12:10:43.2084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1AchDnNetR2C1/D6yAwNiNGBZH25apEAe7aLYYUeuZoydoqC0WyhtdDzDHB5poCz9Th5VLtwRGLatrfJKa4Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6562
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11; envelope-from=yi.l.liu@intel.com;
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
> IOMMU have to implement iommu_ats_request_translation to support ATS.
> 
> Devices can use IOMMU_TLB_ENTRY_TRANSLATION_ERROR to check the tlb
> entries returned by a translation request.
> 
> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> ---
>   include/exec/memory.h | 26 ++++++++++++++++++++++++++
>   system/memory.c       | 20 ++++++++++++++++++++
>   2 files changed, 46 insertions(+)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 003ee06610..48555c87c6 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -148,6 +148,10 @@ struct IOMMUTLBEntry {
>       uint32_t         pasid;
>   };
>   
> +/* Check if an IOMMU TLB entry indicates a translation error */
> +#define IOMMU_TLB_ENTRY_TRANSLATION_ERROR(entry) ((((entry)->perm) & IOMMU_RW) \
> +                                                    == IOMMU_NONE)
> +
>   /*
>    * Bitmap for different IOMMUNotifier capabilities. Each notifier can
>    * register with one or multiple IOMMU Notifier capability bit(s).
> @@ -571,6 +575,20 @@ struct IOMMUMemoryRegionClass {
>        int (*iommu_set_iova_ranges)(IOMMUMemoryRegion *iommu,
>                                     GList *iova_ranges,
>                                     Error **errp);
> +
> +    /**
> +     * @iommu_ats_request_translation:
> +     * This method must be implemented if the IOMMU has ATS enabled
> +     *
> +     * @see pci_ats_request_translation_pasid
> +     */
> +    ssize_t (*iommu_ats_request_translation)(IOMMUMemoryRegion *iommu,
> +                                             bool priv_req, bool exec_req,
> +                                             hwaddr addr, size_t length,
> +                                             bool no_write,
> +                                             IOMMUTLBEntry *result,
> +                                             size_t result_length,
> +                                             uint32_t *err_count);
>   };
>   

I'm not quite understanding why the existing translate() does not work.
Could you elaborate?

>   typedef struct RamDiscardListener RamDiscardListener;
> @@ -1926,6 +1944,14 @@ void memory_region_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n);
>   void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
>                                                IOMMUNotifier *n);
>   
> +ssize_t memory_region_iommu_ats_request_translation(IOMMUMemoryRegion *iommu_mr,
> +                                                bool priv_req, bool exec_req,
> +                                                hwaddr addr, size_t length,
> +                                                bool no_write,
> +                                                IOMMUTLBEntry *result,
> +                                                size_t result_length,
> +                                                uint32_t *err_count);
> +
>   /**
>    * memory_region_iommu_get_attr: return an IOMMU attr if get_attr() is
>    * defined on the IOMMU.
> diff --git a/system/memory.c b/system/memory.c
> index 74cd73ebc7..8268df7bf5 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2005,6 +2005,26 @@ void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
>       memory_region_update_iommu_notify_flags(iommu_mr, NULL);
>   }
>   
> +ssize_t memory_region_iommu_ats_request_translation(IOMMUMemoryRegion *iommu_mr,
> +                                                    bool priv_req,
> +                                                    bool exec_req,
> +                                                    hwaddr addr, size_t length,
> +                                                    bool no_write,
> +                                                    IOMMUTLBEntry *result,
> +                                                    size_t result_length,
> +                                                    uint32_t *err_count)
> +{
> +    IOMMUMemoryRegionClass *imrc = memory_region_get_iommu_class_nocheck(iommu_mr);
> +
> +    if (!imrc->iommu_ats_request_translation) {
> +        return -ENODEV;
> +    }
> +
> +    return imrc->iommu_ats_request_translation(iommu_mr, priv_req, exec_req,
> +                                               addr, length, no_write, result,
> +                                               result_length, err_count);
> +}
> +
>   void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
>                                       IOMMUTLBEvent *event)
>   {

-- 
Regards,
Yi Liu

