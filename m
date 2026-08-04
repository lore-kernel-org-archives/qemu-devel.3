Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 653E5C55172
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrAgk-0004xd-VV; Tue, 04 Aug 2026 04:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wrAge-0004xK-BJ
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 04:39:48 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wrAgc-0000vJ-Jw
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 04:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785832787; x=1817368787;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rmibb6BkWFo+mqidVAcxNp7teve5meubpXoZo6dTlRY=;
 b=aqypOhM4NytOCcLm2aaMzW2dO8cOH7q43myeGB+EU+rfViMJaUqOAp9V
 lH+ua1UArp5EW9Gj3ZVfmjbfnFOPLmDiBlQ4/IW7nsj0MBd3RWoQJC1f3
 l1LT0lbmXLAcFYn8KHvN6g0iEF4iWHjFyJ6eDxXmK1vjFnXZw+iloG2/r
 Lj85nHuu9U8v44hcrW+qfL9t7PjlmXHXnQfcdEBAQgF1s/aRUg8GR2khb
 AU01x9aRBNR7FbjWRsYm4RB9L/YbnCuxEgD67TY1xRv8LO/NWMEp2JY5A
 iRI9ruBU7u8yC5RgQsTPfyzMcwa5BHjJyCpqLeWeBbYGqkOUWsRwOjCPr Q==;
X-CSE-ConnectionGUID: 45xe3puDR3W0Y4bp2WjJ2A==
X-CSE-MsgGUID: kIaaVN7DQLG/JuuDRuVQ5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="90263843"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="90263843"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 01:39:44 -0700
X-CSE-ConnectionGUID: vEUddGwWRG6kgBPOfZY3xg==
X-CSE-MsgGUID: wAEZuNXXTtibKR7itfbB2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="260846934"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 01:39:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 01:39:43 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 01:39:43 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.26) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 01:39:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEUeI6XQi8YqtGlKE8EduW2S//e464NDtu90F5QX84KYVafZqaMgctTiLGZw6nfVr0r/8Q+bR3ymSO357b2YWPty1JL8ZJq1OARVwvuI2Z8OnsAqdIZede/FTX1/Wev2NtclIGOtRC9pnoUXBQqYFcCh4ufEJAoTk77/mU/DXMKf7X6wt7u61HxaX1c1rm+2colonsKFB0tyMKxd7dh5ABZtUjEN7J3rrsT1xalFfM2MCG1S9vsTdAeFQPhphAIayfXDwMZl5sD/k0krJNwGyaL2hTHuiQEzCSgTd65U1okd8blKM69lQ/i4yp6cg9frW9AOlWqo8Nz7vzzVsWRdzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/m+3Lh+sU7J4HpyHJVxzGbunZJDW1k9NxKVRSmgPJM=;
 b=n2bO7GswVN+PtypuuqBtsRzmg9xdKStCLsILq0FjCN97+4V9Vz66ARpSumw9de4w67UIbX8h/LIHAnBDTH6XXSeSBHegsK+UNVTX5rLQ8PGEi5pEJ5IMoFnADMaXPCIOAs5yqJgly/TgnpIaK/v2EtYgjnlp6b/pQoOlGVnoZsVzgEhhms4R/2pfQwjKggzXOiNlGsCkGKwGHe2KGXNQ0x0OkbvVssNCPRcHHjFcgitFnOOyEfBzGMEsckZwJozWx6dQuPcjL3rYAS80nJUn5LiKZntjBlu2A4OkACwIcqN9qKSR0jTmpRMaxrTg1MEsEgyzt1K3a++fHoggjZGT9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SA1PR11MB9616.namprd11.prod.outlook.com (2603:10b6:806:4c4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 08:39:41 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 08:39:41 +0000
Message-ID: <d6d2a51b-7209-448d-a2b3-deafb320cab5@intel.com>
Date: Tue, 4 Aug 2026 16:48:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] intel_iommu: Expose SMPWC when SVM is enabled
To: =?UTF-8?Q?Cl=C3=A9ment_MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowangio@gmail.com" <jasowangio@gmail.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
References: <20260802160408.645484-1-clement.mathieu--drif@bull.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260802160408.645484-1-clement.mathieu--drif@bull.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0011.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:9::6)
 To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SA1PR11MB9616:EE_
