Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC50C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 09:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfytX-0003Ce-DB; Mon, 19 Aug 2024 05:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sfytV-0003C4-6r
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 05:41:45 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sfytT-0007Nj-9F
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 05:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1724060503; x=1755596503;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=p6VDDHjyNlsd8dUG86n1juQyqXR04kYta8ybZzvCldU=;
 b=BQYoPOhD+gMN731EytDBkFUPps3LtuuTEOFShWA9mrrYH809+yjAlSlp
 Gq+4BL5K1CTmvMGhOcNq+QE4p2k6Roa1m6P06dMJlAR8/hkrfcOGEZ7PK
 itu3iA9K1bzHXKKHRNXk8xnmL9JrdAfPcc3Yf4/KVi9USuSymNSv+J92y
 cUueuRmSYQj3BdrB3YtNd+mwYibxUdEzzEvrtbWNU2eEQu1c7w/Q7uYGy
 rDkCuLygzYZLX0pO/58UBp882fXFfFiuIo9VNVhDQvgv2lT9zoePTGL9h
 Yz+vmnchsLqjCYyid2in4/rWi9zUoH5oWyzPVQDDCHVlCtygpV2Mj+p/y g==;
X-CSE-ConnectionGUID: 2PSghCE8RAKgo/pbLYHluw==
X-CSE-MsgGUID: or/BzTqZRWO8I+jhbG8RNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="22434984"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; d="scan'208";a="22434984"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2024 02:41:40 -0700
X-CSE-ConnectionGUID: rWN99z0nQkqG3hvjjX/HGg==
X-CSE-MsgGUID: Ck66uYg0TaSjT4hvlH6XTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; d="scan'208";a="60473897"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 19 Aug 2024 02:41:40 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 02:41:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 02:41:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 02:41:39 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 02:41:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRr6sIhbZ0shPNhvzoz08uMv+4um8iK/ftjdGEI6J7U3wYZu//JRw+RDAcwVpW0WDpGnHUDjPgg+3oifmkkvFLwMFMh21UtFtrw3wxXTOlAaLy1zvpgb534YUL3eWBYb4PrCNCS6P6o77REIkow871uYQNETq9c0Aa8SOCtTAm0gj7zWB+SaplFQ3gfWVrmy2Kv82VFOs+IoaCuTYLJMg/X6ml4D5aIxkoryGVGOqxUwiIuSR5zK7zF7ey200aYr7N1j+BbkiWWjKhzruInv38tTi/UK9MBPp0/vDlu7++nk6ciK+UV7LoyNaE+l/hEmKrU6OQF6RCQM67tqdudsEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6VDDHjyNlsd8dUG86n1juQyqXR04kYta8ybZzvCldU=;
 b=EblYaCNIUnGWyCm0fdUL1iJ04bxzgRRzOdoED1U4GjwyWA4nprKdNWZlMvq7KN0JNlV+SyJ5XvniKXSPnhAa283gwbesHjbdAOSyNVv60/9SQCzL4m3RJfZzXfg26qxPkMmkspmUzZNQyQXeP0S8rRfyFqYKELHZV3O86JmEeBbakq25qlsNM+r+6/fiT3a8Tj9dDKdR5AgdFG2CMNMXGpaCpdL7ssN27fQzMRAuyQp59nfSsOa31r6Vt4TnygeuegabvN2PPXXzrINzkO1b+ryj/RyUNP73oV2cofNLv+yKLuM6qr6AhB3FtHCC3f2REVwQDhBPvHin7aHFdYQtEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MW4PR11MB6667.namprd11.prod.outlook.com (2603:10b6:303:1ea::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 09:41:36 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 09:41:36 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v2 16/17] intel_iommu: Introduce a property to control
 FS1GP cap bit setting
Thread-Topic: [PATCH v2 16/17] intel_iommu: Introduce a property to control
 FS1GP cap bit setting
