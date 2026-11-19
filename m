Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C6E606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GZPptpc3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU8fj-0008VL-4a; Thu, 19 Nov 2026 15:23:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xU8fg-0008U4-S4
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:23:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xU8fd-0003Jb-7Q
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:23:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795119825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UOtdhRClmToIkuINOHRNiC72n4fmaONo8KvuB+D4MOA=;
 b=GZPptpc3tN1N6k961495oMzUd6+q1NoyoN2J+9XZDKz6m7WqeSrr3RpGFxtjcmYVY7zbZS
 IbLv6FZ4r9S2Bv1BQi/KVKhhuFRnstqQ8H5xmobfFHh6OpjMo4E0XMI78MuUqU3tQDfE/Z
 80T7Eiq9NV8Z8TeU6nkdQjCwPSfwbYg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-JmhlUJMdPwKLhmbWCPNdQA-1; Thu,
 19 Nov 2026 15:23:39 -0500
X-MC-Unique: JmhlUJMdPwKLhmbWCPNdQA-1
X-Mimecast-MFC-AGG-ID: JmhlUJMdPwKLhmbWCPNdQA_1795119818
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72FE6195D03D; Thu, 19 Nov 2026 20:23:38 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2A5B734C; Thu, 19 Nov 2026 20:23:36 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 2/3] nbd: Pass back offset/length for all structured read
 replies
Date: Thu, 19 Nov 2026 14:23:12 -0600
Message-ID: <20261119202330.3853797-7-eblake@redhat.com>
In-Reply-To: <20261119202330.3853797-5-eblake@redhat.com>
References: <20261119202330.3853797-5-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 block/nbd.c | 45 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 052469b3547..d873892c197 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -786,9 +786,17 @@ static int nbd_parse_error_payload(NBDStructuredReplyChunk *chunk,
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
@@ -797,6 +805,7 @@ nbd_co_receive_offset_data_payload(BDRVNBDState *s, uint64_t orig_offset,
     NBDStructuredReplyChunk *chunk = &s->reply.structured;

     assert(nbd_reply_is_structured(&s->reply));
+    assert(payload);

     /* The NBD spec requires at least one byte of payload */
     if (chunk->length <= sizeof(offset)) {
@@ -826,6 +835,18 @@ nbd_co_receive_offset_data_payload(BDRVNBDState *s, uint64_t orig_offset,
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

@@ -867,18 +888,21 @@ static coroutine_fn int nbd_co_receive_structured_payload(

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
@@ -945,7 +969,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(

         return nbd_co_receive_offset_data_payload(
                 s, nbd_request_by_cookie(s, cookie, &error_abort)->offset,
-                qiov, errp);
+                qiov, payload, errp);
     }

     if (nbd_reply_type_is_error(chunk->type)) {
@@ -1093,6 +1117,7 @@ static bool coroutine_fn nbd_reply_chunk_iter_receive(BDRVNBDState *s,
     return true;

 break_loop:
+    assert(payload == NULL || *payload == NULL);
     qemu_mutex_lock(&s->requests_lock);
     nbd_request_by_cookie(s, cookie, &error_abort)->coroutine = NULL;
     s->in_flight--;
-- 
2.56.1


