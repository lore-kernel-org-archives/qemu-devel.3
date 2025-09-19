Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14681CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 11:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzZfU-00035Y-KV; Fri, 19 Sep 2025 07:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzZf2-0002jm-NN
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:52:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzZew-0000tz-NA
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758282727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ATlsXS8BZZhkrb06fgwiQpKpule5hVLhnbHVKaTdUx4=;
 b=KFursU0I8dpyDeRC7AWoGYjJ6EQbmF4C5JYfXmPO9p5l6oi1DP8x1cYWXYBZ2LKCvt8gvJ
 hopkH2klgdzqHzUgkOlZH66qhpzvN/gWKDX/DIvFjAWvugpijSa9ycAncIFfNDbiFyXf4r
 JBmnip7QnGl/hTYgI4ZlOpj9I7zS/WQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-_5Y_3oHGMSKUlyQjfTyZoQ-1; Fri,
 19 Sep 2025 07:52:04 -0400
X-MC-Unique: _5Y_3oHGMSKUlyQjfTyZoQ-1
X-Mimecast-MFC-AGG-ID: _5Y_3oHGMSKUlyQjfTyZoQ_1758282722
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FF3119560B0; Fri, 19 Sep 2025 11:52:02 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.187])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2F7B51955F21; Fri, 19 Sep 2025 11:51:51 +0000 (UTC)
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
Subject: [PULL 09/16] util: drop qemu_socket_set_nonblock()
Date: Fri, 19 Sep 2025 12:50:10 +0100
Message-ID: <20250919115017.1536203-10-berrange@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Use common qemu_set_blocking() instead.

Note that pre-patch the behavior of Win32 and Linux realizations
are inconsistent: we ignore failure for Win32, and assert success
for Linux.

How do we convert the callers?

1. Most of callers call qemu_socket_set_nonblock() on a
freshly created socket fd, in conditions when we may simply
report an error. Seems correct switching to error handling
both for Windows (pre-patch error is ignored) and Linux
(pre-patch we assert success). Anyway, we normally don't
expect errors in these cases.

Still in tests let's use &error_abort for simplicity.

What are exclusions?

2. hw/virtio/vhost-user.c - we are inside #ifdef CONFIG_LINUX,
so no damage in switching to error handling from assertion.

3. io/channel-socket.c: here we convert both old calls to
qemu_socket_set_nonblock() and qemu_socket_set_block() to
one new call. Pre-patch we assert success for Linux in
qemu_socket_set_nonblock(), and ignore all other errors here.
So, for Windows switch is a bit dangerous: we may get
new errors or crashes(when error_abort is passed) in
cases where we have silently ignored the error before
(was it correct in all such cases, if they were?) Still,
there is no other way to stricter API than take
this risk.

4. util/vhost-user-server - compiled only for Linux (see
util/meson.build), so we are safe, switching from assertion to
&error_abort.

Note: In qga/channel-posix.c we use g_warning(), where g_printerr()
would actually be a better choice. Still let's for now follow
common style of qga, where g_warning() is commonly used to print
such messages, and no call to g_printerr(). Converting everything
to use g_printerr() should better be another series.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 contrib/ivshmem-server/ivshmem-server.c |  9 ++++++++-
 hw/hyperv/syndbg.c                      |  4 +++-
 hw/virtio/vhost-user.c                  |  5 ++++-
 include/qemu/sockets.h                  |  1 -
 io/channel-socket.c                     |  7 +++----
 net/dgram.c                             | 16 +++++++++++++---
 net/l2tpv3.c                            |  5 +++--
 net/socket.c                            | 20 ++++++++++++++++----
 qga/channel-posix.c                     |  7 ++++++-
 tests/unit/socket-helpers.c             |  4 +++-
 tests/unit/test-crypto-tlssession.c     |  8 ++++----
 util/oslib-posix.c                      |  7 -------
 util/oslib-win32.c                      |  5 -----
 util/vhost-user-server.c                |  6 ++++--
 14 files changed, 67 insertions(+), 37 deletions(-)