Thread-Index: AQHa5wEcbJ7zQ5MdU06ZtXNCg9xsy7Imu2OAgAEA3vCABqp5gIAAAOgg
Date: Mon, 19 Aug 2024 09:41:36 +0000
Message-ID: <SJ0PR11MB6744C75C8C541498CA22479E928C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-17-zhenzhong.duan@intel.com>
 <9b2b2f76-a5ef-4378-b233-af1a44f742c7@intel.com>
 <SJ0PR11MB6744410546621C57CCF7D2E892802@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <68c7f380-08c3-42ca-9cb8-db0368f92fc2@intel.com>
In-Reply-To: <68c7f380-08c3-42ca-9cb8-db0368f92fc2@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MW4PR11MB6667:EE_
x-ms-office365-filtering-correlation-id: 57d12387-10e3-46a4-0f33-08dcc0331e29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?YW43RFFIYmIzazVoY1MxYVd1YXZyU1g0b2s4TnorU254K091YWs2R0xkbXM5?=
 =?utf-8?B?bVpxRTJqM1R2TGNHSW82QVhjWmRla1gxVmdSNEJBYVRsRGRia0EyUnNaditw?=
 =?utf-8?B?YmdsR2VYdDIvc2s0ZWhhajFta1pROUlPd2dZUGo1bzk2YUs5TXJxSFIrcHVS?=
 =?utf-8?B?U1dsZzAzTzNkUVVRNmRidXp3elZDTXU1UUdGaGhsMy9sRUZGNEltWEhxMDNr?=
 =?utf-8?B?aWJwY3ZxcjJ4b0ZQL1puVm1qSEs1OGZKVWZwazdqbENhSE5EdkVTa29yK3hV?=
 =?utf-8?B?ZjdIK0pEWXNoeVVIMit0Z0N3bkFTN0pqZVVqcURBMzRNQWVJYTlOZVN4STZy?=
 =?utf-8?B?U0tmRjFWdDJFaGlDNzB3QVlwa2w1TWlUL2hJbmhiUzZqMGR3Y01zcllpbU10?=
 =?utf-8?B?K2xZNkxuM2RBVmJnaVpSaVZWWjVnamxXUzBmRHN4VUtrNHcyczNISEdNZFhr?=
 =?utf-8?B?cm1IOFBQQnZJS3pqVWNMT3lZaXVrZzF0djV4Q05mSkZsYkh0MjAxU0tqMHhr?=
 =?utf-8?B?akxqSWtHU3FidkpVQjJSREkra2VlKzR4RFJmQ0k2S254MjVWeHI5OWFUKy8y?=
 =?utf-8?B?MDIrQnRLbTZVd2hsR0ovdENQOGZBdmpCTzloSzFES3h6bWtiZ3YzaHVqTkdn?=
 =?utf-8?B?ejEzUlpOMEtVZnExbE5TR3VkTThOVnAzZkd3a0tkUEpZY0RxWmFtTnYrc2dG?=
 =?utf-8?B?Rld3bEViTTVKOWxiVjE4dlBNMzlGTEMxL0N3SDZwWHJjNWM0UkRjL3Zndzdh?=
 =?utf-8?B?ckJuRnRxTFlqbXdkMHU3dlZSZFY3cVJyalJ0QndNN09vMWpQMkh1YU9UYTBw?=
 =?utf-8?B?S29JQjZuVEc3SnB2Ni8xMkdiMEpZcmNoOEhXMkNHaDdVWXczckhZcENuSU53?=
 =?utf-8?B?TmVLUnVPR2lhTURZSERvTXliT1NFWVVidnp3VlZRanBYRisrT2tPYUhjQmZN?=
 =?utf-8?B?UlFuTjlEZzRsa3Vpc20yMTlIblRsM0I5d082MkRhRldoOFJrYVhxTEpHWnlP?=
 =?utf-8?B?b3poNXdMTjAxREh2M0tLRTlpOVlOQStGbzYrVjFFcXpIcnZQTVFZa2llOTlr?=
 =?utf-8?B?Y281cE5xKzc2OWI5YWtUeHoxSWRFUDUwWmZoUGRzODB1NURnR0FIMURoWkIx?=
 =?utf-8?B?K0F5NVRreXp6TGNGNnh1ZW0zd2trR3pPNWJ3dzJ5YXdjUjFjci9GM1BZTUVI?=
 =?utf-8?B?V2xXQzZKcWZkWWR5VlZFT05BaDRyejRzN1pnTkgrTFVkZzFlTXNEQ2RuaHY5?=
 =?utf-8?B?bSswUzNjU2cyZC9RZEg3b1VFZzZFeU1rN1ZoTk1iUkNtanBVRzhIbmlQYmRI?=
 =?utf-8?B?K3BzSjBZbE9pL21XRVdJdFJaYnJRV2tPWXcvUlE1aTc2YS9IeWkvZGp1R2VH?=
 =?utf-8?B?aEc1cWFUbFNnVHFBTXhEbUVwQTdCaDJEU05XeWVNS2ZmMXI0NSthVE5iOEZU?=
 =?utf-8?B?c0EwcUt1Y2xmNm00bDBTeXVyMGQ3TkVFc1B3MU1haTRtTHc2eGc2MUNnYnZx?=
 =?utf-8?B?OHF2ditaS08weEtyZDlTcmZzb1BDT25QQlFZd1hwNlYySnVEVURmZTN1OEVr?=
 =?utf-8?B?R1krTjRDN0NuVTloMktiRHBCaUZJbEJtUUcyM0JucXhEc2F6cG5HL3JMaTZL?=
 =?utf-8?B?NkxLSjJYQVVXNldVSUREVDZOMGZUbTU0aGxWdG56Z1ZZM3hUUjJMczRYeU1h?=
 =?utf-8?B?NG1ua0lzT3V2MXA1ekRaZnAxbjd6cXhQT2tiZWVHRWN6dHFHQkFhcUZramUz?=
 =?utf-8?B?YWVxK1BzWW9PQnJpb2ZWdnVLNXBNcHF1RUlQWisrdTJXZkxod3Y0dlhhbXkv?=
 =?utf-8?Q?UsX/hDfTyoud7r/9ejp2TG8RTZO9a8lWBKtKA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmhRNElwVGVlN2x2cCs4WWxRb2x5MFRzZlorYXVrcnNJZ0pZRmxMdVVXV3dp?=
 =?utf-8?B?OHk1OUJ6TURYRUI0ckJ1WlRkN1h2NFdydmNVa0RHZWlONkcyL2puVFJ5cUND?=
 =?utf-8?B?b205UjBEMUFEM2RoV0RnRlRKZXZCbE1QU1lkWkJrZjhkMG5PNzRCbmwrN0hD?=
 =?utf-8?B?bUZaWUg1Mk53Tk95R1dGc2Z4QVhuQ0lsQ3cvNzNTd2hMSmJiSHpKRm8vZ0ln?=
 =?utf-8?B?emo0eWpuSlBqd2JPMlcxMUh1OW01K0gyTHdWMSt5dEMxWjZuRUpjNlhvOXla?=
 =?utf-8?B?U3RJQjg2ZjBGSTdZSDJ5dHZyUlgyVGRLYVowQmFFeXFHeW1TVUZsNWxTSjBL?=
 =?utf-8?B?c0h6anJ4WG9VZTN2OG83azJ0MWc3L1ViT2hmRjlCY3dOcUdMT2VYUVpGUUhL?=
 =?utf-8?B?bVVsT3VLbUNOSDlpQTk3cHk2bGgwOVd2Qm93WnNTNnNja3haV1V6emJwalB3?=
 =?utf-8?B?NFdkUFVhak95eE1pVmR2Z0VsOFg0Q0RRdkRYSU5oa0RhbWZ4ZmdBeDhqR0RQ?=
 =?utf-8?B?UFVoUHl5UTZ1RkJwNTdhSk9nanZqbmtmNGVPVW51UWRjZ09CNjZGRjJwZk1G?=
 =?utf-8?B?YVVNSUFidFo4cnl2TUtiRW1EK3FzSU1GOTJranlPWnBSczU5NEd1SDJETWVC?=
 =?utf-8?B?cStRcnlLekJ6Y0R1V2lwOGtsWkIzVXpGQU9nNjlwaWZ5NHNVSUNqellmL0lq?=
 =?utf-8?B?ZkFmcFE4M1pqQXV1Zkx0cU93dW9jYmFFelJTUlFKNVdCUjF5S2dGallvWjQ0?=
 =?utf-8?B?QWgwdXN2V09CYVVEYU56eDlaRHQ3ZE95MjdHZFNMdU1QVlVqWkE5WWJlSnZV?=
 =?utf-8?B?U1lnM3lXNkRiOVZNM3JqTm5KcnY0OUhZZHVJdWloVGpYc2Z1dGI5SmFwQll4?=
 =?utf-8?B?ZWI0OGdnbUlEQlhUR3JDM0lUNk9sNTg5NEJIN2FOZDNNRzVDRFNSSXpBMmRo?=
 =?utf-8?B?VEQ1NTVWMkM0a3Q0Zll6TVA3QVQ2eHVaaWV6dCtmWTQxZEZvcFdaNldkSWFm?=
 =?utf-8?B?bGU2MC9JOGY1a1NQb0VuVVJySmoyQnllRURrQ3JHOXlqY3p6NGJFYUpkSUgr?=
 =?utf-8?B?ZmRpWHM3ekNvMUN6NksrRnJ5NG1HOTFSKzFRc1c0dmM1b1NVT0YwZmw4U2pC?=
 =?utf-8?B?QmZZUkxmaEwzWXpCcllkM0RGRzRvZjlyQTZZYWQyam9UQU5UQ3pwMWVxQ0VR?=
 =?utf-8?B?TFpmMS9lbUVhZXZVc3hZVXBTM1BRNFJhakxDanpxcmRudWM2ZnI5MWV1ZDIr?=
 =?utf-8?B?Nk90bG0zVTZUUXYrRzVnaVRlc2tLd3MwenVTVkMyK3VPVVhOSWpPSEdzd0dz?=
 =?utf-8?B?SUlYRkVJSThGSzN2blpHaDZMc1lTVnFuZndKc2dhSmhYZjlBTjNmZHRON2lL?=
 =?utf-8?B?S1RuQndkMnNHRCtETHBhekpGSG1rYmpza2FGMFJiSU9OSjJydHAvSE9TbDRN?=
 =?utf-8?B?TENEM2JBWG8zaUN3T0tXd1IwNWVmQTRkR2J1WDcwV0U3U05tSDlMM1dYaXBZ?=
 =?utf-8?B?L2FPK0d2NnpKdERCL3E4MmxvN0pnR3oxVWFJck80OElHaXVHSTh2UVFXU3ZN?=
 =?utf-8?B?TnhBeUpsRDh5cTZlT21jVWFFL1ZWUEtIWnp1OWI4dlI0N2VmemNWSi9QeVda?=
 =?utf-8?B?ektjaXYrV1c2K0I0b2l3U2YwM2daVm9TZ3N1YU5mOGpnY0lDdW5HenpHYytp?=
 =?utf-8?B?TTJxczRnNWduOW1Ca2pFQWFoVjNIRDdRRlZOWkxlZ1NmckI4Ni9MczdPUENu?=
 =?utf-8?B?cVFyYmtIVTY2bUFuM3pvNDFTbzBoRVRmUVU0R1V5TnNvMEhHQUdNVDFsT3Jm?=
 =?utf-8?B?MmxGSURXbjloVGs4Z09UQUZGYmFQQ2cwOUczOWRBYm1yNk8xZ2NuVElHeWdS?=
 =?utf-8?B?SFBQdTQzRlQ1SDlGdUZWVGx5dVh2aERVUEFSbDN3UXhZODg4MzZocXhrT2oy?=
 =?utf-8?B?OHlTYVJpMVZYWUplWC9qZEt0M0c2bDc0SVp5WG9KelVoL1VRUW1ENHJlZlN1?=
 =?utf-8?B?MUFZcFh1UkJ0UWtUSlo1NG9JMnpZT0IvcmppdWJhVWJ3RUQxOWQ0TWEwZjkx?=
 =?utf-8?B?blVjdGQrTG5vam9oZElzMUQxVGZWbEVDcWxvcjBkUHpCa3RRc2ZuSThPRWxn?=
 =?utf-8?Q?/2tt8kuSfArq0zHVaOt7gKneY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d12387-10e3-46a4-0f33-08dcc0331e29
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 09:41:36.1277 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H3SWHt4kjVs0/uTN9FORshYKCyFefxPKmh/nfDgdnjjHz7Lq8Xmfc4dDKwgan//7Zstt/iPrP0kqxHVUH64uthu/wrg4VwyKED8ACNpfKT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6667
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMTYvMTddIGludGVsX2lvbW11
OiBJbnRyb2R1Y2UgYSBwcm9wZXJ0eSB0byBjb250cm9sDQo+RlMxR1AgY2FwIGJpdCBzZXR0aW5n
DQo+DQo+T24gMjAyNC84LzE1IDExOjQ2LCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pg0KPj4N
Cj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IExpdSwgWWkgTCA8eWku
bC5saXVAaW50ZWwuY29tPg0KPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMTYvMTddIGludGVs
X2lvbW11OiBJbnRyb2R1Y2UgYSBwcm9wZXJ0eSB0bw0KPmNvbnRyb2wNCj4+PiBGUzFHUCBjYXAg
Yml0IHNldHRpbmcNCj4+Pg0KPj4+IE9uIDIwMjQvOC81IDE0OjI3LCBaaGVuemhvbmcgRHVhbiB3
cm90ZToNCj4+Pj4gV2hlbiBob3N0IElPTU1VIGRvZXNuJ3Qgc3VwcG9ydCBGUzFHUCBidXQgdklP
TU1VIGRvZXMsIGhvc3QNCj4+PiBJT01NVQ0KPj4+PiBjYW4ndCB0cmFuc2xhdGUgc3RhZ2UtMSBw
YWdlIHRhYmxlIGZyb20gZ3Vlc3QgY29ycmVjdGx5Lg0KPj4+DQo+Pj4gdGhpcyBzZXJpZXMgaXMg
Zm9yIGVtdWxhdGVkIGRldmljZXMsIHNvIHRoZSBhYm92ZSBzdGF0ZW1lbnQgZG9lcyBub3QNCj4+
PiBiZWxvbmcgdG8gdGhpcyBzZXJpZXMuIElzIHRoZXJlIGFueSBvdGhlciByZWFzb24gdG8gaGF2
ZSB0aGlzIG9wdGlvbj8NCj4+DQo+PiBHb29kIGNhdGNoLCB3aWxsIHJlbW92ZSB0aGlzIGNvbW1l
bnQuDQo+PiBJbiBmYWN0LCB0aGlzIHBhdGNoIGlzIG1haW5seSBmb3IgcGFzc3Rocm91Z2ggZGV2
aWNlIHdoZXJlIGhvc3QgSU9NTVUNCj5kb2Vzbid0IHN1cHBvcnQgZnMxZ3AuDQo+DQo+SSBzZWUu
IFRvIG1lLCBhcyBsb25nIGFzIHRoZSB2SU9NTVUgcGFnZSB3YWxrIGxvZ2ljIHN1cHBvcnRzIDFH
UCBsYXJnZQ0KPnBhZ2VzLCBpdCdzIG9rIHRvIHJlcG9ydCB0aGUgRlMxR1AgY2FwIHRvIFZNLiBC
dXQgaXQgaXMgc3RpbGwgZmluZSB0bw0KPmhhdmUgdGhpcyBwcm9wZXJ0eSB0byBvcHQtb3V0IEZT
MUdQIGlmIGFkbWluL29yY2hlc3RyYXRpb24gbGF5ZXIoZS5nLiBsaWJ2aXJ0KQ0KPmtub3dzIG5v
IGh3IGlvbW11IGhhcyB0aGlzIGNhcGFiaWxpdHksIHNvIGl0IGlzIGJldHRlciB0byBvcHQgb3V0
IGl0DQo+YmVmb3JlIGludm9raW5nIFFFTVUuDQo+DQo+SXMgdGhpcyB5b3VyIG1vdGl2YXRpb24g
Zm9yIHRoaXMgcHJvcGVydHk/DQoNCkV4YWN0bHkuDQoNCj4NCj4+Pg0KPj4+PiBBZGQgYSBwcm9w
ZXJ0eSB4LWNhcC1mczFncCBmb3IgdXNlciB0byB0dXJuIEZTMUdQIG9mZiBzbyB0aGF0DQo+Pj4+
IG5lc3RlZCBwYWdlIHRhYmxlIG9uIGhvc3Qgc2lkZSB3b3Jrcy4NCj4+Pg0KPj4+IEkgZ3Vlc3Mg
eW91IHdvdWxkIG5lZWQgdG8gc3luYyB0aGUgRlMxR1AgY2FwIHdpdGggaG9zdCBiZWZvcmUgcmVw
b3J0aW5nDQo+aXQNCj4+PiBpbiB2SU9NTVUgd2hlbiBjb21lcyB0byBzdXBwb3J0IHBhc3N0aHJv
dWdoIGRldmljZXMuDQo+Pg0KPj4gWWVzLCB3ZSBhbHJlYWR5IGhhdmUgdGhpcyBjaGVjaywgc2Vl
DQo+aHR0cHM6Ly9naXRodWIuY29tL3lpbGl1MTc2NS9xZW11L2NvbW1pdC9iN2FjN2NlM2EyZTIx
ZWIxYjMxNzI3NDMNCj5lZTZmNzNlODBmZTY3YjNhDQo+DQo+Z29vZCB0byBrbm93IGl0LiA6KSBX
aWxsIHlvdSBmYWlsIHRoZSBWTSBpZiB0aGUgZGV2aWNlJ3MgaW9tbXUgZG9lcyBub3QNCj5zdXBw
b3J0IEZTMUdQIG9yIGp1c3QgbWFzayBvdXQgdGhlIEZTMUdQPw0KDQpGb3IgY29sZCBwbHVnZ2Vk
IFZGSU8gZGV2aWNlLCBpdCB3aWxsIGZhaWwgdGhlIFZNIHdpdGggIlN0YWdlLTEgMUdCIGh1Z2Ug
cGFnZSBpcyB1bnN1cHBvcnRlZCBieSBob3N0IElPTU1VIiBlcnJvciByZXBvcnQuDQpGb3IgaG90
cGx1ZyBWRklPIGRldmljZSwgb25seSBob3RwbHVnIGZhaWxzIHdpdGggIlN0YWdlLTEgMUdCIGh1
Z2UgcGFnZSBpcyB1bnN1cHBvcnRlZCBieSBob3N0IElPTU1VIi4NCg0KV2UgZG9uJ3QgdXBkYXRl
IHZJT01NVSBjYXAvZWNhcCBmcm9tIGhvc3QgY2FwL2VjYXAgcGVyIE1pY2hhZWwncyBzdWdnZXN0
aW9uLCBvbmx5IHZJT01NVSBwcm9wZXJ0aWVzIGNhbiBjb250cm9sIHRoZW0uDQoNClRoYW5rcw0K
Wmhlbnpob25nDQo=

