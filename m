Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1C0CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:02:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuCu-0003ik-Mc; Tue, 12 May 2026 17:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuBm-0002Nr-UF; Tue, 12 May 2026 16:58:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuBl-0004t3-6s; Tue, 12 May 2026 16:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619276; bh=gjFyd651RWy0F6xlDfP/SdobmZuQcY+OKU1rjZMzzV0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=xoxL5U5/a/Tz/jx32ZOmvlAtlvb/FFbqilP6fXLkpCeEJTGkNusCa9BxKeeeZ6TBt
 14cmyhHsriaRY8fQTI5mRYfynutwwK/orsWE73HZTgm7BpVfcz92xnBxEg1QHj4UmJ
 +lqvebyEPvR6ZNqitm9PTN/oSCthOqj1T96LHUHk1ik5HB6jroTSCIg+G/BlexCLYd
 b1HV62vr31p7WXw3y83eJt1EGZYUbGxQBK5bJGBRInOGUphfP1QdmiWKKLDcJl/7zW
 fKd4CEN/Z4r11z9HOws+gnzpH8Aeoal1LheVzT8nYIxgFYitxTw37ABEtZw6RVOpHg
 dBTwRGT1mXJsw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 179A01AA2F7;
 Tue, 12 May 2026 23:54:36 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 21C7E3ABC68;
 Tue, 12 May 2026 23:54:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, hongmianquan <hongmianquan@bytedance.com>,
 Kevin Wolf <kwolf@redhat.com>, "wubo.bob" <wubo.bob@bytedance.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 043/107] monitor: Fix deadlock in monitor_cleanup
Date: Tue, 12 May 2026 23:53:30 +0300
Message-ID: <20260512205437.360850-43-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: hongmianquan <hongmianquan@bytedance.com>

During qemu_cleanup, if a non-coroutine QMP command (e.g.,
query-commands) is concurrently received and processed by the
mon_iothread, it can lead to a deadlock in monitor_cleanup.

The root cause is a race condition between the main thread's shutdown
sequence and the coroutine's dispatching mechanism. When handling a
non-coroutine QMP command, qmp_dispatcher_co schedules the actual
command execution as a bottom half in iohandler_ctx and then yields. At
this suspended point, qmp_dispatcher_co_busy remains true.

Subsequently, the main thread in monitor_cleanup(), sets
qmp_dispatcher_co_shutdown, and calls qmp_dispatcher_co_wake(). Since
qmp_dispatcher_co_busy is already true, the aio_co_wake is skipped. The
main thread then enters the AIO_WAIT_WHILE_UNLOCKED loop, it executes
the scheduled BH (do_qmp_dispatch_bh) via aio_poll(iohandler_ctx,
false), which attempts to wake up the coroutine, aio_co_wake schedules a
new wake-up BH in iohandler_ctx. The main thread then blocks
indefinitely in aio_poll(qemu_aio_context, true), while the coroutine's
wake-up BH is starved in iohandler_ctx, qmp_dispatcher_co never reaches
termination, resulting in a deadlock.

The execution sequence is illustrated below:

 IO Thread                 Main Thread (qemu_aio_context)        qmp_dispatcher_co (iohandler_ctx)
    |                                 |                                        |
    |-- query-commands                |                                        |
    |-- qmp_dispatcher_co_wake()      |                                        |
    |    (sets busy = true)           |                                        |
    |                                 |   <-- Wakes up in iohandler_ctx -->    |
    |                                 |                                        |-- qmp_dispatch()
    |                                 |                                        |-- Schedules BH (do_qmp_dispatch_bh)
    |                                 |                                        |-- qemu_coroutine_yield()
    |                                 |                                            [State: Suspended, busy=true]
    |   [ quit triggered ]            |
    |                                 |-- monitor_cleanup()
    |                                 |-- qmp_dispatcher_co_shutdown = true
    |                                 |-- qmp_dispatcher_co_wake()
    |                                 |    -> Checks busy flag. It's TRUE!
    |                                 |    -> Skips aio_co_wake().
    |                                 |
    |                                 |-- AIO_WAIT_WHILE_UNLOCKED:
    |                                 |   |-- aio_poll(iohandler_ctx, false)
    |                                 |   |    -> Executes do_qmp_dispatch_bh
    |                                 |   |    -> Schedules 'co_schedule_bh' in iohandler_ctx
    |                                 |   |
    |                                 |   |-- aio_poll(qemu_aio_context, true)
    |                                 |   |    -> Blocks indefinitely! (Deadlock)
    |                                 |
    |                                 X (Main thread sleeping)                 X (Waiting for next iohandler_ctx poll)

To fix this, we add an explicit aio_wait_kick() in do_qmp_dispatch_bh()
to break the main loop out of its blocking poll, allowing it to evaluate
the loop condition and poll iohandler_ctx.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: hongmianquan <hongmianquan@bytedance.com>
Signed-off-by: wubo.bob <wubo.bob@bytedance.com>
Message-ID: <20260327131024.51947-1-hongmianquan@bytedance.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit fc1a2ec7da531223b3473185dc2584f8a7c6c659)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index e569224eae..50eae4f082 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -128,6 +128,16 @@ static void do_qmp_dispatch_bh(void *opaque)
     data->cmd->fn(data->args, data->ret, data->errp);
     monitor_set_cur(qemu_coroutine_self(), NULL);
     aio_co_wake(data->co);
+
+    /*
+     * If the QMP dispatcher coroutine is waiting to be scheduled
+     * in iohandler_ctx, we must kick the main loop. This ensures
+     * that AIO_WAIT_WHILE_UNLOCKED() in monitor_cleanup() doesn't
+     * block indefinitely waiting for an event in qemu_aio_context,
+     * but actually gets the chance to poll iohandler_ctx and resume
+     * the coroutine.
+     */
+    aio_wait_kick();
 }
 
 /*
-- 
2.47.3


