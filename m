Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDDDC71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 16:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYdv-0007Ms-0s; Tue, 17 Jun 2025 11:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uRYL9-0004LP-Lg
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:35:12 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uRVsp-0004cG-H3
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 08:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750165067; x=1781701067;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=H8VLOE2RlGBomreWRD7ZOGxknj8guWjHuC/q89agayw=;
 b=PfBMZVNoRR8xZJ3hWAlE+JUhdzceGSdv5rkyGLZPOvkfBkyzz7SColJc
 bm+x9ltUbb+TF743e/Z9L/+iNfLMHzPg8QCUUO3pLu5NymAT07QolsyB5
 LzBkMorT7s9Rx2DAHWPhirffCps9u7T6x53UP4lmLeWAhxXzP+VPZr7rf
 dXsjZ2aMuqn3xZls79OMeE7TG7mIS5qichSrsP7rL9NHfI3erF18X8DKt
 wGhfFDy2UzGDzXSKoxYpt37Vabzp60T5ysMDtdI1kNFXYO89cd/VWKH7t
 GxdPenK1hVjkQisL+EE5CtwT/hQq+ZwFVV5wYznkKxE3hNWvMEEkxmjYW Q==;
X-CSE-ConnectionGUID: 2G6XOWvSRYaj95kRsTuT+w==
X-CSE-MsgGUID: HcYxmjubT0uOWC/to4mJzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="51451054"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; d="scan'208";a="51451054"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 05:57:43 -0700
X-CSE-ConnectionGUID: vAl9pNA0QN2S5SIuojSmeA==
X-CSE-MsgGUID: T4DUzfXBQXqjInCo2L8acA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; d="scan'208";a="154060202"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 05:57:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 05:57:42 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 05:57:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.42)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 05:57:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OI7i3odjdd9cUFcn7/Hzn94O5qKddXutMG/H/ilkumsf1NMpH7FJAapT9RoFj1/rrV6VZAb1G4d/3GYhWfcPPuU4h4kVYz1ujcQuhlx+HPQenS9JwGJkfzYeIipMxfcosM5SdAHdRN3yjiiWe+xoloDIGeR35JOEAnQOYx4MdWELCvv1uW5NnFQDFOXDyPV6QjKV5OV5qJiiOIeZGGe9qOnfgO7GfdIAFQVxzTBOeFvr9taR8LAtT9BKidp8nLDDvNuviIMzXAKhY8fsHh6gPqyDGRysUBo+P40Jm8IYHbKkkkqihNCyWKpdPX83VEciZ4getNLoOVSyclY+VJAUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3W9fAOUarx2vroU6MzE/0ePFng9Ryul2vW8NpaVBgeg=;
 b=a2Z1M+VMeJ2+l6MBhOqKve/WPfp9dea8TgM4wHOk3wCltXtQ+tfr7vHk3jh5AAEPfCjX/z93Qdu4OAi3zhVXtJ+20vL0jDOmgGXygvcCCeSmlY+BiCBmCkT/F7q8eGEdc69w8ssL7mYLkMrO6clzlXxCZUcK6pRQZ9tLrnHdeicRcvsbiT42alz3+ddzq42FSTTFnkm7cvUBNeAvTSz9NsYmS3lmxvxnamqfU+fCO0trQPhfosHuQ3Awje6Oc4v9aCk0eWlLohAbxHca2MREkqyhsvucPUBKiDQeSx4e20clfcCqBv7viGes0O2d6FmZSxM4D0XYUx5fZ6eRJi0ZOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH0PR11MB7635.namprd11.prod.outlook.com (2603:10b6:510:28e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Tue, 17 Jun
 2025 12:57:26 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%7]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 12:57:26 +0000
