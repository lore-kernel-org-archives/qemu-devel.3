Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0BDFD4F04
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 16:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzvO-0003S9-Sz; Tue, 10 Mar 2026 12:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzvH-0003PW-Fp
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:27:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzvE-0000wH-VT
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773160023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LB/woqVlxsVC7/O7ZXNLjER0uo2c8Oe6KZpAiLrH3DE=;
 b=QLaypyQR0uLEqh1He7/j/fu27TJWNikiXH9p9ZCus5ArKoNvJtcFCOWUkGFvISC5UiL65j
 DTASLMspCrS4sazwCu7wc9zc1bzv4E9yUZmWo2rNchgKAH20MOYp8C21p26b4w1HcUxvLr
 rkmsg4ZsFKTv0k8teOGQMOsUESYo3ZA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-76i2CL3_PfmVr6-IARLzwg-1; Tue,
 10 Mar 2026 12:27:02 -0400
X-MC-Unique: 76i2CL3_PfmVr6-IARLzwg-1
X-Mimecast-MFC-AGG-ID: 76i2CL3_PfmVr6-IARLzwg_1773160021
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 648AC18005B8; Tue, 10 Mar 2026 16:27:01 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.224.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3FC4619560A6; Tue, 10 Mar 2026 16:27:00 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 19/28] fuse: Process requests in coroutines
Date: Tue, 10 Mar 2026 17:26:13 +0100
Message-ID: <20260310162622.333137-20-kwolf@redhat.com>
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

Make fuse_process_request() a coroutine_fn (fuse_co_process_request())
and have read_from_fuse_fd() launch it inside of a newly created
coroutine instead of running it synchronously.  This way, we can process
requests in parallel.

These are the benchmark results, compared to (a) the original results
with libfuse, and (b) the results after switching away from libfuse
(i.e. before this patch):

file:                (vs. libfuse / vs. no libfuse)
  read:
    seq aio:    97.8k ±1.5k (-2%  / -8%)
    rand aio:   95.8k ±3.4k (+90% / +98%)
    seq sync:   34.5k ±1.0k (-4%  / -3%)
    rand sync:   9.9k ±0.1k (-1%  / -1%)
  write:
    seq aio:    68.7k ±1.3k (-5%  / -10%)
    rand aio:   68.9k ±1.1k (-2%  / -10%)
    seq sync:   30.6k ±0.9k (±0%  / -3%)
    rand sync:  30.6k ±0.6k (+1%  / -1%)
null:
  read:
    seq aio:   174.5k ±6.8k (+11% / +8%)
    rand aio:  170.9k ±5.7k (+8%  / +3%)
    seq sync:   82.0k ±3.3k (+2%  / +2%)
    rand sync:  78.0k ±4.0k (+1%  / -1%)
  write:
    seq aio:   196.0k ±2.8k (+27% / +6%)
    rand aio:  191.2k ±7.9k (+24% / +2%)
    seq sync:   83.3k ±4.4k (+9%  / +1%)
    rand sync:  79.5k ±4.4k (+9%  / +1%)

So there is not much difference, especially when compared to how it was
with libfuse, except for the randread AIO case with an actual file.
That improves greatly.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20260309150856.26800-20-hreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/export/fuse.c | 176 ++++++++++++++++++++++++++------------------
 1 file changed, 104 insertions(+), 72 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index f32e74f39dd..7c072409d83 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -27,6 +27,7 @@
 #include "block/qapi.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-block.h"
+#include "qemu/coroutine.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "system/block-backend.h"
@@ -181,9 +182,9 @@ static int mount_fuse_export(FuseExport *exp, Error **errp);
 static bool is_regular_file(const char *path, Error **errp);
 
 static void read_from_fuse_fd(void *opaque);
-static void fuse_process_request(FuseExport *exp,
-                                 const FuseRequestInHeader *in_hdr,
-                                 const void *data_buffer);
+static void coroutine_fn
+fuse_co_process_request(FuseExport *exp, const FuseRequestInHeader *in_hdr,
+                        const void *data_buffer);
 static int fuse_write_err(int fd, const struct fuse_in_header *in_hdr, int err);
 
 static void fuse_inc_in_flight(FuseExport *exp)
