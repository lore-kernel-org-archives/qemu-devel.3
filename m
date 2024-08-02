Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC1BC3DA64
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 01:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZhPQ-0000NH-Vr; Thu, 01 Aug 2024 21:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sZhPP-0000HC-MK
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 21:48:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sZhPN-0001x3-Vf
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 21:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722563321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9XSbx+qalhDMiZY7QyZ5LwrsBwDHNdIomGwno1d0l3M=;
 b=TONjeUeWK80BMt9tPWua11Tn+EbN5NopS6UNbem9qjRWjNzChLP3RlQQjBnC7V27QOvnGH
 u9I2d/bFrdRu8PujJnbq9RItne2Dtt9hryUMKr6hS7knkJyd3xx7+3pyEaYwqOI5tKzmsx
 EFrtYajJaqTorTK1DYHDsZ+D7EJtVWo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-KilJe2ADOWS3Gc1jNcfPeA-1; Thu,
 01 Aug 2024 21:48:37 -0400
X-MC-Unique: KilJe2ADOWS3Gc1jNcfPeA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA8661956088; Fri,  2 Aug 2024 01:48:35 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.72])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C4F9C19560AA; Fri,  2 Aug 2024 01:48:33 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com,
 berrange@redhat.com, Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Subject: [PATCH v2 1/3] nbd: CVE-XXX: Use cookie to track generation of
 nbd-server
Date: Thu,  1 Aug 2024 20:32:06 -0500
Message-ID: <20240802014824.1906798-6-eblake@redhat.com>
In-Reply-To: <20240802014824.1906798-5-eblake@redhat.com>
References: <20240802014824.1906798-5-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

As part of the QMP command nbd-server-start, the blockdev code was
creating a single global nbd_server object, and telling the qio code
to accept one or more client connections to the exposed listener
socket.  But even though we tear down the listener socket during a
subsequent QMP nbd-server-stop, the qio code has handed off to a
coroutine that may be executing asynchronously with the server
shutdown, such that a client that connects to the socket before
nbd-server-stop but delays disconnect or completion of the NBD
handshake until after the followup QMP command can result in the
nbd_blockdev_client_closed() callback running after nbd_server has
already been torn down, causing a SEGV.  Worse, if a second nbd_server
object is created (possibly on a different socket address), a late
client resolution from the first server can subtly interfere with the
second server.  This can be abused by a malicious client that does not
know TLS secrets to cause qemu to SEGV after a legitimate client has
concluded storage migration to a destination qemu, which can be turned
into a denial of service attack even when qemu is set up to require
only TLS clients.

For environments without this patch, the CVE can be mitigated by
ensuring (such as via a firewall) that only trusted clients can
connect to an NBD server; using frameworks like libvirt that ensure
that nbd-server-stop is not executed while any trusted clients are
still connected will only help if there is also no possibility for an
untrusted client to open a connection but then stall on the NBD
handshake.

Fix this by passing a cookie through to each client connection
(whether or not that client actually knows the TLS details to
successfully negotiate); then increment the cookie every time a server
is torn down so that we can recognize any late client actions
lingering from an old server.

This patch does not address the fact that client sockets can be left
open indefinitely after the server is torn down (possibly creating a
resource leak, if a malicious client intentionally leaves lots of open
sockets paused partway through NBD negotiation); the next patch will
add some code to forcefully close any lingering clients as soon as
possible when the server is torn down.

Reported-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/nbd.h |  3 ++-
 blockdev-nbd.c      | 17 ++++++++++++-----
 nbd/server.c        | 12 ++++++++----
 qemu-nbd.c          |  5 +++--
 4 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 4e7bd6342f9..9c43bcf8a26 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -405,7 +405,8 @@ NBDExport *nbd_export_find(const char *name);
 void nbd_client_new(QIOChannelSocket *sioc,
                     QCryptoTLSCreds *tlscreds,
                     const char *tlsauthz,
-                    void (*close_fn)(NBDClient *, bool));
+                    void (*close_fn)(NBDClient *, uint32_t, bool),
+                    uint32_t cookie);
 void nbd_client_get(NBDClient *client);
 void nbd_client_put(NBDClient *client);

diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 213012435f4..1ddcbd7b247 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -30,6 +30,7 @@ typedef struct NBDServerData {
 } NBDServerData;

 static NBDServerData *nbd_server;
+static uint32_t nbd_cookie; /* Generation count of nbd_server */
 static int qemu_nbd_connections = -1; /* Non-negative if this is qemu-nbd */

 static void nbd_update_server_watch(NBDServerData *s);
