Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70831C7114A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 06:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRQ2e-0004us-TS; Tue, 17 Jun 2025 02:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uRQ2d-0004ui-Lt
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 02:43:31 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uRQ2a-0004KL-Mv
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 02:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750142609; x=1781678609;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ms84QyHz65/WI2nW4PV/cLZ2d0rUzFPUnKntO8yZ1TQ=;
 b=OnXtISl+JJpKiQ77gxEyNO+liltbBnzR2FOjSE1gyuUfb9oa5BfbUJwN
 Q47TJxQAhwfF9PcbVQnwHgDnkCHHzqUD9Cax5s+OJyzeRbICGZ60nlFMA
 US5GmO2acj/ddF6FtRJiGNCVqA0OMi3SC/xAooGJbuKOOjt7cBuxh/Jz8
 YP5ep7F3gpjvgWXKbrvb5/OTh5Yh/zno1zK8tJcg5G96Eg4gpu5azCTaO
 l2odzerHcgAJiEzpeWnGlKiL3XWF4hpBKsjx0OB//vCafy7crzVqx1xgC
 k3cr3qtwW9XC3wIYlhgeWHuWoxoLWLD4L3VXm4bdHah36lsqMrj4armUg w==;
X-CSE-ConnectionGUID: JcchA+/1QtGjUjJA2bl8qA==
X-CSE-MsgGUID: I3+kuYdjRcebxkgI0goPEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="51527854"
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="51527854"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 23:43:25 -0700
X-CSE-ConnectionGUID: pRYT/YykRPSE7RQazKKYfg==
X-CSE-MsgGUID: YQ46jm4PRDKtZ2OfRe11Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="148676304"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 23:43:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 23:43:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 23:43:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.67)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 23:43:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHdOgeHX2EaG5l+7Eh1Hb+B5yVgxLQIcNpKcY/S2FyNS8lnTLha0TvatpOT4tbrsi6uwiaAuqI/qCJ0KDB21cLNbAox9B8Fy/k7nEGBcg0tN7OX9XN8GcGfMLkAx4HbC9o4lqiaSbjOI8XXNw5c5MAnlc1lvB1kIw2mF2hzTHTGs8/F3B8HOO7ZUYYUv7f5hXgc1JadpQUJDNX89lA8nTVaymc0ory8gz1XfQ8EJaSJnMKBJGsylWFcaA7/1R7Z7arzLA83SZivHQV3+VgxI2gOTGjoF5KP0wilxhfQ5WTP72BUHnLlYga9JGvRRslUyl7zVMu8TU/UiPO4LAPo0bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcYajj+WlmRwmYq7R6HQ6e1G4Lmb8J8ZHNQFafOMoxA=;
 b=yhMFET4k81yslvD1OmHEPO1YFn5JtqX6Gy26EeFAndDm8XwCb1n+E+8WHHIrWEzt5rXiRulz9Rok3nkVAJEmdpGaIbjTyyF/AkUiThfpHMZb84jbDNReBzu2IW4w5OMvhIWkRav8IjoSbpmcc/QR3hv6zkIm4ipBKPUk24Z3MRh9RvSHUg1c8x0aCwXcqm2LNGCgPaGo7mDPXY3M3fCAA6wtWyqG893k1IUEoaHsZFnIMYtVS4OgetoaR3Mjp1wJ15VzcllxkKcOrLut0nyvOeQHvghCjcpObEl+IiytAeVAdMonw8P+wVNHTizTPZUJN13oQqXxdWL9zmGIZSc6JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by LV8PR11MB8723.namprd11.prod.outlook.com (2603:10b6:408:1f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 06:42:52 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%7]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 06:42:52 +0000
