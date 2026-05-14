Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE21CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 11:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNUBi-0001Z3-Cq; Thu, 14 May 2026 07:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wNUBf-0001Xz-OT
 for qemu-devel@nongnu.org; Thu, 14 May 2026 07:25:07 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wNUBd-0002pL-2H
 for qemu-devel@nongnu.org; Thu, 14 May 2026 07:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778757905; x=1810293905;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xgogbYiSW6s8RYDYwWWmlwZ/YxH54737/PuY0ypSwVM=;
 b=fOEXjfiQtbr6wBUSqA+OSdc0QWWScarsJz2cqJT2uWPHesPNd2sJ50GS
 u/eAO7tuSuqx81HCXaZSCjNLvq8lYYU0lGLCYs4ZKR1plyZ1s8/6+4+yT
 ZR//n/wL8SYZKLY16ucU7vqc68RzY2KqVk/8UJwjp6vuttaZUrtHbuyrL
 zBneFw6EKnrE9WpioZJ4/CIhm++EpgyogbLR4il+WMVoeaTzkynlUw8hZ
 2cy4uTDrHn65VKJJ19N2b2oy/qhI53HH7x4Y2btknRa+ls9arQKrV1b2p
 LEDUTZk7XTHPZQ1ds3su2pNkxoKZMxx/cQ9fjJv0J1gTfDLrI31Q4Hqhy g==;
X-CSE-ConnectionGUID: BdmRZJ6TSWGqWeQXmaoeyQ==
X-CSE-MsgGUID: IArmc23OR3aYPyKcXSUVQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="90801342"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="90801342"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 04:25:03 -0700
X-CSE-ConnectionGUID: b6uCVhaoT5uE0CzXnH9S5w==
X-CSE-MsgGUID: BEv10jWzSP69qsn+Fj46MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="238478366"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 04:25:03 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 04:25:02 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 14 May 2026 04:25:02 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.3) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 04:25:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vo+sjbTaa/9CPyZ2fX9X5oX+jZy3AsIG2QU4yOhTIygw17j1IOcKhlTFdrBDeld83lH0TRg0bktNZsDqSoy9a1cb8ZPd33k8+Au6yJF1EcYivNXCtH0uBJjsNLMaOwPBAundIfugOX1M8QvR/Rlo4mWDiBpRSaI5OUZtHYEjCUL5DZxQ2AWXjx8MEfuVIQ8L7WXjjNUgxY3faxfYJbmJ68QqvFWnhLGKwwjJX1TWkCEjFmLFXg5N9OJnThPjv7/zN0jbfO93Jck32iteoUXOaK67oDL04EJGOlt7GQnWLNR+7EvG7J6jt4x9MbUVl7a5I4hqxy1Et3B9vXQqXHR2bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nq1xPVGqyvwfCghkCfAYPGG04I45dBDhZ1TDkFPtYr8=;
 b=gfsu0pPDXnQqqZGLj9IyXwQ2oZ1wW0RUBSpMMn5ClZZ6qodYdJ7MBwwu6SmcSiZMK3wUTutOjjF0YB8Es0luL9hV6AxaqC6SWlHSl9KhQWZzV//8OUGugMUQmYKSG7EP+iiQOiCjFxkp3xH/Xxy+U2lojNrzuI0A2okNLlAj/hSAAdC9UPDV9jT7ESrU7hjwfM5bfrEpQVQLMU4yVlUVvlmXnIeJSm+nrvbpxzOrnCxO4iRfPKbqg0+Mbr/I3IDa+sCbqh60YHqgKRLTmTWAwvtZRR+D6cfCJLFpMreUJ7ARfl30DaKnkKC+pbMwvLq54+jpsaGBTDP+AVxzQl7lJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by CY8PR11MB7948.namprd11.prod.outlook.com (2603:10b6:930:7f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 11:24:54 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 11:24:53 +0000
Message-ID: <7a2d4ad0-9dd5-4785-972f-67b1209978c0@intel.com>
Date: Thu, 14 May 2026 19:33:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] intel_iommu: fix guest-triggerable assert in MMIO
 handlers
