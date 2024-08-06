Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32BDC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 02:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb9tj-000092-7y; Mon, 05 Aug 2024 22:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sb9th-0008UL-2s
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 22:26:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sb9tf-0007Ve-B6
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 22:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722911158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JUix5tMRaAqggQsxcMDZnZrhqqyyV2fnHtxVRcsXu8Q=;
 b=NPz5raGpRd8ZTMQRMTJlFbkhR19WPGBemvMCoA7YavJU5Y3cKWE30+MlEQqk2YH1BtBgAL
 TkS51JbQDfASCf+jc96EPnT99gdMawC2mrPuk4mP4p9n52/TxF1YmNdTeqyhpLqc8qkTz6
 9aB4eyWOiyXLhEzd53pb1IdN3K9ED7k=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-z9K6w72rPdiN8XBFyV95vg-1; Mon,
 05 Aug 2024 22:25:55 -0400
X-MC-Unique: z9K6w72rPdiN8XBFyV95vg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 192211955D47; Tue,  6 Aug 2024 02:25:54 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.20])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E31131955E7F; Tue,  6 Aug 2024 02:25:51 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, vsementsov@yandex-team.ru
Subject: [PATCH v3 2/2] nbd: Clean up clients more efficiently
Date: Mon,  5 Aug 2024 21:21:36 -0500
Message-ID: <20240806022542.381883-6-eblake@redhat.com>
In-Reply-To: <20240806022542.381883-4-eblake@redhat.com>
References: <20240806022542.381883-4-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Since an NBD server may be long-living, serving clients that
repeatedly connect and disconnect, it can be more efficient to clean
up after each client disconnects, rather than storing a list of
resources to clean up when the server exits.  Rewrite the list of
known clients to be double-linked so that we can get O(1) deletion to
keep the list pruned to size as clients exit.  This in turn requires
each client to track an opaque pointer of owner information (although
qemu-nbd doesn't need to refer to it).

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/nbd.h |  4 +++-
 blockdev-nbd.c      | 27 ++++++++++++++++-----------
 nbd/server.c        | 15 ++++++++++++---
 qemu-nbd.c          |  2 +-
 4 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 4e7bd6342f9..7dce9b9c35b 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -405,7 +405,9 @@ NBDExport *nbd_export_find(const char *name);
 void nbd_client_new(QIOChannelSocket *sioc,
                     QCryptoTLSCreds *tlscreds,
                     const char *tlsauthz,
-                    void (*close_fn)(NBDClient *, bool));
+                    void (*close_fn)(NBDClient *, bool),
+                    void *owner);
+void *nbd_client_owner(NBDClient *client);
 void nbd_client_get(NBDClient *client);
 void nbd_client_put(NBDClient *client);

diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index b8f00f402c6..660f89d881e 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -23,7 +23,7 @@

 typedef struct NBDConn {
     QIOChannelSocket *cioc;
-    QSLIST_ENTRY(NBDConn) next;
+    QLIST_ENTRY(NBDConn) next;
 } NBDConn;

 typedef struct NBDServerData {
@@ -32,10 +32,11 @@ typedef struct NBDServerData {
     char *tlsauthz;
     uint32_t max_connections;
     uint32_t connections;
-    QSLIST_HEAD(, NBDConn) conns;
+    QLIST_HEAD(, NBDConn) conns;
 } NBDServerData;

 static NBDServerData *nbd_server;
+static uint32_t nbd_cookie; /* Generation count of nbd_server */
 static int qemu_nbd_connections = -1; /* Non-negative if this is qemu-nbd */

 static void nbd_update_server_watch(NBDServerData *s);
@@ -57,10 +58,16 @@ int nbd_server_max_connections(void)

 static void nbd_blockdev_client_closed(NBDClient *client, bool ignored)
 {
+    NBDConn *conn = nbd_client_owner(client);
+
     assert(qemu_in_main_thread() && nbd_server);

+    object_unref(OBJECT(conn->cioc));
+    QLIST_REMOVE(conn, next);
+    g_free(conn);
+
     nbd_client_put(client);
-    assert(nbd_server->connections > 0);
+    assert(nbd_server && nbd_server->connections > 0);
     nbd_server->connections--;
     nbd_update_server_watch(nbd_server);
 }
@@ -74,12 +81,12 @@ static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,
     nbd_server->connections++;
     object_ref(OBJECT(cioc));
     conn->cioc = cioc;
-    QSLIST_INSERT_HEAD(&nbd_server->conns, conn, next);
+    QLIST_INSERT_HEAD(&nbd_server->conns, conn, next);
     nbd_update_server_watch(nbd_server);

     qio_channel_set_name(QIO_CHANNEL(cioc), "nbd-server");
     nbd_client_new(cioc, nbd_server->tlscreds, nbd_server->tlsauthz,
-                   nbd_blockdev_client_closed);
+                   nbd_blockdev_client_closed, conn);
 }

 static void nbd_update_server_watch(NBDServerData *s)
