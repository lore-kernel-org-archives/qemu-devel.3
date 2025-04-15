Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD10C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 08:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4beI-0006jC-Og; Tue, 15 Apr 2025 04:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1u4beE-0006hh-RJ
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:28:04 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1u4beB-0004FD-W6
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744705680; x=1776241680;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/kV1+46zR4e48xzGOT/yYrOCwIJV/zcEtMJghnRKJzQ=;
 b=iJcA/NsQdWGaVNUQL8P6jTrHlV56oe818KdMyjx48okQp0NyZf3NsMYe
 WAl28ScNpm45cn1ScMW4SF+FbWVxCmKiq9AKkixgXNlpl5tEjbB2iv6b/
 h/2F+Nn4IJ5Q7/K53/G+mR6OUTIZXoNETicSodPhpiv5iQdq/oFhunJBf
 mUou7rIjj4n7On5fiP/A9vYPOIOLhbYZ8rtqeNnJItHuW98JJ6/sM9Z3I
 lfZGlWzgYIb1yYdK34aPUEIsDGwQvnlz5t2CN14JfiK35fzSXL4OooKBL
 x6xJ6dqYhDgZ5hJ4BCS0Kr/u5rK/pzU1cjuFet1FS0u4ZMNNket3ECAYe A==;
X-CSE-ConnectionGUID: xTV10xfoQCmrOpiF7BQMKQ==
X-CSE-MsgGUID: 9cQ8wVpXSTaFQdlXqcXv6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="50004400"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; d="scan'208";a="50004400"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2025 01:27:55 -0700
X-CSE-ConnectionGUID: HEIL0WeXTca+31XtrvG9ZQ==
X-CSE-MsgGUID: jUXmpcWBQ0e39sA08P+mNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; d="scan'208";a="134156665"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2025 01:27:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 01:27:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 01:27:54 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 01:27:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgHtEg35zxUNENmHnONPxcGEUBcPvmMht6ciX/HJjCa8DJnoH0zExsOds5KDK2BxCk7TOnFmu68fanNc+jrHyvdtn6BIP9xShk/SunYRP86YUF9IHsCMeJWfmMu24cP7dcp9VBxq7tOGNn5jDFtKzTwYrIKR5FYhGHPFxrFeOOQApLKzWXIJYxMauesJmxECybfTHL9V/o/e6/4+J+fyJ4AyrD50pfCn/zyvAEpAoBGNitE9N7ZhCykucds/wMyU/xKdPv+Nf5ou97Ze31vjYcZzvXH/8g1opIgoLV5BQViqmQhwLW7H9lVL/0lj+jJpGlMudTM+sQh7eZ9pHT/bSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cBXjH0ruLC1lO2DXbPFVuNXjir+l6UR4KM8opoFiIc=;
 b=hJQK1iC/usBsUaF/R9pWubgwX6jfLnUkxsq1Dwy9gffarcDhfOpUe6MHtu85rRLndmQRwUDo06gR2cDVt39snYSqBzurZHvFpNNbuZYjOVdk4mxrBFKUbtKFDEoItCLEObkC+6eVV//FCi0KH7K6/ppKg6V0BGuUEXmcTA8amyHOuBF5nuqdYxIBTYo3lS+78B5qQWSnzKd7mqU+BCtdaAVxOcq/GreHa9vcPclG9BB8Ry7JvK/iN5HgV0DmKJJjDblu66VXjWU7XK7bDW25augDmmq4ZTqVHM7SKCMblK0qv7ByAoP8ShWumHXSnJWMFBTsf6mMbmxJvaGeln3YSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA3PR11MB7581.namprd11.prod.outlook.com (2603:10b6:806:31b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Tue, 15 Apr
 2025 08:27:49 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 08:27:49 +0000
