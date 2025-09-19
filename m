Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7679ECAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 11:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzZfD-0002jo-EF; Fri, 19 Sep 2025 07:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzZei-0002YP-1a
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:52:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzZec-0000s1-W5
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758282709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nYpEdFXtBLEV86Ix65e1Molyf190v9S0JmjYC86IjG8=;
 b=AKSUZATGtgvVVxRP6K9b1xQ61ZfHCsY8tc2op0hfsXt3pmR2atmz/athC0cP6B0nVJyLxQ
 woDeqAx2f+zsAo88JPlf1bbo5LxP4u8HO+EsLr42rwroYzWgz53RZ6eSABmQLMVsJoHLig
 xOtz4QU6w5LKfXijbSQ5W9zTu9HXoVE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-HJ1l12WQMhOPvG6CjFpvhw-1; Fri,
 19 Sep 2025 07:51:45 -0400
X-MC-Unique: HJ1l12WQMhOPvG6CjFpvhw-1
X-Mimecast-MFC-AGG-ID: HJ1l12WQMhOPvG6CjFpvhw_1758282701
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 531A21956089; Fri, 19 Sep 2025 11:51:41 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.187])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 163731955F21; Fri, 19 Sep 2025 11:51:31 +0000 (UTC)
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
Subject: [PULL 07/16] treewide: handle result of qio_channel_set_blocking()
Date: Fri, 19 Sep 2025 12:50:08 +0100
Message-ID: <20250919115017.1536203-8-berrange@redhat.com>
In-Reply-To: <20250919115017.1536203-1-berrange@redhat.com>
References: <20250919115017.1536203-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Currently, we just always pass NULL as errp argument. That doesn't
look good.

Some realizations of interface may actually report errors.
Channel-socket realization actually either ignore or crash on
errors, but we are going to straighten it out to always reporting
an errp in further commits.

So, convert all callers to either handle the error (where environment
allows) or explicitly use &error_abort.

Take also a chance to change the return value to more convenient
bool (keeping also in mind, that underlying realizations may
return -1 on failure, not -errno).

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
[DB: fix return type mismatch in TLS/websocket channel
     impls for qio_channel_set_blocking]
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 block/nbd.c                      |  4 +++-
 chardev/char-socket.c            | 20 ++++++++++++++++----
 hw/remote/proxy.c                |  6 +++++-
 hw/remote/remote-obj.c           |  6 +++++-
 hw/vfio-user/proxy.c             | 11 ++++++++---
 include/io/channel.h             |  6 +++---
 io/channel-tls.c                 |  2 +-
 io/channel-websock.c             |  3 +--
 io/channel.c                     |  4 ++--
 nbd/server.c                     |  4 +++-
 scsi/qemu-pr-helper.c            |  9 ++++++---
 tests/unit/io-channel-helpers.c  |  5 +++--
 tests/unit/test-io-channel-tls.c |  4 ++--
 tools/i386/qemu-vmsr-helper.c    |  6 ++++--
 ui/vnc.c                         |  2 +-
 util/vhost-user-server.c         |  7 ++++++-
 16 files changed, 69 insertions(+), 30 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index d5a2b21c6d..5d231d5c4e 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -351,7 +351,9 @@ int coroutine_fn nbd_co_do_establish_connection(BlockDriverState *bs,
         return ret;
     }
 
-    qio_channel_set_blocking(s->ioc, false, NULL);
+    if (!qio_channel_set_blocking(s->ioc, false, errp)) {
+        return -EINVAL;
+    }
     qio_channel_set_follow_coroutine_ctx(s->ioc, true);
 
     /* successfully connected */
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 1be078dfc0..cb4ec78ebe 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -530,16 +530,24 @@ static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
     SocketChardev *s = SOCKET_CHARDEV(chr);
     int size;
     int saved_errno;
+    Error *local_err = NULL;
 
     if (s->state != TCP_CHARDEV_STATE_CONNECTED) {
         return 0;
     }
 
