Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6908DE9A049
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 13:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vshfh-0004IF-M2; Wed, 18 Feb 2026 08:32:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfe-0004Ev-Tk
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfT-0005pY-8W
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771421557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hC0XQ436Lp4KW+507FjuStJRdl+9Hpi0tG50/F5Xsmg=;
 b=KddgW/6Av0EVYYNdORWdgeNZTRDkBCWt0/4l7CWuuuyF9gPOPybIs+sj4xso0RWELFonDq
 ZP9DWlxHcLxuEU8xeCBWJ64/Etby2nFCVOau/nP1my/R/4Kzb/PEb+YfVD5PDfRINAWckM
 tlxxe4/9XCqUMnNrt8A7THu+hi5biOQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-5hH5UpFdOxymyHA70RAEEQ-1; Wed, 18 Feb 2026 08:27:30 -0500
X-MC-Unique: 5hH5UpFdOxymyHA70RAEEQ-1
X-Mimecast-MFC-AGG-ID: 5hH5UpFdOxymyHA70RAEEQ_1771421250
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-437681ecd32so4394591f8f.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 05:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771421249; x=1772026049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hC0XQ436Lp4KW+507FjuStJRdl+9Hpi0tG50/F5Xsmg=;
 b=mkjzVpXLLrmsUtYIC1saRf7lYO76GNhqNixeamT1ktFA2VrO61xfZ5c4Ap9uH/beOj
 jss514UoNGBRRsiR4aOxRBTC+85hPOG3x6rwf5O4VaDl0gCS/xVOyzFxXBH/tjcyaqXg
 OBefCqis+jtWoN2dcvdEzBRoPZoVfP3cXtM88A+CHV1aQO/SZoTmoyxN4Jhbr47xwx/g
 l97QUlOq2APegnu+2iDlojax0lRjBrMMkGqPzY11N23rFqaHBeJneguP8dnbxiJKaX92
 N1e1S7eXL//eO+MHQaZBz/uCb9wiqeDnIRmRJuALPFbAV7I8TbRzXJp8Ew0XPNjQfUF5
 E+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771421249; x=1772026049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hC0XQ436Lp4KW+507FjuStJRdl+9Hpi0tG50/F5Xsmg=;
 b=MeQ6QUQl6e9cFTXb5Yp7i1dfy4NokAxobuBp5L3NEcK4zqNRvqCsk1753/Qsb7FuqO
 fzmno4eFmYZIfqZvnmPRO4HDnG9YDnCDMxfHqJ2vyGXG6cJL1cD3N0EpmtCV9ONhBkVo
 0q4kS8MwwglV+Js64RxVLCjrDJ283WJS7FzEQ53ZLzigApTeOxKG3svP+3Yod9s94rBj
 5LC/HCDCANe0mJQbxFBRELjYrZe8RlXVILvI5Fzag/NGfkOrrv4T73g/fyssH9Yb9msj
 j6bWW+FYCHSTAIK/dqkIPlzkCvJZwX7tw2e7VLGToQeBoQPzLNyTKnUAf5iPZoqmigXH
 eVYQ==
X-Gm-Message-State: AOJu0Yxl/EPT57QCWZr2URFQ5kJNnAZpdiqttNHHYNwSSGCMEyUtHfMI
 ODDbpwt9gWbS2whibTcf9nqdg0fHVAXmo+Nrt+/n369U0lsxhSDCUhRTDy/1rMKRV3EoiRmn1sD
 zKi1ifRDm8s/NCRYATuVWvUacOXT1+Q63WJIMkW9Uhy4TIvK5qqSuM+zf
