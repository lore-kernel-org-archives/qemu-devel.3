Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE46C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 03:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucFd2-0002Rf-K7; Wed, 16 Jul 2025 23:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ucFb3-0007uA-L4
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 23:47:49 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ucFaz-0001Op-Ji
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 23:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752724066; x=1784260066;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3U6euEuRuY0RlPBQYdnXzoGsuY47ErgU7veKpfdEllY=;
 b=iANUEodI1Szx30euazcCO5BqQvZ5smZw2F2Ynsj8n8YKYJKhDvq5l85O
 kIjBxJcNWgSNqNroMRgDlzOA/NKMBhrB7l73vWe7P8kVqRGaY2D+hT/Re
 Xfq8L9SlpmiUAlv8Er7iYfCxmRRZdZtHvcbCL3LLVc9MY1eJ/CMw8bFvX
 g+tsewfSRL9DLN3yWJgUvbcU3Pz7nTxEmppSc5JwJ4UpxmefvA0uEa2NO
 +PjHfCxFhyrwaQa8O+9e8NPr1BKh+MPlY7LBG9EZ4Ug5nh74J4HBWG+NB
 MetQz8rHHlliyUDDf92IlUjWuIAf/OmCJQ4pweGxglJTEB9ANFJd6vVdT w==;
X-CSE-ConnectionGUID: GqVQG3k1RuSn5tkfd8r0Bg==
X-CSE-MsgGUID: huQ9aIqnSVyrY1MX0cXW0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="77524771"
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; d="scan'208";a="77524771"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 20:47:42 -0700
X-CSE-ConnectionGUID: pBw0CpCsQqODyxkatL9ULA==
X-CSE-MsgGUID: 6WV4GGAzT9i/gFji9Pi7Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; d="scan'208";a="157752882"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 20:47:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 20:47:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 20:47:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.45)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 20:47:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2d9STCMp+dBSuetMGVzTuEA4sE6n8iCdKD5bTPFCosDZiC0XzPsKSdB9xPXpe7qtXzphXrItFwFSnLHOKe/74yIQUPCJsnkBKkJm2uixa/VKs9yy9bHtrHYOFND3adq6p2Cch3lUBjP+z82nFUcNO9yt/7ABvNyFsVv4OF1V8yWEcoEDuiGQYLYhHukB3HNnE4iHe6IPPMawv3FQxTSamprFKiUHvuwDoMojN4cIl54TDL6OmWjLW2vDXPu3zIfGMvSvY8s0kdU2OCg7l1wY/oBfMht3T7idEptin4uoGUKNr64lYHHZM5EqnBq95ERCcqKXFLLgtxG1/8/+1ei5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3U6euEuRuY0RlPBQYdnXzoGsuY47ErgU7veKpfdEllY=;
 b=pQxKBOzgQ5OvxFocBtzqczy2JRsWxQRsTc9mibfeMv6fdlCdneCE69bNgbEB3GvjOx3GQxcDltlRS1UWuIJ26F+8NqI0qDXeNtPgcA/NeRsItXEHy7wwp3dhjV/9Tye5tXOw+e2ZTokQKUI0QwMe4YitMdSkLba84TEocKpegbXn0KQh1ySgJUUCDbJS2dnMl86ZEgb51UfdLCFxkVFY72yYApr5vS8HPfYGQo5QERoSOfvEn6cBFOf5EmlobDyQb4PYEzHSSxFViFtimYqKNkrpPwdIPn2bb5skDRd0hq/w6Sj46N3/PYkD5TfM3EbD2r3JWCIukyWn7Eb9uW0Kog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH7PR11MB8598.namprd11.prod.outlook.com (2603:10b6:510:2fd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Thu, 17 Jul
 2025 03:47:32 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Thu, 17 Jul 2025
 03:47:32 +0000
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
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 07/20] intel_iommu: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Thread-Topic: [PATCH v3 07/20] intel_iommu: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Thread-Index: AQHb7/hoBQVqCDKijEq37aEKMjw/RLQ0hlWAgAAOMLCAACBhgIABABUw
Date: Thu, 17 Jul 2025 03:47:32 +0000
Message-ID: <IA3PR11MB9136ABA0E88C04CB6E9E80BA9251A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-8-zhenzhong.duan@intel.com>
 <342129d6-0b96-440c-83ac-e9b8bc5b18a0@redhat.com>
 <IA3PR11MB9136C85F0799CB91572121FB9256A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <081c3534-332f-454a-985b-4dc81a3dd2a7@redhat.com>
