Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED326CAC59C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 13:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy9AW-0001lC-H8; Mon, 15 Sep 2025 09:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uy9AM-0001gW-9X; Mon, 15 Sep 2025 09:22:47 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uy9A7-0006zF-UQ; Mon, 15 Sep 2025 09:22:44 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 5CDA9807F6;
 Mon, 15 Sep 2025 16:22:25 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:130::1:7])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id GMPC4o1FuGk0-SwGhUiqD; Mon, 15 Sep 2025 16:22:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757942544;
 bh=pyuFrVsIASANJ+N7QppBHO2Se495Z6bX5OmLVwFaQlA=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=LMOki59NEMjc2+srIQjRmcBwfvcnB7dO4YIxFU+Mvdl6XKkz+cMKJffSXIwOp50tb
 39WuI9Wt9rOxJhHn5PRvdcCDXTIn9d2lj5HfHkl7OQLKXszr2oD75srL0l9aD24cS5
 FKA6Rb8L70NDHj0LJ5xLQUc17NF2SrtzXCJQByrU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 vsementsov@yandex-team.ru, leiyang@redhat.com, marcandre.lureau@redhat.com,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Subject: [PATCH v3 08/13] util: drop qemu_socket_try_set_nonblock()
Date: Mon, 15 Sep 2025 16:22:05 +0300
Message-ID: <20250915132211.135095-9-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250915132211.135095-1-vsementsov@yandex-team.ru>
References: <20250915132211.135095-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Now we can use qemu_set_blocking() in these cases.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/sockets.h |  1 -
 net/dgram.c            | 12 +++---------
 net/socket.c           |  7 ++-----
 net/stream.c           |  9 +++------
 net/stream_data.c      | 10 ++++------
 util/oslib-posix.c     |  4 ----
 util/oslib-win32.c     |  9 ---------
 7 files changed, 12 insertions(+), 40 deletions(-)

diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index 6477f90b9e..9512fec514 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -47,7 +47,6 @@ ssize_t qemu_send_full(int s, const void *buf, size_t count)
 int socket_set_cork(int fd, int v);
 int socket_set_nodelay(int fd);
 void qemu_socket_set_block(int fd);
-int qemu_socket_try_set_nonblock(int fd);
 int socket_set_fast_reuse(int fd);
 
 #ifdef WIN32
