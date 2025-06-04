Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF447C5B552
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 05:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMh1I-0001X4-OL; Wed, 04 Jun 2025 01:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMh1A-0001Wl-Te
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 01:50:28 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMh17-0005fW-Cb
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 01:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749016225; x=1780552225;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=n72yiyXiaVryt7UYCzvps8A/Bp5NPfSWB+3eqY4BP6w=;
 b=EHoaSFZgD3xWhI2yImEGfoLWJwdUF2XrvUQRcwin1Y//4caatDP19AfP
 A0AyS7uK+NQ1Y6HfhRvwXJFrUdcDLCA56eMs7fJOuf9uytWP4qURVyF8O
 vRNVK7OFglPYuhAotN1Wd+1/hN8+I3rnN8i31L94+17lmZRg3X+o/nUVd
 WbS3hIOowZKTZhb+ZSE3NrLhiGXvM89ecX6ATEpaqBtfFfwVN4K6o/FPM
 Pi+sGO78BNFOlMR444nxTJS/yiRXwnd1bsLCBM7R6S2nSDL2zSDGiPVkf
 Yoimu4YG/fvpy568peaGLAkf9jz6i8u7Agg3KOHyELDmbznQ5pbcY7BeZ g==;
X-CSE-ConnectionGUID: +HCi6UofRiuPbxRmNOmgnA==
X-CSE-MsgGUID: mQFFReoFRDmSWvcnlrr8FQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62435453"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="62435453"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 22:50:20 -0700
X-CSE-ConnectionGUID: HJO/AqGeRziwYhb85rhHPA==
X-CSE-MsgGUID: /nV+dSBbSuukjkxaIauJ/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="182257029"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 22:50:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 22:50:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 22:50:16 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.65)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 22:50:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fwj21CimdbBdEZh+7W7Mb/jiM6xt1skiYksq78B8r5o4RwrgaWf85uWZ83Y9srF+jK17lZY61R81DQ9aprY/chi7P7Odj3Qoh4Ih134l0zWw3jkGrk1dAkaWosVdZTVOIZu8Kxd9w3Oi+EVELIHW9eJwhb8WnolrQToS+VOgymzqv6PNqUYjh+aOWtrRW886ihZGLEwcSe4l2kd0Q+EvdqC3u5LxAijwB10XUWFh4QS+SB5ZQBrsJXM+zkCEfXHZzQVyaEE5lESSuBg2C77+U+uKErf7pU2NtuMhab4NuMFg/S52pGJRXmveMPj+SMqCDBKVXlOON9O6ORUspGVutA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n72yiyXiaVryt7UYCzvps8A/Bp5NPfSWB+3eqY4BP6w=;
 b=M30Jj/QR6YZuMWg6RQ7/ZB9AvbeOXt7uEPyvdFmKO0jn19LGTNE4+HYTJKNvvbgPnhqOP1Kyuy2EJOKuuntRhvBGE1GPqcIKMuoLPqo5vp+zOVLA8SwPLu/Ua+MTfIqs2QYLhyH472GUO4oV8nAe1flsUojD3GFND3U3dMBVhjNTGn7s4fmgCYDCL8anotaomzlRyZHDXM68T/5OE3BHBvTOjJAj0QzdL9SEC9MZ1rMnqIzM/IE4uyhBXdC5tP9K4vcDpry8CWvSge37Ar1LRvrc0dFY1IWIfvsJfLY+IZmrb/AJkL8D0Q6PQlVDvvdYNyyxdtWKHHB/9qbmozqjLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA1PR11MB7014.namprd11.prod.outlook.com (2603:10b6:806:2b9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 4 Jun
 2025 05:50:14 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8769.037; Wed, 4 Jun 2025
 05:50:13 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v2 1/4] backends/iommufd: Add a helper to invalidate
 user-managed HWPT
Thread-Topic: [PATCH v2 1/4] backends/iommufd: Add a helper to invalidate
 user-managed HWPT
Thread-Index: AQHb0Ua1aVRjTXOzd0e/EdeRNhH6vrPxYWSAgAEkVhA=
Date: Wed, 4 Jun 2025 05:50:13 +0000
Message-ID: <IA3PR11MB9136A572E2D94B5537C26CBE926CA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250530093512.3959484-1-zhenzhong.duan@intel.com>
 <20250530093512.3959484-2-zhenzhong.duan@intel.com>
 <bcec7aeb-47c2-4edf-87f4-d09362e59715@redhat.com>
