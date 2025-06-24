Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC94C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 02:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTtiu-00044I-QX; Mon, 23 Jun 2025 22:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTtis-000441-J1
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 22:49:22 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTtip-0000UI-Jh
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 22:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750733359; x=1782269359;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6NYndvEY0PQW5imrkbwJa0Z+UTDaltXI6cJ9Ymk5H8o=;
 b=bbuotFaRt/6SJDsG7WGQR68LJvRu2Rn8ERc1z4y8XPSUyCPzEpqGoe33
 0io1qip/URqSkq1R7YMsqmv52hyG16pGFscgnMTh3zb2Kidoq0N72isTB
 GQCNcWN4byRS+1JWQS/fJwzZiKBJLI+wbCP1WQOCulBvO623i5o4MzZLy
 EVFzevxXN8Vk5FGU0qJr9uFaoJ9p22LQ7mGg3mj70sF6/V0gSvrVnpKv9
 zVrn3SCzXXJnaXxsEx/i15CQyttwwLS/ttv4r6vxFaICwSc7C1JzjG4oE
 SYZrPbyNcxTDjgTYnBm8qlPoucAdb2ZJ6v2xf620V3daVQlmIwHWw3mAU A==;
X-CSE-ConnectionGUID: 7pM6kxtNTkKuyVC6Q9kYYw==
X-CSE-MsgGUID: 1bo9V5d5TTaJgiIpJF15eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="56633233"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; d="scan'208";a="56633233"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 19:49:13 -0700
X-CSE-ConnectionGUID: URkuZAYpTCKUNnYRrmT/6w==
X-CSE-MsgGUID: c+rzFrDYRdO/M6LJLViH5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; d="scan'208";a="188988825"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 19:49:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 19:49:11 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 23 Jun 2025 19:49:11 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.89)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 19:49:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1osKsBE2rTik8BEVBuLTaMnMXOlCgrMUkCEUlOzRB9OIes7f2uDrVE0pQrS4kRVOT60ADrgsF67QdG1/IOpxGo0idp5XaZQglx+CjzTxlcsOtv53TdNh0+RXO0qxN1yFCJcMLukOS+OeuUwXKi1wDoDkF4eWlvzYS/HK6vlagTs8jFAUm7+3vuZIIL97DYGXe8ZbvnKVw5zqwjyYTdgZsyvT97tW5Ls9bPKWXlcXAVVSZRDKot08skmTbp6adG47KcQuHdPGlctgJ3Fl2osOmABcJP7B1x8vZXnUUl2duCoeAq7cYImZohJYwKe3w0DEojykMipy2iZWZKJyUQunw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NYndvEY0PQW5imrkbwJa0Z+UTDaltXI6cJ9Ymk5H8o=;
 b=rz34EdLiSdFE5tN/PpCZ20S63DJDlIPyGHlxOVvWI8JTHap8dxpPFz7f5N+zwdJA0QnvUs6Osjy6e8tNVeMQV6gVSVOhpRuuaIOdK35ZWRqkIONZVud0xz3MQtk9tYQCBn5pEyfv/oZSTwfwsseXDelKbyT59hdSUJ82BOPjKVBTsb3LqMriAS2K+BoKHlFOQeoavxe/cOdcQRf8mcOnfM6PmusrDQ/sQth06Mf+k80uRZ9OB1i2U0tcsNx15iLcIXPlxbI9JIx36hbM2SWN9a6iKdJHZPj1V/UxUc665heBKh5GnCiPDj6MVmTLiHuwKoBh37WcCy0mWgBR+Eu9ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA0PR11MB7258.namprd11.prod.outlook.com (2603:10b6:208:43d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Tue, 24 Jun
 2025 02:48:50 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Tue, 24 Jun 2025
 02:48:50 +0000
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
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v2 09/19] intel_iommu: Introduce two helpers
 vtd_as_from/to_iommu_pasid_locked
Thread-Topic: [PATCH v2 09/19] intel_iommu: Introduce two helpers
 vtd_as_from/to_iommu_pasid_locked
Thread-Index: AQHb4bQosuj8+0B4mECFK/DRFdJ0t7QL/2WAgAWe78A=
Date: Tue, 24 Jun 2025 02:48:50 +0000
Message-ID: <IA3PR11MB9136359F208103BA9F3DB8F79278A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-10-zhenzhong.duan@intel.com>
 <3babbbd5-23e3-4b6b-9f9c-e879d4ddb125@redhat.com>
