Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2F7FD4F04
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 16:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzvZ-0003tC-6H; Tue, 10 Mar 2026 12:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzvP-0003SV-JV
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:27:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzvM-0000yI-FE
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773160031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IzgPE2qoJKJk1GXEHyIV3nzDp+WR6Nwuypa/cvTvsiw=;
 b=EqP7SoGMEKUTYuH0A7A+y04t2ymBK/GZo7jV6+QqQ7uusBhgFZkCMJJY8gnwffLYH5fPij
 Fex6hP1efLzv43x4xSfSkRsVZ4fzkm3Gyh+gABIUILzcqUrqnEdR3SDxjGfgTNXnbGQKil
 LjOvrqJVOIHy+nzUdMvzxS3kdrZenYo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-Mjw5b1b6PkCqcTGgZzXgaA-1; Tue,
 10 Mar 2026 12:27:09 -0400
X-MC-Unique: Mjw5b1b6PkCqcTGgZzXgaA-1
X-Mimecast-MFC-AGG-ID: Mjw5b1b6PkCqcTGgZzXgaA_1773160028
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D70C1955F29; Tue, 10 Mar 2026 16:27:08 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.224.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0941019560A6; Tue, 10 Mar 2026 16:27:06 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 23/28] fuse: Implement multi-threading
Date: Tue, 10 Mar 2026 17:26:17 +0100
Message-ID: <20260310162622.333137-24-kwolf@redhat.com>
In-Reply-To: <20260310162622.333137-1-kwolf@redhat.com>
References: <20260310162622.333137-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

From: Hanna Czenczek <hreitz@redhat.com>

FUSE allows creating multiple request queues by "cloning" /dev/fuse FDs
(via open("/dev/fuse") + ioctl(FUSE_DEV_IOC_CLONE)).

We can use this to implement multi-threading.

For configuration, we don't need any more information beyond the simple
array provided by the core block export interface: The FUSE kernel
driver feeds these FDs in a round-robin fashion, so all of them are
equivalent and we want to have exactly one per thread.

These are the benchmark results when using four threads (compared to a
single thread); note that fio still only uses a single job, but
performance can still be improved because of said round-robin usage for
the queues.  (Not in the sync case, though, in which case I guess it
just adds overhead.)

file:
  read:
    seq aio:   261.7k ±1.7k  (+168%)
    rand aio:  129.2k ±14.3k (+35%)
    seq sync:   36.6k ±0.6k  (+6%)
    rand sync:  10.1k ±0.1k  (+2%)
  write:
    seq aio:   235.7k ±2.8k  (+243%)
    rand aio:  232.0k ±6.7k  (+237%)
    seq sync:   31.7k ±0.6k  (+4%)
    rand sync:  31.8k ±0.5k  (+4%)
null:
  read:
    seq aio:   253.8k ±12.3k (+45%)
    rand aio:  248.2k ±12.0k (+45%)
    seq sync:   91.6k ±2.4k  (+12%)
    rand sync:  91.3k ±2.1k  (+17%)
  write:
    seq aio:   208.2k ±9.8k  (+6%)
    rand aio:  207.0k ±7.4k  (+8%)
    seq sync:   91.2k ±1.9k  (+9%)
    rand sync:  90.4k ±2.5k  (+14%)

So moderate improvements in most cases, but quite improved AIO
performance with an actual underlying file.

Here's results for numjobs=4:

"Before", i.e. without multithreading in QSD/FUSE (results compared to
numjobs=1):

file:
  read:
    seq aio:    85.5k ±0.4k (-13%)
    rand aio:   92.5k ±0.5k (-3%)
    seq sync:   54.5k ±9.1k (+58%)
    rand sync:  38.0k ±0.2k (+283%)
  write:
    seq aio:    67.3k ±0.3k (-2%)
    rand aio:   67.6k ±0.3k (-2%)
    seq sync:   69.3k ±0.5k (+126%)
    rand sync:  69.3k ±0.3k (+126%)
null:
  read:
    seq aio:   170.6k ±0.8k (-2%)
    rand aio:  170.9k ±0.9k (±0%)
    seq sync:  187.6k ±1.3k (+129%)
    rand sync: 188.9k ±0.9k (+142%)
  write:
    seq aio:   191.5k ±1.2k (-2%)
    rand aio:  193.8k ±1.4k (-1%)
    seq sync:  206.1k ±1.3k (+147%)
    rand sync: 206.1k ±1.2k (+159%)