Message-ID: <b3d31287-4de5-4e0e-a81b-99f82edd5bcc@intel.com>
Date: Tue, 17 Jun 2025 14:48:58 +0800
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
References: <20250521111452.3316354-16-zhenzhong.duan@intel.com>
 <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
 <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
 <aDDk1NYwJXaAdUQI@Asurada-Nvidia>
 <29f5f434-1fe3-4b5e-91d1-f153e1e98602@intel.com>
 <aDSmcvZ08jNOSr05@Asurada-Nvidia>
 <SJ0PR11MB6744340B889FF65D3BD5B8459267A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <f6baaea1-a60c-41dc-a9a8-d2389ed14679@intel.com>
 <aE+yvI2clKEZyoyz@nvidia.com>
 <6f0cb11d-ab12-4ae1-98d0-eb44bb0a7f4f@intel.com>
 <aFDfhI0zScBhy01j@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <aFDfhI0zScBhy01j@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::31) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|LV8PR11MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a70098c-1831-4cc4-2ba8-08ddad6a2eb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2cyam9wdGh5T0J4Z1RRSnprdGRmNjl4blpQc2piRkNJNXhsQzYvVGhFaG9N?=
 =?utf-8?B?Y0dtUldYb01CeEhTK3FOTDNtcFZ2ZERUbXdpdkttUkRZa2lDaWVEQWdlZkJv?=
 =?utf-8?B?cVRnNEJ4T1FJcHRjSFBtQSs3OHdEZXFzTjRLanRiSzA5em5CQjR3UVNtZEZD?=
 =?utf-8?B?aW1TV0RKSWJKTHpXZDdMV0hQV3NOajMwb3htQmtiby82VUZLSGxDTU5DWkN6?=
 =?utf-8?B?V3MwZjdMWlBWd2hqVEhEckJDTThoWGFrd2RLSzY2M3Nla1RoTUl2VDZvdU8z?=
 =?utf-8?B?VTVZaS9vUEV1cEFVSDNKWENoRDl0d0dKMVNmWXFVZk1JU29NdEtSNUd0M0I3?=
 =?utf-8?B?N01xeVFQSHByOXFsT3VVR3MrYnJYTFMwaVpnSVhNOFdLWXN4N3hzZnF4UHR4?=
 =?utf-8?B?ZVR6QkllSUNqVW0wMUUyamhRM3FBOUMrSFJzWUNseUtTa3VMZzJUU2N0cDR3?=
 =?utf-8?B?YlgzS1R4WllWeFU4NzV3VEdHL2hibXN1bG8xdXRtRlZObXp0UWc2MUVoU1Fj?=
 =?utf-8?B?bytHSW1saXp1OGoxbjhoV2NUUkpGNS8zQWJadUpmZGQ4emtER0Z2RnEvUE5m?=
 =?utf-8?B?UTNvZ0xFZUIzMSsrR3JueTNsNTVmYWVFeE1EajJRK0twZHJrZ2E5bk5hY2hY?=
 =?utf-8?B?bW0xUjVBWXZ4UVBFM1FWRllWbXFCbGF3Qi9sY3NLT1daYUdMVU94emYrRE53?=
 =?utf-8?B?UVhaTEZvQ3FNSW4vM2I3ckUydzF3ZEs4b29SN1dmTGhaeURuR0RYODloTnpz?=
 =?utf-8?B?TjVCMGlnL2NvYjF5dGdJd09IbWFRSS9yUjRINisrZXR2VW11cVBTK0dhS083?=
 =?utf-8?B?Z1o1bitXRXR1UnpBVDhibnJuNjhOeFljb2tDU2NaeGdsanhFdEFZRldWWUVm?=
 =?utf-8?B?RE9LUUd5NkpFNy9raFNSQkZvY21Zbld0N1RVWFkvQXdLbTdwNlZYMDl3U1lM?=
 =?utf-8?B?aXhLNUF1aUxLZG5lYlpkOE9KRHFOVXYxbFVkTFRUcXJIT0RSa0lZcDRTWVY4?=
 =?utf-8?B?ZlowY004NTAxMWREZzhnNGNwcVVsVWpMMkxaMkZuano0NVNnRUQ1YVg2SVg0?=
 =?utf-8?B?T0JKQUpvVTQvRmlUWnpGc3o4VlVhcFhKYUZHSG9ETlVRcGNEdlNOODRicUxp?=
 =?utf-8?B?aE1UWU53dnNIcTRQaHY1RStvREhUaXY1YnNyNk53S2JJckxTTlZ4bFhPTFVa?=
 =?utf-8?B?azBXZ2tIWmRiRzVwLzlsL0RSY1hOV0VsSUIxQVB2SExqc1NQeEdvOWhaOFFH?=
 =?utf-8?B?SlEySmFOM0dZajdBMVJQYkpadXlCclNORGdheWVtK1djeWRtczZkUFRuZDlD?=
 =?utf-8?B?bzNBYTJ4OTJkamVwaFEvMjdna21uTGtBdTNrRGxMeXR3NmlqK3NkL3pia0E2?=
 =?utf-8?B?bEl0eHNJYVZQQlRVc29nKzl4RlFkSkNFdVJ1ckhQZUt5MzhwbEp5d2RyUUhE?=
 =?utf-8?B?emYrSW4wRjdiVldxaVhUS2tWdVlqdm5JcXg4MXFTOWZTUlZ6ZitBWjBvRFky?=
 =?utf-8?B?T2RranRwUGY4SXZidzlQQnpweFh1NEt2REVrUHgzaDJGZmxwcVNscUh1MnQ3?=
 =?utf-8?B?c2pPdHJZWjFFQ2ZlTHA4TEdrbHJLNWY5cjBFaTBWdVp4UHFNWWtoMlNYakNK?=
 =?utf-8?B?S0lJT1FaMGxpZDVzMVUzQWllalFDaXkySmRsL3g4VkNwcmRtVUhyN0VsSE12?=
 =?utf-8?B?MjlBYVhDbkFjNS8xNkZzbkhCb1hzcTZ5L1E2QnpsbVdOR2RRWW1XNDJsdmpD?=
 =?utf-8?B?d0N3YnlVZTlZclMreXhVdkNRK1VZZVBKOEp2WU5CeFdSK01DTjhwbFUvcDht?=
 =?utf-8?B?cjZrRmRLenJIUW5JTFNwVTQyZEIyMHBoL25UWmh4aktLNjRhM2lxQ3NZcEcy?=
 =?utf-8?B?V0JPTmhDNDJTUzFocUFzU25QZkxzWW1SNmgxanBmZWlnWWQ4RTNXUWExNUJr?=
 =?utf-8?Q?N1CRg67+Ask=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUZYRUJhS2hRT3l2a1ZpMS9IWVNmK05URWRmMkczemJBY2pXSENOVEJ1Y21O?=
 =?utf-8?B?N09OU1RrUkYxL0NOUW82SGRKOTNuSUVpWHI1VFZwU2h6c0tvR1RKdk80UzFJ?=
 =?utf-8?B?SFN5c3JXQllkWmhrS0puYm50ZWp3REtUNGtPcVVxN2loa1BOYytyWmJLeDJ1?=
 =?utf-8?B?V3RPS2tqM1pzaU4yTS9jeGhFeVZMdzlVV2IvL29ndEhzUnVteXRBeDBKMGR5?=
 =?utf-8?B?MzA2TVZMRFpwSkh5MDdTZ1E2ZkdTNTNVSVdNODRtVUs1Yk1ObTdyYUNTZTBN?=
 =?utf-8?B?N2oybE16ZFcxY2hybk5uNHFGVDhoSzcvMmpmdTM4SDQ1eVB2WWdRWFMxbStz?=
 =?utf-8?B?S09NQjJaeXdGTDdpRjAvNThpQVNIaVRqb2c1SEZXYkNDTGdxMzlXZldDN0JV?=
 =?utf-8?B?T3h2bENtUkR5MDNsSDBKNlpSTjJqdFlWbjZtRjFSSDJOZFZZN01CeFNZNzZT?=
 =?utf-8?B?Q3N2OFFKQit3eU8vemFpQzFUcVAvMkxkeWVzYm1WTURzU1QzQkszVlQwMVBS?=
 =?utf-8?B?Q05pWUhvUzREZ1Y4VUJoN1NYdzEwVzVZUVZXYTU5V1JPN1BhYlpzcHBKWFhw?=
 =?utf-8?B?SnVHSDNnVTJrTTN6S0trMWdaRkNYZXltMDVtTmNsRzRUR1RGV0hzcjlwaXY1?=
 =?utf-8?B?WVRLSkV5b2lBdTYwaElyTjdmZ1NGa0Rub1hsVlB5RTFVK1h5MHhLZjJkRkt4?=
 =?utf-8?B?dTFZU0FUcytPb0pPbkNJOEROTmxHUDIvYnVRdE15elpRc1crN01vMFhhd0hO?=
 =?utf-8?B?T09qeUtSazQyM3RsYTFXRjN1N00vS011OHdJdWpjbUdkdDZQTmlyL2J6L20x?=
 =?utf-8?B?Vmg2dkpSUzhPcVN3N1NLVUhuK29HSDdLRENUYk9BRzR5QVlldng4dmRmQ3dQ?=
 =?utf-8?B?OUw4RlJLb3p2YUIrcElRRjlBMVo4SzlNWlcxSGwrK2oyOW4weTZCK000cit1?=
 =?utf-8?B?dXNKSnV5d1kwT2pvMU1UZGdUdjVUalMrOVNNeGZWTEMzUU4ycURNTk5pS2VY?=
 =?utf-8?B?YUFKWFJjZW9PZm9GQlJGcHVFOVBpZGVTUktHUUtRSXRTbWxhK2RPMmtSeGZJ?=
 =?utf-8?B?ZFpzY2h6Vnc3RDBlZDhnODFKNk13OW9xWS8yK1FzWW9YMHhLS1AwdUs5ZnV0?=
 =?utf-8?B?aE54Z0pEQ29DS3gxbXRNdXd0NThQTkNNeE9BRjNpL1pPK2o4WGpkVTV6UDA2?=
 =?utf-8?B?QkZIWFhIczlzOVJXaGVSSXQ3VzhPK2wvcXI3bThTU0NWaXdwbUpsVmRkK0VB?=
 =?utf-8?B?QlVSb09OaDV0WjQ4U0F3Z0E1TThGb05JSDRYNVhHd2tyeDRHOThsN3d5ellB?=
 =?utf-8?B?K1llMUtXYUZKcVhvRnlaZDVnSmtLV2hlckhRcTlPYmwyU2VWamhtRVE2YWlj?=
 =?utf-8?B?S1gwSXd6ZTBCb0J1K0VtNStkam01cW5zUUFESG9UOGVTU3kwTHhXRWVJYklD?=
 =?utf-8?B?VUpFUmNYM1NFZ0RacEx1eHJwbXFhNy9TREo2ZTNxUy9WdFVtNGxndjFoSGpl?=
 =?utf-8?B?Q1ByMWgweExNZ0VGaUR2VEp1WmY4dXgrbE02N3JhN3hyVUFxRmljRUttWit1?=
 =?utf-8?B?Ni8xdklpb1Baam0wWHVhaEU4aDY5Q0xFdFVzMkovN2Vsc1p1bCtEQ0RKV2x1?=
 =?utf-8?B?amxsSWlnOUR0S0laV3FKd29YbUNtWmNLblNCQnlHenRETGRHVjNBT3dUek55?=
 =?utf-8?B?VHZ5UURXMjIvTk9nbDFEakU2WGQ4dXVJdkhTcUhreXZyd2JZWXhYRk5FMkpJ?=
 =?utf-8?B?Njdmc2dGMTg4VU5qcXpQUDhCTVNoY2R6dWdaaW1sUmVHbCt5b1RmQTVvaE1O?=
 =?utf-8?B?MnpmZFN3TU9UWWw4Qm4yRGorTVg0T1UxVUJZbzY2Z2hPenlNNG51V3Bjc3Ba?=
 =?utf-8?B?a1VGWmZjWGVpZ2VKM3BYQmZCYlVxT2EzSDhPbHBSK1JwK1BReC9BbHdGWDFX?=
 =?utf-8?B?Tkd5cXo4K29tNUJZRGxxVzMyeDJ0SVNwVEczTzdDbmFodStwK0cvZG5NQ3VJ?=
 =?utf-8?B?a01NMFBwV2dITVowN2N5NXg4RTAwRjQ3Z0EzTi9oWk90dnpTcUNNaisyZTQr?=
 =?utf-8?B?QXNCSzRUUEJuR3ZoVmMyV2hPc0U0Sk90OVZpalJGQ0lmS2MvYmtFeGxJK2dW?=
 =?utf-8?Q?mSmVfZ6YcGjxHCtsCHhU8bQCU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a70098c-1831-4cc4-2ba8-08ddad6a2eb0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 06:42:52.2772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZL2aXfhBaopa7cdWEbdxXFaw3BOmAKVJ9t5sFUHDyTTm1tGn3Ih7pqcIwfUzxfiZ2ygb78U4VFSgD7vxUHPTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8723
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
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

