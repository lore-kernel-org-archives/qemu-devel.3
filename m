Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09B1CD129A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSLG-0005kc-08; Wed, 10 Apr 2024 03:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSKn-0005Gx-Fr; Wed, 10 Apr 2024 03:25:33 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSKh-0004VL-B0; Wed, 10 Apr 2024 03:25:28 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6F22C5D68B;
 Wed, 10 Apr 2024 10:25:04 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 130B7B02CC;
 Wed, 10 Apr 2024 10:23:06 +0300 (MSK)
Received: (nullmailer pid 4191730 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 28/87] nbd/server: only traverse NBDExport->clients
 from main loop thread
Date: Wed, 10 Apr 2024 10:22:01 +0300
Message-Id: <20240410072303.4191455-28-mjt@tls.msk.ru>
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

The NBD clients list is currently accessed from both the export
AioContext and the main loop thread. When the AioContext lock is removed
there will be nothing protecting the clients list.

Adding a lock around the clients list is tricky because NBDClient
structs are refcounted and may be freed from the export AioContext or
the main loop thread. nbd_export_request_shutdown() -> client_close() ->
nbd_client_put() is also tricky because the list lock would be held
while indirectly dropping references to NDBClients.

A simpler approach is to only allow nbd_client_put() and client_close()
calls from the main loop thread. Then the NBD clients list is only
accessed from the main loop thread and no fancy locking is needed.

nbd_trip() just needs to reschedule itself in the main loop AioContext
before calling nbd_client_put() and client_close(). This costs more CPU
cycles per NBD request so add nbd_client_put_nonzero() to optimize the
common case where more references to NBDClient remain.

Note that nbd_client_get() can still be called from either thread, so
make NBDClient->refcount atomic.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20231221192452.1785567-6-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit f816310d0c32c8482e56807ea0f9faa8d1b5f696)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/nbd/server.c b/nbd/server.c
index 895cf0a752..65ec99fa92 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -122,7 +122,7 @@ struct NBDMetaContexts {
 };
 
 struct NBDClient {
-    int refcount;
+    int refcount; /* atomic */
     void (*close_fn)(NBDClient *client, bool negotiated);
 
     NBDExport *exp;
@@ -1501,14 +1501,17 @@ static int coroutine_fn nbd_receive_request(NBDClient *client, NBDRequest *reque
 
 #define MAX_NBD_REQUESTS 16
 
+/* Runs in export AioContext and main loop thread */
 void nbd_client_get(NBDClient *client)
 {
-    client->refcount++;
+    qatomic_inc(&client->refcount);
 }
 
 void nbd_client_put(NBDClient *client)
 {
-    if (--client->refcount == 0) {
+    assert(qemu_in_main_thread());
+
+    if (qatomic_fetch_dec(&client->refcount) == 1) {
         /* The last reference should be dropped by client->close,
          * which is called by client_close.
          */
@@ -1529,8 +1532,35 @@ void nbd_client_put(NBDClient *client)
     }
 }
 
+/*
+ * Tries to release the reference to @client, but only if other references
+ * remain. This is an optimization for the common case where we want to avoid
+ * the expense of scheduling nbd_client_put() in the main loop thread.
+ *
+ * Returns true upon success or false if the reference was not released because
+ * it is the last reference.
+ */
+static bool nbd_client_put_nonzero(NBDClient *client)
+{
+    int old = qatomic_read(&client->refcount);
+    int expected;
+
+    do {
+        if (old == 1) {
+            return false;
+        }
+
+        expected = old;
+        old = qatomic_cmpxchg(&client->refcount, expected, expected - 1);
+    } while (old != expected);
+
+    return true;
+}
+
 static void client_close(NBDClient *client, bool negotiated)
 {
+    assert(qemu_in_main_thread());
+
     if (client->closing) {
         return;
     }
@@ -2936,15 +2966,20 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
 static coroutine_fn void nbd_trip(void *opaque)
 {
     NBDClient *client = opaque;
-    NBDRequestData *req;
+    NBDRequestData *req = NULL;
     NBDRequest request = { 0 };    /* GCC thinks it can be used uninitialized */
     int ret;
     Error *local_err = NULL;
 
+    /*
+     * Note that nbd_client_put() and client_close() must be called from the
+     * main loop thread. Use aio_co_reschedule_self() to switch AioContext
+     * before calling these functions.
+     */
+
     trace_nbd_trip();
     if (client->closing) {
-        nbd_client_put(client);
-        return;
+        goto done;
     }
 
     if (client->quiescing) {
@@ -2952,10 +2987,9 @@ static coroutine_fn void nbd_trip(void *opaque)
          * We're switching between AIO contexts. Don't attempt to receive a new
          * request and kick the main context which may be waiting for us.
          */
-        nbd_client_put(client);
         client->recv_coroutine = NULL;
         aio_wait_kick();
-        return;
+        goto done;
     }
 
     req = nbd_request_get(client);
@@ -3015,8 +3049,13 @@ static coroutine_fn void nbd_trip(void *opaque)
 
     qio_channel_set_cork(client->ioc, false);
 done:
-    nbd_request_put(req);
-    nbd_client_put(client);
+    if (req) {
+        nbd_request_put(req);
+    }
+    if (!nbd_client_put_nonzero(client)) {
+        aio_co_reschedule_self(qemu_get_aio_context());
+        nbd_client_put(client);
+    }
     return;
 
 disconnect:
@@ -3024,6 +3063,8 @@ disconnect:
         error_reportf_err(local_err, "Disconnect client, due to: ");
     }
     nbd_request_put(req);
+
+    aio_co_reschedule_self(qemu_get_aio_context());
     client_close(client, true);
     nbd_client_put(client);
 }
-- 
2.39.2


