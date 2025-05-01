Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA225C3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 05:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAMjB-0002HW-Qb; Thu, 01 May 2025 01:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uAMj7-0002H4-G6
 for qemu-devel@nongnu.org; Thu, 01 May 2025 01:44:54 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uAMj3-00014j-S3
 for qemu-devel@nongnu.org; Thu, 01 May 2025 01:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746078289; x=1777614289;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qPzdTDXp/7FLrDQ17R4IArE6Ssc7d7sPdcdYD2g/3a0=;
 b=gfHz1xDgcHt4Qj8+5AnSY/CRtAKQAQsef08iHVw1dMzpu9x7t7aX7d2N
 yT6ejfDS3hJbRTs4/wKqNAHwW+Z4uWt5d0tPANVwdzvRZaS2nWZ2dtKP6
 2XlpnUoXf6a3EezE4keKj+/BfyW+LO8PAnvL4cJLKmQreSRhxN3u2OIrB
 wJf0D+x0gA1fiJ8WLO+o8RhXwSmZMLV85froi5dDL2U7y63Ts7t0/ar2D
 f6AT8SQjs7ifFQIkRxG/efoWm1Y2TmBgty0WK4zOG4RV05AUrOh6AAcTX
 YeOqfSJpG3MGYCSfxRa7WUB5bM0A/kVf7HZ2EACNaXuag/w11IATwaH9A w==;
