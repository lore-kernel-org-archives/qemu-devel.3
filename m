Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697ABC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 08:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEPhn-0000sC-8V; Tue, 04 Jun 2024 04:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEPhl-0000ro-IJ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:39:41 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEPhj-0004Dl-By
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717490380; x=1749026380;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZfdWI8B5TyJGqaEyIBJNPISVeCoX7FuG6455PreBTgQ=;
 b=eYo10V5q/zp4rlPObO4djn7/pz/2HGXxFvofUatHkZ0DxRXqBMW0ecBB
 DFZ5y8O06NNGoqovzgF+RlAZHUNeW1w73hKJ4sK9iMkytyYFtIlKh5MAL
 NkNJCQJnigDOaMmBonAo6aWvMj+LnmoFyEHKJ9PoNKs7HDcvK3w+0pqoA
 OYU/vMhXd6MOC4rX1ux8LI/sF1q4xJA0BaUqxkam3I7lQzBwFs1FYaQ4E
 a6xXHWieZKTzCPRri5/DmkH/mdIlkPRfxM9nBqSg/lNaXNyEkdJp8a3JN
 D6O7cO748YV+W/836mid0GAI0nyyN3s/wxaKhOVz1oc/jjDzIiqEbpCG+ A==;
X-CSE-ConnectionGUID: 6qJ2ITsDTbKk4cEB4L/Myw==
X-CSE-MsgGUID: 6RausvMPS6qu/qJp5pbnCA==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="17850477"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="17850477"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 01:39:38 -0700
X-CSE-ConnectionGUID: h6ATa5I9T3WW1+Fp/deKmg==
X-CSE-MsgGUID: 8O1XW4zMSVaBA8dBkEGAzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="41629323"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Jun 2024 01:39:37 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 01:39:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 01:39:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 01:39:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKtl3OG7088lyfwb9o4u1mm/SOvshvhmt3PtEI4B5vZp2kZa7ns/WCcED+KJjgiXNkxUvYUqbQcVR09HEioubco346z6paMn+RgIFdEiXrHFdQaB//KbkBpHPM1JT1kfAEfgwIXi5lgW9yJP2OhSa8+F6LKYA3GZcHSgSG5baCgCr5lMpiN5xhjCkv2z38X6SeecFZF3G355spHXfXg0jc4/6sWXmmlsF0FCaq63nx8jgSKLjeaNVjeVEKlOpmGyQOj5oJIHS0RdRYjUwHHzWKInSELg3ebOc8OajZz0flEeC93HBr0RgGjVmh7thUtNYBBHr4qk9cVdSQc1lT4hvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfdWI8B5TyJGqaEyIBJNPISVeCoX7FuG6455PreBTgQ=;
 b=XP4LT3GFoEPXtWQODQDFEulOpJY1olXTKxGbkr3GdvByXTujKqX15iH/d2TQoIQrjtg2Lz1C1TO1n2Lyxz6Kbe6Gm9+tCs2gWtcMGnMlrvCu1mgvbzioCk6q+iN902f4H3SvTF462bNxWnr47+tV9GH6U2wQNhmDGJDmCU0pEZjI33qvm1FmSX0aISOYBjHvyEdgjx2/Ix3eAzJIZX0WfvfcbVI3TES9rO13b42S6V86EhE6tPfXqEdmVx78RRq3pv4CGa2Dowe1x16SydwPWDyCpWxZwN4Xa7renRFVict+CcI0CIVAYad/1xV9ms6+RypNUrjfA5aeHvutIcmkeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CO1PR11MB4770.namprd11.prod.outlook.com (2603:10b6:303:94::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Tue, 4 Jun
 2024 08:39:34 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 08:39:34 +0000
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
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v6 09/19] vfio/iommufd: Implement
 HostIOMMUDeviceClass::realize() handler
Thread-Topic: [PATCH v6 09/19] vfio/iommufd: Implement
 HostIOMMUDeviceClass::realize() handler
