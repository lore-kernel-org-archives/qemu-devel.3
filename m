Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160D9CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSM0-0008CA-KB; Wed, 10 Apr 2024 03:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSKs-0005KD-Ji; Wed, 10 Apr 2024 03:25:35 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSKq-0004W7-Al; Wed, 10 Apr 2024 03:25:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8052D5D68C;
 Wed, 10 Apr 2024 10:25:04 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 24017B02CD;
 Wed, 10 Apr 2024 10:23:06 +0300 (MSK)
Received: (nullmailer pid 4191734 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 29/87] nbd/server: introduce NBDClient->lock to protect
 fields
Date: Wed, 10 Apr 2024 10:22:02 +0300
Message-Id: <20240410072303.4191455-29-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

NBDClient has a number of fields that are accessed by both the export
AioContext and the main loop thread. When the AioContext lock is removed
these fields will need another form of protection.

Add NBDClient->lock and protect fields that are accessed by both
threads. Also add assertions where possible and otherwise add doc
comments stating assumptions about which thread and lock holding.

Note this patch moves the client->recv_coroutine assertion from
nbd_co_receive_request() to nbd_trip() where client->lock is held.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20231221192452.1785567-7-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 7075d235114b40b30524cf1c5b61906c0bbf5f4d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/nbd/server.c b/nbd/server.c
index 65ec99fa92..f8738f6d27 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -125,23 +125,25 @@ struct NBDClient {
     int refcount; /* atomic */
     void (*close_fn)(NBDClient *client, bool negotiated);
 
+    QemuMutex lock;
+
     NBDExport *exp;
     QCryptoTLSCreds *tlscreds;
     char *tlsauthz;
     QIOChannelSocket *sioc; /* The underlying data channel */
     QIOChannel *ioc; /* The current I/O channel which may differ (eg TLS) */
 
-    Coroutine *recv_coroutine;
+    Coroutine *recv_coroutine; /* protected by lock */
 
     CoMutex send_lock;
     Coroutine *send_coroutine;
 
-    bool read_yielding;
-    bool quiescing;
+    bool read_yielding; /* protected by lock */
+    bool quiescing; /* protected by lock */
 
     QTAILQ_ENTRY(NBDClient) next;
-    int nb_requests;
-    bool closing;
+    int nb_requests; /* protected by lock */
+    bool closing; /* protected by lock */
 
     uint32_t check_align; /* If non-zero, check for aligned client requests */
 
@@ -1415,11 +1417,18 @@ nbd_read_eof(NBDClient *client, void *buffer, size_t size, Error **errp)
 
         len = qio_channel_readv(client->ioc, &iov, 1, errp);
         if (len == QIO_CHANNEL_ERR_BLOCK) {
-            client->read_yielding = true;
+            WITH_QEMU_LOCK_GUARD(&client->lock) {
+                client->read_yielding = true;
+
+                /* Prompt main loop thread to re-run nbd_drained_poll() */
+                aio_wait_kick();
+            }
             qio_channel_yield(client->ioc, G_IO_IN);
-            client->read_yielding = false;
-            if (client->quiescing) {
-                return -EAGAIN;
+            WITH_QEMU_LOCK_GUARD(&client->lock) {
+                client->read_yielding = false;
+                if (client->quiescing) {
+                    return -EAGAIN;
+                }
             }
             continue;
         } else if (len < 0) {
@@ -1528,6 +1537,7 @@ void nbd_client_put(NBDClient *client)
             blk_exp_unref(&client->exp->common);
         }
         g_free(client->contexts.bitmaps);
+        qemu_mutex_destroy(&client->lock);
         g_free(client);
     }
 }
