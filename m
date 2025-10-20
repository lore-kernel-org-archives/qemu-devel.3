Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB01CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 12:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vApAm-0002C9-UG; Mon, 20 Oct 2025 08:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vApAh-000283-JU
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:39:31 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vApAd-0000oP-36
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760963967; x=1792499967;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CFaAFH1xISF8lSIESQnGhsq3vlm7nY8Caa2aEgYY75M=;
 b=mOxw4Rk95ciCuzRoK7oZoN9k7uFlL3dptrMXPgvbSf/dqOpvjQhbTCIk
 IweypG4qUqwm87+pIcOWGT+eNcHbgnyhwA8EZW+0ksoMFjJbWeCk9NyOh
 yoekTYxFDniR24IP6gsDt0OvToI9hQsHfnYIPjUYTGZJQgiMrdzngHMpK
 iTGpf9huDbx3dFVJr3Thq+458Fje0nqpf2vhvCcYdq3mHmtoMyBgjU/GL
 k5U5E1EzGiRefMveyWdc9GrhOmjdLqgZYa94xn+pjKQ0H+IcYig29ZZPQ
 7HbknqC/v0L5tTA9qRPIw5HMyLkdxpIMU62NV1+XoFE55WhEJhz/fD53s g==;
X-CSE-ConnectionGUID: no68GU2wTU6OeLwFln4OPQ==
X-CSE-MsgGUID: tyiSPlpQT4KrW+fFZwMarA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63117700"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="63117700"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 05:39:23 -0700
X-CSE-ConnectionGUID: JuHAHkL1QVaSnTukh1osVg==
X-CSE-MsgGUID: AqLbmbofRGazvu254Usytw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="207005601"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 05:39:23 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 05:39:22 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 05:39:22 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.15) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 05:39:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alf/VChZ//ErtPWjWZS0fGkfAxSgRGnLg1LJtzjnwLCy1UXS1+ad0bKgW3TDcJeltOJbL3ayetxmFbxLe/NVMdYPq18hsmPtK52CO2U1rrX4dXNmfxWR/WAmdY5mle7H7/1bfGojBWTcJ3VDahQYbkXlWDvfusorqhAmJsMHeLKUz/WmvxiTspV4CfCuihtUBi2TkCn78n0JBUWQjftW7Krhj8ddGfBGXg4JG7ybXyLoZViZuDix+IEZ4SyTyhX4QlPhNrhFAHGNK0DPUdf+cjY/m4/iM55X+Yp9yYSTVWxRe8X5lr3MSOVBWNDxZqqBN6kEEMRb9/p+6TF2Grg9LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ryj93tx6sUKYxSG5kyuvr2Ph/2C6318M+d+3ayGikgo=;
 b=TXj2SFPoGuSFQFBS0OnmYxHeoIgmAkx72F9VwJo/Ap5evg95HoImLf+OFv9X4bddqS7XGd92/AmoBjnWIwdMqET7CCC9q/mvR4Lh7PaG0DM9hU8nJK5MShKMiOkU2H+IP+SVCOwGlpcS9jGedE7Ad27jpLLi/kgmSuoTGLtFj1EfbKa+3fMy1t+WEsjr/5BOnSSc/lq4VsJ1h+B6HyxbqRxdeu1A8utJrLxksXXXA8IJBJ31by4OUEtmszyauzPInhiERsSUUQ/KKuy3ESjQNaPsj1Rfp6u9aQRdB3s+SaNVramF5WWdJvbvaClTWSlVnbyJ04oVWdQoYw8b2qcOnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by SJ5PPFB8C3A0B7C.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::84c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 12:39:15 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 12:39:15 +0000
Message-ID: <f5342918-497f-44dd-b39a-07a56ca0826c@intel.com>
Date: Mon, 20 Oct 2025 20:46:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] intel_iommu: Fix DMA failure when guest switches
 IOMMU domain
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <clement.mathieu--drif@eviden.com>
References: <20251017093602.525338-1-zhenzhong.duan@intel.com>
 <20251017093602.525338-4-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20251017093602.525338-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU0P306CA0039.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::13) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|SJ5PPFB8C3A0B7C:EE_