X-CSE-ConnectionGUID: h5j6vyVeQqKsRHIKnifmrw==
X-CSE-MsgGUID: IFNs6tVrRXuQeueuVBm+dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="57947690"
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; d="scan'208";a="57947690"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2025 22:44:42 -0700
X-CSE-ConnectionGUID: oqq58m+JRdmRVYC3Ijd7NA==
X-CSE-MsgGUID: II9irIbfSHi/l1U4Q2vaNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; d="scan'208";a="171543911"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2025 22:44:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 30 Apr 2025 22:44:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 30 Apr 2025 22:44:42 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 30 Apr 2025 22:44:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feRR+YnTHa6PdO1GrxZ6z7x4PJnc2LKXB6WHCfAL0DglhwQ29iTjtXnCVAVEZxaHQDAt8ahbLIyYMP9St1c/M0wJC8mPGIZvEldFSwVc2Dhzbz+7/qPPvGamywhSVSltRNQ6XUddmMlQotmaf5uKUV+beLRs3DGLNItKzBi6gAYsilzUqz7b7sBhkRJ2mjbODRqEtnhVovZgo3GKO0owM+akBygWYAosInQ5aYjr63zyrBJjyUvPp6F5lQNuRMF1xwQ7K/4hVoXIzDdcjpZizaYjuVp8tD8DhboZNXysOJ1WR17AplYueQlL0Lwqj2Vlx3QVyA36yumZERCkwwh8+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPzdTDXp/7FLrDQ17R4IArE6Ssc7d7sPdcdYD2g/3a0=;
 b=Ve8qaPJ9chREt6I4B97wHgCdUuMFmCZGMBEQXVFZ0gs9g6R5W5lyPIX06v8wbIALQlIyBKAjrJP7sdgknvVNFh9xVrmDuHekCOPhSR2N76ixFMRvaiaGfrFj+Ead/9THz2/mi3a9jQ04AnY8pCIbqj21AmdwfnW9Dyt15y1SjDDCt9KhpAq5Hdywwt6uf3ZE/ZRlvUXCnZIeaO+tAmgA6TBHzSqmMke3rItpzBnNNnuMCrxUpLjr8JjJrJjc6MwZ2V2/LupJmY4mQJZdA4xmdCbqgqZlAfLXgO5jRfp03pP6F6F/exX+OvGtIvYJHO94MToOLN1ZoPmuwgJEDWacSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by DS7PR11MB8856.namprd11.prod.outlook.com (2603:10b6:8:253::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 05:44:39 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.8678.028; Thu, 1 May 2025
 05:44:38 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Gerd Hoffmann
 <kraxel@redhat.com>, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, "Kim, Dongwon" <dongwon.kim@intel.com>
Subject: RE: [PATCH v3 3/6] ui/spice: Submit the gl_draw requests at 60 FPS
 for remote clients
Thread-Topic: [PATCH v3 3/6] ui/spice: Submit the gl_draw requests at 60 FPS
 for remote clients
Thread-Index: AQHbuM24eSj9fwRnfEa29ZK9vJPdnbO6OxqAgADm4wA=
Date: Thu, 1 May 2025 05:44:38 +0000
Message-ID: <IA0PR11MB7185710E1DD0428A417DC227F8822@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20250429060952.59508-1-vivek.kasireddy@intel.com>
 <20250429060952.59508-4-vivek.kasireddy@intel.com>
 <CAJ+F1C+_mDLR1+kwNKBh80QR1xDMttMWKu5_6xO4hL+BV6EQYw@mail.gmail.com>
In-Reply-To: <CAJ+F1C+_mDLR1+kwNKBh80QR1xDMttMWKu5_6xO4hL+BV6EQYw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|DS7PR11MB8856:EE_
x-ms-office365-filtering-correlation-id: 5a7e299e-5bfb-4e8f-1c9f-08dd88734359
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SThENTBXR1lLeG9TenRWMkJZWmpqRmxBM0R3YjJtMHhSWXBuMFlZRk10UkhC?=
 =?utf-8?B?eTR5UG1uY0FBZG5hYW00Y3VVQ1kwQWVKK1B1QUlJNzdKbzlxOENBdGVpbW9S?=
 =?utf-8?B?MFQ3VnhqQWVJK3dRdnM5emJ3bms1d1p4a2RwMk1qT0dnbGE5NHIrU2h1Sm9F?=
 =?utf-8?B?dGVSbDJmREZReFpPeWFVSGh0U0ZidTV2ZDl6VUd4eHRaSFk2T3JCS3pBS3pR?=
 =?utf-8?B?a2JvOWdTOUREQmxEQVpRa3ovU3pUeFM4MDVkN0ZiN2I0UUxoKyt6Q25RNFd2?=
 =?utf-8?B?MzhDbEttTi9XSTVFTEVaOTU3L3ZBaGp0MEttemZxOTByUm5rUEdIdTg2emRI?=
 =?utf-8?B?SnVSQlEySFRyVmlvN1E5cEdUb1N1TmFLZmlpWUI4UlRPclNJbE5Lc0hreXNk?=
 =?utf-8?B?VTFvQkQvcm9rWVBBREtkVDhZM3pjbkY3akJseW5rNWI1bHI2SlVjK3k5Titw?=
 =?utf-8?B?QUU2clZUQTdQM0w1alBNeGxXM1UzL0tKRktlM3Z3MUJQbG4wenYyQ3NHM2ZN?=
 =?utf-8?B?TkYwWXV3UUdOdUd3THBySW9zL1I5a0ZNSmtEZ2FsTmlFZS9FNTVSZ3pHZ2VZ?=
 =?utf-8?B?RFo2ckRjNlc4VkxtT2ppWWxHSjRQSGVsWGZTbDJVZVRWSVUxQ2NuV01xa2M4?=
 =?utf-8?B?VUZaUzVqVkZva1pxUzdFSCtIUnRqZFM5WjBRUWlYazVmWjF0Z1BXT1RWemg1?=
 =?utf-8?B?amsxTENuSDY1N2FLWm95RUxPOEllZEltUTEwYmFtUUJ2NjhVNllZeS9qeHNo?=
 =?utf-8?B?NUdsZnoxVHZzRmhSbEhGVGF0OFZaZ2Y4RXhNM1VpY1FJT0FwTDdVQmFndEZh?=
 =?utf-8?B?UHVmUHEyazRxb1ZDeWJ0TG5hQnd5ZHVaN0tlaVN5K0VLU0JIclRRZUt0RDQw?=
 =?utf-8?B?ckN1UUZvQS8rQXdKd1dqQ0tYdGJ3Z3d2OHY0QU9uUU4rVzZaM1BENDcxU2Ex?=
 =?utf-8?B?YTdvK2tXRVl2amRCMjBRdDFURlJBNjJtRk1KWTNhckRqM1dsMkNCRVhsVnUy?=
 =?utf-8?B?aUFKYUtZYk42NDQvWTBWSkwyUk5QOGsrUEhGaHY5eUtFSlVLKzZHb3VIWUdS?=
 =?utf-8?B?eUNPTFZkYWI2ZGVRZHNWN0VBZ2RrdXRIRngvOTMvd0VHc1B0VEhvYWVNTXF1?=
 =?utf-8?B?aTh4ZXJCdG5Jd2Y4cVZFbm9VODhpUXdGVmlXNFk0cW5xb3B2L1NXOUhMQ29F?=
 =?utf-8?B?REFvUXdqeXFQRW5rSEVtREhUZGgraE4xTEZCT2NvKzQ2a09Tei9zRXJtZUJq?=
 =?utf-8?B?NDY5eld5UTAwWFJTOENtYiswZUxaUmhkZk5xcnY4UUN0VGFTNEhpejhubEtC?=
 =?utf-8?B?czlKWG41RTFaNERnWVA1bk80N0xFZGhYVkQ4aHArVTVkSXUvbUZHZWNuaXJK?=
 =?utf-8?B?alFYSVp4b3lxV0luUEJXMFVHZ1A5SjZUL2E2OTBXZEtBRVRnb092S2ZBRURX?=
 =?utf-8?B?UVZIendXU0VpRmNVWUVZZU5LMDJEeCs2alRZd2h5bHNxSVc5a1prdDR0bGNW?=
 =?utf-8?B?eGE0WGVBczdFZTFLM29nSzZJUzhISGUyRGtLQk1TaGdlVWMwdUJxcXAreEx0?=
 =?utf-8?B?RmFyZnVjOGI3eUc4OHZwK3Q1aWtWRFdzWXptcFVjRjMzTDBETlNRWmYzYWV0?=
 =?utf-8?B?M090TytzZmNhZ3BiRy9NYlJ3TG1Rci9pVVlqYml3M1pQd2ZUdHNJMW9LZXEz?=
 =?utf-8?B?ZjJOT0dTUlhHbE1kTmZRbUxiL2l1QkNYUWdjcG1ZelB0OC94RWNCK0g1Ni9L?=
 =?utf-8?B?bjhQNWFFSlFzcHoweG5UY1RFMVRabUt1cSt4SUVPQzNuNUVoZGc3RGw1NXdy?=
 =?utf-8?B?cUIvY1RaRkxoczhhZUJON3JyZXVZSWJoc1oyUVd3N0NmcFZqMGhYT0JMWTdE?=
 =?utf-8?B?ZUhaajdFcytMU0EwM2VOSi9sL205SW5hNWZhRmU2d014WEdXcUlRNWFjT2ZR?=
 =?utf-8?B?V21QRzNrWTRDcHVhMFlqRDN4ODFzVkQ1d3k5RHA4NERuQjA2blI5LzhSeUFN?=
 =?utf-8?Q?7Pgj8PmHqLLg3BFwLIeTRNkx3rZonA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWIxTWMwMnZTeHpPSjVnL2I4SndoWDIrLzVxdWo0dGovQk03OXVFMkQ4TUFL?=
 =?utf-8?B?blBmUFEvTFJLZDd5emxYQ1pLYXViOXhoVG9hKyswc0dEMVJXdURjcXZpREtm?=
 =?utf-8?B?cml2dWRxTFd0S3hDT25GenB5NzZHYWRwSzArRnUrUXBGeWMxK2RSQXZqcW1H?=
 =?utf-8?B?Z3dhR3NVY2lwUEJoZUtTaDMzaXBXS1JFT0ZaVkRRa1RXVFhVMVlPc2ZqcUky?=
 =?utf-8?B?TGpRQVRMWDdhdS9nMkpXNk9KSHZjdzdieVkrM1NMR2Q0bHhQcUlHTnVVcnR6?=
 =?utf-8?B?aE5wZTk4dnJVL0ZjNjh2ZHZJL1RuLzJjbis5bWdxQmxXb2srT0tCL1AxeXdK?=
 =?utf-8?B?SHRiQ200eWE3TTVkT1A4eUM2aldhdzVLWHdsMEFXQ1Bvc3EzbTkwbmFPck04?=
 =?utf-8?B?ODllVkJhVHRkRWNjMXhhV25CRDJvdE03Yk5kOTJJcDNzYlhEdGlNRGlPaVVH?=
 =?utf-8?B?NFNHT3llMTVSRDdSaXVsY1FCR2JiemlIZERYOXJwUkhiWHhPSlJ4dWhlVlNH?=
 =?utf-8?B?MUpPeHhtd2NKMlVyYi8wRmVqdkYreEsvMmQ4c0M1cnNrdE00dVRJVDZLRXdo?=
 =?utf-8?B?U3o1YWE1K0NlOVlSOXlSZUxncExPTjRLQkVubFk0bldTSW1WY2NWbTBDdXRE?=
 =?utf-8?B?eGdkQjZ5RVZEZ2dLV2Q3VitzdkVzQjZxK0VHL2ZYcTREZ1pkbDlYRVVTN3pH?=
 =?utf-8?B?dlF1eVd0bHNCQy9aaHNuNng4YjJjR1MwTjBDTzExNG9QeFBJNDkxUHAyRk52?=
 =?utf-8?B?YnRLa2pLdDhmRXhJcnk4WXJ3WnJzb0toUDA0TnJoQzI3Z1hZWUd3T3huWmNM?=
 =?utf-8?B?dW5JeG1XSmJFRkQyNWhWR1kzWEZRNG45YmhWSXY4NEZVSndEWmZLRUU0UWQw?=
 =?utf-8?B?WTNlUEZERFhmM3B1Zzh1YlVGc0srcFF4RmRUYWpyWkJZMDVweE44cXZ1aEVp?=
 =?utf-8?B?OHZiTjFTZzlnall6dm5hRE9QSWY5OVNSbjFId0dPWlpUU2F0ZEszQWRyQ0lC?=
 =?utf-8?B?M3U0YnN3bmYrdEFKZjc1UnhFNnc4Z1NOMU1pNUxvSXZlbFNqa2ZzVEFHQ2FU?=
 =?utf-8?B?S05oRndNOFMzb24xd1BlOHVhRElub3AxV0dhaUhEeGJ0anhFN2NWUWlBbzFJ?=
 =?utf-8?B?WGhOYXhOVi83QXVnNVZQZGJPeFlzazZ1ayswRS9Oc01GUFU0SW5wVjNZMWRq?=
 =?utf-8?B?bEtyY1Nhd2lEQUJsYi9vNTUyUG9BTk9nb3J2VGkxeDM0R1pONlpDM1AwWll3?=
 =?utf-8?B?Q2RvYnFqVUUrdmZJT0lLK3hYdG9aSEh3dXYrUzZvZWE5dDcvOGdMMkZ0c3RX?=
 =?utf-8?B?Sk1KVnJoY1gzdW8zSDc3bTlwMGVDOHVVSzlWNXFPNkxIOGVnMENuNWNORXpC?=
 =?utf-8?B?S3gzMkpTd0twWWh4dnVoeGlxcXB1MU9YOWcwUDluUW9YeEdZdFlLNEF4WXB3?=
 =?utf-8?B?d2xmcmpCa2Y1dmM3ZHZGNEFLa2Fvbzh4SVJKQUxFZU04TUpuVCtpU1dyVitz?=
 =?utf-8?B?QlRNa1Fzd1ROM2xYUHJEbjVrNjl1U2h4WUc0QU5iRTRTMzNud2pvaEtwV2Ey?=
 =?utf-8?B?Q0RDczZ1K2pLS1lycUpRRWhHNkhKMWx5RVlwQzBIRGRDbGhWbHBDTk9vcFBt?=
 =?utf-8?B?ZWFkc3F5dUxJTHNYak1CK09qMEZyM3NBdmg5ZlljdkdkZjB6SENEMmNvSEJu?=
 =?utf-8?B?czdTRmpIaUkxeXdBSUFESHhPa0R4eUQ5UmlwR01henBQSnI1bzVTZFYwTXoy?=
 =?utf-8?B?OStYQUo2YzVoeTJnMGtoQWNzeWVFUG5yWHo2TGRUL3k1ZjJyT29Zak1RUGFL?=
 =?utf-8?B?UTUzZXNOc2lFUzM3eEh4aEdDMzZiS3lOMXYxVlY4THNhb3doRzNOckNvbWYv?=
 =?utf-8?B?dnJhWDVIWGh6akpueG11U0pWbDM3UzdJaG94TG4xbWZUYlhSOGRRajFmZ2NN?=
 =?utf-8?B?WFJZdmp1QWo3Rzd0MDlsN09rQ0t1OEMvTG5BYk1JeEZwdjBLVU1qSkViOU82?=
 =?utf-8?B?SUhaZTNmRSsrMTZrM0tRdXpwaUk4S0tvRDJTajdNR09OMjQyN05BU01jMnBZ?=
 =?utf-8?B?dGdTOElSTHl5SzRNTXd4VXU3ZU9PUVJNS1Z5MENtOVpCNTI5RkE2L21zNVNq?=
 =?utf-8?Q?B1A5wMUaXndXe4Q0eVVXiWXfj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7e299e-5bfb-4e8f-1c9f-08dd88734359
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2025 05:44:38.8700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qXGWKoO9VhKIY7uagKd+Um57DDwxvqGa5RnI3hrAZe6kFLnXIjIn9J89RFRsZi+f9Yg0uqB3YVIjXdR/0sjDzmiHzuxjB/hRGuGdNWdyi2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8856
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

SGkgTWFyYy1BbmRyZSwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDMvNl0gdWkvc3BpY2U6
IFN1Ym1pdCB0aGUgZ2xfZHJhdyByZXF1ZXN0cyBhdCA2MCBGUFMNCj4gZm9yIHJlbW90ZSBjbGll
bnRzDQo+IA0KPiBIaSBWaXZlaw0KPiANCj4gT24gVHVlLCBBcHIgMjksIDIwMjUgYXQgMTA6MTni
gK9BTSBWaXZlayBLYXNpcmVkZHkNCj4gPHZpdmVrLmthc2lyZWRkeUBpbnRlbC5jb20+IHdyb3Rl
Og0KPiA+DQo+ID4gSW4gdGhlIHNwZWNpZmljIGNhc2Ugd2hlcmUgdGhlIGRpc3BsYXkgbGF5ZXIg
KHZpcnRpby1ncHUpIGlzIHVzaW5nDQo+ID4gZG1hYnVmLCBhbmQgaWYgcmVtb3RlIGNsaWVudHMg
YXJlIGVuYWJsZWQgKC1zcGljZSBnbD1vbixwb3J0PXh4eHgpLA0KPiA+IGl0IG1ha2VzIHNlbnNl
IHRvIGxpbWl0IHRoZSBtYXhpbXVtIChzdHJlYW1pbmcpIHJhdGUgdG8gNjAgRlBTDQo+ID4gdXNp
bmcgdGhlIEdVSSB0aW1lci4gVGhpcyBtYXRjaGVzIHRoZSBiZWhhdmlvciBvZiBHVEsgVUkgd2hl
cmUgdGhlDQo+ID4gZGlzcGxheSB1cGRhdGVzIGFyZSBzdWJtaXR0ZWQgYXQgNjAgRlBTIChhc3N1
bWluZyB0aGUgdW5kZXJseWluZw0KPiA+IG1vZGUgaXMgV3hZQDYwKS4NCj4gDQo+IEkgZ3Vlc3Mg
aXQgd291bGQgbWFrZSBzZW5zZSB0byBtYWtlIGl0IGNvbmZpZ3VyYWJsZSwgZm9yIGFueSBVSS9y
ZW1vdGUNCj4gcHJvdG9jb2wuDQpTdXJlLCBJJ2xsIGFkZCBhIG5ldyBwYXJhbWV0ZXIgZm9yIHRo
aXMuDQoNCj4gDQo+IEZvciBzb21lIFVJLCByZWZyZXNoIHJhdGUgaXMgc2V0IHZpYSBkcHlfc2V0
X3VpX2luZm8oKS4gVW5mb3J0dW5hdGVseSwNCj4gbm9uZSBvZiB0aGUgdm5jLCBzcGljZSBvciBk
YnVzIHByb3RvY29scyBwcm92aWRlIHRoZSByZWZyZXNoIHJhdGUuDQpBRkFJVSwgZHB5X3NldF91
aV9pbmZvKCkgc2V0cyB0aGUgcmVmcmVzaCByYXRlIGZvciB0aGUgR3Vlc3QgdXBkYXRlcyBidXQN
CndoYXQgSSBhbSB0cnlpbmcgdG8gZG8gaW4gdGhpcyBwYXRjaCBpcyBpbmNyZWFzZSB0aGUgc3Vi
bWlzc2lvbi91cGRhdGUgcmF0ZQ0KKHRvIEhvc3QpIGZyb20gMzAgRlBTIHRvIDYwIEZQUy4gVGhp
cyBpcyBvbmx5IG5lZWRlZCBmb3Igc3BlY2lmaWMgdXNlLWNhc2VzDQp3aGVyZSB0aGUgdXBkYXRl
IHN1Ym1pc3Npb24gdG8gSG9zdCAoZW5jb2RlIHJlcXVlc3QpIGlzIGRvbmUgZnJvbSB0aGUNCnJl
ZnJlc2ggdGltZXIgY2FsbGJhY2suDQoNCj4gDQo+IEkgd29uZGVyIGlmIGl0IHdvdWxkIG1ha2Ug
c2Vuc2UgdG8gc2V0IGl0IG9uIHRoZSBHUFUuLiBQZXJoYXBzIGENCj4gIm1heC1yZWZyZXNoLXJh
dGUiIGRldmljZSBwcm9wZXJ0eT8NCk5vdCBzdXJlIGlmIGEgZ2VuZXJpYyBvbmUgaXMgbmVlZGVk
IGFzIG5vdCBhbGwgVUlzIGRvIEhvc3Qgc3VibWlzc2lvbg0KKGVuY29kZSBvciBkcmF3KSBmcm9t
IHRoZSByZWZyZXNoIHRpbWVyIGNhbGxiYWNrLg0KDQo+IA0KPiA+DQo+ID4gQ2M6IEdlcmQgSG9m
Zm1hbm4gPGtyYXhlbEByZWRoYXQuY29tPg0KPiA+IENjOiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1h
cmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4NCj4gPiBDYzogRG1pdHJ5IE9zaXBlbmtvIDxkbWl0
cnkub3NpcGVua29AY29sbGFib3JhLmNvbT4NCj4gPiBDYzogRnJlZGlhbm8gWmlnbGlvIDxmcmVk
ZHk3N0BnbWFpbC5jb20+DQo+ID4gQ2M6IERvbmd3b24gS2ltIDxkb25nd29uLmtpbUBpbnRlbC5j
b20+DQo+ID4gU2lnbmVkLW9mZi1ieTogVml2ZWsgS2FzaXJlZGR5IDx2aXZlay5rYXNpcmVkZHlA
aW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICB1aS9zcGljZS1kaXNwbGF5LmMgfCA1MyArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCA0MyBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS91aS9zcGljZS1kaXNwbGF5LmMgYi91aS9zcGljZS1kaXNwbGF5LmMNCj4gPiBpbmRleCBi
ZjRjYWYwZDFiLi4yYzRkYWEwNzA3IDEwMDY0NA0KPiA+IC0tLSBhL3VpL3NwaWNlLWRpc3BsYXku
Yw0KPiA+ICsrKyBiL3VpL3NwaWNlLWRpc3BsYXkuYw0KPiA+IEBAIC04NDIsMTIgKzg0MiwzMiBA
QCBzdGF0aWMgdm9pZCBxZW11X3NwaWNlX2dsX2Jsb2NrX3RpbWVyKHZvaWQNCj4gKm9wYXF1ZSkN
Cj4gPiAgICAgIHdhcm5fcmVwb3J0KCJzcGljZTogbm8gZ2wtZHJhdy1kb25lIHdpdGhpbiBvbmUg
c2Vjb25kIik7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCBzcGljZV9nbF9kcmF3KFNp
bXBsZVNwaWNlRGlzcGxheSAqc3NkLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICB1
aW50MzJfdCB4LCB1aW50MzJfdCB5LCB1aW50MzJfdCB3LCB1aW50MzJfdCBoKQ0KPiA+ICt7DQo+
ID4gKyAgICB1aW50NjRfdCBjb29raWU7DQo+ID4gKw0KPiA+ICsgICAgY29va2llID0NCj4gKHVp
bnRwdHJfdClxeGxfY29va2llX25ldyhRWExfQ09PS0lFX1RZUEVfR0xfRFJBV19ET05FLCAwKTsN
Cj4gPiArICAgIHNwaWNlX3F4bF9nbF9kcmF3X2FzeW5jKCZzc2QtPnF4bCwgeCwgeSwgdywgaCwg
Y29va2llKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIHZvaWQgc3BpY2VfZ2xfcmVmcmVz
aChEaXNwbGF5Q2hhbmdlTGlzdGVuZXIgKmRjbCkNCj4gPiAgew0KPiA+ICAgICAgU2ltcGxlU3Bp
Y2VEaXNwbGF5ICpzc2QgPSBjb250YWluZXJfb2YoZGNsLCBTaW1wbGVTcGljZURpc3BsYXksIGRj
bCk7DQo+ID4gLSAgICB1aW50NjRfdCBjb29raWU7DQo+ID4NCj4gPiAtICAgIGlmICghc3NkLT5k
cyB8fCBxZW11X2NvbnNvbGVfaXNfZ2xfYmxvY2tlZChzc2QtPmRjbC5jb24pKSB7DQo+ID4gKyAg
ICBpZiAoIXNzZC0+ZHMpIHsNCj4gPiArICAgICAgICByZXR1cm47DQo+ID4gKyAgICB9DQo+ID4g
Kw0KPiA+ICsgICAgaWYgKHFlbXVfY29uc29sZV9pc19nbF9ibG9ja2VkKHNzZC0+ZGNsLmNvbikp
IHsNCj4gPiArICAgICAgICBpZiAocmVtb3RlX2NsaWVudCAmJiBzc2QtPmdsX3VwZGF0ZXMgJiYg
c3NkLT5oYXZlX3NjYW5vdXQpIHsNCj4gPiArICAgICAgICAgICAgZ2xGbHVzaCgpOw0KPiA+ICsg
ICAgICAgICAgICBzcGljZV9nbF9kcmF3KHNzZCwgMCwgMCwNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICBzdXJmYWNlX3dpZHRoKHNzZC0+ZHMpLCBzdXJmYWNlX2hlaWdodChzc2QtPmRz
KSk7DQo+ID4gKyAgICAgICAgICAgIHNzZC0+Z2xfdXBkYXRlcyA9IDA7DQo+ID4gKyAgICAgICAg
ICAgIC8qIFRvIHN0cmVhbSBhdCA2MCBGUFMsIHRoZSAoR1VJKSB0aW1lciBkZWxheSBuZWVkcyB0
byBiZSB+MTcgbXMNCj4gKi8NCj4gPiArICAgICAgICAgICAgZGNsLT51cGRhdGVfaW50ZXJ2YWwg
PSAxMDAwIC8gKDIgKg0KPiBHVUlfUkVGUkVTSF9JTlRFUlZBTF9ERUZBVUxUKSArIDE7DQo+IA0K
PiBUaGF0IGV4cHJlc3Npb24gZG9lc24ndCBtYWtlIG11Y2ggc2Vuc2UgdG8gbWUuDQo+IA0KPiAi
dXBkYXRlX2ludGVydmFsIiBpcyBpbiBtcy4gR1VJX1JFRlJFU0hfSU5URVJWQUxfREVGQVVMVCBp
cyAzMG1zLg0KPiAoaW93LCBpdCdzIG5vdCAzMGZwcykNCklJVUMsIHVwZGF0ZV9pbnRlcnZhbCBu
ZWVkcyB0byBiZSB+MTdtcyAoMTYuNjYgdG8gYmUgbW9yZSBhY2N1cmF0ZSkgZm9yIHRoZQ0KcmVm
cmVzaCB0aW1lciBjYWxsYmFjayB0byBnZXQgaW52b2tlZCA2MCB0aW1lcyBwZXIgc2VjLiANCg0K
PiANCj4gSWYgeW91IG5lZWQgNjBmcHMsIGp1c3QgYWRkIGEgbmV3IGNvbnN0YW50L21hY3JvIHZh
bHVlIGluc3RlYWQ/DQpZZWFoLCBJJ2xsIGRvIHRoYXQgYXMgaXQgd291bGQgbWFrZSBpdCBtb3Jl
IGNsZWFyLg0KDQpUaGFua3MsDQpWaXZlaw0KDQo+IA0KPiA+ICsgICAgICAgIH0NCj4gPiAgICAg
ICAgICByZXR1cm47DQo+ID4gICAgICB9DQo+ID4NCj4gPiBAQCAtODU1LDExICs4NzUsOCBAQCBz
dGF0aWMgdm9pZA0KPiBzcGljZV9nbF9yZWZyZXNoKERpc3BsYXlDaGFuZ2VMaXN0ZW5lciAqZGNs
KQ0KPiA+ICAgICAgaWYgKHNzZC0+Z2xfdXBkYXRlcyAmJiBzc2QtPmhhdmVfc3VyZmFjZSkgew0K
PiA+ICAgICAgICAgIHFlbXVfc3BpY2VfZ2xfYmxvY2soc3NkLCB0cnVlKTsNCj4gPiAgICAgICAg
ICBnbEZsdXNoKCk7DQo+ID4gLSAgICAgICAgY29va2llID0NCj4gKHVpbnRwdHJfdClxeGxfY29v
a2llX25ldyhRWExfQ09PS0lFX1RZUEVfR0xfRFJBV19ET05FLCAwKTsNCj4gPiAtICAgICAgICBz
cGljZV9xeGxfZ2xfZHJhd19hc3luYygmc3NkLT5xeGwsIDAsIDAsDQo+ID4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3VyZmFjZV93aWR0aChzc2QtPmRzKSwNCj4gPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzdXJmYWNlX2hlaWdodChzc2QtPmRzKSwNCj4gPiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb29raWUpOw0KPiA+ICsgICAgICAgIHNw
aWNlX2dsX2RyYXcoc3NkLCAwLCAwLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgc3VyZmFj
ZV93aWR0aChzc2QtPmRzKSwgc3VyZmFjZV9oZWlnaHQoc3NkLT5kcykpOw0KPiA+ICAgICAgICAg
IHNzZC0+Z2xfdXBkYXRlcyA9IDA7DQo+ID4gICAgICB9DQo+ID4gIH0NCj4gPiBAQCAtOTI2LDYg
Kzk0MywyMCBAQCBzdGF0aWMgdm9pZA0KPiBxZW11X3NwaWNlX2dsX3NjYW5vdXRfZGlzYWJsZShE
aXNwbGF5Q2hhbmdlTGlzdGVuZXIgKmRjbCkNCj4gPiAgICAgIFNpbXBsZVNwaWNlRGlzcGxheSAq
c3NkID0gY29udGFpbmVyX29mKGRjbCwgU2ltcGxlU3BpY2VEaXNwbGF5LCBkY2wpOw0KPiA+DQo+
ID4gICAgICB0cmFjZV9xZW11X3NwaWNlX2dsX3NjYW5vdXRfZGlzYWJsZShzc2QtPnF4bC5pZCk7
DQo+ID4gKw0KPiA+ICsgICAgLyoNCj4gPiArICAgICAqIFdlIG5lZWQgdG8gY2hlY2sgZm9yIHRo
ZSBjYXNlIG9mICJsb3N0IiB1cGRhdGVzLCB3aGVyZSBhIGdsX2RyYXcNCj4gPiArICAgICAqIHdh
cyBub3Qgc3VibWl0dGVkIGJlY2F1c2UgdGhlIHRpbWVyIGRpZCBub3QgZ2V0IGEgY2hhbmNlIHRv
IHJ1bi4NCj4gPiArICAgICAqIE9uZSBjYXNlIHdoZXJlIHRoaXMgaGFwcGVucyBpcyB3aGVuIHRo
ZSBHdWVzdCBWTSBpcyBnZXR0aW5nDQo+ID4gKyAgICAgKiByZWJvb3RlZC4gSWYgdGhlIGNvbnNv
bGUgaXMgYmxvY2tlZCBpbiB0aGlzIHNpdHVhdGlvbiwgd2UgbmVlZA0KPiA+ICsgICAgICogdG8g
dW5ibG9jayBpdC4gT3RoZXJ3aXNlLCBuZXdlciB1cGRhdGVzIHdvdWxkIG5vdCB0YWtlIGVmZmVj
dC4NCj4gPiArICAgICAqLw0KPiA+ICsgICAgaWYgKHFlbXVfY29uc29sZV9pc19nbF9ibG9ja2Vk
KHNzZC0+ZGNsLmNvbikpIHsNCj4gPiArICAgICAgICBpZiAocmVtb3RlX2NsaWVudCAmJiBzc2Qt
PmdsX3VwZGF0ZXMgJiYgc3NkLT5oYXZlX3NjYW5vdXQpIHsNCj4gPiArICAgICAgICAgICAgc3Nk
LT5nbF91cGRhdGVzID0gMDsNCj4gPiArICAgICAgICAgICAgcWVtdV9zcGljZV9nbF9ibG9jayhz
c2QsIGZhbHNlKTsNCj4gPiArICAgICAgICB9DQo+ID4gKyAgICB9DQo+ID4gICAgICBzcGljZV9x
eGxfZ2xfc2Nhbm91dCgmc3NkLT5xeGwsIC0xLCAwLCAwLCAwLCAwLCBmYWxzZSk7DQo+ID4gICAg
ICBxZW11X3NwaWNlX2dsX21vbml0b3JfY29uZmlnKHNzZCwgMCwgMCwgMCwgMCk7DQo+ID4gICAg
ICBzc2QtPmhhdmVfc3VyZmFjZSA9IGZhbHNlOw0KPiA+IEBAIC0xMDI5LDcgKzEwNjAsNiBAQCBz
dGF0aWMgdm9pZA0KPiBxZW11X3NwaWNlX2dsX3VwZGF0ZShEaXNwbGF5Q2hhbmdlTGlzdGVuZXIg
KmRjbCwNCj4gPiAgICAgIEVHTGludCBzdHJpZGUgPSAwLCBmb3VyY2MgPSAwOw0KPiA+ICAgICAg
Ym9vbCByZW5kZXJfY3Vyc29yID0gZmFsc2U7DQo+ID4gICAgICBib29sIHlfMF90b3AgPSBmYWxz
ZTsgLyogRklYTUUgKi8NCj4gPiAtICAgIHVpbnQ2NF90IGNvb2tpZTsNCj4gPiAgICAgIGludCBm
ZDsNCj4gPiAgICAgIHVpbnQzMl90IHdpZHRoLCBoZWlnaHQsIHRleHR1cmU7DQo+ID4NCj4gPiBA
QCAtMTEwNyw4ICsxMTM3LDExIEBAIHN0YXRpYyB2b2lkDQo+IHFlbXVfc3BpY2VfZ2xfdXBkYXRl
KERpc3BsYXlDaGFuZ2VMaXN0ZW5lciAqZGNsLA0KPiA+ICAgICAgdHJhY2VfcWVtdV9zcGljZV9n
bF91cGRhdGUoc3NkLT5xeGwuaWQsIHcsIGgsIHgsIHkpOw0KPiA+ICAgICAgcWVtdV9zcGljZV9n
bF9ibG9jayhzc2QsIHRydWUpOw0KPiA+ICAgICAgZ2xGbHVzaCgpOw0KPiA+IC0gICAgY29va2ll
ID0NCj4gKHVpbnRwdHJfdClxeGxfY29va2llX25ldyhRWExfQ09PS0lFX1RZUEVfR0xfRFJBV19E
T05FLCAwKTsNCj4gPiAtICAgIHNwaWNlX3F4bF9nbF9kcmF3X2FzeW5jKCZzc2QtPnF4bCwgeCwg
eSwgdywgaCwgY29va2llKTsNCj4gPiArICAgIGlmIChyZW1vdGVfY2xpZW50KSB7DQo+ID4gKyAg
ICAgICAgc3NkLT5nbF91cGRhdGVzKys7DQo+ID4gKyAgICB9IGVsc2Ugew0KPiA+ICsgICAgICAg
IHNwaWNlX2dsX2RyYXcoc3NkLCB4LCB5LCB3LCBoKTsNCj4gPiArICAgIH0NCj4gPiAgfQ0KPiA+
DQo+ID4gIHN0YXRpYyBjb25zdCBEaXNwbGF5Q2hhbmdlTGlzdGVuZXJPcHMgZGlzcGxheV9saXN0
ZW5lcl9nbF9vcHMgPSB7DQo+ID4gLS0NCj4gPiAyLjQ5LjANCj4gPg0KPiA+DQo+IA0KPiANCj4g
LS0NCj4gTWFyYy1BbmRyw6kgTHVyZWF1DQo=

