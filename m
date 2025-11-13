Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FDBCD98FC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 22:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJgET-0006pe-Vw; Thu, 13 Nov 2025 17:56:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJgEJ-0006ky-TT
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 17:55:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJgEH-0000lw-OY
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 17:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763074549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yfaZmhfT5FMbK6fQyyHMb4KRAuvT1pqkCCWbuRrODso=;
 b=TELaO2Ve3wFW5ufNSrskZzQwlbSuGLvS1UzN9HE4oCqwwPCarZb6oGc4Uwoz3+oh8IO+1/
 njtOorWBoKDsXILa0/2PKsn7I0lskq8Zy703ohq8KqhQuWuH+Zr3TH7CDPkRA/OLkH5TSP
 JDHgftwe5zi4BQ/6PppbKPurB9PwAN8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-TFrlQC1HMdWgRz2_gvFAHw-1; Thu,
 13 Nov 2025 17:55:47 -0500
X-MC-Unique: TFrlQC1HMdWgRz2_gvFAHw-1
X-Mimecast-MFC-AGG-ID: TFrlQC1HMdWgRz2_gvFAHw_1763074546
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA8CD1956070; Thu, 13 Nov 2025 22:55:46 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4B33E1955F1B; Thu, 13 Nov 2025 22:55:45 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 09/15] qio: Provide accessor around QIONetListener->sioc
Date: Thu, 13 Nov 2025 16:55:05 -0600
Message-ID: <20251113225531.1077484-26-eblake@redhat.com>
In-Reply-To: <20251113225531.1077484-17-eblake@redhat.com>
References: <20251113225531.1077484-17-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

An upcoming patch needs to pass more than just sioc as the opaque
pointer to an AioContext; but since our AioContext code in general
(and its QIO Channel wrapper code) lacks a notify callback present
with GSource, we do not have the trivial option of just g_malloc'ing a
small struct to hold all that data coupled with a notify of g_free.
Instead, the data pointer must outlive the registered handler; in
fact, having the data pointer have the same lifetime as QIONetListener
is adequate.

But the cleanest way to stick such a helper struct in QIONetListener
will be to rearrange internal struct members.  And that in turn means
that all existing code that currently directly accesses
listener->nsioc and listener->sioc[] should instead go through
accessor functions, to be immune to the upcoming struct layout
changes.  So this patch adds accessor methods qio_net_listener_nsioc()
and qio_net_listener_sioc(), and puts them to use.

While at it, notice that the pattern of grabbing an sioc from the
listener only to turn around can call
qio_channel_socket_get_local_address is common enough to also warrant
the helper of qio_net_listener_get_local_address, and fix a copy-paste
error in the corresponding documentation.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20251113011625.878876-24-eblake@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/io/channel-socket.h |  2 +-
 include/io/net-listener.h   | 42 +++++++++++++++++++++++++++++++++++++
 chardev/char-socket.c       |  2 +-
 io/net-listener.c           | 27 ++++++++++++++++++++++++
 migration/socket.c          |  4 ++--
 ui/vnc.c                    | 34 ++++++++++++++++++------------
 6 files changed, 94 insertions(+), 17 deletions(-)

diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index fcfd489c6ce..a1ef3136ea2 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -228,7 +228,7 @@ void qio_channel_socket_dgram_async(QIOChannelSocket *ioc,
  * release with a call qapi_free_SocketAddress() when no
  * longer required.
  *
- * Returns: 0 on success, -1 on error
+ * Returns: the socket address struct, or NULL on error
  */
 SocketAddress *
 qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
diff --git a/include/io/net-listener.h b/include/io/net-listener.h
index c2165dc1669..95bc7407d66 100644
--- a/include/io/net-listener.h
+++ b/include/io/net-listener.h
@@ -185,4 +185,46 @@ void qio_net_listener_disconnect(QIONetListener *listener);
  */
 bool qio_net_listener_is_connected(QIONetListener *listener);

+
+/**
+ * qio_net_listener_nsioc:
+ * @listener: the network listener object
+ *
+ * Determine the number of listener channels currently owned by the
+ * given listener.
+ *
+ * Returns: number of channels, or 0 if not listening
+ */
+size_t qio_net_listener_nsioc(QIONetListener *listener);
+
+
+/**
+ * qio_net_listener_sioc:
+ * @listener: the network listener object
+ * @n: index of the sioc to grab
+ *
+ * Accessor for the nth sioc owned by the listener.
+ *
+ * Returns: the requested listener, or NULL if not in bounds
+ */
+QIOChannelSocket *qio_net_listener_sioc(QIONetListener *listener, size_t n);
+
+/**
+ * qio_net_listener_get_local_address:
+ * @listener: the network listener object
+ * @n: index of the sioc to grab
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Get the string representation of the local socket
+ * address. A pointer to the allocated address information
+ * struct will be returned, which the caller is required to
+ * release with a call qapi_free_SocketAddress() when no
+ * longer required.
+ *
+ * Returns: the socket address struct, or NULL on error
+ */
+SocketAddress *
+qio_net_listener_get_local_address(QIONetListener *listener, size_t n,
+                                   Error **errp);
+
 #endif /* QIO_NET_LISTENER_H */
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index ec4116ade4d..26d2f11202e 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1255,7 +1255,7 @@ static int qmp_chardev_open_socket_server(Chardev *chr,
     }

     qapi_free_SocketAddress(s->addr);
-    s->addr = qio_channel_socket_get_local_address(s->listener->sioc[0], errp);
+    s->addr = qio_net_listener_get_local_address(s->listener, 0, errp);

 skip_listen:
     update_disconnected_filename(s);
diff --git a/io/net-listener.c b/io/net-listener.c
index 9a94b153279..9ffbc141a76 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -316,6 +316,33 @@ bool qio_net_listener_is_connected(QIONetListener *listener)
     return listener->connected;
 }

