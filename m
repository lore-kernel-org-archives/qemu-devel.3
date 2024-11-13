Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C229D41C17
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 08:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tB93r-0002eb-KC; Wed, 13 Nov 2024 03:49:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tB93p-0002eM-9n
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 03:49:13 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tB93m-0007Ko-Tu
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 03:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731487751; x=1763023751;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BpjAY9AzL5x5KZX2qxgLQ+3z8wVovt0Ej3VwkOeUc9Y=;
 b=COpfYSCoxLhfLs0e6mfvYaEFC3tmveaXlnYqasaIFOYYYkSaFs0+CuDg
 ZVkwWfhixmW/sdYCIw2Gg7Ld3uQYuKyxzDiwUYGf4AIT9gJQrXorRfUQa
 sjYJE+qo0+tcU+9lUPQooI+FkXxGdyCdxL5zAm+z9eWT8MaiECjMwBq12
 ghzadummHLhvM4H1sGUXrHmTAPABHNLG13Crp8lUZ1TywlhkxYqFqmr7U
 3cXkpGoKfIv/ZqZdHQ138jTh7heW+xFsuNt2LG2ts4f/hWlZZD7tCXvJC
 L0bmpbVZqsqxNBHdfq4K0ESRJmUEstyntUDRPl6ZjIGn4jtj6SPAlGvM5 g==;
X-CSE-ConnectionGUID: M9CstbDEQ5Spd+aakcbgVw==
X-CSE-MsgGUID: CaDOvxqJT2+TaWPs7hcUAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="48821730"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="48821730"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2024 00:49:07 -0800
X-CSE-ConnectionGUID: hcbxJOQhToWkSiv3DUOkQw==
X-CSE-MsgGUID: RFBQ5JbESFaXUPtBQcnKfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; d="scan'208";a="87793715"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Nov 2024 00:49:06 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 00:49:05 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 13 Nov 2024 00:49:05 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 00:49:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gj+GATj1zb+YzZDZ9gspffNXiGqsBeliwj7i27Sf+DfmhCPg89f4gEwxXtWggOH/uvT6xWm952GpLf1L6bQ6ri0lA/lgfL+SQ+Pw3bcYX4K6mD8/K5wbcqvlAIpmZk/6eG+bMjjbSG+LeqPSprjcU/ZMLJG3vju0uJMkG2zmT5DXLg+MGS2RwhRj2BRlKpdbLcgIrgxl3PJ0a5kpF8uDReFjPaKwrakwwJHGn+/neNFBesDU3rZ/2/X90XX8zRXp7MENVfVlDXYvZq+1mDL6lMs3iIFUCMAhNPRrOHCWxrvczbgxN8xuzPUh5wrXJgKkINvGo8I/hpn97/WhQdUd3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpjAY9AzL5x5KZX2qxgLQ+3z8wVovt0Ej3VwkOeUc9Y=;
 b=wlhqJMlW+MaO8j09+e2QwKDWXAM35tU9bY4dXjCYnl5FMVfNpfxie5/wo9WmYXhHONw9z4Wn7UATiHp/eBZ79Mubuq4ln3+cogjFuzVle2DKFkOzB9kTVrXiNdM62MrSpiZR8UncYl4YLl0a6D9Kx5NmURfT6DxyREZOthuVsUgwrbYstGDAkgsb4SV/pQG9FZFfwHMPAdPMfZ6dcZolhGn254xCTtRBVNa/L8y/lI5g2e6fkuqd8EEr0ZK+eeEGjIq+8JAPkSo34dMibaqeBDZs3Ah+p992ql4y+nhoOS/fXPl/dTqZLrG/z8rjoU7nN/9bV+nXCi8t2rUVZOZ20w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY8PR11MB7193.namprd11.prod.outlook.com (2603:10b6:930:91::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 08:49:03 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 08:49:02 +0000
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
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v5 08/20] intel_iommu: Check stage-1 translation result
 with interrupt range
Thread-Topic: [PATCH v5 08/20] intel_iommu: Check stage-1 translation result
 with interrupt range
Thread-Index: AQHbNBUgojqICTTWREmOl85RD5a2urK0yfEAgAAdsfA=
Date: Wed, 13 Nov 2024 08:49:02 +0000
Message-ID: <SJ0PR11MB6744955D0692A4D225108831925A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
 <20241111083457.2090664-9-zhenzhong.duan@intel.com>
 <04f7b400-b754-417b-8c17-7605d9676e76@eviden.com>