diff --git a/net/dgram.c b/net/dgram.c
index fb9ded30df..baa126d514 100644
--- a/net/dgram.c
+++ b/net/dgram.c
@@ -287,7 +287,7 @@ static int net_dgram_mcast_init(NetClientState *peer,
                                 Error **errp)
 {
     NetDgramState *s;
-    int fd, ret;
+    int fd;
     struct sockaddr_in *saddr;
 
     if (remote->type != SOCKET_ADDRESS_TYPE_INET) {
@@ -335,11 +335,8 @@ static int net_dgram_mcast_init(NetClientState *peer,
                 g_free(saddr);
                 return -1;
             }
-            ret = qemu_socket_try_set_nonblock(fd);
-            if (ret < 0) {
+            if (!qemu_set_blocking(fd, false, errp)) {
                 g_free(saddr);
-                error_setg_errno(errp, -ret, "%s: Can't use file descriptor %d",
-                                 name, fd);
                 return -1;
             }
 
@@ -572,10 +569,7 @@ int net_init_dgram(const Netdev *netdev, const char *name,
         if (fd == -1) {
             return -1;
         }
-        ret = qemu_socket_try_set_nonblock(fd);
-        if (ret < 0) {
-            error_setg_errno(errp, -ret, "%s: Can't use file descriptor %d",
-                             name, fd);
+        if (!qemu_set_blocking(fd, false, errp)) {
             return -1;
         }
         dest_addr = NULL;
diff --git a/net/socket.c b/net/socket.c
index db25e3d9ae..1ad03fc9d4 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -718,7 +718,7 @@ int net_init_socket(const Netdev *netdev, const char *name,
     }
 
     if (sock->fd) {
-        int fd, ret, so_type;
+        int fd, so_type;
 
         fd = monitor_fd_param(monitor_cur(), sock->fd, errp);
         if (fd == -1) {
@@ -728,10 +728,7 @@ int net_init_socket(const Netdev *netdev, const char *name,
         if (so_type < 0) {
             return -1;
         }
-        ret = qemu_socket_try_set_nonblock(fd);
-        if (ret < 0) {
-            error_setg_errno(errp, -ret, "%s: Can't use file descriptor %d",
-                             name, fd);
+        if (!qemu_set_blocking(fd, false, errp)) {
             return -1;
         }
         switch (so_type) {
diff --git a/net/stream.c b/net/stream.c
index d893f02cab..94f823a2a7 100644
--- a/net/stream.c
+++ b/net/stream.c
@@ -138,7 +138,6 @@ static void net_stream_server_listening(QIOTask *task, gpointer opaque)
     NetStreamData *d = opaque;
     QIOChannelSocket *listen_sioc = QIO_CHANNEL_SOCKET(d->listen_ioc);
     SocketAddress *addr;
-    int ret;
     Error *err = NULL;
 
     if (qio_task_propagate_error(task, &err)) {
@@ -149,13 +148,11 @@ static void net_stream_server_listening(QIOTask *task, gpointer opaque)
 
     addr = qio_channel_socket_get_local_address(listen_sioc, NULL);
     g_assert(addr != NULL);
-    ret = qemu_socket_try_set_nonblock(listen_sioc->fd);
-    if (addr->type == SOCKET_ADDRESS_TYPE_FD && ret < 0) {
-        qemu_set_info_str(&d->nc, "can't use file descriptor %s (errno %d)",
-                          addr->u.fd.str, -ret);
+    if (!qemu_set_blocking(listen_sioc->fd, false, &err)) {
+        qemu_set_info_str(&d->nc, "error: %s", error_get_pretty(err));
+        error_free(err);
         return;
     }
-    g_assert(ret == 0);
     qapi_free_SocketAddress(addr);
 
     d->nc.link_down = true;
diff --git a/net/stream_data.c b/net/stream_data.c
index 5af27e0d1d..03740e9f73 100644
--- a/net/stream_data.c
+++ b/net/stream_data.c
@@ -12,6 +12,7 @@
 #include "net/net.h"
 #include "io/channel.h"
 #include "io/net-listener.h"
+#include "qemu/sockets.h"
 
 #include "stream_data.h"
 
@@ -154,7 +155,6 @@ int net_stream_data_client_connected(QIOTask *task, NetStreamData *d)
 {
     QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(d->ioc);
     SocketAddress *addr;
-    int ret;
     Error *err = NULL;
 
     if (qio_task_propagate_error(task, &err)) {
@@ -166,14 +166,12 @@ int net_stream_data_client_connected(QIOTask *task, NetStreamData *d)
     addr = qio_channel_socket_get_remote_address(sioc, NULL);
     g_assert(addr != NULL);
 
-    ret = qemu_socket_try_set_nonblock(sioc->fd);
-    if (addr->type == SOCKET_ADDRESS_TYPE_FD && ret < 0) {
-        qemu_set_info_str(&d->nc, "can't use file descriptor %s (errno %d)",
-                          addr->u.fd.str, -ret);
+    if (!qemu_set_blocking(sioc->fd, false, &err)) {
+        qemu_set_info_str(&d->nc, "error: %s", error_get_pretty(err));
+        error_free(err);
         qapi_free_SocketAddress(addr);
         goto error;
     }
-    g_assert(ret == 0);
     qapi_free_SocketAddress(addr);
 
     net_socket_rs_init(&d->rs, net_stream_data_rs_finalize, false);
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 599993d40d..7654febfa5 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -270,10 +270,6 @@ void qemu_socket_set_block(int fd)
     g_unix_set_fd_nonblocking(fd, false, NULL);
 }
 
-int qemu_socket_try_set_nonblock(int fd)
-{
-    return g_unix_set_fd_nonblocking(fd, true, NULL) ? 0 : -errno;
-}
 
 int socket_set_fast_reuse(int fd)
 {
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 1566eb57e7..bf5d478c5c 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -202,15 +202,6 @@ void qemu_socket_set_block(int fd)
     ioctlsocket(fd, FIONBIO, &opt);
 }
 
-int qemu_socket_try_set_nonblock(int fd)
-{
-    unsigned long opt = 1;
-    if (ioctlsocket(fd, FIONBIO, &opt) != NO_ERROR) {
-        return -socket_error();
-    }
-    return 0;
-}
-
 int socket_set_fast_reuse(int fd)
 {
     /* Enabling the reuse of an endpoint that was used by a socket still in
-- 
2.48.1