X-Gm-Gg: AZuq6aIedWPFO7oVVxnZYxJyKbnyZ3M8yp06j/kiZ18BWb80FNEx56zI/PZfgFwjH1x
 ggJoGvAvSaKrkKiIYWCTiKwFniXp3HruPfEb73XerVDEZDAUnpsj1zZdm+aAq/xzOZaQRqQhAXa
 1JFjwyvrPcZFUTaFEg5zBlbGysFpkR8RfJuHbr98duln3ajfQ7z0BHMc+d7rkdi/Y0qW1w4AwEg
 6CvurhuRd/VjxqDYw11tLAwGfDgSDwOBYhC9eQI+5KjHESgGSOTSRYHe4n0nCefZug2aap37V5p
 Pgo3N7cFJWXA2dUio79eUwsPLm6M62iYGFyrOK5ro1p2wSWVQWnRVfs8tBMcxjWf4yPuu84a3v5
 N6xWavQz5v6Hk1oko3iez2Uo9o6dxCzG21w7okvKXaoPB1LgiwFpfuSZR2bX22+lQaDCgtzwfUt
 JiAk6a
X-Received: by 2002:a05:6000:2c01:b0:437:6d8c:c07f with SMTP id
 ffacd0b85a97d-4379dba4416mr24878176f8f.52.1771421249092; 
 Wed, 18 Feb 2026 05:27:29 -0800 (PST)
X-Received: by 2002:a05:6000:2c01:b0:437:6d8c:c07f with SMTP id
 ffacd0b85a97d-4379dba4416mr24878113f8f.52.1771421248407; 
 Wed, 18 Feb 2026 05:27:28 -0800 (PST)
