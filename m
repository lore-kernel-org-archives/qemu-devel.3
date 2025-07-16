Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87ABAC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 09:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubyHH-0002A5-J6; Wed, 16 Jul 2025 05:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1ubyGt-0001fO-Dy
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 05:17:51 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1ubyGo-0006lP-RS
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 05:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752657468; x=1784193468;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fg8a2QyCw3xHwIIazAWnSOOFuNvUHnyqLbrzialO3KQ=;
 b=Adzo/poRwgtDd5n7unsnz0bvJ+kp3Ctl4UGUkcMj1sZ9wbEP8xp/8Zl3
 lfXRZhJzuNvfgvSgu5LJwERsJu4K2B+vu+9e+3y7ztuZtw/BnejfWOYAx
 M7m59UKdTk8/QGfi81qEXHsuImwwBunYwjjy3KvnP0JCwJc7IyB5/gj+P
 YINETSkuGSmqhaM1BJ16zwfCf7bSlwDLB7Ces1P2447mfUZTQdfML9/KZ
 3LfiNDhf7vjgdxEE5rYckQdAb0KIwfdDuPfbC+2WsNc4xBM1T1RBoIewP
 8PSX5X1mpAE5C8SWakENNGzT008csu7xVnKkZrC+gMyyibxp3b29n7fUx g==;
X-CSE-ConnectionGUID: HRYPwEuZRhWbSgZngEVvtw==
X-CSE-MsgGUID: 0t5RKci5QVSSJjwtNIwDkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="66342918"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; d="scan'208";a="66342918"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 02:17:41 -0700
X-CSE-ConnectionGUID: rWXTVsDiTlO1Dqhzuw++TQ==
X-CSE-MsgGUID: xKRRyT6hTPSQPp9tY6TGww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; d="scan'208";a="161476125"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 02:17:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 02:17:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 02:17:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.65) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 02:17:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N398FwzAnQ+QmO8wtmQo2HJwZVZYodFZy/iWKtqih/XAKMNb6F10wJRozEDhieoCmN7MOJ7zmJNeprRC6oj4EJmTZc/KGCvFnUgnwrca6QWhkNmjSfJVgNF7U7cM5aZbmsfSbuVZzImufbQXdqeITlXOxCsBbo0pzVBptxP0zQcEZHPQjItAf9jpHQ0YHYTDoSXFoXcPl6pDryCAjMZdAdAU/eLAxsUFnATNxcs5z8UlpoUhsvqsuX7p0r2Y0Q4PXk05FzbnXbRS5aDLpgnYejtUksIIzADNUvTXA/iduER1NrVpLdNnXHkq8QUQsAQL1aLOIffPhvD9W/oTXjsNOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BG0GehV+xnk3kFKVgHGb+oe4XA80L/EXXnPtx1/2Uck=;
 b=IGKN7yR9dC24I7eOfCHt5LinaF0Z7oD5bcrGTVlukOQBJBzZfWummsE6HCyCzX9t8SC5YsWs/PyAf1YdQrN5NkVy5UC4UxjnXMqwdPfSZAZF9TDWlbtuBmhN750MUkubiBiwnEJVmgYbbf4A4b6t0eD3nLekGKTOhWW5VN3q3X645m9KhbfQdO0cpzqh1ksEAJp6OIQ/R3IWoS1DBo+lYmULRd3znqvrZuTGdqOPv5dJ9yDseE2eoAMc2lS4W/B4jnjHyc9+egoMZlVuT4BopS02RD26rCKD2emOYwKgZHSqBVPcjWzz/re+VoEZLx43BUV26u8+UFFlZiJ/yiBKpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by CY8PR11MB7729.namprd11.prod.outlook.com (2603:10b6:930:70::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 09:17:35 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.8901.024; Wed, 16 Jul 2025
 09:17:35 +0000
Message-ID: <80e9a8fd-e03b-48b0-856c-b8dd761a774e@intel.com>
Date: Wed, 16 Jul 2025 17:23:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] intel_iommu: Allow both Status Write and Interrupt
 Flag in QI wait
