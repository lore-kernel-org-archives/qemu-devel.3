Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18B610AB80C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 19:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5qRt-00069G-I5; Thu, 26 Mar 2026 15:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w5qRr-00068w-CE
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 15:32:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w5qRp-0001Qp-Lj
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 15:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774553571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5jsknFxIQfKrGmKaAVWKJ9V7/paBghRvgTbnj5iE9mQ=;
 b=iFJDDLOaTolgoMCZnR8jiH4XyvrT1PlhOPs10+iQb7EGqM30krpeFFa5s9/TxLTHbYLWZm
 Palj2O72+eeUl+uNTCqTAbqUTqbyrtqUkDfpoRlmO73tydd+mSPS34VjdNmWpgBfV/TdJj
 R9UHaP/jrSE/PX6r64zYiKT+bJsRlAk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-UlLWGP-dOcawTm_8Azhk4A-1; Thu,
 26 Mar 2026 15:32:46 -0400
X-MC-Unique: UlLWGP-dOcawTm_8Azhk4A-1
X-Mimecast-MFC-AGG-ID: UlLWGP-dOcawTm_8Azhk4A_1774553564
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D21F1954B1E; Thu, 26 Mar 2026 19:32:44 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.108])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 003D419560B1; Thu, 26 Mar 2026 19:32:41 +0000 (UTC)
Date: Thu, 26 Mar 2026 20:32:39 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: hongmianquan <hongmianquan@bytedance.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, armbru@redhat.com,
 wubo.bob@bytedance.com
Subject: Re: [RFC] monitor: Fix deadlock in monitor_cleanup
Message-ID: <acWJ1-aAmegtcOCv@redhat.com>
References: <20260323133744.46493-1-hongmianquan@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323133744.46493-1-hongmianquan@bytedance.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 23.03.2026 um 14:37 hat hongmianquan geschrieben:
> During qemu_cleanup, if a non-coroutine QMP command (e.g.,
> query-commands) is concurrently received and processed by the
> mon_iothread, it can lead to a deadlock in monitor_cleanup.
> 
> The root cause is a race condition between the main thread's shutdown
> sequence and the coroutine's dispatching mechanism. When handling a
> non-coroutine QMP command, qmp_dispatcher_co schedules the actual
> command execution as a bottom half in iohandler_ctx and then yields.
> At this suspended point, qmp_dispatcher_co_busy remains true.
> Subsequently, the main thread in monitor_cleanup(), sets
> qmp_dispatcher_co_shutdown, and calls qmp_dispatcher_co_wake(). Since
> qmp_dispatcher_co_busy is already true, the aio_co_wake is skipped.
> The main thread then enters the AIO_WAIT_WHILE_UNLOCKED loop, it
> executes the scheduled BH (do_qmp_dispatch_bh) via
> aio_poll(iohandler_ctx, false), which attempts to wake up the
> coroutine, aio_co_wake schedules a new wake-up BH in iohandler_ctx.
> The main thread then blocks indefinitely in aio_poll(qemu_aio_context,
> true), while the coroutine's wake-up BH is starved in iohandler_ctx,
> qmp_dispatcher_co never reaches termination, resulting in a deadlock.

If the real problem is that the aio_poll() in the main thread is never
woken up, does this fix the problem? (Completely untested, and would
need a comment if we commit it.)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 9bb1e6a9f4a..0a0e9e07756 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -128,6 +128,7 @@ static void do_qmp_dispatch_bh(void *opaque)
     data->cmd->fn(data->args, data->ret, data->errp);
     monitor_set_cur(qemu_coroutine_self(), NULL);
     aio_co_wake(data->co);
