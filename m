Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F392D111B3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 06:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7r0i-0004aY-Sy; Mon, 04 Nov 2024 01:56:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7r0g-0004Zp-UN
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 01:56:23 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7r0c-0001wv-8w
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 01:56:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730703378; x=1762239378;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=puS61UENsavjj20OypV+IWu0X4IHQH8rwmgGPUYuE68=;
 b=gcpdUgfUiv2HOEpUB096kJa55r3m0m5PMelR5SBzEosjsY3wilaZ6Sxi
 h81MHxlvIUjkfqnwi4uX5xjtx7qXAtlkXFF9gHQtiGYYLpKq3jpVgcRBT
 ROSWQYIHfT2RN4re0H+Z08AXHKipQh+R9wzOe67LcejO5lyqsNC0iJ45a
 OoN+9qlNMBzpxBx5t2Gh9snT7B9Ca4DkKZ+IHavzY6MiSQDVH8vqAULqQ
 cYnt6GNg0e/vX5En4vUGiJdvOOCggUdA6Bjl48a75pMXAnYhA8FivxUa9
 HMTaCdoohNl15bZBXUC3efox4I13TC2witvawBg+WeC16OE78uTZUgtJM Q==;
X-CSE-ConnectionGUID: Nqc4ZFtrTW2oETn5OoFA/A==
X-CSE-MsgGUID: AGzkgqNHQXON77ewtChC3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="30496463"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="30496463"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2024 22:56:14 -0800
X-CSE-ConnectionGUID: e5r89Y+XRtmbzAuj7riqiw==
X-CSE-MsgGUID: GWQcSZDPT9+gQat+i30IRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="83087413"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Nov 2024 22:56:14 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 22:56:13 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 22:56:13 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 22:56:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYA7SMYcd4jroEYkE7368hCO5lUUmWkk6wwoXNZcZ20FylurzRUtUiAdjnyz4Z5rJR+9TjOVi/syVaW58e7dZ3EHm+L55ahMF8F/Vjc7nZ1amDs1qhG7y5EO1I4UrVkX9qNnlMRKGYAVLxVKsn5Hs9b9IgNcYjGL0ffELzFHbYYk3JZB9ZqT9m9KYwO52wssrnQSogahc0qw5ZGCsLiTPGgHoyuOZtyJQYiEdDR65Rr3+/Pt3QS7gDcTZI4YWlOP/BJ8L6vojfJeEMn1yorEn/F0RiiTyxyJx2GgH0wpIR7I/vehIGBWcWfRqh2CzAs45Iszes1rqzoqtaax7V9HtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvqqm3dS3FTHqhXdfItoJXtCc+qqL/O0HG+6+6hyYss=;
 b=TN//m3JkZzH3Gt+6ZFUXchm/6RqdI++ZgCop0C/Fna3upxT9SaaE/wuO/002kNWPK3mVypFaL+DbeK+sYsjNgTZDqMBRfM0PMSicszfkiYexdrbOPWYStL5H73MIilqg4SinwRLWyX/MBxGIqQS49afVSHay/JosMUxwd5IqBRq2OfHlb8Pc4GjQEp8dZlFFtUqnbavxb88cJ4tBd5/7lBeaulI9zf2uWyb2CGySi8jOz2HzwfU3qeancC3xDYugdrp09jmVYfP/NaaCYtFzNoRiWVkQmRcd+NwFZ8Ad3Gb6BBfHaBAWQgs5sroka0UThRUzmv7WDG/aAvhX3z1c6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SN7PR11MB6875.namprd11.prod.outlook.com (2603:10b6:806:2a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Mon, 4 Nov
 2024 06:56:11 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 06:56:10 +0000