+size_t qio_net_listener_nsioc(QIONetListener *listener)
+{
+    return listener->nsioc;
+}
+
+QIOChannelSocket *qio_net_listener_sioc(QIONetListener *listener, size_t n)
+{
+    if (n >= listener->nsioc) {
+        return NULL;
+    }
+    return listener->sioc[n];
+}
+
+SocketAddress *
+qio_net_listener_get_local_address(QIONetListener *listener, size_t n,
+                                   Error **errp)
+{
+    QIOChannelSocket *sioc = qio_net_listener_sioc(listener, n);
+
+    if (!sioc) {
+        error_setg(errp, "Listener index out of range");
+        return NULL;
+    }
+
+    return qio_channel_socket_get_local_address(sioc, errp);
+}
+
 static void qio_net_listener_finalize(Object *obj)
 {
     QIONetListener *listener = QIO_NET_LISTENER(obj);
diff --git a/migration/socket.c b/migration/socket.c
index 5ec65b8c039..9e379bf56fd 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -170,9 +170,9 @@ void socket_start_incoming_migration(SocketAddress *saddr,
                                           NULL, NULL,
                                           g_main_context_get_thread_default());

-    for (i = 0; i < listener->nsioc; i++)  {
+    for (i = 0; i < qio_net_listener_nsioc(listener); i++)  {
         SocketAddress *address =
-            qio_channel_socket_get_local_address(listener->sioc[i], errp);
+            qio_net_listener_get_local_address(listener, i, errp);
         if (!address) {
             return;
         }
diff --git a/ui/vnc.c b/ui/vnc.c
index 50016ff7ab4..0d499b208b9 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -235,12 +235,12 @@ static VncServerInfo *vnc_server_info_get(VncDisplay *vd)
     VncServerInfo *info;
     Error *err = NULL;

-    if (!vd->listener || !vd->listener->nsioc) {
+    if (!vd->listener || !qio_net_listener_nsioc(vd->listener)) {
         return NULL;
     }

     info = g_malloc0(sizeof(*info));
-    vnc_init_basic_info_from_server_addr(vd->listener->sioc[0],
+    vnc_init_basic_info_from_server_addr(qio_net_listener_sioc(vd->listener, 0),
                                          qapi_VncServerInfo_base(info), &err);
     info->auth = g_strdup(vnc_auth_name(vd));
     if (err) {
@@ -377,7 +377,7 @@ VncInfo *qmp_query_vnc(Error **errp)
     VncDisplay *vd = vnc_display_find(NULL);
     SocketAddress *addr = NULL;

-    if (vd == NULL || !vd->listener || !vd->listener->nsioc) {
+    if (vd == NULL || !vd->listener || !qio_net_listener_nsioc(vd->listener)) {
         info->enabled = false;
     } else {
         info->enabled = true;
@@ -386,8 +386,7 @@ VncInfo *qmp_query_vnc(Error **errp)
         info->has_clients = true;
         info->clients = qmp_query_client_list(vd);

-        addr = qio_channel_socket_get_local_address(vd->listener->sioc[0],
-                                                    errp);
+        addr = qio_net_listener_get_local_address(vd->listener, 0, errp);
         if (!addr) {
             goto out_error;
         }
@@ -549,6 +548,8 @@ VncInfo2List *qmp_query_vnc_servers(Error **errp)
     size_t i;

     QTAILQ_FOREACH(vd, &vnc_displays, next) {
+        size_t nsioc = 0;
+
         info = g_new0(VncInfo2, 1);
         info->id = g_strdup(vd->id);
         info->clients = qmp_query_client_list(vd);
@@ -559,14 +560,21 @@ VncInfo2List *qmp_query_vnc_servers(Error **errp)
                                                   "device", &error_abort));
             info->display = g_strdup(dev->id);
         }
-        for (i = 0; vd->listener != NULL && i < vd->listener->nsioc; i++) {
-            info->server = qmp_query_server_entry(
-                vd->listener->sioc[i], false, vd->auth, vd->subauth,
-                info->server);
+        if (vd->listener != NULL) {
+            nsioc = qio_net_listener_nsioc(vd->listener);
         }
-        for (i = 0; vd->wslistener != NULL && i < vd->wslistener->nsioc; i++) {
+        for (i = 0; i < nsioc; i++) {
             info->server = qmp_query_server_entry(
-                vd->wslistener->sioc[i], true, vd->ws_auth,
+                qio_net_listener_sioc(vd->listener, i), false, vd->auth,
+                vd->subauth, info->server);
+        }
+        nsioc = 0;
+        if (vd->wslistener) {
+            nsioc = qio_net_listener_nsioc(vd->wslistener);
+        }
+        for (i = 0; i < nsioc; i++) {
+            info->server = qmp_query_server_entry(
+                qio_net_listener_sioc(vd->wslistener, i), true, vd->ws_auth,
                 vd->ws_subauth, info->server);
         }

@@ -3550,11 +3558,11 @@ static void vnc_display_print_local_addr(VncDisplay *vd)
 {
     SocketAddress *addr;

-    if (!vd->listener || !vd->listener->nsioc) {
+    if (!vd->listener || !qio_net_listener_nsioc(vd->listener)) {
         return;
     }

-    addr = qio_channel_socket_get_local_address(vd->listener->sioc[0], NULL);
+    addr = qio_net_listener_get_local_address(vd->listener, 0, NULL);
     if (!addr) {
         return;
     }
-- 
2.51.1


