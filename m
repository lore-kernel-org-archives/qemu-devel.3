Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F62EC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 08:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEP5q-0008Sv-H1; Tue, 04 Jun 2024 04:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEP5m-0008SM-RE
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:00:28 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEP5k-0004QZ-7u
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717488024; x=1749024024;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nHzUdc3SrZYEf9H/c+dUt0noj/x59cJsu1n4XO5jFuA=;
 b=jMAZNc+UgvnTuXXlTox04ECq5v7GJQEras16YrPvOTl+t/N21GxGfcrD
 mJpRJFfk9VrzB0XsS/FbkP4mnEjlXZJ9R1CHL+ox7dyla3Z7MGrYMdJvL
 4FX9D0Q127nfjtb5tygeSsU12JpZq3mymFQjXHmjrHZXQUJTCpDGQG+td
 m6Gh/m1hGkRJXiWNOp0vvg5sD2KAgolKAv9IHDX46eE2mr0xuAfJEnrq/
 jdRw58ptOtqXyycCyGAARMByo7wz1VeZ8O4YUo7FaTkCOLpFe/z70XkQk
 /hymGUyddVkTPnjLM8NsRIsVtFLW9BFhpdqASJfbFN4dQS6sLyYTqBLOw w==;
X-CSE-ConnectionGUID: Ku5vyhjfT/K/7SCwSuexMg==
X-CSE-MsgGUID: P2CsaAN/TVOukirgVOj8qg==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="17853475"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="17853475"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 00:59:29 -0700
X-CSE-ConnectionGUID: nMo1B2OeT8W0xMh9bNeaqw==
X-CSE-MsgGUID: GSVY2/IHSCCFg5UtzE54/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="37142237"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Jun 2024 00:59:29 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 00:59:28 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 00:59:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 00:59:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 00:59:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIdF4PIpIgJM1f/hTnpTyVDrCEHu2Q0oMjfFZCokDy4TtovJ36rNGzHY9izb2qRNMDj0FaWYhnFDOOEm1ZolT3TvwA8ik7eeV5Fuo07VUedfPeOGRneXU8uHGHsAkmkC2e3KLzQwv7NApvJ+vls+E6BONOuVbj5LG4jqe4+9MmZN/7ATROFvDmhpHQD3S9Aqh99CkbkddK40+M9tlJLVER1vhLj4x7vp6659YY056oiQ6L8Qvmh33my4tvo8TVYTuXvoiNdbxUgmPfpv1LBfOr94Ozh29nUD+hg/Vy/thNuV7mQHAg5LNswCNjyr7pizCkGOtwGih5OKAqLbblg7gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHzUdc3SrZYEf9H/c+dUt0noj/x59cJsu1n4XO5jFuA=;
 b=WdYH5Z+II6QSPaTxPFmEYLWk63nzM69rGAYe4M84IKLdt1ftBQC8MY+6Grrw22oFmjcQludXvVR5KK+L78HXMqqqyCctlFLFjWZJKd9DMEhChmzGmhD74C7tjDNldPUgNj5kV54RcNZIgc1wy/n8eYWwvrt/7RUqPWneueMfSBPPlNYBawNK5wxyjhk4xgWGOLg0XJTyIB0TstaoP8IbFrToEhqimAsSfAYnDuo6uF8XC4XRXh6owzAmxm24nXQzHRhFENLQsdoS5cMUtfQJORSsqbTtQxJmq0eqAOE6r5lpgvR6pxA1tZoeu0w9ao9XJPRs/uW7w0nj/DOOSZ6E9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA1PR11MB7918.namprd11.prod.outlook.com (2603:10b6:208:3ff::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 07:59:26 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 07:59:25 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v6 07/19] vfio/container: Implement
 HostIOMMUDeviceClass::realize() handler
Thread-Topic: [PATCH v6 07/19] vfio/container: Implement
 HostIOMMUDeviceClass::realize() handler
