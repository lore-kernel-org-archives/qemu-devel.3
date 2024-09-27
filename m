Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4DECEBF80
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 08:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su5vo-0002Ek-KU; Fri, 27 Sep 2024 04:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1su5vm-0002ED-QK
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 04:02:26 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1su5vi-0008Fe-Bd
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 04:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727424142; x=1758960142;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KlphtwijVdulJZ5aL1Y+RC2ZUscPfQXaAlGJY+Uyt4Q=;
 b=Xqh+ZF4YrlFAM84pADGJTnPdH6oeyDewJyDJ+cgjwDAB2XgV8LREet1y
 6XfvB1XxlR2akT1HaBVRC9OpbZcxVG9Kxr1uqIY08eedG0fSLnngEMpie
 Zm64BM0+Mum74AVX9aoRFVU7FfE36643VU/Xwcq7d+LyZBZZJwX+5GvpJ
 r3DvxK0Qs4q3pUUuM067YaoCkH2Olf9qNnxKckv9bB8+UGUCyLPpOnQ1M
 7TsNk4d+xFxY9hCBCitgynAcgtXO72+k66Wu9DoWgwzv4OhK4Bp0ij0zG
 2ViXYzDD/1xon2J1TfBQcYkAHy9DjtDm4nlsE9UiDP+ReEGROwYd23ZtT A==;
X-CSE-ConnectionGUID: U7RCfDoATbKvnV4LCc+LiA==
X-CSE-MsgGUID: F6i7Bm8iS/6e5JxVnxPIbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="44028772"
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; d="scan'208";a="44028772"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2024 01:02:19 -0700
X-CSE-ConnectionGUID: oMsJI8BsQTyTcNRlCYT/Sw==
X-CSE-MsgGUID: s2nbN0vWQeCkiGfQrXsNVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; d="scan'208";a="72545522"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Sep 2024 01:02:14 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 01:02:13 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 01:02:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 01:02:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 27 Sep 2024 01:02:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 27 Sep 2024 01:02:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+MkP9RYeOoGPDCf+sz7a/L7Ybx6U9Li/IdDEZhKbZVQH7EbUy4ZySeBEo8ZQzpy5mDT//z8XaUAhZjiwjayy9vsWrXIwNz5grRba/pJnSpIZDseseo33V5Vv8cD9ZFZNrTEAVtK9RGSjzWFiLZg7hNZDO+fMlo7SZ0o6/y24NS8rl+loLyzJldsiBaQjS+Lfs5uFp/t9zaF0Sdpuu4natUDMf/Vfj91YXK9AYSAV6dGI4KAyBq01Wb5Ka22hX6jDkUDoTGaUJqNcd209Y2UXkA3oGH6spwEzAF19duoUaE14AIjSBHTTJuTy4sooemOY6/3S0X/wczqDVhMUeoBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlphtwijVdulJZ5aL1Y+RC2ZUscPfQXaAlGJY+Uyt4Q=;
 b=ajU+Yb80a+xEtP/ojaXTLXmbYhxjxM86k7iNu5hmZD8aVTkD76fvZgTgjXrpJ7WhBJYvQEGnqHF3xF8gvZMNKxsJ8yaE2QVxQBHxbt0jIcMZzcYnfh2ZMFgYeJXY6ACljfxgL6qSWuUAyalxmt/yarNbooWS7zpzdbTQE4sJTDUCIUdjHx2rxy0kXYsDNqm0ScrVmbGWk14Guip4Y2hax761QBwu6W5dpWFabwOh6LwYRWVWwSBR1qh03jYpSlhPez/nQ4Vx4cFdGOvwwsgY/KXSlECOJfnD5cV6anB4UoepOo3f2AaDXpI4TwlcByT+u8C4cadXpK2LoDMgsyQ7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY8PR11MB7948.namprd11.prod.outlook.com (2603:10b6:930:7f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Fri, 27 Sep
 2024 08:02:10 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 08:02:09 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Wang <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v3 12/17] intel_iommu: Add support for PASID-based device
 IOTLB invalidation
Thread-Topic: [PATCH v3 12/17] intel_iommu: Add support for PASID-based device
 IOTLB invalidation
