Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2315D3E799
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 06:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTaUX-0006K3-3p; Thu, 11 Dec 2025 01:49:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vTaUV-0006JC-Bq
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 01:49:31 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vTaUO-0007xr-KI
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 01:49:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765435764; x=1796971764;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DUXc7HWYmNsNLAZb7hM7INW5n7DGTRt2kfciwbeWzXs=;
 b=YKI3ALC9bjocIpQ/eIVTKcNvz5Q4V6Aao4e/feqx6cp2QB4Rz/GM2tRm
 T8/+TVh2zHGWvg/uTqUinHiVfCaVyMFkfPEhUCNLyy8ba5gJ0kSPmZ6OU
 WUPTVGBQUw0p2VAE8aH7yiDb/5IrYz5PIgIQgfGWWL7j83yIInMRXnxxw
 SBSPKPLHnTdQfbhF1Cexlzej6MZOHkZ78Jlvaz70BQ96R0ugIwM2fj80c
 qsIPK8bmM9DaaytyDkQBgelFZGgQeU54miSZH/hYWjHX0G/aXlGTUPvAC
 /v+mfLzvZkU2a3Q5JtBoNIC5iLiU1vHBVsyZhulk3zM71YX0WXmxV995A g==;
X-CSE-ConnectionGUID: b/0hoYXsRqSxliAyuuZBpQ==
X-CSE-MsgGUID: FsOUb4y0ScK6DKOh9T+cYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="67585049"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="67585049"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 22:49:17 -0800
X-CSE-ConnectionGUID: En74Vf6iRLKKNVu0xBovfA==
X-CSE-MsgGUID: WZyv/KWYTC69x0F9+59NJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="201200253"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 22:49:17 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 22:49:16 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 10 Dec 2025 22:49:16 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.63) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 22:49:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQdFMLn1SOIs0Oqj4K5Fm72CgayMXc1RbuvbyJensl2VeQIXSQKQUjOdXAa7u3xrCYCeaaDgdUfxbnA7qqA6gxEBoVXTKPtlgdr6OGWsqxVkS5f1gCj9AN5+ArZ2/AeeDf3d9cUj3OL49pvSEYBBL57ziOsjRm8KQZiYOssa4pvjcTyYoYTb3F33COcUjjqDMgA/W3tURmguQz4ArfOmais4OtqxjkYef7ge5HC7mtSDdgGVnCFDglKBs5d3mqL5ctwH91e1XkTTrCdF8+y3/7XSmddpO8cuwKqEI8Yh9ZX76n1sx2kY0iaoXXXkDiCl7rc4VJmwkE9qFw8e/etb2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUXc7HWYmNsNLAZb7hM7INW5n7DGTRt2kfciwbeWzXs=;
 b=D0MdpLEB7luvdmutfpoUm/F4wu3Hf3tRTpgPqq+iYcU/xiNoExMVeYS/uwF3cPtM3E7g8JivTUnzqjacVBWO8fPnG4yUP27NSF+WQRGohW3bA/KFEcn+wb7l3+PDgG1HinDDCwCDx7ZgY8XmfPjhukJRhrcwjutNaNRBe3KmDA9eT7n6DmYANvUtUwc+nHR0XF8bxutJz6XbNBMhrfjq62YNJT3LsHfzzhnkt0T29A+K+ScDEftvOW1/efOJdN5VJW6au4P3g+JqZ7yKxssbrHtJGxnmJeqNIm/JJTGDtPwyNbzswxuLjeFk8+MSsWg892nYViCoqOv69dlfaC+klw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SN7PR11MB6825.namprd11.prod.outlook.com (2603:10b6:806:2a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Thu, 11 Dec
 2025 06:49:14 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 06:49:14 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "skolothumtho@nvidia.com"
 <skolothumtho@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v8 09/23] intel_iommu_accel: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Thread-Topic: [PATCH v8 09/23] intel_iommu_accel: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Thread-Index: AQHcV6YKforrUDQa4EmwlqHgD985s7UbCwQAgAELprA=
Date: Thu, 11 Dec 2025 06:49:14 +0000
Message-ID: <IA3PR11MB9136A94E3A6B29A2F35D57EA92A1A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
 <20251117093729.1121324-10-zhenzhong.duan@intel.com>
 <52074045-fe32-4fbf-b8a3-5037438649f7@redhat.com>
