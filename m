Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675CAC369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 18:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9TbP-0003AM-5u; Mon, 28 Apr 2025 14:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u9TbH-00036i-Kq
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 14:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u9TbF-0002qu-Jr
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 14:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745866384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JAFbol7NFCXBUTDNqhWJ07OXep90ovKk/mI1Cs0q3nY=;
 b=ORyNwSxMEWD5UorWRAY2ft96BYHA+WRVFjmrzI43m50w7cJsu8XkD4F7GS58+D/E+2Osls
 ggKrj9P+rMlCYLZ29mBz2NJaXpGl4Eayz+4ENC0qnvyZjMysmZ9Zx5yqJWw6Am9jlTsjbd
 aYCFELew7uIADhNLjR4+GBmvBiZ3VdA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-ufJuYek1PPGTdMG9qGdLaw-1; Mon,
 28 Apr 2025 14:53:00 -0400
X-MC-Unique: ufJuYek1PPGTdMG9qGdLaw-1
X-Mimecast-MFC-AGG-ID: ufJuYek1PPGTdMG9qGdLaw_1745866379
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FA651955DC5; Mon, 28 Apr 2025 18:52:59 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.31])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9316C180097D; Mon, 28 Apr 2025 18:52:57 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v2 4/4] nbd: Enable multi-conn using round-robin
Date: Mon, 28 Apr 2025 13:46:47 -0500
Message-ID: <20250428185246.492388-10-eblake@redhat.com>
In-Reply-To: <20250428185246.492388-6-eblake@redhat.com>
References: <20250428185246.492388-6-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: "Richard W.M. Jones" <rjones@redhat.com>

Enable NBD multi-conn by spreading operations across multiple
connections.

(XXX) This uses a naive round-robin approach which could be improved.
For example we could look at how many requests are in flight and
assign operations to the connections with fewest.  Or we could try to
estimate (based on size of requests outstanding) the load on each
connection.  But this implementation doesn't do any of that.

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
Message-ID: <20230309113946.1528247-5-rjones@redhat.com>
---
 block/nbd.c | 67 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 18 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 19da1a7a1fe..bf5bc57569c 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1264,6 +1264,26 @@ nbd_co_request(NBDConnState *cs, NBDRequest *request,
     return ret ? ret : request_ret;
 }

+/*
+ * If multi-conn, choose a connection for this operation.
+ */
+static NBDConnState *choose_connection(BDRVNBDState *s)
+{
+    static size_t next;
+    size_t i;
+
+    if (s->multi_conn <= 1) {
+        return s->conns[0];
+    }
+
+    /* XXX Stupid simple round robin. */
+    i = qatomic_fetch_inc(&next);
+    i %= s->multi_conn;
+
+    assert(s->conns[i] != NULL);
+    return s->conns[i];
+}
+
 static int coroutine_fn GRAPH_RDLOCK
 nbd_client_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
                      QEMUIOVector *qiov, BdrvRequestFlags flags)
@@ -1276,7 +1296,7 @@ nbd_client_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
         .from = offset,
         .len = bytes,
     };
-    NBDConnState * const cs = s->conns[0];
+    NBDConnState * const cs = choose_connection(s);

     assert(bytes <= NBD_MAX_BUFFER_SIZE);

@@ -1333,7 +1353,7 @@ nbd_client_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
         .from = offset,
         .len = bytes,
     };
-    NBDConnState * const cs = s->conns[0];
+    NBDConnState * const cs = choose_connection(s);

     assert(!(cs->info.flags & NBD_FLAG_READ_ONLY));
     if (flags & BDRV_REQ_FUA) {
@@ -1359,7 +1379,7 @@ nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int64_t bytes,
         .from = offset,
         .len = bytes,
     };
-    NBDConnState * const cs = s->conns[0];
+    NBDConnState * const cs = choose_connection(s);

     /* rely on max_pwrite_zeroes */
     assert(bytes <= UINT32_MAX || cs->info.mode >= NBD_MODE_EXTENDED);
