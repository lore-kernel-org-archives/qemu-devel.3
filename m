Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C868C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9e2K-0006x0-FK; Tue, 29 Apr 2025 02:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u9e29-0006qa-Kf
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:01:35 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u9e25-0004Fm-SH
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745906490; x=1777442490;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=i7Q8+meBdvi1LoCTt2UZF04tldwHcsru7Z/2cjNomZU=;
 b=OEB2VuD7erQfq0HebLZRhbG9ZjH6Amev43d9dYqy2yb8JX/rhs/iutQI
 tBtYcxOE8MXsgPL3Y9x5jK5s6iCHLVJkxwrzfZq7PXq2hgdWDMbY+Tqtb
 ARmkN6HkuRok5B811M/ZaL8Gu2ziqUageh0AaOzZVFXqLog29LlbMFGhP
 Teuzq7s4764d7YkEKwm/usP6bCjbAYLDVotSrshjMvN8bLvQQO74RL67l
 58RpQmR6eeok2NGd0HloR0NHR7MHhugGJME4tEi9kXFCAm0cXWWW2/DgT
 0TIk/gRCkOHCF+W0z0e/LN+VCQHrULhBcgH8XgM8hM1ze06WaIL9gzIOU g==;
X-CSE-ConnectionGUID: u7GCpZAnT0+Gi8l8PeCAeQ==
X-CSE-MsgGUID: 9NmQ5V5FRiaxHYFJzmUp/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="47424332"
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="47424332"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 23:01:28 -0700
X-CSE-ConnectionGUID: bMWDz+BFTj2Oi82FhP975g==
X-CSE-MsgGUID: rjA2E94rRCCXeprZRPbLmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="133450678"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 23:01:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 28 Apr 2025 23:01:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 28 Apr 2025 23:01:27 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 28 Apr 2025 23:01:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F035boI5FJD+QEBy3AxWgLxTi/30Gim3AtwfkiyDv7gTXx+97p4+ODLeJFKnk+7QfckM9CAUWc3ENAaBJ/3amnjiP6CqSaZCKNU1u6KqtvOut91wNFszUZmD8wtDpd7/bbRIT3kUHcJoC4/r65IofAo4LHffTE4cG98mLSDVD7ChY4s/8I7rVHAAGky0BuIkclF0XKHhaKhmrjlGTxodycpAmgFKjOogYEbSkrfQz44XxThTUKNK4OVI7c5+V/TZ9aOwV9SH3eJVAR1JGh+TqWzFtPsB2thmGf9ulqKOHoExFDmLFti0QNcc91DDRvf5p/4Uwu9EjygFOosifU8l6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7Q8+meBdvi1LoCTt2UZF04tldwHcsru7Z/2cjNomZU=;
 b=s+kKCO2idfzVME+e7bBFPDxcCvbzoqjkCxo+57fn+lmXmFs5Zv96ghcaPJb8BYZMSRIN14SNz4AHHkFPW3NzsUH/xqVQ8mOydWZpsJFtoSsVEpVNlrvo0cMx2nAV2sBp31nLUPiklbMW4yBCXi7H2dfaV6rolVblfWyxCE4YsTBINkAzMKf8Xh6LIE1NQqy/g7dbZtkRWMNk1bxn7uMnnExuDhEuy1sqaanmP8MEw6/IMR7x8xFTQfjJ72FcIJF6ij5f99LBQbSKZ790bn9XkyN9C66wtt8LSmjOR+/NDCBRKAkaAMiy7TR5mNCUoPrSaEw5+OJOsVCg0TQlVnMikA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MN6PR11MB8169.namprd11.prod.outlook.com (2603:10b6:208:47d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 06:01:24 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 06:01:23 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: RE: [PATCH v4 3/3] intel_iommu: Take the VTD lock when looking for
 and creating address spaces
Thread-Topic: [PATCH v4 3/3] intel_iommu: Take the VTD lock when looking for
 and creating address spaces
Thread-Index: AQHbt/xFnz+12v1rTEmQHzTfc+jobLO4xhPAgABemACAAO9xkA==
Date: Tue, 29 Apr 2025 06:01:23 +0000
Message-ID: <SJ0PR11MB67444C4BCD3A61A5D4F9A45A92802@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250428051235.10767-1-clement.mathieu--drif@eviden.com>
 <20250428051235.10767-4-clement.mathieu--drif@eviden.com>
 <SJ0PR11MB67441EF218A7D9B3D9860A1892812@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <3972adb2-fc9b-42cc-bc9c-a1c578577c1b@eviden.com>
In-Reply-To: <3972adb2-fc9b-42cc-bc9c-a1c578577c1b@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MN6PR11MB8169:EE_
x-ms-office365-filtering-correlation-id: 2d336677-af3e-461d-00f9-08dd86e34584
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZUtYNnRlUllLa1dvVk5uLzlNb2M1dXgyeFA4WHpZNGRrZUQ1WG9lUXdnMWlt?=
 =?utf-8?B?MXlLQUNWcS9PSWMyUVdMa0xHUzA4K0x0L1RhaFJUNDErSVhxSHBmUm56Ynh0?=
 =?utf-8?B?VDRzbTMzeThDQVZOOFl3TDFkaUl1dEJTK0hCSkZLS3lzT2dkdVgvT2VhektX?=
 =?utf-8?B?WkkraHJVZTFESDFwUXNFNFB4S3RxRjVQb1FHbFNMcVRyenZMbjRSSm9WLzda?=
 =?utf-8?B?T0hCbTA0L05pK1UxMGhIVTJhUERlRy83L0FjUCtLeWdaZFgvUUxlM2xzeVRL?=
 =?utf-8?B?b25ETW9qWk5rWEdwTjgzbmNlN1k0SjFDMDBwOW8wTXA4RE40MHpUSmRhY3da?=
 =?utf-8?B?c0YrVlVkUGpYaG9wRUdRbWRTV2pBOWZxdGN1S3o2SlVIZ3RzeFU0QU8ycFpY?=
 =?utf-8?B?bE5zNmVxQ3FZL3VkVEpwVEFUN2xaV2wwcysxbVFiRTBOUXN4VWt0Tk5ac3FX?=
 =?utf-8?B?QVhEbzNlVGFYKzltZ3F6YmpNZVEzSlRhVy9QeXlvbmJpYW9tNFd5c0FTVHNo?=
 =?utf-8?B?ZEJaWVhWYTJvVW1VUHFiMVJubmVjb2hkeEtraFYyUTE3SWF0SEVpU1BCWm9L?=
 =?utf-8?B?NHMxRWxHbjIwaWt4RHM4d2ZNTFRXdVF5ZzdGN3A3UmYrYXhsMXIxUEhDSGU0?=
 =?utf-8?B?RGw1WlNodjE4Z0J5blEyTmZBSWZhYnhLL3BudSs4N1hHMjRtWllGb1pGQy9x?=
 =?utf-8?B?ZWRTNE8vSWZwKzJWR25zbXVDWkE2aXVXTnZEMUNWc3dUMlhuTExEcjZoWDVu?=
 =?utf-8?B?VGJaSUJhbmtaVEdyTmN3SVV6eW5FU3llZTNOdnp4VE16alpGTWVKWUsyM3Nr?=
 =?utf-8?B?Vk4rZkNBbnNVdmViMSt4MW9CRnhGckFNMFZ2TlV3azBQOEc5L0lVVmYrbEVx?=
 =?utf-8?B?WVF4blJlWEo2YSsxNGlCeEN4ZURHV0E0Tm5abjFXdzlFSFlWV09kcC9KWS8v?=
 =?utf-8?B?dzlHMUZ4Vm4rVkdncTd6K3hiWUNTVzVNZkhhWXU5YXcrOWRzK28zYWk4Ri82?=
 =?utf-8?B?UTFrZXpBdEMrWDUveElCQ2g3ZWR1ZFJCbG90M0pUUHh2emJNSWVCVEZST1A1?=
 =?utf-8?B?ems2Zk5IUXNSMTFBOFQwdzJQcnoySERvZGVOL0pPMzBUMzBwSEI5UDU4cjA1?=
 =?utf-8?B?WHlVYlRVQkdOSkRyZHh0eHd3dzZQVHBJQ3hxTFFMcTFYQTRGNGRtK1pCM1BB?=
 =?utf-8?B?WXlrODhoSzJmbCsxS3N5SDR6Y1NnOW5YZVcxNlRwWGluZzF0a0N4MldYUm1G?=
 =?utf-8?B?RGMzZ2d3SnlQL0NITndEZTJkM2daMVdUeXRNK0ZnLzNoN3VvNXR4WVhrdC9r?=
 =?utf-8?B?MHBiM0VKdkFxMEpMOUZHRHdQeGxZekNPZ3p3eTV6Ky9HZ3hqd1ZvalpXVHBC?=
 =?utf-8?B?NHNwUWFwaWVnU0FNcFg4c0QrWW5IYnhlOXowbnZRVzk5aTJtc0VQUStCalNv?=
 =?utf-8?B?dHExb0RPZSthVUptek9Cc0ZZRVkybVlRMEY1dGwwZDlnaVVmU2x5Vnh0alUr?=
 =?utf-8?B?QkljU0hqalNBd2JZZkdhSWdqME54UEs3RVZZZ0FuZ1dBWWxwY0MyME5VZnFk?=
 =?utf-8?B?Y0NJalY1Vi9KZEZ0cURObEJjMDk0cG5IajlJR21JUkdDOHBHc3RXQ3ZVZUp5?=
 =?utf-8?B?L0ZQSkhoNVpZMk9GQlVWZlVVUndjc29kaGxFR1RBellFYWVZWE93bVZWMHpB?=
 =?utf-8?B?dElqQ09xRW5nVjArV21JdGVEY05VYTBVUHZkU3I2blIrcXNFZWR2eHRQMXRw?=
 =?utf-8?B?dENzK3lLYXgwSUNvMDJHR24rVGJCMnJIdS9iZXZobU1LbkdvT01hREp3Y3VS?=
 =?utf-8?B?QnROVHZ2eC94ZzEzRzYyZDdMc3o5TWJ0NjQ2b2xHeS9SbnlPS0NMVlpwTTJa?=
 =?utf-8?B?K3VqMXdZdUdLSzZmakVpNjRjRkJPaEttUlBYcUFOOUhCdVE3aWJmZ0o3M3Vp?=
 =?utf-8?B?QWlZRndsU1EwaUt6Q2k1ZTBRNE1HNXlDWWNMbDF1Zlh2Tm5mbjJPOXVKYWw2?=
 =?utf-8?Q?OrWGys/4wJMSs3MJ7+jSwChruqimWo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWpISk15VHQ4MGxvdlAyRURRb0ROanVWZjBva3ZkSFROb2U2V3ZoeVRUajly?=
 =?utf-8?B?emMrNkthcHZ2aGg2TWs1bmt5NEJaQUJ3a3R4Nm9CYjA3TkdoNFBxZCtRcUdF?=
 =?utf-8?B?NWRjNnRNem9xMFVVREw4QkxSS2MwTWxVSU9qTHNCbzNhREEvSlRDK09oQk9S?=
 =?utf-8?B?Mi9majE3cEFTaEg0TE51cW9QMEorVExEamJ4VkJsODUzczdMMzgyM1N2TVQ5?=
 =?utf-8?B?WHBhWisyK0ZSOUhiaGlLSGo2dnJNeDFNZFFqdHpCcDNTMG9UY3ZkQTBWdVBG?=
 =?utf-8?B?c3l3UTlWTktsZU5lTVVYTWlDMGhmWHB6Nzd2WXNGenJ3VW04VkhLTnJYTGQ5?=
 =?utf-8?B?UCtTVmpjRTQydTM3ZDFvOHVVNU93RGVuOTlvVnlWZkN5T3I2czROdDZMQVp1?=
 =?utf-8?B?OVlxc2tSU1g3b2Q3VGtNYmRRMEdrdVMwUWpGVnZjTmYxLzVwczdkNU5lR0sv?=
 =?utf-8?B?ekxTb0I3bHdWN2xNR2FQUlErajNxMExuR2VFL2RsZFlWMHFNdzdSY1NUU3Nr?=
 =?utf-8?B?YnIxYXVJRVpPSm92Qnpsc0JNbVpMWjBJL1licUNSNkhyUnUzUTYwODNWYnQ1?=
 =?utf-8?B?b1ZpUkh6NTd6a2NrK0xaNlZDQVEySk1OclhvNlgyM0JCc3dWamdGSWhBQmgx?=
 =?utf-8?B?VStZQnpwQWphVHNwZUd3cmVxTVdDKzVSSUpkK1lUWncxSDkvZTZhSUhUckJ5?=
 =?utf-8?B?cEhic25kVVhYNnowTnFON0pqdlJKaUFOWSt6LzcxU2drWmYwRzN5R0NFbjdj?=
 =?utf-8?B?L1JKS2tRMXVqekRJYVg2dkNEUmMwQ2ltUHZrTm1PeDZRR0E1a2NNeTlscXhr?=
 =?utf-8?B?Z1hkTTlycUtwR3lTTVo4ZDlnaFdSRUp4TVZxUS9lYU50enZ3NTB5UDhveWFa?=
 =?utf-8?B?UHg1R1pqa2piMUdwZ2FZVEc1a25sMjVLRFVrSHpBVS80QWxpQWlPenlnbDQ3?=
 =?utf-8?B?UDk1SlRweHBFN1JoTi95dUdMUWVHL3Qrc2hJclBFOXdxNU5IbDlKcUVzQzVR?=
 =?utf-8?B?Ykk3NTViRENCaU5wTEJPQ3U5b1lTYk5JdUpyZkp0NDRzNy82NjZEaWx4RDZJ?=
 =?utf-8?B?MDNzejdGb3V0eG9FYTBkVG5MMUROUmxLYVRUNjd3ODB1eDFDS1kyVmxQSVNK?=
 =?utf-8?B?ZEdGdVBsOTBncldFT3ZsQVFYbzF3OU1XUy9TM0JlTldXcnJJa0V0ZFFxS3VY?=
 =?utf-8?B?cFNYcm9hbWVyemhRZ2lKYU1lOWFJV1hQUVZ5WDZtZ0JsSXVKU21iMnhPck5o?=
 =?utf-8?B?R0NxS2Z5YjIvMFRCUm1ZSWNEOXN3LzlxMko0K3pPUWhCRER3ak9CWW5tWUZx?=
 =?utf-8?B?Z0VUSlcwM3lwckJaWEtmMi9EZDhoNHZwS0VOOC80OThhYTVvbTBFc3ZZeXJF?=
 =?utf-8?B?UWg0bG1Xa2prUnFtZlk2MjNFUzdTV1JEVExzYys4Y1JFODhoMzlyRjBadTlv?=
 =?utf-8?B?RG5EK2lReXdmc3A3VkJjQUErbFp0ZUN4QlkwNEMzRUk2ZUJqNXh6S1ZzRkho?=
 =?utf-8?B?YXJVWGVIZFpWQzVacExPdC85WG1TUVhwUkMyUUJvZWpUVUVGc1IzZ0RMUndx?=
 =?utf-8?B?Z3VxclVramNyMWpwMkVRZ0xlWmk2VDBiMHl0ZVlwVkRJdVBmZytiMXlKbXlE?=
 =?utf-8?B?eUZiRWIwOVpSYlNVNEEzS3ZvcGhDWkl3eHNJZ1IrdW1SbjZJNTNtUTNEM0F6?=
 =?utf-8?B?ZTdjZG5YYjVMZzREZk5NbDJqc3VoMEl4bDlHNkJTVFFlME5hYzZjUGdhOEE2?=
 =?utf-8?B?dCt0M21KZHRobWdXdkN3NmpCUmJLbmFLVVFTc08va1VkVG9lZjhxcHhIa3Vt?=
 =?utf-8?B?Z0lUdU1JNUdlcEFvSERWZ3Q5anJ3MFhXVHhaTlI1dGdxOEhQVmFZaDFTOUZ3?=
 =?utf-8?B?U2FaeVFLNE9wenR1and1WGhLaTl5bEl2TFJZVG9kaWxyTUNXYVpJbERnSkVX?=
 =?utf-8?B?bjVwc3dzVDE1SzA2QTRWUXdNem90dnZFU1diOHNlZWRxV1FSN0xEME91Y1pZ?=
 =?utf-8?B?WldJYWRZOTN3eGxxbi9XRGFZSkhsTHhIUWZPQ1J6WXlzSzVmaWdsWXlyQU1W?=
 =?utf-8?B?RnRsdTYrVktLb3BtdlBuV29TSHhxS05aaHJQS00xc3NZa29NWmk3Y0oybE5o?=
 =?utf-8?Q?bDpQi/TEm/XSk5U7xGwnLy+aD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d336677-af3e-461d-00f9-08dd86e34584
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 06:01:23.8227 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LGCaFHp0Azlzi4vSvqDZkkIpdVsFlgyVd977kKNvpcHJyxHn7XPiMEl6ndou9Vj/YUgdzO2P+V6nwKHklkPPHvFn5+LeltSEZwaMpvRTGHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8169
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3ViamVjdDogUmU6IFtQ
QVRDSCB2NCAzLzNdIGludGVsX2lvbW11OiBUYWtlIHRoZSBWVEQgbG9jayB3aGVuIGxvb2tpbmcg
Zm9yIGFuZA0KPmNyZWF0aW5nIGFkZHJlc3Mgc3BhY2VzDQo+DQo+SGkgWmhlbnpob25nLA0KPg0K
Pk9uIDI4LzA0LzIwMjUgMTA6NTUgYW0sIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+IENhdXRp
b246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5r
cywgdW5sZXNzIHRoaXMNCj5lbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPj4NCj4+DQo+PiBIaSBDbGVtZW50LA0KPj4NCj4+
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+Pj4gU3ViamVjdDogW1BB
VENIIHY0IDMvM10gaW50ZWxfaW9tbXU6IFRha2UgdGhlIFZURCBsb2NrIHdoZW4gbG9va2luZyBm
b3IgYW5kDQo+Pj4gY3JlYXRpbmcgYWRkcmVzcyBzcGFjZXMNCj4+Pg0KPj4+IHZ0ZF9maW5kX2Fk
ZF9hcyBjYW4gYmUgY2FsbGVkIGJ5IG11bHRpcGxlIHRocmVhZHMgd2hpY2ggbGVhZHMgdG8gYSBy
YWNlDQo+Pj4gY29uZGl0aW9uIG9uIGFkZHJlc3Mgc3BhY2UgY3JlYXRpb24uIFRoZSBJT01NVSBs
b2NrIG11c3QgYmUgdGFrZW4gdG8NCj4+PiBhdm9pZCBzdWNoIGEgcmFjZS4NCj4+Pg0KPj4+IFNp
Z25lZC1vZmYtYnk6IENsZW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGV2aWRlbi5jb20+DQo+Pj4gLS0tDQo+Pj4gaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwgMjggKysr
KysrKysrKysrKysrKysrKysrKysrKystLQ0KPj4+IDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50
ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+IGluZGV4IGI3ODU1ZjRiODcu
LjkzMWFjMDFlZjAgMTAwNjQ0DQo+Pj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4g
KysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4gQEAgLTQyMDMsMTEgKzQyMDMsMTUgQEAg
VlREQWRkcmVzc1NwYWNlDQo+Pj4gKnZ0ZF9maW5kX2FkZF9hcyhJbnRlbElPTU1VU3RhdGUgKnMs
IFBDSUJ1cyAqYnVzLA0KPj4+ICAgICAgICAgIC5wYXNpZCA9IHBhc2lkLA0KPj4+ICAgICAgfTsN
Cj4+PiAgICAgIFZUREFkZHJlc3NTcGFjZSAqdnRkX2Rldl9hczsNCj4+PiArICAgIHN0cnVjdCB2
dGRfYXNfa2V5ICpuZXdfa2V5ID0gTlVMTDsNCj4+PiAgICAgIGNoYXIgbmFtZVsxMjhdOw0KPj4+
DQo+Pj4gKyAgICB2dGRfaW9tbXVfbG9jayhzKTsNCj4+PiAgICAgIHZ0ZF9kZXZfYXMgPSBnX2hh
c2hfdGFibGVfbG9va3VwKHMtPnZ0ZF9hZGRyZXNzX3NwYWNlcywgJmtleSk7DQo+Pj4gKyAgICB2
dGRfaW9tbXVfdW5sb2NrKHMpOw0KPj4+ICsNCj4+PiAgICAgIGlmICghdnRkX2Rldl9hcykgew0K
Pj4+IC0gICAgICAgIHN0cnVjdCB2dGRfYXNfa2V5ICpuZXdfa2V5ID0gZ19tYWxsb2Moc2l6ZW9m
KCpuZXdfa2V5KSk7DQo+Pj4gKyAgICAgICAgbmV3X2tleSA9IGdfbWFsbG9jKHNpemVvZigqbmV3
X2tleSkpOw0KPj4+DQo+Pj4gICAgICAgICAgbmV3X2tleS0+YnVzID0gYnVzOw0KPj4+ICAgICAg
ICAgIG5ld19rZXktPmRldmZuID0gZGV2Zm47DQo+Pj4gQEAgLTQzMDIsOSArNDMwNiwyOSBAQCBW
VERBZGRyZXNzU3BhY2UNCj4+PiAqdnRkX2ZpbmRfYWRkX2FzKEludGVsSU9NTVVTdGF0ZSAqcywg
UENJQnVzICpidXMsDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgJnZ0ZF9kZXZfYXMtPm5vZG1hciwgMCk7DQo+Pj4NCj4+PiAgICAgICAgICB2dGRfc3dp
dGNoX2FkZHJlc3Nfc3BhY2UodnRkX2Rldl9hcyk7DQo+Pj4gKyAgICB9DQo+Pj4NCj4+PiAtICAg
ICAgICBnX2hhc2hfdGFibGVfaW5zZXJ0KHMtPnZ0ZF9hZGRyZXNzX3NwYWNlcywgbmV3X2tleSwg
dnRkX2Rldl9hcyk7DQo+Pj4gKyAgICBpZiAobmV3X2tleSAhPSBOVUxMKSB7DQo+Pj4gKyAgICAg
ICAgVlREQWRkcmVzc1NwYWNlICpzZWNvbmRfdnRkX2Rldl9hczsNCj4+PiArDQo+Pj4gKyAgICAg
ICAgLyoNCj4+PiArICAgICAgICAgKiBUYWtlIHRoZSBsb2NrIGFnYWluIGFuZCByZWNoZWNrIGFz
IHRoZSBBUyBtaWdodCBoYXZlDQo+Pj4gKyAgICAgICAgICogYmVlbiBjcmVhdGVkIGluIHRoZSBt
ZWFudGltZS4NCj4+PiArICAgICAgICAgKi8NCj4+PiArICAgICAgICB2dGRfaW9tbXVfbG9jayhz
KTsNCj4+PiArDQo+Pj4gKyAgICAgICAgc2Vjb25kX3Z0ZF9kZXZfYXMgPSBnX2hhc2hfdGFibGVf
bG9va3VwKHMtPnZ0ZF9hZGRyZXNzX3NwYWNlcywNCj4ma2V5KTsNCj4+PiArICAgICAgICBpZiAo
IXNlY29uZF92dGRfZGV2X2FzKSB7DQo+Pj4gKyAgICAgICAgICAgIGdfaGFzaF90YWJsZV9pbnNl
cnQocy0+dnRkX2FkZHJlc3Nfc3BhY2VzLCBuZXdfa2V5LCB2dGRfZGV2X2FzKTsNCj4+PiArICAg
ICAgICB9IGVsc2Ugew0KPj4+ICsgICAgICAgICAgICB2dGRfZGV2X2FzID0gc2Vjb25kX3Z0ZF9k
ZXZfYXM7DQo+Pj4gKyAgICAgICAgICAgIGdfZnJlZSh2dGRfZGV2X2FzKTsNCj4+PiArICAgICAg
ICAgICAgZ19mcmVlKG5ld19rZXkpOw0KPj4NCj4+IFdlIG5lZWQgdG8gcmVsZWFzZSBtZW1vcnkg
cmVnaW9ucyB1bmRlciB0aGlzIHZ0ZF9kZXZfYXMgdG8gYXZvaWQgbGVhay4NCj4NCj4NCj5JbmRl
ZWQsIEknbGwgaGF2ZSB0byB0YWtlIHRoZSBCUUwgYWdhaW4uDQo+DQo+SXMgaXQgb2sgZm9yIHlv
dSBpZiBpdCBsb29rIGxpa2UgdGhpczoNCj4NCj52dGRfaW9tbXVfbG9jayhzKTsNCj4NCj5zZWNv
bmRfdnRkX2Rldl9hcyA9IGdfaGFzaF90YWJsZV9sb29rdXAocy0+dnRkX2FkZHJlc3Nfc3BhY2Vz
LCAma2V5KTsNCj5pZiAoIXNlY29uZF92dGRfZGV2X2FzKSB7DQo+ICAgICBnX2hhc2hfdGFibGVf
aW5zZXJ0KHMtPnZ0ZF9hZGRyZXNzX3NwYWNlcywgbmV3X2tleSwgdnRkX2Rldl9hcyk7DQo+ICAg
ICB2dGRfaW9tbXVfdW5sb2NrKHMpOw0KPn0gZWxzZSB7DQo+ICAgICB2dGRfaW9tbXVfdW5sb2Nr
KHMpOw0KPiAgICAgQlFMX0xPQ0tfR1VBUkQoKTsNCj4NCj4gICAgIG1lbW9yeV9yZWdpb25fZGVs
X3N1YnJlZ2lvbigmdnRkX2Rldl9hcy0+cm9vdCwgJnZ0ZF9kZXZfYXMtPm5vZG1hcik7DQo+ICAg
ICBtZW1vcnlfcmVnaW9uX2RlbF9zdWJyZWdpb24oJnZ0ZF9kZXZfYXMtPnJvb3QsDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgTUVNT1JZX1JFR0lPTigmdnRkX2Rldl9hcy0+aW9t
bXUpKTsNCj4gICAgIG1lbW9yeV9yZWdpb25fZGVsX3N1YnJlZ2lvbigmdnRkX2Rldl9hcy0+cm9v
dCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmdnRkX2Rldl9hcy0+aW9tbXVf
aXJfZmF1bHQpOw0KPiAgICAgbWVtb3J5X3JlZ2lvbl9kZWxfc3VicmVnaW9uKCZ2dGRfZGV2X2Fz
LT5yb290LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZ2dGRfZGV2X2FzLT5p
b21tdV9pcik7DQo+DQo+ICAgICBtZW1vcnlfcmVnaW9uX3VucmVmKE1FTU9SWV9SRUdJT04oJnZ0
ZF9kZXZfYXMtPmlvbW11KSk7DQo+ICAgICBtZW1vcnlfcmVnaW9uX3VucmVmKCZ2dGRfZGV2X2Fz
LT5pb21tdV9pcl9mYXVsdCk7DQo+ICAgICBtZW1vcnlfcmVnaW9uX3VucmVmKCZ2dGRfZGV2X2Fz
LT5pb21tdV9pcik7DQo+ICAgICBtZW1vcnlfcmVnaW9uX3VucmVmKCZ2dGRfZGV2X2FzLT5ub2Rt
YXIpOw0KDQpzL21lbW9yeV9yZWdpb25fdW5yZWYvb2JqZWN0X3VucGFyZW50Pw0KDQo+DQo+ICAg
ICBhZGRyZXNzX3NwYWNlX2Rlc3Ryb3koJnZ0ZF9kZXZfYXMtPmFzKTsNCg0Kb2JqZWN0X3VucGFy
ZW50KHZ0ZF9kZXZfYXMtPnJvb3QpOw0KDQpUaGFua3MNClpoZW56aG9uZw0K