-    qio_channel_set_blocking(s->ioc, true, NULL);
+    if (!qio_channel_set_blocking(s->ioc, true, &local_err)) {
+        error_report_err(local_err);
+        return -1;
+    }
     size = tcp_chr_recv(chr, (void *) buf, len);
     saved_errno = errno;
     if (s->state != TCP_CHARDEV_STATE_DISCONNECTED) {
-        qio_channel_set_blocking(s->ioc, false, NULL);
+        if (!qio_channel_set_blocking(s->ioc, false, &local_err)) {
+            error_report_err(local_err);
+            /* failed to recover non-blocking state */
+            tcp_chr_disconnect(chr);
+        }
     }
     if (size == 0) {
         /* connection closed */
@@ -884,18 +892,22 @@ static void tcp_chr_set_client_ioc_name(Chardev *chr,
 static int tcp_chr_new_client(Chardev *chr, QIOChannelSocket *sioc)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
+    Error *local_err = NULL;
 
     if (s->state != TCP_CHARDEV_STATE_CONNECTING) {
         return -1;
     }
 
+    if (!qio_channel_set_blocking(QIO_CHANNEL(sioc), false, &local_err)) {
+        error_report_err(local_err);
+        return -1;
+    }
+
     s->ioc = QIO_CHANNEL(sioc);
     object_ref(OBJECT(sioc));
     s->sioc = sioc;
     object_ref(OBJECT(sioc));
 
-    qio_channel_set_blocking(s->ioc, false, NULL);
-
     if (s->do_nodelay) {
         qio_channel_set_delay(s->ioc, false);
     }
diff --git a/hw/remote/proxy.c b/hw/remote/proxy.c
index b0165aa2a1..18e0f7a064 100644
--- a/hw/remote/proxy.c
+++ b/hw/remote/proxy.c
@@ -112,8 +112,12 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
         return;
     }
 
+    if (!qio_channel_set_blocking(dev->ioc, true, errp)) {
+        object_unref(dev->ioc);
+        return;
+    }
+
     qemu_mutex_init(&dev->io_mutex);
-    qio_channel_set_blocking(dev->ioc, true, NULL);
 
     pci_conf[PCI_LATENCY_TIMER] = 0xff;
     pci_conf[PCI_INTERRUPT_PIN] = 0x01;
diff --git a/hw/remote/remote-obj.c b/hw/remote/remote-obj.c
index 85882902d7..3402068ab9 100644
--- a/hw/remote/remote-obj.c
+++ b/hw/remote/remote-obj.c
@@ -107,7 +107,11 @@ static void remote_object_machine_done(Notifier *notifier, void *data)
         error_report_err(err);
         return;
     }
-    qio_channel_set_blocking(ioc, false, NULL);
+    if (!qio_channel_set_blocking(ioc, false, &err)) {
+        error_report_err(err);
+        object_unref(OBJECT(ioc));
+        return;
+    }
 
     o->dev = dev;
 
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 2c03d49f97..bbd7ec243d 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -886,10 +886,11 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     sioc = qio_channel_socket_new();
     ioc = QIO_CHANNEL(sioc);
     if (qio_channel_socket_connect_sync(sioc, addr, errp) < 0) {
-        object_unref(OBJECT(ioc));
-        return NULL;
+        goto fail;
+    }
+    if (!qio_channel_set_blocking(ioc, false, errp)) {
+        goto fail;
     }
-    qio_channel_set_blocking(ioc, false, NULL);
 
     proxy = g_malloc0(sizeof(VFIOUserProxy));
     proxy->sockname = g_strdup_printf("unix:%s", sockname);
@@ -923,6 +924,10 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     QLIST_INSERT_HEAD(&vfio_user_sockets, proxy, next);
 
     return proxy;
