Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6BDD44C56
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 14:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgOcp-0005PL-5l; Thu, 15 Jan 2026 09:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vgOcK-0004kw-RQ
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:46:47 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vgOcC-0002rN-N2
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:46:28 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bca6:0:640:3d05:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 9E5D7C020B;
 Thu, 15 Jan 2026 17:46:20 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:b8d::1:8])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 8kWwj30BHuQ0-6fAae0hg; Thu, 15 Jan 2026 17:46:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768488379;
 bh=Ou4lRE5AojY7fWZVN/NXIe6momlZuSlhghA8qbKt0xI=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=boSZY5Q6jEoy9f/kcH/653A4vZ7Bjwy6dsHTAuExngUR/pJ7O3zVsMMMokn35sAdj
 5ii1e2aCTChdtF4PNBJWnxa7JN5N4VP6yyN8uaXgSJejGRKjBQn1+7axIOcOlnGenM
 iewYjQfhE9N9NrAUviErmbePVXQjGR/XFGPC1JYY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com,
	qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH v3 09/10] chardev: rework filename handling
Date: Thu, 15 Jan 2026 17:46:03 +0300
Message-ID: <20260115144606.233252-10-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115144606.233252-1-vsementsov@yandex-team.ru>
References: <20260115144606.233252-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Instead of checking, did backend set the filename state or not, let's
be stateless: filename is needed rarely, so, let's just have a generic
function (with optional implementation by backends) to get it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 chardev/char-pty.c     |  8 +++++++-
 chardev/char-socket.c  | 31 ++++++++++++-------------------
 chardev/char.c         | 22 ++++++++++++++++------
 hw/misc/ivshmem-pci.c  |  4 ++--
 include/chardev/char.h |  5 ++++-
 5 files changed, 41 insertions(+), 29 deletions(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 047aade09e..7e95132cdb 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -351,7 +351,6 @@ static bool pty_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
         return false;
     }
 
-    chr->filename = g_strdup_printf("pty:%s", s->pty_name);
     qemu_printf("char device redirected to %s (label %s)\n",
                 s->pty_name, chr->label);
 
@@ -393,6 +392,12 @@ static char *pty_chr_get_pty_name(Chardev *chr)
     return g_strdup(s->pty_name);
 }
 
+static char *pty_chr_get_filename(Chardev *chr)
+{
+    PtyChardev *s = PTY_CHARDEV(chr);
+    return g_strdup_printf("pty:%s", s->pty_name);
+}
+
 static void char_pty_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
@@ -403,6 +408,7 @@ static void char_pty_class_init(ObjectClass *oc, const void *data)
     cc->chr_update_read_handler = pty_chr_update_read_handler;
     cc->chr_add_watch = pty_chr_add_watch;
     cc->chr_get_pty_name = pty_chr_get_pty_name;
+    cc->chr_get_filename = pty_chr_get_filename;
 }
 
 static const TypeInfo char_pty_type_info = {
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 908bbdbc12..5adeb90865 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -40,6 +40,7 @@
 
 static gboolean socket_reconnect_timeout(gpointer opaque);
 static void tcp_chr_telnet_init(Chardev *chr);
+static char *qemu_chr_compute_filename(SocketChardev *s);
 
 static void tcp_chr_change_state(SocketChardev *s, TCPChardevState state)
 {
@@ -384,8 +385,6 @@ static void tcp_chr_free_connection(Chardev *chr)
     s->sioc = NULL;
     object_unref(OBJECT(s->ioc));
     s->ioc = NULL;
-    g_free(chr->filename);
-    chr->filename = NULL;
     tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
 }
 
@@ -439,16 +438,17 @@ static char *qemu_chr_socket_address(SocketChardev *s, const char *prefix)
     }
 }
 