Thread-Index: AQHatX0ydRqw39Gl6EOwkh0framnqrG15eMAgAD/KCCAAFYvAIAAAsCQ
Date: Tue, 4 Jun 2024 07:59:25 +0000
Message-ID: <SJ0PR11MB6744E794E49B6D0D6677E9B992F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-8-zhenzhong.duan@intel.com>
 <1a188365-7101-472d-adfb-89a74dab055b@redhat.com>
 <SJ0PR11MB674405457470C87189BE09CA92F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <a677709e-0bd8-4fa7-aa81-34bc5eb90648@redhat.com>
In-Reply-To: <a677709e-0bd8-4fa7-aa81-34bc5eb90648@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA1PR11MB7918:EE_
x-ms-office365-filtering-correlation-id: 05bd67ab-3dcc-428e-abab-08dc846c40e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|376005|1800799015|7416005|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?TC9mWER2M01mV3cwcmk0Q09QSHR6b3FJRU12WTQ3TE13Q2ZiS0FRL2tDU2xl?=
 =?utf-8?B?Nk5MaCtOV25jUUhGOVZ3Mml2cmlVZ0thRWNpeTQ3ZkRPaEJDYkIzL015NENz?=
 =?utf-8?B?dDQybHRLcVZWMGZES3FpOVUxL2xBVUVyVFRDK1pSR3ZyQ244dlRuYXUxSjhv?=
 =?utf-8?B?SzZNbzZsSVBWdkRHc3FUVVpUaHEyNUYxTGpGb2xwRTB4VDB5NGF1aEN1WXc5?=
 =?utf-8?B?SkZYUC9IVUJXNktSeTdjalRyRmozL3JLZUs5Qkc4T285WkhxNVovYm53MUFE?=
 =?utf-8?B?Rno5VGYyQnYzOVc1eWtEZm12QkJsWW5vUW5FV1A5VzdMaFhSNXl0SnhOdFhn?=
 =?utf-8?B?OXc3RlBBNjk1UXNXRTJIY2xMaGZpV1V3SVJTWmFnT1NBTkdJR21DTGo4UmVw?=
 =?utf-8?B?S2dtYWtwb1pRSzdXREtUdG0zdWZGQzRFMkpYZDRzYnZoMFZjL1Joc0VsVG1o?=
 =?utf-8?B?Y09TTnk3eVJCQlBpREtsZGlDMEtWVTBQZ09VZzhvb1YxTTdsYnFXUm9zdEJ4?=
 =?utf-8?B?S1JycHNkSEFCU2x1UklLUStiTFpGMERmcmFmaTZIWVo2N2ZKZlVUSlhKRS9x?=
 =?utf-8?B?clNiSXdjSnJtK21sSGkvUnJBVllnZVNNdXZYZStkdkFPQlAvbkZxSzhsQ0Vs?=
 =?utf-8?B?bWcvNC93REhqdElIT0NqbTgvVDMySHFnZlVJREdZSWIxeGtRVTh1WWlCY005?=
 =?utf-8?B?ZmFoWjBPNVBjMXFoY3VzMmNqWjU3bTlrZDRGZnUvSEhBZWwyQW9mcW5BcGZu?=
 =?utf-8?B?M3VVNDV6SlBDR21sZlVjRHFhYzZBb1lqbFI2YTNaL1c4VFpwZmZOTFZqWnYr?=
 =?utf-8?B?clZYM3Faek9vUHc3dlREbW02OW1QRVdIbUpYQlRGeW1zZWNLYnpJbkp3MGhI?=
 =?utf-8?B?ajFXemgwMURRUGRBTWYzR3JQdWdjTlAwcGZ1NjhXTXFkRG55TlJYZFVmVElX?=
 =?utf-8?B?OG1hK0pRTW82bGZhMUMwaWZ6QUJkMndQeUprcENFT3E3dHo2R1lvVllMZkR3?=
 =?utf-8?B?bW5TaGd5MkZLODRKWWpQY1RMRXQyS1BnVXk3OGR6Q3NOeVRxOXJwRDZ6bzhT?=
 =?utf-8?B?em41bjRHLzJmWm9neW5uY1Z6UTd3SDhZanBaSU5KMTF6bWZIRzN6aStac2Vz?=
 =?utf-8?B?RHg4ZkM1R1ErSy9IQUxWWnRDbFZQdWhOaVpNRkozYVBKUklGa2h4MTFiOHor?=
 =?utf-8?B?aDhkeHBZSTBZRGxEdTBZRW9BdlRvd2Mvem0rMW5XYWFtQ29DdzRCd3g3QkIx?=
 =?utf-8?B?bmFZTC91UEZWQzZpU1hyR2o2aDRWWUtjMmZrMm5NRFpoZGg3aDZGMXY5TGJh?=
 =?utf-8?B?am1mWVhnZ0VEQTY0eldpSlQ5T0Z1SlNtS1hGbmhHNEZQbGE3YXR5dmljL2Nx?=
 =?utf-8?B?RktzaTVLZVhCNVRaR0dBTzNtVmZTZ2xnM1RuSVg3QSt0TGlianFLdnZVM3R4?=
 =?utf-8?B?Qms3Qkl3RitJbUxYY3ZEaDRObm5SNjBpeW44U2QyUDFBa2hTVXg0cnlPUGtD?=
 =?utf-8?B?bGpxYzRueDRvWElrcXZiSGJzckx0eWpYeE8rZTVRYW1DMGU4ZjNFdHprOTF5?=
 =?utf-8?B?ZGlwZ3gxK2l4L2pTWDVuRU5ndmhBT29aeW9sejFmS3NMZ3haeCtBM1NvSmoz?=
 =?utf-8?B?WVBnMmV1K0FWUXFHZTRNVzRKci9kbUl5MXBoQmErSmsvUWoxVk1iTmNXRmM0?=
 =?utf-8?B?QW5IZTdadEZTOGUwcjN5SFZvNTg5VElmNlprZFgzOFFYYXlsOHJ3NmxMZmdW?=
 =?utf-8?B?anV3VnpGL2hyMEpvbGlDc1RwNE0zWTg0ZFhwL1FGYXpvaGhvdlpXUWN3N2JI?=
 =?utf-8?B?TmhTUk0zUytHeG9GdWp0dz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjBZSlFjbStHUEU0bFZRZDhiK2tWU210cnNsbFBRZStYSVVrU3M4WGl1YzVP?=
 =?utf-8?B?OXByRjJ0SjV4RkdnTzRJZ0JQazN1b1ArN3VOMzNLRmZTelJXaDdCazY4SjY0?=
 =?utf-8?B?SDFwaDJFb05YRFhZK0s0cE1pQzZmelBPK04rUmlJb3lqYVJLN1JWMGxwclIr?=
 =?utf-8?B?aDRGYUJkWUhidUE5YWlCaXNITlFBUFBwSmJJSUJHMG16eTFJdFoyWDMyL0ly?=
 =?utf-8?B?QUYvcjlkMVNJT04wdE9UNXBkUHJVY2pzVmNGVm1MUHBuQnFwSWJpcC9WaFQx?=
 =?utf-8?B?SjhLZk9wZWtwQzdzZXNXbFJ3QnpseW1NalMycDJQL2xmL3dDMlpHaFJnOUJS?=
 =?utf-8?B?K1djUHhhR0l6SzZzeXJodXUzK290KzRNKzVQVHNDUkZzdUF3M096N2YyUDJL?=
 =?utf-8?B?ZmJaL3p0NHFkRzVic2s3TTBxYlFmaXRnMEh3bE5jVVRWSUM0U0pNQzJVT2V0?=
 =?utf-8?B?ZkhUbkQydnV5VGhzbnlqanczbmVCU2l5WWxRV1VuZ1NQTGMrNlN3L3MyL1Zj?=
 =?utf-8?B?Q1RXWnZKb2laenBHc3lXL3JPQmJENEg1aGxraTZyakpnQzdteTJ3WnU0YXVE?=
 =?utf-8?B?cnVKYkd2YVRxbHN1WVFsOURWU1pMaWNGSDZEWWhFQXJFRlduOTRWUy96UE1J?=
 =?utf-8?B?VG9MWUVna1B0bm5xZ3NhMFJOS1ZNMGRtZ3VJcGxJWGZFRGZoN2dhMTlXUWcz?=
 =?utf-8?B?dnFNQnhDbFhyNWlaZlBGUWdGK3VHMDI1N0pKWHljVjJoc3Bma2hEUHZ0SFJo?=
 =?utf-8?B?Q0pBWnJzYmlPRkorUEQ4MUR6WkdsTERyU1ZpaFJBc09NZ3A3VWhWbGFhQWFJ?=
 =?utf-8?B?bitwVnBUL0JsY2NwcDdFUnhwc3gwOVZCd2M1bi9kVWNFZUh5MVNpM2dZVEVY?=
 =?utf-8?B?TlJHTXAyYkhiWXVkTlNQMXRxNXliTTlVYmMyZDVGRWl4WUR2UkRYRllkTDFM?=
 =?utf-8?B?bTF2MHpNWW50SWtndnowL0N5M3RjcnJXRnQ5aCtWajM4TzQrQTJBa0NBcE54?=
 =?utf-8?B?Q1pHbVdKaDE0VkYvNHZ5Qm1MSmNybGlwVGVyamQ1SVRUeHY4TUJXRDU5Qzhq?=
 =?utf-8?B?UExsc2xWVWZYK3g2S2h5V3JUVGRJMFh3NWEzbFppaGhBRHBiQTcyR0wyYlJY?=
 =?utf-8?B?dWFoclFJNWoycDgwTmNTRk5JK2JWSWU3Q3FxNkpCL2QxRm9RRUd4Nnk3THNh?=
 =?utf-8?B?Vkp5V0ZJVkRNN1pyMkJNT25yZFZ2Skh0QWY0by9zRnN3aWNaRlQ2TEhYd09p?=
 =?utf-8?B?VERDQ28wL3pwTExYREZ6Z0pJMjBTaXdwU1c3WW5kMUNLcXdUakVNL1paY05y?=
 =?utf-8?B?a3l0dmpldGtwZXlYRm51Qm5sZENsL0VUNlE5OHR3MENPRTExeCtLT2JTUFMv?=
 =?utf-8?B?R3A1K20rdldlYWlOWDhnN1B4NEtrVTJCeVRvWXYwL0p4V2wxUkVSeWoxYjJG?=
 =?utf-8?B?MFlLeEN0cTdzek9YWnJoQ2NGSk5KaUxpUU81ekZLdXFPd0FrL2QwSytneEEy?=
 =?utf-8?B?WEpPN3lUMTVnTW1TWkFCRGNITUs4TnZreFAxVXBDMTJ2MlM1NUNBYnVrVVpn?=
 =?utf-8?B?eTFXMzd5VWFWek9RaXBmTVl4dU5RNTJ6MktBYmdKOGYxRHZJV1JnUzB4dnlT?=
 =?utf-8?B?Q1JWWGozMmZPN2taRkduRDRMMDh0QitaQ2ZEckE1akZXTDk0Z0I1b1djUmU2?=
 =?utf-8?B?RXpqcE5lekNqUHVxQUtXbnVOWjlwUllwd1Q4TkFFUU5NMFN4dlJsYVY2RFh6?=
 =?utf-8?B?QkUwNzlzYU84OGlkcUNSZmdFRmNsVU9iTTc2WjJUSVBONlpRUjYrVStnSlNX?=
 =?utf-8?B?a3FGVFdkVllOZTRCRHBzcGlTdWpSWkFaWTNnQnFmUFllZ2wrQ1FrcTU4Vkg3?=
 =?utf-8?B?NWZYRWQ2QVJTV3g4RHV0ZVBQMFBLNFhzZkpUSEdpbmVtUDgxWjV0S0RPbk9C?=
 =?utf-8?B?dUsrdHF0dlhLdkRyN0JkY1YzUXhkYWlJZWt3RFpDemZEdFM0OElOSXRVZFAv?=
 =?utf-8?B?YnZXRm1aaHBEcHNoUHBJK1RUYzhOck9Zc3B3cXF6bU5aQVkwa2RGZmg0TFN3?=
 =?utf-8?B?eDdhcHM4bDZMZkoza3QzRUtINTJONFhwbTBUak04QVFsa2xkbUhpMmNROU8w?=
 =?utf-8?Q?MRk3PWgkkREilHnLC84sbiSKL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bd67ab-3dcc-428e-abab-08dc846c40e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 07:59:25.9519 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yltsYrw12uqk+XeN5emrA/4aQ4m7n9hQ5wbN2YalyeVOut49KkRYrmh9MtWl/B4kW3zgtV4krlCURHI0k8Kw+X6/0XI1U+ibQPIOgmV1DjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7918
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY2IDA3LzE5XSB2ZmlvL2Nv
bnRhaW5lcjogSW1wbGVtZW50DQo+SG9zdElPTU1VRGV2aWNlQ2xhc3M6OnJlYWxpemUoKSBoYW5k
bGVyDQo+DQo+SGkgWmhlbnpob25nLA0KPg0KPk9uIDYvNC8yNCAwNDo0NSwgRHVhbiwgWmhlbnpo
b25nIHdyb3RlOg0KPj4gSGkgRXJpYywNCj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4+PiBGcm9tOiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+Pj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2NiAwNy8xOV0gdmZpby9jb250YWluZXI6IEltcGxlbWVudA0KPj4+
IEhvc3RJT01NVURldmljZUNsYXNzOjpyZWFsaXplKCkgaGFuZGxlcg0KPj4+DQo+Pj4gSGkgWmhl
bnpob25nLA0KPj4+DQo+Pj4gT24gNi8zLzI0IDA4OjEwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToN
Cj4+Pj4gVXRpbGl6ZSByYW5nZV9nZXRfbGFzdF9iaXQoKSB0byBnZXQgaG9zdCBJT01NVSBhZGRy
ZXNzIHdpZHRoIGFuZA0KPj4+PiBwYWNrYWdlIGl0IGluIEhvc3RJT01NVURldmljZUNhcHMgZm9y
IHF1ZXJ5IHdpdGggLmdldF9jYXAoKS4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogWmhlbnpo
b25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICBody92
ZmlvL2NvbnRhaW5lci5jIHwgMjYgKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+Pj4gIDEg
ZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9o
dy92ZmlvL2NvbnRhaW5lci5jIGIvaHcvdmZpby9jb250YWluZXIuYw0KPj4+PiBpbmRleCBjNGZj
YTJkZmNhLi40ODgwMGZlOTJmIDEwMDY0NA0KPj4+PiAtLS0gYS9ody92ZmlvL2NvbnRhaW5lci5j
DQo+Pj4+ICsrKyBiL2h3L3ZmaW8vY29udGFpbmVyLmMNCj4+Pj4gQEAgLTExMzYsNiArMTEzNiwz
MSBAQCBzdGF0aWMgdm9pZA0KPj4+IHZmaW9faW9tbXVfbGVnYWN5X2NsYXNzX2luaXQoT2JqZWN0
Q2xhc3MgKmtsYXNzLCB2b2lkICpkYXRhKQ0KPj4+PiAgICAgIHZpb2MtPnBjaV9ob3RfcmVzZXQg
PSB2ZmlvX2xlZ2FjeV9wY2lfaG90X3Jlc2V0Ow0KPj4+PiAgfTsNCj4+Pj4NCj4+Pj4gK3N0YXRp
YyBib29sIGhpb2RfbGVnYWN5X3ZmaW9fcmVhbGl6ZShIb3N0SU9NTVVEZXZpY2UgKmhpb2QsIHZv
aWQNCj4+PiAqb3BhcXVlLA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIEVycm9yICoqZXJycCkNCj4+Pj4gK3sNCj4+Pj4gKyAgICBWRklPRGV2aWNlICp2ZGV2ID0g
b3BhcXVlOw0KPj4+PiArICAgIC8qIGlvdmFfcmFuZ2VzIGlzIGEgc29ydGVkIGxpc3QgKi8NCj4+
Pj4gKyAgICBHTGlzdCAqbCA9IGdfbGlzdF9sYXN0KHZkZXYtPmJjb250YWluZXItPmlvdmFfcmFu
Z2VzKTsNCj4+Pj4gKw0KPj4+PiArICAgIC8qIE9ubHkgc3VwcG9ydCBxdWVyeSBIT1NUX0lPTU1V
X0RFVklDRV9DQVBfQVdfQklUUyB3aXRoDQo+Pj4gbGVnYWN5IGJhY2tlbmQgKi8NCj4+PiBJIGRv
bid0IGdldCB0aGUgY29tbWVudCBhcyBIT1NUX0lPTU1VX0RFVklDRV9DQVBfQVdfQklUUw0KPnN1
cHBvcnQNCj4+PiBzZWVtcw0KPj4+IHRvIGJlIGludHJvZHVjZWQgaW4gW1BBVENIIHY2IDExLzE5
XSBiYWNrZW5kcy9pb21tdWZkOiBJbXBsZW1lbnQNCj4+PiBIb3N0SU9NTVVEZXZpY2VDbGFzczo6
Z2V0X2NhcCgpIGhhbmRsZXINCj4+IFNvcnJ5IGFib3V0IG15IHBvb3IgRW5nbGlzaCwgSSBtZWFu
IGxlZ2FjeSBiYWNrZW5kIG9ubHkgc3VwcG9ydA0KPj4gSE9TVF9JT01NVV9ERVZJQ0VfQ0FQX0FX
X0JJVFMsIG5vIG90aGVyIGNhcHMuDQo+PiBNYXkgYmUgb25seToNCj4+DQo+PiAvKiBPbmx5IHN1
cHBvcnQgcXVlcnkgSE9TVF9JT01NVV9ERVZJQ0VfQ0FQX0FXX0JJVFMgKi8NCj5ubyBwcm9ibGVt
LiBUaGVuIEkgd291bGQgcHV0IHRoaXMgY29tbWVudCBpbiB0aGUgY29tbWl0IG1zZyBpbnN0ZWFk
Lg0KPlNvbWV0aGluZyBsaWtlICJ0aGUgcmVhbGl6ZSBmdW5jdGlvbiBwb3B1bGF0ZXMgdGhlIGNh
cGFiaWxpdGllcy4gRm9yIG5vdw0KPm9ubHkgdGhlIGF3X2JpdHMgY2FwcyBpcyBjb21wdXRlZCIu
DQoNClN1cmUuDQoNCj4NCj4NCj4+DQo+Pj4+ICsgICAgaWYgKGwpIHsNCj4+Pj4gKyAgICAgICAg
UmFuZ2UgKnJhbmdlID0gbC0+ZGF0YTsNCj4+Pj4gKyAgICAgICAgaGlvZC0+Y2Fwcy5hd19iaXRz
ID0gcmFuZ2VfZ2V0X2xhc3RfYml0KHJhbmdlKSArIDE7DQo+Pj4+ICsgICAgfSBlbHNlIHsNCj4+
Pj4gKyAgICAgICAgaGlvZC0+Y2Fwcy5hd19iaXRzID0gMHhmZjsNCj4+PiB3aHkgdGhpcyB2YWx1
ZT8NCj4+IDB4ZmYgbWVhbnMgbm8gbGltaXRhdGlvbiBvbiBhd19iaXRzIGZyb20gaG9zdCBzaWRl
LiBBd19iaXRzIGNoZWNrDQo+PiBzaG91bGQgYWx3YXlzIHBhc3MuIFRoaXMgY291bGQgYmUgYSBj
YXNlIHRoYXQgYW4gb2xkIGtlcm5lbCBkb2Vzbid0DQo+PiBzdXBwb3J0IHF1ZXJ5IGlvdmEgcmFu
Z2VzLg0KPj4NCj4+IFdpbGwgYWRkIGEgZGVmaW5lIGxpa2U6DQo+Pg0KPj4gI2RlZmluZSBIT1NU
X0lPTU1VX0RFVklDRV9DQVBfQVdfQklUU19NQVggMHhmZg0KPldvdWxkbid0IDY0IGJpdHMgYmUg
YSBiZXR0ZXIgY2hvaWNlPw0KDQpZZXMsIDY0IGJpdHMgaXMgbGFyZ2UgZW5vdWdoLCB3aWxsIGl0
Lg0KDQo+IEFsc28gbWF5YmUgYWRkIGEgY29tbWVudCBleHBsYWluaW5nDQo+dGhhdCBpb3ZhX3Jh
bmdlcyBtYXkgYmUgdm9pZCBmb3Igb2xkIGtlcm5lbHMgdGhhdCBkbyBub3Qgc3VwcG9ydCB0aGUg
cXVlcnk/DQoNClN1cmUuDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCg==

