Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DFEEEA860
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 09:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqpoq-0007TT-L6; Fri, 13 Feb 2026 04:50:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vqpoh-00077A-Oq
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 04:50:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vqpob-0007KM-Up
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 04:50:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770976221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NawPSV0+R7Z6iBTNYDG41PH3COFdnG/VW+iZ15ECL/g=;
 b=hMOvy3uyQGFRNGiO0tP2eqVKtTfPFsvxr6cTbleSYm0UVAn82IdM+70MBfa8h8hbbPqKnf
 IAvYBqvcAk1o6ptKHBrlFa2lFDMgoPGme3q2CEDbZ+uxfPzORJrXDFVNmf00YCehdJxdd5
 nGUeLO5EIfW4Uyk8qJOI14bCGS9wVBc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433--Y17YsGYPkOtZeaIxLcQjw-1; Fri,
 13 Feb 2026 04:50:17 -0500
X-MC-Unique: -Y17YsGYPkOtZeaIxLcQjw-1
X-Mimecast-MFC-AGG-ID: -Y17YsGYPkOtZeaIxLcQjw_1770976216
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFF8419560AA; Fri, 13 Feb 2026 09:50:15 +0000 (UTC)
Received: from localhost (unknown [10.44.22.41])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 435E71955D85; Fri, 13 Feb 2026 09:50:14 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paul Durrant <paul@xen.org>, Anthony PERARD <anthony@xenproject.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL v2 10/15] chardev: rework filename handling
Date: Fri, 13 Feb 2026 10:49:29 +0100
Message-ID: <20260213094938.4074478-11-marcandre.lureau@redhat.com>
In-Reply-To: <20260213094938.4074478-1-marcandre.lureau@redhat.com>
References: <20260213094938.4074478-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Instead of checking, did backend set the filename state or not, let's
be stateless: filename is needed rarely, so, let's just have a generic
function (with optional implementation by backends) to get it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
[ Marc-André - fix leak in ivshmem-pci.c ]
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260115144606.233252-10-vsementsov@yandex-team.ru>
---
 include/chardev/char.h |  5 ++++-
 chardev/char-pty.c     |  8 +++++++-
 chardev/char-socket.c  | 31 ++++++++++++-------------------
 chardev/char.c         | 21 +++++++++++++++------
 hw/misc/ivshmem-pci.c  |  7 ++++---
 5 files changed, 42 insertions(+), 30 deletions(-)

diff --git a/include/chardev/char.h b/include/chardev/char.h
index ada5529fa6c..81bc0cbdf2a 100644
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
diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 047aade09e5..7e95132cdbb 100644
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
index 908bbdbc124..5adeb908659 100644
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
index 0dc792b88f7..3373c9b61f8 100644
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
 
@@ -1110,6 +1105,20 @@ char *qemu_chr_get_pty_name(Chardev *chr)
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
 ChardevReturn *qmp_chardev_change(const char *id, ChardevBackend *backend,
                                   Error **errp)
 {
diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
index b9162589a02..a3a43f53bd1 100644
--- a/hw/misc/ivshmem-pci.c
+++ b/hw/misc/ivshmem-pci.c
@@ -873,10 +873,11 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
         host_memory_backend_set_mapped(s->hostmem, true);
     } else {
         Chardev *chr = qemu_chr_fe_get_driver(&s->server_chr);
-        assert(chr);
+        g_autofree char *filename = NULL;
 
-        IVSHMEM_DPRINTF("using shared memory server (socket = %s)\n",
-                        chr->filename);
+        assert(chr);
+        filename = qemu_chr_get_filename(chr);
+        IVSHMEM_DPRINTF("using shared memory server (socket = %s)\n", filename);
 
         /* we allocate enough space for 16 peers and grow as needed */
         resize_peers(s, 16);
-- 
2.52.0


