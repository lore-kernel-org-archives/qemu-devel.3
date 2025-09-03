Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D36CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 09:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utk2k-0006Kv-2c; Wed, 03 Sep 2025 05:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utk2R-000646-Qb; Wed, 03 Sep 2025 05:44:24 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utk2O-0007ul-Oa; Wed, 03 Sep 2025 05:44:23 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 63FF180782;
 Wed, 03 Sep 2025 12:44:18 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id EicMoq3GhCg0-Z2a9dZNQ; Wed, 03 Sep 2025 12:44:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756892657;
 bh=zit6+aTBTIBl1ZuWWFJYHmrdrb/Nql11nAAi/gn7+/o=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Pv0JZpdIcROZWPy1vZnhejYEU/WI1ZBqWwbtwuE+zUO3tXfDng6utzVW0a2ATVhNW
 XYAOo9yHKEA9Vo5i2ki55VbR/fFND2Dc4lNIr2v9Jmby5ALBnMFkqatschXQyu//xq
 ae0C7OOB/gnugZEpCAVCBckBqVXVmZ5WmGl3bQC0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, peterx@redhat.com,
 vsementsov@yandex-team.ru, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Coiby Xu <Coiby.Xu@gmail.com>
Subject: [PATCH 04/10] util: drop qemu_socket_set_nonblock()
Date: Wed,  3 Sep 2025 12:44:04 +0300
Message-ID: <20250903094411.1029449-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use common qemu_set_blocking() instead.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 contrib/ivshmem-server/ivshmem-server.c |  5 ++++-
 hw/hyperv/syndbg.c                      |  4 +++-
 hw/virtio/vhost-user.c                  |  5 ++++-
 include/qemu/sockets.h                  |  1 -
 io/channel-socket.c                     |  7 +++----
 net/dgram.c                             | 16 +++++++++++++---
 net/l2tpv3.c                            |  5 +++--
 net/socket.c                            | 20 ++++++++++++++++----
 qga/channel-posix.c                     |  7 ++++++-
 tests/unit/socket-helpers.c             |  5 ++++-
 tests/unit/test-crypto-tlssession.c     |  8 ++++----
 util/oslib-posix.c                      |  7 -------
 util/oslib-win32.c                      |  5 -----
 util/vhost-user-server.c                |  4 ++--
 14 files changed, 62 insertions(+), 37 deletions(-)

diff --git a/contrib/ivshmem-server/ivshmem-server.c b/contrib/ivshmem-server/ivshmem-server.c
index 2f3c7320a6..9ccd436ee4 100644
--- a/contrib/ivshmem-server/ivshmem-server.c
+++ b/contrib/ivshmem-server/ivshmem-server.c
@@ -146,7 +146,10 @@ ivshmem_server_handle_new_conn(IvshmemServer *server)
         return -1;
     }
 
-    qemu_socket_set_nonblock(newfd);
+    if (!qemu_set_blocking(newfd, false, NULL)) {
+        close(newfd);
+        return -1;
+    }
     IVSHMEM_SERVER_DEBUG(server, "accept()=%d\n", newfd);
 
     /* allocate new structure for this peer */
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
index 3b7ca924ff..e77602a22e 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -820,11 +820,10 @@ qio_channel_socket_set_blocking(QIOChannel *ioc,
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
index 465d688ecb..ddf8ebdc5e 100644
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
+        g_warning("errer: %s", error_get_pretty(err));
+        error_free(err);
+        goto out;
+    }
     ret = ga_channel_client_add(c, client_fd);
     if (ret) {
         g_warning("error setting up connection");
diff --git a/tests/unit/socket-helpers.c b/tests/unit/socket-helpers.c
index 37db24f72a..1b7e283f24 100644
--- a/tests/unit/socket-helpers.c
+++ b/tests/unit/socket-helpers.c
@@ -88,7 +88,10 @@ static int socket_can_bind_connect(const char *hostname, int family)
         goto cleanup;
     }
 
-    qemu_socket_set_nonblock(cfd);
+    if (!qemu_set_blocking(cfd, false, NULL)) {
+        goto cleanup;
+    }
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
index e473938195..dc23b33210 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -272,13 +272,6 @@ int qemu_socket_try_set_nonblock(int fd)
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
index b19229074a..8dcd32dc65 100644
--- a/util/vhost-user-server.c
+++ b/util/vhost-user-server.c
@@ -78,7 +78,7 @@ static void vmsg_unblock_fds(VhostUserMsg *vmsg)
     }
 
     for (i = 0; i < vmsg->fd_num; i++) {
-        qemu_socket_set_nonblock(vmsg->fds[i]);
+        qemu_set_blocking(vmsg->fds[i], false, &error_abort);
     }
 }
 
@@ -303,7 +303,7 @@ set_watch(VuDev *vu_dev, int fd, int vu_evt,
 
         vu_fd_watch->fd = fd;
         vu_fd_watch->cb = cb;
-        qemu_socket_set_nonblock(fd);
+        qemu_set_blocking(fd, false, &error_abort);
         aio_set_fd_handler(server->ctx, fd, kick_handler,
                            NULL, NULL, NULL, vu_fd_watch);
         vu_fd_watch->vu_dev = vu_dev;
-- 
2.48.1


