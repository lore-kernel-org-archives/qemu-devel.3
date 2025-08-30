Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686E1CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNqM-0000XR-M8; Sat, 30 Aug 2025 11:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1usBg5-0003bM-7J; Fri, 29 Aug 2025 22:50:53 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1usBg2-00087U-B7; Fri, 29 Aug 2025 22:50:52 -0400
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4b297962b24so29026821cf.2; 
 Fri, 29 Aug 2025 19:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756522249; x=1757127049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XAdEckVxs7wUU52+bCeoIAHQ38yDPI3pC7AsOopH9Xw=;
 b=NSfGp42vA0XD8E87pUX1+6tVPl4vjohFL4SpTsAStF7TKAmqSE+XVZpRi+0amFb6M9
 0W8BufaQg+3iSx5BQD2oYpa05UynekaEO8h3xO6b+5obPalZxt0z/LKKxu2waisHa8GY
 YO/6GpfOlbBMLhEtN3q4CyDohZbhiDoIQsRn02lS3VASTOf05qCUeIyrB6KicMmxReyV
 cfEHul1Gm2eB3x+MxrbTdvQKCWc4y6v+UWSpMvj/5MN44RiUO60umnDhR5DCQ8SH9Aa7
 /Y5KgguRaYQl8FCAEE9UQT8cuDfnOcTzmJ2sFb5r2XYHlIwzXGX6VIKkMXMOCt/eRtLO
 kcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756522249; x=1757127049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XAdEckVxs7wUU52+bCeoIAHQ38yDPI3pC7AsOopH9Xw=;
 b=nATgD9mihFqV5AyHru/sTLwu9kNq6R1hU3AO3Z7YNIiPl7SWGm2GqIlirSrHCjpYQp
 ey//bvRUPv8giImowS1v8fRJFVSAQENGFBUU2tFm7ewiTTv6FHT6zQvZ/McgTufhazqW
 9qw4UsLdq8v1ztIAuAQZ0O7fC5sbhwtgmkD8PTVZIleOFKBb/Ni0nOwRjhN/MCblTx1M
 iDmSehKCSHYAorR9peLG6BKsmafsdcS/1hdU2OHNw1WsP2S1xtYM5qMTi3l4FAQOR1el
 O1F2eTE6ZUH7i+aBPK5w65rHas2Msz4TX40myyWN5a+Khj4BRaF1U/oJRUmvX6L0vYu0
 KMnw==
X-Gm-Message-State: AOJu0YzxYxCtEzHEcJj3rBjVAJU2IoOdWKE2drrTSJxrMNpaKWhQgmx9
 WQmr0Ep4ZC9/xLeGF8Z0FN4L+1wMAOCiKFRMvYhJEmk796qWdOUwIpoNcPoAAg==
X-Gm-Gg: ASbGncs5R+np0vxsKMFRjqj5Zi91uzPCN4zJko/epuDiE70SJCikO6kPqZ5m+xoazIP
 tryM9WChtYFB0tfRQqZiB8K+LVOdO0ypC6ZwNKBwgBBXfc+MpvE2bMgOHP2sM3TbJpTWuOtnK6B
 3zjZMlN3S/c6FW1z+vRIelFRE3PaRj5Nzng6jo/W/ifxwLh3RiUJ+32aGMqjHrelE9tv2SXuHW5
 IlGSi1QNWQ9ISdlTWR3VOzAftiTOoJ8cEBfw7diFnK/XNkxeFinifLC8fGv/Dq1cbCUWg6M4Odv
 GTLTRmlZMyfwjzTc//1LfBSK8RH21Hy19IjSZh0HaM7fFtzbQuVJwh0h8qb0jPk3LN708zxrMCH
 /EMnkVZY0FCbclawujghfoLcb4TekTxftEtJ/NtG9hLjEHrkdvsjQl9DTBrClmcaJV7vEKNA+J3
 a/G/QBERM7xoagCciRpEEnG74sPRY=
X-Google-Smtp-Source: AGHT+IHY1684My/DJOqAEiegu5qoqFoLPTlj2mu7pKXrp026xgpo2nRFAAaApxVg3awdNIhrrX70Dw==
X-Received: by 2002:a05:622a:1353:b0:4b2:9cdc:6d52 with SMTP id
 d75a77b69052e-4b31dcf3a7bmr9040131cf.71.1756522248677; 
 Fri, 29 Aug 2025 19:50:48 -0700 (PDT)