In-Reply-To: <04f7b400-b754-417b-8c17-7605d9676e76@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY8PR11MB7193:EE_
x-ms-office365-filtering-correlation-id: 8185b8e6-47cb-49a4-3663-08dd03c005e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?d2RjU0VSc3l1WmxUNVZDbFZkZ0xEN096eUplVGNyUVZsZS9Qb0NNT1BQcjVT?=
 =?utf-8?B?K3IyWU5wR3o0T08xQ2RERWVLMDlxUVRkMnhFZGR5SjNDMFpOQy9YWU5zVFYr?=
 =?utf-8?B?ekl3V0RiK1hDZUZHcUZvNEFxaXRFQ0RBQm4vZGhKL3UyMzRRQ3BRUTlJY1JZ?=
 =?utf-8?B?MG5lQ1MrRXZ2OXk5TllGSSthNldlY0lyWTh4NzkvOTlCQldyM2xicyszYXdU?=
 =?utf-8?B?cWhSODJTb1J4NGFJbkExdHR5RHlyODJiNk5MMDBIYXNtZ0IzUDVWWGxMTy9l?=
 =?utf-8?B?aE9PMnlOVUp2NHRHRjNVU0ZzSEpzTHQzVWVFVURtaFJ1aUhxY3c4TTRmcmZs?=
 =?utf-8?B?cGR6UmZNcSt2cXVld0V3YzZ5UEpGNVRTK3R6Q0daaytiYjUvdlN4ZFc5YjZZ?=
 =?utf-8?B?R2c1clEvTERWZUVqRllyM09JaFU4REI0cGxvOW00TUs2Mm83Rnp3TnQ4cEx2?=
 =?utf-8?B?QlI3c3dCOGYrMmtnajhrNTliV2dXTjA1YWFoWWVWbUJRRDJiZk5hWDd1T3VC?=
 =?utf-8?B?UkZZTDRDK0p0djFsWXZ4M3dsSzZNVzR1M2hudVlQSFJac3NUeHhaalRIblZw?=
 =?utf-8?B?SEo3RnRZMmtSOXpVK2hwelZIZ013NkF1QnFWclFOckVXblREN2lCSjRrWTlS?=
 =?utf-8?B?bW5PZTdvYXBtdGZsUFB0TnVkajcyRHpheFFtMFI0TW0yQldBejJkbjBlSXdC?=
 =?utf-8?B?RUw1ZG13SUJiZ1VxNXpoWXduc2tsRUkraWluWjFhTGM4ZFNkTml2eThQVkZH?=
 =?utf-8?B?WWxBaTRLN252RTdSNWVYSjFod3dKeUM2emF1RlV6SWVsZ1kweFE1eTFSVzFY?=
 =?utf-8?B?dU5jVm5ianRXVVlnS2dVZkQzMGJtdkkvdXhMS3FuTUUxRjhibWc1UkxzdjJL?=
 =?utf-8?B?NnFXV204UjlwMGowTFBKc3drMXR5emZNN29hTFhZUTFYNmRmQjZyZjd6NWI0?=
 =?utf-8?B?dzR4d3B3SEtNQmJxVXpldUpwaldoeXZHR2tadXVHZi9pYjBuc0xSZWZ6QWhN?=
 =?utf-8?B?UWFVNkZIcks5ZVg0NE1pY3AvRTZ5a0xLa3hxd0pLVi9oTDNrSXJlaWMzM2FL?=
 =?utf-8?B?bWdWT2g0cTgvQ1poWjVGT0FPT2dDZDNRVHc1ZU43b1hBUmpUR3VQRzg0MmUy?=
 =?utf-8?B?VEI4ZkpiR0Z3TFZsR3IxL1BzZm54UFlFTEkxSytBZGdtK3FhMDA2cVdZc3N2?=
 =?utf-8?B?WGVCZERXUUdZaXU1YzU4UU9Nc0c3bUhvNlQ1RmVKd1BLUG5zckRLOTZEVThi?=
 =?utf-8?B?aTRUVTF4RytnMUdhcmFjRUV2TFFubXBuYkphTTAxWkZ5M3NGWWxXenc5SFJC?=
 =?utf-8?B?ZmdnS0ZlNDRyalpKaXozQ3RvMHF3RU1TTlpFanNhd1BHYldLcVNXdm14UTdp?=
 =?utf-8?B?aHJ4dFFjcVdkMlM5Q3RaeUhFKythYlNaUFBCdnFBV2syUVhPU2NzWGdYeHZZ?=
 =?utf-8?B?SEMzejEwTWV0aWlFaSt6N0Q5N2hKZjFWMk9LT0dUWmVsZUJ0cXFFbVptd2F5?=
 =?utf-8?B?ZlI0cWd4Mm9sRUFsK0RPdCtBd2d0VzI1L2NJT3oySGJaWVRJUVRwbGxHWm9p?=
 =?utf-8?B?U0Nmd29qTkViYzZzVTA0UWdMYVcrWHFFSzM2NE5EeU91VUl1N2REYmFhR0pr?=
 =?utf-8?B?WExOekdsSHZGUzVaRTBRdHdJZzJTUjNHamswTnlZNXpXUWFlV0JUb1VUTHhL?=
 =?utf-8?B?blJxbEwzT2MrbVZkdVljNStWemYreGc2Tm0wUDZ2aVNpekRVSys0Z3BSOVZE?=
 =?utf-8?B?RXEvcTlLTGFYL2F4Y1dkLzdKSFR3UU5SRXdHMWErN1VnU1VXS2dVMXRKQVpx?=
 =?utf-8?Q?ZkovaNmYXfeJXGDm3juphyctaX2D3LMoaC3fs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Szl2NThEUVRCL0V0WjZVamQvZFU4bGRnNU9wbFBBdktWMjNoMVJoNkhNZ05t?=
 =?utf-8?B?Z1RPdGtRNWFYY2VlTHpTU0YzeXo3UDJyc1cxbGlWMjJlRHVkWXdGRmxsdkNz?=
 =?utf-8?B?YU9WRnhGdy9FaTNWL2h6enQvdUlnUnRQVUI0QWo0a2dIb2Z3NzQ3ajM2TzFO?=
 =?utf-8?B?aXRwZU5lZzNmV05FZmlSN29ETUd1VFhLVnUvQjBOZVk3UDVJd3VqRy83VFVZ?=
 =?utf-8?B?SDUyd1U3WWR5SUczcHVnb05iN1ZqdTh2a3Y0enlxSGpaQ3BRanJHenp1VlZ3?=
 =?utf-8?B?R3dEV25POFA0cndkQjFyUG4rZ3VqY2VkMElweExxT3VxRE4rc2R4Mm11UWw1?=
 =?utf-8?B?cnVKZ2NFNWJZYjFDWjZjOTZlM2ZNVCtCRVE3ZUJRaW5mTnJFTGJhYXN4cS8y?=
 =?utf-8?B?MEhGTUhyNiswTWdlc1dvQWt5dzFzY3paYktUaWdhRmJYT0FSdEtjYS9EUldW?=
 =?utf-8?B?Yy9WSVRtVlQ1NVpxcFdxNi9OY3ZzZzhZUFpQcmI1ak95dHlJQ0dRWEVrdGZH?=
 =?utf-8?B?QitJOGtVY0tEY1NqSWo2OVhJNUxKbkR2ZE03UUVFU3hrMHZrVGlEVGRENmlB?=
 =?utf-8?B?Ym40WEZJODM1WG5IZ2pDOVFZOGxLZjc2RUxFRzdHSmcxU0FRQmtVSStlQnNP?=
 =?utf-8?B?YjJjWmd3T3dCMDBVS2VOVWo2VXczRmpMckZoN2o2aERhMHpRcE5FUkh0STVY?=
 =?utf-8?B?cmxCRzF5bGxic2dSV2VFN3BZTlBuajBySzRLYjBwcHhZQnYxQjhuelBCUHNw?=
 =?utf-8?B?cmZNRWZoTjFOY3Y5bGpjNUtxa3RUMFE5VzZsT3BKcUVsYUZSd2tRNi9tTUU1?=
 =?utf-8?B?NCtqVTdwQmFNRXVZM1RKcmNEWlF3K2QzZGhaVVgzMG9vcFhESlFBOEh1YXU3?=
 =?utf-8?B?SEZ5R2Z6OHVIK3dHQVNwSkwwSk1vRWFLNVA4V3lENTU4dGN6dXlLelkxNkQ4?=
 =?utf-8?B?Z1FWcFVCVnVoOHBKUGV2QWRSYjc2bnZnZ3NXL01pLzFhb1N3S1pZT0lsU0Qz?=
 =?utf-8?B?eVVYelZIZUZoVmxqZkk4d3c0ZHpzZFBtR2hrUzUrdUFNRXhGbE9WbzN2VXlD?=
 =?utf-8?B?NzdMdUROWHpod0orQmx6RzFMdlpybVB2QU1IVUxhMGZtYVp5d0l5VTY1dkF1?=
 =?utf-8?B?MXdaa3VPTERTaW9VNmllalBFalp2bU1tU2doWEtkd3Q3UFhuVjFySTlPeGVZ?=
 =?utf-8?B?WTBSOFo4ZDh2Y2p4V0tSUTdVNjVyQksyenFlOGg5UzdaaWl0S2YvcUhLdXFu?=
 =?utf-8?B?bFpQcTl1V0FjUGFLTVlyaFBEYXZ3TzFpUkQyYkJTODBiaXdiVEFmd1FoVlRl?=
 =?utf-8?B?U0s1RTByMy9YZURXWkFNRWIyNzN3UEg4c2ZnVXZ5S3hoVU1JUzVOU0dqbDFa?=
 =?utf-8?B?UlRVdE54YTY2Mmtyc3ZhYi9DK0czd2lZUmlqVFBzYzhOL0xQdU1TZW4xZDA4?=
 =?utf-8?B?UHJPR1ZFTG1QK1FYQktRbHp3RVhRbkFHVHhCb2RqVkNRUi8xeVdGTkgzcDlZ?=
 =?utf-8?B?WUdUcXplVWVzMmFRMXRTQ3B2S0F2d21wcVJVNG9LOVJtWXNxMTlMWEFiNTA1?=
 =?utf-8?B?WEoyMmFGMm5hZlVYbnZrQ0VQc1J0N2FEWU82Q3grOE93UUpvdGNGK0xjVThm?=
 =?utf-8?B?ekNmVy9wTDd1ajdhb0MyT1UvTEcvOVNrQVNFWnhsSHM2WkRFb3BEc21aMmFK?=
 =?utf-8?B?aEhYc0VpdTVhdGY4OVpQY21mRWVQUEVXdXhRbjlCd1Q0R1dZUWhQRmQ3cFRG?=
 =?utf-8?B?UHJOQ01QUmYvUEdqMmRWejJVMEl5M2NuU0tqb2wzRkNPNGZuSlo3ZjlMWWxy?=
 =?utf-8?B?NFdKejdVdUllcU9wRDBtZmN6SHNST2pBWjlkWmR2QWpZcFJhZ3F0eXUrM0FB?=
 =?utf-8?B?L0c3ZlY3M1kyRTU4Nk9lZW9aUnk2R0FKQWFYai9TNXNrV2hzdUVOQ0JnR1JU?=
 =?utf-8?B?cFBUZFRPRDM4T05qK2NVeVY5M1BqaFZna3BjL0QwUTAzeVdWRVVPYUtaSS9W?=
 =?utf-8?B?NjFFWVJ3RE96SzJDeXVqT0sxWStEY0dtblFSQXgxWklhN0pSbmZUMU9rWUdu?=
 =?utf-8?B?dHZ6UGFzOE4rbnpLK1BTQ3VERVpQNUJlT2RSRWhFOEhrSFdJYzlyaUZvaHho?=
 =?utf-8?Q?N1EK0/d+yQRtV7jZA2texrfd1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8185b8e6-47cb-49a4-3663-08dd03c005e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 08:49:02.3750 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yuK+0uIeSg7QEm0rQqvl1lV8udTot01DQhzjZOjlU5P1obQknQjfGVpioNxXVfs8F3yMnLgbMievTRZ9v7+Ei5XyiAei4bUaZ2e5O22/G6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7193
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U2VudDogV2VkbmVzZGF5
LCBOb3ZlbWJlciAxMywgMjAyNCAyOjU2IFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2NSAwOC8y
MF0gaW50ZWxfaW9tbXU6IENoZWNrIHN0YWdlLTEgdHJhbnNsYXRpb24gcmVzdWx0IHdpdGgNCj5p
bnRlcnJ1cHQgcmFuZ2UNCj4NCj4NCj5PbiAxMS8xMS8yMDI0IDA5OjM0LCBaaGVuemhvbmcgRHVh
biB3cm90ZToNCj4+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2ht
ZW50cyBvciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMNCj5lbWFpbCBjb21lcyBmcm9tIGEga25v
d24gc2VuZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPj4NCj4+DQo+PiBQ
ZXIgVlQtZCBzcGVjIDQuMSBzZWN0aW9uIDMuMTUsICJVbnRyYW5zbGF0ZWQgcmVxdWVzdHMgYW5k
IHRyYW5zbGF0aW9uDQo+PiByZXF1ZXN0cyB0aGF0IHJlc3VsdCBpbiBhbiBhZGRyZXNzIGluIHRo
ZSBpbnRlcnJ1cHQgcmFuZ2Ugd2lsbCBiZQ0KPj4gYmxvY2tlZCB3aXRoIGNvbmRpdGlvbiBjb2Rl
IExHTi40IG9yIFNHTi44LiINCj4+DQo+PiBUaGlzIGFwcGxpZXMgdG8gYm90aCBzdGFnZS0xIGFu
ZCBzdGFnZS0yIElPTU1VIHBhZ2UgdGFibGUsIG1vdmUgdGhlDQo+PiBjaGVjayBmcm9tIHZ0ZF9p
b3ZhX3RvX3NscHRlKCkgdG8gdnRkX2RvX2lvbW11X3RyYW5zbGF0ZSgpIHNvIHN0YWdlLTENCj4+
IHBhZ2UgdGFibGUgY291bGQgYWxzbyBiZSBjaGVja2VkLg0KPj4NCj4+IEJ5IHRoaXMgY2hhbmNl
LCB1cGRhdGUgdGhlIGNvbW1lbnQgd2l0aCBjb3JyZWN0IHNlY3Rpb24gbnVtYmVyLg0KPj4NCj4+
IFN1Z2dlc3RlZC1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+
PiAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyB8IDQ4ICsrKysrKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyks
IDIzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11
LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IGluZGV4IDRjYzRkNjY4ZmMuLmU2NTE0MDFk
YjEgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+ICsrKyBiL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTExMzgsNyArMTEzOCw2IEBAIHN0YXRpYyBpbnQgdnRk
X2lvdmFfdG9fc2xwdGUoSW50ZWxJT01NVVN0YXRlICpzLA0KPlZURENvbnRleHRFbnRyeSAqY2Us
DQo+PiAgICAgICB1aW50MzJfdCBvZmZzZXQ7DQo+PiAgICAgICB1aW50NjRfdCBzbHB0ZTsNCj4+
ICAgICAgIHVpbnQ2NF90IGFjY2Vzc19yaWdodF9jaGVjazsNCj4+IC0gICAgdWludDY0X3QgeGxh
dCwgc2l6ZTsNCj4+DQo+PiAgICAgICBpZiAoIXZ0ZF9pb3ZhX3NsX3JhbmdlX2NoZWNrKHMsIGlv
dmEsIGNlLCBhd19iaXRzLCBwYXNpZCkpIHsNCj4+ICAgICAgICAgICBlcnJvcl9yZXBvcnRfb25j
ZSgiJXM6IGRldGVjdGVkIElPVkEgb3ZlcmZsb3cgKGlvdmE9MHglIiBQUkl4NjQgIiwiDQo+PiBA
QCAtMTE5MSwyOCArMTE5MCw3IEBAIHN0YXRpYyBpbnQgdnRkX2lvdmFfdG9fc2xwdGUoSW50ZWxJ
T01NVVN0YXRlICpzLA0KPlZURENvbnRleHRFbnRyeSAqY2UsDQo+PiAgICAgICAgICAgbGV2ZWwt
LTsNCj4+ICAgICAgIH0NCj4+DQo+PiAtICAgIHhsYXQgPSB2dGRfZ2V0X3B0ZV9hZGRyKCpzbHB0
ZXAsIGF3X2JpdHMpOw0KPj4gLSAgICBzaXplID0gfnZ0ZF9wdF9sZXZlbF9wYWdlX21hc2sobGV2
ZWwpICsgMTsNCj4+IC0NCj4+IC0gICAgLyoNCj4+IC0gICAgICogRnJvbSBWVC1kIHNwZWMgMy4x
NDogVW50cmFuc2xhdGVkIHJlcXVlc3RzIGFuZCB0cmFuc2xhdGlvbg0KPj4gLSAgICAgKiByZXF1
ZXN0cyB0aGF0IHJlc3VsdCBpbiBhbiBhZGRyZXNzIGluIHRoZSBpbnRlcnJ1cHQgcmFuZ2Ugd2ls
bCBiZQ0KPj4gLSAgICAgKiBibG9ja2VkIHdpdGggY29uZGl0aW9uIGNvZGUgTEdOLjQgb3IgU0dO
LjguDQo+PiAtICAgICAqLw0KPj4gLSAgICBpZiAoKHhsYXQgPiBWVERfSU5URVJSVVBUX0FERFJf
TEFTVCB8fA0KPj4gLSAgICAgICAgIHhsYXQgKyBzaXplIC0gMSA8IFZURF9JTlRFUlJVUFRfQURE
Ul9GSVJTVCkpIHsNCj4+IC0gICAgICAgIHJldHVybiAwOw0KPj4gLSAgICB9IGVsc2Ugew0KPj4g
LSAgICAgICAgZXJyb3JfcmVwb3J0X29uY2UoIiVzOiB4bGF0IGFkZHJlc3MgaXMgaW4gaW50ZXJy
dXB0IHJhbmdlICINCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICIoaW92YT0weCUiIFBS
SXg2NCAiLCBsZXZlbD0weCUiIFBSSXgzMiAiLCAiDQo+PiAtICAgICAgICAgICAgICAgICAgICAg
ICAgICAic2xwdGU9MHglIiBQUkl4NjQgIiwgd3JpdGU9JWQsICINCj4+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICJ4bGF0PTB4JSIgUFJJeDY0ICIsIHNpemU9MHglIiBQUkl4NjQgIiwgIg0K
Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgInBhc2lkPTB4JSIgUFJJeDMyICIpIiwNCj4+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBpb3ZhLCBsZXZlbCwgc2xwdGUs
IGlzX3dyaXRlLA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgeGxhdCwgc2l6ZSwgcGFz
aWQpOw0KPj4gLSAgICAgICAgcmV0dXJuIHMtPnNjYWxhYmxlX21vZGUgPyAtVlREX0ZSX1NNX0lO
VEVSUlVQVF9BRERSIDoNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLVZU
RF9GUl9JTlRFUlJVUFRfQUREUjsNCj4+IC0gICAgfQ0KPj4gKyAgICByZXR1cm4gMDsNCj4+ICAg
fQ0KPj4NCj4+ICAgdHlwZWRlZiBpbnQgKCp2dGRfcGFnZV93YWxrX2hvb2spKGNvbnN0IElPTU1V
VExCRXZlbnQgKmV2ZW50LCB2b2lkDQo+KnByaXZhdGUpOw0KPj4gQEAgLTIwNjQsNiArMjA0Miw3
IEBAIHN0YXRpYyBib29sDQo+dnRkX2RvX2lvbW11X3RyYW5zbGF0ZShWVERBZGRyZXNzU3BhY2Ug
KnZ0ZF9hcywgUENJQnVzICpidXMsDQo+PiAgICAgICB1aW50OF90IGFjY2Vzc19mbGFnczsNCj4+
ICAgICAgIGJvb2wgcmlkMnBhc2lkID0gKHBhc2lkID09IFBDSV9OT19QQVNJRCkgJiYgcy0+cm9v
dF9zY2FsYWJsZTsNCj4+ICAgICAgIFZURElPVExCRW50cnkgKmlvdGxiX2VudHJ5Ow0KPj4gKyAg
ICB1aW50NjRfdCB4bGF0LCBzaXplOw0KPj4NCj4+ICAgICAgIC8qDQo+PiAgICAgICAgKiBXZSBo
YXZlIHN0YW5kYWxvbmUgbWVtb3J5IHJlZ2lvbiBmb3IgaW50ZXJydXB0IGFkZHJlc3Nlcywgd2UN
Cj4+IEBAIC0yMTczLDYgKzIxNTIsMjkgQEAgc3RhdGljIGJvb2wNCj52dGRfZG9faW9tbXVfdHJh
bnNsYXRlKFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzLCBQQ0lCdXMgKmJ1cywNCj4+ICAgICAgICAg
ICByZXRfZnIgPSB2dGRfaW92YV90b19zbHB0ZShzLCAmY2UsIGFkZHIsIGlzX3dyaXRlLCAmcHRl
LCAmbGV2ZWwsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnJlYWRz
LCAmd3JpdGVzLCBzLT5hd19iaXRzLCBwYXNpZCk7DQo+PiAgICAgICB9DQo+PiArICAgIGlmICgh
cmV0X2ZyKSB7DQo+PiArICAgICAgICB4bGF0ID0gdnRkX2dldF9wdGVfYWRkcihwdGUsIHMtPmF3
X2JpdHMpOw0KPj4gKyAgICAgICAgc2l6ZSA9IH52dGRfcHRfbGV2ZWxfcGFnZV9tYXNrKGxldmVs
KSArIDE7DQo+PiArDQo+PiArICAgICAgICAvKg0KPj4gKyAgICAgICAgICogUGVyIFZULWQgc3Bl
YyA0LjEgc2VjdGlvbiAzLjE1OiBVbnRyYW5zbGF0ZWQgcmVxdWVzdHMgYW5kIHRyYW5zbGF0aW9u
DQo+PiArICAgICAgICAgKiByZXF1ZXN0cyB0aGF0IHJlc3VsdCBpbiBhbiBhZGRyZXNzIGluIHRo
ZSBpbnRlcnJ1cHQgcmFuZ2Ugd2lsbCBiZQ0KPj4gKyAgICAgICAgICogYmxvY2tlZCB3aXRoIGNv
bmRpdGlvbiBjb2RlIExHTi40IG9yIFNHTi44Lg0KPj4gKyAgICAgICAgICovDQo+PiArICAgICAg
ICBpZiAoKHhsYXQgPD0gVlREX0lOVEVSUlVQVF9BRERSX0xBU1QgJiYNCj4+ICsgICAgICAgICAg
ICAgeGxhdCArIHNpemUgLSAxID49IFZURF9JTlRFUlJVUFRfQUREUl9GSVJTVCkpIHsNCj4+ICsg
ICAgICAgICAgICBlcnJvcl9yZXBvcnRfb25jZSgiJXM6IHhsYXQgYWRkcmVzcyBpcyBpbiBpbnRl
cnJ1cHQgcmFuZ2UgIg0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICIoaW92YT0w
eCUiIFBSSXg2NCAiLCBsZXZlbD0weCUiIFBSSXgzMiAiLCAiDQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgInB0ZT0weCUiIFBSSXg2NCAiLCB3cml0ZT0lZCwgIg0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICJ4bGF0PTB4JSIgUFJJeDY0ICIsIHNpemU9MHglIiBQ
Ukl4NjQgIiwgIg0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJwYXNpZD0weCUi
IFBSSXgzMiAiKSIsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18s
IGFkZHIsIGxldmVsLCBwdGUsIGlzX3dyaXRlLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHhsYXQsIHNpemUsIHBhc2lkKTsNCj4NCj5IaSBaaGVuemhvbmcsDQo+DQo+U2hvdWxk
bid0IHdlIGFkZCB0aGUgcGd0dCB2YWx1ZSB0byB0aGlzIHRyYWNlIGFzIGl0IGNhbiBub3cgYmUg
Z2VuZXJhdGVkDQo+YnkgYm90aCBGTCBhbmQgU0w/DQoNCkhpIENsZW1lbnQsDQoNCldlIGRvbid0
IGFsd2F5cyBoYXZlIGEgcGd0dCB2YWx1ZSB0byBkdW1wLCBlLmcuLCB3aGVuIHZJT01NVSBpcyBp
biBsZWdhY3kgbW9kZS4NCk1lYW53aGlsZSB3ZSBoYXZlIG90aGVyIHdheSB0byBnZXQgcGd0dCBp
ZiB0aGVyZSBpcywgZS5nLiwgZnJvbSBxZW11IGNtZGxpbmUuDQpQZ3R0IGlzIGFsc28gdW5yZWxh
dGVkIHRvIHRoZSBlcnJvciBpdHNlbGYsIHNvIEknZCBsaWtlIHRvIHNraXAgcGd0dCBkdW1wIHRv
IGJlIGEgYml0IHNpbXBsZS4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0K

