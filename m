Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A734C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 06:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiopf-0004eX-Cj; Fri, 14 Feb 2025 01:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1tiopc-0004eL-P8
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 01:05:44 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1tiopa-0000id-Jp
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 01:05:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739513142; x=1771049142;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=p2mWrA5r+6VIVqkRpWANzJtHELgStDoohoIybv6k3A0=;
 b=Dm6gFEZiLMQVu162Kfh/fwci4ho3cQEwiq9MiyDrwuYIAlORzPlqb0eS
 FaLdxNlkj1FBa6xiLEQdJ3k7Ozz8abwFvv9lc/4fI+NHL0jCd9l707bzT
 gFKfWqYftEZGeq5iZ5MlumaJ3G5/8WXL/NWX8eL4PZLEoBNGMWDtYlC22
 Lcohoz3fUwNayNWbxFmrdLr9///gdQpWgjeTBjcZVqpKWBfKBhj2qPRBk
 uYTREcFuQZNxXdNXS/S2RhgE/oW+m22VvCtH9imt3g3c1zDPO7AMZ3qmk
 7Sdb+KYY98wCYw4hzfEg7et0mHn9i9k4V3bTpPhwLilvoTSrVL6auZydu Q==;
X-CSE-ConnectionGUID: PoFQMn12QiqcyAy8ZdFvqA==
X-CSE-MsgGUID: sX7LjSGwTcqOiytUqBg1vQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="44182404"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; d="scan'208";a="44182404"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2025 22:04:20 -0800
X-CSE-ConnectionGUID: 3VUpf+PXQzyr4AF8UvPOXw==
X-CSE-MsgGUID: Lqg4HUQpT8+VrqZHK00k9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="117984896"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Feb 2025 22:03:48 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 22:03:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Feb 2025 22:03:33 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 22:03:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r20ZOU6xYpp7m/YvuCq5TIcUXeGgAkhB84k6HhdAuV9pL47osWkZJrjFBu/Q7bVc+Cnzx8MUZDts9Wh0ElUJEUT5VaHKddf+GYsAWKe39oyU8xrVYJ5Wj0x+ynMsnigol7tSkN4631SxvCGZdBGQUsYn8OaUUQ7Ku1J2ocNcP499fuLAlY1c8CkSIyfAxSsnHwAaHt5reDnukB+wxBfco8/3KMaUXLtP/BwuA8TQzoykSzv81wSIGjaeiNA1ikIzA6mm2rfsOTb5hCsCBAx8s5Fz1W1btyslzM6PXhCd8ny/RzJSDpXwBOYI6ubgZuV6V4213SYAu68OSEVHIOiYuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2mWrA5r+6VIVqkRpWANzJtHELgStDoohoIybv6k3A0=;
 b=LfcXJZrt7rY5/eC+ZNL2lR1+Osfbaw9/cJm+kHVdgi6yB2sgVtpF7k24HxCEnsyR0RAc8lOZb9Rq4a7bGeGPNPsaaPAybSlF+xfJiRHoijyk5J1zRRUNz52LyFSnSEorQUdkrYcnxQs147VGXSkYDsqchpB/4ZNuPHSXqFq+q2koZVNHCh/3qR8tD8HLZ5D+wotGUEDuGaZere739MzXs5XKaxtaN6NY6XGeUlr8SpEBTtW9gpC4YPwqBf7NwW0PA+Eo8HMUcAYeLkyho8VwX6HYMXy2IovJ07JcAP9pHv22m2N63Ae1mbNUMYfVFv4JgFnt/Qzaa+qhLmxd9IMCLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by SN7PR11MB7489.namprd11.prod.outlook.com (2603:10b6:806:342::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Fri, 14 Feb
 2025 06:03:13 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%3]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 06:03:13 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, "Kim, Dongwon"
 <dongwon.kim@intel.com>, =?utf-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>
