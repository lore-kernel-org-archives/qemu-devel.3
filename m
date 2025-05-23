Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416D5C3DA6D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 06:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIMH9-0001Sg-5W; Fri, 23 May 2025 02:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uIMH7-0001SX-OH
 for qemu-devel@nongnu.org; Fri, 23 May 2025 02:53:01 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uIMH4-0001oA-5l
 for qemu-devel@nongnu.org; Fri, 23 May 2025 02:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747983178; x=1779519178;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wgSD3Lgfox/hlZQ1spwxN9Ai+IXpq4a75DWgdycy6VM=;
 b=ErzQrOiweXdYVPl0v/fu1izgnHrzfri6efO6Y3nVl5rp7C1yRIfFkxcq
 HdfjsXabajhRvU4uftDYZe6A5ogLhmZXWipX5Lgk0NlkRKrBKYEpeNBpt
 D2bFTKopPlZr1tdEBLm9sj463nrOsStYLgANb/mtbqBP6E7mGYf143bED
 g/ttgW3+1m8H/HLvUDuYGzev0LNYQuurPGRhYb8TYaPyA+sqIUZp90XD2
 UsYqbB/cxwD+g8txQqJLx/hQCbqvTh4C+ECa+OxTWpyyMBjG3jd8ElO9s
 7XoTkI4y+pysPNpAJ1nVmJUu7CMYc39NvkMgTVAscCrmi1UiPeS5pImhh g==;
X-CSE-ConnectionGUID: 36Le/mtTSXmGYc0YsrTyTQ==
X-CSE-MsgGUID: Br+VhYCqToShSOxbYGziAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="53826019"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; d="scan'208";a="53826019"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2025 23:52:50 -0700
X-CSE-ConnectionGUID: vluFLI+ASCuaHPoHUDeSoA==
X-CSE-MsgGUID: i2+pG+nxTVahinIu7Z6Ppg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; d="scan'208";a="141962467"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2025 23:52:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 May 2025 23:52:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 22 May 2025 23:52:41 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.47)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 22 May 2025 23:52:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2PVUEIgUm6h69UHJGybsTkAAnqXIaHVxd+wBsqPFNEJUP5lWkZeAEK32vk4y7zIH+pnugqxEiuVscpCaDkI5kbY3hGK+7ayScELuxQBmAy2aVB+p4+XNApBE/jIOrihJu/49rpoQnee/6SnRhwo3Fj4fM0fcn030jlPvrivJIN4ZrvFqhUIP0+JJoaelScfw/ymRt35SLMoB3Or3QdQPxoRCu70bmqE+l2BEjmGSMU5u7CytP95H7WXwV64d8Q7AkrO+L7g1lQSgtAf8sRurKu9ZTBv6x6H5SSL/xRnDPiGnZ5T7cKqOLBvXsKcm6/1aLrVPaL82qv4n3wORqoevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgSD3Lgfox/hlZQ1spwxN9Ai+IXpq4a75DWgdycy6VM=;
 b=fdg73PCZFz99P7LiPIfKC51iNJHI9OW3nOapo2TTtdom7OhGah43F+WWhID8B7gO1dVHOehdSw0ZrppoaKx6swlFcKyY9OOkJaNyyEvPcWq/2pjVtZtvLOT3qwAjqBrQXBwa8lOWsG7sx8D88z8LjCANxaYyqUTIi7FkMCN8ggqkaWNx4//tpqKyXZNLpQVHC9l/CxWdC0ko4Ao294e/IqZVyU2O8a7JYmkZEhBSJpIOrM2Hg5UjLSzFfkuzu/BnBPk3LgmK8okK4eJ49UEwTTCoQnDffqxBSbAB8PcxjESRVG0418puCl4DjHvsSAab9IyCcm0/pnc44BU73ga25Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15)
 by SN7PR11MB8067.namprd11.prod.outlook.com (2603:10b6:806:2e8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Fri, 23 May
 2025 06:52:12 +0000
Received: from PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::9136:e302:ad5f:b522]) by PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::9136:e302:ad5f:b522%6]) with mapi id 15.20.8769.019; Fri, 23 May 2025
 06:52:12 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Thread-Topic: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Thread-Index: AQHbykJMfKt9Mfha3Ee+klVeu6JiiLPdsMoAgAIQvoCAAAetsA==