Message-ID: <ef0e97df-5b88-4329-906a-c8d0cab8bbdd@intel.com>
Date: Mon, 4 Nov 2024 15:00:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/17] intel_iommu: Introduce a property to control
 FS1GP cap bit setting
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-17-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240930092631.2997543-17-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0089.apcprd02.prod.outlook.com
 (2603:1096:4:90::29) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SN7PR11MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a8670d0-24e2-4508-4179-08dcfc9dc3c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmthWVRBbHN1VFZCWTBiUTArSEpYT1JSc2RQcFdYOHpSK2JVaDNqQmZXc1c4?=
 =?utf-8?B?V1ZzeFZUOExXSkJoMitaMEl6NkFNdXVSV1hqUWNvV1lUT0I4MUNiSENTaCsy?=
 =?utf-8?B?YkVQdGZseEh0YmhHWk5SY3JlVkV4RmFidEdWQUVEM2NBdjVsdllndW5ieWw2?=
 =?utf-8?B?bkxUanMxVy9SVVl1Nng2STQrdkhYMVpzR0FJU1dOSnBhS3pOcnhvWXMvVFJJ?=
 =?utf-8?B?MGZmaGVObmgrWTdKWlRaaU13THhDeGVFd0g5ZVhWdUR6Z2ZDNmNmRWprYzdT?=
 =?utf-8?B?Y3pJZkkwb2wyQWdQbm9zRkZCN2U4Rm82WFFVT2ZTeUFiMm92M09Wc3Y3ajR6?=
 =?utf-8?B?MUlpNWY2ODd0QnJvdHZ4bFFwZGJUTDRkUHpEQm1yR09idnhLbHFtOTgzVml0?=
 =?utf-8?B?bFdCdWdmY2Vyb3QwZTJ4U244N0ZINXpxQWNtN1JqL2s3cmJ0ZGM4QWpDNlVS?=
 =?utf-8?B?L2d1VU04alhvMGcwaDgzbmV2ckhUMkV3eEVrQW9Cem1FVlJ6ODZRT05Ra1FU?=
 =?utf-8?B?QmRFcUYyc3BnQTJjaVQ4Q2Q2TGIybUJoNklXdGpmcWFaODk5NXVBY0QxQTUy?=
 =?utf-8?B?MkNWN2lyb3lGM3YwOXczUVlsUWU4T1o5QVlPcU0rNlBmeHpDaTVFWGdLYkht?=
 =?utf-8?B?M1YzNWhjQUc4UGgrSi9ZN2lBZ2tLemQ4M1hFL2FtdDkzeUwwcVc5K3lvSzA4?=
 =?utf-8?B?MHRNNGJuUTI2VTU2ZUJVK25xRmdURHA4SGdleUZ3VTM0bXNHaWJ4L245Yi9h?=
 =?utf-8?B?UHd1M1k2SHRSNUtselVlMWlGa1VIdXpLRi9neEkraDZnTjRuZHNESk5Zbnlm?=
 =?utf-8?B?RVZIVURuSm5GbWxSc2l4WTdTQStUcFJmZ2I4U21iY3FkaXZQNEZUTzdXaTlh?=
 =?utf-8?B?U2loSThJZ0ExYkpkQ1cxT0orM2ttT3A5Y1JUbnRFUnVKcjJXSzZYaUwxV0VH?=
 =?utf-8?B?YWQwdjdVNURHaGxITHBzWXdJdDlPOTlTK1RjT0lQb21CT0plT0JCREFadlhV?=
 =?utf-8?B?Q05yTDBJNVYrZjE4OWQ0QmNwRHJtYUd5T3JmdFI1N2gzSzlEaEJVV1RqVktp?=
 =?utf-8?B?SENJYUw4WWJWS21xanZDL1ljOVRXazIyQ2ZLQUNJa3dmcDFZaFM3Q2c0QWFO?=
 =?utf-8?B?VmlibGZBczFid2thazBoempianIxeUZDSGRwS2c1QVFQbWRIcFAwTGUrRlRG?=
 =?utf-8?B?L3ErSGxnUDk4aEJ3aWRGRmV1OUdkczM1M0FyOUZ4QVdYemdlWk9wdFk5SkJS?=
 =?utf-8?B?YU1yb3RSZ0oydGEzUjVJY1lCWmM4MVFQd1dnaGI0aFhCR09Jd3VySUd2aGY5?=
 =?utf-8?B?TTFtRlFMNDlrRWtnbm83LytLSHhMcTloT3hjbHZFYkR5NjUwYnJBMis2Zm03?=
 =?utf-8?B?Q2lNQi9ybTNTMWF1SXplSHZ4a3haQzhLVVpoUnVwVEt0MUNibmxteVhrbFJ2?=
 =?utf-8?B?NE0yMW1IZGd2WCtPUHY5R1VhMHBYQWt1VWgzT2pIdTdOc09GODVmUjljVlJr?=
 =?utf-8?B?UGVRQm9UbTkzMFRnVmpqeGR6Y09HNm5QU2I3RElBRnFtanRSMXZaOHd1NmJQ?=
 =?utf-8?B?MWZSYmVzNEZLVUM5V1dTVlJJTzdHb3Vkd0NrWHBtaGJxZERUNExsWnhlQ0Fp?=
 =?utf-8?B?WXFFZ29IZGVPZkszbHcrQk91S2sraHVZRCtaOFVqdUQzTlJzendCU0hTR291?=
 =?utf-8?B?eTlSR2JiR2Y0Q2JIbllxNXNCdGZ6ajVjZlZaQXpZTndFeGVPcGwwZGhJNE1L?=
 =?utf-8?Q?gTuDMUSF2KQHv2GXuXKiZrEt9lvlYx98IQkBQWZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3NxYkl0L1hBc2lqRERPd0toeTVNNU4yVTUyR3BsblJNblBpMk92NmRsL1or?=
 =?utf-8?B?MS9laFdvTW1iSVB1NFZubEcwYjNRNXdjazd6bzErNXJFNWVyYVFaWEk3bld2?=
 =?utf-8?B?enVEWk5pR1lJK2x2Z0p3VS9RYTB1REt1cjUzR0xxdlRVejRGNS9LbWxQcGtM?=
 =?utf-8?B?SWt5TEhtWFZSUndueUcxamNuMWJsNi9IUnlQRmJVd01wT3M4Q3FlSGRKaTFu?=
 =?utf-8?B?MkVGbGR6YVVSZUNlU0FVSTdMMnFCTXM0bDljNnpTRDJBNitFV0wxVEc1UGp6?=
 =?utf-8?B?UHJFMDVXd1JmU2VudVpCc1NoOFJuRzlNYXRqQ2phUzlxUWdER1VSZGt2U0pS?=
 =?utf-8?B?SUZVeXlTUGVzU0plb1VsM2FOQXFidHRMTGVsTHh5Mk1FWXN5MjIySGM3RVlC?=
 =?utf-8?B?MG5VcVlDNDFsY2p2eU15andkZjRWNmozRS9MR3cxNmdBRnhVNUtieWp1QU1y?=
 =?utf-8?B?UldYMHpNVGw4dGppY2tpNHRXSm9HTU9VTnBFaUxoa3RrNWo2aDErZy9Qd0k5?=
 =?utf-8?B?Q2FKb2EvTTFEdUVrSGdhUVR2OG9FL2dsRllQMndPTVQ1dEVhY2YzZXdOWE1Q?=
 =?utf-8?B?NXFhcG9icjkxVC94M0pMN0RHV2U0TzZWRGYxTk1XMjB0c20wbHErcVUzRGhV?=
 =?utf-8?B?ckY0M0FjRXRrWmRhcU1nSDh4RnUyelB6RXpBaEUvTnVQZEw3SEJtWVdpblFt?=
 =?utf-8?B?NzZOQ3FxZUdMdmc0b3AzaXNyMGhwaXJjcXFjUGwzTk5kMkVzRmkxZ3U5KzlM?=
 =?utf-8?B?UEZhMXdTYTE2UktURGdLRjNPYzY3OE9EL1ZnankrRi81Qmk5elliUnptT2ZM?=
 =?utf-8?B?Y3FPajgzN1l5OFBVNlpLSmJ2QXJlSEVHQXpXT0YrWGZXb2pVTGhRM0dqdHBk?=
 =?utf-8?B?MG1SWjlRWDF0MG9WMzFQNUJiWFY3WEZYZ2FoLzNveDlyMmJsZGNJUFBHYThW?=
 =?utf-8?B?bG80V2VSczlIV0xVRzZ1VGxjZncrc095Sjloc1B2clB4b3J3NnFWNEZQNE8z?=
 =?utf-8?B?a1ZaUVA5YnZpRml4YUV1L29HWld1UFE1eEZzeWphR1Q2b0Q0U3lxVTRyN3dO?=
 =?utf-8?B?V1pvNE0xSVRCQzNUTzlTYTZDRlNvRkhlRlMzektTRUJGc25ld2R1ajlveHJY?=
 =?utf-8?B?ZDVGd0h2bjZrL1BaaW9MODd4c3lnNlVQUHl0a3dFVU5CQ2I5Ymk4dHl3V0Uv?=
 =?utf-8?B?R2NjVWpwcDBGUFhPWFFpam5UaTFqOWtYZmUwdldQeC9ILzBOa2E1akljZHBu?=
 =?utf-8?B?TnJhWFpQUVppTFpad3hZZHFmcit2RHpxOFFHVDV2WXNYM0RLUzBCNCtqY2M3?=
 =?utf-8?B?SVlnTmlaeU9OR3NIS1crQTRrRTkyYjNpM1V2K1hTa0grQzV1OVdyVXl4N2h1?=
 =?utf-8?B?QkFsYUJVTGFwVkNoOEVWVnpURVpCWVYzZ2dWQVEwUHB3Q2Z1b2xrRHNFQVlE?=
 =?utf-8?B?Q3FoYzZFWEs3dUliUEQzVmpXQjYzOHlteEpPTitCNEhobnpvdlFvdHkzdHAv?=
 =?utf-8?B?NnVyWUpQVWZHWUFUSmJpVnU3QUczNjB3K1RmM0VuWEpZNzhMOW95ckFoeUpm?=
 =?utf-8?B?SFRtNXp0NUJWUHQ3TDN1YkVWdFZVOXZCdncvS1ZlbitqRDFLUnE2akdWUml4?=
 =?utf-8?B?STVTTHZTOUJwQ0NzNkczSHRiWGUwZ0JvQ1VDWWxpL2l3V2NKSExYMzJpQlU3?=
 =?utf-8?B?Q0FjcXU0QjN3N0IwTkhXYkpzY2hkeUxpSmFjQm5yUzJoR1RsVmh5N2JSb1pP?=
 =?utf-8?B?Y2xkTnRTc3hUWEF1YUFsc3ZLWFF1MFhHU3VnL0JVNjNqTTVORkNaSFpyc09w?=
 =?utf-8?B?TDVpakNDZHMwVXlLQkl0dkdBM1U2NnhUdjF3K2FpcVcwRHB6bEx6SHRaN3FL?=
 =?utf-8?B?Wk5sNFVEOG9vWnBybkJ2dnFjeTV2eGt3SEZNd2h0dVhFb3EwY3lQcTRTOERG?=
 =?utf-8?B?NVN4dzNDai9ydVVDcWdISloxa3IzdkUwdFprVzYzSUtBRkwrZktvV3RobEts?=
 =?utf-8?B?VEF0Nkxxc09JNFFPVVNFNFpWZnMrOEZFM0d6dFdWSlFXbXBhWjROZkFzL3Zo?=
 =?utf-8?B?Uk1nV3dzTWpuYWRZZVo4VjR3bEpBanFRZWlpSGJ0UjczekhUTFYzcEtseTFW?=
 =?utf-8?Q?5QdnaQz61aAieBrSO01GWmO43?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8670d0-24e2-4508-4179-08dcfc9dc3c4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 06:56:10.7953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lv3yBQM6oACULIjzmz/TP0/y7asRhDuMVY3dKD24V/zb0KxYFJoxj5Dz/VitRZGzKQefRy7OKZwptlR5A9B2yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6875
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

