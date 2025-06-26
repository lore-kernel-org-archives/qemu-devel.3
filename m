Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB53C7EE33
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 09:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUj7f-0006kK-1q; Thu, 26 Jun 2025 05:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uUj7d-0006jx-Iv
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 05:42:21 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uUj7a-0007oq-GK
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 05:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750930938; x=1782466938;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2q9YP7Jj7LR/UUYPmYbglbjO7G43mcCSFL0GxZLA/rA=;
 b=gek5fuo/oL85L35gTbdkJXrr0NQg/jNbMuvOqJ2UrHsNZPLXGeg7moXL
 LE1fhplMJ2yFFQ75BdfTeKnbFNbeQXDYkDdT5GHFLuUFLy4lTI/ommoRV
 lPf/LfWTvtDytx4+I4oFr2vb3rmjqrr84btGbJN4ui/uj+0UW61ytioL1
 L4870Xfyyaf89mbrD3wcnQvxyx/at/VKCbs+6SVWIFkRVRIgNaiCGtA5B
 5SzusYKjMIUe+a2QchW/kv49Vt/iJVmhwu2fM/9gbQzdNqGz82hTHKShE
 BQ+hxPm7HiE9Di0s0PCMtfq9YKBshbBTpK+gEAS8VTHp+EjKOYvnU8lUr Q==;
X-CSE-ConnectionGUID: R2WHKnJ5SPKdSpJCrijwgQ==
X-CSE-MsgGUID: /+nSXb3tS9yjB1qDeza/QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="53292613"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="53292613"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 02:42:15 -0700
X-CSE-ConnectionGUID: aPfU1k1FRZac0G7yN4Ae7Q==
X-CSE-MsgGUID: uVKDSy6rRualA3On7BxONw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="176134638"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 02:42:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 02:42:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 26 Jun 2025 02:42:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.80) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 02:42:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuK/ggOQWUBPNxgwaBJaPzyjFiCvSjm9Dw3K8xJDyD4A4wsUhoU9yn+FCapXodfKV/pzJ1qF4Ge0TXTWkT0Xwk+j4JVu6L2Sw/bnWVtkmGfMsyQv+B9n/FEUrpSrse1ljzwdM7WiEwf1X0satPS1G3+fQ5AvVqEZMnBwNXFd3AcYt+52xqIt75IvvIdAHNgvVhiopz23SBW7aPu/m0DV0+vQiW1YyA9OSf5VLaDKxPsep7h7Lp1X7wPjQ1slWxvxLuPQWsbTbdlvZRblx79f1Oj9xZayH23OgWTBFMLq2OqUG8jNR5+9Zt+stvEXTkPs8RD5GoRhQtUhC9KKMw+iNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2q9YP7Jj7LR/UUYPmYbglbjO7G43mcCSFL0GxZLA/rA=;
 b=LpQQBYMPomZrxAy/jqCdRH//Bq9Jtr89yWmSdy/EbGfyw9DNtC46nmi+7dSQAR872AtDYYsiPvEsg52stKNlSzul7HbHeQGmXbfsRCNqH1aY4o7dLtT8h7CvzefrFIRdib71rntlXJGDmmThWo8NCgljAZT5S9oztV8eyFmcqoFxsvPVoZfwW4XKlAEat5/FqiD7qw/3TqVT3Fwi1pigAgteVsG9AMYSfZ2mrKBIHnhZqX9Um8R4CDyFdpxk9wLwEvPZmexnDuvTKitWEqtauwYrLVRsj5UjhLH/31sHVLbu5cK/SaForjTpA8w+lrbr9WvD7Y2iX1f8h+/1+e7VHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by MN2PR11MB4614.namprd11.prod.outlook.com (2603:10b6:208:268::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.35; Thu, 26 Jun
 2025 09:42:06 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Thu, 26 Jun 2025
 09:42:06 +0000
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
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Yi
 Sun" <yi.y.sun@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v2 16/19] intel_iommu: Propagate PASID-based iotlb
 invalidation to host
Thread-Topic: [PATCH v2 16/19] intel_iommu: Propagate PASID-based iotlb
 invalidation to host
Thread-Index: AQHb4bQ90sj6oYBKNkSLfuNXey1ID7QQxaWAgARzTHA=
Date: Thu, 26 Jun 2025 09:42:06 +0000
Message-ID: <IA3PR11MB9136E15C48AC09B056199E68927AA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-17-zhenzhong.duan@intel.com>
 <f38345e6-701f-4a10-9505-7f5bfb0a9b91@redhat.com>
