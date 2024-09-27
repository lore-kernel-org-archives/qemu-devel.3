Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B10CCEBF76
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 06:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su4dU-0000Pr-Sb; Fri, 27 Sep 2024 02:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1su4dT-0000Fx-4r
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 02:39:27 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1su4dR-0006jG-E2
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 02:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727419165; x=1758955165;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ca8p7EmA8hb2oZuwk2ccBYUXsQe3fZEsN+k0gmRWNFE=;
 b=ZAHz+UNZCdiC0g4/IZcnsektBoh5rzYO7idVe+0z71E1eYd4o3Df2Ctg
 iZMx+JbAPb6Cn6MvviBhQ8mQuyB4xgcaRp+kBogCRilLmWF4qUhOW+87y
 OoHPkfLF8isbR7/dU61xmYrHeZXQdBCH/PGqUYvBgGNbZJ5sD0RtnNx/F
 I0crzntd/iyW0/JBAO6xpB67SpjWVNuGuQPIV/l5p3H/Vzri12YqhlZVo
 BTNOH5ghpU17DYZGoPwyU16LinKdCwucejqFXckhY9FKgyoefiFUR3hL5
 VyDGQwMzStw0W6uOcHbuxDlwUI8lH5Hc/AVYwFVWPpDreSnudhE8LhlTR g==;
X-CSE-ConnectionGUID: +iLvvsUuTX2rZIrc3DgtaA==
X-CSE-MsgGUID: 8IVxVQOAQeCO/tA1FHQfvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="37133495"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; d="scan'208";a="37133495"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2024 23:39:23 -0700
X-CSE-ConnectionGUID: BiSyGfz5Q9yapENTG5FThw==
X-CSE-MsgGUID: SBupRGHoTuieI3XKK+np5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; d="scan'208";a="73222899"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Sep 2024 23:39:22 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 23:39:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 23:39:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 23:39:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 23:39:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9m8IYqDhyQTWL6z98XHUnbTlHAolIirvAt5yE5ZmrsycFOxXJ+rG0ipHKeunijqS7IJD5N2pogd9wWa3VG1hOkO/3BAJn3FOIdkcuLjc1HSr76fGaYyWHl4mN0CJQhd16cmi/2Ep3bOZzMWwag9PWGWxUBaJ5muxMdHCMKgIANX/xOKoAj4hCw9Ns+fZdyZeLKBHBwb9f/DL7gVwi41ZNz5QI5AherFQ17Zi00dYd9FgNEB3AhhRJlEo5YUKRNLjsPOJMcduVokS4gBs0PmZxAK+3CiCLVFlw+AH7jS7b+2uoYIjWgPYu9jaB8AfY9NuhNqslQLiGSMao717nEu2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ca8p7EmA8hb2oZuwk2ccBYUXsQe3fZEsN+k0gmRWNFE=;
 b=pxw44v/DcTWWGthjPBH0eBG9mZDQcspy6PAROvGC8PFnHqXSZ0Z8tXf9NWjtmCuszdc1OTrxRcSrIYgrmy9m7bSdOK/OuWSRlkpHrV6t0TtCQssNcs/uvropeTTvEeaReVM4M76wsL3H7KNNYdqaJfXc5d0nlqItPmIa7vp8SSKB2xvGgogFkiOrlsUfQs0Bjkb+Fp8nTrrGnbTuIOXs4xkspiCbB8Jiqv7MMwEimq1+R4mvqTJAUdaUFEw6Tf2K5Tl/KnBCdpl8txHkb4yuVJwShOuIF+6SXfJ1l8pALlKmmXq3TshPTYCIOnxXSwgmWIpKqcajTRW8ZDryuPs3+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB6495.namprd11.prod.outlook.com (2603:10b6:8:c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Fri, 27 Sep
 2024 06:39:19 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 06:39:19 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Wang <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v3 15/17] intel_iommu: Modify x-scalable-mode to be string
 option to expose scalable modern mode
Thread-Topic: [PATCH v3 15/17] intel_iommu: Modify x-scalable-mode to be
 string option to expose scalable modern mode
Thread-Index: AQHbBAtHdaavab9yLEu2iYSTDuFy1rJrHayAgAAd3fA=
Date: Fri, 27 Sep 2024 06:39:19 +0000
Message-ID: <SJ0PR11MB6744EE9C94E4BD7FC7275455926B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-16-zhenzhong.duan@intel.com>
 <CACGkMEutsgWhp0mrCG6A3QA1NXnMj8RFDHMKPq3eBv3WxaQ=Vg@mail.gmail.com>