To: Junjie Cao <junjie.cao@intel.com>, <qemu-devel@nongnu.org>
CC: <zhenzhong.duan@intel.com>, <philmd@linaro.org>, <mst@redhat.com>,
 <jasowang@redhat.com>, <clement.mathieu--drif@bull.com>,
 <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <farosas@suse.de>, <lvivier@redhat.com>
References: <20260514180703.85686-1-junjie.cao@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260514180703.85686-1-junjie.cao@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::22) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|CY8PR11MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: f8a1f456-4a94-485b-e786-08deb1ab6b8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|42112799006|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: bMDseL/NBIpb/y1cr8TpUR07j8YJ7R2aOV632Hj1TdOKnA8ELeHbH9tHFy0yaBaXaI+Kei2bDwOAWQpOITyVNHTh5AHQgNeurdLIOPElCzpcg0/oGnL2ErfZ+D0z5pTc/o+sTRtXAEaLUNWoPyRTUR65OhcWkHiVIaeuG9LIKB9WsaVn4lCUkG44h518/RcPWUBm17teU5J/vIbffhMvr/knIH6cepfDyJnutz34zGYqEgdWKWkFsGLdZgrf+cjg9G+8Z+6kYXs5qu30x8aYzBQPozYXZ68f12aS/10f2pKqMC6EmQzVi/o6x91X9XRfhqd1qW+RVHTaxy10kLhewA0o8KbBgaTN/gqS78ioxLCxnFHozdgsDn5iXf6CEIkxAl9hwbemIJ9WwjEoPEyLW/LUrwZ0SNwLct3RKskmUnWLOJ475/xqgeFNh6/kJs4R6UYB95OPUAdbfKtmdYQawCxD20m5ibUEwMCORUDQ9P4wm9OOOk0SH4Z4RBphfjl3PiS0uQcsXno4UaUD3/Xz/50WjY5dNhltrDB+KiUVksuZg1AieiGyO9eYeQrjLOyzCTY7WPN9RKIG8MyR86QcbwKm/Q0l02Evih5ZEzQQTECJVbD4A02C7ffNl4bJNhdwqVf1VlvqwquSmCzc5/o8Sy2kkWnzlWYC4d6SIhaTz6EVxfKGTQBhoCMNLoVLvaWn7aLnn2s/k1m0RWBE4E6PKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(42112799006)(11063799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVU2b0pER0dhdld1Nnk5SXBMZGhCRVRMSWxEZHU4MmRkcUpjcnM3azVEYjNr?=
 =?utf-8?B?S2NxQ2ZlWHdhbW5kY25Ta0I1UDVNa1dmYndNTXZLYXNpMnREOXFiQStjdDRN?=
 =?utf-8?B?TUw5Zys0SkwxdW1RdlQ0dU1NbXJRd3hjSmVLRzRkMGJkVkxBUitSb0hpdVhE?=
 =?utf-8?B?YTIvZzN2aDE0WmIydUltQlBxYWllMWJxcTZsMSt6UmMzZkhNNkpIUFRHOVJD?=
 =?utf-8?B?L0NvL0dIclVjTjl2NjJweWw5Mkw4WFdMbUxtL2VrSit6ME5ZeWNCRjFWbGhP?=
 =?utf-8?B?Yit6N1IrVy9LUnNvWW9YaFRKMk9DejQrajkzODltKzNnZ0ZCYi9MRHlxaTRY?=
 =?utf-8?B?UEI3L1JGWnJXQVpDSjFEODNzVEh2OFZVelNIQ1BEQ1VqelpUa0ZYN3JqMUVC?=
 =?utf-8?B?UlZxcC92RUVvTjZDNnJsbUhIS1lHUXZmS3krSldpWEF6Z1FxMlo5NFlWNXdx?=
 =?utf-8?B?SGNXN1dzczJkb0xHblZlREwzdHRvT1pjRFR5aWkxUXpEMWZTS0RFR0EzWHVr?=
 =?utf-8?B?UjE4OHQxMjQvODArZEtFWXhsT1Q2WXpjbC9ZdUgybXV3NXNvbnZCTi9HLzZS?=
 =?utf-8?B?bWpSNWQxR3ViYis0bjZJMmdETnAxbk9GTTRpR0JUT3pEaGhneWJDRTVuOXdE?=
 =?utf-8?B?NWYwZHVsdFJlUkhsN1ZjVzJNTUlSUzZ4WFpNQXRSTWx2Nk5FZnhsNXEwL0VB?=
 =?utf-8?B?eGd2dHB6Z0I0RHd2WERXdVNZMCs2U1QzdUxRMGtRc1MyYVVrMTZhdng0RzBQ?=
 =?utf-8?B?cS9JVjRESlhXeWp6TDMyNUVqSUpTOTJGNkF4WldQMnp6MnJoRFgwUG0vN3NU?=
 =?utf-8?B?L1FSeFlKYkY1bzhvTWNKZDBxZE0xRTR4QXpVZXRQTGhONWdma2h2UUdYOExC?=
 =?utf-8?B?TlVhcjQyQy9lNkRQK2N3WUdFRXQ0Z0pUcTJEa2krZWdtWWRwK2FrUmQ1dmd0?=
 =?utf-8?B?L0M3TEZOM1BZdm5rWUdLRG1sTVNKV0hhZ0FPWXpyV0NKMndRNmlCRjdrZmpB?=
 =?utf-8?B?eEJTZCs1eVIrV3NkTm9kSG16QnRFU01Nczdqd1RiSnRja3gvOVpmUDFubjgz?=
 =?utf-8?B?NTRoTDlMRjRaTFVGejlyQXNFM3RYRzdjYVRjR29lSGZLV3JwN2tRTk9OMFB1?=
 =?utf-8?B?YUxCdVRIT01NNmVRV3BIcjBYdXVSTk1HMTFzdG9JdEF3TEtVV2trdDQxRmhl?=
 =?utf-8?B?WXVPQ0FNaEQyMjJBcmFiQ3lOdU1QaVRCZUVKNk9pZStYNnpxS09IRGVlTUFv?=
 =?utf-8?B?akphZ042N2U1S05pSDkvb3JZRFNqOUhST1UrQmFERldyaDNhQjFqZXpkbWF4?=
 =?utf-8?B?M2FiK1BDaE5hN09hcW1IU2QweHhZSGl2OStkREd3enI0MGhiL0dZOW52ZDh3?=
 =?utf-8?B?aGJlblpvUERzSjRVdWM0dFo3Wmp1NEJST2x3TGJTTGpHeXhRMnYrME1HejA1?=
 =?utf-8?B?QmFBVVhib21aT2Z1NlJTVkNMaXQydnk3NHZXREVLYUIyWmNBM0xGN0U3MkZG?=
 =?utf-8?B?Y05vdmlzTytwVnVrc0NBWW8zaEl3QnpPNFdjOXZHREgydmFud1JOcFUvNVU5?=
 =?utf-8?B?WDhuUkp4Z3BwVzQvbVNIQitLS3QwWHl1akVMeTJpSjdSSU5WSzlJWlFDaVhL?=
 =?utf-8?B?aWF6aDFFVElsMElWYVJheURLdzdUamw3TDZyWS9yV09HaCtXYkk0d3h0ZWxv?=
 =?utf-8?B?Uk1UM2g0cTFFb20vK0VqM2NKMkZra3JWSWNyZzd5VVpKUlo0NjE0elJEUUdp?=
 =?utf-8?B?QzZhVm9TZ0s3RzFmTEVLSU53OHg3U0ZQdnhYa0tZeU8zcTZMb2t0ZCtmSjJt?=
 =?utf-8?B?MldpN2xiM05hNTdLcWdvNHV0bXJIQkEyc0Nvdy8zblpZYzN5cDZSZmROM2FC?=
 =?utf-8?B?ajR5OGRVSWYwbWRCQ3FJOERyRXhpRzBnMHRsc3B1Qm1sZFgyUkJ3UU0xd1B3?=
 =?utf-8?B?SmI4R3E3Tm9rbkZ5dW5VVnFDSXFUd0JjWUpRQWpEVUdaZ3EwMTVlQVMvWlMr?=
 =?utf-8?B?RkRYaGtPaEhIOGw3bHcrQmJ0QTA1eUFtcGs1cFF2L0FzMG5udlRoYTJoNCtn?=
 =?utf-8?B?clg5N05LNjVIVXREdmxsMHpscnlDcmNsS0NtQzRZdDgvRERiWi93QXhwS21s?=
 =?utf-8?B?MDMzZHRHUjZMaXBvVHhHYUt5S2k0RzdOSTcxQi9PM2JOUmZhUHVaakpZWlV3?=
 =?utf-8?B?aUJtMW02enpNdnd3SjdPd25HTGR4Si83UEpqakdFY3ZYQjdDQ3dieWRFeG45?=
 =?utf-8?B?OTN5ZEx6OWd1ZFQvcjFyeFdGTkpEOFZRT3doeE5xVkNjS3o1NnlCUG80RjBU?=
 =?utf-8?B?eHVVQStrTUhBUGVHa2M4d3g1dXRlR1ptVXZXWGkzd2NsZURsMWVndz09?=
X-Exchange-RoutingPolicyChecked: YGjOUdbuj7kEIJ4Ja5vE+NtrZLLPQ+R5zASLrnMstN8qg7/t3yxfj6MSCRY4G2h0q8wKDIavxKUsUYFeJR7DljyLkDkYUBnvEDL45snyQIvHqfexbZZbbL4pAJ4hXoS6Wu9AtmwTEoj1ba13xUmLuSBbp4VCVmuxSqSG3ec+jlubMUloD1fvGBSZYLN5PxXh3TTdKmpF4ufWHxHO4IV7upWfg+M7sJkG5YpI++h5psGyRnk3OEK7m43Ypd8Y/XIX8CyvuMg4iCbyPaN3bHOF+9QJL7lz6l17Xcc28viuIp2sZuwBEesBeHQmLMDZBIEB5sqEud02kGHeRa6pghbgeQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a1f456-4a94-485b-e786-08deb1ab6b8b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 11:24:53.8884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVbGNPYCbOk0Pe/IoYDDcqiEB5kXi2vkk79yIUHZ+ZAWIAFd7xQdznbyGqaQxzCIAyH3fhTX62VkEawNmjVQKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7948
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13; envelope-from=yi.l.liu@intel.com;
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

On 5/15/26 02:07, Junjie Cao wrote:
> An 8-byte guest access to a 32-bit-only VT-d register hits
> assert(size == 4) and aborts QEMU.  Found by generic-fuzz.
> 
> v1: https://lore.kernel.org/all/20260420170523.17908-1-junjie.cao@intel.com/
> v2: https://lore.kernel.org/all/20260424201842.176953-1-junjie.cao@intel.com/
> v3: https://lore.kernel.org/all/20260506031942.251335-1-junjie.cao@intel.com/
> 
> Changes in v4:
>    - Switch the guest-error log from error_report_once() to
>      qemu_log_mask(LOG_GUEST_ERROR, ...) so it is surfaced only
>      under -d guest_errors (Zhenzhong).
>    - Add a block comment at each of the 4 reachable sites
>      (FECTL 0x38, IECTL 0xa0, IEADDR 0xa8, PECTL 0xe0)
>      explaining why the check must stay, so future readers do
>      not delete it as "harmless" (Yi).
>    - No functional change beyond the logging-API swap.
> 
> Changes in v3:
>    - Drop v2's min_access_size=8 approach: per Zhenzhong, it
>      silently zero-extends 4-byte guest writes, wiping upper
>      wmask bits of 64-bit registers and firing triggers gated
>      on size==8.
>    - Keep min_access_size=4.  Remove the 25 assert(size == 4)
>      sites: 21 are unreachable (non-8-aligned), the 4 reachable
>      (FECTL 0x38, IECTL 0xa0, IEADDR 0xa8, PECTL 0xe0) fall
>      through to vtd_set_long() and log a guest error.
> 
> Junjie Cao (2):
>    intel_iommu: fix guest-triggerable abort on oversized MMIO access
>    tests/qtest: add 8-byte MMIO access sweep for intel-iommu
> 
>   hw/i386/intel_iommu.c          | 74 ++++++++++++++++++++++------------
>   tests/qtest/intel-iommu-test.c | 30 ++++++++++++++
>   2 files changed, 79 insertions(+), 25 deletions(-)
> 
> 
> base-commit: 5e61afe211e82a9af15a8794a0bd29bb574e953b

LGTM. Thanks.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

