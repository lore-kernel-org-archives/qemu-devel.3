Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499A7CCD18D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 13:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8IlL-0006eU-Hm; Mon, 13 Oct 2025 09:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8IlJ-0006dW-Au
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:38:53 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8IlC-0006az-Kw
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:38:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id D883A80871;
 Mon, 13 Oct 2025 16:38:44 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a50::1:2a])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ccOm1D2F0Cg0-1xuDBwId; Mon, 13 Oct 2025 16:38:44 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760362724;
 bh=06Uu2iVsnsapITxTvvSPPGPFljkUJPRyJShRcyWyILA=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=FT/gNPaIic/2RMEkG1V+FQrABzBmuGJ5q30bJyrDo2d3lgOjeg4hIKpmXwON6sRof
 yFEeWI8aTpBPUACsCMJ3bxrdsxgIBLvny4MLOvh8q7ZzWeZ/ghebpNDcDtT6iYcE5O
 ydwgIApppXDbbTTonoQMNXWtGvG8qxcTOw1LP8vs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, raphael@enfabrica.net,
 armbru@redhat.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Subject: [PATCH v2 6/7] chardev/char-socket: move to .init + .connect api
Date: Mon, 13 Oct 2025 16:38:35 +0300
Message-ID: <20251013133836.852018-7-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251013133836.852018-1-vsementsov@yandex-team.ru>
References: <20251013133836.852018-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Move char-socket to new API. This will help to realize backend-transfer
feature for vhost-user-blk.

With this commit qemu_chr_fe_init() starts to do connecting, so we
should handle its errors instead of passing &error_abort.

Also, move qemu_chr_fe_init() in test-char.c, to trigger connect
before trying to get address.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 chardev/char-socket.c         | 55 ++++++++++++++++++++---------------
 chardev/char.c                |  7 +++--
 include/chardev/char-socket.h |  1 +
 tests/unit/test-char.c        | 14 ++++-----
 ui/dbus-chardev.c             | 12 ++++++--
 5 files changed, 54 insertions(+), 35 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index f3bc6290d2..0a5738c158 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1287,6 +1287,25 @@ static int qmp_chardev_open_socket_client(Chardev *chr,
 }
 
 
