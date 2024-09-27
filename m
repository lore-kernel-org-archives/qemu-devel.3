Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B422CEBF76
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 06:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su4dY-0000gw-4s; Fri, 27 Sep 2024 02:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1su4dV-0000UP-MN
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 02:39:30 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1su4dT-0006jG-Eq
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 02:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727419167; x=1758955167;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3U0a3zRrAL1xM6cmhpEQw0jKnBqsttT+l8oEqjpiM3Q=;
 b=bnRi0LmNtiQ6zGPhlWvR0X4y3DdDOjMAnEpKRVTjos1xNcVDdfCzC9ZG
 jo6hMmqACEdnNjOh75nCeP6VjbCQkGj66yKXAq69moHGDmqEeWI3iywfw
 Te76F9/EcJylmyjDkx+rbPeP/PYIt0hPiYdA3DXR4g7Hnrf+ifX28xo0j
 OmvwSJBaHNnkvlg5gT5BlXJkBZaVulDpEcERpvhNHBeEBEuAiQuJicMkD
 pnVrm8cBH3FAs7x4eHaaWCCl32Mp5tK92FpEV454iY/3Zq8rAiTDguXDA
 WT8yWRQ1FrCfb/1nRKloDs+mEFIX7mVYqMcUz6ElUvEy7W68FVb7aNZmx g==;
X-CSE-ConnectionGUID: gPbu9/4ZR4uPm5tvWpMHtw==
X-CSE-MsgGUID: zC/Ze7RGQr6d5rv9r0lgpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="37133508"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; d="scan'208";a="37133508"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2024 23:39:26 -0700
X-CSE-ConnectionGUID: jfYkK2aISMOEYu6vA8ZZNQ==
X-CSE-MsgGUID: TVUlDtG4Q42Q8vi4yM92kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; d="scan'208";a="73222947"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Sep 2024 23:39:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 23:39:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 23:39:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 23:39:25 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 23:39:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYh7INph7Br5/ug2fXKennT1mJWeE0tM6+XSL5I3HLjJxLx8/EbMBo72pKB3Zyc7JxzCeHQvNOMObCvRurZXUrc3ON6deoWPc86rTVe6Tx2EYEhTOlANtsWMN9X2MZbpd0MzlIueB7dpjpBp5sKIfhIJ0BEH2p8uRTikw7zD30NP+vYglNohlwdFMD/CLJbczMUKUSxRsqq/kCs0nRF4D2r3p1HQSTVUDYh2n1RB+rBqnBoyaiGG4G00RPbL8ZuERD/kRsnXaMVZG4eVdxMmcXJBxE94YAslxpBLGC3p9X1HId1046d0OLYQiYlxoMf2JKhu/q6hJUbsse9RssBzUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3U0a3zRrAL1xM6cmhpEQw0jKnBqsttT+l8oEqjpiM3Q=;
 b=uTZUxe3S6SDyqF/pl7RJ4zncY6G93CSGHCuI8+RXWDwIxqnJpyoP3gFa/VK4kqydev85NyuMQHbFWxFlw9+NMWy6vSU3pkXggjXfOYDbycSZ0pFVTBldeLV64Lbzuy9N8UntylrAVcw0iOs8dgSc8S4O8jDI1j2XX2/puhdgV7QJMYsHihSiTne1jtD/H4ErF/V/4WU1RYuiE3QVXhmtBapvuiAiqMn3D6Xxug1cgWDF9H4vjX3rWbYuGHSZZSYucj42567kUcMC0JEQMCL9Kgv0fSOloWiSMBY04s0zPpZIt16MLxC4AQYFoMR2j80DuXMvbsCqDeolGRpTLCKt7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB6495.namprd11.prod.outlook.com (2603:10b6:8:c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Fri, 27 Sep
 2024 06:39:22 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 06:39:22 +0000
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
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v3 16/17] intel_iommu: Introduce a property to control
 FS1GP cap bit setting
Thread-Topic: [PATCH v3 16/17] intel_iommu: Introduce a property to control
 FS1GP cap bit setting
