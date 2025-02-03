Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F451C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 18:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf0zM-0004oI-8e; Mon, 03 Feb 2025 13:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1tf0zI-0004o8-IO
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:16:00 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1tf0zG-0001eR-AX
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:16:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738606559; x=1770142559;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FJNMnt0jmZkmwgZf0iNSPrCrXytUA5yRK9BEbgEZKBI=;
 b=DjTnynglIfntcXFdZQ38Folhbj1DuzS+XZUWLL2lNNO7bF5zYdwdTpwV
 TzA7fM8VX23nfieesm8Liz3VzM+/7FWqVBD6Rc/y+GAWeSff8nwoQYfbf
 tWVEkwy32sMBKu/bjdXo30ScYgeFytWnsT/e8LSXjXO+r5LsQ2HWMiJXK
 Cyijk0x/kBT9OaHZwbu9rX3Beny9tqpNbqepKq5MJDLpRIjdVFlGJu3pR
 rtFu+BC8QJQ/J4Tibd43lrEH/LrKoX7SLw599CdQ6K/a22rFz6KclG0pN
 sBuoQe/AF5l5YQf58A3OMTow+5DLXBWDUCs63KMvmTg6tqYeWHewmA2v8 Q==;
X-CSE-ConnectionGUID: sSg9katuRtioIseu9JRDQQ==
X-CSE-MsgGUID: V5Qfx7gtQWazMJiB0oeCWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="38819238"
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; d="scan'208";a="38819238"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2025 10:15:50 -0800
X-CSE-ConnectionGUID: NC3BtS58T4q9qx9q09OC0A==
X-CSE-MsgGUID: Ui6bRYHmSmK+45syEQ6tWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="114396003"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Feb 2025 10:15:48 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 3 Feb 2025 10:15:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 3 Feb 2025 10:15:41 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Feb 2025 10:15:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BItjTuRfdnrosreYnfVFXI4WGKabOewaiDVS4sW/HRGZZVOqH5WfKikKpubFuqUOO7LlBlsvqIridmK9OIGCfgzEHafyZxRLR08eP1TNv63XCHML3M1vkJ3fJhnD6t6ecVX6gd5BkfhLCF4GTjPxgsIxTPJtxrhK7fZsc/L1JVBd3ubLFg5h3Ay/DaIlEMURNTBQ0oHwcU9+a4mwefQNjLJsYA6vVtbFy7XKCvTdBogFQ0MU1M+iIrXungpqWZl2jtZ9mVoJ383FAw+hDEQki5f41DtfpCFy+SKcEAr3BJfjUOdgdlDgJrafPWFBsgyZ093y6E5bPyZTonumaQvUig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJNMnt0jmZkmwgZf0iNSPrCrXytUA5yRK9BEbgEZKBI=;
 b=lr4KoTI7uLKtlwigLRrk58sgLUZSTGgl89csLcE0WXc1TZ+Js6GyvW6fT1CMyRzHGyTcBNkTHMITihiHN7CYDD+rua2SOfpcvvSnvGvrsD+fwNsAUxzVuJB6xpwMnnSG1CPKyPIMaFWR4AJTd0tlVVaccIX0pfvOL/SpsUZ5AYl/GtgT+iiW3z0tttent3Zxdi12WAeoi+kJbKfxsXSNnnqatD+ufVmeWNVmCD91OLmoyqtnAN+g4PGKt5Tl6UHjbIEaJYeOJnn+dMzKxQuekZgL58/VfeExgr63c79/RZiDK5RxWhIGazZzU5CKFE+vzZIWs/VzXVn/KMM9E7Cmkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by MN0PR11MB6157.namprd11.prod.outlook.com (2603:10b6:208:3cb::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Mon, 3 Feb
 2025 18:15:08 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%6]) with mapi id 15.20.8398.017; Mon, 3 Feb 2025
 18:15:06 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>
CC: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>, Akihiko Odaki
 <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "Gerd
 Hoffmann" <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Gert Wollny <gert.wollny@collabora.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Gurchetan Singh
 <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?utf-8?B?UGF1IE1vbm7DqSwgUm9nZXI=?= <roger.pau@citrix.com>, Alex Deucher
 <alexander.deucher@amd.com>, Stefano Stabellini <stefano.stabellini@amd.com>, 
 =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Xenia
 Ragiadakou" <xenia.ragiadakou@amd.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>, Honglei Huang <honglei1.huang@amd.com>, 
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>, "Rob
 Clark" <robdclark@gmail.com>, Yiwei Zhang <zzyiwei@chromium.org>, "Sergio
 Lopez Pascual" <slp@redhat.com>