Date: Fri, 23 May 2025 06:52:12 +0000
Message-ID: <PH7PR11MB672261211B3526166A6841A59298A@PH7PR11MB6722.namprd11.prod.outlook.com>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-16-zhenzhong.duan@intel.com>
 <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
 <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
In-Reply-To: <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6722:EE_|SN7PR11MB8067:EE_
x-ms-office365-filtering-correlation-id: 4bbf841f-1a88-49de-5d60-08dd99c65853
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?V1NqU3lMSEFzSERncGY3LzF5d0xMU3kvZXh0c0tzRnBUMnJEa3NlR3JYeWVM?=
 =?utf-8?B?V3U2b296c0NseEh6ci9hZ1Jsam4xRkNZSmxqck9DbXByQ3d5WXVJcXpYV1ov?=
 =?utf-8?B?NnBhUG5VQ0t2MFZQdlVuUjJtRzFicmlGQXlLS1hnZ2RFVU9qVllqMC9VYnkx?=
 =?utf-8?B?YkJ4amZUSzNGNzhMeW42OEdJczJ6TGJVZTk4VE1YbU1aZEQ3OWl4SmgyWVAy?=
 =?utf-8?B?WC9WNnY5d0Zlb0lUUkt5R3FOWTFTNlN2MHc5TXkwV1N3VjFLVCtzQU9FV0gw?=
 =?utf-8?B?TkRBV2dkZ2FzK29nRFQwWjhBRDNaRnkyenJ5cVo5ZHJUTFFzcnFaZDdIQmJh?=
 =?utf-8?B?UENHVmpKci9NQUF0VDB3VWlrMlMzMXpMTWp0akZhVFlyWHBZcUw1a3pxTVF3?=
 =?utf-8?B?a2xaUUIvUnB6YXJMSFk0dis2NzROL1I0OTE3Z0p1REV0OUVKUUFxbzdrN0hT?=
 =?utf-8?B?L2dzdkFkVU9pUEg2bFJmay9BeTFQRHBBRFgxVUxKc0ExbkJPeVJ1N25Qa0FL?=
 =?utf-8?B?TU42alkyQ3RUZ0wyOUsrRXYzd2ZlWkJ2eFQ3NnZNRU5KSlFZTUZqZytHdSt2?=
 =?utf-8?B?RG13NE1WVitJUG9uWFhYVkxkRm5QVmxSTkQ2N040Qng3TFZqYzZxeEg5VEJ3?=
 =?utf-8?B?bmhNbjF3T3hsK3N3NEgwd1Vpa2Roc3ZLbjZvV0tiVWhLeUtFN2dxZTR6QU1a?=
 =?utf-8?B?bUZKcVFxdFhGUmxVTXZqRVdBWCtpbnA1Z0YweEFmZ1lwdWwwT0FhZ01UWEYy?=
 =?utf-8?B?UzJGbEtSY0t5bVRIdXNzSElpYW5qbm01ZXZzQlJuNEh4K214ZkR4QlZXamdp?=
 =?utf-8?B?d3RwNVZBcUpoK1lkaDhHS0hESFUyRHdOYWplN3hGUUZmS0NPWWlBRzJESmQ0?=
 =?utf-8?B?VFBKa21YNGdqclhQQTczVEF3TE9kZG56QU1XZk1seUFUM1lNdWFydzEyaG9P?=
 =?utf-8?B?aDBGbGt5elBkNnk4LzI5NGdXWWNKVVByUmtlNWJ3bEpWd3pycXBaMjZTeW1x?=
 =?utf-8?B?NzRpcFlNYm5zTEdzU0YyWk1tTDlLUlFHdmdwdWNWeUQ5N0JyNUx0d2FmM29R?=
 =?utf-8?B?UzJkUUF0Z2VxSzF1WHM4SzZ1aUxZcGRvbVltdWJGbUdqSEd5enQ1WExUM1RV?=
 =?utf-8?B?aElJbmt1WDl4YTlwWVQyT3hBd3VzK3pVY1V6cUtFWGxPVmhjUitkYmg5V25m?=
 =?utf-8?B?Y1FKNlIxVHZkZjFaTnp5VFBOcnFFMDhrZDRCcnZqNWRsdTN4L20rV2h0Q0RG?=
 =?utf-8?B?WWRlOWYrYzVlMHFMN2xEeDEwZk1rcHYzT1pINERPUGdpSDAxSWhaUms1UnJm?=
 =?utf-8?B?RGJCSnRMcjBISXVRWHVYTm8rM3pYTWJSakFIKzdZWmM4RGdRZFFySk10Vnlk?=
 =?utf-8?B?SFdpVHdPZ3B6UE54RTdsMUEybFZORlA0cUJJVXpBRzcyd2N2WGIvQW5yaldp?=
 =?utf-8?B?UkJBc3FVbVB4cThId2JhR2RUU1dZcEpkMEFZejNnWEdpN0JyNlFFZ0Z1MWFJ?=
 =?utf-8?B?VW92M3g3MU9hQzFOM0J2eTRZcjJCQlZTUDhETDZLeGhaNGdWS1FPVW9jRVpa?=
 =?utf-8?B?ZG9SMzRYbFRZb3ZjOWlpSXg5Tjh5bU5iUk0vcWFhRDR1NW5SY0Q2eEIvRGdF?=
 =?utf-8?B?bWx1YVVUUzNocmhtQysrUndFbVpBRGRjcWk3alh5bDJ6bTZ1K2JPQjY5MHV2?=
 =?utf-8?B?MitjM0FKdEc3RUZ4N0drNzZkb0pHUzFJa2U4bEU5dm0wSEhYQTUwa2Fwck9W?=
 =?utf-8?B?NW1CY2VWOS9oQVBld1J5YlRVQ20vRFdHZm1CSWJPWm9IV2VKUk44UzdEV1hu?=
 =?utf-8?B?VHNDVkk1TTI0S3gramtzR05xMUp6S0EyN3NVaFUwWTg0QStYNlVRaEovQ040?=
 =?utf-8?B?cVZmTHdydjBlaW1BeVdoY3VWTm0yZlpkSTk0ejhXY25JR3lnQ2xyU1hSVGlu?=
 =?utf-8?Q?NMO264OAPEQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6722.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cG9zUU9YenJ6bFRKREd2dFpWa1pYVVY2SFc4TG1LamtpYzdWR2xWTllnT1Nx?=
 =?utf-8?B?SVN6YThGYkhzaXF5MExUbWNHVHNNeURzZ2sxS3k1bjZoenZJSkpHN0Q5bDFi?=
 =?utf-8?B?YTdoWDVlSkxRdlAyQnZkVFJkMkhZUk1xNFZqN1hZVzRBdTFnM0VOZ1NCTVJW?=
 =?utf-8?B?VXBUTVZvSXVhN3FrbWIzOTRobjRQaHA5S21SaDZGSFB4WVJRNFNReFZHaU0v?=
 =?utf-8?B?bENVeThGamQvNVlWT2xPenNUV0VDcnEweHozK0RVT0tqTWNkYzV1SGdqRHJV?=
 =?utf-8?B?TDlSdnZ1WWl1T1cxcVJXdkNoTzZNQVd2MU0zUnYrOE9XMldISEJkUnp4aFMv?=
 =?utf-8?B?REFSYmNveWtzT0lXanF1S25LSWI1UlA2S1oxTWxrZzBvcUZTV3RObnBrczZo?=
 =?utf-8?B?KzJkS2pVakhhWUtpUzZIbG1FZzNRQVhpYTFMSUVKTlZ3SmNHMDBjS2ZLQXA5?=
 =?utf-8?B?UVYreGJBQTJUVW45Mk5OVHhYMmFuaXB3U0pMTThjRnQ0eVovQ2huSXFuaUQw?=
 =?utf-8?B?NmlRQlBrT2x6VGU1cCsvYVlMWUdUYWM0OE00SE05djhZNzNsdmxkYjBaaWlG?=
 =?utf-8?B?ZE51WklzcnppTmxwS2trblJCU09QS0VrRnFoMERwWmN3OFJEb1V1cmRzSWF2?=
 =?utf-8?B?VWRaR2xiNFFaMFMwaXJkOEl0eVkySnBZY2IwWDRqUUkvQytwTmNhaXlPTy9s?=
 =?utf-8?B?OCszUkY5N0dKZWJ6MnpzRWF2UFdmYStzMHdTV2pTOE9FWFY2c2toKzdmcWg1?=
 =?utf-8?B?eEFVZlpxaUIxTmxnS1hsRDExT1FDdzRJdENETFBtUFh6bVhBT1g4dGR3Y2hp?=
 =?utf-8?B?WVBQNEFGRTZaODg5TlJzSGZhMGtwT1BIMUg5M29VOVhEYTREbzhsMEFIVVl6?=
 =?utf-8?B?U3JEV0tXeGovMzdNZ0Jhald1eVYrQkZhN0V4WU83bkFZRlJiNWVWVXBCZGtT?=
 =?utf-8?B?T1cyUHFnMktaSEEweUpNbTlIVDJWTnhyeFRwOFhPVWdZZDdteVFoMDNmQk1R?=
 =?utf-8?B?YmtQbGlEUzZZQ09wNkdpSjhMRHozdEJFYjc3OTFJMlBjMmlXZjQyZTA1aGFE?=
 =?utf-8?B?cEdyejlOY1RNWEZLNjZDVmU5SjNVZVZXL1pualZBbnFubE94RUNFS0tsVDBB?=
 =?utf-8?B?a1hKcjYrYk4yMTJTQ0I1UjJESS9QakFMWUpkRS9pV0luaHZHUzlNRC9BNExR?=
 =?utf-8?B?cnF6ckl2Q2VlVTE4M1V2dU5nOWdnRVliU3pYcTJRRFpiWmtlUkY4VVp5bEZx?=
 =?utf-8?B?OGJpdXJWdTdpSGpFOTdzeHJTQTh5ZmRLZWFlbkk4NlVTT3hyUjdsdW5qRzh6?=
 =?utf-8?B?dldQQVZWVmlOSFIyaWgyQVhuMlREYkpKUW94MHl1VGxjZ2J3eHhmWXVjdElL?=
 =?utf-8?B?Zi8wUzRjYlAxc1FCNEpoM1hpSHJRanlTenh3Mm1lTzZVWXp1TThDbGtvc2RD?=
 =?utf-8?B?Qnhycng2Mit3ME1tbU5ZeUxzZjlvU0N4SWVOaGVxNE8wWjh0ZksrYW1PUlFq?=
 =?utf-8?B?M0NKd0RzZ0hOQ2hOUThrczJFdTBVd0k4VldDaDdzNHVQTlE5WDFkajNvZnRY?=
 =?utf-8?B?Sm9QelI0ZlpSK3gzVlZYSFBibFVWdmhKc2gwRUpLczY3eUZWZk56bmM0RWU2?=
 =?utf-8?B?SEJyYTlqWDNEa1Fvdk11eWxNUEE5NkhYNGIrQXNwc3hzMDYzR2d1Z0pmdktr?=
 =?utf-8?B?RkY4Y0ZHcWlxb2EwTGVreUNobDlQN2d1RFE1QXh2dTZhY2MrWWhHYXN6UnAw?=
 =?utf-8?B?d0Y5ME9nNkpTRE1Mem9PTTlKamp3QVVvTExSaEx6SVZxSlkwQWdQOEpSMWQ4?=
 =?utf-8?B?TlA3L2hBaEZneVlaUldaNjc4RXpScHBvM3VNc3htL0xTVFFFZGVFSmxPZnRR?=
 =?utf-8?B?SjE4VEMxKzV5NlRxdFoyTFVoVzZOMkhZeGdGUmdyNUkyMkRZZzUzbGpoR1Vo?=
 =?utf-8?B?Skg4T1N5bFBGVDk0bkI3b3hYa0hBMFlZb1M2T3AzQlZndTI5VlNiRUtrcVdL?=
 =?utf-8?B?VnpCV2xCSVlZY3BkUjZZSjJtOHNwRVVUTFp1RW1SV08vLzZZV0lLZFo4TXgr?=
 =?utf-8?B?UzM3bXd2K0xzTDhFMWtuMUtjb0M3OVlGTS9NaFo3ZnFHdlZVMnJFaitLWHpL?=
 =?utf-8?Q?RmMRd5QsnFqIvkYBwqVSCEcqr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bbf841f-1a88-49de-5d60-08dd99c65853
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 06:52:12.0813 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z4akeB4IQ/+q3/sOTy3bVRfz7jB85tlOy4ry99YL7NxrnheS4GrcOT3w7viWZCKW2rEVz59Waelc2KtOFazN93ZRaSga8JMrMrqgHHecDuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8067
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggcmZjdjMgMTUvMjFdIGludGVsX2lv
bW11OiBCaW5kL3VuYmluZCBndWVzdCBwYWdlIHRhYmxlIHRvDQo+aG9zdA0KPg0KPkhleSBOaWMs
DQo+DQo+T24gMjAyNS81LzIyIDA2OjQ5LCBOaWNvbGluIENoZW4gd3JvdGU6DQo+PiBPbiBXZWQs
IE1heSAyMSwgMjAyNSBhdCAwNzoxNDo0NVBNICswODAwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToN
Cj4+PiArc3RhdGljIGNvbnN0IE1lbW9yeUxpc3RlbmVyIGlvbW11ZmRfczJkb21haW5fbWVtb3J5
X2xpc3RlbmVyID0gew0KPj4+ICsgICAgLm5hbWUgPSAiaW9tbXVmZF9zMmRvbWFpbiIsDQo+Pj4g
KyAgICAucHJpb3JpdHkgPSAxMDAwLA0KPj4+ICsgICAgLnJlZ2lvbl9hZGQgPSBpb21tdWZkX2xp
c3RlbmVyX3JlZ2lvbl9hZGRfczJkb21haW4sDQo+Pj4gKyAgICAucmVnaW9uX2RlbCA9IGlvbW11
ZmRfbGlzdGVuZXJfcmVnaW9uX2RlbF9zMmRvbWFpbiwNCj4+PiArfTsNCj4+DQo+PiBXb3VsZCB5
b3UgbWluZCBlbGFib3JhdGluZyBXaGVuIGFuZCBob3cgdnRkIGRvZXMgYWxsIFMyIG1hcHBpbmdz
Pw0KPj4NCj4+IE9uIEFSTSwgdGhlIGRlZmF1bHQgdmZpb19tZW1vcnlfbGlzdGVuZXIgY291bGQg
Y2FwdHVyZSB0aGUgZW50aXJlDQo+PiBndWVzdCBSQU0gYW5kIGFkZCB0byB0aGUgYWRkcmVzcyBz
cGFjZS4gU28gd2hhdCB3ZSBkbyBpcyBiYXNpY2FsbHkNCj4+IHJldXNpbmcgdGhlIHZmaW9fbWVt
b3J5X2xpc3RlbmVyOg0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI1
MDMxMTE0MTA0NS42NjYyMC0xMy0NCj5zaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5j
b20vDQo+DQo+aW4gY29uY2VwdCB5ZXMsIGFsbCB0aGUgZ3Vlc3QgcmFtLiBidXQgZHVlIHRvIGFu
IGVycmF0YSwgd2UgbmVlZA0KPnRvIHNraXAgdGhlIFJPIG1hcHBpbmdzLg0KPg0KPj4gVGhlIHRo
aW5nIGlzIHRoYXQgd2hlbiBhIFZGSU8gZGV2aWNlIGlzIGF0dGFjaGVkIHRvIHRoZSBjb250YWlu
ZXINCj4+IHVwb24gYSBuZXN0aW5nIGNvbmZpZ3VyYXRpb24sIHRoZSAtPmdldF9hZGRyZXNzX3Nw
YWNlIG9wIHNob3VsZA0KPj4gcmV0dXJuIHRoZSBzeXN0ZW0gYWRkcmVzcyBzcGFjZSBhcyBTMSBu
ZXN0ZWQgSFdQVCBpc24ndCBhbGxvY2F0ZWQNCj4+IHlldC4gVGhlbiBhbGwgdGhlIGlvbW11IGFz
IHJvdXRpbmVzIGluIHZmaW9fbGlzdGVuZXJfcmVnaW9uX2FkZCgpDQo+PiB3b3VsZCBiZSBza2lw
cGVkLCBlbmRpbmcgdXAgd2l0aCBtYXBwaW5nIHRoZSBndWVzdCBSQU0gaW4gUzIgSFdQVA0KPj4g
Y29ycmVjdGx5LiBOb3QgdW50aWwgdGhlIFMxIG5lc3RlZCBIV1BUIGlzIGFsbG9jYXRlZCBieSB0
aGUgZ3Vlc3QNCj4+IE9TIChhZnRlciBndWVzdCBib290cyksIGNhbiB0aGUgLT5nZXRfYWRkcmVz
c19zcGFjZSBvcCByZXR1cm4gdGhlDQo+PiBpb21tdSBhZGRyZXNzIHNwYWNlLg0KPg0KPlRoaXMg
c2VlbXMgYSBiaXQgZGlmZmVyZW50IGJldHdlZW4gQVJNIGFuZCBWVC1kIGVtdWxhdGlvbi4gVGhl
IFZULWQNCj5lbXVsYXRpb24gY29kZSByZXR1cm5zIHRoZSBpb21tdSBhZGRyZXNzIHNwYWNlIHJl
Z2FyZGxlc3Mgb2Ygd2hhdA0KPnRyYW5zbGF0aW9uIG1vZGUgZ3Vlc3QgY29uZmlndXJlZC4gQnV0
IHRoZSBNUiBvZiB0aGUgYWRkcmVzcyBzcGFjZQ0KPmhhcyB0d28gb3ZlcmxhcHBlZCBzdWJyZWdp
b25zLCBvbmUgaXMgbm9kbWFyLCBhbm90aGVyIG9uZSBpcyBpb21tdS4NCj5BcyB0aGUgbmFtaW5n
IHNob3dzLCB0aGUgbm9kbWFyIGlzIGFsaWFzZWQgdG8gdGhlIHN5c3RlbSBNUi4gQW5kIGJlZm9y
ZQ0KPnRoZSBndWVzdCBlbmFibGVzIGlvbW11IGFuZCBzZXQgUEdUVCB0byBhIG5vbi1QVCBtb2Rl
IChlLmcuIFMxIG9yIFMyKSwNCj50aGUgZWZmZWN0aXZlIE1SIGFsaWFzIGlzIHRoZSBub2RtYXIs
IGhlbmNlIHRoZSBtYXBwaW5nIHRoaXMgYWRkcmVzcw0KPnNwYWNlIGhvbGRzIGFyZSB0aGUgR1BB
IG1hcHBpbmdzIGluIHRoZSBiZWdpbm5pbmcuIElmIGd1ZXN0IHNldCBQR1RUIHRvIFMyLA0KPnRo
ZW4gdGhlIGlvbW11IE1SIGlzIGVuYWJsZWQsIGhlbmNlIHRoZSBtYXBwaW5nIGlzIGdJT1ZBIG1h
cHBpbmdzDQo+YWNjb3JkaW5nbHkuIFNvIGluIFZULWQgZW11bGF0aW9uLCB0aGUgYWRkcmVzcyBz
cGFjZSBzd2l0Y2ggaXMgbW9yZSB0aGUgTVINCj5hbGlhcyBzd2l0Y2hpbmcuDQo+DQo+SW4gdGhp
cyBzZXJpZXMsIHdlIG1haW5seSB3YW50IHRvIHN1cHBvcnQgUzEgdHJhbnNsYXRpb24gdHlwZSBm
b3IgZ3Vlc3QuDQo+QW5kIGl0IGlzIGJhc2VkIG9uIG5lc3RlZCB0cmFuc2xhdGlvbiwgd2hpY2gg
bmVlZHMgYSBTMiBkb21haW4gdGhhdCBob2xkcw0KPnRoZSBHUEEgbWFwcGluZ3MuIEJlc2lkZXMg
UzEgdHJhbnNsYXRpb24gdHlwZSwgUFQgaXMgYWxzbyBzdXBwb3J0ZWQuIEJvdGgNCj50aGUgdHdv
IHR5cGVzIG5lZWQgYSBTMiBkb21haW4gd2hpY2ggYWxyZWFkeSBob2xkcyBHUEEgbWFwcGluZ3Mu
IFNvIHdlIGhhdmUNCj50aGlzIGludGVybmFsIGxpc3RlbmVyLiBBbHNvLCB3ZSB3YW50IHRvIHNr
aXAgUk8gbWFwcGluZ3Mgb24gUzIsIHNvIHRoYXQncw0KPmFub3RoZXIgcmVhc29uIGZvciBpdC4g
IEBaaGVuemhvbmcsIHBlcmhhcHMsIGl0IGNhbiBiZSBkZXNjcmliZWQgaW4gdGhlDQo+Y29tbWl0
IG1lc3NhZ2Ugd2h5IGFuIGludGVybmFsIGxpc3RlbmVyIGlzIGludHJvZHVjZWQuDQoNClRoYW5r
cyBZaSBmb3IgYWNjdXJhdGUgZXhwbGFuYXRpb24sIHN1cmUsIHdpbGwgYWRkIGNvbW1lbnRzIGZv
ciBpbnRlcm5hbCBsaXN0ZW5lci4NCg0KQlJzLA0KWmhlbnpob25nDQoNCj4NCj4+DQo+PiBXaXRo
IHRoaXMgYWRkcmVzcyBzcGFjZSBzaGlmdCwgUzIgbWFwcGluZ3MgY2FuIGJlIHNpbXBseSBjYXB0
dXJlZA0KPj4gYW5kIGRvbmUgYnkgdmZpb19tZW1vcnlfbGlzdGVuZXIuIFRoZW4sIHN1Y2ggYW4g
czJkb21haW4gbGlzdGVuZXINCj4+IHdvdWxkIGJlIGxhcmdlbHkgcmVkdW5kYW50Lg0KPg0KPmhv
cGUgYWJvdmUgYWRkcmVzc2VkIHlvdXIgcXVlc3Rpb24uDQo+DQo+PiBTbyB0aGUgc2Vjb25kIHF1
ZXN0aW9uIGlzOg0KPj4gRG9lcyB2dGQgaGF2ZSB0byBvd24gdGhpcyBpb21tdWZkX3MyZG9tYWlu
X21lbW9yeV9saXN0ZW5lcj8gSU9XLA0KPg0KPnllcyBiYXNlZCBvbiB0aGUgY3VycmVudCBkZXNp
Z24uIHdoZW4gZ3Vlc3QgR1BUVD09UFQsIGF0dGFjaCBkZXZpY2UNCj50byBTMiBod3B0LCB3aGVu
IGl0IGdvZXMgdG8gUzEsIHRoZW4gYXR0YWNoIGl0IHRvIGEgUzEgaHdwdCB3aG9zZQ0KPnBhcmVu
dCBpcyB0aGUgYWZvcmVtZW50aW9uZWQgUzIgaHdwdC4gVGhpcyBTMiBod3B0IGlzIGFsd2F5cyB0
aGVyZQ0KPmZvciB1c2UuDQo+DQo+PiBkb2VzIHZ0ZF9ob3N0X2RtYV9pb21tdSgpIGhhdmUgdG8g
cmV0dXJuIHRoZSBpb21tdSBhZGRyZXNzIHNwYWNlDQo+PiBhbGwgdGhlIHRpbWU/DQo+DQo+eWVz
LCBhbGwgdGhlIHRpbWUuDQo+DQo+LS0NCj5SZWdhcmRzLA0KPllpIExpdQ0K

