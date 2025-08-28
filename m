Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7CFCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 05:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urVa3-0004hj-P3; Thu, 28 Aug 2025 01:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1urVa1-0004gB-Fl
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 01:53:49 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1urVZy-0008Pj-EJ
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 01:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756360426; x=1787896426;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZCa7lN6FwwHtX/CBzCAOTxuL4rpjwvOLC3qXq789r9Y=;
 b=CR/nK/5ZXGNXYkqBf6+XVZhdNd4lepkIUv2scPfKdBfdADE2EdKuJzay
 5yAVEM8BGuYaoS5DfdL/jcpMJxjBo4BYnjaaMFED/tVvKjJ+uqiCQryS+
 glLPUe7zy3847RSzhNs03Drd/5QTC6tkUj9y8/43XqZsxOd3+fGMhS+oG
 m/aI5cBp/TclyzbV4C4CzB9OAIzhb7NuzHOzuFiisyQxaZo4nsudvXKNP
 +eJrvO8DL9iRr4aFSun1TosfrOzkfJOVC7g8q0JRsjDyBa577U92sdVZI
 pgJ1yQNkdyoEHxOp/MxMs/71kdRVSeOPz0av7OeiiNT4fWqJB5Dm7aEXQ Q==;
X-CSE-ConnectionGUID: q1c8JSbnQL2eM1QYKHHYjg==
X-CSE-MsgGUID: IiLgSm1jTd6QgpSL9BvsXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="62264097"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="62264097"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 22:53:42 -0700
X-CSE-ConnectionGUID: oO00UxyyTUOpNTgXhtUSDQ==
X-CSE-MsgGUID: FfQ1/wGiQIqEQB2ZCiwE4g==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 22:53:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 22:53:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 27 Aug 2025 22:53:41 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.88)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 22:53:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjbt83HN8YYXOdsa8WPhyn6Nmc+N1yf/b0jRn8+VLtHPYd+smANftwxPrlDhBilSFHX5RdZebnB/LVflEIqHIrLr5TNnoG0d3M6yw85XV7SdTaxQ3zXHjZy1HIub+GXZLU2vxyUYFFa4dT0QP9aZA576m3bLMzWKMXygSsHeUyKJ/Yt+RRcYKVCXUVOrN2IZ6XLrFxrIk2f95OAMo2yCKbt0spFo0+OWVabp533I+EFcD0pGDcAezzYhfgC+hOAb1Zv1Thbug+Vyqb+f4fw7ZkS50lhxPte3zMgy9xMYv1ihHsGLxk6qkJNMQuERXp6ybv85Iw2YWssXlAmeyrPxlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCa7lN6FwwHtX/CBzCAOTxuL4rpjwvOLC3qXq789r9Y=;
 b=hFpB+UrWhvMbR3A+Nz0DHmlAbHQmIiJSE25fJZG9IMsqvnX6zIBFngyRPJiL6bDO8iScyV9GAdbM1MWP22K+0m/0RSdDUB5vHjp1Yqx7ut0qjNYL2ZxZA5euKsrV7Xj09dYYHX5wEmy+VVncLbHyQnoyj6Az2ZtQwDDBFp/o+y9zd+75sIHFTuMRTdxBAW6Hpc+QzzJuLQQ+xXrFfooN+IiQprXS7VxNy1y+sY2X4nOwJTTXd1SGkdTIPv16+8c0TAX4RPueyp3YT9p2DDkZBnM1/UtdFB4+P+iiJ5FOdi+tpl2E9DwU9H7Z72gM/hB8Ng0EJ/Yg1n8NnlqYJSLBKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH8PR11MB6561.namprd11.prod.outlook.com (2603:10b6:510:1c0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 28 Aug
 2025 05:53:34 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 05:53:33 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v5 00/21] intel_iommu: Enable stage-1 translation for
 passthrough device
Thread-Topic: [PATCH v5 00/21] intel_iommu: Enable stage-1 translation for
 passthrough device