@@ -49,23 +50,28 @@ int nbd_server_max_connections(void)
     return nbd_server ? nbd_server->max_connections : qemu_nbd_connections;
 }

-static void nbd_blockdev_client_closed(NBDClient *client, bool ignored)
+static void nbd_blockdev_client_closed(NBDClient *client, uint32_t cookie,
+                                       bool ignored)
 {
     nbd_client_put(client);
-    assert(nbd_server->connections > 0);
-    nbd_server->connections--;
-    nbd_update_server_watch(nbd_server);
+    /* Ignore any (late) connection made under a previous server */
+    if (cookie == nbd_cookie) {
+        assert(nbd_server->connections > 0);
+        nbd_server->connections--;
+        nbd_update_server_watch(nbd_server);
+    }
 }

 static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,
                        gpointer opaque)
 {
+    assert(nbd_server);
     nbd_server->connections++;
     nbd_update_server_watch(nbd_server);

     qio_channel_set_name(QIO_CHANNEL(cioc), "nbd-server");
     nbd_client_new(cioc, nbd_server->tlscreds, nbd_server->tlsauthz,
-                   nbd_blockdev_client_closed);
+                   nbd_blockdev_client_closed, nbd_cookie);
 }

 static void nbd_update_server_watch(NBDServerData *s)
@@ -89,6 +95,7 @@ static void nbd_server_free(NBDServerData *server)
         object_unref(OBJECT(server->tlscreds));
     }
     g_free(server->tlsauthz);
+    nbd_cookie++;

     g_free(server);
 }
diff --git a/nbd/server.c b/nbd/server.c
index 892797bb111..7c37d9753f0 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -123,7 +123,8 @@ struct NBDMetaContexts {

 struct NBDClient {
     int refcount; /* atomic */
-    void (*close_fn)(NBDClient *client, bool negotiated);
+    void (*close_fn)(NBDClient *client, uint32_t cookie, bool negotiated);
+    uint32_t close_cookie;

     QemuMutex lock;

@@ -1621,7 +1622,7 @@ static void client_close(NBDClient *client, bool negotiated)

     /* Also tell the client, so that they release their reference.  */
     if (client->close_fn) {
-        client->close_fn(client, negotiated);
+        client->close_fn(client, client->close_cookie, negotiated);
     }
 }

@@ -3207,12 +3208,14 @@ static coroutine_fn void nbd_co_client_start(void *opaque)
 /*
  * Create a new client listener using the given channel @sioc.
  * Begin servicing it in a coroutine.  When the connection closes, call
- * @close_fn with an indication of whether the client completed negotiation.
+ * @close_fn with @cookie and an indication of whether the client completed
+ # negotiation.
  */
 void nbd_client_new(QIOChannelSocket *sioc,
                     QCryptoTLSCreds *tlscreds,
                     const char *tlsauthz,
-                    void (*close_fn)(NBDClient *, bool))
+                    void (*close_fn)(NBDClient *, uint32_t, bool),
+                    uint32_t cookie)
 {
     NBDClient *client;
     Coroutine *co;
@@ -3231,6 +3234,7 @@ void nbd_client_new(QIOChannelSocket *sioc,
     client->ioc = QIO_CHANNEL(sioc);
     object_ref(OBJECT(client->ioc));
     client->close_fn = close_fn;
+    client->close_cookie = cookie;

     co = qemu_coroutine_create(nbd_co_client_start, client);
     qemu_coroutine_enter(co);
diff --git a/qemu-nbd.c b/qemu-nbd.c
index d7b3ccab21c..3ad50eec18e 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -371,7 +371,8 @@ static int nbd_can_accept(void)

 static void nbd_update_server_watch(void);

-static void nbd_client_closed(NBDClient *client, bool negotiated)
+static void nbd_client_closed(NBDClient *client, uint32_t ignored,
+                              bool negotiated)
 {
     nb_fds--;
     if (negotiated && nb_fds == 0 && !persistent && state == RUNNING) {
@@ -390,7 +391,7 @@ static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,

     nb_fds++;
     nbd_update_server_watch();
-    nbd_client_new(cioc, tlscreds, tlsauthz, nbd_client_closed);
+    nbd_client_new(cioc, tlscreds, tlsauthz, nbd_client_closed, 0);
 }

 static void nbd_update_server_watch(void)
-- 
2.45.2