CC: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
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
Thread-Index: AQHbcDXZ5SMS0FAhbUGPMzRmThuprbMqzc1kgAlc/YCAASsDxoAAmOEAgAAVT3GAAGo4AIACq4OAgAAERwCAABTogIAAIvuAgAm6TYCAAytdcA==
Date: Fri, 14 Feb 2025 06:03:13 +0000
Message-ID: <IA0PR11MB71859A4A004752BA6089C1D4F8FE2@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20250126201121.470990-1-dmitry.osipenko@collabora.com>
 <87cyg844fr.fsf@draig.linaro.org>
 <5aedf1ad-d9b0-4edb-a050-f3d9bee9bccb@collabora.com>
 <87ikprflbb.fsf@draig.linaro.org>
 <PH8PR11MB6879D81CAA931B0718DF3B1EFAF52@PH8PR11MB6879.namprd11.prod.outlook.com>
 <878qqmbzb9.fsf@draig.linaro.org>
 <SA1PR11MB6870F6C4479128EA3CBF9543FAF42@SA1PR11MB6870.namprd11.prod.outlook.com>
 <63a991d6-dfb5-4a7d-80d0-4c31673d3251@collabora.com>
 <PH8PR11MB687958C8B4F275CA4D9BD614FAF72@PH8PR11MB6879.namprd11.prod.outlook.com>
 <4250091a-d823-4bcc-89ce-80f3f26f3be4@collabora.com>
 <9f81a22e-edd1-4525-b97d-3be31057ad26@collabora.com>
 <6db636f8-18f6-4461-9d95-cac7590acd15@collabora.com>
