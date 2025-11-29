Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0C2D116EA
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Nov 2025 13:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPLFl-0005QS-H0; Sat, 29 Nov 2025 08:44:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vPLFZ-0005OL-Iw
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 08:44:34 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vPLFW-0002Yb-DH
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 08:44:32 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 23EE08084E;
 Sat, 29 Nov 2025 16:44:29 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:891::1:b])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Iigm2k0FK8c0-THaXbO3L; Sat, 29 Nov 2025 16:44:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764423868;
 bh=CL6qFPwQoeSNpg/HvJgiM8hNjV5gKvEi8vUGkDkQQc4=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Ksah5/JNgU6NuaZe0f++8NSGcV+mrjt6EmWrSq0kmPcIlMdkcgcXuNUjnXki2mgRW
 ti6NG0xh3O687q87cTrBUBNT3aYaNYM+mKWqzqeqTIWmeNAneVYeADjdXl6nx5YHQk
 AHgVehZl7x4EkRC2qv/t1iRTHxX9xWgW3+JWOkCc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH 7/8] chardev: rework filename handling
Date: Sat, 29 Nov 2025 16:43:47 +0300
Message-ID: <20251129134350.487839-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129134350.487839-1-vsementsov@yandex-team.ru>
References: <20251129134350.487839-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

We have the following flaws with it:

1. Layring violation by modifying generic state directly in backends

2. Tricky generic logic: we should check, did backend set the
generic state field, and fill it when not.

Let's fix them all by making filename a private field with getter
and setter. And move the "default logic" into getter.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 chardev/char-pty.c     |  4 +++-
 chardev/char-socket.c  | 17 ++++++++---------
 chardev/char.c         |  8 ++------
 hw/misc/ivshmem-pci.c  |  4 ++--
 include/chardev/char.h | 21 ++++++++++++++++++++-
 5 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 047aade09e..f4294679be 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -336,6 +336,7 @@ static bool pty_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
     int master_fd, slave_fd;
     char *name;
     char *path = backend->u.pty.data->path;
+    g_autofree char *filename = NULL;
 
     s = PTY_CHARDEV(chr);
 
@@ -351,7 +352,8 @@ static bool pty_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
         return false;
     }
 
-    chr->filename = g_strdup_printf("pty:%s", s->pty_name);
+    filename = g_strdup_printf("pty:%s", s->pty_name);
+    qemu_chr_set_filename(chr, filename);
     qemu_printf("char device redirected to %s (label %s)\n",
                 s->pty_name, chr->label);
 
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 31c9acd164..9387760009 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -384,8 +384,7 @@ static void tcp_chr_free_connection(Chardev *chr)
     s->sioc = NULL;
     object_unref(OBJECT(s->ioc));
     s->ioc = NULL;
-    g_free(chr->filename);
-    chr->filename = NULL;
+    qemu_chr_set_filename(chr, NULL);
     tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
 }
 
@@ -443,11 +442,11 @@ static void update_disconnected_filename(SocketChardev *s)
 {
     Chardev *chr = CHARDEV(s);
 
-    g_free(chr->filename);
     if (s->addr) {
-        chr->filename = qemu_chr_socket_address(s, "disconnected:");
+        g_autofree char *filename = qemu_chr_socket_address(s, "disconnected:");
+        qemu_chr_set_filename(chr, filename);
     } else {
-        chr->filename = g_strdup("disconnected:socket");
+        qemu_chr_set_filename(chr, "disconnected:socket");
     }
 }
 
@@ -638,9 +637,9 @@ static void tcp_chr_connect(void *opaque)
 {
     Chardev *chr = CHARDEV(opaque);
     SocketChardev *s = SOCKET_CHARDEV(opaque);
+    g_autofree char *filename = qemu_chr_compute_filename(s);
 
-    g_free(chr->filename);
-    chr->filename = qemu_chr_compute_filename(s);
+    qemu_chr_set_filename(chr, filename);
 
     tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTED);
     update_ioc_handlers(s);
@@ -1000,8 +999,8 @@ static void tcp_chr_accept_server_sync(Chardev *chr)
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
diff --git a/chardev/char.c b/chardev/char.c
index 0dc792b88f..bdd907f015 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -309,7 +309,7 @@ static void char_finalize(Object *obj)
     if (chr->fe) {
         chr->fe->chr = NULL;
     }
-    g_free(chr->filename);
+    qemu_chr_set_filename(chr, NULL);
     g_free(chr->label);
     if (chr->logfd != -1) {
         close(chr->logfd);
@@ -796,7 +796,7 @@ static int qmp_query_chardev_foreach(Object *obj, void *data)
     ChardevInfo *value = g_malloc0(sizeof(*value));
 
     value->label = g_strdup(chr->label);
-    value->filename = g_strdup(chr->filename);
+    value->filename = qemu_chr_get_filename(chr);
     value->frontend_open = chr->fe && chr->fe->fe_is_open;
 
     QAPI_LIST_PREPEND(*list, value);
@@ -1025,10 +1025,6 @@ static Chardev *chardev_new(const char *id, const char *typename,
         return NULL;
     }
 
-    if (!chr->filename) {
-        chr->filename = g_strdup(typename + 8);
-    }
-
     return chr;
 }
 
diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
index 636d0b83de..2c7b987241 100644
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
index d36e50b99e..ffeb4a4e3b 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -62,7 +62,7 @@ struct Chardev {
     QemuMutex chr_write_lock;
     CharFrontend *fe;
     char *label;
-    char *filename;
+    char *_filename;
     int logfd;
     int be_open;
     /* used to coordinate the chardev-change special-case: */
@@ -72,6 +72,25 @@ struct Chardev {
     DECLARE_BITMAP(features, QEMU_CHAR_FEATURE_LAST);
 };
 
+static inline char *qemu_chr_get_filename(Chardev *chr)
+{
+    const char *typename;
+
+    if (chr->_filename) {
+        return g_strdup(chr->_filename);
+    }
+
+    typename = object_get_typename(OBJECT(chr));
+    assert(g_str_has_prefix(typename, "chardev-"));
+    return g_strdup(typename + 8);
+}
+
+static inline void qemu_chr_set_filename(Chardev *chr, const char *filename)
+{
+    g_free(chr->_filename);
+    chr->_filename = g_strdup(filename);
+}
+
 /**
  * qemu_chr_new_from_opts:
  * @opts: see qemu-config.c for a list of valid options
-- 
2.48.1