On 2025/6/17 11:22, Nicolin Chen wrote:
> On Mon, Jun 16, 2025 at 03:38:26PM +0800, Yi Liu wrote:
>> On 2025/6/16 13:59, Nicolin Chen wrote:
>>> On Thu, Jun 12, 2025 at 08:53:40PM +0800, Yi Liu wrote:
>>>>>> That being said, IOMMU_NOTIFIER_IOTLB_EVENTS should not be needed
>>>>>> for passthrough devices, right?
>>>>>
>>>>> No, even if x-flts=on is configured in QEMU cmdline, that only mean virtual vtd
>>>>> supports stage-1 translation, guest still can choose to run in legacy mode(stage2),
>>>>> e.g., with kernel cmdline intel_iommu=on,sm_off
>>>>>
>>>>> So before guest run, we don't know which kind of page table either stage1 or stage2
>>>>> for this VFIO device by guest. So we have to use iommu AS to catch stage2's MAP event
>>>>> if guest choose stage2.
>>>>
>>>> @Zheznzhong, if guest decides to use legacy mode then vIOMMU should switch
>>>> the MRs of the device's AS, hence the IOAS created by VFIO container would
>>>> be switched to using the IOMMU_NOTIFIER_IOTLB_EVENTS since the MR is
>>>> switched to IOMMU MR. So it should be able to support shadowing the guest
>>>> IO page table. Hence, this should not be a problem.
>>>>
>>>> @Nicolin, I think your major point is making the VFIO container IOAS as a
>>>> GPA IOAS (always return system AS in get_address_space op) and reusing it
>>>> when setting nested translation. Is it? I think it should work if:
>>>> 1) we can let the vfio memory listener filter out the RO pages per vIOMMU's
>>>>      request.
>>>
>>> Yes.
>>>
>>>> But I don't want the get_address_space op always return system
>>>>      AS as the reason mentioned by Zhenzhong above.
>>>
>>> So, you mean the VT-d model would need a runtime notification to
>>> switch the address space of the VFIO ioas?
>>
>> It's not a notification. It's done by switching AS. Detail can be found
>> in vtd_switch_address_space().
> 
> OK. I got confused about the "switch", thinking that was about
> the get_address_space() call.

