Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 795F4E9273E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 16:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaGEh-0007h5-QX; Mon, 29 Dec 2025 11:36:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vaGEg-0007gj-Ix; Mon, 29 Dec 2025 11:36:46 -0500
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vaGEe-0007yQ-VX; Mon, 29 Dec 2025 11:36:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpLzJmqD4xn8mG04ciYNjMu+4lKQdIYwaKHCCV3PhZaFUUrUdfZjz2kyC9H9+7607MAMuEujTBlwF6h/tEjEZ4v4KwhFrnPzACqlKUfCKdxHdLvmBmraJPQTCspxtWfjWSaVdehpDINd9iH5ZFes3qAJVU73KQg8PwYCEZIaP0XU8Uoqww/Y46K5MzlvS/P10osSIq2d+RDkiOQNJIDQekkbVI2NVmi2r4wn8+tfGp4wCjge32zq6bMULF7NizoHHc9vbkLx/K+H1niSSsEyu+sBmcwEZHrU5Mf07qWDZN49NPocorHMxvYjBbj0fZzUYFdlmUKKksgr/NcpzKi2Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NcjOMvTe/lcrbrtfe2XHk4rVRXZP7GspoWVABYrjRg=;
 b=OMGtzS0p/YmnfJiNEg30dRwh4fvL8gb6OVRMZV4DQPUgWUDDqh6/q0ymzpYJi5NaVZBzpzKePVGtsXSlcfMXQEZ4t9FDqsCEKSw7rdrvnTQzB7mzG4v41FT3mXj7dR7XldZh2CDbvBGI/9TF9DmuMnR5U5owZTjBrZ/rMGxuQXK4b+v4vE3oI6bnG2+FP/+vDsjD4aE71PVWqiP2DHZS08csO27lW2yxe+OYBbth9QqpvP4a0RvNmxaNNUZLNSjXjO/2fbT7FxWMlFm1DHdh9YxsIBXXDTp9sbw3GvrDvlxmHOkeLDLeSFv7ifY8M8sgMFGasw3b/pOjCHY+O+Lt8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NcjOMvTe/lcrbrtfe2XHk4rVRXZP7GspoWVABYrjRg=;
 b=wFoduGH9yx9DCkc2z8eNBZZpjWmm1PT1XElHMjX+Qmu18/DVXJr0deDWbSUVO1ecnJwnMZbkwRZXIEW/XSXpl7BWtwdFXJljwx6sys5P/ufG8wyXOzzQUfc4YN64H3aUxbXqvcZiRU+nc24+T9rmPaE2eFBnCtMs+CXp9oSztoL9IyxolxAhYHBqigXVee2sy+VJ2mnOt7ZwHDBWb8GeoytsoPBnYqZWUkvqp6Tn2/ICDitQYfplfEO9Q5+dpivYSqDbG1RRfyFZ+AR9R+QG37D5x12wiPmehOydVdSPgkwK/+5skWgaC5sSeYzNlthZhf8ppYyqyDfE7QRlBpEUfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by VE1PR08MB5614.eurprd08.prod.outlook.com
 (2603:10a6:800:1a8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 16:36:39 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%3]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 16:36:38 +0000