Received: from localhost.localdomain
 (wn-campus-nat-129-97-124-90.dynamic.uwaterloo.ca. [129.97.124.90])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7fc0eacf1b4sm299457085a.21.2025.08.29.19.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 19:50:48 -0700 (PDT)
From: Brian Song <hibriansong@gmail.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, bernd@bsbernd.com,
 fam@euphon.net, hibriansong@gmail.com, hreitz@redhat.com, kwolf@redhat.com,
 stefanha@redhat.com
Subject: [PATCH 2/4] export/fuse: process FUSE-over-io_uring requests
Date: Fri, 29 Aug 2025 22:50:23 -0400
Message-ID: <20250830025025.3610-3-hibriansong@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250830025025.3610-1-hibriansong@gmail.com>
References: <20250830025025.3610-1-hibriansong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=hibriansong@gmail.com; helo=mail-qt1-x836.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

https://docs.kernel.org/filesystems/fuse-io-uring.html

As described in the kernel documentation, after FUSE-over-io_uring
initialization and handshake, FUSE interacts with the kernel using
SQE/CQE to send requests and receive responses. This corresponds to
the "Sending requests with CQEs" section in the docs.

This patch implements three key parts: registering the CQE handler
(fuse_uring_cqe_handler), processing FUSE requests (fuse_uring_co_
process_request), and sending response results (fuse_uring_send_
response). It also merges the traditional /dev/fuse request handling
with the FUSE-over-io_uring handling functions.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Brian Song <hibriansong@gmail.com>
---
 block/export/fuse.c | 457 ++++++++++++++++++++++++++++++--------------
 1 file changed, 309 insertions(+), 148 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 19bf9e5f74..07f74fc8ec 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -310,6 +310,47 @@ static const BlockDevOps fuse_export_blk_dev_ops = {
 };
 
 #ifdef CONFIG_LINUX_IO_URING
+static void coroutine_fn fuse_uring_co_process_request(FuseRingEnt *ent);
+
+static void coroutine_fn co_fuse_uring_queue_handle_cqes(void *opaque)
+{
+    FuseRingEnt *ent = opaque;
+    FuseExport *exp = ent->rq->q->exp;
+
+    /* Going to process requests */
+    fuse_inc_in_flight(exp);
+
+    /* A ring entry returned */
+    fuse_uring_co_process_request(ent);
+
+    /* Finished processing requests */
+    fuse_dec_in_flight(exp);
+}
+
+static void fuse_uring_cqe_handler(CqeHandler *cqe_handler)
+{
+    FuseRingEnt *ent = container_of(cqe_handler, FuseRingEnt, fuse_cqe_handler);
+    Coroutine *co;
+    FuseExport *exp = ent->rq->q->exp;
+
+    if (unlikely(exp->halted)) {
+        return;
+    }
+
+    int err = cqe_handler->cqe.res;
+
+    if (err != 0) {
+        /* -ENOTCONN is ok on umount  */
+        if (err != -EINTR && err != -EAGAIN &&
+            err != -ENOTCONN) {
+            fuse_export_halt(exp);
+        }
+    } else {
+        co = qemu_coroutine_create(co_fuse_uring_queue_handle_cqes, ent);
+        qemu_coroutine_enter(co);
+    }
+}
+
 static void fuse_uring_sqe_set_req_data(struct fuse_uring_cmd_req *req,
                     const unsigned int rqid,
                     const unsigned int commit_id)
@@ -1213,6 +1254,9 @@ fuse_co_read(FuseExport *exp, void **bufptr, uint64_t offset, uint32_t size)
  * Data in @in_place_buf is assumed to be overwritten after yielding, so will
  * be copied to a bounce buffer beforehand.  @spillover_buf in contrast is
  * assumed to be exclusively owned and will be used as-is.
+ * In FUSE-over-io_uring mode, the actual op_payload content is stored in
+ * @spillover_buf. To ensure this buffer is used for writing, @in_place_buf
+ * is explicitly set to NULL.
  * Return the number of bytes written to *out on success, and -errno on error.
  */
 static ssize_t coroutine_fn
@@ -1220,8 +1264,8 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
               uint64_t offset, uint32_t size,
               const void *in_place_buf, const void *spillover_buf)
 {
-    size_t in_place_size;
-    void *copied;
+    size_t in_place_size = 0;
+    void *copied = NULL;
     int64_t blk_len;
     int ret;
     struct iovec iov[2];
@@ -1236,10 +1280,12 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
         return -EACCES;
     }
 