On 2024/9/30 17:26, Zhenzhong Duan wrote:
> This gives user flexibility to turn off FS1GP for debug purpose.
> 
> It is also useful for future nesting feature. When host IOMMU doesn't
> support FS1GP but vIOMMU does, nested page table on host side works
> after turn FS1GP off in vIOMMU.

s/turn/turning

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> This property has no effect when vIOMMU isn't in scalable modern
> mode.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
> ---
>   include/hw/i386/intel_iommu.h | 1 +
>   hw/i386/intel_iommu.c         | 5 ++++-
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 48134bda11..4d6acb2314 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -307,6 +307,7 @@ struct IntelIOMMUState {
>       bool dma_drain;                 /* Whether DMA r/w draining enabled */
>       bool dma_translation;           /* Whether DMA translation supported */
>       bool pasid;                     /* Whether to support PASID */
> +    bool fs1gp;                     /* First Stage 1-GByte Page Support */
>   
>       /*
>        * Protects IOMMU states in general.  Currently it protects the
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 14578655e1..f8f196aeed 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3785,6 +3785,7 @@ static Property vtd_properties[] = {
>       DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
>       DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
>       DEFINE_PROP_BOOL("dma-translation", IntelIOMMUState, dma_translation, true),
> +    DEFINE_PROP_BOOL("fs1gp", IntelIOMMUState, fs1gp, true),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> @@ -4513,7 +4514,9 @@ static void vtd_cap_init(IntelIOMMUState *s)
>       /* TODO: read cap/ecap from host to decide which cap to be exposed. */
>       if (s->scalable_modern) {
>           s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_FLTS;
> -        s->cap |= VTD_CAP_FS1GP;
> +        if (s->fs1gp) {
> +            s->cap |= VTD_CAP_FS1GP;
> +        }
>       } else if (s->scalable_mode) {
>           s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
>       }

-- 
Regards,
Yi Liu

