Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B06C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 18:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9TbO-0003AF-QO; Mon, 28 Apr 2025 14:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u9TbF-00036T-RB
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 14:53:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u9TbA-0002pf-0I
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 14:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745866378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z7U/DLVRepqbLtz2BYGuqBM/VN30uvhUJyHvxgafIR0=;
 b=GgxPlsiaoVhvZB4TIUWA3UCSGjDiewWZMWWIzv9B2eeTbhHR037dU5coo9Zn8SkwvVyeEX
 Ck1qy830UY7yvJKeC4x7CTG5d0++9Ay4ADAVn3hv4slPkSDVfRO76inFhLrWLNsCoienfd
 fKb1iVggdP3gv2XJuhpfQaTErdy6x/A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-ILoRAyjEMfKC6yscBZ69Sw-1; Mon,
 28 Apr 2025 14:52:56 -0400
X-MC-Unique: ILoRAyjEMfKC6yscBZ69Sw-1
X-Mimecast-MFC-AGG-ID: ILoRAyjEMfKC6yscBZ69Sw_1745866374
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D0B6180034A; Mon, 28 Apr 2025 18:52:54 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.31])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7A757180045B; Mon, 28 Apr 2025 18:52:52 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v2 2/4] nbd: Split out block device state from underlying NBD
 connections
Date: Mon, 28 Apr 2025 13:46:45 -0500
Message-ID: <20250428185246.492388-8-eblake@redhat.com>
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

To implement multi-conn, we will put multiple underlying NBD
connections (ie. NBDClientConnection) inside the NBD block device
handle (BDRVNBDState).  This requires first breaking the one-to-one
relationship between NBDClientConnection and BDRVNBDState.

To do this a new structure (NBDConnState) is implemented.
NBDConnState takes all the per-connection state out of the block
driver struct.  BDRVNBDState now contains a conns[] array of pointers
to NBDConnState, one for each underlying multi-conn connection.

After this change there is still a one-to-one relationship because we
only ever use the zeroth slot in the conns[] array.  Thus this does
not implement multi-conn yet.

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
Message-ID: <20230309113946.1528247-3-rjones@redhat.com>
[eblake: rebase to changes in the meantime]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/coroutines.h |   5 +-
 block/nbd.c        | 671 ++++++++++++++++++++++++---------------------
 2 files changed, 356 insertions(+), 320 deletions(-)

diff --git a/block/coroutines.h b/block/coroutines.h
index 892646bb7aa..d611408fa14 100644
--- a/block/coroutines.h
+++ b/block/coroutines.h
@@ -62,7 +62,7 @@ int coroutine_fn GRAPH_RDLOCK
 bdrv_co_writev_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos);

 int coroutine_fn GRAPH_RDLOCK
