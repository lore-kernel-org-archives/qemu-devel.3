Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93ED6C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 03:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbAYh-0001o4-3q; Thu, 23 Jan 2025 22:40:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tbAYf-0001nR-Cp
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 22:40:37 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tbAYc-00051E-Q8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 22:40:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737690035; x=1769226035;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VbgWNG5DDbWPbzvco+OgetXRMB6vf8Z2AIDU1BzVdz8=;
 b=DNagvG29PJXEAKCCnx1LAyGuLoPqThGM8r3dkaTe7iCopUS8qC3tTSiw
 wCWHLSHHxrJh6Fe7x0HUbqJEIuqkzwVId/ypNU4iiwGToti8n6SdIkoeP
 z0JX6tZUXMS5ymTffhribhJVPYX81Ut7+HsK8Yu7InRd2To+DP/9N+zE0
 +axo1af68kKC/51an4b9cAZy0OgipZxwRR2eKfnnelUDGBe2NX0n7wYie
 aRVwBLlYYfQ6ML5qKVkqQu7eD0FaDehQT2WkTHyEXlLXtsORvmWlcN6zO
 wVz6Rx+8z06mv4cjPLKc4/Y8id5UTuU+sizi5xduOvKqAlJ5/arY/4/dV A==;
X-CSE-ConnectionGUID: +/sj7oJ1QIuMQbdUNvkMJw==
X-CSE-MsgGUID: /+a4oQOzSxaZtP22M1gGmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="49616048"
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; d="scan'208";a="49616048"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2025 19:40:32 -0800
X-CSE-ConnectionGUID: akDwIP7xQrqj28nZER0vjA==
X-CSE-MsgGUID: tXEMxpmBTaSq7Pjxie8fIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="144899232"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Jan 2025 19:40:32 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 19:40:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 19:40:31 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 19:40:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wX68UoLNBdZTmUxQjDH3adf7cki1+ZHN1KW/vwCBrdcLkcBaZJ2fJX7Fwzmio5rNINp6h8V9s9PG3Hz/SF72ogYCxwLMhl1Cq4M/0b6xbk/R/LxlCq5fdPV0GGum2CdGv91O5P3OvBS7Z06zJ7QrSYf6Eo/dtNO2wnWnIlWz7yeH3c9e+adJAX337h6Go7LlkbA0Ruhl/ONO/ldH5i42GWyONTlcB1kaZ4S37+IR85i9+kB14dvaGfgBwr2ZHRIYdQEzcEL1fl8LuaEYyyfPaWzi5cRBXvMAM+GuhoqUtQti9CelIZOdPSdxr9ZYJy4k+3xAnOr7VqRrgaUsnlxbfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2ks++zETErGOgzqfH4i8afvO0S6JCetZbWtldu4SkU=;
 b=mbsPy4NywRuexFO1JB1egiF8HdEhH+Ww4oX6NehH8eecDrzqnHRYDPUo1YsWubX1jKafjvxoazwHSq84CRgDDob3C0kltp1Fb/IlFWe5ZxpO1ckwRJUdzxB2blNyhIQkesmBg6Xbitf2uaOzBVe3aZYf9IoQbbRUAAa9pjbBeJ2twrQgW4Zz2YRJErQ5WHNcjvLaA6SKgYNztU156dpUno+h0Cnmvqgu0PxDsl2teMN0yavLuqvoLw0BEsLswBhNnTRDH2ctqPeGjBdhhGrk3Fa3LW545LRJX7CR47R0B6xHZMipnU2t1zqyH3wxSFWFBSMcxzG91ReI6b+88WYbtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 BL4PR11MB8847.namprd11.prod.outlook.com (2603:10b6:208:5a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Fri, 24 Jan
 2025 03:40:29 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 03:40:29 +0000
Message-ID: <b55047fd-7b73-4669-b6d2-31653064f27f@intel.com>
Date: Fri, 24 Jan 2025 11:40:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] guest_memfd: Introduce an object to manage the
 guest-memfd with RamDiscardManager
To: Peter Xu <peterx@redhat.com>
CC: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Michael Roth
 <michael.roth@amd.com>, <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>,
 Williams Dan J <dan.j.williams@intel.com>, Peng Chao P
 <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>, Xu Yilun
 <yilun.xu@intel.com>
