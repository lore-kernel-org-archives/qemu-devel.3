Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968AAC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 10:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubdBx-00064a-KT; Tue, 15 Jul 2025 06:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ubdBj-00061N-VK; Tue, 15 Jul 2025 06:47:10 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ubdBg-0006bT-6x; Tue, 15 Jul 2025 06:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752576424; x=1784112424;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pS0QDOGbstgNLF0BIg3gqLQm8FfuClYOG1WR75SrATc=;
 b=NxL9BMbqLUMLZApNObLfgAak7k3hI+pf1STye0cf+F8xuBk74Ry5SCsV
 xwbJyqQNJbVawpruNiIND0v4UH/CJhcggj27/4JqH8nKPQBFAa/prh0Py
 R5JpQtKUjeIFzgBgav85QihKHlZJQgGh3ZhkpYDjaavsZDJ6w0k3qzsT9
 PNDZcQi+Hto4crN/zIgt+1V+keBp6lvDbeUyZC31wbrMlGQdTQyoxozxU
 2pUbth5XPnVDtFNUAmtnnO352GEPLNMXP6041QWRjP3cD78y/NPYkj32R
 juSMJ1K9KnOIF/YmlL/xFBIY+SUSbxX5rqnmU37xzjcfzRrMl0Bhqr/V9 A==;
