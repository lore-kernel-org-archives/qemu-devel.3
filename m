Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53726CA0EF6
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 08:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjxLa-0003m5-FQ; Fri, 30 Aug 2024 04:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1sjxLY-0003j5-3Z; Fri, 30 Aug 2024 04:51:08 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1sjxLT-0007u0-Cm; Fri, 30 Aug 2024 04:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1725007863; x=1756543863;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=i99QEQBzVWbniav03MRI+WI7bnLAhcZjvtoIj6ubLR8=;
 b=l952u/X08pn2l4Q+nzY5kgYBJ28F+cNVFetYBWvYKxN8kamAF4dO9R0g
 ii6aaZXcg29B3E+jTwiC8W30OB1Y2I5fYANv16f5cL9qXKNFfI/Mj5W7P
 NYjG2lvd8eVOrGqtofsA8+qtOHIYwnbGP2ncLqPgVffwKDUGipuMmYL4Q
 t8ni4bnHxJwqb6l4pVTw3KTvC5A8JcOMVrKybJC5dnnK0TP7+8sonG70n
 8KM5FsfzzN9LTx5omFbse32pPwjBUspBhhstcWvOWCypD4XadylRmhol9
 XNi62+aNRhoBxtaoOipAazeav1hkyNvMUEXPlUs4ezuPrk0uhRDm0nzY+ Q==;
