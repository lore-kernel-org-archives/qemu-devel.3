Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA92CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 17:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waGzu-0003I9-Pr; Thu, 18 Jun 2026 13:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1waGzt-0003HC-21; Thu, 18 Jun 2026 13:57:49 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1waGzq-0001A5-U6; Thu, 18 Jun 2026 13:57:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g76YpKV14qF45AbiwM0w/s9PMxwgrzs0e/UWVd10vfuphwZaPWcE2Vgda1GFMLrA1DgNfTsr1GApy2Jv1YxLKkCwjih6db7C+sZn457dJnSdc98slUxSfxZkmhN6JQXV8to0nm8Ha77O8uQe5GeoFrCZvLxpNsFAawOPX9f8bSJHP4SrN4O9DCbQYgJHLn7/SBP82ccTsUc69rAf7/dDtJReo+MSEgXmgZvazK+nIlL4ACtewMryyQjAEblQooHaBRRSdkyPbla4+c7IY2B/nVXemaE4h+YKrSH1XKZYbS9BvRnh5vn2ecf1HRk/wD423p96w//4qVRkEvADU9znAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LQN3trPcR9WP19RW9bcVm+AEzDktiei8K3aECTMp0U=;
 b=OAF6IMpT2pTrU0BGT1TVMwUTzhb+/kvDsY5y83xqOPMUnmxrA7O/EC88xcvyhMexrr9LuB13ssJNw3Tn+fwY/w78UAsIzWm5yMbYbza4iixeHFv73dZkLiWt44WzUgYEd4ygUNA+w/GBo6Tv+rSelj9i7zpGBfCmyTtWAQJ5EMrN2RfekWpLlJUl/e4Jcivv4LKHNmCma4DfVu3hIpIChHDAGCgw0EoBCGF0oYwC/b3lPGFpdDBHtpJoXrsxm/pXFcPlCoBuXIp/nV8cuJ+vxzXhWXyI6zgwPW7jzK3E9PVy+uW0i3yux9ZN3Q9yN0PLuD4QuE47U4Do83b+deIyQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LQN3trPcR9WP19RW9bcVm+AEzDktiei8K3aECTMp0U=;
 b=viM3o05nKkqvFLV1PX1m4PYhhC21j3ua2OzMnJ7UPV3I4PvMal4U88H/Oj4bgp1m+H/6iuqB/eqbaY7w9oTjiy117gca4ZVQ3sG9YTxrKIZtyB/bb88HrfB2lrlIxvICIxhdZ9hxGjSyHvp5ov4y77ldETpytjUUpyO9+9lnb+hHrw5I/Vagx869jsRSyb0yr3ZNjrHJPNbweN0M/n4jNZN54fzAYFfxfmao023zuLJTRECYqLit1OE0o77rE9cTjb2FXgXo4jKkhtwKxM+83Kb2BFBRPv0YX9baD3ZZXQOyMKm9dEXZSfMutXQpPcBS98Ce3pcdcyn4MVgJQHSFwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS8PR08MB6232.eurprd08.prod.outlook.com (2603:10a6:20b:296::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 17:57:40 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 17:57:40 +0000
Message-ID: <39dcf93e-7c83-477f-8676-f9f44f7974ed@virtuozzo.com>
Date: Thu, 18 Jun 2026 19:57:39 +0200
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
X-ClientProxiedBy: VIUP296CA0021.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34e::13) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS8PR08MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a1c5868-087f-4ada-ffa0-08decd6316f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|23010399003|1800799024|18002099003|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: yw1xR+r8046jrxTLrfnZVIV7lcqOXE+26CppPBeFi78bsg0VXkXRntxHZarTLgYB8ZNUFdwH/aJ106t6Ydy/duPklBvLgYleXGc+ymFo/TjKBWpKV84aTbcG9DuEPknZNk2xVQVsP41qLwM5x4v7DvyGPcwQ6B2J3y9mBvvCbUUNDhtWQO72Wrx26V3q7zH05IAYWJLDw/cOy/KSsj+ZFvLu9s3Iq8gkeTrL8Pr27BV2wG/tRHxwXcZGdPfLjtL8hyQGEAkQsxddX0o4xwCqChKv4mkmqrUeGaJsPMV5yoJAJMa5EBeHjrNNZgqwcAlAVNkZYz0rUoW2TrkQcO6j8Y0l4W6cWYqjM00JNJf0ahAAB/gy4rpEjGf4tTdzXuIfbFUKWcPtJaZM9i0P2yZDNjXlNhtZs4TMhr9cUKqPbJB0+vr0GgvnMESXY0PMFy5I49tqtI0irPd1bsq4M/RqQCZHxychm3KN3ENDxA9fwa6qRvF99gpKFxVz7LO/8UNOgRk0Ii4Jc4NEixGzXMmGmuzDRbqj0KrF6KDGScGdWlUJuPBbTyFaiY5Banfice0B7SVRZDdTohkc3gblawu/frD2Bj4htIrvAURICqOvGZbQiNqpf2rdGK6lKxqOUpAjvH7tKGhvr2ARSqmerGEHli2BOWKKm4OodStyf15BN0tGvhtnc1vUXlTPDloirrx6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEdneC9lSk9aMHIzd2MrTjlLbVFuTFhTRk9ZQVVuVUpiMmh2NFJIZFVoM2hT?=
 =?utf-8?B?dWdDYTN5cHQwcDVFNEZzUmpMWm5RVWtqdmFlQVVsUk5YSEYrWE9YVzVuK0tx?=
 =?utf-8?B?RFZmb1ZCRmVnTXgrS2RObUxia2N3ZFc0NXBjTkFxVEtrcmpVN3NLeGp6TnV4?=
 =?utf-8?B?bzFud20wYVBnaEVUSTdrL2tQQWxPSnllemxTeUZvVzgyMWdiZ2N1enVHSE9O?=
 =?utf-8?B?MFR3dVBiS09JWkNTU01QcGNCcnllVDZacWNEeUFaTEE5K3hYVmpWRC9SK3do?=
 =?utf-8?B?bFlvdlA2cEVVYXZ4eWZBT3hON09XY3h4ZDhGSDF5TXgva1V0alBwQjZvRk9j?=
 =?utf-8?B?WG00cVNxUlNuYzRUb2JidFB0Q0tkOE1SQUZBQ1Z5Y3Q0eDMvOC9SUEM1emJU?=
 =?utf-8?B?Qk4wb1VOTUt1Tnk0ZmFEazhxMnZSWS9BTTdEcTZ2aHJvblhhNkQyUGpOL01R?=
 =?utf-8?B?RHk0bEhQZlMyS1dXczdKdXUrK1F0SWdydm42K1p0SmdEeEJwbzhOZDlLalZO?=
 =?utf-8?B?WkRoR3AyNE0xRm43dUNGUHFhWnp1MXU3OVowK25tVFFSZjd1cjFtc1UvRmRE?=
 =?utf-8?B?bWliUDhTajROZ1l4dXYzdmhCYVNMYmc1TVRoQnY0YzBSWjJZWFJ2akh2a0Q1?=
 =?utf-8?B?VHRNS1BBeXNsLys2RzhRc3k0UjhwM0lES1NWcUJHZHB6T1RhM0NaKzU0cXpx?=
 =?utf-8?B?SFNxcXIyTnZndi8rL2tGWDd3Q2lOVDBIdThlVXh2ZHVjZk9jNDZ3N1ZQdUZ3?=
 =?utf-8?B?RkhoREFMcFNKSE9TVGdhS2dpNlUvdGlhRWU1UW16ZWt1K1hmcDRBWmJmUmY2?=
 =?utf-8?B?YU5La2FMdFhLS0c0VDFNT2JDTDk3WWsrc2VESHl5SGpNaWxuU05GTXl0b3Qw?=
 =?utf-8?B?WmNVazFobjZRRmh1cXZxbGw1ZU5sWHU5UVF2SDRzdnRHSXg5UWF0T2V5cEpq?=
 =?utf-8?B?T3pBT3RHZ1FUKzduYUp5Umt2bXppbzlBbUV0MkljMUorQnVJd2dJZXV1eTZh?=
 =?utf-8?B?M3B0Mm10dGlTL21uMkpJUUJRcDdLcFBsay8yMnp6bTBNVXVJcTBlTzNBTm1R?=
 =?utf-8?B?cFAxM2Nhb3lPYk9UdTNQUEVDdTR5VDFNNjhOSEhNZCtCTDUxdzRIODQ5RWNK?=
 =?utf-8?B?b3djdzQyNDgzTDYySG5uNWg4OVBXd3NqTDBSZjRoZlZMaGxCOG85SUdTd0Fu?=
 =?utf-8?B?YXBOczFoYWl3aC9JQ1ZZeTNwTjhnMzNHYWE3cC9EZjBFejhKS1QySEpJZmRW?=
 =?utf-8?B?dFRwOTN6c01mK3F0MVN1VDlaSmNqSmZ5ajl3UHdzZ24wU1hYc0tLOUhaaVQ5?=
 =?utf-8?B?ck5ZenNRK0dNUUt4OUxacG9JSTlRVFBMTGtkV3FZczVKbHZpbm0wbkhMME9z?=
 =?utf-8?B?OTEwVCtsbE5ZTEt5eW1JT2FkMElhM2ZJNFlTQVc1Q2xXTUo1T3g0Y2VWT2xP?=
 =?utf-8?B?ZkovQWJoVGE5aU5KU0s2NW5IMDcrbGw1TjdMb1ZrcVVCUlExUW15ejBrd1R1?=
 =?utf-8?B?STR5aVV0amk3WUN1c1F6dVhPWGQ4M3BaSnNNTXNobm1scUxPNHBaUnZyc3Vq?=
 =?utf-8?B?cVVQTytjMVBJQnc5Q0JhY05SQ3YxN25KcU5abHNGQ0ZJMmVTQit1VHgvZmph?=
 =?utf-8?B?dzJYdHdvK0VlRU9QNXc3YTF3bnJOLzB5dndGb09wbVN6SWhldjZOQnUzc2FI?=
 =?utf-8?B?ZExPSTBLZE5Gd3NkejZWYzF3Ulh2MnNPYmNhb2ZKR0dLR2RWM0xsaHhodXNh?=
 =?utf-8?B?Q0xsNDlyYVlRVHVLd09NeGphelRiUm5pWDV1Y0pPM043UnNBekt5TEtNVUJZ?=
 =?utf-8?B?RGRydXFjZFZzYkNGMWNRaGFXYXVGckNYOXVYeE9CL00zUHBWMnJvemFFaWZD?=
 =?utf-8?B?VHF5cnVrTUdFUDJGOUNWNTJWWDkxeFNUOG9tQVk4TVNKQlEvaUQ1bE0xVHJh?=
 =?utf-8?B?aHc4QmFXU0VqYVFCbHRaOUw3NWRtTlZvTmhIc2VCenZiK0FlTkJhYXUySzZa?=
 =?utf-8?B?Z0V0QzBQQlkwS0pBVFRQeFkxcEszRGpJTnZkRldqZXd2a1FDT1B1ZUZOUTUv?=
 =?utf-8?B?bmVSYlZZbVA4cVdnUnR6cUdINXFVUitpVDNGLzVGRXB3bGtZd3ZDTzFnd3hi?=
 =?utf-8?B?SC9ua1MrcmRVa3VSNkt0QUdLSy9lNmhzLzc4bjVPeUlOYWJaMWVLci9jcGgy?=
 =?utf-8?B?a21KOXZPTVN3V29JdC96TWpDcFJ4UjJ0aTJTR3Jtcm1VU3doVitDcEJ2Z2d3?=
 =?utf-8?B?dysyY0ZSaWZxZnZNMUc3b1JvMWwxUncweTNqa2ZFSnJqTXNpaVBQUys4YVJh?=
 =?utf-8?B?WDIwaGh6ZHQ2N2FpQlBsbjRyMFVVT3g4bFdkY1ZvYmRsMFlEYi9heWJEb2RI?=
 =?utf-8?Q?KvFb5Bkc8nevG6eC8n+y7Pa+x5hK2OwVJzwSd8K+bX0DC?=
X-MS-Exchange-AntiSpam-MessageData-1: rRpi/eMquAegaA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1c5868-087f-4ada-ffa0-08decd6316f5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 17:57:40.5963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: koKKMeuZMzdcfR4qpGs41OH1mrxOfRGBbiS4YMQ5+x4jLpYflkc4T1xqsNbqU9RFTpyfrHEEKwlDjHIFdM6Eug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6232
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=den@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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
ping

