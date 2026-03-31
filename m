Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5469109B47B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 15:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7adZ-0003JT-UR; Tue, 31 Mar 2026 11:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w7adY-0003Gy-1B
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 11:04:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w7adW-0002ZF-Im
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 11:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774969450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4/EQKTbtcH/MX2YkSmC6DrV9C1Uks/s3kAn+UlSgZnk=;
 b=J5PcoOpfEqzTpVBBcpCgGNPy+EBNdBXxldSYQNks2VuZsDjE0r2IkpWQjpgqBKtJ8mv5pk
 kHWb66ybGHTaFm/6bWhpiccfMSfAAJKifNbXhB6WErecAocbU1TlxWUhR/I55wu2Tz5O5n
 0zAPjqFTau/jp3Q+kvHYv0m748VpA5s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-GN0xrhozMYCzet6TcjxOEw-1; Tue,
 31 Mar 2026 11:04:06 -0400
X-MC-Unique: GN0xrhozMYCzet6TcjxOEw-1
X-Mimecast-MFC-AGG-ID: GN0xrhozMYCzet6TcjxOEw_1774969445
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42032195609E; Tue, 31 Mar 2026 15:04:05 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.50.38])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DACDE1954102; Tue, 31 Mar 2026 15:04:03 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 4/6] monitor: Fix deadlock in monitor_cleanup
Date: Tue, 31 Mar 2026 17:03:50 +0200
Message-ID: <20260331150352.256332-5-kwolf@redhat.com>
In-Reply-To: <20260331150352.256332-1-kwolf@redhat.com>
References: <20260331150352.256332-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 qapi/qmp-dispatch.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 9bb1e6a9f4a..e3897d51977 100644
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
2.53.0