Subject: RE: [PATCH v6 00/10] Support virtio-gpu DRM native context
Thread-Topic: [PATCH v6 00/10] Support virtio-gpu DRM native context
Thread-Index: AQHbcDXbhlx9arVsgEanRzZCBe4QsbMqzcWCgAldBYCAASsJ5IAAl1hg
Date: Mon, 3 Feb 2025 18:15:06 +0000
Message-ID: <PH8PR11MB6879D81CAA931B0718DF3B1EFAF52@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20250126201121.470990-1-dmitry.osipenko@collabora.com>
 <87cyg844fr.fsf@draig.linaro.org>
 <5aedf1ad-d9b0-4edb-a050-f3d9bee9bccb@collabora.com>
 <87ikprflbb.fsf@draig.linaro.org>
In-Reply-To: <87ikprflbb.fsf@draig.linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|MN0PR11MB6157:EE_
x-ms-office365-filtering-correlation-id: 205212c9-a5c3-4bea-ac6f-08dd447eb027
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?dU14SzFSRG04aVFsVzNGU0tRNURBT3hIWmNseEhGRk1EK08xY1BobEk3aFI1?=
 =?utf-8?B?SXRYVUNiWElkWWhLelBtMS9mUE91TGZqeU5UYlN6a1k1QnJFQzlFUlpSLy9X?=
 =?utf-8?B?cHo5TUNPcnIwcmVmZ0Y0NkdyRlFlT0VSVnFDcDdaeFNoVkJzN1IxTHBwNXVG?=
 =?utf-8?B?dk1UTVdwcDk5NmJvVFI2WFpwU2lDc2tRQ1RteU5kTDU1MVFtR2ZTRzFkcUha?=
 =?utf-8?B?dWRJZnZvZlVEUGN6ZDRxYkZFcVJPeWViQUFZNmphSmNsY0hUNEJuRERNM3Va?=
 =?utf-8?B?TDBBSTExMHNqR2VoUmRLUmxobWt1WFNZcFpZa3U5UnJLNDcrSnFpYjI0K21l?=
 =?utf-8?B?dEQwOTZ6ODJFZm9hcnBhM3J2WmZpQkdzTGhzWEM5bHo0N0FYdGJrdFlUUFAv?=
 =?utf-8?B?N0lqUVZMa0xHdmlrK3MvV0d5TVliVmtQc2J2Qi9ZaDZFUTFnd1pmMUtYcENP?=
 =?utf-8?B?eDQwL3dtcFFWaU51NWUvZ3dwTzJ6Z25QbWgzblRFQ25EWEZLZDlldURrUG5q?=
 =?utf-8?B?UzlZQTlMa2M3TU5pbFRJalpySGU4U1U5aHNIbGRPMy9CSmg4MFR0TDYyS3g4?=
 =?utf-8?B?SjVYKy8rTjJkM0l0R0lFRFQvUjRzRWRVeEo0VGxWeGpkSHRMZng3L0RoazF3?=
 =?utf-8?B?L3hNVXMyd3c5TUdneUFBSkhOZGg5N3ZDWnlsR2Zzem5UTEU0K0tLS3RaVEt3?=
 =?utf-8?B?NmxRUjhnZFJpTzZjNUxWcXNvQlVVRGkvWUFkcThZbFNTOXp1Z0hxVUhRZzVk?=
 =?utf-8?B?S1BnWFVsdzdRZHJ1VG5IQXhCMFNhOFMzOTJUNm5XNFVkL0E0MlNEM2dJZzNn?=
 =?utf-8?B?TG1GcFNtdGk0RG5TdjZ4Z29PbE9zUE9NdkIxMXBDR0lQSkkvYnBrbEp4Y2ZY?=
 =?utf-8?B?UjA3S1Jlb05zL09oQkx3ai9FaWtiY1JHOS9KYmlrVmNjdjdYM3lvRHZUZDVX?=
 =?utf-8?B?cC9KR3lnL2xlWFJENktJZWhJOG9qT0liS1RmeC9UVkxxaytuUFluQnoxRTV5?=
 =?utf-8?B?ZnRLekloZlRrTEJXVEdjYUhNVlVBa20xTWRKTzB1NmpobWtYNTBLMkJYRHAz?=
 =?utf-8?B?bTM0aW1RR3BreVJLQUpPWGJ6RzB4YWswcm9tSVRKRGZRaFcva1pmU1lKa0Nn?=
 =?utf-8?B?VUZLNmRRY21JOE9sK29MSXdrQUhYdlBDTjVkSm9kQXc3TG4zTzNHMk1JYnUw?=
 =?utf-8?B?THBQUlVsdjhPSjc4V2NWanRvTmlpY294K0dTSVRRVlAyNW0zZGI5V1hXcFB4?=
 =?utf-8?B?RmxOS3hLZFhZNURzMElhbXZEWXA3d3ZvVTNXNnkweG9ncEpJSVcwalAzaWNK?=
 =?utf-8?B?a3VZb1BQQk5ZSG01UTdHZ0hKeGx6eER6cUEvMmI0d3VKb2RBUXVxVThzZEUr?=
 =?utf-8?B?bjRkeEFEaWVjbVZheXBPYmVheGd1dmdIUmhkNWNDbTI1QTRPY1R4SHRIVHF1?=
 =?utf-8?B?UTVPYU5qajIxKzlTR21HMkFBdHZGQWR4SEZBUkZlYUtObmRpV3hzYksrckNQ?=
 =?utf-8?B?L1d6SEwyZEZTV3poMzNsU08zdHo0UndNRWtlVmRGK241TGd5cXp3N3JIUHlZ?=
 =?utf-8?B?VkhPWW1iOUs1dFJaZjl0VlhveS83NzluRmZtQm1UdE8vT05DVnFrdUlwWmU2?=
 =?utf-8?B?YWFBQTV2SlB0clQyOVJYdlR4aXlvRUgzSmgwOVVLdng4Z0psc1FNWEx1RGFs?=
 =?utf-8?B?YXV6MWliYjBOTXcwZ1djTmNGd0I3ejJ1UDE5Z0hDbDVodUthTXVxK0g2cU5K?=
 =?utf-8?B?ejFJNTRwd2p6clgxcVVoVzN5OG4xaVZzbktVK0E1b3NudkF4Y0FVTS82M0pw?=
 =?utf-8?B?YWJCbys0cWt2VjNKaVROdm1hdk0wZjN3M015cjhqNzVGK2dMdEl6bTczVkxK?=
 =?utf-8?B?eXBac2VyUXNFNU1oQ2pjRzlDbE9qWjhGMFNIT0dhajI0R1l5K0k2SUxuTDdy?=
 =?utf-8?Q?X+boYsHt3mI9tooy4fPy7mJ86ksqUA+N?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXRjS1BHUDdOWVBKNENXcHFDd2VPZU9XVmYvWXRUcnFjRllSc1NlVDVBTklZ?=
 =?utf-8?B?enFTMVQvb0xpaGtmeTFndXRjNWtsd2FYZHlZcDU2dUdubWlJQnlpRXJVWnhL?=
 =?utf-8?B?VVFiVWpUUERsUENHVWhLRk5NQXNLNTBaMEpsVnVoWUllT3k4dzd5MTN6OG5a?=
 =?utf-8?B?U3M5Rk1zbmxJSjhMeStEYVhHaWR1V0E3dFExUXRQNEJHK2l4eDBhVU1lK05r?=
 =?utf-8?B?NmwyNU5Ydm9tRnhoQ3F3TzhzNEdFWkhTS2wxY2VCMEhnYVo1VlRkdWIrclNv?=
 =?utf-8?B?ZUNkSmhMM1JZTkpIMEVTcFQ3SEVSbjFZVWx1TklIQlZKUGwzdFBHRGZnNWNl?=
 =?utf-8?B?VXFFMEdWRHN0MGpBeGdlM3ZIWGEwU2g0aEd3TG51bXc5U3F5RzloRVJOQlZ0?=
 =?utf-8?B?ZkpYd0hwcnFwRHpGZkxRV1Y0Y3AxM3g3KzQ1R25KREJSeXNhbWNiZldSYjM5?=
 =?utf-8?B?aGUrRGFmYVdUbnJPTHF5Njg2L3pYWEl1MUNwRmhxaUk4Tmd5SDR5VUtZMm1G?=
 =?utf-8?B?aENlY0FTYVhTOE1EMGN6Rnk5NTlzTnZTQzJzdENrcXJCeXc3Tlo5Nkt6dnV6?=
 =?utf-8?B?bXJWbWtWVkJEajNHOFJ4clpocnBLQTF2MlExbmYvYXY0SnUvUjlCcGJLZnJi?=
 =?utf-8?B?MnpLT2pTaEE2cjBIaTByM2pjTXJkVnpmbkIrYVIxdHlkdGdhL3hYcVZTcWlR?=
 =?utf-8?B?SHd4bTZFRTllYXRqYmoza3Y3SjJOcHhiTlY0YW5HQmIxbm43VzgxNGJJVXJW?=
 =?utf-8?B?aEpaVHkvNWN2MXFSVnVaa3U0OEVpVzdyay9lRnQ4Zkg0bmVwbWVkUnpHOUZQ?=
 =?utf-8?B?TUxZa2JENkhqRWhlK0lFUS9mYUJIbktkQ0tpTVV0L3FSaEN3Rks0YldDZThu?=
 =?utf-8?B?bksyOHNsUkZ0a05KaWt5NFRHd1MrMWFaMVNiR2NGUnVzVHNPM0graGdTb0Nx?=
 =?utf-8?B?dXNhelp4THVMbHJZaWJtYlhoZ2w5dXIxTUhHOXEvZWNwcSthSWVUdzB3Tkt5?=
 =?utf-8?B?UnlmUXJkY3FBN1V0OS9kSjFvSGJsS2YzT0FTOEVTcFF3OEx3bTZvaFZGYlF5?=
 =?utf-8?B?QjV3aks0Ny9xTWVEanI1S29HNWFySCt1U29CTWR5SFBONVdtT0RnTkhZSXE1?=
 =?utf-8?B?YTdtc2NTS0RPWUFydDVvVmJyeXZTejA5TTEweC9mRmg0VE85Y210T2diSUFC?=
 =?utf-8?B?Qm4xbDlLU2tYbHp3c3lhR3Fmc1JESEFJdUhiSXFhZ1h1TlZYNG9ma3lmVWJN?=
 =?utf-8?B?NFV4cU5rblJVSXk5K0hkMHhKOEtodTRXZkhVMTY3emFDWTRvRWNrc0U4cTJz?=
 =?utf-8?B?NHpRSy9nRmZITTRDQm1EM3QyeVpNbWcreWp1Z2YwVTg2VmJoSUxTR1ova2pZ?=
 =?utf-8?B?Vms3T0hKbmpWVDFMS2VyQW03eHVKa056bCtSMXlpSTFkclFjcmg4ZnU4bHY2?=
 =?utf-8?B?MDNranBXYk5idW1IcFN6UUpYbkdvRjZJWXpYcThPZ05rV2tHUHgwTGNVZ0lj?=
 =?utf-8?B?azRPdTNNUEw1emVvYmNaVCszbmhFNCtRVzh1QkhDamhPaDh4Y0NBQ2wvN2xL?=
 =?utf-8?B?Y0lGc0lGZWxvOERYbS9qcVBQWW1MajRRRHRUOGl3WmpMMGRVb2tiUzJKNENh?=
 =?utf-8?B?ZDZ0TllNMzFXRXhuM3FLMnd5UWJXOGJNTFdGNkIwVkdwUkFNZVdqQ25WVm9Y?=
 =?utf-8?B?dUgxUXppNGhVVUVUT3BjS1pDQ1NCcFVxL3QyS2ZQMFVYVXQ2TlJVYXljMW5j?=
 =?utf-8?B?R09zeTE4MENXY0lWOVZaSC9WYTBuVjVhSEw3OWZsYnYrb285RW5xYS9QM0NR?=
 =?utf-8?B?Ly96ZFkxa0Z0SElrK2UvTTVZSWZ0dFFXd01IdkFZMVgyVmVUUklDSHhiellp?=
 =?utf-8?B?Ym02VVNJUWc5U0FxQ2UvLzlqSndIOHRHWXh0NXdjTXpTcTRGbzgxc25YbDRR?=
 =?utf-8?B?c2x1OWxRRlJySk9HMExxcDVuMzFBc0RrcFZmdFBwcUZNdWc4Z0ZVcFZ5blBX?=
 =?utf-8?B?MHNBTUFOOE1lU1hYRWQzWnBTY3VSVThaaEJjTW5Ha1NNQ0NWYXlkNDlCTGJG?=
 =?utf-8?B?STJwYU1WWkZMZ25mN09UcXRiQWRoaW1kNlFrd2NyY2l5RDlKQzRrVjBHR2Jx?=
 =?utf-8?Q?Td3Br15xRC3cfjLc4Jeom+JSY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 205212c9-a5c3-4bea-ac6f-08dd447eb027
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 18:15:06.8090 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SP89seSqrqdgAEJkRAJinYBfxmQAW5Ypub7XmkCeBSJU7nZpOvbdkQ8hP7NMaicQKLHXbFviaE1hnBWKaAQycg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6157
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

