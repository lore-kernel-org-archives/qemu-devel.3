Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EAACDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 23:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wctQ0-0008L0-Qn; Thu, 25 Jun 2026 19:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wctPy-0008Jb-DW; Thu, 25 Jun 2026 19:23:34 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wctPw-0001x8-Si; Thu, 25 Jun 2026 19:23:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTlmW2COwwhFGaPJCA9pyr/QcLp2Dr3/CXy86SeAZuHIIJjaT+J+FWok967WxF2tD0SOl8YffNGxiZcQF8vZUKGol4Jc1VMwq1P0kCgjMR+xvBkoOymC4XI9JFrq5W/qJnvF7sn8wiyWlPslm5xt9rjtMm3b5KA36mgjR7N6XyUNVrG/FubWcYWXOxzztLNGpFOWaA/c6aSD6P6+PGPnpiVVLaNAHbYAu/hPXltbOkF1cdhp7mQV3y93LJdVQXqmMpMPUNV2rHEAJxVeVLIGVcpzxWCTwjAAL9wGdJYaoz0R1kXLj12UZequ0hAeigZit72s8nFPCbdDG1sn3Cj5GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDvmUnNlLY+9vhGPunkD0aKSlMvE2Rj0sZKjUQlEiAU=;
 b=C+wVt76fnRZAdydY/TxiM2mt0w6QpiTz+P8igBLOoNxagHIkhvhFTk0eaHon1wwLtiw8W/U59te3X65YSgLAhxZ0bSF08iwco5D2NMNOgXQQsknQUWAvTx++ZPOT+CAQ5T7XAy2MCoFtFg0BG3iqHDqstsLp+PXAaF8G7tuL3d7FN3k93H+DP7yW2IufrhB6j24Zlnq9ic659LXNmLRy00yQR/KDtf5teo4c5jNz/8/cFM7CtDCxl4+6mYB+haDOr4S6uNW8LHYwKD5ohOPdHYq3Z+zwJ0T09oOB2iI7a/0gDoR8UGGSwDjCJaZXUEYHUbiEtBKMjq7Oou7etR8uRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDvmUnNlLY+9vhGPunkD0aKSlMvE2Rj0sZKjUQlEiAU=;
 b=tVssqfn5wxB4AvADlFVifEKdZXOYSxBGcaNkgcmS9WJMCmOcmVXs/N/rV9DDZrsPACciA2Lm9PaMfaFQA7NZ/APvfyljoaVDayx3a+hHtOg1mPSgctJ3JqKkekCmpUM74nXavbJ78j01n8XKwEmwFbcXknd8kHXwQ2I4yq4g+GTiVby136yuyXU+/CkTmohnBPxkOfFwNnWGo6eawFFw+gyc2/gKVkZt5mMDx41kEk+Rc2xOHwRy4bMdtu+Kxmx50piQ+gUKt6E4/wm5gGWKyZxH+MRBv+4py1vnFM3ugB8L9HMKQea7GtknpurQm6+NPPnUdCdv5DvBdskpQZkrdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS8PR08MB9528.eurprd08.prod.outlook.com (2603:10a6:20b:61c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 23:23:28 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0159.012; Thu, 25 Jun 2026
 23:23:28 +0000
Message-ID: <db081d5f-9c04-43a2-bdda-4824f23f51ae@virtuozzo.com>
Date: Fri, 26 Jun 2026 01:23:27 +0200
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
X-ClientProxiedBy: VI1PR06CA0215.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::36) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS8PR08MB9528:EE_
X-MS-Office365-Filtering-Correlation-Id: 30eac839-56ef-4d39-5ab2-08ded310c393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|10070799003|1800799024|18002099003|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: PjUpo8nA6McXvt5xVDSWCrzTHfNwPVIndlqOA7F4nd50AL3JTj2IKre9kCiX7InDQMR837vT3EjwYWGyuS4B/WXOBTyEnS/fsCWQrrS+GPIkk+XONjKBtcE9J5rD3rGdMfGtm6nENEjWC/p6oCFeht/ABE8msJnbtcJ6eoOUxFizLGwRxEo22aC/D+BW1Ijenhx4TjxyiAW+2WLqMJ4xzm2URb9FqYzDEyvecxmpdXZlI9J5enOiwlfPDsdbPKnguQO97TLGoatctgwKv2kFcCt4KtbPnAzGsluFlUiXD8AuDwpYLKFdAtIzyjsTmZz9VjiPb4yu9yD+BS/4i6DU1UXWXHZQwU6yw3PrcqXRiUU59WK1yk5wzpLq1H7WGxC/PZGD3eOrwcyQA7+A0UZm9w5yq53ADWc81Qrax4x+ZNCpBf9ZsVDexzcseB3elceMr5ypL0D2dhSMmAMO7dWDttF3qkU0Vkz/I7lCTV7O3Fp+hy5emVtXQWmKE2oklK96RdMl8ZUAhHmtHHw5IJYe/Py7TkYehd2E6iluGB5u8BiqtZw+souMpbSkg/TQ2CINptpPmjDFLdkmMMqPK42hUCilQtx3o9kV1Qv9SCMfSkkS9B87Wt6CUJ4zuOuVXf+X6JkBBIgJptHW8pbrEvs+TcFVUhwmsumwJzed6HqRegM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(10070799003)(1800799024)(18002099003)(22082099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVNlVzlyNVhPaTRVMU1rdVE5bkI4a2IrV1hUNXFwcTZRVTJTNklFU2k3TG40?=
 =?utf-8?B?L2xjSFgwQVc5UVdvbzVjWnluaG9hZitTd2xTSWd2WWhUWUE5WC9wWXJjVGdn?=
 =?utf-8?B?L1RJWGQzOHRhLzNsWXB1Q0RQMG5WNnExRlpGbWRUeGhEekNoQjU1UUZFRnI4?=
 =?utf-8?B?Q1RZMVJscGM0bzRrQlVzN1dxWk1BQnhWN1ltTDA2YjJsT3lzZzZsRTJVd01v?=
 =?utf-8?B?bDNWeXR5bFFoWTFoTXJuVmhQbzNlNEl2QWtLdHgvTkJkbDUvWWxtbFIwTjAv?=
 =?utf-8?B?Ykgzc2RsR0FaMm1WRHQ2Q1dueitIVWNFRXJjc1NoN0MvaGNrUzR3UG1vYUdX?=
 =?utf-8?B?SjQ1eSttblp1SWg0OXV4ZXgrNkZ2SERqSjFjSlIwSm14a0ZIZkdzUDVtUzRS?=
 =?utf-8?B?ZEtpWUg4S3ovbDNuNzN6emxGUDBvY1k5M2pUcmhIbklwWDJsRjN4WTBQdjJs?=
 =?utf-8?B?enJSWUg0bVduUjNzdmRSQXZSRUdKcVJSa0dqZUxqTHVFQTFZQmpncnhNL0Z2?=
 =?utf-8?B?Z09OeDVDL0tqbFlMUDRqK1NBcE1idlJpbzR3bnZ5bU4xbGV0WDN0anRQTCtT?=
 =?utf-8?B?cW84ZjRFUy8yczlJZzB3eXFLUFdNbCtDTWxGcnBOTTRKaFlXblRqYVNVUGFS?=
 =?utf-8?B?NGRlQmVWNkNURkFScGhlVytodHdTci80NWUyVGdoWm1OK1doZEZBNXkyVTUz?=
 =?utf-8?B?L29KK09wU0dlR3A2dFIyRzVBRm5LdzlHK25hZUZlQkFlRDRmRko3WVY0WFFw?=
 =?utf-8?B?aDVKTVRGWVdpUVB3NmdmTzNSVnBUQm9UVm5lRktlc3c5bU1EYnF3dnpYY3Fp?=
 =?utf-8?B?MFl4RGdDVVgvMngrc0RWS0d0bHZ6a05nUmYwWkw4U1AxZGFBQ2tqQWlQQWp5?=
 =?utf-8?B?Y05CV2FBTVd2ZEtrYUhtYmVhRGhqb2Nxd1JNVUlZdDdHNHlqT21QVVdlbHIx?=
 =?utf-8?B?anJJNldYZTA1T1NiNkQza3F5NHRIbWFqNTRlVEp6MmlEdlV1ZnNyUVF4aUNW?=
 =?utf-8?B?bm4rUThNcjZZVDhnUXBGYlhtK0hVNjd4RUplRmpFZHV5cEwrMHI0TGRpQ3Fm?=
 =?utf-8?B?KzVTRXJnOFhUckdHR1l1aTJuTmtoMk1YaDcxVWwrNEFPYUhPWXlWVFUvY1JB?=
 =?utf-8?B?RnFNeGoyZEt6MFJJQWhXSWthZytEQXBDRFM5KzE3RDhvOXc2T3V2SjFCUnlU?=
 =?utf-8?B?M2syN3pOSXQ1UUplOTA3eGNGVDdsMDFqaGRUYkJzUnBsR0l6U0RZNDh4djln?=
 =?utf-8?B?N1BRNEYzY3JidVJoaU1pTEdoc1AxUFdyTVJqTjV1TW90V3dHY3Q5QjBpQUls?=
 =?utf-8?B?eVk2MUlWUEtEdmdCRS9oYTNZcUJoM21vNG9saEdMUlY0NXRwK0lyb2c1TUw4?=
 =?utf-8?B?VVFTdy9UUDF3aVBuemRLUjBoOWZYRWwrUzNGZGpDOXpGV0JjbU1qREdldEtX?=
 =?utf-8?B?Q3ZOQThHQitEVGh4ZzhtQjNYclVNbTVMelIwck9qUVpWTEtybm5UMlplcTB1?=
 =?utf-8?B?ZkxIOU1vQWx0bG9lL3hiMVU1QnFnNGdqclhwM3ZkdE5FQzFYbDhFZkhUd2ls?=
 =?utf-8?B?cno1YkVYK251NytYNitzRU9WVzNpZDEvUkZxbUlMTFBESzR0RWUyT2ZwdDNs?=
 =?utf-8?B?QkVvOFNiQ3BGY3B5WTBRYkFiQkRJaFRsSnpzOGZlRFlLSS9zc0NHWEhQK0RL?=
 =?utf-8?B?ZTRXbHhoV21TN2pRRWZIRlV5dVg1cVNGY2wzVnd1aG8ycU91TmR6aEtaNVZM?=
 =?utf-8?B?S2d6MURBQ3pJL2dYKy9hVTB6K2Z3Y3RuSzUydnFhMUs1a0xqdVgrb2FwaFZO?=
 =?utf-8?B?ejFLd1JNZ0p2UGZDaXgrZTE3RHA3UGVnb3VpWjREU3UzenVwb0VOb3A4azcv?=
 =?utf-8?B?WWY0a21jRnVFbzJGdTJSbS9MZ2M0cHMzUUxOVmJURjlUcGlmNDQzUWpMbEdL?=
 =?utf-8?B?djJFTDF2YWQ2NjZrcFlsZEM3NXFnRFpnTEkxaWdDazZ0V1JOTUt1TWRtcUdh?=
 =?utf-8?B?Rmp1YTN3b2phLzZjbVdiaGRxZkRTb1JjbEpPT0c1UzJwSWM3M0FQTFpOOWtT?=
 =?utf-8?B?TkxhVzhBVEt4TlVONFJ4clM5NFBEY0xuL1FTVEZIOE96ZXJyMGJUUVBkNXpv?=
 =?utf-8?B?MGdvM0N4dW1Qd2tIWWFZdXZBbS9QUzNDTmlpOXR4LzBzQnVDMkNTRGJheDk4?=
 =?utf-8?B?d3NNY1o2MGlXUlczOUl3RGVEcUJTZXdUQzd6OXV4NUtHODVPY2NaT2xlYVdj?=
 =?utf-8?B?LzlOWityS2tSR2I0K2hNSVRsSEpzTit2SUN5bStiOUwrSUIxdmlsVnNPaGg3?=
 =?utf-8?B?eUN3anE5RXVwQVBRU0xUUm1sVmFaN1I4QzBlT2NTOUhEMTlkN0VsclM1ZThx?=
 =?utf-8?Q?AS/phlnQMmfyyHq6F01H2p9MMNuZzIxsBkPrUTykpJaXL?=
X-MS-Exchange-AntiSpam-MessageData-1: viUGqixlPfJkww==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30eac839-56ef-4d39-5ab2-08ded310c393
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 23:23:28.8373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9qeaaNG0Kp2Y1d/qhDPRLFp9KugCn1eMYCJT92HuiR8t4AxGIA6or0hNFktueoEmu9lyAhlIQfVjZ6P3ym0TMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9528
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=den@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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
ping v2

