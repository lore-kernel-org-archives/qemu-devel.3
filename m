Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95371C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 03:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seRKX-0003dw-JZ; Wed, 14 Aug 2024 23:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1seRKV-0003cp-Ss
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 23:39:15 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1seRKS-0004Rs-Ec
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 23:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723693152; x=1755229152;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Yq4G8wUHICxEMas+Kk3bYeEncQv1R7HP1K6mdQsmrmU=;
 b=UTqaXh/mtG5x4XsNuGWOEJYcLKTloveXO6xg5TC37YwBoVqGIdMR7nRK
 2LgE0zY5beWMKr5eyUQfcE8epLkcxbYACANAuzI2eRE+VrHQjnpIQYr8q
 wxIEABgHK1dDDNKoC4gkv7BgMQAkt/PM6X3hgjQO5TT/zCydPB5smt0lB
 OZo19IdZtlCxAK/uaCW0AspYpSN3G8Mdq7b/tvU9b/pS6fQzY2FQ4JMwi
 ZZAXJaMTJq8T0tC2YPmowDfhRZTPXiHkLqnxwRqyOrN/p6GZ8u0TlYhHs
 r7J/wGDfBQseEXRTCzPz6gx8n4lqVZVUjtTPU8MfofLtCBTMzcM7cZzPx w==;
