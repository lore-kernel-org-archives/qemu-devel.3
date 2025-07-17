Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CACC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 03:50:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucFcO-0001Ne-IU; Wed, 16 Jul 2025 23:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ucFbq-0000vc-Ur
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 23:48:42 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ucFbp-0001Ss-5k
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 23:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752724118; x=1784260118;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=385RV9yLK7twnjXD5W/U0ZGjGHo1BBbdysVYDUzWW9c=;
 b=Q++RxWDuvespwSX+FUlE2iJDQoGuUKlG41C0u0D4IOOvsRDuaqrJCrek
 pA89mFexTznTZW6YeDF7BlIs5UMNKLf8iAzULoRi0ycJ3zWJtXzqKIhGv
 unUwOML1i25LtcdywderpaH2PPkpwsDDQXZCgBXX62IN5u+0BBapVqion
 Q/tKEoz8HipHMiOiIAY3iT/imSeGabJN5153SW2EmowCAXwqvhmWs6y8T
 z1PNz4dIDc/FzTzPaJ3ScevKE4n1cULaZiTWX2xDQWzUmBQdzo4j6CTF6
 9ZeN4jjh65KCG68S5aMfM5y0AuJf+bBish+MAaRkqRctJ4px9MfSbpZ6h w==;
X-CSE-ConnectionGUID: +EKZiP46Qc67LvhbXISzIA==
X-CSE-MsgGUID: uEeYXB7xSXGpA02/dhxJDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="77524830"
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; d="scan'208";a="77524830"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 20:48:33 -0700
X-CSE-ConnectionGUID: dnkGFC33SXCRlz7vR9IVBA==
X-CSE-MsgGUID: 31aLuNYFRBSLw+efZvv41g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; d="scan'208";a="157753006"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 20:48:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 20:48:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 20:48:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.70)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 20:48:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVyYG6ctf7sQa4b6jAby8B4QHRzXCqRV5bDFY/ojCzRQeuMZd37ltqAiDXdRfsgdLPFPwcBdOh9yLO727IFcwBq16YH8rGpFylLDjGa8CziYxPUC4b41esrd7qvOmmTsfa8auMXW8SC/S4qu07sZkJtVyHRL6w3GwkMbLrAH21WH25Qkzg+Ct95Wr3e4BVHB6mGjwJpvxO7a1GVeoztI+jdbQNFYwxK0669KaD8PheZb9QfolccLSkcubcie7By/9dvI++7CoZk3s1d0egN3Jis1znrvmhkiAmLbiMx7n63vAXeT6ZRKpg8LAxfLKc4iTs8fqGAwBL32NUO84Rv5Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=385RV9yLK7twnjXD5W/U0ZGjGHo1BBbdysVYDUzWW9c=;
 b=pb16hfkP6NDHmOTt83UESUkf4N/oa3sO5/batsWEek7ugVkxZsISDbbQU4gSIXn6q763Lj3gP5zVh4beNzJBoUbB7n5tGjRUvAZMkI7VhjwQN20rfjFyRX6h2KHvk5EkEElK/F79UeNo2Udf0mvCOeug6w1rylQ6eSsVz0ek7rJTkXpol/lMGnS7boPIKRBu9cE/63mAE+CCeKFNSL9zVABGygbvbudSQMajK99Gkg1Vqs73LJ7IJrEO7fo+QRrg9boRJD15gbiNcvF6vIcx6lj1n6wwIGqLhubDPrvw6jJR7jUxbMhtAEOSbSqdynrbMqKX103sbcTYkIQy5wbYjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH7PR11MB8598.namprd11.prod.outlook.com (2603:10b6:510:2fd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Thu, 17 Jul
 2025 03:48:24 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Thu, 17 Jul 2025
 03:48:24 +0000
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
Subject: RE: [PATCH v3 09/20] intel_iommu: Introduce two helpers
 vtd_as_from/to_iommu_pasid_locked
Thread-Topic: [PATCH v3 09/20] intel_iommu: Introduce two helpers
 vtd_as_from/to_iommu_pasid_locked
Thread-Index: AQHb7/hrT9hc11E320avHEWzz4JuKrQ0wWcAgAD50TA=
Date: Thu, 17 Jul 2025 03:48:24 +0000
Message-ID: <IA3PR11MB91367AFE1F1C9470A88FF93E9251A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-10-zhenzhong.duan@intel.com>
 <3f8e0021-9a68-4326-8100-152dfc36cd13@redhat.com>
In-Reply-To: <3f8e0021-9a68-4326-8100-152dfc36cd13@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH7PR11MB8598:EE_
x-ms-office365-filtering-correlation-id: c7ccf473-9679-49b1-cfc1-08ddc4e4c7ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?dFdHNWp6dDVGU0lhaEF3T3RVd0xKY09DNTZ5b0JoK1RzcFZpR0JLY0N5T0lI?=
 =?utf-8?B?cVZYZmwzclFhRWhsb0hNN2dVeStJTTQ2S3RURi9YTXdkdStHcEpXOU1zZVpG?=
 =?utf-8?B?NkZIOGhqa0pNRHdSYW5aVzFNbnc0RXlPLytGQVNrTTRCVW9vbHE2L1BRNTI4?=
 =?utf-8?B?SFF6YlhYUEJ5enF2TE1XaFVENDFONkROb2JPY2JEZFM0V082OUh5YWx1TG5P?=
 =?utf-8?B?U1ZjT1NIUG1ibmJsQ2pGcStXcXoyUmhWazVha01IeE9aeUJBOUlEQXdaWXdt?=
 =?utf-8?B?RUx3ZDF3LytpVi9vVVlVRjVsVStvSk94Q0dJNVU2Q2tpTEQ0V0IvNmJDYStC?=
 =?utf-8?B?R0E3UDBiYkNXUGE4VUxmcDV2WHk2bUsvbHlQWGtmc0JOQlBTRGprbjA0bEh2?=
 =?utf-8?B?SnhmbG5TSEdCMC9ld2ZzNnAxdUo3bW11L0NjcUI3OXlKTDY2U2pxZ3p0Sm9X?=
 =?utf-8?B?bTg0R1VEZ1h6c0lTaU5LbVozRTQ4OGt6YTBnYUxiUWRONG9XMWlIeDlQVUxT?=
 =?utf-8?B?cTRMbHkzQ29aek9LTWhTbjc4eHhlSjduRXdlS2IxRlJLbTIwVSt5NFlIVEhO?=
 =?utf-8?B?RXZxa1BJL1VSY1dwZlpDdGlwSUNDdmxlN1Y3djBlSFhBSXdCbDJyUHg0eUV1?=
 =?utf-8?B?Qm0yRldoaG0zTzQ5Ymc4OHNvaW9GaTdxcnY3VVVvdGg5bWI4bXVITHNUblAr?=
 =?utf-8?B?WnhPZm1peldZWm8vMlhCUllHSlF5djBMcHRRb05qNTlmTnJxbklYTmZJMHNK?=
 =?utf-8?B?QjN4RFIrb2psV3dWS3l0REhMYjRXQ0YyTVFHY2hmNkpyODVmM3d6alJKQVYz?=
 =?utf-8?B?TGh6RU52Tmkxdkh4MXdsV0ptNU5uZ2lxd3FjN1JmQVMvNlc5YWRISFNPek10?=
 =?utf-8?B?TFBMVmNaYnpPUVpsRFlYQkphdFpENncxTG1TTzVML1QzUXpaMVdIYTZ0UHBj?=
 =?utf-8?B?SnRrNldjNUo3cmlLbi9YMGpvVE1XZUVSaTZDZU9PNGZ6SVdYS1NLdnFYZ1JM?=
 =?utf-8?B?bCtEVTRzNGp0NjRSZmlhMVdtUWlnOXJ1WDhENmRSTXZRNUdhWnJaVEZBVkQ4?=
 =?utf-8?B?T0VyUy8rQWloRkR5YnVmejE0N0dIQUkwVE1IS1dYM285M1o1ODhUaTU1QndZ?=
 =?utf-8?B?dzcxaFZBam5UU1RkM0RYM2pjc0N3SGVhbFV2QWlxODNaK3VYLzJWYWROT3lo?=
 =?utf-8?B?czhuM3BFZGhVbmtBSmFWak1lai9HNDVKUVhJaVlpSnNEZ3pidXU0OFlDZldq?=
 =?utf-8?B?a09aQThGL2QzK0phekd2bHljWHc5NzdBR1MwVkR1Um5IQ0FUZ2R0TGpwUFRu?=
 =?utf-8?B?cU01ZzFlWjBQSlh3MC9jNDlHQWh6aCtpY1lXWm4wYjZ1ZUpLODJ1K2t4N3BZ?=
 =?utf-8?B?Ylc2UERMR1Z5M3hOSzRhSkxmQm01dXFTZUF1RGxOM2xtUDVxVU1ZaHhMOTNx?=
 =?utf-8?B?cXloL29rWHNkckV5d1NncUI4bGV1ZjhuOFQrZlhVcDhUQ3FheHo2L2luckFP?=
 =?utf-8?B?TnBLaEdpUVRXN3dBM0hzREp0R1VwY0F1VzdBU3VuWDJ1anV1MTFrM2N2MDNC?=
 =?utf-8?B?SFU4T1VvVXZUNDBOUDVucjJEelNuYU5KRmJEdHBYQUtpUnZvUkgyZzFiUnd0?=
 =?utf-8?B?aHFwdWZDTGttanBZRW5Dek1lV3IxZ3lwUERQZnRCTUpxbUkyOEtMTFNvbUZN?=
 =?utf-8?B?eTF3UlRwWFJWRlhTY3J1c1NNTUUvN3VSUmNhSUFrVUZlRXVSeGZCNmxPV0Vk?=
 =?utf-8?B?UCtsN2QyRDFUcm45aUc0YTRXdWR5TVVBa0NxQ2Vlc0N2dEdESVl1aGRjcnZ1?=
 =?utf-8?B?bzlmb2Q1UHJsZWlEcUNod3dhTzZIZWhyQUFzNXlzM0pRV1g2R2xUMm83WkJM?=
 =?utf-8?B?dENXcndBUExlUkcrS0dBN0ZyQUxaWTdUM2RKWlFObnI3VXIrbHlrL00ySER3?=
 =?utf-8?B?eFhxMXQrbWgydGlpcGc3M01MdEVDQ0xQM2drdm5qV2hTN1dyNjY4N1RwODFJ?=
 =?utf-8?B?V3d5QWNBODN3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWd1SGJmeTRTQ0d6NEhxVERNQWl1QjV1NmtPWWwzYTMzVXY0UXBwVUtxTVJr?=
 =?utf-8?B?MkE2Z2E3YkFRVTU5MWVqdFlSTFRwQWM3T2laSmF4MHU5WjA0U1hVdVdzeHlp?=
 =?utf-8?B?L2ZCejRTUnNqZS93Y0RNbHMwZkJDL2t2WFNYMndFRFJQY0ZFQ3MxcXdkanEz?=
 =?utf-8?B?NnQvZ0R1SUlZajlqSzZiejVrNXBGYWZib1JaeWFaMlFPNGo5bnFISVphS01M?=
 =?utf-8?B?cDR3Y1RtWkd4UWpnT2dlSGtRdk82bldIR0pTR3dzQjVWNFpzVmVYWC9TZzJB?=
 =?utf-8?B?czZVTWF5SXNwOHl6NTdTcHFNNDZ2M2czQ0lsdHJwOHRXeUFKelFvVXJFdWJo?=
 =?utf-8?B?bWpWeXBhQlRZVGNiaFdTQlR2bi9ZUUtCRzNNdTI4THA2dW9qZUc0LzZMTjFh?=
 =?utf-8?B?bWhjTDlPcUhNUlBRcnBKeEdIZXdlV0J6UXJibkVmNGFCYXRYVUU2eUVEcnFz?=
 =?utf-8?B?cURLSWZpUEM3KzVWRXVoT1I4aUVqZXdQQ2VTaGdjTC9WZVVBQVg5cGFBV2Zj?=
 =?utf-8?B?aDE3eVhtYjZjbkJKdCtETktibDFvZVZJNEMwdlFsd1hLNVg4djdvWm8xdkZm?=
 =?utf-8?B?d2p1SUZhUWlCL3QzT3M2dWVrS21MWnBCSGlRSW9aQm5SSk52eHpYcitjWUlv?=
 =?utf-8?B?S0JZTmoxQkZCd2ZvZWk4U0kxOGc5aTVKSGordFZXb2N6dTN4bW9NZ0NoMVBm?=
 =?utf-8?B?U3U3cFZOWjNoeVloMkovNTZLNnpNQjQraWRJU055bnlSQXk1N2xmVzFaTjIy?=
 =?utf-8?B?UGs3ZU5iMnFYR2hRMFFLcVNrbEx4THo0cHpjOEZGVTAva0ZmL0dhMCtpU3Aw?=
 =?utf-8?B?Y29CajlST1ZsRWMwV0RzTjVtY2hiK1B0S1k4TGtmS0Vsb2RnZCtuckUzRG5F?=
 =?utf-8?B?dXBxSkVDQ2Nwem11WUdmUHVGa2FZWnl5UXA2MW1wbGFMY0xpM1dieldWbjRM?=
 =?utf-8?B?RGpWWW52R3dPZUpsZk1GTlJrWm9rMG4xQWFiM25icnd2M0s4NTMycHRROEsz?=
 =?utf-8?B?eXdRc051ZTMvcjlCenpPYUhydW1YeDRuREY2TWc3Q2Z3TW5LZnBTWE5aaW0v?=
 =?utf-8?B?M0czcVc1S1NzZmhVNUtRNGFKSTF6YXZNNE5qajQvMVZGTWJYRDdJUEp1OXRO?=
 =?utf-8?B?Zy93V2ZlNE83eStmZ3NpRnZOM2lzMGZsOXdRZWlRVXViQ3k2dHNFN2EyTXBN?=
 =?utf-8?B?dWoxbjk4MXVReDA2MnUzclBBVTRXL0xicGpNcTNmanlmd1RhdnYvVkxPUjFJ?=
 =?utf-8?B?OFZ1bXluRTdyaHZMNnl1UWc3dUJwQVh3Y3ZIS1FFSGNSOEJjNHE1cGxCS1No?=
 =?utf-8?B?T0dCWmxyWFV3VGkvaWV2am4zRzFFSFFoemlyd3NlMXlKMW1SdDhvRjI4VmV1?=
 =?utf-8?B?VHY5aHlrNWdZOStNZHFEYWxiSU81NW5CWVlnM3lQWmlKbHN2OWxENnNkY1RN?=
 =?utf-8?B?Uzk5OVBWVTRVWEpwK292azBhSHpLK1Mrak9tV2JXb0dFNTQ0am1xODc0UmxC?=
 =?utf-8?B?d0Y5R09RdDk4SitEdEMyeXZkWjZOdjNLcldsWHhQWEJibkpPWUExRnJ1NllF?=
 =?utf-8?B?YnBZWncrY29UNnNHOTZSeGsxK0ZPOWVuR01NQW1Rc0h6NWhBUEl0TG5BWjNi?=
 =?utf-8?B?Z0xXN0ZacTlZUThjMGw0MjZKSnJjWmV3MnorM01zWEJlNDdFQWxOSUN2bTFH?=
 =?utf-8?B?VXRUamJNdHJ4SnNrRGE4Z3RINk9rVVBZZ2ZjczBQRUhsYUJ5ZHF0VG4yL3JS?=
 =?utf-8?B?L2xWWU1wejZzSTY4S3BmczcwOEZBNFZBMUJYUmtST3RvblAwM1BNL2MxN1pB?=
 =?utf-8?B?MmxOazh1VFQrc0hlNHZKNDFsMEVST1VDTkRWYWVQYVlsU1FxSjZqZGdTVmRl?=
 =?utf-8?B?M1JyTmRxaDIwQ2tFMStVRGhlTTBwbEcyWWs1cisveWdmdFF5eTVxcWFURFNZ?=
 =?utf-8?B?VmVtSnVsUGNacWUyL1VHOGZ4WTB0N1FIL1RjTUwzelBaSVI3VE85OVVZK0du?=
 =?utf-8?B?MjVWOHhVY2Raby82VThBVVUyTHBkSGNnMUhJamhhUG5PaDI1R1o5cFpKQk5h?=
 =?utf-8?B?a3h5VTB4VXlFWkZrQVJhOHlQTk51QlJ1N1llM0NIaG1VcUdBamd0K21XdVR5?=
 =?utf-8?Q?T6QV88La+zK3QpTyQ6gLfUqPo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ccf473-9679-49b1-cfc1-08ddc4e4c7ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 03:48:24.2212 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zwkh3Ld1oXFZSFvrKaB0k+TgieO5ID0fMTtp78M0IY452L9n1pMh6WMq63XbfBWMMNcHS7d33CI5I2tx8KuDtP9BfsaByDBJj/bzHXOOJJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8598
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDA5LzIwXSBpbnRlbF9p
b21tdTogSW50cm9kdWNlIHR3byBoZWxwZXJzDQo+dnRkX2FzX2Zyb20vdG9faW9tbXVfcGFzaWRf
bG9ja2VkDQo+DQo+SGkgWmhlbnpob25nLA0KPg0KPk9uIDcvOC8yNSAxOjA1IFBNLCBaaGVuemhv
bmcgRHVhbiB3cm90ZToNCj4+IFBDSSBkZXZpY2Ugc3VwcG9ydHMgdHdvIHJlcXVlc3QgdHlwZXMs
IFJlcXVlc3RzLXdpdGhvdXQtUEFTSUQgYW5kDQo+PiBSZXF1ZXN0cy13aXRoLVBBU0lELiBSZXF1
ZXN0cy13aXRob3V0LVBBU0lEIGRvZXNuJ3QgaW5jbHVkZSBhIFBBU0lEIFRMUA0KPj4gcHJlZml4
LCBJT01NVSBmZXRjaGVzIHJpZF9wYXNpZCBmcm9tIGNvbnRleHQgZW50cnkgYW5kIHVzZSBpdCBh
cyBJT01NVSdzDQo+PiBwYXNpZCB0byBpbmRleCBwYXNpZCB0YWJsZS4NCj4+DQo+PiBTbyB3ZSBu
ZWVkIHRvIHRyYW5zbGF0ZSBiZXR3ZWVuIFBDSSdzIHBhc2lkIGFuZCBJT01NVSdzIHBhc2lkIHNw
ZWNpYWxseQ0KPj4gZm9yIFJlcXVlc3RzLXdpdGhvdXQtUEFTSUQsIGUuZy4sIFBDSV9OT19QQVNJ
RCgtMSkgPC0+IHJpZF9wYXNpZC4NCj4+IEZvciBSZXF1ZXN0cy13aXRoLVBBU0lELCBQQ0kncyBw
YXNpZCBhbmQgSU9NTVUncyBwYXNpZCBhcmUgc2FtZSB2YWx1ZS4NCj4+DQo+PiB2dGRfYXNfZnJv
bV9pb21tdV9wYXNpZF9sb2NrZWQoKSB0cmFuc2xhdGVzIGZyb20gQkRGK2lvbW11X3Bhc2lkIHRv
DQo+dnRkX2FzDQo+PiB3aGljaCBjb250YWlucyBQQ0kncyBwYXNpZCB2dGRfYXMtPnBhc2lkLg0K
Pj4NCj4+IHZ0ZF9hc190b19pb21tdV9wYXNpZF9sb2NrZWQoKSB0cmFuc2xhdGVzIGZyb20gQkRG
K3Z0ZF9hcy0+cGFzaWQgdG8NCj5pb21tdV9wYXNpZC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBa
aGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgaHcv
aTM4Ni9pbnRlbF9pb21tdS5jIHwgNTgNCj4rKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDU4IGluc2VydGlvbnMoKykNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21t
dS5jDQo+PiBpbmRleCAxNWY0MzkzZDZmLi4zOGU3ZjdiN2JlIDEwMDY0NA0KPj4gLS0tIGEvaHcv
aTM4Ni9pbnRlbF9pb21tdS5jDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IEBA
IC0xNjAyLDYgKzE2MDIsNjQgQEAgc3RhdGljIGludA0KPnZ0ZF9kZXZfdG9fY29udGV4dF9lbnRy
eShJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQ4X3QgYnVzX251bSwNCj4+ICAgICAgcmV0dXJuIDA7
DQo+PiAgfQ0KPj4NCj4+ICtzdGF0aWMgaW50IHZ0ZF9hc190b19pb21tdV9wYXNpZF9sb2NrZWQo
VlREQWRkcmVzc1NwYWNlICp2dGRfYXMsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHVpbnQzMl90ICpwYXNpZCkNCj4+ICt7DQo+PiArICAgIFZURENvbnRleHRD
YWNoZUVudHJ5ICpjY19lbnRyeSA9ICZ2dGRfYXMtPmNvbnRleHRfY2FjaGVfZW50cnk7DQo+PiAr
ICAgIEludGVsSU9NTVVTdGF0ZSAqcyA9IHZ0ZF9hcy0+aW9tbXVfc3RhdGU7DQo+PiArICAgIHVp
bnQ4X3QgYnVzX251bSA9IHBjaV9idXNfbnVtKHZ0ZF9hcy0+YnVzKTsNCj4+ICsgICAgdWludDhf
dCBkZXZmbiA9IHZ0ZF9hcy0+ZGV2Zm47DQo+PiArICAgIFZURENvbnRleHRFbnRyeSBjZTsNCj4+
ICsgICAgaW50IHJldDsNCj4+ICsNCj4+ICsgICAgaWYgKGNjX2VudHJ5LT5jb250ZXh0X2NhY2hl
X2dlbiA9PSBzLT5jb250ZXh0X2NhY2hlX2dlbikgew0KPj4gKyAgICAgICAgY2UgPSBjY19lbnRy
eS0+Y29udGV4dF9lbnRyeTsNCj4+ICsgICAgfSBlbHNlIHsNCj4+ICsgICAgICAgIHJldCA9IHZ0
ZF9kZXZfdG9fY29udGV4dF9lbnRyeShzLCBidXNfbnVtLCBkZXZmbiwgJmNlKTsNCj4+ICsgICAg
ICAgIGlmIChyZXQpIHsNCj4+ICsgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPnlvdSBuZWVkIHRv
IHJldHJpZXZlIHRoZSBjZSBvbmx5IGlmIHZ0ZF9hcy0+cGFzaWQuIFNvIHRoaXMgY2FuIGJlIG1v
dmVkDQo+dG8gdGhlIGNvbmRpdGlvbmFsIGJsb2NrIGJlbG93Lg0KDQpHb29kIGlkZWEhIFdpbGwg
ZG8uDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

