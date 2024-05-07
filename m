Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDD6C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 08:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4GPf-0003p9-85; Tue, 07 May 2024 04:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s4GPV-0003Wr-73; Tue, 07 May 2024 04:42:53 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s4GPR-0003Ej-29; Tue, 07 May 2024 04:42:52 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DE21564BCA;
 Tue,  7 May 2024 11:42:48 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id CB534C85B3;
 Tue,  7 May 2024 11:42:29 +0300 (MSK)
Received: (nullmailer pid 1026530 invoked by uid 1000);
 Tue, 07 May 2024 08:42:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zhu Yangyang <zhuyangyang14@huawei.com>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.4 06/16] nbd/server: do not poll within a coroutine
 context
Date: Tue,  7 May 2024 11:42:05 +0300
Message-Id: <20240507084226.1026455-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.4-20240506205855@cover.tls.msk.ru>
References: <qemu-stable-8.2.4-20240506205855@cover.tls.msk.ru>
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

From: Zhu Yangyang <zhuyangyang14@huawei.com>

Coroutines are not supposed to block. Instead, they should yield.

The client performs TLS upgrade outside of an AIOContext, during
synchronous handshake; this still requires g_main_loop.  But the
server responds to TLS upgrade inside a coroutine, so a nested
g_main_loop is wrong.  Since the two callbacks no longer share more
than the setting of data.complete and data.error, it's just as easy to
use static helpers instead of trying to share a common code path.  It
is also possible to add assertions that no other code is interfering
with the eventual path to qio reaching the callback, whether or not it
required a yield or main loop.

Fixes: f95910f ("nbd: implement TLS support in the protocol negotiation")
Signed-off-by: Zhu Yangyang <zhuyangyang14@huawei.com>
[eblake: move callbacks to their use point, add assertions]
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20240408160214.1200629-5-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
(cherry picked from commit ae6d91a7e9b77abb029ed3fa9fad461422286942)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/nbd/client.c b/nbd/client.c
index 29ffc609a4..c89c750467 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -596,13 +596,31 @@ static int nbd_request_simple_option(QIOChannel *ioc, int opt, bool strict,
     return 1;
 }
 
+/* Callback to learn when QIO TLS upgrade is complete */
+struct NBDTLSClientHandshakeData {
+    bool complete;
+    Error *error;
+    GMainLoop *loop;
+};
+
+static void nbd_client_tls_handshake(QIOTask *task, void *opaque)
+{
+    struct NBDTLSClientHandshakeData *data = opaque;
+
+    qio_task_propagate_error(task, &data->error);
+    data->complete = true;
+    if (data->loop) {
+        g_main_loop_quit(data->loop);
+    }
+}
+
 static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
                                         QCryptoTLSCreds *tlscreds,
                                         const char *hostname, Error **errp)
 {
     int ret;
     QIOChannelTLS *tioc;
-    struct NBDTLSHandshakeData data = { 0 };
+    struct NBDTLSClientHandshakeData data = { 0 };
 
     ret = nbd_request_simple_option(ioc, NBD_OPT_STARTTLS, true, errp);
     if (ret <= 0) {
@@ -619,18 +637,20 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
         return NULL;
     }
     qio_channel_set_name(QIO_CHANNEL(tioc), "nbd-client-tls");
-    data.loop = g_main_loop_new(g_main_context_default(), FALSE);
     trace_nbd_receive_starttls_tls_handshake();
     qio_channel_tls_handshake(tioc,
-                              nbd_tls_handshake,
+                              nbd_client_tls_handshake,
                               &data,
                               NULL,
                               NULL);
 
     if (!data.complete) {
+        data.loop = g_main_loop_new(g_main_context_default(), FALSE);
         g_main_loop_run(data.loop);
+        assert(data.complete);
+        g_main_loop_unref(data.loop);
     }
-    g_main_loop_unref(data.loop);
+
     if (data.error) {
         error_propagate(errp, data.error);
         object_unref(OBJECT(tioc));
diff --git a/nbd/common.c b/nbd/common.c
index 3247c1d618..589a748cfe 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -47,17 +47,6 @@ int nbd_drop(QIOChannel *ioc, size_t size, Error **errp)
 }
 
 
-void nbd_tls_handshake(QIOTask *task,
-                       void *opaque)
-{
-    struct NBDTLSHandshakeData *data = opaque;
-
-    qio_task_propagate_error(task, &data->error);
-    data->complete = true;
-    g_main_loop_quit(data->loop);
-}
-
-
 const char *nbd_opt_lookup(uint32_t opt)
 {
     switch (opt) {
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index dfa02f77ee..91895106a9 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -72,16 +72,6 @@ static inline int nbd_write(QIOChannel *ioc, const void *buffer, size_t size,
     return qio_channel_write_all(ioc, buffer, size, errp) < 0 ? -EIO : 0;
 }
 
-struct NBDTLSHandshakeData {
-    GMainLoop *loop;
-    bool complete;
-    Error *error;
-};
-
-
-void nbd_tls_handshake(QIOTask *task,
-                       void *opaque);
-
 int nbd_drop(QIOChannel *ioc, size_t size, Error **errp);
 
 #endif
diff --git a/nbd/server.c b/nbd/server.c
index 091b57119e..9fbac7d409 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -748,6 +748,23 @@ static int nbd_negotiate_handle_info(NBDClient *client, Error **errp)
     return rc;
 }
 
+/* Callback to learn when QIO TLS upgrade is complete */
+struct NBDTLSServerHandshakeData {
+    bool complete;
+    Error *error;
+    Coroutine *co;
+};
+
+static void nbd_server_tls_handshake(QIOTask *task, void *opaque)
+{
+    struct NBDTLSServerHandshakeData *data = opaque;
+
+    qio_task_propagate_error(task, &data->error);
+    data->complete = true;
+    if (!qemu_coroutine_entered(data->co)) {
+        aio_co_wake(data->co);
+    }
+}
 
 /* Handle NBD_OPT_STARTTLS. Return NULL to drop connection, or else the
  * new channel for all further (now-encrypted) communication. */
@@ -756,7 +773,7 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
 {
     QIOChannel *ioc;
     QIOChannelTLS *tioc;
-    struct NBDTLSHandshakeData data = { 0 };
+    struct NBDTLSServerHandshakeData data = { 0 };
 
     assert(client->opt == NBD_OPT_STARTTLS);
 
@@ -777,17 +794,18 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
 
     qio_channel_set_name(QIO_CHANNEL(tioc), "nbd-server-tls");
     trace_nbd_negotiate_handle_starttls_handshake();
-    data.loop = g_main_loop_new(g_main_context_default(), FALSE);
+    data.co = qemu_coroutine_self();
     qio_channel_tls_handshake(tioc,
-                              nbd_tls_handshake,
+                              nbd_server_tls_handshake,
                               &data,
                               NULL,
                               NULL);
 
     if (!data.complete) {
-        g_main_loop_run(data.loop);
+        qemu_coroutine_yield();
+        assert(data.complete);
     }
-    g_main_loop_unref(data.loop);
+
     if (data.error) {
         object_unref(OBJECT(tioc));
         error_propagate(errp, data.error);
-- 
2.39.2


