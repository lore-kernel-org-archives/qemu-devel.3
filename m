Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDE5C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 11:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWZRo-0006gR-Ui; Tue, 01 Jul 2025 07:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZR4-0005m1-AN
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:46:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQx-0003fo-9e
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751370354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=apTE44HrBCLaFuuQZm7HtEFEO/u09gbTpH+Q+H5z9eQ=;
 b=RraMnKL3q4MHWH6+dDLTGaMtcSpc/sXsTOiZukhXM3qFpBwuPzRk4dVrsuTjBFBl7Vi7dl
 LajaMZRD8/VRGJzkteFHiCNwgVs2R/9PXOz63dKag7aa0pdUB0jNUw7QxSVXQjy2MxsIjO
 WoyMs7IJmKDZRFsA6BV9lGIlqSgbxPA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-Fo5K_tIcMWeqMNp7B19CQw-1; Tue, 01 Jul 2025 07:45:53 -0400
X-MC-Unique: Fo5K_tIcMWeqMNp7B19CQw-1
X-Mimecast-MFC-AGG-ID: Fo5K_tIcMWeqMNp7B19CQw_1751370352
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4538f375e86so29202295e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 04:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751370351; x=1751975151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=apTE44HrBCLaFuuQZm7HtEFEO/u09gbTpH+Q+H5z9eQ=;
 b=FrAn1V0/+ix8mLL49yYTwJn5L0YRPTC+uo1QG79K/JZajWl8dbAEi/8MudvWHTCWL/
 baQV+MZYVNzzBxytXqkAQ412S2bd9GS6P9K4UEjG2jlysjjvDTnbXSH1X0+eQDKzXiFY
 Rjy3jRPPbpsQpPZrYSrR4GbaNA4dKhgygntNLxlJ4PQwRNdmMKA9DvRNXHEHIAd7VK1M
 2s7E8/1p4mvsa3GT8nUuQRHYxAB3k/U5LMAcErZFKrbLxjMbc9WfFJhrBxNCeeXeeHEx
 T767xHnQq3acKQ5mLZWYoLvqhcGPO2+bQzM3EAfpuoxaG82pTDmER8+aI+VeYXa/niV4
 iC4g==
X-Gm-Message-State: AOJu0YyC0W4xB4MBOfKDWeExtZmZZY6KgxFhrEmFzU/UVQj9W1xlReEZ
 SoY2w4YmyhA9C6JonUvyvw6zkt6g/UMgRHtCVqCldhGnK7gubBZymbUwdgSQXXNT/5tE0gjJjcI
 Ytq9lSEdLOQhcdplnfxsN4HQDnorYZEbux+CQasecIgw4KIO8nNw5uPXQ7+gQL9M3
X-Gm-Gg: ASbGncus/nt4FG7n59eEaxq7MtEi5bqYRRcF8QSBGe4nqk85eR98GdnbK6jUxevmkre
 4XUBbvZijnG0IjrrthXePU1n+A73ZuNTTM6rRAYA0raCjKR7ap/ukZL0pehWwtlUo5SrOLQ/8Vt
 DGFnm+UQ1ypYIxVDlNruB+uRybnEOAmIoyef3QLcqJRohGwv8Xfa5O2tdSQGWNF1AhzXKuzUn2Q
 odXvxFUDlL4THvantLT94k0qc344AHLZN75d936bueC7eQCbUNQHNgfIPrz0oRCLDHLZD/E5xgc
 1CkCTvHg3csJHC9UK8FvVaKh5+1nmqlM5Bahbk1HPehpwb+7udSE2gaqob+Gj31YZdBGtlh1YdK
 G7qj4
X-Received: by 2002:a05:600c:3b86:b0:441:b00d:e9d1 with SMTP id
 5b1f17b1804b1-454a06a497bmr11468685e9.2.1751370351057; 
 Tue, 01 Jul 2025 04:45:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpFSF/XW67UQPnhg2EidQc4NBbXVWYD3M0WmuTG8ymS/RlumP3MZOEMaLLR7efZLxafugscw==
X-Received: by 2002:a05:600c:3b86:b0:441:b00d:e9d1 with SMTP id
 5b1f17b1804b1-454a06a497bmr11468155e9.2.1751370350514; 
 Tue, 01 Jul 2025 04:45:50 -0700 (PDT)
