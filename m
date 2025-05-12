Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BB9C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 17:03:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEWY8-0004SI-65; Mon, 12 May 2025 13:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1uEWY4-0004NF-NG; Mon, 12 May 2025 13:02:42 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1uEWY1-0001CU-2l; Mon, 12 May 2025 13:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747069358; x=1778605358;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=on7PbeFOyYBIT4HPr5WE1niUyKxsnD8H/jsdPRVaQwI=;
 b=SbZnhCSyweFL9w9Z5XD/BqRpJ+MeEcaabMq6lX9OpSoynwCZYPMXMc/l
 P7EMAkF3d7hWGQAekRdlVtsJ/9ybyUcH4YfvA12p6QWFVpHWmfuk/kNVE
 /aYYQrw/QehOAYSXhhvNniJX0wOjrGyy9WgE/ABjHhy43J+5bcTKPWcQY
 aXA5kyNHU0XR74A5aDFHJPZNboUuLya+ZhkENcIO6RW4/A9q6UQDQmE8K
 MjyRDnHICxnuixwvjUPI+We7ZdlMBJlbFFbrlfrRjSjVw4c6n180h9nSH
 KsVfN5UzqrtALu6EKgRdar5nPMhyQlvt7bgxQsCldBQ6iwbKXg2nQNwgp g==;
X-CSE-ConnectionGUID: r29HkYNDTyO4mAuAIRH7+g==
X-CSE-MsgGUID: 2JpF8VUsQR6zOtA7cQM+Kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="59880938"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="59880938"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 10:01:31 -0700
X-CSE-ConnectionGUID: az4G+yCXTN+NdWG4uxOy3g==
X-CSE-MsgGUID: +cPE6g2qSKC05CxPW6JdzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="138362064"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 10:01:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 12 May 2025 10:01:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 12 May 2025 10:01:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 12 May 2025 10:01:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vsm7XKnVYKXIFZqovzAlfA2XAdOFPtsjAQ0ttzlR0oUlrVJHzUY/lJZvLhtZOuhC8XqAwRZPQcuvezkuCYw17TpMepaWLqQEGkgdUICP5IRlMb7DnBPlNRaDWRBoHYOkebCZ2lZIaI+ydEi5uRQRBu0NTTr3xmkojsUvhEbzh8KNFJCd9m4XYl5jEaV2ewfu6LIOnVz9ibbfl0P4RmHUJ7rXpg2QMrurL6zLG8ZhkdkuYmO9LsaBygRsPBkm6keB6p1N2iZsPkK7T/P94kaIWYT4ubgXrZ9tsrOBLFpuFKgVM841gMwWF9Io7XpaLXyqs3zEvNQZMByMx+G7kCWCDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=on7PbeFOyYBIT4HPr5WE1niUyKxsnD8H/jsdPRVaQwI=;
 b=vt7/wmQ2o7Uok8l0ZxH9jKLg2N5J0J9zI6OCSbqr5TJZlf7kXr+6VCp0QNxHIn5Antg/8VCLo9xSMi8K7jtYQte6lhaEV8i9zA6a6sB50hywo1VHhkDJ0pYSKCmpJ2kqMw8a5ATT+pSNTnRPe9DgidK3GQpMOENAGFQlYYBkFReTNlv8gfpXUnC0ZJ+5yoU5AY9++SPy4iOM449mWCDUPTRYau9bDtk6T3k8GxCIqdWNmcYQta2nntUZJCetNPArs6ATE5GvuZfiMgooXqi69wA4WJDBm5ksD2t+KIqxjSrUIi3xL+FMoYFjv6Sc6JL6c8I4roU/XnRsRjj1xs7eTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by IA0PR11MB7790.namprd11.prod.outlook.com (2603:10b6:208:403::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Mon, 12 May
 2025 17:01:18 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%7]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 17:01:18 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, =?utf-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "David
 Hildenbrand" <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Pierrick
 Bouvier" <pierrick.bouvier@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Peter Xu
 <peterx@redhat.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, John Snow <jsnow@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>, Alexandre Iooss
 <erdnaxe@crans.org>, "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
Subject: RE: [PATCH v2 12/14] ui/gtk-gl-area: Remove extra draw call in refresh
Thread-Topic: [PATCH v2 12/14] ui/gtk-gl-area: Remove extra draw call in
 refresh
