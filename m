Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58451E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOC7n-0005j4-5v; Thu, 19 Dec 2024 03:43:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1tOC7l-0005ii-PZ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:43:13 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1tOC7j-0007cr-A7
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734597791; x=1766133791;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yjH2W5GgFrRfKBsN5JdEMHr+RCacAXLhKz7BrFguEWc=;
 b=iiUj5DCQelZoNULgoO3wR0cR1oAzYkojVyDaJ93Wj0YnLNF5YZFMv+ob
 kxozj/oRyTa6ffHbDaCHQ27s+dfosHbFOpJqoevWBvHht5Cqtrv/wDsrQ
 aX9s75qZL+ASUuidzuBrJydJBY5ExORPa3TA1NdSiqns3XHD5PH5TShiG
 MXAs63WAx756HHf/+myup6ZWR1cd1tUo2hteeDWPZ21erzIjyOvGq9G8p
 nDrNB8ZiaEJgu1K2NDfWXotNzkjafoMux8VhfSU8cAqaZ84b5r7smfUCJ
 Oh1lrGp/I7FQosP8Go2OVONqhdse9ua9fYk99rhEtfRWqTzmuk4EWa9CA g==;
X-CSE-ConnectionGUID: 3mAMbzCVTyGSRyDQVGSGpQ==
X-CSE-MsgGUID: Ot8GhMW+QMmMUxZzXjmBgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="35227546"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="35227546"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2024 00:43:07 -0800
X-CSE-ConnectionGUID: 8STfssezQiKP9zcUXalVAQ==
X-CSE-MsgGUID: JrsB9eKuTEGQYBIU7EXm5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="98353785"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 19 Dec 2024 00:43:07 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 19 Dec 2024 00:43:06 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 19 Dec 2024 00:43:06 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 19 Dec 2024 00:43:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrPV2u3HMokIYAoULvXPi0FpXHefFbB/uRxCapD1b+XKC3hJKalo+fATnFoZkqA9puxjdmMAD4IK/FMHogpdg9Kc6JJ9JUgTmKbZs6a3iAG1V022oJBh3uOF+jzsh/XWDahaV9VqsVKclWKHQRe5G0CFNpsnispXeuL4EzUxzAys+RbvlF2JiDGCMXkGA9Q+CoagJeDuCMlCHNZvTQQbnJ8xoheHO8fYGIA1jqYWS1YlftNhQBFoWnYCIPrvyAWVoTc79QzVK14zKLMfQl+J+CPXGm2NdZVOBoosKTeGXT9iY+aePl+OmOjODixyxsKFo5OW6qKcBsAJqnJo483bsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjH2W5GgFrRfKBsN5JdEMHr+RCacAXLhKz7BrFguEWc=;
 b=QSLb1RAPwwt878FQ/nHrTfatwOIyQc23OvTP9HRKE9NpyPua0JVeD9uoSmn55pTRXv6GcrFU0mHlrL4qFLJfzJX0lVf4idw6bu0GHeH3H2FZwy9Rc6TF6Km0hXdTqD42Eu1MH+W/NhlljI+0Tgz8DjIRE75xZGkorTkJ8whdszEmwMSUSMmpPa0IX/ppt9HXi58ZV2R+0DdQLNGbbbXj9Zu6IkxG/CxX4Pj42fB2gysnMx3gH8RA6WU6p5BHdWrj3VBOU42kOS41W9bpkgg0XdyIdDshVm/5PkU1Fk/2nPVKjde8gePhujbCh+mkEN+rq6/Q3wcOKAPmhbEL5YJ+FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by SA1PR11MB8812.namprd11.prod.outlook.com (2603:10b6:806:469::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.12; Thu, 19 Dec
 2024 08:42:49 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%5]) with mapi id 15.20.8251.015; Thu, 19 Dec 2024
 08:42:49 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "farosas@suse.de" <farosas@suse.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Zeng, Jason" <jason.zeng@intel.com>, "Wang, Yichen"
 <yichen.wang@bytedance.com>
Subject: RE: [PATCH 1/3] multifd: bugfix for migration using compression
 methods
Thread-Topic: [PATCH 1/3] multifd: bugfix for migration using compression
 methods
