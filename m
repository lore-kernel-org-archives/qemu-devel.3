Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646A1C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 08:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZ2A-0005qV-R1; Tue, 02 Jul 2024 04:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sOZ28-0005qF-D5
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 04:38:40 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sOZ24-000115-QF
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 04:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719909517; x=1751445517;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KMYpgf0dvVL/WqRzue6yHL1X35xjAlhSKhzETZnO08o=;
 b=B+X3JyOjLFi7GXu/kWgCGx4WG2KpMs60juGKjftQAv0OB9NU4t0R8I9j
 wZj465vSBaFnZrqAZeEM+BMQ/KGp+m0Y2F2ZZKFa17bJmj0YXdku36Eze
 ajbHiiT+7wPw6B87layFZ8nhxQG2yoE6kqeVaopd8C9AdRQ7bKIgzSKP0
 ntGEjZnqlFvgVJlXl7kz62FAj+aDzNxD9DQqdixiGvO6Ca0BEN9/yzQ+d
 gKXKgPdTJWNZXEkP2NLSkWhnRsOlxwLAP3ASMlyhqmg97pal6Q+iTALkG
 5beopyqYqgICWUyfswBAVtLd33YEe6q+ui0Z2x1a2MbE3v6yIyBDVUeeK w==;
X-CSE-ConnectionGUID: Gbpa7GgFSq+6NM9Mdd429A==
X-CSE-MsgGUID: R8iSr3mkT8aRlHGDgajgEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="20832228"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; d="scan'208";a="20832228"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 01:38:33 -0700
X-CSE-ConnectionGUID: r7vfyJn2RA2qauUEcSf9cQ==
X-CSE-MsgGUID: L89+6gQBT+26q94K6Aq4kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; d="scan'208";a="46559725"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 02 Jul 2024 01:38:32 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 01:38:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 01:38:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 01:38:31 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 01:38:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFu0mzeBXD9+Xi8pr3JTB3klHKDBy5Xr1eC5BukWDTasICnNoi70IETxTPSVorAcv8VWz+rt96hD50ggb2YD/k57VhN2q5Wsy19M65H5Aqk+d0NnuBgms9xabsgRS06DexErD0/3gyIsqZhE6+XLW9c8RNbJ2vCem6kBH+yCTq00ehZeXolTsye5lkLFdNcnZANlZEeoDLlbTSOxwAocz/Qm5dMPmashngftP3EYiKW77Sh6u/NWbHRXntULiuZuQbV25UKbCxxPINjxslTT8ciJn+Eof8vFtMbHCTifyRf1KuV0oQVwYzT2CkENnH0sAgUrSk6ABcu59new+ZcpBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsbHcY/7Kz6ps0gaV8Z/erdGEFevs4QspALwV53RRio=;
 b=XY1x0qrHODpwIFGNokvXUY+T0H2dKLRONCnIv3CCicT8TTnjxFVGbGJM0PlEG1EZjIvZuPnxGLpk1VSXS6d3PVeU9iprvq/zdkMv/Gggx5ckueWx+lX6AL8ygjJsSkzLnnoUhwOFiHVOKRHOAgIRMbLyg1Ni76s1NtlsjLDPqBnbJAzXhpPRBZtBNTxubftGW0o+YjvmUEak320GOcOdDEgAjmxD/TeSa32KtSp0nei2k3zYk3gwbdZR5PQBH+e5WMNrWpCnKEqPDbXFNPcqk/4CkoWRSH7k15Alb5tm8UYC2ac9glNIS1330/7Eyd13xhIWwgbpvQS77TfNVfdf2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA0PR11MB7377.namprd11.prod.outlook.com (2603:10b6:208:433::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Tue, 2 Jul
 2024 08:38:29 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7719.022; Tue, 2 Jul 2024
 08:38:29 +0000
Message-ID: <a791e442-f5b5-4670-9394-876b041cfd62@intel.com>
Date: Tue, 2 Jul 2024 16:42:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Peng, Chao P" <chao.p.peng@intel.com>, Yu Zhang
 <yu.c.zhang@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <CACGkMEvTomFeC1bM3SfY1zGhQ_5i15r6CY6M3jVzau6niNUf_w@mail.gmail.com>
 <SJ0PR11MB6744AECEAA6F9319259B0DF192E92@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <DS0PR11MB752917B52B66A6EF10C10678C3E92@DS0PR11MB7529.namprd11.prod.outlook.com>
 <CACGkMEt5ofYt12A6uKUj=QLcLbOnrGT=UkMpee=MUxO6Xy3sxg@mail.gmail.com>
 <SJ0PR11MB6744C340AAB1B786D3913F5D92EA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEsV05ujKNEL9JSAsfikWGW582yvfSOdHJgRxZC_1cxgEg@mail.gmail.com>
 <SJ0PR11MB67445F7F8B79D2C2B982C1F692F52@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEuO6T-LqcZ=5oRR83LyhZ7oOtZvb70CUksZDAmC1KnsOA@mail.gmail.com>
 <SJ0PR11MB6744135D8C08CEE42460CAF792F02@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <SJ0PR11MB67448F0D3CE487F125D274AF92F02@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20240527025023-mutt-send-email-mst@kernel.org>
 <CACGkMEuCqCNhVvXYN6jT5CDHbnt8sEHUk2UfwVaaOVLXfSfv3w@mail.gmail.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <CACGkMEuCqCNhVvXYN6jT5CDHbnt8sEHUk2UfwVaaOVLXfSfv3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA0PR11MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be3eba5-5011-436a-d280-08dc9a7258f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3F3Si80aGtZTjlSSjM1dUtMNnZONUlERzBaMGUvKzh2bG81SlJoV1V2VGEy?=
 =?utf-8?B?N3dabVZyRE01Yk44ZklaMGszeTZyYzU0a0NkSXRyNDRaS1JzWGx4R1VGR2ZD?=
 =?utf-8?B?QVZLcnpYT0Y0TDl4dUV6ZnJzblZoOFBKSnJXS2d4aVpKbyt4Ull6eW5BRVJr?=
 =?utf-8?B?UjZiS2UxT1QybXZjT0Uzak9FMStSSEFuTUxJa0ZQSjJaUkZLVFF2SUtQeVJX?=
 =?utf-8?B?RU8rWFJxZXJaN29NTzNHRWM5QTZ5elFuQVdDMjVoampaQkRJZGJMUlNDWkJh?=
 =?utf-8?B?Q3RkWld1ZTlBR3l3T3dxMEIxYUhsbUhKL0RrVDNQOEtrbkZLOG1McnBVVVdD?=
 =?utf-8?B?MWRHQzBwdWtpRXlNejk5aitacy9Lb0NtdDBpRGpSaHozY25XVlNZa3JmQytI?=
 =?utf-8?B?VExwQVl1U0wxV3dLcldGcVB6VGQ3WmdwVlRaeGxEdmduaGc3ZmJNVnBQdS85?=
 =?utf-8?B?b3cwVi9ZUERjdVhHSGVRZzhXUUZwd2k0bFczWnVFakNjeld6anRjZ0FGVnY5?=
 =?utf-8?B?ZzRueEl2U09UcGNLdko2VDJnOVI1TnhaSUxxM3psQ0dCeEVrSkhxL2NTcm03?=
 =?utf-8?B?WHlHeG1ZRnJDWmw0bno2eWdWZytzQzE0RlRPc2NoWkdRQys0Wi9LV2c0MU1Q?=
 =?utf-8?B?NnpPNU1Ja25odktWcHgvdWpiWEh2aFhSU0RQNEVIRXU3ZlpORmR0M29hYmcz?=
 =?utf-8?B?NTFoUFZVRWtvWURyT2VMWExkOXBwMEhGRHJ6T1VOcTh4Qm83c2J5NTloaFRR?=
 =?utf-8?B?d2dKbDlIVG82SWJFajRIeFNNK0xBWlZYU2dRZzNaSXVid081RTdvbW5qK09O?=
 =?utf-8?B?dTgwYVpnbHpRQXZXRk9qYlJrODJXeEV1OGhyMHFKcGJ4S3JiZ2s3SDc2VEYw?=
 =?utf-8?B?NUVwQ1c4NE4zOCtWOFQySklOcHVhVVg0NUJxVGJhSkJOa0tEWUNoSm0xSDli?=
 =?utf-8?B?N2pPdEFhd1hFU05PVTFhY1NYK2RjK1pMNlpnaktRelFEMkx6cDBpcmlLQ2NL?=
 =?utf-8?B?M0VBUWRJSUtDZzVRWnJlRCtmSzIydnRPYkxobWJjV1F3RDRXU1VCK05zZW9o?=
 =?utf-8?B?YmI3RVBJVmxNVi9FQkRTNXk0V1FBMVR4TVl3YVZORmNhcENXMVlPTklxYUxa?=
 =?utf-8?B?eWZlQVdwdWVCejRNYVB3YWlHaGRBOTFyUW5abzlvNnJ3QTdQLzlaWjBaTkhW?=
 =?utf-8?B?djJpRTBQRis1RzQzV1NCK0xnTWIxRWJwSmdOc3RlVFE2QjVBdCtncTZaOHNT?=
 =?utf-8?B?eldra0syeG9HQWFpbHozNGhoVjdhN2lubm5PL2drdFZ0cU9sZGRESmc1TGdj?=
 =?utf-8?B?QkYvejRuOVhWaHFFaUlyYTNLS0tlREQrZ2Npb3FXdkNlckU5VlozK0dXUkFz?=
 =?utf-8?B?ZCtLcEx2a2RXc2Z6MGIybDZNWTMzNUR4RGlML2pkcEpYcTZReEg3Sjk0Wmo2?=
 =?utf-8?B?cmFaS3J2L1hkVDhacW1HU0Z0M3pIaWJLelV3emJqVUJ6RHNkWVlaK1AwSU1I?=
 =?utf-8?B?anVMR1MrUUQycWVXQ1JUR2tiUWdlTk1GRFlxVERhYWcxY2w1VW83N3FscmN6?=
 =?utf-8?B?MTVMMm9PMHhKNThGeUUrT3dnUzRSb3BDY0MyaEhHSGRBZDlzMnVqZDJLNmpm?=
 =?utf-8?B?Wi8rRThaRXJCVWxZYlVFN1IzdlFjMmRYTG1maFJZNUNZVVQwaUZNeUR4dm5X?=
 =?utf-8?B?T1ZUeHlmeW1vVFVLcnNJaGF1cXpEU1FmZzQ3Q00rbUhYeGd4ai9jVyt4TUV2?=
 =?utf-8?B?WWxFSU5DRmpvRm5pQmdtam9sQlNreEZOb2I4bXJTRVlCWGswRWd4Zkg5dnB2?=
 =?utf-8?B?cDFEU1lwZGlaSU9GV2dxZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDcvUk0wRXU1NmI5SmVDd0ZVOWJhRkVmY2xaQVpZRTFFT1hVeDJGWkV2N1k3?=
 =?utf-8?B?dG9HQVd5Nms3bThPNWViVTN6QTBqOGJUMjduZzZ1L0RySzJ2V2J6cFo5eTJ1?=
 =?utf-8?B?eVRuQ3ZNWXFFSFdOOTMvdXRGOWFwVko4UUNIRUUrNE11V0F0K1NWVlc5WHc4?=
 =?utf-8?B?QXdZK1E4TDBTV3pVNzlMcUU2ZmVpV3FEd3RaR29Oc1FCejNabTFPVmZqYmY4?=
 =?utf-8?B?ZDdOYmhoRy9PTm5oaG1EUnVZVVl2bzFpL1RDdmNsZ2M3MElOUHBkWUZMUEoz?=
 =?utf-8?B?RnZ0THlQcWpoYjBGTldHTDV5L2kyN3BYYjhDMitPdm0rRHRIZFM5aytUcUl2?=
 =?utf-8?B?dGlZWmZnUzhiS2FBUWo2bGorblpyQVFrNHhXQnZucGJtL3p0bDNhUjdBVlI2?=
 =?utf-8?B?TUlZL0JmZWhrK3oxQWFFQWl5WDYzVDd4TmcwZmxQWXRvZE9mcVBjL01wWFkr?=
 =?utf-8?B?cE9GUjQvbnd5RmdlZFFFMWxhZGQwNndhYkppOVN6NXc3bXNlUld4TlY5VkJq?=
 =?utf-8?B?ZHZraVQzRFBRaTlmYkVmK056V1BUc0Y1Z2tZS25oazMzNEN5cWs3WGErNlFh?=
 =?utf-8?B?YUw5WFlkMXhBQkJacVdGRkJtVytpRzZ2VjZaL2srK1Nna1hldXNYUzJoQTcx?=
 =?utf-8?B?UXpFdlQ3TnMraWR1aFRrQzZBdmJ1aGNuRnVZaHh5Nmh0ZTlKQytBUnl4U1lk?=
 =?utf-8?B?Wi9CNmlrdkdrTXVxU2pncVVyTG1La25lWlIvRW1CaVluZFFGN0lFSXRLeG45?=
 =?utf-8?B?RCtaYVZkejdJODB5Rk5EYWsxdE8yNUdzeXptWUxMVWNDT1JaSnFMSVE2K0U2?=
 =?utf-8?B?SVlvRSt4WE5lN2Y4UlJpbzdpZ0NZRDBvRnZUUWpmUzZKZkJ1Mk9uNDBsbkM1?=
 =?utf-8?B?QTZ4QmNQVkE1enFDOWo0VllNZ1NNNXNWdVRHdVNOZytRUmtGUWE4T3F0SVdL?=
 =?utf-8?B?Y0s4dERsZ1lheVNLd2JVTnV0M0JjMWpMU3lmSmJUUEg4Wk5SQjZIaVB3UWNr?=
 =?utf-8?B?bVFxTGtkMmxzVWdCbWo4Mnh3L2dBU1l5bG5hdjkwZS91NVBDVWJtV0dENWFo?=
 =?utf-8?B?L0tjdEs5NnJJS0NsSm9MMFFYWHJwbWJtMkI4ZThieFVuQWhRdGx6SFBpMWd3?=
 =?utf-8?B?Q0Fja2h3RHJQTjgyaXg5VEFHVjZLc2Qwb25nSkdOT0FJbW8rK2tUQnIraERH?=
 =?utf-8?B?TzJwYlpDekdhZWkwQ0JVcUErT0xXQjlFODgwcWgydDVjSW1BZnlkdUcwUUxh?=
 =?utf-8?B?YnY1cmQ2K2FqUzBVaHh6YlVyQlAzQnN3Q2ZQbFhGYnJEcUh3VlJVbzlidzJ4?=
 =?utf-8?B?VVVVK0l5dndjTlVKUVROcXNhS0FyOW40aWt4SkE0ZDQxbyt4TzVzbVE4dWZ5?=
 =?utf-8?B?Q0Z0SFEvelVkZVpKVWRtenYzZW5RODZkVWRZQ0VodWVRdllyMHk0ZENSV3o1?=
 =?utf-8?B?VTJ4bHRzN01LYmJPVGgreDZ4VzRBbkZCSW85b0tyZTNuWUNJV24xZmlmYnI3?=
 =?utf-8?B?MmpoL2IybVdScU5BUzdjalZKbWZwUEttZ2VVZ1NHMitSWFZLRU9uZ1cxb3ha?=
 =?utf-8?B?Umg2Y3QxZG9wZFRqdG1JbDA1YUpTOVFhREJrZGI1N1NITzVHMnF3ZVdUdytX?=
 =?utf-8?B?QzQyL0xCaTAxalJ4NnE1UzU2QjBzanhRak1BWkI3bVoxUVJRWVhVdUJnMmpn?=
 =?utf-8?B?R2dOaEhFamxqZHNNT2p3QWdqdUZ5R1hTdW5sM24weUpYZlFDczRoNUh1V2l3?=
 =?utf-8?B?QmN5cDcxMU54MnNFMUptM3orTVljajFYR1FlZlB5SFdpWERJTEJiMVM4L0JM?=
 =?utf-8?B?clVybHRvb0l1aXBKMnp3Z2RvZ2tEaVVZd3hnQmxQUFhKWTZQbHVZa2dZTEJj?=
 =?utf-8?B?TlJQZ0ZYdHRzVDFTU0tHQUthRmlXSVlKbFNOajRNZkp2cTAzMWNFdlZjRTFi?=
 =?utf-8?B?NDNqY1NkQU5uWTc0RzY3VTg5U3crZGUzcHRtbWtlemRaNWJUNHpUSmJkUTM3?=
 =?utf-8?B?Y25TTkRPUG91QjNSQUQvbTJ6N2ZjYzVRRzR1ZXRURlloSE1Xb3lmZUg5aFVv?=
 =?utf-8?B?UGVJVWVtK0xjNm5jNkpzWVdVeGNBMzhVS2pxbzE0bVhieUVleFJkRUIrS2hD?=
 =?utf-8?Q?eOUBk5JfpWAZtDpaR+BiiPN6v?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be3eba5-5011-436a-d280-08dc9a7258f3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 08:38:29.0025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2g2FvhqlQXekbWgkeqzG8OgbgJfLNG/qcu7c8WTLkml5fbswe4Hd3VTp68kl8fXfNCreor4HbuR7robtG0lrFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7377
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi Michael, Jason,

On 2024/5/28 11:03, Jason Wang wrote:
> On Mon, May 27, 2024 at 2:50 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Mon, May 27, 2024 at 06:44:58AM +0000, Duan, Zhenzhong wrote:
>>> Hi Jason,
>>>
>>>> -----Original Message-----
>>>> From: Duan, Zhenzhong
>>>> Subject: RE: [PATCH] intel_iommu: Use the latest fault reasons defined by
>>>> spec
>>>>
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Jason Wang <jasowang@redhat.com>
>>>>> Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons defined by
>>>>> spec
>>>>>
>>>>> On Fri, May 24, 2024 at 4:41 PM Duan, Zhenzhong
>>>>> <zhenzhong.duan@intel.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Jason Wang <jasowang@redhat.com>
>>>>>>> Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons defined
>>>> by
>>>>>>> spec
>>>>>>>
>>>>>>> On Tue, May 21, 2024 at 6:25 PM Duan, Zhenzhong
>>>>>>> <zhenzhong.duan@intel.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>> -----Original Message-----
>>>>>>>>> From: Jason Wang <jasowang@redhat.com>
>>>>>>>>> Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons
>>>> defined
>>>>> by
>>>>>>>>> spec
>>>>>>>>>
>>>>>>>>> On Mon, May 20, 2024 at 12:15 PM Liu, Yi L <yi.l.liu@intel.com>
>>>>> wrote:
>>>>>>>>>>
>>>>>>>>>>> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>>>>>>>>>>> Sent: Monday, May 20, 2024 11:41 AM
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>> -----Original Message-----
>>>>>>>>>>>> From: Jason Wang <jasowang@redhat.com>
>>>>>>>>>>>> Sent: Monday, May 20, 2024 8:44 AM
>>>>>>>>>>>> To: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>>>>>>>>>>>> Cc: qemu-devel@nongnu.org; Liu, Yi L <yi.l.liu@intel.com>; Peng,
>>>>>>> Chao
>>>>>>>>> P
>>>>>>>>>>>> <chao.p.peng@intel.com>; Yu Zhang
>>>>> <yu.c.zhang@linux.intel.com>;
>>>>>>>>> Michael
>>>>>>>>>>>> S. Tsirkin <mst@redhat.com>; Paolo Bonzini
>>>>>>> <pbonzini@redhat.com>;
>>>>>>>>>>>> Richard Henderson <richard.henderson@linaro.org>; Eduardo
>>>>>>> Habkost
>>>>>>>>>>>> <eduardo@habkost.net>; Marcel Apfelbaum
>>>>>>>>> <marcel.apfelbaum@gmail.com>
>>>>>>>>>>>> Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons
>>>>>>> defined
>>>>>>>>> by
>>>>>>>>>>>> spec
>>>>>>>>>>>>
>>>>>>>>>>>> On Fri, May 17, 2024 at 6:26 PM Zhenzhong Duan
>>>>>>>>>>>> <zhenzhong.duan@intel.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> From: Yu Zhang <yu.c.zhang@linux.intel.com>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Currently we use only VTD_FR_PASID_TABLE_INV as fault
>>>>> reason.
>>>>>>>>>>>>> Update with more detailed fault reasons listed in VT-d spec
>>>>> 7.2.3.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
>>>>>>>>>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>
>>>>>>>>>>>> I wonder if this could be noticed by the guest or not. If yes
>>>> should
>>>>>>>>>>>> we consider starting to add thing like version to vtd emulation
>>>>> code?
>>>>>>>>>>>
>>>>>>>>>>> Kernel only dumps the reason like below:
>>>>>>>>>>>
>>>>>>>>>>> DMAR: [DMA Write NO_PASID] Request device [20:00.0] fault
>>>> addr
>>>>>>>>> 0x1234600000
>>>>>>>>>>> [fault reason 0x71] SM: Present bit in first-level paging entry is
>>>>> clear
>>>>>>>>>>
>>>>>>>>>> Yes, guest kernel would notice it as the fault would be injected to
>>>> vm.
>>>>>>>>>>
>>>>>>>>>>> Maybe bump 1.0 -> 1.1?
>>>>>>>>>>> My understanding version number is only informational and is
>>>> far
>>>>>>> from
>>>>>>>>>>> accurate to mark if a feature supported. Driver should check
>>>>> cap/ecap
>>>>>>>>>>> bits instead.
>>>>>>>>>>
>>>>>>>>>> Should the version ID here be aligned with VT-d spec?
>>>>>>>>>
>>>>>>>>> Probably, this might be something that could be noticed by the
>>>>>>>>> management to migration compatibility.
>>>>>>>>
>>>>>>>> Could you elaborate what we need to do for migration compatibility?
>>>>>>>> I see version is already exported so libvirt can query it, see:
>>>>>>>>
>>>>>>>>      DEFINE_PROP_UINT32("version", IntelIOMMUState, version, 0),
>>>>>>>
>>>>>>> It is the Qemu command line parameters not the version of the vmstate.
>>>>>>>
>>>>>>> For example -device intel-iommu,version=3.0
>>>>>>>
>>>>>>> Qemu then knows it should behave as 3.0.
>>>>>>
>>>>>> So you want to bump vtd_vmstate.version?
>>>>>
>>>>> Well, as I said, it's not a direct bumping.
>>>>>
>>>>>>
>>>>>> In fact, this series change intel_iommu property from x-scalable-
>>>>> mode=["on"|"off"]"
>>>>>> to x-scalable-mode=["legacy"|"modern"|"off"]".
>>>>>>
>>>>>> My understanding management app should use same qemu cmdline
>>>>>> in source and destination, so compatibility is already guaranteed even if
>>>>>> we don't bump vtd_vmstate.version.
>>>>>
>>>>> Exactly, so the point is to
>>>>>
>>>>> vtd=3.0, the device works exactly as vtd spec 3.0.
>>>>> vtd=3.3, the device works exactly as vtd spec 3.3.
>>>
>>> Yi just found version ID stored in VT-d VER_REG is not aligned with the VT-d spec version.
>>> For example, we see a local hw with vtd version 6.0 which is beyond VT-d spec version.
>>> We are asking VTD arch, will get back soon.
>>>
>>> Or will you plan qemu vVT-d having its own version policy?
>>>
>>> Thanks
>>> Zhenzhong
>>
>> Not unless there's a good reason to do this.
> 
> +1

Had more studying in the spec. Bumping up to 3.0 might not be trivial. :(

The VT-d spec has some requirements based on the version number. Below is a
list of it. Although they are defined for hardware, but vVT-d may need to
respect it as the same iommu driver runs for both the vVT-d and the hw
VT-d. Per 1), if bumping up the major value to be 6 or higher, the vVT-d
needs to ensure the register-based invalidation interface is not available.
Per 2), if bump up the major version to be 2 or higher, the vVT-d needs to
by default drain write and read requests no matter the software requests it
or not.

