Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F63CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 17:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utUeU-0005FT-1C; Tue, 02 Sep 2025 13:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1utUeA-0005Ay-88; Tue, 02 Sep 2025 13:18:19 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1utUe7-0000ox-EI; Tue, 02 Sep 2025 13:18:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKOy/hWs5FmQcvQpxmmlVe6Jdp/AiGxvsnxoE7oFVal5GS83bAWMVWwciNTtgN8fXiox31cREoP809byB7Xbz9V5O7d2ZuY7m9XSnIt0mnsxKZBUrzbPivA0rcpLceOPF+5vkZRNXQS24bYFOTVq+d7fsBd4HCNC0zeO+51E/n6WxcZky/w07uM/np56fpa7PeJOlk0iDK4N16tDd8uw89B/x9EzJ+bo/N3twJ3DTzAOKCBMukBe/EnsHrdTkwL+DTwZ4x8mzzPKPMnC+Z/cM2FypHO3cPZnB8gmauNMKbKYTxh9cEVrvGQKqsKCAobzeuN5gQMeE4Me/UEVUJCRkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnkA+QYobEHt3Zb15CiT8A6snNwk/JjNBOpomHtBRME=;
 b=yKgejrFQZU0FVoPrQtiTyXUyJXsxSdJgQFKzVwEaVVjkIvR0cvOUbAKaKmsKrUQvCgCQetQB90V+IUhFC8rJjAtADzumh0HRNImqBbzueelNFWD3CLDH9/vPpWkWkF1sVFYOKTOGXdiRXsjUY6SAB/heGyEvB+GEgVrfjZE/gvWKDyeJP1goTYu2tCQUN6iZpHmFIHcGiRT09Hhyf01O//7kwSULElkidNkCUQ9A9nWd69CN1VWpOOa7wjhrTN5g3atTERDs3qLeM7yUTwt1DZhMXDJAi/uhiOEf0Uzf215bivI5z3LNzssDwlOrLdD06XMKr4dyNAQAir3aILe2Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnkA+QYobEHt3Zb15CiT8A6snNwk/JjNBOpomHtBRME=;
 b=qucs/9k/aA8FP0nr8dPvN8zFbuUbtwe+GBAVINZ+XZ01IEwcqorajJJZYuBDyaVXYi4ML1P1Cq5MUdL7+qWPSy/PAVWiqDSjGa7t7DrZ7SFA+z5paC+VkmPgjwv8/PrNL/9ZNKQL3wIyXrF3wTPnzUPO12LWXwoUSxPKR7Ok/88VYa5DXO8M8u3OKAfS/rE4cYAy5ZuDFzTvdvbuPS1doFfydNmbb9Ep8mUrqBG4DbsntdIWkKAxRVAx8nbvouafu7Q/mdfF8cwtMRWrLVo0xPPEVvjilCRBZJZy4iVe2n0JLAH5KKHE1fWQN0i21T0XSGjVCl9ArhUBSas2EkVAfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GV2PR10MB8040.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:ba::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Tue, 2 Sep
 2025 17:18:09 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 17:18:09 +0000
Message-ID: <85b059c1-4a08-447b-a908-8af6b22d06c3@siemens.com>
Date: Tue, 2 Sep 2025 19:18:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] hw/sd/sdcard: Fix size check for backing block
 image
To: Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Jan_L=C3=BCbbe?=
 <jlu@pengutronix.de>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-devel <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair@alistair23.me>,
 Alexander Bulekov <alxndr@bu.edu>
