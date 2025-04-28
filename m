Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3773AC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 18:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9TbQ-0003Bx-44; Mon, 28 Apr 2025 14:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u9TbH-00036a-7w
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 14:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u9TbC-0002qK-Ou
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 14:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745866381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=714m1FGgEYSaIEoqInWp3kt74djm4hxza+A2P2/Ao2A=;
 b=UQs40r13qTPvRL7nrkdogfHBykHqarnAiHT8ms8EoUZUAF8d8hDNJQft9NfxNRXKVZgOoL
 F7WZ+gCszK7dvM6h52NAO8+JiNCKtFmnnt4pQkKH6hXpcA7xyZfBfAljBgWEF6foTFV85E
 LC6Bnq/pJZk0qyHbYQ8HTc/SNeyKHMw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-DnuB61xOO3yyxSNFiNhkwg-1; Mon,
 28 Apr 2025 14:52:58 -0400
X-MC-Unique: DnuB61xOO3yyxSNFiNhkwg-1
X-Mimecast-MFC-AGG-ID: DnuB61xOO3yyxSNFiNhkwg_1745866377
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4039719560B2; Mon, 28 Apr 2025 18:52:57 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.31])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6FC09180047F; Mon, 28 Apr 2025 18:52:54 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v2 3/4] nbd: Open multiple NBD connections if multi-conn is set
Date: Mon, 28 Apr 2025 13:46:46 -0500
Message-ID: <20250428185246.492388-9-eblake@redhat.com>
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

If the user opts in to multi-conn and the server advertises it, open
multiple NBD connections.  They are opened with the same parameters as
the initial connection.  Similarly on the close path the connections
are closed.

However only the zeroth connection is used, so this commit does not
actually enable multi-conn capabilities.

(XXX) The strategy here is very naive.  Firstly if you were going to
open them, you'd probably want to open them in parallel.  Secondly it
would make sense to delay opening until multiple parallel requests are
seen (perhaps above some threshold), so that simple or shortlived NBD
operations do not require multiple connections to be made.

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 block/nbd.c | 128 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 90 insertions(+), 38 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 4690599bc61..19da1a7a1fe 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -123,18 +123,23 @@ static void nbd_yank(void *opaque);
 static void nbd_clear_bdrvstate(BlockDriverState *bs)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
+    size_t i;

-    nbd_client_connection_release(s->conns[0]->conn);
-    s->conns[0]->conn = NULL;
+    for (i = 0; i < MAX_MULTI_CONN; ++i) {
+        if (s->conns[i]) {
+            nbd_client_connection_release(s->conns[i]->conn);
+            s->conns[i]->conn = NULL;
+
+            /* Must not leave timers behind that would access freed data */
+            assert(!s->conns[i]->reconnect_delay_timer);
+            assert(!s->conns[i]->open_timer);
+
+            g_free(s->conns[i]);
+        }
+    }

     yank_unregister_instance(BLOCKDEV_YANK_INSTANCE(bs->node_name));

-    /* Must not leave timers behind that would access freed data */
-    assert(!s->conns[0]->reconnect_delay_timer);
-    assert(!s->conns[0]->open_timer);
-
-    g_free(s->conns[0]);
-
     object_unref(OBJECT(s->tlscreds));
     qapi_free_SocketAddress(s->saddr);
     s->saddr = NULL;
@@ -1941,21 +1946,68 @@ static int nbd_process_options(BlockDriverState *bs, QDict *options,
     return ret;
 }