@@ -518,9 +519,14 @@ static ssize_t req_op_hdr_len(const FuseRequestInHeader *in_hdr)
 }
 
 /**
- * Try to read and process a single request from the FUSE FD.
+ * Try to read a single request from the FUSE FD.
+ * Takes a FuseExport pointer in `opaque`.
+ *
+ * Assumes the export's in-flight counter has already been incremented.
+ *
+ * If a request is available, process it.
  */
-static void read_from_fuse_fd(void *opaque)
+static void coroutine_fn co_read_from_fuse_fd(void *opaque)
 {
     FuseExport *exp = opaque;
     int fuse_fd = exp->fuse_fd;
@@ -531,8 +537,6 @@ static void read_from_fuse_fd(void *opaque)
     struct iovec iov[2];
     ssize_t op_hdr_len;
 
-    fuse_inc_in_flight(exp);
-
     if (unlikely(qatomic_read(&exp->halted))) {
         goto no_request;
     }
@@ -601,13 +605,29 @@ static void read_from_fuse_fd(void *opaque)
         release_write_data_buffer(exp, &data_buffer);
     }
 
-    fuse_process_request(exp, in_hdr, data_buffer);
+    fuse_co_process_request(exp, in_hdr, data_buffer);
 
 no_request:
     release_write_data_buffer(exp, &data_buffer);
     fuse_dec_in_flight(exp);
 }
 