As probably expected, little difference in the AIO case, but great
improvements in the sync cases because it kind of gives it an artificial
iodepth of 4.

"After", i.e. with four threads in QSD/FUSE (now results compared to the
above):

file:
  read:
    seq aio:   198.7k ±2.7k (+132%)
    rand aio:  317.3k ±0.6k (+243%)
    seq sync:   55.9k ±8.9k (+3%)
    rand sync:  39.1k ±0.0k (+3%)
  write:
    seq aio:   229.0k ±0.8k (+240%)
    rand aio:  227.0k ±1.3k (+235%)
    seq sync:  102.5k ±0.2k (+48%)
    rand sync: 101.7k ±0.2k (+47%)
null:
  read:
    seq aio:   584.0k ±1.5k (+242%)
    rand aio:  581.9k ±1.9k (+240%)
    seq sync:  270.6k ±0.9k (+44%)
    rand sync: 270.4k ±0.7k (+43%)
  write:
    seq aio:   598.4k ±2.0k (+212%)
    rand aio:  605.2k ±2.0k (+212%)
    seq sync:  274.0k ±0.8k (+33%)
    rand sync: 275.0k ±0.7k (+33%)

So this helps mainly for the AIO cases, but also in the null sync cases,
because null is always CPU-bound, so more threads help.

One unsolved mystery: When using a multithreaded export, running fio
with 1 job (benchmark at the top of this commit) yields better seqread
performance than doing so with 4 jobs.  Actually, with 4 jobs, it's
significantly than randread, which is quite strange.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20260309150856.26800-24-hreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/export/fuse.c | 193 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 153 insertions(+), 40 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index fe1b6ad5ffc..a2a478d2934 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -31,11 +31,13 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "system/block-backend.h"
+#include "system/iothread.h"
 
 #include <fuse.h>
 #include <fuse_lowlevel.h>
 
 #include "standard-headers/linux/fuse.h"
+#include <sys/ioctl.h>
 
 #if defined(CONFIG_FALLOCATE_ZERO_RANGE)
 #include <linux/falloc.h>
@@ -118,12 +120,17 @@ QEMU_BUILD_BUG_ON(sizeof(((FuseRequestInHeaderBuf *)0)->head) +
                   sizeof(((FuseRequestInHeaderBuf *)0)->tail) !=
                   sizeof(FuseRequestInHeader));
 
