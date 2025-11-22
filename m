Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C7ACFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd4F-0002Vl-Dp; Fri, 21 Nov 2025 21:09:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@jiesong.me>) id 1vMclI-0001MX-Rh
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:50:04 -0500
Received: from out28-66.mail.aliyun.com ([115.124.28.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@jiesong.me>) id 1vMcjH-0005Ds-0I
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:50:01 -0500
Received: from Sun.localdomain(mailfrom:mail@jiesong.me
 fp:SMTPD_---.fT0U-1w_1763776042 cluster:ay29) by smtp.aliyun-inc.com;
 Sat, 22 Nov 2025 09:47:27 +0800
From: Jie Song <mail@jiesong.me>
To: eblake@redhat.com, armbru@redhat.com, berrange@redhat.com,
 qemu-devel@nongnu.org
Cc: mail@jiesong.me,
	songjie_yewu@cmss.chinamobile.com
Subject: [PATCH v3] monitor/qmp: cleanup SocketChardev listener sources early
 to avoid fd handling race
Date: Sat, 22 Nov 2025 09:46:56 +0800
Message-ID: <20251122014656.297693-1-mail@jiesong.me>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.66; envelope-from=mail@jiesong.me;
 helo=out28-66.mail.aliyun.com
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
---
Changes in v3:
- Use a more general method to fix the problem.
- Link to v2:
  https://lore.kernel.org/qemu-devel/20251117150142.131694-1-mail@jiesong.me/
- Link to v1:
  https://lore.kernel.org/qemu-devel/20251111150144.76751-1-mail@jiesong.me/
---
 chardev/char-io.c         | 8 ++++++++
 chardev/char-socket.c     | 9 +++++++++
 include/chardev/char-io.h | 2 ++
 include/chardev/char.h    | 2 ++
 monitor/qmp.c             | 5 +++++
 5 files changed, 26 insertions(+)

diff --git a/chardev/char-io.c b/chardev/char-io.c
index 3be17b51ca..998282e526 100644
--- a/chardev/char-io.c
+++ b/chardev/char-io.c
@@ -182,3 +182,11 @@ int io_channel_send(QIOChannel *ioc, const void *buf, size_t len)
 {
     return io_channel_send_full(ioc, buf, len, NULL, 0);
 }
+
+void remove_listaner_fd_in_watch(Chardev *chr)
+{
+    ChardevClass *cc = CHARDEV_GET_CLASS(chr);
+    if (cc->chr_listener_cleanup) {
+        cc->chr_listener_cleanup(chr);
+    }
+}
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 26d2f11202..39b3a76638 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1570,6 +1570,14 @@ char_socket_get_connected(Object *obj, Error **errp)
     return s->state == TCP_CHARDEV_STATE_CONNECTED;
 }
 
+static void tcp_chr_listener_cleanup(Chardev *chr)
+{
+    SocketChardev *s = SOCKET_CHARDEV(chr);
+    if (s->listener)
+        qio_net_listener_set_client_func_full(s->listener, NULL, NULL,
+                                              NULL, chr->gcontext);
+}
+
 static void char_socket_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
@@ -1587,6 +1595,7 @@ static void char_socket_class_init(ObjectClass *oc, const void *data)
     cc->chr_add_client = tcp_chr_add_client;
     cc->chr_add_watch = tcp_chr_add_watch;
     cc->chr_update_read_handler = tcp_chr_update_read_handler;
+    cc->chr_listener_cleanup = tcp_chr_listener_cleanup;
 
     object_class_property_add(oc, "addr", "SocketAddress",
                               char_socket_get_addr, NULL,
diff --git a/include/chardev/char-io.h b/include/chardev/char-io.h
index ac379ea70e..087a250c70 100644
--- a/include/chardev/char-io.h
+++ b/include/chardev/char-io.h
@@ -43,4 +43,6 @@ int io_channel_send(QIOChannel *ioc, const void *buf, size_t len);
 int io_channel_send_full(QIOChannel *ioc, const void *buf, size_t len,
                          int *fds, size_t nfds);
 
+void remove_listaner_fd_in_watch(Chardev *chr);
+
 #endif /* CHAR_IO_H */
diff --git a/include/chardev/char.h b/include/chardev/char.h
index b65e9981c1..192cad67d4 100644
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
index cb99a12d94..e2b1c49ed6 100644
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
+        remove_listaner_fd_in_watch(chr);
         /*
          * We can't call qemu_chr_fe_set_handlers() directly here
          * since chardev might be running in the monitor I/O
-- 
2.43.0


