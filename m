Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6FBC531D1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBON-0005f9-0W; Thu, 19 Feb 2026 16:16:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vtBOJ-0005el-3o
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:16:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vtBOF-0005X8-1x
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771535808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S+5hQGGZywLI2PLtKdUE33CAXPAjE5523eM+4x4NpYA=;
 b=Rk59B3zttho3REOFj/XTG0cFTDsXq6wGeclWuFu+lFgyRBT+dTdUze7nKWKUWdtp+nmGzw
 aFeBV6+zte3erySeUvUZZHTfrfIsd2U2BGEkdC1bX7LIPlzljXkUcu8/epK5L4JMXOnh/o
 2zQTZC5S6h0DrPN84m34OYodbcEPFto=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-n6m1cz2jMsaI_ciIZxuqRA-1; Thu,
 19 Feb 2026 16:16:44 -0500
X-MC-Unique: n6m1cz2jMsaI_ciIZxuqRA-1
X-Mimecast-MFC-AGG-ID: n6m1cz2jMsaI_ciIZxuqRA_1771535803
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6916418002DE; Thu, 19 Feb 2026 21:16:42 +0000 (UTC)
Received: from localhost (unknown [10.2.16.138])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1251819560A7; Thu, 19 Feb 2026 21:16:40 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, fam@euphon.net,
 bernd@bsbernd.com, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] fuse: unify op_in for io_uring and classic FUSE
Date: Thu, 19 Feb 2026 16:14:00 -0500
Message-ID: <20260219211626.987027-1-stefanha@redhat.com>
In-Reply-To: <96F8FC7D-C7B5-4346-8421-65173B0FAD1A@gmail.com>
References: <96F8FC7D-C7B5-4346-8421-65173B0FAD1A@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Handle the memory layout differences for op_in in
fuse_co_process_request_common()'s callers. This way it's not necessary
to check whether uring is started.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/export/fuse.c | 118 ++++++++++++--------------------------------
 1 file changed, 32 insertions(+), 86 deletions(-)

Hi Brian,
You mentioned that FUSE_IN_OP_STRUCT_LEGACY() is harder to eliminate so
I took a look at it this morning. This patch compiles but I have not
tested it.

If you like this approach, please include it in your series and write a
similar patch for FUSE_OUT_OP_STRUCT_LEGACY().