Thread-Index: AQHcEy/MLyWBxIOJg0adIAic9u7SpLR2YOQAgAEVQ1A=
Date: Thu, 28 Aug 2025 05:53:33 +0000
Message-ID: <IA3PR11MB913664EF4F882473DD882AFD923BA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <278c6fe2-9d7d-4695-b837-8cde2c8223d6@intel.com>
In-Reply-To: <278c6fe2-9d7d-4695-b837-8cde2c8223d6@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH8PR11MB6561:EE_
x-ms-office365-filtering-correlation-id: aa378834-699c-4008-aafd-08dde5f73961
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?SU1JOVc2OU0waUMvR1d6eHB1SXNEUFpYR3Zlb0wzSC9TSFBYNGtFUmN0Rmow?=
 =?utf-8?B?L3FPWnhYVDQ5S0ZPQjBxZ0RsMVpnRTZVWXA0TG5Qam5FcitBRWNqVTd0cHFj?=
 =?utf-8?B?OEFUUUw3VGFrb25pdTZBNDcySS9tNFUzeERreTN6cFBlWUtrUlZoMGlUNmxX?=
 =?utf-8?B?OVpjUDhVb0FmRkhwT00vUnY4bG9uYlRQc2djNzlvVkZyTENCT2h2MEVYbXFk?=
 =?utf-8?B?YVVpNFFIZTdCWlJ4MTlPVUlmbUJrN05CbG1xY2Qwdm5nRzMzRzdESEJzYWlT?=
 =?utf-8?B?NDU3U3hTWnBZVlo4VU5uMnYrT2RSSkJ0SGo3NVFWVXpBRkVOQnk3b2tJWCs4?=
 =?utf-8?B?QVJtUjlsbjdVRDBhaS9xTUI0WXdFMDhVc0c3SG53SGIwOFUwRy8wakp4YTI0?=
 =?utf-8?B?VXFvWk9MMFZiWWVXVkk5SlJ3YUF1UW9KTjh5WEN1TUJNZlB0S2x6Z3lGdllR?=
 =?utf-8?B?SExsSmxVSHpZeTArWHFWVnFzWnVoQ1BHdXUwcWlEWjFoS0VmVUhySG1GUWlP?=
 =?utf-8?B?aDYxTVVreDF2eWxUcnlESElTS0trSVo4RUNXOHhDblVsT2src0s1b1lYZHdZ?=
 =?utf-8?B?UElPMm1yREFIalpERnR3R3RqS0EwOVpKVU04d0dYcVdkMWRyWk5qTEV2dTNa?=
 =?utf-8?B?M3pBNnF3ZUlrUFozNnRpbHRFUDBzRURJaEZNa01TaFZRV2tweWdhK1Evb3hM?=
 =?utf-8?B?dFhEZGxMbWpPYmtVM3V0MzBlUzVUSjJMQ0VxZjVHTFNJQzdaQVQ3bElVUFUw?=
 =?utf-8?B?dzhWRis0WDhXVE1UVTIzQlNpRFd6OURrYWhibUdVS0x4ZDFqREVXTmt4d2xp?=
 =?utf-8?B?ZTdJalNUTkhSUHgrSzJIUjQ0TEJBSlJiZGxrdnJTYjg1eHZUemFSYWNBcnVW?=
 =?utf-8?B?RUYzOW9LYXlzREwydlVBckRZQXpYbVd6K3hyV2hMaUF0aGZlL3VnS3hFQThJ?=
 =?utf-8?B?QUcrc1ZXTTVTeFdvdG9BQ0dsZW9KUGFTbndqbzBGZGJIempUUEJERXBHMDNX?=
 =?utf-8?B?NjlVemtzRTZlZTByNXkxTGhnVU5jRVBYVXhEMUdMQmpUdkNQMk8rWEJaWFNB?=
 =?utf-8?B?VE93NmFkdktLMDR3aGozaTlHVzZrSzBBcWhGWEVxcFcwdVNOOUVhWDh4SUVU?=
 =?utf-8?B?YXFBZmR3UUpCVkJzdVVhKzNvWGtFN0JndTV1ZnU0aTc3MTFGaWthTW9xUTJt?=
 =?utf-8?B?WGNWalh4bEY0YVpQb0F6UkJIbXJGc2NvS0xxaFB1YjJWL2hWZEhmcy9mSzVi?=
 =?utf-8?B?ZUU4dTZtZUVLSHUweXRTb3RCNnhYZzZJQS8zRmptMnVRS1gwMzVoYlh1TnRT?=
 =?utf-8?B?WTVpSm9qaWZ6Z3pnNWhoWVpsTHBKbFRsOFpMbWlpRXIxVGtBNURERzVGblgw?=
 =?utf-8?B?dmV3YUh3RFlIaDBlUmx4U2gwSFlqdDVEZWE4NEF2YkQzbE9Md0Z2b1Blb0N5?=
 =?utf-8?B?YXYram9ZVUlpZVRjYXc5eXp6dHBxVHVNSVJPaG9IMDBMckpjMG1KaEFrbk9u?=
 =?utf-8?B?L1BSOTNaRUFRSC8ybE56a3lMbXdzbFErSUw4d3RtYXZVQ1lvRXJTRFA0SHZm?=
 =?utf-8?B?ZDc1cTJYVk1vUEdkaXIrazhkUkxNdmZDS3NQWFlRNlpxcWlBSTBJQnB6ZDd3?=
 =?utf-8?B?UlQrb2JWeHUrUzhNUCtiQmZYRGZBVk4yTWk2UWFBZWlacUkrcU1sV3Z5YlhM?=
 =?utf-8?B?ZDNyK3FEcmxjcUR4YndXWjNUdHVpbGtFdVJJRVdnMnBwMDNnV2RNeUdXQU1y?=
 =?utf-8?B?MjBsMXF0Um1ZWFRmOEFiZVEzcDdFTzVLT2lYMDJ5YVQrQkl3S0IvMms2cGNT?=
 =?utf-8?B?UjJOQnpXQkt0NlBxakdLem9vKzMrR2NXZHhTZndXd1FVNk1HWlJDRUJhbi9z?=
 =?utf-8?B?YnZpSEorRWlKeWllZXdFYkp0NE81aFYzWCtVNkJuK0RzMFRZcW5PTHpnbi9J?=
 =?utf-8?B?RHMyREVneGVRMUthN1F3Y2hPRGRNMWJLZ0RXbVZ0eXJUOWdYV00rZ3VNekt0?=
 =?utf-8?Q?9fZohM5bRZw2e6KdmVgzGEvB9lZSkg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3ZvdHRGc2czMnloM2cxMWxJb2c2ck1rb1ZONFp0cmNKaE8zV1NIVUVPL2c4?=
 =?utf-8?B?bloyb0hvR0RmYXp4SHNPdW9ZN3BMZ3p0VGw4V1ZpNzZidDNXNEthVXhCclB1?=
 =?utf-8?B?bzcwTkFCanZ0NDRvNVU4YUlydW1oczcxb28xdmEzOTBzT1pjK3Zrd3h5bW5T?=
 =?utf-8?B?N0NrUUV3SWs4QVZmWGJKZmFGN01oSGllQTBDS1YxTS84MDlMTi9CQ2ZBcTEw?=
 =?utf-8?B?ME5FdXlaQTJLcTVVaE1aL0dxTlEyQXFLUE1tY0N1TG5hZXpJQnZPWlpuMkNj?=
 =?utf-8?B?TU1wWHA5b0hCaTRCQlVjL0dTNWtvaFVkYmlBU2NUYkU2ck1VckdpUlFCYUUr?=
 =?utf-8?B?cFI1ZmZKNUFGSXBzT3BFbTFlNkJVeksvWHg1dG9IbkZuT0VSUVBiSjhudElo?=
 =?utf-8?B?dHcxZnppTVZtek9zaTgyN0trRzM3dEtOWE80OGRLbE1JTmx6VzJBcWhjeXpj?=
 =?utf-8?B?WkttWkFISEFoYitma2xWNm9hWmVZc2dGVnYzejMzS3JPdUZ6N05GN2JTQmJk?=
 =?utf-8?B?STZ5T0JTeTMvNWdXdkwvRGxwUElvTGE2T2FobXV1YUpzcU9iSlU0M0ZabHln?=
 =?utf-8?B?RVF5MGV6ekFlRWRxeFEwVnhIdGpHTUlWNm81emF0R1daZnZtLzM2UHduYjF1?=
 =?utf-8?B?MmZ3dzBDZzJEUGRzanBkT0dXeDJxMjRQaSt5cDZ1b053c0VnOFJIbHJiRk5X?=
 =?utf-8?B?M3RiU2N1NytZeDZvNVJ6Z0F3WXd4UDhXTFFVS0xXY20vNy9vU1JESGZ5Y0dJ?=
 =?utf-8?B?M2pRY3ViUkNJN2tSTGhzT0NPcUc1dVljZ2JsQTFBaG1SVEhsNUt6dWMyNGRs?=
 =?utf-8?B?YytDdS9UUlFsbkhDeHV0KzRDL09STW5NRU5YOHJYY2YvRUp0YTBJWXQxMElK?=
 =?utf-8?B?b090SWRMMVdqSkdGakJ4ZkpDZFNWMWs1S1F6cnNMUjZOUDZaWXFWZlliUElw?=
 =?utf-8?B?eTRlMGhXb01NZDlXcmh1Wk12MzJIM1E1Unl4b0E1a3ZvS055YWFTeGpRQm8r?=
 =?utf-8?B?ZTJURWtGbmg4cGtXenk2ck1WTEN0WUQ3L05TMlE3M3ZzVm5EMEFza0pDZ3NQ?=
 =?utf-8?B?UTR1Q2d3MnA5WXZyVjQrOGJOWUpvQWowN2lDU1NPbUVObXUyYVhSUmpmd0M4?=
 =?utf-8?B?VHhjODFpUjJuZHVBRkdxTzAwUEFmTUpKVXJmUGVrSE1mQWRkcUJrMWd3MjQ2?=
 =?utf-8?B?dis2R0RQVE00NUxRWHRFV2d6NHlpbktkN1ZMQUxNaC92ajFKeGNmUEE4SkVl?=
 =?utf-8?B?LzJWUnNKYWt1cGMwVGxwYVdTdkNWUnFHaTM5SEliZzV6VnNvRXVJRTI2Y1lt?=
 =?utf-8?B?OGlyNDkvZlEyZ0RObEJ0ekk5MExVOTJmaGNnWWs4MlBJTTR0bHY0amNrWFhI?=
 =?utf-8?B?NzdrZDJ5Slphc1l0V2dZU3NpY2hkMXFMU2RDZWhRR0NZMVIxQlpOdXhtR0pY?=
 =?utf-8?B?Z2c3My9VUVZEbXhzZ1lWTDJTbmdwSldtSUs2YWpLdDBSd2h0cVhYVkNQY3Bv?=
 =?utf-8?B?ZDFmamhXTlUyeGJaQ1FWK0hibzZPdURTc3ZMbDV5Y0JCR2VRVHJsL3FjTlpt?=
 =?utf-8?B?cjdjeTJ5YzJZdDdQNVE0RldMU3lwVThXYW9STDRvaDMxL2U5ZFR0K1VlRTI5?=
 =?utf-8?B?ZUlPNVdIdFVNWkYxVGxYN2ZobEZGdWZYT2sxVWtNb2plM0pubE9OZVIzdnFq?=
 =?utf-8?B?YzREQ2Q0bFVBRHgyS0FmOXJsSlROTXNybWY3bmtYMzlzTlFDTkNwUktnbTEz?=
 =?utf-8?B?MjErN1ZWZUZ5ZE5CTFVna0dzWnRpTXFFNDhicHFVYXZncFl3dWhpWmRNeGNn?=
 =?utf-8?B?STNoZFRNT3gwV3ZNSTdDVHo0ZWFUKy9XcDVneW9SdzFoalNqa0FtNkNWdjhy?=
 =?utf-8?B?MmhXZ20wRmdKRTJ6TXpueW1HK1MzdWdQalNtU2ZXd2ZZNFRRWDQ1YTdLemxX?=
 =?utf-8?B?VHJIc3lsUXZHcGFhN2dQanRlbGFveUlreGVPRFNMYWlVM1hFUVdFUGdxajha?=
 =?utf-8?B?Y0xtZWtFYnJ1d0U0cmorWm5KaWxSTWZ2Nll5d0NwVUVpSTZiTFpzZ2FYa0tu?=
 =?utf-8?B?UGtkR1pCNmVSUm5XcUVTYzhSWGVzMEk1MzhNT1hUdWV6U21IYkI4WTFra1VI?=
 =?utf-8?Q?ZcKzZ2y/0ismii/f1DzAnEQlE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa378834-699c-4008-aafd-08dde5f73961
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 05:53:33.8359 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XZffdfx7p4yIRkZsL8ZyhR0n4GAG7AtoAkU61Osbg8GXVMROf2o7mB+Xo4HWIqM3AZ+/XRQTCzfVACWjz9Y+SsJplkYHpXzt3XMz9lJHBUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6561
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMDAvMjFdIGludGVsX2lvbW11
OiBFbmFibGUgc3RhZ2UtMSB0cmFuc2xhdGlvbiBmb3INCj5wYXNzdGhyb3VnaCBkZXZpY2UNCj4N
Cj5PbiAyMDI1LzgvMjIgMTQ6NDAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gSGksDQo+Pg0K
Pj4gRm9yIHBhc3N0aHJvdWdoIGRldmljZSB3aXRoIGludGVsX2lvbW11LngtZmx0cz1vbiwgd2Ug
ZG9uJ3QgZG8gc2hhZG93aW5nDQo+b2YNCj4+IGd1ZXN0IHBhZ2UgdGFibGUgZm9yIHBhc3N0aHJv
dWdoIGRldmljZSBidXQgcGFzcyBzdGFnZS0xIHBhZ2UgdGFibGUgdG8gaG9zdA0KPj4gc2lkZSB0
byBjb25zdHJ1Y3QgYSBuZXN0ZWQgZG9tYWluLiBUaGVyZSB3YXMgc29tZSBlZmZvcnQgdG8gZW5h
YmxlIHRoaXMNCj5mZWF0dXJlDQo+PiBpbiBvbGQgZGF5cywgc2VlIFsxXSBmb3IgZGV0YWlscy4N
Cj4+DQo+PiBUaGUga2V5IGRlc2lnbiBpcyB0byB1dGlsaXplIHRoZSBkdWFsLXN0YWdlIElPTU1V
IHRyYW5zbGF0aW9uIChhbHNvIGtub3duIGFzDQo+PiBJT01NVSBuZXN0ZWQgdHJhbnNsYXRpb24p
IGNhcGFiaWxpdHkgaW4gaG9zdCBJT01NVS4gQXMgdGhlIGJlbG93DQo+ZGlhZ3JhbSBzaG93cywN
Cj4+IGd1ZXN0IEkvTyBwYWdlIHRhYmxlIHBvaW50ZXIgaW4gR1BBIChndWVzdCBwaHlzaWNhbCBh
ZGRyZXNzKSBpcyBwYXNzZWQgdG8NCj5ob3N0DQo+PiBhbmQgYmUgdXNlZCB0byBwZXJmb3JtIHRo
ZSBzdGFnZS0xIGFkZHJlc3MgdHJhbnNsYXRpb24uIEFsb25nIHdpdGggaXQsDQo+PiBtb2RpZmlj
YXRpb25zIHRvIHByZXNlbnQgbWFwcGluZ3MgaW4gdGhlIGd1ZXN0IEkvTyBwYWdlIHRhYmxlIHNo
b3VsZCBiZQ0KPmZvbGxvd2VkDQo+PiB3aXRoIGFuIElPVExCIGludmFsaWRhdGlvbi4NCj4+DQo+
PiAgICAgICAgICAuLS0tLS0tLS0tLS0tLS4gIC4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0u
DQo+PiAgICAgICAgICB8ICAgdklPTU1VICAgIHwgIHwgR3Vlc3QgSS9PIHBhZ2UgdGFibGUgICAg
ICB8DQo+PiAgICAgICAgICB8ICAgICAgICAgICAgIHwgICctLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0nDQo+PiAgICAgICAgICAuLS0tLS0tLS0tLS0tLS0tLS8NCj4+ICAgICAgICAgIHwgUEFT
SUQgRW50cnkgfC0tLSBQQVNJRCBjYWNoZSBmbHVzaCAtLSsNCj4+ICAgICAgICAgICctLS0tLS0t
LS0tLS0tJyAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4+ICAgICAgICAgIHwgICAgICAgICAg
ICAgfCAgICAgICAgICAgICAgICAgICAgICAgIFYNCj4+ICAgICAgICAgIHwgICAgICAgICAgICAg
fCAgICAgICAgICAgSS9PIHBhZ2UgdGFibGUgcG9pbnRlciBpbiBHUEENCj4+ICAgICAgICAgICct
LS0tLS0tLS0tLS0tJw0KPj4gICAgICBHdWVzdA0KPj4gICAgICAtLS0tLS18IFNoYWRvdyB8LS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tDQo+PiAgICAgICAgICAgIHYgICAgICAg
IHYgICAgICAgICAgICAgICAgICAgICAgICAgICB2DQo+PiAgICAgIEhvc3QNCj4+ICAgICAgICAg
IC4tLS0tLS0tLS0tLS0tLiAgLi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS4NCj4+ICAgICAgICAg
IHwgICBwSU9NTVUgICAgfCAgfCBTdGFnZTEgZm9yIEdJT1ZBLT5HUEEgIHwNCj4+ICAgICAgICAg
IHwgICAgICAgICAgICAgfCAgJy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLScNCj4+ICAgICAgICAg
IC4tLS0tLS0tLS0tLS0tLS0tLyAgfA0KPj4gICAgICAgICAgfCBQQVNJRCBFbnRyeSB8ICAgICBW
IChOZXN0ZWQgeGxhdGUpDQo+PiAgICAgICAgICAnLS0tLS0tLS0tLS0tLS0tLVwuLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0uDQo+PiAgICAgICAgICB8ICAgICAgICAgICAg
IHwgICB8IFN0YWdlMiBmb3IgR1BBLT5IUEEsIHVubWFuYWdlZA0KPmRvbWFpbnwNCj4+ICAgICAg
ICAgIHwgICAgICAgICAgICAgfCAgICctLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLScNCj4+ICAgICAgICAgICctLS0tLS0tLS0tLS0tJw0KPj4gRm9yIGhpc3RvcnkgcmVhc29u
LCB0aGVyZSBhcmUgZGlmZmVyZW50IG5hbWluZ3MgaW4gZGlmZmVyZW50IFZURCBzcGVjIHJldiwN
Cj4+IFdoZXJlOg0KPj4gICAtIFN0YWdlMSA9IEZpcnN0IHN0YWdlID0gRmlyc3QgbGV2ZWwgPSBm
bHRzDQo+PiAgIC0gU3RhZ2UyID0gU2Vjb25kIHN0YWdlID0gU2Vjb25kIGxldmVsID0gc2x0cw0K
Pj4gPEludGVsIFZULWQgTmVzdGVkIHRyYW5zbGF0aW9uPg0KPj4NCj4+IFRoaXMgc2VyaWVzIHJl
dXNlIFZGSU8gZGV2aWNlJ3MgZGVmYXVsdCBod3B0IGFzIG5lc3RlZCBwYXJlbnQgaW5zdGVhZCBv
Zg0KPj4gY3JlYXRpbmcgbmV3IG9uZS4gVGhpcyB3YXkgYXZvaWRzIGR1cGxpY2F0ZSBjb2RlIG9m
IGEgbmV3IG1lbW9yeQ0KPmxpc3RlbmVyLA0KPj4gYWxsIGV4aXN0aW5nIGZlYXR1cmUgZnJvbSBW
RklPIGxpc3RlbmVyIGNhbiBiZSBzaGFyZWQsIGUuZy4sIHJhbSBkaXNjYXJkLA0KPj4gZGlydHkg
dHJhY2tpbmcsIGV0Yy4gVHdvIGxpbWl0YXRpb25zIGFyZTogMSkgbm90IHN1cHBvcnRpbmcgVkZJ
TyBkZXZpY2UNCj4+IHVuZGVyIGEgUENJIGJyaWRnZSB3aXRoIGVtdWxhdGVkIGRldmljZSwgYmVj
YXVzZSBlbXVsYXRlZCBkZXZpY2Ugd2FudHMNCj4+IElPTU1VIEFTIGFuZCBWRklPIGRldmljZSBz
dGljayB0byBzeXN0ZW0gQVM7DQo+DQo+c2hvdWxkIHdlIGRvY3VtZW50IGl0IHNvbWV3aGVyZT8N
Cg0KU3VyZSwgZG9jcy9kZXZlbC92ZmlvLWlvbW11ZmQucnN0IG1heSBiZSBhIGdvb2QgcGxhY2Ug
Zm9yIHRoYXQuDQoNCj4NCj4+IDIpIG5vdCBzdXBwb3J0aW5nIGtleGVjIG9yDQo+PiByZWJvb3Qg
ZnJvbSAiaW50ZWxfaW9tbXU9b24sc21fb24iIHRvICJpbnRlbF9pb21tdT1vbixzbV9vZmYiLA0K
PmJlY2F1c2UNCj4+IFZGSU8gZGV2aWNlJ3MgZGVmYXVsdCBod3B0IGlzIGNyZWF0ZWQgd2l0aCBO
RVNUX1BBUkVOVCBmbGFnLCBrZXJuZWwNCj4+IGluaGliaXQgUk8gbWFwcGluZ3Mgd2hlbiBzd2l0
Y2ggdG8gc2hhZG93IG1vZGUuDQo+DQo+aG93IGRvZXMgZ3Vlc3Qga25vdyB0aGlzIGxpbWl0YXRp
b24gYW5kIGhvbGQgb24gc3VjaCBhdHRlbXB0cz8NCg0KTm8gd2F5IGZvciBndWVzdCB0byBrbm93
IEVSUkFUQSBpbiBob3N0IElPTU1VLg0KDQo+DQo+Pg0KPj4gVGhpcyBzZXJpZXMgaXMgYWxzbyBh
IHByZXJlcXVpc2l0ZSB3b3JrIGZvciB2U1ZBLCBpLmUuIFNoYXJpbmcgZ3Vlc3QNCj4+IGFwcGxp
Y2F0aW9uIGFkZHJlc3Mgc3BhY2Ugd2l0aCBwYXNzdGhyb3VnaCBkZXZpY2VzLg0KPj4NCj4+IFRo
ZXJlIGFyZSBzb21lIGludGVyYWN0aW9ucyBiZXR3ZWVuIFZGSU8gYW5kIHZJT01NVQ0KPj4gKiB2
SU9NTVUgcmVnaXN0ZXJzIFBDSUlPTU1VT3BzIFtzZXR8dW5zZXRdX2lvbW11X2RldmljZSB0byBQ
Q0kNCj4+ICAgIHN1YnN5c3RlbS4gVkZJTyBjYWxscyB0aGVtIHRvIHJlZ2lzdGVyL3VucmVnaXN0
ZXIgSG9zdElPTU1VRGV2aWNlDQo+PiAgICBpbnN0YW5jZSB0byB2SU9NTVUgYXQgdmZpbyBkZXZp
Y2UgcmVhbGl6ZSBzdGFnZS4NCj4+ICogdklPTU1VIHJlZ2lzdGVycyBQQ0lJT01NVU9wcyBnZXRf
dmlvbW11X2NhcCB0byBQQ0kgc3Vic3lzdGVtLg0KPj4gICAgVkZJTyBjYWxscyBpdCB0byBnZXQg
dklPTU1VIGV4cG9zZWQgY2FwYWJpbGl0aWVzLg0KPj4gKiB2SU9NTVUgY2FsbHMgSG9zdElPTU1V
RGV2aWNlSU9NTVVGRCBpbnRlcmZhY2UgW2F0fGRlXXRhY2hfaHdwdA0KPj4gICAgdG8gYmluZC91
bmJpbmQgZGV2aWNlIHRvIElPTU1VRkQgYmFja2VkIGRvbWFpbnMsIGVpdGhlciBuZXN0ZWQNCj4+
ICAgIGRvbWFpbiBvciBub3QuDQo+Pg0KPj4gU2VlIGJlbG93IGRpYWdyYW06DQo+Pg0KPj4gICAg
ICAgICAgVkZJTyBEZXZpY2UgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJbnRlbA0K
PklPTU1VDQo+PiAgICAgIC4tLS0tLS0tLS0tLS0tLS0tLS4gICAgICAgICAgICAgICAgICAgICAg
ICAgLi0tLS0tLS0tLS0tLS0tLS0tLS0uDQo+PiAgICAgIHwgICAgICAgICAgICAgICAgIHwgICAg
ICAgICAgICAgICAgICAgICAgICAgfA0KPnwNCj4+ICAgICAgfCAgICAgICAuLS0tLS0tLS0tfFBD
SUlPTU1VT3BzICAgICAgICAgICAgICB8Li0tLS0tLS0tLS0tLS0uDQo+fA0KPj4gICAgICB8ICAg
ICAgIHwgSU9NTVVGRCB8KHNldC91bnNldF9pb21tdV9kZXZpY2UpIHx8IEhvc3QgSU9NTVUNCj58
ICAgIHwNCj4+ICAgICAgfCAgICAgICB8IERldmljZSAgfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LT58fCBEZXZpY2UgbGlzdCB8ICAgIHwNCj4+ICAgICAgfCAgICAgICAuLS0tLS0tLS0tfChnZXRf
dmlvbW11X2NhcCkgICAgICAgICB8Li0tLS0tLS0tLS0tLS0uICAgIHwNCj4+ICAgICAgfCAgICAg
ICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgIHwNCj58DQo+PiAg
ICAgIHwgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICBW
DQo+fA0KPj4gICAgICB8ICAgICAgIC4tLS0tLS0tLS18ICBIb3N0SU9NTVVEZXZpY2VJT01NVUZE
IHwgIC4tLS0tLS0tLS0tLS0tLg0KPnwNCj4+ICAgICAgfCAgICAgICB8IElPTU1VRkQgfCAgICAg
ICAgICAgIChhdHRhY2hfaHdwdCl8ICB8IEhvc3QNCj5JT01NVSAgfCAgfA0KPj4gICAgICB8ICAg
ICAgIHwgbGluayAgICB8PC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwgIHwgICBEZXZpY2UgICAg
fCAgfA0KPj4gICAgICB8ICAgICAgIC4tLS0tLS0tLS18ICAgICAgICAgICAgKGRldGFjaF9od3B0
KXwgIC4tLS0tLS0tLS0tLS0tLiAgfA0KPj4gICAgICB8ICAgICAgICAgICAgICAgICB8ICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgICAgICAgfA0KPnwNCj4+ICAgICAgfCAgICAgICAgICAgICAg
ICAgfCAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgIC4uLg0KPnwNCj4+ICAgICAgLi0t
LS0tLS0tLS0tLS0tLS0tLiAgICAgICAgICAgICAgICAgICAgICAgICAuLS0tLS0tLS0tLS0tLS0t
LS0tLS4NCj4+DQo+PiBCZWxvdyBpcyBhbiBleGFtcGxlIHRvIGVuYWJsZSBzdGFnZS0xIHRyYW5z
bGF0aW9uIGZvciBwYXNzdGhyb3VnaCBkZXZpY2U6DQo+Pg0KPj4gICAgICAtTSBxMzUsLi4uDQo+
PiAgICAgIC1kZXZpY2UgaW50ZWwtaW9tbXUseC1zY2FsYWJsZS1tb2RlPW9uLHgtZmx0cz1vbi4u
Lg0KPj4gICAgICAtb2JqZWN0IGlvbW11ZmQsaWQ9aW9tbXVmZDAgLWRldmljZQ0KPnZmaW8tcGNp
LGlvbW11ZmQ9aW9tbXVmZDAsLi4uDQo+Pg0KPj4gVGVzdCBkb25lOg0KPj4gLSBWRklPIGRldmlj
ZXMgaG90cGx1Zy91bnBsdWcNCj4+IC0gZGlmZmVyZW50IFZGSU8gZGV2aWNlcyBsaW5rZWQgdG8g
ZGlmZmVyZW50IGlvbW11ZmRzDQo+PiAtIHZob3N0IG5ldCBkZXZpY2UgcGluZyB0ZXN0DQo+Pg0K
Pj4gUEFUQ0gxLTc6ICBTb21lIHByZXBhcmluZyB3b3JrDQo+PiBQQVRDSDgtOTogIENvbXBhdGli
aWxpdHkgY2hlY2sgYmV0d2VlbiB2SU9NTVUgYW5kIEhvc3QgSU9NTVUNCj4+IFBBVENIMTAtMTg6
SW1wbGVtZW50IHN0YWdlLTEgcGFnZSB0YWJsZSBmb3IgcGFzc3Rocm91Z2ggZGV2aWNlDQo+PiBQ
QVRDSDE5LTIwOldvcmthcm91bmQgZm9yIEVSUkFUQV83NzI0MTVfU1BSMTcNCj4+IFBBVENIMjE6
ICAgRW5hYmxlIHN0YWdlLTEgdHJhbnNsYXRpb24gZm9yIHBhc3N0aHJvdWdoIGRldmljZQ0KPj4N
Cj4+IFFlbXUgY29kZSBjYW4gYmUgZm91bmQgYXQgWzJdDQo+Pg0KPj4gRmF1bHQgcmVwb3J0IGlz
bid0IHN1cHBvcnRlZCBpbiB0aGlzIHNlcmllcywgd2UgcHJlc3VtZSBndWVzdCBrZXJuZWwgYWx3
YXlzDQo+PiBjb25zdHJ1Y3QgY29ycmVjdCBzdGFnZTEgcGFnZSB0YWJsZSBmb3IgcGFzc3Rocm91
Z2ggZGV2aWNlLiBGb3IgZW11bGF0ZWQNCj4+IGRldmljZXMsIHRoZSBlbXVsYXRpb24gY29kZSBh
bHJlYWR5IHByb3ZpZGVkIHN0YWdlMSBmYXVsdCBpbmplY3Rpb24uDQo+DQo+anVzdCBjYWxsIG91
dCB0aGlzIHNlcmllcyBpcyBvbmx5IGxpbWl0ZWQgdG8gZ0lPVkEgdXNhZ2Ugc28gZmFyLiB2U1ZB
IGlzDQo+bGF0ZXIuIDopDQoNCldpbGwgZG8uDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