Message-ID: <de5baefb-515a-47e3-9e4b-16bca4dbec5e@intel.com>
Date: Tue, 17 Jun 2025 21:03:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, Peter Xu
 <peterx@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250521111452.3316354-16-zhenzhong.duan@intel.com>
 <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
 <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
 <aDDk1NYwJXaAdUQI@Asurada-Nvidia>
 <29f5f434-1fe3-4b5e-91d1-f153e1e98602@intel.com>
 <aDSmcvZ08jNOSr05@Asurada-Nvidia>
 <SJ0PR11MB6744340B889FF65D3BD5B8459267A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <aE+wCIG8KHb3u1lV@nvidia.com>
 <IA3PR11MB91369A0E98CC76ABDBA365809270A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aFDdkxPODYnyG0Vo@nvidia.com> <20250617123707.GW1174925@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250617123707.GW1174925@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH0PR11MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f62ed2-2b3f-4aef-4691-08ddad9e8256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVVtSzdhTVJvOHBmRXZSVzI0Z0NFdEZqZHBGNld6Zm1MaFRKbkRsMkJQYzVz?=
 =?utf-8?B?NnloM2lVMTUxNWJ1VmJnRzU4bHhHSmZMaDFDZW5BSXZTTmdRdVBXNkxQUEs3?=
 =?utf-8?B?cnVJd0R5VldSMVFxTTdPeWRyT0tKQ1RTYVJraXhOSXdVTlRhbDF0TVdCSVIv?=
 =?utf-8?B?akdWdmtpUnZieWtXT2c1STNuMnpPYXlXUytWVXdvdHpXc1orQ2hKaXNpdk52?=
 =?utf-8?B?RDdVMDFMQWY2aXVVMitIWWFYc0EwRWlXM2JmYjZ0bGdGR2Q0MGNNbkZvWWg0?=
 =?utf-8?B?VFlndVpHUHVDTmdtT0tDUVdqd2VTcEt4d0wySUN4Nk1JQ0YzQThqK1Z5MzZK?=
 =?utf-8?B?UGQ1TmtLNzZ1cnpMV2NuN1A4NEdpQTFFdGF4NkhsV216MXhqSGlVbS9lMm9q?=
 =?utf-8?B?dHZ2N3ZUa1BlcklMbVFRUURiRUQrTlh5SUVSbzdjZDhlRks3M3d2TkVkM3JO?=
 =?utf-8?B?elIxNEc1VzJQT0c2RlZtd2hoa296UUVCNDZQTDJaa0ovQW5aNWxLeUZrSEU2?=
 =?utf-8?B?TGlDTUF1bDRwcnZzT05jcWRXNjlzaXBmcTByTXV3M0tvMW03dGwrVnYxSkVZ?=
 =?utf-8?B?SUVIdUZJY2tHQ2JRU1JBWGpldHVBOGR5dngvS2lyaE9zTGJta2VmOUdmU3FO?=
 =?utf-8?B?N2QvbkJVZlZGalZteS80SmduQ0lSa0FWWlltT044aG9RdGNRZjVmand3RmFy?=
 =?utf-8?B?ckFsUWFsQUxEYmZ3R25mK2pBQ1RXeGpiMmpUcUZYOVNOZ081Q1lXVGNzanlS?=
 =?utf-8?B?dzFCZ3MxR3VsenFtaGZZUzJVTVdzRllvME9BMzJNVDBUanF4RVZVZk94d05C?=
 =?utf-8?B?YU1UMnljVHVEUncvdUtuSTAyYWRQUGliN0lMMDdWUVQxNFlLQllNQXY5OEdl?=
 =?utf-8?B?N3pmaStiWVNWaE5qVGNJc2Z4V0pJQUJtc0dkNXQ5U29tcVI5a0QrWjg5NTBB?=
 =?utf-8?B?M3cvNW00N0dQVmZHcS9JNnVjUCtLRk9NQWdFenpiV3ZRYkR4eDR3US9UZWpC?=
 =?utf-8?B?MUJjTTdrOHRFQzE3MGlSYmxPenllMU5TR1JtK043TzFCQWJQeVRUSDBwcEl3?=
 =?utf-8?B?QmRNNTUwSDFCenF0SG1RcjczbXpRTEs3cnhyaStQbnhtQTdpWHZUZ3ZtT0RO?=
 =?utf-8?B?bkFGWjFQaUNtcHh4R0Q1eXNOeHhRZ25CVGhYQWRvV2NSUjQrVFIveHlKaDNH?=
 =?utf-8?B?bVRyZE5PTEJ2TmVIeWhzMmltbElxNVNtZXV0WHBjWFRsZW85YzlLT0trc1Ry?=
 =?utf-8?B?SzJ4Nnk1UXZJdGJWeWhMUFdzT0RZTVYzNXhzeEx0YkFBS0Y2YmxtYUI1QW03?=
 =?utf-8?B?UTZZRysxUXNnRWo1Rm5meFVCMVBsRSswZlN1UUNhWUxMVEhua2xBZE1lcnVv?=
 =?utf-8?B?eDYvT0NXTzlJalNkcHVSRTBBQ0RwYnZiT3o3ZGNNeDZuZ0VjNzJ2UkVuWEtH?=
 =?utf-8?B?bW10OXkya1pBd2RtK3dHUWtuRzNYL1pZV2ZodmlRU0hqcnEwMXYvVnMzQmRy?=
 =?utf-8?B?L0VmaUd3MWxISXNybnZRNlp3STNRWjJHZDQzYWlHOEpYQUlsQWttYlVjSnlF?=
 =?utf-8?B?eGZxTHJkd0pnL0c4NW1YQzFieFFZT2FhOURhNnh4TjF5ektuei9jYTFBb0Jw?=
 =?utf-8?B?ZmJZeWhKZlRBVVFVZ0xvL3lvRFBMTkVKLzhmeGZYUEEwMjdQcERaZENZRTFT?=
 =?utf-8?B?RHE3L01BT1hjbVlKZC9ZWkRHakxSQlB5aHZOMUJVQXpRQkt5ZGJwTktxV3lx?=
 =?utf-8?B?TVN5RWd5NkYzOTROaUZlbmJDQ0dqaWNzemVSYS8rR214TmwveHJpU2R5dWNh?=
 =?utf-8?B?NXVGeGxQNEpKWGhBZ2Q4aXE2VklOV0RnMzJ3R09qUHppTVVSeTV5WlEwWlY2?=
 =?utf-8?B?OS9VSUh0T1djdXUyMEtkeHNPNjI4Z3VaSWl5VURaZm9xSDdYc0tLb0FhRyt2?=
 =?utf-8?Q?cDYv/NsMrzs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUVWcGdJek55L2piSFM2OWdlb3lnYjdPbzlONnFxRWZVRFRVNkFpWkFrbkNO?=
 =?utf-8?B?ZFdwMENxcWpoL1EyeVM4dit4cm5ramc1RWRaeFpSbjR6dXJ6U0JDVFI0czdq?=
 =?utf-8?B?TFNvZVpKakVId1FreEVRd0wyL0hJVmJJSVpFeUtkcThtejJzWkRWYmlZNUM0?=
 =?utf-8?B?SWhrK3R5L0RkSjdGSmV5WXB5SEl4RTMvZGtiWEZ3MEx3L2FlVU9GYThwSTBq?=
 =?utf-8?B?UDUrQ2hDWWd4SHNQa2xoS0JaYzlIUmtKYjA2em1DYWg0Z2Q1QkxUcXZpTnVK?=
 =?utf-8?B?ZmxNTEtvYXlDMVM5U21HNkJYQzBwdUpsYjJkWUd3SG51U1VWeERaNitHNENQ?=
 =?utf-8?B?T0VxTy9yQ0NKSUxOc2xFK0pBcEpReHpsc3EwV1pjc0Y2L01iUkgyMjgrWnp1?=
 =?utf-8?B?d0ZpcWJjaFdPWjlVUXgyTWViYTVnM3lGemJGaS9aYW1YUkJ4ei9nYk00amNi?=
 =?utf-8?B?Z0ZzY2RYMlJ1SzdWK1RHbEoxbDZWRjk2UlQyQVVieGlOeHdhQU1ZL0EzZ3Zh?=
 =?utf-8?B?d3huT0Jkc0JRR0FabytaNWZXTzg0blUzWUJQL1hRQkhBQS84azVaQ0QyYzd5?=
 =?utf-8?B?Y2M1bnQ1Ny9zcEdzL0NsOWFYQnRqVzkzZWlyL3hzT1AwVGRKUDcvQWZqdlVk?=
 =?utf-8?B?ZGIySzIxNitCVmUvTnl3bHRFcElUeVlSSmVuek5hMThvVWdiV1FHRkZyb2xX?=
 =?utf-8?B?VzZYSmt1S2hnaTJkWXhwNGxzZkRUVERpbkl0Qy9kckhoQm9kQUd3eGEzVUVK?=
 =?utf-8?B?UC9YejhRMTJNVkpPWjBPb3VpZEtkcmY4T1hEMEJKMFp5NW10Yk9WM3Q5ZHh6?=
 =?utf-8?B?bFc3Y0N3RDVVVzBMRlhiVVFEOFIvb2F3Ri8wTlFGTGtpcDYzRTV2dUQxQnhr?=
 =?utf-8?B?a0JKVU91ZFdqYlhJQWIzeFpIZHRxdDlORjh6N25kcFk4cjVaRERJN3JaQ21q?=
 =?utf-8?B?NU4ybjVmYVBsUjRONDBMTytwbHpua3FuSkNaellrY2JTWi9Jb3lZaU9RS3Rn?=
 =?utf-8?B?NSs2c1ZEUUJYWFU2QWljb3VwYWQvT29yK0IxTEM0S3ZjZC9xTHFyaXNrN1VS?=
 =?utf-8?B?akYyeGJDaTlIU1JlUVZ3b1lpOThHQTBtUURPV1lZMUFiSHhLTzc1S2xWclNY?=
 =?utf-8?B?cHNsRUcyR1MzRE1YT2pNREtKTjdDRDVTT3FBa2lrdEVDK3A2d05ySU0yaThi?=
 =?utf-8?B?QmNFd1VVSlk4cUwxS1M0ZXQzRnNpVThzbTVWUEgrZVE0MllJQmlDN3VNYllF?=
 =?utf-8?B?SXNWSG9EVlFaaXV0eUZKNUVTU01KS1ZtbjRReGkxU01oRWdQcWtadGN1MWwx?=
 =?utf-8?B?Y3BPSkRVZlQvYVErVDdoeldlMmloVFROeG16WW82NWIxRlhuUTdjMnN6S3pH?=
 =?utf-8?B?ajN4RVBtUkVjNHg3eVF4M3A4N0xTeU1PZTRwWndYNjkvNzZwNFB3NER6a2t4?=
 =?utf-8?B?clJSSkJnNk9MTUZ0TjZmTkRnc0Fma3NLTzBTWDYycDVteTBoT2gvRjlHY0lO?=
 =?utf-8?B?ZkxSbWJLSk1HTXZLdkluWjh2VnFNU2RidHdHemVnTW0wMStySnE5ZGdQVlVQ?=
 =?utf-8?B?ZFlZeGx5aGFWZndBNDJxNUVhL3lFa1orUG5weURnTGNQemc1NjNmUWZISDhy?=
 =?utf-8?B?Ukt5VjlrajJsRWJIbUUvN05pSW41ajgzc2t2Ty95b1U0eFdvbklWdzNEeGNl?=
 =?utf-8?B?cmt4b2w3dVZuYjZmUHVQaWpGMHdFV1BRUFJlanBCeTI2dnErSk9YWVVnL0Zq?=
 =?utf-8?B?Q09WS1JpSkNscDBYOGtTaTB2elZzaHp2MjhLRjZuVG9rdXpQcFZjTDhyS0V5?=
 =?utf-8?B?UlZ2L0ZwcXgrcGlZVnRUTTd6S0RURlpNWTJ5eWpyMi9zYm1YUUNyUE9VM01K?=
 =?utf-8?B?cis4dnFJSXk1T2RyakdvakNJbFFOWk9uVFpJV3RXRHRYOHRNRFFidFE1d1Qw?=
 =?utf-8?B?RThJTm5RMnovbFkrWmNlcHlvUU5nTy9GK1JxeTZNdXZnR2x3WXBidWNYYlZZ?=
 =?utf-8?B?MkU1eU5VVmRPOXdpbGFMcFJ0Mkkra2xTcVErcEhqUlFURkc2c0NUK3FnWWpV?=
 =?utf-8?B?bG9FQVl3U0hvakgvZ1F0RlhyYlgrWkR1MzUwWFBMU1FGQnJqaHVBQkoweHFX?=
 =?utf-8?Q?T1RgmqFHKWWfsx611q5YP5Cey?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f62ed2-2b3f-4aef-4691-08ddad9e8256
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 12:57:26.0621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bY4HUmH+RUJ8a6tuCcwpyT0A04b7X1pr+ytIAOINL6vYz4hfVaqoQ2sCW+tZaHumLwIM0c5SKGmtdZI+JhkFvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7635
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
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