@@ -1561,11 +1571,13 @@ static void client_close(NBDClient *client, bool negotiated)
 {
     assert(qemu_in_main_thread());
 
-    if (client->closing) {
-        return;
-    }
+    WITH_QEMU_LOCK_GUARD(&client->lock) {
+        if (client->closing) {
+            return;
+        }
 
-    client->closing = true;
+        client->closing = true;
+    }
 
     /* Force requests to finish.  They will drop their own references,
      * then we'll close the socket and free the NBDClient.
@@ -1579,6 +1591,7 @@ static void client_close(NBDClient *client, bool negotiated)
     }
 }
 
+/* Runs in export AioContext with client->lock held */
 static NBDRequestData *nbd_request_get(NBDClient *client)
 {
     NBDRequestData *req;
@@ -1592,6 +1605,7 @@ static NBDRequestData *nbd_request_get(NBDClient *client)
     return req;
 }
 
+/* Runs in export AioContext with client->lock held */
 static void nbd_request_put(NBDRequestData *req)
 {
     NBDClient *client = req->client;
@@ -1617,14 +1631,18 @@ static void blk_aio_attached(AioContext *ctx, void *opaque)
     NBDExport *exp = opaque;
     NBDClient *client;
 
+    assert(qemu_in_main_thread());
+
     trace_nbd_blk_aio_attached(exp->name, ctx);
 
     exp->common.ctx = ctx;
 
     QTAILQ_FOREACH(client, &exp->clients, next) {
-        assert(client->nb_requests == 0);
-        assert(client->recv_coroutine == NULL);
-        assert(client->send_coroutine == NULL);
+        WITH_QEMU_LOCK_GUARD(&client->lock) {
+            assert(client->nb_requests == 0);
+            assert(client->recv_coroutine == NULL);
+            assert(client->send_coroutine == NULL);
+        }
     }
 }
 
@@ -1632,6 +1650,8 @@ static void blk_aio_detach(void *opaque)
 {
     NBDExport *exp = opaque;
 
+    assert(qemu_in_main_thread());
+
     trace_nbd_blk_aio_detach(exp->name, exp->common.ctx);
 
     exp->common.ctx = NULL;
@@ -1642,8 +1662,12 @@ static void nbd_drained_begin(void *opaque)
     NBDExport *exp = opaque;
     NBDClient *client;
 
+    assert(qemu_in_main_thread());
+
     QTAILQ_FOREACH(client, &exp->clients, next) {
-        client->quiescing = true;
+        WITH_QEMU_LOCK_GUARD(&client->lock) {
+            client->quiescing = true;
+        }
     }
 }
 
@@ -1652,28 +1676,48 @@ static void nbd_drained_end(void *opaque)
     NBDExport *exp = opaque;
     NBDClient *client;
 
+    assert(qemu_in_main_thread());
+
     QTAILQ_FOREACH(client, &exp->clients, next) {
-        client->quiescing = false;
-        nbd_client_receive_next_request(client);
+        WITH_QEMU_LOCK_GUARD(&client->lock) {
+            client->quiescing = false;
+            nbd_client_receive_next_request(client);
+        }
     }
 }
 
