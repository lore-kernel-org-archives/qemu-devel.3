Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30FECAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 11:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzZfY-0003EA-4u; Fri, 19 Sep 2025 07:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzZfI-0002s1-5v
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:52:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzZf5-0000v9-84
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758282738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Da93fHKvg30zR+PExOLc2FmPdm1BxYGR/cY3/h+WITU=;
 b=DwVaNClErTgZ8s2pxPu8TPikOnS6BSHv35bGDMI7ZARWaKiL2z5hRykKuIjejjEVpQcoBP
 KV46JKSr+rGNFqOjzkXIYBdpm6+pinjTHSlROx7qLBOfQBJ7fHZ45Rj7aMAm/1vFfWF3XZ
 2gYLuH/5ZmsNHCwRpatQ/J6ybpA+O7Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-RBOvo2cIN7mM1qlIaGxnJA-1; Fri,
 19 Sep 2025 07:52:14 -0400
X-MC-Unique: RBOvo2cIN7mM1qlIaGxnJA-1
X-Mimecast-MFC-AGG-ID: RBOvo2cIN7mM1qlIaGxnJA_1758282732
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B1E81956096; Fri, 19 Sep 2025 11:52:12 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.187])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 83E021955F2D; Fri, 19 Sep 2025 11:52:02 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John Levon <john.levon@nutanix.com>, Fam Zheng <fam@euphon.net>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Weil <sw@weilnetz.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Michael Roth <michael.roth@amd.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Subject: [PULL 10/16] util: drop qemu_socket_try_set_nonblock()
Date: Fri, 19 Sep 2025 12:50:11 +0100
Message-ID: <20250919115017.1536203-11-berrange@redhat.com>
In-Reply-To: <20250919115017.1536203-1-berrange@redhat.com>
References: <20250919115017.1536203-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Now we can use qemu_set_blocking() in these cases.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
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
2.50.1