diff --git a/block/export/fuse.c b/block/export/fuse.c
index e5b753e717..d4f393c2eb 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -137,8 +137,7 @@ struct FuseQueue {
      * The request buffer must be able to hold a full write, and/or at least
      * FUSE_MIN_READ_BUFFER (from linux/fuse.h) bytes.
      * This however is just the first part of the buffer; every read is given
-     * a vector of this buffer (which should be enough for all normal requests,
-     * which we check via the static assertion in FUSE_IN_OP_STRUCT_LEGACY())
+     * a vector of this buffer (which should be enough for all normal requests)
      * and the spill-over buffer below.
      * Therefore, the size of this buffer plus FUSE_SPILLOVER_BUF_SIZE must be
      * FUSE_MIN_READ_BUFFER or more (checked via static assertion below).
@@ -1765,33 +1764,24 @@ static int fuse_write_buf_response(int fd, uint32_t req_id,
 
 /*
  * For use in fuse_co_process_request_common():
- * Returns a pointer to the parameter object for the given operation (inside of
- * in_buf, which is assumed to hold a fuse_in_header first).
- * Verifies that the object is complete (in_buf is large enough to hold it in
- * one piece, and the request length includes the whole object).
- * Only performs verification for legacy FUSE.
+ * Returns a pointer to the parameter object for the given operation.
+ * Verifies that the object is complete (the request length includes the whole
+ * object).
  *
  * Note that queue->request_buf may be overwritten after yielding, so the
  * returned pointer must not be used across a function that may yield!
  */
-#define FUSE_IN_OP_STRUCT_LEGACY(op_name, queue) \
+#define FUSE_IN_OP_STRUCT(op_name) \
     ({ \
-        const struct fuse_in_header *__in_hdr = \
-            (const struct fuse_in_header *)(queue)->request_buf; \
-        const struct fuse_##op_name##_in *__in = \
-            (const struct fuse_##op_name##_in *)(__in_hdr + 1); \
-        const size_t __param_len = sizeof(*__in_hdr) + sizeof(*__in); \
-        \
-        QEMU_BUILD_BUG_ON(sizeof((queue)->request_buf) < \
-                          (sizeof(struct fuse_in_header) + \
-                           sizeof(struct fuse_##op_name##_in))); \
-        \
-        uint32_t __req_len = __in_hdr->len; \
-        if (__req_len < __param_len) { \
-            warn_report("FUSE request truncated (%" PRIu32 " < %zu)", \
-                        __req_len, __param_len); \
+        const struct fuse_##op_name##_in *__in = op_in; \
+        const size_t __needed = sizeof(struct fuse_in_header) + \
+                                sizeof(*__in); \
+        QEMU_BUILD_BUG_ON(sizeof(((FuseQueue *)0)->request_buf) < __needed); \
+        if (req_len < __needed) { \
+            warn_report("FUSE request with opcode %u truncated (%u < %zu)", \
+                        opcode, req_len, __needed); \
             ret = -EINVAL; \
-            __in = NULL; \
+            break; \
         } \
         __in; \
     })
@@ -1822,9 +1812,10 @@ static int fuse_write_buf_response(int fd, uint32_t req_id,
  */
 static void coroutine_fn fuse_co_process_request_common(
     FuseExport *exp,
+    uint32_t req_len,
     uint32_t opcode,
     uint64_t req_id,
-    void *in_buf,
+    const void *op_in,
     void *spillover_buf,
     void *out_buf,
     void (*send_response)(void *opaque, uint32_t req_id, int ret,
@@ -1849,13 +1840,7 @@ static void coroutine_fn fuse_co_process_request_common(
 
     switch (opcode) {
     case FUSE_INIT: {
-        FuseQueue *q = opaque;
-        const struct fuse_init_in *in =
-            FUSE_IN_OP_STRUCT_LEGACY(init, q);
-        if (!in) {
-            break;
-        }
-
+        const struct fuse_init_in *in = FUSE_IN_OP_STRUCT(init);
         struct fuse_init_out *out =
             FUSE_OUT_OP_STRUCT_LEGACY(init, out_buf);
 
@@ -1898,19 +1883,12 @@ static void coroutine_fn fuse_co_process_request_common(
     }
 
     case FUSE_SETATTR: {
-        const struct fuse_setattr_in *in;
+        const struct fuse_setattr_in *in = FUSE_IN_OP_STRUCT(setattr);
         struct fuse_attr_out *out;
 
         if (exp->uring_started) {
-            in = in_buf;
             out = out_buf;
         } else {
-            FuseQueue *q = opaque;
-            in = FUSE_IN_OP_STRUCT_LEGACY(setattr, q);
-            if (!in) {
-                break;
-            }
-
             out = FUSE_OUT_OP_STRUCT_LEGACY(attr, out_buf);
         }
 
@@ -1920,24 +1898,13 @@ static void coroutine_fn fuse_co_process_request_common(
     }
 
     case FUSE_READ: {
-        const struct fuse_read_in *in;
-
-        if (exp->uring_started) {
-            in = in_buf;
-        } else {
-            FuseQueue *q = opaque;
-            in = FUSE_IN_OP_STRUCT_LEGACY(read, q);
-            if (!in) {
-                break;
-            }
-        }
-
+        const struct fuse_read_in *in = FUSE_IN_OP_STRUCT(read);
         ret = fuse_co_read(exp, &out_data_buffer, in->offset, in->size);
         break;
     }
 
     case FUSE_WRITE: {
-        const struct fuse_write_in *in;
+        const struct fuse_write_in *in = FUSE_IN_OP_STRUCT(write);
         struct fuse_write_out *out;
         const void *in_place_buf;
         const void *spill_buf;
@@ -1945,7 +1912,6 @@ static void coroutine_fn fuse_co_process_request_common(
         if (exp->uring_started) {
             FuseUringEnt *ent = opaque;
 
-            in = in_buf;
             out = out_buf;
 
             assert(in->size <= ent->req_header.ring_ent_in_out.payload_sz);
@@ -1957,17 +1923,8 @@ static void coroutine_fn fuse_co_process_request_common(
             in_place_buf = NULL;
             spill_buf = out_buf;
         } else {
-            FuseQueue *q = opaque;
-            in = FUSE_IN_OP_STRUCT_LEGACY(write, q);
-            if (!in) {
-                break;
-            }
-
-            out = FUSE_OUT_OP_STRUCT_LEGACY(write, out_buf);
-
             /* Additional check for WRITE: verify the request includes data */
-            uint32_t req_len =
-                ((const struct fuse_in_header *)(q->request_buf))->len;
+            out = FUSE_OUT_OP_STRUCT_LEGACY(write, out_buf);
 
             if (unlikely(req_len < sizeof(struct fuse_in_header) + sizeof(*in) +
                         in->size)) {
@@ -2002,18 +1959,7 @@ static void coroutine_fn fuse_co_process_request_common(
     }
 
     case FUSE_FALLOCATE: {
-        const struct fuse_fallocate_in *in;
-
-        if (exp->uring_started) {
-            in = in_buf;
-        } else {
-            FuseQueue *q = opaque;
-            in = FUSE_IN_OP_STRUCT_LEGACY(fallocate, q);
-            if (!in) {
-                break;
-            }
-        }
-
+        const struct fuse_fallocate_in *in = FUSE_IN_OP_STRUCT(fallocate);
         ret = fuse_co_fallocate(exp, in->offset, in->length, in->mode);
         break;
     }
@@ -2028,19 +1974,12 @@ static void coroutine_fn fuse_co_process_request_common(
 
 #ifdef CONFIG_FUSE_LSEEK
     case FUSE_LSEEK: {
-        const struct fuse_lseek_in *in;
+        const struct fuse_lseek_in *in = FUSE_IN_OP_STRUCT(lseek);
         struct fuse_lseek_out *out;
 
         if (exp->uring_started) {
-            in = in_buf;
             out = out_buf;
         } else {
-            FuseQueue *q = opaque;
-            in = FUSE_IN_OP_STRUCT_LEGACY(lseek, q);
-            if (!in) {
-                break;
-            }
-
             out = FUSE_OUT_OP_STRUCT_LEGACY(lseek, out_buf);
         }
 
@@ -2081,6 +2020,7 @@ static void coroutine_fn fuse_co_process_request_common(
     }
 #endif
 }
+
 /* Helper to send response for legacy */
 static void send_response_legacy(void *opaque, uint32_t req_id, int ret,
                                  const void *buf, void *out_buf)
@@ -2101,8 +2041,10 @@ static void coroutine_fn
 fuse_co_process_request(FuseQueue *q, void *spillover_buf)
 {
     FuseExport *exp = q->exp;
+    uint32_t req_len;
     uint32_t opcode;
     uint64_t req_id;
+    const void *op_in;
 
     /*
      * Return buffer.  Must be large enough to hold all return headers, but does
@@ -2134,12 +2076,15 @@ fuse_co_process_request(FuseQueue *q, void *spillover_buf)
         const struct fuse_in_header *in_hdr =
             (const struct fuse_in_header *)q->request_buf;
 
+        req_len = in_hdr->len;
         opcode = in_hdr->opcode;
         req_id = in_hdr->unique;
+        op_in = in_hdr + 1;
     }
 
-    fuse_co_process_request_common(exp, opcode, req_id, NULL, spillover_buf,
-                                   out_buf, send_response_legacy, q);
+    fuse_co_process_request_common(exp, req_len, opcode, req_id, op_in,
+            spillover_buf, out_buf,
+            send_response_legacy, q);
 }
 
 #ifdef CONFIG_LINUX_IO_URING
@@ -2196,6 +2141,7 @@ static void coroutine_fn fuse_uring_co_process_request(FuseUringEnt *ent)
         (struct fuse_uring_ent_in_out *)&rrh->ring_ent_in_out;
     struct fuse_in_header *in_hdr =
         (struct fuse_in_header *)&rrh->in_out;
+    uint32_t req_len = in_hdr->len;
     uint32_t opcode = in_hdr->opcode;
     uint64_t req_id = in_hdr->unique;
 
@@ -2208,7 +2154,7 @@ static void coroutine_fn fuse_uring_co_process_request(FuseUringEnt *ent)
         return;
     }
 
-    fuse_co_process_request_common(exp, opcode, req_id, &rrh->op_in,
+    fuse_co_process_request_common(exp, req_len, opcode, req_id, &rrh->op_in,
         NULL, ent->req_payload, send_response_uring, ent);
 }
 #endif /* CONFIG_LINUX_IO_URING */
-- 
2.53.0