+/* Runs in export AioContext */
+static void nbd_wake_read_bh(void *opaque)
+{
+    NBDClient *client = opaque;
+    qio_channel_wake_read(client->ioc);
+}
+
 static bool nbd_drained_poll(void *opaque)
 {
     NBDExport *exp = opaque;
     NBDClient *client;
 
+    assert(qemu_in_main_thread());
+
     QTAILQ_FOREACH(client, &exp->clients, next) {
-        if (client->nb_requests != 0) {
-            /*
-             * If there's a coroutine waiting for a request on nbd_read_eof()
-             * enter it here so we don't depend on the client to wake it up.
-             */
-            if (client->recv_coroutine != NULL && client->read_yielding) {
-                qio_channel_wake_read(client->ioc);
-            }
+        WITH_QEMU_LOCK_GUARD(&client->lock) {
+            if (client->nb_requests != 0) {
+                /*
+                 * If there's a coroutine waiting for a request on nbd_read_eof()
+                 * enter it here so we don't depend on the client to wake it up.
+                 *
+                 * Schedule a BH in the export AioContext to avoid missing the
+                 * wake up due to the race between qio_channel_wake_read() and
+                 * qio_channel_yield().
+                 */
+                if (client->recv_coroutine != NULL && client->read_yielding) {
+                    aio_bh_schedule_oneshot(nbd_export_aio_context(client->exp),
+                                            nbd_wake_read_bh, client);
+                }
 
-            return true;
+                return true;
+            }
         }
     }
 
@@ -1684,6 +1728,8 @@ static void nbd_eject_notifier(Notifier *n, void *data)
 {
     NBDExport *exp = container_of(n, NBDExport, eject_notifier);
 
+    assert(qemu_in_main_thread());
+
     blk_exp_request_shutdown(&exp->common);
 }
 
@@ -2569,7 +2615,6 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
     int ret;
 
     g_assert(qemu_in_coroutine());
-    assert(client->recv_coroutine == qemu_coroutine_self());
     ret = nbd_receive_request(client, request, errp);
     if (ret < 0) {
         return ret;
@@ -2978,6 +3023,9 @@ static coroutine_fn void nbd_trip(void *opaque)
      */
 
     trace_nbd_trip();
+
+    qemu_mutex_lock(&client->lock);
+
     if (client->closing) {
         goto done;
     }
@@ -2993,7 +3041,21 @@ static coroutine_fn void nbd_trip(void *opaque)
     }
 
     req = nbd_request_get(client);
-    ret = nbd_co_receive_request(req, &request, &local_err);
+
+    /*
+     * nbd_co_receive_request() returns -EAGAIN when nbd_drained_begin() has
+     * set client->quiescing but by the time we get back nbd_drained_end() may
+     * have already cleared client->quiescing. In that case we try again
+     * because nothing else will spawn an nbd_trip() coroutine until we set
+     * client->recv_coroutine = NULL further down.
+     */
+    do {
+        assert(client->recv_coroutine == qemu_coroutine_self());
+        qemu_mutex_unlock(&client->lock);
+        ret = nbd_co_receive_request(req, &request, &local_err);
+        qemu_mutex_lock(&client->lock);
+    } while (ret == -EAGAIN && !client->quiescing);
+
     client->recv_coroutine = NULL;
 
     if (client->closing) {
@@ -3005,15 +3067,16 @@ static coroutine_fn void nbd_trip(void *opaque)
     }
 
     if (ret == -EAGAIN) {
-        assert(client->quiescing);
         goto done;
     }
 
     nbd_client_receive_next_request(client);
+
     if (ret == -EIO) {
         goto disconnect;
     }
 
+    qemu_mutex_unlock(&client->lock);
     qio_channel_set_cork(client->ioc, true);
 
     if (ret < 0) {
@@ -3033,6 +3096,10 @@ static coroutine_fn void nbd_trip(void *opaque)
         g_free(request.contexts->bitmaps);
         g_free(request.contexts);
     }
+
+    qio_channel_set_cork(client->ioc, false);
+    qemu_mutex_lock(&client->lock);
+
     if (ret < 0) {
         error_prepend(&local_err, "Failed to send reply: ");
         goto disconnect;
@@ -3047,11 +3114,13 @@ static coroutine_fn void nbd_trip(void *opaque)
         goto disconnect;
     }
 
-    qio_channel_set_cork(client->ioc, false);
 done:
     if (req) {
         nbd_request_put(req);
     }
+
+    qemu_mutex_unlock(&client->lock);
+
     if (!nbd_client_put_nonzero(client)) {
         aio_co_reschedule_self(qemu_get_aio_context());
         nbd_client_put(client);
@@ -3062,13 +3131,19 @@ disconnect:
     if (local_err) {
         error_reportf_err(local_err, "Disconnect client, due to: ");
     }
+
     nbd_request_put(req);
+    qemu_mutex_unlock(&client->lock);
 
     aio_co_reschedule_self(qemu_get_aio_context());
     client_close(client, true);
     nbd_client_put(client);
 }
 
+/*
+ * Runs in export AioContext and main loop thread. Caller must hold
+ * client->lock.
+ */
 static void nbd_client_receive_next_request(NBDClient *client)
 {
     if (!client->recv_coroutine && client->nb_requests < MAX_NBD_REQUESTS &&
@@ -3094,7 +3169,9 @@ static coroutine_fn void nbd_co_client_start(void *opaque)
         return;
     }
 
-    nbd_client_receive_next_request(client);
+    WITH_QEMU_LOCK_GUARD(&client->lock) {
+        nbd_client_receive_next_request(client);
+    }
 }
 
 /*
@@ -3111,6 +3188,7 @@ void nbd_client_new(QIOChannelSocket *sioc,
     Coroutine *co;
 
     client = g_new0(NBDClient, 1);
+    qemu_mutex_init(&client->lock);
     client->refcount = 1;
     client->tlscreds = tlscreds;
     if (tlscreds) {
-- 
2.39.2