@@ -1391,7 +1411,13 @@ static int coroutine_fn GRAPH_RDLOCK nbd_client_co_flush(BlockDriverState *bs)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     NBDRequest request = { .type = NBD_CMD_FLUSH };
-    NBDConnState * const cs = s->conns[0];
+
+    /*
+     * Multi-conn (if used) guarantees that flushing on any connection
+     * flushes caches on all connections, so we can perform this
+     * operation on any.
+     */
+    NBDConnState * const cs = choose_connection(s);

     if (!(cs->info.flags & NBD_FLAG_SEND_FLUSH)) {
         return 0;
@@ -1412,7 +1438,7 @@ nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
         .from = offset,
         .len = bytes,
     };
-    NBDConnState * const cs = s->conns[0];
+    NBDConnState * const cs = choose_connection(s);

     /* rely on max_pdiscard */
     assert(bytes <= UINT32_MAX || cs->info.mode >= NBD_MODE_EXTENDED);
@@ -1433,7 +1459,7 @@ static int coroutine_fn GRAPH_RDLOCK nbd_client_co_block_status(
     NBDExtent64 extent = { 0 };
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     Error *local_err = NULL;
-    NBDConnState * const cs = s->conns[0];
+    NBDConnState * const cs = choose_connection(s);

     NBDRequest request = {
         .type = NBD_CMD_BLOCK_STATUS,
@@ -2058,7 +2084,7 @@ fail:
 static void nbd_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
-    NBDConnState * const cs = s->conns[0];
+    NBDConnState * const cs = choose_connection(s);
     uint32_t min = cs->info.min_block;
     uint32_t max = MIN_NON_ZERO(NBD_MAX_BUFFER_SIZE, cs->info.max_block);

@@ -2124,7 +2150,7 @@ static int coroutine_fn nbd_co_truncate(BlockDriverState *bs, int64_t offset,
                                         BdrvRequestFlags flags, Error **errp)
 {
     BDRVNBDState *s = bs->opaque;
-    NBDConnState * const cs = s->conns[0];
+    NBDConnState * const cs = choose_connection(s);

     if (offset != cs->info.size && exact) {
         error_setg(errp, "Cannot resize NBD nodes");
@@ -2207,24 +2233,29 @@ static const char *const nbd_strong_runtime_opts[] = {
 static void nbd_cancel_in_flight(BlockDriverState *bs)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
-    NBDConnState * const cs = s->conns[0];
+    size_t i;
+    NBDConnState *cs;

-    reconnect_delay_timer_del(cs);
+    for (i = 0; i < MAX_MULTI_CONN; ++i) {
+        cs = s->conns[i];

-    qemu_mutex_lock(&cs->requests_lock);
-    if (cs->state == NBD_CLIENT_CONNECTING_WAIT) {
-        cs->state = NBD_CLIENT_CONNECTING_NOWAIT;
+        reconnect_delay_timer_del(cs);
+
+        qemu_mutex_lock(&cs->requests_lock);
+        if (cs->state == NBD_CLIENT_CONNECTING_WAIT) {
+            cs->state = NBD_CLIENT_CONNECTING_NOWAIT;
+        }
+        qemu_mutex_unlock(&cs->requests_lock);
+
+        nbd_co_establish_connection_cancel(cs->conn);
     }
-    qemu_mutex_unlock(&cs->requests_lock);
-
-    nbd_co_establish_connection_cancel(cs->conn);
 }

 static void nbd_attach_aio_context(BlockDriverState *bs,
                                    AioContext *new_context)
 {
     BDRVNBDState *s = bs->opaque;
-    NBDConnState * const cs = s->conns[0];
+    NBDConnState * const cs = choose_connection(s);

     /* The open_timer is used only during nbd_open() */
     assert(!cs->open_timer);
@@ -2244,7 +2275,7 @@ static void nbd_attach_aio_context(BlockDriverState *bs,
 static void nbd_detach_aio_context(BlockDriverState *bs)
 {
     BDRVNBDState *s = bs->opaque;
-    NBDConnState * const cs = s->conns[0];
+    NBDConnState * const cs = choose_connection(s);

     assert(!cs->open_timer);
     assert(!cs->reconnect_delay_timer);
-- 
2.49.0


