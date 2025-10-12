Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAD0CCD187
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 10:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7tFi-0004pj-2y; Sun, 12 Oct 2025 06:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v7tFh-0004pZ-4e
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 06:24:33 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v7tFf-00058u-0d
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 06:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760264671; x=1791800671;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mYuEHlbOEfgY5E3yEI/ZxJpVv0h2BQWJDA81w8RS1I0=;
 b=ge79Fr8SuFil3UpH/hsCs9rhMvojaza3nG4mTjwlCwnnKFzkC8HmpfXl
 7Yt50+9VMr+zhm7LkJ8OurwrqzHBfEOKPJe4kXRWGwrf/e+gFyl//SBMD
 shdmmvzxshnNhi3zuVNsjGTlJjYEy0XM/2n0w1ibCrrCogOm2QEjfL1ne
 if9J24W2OfEiNP0f4pouO43I2IDGffoY6apskACbijPanP19tmpUYYFTV
 ftzbdcIEct8Bc0lRkLSUwC4f5jpJD1nB5NzW6Stzhcsuvkjag1U0Rn2hZ
 4XELhIvH6XFqw4cdMFezGSkOO5unBSZLHSkhkHDvHayuvTg6twyvzKToe A==;
X-CSE-ConnectionGUID: z0KeNXJ4TOK6WWEiWeUwFQ==
X-CSE-MsgGUID: m04Jm49JRBmcuhcty9OPjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11579"; a="66076257"
X-IronPort-AV: E=Sophos;i="6.19,223,1754982000"; d="scan'208";a="66076257"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 03:24:27 -0700
X-CSE-ConnectionGUID: SOvOIdkJSbWxGzq+ks879w==
X-CSE-MsgGUID: 08YRn7HGQ2WY5VoBm8i7Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,223,1754982000"; d="scan'208";a="181367726"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 03:24:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 03:24:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 12 Oct 2025 03:24:25 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.56) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 03:24:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcDZf+x0Ijd3H4tgdfoCjTnTbCMH7+ipyjWrlDh4HizzuU6UpENQWOBDsZy+Yn/Iuzy7x+H0kZfKkLZJL73nV+L1v2W95niH2lX3o6oA3zary25I4BnIOVNRooyu5YTKl8BEMy3mJF/EbguQ8spmV/iHeurQPyXGAwr7J/AySarR3898sZcewmt52Ew4A1oBfVZO/WVoPKwX9IXUFi0owUDGmIvDIKMtxtzVr5/Nu0Vwa4dS07RKLVzxPX798vQSuCyP4/EImEedx9hHa0iBhMiggA7TAMXxiHBOOemN9s8hyf1wMdOos2/fFhlrL2vsLEslgLRPmb3KX3BoKoE07w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEdw4FMtxOPh3vL2z4U8vm8Z1JEJSqiQRodaNp41Ymk=;
 b=jx06AtrIGZrupZ7M1kjEevns+ge2yI8XRFSmg+dpzmqYdVcm/jN9xl2quU9pZyAILgtmmuwSzo1672HahuN5NGWjqqdbEN/FNX9V+nlmC/T9fy8Xu68l695pNzrkzQo5OLT13NHnY6nZ14rasqqhl8cfUtDRShErTv+lkKdj5VNQdKQrU1NYtny1UQSrN852/QfJaRb3V62PTGZs9Z6qWF49+Z+Z1xFuqGjVPwdm+OSVO7F4tMaFbyhIebsRem1PWnw2W/1rz/O0D7Ildl3jFdtUlOVdqXqWHryiSh726a/fdPqrUzIiYwUNF4AmBYjsUZQGpBffKYhlyd9vle3wXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by DS4PPF9E4E1C227.namprd11.prod.outlook.com (2603:10b6:f:fc02::3e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sun, 12 Oct
 2025 10:24:23 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9203.009; Sun, 12 Oct 2025
 10:24:23 +0000
Message-ID: <bc51d154-be8e-47d7-abe7-bcb9f93a7348@intel.com>
Date: Sun, 12 Oct 2025 18:31:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] intel_iommu: Optimize unmap_bitmap during migration
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <mst@redhat.com>,
 <jasowang@redhat.com>, <clement.mathieu--drif@eviden.com>,
 <eric.auger@redhat.com>, <joao.m.martins@oracle.com>, <avihaih@nvidia.com>,
 <xudong.hao@intel.com>, <giovanni.cabiddu@intel.com>, <mark.gross@intel.com>, 
 <arjan.van.de.ven@intel.com>
