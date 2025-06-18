Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5535AC7115A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 02:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRi5e-0007eV-C3; Tue, 17 Jun 2025 21:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uRi5c-0007eB-DA
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 21:59:48 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uRi5Z-0006au-JB
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 21:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750211985; x=1781747985;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fvHpSqXwKJx2eqtHYerzBz579ABzew6/HlpnkAjaS/8=;
 b=PKEp7WM5PQXatvma5UHdph2wW1NVlTAZYkidiuns/xSoPomUVJzx8dxS
 ai0jsH5F5wVYFi3Fmi245AaqCJ3eQM+gEZKntclq9m/TXcvg40tkmEHjZ
 G5uMdeKjMMfE5hBn/3Sb1N/nhz5h0l9rdXejVKFIoL5KszXfwd8gVJEny
 v6nuyBLGH6J0HqZxJKFq6nNpR5mkie6c04/M2c3dUgCIbUEG8rTADdU5Q
 9gjfuoy+pXqZRmW3nqUZWMA8uwWaH2rwr0v86aDh4D4DycnvSqLItSQbu
 hrU8CjPuej2SCi0nK09vMmdWN088wT4b/uOf1f3H94aBGEJuMMaJEu5O4 g==;
X-CSE-ConnectionGUID: acb/0C58SiWHwKHb2oPI2Q==
X-CSE-MsgGUID: +dhmg9psTfCfyqBwjmszxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52503416"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; d="scan'208";a="52503416"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 18:59:36 -0700
X-CSE-ConnectionGUID: ia6FJBMfREatkDSx+8N9jA==
X-CSE-MsgGUID: SRDYu36OQCSN6QnzcZfl0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; d="scan'208";a="149445784"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 18:59:01 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 18:59:00 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 18:59:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.84)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 18:58:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQKU3qh+OJXCE6oLY8wHvS4aAMG2+qecqB+mHRUgjf6A5SR29dfi8PbUr1ufLa1AwgEErVNzOwm1M5fzf56j6KdBDmClV+P8K4b061W90BdpIsIknAst5/jJ3jd82MRixAGMTBSjm/OBIxyvoaam2cHpCsZNY08L05EBYZzBq4172W3/U1hBi83SEhYeB2UiHLevuQ8Kdjuo1yBnmjnJV6Agh9tQNlzltX0bzffpCybuM5m7PTswBbNTZetzuY9BqTWORAF8NMw6Db42Jhpnme+oi77TBL9YjlmiT3JOfeG0CSDhJQ1XyxslE+M4ugenmT+MFCFZqhJRjnQdRyNNbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvHpSqXwKJx2eqtHYerzBz579ABzew6/HlpnkAjaS/8=;
 b=d/a4UxOu+Ev5hM+bm+nqobPGLtaSm/I/jOTOVAz070OCUMwlzyq941J3wHQvth8fNQyaCprZSzNUCiqerPchMg5LAxeLLqMPoSNnss8GFZZSBb8E69lHUp2JU/OeQKxMnH7CgJYud3U3XIxq6WZXPXWzHx4S3Svm+7bx8pd59LEqhfs+FpIY4B+tGX79B2KqLyECRj72rjEOj8lQomzMwfQKE6rouwkWft2B0sfzexiCbdXn3/453WZrpmLQ7UI2wAlW4ZTDvvhVtgp74P06sr0PAlw0fZsX3ZsiEaet5+YdKSA/1H1QJ0m93VbeQiMJDvh835sFicGHP96xomtSVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ0PR11MB5183.namprd11.prod.outlook.com (2603:10b6:a03:2d9::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 01:58:57 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Wed, 18 Jun 2025
 01:58:57 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: RE: [PATCH v1 02/15] intel_iommu: Optimize context entry cache
 utilization
Thread-Topic: [PATCH v1 02/15] intel_iommu: Optimize context entry cache
 utilization
Thread-Index: AQHb1srx8KBRZWY3jE+gRF83S3+bB7P9nMkAgAAl5iCACX0OAIAA+4uA
Date: Wed, 18 Jun 2025 01:58:57 +0000
Message-ID: <IA3PR11MB9136E7C1BC209032FD0B1DDB9272A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250606100416.346132-1-zhenzhong.duan@intel.com>
 <20250606100416.346132-3-zhenzhong.duan@intel.com>
 <a36077a1-9eee-4c3b-9365-1b7a9dac3b41@intel.com>
 <IA3PR11MB913640374E35567AA052B6DD9275A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <9add1df3-1a2d-41bb-ba6b-ef625e05d7e9@intel.com>
In-Reply-To: <9add1df3-1a2d-41bb-ba6b-ef625e05d7e9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ0PR11MB5183:EE_
x-ms-office365-filtering-correlation-id: 7e08931c-df56-4fe1-8df8-08ddae0bafce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?QWxwNEJldlpudWhrTzk0bTFuOG5uMW54OUVhbXVpOXZnWFZlZXVZcDZwbjdK?=
 =?utf-8?B?dWVpRGZFelB5OTBtbHNpcUF4VkpvR0gyMXhpdzJhS0tPVW9SOXpjNWNRNHBK?=
 =?utf-8?B?SlpCb2d3RzErR051VzBFQ3dURjRBRTYwRXZUL09hdnBSNUhwcndPNHI2dVRu?=
 =?utf-8?B?RHlTSVAwWkdqZ21QT1Fnb1NCemVvUkZSaXp4UWtYQjk2V1BVK2c4ZkRIOEtH?=
 =?utf-8?B?NDZzMU1iYndQOEJyZTdZdC9uUjVyUHBaQWlvQnJkdStUOXl2Qm56bFF1MmZk?=
 =?utf-8?B?VWtTcEU4Q3Q3R2hadnpLYi92VEhVTjRWSzJNNVFqTjBjV1YwMExObUMwcGd0?=
 =?utf-8?B?K0VpeUVkZUhmdmhQNmJpV2JLTU5sMHBuWWxlZEdYYUN1cWZqY3RZbGRwSDNO?=
 =?utf-8?B?bkNvY3FMK0pmaUx3N2FENzdhTmVpanpXMmtlZk8yV3I4cnJLR2hNdDRMK2g3?=
 =?utf-8?B?SXJNd1dZQWgzRi9lRnEzT1dNMWw0bHhWMEpIRllNbTJhMVkrUndBc3BSM294?=
 =?utf-8?B?UTNaZmJYZUhaWjJQOXl3alEvZUhBUG9LRU5iV2kzaGNrVnFmNzBnWmVTOVVS?=
 =?utf-8?B?OEZLNmU5dkFrZWFhNitHQXVJRFRCNVBEN3NnMnQ1d2NjRDNkVC9MUFZhUEUv?=
 =?utf-8?B?TTZsYmZwa0d1SlpkSjJnTU9iNWNiZ09hb2M3UStmbFNORFZlQVpCWnluMHNx?=
 =?utf-8?B?U2xtVTRhRWpNV2xNNFRtRVNyR2hnVUNjUU5YR0VYYVRGK1QwS1F0WHZhWDlZ?=
 =?utf-8?B?VW84bHozMitXNktZSSt6SnRmOHRhZmsyOC9hMjduRGxraWhvVGVmNVlSRTV1?=
 =?utf-8?B?RzhyK1J2M0NvaHVuU2hQUXdzQUlid0lMRWtCUkVRelVwRFNTVnNkL0RLUmVT?=
 =?utf-8?B?NS9sY29kcU1CVDE0QkJKUTVHbThxUWdSMVNXTWxPR2x5Vm1iYy8wRS9rdXBG?=
 =?utf-8?B?MFhkM05LU2M2STA2VW9YdlNHTk9rUmRCckRZTEtiNVdqZmZWeFYwT04wK0Ji?=
 =?utf-8?B?cU9HaUx1M3BTVnMwK3Q5ZjIya0xQVHhpc0JGM2JNUnVOT0psZEVoVlh6eXRV?=
 =?utf-8?B?ak5IOXl5RGxiaFRYTmIwMzlaZTVrM3JjSGtFTDk4Yk5DQTdJRGdhZE5HNWpk?=
 =?utf-8?B?OTh2ZFFNY05majF4aVBEa1RJQjFUSGJFT3lwV3ArQUloMnVSL1NQSGdYbEhm?=
 =?utf-8?B?dHBjVndaOW9pZEUwV29kb3lNNDJneDBtK1ZLZ1BvWEtQZG1uMWdmWWJhSVh2?=
 =?utf-8?B?UmhieG42YVlkaFRlVDZjbFpRN0FvdENObXM3WndPWlB3NTRzcEJJV09wVWxK?=
 =?utf-8?B?ZXlsVGhtdkwxSWlYM2FhcWhXQWl0cGFITWN0WG1TalBnZ0RxWDdMeHVmT3lu?=
 =?utf-8?B?bGh4dkw5bDhERU1LMjVSY1JNak9STDdwaC9GZ0RzUkJMK3ZramcwaWxVQUxB?=
 =?utf-8?B?cGhpNENYS0F6Q1NyRDBqMTVuYVZSNzlGSWtQcnYySGJJVGI5dFdrcEJPNnRx?=
 =?utf-8?B?UHJxbldudThBMHd1RVJaVHVveGs1a3N0UEl0RWNhWXFGSkJVbFpPSUsxTzBH?=
 =?utf-8?B?S25YMTNtcnh6UUgxUk9PWlFpZk92eWVIS3QwR1pZRDJGalJCUjMrUEoyS2Jh?=
 =?utf-8?B?M3ZyMWp1dlJIUFRGMEN6TFVIcUtUOU9LN09GQnZManhKVWt0N0E0cUZSL3V1?=
 =?utf-8?B?UUpjL0xGUXpnL3JCd254dFFQbnVkTWcvRS9CbWJQek1mb3BBZVlmbUtLaDMv?=
 =?utf-8?B?MFRpdWU2TjFqN2FuaS93czNWUHp2VVJoOHVnT29Qdk40SG9ocnJJY1RFM1ZD?=
 =?utf-8?B?cVNFZ2dDSWlEN1FwbmhlUjAzMW1ldDNYV0tjbVh0WTZzN1ZlQzZvVUk4NFJC?=
 =?utf-8?B?V3NPUzRkWlFONXYvaTBBOHVnLzdsTTN6ZkdSZzlZQ2l0QzIrWkxmQnFlaEQy?=
 =?utf-8?B?OUJOc2pGY0tad21zcGlCenhQV2VzQjhFMWFsUE9VVkp2a01OM0U1OW1hSFJJ?=
 =?utf-8?B?TllUVXZja0hRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YU9iMS95K3BaUlo3VzUzM2JUQzZEbTduS2F6aDZoR1lKQ3dMWmpxYm01MXVi?=
 =?utf-8?B?ZFVVZjRjcXNaOC9lbFRmUmdXajNxbndoQzY2dGd0UURSZG1OeElEc1c3VjBS?=
 =?utf-8?B?a2ZTQWdIVkFTdDYvTzd0dXhiRy9KKytJT2hjcXVHOFBvMWY4aXpvNG1jTTht?=
 =?utf-8?B?ZHQ5aWRMbDlsSnJONFVpeDBmVjdPZlhydFUyL3Y1YXJYYzBFbm9DQTd2Wm1H?=
 =?utf-8?B?VnNkV0R1bERpYWovK1dnbmlGamV2V1U3MVN0UFpmS1hqOHpBTW5XVnhLM1cx?=
 =?utf-8?B?OERPWVA5V0tJZ2dkNXp3bjB1K21XSUd6YjBHREJTbk1aWmd2S2pXbHhxVXFN?=
 =?utf-8?B?eHgwdzE5bDUwNTZrSlNYNDRYcTgvdllMb29BdC8zM0RxQ1l5S2JwT29mZk42?=
 =?utf-8?B?ZDJ2QjBxMTRWampyKzI0eXpjd2laUVZqNjl1M1hMU0hSb2NaZFo4allPVEt3?=
 =?utf-8?B?SEwvUFdkaUR1alFvTjZtNHFNQTI5NDJTRHRrZHNXM1ZqdzVnbGxVNE81OWtp?=
 =?utf-8?B?YjJxTnEyOW9uWUE5VTdaV3NiQ1MycVJ4K3FuTGtmcm9yZzZ6WUdjWHh1K0Ju?=
 =?utf-8?B?cTk5SXpLTDF3b1NMWldxd3E0NTZwaUQ3R0tDb0JqRmdQZWVCdUVDeHdBVlVl?=
 =?utf-8?B?M2pnY1F1T2M0cmZwZ3dNNVNheWxkaXJrTi8rMXRGcGNIQ3ZCZnFqMEduZWVR?=
 =?utf-8?B?N2VqWGxOVVlYUjhINEVlWk1uWDByanEzMDFmbSt0alZwNUdzeHBLWGxqQzN1?=
 =?utf-8?B?UkNsc2tLRW4yeGZyTUdqZEtVdUlHRktkVFpiVmtLdm11cm5QeEVHYjNlV0pa?=
 =?utf-8?B?ZWdLQS9sL2l5aGNNamI4UlRTMUdIanhzbVQ5bG1nV0cwb2dCT3NidXV3bjVZ?=
 =?utf-8?B?TXRXMm4rU1huUE81VXNSM2U2VWtNSDhLNTlOL24zbkUycHpROWdrR1RMMTB3?=
 =?utf-8?B?VHMraWVyZTFlclBYOFVOOXg2OHpQdTcwcmtwcmR0VGhKZElFMGRtTU5qUVVS?=
 =?utf-8?B?QWNUQTROTXdlNFQwTGxoV3RLL2ozRkJmWTJaZVIrT003NGFWbnZVUUpRbWg4?=
 =?utf-8?B?YlJDSDZ1c3dVeENKWVc4cXlPeG9MT1ZOOTZxYWNzNXBJNDJ0MlFVNGo0bU1j?=
 =?utf-8?B?VmVBS2pnbWdGMjRCOGtFN3oyM2JRMFJwMDZubGF1QWJJdERqVVdTYVFrOVJw?=
 =?utf-8?B?T0xhVjN6WUppK0dFVm1VakUwOEt3bWVZUHZyUlBEdUtMSjNpTWRJTVdYSzNM?=
 =?utf-8?B?eXIxMUhiZFVGdCtGTWQyaXhEYlZKMGdtUTM2YkRRQzl6a3pOTUlKY1VtMm52?=
 =?utf-8?B?aWpTOExDS3k4d3pCTThLa1Z0ZWZWY3hDNGttUnVncWFXNWhxc1pDbnFPcnpR?=
 =?utf-8?B?aTNUUnFyRlJ1Q210NmxrVjQ5NkdXME1DMmRHTkRPRloydnFnUVpCcnM3N2t1?=
 =?utf-8?B?OEx4ZDEyMGVUSWZvUE1EdG91SGlyS1BuV3ZJakgrcmpudFdxV1Y1d2drektp?=
 =?utf-8?B?MDYxSHlqeGdtR1Z1TGY3YWFReXd5dDg2YktVMXo1Z1B5NGxINkNXa3dTS1Zo?=
 =?utf-8?B?UG9qS1RwSzl0UnNpdlg4WDM4aU96RHJSVzNLZUhRR3ZhMjB5dE5CT1dQeHhi?=
 =?utf-8?B?ajl1Sy90SHlSOXlVWS80K0tyMklEV1hOb3oxYmVZS1ZTaUp3aGtSd01Vbm9s?=
 =?utf-8?B?VktMbWVNaThqeUFEUjlSTUZycmlqVExVN2J2ekd2ZWpHVndMUDB4bW40SW5W?=
 =?utf-8?B?RkdVME5zRXJSbDJBK09LYjl1TVlKekhKUWlQSWJSMjVDdVppT3VzUkRzMEFu?=
 =?utf-8?B?elIzSXZaVkQxbnJ2QlpXNWEvbmQ5SUpGWnhwY2Eyd1hnVHJQRjBKVGc4RS9v?=
 =?utf-8?B?NE5oZXdIZDRpTHk0RzRqOWI0WnJianp3OXpMbHppTGMvRXZma2F5R215RWs3?=
 =?utf-8?B?UGhGQUk0SkJ6N3ZhR2Q4RkUvaFJuaFhIR2xZVm04TTF5M0hzYUlNRHJVZGFC?=
 =?utf-8?B?V3BqbldMWVJDeko4NkdwdkVEdGc4NUtHN09oKzJWVFV5TU8xWGlHU05NdTRI?=
 =?utf-8?B?SkQ0YUZweTBYaEM1M1RVSmhxaUQ3T01tQWh2VFAyMGFWOEc3Q3ZPcGNhcEk4?=
 =?utf-8?Q?/D6qb8yLLITmDaY7WVuPliS04?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e08931c-df56-4fe1-8df8-08ddae0bafce
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 01:58:57.3382 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Le4tuT8eAN99BdHM5WoEqSAnAr1wrUhR8ZJO/Kg7k3UOcd2nJzg8EdaHXJKSJgAtS8N5Ck1xXTbLR9+v3kknWD2WPoHseI+ZarvD0eMazM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5183
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
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
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDIvMTVdIGludGVsX2lvbW11
OiBPcHRpbWl6ZSBjb250ZXh0IGVudHJ5IGNhY2hlDQo+dXRpbGl6YXRpb24NCj4NCj5PbiAyMDI1
LzYvMTEgMTg6MDYsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+DQo+Pg0KPj4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5j
b20+DQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAwMi8xNV0gaW50ZWxfaW9tbXU6IE9wdGlt
aXplIGNvbnRleHQgZW50cnkgY2FjaGUNCj4+PiB1dGlsaXphdGlvbg0KPj4+DQo+Pj4gT24gMjAy
NS82LzYgMTg6MDQsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4+PiBUaGVyZSBhcmUgbWFueSBj
YWxsIHNpdGVzIHJlZmVyZW5jaW5nIGNvbnRleHQgZW50cnkgYnkgY2FsbGluZw0KPj4+PiB2dGRf
ZGV2X3RvX2NvbnRleHRfZW50cnkoKSB3aGljaCB3aWxsIHRyYXZlcnNlIHRoZSBETUFSIHRhYmxl
Lg0KPj4+Pg0KPj4+PiBJbiBtb3N0IGNhc2VzIHdlIGNhbiB1c2UgY2FjaGVkIGNvbnRleHQgZW50
cnkgaW4gdnRkX2FzLQ0KPj5jb250ZXh0X2NhY2hlX2VudHJ5DQo+Pj4+IGV4Y2VwdCB3aGVuIGl0
cyBlbnRyeSBpcyBzdGFsZS4gQ3VycmVudGx5IG9ubHkgZ2xvYmFsIGFuZCBkb21haW4gY29udGV4
dA0KPj4+PiBpbnZhbGlkYXRpb24gc3RhbGUgaXQuDQo+Pj4+DQo+Pj4+IFNvIGludHJvZHVjZSBh
IGhlbHBlciBmdW5jdGlvbiB2dGRfYXNfdG9fY29udGV4dF9lbnRyeSgpIHRvIGZldGNoIGZyb20N
Cj5jYWNoZQ0KPj4+PiBiZWZvcmUgdHJ5aW5nIHdpdGggdnRkX2Rldl90b19jb250ZXh0X2VudHJ5
KCkuDQo+Pj4NCj4+PiBUaGUgY2FjaGVkIGNvbnRleHQgZW50cnkgaXMgbm93IHByb3RlY3RlZCBi
eSB2dGRfaW9tbXVfbG9jaygpLiBXaGlsZSBub3QNCj4+PiBhbGwgY2FsbGVyIG9mIHZ0ZF9kZXZf
dG9fY29udGV4dF9lbnRyeSgpIGFyZSB1bmRlciB0aGlzIGxvY2suDQo+Pj4NCj4+PiBBbHNvLCB0
aGUgY2FjaGVkIGNvbnRleHQgZW50cnkgaXMgY3JlYXRlZCBpbiB0aGUgdHJhbnNsYXRlIHBhdGgu
IElNSE8sDQo+Pj4gdGhpcyBwYXRoIGlzIG5vdCBzdXBwb3NlZCB0byBiZSB0cmlnZ2VyZWQgZm9y
IHBhc3N0aHJvdWdoIGRldmljZXMuDQo+Pj4gV2hpbGUgdGhpcyBtYXkgbmVlZCBkb3VibGUgY2hl
Y2sgYW5kIG1heSBjaGFuZ2UgaW4gdGhlIGZ1dHVyZS4gQnV0IGxldCdzDQo+Pj4gc2VlIGlmIGFu
eSBsb2NraW5nIGlzc3VlIHdpdGggdGhlIGN1cnJlbnQgY29kZS4NCj4+DQo+PiBHb29kIGZpbmRp
bmcsIHllcy4NCj4+IFByZXZpb3VzbHkgSSB0aG91Z2h0IHRyYW5zbGF0aW9uIHBhdGggdXBkYXRl
cyBjY19lbnRyeS0+Y29udGV4dF9lbnRyeSBhZnRlcg0KPmNjX2VudHJ5LT5jb250ZXh0X2NhY2hl
X2dlbi4NCj4+IEluIHZ0ZF9hc190b19jb250ZXh0X2VudHJ5KCkgY2NfZW50cnktPmNvbnRleHRf
Y2FjaGVfZ2VuIGlzIGNoZWNrZWQgZmlyc3QsIHNvDQo+dGhlcmUgd2FzIG5vIHJlYWwgcmFjZS4N
Cj4+IEJ1dCBJIHN0aWxsIG1pc3NlZCBhIG1lbW9yeSBiYXJyaWVyIGxpa2UgYmVsb3c6DQo+DQo+
eWVhaCwgdGVzdGluZyBjb250ZXh0X2NhY2hlX2dlbiBpcyBuZWNlc3NhcnkuIEJ1dCB3aXRob3V0
IGxvY2ssIHRoaXMNCj5jYW5ub3QgZ3VhcmFudGVlIHRoZSBjY19lbnRyeSBpcyB2YWxpZCBhZnRl
ciB0aGUgdGVzdC4NCj4NCj4+IEBAIC0yMjc3LDYgKzIyODYsNyBAQCBzdGF0aWMgYm9vbA0KPnZ0
ZF9kb19pb21tdV90cmFuc2xhdGUoVlREQWRkcmVzc1NwYWNlICp2dGRfYXMsIFBDSUJ1cyAqYnVz
LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2NfZW50cnktPmNvbnRl
eHRfY2FjaGVfZ2VuLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcy0+
Y29udGV4dF9jYWNoZV9nZW4pOw0KPj4gICAgICAgICAgIGNjX2VudHJ5LT5jb250ZXh0X2VudHJ5
ID0gY2U7DQo+PiArICAgICAgICBzbXBfd21iKCk7DQo+PiAgICAgICAgICAgY2NfZW50cnktPmNv
bnRleHRfY2FjaGVfZ2VuID0gcy0+Y29udGV4dF9jYWNoZV9nZW47DQo+PiAgICAgICB9DQo+Pg0K
Pj4gQW5vdGhlciBvcHRpb24gSSBjYW4gdGhpbmsgb2YgaXMgYWRkaW5nIGxvY2sgdG8gY2FjaGUg
cmVhZGluZyBsaWtlIGJlbG93Og0KPg0KPnRoaXMgaXMgaW4tZW5vdWdoIGFzIHdlbGwgc2luY2Ug
dGhlIGNjX2VudHJ5LT5jb250ZXh0X2VudHJ5IGNhbiBiZSBtb2RpZmllZA0KPmFmdGVyIGxvY2sg
aXMgcmVsZWFzZWQuDQo+DQo+PiBAQCAtMTY1OSwxMSArMTY1OSwxNSBAQCBzdGF0aWMgaW50DQo+
dnRkX2FzX3RvX2NvbnRleHRfZW50cnkoVlREQWRkcmVzc1NwYWNlICp2dGRfYXMsIFZURENvbnRl
eHRFbnRyeSAqY2UpDQo+PiAgICAgICB1aW50OF90IGRldmZuID0gdnRkX2FzLT5kZXZmbjsNCj4+
ICAgICAgIFZURENvbnRleHRDYWNoZUVudHJ5ICpjY19lbnRyeSA9ICZ2dGRfYXMtPmNvbnRleHRf
Y2FjaGVfZW50cnk7DQo+Pg0KPj4gKyAgICB2dGRfaW9tbXVfbG9jayhzKTsNCj4+ICsNCj4+ICAg
ICAgIC8qIFRyeSB0byBmZXRjaCBjb250ZXh0LWVudHJ5IGZyb20gY2FjaGUgZmlyc3QgKi8NCj4+
ICAgICAgIGlmIChjY19lbnRyeS0+Y29udGV4dF9jYWNoZV9nZW4gPT0gcy0+Y29udGV4dF9jYWNo
ZV9nZW4pIHsNCj4+ICAgICAgICAgICAqY2UgPSBjY19lbnRyeS0+Y29udGV4dF9lbnRyeTsNCj4+
ICsgICAgICAgIHZ0ZF9pb21tdV91bmxvY2socyk7DQo+PiAgICAgICAgICAgcmV0dXJuIDA7DQo+
PiAgICAgICB9IGVsc2Ugew0KPj4gKyAgICAgICAgdnRkX2lvbW11X3VubG9jayhzKTsNCj4+ICAg
ICAgICAgICByZXR1cm4gdnRkX2Rldl90b19jb250ZXh0X2VudHJ5KHMsIGJ1c19udW0sIGRldmZu
LCBjZSk7DQo+PiAgICAgICB9DQo+PiAgIH0NCj4+DQo+PiBXaGljaCBvbmUgZG8geW91IHByZWZl
cj8NCj4NCj5JZiBpdCdzIGp1c3Qgb3B0aW1pemF0aW9uLCBwZXJoYXBzIGp1c3QgZHJvcCBpdC4g
OikNCg0KRmluZSBmb3IgbWUsIHdpbGwgZG8uDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