Received: from localhost
 (p200300cfd737d029edef7b8da7441ac2.dip0.t-ipconnect.de.
 [2003:cf:d737:d029:edef:7b8d:a744:1ac2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a74918sm41909165f8f.17.2026.02.18.05.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 05:27:27 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v4 18/24] fuse: Process requests in coroutines
Date: Wed, 18 Feb 2026 14:26:27 +0100
Message-ID: <20260218132633.29748-19-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218132633.29748-1-hreitz@redhat.com>
References: <20260218132633.29748-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 block/export/fuse.c | 174 ++++++++++++++++++++++++++------------------
 1 file changed, 102 insertions(+), 72 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 8c5a1d397d..b60affe86b 100644
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
@@ -182,9 +183,9 @@ static int mount_fuse_export(FuseExport *exp, Error **errp);
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
@@ -519,9 +520,14 @@ static ssize_t req_op_hdr_len(const FuseRequestInHeader *in_hdr)
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
@@ -532,8 +538,6 @@ static void read_from_fuse_fd(void *opaque)
     struct iovec iov[2];
     ssize_t op_hdr_len;
 
-    fuse_inc_in_flight(exp);
-
     if (unlikely(qatomic_read(&exp->halted))) {
         goto no_request;
     }
@@ -602,13 +606,29 @@ static void read_from_fuse_fd(void *opaque)
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
@@ -683,8 +703,9 @@ static bool is_regular_file(const char *path, Error **errp)
  * Process FUSE INIT.
  * Return the number of bytes written to *out on success, and -errno on error.
  */
-static ssize_t fuse_init(FuseExport *exp, struct fuse_init_out *out,
-                         const struct fuse_init_in_compat *in)
+static ssize_t coroutine_fn
+fuse_co_init(FuseExport *exp, struct fuse_init_out *out,
+             const struct fuse_init_in_compat *in)
 {
     const uint32_t supported_flags = FUSE_ASYNC_READ | FUSE_ASYNC_DIO;
 
@@ -739,7 +760,8 @@ static ssize_t fuse_init(FuseExport *exp, struct fuse_init_out *out,
 /**
  * Return some filesystem information, just to not break e.g. `df`.
  */
-static ssize_t fuse_statfs(FuseExport *exp, struct fuse_statfs_out *out)
+static ssize_t coroutine_fn
+fuse_co_statfs(FuseExport *exp, struct fuse_statfs_out *out)
 {
     BlockDriverState *root_bs;
     uint32_t opt_transfer = 512;
@@ -767,17 +789,18 @@ static ssize_t fuse_statfs(FuseExport *exp, struct fuse_statfs_out *out)
  * Let clients get file attributes (i.e., stat() the file).
  * Return the number of bytes written to *out on success, and -errno on error.
  */
-static ssize_t fuse_getattr(FuseExport *exp, struct fuse_attr_out *out)
+static ssize_t coroutine_fn
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
@@ -804,8 +827,9 @@ static ssize_t fuse_getattr(FuseExport *exp, struct fuse_attr_out *out)
     return sizeof(*out);
 }
 
-static int fuse_do_truncate(const FuseExport *exp, int64_t size,
-                            bool req_zero_write, PreallocMode prealloc)
+static int coroutine_fn
+fuse_co_do_truncate(const FuseExport *exp, int64_t size, bool req_zero_write,
+                    PreallocMode prealloc)
 {
     uint64_t blk_perm, blk_shared_perm;
     BdrvRequestFlags truncate_flags = 0;
@@ -834,8 +858,8 @@ static int fuse_do_truncate(const FuseExport *exp, int64_t size,
         }
     }
 
-    ret = blk_truncate(exp->common.blk, size, true, prealloc,
-                       truncate_flags, NULL);
+    ret = blk_co_truncate(exp->common.blk, size, true, prealloc,
+                          truncate_flags, NULL);
 
     if (add_resize_perm) {
         /* Must succeed, because we are only giving up the RESIZE permission */
@@ -856,9 +880,9 @@ static int fuse_do_truncate(const FuseExport *exp, int64_t size,
  * they cannot be given non-owner access.
  * Return the number of bytes written to *out on success, and -errno on error.
  */
-static ssize_t fuse_setattr(FuseExport *exp, struct fuse_attr_out *out,
-                            uint32_t to_set, uint64_t size, uint32_t mode,
-                            uint32_t uid, uint32_t gid)
+static ssize_t coroutine_fn
+fuse_co_setattr(FuseExport *exp, struct fuse_attr_out *out, uint32_t to_set,
+                uint64_t size, uint32_t mode, uint32_t uid, uint32_t gid)
 {
     int supported_attrs;
     int ret;
@@ -895,7 +919,7 @@ static ssize_t fuse_setattr(FuseExport *exp, struct fuse_attr_out *out,
             return -EACCES;
         }
 
-        ret = fuse_do_truncate(exp, size, true, PREALLOC_MODE_OFF);
+        ret = fuse_co_do_truncate(exp, size, true, PREALLOC_MODE_OFF);
         if (ret < 0) {
             return ret;
         }
@@ -914,7 +938,7 @@ static ssize_t fuse_setattr(FuseExport *exp, struct fuse_attr_out *out,
         exp->st_gid = gid;
     }
 
-    return fuse_getattr(exp, out);
+    return fuse_co_getattr(exp, out);
 }
 
 /**
@@ -922,7 +946,8 @@ static ssize_t fuse_setattr(FuseExport *exp, struct fuse_attr_out *out,
  * just acknowledge the request.
  * Return the number of bytes written to *out on success, and -errno on error.
  */
-static ssize_t fuse_open(FuseExport *exp, struct fuse_open_out *out)
+static ssize_t coroutine_fn
+fuse_co_open(FuseExport *exp, struct fuse_open_out *out)
 {
     *out = (struct fuse_open_out) {
         .open_flags = FOPEN_DIRECT_IO | FOPEN_PARALLEL_DIRECT_WRITES,
@@ -936,8 +961,8 @@ static ssize_t fuse_open(FuseExport *exp, struct fuse_open_out *out)
  * Returns the buffer (read) size on success, and -errno on error.
  * After use, *bufptr must be freed via qemu_vfree().
  */
-static ssize_t fuse_read(FuseExport *exp, void **bufptr,
-                         uint64_t offset, uint32_t size)
+static ssize_t coroutine_fn
+fuse_co_read(FuseExport *exp, void **bufptr, uint64_t offset, uint32_t size)
 {
     int64_t blk_len;
     void *buf;
@@ -952,7 +977,7 @@ static ssize_t fuse_read(FuseExport *exp, void **bufptr,
      * Clients will expect short reads at EOF, so we have to limit
      * offset+size to the image length.
      */
-    blk_len = blk_getlength(exp->common.blk);
+    blk_len = blk_co_getlength(exp->common.blk);
     if (blk_len < 0) {
         return blk_len;
     }
@@ -971,7 +996,7 @@ static ssize_t fuse_read(FuseExport *exp, void **bufptr,
         return -ENOMEM;
     }
 
-    ret = blk_pread(exp->common.blk, offset, size, buf, 0);
+    ret = blk_co_pread(exp->common.blk, offset, size, buf, 0);
     if (ret < 0) {
         qemu_vfree(buf);
         return ret;
@@ -985,8 +1010,9 @@ static ssize_t fuse_read(FuseExport *exp, void **bufptr,
  * Handle client writes to the exported image.  @buf has the data to be written.
  * Return the number of bytes written to *out on success, and -errno on error.
  */
-static ssize_t fuse_write(FuseExport *exp, struct fuse_write_out *out,
-                          uint64_t offset, uint32_t size, const void *buf)
+static ssize_t coroutine_fn
+fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
+              uint64_t offset, uint32_t size, const void *buf)
 {
     int64_t blk_len;
     int ret;
@@ -1005,7 +1031,7 @@ static ssize_t fuse_write(FuseExport *exp, struct fuse_write_out *out,
      * Clients will expect short writes at EOF, so we have to limit
      * offset+size to the image length.
      */
-    blk_len = blk_getlength(exp->common.blk);
+    blk_len = blk_co_getlength(exp->common.blk);
     if (blk_len < 0) {
         return blk_len;
     }
@@ -1021,7 +1047,8 @@ static ssize_t fuse_write(FuseExport *exp, struct fuse_write_out *out,
         return -EINVAL;
     } else if (offset + size > blk_len) {
         if (exp->growable) {
-            ret = fuse_do_truncate(exp, offset + size, true, PREALLOC_MODE_OFF);
+            ret = fuse_co_do_truncate(exp, offset + size, true,
+                                      PREALLOC_MODE_OFF);
             if (ret < 0) {
                 return ret;
             }
@@ -1030,7 +1057,7 @@ static ssize_t fuse_write(FuseExport *exp, struct fuse_write_out *out,
         }
     }
 
-    ret = blk_pwrite(exp->common.blk, offset, size, buf, 0);
+    ret = blk_co_pwrite(exp->common.blk, offset, size, buf, 0);
     if (ret < 0) {
         return ret;
     }
@@ -1045,8 +1072,9 @@ static ssize_t fuse_write(FuseExport *exp, struct fuse_write_out *out,
  * Let clients perform various fallocate() operations.
  * Return 0 on success (no 'out' object), and -errno on error.
  */
-static ssize_t fuse_fallocate(FuseExport *exp, uint64_t offset, uint64_t length,
-                              uint32_t mode)
+static ssize_t coroutine_fn
+fuse_co_fallocate(FuseExport *exp,
+                  uint64_t offset, uint64_t length, uint32_t mode)
 {
     int64_t blk_len;
     int ret;
@@ -1055,7 +1083,7 @@ static ssize_t fuse_fallocate(FuseExport *exp, uint64_t offset, uint64_t length,
         return -EACCES;
     }
 
-    blk_len = blk_getlength(exp->common.blk);
+    blk_len = blk_co_getlength(exp->common.blk);
     if (blk_len < 0) {
         return blk_len;
     }
@@ -1074,14 +1102,14 @@ static ssize_t fuse_fallocate(FuseExport *exp, uint64_t offset, uint64_t length,
 
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
@@ -1092,8 +1120,9 @@ static ssize_t fuse_fallocate(FuseExport *exp, uint64_t offset, uint64_t length,
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
@@ -1111,8 +1140,8 @@ static ssize_t fuse_fallocate(FuseExport *exp, uint64_t offset, uint64_t length,
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
@@ -1121,8 +1150,8 @@ static ssize_t fuse_fallocate(FuseExport *exp, uint64_t offset, uint64_t length,
         do {
             int size = MIN(length, BDRV_REQUEST_MAX_BYTES);
 
-            ret = blk_pwrite_zeroes(exp->common.blk,
-                                    offset, size, 0);
+            ret = blk_co_pwrite_zeroes(exp->common.blk,
+                                       offset, size, 0);
             offset += size;
             length -= size;
         } while (ret == 0 && length > 0);
@@ -1139,9 +1168,9 @@ static ssize_t fuse_fallocate(FuseExport *exp, uint64_t offset, uint64_t length,
  * Let clients fsync the exported image.
  * Return 0 on success (no 'out' object), and -errno on error.
  */
-static ssize_t fuse_fsync(FuseExport *exp)
+static ssize_t coroutine_fn fuse_co_fsync(FuseExport *exp)
 {
-    return blk_flush(exp->common.blk);
+    return blk_co_flush(exp->common.blk);
 }
 
 /**
@@ -1149,9 +1178,9 @@ static ssize_t fuse_fsync(FuseExport *exp)
  * notes this to be a way to return last-minute errors.)
  * Return 0 on success (no 'out' object), and -errno on error.
  */
-static ssize_t fuse_flush(FuseExport *exp)
+static ssize_t coroutine_fn fuse_co_flush(FuseExport *exp)
 {
-    return blk_flush(exp->common.blk);
+    return blk_co_flush(exp->common.blk);
 }
 
 #ifdef CONFIG_FUSE_LSEEK
@@ -1159,8 +1188,9 @@ static ssize_t fuse_flush(FuseExport *exp)
  * Let clients inquire allocation status.
  * Return the number of bytes written to *out on success, and -errno on error.
  */
-static ssize_t fuse_lseek(FuseExport *exp, struct fuse_lseek_out *out,
-                          uint64_t offset, uint32_t whence)
+static ssize_t coroutine_fn
+fuse_co_lseek(FuseExport *exp, struct fuse_lseek_out *out,
+              uint64_t offset, uint32_t whence)
 {
     if (whence != SEEK_HOLE && whence != SEEK_DATA) {
         return -EINVAL;
@@ -1170,8 +1200,8 @@ static ssize_t fuse_lseek(FuseExport *exp, struct fuse_lseek_out *out,
         int64_t pnum;
         int ret;
 
-        ret = bdrv_block_status_above(blk_bs(exp->common.blk), NULL,
-                                      offset, INT64_MAX, &pnum, NULL, NULL);
+        ret = bdrv_co_block_status_above(blk_bs(exp->common.blk), NULL,
+                                         offset, INT64_MAX, &pnum, NULL, NULL);
         if (ret < 0) {
             return ret;
         }
@@ -1188,7 +1218,7 @@ static ssize_t fuse_lseek(FuseExport *exp, struct fuse_lseek_out *out,
              * and @blk_len (the client-visible EOF).
              */
 
-            blk_len = blk_getlength(exp->common.blk);
+            blk_len = blk_co_getlength(exp->common.blk);
             if (blk_len < 0) {
                 return blk_len;
             }
@@ -1332,9 +1362,9 @@ static int fuse_write_buf_response(int fd,
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
@@ -1343,7 +1373,7 @@ static void fuse_process_request(FuseExport *exp,
 
     switch (in_hdr->common.opcode) {
     case FUSE_INIT:
-        ret = fuse_init(exp, &out_hdr.init, &in_hdr->init);
+        ret = fuse_co_init(exp, &out_hdr.init, &in_hdr->init);
         break;
 
     case FUSE_DESTROY:
@@ -1351,11 +1381,11 @@ static void fuse_process_request(FuseExport *exp,
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
@@ -1372,19 +1402,19 @@ static void fuse_process_request(FuseExport *exp,
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
 
@@ -1402,36 +1432,36 @@ static void fuse_process_request(FuseExport *exp,
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