References: <20241213070852.106092-1-chenyi.qiang@intel.com>
 <20241213070852.106092-3-chenyi.qiang@intel.com> <Z46RT__q02nhz3dc@x1n>
 <a55048ec-c02d-4845-8595-cc79b7a5e340@intel.com> <Z4-_Y-Yqmz_wBWaU@x1n>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <Z4-_Y-Yqmz_wBWaU@x1n>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0135.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::15) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|BL4PR11MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: 8858bbd4-e0a0-4780-dfcf-08dd3c28d8f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3Fsb3NWTVAxd2w4NGRBV1RPV1pBZWJSeUkveEJCZTVQNi9hVDBtLy82TDlE?=
 =?utf-8?B?RDdRa3J1M1JBK3YvRUZqa2RmK2lKRVhUK1dDQjMrUDlNYVp3TC9hMDBHQU1u?=
 =?utf-8?B?YUpBWW9McExMLzJSY09xQnNrRnJXQkZYLzBMYjNzN2xvSStYY0dvSm9TTWRE?=
 =?utf-8?B?MC85T1VmcDl6cjJXYzB4ZVBWSjR6ZzdraUgreTJOeDJyd0hGc3dvV2tXdXZH?=
 =?utf-8?B?QUhBUXlUV0hUNVJHcFo0MzNQUG1xUmRRRmxyR0dVUGRralFwcnBJVlc2cEtq?=
 =?utf-8?B?bm4zK2xwanBLbjZjeml2Zmd2M1kvOUNFL1VoWURrZHVWZDhka3JsMnVrQWVo?=
 =?utf-8?B?dHdkK2diYnJzbFIxS2ZETEZadi9UeWdJRFZ3ZVl1SnBaS3BmNjRxck5vM20w?=
 =?utf-8?B?c2tycXUvVVZKOW1QU3A1MVYrWWpvcFdwK01MUnZNOU1XRnM3dVBvbmg0dHdp?=
 =?utf-8?B?K1hIWEhJMVFxRFdsQnZRdDJKOVJVNGJ2bzY1T3pvV2RGbVNEd1FPeUh3ZU9k?=
 =?utf-8?B?OHBya01rVmp2akhhWUlUbzFrekN0eENVTVdzamNLQlZqTE0wYURaTW82bVcy?=
 =?utf-8?B?NCt6M3B1eTAvbSs1NGtxV3k5RXY5bmdWUG10bjJldHU5TCtOTllyNi9CcVZ2?=
 =?utf-8?B?QlFiMzdLK09KcEQxdmxmQ0U5R1Uyb01DOFVKR3kySFpwUGhmdlhyYnQxZXhv?=
 =?utf-8?B?T0liT2x6enFpQnQ3SmRLQUdXb0FEOFI4eElLWWFtbE84ZXloQlBUNUJhVFRN?=
 =?utf-8?B?L0dXR2hKcmZWMENmNkpocndiOWtmc0U4THJBUmx1MWpFaWhaZzdiTDNIZVhy?=
 =?utf-8?B?WW9WOC83S2JzSzl1K2NmUGlZV0pQcnlSWnFqYzdVNFlCdkMrY0J1ckxFRGtk?=
 =?utf-8?B?cEw2aGc1NFBDc0dEbVlYRys0Zk1RTk5qVkxXNHUxZWZOak1kTTAwWmVUdTN5?=
 =?utf-8?B?YVlkN2JGb1RKdXkrWFRySThvcmxraEFMY05LNzdrYmFaZS9xRjhrdWMyUG14?=
 =?utf-8?B?Vi9OZGJvNXprWlk5Zy9XS3RqNWdHQXhoZEFEVlV4Q0lmRzNvTWVTbXYxTFhr?=
 =?utf-8?B?dm11Rmx5TXoyR3NBcE9CdDFCczlZT0lTbkdqQWw1TkQydDBxZ1FCTGlON1Q4?=
 =?utf-8?B?NWw5Mm80d1FYZUM4VVJxdTJsWC9ydjZBelRjSmswZFhtN0lBemtsajh5RVEz?=
 =?utf-8?B?WWtWQlB2djJoMmV1bTNma3Vld01EZVdoWXk3bmFMSEhJd28rUXplWkNreTA4?=
 =?utf-8?B?WEgyUk5VMWdQWTlmUkk1RjZCUGlBSTlUSVBDdFMxUXpQeUw5UjMvV3pnR1BR?=
 =?utf-8?B?N1hnaGxKcm0yM2RIQjAwalFhempMQXhoREdIaHltSUVoeEY5dDhONzg1SWpk?=
 =?utf-8?B?bDFzcCswdTg1Y1NGQ1Q0TzNMeVpoa2JLY0hKVkZ6V1kyNnU0N2hNeEZZRUp4?=
 =?utf-8?B?TzQxTGF2TC9xWkpseXVONGdCVVVJRko0aW5EOWVXOVljanlEekdTRm9Pa0dJ?=
 =?utf-8?B?eVdWNlBEV2dveVhzUVRvSFdGcE0xOHUyTXBOa3lQVXFUU0NRTUI1QkxqNGNi?=
 =?utf-8?B?bGJjU1oxUEZITHRVd3pqTEwrUXdRVHJuSzMxZXR5TnZuR3dXRnZmVFg2SW43?=
 =?utf-8?B?UGdQUUpRS051UXJNM2hZUGRhNHZnYmdML3NDVnJTOG85VXFKMDdpdUJGTU9J?=
 =?utf-8?B?RkdMWC9mUmxwcStTSWNqZWpGZGM3R1BhOHBCOEhRVytlWmdtVGwvK01PWStX?=
 =?utf-8?B?ek1hSUxyaEdhWG85QnNLbXEraEFDTWpzOWxSQTR0dWt4bGVYb0cxZ0xxVWV5?=
 =?utf-8?B?YitNbHdzZzVJYmxVa09GUjZUWUg1OTM4MzdhVUdVM3JSeGM4bXFnVDcxTHJ2?=
 =?utf-8?Q?ueNf7lv4F3fJu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?citaV2FWbDhGM0ZjbitGK0hEQitLWFlHakdWK2ZJWVhRS25qMHkrZGdNR2Nz?=
 =?utf-8?B?eHBiUkZOTU5WYVpOUGxhMHptRXhvZlhoSzRHREo5VmUrQUNEUVBJcXFsNk1P?=
 =?utf-8?B?czV4TXRMQ2RPaTZUaEpmOWhGUmp1UUR4Nkl5b1h6Z0FSYzg0OTBvRHhCY3Nk?=
 =?utf-8?B?dlNSZ25lYVFmRWEwM1hhVWhaVDVHYUhrM3AzMWFEdE1SeW1Jc2NlZnhPUkZr?=
 =?utf-8?B?WXY0VDNocnhwZEhZNUlzS3FZaUJGZzdsZUs3MjdlN2dmdkFXUE1ycXRJcjln?=
 =?utf-8?B?QnJCS1ZSa080K1ZjbW9qSDMwYzBGZ0s5TmxpU1ljYzVzbi9oc09MbHZrQWla?=
 =?utf-8?B?ZC9XdFpFRlZvTXZlczNwTU9Bc2Q2ZktVcWIwa1lIMWFwOXJRVkJMK1pFbHlt?=
 =?utf-8?B?Tm52OXh6Rmc3TVlGRkZFODNBSXZ4M3c1Y0Q4U293TU15bVhyaDZ1ZEZrZ0ZR?=
 =?utf-8?B?bERmTThObWs0R1VkcHR3TlZ6MzlJM0oxQVAySTdkTTBnUEFKMFk0TE5rRkI2?=
 =?utf-8?B?Q2RZWmlkbDNGd2s1U3VWdURBRVpkQkxoMzMzdUFxc2YwbmpSL25VUGlmQUky?=
 =?utf-8?B?eUlFOG9LcTMrKytrcitKY0NYZGQxT0Yrc0crT3NGNVpNOHI5S2Q3RElhUE1i?=
 =?utf-8?B?RDU4aU1VSWJ1VFlNaE9FYjlINmRBaU96UXBkWHFhTVN3UGdhd3JRN3VqUkdH?=
 =?utf-8?B?VlN2N0hXaXA4all0Qm5mWkZLcCthUmFwWVFzd1ZGZlZ1MkpwMkNBQkg5NTg4?=
 =?utf-8?B?T0N4M2ZZdG01NGtmVVhiRCtIOHpOTjhlNytSWThWUDFGYVRnVmovUWdZSFNQ?=
 =?utf-8?B?T3I0eTdndXRKRlVFdm5VdVdWSmtJZks4MVBnTUZ2SVJ5RGh2c25nbWtMNmJm?=
 =?utf-8?B?Tzk4TlROQmQyRzRLZ1ZSQytqU2RjUThjdk9TREV6cjVyd3JYT0FDUmJrMXFx?=
 =?utf-8?B?T1VwT1dRSlI1cGY5OEMvZkl1U3BIaGVSclhUcWlJSllhNDVOQTdFMldJU0Zy?=
 =?utf-8?B?OFhVakpUenFtVEROMm9qVXVVUi8rWS9GU1l6a0UwdDhpUlBBQTZ2L0Rud2R3?=
 =?utf-8?B?bDdnRWJwZDBOYUJMOW5iU2ttRVdHSmJabi80WStpemwvNUZUdTNjeTBGM3Rm?=
 =?utf-8?B?eW14eDVWaEZBRHRDcG1sOUxBaUlFcGw3Z21OaGNTb3phT3hFRGorSHkwaHln?=
 =?utf-8?B?aG5GM0hhNmtycE9wanpRZHFZRE1ra1oyM0pvNmZ5bWdNVStwRHd5TjRzcXlK?=
 =?utf-8?B?WjNZU0k2dmR0djh3LzZmSkVZL1QzYUJKdTZKT2Y5UDgvRlg3Kzg1dlFTOVNy?=
 =?utf-8?B?T1ZZTUc4bVlDRHBpZFNGYTZWMHlFZjRsd0xtaDF2ZVYyZld1YnA1MElOdi9p?=
 =?utf-8?B?UnNwRWN6Y0FKK2l1RU1FRjNRdkIxZDgwNGJJeG1JNHpsVS9HcVJraEN4UGI5?=
 =?utf-8?B?NE5tam5vYk0zcU16c3h1YzFjZWl6ZWh5ZUcxb3FWckJJS2R5cDN3MWxRUVRS?=
 =?utf-8?B?OTJiSExXdDdOZW1oWTY1Y05iU04vYzBaVFZodnpqRjZxVmFnb0NnM1JvSCtU?=
 =?utf-8?B?Ujc2SWE5WU9sNTRsTXFoaFVwNWNvejJ0R3pZUFVJMWhjalZHMGVrcURwWVlB?=
 =?utf-8?B?Ky9uODR1S1J3VFk2aityVnBtQjE1ZEV5cGo3RGhIcGJEUElHaUQxRFRzLzVl?=
 =?utf-8?B?TUZaa1JTeEtYU2RTdGZ5UWxITjkySENMb0tMcTJZM01ycm9OUjdmczdmaDBo?=
 =?utf-8?B?S0tuWmRIVS85dkkvVVBPTS9TMEM3L2MwUTdhUDBsNVVkTWxuUm9LczA2TTZS?=
 =?utf-8?B?eko4Y25xdTg2eU9DR29vZ29mYWhyTVVjMWM2Q3kvT0hZNnMwTDZqVUpiUVMz?=
 =?utf-8?B?dVp2WU5DZFpWSm5UWjhDVWVITzduSmZQV2JyRFBWUFQzNG91T1Y5UmVZVnVl?=
 =?utf-8?B?RkxNSTlvU1hQMTJyT3pMdy9rc3g0Q21jYUM0Tm0zdmIvcDJxbzBVdDFSb2pB?=
 =?utf-8?B?YzdBTkhDa2tOSStTK2gzWUNIV1l2Z0txcStNQ2d2RDV2Y2k1OU5LbnFrNHJP?=
 =?utf-8?B?TGxUdWV3SHNldU40QklETSttZlhWYnh0cjdnd3c3V0FIL0tkRTNnMEErQzEz?=
 =?utf-8?B?MVhMQm41Yml6dTg5TDJRbGhOUmNaNjJ5b0pHMkovd2s2cnBkdGFVRk9ZNHA1?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8858bbd4-e0a0-4780-dfcf-08dd3c28d8f9
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 03:40:29.6157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXGguDeYd4N6hUBD+dz7KeqwGmOdRDTPGUfiFRi+qh4y4bPKtryNU28GxCwir28SLPSFuuF2PYrKXpt/Hc8uHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8847
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