In-Reply-To: <6db636f8-18f6-4461-9d95-cac7590acd15@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|SN7PR11MB7489:EE_
x-ms-office365-filtering-correlation-id: d6b5763c-b4e6-4e51-af1a-08dd4cbd440d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?UmlXbnc0UVA1RVh6bVRNeVovNDg5dWpzTUZNN2JVTXBQY1BQSGZzeC8rMUtH?=
 =?utf-8?B?SEdFM1RsSEhobWJ0aWdvWGwwNnRkY0xmbzQ4QXJnaFp2T0pSUjlBVVB3bFEw?=
 =?utf-8?B?NDFpUVkwb3FQNmU4SXpBTndFcHdERDZmdjl5a09ZTXJMVEk1MXdBSjdqVWhq?=
 =?utf-8?B?dkZtR21IMTVwMFJGa2J1SkZXZHVRMGtnYUdITWc5d0tDazhWaENzWEh4Z1V2?=
 =?utf-8?B?ck1Md3hDZHpkMHNHVE1yaW01S0VOZW9SWTN4alpFSFpCSHh2ZlZVV0J4SE9p?=
 =?utf-8?B?eHNMY2l1S08vTFFwRHhQdnlXM2hYOEs5eGdHam50cGhUTkMvbTc1RzhLWktR?=
 =?utf-8?B?VUcwU2RXOHZhU0FKbUVQeVpranYvNDlSWkN0YVZ1eFZQRzRISWwvdG9XeTEz?=
 =?utf-8?B?M3BjcmJUN2xaZE42dnlxaEJzaWpYQVN6R1ZiMDVxZjl2L01UTDZmS2JpZ09Q?=
 =?utf-8?B?Mi9aZGtWTStFTlU1QzRZZU5waU56Y1FHdlpzSE5QZEUwZ3lxRUNYbDVrTjNi?=
 =?utf-8?B?T3hrR2lwSitXdEpyRlhzMXRGREgySTBuczY1c0ZxVndONE5FbHlmN2ZoQlJy?=
 =?utf-8?B?bXpMU1ZJdmhaYUtzeXFzeFJ5NXRuWnhyYnA1NFlkdmh5OGRwUVJNWDlER0Fh?=
 =?utf-8?B?MVprRklXSU0zVXpaN2gwV2ZTTXU5SmNwc2QyYU5FWkN5eFRQSDFhVXlSZTFh?=
 =?utf-8?B?OFQrL1pMMzNUK2UrT0p3c29mN2RFQjN0VjMwamhWUWM2bVk2dmhFTmVHV3dZ?=
 =?utf-8?B?ZzBla1JqL1dFMFB1VVhMWFFhRmx1MDl3WS94MkVLSk1NRE9weFh3MVFvOWZj?=
 =?utf-8?B?L0pSQmd1TzZiWUYraGlObG9pUXFEOEJ2Y3BoY3lJZDhNMmhXdE96cGtwMXR1?=
 =?utf-8?B?dkRMd2JXWlBmL09OS2lOODVxOTRIQUVXRy9kZGVtTFNMSWYzRkdxRjBUYkZ0?=
 =?utf-8?B?NkNVUFpjYWVPZkQ0SVJIdktCbDN3b0U1NDkrOGxjRlBWemx5VTdibzVydkU4?=
 =?utf-8?B?eFFZVkNDTU1CT0FNci9tNU5RM2E1ZVp6QUViMVlHNCtXRkUwTm1YZDhCZ3Vi?=
 =?utf-8?B?b0xGQlJCdTFSZGtBaXVSZVhTYVRtZVZtZndKaWtxY1VOV2I5blBaWkxVOXRB?=
 =?utf-8?B?L252NWVLdnRmQ1dTVEpSd0JyMTZKQzYrWDFTaDN4YXJqR3F5a2J0MjFZZ21z?=
 =?utf-8?B?WEpnY2syNE0zQTZ5ZFRleFhnMGVUaVVmbkwwQ05Ma1k1Z3N5WmN3eUtMS0Nv?=
 =?utf-8?B?Q25jRUFuSWNJM1VYYzhNWFNybWlwYVdkZ2hIUFJYMjErY2c5RnRxdXpjOHls?=
 =?utf-8?B?TllIOWhyWHZ4WEF6V0VKNUJFRU1EV3o1RVZjaGMxSDBLN2RwQSsxeHovaG1i?=
 =?utf-8?B?ZFVCUGFjZjhoVzI4UEZJRld2VHNqNThVZ251RWNYNm5lZDhGbmxvVW9Wb0l1?=
 =?utf-8?B?VzVydzdqL1piMmJTSnpMeEFVSDM4dDI1N0FNd2sxek5uNFpuaU5hN0QwT0ww?=
 =?utf-8?B?M0hyc3hDY1hqazRRZEZIaUZKUTFXdHZ2QTZseW4zRUgvcXpLQ00yaXlDajlV?=
 =?utf-8?B?WjlCS1huSTBqNGRpOFNqWERza1oxNFR4N3BEUWZySFBXbEljQW1wcGxoOHpt?=
 =?utf-8?B?VmZ1MkFOeDdQYXRIZ3QxY0UxQjk2SmhUd3cwQ29zbzJCWld2NUFnOEEvKzV3?=
 =?utf-8?B?U1BlTFB2T1RNZTVOaXpYSStId3FXUkZlYkxWTFdaVlQ2ZnlObzlZYWdLU3U1?=
 =?utf-8?B?UUpRaHBPK1Ezck9xL0I4ZGJUaTFDTVJWN1kxQ0FrWjRqODc0NWl3dHFaRi9N?=
 =?utf-8?B?SUJMbjdkOHk5UnhnVFRPb0NDajBoQWJuMndOUEpuTWpod1kzc3hPb0Y1RFRR?=
 =?utf-8?B?ODR5YjVFcCt2emppN3NKekZ5N2R1V1hPWmgyaEpXQ2FDVElYVFM2bzZRSFRV?=
 =?utf-8?Q?NmJ95nWuAhYSYrvoJFs+uFW0iW1xHvsS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3FvYjBnZGVwcVJxVXJkV3hGRHFvRnB5emd5VXJOM25ZQW1wMjM4ZTNZZzF5?=
 =?utf-8?B?elRPUlpiUm5xalZBTmRsRVY4cEVJYVpnOFdaSHdWalRwNlhTMW95T0EreW5Z?=
 =?utf-8?B?MnJjZjROSmZQVXhCSDhOSXZNUWYxVDdNQjFlWnZ5ajNld3B0WEh2VUJQbjds?=
 =?utf-8?B?dm0wYVJaWGtWYmcra2pGL0VxTXY3ZU1tdG1nK1BuMFZtY21DTlBBdkRVMWJt?=
 =?utf-8?B?N2VPTVBzc29TS0FsZUM3S3JYRk81cloyNUtYTERFVmZlbGhKMHFQc1FaVHZ4?=
 =?utf-8?B?UnQxakpyU0g2ZnJKMTgvaExTcDc3Tm5TOWs4YXZlelc4NEIyc0ZIZDFKdStM?=
 =?utf-8?B?bHBpaEtkYXhuYytGZW45Qi8raEJwMkF6akhJVGptbmk5OXlDY1ZRZkt3djNu?=
 =?utf-8?B?S1pvaFV3WS9aazAwaVZwaUZLMUE2VjBEZGVZaU9UOWNPRnpPbndWUFNWeUcr?=
 =?utf-8?B?WmlGeVdZSGxjZ2V2a2JzbTRNd2N0dXJXR3BpQ2p1RnJqdjFKbVpnNnliL1NU?=
 =?utf-8?B?aXA3cWxuVU1MUlVBTXRHQVFTRnRyV05CdjNJUmlvbzdhVXNnWTUrZytrRTY0?=
 =?utf-8?B?Ym5WOFpxZXdCSTk3MHNrSVZoaWtrTmNLaWk3TEdESFNnYjBmeXVoR2tqUWVS?=
 =?utf-8?B?VUZmQ3FLTzNzempVK0NRNVQwczdBQW1IZXJsZTFVQzV3cmhySWgwdjBScGZX?=
 =?utf-8?B?bUJaOFB3L2ZSUW5XK2ZCbTlKTGhMbnhzUERVOGlHNk9meUlhRlNvOUJvNDk2?=
 =?utf-8?B?WGMrSjRvaVFLcWsxemVqY01CTTIwNUR5NXBvU1hOUVB0T3l3NkplRmlwcTBl?=
 =?utf-8?B?MHRvSUppMU03Y0pLMDR4RHE3WUJ0b1loaFJndGdOOENHVU03c3lwaVB2R01S?=
 =?utf-8?B?dDBkWWQybkVlNTIrTGdDSit4VVhuMVJNNmVhWnR6ZFV3TDJNUVdqS294U0ha?=
 =?utf-8?B?Wk5TOGlhQVhhS1FzVHVkWkw5MEFXWTBmTjNNZVJLN3FGSXc5aS9NU3RIRVFy?=
 =?utf-8?B?Mjh0VHEyajl5VHdaUU9KRno2eTllajF1VS9oL0hLUzhyaWQ3MzZPMDhaMW1I?=
 =?utf-8?B?U04xbXVQaHppQ2JNaXBDSEpkbzNxVVBvUGFjMzVRUml6Y1kveFNuTGNnVTVX?=
 =?utf-8?B?ZWNpbnkxOWx4ZHQrQXVNbHFyQnJNKzhuYXB4Tk9xSW14eCtBNU4wWXJXOVdl?=
 =?utf-8?B?L2FNZnNBUy9jQU0xYUVTOHVEaTZ1TzdrQWdPR3R3L0kwRUFlR2R4bHhiS0E2?=
 =?utf-8?B?UkN2dXV6NEhtS0FuYlB3OXBhRG9NdkttU3ZzUThuZkgwalJKTHkraUJlaC9w?=
 =?utf-8?B?Wkc1TVJ5M01ZNFphcEVScjdHK0U3K0huOEQwYVlYNUpkNDFUZURIVWcra0RQ?=
 =?utf-8?B?RG9RTFNyY0hzL1gxaGMzMk44aC9hTDlSWmJYeVlXcU53SVlsTkJRdC9xVkdr?=
 =?utf-8?B?a0ZFZGJLU2xuTG9vajM4ODJ6Um9kMTZCc1lvcytlaG5XcWNUa2VGaTdIRTFp?=
 =?utf-8?B?cE5MbmRqOVlXRWNGdjVHbEFLK3FETUdCS29NeFVNY09UU1d1N05UbEtQNUx1?=
 =?utf-8?B?Tm9mblVocVhJMzBScHdBNmlTdzMyRnhYVWhUSjlvNXkyOXpIV05LdWVKRU9n?=
 =?utf-8?B?cFNvYjluMndONW9UeVNhamlUa2pxS0gydFJpVHgvQm8xaFlhK1ljdjJLK3Rt?=
 =?utf-8?B?TFBwMUxncmJpMm5IU2ZoUEhGcWJzb0NnRE42bWxySUtVQkd3M1g4Z05qWFY0?=
 =?utf-8?B?RWFVSGcvT0NjVUpLSHg4SkVPc0toN1pCUmlMR2dUK25vRTRrMmVSUEJFZExp?=
 =?utf-8?B?RXdTdU1ZRGgzK2VhMTg2cUlDZUNvSHAyMWpkelIzS0p2cGY2bUNBWVBHbGV1?=
 =?utf-8?B?ZkNvSndKTDk5dUkzeXRyQTJzWEp1TFNxMTA3c2VvSm1OUlU1Ky9zUDBlSHhS?=
 =?utf-8?B?ZklVTWtqSTlQTk9SL1hEZDhXRStqS3hmdmJDU0hNL0JNMVRpbnVzY09SMkNW?=
 =?utf-8?B?VU9aZWMzY004RGVsRkd2N25jenBZOXdLR0RXZDdIQmMzT0M1aWZreW02Y2ZU?=
 =?utf-8?B?bi9DWTBxVFNkVUdhUEdUVVlSd2UyREltY0FSeTZCLzNvRHRsVFBIemlLcWNa?=
 =?utf-8?Q?ad0aQgr8MaLwlebQV93Gwgt6x?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b5763c-b4e6-4e51-af1a-08dd4cbd440d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 06:03:13.0528 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bZo5L6dXlwuKrmb3SxsggJTh+V2nMewORNQH23fiRORZS9MUn1gF77bhsjIDDCWsmtQHnFR5S3Wc/PiyAwjxbqo+hoH2lcWhtDPJikY0SK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7489
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
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

