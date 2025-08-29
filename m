Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8F3CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN5n-0005lV-OK; Sat, 30 Aug 2025 11:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urs9n-0004mE-Kh
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 02:00:15 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urs9k-00069X-85
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 02:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756447212; x=1787983212;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5qlSYnTjhK72Ihwc/P8FWtVNYN25VHpUeavHCzjF9Ys=;
 b=nCJcJ/uIX0uMlw1QK3zpSnI3l/zBY7mRXVjZ52l5zo5SFHmvClOlL80x
 UqhMOaVWYipkr0deGsD7Mn5OOQm+AQiQKeDE4jHfu559suC3cLrXSsfja
 ApX0tD09S6o4o8ykU2hDWqxs9xVbMhcNaWZFipxJDbV5WPlzFprZlZtSw
 L4Mt/5RqVAuOCI8R8SzPSs1I+xsNuvlRRP0BaL0Mlmt6+c5w6VsPtDM30
 cNMbHmdJhlCR7F7ZMUfx85jzrpXFOYRF8q/1yATEyhBnFVp76mSdC3lPQ
 54YzToq5Sn0lB4YohXx0VgBglFENYhr1D0nRLfJ7xxW3uAllCqEeSY8V+ A==;
X-CSE-ConnectionGUID: ssZmTqENTSecn32bWc7Jgw==
X-CSE-MsgGUID: D8HZbx8OSjGp0QiC2t92zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="76327223"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="76327223"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 23:00:08 -0700
X-CSE-ConnectionGUID: 9mSqGJqKTzar1SEO/X9yEA==
X-CSE-MsgGUID: G9siBr1zT0OIgk7gn4E0ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="170687593"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 23:00:08 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 23:00:07 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 23:00:07 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.65)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 23:00:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLYHcdgYwg2BJkP5YsaP4jeB0bLx8CvB6wtItP+bDH79rG7rq+tCeS4gaTmTnhcb4I8+PXz26BOsDmj52jKH55Z0ulTiw/POisd2JrH00j9oFGk+Z5amXxY/2Vdhi2pHsnVdNfiyildALv1iTV4m5IgGbhCVBTtZJwvM+VL3GgmHwha7Latc59HBLX274Nk0EtoEFZtvNhZ1j7HofJBCdjzJRqFKtmUEHxYLvF3IuUJgAuUkm9I6/cSAVnkaEekTks7K2wpNUxHmfu/mCt1e8oierbzxffFqltRuw5i2OP/0KyOsETBjMoRNSEHlR03OyY7LxZhIY5vkLBBr056ROw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9TNG+IhbPHia4Cbo7DP0999/a0BySsN3Ow2WPvNuIc=;
 b=JMh8WvvjBbUzIvAtOdeI+nFEDirPv/8Uhsq2Xpk0g653zuL7kzOMuQtBVGjVmhs60RJT4mwXbFdjsnNjIR3nRsPudPlrE57s0ZCFG3RRdA0f4pnbab5lNHUy8+U9lcGuS/udb2gS6l7ihcDlz2a8BH+DTyYS7BaxyNgJpfuGwuo629z+71WDod0c2HFCBmTXbrp3t454/eC33xn2fsi502O5CsrTVl1ug4SImlXd3599/E+FQ6n0WH75ZAS4d5Zlk+XhVdYEWQFDNR+YVe8ZReZsPGLHhRKlpsvL/b+s6fMFgXCCBu1YnKaI3vGvNv3NdM16bzz4tmcEqerttL/f6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by SA1PR11MB7038.namprd11.prod.outlook.com (2603:10b6:806:2b3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.18; Fri, 29 Aug
 2025 05:59:55 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 05:59:55 +0000
Message-ID: <631cff40-fc65-4d1f-9a7e-c51d7e07a900@intel.com>
Date: Fri, 29 Aug 2025 14:06:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/21] intel_iommu: Stick to system MR for IOMMUFD
 backed host device when x-fls=on
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <chao.p.peng@intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-15-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250822064101.123526-15-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::8)
 To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|SA1PR11MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: b57891df-519c-4887-f398-08dde6c146f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|42112799006|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmJYWVRVSWV1a2MvYUVTUVdIYmQxR1hQMTYzaHg0NXI5WlBWcllnYW5QUktZ?=
 =?utf-8?B?c3lZanNheUVOcHA4MHhTZS9IVWkwRTNlbmpJcWYzekw2eXMyakNzOHMvVlh6?=
 =?utf-8?B?MzdoUUQxMm04VGhud1Mrc0dEeDlzMmlRZGNSNWlsd1FHUjJSQXA5TFNqSFNC?=
 =?utf-8?B?blpNRzZJMnVKK25WWU8rZlNIT1hkS1ZjSHFrQ2NjNE9GWEF5aHdoS3I5Smp3?=
 =?utf-8?B?THVPaUY1YkRVZGNpQVFMSGpNMGJLbGVaM0lHbWdNUkp3TEdsUFJOcEx6MnNY?=
 =?utf-8?B?TWdEekFkOUhhOUZIR1FYQ1VnbmNTakhDd09GMHIxYXFPWDhrSC9Uc1pJRERn?=
 =?utf-8?B?WS8zaHY5RnFRTllRUGRYMWpXQk5Rc09wdGVTVkw4NTc4dFdQNnEvZW84bE5T?=
 =?utf-8?B?bTZib3R3QWVIYituUVZtSDErcEVEUXp2MmdLellaVWxaSVoyVVIrbDF6L2Ja?=
 =?utf-8?B?MEQvdGlFRllMZXp1Um55TnE5RnYyUkJjeEpTZHJKKzM3MVNUcXZOS1FNV0dV?=
 =?utf-8?B?UTdWY0hDQXA2b0RJTnJpNUZJN1JLU0tlNXpqNVQvZ3VteXhCcGgzY0c2UDhh?=
 =?utf-8?B?ai85MzZ5SHNHbmM1ZUdxVVZ1aVh2eC9pNDIzdlQ1MENQdllCY3pVbkVNVE1W?=
 =?utf-8?B?ZkR3SFA5K0dBMnBMUk9TSWhZMkMvZEdpZlF6RHJDT0JuOTVnK1o0UW9DS1lq?=
 =?utf-8?B?MVBlS2N6aWpJYlBFTXo3M1NMVThXRHIwWGVZRklsMVN6c3FZaGFIbVU1cCtk?=
 =?utf-8?B?YWtrb1dNZ0VQQWIxUWIxdHF1dUJvZkgzdDlwTVlIbEVlU2R0SlhPcitpSHYx?=
 =?utf-8?B?MWpUVjA4cDhmSUM3eTVJV0laZ0pZYStaeUlqYXFxdWpvY2RWUURaVk1ZRjVJ?=
 =?utf-8?B?VXUwVlMybmxLaXNTTWxUSkN5dkpsU3hCZnVnTEUvZ0tKYmRlaFNLWlVQNFdJ?=
 =?utf-8?B?WDFxRlhSMGI1MHZTMXpjbXJMRGVzYnp1bTFjdDBhMlVBa0ZhUWFGYXlqZEIv?=
 =?utf-8?B?REpGUkxVOVBmQXdnWFp4SlRjSENnSHI4MTJyMkdFQ3JhZkNiVTIybFhGOG5E?=
 =?utf-8?B?ZVdybnJZRzgwRHUyNjllaFI3dnhBMGNpcVhPeDlNVGJnMFBOYTA2VUozQ3Rw?=
 =?utf-8?B?UHluSWZVMFR0L0orKys2NFRoYXRVUkdHMml5Lyt2YWxvSTdxZVF4RzdFOTh5?=
 =?utf-8?B?U3RJQ2k4dHlwRUhicEpIcm9CZGRKdFc0UWc0UENSWkdGR3pmVFdsbDFGWit1?=
 =?utf-8?B?VFd2WW4rWENGaUpxbkV5V0RMVWRpR1NPV0xPQU9LZjRFWFM4amFpVG9NeEVn?=
 =?utf-8?B?cmRUSVNFT0Frc1hpZUY4eElNTmpyQVhHR0dTejdZTkpKOFBXK2NoRFdIVTIv?=
 =?utf-8?B?Z0NGdzhYRFpHbVJpTVB0VDJaOWFpcE9oemlVeW9pdVJ5MEhJdFNtbWpHQmwx?=
 =?utf-8?B?Ymp4QXB6VkszWE93SmxVMzRxLzZtbGZ5c0kwckdyWHNuRVF1SWZFUG9zUGZB?=
 =?utf-8?B?bTZTTHc1SUNYeFJuemFBRTFycmFrL25KditWOG1jVkxhZ0loc2dSNExwekxY?=
 =?utf-8?B?YmlBSWZIK1R1ZnRGYktjTDhwWjF1NlhHWmduT1dpbXE3eXQ5RVpnZmtNUE93?=
 =?utf-8?B?WVhzR0ZPcHByWDYzS1FxY282RVZDYUVPZ0RvNXRKU2VmM3lhcDRZQlBqd0Fi?=
 =?utf-8?B?elluWlZ0VlFiVm93Zk9JUTRLaDJEc2pBMEpXRzlPM1kwam8raEoyZWRBMERp?=
 =?utf-8?B?RklVTEtCZzlFYk9MMU5LRDM0TmJySFpOVlR5VDc5MEhob2FsbTUyOVhrSVAw?=
 =?utf-8?B?eWFoWFFsNDlDQ0kzcEsvUXNiQkdlVzlaRi9hdFJEUlRnR0JnZGU1dkcxZmla?=
 =?utf-8?B?RGdoVGgrZjhaQmpoRDc1Z01uZ25jT01rWjdPK1Z0Q24xa2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(42112799006)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2ZaTHRESzkxc0YvYVRoaTRzN0NhRVhLTnVtako0bUtqRmJvaVNiTSszZkZ5?=
 =?utf-8?B?RkFvWlhsazdMY3dFdm5lMmF6NHNkVmp2L25VeUNjVk9hbDNxUmtPcXRrWElV?=
 =?utf-8?B?Wm1XaFF4VnZtcUlTQUZ1U3QzNkkwTUY2YWN6bXB1Z0w1NGhuOXdHMVowUGtl?=
 =?utf-8?B?OG9CWWQ2MkN1U3M1dEYvdUdXNmx5bGtiMm9KbmVKUGlxN1cvbFhKY0dVNGlX?=
 =?utf-8?B?NkNOZGhGdjF3M3VJZ3U3b3U5aEg5ZXZhZFl5TG1JNUpuSXZTQlFhRDJxakho?=
 =?utf-8?B?UGZ5U3FNb3Q0NGVldWNHYmFtOEpnVDMyanhsM2dTQnlMREpIVkdJTFd2NVhC?=
 =?utf-8?B?bjJSMVNuRm9TQmdtMU5SR3ZJZGljaVF3dTd6VmtYdkdxbU9VNjBMc2pQSUpj?=
 =?utf-8?B?MDNCUlRZNk53b21hc1RsVWdkVjFHQ2NLRXphcEZPVXJkNGRGQVZaSXludFZF?=
 =?utf-8?B?SDRuMjUyR2dWY2ZhdmhOdjVUc0N6OU9WRWxCK1RkQlc4bjF3Y1FDVXV1U0cx?=
 =?utf-8?B?OWlidTUwUFdQQ2lVMXJaNFlSUWw3cHVRZUZ6anB0QVA1QTB2VUcwNEJlVEJh?=
 =?utf-8?B?MklNdkpQandtd3VkSlErYWViTzhZYUJ0WEpTb25ydnluRjVtWjF5WHU2NGtS?=
 =?utf-8?B?SnQzL3ZVdGI4aGh4amg4RjRuZ3MxMnE4NVRNOWtHUW43UndaVFFUZktYYkwx?=
 =?utf-8?B?SHZ5RDdERm10RXE1bkJvRTFsNWlaamRoQUM1b3JOdmxnUC9rblpEODdZNXNS?=
 =?utf-8?B?Y3RCNHpRVG9rNzNXMk5Kbkt3Ykw3RGM5RmwrY0pGZ09PR1poQ0RtTHFpQmJO?=
 =?utf-8?B?SlZCSkltbEhsME13Q2hvck9kSlo2M3NTbnlqMVVqcDNFRmwzMlBFSll6K3Zu?=
 =?utf-8?B?ejl2NGh4OC9sU3VpUXlLaVhaNFJXZktwZWxUSEh1VHpMT3dSUUJlOWdTODND?=
 =?utf-8?B?Sll1bjJpYzVJakJESUUzc2ZZa1ZBVjBYYS9NM3AycTRIUG9UUElwL2RQdTNp?=
 =?utf-8?B?S0x2N0twT0drdzNuRDdlWGlHVkdmQUdrNlp2R1ZEQVM5UmlGalN2WXZBZnlD?=
 =?utf-8?B?dTEzbnFyRURLTklMQmJ3ZUl0cU5Od2pYbG1Yb2szQWZIYVBrSHlKVU13LzFw?=
 =?utf-8?B?QTJyczh2OHZhWnRpWHh0b0x3dWlvMGtCVXYvMnJtQW1NQXR4MFJZenNFZTlR?=
 =?utf-8?B?THRlM3FZYnVYUkVDbXJsQnRBUkZyRVkrSXpDNFcrRzI2TzVpaXhwNmZaVUlP?=
 =?utf-8?B?QXZVZTNJRTNYL2s1YmJaSDZSME9VbTZqaUJQQWFjSGVRME5LZHJiTUE5S1Y2?=
 =?utf-8?B?ZHhLZmV1QnZvYStSMm9nQ3NoS0R2aHh1QUFsbUhLdjZoVGdNUnRVek1pKzI2?=
 =?utf-8?B?ZVR6dk5XNXF6emFoSlcyNURZRFArNS85ZGtvREQ5NU5pZElRZ0w1SVREeDJN?=
 =?utf-8?B?aXpDZHhhSHJlOWY1bTZMVEMyWjUrZ2VBdW5LMDRaTEM4MWVSckpjZ2Z6MFI5?=
 =?utf-8?B?emJ4V2YrK1htU3RTT291Y2pBb3lWaks4OHhZR1RkSEZacnNuY1gvaDZrVU55?=
 =?utf-8?B?cDdNbm9TVnlZUEFiSmNwT080cG9BY0xVVzZqMS9yUDBWSmx4Y3RMaWVHQ1VJ?=
 =?utf-8?B?Mnc2Q1ZzOXd2RWdiYzdCRFF1ckNDUDB6Z0RPWUZUNldQZTlrQ3VSOGgzN1gr?=
 =?utf-8?B?K1BURmJoOE1WRjFxaHVxZmJFREJ2OUhEcEVTcjlXdkFHL2diL2JsNTUxQnNE?=
 =?utf-8?B?WHZzdnY5dEJsOXlJazl4UTRHUU81ZVFwQlZUOTBEeTUwVmZ2RTFZVS92b28w?=
 =?utf-8?B?RFVMNDlCUU5yanFvS1RSclk2bXR0Y25DS0x4N2c0c3BUeVk5a3VHNE5MbXVB?=
 =?utf-8?B?cDFZSjM0c3hkRFdueXFIbVluMk80SUhNc1hRSkNVQlM4b3hiSXliQjhMcDdL?=
 =?utf-8?B?MWZEbXh6SVo5dnVlc2IraTcyZTNlVUg2bi9JZGFEei9CZENrM2pCSHhXRnow?=
 =?utf-8?B?Ky9iQVhzbEs5azU5cEhiOGYwYi9OQ1NmdlVGNTk4a2lYQUlzd2hjbzZ1R05r?=
 =?utf-8?B?TlhUVERyOHoyMk5JclMxMkpTQWszbitBYlFPTDZTNzZBYXlPb1haV1ZhNUx2?=
 =?utf-8?Q?x9yCMEZ7GCd96kZW7qr9MhOgm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b57891df-519c-4887-f398-08dde6c146f5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:59:55.3941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5Gkt9BOkmFOHTjwrzzusg5mTJJEco25FpQ/O+86u+lHN9N25pOFzlUatTmj/vTZ37ZyDMPpV1lcHSU21gzFUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7038
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

