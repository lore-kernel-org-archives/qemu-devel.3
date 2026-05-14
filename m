Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB568CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 06:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNPui-0004mZ-Dg; Thu, 14 May 2026 02:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wNPug-0004mG-T6
 for qemu-devel@nongnu.org; Thu, 14 May 2026 02:51:18 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wNPue-0007QL-Mz
 for qemu-devel@nongnu.org; Thu, 14 May 2026 02:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778741477; x=1810277477;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HSuhd9VAxbs3XMLYeHKoZ6oTUjMuZQrJpbefrWFkSHQ=;
 b=XJm2Wtd4IObbKCOcVdlbQgV3tuoUzH34s/4MnFZUGYUOkTvakm09Mrtn
 7012ocRSDgO4K/ybqUjseBcGSorWr1g2foldtHJkQr5T5MjBSjtvVLV+b
 Fiia2AZeLp/lKB6oIp+tQFQbPApHdZ2PGGel8sP0SPqHlLi9tkWVw5K2X
 DEEfMZLOTIXon0FdiQqV0U/gG4JO0oaaTRBNppJLN+FcZMVT2vn+pWWXL
 mzzVdnY8sdyDEK6tWyBMoptyxLKih0tpjTTC/sVq5m3ZItYLYXi0nXXae
 h6vnLFhDaJONPthyCtvHIRJjwyyRTLlOv+TdZ2ElcWWVef4gyU5/FMGuM A==;
X-CSE-ConnectionGUID: pGC36uLySOiaDBll9IuhvQ==
X-CSE-MsgGUID: 4K4PIEF+Ty2zTO4W0l0PFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79658584"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="79658584"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 23:51:12 -0700
X-CSE-ConnectionGUID: VCOVEX9GRiSZUHkXsBA1lA==
X-CSE-MsgGUID: SZo12oYwSkW2xDd+H6X5ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="242303278"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 23:51:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 13 May 2026 23:51:10 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 13 May 2026 23:51:10 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.33) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 13 May 2026 23:51:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/xbdXd6XF2lBSTp1v2DShT1E9E27+idD2VqoIU+jPXE/5OesCKSRsk2HeZHvG6TCL7VW10HcldkfQAYPHrced2i6n8igyab/y+lblWQ1TupRgxj18jIMqZUBEwIuJnHn4kH2xSb4KKrqm5tCPIhAJPnwybYaXs0rNMUNCygyt1VeUBFGJTJmcnJzO3q4EG0PoIQ64jVxlr84lx8nSMnEKb/n2aJPIi93WSwXIflvxxeIR6L1EvoeeDv9lCEBfwS2yGzjUabkATHvT/6oxUaPskQEN51zKpcok2f335n3aMuT/OouR8jC9+zmuTx1bgoaIs50+SxdRkU/luJLuNF9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Df62rVljcwIeuhX2ZK3YTeMv8nbwzW5z9+xR0wqQ/g=;
 b=XooMRP3UHFHaznSaRuiw491J66DswlH1olophb/E30REmZC63SWa8CZKm1cEKyzRYIW0kqUfgFZQuV46ldfEkEeCyn+t0E7/j86kWlOH2rw316BfdyAFy19DFmOqjwnZbszhZhmgnPRHfHIZcfswAE+72YTJthce72c8u8iZsgVY3ijxMfbDOfBmpMZUGIDYFRx5z5n+shrHwCKsaklq47RMv6nbMFDadadl/0LALblrZUJee2FWvx8NMJBc/EXPwpxrZ7vYlbkp21y9/b9bY86UeWHJn7Sj2EcodzEIla2noZd+b4w+hOMlg7XbG1ziVkAZ0d1w1fUoak+bbX9wrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SJ2PR11MB7501.namprd11.prod.outlook.com (2603:10b6:a03:4d2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 06:50:59 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 06:50:59 +0000
Message-ID: <04419328-e18e-45c9-9180-bb8750702502@intel.com>
Date: Thu, 14 May 2026 14:59:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] intel_iommu: fix guest-triggerable abort on
 oversized MMIO access
To: Junjie Cao <junjie.cao@intel.com>, <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <philmd@linaro.org>, <mst@redhat.com>,
 <jasowang@redhat.com>, <clement.mathieu--drif@bull.com>,
 <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <farosas@suse.de>, <lvivier@redhat.com>
