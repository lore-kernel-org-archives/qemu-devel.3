Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C49C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 07:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR4LK-0000wb-5J; Mon, 16 Jun 2025 03:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uR4Km-0000tu-Kb
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 03:32:55 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uR4Kk-0003Ay-Hn
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 03:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750059167; x=1781595167;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=unes1kELpbvrc0frMDIe7XVRojA3hwD4nYlGg4vDsXg=;
 b=Il6DPu1Q4RVVg5kS8Je2UwW2GyCS3v7lPFsSc4o+9T938+zPYlZevXXc
 wX3s2Y4I2YfxKOP9ee9nvERzKgttwaR2aaZYlkX788em3c8Hc2Ei5ltlr
 9A6ZpyL58AcoQt1Nd17m8gQSUOzjChDnz8mgKbUdYfQbuAnVc9lAKVwiQ
 RLJ8M50QBmWZVC9MJlxiOvDTeoqJmOdKzP/4zWdG4jgXJ/k7y3lL2PB1A
 u5zTIZftduhFoTknsfbHDuw0pUFLufrJf9SFqDfvelX69dWAVhnNmwGo2
 V2ADiphajmcMI99c+faW7ChvScPn7WLNkSxOtIckG2DLUgD4/SibhaMAw g==;
X-CSE-ConnectionGUID: zc9jHXNQT1iu0zV0Zqq86w==
X-CSE-MsgGUID: SssVSBp5S1eSKAnVmr5TUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52064111"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; d="scan'208";a="52064111"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 00:32:42 -0700
X-CSE-ConnectionGUID: pU5DIBVPTza4yVGTWy5cQw==
X-CSE-MsgGUID: xKD3HZmZQsaJX8+wo9fWVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; d="scan'208";a="152225563"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 00:32:41 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 00:32:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 00:32:40 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.73)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 00:32:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icplH9X6yynLy4dfJMNeaIw1vu328EaklLrQyc1rM7Xv49v4RHo4916F38t0UriVGJCeOAnykGsYtxJDz+vornin8POWQvgBk5A5nLl5SMlEkbuI7yN4+bc/BmRNURYP0859J9VRjfwrBX9555BKsBVgzwBURdH+UPWHLhiVkX9fb/CXhPnp6kLLw76nTVm7A3gkddtBrSRPK15iDMC+KyqCxzO+3xlJfftThv6FtsxDwGoLtuzqJXy6LIlQbTqo9Bv9Hfh72MzT2ACKp6tGWZyX1+2ywu4BPnyvGVZy5f966iKFXzceQ8KB9RidpSRyQG5hluabFJHqDYON9L/CPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlG8O/Nr4BzRtPpLCCN2Mkjlzz9KRfCg7X/Q7jfCyAg=;
 b=M5jANXbTv1AkGPda7cSTGkGMAQw2seF1kuMkquhNAIr3ChyrLxk5BUlpaytn0cbvsZ+r+cgvQXI211rmx8fWu49Ws8hJHHH7azzEtjK4zR2k6kFP6fvi9dM567wqNju6NGqyuOgZpOYyTI3f2JG+u6IVJQenWybFaXtsn+WIRna63nm4NF/60PqZbdbYSFbOo1kXJF+NOla4XH/+K1wmKzKCNeRfBrkI7UwuvNKs2Hk0XCudsIx56sHYJ9ynjoq0z+nPAnv3sYQ7uhV77Hy/v2vHp34n3tw6sfpmxz0swwCI7DrK4mFseXsK8NKqgOc8+tH7G6+hvnQg7bcm0NO0Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CH3PR11MB8773.namprd11.prod.outlook.com (2603:10b6:610:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 07:32:19 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%7]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 07:32:19 +0000
