Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EEFCA0FF6
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 11:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urE0Q-0001ur-7O; Wed, 27 Aug 2025 07:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urE0M-0001pO-Ky
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:07:50 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urE0K-0007Ga-Rn
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756292869; x=1787828869;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2XJsTfcLHlYTRb2cC2K8TZ47UuhD+Ta1+5yzKGsG574=;
 b=hjGYwTkXQXfcvDvviE/WwfzONa8Y5bsWCMtdrRRSPsKtMk+K+8ve1zcR
 QXnjqepXpKqr0r/xK77/JZjC52Wy/zucy4KlefITkXIAyt0P4m5XQXysL
 YF9YNy+K2X9Pxlwzch8N62Tbde4dYpLf28gbKJ4y6TInwvg3sRQL6m9SM
 QvjsWFQMAn8YnH00OrD2zfapgzwOTXLdOthdLVuIIE1Z7UYzR1s0wxIzB
 NDDFpmrHZsPfu/rdYDhbksfz94Zm45/PUJOPqwCD+N7SkPYBogzOFeGf5
 lGIRbkf6av20wDsHVthS953XURvrHOOZAwqxUAHnQsQEjCU5kbj1WDo3/ w==;
X-CSE-ConnectionGUID: nWQ+qKYYQ7a261nm+Bk/ow==
X-CSE-MsgGUID: ZNeKlsdaRlqSdTnW0pufRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="57743471"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="57743471"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 04:07:47 -0700
X-CSE-ConnectionGUID: wS0LRp03SsOw1Z1yt/gLfA==
X-CSE-MsgGUID: XKUGfsaqRSmuxa2+I/41gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="169754136"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 04:07:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 04:07:45 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 27 Aug 2025 04:07:45 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.59)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 04:07:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVF6QEWOHAXKXMJUGojvXyt1zHAhi8BD7hg3DF/Sdi+VrS/cd3azeFBkqkB1nh/tRRwKGSayevOZWvqDfEPCGwYh6OY3KUWKgtZWzcMC7m2WlndbBPsMIKnYMDuooaLEH4N0L3KseHxH0e5RyG7R2RFaRivn4T9AgI/PousQ1G/yGM+VGsapB5arw8EReK6BXE0lx8IO8Yp2sosNweNokwu5DZYKeJFaCh+xRGMsSjmhSu4BdiPAkMIFy7ZWqTMNj16WF1o5y+zSaXqcn84Sbffi3XPM+CuSCgiwMswL4kCBp3saBtkcZl/NfPLvUXCnYhrjzoxy+ZWm1lO165RjzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugfyehm7HUpEBx0UqD9SOcLB1VFe+5mO2QZqHwafZa8=;
 b=EpSCJuevpkStWZLPimT/kw6mF11ESeN0Il0h4UtLlRxg0JtwaWq+9HtAXDjLq+Qo20HqBVkXoNAZ+55Yua45sx49dBAZNAaB/g4p1ttU9Vpsh3RVpGcxlNf0zp44s6yf6pNj4twN+3no29tjkzN38rpB2im5dBmbgECcrDfo0UO06ZMRSp6xvGUwu/4p3pMVSywVrelz/MJM8hBtCt9bd+6x9YU54cFhAYxkocBNSZysM5YSy1qfcEahMwh8FF99GQN9NABUAXsEr5scsc+115sEtTDPS0zIqpWfiTm3Us7rdgq+q+rWYQRhVif8ua6bBkMMAq4AwUrWhuRs6kGZ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by SA2PR11MB5082.namprd11.prod.outlook.com (2603:10b6:806:115::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 11:07:39 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 11:07:39 +0000
Message-ID: <2039696c-5e90-452a-8c35-6879c0875223@intel.com>
Date: Wed, 27 Aug 2025 19:14:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/21] hw/pci: Export pci_device_get_iommu_bus_devfn()
 and return bool
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <chao.p.peng@intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-7-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250822064101.123526-7-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:195::15) To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|SA2PR11MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c7eb239-3018-424d-5ddb-08dde559ef5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|42112799006|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjFBTVExN1kybGFRNHlRdWhCSFJNc1BLL3l0MjIybnQzSzdYa053cDZLV1NT?=
 =?utf-8?B?WnhuRWFNODQ2SFpxcFpPL1RZRFN1R0IrczN1d3g0Qjgva1YrQmhwY2syN2dK?=
 =?utf-8?B?L0YweDVSajAzRnA5OFphWERnNG0yTFJEbDlSNGo2akVDZUN1b1Y5SjJJZ1A2?=
 =?utf-8?B?dlhOZWJ1a2RRbHVsK0MzRDBLZzBkWnlWWU52SCtsUDF3VjA3NjJTajZ1dWZ5?=
 =?utf-8?B?RExjU3RyQWt2RFdVRlJ1YmozSFkySkpoOWZDblNyOXE5SGM1dWtoeS92NUZq?=
 =?utf-8?B?NHJtcUFVa2h4RXVYdFpWQVpvSUdnREwrVzlKWk9zSnJWVEc2YlpneXJRNDJQ?=
 =?utf-8?B?TEI2N3ZBU1Q5ZE51UEo4Y2VaMjNsUkl1U2lzNU9ySi83ZEJzWmt4dzl4eDFU?=
 =?utf-8?B?aGt2OUdpNllmeVc4dWpUS3VWc0krbkZQSDZhUGZWa1VmMlZNTWJ2RUZERDZv?=
 =?utf-8?B?S3hveWg3QnB4VW1rK0xYOGVPTDg0REhpNEJLOU5OMVZnZUxkMFcxcStnKy8v?=
 =?utf-8?B?cTVKZVpibWtWRHg0dVdVa010ZWsrUmRjOHlsMXlwWmh1YzFDa1ZNQjZkcEZE?=
 =?utf-8?B?T3JMMkdJclhSZUF2NEh1RmNaVytLblpINmpxN1U1cWM1dDZuZWYxSFBIM1hT?=
 =?utf-8?B?UzlrOURxVEt2aTdrVHJVYUNDNkEzVVFoZWpGMmVPMXAxclNmYkVLSVFUMzFx?=
 =?utf-8?B?YUZSSWVQUmo2Q0lBMXJkNStvN1A1S2VXd2FPMXVsTW5rYm1FT05iQUs2d0da?=
 =?utf-8?B?bnViWFlZeDdnZlZXQkJSZFJEbG9yMzFQNXQwMElMNnVsaU8xdVJBcWhCbXhz?=
 =?utf-8?B?M01RNW9mS3JOK3gxak5MN2FrZDRzeTU2RkpjMDVPWDdJWmZraVJPUU5UODVO?=
 =?utf-8?B?YjZ0a3hTbjdJK1NKc2JBZ1NoQnhiakY5bi9GTDZ0bHJ5N0lZT2RmMUhZclpZ?=
 =?utf-8?B?SmY3WU93VEFKU25XK3dMYmhNVmhKUGJFUk93ajBTTm1wNmpYVDFsY0V5bE1u?=
 =?utf-8?B?MTVvcTZCemc1dHJyMDIwNVhUam5RYVVQQkVaT05NT3pLaTg4M1U4VjhQMEQv?=
 =?utf-8?B?Vmg4bnZyMEUxbzdVTFVXMzhWZEtKb1U5SFpJUkdnNnZ2T3JwRU5uS0dBbGtu?=
 =?utf-8?B?N0R5Zi9MZUdSQkhFbDUzL1JlbHRTWlVqbnQwR0JUQWdIN0tzQTNUbC9YSjJH?=
 =?utf-8?B?RXdOYm1NVDhzQlJCaTFSdFJ6Nm1wbzBoZVZzcUJqNEwyZ00rY2VCS1JWMURB?=
 =?utf-8?B?K0t0N2tweFNFSnZPL3VjVnRzWkV1S3VYTFVvT0RYNTMrYWxqS3dGRUNGcHZ6?=
 =?utf-8?B?Ly92VWxZUDh2Q2QrR3k3N2pPeTV1eUx5bDZ6TUYxbjRQcm5XVGhoclBPc0kx?=
 =?utf-8?B?c3B2NkZoWWdqS3RHR2lzUHc1TVJkc0VyK0VaV1RhOU5idmFUaDJKTk9VT212?=
 =?utf-8?B?bldmM2E5VUwyQ0lxYVBwUWpyV2NHbjlLKytmRTZ2R2c2bEtoQzZXVzBacUdL?=
 =?utf-8?B?bE9pVzhxNWYvVm85Njc0djcyeEdGV2pmd0hMdDJqMDFkVlVMREZXeUNhY2py?=
 =?utf-8?B?ZE1XYWJkeWpHU0w5VGhrMmc2RnhHYmRCSFU0NGh6M3NwWXBlVHJWTk5JUHJG?=
 =?utf-8?B?NTJmZ1ZrK05BN3kzcWc4dXBsQ3dKK2sxMXFZUVAvQjlPNDNkY0NlbGo5WWJI?=
 =?utf-8?B?SzhIYnIvTWc0S3BFcndCSHBldG9SNUk5MzBYQ0VGQmtmNW80eGs3N1F5UHJw?=
 =?utf-8?B?V0E2N1AwNGdOeUpRTHN6MmJZamZXa1FzamVlT2RCVEU0elcvbWh0Q1BTaU1Z?=
 =?utf-8?B?ZGNCcm5DQkVzdzluVEQ4cFZUeHBBU2hNdE1hRlJ4UXIvSXFCam1XRGtGeGth?=
 =?utf-8?B?ZW1CalNHVWh3S1Q5RXNkQWtRZ0NXVksycXlqZHRMMFZQMjRKd1Bocy9kUkdB?=
 =?utf-8?Q?JbeEgEgT4/E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(42112799006)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmM0TG9TT2tZb0M4amZqUXh6SWRnOFM4RGZrSUVEYm1rUFhVcWpWeEZoQ2hX?=
 =?utf-8?B?S3Jhc0o3cVdOS1A0NGo5V3EwTWZtSTZWSVVCSTlpNWJpcVJkZXZvUUc2OExk?=
 =?utf-8?B?WU1NTi96NFZOVXlCWCt0Q2hJUTBPMndESmc4ZHQ5NytaVjhBak96ak94enFQ?=
 =?utf-8?B?bUJncWdvbERkbEJQS2RseFN0Z0gzUEwreStzUG1FS2lIRkZXOHlYLy9BdG9l?=
 =?utf-8?B?UkJXc01zZUVORWZZd1loS0FGZXlrNks4QkVlSEYrRUZJMUxkN2l4VHhQUUEx?=
 =?utf-8?B?M3U2dEg5OFEzS3ROYXdDQ0JjMnJGcGl6RXZwaWY2VVFBY2hra3JJSFpZZGZF?=
 =?utf-8?B?aUc5ZUJ3bkYxRHJIMG4rc0ZEY3ZlYUR3QmhOWXMyZ2N2RXFyTGVDWExOeTlT?=
 =?utf-8?B?Z1BUZWdSOGg4M0VuZjJ1ZXRibHU1N2VSeGxtRW9XODVOZ3d0bFNaa2Y0cHFF?=
 =?utf-8?B?TExMaE8vMGtnalJoSkxXRDVqS1loSVRxd0U3WXkrRTVTa3JUV0MrNnY2b205?=
 =?utf-8?B?WGFhQndmUGxyb1dxNUpKc1pDNjBlN3VwS3RqU1Zka2FYNVNtK3Y5WmFoTEV5?=
 =?utf-8?B?QWZBUXRDbk9jR2ZUUjIwMHZoSEh0RFNzWFloc2RPZ1ExcWpNMEswSnUreHBn?=
 =?utf-8?B?eDlobUxTYUZFZnNncCs1TThkRlF3NmtMTVNEK2c1VkYybmRPSVI5Z2x0ZkdX?=
 =?utf-8?B?b0V1UGx5d2FJb0x0SnVxYzMrUHhsaDRNNndJOU90QWpBVWNxYkRDREZieXVw?=
 =?utf-8?B?QzJXVUlGN2NEak9WME56d052LzZFUHVsbGRsQnZIVURzSmZ0ZU1QbGRCY1l3?=
 =?utf-8?B?WDVOSTlnQ1EzdW1na05QZGd3SVZRVkJsc1p0ampoMWxQZmFZU0h6VkZNclVq?=
 =?utf-8?B?b2h2ZGd0dUVmaFRVeVBiTCtLVlJQN2Uxd3RLSGo0MThma0U4a0g2UlJCMGNM?=
 =?utf-8?B?MG5vcFFHWFYyKzM4OWJmVkM4R1dwQ1dhWDY5U0o2OTJMMWF6Skl5bzd5WmFW?=
 =?utf-8?B?MlFlZ21KQTlrd3c4SnY3aDFSVWtBcVhqS3pyUXJjcHdaQzh5MTRIeXlyWEZP?=
 =?utf-8?B?cXI1WUJBWnVLb0tJUHAwZ3phWUpmUXlSU1FEdkIwRmQwMzJCQ0F5WlgvWE5Z?=
 =?utf-8?B?ZFdPd2hmQzd2Z3VYQ2hXY1N1Slg5TW50eWVGQ3ZIYnhub0o5WW1MNHhoZ21T?=
 =?utf-8?B?a3ptTFlIdytoZkMyZXkrWXRJSC9YcnpNMjBFaGdUTkM0ajJxMFE1T2tTZWZG?=
 =?utf-8?B?TVhKTFdWRWx1Qkw3bDVsOVVweXZ6enRCLzljcDFXTTUzMHFONzBHbnk4aTZ5?=
 =?utf-8?B?REw4cUZxYm1TMjUxTjcveHRJYTNJbzZPbUl6ZFdNdEE1b2VUZUNseSthTEla?=
 =?utf-8?B?OGUzekJESUNDamZoaVVoR0ZyWUNjY3VKSmdIb2tXaHA5NHNJQTZEMk5KNWxz?=
 =?utf-8?B?d0tEZmU3Tkh2NzNKVnJzY1pxbjY4ZmRZNlVGdUpqQU1UbXl1eEpybnBpVG5R?=
 =?utf-8?B?dmJOUDg5MnJUSTFxL0ltWEwvVHdIcVRVWkIyM2NaK2tCOWdZMXVMczhoMFdx?=
 =?utf-8?B?QXRtWVgwbVVaQjVKNW1id1dKcjF1L09IelFCQVgxVW9JN2RpOUhJeVBWWnY2?=
 =?utf-8?B?QzVvVlMrQW5IMzVkNEJRTUxIRER3Qng3bWhzc2VKZmgyamsvcVNEWDZObDZt?=
 =?utf-8?B?aGU2ZGJIblVtWU1YQXVGL3lCQU5HSTRGWUZoaVdRd0poajZhQ2NPV3FiVWk0?=
 =?utf-8?B?QUx1VVlnZ0NVSnI5aDEzM2lSRlZjTDVlTE9xUTA4bkZlNTRub09Qc0lDQ2tn?=
 =?utf-8?B?Mi9DYkJPUnMvbHlGVjcvSHpUK3N1NFQ0Q0pCd2hUNGQrNWxjNmlBZUs5emJW?=
 =?utf-8?B?cFA2T3NsdWluMDZPdVNpVE91Vmw4c3ZLYnFVWUxDU0liZUIrODQ3V3owaERK?=
 =?utf-8?B?NUVxOFNsdEhYZnlSMmYzdDNzeS94VSttMmNWc0tiL25rOEhFcU9uOWxiVlZZ?=
 =?utf-8?B?MS84WkVYbGRiSkxPbmVKemNOK0UyNVc3YjB2QXpLZDVxUStrNUVDYmhBQUp1?=
 =?utf-8?B?OUx2VGhEc2M1NXk2SXQxOGFONnk1RVd3NVNWMXV5MGpPNVJ0dUlzU2dUUlBy?=
 =?utf-8?Q?6kqxZdY1RHwVCK0Ce96aqFh4i?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7eb239-3018-424d-5ddb-08dde559ef5b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 11:07:38.9694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnR0AzQ7FYdnnClOG06TyYmS4laDJ6bo1QAQEntLmg+x30IKBOF1LlbxdDpQNpBH2pwZS/kH7ZtVuUZPhWH9xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5082
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18; envelope-from=yi.l.liu@intel.com;
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

On 2025/8/22 14:40, Zhenzhong Duan wrote:
> Returns true if PCI device is aliased or false otherwise. This will be
> used in following patch to determine if a PCI device is under a PCI
> bridge.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>   include/hw/pci/pci.h |  2 ++
>   hw/pci/pci.c         | 12 ++++++++----
>   2 files changed, 10 insertions(+), 4 deletions(-)


Reviewed-by: Yi Liu <yi.l.liu@intel.com>