diff --git a/contrib/ivshmem-server/ivshmem-server.c b/contrib/ivshmem-server/ivshmem-server.c
index 2f3c7320a6..13cb828174 100644
--- a/contrib/ivshmem-server/ivshmem-server.c
+++ b/contrib/ivshmem-server/ivshmem-server.c
@@ -6,6 +6,7 @@
  * top-level directory.
  */
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu/host-utils.h"
 #include "qemu/sockets.h"
 
@@ -135,6 +136,7 @@ ivshmem_server_handle_new_conn(IvshmemServer *server)
     socklen_t unaddr_len;
     int newfd;
     unsigned i;
+    Error *local_err = NULL;
 
     /* accept the incoming connection */
     unaddr_len = sizeof(unaddr);
@@ -146,9 +148,14 @@ ivshmem_server_handle_new_conn(IvshmemServer *server)
         return -1;
     }
 
-    qemu_socket_set_nonblock(newfd);
     IVSHMEM_SERVER_DEBUG(server, "accept()=%d\n", newfd);
 
+    if (!qemu_set_blocking(newfd, false, &local_err)) {
+        error_report_err(local_err);
+        close(newfd);
+        return -1;
+    }
+
     /* allocate new structure for this peer */
     peer = g_malloc0(sizeof(*peer));
     peer->sock_fd = newfd;
diff --git a/hw/hyperv/syndbg.c b/hw/hyperv/syndbg.c
index ac7e15f6f1..bcdfdf6af7 100644
--- a/hw/hyperv/syndbg.c
+++ b/hw/hyperv/syndbg.c
@@ -338,7 +338,9 @@ static void hv_syndbg_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_socket_set_nonblock(syndbg->socket);
+    if (!qemu_set_blocking(syndbg->socket, false, errp)) {
+        return;
+    }
 
     syndbg->servaddr.sin_port = htons(syndbg->host_port);
     syndbg->servaddr.sin_family = AF_INET;
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 1e1d6b0d6e..36c9c2e04d 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2039,7 +2039,10 @@ static int vhost_user_postcopy_advise(struct vhost_dev *dev, Error **errp)
         error_setg(errp, "%s: Failed to get ufd", __func__);
         return -EIO;
     }
-    qemu_socket_set_nonblock(ufd);
+    if (!qemu_set_blocking(ufd, false, errp)) {
+        close(ufd);
+        return -EINVAL;
+    }
 
     /* register ufd with userfault thread */
     u->postcopy_fd.fd = ufd;
diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index c562690d89..6477f90b9e 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -48,7 +48,6 @@ int socket_set_cork(int fd, int v);
 int socket_set_nodelay(int fd);
 void qemu_socket_set_block(int fd);
 int qemu_socket_try_set_nonblock(int fd);
