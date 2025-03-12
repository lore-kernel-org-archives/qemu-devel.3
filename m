Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2302C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 12:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsLWV-0005z7-Bs; Wed, 12 Mar 2025 08:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1tsLWT-0005yP-4B
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 08:49:21 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1tsLWQ-0004qw-Gl
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 08:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741783758; x=1773319758;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nds6hbZauFLL3KhbvE7KH0/DXwdTDIYc3rTOIKIUckA=;
 b=RGjx34VhZjdXs8Yp6ue6GY7lYRF2gYS+VAwvLsVpTzlHegN42iPDpBGj
 qXeXq1/RG5OyNXkX+W14FMRSvJ2YxRJLGOSSauVapRJaJbftAbjEo/5rJ
 hu314dz8hf224+jSzoXHFOfrcRV14kd0EviKZd2nrDG1nJL9DnC2QqVl+
 IX2Mmzb4OEPvgLBNoQXawgspUtBlSBh0hj5767UMCF0Q8O/0wPt6cRWm9
 hprsuH765pWSNABTMGhDZAbjBXd55LIt/b4tj/I82Bf+0o1Ikc6moO4SA
 QbpwdGlTh159SagQG/DN3jdRuyTsSsidABbs0FXSp8nICOIVPlfuO6wD7 A==;
X-CSE-ConnectionGUID: m38Val+0R3eNtvtpdk2t7g==
X-CSE-MsgGUID: bsnvHnODQ8WI4dzfyxzKAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="60401724"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; d="scan'208";a="60401724"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2025 05:49:13 -0700
X-CSE-ConnectionGUID: p/DOLckmSOWDWQPk3lv74Q==
X-CSE-MsgGUID: 0WFhaG/kRIW5COENAsoLDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; d="scan'208";a="121326668"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 12 Mar 2025 05:49:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Mar 2025 05:49:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 05:49:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 05:49:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTRrt0tGyJTZeU7v8HMDzj9i9+tHqrInElOv766zfja12tSVXNUUsJkFgXgOLL1E7nEzUgRihNsc7FfCgQhPIXuL4TxpiCUYVmve1rpJkpmDmm40oP2FIhA6gbPtSPwThvA9dKpgD/fDNztCe+bKPxRC/O0BjzX9C1zUyrppzQbMbvdVC0d0QD6bjgLYn+/UmYI6N1NBDEfU4ndiG/znLz7kIqUp7Ko9Ab0dhPq5ap6XZp/37NxkqRS5cicrDWj2lxAC400QngFMQWxpvZ9wgweZrNkEgoL9S//pZuHBUVApZu3h2wbAz/CtvBFjZEPXw+v/x7oCNl9Zyl5bhWII7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A64jUIfUvBUxCJvgEOrHmakA5DZKwozwgaogBkRdQ98=;
 b=L+YQODiDkd4gvTPr/Vt2a+5Y8uYMOg8y0Aoj+OftHhd1B2lG0bKOBW+FJZEMdx7D243VtBP6YIwI3bZ1TgfoXHBbjvQ6OvMJPRXAsAU60lzW3Tyc/r3a0H7IoG1W1TsG7ZADSkDeJvaGTg+RYGU3zSiM2m2Wj8SnVCgo8wSNDOnaa3RRFJnXFIpsIS7FzZAgvhnMkceUdXr38HhJEQWLbyNCex0HpRbQ7wN+eBHBazjsJ/+JrInUeYA5BOxHpcKy3Lruqq2WzPnK6w67nWpDb+2rHxh99BVRhfcY949wJ9UAvP9Y64NySHyQ0s+l3YegV64lw1H6s6h+55DjatlxgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY8PR11MB7084.namprd11.prod.outlook.com (2603:10b6:930:50::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 12:49:10 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 12:49:10 +0000
Message-ID: <ca6ab1ec-4f30-4da7-ac08-3a514d8b4a02@intel.com>
Date: Wed, 12 Mar 2025 20:54:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Giving your own patches your Reviewed-by
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Markus
 Armbruster" <armbru@redhat.com>, <qemu-devel@nongnu.org>
CC: Akihiko Odaki <akihiko.odaki@daynix.com>, Bibo Mao <maobibo@loongson.cn>, 
 Peter Maydell <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?=
 <clement.mathieu--drif@eviden.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <878qpamvk6.fsf@pond.sub.org>
 <9329310c-bfad-44aa-a53a-87c1f39668a2@linaro.org>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <9329310c-bfad-44aa-a53a-87c1f39668a2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0060.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::24) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CY8PR11MB7084:EE_
