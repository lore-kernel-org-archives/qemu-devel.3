Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66461CA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 08:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utj8W-0002QM-1h; Wed, 03 Sep 2025 04:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1utj8R-0002Pn-Aj
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 04:46:31 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1utj8J-0004CT-94
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 04:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756889183; x=1788425183;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wUK2voekkNUxiwniMlp3xTur80fT7l8lDSxRDRq8Exw=;
 b=B00d0pYU14VQP/ftcLCTTc9NYntWCiBlh/SGe2wVFCQYAEAqXKZpag9j
 Ey/OUSufwupude8ANqdUjJYsSguTZhClTl0ePOfQhX9xPcA/7p4PIQVub
 QRnkhI4jT8BVLnMvl2ftVlRh3cNEHJs/4k+x5rslv038ElCTkZK0fa86x
 /dzIc8KOLSlIFE/yGrGnlnL8Oq4oL37w4cHzUfTXFm6fvjU+SE7BuWZWE
 hrSH6krNeNONfyS4t95b9ONKFCFHISsKfIIjyHJ9rgOdzGQxprBwVjkwM
 Fl5lrTg4VxVRxcu2v0nMvnF2hwSigsJlyLXKOYWJL8SfgcX/CgiswT+Xz g==;
X-CSE-ConnectionGUID: f1qcBGbOSGmI9JLRRR2Xdw==
X-CSE-MsgGUID: I7VPIY1+SFmDmGfWR9b/Zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="76795629"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="76795629"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2025 01:46:19 -0700
X-CSE-ConnectionGUID: 7XUhAIwSRduwEU3wPup7PA==
X-CSE-MsgGUID: hn6gDSNtRlqfofyk7nLYtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="171497699"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2025 01:46:18 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 01:46:18 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 01:46:18 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.71) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 01:46:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTx1UCS8PDjB51KRAMBySPrR9rGTqGFexd9jPJ8NEiMAAPLT6gEZH42yE4Gf8o6pnu1XNg1iCcZwnTB9vAbf6zCxJi/vwd3ptUKH1xUNMTycMXq1cFFqBUZWl4Kz/yDlBR6RRgsSAGN23Qp5LjMkh5ZsHDx4uMqLr4n7C2hv7PxyMG3D1NnW/ElSkilb67ggG/gxQFLQhhL0R/HIy9gNQbvl+9PK4AvN9SgngfmKssxm8pTKGRWcG1kwVu5VFpiLCMi5qb6G4JWD81ebKT8Rm80imkfOdHdU3ctpnwGpyTUSJZLOUhFlES+rAiZpKQLckB+RP1+q6UMh3jvHmt15iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqiFyB7WXU0myASDCSiEtBDs2HDLhtMejQvnbpEv+0A=;
 b=BVU5p1RA0Apdkh2+bhCo7z7sjnAMcgm/P7muoqrcpk7++o3NTnl+hzpWSQGH+5TjhJQya23aUlvVXS28NJviLXashMHw5PFGfmC+fEt+FUKScPQ//a9d808lXBKam43aYG0ubDnu/RLCdoEFdI+eQkFDfQn2vHeHtvjkJHFeOmEw1b7e1X45Z/amVtEn2Hijqf4Pjmw2g12ppmmh4DGaswfTrffxaJmzC/QRq+Wvc7HPgYWaP7TQerV81JVizK74OVLXb/LHxjMoDXOcmEFL2ebG+ByiGWQ7xCUCMPJqjZcBYpXzyf2X8X7DrWgQGZG74AFMAnm9nX2wJ02pRPzHyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by PH3PPF25FF87461.namprd11.prod.outlook.com (2603:10b6:518:1::d10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 3 Sep
 2025 08:46:11 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.9073.021; Wed, 3 Sep 2025
 08:46:11 +0000
Message-ID: <c1fe5251-4151-43f1-b152-4c0f1be8592d@intel.com>
Date: Wed, 3 Sep 2025 16:52:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/21] intel_iommu: Handle PASID entry addition
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-13-zhenzhong.duan@intel.com>
 <5b25de4b-ae84-4926-9e14-2ab4262e973f@redhat.com>
 <IA3PR11MB91364DF170025220D3168E4B9207A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB91364DF170025220D3168E4B9207A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0176.apcprd04.prod.outlook.com
 (2603:1096:4:14::14) To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|PH3PPF25FF87461:EE_
