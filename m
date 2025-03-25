Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F407BC3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 16:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx6ol-00059R-6S; Tue, 25 Mar 2025 12:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tx6of-0004mp-Gi
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:07:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tx6ob-0007WA-OB
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742918864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1es1GLLwxEkCTyu3NIQVBVSJl87pq6gN18T+d/SedE4=;
 b=PHxQVP+SuPuIXaAR9PcXwPGqt9nzRpqvRGSYL09PH2Bp/ZLdVWrz1ZBodrnYdZQUvz2JaJ
 VZnT2OZdjKp7v9PywDFLytArAfkeL4/Ium0uChbQqg3LSSL24loWzHYqurapoBXF6196Wi
 jGM/jmY+07822Kd3dK0FNZ+p1JFRMVQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-891WnNXJMziLvz1QEjqXrw-1; Tue, 25 Mar 2025 12:07:41 -0400
X-MC-Unique: 891WnNXJMziLvz1QEjqXrw-1
X-Mimecast-MFC-AGG-ID: 891WnNXJMziLvz1QEjqXrw_1742918860
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3912539665cso3290777f8f.1
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 09:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742918859; x=1743523659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1es1GLLwxEkCTyu3NIQVBVSJl87pq6gN18T+d/SedE4=;
 b=WmhhhHYgCE73imEYeWDQyQdRO7KjYaMmkIOQc3xoCpR+VPgkqODo/9HbC0WzZE0keE
 U3bWacrBBi+0jvb6p+frWoVXP5VfPpI+FMBe3qsdPeXHF5eUTsocQYS5W6wpyLN8Qy3o
 pcAhkQJVkk0LzY8V5bja76BxEe9vUJKFwMSi4zXr1dTr/lJGoTLZTgeay6+fySv2b45N
 3D7QR28qD/yjSC3vHTw4psE/tF9lDerMGDXVWhtCEB+hT5s8OKQlGn7IwoxKslcSqiuy
 ecc9/cjE0MsOXJEaMaDjsLloVMfQp3HWZ9rPwgOZedtMPBApgTD27C/aJuVmM9eso1ea
 Utug==
X-Gm-Message-State: AOJu0YysUgXEuFRUzBdrsPBzFe51CUTG0ruJrwj07ckLhyBismNMzgad
 FTTVGmpAcuyki1r29Ai0lqKHt8vlnlmTqTiVzoT6reiexkCd5UbJR6bDWR1NqRRu6SL1Z7w7CTK
 XVqGJLSOZVBldS11PsKfqq6YHpj/SkvqDdjiW7FMMjoNpXNo+EGfifV3SykQw
X-Gm-Gg: ASbGncsGGKIFurVwdJ+wFHfuzVEgmMxGCoS0FqCTORAp2RmWMRD6FdXjZ/tjSuKNbbk
 LxWkX50UD9BXCJx5x3bB9WW5cVWJ3gROFjFpwMT1/Ls2M4hZXQHc/BUBhHxBUaz1gJA+TLMWg5V
 fUI0BMUeiIA2bGxRo7X5ug/OnScvL7uxVvhId2aTm6MyU1sCtVo2Utfc36br8tiqTNzlyQhy7uH
 D864NDatZHITcBV4GViFEyPmbNGlnzT/D7hnqfOJiEwc1x6HgICoAKdKT0VJwLdnT0pCtSuSJbT
 czcokSMckY8OoiMT+kc97iww6tCZlnvUgVkO/a3cgdLPNajJ+Hq0lhh9W9vg3qi15dDY7S8HTg=
 =
X-Received: by 2002:a05:6000:400a:b0:391:865:5a93 with SMTP id
 ffacd0b85a97d-39acc485440mr343121f8f.22.1742918858613; 
 Tue, 25 Mar 2025 09:07:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0mqXCT2sKfdk4792VP2AiQhRN9sb7936odygOMz25SHAztB2E3RzvG45vBRs+axvhWDkqCw==
X-Received: by 2002:a05:6000:400a:b0:391:865:5a93 with SMTP id
 ffacd0b85a97d-39acc485440mr343064f8f.22.1742918858053; 
 Tue, 25 Mar 2025 09:07:38 -0700 (PDT)