SGksDQoNClRoZSBjb21taXQgYmVsb3cgY291bGQgY2hhbmdlIHRoZSB0aW1pbmcgb2YgZHJhd2lu
ZyBieSBtYWtpbmcgdGhlIGRyYXdpbmcNCmRvbmUgYXQgcmVmcmVzaCBjeWNsZSBpbnN0ZWFkIG9m
IHZpYSBkcmF3aW5nIGV2ZW50LiBTbyBpdCBsb29rcyBsaWtlIGVpdGhlciBkbWFidWYNCm9yIGNs
aWVudCdzIGZyYW1lYnVmZmVyIGlzIGJlaW5nIHdyaXR0ZW4gYW5kIHJlYWQgYXQgdGhlIHNhbWUg
dGltZS4gSGV5LCBjYW4geW91DQpkZXNjcmliZSBob3cgdGhlIGNvcnJ1cHRpb24gbG9va3MgbGlr
ZT8gSXMgaXQganVzdCBnYXJiYWdlIGltYWdlIHdpdGggcmFuZG9tIG5vaXNlDQpvciB0aGUgYWN0
dWFsIGZyYW1lIHdpdGggc29tZSBkZWZlY3RzIGxpa2UgdGVhcmluZy4uLj8gIA0KDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjYgMDAvMTBdIFN1cHBvcnQgdmlydGlvLWdwdSBEUk0gbmF0aXZlIGNv
bnRleHQNCj4gDQo+IERtaXRyeSBPc2lwZW5rbyA8ZG1pdHJ5Lm9zaXBlbmtvQGNvbGxhYm9yYS5j
b20+IHdyaXRlczoNCj4gDQo+ID4gT24gMS8yNy8yNSAxOToxNywgQWxleCBCZW5uw6llIHdyb3Rl
Og0KPiA+IC4uLg0KPiA+PiBJJ20gc3RpbGwgc2VlaW5nIGNvcnJ1cHRpb24gd2l0aCAtZGlzcGxh
eSBndGssZ2w9b24gb24gbXkgeDg2IHN5c3RlbQ0KPiA+PiBCVFcuIEkgd291bGQgbGlrZSB0byB1
bmRlcnN0YW5kIGlmIHRoYXQgaXMgYSBwcm9ibGVtIHdpdGggUUVNVSwgR1RLDQo+ID4+IG9yIHNv
bWV0aGluZyBlbHNlIGluIHRoZSBzdGFjayBiZWZvcmUgd2UgbWVyZ2UuDQo+ID4NCj4gPiBJIHJl
cHJvZHVjZWQgdGhlIGRpc3BsYXkgbWlycm9yaW5nL2NvcnJ1cHRpb24gaXNzdWUgYW5kIGJpc2Vj
dGVkIGl0IHRvDQo+ID4gdGhlIGZvbGxvd2luZyBjb21taXQuIFRoZSBwcm9ibGVtIG9ubHkgaGFw
cGVucyB3aGVuIFFFTVUvR1RLIHVzZXMNCj4gPiBXYXlsYW5kIGRpc3BsYXkgZGlyZWN0bHksIHdo
aWxlIHByZXZpb3VzbHkgSSB3YXMgcnVubmluZyBRRU1VIHdpdGgNCj4gPiBYV2F5bGFuZCB0aGF0
IGRvZXNuJ3QgaGF2ZSB0aGUgcHJvYmxlbS4gV2h5IHRoaXMgY2hhbmdlIGJyZWFrcyBkbWFidWYN
Cj4gPiBkaXNwbGF5aW5nIHdpdGggV2F5bGFuZC9HVEsgaXMgdW5jbGVhci4NCj4gDQo+IEFoaCB0
aGF0IG1ha2VzIHNlbnNlIC0gSSBvYnZpb3VzbHkgZm9yZ290IHRvIG1lbnRpb24gSSdtIHJ1bm5p
bmcgc3dheS93YXlsYW5kDQo+IGFjcm9zcyBib3RoIG1hY2hpbmVzLg0KPiANCj4gPiBSZXZlcnRp
bmcgY29tbWl0IGZpeGVzIHRoZSBidWcuDQo+ID4NCj4gPiArRG9uZ3dvbiBLaW0gK1ZpdmVrIEth
c2lyZWRkeQ0KPiA+DQo+ID4gY29tbWl0IDc3YmYzMTAwODRkYWQzOGIzYTJiYWRmMDE3NjZjNjU5
MDU2ZjFjZjINCj4gPiBBdXRob3I6IERvbmd3b24gS2ltIDxkb25nd29uLmtpbUBpbnRlbC5jb20+
DQo+ID4gRGF0ZTogICBGcmkgQXByIDI2IDE1OjUwOjU5IDIwMjQgLTA3MDANCj4gPg0KPiA+ICAg
ICB1aS9ndGs6IERyYXcgZ3Vlc3QgZnJhbWUgYXQgcmVmcmVzaCBjeWNsZQ0KPiA+DQo+ID4gICAg
IERyYXcgcm91dGluZSBuZWVkcyB0byBiZSBtYW51YWxseSBpbnZva2VkIGluIHRoZSBuZXh0IHJl
ZnJlc2gNCj4gPiAgICAgaWYgdGhlcmUgaXMgYSBzY2Fub3V0IGJsb2IgZnJvbSB0aGUgZ3Vlc3Qu
IFRoaXMgaXMgdG8gcHJldmVudA0KPiA+ICAgICBhIHNpdHVhdGlvbiB3aGVyZSB0aGVyZSBpcyBh
IHNjaGVkdWxlZCBkcmF3IGV2ZW50IGJ1dCBpdCB3b24ndA0KPiA+ICAgICBoYXBwZW4gYmFjYXVz
ZSB0aGUgd2luZG93IGlzIGN1cnJlbnRseSBpbiBpbmFjdGl2ZSBzdGF0ZQ0KPiA+ICAgICAobWlu
aW1pemVkIG9yIHRhYmlmaWVkKS4gSWYgZHJhdyBpcyBub3QgZG9uZSBmb3IgYSBsb25nIHRpbWUs
DQo+ID4gICAgIGdsX2Jsb2NrIHRpbWVvdXQgYW5kL29yIGZlbmNlIHRpbWVvdXQgKG9uIHRoZSBn
dWVzdCkgd2lsbCBoYXBwZW4NCj4gPiAgICAgZXZlbnR1YWxseS4NCj4gPg0KPiA+ICAgICB2Mjog
VXNlIGdkX2dsX2FyZWFfZHJhdyh2YykgaW4gZ3RrLWdsLWFyZWEuYw0KPiA+DQo+ID4gICAgIFN1
Z2dlc3RlZC1ieTogVml2ZWsgS2FzaXJlZGR5IDx2aXZlay5rYXNpcmVkZHlAaW50ZWwuY29tPg0K
PiA+ICAgICBDYzogR2VyZCBIb2ZmbWFubiA8a3JheGVsQHJlZGhhdC5jb20+DQo+ID4gICAgIENj
OiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4NCj4gPiAg
ICAgQ2M6IERhbmllbCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+DQo+ID4gICAg
IFNpZ25lZC1vZmYtYnk6IERvbmd3b24gS2ltIDxkb25nd29uLmtpbUBpbnRlbC5jb20+DQo+ID4g
ICAgIEFja2VkLWJ5OiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0
LmNvbT4NCj4gPiAgICAgTWVzc2FnZS1JZDogPDIwMjQwNDI2MjI1MDU5LjM4NzEyODMtMS1kb25n
d29uLmtpbUBpbnRlbC5jb20+DQo+IA0KPiANCj4gTWF5YmUgYSByYWNlIG9uOg0KPiANCj4gICAg
IFFlbXVEbWFCdWYgKmRtYWJ1ZiA9IHZjLT5nZnguZ3Vlc3RfZmIuZG1hYnVmOyA/DQo+IA0KPiAt
LQ0KPiBBbGV4IEJlbm7DqWUNCj4gVmlydHVhbGlzYXRpb24gVGVjaCBMZWFkIEAgTGluYXJvDQo=