X-MS-Office365-Filtering-Correlation-Id: c8fa4522-c1f3-4285-0450-08ddeac6551c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|42112799006|7416014|366016; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0F4ZE4zNStzTlZLRlIzWDVDSDZlSEFDaWtoU2tTQjZFR2ErVDNlZThyS3Ju?=
 =?utf-8?B?d3ZJMEZlalB6N1FNMlNlSS9nK2l5dFFudm1TQzRvcGVISS81MXNBWGZHVGIx?=
 =?utf-8?B?ZTJCOHlKMEJXTlcrbUZFaGpnbGhCeHd0bTlwY3lMWEkrckpOZFZvTEM4SnU2?=
 =?utf-8?B?MEltRVJ3ajNlNUcxU1RZV05GQ2dQdXlWYUt2d2ZXVWhUNzFreVMxbDRXUzNy?=
 =?utf-8?B?aFlIaW1ESjZYQU9XNnVqREdkRWdUQVRHZEVpMUh6NlpWZW5vSFNXVUZoZ0wr?=
 =?utf-8?B?ZlJvOHlmZFBObGpQUDZiKzN5VDk5K1ZrMGZPdlBVclJkb1AwZi9JMVhjU29j?=
 =?utf-8?B?VW54Z0NzbVQ1dlRDWHJReEZ3ekw5aFB3N3pmQUJRbkhzWWhpOG1tbjBKd21z?=
 =?utf-8?B?TURVMmhyeG1JUjJVQXVKWDZiRnFCSng4MURZcTNkMVZzdjFza0s0VjdYY2Ux?=
 =?utf-8?B?bGhUamt5WWM0djk4dWFzVFJyb0VJQXpVL3pwQXc2SVcwWmI2dVcxL0lXdFBX?=
 =?utf-8?B?Si80VThnVEUzTGZvT01hUTV4SitCRm5hZVA2c3hBNWRHSU5FS2RqbTg3OTRH?=
 =?utf-8?B?ZHpyaXJ1QkRpY2JmNmhjblRYT043bS9sZ3E1cDFBY0llblk2YlNwNzcwbFc2?=
 =?utf-8?B?S285MXF0T2pNRWp5QndvYUg1QnY0OHVtUjB4am8rL1RKUDNZUzFJdWpHSTVm?=
 =?utf-8?B?MnN4SlJyL1Q4N2kzcGxCaEZ0bVROb2UvcnpZUjhic1puRDZxWG1BbHhDODJS?=
 =?utf-8?B?ZFl4T2dzcXBhTlJPem1xS3pIMlV5YlVUR2UrWVB6L3IyaVlmaklDcXJtTVNu?=
 =?utf-8?B?N28wczgrc2taZlM1UFJXMHdBTEZBU0krNittb00vWDlYNk1WU0sxelhtSFZm?=
 =?utf-8?B?WTFYb1dWbVdKOFdKalF0WndRKzVXVkRqZ1BrSGlMNDNZODY1UlFGUEttK1Bq?=
 =?utf-8?B?Y1NKQmJMdDJnSE9UclREazBDd05uM1pyZU1Hb3RCM2N4SS83dGtoSTF3VXJP?=
 =?utf-8?B?WTZDL3JWZUJpaWpHcVp1dXdWSVRKaWVjSHlaVzhvcTZLc05nZGNLR1ZESWsv?=
 =?utf-8?B?THdMTUwxWm8rTlZiMFlkcWM4Q014QlRabGJaWnBqd0R1QnhXWlBieFVLb1ox?=
 =?utf-8?B?R2xrQ2ZzUGkwQ2V5Zk5rMnZ5YW5sQmwxaDdqbEI1UVoyODBzM1Fmb1FNRTlZ?=
 =?utf-8?B?UDZZU1NtaVVmUWZjaWFqUGtjZWJ3b21COVhqWHhpZHJKQlV0V2VWYkFyS0RW?=
 =?utf-8?B?NHFVdlNkbmJVaGdCRmZhWmJab0VicDdzU21HZGJET3YrWERlU1V4TzN2Z3hY?=
 =?utf-8?B?dUlNTS93eGdRblh2b2VOM0pyK0cza09KMmZzOWxQMWxua2NEQXBWdHdNWTZF?=
 =?utf-8?B?VmRjK3M5M2Y0bHA2cEFPOXVsSFJ0U0JHQnpicldWMFpQMlhCbzljOWs3Rk85?=
 =?utf-8?B?YXp5RzFITnBrNitWdUVsY0Jrci83Y3YwbTNsK0ZZWG94YWxOWldqSU5aUldo?=
 =?utf-8?B?N21tWmMyazk0amxLRUNLemRuTjRoRnFHSjVmRjVmcUVTN0FwRWFMZ2cybTZR?=
 =?utf-8?B?cTJ3M2U2ZzRyanUrZWhMR1VwOU0xNFVQbkttdkJnMGVTRnIyclJBU0xtbG9y?=
 =?utf-8?B?QTE4dDBJWnk3YjFmLzlOYVhCQTBVZSt3ZC90emJOeWNadTRNTWVGay9pWk45?=
 =?utf-8?B?R0taMEhXcnR4ejNkUHYyVnVJb1pnZnBpbUhBdDhVNlB6ZkV4aVphWnZQNTJr?=
 =?utf-8?B?NWdVVG5YQXk3QXhTdlpLeldrY25OYS9RTGRwcnZoTlBsdVJ2SjJsQ0pha1k3?=
 =?utf-8?B?SU1ldUF0dFFOdExudXNDOUhRY2xzS2VSZFZIYTQza0pRbHVWaUhwMUtKRlBx?=
 =?utf-8?B?UnViTG9TNEVkK0k4V0FXQnRQZkpSVDRPVW83UUgyekNWQmc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(42112799006)(7416014)(366016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajYwUVp6YzZuaWdFbWt6M0VPcDIwcGdzbHdDZ0M1c3ZxSjJaWEZpL21KWmhz?=
 =?utf-8?B?ZGhKcTZRUVdtc2Y5RkJROWN6aXhJS1pIaXk1VHYvSGpZdThieVFQNjV3WkVN?=
 =?utf-8?B?V0NtaHNkR0FEOUhoS1lhNGR3akVjcGIrNHduc3dFUkI5MHJnb2ZEZDduTk0x?=
 =?utf-8?B?WVVENFh4TEwxSmVlZnBDeHZJbUFSWERNbnZ1ZmxzbW01bTFHR0pnSmViZlhz?=
 =?utf-8?B?MW5RWkhlSjBzbkcyWStNc0d3NFQzU0xDeitmQmZIUXZnZXdjbWM2N2xiMC9a?=
 =?utf-8?B?ZFNaNmFUdmNpMzd1RmpvYVBIMGE5b3VLL0YvdGRlWHAxaGRFNDZOcW9DcTVv?=
 =?utf-8?B?V0d1YWRoQStHdWIzUHVsQUJlY3l4RWJPUUVURUFBVllUNWxtMTNJRnFFOEFp?=
 =?utf-8?B?SWsrdUZ2NmhnRHJheElJU3d1QzRxTU5hSHVrOW9KT09OVGVFMHpJV0lvMy9V?=
 =?utf-8?B?Q25mN1NHbkIrYkorNlhGQjhWRERkZkIvekFVSGowVmdhOEdMaGU0WHBvT04v?=
 =?utf-8?B?cXpuandXZ045UW9uVzU2L3JJUnJPdXlMN01TOUdScWxhYTcyc1dtM2NpU2N3?=
 =?utf-8?B?OEsvRVVRUDV1Rmw1K3dTZGZ6UlozdTBVUGF2aHlEMUc5R084b2U3R3VTaUk1?=
 =?utf-8?B?UGJaTjFzL3hhUGwzNGdBSE1YNlh4U2M5aCt2Rnd6TUV1MU9hMldWOFFkTGFv?=
 =?utf-8?B?YVFxSzJEYmNoN0Z2RTNNcEkrZzNhbmRjN2g5ekh3eFJCajJML2toTTl0d082?=
 =?utf-8?B?OGtSKzhEeUwzSUNlRUpVZmZjV0hqUnZJdnAzQ3hGVGZGbEFZWEJ2Z1ZYR2gw?=
 =?utf-8?B?V3BPUzl2eDBVaXVFK3l1cHA0bVlUSVR0bWJlcXVEdnZ1c0ZKV1lQSkUzTzc2?=
 =?utf-8?B?dmltYTE3VmltS0hjcDRMbTd0dkUwSTRucWZKcGVLSEd2dWYxSGhkdml5WUpS?=
 =?utf-8?B?T3E4NnNnRnkxT1lnd0h4bzFVamlFaFFPU3NiWFY1WGYxVmNpY0RpeXNZb3Bh?=
 =?utf-8?B?UjlaNTRaSys0cHVnSjVzbk9HVFpWL21YaVlPUWZSYm5DZDFIS2RWZm5rZnVX?=
 =?utf-8?B?eDJuQVRsd1dLak5IUDdMTVI2UXJXMjNZV24ycFhYeGdxY2VKeEVPYUlPaDcv?=
 =?utf-8?B?U1ZGbzdXUnZmdGd2cjVySnFIT3NyT291bTJNemxDZkxQbTFkQmlTZFAvSVUw?=
 =?utf-8?B?a2QwMlEwWXpBOWpXSWV6NHdBTWErd21KNDMvaE4vUHBha1BHSkk3TnBnN0gr?=
 =?utf-8?B?ZDkvZGZmamRRSUpJR0RRSVNoNWtTcXROTzE5UmtQN2w4dnhESUZqZS9OOHE0?=
 =?utf-8?B?RzEzOTN3TGRLbFlYbmdEMzg0dnNqYjBGWE9DcFA4aTlaRUZKZ3VKdzlaUVdv?=
 =?utf-8?B?RE92RXJnZ0RidFhvZTdZbHdxQnAvQ1BENlk4amRnZjNJOGE3WGE2RTJ5b0xY?=
 =?utf-8?B?eDRCbFFFckNOZkRPdTFhUXRrVG5aVlJFNFRCL2xuQkh0TDZaNjdmMGkzQzVL?=
 =?utf-8?B?MzZiaTNhallmbjFqeDlXaDdBRUNkQmMvK0ZKMUhYaitsdVRwTHVtbzMxRjZS?=
 =?utf-8?B?cUc0K0FjVzZlcXhwWDdRMFFLbUhud2VRK2ZPdXRQcGN2S08xSGtCNEJmZmVC?=
 =?utf-8?B?bGxTR1FpVkg0UkllMXNlSk9ROHllU0NVWWs5Wk9DdjhJek1vUm9xdVpETjF5?=
 =?utf-8?B?cGI5bU1lVEdObjI5V0R5TCttYTdNZTZwM1hibUxxSnpuanNKUU5aZWFFN2Fu?=
 =?utf-8?B?TGIrbmxGL2kvbzZIdWF2bWM3dmZWd1VsRXNJUU9lOGE0bHQwRHM0b0k2YXJw?=
 =?utf-8?B?K1dWZHNmRHpEdStJNTd3a2J2cDE5MHorYzNGNEd4RXR4cTRVekl6cTErRDhG?=
 =?utf-8?B?aG0zT2dNOGZJYTBjTE9iT3dYY0JZbXZ3NnVCMmw5TGlkT2RuV0NCZjJaMk1O?=
 =?utf-8?B?Q3VNaVZ6VUYwWlNXTTFpY0Frd3VQODgrdElReFFDT1JseWRRVlV1dTZiOXJa?=
 =?utf-8?B?SXBmVTM2bDhEM1BuSXJKTGtYRlIzZzdUMVcvd1NMV1hIMnMyWjlpZm9XQWMz?=
 =?utf-8?B?WGYwa3R1WkNXN1hITXFaSzcwbWY1T1NXVGVDNFRCazdaK0ZjRU9qL1lxeE1Y?=
 =?utf-8?Q?XL82RidOaZigjzU5YwIXe9hxx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fa4522-c1f3-4285-0450-08ddeac6551c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 08:46:11.2114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZANA9aJkp9Njos9+OHvizf+7ScV1Qd7v66Z/YAAo2JEgXoML+S10r8Cj3tmtTCDs4cGjXcwdFNc6pkbWnHXF6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF25FF87461
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8; envelope-from=yi.l.liu@intel.com;
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

On 2025/9/1 17:03, Duan, Zhenzhong wrote:

>>>   }
>>>
>>> +/*
>>> + * This function walks over PASID range within [start, end) in a single
>>> + * PASID table for entries matching @info type/did, then retrieve/create
>>> + * vtd_as and fill associated pasid entry cache.
>>> + */
>>> +static void vtd_sm_pasid_table_walk_one(IntelIOMMUState *s,
>>> +                                        dma_addr_t pt_base,
>>> +                                        int start,
>>> +                                        int end,
>>> +                                        VTDPASIDCacheInfo
>> *info)
>>> +{
>>> +    VTDPASIDEntry pe;
>>> +    int pasid = start;
>>> +
>>> +    while (pasid < end) {
>>> +        if (!vtd_get_pe_in_pasid_leaf_table(s, pasid, pt_base, &pe)
>>> +            && vtd_pe_present(&pe)) {
>>> +            int bus_n = pci_bus_num(info->bus), devfn = info->devfn;
>>> +            uint16_t sid = PCI_BUILD_BDF(bus_n, devfn);
>>> +            VTDPASIDCacheEntry *pc_entry;
>>> +            VTDAddressSpace *vtd_as;
>>> +
>>> +            vtd_iommu_lock(s);
>>> +            /*
>>> +             * When indexed by rid2pasid, vtd_as should have been
>> created,
>>> +             * e.g., by PCI subsystem. For other iommu pasid, we need
>> to
>>> +             * create vtd_as dynamically. Other iommu pasid is same
>> value
>> since you don't support somthing else than rid2pasid, I would drop that
>> and simplify the code. See below.
>>> +             * as PCI's pasid, so it's used as input of vtd_find_add_as().
>>> +             */
>>> +            vtd_as = vtd_as_from_iommu_pasid_locked(s, sid, pasid);
>>> +            vtd_iommu_unlock(s);
>>> +            if (!vtd_as) {
>>> +                vtd_as = vtd_find_add_as(s, info->bus, devfn, pasid);
>> you could check the vtd_as already exists here per the rid2pasid support
>> limitation
> 
> In this series, I do include some basic codes for non-rid2pasid because they share some common code with rid2pasid and we already have emulated rid2pasid support in vIOMMU for a long time, it's not bad to accumulate some supporting code for non-rid2pasid for passthrough device. But I can do the factor out if you insist to have only rid_pasid code.

I think it's a reasonable ask. :)

> 
>>> +            }
>>> +
>>> +            if ((info->type == VTD_PASID_CACHE_DOMSI ||
>>> +                 info->type == VTD_PASID_CACHE_PASIDSI) &&
>>> +                (info->did != VTD_SM_PASID_ENTRY_DID(&pe))) {
>>> +                /*
>>> +                 * VTD_PASID_CACHE_DOMSI and
>> VTD_PASID_CACHE_PASIDSI
>>> +                 * requires domain id check. If domain id check fail,
>> fails
>>> +                 * go to next pasid.
>>> +                 */
>>> +                pasid++;
>>> +                continue;
>>> +            }
>>> +
>>> +            pc_entry = &vtd_as->pasid_cache_entry;
>>> +            /*
>>> +             * pasid cache update and clear are handled in
>>> +             * vtd_flush_pasid_locked(), only care new pasid entry
>> here.
>>> +             */
>>> +            if (!pc_entry->valid) {
>>> +                pc_entry->pasid_entry = pe;
>>> +                pc_entry->valid = true;
>>> +            }
>>> +        }
>>> +        pasid++;
>>> +    }
>>> +}
>>> +
>>> +/*
>>> + * In VT-d scalable mode translation, PASID dir + PASID table is used.
>>> + * This function aims at looping over a range of PASIDs in the given
>>> + * two level table to identify the pasid config in guest.
>>> + */
>>> +static void vtd_sm_pasid_table_walk(IntelIOMMUState *s,
>>> +                                    dma_addr_t pdt_base,
>>> +                                    int start, int end,
>>> +                                    VTDPASIDCacheInfo *info)
>>> +{
>>> +    VTDPASIDDirEntry pdire;
>>> +    int pasid = start;
>>> +    int pasid_next;
>>> +    dma_addr_t pt_base;
>>> +
>>> +    while (pasid < end) {
>>> +        pasid_next =
>>> +             (pasid + VTD_PASID_TBL_ENTRY_NUM) &
>> ~(VTD_PASID_TBL_ENTRY_NUM - 1);
>>> +        pasid_next = pasid_next < end ? pasid_next : end;
>>> +
>>> +        if (!vtd_get_pdire_from_pdir_table(pdt_base, pasid, &pdire)
>>> +            && vtd_pdire_present(&pdire)) {
>>> +            pt_base = pdire.val &
>> VTD_PASID_TABLE_BASE_ADDR_MASK;
>>> +            vtd_sm_pasid_table_walk_one(s, pt_base, pasid,
>> pasid_next, info);
>>> +        }
>>> +        pasid = pasid_next;
>>> +    }
>>> +}
>>> +
>>> +static void vtd_replay_pasid_bind_for_dev(IntelIOMMUState *s,
>>> +                                          int start, int end,
>>> +                                          VTDPASIDCacheInfo
>> *info)
>>> +{
>>> +    VTDContextEntry ce;
>>> +
>>> +    if (!vtd_dev_to_context_entry(s, pci_bus_num(info->bus),
>> info->devfn,
>>> +                                  &ce)) {
>>> +        uint32_t max_pasid;
>>> +
>>> +        max_pasid = vtd_sm_ce_get_pdt_entry_num(&ce) *
>> VTD_PASID_TBL_ENTRY_NUM;
>>> +        if (end > max_pasid) {
>>> +            end = max_pasid;
>>> +        }
>>> +        vtd_sm_pasid_table_walk(s,
>>> +
>> VTD_CE_GET_PASID_DIR_TABLE(&ce),
>>> +                                start,
>>> +                                end,
>>> +                                info);
>>> +    }
>>> +}
>>> +
>>> +/*
>>> + * This function replays the guest pasid bindings by walking the two level
>>> + * guest PASID table. For each valid pasid entry, it finds or creates a
>>> + * vtd_as and caches pasid entry in vtd_as.
>>> + */
>>> +static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
>>> +                                            VTDPASIDCacheInfo
>> *pc_info)
>>> +{
>>> +    /*
>>> +     * Currently only Requests-without-PASID is supported, as vIOMMU
>> doesn't
>>> +     * support RPS(RID-PASID Support), pasid scope is fixed to [0, 1).
>>> +     */
>>> +    int start = 0, end = 1;
>>> +    VTDHostIOMMUDevice *vtd_hiod;
>>> +    VTDPASIDCacheInfo walk_info;
>>> +    GHashTableIter as_it;
>>> +
>>> +    switch (pc_info->type) {
>>> +    case VTD_PASID_CACHE_PASIDSI:
>>> +        start = pc_info->pasid;
>>> +        end = pc_info->pasid + 1;
>> if you never replay a range, you could simplify the code for now because
>> some code paths are not properly tested
> 
> OK. Instead of assignment of start and end variable, maybe just an assert(!pc_info->pasid).

I think there are two reasons for this range replay.

1) as a preparation for patch 16 of this series.
2) support domain selective or global pasid cache invalidation

> 
>>> +       /* fall through */
>>> +    case VTD_PASID_CACHE_DOMSI:
>> Why can't we have other invalidation types along with request without
>> PASID? It is not obvious to me at least why it couldn't be used by the
>> guest. Would deserve a comment in the commit desc I think.
> 
> Other invalidation types are indeed used, just in pasid scope [0, 1), because [start, end) are already initialized to [0, 1), nothing more here, so just break.

hmmm. The fixed scope makes the range replay a fake one. It's better
holding the range replay logic for now and add it when there is
non-rid_pasid support for passthrough devices.

Regards,
Yi Liu

