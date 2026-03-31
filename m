Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B6D10F9303
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 21:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7gnP-0006xf-T1; Tue, 31 Mar 2026 17:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w7gnN-0006xL-QX; Tue, 31 Mar 2026 17:38:45 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w7gnM-0007UI-9r; Tue, 31 Mar 2026 17:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1774993089; bh=eqKSPA/zK+eRnDaE3eWsBcbwyYsO/8V59RbBErHmi2g=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=tAFmR48A14eY6952haeTDDNs4JS9d+vL7Dh7ENyLvzK0fr4FVi5yI4KXFejUQGcG/
 LEgLMLJbCMGjrhbsqJ6srXZYYEkbKUYcvJYAXL6EI7NuTItlMbMnXwhggce9n6WqkU
 uxSKRArXiUnLeY790NyeaxTSGa7bSH3W26YLnh0bblk56lLUzODNHCerC+mppLqHBX
 dllCq5QrIpI+bkLbP0HGTAyxUXahejldVBdG7GPmabRb0Gdn4iq+sCWcDl2/Jcdx4V
 0r+rI/k3yyIGWHE8zkctDx7I3FlIidnFwFJQnBkKMWz3PrBPnTNHdsJwktm1BAre0Y
 49yB9o0xkFhlw==
Received: from [192.168.177.146] (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by isrv.corpit.ru (Postfix) with ESMTP id B3C04199565;
 Wed, 01 Apr 2026 00:38:09 +0300 (MSK)
Message-ID: <78e18aaf-2231-42c8-9307-829fd4dd44a3@tls.msk.ru>
Date: Wed, 1 Apr 2026 00:38:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] monitor: Fix deadlock in monitor_cleanup
To: hongmianquan <hongmianquan@bytedance.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, michael.roth@amd.com,
 wubo.bob@bytedance.com, qemu-stable <qemu-stable@nongnu.org>
References: <20260327131024.51947-1-hongmianquan@bytedance.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <20260327131024.51947-1-hongmianquan@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 27.03.2026 16:10, hongmianquan wrote:
> During qemu_cleanup, if a non-coroutine QMP command (e.g., query-commands) is concurrently
> received and processed by the mon_iothread, it can lead to a deadlock in monitor_cleanup.
> 
> The root cause is a race condition between the main thread's shutdown sequence and the coroutine's dispatching mechanism. When handling a non-coroutine QMP command, qmp_dispatcher_co schedules the actual command execution as a bottom half in iohandler_ctx and then yields. At this suspended point, qmp_dispatcher_co_busy remains true.
> Subsequently, the main thread in monitor_cleanup(), sets qmp_dispatcher_co_shutdown, and calls qmp_dispatcher_co_wake(). Since qmp_dispatcher_co_busy is already true, the aio_co_wake is skipped. The main thread then enters the AIO_WAIT_WHILE_UNLOCKED loop, it executes the scheduled BH (do_qmp_dispatch_bh) via aio_poll(iohandler_ctx, false), which attempts to wake up the coroutine, aio_co_wake schedules a new wake-up BH in iohandler_ctx. The main thread then blocks indefinitely in aio_poll(qemu_aio_context, true), while the coroutine's wake-up BH is starved in iohandler_ctx, qmp_dispatcher_co never reaches termination, resulting in a deadlock.
> 
> The execution sequence is illustrated below:
> 
>   IO Thread                 Main Thread (qemu_aio_context)        qmp_dispatcher_co (iohandler_ctx)
>      |                                 |                                        |
>      |-- query-commands                |                                        |
>      |-- qmp_dispatcher_co_wake()      |                                        |
>      |    (sets busy = true)           |                                        |
>      |                                 |   <-- Wakes up in iohandler_ctx -->    |
>      |                                 |                                        |-- qmp_dispatch()
>      |                                 |                                        |-- Schedules BH (do_qmp_dispatch_bh)
>      |                                 |                                        |-- qemu_coroutine_yield()
>      |                                 |                                            [State: Suspended, busy=true]
>      |   [ quit triggered ]            |
>      |                                 |-- monitor_cleanup()
>      |                                 |-- qmp_dispatcher_co_shutdown = true
>      |                                 |-- qmp_dispatcher_co_wake()
>      |                                 |    -> Checks busy flag. It's TRUE!
>      |                                 |    -> Skips aio_co_wake().
>      |                                 |
>      |                                 |-- AIO_WAIT_WHILE_UNLOCKED:
>      |                                 |   |-- aio_poll(iohandler_ctx, false)
>      |                                 |   |    -> Executes do_qmp_dispatch_bh
>      |                                 |   |    -> Schedules 'co_schedule_bh' in iohandler_ctx
>      |                                 |   |
>      |                                 |   |-- aio_poll(qemu_aio_context, true)
>      |                                 |   |    -> Blocks indefinitely! (Deadlock)
>      |                                 |
>      |                                 X (Main thread sleeping)                 X (Waiting for next iohandler_ctx poll)
> 
> To fix this, we add an explicit aio_wait_kick() in do_qmp_dispatch_bh() to break the main loop out of its blocking poll, allowing it to evaluate the loop condition and poll iohandler_ctx.

Shouldn't this one too be picked up for the stable series?
Sounds like a good candidate to me.

Thanks,

/mjt


