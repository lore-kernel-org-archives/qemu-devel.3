Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20C0CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 12:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vApA2-0000Pj-SA; Mon, 20 Oct 2025 08:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vAp9y-0000IT-UY
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:38:47 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vAp9q-0000k6-TD
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760963919; x=1792499919;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UKO2GXT4RnCgMg+fKh64qAlskKAvlmAjW69nsXwzMOk=;
 b=A++4NF4ONDnzaMxK9odwaXmth687zs0N82Sn70VMiByB0jPTOOe9QL2C
 2SWa2Rpbg0mTx410m+eAXvfmXncVSjJIx1RhiEnfX49LTiZKJNzt13Kf+
 W/h0GZBmeGAEH3+ZWvNZKHWxPTVK5ef8Sz1t3NbeqKo3wyyRbKiUUeWP/
 ZJsDSODO33uuyXa9Ju6sY4wcMi/etlOdTxCH4BcgGXAUnafBNOHFW/rbe
 xZUrXrf84DKShHQ0CFDnHhgJ/3+q4kzAAQdif4u0tqthSU13bLPG7eOWF
 LnrUuSbeetbYvgv8Wv4/yH4TvwmjoQIScsTToSgFjcrttOai/KBq2dL/X g==;
X-CSE-ConnectionGUID: ZPwlh19yTQKs5CpOX+FElQ==
X-CSE-MsgGUID: L8/8qGkzTQ2Xh9RhroQRlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="65691564"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="65691564"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 05:38:34 -0700
X-CSE-ConnectionGUID: oB5DQ0gDR9an3apnXPL0qA==
X-CSE-MsgGUID: sjO3zOI8T9+HTwJi3hZpPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="183265223"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 05:38:34 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 05:38:33 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 05:38:33 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.55)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 05:38:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ip0/3+5mHLVH6coyfBvcbqQT4vv0V16GrsiTE6TnEAWZCQOCHQg0JiT7cwofdtnTMp8FOmpMwDGOSFq6S7kYMzrfC+JIQuF3+QsnN/P5Q1zByMNjldQg4g3ErIsc61nzj4E9fWsbYJe7XiRFl7VK6b6F6L8V3tiFvzoq5D6hr8L/BR23BWndvLTRVHtiPqq58VwiztF4fOsiSNDPUmoCdzVIWPNG799vVXTwx7LXcRuEQyI948GejHgGRQkqyhP01HMvxxCgMkYZm8mwtRnoVDlufjtXHKESRXfv/tzD/hIRItuA+QqiVb7JoI6eOfZ6P88BS8pSYs788wp2tHMYpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzQIno+3pBP6rVLDGu+R57eZ1ki1KvJWHsbaqInZNHc=;
 b=eibHJDOlEVaxzb17bp5xCS//4bLCGtlp4FIRnkoXga/1eFAPW9PXlGws8V6Au3yOX67LRxj/hz1TdVMeBicfyDHOgzCn9Mj9AD2SCGpT3Xm9z/MPXc2/SUtuIY8rrb/VSJWgd4O60/7XnnLEb4C/pSEd9sdgroA9CYOYwwRvcnOaTtfZ5ZIfdiyY6M1HOutTLXVD9GnLqtRFaDzyx10WRBRfvxXmxh3IjIIkzRWaiYnSD64vzWYSDcaStsCScXD1msbN1wXEQYvyk9igMP+V62HmvkJ8WSwNUJp2PgVehXZWPokuGLYdRrl+4H3YYCIKuLOD2RM0zWN1pYjVb+XybQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by SJ5PPFB8C3A0B7C.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::84c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 12:38:31 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 12:38:31 +0000
Message-ID: <ddbed964-1bd6-4a14-889e-db3e34d3d0d8@intel.com>
Date: Mon, 20 Oct 2025 20:45:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] vfio/iommufd: Add
 IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <mst@redhat.com>,
 <jasowang@redhat.com>, <clement.mathieu--drif@eviden.com>,
 <eric.auger@redhat.com>, <joao.m.martins@oracle.com>, <avihaih@nvidia.com>,
 <xudong.hao@intel.com>, <giovanni.cabiddu@intel.com>, <mark.gross@intel.com>, 
 <arjan.van.de.ven@intel.com>