Thread-Index: AQHbBAtN88bdWaJ+1kCNt+X8Konp9LJrHbCAgAAdITA=
Date: Fri, 27 Sep 2024 06:39:22 +0000
Message-ID: <SJ0PR11MB6744D549D89D05D1BF368359926B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-17-zhenzhong.duan@intel.com>
 <CACGkMEtPQGmJvYkfCfjNrsrumYKvBH8SXYdT0ZpToJ3Ac5DhYQ@mail.gmail.com>
In-Reply-To: <CACGkMEtPQGmJvYkfCfjNrsrumYKvBH8SXYdT0ZpToJ3Ac5DhYQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB6495:EE_
x-ms-office365-filtering-correlation-id: 67297ccc-8a1e-4bea-6f0a-08dcdebf1f65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?TWxqNXh1WXpML1JtVW95ZExmUkxDT1JaZFUzdUlIWDZDZlRuZVZsdzNlbnd0?=
 =?utf-8?B?ZGRjUU5Ram1TRzJiNC83S2EwRzZiK1ZXdVRSb1NMb2c4eElPVHBQRi8vS0w3?=
 =?utf-8?B?bXNUMWF6ZEVjcDc0dkZNYktsTWxabW1BbmtPVTBIRG55NlkvUCtnbUpNN1dV?=
 =?utf-8?B?bkRqUGtiRmZieXQ5Qyt1N1FpbEJjZjZ2dnIrSDF5TjU1dTllVXp4QW55Rmht?=
 =?utf-8?B?blZvTyt3ZU44VVdFRHMvSlYyYmFZT3grWjBVbDJVL0RmUWtsV3l4TzJESDV3?=
 =?utf-8?B?QmVYdUhyaXZhWHp2emhXbk9LVnBJZy9tMEZIVDZMNzFKRFBJcFEvOHpIOE43?=
 =?utf-8?B?Z21XQzk1dUpGaTZSQ0VXd1I0bzQ4Y0IzOG5HbERPOWU5MkV6bCtKUU0rSGlG?=
 =?utf-8?B?MkdOTnFZVWQ4QVorWkNwVHJ1bG5oRE5UZHQxY3lBM2dkbE5nNTJGcFNSSzM0?=
 =?utf-8?B?ZlA1RnUyMjJJem03NksrSmJEUy9sUlV5c3hIeGRaK0trSkNkZ3pJTmY3bTgv?=
 =?utf-8?B?MHl4QWkzdllZckhwZ0hqbzg1dktsdVp0Si9qcklXakJ5Z0lDVnpmd2NxVjVn?=
 =?utf-8?B?QW1zWGdyenBqUFYwMVpIQWpKc0RONE9LZDR0N0RCLzRXcjVpc1BuanA2aHZZ?=
 =?utf-8?B?bStTOUQ0MExSR3c2Q1ltOU5XQzBncUJETzgwdG45VWF2aFExYUZZL3NBS0F0?=
 =?utf-8?B?VTZnUzdMUitFK2YvK3NSZXBzeU8zZ0x0UitDR1I1ZFpMUk5UbjVZYUQ3S1gz?=
 =?utf-8?B?OXNDMW9kVmIwaXkyRzNXc1pkNzFDSktwZlYrK2NnbDVIczJOY2pYUmxsY056?=
 =?utf-8?B?M3B0enA3MGtHRVJZSU9yRzVMN2d6eTRUeEhlMXB0ci8vY0FEellDMGNJOFht?=
 =?utf-8?B?Mkh0NXRXWHhmZTFSQnlmZ3NGYWYrUkxTWnVBK0UySE4rdEFZUm44cEtuWUFE?=
 =?utf-8?B?aFVHSUNVYnJwN2NlOWV0RVlNekt5WGFSK2lBbmxHTHR4S2pwbEVlQ1ZXUzZB?=
 =?utf-8?B?WlpNS05kdGRBaGo2VnNGWXNkdElKWFdta3BSQlZWS0dvSUF5TWVtVVpnekJ6?=
 =?utf-8?B?azArZldDcWtSbWhtT2lLRlpEN2JNY1NCS0hISElETjVuQ3FTdVQwd1NEOFZL?=
 =?utf-8?B?VUNYLzJJYkdURm9MNHVWa0dvc2FKbEpVTGUwZ3Nnd2hXVmJENlRlNnNvcHlr?=
 =?utf-8?B?ZDhOejg5ZEFmbGdvWDNBV1hweGNITFQzY1VoNm9rcGNpb3IyK2N6ZVNXekdK?=
 =?utf-8?B?Yy9HSDJxc1I3MkQ0STZ2b21zVEs2eU1Eb1lxUms5L3BVblZRT3FjV0p5YUJN?=
 =?utf-8?B?NjVwRVNVS2RucHlGTjBSTVVlQ3hySEV3MitjeVBrRGliUWZPbnpKL01rKzds?=
 =?utf-8?B?bkpSQ0xyanFhd3BGL2lneCtiSHVRMmwwMEIrRjJVME9hYi9zMjFRc3UrTE95?=
 =?utf-8?B?aitFbDVMMVBpUGlwUE1yajhhU0ZJbVdrSFZ4MUFuOWlFWm1zZHJ0Nm5wQnE3?=
 =?utf-8?B?Y1ZDcXRWMTU1MUF2dXRBUkJJUVN0WnZ3eGttanBOd1lNb0Z2VjdHY3lPUWlM?=
 =?utf-8?B?V1Q3RVVYaW1yRFllRjFlQUtBMHVLMmxFZnpTRkdEY2dnOFFhMyt5YlVaUTVQ?=
 =?utf-8?B?amhxTURvcXQ5Qlp5SmFvT2ZTdEpoVlowQkVTSHFZUG0zUHVzVTdub1c0OUFr?=
 =?utf-8?B?bUYxM0ZDUmROcCtUTVd0MGE0WWdLNDJZUlZ3OXhRdjBjV3VFZmh2OTFIMDln?=
 =?utf-8?B?OWEwblRDTDlQSFgrR1EveFJWeTdUK2wzZUNTTVgzcm1RWUpHOWVVMHpkRGtQ?=
 =?utf-8?B?QnU1TFVqOUJDY0lrNENHWW5pZEorcnlzUFRybk0ybXl3bHNGcGtoYjUzN2Nh?=
 =?utf-8?B?YXlEN3NQQVo1OHgwd2pLaDhNUjhYSE1hSDdFZnFDN2ROdGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjVzbURvd2M5STFRWFZwYjd6YmwrSjFRRGZkRFlIZGlSNGt4cUZTdzRQc3lE?=
 =?utf-8?B?OVJEamNXUWlLcUtzZkVlZFZKTWRWU3B6RTB1UzNobVpLYmNScFFBd0NiMWVs?=
 =?utf-8?B?QzFnT1NFdFE0cDZ5M2I0bnhvcmlmM005Vkl0T3hLck5ObWxoZ002WnpmWHd3?=
 =?utf-8?B?Wnp6WHcvN0hnVXZEbmJlSkVkVUhlU0FsTlFlZ0Q2YjhyM0Y1c0ZMdmJ5TUZa?=
 =?utf-8?B?RVZhQ2thTHZ5QS9OM2pOLzB5THEremFHWWFnVkNUSzdCOXR5MW5jdFFTczE3?=
 =?utf-8?B?RExTUXZxYmtPanRyY2g4VTN3WkF3Z3lOSXF5MGlrcS9kZ0lOaXFRMnZJVm01?=
 =?utf-8?B?K0ZLMjVrODMvdmFLSlJkbzJYV3JUb0xhQlRaUUdPODRWRWVSSHR4RFV1VFIz?=
 =?utf-8?B?UFJwNm1sVnZVbXJ1azlEcXAwcnFLQ1l3bVVnN01hSWY1bEpNcllLQkFZaEZM?=
 =?utf-8?B?RjEyT2xTV3Y2dlRFVm1oeERwcllpQ2FaMmxreW1kdGhUaTFOWG1TTVVaWW1k?=
 =?utf-8?B?WnUyQWlYRlBrd21qOHRkd2pkWk5nUXpaVFhFM0ttMG1hd0hjb0IvMG12eml2?=
 =?utf-8?B?Y1Z6U09uRjJCV2NndHJXOUN5TjZMNmtGNHZqWFJ3RGJhT1FFTUVpRU9SYnRr?=
 =?utf-8?B?QjMvYkluLzJGS2hiQkc4MEFENWNDNC95RzB6Sno5UlRuT05TZWVUeHYrYitx?=
 =?utf-8?B?WVhVRXIvZmVPSW1uUEUxSCs3d2FWVjg0T2hTT2dtWU5xQ2dqL2l0ZGs2K3lU?=
 =?utf-8?B?UEd0c3pnS1FVREpFSGdHRkJBZVNyc2Myejg0RFRGWkozdUd5Z3A5VmJBT0xN?=
 =?utf-8?B?L1lPRGFEbzZad3JMc1Jya0dYbGU0eUZKUWlpWlBnRWVqc1B3bHdncVNmZ0Fq?=
 =?utf-8?B?SWloVDgxTk9vQ3RxV1ZBR0VhbzNOT2FuSnhuQUNuWmZQMDVkV2Jqb1Vvamx2?=
 =?utf-8?B?QXVWMXR6NWFaYktrZ2lDeWgvMDVMb0hWSDVlbmhJVVkrUUFDUVRCSFlFYngr?=
 =?utf-8?B?OG80ak8zVGoxODFvMTliR2hRVEhtOHh6SzlYVXpycWNiTEhCY00ybjFpdWN0?=
 =?utf-8?B?aHIyZ2E5QTJHZENRZUV1VFJGdStFdzk1Smt2b0xKMWJxdGFxakRhZWk4S2h0?=
 =?utf-8?B?bGMrNkxyTlVnVGxPOWhnM1FoNFloc2RSdHgvYzY0WmVlQ0tRY3IySWFNN2FS?=
 =?utf-8?B?Zzl5NmViVHErOEM4Qk10M3ZBUVFFSVZ1VkFMTFZ5eUtIbVU5QnV0dC83RFlj?=
 =?utf-8?B?Y3lheE94SUVJRnNpbHM3M3FJTXZJU0JiOFd1K0dOQ3Z5bCtFSFdpY0RiMTE4?=
 =?utf-8?B?RkkvWTJEM0VySTkwMi93T3RlYWhGQWJwNEZXTDRSREtYM1hjYU10bUViSlpp?=
 =?utf-8?B?czg2ejBJcThtUWpHQytoeDhhRWlJc2NOZE8xOUlBTzc0N2wwL2E5T3lGVjRD?=
 =?utf-8?B?eGRleHZ1NnhLMThiV2dYUHpKMnZvNzMzZjJiemt4T3A2VGpFbGNoK2l6YW5L?=
 =?utf-8?B?d0ZMaE9ZSTRxbFJURmttS0h3YlY4aUdZRjBvYkQwVm1RT1orYkR1UUY0ZFRo?=
 =?utf-8?B?cmR0RDRsdnJVTUhqdlJUTlVwQ2NpeEdwV2taV1grTlM5bDFQQmtWN3IzdnhM?=
 =?utf-8?B?Zklvb2NKSFBDazkxN2I5NkpBc3c3cU40WGxFQ2IvQUpERlpnMG53cG9hRUhn?=
 =?utf-8?B?ZGJyckRBQkZXK0o3eGJpVGZBem1wakZJUHB2U2hLblZTZHlBbkJBVVF4aHA2?=
 =?utf-8?B?cUYzUHpUbmh6Z0VJdy9kclpIS0tpRm1SODRNNG5hUjE3U2M1MjA1NzdLYTNj?=
 =?utf-8?B?bTJpYXM4MUo1YkhmUTMwekRMYmdQWExib1d0R1ZvRkFQT0l4djVDRmdZRHlS?=
 =?utf-8?B?Y1cyWi9ybGxweGVDR2NFS21PUFUwb3ZWcUJpQlV3M05mRUlUM0hxNUZMRzVr?=
 =?utf-8?B?UFM0czBvbWkyakU0d1c0ZnVrc1NVQkdqTzFGWkJ2MVNwVVUzcjBING5ldTAz?=
 =?utf-8?B?SHozZkk1ZTF2UXBUdnRXWjluc1JoSjVYNjJPaGRISW9PSlR1MVpHejRoRmVT?=
 =?utf-8?B?eDFIV1B2RnUrVXZ6dnowRmVxcUk3TVhuKzVFTWIxUm5OSU9jWDdGMzZzVnF3?=
 =?utf-8?Q?ADTlevRBWFokmpUIkRrtUXu+x?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67297ccc-8a1e-4bea-6f0a-08dcdebf1f65
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 06:39:22.6482 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: enpXNvpzVIcH2onEcwGc4Y836lBGAyJ6K9l0V6//rdqdfLS3jArNBa4xpxybJkaMfdohiZ/BHpIUyfZtWYRz0ery9qmpIJESY7jHHhpoNnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6495
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MyAxNi8xN10gaW50ZWxfaW9t
bXU6IEludHJvZHVjZSBhIHByb3BlcnR5IHRvIGNvbnRyb2wNCj5GUzFHUCBjYXAgYml0IHNldHRp
bmcNCj4NCj5PbiBXZWQsIFNlcCAxMSwgMjAyNCBhdCAxOjI34oCvUE0gWmhlbnpob25nIER1YW4N
Cj48emhlbnpob25nLmR1YW5AaW50ZWwuY29tPiB3cm90ZToNCj4+DQo+PiBUaGlzIGdpdmVzIHVz
ZXIgZmxleGliaWxpdHkgdG8gdHVybiBvZmYgRlMxR1AgZm9yIGRlYnVnIHB1cnBvc2UuDQo+Pg0K
Pj4gSXQgaXMgYWxzbyB1c2VmdWwgZm9yIGZ1dHVyZSBuZXN0aW5nIGZlYXR1cmUuIFdoZW4gaG9z
dCBJT01NVSBkb2Vzbid0DQo+PiBzdXBwb3J0IEZTMUdQIGJ1dCB2SU9NTVUgZG9lcywgbmVzdGVk
IHBhZ2UgdGFibGUgb24gaG9zdCBzaWRlIHdvcmtzDQo+PiBhZnRlciB0dXJuIEZTMUdQIG9mZiBp
biB2SU9NTVUuDQo+Pg0KPj4gVGhpcyBwcm9wZXJ0eSBoYXMgbm8gZWZmZWN0IHdoZW4gdklPTU1V
IGlzbid0IGluIHNjYWxhYmxlIG1vZGVybg0KPj4gbW9kZS4NCj4NCj5JdCBsb29rcyB0byBtZSB0
aGVyZSdzIG5vIG5lZWQgdG8gaGF2ZSBhbiAieCIgcHJlZml4IGZvciB0aGlzLg0KDQpXaWxsIHJl
bW92ZSAieCIgcHJlZml4Lg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+DQo+T3RoZXIgbG9va3Mg
Z29vZC4NCj4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25n
LmR1YW5AaW50ZWwuY29tPg0KPj4gUmV2aWV3ZWQtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWY8
Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+PiAtLS0NCj4+ICBpbmNsdWRlL2h3
L2kzODYvaW50ZWxfaW9tbXUuaCB8IDEgKw0KPj4gIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAg
ICAgIHwgNSArKysrLQ0KPj4gIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21t
dS5oDQo+Yi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4gaW5kZXggNjUwNjQxNTQ0
Yy4uZjZkOWI0MWI4MCAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21t
dS5oDQo+PiArKysgYi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4gQEAgLTMwOCw2
ICszMDgsNyBAQCBzdHJ1Y3QgSW50ZWxJT01NVVN0YXRlIHsNCj4+ICAgICAgYm9vbCBkbWFfZHJh
aW47ICAgICAgICAgICAgICAgICAvKiBXaGV0aGVyIERNQSByL3cgZHJhaW5pbmcgZW5hYmxlZCAq
Lw0KPj4gICAgICBib29sIGRtYV90cmFuc2xhdGlvbjsgICAgICAgICAgIC8qIFdoZXRoZXIgRE1B
IHRyYW5zbGF0aW9uIHN1cHBvcnRlZCAqLw0KPj4gICAgICBib29sIHBhc2lkOyAgICAgICAgICAg
ICAgICAgICAgIC8qIFdoZXRoZXIgdG8gc3VwcG9ydCBQQVNJRCAqLw0KPj4gKyAgICBib29sIGZz
MWdwOyAgICAgICAgICAgICAgICAgICAgIC8qIEZpcnN0IFN0YWdlIDEtR0J5dGUgUGFnZSBTdXBw
b3J0ICovDQo+Pg0KPj4gICAgICAvKg0KPj4gICAgICAgKiBQcm90ZWN0cyBJT01NVSBzdGF0ZXMg
aW4gZ2VuZXJhbC4gIEN1cnJlbnRseSBpdCBwcm90ZWN0cyB0aGUNCj4+IGRpZmYgLS1naXQgYS9o
dy9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IGluZGV4IGJi
M2VkNDgyODEuLjhiNDBhYWNlOGIgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11
LmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTM3NzksNiArMzc3OSw3
IEBAIHN0YXRpYyBQcm9wZXJ0eSB2dGRfcHJvcGVydGllc1tdID0gew0KPj4gICAgICBERUZJTkVf
UFJPUF9CT09MKCJ4LXBhc2lkLW1vZGUiLCBJbnRlbElPTU1VU3RhdGUsIHBhc2lkLCBmYWxzZSks
DQo+PiAgICAgIERFRklORV9QUk9QX0JPT0woImRtYS1kcmFpbiIsIEludGVsSU9NTVVTdGF0ZSwg
ZG1hX2RyYWluLCB0cnVlKSwNCj4+ICAgICAgREVGSU5FX1BST1BfQk9PTCgiZG1hLXRyYW5zbGF0
aW9uIiwgSW50ZWxJT01NVVN0YXRlLA0KPmRtYV90cmFuc2xhdGlvbiwgdHJ1ZSksDQo+PiArICAg
IERFRklORV9QUk9QX0JPT0woIngtY2FwLWZzMWdwIiwgSW50ZWxJT01NVVN0YXRlLCBmczFncCwg
dHJ1ZSksDQo+PiAgICAgIERFRklORV9QUk9QX0VORF9PRl9MSVNUKCksDQo+PiAgfTsNCj4+DQo+
PiBAQCAtNDUwNyw3ICs0NTA4LDkgQEAgc3RhdGljIHZvaWQgdnRkX2NhcF9pbml0KEludGVsSU9N
TVVTdGF0ZSAqcykNCj4+ICAgICAgLyogVE9ETzogcmVhZCBjYXAvZWNhcCBmcm9tIGhvc3QgdG8g
ZGVjaWRlIHdoaWNoIGNhcCB0byBiZSBleHBvc2VkLg0KPiovDQo+PiAgICAgIGlmIChzLT5zY2Fs
YWJsZV9tb2Rlcm4pIHsNCj4+ICAgICAgICAgIHMtPmVjYXAgfD0gVlREX0VDQVBfU01UUyB8IFZU
RF9FQ0FQX0ZMVFM7DQo+PiAtICAgICAgICBzLT5jYXAgfD0gVlREX0NBUF9GUzFHUDsNCj4+ICsg
ICAgICAgIGlmIChzLT5mczFncCkgew0KPj4gKyAgICAgICAgICAgIHMtPmNhcCB8PSBWVERfQ0FQ
X0ZTMUdQOw0KPj4gKyAgICAgICAgfQ0KPj4gICAgICB9IGVsc2UgaWYgKHMtPnNjYWxhYmxlX21v
ZGUpIHsNCj4+ICAgICAgICAgIHMtPmVjYXAgfD0gVlREX0VDQVBfU01UUyB8IFZURF9FQ0FQX1NS
UyB8IFZURF9FQ0FQX1NMVFM7DQo+PiAgICAgIH0NCj4+IC0tDQo+PiAyLjM0LjENCj4+DQo+DQo+
VGhhbmtzDQoNCg==