-void qemu_socket_set_nonblock(int fd);
 int socket_set_fast_reuse(int fd);
 
 #ifdef WIN32
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 21f8f2e0c5..f7e3cb9742 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -825,11 +825,10 @@ qio_channel_socket_set_blocking(QIOChannel *ioc,
 {
     QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
 
-    if (enabled) {
-        qemu_socket_set_block(sioc->fd);
-    } else {
-        qemu_socket_set_nonblock(sioc->fd);
+    if (!qemu_set_blocking(sioc->fd, enabled, errp)) {
+        return -1;
     }
+
     return 0;
 }
 
diff --git a/net/dgram.c b/net/dgram.c
index 48f653bceb..fb9ded30df 100644
--- a/net/dgram.c
+++ b/net/dgram.c
@@ -226,7 +226,10 @@ static int net_dgram_mcast_create(struct sockaddr_in *mcastaddr,
         }
     }
 
-    qemu_socket_set_nonblock(fd);
+    if (!qemu_set_blocking(fd, false, errp)) {
+        goto fail;
+    }
+
     return fd;
 fail:
     if (fd >= 0) {
@@ -504,7 +507,11 @@ int net_init_dgram(const Netdev *netdev, const char *name,
             close(fd);
             return -1;
         }
-        qemu_socket_set_nonblock(fd);
+
+        if (!qemu_set_blocking(fd, false, errp)) {
+            close(fd);
+            return -1;
+        }
 
         dest_len = sizeof(raddr_in);
         dest_addr = g_malloc(dest_len);
@@ -551,7 +558,10 @@ int net_init_dgram(const Netdev *netdev, const char *name,
             close(fd);
             return -1;
         }
-        qemu_socket_set_nonblock(fd);
+        if (!qemu_set_blocking(fd, false, errp)) {
+            close(fd);
+            return -1;
+        }
 
         dest_len = sizeof(raddr_un);
         dest_addr = g_malloc(dest_len);
diff --git a/net/l2tpv3.c b/net/l2tpv3.c
index b5547cb917..cdfc641aa6 100644
--- a/net/l2tpv3.c
+++ b/net/l2tpv3.c
@@ -648,6 +648,9 @@ int net_init_l2tpv3(const Netdev *netdev,
         error_setg(errp, "could not bind socket err=%i", errno);
         goto outerr;
     }
+    if (!qemu_set_blocking(fd, false, errp)) {
+        goto outerr;
+    }
 
     freeaddrinfo(result);
 
@@ -709,8 +712,6 @@ int net_init_l2tpv3(const Netdev *netdev,
     s->vec = g_new(struct iovec, MAX_L2TPV3_IOVCNT);
     s->header_buf = g_malloc(s->header_size);
 
-    qemu_socket_set_nonblock(fd);
-
     s->fd = fd;
     s->counter = 0;
 
diff --git a/net/socket.c b/net/socket.c
index 784dda686f..db25e3d9ae 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -295,7 +295,10 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr,
         }
     }
 
-    qemu_socket_set_nonblock(fd);
+    if (!qemu_set_blocking(fd, false, errp)) {
+        goto fail;
+    }
+
     return fd;
 fail:
     if (fd >= 0)
@@ -508,7 +511,10 @@ static int net_socket_listen_init(NetClientState *peer,
         error_setg_errno(errp, errno, "can't create stream socket");
         return -1;
     }
-    qemu_socket_set_nonblock(fd);
+    if (!qemu_set_blocking(fd, false, errp)) {
+        close(fd);
+        return -1;
+    }
 
     socket_set_fast_reuse(fd);
 
@@ -556,7 +562,10 @@ static int net_socket_connect_init(NetClientState *peer,
         error_setg_errno(errp, errno, "can't create stream socket");
         return -1;
     }
-    qemu_socket_set_nonblock(fd);
+    if (!qemu_set_blocking(fd, false, errp)) {
+        close(fd);
+        return -1;
+    }
 
     connected = 0;
     for(;;) {
@@ -671,7 +680,10 @@ static int net_socket_udp_init(NetClientState *peer,
         close(fd);
         return -1;
     }
-    qemu_socket_set_nonblock(fd);
+    if (!qemu_set_blocking(fd, false, errp)) {
+        close(fd);
+        return -1;
+    }
 
     s = net_socket_fd_init_dgram(peer, model, name, fd, 0, NULL, errp);
     if (!s) {
diff --git a/qga/channel-posix.c b/qga/channel-posix.c
index 465d688ecb..9ccc8b7bd1 100644
--- a/qga/channel-posix.c
+++ b/qga/channel-posix.c
@@ -28,6 +28,7 @@ static gboolean ga_channel_listen_accept(GIOChannel *channel,
     GAChannel *c = data;
     int ret, client_fd;
     bool accepted = false;
+    Error *err = NULL;
 
     g_assert(channel != NULL);
 
@@ -36,7 +37,11 @@ static gboolean ga_channel_listen_accept(GIOChannel *channel,
         g_warning("error converting fd to gsocket: %s", strerror(errno));
         goto out;
     }
-    qemu_socket_set_nonblock(client_fd);
+    if (!qemu_set_blocking(client_fd, false, &err)) {
+        g_warning("%s", error_get_pretty(err));
+        error_free(err);
+        goto out;
+    }
     ret = ga_channel_client_add(c, client_fd);
     if (ret) {
         g_warning("error setting up connection");
diff --git a/tests/unit/socket-helpers.c b/tests/unit/socket-helpers.c
index 37db24f72a..46d2ff101c 100644
--- a/tests/unit/socket-helpers.c
+++ b/tests/unit/socket-helpers.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu/sockets.h"
 #include "socket-helpers.h"
 
@@ -88,7 +89,8 @@ static int socket_can_bind_connect(const char *hostname, int family)
         goto cleanup;
     }
 
-    qemu_socket_set_nonblock(cfd);
+    qemu_set_blocking(cfd, false, &error_abort);
+
     if (connect(cfd, (struct sockaddr *)&ss, sslen) < 0) {
         if (errno == EINPROGRESS) {
             check_soerr = true;
diff --git a/tests/unit/test-crypto-tlssession.c b/tests/unit/test-crypto-tlssession.c
index 554054e934..61311cbe6e 100644
--- a/tests/unit/test-crypto-tlssession.c
+++ b/tests/unit/test-crypto-tlssession.c
@@ -112,8 +112,8 @@ static void test_crypto_tls_session_psk(void)
      * thread, so we need these non-blocking to avoid deadlock
      * of ourselves
      */
-    qemu_socket_set_nonblock(channel[0]);
-    qemu_socket_set_nonblock(channel[1]);
+    qemu_set_blocking(channel[0], false, &error_abort);
+    qemu_set_blocking(channel[1], false, &error_abort);
 
     clientCreds = test_tls_creds_psk_create(
         QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT,
@@ -264,8 +264,8 @@ static void test_crypto_tls_session_x509(const void *opaque)
      * thread, so we need these non-blocking to avoid deadlock
      * of ourselves
      */
-    qemu_socket_set_nonblock(channel[0]);
-    qemu_socket_set_nonblock(channel[1]);
+    qemu_set_blocking(channel[0], false, &error_abort);
+    qemu_set_blocking(channel[1], false, &error_abort);
 
 #define CLIENT_CERT_DIR "tests/test-crypto-tlssession-client/"
 #define SERVER_CERT_DIR "tests/test-crypto-tlssession-server/"
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index c737701075..599993d40d 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -275,13 +275,6 @@ int qemu_socket_try_set_nonblock(int fd)
     return g_unix_set_fd_nonblocking(fd, true, NULL) ? 0 : -errno;
 }
 
-void qemu_socket_set_nonblock(int fd)
-{
-    int f;
-    f = qemu_socket_try_set_nonblock(fd);
-    assert(f == 0);
-}
-
 int socket_set_fast_reuse(int fd)
 {
     int val = 1, ret;
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 03044f5b59..1566eb57e7 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -211,11 +211,6 @@ int qemu_socket_try_set_nonblock(int fd)
     return 0;
 }
 
-void qemu_socket_set_nonblock(int fd)
-{
-    (void)qemu_socket_try_set_nonblock(fd);
-}
-
 int socket_set_fast_reuse(int fd)
 {
     /* Enabling the reuse of an endpoint that was used by a socket still in
diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
index d805a92394..04c72a92aa 100644
--- a/util/vhost-user-server.c
+++ b/util/vhost-user-server.c
@@ -78,7 +78,8 @@ static void vmsg_unblock_fds(VhostUserMsg *vmsg)
     }
 
     for (i = 0; i < vmsg->fd_num; i++) {
-        qemu_socket_set_nonblock(vmsg->fds[i]);
+        /* TODO: handle error more gracefully than aborting */
+        qemu_set_blocking(vmsg->fds[i], false, &error_abort);
     }
 }
 
@@ -303,7 +304,8 @@ set_watch(VuDev *vu_dev, int fd, int vu_evt,
 
         vu_fd_watch->fd = fd;
         vu_fd_watch->cb = cb;
-        qemu_socket_set_nonblock(fd);
+        /* TODO: handle error more gracefully than aborting */
+        qemu_set_blocking(fd, false, &error_abort);
         aio_set_fd_handler(server->ctx, fd, kick_handler,
                            NULL, NULL, NULL, vu_fd_watch);
         vu_fd_watch->vu_dev = vu_dev;
-- 
2.50.1


