Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01ABC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 11:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh4fC-0004dM-2l; Wed, 30 Jul 2025 07:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uh4PF-0004lE-Pp
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 06:51:38 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uh4P5-00084l-Ox
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 06:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753872684; x=1785408684;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dR/c0arWMWNW17KD70EI4BiV2UhyGrCYe+smTYR6Gis=;
 b=PLeUqSNsJAIA+LxwkXt02L9hkmX1OPb9UWgfcxGQNZLFLyhk2r+TJAPh
 d1a/fB5R2boOs2V2YiOCTnPn6FjODNh/7t3yGmYLtCK7LSNyjdQr1b3Wt
 o6FzJdUtNYMJlfWoTPOrvPIeCa9vwwn5w6J6QFTsXFVdHG3O9Jm4RZMJl
 uMFvEQRMCWQKo8dLMcMIFmjEE7dzQBQjkHxHj7smY+syKt+bZu6ipmeSg
 hds03JiyiRMrEFtE+tQ74moqj66/QZkekGp6+COnPwbOU+syUIbG5taIC
 OMz/chcRiZ5rvbwKxYcMLMmsAXe3JRn+M8jYoXNfw+H5q4U9is6UQo315 A==;
X-CSE-ConnectionGUID: mrVsQ7QaRKi31bbWoQgaSg==
X-CSE-MsgGUID: pXvbLrwOQmuhx0jT9j9UXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="81619270"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; d="scan'208";a="81619270"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 03:51:17 -0700
X-CSE-ConnectionGUID: zGNx97kRQnKf32FmHeMfvQ==
X-CSE-MsgGUID: EOKkQSUTRk657l4b8k0olQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; d="scan'208";a="162216826"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 03:51:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 03:51:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 03:51:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.58)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 03:51:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxK3AKL9hGWh5ZqOpKxLRrIbPsYHVXBf9gJ2u/n8Zib6dikKd2DX5s+W66p5EsTVeAf0+Lhk35wF+ZmNA3w5okUa4CgIPVl5o8W6zxU5BdgHix0Wy3ffs3XY4n6ItfjM0q0UFtyk9XvFP/hHDmiG7s15QEYPQzwQbvPuqZzEQDkXFLKYmQgNSbmdHsPCXhOFw4P5OGsbbjfZ5srS1BYQmd4BMbdlnQyJmTl0sQn5hqfeEndxR8JVnhHqGR+RG0ZZqTDu0h2Di6OIGlUBPPAqrrhgBc++OsQ1L7huwWSJU9C2xD2+HoQ6IMfIlKxwuQKuFLLUFitgjhv55rwD8bvSPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dR/c0arWMWNW17KD70EI4BiV2UhyGrCYe+smTYR6Gis=;
 b=eS36UE3vDxyE1fHGJCoiyfLCXx89RNs3CEjocUZ8Ga9AvghskZvXyj+EGuFgO1cP2GhGSeL/9sbjgY2Oc60/9fALeoS/MnLeM9FA26fz6CCK8BbprKv+MF3fMuJcmh71XauQknn0RuaNfhiWjdgLpAGyUhWCbRVRDcm7hVWP6uJ84Ryrko6poKkgUVH/33DQxgYTmfm7qB9A8PvWDtwse32uYTXYXXtKYZm8V6wkPfpKUMYaq5jToyUT0iDhPAhS9NMMjrKIZjQ1E/ZeIL4EjQV84cxuD8LmIA7KxUgM4gjgPHKo7PZBR3VCxMelorkb2bUBv7cKg9Wfu5chgbgoJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA1PR11MB9519.namprd11.prod.outlook.com (2603:10b6:208:5d6::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Wed, 30 Jul
 2025 10:51:13 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8943.028; Wed, 30 Jul 2025
 10:51:13 +0000
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
Subject: RE: [PATCH v4 02/20] hw/pci: Introduce pci_device_get_viommu_cap()
Thread-Topic: [PATCH v4 02/20] hw/pci: Introduce pci_device_get_viommu_cap()
Thread-Index: AQHcAGojBHGmrySSMUmmVahA3JzrVrRJFhCAgAFhZeA=
Date: Wed, 30 Jul 2025 10:51:13 +0000
Message-ID: <IA3PR11MB9136DEF9919BCB1B4F9662619224A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250729092043.785836-1-zhenzhong.duan@intel.com>
 <20250729092043.785836-3-zhenzhong.duan@intel.com>
 <9989340c-c304-4208-9c33-f54fc5d1e865@redhat.com>
In-Reply-To: <9989340c-c304-4208-9c33-f54fc5d1e865@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA1PR11MB9519:EE_
x-ms-office365-filtering-correlation-id: 34d06214-2765-4bcc-07e0-08ddcf570066
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Umo0eC9lTTVGQnBWeSsxM1JreWVFUzg5SGZzYUxhc2Zid05xT2xZbWdndlNx?=
 =?utf-8?B?eXRQSnhPbk5tYXBCbTVLTUw2cUlYUEpWNUF6NHhYdjNlcmx0UzkwVzJYcFda?=
 =?utf-8?B?bk1NQkhYMUdUaEdxOXp3N3V1Q1g3NVhDMG1DZ0UxaU5nNkhDTWZGNm5uam9I?=
 =?utf-8?B?M1hXWmhqRVdGbXFGSWZsd080QlZRZk43ejBHQXJJS2FwL0VERURPQk5odlh2?=
 =?utf-8?B?WnRrTkpNK2tOUkJSM3B4R1luRGF1U09McDFsZ3BZRG1LQ3lscEhpbWZGRFg1?=
 =?utf-8?B?TmZTdUM0bk5xT1N0enN4V3puMEJYdXFHbkdUMXg4YnBHRU83SlFEVWgxZlNw?=
 =?utf-8?B?SW9wc0VJaFFhSTVpdGVQdk9RdVZMVmx0MUJQdFBNVXY3cFFKaStQQUQ3YnZq?=
 =?utf-8?B?OEJtSldNWnA4Z01NOTBSU3Z1dXg2ZTNvYTUvU3djUWNLUkc5NXg2RHVyU3lB?=
 =?utf-8?B?M2crbHBCVVM5ajFNZXFaNWJIQ0JLNld6NFZIQ1pBSWV3cTZKNUNubjJDZ1ZF?=
 =?utf-8?B?enVlVXRCWVVQLzdCSnR2d0RCTDZDczJLQjA3dW8yMldQV0cxWFNYcUFHOWRs?=
 =?utf-8?B?ZFR3S012WlplQmtIbHJZbWNKcnlVZUR0QkRnazdwV0hKQVg1WW0zOEtGWVNt?=
 =?utf-8?B?aUd1QmpJa2phaWZzS1l6KzRqTTc1ZmZmbVNJRkdWeFVhL3lkbUFoQmJpaU5p?=
 =?utf-8?B?VzFXWFBOSWtnL3lJSVRwSHoxaWc0dzk3UTlORlFOMUxhdER5eW4yZFBKMjJr?=
 =?utf-8?B?QVVzQTJ2SjdZYitpaVpKNTRncTVHWXZpYXI0ajl1SmpmVTNFanNpcGoyR2Np?=
 =?utf-8?B?U01LK29jNHp1cmJaYlZNeGF4OFhNS2N4TkpmTFB1NTN4ZjV2ZHBYVXp2U1pX?=
 =?utf-8?B?U1ZLWVhDUVExTFVlQ3VMa1hhMnZFak95WnNQMzQwK1dzaVB4WGI3ZFBWN3Zp?=
 =?utf-8?B?dGxqSzkzZW9qZXBXSUVoUmFwLzYyTSt3OXR2eElCNmdFVzE3YjczeHJrU25z?=
 =?utf-8?B?b1ltZUswdWVlaHJPQm1BQmcwZHhvR1lBVHBON3ZUSHd2YzlSM3F2UkI4NmVM?=
 =?utf-8?B?VUlRN2hRd0FqS2pnUS9LSW9zVVAwWVp1MTJSc3FlSTdjaUNlWjRBdGlOY0RN?=
 =?utf-8?B?Ulk3RkNMa1JQbEJzRTQ2dGRUblFwZmRmTmVxSHRVbnIvUStUVFVZQmRJdVZT?=
 =?utf-8?B?MVRyeXo2akNXVTdkZiszdnpzNUlyTHR6cnFXVzZxSTBlbDBIWk5YVHJYS0l4?=
 =?utf-8?B?YmxmT0VnQmtWZFZyN0J0cGJoMnFLSGJrSXMwajFpN1Zwbm1Sa1B2Y25QbGw4?=
 =?utf-8?B?VjNtcGVoSVJheTdYVlhPR0dyZjEwWm1hZXFnS1NETDhrdTNsdWVMTkdreEhw?=
 =?utf-8?B?aDJkOGVDaWxaaEs4VEV4UEJGanJ5NzJaVHk3dlFZSXJ3REdXblhrK09rTC9E?=
 =?utf-8?B?NjBYL2grb0VKb2VXUTZuUElUSE9zM0RJUkh1VU8zN1hhZTdTN0UyS1FOMHlE?=
 =?utf-8?B?OTA2V3BnekRvZVl0ZHBSUXp3YnBTQ3ZDZnM2dGRUS2ZUSU9nMFNiQzhsRFpk?=
 =?utf-8?B?NzF0MHRWcjFTaTVMVmJQeWFaOHR2ajNjY0trekR5MkVjcWw1NnN6MDhtaVo0?=
 =?utf-8?B?N0IvZEtUcldFRytMV2JJaVl3alpRUG4xSXN1OUprcWtFWEtpV3VWWkRpM1R6?=
 =?utf-8?B?RTQvZTluR0pQTFZ3UUgvbG5PcnpwU0pEWjhnUDMxcVdkN3BYekJVVDJVNlBp?=
 =?utf-8?B?Rkc1L282MWlyS0JXU3NUclFDL0JaYnAwMVJkYmhXZVJ5Skh4ZUtMTHJzTlo3?=
 =?utf-8?B?dkc2eW1pV1YzNXBSUlZlb1ovOUJjMnpjbGdtVXJPakIvanVXV0tPM1phNjF2?=
 =?utf-8?B?b2NwNDFrSVVDN2N3eUFPVTB6TFdBa042SmR5VzNaWTNzVTVHL0lqaDdPWng5?=
 =?utf-8?B?dmw3WVZwSE5xRlhlTU43Y0IzR3doZysrdUhrM0I5VmFZOFFYM2N0Y3VLMEtH?=
 =?utf-8?Q?0BpxFCzR963F6e/iKD417uyFJqczps=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVhIaGE5YVJpc0dOZFlBMUZNMkRieE9tNlRQRzBscUJKNjBtUWQySDBtZENn?=
 =?utf-8?B?N09IRHJTRGgxMUJ5SVBCdDNFV0hXRU54MXRmUU9mSTU2MGhPWFJVL2VOUVZZ?=
 =?utf-8?B?NnZneDRjYkF6b1JQcXVsOUZDSDYxRnY1Y2tYYkkwdlRteXJUS0swVU5PVVha?=
 =?utf-8?B?eE95VTZLb09sS3Bud0ZoV04xdlFvdlgySm8yQUxhQzZUdlRNczhkVFFsaVZl?=
 =?utf-8?B?ZE8rQ0kwYURCWG1FeVBvbXl0emIzdTZRNWRDYlRkV3Y4dFdvZDkvSExsajBP?=
 =?utf-8?B?eGpxM2gzU0RKWmROaE9TWHlEZVRSZXNjL2RCSWtiNG9SSGJGMmprTUMwZVpD?=
 =?utf-8?B?NWlDY3hPZkgwMGwrY01yTUtUdUVaeTZFbmhIYTFiSEw3N1hvemNqd003SFVE?=
 =?utf-8?B?ckFFMlJFWElqbzMwQ21BQnBvZm9GWG96dEdzaVFNZlpSWVBiUnhjNktwb3E2?=
 =?utf-8?B?L1pZSXhEc3JSMFJHMlhaRjkybDlORVA2QWtpbVNubUxFMmpIMkpLejJ6M0hT?=
 =?utf-8?B?Yi9DUk04MkJHU0VhWHVhYVZtZG00b2lYNk5UZ3pZZC9RQWhObnA0dkV2bmVT?=
 =?utf-8?B?blN4YzJhMkRySlRNVTQrWTk4UzhrbDk0ZXI0NHUwdjVFUVdaZ3BwRG00TDNp?=
 =?utf-8?B?dk1aOGNjQ3JCQ3dKZkp4QkFEK2FEbUFMQ25zTXo0UUV5dk5hZythNHdBUmhI?=
 =?utf-8?B?U3V4dE04d3RzRCtxVkwrSjlrM3lJaG5veEJybUNQVzdiSlNUQlBJN0cwcXBz?=
 =?utf-8?B?dmRyODN6bzZNR25NUmFlY2k5aTdyQWZsaWhSelBCTGVRYXpxRHdDK1F2a2Rr?=
 =?utf-8?B?NUo5c09DSW5EYk04MllFU3A2YXljSzc2ZGR1cXlVMWcwc2l6LzZhdGc4b0t2?=
 =?utf-8?B?WkM5dnZUYVROK2VCeVRHYlVOQ1F1MGVTaHZNWUZuWlRqK1djeW1hN1NQRjMy?=
 =?utf-8?B?ZDJFMmQzQ2VLWU5OM3RtcEFOZjlzQnFiYWR3RFpKa3hOMWxWTThsd0I3bTdq?=
 =?utf-8?B?Y05sangzNmJsRERxM2FZaDRhbHB0cCs5a04xWVBwN2c0dlFLOTZRc1pFR2Fl?=
 =?utf-8?B?THlKbWxXblJJY2ZHZkptV2k2OFUvVkUxM1c2VVRwREVIMWV4WmhwV0JjVEha?=
 =?utf-8?B?emthRWp2T2RHTm9NOVZodTd4V3Axbmt5N0hGUXpPTStWYnVhdTR0MTRYdmtj?=
 =?utf-8?B?RDVnTVpBcDN5SlE0NTJhai84ZjBwMVpZcnpXd1BVdnYyQkkrZDVGOWtFb3Ny?=
 =?utf-8?B?aWgwaFBkRWJOT00zVTV6K1dNTGdZVG9haGJXbEp3SUZPOEp5a1VhUEhSYnJU?=
 =?utf-8?B?bEtSa05qeTVNeTMrdmprcnpFbm9xWHpqM3RjN0w4alJSc0Z6L3VoU3Yyck9h?=
 =?utf-8?B?K2lhajJFbHBqOCt2OENkZWJYbWdFU0IrUFUrSlVMOUpWVU1NUjRudDlBNnls?=
 =?utf-8?B?NUdFM1NOZlNVcUgvRkdUTjVRNUF3cmRTMHgwMndScGIvSHZFUTc1VWlHNUU0?=
 =?utf-8?B?M0RVbDJHUGM0WWtMNXdBRnpycElTVUc0M2RwZUJ6ZlBEUG1OSWltV1p5OEZi?=
 =?utf-8?B?b1FZczJoVVpDUGZ3UHZlVlZuKzVRMXJLZ0MyZERWSU9hOW15dzFGTHoxU0lW?=
 =?utf-8?B?eDFGMXBTS2RyVlNkVU1ObXQzZ0RwenRFNXJBQW1NQXVVQ3dYQUtmeENWU0hs?=
 =?utf-8?B?cmlVb2MxYldiS2w5eUUweHJURm5telFDWVlIYVZWUElaTnlnQ2E2cHh5NnJL?=
 =?utf-8?B?T0F4elhqUnljRnJ5dG8xODkxZmduZlpDenc2YU03K0RnWmJ5S1BPZEhHQXhl?=
 =?utf-8?B?Znc2UXpOZTI0NGRwa0VYRG5YZjR2TU4zdjdzWFM5ZFN2Q1RTT0FNZy8zRnBO?=
 =?utf-8?B?M2RQcnJvSU5PdFdUTjNvd3dKSFBDQ0ZSQmh4T2FoWGlNYXkxV3EwU25TTDFI?=
 =?utf-8?B?TUphWnpobUlzVk5jdmMrVXdKWHhIL2hXTUZWMG52VWJuamFqaTBRZ1lCZXRX?=
 =?utf-8?B?N2ZqZkthTkM1TnNscnJHNTMyaWdlR2NHemExQ1BaZjN6bDlJWFdKU0ptVmxG?=
 =?utf-8?B?L1diT0VNcDhLV1FJTHFvZEU2a3RQZGtGaEh4SnREUTFlNjhGeDg4eDNkKzdE?=
 =?utf-8?Q?viokJBBiFjAYN3Y/CyFVxKhPA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d06214-2765-4bcc-07e0-08ddcf570066
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 10:51:13.2214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ivPLax7uvIeCVjLsZMc51qb8yCj46je3EfpMyD51Uon4Fxrbb7qzk7ScPh5ZMINDmxJZIp5Wy3IE1QN8FWLc56EsY9Mdx8Xlfvu9XTgKsfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB9519
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDIv
MjBdIGh3L3BjaTogSW50cm9kdWNlDQo+cGNpX2RldmljZV9nZXRfdmlvbW11X2NhcCgpDQo+DQo+
SGVsbG8gWmhlbnpob25nDQo+DQo+T24gNy8yOS8yNSAxMToyMCwgWmhlbnpob25nIER1YW4gd3Jv
dGU6DQo+PiBJbnRyb2R1Y2UgYSBuZXcgUENJSU9NTVVPcHMgb3B0aW9uYWwgY2FsbGJhY2ssIGdl
dF92aW9tbXVfY2FwKCkgd2hpY2gNCj4+IGFsbG93cyB0byByZXRyaWV2ZSBjYXBhYmlsaXRpZXMg
ZXhwb3NlZCBieSBhIHZJT01NVS4gVGhlIGZpcnN0IHBsYW5uZWQNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2SU9NTVUgZGV2aWNlDQo+DQo+ImRldmlj
ZSIgaXMgaW1wbGllZCwgYnV0IEkgZmluZCBpdCBlYXNpZXIgdG8gdW5kZXJzdGFuZCBpZiBpdCBp
cyBzdGF0ZWQNCj5vcGVubHkuDQoNCldpbGwgZG8uDQoNCj4NCj4+IGNhcGFiaWxpdHkgaXMgVklP
TU1VX0NBUF9IV19ORVNURUQgdGhhdCBhZHZlcnRpc2VzIHRoZSBzdXBwb3J0IG9mIEhXDQo+PiBu
ZXN0ZWQgc3RhZ2UgdHJhbnNsYXRpb24gc2NoZW1lLiBwY2lfZGV2aWNlX2dldF92aW9tbXVfY2Fw
IGlzIGEgd3JhcHBlcg0KPj4gdGhhdCBjYW4gYmUgY2FsbGVkIG9uIGEgUENJIGRldmljZSBwb3Rl
bnRpYWxseSBwcm90ZWN0ZWQgYnkgYSB2SU9NTVUuDQo+Pg0KPj4gZ2V0X3Zpb21tdV9jYXAoKSBp
cyBkZXNpZ25lZCB0byByZXR1cm4gNjRiaXQgYml0bWFwIG9mIHB1cmVseSBlbXVsYXRlZA0KPj4g
Y2FwYWJpbGl0aWVzIHdoaWNoIGFyZSBvbmx5IGRlcmVybWluZWQgYnkgdXNlcidzIGNvbmZpZ3Vy
YXRpb24sIG5vIGhvc3QNCj4NCj50eXBvOiBkZXRlcm1pbmVkDQoNCldpbGwgZml4Lg0KDQo+DQo+
PiBjYXBhYmlsaXRpZXMgaW52b2x2ZWQuIFJlYXNvbnMgYXJlOg0KPj4NCj4+IDEuIHRoZXJlIGNh
biBiZSBtb3JlIHRoYW4gb25lIGhvc3QgSU9NTVVzIHdpdGggZGlmZmVyZW50IGNhcGFiaWxpdGll
cw0KPg0KPiJob3N0IElPTU1VIGRldmljZXMiDQoNCldpbGwgZG8uDQoNCj4NCj5TdWNoIGFzIGlv
bW11ZmQgYW5kIFZGSU8gSU9NTVUgVHlwZTEgPw0KDQpOb3QgVkZJTyBpb21tdSBiYWNrZW5kLCBJ
IG1lYW4gaG9zdCBpb21tdSBoYXJkd2FyZSB1bml0cy4NCg0KPg0KPj4gMi4gdGhlcmUgY2FuIGFs
c28gYmUgbW9yZSB0aGFuIG9uZSB2SU9NTVVzIHdpdGggZGlmZmVyZW50IHVzZXINCj4+ICAgICBj
b25maWd1cmF0aW9uLCBlLmcuLCBhcm0gc21tdXYzLg0KPj4gMy4gVGhpcyBpcyBtaWdyYXRpb24g
ZnJpZW5kbHksIHJldHVybiB2YWx1ZSBpcyBjb25zaXN0ZW50IGJldHdlZW4gc291cmNlDQo+PiAg
ICAgYW5kIHRhcmdldC4NCj4+IDQuIEl0J3MgdG9vIGxhdGUgZm9yIFZGSU8gdG8gY2FsbCBnZXRf
dmlvbW11X2NhcCgpIGFmdGVyIHNldF9pb21tdV9kZXZpY2UoKQ0KPj4gICAgIGJlY2F1c2Ugd2Ug
bmVlZCBnZXRfdmlvbW11X2NhcCgpIHRvIGRldGVybWluZSBpZiBjcmVhdGluZyBuZXN0ZWQNCj5w
YXJlbnQNCj4+ICAgICBod3B0IG9yIG5vdCBhdCBhdHRhY2hpbmcgc3RhZ2UsIG1lYW53aGlsZSBo
aW9kIHJlYWxpemUgbmVlZHMNCj5pb21tdWZkLA0KPg0KPmhpb2QgLT4gImhvc3QgSU9NTVUgZGV2
aWNlIg0KDQpXaWxsIGRvLg0KDQo+DQo+PiAgICAgZGV2aWQgYW5kIGh3cHRfaWQgd2hpY2ggYXJl
IHJlYWR5IGFmdGVyIGF0dGFjaF9kZXZpY2UoKS4NCj4NCj5JIGZpbmQgdGhlIGFib3ZlIHNlbnRl
bmNlIGRpZmZpY3VsdCB0byB1bmRlcnN0YW5kLg0KDQpUaGlzIGlzIHRyeWluZyB0byBleHBsYWlu
IHRoZSByZWFzb24gb2Ygb3JkZXIgYmV0d2VlbiBhdHRhY2hfZGV2aWNlKCksIGdldF92aW9tbXVf
Y2FwKCkgYW5kIGhpb2QgcmVhbGl6aW5nLg0KV2hhdCBhYm91dDoNCg0KNC4gaG9zdCBJT01NVSBj
YXBhYmlsaXRpZXMgYXJlIHBhc3NlZCB0byB2SU9NTVUgdGhyb3VnaCBzZXRfaW9tbXVfZGV2aWNl
KCkNCiAgIGludGVyZmFjZSB3aGljaCBoYXZlIHRvIGJlIGFmdGVyIGF0dGFjaF9kZXZpY2UoKSwg
d2hlbiBnZXRfdmlvbW11X2NhcCgpDQogICBpcyBjYWxsZWQgaW4gYXR0YWNoX2RldmljZSgpLCB0
aGVyZSBpcyBubyB3YXkgZm9yIHZJT01NVSB0byBnZXQgaG9zdA0KICAgSU9NTVUgY2FwYWJpbGl0
aWVzIHlldCwgc28gb25seSBlbXVsYXRlZCBjYXBhYmlsaXRpZXMgY2FuIGJlIHJldHVybmVkLg0K
ICAgU2VlIGJlbG93IHNlcXVlbmNlOg0KDQogICAgIGF0dGFjaF9kZXZpY2UoKQ0KICAgICAgIGdl
dF92aW9tbXVfY2FwKCkNCiAgICAgICBjcmVhdGUgaHdwdA0KICAgICAuLi4NCiAgICAgdmZpb19k
ZXZpY2VfaGlvZF9jcmVhdGVfYW5kX3JlYWxpemUoKQ0KICAgICBzZXRfaW9tbXVfZGV2aWNlKGhp
b2QpDQoNCg0KPg0KPg0KPj4gICAgIFNlZSBiZWxvdyBzZXF1ZW5jZToNCj4+DQo+PiAgICAgICBh
dHRhY2hfZGV2aWNlKCkNCj4+ICAgICAgICAgZ2V0X3Zpb21tdV9jYXAoKQ0KPj4gICAgICAgICBj
cmVhdGUgaHdwdA0KPj4gICAgICAgLi4uDQo+PiAgICAgICBjcmVhdGUgaGlvZA0KPj4gICAgICAg
c2V0X2lvbW11X2RldmljZShoaW9kKQ0KPj4NCj4+IFN1Z2dlc3RlZC1ieTogWWkgTGl1IDx5aS5s
LmxpdUBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpo
b25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgIE1BSU5UQUlORVJTICAgICAgICAgIHwg
IDEgKw0KPj4gICBpbmNsdWRlL2h3L2lvbW11LmggICB8IDE3ICsrKysrKysrKysrKysrKysrDQo+
PiAgIGluY2x1ZGUvaHcvcGNpL3BjaS5oIHwgMjUgKysrKysrKysrKysrKysrKysrKysrKysrKw0K
Pj4gICBody9wY2kvcGNpLmMgICAgICAgICB8IDExICsrKysrKysrKysrDQo+PiAgIDQgZmlsZXMg
Y2hhbmdlZCwgNTQgaW5zZXJ0aW9ucygrKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVk
ZS9ody9pb21tdS5oDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5F
UlMNCj4+IGluZGV4IDM3ODc5YWI2NGUuLjg0MGNiMWU2MDQgMTAwNjQ0DQo+PiAtLS0gYS9NQUlO
VEFJTkVSUw0KPj4gKysrIGIvTUFJTlRBSU5FUlMNCj4+IEBAIC0yMzA0LDYgKzIzMDQsNyBAQCBG
OiBpbmNsdWRlL3N5c3RlbS9pb21tdWZkLmgNCj4+ICAgRjogYmFja2VuZHMvaG9zdF9pb21tdV9k
ZXZpY2UuYw0KPj4gICBGOiBpbmNsdWRlL3N5c3RlbS9ob3N0X2lvbW11X2RldmljZS5oDQo+PiAg
IEY6IGluY2x1ZGUvcWVtdS9jaGFyZGV2X29wZW4uaA0KPj4gK0Y6IGluY2x1ZGUvaHcvaW9tbXUu
aA0KPj4gICBGOiB1dGlsL2NoYXJkZXZfb3Blbi5jDQo+PiAgIEY6IGRvY3MvZGV2ZWwvdmZpby1p
b21tdWZkLnJzdA0KPj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2lvbW11LmggYi9pbmNs
dWRlL2h3L2lvbW11LmgNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAw
MDAwLi4wMjFkYjUwZGI1DQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9pbmNsdWRlL2h3L2lv
bW11LmgNCj4+IEBAIC0wLDAgKzEsMTcgQEANCj4+ICsvKg0KPj4gKyAqIEdlbmVyYWwgdklPTU1V
IGNhcGFiaWxpdGllcywgZmxhZ3MsIGV0Yw0KPj4gKyAqDQo+PiArICogQ29weXJpZ2h0IChDKSAy
MDI1IEludGVsIENvcnBvcmF0aW9uLg0KPj4gKyAqDQo+PiArICogU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXINCj4+ICsgKi8NCj4+ICsNCj4+ICsjaWZuZGVmIEhXX0lP
TU1VX0gNCj4+ICsjZGVmaW5lIEhXX0lPTU1VX0gNCj4+ICsNCj4+ICtlbnVtIHsNCj4+ICsgICAg
LyogaGFyZHdhcmUgbmVzdGVkIHN0YWdlLTEgcGFnZSB0YWJsZSBzdXBwb3J0ICovDQo+PiArICAg
IFZJT01NVV9DQVBfSFdfTkVTVEVEID0gQklUX1VMTCgwKSwNCj4+ICt9Ow0KPj4gKw0KPj4gKyNl
bmRpZiAvKiBIV19JT01NVV9IICovDQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9wY2kvcGNp
LmggYi9pbmNsdWRlL2h3L3BjaS9wY2kuaA0KPj4gaW5kZXggNmI3ZDNhYzhhMy4uZDg5YWVmYzAz
MCAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvaHcvcGNpL3BjaS5oDQo+PiArKysgYi9pbmNsdWRl
L2h3L3BjaS9wY2kuaA0KPj4gQEAgLTQ2Miw2ICs0NjIsMjEgQEAgdHlwZWRlZiBzdHJ1Y3QgUENJ
SU9NTVVPcHMgew0KPj4gICAgICAgICogQGRldmZuOiBkZXZpY2UgYW5kIGZ1bmN0aW9uIG51bWJl
ciBvZiB0aGUgUENJIGRldmljZS4NCj4+ICAgICAgICAqLw0KPj4gICAgICAgdm9pZCAoKnVuc2V0
X2lvbW11X2RldmljZSkoUENJQnVzICpidXMsIHZvaWQgKm9wYXF1ZSwgaW50IGRldmZuKTsNCj4+
ICsgICAgLyoqDQo+PiArICAgICAqIEBnZXRfdmlvbW11X2NhcDogZ2V0IHZJT01NVSBjYXBhYmls
aXRpZXMNCj4+ICsgICAgICoNCj4+ICsgICAgICogT3B0aW9uYWwgY2FsbGJhY2ssIGlmIG5vdCBp
bXBsZW1lbnRlZCwgdGhlbiB2SU9NTVUgZG9lc24ndA0KPj4gKyAgICAgKiBzdXBwb3J0IGV4cG9z
aW5nIGNhcGFiaWxpdGllcyB0byBvdGhlciBzdWJzeXN0ZW0sIGUuZy4sIFZGSU8uDQo+PiArICAg
ICAqIHZJT01NVSBjYW4gY2hvb3NlIHdoaWNoIGNhcGFiaWxpdGllcyB0byBleHBvc2UuDQo+PiAr
ICAgICAqDQo+PiArICAgICAqIEBvcGFxdWU6IHRoZSBkYXRhIHBhc3NlZCB0byBwY2lfc2V0dXBf
aW9tbXUoKS4NCj4+ICsgICAgICoNCj4+ICsgICAgICogUmV0dXJuczogNjRiaXQgYml0bWFwIHdp
dGggZWFjaCBiaXQgcmVwcmVzZW50cyBhIGNhcGFiaWxpdHkNCj5lbXVsYXRlZCBieQ0KPj4gKyAg
ICAgKiBWSU9NTVVfQ0FQXyogaW4gaW5jbHVkZS9ody9pb21tdS5oLCB0aGVzZSBjYXBhYmlsaXRp
ZXMgYXJlDQo+dGhlb3JldGljYWwNCj4+ICsgICAgICogd2hpY2ggYXJlIG9ubHkgZGV0ZXJtaW5l
ZCBieSB1c2VyJ3MgY29uZmlndXJhdGlvbiBhbmQNCj5pbmRlcGVuZGVudCBvbiB0aGUNCj4NCj5X
aGF0IGlzIG1lYW50IGJ5ICJ1c2VyJ3MgY29uZmlndXJhdGlvbiIgPyB0aGUgdklPTU1VIGRldmlj
ZSBwcm9wZXJ0aWVzID8NCg0KWWVzLCBJIG1lYW4gdXNlcidzIHFlbXUgY21kbGluZSBjb25maWd1
cmF0aW9uLg0KDQo+DQo+PiArICAgICAqIGFjdHVhbCBob3N0IGNhcGFiaWxpdGllcyB0aGV5IG1h
eSBkZXBlbmQgb24uDQo+PiArICAgICAqLw0KPj4gKyAgICB1aW50NjRfdCAoKmdldF92aW9tbXVf
Y2FwKSh2b2lkICpvcGFxdWUpOw0KPj4gICAgICAgLyoqDQo+PiAgICAgICAgKiBAZ2V0X2lvdGxi
X2luZm86IGdldCBwcm9wZXJ0aWVzIHJlcXVpcmVkIHRvIGluaXRpYWxpemUgYSBkZXZpY2UNCj5J
T1RMQi4NCj4+ICAgICAgICAqDQo+PiBAQCAtNjQyLDYgKzY1NywxNiBAQCBib29sIHBjaV9kZXZp
Y2Vfc2V0X2lvbW11X2RldmljZShQQ0lEZXZpY2UNCj4qZGV2LCBIb3N0SU9NTVVEZXZpY2UgKmhp
b2QsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCk7
DQo+PiAgIHZvaWQgcGNpX2RldmljZV91bnNldF9pb21tdV9kZXZpY2UoUENJRGV2aWNlICpkZXYp
Ow0KPj4NCj4+ICsvKioNCj4+ICsgKiBwY2lfZGV2aWNlX2dldF92aW9tbXVfY2FwOiBnZXQgdklP
TU1VIGNhcGFiaWxpdGllcy4NCj4+ICsgKg0KPj4gKyAqIFJldHVybnMgYSA2NGJpdCBiaXRtYXAg
d2l0aCBlYWNoIGJpdCByZXByZXNlbnRzIGEgdklPTU1VIGV4cG9zZWQNCj4+ICsgKiBjYXBhYmls
aXR5LCAwIGlmIHZJT01NVSBkb2Vzbid0IHN1cHBvcnQgZXNwb3NpbmcgY2FwYWJpbGl0aWVzLg0K
Pg0KPmV4cG9zaW5nDQoNCldpbGwgZml4Lg0KDQpUaGFua3MNClpoZW56aG9uZw0K