X-MS-Office365-Filtering-Correlation-Id: 478cf800-8892-4095-e95f-08def203ed50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|42112799006|23010399003|1800799024|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: pBhz3Y/uPDsrK9MO9d6w2b1bOh8+wyqPXF0jFo+smPGPIU7hBD1drEgx7c+1a8UN4Xgg3LSTN46P2gyKxd9ukKzIZSIHQG8OoVWhMqNHkJZ31iLvWpne6R3HKOiUPjgRvLjVJuuc4/Ia8hTRkTewdbnBTjnje/p/nmbBoT/mopfd3Suohl1Z6ItgxFNtUyXqWuW+5nva7i+55Qgi3RRZERv5WcW2D10eaAR9Zh4SC+C6neYqlNhuG/VeVQQxjf8EM8uRQrlkv0rSGXB/snAu0R0w3VwP9Yufd+nwYPRaLJwsRxFcRky4jSbbCMm2rG4oNYwM3rWCxnVDFQKfHDW77Tmle3Mp8drgmcsknI0a/Wc+uJpaDJ0rB6rcomhiKAATZ/G576tbHJ02jfWbKhpe9qKqGZAeWJAwkrgdhtP2XWsUiVVS72tbQygFwd4AFTbBENAK5wPbReub0MY9Tn7My/Ha0y49urDzLiRKGDd6wOWz64HzP2tIuWLQE4jB/8TLZ6CGwsrv9O0Rmb+rzY73wnH/eTzOdehB/gh/IwXAf91DeA2jeoAmm07vkPnSpFnvF+SxmR7XF8Jw13qroKPIT6PZDjY6wvwLAiXZniqEDwks100MeaZC7vdmpY58VqkZ1LjiAFFD7Rrwk2dC5tDBdwbX/KGxpNzdS0p0BlT83Ho=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(42112799006)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTV0UkxaT1ZaQlArbG1zSVhaeSsxV1JHVUpCUXpad211bmRxeEMwZGNmRkFm?=
 =?utf-8?B?MjFUTUJCNHJma3FrVjhLNDRNbTJrYmN5L29McTl2NjJvSTJPV0ppUkFUWWIz?=
 =?utf-8?B?TmNrVi9IeE9NbHFPWVllTm01bU1JV3ZBQXdzcURRZGJ4eHpsNE93bXBXaHVQ?=
 =?utf-8?B?WVF0cHVKZGVERnVxRnpsLzdRSUtEREwyNVhwQWNqbWhyNkJSS0VQbWx3RTRL?=
 =?utf-8?B?azhkbnFWbmo0RWdvMWZjWjNTY2ozYjdXM1IyVU1pMmMrR3k0aXJpaXdHR2VQ?=
 =?utf-8?B?TU56ejlISlBkV3lGYTdIWGYyZ1Y5bXJ0MjVqTzV5a0xxMk01bThFeCs2d294?=
 =?utf-8?B?amJjdG9RbFNKb3I0M21HWVZtcTd0QzNEU0Z5cTFibzBSdSsvMW5iOXhQdEhK?=
 =?utf-8?B?RFVqTDYxWWFRbThFNkoxaFBRb0x6djdtYjdQa2tQYmtpVmsxRnc1cVRHcXg1?=
 =?utf-8?B?WTVHcVhVaTdhcElWOGtka2Yzb2p3UTl6MVZMMjhhLytiTkhLUFJHdUhTMENj?=
 =?utf-8?B?alduZ3ZCQzJOYzgzRVUweDB4Mm5SQ3ErakNhOU1Rd2NnWmk1OFJmZlJEdnNv?=
 =?utf-8?B?dkJQK1RnNkJoK3RaZFd6RStWdUpBaG5hbUNQa0JZOHNyQVVIVTVEbGhKN2hv?=
 =?utf-8?B?cGRnMHQrYlBsVnB6TnJob1R3NC9lYmU3Z1hTU2Zma2d4M0ljZldnZWxGMFZQ?=
 =?utf-8?B?T2lpMXJ6T3ZKWmVKRUs5WkdZTnlJREwvbzYrK3JFTFRKNGFsVDBBYUl5ejJQ?=
 =?utf-8?B?STd0VGNMMXI1cTFxUVdoaVU4NVRVNnhBbUpPSDRIRDZ5QWZsUDF4d2c2VEhS?=
 =?utf-8?B?WXViZFhOT1hwRWozditsMjdoSU1QdkRMWUJhWEUzWld6R3lrTW0zRnVzdFFr?=
 =?utf-8?B?ZWQwSFU4WVdBbmNBVlY0OStsY2hKN05CSHcvWHQzcll3czlBSUhMV1RkWUhC?=
 =?utf-8?B?S1NXSUd2eERxSkhlazdOU3kzQXJtY3NOZytwM1g3eUg5VEd3MmVEMkdieFlz?=
 =?utf-8?B?WHNrUHQvRVFqYStHemJwSHhKbE9GVzZ5QXRsSnlaSVZXa0VIcitnSE5TSVk1?=
 =?utf-8?B?Q3Q0SjFlMkVNL3RkUW1YKzZoMDArTmJrUjNKVStvMkNpQnRiT0Z6TXh5dytL?=
 =?utf-8?B?MHhrbzJrWDRITTcwOWFqbWxlQ2JVb2pQTlJaMjVOUkhtTjljZkY4ME91Y1gy?=
 =?utf-8?B?aURqUUFxSmYxVkR3ZC83REtucllZK3FGbnNKNkM3REtuanNzT3JOSXZuNHdt?=
 =?utf-8?B?Y01UZy9kSHJhVE5obFJtOVZNQnk4NnZrSWVnMFZjRExzTlNtTTVuTHpqR1Bn?=
 =?utf-8?B?Z2hYWVUzTXAyQ0Nyd2xYR2tkSXpYcGp2OTJIQW1mMitCR3Z6VTNma0hNN0RL?=
 =?utf-8?B?cWRTUWZ4TlE0T2FoT1gxVko3OFIrSlY5ZEQ3S1RGcWVvc3pIRVNybXRNbzRR?=
 =?utf-8?B?N0RYZzZaMlgrZTNTb1Zqa1ZTZFhGbnRDa29jQTBlQWxxL3lOazdyQUtaZ1N5?=
 =?utf-8?B?TVpDZ0Z4czNNODFSak42SUFBTTlVK1RRWitNWHpqdThnTkloNVBaK1crbTB6?=
 =?utf-8?B?VlZjVzJ1TDU1TC90em53Z3RBbzFETnFlZi9jekpBYU9DTXZkUmJ1UmxuTUFG?=
 =?utf-8?B?NFE4RHVOUFpCbmxkZVRkV2hKZVlvVGhIb3BhdmZMSkxML2VDYUdEWTFQZk5s?=
 =?utf-8?B?S1poalJld2xDM2p4UkFhUU9yZGgrYWlwUGxDajN0cko2Mmtlb0N0WmpHNEpN?=
 =?utf-8?B?dEl3WVhnNnprNzFlTm80cHJ1QnZ5UHlTeXJQejAzeDNaK3lhbFY5WDVnZUNZ?=
 =?utf-8?B?TVczQUhMZFdSQWxTWUN1ZCtsUklVekQ0TmRiREZyVlQrQUJ1QlZNR1BNdjVZ?=
 =?utf-8?B?YURDMXE3VFlNalJEQitjMDFqT0tzQ0Z0Wk9qNUp3V2dYSXVHbmdkSlNZb09R?=
 =?utf-8?B?UmdZd3N4czlRNUY3b0FpUkc5VTAzV3BqcktEdUYvYWxOeDFqV1cwS0FRNFpk?=
 =?utf-8?B?a1NZWXk4akd0cVpKQ0pEd0RHY1RHMHBjblQ2eHo2VThkQUx3RjNqYzNxM1d4?=
 =?utf-8?B?NnpCOVF2TUlYSW1DRXlpWDlINCtldFp3U1FJTUdkOUlBVXV4L2ZiU21RM1Jv?=
 =?utf-8?B?clNocHhvZC9yWitFYVlZK25EUVdOKzBUbGx3M2ZkdTNNRVFNMWVNUjkyVEh5?=
 =?utf-8?B?bm1kR1NZKzRWSFd0MjlkcU12Z3RXbHdSY0tXWW1kT29UNVltUzFHbHh3OHRk?=
 =?utf-8?B?TlQ4Y1g2TnhEekhmeDRRSnkxNit2dmM5bjF5WUtHSzlya3BxeFBUWEhGdDZR?=
 =?utf-8?B?eGpRekVqNHpORGJBWkVQSmEwaHFoN1dieHY5V1ZvV0lJeDNMR25tdz09?=