yeah, not that call. The all magic is the MR enable/disable. This will
switch to iommu MR hence the vfio_listener_region_add() will see the
MR is iommu MR and register iommu notifier.

>>> TBH, I am still unclear how many cases the VT-d model would need
>>> support here :-/
>>>
>>>> 2) we can disallow emulated/passthru devices behind the same pcie-pci
>>>>      bridge[1]. For emulated devices, AS should switch to iommu MR, while for
>>>>      passthru devices, it needs the AS stick with the system MR hence be able
>>>>      to keep the VFIO container IOAS as a GPA IOAS. To support this, let AS
>>>>      switch to iommu MR and have a separate GPA IOAS is needed. This separate
>>>>      GPA IOAS can be shared by all the passthru devices.
>>>
>>> Yea, ARM is doing in a similar way.
>>>
>>>> So basically, we are ok with your idea. But we should decide if it is
>>>> necessary to support the topology in 2). I think this is a general
>>>> question. TBH. I don't have much information to judge if it is valuable.
>>>> Perhaps, let's hear from more people.
>>>
>>> I would be okay if VT-d decides to move on with its own listener,
>>> if it turns out to be the relatively better case. But for ARM, I'd
>>> like to see we can reuse the VFIO container IOAS.
>>
>> I didn't see a problem so far on this part. Have you seen any?
> 
> Probably no functional problem with that internal listener. ARM
> could work using one like that as well. The only problem is code
> duplication. It's not ideal for everybody to have an internal S2
> listener while wasting the VFIO one.
> 
> But given that VT-d has more complicated use cases like runtime
> guest-level configuration that switches between nesting and non-
> nesting modes, perhaps having an internal listener is a better
> idea?

I noticed there is quite a few duplication now (container/ioas/hwpt). let's
see if anyone wants to put the emulated device and passthru devices under
the same pci bridge. If no, let's avoid duplicating code.

-- 
Regards,
Yi Liu