Thread-Index: AQHbBAs7dSCINsfvkEGytF87b/oqprJrHaMAgAAom3CAABfbgA==
Date: Fri, 27 Sep 2024 08:02:09 +0000
Message-ID: <SJ0PR11MB6744628E336FDDD2BDD766EE926B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-13-zhenzhong.duan@intel.com>
 <CACGkMEscZB9f6toOcm_+3pQknDgnp3r6MvzbejB9BVEsKz7rjA@mail.gmail.com>
 <SJ0PR11MB67441D158F394CE1EA620CA9926B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB67441D158F394CE1EA620CA9926B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY8PR11MB7948:EE_
x-ms-office365-filtering-correlation-id: 37d5ef36-10bc-4ca5-0464-08dcdecaafeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?RmVWRFV4WCsxbzRuK2ZXWTV6eXIrQXhzSTdxN01rSXZoZ2NPV0dJZjd3TVYx?=
 =?utf-8?B?a0ptNFdBbzljdjA0a1kxQi9TRVQxejJES0NDTnhYbnNsQVh3YU5iSUNkeGFD?=
 =?utf-8?B?YkxPSys1eWtaWjNqNC9aU1ZSRGVlTld2WDFRZDZENmNoUmlmaTZ5NjNUQldJ?=
 =?utf-8?B?NThaOE1iRW1SbWZKbjFIbXZpdFJmcWxjVTNQMldlV1RGWU9mTmhzTXVRcloy?=
 =?utf-8?B?dk93dkdXK3dxUHNxL0VuZHJsWGlkQkZTQmdaQlJ1RUpDeG9RZ3BGS2cwWGw1?=
 =?utf-8?B?U1VjcFB0aC9PYnVWbDhjbWxTV05JdXlUNVhHbkVxK3hTNTV0RVFESU1sbXRZ?=
 =?utf-8?B?YzNSc2lxbE51RDltTk13NXc0Wk40Si9sN0h2blpVMUtXZTMrZVpzMnVLUUsx?=
 =?utf-8?B?MEJ5cS9OS2gvcFdKRi9EVjkxam1UU0pLcmxiS1VDVnZYS3JyZDZ0ek0wd051?=
 =?utf-8?B?WDNtcFhFSmx0UFVxNzJBUzYxTGlESDl5K3lNWldaQTZOaDZ0MFJFTTJ6VWtM?=
 =?utf-8?B?OHp6d2FZYUdYRk5SRnhhNDI4VUxweEd2OFk4YU9UbUNBaytNSjc0SVJWKzJy?=
 =?utf-8?B?Y1FwSWhnYjRhang1eHpEYnEyKzVWQmJMY0IwVWV0VW1mNmpNVEM3OXhvTUhn?=
 =?utf-8?B?aHZFY1pKSnhUS0FWL1RUa1o1c2VaOE1QRytyR0lwekJKRHM4bTlTN0hzbUZB?=
 =?utf-8?B?bGl3SnoxMmdDb3pONFhuNmR6b3RNRVdRRXR2N2dLKzJremNkbGtqbU5Jd1JW?=
 =?utf-8?B?TjM0MkNUMHF1N3lEWVFiQndNRWZueTVjc0ZXOFQxRU1tT0VPcytleUh3TEh4?=
 =?utf-8?B?aEkvUjdtMFhNVmwvY1d1TzlZWTNtOGxJNmFveTZLZHlWQVVNM3E5OUNZSzF4?=
 =?utf-8?B?VFFEeHUybWNUcmEyYzlIbGx5WS95cWxVN1RYOXl3SWlnUU5xSGJ4WElZT2VH?=
 =?utf-8?B?b205blRldjRkMFBRWGkySWhacmpzSVhqakJCd3lFTlgvWDh3QU8yc1lrMTZj?=
 =?utf-8?B?ZWpnSWJUZ3lhVkx5dytNeGpwYk4vWE1NdXd6dStuMzZGb1czU01kVHBwMW1I?=
 =?utf-8?B?TVBpbkZmVUhBOUxtZUhqNGhXN1BiSXpmZUVuQk5KR1BjUy9YSGtxb0wxcEdJ?=
 =?utf-8?B?bU5RZUlDQkJITEs3ODQwUDFVekdPUjJlYURNWklvMTBuT1NYUTJxeVhHY1Ni?=
 =?utf-8?B?VWlEWlFWaTVySmw0NzZ1VHQzdzMyc3AxcS82MXpxNUJjSEFtSERNajFtY0xL?=
 =?utf-8?B?UkpMTDU1R2tmZWE2eTF2QnJmb2RuZ3hkTjFMR1Q3eGdvVm1QaURZbVIydmJr?=
 =?utf-8?B?ZXdHUEt0WHRVekhxenJrWXVBVVhFejFxSnJCYVBrZ1plc1hXc3FaQ1dxRFNE?=
 =?utf-8?B?Wnk4U1k2YkcxYzhGaGJCM0xsWGlrZysrL2NMY2c5WWpVMDJ0RkNGYUR0K1k1?=
 =?utf-8?B?dE1ZY2k1VUVkYkptQlNsaEZYUmRNQzk2YnB6OUxLSW04dWExRUpHaC9LSEFJ?=
 =?utf-8?B?a3dmcjdUaGhxNmRhd1lnZm1qRGNGWHNUUzM2NHRla3hCaWhROXgxUk1XQ2V5?=
 =?utf-8?B?bkFwNDVhRnhNOVJvOUtNL0tLUFhjM0dhSlhBMmZFNWlML25GTUJXN1llM05p?=
 =?utf-8?B?QzVMeExtWEJ5dVVyNGR0TlNWd0o0Q1BOZEVnNkRlYmszMVhmSmhzTkhCK1Ri?=
 =?utf-8?B?YVcvelhZSGFjNHZlei9zTlYxMzdoKzVNM3hOMnpENTdxcGtNZXhnOXRCZG1E?=
 =?utf-8?B?RXF0NWg0dUNoQ2l2NjZDK0VzTUN5a1JtT2tCSDE3NTUxQVA3eEgxckYrQWRp?=
 =?utf-8?B?YTZoWGhjQVFWeFhGYnkrRU85NmxiOFhrT21HUHpJTEZ5MS9IWVNsYkd3QmdU?=
 =?utf-8?B?aWlLN3E2bE00Q1lZSEZhSGovWkl1ZG1HU3BGbmtLenBOSnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFdhM1BQU0ZZaUNpWjR5S0ZoSDFFWmp1WGI0RVhVZ29kZGdIbElJNEJoS0gr?=
 =?utf-8?B?OXByMEl1N0lLMDlXa1lWV0F0UUk5T0F4Ulp6dE1ncjJWQlBGTmFoZ0Z4amUv?=
 =?utf-8?B?UW5Vais2ZWJmZ0RlQ3hPRWRvd25DZzFzWEhCL0VvYUtnUXdEa0VoUE80dUJV?=
 =?utf-8?B?d3JybXVDOGpRUjM2d0VjNWduZFdDcVBhcVFDT1gvUjJ3Z3FLdDJBb1hIL0pi?=
 =?utf-8?B?NjBpS2pFKzRVamdpUHJqb0ZxdGZDM3loQStZRWF0ekhyeFJ2K3ZFMDdkS2xQ?=
 =?utf-8?B?TEQzaGx4dFB4UUVDcEVTZzFnZWJNdVNNOUM1cmMrOVZWSnFuY0dCa1lpaElK?=
 =?utf-8?B?YVJjRXdpVDJWOWxjaWVUbGx0WkRpdHZONldhMGtldElaU2paQU9vRGFldUVH?=
 =?utf-8?B?Y09UQm0wRWNiWkJNSlFwenFldENVYzdCTWNheVJHdUhybzljWlFxZDZDa09x?=
 =?utf-8?B?ZHU4YUFkbVZUckNleWxGU0dEaVR2VHlWeFB3T1Z3MlpZK2FrTkxPenIwaFJ4?=
 =?utf-8?B?RWYrOVR6VDZ1M25mYTVMTXRGQW9ObXA3ZUkyZmZKN2UyQTlpU0Nlc1ZWdUZU?=
 =?utf-8?B?a21KR1ZWM2k3aU1rWXBHbVBUcGxyNWIreUdVY3pMblhWcENVODRQeVpJWjVJ?=
 =?utf-8?B?LytIQ0NWdWxmRW9kQm82cEVVSDJ3bmZ6S25sUEZHaWxVaFJQNWJSWmdmTTJH?=
 =?utf-8?B?VnNzL0tVTTVIbktlMVY1Y2QxR0MweDRvaFY2U0pYaXFVZVNVcE0yTnNWeWxx?=
 =?utf-8?B?bDg0TWRpL2l4WjNhQUJOV3R0MVRBd3JsV3drbjE4THB0a1VNeUVKdlc5WnJu?=
 =?utf-8?B?NEtaZTVQNEw5RFdmYmVXNWtKNjc1QmxlZU9ramdKYXh2SlBHM0JQYTNQVGND?=
 =?utf-8?B?U0RkZ1lZK3pYbVhWQ2pTWGRWRVNwM3RTVVQvK2dGelRWWEZRRG16MzBPOHZT?=
 =?utf-8?B?TElCUWFFMTFwdFVFaEoraCtJVEZPWktDU2NzMDg1SlhIWWgxeWozTzBsMjFk?=
 =?utf-8?B?QzVFTUNPbGlyOUl4NXM2dExoWXFxWDNOdDZxd05qN1VtZUk1WUpFdHpQTUlu?=
 =?utf-8?B?Unp2QkZPYlgwTHRmUlcrRmdpRi9uQ0ozL0piUyt1N3JKMjFBdTFTM0dGcGUr?=
 =?utf-8?B?RTRLb2EwVWlVRkM5VVQ5eHlTSUJxREJHZExYdFE5NmM0ci8xOGxuRUdBOGJR?=
 =?utf-8?B?OFZrVWZCdit1NXAwbHZkLzc1OXFKaGZRMFNheCtRNzBlYy9zcXovT2huQzhQ?=
 =?utf-8?B?MWt3REpLOS9qZWNTM2RwN0ppTXMrd0ZoSFFEYW4xR1VvTFRrV3dpMEYzWkZJ?=
 =?utf-8?B?Z01weDBpWVFaUUU2c1dOWllWM1BsUU0wMG9iNXd4aUpkUGJIRFE0UWMzVHNm?=
 =?utf-8?B?N2JqMTVEeVZUQVFQenNOUi9lUno1aFI1U3JiNWV5QU56NmcyVVMzTXFtSTBG?=
 =?utf-8?B?OWtMV0dzeTAvckpEVGR6Y1VMalg2RXNDQVVzU041emEvSTB1RTFORjBJay9R?=
 =?utf-8?B?U2RuWktzK3NDYUJJdm91OHJVVHZoaHoyUFJUSFZ4TVVaeXBvTURpRWpoUTdL?=
 =?utf-8?B?Q1JlZ3htVXZBRktmSkd6cE16ZlZ5NmMwZ2hFWVZKTmZKbkhOWm5jenJvS081?=
 =?utf-8?B?NG50LzA5MkNEQUtyUG9wYnFvSEt5WjV2cXk2cTBSVFNBUkN5N0pPcnYzdlh1?=
 =?utf-8?B?THN5ekZNZzc3Y3l2RGxnRVFiNitwN29qTk9CTHVxVkFnNm1xSi9mN1JzenJa?=
 =?utf-8?B?RVdPeDhCQ0FCWTdCc1U3K3hnaVc1b1RBMTlzOVJvRXZMZUlrVE9ZVFdaenN1?=
 =?utf-8?B?bjhjdytBTmI1VW5RQ1dpOGFaYzlSdjBUdWRjVnQvOXZVZWk1cWI5djg2QjlP?=
 =?utf-8?B?bXVyNXNSSjN1YWJCTndxcHBOL2F0R29xZVJvTC9Wd0pPTjMwVHdLemdYUXdp?=
 =?utf-8?B?N3M2ZmFtTzdlUmRWSDR4aEZjK0pCMXozNkVuVHlxclFuakxxcmxTcXRDWGlZ?=
 =?utf-8?B?UVFjTUQ5K2JleXVGMWtuMEtaU1VlY3YzczVlOVRqa3doT3VIRTlDdHdJaDI4?=
 =?utf-8?B?eFdpd1ArcVY1K1dUZlFmRFhSRXUvYUR5VXJtU3dJZkxqRXdCVlEvaEtSSjhR?=
 =?utf-8?Q?5IwMLxLmvXWRnC14z75/jIakc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d5ef36-10bc-4ca5-0464-08dcdecaafeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 08:02:09.5324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fBmNQK6c86awqvvyznShRv/ybt4bTJwJrKyqfAplydwroW+rttP3RO3Zo8ecc+DcMS/PNg8WIWjmzDNEha8Fj2ebiFNH0AuSU4Dyy9SsnAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7948
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IER1YW4sIFpoZW56aG9uZw0K
PlN1YmplY3Q6IFJFOiBbUEFUQ0ggdjMgMTIvMTddIGludGVsX2lvbW11OiBBZGQgc3VwcG9ydCBm
b3IgUEFTSUQtYmFzZWQNCj5kZXZpY2UgSU9UTEIgaW52YWxpZGF0aW9uDQo+DQo+DQo+DQo+Pi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PkZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+DQo+PlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMTIvMTddIGludGVsX2lvbW11OiBB
ZGQgc3VwcG9ydCBmb3IgUEFTSUQtYmFzZWQNCj4+ZGV2aWNlIElPVExCIGludmFsaWRhdGlvbg0K
Pj4NCj4+T24gV2VkLCBTZXAgMTEsIDIwMjQgYXQgMToyN+KAr1BNIFpoZW56aG9uZyBEdWFuDQo+
Pjx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+IHdyb3RlOg0KPj4+DQo+Pj4gRnJvbTogQ2zDqW1l
bnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+Pj4N
Cj4+PiBTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhp
ZXUtLQ0KPmRyaWZAZXZpZGVuLmNvbT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVh
biA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4+IC0tLQ0KPj4+ICBody9pMzg2L2ludGVs
X2lvbW11X2ludGVybmFsLmggfCAxMSArKysrKysrKw0KPj4+ICBody9pMzg2L2ludGVsX2lvbW11
LmMgICAgICAgICAgfCA1MA0KPj4rKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
Pj4gIDIgZmlsZXMgY2hhbmdlZCwgNjEgaW5zZXJ0aW9ucygrKQ0KPj4+DQo+Pj4gZGlmZiAtLWdp
dCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj5iL2h3L2kzODYvaW50ZWxfaW9t
bXVfaW50ZXJuYWwuaA0KPj4+IGluZGV4IDRmMmMzYTkzNTAuLjUyYmRiZjNiYzUgMTAwNjQ0DQo+
Pj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Pj4gKysrIGIvaHcvaTM4
Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Pj4gQEAgLTM3NSw2ICszNzUsNyBAQCB0eXBlZGVm
IHVuaW9uIFZUREludkRlc2MgVlRESW52RGVzYzsNCj4+PiAgI2RlZmluZSBWVERfSU5WX0RFU0Nf
V0FJVCAgICAgICAgICAgICAgIDB4NSAvKiBJbnZhbGlkYXRpb24gV2FpdA0KPkRlc2NyaXB0b3IN
Cj4+Ki8NCj4+PiAgI2RlZmluZSBWVERfSU5WX0RFU0NfUElPVExCICAgICAgICAgICAgIDB4NiAv
KiBQQVNJRC1JT1RMQiBJbnZhbGlkYXRlDQo+RGVzYw0KPj4qLw0KPj4+ICAjZGVmaW5lIFZURF9J
TlZfREVTQ19QQyAgICAgICAgICAgICAgICAgMHg3IC8qIFBBU0lELWNhY2hlIEludmFsaWRhdGUg
RGVzYw0KPiovDQo+Pj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX0RFVl9QSU9UTEIgICAgICAgICAw
eDggLyogUEFTSUQtYmFzZWQtRElPVExCDQo+Pmludl9kZXNjKi8NCj4+PiAgI2RlZmluZSBWVERf
SU5WX0RFU0NfTk9ORSAgICAgICAgICAgICAgIDAgICAvKiBOb3QgYW4gSW52YWxpZGF0ZSBEZXNj
cmlwdG9yDQo+PiovDQo+Pj4NCj4+PiAgLyogTWFza3MgZm9yIEludmFsaWRhdGlvbiBXYWl0IERl
c2NyaXB0b3IqLw0KPj4+IEBAIC00MTMsNiArNDE0LDE2IEBAIHR5cGVkZWYgdW5pb24gVlRESW52
RGVzYyBWVERJbnZEZXNjOw0KPj4+ICAjZGVmaW5lIFZURF9JTlZfREVTQ19ERVZJQ0VfSU9UTEJf
UlNWRF9ISSAweGZmZVVMTA0KPj4+ICAjZGVmaW5lIFZURF9JTlZfREVTQ19ERVZJQ0VfSU9UTEJf
UlNWRF9MTyAweGZmZmYwMDAwZmZlMGZmZjgNCj4+Pg0KPj4+ICsvKiBNYXNrIGZvciBQQVNJRCBE
ZXZpY2UgSU9UTEIgSW52YWxpZGF0ZSBEZXNjcmlwdG9yICovDQo+Pj4gKyNkZWZpbmUgVlREX0lO
Vl9ERVNDX1BBU0lEX0RFVklDRV9JT1RMQl9BRERSKHZhbCkgKCh2YWwpICYgXA0KPj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAweGZmZmZmZmZm
ZmZmZmYwMDBVTEwpDQo+Pj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX1BBU0lEX0RFVklDRV9JT1RM
Ql9TSVpFKHZhbCkgKCh2YWwgPj4gMTEpICYNCj4weDEpDQo+Pj4gKyNkZWZpbmUgVlREX0lOVl9E
RVNDX1BBU0lEX0RFVklDRV9JT1RMQl9HTE9CQUwodmFsKSAoKHZhbCkgJiAweDEpDQo+Pj4gKyNk
ZWZpbmUgVlREX0lOVl9ERVNDX1BBU0lEX0RFVklDRV9JT1RMQl9TSUQodmFsKSAoKCh2YWwpID4+
IDE2KSAmDQo+PjB4ZmZmZlVMTCkNCj4+PiArI2RlZmluZSBWVERfSU5WX0RFU0NfUEFTSURfREVW
SUNFX0lPVExCX1BBU0lEKHZhbCkgKCh2YWwgPj4gMzIpICYNCj4+MHhmZmZmZlVMTCkNCj4+PiAr
I2RlZmluZSBWVERfSU5WX0RFU0NfUEFTSURfREVWSUNFX0lPVExCX1JTVkRfSEkgMHg3ZmVVTEwN
Cj4+PiArI2RlZmluZSBWVERfSU5WX0RFU0NfUEFTSURfREVWSUNFX0lPVExCX1JTVkRfTE8NCj4+
MHhmZmYwMDAwMDAwMDBmMDAwVUxMDQo+Pj4gKw0KPj4+ICAvKiBSc3ZkIGZpZWxkIG1hc2tzIGZv
ciBzcHRlICovDQo+Pj4gICNkZWZpbmUgVlREX1NQVEVfU05QIDB4ODAwVUxMDQo+Pj4NCj4+PiBk
aWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
DQo+Pj4gaW5kZXggZDI4Yzg2MjU5OC4uNGNmNTY5MjRlMSAxMDA2NDQNCj4+PiAtLS0gYS9ody9p
Mzg2L2ludGVsX2lvbW11LmMNCj4+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+PiBA
QCAtMzAxNyw2ICszMDE3LDQ5IEBAIHN0YXRpYyB2b2lkDQo+PmRvX2ludmFsaWRhdGVfZGV2aWNl
X3RsYihWVERBZGRyZXNzU3BhY2UgKnZ0ZF9kZXZfYXMsDQo+Pj4gICAgICBtZW1vcnlfcmVnaW9u
X25vdGlmeV9pb21tdSgmdnRkX2Rldl9hcy0+aW9tbXUsIDAsIGV2ZW50KTsNCj4+PiAgfQ0KPj4+
DQo+Pj4gK3N0YXRpYyBib29sIHZ0ZF9wcm9jZXNzX2RldmljZV9waW90bGJfZGVzYyhJbnRlbElP
TU1VU3RhdGUgKnMsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBWVERJbnZEZXNjICppbnZfZGVzYykNCj4+PiArew0KPj4+ICsgICAgdWludDE2X3Qgc2lk
Ow0KPj4+ICsgICAgVlREQWRkcmVzc1NwYWNlICp2dGRfZGV2X2FzOw0KPj4+ICsgICAgYm9vbCBz
aXplOw0KPj4+ICsgICAgYm9vbCBnbG9iYWw7DQo+Pj4gKyAgICBod2FkZHIgYWRkcjsNCj4+PiAr
ICAgIHVpbnQzMl90IHBhc2lkOw0KPj4+ICsNCj4+PiArICAgIGlmICgoaW52X2Rlc2MtPmhpICYg
VlREX0lOVl9ERVNDX1BBU0lEX0RFVklDRV9JT1RMQl9SU1ZEX0hJKSB8fA0KPj4+ICsgICAgICAg
ICAoaW52X2Rlc2MtPmxvICYgVlREX0lOVl9ERVNDX1BBU0lEX0RFVklDRV9JT1RMQl9SU1ZEX0xP
KSkgew0KPj4+ICsgICAgICAgIGVycm9yX3JlcG9ydF9vbmNlKCIlczogaW52YWxpZCBwYXNpZC1i
YXNlZCBkZXYgaW90bGIgaW52IGRlc2M6Ig0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICJoaT0lIlBSSXg2NCAiKHJlc2VydmVkIG5vbnplcm8pIiwNCj4+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICBfX2Z1bmNfXywgaW52X2Rlc2MtPmhpKTsNCj4+PiArICAgICAgICByZXR1cm4g
ZmFsc2U7DQo+Pj4gKyAgICB9DQo+Pj4gKw0KPj4+ICsgICAgZ2xvYmFsID0gVlREX0lOVl9ERVND
X1BBU0lEX0RFVklDRV9JT1RMQl9HTE9CQUwoaW52X2Rlc2MtPmhpKTsNCj4+PiArICAgIHNpemUg
PSBWVERfSU5WX0RFU0NfUEFTSURfREVWSUNFX0lPVExCX1NJWkUoaW52X2Rlc2MtPmhpKTsNCj4+
PiArICAgIGFkZHIgPSBWVERfSU5WX0RFU0NfUEFTSURfREVWSUNFX0lPVExCX0FERFIoaW52X2Rl
c2MtPmhpKTsNCj4+PiArICAgIHNpZCA9IFZURF9JTlZfREVTQ19QQVNJRF9ERVZJQ0VfSU9UTEJf
U0lEKGludl9kZXNjLT5sbyk7DQo+Pj4gKyAgICBpZiAoZ2xvYmFsKSB7DQo+Pj4gKyAgICAgICAg
UUxJU1RfRk9SRUFDSCh2dGRfZGV2X2FzLCAmcy0+dnRkX2FzX3dpdGhfbm90aWZpZXJzLCBuZXh0
KSB7DQo+Pj4gKyAgICAgICAgICAgIGlmICgodnRkX2Rldl9hcy0+cGFzaWQgIT0gUENJX05PX1BB
U0lEKSAmJg0KPj4+ICsgICAgICAgICAgICAgICAgKFBDSV9CVUlMRF9CREYocGNpX2J1c19udW0o
dnRkX2Rldl9hcy0+YnVzKSwNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHZ0ZF9kZXZfYXMtPmRldmZuKSA9PSBzaWQpKSB7DQo+Pj4gKyAgICAgICAgICAg
ICAgICBkb19pbnZhbGlkYXRlX2RldmljZV90bGIodnRkX2Rldl9hcywgc2l6ZSwgYWRkcik7DQo+
Pj4gKyAgICAgICAgICAgIH0NCj4+PiArICAgICAgICB9DQo+Pj4gKyAgICB9IGVsc2Ugew0KPj4+
ICsgICAgICAgIHBhc2lkID0gVlREX0lOVl9ERVNDX1BBU0lEX0RFVklDRV9JT1RMQl9QQVNJRChp
bnZfZGVzYy0+bG8pOw0KPj4+ICsgICAgICAgIHZ0ZF9kZXZfYXMgPSB2dGRfZ2V0X2FzX2J5X3Np
ZF9hbmRfcGFzaWQocywgc2lkLCBwYXNpZCk7DQo+Pj4gKyAgICAgICAgaWYgKCF2dGRfZGV2X2Fz
KSB7DQo+Pj4gKyAgICAgICAgICAgIHJldHVybiB0cnVlOw0KPj4+ICsgICAgICAgIH0NCj4+PiAr
DQo+Pj4gKyAgICAgICAgZG9faW52YWxpZGF0ZV9kZXZpY2VfdGxiKHZ0ZF9kZXZfYXMsIHNpemUs
IGFkZHIpOw0KPj4NCj4+UXVlc3Rpb246DQo+Pg0KPj5JIHdvbmRlciBpZiBjdXJyZW50IHZob3N0
ICh3aGljaCBoYXMgYSBkZXZpY2UgSU9UTEIgYWJzdHJhY3Rpb24gdmlhDQo+PnZpcnRpby1wY2kp
IGNhbiB3b3JrIHdpdGggdGhpcyAoUEFTSUQgYmFzZWQgSU9UTEIgaW52YWxpZGF0aW9uKQ0KPg0K
PkN1cnJlbnRseSwgaXQgZGVwZW5kcyBvbiBpZiBjYWNoaW5nLW1vZGUgaXMgb24uIElmIGl0J3Mg
b2ZmLCB2aG9zdCB3b3Jrcy4gRS5nLjoNCj4NCj4tZGV2aWNlIGludGVsLWlvbW11LGNhY2hpbmct
bW9kZT1vZmYsZG1hLWRyYWluPW9uLGRldmljZS1pb3RsYj1vbix4LQ0KPnNjYWxhYmxlLW1vZGU9
b24NCj4tbmV0ZGV2IHRhcCxpZD10YXAwLHZob3N0PW9uLHNjcmlwdD0vZXRjL3FlbXUtaWZ1cA0K
Pi1kZXZpY2UgdmlydGlvLW5ldC1wY2ksbmV0ZGV2PXRhcDAsYnVzPXJvb3QwLGlvbW11X3BsYXRm
b3JtPW9uLGF0cz1vbg0KDQpTb3JyeSwgdHlwbyBlcnJvciBvbiBzY2FsYWJsZSBtb2RlIHBhcmFt
ZXRlciwgc2hvdWxkIGJlOg0KDQotZGV2aWNlIGludGVsLWlvbW11LGNhY2hpbmctbW9kZT1vZmYs
ZG1hLWRyYWluPW9uLGRldmljZS1pb3RsYj1vbix4LXNjYWxhYmxlLW1vZGU9bW9kZXJuDQotbmV0
ZGV2IHRhcCxpZD10YXAwLHZob3N0PW9uLHNjcmlwdD0vZXRjL3FlbXUtaWZ1cA0KLWRldmljZSB2
aXJ0aW8tbmV0LXBjaSxuZXRkZXY9dGFwMCxidXM9cm9vdDAsaW9tbXVfcGxhdGZvcm09b24sYXRz
PW9uDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4NCj5JdCBkb2Vzbid0IHdvcmsgY3VycmVudGx5
IHdoZW4gY2FjaGluZy1tb2RlIGlzIG9uLg0KPlJlYXNvbiBpcyBsaW51eCBrZXJuZWwgaGFzIGFu
IG9wdGltaXphdGlvbiB0byBzZW5kIG9ubHkgcGlvdGxiIGludmFsaWRhdGlvbiwNCj5ubyBkZXZp
Y2UtcGlvdGxiIGludmFsaWRhdGlvbiBpcyBzZW50LiBCdXQgSSBoZWFyZCBmcm9tIFlpIHRoZSBv
cHRpbWl6YXRpb24NCj53aWxsIGJlIGRyb3BwZWQsIHRoZW4gaXQgd2lsbCB3b3JrIHRvbyB3aGVu
IGNhY2hpbmctbW9kZSBpcyBvbi4NCj4NCj5UaGFua3MNCj5aaGVuemhvbmcNCg==

