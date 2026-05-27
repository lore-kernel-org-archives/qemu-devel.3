Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE40CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 07:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS8pm-0005pE-3c; Wed, 27 May 2026 03:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wS8p4-0005li-00
 for qemu-devel@nongnu.org; Wed, 27 May 2026 03:37:04 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wS8oy-0002LU-JS
 for qemu-devel@nongnu.org; Wed, 27 May 2026 03:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779867417; x=1811403417;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=lDF6CUtQMW0lQIP82gwpVNMjC9reyK2HmfAsNtu5fZU=;
 b=T/mCO6MzmHYPU3+5s39KUFuJReQvejAQIdCkXW6waPPCDkq8r4p0MWfR
 /ITJWDqXnh/suV98KQtE3QzeYMaFBWKNn5+MY70WAIyhn5AfY3IhUaFe4
 4oaTxRxio4EVGOMNXnaeX0dhRkbPGWRBDCC5ceTHFRapquwGk86s31H4j
 /fCwADvR9K4LpFTjLKUAr3MMB7Ve/S/Q3jPzzSVt1nTfc9+UR/4s9PzUm
 idWgbdgXrj/RE3Yy87zU8v8OWpsmF/LDeFAG1tTU0wfNk7AMfXKpxpWuC
 WzB1fQPzkozSeMI3vzTCHjsgDS+rwr7iDCgjZ8/pxZNftmxEAL1kOFWnT w==;
X-CSE-ConnectionGUID: CW7/AN0LS1OkJ+GsQgiA2w==
X-CSE-MsgGUID: dMPXGFcDQISMKWB1Cz4zhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="79725550"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="79725550"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 00:36:50 -0700
X-CSE-ConnectionGUID: v+VPUwSbRKiZKPxt9k/D5Q==
X-CSE-MsgGUID: /MiYRkGuTsaGSMb+deGpLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="241113086"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 00:36:50 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 00:36:49 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 00:36:49 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.23) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 00:36:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fkRljvdsf/YqxVqpXkhOkVu/z3wekvUBA4AjIKKxKyWwyCvzUTK46WDn4FStTxaPrjlsDh963ssVbDYYjS94pKJxjTA9qzkvI4gv74qaGvABOOepFkbqCaZvyu4FE8w0sl/PyLgygi8bAC3ExTFTaV5gH74Y9GH5d6OJWuQfrXJD0Jmatv67OhdGVYlvOFUTcv/ApTM/evItlspuq8R8bQ0o0560dNfxknVDhXeJwOU1EmTcZry7vR6V2IQRcfSFjx7ir2SzaSqEPaJ9GDd0jzQsnyxle0btc/1ysO6vVIFYp4WA2cWpba8f6QN9NJzc+WzFHWZD8YfYOlv/5RH9xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDF6CUtQMW0lQIP82gwpVNMjC9reyK2HmfAsNtu5fZU=;
 b=VuKizjjHEl4rxQapAFGDG735hu9F4NPYgTEniwgllbod3Yd8+VrlnGojhEVnjWzYBjqGjogAzOglxPh81hTtYfu7Z2/Jd5pnP0qXj3L5/6qPYhsFBG8g63XFU9XA63LZM0QjoifxkO0GSu4MwKpDlT8Bemh12m8A2Uerd+8mzFEFmk33S/kmSMLa8CfP7Ls0mdgHryyu8TKW5VDdjTbP/Y5zSWdJJ3ycBvxM00CvITvn3L7jbPntov007u2+pm3ag8+Y5QIcOi39pHKcVd7Gvvq0ZYCG145FhHWhIVK6Jk/VUhbVWX4KHcxTjuVq9vCHJ8hRZZYea2o39VozFxkEbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS0PR11MB7460.namprd11.prod.outlook.com (2603:10b6:8:142::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 07:36:40 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.21.0048.016; Wed, 27 May 2026
 07:36:40 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH 4/5] intel_iommu_accel: Accept PRQ response for
 passthrough device