Thread-Index: AQHbvoaBXXwd+aohNE2njZ3n9lvDrLPLUYKAgAB7HYCAARX5gIACXREQ
Date: Mon, 12 May 2025 17:01:18 +0000
Message-ID: <PH8PR11MB6879FBA9E5133649714D74AEFA97A@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20250506125715.232872-1-alex.bennee@linaro.org>
 <20250506125715.232872-13-alex.bennee@linaro.org>
 <d5a8cec1-f689-4d31-b6bb-b63eaa4ce2af@daynix.com>
 <d370ffec-f430-4377-80bc-323d5087834c@collabora.com>
 <f7d65908-cd12-4c44-a80a-07e23ff27833@daynix.com>
In-Reply-To: <f7d65908-cd12-4c44-a80a-07e23ff27833@daynix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|IA0PR11MB7790:EE_
x-ms-office365-filtering-correlation-id: b96f05be-264c-4681-097b-08dd91769d0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?S1VPY3p2clN5bWxzNEMrZWp0cU1CTmJZZFdnaUo5UEs3VndyV05PZzlQMTFT?=
 =?utf-8?B?b2EwblR0dFhTamtWamQ0YXQ3MDZsTTQ4d2hTZ09SYUxiTzh6S2NYZmN4Nk9J?=
 =?utf-8?B?RTNzSHRRdVJQYTR5dzBvOW9wdXUxZkNYa0x5aG53WjVlblBFaTh4UDFiekUy?=
 =?utf-8?B?VHZOcmZ0cUU2VjlKY08yZStvQjJEbk4xTXhzaUE0dkV6bUpTdC9yeHFmOHFJ?=
 =?utf-8?B?SStDNFZPMkx3cWVOcE1DYXBuUmRDTkpYR2R4V3A4WTFWaW5UL2c5Y2g0QWFs?=
 =?utf-8?B?K0ZFWjFNNjlTY1dMeE9NTDYzbjRURmlHa0pGcUcxWXFKQzlJTjh0ZGI1a01U?=
 =?utf-8?B?dFpkVVdwc1BIMFBKQUtValg1Wng4Tml6NWpvQ05Ca2dUeWxIR1Ivc01hSWFI?=
 =?utf-8?B?bXZ4UzFLdEZCaUJnMVg0KzBsUWQ1U1AzYm1QUWx1cmptQk1vY2lhcEJWN2lz?=
 =?utf-8?B?Zk9Uc1BwM0xhUFhEeDN0dDI1WjkvU2RiQno1RlJmZXdYS1Z1eE1OTTMxNlVj?=
 =?utf-8?B?QWtobnE2R2JNQVU5YVM0VlQ4S2F3MHVjbjdBb3FQdm1iY1BwVGxsU3B6VUdB?=
 =?utf-8?B?YklkUnJNRTI2YVNzckdpUzMyZDNjSGtPZjE3RnR3Y2RMOVhrak40UUd5OGxZ?=
 =?utf-8?B?a0NuQjBYdUg5Uk9UYk1vRzVnOUNzZnBWNFNNOHdxU3lTWDBSWFNHTVJYa1M5?=
 =?utf-8?B?OWdoa1hxMUFzY2hvWkZDYlRIcUdEMVF5c0ZORk43RkJKTnFKRUdmdXRQdml1?=
 =?utf-8?B?MkVPRy83VDdKSGV0SnpKWTlIQmlKbTdkTUNjUk1DVGxnMm11VFZSVTNhdXkx?=
 =?utf-8?B?dmNnaE9JeDJwaFIwTVNES3VpczE2QmFXSEtBZW55K3d1MUdoSWhsWnBSY1Yz?=
 =?utf-8?B?c0Nra2tHd1pCeDJNYkozNS9iY2xQYkYvNVcrckFIakpibVlmRjY1WVZTenBl?=
 =?utf-8?B?eWtJNC9KcHoxWk5aZXNpRGZoekNDVVBnK0hjTnJVSmdIdFZ4M04vWWZDdlBX?=
 =?utf-8?B?QUVlS1JRWHpiRk9aL3kvL1Q4UWJOVjlTWHVPSmJpdkkwNk9CNEdtT2VBckZo?=
 =?utf-8?B?cGZvRnJJNHhjK2lGMGRHQWJTV2F5KzBJSUFraDFIY2RNVFYvV2lBQkJCOEZS?=
 =?utf-8?B?MnFzOW9VbEhxY1RTR2dkckNLZms2dGZyMTBxaXhBZHFEaUFJUmUzZE94WW5I?=
 =?utf-8?B?UFlVd1FQY3JTdDdtcGVkSW1GdE4reWVLNmtVUTdFcVVvdmR0NDdGNG9SaGhU?=
 =?utf-8?B?ZWpIbEJZMnk0R2xMV3lnRm0xZTk1NWVrT0V2M1hMelp1WExRSWJPb2pDZVRO?=
 =?utf-8?B?dzVoZGpXNGtBZmZNODRUUllibmxiTEtYVy9iRk5kaG9YK1pKREVPR3kvL0Nh?=
 =?utf-8?B?czhUeThETnc1WUpLQnBncVA4b1JQN0JhSW1vUE9zZEZucHBWZ2F6VE9rbFFm?=
 =?utf-8?B?WnlJcnlhdHpPSUhmNmVvbFU2VHJBRHowSzNZckFmTWlNeFZGM1IzRE9vMDFw?=
 =?utf-8?B?M3JTM3BqbnBqQU9ibDYxak1KOEpHdTJiOGdnS3l3UUs3OEJGYVNMT0hIRnQ2?=
 =?utf-8?B?SWs2cjd2MkQ2T2daZ3hmS25KRkVQVWFNS2hxcG50ZXYxZnhSazIzVXB0V1Rk?=
 =?utf-8?B?MGxKR2d6bWluQWUwS3JhL1J0MnoyZy9ZMjNTKzNpZ21yT2ZlMEhLMnhqalo0?=
 =?utf-8?B?L3hPMklvSklZM0FmR1pMV2dIbitldkY5RE9IaWdjcExZNU5FUUVLWTBpdG9w?=
 =?utf-8?B?RVFVdWgzQ29FVzhNaFZKSWhRTU9EZ3d2UnBtSFFuZmswdXlhV0lTcEFUcDZu?=
 =?utf-8?B?UFJuMXJZWDAzRVIxMGJ5UTI5L2E0TGV1ZjVtSzdwSVF1TGVXRXFZa0tubTF1?=
 =?utf-8?B?R0U4VzJ4NEFEeTlTUml0Sm1mZkJuUmxOeDRTblB0VWlPMFFxODFDTlgwSWts?=
 =?utf-8?B?WGpZMm9MZ3JreTFoUnlNWVR6L3RBWjdSazJRNXhVVjIrOHJ6ME1SSUdBVzJk?=
 =?utf-8?Q?Y3TqqO3WbFmjSuFcL7ZEv10ujic7Uk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzBSZ3NoNk5hRFVsRWYzV2huMytZNWFsbW9WUktObS9sSk1nY2FMNHJyZFR3?=
 =?utf-8?B?SGlaSFkxd1dZN1dRQlN5Zk5CaUxCS3FjNHdVWTM4ZVhUOVExcW50aXN3OHpx?=
 =?utf-8?B?RnllUGlWQWdzUU15LzVTU2ZKbzBvcmROYUIzeXpKT05MOUVicVNGdlNpNDhq?=
 =?utf-8?B?OThlTTZCM1MwUWV3RVBPVXBueVJpS21ZdmpzU1pYeVVEanNsUWdkbEJ2SDUz?=
 =?utf-8?B?RWFJY2R1NDVOa2hIcTBOT0NGY3hZMHMxM2hHS2FXRldvRlNHNGxmT2M3b0xn?=
 =?utf-8?B?b0VoTDErTjlYcVVDakhRay80MkRqWjMvQWc0akxjLzFUbUtOa0hhNGM0L1Nz?=
 =?utf-8?B?RHZtazlBWlhiSm9mcktYb3l3T2FudUtyYzVnKzVYaW1aRkVPUVg1em5Nd3VY?=
 =?utf-8?B?clZmMVJVV1UzalB0RDdpMnZjR1NjZEx6aFU1K0ZpY2JwSmV6dFUyd2lxSWNV?=
 =?utf-8?B?ZXpGZzFBZVMybk0zRGRiaTBreFdKazRrUytva3JkVUxHZmhYKy83TU9rTTd6?=
 =?utf-8?B?M05zRW9rYXpHODV0ZUxjV0s3TklTOWQ4TTdHRHBVNUdJWDJMNCtqcEpOQ2dI?=
 =?utf-8?B?c3pIVlBpOGdteWV1MTBreW1NUThkT0IvYTE5KzZKQWd0NFY0WmdnZ0kxaVpw?=
 =?utf-8?B?RHlZWng2NnRvQ0Y1MDJOdFA3UG1CQU9PcXRXK0dkblR1ZERmMkUzbm1DL2tV?=
 =?utf-8?B?L3NGTTNsSmQzNS9lUm5PMWZBMGRyU1VQbGVVTEhKM2tDZEdlTndrbmE5cTUr?=
 =?utf-8?B?VFBMeWNwUGxNOGVPWmtHbjJTdFFiditmM1pLcWd1OVlHeURXY0gwNWhjWFoz?=
 =?utf-8?B?ZXpiWHFPN3FHRjhyUmRQT0lOdFlLcFhNT25xajl3cyttTDBRbENUNlZCZnk5?=
 =?utf-8?B?ZzQwZUpabXRGblMzVlMvMjF1OGo5bGR0VXhnUWo0SVdyUG9LYlgrcTdMZzU4?=
 =?utf-8?B?c2xHbmhCb1hPYU5IeXNGQ1NlOTZab2dXdlRCV3EzeG50Y3ByMG9oV2JidUM4?=
 =?utf-8?B?bkhVbk5rWTRVcEZlZklXZHdURUdhbDdrdjVyTmUwL1c2ODhJc0hnVHBJWFFO?=
 =?utf-8?B?REw4Nnl4bXh4OWlpZW5VUjZlSTEyT1R2S3VpaU5zMFQ5QUdNMHV6WitOMXpv?=
 =?utf-8?B?RC9kMk9qbWpwY2JLYytNY0ZHTEU5Ri9NSWlaZ3hpZXIzN3JCSGxneVVCL3ZY?=
 =?utf-8?B?aVFGNWRPNGo2cFl3S3d2QXVtZllFdXBkVjNlODdTOEpvZHptUHFaWDFwRk5C?=
 =?utf-8?B?bXVYanVHQmJQb1VJWG1lWWVvSmdpd0huVE1ZTEMzMEdFRWh1UjRPcHJNVmlI?=
 =?utf-8?B?eUZNM0l3R2QvQVA2UmpRMVgwY3RjZzdFSldNeDRSeDAra0s0NS92SWVzVzdo?=
 =?utf-8?B?SGVxQ3V5MUU4VjFGdVBxMGpMd3Q1eHRKTFF6NWhINU1kRXFYVktpbjZzYUlC?=
 =?utf-8?B?UDVWMGRTRkVJT1dJOFl1ajlVbmdRcTlJbUl0WTdTYXZ2TjV0dU0rZ2QrZ202?=
 =?utf-8?B?d3RDRWFiQVJIaHdZRmpTdm1JM2Z5UEFXZVo2dTMwcWx3dnBrNjdKY2hER2ZS?=
 =?utf-8?B?dEVDUS9CaldPVDFwWUJ4TnpEK1dsN3hzV3ZoUFR0TTZncnNyY2RoZEtabDFL?=
 =?utf-8?B?dHdhR1pmWGpCZ09mUGhTMTdGNGlvRFdEb2N3TGNZWmJ5UnZlWTZSYVFzdmdq?=
 =?utf-8?B?b0VIeGdQWHNJWm0xNXh4OWo4UGRVVGE0NGx6L3hiUmpnVE0vY3dtbmhKMGIy?=
 =?utf-8?B?N0I0eHFLWnU2R1o1YW1Cc08ydncrVHZlV3U1SEZaRU1sV0hXd0J4dGR5eEZq?=
 =?utf-8?B?TjE1YkxSaUowdDlwK3FBSHR5UVNzYTgwb2tndlJFa1hLRlQxNVB6WWd2T1l5?=
 =?utf-8?B?MUtKQy9TVkZiRllYazhyakxvS0dYZVFvQ0FKYnExaDBRajNiaFhiei83SnBV?=
 =?utf-8?B?ZnV5V1BxNlVSWE9oZjRZTERURlQvbUpPcEp0blo5RFZabHRDakt0Q2EyOTkr?=
 =?utf-8?B?b0lOb1pBZDVSZ25CZGo0SWIzY2FoR05JM1RSbFE5cWlLd0RtNWZTMjJUY0Zh?=
 =?utf-8?B?WVRWUEdHMzloaTdFc1ZoWTZVUlFWcFhGbGZjWW0xWTV3UUlLYnphQW1ROTlh?=
 =?utf-8?Q?C5clndRXOWeMckushvQWgtqYT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96f05be-264c-4681-097b-08dd91769d0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 17:01:18.3026 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hFd/RGogEvSFDHQUjqW59D2EBKllN4fTnNVyAN+Rv3Avw/+SY7PD+cCoix0OGsp1z2aHaRHLO8qrhdrqlw0dQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7790
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEyLzE0XSB1aS9ndGstZ2wtYXJlYTogUmVtb3ZlIGV4
dHJhIGRyYXcgY2FsbCBpbiByZWZyZXNoDQo+IA0KPiBPbiAyMDI1LzA1LzEwIDIxOjEyLCBEbWl0
cnkgT3NpcGVua28gd3JvdGU6DQo+ID4gT24gNS8xMC8yNSAwNzo1MiwgQWtpaGlrbyBPZGFraSB3
cm90ZToNCj4gPj4gT24gMjAyNS8wNS8wNiAyMTo1NywgQWxleCBCZW5uw6llIHdyb3RlOg0KPiA+
Pj4gRnJvbTogRG9uZ3dvbiBLaW0gPGRvbmd3b24ua2ltQGludGVsLmNvbT4NCj4gPj4+DQo+ID4+
PiBUaGlzIHBhcnRpYWxseSByZXZlcnRzIGNvbW1pdA0KPiA+Pj4gNzdiZjMxMDA4NGRhZDM4YjNh
MmJhZGYwMTc2NmM2NTkwNTZmMWNmMg0KPiA+Pj4gd2hpY2ggY2F1c2VzIHNvbWUgZ3Vlc3QgZGlz
cGxheSBjb3JydXB0aW9uIHdoZW4gZ3RrLWdsLWFyZWEgaXMgdXNlZA0KPiA+Pj4gZm9yIEdUSyBy
ZW5kZXJpbmcgKGUuZy4gV2F5bGFuZCBDb21wb3NpdG9yKSBwb3NzaWJseSBkdWUgdG8NCj4gPj4+
IHNpbXVsYXRhbmVvdXMgYWNjZXNzZXMgb24gdGhlIGd1ZXN0IGZyYW1lIGJ1ZmZlciBieSBob3N0
IGNvbXBvc2l0b3INCj4gPj4+IGFuZCB0aGUgZ3Vlc3QuDQo+ID4+DQo+ID4+IFNpbXBseSByZXZl
cnRpbmcgdGhlIHBhcnQgb2YgdGhlIGNvbW1pdCBtYXkgcmUtaW50cm9kdWNlIHRoZSBwcm9ibGVt
DQo+ID4+IHRoZSBjb21taXQgdHJpZWQgdG8gc29sdmUsIHdoaWNoIHdpbGwgYmUgYSByZWdyZXNz
aW9uIGFzIHRoZSBjb21taXQNCj4gPj4gaXMgYWxyZWFkeSBpbmNsdWRlZCBpbiByZWxlYXNlcy4N
Cj4gPj4NCj4gPj4gSSBndWVzcyB0aGUgcHJvYmxlbSBpcyB0aGF0IHRoZSBnbF9ibG9jayBjYWxs
YmFjayBvZiBHcmFwaGljSHdPcHMgaXMNCj4gPj4gbm90IHByb3Blcmx5IGltcGxlbWVudGVkIGFu
ZCBpdCBpcyB3aGF0IHNob3VsZCBiZSBmaXhlZC4NCj4gPg0KPiA+IFRoZSByZXZlcnRlZCBjb21t
aXQgbWFkZSBRRU1VIEdUSyBHVUkgdW51c2FibGUgdW5kZXIgV2F5bGFuZC4gSXQgd2FzDQo+ID4g
Zml4aW5nIHByb2JsZW0gd2hpY2ggcmVxdWlyZXMgdmVyeSBzcGVjaWZpYyBRRU1VIHNldHVwLCB3
aGlsZSBicmVha2luZw0KPiA+IGdlbmVyaWMgc2V0dXBzLiBUaGUgb2ZmZW5kaW5nIGNoYW5nZSBz
aG91bGQgYmUgcmV2ZXJ0ZWQgYXMgaXQNCj4gPiBpbnRyb2R1Y2VkIGEgYmlnZ2VyIHByb2JsZW0u
IEEgcHJvcGVyIHNvbHV0aW9uIHNob3VsZCBiZSBmb3VuZCwNCj4gPiBtZWFud2hpbGUgUUVNVSBH
VEsgdW5kZXIgV2F5bGFuZCBzaG91bGQgYmUgcmVzdG9yZWQsIElNTy4NCj4gPg0KPiA+IEZvciB0
aGUgcmVmZXJlbmNlIHNlZSBbMV0uIEZpcnN0IGJ1ZyByZXBvcnRzIGFib3V0IGEgbWlycm9yZWQg
ZGlzcGxheQ0KPiA+IHByb2JsZW0gd2VyZSBtYWRlIHRvIG1lIG9uIElSQyBhIHllYXIgYWdvIGFu
ZCB0aGUgcm9vdCBvZiB0aGUgcHJvYmxlbQ0KPiA+IHdhcyBpZGVudGlmaWVkIG9ubHkgY291cGxl
IG1vbnRocyBhZ28uDQo+ID4NCj4gPiBbMV0NCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9x
ZW11LWRldmVsLzVhZWRmMWFkLWQ5YjAtNGVkYi1hMDUwLWYzZDliZWU5YmNjDQo+ID4gYkBjb2xs
YWJvcmEuY29tLw0KPiANCj4gVGhhdCBkZXNjcmliZXMgdGhlIGNvbnRleHQgd2VsbC4gSXQgc2hv
dWxkIGFsc28gYmUgZGVzY3JpYmVkIHdpdGggYW4gaW5saW5lDQo+IGNvbW1lbnQgc28gdGhhdCB3
ZSB3aWxsIG5vdCBsb3NlIHRyYWNrIG9mIHRoZSBrbm93biBwcm9ibGVtLg0KDQpbS2ltLCBEb25n
d29uXSAgRG8geW91IG1lYW4gd2Ugc2hvdWxkIGhhdmUgdGhpcyBpbmZvIGluIHRoZSBjb21taXQg
bWVzc2FnZT8NCg0KPiANCj4gPg0KPiA+IEFzIG9mIHRvZGF5LCB0aGUgR1RLIHByb2JsZW0gaXNu
J3QgdW5kZXJzdG9vZC4NCj4gPg0KPiANCj4gSWYgeW91ciBndWVzcyBhYm91dCBzaW11bHRhbmVv
dXMgYWNjZXNzZXMgb24gdGhlIGd1ZXN0IGZyYW1lIGJ1ZmZlciBpcyBjb3JyZWN0LA0KPiBpdCdz
IGEgYnVnIG9mIHRoZSBlbXVsYXRlZCBkZXZpY2UsIG5vdCBHVEsuDQoNCltLaW0sIERvbmd3b25d
ICAiU2ltdWx0YW5lb3VzIGFjY2Vzc2VzIiB3YXMganVzdCBhIGd1ZXNzLiBUaGlzIHByb2JsZW0g
bmVlZHMgdG8gYmUgZGVidWdnZWQgZnVydGhlci4NCkJUVywgdGhlIHByb2JsZW0gdGhlIG9yaWdp
bmFsIGNvbW1pdCB3YXMgdHJ5aW5nIHRvIGZpeCBpcyBzb21lIGxvY2t1cCBkdWUgdG8gc3VzcGVu
ZGVkIHJlbmRlcmluZyBvbg0KbWluaW1pemVkIG9yIGhpZGRlbiBHVEsgd2luZG93LiBCdXQgYWNj
b3JkaW5nIHRvIERtaXRyeSwgdGhpcyBjYXNlIHdhc24ndCBoaXQgaW4gaGlzIHNldHVwIHdpdGgg
d2F5bGFuZA0KY29tcG9zaXRvciBzbyBJIGFzc3VtZSB0aGUgcmlzayBvZiBub3QgaGF2aW5nIGFu
IGV4dHJhIGRyYXcgaW4gZ3RrLWdsLWFyZWEgd291bGQgYmUgbG93Lg0KDQo+IA0KPiBSZWdhcmRz
LA0KPiBBa2loaWtvIE9kYWtpDQo=

