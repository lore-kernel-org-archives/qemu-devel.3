Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA640606A33A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 21:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LSJELLFH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVxpf-0006jt-5y; Tue, 24 Nov 2026 16:13:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xVxor-0006Uz-EF
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 16:12:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xVxop-0002Mx-8D
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 16:12:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795554763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HXTinqOEqkF57NIJ523/pUObeEcDUPTgTEl7pKhjiIg=;
 b=LSJELLFH5DTMEHt7s03Irr0VNj+89St8ENccxjyLxTV8C+vMK4fhbKtDMLhl+fYhpX/UzR
 zPoNiAchzWoc2RsAj1YCpdqjqKmrk6Au2ILGzFIhOlvGyJeEjgb/2ZGbVgVdxCnm47FxLw
 e8BNkyLxBFc0a6/Gt69vx2HPCa98AMY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-4HyTSmM_Px-UrKGi4957yg-1; Tue,
 24 Nov 2026 21:12:37 +0000
X-MC-Unique: 4HyTSmM_Px-UrKGi4957yg-1
X-Mimecast-MFC-AGG-ID: 4HyTSmM_Px-UrKGi4957yg_1795554756
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30AC5195606F; Tue, 24 Nov 2026 21:12:35 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0673C41F; Tue, 24 Nov 2026 21:12:33 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Lamprecht <t.lamprecht@proxmox.com>, qemu-stable@nongnu.org,
 Fiona Ebner <f.ebner@proxmox.com>
Subject: [PULL for-11.2 1/1] fdmon-io_uring: avoid idle event loop being
 accounted as IO wait
Date: Tue, 24 Nov 2026 16:12:30 -0500
Message-ID: <20261124211230.1944962-2-stefanha@redhat.com>
In-Reply-To: <20261124211230.1944962-1-stefanha@redhat.com>
References: <20261124211230.1944962-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
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
---
 meson.build           |  2 ++
 include/qemu/aio.h    | 15 ++++++++++++++
 util/fdmon-io_uring.c | 46 ++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 4d267e10b5f..3c6c5380de7 100644
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
2.56.1