1) Chapter 6.5 Invalidation of Translation Caches

For software to invalidate the various caching structures, the architecture 
supports the following two
types of invalidation interfaces:
• Register-based invalidation interface: A legacy invalidation interface 
with limited capabilities.
This interface is supported by hardware implementations of this 
architecture with Major Version 5
or lower (VER_REG). In all other hardware implementations, all requests are 
treated as invalid
requests and will be ignored (for details see the CAIG field in the Context 
Command Register and
the IAIG field in the IOTLB Invalidate Register).

2) Chapter 6.5.2.3 IOTLB Invalidate
• Drain Reads (DR): Software sets this flag to indicate hardware must drain 
read requests that are
already processed by the remapping hardware, but queued within the 
Root-Complex to be
completed. When the value of this flag is 1, hardware must drain the 
relevant reads before the
next Invalidation Wait Descriptor (see Section 6.5.2.8) is completed. 
Section 6.5.4 describes
hardware support for draining. Hardware implementations with Major Version 
2 or higher
(VER_REG) will ignore this flag and always drain relevant reads before the 
next Invalidation Wait
Descriptor is completed.
• Drain Writes (DW): Software sets this flag to indicate hardware must 
drain relevant write
requests that are already processed by the remapping hardware, but queued 
within the RootComplex to be completed. When the value of this flag is 1, 
hardware must drain the relevant
writes before the next Invalidation Wait Descriptor is completed. Section 
6.5.4 describes
hardware support for draining. Hardware implementations with Major Version 
2 or higher
(VER_REG) will ignore this flag and always drain relevant writes before the 
next Invalidation Wait
Descriptor is completed.

3) Chapter 11.4.2 Capability Register
Hardware implementations with Major Version 6 or higher
(VER_REG) reporting the second-stage translation support (SSTS)
field as Clear also report this field as 0.

4) Chapter 11.4.8.1 Protected Memory Enable Register
• Hardware implementations with Major Version 2 or higher
(VER_REG) block all DMA requests accessing protected
memory regions whether or not DMA remapping is
enabled.

Also, as replied in the prior email, the VT-d architecture reports
capability via the cap/ecap registers. The new fault reasons in this
patch is meaningful only when the ecap.SMTS bit is set. So bumping version
does not mean too much about the introduction of new capabilities. @Jason,
given the above statements, can we reconsider if it is necessary to bump
up the version number?

-- 
Regards,
Yi Liu

