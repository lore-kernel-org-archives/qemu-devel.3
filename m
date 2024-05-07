Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCE4C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 06:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4EFq-0005nx-Hd; Tue, 07 May 2024 02:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4EFp-0005nk-12
 for qemu-devel@nongnu.org; Tue, 07 May 2024 02:24:45 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4EFm-0004Om-W7
 for qemu-devel@nongnu.org; Tue, 07 May 2024 02:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715063083; x=1746599083;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UOPIrGm9cz5fBvPLjjdIUb5sEywRpamaI2jt1tU+cxw=;
 b=LSwA0w4L4XXI1A787WtUOPb8KRkK6vAScnNx3fL5U02P7hGGxKv0B20m
 3jhk3Kcr0y216CL3R0OHTeiDp0kBiTM4ygxeelWZEIya3t5vfKUYNpGVi
 U7ZaStiP8cBXBMKfMtYtKu9hn6LMmu/hMEtJ2pSKHV68NecmicDH+RqC9
 MHmV6j4MgSTIm7TiKvOqNI5HwVIHYGMQqftXWUnbDGZvbMhyWp4iS3/Sx
 aQBaeDwws/MHmH57ujGwh52iJnBBN553WSM/E0pNx6GdxlvsmipmL5DEg
 0SdeHsZV7oeOlqI8PUb3JvNR7Oy00Re8uN3X7OFS0EosI/k8HGiCqAwV7 A==;
X-CSE-ConnectionGUID: KioR040mRE6+jr/T9h01Kw==
X-CSE-MsgGUID: IAaXJ2c9Qcq/m2LwGawZ/w==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10673454"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="10673454"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 23:24:36 -0700
X-CSE-ConnectionGUID: 8fieha6rRnCBhWHR7PMVYg==
X-CSE-MsgGUID: NwZemxIlSEunTl9VqtWZdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="33082919"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 06 May 2024 23:24:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 23:24:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 23:24:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 6 May 2024 23:24:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 23:24:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmxBFrMX5N+x8OlccNrSmXc1pNEUTAZyIMAQILKVW3aNvzjp/1A0kRC8PB0es2x/GLp1MwcVrQyAYqqTjd7ergvBhR1JL7AXRP1I7nwYHLSO7vRmUVFFw76y2yUIl2xgp6W5G2hdRSXj47L2orBvmJxXVQQV8uYGJ5ntxualuZ+w8a6+6bUZM9jSr3pw89M+30qoxkHxVxny7D7D4yNCpM2Lee5xPWZ8sdaI8C74sRU5+6PkjFidIWkhKlS/JyirLPEdvVco1UjPIF+QioDQ9ckPj5XoOp+yHE3J2ztKHX7HeQktC4Ws90Xez0lCzPvZra3WQEo9NoHZYJPl7q9dIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOPIrGm9cz5fBvPLjjdIUb5sEywRpamaI2jt1tU+cxw=;
 b=GR/LvJowZ5oxiAmXkDeMXAbw6zwCmT6INQdhC68AlmiE5ugaxe5+xjjaVTlra1aV6Zoh0IHmrZ2DFAKFIOTOZ5CLw0UoWTQUfAAdqHj1pY1kYMXPQ7ufCye7pud9z+IVoELzSqCkNzaHEa6xzqGkhhnSE9Ebl84DYzFChmTfSMmscUYrW9zhhCjPCTchiTDenh/KKHMAX32rRf1A1nNIrCPnzG2y5zjFjcOQnyJtjBtjJSKzUynz4xRiUqD8ezADJQ9mujxRdut7Ft8bYa+4erJdIPrsbsujKqIrUzs8A2lFakhQLSL7gk4VfxJm+T4JgBOoIJmyksj4O6q0vbFj8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by LV3PR11MB8694.namprd11.prod.outlook.com (2603:10b6:408:21b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 06:24:32 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 06:24:32 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 05/19] backends/host_iommu_device: Introduce
 HostIOMMUDeviceCaps
Thread-Topic: [PATCH v3 05/19] backends/host_iommu_device: Introduce
 HostIOMMUDeviceCaps
