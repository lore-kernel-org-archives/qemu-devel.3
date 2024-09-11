Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D3AEE0217
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 08:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soIrp-0006VI-GS; Wed, 11 Sep 2024 04:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1soIrm-0006Jy-WF
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 04:38:23 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1soIrk-0000F6-JS
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 04:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726043901; x=1757579901;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=c6M6OZhAZ9Ausj3PetjGBgqWGPlekX2XH2mL67C19i8=;
 b=T1g46QU6SW3tkk2vrL2G3sLagXv6Gre9Hrun+SHV1sHmpxO4nXsR8rdt
 DJbXmYDXLeFYbGnG9ZXTMP8MtRZH6Lh6BFKcvRtdv17gRqfOa43p3KRMH
 L8lIbs3aI8XsV/BYSbMzJQ7Vb5zFIVb7+/iE2Jo1hrn8lGbjq4tCEpZRk
 eQYNKnYMCxYSJIWORFCgR3D+d52rYR7S7aA/ZOQVGZiGieDb0eZve3SRT
 /8fyIoNhFrGDmBHgcp6+tlTQvLVH85Udp6CRwpuy7wH3s40AfPjnBrjY0
 3qCdCrUnr3yDoEfuedkRX1YM9oB7g/aMc38Q/Nf7W/jPCiUr4/WOhox84 Q==;