X-MS-Office365-Filtering-Correlation-Id: 6847ca70-e656-4752-c08a-08de0fd5adaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|42112799006|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M015SkhITkxhYjNFWk1pYTRuM01QTHR3WExQLzhUc1hZaWRjbE1OWjBmeVIx?=
 =?utf-8?B?Yy9SSDBtY2NQanhaZjNKclk2d3hld3dWSEIvMGovMmxGWHN6R3V4bGYwVksv?=
 =?utf-8?B?WXVZcUZwWG4vcEt2azdKVndiM3FqaHhqR280eHMvL04vT3ZSdkEvanBpTjVx?=
 =?utf-8?B?TFVzS29aSlNkTjhhZjN1ZStNMUx2NkY0L0FyMC9BNDVmU0dBYkNvWTQ2emxU?=
 =?utf-8?B?U2loRXNkY0xLU05yQ21lTTc4T0hNUnErSjJ2T3h0MUFqQjl2cUVrZ0xvUHB3?=
 =?utf-8?B?YjBmcEhJUFAwUVU5eFNVMjlYbnFEN0pWaTF0eHFPem1qaG5RZVdKc0Rmdkxv?=
 =?utf-8?B?Mzc2WlAzeTl2WGc4ZlBQcjI3eHkyOVZRVFQzT3BINGJ2VFZoQ0xiOFlMVE52?=
 =?utf-8?B?aUhJeFhRMWFaT2lJQ3VuUU1wcmhyMzhaMlRWaGtJZkVrcTN4MGVtU0VOQldw?=
 =?utf-8?B?UmtjVHhkUXlYME11SndZYTYxM3lKNmFxM0JDcGFheEh6TW9vMW5hN1MzNDA0?=
 =?utf-8?B?R1Y5NW5tZDlPbzNyeGRMZmhPcHJpNUJEbEt1cEs1M0FTRFNjWXNEZE8wVEhu?=
 =?utf-8?B?U0lOOWxEZDRpMFdUdTNzclJNMTBpaWx0aXJMNHdUUzJLNkJac2RsdkJIZS9W?=
 =?utf-8?B?SERKRFFOWGtxdjdmOU1OV2RYdWk4ZzVvM1BrZklqSHJUSmpBa3kxclk3ajk0?=
 =?utf-8?B?ZlNTL2gzbnNxWW5TU3NhREJhV1k5LzFJSmFSd3hHRGovV0VUZ3htWlJCR3JB?=
 =?utf-8?B?NWpuWUxVOGVON1RFZmNWY0VwSXR0VVhPUDlueGpnKzhSZmhtbjBRZURoemxS?=
 =?utf-8?B?VzU4czZZYjliTXlySUpWQ1JQd3QrTzkyOHB0UGdyUEhnakd6QllKZkpZTlNX?=
 =?utf-8?B?cTdIMUFGRmZEYmQ1V1ZTd282cXJJejEwUnBEYVVnbW0ydXQ3OXY5MUdBL2or?=
 =?utf-8?B?aDg1Njhwd3RJU1BaajZlKzV5N2YybG1zRDN0dUkwQThiaEg0MkdTdGFGbURu?=
 =?utf-8?B?dHQ1ZmdtQXBKQ0d4bDFCaEJ4NFpQayt3VFJRL1YvSTlhclNEeGZJUDZ2b1M3?=
 =?utf-8?B?dDBoZHdZdjFQVVRIblpCV1FNZTRndXllZmRSVVMyRXNFRW1GWmwzVFE0WUcw?=
 =?utf-8?B?YnJwVzlhWExEQmw4a2xadDU2WG0wRWV5cDJtTTcxeUxRS2JnRkh2WDhRWFV0?=
 =?utf-8?B?bnVZeDh2T3RsSlRTaXJOaHFrT0sxUFlPZHV0TTlLS1VHMVFJNzA3cUxmcGEz?=
 =?utf-8?B?dUVQaEhwcDlRd2htK0FKeVZHZk1COEN6VlNWaXp4Y2FOS0wwMHRnME1PZjJu?=
 =?utf-8?B?K3pReXJybjJGd0J4cHlPcldDR3RyaDVhZ3dNTml6aFZ6VkdxMkhmaisrbWhQ?=
 =?utf-8?B?R04wTHNFVGpOejR3dXJBT2ttaG1LbDBUWnpIS3g2c3JRTDFEbDlrTXM2YlRR?=
 =?utf-8?B?MXZtdEl2dUxjMnVTc3JYUEFNc1lrR1lDcEliajEvbGIyM2JJYmczVVdrT2dU?=
 =?utf-8?B?Sko1SVQ3YVYyN1VGZGJ2R05yK2VnZ09QakNjdG5QcnBvY2g1Z1RWZDZRanJ6?=
 =?utf-8?B?NjR3RDVzaHFER0lma1Z4REx3UXlsa1lRTHIvK3NIV00wa3lYZUVTeEdyU0o0?=
 =?utf-8?B?T0NjakhHV0ZnVkZReWRDdFN3dFBtQ04rZWVmV0VFVGl3cW9qK3lvc3BXcE05?=
 =?utf-8?B?eVdmTTg2SlVjeFRPZUQyanFKY0hUeFRyeHRyN3B2QXRoUU94RHp3bUhkQzdQ?=
 =?utf-8?B?Wi9WR24zUTkrZ0o4dGtXMTdqMllmNkFZeGxMclFxZDU5Nm8wYlljbVpzZmNO?=
 =?utf-8?B?S2VIYUhvQTdmV0crRkdQOTVjLzFGNWFNcTVocXNWWFFES3BIU0t5YXZONXIz?=
 =?utf-8?B?TG5FWHJCNEU1Lzg4MHpGcDVKa1JvanNvbEhvWGgwNTMxWnBWTXJ3NVhnWTJq?=
 =?utf-8?Q?LuZRrcQFI4/C7UoXozW9pHvm1tZ3PmsE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3ZjNHN1WXJ4OVpIT054RkN2OE9OVGJ1UGhOMzBaQ0NzdWRTWUl3VjRVVFNk?=
 =?utf-8?B?OC9qdmVlaVk0cnV5ZXg5NjFKc0M3SlRVYWpGQ2FnYTBMSEJPRXdxR3dRMUtn?=
 =?utf-8?B?dDFVQllBYmcvR3Fua3R3MHhRTzd2MUs1cXJWcjlVa25CWmxMU0NQa01zRXlO?=
 =?utf-8?B?UmthR3V1bzJaR2cvcTZCRnpia2FpS1h5WThuWE40cy9Uc05rNFM1WEdnTWtX?=
 =?utf-8?B?SVVrN0F3aDd6TnAzbU9iVk9jWWhKa1d6bUgxU1k0bmF5WVc0aXVEcS9mem94?=
 =?utf-8?B?cnp3MXNzYWxwbHNGQ1NIallnVEg2MnpWOUZ1eUxtSk5mOGc4WC9oUjVseDh1?=
 =?utf-8?B?a3c3T2JKYmJMMVEyMWpEemhTZDMrWDVLZHhlV09zU1MrN3E0VUVlQXRQaDZ2?=
 =?utf-8?B?WlN0V1hVSzdRQXZZb1R2dGN0VEREcUYybmxpM3VxTzZhTythSk5GTnFNWDh1?=
 =?utf-8?B?aDQxRWVIUnkrREhsVW5ET2pJeUhLc1VrZjloS2NzdkI2Q1JCeVdCNFZjN1JP?=
 =?utf-8?B?N2cwd250bTJKekRLT3FsclJvaStzMU9VZWNscmZoMFpIMnFJVGtyYzhNM2pX?=
 =?utf-8?B?ZUg2ZDBIcHpIbkJ2TS9lcGZackFmTmVGd2c5OUdDcmRoR2tJMVN4QWpGb3Nk?=
 =?utf-8?B?bjNTWXg1Q0hQeHFpRE1TcGZ5VHZjRWF4dVp5YkNEQUJybkFudEJRY3VIcE0w?=
 =?utf-8?B?VEIwN1o4WXVQbzU2aHVTS29MWWNzNSs4TmgyYmpnTCt0Tk5Ba1cxVFNFWnU1?=
 =?utf-8?B?SFJ1SWRqUDI1SFFKczNUYWZsQkRTdFN5bldJZ0dDY1duMUNUS1BPME1HRjJM?=
 =?utf-8?B?VHJnTWJQU2FnSlBnaVhzYXBvRExhaERQRWl0QXNrQ1hIVUZUNEVkbWw5c1k3?=
 =?utf-8?B?SlhhUFduZkszTGkreUhRWi90Qk1qazRQdjd6NkF3SytRc1RvOFdDYTVBUVhK?=
 =?utf-8?B?dk9KQm1xNHRrdFB2MmRYVjRzZ2ZMTE16eTJCbHVFL1dxMFRaZWhERWFlVTFR?=
 =?utf-8?B?ckJ5aGk3WnpLMXNFcUNIWTJIbkZGV2kxem50bkQ2cHBrOEtKczBsSzFxbzlQ?=
 =?utf-8?B?UzRDTndMbzk1TmI0cU9TTjVMaTF5bjN4MEFoWGV5MlpUMlEreG5EV0k5Zzkr?=
 =?utf-8?B?SVU0VGhHNlI5K3N2YS95eDdZZzRHM3Ewb1dhc1dHZ0JJc3UweS94d25HTUM3?=
 =?utf-8?B?SitSd2tqK1JZL3NEU1dYaUdtT0NVcWFuNTFwYzdKSFBEVXlnSTIwOUdKRmMx?=
 =?utf-8?B?RzVsKzdyTVhqRlRaS0pJckd3ZFNWOVQ5NktrNWJEWFpxZmZmTHFnQ0UwYU44?=
 =?utf-8?B?QlNZRnJjQk5MdTdtSEtzNStKZTJFU0U1VE9XM1NpQ2tGMnFXUWJtSFpWUGFW?=
 =?utf-8?B?Q0RDYVN4dG1RcHBCbUtLd05aRjNYa0RBc2c4V3lZVDlBRHFHZzhJVURBMTBK?=
 =?utf-8?B?dDZVcGVEU0pGR1VJWnpDNExMa2QrWFUvWXdpb2l6UCt3RU9Xd3ZMWG5HL0Vs?=
 =?utf-8?B?T1NJSTJCQzZZQkJrV3lxY2Y0b1huQjBiMUpDb0lqY2gwUitkbHR6eVg0U094?=
 =?utf-8?B?bjZqdkpEWWxzOW03azNTRmNqQUZuVXRsRU42VTNjY1o5c3FQTXM5NEpKVzND?=
 =?utf-8?B?b2pxQ0U2T0NlL0V6di9LUGFoMk5tTmV3dmt4R3ZTTVAvVHhFOGNHVVpEK2Mv?=
 =?utf-8?B?STFpQURuQ2svZTdLb2lpdENkSjVrbkhDODJKZWJGK0pFb3lNWTQzNWFHOTJn?=
 =?utf-8?B?S0Q5enRSdEZlSkhIdWV4YzRGY1BGNHVIaHRqR3U0MEIrVmdFMk9aK25UV2wr?=
 =?utf-8?B?T2xMQzY0WGRVNFMrWXZBeHl0QkVCV2JZcy92c2cxZVhlUlY3b0g2bDRMeWRn?=
 =?utf-8?B?MDRyM2JKYTZpVW5ocmYvUWdDbXdyeUlVTEdGRGZIZ3NWcGZRdkJHV1lGems4?=
 =?utf-8?B?T3UzR1B0NEdLUGhORzM2djhoQTgyR1ZicW5lWTYwL3dkTXluUU1mdGpkdWRo?=
 =?utf-8?B?QXRlZTBtbDFJK1MzUm9lUytDckVMMmxFNnE5ZjdqK1V1bXYrenJ3TXZYMWRN?=
 =?utf-8?B?RTl1V2tyZWp3bGE1THhKdEwycE95NTFSRVVuaTNQa2ZKZTJPSnl4cXpyeEF2?=
 =?utf-8?Q?zi3zpOswCcv1KnuzzwNWczsc7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6847ca70-e656-4752-c08a-08de0fd5adaf
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:39:15.2231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Il9F9dnWKzlMxaBJRR+1v4SnasgjDpxB1ERCHq68JW/wYAseVfdqWoluc4eFZQsRh/xpfJR153D1GiWzirceeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFB8C3A0B7C
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18; envelope-from=yi.l.liu@intel.com;
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

