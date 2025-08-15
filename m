Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FADCA0EE0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 03:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umlPf-0004dL-PR; Thu, 14 Aug 2025 23:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1umlPd-0004bs-CD; Thu, 14 Aug 2025 23:47:29 -0400
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1umlPa-0002vz-Ip; Thu, 14 Aug 2025 23:47:29 -0400
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-70a88ddb1a2so15609966d6.0; 
 Thu, 14 Aug 2025 20:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755229644; x=1755834444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IS2rJiUNIoOPC4jKy0MbPPTjXf6JnFqJMKHpOMuuXaI=;
 b=KwiesENzADD3Ba5xw/JfuVVIEU5IVlJrvd+pQdvBnbIuQkFZFgEEb9OUt3XVdjOVfu
 OP7Eq0MtFLlIWKucDsCrNfK0SsTnKyObn5IIHzDFevI+or8xNtWIFv4CvIXe1BN+unjH
 y1Pqn9hV1EM48QSzKEtL6VZM5XpVVPgjhijdfKRj2XjKS+TZ0wtbtsCbBUsma5XZzq/w
 kqsd6k6BEho4OcuW77wLqz/NihIjmAs6RPDndJkQSlRWWeVAgMK4JcpuwNvPJf1M+x+T
 GCu3Ybtq+wjzDapyTJIc2m/6TQjHNdErThl2buoRYnZol/PhkIk3YwkdFzccPOFHbRdX
 yUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755229644; x=1755834444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IS2rJiUNIoOPC4jKy0MbPPTjXf6JnFqJMKHpOMuuXaI=;
 b=V4vLTLYODlO88XMzXKZm7ueaioksxtiyMkpGwyzFu9uj9qDIPpLPjWXzwWdHCzjYv/
 KnmPvKMwBVylgz5aTVIQerPFusQ2xB9QupFVAQBD2G4+sJVYIu0fa1gkUVBBDyP1Wpx/
 B6qROb47RbixLOhA+E7Rwd9Y2N66lfwIisYi1Mxx9uFLv6mmhPJ8YIyLpgTcGDlGWHKF
 Pas/1Uk5GVqaMH+F2cqdKBz363mEzsP+uwqdJPPNdK1WpJ+d6/PGeNzch5iIfb7mFKsL
 RFNUjSSiQo5BBRcjsIGvW1JDmNoDi6hg7YzCpbusNA5VPnFJgvrxCpY8XbXlPMprkfUn
 844w==
X-Gm-Message-State: AOJu0YxWdBI56ZtpO3+gGacKTz8RCeiUETdhacEIc0lP5ehCWF+5/wph
 7uj42B5sFhdGFyYhmqXq5QorCrAXO2eLlO2ylhtWentQO1/5Du20QG0WZ+33PQ==
X-Gm-Gg: ASbGncvXeLpDHmaXVc+anECVEuKYOd04F9+1LdfaplyUVHgiejPc8WdZRTMrM7mJ4jv
 RVpIZx4RW9579kUjMaO5UqxMcIsgNJ54PN4UbwyK4KX+Z30byIuD/ZdQ3JW7sRNEDTie0SAPtYO
 SWtQnFCbinHfsBFbL2YwEfLQWSHXHN1kOSSyamNM0Cde3NXb/P51ddpJ7EDvpWWfuKLcYeKgQx2
 mY+359yltMIs8DU+2hBObpcP7CkZ/vZUDyzBNxIEF6DTViqySgUJwh+LD0Y9XYYDctvD2gm0HeH
 ChYq0iIGfut7xYmXxvLkPKeBKzYbeSsMxdZYibVjcp+naeVWxsGeAczwFD5blQklFRZp/9udN73
 dv0/1wKkqHaBtokqyS5fzL8yCWbFEkr29yzRdZiZ+Z1tU8St4H9eIQm5PLo3TqcVkGb/xtSDb8N
 183cO/P90SdvSg
X-Google-Smtp-Source: AGHT+IFfjZdBG6T+VENN5wHnRwFhulVCu8PF2IxCXK6r8ylocYdvWmhTed+nWDemgOt84gQpEQW/Dw==
X-Received: by 2002:a05:6214:2aae:b0:709:dfc5:a43 with SMTP id
 6a1803df08f44-70ba63b4a7amr8874096d6.1.1755229644227; 
 Thu, 14 Aug 2025 20:47:24 -0700 (PDT)
Received: from zzzhi.uwaterloo.ca
 (wn-campus-nat-129-97-124-101.dynamic.uwaterloo.ca. [129.97.124.101])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70ba906706esm1402346d6.17.2025.08.14.20.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 20:47:23 -0700 (PDT)
From: Zhi Song <hibriansong@gmail.com>
X-Google-Original-From: Zhi Song <hizhisong@gmail.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, bernd@bsbernd.com,
 fam@euphon.net, hibriansong@gmail.com, hreitz@redhat.com, kwolf@redhat.com,
 stefanha@redhat.com