Message-ID: <6f0cb11d-ab12-4ae1-98d0-eb44bb0a7f4f@intel.com>
Date: Mon, 16 Jun 2025 15:38:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, Peter Xu
 <peterx@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-16-zhenzhong.duan@intel.com>
 <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
 <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
 <aDDk1NYwJXaAdUQI@Asurada-Nvidia>
 <29f5f434-1fe3-4b5e-91d1-f153e1e98602@intel.com>
 <aDSmcvZ08jNOSr05@Asurada-Nvidia>
 <SJ0PR11MB6744340B889FF65D3BD5B8459267A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <f6baaea1-a60c-41dc-a9a8-d2389ed14679@intel.com>
 <aE+yvI2clKEZyoyz@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <aE+yvI2clKEZyoyz@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0165.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::21) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CH3PR11MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c37ef49-7dbc-49ad-8bbc-08ddaca7ed1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M05vZi9NR1BtVSsvY1Vhb2JpenJBcGhVdHNzckNDZVhnYjlkajRaM1hQMkFj?=
 =?utf-8?B?TkVTYzA0VW9wY3VBV21KVHBRbk9ybGZMalZjZDFaR0RvOWNKY1UzYWM0OGtX?=
 =?utf-8?B?TFl1WFhVR0pxdU52dUxjd3ZiR3JHalhnZ0RmejZMMWFGSjF6Q1dPZitYUTZo?=
 =?utf-8?B?T0w5WU1SdHFUeERVOHJTZEYyNS8vRGxTNHMwVmhyM0lNaUFiU2R0VzlETWVw?=
 =?utf-8?B?M2F5b05CcnZDSnpacGk1T3hzWDlGNlY3aXFiMlRVUUxHdVUrTXZ4MlRFSU50?=
 =?utf-8?B?Rm9QRzEyWTV1c3ZtUTYvUFY5SDdEVTZRMkROYWdkaWswMEFFTHdPN3Jnbmsv?=
 =?utf-8?B?aHkwdGk0bE5xQ2NIdDNteUVOMXRUdW5vSVBzN2U4T1NNWi9ZQjRPbmdveFRu?=
 =?utf-8?B?Y1d0alIzL3d1UnpKL2ZjNHRObGhEeHpwNGNqWllOMXg3eDVMYU9UcFJIQlJY?=
 =?utf-8?B?M3lsVXhaOWM4SW5LODArQldPTGFMS0xpOXlMd0FHYndraHFXUlh3ZDlzNkVh?=
 =?utf-8?B?QktKWldYY1BlYXEreVNPdEEzU0kyZVd0aC80RW1vQVQ2Vm1JcW1zaXdCeHVo?=
 =?utf-8?B?RkdnREhEYzdVY2ppRDY0cEF0RTM0QVYwYktnZ1QxN0pMdUVDV3AvbldtSmxQ?=
 =?utf-8?B?M0hISmhwNkFYZXAySFBhVCtVRVIvNENmQzNuNHo3ZFVzSVZiZUdqTEFGcmpY?=
 =?utf-8?B?cEU0RDZnWDJhK2ZqWXpEL1c3U2hCV2VZRFhWOVJBMjRUcmdxbHlZanJwTks4?=
 =?utf-8?B?a3h0bnNnZC9WUTRnYlcyWnllT3BuL2FkQ0liWllFNkNFTEc0eUJiRlQ1WGZZ?=
 =?utf-8?B?YjhXNENOeTZLVFcreVoxQndlZVA1QkM4T29kU0FSTGdLcEU2V2gwODlyaHJD?=
 =?utf-8?B?K09HekxtUENtaXpTQjFQTXRKaW1JSm1TcVlJMkZYREprL1hmY0JYTUFaMTdM?=
 =?utf-8?B?dXZ6SUYyVTB3UWVYTVJkSjRKNWp0YnJVbTFyalVxUHFUUGlTR3ErV1VrWWND?=
 =?utf-8?B?d1lVam8xaEh5dlZEMmw0c1pYd3FKNnJFTGlsMnJxeHptblNWYlRTSDBxRVpt?=
 =?utf-8?B?MXVYNFZIWnFYV3NBY04zbkNiUGs4dzdMMTh3dVhZbkVpYnArbXBGcStGZ1FJ?=
 =?utf-8?B?QXBFaGx5RnB5UVQ2cUFOMXJOaisvYm14OHQ1dk4vZVMvc0hyZitaa24rdi8v?=
 =?utf-8?B?OXBIWTRGYUdLdGRoWmY2emNiUHNXQ0xJUzVraXdsc0hYYzFMNGdaaXcza0JI?=
 =?utf-8?B?bnQxRVVOakVVUlVzcUlOeW5DR0ZQZ2t4cDV5MnMvNGE1YkFBbnlvNlJ4Zk95?=
 =?utf-8?B?RldyRXI2b2hCTzhmcGlUMFlSNEw1QjVaQkFNM05kT1lEdDFYS1BrRG9xbzNr?=
 =?utf-8?B?UndVZmx4LzdRSjBER0Vab0xZajhsTll4Z05oMTVSazZEdEFsNmdyS0RwRldz?=
 =?utf-8?B?UkxvV3VUd2RDUnFwbUh2S1ZxN1RLMGVFa2ZYRERxSUtES3BOcWtHckFvVklC?=
 =?utf-8?B?Wlhpa3lvZkRxVE1RV2VheUtmOHlSanllODlrQWNVQWt3M2d4dlI5ZnBvcFBn?=
 =?utf-8?B?NVZ2S2hWbzIzMlh6c3puOFV5dmx1OGZOM3FaN2ZGSjRnRWxLMG9EcTBVMXRj?=
 =?utf-8?B?ZWFUbGVjMERzdTdnak9FYmROaWp5SnNCa0lpMXYyOVlEM2lpQWlOdmtFREsv?=
 =?utf-8?B?c2VGRkR2Q0l1SUFEb1ZPajVvVXVaV21LZWl3VFdCcGRwbkpNaXZGaTVJdUZ3?=
 =?utf-8?B?RmxKVnNmcmVEcFlkU1I3dmg4SFU2SmE1b216K21HYVRCYUZ1Q015N1JkVjV0?=
 =?utf-8?B?RG5TVXNjUkp5b2xVUHVkRkpDbmFQYVhQM2wzeE0wMHNiMUJKOGttRWpZdUFp?=
 =?utf-8?B?S3RXenBmRVBoV0tmMVdJbEpJV1RDMlRZdFNERXYwMmIwbkI5ZVJ0aVM3eXlp?=
 =?utf-8?Q?vhsZ9P1I+zU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXFTblcybUl3cVVwSS9YOGNQTGw1cmtzcHgwOE84aTRpdld1RVFMS203Z3Zr?=
 =?utf-8?B?aXRJTklyNFllQktXb3doNGFiK3lvNmZ2SFdIZ2crN29HbEdadUpzTkVXd3Zx?=
 =?utf-8?B?NVN4ODBrZ1VwbFpsV2NTaHhrOUZlSTlMU0FTNEhUdGszSlZkWmdtbDVJb0VG?=
 =?utf-8?B?OXladUNJL1JrNEtjVStuNkd3RVNXWkVDQWhIUnBQa3EzQVZyNkxSdGxONldK?=
 =?utf-8?B?L1JWeFlwVmhseGlyVlpac2ZHODlEZk9ndjdIalRjdk5mQVlSTWp1VkhaNzNY?=
 =?utf-8?B?NHBoRmttTUlNR1lEUW5wYlNXSTN5blptOFN1SFpzS28yajFiZlZZRzJSbnhN?=
 =?utf-8?B?WFlpSEpsWGFrRUJ5UWVKMXdvbk9COXBMNlJQUjJXK0NDM2NqWVc5SXhXRTVN?=
 =?utf-8?B?dGU1c2VoWGFZZnVrT0gzc3RGNi93bkNtMjBkcjlxSlFoQjk3aU9tMDNDeG1G?=
 =?utf-8?B?Qk5QZkl6djRQT2ViYk16MkVSa0tTNW85blJHYkhrd2RuZHJzdWcwSzFDdnpL?=
 =?utf-8?B?YlRLVzQydTI4RGJHWStUUTkydHp2RlV0Q0JqYjcxdlpvYVNqZElrT3RJMzRs?=
 =?utf-8?B?bCswcUhOcm5YM0RJVVBKM3p4VW03bnZtZXJid2l3VlNRMGUwMG56RU9QVU1m?=
 =?utf-8?B?MThwT2FRQ29XMGZ2RFRJOTZFU0RIQU5vWVpIOVZpemZqTXV2ZHZHelNUaERQ?=
 =?utf-8?B?RFJCd0V1U0oxN2U2c0ZYR0ZxWU92VXlZcWRoV2ZzU3dPaE9Zck90OC9KS2to?=
 =?utf-8?B?TGFwN3BQRVpCdGNGWmR0R3dUM0o0OXkxcVd0djFTL1cxU1hud0g0SGFsSEM4?=
 =?utf-8?B?YllOaFVNRHBWdS8vRklhVUQ1dGo2eXVXMW80NE9CTlc2OEdxQS9ScTVyNTZK?=
 =?utf-8?B?VVVUYWxsWkQ2MnZBM2paUXk3OXV0ciswN096dFI0bkxDbmg0K214ekxVK0ta?=
 =?utf-8?B?UjhLUUhrZHRKL2swNUwwR0JzZ2FIQXNlUzQ4VDVRT1libHRmMVBuZER3bnVS?=
 =?utf-8?B?czZQUlhaUHpWUzA4VnJhcWpHZ1AyODBFY01vWFRCMHl2T0JwQStsQnRENngr?=
 =?utf-8?B?YjdQZldSZTc4MUovRkhxdjJFYUxKR25ISWpZaHNZQ0FEREM2Z0pjb3YzODUw?=
 =?utf-8?B?TDlabE83bWMrZDF2VnBoMklKY0tyaCsra1NqUU1rOXZvc3QwaUdMeisvWXhD?=
 =?utf-8?B?TElvRXcreVJPalc4dUtIdUZTd1UzRDhOR1RtTEFHblMxNW05d2JQcE9QZmRY?=
 =?utf-8?B?eUFGSW8rRGcrc1d5UVEvaWx0OE1uVVVzWGx1MDRjSHVjMnhNRTB0dWNxajR0?=
 =?utf-8?B?Rlp5U3VYQ3d4Slk2NXkrSFp1d3Q5Mkk2U0ZJTWFUOEJ3NjZ6NkgzWWs4SzZD?=
 =?utf-8?B?YW1rNXJCVlozUlBtWnYySm5IYm01MHpmWk9WNDE4QlgrSFN2dmU1WTdyYUdB?=
 =?utf-8?B?QzdMeDB0T3FMaVFZVHR1NTRrTjhPVCsvb3NVdzdkaGhDRjdjYkMrdzBHM0Jw?=
 =?utf-8?B?NFI0UldQQjgzd0M2cHYvMWg0VnRTbW53YzlMRi9nNDNLNmk0NkNtV2VkM1pq?=
 =?utf-8?B?cVpzU1Q0OW5KZlNyWk0xT1RkekdrclNQOHkyWWVNc0Q2bjRObmtwc0hrWlVT?=
 =?utf-8?B?TGlBZjJtTlVDcjFLUlZtYmZaa3VpR2RQR0NtME9GRjFhSUpwcGNqQU5VbGIr?=
 =?utf-8?B?bGg3dC8yRDZWa1UyZ09Lc2xYaFRSSEIwU0twelovZDdKczlGMFAxVGNCeUZw?=
 =?utf-8?B?eVdBQU1PT2JIV1pIdGxVMUxqb3UxRTl1cTNST1dHdWoxRW9hYW5KRGFmSnd4?=
 =?utf-8?B?eXRvS1p0Z20yMVUxRzNiT2psM0NnSVVZYWM1MGtlRDIzbjhFRWwwdkxDZksv?=
 =?utf-8?B?Zi9JS2NwZjAxN0lsMlNybHJ5eWUxOVF4d0Y4ejZMSmk1U1JkeURFM2dmTnpD?=
 =?utf-8?B?QUZzcWJWSVlPcitleHdRUjNXak5mWWVyVXYvUUJTTHptSUtRSmZzeUovaUhi?=
 =?utf-8?B?VXNUTXVhdHo3SnBLQUhXZWo4L2FLOTNKU3oyN3hRRFpTZGZtKzRoQVFyelkz?=
 =?utf-8?B?bG5uWC9UWjZDRmIzK3ZMMFJFQWZoL2YrbStvbE1yWkN1V0FtQitKeHdPR2NM?=
 =?utf-8?Q?TMHDqChy7TeQ79xFOp1/JO3y7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c37ef49-7dbc-49ad-8bbc-08ddaca7ed1e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 07:32:19.7243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ru6ZLv5W3pQM8JY/VYxIYE9CI3BYac5FdEP41Cphbl2J18KdY4JhDSNzWffwwDhuWpFzD9tRR6DjNG9LP6Grg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8773
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21; envelope-from=yi.l.liu@intel.com;
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

