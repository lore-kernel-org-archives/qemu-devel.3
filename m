Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87A8CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 11:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urE06-0001fs-Rc; Wed, 27 Aug 2025 07:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urDzz-0001cp-SG
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:07:30 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urDzx-00072X-Ua
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756292846; x=1787828846;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fB8wWobUrYb78HkIcrDSG+DXOBmrWfnuZbQZ6lAUaBM=;
 b=FdXs/TrlVGL1XW4EYg0hZWmJCXU0pSlsoLDhrm2No/zyLI/4JVBIrAnF
 ABZm0Dv4IqtNIMBrzHVjxkMOm0qPYq7VB1Qzxk0IcyWHLRUSC5Sg1PgWu
 IQbyxtOOOVp0fOQ4DGBhcF+8et6+8vDnqjrNMNa1ZB1J17Ndp7h2AR4q8
 +9G39svggWcqq8TarHKtoI3KnJlMDVBbdZ/u86yX8heltURE9mHp01wSA
 LERMjENRjTd9k5PBEC1LocSoCBo0bbr1/59YSUyu8y0KmXQ5hlkZQ/fH8
 YPuzyF008C1YsVa3FOc+wdBgqB/yV6WAsqZTlGgLhDHKLV46obsqHmf5y A==;
X-CSE-ConnectionGUID: wCYirOfBR+KI+6HYbQqW8w==
X-CSE-MsgGUID: VjBewAwtRvK58AOtpWjOFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="57743402"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="57743402"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 04:07:25 -0700
X-CSE-ConnectionGUID: ACBlxQfnTvWYMKBByKeR1A==
X-CSE-MsgGUID: Oxoguo8cQ4y5TAyN8nP6TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="169754076"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 04:07:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 04:07:23 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 27 Aug 2025 04:07:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.60)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 04:07:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNDrSYw1Ke4u6WUqMfnB4n4nBInVgGlnmIgKwC9Ph1U7VS759Se6y6yLx6apDC1Z0cn+Wzt4gyYbxQcJ7K87dB3wOllaZH1dmi56Ve6RXyaq12SFDbqyLZQbl/nLRRdFYmj2gK3a0RQFdO3utB1HTN2yU+8VHe58MpEfagXjRTTWsHh/axo6iZl5ssAjdtABP34TR70bgRPBPhZoBicY0yGA90uUXe9lrXQY5Qwg0huDb0lz3fYH2aDxi913jo1tmFBddjWSxtIls7w/oZsihXw+ZJIX1I/IlsHa2yYLSypjAdEqhd6iOQvQEzjqTg0AWzbhKB+0OzRLRUDi84BNdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gN5dwWuaHhm3kHd3xqMQkbw7X3if+kymvYVLXJJk/MM=;
 b=D/1YHqV/Xdqar2ysy8W4X9RyBFDD7BHbBjE10mwu78Cj+60XkuVO2xCwFVKCbOuM4i9AfwagUWzwqem6OtU0Y/pbM6r8Ul2TDT7Pn6hxs8NB1wtCwwJFd4cVUgSLikGdveheqjb5gx4aDvUsle9MVfHRUtooaDBdCGiVB9sgKX/QxbTvcStqWE4eIClsZZfm7KjSw9Bf4Xi5D2TW1ASsIJnxmqGG+9X95BSNvYvwYo9urec7XO/cBUrZOPYFIrPwU/bc0VoAr7KQGCKke2YtjcgE128Wgvg5KJvTpPWm7W43w1n5Vl8h+AJ5X+uHEr8Lmk7PhNW6yAlIY5n6QtabpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by SA2PR11MB5082.namprd11.prod.outlook.com (2603:10b6:806:115::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 11:07:22 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 11:07:22 +0000
Message-ID: <1a6b19a2-2467-4086-9a0c-0bd7fde9ee16@intel.com>
Date: Wed, 27 Aug 2025 19:13:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/21] vfio: Introduce helper
 vfio_pci_from_vfio_device()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <chao.p.peng@intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-5-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250822064101.123526-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|SA2PR11MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: 79c31ae2-95b8-4378-55ad-08dde559e53b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|42112799006|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkVrZTBlbTFVR3UyaGZnZi9KbDdoQ0oyczZFZEhvWDV0VlcyV3dVOVZya2FX?=
 =?utf-8?B?NGtndk0yR2IzUHVxeHdMc3hJWWphN1haTlFlL3VuUXRwUGVIV01QdmdjRXho?=
 =?utf-8?B?S2VVRFk1VnpUK3NRYTNSY1AxZE9PS2M1enp0eDRzbUNUekN6OVltemoxRkxB?=
 =?utf-8?B?eTh5WHUrWFFNMUt4aTRneTFrdnkzejJSeG50NkVGR0NDbmtzTHhPR2hFVlB1?=
 =?utf-8?B?VnBFaDN3WDRUdzk4Y2U3Vk9DZnhCU1ZodUNFVTNwcnV2MkMzUitUNDd1bno3?=
 =?utf-8?B?c2FYY05oT2EvODlpc3U3MUFYSzF2RklvckgxVWVrN2YzUkk3dTJoc3FIelJR?=
 =?utf-8?B?RHpGNFB6eWd1cUhQVTNiTWRwUnJieDNrdUxRYUZLeVF4N091NkZxdnZXNHhi?=
 =?utf-8?B?QldMNXJ4V09pS1dEQjBMd1NIcFdZNXFoQndaU05qWWxZOGV0cEtRZVMzeHIw?=
 =?utf-8?B?RWhUSFZHSTc5Q1MzWURpN1FRdXFpREMvTlVyTUhOTWc2NEZQT3dOYXJhM2J4?=
 =?utf-8?B?U1RwaGhuUHBPZTFSanN6ZEIwSk1BeGhOeVU3NndRY3N1UHZpODVtK3JQUlZW?=
 =?utf-8?B?RDVMUTNOSFB2YjdCVTdaTmR1R1NkVkt5UWlKUFZjb0l6dDlWMVlGUlczVEJo?=
 =?utf-8?B?U0wyMG9kWDE0NFVJVDdza3ppc2tMTzVNR28rb1BmWjdBOTJCWnV2YTUwL2lh?=
 =?utf-8?B?K29MME0xL0lTNUoxclpjKzlvYldXcFNQNVRra0JLS1MrR1lTc3hRWW9iQThF?=
 =?utf-8?B?dmJXVk5DTWJFcVNvM213ZVRKWi9wMHdyMlRFT0lxVk5oSnBXYzUwMVJaVmZQ?=
 =?utf-8?B?WktUVWpEazVuMXVCUmJPR2crcFBxeVNxT1Vrb0dnUTVHRG9XbmN2WWxUWkFo?=
 =?utf-8?B?WWkxcTd2Qit4elFlTWdUempiZEptQUx6Qjg4dmpaZlZNSlpxeHRvdnFYdy9T?=
 =?utf-8?B?OW9CaTlma0xQYUI3MkN4emtJWlN3MXdOby9qWlpsUWZkSFNRQ292YTgrTWNw?=
 =?utf-8?B?WDFnRUJ0QkJuc2laOUxwRFE1YWtvU0pZRFIxRDJKekI5bStLdmUxZW5JakN0?=
 =?utf-8?B?dDRZTisrMC9JaTQ0ODVMbERsQTh1eHRBdlZtbmRjanQwSjNYdmljM1BDQ2Ew?=
 =?utf-8?B?Mis3MElFM3I4Q0dyWE1TTHZ6clpiV1RMNTc4WEZXL1VaZlhaNW5QNUJEMW9Z?=
 =?utf-8?B?L3YxT284RWw4eDhIYkdIWXh1UmRFMnlOZ2ZvMkEwQ1lWUjJLU29yVTNUUW9q?=
 =?utf-8?B?MmFYRktlUDhRZmY3VjZVblVxZlBrblFiMVo4bVNWR1hTWHoyWWxFZnRoZ0RQ?=
 =?utf-8?B?Y0pXQTJOUE4zTVJvUjFLZy9XaUJMNjdVQXNYNVE0MXVZTmZRVk95bE1pQ0c0?=
 =?utf-8?B?My9mWldPb2Z6K1Q0T3o2cW9qR3BMOXRTb3VBK1g5c0w5Q2N2SWNEdzFYQTdo?=
 =?utf-8?B?YjlWZzVHK2svanNmdG9hZXdVMFFqcWhSYXhDY0dYcG9WbDEwSFQ5a1JoRUdQ?=
 =?utf-8?B?WnIxSW5Tb0hMMks4a2Q5Q3VjT0VOVG9xbERQVVdvVDlzM0JabE9mRWROTW9D?=
 =?utf-8?B?Y1hISHpXaERVRFp0S1c1QXZueitGY0dwazFuKzNEcFNNMUs5RmxVdENYeXJP?=
 =?utf-8?B?UGt0akw3Q2ZXVE5CaXdtc0lJUzE2MEpHSVh2aXh2R2J4cEJQZ0tIcUlmZ0xO?=
 =?utf-8?B?aGNUTWVxRkFhM0Q4ZmE2WXdBSWpkSEZRaVIxLzQzNlFGVDFGN0RlUCtXcW94?=
 =?utf-8?B?NzNVOTd4ZitIc1l0S2wvUlBQYjJWUTNIQmQ3MFQxbjIyRTd5OE1aQVNQM1Nr?=
 =?utf-8?B?NkpjbU1jNHUyTHgySEw0MitoU0RFRUhrNnVlK3RuWDlHeTJLMEZudUpwNVBj?=
 =?utf-8?B?eWh0RG5YQnA4YWhMYWJvbDh0TWk1UFNFL0lNM0p4akFvREE3dmlSUHVWWUZI?=
 =?utf-8?Q?MH1i6LL9PHM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(42112799006)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3FCZ2tBUitTTGpPbmR5am1lbVdFM0g1dDhlQjJ3VEJqUFhXUEdmQVRLWE1v?=
 =?utf-8?B?b3pXUmlDRzcwNVhPa2lYQ282eHRWN1RqZjBpN2w2NnZMT2tGOTBqbmg2THJC?=
 =?utf-8?B?OE51Z0wvQlYvSVBURjludVZuTU5MUmkwRGpubGtkeGtZUU0zclRiUWZGNGht?=
 =?utf-8?B?Q0VHVEFWU29SbmF5Lzh6WFliVks4TUp2OC9UY3RoUjlMNVk1cEpCZzlZY3U1?=
 =?utf-8?B?M2pvK2oza2hmUE5YY2lRUGhXUVZXeVZoekpVaG84SVZUUWpCSVlicFlTUHNk?=
 =?utf-8?B?RkRmNmpaVkMrNzdFUWd1QUJNL0FSYzN4cUpkaU13clVubUhFU28wVVRSZzQw?=
 =?utf-8?B?QnQraEgxNnVDd01wSEIrUy9kVENVTG5EVERMNkJFRlpXM2NHVzB1R01KemJE?=
 =?utf-8?B?a0dYanRhZVM2Zi9UbmY4MGF3V3BFT0ZqWEVCWlRtNmtXTzZDMjY2UE9LM0NV?=
 =?utf-8?B?eHFwUnoza2NYSUpBMEpIdnFlYlVFOHgycm5vMVE0d2pXREJmOEszeUtlQzgy?=
 =?utf-8?B?QkFkZGdNYVNvOUZ1b1AzT2tKMmxGVmc1Y1h4UHFRSWFxa3M0OFhpSENLZHYw?=
 =?utf-8?B?bzJLMVg5WVU2NElNN3pOSHNtc3lYV2N6UHAwYkh2NDFrWXgzYnJVUWtVQ3Vv?=
 =?utf-8?B?dUt5dmxCazdCMEIzdDJ1RWFtWDBTOFVabTNjYThKVS9MWVphMlJXTlJyN0Zn?=
 =?utf-8?B?Y1d4OXBaVXJCMFVUQXFCMmMyUGlGOFNDblkybzMzVUR4MkNIajNmdm1vWlFo?=
 =?utf-8?B?ZUdDWmR6azZsNDZiNlo0MUh1bmc5Wmc2L3NwejJLTC9SZ3VJY2s3cUJGbnA2?=
 =?utf-8?B?NnA0bDBYekpua3dTQjZwblBEVnU0SWRCRHVjZEEreHByYVlTWm12ZDdQMG1p?=
 =?utf-8?B?c0hYSUFjdFlYS20rSDJ2NEVnbHFYM2RkTWUxNzJOZDZYb0JWOTBxUzZ3ZlRO?=
 =?utf-8?B?empPeithRUtJVTB2Y1hkQ2Z4NHJDRFhpS3ByL3k1SWZULzNjZkVWV0NzWjlW?=
 =?utf-8?B?MHhweXpsYkQ1ZFZwcDk2Mkd1WW9xTlRVcmhoZ09Wa0FnTVF3M2h6SDhHdG4z?=
 =?utf-8?B?YkVlUzNUbXI0U081VW9UOWhvRlQ4ODZRdlF2T0ZFT3hHRTB6VU96aWhnanhh?=
 =?utf-8?B?MDZoUExHRlN6N3NGcFRSd2hoR05WUis4djVCbEtIcG5iajFjMnFQc0xTOGh6?=
 =?utf-8?B?OHJQbnk2clNkT0ltVFZyVnRlakt2aFlqVmEwNS93aFczT0xFYTl2OGtSNnMv?=
 =?utf-8?B?UUxrTWIveElBUUk0Nnc2bE5QU0d0Njl0NTk5UVFJdTdrRFcwU3R0TXprV0x3?=
 =?utf-8?B?WVJrZFhVUnJNY0dxVkFHd21nZk1VYVQxbDdTN284R1VXb3B3QUhmUHdWN3ZT?=
 =?utf-8?B?bERXVkgzRGNyVE40SDArem1OSnB1SGsrMjZma0dNd0NKT29KajlTam9zbHR0?=
 =?utf-8?B?bmwvNUlwZkE0ZjdIcTBaZFRaMzRkd2xrQ2l6UHFsbFVPYm1MT1dqeTF1VXJj?=
 =?utf-8?B?Y3RYTEszWXJnb2FVZmdja08yWStJbklGM1BqaVcvdGFVZWhDaGQvS2hFcmJ0?=
 =?utf-8?B?WDRVall6TjBlelJKcFMrZCs4bnlhdTN5KzhnR2EwOUJkM0xXM3g4WXVmNmNO?=
 =?utf-8?B?WEdCRWRHRVRRMzdpM3JOK3pjYjdReHMvcDZBOVlUL0tJR0JkNnVOWVZ4RHMr?=
 =?utf-8?B?YWdPdC9zK3psWnVkcjdENlRIUTBKaFdhTDlCTStxOEVtakFvR1gyWmtXVHdh?=
 =?utf-8?B?dzB6RTUzRUhVS0xrWHFpMW95VkFsOTBBdXpMZzYvZnNlRjdHamR3ZDFzM0Jy?=
 =?utf-8?B?a2JNRzhydG5za01OVzFSdGduditNaFFjL3pKQlRsTDN1Vy81ZEhLWmlwcCtw?=
 =?utf-8?B?SGZ5Nk1Ra25vZ2FDaTZZenVIby9DejArZWUxL01ZV0cwNVFLbVgzRiswSUdQ?=
 =?utf-8?B?QzNxK0U5TkNHNDFZN3VNRGZHYTg2U2thQ21QY2pZQ095Q1F3TzVOYW45MEtm?=
 =?utf-8?B?RGVBSXZyN0I5V2xaSk5XRzFMdHFtNWFOZGRlNkZZMHZSTEtlMUFLblhJNWxX?=
 =?utf-8?B?YjlLSFJGTTc4L3pBci9ZK2UzeCtYQy9tN2svNllJSTkwdllXVTQ2dkpWMnpQ?=
 =?utf-8?Q?3hB9UlJ2ffNRQXE9km6u186sS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c31ae2-95b8-4378-55ad-08dde559e53b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 11:07:21.9720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ncRhU9rpHF5YpetWwkk+vauxP40JdZ14ZRjTbjE82L27ynFwurEz4MBTPLy2f4Bz15/yQu3PLs/50cqo2OiKg==
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
> Introduce helper vfio_pci_from_vfio_device() to transform from VFIODevice
> to VFIOPCIDevice, also to hide low level VFIO_DEVICE_TYPE_PCI type check.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Link: https://lore.kernel.org/qemu-devel/20250801023533.1458644-1-zhenzhong.duan@intel.com
> [ clg: Added documentation ]
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/pci.h       | 12 ++++++++++++
>   hw/vfio/container.c |  4 ++--
>   hw/vfio/device.c    |  2 +-
>   hw/vfio/iommufd.c   |  4 ++--
>   hw/vfio/listener.c  |  4 ++--
>   hw/vfio/pci.c       |  9 +++++++++
>   6 files changed, 28 insertions(+), 7 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