-    /* Must copy to bounce buffer before potentially yielding */
-    in_place_size = MIN(size, FUSE_IN_PLACE_WRITE_BYTES);
-    copied = blk_blockalign(exp->common.blk, in_place_size);
-    memcpy(copied, in_place_buf, in_place_size);
+    if (in_place_buf) {
+        /* Must copy to bounce buffer before potentially yielding */
+        in_place_size = MIN(size, FUSE_IN_PLACE_WRITE_BYTES);
+        copied = blk_blockalign(exp->common.blk, in_place_size);
+        memcpy(copied, in_place_buf, in_place_size);
+    }
 
     /**
      * Clients will expect short writes at EOF, so we have to limit
@@ -1263,26 +1309,38 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
         }
     }
 
-    iov[0] = (struct iovec) {
-        .iov_base = copied,
-        .iov_len = in_place_size,
-    };
-    if (size > FUSE_IN_PLACE_WRITE_BYTES) {
-        assert(size - FUSE_IN_PLACE_WRITE_BYTES <= FUSE_SPILLOVER_BUF_SIZE);
-        iov[1] = (struct iovec) {
-            .iov_base = (void *)spillover_buf,
-            .iov_len = size - FUSE_IN_PLACE_WRITE_BYTES,
+    if (in_place_buf) {
+        iov[0] = (struct iovec) {
+            .iov_base = copied,
+            .iov_len = in_place_size,
         };
-        qemu_iovec_init_external(&qiov, iov, 2);
+        if (size > FUSE_IN_PLACE_WRITE_BYTES) {
+            assert(size - FUSE_IN_PLACE_WRITE_BYTES <= FUSE_SPILLOVER_BUF_SIZE);
+            iov[1] = (struct iovec) {
+                .iov_base = (void *)spillover_buf,
+                .iov_len = size - FUSE_IN_PLACE_WRITE_BYTES,
+            };
+            qemu_iovec_init_external(&qiov, iov, 2);
+        } else {
+            qemu_iovec_init_external(&qiov, iov, 1);
+        }
     } else {
+        /* fuse over io_uring */
+        iov[0] = (struct iovec) {
+            .iov_base = (void *)spillover_buf,
+            .iov_len = size,
+        };
         qemu_iovec_init_external(&qiov, iov, 1);
     }
+
     ret = blk_co_pwritev(exp->common.blk, offset, size, &qiov, 0);
     if (ret < 0) {
         goto fail_free_buffer;
     }
 
-    qemu_vfree(copied);
+    if (in_place_buf) {
+        qemu_vfree(copied);
+    }
 
     *out = (struct fuse_write_out) {
         .size = size,
@@ -1290,7 +1348,9 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
     return sizeof(*out);
 
 fail_free_buffer:
-    qemu_vfree(copied);
+    if (in_place_buf) {
+        qemu_vfree(copied);
+    }
     return ret;
 }
 
@@ -1578,173 +1638,151 @@ static int fuse_write_buf_response(int fd, uint32_t req_id,
     }
 }
 
