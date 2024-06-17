Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7508C27C53
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 01:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ17q-0007YC-Rc; Sun, 16 Jun 2024 21:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sJ17p-0007XT-AZ; Sun, 16 Jun 2024 21:25:37 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sJ17m-00028v-UN; Sun, 16 Jun 2024 21:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718587535; x=1750123535;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cvvGz6eeKartbMCsJeHdT/y1x6ncIFtukvyWzG0IbLY=;
 b=Umx+S2BB6g4N7jHbvyR03pxB25z74lK486n/w3OH+E6dAgGU/g2UJdUh
 n4OCVy1mEoJKwdkQ4ewxmBr1v0VtybYPTz8GJs9xPmQx9R71ms94IB68Y
 abz2a+IW2XlxqcqDlKAd8v6ySf+QRNZD6Cw0ThMeyyx2giSktuWUTTfEy
 s7FxEGo8W7N4hUESNxIIs1UcrprjXA+tNj1lamDjtPVVnPsscPovzuZ02
 SN7z3dhlxU/MF6SdsKI8sBshPa7leLCpf4L7FAUQBmaojnjgEA3RPxxiw
 IFq8OWPRR1RRnz7ftEKa0vqcqn0uTv0VEXs0XOGQVSkW8EhXrgLl2D6GP w==;