SGkgRG1pdHJ5LA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMDAvMTBdIFN1cHBvcnQgdmly
dGlvLWdwdSBEUk0gbmF0aXZlIGNvbnRleHQNCj4gDQo+IE9uIDIvNi8yNSAwMToxMywgRG1pdHJ5
IE9zaXBlbmtvIHdyb3RlOg0KPiA+IE9uIDIvNS8yNSAyMzowOCwgRG1pdHJ5IE9zaXBlbmtvIHdy
b3RlOg0KPiA+Pj4gVGhhbmtzIGZvciBzaG93aW5nIG1lIHRoZSB2aWRlby4gSSB3aWxsIHRha2Ug
YSBsb29rIGFuZCBjaGVjayB3aGF0IHdvdWxkDQo+IGdvIHdyb25nIGhlcmUuIEkga2luZGEgdW5k
ZXJzdGFuZCBjb3JydXB0aW9uIG1heSBoYXBwZW4NCj4gPj4+IGluIHNvbWUgc2NlbmFyaW8gYnV0
IEkgZG9uJ3Qga25vdyB3aGF0IGNvdWxkIGNhdXNlIHRoZSB1cHNpZGUgZG93bg0KPiBpbWFnZS4g
RG8geW91IGhhdmUgYW55IGlkZWE/PyBNYXliZSB0aGUgZnJhbWUgd2FzIHRlbXBvcmFyaWx5IHJl
cGxhY2VkDQo+IHdpdGgNCj4gPj4+IGEgbWlzaGFuZGxlZCB0ZXh0dXJlIHRoYXQgUUVNVSBjcmVh
dGVzIGZyb20gdGhlIHN1cmZhY2UgdGVtcG9yYXJpbHkgYnV0DQo+IEkgYW0gbm90IHN1cmUuLg0K
PiA+PiBObyBjbHVlLiBDb3VsZCBiZSBhbnl0aGluZy4gQ291bGQgYmUgYSBHVEsvV2F5bGFuZCBi
dWcsIGNvdWxkIGJlIGFuDQo+ID4+IG9ic2N1cmUgUUVNVSBidWcuIEdUSyBleHBlcnQgd2FudGVk
IGhlcmUuDQo+ID4NCj4gPiBBbHJpZ2h0LCBpdCdzIGJ1Z2dlZCB3aXRoICJibG9iPW9uIiwgYnV0
IHdvcmtzIHdpdGggImJsb2I9b2ZmIi4gV2hpbGUgSQ0KPiA+IGRvbid0IHNlZSBRRU1VIHVzaW5n
IGJsb2JzLiBNaWdodCBiZSBRRU1VJ3MgYnVnIHRoZW4uDQo+ID4NCj4gDQo+IExvb2tlZCBmdXJ0
aGVyIGF0IGl0LiBTbyBRRU1VIHdhcyB1c2luZyBibG9icyB3aXRoICJibG9iPW9uIiBhbmQgSSB3
YXMNCj4gbG9va2luZyBhdCBhIHdyb25nIHBsYWNlLiBUaGVuIEkgZm91bmQgdGhhdCBzZXR0aW5n
IHkwX3RvcD10cnVlIGZvcg0KPiBkbWFidWYgbWFrZXMgZGlzcGxheSB0byBzaG93IHVwc2lkZSBk
b3duLCBidXQgdGhlcmUgaXMgbm8gcmVuZGVyaW5nIGJ1Zw0KPiB3aXRoIGl0LiBTb21ldGhpbmcg
cmVkcmF3cyBkaXNwbGF5IHdpdGggeTBfdG9wPXRydWUsIHdoaWxlIGl0IHNob3VsZCBiZQ0KPiB5
MF90b3A9ZmFsc2UuIEkgY291bGRuJ3QgZmlndXJlIG91dCBob3cgaXQncyByZWxhdGVkIHRvIHRo
ZSBvZmZlbmRpbmcNCj4gY2hhbmdlLg0KSXQgaXMgcG9zc2libGUgdGhhdCB0aGUgYWRkaXRpb25h
bCBkcmF3IGNhbGwgKG9mZmVuZGluZyBjaGFuZ2UpIGlzIGV4cG9zaW5nIGEgYnVnDQplbHNld2hl
cmUuIFRoaXMgaXMgYmVjYXVzZSBoYXZpbmcgYm90aCBibG9iPW9uIGFuZCB2aXJnbD1vbiB3YXMg
bm90IGEgdmFsaWQgY29tYm8NCnVudGlsIHJlY2VudGx5LiBJSVVDLCB2aXJnbCBkaXJlY3RseSBj
YWxscyBnZF9nbF9hcmVhX3NjYW5vdXRfdGV4dHVyZSgpIHdpdGggeTBfdG9wPXRydWUNCihzb21l
dGltZXMpIGJ1dCBJIGd1ZXNzIGdkX2dsX2FyZWFfc2Nhbm91dF90ZXh0dXJlKCkgbWlnaHQgYmUg
Z2V0dGluZyBjYWxsZWQgYWdhaW4NCndpdGggeW9fdG9wPWZhbHNlIHZpYSBnZF9nbF9hcmVhX3Nj
YW5vdXRfZG1hYnVmKCkgaW4gdGhlIHNhbWUgcmVwYWludCBjeWNsZT8NCg0KPiANCj4gSSBhbHNv
IG5vdGljZWQgdGhhdCBRRU1VIGNoZWNrcyBXYXlsYW5kIHByZXNlbmNlIGluDQo+IGVhcmx5X2d0
a19kaXNwbGF5X2luaXQoKSBhbmQgZG9lc24ndCB1c2UgRUdMIGNhbGxiYWNrcyB0aGF0IGFyZSB1
c2VkIGZvcg0KPiBYMTEgZGlzcGxheSwgYnV0IHRoZSB5MF90b3AgbG9naWMgbG9va3MgdGhlIHNh
bWUuIEludGVyZXN0aW5nbHksIFdpbmRvd3MNCj4gc2hvdWxkIGJlIHVzaW5nIHNhbWUgZGlzcGxh
eSBjb2RlIHBhdGhzIGFzIFdheWxhbmQsIGJ1dCBJIGRvbid0IGhhdmUNCj4gYWJpbGl0eSB0byB0
ZXN0IFdpbmRvd3MuDQo+IA0KPiBJZiBub2JvZHkgd2lsbCBiZSBhYmxlIHRvIGZpeCB0aGUgYnVn
IHNvb24sIGF0IGxlYXN0IHJldmVydGluZyB0aGUNCj4gV2F5bGFuZCBwYXJ0IHdpbGwgYmUgZ29v
ZCB0byBkby4NCkhvcGUgd2UgY2FuIGZpbmQgYSBwcm9wZXIgZml4IHNvb24gYnV0IGxvb2tzIGxp
a2UgRG9uZ3dvbiBhbHJlYWR5IHNlbnQgdGhlIHBhdGNoDQp0byByZXZlcnQgdGhlIGNoYW5nZXMg
aW4gZ3RrLWdsLWFyZWEuYy4NCg0KVGhhbmtzLA0KVml2ZWsNCg0KPiANCj4gLS0NCj4gQmVzdCBy
ZWdhcmRzLA0KPiBEbWl0cnkNCg==

