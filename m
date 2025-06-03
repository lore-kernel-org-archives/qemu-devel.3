Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A627C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPMw-0006ZC-Kb; Tue, 03 Jun 2025 06:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMPMu-0006Yl-5B
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 06:59:44 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMPMq-0001oQ-Tz
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 06:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748948381; x=1780484381;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mPGHHSSTXET4rwWifaKS36FEFxNJVrVRGdo7tobruDA=;
 b=n5QaGKG2XUn81MlAYPjrGdGJTOWLPOkETCRgMMYeCEC6C8uaE2jSTrBE
 yjtgW0pc9pWMLraNYoDeZ1HGGbU4KPRjNAQn9qJdyVJNFKpRxUlu8mWkV
 gCmTS6ZX6vXmKy3IcjyXq2USW0FT0IQ7bkV4mi6fIqmvLZP2BUaNEBTjd
 1J1Zsyx3+NzvZEKhxGqMgzcmJzxI4jo8mAp4/At0Tyz9YYFpoYIhMlhv8
 19/OJCnywuARfTpn00DMt+GVcF8t2q56kHdCucPIOBgVXLHVKPBWzldTR
 DuWrPFSOGkoJsBo3rX69m20OXW4brJ7ZoDHMY/JIhG0m9F/RlbzEYK+yZ A==;
X-CSE-ConnectionGUID: YJsPSSp/SOKRxVI6yy+MfQ==
X-CSE-MsgGUID: TORGV0mKSKC/G4uSasdE9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="68535777"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="68535777"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 03:59:36 -0700
X-CSE-ConnectionGUID: iCJMYrTiTmGAp2Ko/R2NMg==
X-CSE-MsgGUID: DrEqGprlRvyef/7VSjAmWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="149981186"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 03:59:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 03:59:35 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 03:59:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.42)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 03:59:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMVOQTmowPVjogh+rtoyW77uGodfihGv+3oXdtixmtsct2emAWEH8VgSHiBRFUveeQrLLLNSsqMYkUBJJR3F6PqLX4le73+NvNDt742hMkkNq1WDPDZm5uBNinF5K/UzfzonB7IEufDs38+6HbrVXmvZobFkVMasiaZqsCoKRxY+NtlYBYLrcB18djLwX1Fbr+fFqMWc00XnGcdtd7Iy9Li8horCPK8BXejkLATLs79tNMi9N/17SIxDO9mOGcVQm5w5kQFMTJStoDPeS4RHdyj2HfO1SrlwTQHrSMq6KKFLKDlOu5FuRlV77Cwcqx1BIrBeFSfM5PoVryUKHTC1uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPGHHSSTXET4rwWifaKS36FEFxNJVrVRGdo7tobruDA=;
 b=rpuMhgoEXVaYB2oNgPf9MEFXpTPlrvS8HFLt/g1qq1AygUEiRqMf6q9d+EjB7vr9Npu8zFHFVaR4QK/BqjIsx057SRo0RFXC6nvZ9E+NboXFE0yR1kp+xRl3a2qtW8u0Z4N6Ff8u2DxvFcxR3BTfVTq4/Tsid8jk5Gm0yC+ld1NeQxNnitX3iEHNssrGDIDPiY1ro1tg1htFGR0L4WZwNPTGHvJOy6wcJJoVXfcQR7euZseGv49gi2Dr84pCTIOiS7TlnWgS7Bbt8rmuz4T1s+Ofh9Jff7ov7K4JPRmQW3hCv8WGmGJwAzHyBuSrFlCcP0FkZ0U4n9R/flBtfSEy4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA1PR11MB6396.namprd11.prod.outlook.com (2603:10b6:208:3ab::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.19; Tue, 3 Jun
 2025 10:59:19 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 10:59:19 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V4 07/43] vfio: vfio_find_ram_discard_listener