+static NBDConnState *init_conn_state(BDRVNBDState *s)
+{
+    NBDConnState *cs;
+
+    cs = g_new0(NBDConnState, 1);
+    cs->s = s;
+    qemu_mutex_init(&cs->requests_lock);
+    qemu_co_queue_init(&cs->free_sema);
+    qemu_co_mutex_init(&cs->send_mutex);
+    qemu_co_mutex_init(&cs->receive_mutex);
+
+    return cs;
+}
+
+static int conn_state_connect(BlockDriverState *bs, NBDConnState *cs,
+                              Error **errp)
+{
+    BDRVNBDState *s = cs->s;
+    int ret;
+
+    cs->conn =
+        nbd_client_connection_new(s->saddr, true, s->export,
+                                  s->x_dirty_bitmap, s->tlscreds,
+                                  s->tlshostname);
+
+    if (s->open_timeout) {
+        nbd_client_connection_enable_retry(cs->conn);
+        open_timer_init(cs, qemu_clock_get_ns(QEMU_CLOCK_REALTIME) +
+                        s->open_timeout * NANOSECONDS_PER_SECOND);
+    }
+
+    cs->state = NBD_CLIENT_CONNECTING_WAIT;
+    ret = nbd_do_establish_connection(bs, cs, true, errp);
+    if (ret < 0) {
+        goto fail;
+    }
+
+    /*
+     * The connect attempt is done, so we no longer need this timer.
+     * Delete it, because we do not want it to be around when this node
+     * is drained or closed.
+     */
+    open_timer_del(cs);
+
+    nbd_client_connection_enable_retry(cs->conn);
+
+    return 0;
+
+fail:
+    open_timer_del(cs);
+    return ret;
+}
+
 static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
                     Error **errp)
 {
     int ret;
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
+    size_t i;

     s->bs = bs;

-    s->conns[0] = g_new0(NBDConnState, 1);
-    s->conns[0]->s = s;
-    qemu_mutex_init(&s->conns[0]->requests_lock);
-    qemu_co_queue_init(&s->conns[0]->free_sema);
-    qemu_co_mutex_init(&s->conns[0]->send_mutex);
-    qemu_co_mutex_init(&s->conns[0]->receive_mutex);
-
     if (!yank_register_instance(BLOCKDEV_YANK_INSTANCE(bs->node_name), errp)) {
         return -EEXIST;
     }
@@ -1965,32 +2017,16 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }

-    s->conns[0]->conn =
-        nbd_client_connection_new(s->saddr, true, s->export,
-                                  s->x_dirty_bitmap, s->tlscreds,
-                                  s->tlshostname);
+    /*
+     * Open the first NBD connection.
+     */
+    s->conns[0] = init_conn_state(s);

-    if (s->open_timeout) {
-        nbd_client_connection_enable_retry(s->conns[0]->conn);
-        open_timer_init(s->conns[0], qemu_clock_get_ns(QEMU_CLOCK_REALTIME) +
-                        s->open_timeout * NANOSECONDS_PER_SECOND);
-    }
-
-    s->conns[0]->state = NBD_CLIENT_CONNECTING_WAIT;
-    ret = nbd_do_establish_connection(bs, s->conns[0], true, errp);
+    ret = conn_state_connect(bs, s->conns[0], errp);
     if (ret < 0) {
         goto fail;
     }

-    /*
-     * The connect attempt is done, so we no longer need this timer.
-     * Delete it, because we do not want it to be around when this node
-     * is drained or closed.
-     */
-    open_timer_del(s->conns[0]);
-
-    nbd_client_connection_enable_retry(s->conns[0]->conn);
-
     /*
      * We set s->multi_conn in nbd_process_options above, but now that
      * we have connected if the server doesn't advertise that it is
@@ -2000,10 +2036,21 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
         s->multi_conn = 1;
     }

+    /*
+     * Open remaining multi-conn NBD connections (if any).
+     */
+    for (i = 1; i < s->multi_conn; ++i) {
+        s->conns[i] = init_conn_state(s);
+
+        ret = conn_state_connect(bs, s->conns[i], errp);
+        if (ret < 0) {
+            goto fail;
+        }
+    }
+
     return 0;

 fail:
-    open_timer_del(s->conns[0]);
     nbd_clear_bdrvstate(bs);
     return ret;
 }
@@ -2054,8 +2101,13 @@ static void nbd_refresh_limits(BlockDriverState *bs, Error **errp)
 static void nbd_close(BlockDriverState *bs)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
+    size_t i;

-    nbd_client_close(s->conns[0]);
+    for (i = 0; i < MAX_MULTI_CONN; ++i) {
+        if (s->conns[i]) {
+            nbd_client_close(s->conns[i]);
+        }
+    }
     nbd_clear_bdrvstate(bs);
 }

-- 
2.49.0