X-MS-Office365-Filtering-Correlation-Id: 012af4c2-bbcb-432c-4b7b-08dd616448f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVY2RTJrMXkzeWNZcmdKQ3RqbTNoakJLemV6SCtEZjJNZVRMbDJIOFZnK29v?=
 =?utf-8?B?eWRoM0h4Qm5SaTd3aEwxV2Z1dk5MVkRVOUlneHErMG9DQlAranl3MnJGcHFY?=
 =?utf-8?B?b0NLK0MrN1I0TUFlVys3RFd6amxFaTJJaHNHRTBoZ1FSQmg3UVU0Tmo3RUhF?=
 =?utf-8?B?UUdQalBSSzIrR2pnS1E1bDdsYkVBTFFBcVpPODd5Q1ZVc1U4eC9LVm1qRzRV?=
 =?utf-8?B?bkt0TEJTZGxiNDc2bE9QTFVQNmdIYVpjYm9XajM1MXRvalJXMFZrcWc5UmtB?=
 =?utf-8?B?RlFNdU9KUWRKTUNxOHR6MHNXTVRNNW5FbkJmaVpqMVVJUG93RG1Cc1lWMkJo?=
 =?utf-8?B?Nm0yUFpsdVl2VjNBVi9YTTR5RlN4ZGVSUGkwZEpTSWtWNnk5RDIxTnYzZGhD?=
 =?utf-8?B?enlTQmU5V0l6TEkyVWJMUS9nVjM1cWFucjVSNFJtTVk2NGRoNXczeUdvWElO?=
 =?utf-8?B?K2NVNnV3K0hXOFBMVXliTmNVSTNrNkxLVWpmZjg4OEdDQ1VjRDFjVDZuVUNy?=
 =?utf-8?B?RFFibXFveEtMOEtLS3FRbGdvQVhLNWdiLzhsaEt1WW5MSnVRb3lqS0pvSXM5?=
 =?utf-8?B?aGRzZW9wOGtQeldMRTNBcEVXSExKdE0reWdSejM1cmNoUVdoRHczWEQ4QW9G?=
 =?utf-8?B?aVo3UTVVamE4ZGE5aWszTmkrQ0JmL0lQdE5EZlZqZzRhVWhrdlcxNEpDNzYw?=
 =?utf-8?B?b2NlWjYzT1BucUtseVNndXJGYzllenM1Wms4T1Jxc1NjMDBHWkp6YXJGdWZS?=
 =?utf-8?B?S1F2aThoc1JLTlY2WmpWOWlSL0pPSFVnRmV2Y0VTY3gwc3ZTdEp0NFVVelBv?=
 =?utf-8?B?VE9LSmlqd1B5UzU3amZlRFQ1SFM5ZDFIK1lBM2xFRjBNRmkyeDArZ1ZYZGpY?=
 =?utf-8?B?NDI2NHdGdTJuazJ1VlpoZTZ0NjQ1cjJPTzBaVHJCUGhkT3lzMmdIa3JpRUpM?=
 =?utf-8?B?NDlYcExJQWgxRWoxcFVCVDljc3ZvTDRva2pmMHZhbHVkRFpya0hha3h0K0N6?=
 =?utf-8?B?dUZJVTljYUR6WnczODZmSVYxc3hWbzVJdTdNK2k5b3gxTitQUHJtdGNQdmtL?=
 =?utf-8?B?cXVSQk5UbDQxeDNTbHQ1QmcxZWN4Q1ZRdTVMYTlCdXlxUjdxYzVBSENuNFJG?=
 =?utf-8?B?OEI2alBveGl1Zzg1V0RWZit1SnVqcHFCUlN4dHIvSkwrMjQ5S0p1WGgxSTRx?=
 =?utf-8?B?VEtQQVZNblpRajN4NXlLc3Z3L1VKMWs4YVo1cjRSWmcybldXQlRIekZEK2lR?=
 =?utf-8?B?MjI2V1N2OVZ6bldmYmhPekRCWXN5UmpmOW5XQk5oWS80YTNSM1lVYUdhS2pL?=
 =?utf-8?B?VldyZDkzY0NXbjNTeFo2bWY4WXhpYWE1Q1ZoTXF3R0U3T0pyTkZVOTNGSFIy?=
 =?utf-8?B?eDMzUXhKZWNhSWFhR0pUeTZBd0ptbzYrYTVyM3RoS0czRkw5T0YwUnFqNW1G?=
 =?utf-8?B?SHFyODhCaUNHcmQvYzlrdDk3SU1WSzBZVWk0SDRKSHpaUjVSUDVHZnFQaWxY?=
 =?utf-8?B?OEpJQVdQenBZSzE5YSt3elgwWTgzRnNhZ3BJN0prTHB1VDJRbzJFdjFES3JQ?=
 =?utf-8?B?YTZWbytGZ01oQnZadWZUQTRhaGZhUnlNNmkxdmlCNm9xek9tUmtFOXNJdnlW?=
 =?utf-8?B?WDJnOHpTZkhYeW91dGpRY2w5cjBmQmM0ODBaaHJPU3I0RnIya0kvaU9UUE85?=
 =?utf-8?B?QjA1ZEg3SmIwQmpOd254R2NaM2hxR0hFUXZvTENsakQxZy9YS1VDaklOaVZq?=
 =?utf-8?B?T0tUQ2RDZG9HVWpxbml6ZlR0Q1ZEUml1QjVkYTlienRqdEZVY01tS1dVSkc3?=
 =?utf-8?B?dFdqYXpKTG9HY1NKR3RGcVQxaFVOTGM3VlphTzI3ZWR4aWJqQnVCT0tCWnJD?=
 =?utf-8?Q?YhwAs1L9tsd0u?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2d2eisvSWZkRHFCSkhqK0p1TTczVzQxZ0E5UFM2L3lSeDB4MjBXVWIzMkdQ?=
 =?utf-8?B?cTVESlRYUVZ3OXI5UTVyVXR6Q3NvVW40NXlzYWJQZkszMUR4RmIyVG9HeFM0?=
 =?utf-8?B?aURDMm5QRHlrdnpQa0lhWW9yN01OaDhXbDFHV0FUMS9WR0ZQc2VFZUpYcHNm?=
 =?utf-8?B?Z3lJSWgrS1ltTmplcmV5YzV3eFRKMmNXMlUrWlZmR0FvSXhyM1JlbEYzRTh3?=
 =?utf-8?B?bTl3N0ViZ2hib0FGK1lKenB0QlZpSWIwSUZvbmdFVHdhTWd6RE8wNnZ6amhH?=
 =?utf-8?B?V2gxWWwxemtVc29nYm5MaW9pcCtXV04rYVhhUjZoSmJPZEZVcGdYMFdiVmxW?=
 =?utf-8?B?cDFmYWFuVnNhTWxFaGJzZkk4bHVtaW0xYjRwcWJuTE03cWxoN2FUaDZRQ0Yz?=
 =?utf-8?B?SkNqZTBQeis5NHZpVUp5Rm9HSUtBN1ZtV1BIa3g0K1hYVkUrRWkvVnZDU053?=
 =?utf-8?B?YWh1SG1jSmNQeExpL2xGN1FPMld4Q3l4VDEvYUE0Z0JtQURKeVlQRVFoTFJF?=
 =?utf-8?B?blY5NWwwQi94ZzJsdTgzYllLUUxpOU5uTDBEZVdSYVl6RWJOR1VLOXRzZnpl?=
 =?utf-8?B?ckNlUW9BaFlmSFVhSFhzU2F4STJySEFtbjNsN1AvbTFYTFlNNjkrcnBhMUZi?=
 =?utf-8?B?UVdZMlVUUVYwTVNGUy9EMWxMZ3BhR2JxNmd0MDl3UGNTNzMrODhsVnhyQ05m?=
 =?utf-8?B?YnAvQzFvQlhEdVVHTnNKdHFmeHREeFZOTmxkS2NFSFAvVFJhQzJjU3JIL0lZ?=
 =?utf-8?B?QURJMERkQWtMOVRXaGNXSVQxeXMva0JpL014VFJscGhkeXNwTUFjTkc3S1Ax?=
 =?utf-8?B?aEREMys4K1IzSFhFMExpbFBhd0FxM3dSS0FyQW5GN3gzZVBic2VQeGVmQlp3?=
 =?utf-8?B?eXFrb2s0RDEvUGlDQTBuUmIzemlIZUh1aHlkb05naExhaFhaMXdjS084aVFm?=
 =?utf-8?B?azZIVTNuQkhQTFBMdzVkdm9oM2N3TWhjdG1JREpRUkp0MVl3K2doa29IelRq?=
 =?utf-8?B?S293MERZcThPT3ltR25UNUh3Q3ZKcTU5VHlRd1ltUUhBb0xZaTZIVjRHOUkw?=
 =?utf-8?B?U3V2OGdISDNXWFFBb3djSVI4bC9mOTJEWkV1cGhrMW40V3ppWGtERzFUTWJh?=
 =?utf-8?B?a2dHeUVVK0lQNjBlREE2LzdXdzc3NkJGcklzRlRWM243S2kxam9NUXRKcDFp?=
 =?utf-8?B?ZFEzV2dESmFmUHROWHdGSGJEKzJPRjBnRmthU3NCclZNY0xMOWtWWmNOVlQ5?=
 =?utf-8?B?OGNqalBHV1o3aU1ucXJoMHkxdlpXNmc3N3Q0NHJxYllzSXpjVGhDbHo0M2R5?=
 =?utf-8?B?THUxMjhFRDk2cXo4MC9BZ08yS3NtYWIxenZXbFpzNDhCYUZjdEh6ZTdmTGhD?=
 =?utf-8?B?YUZOSE93Tmh3QWlaSHp1Rk8yU3QzamQrUU5DWUhlYVp2V3RpNUpzNDRXL2Fs?=
 =?utf-8?B?QnB2RUoyVkFRL3psci9NSDlOenFNMFY1bFlZV2VMYmNHNXZ2R1Z6bEZJbDhl?=
 =?utf-8?B?aXJDU295aUxOWnhTQW80cWRrWUxycUltNTBkaWhaaWVieUQ2QXh0bXlYcDVq?=
 =?utf-8?B?L1Jua05yR0VUUWtaVlNLbkJPR2duTm5oN0d3RFFrM09mTjg5RldBR21EV1k4?=
 =?utf-8?B?S1hKT2tvRGZybmM2VUFIc3Bkd2JiWXYvb0svRm9rRm5zbU1CWUk2dU9KY3E2?=
 =?utf-8?B?L3kwdEVCZUI0a0xoQWQ2TnIxWmxTYzFzVTJMZXNzN3JjWnBLWmt2WEoyN3pp?=
 =?utf-8?B?Q2doUzA2Y3hPNk5zZU1xdGZVSmtZVFFzOFRVdE1NWXByL29NbWZVNWlzMWN2?=
 =?utf-8?B?Y2IyMmtpUEMrOHA2RnZMK3BRQ1g5UjVlSWgza093TVpoOENxVGdvN3NMeGox?=
 =?utf-8?B?aWlsQmxpaGdKb3FvRzBJU3paWVhxbjZXRm4xd2JYUUl4blZ4enBXSndWMHMr?=
 =?utf-8?B?VENjT0Nwci9MT2FBK0pTWW5PbWV6TVNFZnZLbVhjbERheGtaNW50R0tRRG1K?=
 =?utf-8?B?Y1NOZldxSGRvOFlMM2JJd2lGNGs3R0tSOWV0UWQrK1M1OTZxWGVwb3VVUkNS?=
 =?utf-8?B?WEV6UU1jYmZPNkVpemE5eFZ0dU02bGZVRmxZSGdzc1d3SHRMT28xOURNenUv?=
 =?utf-8?Q?Wp3q58sXC62AG9pA4iDp1q4Bi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 012af4c2-bbcb-432c-4b7b-08dd616448f0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 12:49:10.8001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEDIr13aLTaXOOFWscs78gdHRA5s+hdqFgOtdLMdgSLN74nkVsdXiko6Ena+lzKGPoPE05Y23XsMgMFA5yk2VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7084
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