Received: from localhost
 (p200300cfd74f9db6ee8035b86ef736e5.dip0.t-ipconnect.de.
 [2003:cf:d74f:9db6:ee80:35b8:6ef7:36e5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9f0107sm14368892f8f.99.2025.03.25.09.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 09:07:37 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 15/15] fuse: Increase MAX_WRITE_SIZE with a second buffer
Date: Tue, 25 Mar 2025 17:06:55 +0100
Message-ID: <20250325160655.119407-14-hreitz@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325160529.117543-1-hreitz@redhat.com>
References: <20250325160529.117543-1-hreitz@redhat.com>
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

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 137 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 118 insertions(+), 19 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 0edd994392..a24c5538b3 100644
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
 
@@ -132,7 +175,8 @@ static bool is_regular_file(const char *path, Error **errp);
 
 static bool poll_fuse_fd(void *opaque);
 static void read_fuse_fd(void *opaque);
-static void coroutine_fn fuse_co_process_request(FuseQueue *q);
+static void coroutine_fn
+fuse_co_process_request(FuseQueue *q, void *spillover_buf);
 
 static void fuse_inc_in_flight(FuseExport *exp)
 {
@@ -494,6 +538,8 @@ static void coroutine_fn co_read_from_fuse_fd(void *opaque)
     FuseExport *exp = q->exp;
     ssize_t ret;
     const struct fuse_in_header *in_hdr;
+    struct iovec iov[2];
+    void *spillover_buf = NULL;
 
     fuse_inc_in_flight(exp);
 
@@ -501,7 +547,20 @@ static void coroutine_fn co_read_from_fuse_fd(void *opaque)
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
@@ -530,9 +589,15 @@ static void coroutine_fn co_read_from_fuse_fd(void *opaque)
         goto no_request;
     }
 
+    if (unlikely(ret > sizeof(q->request_buf))) {
+        /* Spillover buffer used, take ownership */
+        spillover_buf = q->spillover_buf;
+        q->spillover_buf = NULL;
+    }
+
     /* Must set this before yielding */
     co_param->got_request = 1;
-    fuse_co_process_request(q);
+    fuse_co_process_request(q, spillover_buf);
     fuse_dec_in_flight(exp);
     return;
 
@@ -607,6 +672,9 @@ static void fuse_export_delete(BlockExport *blk_exp)
         if (i > 0 && q->fuse_fd >= 0) {
             close(q->fuse_fd);
         }
+        if (q->spillover_buf) {
+            qemu_vfree(q->spillover_buf);
+        }
     }
     g_free(exp->queues);
 
@@ -915,17 +983,25 @@ fuse_co_read(FuseExport *exp, void **bufptr, uint64_t offset, uint32_t size)
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
@@ -937,8 +1013,9 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
     }
 
     /* Must copy to bounce buffer before potentially yielding */
-    copied = blk_blockalign(exp->common.blk, size);
-    memcpy(copied, buf, size);
+    in_place_size = MIN(size, FUSE_IN_PLACE_WRITE_BYTES);
+    copied = blk_blockalign(exp->common.blk, in_place_size);
+    memcpy(copied, in_place_buf, in_place_size);
 
     /**
      * Clients will expect short writes at EOF, so we have to limit
@@ -962,7 +1039,21 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
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
@@ -1321,8 +1412,14 @@ static int fuse_write_buf_response(int fd, uint32_t req_id,
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
@@ -1418,7 +1515,7 @@ static void coroutine_fn fuse_co_process_request(FuseQueue *q)
          * yielding.
          */
         ret = fuse_co_write(exp, FUSE_OUT_OP_STRUCT(write, out_buf),
-                            in->offset, in->size, in + 1);
+                            in->offset, in->size, in + 1, spillover_buf);
         break;
     }
 
@@ -1460,6 +1557,8 @@ static void coroutine_fn fuse_co_process_request(FuseQueue *q)
                             ret < 0 ? ret : 0,
                             ret < 0 ? 0 : ret);
     }
+
+    qemu_vfree(spillover_buf);
 }
 
 const BlockExportDriver blk_exp_fuse = {
-- 
2.48.1