On 2025/6/17 20:37, Jason Gunthorpe wrote:
> On Mon, Jun 16, 2025 at 08:14:27PM -0700, Nicolin Chen wrote:
>> On Mon, Jun 16, 2025 at 08:15:11AM +0000, Duan, Zhenzhong wrote:
>>>> IIUIC, the guest kernel cmdline can switch the mode between the
>>>> stage1 (nesting) and stage2 (legacy/emulated VT-d), right?
>>>
>>> Right. E.g., kexec from "intel_iommu=on,sm_on" to "intel_iommu=on,sm_off",
>>> Then first kernel will run in scalable mode and use stage1(nesting) and
>>> second kernel will run in legacy mode and use stage2.
>>
>> In scalable mode, guest kernel has a stage1 (nested) domain and
>> host kernel has a stage2 (nesting parent) domain. In this case,
>> the VFIO container IOAS could be the system AS corresponding to
>> the kernel-managed stage2 domain.
>>
>> In legacy mode, guest kernel has a stage2 (normal) domain while
>> host kernel has a stage2 (shadow) domain? In this case, the VFIO
>> container IOAS should be the iommu AS corresponding to the kernel
>> guest-level stage2 domain (or should it be shadow)?
> 
> What you want is to disable HW support for legacy mode in qemu so the
> kernel rejects sm_off operation.