References: <cover.1756706188.git.jan.kiszka@siemens.com>
 <86217712232abd5152e7dfa98111f57b9b78d83b.1756706188.git.jan.kiszka@siemens.com>
 <6289fe04-82be-4a34-9fed-b0cc08e3b8f0@linaro.org>
 <a9fdf524-0ca1-45db-be39-7bfccc468f0f@siemens.com>
 <11808e86-cee0-48bf-8fbd-de13a9a25ed0@linaro.org>
 <4c039b3c-dc2c-4478-b1bb-90b925e56245@linaro.org>
 <c8e1a073-7702-4bad-b7f1-2b4f51da47f4@kaod.org>
 <03a51e36-9a15-4b49-a310-c36a4d0af360@linaro.org>
 <2abbaeda-f9dc-4045-a9f7-b2b48451255f@kaod.org>
 <42310bdb-4fad-4df2-b7ad-3ff3f863e248@linaro.org>
 <d21f6449-e646-42fc-8277-b011a886e9c9@linaro.org>
 <41d2e67e-3345-4720-b3aa-1051224025de@siemens.com>
 <21b6726a-1ceb-4782-a219-36f32cebb774@siemens.com>
 <a1463f9e36d8b3e6289859bec9a0a5a758709316.camel@pengutronix.de>
 <CANCZdfprQZTVskt-EPgT-ALMO3HU-akdcw+yZ5=9Cmu1F00etQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CANCZdfprQZTVskt-EPgT-ALMO3HU-akdcw+yZ5=9Cmu1F00etQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::16) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GV2PR10MB8040:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ac2fc2-768c-49d1-7999-08ddea44b009
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2V6ZHA2YnJEbFk2MHVPMHN3UkxVU1VKc2d0WXdTMFQ3UFRBaWFBSjJ2TjVO?=
 =?utf-8?B?WGJBRStiSTRvRTJGaktyWmc5VUZTU2RHeDd1RG1TYVgrU0EwUWxJRFM5c005?=
 =?utf-8?B?Q05nS2RCS1RiSHgrdWxuTHdhcUpvNEw1MktsSGIrZldubnBPck4vdHhXeW5q?=
 =?utf-8?B?NUdRSU10RFlhTzVXM3NJVllwY1ZQRG5JK0hGSkpHZDFHRnUvdEhmTVoyZ0ZG?=
 =?utf-8?B?RHJhZGNhalFacEowaTBaU1E5K0huaStmUU1jS2QwWk43aUpmaXkyemtmUkRX?=
 =?utf-8?B?Q1Z5MU1qQnlmTWd2RVM5NE1XRW9vY2NTRnRERXdXOFRvN2xJN0p6MCtDc3BC?=
 =?utf-8?B?SmR4VkFKWWYvUk5wNW5nNlJnNHh1N3dWOS9wdEFPdnBybE1ZZm15S0t6bVFU?=
 =?utf-8?B?T241Y2VWbWZldFVGaHU4dkxiWEdkVzZxVksyTW1jcGU4bytMdkc4M2xTeit2?=
 =?utf-8?B?VTRHd1lDUmZVRFExRnNEOHdGUlFsQWNPRmlxSjAvRGpWT1hENWkyLzlIemsx?=
 =?utf-8?B?NjFsREZ1cm1mMFF4Sm1hVTMvbDZjSHFqWU9TOGhvYzJPTWF2MmJCRUZ2a3ZZ?=
 =?utf-8?B?ck9HVWorT3QydStTME83NzFpOWdVTGtrNHZtK2JlenplTHp6dmE3SWZJU2tV?=
 =?utf-8?B?L3o4VjhtdHpsTXQrNEgzdGFTT1RHdmJib1NReXJxWjNhZnB2dXlSN1hYMklQ?=
 =?utf-8?B?Mjc4ZUo4K2kxWWhtOEkvSVhtR3N4U1BMVFI2ZEtQNzRvN2c2MnNQa0dQQTNT?=
 =?utf-8?B?RjRLTEQvRHIzYW15OXhQNXF2a0pxZ2VxMEdxUVNsRE1zNDJBbVJOLzNtS0Rk?=
 =?utf-8?B?bXJOQmhzQXFTeVZuc0prL2lwVUxjSjNxckppVk1DbGoxbDZWWmc3RmMzc3N6?=
 =?utf-8?B?NUdQQzBkcm4yU3ZFa0plTGtwelJSR0lUcHdKV3QwR2k4RWVmZWFKeXByNVNa?=
 =?utf-8?B?S21ZUmpqME9TOTc0UHM3TVRlWm9aM2huK2Jvd3lLUmJLYUIzRW5PUGw0UWhF?=
 =?utf-8?B?L3c3bVRJNTdDWmhBWmxveXpOSUdWTEJCcTBRMzdyREtNRjlsN0FDUGQwU0Vv?=
 =?utf-8?B?YUhWckpPN1FBQVZvTjR5VzJqdmJOSTZRN3lISFh6QzJlQzA4UFVqU0hQR2dL?=
 =?utf-8?B?MGxaNWNRMUtIT09vUDc4Qno4MnVRR1NiRGZkM284Y1B1N2xaWnpLSTgxL2gw?=
 =?utf-8?B?Z0h3cXFsY2RUUnVkb1ZOdWU0TkM3bzZrYTFZSjhMa2p2QTIvZjhVQ1JTMXdt?=
 =?utf-8?B?UnVUV3lxSjFwOVJ2OXBGR1lYZmdyQmJHb0RTY1k3V016VzFSNFR6UWY0M2hB?=
 =?utf-8?B?OU4yQUFuOWdoZVNvTXZxQUpqL0FjcThNMWZuYW4xTENEZTNSYlRDT2ZFUFBQ?=
 =?utf-8?B?SXBRYk8wN0hsaml2YWFwN2RFRnNpejZSZFVEVGkxWFZYcU1NMXJFR2EyUEE2?=
 =?utf-8?B?bW1DZUQ2Z2NCTUxJZ1NvWU5LbFQ1Tnl2aFZHdGpqRm9aZFV1Y0VmMGdoRURW?=
 =?utf-8?B?YklqZ3BIVkdPUEs5K1E1blBleWtUVVpGN1VGQmt2UEh0ZWhVcERBVkpiN3VO?=
 =?utf-8?B?Z0ZYa3c0QnI4aHV2b2srWWNWRERrbTZEZWVISWNrVC9RR3l6NG5IdU5kY0My?=
 =?utf-8?B?QmxwRi9zWmViN1lXNlgzSTFaV0RpUlpzUE81RlJhWUJlV1pEeStVRFpmK3hJ?=
 =?utf-8?B?MTNoVzc0WUh6azhHNU5BdzB3MUY3UVZmVDVPVmxvZTVzS0Y0bk5ZQUtFQnRT?=
 =?utf-8?B?MFpNZWQ1Wi85U3VYNkJTdG16WW5NbjlUQVVncGJTSjNvS211V2FTRzRIVEQ4?=
 =?utf-8?B?Q2dGVVJqTTJVN3JJQzJIN2dIZmM5TjFTNVM4R3NZOFYwb0ZhN0p3US8xSlE0?=
 =?utf-8?B?SmdyUEd0S25FRjd5b1dvMG1peEk1VXljaFVycTBEdi9GQ1VNMnkzNE5yQzB1?=
 =?utf-8?Q?hak/P7MjmKs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlViMGx0QlFqMHI4L0pISzFYaDdmVzE2ckZWL2dMM0dWazVsUzZxbXJGUXBW?=
 =?utf-8?B?S2JzbmNYeWR0dmJWaVZLdTZoQ21yUVRGNElzV1FnSjdHRkNHbXVFcExzN3dp?=
 =?utf-8?B?S3g3ZmxEdHA5UUxzQVJTYmJwUVIyeGxVR0xzQlNTWCt0N29xaGVtajBJMmxO?=
 =?utf-8?B?VDRQQ2NPcFVIUE1VeDMrMEgzWjJXczRtdXdqT01LSDViNU1uS0hEY2hlUVBj?=
 =?utf-8?B?dmRyTkc1a3hCOHNOZFNiUkdYN3lSL1VEamU3WDhWbWZUZjdzeTBaNTZ3b08y?=
 =?utf-8?B?TktmL0tOMFVQSEVZS2JDRXM1RTRWNnIyK09raUl0a0h6KzVEckFxU2ZzNnQz?=
 =?utf-8?B?eEJwRGd4RVQ1SXlTYWJJcjdySlJLU0w2T1F6MzdmNUJ4SWNUd0M3dTNja1N5?=
 =?utf-8?B?aXV0OTd3VExvcVp3ajRVN3JwV2xvYWxnUjVZbHhhN2Q4Nlg4dnFKT1FWekQw?=
 =?utf-8?B?TzdHZGVudE96Qm4wSnd4ZktnQXNRRjl5SUZwYWhZNUdyVlJ5dURSSmYvRFlx?=
 =?utf-8?B?alpkS09GeGJLaGswT3NPWjNCTDNHczZ4OEhWQ2dFRnMrWjM3eEVTbTcrMVhv?=
 =?utf-8?B?Z29oUER2V0VFN0h0NDdFWG16aHAwTmZwQysrK2RvU3NEWmowVHVBNjlpclVh?=
 =?utf-8?B?emQvUmtOTktFdHc5OUtZSUtzWnJ6ZWhNZzAzZ3JmWlFZZE9PQ0xyeTdSMjBu?=
 =?utf-8?B?dUIzSEZrUlF4L3p2aHQ4MEZyRW91NkhRMnJiMjliTmVvUFhKdk1XYW5QcmhY?=
 =?utf-8?B?b081dkliZUFlU3owZ0R5aGpha1JST2ZnbXVUQ2FDMVVFWDY4L1NndEdFV3BT?=
 =?utf-8?B?ZmFZcjlxZ01rcDFQMmlzQ0trY25lbys4SUdtSUMzdlR6eUlkaHlPOHVDSFIr?=
 =?utf-8?B?dTZ0M0FkU0Y2d3poK3cvMTI0bGdsenNlb0ZSQ0MxMitqU2twTksyN3V4V1hC?=
 =?utf-8?B?OTR5K29mS0xycW5SQ1YyOURPYlg3T2dsZ2dVRHIvWWtXVEppTFZRbTVNWkpw?=
 =?utf-8?B?a3QrckJYWlZQSnJmczlnVVVZWWxXVmg2Y3A4NlB2NzB6K05DN0pKclVwN3Nn?=
 =?utf-8?B?ZkZJNERRcGFWbW9EeEhOeDhVOTdwZE4rSVJSeUk5M0xlc2Vkb21RRFR4K21t?=
 =?utf-8?B?YnZrNkJiQmJ6WUxVVlFBL09tYlJ2ZG5JU2tKV0F5WjJXMEdrbUJONFJUQnh6?=
 =?utf-8?B?alFKVDNjQ0RPNGxNMHh4OGt6cjBUenkvbW15YVJBVjhFZlk5d1BKbnhJemNR?=
 =?utf-8?B?RUY1Nk1qY3NMbU4vdEppRVJQLzFVb0REOFZqeWx6Sk5ySERLQ3hrNURTZ3Zn?=
 =?utf-8?B?clBlSFdBU1YxUWg3WTlsK3hSR0QxbEdYUFhyaFV1SWNEdTIycW0yT0pJbGhW?=
 =?utf-8?B?VXZhRk1uZ3NkN0ZDTzB4ZnEzN3VhQW9Za3FJZjRPOVl5dW1JeWtGM28yN0s5?=
 =?utf-8?B?MEFXSzJsSXlhemE3UzNPY2QyakJNdlNCMThMS2RPeUI3MkZXLzFYZnJjRmsz?=
 =?utf-8?B?TWZpVXJuTmhNcytDelRlSEZLWnF6WHQyNGxIWnJRWWJTZ1BvcmpSbTdVN3Vm?=
 =?utf-8?B?WjdweU82MnY0ZzdwUnZmN0IrMFlkY0FaZ1JVbkZFRHRjU0EyazBKOWhMMWdo?=
 =?utf-8?B?UWpDbE1WWnhrN3RFY1pFZ0JEeEt1YTQ4eXNVVkd6WG9JMUVrdy9WeHhtVmhy?=
 =?utf-8?B?eDNYVVlPTGVabFl0Z1g0OWNnWTJjczl3VjBDQ0Uzd0N4cUcyMmZrTldxZitV?=
 =?utf-8?B?TytYSFYzR2V2TGQ4cHJ2SFF6VEMrOUFodFQ3dXpvMXp4UWtEUG9WbFh0WnI5?=
 =?utf-8?B?cTFNdmpaTjJGZnlkNEk0WlNnemhKdkVxWHNxUE9EY2Fab0l1aXNxczVodDFi?=
 =?utf-8?B?d0R2L1ZORU5TQkljdUxqK3RhL040QWFrc3lCNnZZMnhFeU5lcUNxNG0zOVgy?=
 =?utf-8?B?Rmw3V2VOOUxMZU1vblJNRjBtSXJvOUZVTVlmMG9zZ2ppUEpFbW8vTkMyUlJL?=
 =?utf-8?B?LytkZVMxeWJtYzhITjI3SVpkV01JQi8zV3hFbUxUS0NoUEtyZng5NUlEL29Q?=
 =?utf-8?B?UGNEQWx5cU5QMHRMMnlmMDFHTG1hY1dua0ZPeXJFSmw3RWtLWWpWMnFEMFU0?=
 =?utf-8?B?YlRpeUpYc21oUGdwcmlGYy9MSWNIb0V3MktKbmhwWWxiNlpHbm9GOFo0dVhl?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ac2fc2-768c-49d1-7999-08ddea44b009
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 17:18:09.1497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+kf6IsSEd/7uqk5ruw6RQGotRK8wvtBies/H0SSLEeU3aF1Np9YV+1H64rqlkViEwMJkBDTE8zhOce8kLbL9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB8040
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=jan.kiszka@siemens.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On 02.09.25 19:07, Warner Losh wrote:
> 
> 
> On Tue, Sep 2, 2025 at 10:49 AM Jan Lübbe <jlu@pengutronix.de
> <mailto:jlu@pengutronix.de>> wrote:
> 
>     On Tue, 2025-09-02 at 18:39 +0200, Jan Kiszka wrote:
>     > > > I expect us to be safe and able to deal with non-pow2 regions
>     if we use
>     > > > QEMUSGList from the "system/dma.h" API. But this is a rework
>     nobody had
>     > > > time to do so far.
>     > >
>     > > We have to tell two things apart: partitions sizes on the one
>     side and
>     > > backing storage sizes. The partitions sizes are (to my reading)
>     clearly
>     > > defined in the spec, and the user partition (alone!) has to be
>     power of
>     > > 2. The boot and RPMB partitions are multiples of 128K. The sum
>     of them
>     > > all is nowhere limited to power of 2 or even only multiples of 128K.
>     > >
>     >
>     > Re-reading the part of the device capacity, the rules are more
>     complex:
>     >  - power of two up to 2 GB
>     >  - multiple of 512 bytes beyond that
>     >
>     > So that power-of-two enforcement was and still is likely too strict.
> 
> 
> It is. Version 0 (and MMC) cards had the capacity encoded like so:
>                 m = mmc_get_bits(raw_csd, 128, 62, 12);
>                 e = mmc_get_bits(raw_csd, 128, 47, 3);
>                 csd->capacity = ((1 + m) << (e + 2)) * csd->read_bl_len;
> so any card less than 2GB (well, technically 4GB, but 4GB version 0
> cards were
> rare and broke some stacks... I have one and I love it on my embedded
> ARM board
> that can't do version 1 cards). Version 1 cards encoded it like:
>                 csd->capacity = ((uint64_t)mmc_get_bits(raw_csd, 128,
> 48, 22) +
>                     1) * 512 * 1024;
> So it's a multiple of 512k. These are also called 'high capacity' cards.
> 
> Version 4 introduces an extended CSD, which had a pure sector count in
> the EXT CSD. I think this
> is only for MMC cards. And also the partition information.
>  
> 
>     > But I still see no indication, neither in the existing eMMC code
>     of QEMU
>     > nor the spec, that the boot and RPMB partition sizes are included
>     in that.
> 
>     Correct. Non-power-of-two sizes are very common for real eMMCs.
>     Taking a random
>     one from our lab:
>     [    1.220588] mmcblk1: mmc1:0001 S0J56X 14.8 GiB
>     [    1.228055]  mmcblk1: p1 p2 p3 p4
>     [    1.230375] mmcblk1boot0: mmc1:0001 S0J56X 31.5 MiB
>     [    1.233651] mmcblk1boot1: mmc1:0001 S0J56X 31.5 MiB
>     [    1.236682] mmcblk1rpmb: mmc1:0001 S0J56X 4.00 MiB, chardev (244:0)
> 
>     For eMMCs using MLC NAND, you can also configure part of the user
>     data area to
>     be pSLC (pseudo single level cell), which changes the available
>     capacity (after
>     a required power cycle).
> 
> 
> Yes. Extended partitions are a feature of version 4 cards, so don't have
> power-of-2 limits since they are a pure sector count in the ext_csd.
> 

JESD84-B51A (eMMC 5.1A):

"The C_SIZE parameter is used to compute the device capacity for devices
up to 2 GB of density. See 7.4.52, SEC_COUNT [215:212] , for details on
calculating densities greater than 2 GB."

So I would now continue to enforce power-of-2 for 2G (including) cards,
and relax to multiples of 512 for larger ones.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