Message-ID: <b346f57a-144c-46d2-adb6-dd82e6fbdd98@intel.com>
Date: Tue, 15 Apr 2025 16:33:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel_iommu: Take the bql before registering a new
 address space
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
References: <20250415061353.185589-1-clement.mathieu--drif@eviden.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250415061353.185589-1-clement.mathieu--drif@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA3PR11MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 2776ff2c-4ba3-4482-2171-08dd7bf76843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlNSb29sQ05sZDBOTFY1ZkFKVkpYVkhKc1pQRVlkenlWZUxkajZiVzhmV1Fk?=
 =?utf-8?B?ampTeUllUVdYR0tkM0xyOWJJRnErTEx2bURuSUpZVWY5VnNaa1R5c2w2VXhY?=
 =?utf-8?B?YUN2UHVmcU5DTzd3bHZ5YXVDRDlkQ3hUSDh5ZnhySVVuNnMvYjJaTVBMTWZm?=
 =?utf-8?B?clF3MkdXMlRDalVUVzJHNlkvcngydzdkS01FazBERDNnZDcvV2tBb09FVmFo?=
 =?utf-8?B?YkNqUk5hbVdpbTE0emt0b3QvT3VMdEZZbDliMVdLbkJQU1gvbWlzRFU5ZjY1?=
 =?utf-8?B?OWFWaVhKaG5YQkxYVVZ2ZTBCUnhLa0NxNm9RZERndXZ6QktyOEY1ei9QaUtV?=
 =?utf-8?B?eDdhemYzRTZJbUZjcVNKYU03eEtGbkw3Q25FVjhJdkdpckZtOFhaQWdGaXRL?=
 =?utf-8?B?ZS9vTmp2eFFoNFIvNTA2ZFFoVW1JaVZQTi9HNHlHQmVCTnFZUk41QU9kcGVF?=
 =?utf-8?B?eUhuaFhDUUNXL29hU2gwb05SYjhhN0Z6M0cxaTZqNmsxUHcvQUVOaHFGdWRq?=
 =?utf-8?B?Zys2UCtsK2dvdUt6eDN1VXdFZEJQZ0gxam5NZ1JVUjg0KzM2Z3FKVHMyYW1U?=
 =?utf-8?B?cGFYdEUyU1dOWlR1eDlXVTBMM3VXLzFMck4zam56N21HOXBQdHpnc05FZWVW?=
 =?utf-8?B?eGxtSmk5OEI4OXhvai9GRzJ2Ujh3TEllZmhlWmJXODRwcTJuODVsNzUxU0do?=
 =?utf-8?B?T0VOa044VllQSjJobDMvaVZSTzk5a2JQeEtidXl6dmlCY0tBRlBvTnR0Yjgz?=
 =?utf-8?B?RUxYaFhYTjZNcnZRY1UyYVpjOVp6bE45aXgxZTRYcDBXTVQzZlJvRERkdkU1?=
 =?utf-8?B?cWlmNzlpRzRXL2kxNDNQbnMrM3QyR3dZamxpd2ZHdnlXTUd1QTV5cnQrT3p0?=
 =?utf-8?B?bm1wOUVuV1h3dTdNQjhrUlpEdTdaSUU1aXpPUE1obmxjMUNSYXl4NUNRWlVo?=
 =?utf-8?B?enZnY1Uwd2NzTldtRnN3Y01zZ2R2WXNKc0hNRWVlNVFxSjI4WVNOUEhaOCty?=
 =?utf-8?B?S1lMSVlnM0RpOWduYllvZmU0YStFK1hrSU1LMXdWMUtNWDYxaTJvaStkbFRa?=
 =?utf-8?B?bVFJL3pMMExCQURad0l6RUJCeUJMTHJIcC95VzV3RzdOa0pQVDJUZzVPd0RD?=
 =?utf-8?B?RDArNzVHdGV0Uk1zZjFuZDNmMmZ2QzVEQlV1R2tKWld6dUZIUXViTWpaMTNo?=
 =?utf-8?B?ZlBqNDVyZHNIYjNkUUYySGViSXZtaG1xdjl3Z0RNK0RTVm1Xd2tjd2dhNWxI?=
 =?utf-8?B?MndPZzhnRmJsS2lXTXNETUZVTFR1Q3hUYVVCTytGWFkwRlNIK0FRNlZBN1BI?=
 =?utf-8?B?T1RXWVg0UjJXdFRxaU5NWDZNUE5zZ24xdEUycVVJajRTcDlqVHBjb2ZvMk9i?=
 =?utf-8?B?ZGhrSGpSeHRhOVZBbU9WejlzdnBmblVpaVZCSy9zMUowUkZVdG96V0p1eUt6?=
 =?utf-8?B?U3dML3NKdGtBQTFHR2hmODV2eEUxTElONXhMOEx4dFFPbUhDd0p1UHpQdzRL?=
 =?utf-8?B?RDdXUkprUHV3L1FUaWZRZkhFV3FYeURvY0s3T3k2ZURzcVFTUi83eFVIYlpx?=
 =?utf-8?B?NWYvVWpCN3NCNzlUL0ZrU0xBSk8xU0hvUS95ckI5eHFQaFJiNGN5eHJNc01Z?=
 =?utf-8?B?SjcyQUxSNUxWc2VPemtJYXRqcWMvb0ZZN3g3USt4NzlRNUcyQW4yY0pkS1cx?=
 =?utf-8?B?R1lNK05nSW1WRUtOMk1lMDE3WjB5NllkbU9aaGpaUkRLL1E1MFl2VmYyaGNI?=
 =?utf-8?B?d1ZoMThIM0k5b2dPbjNISXExRWg0ZHRSOG1USWt2c3FjbUN4aDNzOC9vcmFR?=
 =?utf-8?B?Z0dlVk9adDZ1aXJ1L2xCL0VBYmg1TG1rKzhWUmY1bTdWeFpSVnFmT1N2Vjh6?=
 =?utf-8?B?M2dBekVKRnVvV0JVZTAxamozT3cwN1oyVGVRRlJlemZOWVZiazRwamR2OEJH?=
 =?utf-8?Q?v+oKq0yZB/0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW03RU1UdmNUTVJRaFlQcElWejhFQUp1bWhYSkV6dTZETFdIWU0vUDU5SU05?=
 =?utf-8?B?TXZnR0llTmo2YWw1Tko4SmRVZG0yelBmWWJSVWIxRndhZ0huVUJ1QjFVTGs1?=
 =?utf-8?B?MThabGZ0eVRXM255SVhhRncvRHFtV3phcVVzMFUzWkFPYUdBUy81c2pMSXVG?=
 =?utf-8?B?Q0E2K1pWRGVCWWJaNncvWDNJVlpGMkhjcStQNHRURHVzN01BSHdROGdKSTBk?=
 =?utf-8?B?TU5tdFNvbjFsRndkaFNOL2VyVDhRNWFmL2tkbHpiYXVQQVMxa3ZDbUhRbWxU?=
 =?utf-8?B?WlZkck4vbUVRMTh3RnZibHhUaDNNbEpTUHRwWXFhbDRrckxvMWZyZStpMzhw?=
 =?utf-8?B?SkZMMHViakdzbHFtVElpdW85em01cDhRaThTdk1zeG5hZUtXSWhiRkZaNEVn?=
 =?utf-8?B?WDVBWjcwT1VhNlhVcS9lblJwWFI0bWkwZWM0dTNYOURlb294TTRLcnlnODcw?=
 =?utf-8?B?ejFrckMvWlljWE9EK1FWLy9MdEhDTTRhMXZuUkRRbnovcnJFTVJyVEhkaTY5?=
 =?utf-8?B?eVpNNHZUZXU3RXBwQS9tQlo1OU9jME50b050NHllc2xrTjU5NndGaUw5T2tO?=
 =?utf-8?B?NjYxRVFWMC9XYnZMK0RDWTZlQUYyWlZmU3k5cWpPR0R6NnpUajkzdTBFVnNq?=
 =?utf-8?B?VzExWUhSbSt4WTFIeldDRVlQcVZZaTlYdkNZamtwelpzd3REWkJ4MnllaDRY?=
 =?utf-8?B?cGYrOEszVzVtYm9YMXNoYmc5STF1bnFBWWdockxXWW8rTG5GTlNSL3VtUFZq?=
 =?utf-8?B?d1J3ZTM3RzF5eENwOWN6eFVuYnorN0tCdVI0N0NFcElseUFEZS9KckY2QTNh?=
 =?utf-8?B?b2ZKUjlWU0EyTWpNWk1uS1BUZ2RXUHh2cDl6eUxMbjA1aTVLc1J1M1VFcGFY?=
 =?utf-8?B?OHJYQ2R6bjI0eHpMbEhIUDVtdkhtdmFVMXpkbXdTbExDU1BCajNIL2dKYTJm?=
 =?utf-8?B?NTBRWWJUUUwvd3pVMHErVVB3RllBU0RHNC9tV3lnWGE5Vkx3MTBaRStLVk12?=
 =?utf-8?B?N2xVNVdoMld4VWhIdndCTTlGRTdjY2lTS0dmUEVOL0htZWlUaEtlMG90R1h1?=
 =?utf-8?B?eSsxOTQ4eEJsU1NsTDhlTFpxc05oaVFRS29tcjJjMVg1V1JsNWQ3Q0t2dWpE?=
 =?utf-8?B?VE5aVTVvb3F3NENHVXV6TjJmWnd3YktVQlIrVDhvNlU2OFU2ZWhFS3FLYU1p?=
 =?utf-8?B?VW9ScHlxbDByNXlmVndEdG5MaEZ4dGhZTllJOU5tNlpvQ3RwL215M2s4SFo2?=
 =?utf-8?B?ZXJFZEdoYmlHcWJSajJjWTVjdlFVT2s2K2owejhGSWpzeU9zMTFKemgrQmo0?=
 =?utf-8?B?cElRZ1ZBVXR3cEx5ZW4xV3VwYllQM2crdG9sNHYxeGJ4YWppSEpFRUlJdE1l?=
 =?utf-8?B?aEszUmFsYVFFQ21lcGYxeDFnQUZtS0lrRFNHNjdOa0RZY2FsYkN6T284aGQv?=
 =?utf-8?B?dDFmMW9DbXBvLzY1ZnB2YWNjdTdlUlhLZ3ozN2xhRklTNC9PTG5xRWxjMEFz?=
 =?utf-8?B?SitKVEpNOTZ6T3FCQnVMSDV3RWIwMW1RMGdPS2ZOVEpIRUxEWTZWTitLMmFz?=
 =?utf-8?B?clpCMGc0Mm0zNlRDSlZvQ1lTTXpVNEQ1RlJGaDlKWjR5K2RjVVNZK0VLK1Fw?=
 =?utf-8?B?ZXplaXZNcEdBbFl4YnlMSlVQYUpHSk9ZQnkrcllnZjd1VWI0S0pJUHZRTWI5?=
 =?utf-8?B?UzZVQ1ZEYUtBU0o5S0szTnVTd1haUG5JM2NkQ0ltOXdCazhBNnhwNXhhaHk1?=
 =?utf-8?B?WnkyVDFzUHN5aUREdkI4Qmo3bjNNZnJQUVFCVkdrbGZWZUU4c2hKV1NCc1BP?=
 =?utf-8?B?TnN3TEFwdmt4MWthSTlYQlhKMS9SZ1dJOG1FMWNHRERZaWZFRTM0ckE5U3VZ?=
 =?utf-8?B?WVFGVnNsQXBlck4yRnZMbGtrclpXckw1bUl5ZjJOL2gvaDhtdjEwcmlrWncr?=
 =?utf-8?B?VHdYS1B5NzMrdTFkNFJGSzltaExBcTdsUVZMN2gyZ1Z2dlJ3cXhiTUtGaEZt?=
 =?utf-8?B?STNuaEs3VFBpZTZjK1o5R01QTnliazZOM3JKTWxmTFpvY1hmdjV3ZDBQVVc1?=
 =?utf-8?B?Y1lrUXB0ODBSaHBZd0lMNFdTSlZ2cHNUazdQbTNocThEVXJuTWRmMmMrM3F2?=
 =?utf-8?Q?/Rhu9rIy6MvuGoV85mp3A7wUY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2776ff2c-4ba3-4482-2171-08dd7bf76843
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 08:27:49.5769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qn+jb3dZisM1mlAQJ1VtSeCJh6vCqCuB2G60ir+8OyM8LSMQz9SnvqobVHa6YQ8Y77c+ll4GmpccONKkon+M0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7581
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
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