+static bool char_socket_connect(Chardev *chr, Error **errp)
+{
+    SocketChardev *s = SOCKET_CHARDEV(chr);
+
+    if (s->is_listen) {
+        if (qmp_chardev_open_socket_server(chr, s->is_telnet || s->is_tn3270,
+                                           s->is_waitconnect, errp) < 0) {
+            return false;
+        }
+    } else {
+        if (qmp_chardev_open_socket_client(chr, errp) < 0) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+
 static bool qmp_chardev_validate_socket(ChardevSocket *sock,
                                         SocketAddress *addr,
                                         Error **errp)
@@ -1363,10 +1382,9 @@ static bool qmp_chardev_validate_socket(ChardevSocket *sock,
 }
 
 
-static void qmp_chardev_open_socket(Chardev *chr,
-                                    ChardevBackend *backend,
-                                    bool *be_opened,
-                                    Error **errp)
+static bool char_socket_init(Chardev *chr,
+                             ChardevBackend *backend,
+                             Error **errp)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
     ChardevSocket *sock = backend->u.socket.data;
@@ -1374,7 +1392,6 @@ static void qmp_chardev_open_socket(Chardev *chr,
     bool is_listen      = sock->has_server  ? sock->server  : true;
     bool is_telnet      = sock->has_telnet  ? sock->telnet  : false;
     bool is_tn3270      = sock->has_tn3270  ? sock->tn3270  : false;
-    bool is_waitconnect = sock->has_wait    ? sock->wait    : false;
     bool is_websock     = sock->has_websocket ? sock->websocket : false;
     SocketAddress *addr;
 
@@ -1383,6 +1400,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
     s->is_tn3270 = is_tn3270;
     s->is_websock = is_websock;
     s->do_nodelay = do_nodelay;
+    s->is_waitconnect = sock->has_wait ? sock->wait : false;
     s->reconnect_time_ms = sock->has_reconnect_ms ? sock->reconnect_ms : 0;
 
     if (sock->tls_creds) {
@@ -1392,7 +1410,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
         if (!creds) {
             error_setg(errp, "No TLS credentials with id '%s'",
                        sock->tls_creds);
-            return;
+            return false;
         }
         s->tls_creds = (QCryptoTLSCreds *)
             object_dynamic_cast(creds,
@@ -1400,7 +1418,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
         if (!s->tls_creds) {
             error_setg(errp, "Object with id '%s' is not TLS credentials",
                        sock->tls_creds);
-            return;
+            return false;
         }
         object_ref(OBJECT(s->tls_creds));
         if (!qcrypto_tls_creds_check_endpoint(s->tls_creds,
@@ -1408,7 +1426,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
                                           ? QCRYPTO_TLS_CREDS_ENDPOINT_SERVER
                                           : QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT,
                                           errp)) {
-            return;
+            return false;
         }
     }
     s->tls_authz = g_strdup(sock->tls_authz);
@@ -1416,7 +1434,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
     s->addr = addr = socket_address_flatten(sock->addr);
 
     if (!qmp_chardev_validate_socket(sock, addr, errp)) {
-        return;
+        return false;
     }
 
     qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_RECONNECTABLE);
@@ -1433,26 +1451,14 @@ static void qmp_chardev_open_socket(Chardev *chr,
      */
     if (!chr->handover_yank_instance) {
         if (!yank_register_instance(CHARDEV_YANK_INSTANCE(chr->label), errp)) {
-            return;
+            return false;
         }
     }
     s->registered_yank = true;
 
-    /* be isn't opened until we get a connection */
-    *be_opened = false;
-
     update_disconnected_filename(s);
 
-    if (s->is_listen) {
-        if (qmp_chardev_open_socket_server(chr, is_telnet || is_tn3270,
-                                           is_waitconnect, errp) < 0) {
-            return;
-        }
-    } else {
-        if (qmp_chardev_open_socket_client(chr, errp) < 0) {
-            return;
-        }
-    }
+    return true;
 }
 
 static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
@@ -1576,7 +1582,8 @@ static void char_socket_class_init(ObjectClass *oc, const void *data)
     cc->supports_yank = true;
 
     cc->parse = qemu_chr_parse_socket;
-    cc->open = qmp_chardev_open_socket;
+    cc->init = char_socket_init;
+    cc->connect = char_socket_connect;
     cc->chr_wait_connected = tcp_chr_wait_connected;
     cc->chr_write = tcp_chr_write;
     cc->chr_sync_read = tcp_chr_sync_read;
diff --git a/chardev/char.c b/chardev/char.c
index 01ffe37acf..4d151f537c 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -1221,12 +1221,15 @@ ChardevReturn *qmp_chardev_change(const char *id, ChardevBackend *backend,
     }
 
     chr->be = NULL;
-    qemu_chr_fe_init(be, chr_new, &error_abort);
+    if (!qemu_chr_fe_init(be, chr_new, errp)) {
+        object_unref(OBJECT(chr_new));
+        return NULL;
+    }
 
     if (be->chr_be_change(be->opaque) < 0) {
         error_setg(errp, "Chardev '%s' change failed", chr_new->label);
         chr_new->be = NULL;
-        qemu_chr_fe_init(be, chr, &error_abort);
+        qemu_chr_fe_init(be, chr, NULL);
         if (closed_sent) {
             qemu_chr_be_event(chr, CHR_EVENT_OPENED);
         }
diff --git a/include/chardev/char-socket.h b/include/chardev/char-socket.h
index d6d13ad37f..0109727eaa 100644
--- a/include/chardev/char-socket.h
+++ b/include/chardev/char-socket.h
@@ -68,6 +68,7 @@ struct SocketChardev {
     bool is_listen;
     bool is_telnet;
     bool is_tn3270;
+    bool is_waitconnect;
     GSource *telnet_source;
     TCPChardevTelnetInit *telnet_init;
 
diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
index f30a39f61f..5c9482a478 100644
--- a/tests/unit/test-char.c
+++ b/tests/unit/test-char.c
@@ -845,6 +845,7 @@ static void char_websock_test(void)
                               0xef, 0xaa, 0xc5, 0x97, /* Masking key */
                               0xec, 0x42              /* Status code */ };
 
+    qemu_chr_fe_init(&be, chr, &error_abort);
     addr = object_property_get_qobject(OBJECT(chr), "addr", &error_abort);
     qdict = qobject_to(QDict, addr);
     port = qdict_get_str(qdict, "port");
@@ -852,7 +853,6 @@ static void char_websock_test(void)
     handshake_port = g_strdup_printf(handshake, port, port);
     qobject_unref(qdict);
 
-    qemu_chr_fe_init(&be, chr, &error_abort);
     qemu_chr_fe_set_handlers(&be, websock_server_can_read, websock_server_read,
                              NULL, NULL, chr, NULL, true);
 
@@ -1216,6 +1216,8 @@ static void char_socket_server_test(gconstpointer opaque)
     g_assert_nonnull(chr);
     g_assert(!object_property_get_bool(OBJECT(chr), "connected", &error_abort));
 
+    qemu_chr_fe_init(&be, chr, &error_abort);
+
     qaddr = object_property_get_qobject(OBJECT(chr), "addr", &error_abort);
     g_assert_nonnull(qaddr);
 
@@ -1224,8 +1226,6 @@ static void char_socket_server_test(gconstpointer opaque)
     visit_free(v);
     qobject_unref(qaddr);
 
-    qemu_chr_fe_init(&be, chr, &error_abort);
-
  reconnect:
     data.event = -1;
     data.be = &be;
@@ -1417,6 +1417,8 @@ static void char_socket_client_test(gconstpointer opaque)
     qemu_opts_del(opts);
     g_assert_nonnull(chr);
 
+    qemu_chr_fe_init(&be, chr, &error_abort);
+
     if (config->reconnect) {
         /*
          * If reconnect is set, the connection will be
@@ -1431,8 +1433,6 @@ static void char_socket_client_test(gconstpointer opaque)
                                           &error_abort));
     }
 
-    qemu_chr_fe_init(&be, chr, &error_abort);
-
  reconnect:
     data.event = -1;
     data.be = &be;
@@ -1550,6 +1550,8 @@ static void char_socket_server_two_clients_test(gconstpointer opaque)
     g_assert_nonnull(chr);
     g_assert(!object_property_get_bool(OBJECT(chr), "connected", &error_abort));
 
+    qemu_chr_fe_init(&be, chr, &error_abort);
+
     qaddr = object_property_get_qobject(OBJECT(chr), "addr", &error_abort);
     g_assert_nonnull(qaddr);
 
@@ -1558,8 +1560,6 @@ static void char_socket_server_two_clients_test(gconstpointer opaque)
     visit_free(v);
     qobject_unref(qaddr);
 
-    qemu_chr_fe_init(&be, chr, &error_abort);
-
     qemu_chr_fe_set_handlers(&be, char_socket_can_read, char_socket_discard_read,
                              count_closed_event, NULL,
                              &closed, NULL, true);
diff --git a/ui/dbus-chardev.c b/ui/dbus-chardev.c
index d05dddaf81..23cf9d6ee9 100644
--- a/ui/dbus-chardev.c
+++ b/ui/dbus-chardev.c
@@ -210,8 +210,14 @@ dbus_chr_open(Chardev *chr, ChardevBackend *backend,
     if (*errp) {
         return;
     }
-    CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKET))->open(
-        chr, be, be_opened, errp);
+    if (!CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKET))->init(
+        chr, be, errp)) {
+        return;
+    }
+    if (!CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKET))->connect(
+        chr, errp)) {
+        return;
+    }
 }
 
 static void
@@ -276,6 +282,8 @@ char_dbus_class_init(ObjectClass *oc, const void *data)
 
     cc->parse = dbus_chr_parse;
     cc->open = dbus_chr_open;
+    cc->init = NULL;
+    cc->connect = NULL;
     cc->chr_set_fe_open = dbus_chr_set_fe_open;
     cc->chr_set_echo = dbus_chr_set_echo;
     klass->parent_chr_be_event = cc->chr_be_event;
-- 
2.48.1