In-Reply-To: <52074045-fe32-4fbf-b8a3-5037438649f7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SN7PR11MB6825:EE_
x-ms-office365-filtering-correlation-id: 3b4f5cc6-9086-44fb-66c4-08de388165bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?amVxc3hqRWU4Zi82VWppazloTVJnUFJwUWdBcG53WTA4VUZ0KzhOMnIrUjNV?=
 =?utf-8?B?T1IyUThGYmNzenJPZXZadnJFdmZPbXI1NUJ4MmswbStTL0dEbDN2V2JXeDY3?=
 =?utf-8?B?cWNQTjZ4ZlVIQ2VoU1JYZXEvSHNBdGRJNHNER3pDNktWS0dEZUN6YjZNczA5?=
 =?utf-8?B?M1Fta1VrUUJmRmFJQ2hmbWd1QzE3YzBKMGJMVk9VSkFVTWpabFozZEdBazdt?=
 =?utf-8?B?N3FrOUt4ODc1cFVoNFZwNldRck54aHVKVjB4UW9kcytTUGlHZVUwYzQwZStZ?=
 =?utf-8?B?N1ltbXl2dU42cnlCT1U0S1dFVC9WRC9PeEwxZDIwNW9CL2pYWlE0anJKa3Bm?=
 =?utf-8?B?ZVY3U0RrOGJ2dEFnS3Z4c0JOSHQwelp3VlQ0ano4WmVjaHowZjE4NVltY1dG?=
 =?utf-8?B?V09tQW1rc083MG1QbUpCUUxVY3dUY1l1V1lDSjdGTXlFck9XV2VpdXgzQy9h?=
 =?utf-8?B?b3lnSDNodXJoM3dqRWNuZ0hRZ0psK0tFTThYb1Z1SGwzajBGODZseGxZZUxi?=
 =?utf-8?B?ZGt0ekM2M0kzQ0U2MkhtRlp6Tnh2UXE3UWNwWGJMMnFsUFVDYXRpK3FsVXhG?=
 =?utf-8?B?US9IUWN1dkRIUVVhdVI2UzNZa0NkWHU3cUVMdGhyODgyM05Xd1gwQWpxSmpY?=
 =?utf-8?B?a0VKVVFaSDUvNVEvMDkrSnQvNTZ4RmFScVE3SVFhMmVaRjNFT08zVEpxTENU?=
 =?utf-8?B?QjdMM0FoZktXNmVuMlZjWjlYUG9iMmZ0ZlgzR2dtZTM5cG9HTVNCYk02Zmw5?=
 =?utf-8?B?NkpmQWdWanZQZXgwKzJERHptdzlzRURRdjRISHR3SFJSeWZrYTlUYzJnTlJk?=
 =?utf-8?B?SlhBSGY3b200VHhRNm5QYUhici9zNlYrN1c0MG85WHBNS1NQMnBjSmprV1Jo?=
 =?utf-8?B?NUdXZ1k4SVVvK0tNSjh2eTNJOG1aT0k5TmVPK042dktBZDhpbWl5dTJPa1Zs?=
 =?utf-8?B?RXlMRm1EdkpydlN5Zkd2d0FSSFY5dGNvZlNKMEJPRWtIRy9sVStYVEZkdWxL?=
 =?utf-8?B?WFl1dHZ2S0xreUY5cXlUVDFYUGxDM3RiS1JPT2UzUzlLYTBkazBnQ1Yranp5?=
 =?utf-8?B?TVVjNUJKbnoxSk43NG9RM3ltWEdLYmJwWVR0c2pxSDVxVHJPc2NwOWo5TzBi?=
 =?utf-8?B?UWoxVjFQVk5jamRoRjNIb0NIYlBRcWNxTWNzRlV0azhzdU1qcDcrM0JLcmQy?=
 =?utf-8?B?Z0JkMjgzbEUyR09lTHlpZnQ0N0Z6S0tHdmNuSWJjQUcvK0ZQNDFJTkh3cFp1?=
 =?utf-8?B?OHFEdUhVNzJ2SGpvaWRrVFpFRUNkaDhTNURoL1B4bURpMTVlSUFLWXRVNGIx?=
 =?utf-8?B?bFk3YWhxTUN2OEcyWnQ1TGFiTENtQzhwQUQ0Z1A4VlRQaitJN1JoWjNlcGll?=
 =?utf-8?B?V3BPS1dVL015WkdSdU1JSTNnZE9pdUtuSStXL0VhR1ZVVTRqVUVCQmRoUi9j?=
 =?utf-8?B?UXBSMWtKWWJVNklUZzIra1FKSVpQTnNvOHNwZDNOVUJjR0V1VmVUaFpzQk9L?=
 =?utf-8?B?SUlRRGhYM3BFNFkyU2RiaEZ5bk9FTDVpdFJDT0xpa0wxeHBBb0RhOHRKZjVW?=
 =?utf-8?B?TklUUDZDckwxamx0QmtraVZsamZ6cEZxVHRJOSs3a3cvZHdMdlJXTThTMjND?=
 =?utf-8?B?WEtoUUR5MXpWZy9FQURETlJwMXhwTnp2MFVmc1FwQ2ZudUVMOTFFMkNmMCsv?=
 =?utf-8?B?RGdyMGFzYUd3blJBMzJDY2xLY3V1cGU4TkRiMmhRM0E2NklsVGVXSFAzMnFr?=
 =?utf-8?B?STRHc3A3RDFadWRwMzgraktsckVRK0toQkdoTkN2VFpTUGtueSt2OFJOd3c1?=
 =?utf-8?B?MGw1emRCTUFJMGRTSi9YVlA4dWk5VEYzQXVOMEdtcE9zb1VZU1V0VXFLVzFR?=
 =?utf-8?B?KzhTbW1GL1VzeURTZ3ZHL0RkTFd6WTIrVjNDYW9jWUZyR3JmcDkwUFVqTURW?=
 =?utf-8?B?NGZNaDZsS3FhSTI5RlRPNlYxQUNpRndjSHptOEdsL1hKbVN2c3JzZU5rajRn?=
 =?utf-8?B?MUhDc0g3WGpNR0hQZy9JSFdvS3lTTDhoYTNKU0RXYTQzZVNhS0JGWmpFZHM3?=
 =?utf-8?Q?waWIl0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWpKRy9QcDlQbjRBVGhLcTVxVC9UUURBdzlFSGZKNzlmY2ZsMjV5Y0k3dmxN?=
 =?utf-8?B?QnJVVGVNM01XS0xuN1hpNnlyNkQrbGVXMHNFS1dIK0Z1eW84aVN0ZXBUeEsv?=
 =?utf-8?B?b1ptRS9neXRheWVJYU9yWmlFR3dkUTdrOW5yMFh3b0gvZE8yOGJhejZYalFl?=
 =?utf-8?B?RkVrZ3RRakhUL2lNckFpd3lYTHkva0JRanRPd1BDRzF3Qm5DYkc1SVVNMGlT?=
 =?utf-8?B?eHEzc0hnak5QeTUyQTBNTVQ0Tmx4Uks3bGVWZitqSGdGTkd2RzRGZkhTWlEx?=
 =?utf-8?B?SmUzOEd6bUl0SjVTZ3hkRlptZk4wZ3IydW9jbjFVYi9NTk1panU0L3pyZDdK?=
 =?utf-8?B?YVdWdGZGNlB5Q3JWeFdsZStvdEhxM3UzREM1eVR1TVVPek83WmIxcFdwTFVT?=
 =?utf-8?B?aStmY2lHaXVQU2grVUoyWkJXMHgyc0l2aEJCNnhUeVZPWitMc2pBMkdrTkJ5?=
 =?utf-8?B?L04xeGg1ZFZwSnVDS25pa0ZtUjNSMFNteXdhc3NqS2tOWmpDdkxjdWVpclJs?=
 =?utf-8?B?a29zRUhQYThDRmlTZEU5WHJHYTBWa1BndVFFcWdHRG02c3dCanhRc0grRUtv?=
 =?utf-8?B?NE0wYXFXYitFY1pUZUd2REhWeCsvYlUvYzRQZU8wbzVaaUUyVStVaFRnS3VS?=
 =?utf-8?B?U2VtVmhVRVJveWc4SWtLazl6SXBsc0xid0xPamNXNXQ3N1dhTlBiOHZ0Zkc3?=
 =?utf-8?B?cFBzMGJhcGVRWnRXOEI4QnJSTnVYeFN3Tzg4TUxQM2cwR2hFYWN3UHdYZWpp?=
 =?utf-8?B?N3JVbDJEbWtuWElQdFFUMHEwLzdtRlI0VDVQUG5RN3pjVVhveFVzL0I5ejgw?=
 =?utf-8?B?UTZsL3NWVEFRWUtiVC9seisrYzB2OWg0OUFCd1R0RUx4bmdFNU81aDR3WUtu?=
 =?utf-8?B?blk0UkQ5WVdoUElaWHhvRnZHdDFhU0g3KzBhR3JKYXJDd0dFVk1pYTExNE1l?=
 =?utf-8?B?VXFVampNQXFBR2FzNU5scStPS2dzWXBNUWF1anpsRU5SUzdXalhSWGMzMFA2?=
 =?utf-8?B?ek5Bd0hmVWxBc2hxUUFzNFlrN29aWnZKeFdmejhEWlNHZnVMR2dSUmdxb1Uz?=
 =?utf-8?B?VjBuRStNQ1VxdHRIVFJHcVUxY1hWcUlkOVdBZ29rT0JhQTNJTGgyLzN5eVZ2?=
 =?utf-8?B?NGxldndxcUh2bVRISzdRa0sreUR5WEVVS3ZLMHVJR2ZCV2hZS2JUYU8vRlJ1?=
 =?utf-8?B?S2w4ZUV2ZTRoRlV6UDVFbForcEV2MHNRRy9MUDJsNllFaklyZnQwWXNCTVZO?=
 =?utf-8?B?THVxVGU0dlRBWDlya0VrYWZzSng2NndtbzdIR2grdEtXbHkzYStFWUhEMmRT?=
 =?utf-8?B?MHlvbTgyOXZpSlJpc0FBZHllV2hKcEttNFlSOUcrcXhISlhuSDRWSEx5ZW1R?=
 =?utf-8?B?eWVteHdZRERZWGdVYnYxSDBhVGQwQXVCcjQwamVYMzBZamJ4N1lGeE5ybW5m?=
 =?utf-8?B?M0V3Z1V1dURlUGxtZ3RZZmJoWGxUNkVEN3d6NVg2aGRXRUJUYnY1K1UraWlN?=
 =?utf-8?B?L1VVaTZndVAxMGVLTmFXTVB6UWY4VXRNNDErL3d2OXVNVW5tTWFzRnVmNytC?=
 =?utf-8?B?eG1DQjZqaWoyNWFXTUM5SzZGb0E3RkNyVHZQcTg4VUlQWDdhMGJvQ3pXaTcx?=
 =?utf-8?B?QTBUdm85dDYzY2RPSno1cXBveWhZakEzSmhkVUdEUjJ6R082MkswSmYrU0hM?=
 =?utf-8?B?Skp4NXlRTC9MNllRbDhPRElQWitIMFhaQUtDTnhPK01DMEZsRUZiN2VWMUJD?=
 =?utf-8?B?dzFGaWZ6ayt6YjVUUVpjRlk5Z0ZaZlArekJ4MFhCNHR3elRvK016MlRzazBu?=
 =?utf-8?B?bVBuV1dQdkF2TEpaNkhKZlorbHc0QzN4bWUrRDBjZkVpUkVpenJNVWJxbTZu?=
 =?utf-8?B?UTNCdWdjL0tveFJ1VUFMVU05R01PdWRLZFNKNHU3TGE1YTQyd2dkU1kvSFYz?=
 =?utf-8?B?eXJyUlFjZ1pRTVNaU3pzNFZEbWR5QXY2ZWpiejVXaWZEajJqSDY5Vmx3RzUr?=
 =?utf-8?B?ZU90VUtnREFHRWVsbU1LeU9lQ2tSekY1dDNzenU3Q1l6ZVV4MDdsSlI2MnRN?=
 =?utf-8?B?dVMxVW00eXlNczJtZjVDdUc0VEpGUnpUR0hyb0hxZHIwSVN1dGphQ1ZrTTdN?=
 =?utf-8?Q?GYmmNKfuiGzo1vTJTtW+2/IBa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4f5cc6-9086-44fb-66c4-08de388165bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2025 06:49:14.1854 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w+R1hnV9y3ImbBuNbRqS4xLRRqCsgrZSnGy1FU2xidH8ovHMwDAcRJsu+ZmE72RO+y1lZj+d7NW5oEhGxNtHH+RmbTQK1jUzQkMt8R3Gf9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6825
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggMDkvMjNd
IGludGVsX2lvbW11X2FjY2VsOiBDaGVjayBmb3IgY29tcGF0aWJpbGl0eQ0KPndpdGggSU9NTVVG
RCBiYWNrZWQgZGV2aWNlIHdoZW4geC1mbHRzPW9uDQo+DQo+SGkgWmhlbnpob25nLA0KPk9uIDEx
LzE3LzI1IDEwOjM3IEFNLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IFdoZW4gdklPTU1VIGlz
IGNvbmZpZ3VyZWQgeC1mbHRzPW9uIGluIHNjYWxhYmxlIG1vZGUsIGZpcnN0IHN0YWdlIHBhZ2UN
Cj50YWJsZQ0KPj4gaXMgcGFzc2VkIHRvIGhvc3QgdG8gY29uc3RydWN0IG5lc3RlZCBwYWdlIHRh
YmxlIGZvciBwYXNzdGhyb3VnaCBkZXZpY2VzLg0KPj4NCj4+IFdlIG5lZWQgdG8gY2hlY2sgY29t
cGF0aWJpbGl0eSBvZiBzb21lIGNyaXRpY2FsIElPTU1VIGNhcGFiaWxpdGllcw0KPmJldHdlZW4N
Cj4+IHZJT01NVSBhbmQgaG9zdCBJT01NVSB0byBlbnN1cmUgZ3Vlc3QgZmlyc3Qgc3RhZ2UgcGFn
ZSB0YWJsZSBjb3VsZCBiZQ0KPnVzZWQgYnkNCj4+IGhvc3QuDQo+Pg0KPj4gRm9yIGluc3RhbmNl
LCB2SU9NTVUgc3VwcG9ydHMgZmlyc3Qgc3RhZ2UgMUdCIGxhcmdlIHBhZ2UgbWFwcGluZywgYnV0
DQo+aG9zdCBkb2VzDQo+PiBub3QsIHRoZW4gdGhpcyBJT01NVUZEIGJhY2tlZCBkZXZpY2Ugc2hv
dWxkIGZhaWwuDQo+Pg0KPj4gRXZlbiBvZiB0aGUgY2hlY2tzIHBhc3MsIGZvciBub3cgd2Ugd2ls
bGluZ2x5IHJlamVjdCB0aGUgYXNzb2NpYXRpb24gYmVjYXVzZQ0KPj4gYWxsIHRoZSBiaXRzIGFy
ZSBub3QgdGhlcmUgeWV0LCBpdCB3aWxsIGJlIHJlbGF4ZWQgaW4gdGhlIGVuZCBvZiB0aGlzIHNl
cmllcy4NCj4+DQo+PiBOb3RlIHZJT01NVSBoYXMgZXhwb3NlZCBJT01NVV9IV1BUX0FMTE9DX05F
U1RfUEFSRU5UIGZsYWcgdG8NCj5mb3JjZSBWRklPIGNvcmUgdG8NCj4+IGNyZWF0ZSBuZXN0aW5n
IHBhcmVudCBIV1BULCBpZiBob3N0IGRvZXNuJ3Qgc3VwcG9ydCBuZXN0ZWQgdHJhbnNsYXRpb24s
IHRoZQ0KPj4gY3JlYXRpb24gd2lsbCBmYWlsLiBTbyBubyBuZWVkIHRvIGNoZWNrIG5lc3RlZCBj
YXBhYmlsaXR5IGhlcmUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpo
ZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gIE1BSU5UQUlORVJTICAgICAgICAg
ICAgICAgICB8ICAxICsNCj4+ICBody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmggfCAyOCArKysr
KysrKysrKysrKysrKysrKysrKysrDQo+PiAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAgIHwg
IDUgKystLS0NCj4+ICBody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMgfCA0Mg0KPisrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICBody9pMzg2L0tjb25maWcgICAgICAg
ICAgICAgfCAgNSArKysrKw0KPj4gIGh3L2kzODYvbWVzb24uYnVpbGQgICAgICAgICB8ICAxICsN
Cj4+ICA2IGZpbGVzIGNoYW5nZWQsIDc5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuaA0KPj4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPj4gaW5kZXggZjRhMzBjMTI2Yi4u
YmMxZDJiNjI2MSAxMDA2NDQNCj4+IC0tLSBhL01BSU5UQUlORVJTDQo+PiArKysgYi9NQUlOVEFJ
TkVSUw0KPj4gQEAgLTM5MjksNiArMzkyOSw3IEBAIFI6IENsw6ltZW50IE1hdGhpZXUtLURyaWYN
Cj48Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+PiAgUzogU3VwcG9ydGVkDQo+
PiAgRjogaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiAgRjogaHcvaTM4Ni9pbnRlbF9pb21tdV9p
bnRlcm5hbC5oDQo+PiArRjogaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC4qDQo+PiAgRjogaW5j
bHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+ICBGOiB0ZXN0cy9mdW5jdGlvbmFsL3g4Nl82
NC90ZXN0X2ludGVsX2lvbW11LnB5DQo+PiAgRjogdGVzdHMvcXRlc3QvaW50ZWwtaW9tbXUtdGVz
dC5jDQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5oIGIvaHcvaTM4
Ni9pbnRlbF9pb21tdV9hY2NlbC5oDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXgg
MDAwMDAwMDAwMC4uYzUyNzRlMzQyYw0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvaHcvaTM4
Ni9pbnRlbF9pb21tdV9hY2NlbC5oDQo+PiBAQCAtMCwwICsxLDI4IEBADQo+PiArLyoNCj4+ICsg
KiBJbnRlbCBJT01NVSBhY2NlbGVyYXRpb24gd2l0aCBuZXN0ZWQgdHJhbnNsYXRpb24NCj4+ICsg
Kg0KPj4gKyAqIENvcHlyaWdodCAoQykgMjAyNSBJbnRlbCBDb3Jwb3JhdGlvbi4NCj4+ICsgKg0K
Pj4gKyAqIEF1dGhvcnM6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+
DQo+PiArICoNCj4+ICsgKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRl
cg0KPj4gKyAqLw0KPj4gKw0KPj4gKyNpZm5kZWYgSFdfSTM4Nl9JTlRFTF9JT01NVV9BQ0NFTF9I
DQo+PiArI2RlZmluZSBIV19JMzg2X0lOVEVMX0lPTU1VX0FDQ0VMX0gNCj4+ICsjaW5jbHVkZSBD
T05GSUdfREVWSUNFUw0KDQpIZXJlIHRvIGFkZHJlc3MgQ8OpZHJpYydzIHN1Z2dlc3Rpb24uDQoN
Cj4+ICsNCj4+ICsjaWZkZWYgQ09ORklHX1ZURF9BQ0NFTA0KPj4gK2Jvb2wgdnRkX2NoZWNrX2hp
b2RfYWNjZWwoSW50ZWxJT01NVVN0YXRlICpzLCBIb3N0SU9NTVVEZXZpY2UNCj4qaGlvZCwNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCk7DQo+PiArI2Vsc2UNCj4+
ICtzdGF0aWMgaW5saW5lIGJvb2wgdnRkX2NoZWNrX2hpb2RfYWNjZWwoSW50ZWxJT01NVVN0YXRl
ICpzLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBIb3N0SU9N
TVVEZXZpY2UNCj4qaGlvZCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgRXJyb3IgKiplcnJwKQ0KPj4gK3sNCj4+ICsgICAgZXJyb3Jfc2V0ZyhlcnJwLA0KPj4g
KyAgICAgICAgICAgICAgICJob3N0IElPTU1VIGlzIGluY29tcGF0aWJsZSB3aXRoIGd1ZXN0IGZp
cnN0IHN0YWdlDQo+dHJhbnNsYXRpb24iKTsNCj5JIHdvdWxkIHJhdGhlciBjaGFuZ2UgdGhlIGVy
cm9yIG1zZyB0bw0KPg0KPmhvc3QgSU9NTVUgY2Fubm90IGJlIGNoZWNrZWQhDQo+KyBhcHBlbmQg
YSBoaW50IHRocm91Z2ggZXJyb3JfYXBwZW5kX2hpbnQsDQo+Q09ORklHX1ZURF9BQ0NFTCBpcyBu
b3QgZW5hYmxlZCBvciBzbXRoZyBhbGlrZQ0KDQpXaWxsIGRvLg0KDQo+DQo+PiArICAgIHJldHVy
biBmYWxzZTsNCj4+ICt9DQo+PiArI2VuZGlmDQo+PiArI2VuZGlmDQo+PiBkaWZmIC0tZ2l0IGEv
aHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBpbmRleCAz
MDk1ZDc4MzIxLi5kM2M4YTc1ODc4IDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21t
dS5jDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IEBAIC0yNiw2ICsyNiw3IEBA
DQo+PiAgI2luY2x1ZGUgImh3L3N5c2J1cy5oIg0KPj4gICNpbmNsdWRlICJody9pb21tdS5oIg0K
Pj4gICNpbmNsdWRlICJpbnRlbF9pb21tdV9pbnRlcm5hbC5oIg0KPj4gKyNpbmNsdWRlICJpbnRl
bF9pb21tdV9hY2NlbC5oIg0KPj4gICNpbmNsdWRlICJody9wY2kvcGNpLmgiDQo+PiAgI2luY2x1
ZGUgImh3L3BjaS9wY2lfYnVzLmgiDQo+PiAgI2luY2x1ZGUgImh3L3FkZXYtcHJvcGVydGllcy5o
Ig0KPj4gQEAgLTQ1OTYsOSArNDU5Nyw3IEBAIHN0YXRpYyBib29sIHZ0ZF9jaGVja19oaW9kKElu
dGVsSU9NTVVTdGF0ZSAqcywNCj5Ib3N0SU9NTVVEZXZpY2UgKmhpb2QsDQo+PiAgICAgICAgICBy
ZXR1cm4gdHJ1ZTsNCj4+ICAgICAgfQ0KPj4NCj4+IC0gICAgZXJyb3Jfc2V0ZyhlcnJwLA0KPj4g
LSAgICAgICAgICAgICAgICJob3N0IGRldmljZSBpcyB1bmNvbXBhdGlibGUgd2l0aCBmaXJzdCBz
dGFnZQ0KPnRyYW5zbGF0aW9uIik7DQo+PiAtICAgIHJldHVybiBmYWxzZTsNCj4+ICsgICAgcmV0
dXJuIHZ0ZF9jaGVja19oaW9kX2FjY2VsKHMsIGhpb2QsIGVycnApOw0KPj4gIH0NCj4+DQo+PiAg
c3RhdGljIGJvb2wgdnRkX2Rldl9zZXRfaW9tbXVfZGV2aWNlKFBDSUJ1cyAqYnVzLCB2b2lkICpv
cGFxdWUsIGludA0KPmRldmZuLA0KPj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVf
YWNjZWwuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYw0KPj4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAuLjY4NDZjNmVjNGQNCj4+IC0tLSAvZGV2L251bGwN
Cj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYw0KPj4gQEAgLTAsMCArMSw0MiBA
QA0KPj4gKy8qDQo+PiArICogSW50ZWwgSU9NTVUgYWNjZWxlcmF0aW9uIHdpdGggbmVzdGVkIHRy
YW5zbGF0aW9uDQo+PiArICoNCj4+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjUgSW50ZWwgQ29ycG9y
YXRpb24uDQo+PiArICoNCj4+ICsgKiBBdXRob3JzOiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25n
LmR1YW5AaW50ZWwuY29tPg0KPj4gKyAqDQo+PiArICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjAtb3ItbGF0ZXINCj4+ICsgKi8NCj4+ICsNCj4+ICsjaW5jbHVkZSAicWVtdS9vc2Rl
cC5oIg0KPj4gKyNpbmNsdWRlICJzeXN0ZW0vaW9tbXVmZC5oIg0KPj4gKyNpbmNsdWRlICJpbnRl
bF9pb21tdV9pbnRlcm5hbC5oIg0KPj4gKyNpbmNsdWRlICJpbnRlbF9pb21tdV9hY2NlbC5oIg0K
Pj4gKw0KPj4gK2Jvb2wgdnRkX2NoZWNrX2hpb2RfYWNjZWwoSW50ZWxJT01NVVN0YXRlICpzLCBI
b3N0SU9NTVVEZXZpY2UNCj4qaGlvZCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIEVy
cm9yICoqZXJycCkNCj4+ICt7DQo+PiArICAgIHN0cnVjdCBIb3N0SU9NTVVEZXZpY2VDYXBzICpj
YXBzID0gJmhpb2QtPmNhcHM7DQo+PiArICAgIHN0cnVjdCBpb21tdV9od19pbmZvX3Z0ZCAqdnRk
ID0gJmNhcHMtPnZlbmRvcl9jYXBzLnZ0ZDsNCj4+ICsNCj4+ICsgICAgaWYgKCFvYmplY3RfZHlu
YW1pY19jYXN0KE9CSkVDVChoaW9kKSwNCj5UWVBFX0hPU1RfSU9NTVVfREVWSUNFX0lPTU1VRkQp
KSB7DQo+PiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJOZWVkIElPTU1VRkQgYmFja2VuZCB3
aGVuIHgtZmx0cz1vbiIpOw0KPj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gKyAgICB9DQo+
PiArDQo+PiArICAgIGlmIChjYXBzLT50eXBlICE9IElPTU1VX0hXX0lORk9fVFlQRV9JTlRFTF9W
VEQpIHsNCj4+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwgIkluY29tcGF0aWJsZSBob3N0IHBs
YXRmb3JtIElPTU1VIHR5cGUgJWQiLA0KPj4gKyAgICAgICAgICAgICAgICAgICBjYXBzLT50eXBl
KTsNCj4+ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICBp
ZiAocy0+ZnMxZ3AgJiYgISh2dGQtPmNhcF9yZWcgJiBWVERfQ0FQX0ZTMUdQKSkgew0KPj4gKyAg
ICAgICAgZXJyb3Jfc2V0ZyhlcnJwLA0KPj4gKyAgICAgICAgICAgICAgICAgICAiRmlyc3Qgc3Rh
Z2UgMUdCIGxhcmdlIHBhZ2UgaXMgdW5zdXBwb3J0ZWQgYnkgaG9zdA0KPklPTU1VIik7DQo+PiAr
ICAgICAgICByZXR1cm4gZmFsc2U7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgZXJyb3Jfc2V0
ZyhlcnJwLA0KPj4gKyAgICAgICAgICAgICAgICJob3N0IElPTU1VIGlzIGluY29tcGF0aWJsZSB3
aXRoIGd1ZXN0IGZpcnN0IHN0YWdlDQo+dHJhbnNsYXRpb24iKTsNCj4+ICsgICAgcmV0dXJuIGZh
bHNlOw0KPj4gK30NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L0tjb25maWcgYi9ody9pMzg2L0tj
b25maWcNCj4+IGluZGV4IDZhMGFiNTRiZWEuLjEyNDczYWNhYTcgMTAwNjQ0DQo+PiAtLS0gYS9o
dy9pMzg2L0tjb25maWcNCj4+ICsrKyBiL2h3L2kzODYvS2NvbmZpZw0KPj4gQEAgLTE1MCw4ICsx
NTAsMTMgQEAgY29uZmlnIFg4Nl9JT01NVQ0KPj4NCj4+ICBjb25maWcgVlREDQo+PiAgICAgIGJv
b2wNCj4+ICsgICAgaW1wbHkgVlREX0FDQ0VMDQo+PiAgICAgIHNlbGVjdCBYODZfSU9NTVUNCj4+
DQo+PiArY29uZmlnIFZURF9BQ0NFTA0KPj4gKyAgICBib29sDQo+PiArICAgIGRlcGVuZHMgb24g
VlREICYmIElPTU1VRkQNCj4+ICsNCj4+ICBjb25maWcgQU1EX0lPTU1VDQo+PiAgICAgIGJvb2wN
Cj4+ICAgICAgc2VsZWN0IFg4Nl9JT01NVQ0KPj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvbWVzb24u
YnVpbGQgYi9ody9pMzg2L21lc29uLmJ1aWxkDQo+PiBpbmRleCA0MzZiM2NlNTJkLi42M2FlNTdi
YWE1IDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9tZXNvbi5idWlsZA0KPj4gKysrIGIvaHcvaTM4
Ni9tZXNvbi5idWlsZA0KPj4gQEAgLTIxLDYgKzIxLDcgQEAgaTM4Nl9zcy5hZGQod2hlbjogJ0NP
TkZJR19RMzUnLCBpZl90cnVlOg0KPmZpbGVzKCdwY19xMzUuYycpKQ0KPj4gIGkzODZfc3MuYWRk
KHdoZW46ICdDT05GSUdfVk1NT1VTRScsIGlmX3RydWU6IGZpbGVzKCd2bW1vdXNlLmMnKSkNCj4+
ICBpMzg2X3NzLmFkZCh3aGVuOiAnQ09ORklHX1ZNUE9SVCcsIGlmX3RydWU6IGZpbGVzKCd2bXBv
cnQuYycpKQ0KPj4gIGkzODZfc3MuYWRkKHdoZW46ICdDT05GSUdfVlREJywgaWZfdHJ1ZTogZmls
ZXMoJ2ludGVsX2lvbW11LmMnKSkNCj4+ICtpMzg2X3NzLmFkZCh3aGVuOiAnQ09ORklHX1ZURF9B
Q0NFTCcsIGlmX3RydWU6DQo+ZmlsZXMoJ2ludGVsX2lvbW11X2FjY2VsLmMnKSkNCj4+ICBpMzg2
X3NzLmFkZCh3aGVuOiAnQ09ORklHX1NHWCcsIGlmX3RydWU6IGZpbGVzKCdzZ3gtZXBjLmMnLCdz
Z3guYycpLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWZfZmFsc2U6IGZp
bGVzKCdzZ3gtc3R1Yi5jJykpDQo+Pg0KPndydCBjb21tZW50cyBtYWRlIGJ5IEPDqWRyaWMgaW4N
Cj5odHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvSUEzUFIxMU1COTEzNkIxM0MwQzQ4RUYyOTNE
M0I1OTlEOTJGQUFADQo+SUEzUFIxMU1COTEzNi5uYW1wcmQxMS5wcm9kLm91dGxvb2suY29tLw0K
Pkkgc2VlIHlvdSBrZXB0IHRoZSBvcmlnaW5hbCBhcHByb2FjaC4gSSBoYXZlIG5vIHN0cm9uZyBv
cGluaW9uIG9uIHRoYXQuDQo+SSBsZXQgQ8OpZHJpYydzIGNvbW1lbnQgaWYgaGUgc3Ryb25nbHkg
ZGlzYWdyZWVzLg0KDQpHdWVzcyB5b3UgbWVhbiBhZGRpbmcgJyNpbmNsdWRlIENPTkZJR19ERVZJ
Q0VTJz8NCkkgYWRkZWQgaXQgaW4gaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5oLCBzZWUgYWJv
dmUuIFRoZXJlIGlzIHJlZmVyZW5jZSB0bw0KQ09ORklHX1ZURF9BQ0NFTCBpbiBpbnRlbF9pb21t
dV9hY2NlbC5oLCBJIHRob3VnaHQgaXQncyBiZXR0ZXIgdG8gYWRkIGl0DQp0aGVyZSBpbnN0ZWFk
IG9mIGludGVsX2lvbW11X2FjY2VsLmMNCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPg0KPldpdGgg
bXkgY29tbWVudCB0YWtlbiBpbnRvIGFjY291bnQgZmVlbCBmcmVlIHRvIGdyYWIgbXkNCj4NCj5S
ZXZpZXdlZC1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPg0KPlRoYW5r
cw0KPg0KPkVyaWMNCg0K