In-Reply-To: <f38345e6-701f-4a10-9505-7f5bfb0a9b91@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|MN2PR11MB4614:EE_
x-ms-office365-filtering-correlation-id: 544db0ee-fbdb-4891-8feb-08ddb495b68a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZnFRa1dWZmxUci9PbHFqckxZeU5BR0d6bGs4SGlLMDY1Q1BBQ1BsQWRJUmw3?=
 =?utf-8?B?N1ZwNGlCQnBmUGpWOVBvZGIvUFZBZkJmaVRjc2ZZaFI2ZkFaMmt2aVZWU2ls?=
 =?utf-8?B?U24vV2lWZnBzdmhiWXlZUks2UGVuK1RsQVZQSjBSTFY3UFNsNDZIZHpwczB2?=
 =?utf-8?B?M0VxbHJsTFZ0UHA3S2YwMW5SMXZkbkUrdTdhTlk5YkZnZDVPamdiNytIbFJI?=
 =?utf-8?B?VDdlcHl2SkhjOGNqQnRFUy9GZzREREFrb1IzS1VoVnorMmdGZmZOMEd2eU5t?=
 =?utf-8?B?RUxvM1ZDanloNTRlYTVVR2ZsTnRBVXNWSm5IWWxjVVhtY1pTSktZUXVFdHpN?=
 =?utf-8?B?SDdqVG1hWkhlcUlmYU9Pejk0QS9QL3ZFQmlKZEUyRTRxSEZaZmFlVllsbkpo?=
 =?utf-8?B?Z2RSOXorUERNaDM3R1N4djNqS0VmaXhJRFppUGtxeDNjUjU5WnVmNVNqWTVu?=
 =?utf-8?B?KzNOUEV4MXN5c3dBZEd2YXRVUlpEUy9VUmhRY1dWZ0ZvemdkM291QUl2NVda?=
 =?utf-8?B?c25NaTk4dUtUa00xeGtvVjRIaXNVY0dOSXBwT0hkTkdnZi9zS0VCRFhjV0pq?=
 =?utf-8?B?eUE1WFlzTXNGRnBmeWE1WUhYcFZISTBXVTgxOW5TZ3pINmwwWUxuaE56ZFl2?=
 =?utf-8?B?ekErdG1tYXFYTTdPeHRIT0RoeEZOcmpyTjRITlRKY2ZJd1c5R0tIVkVWQkdX?=
 =?utf-8?B?NVI1NGIvOWZUUEtlTUs5NytSckJRWmhSVkZ0SFR0dUFPN3VCUnRKeFVNYUJq?=
 =?utf-8?B?MUpqL0tLclVXYWZPNUVyU3EzWUhJdTVYL2pSSDZqL0ZHcEVUOHl1QlFYelRP?=
 =?utf-8?B?UDRhWTRwL0J5UVVTSldWcmk3UDZ4Q3RTUm53QS95ZnpVTmR6NDFvOXpNQkdD?=
 =?utf-8?B?dzV1Z1RDeDRaZXZLNS9WVk9DNDBGY2VvUGxnV2ZndTE0MU9CYTNsc01FbGtS?=
 =?utf-8?B?NWdBeXBzbTEwUlMwekJlNG5rWHIwbytuN0JOL2FMSnVhUjk0WkJ0S0dwNEph?=
 =?utf-8?B?RlBNZFJRQTM2QkQ2M0hYWGZsdHRmODlHd3N1U0Nzb1U4ZS9QdmdiYXovZ2FT?=
 =?utf-8?B?TFBFZ2M2SWJRN0pKRWhmTXlvMFpVQWlleHZYVGJsTkhzUVdGUi9JTkJCaGY0?=
 =?utf-8?B?U3c4eldyVjNBMFBQdDlzeE8zMUt2YVZtMVppaXBhdnBabm4zbVRVa2tlWGZk?=
 =?utf-8?B?RldwT0lXWDhyell2UlJGQ3QwUk5pNldjMytVbXR0V1p1QjJqTkRISGZya202?=
 =?utf-8?B?YWY0dnRqS3YyWkQ0SmdBNk5HY3I2VkM0QWhIc0xmZVhrai9mbHpGNVJtUkR4?=
 =?utf-8?B?YXdKYVRFY085NE1hU1AvQWV6cGdWYzVpbzQrSEpLNjFpU0tHRDlnS2gwWUE3?=
 =?utf-8?B?UmExRWJRRnpFQWV5cHJ5OXl1eUJUN3Yydlh0TTVEWVhFN1A5UVJOenArQTMx?=
 =?utf-8?B?dnhScEo0eWJkY2pOaTNvakJHVVdIS2ZkaElJTzJIakwyS1BDZklVMk96ekRC?=
 =?utf-8?B?RmtVQisrQzBndEo5azZxeCt5U0dleThrVGhhb3VVN2tMV1JIY2psRXlwSzNL?=
 =?utf-8?B?M3RHREdPb2hsS1VISERzTzc1ZnVjQnRiaGdYZXl4THlMcC9LVURucTFSVTM3?=
 =?utf-8?B?d3BMR21qZGUzZGFRR3ZTTXpqYnlGNktXTnJuc2hwTFNYdHJlZjB2N3IxQlVw?=
 =?utf-8?B?bTVLR3RHR0orbkdkU3BaeDBReVZhT1NLY3FwYk9PUlJRV1A1STRLVXMxeUJK?=
 =?utf-8?B?Z0tWZlBLeTJxWHBjWS9tdlFGeDNiU2FxU1haaUNzR1kwb2dHU0NxdWtDcVZq?=
 =?utf-8?B?aHZBK213UWM4eTh4V2dPMnNXK2RoWHdBdkJQeHZlTWUva05idEVyNFNUbjk4?=
 =?utf-8?B?Zkcyb2dRcEY4QndMN0MzYXZOTjhSeTd2SWJLL2RHM2RVTU1VUllFemtwdnB3?=
 =?utf-8?B?WWtRUzdNTmlTY0wvM1BRTEtOTlQ2TkFDS3Iwb1pFZWdPbkcyVG03MUZEQ1M4?=
 =?utf-8?B?WUozL1VFSmt3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3BLNVRWUXlhVkh0NHgyUzlTZ1RXZUNwZzV0aVYybHdEaGg3bnd4Q24zcXJY?=
 =?utf-8?B?Q0x5MDJQdnNKemYwblc0bXZpeGt6V3h6YURXTkVTeks3bDljMUgwekpiZGNF?=
 =?utf-8?B?dFZMVEtoOExDQU13amRYVzFhcmszQWhkbHdIQWhBWjEwNzdFdGwyQzZWenBG?=
 =?utf-8?B?WjVINlIyVkFPRzFNTGtvNytkaFdPbG9pME5VdVRINXVNNHZhRHMxRnFyVS9s?=
 =?utf-8?B?UHgvQWN2QlkrcDhHNU5JM0pZKy9GRGtqdFVYRkcrb05ScUFNcjc5NXpzVitO?=
 =?utf-8?B?S3FCcTBGZFVWN09EVVVPT2wvQlp2V3RFTmdMN3M0ZmgwOUw4Rm54RFRUNDhp?=
 =?utf-8?B?TDB3VXpMMEF2eXB2NWtLb2o3Rm4va2ZRbVEvUmkwdlVZK1FFdGIzYStHdlFD?=
 =?utf-8?B?WEdoMGZ1TldRaEE1RXp0OHJzK053dytHb2FVaGdSTWh2K3FqeGJHZnFOLzBL?=
 =?utf-8?B?RzYvblg5Q25sQkw1RjBCV3J1Z01qOVM3ajZYUUJRQndDdjEvbG0zbHI1Wkwy?=
 =?utf-8?B?UEFmUkRSRXVmdXduNkpocCt1dnJLeDNGblRFbEF4Qnd5WlpZclJrY0RRNVVI?=
 =?utf-8?B?Zjhwd0UxMVl6TDVBN3hIblU1Sm04a2xLeFpvbHFsMHp2dHJFR3E0Y0p0TFBp?=
 =?utf-8?B?UElqbjhQaWNRbHZSdDFhMlNyRkVpZnROR1E2a0x1Wkd3YndvTDFPcFQwR2xL?=
 =?utf-8?B?bStpVTlTLzlRWXIxbzJOMGRPSWFTVGZid2pPR3B5bFlmY1gxMkkvcWFFTCtk?=
 =?utf-8?B?MkFnVGFvaGJDZTZRTlZJbUxlTmlHRkJFbEljOHB2T0VYSGRkV2FxbnRDRjFN?=
 =?utf-8?B?ak9VTG5uaU1oWjF0WG1mOVJ2aDNXTngzQ0ZXcHM0WXlNeUdBRFBDbkJuUHY4?=
 =?utf-8?B?RWlIL0xYTHFxdGVmMk4wNFl6SGcyWUxKcnZ0U3A0b0I1dGdHdUJITFh3ejB4?=
 =?utf-8?B?VFFBUTJqWEh0V21oODN4UWh1eksvUy9mZk1mV0taeTByN2E5ZXpkZTRkZjdE?=
 =?utf-8?B?Tkw5eGJzSUErOVNvZUsxTHkyQ08zeFNTeU1qeFRnYk5EUGM3VldDWHpUeDdl?=
 =?utf-8?B?TjJQZ2sxb1p6cVBqeXNxUmZrSEozNnliRFVtVGg5bHVvTmQvQ0lrRjZSUDNQ?=
 =?utf-8?B?RkxNYTRjS0xhcE5FTyt0czh5STVKcDV3WTJNKzIrZ0s5TWVRY3JaREt4RUZn?=
 =?utf-8?B?THducy9maUl0aDAvMVJqMzhjMXVXK05LWlB3RWhNbVlVSFNIZ2JnVG5Id0dL?=
 =?utf-8?B?cnRoaTI1K29nTS9nVTQrU2lwdDZMM1FCbDNoZ0t1OEZxQVFmYWw1VkFGaWJl?=
 =?utf-8?B?QUpPRVZkYm93cGtSUmlNUVoxZHlkU0V1Qk0yVXE4TEVYdHNaQnZMQ2d5Nnlh?=
 =?utf-8?B?aDVtcHNNYVJlUE5YL09aaFhOVFp4TkxWMXgrK0x0NGVtVk15UGRqWEFIY3k0?=
 =?utf-8?B?SCtybFo3d3hYaGZZWmhOaklObVY3c2h2REExSzJtUldMZWMyRUlXd2VDdGxh?=
 =?utf-8?B?Y1F0aG5EVFhJM1NnTXhubVlHdnFwTXpIWi9jWlNobTN2L1RsaTFxNUc4b0J0?=
 =?utf-8?B?SmlmUFpPREhNQlZCb0V0NkI5TjlnbGRQV0N2enAycG9qbjRJb1pMOVRzc0xk?=
 =?utf-8?B?eFJycy8reW9BMnBxclBDV1FiNEpOOGIybEJLcEhmYlBzWEJTSUVCNnNGaGJi?=
 =?utf-8?B?cTdHMjErdyt3ZjRwMGtwYndDMndDRFRCYUhRMjNzRGQvTVVhZmlsejQ2REJQ?=
 =?utf-8?B?V1k5QkRSMlFpbjFVaHoydGRFWkZ6T2dZRUdSUFRWbHd1R3hRN0xNSVRPQ1o0?=
 =?utf-8?B?a1p5V0dENmNvWVp2QXk2UmFuOVlkT2ZaUUI4ZXBqaEMwL0l4UkkvSkpsQW1y?=
 =?utf-8?B?bFZwYUdwbzdIeU1IYkE3bVllQ2J1QUZndVgvTEZKTWxYQ01ONnh2YWY1TVJK?=
 =?utf-8?B?aGE0S2dZQnA1VUlvNkN2MHJpaTMvUDg4clJPSXFBSDVzenNGNnQ4OXpUN0U3?=
 =?utf-8?B?S2duQkxlNTlLZENzOG9YTll6aml4Q0NRMzBrK2cwbEU4TDBvT09tcDhOQ3Uy?=
 =?utf-8?B?dGlVV3F0NjIzRThoUDVPYTN4bXVKeFZ0bU9DR3NKL01jRjRpT2NRVjBST0Zv?=
 =?utf-8?Q?MM/fhK4HPnvwfPIMg+b49iSEQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 544db0ee-fbdb-4891-8feb-08ddb495b68a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 09:42:06.1592 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R9rHXUeq/Q1w6S8mHKa8+VympK+bC1jdZyQDc2qxkl/srBGtfQewaMznk8a5t5ZIhcRQga4BCI05BoqEMR+OTaV1Ox2bjFfm+R/04EKF8WI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4614
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMTYvMTld
IGludGVsX2lvbW11OiBQcm9wYWdhdGUgUEFTSUQtYmFzZWQgaW90bGINCj5pbnZhbGlkYXRpb24g
dG8gaG9zdA0KPg0KPkhpIFpoZW56aG9uZywNCj4NCj5PbiA2LzIwLzI1IDk6MTggQU0sIFpoZW56
aG9uZyBEdWFuIHdyb3RlOg0KPj4gRnJvbTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+
Pg0KPj4gVGhpcyB0cmFwcyB0aGUgZ3Vlc3QgUEFTSUQtYmFzZWQgaW90bGIgaW52YWxpZGF0aW9u
IHJlcXVlc3QgYW5kIHByb3BhZ2F0ZSBpdA0KPj4gdG8gaG9zdC4NCj4+DQo+PiBJbnRlbCBWVC1k
IDMuMCBzdXBwb3J0cyBuZXN0ZWQgdHJhbnNsYXRpb24gaW4gUEFTSUQgZ3JhbnVsYXIuIEd1ZXN0
IFNWQQ0KPnN1cHBvcnQNCj5zL2dyYW51bGFyL2dyYW51bGFyaXR5DQoNCldpbGwgZG8NCg0KPj4g
Y291bGQgYmUgaW1wbGVtZW50ZWQgYnkgY29uZmlndXJpbmcgbmVzdGVkIHRyYW5zbGF0aW9uIG9u
IHNwZWNpZmljIFBBU0lELg0KPlRoaXMNCj4+IGlzIGFsc28ga25vd24gYXMgZHVhbCBzdGFnZSBE
TUEgdHJhbnNsYXRpb24uDQo+Pg0KPj4gVW5kZXIgc3VjaCBjb25maWd1cmF0aW9uLCBndWVzdCBv
d25zIHRoZSBHVkEtPkdQQSB0cmFuc2xhdGlvbiB3aGljaCBpcw0KPj4gY29uZmlndXJlZCBhcyBz
dGFnZS0xIHBhZ2UgdGFibGUgaW4gaG9zdCBzaWRlIGZvciBhIHNwZWNpZmljIHBhc2lkLCBhbmQg
aG9zdA0KPj4gb3ducyBHUEEtPkhQQSB0cmFuc2xhdGlvbi4gQXMgZ3Vlc3Qgb3ducyBzdGFnZS0x
IHRyYW5zbGF0aW9uIHRhYmxlLCBwaW90bGINCj4+IGludmFsaWRhdGlvbiBzaG91bGQgYmUgcHJv
cGFnYXRlZCB0byBob3N0IHNpbmNlIGhvc3QgSU9NTVUgd2lsbCBjYWNoZSBmaXJzdA0KPj4gbGV2
ZWwgcGFnZSB0YWJsZSByZWxhdGVkIG1hcHBpbmdzIGR1cmluZyBETUEgYWRkcmVzcyB0cmFuc2xh
dGlvbi4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4N
Cj4+IFNpZ25lZC1vZmYtYnk6IFlpIFN1biA8eWkueS5zdW5AbGludXguaW50ZWwuY29tPg0KPj4g
U2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4N
Cj4+IC0tLQ0KPj4gIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8ICAgNiArKw0KPj4g
IGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDExMw0KPisrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLQ0KPj4gIDIgZmlsZXMgY2hhbmdlZCwgMTE3IGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVf
aW50ZXJuYWwuaA0KPmIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+PiBpbmRleCBi
M2U0YWEyM2YxLi4wN2JmYjk3NDk5IDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+
IEBAIC01ODksNiArNTg5LDEyIEBAIHR5cGVkZWYgc3RydWN0IFZURFBBU0lEQ2FjaGVJbmZvIHsN
Cj4+ICAgICAgYm9vbCBlcnJvcl9oYXBwZW5lZDsNCj4+ICB9IFZURFBBU0lEQ2FjaGVJbmZvOw0K
Pj4NCj4+ICt0eXBlZGVmIHN0cnVjdCBWVERQSU9UTEJJbnZJbmZvIHsNCj4+ICsgICAgdWludDE2
X3QgZG9tYWluX2lkOw0KPj4gKyAgICB1aW50MzJfdCBwYXNpZDsNCj4+ICsgICAgc3RydWN0IGlv
bW11X2h3cHRfdnRkX3MxX2ludmFsaWRhdGUgKmludl9kYXRhOw0KPj4gK30gVlREUElPVExCSW52
SW5mbzsNCj4+ICsNCj4+ICAvKiBQQVNJRCBUYWJsZSBSZWxhdGVkIERlZmluaXRpb25zICovDQo+
PiAgI2RlZmluZSBWVERfUEFTSURfRElSX0JBU0VfQUREUl9NQVNLICAofjB4ZmZmVUxMKQ0KPj4g
ICNkZWZpbmUgVlREX1BBU0lEX1RBQkxFX0JBU0VfQUREUl9NQVNLICh+MHhmZmZVTEwpDQo+PiBk
aWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
DQo+PiBpbmRleCA2MjFiMDdhYTAyLi5kMWZhMzk1Mjc0IDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4
Ni9pbnRlbF9pb21tdS5jDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IEBAIC0y
NjM5LDEyICsyNjM5LDEwNSBAQCBzdGF0aWMgaW50DQo+dnRkX2JpbmRfZ3Vlc3RfcGFzaWQoVlRE
QWRkcmVzc1NwYWNlICp2dGRfYXMsDQo+Pg0KPj4gICAgICByZXR1cm4gcmV0Ow0KPj4gIH0NCj4+
ICsNCj4+ICsvKg0KPj4gKyAqIENhbGxlciBvZiB0aGlzIGZ1bmN0aW9uIHNob3VsZCBob2xkIGlv
bW11X2xvY2suDQo+PiArICovDQo+PiArc3RhdGljIHZvaWQgdnRkX2ludmFsaWRhdGVfcGlvdGxi
KFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzdHJ1Y3QNCj5pb21tdV9od3B0X3Z0ZF9zMV9pbnZhbGlkYXRlICpjYWNoZSkNCj4+
ICt7DQo+PiArICAgIFZUREhvc3RJT01NVURldmljZSAqdnRkX2hpb2Q7DQo+PiArICAgIEhvc3RJ
T01NVURldmljZUlPTU1VRkQgKmlkZXY7DQo+PiArICAgIGludCBkZXZmbiA9IHZ0ZF9hcy0+ZGV2
Zm47DQo+PiArICAgIHN0cnVjdCB2dGRfYXNfa2V5IGtleSA9IHsNCj4+ICsgICAgICAgIC5idXMg
PSB2dGRfYXMtPmJ1cywNCj4+ICsgICAgICAgIC5kZXZmbiA9IGRldmZuLA0KPj4gKyAgICB9Ow0K
Pj4gKyAgICBJbnRlbElPTU1VU3RhdGUgKnMgPSB2dGRfYXMtPmlvbW11X3N0YXRlOw0KPj4gKyAg
ICB1aW50MzJfdCBlbnRyeV9udW0gPSAxOyAvKiBPbmx5IGltcGxlbWVudCBvbmUgcmVxdWVzdCBm
b3Igc2ltcGxpY2l0eQ0KPiovDQo+PiArICAgIEVycm9yICplcnI7DQo+PiArDQo+PiArICAgIHZ0
ZF9oaW9kID0gZ19oYXNoX3RhYmxlX2xvb2t1cChzLT52dGRfaG9zdF9pb21tdV9kZXYsICZrZXkp
Ow0KPj4gKyAgICBpZiAoIXZ0ZF9oaW9kIHx8ICF2dGRfaGlvZC0+aGlvZCkgew0KPj4gKyAgICAg
ICAgcmV0dXJuOw0KPj4gKyAgICB9DQo+PiArICAgIGlkZXYgPSBIT1NUX0lPTU1VX0RFVklDRV9J
T01NVUZEKHZ0ZF9oaW9kLT5oaW9kKTsNCj4+ICsNCj4+ICsgICAgaWYgKCFpb21tdWZkX2JhY2tl
bmRfaW52YWxpZGF0ZV9jYWNoZShpZGV2LT5pb21tdWZkLA0KPnZ0ZF9oaW9kLT5zMV9od3B0LA0K
Pj4gKw0KPklPTU1VX0hXUFRfSU5WQUxJREFURV9EQVRBX1ZURF9TMSwNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2YoKmNhY2hlKSwNCj4mZW50cnlf
bnVtLCBjYWNoZSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAmZXJyKSkgew0KPj4gKyAgICAgICAgZXJyb3JfcmVwb3J0X2VycihlcnIpOw0KPj4gKyAgICB9
DQo+PiArfQ0KPj4gKw0KPj4gKy8qDQo+PiArICogVGhpcyBmdW5jdGlvbiBpcyBhIGxvb3AgZnVu
Y3Rpb24gZm9yIHRoZSBzLT52dGRfYWRkcmVzc19zcGFjZXMNCj4+ICsgKiBsaXN0IHdpdGggVlRE
UElPVExCSW52SW5mbyBhcyBleGVjdXRpb24gZmlsdGVyLiBJdCBwcm9wYWdhdGVzDQo+PiArICog
dGhlIHBpb3RsYiBpbnZhbGlkYXRpb24gdG8gaG9zdC4gQ2FsbGVyIG9mIHRoaXMgZnVuY3Rpb24N
Cj4+ICsgKiBzaG91bGQgaG9sZCBpb21tdV9sb2NrLg0KPmluc3RlYWQgb2YgaGF2aW5nIHRoaXMg
bWVudGlvbiBldmVyeXdoZXJlIG1heSBiZSBtb3JlIGVmZmljaWVudCB0bw0KPnBvc3RmaXggZWFj
aCBmdW5jdGlvbiB3aXRoIF9sb2NrZWQgYW5kIEkgZG9uJ3Qga25vdyBpZiBpdCBleGlzdHMgaGF2
ZSBhDQo+Y2hlY2tlci4NCg0KT0ssIHdpbGwgYWRkIF9sb2NrZWQgYW5kIGNoZWNrZXIgaWYgbmVj
ZXNzYXJ5Lg0KDQo+PiArICovDQo+PiArc3RhdGljIHZvaWQgdnRkX2ZsdXNoX3Bhc2lkX2lvdGxi
KGdwb2ludGVyIGtleSwgZ3BvaW50ZXIgdmFsdWUsDQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGdwb2ludGVyIHVzZXJfZGF0YSkNCj4+ICt7DQo+PiArICAgIFZURFBJT1RM
QkludkluZm8gKnBpb3RsYl9pbmZvID0gdXNlcl9kYXRhOw0KPj4gKyAgICBWVERBZGRyZXNzU3Bh
Y2UgKnZ0ZF9hcyA9IHZhbHVlOw0KPj4gKyAgICBWVERQQVNJRENhY2hlRW50cnkgKnBjX2VudHJ5
ID0gJnZ0ZF9hcy0+cGFzaWRfY2FjaGVfZW50cnk7DQo+PiArICAgIHVpbnQzMl90IHBhc2lkOw0K
Pj4gKyAgICB1aW50MTZfdCBkaWQ7DQo+PiArDQo+PiArICAgIC8qIFJlcGxheSBvbmx5IGZpbGwg
cGFzaWQgZW50cnkgY2FjaGUgZm9yIHBhc3N0aHJvdWdoIGRldmljZSAqLw0KPmZpbGxzDQo+PiAr
ICAgIGlmICghcGNfZW50cnktPmNhY2hlX2ZpbGxlZCB8fA0KPj4gKyAgICAgICAgIXZ0ZF9wZV9w
Z3R0X2lzX2ZsdCgmcGNfZW50cnktPnBhc2lkX2VudHJ5KSkgew0KPj4gKyAgICAgICAgcmV0dXJu
Ow0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIGlmICh2dGRfYXNfdG9faW9tbXVfcGFzaWRfbG9j
a2VkKHZ0ZF9hcywgJnBhc2lkKSkgew0KPj4gKyAgICAgICAgcmV0dXJuOw0KPj4gKyAgICB9DQo+
PiArDQo+PiArICAgIGRpZCA9IHZ0ZF9wZV9nZXRfZGlkKCZwY19lbnRyeS0+cGFzaWRfZW50cnkp
Ow0KPj4gKw0KPj4gKyAgICBpZiAocGlvdGxiX2luZm8tPmRvbWFpbl9pZCA9PSBkaWQgJiYgcGlv
dGxiX2luZm8tPnBhc2lkID09IHBhc2lkKSB7DQo+PiArICAgICAgICB2dGRfaW52YWxpZGF0ZV9w
aW90bGIodnRkX2FzLCBwaW90bGJfaW5mby0+aW52X2RhdGEpOw0KPj4gKyAgICB9DQo+PiArfQ0K
Pj4gKw0KPj4gK3N0YXRpYyB2b2lkIHZ0ZF9mbHVzaF9wYXNpZF9pb3RsYl9hbGwoSW50ZWxJT01N
VVN0YXRlICpzLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWlu
dDE2X3QgZG9tYWluX2lkLA0KPnVpbnQzMl90IHBhc2lkLA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgaHdhZGRyIGFkZHIsIHVpbnQ2NF90DQo+bnBhZ2VzLCBib29s
IGloKQ0KPj4gK3sNCj4+ICsgICAgc3RydWN0IGlvbW11X2h3cHRfdnRkX3MxX2ludmFsaWRhdGUg
Y2FjaGVfaW5mbyA9IHsgMCB9Ow0KPj4gKyAgICBWVERQSU9UTEJJbnZJbmZvIHBpb3RsYl9pbmZv
Ow0KPj4gKw0KPj4gKyAgICBjYWNoZV9pbmZvLmFkZHIgPSBhZGRyOw0KPj4gKyAgICBjYWNoZV9p
bmZvLm5wYWdlcyA9IG5wYWdlczsNCj4+ICsgICAgY2FjaGVfaW5mby5mbGFncyA9IGloID8gSU9N
TVVfVlREX0lOVl9GTEFHU19MRUFGIDogMDsNCj4+ICsNCj4+ICsgICAgcGlvdGxiX2luZm8uZG9t
YWluX2lkID0gZG9tYWluX2lkOw0KPj4gKyAgICBwaW90bGJfaW5mby5wYXNpZCA9IHBhc2lkOw0K
Pj4gKyAgICBwaW90bGJfaW5mby5pbnZfZGF0YSA9ICZjYWNoZV9pbmZvOw0KPj4gKw0KPj4gKyAg
ICAvKg0KPj4gKyAgICAgKiBIZXJlIGxvb3BzIGFsbCB0aGUgdnRkX2FzIGluc3RhbmNlcyBpbiBz
LT52dGRfYWRkcmVzc19zcGFjZXMNCj5JIGFtIG5vdCBhIG5hdGl2ZSBlbmdsaXNoIHNwZWFrZXIg
YnV0IEkgYW0gbm90IHN1cmUgbG9vcCBzb21ldGhpbmcgaXMNCj5PSy4gR28gdGhvdWdoIGVhY2g/
DQpXaWxsIGRvLg0KDQo+QmVzaWRlcyB0aGF0IGNvbW1lbnQgaXMgbm90IHRoYXQgdXNlZnVsIGFz
IGl0IHBhcmFwaHJhc2VzIHRoZSBjb2RlLg0KDQpPSywgd2lsbCB0cnkgdG8gc2ltcGxpZnkgaXQu
DQoNCj4+ICsgICAgICogdG8gZmluZCBvdXQgdGhlIGFmZmVjdGVkIGRldmljZXMgc2luY2UgcGlv
dGxiIGludmFsaWRhdGlvbg0KPj4gKyAgICAgKiBzaG91bGQgY2hlY2sgcGFzaWQgY2FjaGUgcGVy
IGFyY2hpdGVjdHVyZSBwb2ludCBvZiB2aWV3Lg0KPj4gKyAgICAgKi8NCj4+ICsgICAgZ19oYXNo
X3RhYmxlX2ZvcmVhY2gocy0+dnRkX2FkZHJlc3Nfc3BhY2VzLA0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICB2dGRfZmx1c2hfcGFzaWRfaW90bGIsICZwaW90bGJfaW5mbyk7DQo+PiArfQ0K
Pj4gICNlbHNlDQo+PiAgc3RhdGljIGludCB2dGRfYmluZF9ndWVzdF9wYXNpZChWVERBZGRyZXNz
U3BhY2UgKnZ0ZF9hcywNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZURFBB
U0lERW50cnkgKnBlLCBWVERQQVNJRE9wDQo+b3ApDQo+PiAgew0KPj4gICAgICByZXR1cm4gMDsN
Cj4+ICB9DQo+PiArDQo+PiArc3RhdGljIHZvaWQgdnRkX2ZsdXNoX3Bhc2lkX2lvdGxiX2FsbChJ
bnRlbElPTU1VU3RhdGUgKnMsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB1aW50MTZfdCBkb21haW5faWQsDQo+dWludDMyX3QgcGFzaWQsDQo+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBod2FkZHIgYWRkciwgdWludDY0X3QNCj5ucGFn
ZXMsIGJvb2wgaWgpDQo+PiArew0KPj4gK30NCj4+ICAjZW5kaWYNCj4+DQo+PiAgLyogRG8gYSBj
b250ZXh0LWNhY2hlIGRldmljZS1zZWxlY3RpdmUgaW52YWxpZGF0aW9uLg0KPj4gQEAgLTMzMDAs
NiArMzM5MywxMyBAQCBzdGF0aWMgdm9pZA0KPnZ0ZF9waW90bGJfcGFzaWRfaW52YWxpZGF0ZShJ
bnRlbElPTU1VU3RhdGUgKnMsDQo+PiAgICAgIGluZm8ucGFzaWQgPSBwYXNpZDsNCj4+DQo+PiAg
ICAgIHZ0ZF9pb21tdV9sb2NrKHMpOw0KPj4gKyAgICAvKg0KPj4gKyAgICAgKiBIZXJlIGxvb3Bz
IGFsbCB0aGUgdnRkX2FzIGluc3RhbmNlcyBpbiBzLT52dGRfYXMNCj53b3VsZCBmcm9wIGFib3Zl
Lg0KPj4gKyAgICAgKiB0byBmaW5kIG91dCB0aGUgYWZmZWN0ZWQgZGV2aWNlcyBzaW5jZSBwaW90
bGIgaW52YWxpZGF0aW9uDQo+RmluZCBvdXQgLi4uDQoNCldpbGwgZG8uDQoNClRoYW5rcw0KWmhl
bnpob25nDQo=

