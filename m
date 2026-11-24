Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59744606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVopy-00029C-Hx; Tue, 24 Nov 2026 06:37:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1xVopw-00028h-Uy; Tue, 24 Nov 2026 06:37:24 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1xVopt-00053I-OU; Tue, 24 Nov 2026 06:37:24 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 5D056441C4;
 Tue, 24 Nov 2026 12:37:18 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 jmaguire2013@gmail.com, axboe@kernel.dk, kwolf@redhat.com,
 hreitz@redhat.com, t.lamprecht@proxmox.com, qemu-stable@nongnu.org,
 casasfernando@outlook.com, ncopa@alpinelinux.org,
 pierrick.bouvier@oss.qualcomm.com, berrange@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com
Subject: [PATCH v2] fdmon-io_uring: avoid idle event loop being accounted as
 IO wait
Date: Tue, 24 Nov 2026 12:36:57 +0100
Message-ID: <20261124113700.470090-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1795520236807
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
references and real in-flight requests [0], so the issue could occur
even if no poll or timeout SQE was present.

The io_uring_set_iowait() function is available since liburing 2.10,
so create a stub when it's not available and accept that IOWAIT
accounting includes POLL_ADD and TIMEOUT ops on older hosts.

Track the number of in-flight requests that represent real block-layer
IO (currently, anything submitted via aio_add_sqe() is) in a
per-AioContext counter, and disable iowait accounting when the count
is zero.

SQ-ring composition alone is not a usable signal here: poll SQEs get
re-armed by process_cqe_aio_handler() on every fd-event cycle, so
workloads with constant fd wakeups (observed with librbd) always leave
a non-timeout SQE in the ring even when the guest is idle. Block
drivers that do not go through aio_add_sqe() (e.g. librbd, libaio,
thread-pool) never increment the counter and thus always get the flag
passed, which matches the semantic intent: their iothreads block on
completion notifications from other threads, not on IO they issued
themselves.

The iowait_accounting_reqs counter added to the AioContext struct must
be accessed with atomics, since a vCPU thread can reach
fdmon_io_uring_wait() via aio_poll() (for example via
virtio_scsi_dataplane_stop()).

[0]: https://lore.kernel.org/io-uring/b4d2aa36-8301-4e58-be3e-1451267b8c43@proxmox.com/T/

Cc: qemu-stable@nongnu.org
Fixes: ded29e64c6f3 ("aio-posix: integrate fdmon into glib event loop")
Suggested-by: Fiona Ebner <f.ebner@proxmox.com>
Link: https://lore.proxmox.com/pve-devel/525c4dad-6d04-41f0-8a21-9302b0c6baa4@proxmox.com/
Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
Co-authored-by: Fiona Ebner <f.ebner@proxmox.com>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Changes in v2:
* Use io_uring_set_iowait() if available.
* Do not split submit and wait in fdmon_io_uring_wait().
* Cover other entry points that may call io_uring_enter().
* Improve comment about private struct member.
* Document assumption that request is not multishot for aio_add_sqe().

 include/qemu/aio.h    | 15 ++++++++++++++
 meson.build           |  2 ++
 util/fdmon-io_uring.c | 46 ++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/include/qemu/aio.h b/include/qemu/aio.h
