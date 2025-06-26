Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80969C77B7F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 08:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUi7h-0007t1-S1; Thu, 26 Jun 2025 04:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uUi7e-0007sg-OJ
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 04:38:19 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uUi7a-0003fA-J0
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 04:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750927095; x=1782463095;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1Zw18KuQjFfM4ccyjzBbU7tNFURv+cNdds+7AShk76I=;
 b=i8a8tyi1pVsbMt8W9rdxk+Bgnd4NfLBDZjARiSCpQDrX6dqZfspFeoIY
 QbwkpaqIAHoicq7omzRhFmKsgQfnpALd0JrbU6EX8IdLfTcfUif5L5v/y
 dvcccVm0F0g/0xgErPBO1q4vp/PHLVbnlcRECdtmS26pD2wsQuxb2LMLo
 Oi4Lyq3/2hEZGlyFymyoOi78UKMCb0V8lbgBH17phG/jLqqlLrT9ACT/i
 8OVuMnlPhFsZOxmQlEoFV0HwFrJjV7OMUwDYABadfkfv21OulmAUJclKh
 Iy3am2zcKm7NJL0lTIZkXSmkzVzCxBNNdNLLzoEhuyVTYUD9sm1Fy+8JM Q==;
X-CSE-ConnectionGUID: CUKy5UWwQy260MMygPFEyA==
X-CSE-MsgGUID: oebnQJQNSGGjvtucwyp8Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="52332021"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="52332021"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 01:38:10 -0700
X-CSE-ConnectionGUID: iCGh/u8BRK+kkNUL9B9V/w==
X-CSE-MsgGUID: iz3eJ9x8Ss+gK3S3avht1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="156725735"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 01:38:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 01:38:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 26 Jun 2025 01:38:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.70) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 01:38:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKC1J5Pt5xCdx8pY/KdT6CWLMwys1CwsK1gBswBED/5ohDrJR+NgQXY6oqPjOaIazC0hIdm7UrxflaKEA0UGQ5kQtJ4jPwBYL24W3xl52CZpImS+ievfdFbPaUHiXV1MKpCZmo1Qgk35Rf15SW/bIYuEzVwIVA6/8JNzE0m54TDEDikKAmzgswHq+LbdYV6Qh8N29eqwJLHxYvN8s5jdQhyq/hgcKEgmBuv9roBL9O6/pd6fS6t6p0jr6/aVEmwNvCHknxFu/ul2JtKxx+UWoPnF+3u6zzCfIMFvivPsKfqFsLC9E4bSModq7d5vPzUntjZptYpl/M0L84EDw1rFeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Zw18KuQjFfM4ccyjzBbU7tNFURv+cNdds+7AShk76I=;
 b=Nly97vROs0JtSGoA1JFzRTcw80S/6h2aS4KdyN9R98ngjag083W0s2GdgIsSrxByHf+FSPKDO2hVyJj5z+fFiDKlF6p3wL5aBZTCQgLzIWk5wJTvkwQMvXkT96ISImYc0lRo2imrjKay4L3vp6X/8jGIhTlrE9zu+Yiq5FzPO4Ik0o1PZKKiRl1CPce3BvPAKUJdqg7tiZeFbd86IS33ifuTSdNrmbQMg6JoKMKbWbWxFWu3lYL0LosV+fwj5xAUrI23K9ZKppbxZA6tg9MXDtUcTXZaA+i9BBmS2mw+wx3f+hX195ot4L1/bE8PXDTsKrldNksOA0gJ8sS+BDuJDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by MW4PR11MB7078.namprd11.prod.outlook.com (2603:10b6:303:219::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Thu, 26 Jun
 2025 08:37:49 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Thu, 26 Jun 2025
 08:37:48 +0000
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
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v2 13/19] intel_iommu: Stick to system MR for IOMMUFD
 backed host device when x-fls=on
Thread-Topic: [PATCH v2 13/19] intel_iommu: Stick to system MR for IOMMUFD
 backed host device when x-fls=on
