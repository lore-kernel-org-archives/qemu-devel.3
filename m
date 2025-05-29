Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E8AC54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 06:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKX5y-0004L8-2a; Thu, 29 May 2025 02:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uKX5x-0004Ke-1J
 for qemu-devel@nongnu.org; Thu, 29 May 2025 02:50:29 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uKX5u-0001ch-Lz
 for qemu-devel@nongnu.org; Thu, 29 May 2025 02:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748501426; x=1780037426;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jKGavHOLwOkmWZ0RZ8rqjVSjX4FvkPxixUUodrg4fHs=;
 b=LIeBCwLKO6gAWHSJcd/SvvThHMuuqpyb4q5Nv5Z43EyVJ8gy7PG0vhru
 zlseM9hfE5nGBAZhYMckXm3p7RIuwqmZeoL2l7DBQJcH1SFTwz0CK4FmA
 0n+JbXX/YGzNaqmW7AwuZfpkUzHhw/d4DZcmpr0L9AX56HPmXaPhZjEwG
 FjSkTo7NBqeXxxBFdRifokm2QBs2yDwc5ZtFu+KMdd+b8LO4LviNUonAW
 xWtcjArxjAZTnS++tBgs5x9uRJ9jQtdgzTfhvPPP4GR/oP4xf/3Nmfr6Q
 LsRAjwQ8mEgUMFyJxmm6fOwwENtYFv4VuO8VTZBs6MN3hyaltWtsPeeD3 w==;
X-CSE-ConnectionGUID: +wXCmvqJTu6NjxFMSaeigw==
X-CSE-MsgGUID: 93qbpLKxR2qsdWOu9TekvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="73079961"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="73079961"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2025 23:50:22 -0700
X-CSE-ConnectionGUID: isvO71AsQ6qPoOK0xS8MDA==
X-CSE-MsgGUID: 6i+NOcn1SYCdyRqIXWfiJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="148756748"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2025 23:50:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 23:50:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 23:50:22 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.68) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 23:50:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOX8UjHGh41Y+1zlnwu+oTpEVK9xe7+77Qe4gXTTvNx3w+YaUrpSm9b/DBaSRVnH80CK5GJUFVIFGd2k7iVGJrIVrmxzUyrdexAkOViLAWHtgIk95bE6L0kcGi82UyNU3D5mJd2l+FmWvRr6E7rvhOBmm8SS9k+V+Zfg2G86uL5SuEDis6QYLUXhxrtLqMSGKepD7pv5G/3A4YHHoCUNdwogFuA14+Z2FAXZCjKcfdKklbBqIpdszzpPb90kZGA9sUeTYHJiEZ7TIqT7lK2TbgSAOBchQkAUMFNqsb+SHVu9PgZO7opqLI7rGi8iYlv2s+ZZ6KXVla8eIn/Y4lTXYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKGavHOLwOkmWZ0RZ8rqjVSjX4FvkPxixUUodrg4fHs=;
 b=cBZCIqTHWmxkLS4/v1wvia8W7LB+Pvbji9m4bL7EX0Z7dfKF4UT7Mr97bHky/N5/xe74rpbnwHs5fTNxayZ14tm+2rkw81xuMs65AJKd8mpagZvLfEYNE7iIoFqwZJgB5npFDR53FLL3APJ1UCDX/ZcSQ2oMPZVKsYKtE/+uFj1oT8FYPGV0MN4JoQy8x42GfYuUgsu6oFOb51cXj1TWZhGJnGD9QM8dLHgr14YZqJ+jI3DbSjcjP/JgOKU6adpCp0dxe5APhJVrzdQhzWhgEXWkDm6kxRjIplViqdbnUsiFKv9noWfWBy1veOPAB0sJfoLdtufKbINaszh5286Gig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB5819.namprd11.prod.outlook.com (2603:10b6:510:13b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 29 May
 2025 06:50:18 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8769.021; Thu, 29 May 2025
 06:50:18 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v1 2/6] vfio/iommufd: Add properties and handlers to
 TYPE_HOST_IOMMU_DEVICE_IOMMUFD
Thread-Topic: [PATCH v1 2/6] vfio/iommufd: Add properties and handlers to
 TYPE_HOST_IOMMU_DEVICE_IOMMUFD