that can be the future. :)

> The HW spec is really goofy, we get an ecap_slts but it only applies
> to a PASID table entry (scalable mode). So the HW has to support
> second stage for legacy always but can turn it off for PASID?

yes. legacy mode (page table following second stage format) is anyhow
supported.

> IMHO the intention was to allow the VMM to not support shadowing, but
> it seems the execution was mangled.
> 
> I suggest fixing the Linux driver to refuse to run in sm_on mode if
> the HW supports scalable mode and ecap_slts = false. That may not be
> 100% spec compliant but it seems like a reasonable approach.

running sm_on with only ecap_flts==true is what we want here. We want
the guest use stage-1 page table hence it can be used by hw under the
nested translation mode. While this page table is only available in sm_on
mode.

If we want to drop the legacy mode usage in virtualization environment, we
might let linux iommu driver refuse running legacy mode while ecap_slts is
false. I suppose HW is going to advertise both ecap_slts and ecap_flts. So
this will just let guest get rid of using legacy mode.

But this is not necessary so far. As the discussion going here, we intend
to reuse the GPA HWPT allocated by VFIO container as well.[1] This is now
aligned with Nic and Shameer.

[1] 
https://lore.kernel.org/qemu-devel/b3d31287-4de5-4e0e-a81b-99f82edd5bcc@intel.com/

>> The ARM model that Shameer is proposing only allows a nested SMMU
>> when such a legacy mode is off. This simplifies a lot of things.
>> But the difficulty of the VT-d model is that it has to rely on a
>> guest bootcmd during runtime..
> 
> ARM is cleaner because it doesn't have these drivers issues. qemu can
> reliably say not to use the S2 and all the existing guest kernels will
> obey that.

out of curious, does SMMU have legacy mode or a given version of SMMU
only supports either legacy mode or newer mode?

> AMD has the same issues, BTW, arguably even worse as I didn't notice
> any way to specify if the v1 page table is supported :\
> 
> Jason

-- 
Regards,
Yi Liu

