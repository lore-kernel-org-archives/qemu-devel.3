Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA86EF99F2
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 02:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr5PH-0000Nv-SY; Fri, 13 Feb 2026 21:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vr5PF-0000NU-Uh
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:29:13 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vr5PC-0001NU-VG
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:29:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771036151; x=1802572151;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1VTsEmVygtNmMq2A2lv0/frcoeXC8CTEuN4mi7rZiZk=;
 b=H2VVJmF6Y8uO/83IxOeXwtPSc0vIMuQPM/JJChOe6czkGI4sKIXuOVnF
 N7uyGKVOKI6O35cFh3tPTH8aaGMqOBs8t7q1Dd/APlbAXXS221rA+hNob
 KNM5NHJSWQ+QysDQGC3m3kelIS+AEwmCe/FgeoU6N0NuyJFHOX8Yf5j4t
 k2tD6PPEuE2GsTuBtCY1vFnxSNSU5izFW01gbumxSryQtEOWwoAlKr1cy
 Jhf9p2bI83Klu/OLThLHoVyeJpD6GjrvOeUJ7Z1AmVGu8wmifPGL44+58
 yVlMMcQo48tkBhPUVZ6VSkTs3hsThsfBtIk0iez6LkZCtiIYOgJ2TA62n A==;
X-CSE-ConnectionGUID: ujhS/H5rR4Oe5Ut936OvyA==
X-CSE-MsgGUID: Hkr3d4LZTZSXjq0j252wAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="89632457"
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; d="scan'208";a="89632457"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 18:29:08 -0800
X-CSE-ConnectionGUID: UyStzMExRh+3LQ79l/uuaQ==
X-CSE-MsgGUID: Z0YtfzdoT/GUB1YRhSsqkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; d="scan'208";a="213183050"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 18:29:08 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 18:29:07 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 13 Feb 2026 18:29:07 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.61) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 18:29:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTy7hwAnfZHuO2SaYo13yuma+ZNxN01ejbJaYRs4nni3Y36oUIx4zQw2J2sJXgw64xL/WirJEvGjr8Q9DDsZZkzORELSuELWL0kTV9rjCuwh2cJlzYKhRO9YvvXtBffbnKOnggcvXFNDXaTKMGblJZgMXYxrlAvGIYwtX4orTXQE6eF5EswQb9IcCkl9nWwp3nQ7avMS+2aFfMwkT7qwRvykLMcFQ2eulnCYbe7pCa/fuSe9tHmtvXDJRIP75DXhQx/YHN0kgbcvfZaJXIsGUy7ASTDtsk8eyxBZZRfML3zdAF4vtwZ7v07jhfpA/fQwSaV5pREFlrppUea7HGWp5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VTsEmVygtNmMq2A2lv0/frcoeXC8CTEuN4mi7rZiZk=;
 b=ANHwJgWC5yjqeW8GiofgGtxyttfPp+mxjYJVAqp12itS6XOUQy2e1XqTWRNHpCO4VXBEJQcgTzh50vE2bGyXV5/O1wI7iMBhCm8YF6msU0uoewd6J5YWf4kh/ZbE132UB9KgRsIRYrNFIKbRMiy1bJLBYvZmTusJ9Hwr4UWgeusjNC7ZdgOG/FNKMnbXSMvPqulcVFFC9kkNGO9urFrqQlVpgHfVtnSTeZlKl1aofDMBamhPkIHKkGRiaUd0EzLUXbotAO/TwLPL2mhqOPe3yDsTUV1kXxkq+XOzoTRms1Cb9tZiNyAN5RT0Y0aWvxogqIbkdGvtQKXJWVkV1kPCuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CH3PR11MB8749.namprd11.prod.outlook.com (2603:10b6:610:1c9::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Sat, 14 Feb
 2026 02:29:03 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9611.013; Sat, 14 Feb 2026
 02:29:03 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao,
 Xudong" <xudong.hao@intel.com>
Subject: RE: [RFC PATCH 03/14] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Thread-Topic: [RFC PATCH 03/14] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Thread-Index: AQHclk1HX8laRIx0MU+iiNOPP72pr7WAp58AgADakVA=
Date: Sat, 14 Feb 2026 02:29:03 +0000
Message-ID: <IA3PR11MB9136BF9260AF44C1F3546022926EA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260205031133.74357-1-zhenzhong.duan@intel.com>
 <20260205031133.74357-4-zhenzhong.duan@intel.com>
 <87309142-6457-447b-ac04-8bd51b983a80@redhat.com>
In-Reply-To: <87309142-6457-447b-ac04-8bd51b983a80@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CH3PR11MB8749:EE_
x-ms-office365-filtering-correlation-id: 0859e05c-3493-4876-efd0-08de6b70d1f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?OHFHOFBFZTBpZ2hQaEtDNk5DcDJicG00ZnJCNkpJT3dod3hnSndTSmF6SDVN?=
 =?utf-8?B?TjBveHh0eVV6eDBQTjdUaWtqbTNuZVBQU25GNmZzZU0yZmltSnZHTDFNZXV3?=
 =?utf-8?B?M3ppempYYldJQ2Z1YW95ek54Q3pEaE0yanpHdlRUaS9xU3dyMGxpaElOV0dr?=
 =?utf-8?B?dDVZR2xZelR5eWI1TTIvcC9Oa1o1bXIrNkxGTGdBQ0p0TGUxeDllY2IwbXR2?=
 =?utf-8?B?am9hWVBhQTB5S1MzTisvWTV1SmIrRHMzTDQ3UlZscWxodEdEZ05ERHIxUkJr?=
 =?utf-8?B?VzFKQTNWOSt6T3NDQ282b2N4R3VKT0RvL0Y2OUlFYmM4cEVHWmVnWFhvbUVa?=
 =?utf-8?B?RFhzcjN6UlBzV2hWNlZoNTVhbHpQUlpPR0V0VU8yM0FsZHgwbUVnYjB6dVh1?=
 =?utf-8?B?M0hadTkrbXJtV1RuVVhXWFR3ZHZpd0w4cFc0eTByWjBWUEZLNzRPQ2pzdXgz?=
 =?utf-8?B?d2JMTnFnSllqOUVkbWpGWHhHajAreXUzS0JjamJwWFUxWjRXSVF6TllpMUZB?=
 =?utf-8?B?c2FuSHYvTlNtZEhmVkF0eTBXck1RTXJUd3ZkVitDUjlURTQ0VWxGYXZjZ01y?=
 =?utf-8?B?aGlLdVZpQXExWHhRc1hIZEVGYzNsSk9CblFqQ2YxQ3dTNW41RW5jNUxNZlN0?=
 =?utf-8?B?eEFWMkl3VTVoVlVuRjdjOWxDd25xanhRT2pWYTZ1bHh2SFV2VXhMMjEyZUF2?=
 =?utf-8?B?Y1B4YkNzMS9EK0ZSVTlnMDZnQlpublF6ZHJzTDVBeEduWDF1MkhtcmNNYjhC?=
 =?utf-8?B?Vm1QcmJOeXErbUdNSGNyR213a0FoZU1nU2tyUTkxVThRMEM0cWRLRThuTW5t?=
 =?utf-8?B?a0NxbW05WDdaZnh4bmZlbkd6cUQyNHAxaEhNNFR2Tm1iMndpWDFISVdWYUNv?=
 =?utf-8?B?cTZERGxlOVd0a201YkF3TVpNVVhxM3JEMis5b0tvbzdUM2NKSlR0RmRzNnRs?=
 =?utf-8?B?SUVBKzIyMXNZbVN2bXVENlNLM3hFSTQvRXNHa25kYmhkY3IzbmlkdWh6TVNM?=
 =?utf-8?B?eW14MnZwNTNFcnl3YmNCVUFEZEVMOVo4NEFiUkRhdnJsUmJXNVR1R2JXY3F6?=
 =?utf-8?B?RUdlaFRzSXRsQk1yMEFKV1BQUk5jUzNQZXFzTzBycjh6NDRhQ2U2eWlVRm9z?=
 =?utf-8?B?UDY4QjJKN04zYXAxKzJTVVF3bzFwUFh2czh1VEMwcWNVNVR4dWxteml4L1pk?=
 =?utf-8?B?TTZXUXlsUkQ2L200WE0zditkMmtqYmc2VlFrRENmVE5BbHJkM05WZnNoODlG?=
 =?utf-8?B?b2V0aHVvMjA1MG9FUndMOUlXcE9tSG5CVVRlenNLYU9hUTZweGR6TURmUmtL?=
 =?utf-8?B?QWliaFZIK0ltRHZQbDRkVVMvMkNEZzJPZkpMTzdiWDRaY2xpMlY0eWVhTkhj?=
 =?utf-8?B?cDh6czFoYzF3MHA0N3ZmRHQ4Q2pwVTBOTDNTYkJ4QWx2TFR3M0ZlWDZZUGNT?=
 =?utf-8?B?dVB1d1lHRWZiT0tRNFlzVmt3ZVlsMjZwcmQ3NTVGeU1NQ1RJUUdqVDVkME5t?=
 =?utf-8?B?cDArTmhyOWxXVTdGbWFsbUN0bHJhVWtRT3VVSkw2dXdKNktJNFR4NGFSUS9L?=
 =?utf-8?B?RzdoYytSc3FGamNsNmpNS1ZPSDZWb2o4YlZXUHBCc2xldDhBdmZqRndMWWc2?=
 =?utf-8?B?dHZXLzF5bmhuUjJLSkxZelR6ZjBseUlndWx3NlVKTURmMndlM0tEL0NERlU3?=
 =?utf-8?B?bUIwMGUvbElCUjBYVmpHSk54RENubExyL004RDczaGxoWi8xUWtDdHYyN2g0?=
 =?utf-8?B?OXRQQWFESXBFQjY5cDZRMndsQkZYdGE2QWRTR3g2M3pxaUdjZUNWRW1hdC94?=
 =?utf-8?B?RzNaUG9mQkVuNE03YW5pV0w2S01SUG9uYTNGcEtDVFRadjgwcktOeTlMKzNZ?=
 =?utf-8?B?ZFpGQzQ4SlhSWExPdiswaWZKTG5LN3Nubnd0dGxYOGQ1czJ6THdwU1B4RHNl?=
 =?utf-8?B?cVkwblFPZXdEd1pUd3FNcmJweGkyNzdGcEpybFVhZGlGMXZ0dlQ2UURGWEp1?=
 =?utf-8?B?UEUzS0VRbXNCNjRESkNvRVlKUWxFVG0zSTV1WGNURmRPLzAzbXRIVXZsR3JG?=
 =?utf-8?B?NE1pbXBOSUkrd2pvblJaNzBXcDBNcE9ZdXFySHMybXFiclB1ZGhvUjNJWml0?=
 =?utf-8?B?T1daQis2NkVjUFR5M1hsVTFFOG5RNHpScXQyeGxuYTJBUk0xZUdBcnU4UDgx?=
 =?utf-8?Q?zYvyBHbzoxALHiIZimrrCbQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmsvUlQyRzF5NEFJbDZ0Q0tndFMrNExYOG9aenZoTXVtY3ptQXM1VHdWMGZG?=
 =?utf-8?B?MkxtanBhajRhRGdSUHM5ZmIrRTA5U3ZPOHM4UGNlWW9WdzV5SW1TOVR2b2F3?=
 =?utf-8?B?ekVyRmxiSkVOU04vWEIwM3RpaFBaUlFxcFlKODZNMW90K0Q1TmNmUzNoVGJw?=
 =?utf-8?B?OHg3a1RLNkora0lQWlN3QXE3bWtOQnpHNVZMYXhmZU1OL0xkYytlWk5XL2xE?=
 =?utf-8?B?RjB6OVF1TGo0WU5mZVlpdlFyR2RUZ2ZYb05oS1ROb2VIczRzc3Z2VFp2MEFE?=
 =?utf-8?B?YVdXUXhJWk5lSlFPV05nRC9NdW5acGhORXppRk9zcHN2ZGNKMW0xWE5XZ1FS?=
 =?utf-8?B?QTVHQlpib1pzbWtRaDF0WnIvdG4ydGY2VDZPeXN6aFp1czRSVUFCdG45YXFh?=
 =?utf-8?B?YlRycnRFSkhRZCtxYkxtZzZlNjJEMnFXTld4elNzOE11ZmRsTS9wRUVhZVZ5?=
 =?utf-8?B?MjFrZXdudDhBTTh2TnQ3bVJUM0pCM2NxR2lwSU5SWE9nbU5Uc2g1THlKR0tk?=
 =?utf-8?B?VmVXSFNuSUpFTXlRaVdUWEdwWWpKeThCcmwvVU9CYjdyTld0Z3BHeUo2VTdq?=
 =?utf-8?B?aWNXNlRMK2lvNTkxRXJMbjdFWVZSZWdMMFdSUFhSYWxLUEVzZytxU0EwUklS?=
 =?utf-8?B?VmpJbkZYT2p6LzlpdXZ2NDZudm00SXlwQmFmd3ZEWG80SWpMaURmVTM3YmIy?=
 =?utf-8?B?VXNXZWU5MitPeUpOWWdRVXdRVXo4NmdTTFNsaE9ldkpKbmhGc2pzQ0MreXlD?=
 =?utf-8?B?bXJuRWlzeUh4U2cxdnFvZWtsNVdCUFRlalZ5UmdpdXFEWmo2QnRDMWtGZW1Q?=
 =?utf-8?B?NGhudTR6OEx3L01QVzZzTVlPWXE1RHdOTE5PZHk2eklwNmVYbllWT3lpTGFk?=
 =?utf-8?B?RzF2eDhVY0J5VFdGN3l0VmJIdGZJZDVYR2RLcXdpcUJ5eldyZEhxS3YzS0ps?=
 =?utf-8?B?b2ZmaUMwRkt2YUxUMHRJTWpvRVEzWUhJZ0xvUDh4dVlpMXk3M3R3Z0g2KzEz?=
 =?utf-8?B?UHRzNzljQ3NLQUtTYzdOZ2ZnRG1kZ1JORCt4blNlOFIxZWtNQmM2eFZoS20y?=
 =?utf-8?B?Tk92ZUFwb3JLUVpQM2JWY2RnOXpnR0ZZZ2V0amExVENOanNMY1ZpWm1ES3ZO?=
 =?utf-8?B?eEVlVW5iNHQwb0JnQkg1Ky9LYWx5U0dIcHR6eVRLWHNwYVRsbHRkVzZVcWZF?=
 =?utf-8?B?VUlXb2Z2YU5vUzVYdDdndG4wTDd3UU1WVGpuNm5Zd2lGUk9JZjJ0MDJkQXlK?=
 =?utf-8?B?ckF6T3BxQzJxSEhPN1g2SWgyRFZHVjg1Rkw2eEgxa0d6QjQrTXFkaVRHNHJB?=
 =?utf-8?B?a3hCVUNlQ2ZJdTFhNFJEaTB4bFN0M0pzcUtLRUoxYWlKTmNISWdwN1EzY2lp?=
 =?utf-8?B?RjNndEdWdEpwZWFOU2ZVTy9yZksrZWNrSU9oS2lXckoxUHBGL3RUdTB5VGRV?=
 =?utf-8?B?TEJRdkJ0d0VOUUVyQ3piQkYxOWpZL2ZDSWlSUU0zbDNaZkw4bGJnSDRFT3Z3?=
 =?utf-8?B?K3ZiS3FRbUsxVDdJUkdFUXJYbVRad2pCR2dkZXEzVVcyU25kd2ZGbVZJbDBM?=
 =?utf-8?B?eUdGUmx5QVJ2NmRVUkdqR1ZKVnBUSE1KeFNCMFh1cnJRbCtVNVhzS2NJU1Js?=
 =?utf-8?B?QytZSGhLa2tLL1JNNHQ4ZzNpMGVxWFBSdlFtc2x0c0o2Vnh3ZDhybTZyQXpV?=
 =?utf-8?B?UDJLdGo1SmpDZ2cyWlNyQUI4Z3NOQmtXdkY1aDdjaVBPcmlGZ01DMnd4VE40?=
 =?utf-8?B?VG1zMGMxV2NCR2ZiTUFMZjAzS0xHdVd5RXFkRWZjdjNuN1RMV3BTV01YRkVS?=
 =?utf-8?B?RUhCQVlvYVNlV3dIMGRwR1VDeXJRcm9CUGdoT1NldjZKd3dCUDNyYmpoU3l1?=
 =?utf-8?B?NTZUMVN5MGpBNXJJSUExQmtSS2FJc2svczVTWFVCL2owaENpUjVBcDhjVEFM?=
 =?utf-8?B?N0VZc3IyOXN4bTdpUkwyVURMY0k2clV3cEpERGQrS3prdW5GUWtBNzkwYm5z?=
 =?utf-8?B?QVk3U1Jwa2lHS2hTTWlMUjRPUkxPZElDMFgyR1FFV1ZVVGkwdithajZ5RXU5?=
 =?utf-8?B?bTZzL0g2ekJxTmpvNW1Cc3dsaVFYd01vRE5hcm9YUjdEcC9QMS9qazJIdExy?=
 =?utf-8?B?V2RDVGxWSUlETFREQy9NMW45SVZ2WjhyRmhrNjV4ZU1pMEw2UEJkOGl5cXp2?=
 =?utf-8?B?SmZtaVZNT2xTNUpXbDgwU3J0K0VVTzlyR2dNZFpIZkZvZWVJYVBGbnQ5czJ1?=
 =?utf-8?B?bEFNSnF5Vm94RDN0OW95NFNoZzVuT09taHZmZThvMHJpcmR4Rm1GVnY2V3k3?=
 =?utf-8?B?Q2pzN05YOHo0RlN6N1EvdVpGQUlSY2JBaUw4d1lmRHZReFVQVytMUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0859e05c-3493-4876-efd0-08de6b70d1f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2026 02:29:03.6342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/CfEbOqoBDoLxACzQ4VOyaKlE6KIo2DZkizkMXQAIoUlguiTMXYGdW29ij6/GMjhVUxVfhLzf0ugR1J9nRAc7Jfoa4+qJ3S/8Rzfdhjgn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8749
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAwMy8xNF0gdmZpby9p
b21tdWZkOiBDcmVhdGUgbmVzdGluZyBwYXJlbnQgaHdwdCB3aXRoDQo+SU9NTVVfSFdQVF9BTExP
Q19QQVNJRCBmbGFnDQo+DQo+T24gMi81LzI2IDA0OjExLCBaaGVuemhvbmcgRHVhbiB3cm90ZToN
Cj4+IFdoZW4gYm90aCBob3N0IGRldmljZSBhbmQgdklPTU1VIGhhdmUgUEFTSUQgZW5hYmxlZCwg
dGhlbiBndWVzdCBtYXkNCj4+IHNldHVwIHBhc2lkIGF0dGFjaGVkIHRyYW5zbGF0aW9uLg0KPj4N
Cj4+IFdlIG5lZWQgdG8gY3JlYXRlIHRoZSBuZXN0aW5nIHBhcmVudCBod3B0IHdpdGggSU9NTVVf
SFdQVF9BTExPQ19QQVNJRA0KPj4gZmxhZyBiZWNhdXNlIGFjY29yZGluZyB0byB1QVBJLCBhbnkg
ZG9tYWluIGF0dGFjaGVkIHRvIHRoZSBub24tUEFTSUQNCj4+IHBhcnQgb2YgdGhlIGRldmljZSBt
dXN0IGFsc28gYmUgZmxhZ2dlZCwgb3RoZXJ3aXNlIGF0dGFjaGluZyBhIFBBU0lEDQo+PiB3aWxs
IGJsb2NrZWQuDQo+Pg0KPj4gSW50cm9kdWNlIGEgdmZpb19kZXZpY2VfZ2V0X3Zpb21tdV9mbGFn
c19wYXNpZF9zdXBwb3J0ZWQoKSBoZWxwZXIgdG8NCj4+IGZhY2lsaXRhdGUgdGhpcyBpbXBsZW1l
bnRhdGlvbi4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25n
LmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgIGluY2x1ZGUvaHcvdmZpby92ZmlvLWRldmlj
ZS5oIHwgIDEgKw0KPj4gICBody92ZmlvL2RldmljZS5jICAgICAgICAgICAgICB8IDExICsrKysr
KysrKysrDQo+PiAgIGh3L3ZmaW8vaW9tbXVmZC5jICAgICAgICAgICAgIHwgIDggKysrKysrKy0N
Cj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWRldmljZS5oIGIvaW5jbHVk
ZS9ody92ZmlvL3ZmaW8tZGV2aWNlLmgNCj4+IGluZGV4IDM1YTVlYzZkOTIuLjk4M2ViMGVjY2Ug
MTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1kZXZpY2UuaA0KPj4gKysrIGIv
aW5jbHVkZS9ody92ZmlvL3ZmaW8tZGV2aWNlLmgNCj4+IEBAIC0yNjgsNiArMjY4LDcgQEAgdm9p
ZCB2ZmlvX2RldmljZV9wcmVwYXJlKFZGSU9EZXZpY2UgKnZiYXNlZGV2LA0KPlZGSU9Db250YWlu
ZXIgKmJjb250YWluZXIsDQo+PiAgIHZvaWQgdmZpb19kZXZpY2VfdW5wcmVwYXJlKFZGSU9EZXZp
Y2UgKnZiYXNlZGV2KTsNCj4+DQo+PiAgIGJvb2wgdmZpb19kZXZpY2VfZ2V0X3Zpb21tdV9mbGFn
c193YW50X25lc3RpbmcoVkZJT0RldmljZSAqdmJhc2VkZXYpOw0KPj4gK2Jvb2wgdmZpb19kZXZp
Y2VfZ2V0X3Zpb21tdV9mbGFnc19wYXNpZF9zdXBwb3J0ZWQoVkZJT0RldmljZSAqdmJhc2VkZXYp
Ow0KPj4gICBib29sIHZmaW9fZGV2aWNlX2dldF9ob3N0X2lvbW11X3F1aXJrX2J5cGFzc19ybyhW
RklPRGV2aWNlICp2YmFzZWRldiwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdWludDMyX3QgdHlwZSwgdm9pZCAqY2FwcywNCj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3Qgc2l6ZSk7
DQo+PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9kZXZpY2UuYyBiL2h3L3ZmaW8vZGV2aWNlLmMNCj4+
IGluZGV4IDk3M2ZjMzViNTkuLmIxNWNhNmVmMGEgMTAwNjQ0DQo+PiAtLS0gYS9ody92ZmlvL2Rl
dmljZS5jDQo+PiArKysgYi9ody92ZmlvL2RldmljZS5jDQo+PiBAQCAtNTMzLDYgKzUzMywxNyBA
QCBib29sDQo+dmZpb19kZXZpY2VfZ2V0X3Zpb21tdV9mbGFnc193YW50X25lc3RpbmcoVkZJT0Rl
dmljZSAqdmJhc2VkZXYpDQo+PiAgICAgICByZXR1cm4gZmFsc2U7DQo+PiAgIH0NCj4+DQo+PiAr
Ym9vbCB2ZmlvX2RldmljZV9nZXRfdmlvbW11X2ZsYWdzX3Bhc2lkX3N1cHBvcnRlZChWRklPRGV2
aWNlICp2YmFzZWRldikNCj4+ICt7DQo+PiArICAgIFZGSU9QQ0lEZXZpY2UgKnZkZXYgPSB2Zmlv
X3BjaV9mcm9tX3ZmaW9fZGV2aWNlKHZiYXNlZGV2KTsNCj4+ICsNCj4+ICsgICAgaWYgKHZkZXYp
IHsNCj4+ICsgICAgICAgIHJldHVybiAhIShwY2lfZGV2aWNlX2dldF92aW9tbXVfZmxhZ3MoUENJ
X0RFVklDRSh2ZGV2KSkgJg0KPj4gKyAgICAgICAgICAgICAgICAgIFZJT01NVV9GTEFHX1BBU0lE
X1NVUFBPUlRFRCk7DQo+PiArICAgIH0NCj4+ICsgICAgcmV0dXJuIGZhbHNlOw0KPj4gK30NCj4+
ICsNCj4+ICAgYm9vbCB2ZmlvX2RldmljZV9nZXRfaG9zdF9pb21tdV9xdWlya19ieXBhc3Nfcm8o
VkZJT0RldmljZSAqdmJhc2VkZXYsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHR5cGUsIHZvaWQgKmNhcHMsDQo+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHNpemUp
DQo+PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9pb21tdWZkLmMgYi9ody92ZmlvL2lvbW11ZmQuYw0K
Pj4gaW5kZXggOTY3MzVmMWZjOC4uOTYwNWJmNzNiNyAxMDA2NDQNCj4+IC0tLSBhL2h3L3ZmaW8v
aW9tbXVmZC5jDQo+PiArKysgYi9ody92ZmlvL2lvbW11ZmQuYw0KPj4gQEAgLTM1NCw2ICszNTQs
NyBAQCBzdGF0aWMgYm9vbA0KPmlvbW11ZmRfY2Rldl9hdXRvZG9tYWluc19nZXQoVkZJT0Rldmlj
ZSAqdmJhc2VkZXYsDQo+PiAgICAgICBWZW5kb3JDYXBzIGNhcHM7DQo+PiAgICAgICBWRklPSU9B
U0h3cHQgKmh3cHQ7DQo+PiAgICAgICB1aW50MzJfdCBod3B0X2lkOw0KPj4gKyAgICB1aW50OF90
IG1heF9wYXNpZF9sb2cyOw0KPg0KPkkgdGhpbmsgdGhpcyBzaG91bGQgYmUgaW5pdGlhbGl6ZWQg
dG8gc29tZSBkZWZhdWx0IHZhbHVlLg0KDQpPSywgd2lsbCBhZGQgbWF4X3Bhc2lkX2xvZzIgPSAw
Ow0KDQo+DQo+PiAgICAgICBpbnQgcmV0Ow0KPj4NCj4+ICAgICAgIC8qIFRyeSB0byBmaW5kIGEg
ZG9tYWluICovDQo+PiBAQCAtMzk4LDcgKzM5OSw3IEBAIHN0YXRpYyBib29sDQo+aW9tbXVmZF9j
ZGV2X2F1dG9kb21haW5zX2dldChWRklPRGV2aWNlICp2YmFzZWRldiwNCj4+ICAgICAgICAqLw0K
Pj4gICAgICAgaWYgKCFpb21tdWZkX2JhY2tlbmRfZ2V0X2RldmljZV9pbmZvKHZiYXNlZGV2LT5p
b21tdWZkLCB2YmFzZWRldi0NCj4+ZGV2aWQsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgJnR5cGUsICZjYXBzLCBzaXplb2YoY2FwcyksICZod19jYXBzLA0K
Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCwgZXJycCkp
IHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZtYXhfcGFz
aWRfbG9nMiwgZXJycCkpIHsNCj4+ICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+PiAgICAgICB9
DQo+Pg0KPj4gQEAgLTQyMCw2ICs0MjEsMTEgQEAgc3RhdGljIGJvb2wNCj5pb21tdWZkX2NkZXZf
YXV0b2RvbWFpbnNfZ2V0KFZGSU9EZXZpY2UgKnZiYXNlZGV2LA0KPj4gICAgICAgICAgIH0NCj4+
ICAgICAgIH0NCj4+DQo+PiArICAgIGlmIChtYXhfcGFzaWRfbG9nMiAmJg0KPj4gKyAgICAgICAg
dmZpb19kZXZpY2VfZ2V0X3Zpb21tdV9mbGFnc19wYXNpZF9zdXBwb3J0ZWQodmJhc2VkZXYpKSB7
DQo+DQo+Q2FuIGFuIElPTU1VIGJhY2tlbmQgbm90IHN1cHBvcnQgUEFTSUQgd2hpbGUgdGhlIHZJ
T01NVSBkZXZpY2UgZG9lcyA/DQo+VGhhdCB3b3VsZCBiZSBhIHByb2JsZW0gbm8gPw0KDQpJZiBJ
T01NVSBiYWNrZW5kIGRvZXNuJ3Qgc3VwcG9ydCBQQVNJRCwgbWF4X3Bhc2lkX2xvZzIgd2lsbCBi
ZSAwIHJldHVybmVkIGJ5IGdldF9kZXZpY2VfaW5mbygpLg0KVGhlbiBRRU1VIHdpbGwgbm90IGV4
cG9zZSB2UEFTSUQgY2FwYWJpbGl0eSBvZiBWRklPIGRldmljZSB0byBndWVzdCwgdGhlbiBndWVz
dCBjYW5ub3QgZW5hYmxlIFBBU0lEIG9uIHRoaXMgVkZJTyBkZXZpY2UgZXZlbiB0aG91Z2ggdklP
TU1VIHN1cHBvcnQgUEFTSUQuDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4NCj4+ICsgICAgICAg
IGZsYWdzIHw9IElPTU1VX0hXUFRfQUxMT0NfUEFTSUQ7DQo+PiArICAgIH0NCj4+ICsNCj4+ICAg
ICAgIGlmIChjcHJfaXNfaW5jb21pbmcoKSkgew0KPj4gICAgICAgICAgIGh3cHRfaWQgPSB2YmFz
ZWRldi0+Y3ByLmh3cHRfaWQ7DQo+PiAgICAgICAgICAgZ290byBza2lwX2FsbG9jOw0KDQo=