On 2025/10/17 17:36, Zhenzhong Duan wrote:
> Kernel allows user to switch IOMMU domain, e.g., switch between DMA
> and identity domain. When this happen in IOMMU scalable mode, a pasid
> cache invalidation request is sent, this request is ignored by vIOMMU
> which leads to device binding to wrong address space, then DMA fails.
> 
> This issue exists in scalable mode with both first stage and second
> stage translations, both emulated and passthrough devices.
> 
> Take network device for example, below sequence trigger issue:
> 
> 1. start a guest with iommu=pt
> 2. echo 0000:01:00.0 > /sys/bus/pci/drivers/virtio-pci/unbind
> 3. echo DMA > /sys/kernel/iommu_groups/6/type
> 4. echo 0000:01:00.0 > /sys/bus/pci/drivers/virtio-pci/bind
> 5. Ping test
> 
> Fix it by switching address space in invalidation handler.
> 
> Fixes: 4a4f219e8a10 ("intel_iommu: add scalable-mode option to make scalable mode work")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu.c | 29 +++++++++++++++++++++++++++--
>   1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 07bc0a749c..c402643b56 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3087,6 +3087,11 @@ static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
>       return vtd_ce_get_rid2pasid_entry(s, &ce, pe, vtd_as->pasid);
>   }
>   
> +static int vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
> +{
> +    return memcmp(p1, p2, sizeof(*p1));
> +}
> +
>   /* Update or invalidate pasid cache based on the pasid entry in guest memory. */
>   static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>                                           gpointer user_data)
> @@ -3095,15 +3100,28 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>       VTDAddressSpace *vtd_as = value;
>       VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
>       VTDPASIDEntry pe;
> +    IOMMUNotifier *n;
>       uint16_t did;
>   
>       if (vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {
> +        if (!pc_entry->valid) {
> +            return;
> +        }
>           /*
>            * No valid pasid entry in guest memory. e.g. pasid entry was modified
>            * to be either all-zero or non-present. Either case means existing
>            * pasid cache should be invalidated.
>            */
>           pc_entry->valid = false;
> +
> +        /*
> +         * When a pasid entry isn't valid any more, we should unmap all
> +         * mappings in shadow pages instantly to ensure DMA security.
> +         */
> +        IOMMU_NOTIFIER_FOREACH(n, &vtd_as->iommu) {
> +            vtd_address_space_unmap(vtd_as, n);
> +        }

I just realized that if the MR is nodmar MR, the notifier is not
registered at all. is it? So the above loop and below does not
duplicate.

> +        vtd_switch_address_space(vtd_as);
>           return;
>       }
>   
> @@ -3129,8 +3147,15 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>           }
>       }
>   
> -    pc_entry->pasid_entry = pe;
> -    pc_entry->valid = true;
> +    if (!pc_entry->valid) {
> +        pc_entry->pasid_entry = pe;
> +        pc_entry->valid = true;
> +    } else if (!vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
> +        return;
> +    }
> +
> +    vtd_switch_address_space(vtd_as);
> +    vtd_address_space_sync(vtd_as);
>   }
>   
>   static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

Regards,
Yi Liu