+
+fail:
+    object_unref(OBJECT(ioc));
+    return NULL;
 }
 
 void vfio_user_set_handler(VFIODevice *vbasedev,
diff --git a/include/io/channel.h b/include/io/channel.h
index c7f64506f7..999a8f5f23 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -531,9 +531,9 @@ int coroutine_mixed_fn qio_channel_write_all(QIOChannel *ioc,
  * return QIO_CHANNEL_ERR_BLOCK if they would otherwise
  * block on I/O
  */
-int qio_channel_set_blocking(QIOChannel *ioc,
-                             bool enabled,
-                             Error **errp);
+bool qio_channel_set_blocking(QIOChannel *ioc,
+                              bool enabled,
+                              Error **errp);
 
 /**
  * qio_channel_set_follow_coroutine_ctx:
diff --git a/io/channel-tls.c b/io/channel-tls.c
index a8248a9216..7135896f79 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -425,7 +425,7 @@ static int qio_channel_tls_set_blocking(QIOChannel *ioc,
 {
     QIOChannelTLS *tioc = QIO_CHANNEL_TLS(ioc);
 
-    return qio_channel_set_blocking(tioc->master, enabled, errp);
+    return qio_channel_set_blocking(tioc->master, enabled, errp) ? 0 : -1;
 }
 
 static void qio_channel_tls_set_delay(QIOChannel *ioc,
diff --git a/io/channel-websock.c b/io/channel-websock.c
index 08ddb274f0..0a8c5c4712 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -1184,8 +1184,7 @@ static int qio_channel_websock_set_blocking(QIOChannel *ioc,
 {
     QIOChannelWebsock *wioc = QIO_CHANNEL_WEBSOCK(ioc);
 
-    qio_channel_set_blocking(wioc->master, enabled, errp);
-    return 0;
+    return qio_channel_set_blocking(wioc->master, enabled, errp) ? 0 : -1;
 }
 
 static void qio_channel_websock_set_delay(QIOChannel *ioc,
diff --git a/io/channel.c b/io/channel.c
index ebd9322765..852e684938 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -359,12 +359,12 @@ int coroutine_mixed_fn qio_channel_write_all(QIOChannel *ioc,
 }
 
 
-int qio_channel_set_blocking(QIOChannel *ioc,
+bool qio_channel_set_blocking(QIOChannel *ioc,
                               bool enabled,
                               Error **errp)
 {
     QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
-    return klass->io_set_blocking(ioc, enabled, errp);
+    return klass->io_set_blocking(ioc, enabled, errp) == 0;
 }
 
 
diff --git a/nbd/server.c b/nbd/server.c
index d242be9811..acec0487a8 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1411,7 +1411,9 @@ static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
         ....options sent, ending in NBD_OPT_EXPORT_NAME or NBD_OPT_GO....
      */
 
-    qio_channel_set_blocking(client->ioc, false, NULL);
+    if (!qio_channel_set_blocking(client->ioc, false, errp)) {
+        return -EINVAL;
+    }
     qio_channel_set_follow_coroutine_ctx(client->ioc, true);
 
     trace_nbd_negotiate_begin();
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index b69dd982d6..074b4db472 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -733,8 +733,11 @@ static void coroutine_fn prh_co_entry(void *opaque)
     uint32_t flags;
     int r;
 
-    qio_channel_set_blocking(QIO_CHANNEL(client->ioc),
-                             false, NULL);
+    if (!qio_channel_set_blocking(QIO_CHANNEL(client->ioc),
+                                  false, &local_err)) {
+        goto out;
+    }
+
     qio_channel_set_follow_coroutine_ctx(QIO_CHANNEL(client->ioc), true);
 
     /* A very simple negotiation for future extensibility.  No features
@@ -786,6 +789,7 @@ static void coroutine_fn prh_co_entry(void *opaque)
         }
     }
 
+out:
     if (local_err) {
         if (verbose == 0) {
             error_free(local_err);
@@ -794,7 +798,6 @@ static void coroutine_fn prh_co_entry(void *opaque)
         }
     }
 
-out:
     object_unref(OBJECT(client->ioc));
     g_free(client);
 }
diff --git a/tests/unit/io-channel-helpers.c b/tests/unit/io-channel-helpers.c
index c0799c21c2..22b42d14cd 100644
--- a/tests/unit/io-channel-helpers.c
+++ b/tests/unit/io-channel-helpers.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "io-channel-helpers.h"
+#include "qapi/error.h"
 #include "qemu/iov.h"
 
 struct QIOChannelTest {
@@ -109,8 +110,8 @@ void qio_channel_test_run_threads(QIOChannelTest *test,
     test->src = src;
     test->dst = dst;
 
-    qio_channel_set_blocking(test->dst, blocking, NULL);
-    qio_channel_set_blocking(test->src, blocking, NULL);
+    qio_channel_set_blocking(test->dst, blocking, &error_abort);
+    qio_channel_set_blocking(test->src, blocking, &error_abort);
 
     reader = g_thread_new("reader",
                           test_io_thread_reader,
diff --git a/tests/unit/test-io-channel-tls.c b/tests/unit/test-io-channel-tls.c
index e036ac5df4..6f282ad45d 100644
--- a/tests/unit/test-io-channel-tls.c
+++ b/tests/unit/test-io-channel-tls.c
@@ -184,8 +184,8 @@ static void test_io_channel_tls(const void *opaque)
      * thread, so we need these non-blocking to avoid deadlock
      * of ourselves
      */
-    qio_channel_set_blocking(QIO_CHANNEL(clientChanSock), false, NULL);
-    qio_channel_set_blocking(QIO_CHANNEL(serverChanSock), false, NULL);
+    qio_channel_set_blocking(QIO_CHANNEL(clientChanSock), false, &error_abort);
+    qio_channel_set_blocking(QIO_CHANNEL(serverChanSock), false, &error_abort);
 
     /* Now the real part of the test, setup the sessions */
     clientChanTLS = qio_channel_tls_new_client(
diff --git a/tools/i386/qemu-vmsr-helper.c b/tools/i386/qemu-vmsr-helper.c
index 5f19a48cbd..6c0f4fe870 100644
--- a/tools/i386/qemu-vmsr-helper.c
+++ b/tools/i386/qemu-vmsr-helper.c
@@ -213,8 +213,10 @@ static void coroutine_fn vh_co_entry(void *opaque)
     uint64_t vmsr;
     int r;
 
-    qio_channel_set_blocking(QIO_CHANNEL(client->ioc),
-                             false, NULL);
+    if (!qio_channel_set_blocking(QIO_CHANNEL(client->ioc),
+                                  false, &local_err)) {
+        goto out;
+    }
 
     qio_channel_set_follow_coroutine_ctx(QIO_CHANNEL(client->ioc), true);
 
diff --git a/ui/vnc.c b/ui/vnc.c
index 9054fc8125..77c823bf2e 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3337,7 +3337,7 @@ static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
 
     VNC_DEBUG("New client on socket %p\n", vs->sioc);
     update_displaychangelistener(&vd->dcl, VNC_REFRESH_INTERVAL_BASE);
-    qio_channel_set_blocking(vs->ioc, false, NULL);
+    qio_channel_set_blocking(vs->ioc, false, &error_abort);
     if (vs->ioc_tag) {
         g_source_remove(vs->ioc_tag);
     }
diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
index b19229074a..d805a92394 100644
--- a/util/vhost-user-server.c
+++ b/util/vhost-user-server.c
@@ -336,6 +336,7 @@ static void vu_accept(QIONetListener *listener, QIOChannelSocket *sioc,
                       gpointer opaque)
 {
     VuServer *server = opaque;
+    Error *local_err = NULL;
 
     if (server->sioc) {
         warn_report("Only one vhost-user client is allowed to "
@@ -368,7 +369,11 @@ static void vu_accept(QIONetListener *listener, QIOChannelSocket *sioc,
     object_ref(OBJECT(server->ioc));
 
     /* TODO vu_message_write() spins if non-blocking! */
-    qio_channel_set_blocking(server->ioc, false, NULL);
+    if (!qio_channel_set_blocking(server->ioc, false, &local_err)) {
+        error_report_err(local_err);
+        vu_deinit(&server->vu_dev);
+        return;
+    }
 
     qio_channel_set_follow_coroutine_ctx(server->ioc, true);
 
-- 
2.50.1