-typedef struct FuseExport {
-    BlockExport common;
+typedef struct FuseExport FuseExport;
 
-    struct fuse_session *fuse_session;
-    unsigned int in_flight; /* atomic */
-    bool mounted, fd_handler_set_up;
+/*
+ * One FUSE "queue", representing one FUSE FD from which requests are fetched
+ * and processed.  Each queue is tied to an AioContext.
+ */
+typedef struct FuseQueue {
+    FuseExport *exp;
+
+    AioContext *ctx;
+    int fuse_fd;
 
     /*
      * Cached buffer to receive the data of WRITE requests.  Cached because:
@@ -140,6 +147,14 @@ typedef struct FuseExport {
      * via blk_blockalign() and thus need to be freed via qemu_vfree().
      */
     void *req_write_data_cached;
+} FuseQueue;
+
+struct FuseExport {
+    BlockExport common;
+
+    struct fuse_session *fuse_session;
+    unsigned int in_flight; /* atomic */
+    bool mounted, fd_handler_set_up;
 
     /*
      * Set when there was an unrecoverable error and no requests should be read
@@ -148,7 +163,15 @@ typedef struct FuseExport {
      */
     bool halted;
 
-    int fuse_fd;
+    int num_queues;
+    FuseQueue *queues;
+    /*
+     * True if this export should follow the generic export's AioContext.
+     * Will be false if the queues' AioContexts have been explicitly set by the
+     * user, i.e. are expected to stay in those contexts.
+     * (I.e. is always false if there is more than one queue.)
+     */
+    bool follow_aio_context;
 
     char *mountpoint;
     bool writable;
@@ -160,7 +183,7 @@ typedef struct FuseExport {
     mode_t st_mode;
     uid_t st_uid;
     gid_t st_gid;
-} FuseExport;
+};
 
 /*
  * Verify that the size of FuseRequestInHeaderBuf.head plus the data
@@ -179,12 +202,13 @@ static void fuse_export_halt(FuseExport *exp);
 static void init_exports_table(void);
 
 static int mount_fuse_export(FuseExport *exp, Error **errp);
+static int clone_fuse_fd(int fd, Error **errp);
 
 static bool is_regular_file(const char *path, Error **errp);
 
 static void read_from_fuse_fd(void *opaque);
 static void coroutine_fn
-fuse_co_process_request(FuseExport *exp, const FuseRequestInHeader *in_hdr,
+fuse_co_process_request(FuseQueue *q, const FuseRequestInHeader *in_hdr,
                         const void *data_buffer);
 static int fuse_write_err(int fd, const struct fuse_in_header *in_hdr, int err);
 
@@ -216,8 +240,11 @@ static void fuse_attach_handlers(FuseExport *exp)
         return;
     }
 
-    aio_set_fd_handler(exp->common.ctx, exp->fuse_fd,
-                       read_from_fuse_fd, NULL, NULL, NULL, exp);
+    for (int i = 0; i < exp->num_queues; i++) {
+        aio_set_fd_handler(exp->queues[i].ctx, exp->queues[i].fuse_fd,
+                           read_from_fuse_fd, NULL, NULL, NULL,
+                           &exp->queues[i]);
+    }
     exp->fd_handler_set_up = true;
 }
 
@@ -226,8 +253,10 @@ static void fuse_attach_handlers(FuseExport *exp)
  */
 static void fuse_detach_handlers(FuseExport *exp)
 {
-    aio_set_fd_handler(exp->common.ctx, exp->fuse_fd,
-                       NULL, NULL, NULL, NULL, NULL);
+    for (int i = 0; i < exp->num_queues; i++) {
+        aio_set_fd_handler(exp->queues[i].ctx, exp->queues[i].fuse_fd,
+                           NULL, NULL, NULL, NULL, NULL);
+    }
     exp->fd_handler_set_up = false;
 }
 
@@ -242,6 +271,11 @@ static void fuse_export_drained_end(void *opaque)
 
     /* Refresh AioContext in case it changed */
     exp->common.ctx = blk_get_aio_context(exp->common.blk);
+    if (exp->follow_aio_context) {
+        assert(exp->num_queues == 1);
+        exp->queues[0].ctx = exp->common.ctx;
+    }
+
     fuse_attach_handlers(exp);
 }
 
