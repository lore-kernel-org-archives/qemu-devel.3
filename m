Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A15E7FDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn12x-00014F-G1; Mon, 02 Feb 2026 16:01:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn12Q-0000cL-4C; Mon, 02 Feb 2026 16:01:01 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn12O-0004FH-9R; Mon, 02 Feb 2026 16:00:49 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7DFA51851A4;
 Mon, 02 Feb 2026 23:57:53 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4775235B31B;
 Mon, 02 Feb 2026 23:58:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jie Song <songjie_yewu@cmss.chinamobile.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.4 24/74] monitor/qmp: cleanup SocketChardev listener
 sources early to avoid fd handling race
Date: Mon,  2 Feb 2026 23:57:35 +0300
Message-ID: <20260202205833.941615-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
References: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Jie Song <songjie_yewu@cmss.chinamobile.com>

When starting a dummy QEMU process with virsh version, monitor_init_qmp()
enables IOThread monitoring of the QMP fd by default. However, a race
condition exists during the initialization phase: the IOThread only removes
the main thread's fd watch when it reaches qio_net_listener_set_client_func_full(),
which may be delayed under high system load.

This creates a window between monitor_qmp_setup_handlers_bh() and
qio_net_listener_set_client_func_full() where both the main thread and
IOThread are simultaneously monitoring the same fd and processing events.
This race can cause either the main thread or the IOThread to hang and
become unresponsive.

Fix this by proactively cleaning up the listener's IO sources in
monitor_init_qmp() before the IOThread initializes QMP monitoring,
ensuring exclusive fd ownership and eliminating the race condition.

Signed-off-by: Jie Song <songjie_yewu@cmss.chinamobile.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20251125140706.114197-1-mail@jiesong.me>
(cherry picked from commit e714f1a3d4d1e66b9a3ff4be1ff999c32bbef29e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/chardev/char-io.c b/chardev/char-io.c
index 3be17b51ca..beac5cd245 100644
--- a/chardev/char-io.c
+++ b/chardev/char-io.c
@@ -182,3 +182,11 @@ int io_channel_send(QIOChannel *ioc, const void *buf, size_t len)
 {
     return io_channel_send_full(ioc, buf, len, NULL, 0);
 }
+
+void remove_listener_fd_in_watch(Chardev *chr)
+{
+    ChardevClass *cc = CHARDEV_GET_CLASS(chr);
+    if (cc->chr_listener_cleanup) {
+        cc->chr_listener_cleanup(chr);
+    }
+}
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 1e8313915b..a52a47a25c 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1581,6 +1581,15 @@ char_socket_get_connected(Object *obj, Error **errp)
     return s->state == TCP_CHARDEV_STATE_CONNECTED;
 }
 
+static void tcp_chr_listener_cleanup(Chardev *chr)
+{
+    SocketChardev *s = SOCKET_CHARDEV(chr);
+    if (s->listener) {
+        qio_net_listener_set_client_func_full(s->listener, NULL, NULL,
+                                              NULL, chr->gcontext);
+    }
+}
+
 static void char_socket_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
@@ -1598,6 +1607,7 @@ static void char_socket_class_init(ObjectClass *oc, const void *data)
     cc->chr_add_client = tcp_chr_add_client;
     cc->chr_add_watch = tcp_chr_add_watch;
     cc->chr_update_read_handler = tcp_chr_update_read_handler;
+    cc->chr_listener_cleanup = tcp_chr_listener_cleanup;
 
     object_class_property_add(oc, "addr", "SocketAddress",
                               char_socket_get_addr, NULL,
diff --git a/include/chardev/char-io.h b/include/chardev/char-io.h
index ac379ea70e..540131346d 100644
--- a/include/chardev/char-io.h
+++ b/include/chardev/char-io.h
@@ -43,4 +43,6 @@ int io_channel_send(QIOChannel *ioc, const void *buf, size_t len);
 int io_channel_send_full(QIOChannel *ioc, const void *buf, size_t len,
                          int *fds, size_t nfds);
 
+void remove_listener_fd_in_watch(Chardev *chr);
+
 #endif /* CHAR_IO_H */
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 429852f8d9..c57f4b7329 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -307,6 +307,8 @@ struct ChardevClass {
 
     /* handle various events */
     void (*chr_be_event)(Chardev *s, QEMUChrEvent event);
+
+    void (*chr_listener_cleanup)(Chardev *chr);
 };
 
 Chardev *qemu_chardev_new(const char *id, const char *typename,
diff --git a/monitor/qmp.c b/monitor/qmp.c
index cb99a12d94..7ae070dc8d 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -537,6 +537,11 @@ void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
          * e.g. the chardev is in client mode, with wait=on.
          */
         remove_fd_in_watch(chr);
+        /*
+         * Clean up listener IO sources early to prevent racy fd
+         * handling between the main thread and the I/O thread.
+         */
+        remove_listener_fd_in_watch(chr);
         /*
          * We can't call qemu_chr_fe_set_handlers() directly here
          * since chardev might be running in the monitor I/O
-- 
2.47.3