Message-ID: <8164d0a1-c1d1-4136-830c-9578ff33dc62@virtuozzo.com>
Date: Mon, 29 Dec 2025 17:34:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] block: create bdrv_advance_flush_gen() helper
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20251229161740.758800-1-den@openvz.org>
 <20251229161740.758800-2-den@openvz.org>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20251229161740.758800-2-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::10) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|VE1PR08MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: 528e1419-399b-48b4-255a-08de46f8707f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VW14WTRPcUdxendLaWIxTzlqVEVGRndlQW1TUnM3ZDVDd3V5TnpMbm5NL3Ix?=
 =?utf-8?B?ZEx3eE01bVNuL2VaWXFpUkt6OEFRZFJqVlN5YTVnWVFUTGZNVlVzaFZFekJa?=
 =?utf-8?B?dmJxS011cCtxdHFvaEdwbExYd3huT1RBdVhjK3BLMnJJWmlHMUQ1ZWIvd2Nl?=
 =?utf-8?B?Q3gvZE1BYUw3SWVUM1J0dm4zb1ZoM3gxYmFYMldJSVlJUnZabiszUDBLVEcy?=
 =?utf-8?B?L3BHbEhyUVcwMVdMMjd5NHZrZ29Yb2ZwRUVSOEFyb1M1YVdETXNlOGlvTTRD?=
 =?utf-8?B?S2hXdzhRbFdySXZyM255UENnQ1pFUTZYTVZKRmtWV1oraHVsNFNCbFBtdGlo?=
 =?utf-8?B?MVN4Z1VaNCtzS2tBWnNVa1VLSVZ4bENTWWdaSnZZLzlzSm1rOFVpcVM2WGI1?=
 =?utf-8?B?Mm8rbW5CWER6bTF5LzV4WHVDRmJLOUdsSWJzTjEyUmJLTGtxMlE2RTNDODdM?=
 =?utf-8?B?dVpZUURscnpJM3A3dFNDQW9UOU1BdldHZlo2anpQNExFZSt3UGViK0VncW1q?=
 =?utf-8?B?eFFPazVrVXhYUGdVcmgvQjlLazlZOXY4aVJjazhmNjlIbTdTdHhYcXlmekVF?=
 =?utf-8?B?VlFIYzJzVVp6TTd5dDhxNTIvV1BpTlRsY2VmZmdOTFJrTW5Mbmc4MVE4UytQ?=
 =?utf-8?B?b2gzTWhEUHBuMWVUcFZEVkJCSzR2Z2NhWlRxNmZjSTJFSW1nMk1ZNXpQdHBt?=
 =?utf-8?B?SEpHUTBWRWpYVTZaUTE4NzlRZ0RqclZGaG1JNUhoTmpkTm9KOUJ4UTBXRGR5?=
 =?utf-8?B?L2ZIVFgzV1FEM284Qm9FQzJ2RDhZRW1oRXU3RnRBQnEwZ01NaEMxRTlFbUxK?=
 =?utf-8?B?VE5OUlVLRC8xU0JLTUJaSyt1WDNOOUVOYUt1bHRVV1ZyTTJmTmd1MmJoSUtE?=
 =?utf-8?B?Y2Z2U3FNVTVVaTFLMzhtOElRMElocHNhemZBa2k0S2drdjZpMFpYS2U4ZmtW?=
 =?utf-8?B?czE4bHQrelcwNWRRb0Mra3pWbEZUSzNOdUIzTEtBSXgzdnlrMDlLTG9vYWhS?=
 =?utf-8?B?NFByUDM3eGErbXE1dzVNQWF1VWlPUTJZWkFTME9yQmt1QVcrQk12SFloNmVM?=
 =?utf-8?B?Z1UxNUZ3Q1hlVnlkaktyUUZNOUIxV0djTjVDckRVQ3JIa1dIUU9TUlRYV29R?=
 =?utf-8?B?YkZSRXMzVkliOVJTU29BY21xL3Z0TndLS2hjSmZpMDduOElTTm8zN1dpWlA2?=
 =?utf-8?B?NlRvbFhsZU9HYklLRTRqWG9MWDg4OCtSU256Z0I5aXBUQm1YRU5OY2JhYUNy?=
 =?utf-8?B?czNXcDkxM3M4eE5EdkFoYzRTUmRjUXZtM1NJSThVU3ZSTlIxaU5EUHNrMUVa?=
 =?utf-8?B?TDM3WnljQXVQQ3ZKTER2dlQ2TXFMd0FGWUYzUlVybC8wd3hlUm1zdktRM2FG?=
 =?utf-8?B?dTNpWFFPQytUaERpdm13b0taVSs3VkNIM1V0ZDdRQ2Y2STdCWkxrWC83OW04?=
 =?utf-8?B?ZGx2a3JXZFFUbnpzWkozbW4zWlNkd3kvYzl3Q05LbnA2c2E2Y2h4azd6MGxx?=
 =?utf-8?B?UE5JRmFtakp2emhTaytBMFhwS3dsdjZYYm5IeHVlMzNVVjNLZjdnd0FnMlZZ?=
 =?utf-8?B?WSt0SHRWaDdjazdoUER0K0JKRkN5UjdEdDR3NWlFSlM5VlU4UFdyTzhZbERh?=
 =?utf-8?B?SjQ2NEZWUG1kdklRTk1SdVVEMnNhWm5MR1hPVm1pclBDenFJSXlmK2ZLYU1n?=
 =?utf-8?B?ejkxaWxybmMwZEwwaTh0NE1MK1QyQlB2M0VvbWdXOXduMGxoT25ZZE41TDVZ?=
 =?utf-8?B?WmI3Q0V1VkVnT09wMzVOdEdKaVQyRkwySGJzS0FTOGNpMFJDWTI5OEI2R1Fi?=
 =?utf-8?B?L015dmhaVWVOZktIVkw2Y2FwOTllWm95T04xK0RjY04xa3Z1Z1NXd21aTDRp?=
 =?utf-8?B?MEwya1crTGwweXpPc3RNTHVFVEYvelFmSUlFbWtSMHZSbnYxVUZMbUZCUGVn?=
 =?utf-8?Q?VDW6pAqLTbcTc8rTV5XSIxpMNM1MuyvG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU5tL25ZcTk2ZjB1aDZ1MG9BbzAyMUtVUDJ1OWFmM0dINGVTckx0OWl6Mjdu?=
 =?utf-8?B?VDdkUHZ2UUI2Q0FHSSt1QmhYRnlzeHRkVEduM2FaUjQrVzBxcVo4YWtQNzFX?=
 =?utf-8?B?cjdYU1M1VlFKSkU3aUNrTm9SeHJWNDlPNyt4STR1Y2hTbWYxRG1HMTRhKzUy?=
 =?utf-8?B?Rlg4LzYzYk9NV2wvQ01zR1VXZzNwcU9ZWnMyTzFvSUZNT2hxR0N2K09KdGxM?=
 =?utf-8?B?N2UxaDNweTF3UXg4Uk5HTkJka3dkdXprN1VFeXBEMU9XZnVhVzJpMTFoc1hw?=
 =?utf-8?B?Mjh3RWxGTnBvTlJHemdFbEF4WDJ3bk5PRVc2dWVBWmpBdzZpUFZsQUJ2NEhD?=
 =?utf-8?B?bmdVVFg2THZTTEpWRHZpMDBiTm8xZnNLL0dCR1kxRzBWb3ZPS1Z5WDJINFJ6?=
 =?utf-8?B?K1Vwbzk2QWlCM2hsK0JVM3J5SHhJc0JUaHNEamdNaEllQ2xKNGtaaGoxc0gy?=
 =?utf-8?B?SEFFOStzMFhoVjFRc25PZHBOeXJIUzFrOGU0NGlLUEc0RzBOUzRyU0VCN3gz?=
 =?utf-8?B?SjNHcG4xSUkyT21XeWRxb2YwMUl2dFJKSE1LNVlOaDNtRTNwZVN4SURURUFM?=
 =?utf-8?B?RC9tK292dC9EdENVRWN0NUdDWENiTGFYZm9EUXIxUGlTNWw3ZWExbWRDdGIx?=
 =?utf-8?B?QjIvVkU4NTkxVWhKL0crRlB0ZnVKaXQ2UkZIWnhLZ3RHOVc4WnNhdzNxTitq?=
 =?utf-8?B?NVlBQVppMFdhdHVyVXhKcVcxWWsxVU1xOFN3VXNNUmRwOE0vVVpEaytpNDUx?=
 =?utf-8?B?Nzdra2k3MERTVDJORHI1NkpYUS9SZ2VTNkhqanJGMERzODEvYlI1TG9EeC81?=
 =?utf-8?B?YWFlWSt0dFc1M09CRFhsWU1RZzk0UHg4NU1PSUlnd1lrbnRENVM5RU9EMldp?=
 =?utf-8?B?bk1xV0RQQ2hSNVFpWmJFSXd6VzB4aXBLRGw1YlZabnRxS0NlNkFKMDZFRHZv?=
 =?utf-8?B?U3hxQ29aWHFONitZMDJOMjQwM3Zyc1FBQVRObXJVZnNjUWkzQzBSV0tLcE5B?=
 =?utf-8?B?YlQvZ1AxRExvbE1EYjdOQWJtdThERWtZR0RIT0twNGhUYVFjZzlUb3drdjBF?=
 =?utf-8?B?VkFMdlVqR3RzVlArOG1teW51QnoyV0ErUkszNFNFbEU5L29raWZhR0poanBt?=
 =?utf-8?B?SE5QUEY2aXcwWSsrOFl0QnFBcWxFYU8xT3NaRy92ejlOam50YnhPZXdlRTZy?=
 =?utf-8?B?MEl1bm1JYUlJWC94UkJ4SzI5K20zQUkzWnRHMlZGcWRTSjBrcU0rNTMrci9j?=
 =?utf-8?B?SzY4eHJqamFrUmxVanIvV1FacXllL2NENVU5MWNNcUN0dEE0aS9ralJ0azNm?=
 =?utf-8?B?Zkh1TE11M3V1aE53aGIvcDdJQW1BWkJmSmt1Z2E5MXJTbTJ1OW43S09JbzRk?=
 =?utf-8?B?b2szYlRRbjU4cXk1NlVsKzdWZ21FeEo5Z3J3V1F1eWNUVDRJYVIzaXVLaU42?=
 =?utf-8?B?cCt6L0hFTVRuQ0pXWGtWQmNWMWhPdXQvTkEzdHNzZ1dabEZNNEZtejZKVUk4?=
 =?utf-8?B?QjVpS3o5OSs1MTFUbzl4blZQYUpGcXFGSHpYb3l0b05sZzAyT29wVFdGLzJ3?=
 =?utf-8?B?RUVqSTRpRzZvRytkdUswdGxseWJLdmNPWEMrbFllSVhFTWY4OWR0ZzIrUGJt?=
 =?utf-8?B?WWR3M2lPK0tlTEtiTVFhbzg2UmV2QVdFcG1FVlNuMWk3RHdrWndkMUNzMnpn?=
 =?utf-8?B?cncrOTN6OEp1N2FWMk9tUXdCUGdNR1dwbWMrV1VKdmllcmp5dm1PRVlMb080?=
 =?utf-8?B?SUlFWVo2TkdLTStLNXB6eVNpaWExNDFBcy9rMGhGU3hGdy9ZSjcxeU16cHZS?=
 =?utf-8?B?TGNrcWk4ZCtTUDBheVZTcHRQeVQ4bHBocW0vMWVZa1lHVGVKWXNjcFJvS3lU?=
 =?utf-8?B?L0xSVVlvSjlSdUNDdUljMit2TDJVaWlIdlk5K1phbGhJRCs0M3hYZEdIamY3?=
 =?utf-8?B?WWF5b1N3bXQzVStIdmJndlpXMmJ3SlF3WW9nSVg0UG10NTMvN3hVZUl1WEJq?=
 =?utf-8?B?d2ZBa1NNOHRqNjY0bXBnL2xWMVdGek15R2xsWVVpMEhXOEVlS0VsQzQ3bVNq?=
 =?utf-8?B?U0pxWWZYYW56MDJWNFBYL2E2MXVGeTc4ZWM4VGxydU9tSkl1clppY09jWjZC?=
 =?utf-8?B?NXQySzVuTmFzZUJoNkdjMDFQMEx3R0Z4ckxsUkxMeStGMExvdUxHUS8vaUdC?=
 =?utf-8?B?MExxZHJTdU5YaFBvVS83Wmo1S0F1SGJ6MjZHeW13U0dBT1BhT3o0blVoZEQ2?=
 =?utf-8?B?TmhWOXJDZUw4T3g1NENMaGJoU1d3alhHQUkxajR0UERwSjM4WXBJQmFBb2Fu?=
 =?utf-8?B?TVpnTzRTZ1lSRVNiNmorTnAxakJJOVRTS1NLcWsxQ3hWOFZJQ0d0MDExMHIx?=
 =?utf-8?Q?zQQSaMYVbXElC3Dw=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 528e1419-399b-48b4-255a-08de46f8707f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 16:36:38.7658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /azyVV9Ov6BL8ZwQgdO99j6o0IlBcLe/nVGv8Yq2qCMMwnltAWPZOBs0eiwEx9OLzG0fSeJM3odIttpha3XUIeSVfUj+060kiRNagS8cxng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5614
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 12/29/25 6:07 PM, Denis V. Lunev wrote:
> The patch creates helper to advance flush generation.
> 
> Right now there is the only place which handles bs->write_gen, but this
> is going to be changed in the next patches. Unfortunately we need to
> precisely control the moment of flush() when BDRV_REQ_FUA is passed
> as a request flag. Generic processing inside bdrv_co_write_req_finish()
> is too late.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> ---
>  block/io.c                       | 2 +-
>  include/block/block_int-common.h | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/block/io.c b/block/io.c
> index d37da2e0ac5..f39ff862c11 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2147,7 +2147,7 @@ bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, int64_t bytes,
>  
>      bdrv_check_request(offset, bytes, &error_abort);
>  
> -    qatomic_inc(&bs->write_gen);
> +    bdrv_advance_flush_gen(bs);
>  
>      /*
>       * Discard cannot extend the image, but in error handling cases, such as
> diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
> index 80c54a6d09f..67552463dbe 100644
> --- a/include/block/block_int-common.h
> +++ b/include/block/block_int-common.h
> @@ -1373,6 +1373,11 @@ int bdrv_check_qiov_request(int64_t offset, int64_t bytes,
>                              QEMUIOVector *qiov, size_t qiov_offset,
>                              Error **errp);
>  
> +static inline void bdrv_advance_flush_gen(BlockDriverState *bs)
> +{
> +    qatomic_inc(&bs->write_gen);
> +}
> +

The name is misleading.  In bdrv_co_flush() we're comparing
bs->flushed_gen with bs->write_gen.  Here we're incrementing
bs->write_gen. Did you mean bdrv_advance_write_gen() maybe?

>  bool cbw_filter_present(void);
>

Minor issue: patch doesn't apply cleanly because of the declaration
above.  Probably was committed on a downstream branch?

>  #ifdef _WIN32