-nbd_co_do_establish_connection(BlockDriverState *bs, bool blocking,
+nbd_co_do_establish_connection(BlockDriverState *bs, void *cs, bool blocking,
                                Error **errp);


@@ -87,6 +87,7 @@ bdrv_common_block_status_above(BlockDriverState *bs,
                                int *depth);

 int co_wrapper_mixed_bdrv_rdlock
-nbd_do_establish_connection(BlockDriverState *bs, bool blocking, Error **errp);
+nbd_do_establish_connection(BlockDriverState *bs, void *cs, bool blocking,
+                            Error **errp);

 #endif /* BLOCK_COROUTINES_H */
diff --git a/block/nbd.c b/block/nbd.c
index 5eb00e360af..4690599bc61 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -66,7 +66,10 @@ typedef enum NBDClientState {
     NBD_CLIENT_QUIT
 } NBDClientState;

-typedef struct BDRVNBDState {
+/* A single client connection. */
+typedef struct NBDConnState {
+    struct BDRVNBDState *s; /* Points to enclosing BDRVNBDState */
+
     QIOChannel *ioc; /* The current I/O channel */
     NBDExportInfo info;

@@ -93,7 +96,12 @@ typedef struct BDRVNBDState {

     QEMUTimer *open_timer;

-    BlockDriverState *bs;
+    NBDClientConnection *conn;
+} NBDConnState;
+
+typedef struct BDRVNBDState {
+    /* The underlying NBD connections */
+    NBDConnState *conns[MAX_MULTI_CONN];

     /* Connection parameters */
     uint32_t reconnect_delay;
@@ -107,7 +115,7 @@ typedef struct BDRVNBDState {
     char *x_dirty_bitmap;
     bool alloc_depth;

-    NBDClientConnection *conn;
+    BlockDriverState *bs;
 } BDRVNBDState;

 static void nbd_yank(void *opaque);
@@ -116,14 +124,16 @@ static void nbd_clear_bdrvstate(BlockDriverState *bs)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;

-    nbd_client_connection_release(s->conn);
-    s->conn = NULL;
+    nbd_client_connection_release(s->conns[0]->conn);
+    s->conns[0]->conn = NULL;

     yank_unregister_instance(BLOCKDEV_YANK_INSTANCE(bs->node_name));

     /* Must not leave timers behind that would access freed data */
-    assert(!s->reconnect_delay_timer);
-    assert(!s->open_timer);
+    assert(!s->conns[0]->reconnect_delay_timer);
+    assert(!s->conns[0]->open_timer);
+
+    g_free(s->conns[0]);

     object_unref(OBJECT(s->tlscreds));
     qapi_free_SocketAddress(s->saddr);
@@ -150,140 +160,143 @@ static bool coroutine_fn nbd_recv_coroutine_wake_one(NBDClientRequest *req)
     return false;
 }

-static void coroutine_fn nbd_recv_coroutines_wake(BDRVNBDState *s)
+static void coroutine_fn nbd_recv_coroutines_wake(NBDConnState *cs)
 {
     int i;

-    QEMU_LOCK_GUARD(&s->receive_mutex);
+    QEMU_LOCK_GUARD(&cs->receive_mutex);
     for (i = 0; i < MAX_NBD_REQUESTS; i++) {
-        if (nbd_recv_coroutine_wake_one(&s->requests[i])) {
+        if (nbd_recv_coroutine_wake_one(&cs->requests[i])) {
             return;
         }
     }
 }

 /* Called with s->requests_lock held.  */
-static void coroutine_fn nbd_channel_error_locked(BDRVNBDState *s, int ret)
+static void coroutine_fn nbd_channel_error_locked(NBDConnState *cs, int ret)
 {
-    if (s->state == NBD_CLIENT_CONNECTED) {
-        qio_channel_shutdown(s->ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
+    if (cs->state == NBD_CLIENT_CONNECTED) {
+        qio_channel_shutdown(cs->ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
     }

     if (ret == -EIO) {
-        if (s->state == NBD_CLIENT_CONNECTED) {
-            s->state = s->reconnect_delay ? NBD_CLIENT_CONNECTING_WAIT :
-                                            NBD_CLIENT_CONNECTING_NOWAIT;
+        if (cs->state == NBD_CLIENT_CONNECTED) {
+            cs->state = cs->s->reconnect_delay ? NBD_CLIENT_CONNECTING_WAIT :
+                                                 NBD_CLIENT_CONNECTING_NOWAIT;
         }
     } else {
-        s->state = NBD_CLIENT_QUIT;
+        cs->state = NBD_CLIENT_QUIT;
     }
 }

-static void coroutine_fn nbd_channel_error(BDRVNBDState *s, int ret)
+static void coroutine_fn nbd_channel_error(NBDConnState *cs, int ret)
 {
-    QEMU_LOCK_GUARD(&s->requests_lock);
-    nbd_channel_error_locked(s, ret);
+    QEMU_LOCK_GUARD(&cs->requests_lock);
+    nbd_channel_error_locked(cs, ret);
 }

-static void reconnect_delay_timer_del(BDRVNBDState *s)
+static void reconnect_delay_timer_del(NBDConnState *cs)
 {
-    if (s->reconnect_delay_timer) {
-        timer_free(s->reconnect_delay_timer);
-        s->reconnect_delay_timer = NULL;
+    if (cs->reconnect_delay_timer) {
+        timer_free(cs->reconnect_delay_timer);
+        cs->reconnect_delay_timer = NULL;
     }
 }

 static void reconnect_delay_timer_cb(void *opaque)
 {
-    BDRVNBDState *s = opaque;
+    NBDConnState *cs = opaque;

-    reconnect_delay_timer_del(s);
-    WITH_QEMU_LOCK_GUARD(&s->requests_lock) {
-        if (s->state != NBD_CLIENT_CONNECTING_WAIT) {
+    reconnect_delay_timer_del(cs);
+    WITH_QEMU_LOCK_GUARD(&cs->requests_lock) {
+        if (cs->state != NBD_CLIENT_CONNECTING_WAIT) {
             return;
         }
-        s->state = NBD_CLIENT_CONNECTING_NOWAIT;
+        cs->state = NBD_CLIENT_CONNECTING_NOWAIT;
     }
-    nbd_co_establish_connection_cancel(s->conn);
+    nbd_co_establish_connection_cancel(cs->conn);
 }

-static void reconnect_delay_timer_init(BDRVNBDState *s, uint64_t expire_time_ns)
+static void reconnect_delay_timer_init(NBDConnState *cs,
+                                       uint64_t expire_time_ns)
 {
-    assert(!s->reconnect_delay_timer);
-    s->reconnect_delay_timer = aio_timer_new(bdrv_get_aio_context(s->bs),
-                                             QEMU_CLOCK_REALTIME,
-                                             SCALE_NS,
-                                             reconnect_delay_timer_cb, s);
-    timer_mod(s->reconnect_delay_timer, expire_time_ns);
+    assert(!cs->reconnect_delay_timer);
+    cs->reconnect_delay_timer = aio_timer_new(bdrv_get_aio_context(cs->s->bs),
+                                              QEMU_CLOCK_REALTIME,
+                                              SCALE_NS,
+                                              reconnect_delay_timer_cb, cs);
+    timer_mod(cs->reconnect_delay_timer, expire_time_ns);
 }

-static void nbd_teardown_connection(BlockDriverState *bs)
+static void nbd_teardown_connection(NBDConnState *cs)
 {
-    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
+    assert(!cs->in_flight);

-    assert(!s->in_flight);
-
-    if (s->ioc) {
-        qio_channel_shutdown(s->ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
-        yank_unregister_function(BLOCKDEV_YANK_INSTANCE(s->bs->node_name),
-                                 nbd_yank, s->bs);
-        object_unref(OBJECT(s->ioc));
-        s->ioc = NULL;
+    if (cs->ioc) {
+        qio_channel_shutdown(cs->ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
+        yank_unregister_function(BLOCKDEV_YANK_INSTANCE(cs->s->bs->node_name),
+                                 nbd_yank, cs);
+        object_unref(OBJECT(cs->ioc));
+        cs->ioc = NULL;
     }

-    WITH_QEMU_LOCK_GUARD(&s->requests_lock) {
-        s->state = NBD_CLIENT_QUIT;
+    WITH_QEMU_LOCK_GUARD(&cs->requests_lock) {
+        cs->state = NBD_CLIENT_QUIT;
     }
 }

-static void open_timer_del(BDRVNBDState *s)
+static void open_timer_del(NBDConnState *cs)
 {
-    if (s->open_timer) {
-        timer_free(s->open_timer);
-        s->open_timer = NULL;
+    if (cs->open_timer) {
+        timer_free(cs->open_timer);
+        cs->open_timer = NULL;
     }
 }

 static void open_timer_cb(void *opaque)
 {
-    BDRVNBDState *s = opaque;
+    NBDConnState *cs = opaque;

-    nbd_co_establish_connection_cancel(s->conn);
-    open_timer_del(s);
+    nbd_co_establish_connection_cancel(cs->conn);
+    open_timer_del(cs);
 }

-static void open_timer_init(BDRVNBDState *s, uint64_t expire_time_ns)
+static void open_timer_init(NBDConnState *cs, uint64_t expire_time_ns)
 {
-    assert(!s->open_timer);
-    s->open_timer = aio_timer_new(bdrv_get_aio_context(s->bs),
-                                  QEMU_CLOCK_REALTIME,
-                                  SCALE_NS,
-                                  open_timer_cb, s);
-    timer_mod(s->open_timer, expire_time_ns);
+    assert(!cs->open_timer);
+    cs->open_timer = aio_timer_new(bdrv_get_aio_context(cs->s->bs),
+                                   QEMU_CLOCK_REALTIME,
+                                   SCALE_NS,
+                                   open_timer_cb, cs);
+    timer_mod(cs->open_timer, expire_time_ns);
 }

-static bool nbd_client_will_reconnect(BDRVNBDState *s)
+static bool nbd_client_will_reconnect(NBDConnState *cs)
 {
     /*
      * Called only after a socket error, so this is not performance sensitive.
      */
-    QEMU_LOCK_GUARD(&s->requests_lock);
-    return s->state == NBD_CLIENT_CONNECTING_WAIT;
+    QEMU_LOCK_GUARD(&cs->requests_lock);
+    return cs->state == NBD_CLIENT_CONNECTING_WAIT;
 }

 /*
  * Update @bs with information learned during a completed negotiation process.
  * Return failure if the server's advertised options are incompatible with the
  * client's needs.
+ *
+ * Note that we are only called for the first connection (s->conns[0])
+ * because multi-conn assumes that all other connections are alike.
+ * We don't check that assumption but probably should (XXX).
  */
 static int coroutine_fn GRAPH_RDLOCK
-nbd_handle_updated_info(BlockDriverState *bs, Error **errp)
+nbd_handle_updated_info(BlockDriverState *bs, NBDConnState *cs, Error **errp)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     int ret;

     if (s->x_dirty_bitmap) {
-        if (!s->info.base_allocation) {
+        if (!cs->info.base_allocation) {
             error_setg(errp, "requested x-dirty-bitmap %s not found",
                        s->x_dirty_bitmap);
             return -EINVAL;
@@ -293,21 +306,21 @@ nbd_handle_updated_info(BlockDriverState *bs, Error **errp)
         }
     }

-    if (s->info.flags & NBD_FLAG_READ_ONLY) {
+    if (cs->info.flags & NBD_FLAG_READ_ONLY) {
         ret = bdrv_apply_auto_read_only(bs, "NBD export is read-only", errp);
         if (ret < 0) {
             return ret;
         }
     }

-    if (s->info.flags & NBD_FLAG_SEND_FUA) {
+    if (cs->info.flags & NBD_FLAG_SEND_FUA) {
         bs->supported_write_flags = BDRV_REQ_FUA;
         bs->supported_zero_flags |= BDRV_REQ_FUA;
     }

-    if (s->info.flags & NBD_FLAG_SEND_WRITE_ZEROES) {
+    if (cs->info.flags & NBD_FLAG_SEND_WRITE_ZEROES) {
         bs->supported_zero_flags |= BDRV_REQ_MAY_UNMAP;
-        if (s->info.flags & NBD_FLAG_SEND_FAST_ZERO) {
+        if (cs->info.flags & NBD_FLAG_SEND_FAST_ZERO) {
             bs->supported_zero_flags |= BDRV_REQ_NO_FALLBACK;
         }
     }
@@ -318,130 +331,134 @@ nbd_handle_updated_info(BlockDriverState *bs, Error **errp)
 }

 int coroutine_fn nbd_co_do_establish_connection(BlockDriverState *bs,
+                                                void *csvp,
                                                 bool blocking, Error **errp)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
+    NBDConnState *cs = csvp;
     int ret;
     IO_CODE();

     assert_bdrv_graph_readable();
-    assert(!s->ioc);
+    assert(!cs->ioc);

-    s->ioc = nbd_co_establish_connection(s->conn, &s->info, blocking, errp);
-    if (!s->ioc) {
+    cs->ioc = nbd_co_establish_connection(cs->conn, &cs->info, blocking, errp);
+    if (!cs->ioc) {
         return -ECONNREFUSED;
     }

-    yank_register_function(BLOCKDEV_YANK_INSTANCE(s->bs->node_name), nbd_yank,
-                           bs);
+    yank_register_function(BLOCKDEV_YANK_INSTANCE(bs->node_name), nbd_yank, cs);

-    ret = nbd_handle_updated_info(s->bs, NULL);
-    if (ret < 0) {
-        /*
-         * We have connected, but must fail for other reasons.
-         * Send NBD_CMD_DISC as a courtesy to the server.
-         */
-        NBDRequest request = { .type = NBD_CMD_DISC, .mode = s->info.mode };
+    if (cs == s->conns[0]) {
+        ret = nbd_handle_updated_info(s->bs, cs, NULL);
+        if (ret < 0) {
+            /*
+             * We have connected, but must fail for other reasons.
+             * Send NBD_CMD_DISC as a courtesy to the server.
+             */
+            NBDRequest request = { .type = NBD_CMD_DISC,
+                                   .mode = cs->info.mode };

-        nbd_send_request(s->ioc, &request);
+            nbd_send_request(cs->ioc, &request);

-        yank_unregister_function(BLOCKDEV_YANK_INSTANCE(s->bs->node_name),
-                                 nbd_yank, bs);
-        object_unref(OBJECT(s->ioc));
-        s->ioc = NULL;
+            yank_unregister_function(BLOCKDEV_YANK_INSTANCE(s->bs->node_name),
+                                     nbd_yank, cs);
+            object_unref(OBJECT(cs->ioc));
+            cs->ioc = NULL;

-        return ret;
+            return ret;
+        }
     }

-    qio_channel_set_blocking(s->ioc, false, NULL);
-    qio_channel_set_follow_coroutine_ctx(s->ioc, true);
+    qio_channel_set_blocking(cs->ioc, false, NULL);
+    qio_channel_set_follow_coroutine_ctx(cs->ioc, true);

     /* successfully connected */
-    WITH_QEMU_LOCK_GUARD(&s->requests_lock) {
-        s->state = NBD_CLIENT_CONNECTED;
+    WITH_QEMU_LOCK_GUARD(&cs->requests_lock) {
+        cs->state = NBD_CLIENT_CONNECTED;
     }

     return 0;
 }

 /* Called with s->requests_lock held.  */
-static bool nbd_client_connecting(BDRVNBDState *s)
+static bool nbd_client_connecting(NBDConnState *cs)
 {
-    return s->state == NBD_CLIENT_CONNECTING_WAIT ||
-        s->state == NBD_CLIENT_CONNECTING_NOWAIT;
+    return cs->state == NBD_CLIENT_CONNECTING_WAIT ||
+        cs->state == NBD_CLIENT_CONNECTING_NOWAIT;
 }

 /* Called with s->requests_lock taken.  */
-static void coroutine_fn GRAPH_RDLOCK nbd_reconnect_attempt(BDRVNBDState *s)
+static void coroutine_fn GRAPH_RDLOCK nbd_reconnect_attempt(NBDConnState *cs)
 {
     int ret;
-    bool blocking = s->state == NBD_CLIENT_CONNECTING_WAIT;
+    bool blocking = cs->state == NBD_CLIENT_CONNECTING_WAIT;

     /*
      * Now we are sure that nobody is accessing the channel, and no one will
      * try until we set the state to CONNECTED.
      */
-    assert(nbd_client_connecting(s));
-    assert(s->in_flight == 1);
+    assert(nbd_client_connecting(cs));
+    assert(cs->in_flight == 1);

-    trace_nbd_reconnect_attempt(s->bs->in_flight);
+    trace_nbd_reconnect_attempt(cs->s->bs->in_flight);

-    if (blocking && !s->reconnect_delay_timer) {
+    if (blocking && !cs->reconnect_delay_timer) {
         /*
          * It's the first reconnect attempt after switching to
          * NBD_CLIENT_CONNECTING_WAIT
          */
-        g_assert(s->reconnect_delay);
-        reconnect_delay_timer_init(s,
+        g_assert(cs->s->reconnect_delay);
+        reconnect_delay_timer_init(cs,
             qemu_clock_get_ns(QEMU_CLOCK_REALTIME) +
-            s->reconnect_delay * NANOSECONDS_PER_SECOND);
+            cs->s->reconnect_delay * NANOSECONDS_PER_SECOND);
     }

     /* Finalize previous connection if any */
-    if (s->ioc) {
-        yank_unregister_function(BLOCKDEV_YANK_INSTANCE(s->bs->node_name),
-                                 nbd_yank, s->bs);
-        object_unref(OBJECT(s->ioc));
-        s->ioc = NULL;
+    if (cs->ioc) {
+        yank_unregister_function(BLOCKDEV_YANK_INSTANCE(cs->s->bs->node_name),
+                                 nbd_yank, cs);
+        object_unref(OBJECT(cs->ioc));
+        cs->ioc = NULL;
     }

-    qemu_mutex_unlock(&s->requests_lock);
-    ret = nbd_co_do_establish_connection(s->bs, blocking, NULL);
-    trace_nbd_reconnect_attempt_result(ret, s->bs->in_flight);
-    qemu_mutex_lock(&s->requests_lock);
+    qemu_mutex_unlock(&cs->requests_lock);
+    ret = nbd_co_do_establish_connection(cs->s->bs, cs, blocking, NULL);
+    trace_nbd_reconnect_attempt_result(ret, cs->s->bs->in_flight);
+    qemu_mutex_lock(&cs->requests_lock);

     /*
      * The reconnect attempt is done (maybe successfully, maybe not), so
      * we no longer need this timer.  Delete it so it will not outlive
      * this I/O request (so draining removes all timers).
      */
-    reconnect_delay_timer_del(s);
+    reconnect_delay_timer_del(cs);
 }

-static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie,
+static coroutine_fn int nbd_receive_replies(NBDConnState *cs, uint64_t cookie,
                                             Error **errp)
 {
     int ret;
     uint64_t ind = COOKIE_TO_INDEX(cookie), ind2;
-    QEMU_LOCK_GUARD(&s->receive_mutex);
+    QEMU_LOCK_GUARD(&cs->receive_mutex);

     while (true) {
-        if (s->reply.cookie == cookie) {
+        if (cs->reply.cookie == cookie) {
             /* We are done */
             return 0;
         }

-        if (s->reply.cookie != 0) {
+        if (cs->reply.cookie != 0) {
             /*
              * Some other request is being handled now. It should already be
-             * woken by whoever set s->reply.cookie (or never wait in this
+             * woken by whoever set cs->reply.cookie (or never wait in this
              * yield). So, we should not wake it here.
              */
-            ind2 = COOKIE_TO_INDEX(s->reply.cookie);
-            assert(!s->requests[ind2].receiving);
+            ind2 = COOKIE_TO_INDEX(cs->reply.cookie);
+            assert(!cs->requests[ind2].receiving);

-            s->requests[ind].receiving = true;
-            qemu_co_mutex_unlock(&s->receive_mutex);
+            cs->requests[ind].receiving = true;
+            qemu_co_mutex_unlock(&cs->receive_mutex);

             qemu_coroutine_yield();
             /*
@@ -449,112 +466,112 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie,
              * 1. From this function, executing in parallel coroutine, when our
              *    cookie is received.
              * 2. From nbd_co_receive_one_chunk(), when previous request is
-             *    finished and s->reply.cookie set to 0.
+             *    finished and cs->reply.cookie set to 0.
              * Anyway, it's OK to lock the mutex and go to the next iteration.
              */

-            qemu_co_mutex_lock(&s->receive_mutex);
-            assert(!s->requests[ind].receiving);
+            qemu_co_mutex_lock(&cs->receive_mutex);
+            assert(!cs->requests[ind].receiving);
             continue;
         }

         /* We are under mutex and cookie is 0. We have to do the dirty work. */
-        assert(s->reply.cookie == 0);
-        ret = nbd_receive_reply(s->bs, s->ioc, &s->reply, s->info.mode, errp);
+        assert(cs->reply.cookie == 0);
+        ret = nbd_receive_reply(cs->s->bs, cs->ioc, &cs->reply,
+                                cs->info.mode, errp);
         if (ret == 0) {
             ret = -EIO;
             error_setg(errp, "server dropped connection");
         }
         if (ret < 0) {
-            nbd_channel_error(s, ret);
+            nbd_channel_error(cs, ret);
             return ret;
         }
-        if (nbd_reply_is_structured(&s->reply) &&
-            s->info.mode < NBD_MODE_STRUCTURED) {
-            nbd_channel_error(s, -EINVAL);
+        if (nbd_reply_is_structured(&cs->reply) &&
+            cs->info.mode < NBD_MODE_STRUCTURED) {
+            nbd_channel_error(cs, -EINVAL);
             error_setg(errp, "unexpected structured reply");
             return -EINVAL;
         }
-        ind2 = COOKIE_TO_INDEX(s->reply.cookie);
-        if (ind2 >= MAX_NBD_REQUESTS || !s->requests[ind2].coroutine) {
-            nbd_channel_error(s, -EINVAL);
+        ind2 = COOKIE_TO_INDEX(cs->reply.cookie);
+        if (ind2 >= MAX_NBD_REQUESTS || !cs->requests[ind2].coroutine) {
+            nbd_channel_error(cs, -EINVAL);
             error_setg(errp, "unexpected cookie value");
             return -EINVAL;
         }
-        if (s->reply.cookie == cookie) {
+        if (cs->reply.cookie == cookie) {
             /* We are done */
             return 0;
         }
-        nbd_recv_coroutine_wake_one(&s->requests[ind2]);
+        nbd_recv_coroutine_wake_one(&cs->requests[ind2]);
     }
 }

 static int coroutine_fn GRAPH_RDLOCK
-nbd_co_send_request(BlockDriverState *bs, NBDRequest *request,
+nbd_co_send_request(NBDConnState *cs, NBDRequest *request,
                     QEMUIOVector *qiov)
 {
-    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     int rc, i = -1;

-    qemu_mutex_lock(&s->requests_lock);
-    while (s->in_flight == MAX_NBD_REQUESTS ||
-           (s->state != NBD_CLIENT_CONNECTED && s->in_flight > 0)) {
-        qemu_co_queue_wait(&s->free_sema, &s->requests_lock);
+    qemu_mutex_lock(&cs->requests_lock);
+    while (cs->in_flight == MAX_NBD_REQUESTS ||
+           (cs->state != NBD_CLIENT_CONNECTED && cs->in_flight > 0)) {
+        qemu_co_queue_wait(&cs->free_sema, &cs->requests_lock);
     }

-    s->in_flight++;
-    if (s->state != NBD_CLIENT_CONNECTED) {
-        if (nbd_client_connecting(s)) {
-            nbd_reconnect_attempt(s);
-            qemu_co_queue_restart_all(&s->free_sema);
+    cs->in_flight++;
+    if (cs->state != NBD_CLIENT_CONNECTED) {
+        if (nbd_client_connecting(cs)) {
+            nbd_reconnect_attempt(cs);
+            qemu_co_queue_restart_all(&cs->free_sema);
         }
-        if (s->state != NBD_CLIENT_CONNECTED) {
+        if (cs->state != NBD_CLIENT_CONNECTED) {
             rc = -EIO;
             goto err;
         }
     }

     for (i = 0; i < MAX_NBD_REQUESTS; i++) {
-        if (s->requests[i].coroutine == NULL) {
+        if (cs->requests[i].coroutine == NULL) {
             break;
         }
     }

     assert(i < MAX_NBD_REQUESTS);
-    s->requests[i].coroutine = qemu_coroutine_self();
-    s->requests[i].offset = request->from;
-    s->requests[i].receiving = false;
-    qemu_mutex_unlock(&s->requests_lock);
+    cs->requests[i].coroutine = qemu_coroutine_self();
+    cs->requests[i].offset = request->from;
+    cs->requests[i].receiving = false;
+    qemu_mutex_unlock(&cs->requests_lock);

-    qemu_co_mutex_lock(&s->send_mutex);
+    qemu_co_mutex_lock(&cs->send_mutex);
     request->cookie = INDEX_TO_COOKIE(i);
-    request->mode = s->info.mode;
+    request->mode = cs->info.mode;

-    assert(s->ioc);
+    assert(cs->ioc);

     if (qiov) {
-        qio_channel_set_cork(s->ioc, true);
-        rc = nbd_send_request(s->ioc, request);
-        if (rc >= 0 && qio_channel_writev_all(s->ioc, qiov->iov, qiov->niov,
+        qio_channel_set_cork(cs->ioc, true);
+        rc = nbd_send_request(cs->ioc, request);
+        if (rc >= 0 && qio_channel_writev_all(cs->ioc, qiov->iov, qiov->niov,
                                               NULL) < 0) {
             rc = -EIO;
         }
-        qio_channel_set_cork(s->ioc, false);
+        qio_channel_set_cork(cs->ioc, false);
     } else {
-        rc = nbd_send_request(s->ioc, request);
+        rc = nbd_send_request(cs->ioc, request);
     }
-    qemu_co_mutex_unlock(&s->send_mutex);
+    qemu_co_mutex_unlock(&cs->send_mutex);

     if (rc < 0) {
-        qemu_mutex_lock(&s->requests_lock);
+        qemu_mutex_lock(&cs->requests_lock);
 err:
-        nbd_channel_error_locked(s, rc);
+        nbd_channel_error_locked(cs, rc);
         if (i != -1) {
-            s->requests[i].coroutine = NULL;
+            cs->requests[i].coroutine = NULL;
         }
-        s->in_flight--;
-        qemu_co_queue_next(&s->free_sema);
-        qemu_mutex_unlock(&s->requests_lock);
+        cs->in_flight--;
+        qemu_co_queue_next(&cs->free_sema);
+        qemu_mutex_unlock(&cs->requests_lock);
     }
     return rc;
 }
@@ -577,7 +594,7 @@ static inline uint64_t payload_advance64(uint8_t **payload)
     return ldq_be_p(*payload - 8);
 }

-static int nbd_parse_offset_hole_payload(BDRVNBDState *s,
+static int nbd_parse_offset_hole_payload(NBDConnState *cs,
                                          NBDStructuredReplyChunk *chunk,
                                          uint8_t *payload, uint64_t orig_offset,
                                          QEMUIOVector *qiov, Error **errp)
@@ -600,8 +617,8 @@ static int nbd_parse_offset_hole_payload(BDRVNBDState *s,
                          " region");
         return -EINVAL;
     }
-    if (s->info.min_block &&
-        !QEMU_IS_ALIGNED(hole_size, s->info.min_block)) {
+    if (cs->info.min_block &&
+        !QEMU_IS_ALIGNED(hole_size, cs->info.min_block)) {
         trace_nbd_structured_read_compliance("hole");
     }

@@ -615,7 +632,7 @@ static int nbd_parse_offset_hole_payload(BDRVNBDState *s,
  * Based on our request, we expect only one extent in reply, for the
  * base:allocation context.
  */
-static int nbd_parse_blockstatus_payload(BDRVNBDState *s,
+static int nbd_parse_blockstatus_payload(NBDConnState *cs,
                                          NBDStructuredReplyChunk *chunk,
                                          uint8_t *payload, bool wide,
                                          uint64_t orig_length,
@@ -634,11 +651,11 @@ static int nbd_parse_blockstatus_payload(BDRVNBDState *s,
     }

     context_id = payload_advance32(&payload);
-    if (s->info.context_id != context_id) {
+    if (cs->info.context_id != context_id) {
         error_setg(errp, "Protocol error: unexpected context id %d for "
                          "NBD_REPLY_TYPE_BLOCK_STATUS, when negotiated context "
                          "id is %d", context_id,
-                         s->info.context_id);
+                         cs->info.context_id);
         return -EINVAL;
     }

@@ -670,14 +687,14 @@ static int nbd_parse_blockstatus_payload(BDRVNBDState *s,
      * up to the full block and change the status to fully-allocated
      * (always a safe status, even if it loses information).
      */
-    if (s->info.min_block && !QEMU_IS_ALIGNED(extent->length,
-                                              s->info.min_block)) {
+    if (cs->info.min_block && !QEMU_IS_ALIGNED(extent->length,
+                                               cs->info.min_block)) {
         trace_nbd_parse_blockstatus_compliance("extent length is unaligned");
-        if (extent->length > s->info.min_block) {
+        if (extent->length > cs->info.min_block) {
             extent->length = QEMU_ALIGN_DOWN(extent->length,
-                                             s->info.min_block);
+                                             cs->info.min_block);
         } else {
-            extent->length = s->info.min_block;
+            extent->length = cs->info.min_block;
             extent->flags = 0;
         }
     }
@@ -706,7 +723,7 @@ static int nbd_parse_blockstatus_payload(BDRVNBDState *s,
      * since nbd_client_co_block_status is only expecting the low two
      * bits to be set.
      */
-    if (s->alloc_depth && extent->flags > 2) {
+    if (cs->s->alloc_depth && extent->flags > 2) {
         extent->flags = 2;
     }

@@ -756,16 +773,16 @@ static int nbd_parse_error_payload(NBDStructuredReplyChunk *chunk,
 }

 static int coroutine_fn
-nbd_co_receive_offset_data_payload(BDRVNBDState *s, uint64_t orig_offset,
+nbd_co_receive_offset_data_payload(NBDConnState *cs, uint64_t orig_offset,
                                    QEMUIOVector *qiov, Error **errp)
 {
     QEMUIOVector sub_qiov;
     uint64_t offset;
     size_t data_size;
     int ret;
-    NBDStructuredReplyChunk *chunk = &s->reply.structured;
+    NBDStructuredReplyChunk *chunk = &cs->reply.structured;

-    assert(nbd_reply_is_structured(&s->reply));
+    assert(nbd_reply_is_structured(&cs->reply));

     /* The NBD spec requires at least one byte of payload */
     if (chunk->length <= sizeof(offset)) {
@@ -774,7 +791,7 @@ nbd_co_receive_offset_data_payload(BDRVNBDState *s, uint64_t orig_offset,
         return -EINVAL;
     }

-    if (nbd_read64(s->ioc, &offset, "OFFSET_DATA offset", errp) < 0) {
+    if (nbd_read64(cs->ioc, &offset, "OFFSET_DATA offset", errp) < 0) {
         return -EIO;
     }

@@ -786,13 +803,14 @@ nbd_co_receive_offset_data_payload(BDRVNBDState *s, uint64_t orig_offset,
                          " region");
         return -EINVAL;
     }
-    if (s->info.min_block && !QEMU_IS_ALIGNED(data_size, s->info.min_block)) {
+    if (cs->info.min_block &&
+        !QEMU_IS_ALIGNED(data_size, cs->info.min_block)) {
         trace_nbd_structured_read_compliance("data");
     }

     qemu_iovec_init(&sub_qiov, qiov->niov);
     qemu_iovec_concat(&sub_qiov, qiov, offset - orig_offset, data_size);
-    ret = qio_channel_readv_all(s->ioc, sub_qiov.iov, sub_qiov.niov, errp);
+    ret = qio_channel_readv_all(cs->ioc, sub_qiov.iov, sub_qiov.niov, errp);
     qemu_iovec_destroy(&sub_qiov);

     return ret < 0 ? -EIO : 0;
@@ -800,14 +818,14 @@ nbd_co_receive_offset_data_payload(BDRVNBDState *s, uint64_t orig_offset,

 #define NBD_MAX_MALLOC_PAYLOAD 1000
 static coroutine_fn int nbd_co_receive_structured_payload(
-        BDRVNBDState *s, void **payload, Error **errp)
+        NBDConnState *cs, void **payload, Error **errp)
 {
     int ret;
     uint32_t len;

-    assert(nbd_reply_is_structured(&s->reply));
+    assert(nbd_reply_is_structured(&cs->reply));

-    len = s->reply.structured.length;
+    len = cs->reply.structured.length;

     if (len == 0) {
         return 0;
@@ -824,7 +842,7 @@ static coroutine_fn int nbd_co_receive_structured_payload(
     }

     *payload = g_new(char, len);
-    ret = nbd_read(s->ioc, *payload, len, "structured payload", errp);
+    ret = nbd_read(cs->ioc, *payload, len, "structured payload", errp);
     if (ret < 0) {
         g_free(*payload);
         *payload = NULL;
@@ -850,7 +868,7 @@ static coroutine_fn int nbd_co_receive_structured_payload(
  * corresponding to the server's error reply), and errp is unchanged.
  */
 static coroutine_fn int nbd_co_do_receive_one_chunk(
-        BDRVNBDState *s, uint64_t cookie, bool only_structured,
+        NBDConnState *cs, uint64_t cookie, bool only_structured,
         int *request_ret, QEMUIOVector *qiov, void **payload, Error **errp)
 {
     ERRP_GUARD();
@@ -864,34 +882,34 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
     }
     *request_ret = 0;

-    ret = nbd_receive_replies(s, cookie, errp);
+    ret = nbd_receive_replies(cs, cookie, errp);
     if (ret < 0) {
         error_prepend(errp, "Connection closed: ");
         return -EIO;
     }
-    assert(s->ioc);
+    assert(cs->ioc);

-    assert(s->reply.cookie == cookie);
+    assert(cs->reply.cookie == cookie);

-    if (nbd_reply_is_simple(&s->reply)) {
+    if (nbd_reply_is_simple(&cs->reply)) {
         if (only_structured) {
             error_setg(errp, "Protocol error: simple reply when structured "
                              "reply chunk was expected");
             return -EINVAL;
         }

-        *request_ret = -nbd_errno_to_system_errno(s->reply.simple.error);
+        *request_ret = -nbd_errno_to_system_errno(cs->reply.simple.error);
         if (*request_ret < 0 || !qiov) {
             return 0;
         }

-        return qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
+        return qio_channel_readv_all(cs->ioc, qiov->iov, qiov->niov,
                                      errp) < 0 ? -EIO : 0;
     }

     /* handle structured reply chunk */
-    assert(s->info.mode >= NBD_MODE_STRUCTURED);
-    chunk = &s->reply.structured;
+    assert(cs->info.mode >= NBD_MODE_STRUCTURED);
+    chunk = &cs->reply.structured;

     if (chunk->type == NBD_REPLY_TYPE_NONE) {
         if (!(chunk->flags & NBD_REPLY_FLAG_DONE)) {
@@ -913,7 +931,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
             return -EINVAL;
         }

-        return nbd_co_receive_offset_data_payload(s, s->requests[i].offset,
+        return nbd_co_receive_offset_data_payload(cs, cs->requests[i].offset,
                                                   qiov, errp);
     }

@@ -921,7 +939,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
         payload = &local_payload;
     }

-    ret = nbd_co_receive_structured_payload(s, payload, errp);
+    ret = nbd_co_receive_structured_payload(cs, payload, errp);
     if (ret < 0) {
         return ret;
     }
@@ -941,23 +959,23 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
  * Return value is a fatal error code or normal nbd reply error code
  */
 static coroutine_fn int nbd_co_receive_one_chunk(
-        BDRVNBDState *s, uint64_t cookie, bool only_structured,
+        NBDConnState *cs, uint64_t cookie, bool only_structured,
         int *request_ret, QEMUIOVector *qiov, NBDReply *reply, void **payload,
         Error **errp)
 {
-    int ret = nbd_co_do_receive_one_chunk(s, cookie, only_structured,
+    int ret = nbd_co_do_receive_one_chunk(cs, cookie, only_structured,
                                           request_ret, qiov, payload, errp);

     if (ret < 0) {
         memset(reply, 0, sizeof(*reply));
-        nbd_channel_error(s, ret);
+        nbd_channel_error(cs, ret);
     } else {
         /* For assert at loop start in nbd_connection_entry */
-        *reply = s->reply;
+        *reply = cs->reply;
     }
-    s->reply.cookie = 0;
+    cs->reply.cookie = 0;

-    nbd_recv_coroutines_wake(s);
+    nbd_recv_coroutines_wake(cs);

     return ret;
 }
@@ -998,16 +1016,16 @@ static void nbd_iter_request_error(NBDReplyChunkIter *iter, int ret)
  * NBD_FOREACH_REPLY_CHUNK
  * The pointer stored in @payload requires g_free() to free it.
  */
-#define NBD_FOREACH_REPLY_CHUNK(s, iter, cookie, structured, \
+#define NBD_FOREACH_REPLY_CHUNK(cs, iter, cookie, structured, \
                                 qiov, reply, payload) \
     for (iter = (NBDReplyChunkIter) { .only_structured = structured }; \
-         nbd_reply_chunk_iter_receive(s, &iter, cookie, qiov, reply, payload);)
+         nbd_reply_chunk_iter_receive(cs, &iter, cookie, qiov, reply, payload);)

 /*
  * nbd_reply_chunk_iter_receive
  * The pointer stored in @payload requires g_free() to free it.
  */
-static bool coroutine_fn nbd_reply_chunk_iter_receive(BDRVNBDState *s,
+static bool coroutine_fn nbd_reply_chunk_iter_receive(NBDConnState *cs,
                                                       NBDReplyChunkIter *iter,
                                                       uint64_t cookie,
                                                       QEMUIOVector *qiov,
@@ -1028,7 +1046,7 @@ static bool coroutine_fn nbd_reply_chunk_iter_receive(BDRVNBDState *s,
         reply = &local_reply;
     }

-    ret = nbd_co_receive_one_chunk(s, cookie, iter->only_structured,
+    ret = nbd_co_receive_one_chunk(cs, cookie, iter->only_structured,
                                    &request_ret, qiov, reply, payload,
                                    &local_err);
     if (ret < 0) {
@@ -1060,22 +1078,22 @@ static bool coroutine_fn nbd_reply_chunk_iter_receive(BDRVNBDState *s,
     return true;

 break_loop:
-    qemu_mutex_lock(&s->requests_lock);
-    s->requests[COOKIE_TO_INDEX(cookie)].coroutine = NULL;
-    s->in_flight--;
-    qemu_co_queue_next(&s->free_sema);
-    qemu_mutex_unlock(&s->requests_lock);
+    qemu_mutex_lock(&cs->requests_lock);
+    cs->requests[COOKIE_TO_INDEX(cookie)].coroutine = NULL;
+    cs->in_flight--;
+    qemu_co_queue_next(&cs->free_sema);
+    qemu_mutex_unlock(&cs->requests_lock);

     return false;
 }

 static int coroutine_fn
-nbd_co_receive_return_code(BDRVNBDState *s, uint64_t cookie,
+nbd_co_receive_return_code(NBDConnState *cs, uint64_t cookie,
                            int *request_ret, Error **errp)
 {
     NBDReplyChunkIter iter;

-    NBD_FOREACH_REPLY_CHUNK(s, iter, cookie, false, NULL, NULL, NULL) {
+    NBD_FOREACH_REPLY_CHUNK(cs, iter, cookie, false, NULL, NULL, NULL) {
         /* nbd_reply_chunk_iter_receive does all the work */
     }

@@ -1085,7 +1103,7 @@ nbd_co_receive_return_code(BDRVNBDState *s, uint64_t cookie,
 }

 static int coroutine_fn
-nbd_co_receive_cmdread_reply(BDRVNBDState *s, uint64_t cookie,
+nbd_co_receive_cmdread_reply(NBDConnState *cs, uint64_t cookie,
                              uint64_t offset, QEMUIOVector *qiov,
                              int *request_ret, Error **errp)
 {
@@ -1094,8 +1112,8 @@ nbd_co_receive_cmdread_reply(BDRVNBDState *s, uint64_t cookie,
     void *payload = NULL;
     Error *local_err = NULL;

-    NBD_FOREACH_REPLY_CHUNK(s, iter, cookie,
-                            s->info.mode >= NBD_MODE_STRUCTURED,
+    NBD_FOREACH_REPLY_CHUNK(cs, iter, cookie,
+                            cs->info.mode >= NBD_MODE_STRUCTURED,
                             qiov, &reply, &payload)
     {
         int ret;
@@ -1111,17 +1129,17 @@ nbd_co_receive_cmdread_reply(BDRVNBDState *s, uint64_t cookie,
              */
             break;
         case NBD_REPLY_TYPE_OFFSET_HOLE:
-            ret = nbd_parse_offset_hole_payload(s, &reply.structured, payload,
+            ret = nbd_parse_offset_hole_payload(cs, &reply.structured, payload,
                                                 offset, qiov, &local_err);
             if (ret < 0) {
-                nbd_channel_error(s, ret);
+                nbd_channel_error(cs, ret);
                 nbd_iter_channel_error(&iter, ret, &local_err);
             }
             break;
         default:
             if (!nbd_reply_type_is_error(chunk->type)) {
                 /* not allowed reply type */
-                nbd_channel_error(s, -EINVAL);
+                nbd_channel_error(cs, -EINVAL);
                 error_setg(&local_err,
                            "Unexpected reply type: %d (%s) for CMD_READ",
                            chunk->type, nbd_reply_type_lookup(chunk->type));
@@ -1139,7 +1157,7 @@ nbd_co_receive_cmdread_reply(BDRVNBDState *s, uint64_t cookie,
 }

 static int coroutine_fn
-nbd_co_receive_blockstatus_reply(BDRVNBDState *s, uint64_t cookie,
+nbd_co_receive_blockstatus_reply(NBDConnState *cs, uint64_t cookie,
                                  uint64_t length, NBDExtent64 *extent,
                                  int *request_ret, Error **errp)
 {
@@ -1150,7 +1168,7 @@ nbd_co_receive_blockstatus_reply(BDRVNBDState *s, uint64_t cookie,
     bool received = false;

     assert(!extent->length);
-    NBD_FOREACH_REPLY_CHUNK(s, iter, cookie, false, NULL, &reply, &payload) {
+    NBD_FOREACH_REPLY_CHUNK(cs, iter, cookie, false, NULL, &reply, &payload) {
         int ret;
         NBDStructuredReplyChunk *chunk = &reply.structured;
         bool wide;
@@ -1161,27 +1179,27 @@ nbd_co_receive_blockstatus_reply(BDRVNBDState *s, uint64_t cookie,
         case NBD_REPLY_TYPE_BLOCK_STATUS_EXT:
         case NBD_REPLY_TYPE_BLOCK_STATUS:
             wide = chunk->type == NBD_REPLY_TYPE_BLOCK_STATUS_EXT;
-            if ((s->info.mode >= NBD_MODE_EXTENDED) != wide) {
+            if ((cs->info.mode >= NBD_MODE_EXTENDED) != wide) {
                 trace_nbd_extended_headers_compliance("block_status");
             }
             if (received) {
-                nbd_channel_error(s, -EINVAL);
+                nbd_channel_error(cs, -EINVAL);
                 error_setg(&local_err, "Several BLOCK_STATUS chunks in reply");
                 nbd_iter_channel_error(&iter, -EINVAL, &local_err);
             }
             received = true;

             ret = nbd_parse_blockstatus_payload(
-                s, &reply.structured, payload, wide,
+                cs, &reply.structured, payload, wide,
                 length, extent, &local_err);
             if (ret < 0) {
-                nbd_channel_error(s, ret);
+                nbd_channel_error(cs, ret);
                 nbd_iter_channel_error(&iter, ret, &local_err);
             }
             break;
         default:
             if (!nbd_reply_type_is_error(chunk->type)) {
-                nbd_channel_error(s, -EINVAL);
+                nbd_channel_error(cs, -EINVAL);
                 error_setg(&local_err,
                            "Unexpected reply type: %d (%s) "
                            "for CMD_BLOCK_STATUS",
@@ -1205,12 +1223,11 @@ nbd_co_receive_blockstatus_reply(BDRVNBDState *s, uint64_t cookie,
 }

 static int coroutine_fn GRAPH_RDLOCK
-nbd_co_request(BlockDriverState *bs, NBDRequest *request,
+nbd_co_request(NBDConnState *cs, NBDRequest *request,
                QEMUIOVector *write_qiov)
 {
     int ret, request_ret;
     Error *local_err = NULL;
-    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;

     assert(request->type != NBD_CMD_READ);
     if (write_qiov) {
@@ -1221,12 +1238,12 @@ nbd_co_request(BlockDriverState *bs, NBDRequest *request,
     }

     do {
-        ret = nbd_co_send_request(bs, request, write_qiov);
+        ret = nbd_co_send_request(cs, request, write_qiov);
         if (ret < 0) {
             continue;
         }

-        ret = nbd_co_receive_return_code(s, request->cookie,
+        ret = nbd_co_receive_return_code(cs, request->cookie,
                                          &request_ret, &local_err);
         if (local_err) {
             trace_nbd_co_request_fail(request->from, request->len,
@@ -1237,7 +1254,7 @@ nbd_co_request(BlockDriverState *bs, NBDRequest *request,
             error_free(local_err);
             local_err = NULL;
         }
-    } while (ret < 0 && nbd_client_will_reconnect(s));
+    } while (ret < 0 && nbd_client_will_reconnect(cs));

     return ret ? ret : request_ret;
 }
@@ -1254,6 +1271,7 @@ nbd_client_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
         .from = offset,
         .len = bytes,
     };
+    NBDConnState * const cs = s->conns[0];

     assert(bytes <= NBD_MAX_BUFFER_SIZE);

@@ -1266,13 +1284,13 @@ nbd_client_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
      * advertised size because the block layer rounded size up, then
      * truncate the request to the server and tail-pad with zero.
      */
-    if (offset >= s->info.size) {
+    if (offset >= cs->info.size) {
         assert(bytes < BDRV_SECTOR_SIZE);
         qemu_iovec_memset(qiov, 0, 0, bytes);
         return 0;
     }
-    if (offset + bytes > s->info.size) {
-        uint64_t slop = offset + bytes - s->info.size;
+    if (offset + bytes > cs->info.size) {
+        uint64_t slop = offset + bytes - cs->info.size;

         assert(slop < BDRV_SECTOR_SIZE);
         qemu_iovec_memset(qiov, bytes - slop, 0, slop);
@@ -1280,12 +1298,12 @@ nbd_client_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
     }

     do {
-        ret = nbd_co_send_request(bs, &request, NULL);
+        ret = nbd_co_send_request(cs, &request, NULL);
         if (ret < 0) {
             continue;
         }

-        ret = nbd_co_receive_cmdread_reply(s, request.cookie, offset, qiov,
+        ret = nbd_co_receive_cmdread_reply(cs, request.cookie, offset, qiov,
                                            &request_ret, &local_err);
         if (local_err) {
             trace_nbd_co_request_fail(request.from, request.len, request.cookie,
@@ -1295,7 +1313,7 @@ nbd_client_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
             error_free(local_err);
             local_err = NULL;
         }
-    } while (ret < 0 && nbd_client_will_reconnect(s));
+    } while (ret < 0 && nbd_client_will_reconnect(cs));

     return ret ? ret : request_ret;
 }
@@ -1310,10 +1328,11 @@ nbd_client_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
         .from = offset,
         .len = bytes,
     };
+    NBDConnState * const cs = s->conns[0];

-    assert(!(s->info.flags & NBD_FLAG_READ_ONLY));
+    assert(!(cs->info.flags & NBD_FLAG_READ_ONLY));
     if (flags & BDRV_REQ_FUA) {
-        assert(s->info.flags & NBD_FLAG_SEND_FUA);
+        assert(cs->info.flags & NBD_FLAG_SEND_FUA);
         request.flags |= NBD_CMD_FLAG_FUA;
     }

@@ -1322,7 +1341,7 @@ nbd_client_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
     if (!bytes) {
         return 0;
     }
-    return nbd_co_request(bs, &request, qiov);
+    return nbd_co_request(cs, &request, qiov);
 }

 static int coroutine_fn GRAPH_RDLOCK
@@ -1335,46 +1354,48 @@ nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int64_t bytes,
         .from = offset,
         .len = bytes,
     };
+    NBDConnState * const cs = s->conns[0];

     /* rely on max_pwrite_zeroes */
-    assert(bytes <= UINT32_MAX || s->info.mode >= NBD_MODE_EXTENDED);
+    assert(bytes <= UINT32_MAX || cs->info.mode >= NBD_MODE_EXTENDED);

-    assert(!(s->info.flags & NBD_FLAG_READ_ONLY));
-    if (!(s->info.flags & NBD_FLAG_SEND_WRITE_ZEROES)) {
+    assert(!(cs->info.flags & NBD_FLAG_READ_ONLY));
+    if (!(cs->info.flags & NBD_FLAG_SEND_WRITE_ZEROES)) {
         return -ENOTSUP;
     }

     if (flags & BDRV_REQ_FUA) {
-        assert(s->info.flags & NBD_FLAG_SEND_FUA);
+        assert(cs->info.flags & NBD_FLAG_SEND_FUA);
         request.flags |= NBD_CMD_FLAG_FUA;
     }
     if (!(flags & BDRV_REQ_MAY_UNMAP)) {
         request.flags |= NBD_CMD_FLAG_NO_HOLE;
     }
     if (flags & BDRV_REQ_NO_FALLBACK) {
-        assert(s->info.flags & NBD_FLAG_SEND_FAST_ZERO);
+        assert(cs->info.flags & NBD_FLAG_SEND_FAST_ZERO);
         request.flags |= NBD_CMD_FLAG_FAST_ZERO;
     }

     if (!bytes) {
         return 0;
     }
-    return nbd_co_request(bs, &request, NULL);
+    return nbd_co_request(cs, &request, NULL);
 }

 static int coroutine_fn GRAPH_RDLOCK nbd_client_co_flush(BlockDriverState *bs)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     NBDRequest request = { .type = NBD_CMD_FLUSH };
+    NBDConnState * const cs = s->conns[0];

-    if (!(s->info.flags & NBD_FLAG_SEND_FLUSH)) {
+    if (!(cs->info.flags & NBD_FLAG_SEND_FLUSH)) {
         return 0;
     }

     request.from = 0;
     request.len = 0;

-    return nbd_co_request(bs, &request, NULL);
+    return nbd_co_request(cs, &request, NULL);
 }

 static int coroutine_fn GRAPH_RDLOCK
@@ -1386,16 +1407,17 @@ nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
         .from = offset,
         .len = bytes,
     };
+    NBDConnState * const cs = s->conns[0];

     /* rely on max_pdiscard */
-    assert(bytes <= UINT32_MAX || s->info.mode >= NBD_MODE_EXTENDED);
+    assert(bytes <= UINT32_MAX || cs->info.mode >= NBD_MODE_EXTENDED);

-    assert(!(s->info.flags & NBD_FLAG_READ_ONLY));
-    if (!(s->info.flags & NBD_FLAG_SEND_TRIM) || !bytes) {
+    assert(!(cs->info.flags & NBD_FLAG_READ_ONLY));
+    if (!(cs->info.flags & NBD_FLAG_SEND_TRIM) || !bytes) {
         return 0;
     }

-    return nbd_co_request(bs, &request, NULL);
+    return nbd_co_request(cs, &request, NULL);
 }

 static int coroutine_fn GRAPH_RDLOCK nbd_client_co_block_status(
@@ -1406,21 +1428,22 @@ static int coroutine_fn GRAPH_RDLOCK nbd_client_co_block_status(
     NBDExtent64 extent = { 0 };
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     Error *local_err = NULL;
+    NBDConnState * const cs = s->conns[0];

     NBDRequest request = {
         .type = NBD_CMD_BLOCK_STATUS,
         .from = offset,
-        .len = MIN(bytes, s->info.size - offset),
+        .len = MIN(bytes, cs->info.size - offset),
         .flags = NBD_CMD_FLAG_REQ_ONE,
     };

-    if (!s->info.base_allocation) {
+    if (!cs->info.base_allocation) {
         *pnum = bytes;
         *map = offset;
         *file = bs;
         return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
     }
-    if (s->info.mode < NBD_MODE_EXTENDED) {
+    if (cs->info.mode < NBD_MODE_EXTENDED) {
         request.len = MIN(QEMU_ALIGN_DOWN(INT_MAX, bs->bl.request_alignment),
                           request.len);
     }
@@ -1432,23 +1455,23 @@ static int coroutine_fn GRAPH_RDLOCK nbd_client_co_block_status(
      * up, we truncated the request to the server (above), or are
      * called on just the hole.
      */
-    if (offset >= s->info.size) {
+    if (offset >= cs->info.size) {
         *pnum = bytes;
         assert(bytes < BDRV_SECTOR_SIZE);
         /* Intentionally don't report offset_valid for the hole */
         return BDRV_BLOCK_ZERO;
     }

-    if (s->info.min_block) {
-        assert(QEMU_IS_ALIGNED(request.len, s->info.min_block));
+    if (cs->info.min_block) {
+        assert(QEMU_IS_ALIGNED(request.len, cs->info.min_block));
     }
     do {
-        ret = nbd_co_send_request(bs, &request, NULL);
+        ret = nbd_co_send_request(cs, &request, NULL);
         if (ret < 0) {
             continue;
         }

-        ret = nbd_co_receive_blockstatus_reply(s, request.cookie, bytes,
+        ret = nbd_co_receive_blockstatus_reply(cs, request.cookie, bytes,
                                                &extent, &request_ret,
                                                &local_err);
         if (local_err) {
@@ -1459,7 +1482,7 @@ static int coroutine_fn GRAPH_RDLOCK nbd_client_co_block_status(
             error_free(local_err);
             local_err = NULL;
         }
-    } while (ret < 0 && nbd_client_will_reconnect(s));
+    } while (ret < 0 && nbd_client_will_reconnect(cs));

     if (ret < 0 || request_ret < 0) {
         return ret ? ret : request_ret;
@@ -1478,8 +1501,10 @@ static int nbd_client_reopen_prepare(BDRVReopenState *state,
                                      BlockReopenQueue *queue, Error **errp)
 {
     BDRVNBDState *s = (BDRVNBDState *)state->bs->opaque;
+    NBDConnState * const cs = s->conns[0];

-    if ((state->flags & BDRV_O_RDWR) && (s->info.flags & NBD_FLAG_READ_ONLY)) {
+    if ((state->flags & BDRV_O_RDWR) &&
+        (cs->info.flags & NBD_FLAG_READ_ONLY)) {
         error_setg(errp, "Can't reopen read-only NBD mount as read/write");
         return -EACCES;
     }
@@ -1488,24 +1513,22 @@ static int nbd_client_reopen_prepare(BDRVReopenState *state,

 static void nbd_yank(void *opaque)
 {
-    BlockDriverState *bs = opaque;
-    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
+    NBDConnState *cs = opaque;

-    QEMU_LOCK_GUARD(&s->requests_lock);
-    qio_channel_shutdown(s->ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
-    s->state = NBD_CLIENT_QUIT;
+    QEMU_LOCK_GUARD(&cs->requests_lock);
+    qio_channel_shutdown(cs->ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
+    cs->state = NBD_CLIENT_QUIT;
 }

-static void nbd_client_close(BlockDriverState *bs)
+static void nbd_client_close(NBDConnState *cs)
 {
-    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
-    NBDRequest request = { .type = NBD_CMD_DISC, .mode = s->info.mode };
+    NBDRequest request = { .type = NBD_CMD_DISC, .mode = cs->info.mode };

-    if (s->ioc) {
-        nbd_send_request(s->ioc, &request);
+    if (cs->ioc) {
+        nbd_send_request(cs->ioc, &request);
     }

-    nbd_teardown_connection(bs);
+    nbd_teardown_connection(cs);
 }


@@ -1925,10 +1948,13 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;

     s->bs = bs;
-    qemu_mutex_init(&s->requests_lock);
-    qemu_co_queue_init(&s->free_sema);
-    qemu_co_mutex_init(&s->send_mutex);
-    qemu_co_mutex_init(&s->receive_mutex);
+
+    s->conns[0] = g_new0(NBDConnState, 1);
+    s->conns[0]->s = s;
+    qemu_mutex_init(&s->conns[0]->requests_lock);
+    qemu_co_queue_init(&s->conns[0]->free_sema);
+    qemu_co_mutex_init(&s->conns[0]->send_mutex);
+    qemu_co_mutex_init(&s->conns[0]->receive_mutex);

     if (!yank_register_instance(BLOCKDEV_YANK_INSTANCE(bs->node_name), errp)) {
         return -EEXIST;
@@ -1939,18 +1965,19 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }

-    s->conn = nbd_client_connection_new(s->saddr, true, s->export,
-                                        s->x_dirty_bitmap, s->tlscreds,
-                                        s->tlshostname);
+    s->conns[0]->conn =
+        nbd_client_connection_new(s->saddr, true, s->export,
+                                  s->x_dirty_bitmap, s->tlscreds,
+                                  s->tlshostname);

     if (s->open_timeout) {
-        nbd_client_connection_enable_retry(s->conn);
-        open_timer_init(s, qemu_clock_get_ns(QEMU_CLOCK_REALTIME) +
+        nbd_client_connection_enable_retry(s->conns[0]->conn);
+        open_timer_init(s->conns[0], qemu_clock_get_ns(QEMU_CLOCK_REALTIME) +
                         s->open_timeout * NANOSECONDS_PER_SECOND);
     }

-    s->state = NBD_CLIENT_CONNECTING_WAIT;
-    ret = nbd_do_establish_connection(bs, true, errp);
+    s->conns[0]->state = NBD_CLIENT_CONNECTING_WAIT;
+    ret = nbd_do_establish_connection(bs, s->conns[0], true, errp);
     if (ret < 0) {
         goto fail;
     }
@@ -1960,23 +1987,23 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
      * Delete it, because we do not want it to be around when this node
      * is drained or closed.
      */
-    open_timer_del(s);
+    open_timer_del(s->conns[0]);

-    nbd_client_connection_enable_retry(s->conn);
+    nbd_client_connection_enable_retry(s->conns[0]->conn);

     /*
      * We set s->multi_conn in nbd_process_options above, but now that
      * we have connected if the server doesn't advertise that it is
      * safe for multi-conn, force it to 1.
      */
-    if (!(s->info.flags & NBD_FLAG_CAN_MULTI_CONN)) {
+    if (!(s->conns[0]->info.flags & NBD_FLAG_CAN_MULTI_CONN)) {
         s->multi_conn = 1;
     }

     return 0;

 fail:
-    open_timer_del(s);
+    open_timer_del(s->conns[0]);
     nbd_clear_bdrvstate(bs);
     return ret;
 }
@@ -1984,8 +2011,9 @@ fail:
 static void nbd_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
-    uint32_t min = s->info.min_block;
-    uint32_t max = MIN_NON_ZERO(NBD_MAX_BUFFER_SIZE, s->info.max_block);
+    NBDConnState * const cs = s->conns[0];
+    uint32_t min = cs->info.min_block;
+    uint32_t max = MIN_NON_ZERO(NBD_MAX_BUFFER_SIZE, cs->info.max_block);

     /*
      * If the server did not advertise an alignment:
@@ -2000,8 +2028,8 @@ static void nbd_refresh_limits(BlockDriverState *bs, Error **errp)
      *   sub-sector requests
      */
     if (!min) {
-        min = (!QEMU_IS_ALIGNED(s->info.size, BDRV_SECTOR_SIZE) ||
-               s->info.base_allocation) ? 1 : BDRV_SECTOR_SIZE;
+        min = (!QEMU_IS_ALIGNED(cs->info.size, BDRV_SECTOR_SIZE) ||
+               cs->info.base_allocation) ? 1 : BDRV_SECTOR_SIZE;
     }

     bs->bl.request_alignment = min;
@@ -2013,19 +2041,21 @@ static void nbd_refresh_limits(BlockDriverState *bs, Error **errp)
      * Assume that if the server supports extended headers, it also
      * supports unlimited size zero and trim commands.
      */
-    if (s->info.mode >= NBD_MODE_EXTENDED) {
+    if (cs->info.mode >= NBD_MODE_EXTENDED) {
         bs->bl.max_pdiscard = bs->bl.max_pwrite_zeroes = 0;
     }

-    if (s->info.opt_block &&
-        s->info.opt_block > bs->bl.opt_transfer) {
-        bs->bl.opt_transfer = s->info.opt_block;
+    if (cs->info.opt_block &&
+        cs->info.opt_block > bs->bl.opt_transfer) {
+        bs->bl.opt_transfer = cs->info.opt_block;
     }
 }

 static void nbd_close(BlockDriverState *bs)
 {
-    nbd_client_close(bs);
+    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
+
+    nbd_client_close(s->conns[0]);
     nbd_clear_bdrvstate(bs);
 }

@@ -2042,13 +2072,14 @@ static int coroutine_fn nbd_co_truncate(BlockDriverState *bs, int64_t offset,
                                         BdrvRequestFlags flags, Error **errp)
 {
     BDRVNBDState *s = bs->opaque;
+    NBDConnState * const cs = s->conns[0];

-    if (offset != s->info.size && exact) {
+    if (offset != cs->info.size && exact) {
         error_setg(errp, "Cannot resize NBD nodes");
         return -ENOTSUP;
     }

-    if (offset > s->info.size) {
+    if (offset > cs->info.size) {
         error_setg(errp, "Cannot grow NBD nodes");
         return -EINVAL;
     }
@@ -2059,8 +2090,9 @@ static int coroutine_fn nbd_co_truncate(BlockDriverState *bs, int64_t offset,
 static int64_t coroutine_fn nbd_co_getlength(BlockDriverState *bs)
 {
     BDRVNBDState *s = bs->opaque;
+    NBDConnState * const cs = s->conns[0];

-    return s->info.size;
+    return cs->info.size;
 }

 static void nbd_refresh_filename(BlockDriverState *bs)
@@ -2123,25 +2155,27 @@ static const char *const nbd_strong_runtime_opts[] = {
 static void nbd_cancel_in_flight(BlockDriverState *bs)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
+    NBDConnState * const cs = s->conns[0];

-    reconnect_delay_timer_del(s);
+    reconnect_delay_timer_del(cs);

-    qemu_mutex_lock(&s->requests_lock);
-    if (s->state == NBD_CLIENT_CONNECTING_WAIT) {
-        s->state = NBD_CLIENT_CONNECTING_NOWAIT;
+    qemu_mutex_lock(&cs->requests_lock);
+    if (cs->state == NBD_CLIENT_CONNECTING_WAIT) {
+        cs->state = NBD_CLIENT_CONNECTING_NOWAIT;
     }
-    qemu_mutex_unlock(&s->requests_lock);
+    qemu_mutex_unlock(&cs->requests_lock);

-    nbd_co_establish_connection_cancel(s->conn);
+    nbd_co_establish_connection_cancel(cs->conn);
 }

 static void nbd_attach_aio_context(BlockDriverState *bs,
                                    AioContext *new_context)
 {
     BDRVNBDState *s = bs->opaque;
+    NBDConnState * const cs = s->conns[0];

     /* The open_timer is used only during nbd_open() */
-    assert(!s->open_timer);
+    assert(!cs->open_timer);

     /*
      * The reconnect_delay_timer is scheduled in I/O paths when the
@@ -2152,15 +2186,16 @@ static void nbd_attach_aio_context(BlockDriverState *bs,
      * Since the AioContext can only be changed when a node is drained,
      * the reconnect_delay_timer cannot be active here.
      */
-    assert(!s->reconnect_delay_timer);
+    assert(!cs->reconnect_delay_timer);
 }

 static void nbd_detach_aio_context(BlockDriverState *bs)
 {
     BDRVNBDState *s = bs->opaque;
+    NBDConnState * const cs = s->conns[0];

-    assert(!s->open_timer);
-    assert(!s->reconnect_delay_timer);
+    assert(!cs->open_timer);
+    assert(!cs->reconnect_delay_timer);
 }

 static BlockDriver bdrv_nbd = {
-- 
2.49.0


