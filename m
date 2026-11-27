Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A186606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=uFiWjFxK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWozP-0006DF-79; Fri, 27 Nov 2026 00:59:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWozM-00067n-KB; Fri, 27 Nov 2026 00:59:16 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWozK-0007RD-Ny; Fri, 27 Nov 2026 00:59:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758877; bh=NJohPhhcx2beWCYH6dSPmQJSFa/3WL3ZVM7EsdxEZC4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=uFiWjFxKI+w+GJkZfDxLbQiTN7AUs7nyoUWwF6xcbCGh0GqD2IyE07Uxl9pgjEVdB
 bl30zbGvEp8rnf/65+/qH7HPClYcB6bVFUbX2doEl5k72zV6RaEnvCQ3pT54E6SYxu
 3Z7ERUt8d14WqAAYydG4jHvNOzOK0E6qdsH4BOq+lnmY0oMtbplL++a0EnhnZqDwtu
 TJrMiZD5S49C6LeFIv1kPNZTvjIMZziHy6QqRwmpQm64abo4tgwPIqtdz1t7c1XKjt
 YDbV5vHy7oHfeKfydL5Di0hfyling7YzZpHr7boK8w0gihCu2q7B9UtyN9zZy+RsZw
 IF05Yis6zI5Hg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E082F1EA2F7;
 Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DE08A469932;
 Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B60F1CF270; Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 109/140] nbd: Pass back offset/length for all
 structured read replies
Date: Fri, 27 Nov 2026 08:53:35 +0300
Message-ID: <20261127055421.39015-50-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
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

From: Eric Blake <eblake@redhat.com>

The NBD spec allows a server that has negotiated structured replies to
respond in any order among its various reply chunks. Although most
known servers happen to give replies in sequential order, QEMU must be
prepared for a server that intentionally returns out-of-order read
chunks (a malicious server could exploit that in an effort to attempt
to convince QEMU to expose uninitialized memory to a guest that is
using the NBD client as storage). Although this patch does not
actually add any new validation of the server's response chunks, it
does make it easier for the next patch to do so by providing a
centralized location in the code.  Now, in
nbd_co_receive_cmdread_reply(), payload contains a host-endian
offset+length after either the nbd_co_receive_one_chunk for
OFFSET_DATA or the nbd_parse_offset_hole_payload() for OFFSET_HOLE.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20261113223742.2546619-8-eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit b96bec51a5ee3eda9f03b85659abb89b5eb4ef60)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/nbd.c b/block/nbd.c
index 9365d0c0c36..83eeb080d46 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -784,9 +784,17 @@ static int nbd_parse_error_payload(NBDStructuredReplyChunk *chunk,
     return 0;
 }
 
+/*
+ * nbd_co_receive_offset_data_payload:
+ * Helper to nbd_co_do_receive_one_chunk when server replies with
+ * structured reply to NBD_CMD_READ with an OFFSET_DATA chunk. On
+ * success, synthesize an NBDStructuredReadHole into @payload
+ * describing the same region that was populated into @qiov.
+ */
 static int coroutine_fn
 nbd_co_receive_offset_data_payload(BDRVNBDState *s, uint64_t orig_offset,
-                                   QEMUIOVector *qiov, Error **errp)
+                                   QEMUIOVector *qiov, void **payload,
+                                   Error **errp)
 {
     QEMUIOVector sub_qiov;
     uint64_t offset;
@@ -795,6 +803,7 @@ nbd_co_receive_offset_data_payload(BDRVNBDState *s, uint64_t orig_offset,
     NBDStructuredReplyChunk *chunk = &s->reply.structured;
 
     assert(nbd_reply_is_structured(&s->reply));
+    assert(payload);
 
     /* The NBD spec requires at least one byte of payload */
     if (chunk->length <= sizeof(offset)) {
@@ -824,6 +833,18 @@ nbd_co_receive_offset_data_payload(BDRVNBDState *s, uint64_t orig_offset,
     ret = qio_channel_readv_all(s->ioc, sub_qiov.iov, sub_qiov.niov, errp);
     qemu_iovec_destroy(&sub_qiov);
 
+    if (ret == 0) {
+        /*
+         * Give the caller a struct describing the same region we
+         * populated here, to allow for easier followup accounting
+         * between data and hole reads.
+         */
+        NBDStructuredReadHole *synth = g_new(NBDStructuredReadHole, 1);
+        synth->offset = offset;
+        synth->length = data_size;
+        *payload = synth;
+    }
+
     return ret < 0 ? -EIO : 0;
 }
 
@@ -865,18 +886,21 @@ static coroutine_fn int nbd_co_receive_structured_payload(
 
 /*
  * nbd_co_do_receive_one_chunk
+ * @qiov is non-NULL for NBD_CMD_READ, NULL for all other commands.
  * for simple reply:
  *   set request_ret to received reply error
- *   if qiov is not NULL: read payload to @qiov
+ *   if qiov is not NULL: read data to @qiov
+ *   either way, @payload stays NULL
  * for structured reply chunk:
- *   if error chunk: read payload, set @request_ret, do not set @payload
- *   else if offset_data chunk: read payload data to @qiov, do not set @payload
- *   else: read payload to @payload
+ *   if error chunk: read chunk payload, set @request_ret, @payload is NULL
+ *   else if offset_data chunk and @qiov: read data to @qiov, allocate
+ *     @payload as NBDStructuredReadHole describing region just populated
+ *   else: read payload to @payload; caller checks size and contents
  *
- * If function fails, @errp contains corresponding error message, and the
- * connection with the server is suspect.  If it returns 0, then the
- * transaction succeeded (although @request_ret may be a negative errno
- * corresponding to the server's error reply), and errp is unchanged.
+ * If function fails, @errp contains corresponding error message, @payload
+ * is NULL, and the connection with the server is suspect.  If it returns 0,
+ * then the transaction succeeded (although @request_ret may be a negative
+ * errno corresponding to the server's error reply), and errp is unchanged.
  */
 static coroutine_fn int nbd_co_do_receive_one_chunk(
         BDRVNBDState *s, uint64_t cookie, bool only_structured,
@@ -943,7 +967,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
 
         return nbd_co_receive_offset_data_payload(
                 s, nbd_request_by_cookie(s, cookie, &error_abort)->offset,
-                qiov, errp);
+                qiov, payload, errp);
     }
 
     if (nbd_reply_type_is_error(chunk->type)) {
@@ -1091,6 +1115,7 @@ static bool coroutine_fn nbd_reply_chunk_iter_receive(BDRVNBDState *s,
     return true;
 
 break_loop:
+    assert(payload == NULL || *payload == NULL);
     qemu_mutex_lock(&s->requests_lock);
     nbd_request_by_cookie(s, cookie, &error_abort)->coroutine = NULL;
     s->in_flight--;
-- 
2.47.3