@@ -273,8 +307,32 @@ static int fuse_export_create(BlockExport *blk_exp,
     assert(blk_exp_args->type == BLOCK_EXPORT_TYPE_FUSE);
 
     if (multithread) {
-        error_setg(errp, "FUSE export does not support multi-threading");
-        return -EINVAL;
+        /* Guaranteed by common export code */
+        assert(mt_count >= 1);
+
+        exp->follow_aio_context = false;
+        exp->num_queues = mt_count;
+        exp->queues = g_new(FuseQueue, mt_count);
+
+        for (size_t i = 0; i < mt_count; i++) {
+            exp->queues[i] = (FuseQueue) {
+                .exp = exp,
+                .ctx = multithread[i],
+                .fuse_fd = -1,
+            };
+        }
+    } else {
+        /* Guaranteed by common export code */
+        assert(mt_count == 0);
+
+        exp->follow_aio_context = true;
+        exp->num_queues = 1;
+        exp->queues = g_new(FuseQueue, 1);
+        exp->queues[0] = (FuseQueue) {
+            .exp = exp,
+            .ctx = exp->common.ctx,
+            .fuse_fd = -1,
+        };
     }
 
     /* For growable and writable exports, take the RESIZE permission */
@@ -286,7 +344,7 @@ static int fuse_export_create(BlockExport *blk_exp,
         ret = blk_set_perm(exp->common.blk, blk_perm | BLK_PERM_RESIZE,
                            blk_shared_perm, errp);
         if (ret < 0) {
-            return ret;
+            goto fail;
         }
     }
 
@@ -362,13 +420,23 @@ static int fuse_export_create(BlockExport *blk_exp,
 
     g_hash_table_insert(exports, g_strdup(exp->mountpoint), NULL);
 
-    exp->fuse_fd = fuse_session_fd(exp->fuse_session);
-    ret = qemu_fcntl_addfl(exp->fuse_fd, O_NONBLOCK);
+    assert(exp->num_queues >= 1);
+    exp->queues[0].fuse_fd = fuse_session_fd(exp->fuse_session);
+    ret = qemu_fcntl_addfl(exp->queues[0].fuse_fd, O_NONBLOCK);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to make FUSE FD non-blocking");
         goto fail;
     }
 
+    for (int i = 1; i < exp->num_queues; i++) {
+        int fd = clone_fuse_fd(exp->queues[0].fuse_fd, errp);
+        if (fd < 0) {
+            ret = fd;
+            goto fail;
+        }
+        exp->queues[i].fuse_fd = fd;
+    }
+
     fuse_attach_handlers(exp);
     return 0;
 
@@ -461,28 +529,28 @@ fail:
 /**
  * Allocate a buffer to receive WRITE data, or take the cached one.
  */
-static void *get_write_data_buffer(FuseExport *exp)
+static void *get_write_data_buffer(FuseQueue *q)
 {
-    if (exp->req_write_data_cached) {
-        void *cached = exp->req_write_data_cached;
-        exp->req_write_data_cached = NULL;
+    if (q->req_write_data_cached) {
+        void *cached = q->req_write_data_cached;
+        q->req_write_data_cached = NULL;
         return cached;
     } else {
-        return blk_blockalign(exp->common.blk, FUSE_MAX_WRITE_BYTES);
+        return blk_blockalign(q->exp->common.blk, FUSE_MAX_WRITE_BYTES);
     }
 }
 
 /**
  * Release a WRITE data buffer, possibly reusing it for a subsequent request.
  */
-static void release_write_data_buffer(FuseExport *exp, void **buffer)
+static void release_write_data_buffer(FuseQueue *q, void **buffer)
 {
     if (!*buffer) {
         return;
     }
 
-    if (!exp->req_write_data_cached) {
-        exp->req_write_data_cached = *buffer;
+    if (!q->req_write_data_cached) {
+        q->req_write_data_cached = *buffer;
     } else {
         qemu_vfree(*buffer);
     }
@@ -528,9 +596,42 @@ static ssize_t req_op_hdr_len(const FuseRequestInHeader *in_hdr)
     }
 }
 
+/**
+ * Clone the given /dev/fuse file descriptor, yielding a second FD from which
+ * requests can be pulled for the associated filesystem.  Returns an FD on
+ * success, and -errno on error.
+ */
+static int clone_fuse_fd(int fd, Error **errp)
+{
+    uint32_t src_fd = fd;
+    int new_fd;
+    int ret;
+
+    /*
+     * The name "/dev/fuse" is fixed, see libfuse's lib/fuse_loop_mt.c
+     * (fuse_clone_chan()).
+     */
+    new_fd = open("/dev/fuse", O_RDWR | O_CLOEXEC | O_NONBLOCK);
+    if (new_fd < 0) {
+        ret = -errno;
+        error_setg_errno(errp, errno, "Failed to open /dev/fuse");
+        return ret;
+    }
+
+    ret = ioctl(new_fd, FUSE_DEV_IOC_CLONE, &src_fd);
+    if (ret < 0) {
+        ret = -errno;
+        error_setg_errno(errp, errno, "Failed to clone FUSE FD");
+        close(new_fd);
+        return ret;
+    }
+
+    return new_fd;
+}
+
 /**
  * Try to read a single request from the FUSE FD.
- * Takes a FuseExport pointer in `opaque`.
+ * Takes a FuseQueue pointer in `opaque`.
  *
  * Assumes the export's in-flight counter has already been incremented.
  *
@@ -538,8 +639,9 @@ static ssize_t req_op_hdr_len(const FuseRequestInHeader *in_hdr)
  */
 static void coroutine_fn co_read_from_fuse_fd(void *opaque)
 {
-    FuseExport *exp = opaque;
-    int fuse_fd = exp->fuse_fd;
+    FuseQueue *q = opaque;
+    int fuse_fd = q->fuse_fd;
+    FuseExport *exp = q->exp;
     ssize_t ret;
     FuseRequestInHeaderBuf in_hdr_buf;
     const FuseRequestInHeader *in_hdr;
@@ -551,7 +653,7 @@ static void coroutine_fn co_read_from_fuse_fd(void *opaque)
         goto no_request;
     }
 
-    data_buffer = get_write_data_buffer(exp);
+    data_buffer = get_write_data_buffer(q);
 
     /* Construct the I/O vector to hold the FUSE request */
     iov[0] = (struct iovec) { &in_hdr_buf.head, sizeof(in_hdr_buf.head) };
@@ -612,29 +714,29 @@ static void coroutine_fn co_read_from_fuse_fd(void *opaque)
             memcpy(in_hdr_buf.tail, data_buffer, len);
         }
 
-        release_write_data_buffer(exp, &data_buffer);
+        release_write_data_buffer(q, &data_buffer);
     }
 