-static void update_disconnected_filename(SocketChardev *s)
+static char *tcp_chr_get_filename(Chardev *chr)
 {
-    Chardev *chr = CHARDEV(s);
+    SocketChardev *s = SOCKET_CHARDEV(chr);
 
-    g_free(chr->filename);
-    if (s->addr) {
-        chr->filename = qemu_chr_socket_address(s, "disconnected:");
-    } else {
-        chr->filename = g_strdup("disconnected:socket");
+    if (s->state == TCP_CHARDEV_STATE_CONNECTED) {
+        return qemu_chr_compute_filename(s);
+    } else if (s->addr) {
+        return qemu_chr_socket_address(s, "disconnected:");
     }
+
+    return g_strdup("disconnected:socket");
 }
 
 /* NB may be called even if tcp_chr_connect has not been
@@ -468,7 +468,6 @@ static void tcp_chr_disconnect_locked(Chardev *chr)
         qio_net_listener_set_client_func_full(s->listener, tcp_chr_accept,
                                               chr, NULL, chr->gcontext);
     }
-    update_disconnected_filename(s);
     if (emit_close) {
         qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
     }
@@ -639,9 +638,6 @@ static void tcp_chr_connect(void *opaque)
     Chardev *chr = CHARDEV(opaque);
     SocketChardev *s = SOCKET_CHARDEV(opaque);
 
-    g_free(chr->filename);
-    chr->filename = qemu_chr_compute_filename(s);
-
     tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTED);
     update_ioc_handlers(s);
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
@@ -1000,8 +996,8 @@ static void tcp_chr_accept_server_sync(Chardev *chr)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
     QIOChannelSocket *sioc;
-    info_report("QEMU waiting for connection on: %s",
-                chr->filename);
+    g_autofree char *filename = qemu_chr_get_filename(chr);
+    info_report("QEMU waiting for connection on: %s", filename);
     tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     sioc = qio_net_listener_wait_client(s->listener);
     tcp_chr_set_client_ioc_name(chr, sioc);
@@ -1258,8 +1254,6 @@ static int qmp_chardev_open_socket_server(Chardev *chr,
     s->addr = qio_net_listener_get_local_address(s->listener, 0, errp);
 
 skip_listen:
-    update_disconnected_filename(s);
-
     if (is_waitconnect) {
         tcp_chr_accept_server_sync(chr);
     } else {
@@ -1436,8 +1430,6 @@ static bool tcp_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
     }
     s->registered_yank = true;
 
-    update_disconnected_filename(s);
-
     if (s->is_listen) {
         if (qmp_chardev_open_socket_server(chr, is_telnet || is_tn3270,
                                            is_waitconnect, errp) < 0) {
@@ -1593,6 +1585,7 @@ static void char_socket_class_init(ObjectClass *oc, const void *data)
     cc->chr_add_watch = tcp_chr_add_watch;
     cc->chr_update_read_handler = tcp_chr_update_read_handler;
     cc->chr_listener_cleanup = tcp_chr_listener_cleanup;
+    cc->chr_get_filename = tcp_chr_get_filename;
 
     object_class_property_add(oc, "addr", "SocketAddress",
                               char_socket_get_addr, NULL,
diff --git a/chardev/char.c b/chardev/char.c
index 0dc792b88f..ef0cdffd3f 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -309,7 +309,6 @@ static void char_finalize(Object *obj)
     if (chr->fe) {
         chr->fe->chr = NULL;
     }
-    g_free(chr->filename);
     g_free(chr->label);
     if (chr->logfd != -1) {
         close(chr->logfd);
@@ -796,7 +795,7 @@ static int qmp_query_chardev_foreach(Object *obj, void *data)
     ChardevInfo *value = g_malloc0(sizeof(*value));
 
     value->label = g_strdup(chr->label);
-    value->filename = g_strdup(chr->filename);
+    value->filename = qemu_chr_get_filename(chr);
     value->frontend_open = chr->fe && chr->fe->fe_is_open;
 
     QAPI_LIST_PREPEND(*list, value);
@@ -1025,10 +1024,6 @@ static Chardev *chardev_new(const char *id, const char *typename,
         return NULL;
     }
 
-    if (!chr->filename) {
-        chr->filename = g_strdup(typename + 8);
-    }
-
     return chr;
 }
 
@@ -1110,6 +1105,21 @@ char *qemu_chr_get_pty_name(Chardev *chr)
     return NULL;
 }
 
+char *qemu_chr_get_filename(Chardev *chr)
+{
+    ChardevClass *cc = CHARDEV_GET_CLASS(chr);
+    const char *typename;
+
+    if (cc->chr_get_filename) {
+        return cc->chr_get_filename(chr);
+    }
+
+    typename = object_get_typename(OBJECT(chr));
+    assert(g_str_has_prefix(typename, "chardev-"));
+    return g_strdup(typename + 8);
+}
+
+
 ChardevReturn *qmp_chardev_change(const char *id, ChardevBackend *backend,
                                   Error **errp)
 {
diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
index b9162589a0..bf05688065 100644
--- a/hw/misc/ivshmem-pci.c
+++ b/hw/misc/ivshmem-pci.c
@@ -873,10 +873,10 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
         host_memory_backend_set_mapped(s->hostmem, true);
     } else {
         Chardev *chr = qemu_chr_fe_get_driver(&s->server_chr);
+        char *filename = qemu_chr_get_filename(chr);
         assert(chr);
 
-        IVSHMEM_DPRINTF("using shared memory server (socket = %s)\n",
-                        chr->filename);
+        IVSHMEM_DPRINTF("using shared memory server (socket = %s)\n", filename);
 
         /* we allocate enough space for 16 peers and grow as needed */
         resize_peers(s, 16);
diff --git a/include/chardev/char.h b/include/chardev/char.h
index ada5529fa6..81bc0cbdf2 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -62,7 +62,6 @@ struct Chardev {
     QemuMutex chr_write_lock;
     CharFrontend *fe;
     char *label;
-    char *filename;
     int logfd;
     int be_open;
     /* used to coordinate the chardev-change special-case: */
@@ -309,6 +308,9 @@ struct ChardevClass {
 
     /* return PTY name if available */
     char *(*chr_get_pty_name)(Chardev *s);
+
+    /* get filename for reporting */
+    char *(*chr_get_filename)(Chardev *s);
 };
 
 Chardev *qemu_chardev_new(const char *id, const char *typename,
@@ -324,5 +326,6 @@ void suspend_mux_open(void);
 void resume_mux_open(void);
 
 char *qemu_chr_get_pty_name(Chardev *chr);
+char *qemu_chr_get_filename(Chardev *chr);
 
 #endif
-- 
2.52.0