X-Exchange-RoutingPolicyChecked: pMXx9+YdarfbNuknAN/DBzTam8OWqkk6uh2K0kbpTyEt0Dc0zXoNmpir3UxflLt2ldL+eMmb8WwyPNAPp3xjlyt1rDHDDEQ2NTojbavD1SS/o8b9a7odXlpyX9+fjYeaX7TmnRH8HVT7eAkjgGJRPobNlOk7nFStpacqi6PZ7A/JyIeRQ7GAquRkI4w6wYbxdURfIlv6KT0Uac+z7QLA2xKaYDoAqX7aO7f71pTx0tHHHr/bxJa0WmiSyND3dEZsifKAJeaSXVTjc74X20plUkXwXCBjZt9+SzFMwLGjXYO1Va+GlD6NUpNNLcuBv4kkYC9iUNYyolAJI0WxOg90zA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 478cf800-8892-4095-e95f-08def203ed50
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 08:39:41.6755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XOMSXOsKoqMOrGB+ZEh9y8SLJ86kx6TWEboJVZE/7BqJS0sXiRXzkke0J5Nrh/7gcaIusbBN7h1LkDtrkSIl1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9616
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 8/3/26 00:05, Clément MATHIEU--DRIF wrote:
> SVM in Linux requires SMPWC as of 780dfed68862. This is free in the
> current implementation as it is already in line with the expected
> behaviour.
> 
> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
> ---
>   hw/i386/intel_iommu.c          | 3 ++-
>   hw/i386/intel_iommu_internal.h | 1 +
>   2 files changed, 3 insertions(+), 1 deletion(-)

Is it a fix tag needed?

> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 8245452d89..9f21622a4f 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -5108,7 +5108,8 @@ static void vtd_init(IntelIOMMUState *s)
>       }
>   
>       if (s->svm) {
> -        s->ecap |= VTD_ECAP_PRS | VTD_ECAP_PDS | VTD_ECAP_NWFS;
> +        s->ecap |= VTD_ECAP_PRS | VTD_ECAP_PDS | VTD_ECAP_NWFS |
> +                   VTD_ECAP_SMPWCS;
>       }
>   
>       vtd_reset_caches(s);
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 924e91cb8a..df7a0efa6e 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -202,6 +202,7 @@
>   #define VTD_ECAP_SMTS               (1ULL << 43)
>   #define VTD_ECAP_SSTS               (1ULL << 46)
>   #define VTD_ECAP_FSTS               (1ULL << 47)
> +#define VTD_ECAP_SMPWCS             (1ULL << 48)
>   
>   /* CAP_REG */
>   /* (offset >> 4) << 24 */