In-Reply-To: <bcec7aeb-47c2-4edf-87f4-d09362e59715@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA1PR11MB7014:EE_
x-ms-office365-filtering-correlation-id: cee27a8e-c330-4a75-3d6b-08dda32bacf7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?TGNJS044NVZVbUpOV0h3U25kM1ZXSVJzdit0bmNtL014Sm0wRTZ5eittVHl3?=
 =?utf-8?B?VTA1Z2Jyc09CQmI1UVJxSTVCanZGb0NEVkFqa3NSdUFRRFJDL081NjE0YlJR?=
 =?utf-8?B?S0Jra0dZMlRTa2t2UzNxRVN4cGZWVWc5SFJyOGJDSE5salpmaVQ2TERxTlkv?=
 =?utf-8?B?MkRqV0pIaGJoUnZLU1JyckJwZXRQQzFXMTJ3Q0NNSTJ5N2h3THlHbkoyMFN2?=
 =?utf-8?B?YnUwOGxUOVVLRDBuQjcvRTQ4MzUyMWF0Q3g2aTR4T0loQU4wdnAvbFdDMXJa?=
 =?utf-8?B?U05UZUVoeFdYWmN2aW13akk2Nmdjby8vc3hmV3gvdkNiTk1ZSXpmUnE2RUhr?=
 =?utf-8?B?SGxMMlpuaGt3Ui91YW5TMWdJRENVVGROdjRlYTcrY0ZpNytsVFVjT1JCRnBH?=
 =?utf-8?B?ekd3NlQ2K3VydGFreHd0RXN6c2NZdUliNzZjWUtEYm82N0ZXWi9vV2RLS1l5?=
 =?utf-8?B?TVhZenppRWRJd29JaXM1UVdLMndzSGU0Q0NURFFiMnZFaWhtNHhvWVB1anBC?=
 =?utf-8?B?cUpyKzhJY09nZElDZzJOQUIwNWhWV3JwTEVhc0VJK2lkekpqZmdFbXJjQjlM?=
 =?utf-8?B?VzVlRjdTOXlGQ2wraFc4WkE5TldVcnFoWHdIY2lNYzJyUVd4emUxaHJLdGNR?=
 =?utf-8?B?L3lNbE4rcWJvaFdOSFVkZzZKMzMyMVhkL21RZEw4bGxGQVllc2FiOXRSY3NB?=
 =?utf-8?B?REsra09Dd1VqYzIxZE9saDNjQmIxUHZzeEpLWmdsaVNROWd4bHpzaFU5UHpt?=
 =?utf-8?B?cTVtSUxXMzRodzNEODhtQlo1elc1eGMvQm5QOWlYN0xQZXA1M1QvdDZXWHo4?=
 =?utf-8?B?T3J5dVJoRlgyT0VEMDlkazZwZm1YSWxqdkRlOGY1QitSQTY4enZPSC9hTnhl?=
 =?utf-8?B?WnZWUlQyWENsQStMQnBnYmhDU2lsUGtnSnZJbjRhNFM3aVB1NUZpeHRiSU01?=
 =?utf-8?B?ZzEvYVloZkdyaHAyZlRXRkV3RnhuNEVPS0Fod3IyQ0pOcmExZUVjNGVESEhZ?=
 =?utf-8?B?dWp0N3NRZlFjTDJEcVk2SHpoc2dKNEp3YWttY0FCcER2MndKVmFzOUtpVEhR?=
 =?utf-8?B?UnQ2MTl2Q2duRTlJOGZMNFo1RkxmUVVTdTNWamgxek5CMnRUM3dyMW8ydGkr?=
 =?utf-8?B?WklaNG05Q2RxWExxZlppbmx6RFBNN3I3S3Ard2tJY290NXplWkhzYUJDTnkw?=
 =?utf-8?B?STNuNjJQblNPZ0FYdXV1ZlVvaW9vWld1WUpZaEJBZzlHN2lhK2NQOGFjVHY4?=
 =?utf-8?B?YldockMySzcvNUdVZG1hcWZZaHZBUmphN083SmxDaU5DaGZMYXhMeTJkc0xu?=
 =?utf-8?B?Y3o3eG14N1RCek9GSkhCc2tEa0U1RVVmZzYwUWJOdEhYT0xHYzIxL1NkMWVY?=
 =?utf-8?B?c2FUQXdnQWFRMVMvK1RBS0dEUndvV1NjVXpHTEdrZXE1c1NDTjhJR1dHcUw2?=
 =?utf-8?B?bytVSzJmdjIxcW5pc2ZLTzRKaTZwZDJuYWdOdExlZ0VxcnA3eUpXUW1JL1Zz?=
 =?utf-8?B?WGpxM1I2MG1zQXhqVlFyOVNRRUF1VWd3TXZCa0l3bm1sOTl3dUgvalo5RzUy?=
 =?utf-8?B?QlVOc0tlTTE4OC9Qd1praDRORWxBRUZSWXhPSlhqbVcweUJFNjBoWUlNVHN4?=
 =?utf-8?B?WUxQRWV3NVc5V0Y0MnNzTWZPZGpiZk1ZYmNwMk1STFVoY3FmUjNlTGZqalRW?=
 =?utf-8?B?M1FoazkrTGhCQ3hmbXN6ZVFUczlDaENsT0JtTUJyNDhVTFVFc3FZTnlYb3pt?=
 =?utf-8?B?TDlVRXI4aE9VbWRYM0Y4bXllVHVSYnJvMFMxNTFPMFRIMnpGQjEzbEVFdC8z?=
 =?utf-8?B?YWdkVSsyQmJyamo0Y2Y2a0lNSHBXNUtIT2o2OHhrN1N3Yy9GRUpOY0JXOENt?=
 =?utf-8?B?d1RDOFY5ajZtam90YnZnVkRROE9JeFJGL0NKem9QYmxPcEhSY2wvSjYwcDdO?=
 =?utf-8?B?b3QxY1hhVGZ3aXR5anhOVDZSQWdwR1QyTDNHODhPNEd2Y3QvQ0hWUTZQdHV3?=
 =?utf-8?Q?vbrNUdgPnykySuH/tR9ApxT9LoWEPA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmppVWd5UllTczlnK0YwS3I0bzF0YXkvS3lzbDFmdFlXOFF5dE4wQWZ3QnMy?=
 =?utf-8?B?V2F0cDdCdmREbUkza3dGQ1BlZDBOeGpYVklRMm9kSlh2MjhoenlYWE9kc0Jx?=
 =?utf-8?B?NC9vbHRrQmVVVW9pMWZhVmFUMnJaeS9qZjZsbUtURUIweTh3VDlyMHg3bWJj?=
 =?utf-8?B?WW0xczE3dmV1NnpLQjJRUVdCSW01WXlLYm11SmN0eTIxL0d6L2gzRFo5M0pV?=
 =?utf-8?B?aFZLUVh2QVQwV1JtSjVTb2srQ2ljRElwMXlCMUFqSnVuNGxrWFdkQTBjUFd6?=
 =?utf-8?B?dnU2dU1ka0ZqV0htN29NK0pic3NmU3lNdmNzczhxdyt2ai9DeHdRSzd1VGlO?=
 =?utf-8?B?aWloMmdjNVRmWGVYK2xFeStNVkwzMURUSVgzRzFQSVJwbE10NXhKdlFQSDZz?=
 =?utf-8?B?aGJwYkxCWTFDQW9EaUhhZnhtQ2VYbUxOcUk5TlNYY01VeXFtVjJvN0hoUWdJ?=
 =?utf-8?B?UkJITndjbmFobjdTbE1COUlYNHFQUFlEUVowSUl4OTZXUWxzWk12YjFjeW9p?=
 =?utf-8?B?SnRIOTdSZS9WNUVTZUI5RUU1aktKek1mQzdJY2QxRUlBTEpyNVpzTTFMVG44?=
 =?utf-8?B?ZDZld1lWcFd1dWJ3VHJiZEJadVNSU3QxcmYvak5aM2tmcU9zVVgrQVQ3eUwv?=
 =?utf-8?B?OWo3YkhRZXdrM0tEWldrNEpsakZqSWNhOHNhSHZBU0RBU1VSeDFhZVdOMHFu?=
 =?utf-8?B?Sk1YK3dNMVhscndsbnFseEtFTU8xZndibU1TYllmVEQ1Wnp5ekFRT2s0dlNq?=
 =?utf-8?B?TzlmcXl1NDZlQ0RiK2VpbW1iUENZSjhlVmxXYWFBTUJTZjd0UUNsZEkwRGNU?=
 =?utf-8?B?dUx0RGhFeW5ZTHBrdXJDTE9EdVVVcmVRdDdMMzdkZ3VzSkRTdjJGVkU5V3Jm?=
 =?utf-8?B?UjU2ZmN0VzA0cFZUbm0xVEYyK3o3Q0JycEJGUUprSlJHQzRtZFRSSzRmTlB3?=
 =?utf-8?B?REFwaktCZ1U3dzhraEZ4Z3JhZlBQNFlZbTFRTjRMK1FacldIUkZ5akVGR1h6?=
 =?utf-8?B?WWJQeUFDRXh4NTBsZGNnZVV1cHFSQWp3NVBnV0RxUDNwTTBNYVBCVC93dFgx?=
 =?utf-8?B?bnFNSW5sUVAxZDhKTXBsdm5FNVZXYkFWNmltd2tTSGVNZnNMT1ZvTHpuQU9V?=
 =?utf-8?B?Kyt4S1o5VVN1ZFRMVlFZN0wvZ1MyaTZ1bWcrak92Y1NxT2ZjZm9wTEZtR2Yv?=
 =?utf-8?B?emloQVFMcmV6bDJQdThYc1VYd3l0M2xZdTdYMWFYN0pEcTFVVnZIQnJPV1NW?=
 =?utf-8?B?Tm9Qd2ovdHdyTFZpUURGemR3M1VxcFNGVTZGVWZ3NVoxSmtEcGUvUzRwR2FY?=
 =?utf-8?B?OGZUZWg0RXZkaU56ZlhzZGJoOWtDOXlNdXBhZTN1S3dYZEY1UGhCSzZTbDd4?=
 =?utf-8?B?OGdROTJ3NjEyMmZiSjVpTHFEVm9USUIyemkwVi93SzdsZmN6bk1VV01oYUx6?=
 =?utf-8?B?Z0FmenlmMWtYVEdmRHJZSHAzczVrVi9ZK2FRWlRRN1ZSNm00cmtidEdzNTF4?=
 =?utf-8?B?MDY4bDZoZlB2Q0tJWXVPV1pTMXJSSnMzb3l3NG1TYVNXaVhoK1RJcG9pOHpF?=
 =?utf-8?B?UWZPVlFSYjd2a0JTbWJOaEdsSE4yOGErRXdxeWRzWE5wVmE3SWRvbXhPV3Fk?=
 =?utf-8?B?MldIa3dhMWJYU3orVGJ2MU5xOE1IRk5rV3M0Z2JZZHFieldIMUVjV0wxTzln?=
 =?utf-8?B?Tks4YlRLeHhtOGd3c0ZSR1pRQ2NKWmhyZ1J4U0c5N01RbXBwWFpmVUNCN1Fy?=
 =?utf-8?B?RFlJWVFYVGxhbzBITHZjK0lTZVAyV0VvTW1xK1ZkYjJXOGkySElaZ0xYcFNM?=
 =?utf-8?B?dzFjWWNvYy9UNUpXa0Q4amxZeE9nUnJMQXlTTkFhTE1PUDZ1SU5IeHNMaDFJ?=
 =?utf-8?B?N29OelNYQ3BRS2tlQ1FhWEcwR3hjaDFDdnpkM2JEQjRuMTlDaUFwaWh1ZC9G?=
 =?utf-8?B?ZDUxcDFvaVFGUWhCYWpHT3lTaG5Td3NrUjhBL1hUMlBWa2JjczMzVWRCZVJN?=
 =?utf-8?B?b0ozeldSUzFBSWNZaXpNR25kNzJGTU1rM00yNFI4NWszbjJTWFBqQ0syVmZ6?=
 =?utf-8?B?TTdybFpmazRncFIxRU12dyt5b1RtYkE1cXJndWczQmtXT24rcGRPdDE2aGJ4?=
 =?utf-8?Q?3BBgL975Pfbofsc94u2a3+Pmh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee27a8e-c330-4a75-3d6b-08dda32bacf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 05:50:13.7061 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EP5aYskI3JFJcfEq2MSrdTjcHTeLrJ5YVH42DfQq+QDMgJCOm10pNOwFC4d0Ak/m+1xx9HUoygVgj2+cj3CUFuPZ1504BmLtvFgru4Jtwos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7014
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlNlbnQ6IFR1ZXNkYXksIEp1bmUgMywgMjAyNSA4
OjIxIFBNDQo+VG86IER1YW4sIFpoZW56aG9uZyA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPjsg
cWVtdS1kZXZlbEBub25nbnUub3JnDQo+Q2M6IGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tOyBj
bGdAcmVkaGF0LmNvbTsgbXN0QHJlZGhhdC5jb207DQo+amFzb3dhbmdAcmVkaGF0LmNvbTsgcGV0
ZXJ4QHJlZGhhdC5jb207IGRkdXRpbGVAcmVkaGF0LmNvbTsNCj5qZ2dAbnZpZGlhLmNvbTsgbmlj
b2xpbmNAbnZpZGlhLmNvbTsgc2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tOw0K
PmpvYW8ubS5tYXJ0aW5zQG9yYWNsZS5jb207IGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4u
Y29tOyBUaWFuLCBLZXZpbg0KPjxrZXZpbi50aWFuQGludGVsLmNvbT47IExpdSwgWWkgTCA8eWku
bC5saXVAaW50ZWwuY29tPjsgUGVuZywgQ2hhbyBQDQo+PGNoYW8ucC5wZW5nQGludGVsLmNvbT4N
Cj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvNF0gYmFja2VuZHMvaW9tbXVmZDogQWRkIGEgaGVs
cGVyIHRvIGludmFsaWRhdGUgdXNlci0NCj5tYW5hZ2VkIEhXUFQNCj4NCj5IaSBaaGVuemhvbmcs
DQo+DQo+T24gNS8zMC8yNSAxMTozNSBBTSwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBUaGlz
IGhlbHBlciBwYXNzZXMgY2FjaGUgaW52YWxpZGF0aW9uIHJlcXVlc3QgZnJvbSBndWVzdCB0byBp
bnZhbGlkYXRlDQo+PiBzdGFnZS0xIHBhZ2UgdGFibGUgY2FjaGUgaW4gaG9zdCBoYXJkd2FyZS4N
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwu
Y29tPg0KPj4gLS0tDQo+PiAgaW5jbHVkZS9zeXN0ZW0vaW9tbXVmZC5oIHwgIDQgKysrKw0KPj4g
IGJhY2tlbmRzL2lvbW11ZmQuYyAgICAgICB8IDM2ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPj4gIGJhY2tlbmRzL3RyYWNlLWV2ZW50cyAgICB8ICAxICsNCj4+ICAzIGZp
bGVzIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9zeXN0ZW0vaW9tbXVmZC5oIGIvaW5jbHVkZS9zeXN0ZW0vaW9tbXVmZC5oDQo+PiBpbmRleCBj
YmFiNzViZmJmLi44M2FiOGUxZTRjIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9zeXN0ZW0vaW9t
bXVmZC5oDQo+PiArKysgYi9pbmNsdWRlL3N5c3RlbS9pb21tdWZkLmgNCj4+IEBAIC02MSw2ICs2
MSwxMCBAQCBib29sDQo+aW9tbXVmZF9iYWNrZW5kX2dldF9kaXJ0eV9iaXRtYXAoSU9NTVVGREJh
Y2tlbmQgKmJlLCB1aW50MzJfdCBod3B0X2lkLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdWludDY0X3QgaW92YSwgcmFtX2FkZHJfdCBzaXplLA0KPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgcGFnZV9zaXplLCB1aW50
NjRfdCAqZGF0YSwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVy
cm9yICoqZXJycCk7DQo+PiArYm9vbCBpb21tdWZkX2JhY2tlbmRfaW52YWxpZGF0ZV9jYWNoZShJ
T01NVUZEQmFja2VuZCAqYmUsIHVpbnQzMl90IGlkLA0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdWludDMyX3QgZGF0YV90eXBlLCB1aW50MzJfdCBlbnRyeV9sZW4s
DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCAqZW50
cnlfbnVtLCB2b2lkICpkYXRhLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgRXJyb3IgKiplcnJwKTsNCj4+DQo+PiAgI2RlZmluZSBUWVBFX0hPU1RfSU9NTVVfREVW
SUNFX0lPTU1VRkQNCj5UWVBFX0hPU1RfSU9NTVVfREVWSUNFICItaW9tbXVmZCINCj4+ICAjZW5k
aWYNCj4+IGRpZmYgLS1naXQgYS9iYWNrZW5kcy9pb21tdWZkLmMgYi9iYWNrZW5kcy9pb21tdWZk
LmMNCj4+IGluZGV4IGI3M2Y3NWNkMGIuLjhiY2RiNjBmZTcgMTAwNjQ0DQo+PiAtLS0gYS9iYWNr
ZW5kcy9pb21tdWZkLmMNCj4+ICsrKyBiL2JhY2tlbmRzL2lvbW11ZmQuYw0KPj4gQEAgLTMxMSw2
ICszMTEsNDIgQEAgYm9vbA0KPmlvbW11ZmRfYmFja2VuZF9nZXRfZGV2aWNlX2luZm8oSU9NTVVG
REJhY2tlbmQgKmJlLCB1aW50MzJfdCBkZXZpZCwNCj4+ICAgICAgcmV0dXJuIHRydWU7DQo+PiAg
fQ0KPj4NCj4+ICtib29sIGlvbW11ZmRfYmFja2VuZF9pbnZhbGlkYXRlX2NhY2hlKElPTU1VRkRC
YWNrZW5kICpiZSwgdWludDMyX3QgaWQsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB1aW50MzJfdCBkYXRhX3R5cGUsIHVpbnQzMl90IGVudHJ5X2xlbiwNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90ICplbnRyeV9udW0s
IHZvaWQgKmRhdGEsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBF
cnJvciAqKmVycnApDQo+PiArew0KPj4gKyAgICBpbnQgcmV0LCBmZCA9IGJlLT5mZDsNCj4+ICsg
ICAgdWludDMyX3QgdG90YWxfZW50cmllcyA9ICplbnRyeV9udW07DQo+PiArICAgIHN0cnVjdCBp
b21tdV9od3B0X2ludmFsaWRhdGUgY2FjaGUgPSB7DQo+PiArICAgICAgICAuc2l6ZSA9IHNpemVv
ZihjYWNoZSksDQo+PiArICAgICAgICAuaHdwdF9pZCA9IGlkLA0KPj4gKyAgICAgICAgLmRhdGFf
dHlwZSA9IGRhdGFfdHlwZSwNCj4+ICsgICAgICAgIC5lbnRyeV9sZW4gPSBlbnRyeV9sZW4sDQo+
PiArICAgICAgICAuZW50cnlfbnVtID0gdG90YWxfZW50cmllcywNCj4+ICsgICAgICAgIC5kYXRh
X3VwdHIgPSAodWludHB0cl90KWRhdGEsDQo+PiArICAgIH07DQo+PiArDQo+PiArICAgIHJldCA9
IGlvY3RsKGZkLCBJT01NVV9IV1BUX0lOVkFMSURBVEUsICZjYWNoZSk7DQo+PiArICAgIHRyYWNl
X2lvbW11ZmRfYmFja2VuZF9pbnZhbGlkYXRlX2NhY2hlKGZkLCBpZCwgZGF0YV90eXBlLCBlbnRy
eV9sZW4sDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRv
dGFsX2VudHJpZXMsIGNhY2hlLmVudHJ5X251bSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKHVpbnRwdHJfdClkYXRhLCByZXQgPyBlcnJubyA6IDApOw0K
Pj4gKyAgICAqZW50cnlfbnVtID0gY2FjaGUuZW50cnlfbnVtOw0KPj4gKw0KPj4gKyAgICBpZiAo
cmV0KSB7DQo+PiArICAgICAgICBlcnJvcl9zZXRnX2Vycm5vKGVycnAsIGVycm5vLCAiSU9NTVVf
SFdQVF9JTlZBTElEQVRFIGZhaWxlZDoiDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICIg
dG90YWwgJWQgZW50cmllcywgcHJvY2Vzc2VkICVkIGVudHJpZXMiLA0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICB0b3RhbF9lbnRyaWVzLCBjYWNoZS5lbnRyeV9udW0pOw0KPj4gKyAgICB9
IGVsc2UgaWYgKHRvdGFsX2VudHJpZXMgIT0gY2FjaGUuZW50cnlfbnVtKSB7DQo+PiArICAgICAg
ICBlcnJvcl9zZXRnKGVycnAsICJJT01NVV9IV1BUX0lOVkFMSURBVEUgc3VjY2VlZCBidXQgd2l0
aA0KPnVucHJvY2Vzc2VkIg0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAiIGVudHJpZXM6
IHRvdGFsICVkIGVudHJpZXMsIHByb2Nlc3NlZCAlZCBlbnRyaWVzLiINCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgIiBLZXJuZWwgQlVHPyEiLCB0b3RhbF9lbnRyaWVzLCBjYWNoZS5lbnRy
eV9udW0pOw0KPkNhbiB0aGlzIGhhcHBlbj8gSXNuJ3QgaXQgYSBmYWlsdXJlIGNhc2U/DQoNCkl0
IHNob3VsZG4ndCBoYXBwZW4gZXhjZXB0IGtlcm5lbCBoYXMgYSBidWcuIEl0J3MgYSBmYWlsdXJl
IGNhc2UsIHNvIGZhbHNlIGlzIHJldHVybmVkLg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+DQo+
QmVzaWRlcw0KPlJldmlld2VkLWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+
DQo+DQo+DQo+RXJpYw0KPj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gKyAgICB9DQo+PiAr
DQo+PiArICAgIHJldHVybiAhcmV0Ow0KPj4gK30NCj4+ICsNCj4+ICBzdGF0aWMgaW50IGhpb2Rf
aW9tbXVmZF9nZXRfY2FwKEhvc3RJT01NVURldmljZSAqaGlvZCwgaW50IGNhcCwgRXJyb3INCj4q
KmVycnApDQo+PiAgew0KPj4gICAgICBIb3N0SU9NTVVEZXZpY2VDYXBzICpjYXBzID0gJmhpb2Qt
PmNhcHM7DQo+PiBkaWZmIC0tZ2l0IGEvYmFja2VuZHMvdHJhY2UtZXZlbnRzIGIvYmFja2VuZHMv
dHJhY2UtZXZlbnRzDQo+PiBpbmRleCA0MDgxMWEzMTYyLi43Mjc4MjE0ZWE1IDEwMDY0NA0KPj4g
LS0tIGEvYmFja2VuZHMvdHJhY2UtZXZlbnRzDQo+PiArKysgYi9iYWNrZW5kcy90cmFjZS1ldmVu
dHMNCj4+IEBAIC0xOCwzICsxOCw0IEBAIGlvbW11ZmRfYmFja2VuZF9hbGxvY19od3B0KGludCBp
b21tdWZkLCB1aW50MzJfdA0KPmRldl9pZCwgdWludDMyX3QgcHRfaWQsIHVpbnQzMl8NCj4+ICBp
b21tdWZkX2JhY2tlbmRfZnJlZV9pZChpbnQgaW9tbXVmZCwgdWludDMyX3QgaWQsIGludCByZXQp
ICIgaW9tbXVmZD0lZA0KPmlkPSVkICglZCkiDQo+PiAgaW9tbXVmZF9iYWNrZW5kX3NldF9kaXJ0
eShpbnQgaW9tbXVmZCwgdWludDMyX3QgaHdwdF9pZCwgYm9vbCBzdGFydCwgaW50IHJldCkNCj4i
IGlvbW11ZmQ9JWQgaHdwdD0ldSBlbmFibGU9JWQgKCVkKSINCj4+ICBpb21tdWZkX2JhY2tlbmRf
Z2V0X2RpcnR5X2JpdG1hcChpbnQgaW9tbXVmZCwgdWludDMyX3QgaHdwdF9pZCwgdWludDY0X3QN
Cj5pb3ZhLCB1aW50NjRfdCBzaXplLCB1aW50NjRfdCBwYWdlX3NpemUsIGludCByZXQpICIgaW9t
bXVmZD0lZCBod3B0PSV1DQo+aW92YT0weCUiUFJJeDY0IiBzaXplPTB4JSJQUkl4NjQiIHBhZ2Vf
c2l6ZT0weCUiUFJJeDY0IiAoJWQpIg0KPj4gK2lvbW11ZmRfYmFja2VuZF9pbnZhbGlkYXRlX2Nh
Y2hlKGludCBpb21tdWZkLCB1aW50MzJfdCBpZCwgdWludDMyX3QNCj5kYXRhX3R5cGUsIHVpbnQz
Ml90IGVudHJ5X2xlbiwgdWludDMyX3QgZW50cnlfbnVtLCB1aW50MzJfdCBkb25lX251bSwgdWlu
dDY0X3QNCj5kYXRhX3B0ciwgaW50IHJldCkgIiBpb21tdWZkPSVkIGlkPSV1IGRhdGFfdHlwZT0l
dSBlbnRyeV9sZW49JXUNCj5lbnRyeV9udW09JXUgZG9uZV9udW09JXUgZGF0YV9wdHI9MHglIlBS
SXg2NCIgKCVkKSINCg0K

