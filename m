Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBE4CD1288
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 01:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsC9g-0003ee-Rk; Wed, 03 Apr 2024 21:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rsC9a-0003ct-Ko
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 21:44:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rsC9X-00088M-SU
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 21:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712195070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3v1A/XRbAuRYdZTBDb5U+5I0E7Ui1CGNVwOXEjygZ5w=;
 b=UivKICZrNXwV7YAkFCqmmhbkP2IZ5+YskMjfhlbO0REtyfkMdSHxGeWDfdTmaSjDQDZC9/
 5ElzIJiVlIjNPkMMK0ge6PlRjETKtOUutw6lJVtDtBp45YxhP91lZ1LjkLnVM0r2icis/T
 vOIWlE5tJiyCrZR/xRuhL423owkmkV8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-a_YDNk2xMf6PaYUpHrGZng-1; Wed,
 03 Apr 2024 21:44:27 -0400
X-MC-Unique: a_YDNk2xMf6PaYUpHrGZng-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F16DB1C172A8;
 Thu,  4 Apr 2024 01:44:26 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 787F3492BCD;
 Thu,  4 Apr 2024 01:44:25 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Zhu Yangyang <zhuyangyang14@huawei.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v3] nbd/server: do not poll within a coroutine context
Date: Wed,  3 Apr 2024 20:42:24 -0500
Message-ID: <20240404014418.620851-2-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
use static helpers instead of trying to share a common code path.

Fixes: f95910f ("nbd: implement TLS support in the protocol negotiation")
Signed-off-by: Zhu Yangyang <zhuyangyang14@huawei.com>
[eblake: move callbacks to their use point]
Signed-off-by: Eric Blake <eblake@redhat.com>
---

After looking at this more, I'm less convinced that there is enough
common code here to even be worth trying to share in common.c.  This
takes the essence of the v2 patch, but refactors it a bit.

v2: https://lists.gnu.org/archive/html/qemu-devel/2024-04/msg00019.html

 nbd/nbd-internal.h | 20 ++++++++++----------
 nbd/client.c       | 21 +++++++++++++++++----
 nbd/common.c       | 11 -----------
 nbd/server.c       | 21 ++++++++++++++++-----
 4 files changed, 43 insertions(+), 30 deletions(-)

diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index dfa02f77ee4..087c6bfc002 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -63,6 +63,16 @@
 #define NBD_SET_TIMEOUT             _IO(0xab, 9)
 #define NBD_SET_FLAGS               _IO(0xab, 10)

+/* Used in NBD_OPT_STARTTLS handling */
+struct NBDTLSHandshakeData {
+    bool complete;
+    Error *error;
+    union {
+        GMainLoop *loop;
+        Coroutine *co;
+    } u;
+};
+
 /* nbd_write
  * Writes @size bytes to @ioc. Returns 0 on success.
  */
@@ -72,16 +82,6 @@ static inline int nbd_write(QIOChannel *ioc, const void *buffer, size_t size,
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
diff --git a/nbd/client.c b/nbd/client.c
index 29ffc609a4b..c9dc5265404 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -596,6 +596,18 @@ static int nbd_request_simple_option(QIOChannel *ioc, int opt, bool strict,
     return 1;
 }

+/* Callback to learn when QIO TLS upgrade is complete */
+static void nbd_client_tls_handshake(QIOTask *task, void *opaque)
+{
+    struct NBDTLSHandshakeData *data = opaque;
+
+    qio_task_propagate_error(task, &data->error);
+    data->complete = true;
+    if (data->u.loop) {
+        g_main_loop_quit(data->u.loop);
+    }
+}
+
 static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
                                         QCryptoTLSCreds *tlscreds,
                                         const char *hostname, Error **errp)
@@ -619,18 +631,19 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
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
-        g_main_loop_run(data.loop);
+        data.u.loop = g_main_loop_new(g_main_context_default(), FALSE);
+        g_main_loop_run(data.u.loop);
+        g_main_loop_unref(data.u.loop);
     }
-    g_main_loop_unref(data.loop);
+
     if (data.error) {
         error_propagate(errp, data.error);
         object_unref(OBJECT(tioc));
diff --git a/nbd/common.c b/nbd/common.c
index 3247c1d618a..589a748cfe6 100644
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
diff --git a/nbd/server.c b/nbd/server.c
index c3484cc1ebc..d16726a6326 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -748,6 +748,17 @@ static int nbd_negotiate_handle_info(NBDClient *client, Error **errp)
     return rc;
 }

+/* Callback to learn when QIO TLS upgrade is complete */
+static void nbd_server_tls_handshake(QIOTask *task, void *opaque)
+{
+    struct NBDTLSHandshakeData *data = opaque;
+
+    qio_task_propagate_error(task, &data->error);
+    data->complete = true;
+    if (!qemu_coroutine_entered(data->u.co)) {
+        aio_co_wake(data->u.co);
+    }
+}

 /* Handle NBD_OPT_STARTTLS. Return NULL to drop connection, or else the
  * new channel for all further (now-encrypted) communication. */
@@ -777,17 +788,17 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,

     qio_channel_set_name(QIO_CHANNEL(tioc), "nbd-server-tls");
     trace_nbd_negotiate_handle_starttls_handshake();
-    data.loop = g_main_loop_new(g_main_context_default(), FALSE);
+    data.u.co = qemu_coroutine_self();
     qio_channel_tls_handshake(tioc,
-                              nbd_tls_handshake,
+                              nbd_server_tls_handshake,
                               &data,
                               NULL,
                               NULL);

-    if (!data.complete) {
-        g_main_loop_run(data.loop);
+    while (!data.complete) {
+        qemu_coroutine_yield();
     }
-    g_main_loop_unref(data.loop);
+
     if (data.error) {
         object_unref(OBJECT(tioc));
         error_propagate(errp, data.error);
-- 
2.44.0