Thread-Index: AQHbz5bumnz2i6ZYoU+ebC16sn2lsrPn13yAgAFVEzA=
Date: Thu, 29 May 2025 06:50:18 +0000
Message-ID: <SJ0PR11MB67449BB59A237E075D1DDD359266A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250528060409.3710008-1-zhenzhong.duan@intel.com>
 <20250528060409.3710008-3-zhenzhong.duan@intel.com>
 <d4d0a5b8-1d4a-4c17-8267-8bb362d89772@redhat.com>
In-Reply-To: <d4d0a5b8-1d4a-4c17-8267-8bb362d89772@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB5819:EE_
x-ms-office365-filtering-correlation-id: f3559152-b29d-4e7f-9da3-08dd9e7d12da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?UzE3eTUvdGhtUW5ndDFpSUZnNDlYYnpoMjkrOHZPV3BwSDRYeHJ5NjYrdEZW?=
 =?utf-8?B?SHNGL3l0aUhGV3dJTDU4ajJSMmhFR1Z5czViTVZybXAwTHJMaGZUZU5wWUg4?=
 =?utf-8?B?dk1qWm5oMVovNnRrM0t0NjMzMHlReTUvWjRPL2E1VGVqOUV2ckJxZjFiRFIv?=
 =?utf-8?B?cHV1bUExTG5CU1pZU0tuRGNyUlk2UW5JejkyTjBjajVIVjdzbEdDcG9UYThp?=
 =?utf-8?B?bTA5K0RuUWhwdHZlVmNiTDFBcFFhVmJWSERFRDE1S1JGNmluLzkzOVhRMnNL?=
 =?utf-8?B?ejhDRVhLNlh2ZlRhbXRCTWdYSVNGajF6RG1UT3FCM2ZSZnh3RWFsTUpqUVg4?=
 =?utf-8?B?WmFrZlZ5UGJBY293WHZsaWxXQzRYak02UWtRMGs2TndrZXcxZ25XNjZKaFI4?=
 =?utf-8?B?SjFxR0g3OTFyTVdTbGFVdUxDOHFVN0ZOckNhQnozOUtwWHpxNER5ZzhxSUJ1?=
 =?utf-8?B?VDBDaDgxMGNlY3lnOFVQdEF0bDc5WXJvdGVKU3NNMUMvQ3ZXRkwvQUM5YjNM?=
 =?utf-8?B?amRzbHNHa3UzWm81bTZsS0FZanI3aDJJYTlwN0c2WU81VnBQdUJkYWovUE1o?=
 =?utf-8?B?S1VEaXF2U0VYYzdUMFJ3L1BLSjlVOVhhdFFWeHY3QmJESkFaMWtMbUF3aDRt?=
 =?utf-8?B?czBpWFJHaDFTcFBjWGZVS3JnaW5zdWxVeExZd2w1VVl0MzNwUHhNRllMa0V4?=
 =?utf-8?B?UllCVHJnV05aUnRxWGxaTTNSMitLVDFYNy8xdlpJUitQUEhsUE92ejgrUERP?=
 =?utf-8?B?ZkxJVU1pNVk2SWRCZytJazFSUTJsQWphbXpHVHpUUGZwbDZ3VWRUcVUvaGlV?=
 =?utf-8?B?V0hvZkxkR1VrKzFGSEpNQWhydzYzanVrVm5lcDZQNU9lenR2THhzQ29ZY1VS?=
 =?utf-8?B?OWh1QUc0UW9KRmZiaDVFMzljZEx6RS9FU3JaTDgvVWlwRE9mL2NjM3dIWUxN?=
 =?utf-8?B?eW5jSHZUS0psaUJGTWQ3ODZ5OGlMd2hTMGswS2dBWnp5ckJDZURDZ1ZGT1M4?=
 =?utf-8?B?OFhyWktobzZWZVlqWjJyZVpmd3BpUDlyRUFGRXhvY3JhVWxhZ0Nld28wOHUy?=
 =?utf-8?B?L3RVMXE0SWJlOS9QWmF6QkJTZ1gvQ0dUbEE3VHpCYTlMeGFJU1hxRC8xRXBM?=
 =?utf-8?B?alVTUkUzREFFZEM3V21XZXZGMzNMa2dxYk1aZjVqWmxmMWRrRzJGZTRYcXNB?=
 =?utf-8?B?MzVpN1lXRk9qVHRHcXo5Z2JrdXZ6OXBSSnJwcG85NmIzZ2pKdHdHQ2dTeEFR?=
 =?utf-8?B?bTRpS01FcHhSQThnWFRhNTZYMWFqRHlnbFJxb1J5N2JEbmU1dUwwejg1T3RU?=
 =?utf-8?B?M0dOZE5nUHVnVEgzeVRtajdxL2xOZmErWVFHd2l2c0YxbUQ2NEdURjZTek8w?=
 =?utf-8?B?SmkxbndtZkcwT0ZUbms1VG1hck9PU0pNREVHL3VPbkFYdVlpQnJLeUp4dnhl?=
 =?utf-8?B?WStVc2RTdFRRKzBIcVJka0VVVFJydlR2U3VZOEJweXZpY1hGaXRPSFVPcWpu?=
 =?utf-8?B?VWU2VE1rK0ZZaWdyWUJna3ZyY0doR2tMU2tPTForalZ3NXNDdjBBUTliRTAw?=
 =?utf-8?B?d1R1N3VueTJHZ29yT3FZT3AyeGsycktKaU45azQ4ZHo5MGdLdGJYUjBoU2V4?=
 =?utf-8?B?NWJkVmlOSUhQSXplRzlieGtqZTlWUlRaNWJZL3pRd2xyMCtQUTN0bDVFU1lj?=
 =?utf-8?B?a2pXd2kyM0JtNURYSUVIdS83VkNYL3RTVUY2VmxDRG9xTWIwbUlXUGp0VFZ0?=
 =?utf-8?B?cy9keEdKaWhPZzVza0NMaHFtSXdJQTQyd3E2c3BHaC9SanZNK3hhZHRLZWpV?=
 =?utf-8?B?eFVSSHVsL0psTy8zd0xXU1NWcDJNME5DYU9Gb2JHSnRwN04yQjhCRGxLdmo2?=
 =?utf-8?B?MEZUZmJjM0xrdlVBSjlXMWlRSnpObGdiaHVFbUdNaDE5V0xESEJ5ZjBpMGw2?=
 =?utf-8?B?eVM4SzVjKzFNdkE2VU5kNWtWR1MzbW1nbjNCNmtxazlBVVZqV2MxRmR6VVp4?=
 =?utf-8?Q?5XP2bJSYKQhXmivDGqUcGiXK2WcvTA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnlORUUwTnROaGhUVkJINUMzYnFkd2NYQnJPTk9GM3FuYkFJSU1hWE1OVzNB?=
 =?utf-8?B?S3VGZ2pjVTJQaktQemNxREs2RitpQTVZbmI3OHRVS2FDc3lmTFQ2d1dsbHhw?=
 =?utf-8?B?V1JyQ2daK3Fub1JXcTBjcWFJbnhGTlBqcjFuajZzVThoSkNOUWwreWllUE9m?=
 =?utf-8?B?eHZia3dGbUZmQTRsQy8zZXdJVHAxOWJOQWlubVRMdDJlaXNoMDR4NnkvVXcy?=
 =?utf-8?B?K1RESG1Ybml0TmdXVi9SYnlBRlZscXZvbHdwbEt3UytOcDhoTUFkRXB0ckdz?=
 =?utf-8?B?YU9TYzNLMkNuTWJUOFNKcnRaZTR6OFhRM0ttWmxIR0hSbXBUeDV4YVN0SXhU?=
 =?utf-8?B?SVN6TXQ2emc5UFVTM1NZeEMyR0hIQTYzNi9LQ01aK2dFd3QwYVRlalFFblhV?=
 =?utf-8?B?N3NXN1M3ZnlGVVRWM1pUSE5ZU3dzOXJSTjd2em1yT0hvU0RLYzNJbFFDV3JY?=
 =?utf-8?B?cDJxUE55c3Y4R3pVOThxVFV0Q0M0YjNUVDFZWSsyMWM1RDdVeFRDQUgzL2JP?=
 =?utf-8?B?RVdsMGN6VUpqZk5maE5DaWFaUUxXdWQyY05QZStkVUdyb2Z5Sk1adzdHMUZv?=
 =?utf-8?B?N0tYS25NMzkwOEphcFNTMkVsdm8xbmNTbE90S1JWRmJYL0FXNEdRcGtKZEph?=
 =?utf-8?B?blpjMEgzRGtBYVRXaDdWbEJwdW1wR0cyNy9BbjRLQnBzTjcrNzhkTGx1ZEs5?=
 =?utf-8?B?QnIvbmJSdzFqYXhxQ1k0RW85VkorQjZIc2NHRWNZaUdjZ3lHY1ArVkM4b29y?=
 =?utf-8?B?TU9wU1lQMGI3bGJBbTZ4Wkc2OHY3NC9rRE9ZUHdFN1k2eWV6dlBBVWtISy9k?=
 =?utf-8?B?Y1lhcG9ER01NZE5FVDlFUFloTk00R0xwU3ByQnNWZUt4RmxHRHBoZlF4dVdK?=
 =?utf-8?B?R3M4Y2YwVjQ1TDduS1hNaTFrdmMvcU02QWw3OUpMcURnWmFCQU5scTNienNx?=
 =?utf-8?B?OXdGSmdCMEVtaU9EY292Ukl1dnlVL0ZVbmdPUWxUdDZiWFVFcHYzaGFPdTRx?=
 =?utf-8?B?Y3J1OU9wZnNyVHV4L1cyVFhwVUhlbmlEQlpzb3R4WUVPMzI0VFBFbkl0WnBz?=
 =?utf-8?B?dXRLZ0FOWmg4TmpyODNOdGVXeWVVL0hHMWQ2ZSttdE1xWFo5cThIaTZleFJW?=
 =?utf-8?B?WmRlNlRjZFk4b0FISU1tSkJqK2ZTZGppajdGeUk3MVpwZ3N1cUQxQVVDbnY5?=
 =?utf-8?B?d3RXUXRMdUxZVmgrNkY5REcraGtMRTdjRHloNk5sYjlCNnJQL3RBd3VHWEM5?=
 =?utf-8?B?eDVBZjB0d2ZOWGdSSW5hQ2dGNHRBd3MyQ3BVSWRhdmNYbnB6MG5NNTlCU0Vl?=
 =?utf-8?B?ZW9nNTJmZ0JhT1poTEZWNytTSjZYaitBRjhRUDBiLy9UTjBIY0JWMnFHckVR?=
 =?utf-8?B?bGQyYmc0dU1FMHdPVGg5bEsvVFRXaUJoVHRFRUlVQlk4ZFVZS2kwdG1RODk4?=
 =?utf-8?B?M25mVG4yU2VLTW5NQXo5cnp2Y3dWcmpGWXFtYmJ5SFFvTkVNTTZzbDVPNHhK?=
 =?utf-8?B?R2gyZSt1V3lmdkZGUVZxTHI2UUVCc0lVRWdkUWN5NnpmZzVoS3NYVlVNSGVB?=
 =?utf-8?B?MWJGUWNtOXlOZ1F2WEpBTHRDNVRwZnV6Q1RzS2tEdlU3OVF3QXByUHlZeWVJ?=
 =?utf-8?B?NWwvN1pTR1N3dC9veWd0L2MrSGxtaWk5VnFmRkJ3M21GeU5hQlRlREZ0M2NJ?=
 =?utf-8?B?NzZrMlZ4eVV0OXlZNFVWVW1xVEdzbjIrTkVKM2d3a0s2QWtmSWxRNGJ1WjdB?=
 =?utf-8?B?K1ZIUEhaSWVCai91Umg0SVBPMTRJbUpJTS9HazJyN1pRbUY4ODFLL292aFdM?=
 =?utf-8?B?YkM2Nk0wdHBseXJMait6U25UcWRUamc5QmRGQ011U3F5b0h0V05NUkVpZ2N5?=
 =?utf-8?B?YzZGdTNkWmVUczJadDJtQjlwVVB4VDV3M0lQaEV0dHB5Ym9GeTlCUzhGSFVS?=
 =?utf-8?B?c2hEZzVPelRLVUw2dnZTQlZvR2NoT1RBZTM3VGd3OWpJZ3g0c3NNQ1gxUnh2?=
 =?utf-8?B?K0w3NjZ6OWlHK0tqSHIreFltMFZpYWE1M3oxWlBIRW9qWlNqRU5yVGpXV1ov?=
 =?utf-8?B?d21tdG0wNTFKdXhrT3lrYzM1MG5kWEF0bFFWMHc3cnF2clVFSGxWN2VJditC?=
 =?utf-8?Q?ZGTQHxn8QWPVFt2TpHSVfUgzl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3559152-b29d-4e7f-9da3-08dd9e7d12da
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 06:50:18.0286 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EHPGp5R6RjQ63aw6bs76GPSclVtECT2mohOR8h2H5TISka0bUWBX0WhHCr3OiM52xNtKX7A68rvdwg3LoQWKpn7U8vTtWtYRbH5OV+1SJxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5819
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYxIDIvNl0gdmZpby9pb21t
dWZkOiBBZGQgcHJvcGVydGllcyBhbmQgaGFuZGxlcnMgdG8NCj5UWVBFX0hPU1RfSU9NTVVfREVW
SUNFX0lPTU1VRkQNCj4NCj5PbiA1LzI4LzI1IDA4OjA0LCBaaGVuemhvbmcgRHVhbiB3cm90ZToN
Cj4+IEVuaGFuY2UgSG9zdElPTU1VRGV2aWNlSU9NTVVGRCBvYmplY3Qgd2l0aCAzIG5ldyBtZW1i
ZXJzLCBzcGVjaWZpYw0KPj4gdG8gdGhlIGlvbW11ZmQgQkUgKyAyIG5ldyBjbGFzcyBmdW5jdGlv
bnMuDQo+Pg0KPj4gSU9NTVVGRCBCRSBpbmNsdWRlcyBJT01NVUZEIGhhbmRsZSwgZGV2aWQgYW5k
IGh3cHRfaWQuIElPTU1VRkQgaGFuZGxlDQo+PiBhbmQgZGV2aWQgYXJlIHVzZWQgdG8gYWxsb2Nh
dGUvZnJlZSBpb2FzIGFuZCBod3B0LiBod3B0X2lkIGlzIHVzZWQgdG8NCj4+IHJlLWF0dGFjaCBJ
T01NVUZEIGJhY2tlZCBkZXZpY2UgdG8gaXRzIGRlZmF1bHQgVkZJTyBzdWItc3lzdGVtIGNyZWF0
ZWQNCj4+IGh3cHQsIGkuZS4sIHdoZW4gdklPTU1VIGlzIGRpc2FibGVkIGJ5IGd1ZXN0LiBUaGVz
ZSBwcm9wZXJ0aWVzIHdpbGwgYmUNCj4+IGluaXRpYWxpemVkIGFmdGVyIGF0dGFjaG1lbnQuDQo+
Pg0KPj4gMiBuZXcgY2xhc3MgZnVuY3Rpb25zIGFyZSBbYXR8ZGVddGFjaF9od3B0KCkuIFRoZXkg
YXJlIHVzZWQgdG8NCj4+IGF0dGFjaC9kZXRhY2ggaHdwdC4gVkZJTyBhbmQgVkRQQSBjYW4gaGF2
ZSBkaWZmZXJlbnQgaW1wbGVtZW50aW9ucywNCj4+IHNvIGltcGxlbWVudGF0aW9uIHdpbGwgYmUg
aW4gc3ViLWNsYXNzIGluc3RlYWQgb2YgSG9zdElPTU1VRGV2aWNlSU9NTVVGRCwNCj4+IGUuZy4s
IGluIEhvc3RJT01NVURldmljZUlPTU1VRkRWRklPLg0KPj4NCj4+IEFkZCB0d28gd3JhcHBlcnMg
aG9zdF9pb21tdV9kZXZpY2VfaW9tbXVmZF9bYXR8ZGVddGFjaF9od3B0IHRvDQo+PiB3cmFwIHRo
ZSB0d28gZnVuY3Rpb25zLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6
aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICAgaW5jbHVkZS9zeXN0ZW0vaW9t
bXVmZC5oIHwgNTANCj4rKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
PiAgIGJhY2tlbmRzL2lvbW11ZmQuYyAgICAgICB8IDIyICsrKysrKysrKysrKysrKysrKw0KPj4g
ICAyIGZpbGVzIGNoYW5nZWQsIDcyIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9zeXN0ZW0vaW9tbXVmZC5oIGIvaW5jbHVkZS9zeXN0ZW0vaW9tbXVmZC5oDQo+PiBp
bmRleCA1Mzk5NTE5NjI2Li5hNzA0NTc1NjYyIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9zeXN0
ZW0vaW9tbXVmZC5oDQo+PiArKysgYi9pbmNsdWRlL3N5c3RlbS9pb21tdWZkLmgNCj4+IEBAIC02
Nyw0ICs2Nyw1NCBAQCBib29sDQo+aW9tbXVmZF9iYWNrZW5kX2ludmFsaWRhdGVfY2FjaGUoSU9N
TVVGREJhY2tlbmQgKmJlLCB1aW50MzJfdCBpZCwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApOw0KPj4NCj4+ICAgI2RlZmluZSBUWVBFX0hP
U1RfSU9NTVVfREVWSUNFX0lPTU1VRkQNCj5UWVBFX0hPU1RfSU9NTVVfREVWSUNFICItaW9tbXVm
ZCINCj4+ICtPQkpFQ1RfREVDTEFSRV9UWVBFKEhvc3RJT01NVURldmljZUlPTU1VRkQsDQo+SG9z
dElPTU1VRGV2aWNlSU9NTVVGRENsYXNzLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgSE9TVF9J
T01NVV9ERVZJQ0VfSU9NTVVGRCkNCj4+ICsNCj4+ICsvKiBPdmVybG9hZCBvZiB0aGUgaG9zdCBJ
T01NVSBkZXZpY2UgZm9yIHRoZSBpb21tdWZkIGJhY2tlbmQgKi8NCj4+ICtzdHJ1Y3QgSG9zdElP
TU1VRGV2aWNlSU9NTVVGRCB7DQo+PiArICAgIEhvc3RJT01NVURldmljZSBwYXJlbnRfb2JqOw0K
Pj4gKw0KPj4gKyAgICBJT01NVUZEQmFja2VuZCAqaW9tbXVmZDsNCj4+ICsgICAgdWludDMyX3Qg
ZGV2aWQ7DQo+PiArICAgIHVpbnQzMl90IGh3cHRfaWQ7DQo+PiArfTsNCj4NCj50aGUgYWRkaXRp
b24gb2YgbmV3IGF0dHJpYnV0ZXMgd291bGQgYmUgYmV0dGVyIHBsYWNlZCBpbiB0aGUgbmV4dCBw
YXRjaC4NCg0KT0ssIHdpbGwgbWVyZ2UgdGhpcyBwYXRjaCB3aXRoIHRoZSBuZXh0IHBhdGNoLg0K
DQpUaGFua3MNClpoZW56aG9uZw0KDQo+DQo+QW55aG93LA0KPg0KPg0KPg0KPlJldmlld2VkLWJ5
OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+DQo+VGhhbmtzLA0KPg0KPkMu
DQo+DQo+DQo+DQo+PiArc3RydWN0IEhvc3RJT01NVURldmljZUlPTU1VRkRDbGFzcyB7DQo+PiAr
ICAgIEhvc3RJT01NVURldmljZUNsYXNzIHBhcmVudF9jbGFzczsNCj4+ICsNCj4+ICsgICAgLyoq
DQo+PiArICAgICAqIEBhdHRhY2hfaHdwdDogYXR0YWNoIGhvc3QgSU9NTVUgZGV2aWNlIHRvIElP
TU1VRkQgaGFyZHdhcmUgcGFnZQ0KPnRhYmxlLg0KPj4gKyAgICAgKiBWRklPIGFuZCBWRFBBIGRl
dmljZSBjYW4gaGF2ZSBkaWZmZXJlbnQgaW1wbGVtZW50YXRpb24uDQo+PiArICAgICAqDQo+PiAr
ICAgICAqIE1hbmRhdG9yeSBjYWxsYmFjay4NCj4+ICsgICAgICoNCj4+ICsgICAgICogQGlkZXY6
IGhvc3QgSU9NTVUgZGV2aWNlIGJhY2tlZCBieSBJT01NVUZEIGJhY2tlbmQuDQo+PiArICAgICAq
DQo+PiArICAgICAqIEBod3B0X2lkOiBJRCBvZiBJT01NVUZEIGhhcmR3YXJlIHBhZ2UgdGFibGUu
DQo+PiArICAgICAqDQo+PiArICAgICAqIEBlcnJwOiBwYXNzIGFuIEVycm9yIG91dCB3aGVuIGF0
dGFjaG1lbnQgZmFpbHMuDQo+PiArICAgICAqDQo+PiArICAgICAqIFJldHVybnM6IHRydWUgb24g
c3VjY2VzcywgZmFsc2Ugb24gZmFpbHVyZS4NCj4+ICsgICAgICovDQo+PiArICAgIGJvb2wgKCph
dHRhY2hfaHdwdCkoSG9zdElPTU1VRGV2aWNlSU9NTVVGRCAqaWRldiwgdWludDMyX3QgaHdwdF9p
ZCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApOw0KPj4gKyAgICAv
KioNCj4+ICsgICAgICogQGRldGFjaF9od3B0OiBkZXRhY2ggaG9zdCBJT01NVSBkZXZpY2UgZnJv
bSBJT01NVUZEIGhhcmR3YXJlDQo+cGFnZSB0YWJsZS4NCj4+ICsgICAgICogVkZJTyBhbmQgVkRQ
QSBkZXZpY2UgY2FuIGhhdmUgZGlmZmVyZW50IGltcGxlbWVudGF0aW9uLg0KPj4gKyAgICAgKg0K
Pj4gKyAgICAgKiBNYW5kYXRvcnkgY2FsbGJhY2suDQo+PiArICAgICAqDQo+PiArICAgICAqIEBp
ZGV2OiBob3N0IElPTU1VIGRldmljZSBiYWNrZWQgYnkgSU9NTVVGRCBiYWNrZW5kLg0KPj4gKyAg
ICAgKg0KPj4gKyAgICAgKiBAZXJycDogcGFzcyBhbiBFcnJvciBvdXQgd2hlbiBhdHRhY2htZW50
IGZhaWxzLg0KPj4gKyAgICAgKg0KPj4gKyAgICAgKiBSZXR1cm5zOiB0cnVlIG9uIHN1Y2Nlc3Ms
IGZhbHNlIG9uIGZhaWx1cmUuDQo+PiArICAgICAqLw0KPj4gKyAgICBib29sICgqZGV0YWNoX2h3
cHQpKEhvc3RJT01NVURldmljZUlPTU1VRkQgKmlkZXYsIEVycm9yICoqZXJycCk7DQo+PiArfTsN
Cj4+ICsNCj4+ICtib29sDQo+aG9zdF9pb21tdV9kZXZpY2VfaW9tbXVmZF9hdHRhY2hfaHdwdChI
b3N0SU9NTVVEZXZpY2VJT01NVUZEICppZGV2LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBod3B0X2lkLCBFcnJvciAqKmVycnApOw0KPj4g
K2Jvb2wNCj5ob3N0X2lvbW11X2RldmljZV9pb21tdWZkX2RldGFjaF9od3B0KEhvc3RJT01NVURl
dmljZUlPTU1VRkQgKmlkZXYsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIEVycm9yICoqZXJycCk7DQo+PiAgICNlbmRpZg0KPj4gZGlmZiAtLWdpdCBhL2Jh
Y2tlbmRzL2lvbW11ZmQuYyBiL2JhY2tlbmRzL2lvbW11ZmQuYw0KPj4gaW5kZXggYzg3ODhhNjQz
OC4uYjExNGZiMDhlNyAxMDA2NDQNCj4+IC0tLSBhL2JhY2tlbmRzL2lvbW11ZmQuYw0KPj4gKysr
IGIvYmFja2VuZHMvaW9tbXVmZC5jDQo+PiBAQCAtMzQ0LDYgKzM0NCwyNiBAQCBib29sDQo+aW9t
bXVmZF9iYWNrZW5kX2ludmFsaWRhdGVfY2FjaGUoSU9NTVVGREJhY2tlbmQgKmJlLCB1aW50MzJf
dCBpZCwNCj4+ICAgICAgIHJldHVybiAhcmV0Ow0KPj4gICB9DQo+Pg0KPj4gK2Jvb2wNCj5ob3N0
X2lvbW11X2RldmljZV9pb21tdWZkX2F0dGFjaF9od3B0KEhvc3RJT01NVURldmljZUlPTU1VRkQg
KmlkZXYsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVp
bnQzMl90IGh3cHRfaWQsIEVycm9yICoqZXJycCkNCj4+ICt7DQo+PiArICAgIEhvc3RJT01NVURl
dmljZUlPTU1VRkRDbGFzcyAqaWRldmMgPQ0KPj4gKyAgICAgICAgSE9TVF9JT01NVV9ERVZJQ0Vf
SU9NTVVGRF9HRVRfQ0xBU1MoaWRldik7DQo+PiArDQo+PiArICAgIGdfYXNzZXJ0KGlkZXZjLT5h
dHRhY2hfaHdwdCk7DQo+PiArICAgIHJldHVybiBpZGV2Yy0+YXR0YWNoX2h3cHQoaWRldiwgaHdw
dF9pZCwgZXJycCk7DQo+PiArfQ0KPj4gKw0KPj4gK2Jvb2wNCj5ob3N0X2lvbW11X2RldmljZV9p
b21tdWZkX2RldGFjaF9od3B0KEhvc3RJT01NVURldmljZUlPTU1VRkQgKmlkZXYsDQo+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCj4+
ICt7DQo+PiArICAgIEhvc3RJT01NVURldmljZUlPTU1VRkRDbGFzcyAqaWRldmMgPQ0KPj4gKyAg
ICAgICAgSE9TVF9JT01NVV9ERVZJQ0VfSU9NTVVGRF9HRVRfQ0xBU1MoaWRldik7DQo+PiArDQo+
PiArICAgIGdfYXNzZXJ0KGlkZXZjLT5kZXRhY2hfaHdwdCk7DQo+PiArICAgIHJldHVybiBpZGV2
Yy0+ZGV0YWNoX2h3cHQoaWRldiwgZXJycCk7DQo+PiArfQ0KPj4gKw0KPj4gICBzdGF0aWMgaW50
IGhpb2RfaW9tbXVmZF9nZXRfY2FwKEhvc3RJT01NVURldmljZSAqaGlvZCwgaW50IGNhcCwgRXJy
b3INCj4qKmVycnApDQo+PiAgIHsNCj4+ICAgICAgIEhvc3RJT01NVURldmljZUNhcHMgKmNhcHMg
PSAmaGlvZC0+Y2FwczsNCj4+IEBAIC0zODIsNiArNDAyLDggQEAgc3RhdGljIGNvbnN0IFR5cGVJ
bmZvIHR5cGVzW10gPSB7DQo+PiAgICAgICB9LCB7DQo+PiAgICAgICAgICAgLm5hbWUgPSBUWVBF
X0hPU1RfSU9NTVVfREVWSUNFX0lPTU1VRkQsDQo+PiAgICAgICAgICAgLnBhcmVudCA9IFRZUEVf
SE9TVF9JT01NVV9ERVZJQ0UsDQo+PiArICAgICAgICAuaW5zdGFuY2Vfc2l6ZSA9IHNpemVvZihI
b3N0SU9NTVVEZXZpY2VJT01NVUZEKSwNCj4+ICsgICAgICAgIC5jbGFzc19zaXplID0gc2l6ZW9m
KEhvc3RJT01NVURldmljZUlPTU1VRkRDbGFzcyksDQo+PiAgICAgICAgICAgLmNsYXNzX2luaXQg
PSBoaW9kX2lvbW11ZmRfY2xhc3NfaW5pdCwNCj4+ICAgICAgICAgICAuYWJzdHJhY3QgPSB0cnVl
LA0KPj4gICAgICAgfQ0KDQo=