Thread-Index: AQHb4bQ2DkevPfpUtE6i5URmfUob77QQqe6AgAReZpA=
Date: Thu, 26 Jun 2025 08:37:48 +0000
Message-ID: <IA3PR11MB9136E0871BB2D4208A523D8B927AA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-14-zhenzhong.duan@intel.com>
 <275e56ed-940b-4ebe-a1bb-37c556ea909f@redhat.com>
In-Reply-To: <275e56ed-940b-4ebe-a1bb-37c556ea909f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|MW4PR11MB7078:EE_
x-ms-office365-filtering-correlation-id: d98440b4-9303-485e-22d0-08ddb48cbb63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?b0lXc2pOclpQa3RVMkpJTWNxdGx5eStnUS9TVXYwZnZBVmR3YzdYY2JtUUxZ?=
 =?utf-8?B?VTYxWjVxSEJqbkRuR2JtVE1tUlI4bDhnNFo0M1N1L1JuTDVBZXZzazZPNjFx?=
 =?utf-8?B?eTZuQUF0MllHeVVoY1E5aTVCMDN1L2FiOW5SbWF5a015SG5HRzdpb1I3ZjNP?=
 =?utf-8?B?ZC9pNEZSWWRpVExWMFZ5RG1Hb0JWZVhVYUN5eTZYdlpsaEhlaXZlVEtOV1dW?=
 =?utf-8?B?TzFObUgxYVdiT1dGVk9VRlZrZUJEWUVxWi9FU3pYeFd4L0xFU0VURUFENGUv?=
 =?utf-8?B?dFJqU0Z0cWxUTmFxMXRQaXhrQkozdkJGZTEzUUsrd2VDNEdUcnpXVDhNaUdM?=
 =?utf-8?B?MXZmUms3TjdxZUlBQ3hFVThXV3diTTczSU9pb2tDcEVXQmt2UGEzekxMVEdo?=
 =?utf-8?B?SWZpcHdnRUZLS01jcHYwd2JxanVNL1NoWkJIdzlYVGVMeFcrWG1ycmdsMmQy?=
 =?utf-8?B?Nmd1WEgxYWdRNzRjRE5hQjdkQTNQNmZVTnJ1MEJKM2pUbDdpNzdyS0pjOWhI?=
 =?utf-8?B?NkpaQjVwM25ORmJiZkVUL2NGYmlObDUzMjNyZ25KM2wxYmk0TCtlc2ZUWUFj?=
 =?utf-8?B?NkFsQVZ5VVJMOUtNRllXTmhTNXJNaEJ4dXBvVWRMU2htQVV4NWFwUGorT25q?=
 =?utf-8?B?U3lYaUZJcE5TdlF4V0Foa2l5R21Mci82ZkhobGJad09ibHVCVDZjU1A4MG5z?=
 =?utf-8?B?R3NGaGwwUEJIYzV2Z2hKTG1WSjhBVmNHYjdKT3FzZjhZN0s0anE4Ulk4RWw4?=
 =?utf-8?B?eXFabC9yQlB4WDJtbDMvNGFEaGZseWpEQXl2TVE4bE5lWFpmTWJpNjI2NGww?=
 =?utf-8?B?TzNnTkhXSG93Skw3enJaOVB2T2tEczZPRWNFWTJscjhwSHRzcVM2V2dJNnpr?=
 =?utf-8?B?bnNVbDBOREl0MUxYMUVxRmNMaUJXaUxUblRKaDEvMG9hRlB0TTNlMVFweHpU?=
 =?utf-8?B?VkRHR2ROQXZLZWN6L3VaMmF5VVFHQUdSMk1pUkEwWlFHSDM0MHZjSk1wV1Nt?=
 =?utf-8?B?c0ROS0ttdktNTElkLzVPUytkU09jSzEwYjU0NzhldkRtMnBzV0JRc0hFWDUz?=
 =?utf-8?B?dmtZNDJuczJDNnY4UnJqUUNoZjZ0L1d1N05MaGRrMFI5SG5IVTRDcllhMlZh?=
 =?utf-8?B?clkvdnNNTFZOL2lKREQ4aVlIa01ndVdONitBSmQ0ajBKQjNsSFVDcy9BajNx?=
 =?utf-8?B?Q0VUUnVHNWZTTERqMW9Fc1BJanNkTlU1akh2aXFqWmR0c05JMjVZdndKRmFm?=
 =?utf-8?B?S2Q1UjZpb0FMSkhEdXJyTGJqbDFHbVNJT2c4MG4rWU9oOXhvUFVsTGpRdkpR?=
 =?utf-8?B?QXJYZ3BCWDUvenJIYWFHcU1BZ1BlY0Q2UFA0U045SFZIaWhsVjBCdjJ5dVRO?=
 =?utf-8?B?VVkwYmZuQ003ZzBUZUtvWXdNcDJMeC92SzBXMDRISmdVTTJCSGR2T0dPbDc3?=
 =?utf-8?B?Y1hTNHNvZVp3MWRZbG8zdFp2bCtXU2FMWGVNZEgzMFpTRWVDOExkTXJQckZO?=
 =?utf-8?B?TFlrT1Ztdmo2bzZXOUxCMHdyOGV1c3pycjFpZzJVTmhlc3VwSDNVcmpBbE9W?=
 =?utf-8?B?eEhGb0x0Uk1QM2hWbGd5ZVhLZ1BQYTAyK1RWb2NXcEtVWUw0bXUzSEFmczVr?=
 =?utf-8?B?OHVvSXE3enVYYkFpMlJ4dDltSGxoRmdSM0YzRDFpNUJKNDN3NzhhMkN1VmNZ?=
 =?utf-8?B?bzVYYnFOYzhrb1JRTnJ6WnkxVnBNRDQ2V1RSR0N1b1lydG93T2hEQURNcU0z?=
 =?utf-8?B?NnBYSGFBOTZveGYwNlhudXBEQ2hkNkJ5L0JlZjhVZ0ZydG9UK3JjdG5kT2J2?=
 =?utf-8?B?MitEVFBjQ3ZXRTB1YmxLYnRWRGlQZk9yaTRFY2xrbUxjaldobmFJSDIrZVlx?=
 =?utf-8?B?bVo1VlFOL1N6MERDV3J5VVovYmFNcm1kQ29sUm1JV3dsSitLeTZ2M1dtVDVW?=
 =?utf-8?B?dGQ5bHlTc2F0WGhVRzdPakd5b2tqaWxGeXIvWEJwcWdqVExNQzdMWnQ0NFRC?=
 =?utf-8?Q?iKxO7oDEqFD95/Ck9FJGwKov1p1zYo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1V2dTV3ZWlxdEhqT0lOVThPcDB1ZzhIeGVlbTJxN0xwWjJUUndhcUFkL3dI?=
 =?utf-8?B?Q3lIbkJYZWJ4azJlMUFIekNFanUwc01XZGpLMllkQUVwSHMyV2IwY2o4SHB0?=
 =?utf-8?B?enRVMmtwQzI1VmVSZ3JWMGFaNUZvOXQzMzNpWTI1U3hhZ0YzRWV2S1JydmdU?=
 =?utf-8?B?dFNZK1BuQ0F0a2hFdWtMVWV4UisxbmVpTU9RTFVLekozQWxWbTBCQkg3aVdH?=
 =?utf-8?B?SEVhd3ZiQUNDd2czckRFSTRDZkl0RE1lVkRzRlcrcU1NRUI4bmg2QnV3ckEx?=
 =?utf-8?B?dXJNc0JScHhIWEN3TW1oSTJVOTNCNXFqajJzMWFJNkRvVFF1M1hTa1hNejBG?=
 =?utf-8?B?Q0RkeEsxQTU2VlQ5anpSWHRMbmdXdTRsRkdVRSt0TS8zL0NwdmtuQlZUNC94?=
 =?utf-8?B?bzJOZTdPNlQ2bTVmblJwVDBwKytwU3FWOEpJRXMwU09VaUFFT00vMmVJSmNq?=
 =?utf-8?B?Rld3V09HTWQvUWloQU5XM05tY1ZWM245TXJ2OCtoU2hWOGlnc0tZWVhrM0ZK?=
 =?utf-8?B?cVFjQW5BbFFJa1BEczhoekx5ZTkzQWZBZHUrQTQzcTBLRjF5WEZ4VlZwMVFP?=
 =?utf-8?B?YmUwNGErOEVZS3VmUmRPaUh2Qk5QSFVvaENsS2FPSXZYNDRNcDZvSm1sdjdN?=
 =?utf-8?B?SGZqbGFBcE5ibmwzamx5UjNrSWJIQkFub09aUWgxVTZhZnduNXVyRVpjeXZ4?=
 =?utf-8?B?azVJNTZUd2l2OWwzditocWR3TFVlYWU3T0k4VDBaTFBrM3ljZjZXaXFOSFEz?=
 =?utf-8?B?a0VXc05pVnRYaHRuQzBGZFpienhEUWRoMUxYWGpwTEdkZ092SkpjY3RidThU?=
 =?utf-8?B?eG8zbER2QXNVK3YrU2Y1L3g5TWgyZ0lpSEs5dEZDMVJyekhlZ011SU4rOFZs?=
 =?utf-8?B?ZzY2OXZvY2ZCa2xWQmRpbStadkwvUGFyODBhb3NjMGtFNFd5Y2VjUjNkVXlG?=
 =?utf-8?B?UU1XU3lLYzZHYVdPYVQwb25sbGlTc2xFSzZXeGxqbVJZc1orVGRtQUNwR0F0?=
 =?utf-8?B?RlAyUEkzMG0za2J2MGtyb0UwUU9DL2NqYWVRdkQreDFCU2xNemRkQ3RRNzlD?=
 =?utf-8?B?WWtEck1jb0xFTW5URjFYanE3OURuMFpTQTUrU3ZzWTE0R2Z0a2hucWJKcitn?=
 =?utf-8?B?VEVoWkNydkNHK1l1dzdUM0NWem5GQ0tCdlJOTno4cHE1bU91UHM4Z0x0YlNz?=
 =?utf-8?B?T0JDaUl1WDhwSFg3Mk11YzY2alg0RHh0MldvNWRmeWJpV3lzYUQ1WGUrZ0Qw?=
 =?utf-8?B?cVcrTjdNelFlZHk1UzVyNzZzNFRkSGdNMVJrb3Q4amRMZmYwMFJQNU5UZS9a?=
 =?utf-8?B?QjZqQkZKcHZpbW14d3VUN05SQXdsL1RTZk1peS9WZkF0T1lFSVZPTVhLYlFx?=
 =?utf-8?B?YU1HUzNRMXVVSytjT3dZbVNZY3dUL1ByOWFxWGJrR3VROGpXbTYweFBrbW9O?=
 =?utf-8?B?ZjBUaFA2ejVUYjk1bWhLM1NITDZZL1JZMlhMemxQM1A2UzZkL2lPQWk5YmZB?=
 =?utf-8?B?MGdIdnZ4elZSNHAvK0ZveVBCUW9IK053YWcvM1hXTWl3UG9XdkNQbkgrSVdE?=
 =?utf-8?B?MGRBTmxZRjA5Y3JIampZSkgrbkhPMkY3bTJ1SVV2SjZxeWRRSWhaa05kTlpq?=
 =?utf-8?B?Qm9xMVhPc0dsd3F2cWlvdnY5VHhqVEdXSVA5bjJ1aU8rbVZ6ckhnRW11ZmRV?=
 =?utf-8?B?MS9yNzhUYUZHNUI5a2hmZnNKelBSOG5aMGNCUTh6MkppemxyL051M3lPSTRT?=
 =?utf-8?B?eVRPV1hWZStQclJHbE80RFc0RVl3bkpjaXlpSnNmZnc0b1dYMzkwcEVKRzBU?=
 =?utf-8?B?YUFxd3Nvb1poYVoyN1hXaStac0ZqSTQ3bHNaMitrNEhrb0tzY05JeE9lekpX?=
 =?utf-8?B?dmZSMHpwVFBnQzFaUW1sbjh3RDNKQUNjMjIvbmJJMy9jSDZ1dEhsbTlkclVV?=
 =?utf-8?B?aUpoT05yeUF2dDFWcHplOGpvenJWczlJUzN2b2NSUkRkSjNSKzNzMkFqSGs4?=
 =?utf-8?B?TGNYcnAzdEZiSnlVcDYyeElyNS9MOXdZczhRTlZxaUVXN0NRY1pMMjAwTzJy?=
 =?utf-8?B?Q3UvK3Z1czB2bCsrRTJhbHlZZkpUOGluMGFFYzRHdFJkL2FpM3NYcGxGZWFv?=
 =?utf-8?Q?F03xB/Uwi/57Te6q+8A3KHB6G?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d98440b4-9303-485e-22d0-08ddb48cbb63
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 08:37:48.8135 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HlQDVEkpPke2g/1qQASCKk3xMkNjuWVSYYw7MqY2yzv7YhEeNcdCWpCrPNXlnGwak5lsQl/qo3V4H3Kz0XBbmtKAeYT4Sdkz8ODW2WqV+LQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7078
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDEzLzE5XSBpbnRlbF9p
b21tdTogU3RpY2sgdG8gc3lzdGVtIE1SIGZvcg0KPklPTU1VRkQgYmFja2VkIGhvc3QgZGV2aWNl
IHdoZW4geC1mbHM9b24NCj4NCj4NCj4NCj5PbiA2LzIwLzI1IDk6MTggQU0sIFpoZW56aG9uZyBE
dWFuIHdyb3RlOg0KPj4gV2hlbiBndWVzdCBpbiBzY2FsYWJsZSBtb2RlIGFuZCB4LWZsdHM9b24s
IHdlIHN0aWNrIHRvIHN5c3RlbSBNUiBmb3INCj5JT01NVUZEDQo+d2hlbiBndWVzdCB3b3JrcyBp
biBzY2FsYWJsZSBtb2RlID8NCj4+IGJhY2tlZCBob3N0IGRldmljZS4gVGhlbiBpdHMgZGVmYXVs
dCBod3B0IGNvbnRhaW5zIEdQQS0+SFBBIG1hcHBpbmdzDQo+d2hpY2ggaXMNCj4+IHVzZWQgZGly
ZWN0bHkgaWYgUEdUVD1QVCBhbmQgdXNlZCBhcyBuZXN0ZWQgcGFyZW50IGlmIFBHVFQ9RkxULiBP
dGhlcndpc2UNCj4+IGZhbGxiYWNrIHRvIG9yaWdpbmFsIHByb2Nlc3NpbmcuDQo+Pg0KPj4gU3Vn
Z2VzdGVkLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6
IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICBo
dy9pMzg2L2ludGVsX2lvbW11LmMgfCAyNCArKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAx
IGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9p
Mzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IGluZGV4IGVkNzFi
YjhlYzcuLmJlMDFmODg4NWYgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMN
Cj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTE3NzksNiArMTc3OSw3IEBA
IHN0YXRpYyBib29sDQo+dnRkX2Rldl9wdF9lbmFibGVkKEludGVsSU9NTVVTdGF0ZSAqcywgVlRE
Q29udGV4dEVudHJ5ICpjZSwNCj4+ICAgICAgICAgICAgICAgKi8NCj4+ICAgICAgICAgICAgICBy
ZXR1cm4gZmFsc2U7DQo+PiAgICAgICAgICB9DQo+PiArDQo+c3B1cmlvdXMgbmV3IGxpbmUNCg0K
V2lsbCBmaXguDQoNCj4+ICAgICAgICAgIHJldHVybiAoVlREX1BFX0dFVF9UWVBFKCZwZSkgPT0g
VlREX1NNX1BBU0lEX0VOVFJZX1BUKTsNCj4+ICAgICAgfQ0KPj4NCj4+IEBAIC0xNzkwLDEwICsx
NzkxLDMzIEBAIHN0YXRpYyBib29sDQo+dnRkX2FzX3B0X2VuYWJsZWQoVlREQWRkcmVzc1NwYWNl
ICphcykNCj4+ICB7DQo+PiAgICAgIEludGVsSU9NTVVTdGF0ZSAqczsNCj4+ICAgICAgVlREQ29u
dGV4dEVudHJ5IGNlOw0KPj4gKyAgICBzdHJ1Y3QgdnRkX2FzX2tleSBrZXkgPSB7DQo+PiArICAg
ICAgICAuYnVzID0gYXMtPmJ1cywNCj4+ICsgICAgICAgIC5kZXZmbiA9IGFzLT5kZXZmbiwNCj4+
ICsgICAgfTsNCj4+DQo+PiAgICAgIGFzc2VydChhcyk7DQo+Pg0KPj4gICAgICBzID0gYXMtPmlv
bW11X3N0YXRlOw0KPj4gKw0KPj4gKyAgICAvKg0KPj4gKyAgICAgKiBXaGVuIGd1ZXN0IGluIHNj
YWxhYmxlIG1vZGUgYW5kIHgtZmx0cz1vbiwgd2Ugc3RpY2sgdG8gc3lzdGVtIE1SDQo+ZGl0dG8N
Cg0KVGhhdCdzIHN0cmFuZ2UsIEkgZGlkbid0IHNlZSBzcHVyaW91cyBuZXcgbGluZSBoZXJlLg0K
DQo+PiArICAgICAqIGZvciBJT01NVUZEIGJhY2tlZCBob3N0IGRldmljZS4gVGhlbiBpdHMgZGVm
YXVsdCBod3B0IGNvbnRhaW5zDQo+PiArICAgICAqIEdQQS0+SFBBIG1hcHBpbmdzIHdoaWNoIGlz
IHVzZWQgZGlyZWN0bHkgaWYgUEdUVD1QVCBhbmQgdXNlZCBhcw0KPj4gKyAgICAgKiBuZXN0ZWQg
cGFyZW50IGlmIFBHVFQ9RkxULiBPdGhlcndpc2UgZmFsbGJhY2sgdG8gb3JpZ2luYWwNCj5mYWxs
IGJhY2sgaGVyZSBhbmQgYWJvdmUNCj4NCj5UaGlzIGNvbW1lbnQgc291bmRzIGEgbGl0dGxlIGJp
dCB1bnJlbGF0ZWQgdG8gdGhlIGJlbG93IGltcGxlbWVudGF0aW9uDQo+d2hpY2ggZG9lcyBub3Qg
cmVmZXIgdG8gc3lzdGVtIE1SLiBob3cgZG9lcyB0aGUgc2VhcmNoIGZvciB0aGUgaGlvZA0KPnJl
bGF0ZSB0byB0aGF0LiBJIHdvdWxkIHJlZm9jdXMgdGhlIGNvbW1lbnQuDQoNCnZ0ZF9hc19wdF9l
bmFibGVkKCkncyByZXR1cm4gdmFsdWUgZGV0ZXJtaW5lcyB3aGljaCBNUiB0byBzd2l0Y2ggdG8u
DQpTZWUgdnRkX3N3aXRjaF9hZGRyZXNzX3NwYWNlKCkuIEhvdyBhYm91dCBhZGRpbmcgYSBjb21t
ZW50Og0KDQorLyoNCisgKiB2dGRfc3dpdGNoX2FkZHJlc3Nfc3BhY2UoKSBjYWxscyB2dGRfYXNf
cHRfZW5hYmxlZCgpIHRvIGRldGVybWluZSB3aGljaA0KKyAqIE1SIHRvIHN3aXRjaCB0by4gU3dp
dGNoIHRvIHN5c3RlbSBNUiBpZiByZXR1cm4gdHJ1ZSwgaW9tbXUgTVIgb3RoZXJ3aXNlLg0KKyAq
Lw0KIHN0YXRpYyBib29sIHZ0ZF9hc19wdF9lbmFibGVkKFZUREFkZHJlc3NTcGFjZSAqYXMpDQog
ew0KDQpXaXRoIHRoaXMgY29tbWVudCwgd2Uga25vdyB0aGUgcmV0dXJuIHZhbHVlIGltcGFjdCBN
UiBzd2l0Y2ggYW5kIHRoaXMgcGF0Y2gNCmRlYWwgd2l0aCByZXR1cm4gdmFsdWUuDQoNClRoYW5r
cw0KWmhlbnpob25nDQo=