References: <20250910023701.244356-1-zhenzhong.duan@intel.com>
 <20250910023701.244356-5-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250910023701.244356-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PS2PR02CA0083.apcprd02.prod.outlook.com
 (2603:1096:300:5c::23) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|DS4PPF9E4E1C227:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c6521a-2b28-4925-c633-08de0979833e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|42112799006|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzBNYTBZZVNtd1ZjcFBFQ0EwRjJJOGFzaEd1eGczSjh5a08yckNXM0o3TUhB?=
 =?utf-8?B?VDBiZmN3dlFDb3hxNWF6R0JqQVAvRVFSUmVUcGZtY1NkT2JDVVF2MTVnNjNR?=
 =?utf-8?B?YU53UWpCQTgvSGtMTk9xWDVBU3FlR0JMYWR0WDJ0MG5vNzhmdk5TZjF3MTc0?=
 =?utf-8?B?Mk9OUGJOc09KOXNZL3I2T0RGLy8yZnFIYkg5dkN3Vk44V21XRTdUWGpTcWxI?=
 =?utf-8?B?Y2FkMmU1dnhDb3hKcHNwU0xHTCtuK0dndUNKZVlXdm01dnFKZzNLZy8xL2Ra?=
 =?utf-8?B?d0VySEJBKzRURlFFaC9Ya0x4aElZOCtxMEowV3IzWkZHdTJHY2E1b1BuR2ZO?=
 =?utf-8?B?eENDNkY1TEtiQ3N3NnQvWU1yUmZFOWk5QngrOElNNFdlSzV5RHJJNWtRVWRO?=
 =?utf-8?B?NnpaZzJVSDE5MWh2WjlYU1Q1dWNTVWlBcTlSZWhid3FKQVlmWEFTT0FCMVo3?=
 =?utf-8?B?N2xQSytpMmpoaU4ydWw1cTU0YnJvdnEyRUVZcVY3RVZPZGR4N05odXV3N3k3?=
 =?utf-8?B?b3NkTGFTOWtHNlQ1Ull4aVFSVU8wSHdJWnFxYmxNUTdoeERqditVcXIvSUZJ?=
 =?utf-8?B?NzcxZ1pyWU9uNmd5RHhFRE16YVA3U2lmNTI1K1lmYXdaSWMvQk9mNndnc2Ux?=
 =?utf-8?B?UEJtVm8yblBCY3RRTWZmSXVqSEExZDBZaVJlR2czZDJPQUg4TVJxbzM5ZVR2?=
 =?utf-8?B?a2RUUzVTM0dTeFQ0bTRwcjBFNWNNR29UZm5adkwwRzJUTlRHUCtrYkwyL3Zm?=
 =?utf-8?B?Q0RMbGZrRUY1RE1CZENXYnJ4a2p4UGF0Uzl5R0F0OThCVzdyaE1yUmlzdFYy?=
 =?utf-8?B?NlVJUlJOSVhQbEZjNVhQTVpNUmtXWmNGdzQxYUttNHZWMmdvTzFwTzVkSkZS?=
 =?utf-8?B?N0xFenhKNDBOWVZ3MG5VQTJWK2NSYkp6V3EyYk5ZWTVzcUFmcitkNzNMeVl2?=
 =?utf-8?B?Vy9icVZTRW1yRkViZnFnZUdLcmJPOFN2VFB5SEgzT2VXamsvYnFpcjlzdWwv?=
 =?utf-8?B?K3kvbVlLa2RhZVdSKzRsKzNZZGFiMHVlclNRYXpXWExSbHlvbUNBWiswYzFY?=
 =?utf-8?B?SFNmd2l5dUZTV1kycjhqTjhpa280L1hrNFEyczVoeEFmOVZ1d0RwYVVldzh2?=
 =?utf-8?B?amtSb0kvTmVqUERWclNpUlpUUU1IZVVBSjB4R2ZQc293NHhpeVYxdGF0Nlkr?=
 =?utf-8?B?cEd1L2NNQ0RwZ0lnWVg4dEl0VS9HQ3ZMRVVhaUlnUWEwY3ZxRDZkemVNcEVs?=
 =?utf-8?B?SFExMFRUeDVQQUE3UWdlOU9PK09MOFhITk9PRWhMZ1NLRUIwc1AvSmxYUHpm?=
 =?utf-8?B?SjlqUndIUjJwZU1IclJteVloZ1JpRWRFdEtKMi9GV3pvZGJrSDdmVmcvRWVk?=
 =?utf-8?B?dUZJQkVUMFE5RmFSbXo2NjM1dTl0VW5uK2ljK2ZhV043VVpReHNYczcyUXQ4?=
 =?utf-8?B?YWdLQ3VkcVIzZm15akI1U3N6VkZtWHJPZmFoK3R6NnVxUGdOWVlLNDl3M0Iw?=
 =?utf-8?B?Tzd2c3lUcWEvUzN1SkpRNVl1eFkrSDdFWCtna2xBazhOakpWVDlzTDIzNXVH?=
 =?utf-8?B?ZEdXMHRnb0tCL29hWVc1Q2h6MHN1bmtmZ1lkZXQ5eExUV2FLMGxNNmo0ck5F?=
 =?utf-8?B?Qm1VTnN6VzI4czlCUjlvaDVjK0RFQUlpQTQyYkJXNXlyQXFSL1hYQ281bm1Y?=
 =?utf-8?B?dzZPLzJOK3RoK0ZIbW1vYTd2RHk1cHBPUklPVGM5UTBUc2I2QlM5TXNTMkg0?=
 =?utf-8?B?V2hQcUNpVVZwUEVwUHhsNjhqeUN6VkpCVElXTXJ2b1c0U1ZqYXdYWkZmeEFh?=
 =?utf-8?B?SG1QTUt3YTNtL0pFeXdqQ1hia2NVZUltSy9JVUtBVkQxWDNZOFNpaFVubVda?=
 =?utf-8?B?RVgvc3FqTG14UkQ2V0wrYnlEM3NzNDRsM1VMLytmandScCtBUEU2NHJSMHlm?=
 =?utf-8?Q?PdKye1j1/Yu6vK8e825HOfgvCFUgGJ9f?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk05aWNGMFNFYm9qSHcrM1AwR040a1VaSjdleTAvakVuS0xZMDloc05kTFhi?=
 =?utf-8?B?MUI0TUZ0c1NWUUYxdmdrYTV6OGdZNnRUVUYvU0NaZnUzcGpCZkQySW1MajBx?=
 =?utf-8?B?dHJOcEF0M0tNOEdFcis0Ull3REZkMkduQUkzalNDUEM2S2NRR0d1RGI0UjlB?=
 =?utf-8?B?UndDbEl6K0VhRHlENHp6bXBtK2tvaTE0dENkTnR4bGY5QWY5OEdGZU1kaHdF?=
 =?utf-8?B?bitJQmo2WnBoN0J5eGh2c0kwZEpML3o1NVoxbzAzY2d3VzlzV3dJOUtzaHFN?=
 =?utf-8?B?NlJlbEcwWlozV1drY01iUno5Z1BWbzJ1eVhqZm85dXMzTU5OWllqTEdjRGtx?=
 =?utf-8?B?WkQ5Z09jdS9oSUFJdTV1MHRDZ0JYSWlpT01ZRWdjQktRZzNtZzcyNXZ3N2Ri?=
 =?utf-8?B?V3JDQzV1aFhMM3g0WnM4NHZSOVNjaHdBOTNMZjFqUG9TbmJsQTlPTUcwRFc0?=
 =?utf-8?B?OE8rL0lIeEhHQ2hsazNjbEtGbDFrbFE4OW4vSFNtbmRrWUE4L3NzOXo4RFFT?=
 =?utf-8?B?dHdDVUZWQThYQUgxQTc4NXo2NXBFb1pPNlVWbU9EWnBjUmxtMnIrWG9YQkgz?=
 =?utf-8?B?VEFUTHNoTVVobDFWdmxJSFVuU3NVSDZOOGtvMFFjcWQ1TjE3M0FYclFRcE51?=
 =?utf-8?B?bmVBZmxpNERhaTM3eHJFTTlvMnVHSndya1poVWdLclVZWThpWlFwZGNwL2tX?=
 =?utf-8?B?WmwvSFI3UVhxUjMvTUdTYzg5RzNVaGVKWGd3WlkvVTNoZWl5VEhDZG1YRUgr?=
 =?utf-8?B?bTlJWWptcXl4RnZvTys0RXFiRElEUVZoU2NXZHFpZEM5bnM1VTZJRXFNdUts?=
 =?utf-8?B?dzRHQWRTNUdEQmZjWHg3ZTRHeDlvOWsrYy9iTFRvcG9wMXBnNm9IbDZodi9i?=
 =?utf-8?B?dDlYcHVkRzRBT3oyc1RwWUpGbjdmNmcxaGFKUjlaNmNVRUxRVE5ZRXE2VDli?=
 =?utf-8?B?MndyNTZSaUlTaUxKanY2VktiRFhMZlFicWNKcUgyNnQxdnovemJqWVdKQ3Rk?=
 =?utf-8?B?Ynp0eGJ2aCs0ekRheHM4UzhrVHRncW4zN2pUc3RxdTlCWlVzNnpGMU9Rc2th?=
 =?utf-8?B?NmVTWHo5YnI0ZlNkemtRd291Y0NrMHRNQ3BHa0pwdU5jUU9nczJzcFN6TlFo?=
 =?utf-8?B?Y2RkSzJxbzNwcGFLVUZGdHJwSFRRM1NCa2ZDUUN5V3dqcUtYby81ajNPWkhm?=
 =?utf-8?B?NUM2dHI1Nk84alZXeENON2wvY1BMeWxkL0M1elpmNVFxSjJGbmJZQXU3YnZX?=
 =?utf-8?B?WHowbEFIc0M1QlJ5YU1BYlRTTlJIZmFkZ1pmMXp1NU1qVFM3dmRpTTVYaUdj?=
 =?utf-8?B?WXB6RHpOMlF4eEdQNXcySXBnZVZYVzBrOGQ4Q0dZTjNLdXJVVDdZa1lWdDBT?=
 =?utf-8?B?WEFnMk54RFd6ak9HVWU5WjVraG1UanZxMkp1M3BkdnRDcHZGZk5ybFF6QWhj?=
 =?utf-8?B?cmRWYTN6Qm5BbWZBWUFESzV6MXZ2TGN2ZFc1THF3dVZHL1o4TFEwRTZJVHc3?=
 =?utf-8?B?eEN3WENRSmxBSkVncXRvaDNDRWQ2TWlqT2UrR0NrTlRjaWhhU3VuWkZzNlZv?=
 =?utf-8?B?dWE3MDQwQXgzRUZFcU5lVGt5c2lHZno0WkdZZWpOUmxNZDVxRzZTVThrTUtI?=
 =?utf-8?B?M29qSWcwYnJxYklDUHQwZlR3VjFRazVFM1hTYndGRmV6U3UrV3o4bUxFclZv?=
 =?utf-8?B?WmRFZEZzakpNb2R2NGVHR2pMS0kzQ2VSVHR3RWxKekJ1WlRBVXZCZVpaUFBj?=
 =?utf-8?B?MzlkaFVhRWdCYjZyQWNGcmJBY1BXOWdBbFg2R0pybktyVEhHdVhMNldieHNJ?=
 =?utf-8?B?anFLcnlaNkdPQmgwYjV5RENlNHk4SWt4UVR6QjFJM3Eza2lnTlcyRVUvUlRl?=
 =?utf-8?B?dHlnY1ROZ1plNWNRcHFKdWZ5bjF0MDBTYmZONHRTTWg4Y3dGY044RGdLYjVY?=
 =?utf-8?B?WVpyajJKTVk3aWRkYmFncWhLNFlCaHR2TjkvbCtlZVpNVUVQTVBVWWxKQ1pw?=
 =?utf-8?B?OFJTSHhsK2dSZFBjTW1IVlFpN0NpQWlqbjhCRlZ3czEyMERjd05keXI2NzZD?=
 =?utf-8?B?cmx2TC90ckNCdlpZdlhLbklqQ3pzNmZPOU04U0EvZ01aMnBzRTFBdGw1bTVh?=
 =?utf-8?Q?0pOKJLa6T/WFfRbWbKerKI5mC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c6521a-2b28-4925-c633-08de0979833e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2025 10:24:23.3431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lXPryqoNfcPA39YObkeFR3QrHcdIlZChXKogQTWnJ+we8q0sISRVnN68Aq/Yv2gqaST5t7YJCqD7/birW6qXbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF9E4E1C227
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
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

