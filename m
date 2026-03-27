Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F380610ED676
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 13:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w66xr-0000ph-WA; Fri, 27 Mar 2026 09:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1w66xo-0000pY-Ue
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 09:11:01 -0400
Received: from va-1-111.ptr.blmpb.com ([209.127.230.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1w66xm-0005zZ-0o
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 09:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1774617040; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=l/lgnMIV8DNoZCBSRTWY7xYrOxj5DgN3eWBfLFhjboU=;
 b=jfcNvF8tFlaYJ1nkitWy70Ksy9cV2OqJRFntlKCrttASDwgPUYNQUlz88np3agWqK5mctP
 xJ6vD1oZRbgDNN01SsrQUvcwyWOmD8YkjZYiNXZKICHH3ECkO+f6EYU8f/a/k6pWX6CTrP
 VsC58JKx2k3aH/fpIPsxwCCLuysGdGZd/6M2A4YDWK5X8yL5CgMi/+/a0gtyPuSMBsXNG7
 kx1NuxSsnFF+6xygoGjK+nTS9Cr7KJ2JQnwTe306CVamsSyUqudhdlyzS9GDzpvCQUi2PP
 wkjdvp6Qt/0aaaMlUMOjVygMzfJYXUxr4IluzjsIMcdnLmAXjA5PrdoMZDn8lw==
Date: Fri, 27 Mar 2026 21:10:24 +0800
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
To: <qemu-devel@nongnu.org>
Cc: <kwolf@redhat.com>, <armbru@redhat.com>, <michael.roth@amd.com>, 
 <wubo.bob@bytedance.com>, "hongmianquan" <hongmianquan@bytedance.com>
Message-Id: <20260327131024.51947-1-hongmianquan@bytedance.com>
Mime-Version: 1.0
X-Original-From: hongmianquan <hongmianquan@bytedance.com>
X-Lms-Return-Path: <lba+269c681ce+2f99e9+nongnu.org+hongmianquan@bytedance.com>
From: "hongmianquan" <hongmianquan@bytedance.com>
Subject: [PATCH v2] monitor: Fix deadlock in monitor_cleanup
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
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

To fix this, we add an explicit aio_wait_kick() in do_qmp_dispatch_bh() to break the main loop out of its blocking poll, allowing it to evaluate the loop condition and poll iohandler_ctx.

Signed-off-by: hongmianquan <hongmianquan@bytedance.com>
Signed-off-by: wubo.bob <wubo.bob@bytedance.com>
---
 qapi/qmp-dispatch.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 9bb1e6a9f4..e3897d5197 100644
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
2.32.1 (Apple Git-133)

