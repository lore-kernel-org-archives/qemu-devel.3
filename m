Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FB0CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN5m-0005gJ-4B; Sat, 30 Aug 2025 11:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urrqG-0003Zb-N4
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 01:40:05 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urrqD-0000KV-LH
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 01:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756446002; x=1787982002;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/CaAw68ias+R2bsIUb2Bq1AcjjBh04TQlUkHekg+MgQ=;
 b=HRGhjiOoF6lYIklmZPOd4KhUAnKtbyBaU5KIm0exTN87Evs7UmevIZGB
 He7jkxxb8eeT4teI9cF/qw2FUUJtjTWJU0KxmDBqWSYix2UxOvPE8D188
 CrNEPgDTumxHoqip4FQNYmh3+qGQi7MrFPzjvoIE1whnpRHpVEA0doAzN
 m3/Ldndf1/7XjZ0yiwnjzVGf3jw6dk2U8JP7EVYiwnggG585DXOv8tRuw
 tLh+TfnjswAbUvgGzO2vAJDeieU1xnoco5JgjX49pMaRHiR9XxoGC8/KY
 k0dQB3bgOGXxDXqTl8z8fGxfBsjQwabvr0gQYJ+o5bQDigmcsiTioc2rw Q==;
X-CSE-ConnectionGUID: fuwWMwRFQ12rpSJl7+xliQ==
X-CSE-MsgGUID: md211P26RLyIgo/UJmu8kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="81319422"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="81319422"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 22:39:58 -0700
X-CSE-ConnectionGUID: qXzwJqeVQ46itKmw7FTBMg==
X-CSE-MsgGUID: Rsyy9r4ERmeNKQaTeLXE2g==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 22:39:57 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 22:39:56 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 22:39:56 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.82)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 22:39:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkxNWKAdFF0o6bv8czNdWmChmJRK4GLoET5JpaJllx6mtagUFCrv0pYneyvv3hOFIA1JnV4PwP/33C56nnT3CzrVNjywmSeipC7NrKW5IYn9jYJFLLoVLoxk17VKlTMKgg5O7hQPyxQx5BFW0vwmCYK6zmdVKdQQq8k22epBOKYyg2bqCO0Fpc8fItxgjwLZfixM3ij2tX5Xk1k2vdk4fsz8XsSA7fIVcQmcIYCNLDequvC/jgtNeUP3u225CPTC+EoM/fh09JoIalSVmCc7nWcQs7eoiS6jm1NVE+5OkcoT9HjyDTNkLR8sOi8YFd1/eTnLJiuLotrpk0vbXzTU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glWBtIyJluvtq3WELVEa9MI8n6TpOQjRan4MiyKBZgU=;
 b=AojvxgcIk+wQ6hFp+1W3LP7TrazQ/n/BueLDZBAzcqaaTJTPabo12+w+rcBQzrDWQWtlH2GPulnojjRGLZZxk9g3dc/m4H9KMFdib8E1n1aElQwcyOpP94D81nVEVwL9t/F79PAC/5zLhHdFYkPXyoliq0nG98Fp2bvi4Xjv5rC2fVn8NdhHaNFW/YVOvF9ZD2EB3LvpudELk2XYHx2Qmnq7MEJnrsJxWSvTQq4UpCrODcs+7xBGBZ9BbYB5+6P+nJRRYzGXdllTOxlCi1/RCryobg6y/lChpWo8GVd3+qol1wkVJUyvpnPPRloR9czylpgTZr3YwOYO49Uw5vM1eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by BL3PR11MB6483.namprd11.prod.outlook.com (2603:10b6:208:3be::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.25; Fri, 29 Aug
 2025 05:39:50 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 05:39:50 +0000
Message-ID: <0e6776f6-9094-432e-97c9-7d40e6983a39@intel.com>
Date: Fri, 29 Aug 2025 13:46:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/21] intel_iommu: Handle PASID entry addition
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-13-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250822064101.123526-13-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::18) To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|BL3PR11MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b9d163d-82de-4775-cf07-08dde6be785a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|42112799006|366016|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clIzcXo5Y05acnlYR1A4bnhMZ0o4VzJJeWRvZVlLZjliMFVjR2pCOUlrV0tG?=
 =?utf-8?B?d29Pc2xydVpvKzJaT2tlK2tBN05sczREN2g0TzdJeGZYcHZiRFhleHA0cEhY?=
 =?utf-8?B?bWZiVGpJUjYrYmg3dkExSkUyQ01DWmdvVnlVSm04eGNRcDN4dTBWakhnWEQ0?=
 =?utf-8?B?R1ozREx3dkJ4aG9nc1NSQ1dnNVBGRTltQ3FmRWFWMXZHRXA5eTZ1aVRwaCtC?=
 =?utf-8?B?K2YvclBuMEVxN2ZvY2c1Z2VybVNDM3dsRnVXWFhqei85SFZSakFSVXhrZ2tN?=
 =?utf-8?B?YnNtVURxQ1VSR3RoaW1BUXdDdjVvWWx2a3NwSWZLQkd5OXRlei9yQ1dnT3F3?=
 =?utf-8?B?L040M1AyYWJjODNCaFlvc2R6S3R1UXBuMTZrN3BXcDFlenpRdFpGMUNSKzUw?=
 =?utf-8?B?cko2aTU2MTllUEFiQWM2Q1ZHeWFTSzNVQ2xOenN6SGh1bDNIdmNySTBpaHVk?=
 =?utf-8?B?WXFsV0pHa1hxRkFKRUNoakxnZFhncmNUQnVxL3gxZlZ5UlFQYno4bHNFSXRH?=
 =?utf-8?B?dU4vc2hSVTBJRWhSTmVmUHdGUW8zb3Rtc2U4UzhFMUdEY0UvVkIxR2YySXd0?=
 =?utf-8?B?NFlvSmsxSTdueTBVN1plOFR0U3ZqUjlHQlI3SzZjdCtWQys4Q1JRbm9abXdN?=
 =?utf-8?B?RzJScGJ0S0Y0SmlJcitPdE9rdmdLb3p4cHJvNDNVd1dRYnBQR2FRNjZTRXph?=
 =?utf-8?B?dkdvZWZjUE1jRyswUDhObE1qbG90ck1xL0U1OGg1cDk4N0FsckJ6bG9MMk1G?=
 =?utf-8?B?SHR0c1MzT1pReE9WWkY3U2g1aC9GMk5IL2QxOW13ZE9IZWpodi9uNnlwWnNK?=
 =?utf-8?B?cng4MWMzRUtTa3NkeWRqTm9Oc0dXcUU0RElWRWx2Uk9VamI5S2dZV1Byd1FE?=
 =?utf-8?B?RVlwTkxVeUFxcE5iUUtBMUlSb1p5WStHcEhWa0JpUSt6RCtOMmdMSCtDL0U0?=
 =?utf-8?B?YWRiTVNaQ0tQUnpha0hhelVTZ3dHbjRMRlkzVHdMUThFMDdNbVZMNk5ZQVRQ?=
 =?utf-8?B?OHg5a3VJVSt0SHlpc0xEQjNISkRhWnA0RUpkZE1XUktZYW9yOXpHY1FhVWUy?=
 =?utf-8?B?Y2Y3blMwblhJdkR0UXZkWDkzcGJ3YllhL0gzeHdncFdDM2V5ejhLYThyS2dw?=
 =?utf-8?B?QUZmaCtGYkRIQ1dwNHBxcW94SDY0a0o3VWpEbHdyWmJ6UGVZNTVsTXk0SjZO?=
 =?utf-8?B?ODhFQm5UNncramtpdWdWM2doTlJXTkM1Mkh5S3lOc3ZycGtHWkR2aUNBWTZx?=
 =?utf-8?B?RUFsRHdrdnBSK1FiM0lqd3R0OW1JbHBRVzhnMFAzNndlSzVXTWp2Q1BXVTJj?=
 =?utf-8?B?bUQ1MUgwaUtvakJDbDhEYlJ1VTNYR1BqZVg2WkFNRFJXa1hHTU5GcTY1T0R6?=
 =?utf-8?B?akhCdUtpYTZDSWlsLzMzNVB1RjhDMXpaUmZiMVY3S1pCSnU1RkQ2UW1rSWs4?=
 =?utf-8?B?SzEyTzJBaG45THl3K1RwSDN6dUNhMmQ4YXBLWEpXdXZ4M0d6YkFwai9mWDlL?=
 =?utf-8?B?cUhGVEx2N1FzSVdVa1VWUGhBREZROEZDWVZaT0g1aVpON0owb1VlNkRzbmdy?=
 =?utf-8?B?ZS9iR2VNNHBka3p6bUR3NjNyekV6VkRRQjhoRXMyTjgvcUk0QjJYdUdlVllz?=
 =?utf-8?B?QnJ1c3lPcVpPRVoxZUtRQUZWZS9mQnFMbnBKcUg3dXMxWEw2OGp6N1l1N1k0?=
 =?utf-8?B?TGdjaUdiQ3piaVhlbDdmYm4vV0VnRU5iZ0gvenFOWUF6V2g1MGRPNXlUNUhQ?=
 =?utf-8?B?bXMxbUF1NTFkbnlGaVZnL3RXS3MvaGxubGxSdWtRSFdqekpNTDJwdmJiUXVB?=
 =?utf-8?B?c2tCQWtTL3NnOXZXa1NmTWUrVVEzaCsvSUlaY0tHbStKalp6ZlZBSURrb29E?=
 =?utf-8?B?ODlTWlVHcG8wLzBqdklLYjNZWjhncVhTR2wwWlUrbE93WXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(42112799006)(366016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1NBQXZia2ZIcGVtdlRENTFaZzJYTG83ZzVmSkk4citOaHFtdGR6VVByczV1?=
 =?utf-8?B?TnV4L2dwQjFlblhnS1BIUDhieHFZSTJ4VWdrRUVEc213YzJiYnRFU01kSkFF?=
 =?utf-8?B?S2pUYTFHWXR3ek9xWVJXbGlZbXRndWtPYjZPOVk2SG14T2tscGZrWFpBZTFa?=
 =?utf-8?B?SisxSzI3a0ljRkNSV2N5b3VMb012dnlQS0pvanFEeXkvWUIwUVRReHdPVnMz?=
 =?utf-8?B?L2JXa012cWlZWVZhWW1KVFRHVTFzTStBNVJNbjFZU3hvbWQyYnNDcXk5aXlR?=
 =?utf-8?B?Mk1LcjNMM09HaGRZRzc1cEJsL2E1dkFLckwvd0NDU2lTcnFCMFdsc0R3U05D?=
 =?utf-8?B?VDlYSmFEOHRXcTRZbG04T0JIWExGQ3FyOG80SmRCdThaRGpmYlVPbkY0bTRW?=
 =?utf-8?B?ekphaStvRUVncW1xNmFlYitsQWJGbW9WUTJpVnE0YmZDd1haKzEzazlEWHpZ?=
 =?utf-8?B?KzgvS3Z2VjhlM0RQN0lORG5VcGlxajNEOEJEU1VkK0U1MDJXNkNaQiswMVly?=
 =?utf-8?B?N1AzWmpFd2lCSWd1d2tDYU15clIzcXpMU1luKy9hWDhRUFFYY3ZReklzRzlh?=
 =?utf-8?B?bmdLSEpZVWs2cGJiNVA1U0FZR1h1VG0yT21DdUtRaVVUUDN0OGpyZXFEZUp2?=
 =?utf-8?B?cjhKOXUvbG9UUUZRa2FYT2F2SkJldEVXL25qWkZvQW1PT05JRFZzaHFUakJx?=
 =?utf-8?B?ZGF5MTQxSnB6NnQ3SFRzVU0vSUZIelNVZXNjZkJtcGR6Y0NXYjdRWVIrd1BV?=
 =?utf-8?B?bDNWQm5DdXhOUG1HZHBwUDR3WWVTNyswYmsyVDQ1OWMxcWRORDIxTXViVWhS?=
 =?utf-8?B?OVBmNGJSMTRrWVFhNGU1a3dsTWNRZEx3TTlLdzM1T3Fkd0dTbC83VFFlU3pN?=
 =?utf-8?B?Z2VvOEZrNi9TNjNmVVd3UVlUV2JYTi9kSlgra0VGa2lhR1l4WnFyQVBjNGdI?=
 =?utf-8?B?Ulk4UnpTNUx0WmdnQVZablFXRzNnN0VmclIvanBRd1B5TnBhRDVWZzFheThy?=
 =?utf-8?B?YnVVdmEydVFtbW5Db3FJS0t2U3A3ZkJxWjI4RjltMFo0VUNqeGlGRy9WTW4z?=
 =?utf-8?B?ZnRwU1daNlk5eVA3Wk5Kb0NkNXpxWVJxK2tPNktWMXVMVGlwM0hCZjRhKzMx?=
 =?utf-8?B?M1RlcXdYOVFWYUE2UTUzYVlldjkzOCsyMlROT2IzSmo0Y0RicmU0QUk3bU1I?=
 =?utf-8?B?MjVudVhBVlRORjJaSHFyQXB1U0c0MmJYUU40YzR4V0JjT2k5OCszWVYxZkRI?=
 =?utf-8?B?d2ZTdkZKT3NtQ013S2M3VndYSmFQOElaTmxkUkozeUlDbURQSmJrVzEvU0dt?=
 =?utf-8?B?NnphT0s4ZE1tREwzNm04bnUvSVJuUGx2bDNpeVQzcGNKVDRyaFJxTDNkNXdS?=
 =?utf-8?B?K2dWenB0SmRkeUpDV2VkWVJvYkV6ZC9hbzB4MUs0S1FNRFlVWGJBa0hsZkdy?=
 =?utf-8?B?bnZsdVc1eHMvU0t3c3lUNi9DNm8raytabXZGT21WMm5ENFROL01ieHNTUXlG?=
 =?utf-8?B?eXhDQ1ZSUjB0QmNndXZ5L3JoRzAyYVBXdmZ0U2ljanVXbEZpUVJzcWx5Mld1?=
 =?utf-8?B?L1kzYWYyTTNXVVEzZk8xYnp3am5tSmIzOVB1MWt1KzRNazE3M1Y2QzJpcHBz?=
 =?utf-8?B?aHlyUGJQRndISEhzcTRFNzdZaFNuQ2toOERPY0FXb3NRVEV0ZlZyV0dOeDRo?=
 =?utf-8?B?SmJMVkcxcXNqU0c1cWlqcGMrVDNieEorYkVQM1RaNmEwcVlleXFONEIyeUk5?=
 =?utf-8?B?SU9Ka2lCeXdsckwvYVcrd01VZGJwYURRaG9HNStoQmZsMnE3SXYzYW1qeC9N?=
 =?utf-8?B?dVJFL2hONUUxTEF6a2tUT2h4UkZuaUl6WUo3c3I5ZFlvYVZCaXhsOW9KZzVR?=
 =?utf-8?B?eXJhZVFnc2h0MnY0SXVmRXVjamNIZ3pXZ0NvQUQzaXQ4VUplOUxjdFRBdmRx?=
 =?utf-8?B?S1RHdXpWZzJ1N0Z2KzFDTGt1anNVYklIRGFhRklkZVVPMUNmbmtPWG0wTlN3?=
 =?utf-8?B?YXRIN3dTcDJXbVBydWc1d3ZML3k3bGpYYnFaaGZWZk1BSjlDZ3NRR1BiMXFB?=
 =?utf-8?B?V2FoRmVhY2JMVmpHa3RaUDA2dHA3UGFyd0kwa2U1WWt2d21tK1hMalhEc09E?=
 =?utf-8?Q?j5MuY6ufqMjVZf4sK4LD+CDwA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9d163d-82de-4775-cf07-08dde6be785a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:39:50.2041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QToerTqpBbKdBNUUBFoLH8orAHuYiO7E6WhYw5N3EAKwKBoiNjX6Tl6VWFcDhkyU7nmQCo1G8jtN2FpGVRflCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6483
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9; envelope-from=yi.l.liu@intel.com;
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

On 2025/8/22 14:40, Zhenzhong Duan wrote:
> When guest creates new PASID entries, QEMU will capture the guest pasid
> selective pasid cache invalidation, walk through each passthrough device
> and each pasid, when a match is found, identify an existing vtd_as or
> create a new one and update its corresponding cached pasid entry.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_internal.h |   2 +
>   hw/i386/intel_iommu.c          | 176 ++++++++++++++++++++++++++++++++-
>   2 files changed, 175 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index b9b76dd996..fb2a919e87 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -559,6 +559,7 @@ typedef struct VTDRootEntry VTDRootEntry;
>   #define VTD_CTX_ENTRY_LEGACY_SIZE     16
>   #define VTD_CTX_ENTRY_SCALABLE_SIZE   32
>   
> +#define VTD_SM_CONTEXT_ENTRY_PDTS(x)        extract64((x)->val[0], 9, 3)
>   #define VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK 0xfffff
>   #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
>   #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
> @@ -589,6 +590,7 @@ typedef struct VTDPASIDCacheInfo {
>   #define VTD_PASID_TABLE_BITS_MASK     (0x3fULL)
>   #define VTD_PASID_TABLE_INDEX(pasid)  ((pasid) & VTD_PASID_TABLE_BITS_MASK)
>   #define VTD_PASID_ENTRY_FPD           (1ULL << 1) /* Fault Processing Disable */
> +#define VTD_PASID_TBL_ENTRY_NUM       (1ULL << 6)
>   
>   /* PASID Granular Translation Type Mask */
>   #define VTD_PASID_ENTRY_P              1ULL
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index a2ee6d684e..7d2c9feae7 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -826,6 +826,11 @@ static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
>       }
>   }
>   
> +static inline uint32_t vtd_sm_ce_get_pdt_entry_num(VTDContextEntry *ce)
> +{
> +    return 1U << (VTD_SM_CONTEXT_ENTRY_PDTS(ce) + 7);
> +}
> +
>   static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
>   {
>       return pdire->val & 1;
> @@ -1647,9 +1652,9 @@ static gboolean vtd_find_as_by_sid_and_iommu_pasid(gpointer key, gpointer value,
>   }
>   
>   /* Translate iommu pasid to vtd_as */
> -static inline
> -VTDAddressSpace *vtd_as_from_iommu_pasid_locked(IntelIOMMUState *s,
> -                                                uint16_t sid, uint32_t pasid)
> +static VTDAddressSpace *vtd_as_from_iommu_pasid_locked(IntelIOMMUState *s,
> +                                                       uint16_t sid,
> +                                                       uint32_t pasid)
>   {
>       struct vtd_as_raw_key key = {
>           .sid = sid,

this hunk can be merged with the patch that introduces 
vtd_as_from_iommu_pasid_locked.

> @@ -3220,10 +3225,172 @@ remove:
>       return true;
>   }
>   
> +/*
> + * This function walks over PASID range within [start, end) in a single
> + * PASID table for entries matching @info type/did, then retrieve/create
> + * vtd_as and fill associated pasid entry cache.
> + */
> +static void vtd_sm_pasid_table_walk_one(IntelIOMMUState *s,
> +                                        dma_addr_t pt_base,
> +                                        int start,
> +                                        int end,
> +                                        VTDPASIDCacheInfo *info)
> +{
> +    VTDPASIDEntry pe;
> +    int pasid = start;
> +
> +    while (pasid < end) {
> +        if (!vtd_get_pe_in_pasid_leaf_table(s, pasid, pt_base, &pe)
> +            && vtd_pe_present(&pe)) {
> +            int bus_n = pci_bus_num(info->bus), devfn = info->devfn;
> +            uint16_t sid = PCI_BUILD_BDF(bus_n, devfn);
> +            VTDPASIDCacheEntry *pc_entry;
> +            VTDAddressSpace *vtd_as;
> +
> +            vtd_iommu_lock(s);
> +            /*
> +             * When indexed by rid2pasid, vtd_as should have been created,
> +             * e.g., by PCI subsystem. For other iommu pasid, we need to
> +             * create vtd_as dynamically. Other iommu pasid is same value
> +             * as PCI's pasid, so it's used as input of vtd_find_add_as().
> +             */
> +            vtd_as = vtd_as_from_iommu_pasid_locked(s, sid, pasid);
> +            vtd_iommu_unlock(s);
> +            if (!vtd_as) {
> +                vtd_as = vtd_find_add_as(s, info->bus, devfn, pasid);
> +            }
> +
> +            if ((info->type == VTD_PASID_CACHE_DOMSI ||
> +                 info->type == VTD_PASID_CACHE_PASIDSI) &&
> +                (info->did != VTD_SM_PASID_ENTRY_DID(&pe))) {
> +                /*
> +                 * VTD_PASID_CACHE_DOMSI and VTD_PASID_CACHE_PASIDSI
> +                 * requires domain id check. If domain id check fail,
> +                 * go to next pasid.
> +                 */
> +                pasid++;
> +                continue;
> +            }
> +
> +            pc_entry = &vtd_as->pasid_cache_entry;
> +            /*
> +             * pasid cache update and clear are handled in
> +             * vtd_flush_pasid_locked(), only care new pasid entry here.
> +             */
> +            if (!pc_entry->valid) {
> +                pc_entry->pasid_entry = pe;
> +                pc_entry->valid = true;
> +            }
> +        }
> +        pasid++;
> +    }
> +}
> +
> +/*
> + * In VT-d scalable mode translation, PASID dir + PASID table is used.

remove translation.

> + * This function aims at looping over a range of PASIDs in the given
> + * two level table to identify the pasid config in guest.
> + */
> +static void vtd_sm_pasid_table_walk(IntelIOMMUState *s,
> +                                    dma_addr_t pdt_base,
> +                                    int start, int end,
> +                                    VTDPASIDCacheInfo *info)
> +{
> +    VTDPASIDDirEntry pdire;
> +    int pasid = start;
> +    int pasid_next;
> +    dma_addr_t pt_base;
> +
> +    while (pasid < end) {
> +        pasid_next =
> +             (pasid + VTD_PASID_TBL_ENTRY_NUM) & ~(VTD_PASID_TBL_ENTRY_NUM - 1);
> +        pasid_next = pasid_next < end ? pasid_next : end;
> +
> +        if (!vtd_get_pdire_from_pdir_table(pdt_base, pasid, &pdire)
> +            && vtd_pdire_present(&pdire)) {
> +            pt_base = pdire.val & VTD_PASID_TABLE_BASE_ADDR_MASK;
> +            vtd_sm_pasid_table_walk_one(s, pt_base, pasid, pasid_next, info);
> +        }
> +        pasid = pasid_next;
> +    }
> +}
> +
> +static void vtd_replay_pasid_bind_for_dev(IntelIOMMUState *s,
> +                                          int start, int end,
> +                                          VTDPASIDCacheInfo *info)
> +{
> +    VTDContextEntry ce;
> +
> +    if (!vtd_dev_to_context_entry(s, pci_bus_num(info->bus), info->devfn,
> +                                  &ce)) {
> +        uint32_t max_pasid;
> +
> +        max_pasid = vtd_sm_ce_get_pdt_entry_num(&ce) * VTD_PASID_TBL_ENTRY_NUM;
> +        if (end > max_pasid) {
> +            end = max_pasid;
> +        }
> +        vtd_sm_pasid_table_walk(s,
> +                                VTD_CE_GET_PASID_DIR_TABLE(&ce),
> +                                start,
> +                                end,
> +                                info);
> +    }
> +}
> +
> +/*
> + * This function replays the guest pasid bindings by walking the two level
> + * guest PASID table. For each valid pasid entry, it finds or creates a
> + * vtd_as and caches pasid entry in vtd_as.
> + */
> +static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
> +                                            VTDPASIDCacheInfo *pc_info)
> +{
> +    /*
> +     * Currently only Requests-without-PASID is supported, as vIOMMU doesn't
> +     * support RPS(RID-PASID Support), pasid scope is fixed to [0, 1).

RPS is not the reason for only requests-without-PASID. RPS is 0 means
rid_pasid is fixed to be 0. While if RPS is 1, rid_pasid can be other
values. This is different with requests-with-PASID. If only aims for
supporting requests-without-PASID when RPS is 0, we may want to re-org
the code here. No need to pretend to loop a range of PASIDs just use
pasid#0 as we know rid_pasid is 0.

To me, this series should be able to support non-rid_pasid PASIDs.

> +     */
> +    int start = 0, end = 1;
> +    VTDHostIOMMUDevice *vtd_hiod;
> +    VTDPASIDCacheInfo walk_info;
> +    GHashTableIter as_it;
> +
> +    switch (pc_info->type) {
> +    case VTD_PASID_CACHE_PASIDSI:
> +        start = pc_info->pasid;
> +        end = pc_info->pasid + 1;
> +       /* fall through */
> +    case VTD_PASID_CACHE_DOMSI:
> +    case VTD_PASID_CACHE_GLOBAL_INV:
> +        /* loop all assigned devices */
> +        break;
> +    default:
> +        error_setg(&error_fatal, "invalid pc_info->type for replay");
> +    }
> +
> +    /*
> +     * In this replay, one only needs to care about the devices which are
> +     * backed by host IOMMU. Those devices have a corresponding vtd_hiod
> +     * in s->vtd_host_iommu_dev. For devices not backed by host IOMMU, it
> +     * is not necessary to replay the bindings since their cache could be
> +     * re-created in the future DMA address translation.
> +     *
> +     * VTD translation callback never accesses vtd_hiod and its corresponding
> +     * cached pasid entry, so no iommu lock needed here.
> +     */
> +    walk_info = *pc_info;
> +    g_hash_table_iter_init(&as_it, s->vtd_host_iommu_dev);
> +    while (g_hash_table_iter_next(&as_it, NULL, (void **)&vtd_hiod)) {
> +        walk_info.bus = vtd_hiod->bus;
> +        walk_info.devfn = vtd_hiod->devfn;
> +        vtd_replay_pasid_bind_for_dev(s, start, end, &walk_info);
> +    }
> +}
> +
>   /*
>    * For a PASID cache invalidation, this function handles below scenarios:
>    * a) a present cached pasid entry needs to be removed
>    * b) a present cached pasid entry needs to be updated
> + * c) a present cached pasid entry needs to be created
>    */
>   static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
>   {
> @@ -3239,6 +3406,9 @@ static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
>       g_hash_table_foreach_remove(s->vtd_address_spaces, vtd_flush_pasid_locked,
>                                   pc_info);
>       vtd_iommu_unlock(s);
> +
> +    /* c): loop all passthrough device for new pasid entries */
> +    vtd_replay_guest_pasid_bindings(s, pc_info);
>   }
>   
>   static bool vtd_process_pasid_desc(IntelIOMMUState *s,

