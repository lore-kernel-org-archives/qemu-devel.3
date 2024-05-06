Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10A8C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 06:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3s76-0001Ac-N0; Mon, 06 May 2024 02:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s3s6I-00010A-D0
 for qemu-devel@nongnu.org; Mon, 06 May 2024 02:45:33 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s3s6D-0000tN-Eq
 for qemu-devel@nongnu.org; Mon, 06 May 2024 02:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714977922; x=1746513922;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=J+YlQkkkUlIbpbcHQ1Y2dG3C85HYkwZYnZef7HXWE+s=;
 b=mcyZyNWIf2FMY3t1n2E79PIr82WZMoj6CZLuAi6ALgW3ezHm99dNuM7A
 B/lsPFfrCNYtABw+hVC2s4HIxq2u2V/YPK7XLqfPtwYKNDqLOhfUiRMQd
 hYPK1K8y+4N4e+iZsZeIOmf13u8sLw1DK6SNDa0GGiGoHn7u3hGltw4pb
 xTDCTBSO2fJEPybcNdskT/DQiNVE1cnqdNW9tkVz7wP0ugX2Ooe7LOugP
 +aRx6YqU+kqM30kkUD5iqmNcqVb/sDeM81Td7UoX6ZTRv7vJA7ET2QKS6
 2Jphu4qvQiJgQUAE6phy6dZNaym9yYYIE4M/56t96nFxBkvcb0Dz3yCwx g==;
X-CSE-ConnectionGUID: DcKDT0W7QzCLmLCGljAoJQ==
X-CSE-MsgGUID: s3gpsgTwTDWflIam9LKp/w==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10833575"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="10833575"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2024 23:45:18 -0700
X-CSE-ConnectionGUID: ZWn7kx8vR52O5S4O4jmw/w==
X-CSE-MsgGUID: 0IUIHZd6RO2oitoYYVKzgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="32871975"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 May 2024 23:45:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 5 May 2024 23:45:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 5 May 2024 23:45:17 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 5 May 2024 23:45:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxl3hKPWF07cqE1+mfuAtz7RbKbSGiSSLzO//e0enJk1ryPPC6sdjrvZINzUUpfZIVOfUW+x6faPnhoa261z0OD5TWvlQ8G2+IXy1u5oP4wGrGDPNglRFvHngObvhIUFpyqxICjlaRb4MrLybY5FChKQh9KuGlhYSVHpcbnzSdMH+AFk4CqzaS/DuDtZwcIyO+7R0j6Er9naXbeHjc4S2aq614bsgp8sZmfNVEDDmftaqUYdf15VM2WmGLt5pDkfEqpEpvWIiQWnlyQkmYD5OblAM1lvZDtPvSO5E00SlEogacqRxnjpX0DKQF52TqhaUeAr6YvdJ5DEKaf7GLcISg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+YlQkkkUlIbpbcHQ1Y2dG3C85HYkwZYnZef7HXWE+s=;
 b=LWKAbkX/L1rEiIizkQwM9XjOSeJLtJMj8mmjjh+z8/Hj0B+6RTsRe09xYjUHtsmrK+SApLh5xn49M1WxlYjNLI+yR5tmY/qDNzpPk+Gg9NAQFk4pS2JbWj8F5C/KpfgKKPobcu55Rq6Ah2pFdirUy+mT0DtuVPXogU/944e6XODJ9QquSQxgncaWx13oQUNVmX96BbT2Y6x8JxgsYiBp5lEU4pv9nCgzEogpj150KHRC1m/AfB8h1f2KXKFWRY7WuLAqSImAd8yCWcNm+DGG2MWgva0LEdPeLL+KhFCjRXC58O7KMw1KaEsajJ6HlsjPSMILsaYOEi01aoPjgzF0jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MN2PR11MB4742.namprd11.prod.outlook.com (2603:10b6:208:26b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 06:45:09 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 06:45:09 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 06/19] range: Introduce range_get_last_bit()
Thread-Topic: [PATCH v3 06/19] range: Introduce range_get_last_bit()
Thread-Index: AQHamgIOvrV76aEjm0SX75m+BoKnwbGAkQuAgAAEJuCAAy4vgIAGCiSw
Date: Mon, 6 May 2024 06:45:09 +0000
Message-ID: <SJ0PR11MB6744BB49E6B5E5A76D980C7A921C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <20240429065046.3688701-7-zhenzhong.duan@intel.com>
 <bc6b71f7-242f-4de4-b440-67689039886a@redhat.com>
 <SJ0PR11MB67440124211B42A33071CAED921A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <e2aa7e67-cda6-4f0b-9289-acb88cf3a624@redhat.com>