X-CSE-ConnectionGUID: 6araYopYRdu0bv5E2Up2fg==
X-CSE-MsgGUID: OB4hE+QKQwydflSZs73wkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="22089909"
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; d="scan'208";a="22089909"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2024 20:39:07 -0700
X-CSE-ConnectionGUID: hX6DYQs7T7+GU5q+vkC8lA==
X-CSE-MsgGUID: zywXtKONQJePZRarZtg99Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; d="scan'208";a="64096876"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 Aug 2024 20:39:07 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 20:39:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 20:39:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 Aug 2024 20:39:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 Aug 2024 20:39:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NsQFc2b+MP7BFI1DCPGCaTTvK+tnIWUi99BALe3UYcGwySFRuRWllL917oJuqvn4UdKYX2TJ0Qgj9RciD/Ih7Hwz4X+pIaMSvCT33/wDXHDf5eIYY4YgzLFPS7UbQb7UhMUF37o2l6nhA1YGUs7BOPir7dxMIaRYXvlVRolNyr7Kf73BZcTC6JSnNcyKl50kj8M7tN723sH1wtk4WAKrHUOaF0LcmGXmtoUN2kRSHnNCJ7aotxcCq6YnQKlwsS84PHQxGxNZ1NNL7QY59MfLuOJ6OUkCWFkh+ShBos9ywqkT8WJjApirS0kUh++JVD3zCrdQs14M1wHiauFhXuWx6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yq4G8wUHICxEMas+Kk3bYeEncQv1R7HP1K6mdQsmrmU=;
 b=MXSyhbF03rO3zrqJv9+POumrpFbJ3r93Z76clS52kXMhP0m7gWxdfC/e+JuyhbSk5XWXfHqhJeIZc1kJ/s/TrXtrPimp5MCnRze8OqxacOjoXrbuPqrCPoKJBntihZ9JMusBAw6rAS4Nj/k5eEapo8iN7IYP7XDWnLxHSbxEF6rWMvfWSN268gLFT32vryFeDsY/2a9y1/UFMI/yC+WJhkzmxUqZ67oTiwp1bK6yPKRgy98mdPk9wRTsvRSPlRE6HN/+dXGs7pS/8O9eUQnqd+/toKh7e45ZvoW1jM0izku7fvlCQNaO2U6RCFKKGkM9syAOgVnPdBz1ZiQdXDhDLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA1PR11MB6075.namprd11.prod.outlook.com (2603:10b6:208:3d5::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Thu, 15 Aug
 2024 03:39:03 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.7828.031; Thu, 15 Aug 2024
 03:39:03 +0000
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
 "Peng, Chao P" <chao.p.peng@intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: RE: [PATCH v2 14/17] intel_iommu: Set default aw_bits to 48 in
 scalable modren mode
Thread-Topic: [PATCH v2 14/17] intel_iommu: Set default aw_bits to 48 in
 scalable modren mode
Thread-Index: AQHa5wEUCgc5KYQR/0Gor+FP/qadcrImvE2AgAD+3FA=
Date: Thu, 15 Aug 2024 03:39:03 +0000
Message-ID: <SJ0PR11MB67442412EC7552C7BCFA626B92802@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-15-zhenzhong.duan@intel.com>
 <745d9b3a-388f-4dfb-9062-4591ffd457c3@intel.com>
In-Reply-To: <745d9b3a-388f-4dfb-9062-4591ffd457c3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA1PR11MB6075:EE_
x-ms-office365-filtering-correlation-id: 451e0aa2-fd10-426d-dd9f-08dcbcdbcf21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZTdFcHBocjN3SnhjNnhOdzNCMEdEQVpldzFHT2tmbXNVd2xMTDFXcnNua3pX?=
 =?utf-8?B?bEFjYU5qK2IwbmZjOVZmdWxzOEJRYWg0ZFdhcFFtK1VmcEh5U1hpVzE2S3Ir?=
 =?utf-8?B?R0JtWnhIc0VVcElVTmhGUkg5N1VFVDd3S1FqRDltcklnb1lBOUlGLzBydTZE?=
 =?utf-8?B?eHhIc1BLWHduVUo1blVhZ0ZvSmg5Z3JJWTZ0WmREbDF0dnFKK0hiVG1LMTda?=
 =?utf-8?B?MUI3eURqQi82NGdhQVUrb2p4LzAzM0RIbkdYQ3ZBNWZVZDh2Q3F6WjhpcXNH?=
 =?utf-8?B?QUhBSzdXdEF4UEkzYldwYTFrM0RkaXNvOW1DME9taTRQR0IwY2s5ZDFVTUI2?=
 =?utf-8?B?YjJYQmNwdGJ6Zk9UYUtyTVFDcEtYakxrUWQxci83cHMvTTlDTCszS3BRc2FO?=
 =?utf-8?B?amJXM2FnQ0lxZ052bGxOSVBJYzB5TVdMY2FMRkRJa0hIbEtCN0tscUdwUW4r?=
 =?utf-8?B?aGg4Lzd6UVVNVkxQc08ra0tRU0Nqa0hIODR5V3dSYU1IcHB5OEQ2d1dpU2s2?=
 =?utf-8?B?RW1wWDhwSVJHZERCYXVBM0dVdEFXVHMrY3ppTFluR05XVFQrZ3FGdnhDSmZ2?=
 =?utf-8?B?SWFhS0hlVTRFamxHSmdVVllWOVRHUk5rdHlFeHM2ZGZQdHFHR1l2Tmx0Q1Ni?=
 =?utf-8?B?MEZvYjFtRndGbEsrSGhoOHk2WEd1WGV2QlJjbUlwUUd5bkpEdEcwSWNuZzJk?=
 =?utf-8?B?V2ZjU0xZdmVIRDlkSlFqUDZTWlVxNzVtZkZiQ0NhSnZ6UU55bzZqTVRnY2VI?=
 =?utf-8?B?TU0rNktkUjYvYjlESjBXZ25qVGdYc3llZldFUitOR1lHeEZwcy9OaWU3Nk9M?=
 =?utf-8?B?ZUg2S2FmNXZmd2liZGpQaGZTd1VZdEZwd2xYTm9HcVdMdVg0aS83QUF3d29s?=
 =?utf-8?B?bzB6WkhPSmc0WE44NStQa3NLSStWQ1VYV216OFkrdGdYUmtrUUc0ajlVTGpI?=
 =?utf-8?B?cnZNVE15YlUwTkx3NlJuQTZobVR4V01ZUnBjYjFGZ1hBZk9UVEg4VzdnRDYr?=
 =?utf-8?B?bjNYRk5XbzV3bHVLa1pZYjRiamxXNm1PM0dJbzdYT3dQYTY0SW5FZXRPOVpO?=
 =?utf-8?B?U09CbHA0OVNld1FqeWxBTm9JSmkveUVsUTB5VUN4Q2g0YXBNWHpkL0creUdz?=
 =?utf-8?B?ZUV0NEhUQjBMb3dwNmtEY1Y4dExTZHVGUGhkSUVpTmluMjU1dTlta242djli?=
 =?utf-8?B?WnhWM0hNYWlpMkhkM1F6bFE1dndoNmhOY0IzVW83eDVxdmpLdkxyTGNoRTNl?=
 =?utf-8?B?SG54VlJ1cGFTTXduNUl6dmhmZ1p6ZDlSWTZXQkgzZlIrSEQ3cXJmdHUyaWtk?=
 =?utf-8?B?cE9XSER4eEJPaWhXVFNzdEZQMkdZVjQrNXArMkF2eEVSTVdvZHFDVW9vM2dG?=
 =?utf-8?B?YmhDOUplcUZMV3pvZ0grOUxTRk1NTkpZb042SEI2T0F1UWRPb1psUldGOHlT?=
 =?utf-8?B?MlF2WkxJOStTK0lwSTY2cWE4ZU5tNmo5d0piS051dEFmN2VLQkRTZXZJbVVr?=
 =?utf-8?B?N1h3alpTem0xbVc1NVp4a0t3eEJHMERYU29kSi8yTE4ySTVGR2dpQ1JMTUxw?=
 =?utf-8?B?cEhsenI0bUZjWFplcHI4RjZsckJXMnJpL0tROFFUcDR3WGVUWDBsclZXTHdY?=
 =?utf-8?B?YTdGZ3o5ZXdyU1AwMmM0ZGpPUEVLb2M0V2N4NzR1YmdkdTF0cWxDSllxQVUv?=
 =?utf-8?B?TFpPcVY0NDJZSmJ3dndFbzRFNDNieDB4dVI1WUdTdmJaQytRa1dldnpKc1ZG?=
 =?utf-8?B?MzNNODZnRmRZUEtYZy9Ub2FUNVhMNkszRDFnTmxUQ0NSQUVYTzROSklJQUgr?=
 =?utf-8?B?cWcyVmIzRXIxL2VTWEU3aVdvQ0orTXNlakpHcHhjWSt2aTBvemVFeW8yc0RG?=
 =?utf-8?B?TEJLYWxTMnJBb1lXRXU3Sy9mdmNvdlJoMlVPZy9tUFhvbEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkdwOVRFUE5XYnBkY2VLWWxtWmlRd1BlQnpEaXdPZEpVYXYySnZlNnNsWmpL?=
 =?utf-8?B?TGR6SWFlZ29mQlI0V1VCYXNqSW96RHcrYmVVbjdaYjVxeEpLb1JudjV5NW9x?=
 =?utf-8?B?RUduUUtnUTN5cEI0a3ZML0ltMzhrS3RpR0hRYzFOV3oyYk16Qk9UTGpkZkVt?=
 =?utf-8?B?SUpaMU5vNkVrWEhIWnUzWEtpS1JqWnJrYVlyM1pwUWVja2NvR3AwUHNlZWhj?=
 =?utf-8?B?Rk14dE9kaXNUNlFQaVFNbGRkS21aUVdKbkdWQ1VZUWF3QytVbG81RFprM2s5?=
 =?utf-8?B?Ni9aNlUrNE5tSHpnTzRzOVVjajBjR3hsWS9PMk5lOGtTTmFsRVFQb1A0dG9S?=
 =?utf-8?B?Vm9zL3BnWXMxN0dRU0JaVXBZOU0zdTBUMFNBeVY5MldHWGxFdTRuYWhjL2M3?=
 =?utf-8?B?YVI1NXN3bVRrYnFxVmdRbXNwUTA1dGZjTGQrWjZnY0wrNW9SMWZPMG4yL0Nr?=
 =?utf-8?B?RHQrdEZqOGN3dk4xMEZtdlRWWThwTlB0eTFHekRkQytIRkg4WURuazN6cDBk?=
 =?utf-8?B?QmZnN1g3emNTNVpQQVZyTmU2K2Jib2VLcU9lUjh1eFhQdE1lcXVOenFBNmlN?=
 =?utf-8?B?dEl4eU5WNHN3UlJCQWNFZU9aZW16b3UyeVNrYkQwbnAyU0tJYTZYNDltdHBU?=
 =?utf-8?B?QkQ1dXRiM2pETDA0RzFvckM1Qy8rZXY0eCtmcG9walZ4SUZwVkY4YldUK0Rn?=
 =?utf-8?B?MnRDSS9VYXRtSURWYm0vaHo1THhteGZtOW9Va0txT3RUbWpRd2lBRFpEYjNB?=
 =?utf-8?B?NitmbnE4eFFTcDN4NXh2ck1xS0tBQ3JqbFdsMlU3QnU2UUh3UTFYZGhRN0E3?=
 =?utf-8?B?VzczbVErWHBTcDNXN2ZFT1UvRXJRaFZ3STgwZjdWNzBqWi9TMkJKTm5qTDd1?=
 =?utf-8?B?VDQydnhlbGNLWkloR0w2cnhoS1N5aDUxWnVTVFNjSVAzZXMxYmo4SkxyMm4w?=
 =?utf-8?B?TE1XbWU0ZVhvam45dFdsWTQ0QlVYdHdWWXhDa3MzbFhMOWdIald1eGh0bXln?=
 =?utf-8?B?SVBVT29PaGhxaVl3VHJ3M2VkWTcxQzZmaHRaNkpKdHZhZEV4bVYxNExpUUgv?=
 =?utf-8?B?d1Ayb3BUendvUTlaWHJFVXl4WjU5WERMVkNtREQ4VytLVDJva0tybFUranZl?=
 =?utf-8?B?ZVhOUE5UZ1NGQU1tQXVkN01oMHlaUWdJcEZTRnU2QklpOC9YTkpkZEpnd1Fo?=
 =?utf-8?B?MkM4YmtlNCtET1QzTHNaTU16L2t2SDZ2WEE3dFllbjhPOTF4Q3hqejM4QmxV?=
 =?utf-8?B?d0UvZ3N3WitPTHhjZkpmWW5tRlNHekFIQ1VidnVQL3BSL3VuK1RpdlQ5SVRF?=
 =?utf-8?B?WFZrMW5jVnZuVzBEZjkwT25tLzdLTmVyd0pXRzUxWE9GL0FJakEwRkgyWmcv?=
 =?utf-8?B?NE9VYjB3T2JpaDN1bDBQUFVLVWZGeXJPY2NtUTRpdk5qNzVFd0xsOUNpazBq?=
 =?utf-8?B?Yk9GcTczUTdVeEQwV0F1Q3Nwc0RDdnpVZ2kwb3RkRlNUL2VQZ0hqV3hxOURu?=
 =?utf-8?B?NnYya2tYcEpVQjBVNERYbVRuQUhOZjhGV016TkRUaXNKVFJBWERWMm9nUEhE?=
 =?utf-8?B?VmdZMXR3ZjF0MkYrTk5ZVHdHc3VUOFovZzdPeFFBWXJPL2JPV1lnQVVneUlz?=
 =?utf-8?B?b1hzQWIwM3NvTXpzWDk3b0V6U0VERFhwd2hRR2pyZFoxWnQwcW9kS2ZpMHFr?=
 =?utf-8?B?WlRlU3k2cFF4VTlZaXFNOUE1bWNhM1JubjFGc2ZoWmRYZVFkOFV3eWlUa0wz?=
 =?utf-8?B?TzBlcVNmK2d5YzhPOU9XZHZnM2NHcm1mQ0swY2hBcTZKT293NmhLOWR0MFlK?=
 =?utf-8?B?RG5jN25YS3BGRURRdC9SWC84dlA2MTNPZmxZUXdpYzhzblA3YW95dldobVNH?=
 =?utf-8?B?cjBRSkcxeStSUXc0VG0wWlJZUU9SM0syTzBVUWM5UzMxMGZrVmxDd2p0MmlE?=
 =?utf-8?B?cmd1dWN2V1BEQXE4Zno2c3JacnRmYmRFZlI3b3lQb21qS1FEMFhYYVRYdVRW?=
 =?utf-8?B?cndjVmp1N2ZoMUZDM2huSktjR0o2bTcrWUZyWGNLWGtBdmVUZjBSTUU3UnJa?=
 =?utf-8?B?aUQ5dmhMV29BQUVrazA4VGtUWExKbm1lTFB4Q2E2ZGFxUHBFUlZRVGRqZmkr?=
 =?utf-8?Q?CxAevh2bhR9y8M/dxKcypOCwM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 451e0aa2-fd10-426d-dd9f-08dcbcdbcf21
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 03:39:03.8583 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jrbpE2u6++UELk0eZsJAUL95SAkmD311nHWpowzRhGLXD/kxjrboAHlfQXjzBbf2zrIGt70kKVuio3Te1b1Qv/6vuuJfnuEIGT4OTamHQ/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6075
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.135,
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
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMTQvMTddIGludGVsX2lvbW11
OiBTZXQgZGVmYXVsdCBhd19iaXRzIHRvIDQ4IGluDQo+c2NhbGFibGUgbW9kcmVuIG1vZGUNCj4N
Cj5PbiAyMDI0LzgvNSAxNDoyNywgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBBY2NvcmRpbmcg
dG8gVlREIHNwZWMsIHN0YWdlLTEgcGFnZSB0YWJsZSBjb3VsZCBzdXBwb3J0IDQtbGV2ZWwgYW5k
DQo+PiA1LWxldmVsIHBhZ2luZy4NCj4+DQo+PiBIb3dldmVyLCA1LWxldmVsIHBhZ2luZyB0cmFu
c2xhdGlvbiBlbXVsYXRpb24gaXMgdW5zdXBwb3J0ZWQgeWV0Lg0KPj4gVGhhdCBtZWFucyB0aGUg
b25seSBzdXBwb3J0ZWQgdmFsdWUgZm9yIGF3X2JpdHMgaXMgNDguDQo+Pg0KPj4gU28gZGVmYXVs
dCBhd19iaXRzIHRvIDQ4IGluIHNjYWxhYmxlIG1vZGVybiBtb2RlLiBJbiBvdGhlciBjYXNlcywN
Cj4+IGl0IGlzIHN0aWxsIGRlZmF1bHQgdG8gMzkgZm9yIGNvbXBhdGliaWxpdHkuDQo+Pg0KPj4g
QWRkIGEgY2hlY2sgdG8gZW5zdXJlIHVzZXIgc3BlY2lmaWVkIHZhbHVlIGlzIDQ4IGluIG1vZGVy
biBtb2RlDQo+PiBmb3Igbm93Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFu
IDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiBSZXZpZXdlZC1ieTogQ2zDqW1lbnQgTWF0
aGlldS0tRHJpZjxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4+IC0tLQ0KPj4g
ICBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCB8ICAyICstDQo+PiAgIGh3L2kzODYvaW50
ZWxfaW9tbXUuYyAgICAgICAgIHwgMTYgKysrKysrKysrKysrKysrLQ0KPj4gICAyIGZpbGVzIGNo
YW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+Yi9pbmNsdWRlL2h3L2kzODYvaW50
ZWxfaW9tbXUuaA0KPj4gaW5kZXggYjg0M2QwNjljYy4uNDgxMzRiZGExMSAxMDA2NDQNCj4+IC0t
LSBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+PiArKysgYi9pbmNsdWRlL2h3L2kz
ODYvaW50ZWxfaW9tbXUuaA0KPj4gQEAgLTQ1LDcgKzQ1LDcgQEAgT0JKRUNUX0RFQ0xBUkVfU0lN
UExFX1RZUEUoSW50ZWxJT01NVVN0YXRlLA0KPklOVEVMX0lPTU1VX0RFVklDRSkNCj4+ICAgI2Rl
ZmluZSBETUFSX1JFR19TSVpFICAgICAgICAgICAgICAgMHgyMzANCj4+ICAgI2RlZmluZSBWVERf
SE9TVF9BV18zOUJJVCAgICAgICAgICAgMzkNCj4+ICAgI2RlZmluZSBWVERfSE9TVF9BV180OEJJ
VCAgICAgICAgICAgNDgNCj4+IC0jZGVmaW5lIFZURF9IT1NUX0FERFJFU1NfV0lEVEggICAgICBW
VERfSE9TVF9BV18zOUJJVA0KPj4gKyNkZWZpbmUgVlREX0hPU1RfQVdfQVVUTyAgICAgICAgICAg
IDB4ZmYNCj4+ICAgI2RlZmluZSBWVERfSEFXX01BU0soYXcpICAgICAgICAgICAgKCgxVUxMIDw8
IChhdykpIC0gMSkNCj4+DQo+PiAgICNkZWZpbmUgRE1BUl9SRVBPUlRfRl9JTlRSICAgICAgICAg
ICgxKQ0KPj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50
ZWxfaW9tbXUuYw0KPj4gaW5kZXggMzE3ZTYzMGUwOC4uNTQ2OWFiNGY5YiAxMDA2NDQNCj4+IC0t
LSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
DQo+PiBAQCAtMzc3MCw3ICszNzcwLDcgQEAgc3RhdGljIFByb3BlcnR5IHZ0ZF9wcm9wZXJ0aWVz
W10gPSB7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPTl9PRkZfQVVUT19BVVRP
KSwNCj4+ICAgICAgIERFRklORV9QUk9QX0JPT0woIngtYnVnZ3ktZWltIiwgSW50ZWxJT01NVVN0
YXRlLCBidWdneV9laW0sDQo+ZmFsc2UpLA0KPj4gICAgICAgREVGSU5FX1BST1BfVUlOVDgoImF3
LWJpdHMiLCBJbnRlbElPTU1VU3RhdGUsIGF3X2JpdHMsDQo+PiAtICAgICAgICAgICAgICAgICAg
ICAgIFZURF9IT1NUX0FERFJFU1NfV0lEVEgpLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICBW
VERfSE9TVF9BV19BVVRPKSwNCj4+ICAgICAgIERFRklORV9QUk9QX0JPT0woImNhY2hpbmctbW9k
ZSIsIEludGVsSU9NTVVTdGF0ZSwgY2FjaGluZ19tb2RlLA0KPkZBTFNFKSwNCj4+ICAgICAgIERF
RklORV9QUk9QX0JPT0woIngtc2NhbGFibGUtbW9kZSIsIEludGVsSU9NTVVTdGF0ZSwNCj5zY2Fs
YWJsZV9tb2RlLCBGQUxTRSksDQo+PiAgICAgICBERUZJTkVfUFJPUF9CT09MKCJzbm9vcC1jb250
cm9sIiwgSW50ZWxJT01NVVN0YXRlLA0KPnNub29wX2NvbnRyb2wsIGZhbHNlKSwNCj4+IEBAIC00
Njg1LDYgKzQ2ODUsMTQgQEAgc3RhdGljIGJvb2wNCj52dGRfZGVjaWRlX2NvbmZpZyhJbnRlbElP
TU1VU3RhdGUgKnMsIEVycm9yICoqZXJycCkNCj4+ICAgICAgICAgICB9DQo+PiAgICAgICB9DQo+
Pg0KPj4gKyAgICBpZiAocy0+YXdfYml0cyA9PSBWVERfSE9TVF9BV19BVVRPKSB7DQo+PiArICAg
ICAgICBpZiAocy0+c2NhbGFibGVfbW9kZXJuKSB7DQo+PiArICAgICAgICAgICAgcy0+YXdfYml0
cyA9IFZURF9IT1NUX0FXXzQ4QklUOw0KPj4gKyAgICAgICAgfSBlbHNlIHsNCj4+ICsgICAgICAg
ICAgICBzLT5hd19iaXRzID0gVlREX0hPU1RfQVdfMzlCSVQ7DQo+PiArICAgICAgICB9DQo+PiAr
ICAgIH0NCj4+ICsNCj4+ICAgICAgIGlmICgocy0+YXdfYml0cyAhPSBWVERfSE9TVF9BV18zOUJJ
VCkgJiYNCj4+ICAgICAgICAgICAocy0+YXdfYml0cyAhPSBWVERfSE9TVF9BV180OEJJVCkgJiYN
Cj4+ICAgICAgICAgICAhcy0+c2NhbGFibGVfbW9kZXJuKSB7DQo+PiBAQCAtNDY5Myw2ICs0NzAx
LDEyIEBAIHN0YXRpYyBib29sDQo+dnRkX2RlY2lkZV9jb25maWcoSW50ZWxJT01NVVN0YXRlICpz
LCBFcnJvciAqKmVycnApDQo+PiAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gICAgICAgfQ0K
Pj4NCj4+ICsgICAgaWYgKChzLT5hd19iaXRzICE9IFZURF9IT1NUX0FXXzQ4QklUKSAmJiBzLT5z
Y2FsYWJsZV9tb2Rlcm4pIHsNCj4+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwgIlN1cHBvcnRl
ZCB2YWx1ZXMgZm9yIGF3LWJpdHMgYXJlOiAlZCIsDQo+PiArICAgICAgICAgICAgICAgICAgIFZU
RF9IT1NUX0FXXzQ4QklUKTsNCj4NCj5jYWxsIG91dCBpdCBpcyBmb3Igc2NhbGFibGUgbW9kZXJu
LjopDQoNClN1cmUsIHdpbGwgYmU6DQoNCiAgICBpZiAoKHMtPmF3X2JpdHMgIT0gVlREX0hPU1Rf
QVdfMzlCSVQpICYmDQogICAgICAgIChzLT5hd19iaXRzICE9IFZURF9IT1NUX0FXXzQ4QklUKSAm
Jg0KICAgICAgICAhcy0+c2NhbGFibGVfbW9kZXJuKSB7DQogICAgICAgIGVycm9yX3NldGcoZXJy
cCwgIiVzIG1vZGU6IHN1cHBvcnRlZCB2YWx1ZXMgZm9yIGF3LWJpdHMgYXJlOiAlZCwgJWQiLA0K
ICAgICAgICAgICAgICAgICAgIHMtPnNjYWxhYmxlX21vZGUgPyAiU2NhbGFibGUgbGVnYWN5IiA6
ICJMZWdhY3kiLA0KICAgICAgICAgICAgICAgICAgIFZURF9IT1NUX0FXXzM5QklULCBWVERfSE9T
VF9BV180OEJJVCk7DQogICAgICAgIHJldHVybiBmYWxzZTsNCiAgICB9DQoNCiAgICBpZiAoKHMt
PmF3X2JpdHMgIT0gVlREX0hPU1RfQVdfNDhCSVQpICYmIHMtPnNjYWxhYmxlX21vZGVybikgew0K
ICAgICAgICBlcnJvcl9zZXRnKGVycnAsDQogICAgICAgICAgICAgICAgICAgIlNjYWxhYmxlIG1v
ZGVybiBtb2RlOiBzdXBwb3J0ZWQgdmFsdWVzIGZvciBhdy1iaXRzIGlzOiAlZCIsDQogICAgICAg
ICAgICAgICAgICAgVlREX0hPU1RfQVdfNDhCSVQpOw0KICAgICAgICByZXR1cm4gZmFsc2U7DQog
ICAgfQ0KDQpUaGFua3MNClpoZW56aG9uZw0K