@@ -93,6 +100,8 @@ static void nbd_update_server_watch(NBDServerData *s)

 static void nbd_server_free(NBDServerData *server)
 {
+    NBDConn *conn, *tmp;
+
     if (!server) {
         return;
     }
@@ -103,14 +112,9 @@ static void nbd_server_free(NBDServerData *server)
      */
     qio_net_listener_disconnect(server->listener);
     object_unref(OBJECT(server->listener));
-    while (!QSLIST_EMPTY(&server->conns)) {
-        NBDConn *conn = QSLIST_FIRST(&server->conns);
-
+    QLIST_FOREACH_SAFE(conn, &server->conns, next, tmp) {
         qio_channel_shutdown(QIO_CHANNEL(conn->cioc), QIO_CHANNEL_SHUTDOWN_BOTH,
                              NULL);
-        object_unref(OBJECT(conn->cioc));
-        QSLIST_REMOVE_HEAD(&server->conns, next);
-        g_free(conn);
     }

     AIO_WAIT_WHILE_UNLOCKED(NULL, server->connections > 0);
@@ -119,6 +123,7 @@ static void nbd_server_free(NBDServerData *server)
         object_unref(OBJECT(server->tlscreds));
     }
     g_free(server->tlsauthz);
+    nbd_cookie++;

     g_free(server);
 }
diff --git a/nbd/server.c b/nbd/server.c
index 892797bb111..90f48b42a47 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -124,6 +124,7 @@ struct NBDMetaContexts {
 struct NBDClient {
     int refcount; /* atomic */
     void (*close_fn)(NBDClient *client, bool negotiated);
+    void *owner;

     QemuMutex lock;

@@ -3205,14 +3206,15 @@ static coroutine_fn void nbd_co_client_start(void *opaque)
 }

 /*
- * Create a new client listener using the given channel @sioc.
+ * Create a new client listener using the given channel @sioc and @owner.
  * Begin servicing it in a coroutine.  When the connection closes, call
- * @close_fn with an indication of whether the client completed negotiation.
+ * @close_fn and an indication of whether the client completed negotiation.
  */
 void nbd_client_new(QIOChannelSocket *sioc,
                     QCryptoTLSCreds *tlscreds,
                     const char *tlsauthz,
-                    void (*close_fn)(NBDClient *, bool))
+                    void (*close_fn)(NBDClient *, bool),
+                    void *owner)
 {
     NBDClient *client;
     Coroutine *co;
@@ -3231,7 +3233,14 @@ void nbd_client_new(QIOChannelSocket *sioc,
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
index d7b3ccab21c..da6e36a2a34 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -390,7 +390,7 @@ static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,

     nb_fds++;
     nbd_update_server_watch();
-    nbd_client_new(cioc, tlscreds, tlsauthz, nbd_client_closed);
+    nbd_client_new(cioc, tlscreds, tlsauthz, nbd_client_closed, NULL);
 }

 static void nbd_update_server_watch(void)
-- 
2.45.2