In-Reply-To: <e2aa7e67-cda6-4f0b-9289-acb88cf3a624@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MN2PR11MB4742:EE_
x-ms-office365-filtering-correlation-id: 30f95d93-1e24-445c-9fb4-08dc6d981287
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|376005|7416005|1800799015|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?ckROenpaRTFyNlQ0Y2pqeFZCd3dpb3dxbWt3WnpGdEljV2d4RWJtaHE3YWsz?=
 =?utf-8?B?WXRhandEMlJiUXRPZnRvK25WZmpKVTMyL1kxWVJNKzIrZFpCTHQreW9Eelkr?=
 =?utf-8?B?aERoQ3BWWnVqSEFXbHdDdy9LM3pKeXZoTjdvSXRGdDdydlBpREljazg2ZHFZ?=
 =?utf-8?B?a3V1UXJiRXpkUk1qOXAyMVI3c25hOFViRXFMQkpFTElSREF3cnZSK081K3Na?=
 =?utf-8?B?OHcrTHRwU084b1lmZ3E5dTFUQ0NzazZabmtjdDNqSmM0bm83bDJ6NVZNeHVT?=
 =?utf-8?B?NFNPTGc1QjZpMkhIMXNGMWZ2OFE3T2lUZWxKK0VSSnBVeTZ2aGFiaFNLdEtt?=
 =?utf-8?B?ZUh1RWkzNTJVRDZJN3EvY3NOU1dzaGo2aVRaL29JNTlOcEUrWVNxWkFtQ3d4?=
 =?utf-8?B?WkM1cDExMGVCZStpdGs0NnFMdlR3YlFta0kxYUl5Q2ZoN29nOEZQUUpSNVZG?=
 =?utf-8?B?RlpIZ2JSSHppcFdocmp0OENzdkRJTERsc3pkMEJieGpjOVRrUG9DS1FHNFI4?=
 =?utf-8?B?T00vMHQ1OVFwZFR4NmgrYXh1dkRqelhYODBiWk5wams0WkhtanBGUWJOZ2Mw?=
 =?utf-8?B?MTNiTVVTUnR6YzVSRDBwWWhmTUJZWjRZSnREWStJa1VUb2w1eGhOOU5TT2pT?=
 =?utf-8?B?MUpJWnlXRHpQaW1GYVRCNkRqYVlOMzJwMW03Z0s0eUpGTjlmOHlOaE93LzAw?=
 =?utf-8?B?RVc5Zjh6QjhwQmFqSUhoaVdpRUNYU1dFVXpSY1R2TmFHNTNHdk5aU253Szhi?=
 =?utf-8?B?VDVtcE9CT1hWS1RUY3JjejYwTk13dVU0a2hBL0x1L2pqTlhnazd6Q202M01q?=
 =?utf-8?B?T3hWYjg3VFBqN0o1dUpiYkQrMHkrV2EzcVFpYTMyTVpCUFB1NUVJWjU4d3dH?=
 =?utf-8?B?bnNPTjRyVHBPRUhmbjFjbXBFZndQdVpaSnJzaHBZeTRONmFkNFZreUh3Tlk0?=
 =?utf-8?B?aUtjeFNhRTlDMm1DVTJYUGhqNmxUVU1sNW9XNCt2UzQreDJTYS9sZ2tnNXZu?=
 =?utf-8?B?SkJUZWV3NUFYblU3VTdFSlRFZUNzL2RNS2N5T3lOVkppZUxReENER1dJL0t0?=
 =?utf-8?B?dm9TUWE2YjY0dWtJTk1xN1J2Nm9oczJZTnNoUXpteTc1alI3ck9hYWErbTFO?=
 =?utf-8?B?ODQ5am1GV0JmOHJzN0Y2dFJNK3VJV2lxYnpLT05WQ1VEbWdERnpoUEdGMHdm?=
 =?utf-8?B?OG41N3B1aDRaRVpOS2ROcnZuaktKS3gyWGNSeitxMk1HcXI4TkYyS04xS2RJ?=
 =?utf-8?B?REEvRDVVR1U4U0YxRE9wOGl5ZTc2aWI1eXhTRUowV0xwNWFlaGZhVkJpYnJ0?=
 =?utf-8?B?M0VrVW5LTnhjT1VVWlE4Z3QvZWdPZWdaRXByVVBCaXF6QlF1WHdyKzRvNW8y?=
 =?utf-8?B?ZmVzbDZ4RkJKd01lSk5qa3JmczBRWm1tOGYrd3NrSHJUOHd1aVVHbFpIU3lU?=
 =?utf-8?B?bVBTU29lWmNrUDMwOVRBdFAweFIwVkFyOU9tdEplZXRxVGVBUXA4UTRwcVIz?=
 =?utf-8?B?YTk2emlSSlF5UTY4MVkrMzNUZGpOY21rVEp4bXZvc004dk8xSmlvYWtucTBV?=
 =?utf-8?B?VFRHbkZmUnY4dzdWQk1PSHFVWThidmwwQmJmUlZ4akRhb01YYWhoSmhTbnd3?=
 =?utf-8?B?ZnZ2bVQ5ZUhWaFc1clpLODI1N1JQY1FmK1JsNWpiSlVNT3VIV2gvdW9sU1p1?=
 =?utf-8?B?OXNweHIrK0FMNytzd1JNK0JNR1pxSzllZUZkQUpnbUV3WmhsRnR6b2hadTN4?=
 =?utf-8?B?S2RHcjVoWXRGNExCOFlxUXlPc2o0UmRya1R5UU1ZbDhuN3JmUG91bWt4R1hD?=
 =?utf-8?B?OURXWllkUm5EamhsYjdUdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUJoMjM5K1JteVcrTVNtSEJzYWdVOEV5d0JQN3hZTXE4dnlGUndHME1PV2hu?=
 =?utf-8?B?dUtaM2NKV2lIbWhCRFFZRlI1NUJhYVBxakpKdS9tWS92RGhXWHJLNGRVU01X?=
 =?utf-8?B?SklaK0hhR0lhQm5OV2hUTjJaZHVaZ0JKa2VJSDFJaWJGWU1iUWRMeS9pZWZB?=
 =?utf-8?B?TWJPNTFkN2ZBQUJqdFJiQWp6Q0xtT2kzbk5ibWZJdW9sVERyVHpWQlNBMEJw?=
 =?utf-8?B?aE5CUjg0cnVLODhWdkNVQm10U3A0MjQ2WlRGOCtCV2xTQTN4NjlERTZPS2Rv?=
 =?utf-8?B?UmhwSGovSWFMeUw0UTU3NFdwL1dqTVEvUVFabkgrRmZ0clovdjBOSGJhTlg0?=
 =?utf-8?B?K3lkMGZMZGdvZWNqR29XQVAzS1JUcVRMc29YSnBlcTZwcmUybWRjMUlMRS90?=
 =?utf-8?B?dldaVXBmTTY3OXZMaDlkeDdVRlkyNGNwYlRHTjVzSk9Td2tVZDRBOFRTVjJ6?=
 =?utf-8?B?M2laTlZaMnpnQlN4eEYxVXV2bFNpSHZyNEpxVUp2L01LbnBJZ1kzT3lDemxS?=
 =?utf-8?B?VDVPM1FsRGxDRGRuY2NqSkRlaGtVR25TdTdGbzQzeEVzT05YUmh3MjNkSlBm?=
 =?utf-8?B?UlFWZ1M3QU5PWmFtMzNpWmY4emxpTldUUFFieWtLKzBMaFNVQUN3MStCcWI1?=
 =?utf-8?B?ZWxLOFhTUk9HelNrK2JRTjhsb3d4bC9jZ09kQzJ4RWI5Qm9CMGRST1ZHUUxJ?=
 =?utf-8?B?RUtnNDlyUVNoUmF2OE1jcU01cmFjUmVONFc4K2k1SWwrcVNQYXFLaDBnT0g3?=
 =?utf-8?B?ZWV5aWI5YjVKK2F0RnBzdzJtOHdoaVNuZm5qTERIbEdPSUVVNVVXQkdRWVBC?=
 =?utf-8?B?ckFoNFBmRUxLWjlYblNtaUt1M0VmbTBaYXpqVmNxamVJMXJEdnh6R1RiUzdn?=
 =?utf-8?B?bW1CVDBEaDdQbkxwMllTc3N1QkRpUnRGMTNKbVlhWWlQNEFQRldia2ltTEMz?=
 =?utf-8?B?R2NYdVplcmEvWmF0bnM4OTcyM3RiVGp4NEZPWm1jZk0rb0h5d1pVWDNES21h?=
 =?utf-8?B?dnhJTnhJdzJhOXFmNzdabE1NRm1OcG5PdjFkVDF2WGJuejFSZ2hUSG1OL2Uv?=
 =?utf-8?B?L2VQZ2FqcnhMdkY0S1ZJZUpaVTRTVnRPL0NHakZIY2FlYm9Zb0hqbHg1VnVG?=
 =?utf-8?B?V2VFeTRtcmRXdTRoMnovWVF6bWJjaUlUQktzRlhxaDZoK3k5M3hyMmdLYWZJ?=
 =?utf-8?B?K3RYUExPUENUVlRtK0hIMmw3K0IrUDNQdGdDNG8xcXpKNzRSbGhhOW11bWR2?=
 =?utf-8?B?ZEJOOHRnOW9Qcy9iRUxZdVhMek91Njd5Z2dXblg3TmRjblNHTGRyekhFVit1?=
 =?utf-8?B?NkpaZ1U2SzRnWUl2NzByZHYxaFpGZHhxSnYxZ1ZUcGNocU9UTVVmbXdzMXRM?=
 =?utf-8?B?L2hIMlcxZU84czJnTHcxVWxZYkU1YWw3Y2tCSWhlVk1zbHZXUTREWmlXbXdz?=
 =?utf-8?B?WCtDVGUzY254UG1odkcyNitBV2dTQ3o4Rm85SU9OUTV3VitDZ013SUZtWWJs?=
 =?utf-8?B?TWFsd1kzUjhNLy9Oc2F6RVZ5Y1d0cnlCd2t0dUtQcE1KOWZlZ0phdm0wYnpr?=
 =?utf-8?B?SXEzYXE1cGoyZGUwaDdBc3pSYWtMOXM1VG94emhNc1Jscks5WVZwZFZzY29S?=
 =?utf-8?B?VWpuTExIWm9nZVdndHFYYUVqNG5SOFNtbWhkUHFCMnVkeFpQL2Q2eGhuMkRn?=
 =?utf-8?B?bVhyVzF0eTRPMzE2QXhnR0EwOWxtZkxGV2ZVOFFsUmo3RUh3OWdBeHJoaEg2?=
 =?utf-8?B?RDVZU0hxM0VMbG9jWGphaHdLd25mUkRiNmU4T2VyVG9mZ2h0UE5EMXcwTXJu?=
 =?utf-8?B?SGN0YktXYWp1T0VCQmRjNWIxZUtFeTlsaG1pMDhBYStVcHpDcytQYnhiRkpt?=
 =?utf-8?B?SVNYUVkzSVBwOW9BS3NqemN5TkEzZUY5UVV2dExtZk0vVVZmT0VqbFVlY3hp?=
 =?utf-8?B?aTVMdXJpVDMvZkhrK1dIeWJVekJ1MXY2WTZObHpORWUreDdBU3EvdlpaT3lu?=
 =?utf-8?B?a1E1dzY2SStDWWJraE5UdmdPcVRCS0lTZDhyRzYwS0xHdkwvMmVRLzVid09x?=
 =?utf-8?B?RW1LbGVCcmJTR0I0WHZKUXRoc2ovZTNsb0YzRktHSFB6UElyMFVpek4zNlVI?=
 =?utf-8?Q?YW1J4Dq9EA72znYVkhwL59HTh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f95d93-1e24-445c-9fb4-08dc6d981287
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 06:45:09.2988 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yhPuQfjXp8vkeyTAL+H34dBJuth7PzAbDYempBxiU6805unTuBz0imyOAgAtUZpK2N7wJ7ZzOBrBNlLHR5DWuFCAccVLy1YbW0GdgO4ehyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4742
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDA2LzE5XSByYW5nZTog
SW50cm9kdWNlIHJhbmdlX2dldF9sYXN0X2JpdCgpDQo+DQo+T24gNC8zMC8yNCAxMTo1OCwgRHVh
biwgWmhlbnpob25nIHdyb3RlOg0KPj4NCj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4+PiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+Pj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MyAwNi8xOV0gcmFuZ2U6IEludHJvZHVjZSByYW5nZV9nZXRfbGFz
dF9iaXQoKQ0KPj4+DQo+Pj4gT24gNC8yOS8yNCAwODo1MCwgWmhlbnpob25nIER1YW4gd3JvdGU6
DQo+Pj4+IFRoaXMgaGVscGVyIGdldCB0aGUgaGlnaGVzdCAxIGJpdCBwb3NpdGlvbiBvZiB0aGUg
dXBwZXIgYm91bmQuDQo+Pj4+DQo+Pj4+IElmIHRoZSByYW5nZSBpcyBlbXB0eSBvciB1cHBlciBi
b3VuZCBpcyB6ZXJvLCAtMSBpcyByZXR1cm5lZC4NCj4+Pj4NCj4+Pj4gU3VnZ2VzdGVkLWJ5OiBD
w6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFpo
ZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAg
ICBpbmNsdWRlL3FlbXUvcmFuZ2UuaCB8IDExICsrKysrKysrKysrDQo+Pj4+ICAgIDEgZmlsZSBj
aGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L3FlbXUvcmFuZ2UuaCBiL2luY2x1ZGUvcWVtdS9yYW5nZS5oDQo+Pj4+IGluZGV4IDIwNWUxZGE3
NmQuLjhlMDViYzFkOWYgMTAwNjQ0DQo+Pj4+IC0tLSBhL2luY2x1ZGUvcWVtdS9yYW5nZS5oDQo+
Pj4+ICsrKyBiL2luY2x1ZGUvcWVtdS9yYW5nZS5oDQo+Pj4+IEBAIC0yMCw2ICsyMCw4IEBADQo+
Pj4+ICAgICNpZm5kZWYgUUVNVV9SQU5HRV9IDQo+Pj4+ICAgICNkZWZpbmUgUUVNVV9SQU5HRV9I
DQo+Pj4+DQo+Pj4+ICsjaW5jbHVkZSAicWVtdS9iaXRvcHMuaCINCj4+Pj4gKw0KPj4+PiAgICAv
Kg0KPj4+PiAgICAgKiBPcGVyYXRpb25zIG9uIDY0IGJpdCBhZGRyZXNzIHJhbmdlcy4NCj4+Pj4g
ICAgICogTm90ZXM6DQo+Pj4+IEBAIC0yMTcsNiArMjE5LDE1IEBAIHN0YXRpYyBpbmxpbmUgaW50
IHJhbmdlc19vdmVybGFwKHVpbnQ2NF90IGZpcnN0MSwNCj4+PiB1aW50NjRfdCBsZW4xLA0KPj4+
PiAgICAgICAgcmV0dXJuICEobGFzdDIgPCBmaXJzdDEgfHwgbGFzdDEgPCBmaXJzdDIpOw0KPj4+
PiAgICB9DQo+Pj4+DQo+Pj4+ICsvKiBHZXQgaGlnaGVzdCBub24temVybyBiaXQgcG9zaXRpb24g
b2YgYSByYW5nZSAqLw0KPj4+PiArc3RhdGljIGlubGluZSBpbnQgcmFuZ2VfZ2V0X2xhc3RfYml0
KFJhbmdlICpyYW5nZSkNCj4+Pj4gK3sNCj4+Pj4gKyAgICBpZiAocmFuZ2VfaXNfZW1wdHkocmFu
Z2UpIHx8ICFyYW5nZS0+dXBiKSB7DQo+Pj4+ICsgICAgICAgIHJldHVybiAtMTsNCj4+Pj4gKyAg
ICB9DQo+Pj4+ICsgICAgcmV0dXJuIGZpbmRfbGFzdF9iaXQoJnJhbmdlLT51cGIsIHNpemVvZihy
YW5nZS0+dXBiKSk7DQo+Pj4NCj4+PiBUaGlzIGJyZWFrcyBidWlsZHMgb24gMzItYml0IGhvc3Qg
c3lzdGVtcy4NCj4+DQo+PiBPaCwgSSBtaXNzZWQgMzJiaXQgYnVpbGQuIFRoYW5rcywgd2lsbCBm
aXguDQo+DQo+VGhpcyBzaG91bGQgcHJvdmlkZSB0aGUgc2FtZSByZXN1bHQgPw0KPg0KPiAgICAg
cmV0dXJuIDYzIC0gY2x6NjQocmFuZ2UtPnVwYik7DQoNClllcywgSSB0cmllZCAzMmJpdCBhbmQg
NjRiaXQsIGl0IHdvcmtzLiBXaWxsIHVzZSBpdCwgdGhhbmtzIGZvciBzdWdnZXN0aW9uLg0KDQpC
UnMuDQpaaGVuemhvbmcNCg==