index e65e90093a..dbc5370eb0 100644
--- a/include/qemu/aio.h
+++ b/include/qemu/aio.h
@@ -55,6 +55,12 @@ struct CqeHandler {
 
     /* This field is filled in before ->cb() is called */
     struct io_uring_cqe cqe;
+
+    /*
+     * Whether the in-flight request should count towards IO wait.
+     * Private to the fdmon layer; must not be touched outside of it.
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
@@ -843,6 +855,9 @@ static inline bool aio_has_io_uring(void)
  * as soon as @prep_sqe() returns or it may take until the next event loop
  * iteration.
  *
+ * The fdmon's IO wait accounting logic currently assumes that the request is
+ * not multishot.
+ *
  * When the AioContext is destroyed, pending sqes are ignored and their
  * CqeHandlers are not invoked.
  *
diff --git a/meson.build b/meson.build
index 4d267e10b5..3c6c5380de 100644
--- a/meson.build
+++ b/meson.build
@@ -2717,6 +2717,8 @@ if linux_io_uring.found()
                        cc.has_header_symbol('liburing.h', 'io_uring_prep_writev2'))
   config_host_data.set('HAVE_IO_URING_CQ_HAS_OVERFLOW',
                        cc.has_header_symbol('liburing.h', 'io_uring_cq_has_overflow'))
+  config_host_data.set('HAVE_IO_URING_SET_IOWAIT',
+                       cc.has_header_symbol('liburing.h', 'io_uring_set_iowait'))
 endif
 config_host_data.set('HAVE_TCP_KEEPCNT',
                      cc.has_header_symbol('netinet/tcp.h', 'TCP_KEEPCNT') or
diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index b81e412402..33e0eec934 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -61,6 +61,32 @@ enum {
     FDMON_IO_URING_DELETE_AIO_HANDLER = (1 << 3),
 };
 
+#ifndef HAVE_IO_URING_SET_IOWAIT
+static inline int io_uring_set_iowait(struct io_uring *ring, bool enable_iowait)
+{
+    /*
+     * Stub out this liburing 2.10 API on older hosts and accept that
+     * IOWAIT accounting includes POLL_ADD and TIMEOUT ops. Build
+     * against a newer liburing and a newer Linux kernel if you want to
+     * fix IOWAIT accounting.
+     */
+    return 0;
+}
+#endif
+
+/*
+ * Use before calling any liburing function that may call io_uring_enter().
+ *
+ * Configures IO wait accounting for the AioContext's ring depending on the
+ * presence of real block-layer IO. Poll or timeout SQEs alone do not count
+ * towards IO wait.
+ */
+static inline void configure_iowait_accounting(AioContext *ctx)
+{
+    io_uring_set_iowait(&ctx->fdmon_io_uring,
+                        qatomic_read(&ctx->iowait_accounting_reqs) > 0);
+}
+
 static inline int poll_events_from_pfd(int pfd_events)
 {
     return (pfd_events & G_IO_IN ? POLLIN : 0) |
@@ -93,6 +119,7 @@ static struct io_uring_sqe *get_sqe(AioContext *ctx)
 
     /* No free sqes left, submit pending sqes first */
     do {
+        configure_iowait_accounting(ctx);
         ret = io_uring_submit(ring);
     } while (ret == -EINTR);
 
@@ -176,9 +203,14 @@ static void fdmon_io_uring_add_sqe(AioContext *ctx,
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
@@ -286,6 +318,10 @@ static bool process_cqe(AioContext *ctx,
         return false;
     }
 
+    if (cqe_handler->iowait_accounting) {
+        qatomic_dec(&ctx->iowait_accounting_reqs);
+    }
+
     /*
      * Special handling for AioHandler cqes. They need ready_list and have a
      * return value.
@@ -314,6 +350,7 @@ static int process_cq_ring(AioContext *ctx, AioHandlerList *ready_list)
 #ifdef HAVE_IO_URING_CQ_HAS_OVERFLOW
     /* If the CQ overflowed then fetch CQEs with a syscall */
     if (io_uring_cq_has_overflow(ring)) {
+        configure_iowait_accounting(ctx);
         io_uring_get_events(ring);
     }
 #endif
@@ -335,9 +372,11 @@ static void fdmon_io_uring_gsource_prepare(AioContext *ctx)
 {
     fill_sq_ring(ctx);
     if (io_uring_sq_ready(&ctx->fdmon_io_uring)) {
-        while (io_uring_submit(&ctx->fdmon_io_uring) == -EINTR) {
-            /* Keep trying if syscall was interrupted */
-        }
+        int ret;
+        do {
+            configure_iowait_accounting(ctx);
+            ret = io_uring_submit(&ctx->fdmon_io_uring);
+        } while (ret == -EINTR); /* Keep trying if syscall was interrupted */
     }
 }
 
@@ -424,6 +463,7 @@ static int fdmon_io_uring_wait(AioContext *ctx, AioHandlerList *ready_list,
      *    rather than -EINTR.
      */
     do {
+        configure_iowait_accounting(ctx);
         ret = io_uring_submit_and_wait(&ctx->fdmon_io_uring, wait_nr);
     } while (ret == -EINTR ||
              (ret >= 0 && wait_nr > io_uring_cq_ready(&ctx->fdmon_io_uring)));
-- 
2.47.3