-/*
- * For use in fuse_co_process_request():
- * Returns a pointer to the parameter object for the given operation (inside of
- * queue->request_buf, which is assumed to hold a fuse_in_header first).
- * Verifies that the object is complete (queue->request_buf is large enough to
- * hold it in one piece, and the request length includes the whole object).
- *
- * Note that queue->request_buf may be overwritten after yielding, so the
- * returned pointer must not be used across a function that may yield!
- */
-#define FUSE_IN_OP_STRUCT(op_name, queue) \
+#define FUSE_IN_OP_STRUCT_LEGACY(in_buf) \
     ({ \
-        const struct fuse_in_header *__in_hdr = \
-            (const struct fuse_in_header *)(queue)->request_buf; \
-        const struct fuse_##op_name##_in *__in = \
-            (const struct fuse_##op_name##_in *)(__in_hdr + 1); \
-        const size_t __param_len = sizeof(*__in_hdr) + sizeof(*__in); \
-        uint32_t __req_len; \
-        \
-        QEMU_BUILD_BUG_ON(sizeof((queue)->request_buf) < __param_len); \
-        \
-        __req_len = __in_hdr->len; \
-        if (__req_len < __param_len) { \
-            warn_report("FUSE request truncated (%" PRIu32 " < %zu)", \
-                        __req_len, __param_len); \
-            ret = -EINVAL; \
-            break; \
-        } \
-        __in; \
+        (void *)(((struct fuse_in_header *)in_buf) + 1); \
     })
 
-/*
- * For use in fuse_co_process_request():
- * Returns a pointer to the return object for the given operation (inside of
- * out_buf, which is assumed to hold a fuse_out_header first).
- * Verifies that out_buf is large enough to hold the whole object.
- *
- * (out_buf should be a char[] array.)
- */
-#define FUSE_OUT_OP_STRUCT(op_name, out_buf) \
+#define FUSE_OUT_OP_STRUCT_LEGACY(out_buf) \
     ({ \
-        struct fuse_out_header *__out_hdr = \
-            (struct fuse_out_header *)(out_buf); \
-        struct fuse_##op_name##_out *__out = \
-            (struct fuse_##op_name##_out *)(__out_hdr + 1); \
-        \
-        QEMU_BUILD_BUG_ON(sizeof(*__out_hdr) + sizeof(*__out) > \
-                          sizeof(out_buf)); \
-        \
-        __out; \
+        (void *)(((struct fuse_out_header *)out_buf) + 1); \
     })
 
-/**
- * Process a FUSE request, incl. writing the response.
- *
- * Note that yielding in any request-processing function can overwrite the
- * contents of q->request_buf.  Anything that takes a buffer needs to take
- * care that the content is copied before yielding.
- *
- * @spillover_buf can contain the tail of a write request too large to fit into
- * q->request_buf.  This function takes ownership of it (i.e. will free it),
- * which assumes that its contents will not be overwritten by concurrent
- * requests (as opposed to q->request_buf).
+
+/*
+ * Shared helper for FUSE request processing. Handles both legacy and io_uring
+ * paths.
  */
-static void coroutine_fn
-fuse_co_process_request(FuseQueue *q, void *spillover_buf)
+static void coroutine_fn fuse_co_process_request_common(
+    FuseExport *exp,
+    uint32_t opcode,
+    uint64_t req_id,
+    void *in_buf,
+    void *spillover_buf,
+    void *out_buf,
+    int fd, /* -1 for uring */
+    void (*send_response)(void *opaque, uint32_t req_id, ssize_t ret,
+                         const void *buf, void *out_buf),
+    void *opaque /* FuseQueue* or FuseRingEnt* */)
 {
-    FuseExport *exp = q->exp;
-    uint32_t opcode;
-    uint64_t req_id;
-    /*
-     * Return buffer.  Must be large enough to hold all return headers, but does
-     * not include space for data returned by read requests.
-     * (FUSE_IN_OP_STRUCT() verifies at compile time that out_buf is indeed
-     * large enough.)
-     */
-    char out_buf[sizeof(struct fuse_out_header) +
-                 MAX_CONST(sizeof(struct fuse_init_out),
-                 MAX_CONST(sizeof(struct fuse_open_out),
-                 MAX_CONST(sizeof(struct fuse_attr_out),
-                 MAX_CONST(sizeof(struct fuse_write_out),
-                           sizeof(struct fuse_lseek_out)))))];
-    struct fuse_out_header *out_hdr = (struct fuse_out_header *)out_buf;
-    /* For read requests: Data to be returned */
     void *out_data_buffer = NULL;
-    ssize_t ret;
+    ssize_t ret = 0;
 
-    /* Limit scope to ensure pointer is no longer used after yielding */
-    {
-        const struct fuse_in_header *in_hdr =
-            (const struct fuse_in_header *)q->request_buf;
+    void *op_in_buf = (void *)FUSE_IN_OP_STRUCT_LEGACY(in_buf);
+    void *op_out_buf = (void *)FUSE_OUT_OP_STRUCT_LEGACY(out_buf);
 
-        opcode = in_hdr->opcode;
-        req_id = in_hdr->unique;
+#ifdef CONFIG_LINUX_IO_URING
+    if (opcode != FUSE_INIT && exp->is_uring) {
+        op_in_buf = (void *)in_buf;
+        op_out_buf = (void *)out_buf;
     }
+#endif
 
     switch (opcode) {
     case FUSE_INIT: {
-        const struct fuse_init_in *in = FUSE_IN_OP_STRUCT(init, q);
-        ret = fuse_co_init(exp, FUSE_OUT_OP_STRUCT(init, out_buf),
-                           in->max_readahead, in->flags);
+        const struct fuse_init_in *in =
+            (const struct fuse_init_in *)FUSE_IN_OP_STRUCT_LEGACY(in_buf);
+
+        struct fuse_init_out *out =
+            (struct fuse_init_out *)FUSE_OUT_OP_STRUCT_LEGACY(out_buf);
+
+        ret = fuse_co_init(exp, out, in->max_readahead, in);
         break;
     }
 
-    case FUSE_OPEN:
-        ret = fuse_co_open(exp, FUSE_OUT_OP_STRUCT(open, out_buf));
+    case FUSE_OPEN: {
+        struct fuse_open_out *out =
+            (struct fuse_open_out *)op_out_buf;
+
+        ret = fuse_co_open(exp, out);
         break;
+    }
 
     case FUSE_RELEASE:
         ret = 0;
         break;
 
     case FUSE_LOOKUP:
-        ret = -ENOENT; /* There is no node but the root node */
+        ret = -ENOENT;
         break;
 
-    case FUSE_GETATTR:
-        ret = fuse_co_getattr(exp, FUSE_OUT_OP_STRUCT(attr, out_buf));
+    case FUSE_GETATTR: {
+        struct fuse_attr_out *out =
+            (struct fuse_attr_out *)op_out_buf;
+
+        ret = fuse_co_getattr(exp, out);
         break;
+    }
 
     case FUSE_SETATTR: {
-        const struct fuse_setattr_in *in = FUSE_IN_OP_STRUCT(setattr, q);
-        ret = fuse_co_setattr(exp, FUSE_OUT_OP_STRUCT(attr, out_buf),
-                              in->valid, in->size, in->mode, in->uid, in->gid);
+        const struct fuse_setattr_in *in =
+            (const struct fuse_setattr_in *)op_in_buf;
+
+        struct fuse_attr_out *out =
+            (struct fuse_attr_out *)op_out_buf;
+
+        ret = fuse_co_setattr(exp, out, in->valid, in->size, in->mode,
+                              in->uid, in->gid);
         break;
     }
 
     case FUSE_READ: {
-        const struct fuse_read_in *in = FUSE_IN_OP_STRUCT(read, q);
+        const struct fuse_read_in *in =
+            (const struct fuse_read_in *)op_in_buf;
+
         ret = fuse_co_read(exp, &out_data_buffer, in->offset, in->size);
         break;
     }
 
     case FUSE_WRITE: {
-        const struct fuse_write_in *in = FUSE_IN_OP_STRUCT(write, q);
-        uint32_t req_len;
-
-        req_len = ((const struct fuse_in_header *)q->request_buf)->len;
-        if (unlikely(req_len < sizeof(struct fuse_in_header) + sizeof(*in) +
-                               in->size)) {
-            warn_report("FUSE WRITE truncated; received %zu bytes of %" PRIu32,
-                        req_len - sizeof(struct fuse_in_header) - sizeof(*in),
-                        in->size);
-            ret = -EINVAL;
-            break;
+        const struct fuse_write_in *in =
+            (const struct fuse_write_in *)op_in_buf;
+
+        struct fuse_write_out *out =
+            (struct fuse_write_out *)op_out_buf;
+
+#ifdef CONFIG_LINUX_IO_URING
+        if (!exp->is_uring) {
+#endif
+            uint32_t req_len = ((const struct fuse_in_header *)in_buf)->len;
+
+            if (unlikely(req_len < sizeof(struct fuse_in_header) + sizeof(*in) +
+                        in->size)) {
+                warn_report("FUSE WRITE truncated; received %zu bytes of %"
+                    PRIu32,
+                    req_len - sizeof(struct fuse_in_header) - sizeof(*in),
+                    in->size);
+                ret = -EINVAL;
+                break;
+            }
+#ifdef CONFIG_LINUX_IO_URING
+        } else {
+            assert(in->size <=
+                ((FuseRingEnt *)opaque)->req_header.ring_ent_in_out.payload_sz);
         }
+#endif
 
-        /*
-         * poll_fuse_fd() has checked that in_hdr->len matches the number of
-         * bytes read, which cannot exceed the max_write value we set
-         * (FUSE_MAX_WRITE_BYTES).  So we know that FUSE_MAX_WRITE_BYTES >=
-         * in_hdr->len >= in->size + X, so this assertion must hold.
-         */
         assert(in->size <= FUSE_MAX_WRITE_BYTES);
 
-        /*
-         * Passing a pointer to `in` (i.e. the request buffer) is fine because
-         * fuse_co_write() takes care to copy its contents before potentially
-         * yielding.
-         */
-        ret = fuse_co_write(exp, FUSE_OUT_OP_STRUCT(write, out_buf),
-                            in->offset, in->size, in + 1, spillover_buf);
+        const void *in_place_buf = in + 1;
+        const void *spill_buf = spillover_buf;
+
+#ifdef CONFIG_LINUX_IO_URING
+        if (exp->is_uring) {
+            in_place_buf = NULL;
+            spill_buf = out_buf;
+        }
+#endif
+
+        ret = fuse_co_write(exp, out, in->offset, in->size,
+                            in_place_buf, spill_buf);
         break;
     }
 
     case FUSE_FALLOCATE: {
-        const struct fuse_fallocate_in *in = FUSE_IN_OP_STRUCT(fallocate, q);
+        const struct fuse_fallocate_in *in =
+            (const struct fuse_fallocate_in *)op_in_buf;
+
         ret = fuse_co_fallocate(exp, in->offset, in->length, in->mode);
         break;
     }
@@ -1759,9 +1797,13 @@ fuse_co_process_request(FuseQueue *q, void *spillover_buf)
 
 #ifdef CONFIG_FUSE_LSEEK
     case FUSE_LSEEK: {
-        const struct fuse_lseek_in *in = FUSE_IN_OP_STRUCT(lseek, q);
-        ret = fuse_co_lseek(exp, FUSE_OUT_OP_STRUCT(lseek, out_buf),
-                            in->offset, in->whence);
+        const struct fuse_lseek_in *in =
+            (const struct fuse_lseek_in *)op_in_buf;
+
+        struct fuse_lseek_out *out =
+            (struct fuse_lseek_out *)op_out_buf;
+
+        ret = fuse_co_lseek(exp, out, in->offset, in->whence);
         break;
     }
 #endif
@@ -1770,28 +1812,147 @@ fuse_co_process_request(FuseQueue *q, void *spillover_buf)
         ret = -ENOSYS;
     }
 
-    /* Ignore errors from fuse_write*(), nothing we can do anyway */
+    send_response(opaque, req_id, ret, out_data_buffer, out_buf);
+
     if (out_data_buffer) {
-        assert(ret >= 0);
-        fuse_write_buf_response(q->fuse_fd, req_id, out_hdr,
-                                out_data_buffer, ret);
         qemu_vfree(out_data_buffer);
+    }
+
+    if (fd != -1) {
+        qemu_vfree(spillover_buf);
+    }
+
 #ifdef CONFIG_LINUX_IO_URING
+    /* Handle FUSE initialization errors */
+    if (unlikely(opcode == FUSE_INIT && ret == -ENODEV)) {
+        error_report("System doesn't support FUSE-over-io_uring");
+        fuse_export_halt(exp);
+        return;
+    }
+
     /* Handle FUSE-over-io_uring initialization */
-    if (unlikely(opcode == FUSE_INIT && exp->is_uring)) {
+    if (unlikely(opcode == FUSE_INIT && exp->is_uring && fd != -1)) {
         struct fuse_init_out *out =
-            (struct fuse_init_out *)FUSE_OUT_OP_STRUCT(out_buf);
+            (struct fuse_init_out *)FUSE_OUT_OP_STRUCT_LEGACY(out_buf);
         fuse_uring_start(exp, out);
     }
 #endif
+}
+
+/* Helper to send response for legacy */
+static void send_response_legacy(void *opaque, uint32_t req_id, ssize_t ret,
+                            const void *buf, void *out_buf)
+{
+    FuseQueue *q = (FuseQueue *)opaque;
+    struct fuse_out_header *out_hdr = (struct fuse_out_header *)out_buf;
+    if (buf) {
+        assert(ret >= 0);
+        fuse_write_buf_response(q->fuse_fd, req_id, out_hdr, buf, ret);
     } else {
         fuse_write_response(q->fuse_fd, req_id, out_hdr,
                             ret < 0 ? ret : 0,
                             ret < 0 ? 0 : ret);
     }
+}
 
-    qemu_vfree(spillover_buf);
+static void coroutine_fn
+fuse_co_process_request(FuseQueue *q, void *spillover_buf)
+{
+    FuseExport *exp = q->exp;
+    uint32_t opcode;
+    uint64_t req_id;
+
+    /*
+     * Return buffer.  Must be large enough to hold all return headers, but does
+     * not include space for data returned by read requests.
+     */
+    char out_buf[sizeof(struct fuse_out_header) +
+        MAX_CONST(sizeof(struct fuse_init_out),
+        MAX_CONST(sizeof(struct fuse_open_out),
+        MAX_CONST(sizeof(struct fuse_attr_out),
+        MAX_CONST(sizeof(struct fuse_write_out),
+                  sizeof(struct fuse_lseek_out)))))] = {0};
+
+    /* Limit scope to ensure pointer is no longer used after yielding */
+    {
+        const struct fuse_in_header *in_hdr =
+            (const struct fuse_in_header *)q->request_buf;
+
+        opcode = in_hdr->opcode;
+        req_id = in_hdr->unique;
+    }
+
+    fuse_co_process_request_common(exp, opcode, req_id, q->request_buf,
+        spillover_buf, out_buf, q->fuse_fd, send_response_legacy, q);
+}
+
+#ifdef CONFIG_LINUX_IO_URING
+static void fuse_uring_prep_sqe_commit(struct io_uring_sqe *sqe, void *opaque)
+{
+    FuseRingEnt *ent = opaque;
+    struct fuse_uring_cmd_req *req = (void *)&sqe->cmd[0];
+
+    fuse_uring_sqe_prepare(sqe, ent->rq->q, FUSE_IO_URING_CMD_COMMIT_AND_FETCH);
+    fuse_uring_sqe_set_req_data(req, ent->rq->rqid,
+                                     ent->req_commit_id);
+}
+
+static void
+fuse_uring_send_response(FuseRingEnt *ent, uint32_t req_id, ssize_t ret,
+                         const void *out_data_buffer)
+{
+    FuseExport *exp = ent->rq->q->exp;
+
+    struct fuse_uring_req_header *rrh = &ent->req_header;
+    struct fuse_out_header *out_header = (struct fuse_out_header *)&rrh->in_out;
+    struct fuse_uring_ent_in_out *ent_in_out =
+        (struct fuse_uring_ent_in_out *)&rrh->ring_ent_in_out;
+
+    /* FUSE_READ */
+    if (out_data_buffer && ret > 0) {
+        memcpy(ent->op_payload, out_data_buffer, ret);
+    }
+
+    out_header->error  = ret < 0 ? ret : 0;
+    out_header->unique = req_id;
+    /* out_header->len = ret > 0 ? ret : 0; */
+    ent_in_out->payload_sz = ret > 0 ? ret : 0;
+    aio_add_sqe(fuse_uring_prep_sqe_commit, ent,
+                    &ent->fuse_cqe_handler);
+}
+
+/* Helper to send response for uring */
+static void send_response_uring(void *opaque, uint32_t req_id, ssize_t ret,
+                        const void *out_data_buffer, void *payload)
+{
+    FuseRingEnt *ent = (FuseRingEnt *)opaque;
+
+    fuse_uring_send_response(ent, req_id, ret, out_data_buffer);
+}
+
+static void coroutine_fn fuse_uring_co_process_request(FuseRingEnt *ent)
+{
+    FuseExport *exp = ent->rq->q->exp;
+    struct fuse_uring_req_header *rrh = &ent->req_header;
+    struct fuse_uring_ent_in_out *ent_in_out =
+        (struct fuse_uring_ent_in_out *)&rrh->ring_ent_in_out;
+    struct fuse_in_header *in_hdr =
+        (struct fuse_in_header *)&rrh->in_out;
+    uint32_t opcode = in_hdr->opcode;
+    uint64_t req_id = in_hdr->unique;
+    ent->req_commit_id = ent_in_out->commit_id;
+
+    if (unlikely(ent->req_commit_id == 0)) {
+        error_report("If this happens kernel will not find the response - "
+            "it will be stuck forever - better to abort immediately.");
+        fuse_export_halt(exp);
+        return;
+    }
+
+    fuse_co_process_request_common(exp, opcode, req_id, &rrh->op_in,
+        NULL, ent->op_payload, -1, send_response_uring, ent);
 }
+#endif
 
 const BlockExportDriver blk_exp_fuse = {
     .type               = BLOCK_EXPORT_TYPE_FUSE,
-- 
2.45.2