In-Reply-To: <CACGkMEutsgWhp0mrCG6A3QA1NXnMj8RFDHMKPq3eBv3WxaQ=Vg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB6495:EE_
x-ms-office365-filtering-correlation-id: e236492d-63a2-4342-5b06-08dcdebf1d3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?RmtBNDdSMDdoVUNVaGtJNUttZFZoY0hWa0t4cnpyVU14ZDhVR25SSEp4MlNN?=
 =?utf-8?B?N1JQYjFvWlNjK2RCa0pRSU5VRWdIN0c4QXFJK0J3b3hDSVMxakJQSjVZQk96?=
 =?utf-8?B?TklXanNNWm02eU1SVHpTZjZLZDI4MkErNWd0Q2k5aXZicStmVmgraXJIU2VQ?=
 =?utf-8?B?RzBHWm5qbDZ5QWtpWGo3M2cyTUpBU2lNNVhkck55czZONENnYWlzNFJDWWwv?=
 =?utf-8?B?N0dQYXAzTXdkNXdacndKRjlxUkQyUHYwMi9hN1dNb0IxOG12OHN2c3EvUVpG?=
 =?utf-8?B?MDlMencyUjBEYXhLTXB1U3g0Z0M4MVhFNzJidkxUejRPYWJXUUY4SWRIYWZy?=
 =?utf-8?B?ZDBlS0R2VFFnZlVMTFBuaHJvcVNsanV6NWVCYnZWM0hIWUh0Vms1VW83cnRu?=
 =?utf-8?B?Wks2VW50RHhtUEUzcVBwbXlYTDlLNFFaM3ZlQUkvVlNhZUhKclRIVU5nbGZI?=
 =?utf-8?B?Wk8yN1FHdW1XVWVyQ015alJsdnRXUlhGQk9TK1JuVlFINVVyZVQ0akJIMmhx?=
 =?utf-8?B?NWZHRTNWRUJTNnBYYXhCK1pwUlEvNWk0bDNwTWNFQktCaE1yd0xlOTV4eW9m?=
 =?utf-8?B?bU8vSUdrQ2xVOXBRSXU3dnE3WGpYaEE3OXI5ZmUwU1ZlQndHTVUzMGN6cC9P?=
 =?utf-8?B?LzFXRWM1Z3NHbDRRV0hZSHI4ajdkQXpmVVlqU0dEODZCK3NHKzRuU2NJZWhH?=
 =?utf-8?B?SnRJZ01Cb21NZDRIalRIbXlYSEtaRnJ6ckx2MW9DN01aU0RmNjdocHlqQlpD?=
 =?utf-8?B?aloxUlJrWm1oaXltUWc4SktFai9mR0RVOUpQalB1RkxaUmJ2RlZXeStVQ3lV?=
 =?utf-8?B?ZEdFaWs0dEVxK0QreHRnQVVQNSthYkdYWUVoTDkreDRNR1REMlE5WjFjN3V2?=
 =?utf-8?B?ZlMvSzFqODhGd2prUzV2K2xXRS9LNDdzRmV5TGZSV2N4QTN2M1FoVXhxWC9z?=
 =?utf-8?B?anJwREd3SitoRkFEK3hicGVvdTZLU3ZrU2JLUUtwUWVqU3FYY2tVVVRwUEJE?=
 =?utf-8?B?Z2pqTHFCUmdGQUVvK2dsQlFXWEdiRXE5b29CUmRWdXppQitSTXVTSDNVTkhI?=
 =?utf-8?B?cVNNdUk1T2VxZHd6RzgrRzBNZmd3bEVUdzdHdFpHQ0Vydm5HQ2xCTmw1UlJQ?=
 =?utf-8?B?MlNjSXNjcWZjSm1ab0JZblhVUGM4L1Y0dFFaTkpRc2hRaFpRSGtkV2JYS005?=
 =?utf-8?B?enl6VVlqY0ZIZytMcE1uVTdCUnhQVFY4TVNQQTgyM0hzNHFMU09GS0dUTXh3?=
 =?utf-8?B?c21EbklZbmRMRVFORUM3ZUJPbzdLb2p3ZVU1cnFrR1VNYlR6NEtQQkZuczBm?=
 =?utf-8?B?VW05ajMxMWY2YklQQUdkN3lHazl5blRqZm54UG5oVlpxeW5FL2FLcWpkWnRU?=
 =?utf-8?B?ejlUdUhGMmg1RlRaS3M1RVFiREYxb1F2bnBhQnR4elN6bXRrLzdQY0VhYTVm?=
 =?utf-8?B?N3Mwc08zWEpZbDNoRGNvazVuaDlnTG9qYlkwa09vbFFBUmU1bThGTzU2T2FZ?=
 =?utf-8?B?b05sWTVrMWpvY2tQazJxNTR0ZUFLb1RqWkZ6N3NkTFk5R2hDN3RLV3BaYVhu?=
 =?utf-8?B?aHdDYlB6eTdMQXhVenVvbi9rRXZ4YzdscER6UDNwK1ZNendaSUVzb2gxdjFJ?=
 =?utf-8?B?eWJydndsZGZzanpOankwSWNONlJDSVhKZ0REajN6K2xUZUhNMXRqVUNtZFNF?=
 =?utf-8?B?NXphSml1TGJYR3JyWkdRMU5zc3dnSFNNSHlkNnJHSUsyVVdKanc3K1h1cUFY?=
 =?utf-8?B?UGlUakFTblN3WWMwcXVFNVBTNXBrc3lwM05FR2JJNDZyYmt2TkcraDJUV2Rj?=
 =?utf-8?B?ckgxc2VvZkt0bzlVVW5jM09XVzJrazZmalAwdzVzRXR0Y2VrZXV4ZE9XelZF?=
 =?utf-8?B?Rng4M2IrU3Z1bEJEK0c2NDNwbUdPMWRRc0JWSGFqOHNlYUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bW5SeUk2Q0d5OXpxa0F2UXJYSFFoRURDdHpGUUxCUjV6MERETWVrd1JVcmtC?=
 =?utf-8?B?Z09aVFpSdUprbTVWRzJtQ0djOG5KYis3L1BWcnVOWHBUVVF0NEowb3FIQ3Qv?=
 =?utf-8?B?d1QvN0FWdllnTk4rWUJ6NE9OZkxlMlUxN2lHV0VvUy9GYi9teVFsWHhGVkZT?=
 =?utf-8?B?cjFYR0RkV2ZYekRpWCtwUy9PbTNOSVROOTdCeldnTTBnUU54d1VyMlp6d1hY?=
 =?utf-8?B?S0ZjR0NUTy9JNHVmcG53R1FFbStpMi9SQVR6TTRvNFVFZy94N0dPcExjeUhD?=
 =?utf-8?B?RTkzWThyRytFUnUxaXRvTmhyWXB0ajZnSWpTbmFDSjVRS0RLZ1VPbVZBMExz?=
 =?utf-8?B?ejZidkMwWkxmZ1JOazU2QnJSTlJpOGNMTUoyNkkwckgwSk1CMzB2ODRONTE5?=
 =?utf-8?B?ZWtEUEdDVXlvSEE5S1phR2ZwaHc3cEVyVEkwdkRHb0NpN29kblJOaHRQYTZx?=
 =?utf-8?B?ZTI0cVIzS3MzSitHKzkyTTBrZy83TWlrVlFaSkFZYnh4d1RaUk52VmJJeHV0?=
 =?utf-8?B?eEd2RDlvMVF3c0NNUWZjVEFoTFlvWVkwWWhXUzRiR3piOXJaZFhsdDN5aGR5?=
 =?utf-8?B?L3FiOEFFTGpMUHRqMTFJRE9Hek5LdmhLL2xNLzN0VDVJNThYSUVWclEvRGVx?=
 =?utf-8?B?cUhiaFpVcm8rdHJjMnFtaW1odGxsNEdiSUlGanUrdGhQVkpMSFpKbzN4K0lR?=
 =?utf-8?B?V1BxYlBJcCtUZHd6Rm40VkFwWGhpeVJtdHNTYXhSQ0FxN0VQSkdtbEEvK212?=
 =?utf-8?B?bTJMc1QwYXVZaXNpQmVFWVdnNTRVc0JqaEhtVSs2UVNURWxVUjlmZGpGRW10?=
 =?utf-8?B?YjRxNTMzUjVHQUJNTUZYblREdHFNQzJGdmFKWGdzRHRUSmpMUHdpeklVd1ZF?=
 =?utf-8?B?S3VpbXdybHlMblpvd0hyRzBJcFBZS0g1RjlNZDYya1dZSGlmZ0xUUDFOQ3NT?=
 =?utf-8?B?SjdiN0F5RUw2N1ovU0NJS1I5UHIrckp2YjlMQnV3c0lpZnVUM1BLZ0dFMDFp?=
 =?utf-8?B?U1dzTit0aExGMzVtNkI1MVc3V1BuRHNsN1ZwMFR1ZWVTSUQxakg2SXdBOXlx?=
 =?utf-8?B?NlFWVSt4WTgwVnp1bkI3Q056d2RiTUpTQmFvMk5CWlhQY0VaZ2tJWXBpbUV5?=
 =?utf-8?B?eCtuYkpYdWZ5VEFCa0lzY3VBc2VSWmVveStWQTFaSGhUaUlDSFFYV3RkbVJE?=
 =?utf-8?B?T1g3bTc3MDlIZDVWRmtzSldvSDhlOSsvdDlvcjd4R3pOaFk4NkVrWHZFc25k?=
 =?utf-8?B?a1VGeU1mU2pkVlRkbDJsU0tBV3l2TlZTY3FaVXNZYWRFdHVBNGhYZjRGbVFS?=
 =?utf-8?B?QUo1QVFIdnM1NVE5YUF3NW4zL2FjUXBna29CVmo3T0V5OEtsR3pneFhOZkRU?=
 =?utf-8?B?UG9Kcm5DT2dvZTcwS2QvNU1sa3RnTWhqWGRyNXpBZkFlK1dDeEhQaWNJZ0xJ?=
 =?utf-8?B?Uzh5M3BmcUliOVQwWDVTQVA3MW9UQW5EbStVb2IxZUNvVFgyQVRRV3hSZERi?=
 =?utf-8?B?NGRTcW1uT3VRUmJwdm12enZqR3Nxeng2Y0NnZWZhS2NTOUJ3ckUwQ1hqaURC?=
 =?utf-8?B?SER0QkgvblhjT2lqVDFZRmU1ZGZtVUxmd2x0QytNQWxhNWQxcUtGUUNtaEo2?=
 =?utf-8?B?eHA5dDRqSDdDMksvNnBXUURGTDRwamJaRjhVOFVWTVRSNExsTFVQSDExMkV0?=
 =?utf-8?B?SC9XYWxpM3NWUVczTlZmUTJpVThUZWk1UzNaSXhYRkg5YzQ1OGdJSkVWWXNq?=
 =?utf-8?B?YWh6TlNaYnNhRHc5SFBUQVRkdm1aMVZlYU9DSlBrWHVyUmh1L204QWU2WWxk?=
 =?utf-8?B?MDJQZGhpMzFHY3BteDFqMndZa1RITTUxVGRmeTFDSUJDY1ZqWjBRYU5henFr?=
 =?utf-8?B?dTRPWjZFVXd5MVFZcWtlN0FhVEt5RDBvc3BGck4wSldRWW5pM2FTVTBtbVVH?=
 =?utf-8?B?L0QyT3dhek5mT2I3SjhIbWtPRE1rNTVxT3FtUTZZRklGbXRIT2FONS9jZlMv?=
 =?utf-8?B?QXJZM3RzOGdqZTVUSHlzZzAxdFN3N3BRLzRxMWlpKzBnc0huUWphaG1vNmlo?=
 =?utf-8?B?WThvVE81YWllV1lONE5XYWw1cTFreHhETFFOMDJHcXBOMU56anFVL0p3Vis2?=
 =?utf-8?Q?N/Y1vRejQHBYyt9Rmnw2i3yE0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e236492d-63a2-4342-5b06-08dcdebf1d3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 06:39:19.0334 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6IvHabpL2k5QCM2hovmTRQljljnV52To/hWGJ8P22LZ5JIdULSA7Fzzu3ihEFZPbxG3G9zAdbVgnFKT+3jSbwx5ju93IGUJSnmVCnWk3kNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6495
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MyAxNS8xN10gaW50ZWxfaW9t
bXU6IE1vZGlmeSB4LXNjYWxhYmxlLW1vZGUgdG8gYmUNCj5zdHJpbmcgb3B0aW9uIHRvIGV4cG9z
ZSBzY2FsYWJsZSBtb2Rlcm4gbW9kZQ0KPg0KPk9uIFdlZCwgU2VwIDExLCAyMDI0IGF0IDE6Mjfi
gK9QTSBaaGVuemhvbmcgRHVhbg0KPjx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+IHdyb3RlOg0K
Pj4NCj4+IEZyb206IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4NCj4+IEludGVsIFZU
LWQgMy4wIGludHJvZHVjZXMgc2NhbGFibGUgbW9kZSwgYW5kIGl0IGhhcyBhIGJ1bmNoIG9mIGNh
cGFiaWxpdGllcw0KPj4gcmVsYXRlZCB0byBzY2FsYWJsZSBtb2RlIHRyYW5zbGF0aW9uLCB0aHVz
IHRoZXJlIGFyZSBtdWx0aXBsZSBjb21iaW5hdGlvbnMuDQo+PiBXaGlsZSB0aGlzIHZJT01NVSBp
bXBsZW1lbnRhdGlvbiB3YW50cyB0byBzaW1wbGlmeSBpdCBmb3IgdXNlciBieQ0KPnByb3ZpZGlu
Zw0KPj4gdHlwaWNhbCBjb21iaW5hdGlvbnMuIFVzZXIgY291bGQgY29uZmlnIGl0IGJ5ICJ4LXNj
YWxhYmxlLW1vZGUiIG9wdGlvbi4gVGhlDQo+PiB1c2FnZSBpcyBhcyBiZWxvdzoNCj4+DQo+PiAi
LWRldmljZSBpbnRlbC1pb21tdSx4LXNjYWxhYmxlLW1vZGU9WyJsZWdhY3kifCJtb2Rlcm4ifCJv
ZmYiXSINCj4+DQo+PiAgLSAibGVnYWN5IjogZ2l2ZXMgc3VwcG9ydCBmb3Igc3RhZ2UtMiBwYWdl
IHRhYmxlDQo+PiAgLSAibW9kZXJuIjogZ2l2ZXMgc3VwcG9ydCBmb3Igc3RhZ2UtMSBwYWdlIHRh
YmxlDQo+PiAgLSAib2ZmIjogbm8gc2NhbGFibGUgbW9kZSBzdXBwb3J0DQo+PiAgLSBhbnkgb3Ro
ZXIgc3RyaW5nLCB3aWxsIHRocm93IGVycm9yDQo+DQo+VGhvc2Ugd2UgaGFkICJ4IiBwcmVmaXgg
YnV0IEkgd29uZGVyIGlmIHRoaXMgaXMgdGhlIGJlc3Qgb3B0aW9uIGZvcg0KPmVuYWJsaW5nIHNj
YWxhYmxlLW1vZGVybiBtb2RlIHNpbmNlIHRoZSAib24iIGlzIGlsbGVnYWwgYWZ0ZXIgdGhpcw0K
PmNoYW5nZS4NCg0KWWVzLCBJIHdhcyB0aGlua2luZyAieCIgbWVhbnMgbm90IHN0YWJsZSB1c2Vy
IGludGVyZmFjZSB5ZXQuDQpCdXQgSSBkbyBhZ3JlZSB3aXRoIHlvdSBpdCdzIGJldHRlciB0byBr
ZWVwIHN0YWJsZSB1c2VyIGludGVyZmFjZSB3aGVuZXZlciBwb3NzaWJsZS4NCg0KPg0KPk1heWJl
IGl0J3MgYmV0dGVyIHRvIGp1c3QgaGF2ZSBhbiAieC1mbHMiLiBPciBpZiB3ZSBjb25zaWRlcmlu
ZyB0aGUNCj5zY2FsYWJsZSBtb2RlIGlzIGtpbmQgb2YgY29tcGxldGUsIGl0J3MgdGltZSB0byBn
ZXQgcmlkIG9mICJ4IiBwcmVmaXguDQoNCkFoLCBJIHRob3VnaHQgdGhpcyBpcyBhIHF1ZXN0aW9u
IG9ubHkgbWFpbnRhaW5lcnMgYW5kIHJldmlld2VycyBjYW4gZGVjaWRlIGlmIGl0J3MgY29tcGxl
dGUuDQpJZiBubyB2b2ljZSBvbiB0aGF0LCBJJ2QgbGlrZSB0byBhZGQgIngtZmxzIiBhcyB5b3Ug
c3VnZ2VzdGVkIGFuZCBrZWVwIHgtc2NhbGFibGUtbW9kZSB1bmNoYW5nZWQuDQoNClRoYW5rcw0K
Wmhlbnpob25nDQogDQo=

