Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046E1CD4F4E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 03:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm2ol-00077L-6O; Wed, 04 Sep 2024 23:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1sm2oi-000762-7v
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 23:05:53 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1sm2of-0001Ma-9C
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 23:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1725505549; x=1757041549;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5MCRbZr4M73Gebv6PYjtOJTBzCNdxhEPku6RU9fWIV4=;
 b=KBAGDkHrxeF6wr8XMisXizPxv2QjI6hisEh4eqwF+/TiQfDIoeDKG4Eu
 is8u8C6rMDDZikgjv8DLHwZ5dHGcIBR+xE/syWX6yooaczmBiRbMZD7b5
 CoeFZdzJaCQWB6sNDHPDOBczzJh9ykNuM8qHuN7Itxqr2xzlAuNxwuvWM
 aMKXPPJI6c+noAhff0ZjOu+YaI94AazfMFYhbTwF/7uZPmg/bbSJNQqCM
 oTjlv4G5HKKqz//xu2vdCiCGRUgc/9o4wY9lgTZa1ztXXNaB0hqCjYmZB
 1Xl8fq66mhaOyVmgR3z3lDmujCZm2db6EynLpsfFVXKKCSVj0Wv6YkIJG w==;
X-CSE-ConnectionGUID: yM2wTK8RTVGIpIdxJcmyTw==
X-CSE-MsgGUID: sqm700xpTjWKnxz8T1YQMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="46725088"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; d="scan'208";a="46725088"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2024 20:05:42 -0700
X-CSE-ConnectionGUID: KlaWBoKyQbGgtY7FBcKYbw==
X-CSE-MsgGUID: pYSjUU8LQV2zqNG5RVn0iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; d="scan'208";a="65714545"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Sep 2024 20:05:42 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 20:05:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Sep 2024 20:05:41 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 20:05:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XD7X9x4LHhHH0jW3OUiAcKEjuvqqFMInpv8wSKZ8/kJ+1HyMKW901+mx73iYu6rHT0Gp/FNjLtYEzu6e8Lloe2dWqLv7NflVSsFomhxD8s41cI66DAuonp7iUXau9vz7r8D0TDQI+os+wOzz7lq0aG2miXeFMYUf+++u5+M0Ru9SLbX78Kb7jUdZdsSHtZbGB+lQDcfTZzqE0cGxZmGv761R9EwY6kaudFmLbAXRQqwVd9vHwevJSfzW589yqr4HG3QLqwZnmhQAmhEQtkZd2fy9WL8ZHJSzpm44ggdEnnTRnW+B8y13T3bj6hGGtACwZpRuUJd+tRDzPaZTOzjAgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBi6lBVJX8UG9ejLLz7PKul9IZ4hqXlfLChJaI7IWbo=;
 b=sbL+phaR9oHxxZlmcENby0Lf1/4zPIB8cAVyB7TVCWGo+/6KEvees+KU71mcvsNA0mNK0Ul8+H4XBF47HUYbSY2FJ1tbbUkQnZngutC5BuzV+KpzFzYGhkTSDgzeonGpum6lmQoxd1grBpun0r8jcAVMXo2V76urqyXL5fr1nCGi+xh+R7XIWbbV3ZlLhvLjPw8g5loktHxYAa67sYnbmNcAPsgEnnjJJRR3rpV+518Pt7cSuOdeVA2ncsjaj6Y9io8FOCimsGtLWva33M5cxMpepiwFE/cWsLncWt4EY176dj3zXnRdiGIQSH5GJs957ZslKIHKEbcfPosHrUdOsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7009.namprd11.prod.outlook.com (2603:10b6:930:57::12)
 by LV3PR11MB8484.namprd11.prod.outlook.com (2603:10b6:408:1b4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 03:05:39 +0000
Received: from CY8PR11MB7009.namprd11.prod.outlook.com
 ([fe80::7ebc:871a:bc7f:1eed]) by CY8PR11MB7009.namprd11.prod.outlook.com
 ([fe80::7ebc:871a:bc7f:1eed%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 03:05:39 +0000
Message-ID: <e047e64b-1d16-4f86-8cdf-da9b0d6e6a72@intel.com>
Date: Thu, 5 Sep 2024 11:05:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v9 7/9] rust: add crate to expose bindings and
 interfaces
To: Paolo Bonzini <pbonzini@redhat.com>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>
CC: <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
References: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
 <20240828-rust-pl011-v9-7-35579191f17c@linaro.org>
 <CABgObfbe1tFWb1yogUskbUszFyHjy_qhk0k6B9YrgBeVNTnDww@mail.gmail.com>
Content-Language: en-US
From: Junjie Mao <junjie.mao@intel.com>
In-Reply-To: <CABgObfbe1tFWb1yogUskbUszFyHjy_qhk0k6B9YrgBeVNTnDww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0156.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::36) To CY8PR11MB7009.namprd11.prod.outlook.com
 (2603:10b6:930:57::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7009:EE_|LV3PR11MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: be05b767-3309-4099-7fe5-08dccd579ed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bURKTEFTK2VsVjhnaEp4NUxHUCtKcCt6VnE3WTVMK29pcFkwdUtDTzhPN3du?=
 =?utf-8?B?TlJyL3UvTXZkTVhvWnhnbU15YUJyWDA4UGxpbmdlUEJxeVZZbFQzbDBVNUdM?=
 =?utf-8?B?bW1Ebk9ZWHRzRmlTSGZERVMvUjZCZy93Tm44czZvWUxuYytrdjQ3M25WT0lN?=
 =?utf-8?B?WkVxLzVaaDZYbVFUNkRESGJCQ2JYYmhHMkswaHJTZFF2ejVrM1BRZ091Vllu?=
 =?utf-8?B?dXIwYy9majA0dG1CY3ptNVFHOEhhVHlXN2hKRFJncE9iWGI2SnBtMWJSRURx?=
 =?utf-8?B?U3E3UnowQnhJS3NHOEJnMUJkZXFVZHc0RTZCUHdRYnFMOEpMbTc2WnpIdXFj?=
 =?utf-8?B?d1hadldJU2Q0NFRzNm5zVHRYRENSMzNWS0tsT2lvVXdab2VCY0xsS2JJMk5M?=
 =?utf-8?B?Wm5lRldmcUJDakpZM2c2aWpLUmpLWU5zWTVuTjJlUzlyNjdBdWJZS0V0bFBF?=
 =?utf-8?B?SktMYWcwZXdvQTlGbXBsMDlQSFYyUXVLcHpLS3FCQ0RZQkt3VjhtV1QwUmh4?=
 =?utf-8?B?Mk1tbDZVMkNlRkRqSExvUm1EUTdZTjJJNVArN1IraXBPakJKT1Q0Y24wd05i?=
 =?utf-8?B?eVJoZzlBZlFyaGpqQzMydkpycFAwUXJKWmN2Vk50YW1mTHQwNWhrQTYzZ3Rs?=
 =?utf-8?B?UTVWUTd5WGhKVjFpazRoQTNvMHkxWHBOTXN5SUYxYSs0WElyS3E0Qm9iSjZP?=
 =?utf-8?B?amszTjQvNitxS3ZyMkxPVU9RS3NnWVN2TGEva0w3eUdMbUszYlFwVnVuR2Vp?=
 =?utf-8?B?Q1g3Q0JKK0NadVkzM04vOHl6SDdhamlqcTU2RnpWRllmakJpMWJJZldkbFlq?=
 =?utf-8?B?NjJkRW5EMVNmSzBMRkdFOVBnOThJRXZJN3NNYStrTnovbGhKcWlObnBvRUJi?=
 =?utf-8?B?OXMyWDZobU1rdU44dDVnVFh4TkxQbllFbVZTRUl2c3FrOEJxMzk4NmZFc0RX?=
 =?utf-8?B?WURuekVKZ0RvTVpiTFNNSDdPL09WeUo0WTlkeVRJaDdvVEprNGR2UEJ5VVlk?=
 =?utf-8?B?djJpTjhIZE90QjF6NUsyVytyTzJUMU85b0F3cTdOSDlXaFYySVdyYzVFNHRi?=
 =?utf-8?B?dVUzZS93N0pIa0tRQ1dpZ3VaUW0yZkp5aytwZnpxOHNuMlB3b0NncHBDN3Vj?=
 =?utf-8?B?QnBDZkJXMnJmYVBPRnhRU21pVEJGOVhxbjhNNFlnRk1LakZ4RFV0NTk2MHhu?=
 =?utf-8?B?VXR5UExVQTNjVEhMR1JHbGlEblFpbW9GdmRzZ2lRM1VwYnFLZmZFbFRSbTN0?=
 =?utf-8?B?emxaV2tadzluYU9IUjNibzdwVjBBeDNCWk1reCt6eDRnZEVmR1FZZzFzQURr?=
 =?utf-8?B?MmxJbzlTRlFIM0VqOFJkWnZ0SmhQOWJLbXNrbDNJNnRkclVnY2FTYm44VG83?=
 =?utf-8?B?ZHNyZDhETlZwYzNSeVo4dFlOOTMyK3Q0RnpGSDFBcVpkallKZnZKN0lvaEkw?=
 =?utf-8?B?ZXFHM1RoREZ5K2lGMmxTTDZpcVZiaElPYkJ5L00wR0pJWmFKZ3Naamd0YkVw?=
 =?utf-8?B?V3R4a1Q5YjV1TFkvL1VRand1V3JramJtVUo4RUp1RUhwOVNCYTBmOXkwMzZx?=
 =?utf-8?B?dUNlZkVpODVTR3BnNVNMOEtlNTAxM0xjTER0UXVGUUFmUGljMzRsVE5ZVU5a?=
 =?utf-8?B?eEl5bCtCS21SWWdNWHpja2RPNmZPMHFRazdlQTZzeDlRTlBxbWZvRkRvaTJa?=
 =?utf-8?B?L3RqZ0xiNU15R1ZHaUNYeWlmSWpBb1lXaksyclZWc3NJc3VqME9DTGZPelBx?=
 =?utf-8?B?OGxEbmc5UVhCZ3QyNVNEUWRIaVhYSEdGWEVneVlYYlQ1UXdtUlBJNThNS2kr?=
 =?utf-8?Q?fa8iAPEErMCTwBN6NVq699ru5y7CeMpYZ8tu4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7009.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjhFRVFZNXY4dFFEcHJZc3B0a2I2dThPSVZWVFJYbU5NTnV1elJyY0lrUkh4?=
 =?utf-8?B?YlAxQVBIRFJQR0VLcmwzTi9jczJIWXo3RFNTNjJjMzhFWmFUYmE5V1EyUGpF?=
 =?utf-8?B?cWlOdXJjdHRIK0YxeDhxTFdaSGl4TW5QTFcwTUdZM1pxZ0hJbmxDaTRLcWJ3?=
 =?utf-8?B?OWliMS9TN0QzZnROSUYwM21vMDBERVgzSU9selhkQTlOc2k1V0tQTEZJWEVI?=
 =?utf-8?B?anU2a05qalVRck1pK3FhL3FCeXRXY2pjM2pzQmw0ZGhhTnI0bVZ6S2h6aGxG?=
 =?utf-8?B?Z3lBZ05TQmZqRkNiYUo0UXN5NVlDQ0REODEzWEtCbmwya1dCS2greFRUWkRo?=
 =?utf-8?B?YXlWcjR3NS9FaU1hVXV6cWpnajkwK1JOd0tEeTFSbm1jUmF5NVl6VkpOdG1y?=
 =?utf-8?B?ZkdmU0hvWVkwKzFLQmRYS2F4dTJwZ2tYOCtSWWdkRWxjS21ROElZSk5VU2h0?=
 =?utf-8?B?eDNNbktSa2RlaXFKeWovbnhvc1h1czcrSXcyc1MxNmR1ZVJOWStsb3Fub3pw?=
 =?utf-8?B?S3NkR04yemxyRXpuNFNad1ZacDR3aWkrT04zbDJQRG1DU0ZnZU1XOFR5WDhF?=
 =?utf-8?B?akI2b0N4dnBsaXJ2bTN1UE5ycmsrYnVXYkRKVkpjemdURzhrSkhnYlB1NXpZ?=
 =?utf-8?B?UktxUGx3eTVvL2svVzB2Z05sSXNPZnhFWEROQ0NWeFUwS2ltRDNJMkNOUlRF?=
 =?utf-8?B?elVVbDBTbEVSYisxSExPNXgybGgxSnJLQjVnc0x2c3IwWG8wcDBxMEZxd200?=
 =?utf-8?B?U3BUdGdRNnd2bnowM0REUVgvTldVazZlMit2WTBwY2JnNW9tYzZqdTNQQVlM?=
 =?utf-8?B?RVNjVHhydld5V2thZnh2OUlsNjZ2YW1nUEZ4ZFBzZ0dNblFDUEpVMVZBMkRN?=
 =?utf-8?B?cUJ3QVRBOCtybGRxcU1vMGcwajRBV0F3QlF1M3liaWs4M3pXY2NLbkdGRlBS?=
 =?utf-8?B?bDRTV2FPZ2ZTOGR3L2g0YjFGRHJpRjBSVUduVE8vQWtoOVZ0aVNMc3IwUThO?=
 =?utf-8?B?TUpKMlBXVythT2NPN01lc2txN3JvUE9TTjh6MGp1Y05ycVovUzE2RUtkS3Fi?=
 =?utf-8?B?SHFKMWZ3RTFIZEw5UEhZZ0NQa2hHR0UzZGJ6L3BaV2JtZVB2N01mb3UvRi9K?=
 =?utf-8?B?YWh4V0lxN2s2ekFCL01lSjlPMUhkZzFrd21QSE0xbFQwMG9EQStHWlF5ajUy?=
 =?utf-8?B?UWl4RjVYMDVQK1F3eUVVNFBQa1Z0Zk8xS2plaE9WVHpZUEtlWFU1SHFVWGV2?=
 =?utf-8?B?Q3dQUEtjdEtSVmZvMHlTR1JrUnBaVnBsWkFxVlprL2NLZTZXc0RxejdiN0hk?=
 =?utf-8?B?QnBuWHRJUTdycHVFQU9UUTlGeU8rcVlpekJRd3NzZnBCVGhFNHVrZ2JTWklR?=
 =?utf-8?B?eVlOU05ZOU9OZkVFdEFQS3NUMFJySlV4RE85UUxUZ0s1b2pXUFN0aXEzUEZh?=
 =?utf-8?B?eXNOV0FCMUxtTExoM21xUTg0U2xLYmNlNWs2YWlxcmhETUl2RFpsTFZ6eXpx?=
 =?utf-8?B?TWdiRkNaSUJQNXZYYnRhaDhlckszWGxmQmVTVjN3cmYxdlA5eGk4dUlNOWpJ?=
 =?utf-8?B?WE9HRFlrMGg0MldIZmE2NXQwUENFLzRPeWRpV2g0aVRFTmU2NzczbHI0dVM0?=
 =?utf-8?B?OEk5MGk4a2hIQXNCNWFMTWx6MndERDNzdDRSUGhGZG4raXREYnZ6Y1VRWUJ0?=
 =?utf-8?B?QjkxY0VMemtTWmh0Y2FHL0JDYVZQN1J5aERJUUhjMjgxblZOMCtTNWZhdk5T?=
 =?utf-8?B?Ylk1SXl3YVBIYmdHR3BKdEtmTnVzOVRaeUtMRG01eXlYYVBtUVRLM25BZ2Qw?=
 =?utf-8?B?L1QyTzFvUUdrekFUSGxUOHdrNnhwQ0gxSG94TGVyWTUxVEl6TW90eklpcmt2?=
 =?utf-8?B?dEZzT0N4WXNqMkwrSnRad1o0M2VzWGd3c2FhMFlhNXlPeVczTi9hZUx2UzJt?=
 =?utf-8?B?RmtwT1hpTnRKZHRVNjBVbmYrMnpNQnM1cDJzVzVFQXd3ek1ab0tuZm85RzVJ?=
 =?utf-8?B?MXpxVUdVc2VJaURlY25RV1daWGNDd2cwOEM0U3VPbnp5RXp4ZGJWSjA3bGJv?=
 =?utf-8?B?VkdqbjVkTFQ2NUQ4b25PU2xBc2J6bEpOMHBqTGZOL3VIVDN2NGZ6ZXBveDRr?=
 =?utf-8?Q?uSDCb0Oz23QOzHjk9wmunMAuP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be05b767-3309-4099-7fe5-08dccd579ed1
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7009.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 03:05:39.2836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vggfIO2jhLoM7WIrxT8ggniQ8MtRrIGgtY4hpnqQcfjz33c4AldTgspgjGsx3YcLEz/+ruWaM67eyo8xa+Xktg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8484
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9; envelope-from=junjie.mao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On 9/4/2024 7:01 PM, Paolo Bonzini wrote:
> On Wed, Aug 28, 2024 at 6:12 AM Manos Pitsidianakis
> <manos.pitsidianakis@linaro.org> wrote:
>>
>> Add rust/qemu-api, which exposes rust-bindgen generated FFI bindings and
>> provides some declaration macros for symbols visible to the rest of
>> QEMU.
> 
> The only comment I have is that I would drop the allocator support
> completely. It adds complications and, at least initially, we can
> plan/hope that all cross-language allocations go through a constructor
> function like error_setg() or object_new().
> 
> In the case of QOM, if we wanted to allocate objects in a Box rather
> than malloc-ed memory, we could also put in the object a free function
> that calls
> 
>     mem::drop(Box::from_raw(p))
> 
> Fixing rust.bindgen() to use the right CLANG_PATH/LIBCLANG_PATH should
> probably be done in meson itself. The (not too hard) alternative is to
> just use a custom_target.

To unblock this series at the moment a custom_target() is the only way. Fixes to 
either meson or clang-sys crate will take some time before they are available in 
a public release.

The ideal fix to me is that clang-sys always find clang and libclang of the same 
version. I can take a look at that crate and think about how that can be done.

Meanwhile, I opened a PR [1] to discuss this with the meson community. The PR 
itself adds the env argument to rust.bindgen(), but as you suggested meson can 
do more, e.g., when given a native clang executable, meson can search for the 
corresponding libclang and sets CLANG_PATH/LIBCLANG_PATH accordingly. I'll keep 
collecting their feedback and refining the changes in that PR.

[1] https://github.com/mesonbuild/meson/pull/13631

> 
> Paolo
> 

