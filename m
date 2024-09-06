Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78002CD5BDD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 05:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smRNt-000145-BL; Fri, 06 Sep 2024 01:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smRNi-0007r4-Jm; Fri, 06 Sep 2024 01:19:38 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smRNg-0008I5-9h; Fri, 06 Sep 2024 01:19:38 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2370B8C134;
 Fri,  6 Sep 2024 08:15:18 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C5369133379;
 Fri,  6 Sep 2024 08:16:35 +0300 (MSK)
Received: (nullmailer pid 10480 invoked by uid 1000);
 Fri, 06 Sep 2024 05:16:33 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.14 31/40] nbd/server: Plumb in new args to
 nbd_client_add()
Date: Fri,  6 Sep 2024 08:16:19 +0300
Message-Id: <20240906051633.10288-31-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.14-20240906080824@cover.tls.msk.ru>
References: <qemu-stable-7.2.14-20240906080824@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Eric Blake <eblake@redhat.com>

Upcoming patches to fix a CVE need to track an opaque pointer passed
in by the owner of a client object, as well as request for a time
limit on how fast negotiation must complete.  Prepare for that by
changing the signature of nbd_client_new() and adding an accessor to
get at the opaque pointer, although for now the two servers
(qemu-nbd.c and blockdev-nbd.c) do not change behavior even though
they pass in a new default timeout value.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20240807174943.771624-11-eblake@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
[eblake: s/LIMIT/MAX_SECS/ as suggested by Dan]
Signed-off-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit fb1c2aaa981e0a2fa6362c9985f1296b74f055ac)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 012256bb02..bf02ddc1e0 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -64,8 +64,10 @@ static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,
     nbd_update_server_watch(nbd_server);
 
     qio_channel_set_name(QIO_CHANNEL(cioc), "nbd-server");
-    nbd_client_new(cioc, nbd_server->tlscreds, nbd_server->tlsauthz,
-                   nbd_blockdev_client_closed);
+    /* TODO - expose handshake timeout as QMP option */
+    nbd_client_new(cioc, NBD_DEFAULT_HANDSHAKE_MAX_SECS,
+                   nbd_server->tlscreds, nbd_server->tlsauthz,
+                   nbd_blockdev_client_closed, NULL);
 }
 
 static void nbd_update_server_watch(NBDServerData *s)
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 4ede3b2bd0..3392a5c319 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -27,6 +27,12 @@
 
 extern const BlockExportDriver blk_exp_nbd;
 
+/*
+ * NBD_DEFAULT_HANDSHAKE_MAX_SECS: Number of seconds in which client must
+ * succeed at NBD_OPT_GO before being forcefully dropped as too slow.
+ */
+#define NBD_DEFAULT_HANDSHAKE_MAX_SECS 10
+
 /* Handshake phase structs - this struct is passed on the wire */
 
 struct NBDOption {
@@ -338,9 +344,12 @@ AioContext *nbd_export_aio_context(NBDExport *exp);
 NBDExport *nbd_export_find(const char *name);
 
 void nbd_client_new(QIOChannelSocket *sioc,
+                    uint32_t handshake_max_secs,
                     QCryptoTLSCreds *tlscreds,
                     const char *tlsauthz,
-                    void (*close_fn)(NBDClient *, bool));
+                    void (*close_fn)(NBDClient *, bool),
+                    void *owner);
+void *nbd_client_owner(NBDClient *client);
 void nbd_client_get(NBDClient *client);
 void nbd_client_put(NBDClient *client);
 
diff --git a/nbd/server.c b/nbd/server.c
index 74edb2815b..431e543b47 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -120,10 +120,12 @@ typedef struct NBDExportMetaContexts {
 struct NBDClient {
     int refcount;
     void (*close_fn)(NBDClient *client, bool negotiated);
+    void *owner;
 
     NBDExport *exp;
     QCryptoTLSCreds *tlscreds;
     char *tlsauthz;
+    uint32_t handshake_max_secs;
     QIOChannelSocket *sioc; /* The underlying data channel */
     QIOChannel *ioc; /* The current I/O channel which may differ (eg TLS) */
 
@@ -2755,6 +2757,7 @@ static coroutine_fn void nbd_co_client_start(void *opaque)
 
     qemu_co_mutex_init(&client->send_lock);
 
+    /* TODO - utilize client->handshake_max_secs */
     if (nbd_negotiate(client, &local_err)) {
         if (local_err) {
             error_report_err(local_err);
@@ -2767,14 +2770,17 @@ static coroutine_fn void nbd_co_client_start(void *opaque)
 }
 
 /*
- * Create a new client listener using the given channel @sioc.
+ * Create a new client listener using the given channel @sioc and @owner.
  * Begin servicing it in a coroutine.  When the connection closes, call
- * @close_fn with an indication of whether the client completed negotiation.
+ * @close_fn with an indication of whether the client completed negotiation
+ * within @handshake_max_secs seconds (0 for unbounded).
  */
 void nbd_client_new(QIOChannelSocket *sioc,
+                    uint32_t handshake_max_secs,
                     QCryptoTLSCreds *tlscreds,
                     const char *tlsauthz,
-                    void (*close_fn)(NBDClient *, bool))
+                    void (*close_fn)(NBDClient *, bool),
+                    void *owner)
 {
     NBDClient *client;
     Coroutine *co;
@@ -2786,12 +2792,20 @@ void nbd_client_new(QIOChannelSocket *sioc,
         object_ref(OBJECT(client->tlscreds));
     }
     client->tlsauthz = g_strdup(tlsauthz);
+    client->handshake_max_secs = handshake_max_secs;
     client->sioc = sioc;
     object_ref(OBJECT(client->sioc));
     client->ioc = QIO_CHANNEL(sioc);
     object_ref(OBJECT(client->ioc));
     client->close_fn = close_fn;
+    client->owner = owner;
 
     co = qemu_coroutine_create(nbd_co_client_start, client);
     qemu_coroutine_enter(co);
 }
+
+void *
+nbd_client_owner(NBDClient *client)
+{
+    return client->owner;
+}
diff --git a/qemu-nbd.c b/qemu-nbd.c
index f71f5125d8..16b220bdad 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -369,7 +369,9 @@ static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,
 
     nb_fds++;
     nbd_update_server_watch();
-    nbd_client_new(cioc, tlscreds, tlsauthz, nbd_client_closed);
+    /* TODO - expose handshake timeout as command line option */
+    nbd_client_new(cioc, NBD_DEFAULT_HANDSHAKE_MAX_SECS,
+                   tlscreds, tlsauthz, nbd_client_closed, NULL);
 }
 
 static void nbd_update_server_watch(void)
-- 
2.39.2