In-Reply-To: <081c3534-332f-454a-985b-4dc81a3dd2a7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH7PR11MB8598:EE_
x-ms-office365-filtering-correlation-id: 0effdf56-c1ec-413b-0da1-08ddc4e4a901
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?M295VzlzcjFzWVlYTDkrVkNEVDdRamhDZnA5Sk9RbmdsTUlPeTlOVTdNWEVa?=
 =?utf-8?B?Tktra0RIbklvTDhXZ3cwSGwrakIzM3JTeDI0R2lwaXdQRXVCMklQdkVlaGdt?=
 =?utf-8?B?N3JlRkIwUUdXT2l2cWNQNTlwRlpkL2NwYVFZZXJHQi84SEdTeU13TWg5Q2d2?=
 =?utf-8?B?T3VpMkM2UU45M3RsbXZNaWxUZ2hzQTNIZGRtRnZ5NU9Hai9WODY0Y2pLQTJJ?=
 =?utf-8?B?REZ2THA5WC9uZ3BLVFBsNFc0QTRwc1FyQ3c4eUcvdFBFY3VZSGdiRkE4S1lT?=
 =?utf-8?B?citsQTZ2OUJyT2ZUQVBjbTB5dG1XN2JHWVNwcHUwVmpLLzI3TnlhcDZURWdx?=
 =?utf-8?B?NHVoRnhXWEI2OWxVcFcyTVNJSE9vRThSaVlVUzlkRW8wbk9iWldCUEppY1hX?=
 =?utf-8?B?M01GaGtObXV1KzRVVEpTM3FvNHZwQXZsSHNzMUN1Mzl6WmtjdUJSbGlqNk5H?=
 =?utf-8?B?eFBXbk5sUFhSU3JGZ0tmcElWMWdseVgwRk13V2tBTkpjd2hXL1FnejZidnFq?=
 =?utf-8?B?K05kRk1mRk1paHpzZ1p4aEhoZGE5eHBNU25mY2RVRG1PNlh1YTFRb054OUh0?=
 =?utf-8?B?dU50Si9ISnJxMW14UThsKzUxaW9nQ3pjams1YjJYcHZRQmpZUXVGOVQ1dElL?=
 =?utf-8?B?Q0pRcnY1dHVpUHZ6aHNPQ2tDcHRHYUp0Q0tTTnIvTGJEWkxPNUpZWllzNkc2?=
 =?utf-8?B?ak0wMytoNm45ODZ5bDV2SkhwOGF1cUhFcjgzdmZsTmJKdjcyQVBxSzJqTnlX?=
 =?utf-8?B?aEJBZ1MyUWNVc2NtR3hhVXJqb1dkcStKSGRsTWU3aFV2L01PTXJPZ1hlODF4?=
 =?utf-8?B?SVdpYmZNUlQ1ZUt6RVUzZEF1YWQ1TkQ1UmFMblN4Vkw3RGFwY0NBaXlJWlRn?=
 =?utf-8?B?ZWFkaVhIejVtcHZadFN4U2hhNEc5T0REenVSYkppaFRKT21HM3ExYVVjZTdo?=
 =?utf-8?B?QnBRREhNRUY4ZGhWTU9DRS81L2creHg4ZGhEMEVDdjlXNWExUEp2T081ak5J?=
 =?utf-8?B?a1Z4bE02OEZ3dDUzR1FKR0hTVEZrcWptWTRVQnQyQXFZNm0xRHUwY0hJdXdr?=
 =?utf-8?B?djJ4d0xOb0xid0w3WjFvdHF2QWdMOEhyaElFZS9aeldzRWFNREgyUWRhaUpZ?=
 =?utf-8?B?RHhlNDYzcDQ0WlgwbzBrQjBVTCt2cFlGOTAvK3E2TEdCZzgwb1lxSjZ1dzRl?=
 =?utf-8?B?U0dkSlh6cVF3YTJocXMvcVQrNWF6RURUZzltRHprM3BkSUxOZzFCTWhwNzc3?=
 =?utf-8?B?TGxkQUdIdi9kQ1ZZN1B3UzJVT1NOUVlUODFBMmZkbWNGeUQxZXBBMDZKL2ZH?=
 =?utf-8?B?MUIzODZyb3NIWWNUazhOcjJ4QllhbG0xTGU4dmVkUXZrbno0U0c0RE0zSUdv?=
 =?utf-8?B?eW1sT1k1R0lBR1NoRC91K1lyc0lMZmUvN3RCMVM1aWdZQ0FnN1BoVFVTMTB2?=
 =?utf-8?B?WjJKQkJBNmVhbXQ2alI3SndiaGJYUVgxekdzMUxQclQ2ZUZKWVdUMnNSS3o1?=
 =?utf-8?B?V2VjU0VXWjRXZk5hYk5KYkVPN1hIQ3o2aDI2SElLcGFWNXN5bG8yZUZUVnJB?=
 =?utf-8?B?TmhKY0hGakVnOFk5b1QrVklYRFdVdkhHbjZOYXJFTW5Qd3drK0QycFJhK0Rr?=
 =?utf-8?B?T2dVZnVvZExUZi90am40aGlpSXZ3NzNMb1BCOWpUeDFaSmFVSmdjcWVsOTJZ?=
 =?utf-8?B?NVlnd2FkNHpKNG9xMGtRUjFkZzluang2MTFhMkVnZUhBSERHVU1Mcks1ZEw0?=
 =?utf-8?B?T3Z4QTJFUnhIUm5BM1UvVGMraXRwbnVwemFVeUM2MUxSL1NKVnVNTjNaZnRF?=
 =?utf-8?B?UzcxQ0t3bFQvanl3cjVyMVJYUkNQSHJHeUlxdFVrc212R3NlYU84SnpZcmFH?=
 =?utf-8?B?L0JYNFkwOS9mWGMzK2NSWmFNLzdkSGQrVnlqckdjTnZEejFxcUJBSmZSZDJ1?=
 =?utf-8?B?Qnhua21hQVF4QzdUajFLdTdmV1ZXS3BJMFhVUDVBUmhzSkhMcEdacGFVMUFJ?=
 =?utf-8?Q?3fiaegNNte7kQ8ZsFC3DfMGzgM02VM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXpGVGFSMVFZeXJvcnd0OVRrUGI4eDFWd1RHZHd2Z2Jma1V5SGFIN1JEU0dk?=
 =?utf-8?B?VXFxN0d0cW1NME10N2g2emc2OGcvMVhiRk5uVTJwSmJRYmdVdlNwYkhVNWw5?=
 =?utf-8?B?M3ZCUkFIU2pyNk8rWW5zM3NIZmgzNGsrNTlMQ0xVMjZGVmwvM3NaeDhwNTRD?=
 =?utf-8?B?djhFc3h1RUhSRWJmNDRXNXJ6TGtTYVY0OHZKT1JyUXNMYU9JaHZWVDBVQXZT?=
 =?utf-8?B?dkZkVVMxMCt6eDUvKzJhb2svR3YwNUxtM05LNkdKSmQrK2xVekY4MHJTTENj?=
 =?utf-8?B?dUpObkFmSDJROHlFTWxpU09OWTg1NnljbWxQSXUyRHdTdG9hNmxSVFFYVU5Z?=
 =?utf-8?B?Z1kzdGxtVS9NWHRnUkdyaEJhNFJWb3RVY1lFK0VPWFhDSVY4MXpkM25WUjlw?=
 =?utf-8?B?M3I4UUZtempDcUdYOXZXZ1JHUVJCcWNvUmRBcWVVRStVbVo4Y1pGbTNtdU54?=
 =?utf-8?B?N0s1dzQ4SWRtUWswMkhjY250cFZML3VJUWdlV2RhQUszY1p4U0V0QlhqNkFx?=
 =?utf-8?B?UW84ZGxxd1FnMDlZeHhldU81aWh0enltMGs1YUw2S3BoVUtaZU1lSTVzQ2ln?=
 =?utf-8?B?N1VCT2JVaSt4N0gxQTVmTUFRZ3dLNjJDdjY0MHpQdTBJWVl6VzdITXZicHNZ?=
 =?utf-8?B?clRqeGFhR0ZFWHFzL3RaWDROSjdSeFJBWmRDL0ZwejM1NEpFT0p4NFFLMHVp?=
 =?utf-8?B?SVpmUjBPVnk1cVpCRFFrVGljUlVuZUVMZE41dFoyV2ZxNE1KVVk3dFBIUTlJ?=
 =?utf-8?B?Vm12dlh4NVcxbXpQeWM3VktiV0ltU1JrRU9uQjM2SHp4dXBrMjhpbFd3MkFw?=
 =?utf-8?B?Q1lENXg0TnBQV216cUdHRSszblpGcWF5bnhYMkJTSTN1cWFOUW9sUGZHY3BF?=
 =?utf-8?B?N3daMlVYZWJDbzdPUlR5bDRCWGNSaFNlZ3NXTE9FVzhyeUYyeWFzSmZzZEJW?=
 =?utf-8?B?cXV2ZmU4L2tqRlV4ZjlsY0xwd2tEbnc1UUZLaFJSdy9XZWVidWdQSnZXQmtD?=
 =?utf-8?B?ZU56dGorMDNlMW9PL2ZUaWhlSzNvVkZDanh0eXpUb1B6UU92bDJiUXJjQUdz?=
 =?utf-8?B?WG9lUTE3NzJDQzAwNGIwTk1PVG9LWWpCdW5jZnRzQXBlYWJGSHRzaVZEQVl4?=
 =?utf-8?B?ekxHcWMxU0dObUVHMnhsajhDMDZWelFMNW56M2ZUV0xTd3R3VnFOb0VQNjZp?=
 =?utf-8?B?aC9pNnJzYjBoMER4RHJSYjE0Z1k3N1pqTHJ2bTRKYzFjYURDUXE1bXBTWWRC?=
 =?utf-8?B?Mk1Ec0Y3dnFJVXVnRlNCcEVHcVUwdWl4dnNjdXprME9oMDVQVXM3eW11OGdI?=
 =?utf-8?B?ZEV3cDBsOFlrK3hEc1JrL01UQ2RkQkQ1bExqR0JOTzRnZWRwR3BkUE5aQXhr?=
 =?utf-8?B?MXRYMUFVN0hYOFFBRk1pUEVDL055M0ZNTmY0bklQV1d6U3J4M0hwM0Y3aDdh?=
 =?utf-8?B?Z2IyVm5wYzRiY3BRT1lKUTljdTFEd2hjNGtIMUVKT3U0bVJaRkkrSE9rYTFQ?=
 =?utf-8?B?Sm90NG5TQmk2cEVmU0k3RzJka1BYTlpyNkhSR1MzcWx0Q2VSQVBCUU91ZmtV?=
 =?utf-8?B?Rmo1ZnBjUklqZTB5NE0vd1FIMHZFZUV3ZGpiclNYWjJXRkZCTllNdUtBVFAv?=
 =?utf-8?B?TGVSbTAxYS9KdzJheDFJZnVYdmhjWGcrckVRM3FPQS83QjZzV3Qrd1F4K1JM?=
 =?utf-8?B?YjhrNzNRQmZwTHVyUnFYU0dPS1Q2b1V2ZlQ2M2tBemRCZGVpMnRZVmNqWndo?=
 =?utf-8?B?Ti9xeGVWTjBQOEp5dGhDRFFuU296S1I3cmVlelpPRE82MUJ1Y2M3QThIQzBQ?=
 =?utf-8?B?bXEwaUU5VmpPSTFZSytZMXdkVU9VbmlpbDVqQlZUUWo1cjl5OVpDSFhUWDFh?=
 =?utf-8?B?ZU9zTjZlT3FOdi9pNXk3bU1nV3FOZGY4UTE4RGpsNzNBVlJwZjY4dVdEVklW?=
 =?utf-8?B?L3lLcEIreWpMbmQzSkd4eTZFbGJRTlEyZ1Yxd0Q3d3RqRFowRzAvQjk2SXh3?=
 =?utf-8?B?M29hbnZMMDRDbVViejlJRFk4dm1TZjhndklJVTREQW5WMTF6ZzNST05UcDdX?=
 =?utf-8?B?ZWpBdVNNSjBFdXhoalllQ0lCeHdMMTQxaHVpaVp5YndubDlEeDJlYTVGVEty?=
 =?utf-8?Q?FizMik7KjT6Ub/vKhErbrO/Z0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0effdf56-c1ec-413b-0da1-08ddc4e4a901
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 03:47:32.3403 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bFBMlyxmr0JTTimyUuWyvGSOsRnXZGrM6Qs1nn1r/I7LOlXkQ6u9LC/Wqelhv345izvK3Bzdroro5j0jihSONinX+3dYGX5Yrei1Zm7c4Gw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8598
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
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
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlNlbnQ6IFdlZG5lc2RheSwgSnVseSAxNiwgMjAy
NSA4OjA5IFBNDQo+VG86IER1YW4sIFpoZW56aG9uZyA8emhlbnpob25nLmR1YW5AaW50ZWwuY29t
PjsNCj5xZW11LWRldmVsQG5vbmdudS5vcmcNCj5DYzogYWxleC53aWxsaWFtc29uQHJlZGhhdC5j
b207IGNsZ0ByZWRoYXQuY29tOyBtc3RAcmVkaGF0LmNvbTsNCj5qYXNvd2FuZ0ByZWRoYXQuY29t
OyBwZXRlcnhAcmVkaGF0LmNvbTsgZGR1dGlsZUByZWRoYXQuY29tOw0KPmpnZ0BudmlkaWEuY29t
OyBuaWNvbGluY0BudmlkaWEuY29tOw0KPnNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2Vp
LmNvbTsgam9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbTsNCj5jbGVtZW50Lm1hdGhpZXUtLWRyaWZA
ZXZpZGVuLmNvbTsgVGlhbiwgS2V2aW4gPGtldmluLnRpYW5AaW50ZWwuY29tPjsgTGl1LA0KPllp
IEwgPHlpLmwubGl1QGludGVsLmNvbT47IFBlbmcsIENoYW8gUCA8Y2hhby5wLnBlbmdAaW50ZWwu
Y29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDcvMjBdIGludGVsX2lvbW11OiBDaGVjayBm
b3IgY29tcGF0aWJpbGl0eSB3aXRoDQo+SU9NTVVGRCBiYWNrZWQgZGV2aWNlIHdoZW4geC1mbHRz
PW9uDQo+DQo+SGkgWmhlbnpob25nLA0KPg0KPk9uIDcvMTYvMjUgMTI6MzEgUE0sIER1YW4sIFpo
ZW56aG9uZyB3cm90ZToNCj4+IEhpIEVyaWMsDQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+Pj4gRnJvbTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPj4+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDcvMjBdIGludGVsX2lvbW11OiBDaGVjayBmb3IgY29t
cGF0aWJpbGl0eSB3aXRoDQo+Pj4gSU9NTVVGRCBiYWNrZWQgZGV2aWNlIHdoZW4geC1mbHRzPW9u
DQo+Pj4NCj4+PiBIaSBaaGVuemhvbmcsDQo+Pj4NCj4+PiBPbiA3LzgvMjUgMTowNSBQTSwgWmhl
bnpob25nIER1YW4gd3JvdGU6DQo+Pj4+IFdoZW4gdklPTU1VIGlzIGNvbmZpZ3VyZWQgeC1mbHRz
PW9uIGluIHNjYWxhYmxlIG1vZGUsIHN0YWdlLTEgcGFnZQ0KPnRhYmxlDQo+Pj4+IGlzIHBhc3Nl
ZCB0byBob3N0IHRvIGNvbnN0cnVjdCBuZXN0ZWQgcGFnZSB0YWJsZS4gV2UgbmVlZCB0byBjaGVj
aw0KPj4+PiBjb21wYXRpYmlsaXR5IG9mIHNvbWUgY3JpdGljYWwgSU9NTVUgY2FwYWJpbGl0aWVz
IGJldHdlZW4gdklPTU1VIGFuZA0KPj4+PiBob3N0IElPTU1VIHRvIGVuc3VyZSBndWVzdCBzdGFn
ZS0xIHBhZ2UgdGFibGUgY291bGQgYmUgdXNlZCBieSBob3N0Lg0KPj4+Pg0KPj4+PiBGb3IgaW5z
dGFuY2UsIHZJT01NVSBzdXBwb3J0cyBzdGFnZS0xIDFHQiBodWdlIHBhZ2UgbWFwcGluZywgYnV0
DQo+aG9zdA0KPj4+PiBkb2VzIG5vdCwgdGhlbiB0aGlzIElPTU1VRkQgYmFja2VkIGRldmljZSBz
aG91bGQgZmFpbC4NCj4+Pj4NCj4+Pj4gRXZlbiBvZiB0aGUgY2hlY2tzIHBhc3MsIGZvciBub3cg
d2Ugd2lsbGluZ2x5IHJlamVjdCB0aGUgYXNzb2NpYXRpb24NCj4+Pj4gYmVjYXVzZSBhbGwgdGhl
IGJpdHMgYXJlIG5vdCB0aGVyZSB5ZXQuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFlpIExp
dSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVh
biA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4+PiAtLS0NCj4+Pj4gIGh3L2kzODYvaW50
ZWxfaW9tbXUuYyAgICAgICAgICB8IDMwDQo+Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystDQo+Pj4+ICBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggfCAgMSArDQo+Pj4+ICAy
IGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pj4NCj4+
Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9t
bXUuYw0KPj4+PiBpbmRleCBlOTBmZDJmMjhmLi5jNTdjYTAyY2RkIDEwMDY0NA0KPj4+PiAtLS0g
YS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+Pj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
DQo+Pj4+IEBAIC00MCw2ICs0MCw3IEBADQo+Pj4+ICAjaW5jbHVkZSAia3ZtL2t2bV9pMzg2Lmgi
DQo+Pj4+ICAjaW5jbHVkZSAibWlncmF0aW9uL3Ztc3RhdGUuaCINCj4+Pj4gICNpbmNsdWRlICJ0
cmFjZS5oIg0KPj4+PiArI2luY2x1ZGUgInN5c3RlbS9pb21tdWZkLmgiDQo+Pj4+DQo+Pj4+ICAv
KiBjb250ZXh0IGVudHJ5IG9wZXJhdGlvbnMgKi8NCj4+Pj4gICNkZWZpbmUgVlREX0NFX0dFVF9S
SUQyUEFTSUQoY2UpIFwNCj4+Pj4gQEAgLTQzNTUsNyArNDM1NiwzNCBAQCBzdGF0aWMgYm9vbCB2
dGRfY2hlY2tfaGlvZChJbnRlbElPTU1VU3RhdGUNCj4qcywNCj4+PiBIb3N0SU9NTVVEZXZpY2Ug
Kmhpb2QsDQo+Pj4+ICAgICAgICAgIHJldHVybiB0cnVlOw0KPj4+PiAgICAgIH0NCj4+Pj4NCj4+
Pj4gLSAgICBlcnJvcl9zZXRnKGVycnAsICJob3N0IGRldmljZSBpcyB1bmNvbXBhdGlibGUgd2l0
aCBzdGFnZS0xDQo+Pj4gdHJhbnNsYXRpb24iKTsNCj4+Pj4gKyNpZmRlZiBDT05GSUdfSU9NTVVG
RA0KPj4+PiArICAgIHN0cnVjdCBIb3N0SU9NTVVEZXZpY2VDYXBzICpjYXBzID0gJmhpb2QtPmNh
cHM7DQo+Pj4+ICsgICAgc3RydWN0IGlvbW11X2h3X2luZm9fdnRkICp2dGQgPSAmY2Fwcy0+dmVu
ZG9yX2NhcHMudnRkOw0KPj4+IEkgYW0gbm93IGNvbmZ1c2VkIGFib3V0IGhvdyB0aGlzIHJlbGF0
ZXMgdG8gdnRkX2dldF92aW9tbXVfY2FwKCkuDQo+Pj4gUENJSU9NTVVPcHMuc2V0X2lvbW11X2Rl
dmljZSA9IHZ0ZF9kZXZfc2V0X2lvbW11X2RldmljZSBjYWxscw0KPj4+IHZ0ZF9jaGVja19oaW9k
KCkNCj4+PiB2aW9tbXUgbWlnaHQgcmV0dXJuIEhXX05FU1RFRF9DQVAgdGhyb3VnaA0KPj4+IFBD
SUlPTU1VT3BzLmdldF92aW9tbXVfY2FwDQo+Pj4gd2l0aG91dCBtYWtpbmcgc3VyZSB0aGUgdW5k
ZXJseWluZyBIVyBJT01NVSBkb2VzIHN1cHBvcnQgaXQuIElzIHRoYXQgYQ0KPj4+IGNvcnJlY3Qg
dW5kZXJzdGFuZGluZz8gTWF5YmUgd2Ugc2hvdWxkIGNsYXJpZnkgdGhlIGNhbGxpbmcgb3JkZXIg
YmV0d2Vlbg0KPj4+IHNldF9pb21tdV9kZXZpY2UgdnMgZ2V0X3Zpb21tdV9jYXA/IENvdWxkIHdl
IGNoZWNrIEhXIElPTU1VDQo+Pj4gcHJlcmVxdWlzaXRlcyBpbiB2dGRfZ2V0X3Zpb21tdV9jYXAo
KSBieSBlbmZvcmNpbmcgdGhpcyBpcyBjYWxsZWQgYWZ0ZXINCj4+PiBzZXRfaW9tbXVfZGV2aWNl
LiBJIHRoaW5rIHdlIHNob3VsZCBjbGFyaWZ5IHRoZSBleGFjdCBzZW1hbnRpYyBvZg0KPj4+IGdl
dF92aW9tbXVfY2FwKCkuVGhhbmtzIEVyaWMNCj4+IE15IHVuZGVyc3RhbmRpbmcgZ2V0X3Zpb21t
dV9jYXAoKSByZXR1cm5zIHB1cmUgdklPTU1VJ3MgY2FwYWJpbGl0aWVzDQo+PiB3aXRoIG5vIGhv
c3QgSU9NTVUncyBjYXBhYmlsaXRpZXMgaW52b2x2ZWQuDQo+Pg0KPj4gRm9yIGV4YW1wbGUsIHJl
dHVybmVkIEhXX05FU1RFRF9DQVAgbWVhbnMgdGhpcyB2SU9NTVUgaGFzIGNvZGUNCj4+IHRvIHN1
cHBvcnQgY3JlYXRpbmcgbmVzdGVkIGh3cHQgYW5kIGF0dGFjaGluZywgbm8gbWF0dGVyIGlmIGhv
c3QgSU9NTVUNCj4+IHN1cHBvcnRzIG5lc3Rpbmcgb3Igbm90Lg0KPg0KPlRoZW4gSSB0aGluayB5
b3UgbmVlZCB0byByZWZpbmUgdGhlIGRlc2NyaXB0aW9uIGluIDIvMjAgdG8gbWFrZSB0aGlzIGNs
ZWFyLg0KPnN0YXRpbmcgZXhwbGljaXRseSBnZXRfdmlvbW11X2NhcCByZXR1cm5zIHRoZW9yZXRp
Y2FsIGNhcGFiaWxpdGllcyB3aGljaA0KPmFyZSBpbmRlcGVuZGVudCBvbiB0aGUgYWN0dWFsIGhv
c3QgY2FwYWJpbGl0aWVzIHRoZXkgbWF5IGRlcGVuZCBvbi4NCg0KV2lsbCBkby4NCg0KRm9yIHZp
cnR1YWwgdnRkLCB3ZSBhcmUgdW5hYmxlIHRvIHJldHVybiBjYXBhYmlsaXRpZXMgZGVwZW5kaW5n
IG9uIGhvc3QgY2FwYWNpdGllcywNCkJlY2F1c2UgZGlmZmVyZW50IGhvc3QgSU9NTVUgbWF5IGhh
dmUgZGlmZmVyZW50IGNhcGFiaWxpdGllcywgd2Ugd2FudCB0byByZXR1cm4NCmEgY29uc2lzdGVu
dCByZXN1bHQgb25seSBkZXBlbmRpbmcgb24gdXNlcidzIGNtZGxpbmUgY29uZmlnLg0KDQo+Pg0K
Pj4gVGhlIGNvbXBhdGliaWxpdHkgY2hlY2sgYmV0d2VlbiBob3N0IElPTU1VIHZzIHZJT01NVSBp
cyBkb25lIGluDQo+PiBzZXRfaW9tbXVfZGV2aWNlKCksIHNlZSB2dGRfY2hlY2tfaGlvZCgpLg0K
Pj4NCj4+IEl0J3MgdG9vIGxhdGUgZm9yIFZGSU8gdG8gY2FsbCBnZXRfdmlvbW11X2NhcCgpIGFm
dGVyIHNldF9pb21tdV9kZXZpY2UoKQ0KPj4gYmVjYXVzZSB3ZSBuZWVkIGdldF92aW9tbXVfY2Fw
KCkgdG8gZGV0ZXJtaW5lIGlmIGNyZWF0aW5nIG5lc3RlZCBwYXJlbnQNCj4+IGh3cHQgb3Igbm90
IGF0IGF0dGFjaGluZyBzdGFnZS4NCj5pc24ndCBpdCBwb3NzaWJsZSB0byByZXdvcmsgdGhlIGNh
bGwgc2VxdWVuY2U/DQoNCkkgdGhpbmsgbm90LiBDdXJyZW50IHNlcXVlbmNlOg0KDQphdHRhY2hf
ZGV2aWNlKCkNCiAgICBnZXRfdmlvbW11X2NhcCgpDQogICAgY3JlYXRlIGh3cHQNCi4uLg0KY3Jl
YXRlIGhpb2QNCnNldF9pb21tdV9kZXZpY2UoaGlvZCkNCg0KSGlvZCByZWFsaXplIG5lZWRzIGlv
bW11ZmQsZGV2aWQgYW5kIGh3cHRfaWQgd2hpY2ggYXJlIHJlYWR5IGFmdGVyIGF0dGFjaF9kZXZp
Y2UoKS4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

