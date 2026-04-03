Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B16E7E34C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8aG8-0004HD-P7; Fri, 03 Apr 2026 04:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w8aG7-0004Gh-Cu; Fri, 03 Apr 2026 04:52:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w8aG5-0000ed-Cr; Fri, 03 Apr 2026 04:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1775206284; bh=h1iPZBe35Wnnzyrg+1XHZFjZfgEutlw4fbGnvrm30jY=;
 h=Date:Subject:To:References:Cc:From:In-Reply-To;
 b=bxJ6zc6D4u2M2DOrur0rppHfX8uM9xZhQvAQokAKx9pNoHV2ynWNcYslmZL41i2zk
 vcRoIacaQ+qZeiXmyBcegtjYpiP/rLkmtNeIhpno95ax/G2XJ0+SAhXUqpA+Bs5x2N
 dLOC7Vr3RTukahsCVRM9Is/3t3wE57Nm/3/QeEHUxbw0WoIXhvdlJYRv4XLpxcPIbF
 Rf3OK5n5NJolVXja3TvsWWfu0PTn8o9RQ/dmnffRk7ti864sOVbUH7WcHSQlfikOo5
 TZq7e2TZ4doTjo9kriP3+dJ/nC5hFitaxlUWdnzsbPzyWqZ6cJKgRCP2SyfzAmOWCo
 +1/HPLGLGdWeQ==
Received: from [192.168.177.146] (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by isrv.corpit.ru (Postfix) with ESMTP id 0389519A560;
 Fri, 03 Apr 2026 11:51:24 +0300 (MSK)
Message-ID: <d2b123a1-7a20-4634-a774-bbd77d3d0e97@tls.msk.ru>
Date: Fri, 3 Apr 2026 11:52:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 6/6] bsd-user, linux-user: signal: recursive signal
 delivery fix
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260401094848.2661985-1-peter.maydell@linaro.org>
 <20260401094848.2661985-7-peter.maydell@linaro.org>
Content-Language: en-US, ru-RU
Cc: qemu-stable <qemu-stable@nongnu.org>, Nicholas Piggin
 <npiggin@gmail.com>, Warner Losh <imp@bsdimp.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <20260401094848.2661985-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 01.04.2026 12:48, Peter Maydell wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> Synchronous signals must accommodate a synchronous signal being
> raised during delivery, as asynchronous ones do. For example
> badframe errors during delivery will cause SIGSEGV to be raised.
> 
> Without this fix, cpu_loop() runs process_pending_signals() which
> delivers the first synchronous signal (e.g., SIGILL) which fails
> to set the handler and forces SIGSEGV, but that is not picked up.
> process_pending_signals() returns. Then cpu_loop() runs cpu_exec()
> again, which attempts to execute the same instruction, another
> SIGILL.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Warner Losh <imp@bsdimp.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Message-id: 20260321135624.581398-3-npiggin@gmail.com
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   bsd-user/signal.c   | 10 ++++++----
>   linux-user/signal.c |  9 ++++++---
>   2 files changed, 12 insertions(+), 7 deletions(-)

This too smells like a qemu-stable material (10.0.x & 10.2.x series).

I'm picking it up.  Please let me know if I shouldn't.

Thanks,

/mjt

> diff --git a/bsd-user/signal.c b/bsd-user/signal.c
> index dadcc037dc..3e5e41e1b1 100644
> --- a/bsd-user/signal.c
> +++ b/bsd-user/signal.c
> @@ -998,7 +998,12 @@ void process_pending_signals(CPUArchState *env)
>                   sigdelset(&ts->signal_mask, target_to_host_signal(sig));
>                   sigact_table[sig - 1]._sa_handler = TARGET_SIG_DFL;
>               }
> +            /*
> +             * Restart scan from the beginning, as handle_pending_signal
> +             * might have resulted in a new synchronous signal (eg SIGSEGV).
> +             */
>               handle_pending_signal(env, sig, &ts->sync_signal);
> +            goto restart_scan;
>           }
>   
>           k = ts->sigtab;
> @@ -1008,10 +1013,7 @@ void process_pending_signals(CPUArchState *env)
>               if (k->pending &&
>                   !sigismember(blocked_set, target_to_host_signal(sig))) {
>                   handle_pending_signal(env, sig, k);
> -                /*
> -                 * Restart scan from the beginning, as handle_pending_signal
> -                 * might have resulted in a new synchronous signal (eg SIGSEGV).
> -                 */
> +                /* Restart scan, explained above. */
>                   goto restart_scan;
>               }
>           }
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index 804096bd44..f0a22577e5 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -1384,6 +1384,11 @@ void process_pending_signals(CPUArchState *cpu_env)
>               }
>   
>               handle_pending_signal(cpu_env, sig, &ts->sync_signal);
> +            /*
> +             * Restart scan from the beginning, as handle_pending_signal
> +             * might have resulted in a new synchronous signal (eg SIGSEGV).
> +             */
> +            goto restart_scan;
>           }
>   
>           for (sig = 1; sig <= TARGET_NSIG; sig++) {
> @@ -1394,9 +1399,7 @@ void process_pending_signals(CPUArchState *cpu_env)
>                   (!sigismember(blocked_set,
>                                 target_to_host_signal_table[sig]))) {
>                   handle_pending_signal(cpu_env, sig, &ts->sigtab[sig - 1]);
> -                /* Restart scan from the beginning, as handle_pending_signal
> -                 * might have resulted in a new synchronous signal (eg SIGSEGV).
> -                 */
> +                /* Restart scan, explained above. */
>                   goto restart_scan;
>               }
>           }