+    aio_wait_kick();
 }

 /*

> The execution sequence is illustrated below:
> 
>  IO Thread                 Main Thread (qemu_aio_context)        qmp_dispatcher_co (iohandler_ctx)
>     |                                 |                                        |
>     |-- query-commands                |                                        |
>     |-- qmp_dispatcher_co_wake()      |                                        |
>     |    (sets busy = true)           |                                        |
>     |                                 |   <-- Wakes up in iohandler_ctx -->    |
>     |                                 |                                        |-- qmp_dispatch()
>     |                                 |                                        |-- Schedules BH (do_qmp_dispatch_bh)
>     |                                 |                                        |-- qemu_coroutine_yield()
>     |                                 |                                            [State: Suspended, busy=true]
>     |   [ quit triggered ]            |
>     |                                 |-- monitor_cleanup()
>     |                                 |-- qmp_dispatcher_co_shutdown = true
>     |                                 |-- qmp_dispatcher_co_wake()
>     |                                 |    -> Checks busy flag. It's TRUE!
>     |                                 |    -> Skips aio_co_wake().
>     |                                 |
>     |                                 |-- AIO_WAIT_WHILE_UNLOCKED:
>     |                                 |   |-- aio_poll(iohandler_ctx, false)
>     |                                 |   |    -> Executes do_qmp_dispatch_bh
>     |                                 |   |    -> Schedules 'co_schedule_bh' in iohandler_ctx
>     |                                 |   |
>     |                                 |   |-- aio_poll(qemu_aio_context, true)
>     |                                 |   |    -> Blocks indefinitely! (Deadlock)
>     |                                 |
>     |                                 X (Main thread sleeping)                 X (Waiting for next iohandler_ctx poll)
> 
> To fix this, we should always wake up the dispatcher coroutine if shutdown is requested, bypassing the qmp_dispatcher_co_busy check. This ensures that the coroutine can process the shutdown signal and exit cleanly, breaking the deadlock.
> 
> Signed-off-by: hongmianquan <hongmianquan@bytedance.com>
> Signed-off-by: wubo.bob <wubo.bob@bytedance.com>
> ---
>  monitor/monitor-internal.h | 1 +
>  monitor/monitor.c          | 7 ++++++-
>  monitor/qmp.c              | 6 ++++++
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index feca111ae3..943fc832f5 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -180,6 +180,7 @@ void qmp_send_response(MonitorQMP *mon, const QDict *rsp);
>  void monitor_data_destroy_qmp(MonitorQMP *mon);
>  void coroutine_fn monitor_qmp_dispatcher_co(void *data);
>  void qmp_dispatcher_co_wake(void);
> +void qmp_dispatcher_co_wake_force(void);
>  
>  int get_monitor_def(Monitor *mon, int64_t *pval, const char *name);
>  void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 1273eb7260..f6c7811cf4 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -671,7 +671,12 @@ void monitor_cleanup(void)
>      WITH_QEMU_LOCK_GUARD(&monitor_lock) {
>          qmp_dispatcher_co_shutdown = true;
>      }
> -    qmp_dispatcher_co_wake();
> +
> +    /*
> +     * Force wake up the dispatcher coroutine to
> +     * make sure it notices the shutdown flag.
> +     */
> +    qmp_dispatcher_co_wake_force();
>  
>      AIO_WAIT_WHILE_UNLOCKED(NULL,
>                     (aio_poll(iohandler_get_aio_context(), false),
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index 687019811f..1b4a55cabf 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -362,6 +362,12 @@ void qmp_dispatcher_co_wake(void)
>      }
>  }
>  
> +void qmp_dispatcher_co_wake_force(void)
> +{
> +    qatomic_set_mb(&qmp_dispatcher_co_busy, true);
> +    aio_co_wake(qmp_dispatcher_co);
> +}
> +

I think this is wrong for at least two reasons:

1. You don't know what the coroutine is currently doing and for what
   it's waiting when you wake it up. For example, this could be a
   coroutine QMP command and the coroutine is waiting for I/O to
   complete. You didn't provide the result it expected, so it might go
   on to do unexpected things.

2. If the iohandler context is ever polled again, there is nothing that
   tells do_qmp_dispatch_bh() that the coroutine was already woken, so
   it will try to wake it up a second time. The coroutine may not even
   exist any more at this point, or it might crash because it's
   scheduled twice, or you may wake it up at another unexpected time.

It's also lacking the barrier and the check that the coroutine still
exists that qmp_dispatcher_co_wake() currently has, so assuming they are
there for a reason, that would probably cause additional problems.

Kevin