In-Reply-To: <3babbbd5-23e3-4b6b-9f9c-e879d4ddb125@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA0PR11MB7258:EE_
x-ms-office365-filtering-correlation-id: 2ef32f10-0560-42b9-8844-08ddb2c9a617
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MU1PdzhaVmtGNjg4ZWFvZTRHWjd1cG5EcGVkYnFSS20wVzVsaHZyMTJBOE1X?=
 =?utf-8?B?RnQyekc0SGNMbUR1Q0IyV2lnOFFUSU1WWURJQndiUks2Wm1RWUp5eUFib0RI?=
 =?utf-8?B?M2NHRk4yZktzT0JMY1pMbkdGVFZUd0VlWUpNUUhMUjM5c0N5dUx3ZzBVT0hy?=
 =?utf-8?B?SUdpVFl5cGQxL1Z1K3dvOTRLYmRUWHErWG4vZzFxZjM2bnA2ejhucGxFV2ZP?=
 =?utf-8?B?MFhBUEgxNFZSaFgzdmgxNzFNanluREM2aVQrQmZvZWFXTjVQQlZHRktDUFRh?=
 =?utf-8?B?MW5QTThQQjk4N0tta2lJWXppQ3JFeE5Nc0NmZnZGR3dlMVpnbGs3NkdjRlJ3?=
 =?utf-8?B?c08xOFNwMWxKWmpBeWlkbmM4ZGxQRnlzRThwMkFMWCtBZ01jLzJ4Q3pWS2xq?=
 =?utf-8?B?ajUvZGV1czdBTGdiRFYrSnkzZVQ5MTkzM3JoNGk0a0RkdU5NZWRsZ3kxVmNP?=
 =?utf-8?B?Vlp4dmhQYThNNWFOTXdLZ0RyYlhPYitvWDdVMDRyS0tITmZjZFF4TmNyaFRV?=
 =?utf-8?B?VFZRem9CVUdTTTlUQ29ZSG5FRmE2UFJNRlpDWGRFVXVEMlZ1ZzI1SXpXTVY2?=
 =?utf-8?B?UERvZ1NLeXJweERscU5WZnpuNkpkbHZnbGZiK2tUTkx1dHcwWHN0aVhEOXFz?=
 =?utf-8?B?NnFQN0xuajlFbEowak4rWWRxTmNjSFBiak1NTG04WlJ0Z1ppZXFlL3RsZm5h?=
 =?utf-8?B?cXI1OEg1eE5lZVhIVTRzVmtNclUzVG5pR2lFSVpmU0hXaEwzZldNNVcxK0JW?=
 =?utf-8?B?Z21jKzhpb1NoN0c3TU92azEzTTlMeGNHR2JtbUNNWnEwN1ZHOTdmOEZ2eXVo?=
 =?utf-8?B?UzFHNTdkaUdXcnVNOHVxK2N5bnY5eWdiS0lNcEQvL3prYWZoWU1veVFVM3Jw?=
 =?utf-8?B?a1k5eHVkcGw5L0dvekhyNHEwYlJSVUZpb3grMzNmZ09LU0ppaUtId1VwcFZw?=
 =?utf-8?B?SG1OWGVoWEZtb1NiUmZDZ1lBTG1VZUcvV0Vha01RSlIrR0ovY2E4V2RrSGQw?=
 =?utf-8?B?SUFBTUhLcFNUR1hBdjM2ZDNZa3FEMEdZUjNncWpGcGZOSk5CeHN4UGNHU052?=
 =?utf-8?B?MFl5MHdqeUZ4NktIYW8xcnQ4SmdEVGp6MGtBL0VvZ2NnNUJPVGJXcEY1VHJz?=
 =?utf-8?B?NHIwOENtdTZyNEc3NjNWU0RsZm9YNVFiT2hxTDdXNENYSmE0dDdCRGpDYWxP?=
 =?utf-8?B?TmYyOWthcnBsb2pJdkdybnJiTzF3RUNIWVFVcjgvK3pJRFFSVXJMd3pCVU00?=
 =?utf-8?B?c2FScUVWSDJsZHJRcWxqSUFWTGVUSVNsM3Z1MENpUmZJRlQzcWN2S0NTMjdR?=
 =?utf-8?B?KzlDUjROenhJdVdyaU41YlVqaE9XQmtqM2dNUVBHR2VCMGVvMmo5QkFVb1l5?=
 =?utf-8?B?S2xwUHRRVkJ4VVJmN1ZDazRwTmZaNlpkNDA0cUZjdE5uWmVWWkx0eUEyT2U5?=
 =?utf-8?B?WGtxVEVHcFhtUWlHYzF4ZXNzeElPRTc4OWt4cUFuOU9NUzN0K1pneVVTQ1Iy?=
 =?utf-8?B?M1pFa1VSZ2ZweXNTN2VwbVQ0Z1ozSEpvRWJrRkNGYXlWcWd5ekI0YXBPbVJC?=
 =?utf-8?B?SUt3Y3JHeWVNWllTR0Jub3pkRGtJS1dCUEpreWFCZHVzcW5ycks3Ty9vWkhM?=
 =?utf-8?B?MlNkY3UzdjBZdVRJWkMzcUF4ek96SzlTNU9mWm8rdTFVTUpub1FZWmhUTlVk?=
 =?utf-8?B?TEEvUEFSZno2Yld6MXpVU2ZRT2xlcXVKWGtobFZRanJJaG9Ld1NuZkRyZG9E?=
 =?utf-8?B?MHNFMG1KaU5pSFBGdUh4c1pJdWJHemxJU2w4ajZqbzJnNWJkcEY0Uzljbm5I?=
 =?utf-8?B?ckhJckFHelhwTktlMmRGbU85Zk9iczJWZnRQZ0l2SXlPdlJ4VklxL25wMEVt?=
 =?utf-8?B?eDdrQ0FSLy8xNHl0T2lFeW1vSTlGeFhHbjQwWXBQWGFabjZ2Z3BWUVVicDV0?=
 =?utf-8?B?dWMxcEVFMGZxeU5ZREZCa3Y1ay9TRTd5bGd1eXhqMXFmWDA5dU9YVEJTa0Zl?=
 =?utf-8?Q?Cna0Sk7Or7GwFzRUCX+uSdv/nMq2fw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UllGdUJTWUpNdUhVWDFjQm9Zd0ZSbzRGdGtSengzbFJGYXlvUVZIeWFIUGl4?=
 =?utf-8?B?dTJoZHVaVlo0bytsTlpsQndhL2g2bXcwb2hzb2NpcDROek45azZMWDVwWEFP?=
 =?utf-8?B?S0FOOFVlZEFUVGFHQ3lpb3RzbEFFTEdxRWZLM2dZOERPWmZLZE9jS2JxNXNy?=
 =?utf-8?B?YTkxRHZqWDF5UDllUjM5Y1VqdTlacWR6cjVPbTlxZTVqemdUWEZzNUZRc1Vn?=
 =?utf-8?B?dFlsZ3Q1MHFtMFh1QUNPdHJZY1U3YjVJQVRacUZyYmxXLzBLbCtPMzlhTzhn?=
 =?utf-8?B?SEIvYVFyUUVrSS80emJQTzFhTWxPdUZyR3E3RDNNRUZWVlJtVHhuVE9ZUGth?=
 =?utf-8?B?ZUtwcm4zcVhvUG1xZ1hmSHNtYkVIS3lreG9qWjNKcU5HTGNmSm9paDFtWE1X?=
 =?utf-8?B?RUxiWnNVdDNUT1JzM04zcytFNFZWTzdqWWgwZllmNFpqUFozaTNEWGFZYXF3?=
 =?utf-8?B?THU4MTlPekp5dmFQRERtSGhMVzBjL0tLcHB6RFg4NVpvaW1Oa3I2SlFIcUJi?=
 =?utf-8?B?T1ZNOTU3ZHpxMGNvY01DejhOdmNKajlVSHNtTHVSSE14cllpbzl3UlBqVUw5?=
 =?utf-8?B?TzN5YnNJRkZLTGpDK0srMTN5czN1YWFsUlE4SlNJM09TZUQ0MzZrRDlTdjYy?=
 =?utf-8?B?VGhGWDhackhGQi8xcHZlTTV1Zk5NNnkxeUpJa0twNmRRY0c5Sk50TnYxRmZI?=
 =?utf-8?B?TjlWdW1oOFNhandtQ1QwS24vaDExVHhtd1dUNkZEZ1JKU0ozTUhHUlNkZnA4?=
 =?utf-8?B?SHEyZk1sZUJZR2JiZ1VSOU5UdVRRck1zWnU0YVZoRnBtc0ZrVlVKc1o2UEgw?=
 =?utf-8?B?d2lSTW41WlE1dWpIVEFCRG9tQkNCdVJ5aTRweUdGNGR1NHlPaHJpcEtsZkxq?=
 =?utf-8?B?aWZHdWtQNXhYMFRBWGJzZmh0eGFQOTFuQWpwcXlqL3BWUXFJdWNqN2VHaHls?=
 =?utf-8?B?d2hOK3gwcUNaQmx2WjdETGh3N25peE1KSXl1SFd1aEQ5VW1XOUR6VFNsdENF?=
 =?utf-8?B?d2xsM2lydlhHNHhIcnZRVk8rNkVjSE5Va3E0eFJzM211ZnVmaEJndnlMZ2th?=
 =?utf-8?B?L1hpWk1nVWhxcU11VWdEWSsrdVdHWDJHVWxpNGJTc1c0Nk1xOWIyOTRJSWtm?=
 =?utf-8?B?UFFPVkttdHRoejdIKzNsOTFLTUZxU09FN25SS3ZQMDZnY2I1ZkZ0eHFtcllw?=
 =?utf-8?B?dWhIL1NRV0Q0dVpWdW5hK0N0djlDcGxEbEZmSVZ0MFFXNDEzN004WFpseTh6?=
 =?utf-8?B?YjRXeVVvOExURTlaZXd3aU8wSnFNMm8ra2xVa3dvRytKdlJ4N1dzWTZMYnVt?=
 =?utf-8?B?OFVOeFh4Z3FwM3FBN1VpTHZLSHlKMlNHMG9rYWRweWRDQTlyL3lVdlkvS0Nh?=
 =?utf-8?B?T05LalZvYUN4Uk41MkhJM3FxRzEvZ05ZOVJub1puRUl4YjdsUHI1K1A5Tnpv?=
 =?utf-8?B?cE5Neml2Q2U3MElqKzZIUGsxNWNJSXlPWXFDTnZZVTdmN0p5ZGtDdGFzbFVM?=
 =?utf-8?B?L0xzc0ZFcDFSRmhXN2JPTHdCTnY2WEludlJSRnN6dHU3eG42MTNkL1MydWpO?=
 =?utf-8?B?a2pkMFpoL05YcVE5MXhmUGlYZmtyQVNjWjMwT1V2NStrb0orNjZNTFBXckEy?=
 =?utf-8?B?Skk0V2FxaEthVEFqSG9OSVZHTFF5UEs3RjNMeGg1TmRieW5TOHBoL1o3RWFJ?=
 =?utf-8?B?QlV0OVBxNVozUi9xQzFmQ2pMc1Vwa1JhZGIxSHFlNEY0Wldpb0hoR1Z0U3Vn?=
 =?utf-8?B?UUhFMnFPY1NlVVJ5QWZxckNFOXZNMkxBa29BdXVnb0tzU0c5M1Exc0htY3BO?=
 =?utf-8?B?U3VwVUM3NVpVUkp1dkZUOWxTQ2VvME0zRUExakxQaG1iUDlhODhiL3lEVjFu?=
 =?utf-8?B?TUdVOU15eWM4Y2V2R2JYSElYS2tFTmR5S2lBRVJqUWozZkFTWFZmVDY3Y0po?=
 =?utf-8?B?eHBqdncwWVdKRUVrODJYYzE3R0J4VFI3Lzk2TkpKTHM1UEtoVWZIRGVvaUc1?=
 =?utf-8?B?Uk1NNDBJZ1JNMllIcnNNVWhJNUxjVnVCcEZCcnJITm4xQ09nbUFGaWsxTEdF?=
 =?utf-8?B?WVdlRU9zbW1oV0xvODgwUElxZngxd2xRM25weVgrSlFENHBnRDMvcFZHclJp?=
 =?utf-8?Q?VpN501P6JR37K6cdTO/2UVnrB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef32f10-0560-42b9-8844-08ddb2c9a617
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 02:48:50.0983 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LC5WHf46v8OP+UHe6RE1OF54AsB4Dj7P/5aSSsJ+CkuRWZpGrEonafbA3t166kPZrwLC2L6nyjaHSbxiq4PiJcZ5RhYBmwAvxgN8uDpydDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7258
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
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
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDA5LzE5XSBpbnRlbF9p
b21tdTogSW50cm9kdWNlIHR3byBoZWxwZXJzDQo+dnRkX2FzX2Zyb20vdG9faW9tbXVfcGFzaWRf
bG9ja2VkDQo+DQo+SGkgWmhlbnpob25nLA0KPg0KPk9uIDYvMjAvMjUgOToxOCBBTSwgWmhlbnpo
b25nIER1YW4gd3JvdGU6DQo+PiBQQ0kgZGV2aWNlIHN1cHBvcnRzIHR3byByZXF1ZXN0IHR5cGVz
LCBSZXF1ZXN0cy13aXRob3V0LVBBU0lEIGFuZA0KPj4gUmVxdWVzdHMtd2l0aC1QQVNJRC4gUmVx
dWVzdHMtd2l0aG91dC1QQVNJRCBkb2Vzbid0IGluY2x1ZGUgYSBQQVNJRCBUTFANCj4+IHByZWZp
eCwgSU9NTVUgZmV0Y2hlcyByaWRfcGFzaWQgZnJvbSBjb250ZXh0IGVudHJ5IGFuZCB1c2UgaXQg
YXMgSU9NTVUncw0KPj4gcGFzaWQgdG8gaW5kZXggcGFzaWQgdGFibGUuDQo+Pg0KPj4gU28gd2Ug
bmVlZCB0byB0cmFuc2xhdGUgYmV0d2VlbiBQQ0kncyBwYXNpZCBhbmQgSU9NTVUncyBwYXNpZCBz
cGVjaWFsbHkNCj4+IGZvciBSZXF1ZXN0cy13aXRob3V0LVBBU0lELCBlLmcuLCBQQ0lfTk9fUEFT
SUQoLTEpIDwtPiByaWRfcGFzaWQuDQo+PiBGb3IgUmVxdWVzdHMtd2l0aC1QQVNJRCwgUENJJ3Mg
cGFzaWQgYW5kIElPTU1VJ3MgcGFzaWQgYXJlIHNhbWUgdmFsdWUuDQo+Pg0KPj4gdnRkX2FzX2Zy
b21faW9tbXVfcGFzaWRfbG9ja2VkKCkgdHJhbnNsYXRlcyBmcm9tIEJERitpb21tdV9wYXNpZCB0
bw0KPnZ0ZF9hcw0KPj4gd2hpY2ggY29udGFpbnMgUENJJ3MgcGFzaWQgdnRkX2FzLT5wYXNpZC4N
Cj4+DQo+PiB2dGRfYXNfdG9faW9tbXVfcGFzaWRfbG9ja2VkKCkgdHJhbnNsYXRlcyBmcm9tIEJE
Rit2dGRfYXMtPnBhc2lkIHRvDQo+aW9tbXVfcGFzaWQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTog
Wmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gIGh3
L2kzODYvaW50ZWxfaW9tbXUuYyB8IDU4DQo+KysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA1OCBpbnNlcnRpb25zKCspDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9t
bXUuYw0KPj4gaW5kZXggOWQ0YWRjOTQ1OC4uODk0OGI4MzcwZiAxMDA2NDQNCj4+IC0tLSBhL2h3
L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBA
QCAtMTYwMiw2ICsxNjAyLDY0IEBAIHN0YXRpYyBpbnQNCj52dGRfZGV2X3RvX2NvbnRleHRfZW50
cnkoSW50ZWxJT01NVVN0YXRlICpzLCB1aW50OF90IGJ1c19udW0sDQo+PiAgICAgIHJldHVybiAw
Ow0KPj4gIH0NCj4+DQo+PiArc3RhdGljIGlubGluZSBpbnQgdnRkX2FzX3RvX2lvbW11X3Bhc2lk
X2xvY2tlZChWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hcywNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90ICpwYXNpZCkNCj5JcyBpdCBtZWFu
aW5nZnVsIHRvIHVzZSBpbmxpbmUgaGVyZSBhbmQgYmVsb3c/IEJlbG93IEkgZ3Vlc3MgeW91IGRv
IHNvDQo+dG8gYXZvaWQgImRlZmluZWQgYnV0IG5vdCB1c2VkIiBjb21waWxhdGlvbiBlcnJvciBi
dXQgSSBkb24ndCB0aGluayBpdA0KPnNob3VsZCBzdGF5IGFzIGlzLg0KDQpZZXMsIHRoYXQncyB0
aGUgb25seSByZWFzb24gSSBkZWZpbmUgdGhlIGJvdGggaW5saW5lLg0KRG8geW91IGhhdmUgb3Ro
ZXIgc3VnZ2VzdGlvbnMgdG8gYXZvaWQgY29tcGlsYXRpb24gZXJyb3IgaWYgbm90IHVzZSBpbmxp
bmU/DQoNCj4NCj5JIGRvbid0IHJlYWxseSB1bmRlcnN0YW5kIHRoZSBpb21tdV9wYXNpZCB0ZXJt
aW5vbG9neS4gRWl0aGVyIGl0IGlzIGENCj5wYXNpZCBwYXNzZWQgdGhyb3VnaCB0aGUgUENJIHRy
YW5zYWN0aW9uIG9yIGl0IGlzIHRoZSBkZWZhdWx0IHBhc2lkDQo+Zm91bmQgaW4gcmlkMnBhc3Np
ZCBjZSBmaWVsZC4gU28gdGhhdCdzIGEgcGFzaWQgYm90aCB3YXlzIDstKSBjYW4ndCB5b3UNCj5z
aW1wbHkgY2FsbCBpdCBwYXNpZC4NCg0KWWVzLCBQQ0kgc2lkZSB3ZSBjYWxsIGl0IGp1c3QgcGFz
aWQsIHRoZSBvdGhlciBzaWRlIEkgbmFtZSBpdCBpb21tdSBwYXNpZCB0byBkaXN0aW5ndWlzaC4N
CkRvZXMgdGhhdCB3b3JrIGZvciB5b3U/DQoNCj4+ICt7DQo+PiArICAgIFZURENvbnRleHRDYWNo
ZUVudHJ5ICpjY19lbnRyeSA9ICZ2dGRfYXMtPmNvbnRleHRfY2FjaGVfZW50cnk7DQo+PiArICAg
IEludGVsSU9NTVVTdGF0ZSAqcyA9IHZ0ZF9hcy0+aW9tbXVfc3RhdGU7DQo+PiArICAgIHVpbnQ4
X3QgYnVzX251bSA9IHBjaV9idXNfbnVtKHZ0ZF9hcy0+YnVzKTsNCj4+ICsgICAgdWludDhfdCBk
ZXZmbiA9IHZ0ZF9hcy0+ZGV2Zm47DQo+PiArICAgIFZURENvbnRleHRFbnRyeSBjZTsNCj4+ICsg
ICAgaW50IHJldDsNCj4+ICsNCj4+ICsgICAgaWYgKGNjX2VudHJ5LT5jb250ZXh0X2NhY2hlX2dl
biA9PSBzLT5jb250ZXh0X2NhY2hlX2dlbikgew0KPj4gKyAgICAgICAgY2UgPSBjY19lbnRyeS0+
Y29udGV4dF9lbnRyeTsNCj4+ICsgICAgfSBlbHNlIHsNCj4+ICsgICAgICAgIHJldCA9IHZ0ZF9k
ZXZfdG9fY29udGV4dF9lbnRyeShzLCBidXNfbnVtLCBkZXZmbiwgJmNlKTsNCj4+ICsgICAgICAg
IGlmIChyZXQpIHsNCj4+ICsgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gKyAgICAgICAgfQ0K
Pj4gKyAgICB9DQo+aWYgdGhlIGFib3ZlIHBhdHRlcm4gaXMgdXNlZCBhdCBtYW55IGxvY2F0aW9u
cyBJIHN0aWxsIHRoaW5rIGl0IG1heSBiZQ0KPnZhbHVhYmxlIHRvIGhhdmUgYSBfbG9ja2VkIGhl
bHBlci4NCg0KTm90IGdldCwgYm90aCB2dGRfYXNfdG9faW9tbXVfcGFzaWRfbG9ja2VkKCkgYW5k
IHZ0ZF9hc19mcm9tX2lvbW11X3Bhc2lkX2xvY2tlZCgpDQphcmUgYWxyZWFkeSBfbG9ja2VkIGhl
bHBlciwgaXNuJ3QgaXQ/DQoNCkRvIHlvdSBtZWFuIGFkZGluZyBhIGNvbW1lbnQgc2F5aW5nICJD
YWxsZXIgb2YgdGhpcyBmdW5jdGlvbiBzaG91bGQgaG9sZCBpb21tdV9sb2NrLiINCg0KPj4gKw0K
Pj4gKyAgICAvKiBUcmFuc2xhdGUgdG8gaW9tbXUgcGFzaWQgaWYgUENJX05PX1BBU0lEICovDQo+
PiArICAgIGlmICh2dGRfYXMtPnBhc2lkID09IFBDSV9OT19QQVNJRCkgew0KPj4gKyAgICAgICAg
KnBhc2lkID0gVlREX0NFX0dFVF9SSUQyUEFTSUQoJmNlKTsNCj4+ICsgICAgfSBlbHNlIHsNCj4+
ICsgICAgICAgICpwYXNpZCA9IHZ0ZF9hcy0+cGFzaWQ7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsg
ICAgcmV0dXJuIDA7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBnYm9vbGVhbiB2dGRfZmluZF9h
c19ieV9zaWRfYW5kX2lvbW11X3Bhc2lkKGdwb2ludGVyIGtleSwgZ3BvaW50ZXINCj52YWx1ZSwN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBn
cG9pbnRlciB1c2VyX2RhdGEpDQo+PiArew0KPj4gKyAgICBWVERBZGRyZXNzU3BhY2UgKnZ0ZF9h
cyA9IChWVERBZGRyZXNzU3BhY2UgKil2YWx1ZTsNCj4+ICsgICAgc3RydWN0IHZ0ZF9hc19yYXdf
a2V5ICp0YXJnZXQgPSAoc3RydWN0IHZ0ZF9hc19yYXdfa2V5ICopdXNlcl9kYXRhOw0KPndoeSB0
YXJnZXQ/IGNhbid0IHlvdSBuYW1lIGl0IGtleSBpbnN0ZWFkPw0KDQpUaGVyZSBpcyBhbHJlYWR5
IGEgcGFyYW1ldGVyIG5hbWVkIGtleSwgbWF5YmUgdGFyZ2V0X2tleT8NCg0KVGhhbmtzDQpaaGVu
emhvbmcNCg0KPj4gKyAgICB1aW50MTZfdCBzaWQgPSBQQ0lfQlVJTERfQkRGKHBjaV9idXNfbnVt
KHZ0ZF9hcy0+YnVzKSwgdnRkX2FzLT5kZXZmbik7DQo+PiArICAgIHVpbnQzMl90IHBhc2lkOw0K
Pj4gKw0KPj4gKyAgICBpZiAodnRkX2FzX3RvX2lvbW11X3Bhc2lkX2xvY2tlZCh2dGRfYXMsICZw
YXNpZCkpIHsNCj4+ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICsgICAgfQ0KPj4gKw0KPj4g
KyAgICByZXR1cm4gKHBhc2lkID09IHRhcmdldC0+cGFzaWQpICYmIChzaWQgPT0gdGFyZ2V0LT5z
aWQpOw0KPj4gK30NCj4+ICsNCj4+ICsvKiBUcmFuc2xhdGUgaW9tbXUgcGFzaWQgdG8gdnRkX2Fz
ICovDQo+c2FtZSBoZXJlDQo+PiArc3RhdGljIGlubGluZQ0KPj4gK1ZUREFkZHJlc3NTcGFjZSAq
dnRkX2FzX2Zyb21faW9tbXVfcGFzaWRfbG9ja2VkKEludGVsSU9NTVVTdGF0ZSAqcywNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MTZfdCBz
aWQsIHVpbnQzMl90IHBhc2lkKQ0KPj4gK3sNCj4+ICsgICAgc3RydWN0IHZ0ZF9hc19yYXdfa2V5
IGtleSA9IHsNCj4+ICsgICAgICAgIC5zaWQgPSBzaWQsDQo+PiArICAgICAgICAucGFzaWQgPSBw
YXNpZA0KPj4gKyAgICB9Ow0KPj4gKw0KPj4gKyAgICByZXR1cm4gZ19oYXNoX3RhYmxlX2ZpbmQo
cy0+dnRkX2FkZHJlc3Nfc3BhY2VzLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dnRkX2ZpbmRfYXNfYnlfc2lkX2FuZF9pb21tdV9wYXNpZCwgJmtleSk7DQo+PiArfQ0KPj4gKw0K
Pj4gIHN0YXRpYyBpbnQgdnRkX3N5bmNfc2hhZG93X3BhZ2VfaG9vayhjb25zdCBJT01NVVRMQkV2
ZW50ICpldmVudCwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9p
ZCAqcHJpdmF0ZSkNCj4+ICB7DQo+VGhhbmtzDQo+DQo+RXJpYw0KDQo=

