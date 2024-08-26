Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F486C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 05:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siRtZ-0007JH-Ad; Mon, 26 Aug 2024 01:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1siRtW-0007Hm-U9
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 01:03:58 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1siRtS-0006by-DE
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 01:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1724648634; x=1756184634;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8trQCxrK5rjnSRis61CRsoq+a4DmYukbMENcDALrUzs=;
 b=Lt3+0ZsNS7x2gyf6so8KhrVcA6poSzAll8YdhQWfLA7jl5YRwbk5OsJt
 qvzL3NHgCGuquKKXOT/2IgJapBYO78WGSMl7HgEy+VDw2EiiLYUkgj8NK
 gBvaKkCBiJ37vHR6KcfjCZY1k6c6Vw1akZHW7omxDJH4Baai0RBJD5AMe
 ndMn8rvp+oxU2N1IwqzHztSwmSMTxvtCPCMdsvH3CLPCQKi1iehQ24UKg
 o6bci+DvOQbvw4u/iCyDbPQFg51BFayqvRIJyHCxjMWsHxH6pJpO5uvEy
 EoUm9sBFopu2lZQkpoqpxjoJfPmDpi3srADpGvDkVTv+ke59dwmOFam0Q g==;
X-CSE-ConnectionGUID: iZG7Y6r1Qye277lQwHglUw==
X-CSE-MsgGUID: vG4wUlYbRRyF/A2vZ2nhoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="40559359"
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; d="scan'208";a="40559359"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2024 22:03:48 -0700
X-CSE-ConnectionGUID: hrkGQU8KQ/+d6EIMVAp2/Q==
X-CSE-MsgGUID: VuXu6wZFQCCM6VxI44SaOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; d="scan'208";a="67204542"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 25 Aug 2024 22:03:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 25 Aug 2024 22:03:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 25 Aug 2024 22:03:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 25 Aug 2024 22:03:47 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 25 Aug 2024 22:03:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzHzcdwm1QSoHaToIGa2eNHEv0KvOstlPovEH5hlpoNuqYEY6OO3WHRdMD2ld8cyBe+aZLc07tdPseFIuR96Txa6JSRynuUcibOoo7l8FOBSvoZjopakyzNPNO0oupgW9FWu6GCJkLB9FqGBmIaRs6KJX5Duf0yBoC0WAdcwFKUY9JeXB0WoE1c9oCjJNgcmTepN1/iaibAGLdOViXmVpddJpKXtLavJueu2U7m/S66UTD2Y7tHxbf2un5GvQiOFUbed2csG7jvUs38U9Ey8iW+wVMsS3eRssDD8Nh+wrzH1EFIhpZNNcVFaId2KZJ/vqxEUWV0Zb6eLHlvsusi9xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/m/mlp/MgfHjgIWwwanMn7i8sLR7wce5QFMtJSD9kM=;
 b=PguQc7zr7HDPo2jgRPqbtO7/MPMC1g8eA5fGr1IFM5jjsHeviPdexiRTda8mCpuSb/Do4g9w72zUY6rCKJw9mkS1SpZvpZMWx5htCOtOMkCcPClksPxj0tV+/sFHcZm0nzGJU3KUZkpxVVHt37PlC/HzcRydhwGk8ZRJ5lkWZEbMCCzLXRO0Rp3u/ebI+3P/7Egv2N9WMGtURGc5/NocDLPJ7VfNmImlCZ102Aj/tYAWduXM41xbl7fKBVuEIWcyb6O1KkOCWzrv+fDRNf2EmTcyynw1AGZb3+psNN6AIIxynuVI6SSqgiJIK2Doot0yRRBDog2ycnQ6zF/mox54Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB7026.namprd11.prod.outlook.com (2603:10b6:510:209::9)
 by SN7PR11MB8261.namprd11.prod.outlook.com (2603:10b6:806:26f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Mon, 26 Aug
 2024 05:03:44 +0000
Received: from PH7PR11MB7026.namprd11.prod.outlook.com
 ([fe80::57a8:69c3:5a62:f755]) by PH7PR11MB7026.namprd11.prod.outlook.com
 ([fe80::57a8:69c3:5a62:f755%5]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 05:03:44 +0000
Message-ID: <8570704d-7cc8-460f-940e-4bf626972465@intel.com>
Date: Mon, 26 Aug 2024 13:03:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/8] rust: add crate to expose bindings and interfaces
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
References: <20240823-rust-pl011-v8-0-b9f5746bdaf3@linaro.org>
 <20240823-rust-pl011-v8-6-b9f5746bdaf3@linaro.org>
Content-Language: en-US
From: Junjie Mao <junjie.mao@intel.com>
In-Reply-To: <20240823-rust-pl011-v8-6-b9f5746bdaf3@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To PH7PR11MB7026.namprd11.prod.outlook.com
 (2603:10b6:510:209::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7026:EE_|SN7PR11MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b5ec69-3c1b-4a48-0cc2-08dcc58c75e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MlYwbUV0RWVQc2VuY1NHSHMxSGRYSGxhSmNIR0hrM1ZKa253WVk3Vzd6NVQz?=
 =?utf-8?B?U3ZFaTZJZmptRFpNVzBKMk5wbWNEZ2xRODFpclk2SVU1OXl6UmpPZDhZK2or?=
 =?utf-8?B?amU0UWlPQUZUVGJFcEZaMVZiM0ZhdjFJMXNJYm9VZEh2cjV0cmsrV3VyazVN?=
 =?utf-8?B?SWg2cUdGWjE1dUVZSHdJekdiQTY0UXF4ZmJiSUNOUWZCSHJMeXNSZENabEpZ?=
 =?utf-8?B?QXZzNU9XT2lIQ1hsRUZZRUt3V1FRYnR3Rlc3OExsNVJ0Sjg3NExwQ1pRVy9s?=
 =?utf-8?B?UXlrcnlHN0czeU1lK1A1elBoV2FGeGpVcUFSQzJvYlRMOFdDdjNrNjJGRWlw?=
 =?utf-8?B?Q3MxK0JlaHkzRG4vL2ptV2VLZE1abGh5dExncGt3TEhOTDFCbjRMOHE1d1VW?=
 =?utf-8?B?Yjc0ajVMZkZxc0U1NFJFODBpZ05MUmpqL0JyeXdnckp1UFpEYXhaYmtBL25m?=
 =?utf-8?B?T1hJRGoxV1hWUGNGRVVyY1lSM1lhb1oxQTQ1STVMTElWUVFyVS80Ui90aXNi?=
 =?utf-8?B?azc4VXl0a3Z2ZnVYVU0rMWl6aFNEZTdIaWtTb24vcWxLR2xsVjBHTS9QQUdY?=
 =?utf-8?B?b08yRVh2dCtYelo0MFNmLzVzQ1VwRWdvRDF0NGxnSG1naHdFdGVPT2RGMW5O?=
 =?utf-8?B?MU1nRE5sQmZvT2hKM3NzYlB2YVNqaVlEVldpZkx5MTRHbGttSDJpZnlqNnIr?=
 =?utf-8?B?T3VYOTRoVWJlZ1I4SHF1Umlqem9yQVdpbTJlNnNmNUVHanZyMW9Hb3lWWGFn?=
 =?utf-8?B?eXh6c0VxanNZZWJ2S08rRXVseGlLaFBROXpVblV5SElaMGh0QnJNREdkNVY0?=
 =?utf-8?B?MGc0ZHY0SmVYZ25aU3ZvT0dzQXI5RmlocEFlL3V5SEVIMUJYa0ljc3ZCMmN0?=
 =?utf-8?B?cFFpWGlFZHhyYmg5Q2wwaEV6L3ZsamFYSE1YOEdlT2hELzVSVTZmY2d4TS80?=
 =?utf-8?B?R0Y4QTJCU3pMeFo2NHJMQURZVVBUeUdibDVJaUNRQnJhZW4xTGJVUC9ZMjJB?=
 =?utf-8?B?ei9NeXc0Zm1HY1VnVDIyb3ZkUllDZTZGTzZ3YTZFK25jbloydTJFdnZ0c2pG?=
 =?utf-8?B?QjN6V1I3OUR0TU8rRTlxUVB2MVJPc2xxcjg3dTNodUc1dFhWeHY1SGdkd1R3?=
 =?utf-8?B?bkdIUWs5cHlCQko2dWc0cjhjcnYyaHJxcHlKZVFMSmlQTGpRakVhcGdBRTVQ?=
 =?utf-8?B?cVZwY0tnZ0tzTGkzSXNBNVNMT1IzcFc1RUdmb0dqdE1US3dMTkJNR09JZ1dN?=
 =?utf-8?B?Vmp5NlpLUk1kNlVYcVJBMm9hZTFwWTRoWTdMREVpMndKU1BYUG90RlBad1dJ?=
 =?utf-8?B?NTNQdXMxYVpqenY2Z2NaUCtXU2JyZFo5MVBlODBlS04vditZV1hMUVN4K3JV?=
 =?utf-8?B?ODNqamREbEtJZU1UNWxZbkZ4MytkaU8wZTVLRjZxMUNoTnA5YkhHRFBHbCs1?=
 =?utf-8?B?VHduR1h5Wkp0emcrUG5STEcrRXU5NXY0STRuOEtiaVBFT1QxRE1XV1o3bFdK?=
 =?utf-8?B?a0V0ai9DZkxJU1o1ZDA2VnIya2liUitKMUxqbWNHWkgwVFhndzQ5dzZ6Tkhp?=
 =?utf-8?B?cldyWHEyRmtEVkxFOGt4WkQ5eE45ZllWZC80QzNmc2UxZ1draXdqc2l5TWRh?=
 =?utf-8?B?SVVNVmh4SDN6WDhmbnAvTzRXbnhNQllNeGdSYkZSUjhWL0xRWlVyKzJYSUd5?=
 =?utf-8?B?dDdoS05BK1hvY2w3cUY2NGZaUS9OeCtxVEkvcERMSDVXa2JCdGZlMGw1QWtn?=
 =?utf-8?Q?JLgmkqEAi9dWqpxVnE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB7026.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDR1bVpudklhQW52WTNMSURGM0dOVHJJVkRFVzA2L2VyRUlZNXYwYkpPdk9O?=
 =?utf-8?B?ZW52dmJUTXhwNlB6NHVXVE5qalhjeGplZGN4cjFOUnVXdW01TEpaWUc5aVJr?=
 =?utf-8?B?elZCTndtUVphbWhKZUhaYUpvRERSbk9sbFpCclVlM3dOWlhxdS82UWc0bTUv?=
 =?utf-8?B?MFArYndpRWtrVmtkaGZqZ2xmRDBLdG5VbnVzL3NFTkFFWVlGVW5JYno0eHZm?=
 =?utf-8?B?cTlsNGxBdHNoQ0paeVFBc0k5My9xNWVuZ01NUVo3bVFoRGNpY29GbS82NGVG?=
 =?utf-8?B?WWZrOHdqMTdZV21kZStWOVQ3QnZ0RjBCWDFidUF5aXMydW52UWhWTWhXS2RB?=
 =?utf-8?B?VVo0QmJoMjZzSC9lYzBEVnRlelNnMlBIVUkxTXl6cEdKaEwxZEIvWjVHUE1G?=
 =?utf-8?B?R21HL2lUNlgzbFFZcytQSWdSam9PYTNBU0k4TjhzUHBZb21xZWNLUEdRTmdT?=
 =?utf-8?B?eTVoQ1M3dkVweG03cm14bHJHZVY3d3J2Znh0WEdONGZlamNtME80ekM5N21h?=
 =?utf-8?B?Q2dlUWVrckhRZ0YrWkxCeWx3QjhKRzVLNVRRNXNqaFdCdzZ4c3BOWDRBZGQw?=
 =?utf-8?B?a2VHQys5QWdvQ0FKcWQ4dkswWGxHRk1udWFLM1NGVjlaWFZwYUhkdUVVZjZY?=
 =?utf-8?B?RFg3WDk1VjZMZThzcDZrZmlKYnkwSVFiVWJKak5EL0Y5Y0dzeE5QQVk1ck5m?=
 =?utf-8?B?eUNkSXhSNFVJSXFtM3poY080QnRKZGlqYmg2RENadmdwaFUydElYQ2dFc1lG?=
 =?utf-8?B?V1FuQUFsTWtOV3piT3pQNTBtbDdialVlelBha05XZWEzcjdDSUJianpna2Qr?=
 =?utf-8?B?TDdaeXc4T0VzR2U4UVhBZEJsWk9iaEJPQzF4eDZCNGhMUXNuWlFxOGM2cjFv?=
 =?utf-8?B?Vmo2Y1FLRlJ5bTFLdmkwdlJ4dm4zZG9YaHRqMXZ2WldaODNsTzFoTnNEM2Ew?=
 =?utf-8?B?VTB5R2t0S1k5Q0hnOTczUmIyQ29HTjhoNThUSTlRWHZwTytRbUlzYjE2NnRH?=
 =?utf-8?B?QVR0bDB5KzFWbExkOS9WK1hqeXRwK2lLb3k1eHRHU0JFNGNSelN4VHVSQjR1?=
 =?utf-8?B?cGg5cE4vYmJwVmVPRkRtRXNlcnNGMHJvOUl5ZFJBSW04OU1SWHV3K1FydmtR?=
 =?utf-8?B?bmtGbFN4cnBMT3JZUUIwUUJBbm0wZkUrK0NzbXZiaTFtck1USVY2YnZhTERw?=
 =?utf-8?B?UmFjVm05bzAvczBCekNYWERMdjFyYUNMeWJvYk5kWWhvb0crMGFSdlFFQXAx?=
 =?utf-8?B?WW1xSExualpwcVNESG1wZkwrOEx1enFJT0NWQU1JVmpYUjFUNHFBbUh0eGYx?=
 =?utf-8?B?cXN4K0VEVWJJV1FyM2lKRU5yVCs2SDNmemYwWnFxRlRGeHM0YXBMbHBhdmhN?=
 =?utf-8?B?aTZGcTBFcHRhdGMzamZCa2o2VHhaSml5YUs4NjdKellWQ2hUMTNrbVZOdGFp?=
 =?utf-8?B?NmFTTkFCSHhjUkZaSmFCOFZmanFldnBMekdaYTdkbHp3ZFdNcy9HYWU4MFlT?=
 =?utf-8?B?T2RQcGdpd0hKZWJNTndsMVo0OWd6SEhmQXU0ZFZjZkVnclZuUjF2MTJlb3N4?=
 =?utf-8?B?R2VQYmFtdkNpVDBFa25vS1Y2Z3BRMlFsNHo3OFFMS2Z2VjRheVJUaTBXOGJ0?=
 =?utf-8?B?aEdyYzZyZS91STZyVUMwbVQyNXRWekF5KzB4TTFVWENoalUyN3hxK2VPdFNr?=
 =?utf-8?B?VW92RURxbEhRU3FhVWdXWk9mNmJRM1RQaStmQ3IxWWJLU1I0NkJlU3M1OUd1?=
 =?utf-8?B?YmdQVGZoZUgvdDd2SDd0MGQ3alpUNi9HMnBDNHpZZHVwU3BkSEtCSUZsaEx2?=
 =?utf-8?B?S2dZQlBrL2xCa2VsWERkdEJkVTdDRUFPdHVXZ0tGemU4bm1TRUpub3pSSlV6?=
 =?utf-8?B?THJyei9JLzVjOVJ1SWZHdmhwU3RVeEQrVTU2UkgxY0o0L3dWS3pvQ1RSaFc4?=
 =?utf-8?B?MkdiWTB2bnBzRTB6VzFCd2xxZ0hSRmlRdklvY1VIRk5FQnNvQzR3US8zMWRi?=
 =?utf-8?B?NHZHc3Y5Rk84bVp1RUNvbktrMFJnQzZLc2twdzVRbmF2Q0NVdVBERmlMeE1F?=
 =?utf-8?B?d1R2MG13UVlYaXJ5QTVXd1Zudmx4WUdKWWdMaUdyb2dCUmR4NVdUd3k0b1p2?=
 =?utf-8?Q?h8ArNcWgx2SBAcBZcIxaM2Usz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b5ec69-3c1b-4a48-0cc2-08dcc58c75e2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7026.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 05:03:44.4662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCJkHCAsS/bUGmtz2aL8aXi6kVWuVjF0gZnHgicjEZqpn6l/kqMFCk1sqyl00k4cwlvyg6WFhonM6uMUn32m3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8261
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8; envelope-from=junjie.mao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Manos,

On 8/23/2024 4:11 PM, Manos Pitsidianakis wrote:
> Add rust/qemu-api, which exposes rust-bindgen generated FFI bindings and
> provides some declaration macros for symbols visible to the rest of
> QEMU.
> 
> Co-authored-by: Junjie Mao <junjie.mao@intel.com>
> Co-authored-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Junjie Mao <junjie.mao@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   MAINTAINERS                       |   6 ++
>   rust/meson.build                  |   1 +
>   rust/qemu-api/.gitignore          |   2 +
>   rust/qemu-api/Cargo.lock          |   7 +++
>   rust/qemu-api/Cargo.toml          |  26 ++++++++
>   rust/qemu-api/README.md           |  17 +++++
>   rust/qemu-api/build.rs            |  14 +++++
>   rust/qemu-api/meson.build         |  20 ++++++
>   rust/qemu-api/rustfmt.toml        |   1 +
>   rust/qemu-api/src/definitions.rs  | 109 ++++++++++++++++++++++++++++++++
>   rust/qemu-api/src/device_class.rs | 128 ++++++++++++++++++++++++++++++++++++++
>   rust/qemu-api/src/lib.rs          | 102 ++++++++++++++++++++++++++++++
>   rust/qemu-api/src/tests.rs        |  49 +++++++++++++++
>   rust/rustfmt.toml                 |   7 +++
>   14 files changed, 489 insertions(+)
> 
[snip]
> diff --git a/rust/qemu-api/README.md b/rust/qemu-api/README.md
> new file mode 100644
> index 0000000000..7588fa29ef
> --- /dev/null
> +++ b/rust/qemu-api/README.md
> @@ -0,0 +1,17 @@
> +# QEMU bindings and API wrappers
> +
> +This library exports helper Rust types, Rust macros and C FFI bindings for internal QEMU APIs.
> +
> +The C bindings can be generated with `bindgen`, using this build target:
> +
> +```console
> +$ ninja bindings.rs
> +```
> +

I suggest mentioning here that cargo test requires --no-default-features.

> +## Generate Rust documentation
> +
> +To generate docs for this crate, including private items:
> +
> +```sh
> +cargo doc --no-deps --document-private-items
> +```
[snip]
> diff --git a/rust/qemu-api/rustfmt.toml b/rust/qemu-api/rustfmt.toml
> new file mode 120000
> index 0000000000..39f97b043b
> --- /dev/null
> +++ b/rust/qemu-api/rustfmt.toml
> @@ -0,0 +1 @@
> +../rustfmt.toml
> \ No newline at end of file

This symbolic link is unnecessary. rustfmt will recursively search the parent 
directories for rustfmt.toml [1].

[1] https://github.com/rust-lang/rustfmt?tab=readme-ov-file#configuring-rustfmt

> diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
> new file mode 100644
> index 0000000000..4abd0253bd
> --- /dev/null
> +++ b/rust/qemu-api/src/definitions.rs
> @@ -0,0 +1,109 @@
> +// Copyright 2024, Linaro Limited
> +// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +//! Definitions required by QEMU when registering a device.
> +
> +/// Trait a type must implement to be registered with QEMU.
> +pub trait ObjectImpl {
> +    type Class;
> +    const TYPE_INFO: crate::bindings::TypeInfo;
> +    const TYPE_NAME: &'static ::core::ffi::CStr;
> +    const PARENT_TYPE_NAME: Option<&'static ::core::ffi::CStr>;
> +    const INSTANCE_INIT: ::core::option::Option<
> +        unsafe extern "C" fn(obj: *mut crate::bindings::Object),
> +    >;
> +    const INSTANCE_POST_INIT: ::core::option::Option<
> +        unsafe extern "C" fn(obj: *mut crate::bindings::Object),
> +    >;
> +    const INSTANCE_FINALIZE: ::core::option::Option<
> +        unsafe extern "C" fn(obj: *mut crate::bindings::Object),
> +    >;
> +    const ABSTRACT: bool;
> +}
> +
> +pub trait Class {
> +    const CLASS_INIT: ::core::option::Option<
> +        unsafe extern "C" fn(
> +            klass: *mut crate::bindings::ObjectClass,
> +            data: *mut core::ffi::c_void,
> +        ),
> +    >;
> +    const CLASS_BASE_INIT: ::core::option::Option<
> +        unsafe extern "C" fn(
> +            klass: *mut crate::bindings::ObjectClass,
> +            data: *mut core::ffi::c_void,
> +        ),
> +    >;
> +}
> +
> +#[macro_export]
> +macro_rules! module_init {
> +    ($func:expr, $type:expr) => {
> +        #[used]
> +        #[cfg_attr(target_os = "linux", link_section = ".ctors")]
> +        #[cfg_attr(target_os = "macos", link_section = "__DATA,__mod_init_func")]
> +        #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
> +        pub static LOAD_MODULE: extern "C" fn() = {
> +            assert!($type < $crate::bindings::module_init_type_MODULE_INIT_MAX);
> +
> +            extern "C" fn __load() {
> +                unsafe {
> +                    $crate::bindings::register_module_init(Some($func), $type);
> +                }
> +            }
> +
> +            __load
> +        };
> +    };
> +    (qom: $func:ident => $body:block) => {

This arm looks duplicating what #[derive(Object)] is for, while both have their 
strengths and limitations: module_init!() provides more flexibility on the 
registration function body, and #[derive(Object)] is much more convenient to use.

Complex registration functions are not rare, and thus the Rust APIs should 
ideally have both strengths: clean type declaration in most cases, and full 
flexibility when needed. In the current codebase, we have ~1080 uses of 
type_init(), with 750 of them having a registration function as simple as a 
single call to type_register_static() (disclaimer: those numbers are collected 
via brute-force searches and may not be accurate). More complex cases include:

1. Registering multiple types (e.g., multiple models of same device) that share 
the same data structure, e.g., hw/misc/aspeed_xdma.c and hw/xtensa/xtfpga.c. 
There are ~200 uses of this kind in the codebase.

2. Use domain-specific registration function, e.g., ui/egl-headless.c, 
audio/ossaudio.c and hw/virtio/virtio-net-pci.c.

3. Other device-specific operations, e.g., hw/net/spapr_llan.c.

My rough idea is to define a proc macro around an impl block to collect 
constants (type names, parent names, etc.) as tokens and callbacks (class init, 
instance init, etc.) as functions, from which we generate TypeInfo and 
(optionally) type registration code. As an example:

   pub struct PL011State {
     ...
   }

   #[qemu_type(name = "pl011", parent = TYPE_SYS_BUS_DEVICE, (abstract)*)]
   impl PL011State {
     #[class_init]
     pub fn class_init(klass: *mut ObjectClass, data: *mut core::ffi::c_void) {
       ...
     }

     #[instance_init]
     pub fn init(obj: *mut Object) { ... }

     ...
   }

The proc macro then generates a TypeInfo instance named TYPE_INFO_pl011, with 
optional callbacks being None when not given. A registration function will also 
be generated unless qemu_type! has a no_register token. Devices can still use 
module_init! to define their own registration function.

The class_init callback is specified together with instance_init because it is 
common for multi-model devices to provide a different class_init even they share 
the same class structure. Refer to hw/misc/aspeed_xdma.c for an example.

What do you think? It is still preliminary and the example can have grammatical 
issues, but I can try drafting if you think that is a good direction.

---
Best Regards
Junjie Mao

> +        // NOTE: To have custom identifiers for the ctor func we need to either supply
> +        // them directly as a macro argument or create them with a proc macro.
> +        #[used]
> +        #[cfg_attr(target_os = "linux", link_section = ".ctors")]
> +        #[cfg_attr(target_os = "macos", link_section = "__DATA,__mod_init_func")]
> +        #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
> +        pub static LOAD_MODULE: extern "C" fn() = {
> +            extern "C" fn __load() {
> +                #[no_mangle]
> +                unsafe extern "C" fn $func() {
> +                    $body
> +                }
> +
> +                unsafe {
> +                    $crate::bindings::register_module_init(
> +                        Some($func),
> +                        $crate::bindings::module_init_type_MODULE_INIT_QOM,
> +                    );
> +                }
> +            }
> +
> +            __load
> +        };
> +    };
> +}
> +
> +#[macro_export]
> +macro_rules! type_info {
> +    ($t:ty) => {
> +        $crate::bindings::TypeInfo {
> +            name: <$t as $crate::definitions::ObjectImpl>::TYPE_NAME.as_ptr(),
> +            parent: if let Some(pname) = <$t as $crate::definitions::ObjectImpl>::PARENT_TYPE_NAME {
> +                pname.as_ptr()
> +            } else {
> +                ::core::ptr::null_mut()
> +            },
> +            instance_size: ::core::mem::size_of::<$t>(),
> +            instance_align: ::core::mem::align_of::<$t>(),
> +            instance_init: <$t as $crate::definitions::ObjectImpl>::INSTANCE_INIT,
> +            instance_post_init: <$t as $crate::definitions::ObjectImpl>::INSTANCE_POST_INIT,
> +            instance_finalize: <$t as $crate::definitions::ObjectImpl>::INSTANCE_FINALIZE,
> +            abstract_: <$t as $crate::definitions::ObjectImpl>::ABSTRACT,
> +            class_size:  ::core::mem::size_of::<<$t as $crate::definitions::ObjectImpl>::Class>(),
> +            class_init: <<$t as $crate::definitions::ObjectImpl>::Class as $crate::definitions::Class>::CLASS_INIT,
> +            class_base_init: <<$t as $crate::definitions::ObjectImpl>::Class as $crate::definitions::Class>::CLASS_BASE_INIT,
> +            class_data: ::core::ptr::null_mut(),
> +            interfaces: ::core::ptr::null_mut(),
> +        };
> +    }
> +}