X-CSE-ConnectionGUID: OWGLnK5KR722iX8lF7K+7Q==
X-CSE-MsgGUID: kHcbXC7TRqyCHYuT5LJcwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54763415"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="54763415"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 03:47:00 -0700
X-CSE-ConnectionGUID: S1eHXpvxQhKm5pyKy2zojA==
X-CSE-MsgGUID: FVE2fHSwTPiqV7cStCfp/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="161216448"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 03:47:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 03:46:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 03:46:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.53) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 03:46:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+SGe7btoJPahbUT+LD0PkFZLLxYC6stC5qFtrDZwj+3LMEvZZ8ZxiGp8wB+NWQOcCOfSCEfaCWhzL3K3v6Sf1aItaqCsBAkUa/kzU4k043EPuJBAP+HQqe2m+UlIs+ORmiH+RBHp6ueoL5C7blmTsFwB/uuSUEk2pvlYlOZsyxsTbI1B5FeydAnTMOkPuoTimEHy3S8iIH88jczVbXXZ9oFHGfNjG9nQTzTHlRDj+TUUWh5D3G5V/0BbqTF2rmlOwuf/dfOneoDS/LfRCuML1RhF2dNFTzEv/qmYie7KxYmUqijky5LwYHkg9YwXfTSSPtxg2QsVQrW2QQD7ilG4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pS0QDOGbstgNLF0BIg3gqLQm8FfuClYOG1WR75SrATc=;
 b=n1l+jiPdK5LUBfVxkFSqw3GeeJqPzKzVBgp/KhzIEXyNLUBfSDlQxhDBPfXnJpcxJyHnWFGsSZJDF2MhBpVj/KyRGBzTy+j6BBbYSpA/wh6Utin2+YEHOrPBAW+kYU1VFYEbon0/y+fXdrOhoLpj7W3z3ucfTWvvjxUehOXBbxz8kQKhHnW9B3Dcc3ngmNRZni8BVP306UFTeRRAhBxBZfGvC5/O44mpN0IsGB+66z5DC17T8AGd6nOa5i9HQdm4iNL9oeTLxaf4BAfC+DhNiUfAg67ssOvPYswhKms7oi4ds44bsePJnaoV8HFledNx0BNL+9GFtwyMdSNFZAwTLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA1PR11MB6417.namprd11.prod.outlook.com (2603:10b6:208:3ab::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 10:46:08 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Tue, 15 Jul 2025
 10:46:08 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com"
 <jiangkunkun@huawei.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "shameerkolothum@gmail.com"
 <shameerkolothum@gmail.com>
Subject: RE: [RFC PATCH v3 00/15] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3 
Thread-Topic: [RFC PATCH v3 00/15] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3 
Thread-Index: AQHb9Nh9eTYZ6hnSJUSkrK9uypTxdLQy/JyQ
Date: Tue, 15 Jul 2025 10:46:08 +0000
Message-ID: <IA3PR11MB91365A480838F35F8223EF9D9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA1PR11MB6417:EE_
x-ms-office365-filtering-correlation-id: 7f77edb5-0586-4903-4097-08ddc38ccec0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?dDJhOVpCWlorS093aWplNjZJY2FUejVkUC92NHlQeHhmUkFqSU9mVDB0OWtp?=
 =?utf-8?B?dmpVaGcxU3VKQWdWbzI2RFlVWTMreHFVa1lTMlIvcGJseWZlSWNOdjhxOUV4?=
 =?utf-8?B?YWRnUndGL3FtY0RLVDJuSVJjK01mL2haQ0tFQVdBQkZOVG9kM2V1a1R4V3pN?=
 =?utf-8?B?M3VhMG5uZTdHZTJXV1ZpZnpyS3hTZnA5RDFVVUIzSWVHRHRMMFl0S2NiNjFL?=
 =?utf-8?B?NmhuNytnS24vSXRJNDlEdWxlVjVNdCtuMHNQdjNidjd0OHJlSzhTZ08zN3Np?=
 =?utf-8?B?cnBCRWZUYlp0cTA4RkhlNmh0NHpjNjYwbzdDRTZIOEIvVTVNZDJhMm5LQkwz?=
 =?utf-8?B?QUw4UUlaVkltM2gvNkZ5UlJCZCtzRURaRkpEU0hCR1J5Q0dxdGsrYi9jcDVQ?=
 =?utf-8?B?MkhDUkpyenNnZ2NmRno0S2tNWkRpaEMyYXo5d054QndlVkFWcHZ2Q1pIVmQw?=
 =?utf-8?B?NnRKUndqUjFNQTVoUWo2T3pZeDEwYlMvNGl6SjJwZGJQSlM4dDBhY3g5K09s?=
 =?utf-8?B?cDMrUkxpNTR0cWNla3hIcC9jeWQ3MUR6MG04TmxnWktsOHBYNGR5MGFPenEw?=
 =?utf-8?B?R1dQTUxvOFlBR2ZUY1NuaXNTNzlITmFJN2VLUlVGQ0lya3JYTGlKcysyeHFa?=
 =?utf-8?B?REpJYUI1YlA5NXlHbCtsL2MxQkRMbWNJZ1pVQ3hUdzB1R09hSWhPSTkxbE5B?=
 =?utf-8?B?ek8zN1NRbkt1Y1ZWVzJ2OCtSU0lrZ2lZNEZnbmwyY01GYTVGa1hybDdWRXhl?=
 =?utf-8?B?b21hdytncHVwcnVJYmpxbXF6SzgrQi9QbVhKSVhOalF4UTNsd1o1OFV4TDRv?=
 =?utf-8?B?dTY1VlRwaVE3ZDBkeFRjUFNydnJaV21ZUzZhelVUcXBzK0JNSWc4bkVOU2tH?=
 =?utf-8?B?OXRvb0pqN0FQcFRJbEV4RGRiNlRMR2tDeUt0Mkpkc3VoY3JrYVE5Q1NMa3pp?=
 =?utf-8?B?MUtnNm1kYk9WaWpUUHJIaWp6T1pTcEw0c3RXWEl2OXA3dVVhcU5ONHFNdmZz?=
 =?utf-8?B?MUxqSFhDNzVBVmpJRW1MbloxVHY5N2Z4UUpvQ3oyU3dRNG1GSzZkMmExVU1I?=
 =?utf-8?B?UDdBV1M1eGVMUzlUUk0yZTFMV2JRYXV6aWU0Zzdkd1lqOTJYdzcrTWhnVm1K?=
 =?utf-8?B?eTBnbXRneXdrK2c4SnVxa2JaWnMycDNBTjhrbmFSamkzT2JuQk53NVJCWmZ3?=
 =?utf-8?B?MDhGL1pwNkNoNE1FYWRwYjFYSC90ZVhoWmpXWm54M0NjVHppOEpZaUFUeDkw?=
 =?utf-8?B?VVFZMDlxaVNTTFRnOCszaW5TVGdDK1VUWEM5ZTc4NTA4OTUrM1NoQ0hCVFpp?=
 =?utf-8?B?eXlrOFB0aERoOUVYVGZEd010VFlWLzZLRFZhUGpOdVh4aFVPOTUxS0ZxckZv?=
 =?utf-8?B?QTNrSm5kQzBoYU9CQmxObFpHRWhBZ21JV1VhK3RoTkFMK2krS0t1SlRGRjAr?=
 =?utf-8?B?aW8rbVNjS1Nsc1N5OEcyS01SRk9XbTg4NFF3YXRFNXJmemN5T1p0TW9TQXFE?=
 =?utf-8?B?RGJEQnoraXBpRGxyc1V4Vy9FMmtiYTVJY2hwVi9lZitXalBHZ282aThJaHI3?=
 =?utf-8?B?bkVWUngvb0tUdGtmbm5tVXp3NzhOSkhMM1FqbTZNSFNvWHg5WFQrbmtLblp3?=
 =?utf-8?B?TGxqcGs3cnltR0t4cjdNNWozT3l2RUdaMXN4bURyeDFzaVAwWExwRkhZSW9V?=
 =?utf-8?B?R3dIRjhhREtUMmpJTmhiMTdOU0pQcEhxTTFZNmNVZ1JmaXhMY0FpcXhHRHFG?=
 =?utf-8?B?T1ZJbUJ1WE85dUlTbjc0QUZ0Mjc5b25mUWplTjBRNHNLSCtNUk9Zcnp2Q09V?=
 =?utf-8?B?TE1LRG1YN3BydHo2N3Jwelp6SHQzTy9uUVBQNi8rakJmZ1IyUHBSbDJQaTZQ?=
 =?utf-8?B?R2hDSlZOK2J2STZsQnA2bVN1UGtIZ3ZpQk1hdnFFNGZXSVJ2SE93cnczWDE3?=
 =?utf-8?B?bmNuQmlCNkZEL2hRelJlTklsUnRVdmtNZjU5aEVRZFVocEF0MzR2NFMxcDFz?=
 =?utf-8?Q?ALVqaKwtacA8NZz5454ifwlFKPleds=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHQrSk5MNGxNdzFGWVhJRVdyUlhJY0VHYm9pelFJSmx0Q05pVjFRZ3NoYWRJ?=
 =?utf-8?B?ejhURHA5QURmd05ncUFTc2RlUHl2MkYrejNlemdXQlBxZVBGcVNsRlNjUW9N?=
 =?utf-8?B?NW1UWXp1eG0xV2JSUUJ2Y25kVnFBcDltcDdBZnlYTlpTaCs0NWlnNjVFcVV5?=
 =?utf-8?B?cXUzN1FTcUhWL3U0OVhuZ0F5MHNpcXgrVGVNSWNYWVpSNndRdEdSZkgxOEt4?=
 =?utf-8?B?aHlWTHJqcDVLeXVZazhrZk9weUkwd2pNTXJhbGFDNHZadVJlMWpsT3RnUTBH?=
 =?utf-8?B?d2dhMjN4UjdoLzU3V2lERGxPMUc2OThpb0FhUnZpbFk2bkR5NjlGSXk3SjIx?=
 =?utf-8?B?Y0g0bFZNZk1jbTUxVWk3c0NidWM2bm92Lzc2Q1RRZGJjd2puaXFGakJPL2RM?=
 =?utf-8?B?amE1VDRJYnpHdzJwVU1oYUVWYWpDRFJLL0VJUUcrSWZjQnRrdER3OVM4L0tI?=
 =?utf-8?B?T0s2R29Tc3NycHpraFV5MkJ2dHRHKzRibVM2QUxTa3MrSW4vdThIOFpid2cw?=
 =?utf-8?B?MlZxZ0xwTC8yWWw1VzEwai85WnZvd1RJOGZmVXNGT3J5NXNJRUNZSW9nWStv?=
 =?utf-8?B?Z0x1OWxXQ002blFsbzZpZTlRMjZxYW8wL1RrZm9CRFVuTUtrMVBnYVJ1S0k0?=
 =?utf-8?B?UFRBTWpQbU9PdXNONmg2di8zc05HZVE5dTN5YmtUd2pubTQ0NytWQVBORWpI?=
 =?utf-8?B?cGhNdjA2cFRWQkE0T21mY3ZRbFhSQXZrMTkyZmgvVzNLOUIva0xhM2JuQldD?=
 =?utf-8?B?ZDVvdGMvejN2cnMvM3U3WldLS3RRbURRRTEvU0NpU1QzenVOU2RzRjkrYnFC?=
 =?utf-8?B?MngxMk5oUXRlejBVOXE3Um5haHduRFYrc2JrS1dMb2QwcDdpUWV1UUwxcEZx?=
 =?utf-8?B?WElVMHdnZkt1cytEMmp2Z3hyVEx4Ty9VVE41SUc2NitrbnIwWkRsamdzZDM3?=
 =?utf-8?B?OTEvemtZZytrZlBrYjNyRHFGV2FqTkZmcW96bTErOGExVjhjNWNKZGJ2dlUv?=
 =?utf-8?B?cUsvZ0ptb2VJVDlHUTlic3c4dGMySUdEVnU1WkhXUENWbFc4S3BualpBV1BF?=
 =?utf-8?B?S3c5ZmhCTW1JaWZEVUxZOFhPUzhTbG9aQVBrTWMyNVl1dlRmejVqY2grRDZq?=
 =?utf-8?B?a3BJV2lSQUFSSzFuWEkwYndhVWNhdEQxbTNPc0w0MXlVMk1NaG1SNkp2TWRo?=
 =?utf-8?B?Y3FnYVBRSUVMbVFaSmR3RjhLN2dPU0szMGdCemdhK25KOEtRdnBFYkViUlNL?=
 =?utf-8?B?TitEcHB1ZVpZeTB2MWppS3p4bCtqdnhQRGVVQ01vZmpoSnRNYUJXUVpROG1k?=
 =?utf-8?B?WVB1eFFBOFk1VWhHNm03eVlZUTVhUzBzVnRSaXRTZXQxR0ttYnZ4MUU2SzBm?=
 =?utf-8?B?OEVTV2VsK29nS2FYSzY5QUwxbXhrb2p5dHg1VFA0U2xPYkxxU0VuQjlJRXd0?=
 =?utf-8?B?ejdDV1FCcVJpa1FQZFRZQWVHR20xcFdlRnVqUWsvRFFKanRKa3p3bzR3Nkpq?=
 =?utf-8?B?eENidE9NSklnNVhDNkpTUTd0VzU0QTh3R2VMMjV4WEZnSnBwUWJRQU5kOXNS?=
 =?utf-8?B?M2FTWVlwZnJzcUh0ZExMRHhFeGd6ZXFMR0dURjQ2V3dMZVNYa08zS1R1dnp5?=
 =?utf-8?B?UjMvWlExeGFNM3cwRHpNM1psRXNXY3duTld2VnRLTkkyOVp3TWRnRjN5LzBP?=
 =?utf-8?B?aGtOd0J5ZFRNRXNlWjV0WFYvSjVqMnc3QjVVODYxVWkwTDFnVFpnQ2dmVU9k?=
 =?utf-8?B?M00zQlIxMzVxamlLNEh6cHl5aHlCb2JXbVFXbC9CNVN3dVlrOC9mdDVpSVpi?=
 =?utf-8?B?azBhL1kzZzUxK3NSeFl6RmIycjRxb0JHL0Nlb1ZHMXN0THVSZ3A5TmFieGk2?=
 =?utf-8?B?QXNlVW1uVGxEdU9CaHZDN2V0Y0UrWUtkWFhpcFUrNnJESUdrUmVtdzV5VDd6?=
 =?utf-8?B?bi8xTEVqaG85UCtIQTdiSDMvOXNxR1hldzQwRUw0YXFHMWNJUXJjeUl2L2JC?=
 =?utf-8?B?aURBdThzTTIzSGtpTG1Qd1VjMll3TlgvcFdlVTZwbGk4c21rdGtiNWY3RWhC?=
 =?utf-8?B?MXgyTlRMVjNIclFOM0JFUEViK2RDSFh2bStmOU9QWFhFNncwOVpRUWRBN29t?=
 =?utf-8?Q?+9az9wAIV3ZYIEnC8Bp+ivYmz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f77edb5-0586-4903-4097-08ddc38ccec0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 10:46:08.7893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0JKm0xU7b2BkazPYQi0V/IleVkeNNui6KFyMF24oNKDXNM3+Mtf4Y5YfcPwludJu4r0tTHsoqki5jpQat/HyalnDsPYpU2xri2/TxBpHj9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6417
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

SGkgU2hhbWVlciwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogU2hhbWVl
ciBLb2xvdGh1bSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPg0KPlN1Ympl
Y3Q6IFtSRkMgUEFUQ0ggdjMgMDAvMTVdIGh3L2FybS92aXJ0OiBBZGQgc3VwcG9ydCBmb3IgdXNl
ci1jcmVhdGFibGUNCj5hY2NlbGVyYXRlZCBTTU1VdjMNCj4NCj5IaSBBbGwsDQo+DQo+VGhpcyBw
YXRjaCBzZXJpZXMgaW50cm9kdWNlcyBpbml0aWFsIHN1cHBvcnQgZm9yIGEgdXNlci1jcmVhdGFi
bGUsDQo+YWNjZWxlcmF0ZWQgU01NVXYzIGRldmljZSAoLWRldmljZSBhcm0tc21tdXYzLGFjY2Vs
PW9uKSBpbiBRRU1VLg0KPg0KPlRoaXMgaXMgYmFzZWQgb24gdGhlIHVzZXItY3JlYXRhYmxlIFNN
TVV2MyBkZXZpY2Ugc2VyaWVzIFswXS4NCj4NCj5XaHkgdGhpcyBpcyBuZWVkZWQ6DQo+DQo+T24g
QVJNLCB0byBlbmFibGUgdmZpby1wY2kgcGFzcy10aHJvdWdoIGRldmljZXMgaW4gYSBWTSwgdGhl
IGhvc3QgU01NVXYzDQo+bXVzdCBiZSBzZXQgdXAgaW4gbmVzdGVkIHRyYW5zbGF0aW9uIG1vZGUg
KFN0YWdlIDEgKyBTdGFnZSAyKSwgd2l0aA0KPlN0YWdlIDEgKFMxKSBjb250cm9sbGVkIGJ5IHRo
ZSBndWVzdCBhbmQgU3RhZ2UgMiAoUzIpIG1hbmFnZWQgYnkgdGhlIGhvc3QuDQo+DQo+VGhpcyBz
ZXJpZXMgaW50cm9kdWNlcyBhbiBvcHRpb25hbCBhY2NlbCBwcm9wZXJ0eSBmb3IgdGhlIFNNTVV2
MyBkZXZpY2UsDQo+aW5kaWNhdGluZyB0aGF0IHRoZSBndWVzdCB3aWxsIHRyeSB0byBsZXZlcmFn
ZSBob3N0IFNNTVV2MyBmZWF0dXJlcyBmb3INCj5hY2NlbGVyYXRpb24uIEJ5IGRlZmF1bHQsIGVu
YWJsaW5nIGFjY2VsIGNvbmZpZ3VyZXMgdGhlIGhvc3QgU01NVXYzIGluDQo+bmVzdGVkIG1vZGUg
dG8gc3VwcG9ydCB2ZmlvLXBjaSBwYXNzLXRocm91Z2guDQo+DQo+VGhpcyBuZXcgYWNjZWxlcmF0
ZWQsIHVzZXItY3JlYXRhYmxlIFNNTVV2MyBkZXZpY2UgbGV0cyB5b3U6DQo+DQo+IC1TZXQgdXAg
YSBWTSB3aXRoIG11bHRpcGxlIFNNTVV2M3MsIGVhY2ggdGllZCB0byBhIGRpZmZlcmVudCBwaHlz
aWNhbA0KPlNNTVV2Mw0KPsKgIG9uIHRoZSBob3N0LiBUeXBpY2FsbHksIHlvdeKAmWQgaGF2ZSBt
dWx0aXBsZSBQQ0llIFBYQiByb290IGNvbXBsZXhlcyBpbiB0aGUNCj7CoCBWTSAob25lIHBlciB2
aXJ0dWFsIE5VTUEgbm9kZSksIGFuZCBlYWNoIG9mIHRoZW0gY2FuIGhhdmUgaXRzIG93bg0KPlNN
TVV2My4NCj7CoCBUaGlzIHNldHVwIG1pcnJvcnMgdGhlIGhvc3QncyBsYXlvdXQsIHdoZXJlIGVh
Y2ggTlVNQSBub2RlIGhhcyBpdHMgb3duDQo+wqAgU01NVXYzLCBhbmQgaGVscHMgYnVpbGQgVk1z
IHRoYXQgYXJlIG1vcmUgYWxpZ25lZCB3aXRoIHRoZSBob3N0J3MgTlVNQQ0KPsKgIHRvcG9sb2d5
Lg0KDQpJcyBpdCBhIG11c3QgdG8gbWlycm9yIHRoZSBob3N0IGxheW91dD8NCkRvZXMgdGhpcyBt
aXJyb3IgaW5jbHVkZSBzbW11djMuMCB3aGljaCBsaW5rZWQgdG8gcGNpZS4wPw0KRG8gd2UgaGF2
ZSB0byBjcmVhdGUgc2FtZSBudW1iZXIgb2Ygc21tdXYzIGFzIGhvc3Qgc21tdXYzIGZvciBndWVz
dD8NCldoYXQgaGFwcGVuIGlmIHdlIGRvbid0IG1pcnJvciBjb3JyZWN0bHksIGUuZy4sIHZmaW8g
ZGV2aWNlIGxpbmtlZCB0byBzbW11djMuMA0KaW4gZ3Vlc3Qgd2hpbGUgaW4gaG9zdCBpdCBsaW5r
ZWQgdG8gc21tdXYzLjE/DQo+DQo+IC1UaGUgaG9zdOKAk2d1ZXN0IFNNTVV2MyBhc3NvY2lhdGlv
biByZXN1bHRzIGluIHJlZHVjZWQgaW52YWxpZGF0aW9uDQo+YnJvYWRjYXN0cw0KPiDCoGFuZCBs
b29rdXBzIGZvciBkZXZpY2VzIGJlaGluZCBkaWZmZXJlbnQgcGh5c2ljYWwgU01NVXYzcy4NCj4N
Cj4gLVNpbXBsaWZpZXMgaGFuZGxpbmcgb2YgaG9zdCBTTU1VdjNzIHdpdGggZGlmZmVyaW5nIGZl
YXR1cmUgc2V0cy4NCj4NCj4gLUxheXMgdGhlIGdyb3VuZHdvcmsgZm9yIGFkZGl0aW9uYWwgY2Fw
YWJpbGl0aWVzIGxpa2UgdkNNRFEgc3VwcG9ydC4NCj4NCj5DaGFuZ2VzIGZyb20gUkZDdjJbMV0g
YW5kIGtleSBwb2ludHMgaW4gUkZDdjM6DQo+DQo+IC1Vbmxpa2UgUkZDdjIsIHRoZXJlIGlzIG5v
IGFybS1zbW11djMtYWNjZWwgZGV2aWNlIG5vdy4gVGhlIGFjY2VsZXJhdGVkDQo+wqAgbW9kZSBp
cyBlbmFibGVkIHVzaW5nIC1kZXZpY2UgYXJtLXNtbXV2MyxhY2NlbD1vbi4NCj4NCj4gLVdoZW4g
YWNjZWw9b24gaXMgc3BlY2lmaWVkLCB0aGUgU01NVXYzIHdpbGwgYWxsb3cgb25seSB2ZmlvLXBj
aSBlbmRwb2ludA0KPiDCoGRldmljZXMgYW5kIGFueSBub24tZW5kcG9pbnQgZGV2aWNlcyBsaWtl
IFBDSSBicmlkZ2VzIGFuZCByb290IHBvcnRzIHVzZWQNCj4gwqB0byBwbHVnIGluIHRoZSB2Zmlv
LXBjaS4gU2VlIHBhdGNoIzYNCj4NCj4gLUkgaGF2ZSB0cmllZCB0byBrZWVwIHRoaXMgUkZDIHNp
bXBsZSBhbmQgYmFzaWMgc28gd2UgY2FuIGZvY3VzIG9uIHRoZQ0KPiDCoHN0cnVjdHVyZSBvZiB0
aGlzIG5ldyBhY2NlbGVyYXRlZCBzdXBwb3J0LiBUaGF0IG1lYW5zIHRoZXJlIGlzIG5vIHN1cHBv
cnQNCj4gwqBmb3IgQVRTLCBQQVNJRCwgb3IgUFJJLiBPbmx5IHZmaW8tcGNpIGRldmljZXMgdGhh
dCBkb27igJl0IHJlcXVpcmUgdGhlc2UNCj4gwqBmZWF0dXJlcyB3aWxsIHdvcmsuDQo+DQo+IC1T
b21lIGNsYXJpdHkgaXMgc3RpbGwgbmVlZGVkIG9uIHRoZSBmaW5hbCBhcHByb2FjaCB0byBoYW5k
bGUgTVNJIHRyYW5zbGF0aW9uLg0KPiDCoEhlbmNlLCBSTVIgc3VwcG9ydCAod2hpY2ggaXMgcmVx
dWlyZWQgZm9yIHRoaXMpIGlzIG5vdCBpbmNsdWRlZCB5ZXQsIGJ1dA0KPiDCoGF2YWlsYWJsZSBp
biB0aGUgZ2l0IGJyYW5jaCBwcm92aWRlZCBiZWxvdyBmb3IgdGVzdGluZy4NCj4NCj4gLUF0IGxl
YXN0IG9uZSB2ZmlvLXBjaSBkZXZpY2UgbXVzdCBjdXJyZW50bHkgYmUgY29sZC1wbHVnZ2VkIHRv
IGEgUENJZSByb290DQo+IMKgY29tcGxleCBhc3NvY2lhdGVkIHdpdGggYXJtLXNtbXV2MyxhY2Nl
bD1vbi4gVGhpcyBpcyByZXF1aXJlZCB0bzoNCj7CoCAxLiBhc3NvY2lhdGUgYSBndWVzdCBTTU1V
djMgd2l0aCBhIGhvc3QgU01NVXYzDQo+wqAgMi4gcmV0cmlldmUgdGhlIGhvc3QgU01NVXYzIGZl
YXR1cmUgcmVnaXN0ZXJzIGZvciBndWVzdCBleHBvcnQNCj7CoCBUaGlzIHN0aWxsIG5lZWRzIGRp
c2N1c3Npb24sIGFzIHRoZXJlIHdlcmUgY29uY2VybnMgcHJldmlvdXNseSBhYm91dCB0aGlzDQo+
wqAgYXBwcm9hY2ggYW5kIGl0IGFsc28gYnJlYWtzIGhvdHBsdWcvdW5wbHVnIHNjZW5hcmlvcy4g
U2VlIHBhdGNoIzE0DQo+DQo+IC1UaGlzIHZlcnNpb24gZG9lcyBub3QgeWV0IHN1cHBvcnQgaG9z
dCBTTU1VdjMgZmF1bHQgaGFuZGxpbmcgb3Igb3RoZXINCj5ldmVudA0KPsKgIG5vdGlmaWNhdGlv
bnMuIFRoZXNlIHdpbGwgYmUgYWRkcmVzc2VkIGluIGEgZnV0dXJlIHBhdGNoIHNlcmllcy4NCj4N
Cj5CcmFuY2ggZm9yIHRlc3Rpbmc6DQo+DQo+VGhpcyBpcyBiYXNlZCBvbiB2OCBvZiB0aGUgU01N
VXYzIGRldmljZSBzZXJpZXMgYW5kIGhhcyBkZXBlbmRlbmN5IG9uIHRoZQ0KPkludGVsDQo+c2Vy
aWVzIGhlcmUgWzNdLg0KPg0KPmh0dHBzOi8vZ2l0aHViLmNvbS9oaXNpbGljb24vcWVtdS90cmVl
L3NtbXV2My1kZXYtdjgtYWNjZWwtcmZjdjMNCj4NCj4NCj5UZXN0ZWQgb24gYSBIaVNpbGljb24g
cGxhdGZvcm0gd2l0aCBtdWx0aXBsZSBTTU1VdjNzLg0KPg0KPi4vcWVtdS1zeXN0ZW0tYWFyY2g2
NCBcDQo+wqAgLW1hY2hpbmUgdmlydCxhY2NlbD1rdm0sZ2ljLXZlcnNpb249MyBcDQo+wqAgLW9i
amVjdCBpb21tdWZkLGlkPWlvbW11ZmQwIFwNCj7CoCAtYmlvcyBRRU1VX0VGSSBcDQo+wqAgLWNw
dSBob3N0IC1zbXAgY3B1cz00IC1tIHNpemU9MTZHLHNsb3RzPTQsbWF4bWVtPTI1NkcgLW5vZ3Jh
cGhpYyBcDQo+wqAgLWRldmljZSB2aXJ0aW8tYmxrLWRldmljZSxkcml2ZT1mcyBcDQo+wqAgLWRy
aXZlIGlmPW5vbmUsZmlsZT11YnVudHUuaW1nLGlkPWZzIFwNCj7CoCAta2VybmVsIEltYWdlIFwN
Cj7CoCAtZGV2aWNlIGFybS1zbW11djMscHJpbWFyeS1idXM9cGNpZS4wLGlkPXNtbXV2My4wLGFj
Y2VsPW9uIFwNCg0KSGVyZSBhY2NlbD1vbiwgc28gb25seSB2ZmlvIGRldmljZSBpcyBhbGxvd2Vk
IG9uIHBjaWUuMD8NCg0KPsKgIC1kZXZpY2UgdmZpby1wY2ksaG9zdD0wMDAwOjc1OjAwLjEsYnVz
PXBjaWUuMCxpb21tdWZkPWlvbW11ZmQwIFwNCj7CoCAtZGV2aWNlIHB4Yi1wY2llLGlkPXBjaWUu
MSxidXNfbnI9MixidXM9cGNpZS4wIFwNCj7CoCAtZGV2aWNlIGFybS1zbW11djMscHJpbWFyeS1i
dXM9cGNpZS4xLGlkPXNtbXV2My4xLGFjY2VsPW9uIFwNCj7CoCAtZGV2aWNlDQo+cGNpZS1yb290
LXBvcnQsaWQ9cGNpZTEucG9ydDEsY2hhc3Npcz0yLGJ1cz1wY2llLjEscHJlZjY0LXJlc2VydmU9
Mk0saW8tcmVzDQo+ZXJ2ZT0xSyBcDQo+wqAgLWRldmljZQ0KPnZmaW8tcGNpLGhvc3Q9MDAwMDo3
ZDowMi4xLGJ1cz1wY2llMS5wb3J0MSxpb21tdWZkPWlvbW11ZmQwLGlkPW5ldDEgXA0KPsKgIC1h
cHBlbmQgInJkaW5pdD1pbml0IGNvbnNvbGU9dHR5QU1BMCByb290PS9kZXYvdmRhIHJ3DQo+ZWFy
bHljb249cGwwMTEsMHg5MDAwMDAwIiBcDQo+wqAgLWRldmljZSBweGItcGNpZSxpZD1wY2llLjIs
YnVzX25yPTMyLGJ1cz1wY2llLjAgXA0KPsKgIC1kZXZpY2UgYXJtLXNtbXV2MyxwcmltYXJ5LWJ1
cz1wY2llLjIsaWQ9c21tdXYzLjIgXA0KPsKgIC1kZXZpY2UgcGNpZS1yb290LXBvcnQsaWQ9cGNp
ZTIucG9ydDEsY2hhc3Npcz04LGJ1cz1wY2llLjIgXA0KPsKgIC1kZXZpY2UgdmlydGlvLTlwLXBj
aSxmc2Rldj1wOWZzLG1vdW50X3RhZz1wOSxidXM9cGNpZTIucG9ydDEgXA0KPsKgIC1mc2RldiBs
b2NhbCxpZD1wOWZzLHBhdGg9cDlyb290LHNlY3VyaXR5X21vZGVsPW1hcHBlZCBcDQo+wqAgLW5l
dCBub25lIFwNCj7CoCAtbm9ncmFwaGljDQo+DQo+DQo+R3Vlc3Qgb3V0cHV0Og0KPg0KPnJvb3RA
dWJ1bnR1Oi8jIGRtZXNnIHxncmVwIHNtbXUNCj4gYXJtLXNtbXUtdjMgYXJtLXNtbXUtdjMuMC5h
dXRvOiBvcHRpb24gbWFzayAweDANCj4gYXJtLXNtbXUtdjMgYXJtLXNtbXUtdjMuMC5hdXRvOiBp
YXMgNDQtYml0LCBvYXMgNDQtYml0IChmZWF0dXJlcw0KPjB4MDAwMDgzMDUpDQo+IGFybS1zbW11
LXYzIGFybS1zbW11LXYzLjAuYXV0bzogYWxsb2NhdGVkIDY1NTM2IGVudHJpZXMgZm9yIGNtZHEN
Cj4gYXJtLXNtbXUtdjMgYXJtLXNtbXUtdjMuMC5hdXRvOiBhbGxvY2F0ZWQgMzI3NjggZW50cmll
cyBmb3IgZXZ0cQ0KPiBhcm0tc21tdS12MyBhcm0tc21tdS12My4xLmF1dG86IG9wdGlvbiBtYXNr
IDB4MA0KPiBhcm0tc21tdS12MyBhcm0tc21tdS12My4xLmF1dG86IGlhcyA0NC1iaXQsIG9hcyA0
NC1iaXQgKGZlYXR1cmVzDQo+MHgwMDAwODMwNSkNCj4gYXJtLXNtbXUtdjMgYXJtLXNtbXUtdjMu
MS5hdXRvOiBhbGxvY2F0ZWQgNjU1MzYgZW50cmllcyBmb3IgY21kcQ0KPiBhcm0tc21tdS12MyBh
cm0tc21tdS12My4xLmF1dG86IGFsbG9jYXRlZCAzMjc2OCBlbnRyaWVzIGZvciBldnRxDQo+IGFy
bS1zbW11LXYzIGFybS1zbW11LXYzLjIuYXV0bzogb3B0aW9uIG1hc2sgMHgwDQo+IGFybS1zbW11
LXYzIGFybS1zbW11LXYzLjIuYXV0bzogaWFzIDQ0LWJpdCwgb2FzIDQ0LWJpdCAoZmVhdHVyZXMN
Cj4weDAwMDA4MzA1KQ0KPiBhcm0tc21tdS12MyBhcm0tc21tdS12My4yLmF1dG86IGFsbG9jYXRl
ZCA2NTUzNiBlbnRyaWVzIGZvciBjbWRxDQo+IGFybS1zbW11LXYzIGFybS1zbW11LXYzLjIuYXV0
bzogYWxsb2NhdGVkIDMyNzY4IGVudHJpZXMgZm9yIGV2dHENCj5yb290QHVidW50dTovIw0KPg0K
PnJvb3RAdWJ1bnR1Oi8jIGxzcGNpIC10dg0KPi0rLVswMDAwOjIwXS0tLTAwLjAtWzIxXS0tLS0w
MC4wIMKgUmVkIEhhdCwgSW5jIFZpcnRpbyBmaWxlc3lzdGVtDQo+wqArLVswMDAwOjAyXS0tLTAw
LjAtWzAzXS0tLS0wMC4wIMKgSHVhd2VpIFRlY2hub2xvZ2llcyBDby4sIEx0ZC4gRGV2aWNlDQo+
YTIyZQ0KPsKgXC1bMDAwMDowMF0tKy0wMC4wIMKgUmVkIEhhdCwgSW5jLiBRRU1VIFBDSWUgSG9z
dCBicmlkZ2UNCj7CoCDCoCDCoCDCoCDCoCDCoCDCoCstMDEuMCDCoEh1YXdlaSBUZWNobm9sb2dp
ZXMgQ28uLCBMdGQuIERldmljZSBhMjUxDQo+wqAgwqAgwqAgwqAgwqAgwqAgwqArLTAyLjAgwqBS
ZWQgSGF0LCBJbmMuIFFFTVUgUENJZSBFeHBhbmRlciBicmlkZ2UNCj7CoCDCoCDCoCDCoCDCoCDC
oCDCoFwtMDMuMCDCoFJlZCBIYXQsIEluYy4gUUVNVSBQQ0llIEV4cGFuZGVyIGJyaWRnZQ0KDQpB
cmUgdGhlc2UgYWxsIHRoZSBkZXZpY2VzIGluIHRoaXMgZ3Vlc3QgY29uZmlnPw0KV2lsbCBub3Qg
cWVtdSBjcmVhdGUgc29tZSBkZWZhdWx0IGRldmljZXMgaW1wbGljaXRseSBldmVuIGlmIHdlIGRv
bid0IGFzayB0aGVtIGluIGNtZGxpbmU/DQoNClRoYW5rcw0KWmhlbnpob25nDQoNCg==