Thread-Index: AQHatX026AiY+etA/U+I5iKUsGNWX7G16AIAgAEAAYCAAE9NAIAAAqHggAAH7QCAAAg9oA==
Date: Tue, 4 Jun 2024 08:39:34 +0000
Message-ID: <SJ0PR11MB674403142BE0A7FE3142D38492F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-10-zhenzhong.duan@intel.com>
 <e20c3fce-5a5a-4efb-9383-9ed7c9c6ef32@redhat.com>
 <SJ0PR11MB67441F9E6629728ABBF7655092F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <999a8b13-61e9-4c5d-a02b-a608487f7114@redhat.com>
 <SJ0PR11MB67449D7B5FFAB6104F050D9092F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <270f9f43-fa47-4b42-92b0-0f717861dbc1@redhat.com>
In-Reply-To: <270f9f43-fa47-4b42-92b0-0f717861dbc1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CO1PR11MB4770:EE_
x-ms-office365-filtering-correlation-id: 83d52d8e-a357-4aa1-d7a5-08dc8471dc4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|1800799015|366007|376005|7416005|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?U0plaEJyeVBEQWQyNGVGR1NIK0NuTFk5bzRRSXE3Kzd6cytjZW1Sdjh5b0E0?=
 =?utf-8?B?VWtRaEJQVDZLc1g2cWlMd0dYWDRhcWF4Y3dlUEFYTWFwMEd4c0pYWnUzd1Ix?=
 =?utf-8?B?Tm5peVgyRGdCK1NWSENVbUtCNXc1OFRrS0piSGw5ZjEweklleDJUdmR5YnNv?=
 =?utf-8?B?NExKQk4wWENyYXROUEh5K3F3SFdCdHNlTzlodkc5TVRleG5iSldHM1pXNExo?=
 =?utf-8?B?RkQxVXBlL21NR2wrUld5YnRYY0NKb0NSN2tLWjFROFFQTDVUYk4rSVNOMHpv?=
 =?utf-8?B?MGxOa0hNWHBrYzNpUUpra0I0cGlia0RwM2JSb2V2RDN2OU94enlBM0daK2FS?=
 =?utf-8?B?WC96NDRqUUo0OTNSYlI5WXFmVTBLNTl1WVVWMmhHS0JtK0NoU0NOYmNmdTQw?=
 =?utf-8?B?ZnA4RGdkNnUwdy92aVBKdEpONGJlS2U3cFZrQ2RubjkrS0RVVWJMS0NXSnAr?=
 =?utf-8?B?SkpVKzR1MUxqdDZMNVU5dGxDMDV1a2poZzRmbFljcnhyMlZ1ZHNHSnd4bnQx?=
 =?utf-8?B?RTdUNktKaWJNam9kYVk2MFV4eGZMYmRVR3FRVy9tdTVQcEFNR1g4dnNlUi8z?=
 =?utf-8?B?YW5Ec2FEeTU3elNWVVVTdURmWURPMDRReUxVTVpjazFGS3d0N0c3b1dPS3o4?=
 =?utf-8?B?eHF4ZTBUVGwvY29vdHlhQ2IzRlBFTjhjczE3YmVqeFpzYUpaSWE1NlY2aXpn?=
 =?utf-8?B?ekU5YkxNcnBtaVpKVExFT0REd2NiZHFMVmZtZThDbVVycS9nVElqMW1lREYy?=
 =?utf-8?B?cUdiTEMrSXdWZ1JZNU5tMmw1OWk2eE5lWlpvdHQ4aXlSSnRBeDRKVEEzR2pn?=
 =?utf-8?B?ZmdlSlhrUXpFTmNncHJ0VDVIdk9iM1pYZDJHdTVHWTdzUXkranROZFl4OFB6?=
 =?utf-8?B?RVF6a0JtZnhVN1UzUUhQc3RtMXRuTXBIUnR6VlI5ZWwrUjZnUGlRcTFuRnEx?=
 =?utf-8?B?VUgzeWZZRDU5WDFjTEt3T3Y1bHREb0RkVFI4YU9zanh1S3NaRG1zaWxHUDNR?=
 =?utf-8?B?RzFkOGtMZjVLdG82cnBWbnFtVldWT056RVZBV2dmNkMrSnJqcDdUWk5GOXBj?=
 =?utf-8?B?TUl0a2RyTm95YmZ2ZFM2eWVWNzJFSk4vaHhkZHBDRk1xSFRPUXY3NjNxY2RU?=
 =?utf-8?B?dFNjZXdjNnZJNmNmVFFFRXRnME41dUF0b2dKUzU4aGVYTENmNHVsZVF5VWUx?=
 =?utf-8?B?K0NKb054bzBBOWtWQk1uZG1FdWtuSkMwL25mYldmY2xMUkJFMmd2dmNHUHNt?=
 =?utf-8?B?WWtTZnZ3QlljLytoZWJsQkJEYndaR3IwdTQzdjVHM2NDbzgyTTlqemlBRnJo?=
 =?utf-8?B?YldJS2hMRHNRMnNOWW5ic05PZjE0YkZPLzZ2NkZSTXlRV0Jyakk0bm5SeWVO?=
 =?utf-8?B?L1JhWEgrZXpDZ1poQzVCRExHc3RZODNxVU5TNThKVHB2Ym5teGNNdnhZdUJl?=
 =?utf-8?B?YXY0Qy9qdzZLNmhSWWlwcHFtQ012TTNiNkhDYllzVW9JSHc0OU95VnUxRnFr?=
 =?utf-8?B?cEZ3OCtoRWxJMzM2T2Y2aHFHdXIweVYzVTZCaHd0djRqM0doNGxyclZsNXFD?=
 =?utf-8?B?dGJyWjNSUHFZTXNSc3VrTHJUWDJLNWhrSjJpZ2xRWDNkOEhheDJLQk1BVVkw?=
 =?utf-8?B?LzNZTVZGSDhUTXpwLzBTTXlMSE15RGlTelBVcm1BdFFEU2tZOXErSDhRSVVq?=
 =?utf-8?B?TUpJNlE1N0pIcVZYL204a3F4YjU5ckJnbTNrUU1pdGphVUdVRHZRZlp3YlY3?=
 =?utf-8?B?YThTQ2xXdG15a0Y1dkowTDZpZjlpVGhHV0xPVHZXUm02azk2VFJtY3BpWjRZ?=
 =?utf-8?B?d2htdDIyZFNWL2FVdjFvQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(7416005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qi81eDdwVWtHR0NKVDBrdERVU3ZxMGtCYmRPNlFIQTV3Q2ltZ1ZpdVp6R3Bp?=
 =?utf-8?B?VG5jcmpEanVRUUZBMENibEpqR1pmYTg3NkppV2plMnFxYXVtOFYzbVo1K3RJ?=
 =?utf-8?B?WTZ4RXNyQ0pwZnZueEpobVdDN2lHdWZtMmFBSUNXQ0FhUWgvVldsNjVabGlE?=
 =?utf-8?B?N3pPdTZyWXBmU0lhUGhjUEtEemNvVFV2WlEyeFRhTzBlbW9HY2VCanlDQmds?=
 =?utf-8?B?UlQxS0RpSm1mYkxKTW5XaklqU0lpblpYU0pXNGdWbmxHUlVXTk03blpmN2VM?=
 =?utf-8?B?WUUydTdaYnZPTElGdjJTMnd6SzBSV1dkZ0w4dnkwL0F0QVNNTzVHaytDVjdt?=
 =?utf-8?B?MlNnNTRUOFdvcjh1ckd1YzVOZ2VGNTVJT3d2OG05RVhhVFRXYVZuKzlvYnVQ?=
 =?utf-8?B?MkZCbWI5aC9xWi9uRDBiVzZodm1iUlF6MW5nVzhOd2NwSVVTZ2VNWEk4Ykhy?=
 =?utf-8?B?Rk5DSHVjeFBXdFArNmxLVVNUTmRRNnhxNEt4ZU9nRGVlaThvOFFKdysxS1po?=
 =?utf-8?B?ZlBDdzBNK1FoYXZtVlVZZENja2FJS0FVK2xQUGFuRlNtQm9jSXFnS3RrQ3pp?=
 =?utf-8?B?UlA1TThQcllFZjZ3K3RkT1JRZE5XZ3NYME91cy9ZQ2RZYnpHQXc5WEhEUTZr?=
 =?utf-8?B?UjIySE1YaUJjOHgwSkF2KytsZXo4NUxYVUQzdkY3dVFpTk9NeDd0dXFHbWhY?=
 =?utf-8?B?L25rcEtIMU00aWpVOGNDZUVKTXFtWlpxNE8vRWkvM3RVNzk3V3Nxb0d1VXBM?=
 =?utf-8?B?bm4vc0I3RmhoaWFMYTFKMDRPVnMvY2V0b0pPNXpmT0t6R2gzZURpM1Z4M2Jn?=
 =?utf-8?B?WDN6aVB4d3o4VTN6ZEJSQ3lqMnF6bVhZdFJ5RTlYa2R6Q1g5S0RFMDMwYWth?=
 =?utf-8?B?NW9JRXBJeUEwK1RqUWJXT1hHYlFTQ2NYeFZraXM2UXY1d3hEOCtlWDBHY05E?=
 =?utf-8?B?cG1nMmxvdVkwY3UwV0p2cVdLa0RaVGJibndnSkZXOURRb29mSytoc2ozcHZM?=
 =?utf-8?B?SVRnVUx3bTRXalI1ZVl3WFRSRmhEZWFNY1cyd0RIM2QvbHhydUhZMGpnTVV5?=
 =?utf-8?B?a3hRelJWdzRSVzhmSU0rVXRhZDZvTFpweE9MRnR3THpUc0FMdjIwQVpHV1BF?=
 =?utf-8?B?Y1VrQlpHQTJKb25EK0xSa0UyejZ1NjduK2N6dW84aFR1Q0JFWEh3QmpZYVdO?=
 =?utf-8?B?bGRDd0psdU9qeThIdHRRUCsvcDY2NFhiSHZ5MXdzUm9nZEs4SzF5bFdpV1lz?=
 =?utf-8?B?TE5FS1RJa1hXV3U4b3dsOW53KzVEdyt5UDI5UkxIbkpVN2NRUENoZTVIVmRu?=
 =?utf-8?B?R2Y5dGFkQzR4NXZLRlUrRGpjZ1BnRi9ZZi9UTFZHOWtkQkh5V1dhbktxSDdt?=
 =?utf-8?B?ZVFwbDJwVDNBekhuZFBJY2srTDZwdkxPakQwV2tFc2lDZFpETmRwKzh5dlVB?=
 =?utf-8?B?ekR1ZHFxMmJheUFHNjFJZllGK3VpaVZoM1RUakx1eElGUDNDcTFEM1dLV1Nt?=
 =?utf-8?B?dGhlbnN0bWd4elRzazZKZG0rZDM1cDZYeWJYRXZxcFY1SWZhcXpVZDJFSC84?=
 =?utf-8?B?ZjZ6Qy9wTHJjNWVCRmFVQWVmalFNWk4yN2NLWHo3SVhNSzhXMyszSnpQL0RY?=
 =?utf-8?B?ZXoxazlnbTJVay90dEYwR0JZOFRGVUJGelVRKzFmWXRpZ2lSMkN4cmJ1ZzNW?=
 =?utf-8?B?d0dYek1CdENteWlSUkVTV0FPY2VwcjVtalJ4ZzZBcVFOMnBzYW51VjZrSWsv?=
 =?utf-8?B?c2ZsREVoUUlDeWRMU2NKejk5RkRpMEZyT29ObXBNSnJkNlRjRDNuNGovUDVn?=
 =?utf-8?B?QlhIcmFoaGROYUhmUFM2WVRyWWF5UUZiV3lMNTJtKzBIdVE1SlhCbWYrOTFW?=
 =?utf-8?B?M3BteWkyNXdWdFdmd05vZUkwK2R0NGJsYm9WaXpZQlpIbkNKS3FvRUlsb0Jl?=
 =?utf-8?B?a1VhM0pBVE9pZEs5Y1poNEE4WVdhSlNVQ2NkYjRLU0xhb2tFMDZmUWpGTkxH?=
 =?utf-8?B?WUk1YWswTWFIc0tWVzVjVCtUTFo2dDJMWFRGZStValc1Z0gxMTlldlZIYTBF?=
 =?utf-8?B?cXlpV0lQU1hjTTBXalMzb1h1U1RySFo4enBjSDdnVnk4bG5RM3Z2WjErVVB4?=
 =?utf-8?Q?zTfVcM/hV/6IAuDcqgct8jaxR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d52d8e-a357-4aa1-d7a5-08dc8471dc4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 08:39:34.1570 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n0HiZUsON03J90dMKr30gbsKg8XAqyBf0rn/m/DSmeQ8rbzfE9kDr3/HoDXjmFo9aJWpaqic9LaER/aMVy8TLvCvCzgmUFvsAqi2KEfnMHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4770
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
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
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY2IDA5LzE5XSB2ZmlvL2lv
bW11ZmQ6IEltcGxlbWVudA0KPkhvc3RJT01NVURldmljZUNsYXNzOjpyZWFsaXplKCkgaGFuZGxl
cg0KPg0KPg0KPkhpLA0KPk9uIDYvNC8yNCAwOTo1MSwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0K
Pj4NCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IEVyaWMgQXVnZXIg
PGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDA5LzE5
XSB2ZmlvL2lvbW11ZmQ6IEltcGxlbWVudA0KPj4+IEhvc3RJT01NVURldmljZUNsYXNzOjpyZWFs
aXplKCkgaGFuZGxlcg0KPj4+DQo+Pj4NCj4+Pg0KPj4+IE9uIDYvNC8yNCAwNDo1OCwgRHVhbiwg
Wmhlbnpob25nIHdyb3RlOg0KPj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+Pj4+
IEZyb206IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+Pj4+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjYgMDkvMTldIHZmaW8vaW9tbXVmZDogSW1wbGVtZW50DQo+Pj4+PiBIb3N0
SU9NTVVEZXZpY2VDbGFzczo6cmVhbGl6ZSgpIGhhbmRsZXINCj4+Pj4+DQo+Pj4+PiBIaSBaaGVu
emhvbmcsDQo+Pj4+Pg0KPj4+Pj4gT24gNi8zLzI0IDA4OjEwLCBaaGVuemhvbmcgRHVhbiB3cm90
ZToNCj4+Pj4+PiBJdCBjYWxscyBpb21tdWZkX2JhY2tlbmRfZ2V0X2RldmljZV9pbmZvKCkgdG8g
Z2V0IGhvc3QgSU9NTVUNCj4+Pj4+PiByZWxhdGVkIGluZm9ybWF0aW9uIGFuZCB0cmFuc2xhdGUg
aXQgaW50byBIb3N0SU9NTVVEZXZpY2VDYXBzDQo+Pj4+Pj4gZm9yIHF1ZXJ5IHdpdGggLmdldF9j
YXAoKS4NCj4+Pj4+Pg0KPj4+Pj4+IEludHJvZHVjZSBtYWNybyBWVERfTUdBV19GUk9NX0NBUCB0
byBnZXQgTUdBVyB3aGljaA0KPmVxdWFscw0KPj4+IHRvDQo+Pj4+Pj4gKGF3X2JpdHMgLSAxKS4N
Cj4+Pj4+Pg0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb20+DQo+Pj4+Pj4gLS0tDQo+Pj4+Pj4gIGluY2x1ZGUvaHcvaTM4Ni9pbnRl
bF9pb21tdS5oIHwgIDEgKw0KPj4+Pj4+ICBody92ZmlvL2lvbW11ZmQuYyAgICAgICAgICAgICB8
IDM3DQo+Pj4+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+Pj4+ICAy
IGZpbGVzIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKykNCj4+Pj4+Pg0KPj4+Pj4+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4+Pj4gYi9pbmNsdWRlL2h3L2kz
ODYvaW50ZWxfaW9tbXUuaA0KPj4+Pj4+IGluZGV4IDdmYTBhNjk1YzguLjdkNjk0YjA4MTMgMTAw
NjQ0DQo+Pj4+Pj4gLS0tIGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+Pj4+PiAr
KysgYi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4+Pj4+IEBAIC00Nyw2ICs0Nyw3
IEBADQo+T0JKRUNUX0RFQ0xBUkVfU0lNUExFX1RZUEUoSW50ZWxJT01NVVN0YXRlLA0KPj4+Pj4g
SU5URUxfSU9NTVVfREVWSUNFKQ0KPj4+Pj4+ICAjZGVmaW5lIFZURF9IT1NUX0FXXzQ4QklUICAg
ICAgICAgICA0OA0KPj4+Pj4+ICAjZGVmaW5lIFZURF9IT1NUX0FERFJFU1NfV0lEVEggICAgICBW
VERfSE9TVF9BV18zOUJJVA0KPj4+Pj4+ICAjZGVmaW5lIFZURF9IQVdfTUFTSyhhdykgICAgICAg
ICAgICAoKDFVTEwgPDwgKGF3KSkgLSAxKQ0KPj4+Pj4+ICsjZGVmaW5lIFZURF9NR0FXX0ZST01f
Q0FQKGNhcCkgICAgICAoKGNhcCA+PiAxNikgJiAweDNmVUxMKQ0KPj4+Pj4+DQo+Pj4+Pj4gICNk
ZWZpbmUgRE1BUl9SRVBPUlRfRl9JTlRSICAgICAgICAgICgxKQ0KPj4+Pj4+DQo+Pj4+Pj4gZGlm
ZiAtLWdpdCBhL2h3L3ZmaW8vaW9tbXVmZC5jIGIvaHcvdmZpby9pb21tdWZkLmMNCj4+Pj4+PiBp
bmRleCBlNGE1MDdkNTVjLi45ZDJlOTVlMjBlIDEwMDY0NA0KPj4+Pj4+IC0tLSBhL2h3L3ZmaW8v
aW9tbXVmZC5jDQo+Pj4+Pj4gKysrIGIvaHcvdmZpby9pb21tdWZkLmMNCj4+Pj4+PiBAQCAtMjUs
NiArMjUsNyBAQA0KPj4+Pj4+ICAjaW5jbHVkZSAicWVtdS9jdXRpbHMuaCINCj4+Pj4+PiAgI2lu
Y2x1ZGUgInFlbXUvY2hhcmRldl9vcGVuLmgiDQo+Pj4+Pj4gICNpbmNsdWRlICJwY2kuaCINCj4+
Pj4+PiArI2luY2x1ZGUgImh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCINCj4+Pj4+Pg0K
Pj4+Pj4+ICBzdGF0aWMgaW50IGlvbW11ZmRfY2Rldl9tYXAoY29uc3QgVkZJT0NvbnRhaW5lckJh
c2UgKmJjb250YWluZXIsDQo+Pj4+PiBod2FkZHIgaW92YSwNCj4+Pj4+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHJhbV9hZGRyX3Qgc2l6ZSwgdm9pZCAqdmFkZHIsIGJvb2wgcmVhZG9u
bHkpDQo+Pj4+Pj4gQEAgLTYxOSw2ICs2MjAsNDEgQEAgc3RhdGljIHZvaWQNCj4+Pj4+IHZmaW9f
aW9tbXVfaW9tbXVmZF9jbGFzc19pbml0KE9iamVjdENsYXNzICprbGFzcywgdm9pZCAqZGF0YSkN
Cj4+Pj4+PiAgICAgIHZpb2MtPnBjaV9ob3RfcmVzZXQgPSBpb21tdWZkX2NkZXZfcGNpX2hvdF9y
ZXNldDsNCj4+Pj4+PiAgfTsNCj4+Pj4+Pg0KPj4+Pj4+ICtzdGF0aWMgYm9vbCBoaW9kX2lvbW11
ZmRfdmZpb19yZWFsaXplKEhvc3RJT01NVURldmljZSAqaGlvZCwNCj52b2lkDQo+Pj4+PiAqb3Bh
cXVlLA0KPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9y
ICoqZXJycCkNCj4+Pj4+PiArew0KPj4+Pj4+ICsgICAgVkZJT0RldmljZSAqdmRldiA9IG9wYXF1
ZTsNCj4+Pj4+PiArICAgIEhvc3RJT01NVURldmljZUNhcHMgKmNhcHMgPSAmaGlvZC0+Y2FwczsN
Cj4+Pj4+PiArICAgIGVudW0gaW9tbXVfaHdfaW5mb190eXBlIHR5cGU7DQo+Pj4+Pj4gKyAgICB1
bmlvbiB7DQo+Pj4+Pj4gKyAgICAgICAgc3RydWN0IGlvbW11X2h3X2luZm9fdnRkIHZ0ZDsNCj4+
Pj4+PiArICAgIH0gZGF0YTsNCj4+Pj4+PiArDQo+Pj4+Pj4gKyAgICBpZiAoIWlvbW11ZmRfYmFj
a2VuZF9nZXRfZGV2aWNlX2luZm8odmRldi0+aW9tbXVmZCwgdmRldi0NCj4+Pj4gZGV2aWQsDQo+
Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnR5cGUsICZk
YXRhLCBzaXplb2YoZGF0YSksIGVycnApKSB7DQo+Pj4+Pj4gKyAgICAgICAgcmV0dXJuIGZhbHNl
Ow0KPj4+Pj4+ICsgICAgfQ0KPj4+Pj4+ICsNCj4+Pj4+PiArICAgIGNhcHMtPnR5cGUgPSB0eXBl
Ow0KPj4+Pj4+ICsNCj4+Pj4+PiArICAgIHN3aXRjaCAodHlwZSkgew0KPj4+Pj4+ICsgICAgY2Fz
ZSBJT01NVV9IV19JTkZPX1RZUEVfSU5URUxfVlREOg0KPj4+Pj4+ICsgICAgICAgIGNhcHMtPmF3
X2JpdHMgPSBWVERfTUdBV19GUk9NX0NBUChkYXRhLnZ0ZC5jYXBfcmVnKSArDQo+MTsNCj4+Pj4+
IFBsZWFzZSBjYW4geW91IHJlbWluZCBtZSBvZiB3aHkgeW91IGNhbid0IHJldXNlIHRoZSBpb3Zh
X3Jhbmdlcw0KPj4+IG1ldGhvZC4NCj4+Pj4+IGlzbid0IGl0IGdlbmVyaWMgZW5vdWdoPw0KPj4+
PiBZZXMsIGlvdmFfcmFuZ2VzIG1ldGhvZCBpcyBvbmx5IGZvciBpb3ZhX3Jhbmdlcywgd2Ugd2Fu
dCB0byBtYWtlDQo+Pj4+IEhvc3RJT01NVURldmljZS5nZXRfY2FwKCkgYSBjb21tb24gaW50ZXJm
YWNlLg0KPj4+Pg0KPj4+PiBXaGVuIHdlIHdhbnQgdG8gcGFzcyBpb3ZhX3Jhbmdlcywgd2UgY2Fu
IGFkZA0KPj4+IEhPU1RfSU9NTVVfREVWSUNFX0NBUF9JT1ZBX1JBTkdFUw0KPj4+PiBhbmQgSG9z
dElPTU1VRGV2aWNlLmlvdmFfcmFuZ2VzLg0KPj4+IEkgcmF0aGVyIG1lYW50IHRoYXQgaW92YV9y
YW5nZXMgaXMgcGFydCBvZiBWRklPQ29udGFpbmVyQmFzZSBhbmQgeW91DQo+Pj4gY291bGQgcmV1
c2UgdGhlIHRlY2huaWNzIHVzZWQgaW4gaGlvZF9sZWdhY3lfdmZpb19yZWFsaXplLCByZWx5aW5n
IG9uIGENCj4+PiBjb21tb24gaGVscGVyIGluc3RlYWQgb2YgdXNpbmcNCj4+Pg0KPj4+IFZURF9N
R0FXX0ZST01fQ0FQKGRhdGEudnRkLmNhcF9yZWcpLiBEb2Vzbid0IGl0IHdvcms/DQo+PiBHZXQg
eW91ciBwb2ludC4NCj4+IFllcywgSXQgZG9lcyB3b3JrIGFuZCBzaG91bGQgaGF2ZSBzYW1lIHJl
c3VsdC4NCj4+IFRoYXQgbWVhbnMgaW9tbXVmZCBiYWNrZW5kIHN1cHBvcnQgdHdvIHdheXMgdG8g
Z2V0IGF3X2JpdHMuDQo+Pg0KPj4gT25seSByZWFzb24gaXMgSSBmZWVsIFZURF9NR0FXX0ZST01f
Q0FQKGRhdGEudnRkLmNhcF9yZWcpIGlzIGEgYml0DQo+c2ltcGxlcg0KPj4gYW5kIHRoZXJlIGFy
ZSBvdGhlciBiaXRzIHBpY2tlZCBpbiBuZXN0aW5nIHNlcmllcywgc2VlOg0KPj4NCj4+ICAgICBj
YXNlIElPTU1VX0hXX0lORk9fVFlQRV9JTlRFTF9WVEQ6DQo+PiAgICAgICAgIGNhcHMtPmF3X2Jp
dHMgPSBWVERfTUdBV19GUk9NX0NBUChkYXRhLnZ0ZC5jYXBfcmVnKSArIDE7DQo+PiAgICAgICAg
IGNhcHMtPm5lc3RpbmcgPSAhIShkYXRhLnZ0ZC5lY2FwX3JlZyAmIFZURF9FQ0FQX05FU1QpOw0K
Pj4gICAgICAgICBjYXBzLT5mczFncCA9ICEhKGRhdGEudnRkLmNhcF9yZWcgJiBWVERfQ0FQX0ZT
MUdQKTsNCj4+ICAgICAgICAgY2Fwcy0+ZXJyYXRhID0gZGF0YS52dGQuZmxhZ3MgJg0KPklPTU1V
X0hXX0lORk9fVlREX0VSUkFUQV83NzI0MTVfU1BSMTc7DQo+Pg0KPj4gSSdtIGZpbmUgdG8gdXNl
IGlvdmFfcmFuZ2VzIHRvIGNhbGN1bGF0ZSBhd19iaXRzIGZvciBpb21tdWZkIGJhY2tlbmQgaWYN
Cj55b3UgcHJlZmVyIHRoYXQuDQo+WWVzIEkgdGhpbmsgSSB3b3VsZCBwcmVmZXIgYmVjYXVzZSB0
aGlzIHRlY2huaWNzIGFsc28gd29yayBmb3Igb3RoZXINCj5pb21tdXMgYW5kIG5vdCBvbmx5IFZU
RC4gSXQgYWxzbyBjYW4gcmVseSBvbiBjb21tb24gY29kZSBiZXR3ZWVuIGxlZ2FjeQ0KPmFuZCBp
b21tdWZkLiBUaGUgbmVzdGluZyBzZXJpZXMgY2FuIGJyaW5nIHRoZSByZXN0IGxhdGVyDQoNCk9L
LCB3aWxsIGRvLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