On 2025/9/10 10:37, Zhenzhong Duan wrote:
> If a VFIO device in guest switches from IOMMU domain to block domain,
> vtd_address_space_unmap() is called to unmap whole address space.
> 
> If that happens during migration, migration fails with legacy VFIO
> backend as below:
> 
> Status: failed (vfio_container_dma_unmap(0x561bbbd92d90, 0x100000000000, 0x100000000000) = -7 (Argument list too long))

this should be a giant and busy VM. right? Is a fix tag needed by the way?

> 
> Because legacy VFIO limits maximum bitmap size to 256MB which maps to 8TB on
> 4K page system, when 16TB sized UNMAP notification is sent, unmap_bitmap
> ioctl fails.
> 
> There is no such limitation with iommufd backend, but it's still not optimal
> to allocate large bitmap.
> 
> Optimize it by iterating over DMAMap list to unmap each range with active
> mapping when migration is active. If migration is not active, unmapping the
> whole address space in one go is optimal.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
> ---
>   hw/i386/intel_iommu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 83c5e44413..6876dae727 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -37,6 +37,7 @@
>   #include "system/system.h"
>   #include "hw/i386/apic_internal.h"
>   #include "kvm/kvm_i386.h"
> +#include "migration/misc.h"
>   #include "migration/vmstate.h"
>   #include "trace.h"
>   
> @@ -4423,6 +4424,42 @@ static void vtd_dev_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
>       vtd_iommu_unlock(s);
>   }
>   
> +/*
> + * Unmapping a large range in one go is not optimal during migration because
> + * a large dirty bitmap needs to be allocated while there may be only small
> + * mappings, iterate over DMAMap list to unmap each range with active mapping.
> + */
> +static void vtd_address_space_unmap_in_migration(VTDAddressSpace *as,
> +                                                 IOMMUNotifier *n)
> +{
> +    const DMAMap *map;
> +    const DMAMap target = {
> +        .iova = n->start,
> +        .size = n->end,
> +    };
> +    IOVATree *tree = as->iova_tree;
> +
> +    /*
> +     * DMAMap is created during IOMMU page table sync, it's either 4KB or huge
> +     * page size and always a power of 2 in size. So the range of DMAMap could
> +     * be used for UNMAP notification directly.
> +     */
> +    while ((map = iova_tree_find(tree, &target))) {

how about an empty iova_tree? If guest has not mapped anything for the
device, the tree is empty. And it is fine to not unmap anyting. While,
if the device is attached to an identify domain, the iova_tree is empty
as well. Are we sure that we need not to unmap anything here? It looks
the answer is yes. But I'm suspecting the unmap failure will happen in 
the vfio side? If yes, need to consider a complete fix. :)

> +        IOMMUTLBEvent event;
> +
> +        event.type = IOMMU_NOTIFIER_UNMAP;
> +        event.entry.iova = map->iova;
> +        event.entry.addr_mask = map->size;
> +        event.entry.target_as = &address_space_memory;
> +        event.entry.perm = IOMMU_NONE;
> +        /* This field is meaningless for unmap */
> +        event.entry.translated_addr = 0;
> +        memory_region_notify_iommu_one(n, &event);
> +
> +        iova_tree_remove(tree, *map);
> +    }
> +}
> +
>   /* Unmap the whole range in the notifier's scope. */
>   static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>   {
> @@ -4432,6 +4469,11 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>       IntelIOMMUState *s = as->iommu_state;
>       DMAMap map;
>   
> +    if (migration_is_running()) {

If the range is not big enough, it is still better to unmap in one-go.
right? If so, might add a check on the range here to go to the iova_tee
iteration conditionally.

> +        vtd_address_space_unmap_in_migration(as, n);
> +        return;
> +    }
> +
>       /*
>        * Note: all the codes in this function has a assumption that IOVA
>        * bits are no more than VTD_MGAW bits (which is restricted by

Regards,
Yi Liu