On 2025/8/22 14:40, Zhenzhong Duan wrote:
> When guest in scalable mode and x-flts=on, we stick to system MR for IOMMUFD
> backed host device. Then its default hwpt contains GPA->HPA mappings which is
> used directly if PGTT=PT and used as nested parent if PGTT=FLT. Otherwise
> fallback to original processing.
> 
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu.c | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index af384ce7f0..15582977b8 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1773,6 +1773,28 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
>   
>   }
>   
> +static VTDHostIOMMUDevice *vtd_find_hiod_iommufd(IntelIOMMUState *s,
> +                                                 VTDAddressSpace *as)
> +{
> +    struct vtd_as_key key = {
> +        .bus = as->bus,
> +        .devfn = as->devfn,
> +    };
> +    VTDHostIOMMUDevice *vtd_hiod = g_hash_table_lookup(s->vtd_host_iommu_dev,
> +                                                       &key);
> +
> +    if (vtd_hiod && vtd_hiod->hiod &&
> +        object_dynamic_cast(OBJECT(vtd_hiod->hiod),
> +                            TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
> +        return vtd_hiod;
> +    }
> +    return NULL;
> +}
> +
> +/*
> + * vtd_switch_address_space() calls vtd_as_pt_enabled() to determine which
> + * MR to switch to. Switch to system MR if return true, iommu MR otherwise.
> + */
>   static bool vtd_as_pt_enabled(VTDAddressSpace *as)
>   {
>       IntelIOMMUState *s;
> @@ -1781,6 +1803,18 @@ static bool vtd_as_pt_enabled(VTDAddressSpace *as)
>       assert(as);
>   
>       s = as->iommu_state;
> +
> +    /*
> +     * When guest in scalable mode and x-flts=on, we stick to system MR
> +     * for IOMMUFD backed host device. Then its default hwpt contains
> +     * GPA->HPA mappings which is used directly if PGTT=PT and used as
> +     * nested parent if PGTT=FLT. Otherwise fallback to original
> +     * processing.
> +     */
> +    if (s->root_scalable && s->flts && vtd_find_hiod_iommufd(s, as)) {
> +        return true;
> +    }
> +

I think you'd add this logic in vtd_switch_address_space() as the return
value of this helper is to reflect if guest has enabled pt. It may break
logic in the caller side.

Regards,
Yi Liu

>       if (vtd_dev_to_context_entry(s, pci_bus_num(as->bus), as->devfn,
>                                    &ce)) {
>           /*

