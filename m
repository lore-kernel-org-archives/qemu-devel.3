Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C77C02198
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 18:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfkWv-0004Q2-27; Wed, 05 Feb 2025 13:53:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1tfkWi-0004Lv-U7
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 13:53:33 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1tfkWc-00055w-TN
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 13:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738781607; x=1770317607;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SFEBDeu7STsb5WdTe/3BtqXAieuYTh67IorA4RBH39U=;
 b=FSZYjgfU7uxSqlR6J88osoczWxOIV9e929R4YNFKSalkTfn65Qlky+3b
 FdvsW4nFg+AU23cSBelemww8XNJmRinP/bnW0u/LfMYPL2B1YN0WvYtK1
 r9vrDPklZ1Vmu+o+rRUtlozvED9RC2HcZdyiOH2WJ6cTDe4LS2GTdrQQp
 a8Rod4+xmCdjZ0XW+8XKYOju3sfoug08UlfRE9I92lfV8TXJZCh+LBqJo
 MHf2SmpHuRohTT/lqNEPhoYO2cHtF6pZJD0pAZGukOm95DOFTaxrY08Ex
 WHS6LrpLwmM/t5p5AxCOKjNloVElJMErLOrKjeg4gPBEszI5JiB1LSAer g==;
X-CSE-ConnectionGUID: C8WxZQWvToiBBOLOFRCxKw==
X-CSE-MsgGUID: FBYnr2UHTcSi9lLxH/pqNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39634758"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; d="scan'208";a="39634758"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 10:53:20 -0800
X-CSE-ConnectionGUID: ehJ2C67pQc6V6Y2EmVyAjA==
X-CSE-MsgGUID: iwuS5yX9SLeIDfAczyVpfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="141885141"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Feb 2025 10:53:19 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 10:53:18 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 10:53:18 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 10:53:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDYn+N5P/R/0q3HoYxyQxpepKwVdlHe448a7cufYAmUmNTUeLP9AzCO5VfwgbtvTwYMUg3t3T44+kAFSEnonntosyGfM0Awl/NPOubkPWav4kaPz07o1Hq2CYK7fDZsL6CK2F50q74bMJSnyVN5v1/h4yEnumdYvBGxeO2gkUPqX5YhK1rbRLQxccgOBaF6K4vBfFw3zG0zi+yfyh8MaHKl9cZrSl6hc9MqERtL00Z77XhxzOOehPf0PxtbzLkvwA9xlj1KQrDZWvIQpcyIKrZUuk027Hr6DwvJ9PS9TCvYFkJAjyobpFzIkSo8MensHeJv5dMcYPAMNRv5prTbydQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFEBDeu7STsb5WdTe/3BtqXAieuYTh67IorA4RBH39U=;
 b=NqygDvAA1948PpDC6KSYuetZseS80bkPjz83QS7KQnPNm0vYYeHaEhV7ikMer1VY8V989vxE4YHrc7cpqxoaSCfwarIuf6oo0NNnmyZZBXFG+DRYsv2XXI9xF8ed9j57IZz3G4Q0xUvyWT9XsweVmzxDuK5frFW5rU4cYJgamz2dAKCmxQRBzgHYaooGItY0r+zCBv7FVceRyNZCs8KFkBC+WUvLeVX8ITDMn8BU/X2JRkyQMUhE0Qe5x9CgeByyQRFybjkR8ykoUGAmgcsmL90TwI9JLxZGlXh6tCxChur9KkXdHhqA2ooibmn3c6VfK9K6TB/mcsqlXb7KRo9iDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by SA1PR11MB7038.namprd11.prod.outlook.com (2603:10b6:806:2b3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 18:53:15 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 18:53:14 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
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
Thread-Index: AQHbcDXbhlx9arVsgEanRzZCBe4QsbMqzcWCgAldBYCAASsJ5IAAl1hggAAW3B6AAGluIIACrEOAgAACQOA=
Date: Wed, 5 Feb 2025 18:53:14 +0000
Message-ID: <PH8PR11MB687958C8B4F275CA4D9BD614FAF72@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20250126201121.470990-1-dmitry.osipenko@collabora.com>
 <87cyg844fr.fsf@draig.linaro.org>
 <5aedf1ad-d9b0-4edb-a050-f3d9bee9bccb@collabora.com>
 <87ikprflbb.fsf@draig.linaro.org>
 <PH8PR11MB6879D81CAA931B0718DF3B1EFAF52@PH8PR11MB6879.namprd11.prod.outlook.com>
 <878qqmbzb9.fsf@draig.linaro.org>
 <SA1PR11MB6870F6C4479128EA3CBF9543FAF42@SA1PR11MB6870.namprd11.prod.outlook.com>
 <63a991d6-dfb5-4a7d-80d0-4c31673d3251@collabora.com>
In-Reply-To: <63a991d6-dfb5-4a7d-80d0-4c31673d3251@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|SA1PR11MB7038:EE_
x-ms-office365-filtering-correlation-id: cbcb1d3e-ae97-425a-7126-08dd461658bc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?LzkweElKVjJoTXdDV3JWbUVaRGFUNTFzNmllWjJLMllHaFF2VzNwSEFaczhT?=
 =?utf-8?B?d2YvU1ZQN21UOTkrRldLdlAxa0ZzVnF0TFZrNnJSdEVVakpObmRrZXJkVUVp?=
 =?utf-8?B?MlBBNTNtL0plMzFONlRkTXc2dXMwbEFFTlUrRU9mMnpOUmxDS2dkTmhHbFc0?=
 =?utf-8?B?SEtSQWEyS1N2ODREejNqTU51TzFISW5hK3NZVVZnZFp3bWtBRUp6clgzdGZ4?=
 =?utf-8?B?eFBUZUVjdFRWSFBsaGhld3paaWF4eXI3ejJMMi9OdkpkR3d4U3VQMEVOYXFF?=
 =?utf-8?B?Wi9JR09DUjBFZ2x2Y25DalF4UC9jcWNtYjBjTFhVcDN1Ym16TUwwWUZ3bitF?=
 =?utf-8?B?WnNsQWpFNmZMY2RLdWY5WEJRUjRWUk5RVnNKMFZaS3E5bUVvRExDVFBiQXJh?=
 =?utf-8?B?R2E2WGNUdlNPZGxobjNpZHVsSlRwNVFuc1dJT3RyZkYyRE9GOE5kYXRJcWZN?=
 =?utf-8?B?RGlBQmx2UUxoUVFuN1dwSEorNHpQa0xraHVrN1Y2Sm9JUHA3Rm5XbisyTXJK?=
 =?utf-8?B?MWF1eVhnUXVPdFhjaHRSbmREakJ5Sk1wVy9TMVZ4czFEOTlNU0xxQlVsZ0l1?=
 =?utf-8?B?VWc0MjlFMTJFQUYyU3BzN2lHNCtFMlpjZHR4aWVDS2Vua3hIM1hLSUU3aVpk?=
 =?utf-8?B?d1FUU3VVeGx1eUxNbVdlME83WWdIWW8yS3A4UXpqRUhSUVJwQlU0Ykt5VmdX?=
 =?utf-8?B?R1pmUHVJeUVyRk5lSWNjaVhMWlA2V2swQ0c0bSthS2t0Y2NISjJzZ0tUaklJ?=
 =?utf-8?B?STBQVUM2Skt1RWp2YWZNeXcrcXJGTW8xZmRHbFd6ZEhmVDFSTGwrWEFodkFW?=
 =?utf-8?B?NFJEVm5KZmg1WmlNUDVDbi9PTkJsRXdyYzV1bTYxRmZSNWYvaFRjWWloWjIz?=
 =?utf-8?B?dWNzeGhFeEhYbnBUYW1XYU5OK1hBRXZUR0tteGVGUEc1WCtJMEpBZndDRzNM?=
 =?utf-8?B?SC9yUFdweFBzWXRCczhzY3U5bmt4eTZlMkNPRWJ2MjhpZWUzelE2VnJ1clI0?=
 =?utf-8?B?RWM2MzVGWHlpZ3g0aW5BcDhGWnJXcWtOQ0k2UHhPeURJVHl2Rk9sUjg0TFR5?=
 =?utf-8?B?UGY2c2dRaWlMTmxlckl1U0ZOMEFObTVUdUVXbjlkd05KaENXL1lrbG00YUF0?=
 =?utf-8?B?ZXpXeCtBVlVqZ3Jpc2dlTnkrZFJ4QTcxVHRHVldtS0dITDVFbVFUaTJaaWdU?=
 =?utf-8?B?bSt2YWdWV25odUxSWHZUdGFPRnNXNGVWbXNVVStJVmRZN3UyYlhzYndxOUZB?=
 =?utf-8?B?M2xEL3k3MnJ2d21kcUovMTBEZGdYSWV3akxoVXA5SURuSU1kbTgxZkFuOUtl?=
 =?utf-8?B?ZDgvZU94Z3o5UkltaUJra0tnRkp4RTB0NXJaUVBTMVRHVVp3a05NNDcyWlN6?=
 =?utf-8?B?NkVSaEZHaUYxVXlINEtMbjB2WE1oMzBuS2xXTzFNaXVremVqZzFldVB4VG5l?=
 =?utf-8?B?UWdiU0htK2NsYUhBYllMVGo4cHB2QWd5RXpQVUlKN21jOUo2cjNhVjZPU1Fi?=
 =?utf-8?B?VGQ1WEx5ck0wSktxSFAwZ0Z2VFdmbU9iU0FrY0Rhd3FkWWNaZGkvNjNlMHNG?=
 =?utf-8?B?YjYvRWVkckpWRXRMY3cyTmZ5OFZFOTBldkRaelRkaXpUTkpZUTZ1ejJmZld1?=
 =?utf-8?B?em1TZ1dBZVR4VHhUalR1NWtqUDB6MW1EMHIrU3FBaFZ0ZGpoUDY5MEhCZTJQ?=
 =?utf-8?B?VjkvekFxd1czWEQyNENrTVpjSlM3SmxSVE1zemF6WHRUZXRIeFpER2ZFRitW?=
 =?utf-8?B?d3dwYjJNOVdsS1ZYV1grcURpQ2RhR0FyYkFZZGxWWXA1YmJCYkxqYXBhV1ZK?=
 =?utf-8?B?cVQ3b1dNN1pHb1ZRNnEzdHE0YVk0bE9wMlRFWGJwK3pLaHlYTVNZcURtUnEy?=
 =?utf-8?B?eFhZYTZSY2l1ZEFmNWw0Y3dRL1k4VUNRNDBqNmlnU0ovR0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUNSUHFaMVNFRmY5WDVQdG53R2NSUEM0dnJmSGRGRmxyYTVVMnZuUnVIcW8z?=
 =?utf-8?B?S2ljR0ZkaktJR2xxTlhtSXd4SU1lSGpzamdoY0hhNVp5bVc0SG13aC9IRVBy?=
 =?utf-8?B?VVJWQ01RUGZZZ04raEd6N3VtL1lUWjNtWllLUlRPQWt1VWx3Wk42c1pTYkNy?=
 =?utf-8?B?UG5JeW1UL3BHR1RJRFJIZm1ZaHNFU0hpbVdOM0p0ektKZmd2Y213ZklkbmNK?=
 =?utf-8?B?T2tkc0JNcmIvN29PbElreUZRWk1oV0M4OGIxWE1xbjdXNjVGV3ZSb2hiV1Jz?=
 =?utf-8?B?OVRZWmtiWExvVm4zUlBxNjlrdVNmQmZGcjV3VDdtYnJBS2N6clh0RDVubkRm?=
 =?utf-8?B?WE5ZUFI1dFNlWHRHM0JMQmN0UjFmWG8zYVhWeXJTVVJ4dlNWU2xkdFY1Tmgw?=
 =?utf-8?B?WllnMHVFVlU1dCthTGdqOUpLZklQdVYvMDdpczAzYzRHekNiMzBnMXQzMFVr?=
 =?utf-8?B?T0dRdGI0WTB0OHBqWjAxYjNKZ0hodzB5R1RXYmVKTmkxbTVXbG5PV1V1WGNp?=
 =?utf-8?B?SlFkRnV2YXFuUlYxaloyaTJBVU1ZbW1ITVd5dzd1YVQwS2Y3bkg0WW9pY1hr?=
 =?utf-8?B?ekFiUC8yOGVubW9sL2Zrc0lEeVRwYm9YYUJTLytFTHBUNGM5SzZ3MFdpdlJN?=
 =?utf-8?B?NldEbDVKQjhONUY4UkxyeG5UdGp1UVpNVlBWbnh0YjdxOHdIZXJUZ1VXcmh0?=
 =?utf-8?B?dkZlbzd5dHo2ZTNyRmRWS1d5OEtJUUxLN2ZjUUk2allmOTRTZStWZUo5SC9W?=
 =?utf-8?B?WFdsNXcwa0NONHMxaGZoRTgrZ1RERExZRngzS1F0NmZ3QmFoNUU5S0hOaE93?=
 =?utf-8?B?V2FVeHhNSHZtMk5INUI4Z2hSeURoMjQ2aDMwUC82WG5xaGxzMXluTDhmSDFK?=
 =?utf-8?B?WG9iL3BtTUhlZWp5Y1BtYVNHck5zWmpkclBrZ1NBSE1YRXV6a28ySFdzaWl6?=
 =?utf-8?B?aHhNYTJnTlIvb3UwL3F3QmVwODFzUXVOc2Fvd25wQnZFaDl6eC9oUkJRN04y?=
 =?utf-8?B?VUpOeW8yU3RjOHV1NFBXbE9lTjdZeXNIMTdGQjFnUWJZWTFYd2hVT09SSFJh?=
 =?utf-8?B?UmErekViYTB2cEVPY2VhcXdtVHg3WmF3WlYwL2lVMGVrREY4ZDY5UUQ2SGtu?=
 =?utf-8?B?N1p2cmNYVDgvcWROTWFkdWtZRkJQNXluLzNKQWNWdWExWkZJVnlLbTFqZjNZ?=
 =?utf-8?B?NkJ1dHZoRGpzd1V3YlB1YWdndDFqa3lWdWJwb0ZVcnAwa1UzRWRFSDh2YUFz?=
 =?utf-8?B?NXp3OWFVTHhscmVmK2wyTVpRdmJCVVlubzQ2U0xFY24xblNBMmwrb0V4ZXJD?=
 =?utf-8?B?VnBKUkoxVnExRU9NU1RWT0NOTmtBRnJ0Z1RzeWJ0QXgvcE9TVjJvYnE3TGt0?=
 =?utf-8?B?SzZsNGZXZy93UjJUUy96UVg2dkUrZEJNLzgzNnkwVndJcjhRSnZHNFhuQXZt?=
 =?utf-8?B?Tk1wZURLMUwrUTlDcFE4MkFhQVdnaTgvT010MDZrbTFKRzVSeU9nTnJXcGZV?=
 =?utf-8?B?WGdRL1FZc2hKdUIvdU44TktZaTh2dnZkdVJDWGlrb01DQ3ZQTWhzUmpNU0w5?=
 =?utf-8?B?SU8wVEVvK3Z3WmlHT2p1ZUpYaGdKc011WU96ZVNvL3oxalZsOU1pUWdGRWpI?=
 =?utf-8?B?YTUzMzVUNk50aWxGaS9HdVdvQ2dqajN3MmNIZCtFWXZNSmVGUXNtTXU0LzRK?=
 =?utf-8?B?NG5qaFY2MVpqTXQzVUZpZVRVSTVuY0xlVUlNbTVVcGtsQURiMTNwcm1zWEdQ?=
 =?utf-8?B?M2doS1dDcnBRdnd1YXFUTEJhVGNsZE9oMkJmYU5XN0hsdUxEaXBmWWk0Y24w?=
 =?utf-8?B?ZkVLUEQ4TFZaMHJzcWliazQ4V1hSUGx5bmFYVnJ1M01pUm1GZFBmUXVpVWgx?=
 =?utf-8?B?Qjg2WkhOaElJL2dzQ3hMUytpZHc2RmVWZWcyR0FzcDV6THJkaFdobFJxbFNF?=
 =?utf-8?B?ZFFPeU5nOFgwbUxYY2U0TnJBYTh0QWRsaFVWOExiVHNJVUFhR3RhU1NDSHAv?=
 =?utf-8?B?RUZpVXpma1VnSGQ2dW5tbktVZFdmY3VjdGs4b01IbVlmLzhOckJnUDhuakhX?=
 =?utf-8?B?eXR5WjJPNzNkdDFnNnh5WEphUWE0SHFqVUdSTzNXRVk4OG5odUZ5ckhob3dS?=
 =?utf-8?Q?1aURmQVXX6DirQ/pAM2kkmHlG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbcb1d3e-ae97-425a-7126-08dd461658bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 18:53:14.8269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CGUM45RE+TH+fWo5rb7wsfzAowGXkwW6b6myOb3M7sRD3H4J5c6ECvASp5GMMXmv+tbIW6nEfxidfEql67Geaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7038
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 THREAD_INDEX_BAD=3.197 autolearn=no autolearn_force=no
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

VGhhbmtzIGZvciBzaG93aW5nIG1lIHRoZSB2aWRlby4gSSB3aWxsIHRha2UgYSBsb29rIGFuZCBj
aGVjayB3aGF0IHdvdWxkIGdvIHdyb25nIGhlcmUuIEkga2luZGEgdW5kZXJzdGFuZCBjb3JydXB0
aW9uIG1heSBoYXBwZW4NCmluIHNvbWUgc2NlbmFyaW8gYnV0IEkgZG9uJ3Qga25vdyB3aGF0IGNv
dWxkIGNhdXNlIHRoZSB1cHNpZGUgZG93biBpbWFnZS4gRG8geW91IGhhdmUgYW55IGlkZWE/PyBN
YXliZSB0aGUgZnJhbWUgd2FzIHRlbXBvcmFyaWx5IHJlcGxhY2VkIHdpdGgNCmEgbWlzaGFuZGxl
ZCB0ZXh0dXJlIHRoYXQgUUVNVSBjcmVhdGVzIGZyb20gdGhlIHN1cmZhY2UgdGVtcG9yYXJpbHkg
YnV0IEkgYW0gbm90IHN1cmUuLg0KDQpJbiB0aGUgd29yc3QgY2FzZSBzY2VuYXJpbywgSSB0aGlu
ayB3ZSBtYXkgaGF2ZSB0byByZXZlcnQgdGhlIGNoYW5nZSBmcm9tIGd0ay1nbC1hcmVhLmMgZm9y
IG5vdyB1bnRpbCB0aGUgcHJvYmxlbSBpcyByb290LWNhdXNlZC4NCkJ1dCB5b3Ugd291bGQgc2Vl
IHNvbWUgcmVuZGVyaW5nIHRpbWVvdXQgaW4gY2FzZSB0aGUgR1RLIHdpbmRvdyBpcyBpbiBpbnZp
c2libGUgc3RhdGUgKGxpa2UgbWluaW1pemF0aW9uKS4NCg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHY2IDAwLzEwXSBTdXBwb3J0IHZpcnRpby1ncHUgRFJNIG5hdGl2ZSBjb250ZXh0DQo+IA0KPiBP
biAyLzQvMjUgMDQ6NTEsIEtpbSwgRG9uZ3dvbiB3cm90ZToNCj4gPj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2NiAwMC8xMF0gU3VwcG9ydCB2aXJ0aW8tZ3B1IERSTSBuYXRpdmUgY29udGV4dA0KPiA+
Pg0KPiA+PiAiS2ltLCBEb25nd29uIiA8ZG9uZ3dvbi5raW1AaW50ZWwuY29tPiB3cml0ZXM6DQo+
ID4+DQo+ID4+PiBIaSwNCj4gPj4+DQo+ID4+PiBUaGUgY29tbWl0IGJlbG93IGNvdWxkIGNoYW5n
ZSB0aGUgdGltaW5nIG9mIGRyYXdpbmcgYnkgbWFraW5nIHRoZQ0KPiA+Pj4gZHJhd2luZyBkb25l
IGF0IHJlZnJlc2ggY3ljbGUgaW5zdGVhZCBvZiB2aWEgZHJhd2luZyBldmVudC4gU28gaXQNCj4g
Pj4+IGxvb2tzIGxpa2UgZWl0aGVyIGRtYWJ1ZiBvciBjbGllbnQncyBmcmFtZWJ1ZmZlciBpcyBi
ZWluZyB3cml0dGVuDQo+ID4+PiBhbmQgcmVhZCBhdCB0aGUgc2FtZSB0aW1lLiBIZXksIGNhbiB5
b3UgZGVzY3JpYmUgaG93IHRoZSBjb3JydXB0aW9uDQo+ID4+PiBsb29rcyBsaWtlPyBJcyBpdCBq
dXN0IGdhcmJhZ2UgaW1hZ2Ugd2l0aCByYW5kb20gbm9pc2Ugb3IgdGhlIGFjdHVhbA0KPiA+Pj4g
ZnJhbWUgd2l0aCBzb21lDQo+ID4+IGRlZmVjdHMgbGlrZSB0ZWFyaW5nLi4uPw0KPiA+Pg0KPiA+
PiBUaGUgdGVybWluYWwgZ2V0cyBtaXJyb3JlZCB1cHNpZGUgZG93biBhbmQgdGhlIG1vdXNlIGNy
ZWF0ZXMgZGFtYWdlDQo+ID4+IGFzIGl0IG1vdmVzIGFib3V0Lg0KPiA+DQo+ID4gSSBhbSB3b25k
ZXJpbmcgaWYgdGhpcyBpcyByZXByb2R1Y2libGUgd2l0aG91dCB2aXJnbCBhbmQgZHJtIG5hdGl2
ZQ0KPiA+IGNvbnRleHQgKGxpa2Ugdy8gc3cgcmFzdGVyaXplciBvbiB0aGUgZ3Vlc3QpIGFzIHdl
bGwuDQo+IA0KPiBJdCBsb29rcyBsaWtlIGEgcHJvYmxlbSB3aXRoIHJlZHJhdyBhcmVhcywgc2Vl
IHZpZGVvIHNhbXBsZSBbMV0uDQo+IA0KPiBbMV0NCj4gaHR0cHM6Ly9kcml2ZS5nb29nbGUuY29t
L2ZpbGUvZC8xM1BOMnNGb1BzTTJveDZfZ2Y5R0xYU3Ric1oyN3hsTHkvdmlldz91DQo+IHNwPXNo
YXJpbmcNCj4gDQo+IEl0J3MgcmVwcm9kdWNpYmxlIHdpdGhvdXQgbmF0aXZlIGNvbnRleHQgd2l0
aCBhIFNXIHJlbmRlciB1c2luZyAnLWRldmljZSB2aXJ0aW8tDQo+IHZnYSxob3N0bWVtPThHLGJs
b2I9b24nDQo+IA0KPiAtLQ0KPiBCZXN0IHJlZ2FyZHMsDQo+IERtaXRyeQ0K