Received: from localhost
 (p200300cfd700f38d3df6a1ca7d40fe1f.dip0.t-ipconnect.de.
 [2003:cf:d700:f38d:3df6:a1ca:7d40:fe1f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823c463asm192863615e9.39.2025.07.01.04.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 04:45:49 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v3 21/21] fuse: Increase MAX_WRITE_SIZE with a second buffer
Date: Tue,  1 Jul 2025 13:44:37 +0200
Message-ID: <20250701114437.207419-22-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701114437.207419-1-hreitz@redhat.com>
References: <20250701114437.207419-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We probably want to support larger write sizes than just 4k; 64k seems
nice.  However, we cannot read partial requests from the FUSE FD, we
always have to read requests in full; so our read buffer must be large
enough to accommodate potential 64k writes if we want to support that.

Always allocating FuseRequest objects with 64k buffers in them seems
wasteful, though.  But we can get around the issue by splitting the
buffer into two and using readv(): One part will hold all normal (up to
4k) write requests and all other requests, and a second part (the
"spill-over buffer") will be used only for larger write requests.  Each
FuseQueue has its own spill-over buffer, and only if we find it used
when reading a request will we move its ownership into the FuseRequest
object and allocate a new spill-over buffer for the queue.

This way, we get to support "large" write sizes without having to
allocate big buffers when they aren't used.

Also, this even reduces the size of the FuseRequest objects because the
read buffer has to have at least FUSE_MIN_READ_BUFFER (8192) bytes; but
the requests we support are not quite so large (except for >4k writes),
so until now, we basically had to have useless padding in there.

With the spill-over buffer added, the FUSE_MIN_READ_BUFFER requirement
is easily met and we can decrease the size of the buffer portion that is
right inside of FuseRequest.

As for benchmarks, the benefit of this patch can be shown easily by
writing a 4G image (with qemu-img convert) to a FUSE export:
- Before this patch: Takes 25.6 s (14.4 s with -t none)
- After this patch: Takes 4.5 s (5.5 s with -t none)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 137 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 118 insertions(+), 19 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 4ae448bc14..c0ad4696ce 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -50,8 +50,17 @@
 
 /* Prevent overly long bounce buffer allocations */
 #define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 1 * 1024 * 1024))
-/* Small enough to fit in the request buffer */
-#define FUSE_MAX_WRITE_BYTES (4 * 1024)
+/*
+ * FUSE_MAX_WRITE_BYTES determines the maximum number of bytes we support in a
+ * write request; FUSE_IN_PLACE_WRITE_BYTES and FUSE_SPILLOVER_BUF_SIZE
+ * determine the split between the size of the in-place buffer in FuseRequest
+ * and the spill-over buffer in FuseQueue.  See FuseQueue.spillover_buf for a
+ * detailed explanation.
+ */
+#define FUSE_IN_PLACE_WRITE_BYTES (4 * 1024)
+#define FUSE_MAX_WRITE_BYTES (64 * 1024)
+#define FUSE_SPILLOVER_BUF_SIZE \
+    (FUSE_MAX_WRITE_BYTES - FUSE_IN_PLACE_WRITE_BYTES)
 
 typedef struct FuseExport FuseExport;
 
@@ -67,15 +76,49 @@ typedef struct FuseQueue {
 
     /*
      * The request buffer must be able to hold a full write, and/or at least
-     * FUSE_MIN_READ_BUFFER (from linux/fuse.h) bytes
+     * FUSE_MIN_READ_BUFFER (from linux/fuse.h) bytes.
+     * This however is just the first part of the buffer; every read is given
+     * a vector of this buffer (which should be enough for all normal requests,
+     * which we check via the static assertion in FUSE_IN_OP_STRUCT()) and the
+     * spill-over buffer below.
+     * Therefore, the size of this buffer plus FUSE_SPILLOVER_BUF_SIZE must be
+     * FUSE_MIN_READ_BUFFER or more (checked via static assertion below).
+     */
+    char request_buf[sizeof(struct fuse_in_header) +
+                     sizeof(struct fuse_write_in) +
+                     FUSE_IN_PLACE_WRITE_BYTES];
+
+    /*
+     * When retrieving a FUSE request, the destination buffer must always be
+     * sufficiently large for the whole request, i.e. with max_write=64k, we
+     * must provide a buffer that fits the WRITE header and 64 kB of space for
+     * data.
+     * We do want to support 64k write requests without requiring them to be
+     * split up, but at the same time, do not want to do such a large allocation
+     * for every single request.
+     * Therefore, the FuseRequest object provides an in-line buffer that is
+     * enough for write requests up to 4k (and all other requests), and for
+     * every request that is bigger, we provide a spill-over buffer here (for
+     * the remaining 64k - 4k = 60k).
+     * When poll_fuse_fd() reads a FUSE request, it passes these buffers as an
+     * I/O vector, and then checks the return value (number of bytes read) to
+     * find out whether the spill-over buffer was used.  If so, it will move the
+     * buffer to the request, and will allocate a new spill-over buffer for the
+     * next request.
+     *
+     * Free this buffer with qemu_vfree().
      */
-    char request_buf[MAX_CONST(
-        sizeof(struct fuse_in_header) + sizeof(struct fuse_write_in) +
-             FUSE_MAX_WRITE_BYTES,
-        FUSE_MIN_READ_BUFFER
-    )];
+    void *spillover_buf;
 } FuseQueue;
 
+/*
+ * Verify that FuseQueue.request_buf plus the spill-over buffer together
+ * are big enough to be accepted by the FUSE kernel driver.
+ */
+QEMU_BUILD_BUG_ON(sizeof(((FuseQueue *)0)->request_buf) +
+                  FUSE_SPILLOVER_BUF_SIZE <
+                  FUSE_MIN_READ_BUFFER);
+
 struct FuseExport {
     BlockExport common;
 
@@ -131,7 +174,8 @@ static int clone_fuse_fd(int fd, Error **errp);
 static bool is_regular_file(const char *path, Error **errp);
 
 static void read_from_fuse_fd(void *opaque);
-static void coroutine_fn fuse_co_process_request(FuseQueue *q);
+static void coroutine_fn
+fuse_co_process_request(FuseQueue *q, void *spillover_buf);
 
 static void fuse_inc_in_flight(FuseExport *exp)
 {
@@ -476,12 +520,27 @@ static void coroutine_fn co_read_from_fuse_fd(void *opaque)
     FuseExport *exp = q->exp;
     ssize_t ret;
     const struct fuse_in_header *in_hdr;
+    struct iovec iov[2];
+    void *spillover_buf = NULL;
 
     if (unlikely(exp->halted)) {
         goto no_request;
     }
 
-    ret = RETRY_ON_EINTR(read(fuse_fd, q->request_buf, sizeof(q->request_buf)));
+    /*
+     * If handling the last request consumed the spill-over buffer, allocate a
+     * new one.  Align it to the block device's alignment, which admittedly is
+     * only useful if FUSE_IN_PLACE_WRITE_BYTES is aligned, too.
+     */
+    if (unlikely(!q->spillover_buf)) {
+        q->spillover_buf = blk_blockalign(exp->common.blk,
+                                          FUSE_SPILLOVER_BUF_SIZE);
+    }
+    /* Construct the I/O vector to hold the FUSE request */
+    iov[0] = (struct iovec) { q->request_buf, sizeof(q->request_buf) };
+    iov[1] = (struct iovec) { q->spillover_buf, FUSE_SPILLOVER_BUF_SIZE };
+
+    ret = RETRY_ON_EINTR(readv(fuse_fd, iov, ARRAY_SIZE(iov)));
     if (ret < 0 && errno == EAGAIN) {
         /* No request available */
         goto no_request;
@@ -510,7 +569,13 @@ static void coroutine_fn co_read_from_fuse_fd(void *opaque)
         goto no_request;
     }
 
-    fuse_co_process_request(q);
+    if (unlikely(ret > sizeof(q->request_buf))) {
+        /* Spillover buffer used, take ownership */
+        spillover_buf = q->spillover_buf;
+        q->spillover_buf = NULL;
+    }
+
+    fuse_co_process_request(q, spillover_buf);
 
 no_request:
     fuse_dec_in_flight(exp);
@@ -560,6 +625,9 @@ static void fuse_export_delete(BlockExport *blk_exp)
         if (i > 0 && q->fuse_fd >= 0) {
             close(q->fuse_fd);
         }
+        if (q->spillover_buf) {
+            qemu_vfree(q->spillover_buf);
+        }
     }
     g_free(exp->queues);
 
@@ -869,17 +937,25 @@ fuse_co_read(FuseExport *exp, void **bufptr, uint64_t offset, uint32_t size)
 }
 
 /**
- * Handle client writes to the exported image.  @buf has the data to be written
- * and will be copied to a bounce buffer before yielding for the first time.
+ * Handle client writes to the exported image.  @in_place_buf has the first
+ * FUSE_IN_PLACE_WRITE_BYTES bytes of the data to be written, @spillover_buf
+ * contains the rest (if any; NULL otherwise).
+ * Data in @in_place_buf is assumed to be overwritten after yielding, so will
+ * be copied to a bounce buffer beforehand.  @spillover_buf in contrast is
+ * assumed to be exclusively owned and will be used as-is.
  * Return the number of bytes written to *out on success, and -errno on error.
  */
 static ssize_t coroutine_fn
 fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
-              uint64_t offset, uint32_t size, const void *buf)
+              uint64_t offset, uint32_t size,
+              const void *in_place_buf, const void *spillover_buf)
 {
+    size_t in_place_size;
     void *copied;
     int64_t blk_len;
     int ret;
+    struct iovec iov[2];
+    QEMUIOVector qiov;
 
     /* Limited by max_write, should not happen */
     if (size > BDRV_REQUEST_MAX_BYTES) {
@@ -891,8 +967,9 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
     }
 
     /* Must copy to bounce buffer before potentially yielding */
-    copied = blk_blockalign(exp->common.blk, size);
-    memcpy(copied, buf, size);
+    in_place_size = MIN(size, FUSE_IN_PLACE_WRITE_BYTES);
+    copied = blk_blockalign(exp->common.blk, in_place_size);
+    memcpy(copied, in_place_buf, in_place_size);
 
     /**
      * Clients will expect short writes at EOF, so we have to limit
@@ -916,7 +993,21 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
         }
     }
 
-    ret = blk_co_pwrite(exp->common.blk, offset, size, copied, 0);
+    iov[0] = (struct iovec) {
+        .iov_base = copied,
+        .iov_len = in_place_size,
+    };
+    if (size > FUSE_IN_PLACE_WRITE_BYTES) {
+        assert(size - FUSE_IN_PLACE_WRITE_BYTES <= FUSE_SPILLOVER_BUF_SIZE);
+        iov[1] = (struct iovec) {
+            .iov_base = (void *)spillover_buf,
+            .iov_len = size - FUSE_IN_PLACE_WRITE_BYTES,
+        };
+        qemu_iovec_init_external(&qiov, iov, 2);
+    } else {
+        qemu_iovec_init_external(&qiov, iov, 1);
+    }
+    ret = blk_co_pwritev(exp->common.blk, offset, size, &qiov, 0);
     if (ret < 0) {
         goto fail_free_buffer;
     }
@@ -1275,8 +1366,14 @@ static int fuse_write_buf_response(int fd, uint32_t req_id,
  * Note that yielding in any request-processing function can overwrite the
  * contents of q->request_buf.  Anything that takes a buffer needs to take
  * care that the content is copied before yielding.
+ *
+ * @spillover_buf can contain the tail of a write request too large to fit into
+ * q->request_buf.  This function takes ownership of it (i.e. will free it),
+ * which assumes that its contents will not be overwritten by concurrent
+ * requests (as opposed to q->request_buf).
  */
-static void coroutine_fn fuse_co_process_request(FuseQueue *q)
+static void coroutine_fn
+fuse_co_process_request(FuseQueue *q, void *spillover_buf)
 {
     FuseExport *exp = q->exp;
     uint32_t opcode;
@@ -1372,7 +1469,7 @@ static void coroutine_fn fuse_co_process_request(FuseQueue *q)
          * yielding.
          */
         ret = fuse_co_write(exp, FUSE_OUT_OP_STRUCT(write, out_buf),
-                            in->offset, in->size, in + 1);
+                            in->offset, in->size, in + 1, spillover_buf);
         break;
     }
 
@@ -1414,6 +1511,8 @@ static void coroutine_fn fuse_co_process_request(FuseQueue *q)
                             ret < 0 ? ret : 0,
                             ret < 0 ? 0 : ret);
     }
+
+    qemu_vfree(spillover_buf);
 }
 
 const BlockExportDriver blk_exp_fuse = {
-- 
2.49.0