On 2025/3/12 18:03, Philippe Mathieu-Daudé wrote:
> Hi Markus,
> 
> (Cc'ing Yi, Clément and Zhenzhong for commit eda4c9b5b3c)
> 
> On 12/3/25 10:45, Markus Armbruster wrote:
>> I stumbled over commits that carry the author's Reviewed-by.
>>
>> There may be cases where the recorded author isn't the lone author, and
>> the recorded author did some meaningful review of the patch's parts that
>> are not theirs.  Mind that we do need all authors to provide their
>> Signed-off-by.
>>
>> When the only Signed-off-by is from the recorded author, and there's
>> also their Reviewed-by, the Reviewed-by is almost certainly bogus.

yeah, that might be sadly possible. :(

>>
>> Now, accidents happen, no big deal, etc., etc.  I post this to hopefully
>> help reduce the accident rate :)

a dumb question. Where can I view this issue?

>>
>> Here's my quick & sloppy search for potentially problematic uses of
>> Reviewed-by:
>>
>> $ git-log --since 'two years ago' | awk -F: '/^commit / { commit=$0 } 
>> /^Author: / { guy=$2 } /^    Reviewed-by: / { if ($2 == guy) { print 
>> commit; print guy } }'
> 
> 
> Explaining some commits where I'm mentioned:
> 
> commit 1e0d4eb4ee7c909323bffc39bc348eb3174b426b
> Author: Philippe Mathieu-Daudé <philmd@linaro.org>
> Date:   Fri Apr 12 00:33:30 2024 -0700
> 
>      backends/tpm: Use qemu_hexdump_line() to avoid sprintf()
> 
>      sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1.
>      Using qemu_hexdump_line() both fixes the deprecation warning and
>      simplifies the code base.
> 
>      Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>      Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>      [rth: Keep the linebreaks every 16 bytes]
>      Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>      Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>      Message-ID: <20240412073346.458116-12-richard.henderson@linaro.org>
>      [PMD: Rebased]
> 
> 
> I posted a patch with my S-o-b; Richard took it, improved and reposted
> it with his S-o-b; I reviewed Richard's changes (and eventually merged).
> 
> commit 0fe4cac5dda1028c22ec3a6997e1b9155a768004
> Author: Peter Maydell <peter.maydell@linaro.org>
> Date:   Mon Jul 17 18:29:40 2023 +0200
> 
>      target/mips: Avoid shift by negative number in page_table_walk_refill()
> 
>      Coverity points out that in page_table_walk_refill() we can
>      shift by a negative number, which is undefined behaviour
>      (CID 1452918, 1452920, 1452922).  We already catch the
>      negative directory_shift and leaf_shift as being a "bail
>      out early" case, but not until we've already used them to
>      calculated some offset values.
> 
>      The shifts can be negative only if ptew > 1, so make the
>      bail-out-early check look directly at that, and only
>      calculate the shift amounts and the offsets based on them
>      after we have done that check. This allows
>      us to simplify the expressions used to calculate the
>      shift amounts, use an unsigned type, and avoids the
>      undefined behaviour.
> 
>      Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>      [PMD: Check for ptew > 1, use unsigned type]
>      Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>      Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>      Message-Id: <20230717213504.24777-3-philmd@linaro.org>
> 
> Peter posted the first patch, I reworked it and reposted,
> Peter reviewed my changes.
> 
> commit c4380f7bcdcb68fdfca876db366782a807fab8f7
> Author: Richard Henderson <richard.henderson@linaro.org>
> Date:   Thu Jan 18 21:06:30 2024 +0100
> 
>      target/arm: Create arm_cpu_mp_affinity
> 
>      Wrapper to return the mp affinity bits from the cpu.
> 
>      Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>      Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>      Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>      Message-id: 20240118200643.29037-10-philmd@linaro.org
>      Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> 
> Is this workflow making sense and accepted? Otherwise what should
> we change? Maybe clarify along with the tags; or including all
> Message-Id could make this easier to track?

Commit eda4c9b5b3c is the similar case. Zhenzhong and Clément took
the patch from me and I was cced when Zhenzhong sent it out. I gave
my r-b after reviewing it.

-- 
Regards,
Yi Liu