Thread-Topic: [PATCH V4 07/43] vfio: vfio_find_ram_discard_listener
Thread-Index: AQHb0M9cyTjoZWcXaUWSFh/QVlfVebPxS0aA
Date: Tue, 3 Jun 2025 10:59:19 +0000
Message-ID: <IA3PR11MB9136F3E845D2BDCEFA8932D3926DA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-8-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1748546679-154091-8-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA1PR11MB6396:EE_
x-ms-office365-filtering-correlation-id: 4ecd38a7-33a9-4e85-a92c-08dda28db0ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?U1NlWU9FdmlERGpQa2xrM1p1RFFtQ3ZmN0VURjF0SVE5UGNXaC8zOUtiSFpx?=
 =?utf-8?B?RENSdXg5ODd3am00Vzg5RGc0dG51dksyT01UbkthMTVIdzFlLzAzcHpZUjdj?=
 =?utf-8?B?dVhzWmlodDlYUlYxN1lFMUZYRndwaytPMjU0UHdyUk9uZ25kaFY4eEtiNlBi?=
 =?utf-8?B?VkxOVVFQdDZ6aDN6Q3JYWXpXVWp4a0xDaXNMdFVWT0I5czV3RHkxdGk0cy81?=
 =?utf-8?B?Q2FxSjJRZHJQV2NqT2dSSTRZU1cyQ2hmSkQrUXFNM0o5V3JwcW5ZTFdtUDFo?=
 =?utf-8?B?UCtQQkF1MXJtQ1pQQWF0L2dqaFA5Q1FFcVRKTXdvNnBoTFJJSERQRW9MNEtl?=
 =?utf-8?B?aTVtRlZHTy9kMDUxYTlFRHNiQVpMQ21FUU1Wa3QvWHlRQWRua0FsOXFGcjVv?=
 =?utf-8?B?dnRRbVp0Z00yUFA2K29OUDZ3SnIrY3hDQy8vM1lrRlV6dlJtenhDajl2U0tB?=
 =?utf-8?B?d2laNnlVY3JENklVK3dCQTNIYmVFYVBLUVZrZ1o4Z0d3U2YwQkFsYVB1cTZY?=
 =?utf-8?B?d2h2V3BMeHVibXllR1VMUmN1RGYvS09JeXl3ekZ6V1gzOWJGRWt2a1ZOekIy?=
 =?utf-8?B?L0RUdFRLeHhyUXBzSmpLdWNueHJpRzVTdUl3WjlObllOOFpPY3MyQTM2anlq?=
 =?utf-8?B?d0xadnJtck1QR1h4SHlkM3cweGQ0ZDVCNjV1NnFRb3VyTjh3b1NjWFFhZTAx?=
 =?utf-8?B?VjFITzlBa1lCR0ZTNlJnb1JkcytxSE1TaDErRTI5TEpGUWkreTVDK2ROV0pZ?=
 =?utf-8?B?eU9NelFxMi9lQklEbmRtVjdYY2ZNSGVaeDZoK2wzeE1vMXNIcG1KWjgzUmpM?=
 =?utf-8?B?QUZ6Sm9JemFEZmZMdXl1WS9HRS9yR0NqK1RMTHhhWjJsc0EwanY1SC9SdXNs?=
 =?utf-8?B?L2tZQUNJbERNcE5FSnVoTjRQbnJwVS9KZFhWZlQ0Q1ZseUp5aWZ2UlF5VEV1?=
 =?utf-8?B?L2lxUnp1VjRva0JMM2k2VExiRm0vcWhpMTBINElLZkRIR0NYWG9veHhDVTJX?=
 =?utf-8?B?QkZuR1VYUVIyYmVKLzBLcHNnZXZ6OUhpdGsvdHQyS3pHbk9yQklseituYUtn?=
 =?utf-8?B?dmlJTHE1ZjU5bjA1Z0RLOURaWklqSHpKTnE4L2FXTDM1OFBJWWZGakppVFhv?=
 =?utf-8?B?ZUNkbHZJbTV0S0krci9rMXU2a01xYWd3VTJBcDZOWklpemhVOXJ3eGlabkFt?=
 =?utf-8?B?SCtTZklCZDBwMzRnRjFWSXQ1aXN4ODN3RVpxNUV5MEpCdld3d3FVSGJjVXNK?=
 =?utf-8?B?QjJMTmtDOERVVml3cmhMOGhIRDNkSWpCWkhBak9PdlJjZ1lraDRaY2w0elFt?=
 =?utf-8?B?OHl3UlplUFMvVDdqSWxKTVBwSHFYWVA0UzRCcmhrRnlhL3BpMkdHc2MzaXZ3?=
 =?utf-8?B?TnQrNGV2V043SmlSTGxVdWdBOUpsT0hmUGEzbnNXVDc2M1N3Q2tNd2JjbW55?=
 =?utf-8?B?TDRVWmdZSmZXbkZ6eTVNZElENjR1b0JFOUFjUVlZY1JNWHAxOVFweDZ6R09D?=
 =?utf-8?B?OHVGN3FXa1VwanFaUGZCdVl0RkZhRFlyUHlZN2RYSzkvSDQ1OG1rbTRMWHdr?=
 =?utf-8?B?WC92Z1lzSytFcmdSTk15bnRHREJWR3hFZE5xbUtESWEzR1plZXovZWZ1d3g0?=
 =?utf-8?B?WElEV2VJdlB1SUQ4WURhdWRUQU8rRkczOUIxUUxzcEUyMXNBMUZzaVhPd005?=
 =?utf-8?B?S1NKWTFBd1lJOGlsa2RqbG85c3pNYVo0dWtQTzhuRXRSZnJ4dnVtcGpWK3px?=
 =?utf-8?B?OWVwc25ybmNOVkNwQldWNllHWmlVOU93aU9OVmFsd0FTMzJ1SkxLcnR1a2Va?=
 =?utf-8?B?cTRoTjViMmVSS3M5NkNsKzlrZURlaUtIcmtsS0NVNkxQdHZVS3p1NDdadHli?=
 =?utf-8?B?YmJ3T1pvZnJIZDY5S1BVMTdhcjJ1cmMvQ2wvZWMwZDlXa2dMZ1Zzd1lmSThI?=
 =?utf-8?B?dTQrcXlXeHkxNFN6TC9oNDFnYWRIMG9PcmhVWVlCSVQrZEJ6UkE2RXNOSUZS?=
 =?utf-8?Q?AR5ieSL/K2PVGSkqViAta+9hA9Ji0U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFNHOEJ2ckI3T1JGUittL3J3clI4TGVoU0hncGh4NzRZbGUydG1BbWRwaFhE?=
 =?utf-8?B?WDBSNE8zamE2a3B5WVlSNitodlA4a1RQR3Q1MUc2VGlJZERRUXBRTTRXSkwx?=
 =?utf-8?B?RWptL0tlSmw3RytqODcyOEhPVFI4MDk1MGhVNmV0R2h5WGlRUGYyQ2NRVXds?=
 =?utf-8?B?cGgyM1JvdlVlTEFHUTFUeGNTN2JTdjU0Szl1TXhBbkZZZEtqUmlLMERHTmY5?=
 =?utf-8?B?Y3FRMTJQdSt1c3ZoQkMwNmFyZnBackExVHhmVTVjQzdNbHRycDVzdy9ZSk53?=
 =?utf-8?B?bFRsdXV2c1ZGQ0VtSkhzQlZqZVlYeTk1R2txWFZ1RU1VVmNFSUpEcDJtb2py?=
 =?utf-8?B?RkFpN3dZbGxFaDIwT3lqcDZTajg5aFNMVHRIU0VvN29iWVpOVzFOVFNqemZh?=
 =?utf-8?B?dkVCa0RpZkFGaUtNc2dIeHFQK1pGdTl4UHMxaHk1Z2M4K24zRW80SG1yZkxU?=
 =?utf-8?B?S2lXL1RvWkF5K2hVYWNqb29oeFAzSU5CU2xROEdObEFoZ3JaVWxhNmcvWGNq?=
 =?utf-8?B?aFRwcElYdENtTkhzUHlsYlRZbG81NmNIcE9RQlN3dzhOblNHcXB2UFYzVm5Z?=
 =?utf-8?B?a3loZjRQdDFXajVyWmI2NW1SdEFkTlZKV2hJR2Y2RGlsQWMwTXdxK2U5enRr?=
 =?utf-8?B?ZXJKWWxWT3hVMGs3S0lKTGgzNVBlU2xvVW9MN25UY3lCWFVIVjkzREg4VWVj?=
 =?utf-8?B?ZWNRYUhCNGY2d2dadHRsQ2l2cVFrUERYSllRZU11K2RYRFlTZ1FybVF0Q2VC?=
 =?utf-8?B?cFUxamVBWUFtZE5aTkhMUnViYlFNWStTd2pMcnpRVldTZ2dIeENrN3REN2NN?=
 =?utf-8?B?cVp6dElKRTZuU2k5dFhYdys1TEhTUTFoN04rWmtWSDNlS014ODgyR0tWcHd3?=
 =?utf-8?B?UTQ0UllRZ3o2VUQxajRHNG03OWgyVkF6bFIyeW1wNXZLQjBVbmh6RTVFSkwy?=
 =?utf-8?B?eS9pWmYrS0ljSDR6OHl2TjhBV0xiUFFQUExVTVFzUklkQUZOZmhwRmZ6YU1k?=
 =?utf-8?B?T0FaUE5TdkJWTFNGSklDMXhQZ2tidHlIbU1tSzY5c0t5d094Z0k2V2N0dUJw?=
 =?utf-8?B?OE1ZdmJGZzZpMW8yVnVwbzMzT0dMRlF1WkM0a1VBdnBObFlVSC9hY2RRVTlq?=
 =?utf-8?B?cnRVTCtZUVdzdWYrTE1TaXl3RWxPNUNtM1JuY3VnRXI0eEZwL2h3Vm9qZkhl?=
 =?utf-8?B?NUMrNG92VDJ4YUlnd3dRZGREVlRrN2s4SjREbzl3aWdkbjdMVnEzN0ZVNml3?=
 =?utf-8?B?VGhrclhHcmdnbFdGZUpkY0tiZkF5aGZFSkg5bXFPR0lJeWVabUdrckxvNmpG?=
 =?utf-8?B?WWdCZFdJT0xLQlZVZnRYQkkzdEM3V3V1UUwzUTBEZDRoLzRKcmV4VldxRy9j?=
 =?utf-8?B?bVlNRVB0eldyK2w0ZnpLeXYzSHYzRDBGOGlRVjJwdlVmME1HTHhRUHBBL3pX?=
 =?utf-8?B?TUhkeFk4aXliZGFCSHlBd2lJQjVtcHN0OWQ2L2FkcEIxRE9ZaVdqQTkzcmpn?=
 =?utf-8?B?UlphQzRheHpRbi9rNXdOUzcrVENhbWp1WkxGM3FZYTNGcVFnZTR4b1U0c3FZ?=
 =?utf-8?B?Tk45c1cvM2JlQm0zU0VXSzZYdlBlN1c2d011aXdJUzhNblAwb1plWDJDdWpW?=
 =?utf-8?B?Y1BabzNEZTVIVmZOUUJ6WllZSEdYMk1zY0RrYTc1ZkZnd09rblp2S2Q4SlJO?=
 =?utf-8?B?Sk1Kam1rb2NDMzEzYmhRbmcyRWxVcHo3RGtBRERJSFFTTWd0Nkkvb0FpaUNW?=
 =?utf-8?B?cTlsZ1NhWDVFM2ZTRVoycmlYV0dRNzdKa084VnA3RDVZd29XbHVYWDUydG5w?=
 =?utf-8?B?VnlyZXFyWGxmZ0VKNEtIWXpOZ0kwYVd3N1JGVmY5TUJZeVZFaFB6VTFpOHQv?=
 =?utf-8?B?Qm1aMENLdHZvS2E1ajR3UVlvcXVYQ1ByT2x5S0lpaWx5Y1l5NEI5SUxwbnBn?=
 =?utf-8?B?YTNRQk1PRkQ2WlRhY3RhY2JBc2cwM3Qzd1BsQ2N3TnI0YWU5REF1R0pYRjJx?=
 =?utf-8?B?b0ZQc3BZVUlDb1c1cDRQdDQwUzZMa0s3dkpMMkdldWNXelZ1YlhRYSt5bk9w?=
 =?utf-8?B?eVhITTkwbVl0dEppZGJ3blY5TGJqOFdSVXVNeW1WZHhvRnVVcGdoRlV0RDdD?=
 =?utf-8?Q?A+TESFJPFVkji4dVqOr2GBQUF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ecd38a7-33a9-4e85-a92c-08dda28db0ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 10:59:19.4649 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K2f4xvoqe9wn9cVR5fm06Ve4AGgyxm09pwnLiJTPrEBD/RcM8Du5sEeUTCnxPwUXZH+oYmEKWmaxEu7DE7MgYk1yrPpCm1cYPq+GiGWKsEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6396
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFN0ZXZlIFNpc3RhcmUgPHN0
ZXZlbi5zaXN0YXJlQG9yYWNsZS5jb20+DQo+U3ViamVjdDogW1BBVENIIFY0IDA3LzQzXSB2Zmlv
OiB2ZmlvX2ZpbmRfcmFtX2Rpc2NhcmRfbGlzdGVuZXINCj4NCj5EZWZpbmUgdmZpb19maW5kX3Jh
bV9kaXNjYXJkX2xpc3RlbmVyIGFzIGEgc3Vicm91dGluZSBzbyBhZGRpdGlvbmFsIGNhbGxzIHRv
DQo+aXQgbWF5IGJlIGFkZGVkIGluIGEgc3Vic2VxdWVudCBwYXRjaC4NCj4NCj5TaWduZWQtb2Zm
LWJ5OiBTdGV2ZSBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPg0KPlJldmlld2Vk
LWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBa
aGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KDQo+LS0tDQo+IGluY2x1
ZGUvaHcvdmZpby92ZmlvLWNvbnRhaW5lci1iYXNlLmggfCAgMyArKysNCj4gaHcvdmZpby9saXN0
ZW5lci5jICAgICAgICAgICAgICAgICAgICB8IDM1ICsrKysrKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0tDQo+IDIgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRp
b25zKC0pDQo+DQo+ZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbnRhaW5lci1i
YXNlLmggYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby0NCj5jb250YWluZXItYmFzZS5oDQo+aW5kZXgg
ODNiYTdhNS4uMDFjZGNiNiAxMDA2NDQNCj4tLS0gYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb250
YWluZXItYmFzZS5oDQo+KysrIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2Uu
aA0KPkBAIC0xOTYsNCArMTk2LDcgQEAgc3RydWN0IFZGSU9JT01NVUNsYXNzIHsNCj4gICAgIHZv
aWQgKCpyZWxlYXNlKShWRklPQ29udGFpbmVyQmFzZSAqYmNvbnRhaW5lcik7DQo+IH07DQo+DQo+
K1ZGSU9SYW1EaXNjYXJkTGlzdGVuZXIgKnZmaW9fZmluZF9yYW1fZGlzY2FyZF9saXN0ZW5lcigN
Cj4rICAgIFZGSU9Db250YWluZXJCYXNlICpiY29udGFpbmVyLCBNZW1vcnlSZWdpb25TZWN0aW9u
ICpzZWN0aW9uKTsNCj4rDQo+ICNlbmRpZiAvKiBIV19WRklPX1ZGSU9fQ09OVEFJTkVSX0JBU0Vf
SCAqLw0KPmRpZmYgLS1naXQgYS9ody92ZmlvL2xpc3RlbmVyLmMgYi9ody92ZmlvL2xpc3RlbmVy
LmMNCj5pbmRleCBhMWQyZDI1Li5mYjFmZDg0IDEwMDY0NA0KPi0tLSBhL2h3L3ZmaW8vbGlzdGVu
ZXIuYw0KPisrKyBiL2h3L3ZmaW8vbGlzdGVuZXIuYw0KPkBAIC00NTYsNiArNDU2LDI2IEBAIHN0
YXRpYyB2b2lkIHZmaW9fZGV2aWNlX2Vycm9yX2FwcGVuZChWRklPRGV2aWNlDQo+KnZiYXNlZGV2
LCBFcnJvciAqKmVycnApDQo+ICAgICB9DQo+IH0NCj4NCj4rVkZJT1JhbURpc2NhcmRMaXN0ZW5l
ciAqdmZpb19maW5kX3JhbV9kaXNjYXJkX2xpc3RlbmVyKA0KPisgICAgVkZJT0NvbnRhaW5lckJh
c2UgKmJjb250YWluZXIsIE1lbW9yeVJlZ2lvblNlY3Rpb24gKnNlY3Rpb24pDQo+K3sNCj4rICAg
IFZGSU9SYW1EaXNjYXJkTGlzdGVuZXIgKnZyZGwgPSBOVUxMOw0KPisNCj4rICAgIFFMSVNUX0ZP
UkVBQ0godnJkbCwgJmJjb250YWluZXItPnZyZGxfbGlzdCwgbmV4dCkgew0KPisgICAgICAgIGlm
ICh2cmRsLT5tciA9PSBzZWN0aW9uLT5tciAmJg0KPisgICAgICAgICAgICB2cmRsLT5vZmZzZXRf
d2l0aGluX2FkZHJlc3Nfc3BhY2UgPT0NCj4rICAgICAgICAgICAgc2VjdGlvbi0+b2Zmc2V0X3dp
dGhpbl9hZGRyZXNzX3NwYWNlKSB7DQo+KyAgICAgICAgICAgIGJyZWFrOw0KPisgICAgICAgIH0N
Cj4rICAgIH0NCj4rDQo+KyAgICBpZiAoIXZyZGwpIHsNCj4rICAgICAgICBod19lcnJvcigidmZp
bzogVHJ5aW5nIHRvIHN5bmMgbWlzc2luZyBSQU0gZGlzY2FyZCBsaXN0ZW5lciIpOw0KPisgICAg
ICAgIC8qIGRvZXMgbm90IHJldHVybiAqLw0KPisgICAgfQ0KPisgICAgcmV0dXJuIHZyZGw7DQo+
K30NCj4rDQo+IHN0YXRpYyB2b2lkIHZmaW9fbGlzdGVuZXJfcmVnaW9uX2FkZChNZW1vcnlMaXN0
ZW5lciAqbGlzdGVuZXIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBN
ZW1vcnlSZWdpb25TZWN0aW9uICpzZWN0aW9uKQ0KPiB7DQo+QEAgLTEwODYsMTkgKzExMDYsOCBA
QA0KPnZmaW9fc3luY19yYW1fZGlzY2FyZF9saXN0ZW5lcl9kaXJ0eV9iaXRtYXAoVkZJT0NvbnRh
aW5lckJhc2UgKmJjb250YWluZXIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgTWVtb3J5UmVnaW9uU2VjdGlvbiAqc2VjdGlvbikNCj4gew0KPiAgICAgUmFt
RGlzY2FyZE1hbmFnZXIgKnJkbSA9DQo+bWVtb3J5X3JlZ2lvbl9nZXRfcmFtX2Rpc2NhcmRfbWFu
YWdlcihzZWN0aW9uLT5tcik7DQo+LSAgICBWRklPUmFtRGlzY2FyZExpc3RlbmVyICp2cmRsID0g
TlVMTDsNCj4tDQo+LSAgICBRTElTVF9GT1JFQUNIKHZyZGwsICZiY29udGFpbmVyLT52cmRsX2xp
c3QsIG5leHQpIHsNCj4tICAgICAgICBpZiAodnJkbC0+bXIgPT0gc2VjdGlvbi0+bXIgJiYNCj4t
ICAgICAgICAgICAgdnJkbC0+b2Zmc2V0X3dpdGhpbl9hZGRyZXNzX3NwYWNlID09DQo+LSAgICAg
ICAgICAgIHNlY3Rpb24tPm9mZnNldF93aXRoaW5fYWRkcmVzc19zcGFjZSkgew0KPi0gICAgICAg
ICAgICBicmVhazsNCj4tICAgICAgICB9DQo+LSAgICB9DQo+LQ0KPi0gICAgaWYgKCF2cmRsKSB7
DQo+LSAgICAgICAgaHdfZXJyb3IoInZmaW86IFRyeWluZyB0byBzeW5jIG1pc3NpbmcgUkFNIGRp
c2NhcmQgbGlzdGVuZXIiKTsNCj4tICAgIH0NCj4rICAgIFZGSU9SYW1EaXNjYXJkTGlzdGVuZXIg
KnZyZGwgPQ0KPisgICAgICAgIHZmaW9fZmluZF9yYW1fZGlzY2FyZF9saXN0ZW5lcihiY29udGFp
bmVyLCBzZWN0aW9uKTsNCj4NCj4gICAgIC8qDQo+ICAgICAgKiBXZSBvbmx5IHdhbnQvY2FuIHN5
bmNocm9uaXplIHRoZSBiaXRtYXAgZm9yIGFjdHVhbGx5IG1hcHBlZCBwYXJ0cyAtDQo+LS0NCj4x
LjguMy4xDQoNCg==