Subject: [PATCH 2/3] fuse: Handle FUSE-uring requests
Date: Thu, 14 Aug 2025 23:46:18 -0400
Message-ID: <20250815034619.51980-3-hizhisong@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815034619.51980-1-hizhisong@gmail.com>
References: <20250815034619.51980-1-hizhisong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=hibriansong@gmail.com; helo=mail-qv1-xf34.google.com
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

From: Brian Song <hibriansong@gmail.com>

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
 block/export/fuse.c | 425 ++++++++++++++++++++++++++++++--------------
 1 file changed, 289 insertions(+), 136 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 59fa79f486..7540f8f5a3 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -288,6 +288,46 @@ static const BlockDevOps fuse_export_blk_dev_ops = {
 };

 #ifdef CONFIG_LINUX_IO_URING
+static void coroutine_fn fuse_uring_co_process_request(FuseRingEnt *ent);
+
+static void coroutine_fn co_fuse_uring_queue_handle_cqes(void *opaque)
+{
+    FuseRingEnt *ent = opaque;
+    FuseExport *exp = ent->q->exp;
+
+    /* Going to process requests */
+    fuse_inc_in_flight(exp);
+
+
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
+    FuseExport *exp = ent->q->exp;
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

 static void fuse_uring_sqe_set_req_data(struct fuse_uring_cmd_req *req,
                     const unsigned int qid,
@@ -1075,6 +1115,9 @@ fuse_co_read(FuseExport *exp, void **bufptr, uint64_t offset, uint32_t size)
  * Data in @in_place_buf is assumed to be overwritten after yielding, so will
  * be copied to a bounce buffer beforehand.  @spillover_buf in contrast is
  * assumed to be exclusively owned and will be used as-is.
+ * In FUSE-over-io_uring mode, the actual op_payload content is stored in
+ * @spillover_buf. To ensure this buffer is used for writing, @in_place_buf
+ * is explicitly set to NULL.
  * Return the number of bytes written to *out on success, and -errno on error.
  */
 static ssize_t coroutine_fn
@@ -1082,8 +1125,8 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
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
@@ -1098,10 +1141,12 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
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
@@ -1125,26 +1170,37 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
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
+    if (in_place_buf)
+        qemu_vfree(copied);

     *out = (struct fuse_write_out) {
         .size = size,
@@ -1152,7 +1208,9 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
     return sizeof(*out);

 fail_free_buffer:
-    qemu_vfree(copied);
+    if (in_place_buf) {
+        qemu_vfree(copied);
+    }
     return ret;
 }

@@ -1440,168 +1498,144 @@ static int fuse_write_buf_response(int fd, uint32_t req_id,
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
+    ssize_t ret = 0;

     bool is_uring = exp->is_uring;

+    void *op_in_buf = (is_uring && opcode != FUSE_INIT) ?
+                (void *)in_buf : (void *)FUSE_IN_OP_STRUCT_LEGACY(in_buf);
+
+    void *op_out_buf = (is_uring && opcode != FUSE_INIT) ?
+                (void *)out_buf : (void *)FUSE_OUT_OP_STRUCT_LEGACY(out_buf);
+
     switch (opcode) {
     case FUSE_INIT: {
+        const struct fuse_init_in *in =
+            (const struct fuse_init_in *)FUSE_IN_OP_STRUCT_LEGACY(in_buf);
+
+        struct fuse_init_out *out =
+            (struct fuse_init_out *)FUSE_OUT_OP_STRUCT_LEGACY(out_buf);
+
+        ret = fuse_co_init(exp, out, in->max_readahead, in->flags);
 #ifdef CONFIG_LINUX_IO_URING
         /* FUSE-over-io_uring enabled && start from the tradition path */
-        if (is_uring) {
+        if (is_uring && fd != -1) {
             fuse_uring_start(exp, out);
         }
 #endif
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
+        if (!is_uring) {
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
+        } else {
+            assert(in->size <=
+                ((FuseRingEnt *)opaque)->req_header.ring_ent_in_out.payload_sz);
         }

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
+        const void *in_place_buf = is_uring ? NULL : (in + 1);
+        const void *spill_buf = is_uring ? out_buf : spillover_buf;
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
@@ -1616,9 +1650,13 @@ fuse_co_process_request(FuseQueue *q, void *spillover_buf)

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
@@ -1627,20 +1665,135 @@ fuse_co_process_request(FuseQueue *q, void *spillover_buf)
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
+
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
+    fuse_uring_sqe_prepare(sqe, ent->q, FUSE_IO_URING_CMD_COMMIT_AND_FETCH);
+    fuse_uring_sqe_set_req_data(req, ent->q->qid,
+                                     ent->req_commit_id);
+}
+
+static void
+fuse_uring_send_response(FuseRingEnt *ent, uint32_t req_id, ssize_t ret,
+                         const void *out_data_buffer)
+{
+    FuseExport *exp = ent->q->exp;
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
+

     qemu_vfree(spillover_buf);
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
+    FuseQueue *q = ent->q;
+    FuseExport *exp = q->exp;
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


