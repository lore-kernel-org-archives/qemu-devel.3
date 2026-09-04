Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC94C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 04:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2LbE-0001Ci-PN; Fri, 04 Sep 2026 00:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <getshell@seu.edu.cn>)
 id 1x2KlI-0004Nc-3f
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 23:38:44 -0400
Received: from mail-m49198.qiye.163.com ([45.254.49.198])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <getshell@seu.edu.cn>)
 id 1x2KlF-00039J-7K
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 23:38:43 -0400
Received: from LAPTOP-99KJFSET (unknown [36.153.54.109])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4c7fb79f4;
 Fri, 4 Sep 2026 11:31:31 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hongyan Xu <getshell@seu.edu.cn>
Subject: [RFC PATCH] migration/rdma: remove the dangling fd handler before
 re-entering loadvm
Date: Fri,  4 Sep 2026 11:31:30 +0800
Message-ID: <20260904033130.276-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa06a78b4cf03a1kunm7e0be8a224083
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaQkhKVhhDGE9JTx4fGhpPTlYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VSktCWVdZFhoPEhUdFFlBWU9LSFVKS0lITk
 NDVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
 b=KLW/qLqs/nXxryC32U9omVjdAZAXYkj0y2ziN8lVce36ezspyN7JZb179sZfDOculw+H26uSWh+YP2d3vxhvUKwYiUSx20/yP146T8T6S1RX+l22OFV390peiFVEM9N8cKEqMWUAN1T8MGGzNiDJha1iX77sxVtAwUeEqTu8Lg0=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=v14I0uhvvc/poJ+OXiBQ/bwNrSetEMETBP/CF3on9P8=;
 h=date:mime-version:subject:message-id:from;
Received-SPF: pass client-ip=45.254.49.198; envelope-from=getshell@seu.edu.cn;
 helo=mail-m49198.qiye.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 04 Sep 2026 00:32:22 -0400
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

The destination RDMA accept path runs the incoming migration coroutine
(mis->loadvm_co).  While blocked waiting for an RDMA completion it parks
itself in yield_until_fd_readable() (util/qemu-coroutine-io.c) on a
completion-channel fd.  That helper registers an fd handler whose opaque
is a stack object (FDYieldUntilData) and only removes the handler from
inside its own fd_coroutine_enter() callback.

rdma_cm_poll_handler() handles RDMA_CM_EVENT_DISCONNECTED /
RDMA_CM_EVENT_DEVICE_REMOVAL by calling qemu_coroutine_enter() on the
coroutine directly.  When the coroutine is parked in
yield_until_fd_readable() at that moment, this bypasses
fd_coroutine_enter(): the coroutine resumes and returns from the wait,
but the fd handler stays registered with an opaque that points into the
(now returned-from) stack frame.  A later event on that fd then calls
fd_coroutine_enter() with a dangling pointer -> use-after-free.

Record, around the yield, the AioContext and fd the coroutine is parked
on, and make rdma_cm_poll_handler() remove that fd handler before it
re-enters the coroutine.

This is an RFC: the coroutine/thread wake-up semantics in this area were
also discussed by Peter Xu's 2025 series ("migration/rdma: Remove
coroutine path in qemu_rdma_wait_comp_channel" / "Remove
rdma_cm_poll_handler"); if that direction is preferred this patch should
be reworked accordingly.

Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 migration/rdma.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index e976739fad..66175aa60b 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -360,6 +360,17 @@ typedef struct RDMAContext {
      */
     int migration_started_on_destination;
 
+    /*
+     * While the incoming-migration coroutine is parked in
+     * yield_until_fd_readable() on a completion channel we record the
+     * fd and AioContext here.  The cm event handler uses this to remove
+     * the fd handler before re-entering the coroutine; without that the
+     * handler keeps pointing at the coroutine stack after the wait
+     * returns, i.e. a dangling fd handler.
+     */
+    AioContext *wait_ctx;
+    int wait_fd;
+
     int total_registrations;
     int total_writes;
 
@@ -1248,7 +1259,21 @@ qemu_rdma_wait_comp_channel(RDMAContext *rdma,
     struct rdma_cm_event *cm_event;
 
     if (qemu_in_coroutine()) {
+        AioContext *ctx = qemu_get_current_aio_context();
+
+        /*
+         * Record where the coroutine is parked so that
+         * rdma_cm_poll_handler() can remove the fd handler before it
+         * re-enters us (yield_until_fd_readable() only removes the
+         * handler through its own fd_coroutine_enter() callback; a
+         * direct qemu_coroutine_enter() would leave a handler whose
+         * opaque points at our stack frame).
+         */
+        rdma->wait_ctx = ctx;
+        rdma->wait_fd = comp_channel->fd;
         yield_until_fd_readable(comp_channel->fd);
+        rdma->wait_ctx = NULL;
+        rdma->wait_fd = -1;
     } else {
         /* This is the source side, we're in a separate thread
          * or destination prior to migration_fd_process_incoming()
@@ -3024,6 +3049,21 @@ static void rdma_cm_poll_handler(void *opaque)
         }
         rdma_ack_cm_event(cm_event);
         if (mis->loadvm_co) {
+            /*
+             * The incoming coroutine may be parked in
+             * yield_until_fd_readable() on a completion channel.  Its
+             * fd handler is normally removed by fd_coroutine_enter()
+             * when that fd becomes readable.  If we re-enter the
+             * coroutine directly we must remove the handler first,
+             * otherwise it stays registered with an opaque pointing at
+             * the (now returned-from) coroutine stack frame.
+             */
+            if (rdma->wait_fd >= 0 && rdma->wait_ctx) {
+                aio_set_fd_handler(rdma->wait_ctx, rdma->wait_fd,
+                                   NULL, NULL, NULL, NULL, NULL);
+                rdma->wait_fd = -1;
+                rdma->wait_ctx = NULL;
+            }
             qemu_coroutine_enter(mis->loadvm_co);
         }
         return;
-- 
2.50.1.windows.1