X-CSE-ConnectionGUID: ILZ8fpl8TFOgpwRVeccTew==
X-CSE-MsgGUID: BmawauiISFuhUbV72D6reg==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15633423"
X-IronPort-AV: E=Sophos;i="6.08,243,1712646000"; d="scan'208";a="15633423"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2024 18:25:30 -0700
X-CSE-ConnectionGUID: GnDbcx16R7aaqk29AnwsgQ==
X-CSE-MsgGUID: A0GsqgTLRSqs3VTLKA1F/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,243,1712646000"; d="scan'208";a="40903010"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 16 Jun 2024 18:25:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 16 Jun 2024 18:25:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 16 Jun 2024 18:25:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 16 Jun 2024 18:25:29 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 16 Jun 2024 18:25:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUssCJp3O+mgP52Mb3QIkbyCBfSUH5b71PLDlgxe7MspAtBOts5LtBv195DOZNx9hrc8ki0637AhHVMcN7gUumlpuI/yw/uJolB469iZSwkSutPRcKw9F0XeAcA8y/lY3ekrDVq3gT6MR/MQ0TrNWh4t1CEOqw7asahfaN3WbPuPbyfVm2VdJTvhtpE478ymgAYzAIOQBEtQcq3y20hw3d/IhuiPRTPaievls91/r36WG43F0dBfjPPhBIUUZRdu3xvYM+5Oejwr+NbakwrHxVCqowuEYuQVMCU74se/jrUYppcuoA5l0HmTZW0zXEjTI63VMPhO/e72H3g4D4k70w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvvGz6eeKartbMCsJeHdT/y1x6ncIFtukvyWzG0IbLY=;
 b=QljznFNV1WonRdW4dw1oeAjjEh/WzuK192/s2nA90Q2y6PYsbJzA2xzhHOd/SJnEZdUIe+L0n8woW4EevDDh9f1HQmpY3F9I6IOpdeCOwmGwl2rxgsVi+t1X5LwEjBJL23Lh46E+EkfTKHBPLEE+Xh4T8xQuOBSBGKq+BK4ovITOPVb23s71Lcs3ylRYhY2PjH0AytEIfzHNbsgTI46/GlfQiPIs0a8oBcCGXQLl7TCxmJ9JR/s9+iEeKnSWtcaLbWJGIOQeevOKbSyhcZsSWYBr4hXcck92fxKHVMej4oxoUNi+MJQhvp4nJG9xU33y7yri4Ffqq3R9QBVM2g93wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB7852.namprd11.prod.outlook.com (2603:10b6:8:fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 01:25:24 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 01:25:24 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "yanghliu@redhat.com"
 <yanghliu@redhat.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>
Subject: RE: [PATCH v3 1/7] HostIOMMUDevice: Store the VFIO/VDPA agent
Thread-Topic: [PATCH v3 1/7] HostIOMMUDevice: Store the VFIO/VDPA agent
Thread-Index: AQHavXOC/oNuGumRbUykLJrCMOqnurHG+3QAgAANL4CAAAERAIAEIbdg
Date: Mon, 17 Jun 2024 01:25:24 +0000
Message-ID: <SJ0PR11MB674408FB45B20DC52E42193692CD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240613092359.847145-1-eric.auger@redhat.com>
 <20240613092359.847145-2-eric.auger@redhat.com>
 <ef400920-dcf4-4f37-b4ce-c5560b92d9c5@redhat.com>
 <f6473f76-1d8f-41cb-9488-73edc960c996@redhat.com>
 <ec740f33-44ae-4d50-be65-5f717122f4f0@redhat.com>
In-Reply-To: <ec740f33-44ae-4d50-be65-5f717122f4f0@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB7852:EE_
x-ms-office365-filtering-correlation-id: e7621316-351c-4043-8432-08dc8e6c5c93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230037|366013|7416011|376011|1800799021|38070700015; 
x-microsoft-antispam-message-info: =?utf-8?B?MGpKckEraHN1UC9FRXhxbThyN05TbHdMTUE5MDFCZU1mLzFra0IybzNad1hx?=
 =?utf-8?B?RTRqTjFUWlBrbDdjMnh6VG5MM0J4VmE0WTZSWnorNDR2ZHZJRmVJNjhlQ29F?=
 =?utf-8?B?ZXpyZndCZFVnZXR3c3dIZ3VjS3NGblpNM2wvRjN3K3RuTytaVTBtTjJWYURI?=
 =?utf-8?B?UHRVN3VsTUVCRE53MnVIQ0QvTGlwbXY2TFozOGpZUCtCcW5ob1d3RjNMYnpv?=
 =?utf-8?B?RjlDK0RHc0NiOHAweThNekhTYUVVY3RGY0VFeGQ1WDh0N1dKMFNFUkRERFI1?=
 =?utf-8?B?alBreGlPbGFqWlFzZWwySXl3MWt3RlNVNXZrck9BaWdtZnJBbS8wRjNQM0d0?=
 =?utf-8?B?NFJUZXpCUEdqM1pFOGVPd0hyS2pLZ1BCc0Z5NXFXRHRtL01lVjFRZlQ5dTVO?=
 =?utf-8?B?Zy82SHFmNzIwMWszMndZWnluTHZ6RnJxV2xaUHdFVW0wcHd2cnZMYW1rWHJz?=
 =?utf-8?B?VTI4Qk14NUlDd2VUL0hCTVg1OHhjWGtFUTNUOThCMFF0K2QzcmxnZ29makdH?=
 =?utf-8?B?ckwxN2hSUUlxM0J2elBnV1ZyUHpiL1U0UDBLSmZVL1J1RHIvSUxHVkFEeVdB?=
 =?utf-8?B?N2F1RUwrSThnaHhRaGtEZmYzQ0VNQTV0Rkl6bVlWWW9TVDFOanNseklPdnB1?=
 =?utf-8?B?Vm5Sc05zQlF5TU5Ka0R5cGh1LzB5dEdEK2EyQzdoM1RBYTRuUHBDczhFZ2xD?=
 =?utf-8?B?eDN4VEdKRXdOUXFqUmpBWllGWDVUeHNpTFhOVVNuUzFuQkRFUDM4N2ZaQ1I2?=
 =?utf-8?B?V0luK2s0eXg5TXRwNXhCREFMeG40eXB1ZXlIQnd2c013OXBDazV4aExYZWZO?=
 =?utf-8?B?UUQyREVTVjlWTkRzNjlrZWtXZUhYZ1JsMUV5VEJ1SDg5aGp3ZHc2TWJON0N3?=
 =?utf-8?B?czkzajFnSFlsMDFDcExIYTdMWDR5ZlZvb3NoZG9QVnlMcGVXMG5UOGtlRm0y?=
 =?utf-8?B?SmZlWmd2YkZ3b3oxVkRvREtmM3UwSTMrV1pRQWV6dlNTVTF4UUdNekJvczgx?=
 =?utf-8?B?bUNneDZZaFlrT0xRbnVBaXM5bzBlK3RkU010NXVCR0lOa1kreVdjWXkvRVVV?=
 =?utf-8?B?ZjNmY2tXK1RQRE54MGtRcHh6MDhGcVI4YXV5bmlmbE00eTBPRTdSRnl0SjJ1?=
 =?utf-8?B?d25QSURuTXNDYVcrT0k2dnNtanBvS3BsNVlzUmFicHdYRHJUMWpHNjNIRVdh?=
 =?utf-8?B?VXNlaHlXYXdMZDVQMXZ2TlJJRStWMHdCRDhZUWI0RFFMZlQrQzhTclYvVXpB?=
 =?utf-8?B?RlkwNGxuWjIwWDVvTE1qOGVpM2NiL1hmR2k3UUxpOU9QbzlZYW9uZWNNUHQ3?=
 =?utf-8?B?QnlJWHJHcnR3aU9oOU1XaytmWFZVSlpwME9CQnBCRWlCNFZZZWJkNW9YK1pC?=
 =?utf-8?B?YWhIVkhJSm5VNlRzTEUvNUtIV2lGMGhGeVlzOXp5SktIbEJROEZTa2pNdTVN?=
 =?utf-8?B?NUc2L0ZpSFhqbEtXaGQrTHo4dFRHUEhZZStSTm13QlZvRFNHajFXVVROdTlB?=
 =?utf-8?B?WlhJMmpjSmpUNmZ0QkdBeCtZWEYvSmN3bzZwbWg2dU1WdGZWRXZWYXNPa1Z1?=
 =?utf-8?B?UzFsYkllWGVHY1ZqYVNMb01qc3A5YUtvd1JXanNpNHF1RTFtWXV0QSt6OG5P?=
 =?utf-8?B?SmthZDJmWlBhMGJlMGthcXpKVWt5QnBiRktjMDZNVCtVeThXWkp4SGVWTUpM?=
 =?utf-8?B?dVA4TnRIWkY0akhHbDY0NVEvSW5jQldXVkZKUE9WNVFlQVRSYTRVOTJiOTJC?=
 =?utf-8?Q?zps9vYRlbYsQngk8rlY7UKZWsohgF9unIhn6bii?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(7416011)(376011)(1800799021)(38070700015); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHhMQ0pmWFd5NlBuYzJkdVRCVDF4cjZiVnZGSjdLWVJZWk1FS1pITk5BUFN1?=
 =?utf-8?B?ZUo2NlZIMWRQUjZxWUlPNkswNUZnMWpXeVZTYyttN2VMZHVJMEVKYnZPV28y?=
 =?utf-8?B?RnYwK1c2V3NpT3pCV1d5MTlGMWtweGR4YzlKSStpK0FScnBpL25Pd0dldUNn?=
 =?utf-8?B?a28vZ2NtUlZCVE1lbGI2Qlp4MGViczhydnBpTEpXY1F0MlF6Q1RJSmhHa05M?=
 =?utf-8?B?dmV4ZkFUYThvWHUrUEh1MGg5bjFBdnNoSXBMR3BuTk1vQndlUkl5MTZCZG9m?=
 =?utf-8?B?aGtiSlBKWVR3b1Bxd1BZcFFQbXZwc0I5Z1czOHNCeUJnZlpRY0xkaXViTzZa?=
 =?utf-8?B?Q1VVdFdGdllacDFGM0VUcVpWYTBNME1aT3hzTUNMdmZPU1l3VFc3VWR2Mkh6?=
 =?utf-8?B?emRKcVFzc3BRRCsxUGYzVkZzMWNkZzZWY1dyeTk3OE5ZL1EzN013alVWMjlG?=
 =?utf-8?B?elF6R0VjemdseHRhcG1DUDJiSDRLb2paN2pxUWdjMEk2V2Q3OTRnZDRIaWFD?=
 =?utf-8?B?Q0JpbUhOYU5DbVQ5NThublVPVXFCOThnM2dUODhCQ3VPbCtrdVBJWXJFL0F2?=
 =?utf-8?B?WitDRzBBYTNXbDRrSnZjakN6NDB2TUpyOGt5WUlDeC9aRjJoK21sRHlFYXJp?=
 =?utf-8?B?bFdYVzVyRjdFTnc3dXNDdXdIZERHMW44RUhja0JnQkJ5ZWZjM3RlRzJzSjdX?=
 =?utf-8?B?emtYSUFPako5YkRHT25GY3BIWllYTzdHNmhTNkt3dXJHeGFrN1ZGd2p5bGpE?=
 =?utf-8?B?NFdOZm1OWm5hb3NzRy93VmZRekFlTlVmZS9wV1k3VlhBMzd0L1A0UXI1cHc5?=
 =?utf-8?B?bGRnVi9scUQ2OHExTHVUMEpmRGtJY3dZSi9rKzk3MzB2S3ZlUnpGY3A4SEZH?=
 =?utf-8?B?Q0pUTEg5ZWdvaFRHTHYvOUFZM2k0bTZEMmhhTjNsOGU4RnJNMCtmKzJqOFV2?=
 =?utf-8?B?UjVNWlB5OG80Y2JlS241WU9tcFlOMjBQb1RKVVc2U0owaE50WnU5MU9YbG5i?=
 =?utf-8?B?SmExN2Y4WXRFV09aS1o4bDJ6QnJ0ckJIMUVoNVZIQmFlNVF3aCsrUnMxUXZK?=
 =?utf-8?B?YUlGQmdnTUtoTitYM3lVb2t3TWpCakVpcFlOTUw4d2VPY1JoekZZNUFxVm1M?=
 =?utf-8?B?bm5PL21ZQjcwcFBwR1VPKzBDTDEweEVSYW9HVllNZ2ErNy90eW02NHZSM2Jp?=
 =?utf-8?B?S09ucUhzenlGQTFRb3NoQXJOeTJOSXprZC8xR3ZKeUF4RjY4ZHBnRS9uaStq?=
 =?utf-8?B?YkNkZm5SbFpOQkZYZTIvTENSWnlsZjMrcGxmaWFjcGpGWm1YSVo3OGhPMSs4?=
 =?utf-8?B?NXU5MlZXajF5RTk3akNyeFlraHlKWmNHNTN4U3p5UFpReE40WU5rQnAyMCsy?=
 =?utf-8?B?dlgrUERsOHB1UVd0eWh6MlJCMXJFb0xTS1Q5SldRYWJOTXlZUXJpYlBWM1dU?=
 =?utf-8?B?MmZ0T3RQZ2lRcmdhS0liUzU1ZXhLbmZhcU5aU3pNcXZwWllQM3hYejVQTmt2?=
 =?utf-8?B?ZTdiNDgvaWRna3J2M0NQayt3SktMRlNZRXFZNHRVb0Z2aWZvY1JOZCtyd2Yv?=
 =?utf-8?B?MHdEeFBpdFdBRUhRQ0p4SHRVTWxwRnc1RXVxcmpQZlN1MlV2WlA5S1V6UXp2?=
 =?utf-8?B?THQrRmkzT2U0czdrOGx4dW1xclJxQmhWTW8wRWJGQVczQzVYSXk3U0c5TVJh?=
 =?utf-8?B?K0t0WVFhaFZ3L2pTZWZsRlFYTnplcC9qZ1IwL1RhemsrSGkzRDRITDRXelpJ?=
 =?utf-8?B?V1V4WmlTR1RGelpJcUtpMGVNWkxnYTBhUjFFeklWVnJFbjdleWcrdlZtYklL?=
 =?utf-8?B?bUc0OHZUTFFGejFnK25KNzJKV09Ua3VvWW5GZjJ1NVJQU0R2NHJRSVo2TFFD?=
 =?utf-8?B?MUVETmc0S1VkOTVybG9lU3ZFVXVDN3RqMGsvSzE3REtHaC9OUDR3cllmN2Zj?=
 =?utf-8?B?ZFdzOFpsOWR3Y0pkdHRPYytBYkdPQ25lMDNXTjZYWjBQU2MxM0tVR05KajFq?=
 =?utf-8?B?Y3IveTFucmRuMUlyTFIyRGkyaVEwOXZiaFZHaURTV2p0YUJSVURiMi9uZ0R1?=
 =?utf-8?B?Mlk4Z1VjM0RFSlhkVENVZXZiekphWDg4Z1hYVThKUHY3NVFXa01YbW9yMTdF?=
 =?utf-8?Q?pjX+HNXcyElMEFFE9UlSd/L0r?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7621316-351c-4043-8432-08dc8e6c5c93
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 01:25:24.0241 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ACMxqTVVRopgJBVeZ96J/0D38wyFgWCPChZzcU1jR1N+M3dMCERHzJHzFe+oPnMLK2AtPsUHtTcfAlW041/bBdtvYIeYbQYkaqQc44qCELA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7852
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlNlbnQ6IEZyaWRheSwgSnVuZSAxNCwgMjAy
NCA2OjA1IFBNDQo+VG86IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsgZXJpYy5hdWdlci5wcm9AZ21h
aWwuY29tOyBxZW11LQ0KPmRldmVsQG5vbmdudS5vcmc7IHFlbXUtYXJtQG5vbmdudS5vcmc7IG1z
dEByZWRoYXQuY29tOyBqZWFuLQ0KPnBoaWxpcHBlQGxpbmFyby5vcmc7IHBldGVyLm1heWRlbGxA
bGluYXJvLm9yZzsgeWFuZ2hsaXVAcmVkaGF0LmNvbTsgRHVhbiwNCj5aaGVuemhvbmcgPHpoZW56
aG9uZy5kdWFuQGludGVsLmNvbT4NCj5DYzogYWxleC53aWxsaWFtc29uQHJlZGhhdC5jb207IGph
c293YW5nQHJlZGhhdC5jb207DQo+cGJvbnppbmlAcmVkaGF0LmNvbTsgYmVycmFuZ2VAcmVkaGF0
LmNvbQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS83XSBIb3N0SU9NTVVEZXZpY2U6IFN0b3Jl
IHRoZSBWRklPL1ZEUEEgYWdlbnQNCj4NCj4NCj4+PiBUYWxraW5nIG9mIHdoaWNoLCB3aHkgYXJl
IHdlIHBhc3NpbmcgYSAnVkZJT0RldmljZSAqJyBwYXJhbWV0ZXIgdG8NCj4+PiBIb3N0SU9NTVVE
ZXZpY2VDbGFzczo6cmVhbGl6ZSA/IEkgZG9uJ3Qgc2VlIGEgZ29vZCByZWFzb24NCj4+Pg0KPj4+
IEkgdGhpbmsgYSAnVkZJT0NvbnRhaW5lckJhc2UgKicgd291bGQgYmUgbW9yZSBhcHByb3ByaWF0
ZSBzaW5jZQ0KPj4+ICdIb3N0SU9NTVVEZXZpY2UnIHJlcHJlc2VudHMgYSBkZXZpY2Ugb24gdGhl
IGhvc3Qgd2hpY2ggaXMgY29tbW9uDQo+Pj4gdG8gYWxsIFZGSU8gZGV2aWNlcy4NCj4+Pg0KPj4+
IEluIHRoYXQgY2FzZSwgSG9zdElPTU1VRGV2aWNlOjphZ2VudCB3b3VsZG4ndCBuZWVkIHRvIGJl
IG9wYXF1ZQ0KPj4+IGFueW1vcmUuIEl0IGNvdWxkwqAgc2ltcGx5IGJlIGEgJ1ZGSU9Db250YWlu
ZXJCYXNlIConIGFuZA0KPj4+IGhpb2RfbGVnYWN5X3ZmaW9fZ2V0X2lvdmFfcmFuZ2VzKCkgaW4g
cGF0Y2ggMyB3b3VsZCBncmFiIHRoZQ0KPj4+ICdpb3ZhX3JhbmdlcycgZnJvbSB0aGUgJ1ZGSU9D
b250YWluZXJCYXNlIConIGRpcmVjdGx5Lg0KPj4+DQo+Pj4gVGhpcyBtZWFucyBzb21lIHJld29y
ayA6DQo+Pj4NCj4+PiAqIHZmaW9fZGV2aWNlX2dldF9hd19iaXRzKCkgd291bGQgdXNlIGHCoCAn
VkZJT0NvbnRhaW5lckJhc2UgKicgaW5zdGVhZC4NCj4+PiAqIEhvc3RJT01NVURldmljZTo6bmFt
ZSB3b3VsZCBiZSByZW1vdmVkLiBUaGlzIGlzIGp1c3QgZm9yIGVycm9yDQo+Pj4gbWVzc2FnZXMu
DQo+Pj4gKiBoaW9kX2lvbW11ZmRfdmZpb19yZWFsaXplKCkgd291bGQgdXNlIFZGSU9JT01NVUZE
Q29udGFpbmVyOjpiZS4NCj4+Pg0KPj4+IFRoYXQgc2FpZCwgSSB0aGluayB3ZSBuZWVkIHRoZSBR
T01pZmljYXRpb24gY2hhbmdlcyBmaXJzdC4NCj4+DQo+PiBPSyBJIG5lZWQgdG8gcmV2aWV3IHlv
dXIgc2VyaWVzIGZpcnN0LiBBdCB0aGUgbW9tZW50IEkgaGF2ZSBqdXN0DQo+PiBhZGRyZXNzZWQg
Wmhlbnpob25nJ3MgY29tbWVudCBpbiB2NCwganVzdCBzZW50Lg0KPg0KPlllcC4gSnVzdCB0YWtl
IGEgbG9vayBhdCBtaW5lLiBJZiBib3RoIG9mIHlvdSBhZ3JlZSB3aXRoIGFib3ZlDQo+cHJvcG9z
YWwsIEkgY2FuIGNhcmUgb2YgaXQgYW5kIHJlc2VuZCBhbGwgMy4gSXQncyBhIHNtYWxsIGNoYW5n
ZS4NCg0KSSB3b3VsZCBzdWdnZXN0IHVzaW5nIG9wYXF1ZSBwb2ludGVyIGFuZCBWRklPRGV2aWNl
IGZvciB0d28gcmVhc29ucywNCjEuIGluIG5lc3Rpbmcgc2VyaWVzIHZJT01NVSBuZWVkcyB0byBh
dHRhY2gvZGV0YWNoaW5nIGh3cHQgd2hpY2ggaXMgVkZJT0RldmljZSBvcGVyYXRpb25zLg0KU2Vl
IGh0dHBzOi8vZ2l0aHViLmNvbS95aWxpdTE3NjUvcWVtdS9jb21taXQvM2NhNTU5ZDM1YWRjOTg0
MDU1NWUzNjFhNTY3MDhhZjRjNjMzOGIzZA0KDQoyLiBJZiB3ZSBwbGFuIHRvIHN1cHBvcnQgVkRQ
QSBEZXZpY2UgaW4gZnV0dXJlLCB0aGUgb3BhcXVlIHBvaW50ZXIgY2FuIGFsc28gcG9pbnQNCnRv
IGFuIFZEUEFEZXZpY2Ugc3RydWN0dXJlLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