Thread-Index: AQHbUS1FSiRO+qmGxUKg4dxF+hxQybLsOxgAgAEC4lA=
Date: Thu, 19 Dec 2024 08:42:49 +0000
Message-ID: <PH7PR11MB5941DCA77CE6C661F9D00986A3062@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20241218091413.140396-1-yuan1.liu@intel.com>
 <20241218091413.140396-2-yuan1.liu@intel.com> <Z2MAUj-ComKI2HUE@x1n>
In-Reply-To: <Z2MAUj-ComKI2HUE@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|SA1PR11MB8812:EE_
x-ms-office365-filtering-correlation-id: 6453122d-b2f6-42f8-79ea-08dd20091e5e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NjllY2xRMDJLVWRhdXhKenVvOXNNbVUwbHNzSS9CQUdoT1VleDFPeWhWSlFT?=
 =?utf-8?B?UW1la243cnlPQTNvZTBEMTAzVnFBNDcwMkMybHNnN2QzdjhnTjZSQm1KTjJC?=
 =?utf-8?B?RUdoQytqTGNuV3ZPZHBQOWZXREwyNnRyMjZGQ2o4S2RiTGFJcWRGYWxMSlNN?=
 =?utf-8?B?RlhCaUZGaklQM0tmZStQREFRQVdwR1ZxLzRDWnVWZUw5N2hKNG1GbW9wN2E5?=
 =?utf-8?B?WjdpcXgyS0lub2puNFZGeWFBeW51aCtJUWJRTysrYlVDelhSYVlvMTc0K05F?=
 =?utf-8?B?YU91ZHBjUFVYYnJaQlZDY2hEL1Ntak53R0pKbG1vb3Y0TWlhdFNwZWYwTzND?=
 =?utf-8?B?d0hQYm1tenI5bi8rQnJSN2lmbEg3RzhmMHI2dzF1bjUzcGpsWWgzV0Fpb3pE?=
 =?utf-8?B?OGJ4Q1U0dGt2SlN6Mmg2dUJWd2Q4eHpMVG1mZE9hQXp2SXFmejl4NFlJWDRH?=
 =?utf-8?B?M0JPZWdMSkpnUnlMbGwzQ1lnQURHR21xOWtGQXJmK0t6bWtGR1dIMk5FUFNX?=
 =?utf-8?B?NEpjUk1Ud2VLTTdzcit1dWx3eitFbFprUmEzVUFWQVZGbVBrUDRrb0FsNUhi?=
 =?utf-8?B?RkpHdm14NG9wRU9kUjVuZ3BXd3VUc3E2M2RneHBvZVlZSHByZWNOdW5CQmx4?=
 =?utf-8?B?UVpUUk5ZcVUwdnpiS0NCakg0bTg3YkxiUVcvSkt3azBUZ2E0bzRPVXlVb05F?=
 =?utf-8?B?K1hncGErTlFrZmZ1ZmR6YXI3NmlnckM2REZrN1cwRW9mWHFaMmk4ZUZiMEl5?=
 =?utf-8?B?R09WdzVkUVRJUGxackpHSkVYZ00yYXExZzQ3YzVQLzVKeHlBK05saFJuZnBs?=
 =?utf-8?B?aVQ3Z2FQLzV6WjhkcnRUUHJHR1JtNDdoMkY0Q01GWkVUeE5CQXZGSTE2TGtY?=
 =?utf-8?B?Y1hkZEdtNHNvSnpiY3l1TDZmR0xZMTN4RnArbGxxa0hnWWhQejhJSUVZMmlD?=
 =?utf-8?B?MjJRcmU2c0JIYk05QUlxWnA2K2w2NlVNQ2lJQ3h3K3l1V0p2REhGZSs1RkF0?=
 =?utf-8?B?TklVMHk5OEZWS2tnbC8xbFhnaWlZVU0zRUlLaC92SmpERTMvV0tUQWFYa0lF?=
 =?utf-8?B?T3hhRXVKd3lMQ25EdjhTYklRQUU1S2dJd0VVaHowVUE5SUdlTW5IaUllMWYv?=
 =?utf-8?B?ckgwV21NVy9vazJqOUcwdjA4RlZBbGFkWTFJN2pYTXR3MXNBQ1RqUWMvSUJo?=
 =?utf-8?B?MktGWUtmaHpkamx2NlhLak5OME94amc2RENCeVVXSHZqOTBKSExHRytRby9E?=
 =?utf-8?B?VnFXVjl3Zk9qTzNITnRlc1pEQXcxbmw5L3ZJV1JLMG9pU0YxbDAwdnpKNVZK?=
 =?utf-8?B?dlVYU0xaeHpMU3FCN0tMWW5oNENEbzc2RXUwenk4RnkyTmE0L0FqOFN6cWFn?=
 =?utf-8?B?OU1EZUdLeUk1UUdtcWE2QkF0Q05xMzROUDFSdUFUYUc5R1hIWUlkcFRTa1BD?=
 =?utf-8?B?bFhkTTdDeGZRVVl6dmJnZ2xoczd3bmI5ejJHL2VNVzdwNW1mVVp1QkFBZDFm?=
 =?utf-8?B?QkthTjVjM09udElwRHliTW0xaE84MXZoVmdPakE5U1RmclFZTER5bFJHRTRI?=
 =?utf-8?B?MWVrTFY4TkpCRHcwUG9OOXRYdXc2WEc2UER6YSs4TGpwYTdlbWdHeGxrVzhK?=
 =?utf-8?B?QmZ5V0V5OVBZNWNWVDRSUEFQQVJhOFdIaXdPN3l4eDloNTJSTHJ4a3R4MEN6?=
 =?utf-8?B?MWl0L21aR0ppMVorRnJZaFo0dHNaOC9ESlcwSURVTWdKQTVySlJsQVhpb0d2?=
 =?utf-8?B?M3lBSWo3OXkxR1J1TGNZemV6RjA5WUtiWVI2cnd0TXEwMDhPVkRoZkJtNXlm?=
 =?utf-8?B?Q25CNDdtTUkwVnR1VnB1S0VNM3hLakFPeVZ4dlovbmZGOFpKdVdwOUZNR3M3?=
 =?utf-8?Q?SMH+0EX3vxNUr?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bG9WT3VhWHVsNno2V0NyVDliZW9EWmMwcjNSZUNOdDFVRzJSUWFYdWdkMDFT?=
 =?utf-8?B?c1lsS0IraWRhLzRzeUJ6cXhZRk41ak9nQ0V1VHZqbW82dnBwbVNiRjNqamsx?=
 =?utf-8?B?SWhoN1MrTkUwV0lHM3dCcnVmbWJabERiV0lTZklkK1FJYzZBNjNzV0EzNzdk?=
 =?utf-8?B?QVFTdDRadkVSZER5TUZtcUxlNWFRZWdteUtGSmhGcEkrOXpYOVlhSFBSb0N5?=
 =?utf-8?B?NkZJRGE1dmdJUHZGR1BhU1V1K3NsSDhnQmtEajZaZzZMR2JJSWMvdTJKRUJU?=
 =?utf-8?B?MzZXYWdKQW5sMVdrRFNGcitRc2xOSk1ySjFwS01PVXhpNlRNdHhoMFVna1Jn?=
 =?utf-8?B?Y1V5MHdxTm1ETndqbHB1R3Y1QVRJUmhQVFIzUlI4cnFjZjFWZzErcXJiNXUz?=
 =?utf-8?B?eDVsZUpNUW9McW9zbStUR0YzK01kcEVpelY1NkRueksza1AzWFZOeER1TXY3?=
 =?utf-8?B?NnJtUUhVWXhtb09oWXU2OWFoZDlZeTZqL0ZpbXVGRW01d2NZSnFxWWtkb1V0?=
 =?utf-8?B?VGR4RnVYcGEvZVdCR2owTHBKNXZVUVRwYUYyWm82Q0Rrb0l0R1EweE5hR0dB?=
 =?utf-8?B?b3ZWbnc3UmZBQlFsZ0xlL0VKWVJvcEYyNUtzcW9KYXdoM2liWVZXeDdiek1x?=
 =?utf-8?B?N1pjY1FIdDBBQ3Z1TVBOUklwWEE4QWZLNW9vTUJVU0VoM3Awbnl6WnRCcHJi?=
 =?utf-8?B?NHI4eFhJbDkvNnVTQWZFUldvL2V1QzAza0R5cFh1VlZTdUk1MDRQU0ExNitv?=
 =?utf-8?B?K1VMZmt0T3cxYUdCZmRxVUZvU0JYS1k3WVVDL29GdjB5aE9EbGJ0ZHNwUFpj?=
 =?utf-8?B?S0RsK2t5a25GOXdLWnJmcWlrSGVaQ2pwODVFbjVkcnpiSDkwT3RVb0JqTFIw?=
 =?utf-8?B?NU12Mks1N3REbnp0MGdWOGNuUUlqWVVCbmJiOWpuL1N0VmJhTm9uZFlPYS9H?=
 =?utf-8?B?Q0p0WFk2R0RjbG9NN3BDejVRemszVlJleXVtUHRQek03aVVYMUszVG9xeVhr?=
 =?utf-8?B?OWZZaDZjVnBqUjQxVkROUVpyNXFHZTJQVXFFZ2o1M0tVMGhOVFBzazgxL2t3?=
 =?utf-8?B?VjI4SytWVyt3ZXpjbzVaeFpQc2w1ZlBLYitLZjBmbTJYTnBBNFM1SlFkTnB4?=
 =?utf-8?B?VUJvVWQ5SGtxQUI1M2U5dWFSQXNadVp0Tm5EZzVuQVB1RElTaWl3Q1F0OTBC?=
 =?utf-8?B?Lzh3MkVGaWk2VkJWSkM2aW9EY1JFRkRGQ2RRYk52V2svM2pqelU4d3FMQ0hT?=
 =?utf-8?B?ZzBVdnAzMVBxK012eDNIbFlnUmUxcVJxTjV0Tkx3d1NQdHdmNUFjUDIyVDVN?=
 =?utf-8?B?UUY2aWpnTmJIT3J5TW91bkozUk9nZ2ZyZncrZHRhWnh3MXRXQUlJQm5OUXpk?=
 =?utf-8?B?SUQ0VzZ1V1doSnMwd0J5aHdXQis1MmRyV2VUMVV2Z202QjBta2NWNUFEL24r?=
 =?utf-8?B?dmZFdWNUT2tyN0htT1JUckdKT2I3RWt4eWdJNk1OQnNETVBQUUh0anJiSW5Q?=
 =?utf-8?B?M2JFOEE0V0JHVEdGNXYzRFZEWGxDRUI2TGFHQU5jNHhYSDMxT3IzS08rdU5q?=
 =?utf-8?B?bFJ4bnlOZytXbThTUlErWERvR3Z0UUY5MDYvVGwzdnlBdzV2TVh6S3hBMVZP?=
 =?utf-8?B?SWtKcGV5bzFtWkRVTCtJOVVJbHF0QUNlblk2TEhQKzFXVHdNM09BVU1mK01Y?=
 =?utf-8?B?LzB1SGc0eTYxU2ZqenYyTC9Tem1iYjRtcVJMMEdWekhXQWxnY2wxMHZyTXE3?=
 =?utf-8?B?emtNZXdCa2pwVEFXWVcrd3dzSk1obVZDNEQ3Vmh3MndhUi8zKzAwZGYwVkFV?=
 =?utf-8?B?TlNoVlY5eHJGTExtUW90OGhVNTlhbElFZmFMUUwzTS9BcElnbC9PckJKaHBC?=
 =?utf-8?B?RVNkNWZXM3ZWbTI2aW9FY0lNZkNpTjdqQ0p6RTlPMWlXdmRGMEZ6bG14R1li?=
 =?utf-8?B?WS9YQkRYNHA3Z3A3WGQzOUs0bXNCVFJ3RjhRdk5qYnpFenlKZWRlUTd4QzEx?=
 =?utf-8?B?dkcxNER2VkVWZ3QxZ2svMkJMdWNIQzBBbWNjNDI4anBwWldxTHZ0blRNUFpE?=
 =?utf-8?B?TlM1TElpSmQyODF0U2ZVU2tVb1BqV2hiWFdqdG1hOFU2eEpSTUlQYms0a3Ez?=
 =?utf-8?Q?LVLZ8UjY2/ba9NS8pUh0srHT9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6453122d-b2f6-42f8-79ea-08dd20091e5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 08:42:49.2477 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HKkK87RWwIV9VPCjb3wF8fMCOkXgJFphcnO0+JHwe1wOZ73j/k18RzS0yFoLOhe53loYkGF8m3bdi/NqpNnAaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8812
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJl
ZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciAxOSwgMjAyNCAxOjAzIEFNDQo+
IFRvOiBMaXUsIFl1YW4xIDx5dWFuMS5saXVAaW50ZWwuY29tPg0KPiBDYzogZmFyb3Nhc0BzdXNl
LmRlOyBxZW11LWRldmVsQG5vbmdudS5vcmc7IFplbmcsIEphc29uDQo+IDxqYXNvbi56ZW5nQGlu
dGVsLmNvbT47IFdhbmcsIFlpY2hlbiA8eWljaGVuLndhbmdAYnl0ZWRhbmNlLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAxLzNdIG11bHRpZmQ6IGJ1Z2ZpeCBmb3IgbWlncmF0aW9uIHVzaW5n
IGNvbXByZXNzaW9uDQo+IG1ldGhvZHMNCj4gDQo+IE9uIFdlZCwgRGVjIDE4LCAyMDI0IGF0IDA1
OjE0OjExUE0gKzA4MDAsIFl1YW4gTGl1IHdyb3RlOg0KPiA+IFdoZW4gY29tcHJlc3Npb24gaXMg
ZW5hYmxlZCBvbiB0aGUgbWlncmF0aW9uIGNoYW5uZWwgYW5kDQo+ID4gdGhlIHBhZ2VzIHByb2Nl
c3NlZCBhcmUgYWxsIHplcm8gcGFnZXMsIHRoZXNlIHBhZ2VzIHdpbGwNCj4gPiBub3QgYmUgc2Vu
dCBhbmQgdXBkYXRlZCBvbiB0aGUgdGFyZ2V0IHNpZGUsIHJlc3VsdGluZyBpbg0KPiA+IGluY29y
cmVjdCBtZW1vcnkgZGF0YSBvbiB0aGUgc291cmNlIGFuZCB0YXJnZXQgc2lkZXMuDQo+ID4NCj4g
PiBUaGUgcm9vdCBjYXVzZSBpcyB0aGF0IGFsbCBjb21wcmVzc2lvbiBtZXRob2RzIGNhbGwNCj4g
PiBtdWx0aWZkX3NlbmRfcHJlcGFyZV9jb21tb24gdG8gZGV0ZXJtaW5lIHdoZXRoZXIgdG8gY29t
cHJlc3MNCj4gPiBkaXJ0eSBwYWdlcywgYnV0IG11bHRpZmRfc2VuZF9wcmVwYXJlX2NvbW1vbiBk
b2VzIG5vdCB1cGRhdGUNCj4gPiB0aGUgSU9WIG9mIE11bHRpRkRQYWNrZXRfdCB3aGVuIGFsbCBk
aXJ0eSBwYWdlcyBhcmUgemVybyBwYWdlcy4NCj4gPg0KPiA+IFRoZSBzb2x1dGlvbiBpcyB0byBh
bHdheXMgdXBkYXRlIHRoZSBJT1Ygb2YgTXVsdGlGRFBhY2tldF90DQo+ID4gcmVnYXJkbGVzcyBv
ZiB3aGV0aGVyIHRoZSBkaXJ0eSBwYWdlcyBhcmUgYWxsIHplcm8gcGFnZXMuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBZdWFuIExpdSA8eXVhbjEubGl1QGludGVsLmNvbT4NCj4gPiBSZXZpZXdl
ZC1ieTogSmFzb24gWmVuZyA8amFzb24uemVuZ0BpbnRlbC5jb20+DQo+IA0KPiBPdWNoLi4gdGhh
bmtzIGZvciBkaWdnaW5nIHRoaXMgb3V0Lg0KPiANCj4gUmV2aWV3ZWQtYnk6IFBldGVyIFh1IDxw
ZXRlcnhAcmVkaGF0LmNvbT4NCj4gDQo+IElzIHRoaXMgdGhlIGNvcnJlY3QgRml4ZXMgdGFnIChh
bmQgY29weSBzdGFibGUgZm9yIDkuMCspPw0KPiANCj4gRml4ZXM6IDMwM2U2ZjU0ZjkgKCJtaWdy
YXRpb24vbXVsdGlmZDogSW1wbGVtZW50IHplcm8gcGFnZSB0cmFuc21pc3Npb24gb24NCj4gdGhl
IG11bHRpZmQgdGhyZWFkLiIpDQoNClllcywgdGhpcyBwYXRjaCBpcyB1c2VkIHRvIGZpeCB0aGUg
dGFnIGNvbnRhaW5pbmcgMzAzZTZmNTRmOSwgYW5kIEkgc2VlIGl0IGFscmVhZHkgZXhpc3RzIGlu
IHY5LjAuMCBhbmQgbGF0ZXIgdmVyc2lvbnMuDQoNCkJ5IHRoZSB3YXksIFRoZSB0aHJlZSBidWdm
aXggcGF0Y2hlcyBhcmUgYmFzZWQgb24gbWFpbmxpbmUgYW5kIHRoZcKgY29tbWl0IGlkIGlzIDgw
MzJjNzhlNTUgKG9yaWdpbi9zdGFnaW5nLCBvcmlnaW4vbWFzdGVyLCBvcmlnaW4vSEVBRCkgTWVy
Z2UgdGFnICdmaXJtd2FyZS0yMDI0MTIxNi1wdWxsLXJlcXVlc3QnIG9mIGh0dHBzOi8vZ2l0bGFi
LmNvbS9rcmF4ZWwvcWVtdSBpbnRvIHN0YWdpbmcNCg0KPiA+IC0tLQ0KPiA+ICBtaWdyYXRpb24v
bXVsdGlmZC1ub2NvbXAuYyB8IDMgKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9taWdyYXRpb24vbXVs
dGlmZC1ub2NvbXAuYyBiL21pZ3JhdGlvbi9tdWx0aWZkLW5vY29tcC5jDQo+ID4gaW5kZXggNTUx
OTExNTJmOS4uMmU0YWFhYzI4NSAxMDA2NDQNCj4gPiAtLS0gYS9taWdyYXRpb24vbXVsdGlmZC1u
b2NvbXAuYw0KPiA+ICsrKyBiL21pZ3JhdGlvbi9tdWx0aWZkLW5vY29tcC5jDQo+ID4gQEAgLTM2
Miw2ICszNjIsNyBAQCBpbnQgbXVsdGlmZF9yYW1fZmx1c2hfYW5kX3N5bmModm9pZCkNCj4gPiAg
Ym9vbCBtdWx0aWZkX3NlbmRfcHJlcGFyZV9jb21tb24oTXVsdGlGRFNlbmRQYXJhbXMgKnApDQo+
ID4gIHsNCj4gPiAgICAgIE11bHRpRkRQYWdlc190ICpwYWdlcyA9ICZwLT5kYXRhLT51LnJhbTsN
Cj4gPiArICAgIG11bHRpZmRfc2VuZF9wcmVwYXJlX2hlYWRlcihwKTsNCj4gPiAgICAgIG11bHRp
ZmRfc2VuZF96ZXJvX3BhZ2VfZGV0ZWN0KHApOw0KPiA+DQo+ID4gICAgICBpZiAoIXBhZ2VzLT5u
b3JtYWxfbnVtKSB7DQo+ID4gQEAgLTM2OSw4ICszNzAsNiBAQCBib29sIG11bHRpZmRfc2VuZF9w
cmVwYXJlX2NvbW1vbihNdWx0aUZEU2VuZFBhcmFtcw0KPiAqcCkNCj4gPiAgICAgICAgICByZXR1
cm4gZmFsc2U7DQo+ID4gICAgICB9DQo+ID4NCj4gPiAtICAgIG11bHRpZmRfc2VuZF9wcmVwYXJl
X2hlYWRlcihwKTsNCj4gPiAtDQo+ID4gICAgICByZXR1cm4gdHJ1ZTsNCj4gPiAgfQ0KPiA+DQo+
ID4gLS0NCj4gPiAyLjQzLjANCj4gPg0KPiANCj4gLS0NCj4gUGV0ZXIgWHUNCg0K