Thread-Index: AQHamgIP5dlYY8RorUiCu4lRxYlSdLGLVrgAgAADkzA=
Date: Tue, 7 May 2024 06:24:32 +0000
Message-ID: <SJ0PR11MB6744F3C5D0BA44017DBD675A92E42@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <20240429065046.3688701-6-zhenzhong.duan@intel.com>
 <462b4000-888b-4f89-bb0d-0cdbc0496a02@redhat.com>
In-Reply-To: <462b4000-888b-4f89-bb0d-0cdbc0496a02@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|LV3PR11MB8694:EE_
x-ms-office365-filtering-correlation-id: 4c056761-6540-474a-914f-08dc6e5e5bd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|376005|7416005|1800799015|366007|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?ZUdOemxDbkZabDJZeEFaTlZ0S0RXWHhFeDRoVXh0Y1ZjeS9kSWIyek1kM09j?=
 =?utf-8?B?R1Y2ZkYrY0o3aENqWHhYVHJJUHdSRGxZbERPVVYyc0pMdW5GYzZkV01GMmk4?=
 =?utf-8?B?Yi9oOVc3KzNadkdPSG9kYWdvNWYwL3dMMnovamJzNkp5UlNnSndpa29EaWpR?=
 =?utf-8?B?c0FGU2s1ZHRCVkJEcjVydWpmNkxVTlZHalZNL2xkWDZ0Y0U4RXkwam1wV29U?=
 =?utf-8?B?YWk4OERwYkVIcnpqbDl3WElGbDEvWS9VcW0wUm1EZHAxQ0JPTHo5a0J0YmVG?=
 =?utf-8?B?UjdnTURRRkNPTlhiNTNqRlNhMC90eE9CdUEzQXprMXRZdjhCWHhNK1c5dDhm?=
 =?utf-8?B?eUttOG5PSVpGUzlRQUdORkpLT1EzTU1SNXhRTE1CdGVoR1F0SkdNY0YraDBi?=
 =?utf-8?B?RmRZOXV3WGJSckZmSFZ6czNIM2h4SEQ2TnU5YXlpdnQ2OGtobm4zR0V5YWd0?=
 =?utf-8?B?aWJFL3V2K3VvQlVBSlFWRy8rZmQ1bUR3bW1TbmN4YlRSTnYvbE5yaE5yRVF4?=
 =?utf-8?B?V2lCOHUxVlFtdzA1dVRwdTl0aHY5OFRxdnNTUlRneWhsVGpSZStPKzFMOGVX?=
 =?utf-8?B?dUdSYzd0NVdTYUo5UEYzMll1V0J4eCswdXlFUWh1K24xclhtQkY0aklkWlNr?=
 =?utf-8?B?T2swU0dvWnN6YkN5M1YrZkc0NlgyNHdjUWVzampXS1pTZVlOWEVxemMwNGQv?=
 =?utf-8?B?Ky9GNVpHMWdsd2loRVBIWnlsM1dyN1ZMeWpWa2JGWUs4WWxWNEFaK2pucW10?=
 =?utf-8?B?L0pHelFZTVNRdjJEYVk0UzM1MDhPZENMYTV3eng4cTd0WXNxSVQrcWZZZVhF?=
 =?utf-8?B?Zit2KzhwaWVaU1Z4VFo4NzVLSFpJeXFJUjFPMmFYSjVhVEF3clZDZ1YrdXRM?=
 =?utf-8?B?dFd6Y1NxK0RqaE9iZmRNbU1lMk9PM3hiVzBNSEhNZXhaZjlkbllSSTlOazNK?=
 =?utf-8?B?RXdvTVdoY2hMUjhSWVFIQzhMemJlMUp3Ni9aTHZjZHNlbWZSR0dFTXAxOVEr?=
 =?utf-8?B?Q0R5UFNVSmhXVGQ0RHREbU5aUUg5bFdweUNwamVKWnUyTlhQaXBJNlNmbWdT?=
 =?utf-8?B?bkNFckdHUmVDMnovMms3U2xSdjUzNjFDUkNiejQwTVNpWkJHQzNXcXlDeWZO?=
 =?utf-8?B?cWJIN3lhOHRsajFZTGhjYjBqUmYvd1lxY25UOXNmd3FhVW1OV21uYUhHZ0Ft?=
 =?utf-8?B?WjY4STlSWitmSlJldUlPbzVLV3FHN2NFMEt2N2xkbENOakxFeXFlZDh6NzBv?=
 =?utf-8?B?eXh5M0dkTXltOVFlTUNLRFBpaW8xMG5FeDhGN2VhVWNqMHY5WXJpV295SkFp?=
 =?utf-8?B?ZUIvVEoweXVtMSsrS3pFcFl3TFFOWmhBdFp5ckExNlVXeWZQT2Q3TnlKNmtm?=
 =?utf-8?B?YUNrSnJnSEsyVVRHL25Tc3ZENU9JdVI2R24zUlpqeGNobi8wRHFjbFNCWGhQ?=
 =?utf-8?B?eGZUQis1dktweDEzK2E2SkRQL2VKZW1yQzZJUm9KdXlHMHFzbEYrY0d0eWVR?=
 =?utf-8?B?QlhOdnAyOVQyaEdkNnFpWjVsVmtJdk53NFJGbnd3MWtuTVg2YmwxQnd4T3Ex?=
 =?utf-8?B?VzdhRE1IdXNWNVYrTzIxN3VoRzZ2cEdJYlBSZmZ3WFJCUzNYUG14VGFhT0Rh?=
 =?utf-8?B?bWNFSVF6SHNXY01rbk0xT0c1QVJvN1owMUk0MlN2YklhMmNIWjBnazNxRXZ2?=
 =?utf-8?B?M3RGaXZqUkRCSkkwclVnbEdoL2g4VGZ0c0dWTTZOcXQwWEFQNnF2eDVsU3Za?=
 =?utf-8?B?MXd6TFVWaEJFaHhmRU9xZHlSWm13bjZuQ2haQTVHZU82RFdwWkhjR1h1STkz?=
 =?utf-8?B?V1lEZUNGWFp1ekloaVlndz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OW5oUllDWStITFhiZW5vSlVsYzUzRmNWOC9DUEgzRjl6NThCUGRvUDhEY1VC?=
 =?utf-8?B?L3F1c2dNWmFZQ1RuZUZmNHdvY0h3ZHcxaDNJWnJwRk1Ka3o3Tko4bTJ0QkM2?=
 =?utf-8?B?RnN3RWJoeEliS2NDdS93WUhGTlFvd21zM05YMnBwZDBYR0E1ZG5FcTRIVURN?=
 =?utf-8?B?SE5lU0lGRlljc3ZYUGJPMytTZm1qL3FEeTd3a09ZQ3lvR3g0cVpDalA3ak92?=
 =?utf-8?B?bFVJSXNsTDZmSXgwelJiTC91QUhibzBxMDJPTWttVWxXcGYvM0MwQmY2STNQ?=
 =?utf-8?B?RXRnYWJQTVZlVXJTY3JqODU5NDIrYVlaOEVPYnBEVmJoQjFyQU5NdHJtNzJD?=
 =?utf-8?B?TTJpL3pIMUhCSFgzcFBEdi9MR1BkS29wa3owSnBqNEN2Vm9WdGdlNElvdmxT?=
 =?utf-8?B?M3dGZlR1ZlpWeEIvakNNNVMyRlA1RXpVdlZjV2RDQzJib1Z6b2JkSmpWcklV?=
 =?utf-8?B?bndWRVplSkROeW1IU0J3UnRLK1pMUHowR1lsdjNQRTJqUDhuaGg3emJRWG0z?=
 =?utf-8?B?MHZmQ05PSnIycjRlQ1JPYU42U3lMQ3ovK250RjFlNDU4TUl1ZldzUXBuRUkx?=
 =?utf-8?B?K2tTMkQ2MkdnOGg5UCtuS1hmbzMzN2pvSFFrTnEzRkVQZ1pzeFJCc0pRR0xB?=
 =?utf-8?B?K0FQcVB5U2xrU09MK1I1Zm10SDN3MXkxLzV5Nk8xZzBBU01OdEpuVGFhMzI2?=
 =?utf-8?B?WU5ycEVFNVVSYWlobmlYRWJVS256ZUl1cThpM1BXajNhR2p1MVpnRnd3bE53?=
 =?utf-8?B?aURReGpoaHBVWWtPdkdZVnNoakZxOWQ5UzZEbHYvVy85cmxSZ3RkK2xvaEdK?=
 =?utf-8?B?THZDMlMyYVQxRHE4aEpRajNiTnFKdzVqemdiZUFzeVdqT2xGMUR3eVpUOUhu?=
 =?utf-8?B?eUJHalQzUUVHck9Sd2VXTDRMQTllYVdBT2xic1NrZk02U0h3VkJGK093M1pz?=
 =?utf-8?B?dlpLM3hiV2lKVyt0OVE2Nzd5K3VyazlHMEJrbU04YUNMRDJzem1lL0RWelgx?=
 =?utf-8?B?Y0Q0U0VTQXFZUEQ2TUV2YzN2QjhpTDJFb3NqcHFnRllMVmVTMUVMK0RURXNU?=
 =?utf-8?B?MVFhSUE4eTJDaDhaVUtYbTM3aWdpbmlpYlI2VE1GWVZFcWJTK3hNTk1TUEVK?=
 =?utf-8?B?Y043d1pLQTNqaGRjUHpxQWdOZ3FhdTJDTW11NUU3aVBVRUI1Vnl1OXlmSW5R?=
 =?utf-8?B?VUgvaDFORFpBUkNQWWk0V09va0pnNGpoQ09RL1plOHBpUnpKSVNJNzJPQXBu?=
 =?utf-8?B?UkI1SlgyaU9idllRWWd1QVVTUnRST1JhYnFKUDF6MzhFb0FaQUJNdkJqQVRT?=
 =?utf-8?B?RXU3UWM2dkZkZElNZjRWU0Q4ZWZDZ2g4YkV6VittQ0M3WEl0QTB5Z1hqTWVi?=
 =?utf-8?B?Ukh3WkFSaFZmZm1sdGNwUE9OWTBwKzBxWXFIRDdHSmNpMU1YOWFnZSszbVBu?=
 =?utf-8?B?bWM4cFVoM2NTYTZxMkNFSEdnblhpUTVBU2hycjJFRkNyaUN1R3JJRFQvd2pw?=
 =?utf-8?B?b0NJK1M1OEZOVzJ1RnhQOFdBUEprMm1wbFZrbktLRFJ5ckRYWnJpdWJYNldy?=
 =?utf-8?B?S1N3bHZ2ODBuREhOc3RqSmNXanVWaHRJSUxEMzNzTFhIWUtlWll1bVNXNHYz?=
 =?utf-8?B?cVZkN0wxWkJmYlVPaW4wVHBEbzFEeFZNMXdTMEpScjJSc01lQ2h6dWM5Q1c0?=
 =?utf-8?B?bnNjcHdBNTBFaFpsdVRVbFA2YzNtaW1iWlNFVkxHRWdTbGYzNVNhSGMwT0hZ?=
 =?utf-8?B?NnhOdk95Y2ppdmVyNTVySkpSdGEyc0xBSGwzT2ZRTDJPcTlBWHJsR1BRMi9r?=
 =?utf-8?B?M0VwUE5CSTQrRjFLa29iVnIzZ3FobTV4Y0h0TmMvNVU2Mk15VGdxWEw5ek96?=
 =?utf-8?B?TTd4Zk1tNitiTWNoU3h1dFFkb2Z4V2pCWXVyMHUwK1Y0enJtNFhscnB0UmZE?=
 =?utf-8?B?WkNyaDduNkZSc3lyMU5MNGJka1ZOZXlSRXJNNTIyYjRqcURpYlVhL0RMYVNE?=
 =?utf-8?B?SWg0NWh2WHFySVdpYXRZMDMrS1hhMHM1eGJvRVhScDRLT0taSHJGaHNML0J5?=
 =?utf-8?B?dnlLUzN4SCtnUWc3dTE1Q1VJTG5uREpFZ0ZBQzhSWTBIR0xDMEtMeEdPdFRI?=
 =?utf-8?Q?ZsaB+DPbB93GiDrIZRIZYzCzY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c056761-6540-474a-914f-08dc6e5e5bd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 06:24:32.6418 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hE9c9ozC/A2MuAitX/zyhAsTyHh0x0eesgd7IHYYq1M6Y3QpQV4+R2ck06craIbMxrqHthS2y8Oe0H71WnawVWM+6KcggdTACIqY1siml4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8694
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDA1LzE5XSBiYWNrZW5k
cy9ob3N0X2lvbW11X2RldmljZTogSW50cm9kdWNlDQo+SG9zdElPTU1VRGV2aWNlQ2Fwcw0KPg0K
PkhlbGxvIFpoZW56aG9uZywNCj4NCj5PbiA0LzI5LzI0IDA4OjUwLCBaaGVuemhvbmcgRHVhbiB3
cm90ZToNCj4+IEhvc3RJT01NVURldmljZUNhcHMncyBlbGVtZW50cyBtYXAgdG8gdGhlIGhvc3Qg
SU9NTVUncyBjYXBhYmlsaXRpZXMuDQo+PiBEaWZmZXJlbnQgcGxhdGZvcm0gSU9NTVUgY2FuIHN1
cHBvcnQgZGlmZmVyZW50IGVsZW1lbnRzLg0KPj4NCj4+IEN1cnJlbnRseSBvbmx5IHR3byBlbGVt
ZW50cywgdHlwZSBhbmQgYXdfYml0cywgdHlwZSBoaW50cyB0aGUgaG9zdA0KPj4gcGxhdGZvcm0g
SU9NTVUgdHlwZSwgaS5lLiwgSU5URUwgdnRkLCBBUk0gc21tdSwgZXRjOyBhd19iaXRzIGhpbnRz
DQo+PiBob3N0IElPTU1VIGFkZHJlc3Mgd2lkdGguDQo+Pg0KPj4gSW50cm9kdWNlIC5jaGVja19j
YXAoKSBoYW5kbGVyIHRvIGNoZWNrIGlmDQo+SE9TVF9JT01NVV9ERVZJQ0VfQ0FQX1hYWA0KPj4g
aXMgc3VwcG9ydGVkLg0KPj4NCj4+IEludHJvZHVjZSBhIEhvc3RJT01NVURldmljZSBBUEkgaG9z
dF9pb21tdV9kZXZpY2VfY2hlY2tfY2FwKCkNCj53aGljaA0KPj4gaXMgYSB3cmFwcGVyIG9mIC5j
aGVja19jYXAoKS4NCj4+DQo+PiBJbnRyb2R1Y2UgYSBIb3N0SU9NTVVEZXZpY2UgQVBJDQo+aG9z
dF9pb21tdV9kZXZpY2VfY2hlY2tfY2FwX2NvbW1vbigpDQo+PiB0byBjaGVjayBjb21tb24gY2Fw
YWJhbGl0aWVzIG9mIGRpZmZlcmVudCBob3N0IHBsYXRmb3JtIElPTU1Vcy4NCj4+DQo+PiBTdWdn
ZXN0ZWQtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4+IFNpZ25lZC1v
ZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0N
Cj4+ICAgaW5jbHVkZS9zeXNlbXUvaG9zdF9pb21tdV9kZXZpY2UuaCB8IDQ0DQo+KysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+PiAgIGJhY2tlbmRzL2hvc3RfaW9tbXVfZGV2aWNlLmMg
ICAgICAgfCAyOSArKysrKysrKysrKysrKysrKysrKw0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDcz
IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zeXNlbXUvaG9zdF9p
b21tdV9kZXZpY2UuaA0KPmIvaW5jbHVkZS9zeXNlbXUvaG9zdF9pb21tdV9kZXZpY2UuaA0KPj4g
aW5kZXggMmI1OGE5NGQ2Mi4uMTJiNmFmYjQ2MyAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvc3lz
ZW11L2hvc3RfaW9tbXVfZGV2aWNlLmgNCj4+ICsrKyBiL2luY2x1ZGUvc3lzZW11L2hvc3RfaW9t
bXVfZGV2aWNlLmgNCj4+IEBAIC0xNCwxMiArMTQsMjcgQEANCj4+DQo+PiAgICNpbmNsdWRlICJx
b20vb2JqZWN0LmgiDQo+PiAgICNpbmNsdWRlICJxYXBpL2Vycm9yLmgiDQo+PiArI2luY2x1ZGUg
ImxpbnV4L2lvbW11ZmQuaCINCj4NCj4NCj5QbGVhc2UgdXNlIGluc3RlYWQgOg0KPg0KPiAgICAj
aW5jbHVkZSA8bGludXgvaW9tbXVmZC5oPg0KDQpHb3QgaXQuDQoNClRoYW5rcw0KWmhlbnpob25n
DQo=