Sorry I missed this mail.

On 1/21/2025 11:38 PM, Peter Xu wrote:
> On Tue, Jan 21, 2025 at 05:00:45PM +0800, Chenyi Qiang wrote:
>>>> +
>>>> +    /* block size and alignment */
>>>> +    uint64_t block_size;
>>>
>>> Can we always fetch it from the MR/ramblock? If this is needed, better add
>>> some comment explaining why.
>>
>> The block_size is the granularity used to track the private/shared
>> attribute in the bitmap. It is currently hardcoded to 4K as guest_memfd
>> may manipulate the page conversion in at least 4K size and alignment.
>> I think It is somewhat a variable to cache the size and can avoid many
>> getpagesize() calls.
> 
> Though qemu does it frequently.. e.g. qemu_real_host_page_size() wraps
> that.  So IIUC that's not a major concern, and if it's a concern maybe we
> can cache it globally instead.
> 
> OTOH, this is not a per-ramblock limitation either, IIUC.  So maybe instead
> of caching it per manager, we could have memory_attr_manager_get_psize()
> helper (or any better name..):
> 
> memory_attr_manager_get_psize(MemoryAttrManager *mgr)
> {
>         /* Due to limitation of ... always notify with host psize */
>         return qemu_real_host_page_size();
> }
> 
> Then in the future if necessary, switch to:
> 
> memory_attr_manager_get_psize(MemoryAttrManager *mgr)
> {
>         return mgr->mr->ramblock->pagesize;
> }

This looks good to me. I'll change in this way.

> 
> Thanks,
> 


