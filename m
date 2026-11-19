Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99657606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU3nm-0005CM-VZ; Thu, 19 Nov 2026 10:11:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1xU3lK-0003te-Pq; Thu, 19 Nov 2026 10:09:22 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1xU3lI-0001JQ-7b; Thu, 19 Nov 2026 10:09:22 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id B334F48D4D;
 Thu, 19 Nov 2026 16:08:45 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 jmaguire2013@gmail.com, axboe@kernel.dk, kwolf@redhat.com,
 hreitz@redhat.com, t.lamprecht@proxmox.com, qemu-stable@nongnu.org,
 casasfernando@outlook.com, ncopa@alpinelinux.org
Subject: [PATCH] fdmon-io_uring: avoid idle event loop being accounted as IO
 wait
Date: Thu, 19 Nov 2026 16:08:08 +0100
Message-ID: <20261119150839.439544-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1795100924267
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Thomas Lamprecht <t.lamprecht@proxmox.com>

Since QEMU 10.2, iothreads use io_uring for file descriptor monitoring
when available at build time. The blocking wait in io_uring_enter()
gets accounted as IO wait by the kernel even when only poll or timeout
SQEs are present. The result is nearly 100% IO pressure in PSI on idle
VMs.

The Linux kernel also has a bug conflating reservations for task
references and real in-flight requests [0], so the issue would occur
even if no poll or timeout SQE was present.

Split io_uring_submit_and_wait() into separate submit and wait calls
so the IORING_ENTER_NO_IOWAIT flag can be passed to io_uring_enter().
Track the number of in-flight requests that represent real block-layer
IO (currently, anything submitted via aio_add_sqe() is) in a
per-AioContext counter, and pass the flag when the count is zero.

SQ-ring composition alone is not a usable signal here: poll SQEs get
re-armed by process_cqe_aio_handler() on every fd-event cycle, so
workloads with constant fd wakeups (observed with librbd) always leave
a non-timeout SQE in the ring even when the guest is idle. Block
drivers that do not go through aio_add_sqe() (e.g. librbd, libaio,
thread-pool) never increment the counter and thus always get the flag
passed, which matches the semantic intent: their iothreads block on
completion notifications from other threads, not on IO they issued
themselves.

The flag is gated on IORING_FEAT_NO_IOWAIT so older kernels are
unaffected.

The iowait_accounting_reqs counter added to the AioContext struct,
must be accessed with atomics, since a vCPU thread can reach
fdmon_io_uring_wait() via aio_poll() (for example via
virtio_scsi_dataplane_stop()).

Even with this change, some users observe higher IO pressure than
before the switch to io_uring in the event loop, but at least not
nearly 100% when idle anymore.

[0]: https://lore.kernel.org/io-uring/b4d2aa36-8301-4e58-be3e-1451267b8c43@proxmox.com/T/

Cc: qemu-stable@nongnu.org
Fixes: ded29e64c6f3 ("aio-posix: integrate fdmon into glib event loop")
Suggested-by: Fiona Ebner <f.ebner@proxmox.com>
Link: https://lore.proxmox.com/pve-devel/525c4dad-6d04-41f0-8a21-9302b0c6baa4@proxmox.com/
Co-authored-by: Fiona Ebner <f.ebner@proxmox.com>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
---
 include/qemu/aio.h    | 12 ++++++++++++
 util/fdmon-io_uring.c | 36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/include/qemu/aio.h b/include/qemu/aio.h
index e65e90093a..17bc145eb6 100644
--- a/include/qemu/aio.h
+++ b/include/qemu/aio.h
@@ -55,6 +55,12 @@ struct CqeHandler {
 
     /* This field is filled in before ->cb() is called */
     struct io_uring_cqe cqe;
+
+    /*
+     * Whether the in-flight request should count towards IO wait.
+     * Set by the fdmon layer; callers must not touch it.
+     */
+    bool iowait_accounting;
 };
 
 typedef QSIMPLEQ_HEAD(, CqeHandler) CqeHandlerSimpleQ;
@@ -295,6 +301,12 @@ struct AioContext {
 
     /* Pending callback state for cqe handlers */
     CqeHandlerSimpleQ cqe_handler_ready_list;
+
+    /*
+     * Number of in-flight requests that should count towards IO wait.
+     * Must be accessed using atomics.
+     */
+    unsigned int iowait_accounting_reqs;
 #endif /* CONFIG_LINUX_IO_URING */
 
     /* TimerLists for calling timers - one per clock type.  Has its own
diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index b81e412402..d308ddfb04 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -51,6 +51,15 @@
 #include "aio-posix.h"
 #include "trace.h"
 
+/* Compat defines for liburing versions that lack NO_IOWAIT support */
+#ifndef IORING_ENTER_NO_IOWAIT
+#define IORING_ENTER_NO_IOWAIT (1U << 7)
+#endif
+
+#ifndef IORING_FEAT_NO_IOWAIT
+#define IORING_FEAT_NO_IOWAIT  (1U << 17)
+#endif
+
 enum {
     FDMON_IO_URING_ENTRIES  = 128, /* sq/cq ring size */
 
@@ -176,9 +185,14 @@ static void fdmon_io_uring_add_sqe(AioContext *ctx,
 {
     struct io_uring_sqe *sqe = get_sqe(ctx);
 
+    /* Currently, IO wait should be accounted for all requests here. */
+    cqe_handler->iowait_accounting = true;
+
     prep_sqe(sqe, opaque);
     io_uring_sqe_set_data(sqe, cqe_handler);
 
+    qatomic_inc(&ctx->iowait_accounting_reqs);
+
     trace_fdmon_io_uring_add_sqe(ctx, opaque, sqe->opcode, sqe->fd, sqe->off,
                                  cqe_handler);
 }
@@ -286,6 +300,10 @@ static bool process_cqe(AioContext *ctx,
         return false;
     }
 
+    if (cqe_handler->iowait_accounting) {
+        qatomic_dec(&ctx->iowait_accounting_reqs);
+    }
+
     /*
      * Special handling for AioHandler cqes. They need ready_list and have a
      * return value.
@@ -422,9 +440,25 @@ static int fdmon_io_uring_wait(AioContext *ctx, AioHandlerList *ready_list,
      * 1. If no SQEs were submitted, then -EINTR is returned.
      * 2. If SQEs were submitted then the number of SQEs submitted is returned
      *    rather than -EINTR.
+     *
+     * Submit and wait are split into separate calls so we can pass
+     * IORING_ENTER_NO_IOWAIT when no request that should count against IO
+     * wait is in flight.
      */
     do {
-        ret = io_uring_submit_and_wait(&ctx->fdmon_io_uring, wait_nr);
+        ret = io_uring_submit(&ctx->fdmon_io_uring);
+
+        if (ret >= 0 && wait_nr > io_uring_cq_ready(&ctx->fdmon_io_uring)) {
+            unsigned flags = IORING_ENTER_GETEVENTS;
+
+            if ((ctx->fdmon_io_uring.features & IORING_FEAT_NO_IOWAIT) &&
+                qatomic_read(&ctx->iowait_accounting_reqs) == 0) {
+                flags |= IORING_ENTER_NO_IOWAIT;
+            }
+
+            ret = io_uring_enter(ctx->fdmon_io_uring.ring_fd, 0, wait_nr,
+                                 flags, NULL);
+        }
     } while (ret == -EINTR ||
              (ret >= 0 && wait_nr > io_uring_cq_ready(&ctx->fdmon_io_uring)));
 
-- 
2.47.3