-    fuse_co_process_request(exp, in_hdr, data_buffer);
+    fuse_co_process_request(q, in_hdr, data_buffer);
 
 no_request:
-    release_write_data_buffer(exp, &data_buffer);
+    release_write_data_buffer(q, &data_buffer);
     fuse_dec_in_flight(exp);
 }
 
 /**
  * Try to read and process a single request from the FUSE FD.
  * (To be used as a handler for when the FUSE FD becomes readable.)
- * Takes a FuseExport pointer in `opaque`.
+ * Takes a FuseQueue pointer in `opaque`.
  */
 static void read_from_fuse_fd(void *opaque)
 {
-    FuseExport *exp = opaque;
+    FuseQueue *q = opaque;
     Coroutine *co;
 
-    co = qemu_coroutine_create(co_read_from_fuse_fd, exp);
+    co = qemu_coroutine_create(co_read_from_fuse_fd, q);
     /* Decremented by co_read_from_fuse_fd() */
-    fuse_inc_in_flight(exp);
+    fuse_inc_in_flight(q->exp);
     qemu_coroutine_enter(co);
 }
 
@@ -659,6 +761,17 @@ static void fuse_export_delete(BlockExport *blk_exp)
 {
     FuseExport *exp = container_of(blk_exp, FuseExport, common);
 
+    for (int i = 0; i < exp->num_queues; i++) {
+        FuseQueue *q = &exp->queues[i];
+
+        /* Queue 0's FD belongs to the FUSE session */
+        if (i > 0 && q->fuse_fd >= 0) {
+            close(q->fuse_fd);
+        }
+        qemu_vfree(q->req_write_data_cached);
+    }
+    g_free(exp->queues);
+
     if (exp->fuse_session) {
         if (exp->mounted) {
             fuse_session_unmount(exp->fuse_session);
@@ -667,7 +780,6 @@ static void fuse_export_delete(BlockExport *blk_exp)
         fuse_session_destroy(exp->fuse_session);
     }
 
-    qemu_vfree(exp->req_write_data_cached);
     g_free(exp->mountpoint);
 }
 
@@ -1344,10 +1456,11 @@ static int fuse_write_buf_response(int fd,
  * Process a FUSE request, incl. writing the response.
  */
 static void coroutine_fn
-fuse_co_process_request(FuseExport *exp, const FuseRequestInHeader *in_hdr,
+fuse_co_process_request(FuseQueue *q, const FuseRequestInHeader *in_hdr,
                         const void *data_buffer)
 {
     FuseRequestOutHeader out_hdr;
+    FuseExport *exp = q->exp;
     /* For read requests: Data to be returned */
     void *out_data_buffer = NULL;
     ssize_t ret;
@@ -1471,10 +1584,10 @@ fuse_co_process_request(FuseExport *exp, const FuseRequestInHeader *in_hdr,
     }
 
     if (out_data_buffer) {
-        fuse_write_buf_response(exp->fuse_fd, &out_hdr.common, out_data_buffer);
+        fuse_write_buf_response(q->fuse_fd, &out_hdr.common, out_data_buffer);
         qemu_vfree(out_data_buffer);
     } else {
-        fuse_write_response(exp->fuse_fd, &out_hdr);
+        fuse_write_response(q->fuse_fd, &out_hdr);
     }
 }
 
-- 
2.53.0