Hi CMD,

good catch. Did you see any assert log. Just curious which path complains
it.

On 2025/4/15 14:18, CLEMENT MATHIEU--DRIF wrote:
> Address space creation might end up being called without holding the
> bql as it is exposed through the IOMMU ops.
> 
> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
> ---
>   hw/i386/intel_iommu.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index dffd7ee885..fea2220013 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4216,6 +4216,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>       vtd_dev_as = g_hash_table_lookup(s->vtd_address_spaces, &key);
>       if (!vtd_dev_as) {
>           struct vtd_as_key *new_key = g_malloc(sizeof(*new_key));
> +        bool take_bql = !bql_locked();
>   
>           new_key->bus = bus;
>           new_key->devfn = devfn;
> @@ -4238,6 +4239,11 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>           vtd_dev_as->context_cache_entry.context_cache_gen = 0;
>           vtd_dev_as->iova_tree = iova_tree_new();
>   
> +        /* Some functions in this branch require the bql, make sure we own it */
> +        if (take_bql) {
> +            bql_lock();
> +        }
> +
>           memory_region_init(&vtd_dev_as->root, OBJECT(s), name, UINT64_MAX);
>           address_space_init(&vtd_dev_as->as, &vtd_dev_as->root, "vtd-root");
>   
> @@ -4305,6 +4311,10 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>   
>           vtd_switch_address_space(vtd_dev_as);
>   
> +        if (take_bql) {
> +            bql_unlock();
> +        }
> +
>           g_hash_table_insert(s->vtd_address_spaces, new_key, vtd_dev_as);
>       }
>       return vtd_dev_as;

-- 
Regards,
Yi Liu