On 2025/6/16 13:59, Nicolin Chen wrote:
> On Thu, Jun 12, 2025 at 08:53:40PM +0800, Yi Liu wrote:
>>>> That being said, IOMMU_NOTIFIER_IOTLB_EVENTS should not be needed
>>>> for passthrough devices, right?
>>>
>>> No, even if x-flts=on is configured in QEMU cmdline, that only mean virtual vtd
>>> supports stage-1 translation, guest still can choose to run in legacy mode(stage2),
>>> e.g., with kernel cmdline intel_iommu=on,sm_off
>>>
>>> So before guest run, we don't know which kind of page table either stage1 or stage2
>>> for this VFIO device by guest. So we have to use iommu AS to catch stage2's MAP event
>>> if guest choose stage2.
>>
>> @Zheznzhong, if guest decides to use legacy mode then vIOMMU should switch
>> the MRs of the device's AS, hence the IOAS created by VFIO container would
>> be switched to using the IOMMU_NOTIFIER_IOTLB_EVENTS since the MR is
>> switched to IOMMU MR. So it should be able to support shadowing the guest
>> IO page table. Hence, this should not be a problem.
>>
>> @Nicolin, I think your major point is making the VFIO container IOAS as a
>> GPA IOAS (always return system AS in get_address_space op) and reusing it
>> when setting nested translation. Is it? I think it should work if:
>> 1) we can let the vfio memory listener filter out the RO pages per vIOMMU's
>>     request.
> 
> Yes.
> 
>> But I don't want the get_address_space op always return system
>>     AS as the reason mentioned by Zhenzhong above.
> 
> So, you mean the VT-d model would need a runtime notification to
> switch the address space of the VFIO ioas?

It's not a notification. It's done by switching AS. Detail can be found
in vtd_switch_address_space().

> TBH, I am still unclear how many cases the VT-d model would need
> support here :-/
 >
>> 2) we can disallow emulated/passthru devices behind the same pcie-pci
>>     bridge[1]. For emulated devices, AS should switch to iommu MR, while for
>>     passthru devices, it needs the AS stick with the system MR hence be able
>>     to keep the VFIO container IOAS as a GPA IOAS. To support this, let AS
>>     switch to iommu MR and have a separate GPA IOAS is needed. This separate
>>     GPA IOAS can be shared by all the passthru devices.
> 
> Yea, ARM is doing in a similar way.
> 
>> So basically, we are ok with your idea. But we should decide if it is
>> necessary to support the topology in 2). I think this is a general
>> question. TBH. I don't have much information to judge if it is valuable.
>> Perhaps, let's hear from more people.
> 
> I would be okay if VT-d decides to move on with its own listener,
> if it turns out to be the relatively better case. But for ARM, I'd
> like to see we can reuse the VFIO container IOAS.

I didn't see a problem so far on this part. Have you seen any?

-- 
Regards,
Yi Liu