X-CSE-ConnectionGUID: dEsudVTORdGPo/E51fkIkg==
X-CSE-MsgGUID: JO9Gw99USRicqjuc++Xv3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="28607184"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; d="scan'208";a="28607184"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2024 01:38:17 -0700
X-CSE-ConnectionGUID: oxEJNilgQ5y//pUFSX35mA==
X-CSE-MsgGUID: 3A6k2OVgRRGlRAQP3lUTuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; d="scan'208";a="71432195"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Sep 2024 01:38:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 01:38:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Sep 2024 01:38:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Sep 2024 01:38:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLI8Fqt8JFlrgex38QuxlEuOHlrcgcpwVkutOmIa549dWWLGlePMldAN9PLdFWvrkrWHS6jxensNul/MbRm2bPX6O5TJgA8GrDbuvnPxf+wp5iaTeb4/m/Hf5jTSoOhzj6Fzvj7lVkxcC32cMDQJ9BlmQLRCMCsCPDvlmLA+xcyzpb04mYEBgrFk0PwD9NVDsLweMzytubZYz3MMQIGaylgH/KrWnbdrz1QCDYzc+4asRRhtDg9UN4gE8H51JD+MpyZmeFaSgY6OuQBEcKabxMIOXJl2gg49aJaAmck0qhbzQn8TPFLnoMn9A8id4SiEMEDnh6etPoPjvd5XpiQ1YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6M6OZhAZ9Ausj3PetjGBgqWGPlekX2XH2mL67C19i8=;
 b=PT+k7qBNFikDkXM6iDkrVrc7oSVRRwsTjbpDqrFpvR7+rjf0+rC5foRiqANWqfKTp6Tc1akCxygELRz26Ba2gMyFgBzhZ1hi8sIVZ6psgmRWkTUHnswggaT3bYb8OYgRc2gOMms5qRoIGMkeT5q+iamLIWgOX1G+3tSUIb5A2JdV6J+fdV2iodDa0IFCRfuT6ILA9bYPEhGytr6TLfApOnsCnPa/hX5fgI6v6vzc2UQq447Jb84eIZDorv4n8z6z9hZbqnjhJIA/rVCTvSqJPrRN4rkOIcFchhlHoYb1SCL2ohECk0gwrd9szZhmcB8Lip8v5IyJ4bPdqgk+7XUQ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB6192.namprd11.prod.outlook.com (2603:10b6:8:a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 08:38:12 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.7939.017; Wed, 11 Sep 2024
 08:38:12 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: RE: [PATCH v3 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Topic: [PATCH v3 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Index: AQHbBAseUq3eerCLFEmnWy8bYeagnLJSHxGAgAAjwBA=
Date: Wed, 11 Sep 2024 08:38:12 +0000
Message-ID: <SJ0PR11MB6744E31BD5BF8AD277650FBD929B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-4-zhenzhong.duan@intel.com>
 <6aa82e5b-1795-4995-a561-0a27bac681c6@eviden.com>
In-Reply-To: <6aa82e5b-1795-4995-a561-0a27bac681c6@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB6192:EE_
x-ms-office365-filtering-correlation-id: 1a4535f3-c1c5-4487-72b5-08dcd23d129d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZzBMMlJtc1hlZGN0MjhKOUpSVmlaajZvM1hXTnBONVdEckd0REZmMklFUUZF?=
 =?utf-8?B?RlVBeXl2empqd0xGMHEzZ3FwcVl1YnpZeVR0SldjdldCeS80dHRBUVJqWllZ?=
 =?utf-8?B?ZEFUYXZNK1c4NDlzRUpNV3pNUCtuTzJhbmVMV1F2cUFzMzJjem54M1l2N1ZK?=
 =?utf-8?B?WTdoeWY3VFFGa0lsaHlMVW5EbHpYcnpSQnBjc3hMQjdIaDBLNWU1TEdBNXln?=
 =?utf-8?B?U0RTNmNGVGZVNU8yOC91bHluRldVb3hVUlRWeHV3VlNXYWpBenZxZElITUFZ?=
 =?utf-8?B?MlFTcXRabHBwajhrdm9BanZxQkJ4MkxiM3dVVWhWN0JjT3ZwT0tZQWp4aVhy?=
 =?utf-8?B?d2kxeFpZV3p6ZEYySEUzSCt0TnlleGJyU0NJclVRanE4T0tNVW4zZ2t2SHVN?=
 =?utf-8?B?NWQ3QlRURkxDSGIxNHlZZnZsaElFSElMTGZQbE1TdGlwNitFdnVBWFYxOUJ1?=
 =?utf-8?B?c0RzeVEweUszTllJVW1aVnlSeXNLKy9DTEdZN25INmFTenU1WU5tUHhFek1V?=
 =?utf-8?B?VHZGTm9rd2tBSkhwRXlFYmdoM2FyUmNqUlpsNzE2OFk2RU5zV1ptVzBWZk4r?=
 =?utf-8?B?QjhDcTR0SHRnVzZmZnNSUnlUb1IrL2VBdUphV1pmcjB4MTNzSks0R3R4NTdV?=
 =?utf-8?B?NVFUUFFSaFZFSnFDYnQwdS9ZYUdxaHJwelU5WGx6VWQ3Nlp0VG9nQWUzeEhn?=
 =?utf-8?B?anhPUmwxU0N4b0JpVnpuZTZnTTR0NVQzcmlYS25SZjYvTVRncHZkd21jRFhq?=
 =?utf-8?B?d0E1bXVmQndtbUo5VUsrdUwwSncwaitXRE1BN2dXL2UvV0hwRkp3RXpaRWdS?=
 =?utf-8?B?MFFDYUxhVXNhS0lxek5xajNqSFVIcjB3L0F2NmUzOVM3a1h2cXEvb1gwNUlo?=
 =?utf-8?B?OEppNmJlaUlvaGNuTE9FK2gwYzJ3a2tjLytXU2NhNTA3TWJSaDA3TzVPd3dv?=
 =?utf-8?B?WkRROS9hcThueElNa1lPY1FzVSs4MEQvRmxPYThkMEZIdGw2N1V1TWVKd05P?=
 =?utf-8?B?MTJHclhhWGVvWmdpU2gzZWZrZldJRXZPSEdNZHJCRXJTbGVJblM0ZUp4bisz?=
 =?utf-8?B?THc3RTgwaHdjMSsrdU10aGNtMUQzcVlCUE56Z2RyYU9CYXdyRE1haUJOZ2lD?=
 =?utf-8?B?K1QwNlJtRFZyRXVOblgzSzJWeFJIeDRNa3lheWxNMzliWmgzVU1ENTdXNWpm?=
 =?utf-8?B?M1BWSWVYV09aaXdHc1hQVUkxL1hmRitvK1ZZR1JKS3dEdmFIWS9zSkpqODRL?=
 =?utf-8?B?OUhjakxuc2N6ZC9jQXFnWk5kNEIySUt0WW1ObmR4cmlYRExZRlJmRUVNWGRO?=
 =?utf-8?B?Nk1mYWprajh0ZU1UbXNVQjNhUzVDNE1hbWdkZWdScVFMUG5weHhXc0pWMEVo?=
 =?utf-8?B?Y0lWWWNtQlVSeUxJTDJHMWJZbGQyZnJrTXJUTzdrOEt6YVlibThMUmpudkJ4?=
 =?utf-8?B?L0p1MDY0Njh0cGRzWlIvWG5KUGFzMTRGeHVaS24zRjZ1ZlpDS2hHUWtBL21q?=
 =?utf-8?B?aTVqWFRVazIxL1QzUDh2cW9BSnNUOTFiUzY0L1cxbFBkS2NFTUNlb0lqV2dP?=
 =?utf-8?B?OUJHTXpES21WQ25wQWNJTUFHWHY0S2ljYW5wQWJZQXZ6MVhEOHJMMkFyTDZl?=
 =?utf-8?B?dXk1ZTRRQkZtNEpuU2dKcndKUTU5NEdyWk1sQWtCSnRmUXRzNkdUT3BSZDI2?=
 =?utf-8?B?NkdnUWF1WmdZcVQvc1htaFV1OEtGdXFJcGZWcTBINUFPblFyUTdRVUFZMlhC?=
 =?utf-8?B?RFczOFlTZVk1MCtiNUhkbE42cDJ4eVg3c3Vwd1N0LzNabHdYSWU0K1A0dHhi?=
 =?utf-8?B?TFVaMmVzRUJ5cjN4NjBLazMxMnp2T2FSc3RNT2VkNVNLVzZmdld3UkJpT0I1?=
 =?utf-8?B?RmxkTFlBazJtdjlrSkpTaWM2UytLMTgwZ2lWTXIvOW81dmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGppQmpBVWdNZFJzVVliMFZCRlRTZlNZSXIwRWlzOUxlanhkMUxPZXRmMDFO?=
 =?utf-8?B?S05HbVI2UmR0V3BSN1J4aWM0QXAzcXFCWDJGSmtFQVU0YTN0L3c0eCtGMVVM?=
 =?utf-8?B?N0pRc3pPckpKMXVCalhzNkNHM3dFNnRlVThkWWF0WlpCMHRreGZNZE1kcEFR?=
 =?utf-8?B?WC9lSzVUeVhYdkxDbXVTckNKaUwxT2ZzT04vYWVYaG42bHZuTVpjNVNrRVNy?=
 =?utf-8?B?U2Yvd0t1djk5UnpTTFMrVEd2bHNuRFd0QnFPejYzOHJ2cVhEUTlYNGhlNGN4?=
 =?utf-8?B?dHB1azI1K29YVURFTmMxdUh5enBubW1YT1FlSFRFY1dFdUxhNG1iaW9NUEFU?=
 =?utf-8?B?UWhSRmZmKzJwckgreVBqclhyU3BIc1oyVWQ5UnlDSnU3T1VjSXg2TUtwSG9C?=
 =?utf-8?B?M0o3ZXlrRk1halBJbWRERjFjb2xrSFhmQjNPemJldW1sMzljbkFSaGwwUThN?=
 =?utf-8?B?SEJmWlBtK1Jyb2xnUFBUMFY2cmRMa0xtc1hRT3RQb0w2Nmx1VVFkWTBoOStp?=
 =?utf-8?B?Zk1UaUxFbGkrczRxM3VKaHk0dm9qdVZlWUx5ZktORTlYMzFLUkpEMDh5dlJQ?=
 =?utf-8?B?YUtCZUZBTXczODcwVzByREN5L1FnTVhNYTY0eHlOSHhUZmxXN09LOS9HRCtq?=
 =?utf-8?B?Z2Q2cm9IUUN3NWZ0MUgyOHV4d241VlVubmswRkw0QVlBYklaM1NqNWo3NHZQ?=
 =?utf-8?B?d1dlcFl2MkNVeTlUVW50cFJuMUpxVVE0cmdaRDZwVFJLaVQyVDFCUkN3QThY?=
 =?utf-8?B?ZTZTWjFpakxUeU9tRG9FSDk4SEJ6cnNmZ1AyNE1iMDdjRG92eW1lRGh0dk5l?=
 =?utf-8?B?dWcrZS82TkFCQ1piemFtTm0zVWVjQ3VXa0I1ekEwQlQ3YmVscHZLc0FIVzEr?=
 =?utf-8?B?Y1dVTnB0TzR6cWdmSXlQeHlFYnJaTitGL3E0ek90VmJ4TlprOVpYTnduQWpD?=
 =?utf-8?B?ZVlubFdjUWhGVnZsNGd0SlpWWmIxTERrV1FYRG82WU52bGl1WmozTUpnWmRT?=
 =?utf-8?B?Yk9UYlUvMDl1ZFI0T2xiVzY2OThOd0xoVVlRcnZpNnNXbGxGbThySkNhdVJu?=
 =?utf-8?B?eU0vK2o0WVVTZXhWZVdsVzJyKytlUGVVTGJ1SnZZSWl4blZLSVg2cmlOZVFQ?=
 =?utf-8?B?WkpwWkFScTVnai93VmNZZzAwRm04eGpDRk8xU1labG5DcDNLUDJqWXl1MmJ5?=
 =?utf-8?B?VjFaTnAxL3RSZWpKNHh1akt0K0JKNGNJcmlFNEtrMG5iSm9ub3lBRGkvTStY?=
 =?utf-8?B?ZVpWS2xZeVdWanZHZmgxK2VmdjlkenNyU3VLY2s2Ti9PanJBVEE3OU9WNElG?=
 =?utf-8?B?UWtxamlUeHl3Rm5oUm95RDRnQXMwdVk1Rm1Bd01VTFFGdm91N1lCbFZoc1dQ?=
 =?utf-8?B?VVZVdWl3TkVxdys3YitNZUxucDd4aEdMNE9QMDM1cnI2b3dHdzEwSVJZY0N5?=
 =?utf-8?B?VXpSbFAvTUhqOEZhUTVLZU14TlpYWGl4YThaVC84UlkzZGxyd0hTOW1MSmlh?=
 =?utf-8?B?cVZLQTRoaUdscVVjbUNrZzNWeUYvSEtiWjhpTlJFb1hMd1plZHh4UHNxR3Mx?=
 =?utf-8?B?dHdPUEdDWE9vUDhtUUZobHNJNDFESW5BTkpYcFArOWpNdHpBNG9XNk05enZh?=
 =?utf-8?B?N3JhenByQStpVXh5ZFVxQm1JOUhEY3R1a3Fpa3pNM2FwSWZXWkhmTVJ1NXlp?=
 =?utf-8?B?b2Q1NERxdDNWS0haclZwdWZMWVVKdVo2cFV4VENsMTBKb0N5MS9uLzRPUGx2?=
 =?utf-8?B?dU1jN1Btd3FWSkdmanY3V0RBaFNLQUM3TjZxaEV5ZmxNUXB3MitBcHVNRytp?=
 =?utf-8?B?YkVSQk5WazZjNk9TV1NPaUo1RjZ0eU5yOENQWjVNWlIwSzRoNjZKa1haNG11?=
 =?utf-8?B?cVFrQXRJQ1N0aFdBZHhDVUhBMnlISHBTME45dlFQSHZ2UHVNVHJ4YVVMMjFL?=
 =?utf-8?B?TU5HUDQ1cGEvVVdPdkx3TStackhzZGl4UmM3TWFhdUszKy9HV2d0TVhiMStn?=
 =?utf-8?B?MHQxOWkwb212VUJ2TEltMEtwZlRHOFlMYks4bGFGVmRJVTI3WTRFYXhCZXU1?=
 =?utf-8?B?azdpMUtpbzFCUTByNmJCTlQwL3lIOWRLbjFISDFXOS9OWll4Q2dEcHgwejBS?=
 =?utf-8?Q?Jy3NabCWmYajOKriKB7YMO4je?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4535f3-c1c5-4487-72b5-08dcd23d129d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 08:38:12.6318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XYFX91rvZmManPsz3Fjy6+y9m2wxKicjVMqgMPr8LWjlCAZIzOrvvWpUyI7fx5HJyRWTBGU3qCxte83zMVtoJ0BgJqQZtydNsZSIaCVjgFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6192
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3ViamVjdDogUmU6IFtQ
QVRDSCB2MyAwMy8xN10gaW50ZWxfaW9tbXU6IEFkZCBhIHBsYWNlaG9sZGVyIHZhcmlhYmxlIGZv
cg0KPnNjYWxhYmxlIG1vZGVybiBtb2RlDQo+DQo+DQo+DQo+T24gMTEvMDkvMjAyNCAwNzoyMiwg
Wmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90
IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3MsIHVubGVzcyB0aGlzDQo+ZW1haWwgY29t
ZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4N
Cj4+DQo+Pg0KPj4gQWRkIGFuIG5ldyBlbGVtZW50IHNjYWxhYmxlX21vZGUgaW4gSW50ZWxJT01N
VVN0YXRlIHRvIG1hcmsgc2NhbGFibGUNCj4+IG1vZGVybiBtb2RlLCB0aGlzIGVsZW1lbnQgd2ls
bCBiZSBleHBvc2VkIGFzIGFuIGludGVsX2lvbW11IHByb3BlcnR5DQo+PiBmaW5hbGx5Lg0KPj4N
Cj4+IEZvciBub3csIGl0J3Mgb25seSBhIHBsYWNlaGhvbGRlciBhbmQgdXNlZCBmb3IgYWRkcmVz
cyB3aWR0aA0KPj4gY29tcGF0aWJpbGl0eSBjaGVjayBhbmQgYmxvY2sgaG9zdCBkZXZpY2UgcGFz
c3Rocm91Z2ggdW50aWwgbmVzdGluZw0KPj4gaXMgc3VwcG9ydGVkLg0KPj4NCj4+IFNpZ25lZC1v
ZmYtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhl
bnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBpbmNs
dWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCB8ICAxICsNCj4+ICAgaHcvaTM4Ni9pbnRlbF9pb21t
dS5jICAgICAgICAgfCAyMiArKysrKysrKysrKysrKysrKystLS0tDQo+PiAgIDIgZmlsZXMgY2hh
bmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj5iL2luY2x1ZGUvaHcvaTM4Ni9pbnRl
bF9pb21tdS5oDQo+PiBpbmRleCAxZWIwNWMyOWZjLi43ODhlZDQyNDc3IDEwMDY0NA0KPj4gLS0t
IGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+ICsrKyBiL2luY2x1ZGUvaHcvaTM4
Ni9pbnRlbF9pb21tdS5oDQo+PiBAQCAtMjYyLDYgKzI2Miw3IEBAIHN0cnVjdCBJbnRlbElPTU1V
U3RhdGUgew0KPj4NCj4+ICAgICAgIGJvb2wgY2FjaGluZ19tb2RlOyAgICAgICAgICAgICAgLyog
Uk8gLSBpcyBjYXAgQ00gZW5hYmxlZD8gKi8NCj4+ICAgICAgIGJvb2wgc2NhbGFibGVfbW9kZTsg
ICAgICAgICAgICAgLyogUk8gLSBpcyBTY2FsYWJsZSBNb2RlIHN1cHBvcnRlZD8gKi8NCj4+ICsg
ICAgYm9vbCBzY2FsYWJsZV9tb2Rlcm47ICAgICAgICAgICAvKiBSTyAtIGlzIG1vZGVybiBTTSBz
dXBwb3J0ZWQ/ICovDQo+PiAgICAgICBib29sIHNub29wX2NvbnRyb2w7ICAgICAgICAgICAgIC8q
IFJPIC0gaXMgU05QIGZpbGVkIHN1cHBvcnRlZD8gKi8NCj4+DQo+PiAgICAgICBkbWFfYWRkcl90
IHJvb3Q7ICAgICAgICAgICAgICAgIC8qIEN1cnJlbnQgcm9vdCB0YWJsZSBwb2ludGVyICovDQo+
PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21t
dS5jDQo+PiBpbmRleCBlMzQ2NWZjMjdkLi41N2MyNGY2N2I0IDEwMDY0NA0KPj4gLS0tIGEvaHcv
aTM4Ni9pbnRlbF9pb21tdS5jDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IEBA
IC0zODcyLDcgKzM4NzIsMTMgQEAgc3RhdGljIGJvb2wgdnRkX2NoZWNrX2hpb2QoSW50ZWxJT01N
VVN0YXRlDQo+KnMsIEhvc3RJT01NVURldmljZSAqaGlvZCwNCj4+ICAgICAgICAgICByZXR1cm4g
ZmFsc2U7DQo+PiAgICAgICB9DQo+Pg0KPj4gLSAgICByZXR1cm4gdHJ1ZTsNCj4+ICsgICAgaWYg
KCFzLT5zY2FsYWJsZV9tb2Rlcm4pIHsNCj4+ICsgICAgICAgIC8qIEFsbCBjaGVja3MgcmVxdWVz
dGVkIGJ5IFZURCBub24tbW9kZXJuIG1vZGUgcGFzcyAqLw0KPj4gKyAgICAgICAgcmV0dXJuIHRy
dWU7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiaG9zdCBkZXZp
Y2UgaXMgdW5zdXBwb3J0ZWQgaW4gc2NhbGFibGUgbW9kZXJuIG1vZGUNCj55ZXQiKTsNCj4+ICsg
ICAgcmV0dXJuIGZhbHNlOw0KPj4gICB9DQo+Pg0KPj4gICBzdGF0aWMgYm9vbCB2dGRfZGV2X3Nl
dF9pb21tdV9kZXZpY2UoUENJQnVzICpidXMsIHZvaWQgKm9wYXF1ZSwgaW50DQo+ZGV2Zm4sDQo+
PiBAQCAtNDI2MiwxNCArNDI2OCwyMiBAQCBzdGF0aWMgYm9vbA0KPnZ0ZF9kZWNpZGVfY29uZmln
KEludGVsSU9NTVVTdGF0ZSAqcywgRXJyb3IgKiplcnJwKQ0KPj4gICAgICAgICAgIH0NCj4+ICAg
ICAgIH0NCj4+DQo+PiAtICAgIC8qIEN1cnJlbnRseSBvbmx5IGFkZHJlc3Mgd2lkdGhzIHN1cHBv
cnRlZCBhcmUgMzkgYW5kIDQ4IGJpdHMgKi8NCj4+ICAgICAgIGlmICgocy0+YXdfYml0cyAhPSBW
VERfSE9TVF9BV18zOUJJVCkgJiYNCj4+IC0gICAgICAgIChzLT5hd19iaXRzICE9IFZURF9IT1NU
X0FXXzQ4QklUKSkgew0KPj4gLSAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiU3VwcG9ydGVkIHZh
bHVlcyBmb3IgYXctYml0cyBhcmU6ICVkLCAlZCIsDQo+PiArICAgICAgICAocy0+YXdfYml0cyAh
PSBWVERfSE9TVF9BV180OEJJVCkgJiYNCj4+ICsgICAgICAgICFzLT5zY2FsYWJsZV9tb2Rlcm4p
IHsNCj4+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwgIiVzIG1vZGU6IHN1cHBvcnRlZCB2YWx1
ZXMgZm9yIGF3LWJpdHMNCj5hcmU6ICVkLCAlZCIsDQo+PiArICAgICAgICAgICAgICAgICAgIHMt
PnNjYWxhYmxlX21vZGUgPyAiU2NhbGFibGUgbGVnYWN5IiA6ICJMZWdhY3kiLA0KPkkgdGhpbmsg
d2Ugc2hvdWxkIGJlIGNvbnNpc3RlbnQgaW4gdGhlIHdheSB3ZSBuYW1lIHRoaW5ncy4NCj5zL1Nj
YWxhYmxlIGxlZ2FjeS9TY2FsYWJsZQ0KDQpXaWxsIGRvLg0KDQo+PiAgICAgICAgICAgICAgICAg
ICAgICBWVERfSE9TVF9BV18zOUJJVCwgVlREX0hPU1RfQVdfNDhCSVQpOw0KPj4gICAgICAgICAg
IHJldHVybiBmYWxzZTsNCj4+ICAgICAgIH0NCj4+DQo+PiArICAgIGlmICgocy0+YXdfYml0cyAh
PSBWVERfSE9TVF9BV180OEJJVCkgJiYgcy0+c2NhbGFibGVfbW9kZXJuKSB7DQo+PiArICAgICAg
ICBlcnJvcl9zZXRnKGVycnAsDQo+PiArICAgICAgICAgICAgICAgICAgICJTY2FsYWJsZSBtb2Rl
cm4gbW9kZTogc3VwcG9ydGVkIHZhbHVlcyBmb3IgYXctYml0cyBpczogJWQiLA0KPj4gKyAgICAg
ICAgICAgICAgICAgICBWVERfSE9TVF9BV180OEJJVCk7DQo+PiArICAgICAgICByZXR1cm4gZmFs
c2U7DQo+PiArICAgIH0NCj4+ICsNCj5JbiBib3RoIGNvbmRpdGlvbnMsIEkgd291bGQgcmF0aGVy
IHRlc3QgdGhlIG1vZGUgZmlyc3QgdG8gbWFrZSB0aGUNCj5pbnRlbnRpb24gY2xlYXJlci4NCj5G
b3IgaW5zdGFuY2UsDQo+DQo+KHMtPmF3X2JpdHMgIT0gVlREX0hPU1RfQVdfNDhCSVQpICYmIHMt
PnNjYWxhYmxlX21vZGVybg0KPg0KPndvdWxkIGJlY29tZQ0KPg0KPnMtPnNjYWxhYmxlX21vZGVy
biAmJiAocy0+YXdfYml0cyAhPSBWVERfSE9TVF9BV180OEJJVCkNCg0KU3VyZSwgd2lsbCBkby4N
Cg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPg0KPkFwYXJ0IGZyb20gdGhlc2UgbWlub3IgY29tbWVu
dHMsIHRoZSBwYXRjaCBsb29rcyBnb29kIHRvIG1lDQo+DQo+PiAgICAgICBpZiAocy0+c2NhbGFi
bGVfbW9kZSAmJiAhcy0+ZG1hX2RyYWluKSB7DQo+PiAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJw
LCAiTmVlZCB0byBzZXQgZG1hX2RyYWluIGZvciBzY2FsYWJsZSBtb2RlIik7DQo+PiAgICAgICAg
ICAgcmV0dXJuIGZhbHNlOw0KPj4gLS0NCj4+IDIuMzQuMQ0KPj4NCg==

