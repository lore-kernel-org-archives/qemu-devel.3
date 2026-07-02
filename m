Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FECFC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 17:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfLVc-0004Yi-1I; Thu, 02 Jul 2026 13:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wfLVa-0004Xa-7q; Thu, 02 Jul 2026 13:47:30 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wfLVY-0004qE-Jp; Thu, 02 Jul 2026 13:47:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OiKIl4j2EAyY9RdP/BTR+S6tVRQI1Aj3aysA2r5ylFyybPMGqVnY6Tyci8e/0zwTeHq0qVNnCh+7Dyz3BryL6wMrzHwZ8kENz2CBrfUpOZ/M01Kwe5/7zItzKQjTJ8CahGcmEJWVlQHBP6CiOGgFEwguQnSDnNA7UZLRn2q4uptsSMgbulUjAShQ8/N5caZPJb57fcCAOB+KtwO6DG6/5Vd2b+tGnIQmy8QR/bEhi2fw1wPJTRJywUcYBREiR4oonuuvb+DCBMc8prWp9MGuhLbbkm0JE2sLYQWa1/39Le79jfVBkTDo4NcZELFrHWPoJv+qySOBukMSGFUrAyfHLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8feUmP7CP+oFsatqA5YpPN+39ZKOhjKDiD4uw7Cmno=;
 b=RQ3wErAd9wzevAD0n1kc96IKcTkWnhnn+tRLUvyMfxsGUeFiJOwrjktWsOS4FaqApNqljPmXoZbG+s/4wClu7BG5e5m3u75RLa6hSuqviFoYYrC4F2D93UzWYXm+OmtfSTjoiAYggCd40xkMXd11Mq34UQQEqQNEvULjr/v3aIMiTA4HjV2uRzU9yItvU95L+EkzcsIdT8qQJ7VJay3JWCiof/PR3ic55VZdsSqodFZCs2aLXU3TcoADTTRrhITQvQmayxjDfFoNf27Z6GBsB2vt3Kf0ZvVDEichW3bdficAkiztVMXvAV0TBGNRgQ83uNkX5S5e05jkmO9F7FZg6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8feUmP7CP+oFsatqA5YpPN+39ZKOhjKDiD4uw7Cmno=;
 b=v9DCSLWv0D6KjdpBfBl31LZITyu99EiBYdtvSTVTEYWtNa3tCTskE4RUBJTyNeznu9kkBI4hPpICEfQxc2HoodgKRoxIEYWZz0WvWqzp4pfBCwb7undIfaeTO+UNNEfhlLy3T9iNbgZh/11OzHQ7Y4JWwVHVSMFcG4XKcWYeEJxnqQyTQR7rD6UiiGheH4alPDQmV9x3AkgfDIjKxKEsFaofF24j46HPsbGcPT91qPLpQEBpPEbfElX4eBJPr3fJ2Wu1SeVJGa+0Qk/zafPD1mZonODvKKOno0DP/JLb1yOrWOu+XkdRYHG8prP2NiRINinMzeSupqDsGJFFxKuZKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by GVXPR08MB10431.eurprd08.prod.outlook.com (2603:10a6:150:15c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 17:47:24 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0181.010; Thu, 2 Jul 2026
 17:47:24 +0000
Message-ID: <e51d2907-ca2e-45a3-b270-7d20e31f8d48@virtuozzo.com>
Date: Thu, 2 Jul 2026 19:47:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1] coroutine: fix lost wakeup in qemu_co_sleep_wake()
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
References: <20260610115850.2410566-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260610115850.2410566-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0050.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::27) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|GVXPR08MB10431:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc0907c-ec4d-40a4-1a6d-08ded861f99a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|23010399003|376014|1800799024|56012099006|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: 9ZEVUeKdpa0gsDw2f6Y4gh+9E1ZJiNWQQGL7Z+9AOcR6tSadU9RM4NGwgniyZnbMX0mdswF5AUQsG82Tqoyzo33q4mgdGz8HNHoAndSJe5GUskQxq17wIEgoV0jTmMEccg0X/+x4WHlvbwpM4HiBNG7Y7PmVVWwtraZaOK7yfDX5GimpaFmfyKFjND/Lrn/PTzj0Z1sNpjXaV475LyjLYP65+sgs4qGkqKKEmhVzR7vWchffuqcXeDkBLYyPiyqP25WyE6KoD83xpgiM8asUrI2Esw8OcWoqG+qH3eao06upTA3U/4wkDIFGZyf66Py/HYZfcYvyf33afKcY60xJOeLrboT5QKEEDggAvLA/+kI2hDRpA+elcOzSr3y2a9cOjTEsWGtdA9f+UdLqz9RwEu5d9P2CmJfyoCZx5EqOmdRC4bxxLtJ9d5TEzQ01j/m2skKFqx1T1FpBNb8ZR4+cqqjG6CAQ2rhtSVDwJd1YKQMxxLeh7NY9h9ei8Wc1NJD014J+i4FZkp8PjMkHTa40vej1XkPmqGUvkb0uujxxduKiq2AAv5ZIZ0badmYMvkkricVK9VLGG40Exe0iwq5V6MRXM9uq+4Ztq8CBf8+Hr92/TN6XcsWUDslMiFytQpT8GCs8ifuXqjGJPGXN6q23LwSgQ1R1aAIpoEBKJ2UQ9cs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(23010399003)(376014)(1800799024)(56012099006)(18002099003)(6133799003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkdaTDVyOXVkdTZNZGI4VTA3ZU5MQUZ4UnRabU4vc0xhalVDdWhWTWVlR1NJ?=
 =?utf-8?B?cXFSTjI4cnBTU2xaV3F5Rld2Z2pocTkvWTRJSTR2bWwrUFBTRm8raUw4N2FI?=
 =?utf-8?B?cDh6UW1uMlQ1RVpuMXhibWxjVEZlMDIrNTNYWXk3TlJ6RXZlbGJaWWxacWlq?=
 =?utf-8?B?YVlFRjNodWpsa20zVkI5TzBUZ1NlOGVWM01Za0djeFhPMzFZMXUyQjhFZldi?=
 =?utf-8?B?aHFPem54ZUF6cytmU1NTUjkrVFNrYU50NzR1SkQ2UEhDRUp1OWpNS2RTSGJt?=
 =?utf-8?B?QmpMWUtsLzZyOUpNL1I4WXZ2RXd3Q3hWRUdvL2NDZVF1UW9zWlc5Y1hlV0U5?=
 =?utf-8?B?L2pyRW9xYWhuNmpxb2oyZWdxcnFxUVpuak5OMWlkVWZENVZCcVd0QjEvOG5q?=
 =?utf-8?B?VTUzQ0xoTG9wZ3l2dGo5cG50UWhmWXV5dkt3Qmo2NUp3MExLd1J1MmhTWjZZ?=
 =?utf-8?B?S29kbVpWNjF6U0d3NTlhTnhuUGxyUnI4VkRrNnZtTmlkbm1zT1JZVlIvcE04?=
 =?utf-8?B?dnNxZTE1MjVtb203YmE2OG9VQWliMm1yVHUxTUhZM3pNR3QrM3ZObTdOZVdq?=
 =?utf-8?B?YzVZYjBSeU8wSXBUYkZRakNXZ3ErRTk0eHNJTWpLTGJncjFQRkNscUpUWEF2?=
 =?utf-8?B?S0gyNVJSeElPSHhlNHlLcHdiaEw0K2s5aGg5Ylk5Wnh5QWU1WENEVWdrbFlp?=
 =?utf-8?B?KzcxbzhhTXlibGxVbFVnOEJPOG1jRys3dzlTTlRJMDRTUGljY1ZRc004NUph?=
 =?utf-8?B?M2ZwR2g2ckNwTXlCcm5vY3c0MlhoamV3Zk9mK1FJTXZsSTFPOTJGTHVLVWlp?=
 =?utf-8?B?NG5tN2N3K3JZUkxlMzBWQXBrZE5RUW04UWJiOThWNXpKOWpwNkhFaklrU0dX?=
 =?utf-8?B?YXQ4WVllQnk1TGZsV3pKQ1FzYzRyalo0cDhkV0MvMnV2dEtTa2tpRVBQM0d3?=
 =?utf-8?B?RjFGL0w3bm1lWlZTTWZ2cUMyb09CdkpPZzhlRnJYQVFsSStzVmQ2N0wrSUI3?=
 =?utf-8?B?UkYrbHNHRTBGZFhoR0xDSzI2U0pqQVBKYzhkK3ErbFlnNUhXOVVMcXp3V0JJ?=
 =?utf-8?B?UWxUM1l3VEZhcmVHVEF5eFlIeTJzQldUU0g0RzM5cVorVnJRV3hIVW5QUTBm?=
 =?utf-8?B?QmVHRmIxTVVOWVpSS3Irc3kybVdqU3lmT0gybWpHQWdNTW5ZeWlPRHRpNE9Z?=
 =?utf-8?B?MGJIMmErcDYwRVpUYXNlemR5RVdZcGp6SFBaVUxxYWc5VkNxd0R0YWpUYmdr?=
 =?utf-8?B?Ym1KRERFRXUxQVVkV3M5dUE5eDhkV3B2eDdnckdhRzZTMDBiRnoxSUliZG1Y?=
 =?utf-8?B?a2ZMcnRBajZtVnFHQlZVVml1U1JITHZpSXFoc0QzM2hsYVhIQmFVcW85YXBE?=
 =?utf-8?B?RHkrSHl4MmU0WGIyaUQvVTdQUnRtRkdCU1FLdTh5c1pFMFhsQVR2RUs4Mm1S?=
 =?utf-8?B?cEhsSzZOblVOck9PMDdKWHhwczNZcE83K0dTOGsva1FxVlNyVmV3cEMyd2JN?=
 =?utf-8?B?Tjg5Sjl5eTVLZVZ5cXFuR1QwZHZsWis5YnZNVUF4VGZTZ0lMZVNYd0NLMkJz?=
 =?utf-8?B?eUw3SG5zTy9SR051d0dieXBQRG9zb01uZW9YNWhwNkxCOXZYc2F3TWcwNm5O?=
 =?utf-8?B?WEUwdktOTDNEUWRibTM3SW1VTWx4VlM4YkhRb1hPYkR6VVdEZnVOaUpwYW9k?=
 =?utf-8?B?d0JYTUtxbldjeUZ1elRaeFFQc1hxTVd5RiswVDFRclJuMXdQZ3JzTFJrNGE2?=
 =?utf-8?B?MUlvSU1kRXhJK1p6M3p5Vk5oS1lIbGJpbUN2TmduV2krSHBtNXZNb015SFRv?=
 =?utf-8?B?Qk1USG51N3ZpMnhvaWJuOWVaNHl5TGFxbFRRUC9SdFFMY2lmOU9UaUlLUkpq?=
 =?utf-8?B?UDJEOXN1MGEyZ1RKVHp1L1FXWDdLZzBNZEh0djEyMGdWMzQyazBkV1hjUXM3?=
 =?utf-8?B?VTYrazU2S0k4MVdHcWpBTEpHRXIzcTQ3QWl1Sy9xb2xjT3QxWnNCa0cvaEVM?=
 =?utf-8?B?S2Yxck1NS1dRSEd6ZFlCVVFyMEpsRXphU3hXa2c0dzF2NkppMG8vZVczV1NU?=
 =?utf-8?B?RnNidXRXZ01mWkxaVFp4WG9BREdyZG9LMXlTR29maDh5V1owSERDWWhSNWZJ?=
 =?utf-8?B?a1dUUTRXelVWbno1VXZ6R0tReklvT3RCdVF6S1FzeCtHVlFtbElkdTk0cFM1?=
 =?utf-8?B?OFJJRVJYOGlKdmNEMndPVktZRmtOWGdNeTk5MjBiamJIbWgwM0drejFxblp4?=
 =?utf-8?B?a0g4dDlyaERSK3kvNlVZZ3cwRHFqaStvNzVpU0J1THZGYklic05YcWp0SXRB?=
 =?utf-8?B?cVp4emhEdER1UUhyaEdhQzBleWZDT3VFcHBvU3cvek42d2NndmZ3cEIyQm1O?=
 =?utf-8?Q?e1yr+tdOcRI/hL8HdLRPZSQiWtQu6bo+14OVY36PvQiIe?=
X-MS-Exchange-AntiSpam-MessageData-1: fo44CA1gwITvRA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc0907c-ec4d-40a4-1a6d-08ded861f99a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:47:24.5414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snooJQKppIIutkzMOI+2Jfyp4X0GA/X8vUPNRJEEsZ6QxpuJ0IKKquPAVSW4hKiUTxIDLFAGd2/Ki8fNhYzskg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10431
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=den@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/10/26 13:58, Denis V. Lunev wrote:
> Changes since v2
> ----------------
>   * Drop the redundant fast-path check in qemu_co_sleep(); the publish
>     cmpxchg already consumes a pending wake (Kevin).
>   * Add a deterministic regression test, no threads or timers needed.
>
> Changes since v1
> ----------------
>   * Patch 1 (graph-lock) applied as e3082ab3b3, dropped here.
>   * Fix the qemu_co_sleep_wake() primitive instead of working around
>     it in qcow2 (Kevin).
>
> Problem
> -------
>
> The qemu shutdown / blockdev-close path can deadlock permanently on
> upstream master. The main thread enters ppoll(timeout=-1) holding
> BQL, no other thread has a wake source that points back at it, and
> qemu has to be SIGKILLed. The hang has no timeout -- it is a hard
> deadlock, not a slow operation; behind BQL, RCU, VCPUs and every
> iothread path that needs BQL stall with it.
>
> The race exposed in qcow2's cache_clean_timer cancellation path:
>
>   ppoll -> aio_poll -> cache_clean_timer_del_and_wait -> qcow2_close
>
> The race diagram and the exact stale-state read are in the patch's
> commit message.
>
> Reproducer
> ----------
>
> Environment: 4-vCPU VM guest, kernel 6.12.x, upstream master at
> de5d8bfd61. On modern bare-metal the window is narrow enough that the
> hang rarely reproduces without a VM -- a VM guest under full CPU
> saturation is what makes the timing reliable.
>
>     # reproducer
>     stress-ng --cpu "$(nproc)" --timeout 0 &
>     for r in $(seq 20); do
>         timeout 120 ./build/tests/qemu-iotests/check -qcow2 iothreads-create
>     done
>     kill %1
>
> With `stress-ng --cpu $(nproc)` the race surfaces. With
> `stress-ng --cpu $(($(nproc) - 1))` or without a stressor it does
> not reproduce reliably across 20 iterations.
>
> The new unit test reproduces the same lost wakeup deterministically,
> without a VM or a stressor.
>
> Results
> -------
>
> Same guest, 20 iterations of the loop above, master at de5d8bfd61:
>
>   without this patch:  reproduces reliably (qcow2_close in ppoll)
>   with this patch:     20/20 PASS
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Hanna Reitz <hreitz@redhat.com>
>
> Denis V. Lunev (1):
>   coroutine: fix lost wakeup in qemu_co_sleep_wake()
>
>  include/qemu/coroutine.h    | 17 +++++++++---
>  tests/unit/test-coroutine.c | 53 +++++++++++++++++++++++++++++++++++++
>  util/qemu-coroutine-sleep.c | 53 ++++++++++++++++++++++++++-----------
>  3 files changed, 104 insertions(+), 19 deletions(-)
>
ping v3