References: <20251017082234.517827-1-zhenzhong.duan@intel.com>
 <20251017082234.517827-6-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20251017082234.517827-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PS2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::25) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|SJ5PPFB8C3A0B7C:EE_
X-MS-Office365-Filtering-Correlation-Id: 62297bc6-2bb5-40e8-090e-08de0fd593a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|42112799006|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STI0M2VlTkwxTEFBTHd1U25qZ3QzaFJ0NWlHN05xbWtQUjRYMjRVRDFvSDRo?=
 =?utf-8?B?elVVYURCU1d6ZGNpVVNjQ2N6M09BcW13UjBuWitlblIwY2M3MjYxbjkxbTd0?=
 =?utf-8?B?SzErUTVWUzBxeDRtWnZKTXhHZEE3U0FDcmJ0dzVyRzVoMm5IamtnWkdnSTdx?=
 =?utf-8?B?U2RDOFk3bXdrVklkR1M5TDFjK3dUK3B2aFh3aERrdGVoVFFYSVhsOGhqZmo2?=
 =?utf-8?B?cG5URytNbXFXb0ZwZS9mU1lEU2tRcTU1cmVRZkJUZjFiRFJXMnN2ZVUrNHUx?=
 =?utf-8?B?aHlydzRxUit6MlFzenNQd0RnOFVJSnR0Ym1nL1lweDRmNXNZSkg0b3dEVUZa?=
 =?utf-8?B?Wm83RmdkUWkzQzB6N011UWVTZ1NvT04yOHIxUG5RQmpqUWVYeTYzRnpNbUNI?=
 =?utf-8?B?dGJSTmpMTFdrS1JUeHpDSStvSjI1S09uZGFJd0xsRUFiTzBULzJuN2NIUTFF?=
 =?utf-8?B?SEtLcTdvWFdTQjR6NEhvVUMwSWpaYnJqTEp5Z3RsOHpuQ0EzUVE4aVFzSHpX?=
 =?utf-8?B?QTVveWtLTVY3ZGlvV2NhUmdlY0diZVZTYVBGb21TVWo0MWNkM2pWZFg0QzdN?=
 =?utf-8?B?K1ZrUGoxUitQY3puVTBqbDFPQXBVR0o0VXdjUXlodDFWTGE1bW9vRTlMOStQ?=
 =?utf-8?B?dzN0NEtsNEJta2RYS1F1bUZ1aWZ0dXg5b2NKeUdqODNMMjk2bUpBcHh3cFo5?=
 =?utf-8?B?MlZIbGJHQ2RONGozQTBNRitCTWxkakV1WktwYTZDVUVGbW9XWGUrcWY2d3Jy?=
 =?utf-8?B?WlIwaFF5SDlidUdPSit6R2J1SFc4bGxlS1J0NWRNS0JjSVd0VkpWQ2RjZjJJ?=
 =?utf-8?B?Nkxyc3JCK1NEZmd3VU5BZlA0N2lqTDQvTmF3VXg2cUthL3l4L1lwS2k5b1Az?=
 =?utf-8?B?S2xFc2pTbHp4K2Q5SlNoK0VPQkN0SzRqejh4RGdkbHIzOXJwWHQ4emtERFUv?=
 =?utf-8?B?anV3WXB3SHFMRDR1ektVMUNBakdScW5EckkzclBKcS92cDBuRGRudk1OMUgx?=
 =?utf-8?B?WWlwNXBuTTBRL2RKdk01NEhPcUVjY0VXdGhYeUZtRHFLWmx0RTVlWXN3aUtI?=
 =?utf-8?B?WC9vT216ZXExRW8vUzJZMjV2WFJ1alg3YW83c0d4TzQ5bmNuTFBXRE04Z3RY?=
 =?utf-8?B?SHUzYVJFUmxoK3pmWDNpcHNocnlDMjU1akZZVjZkZFFWZzZ0emFrU3l1Rmwv?=
 =?utf-8?B?bHZraEowQy9BcnFqbDFhbTBJdGs2L0JWRk0zZ0pRRjhHRTNJNVBrcDRUQ21m?=
 =?utf-8?B?UzFiZzkweFFFeGp2NDJSUS82S0VjOGdQeUZaOXNjVklOYTJ1bHc0T1FLWDBY?=
 =?utf-8?B?LzA3SUVkRjV6QUdSNU1XWHROZnBqZUpuRUY4cWN4UDlnYW5uc0h3K0dYaHNC?=
 =?utf-8?B?SmtnZ3lYcUEyOVBUTmYxdnErOVZvUUIxSXNhTUVFRmIzbDZBbnp3TWlRNnFj?=
 =?utf-8?B?VzQrSGw3aWxKTXJ0NkdiczBaeW5NamRjV1l6OWtVRDJYUzQ2TDM5VDBVbUFO?=
 =?utf-8?B?MUNLTWVnclhKU1M4MU5IQUllazVWMi9IcXo1bERZTGFkWm00UmVWcUZPUW1E?=
 =?utf-8?B?Mm05MjdUMFgyZXAzVFcxcFhCT1FqSDhZSWlBMnhkUktyWXZmZ1VLTVJoWEdl?=
 =?utf-8?B?Zko4Y3BRUzNkNmVsUnBpbU43ZkE5c2RydVlBWEdYVmxpSmFocE56eXhNeVFE?=
 =?utf-8?B?SEdmUCthOTJNVWRvYmw2KzZ5dHlta2FFVkVUbm5EUmNXOFQ5UzdPbjdDQkRI?=
 =?utf-8?B?SGJWZGhTVGJPYlFXOEFxRElka2JNM2FSbDBqQ1lyVi9KZ2xxWnNmTjdCbngy?=
 =?utf-8?B?engwdkg3ZVo0blJnOVNYdVRQY0UyWmo0ZDVselVDR2hHdWVubW5HNEpMeGRG?=
 =?utf-8?B?c0RxU0lPZHlZakR5bEZ6TTZvWDVvaFliRHpwWG1SNC9hVElBQmwrTTdTMDlz?=
 =?utf-8?Q?EdPlkXQCwECqRJQTSOktJtnxsL/FqqdD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGM5dUlYNkRqdytBQ1J2V2FramRkeXVmbW12TEZoN09ySTVIV0ZjODRyejYv?=
 =?utf-8?B?WUp6QkFBNnV4Q2wyNTJ3cHVDc2NPNy8xWTlVTDhJbEFHR1dnUnVYOE5NYW9a?=
 =?utf-8?B?U0s0ODBJakJuR2Nob2k2dlBETW00RnZ6ZzBqZkFsNHBHMXNuTk5GcEpWdDVS?=
 =?utf-8?B?NklRV0lhbkdrWFhiNkJVeE5ZSEw2dHIrcHFzVmg3TzBGcFZNSUY3ck1MMUU2?=
 =?utf-8?B?ZHRLUFNiL0N5NDcxc29HaW9OcXVvYmg4czJHYUhid3NwZ0RNb0V2ZldySFV1?=
 =?utf-8?B?NklvWTdIL3BxMGQ1amtlVHVJdkJ1ZlJxMDhBam9XTGQ2S2U4b21xeUdROTkx?=
 =?utf-8?B?S1FwNkdhdTk4YldGanQ0MlZiQlBRN3ozR2ZobmhFWko0T2Jlc1pLOHE5Um4z?=
 =?utf-8?B?WmNPaUNUN2thQ2xTVnlEeEhDSnIza0ZXOHVPWlUycmJMSjVYQnZFbEw0NTB6?=
 =?utf-8?B?SU9QOHBDTnB3cmVyTzdRVDZSMDdXUHBkdjhubXpPeUxySWgxbXZnWVpOaml2?=
 =?utf-8?B?S3BGK1pSOFlhVkhZdVJmUm5RYTFTb291ZzgwdVgwTXdMeFo4MEdwRklHdEZX?=
 =?utf-8?B?a0FnOWl2MUNUSWhyMk5oQU5UQUwzcHZiQ2t0UXZHWEV6aUFnSWU0eDJNVU1k?=
 =?utf-8?B?VkhNUTJlSHErclBvVno3ZVk5OCtBNlJJSlZ5Z3NFbWxXTXQ2MmNWWDVBNEF2?=
 =?utf-8?B?dlRybnBUQkszcThqbDloTklxNjl3Q281MFRkQzNPc0hVUmxWRml3am96MnNl?=
 =?utf-8?B?eW9ycmppb0MvdGNvZkVFd3dNSzBmeFhrV1BoTzNETlp6aHowck96K3pWVFVN?=
 =?utf-8?B?L2FqYWFOZm5qNU0ray9NM1RUbkdVM29ra0ZYeVEvV2R0N0FhUnJ2akdydGRF?=
 =?utf-8?B?ekZsZ1VMZHc5dGt5cFJNYnViUlo5eUxGUk03Ung5b0luN0ZqenNXNXBDSFUr?=
 =?utf-8?B?dFRieHlQbFR1Q1FYK0JzcXBmN0cvcTNDeWpYb3ZzYkxuSlNXZ2twdEZ1WjdZ?=
 =?utf-8?B?VVFHS0kvWjNpZnppejBnUE16MTRHR3o5R3ZocUZGcGNIdktubFdPdWgyTXIz?=
 =?utf-8?B?ZjVScFZmSUxmODI1WDdDTG5rRTcreG1yckJoYWxMZmhlc0FISW9OVng1ZWF1?=
 =?utf-8?B?RWlYZVU5V1doTEg3TWE3a3RNY3k4NGE3UU9OZ2N0SFUreVhZVkxUVmo5U3JN?=
 =?utf-8?B?Z0czbTlBRnNlNVM0R0JGL0ZSZW1YYlFjYUU3ZkRqS2c4OERmZ3F5b2hSSVVH?=
 =?utf-8?B?Y0JDcC9Hb1RjNHo3ZFZ5aFkyYnFlT0h4ZTEyK3BKdUgxVHNjUWZUWE10YW5H?=
 =?utf-8?B?bFM4MVBpbzA1VDlFQ0djaWtWVk1kaUJrZEp6VWo5cHgwdE5MellPOWQwQ3JV?=
 =?utf-8?B?dzdyWG1kdWljUkJMVjNJZk50ZG9xM0pmU0E1aHRURGFtVmozMFdXTnIvN3lD?=
 =?utf-8?B?Mkh2RmZaU2NRUU12eFFBQTh2Qmx3Z24xdFlKdlBhd2xvYXdaZHA4MmxSaUgr?=
 =?utf-8?B?ZW0zcmlnbzdhTnUrdVVZR3ExOGpZanhvNlNDT0pPQkJlMzRucElhdUNJVit4?=
 =?utf-8?B?VERYaUFSZ1JHcEFBTXJRclk2WEgxeDdqdkxTazA0OHp5cDk4UllFSDRlalgv?=
 =?utf-8?B?SVh4OWQralk3eEhXSE9DY2lqOUxzd1I5TkpXRGNMZk9OSlFXTWs3NDFMYTV6?=
 =?utf-8?B?OS8rb0ltMmIzYk50UVFkMk1jdjBIbUpJNUtDMmEycGl4M3FkU0NlQkpEclNJ?=
 =?utf-8?B?bHdLYkVZeGFSKzZLYlFVMWVlSHpYMzNNZWE1TTExYS8xdXl1cHNzazJMSWQ0?=
 =?utf-8?B?dlBwcDNjU0RjRTJPUWxtbzkxWXNZNG1Pcnh2Vyt6L1ZtSVhFNjFBdVNHaVRP?=
 =?utf-8?B?QkdPRTV1dFlqR3VLV2s0SlpqNTZpUmJMODFSdTFMbEJScTR1ZzRGK05TTjY5?=
 =?utf-8?B?clplcVl2TC82UG4xL2dOQzhQSVBYaCtPSzE1M2lJblg4enBvLzZlSUFMQ0JV?=
 =?utf-8?B?VVByeWdmcHZPZ3BRNEsyQjVxSmhYSUNJRW1LVXQybk9MTU5NSk9BRFl2YnJH?=
 =?utf-8?B?Sm80Q1RvQlJucXFGTE80TVc4aG9tQlhBaGVtVUZMd2RydVNGR2ZsRldOTEZu?=
 =?utf-8?Q?BAgG6Pw7YubVauyANbULWY0zb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62297bc6-2bb5-40e8-090e-08de0fd593a5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:38:31.4728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ymCuY+J335o0aLDJfmj+ap0M8lyZxXvnFgW3Djrc8eor8QqbfI+el96+a5ukfcKdKJLxU+KKvxD0Nae75f+Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFB8C3A0B7C
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 2025/10/17 16:22, Zhenzhong Duan wrote:
> Pass IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR when doing the last dirty
> bitmap query right before unmap, no PTEs flushes. This accelerates the
> query without issue because unmap will tear down the mapping anyway.
> 
> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
> ---
>   include/system/iommufd.h | 2 +-
>   backends/iommufd.c       | 5 +++--
>   hw/vfio/iommufd.c        | 5 +++--
>   backends/trace-events    | 2 +-
>   4 files changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index a659f36a20..767a8e4cb6 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -64,7 +64,7 @@ bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
>   bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>                                         uint64_t iova, ram_addr_t size,
>                                         uint64_t page_size, uint64_t *data,
> -                                      Error **errp);
> +                                      uint64_t flags, Error **errp);
>   bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
>                                         uint32_t data_type, uint32_t entry_len,
>                                         uint32_t *entry_num, void *data,
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index fdfb7c9d67..086bd67aea 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -361,7 +361,7 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
>                                         uint32_t hwpt_id,
>                                         uint64_t iova, ram_addr_t size,
>                                         uint64_t page_size, uint64_t *data,
> -                                      Error **errp)
> +                                      uint64_t flags, Error **errp)
>   {
>       int ret;
>       struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap = {
> @@ -371,11 +371,12 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
>           .length = size,
>           .page_size = page_size,
>           .data = (uintptr_t)data,
> +        .flags = flags,
>       };
>   
>       ret = ioctl(be->fd, IOMMU_HWPT_GET_DIRTY_BITMAP, &get_dirty_bitmap);
>       trace_iommufd_backend_get_dirty_bitmap(be->fd, hwpt_id, iova, size,
> -                                           page_size, ret ? errno : 0);
> +                                           flags, page_size, ret ? errno : 0);
>       if (ret) {
>           error_setg_errno(errp, errno,
>                            "IOMMU_HWPT_GET_DIRTY_BITMAP (iova: 0x%"HWADDR_PRIx
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 6457cef344..937b80340c 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -74,7 +74,8 @@ static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
>       if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
>           if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
>               bcontainer->dirty_pages_supported) {
> -            ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size, 0,
> +            ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
> +                                                    IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR,
>                                                       iotlb->translated_addr,
>                                                       &local_err);
>               if (ret) {
> @@ -224,7 +225,7 @@ static int iommufd_query_dirty_bitmap(const VFIOContainer *bcontainer,
>           if (!iommufd_backend_get_dirty_bitmap(container->be, hwpt->hwpt_id,
>                                                 iova, size, page_size,
>                                                 (uint64_t *)vbmap->bitmap,
> -                                              errp)) {
> +                                              backend_flag, errp)) {
>               return -EINVAL;
>           }
>       }
> diff --git a/backends/trace-events b/backends/trace-events
> index 56132d3fd2..e1992ba12f 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -19,5 +19,5 @@ iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
>   iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
>   iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
>   iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
> -iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
> +iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t flags, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" flags=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
>   iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"