References: <IA3PR11MB913608B2CB25D851EE72D35492382@IA3PR11MB9136.namprd11.prod.outlook.com>
 <20260514134211.48018-1-junjie.cao@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260514134211.48018-1-junjie.cao@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KUZPR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:d10:2a::19) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SJ2PR11MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 04bbfa8b-5ba2-4b54-3e9f-08deb18527b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|376014|366016|7416014|22082099003|11063799003|4143699003|56012099003|3023799003|18002099003;
X-Microsoft-Antispam-Message-Info: DB4lUGQfq+JvY+WpVS8zaF9cqK2QvSk1X3XNTMHDhJMNwv19XKOmYOqcRi8ZoirTbBfrsfaVA55OW4TzydVzY+aVYntsabTvK7CzG5rqvh4EDB2zR5Hll2KNGeyNWY8P8FEKxyhXWCBUeuANRPZUERBNWz+c6cJyicOmbw6JQL2KCygZMG1Y01DL6oHCPA67mMRW+fdvGIQGirEmWtvEHh6WiAacP65YLXZWyH2LYvHHpNIlGBXYKjMYR7csV+X6VbSi2hrqv6Ppa4alqtpFCl2pk/WNuWKSBzC0kOIlDd7aGEmO6xT2O2pAkciUntQgoukqvIMIt+pwuGqBTs6LYMjK3iKHLX2xqDLLfGGJnPVR28F+DNmhY7KnCW+2twjD2i7EyzYm7zbEfhca1B/r1bHEVA5OOvHSICRVOib3RlpQDn/0ogG0ur/aXBA1jrlEJA0MdtQkD02Rzgsq3CzX2Lvz6/JysBvb4o/0u8Gs83XjYhWrOIORw+3ff6pX18+8V5bRxpHeWvMxl+Dgi0/RWoDNk6dqiPVmY+6jfdjXdbz8XunUEZJdr5GYAZUhVwNP4tTbcTc6KkIIih9pCJM5RtH/MgNgtUKzSLVhCDOasgKI5GKCbRZP4iByeBdWByXoWl/22IeitMD+8qXBTdNTA85NS20wqQlwyr+JHE1rlxc/mdiP5fCTMnHXpkSaWD9N
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(376014)(366016)(7416014)(22082099003)(11063799003)(4143699003)(56012099003)(3023799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2lidUJkZVduZVpub21SY2FOYnVpcEYvbU9wc2hhd096QlJYOXJya2JHc1V2?=
 =?utf-8?B?RFFmZngxY2pwTmptbGozY0pHOXRRc2ZSWGN2N24zOGxrU2NNTXV0TXFGRXZL?=
 =?utf-8?B?WnRxVnUzTUN4Nlc4YVExRjd0YXB0ZytKRHVmOVdoUlc3eGtVUmlCMWlJWTY5?=
 =?utf-8?B?ZGR4QkFLYUZ6RVFXNlI1emxTME84Q2V5Rm5VSDJvYzJ4OGtLeGgwOGc1QUt3?=
 =?utf-8?B?SGc0cXFhYlFDalpSbFo2WTlKMEdhcERaZTVqUDV1YjZMb2FkZTkwenNwTTBp?=
 =?utf-8?B?VDkwanJydFE4NHFmS2N5ekM1eGNTakFONWg0RzBLZzVBbzJleEpobjB5aThp?=
 =?utf-8?B?Mk5WaHpsa2NJQytTbHNRSEpHSWl5OFhYN0R1RElEQjR1ditacWRLK0kxWkww?=
 =?utf-8?B?bU1zRXZ3ZWxmOFIvakdwTEcyQUR0Wk9iZ0NyeGt0T3d4YjhBTFNSYldzNTlR?=
 =?utf-8?B?Ykg0ZXhWTzRPSklmL29sbjN6STdVNGczdWUzcDE1VHdkdjlRQjZ5L3ltL3lq?=
 =?utf-8?B?WTJuanA2US9Jdncyei83U3JmTjNmalkwMVNyOXc1VGFBMkRrVUxsM0RkZGFv?=
 =?utf-8?B?d1Jzb0VtUWNiNGw4ZnZEdXU0Uy9RRFdzK1AxNzdWdGlFQVFYUmZ0c1JFY3pT?=
 =?utf-8?B?RGxHanh3VjNRQ1EwcXllRUlYYXFVNjF4elFOOXZnTDhzanBqVXpISHdoZ0wy?=
 =?utf-8?B?Tk5ncXNFSk9kV1hkaU5HQTQ2ZnZHSUhzTVBNaHpZbEtPMkN4MHVIUCtCc2dy?=
 =?utf-8?B?T1c4QzZ1TmlnNUw0NUdpbDlBWDQ4WGNVcjZnL3JsNFpkNHVCZ044UGgxQWc1?=
 =?utf-8?B?RTl0M3lQb2JwOVJqUFovNGVlajFjY2oxWXJqakQ2cTFESy9PM1BLZFlIWG9v?=
 =?utf-8?B?MUFtenA1ZE5tci9jRFRWc3pkUzhQcTgrQldUVUtwWDJMbzYzenZTcWIrdkxu?=
 =?utf-8?B?Vi9qRnN1SE9BWEgvREM5RjNLOEhpRXU0aXRrUTVsaGFKSmp5VlNFOTQ0VzNZ?=
 =?utf-8?B?SVdJeWlLak9LNG8xcjBsK05YUm4wbTI2MWhEd3dCOXFWT0NjTEVsMUtneGZL?=
 =?utf-8?B?NHBieFZXVlFCSTdaS2RjbWU0Vk55Z0xoVUxLVVFvZ0NoMzNEcWVKdVN0d0VO?=
 =?utf-8?B?NzJpT3JXRW1FQmpZaHZJQklhOUwyejBJUXhYVnc0VGw1UjRheGlBWFZwM3dF?=
 =?utf-8?B?QjdMZ0w2UzdiQytrMERvVmcyc3FJaE9NRlhKMWU5L001eUxSL1ZDeXZEWVps?=
 =?utf-8?B?UXk5Z3poYlYrMEpSbVI3MEYvMy9XdzRmL2FvbkpPMXFzU3loZy81cFBUR1Ju?=
 =?utf-8?B?REQ4dHhYY1Q4Tm4wUnBMTkNNWlhQMDJ4eXJQQUJCb29yN3FYNUlhS2dXdHIv?=
 =?utf-8?B?NEZmRTgxNHFZVGZKSVdCWjBQTmRLN05JMHZtOVppTklhSHlUYUFCaDNkY1dG?=
 =?utf-8?B?QXRnQUpXWkRxQml3emRzWmZQdU5ZZ25WNmZnMm11WFkyalp2TEcwcVlUR0g5?=
 =?utf-8?B?RFhHWDBLVSt3VU9abVlBUEs5cnZDYTRUVmlsRHBDbkNNdXBCYmwyOUN1WlBq?=
 =?utf-8?B?OHlFdjYrY29nR2dOS1JjYTJsbFA1cE1XZVZmVHpUeldzdlFUNUVGT1U5L3N6?=
 =?utf-8?B?Wm1kRERPTnNMaWE5YXZBd2F6d3ZzQjNUaGh2ZGJNaUdGWXkxU2luRVZ1M0Y4?=
 =?utf-8?B?R2Q3MnJGaVczYWlKUUJ0TVNYREc0Y09MbzNHR1pmUm0weVZIYmYwK2VxTjkr?=
 =?utf-8?B?N1lweitWS05hVFliRDI5ZzhJdmRrdGRnZS9GenF5a0FmWHFRMmRBR2xYZVZ5?=
 =?utf-8?B?MmZuRCtqUXRJaU5iUk9BNHNLM0pnNW5tSCsyTWxkS2xmT2JCdlpzOE1UUmp6?=
 =?utf-8?B?eVBMM1BGUlNLTWNQREFKOVhLZ0MrTUtPY1U4WE5ER2hPMm9oeE9kRjlSSm5a?=
 =?utf-8?B?Nkt5ZGd1RVZjZ0tLcDhNWUlxSFU0UzRVN25Mb1hxcjFOMjRUN0NybWZhcmM5?=
 =?utf-8?B?TDdZOXhMaVBiN1VCSFpyTlhwQXZBbWQ3TVplN3VQUlQ4TWtBMWpFZElKdGVj?=
 =?utf-8?B?OHNiZFlXbUNMS0VtR0cySGlSSjg5TmsvSlUwZEpyRlJ4ejVONmk1bUJVS2d0?=
 =?utf-8?B?WnNFYW1YUzdyZ25UNWg4bEtYMTNoOEJua2NoNm9XVzliaTNlQXZaVE9RUHly?=
 =?utf-8?B?OVlkOTl1aGZDczNnSzVEd0t2aGRVcVQ1eUtKaWxmMkR4RW5ocy9PWDhtaFYr?=
 =?utf-8?B?MjV4aUJGUGo5U3lzUDJaSkMrY010ZytNT2tBNG9wYnpWYWxxbmZHbENRdHBa?=
 =?utf-8?B?aHo4dGtFUitEd0RaYWV1V2VFTlIvT1ZJUmc3RnNJWGE4dWMzVGFRQT09?=
X-Exchange-RoutingPolicyChecked: L7uxeceARZe+y2bvPDTQfICyS4ZtvEZmMLFxsVSOAb4993TUSX6tOCBxtAblZZSpZiwnSo/jljPitCysAEVG5B5z4xscIwmI0a1dsHmib4JaM40MGcOdgj5S8Ef0MxJ0gEIkhgXpn7GCOG0s2LyYMN4jHfA5R6ndYQjaSIbTnPWA+dXMGhYxNRJKKQ8hs5k5cnY9Sm20+dIDJjpDBuljnUaH8I1dpQy6AwbLG59y3LUvLOcSCdRZZ7GTH3xxL9Xn9c2s6LsxNlskYn+1gyJ7p75jLuppxI/4ygUDjXizJ+dLM+j0A8kbOMlZZ4hXg7bi27mB91Rgc0hH4rRf8iadVA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 04bbfa8b-5ba2-4b54-3e9f-08deb18527b1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 06:50:59.4943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXRvv0vs8zCOqtBY8h/JpQAvO7xN7te71wCV58BfhSp+xdJ1kcWom0PqTdecCEh3gAaIZB0uYRf/DWi6FfIxYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7501
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/14/26 21:42, Junjie Cao wrote:
> Hi Yi and Zhenzhong,
> 
> Thanks both.
> 
> On Yi's question -- I enumerated the 25 v2 assert sites and checked
> offset & 7.  21 (3 reads + 18 writes) sit at non-8-aligned offsets
> and are unreachable (memory_region_access_valid() rejects 8-byte
> access there) -- just deleted.  The remaining 4, all writes at
> 8-aligned offsets, are reachable: FECTL 0x38, IECTL 0xa0,
> IEADDR 0xa8, PECTL 0xe0.
> 
> (FEADDR 0x40 is 8-aligned too but already takes 8-byte writes via
> vtd_set_quad() for Xen; GCMD 0x18 and VER 0x0 never asserted on
> size and their default/long paths already truncate.)
> 
> On the log -- Yi, fair point that the truncation is harmless from
> QEMU's side.  The one thing I'd gently float: the VT-d spec is
> silent on oversized accesses to 32-bit registers, so the guest is
> in undefined territory, and Zhenzhong's LOG_GUEST_ERROR suggestion
> is free unless -d guest_errors is passed.  If that reasoning works
> for you, I'd combine both -- keep the log (with Zhenzhong's API)
> and add the comment you asked for, so future maintainers don't
> delete the block as "harmless":
> 
>      /*
>       * 32-bit register at an 8-byte-aligned offset: a well-formed
>       * 8-byte guest access reaches this handler.  vtd_set_long()
>       * takes uint32_t and truncates the high half -- undefined
>       * per the VT-d spec but harmless here.  Flag it so
>       * -d guest_errors surfaces the guest-side bug.
>       */
>      if (size != 4) {
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: invalid %u-byte access to 32-bit reg "
>                        "addr=0x%" PRIx64 "\n", __func__, size, addr);
>      }
>      vtd_set_long(s, addr, val);
>      vtd_handle_*_write(s);
> 
> Happy either way -- if you'd still rather drop the log, I'll do
> that in v4.

LGTM. Please go ahead. :)

Regards,
Yi Liu

