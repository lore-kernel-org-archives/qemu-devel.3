Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14630F46112
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4fU5-0004JB-Cg; Mon, 23 Mar 2026 09:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1w4fU2-0004IV-08
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:38:18 -0400
Received: from va-1-111.ptr.blmpb.com ([209.127.230.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1w4fTr-00035M-RS
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1774273077; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=P0N0Blz9eTWsx1Ygi7EPAoiTQsWDhfzDt4IseD6bdPA=;
 b=QwUyIkaK4OqwYg9YRZ94bA1bNNrtOIedwm9KR3m/Zf4bJommV/QaPGCtzRBFw0QDR0/y++
 jm5Rh/nXJguetEQP8tlWfC6s2YUXDk14+fsyykkFGyUWewiHTj/MfwJ8txzh9jV7KAl/MN
 8PQIf/NYkxuOC5DdD8XwhG1NEkrJInbPzxxGN3jUDTYuKyGB6oVFOyhJe1Ec6SEHkFq1Cv
 tLIqnuyqnA6qkvPGXJ3HjhZsfZO3ZdItnuY0SOBhY4la78q9rgElzRRzG1H1Sm03WbbuI0
 BJ0U0awp6pB50s8J9FSOkxeyeNlNHZhH4Nn1eknqPVbLJlcx9nWzXTkZU8Onhw==
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Original-From: hongmianquan <hongmianquan@bytedance.com>
Cc: <dave@treblig.org>, <armbru@redhat.com>, <wubo.bob@bytedance.com>, 
 "hongmianquan" <hongmianquan@bytedance.com>
From: "hongmianquan" <hongmianquan@bytedance.com>
Date: Mon, 23 Mar 2026 21:37:44 +0800
Message-Id: <20260323133744.46493-1-hongmianquan@bytedance.com>
X-Lms-Return-Path: <lba+269c14233+ac3f16+nongnu.org+hongmianquan@bytedance.com>
To: <qemu-devel@nongnu.org>
Subject: [RFC] monitor: Fix deadlock in monitor_cleanup
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.127.230.111;
 envelope-from=hongmianquan@bytedance.com; helo=va-1-111.ptr.blmpb.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

During qemu_cleanup, if a non-coroutine QMP command (e.g., query-commands) is concurrently
received and processed by the mon_iothread, it can lead to a deadlock in monitor_cleanup.

The root cause is a race condition between the main thread's shutdown sequence and the coroutine's dispatching mechanism. When handling a non-coroutine QMP command, qmp_dispatcher_co schedules the actual command execution as a bottom half in iohandler_ctx and then yields. At this suspended point, qmp_dispatcher_co_busy remains true.
Subsequently, the main thread in monitor_cleanup(), sets qmp_dispatcher_co_shutdown, and calls qmp_dispatcher_co_wake(). Since qmp_dispatcher_co_busy is already true, the aio_co_wake is skipped. The main thread then enters the AIO_WAIT_WHILE_UNLOCKED loop, it executes the scheduled BH (do_qmp_dispatch_bh) via aio_poll(iohandler_ctx, false), which attempts to wake up the coroutine, aio_co_wake schedules a new wake-up BH in iohandler_ctx. The main thread then blocks indefinitely in aio_poll(qemu_aio_context, true), while the coroutine's wake-up BH is starved in iohandler_ctx, qmp_dispatcher_co never reaches termination, resulting in a deadlock.

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

To fix this, we should always wake up the dispatcher coroutine if shutdown is requested, bypassing the qmp_dispatcher_co_busy check. This ensures that the coroutine can process the shutdown signal and exit cleanly, breaking the deadlock.

Signed-off-by: hongmianquan <hongmianquan@bytedance.com>
Signed-off-by: wubo.bob <wubo.bob@bytedance.com>
---
 monitor/monitor-internal.h | 1 +
 monitor/monitor.c          | 7 ++++++-
 monitor/qmp.c              | 6 ++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index feca111ae3..943fc832f5 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -180,6 +180,7 @@ void qmp_send_response(MonitorQMP *mon, const QDict *rsp);
 void monitor_data_destroy_qmp(MonitorQMP *mon);
 void coroutine_fn monitor_qmp_dispatcher_co(void *data);
 void qmp_dispatcher_co_wake(void);
+void qmp_dispatcher_co_wake_force(void);
 
 int get_monitor_def(Monitor *mon, int64_t *pval, const char *name);
 void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 1273eb7260..f6c7811cf4 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -671,7 +671,12 @@ void monitor_cleanup(void)
     WITH_QEMU_LOCK_GUARD(&monitor_lock) {
         qmp_dispatcher_co_shutdown = true;
     }
-    qmp_dispatcher_co_wake();
+
+    /*
+     * Force wake up the dispatcher coroutine to
+     * make sure it notices the shutdown flag.
+     */
+    qmp_dispatcher_co_wake_force();
 
     AIO_WAIT_WHILE_UNLOCKED(NULL,
                    (aio_poll(iohandler_get_aio_context(), false),
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 687019811f..1b4a55cabf 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -362,6 +362,12 @@ void qmp_dispatcher_co_wake(void)
     }
 }
 
+void qmp_dispatcher_co_wake_force(void)
+{
+    qatomic_set_mb(&qmp_dispatcher_co_busy, true);
+    aio_co_wake(qmp_dispatcher_co);
+}
+
 static void handle_qmp_command(void *opaque, QObject *req, Error *err)
 {
     MonitorQMP *mon = opaque;
-- 
2.32.1 (Apple Git-133)