Thread-Topic: [PATCH 4/5] intel_iommu_accel: Accept PRQ response for
 passthrough device
Thread-Index: AQHcvZTT22HcSP9u/UKSocoBc+M+EbYYuIoAgAkjD7A=
Date: Wed, 27 May 2026 07:36:40 +0000
Message-ID: <IA3PR11MB9136CFCEFB3C88F56F0611C992082@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260327025228.474257-1-zhenzhong.duan@intel.com>
 <20260327025228.474257-5-zhenzhong.duan@intel.com>
 <a628bd88-f15d-4b92-8dc3-9394f6e50a41@intel.com>
In-Reply-To: <a628bd88-f15d-4b92-8dc3-9394f6e50a41@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS0PR11MB7460:EE_
x-ms-office365-filtering-correlation-id: 8a780dc3-4b18-4672-2058-08debbc2b12b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|56012099006|11063799006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: pRIQtDRxnAXpXorMoI2ItTpZd/XdFb1x75hbs7pvSbaqF73EDgPzRUL0tQ79ZKXf+Epwy/Cf2+yQ5TyxoOywPHcq7aeC1bfPHq6nYQgwjLQOkwD5Y+NccQFY0J1Oc73ayMKOtEWyQHedgoJakp24wPxYjmb2ymysIV87jdYNo+vbVWlBCrgGKYE6LqboQBL9LXIWjuTEAKBL8OiWUVyebrauArae0BXZMCwfFP8lB+e0gZieu4DGa6NASlx5jXJvOfgboxdabu+S4P9uZ+WP8bzwLNm7sX1SjDrHDfkEeZ7hMBrxwyDFv8+83cnDf+KEiVziZgMFy7Cn8vH5EzqtbbUx7tCDOYY9btuPLZ9VSeMXjU6c62BYdAVO+praoMgnlmvSyutB30DrCmUH2Kt9Acw1L3FJWYe6fBY90s0lNd+nchXnbnYVdoUu6pqle0JXzID9X45VzlB/wdeAXFUJ4BN6aMzBJZ0s/V2GCTqJTDPW/nC5RUILQnkq2syePe+O3F2fylv7O6kO8vVfbeigNb/6eWQLpIFKBDELkrRfYP6dI1Hr/zFEicSnrgrTfXGyCRdXlHZMQql7g0y7o6R5WaLJeFw5ceQyRixEu4I4CDhOQzWF5I8evWdeL6irei/tro+M5Y8+QGoA5qlUoySjuYyxd6SjsUOg3utHCzoDNwNy5XFJcxjB4auKBQCXOrriZ4OWGtxgLCPPMB44tNftQPO8RKABxZbm9OU9gLeQBw3eHIWQjZOiYs5M19pcfrrP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXpta1haZnZlS3ZoK0ZPRVVXOStnTm9qbVFBdkhENU91SG43NmRxNUZWMGhV?=
 =?utf-8?B?YkFmUFcyWnljMXIxSlMzV0xXL1hvSVd5ak5JTzJXa2hoTmVSZVpHYURncHZL?=
 =?utf-8?B?SDY3RStXY1doSkVSQUhKR1RleVBsMC9MejFGSjFrMzVHTmVnM0NhY3FUdUh1?=
 =?utf-8?B?a2YyZEFnY1ZVMUNKTkpsSE9oZE9ybGJORWFvZlBZaE85Vnp1b2I4V0lPRkoy?=
 =?utf-8?B?a25OWlp2R1Q3dnUxQWo2ZnluTk92bEZIYnFiNFRjaDZoV3ZuNGJxNjZKUHlq?=
 =?utf-8?B?NGtBa0E2UlNXWFJtY2F4dXdBQnlzTklvV2RwVXNlZlVCYlhKbWM0V05iZExT?=
 =?utf-8?B?allYallrdWZzSTViYzd2ZGFib3I4UEhxcGJmRjNxUm40cXh3MGtCOTZObVFx?=
 =?utf-8?B?TjNCOVNnQmFmUUJLenBGMHpoeDJRTEFFb0hDa3QwWW1pWlVUb1EwQ0tWMlBD?=
 =?utf-8?B?WGdQbnYxdEFjMHRVZlJZVDZpNDJkeHFCSm8rUlB3eUJHWWIyV0o4MVQ4THpm?=
 =?utf-8?B?dWVQeFo0QkNGSC9BQlA0VHh2K1F1R1lDSGM5WGh6dEhZektWWENXb0JHcEl2?=
 =?utf-8?B?d2JBdTJJS0x6elhGQ0RSU3oyaFhUSkp0SVpiSWQ1N0FNdDlqblJhenJQYVA0?=
 =?utf-8?B?OTBZTytKYmI0UkxDMGgrWnBrK1NMVlp0RHpVVStSRnZFbnRrT3FycDBHWXRK?=
 =?utf-8?B?SGI1ZnI4R1JhRGVud0piV3plQmNqeWZmdktJVkhMZFBLOUxFZkpweE44dklo?=
 =?utf-8?B?YzJXS2l4d255NitjKzVEVGgvUExtZk1keEFpYmIzL1dVZ2hycG00NysvcE9Y?=
 =?utf-8?B?akowRHhXVGlWWUhRaVk1ZFJrdk5EMHJxd3BRQWNrclZmaTJidnhDcDJVcmZU?=
 =?utf-8?B?Y3pITkg5T2UyUE9aSysremlLZzcxQlBCZ3FzQjBzRmJiK04wcWpMSDgrMVMz?=
 =?utf-8?B?ODdLdlBJVWU3S0V0ZStMVmdYZUV0bDEzUFZlTTdEWHhVSVVVcnFYbHNMdyto?=
 =?utf-8?B?dlZWRzdIRHpITVMzNm1ZQkVRN0NFK3NmNXM5dVBQNkJ5clg0eGo3YmdrMUEw?=
 =?utf-8?B?NndabTZnWTE5ZGdnZHJhMGJqb3RKeFFTVWNneE9YZHFJU2lhSUNPdUNKSTNW?=
 =?utf-8?B?YkxuWFEySUlDK3ozQzlIdHJmYWd2LzlMWUYyZmV6ZkEzbGZTYlpQRW5XKzVE?=
 =?utf-8?B?MEhybElVbDR2ZlpUb1ZFVVNlTDdNa2N4SkFkMHQ0K3Ywb015SE9IQ3RnQnkv?=
 =?utf-8?B?QUVjVUNLbUJhL1RKU3NNL3lLNWdlZmNvZ2gwWUYzbGVoMk1wOWp2Vjk4c1FY?=
 =?utf-8?B?aHkzUE5WNkNqYzlXVHptSzE1NjZBVCtFeStWeTlBMC9QQnZZK2pzTTFwcnNG?=
 =?utf-8?B?cW1Pb3I3VkVleWxQZ3ZIVzlOYjhDVEN4cEhSbm5DUVBKM1hwaXpFSGNiSitR?=
 =?utf-8?B?R1FhbzdqQk10a1hZQTl2SjFaV1kySTR5aVZRYnJ6RTg0Tlo1eWRPNFdKQ3ZS?=
 =?utf-8?B?b2V0UjRVK2VSa1BiT1V6L1QxTXF0MVVTU1E5Vks1Sm1MMXNLMWg1REtWb2Fv?=
 =?utf-8?B?clBPbEMzUFAyS0VvSkZWWjNaZTBNbmpSNVBNVk1VMTIrR3IvaEh3VkVva1Jx?=
 =?utf-8?B?ZkJ6dGx1cnJ5Yk85djJZMWxoeFdmUW9vczQ4Q09kZG5qL2hQb2diYU4vTm9s?=
 =?utf-8?B?UUorYUwraVFnMmlLUHhTNmo2Q0crQitzU1d1NVhJODJIMjlqSTRLVks1OW1m?=
 =?utf-8?B?VDlHTEJuREdVR1VGNUVDRGl2V01KT0R5bTI2Qlp2RDBOa0RLaWI3TzlvaytQ?=
 =?utf-8?B?d1g1aEN6S3VOK3Y1aVptUnRUQ0Jrb3BLRWdVVzh2bDdNNnRid3pIVG43UUcw?=
 =?utf-8?B?V0Evd0ZOaFNlY3hwL3pEUkNISjdmWnFyUlc1enZnb1FwWkFWVUhqQkxIbExS?=
 =?utf-8?B?UWg2aEM4TCtSTUM4aCs4V1laanoyMitaYi9ieEs0V2YvMVhJQkE2a1kvMmM2?=
 =?utf-8?B?alNNK2l0dEZYNzczOEFCY0RFdDFOZkV6QWRuSk5wcUtSUlloZXhiY0UzNS9Y?=
 =?utf-8?B?dDFZYmk3RzBzS2lkVFpKWjF1M1p2M3hqRnBWSmRtalNxNGU4Z2ZNQjlJOEpo?=
 =?utf-8?B?bCsyZUJoeEtaa1AxSlh0ZnpUaHEyOGxybFdiMEFoUm54VzBIT0QvY25DRGRG?=
 =?utf-8?B?TkppdisxZUJmaHlMbUxDaUI2akR0Z1YwclZ3VU13VENSVHI4REVUSllvTEZm?=
 =?utf-8?B?Z1JSZUxJNldrU0ZjclhlQXUyb0RDeDdNRy9GbGsrek5ONnJ5S0IxajdNTkll?=
 =?utf-8?B?NWs5T1hycWwvbzdhS1pNc1J5amUzbWdoaFhLWnRoakRLTVk5eHhrUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VCrCQGeNBOxuVGPvfh/z5fobou117B4SGv8ubv12nT7a/m0zA276ULFrlDDX9hvaVghlJ2cgCjVIfQ01d3TBHRn2Nq7NducY0oC/xH3XUqQbDk8YCLnb2OKRq3NK/TKC/a/nfgI4ZdAJ4/CseRkciNLFEf+Rt+B7he7s/CLOA3p8532yyw5NeA6lkK1Gik7CBKieE4ktplPqmfe0vYA5a88XTtqG0PxEW35/lABd3WXXgbwbKpKYW3ds6+27CMiefoOR3qMWQgu3CtbsmL4A8uucyzQL+ZZFctbGyJp/qUotqVAe85/c4GFMhzgYLePUyQdZQsFT6OQxkw7IoDmaXw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a780dc3-4b18-4672-2058-08debbc2b12b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 07:36:40.3450 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j5kY8Yy136kcJVj74hl/hj6aND6KYtZ1oGlFv5KJ20N43sk9UcpKmfZI98r4ouIZrlDLLbX4s6kGMEvrMwEOxJ+5RXaXWJZYRtz2OkGqJQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7460
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggNC81XSBpbnRlbF9pb21tdV9hY2Nl
bDogQWNjZXB0IFBSUSByZXNwb25zZSBmb3INCj5wYXNzdGhyb3VnaCBkZXZpY2UNCj4NCj5PbiAz
LzI3LzI2IDEwOjUyLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IFByb3BhZ2F0ZSBndWVzdCdz
IFBSUSByZXNwb25zZSB0byBob3N0IGJ5IHdyaXRpbmcgdG8gZmF1bHRfZmQuDQo+PiBDcmVhdGUg
YSBuZXcgVlREUFJRRW50cnkgdG8gY2FjaGUgY29va2llIGZvciBlYWNoIGZhdWx0IGdyb3VwLA0K
Pj4gdGhpcyBjb29raWUgaXMgdXNlZCB0byBtYXJrIHRoZSBmYXVsdCBncm91cCBvbiBob3N0IHNp
ZGUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFu
QGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmggICB8
IDE0ICsrKysrKysrDQo+PiAgIGluY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oIHwgIDYgKysr
Kw0KPj4gICBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICB8ICA0ICsrKw0KPj4gICBody9p
Mzg2L2ludGVsX2lvbW11X2FjY2VsLmMgICB8IDY1DQo+KysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4+ICAgaHcvaTM4Ni90cmFjZS1ldmVudHMgICAgICAgICAgfCAgMSArDQo+
PiAgIDUgZmlsZXMgY2hhbmdlZCwgOTAgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmggYi9ody9pMzg2L2ludGVsX2lvbW11X2FjY2Vs
LmgNCj4+IGluZGV4IDEwZTZlZTU3MjIuLmI0NmM3MTI2ZjcgMTAwNjQ0DQo+PiAtLS0gYS9ody9p
Mzg2L2ludGVsX2lvbW11X2FjY2VsLmgNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNj
ZWwuaA0KPj4gQEAgLTE5LDYgKzE5LDkgQEAgdHlwZWRlZiBzdHJ1Y3QgVlREQWNjZWxQQVNJRENh
Y2hlRW50cnkgew0KPj4gICAgICAgdWludDMyX3QgZnNfaHdwdF9pZDsNCj4+ICAgICAgIHVpbnQz
Ml90IGZhdWx0X2lkOw0KPj4gICAgICAgaW50IGZhdWx0X2ZkOw0KPj4gKyAgICBRTElTVF9IRUFE
KCwgVlREUFJRRW50cnkpIHZ0ZF9wcnFfbGlzdDsNCj4+ICsgICAgSU9NTVVQUklOb3RpZmllciBw
cmlfbm90aWZpZXJfZW50cnk7DQo+PiArICAgIElPTU1VUFJJTm90aWZpZXIgKnByaV9ub3RpZmll
cjsNCj4+ICAgICAgIFFMSVNUX0VOVFJZKFZUREFjY2VsUEFTSURDYWNoZUVudHJ5KSBuZXh0Ow0K
Pj4gICB9IFZUREFjY2VsUEFTSURDYWNoZUVudHJ5Ow0KPj4NCj4+IEBAIC0zMSw2ICszNCw5IEBA
IHZvaWQgdnRkX2ZsdXNoX2hvc3RfcGlvdGxiX2FsbF9hY2NlbChJbnRlbElPTU1VU3RhdGUgKnMs
DQo+dWludDE2X3QgZG9tYWluX2lkLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdWludDY0X3QgbnBhZ2VzLCBib29sIGloKTsNCj4+ICAgdm9pZCB2dGRfcGFzaWRf
Y2FjaGVfc3luY19hY2NlbChJbnRlbElPTU1VU3RhdGUgKnMsIFZURFBBU0lEQ2FjaGVJbmZvDQo+
KnBjX2luZm8pOw0KPj4gICB2b2lkIHZ0ZF9wYXNpZF9jYWNoZV9yZXNldF9hY2NlbChJbnRlbElP
TU1VU3RhdGUgKnMpOw0KPj4gK2Jvb2wgdnRkX3Byb3BhZ2F0ZV9wYWdlX2dyb3VwX3Jlc3BvbnNl
X2FjY2VsKEludGVsSU9NTVVTdGF0ZSAqcywNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB1aW50MTZfdCByaWQsIHVpbnQzMl90IHBhc2lkLA0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIElPTU1VUFJJUmVzcG9u
c2UgKnJlc3BvbnNlKTsNCj4+ICAgdm9pZCB2dGRfaW9tbXVfb3BzX3VwZGF0ZV9hY2NlbChQQ0lJ
T01NVU9wcyAqb3BzKTsNCj4+ICAgI2Vsc2UNCj4+ICAgc3RhdGljIGlubGluZSBib29sIHZ0ZF9j
aGVja19oaW9kX2FjY2VsKEludGVsSU9NTVVTdGF0ZSAqcywNCj4+IEBAIC02OSw2ICs3NSwxNCBA
QCBzdGF0aWMgaW5saW5lIHZvaWQNCj52dGRfcGFzaWRfY2FjaGVfcmVzZXRfYWNjZWwoSW50ZWxJ
T01NVVN0YXRlICpzKQ0KPj4gICB7DQo+PiAgIH0NCj4+DQo+PiArc3RhdGljIGlubGluZQ0KPj4g
K2Jvb2wgdnRkX3Byb3BhZ2F0ZV9wYWdlX2dyb3VwX3Jlc3BvbnNlX2FjY2VsKEludGVsSU9NTVVT
dGF0ZSAqcywNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB1aW50MTZfdCByaWQsIHVpbnQzMl90IHBhc2lkLA0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIElPTU1VUFJJUmVzcG9uc2UgKnJlc3BvbnNlKQ0KPj4g
K3sNCj4+ICsgICAgcmV0dXJuIGZhbHNlOw0KPj4gK30NCj4+ICsNCj4+ICAgc3RhdGljIGlubGlu
ZSB2b2lkIHZ0ZF9pb21tdV9vcHNfdXBkYXRlX2FjY2VsKFBDSUlPTU1VT3BzICpvcHMpDQo+PiAg
IHsNCj4+ICAgfQ0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5o
IGIvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+IGluZGV4IDE4NDJiYTU4NDAuLjVk
NDRlYWMwZWQgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0K
Pj4gKysrIGIvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+IEBAIC0xMDAsNiArMTAw
LDEyIEBAIHR5cGVkZWYgc3RydWN0IFZURFBBU0lEQ2FjaGVFbnRyeSB7DQo+PiAgICAgICBib29s
IHZhbGlkOw0KPj4gICB9IFZURFBBU0lEQ2FjaGVFbnRyeTsNCj4+DQo+PiArdHlwZWRlZiBzdHJ1
Y3QgVlREUFJRRW50cnkgew0KPj4gKyAgICB1aW50MzJfdCBncnBpZDsNCj4+ICsgICAgdWludDMy
X3QgY29va2llOw0KPj4gKyAgICBRTElTVF9FTlRSWShWVERQUlFFbnRyeSkgbmV4dDsNCj4+ICt9
IFZURFBSUUVudHJ5Ow0KPj4gKw0KPj4gICBzdHJ1Y3QgVlREQWRkcmVzc1NwYWNlIHsNCj4+ICAg
ICAgIFBDSUJ1cyAqYnVzOw0KPj4gICAgICAgdWludDhfdCBkZXZmbjsNCj4+IGRpZmYgLS1naXQg
YS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IGluZGV4
IDk2YjQxMDJhYjkuLmQ2NzBhMDM3N2IgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lv
bW11LmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTMzOTAsNiArMzM5
MCwxMCBAQCBzdGF0aWMgYm9vbA0KPnZ0ZF9wcm9jZXNzX3BhZ2VfZ3JvdXBfcmVzcG9uc2VfZGVz
YyhJbnRlbElPTU1VU3RhdGUgKnMsDQo+PiAgICAgICAgICAgcmVzcG9uc2UucmVzcG9uc2VfY29k
ZSA9IElPTU1VX1BSSV9SRVNQX0ZBSUxVUkU7DQo+PiAgICAgICB9DQo+Pg0KPj4gKyAgICBpZiAo
dnRkX3Byb3BhZ2F0ZV9wYWdlX2dyb3VwX3Jlc3BvbnNlX2FjY2VsKHMsIHJpZCwgcGFzaWQsICZy
ZXNwb25zZSkpIHsNCj4+ICsgICAgICAgIHJldHVybiB0cnVlOw0KPj4gKyAgICB9DQo+PiArDQo+
PiAgICAgICBpZiAodnRkX2Rldl9hcy0+cHJpX25vdGlmaWVyKSB7DQo+PiAgICAgICAgICAgdnRk
X2Rldl9hcy0+cHJpX25vdGlmaWVyLT5ub3RpZnkodnRkX2Rldl9hcy0+cHJpX25vdGlmaWVyLCAm
cmVzcG9uc2UpOw0KPj4gICAgICAgfQ0KPj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9t
bXVfYWNjZWwuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYw0KPj4gaW5kZXggMGZjZTYy
ZmY3NS4uNDRhZjUzNGM1NSAxMDA2NDQNCj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNj
ZWwuYw0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jDQo+PiBAQCAtMTAyLDYg
KzEwMiwzMCBAQCBWVERIb3N0SU9NTVVEZXZpY2UNCj4qdnRkX2ZpbmRfaGlvZF9pb21tdWZkKFZU
REFkZHJlc3NTcGFjZSAqYXMpDQo+PiAgICAgICByZXR1cm4gTlVMTDsNCj4+ICAgfQ0KPj4NCj4+
ICtib29sIHZ0ZF9wcm9wYWdhdGVfcGFnZV9ncm91cF9yZXNwb25zZV9hY2NlbChJbnRlbElPTU1V
U3RhdGUgKnMsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdWludDE2X3QgcmlkLCB1aW50MzJfdCBwYXNpZCwNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVVBSSVJlc3BvbnNlICpyZXNwb25zZSkNCj4N
Cj5zL3Z0ZF9wcm9wYWdhdGVfcGFnZV9ncm91cF9yZXNwb25zZV9hY2NlbC92dGRfYWNjZWxfcHJv
cGFnYXRlX3BhZ2VfZ3JvdXBfDQo+cmVzcG9uc2UvDQoNCldpbGwgZG8uDQoNCj4NCj4+ICt7DQo+
PiArICAgIFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzID0gdnRkX2dldF9hc19ieV9zaWQocywgcmlk
KTsNCj4+ICsgICAgVlREQWNjZWxQQVNJRENhY2hlRW50cnkgKnZ0ZF9wY2U7DQo+PiArICAgIFZU
REhvc3RJT01NVURldmljZSAqdnRkX2hpb2QgPSB2dGRfZmluZF9oaW9kX2lvbW11ZmQodnRkX2Fz
KTsNCj4+ICsNCj4+ICsgICAgaWYgKCF2dGRfaGlvZCkgew0KPj4gKyAgICAgICAgcmV0dXJuIGZh
bHNlOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIFFMSVNUX0ZPUkVBQ0godnRkX3BjZSwgJnZ0
ZF9oaW9kLT5wYXNpZF9jYWNoZV9saXN0LCBuZXh0KSB7DQo+PiArICAgICAgICBpZiAodnRkX3Bj
ZS0+cGFzaWQgPT0gcGFzaWQpIHsNCj4+ICsgICAgICAgICAgICBpZiAodnRkX3BjZS0+cHJpX25v
dGlmaWVyKSB7DQo+PiArICAgICAgICAgICAgICAgIHZ0ZF9wY2UtPnByaV9ub3RpZmllci0+bm90
aWZ5KHZ0ZF9wY2UtPnByaV9ub3RpZmllciwgcmVzcG9uc2UpOw0KPg0KPmlzIHRoZSBub3RpZnkg
bWVjaGFuaXNtIHJlYWxseSBuZWVkZWQ/IFlvdSBhbHJlYWR5IGhhdmUgdnRkX3BjZSBoZXJlDQo+
d2hpY2ggaXMgdGhlIG1haW4gaW5wdXQgdGhhdCBuZWVkZWQgYnkgdnRkX3BycV9yZXNwb25zZV9u
b3RpZnkoKS4NCj5Zb3UgbWlnaHQgY2FsbCB2dGRfcHJxX3Jlc3BvbnNlX25vdGlmeSgpIGRpcmVj
dGx5IGhlcmUgc2luY2UgaXQncw0KPmludGVybmFsIGhlbHBlcj8NCg0KR29vZCBzdWdnZXN0aW9u
ISBXaWxsIGRvLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

