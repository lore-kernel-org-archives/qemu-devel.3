Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B6B606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=N6dw7ej/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWpCH-0000Fr-P4; Fri, 27 Nov 2026 01:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp9k-0005Zd-2R; Fri, 27 Nov 2026 01:10:00 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp9g-0005c9-7y; Fri, 27 Nov 2026 01:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759049; bh=lUMJtG+2D0tbJwxUkhk0y2ZRe0GCSS35EPDYc/ey2tw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=N6dw7ej/LRuEwZ5YDt+edoBdCrPqeUsqrVr00vmFZmnDNaquiTrzOi8MRzBChlgMO
 yoDR57WA6Ws5ruQOjAFt6wEhqBo164H3ywiaO7Z5eDu0zfub9ZoUQRhNk8CHQ8NQa8
 NYhk53FPHe4RssCGx4YeQXny8T47F3wYiVY61AJBuzXeB3DxY2x/RNEJ/2MCjjUKHN
 S7Abt4381iaUZuBrm+xO5BTEQqERZ0mNAlCfhTXojyVTlximXXgqoXiDz8/SkfFk4X
 XOjZI3KPtfeSSh9psFt/xPJLN18yEz7iqrPuBMwaXSho//3NzHztlOsw2MObT2ylXd
 01GhWC8AA0zww==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8459A1EA37B;
 Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 81AF94699A6;
 Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 72099CF344; Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Lamprecht <t.lamprecht@proxmox.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 137/152] fdmon-io_uring: avoid idle event loop
 being accounted as IO wait
Date: Fri, 27 Nov 2026 08:54:35 +0300
Message-ID: <20261127055709.39630-74-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-id: 20261124113700.470090-1-f.ebner@proxmox.com
Co-authored-by: Fiona Ebner <f.ebner@proxmox.com>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit d8be4d3166ae991b28171fed3fd336632ba54d5e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/qemu/aio.h b/include/qemu/aio.h
index e65e90093a7..dbc5370eb03 100644
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
index 40e3f4ec44c..38bb8b462c7 100644
--- a/meson.build
+++ b/meson.build
@@ -2713,6 +2713,8 @@ if linux_io_uring.found()
                        cc.has_header_symbol('liburing.h', 'io_uring_prep_writev2'))
   config_host_data.set('HAVE_IO_URING_CQ_HAS_OVERFLOW',
                        cc.has_header_symbol('liburing.h', 'io_uring_cq_has_overflow'))
+  config_host_data.set('HAVE_IO_URING_SET_IOWAIT',
+                       cc.has_header_symbol('liburing.h', 'io_uring_set_iowait'))
 endif
 config_host_data.set('HAVE_TCP_KEEPCNT',
                      cc.has_header_symbol('netinet/tcp.h', 'TCP_KEEPCNT') or
diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index b81e412402b..33e0eec9349 100644
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