+/**
+ * Try to read and process a single request from the FUSE FD.
+ * (To be used as a handler for when the FUSE FD becomes readable.)
+ * Takes a FuseExport pointer in `opaque`.
+ */
+static void read_from_fuse_fd(void *opaque)
+{
+    FuseExport *exp = opaque;
+    Coroutine *co;
+
+    co = qemu_coroutine_create(co_read_from_fuse_fd, exp);
+    /* Decremented by co_read_from_fuse_fd() */
+    fuse_inc_in_flight(exp);
+    qemu_coroutine_enter(co);
+}
+
 static void fuse_export_shutdown(BlockExport *blk_exp)
 {
     FuseExport *exp = container_of(blk_exp, FuseExport, common);
@@ -682,8 +702,9 @@ static bool is_regular_file(const char *path, Error **errp)
  * Process FUSE INIT.
  * Return the number of bytes written to *out on success, and -errno on error.
  */
-static ssize_t fuse_init(FuseExport *exp, struct fuse_init_out *out,
-                         const struct fuse_init_in_compat *in)
+static ssize_t coroutine_fn GRAPH_RDLOCK
+fuse_co_init(FuseExport *exp, struct fuse_init_out *out,
+             const struct fuse_init_in_compat *in)
 {
     const uint32_t supported_flags = FUSE_ASYNC_READ | FUSE_ASYNC_DIO;
 
@@ -738,7 +759,8 @@ static ssize_t fuse_init(FuseExport *exp, struct fuse_init_out *out,
 /**
  * Return some filesystem information, just to not break e.g. `df`.
  */
-static ssize_t fuse_statfs(FuseExport *exp, struct fuse_statfs_out *out)
+static ssize_t coroutine_fn GRAPH_RDLOCK
+fuse_co_statfs(FuseExport *exp, struct fuse_statfs_out *out)
 {
     BlockDriverState *root_bs;
     uint32_t opt_transfer = 512;
@@ -766,17 +788,18 @@ static ssize_t fuse_statfs(FuseExport *exp, struct fuse_statfs_out *out)
  * Let clients get file attributes (i.e., stat() the file).
  * Return the number of bytes written to *out on success, and -errno on error.
  */
-static ssize_t fuse_getattr(FuseExport *exp, struct fuse_attr_out *out)
+static ssize_t coroutine_fn GRAPH_RDLOCK
+fuse_co_getattr(FuseExport *exp, struct fuse_attr_out *out)
 {
     int64_t length, allocated_blocks;
     time_t now = time(NULL);
 
-    length = blk_getlength(exp->common.blk);
+    length = blk_co_getlength(exp->common.blk);
     if (length < 0) {
         return length;
     }
 
-    allocated_blocks = bdrv_get_allocated_file_size(blk_bs(exp->common.blk));
+    allocated_blocks = bdrv_co_get_allocated_file_size(blk_bs(exp->common.blk));
     if (allocated_blocks <= 0) {
         allocated_blocks = DIV_ROUND_UP(length, 512);
     } else {
@@ -803,8 +826,9 @@ static ssize_t fuse_getattr(FuseExport *exp, struct fuse_attr_out *out)
     return sizeof(*out);
 }
 
-static int fuse_do_truncate(const FuseExport *exp, int64_t size,
-                            bool req_zero_write, PreallocMode prealloc)
+static int coroutine_fn GRAPH_RDLOCK
+fuse_co_do_truncate(const FuseExport *exp, int64_t size, bool req_zero_write,
+                    PreallocMode prealloc)
 {
     BdrvRequestFlags truncate_flags = 0;
 
@@ -812,8 +836,8 @@ static int fuse_do_truncate(const FuseExport *exp, int64_t size,
         truncate_flags |= BDRV_REQ_ZERO_WRITE;
     }
 
-    return blk_truncate(exp->common.blk, size, true, prealloc,
-                        truncate_flags, NULL);
+    return blk_co_truncate(exp->common.blk, size, true, prealloc,
+                           truncate_flags, NULL);
 }
 
 /**
@@ -825,9 +849,9 @@ static int fuse_do_truncate(const FuseExport *exp, int64_t size,
  * they cannot be given non-owner access.
  * Return the number of bytes written to *out on success, and -errno on error.
  */
-static ssize_t fuse_setattr(FuseExport *exp, struct fuse_attr_out *out,
-                            uint32_t to_set, uint64_t size, uint32_t mode,
-                            uint32_t uid, uint32_t gid)
+static ssize_t coroutine_fn GRAPH_RDLOCK
+fuse_co_setattr(FuseExport *exp, struct fuse_attr_out *out, uint32_t to_set,
+                uint64_t size, uint32_t mode, uint32_t uid, uint32_t gid)
 {
     int supported_attrs;
     int ret;
@@ -864,7 +888,7 @@ static ssize_t fuse_setattr(FuseExport *exp, struct fuse_attr_out *out,
             return -EACCES;
         }
 
-        ret = fuse_do_truncate(exp, size, true, PREALLOC_MODE_OFF);
+        ret = fuse_co_do_truncate(exp, size, true, PREALLOC_MODE_OFF);
         if (ret < 0) {
             return ret;
         }
@@ -883,7 +907,7 @@ static ssize_t fuse_setattr(FuseExport *exp, struct fuse_attr_out *out,
         exp->st_gid = gid;
     }
 
-    return fuse_getattr(exp, out);
+    return fuse_co_getattr(exp, out);
 }
 
 /**
@@ -891,7 +915,8 @@ static ssize_t fuse_setattr(FuseExport *exp, struct fuse_attr_out *out,
  * just acknowledge the request.
  * Return the number of bytes written to *out on success, and -errno on error.
  */
-static ssize_t fuse_open(FuseExport *exp, struct fuse_open_out *out)
+static ssize_t coroutine_fn GRAPH_RDLOCK
+fuse_co_open(FuseExport *exp, struct fuse_open_out *out)
 {
     *out = (struct fuse_open_out) {
         .open_flags = FOPEN_DIRECT_IO | FOPEN_PARALLEL_DIRECT_WRITES,
@@ -906,8 +931,8 @@ static ssize_t fuse_open(FuseExport *exp, struct fuse_open_out *out)
  * Note: If the returned size is 0, *bufptr will be set to NULL.
  * After use, *bufptr must be freed via qemu_vfree().
  */
-static ssize_t fuse_read(FuseExport *exp, void **bufptr,
-                         uint64_t offset, uint32_t size)
+static ssize_t coroutine_fn GRAPH_RDLOCK
+fuse_co_read(FuseExport *exp, void **bufptr, uint64_t offset, uint32_t size)
 {
     int64_t blk_len;
     void *buf;
@@ -922,7 +947,7 @@ static ssize_t fuse_read(FuseExport *exp, void **bufptr,
      * Clients will expect short reads at EOF, so we have to limit
      * offset+size to the image length.
      */
-    blk_len = blk_getlength(exp->common.blk);
+    blk_len = blk_co_getlength(exp->common.blk);
     if (blk_len < 0) {
         return blk_len;
     }
@@ -942,7 +967,7 @@ static ssize_t fuse_read(FuseExport *exp, void **bufptr,
         return -ENOMEM;
     }
 
-    ret = blk_pread(exp->common.blk, offset, size, buf, 0);
+    ret = blk_co_pread(exp->common.blk, offset, size, buf, 0);
     if (ret < 0) {
         qemu_vfree(buf);
         return ret;
@@ -956,8 +981,9 @@ static ssize_t fuse_read(FuseExport *exp, void **bufptr,
  * Handle client writes to the exported image.  @buf has the data to be written.
  * Return the number of bytes written to *out on success, and -errno on error.
  */
-static ssize_t fuse_write(FuseExport *exp, struct fuse_write_out *out,
-                          uint64_t offset, uint32_t size, const void *buf)
+static ssize_t coroutine_fn GRAPH_RDLOCK
+fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
+              uint64_t offset, uint32_t size, const void *buf)
 {
     int64_t blk_len;
     int ret;
@@ -976,7 +1002,7 @@ static ssize_t fuse_write(FuseExport *exp, struct fuse_write_out *out,
      * Clients will expect short writes at EOF, so we have to limit
      * offset+size to the image length.
      */
-    blk_len = blk_getlength(exp->common.blk);
+    blk_len = blk_co_getlength(exp->common.blk);
     if (blk_len < 0) {
         return blk_len;
     }
@@ -992,7 +1018,8 @@ static ssize_t fuse_write(FuseExport *exp, struct fuse_write_out *out,
         return -EINVAL;
     } else if (offset + size > blk_len) {
         if (exp->growable) {
-            ret = fuse_do_truncate(exp, offset + size, true, PREALLOC_MODE_OFF);
+            ret = fuse_co_do_truncate(exp, offset + size, true,
+                                      PREALLOC_MODE_OFF);
             if (ret < 0) {
                 return ret;
             }
@@ -1001,7 +1028,7 @@ static ssize_t fuse_write(FuseExport *exp, struct fuse_write_out *out,
         }
     }
 
-    ret = blk_pwrite(exp->common.blk, offset, size, buf, 0);
+    ret = blk_co_pwrite(exp->common.blk, offset, size, buf, 0);
     if (ret < 0) {
         return ret;
     }
@@ -1016,8 +1043,9 @@ static ssize_t fuse_write(FuseExport *exp, struct fuse_write_out *out,
  * Let clients perform various fallocate() operations.
  * Return 0 on success (no 'out' object), and -errno on error.
  */
-static ssize_t fuse_fallocate(FuseExport *exp, uint64_t offset, uint64_t length,
-                              uint32_t mode)
+static ssize_t coroutine_fn GRAPH_RDLOCK
+fuse_co_fallocate(FuseExport *exp,
+                  uint64_t offset, uint64_t length, uint32_t mode)
 {
     int64_t blk_len;
     int ret;
@@ -1026,7 +1054,7 @@ static ssize_t fuse_fallocate(FuseExport *exp, uint64_t offset, uint64_t length,
         return -EACCES;
     }
 
-    blk_len = blk_getlength(exp->common.blk);
+    blk_len = blk_co_getlength(exp->common.blk);
     if (blk_len < 0) {
         return blk_len;
     }
@@ -1045,14 +1073,14 @@ static ssize_t fuse_fallocate(FuseExport *exp, uint64_t offset, uint64_t length,
 
         if (offset > blk_len) {
             /* No preallocation needed here */
-            ret = fuse_do_truncate(exp, offset, true, PREALLOC_MODE_OFF);
+            ret = fuse_co_do_truncate(exp, offset, true, PREALLOC_MODE_OFF);
             if (ret < 0) {
                 return ret;
             }
         }
 
-        ret = fuse_do_truncate(exp, offset + length, true,
-                               PREALLOC_MODE_FALLOC);
+        ret = fuse_co_do_truncate(exp, offset + length, true,
+                                  PREALLOC_MODE_FALLOC);
     }
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
     else if (mode & FALLOC_FL_PUNCH_HOLE) {
@@ -1063,8 +1091,9 @@ static ssize_t fuse_fallocate(FuseExport *exp, uint64_t offset, uint64_t length,
         do {
             int size = MIN(length, BDRV_REQUEST_MAX_BYTES);
 
-            ret = blk_pwrite_zeroes(exp->common.blk, offset, size,
-                                    BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK);
+            ret = blk_co_pwrite_zeroes(exp->common.blk, offset, size,
+                                       BDRV_REQ_MAY_UNMAP |
+                                       BDRV_REQ_NO_FALLBACK);
             if (ret == -ENOTSUP) {
                 /*
                  * fallocate() specifies to return EOPNOTSUPP for unsupported
@@ -1082,8 +1111,8 @@ static ssize_t fuse_fallocate(FuseExport *exp, uint64_t offset, uint64_t length,
     else if (mode & FALLOC_FL_ZERO_RANGE) {
         if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + length > blk_len) {
             /* No need for zeroes, we are going to write them ourselves */
-            ret = fuse_do_truncate(exp, offset + length, false,
-                                   PREALLOC_MODE_OFF);
+            ret = fuse_co_do_truncate(exp, offset + length, false,
+                                      PREALLOC_MODE_OFF);
             if (ret < 0) {
                 return ret;
             }
@@ -1092,8 +1121,8 @@ static ssize_t fuse_fallocate(FuseExport *exp, uint64_t offset, uint64_t length,
         do {
             int size = MIN(length, BDRV_REQUEST_MAX_BYTES);
 
-            ret = blk_pwrite_zeroes(exp->common.blk,
-                                    offset, size, 0);
+            ret = blk_co_pwrite_zeroes(exp->common.blk,
+                                       offset, size, 0);
             offset += size;
             length -= size;
         } while (ret == 0 && length > 0);
@@ -1110,9 +1139,9 @@ static ssize_t fuse_fallocate(FuseExport *exp, uint64_t offset, uint64_t length,
  * Let clients fsync the exported image.
  * Return 0 on success (no 'out' object), and -errno on error.
  */
-static ssize_t fuse_fsync(FuseExport *exp)
+static ssize_t coroutine_fn GRAPH_RDLOCK fuse_co_fsync(FuseExport *exp)
 {
-    return blk_flush(exp->common.blk);
+    return blk_co_flush(exp->common.blk);
 }
 
 /**
@@ -1120,9 +1149,9 @@ static ssize_t fuse_fsync(FuseExport *exp)
  * notes this to be a way to return last-minute errors.)
  * Return 0 on success (no 'out' object), and -errno on error.
  */
-static ssize_t fuse_flush(FuseExport *exp)
+static ssize_t coroutine_fn GRAPH_RDLOCK fuse_co_flush(FuseExport *exp)
 {
-    return blk_flush(exp->common.blk);
+    return blk_co_flush(exp->common.blk);
 }
 
 #ifdef CONFIG_FUSE_LSEEK
@@ -1130,8 +1159,9 @@ static ssize_t fuse_flush(FuseExport *exp)
  * Let clients inquire allocation status.
  * Return the number of bytes written to *out on success, and -errno on error.
  */
-static ssize_t fuse_lseek(FuseExport *exp, struct fuse_lseek_out *out,
-                          uint64_t offset, uint32_t whence)
+static ssize_t coroutine_fn GRAPH_RDLOCK
+fuse_co_lseek(FuseExport *exp, struct fuse_lseek_out *out,
+              uint64_t offset, uint32_t whence)
 {
     if (whence != SEEK_HOLE && whence != SEEK_DATA) {
         return -EINVAL;
@@ -1141,8 +1171,8 @@ static ssize_t fuse_lseek(FuseExport *exp, struct fuse_lseek_out *out,
         int64_t pnum;
         int ret;
 
-        ret = bdrv_block_status_above(blk_bs(exp->common.blk), NULL,
-                                      offset, INT64_MAX, &pnum, NULL, NULL);
+        ret = bdrv_co_block_status_above(blk_bs(exp->common.blk), NULL,
+                                         offset, INT64_MAX, &pnum, NULL, NULL);
         if (ret < 0) {
             return ret;
         }
@@ -1159,7 +1189,7 @@ static ssize_t fuse_lseek(FuseExport *exp, struct fuse_lseek_out *out,
              * and @blk_len (the client-visible EOF).
              */
 
-            blk_len = blk_getlength(exp->common.blk);
+            blk_len = blk_co_getlength(exp->common.blk);
             if (blk_len < 0) {
                 return blk_len;
             }
@@ -1303,18 +1333,20 @@ static int fuse_write_buf_response(int fd,
 /**
  * Process a FUSE request, incl. writing the response.
  */
-static void fuse_process_request(FuseExport *exp,
-                                 const FuseRequestInHeader *in_hdr,
-                                 const void *data_buffer)
+static void coroutine_fn
+fuse_co_process_request(FuseExport *exp, const FuseRequestInHeader *in_hdr,
+                        const void *data_buffer)
 {
     FuseRequestOutHeader out_hdr;
     /* For read requests: Data to be returned */
     void *out_data_buffer = NULL;
     ssize_t ret;
 
+    GRAPH_RDLOCK_GUARD();
+
     switch (in_hdr->common.opcode) {
     case FUSE_INIT:
-        ret = fuse_init(exp, &out_hdr.init, &in_hdr->init);
+        ret = fuse_co_init(exp, &out_hdr.init, &in_hdr->init);
         break;
 
     case FUSE_DESTROY:
@@ -1322,11 +1354,11 @@ static void fuse_process_request(FuseExport *exp,
         break;
 
     case FUSE_STATFS:
-        ret = fuse_statfs(exp, &out_hdr.statfs);
+        ret = fuse_co_statfs(exp, &out_hdr.statfs);
         break;
 
     case FUSE_OPEN:
-        ret = fuse_open(exp, &out_hdr.open);
+        ret = fuse_co_open(exp, &out_hdr.open);
         break;
 
     case FUSE_RELEASE:
@@ -1343,19 +1375,19 @@ static void fuse_process_request(FuseExport *exp,
         return;
 
     case FUSE_GETATTR:
-        ret = fuse_getattr(exp, &out_hdr.attr);
+        ret = fuse_co_getattr(exp, &out_hdr.attr);
         break;
 
     case FUSE_SETATTR: {
         const struct fuse_setattr_in *in = &in_hdr->setattr;
-        ret = fuse_setattr(exp, &out_hdr.attr,
-                           in->valid, in->size, in->mode, in->uid, in->gid);
+        ret = fuse_co_setattr(exp, &out_hdr.attr,
+                              in->valid, in->size, in->mode, in->uid, in->gid);
         break;
     }
 
     case FUSE_READ: {
         const struct fuse_read_in *in = &in_hdr->read;
-        ret = fuse_read(exp, &out_data_buffer, in->offset, in->size);
+        ret = fuse_co_read(exp, &out_data_buffer, in->offset, in->size);
         break;
     }
 
@@ -1373,36 +1405,36 @@ static void fuse_process_request(FuseExport *exp,
         }
 
         /*
-         * read_from_fuse_fd() has checked that in_hdr->len matches the number
-         * of bytes read, which cannot exceed the max_write value we set
+         * co_read_from_fuse_fd() has checked that in_hdr->len matches the
+         * number of bytes read, which cannot exceed the max_write value we set
          * (FUSE_MAX_WRITE_BYTES).  So we know that FUSE_MAX_WRITE_BYTES >=
          * in_hdr->len >= in->size + X, so this assertion must hold.
          */
         assert(in->size <= FUSE_MAX_WRITE_BYTES);
 
-        ret = fuse_write(exp, &out_hdr.write,
-                         in->offset, in->size, data_buffer);
+        ret = fuse_co_write(exp, &out_hdr.write,
+                            in->offset, in->size, data_buffer);
         break;
     }
 
     case FUSE_FALLOCATE: {
         const struct fuse_fallocate_in *in = &in_hdr->fallocate;
-        ret = fuse_fallocate(exp, in->offset, in->length, in->mode);
+        ret = fuse_co_fallocate(exp, in->offset, in->length, in->mode);
         break;
     }
 
     case FUSE_FSYNC:
-        ret = fuse_fsync(exp);
+        ret = fuse_co_fsync(exp);
         break;
 
     case FUSE_FLUSH:
-        ret = fuse_flush(exp);
+        ret = fuse_co_flush(exp);
         break;
 
 #ifdef CONFIG_FUSE_LSEEK
     case FUSE_LSEEK: {
         const struct fuse_lseek_in *in = &in_hdr->lseek;
-        ret = fuse_lseek(exp, &out_hdr.lseek, in->offset, in->whence);
+        ret = fuse_co_lseek(exp, &out_hdr.lseek, in->offset, in->whence);
         break;
     }
 #endif
-- 
2.53.0