X-CSE-ConnectionGUID: 1qFgtObRRkG0fSQtj6Ixtw==
X-CSE-MsgGUID: TwjBkG7VS2W1knaguI0ucw==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23208102"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; d="scan'208";a="23208102"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2024 01:51:00 -0700
X-CSE-ConnectionGUID: VGf0lVytRYCMbrkLoW3SUQ==
X-CSE-MsgGUID: ysgEAuBSTfmErLYBLjiDFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; d="scan'208";a="68236224"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 30 Aug 2024 01:50:59 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 01:50:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 30 Aug 2024 01:50:59 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 01:50:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXJBMNnNna07ltL3HO6279MWYo5OBsW3BBXHzvsMP/UNSfD6bAG50j3tDLuopadOUGy7wA62m9fWP342w5s1Qvwv4YJvRUta6QxWnBiKNshRhodaMKniuMBqdHqQDf3uxkY3OODKmW+r0Kh0lBaChi/CCSMVkSEy2IaushxbWmrrQfHdQMw1UcA650WoaQrkRQL+eiqs/ENuUdY1Rq47vOwFvnL2GIZlpj9ef1r3iwdwyEUDCH4v14KApaAT0JUXTr36OtiAYvNN9+lJ7rahf63KfXHY2D/iV+mhSp4qz26Wr2jgyiUV+xPVvv3vuI5n2D/EKNTM95DUXWDzElb+IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3jTt/zAjcQ/lZ0Mx2bovUoaMrAY7LyKXErDL51s+9c=;
 b=sDfVhz7NkftqQMsE1L6cx4gyP7D7x1ZzcdctJpLnojc/lJu5RQylESL+GsuecE/2lr0TU4/87AkRlzmiE9eQFiAbb8JWZJTXHeA5RGtgLUrx2hjRMIxRAkgjZ0LEbcxB13Ln3u5RJOczDc0XC1axzk9JFNtvZQeTcghQ+TVla8fgPAGaVn4RuNnwXl/D5NQXjs3ioSVXR4uPtqYmqMzuph9Rr2sfrkViAYrQ7id0QjpUGnFwx1TVBavBR3So0Q5gF0Qhg0tk8Q1sc+xNqOs853Usq4PEmb+LVIdKz9zBi+GoE5/9W32VFgKy/GJCAPTDxCDJE+jPA4QVO/At9IydQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7009.namprd11.prod.outlook.com (2603:10b6:930:57::12)
 by MN0PR11MB6060.namprd11.prod.outlook.com (2603:10b6:208:378::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 08:50:56 +0000
Received: from CY8PR11MB7009.namprd11.prod.outlook.com
 ([fe80::7ebc:871a:bc7f:1eed]) by CY8PR11MB7009.namprd11.prod.outlook.com
 ([fe80::7ebc:871a:bc7f:1eed%4]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 08:50:56 +0000
Message-ID: <8b82efb4-74a7-4d46-8ba9-c7354a812623@intel.com>
Date: Fri, 30 Aug 2024 16:50:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v9 7/9] rust: add crate to expose bindings and
 interfaces
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
CC: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, "open list:ARM
 SMMU" <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
References: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
 <20240828-rust-pl011-v9-7-35579191f17c@linaro.org>
 <871q284wxk.fsf@draig.linaro.org>
 <dd2ed180-3624-4981-adb7-c78e699048a7@intel.com>
 <CAAjaMXZhvq3qppgEhs5zB-M=hfDFNT993XCUp0ZKPFmVxFXL2Q@mail.gmail.com>
Content-Language: en-US
From: Junjie Mao <junjie.mao@intel.com>
In-Reply-To: <CAAjaMXZhvq3qppgEhs5zB-M=hfDFNT993XCUp0ZKPFmVxFXL2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To CY8PR11MB7009.namprd11.prod.outlook.com
 (2603:10b6:930:57::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7009:EE_|MN0PR11MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed519e5-d5e0-436e-867c-08dcc8d0dcf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0xsdXZBK0Z5c0t3aE4vdk1HSkVjZXhBM3RFQ2lLYWFHNkt6VGZLbUJ1cGt4?=
 =?utf-8?B?WUFxWTNpYjNXT3NPUEdReTFwbEFYSnpnUXhqamY1Qm5KZ1M4YkNIcnl1R1Iv?=
 =?utf-8?B?RzFlUkR1cEpRYmkxcW5EZ0tzeDYzc1RGWlB3aGhrUWZQbWRSMGFqRkVPQm4r?=
 =?utf-8?B?TEJ2NDhmdDBsTUdmbndQdGM1ODBvaDNCQmk0QUNlRklKdnJFOCtDTmh1MnpI?=
 =?utf-8?B?Yys0aG0ra2c2L2dTWDQ5Q0hIWUlKcFJEL1ZnVXoxV1BHSktvZ3lDb0ZXa2dx?=
 =?utf-8?B?RTZWUkNxUWZEL0RsSDh3TEU5S3JQSFVRRzB6R3F2YnZnNnhVbjRpcXMrYW5U?=
 =?utf-8?B?OEt2NVVmZlRCb0FDUzZMMVlHSklHZjBHcW9LNDFZMGg5NUFJRytUQTNWUEZB?=
 =?utf-8?B?NXEzcnJXRVlkaFBoUVQwdjdSbGlLWFVDOVpRdDZIdnlnaVBPRHJtYXYvK3R0?=
 =?utf-8?B?K1FsOE81aEJaeFdqbkhGVHhnS0lKMm1lUW56cTdZRlA1S1habnRDRnNKZU9F?=
 =?utf-8?B?YmdGQitMdnRCTmExMDAyTjF0aVZCY1U2VXRoZE5ZU3Z4bmEva3NTVGpOWTc0?=
 =?utf-8?B?OGxNY2VacTQybG41QTRGU2Q5SitxRGFPcmNEdTNvK3lhaEVEZTIyQ3lrVVdG?=
 =?utf-8?B?VVA1K29LVTloTkhwUjZwUWtHWkovcU4zTkRSMjRjZVVVakdOcitBZ2Jpc0Uy?=
 =?utf-8?B?NzBHZk5zL1ZiSXZRWlBSOTh3ZkJDc2c0YzFmYzczc2dyTHUwenR3ak9aVkJC?=
 =?utf-8?B?bXcydDA1U0J6dmZpT09xSHVCc09ud1ZicDIycVY5SGNDZm9EQ0RKaHRrdzdj?=
 =?utf-8?B?YkxYaUFPcEtCc2ZqemJPYUg1bjQ2MnFPM05ncDR3S2xpS0dKWWhHQVJkU0V6?=
 =?utf-8?B?b2k1WmtGSHdBa1VYbVpSbjJwZkwxbDJjM2UyNmpkQURRN2l0T0ZiYWpydmtl?=
 =?utf-8?B?YkZ1TURwTlpxRWdLaUxWOGlSTVRtWHQ2bjdXcmVpbVArc01vVGdkN3J6ZXhX?=
 =?utf-8?B?YlhkbUZVVzJ5YmRnSXYrZ1loNStvZ29YeHFZVDM5YnVycGRUL1hXVm1jbDJH?=
 =?utf-8?B?bUF0bXFoNlV3c1RWRDc1MHpPeHNLZTNkK0VwYkR4dHdybitLQ2RsSmgrZUJ1?=
 =?utf-8?B?TUt2VU9saUx1Ukh1eE9wMFhXdzFFWjVEajRiaFpkaTQzU2lqeTVxNXpUUnM0?=
 =?utf-8?B?VEthQzBvdUR1OTI5ZHRyTlFTMnJkVzZ1TE1vQ1laeEUwcXlFOE1NUWtWM2xF?=
 =?utf-8?B?RnlMWTNYOStpTFhEMStIcXo1eFk2SCtRUTRtRHRud0tXUW5MQU1JYUFOblFs?=
 =?utf-8?B?ZzNVaUFpME1hMVpRVXE5Q0VYNmlnOWQwT1BEU2N5MnEwSXZ4TzMrcjA2c1N2?=
 =?utf-8?B?MmxHSGRRT0c3cnowME93bng3WHFpZ29hSnNORkJDc1dodGt4bVBCQlRhY1B0?=
 =?utf-8?B?THRlMTlYMyt0NXNTUXZJUy92ZDVncEJ1Vk5wQUJHR0pJR3daZnFsU2ZvQnBH?=
 =?utf-8?B?U3dIeUF4STc0WURpQ0ZqVmorS21OMjhJb3Z4MHlGditNajI1L1JVZGhVOTg4?=
 =?utf-8?B?MmFReURqYkFiZTF4V0plem5KU0VTL2t6SWdGWWZxOWZ2RGl1ZnRhcW9Gc3R2?=
 =?utf-8?B?S0hkK3d2R0twdTJsMWIzZkcxRFdKVWxnYlNOMUg4NXZOc3VyeXl2QTl1Uk9I?=
 =?utf-8?B?cFVVTEVUWjlGRWN2VGhwK2VoaHQ5ZkVaYndrV1BQSFN3TTczRUE1enBxVGF5?=
 =?utf-8?Q?3F0Zb3f+elv2Mc+UMY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7009.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YktGZGdLSWIvMmhzcnJJRnh0RmppZmszbmFBVTh1QXVUSkJoR0d4MTUyb3Vk?=
 =?utf-8?B?bHllY1JjM3RJV1JxWEdCRWFDdjZTaDdiNnBQamU4THRWVUlkRG5aa1ZZUnVZ?=
 =?utf-8?B?QjZwOTR0T2J6VmdST0tYN2xrRy9jdjBNcnZVaUNaWW53Rm9HZUptNStCZ3l4?=
 =?utf-8?B?SWNpbktJM2NkN0R6N2ticXM1WnBUaHJ4dFZXVExxMklUNWhHRHpTelllMWZG?=
 =?utf-8?B?MFF6Qm9NQ1hxaC9PNGxtUHRlWTlzRmYyT3k5NnF6NW1ldmhWM2xROTQ5UmtU?=
 =?utf-8?B?cG9TSFJzUnByanZrYXl4MW5CMktMd3kwZWVEK2FZRXRqcksyR2Vwa2dMSFpQ?=
 =?utf-8?B?SGZsR29OWUtkc3pXblJDb3ZBbzRKUTUwc283VEJUWkIwc3Bpc0JxMDRNaENO?=
 =?utf-8?B?V0lqTWVJVnVpaVE4dmRHRm1pSzRWbkc5NVU4eVdoL00zRFVkN2lhZW5uRW1H?=
 =?utf-8?B?VmNRYnpEY3Jsd0FVbk0vY2w3YXlBdXN2RlZkRGNBYkNmRGlaV2JzL1Z5aUVh?=
 =?utf-8?B?czY5RkYvUGRrVDRCb3FlWFdzR3ZoQ3pmdXUrRUNWVHF1N1dSTGRUME0razYv?=
 =?utf-8?B?dXdSRlFwMWdZbmxtYUZKT0JLa0FOL2J1WlQ4NlJYZkI4R2VjbW9DUVNvSjZs?=
 =?utf-8?B?YmRYVVV2REtrcHJTMmNhUFdqc1U3UEZtMnV3bjZ2bm8zejMwVUU2YjZrcndj?=
 =?utf-8?B?OHVtZUpzSmtvMXJSbGJTZnZqMGJEUkl2NEhRNW02T0pJRDZudVVvTVZKcnFZ?=
 =?utf-8?B?QSs3eXo3aEFWbnR3UDNLblk1b3NUbnUzS3E4Q3lCNFVJY2lYRjN5RU0wMzUy?=
 =?utf-8?B?R1owMGdyaTV0ZFE1RHBzMFlOYUJDc2E5bjNlT3dVQnRXeU5xbFQ1R0dieThI?=
 =?utf-8?B?aGRDWDM2MXpHZTJyREZLNEpRWkJwR0pNaVFQT0l2Z25FWGQzRHlrRk5abElp?=
 =?utf-8?B?UjdUK1lBK3pOWXdhY0l1K0VvRkRLcm00UFlhN09yNG5DRkIwMWx1cTJHdGNE?=
 =?utf-8?B?NExSYi9LWnc0cmRnRjRTZGREdnhFd2tTb3lnQjBlZ2p1bTF6cy9yMzIzMlA0?=
 =?utf-8?B?bXlIK3pESjRjRFh5NTMvYUFTWW9rMm9rWU02d3dMdEJzNFVzTWVldWRuTEo0?=
 =?utf-8?B?OHpVMWFBbDVVaXdiOEd4dTcvRzJSZkR0OE9HMm5yVGlJZnYvRDlKdEw0eWZ0?=
 =?utf-8?B?QjFUZ0FXMlI5ejVGNHZXdHpFNHR3bmRsUW1wS3JpOWFoajNiVlhFV1ZhVzFY?=
 =?utf-8?B?TncxSzZzb1ZVU09SanE5SUpYWWN5RTErNHZNWlJMZitxUkZLT0VHZTdueDRs?=
 =?utf-8?B?b283UTQ3RUsvcHp6K2hVejZldnNMZFRmTnE5aFlkWWtwWWpyd3NpQlZVUGRG?=
 =?utf-8?B?T2VqRDBOL0ZzMG9VUHVVbGhiejlRR01mek9OVUorVjBWOHhja3YxeU5hdFZM?=
 =?utf-8?B?clUvS0pWeWNLekNWWkQwY3YyQ3NpS3ZMZytpc0pJOE0xeXdoK0lMR0sxeW05?=
 =?utf-8?B?aitWRUliTndnWWlIWFoySElxN3h0YUFoaWI2NjRQMmVDOUNlbkVhRlYzSjYz?=
 =?utf-8?B?ek95QTQ5N3R2ejFaMHJzK2hIc05rdjdWaVFFV1Izam1mR3g2Z3NrMmhIaXor?=
 =?utf-8?B?TGpFUkF2eXpvemUva2hIajUxcVFFRytOK1lwMEFCQmltR0F1b2pLTzN5aTg0?=
 =?utf-8?B?aHBRaVVEK1hKMm9vZlJaOWRmSTQvZUhOMFZlVWtGMkxIYWt2dG93am5kbDdK?=
 =?utf-8?B?ZkVLYStCTDhDL25Gd2dMeXVMaVRTVFoyMk5oR1BNVEFXSDMwcWZwUldhd0lm?=
 =?utf-8?B?dTExNEVrNFlZdStpcUFPbWpCbFFNeWhmNml6cmU5ekltQzFreHJ6T0VyMTVS?=
 =?utf-8?B?V2tBR3FpNVRlYXY3dWRMQldTY1ZEZEtjd29JN2l0d0VwM2s3cUp1QXB1cmdW?=
 =?utf-8?B?MEg2VUJZVGtsb3pHejFCdVM3Y2hkZGN4azRrQjV3RTljai9kQ0UybXFFbHM5?=
 =?utf-8?B?R0RQWGtqVDlGWlpmcHJBU25ZandsOFcybDZ3Z2IyWVQ4SENhRFEzUGZ0VnBT?=
 =?utf-8?B?bE5EcjFQUGxnZkFqRWIxOFBEZkVlQ1lEd1ZxR2h1dUN3MTBSWFRPOUhxZ2dE?=
 =?utf-8?Q?dJbQ7QnefVi6zUG1Jc6gPHBNE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed519e5-d5e0-436e-867c-08dcc8d0dcf7
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7009.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 08:50:56.6780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8uBSjeGvCQU2U/urkVRJcIcuYEh5ew8qj1VNRHF2RIPiklOEDX2Fla+ygYvxlKVQuZpEFaRr+Y7PatkZ+Bq9AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6060
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19; envelope-from=junjie.mao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 8/30/2024 2:43 PM, Manos Pitsidianakis wrote:
> 🎱
> 
> On Fri, 30 Aug 2024, 04:19 Junjie Mao, <junjie.mao@intel.com 
> <mailto:junjie.mao@intel.com>> wrote:
> 
>     On 8/28/2024 9:08 PM, Alex Bennée wrote:
>      > Manos Pitsidianakis <manos.pitsidianakis@linaro.org
>     <mailto:manos.pitsidianakis@linaro.org>> writes:
>      >
>      >> Add rust/qemu-api, which exposes rust-bindgen generated FFI bindings and
>      >> provides some declaration macros for symbols visible to the rest of
>      >> QEMU.
>      >
>      > As mentioned on IRC I'm hitting a compilation error that bisects to this
>      > commit:
>      >
>      >    [148/1010] Generating bindings for Rust rustmod-bindgen-rust_wrapper.h
>      >    FAILED: bindings.rs <http://bindings.rs>
>      >    /home/alex/.cargo/bin/bindgen ../../rust/wrapper.h --output
>     /home/alex/lsrc/qemu.git/builds/rust/bindings.rs <http://bindings.rs>
>     --disable-header-comment --raw-line '// @generated' --ctypes-prefix
>     core::ffi --formatter rustfmt --generate-block --generate-cstr --impl-debug
>     --merge-extern-blocks --no-doc-comments --use-core --with-derive-default
>     --allowlist-file '/home/alex/lsrc/qemu.git/include/.*' --allowlist-file
>     '/home/alex/lsrc/qemu.git/.*' --allowlist-file
>     '/home/alex/lsrc/qemu.git/builds/rust/.*' -- -I/home/alex/lsrc/qemu.git/.
>     -I/home/alex/lsrc/qemu.git/builds/rust/. -I/home/alex/lsrc/qemu.git/include
>     -I/home/alex/lsrc/qemu.git/builds/rust/include -I/usr/include/capstone
>     -I/usr/include/p11-kit-1 -I/usr/include/pixman-1 -I/usr/include/libpng16
>     -I/usr/include/spice-server -I/usr/include/spice-1 -I/usr/include/spice-1
>     -DSTRUCT_IOVEC_DEFINED -I/usr/include/libusb-1.0 -I/usr/include/SDL2
>     -D_REENTRANT -I/usr/include/glib-2.0
>     -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -pthread
>     -I/usr/include/libmount -I/usr/include/blkid -I/usr/include/gio-unix-2.0
>     -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include
>     -pthread -I/usr/include/libmount -I/usr/include/blkid -I/usr/include/slirp
>     -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include
>     -DNCURSES_WIDECHAR=1 -D_DEFAULT_SOURCE -D_XOPEN_SOURCE=600
>     -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include
>     -I/usr/include/gtk-3.0 -I/usr/include/pango-1.0 -I/usr/include/glib-2.0
>     -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/harfbuzz
>     -I/usr/include/freetype2 -I/usr/include/libpng16 -I/usr/include/libmount
>     -I/usr/include/blkid -I/usr/include/fribidi -I/usr/include/cairo
>     -I/usr/include/pixman-1 -I/usr/include/gdk-pixbuf-2.0
>     -I/usr/include/x86_64-linux-gnu -I/usr/include/gio-unix-2.0
>     -I/usr/include/atk-1.0 -I/usr/include/at-spi2-atk/2.0
>     -I/usr/include/at-spi-2.0 -I/usr/include/dbus-1.0
>     -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include -pthread -I/usr/include/gtk-3.0
>     -I/usr/include/pango-1.0 -I/usr/include/glib-2.0
>     -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/harfbuzz
>     -I/usr/include/freetype2 -I/usr/include/libpng16 -I/usr/include/libmount
>     -I/usr/include/blkid -I/usr/include/fribidi -I/usr/include/cairo
>     -I/usr/include/pixman-1 -I/usr/include/gdk-pixbuf-2.0
>     -I/usr/include/x86_64-linux-gnu -I/usr/include/gio-unix-2.0
>     -I/usr/include/atk-1.0 -I/usr/include/at-spi2-atk/2.0
>     -I/usr/include/at-spi-2.0 -I/usr/include/dbus-1.0
>     -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include -pthread
>     -I/usr/include/vte-2.91 -I/usr/include/glib-2.0
>     -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/libmount
>     -I/usr/include/blkid -I/usr/include/pango-1.0 -I/usr/include/harfbuzz
>     -I/usr/include/freetype2 -I/usr/include/libpng16 -I/usr/include/fribidi
>     -I/usr/include/cairo -I/usr/include/pixman-1 -I/usr/include/gtk-3.0
>     -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/x86_64-linux-gnu
>     -I/usr/include/gio-unix-2.0 -I/usr/include/atk-1.0
>     -I/usr/include/at-spi2-atk/2.0 -I/usr/include/at-spi-2.0
>     -I/usr/include/dbus-1.0 -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include
>     -pthread -I/usr/include/glib-2.0
>     -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/spice-server
>     -I/usr/include/spice-1 -I/usr/include/cacard -I/usr/include/glib-2.0
>     -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/nss
>     -I/usr/include/nspr -I/usr/include/PCSC -pthread -D_REENTRANT
>     -I/usr/include/pipewire-0.3 -I/usr/include/spa-0.2 -D_REENTRANT
>     -I/usr/include/p11-kit-1 -I/usr/include/fuse3
>     -I/usr/include/x86_64-linux-gnu -D_FILE_OFFSET_BITS=64 -D__USE_FILE_OFFSET64
>     -D__USE_LARGEFILE64 -DUSE_POSIX_ACLS=1 -I/usr/include/uuid
>     -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include
>     -I/usr/include/p11-kit-1 -I/usr/include/p11-kit-1 -I/usr/include/p11-kit-1
>     -I/usr/include/p11-kit-1 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
>     -D_LARGEFILE_SOURCE -I/usr/include/glib-2.0
>     -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -std=gnu11 -MD -MQ
>     ../../rust/wrapper.h -MF wrapper.h.d
>      >    /usr/include/liburing.h:296:3: error: use of undeclared identifier
>     'memory_order_release'
>      >    /usr/include/liburing.h:1080:11: error: use of undeclared identifier
>     'memory_order_acquire'
>      >    /usr/include/liburing.h:1116:9: error: use of undeclared identifier
>     'memory_order_acquire'
>      >    /usr/include/liburing.h:1125:9: error: use of undeclared identifier
>     'memory_order_relaxed'
>      >    /usr/include/liburing.h:1161:2: error: use of undeclared identifier
>     'memory_order_relaxed'
>      >    /usr/include/liburing.h:1197:19: error: use of undeclared identifier
>     'memory_order_acquire'
>      >    /usr/include/liburing.h:1267:10: error: use of undeclared identifier
>     'memory_order_relaxed'
>      >    /usr/include/liburing.h:1269:10: error: use of undeclared identifier
>     'memory_order_acquire'
>      >    /usr/include/liburing.h:1320:2: error: use of undeclared identifier
>     'memory_order_release'
>      >    panicked at
>     /home/alex/.cargo/registry/src/index.crates.io-6f17d22bba15001f/bindgen-cli-0.69.4/main.rs:52:36:
>      >    Unable to generate bindings:
>     ClangDiagnostic("/usr/include/liburing.h:296:3: error: use of undeclared
>     identifier 'memory_order_release'\n/usr/include/liburing.h:1080:11: error:
>     use of undeclared identifier
>     'memory_order_acquire'\n/usr/include/liburing.h:1116:9: error: use of
>     undeclared identifier
>     'memory_order_acquire'\n/usr/include/liburing.h:1125:9: error: use of
>     undeclared identifier
>     'memory_order_relaxed'\n/usr/include/liburing.h:1161:2: error: use of
>     undeclared identifier
>     'memory_order_relaxed'\n/usr/include/liburing.h:1197:19: error: use of
>     undeclared identifier
>     'memory_order_acquire'\n/usr/include/liburing.h:1267:10: error: use of
>     undeclared identifier
>     'memory_order_relaxed'\n/usr/include/liburing.h:1269:10: error: use of
>     undeclared identifier
>     'memory_order_acquire'\n/usr/include/liburing.h:1320:2: error: use of
>     undeclared identifier 'memory_order_release'\n")
> 
>     Those missing identifiers should have been defined in stdatomic.h which is part
>     of C11. You can check if that header exists under the default header search
>     paths (which is listed by clang -E -Wp,-v -) and whether that file declares
>     those enum constants. If so, you can further check whether there is any
>     stdatomic.h elsewhere that shadows the standard one.
> 
> 
> Indeed. These are in the compiler's own header files. I had problems on Debian 
> when using clang-14 and clang-15 but I got rid of them after I upgraded to newer 
> versions. If anyone can confirm/reproduce this we can add a meson warning check?
> 
> 

I can reproduce the issue after rolling back clang-18 to clang-15, but the issue 
is not tied to any specific clang version. It happens when the version of newest 
libclang does not match with the "clang" executable in PATH.

The effective header search paths of libclang invoked by bindgen have the following:

1. The default search paths used by the "clang" executable. The clang-sys crate 
determines which executable to use and collects its default search paths, and 
bindgen adds them (in the form of "-isystem") to clang args.

2. The default search paths that libclang has.

Clang has a version-specific standard header directory (on my Ubuntu it looks 
like /usr/lib/llvm-15/lib/clang/15.0.7/include). When those versions mismatch, 
the effective search paths contain two standard header paths, causing 
stdatomic.h to be included twice without declaring any symbol because clang's 
stdatomic.h starts with:

#ifndef __CLANG_STDATOMIC_H
#define __CLANG_STDATOMIC_H

#if __STDC_HOSTED__ &&                                                         \
     __has_include_next(<stdatomic.h>) &&                                       \
     (!defined(_MSC_VER) || (defined(__cplusplus) && __cplusplus >= 202002L))
# include_next <stdatomic.h>
#else
(symbol declarations ...)

Both the clang executable and libclang library are detected by clang-sys at 
runtime. In my experiments, that crate always find the latest libclang, but 
doesn't necessarily find the latest clang when there are multiple "clang-X" but 
not "clang" in the system.

How about we try bindgen on a simple header like:

#include <libatomic.h>
memory_order order;

If that fails with unknown type name 'memory_order', suggest the user to 
symbolic link the latest clang executable as "clang".

---
Best Regards
Junjie Mao