To: Konstantin Belousov <kostikbel@gmail.com>
CC: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>, David Woodhouse
 <dwmw2@infradead.org>, Konstantin Belousov <kib@kib.kiev.ua>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Le Tan
 <tamlokveer@gmail.com>, "jhb@freebsd.org" <jhb@freebsd.org>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <0122cbabc0adcc3cf878f5fd7834d8f258c7a2f2.camel@infradead.org>
 <9ce8b7e6-ad15-4d2e-a430-3896eccc7519@intel.com>
 <4FE9A8E3-5BA5-46D3-A1FA-EA1B7C85C058@infradead.org>
 <aHV0-wDJImAjRPPp@kib.kiev.ua>
 <afe3881b-1193-4d89-b0d0-6c316e54684f@eviden.com>
 <7cf6b91c1e1ea8b50d116f738215bcb55732b214.camel@infradead.org>
 <d84bdcab-3d2e-4731-a9aa-b8094fbaf7e8@eviden.com>
 <1d00dc9f-7647-4aa5-9ca5-987a06ce4292@intel.com>
 <aHck8KHvEJqrRJ2s@kib.kiev.ua>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <aHck8KHvEJqrRJ2s@kib.kiev.ua>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0204.apcprd04.prod.outlook.com
 (2603:1096:4:187::16) To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|CY8PR11MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: c42adc8f-9091-4dc1-4f57-08ddc44999df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|42112799006|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGJrUmRKNk5VY05zMDlNNHBwSUhRUGUrMCtYOEFSRnp1bFh4K2dGNGRXZGtU?=
 =?utf-8?B?Z2V2Q0FTTFVRNzJVTUFxMTBkT3NkZUdnWTFIS0FTVjB3ZCtOczBPZG9KUG9r?=
 =?utf-8?B?bjhSZXAxSlRZQXBjM015N1R1ZjJZZFpvWjlGeW5sZnJJU0JGVlRRbVlJME94?=
 =?utf-8?B?QWorajU2UzNxQ0lIaURicDFBbUcrT0paZ29qY1R3THdaajlYNzZoVENMTHNZ?=
 =?utf-8?B?Y0ZNcjhtRlhYemp2SndtdmZOb3h3dmlPTjdTUUJFS3dGUHUzSUtXSDcvNkxw?=
 =?utf-8?B?ajZ3ZTBDb0RYd0lzT3BGM3hwV2lzWUFVRGRnam8rSzN4dVlBaWxyUEpRZmZM?=
 =?utf-8?B?RGExZ1ZlOW1ONVQwOE5yRnlMVGhKWDlBT0hZQmx1cVB4bEtLZjJaMFB2MlR5?=
 =?utf-8?B?YjlIY09UOWlheDdLbldWNWE5c2pJWWJ4ZW9tQWYxMElqZTNHa20wb21UZXRT?=
 =?utf-8?B?ek5kMGhoUk0zK1VEMytIVFkyZDJNandySG4rcFBsRzdhWGhrYlpMT2FJU2dH?=
 =?utf-8?B?TEpOdUlpcUZFQ0lqMmhJbTFCSjV1OFZqSWwzOElwMTJCK0tXcXhKYmF1Wmh0?=
 =?utf-8?B?ZlRNNkJrazBFNC9jT2p2WHM2SmlsMGRkNWVFWGFHdUQyQ0dyMUNtenFYMVVI?=
 =?utf-8?B?K09WNkhMZGtCUVYrb3FwOG9XZkRmcFVRai9QUmkzK3lHZWxDUE9nNEVzeFV4?=
 =?utf-8?B?Y29xL1lRQlNTUVVoNkRXUjZzL2ljN1hpd3h2WjdYbVp6V3ZDQWdzUjdsUHB6?=
 =?utf-8?B?Y3lUdGtlRkFPVU4xQzkrVHpxWklTZ3pqSVVKNWZxeklHVHpnOG96UkxGMkNB?=
 =?utf-8?B?MVdUeFFPaGwva3BzaXQxeDZGaGNwbmRqRno1M29keHllTXdwNzV4Q1Z1UGlq?=
 =?utf-8?B?UWNmWFVkclRnYWNHeTRDWlB0OEFubkxjaXBPYVlwTGV4dFNGQVdVdG5rKzFi?=
 =?utf-8?B?K1lGSVlLM0NBOTRWSC9YTnhHaXJuSjNtLzJEdmVRNjVyVk02bldtSUhvbEN1?=
 =?utf-8?B?NEtWTzVlQkNJeDdORVFLSEt6WFpTRlZXVFo1Q1BianFlZzdCN3dZT0VxTncx?=
 =?utf-8?B?MVplb0s3Rk5kalNZVitOaGVIRXNlNFVrQ09JRDZrRitsT3YzanZlZXExNWRB?=
 =?utf-8?B?cFpKcFZ4Wm52NVRsQUg1K1FqTUROcDg5UjR2R3FGRXRjODhCNVBEMkF6NG9q?=
 =?utf-8?B?QkQyd3pVWWsvTEp3QXQ3Ni81Qk14SndTM0pLQk5KbUJ6UE9OZE1rUXloN3BR?=
 =?utf-8?B?WE5nbk1qckpPOUFlaWNnWXJjcEVFSnlRblBlZktyVUtSdTVZcnp2STNpeVgr?=
 =?utf-8?B?ZE12d1NpZ21LZFFZMStzVmVJWFMyRnJDaHdkZTVybFRZZTI3eThlSitVK0VT?=
 =?utf-8?B?VUorbUNVS3hxMVdvUDBVZWt5a3lQcDJTeURsM2ZYdVZ2eE5lb0NuQWwrcWJO?=
 =?utf-8?B?RVZLaHRQWFZWOTdTc0NtRWl6V2tZbXJ3TGNvZ2ZVV0tvRFc2ZUxPaDZHWHly?=
 =?utf-8?B?OW5BK0NkL1NVbE0vaWhOUVJZWXVTWEtqamxpcHNMSVNWZUdLbEtvZGxvWHdY?=
 =?utf-8?B?aGFVNlVmWjVROGxRaUdkaVRsdmM2RnZBbm5Ba0VtY05ndHRDR2s5ZmMyb2JC?=
 =?utf-8?B?OCtpckJpa09KNEFwRkxoN1RJcm5nKzNTdlBHY040STVzbHpvRHJiaGxnbFRn?=
 =?utf-8?B?bVZDaHdSSU53MXd3dThranFFTE5LWlpMM2diUmthTFRUNk1GaFJGWEZtT211?=
 =?utf-8?B?RGtNTjMxblBjRUpHa25acGQrVXRxR1MyM3ZvMTN4YjV4ZVFDYlpwQkJQVDlj?=
 =?utf-8?B?U3FML1N2YUJvVitJZGQ0aWVFN3c1NXFZeDRqUFhIQ0hNLzIrb3A2eXJUcWM3?=
 =?utf-8?B?bENXc2tFU1BkcUh2YURTSlk3WnEwOC9pd3N5dFMwcEp0QTNXWSt6b0UwVHVK?=
 =?utf-8?Q?cogfa1i3bfU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(42112799006)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFFUTk9mVGZmVXB5ZTBMVzVFNlpsaDZldlpKWHBmS3cvYkpoUWE1REw0eFll?=
 =?utf-8?B?bGpaaUpHbGhudHBoelE3elpNVkZRWUhvY1VuSEorTCthaGZ6UXpDeTBiZkF0?=
 =?utf-8?B?VWNPWFpwbG82WGkrQkhqTzBkak0rNHpiakVmTldpMDd4VXJNd1JLL3ZFR3Yz?=
 =?utf-8?B?S2J3aWJYMTM3R1BSY0hlWVk2dGFBcUVaL1ZVZHlLQ01UVE1IY2dTaG1DZnJK?=
 =?utf-8?B?b1FxYm9naXl1dmhBSEYzdVlnZERoOFgwSzd4SzEwWUh2NEpuNEk1RDhxOTh4?=
 =?utf-8?B?TGpQSzgzT3JaV29KeE5teU5TbHhoT1B6Z2FEbW5PclFhRlhsd2NlajNKVS9z?=
 =?utf-8?B?STNPcVBuVXY4OEVoNXFXeXRIWi9KY0UzTXA1S0xEdmZMYXVpZ2NaUkZwYXZt?=
 =?utf-8?B?Mi94U0ZuVkVEMnJPdFpMRUFPOUxtSlZEMlJiTHIvTXNCTzZHQit2NzUvdE94?=
 =?utf-8?B?TVBsRnk1cGhWT0wwaFdCeWNBb1poSmJuc2w1NkxCQTVWdDlvODQyNFJ6TEJR?=
 =?utf-8?B?eGI3eGM5TmpGZ1QySC9yR0lGaHJ2UjBpcDVmZS8wczQ3clVHS1JHR1BoZXZU?=
 =?utf-8?B?alFZK3RlbDB0Qldab2tXVW9KR20rMjJOTmZJcmdDdjRBc3ZpY1BjaWxycit2?=
 =?utf-8?B?dEN6cWhQTHBhQmoyWnJjNnkxOUZCM3NUM0ZqS3NaSHVwbjlmeVNBT0pEbzh2?=
 =?utf-8?B?a3pNZ29MZnRCTVA4UUpGR1AyRFAxRTlROXFaMDh5UEwzTGRQL2dydEtJSVZE?=
 =?utf-8?B?d1dQTDRQaEVYZ3Y3MEJlVDA0UDV2R0t0eUxkQ0NiaUtwdHZXell6MCtiVVBN?=
 =?utf-8?B?Y1pndWhDZ1FITVk2OWRieGd4eUcvL09BdjE3Vjg5N0NRVlhjMlBoa3BRa0tO?=
 =?utf-8?B?L1doOXhyc1JMMm9iaUtYTFNXUHpqcy9jY2dWcTdnMTRybW5mTE1JaVFJNVFE?=
 =?utf-8?B?aWNsRlExTHdESGw0VmVZNnBvZzdJbmxvTmsvQ2p6VHJzU2JMRmF4bzNuUFk0?=
 =?utf-8?B?cEs2RWI3c0x4U3ZyeW9XL3VVN2R0cUc2bFpBNnNDdXBrbHp2VS9JcFBlSFo1?=
 =?utf-8?B?S1FJZW5uekQ5MTBTNTdPQzN2WkRxRC83UzlRcUhkTUVoRDBUQ01RYTVLdXB1?=
 =?utf-8?B?c0d4UGZ2bUZnVzhobmtPVDlmdjI2WTFtMFZiWVhESlNvNEsxcytYRFZtTU5h?=
 =?utf-8?B?MjIxWjlTdy9wSjJHSDlzZmRwSnFoMERmRE9heGQ3Mmpra2E5aFZBNnVLN1ZO?=
 =?utf-8?B?N1I0clRna3FJSlJKTVhBUUZpNnBrWGZqNXJoSjFJWWdZNWtUTjNERHQrNnZh?=
 =?utf-8?B?RHcyRE45U0llQ29zcXRydkdaZVlzM3JnaWhDQkRvZ2plWFZ1NFBZRURyUHRZ?=
 =?utf-8?B?azFpQUFpdkhORVhuejdMTk1EU2hJUE5tbXE1VEhQUlcvVlovYmQwSUIwbmYz?=
 =?utf-8?B?d0tTdFJuSkNqcTlMUEN6K2N1c05vWFlNNEJSbGtvQ0FVaEtWczdCSnpnVDlv?=
 =?utf-8?B?c0x0RVV4cnRqWWJwK1BuRVBDOGFYWkErUG0wSnFOT3Zib3FSdFVZb3cvdFR2?=
 =?utf-8?B?MDd6Y3ZJcG9TOS9iMExHby94WW1tUUpiVzVGQlY2UG83bXNwVEtjNmVacklC?=
 =?utf-8?B?MXRXaHN4VTZ0TjNOWllrbmIrck1wM1lVS04yNlArbTlnb0tQSjBVRzFVaVUz?=
 =?utf-8?B?MGZGNmRnWGJucGlzeDFWSEpFak9uYWFPamV5WU03TmcyK3VpR0JUZXlweDNN?=
 =?utf-8?B?TXBoTEhMdXVmMVVyN2hQTW5MS0Q3dExBZThwa0Y5K1I2YUhDNnlJeHR0TC9y?=
 =?utf-8?B?TFYwWmcwdzMxRCtWUzNueGd1ZVhKc3B6V25OSCtWSnlpVVQwVW14M1R2bzB4?=
 =?utf-8?B?eDFuelNTMVlGVDVlTzZ5NVVsMGJVVVFiVm1MNGI5Q1RRWkdNTXZvK2pSNTh0?=
 =?utf-8?B?OGlTMjBZK0xRbmZJSURVbVl4b0NuekdpZDY1N21ZV0JXZGJVbkR5c0FHaHFJ?=
 =?utf-8?B?b3NYcE1SSk9BUDEwWXZTOHd1UGlRbEhBZTdhQS9HWlY2QTVuVW1qbzJ6cWdv?=
 =?utf-8?B?b1pIank0OUNMVXFoYU9aQWc0SmdEcGRqTWdDd01YVUpIMm0wVFBNZ0pUQlpl?=
 =?utf-8?Q?8IUqD3TkaBMdeGEoGFefjG4bC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c42adc8f-9091-4dc1-4f57-08ddc44999df
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:17:35.2364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7HQ/1GWVaYC/JSYC8+IwpHrTnlJRroBDnfaN/3zT/7ga3NNY6TPuk5BTzCisdeFBvG9xamgLZgQZNZPrL8x/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7729
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2025/7/16 12:05, Konstantin Belousov wrote:
> On Wed, Jul 16, 2025 at 12:01:44PM +0800, Yi Liu wrote:
>> On 2025/7/15 20:27, CLEMENT MATHIEU--DRIF wrote:
>>>
>>>
>>> On 15/07/2025 10:27 am, David Woodhouse wrote:
>>>> On Tue, 2025-07-15 at 06:11 +0000, CLEMENT MATHIEU--DRIF wrote:
>>>>>
>>>>>
>>>>> On 14/07/2025 11:22 pm, Konstantin Belousov wrote:
>>>>>>
>>>>>> On Mon, Jul 14, 2025 at 05:41:22PM +0100, David Woodhouse wrote:
>>>>>>> On 14 July 2025 15:28:09 GMT+01:00, Yi Liu <yi.l.liu@intel.com>
>>>>>>> wrote:
>>>>>>>> Hi David,
>>>>>>>>
>>>>>>>> On 2025/7/14 16:00, David Woodhouse wrote:
>>>>>>>>> From: David Woodhouse <dwmw@amazon.co.uk>
>>>>>>>>>
>>>>
>>>>>>>> I think this "if branch" can be moved just after the inv_desc non-zero
>>>>>>>> reserved bit checking. Hence you don't need a ret at all. :)
>>>>>>>
>>>>>>> We want to return false if the memory write fails, and the
>>>>>>> interrupt has to happen afterwards.
>>>>>
>>>>> Per spec: "Hardware behavior is undefined if the Status Address
>>>>> specified is not an address route-able to memory"
>>>>>
>>>>> Do we want to trigger the interrupt even when the DMA fails?
>>>>
>>>> Yes, we do. That's a quality of implementation issue. Just because the
>>>> behaviour is 'undefined' and theoretically gives us permission to do
>>>> whatever we like to the guest, we should still be as sensible as
>>>> possible.
>>>
>>
>> Personally, I'm fine with generating the interrupt even the status write
>> failed. But to avoid potential conflict, I've also raised this question to
>> the VT-d spec owner. Haven't got a clear answer yet. To further understand
>> this, may I ask some dumb questions here. Why FreeBSD set both SW and IF
>> flag. What is the usage model here. Would software consider that all the QI
>> descriptors prior to this specific wait descriptor has succeeded when
>> either the interrupt got invoked or the expected status is written back?
> 
> FreeBSD queues invalidations, each invalidation has the gen number. To
> know that some invalidation finished, FreeBSD waits for the interrupt,
> we do not scan the invalidation sequence word otherwise. There might be
> further generations of the invalidation descriptors in flight when we
> get the interrupt, which means that we need to know which generation is
> finished.

thanks for the explanation. So software still relies on checking the
written back status of the wait descriptor to identify finished
invalidation. If so might be better to generate interrupt when status write
is succeeded? Otherwise, the interrupt is meaningless to software. Does the
current software implementation rely on this interrupt even status write
failed?

Regards,
Yi Liu

