Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22479C7115B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 15:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRvAW-0003Ee-Pt; Wed, 18 Jun 2025 11:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uRvAQ-0003Cp-J5
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 11:57:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uRvAN-00088e-No
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 11:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750262254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pip8H5LhecWwBCKCriggPkC9ndhlmXdBoFMDWaLqcpM=;
 b=RtfaTJDg9T6fQ/St6xXmchdfXMyiT6QALPxJmUmkB2ygEYTbyraGcWbXH+nzZPyrvwf/b0
 jQaM7W5oiq13al67kfMTOI5bUkLJCjCB/qNEQu/DUW/MrJi3rLxhNyA3BVvku9kGM2Kudo
 SsBhIMNywI4JTuNoAbjbmgqpB2G6TKE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-3M_W288pOFuNCU32EsZtYQ-1; Wed,
 18 Jun 2025 11:57:30 -0400
X-MC-Unique: 3M_W288pOFuNCU32EsZtYQ-1
X-Mimecast-MFC-AGG-ID: 3M_W288pOFuNCU32EsZtYQ_1750262249
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 275D3195608A; Wed, 18 Jun 2025 15:57:29 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.44.33.123])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B8E1C18003FC; Wed, 18 Jun 2025 15:57:24 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 01/10] net: Refactor stream logic for reuse in '-net passt'
Date: Wed, 18 Jun 2025 17:57:09 +0200
Message-ID: <20250618155718.550968-2-lvivier@redhat.com>
In-Reply-To: <20250618155718.550968-1-lvivier@redhat.com>
References: <20250618155718.550968-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

To prepare for the implementation of '-net passt', this patch moves
the generic stream handling functions from net/stream.c into new
net/stream_data.c and net/stream_data.h files.

This refactoring introduces a NetStreamData struct that encapsulates
the generic fields and logic previously in NetStreamState. The
NetStreamState now embeds NetStreamData and delegates the core
stream operations to the new generic functions.

To maintain flexibility for different users of this generic code,
callbacks for send and listen operations are now passed via
function pointers within the NetStreamData struct. This allows
callers to provide their own specific implementations while reusing
the common connection and data transfer logic.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 net/meson.build   |   3 +-
 net/stream.c      | 282 +++++++++++-----------------------------------
 net/stream_data.c | 193 +++++++++++++++++++++++++++++++
 net/stream_data.h |  31 +++++
 4 files changed, 290 insertions(+), 219 deletions(-)
 create mode 100644 net/stream_data.c
 create mode 100644 net/stream_data.h

diff --git a/net/meson.build b/net/meson.build
index bb97b4dcbeb6..bb3c011e5a30 100644
--- a/net/meson.build
+++ b/net/meson.build
@@ -1,6 +1,7 @@
 system_ss.add(files(
   'announce.c',
   'checksum.c',
+  'dgram.c',
   'dump.c',
   'eth.c',
   'filter-buffer.c',
@@ -12,7 +13,7 @@ system_ss.add(files(
   'queue.c',
   'socket.c',
   'stream.c',
-  'dgram.c',
+  'stream_data.c',
   'util.c',
 ))
 
diff --git a/net/stream.c b/net/stream.c
index 6152d2a05e52..d893f02cabe3 100644
--- a/net/stream.c
+++ b/net/stream.c
@@ -27,173 +27,50 @@
 
 #include "net/net.h"
 #include "clients.h"
-#include "monitor/monitor.h"
 #include "qapi/error.h"
-#include "qemu/error-report.h"
-#include "qemu/option.h"
-#include "qemu/sockets.h"
-#include "qemu/iov.h"
-#include "qemu/main-loop.h"
-#include "qemu/cutils.h"
-#include "io/channel.h"
-#include "io/channel-socket.h"
 #include "io/net-listener.h"
 #include "qapi/qapi-events-net.h"
 #include "qapi/qapi-visit-sockets.h"
 #include "qapi/clone-visitor.h"
 
+#include "stream_data.h"
+
 typedef struct NetStreamState {
-    NetClientState nc;
-    QIOChannel *listen_ioc;
-    QIONetListener *listener;
-    QIOChannel *ioc;
-    guint ioc_read_tag;
-    guint ioc_write_tag;
-    SocketReadState rs;
-    unsigned int send_index;      /* number of bytes sent*/
+    NetStreamData data;
     uint32_t reconnect_ms;
     guint timer_tag;
     SocketAddress *addr;
 } NetStreamState;
 
-static void net_stream_listen(QIONetListener *listener,
-                              QIOChannelSocket *cioc,
-                              void *opaque);
 static void net_stream_arm_reconnect(NetStreamState *s);
 
-static gboolean net_stream_writable(QIOChannel *ioc,
-                                    GIOCondition condition,
-                                    gpointer data)
-{
-    NetStreamState *s = data;
-
-    s->ioc_write_tag = 0;
-
-    qemu_flush_queued_packets(&s->nc);
-
-    return G_SOURCE_REMOVE;
-}
-
 static ssize_t net_stream_receive(NetClientState *nc, const uint8_t *buf,
                                   size_t size)
 {
-    NetStreamState *s = DO_UPCAST(NetStreamState, nc, nc);
-    uint32_t len = htonl(size);
-    struct iovec iov[] = {
-        {
-            .iov_base = &len,
-            .iov_len  = sizeof(len),
-        }, {
-            .iov_base = (void *)buf,
-            .iov_len  = size,
-        },
-    };
-    struct iovec local_iov[2];
-    unsigned int nlocal_iov;
-    size_t remaining;
-    ssize_t ret;
-
-    remaining = iov_size(iov, 2) - s->send_index;
-    nlocal_iov = iov_copy(local_iov, 2, iov, 2, s->send_index, remaining);
-    ret = qio_channel_writev(s->ioc, local_iov, nlocal_iov, NULL);
-    if (ret == QIO_CHANNEL_ERR_BLOCK) {
-        ret = 0; /* handled further down */
-    }
-    if (ret == -1) {
-        s->send_index = 0;
-        return -errno;
-    }
-    if (ret < (ssize_t)remaining) {
-        s->send_index += ret;
-        s->ioc_write_tag = qio_channel_add_watch(s->ioc, G_IO_OUT,
-                                                 net_stream_writable, s, NULL);
-        return 0;
-    }
-    s->send_index = 0;
-    return size;
-}
-
-static gboolean net_stream_send(QIOChannel *ioc,
-                                GIOCondition condition,
-                                gpointer data);
-
-static void net_stream_send_completed(NetClientState *nc, ssize_t len)
-{
-    NetStreamState *s = DO_UPCAST(NetStreamState, nc, nc);
-
-    if (!s->ioc_read_tag) {
-        s->ioc_read_tag = qio_channel_add_watch(s->ioc, G_IO_IN,
-                                                net_stream_send, s, NULL);
-    }
-}
+    NetStreamData *d = DO_UPCAST(NetStreamData, nc, nc);
 
-static void net_stream_rs_finalize(SocketReadState *rs)
-{
-    NetStreamState *s = container_of(rs, NetStreamState, rs);
-
-    if (qemu_send_packet_async(&s->nc, rs->buf,
-                               rs->packet_len,
-                               net_stream_send_completed) == 0) {
-        if (s->ioc_read_tag) {
-            g_source_remove(s->ioc_read_tag);
-            s->ioc_read_tag = 0;
-        }
-    }
+    return net_stream_data_receive(d, buf, size);
 }
 
 static gboolean net_stream_send(QIOChannel *ioc,
                                 GIOCondition condition,
                                 gpointer data)
 {
-    NetStreamState *s = data;
-    int size;
-    int ret;
-    QEMU_UNINITIALIZED char buf1[NET_BUFSIZE];
-    const char *buf;
-
-    size = qio_channel_read(s->ioc, buf1, sizeof(buf1), NULL);
-    if (size < 0) {
-        if (errno != EWOULDBLOCK) {
-            goto eoc;
-        }
-    } else if (size == 0) {
-        /* end of connection */
-    eoc:
-        s->ioc_read_tag = 0;
-        if (s->ioc_write_tag) {
-            g_source_remove(s->ioc_write_tag);
-            s->ioc_write_tag = 0;
-        }
-        if (s->listener) {
-            qemu_set_info_str(&s->nc, "listening");
-            qio_net_listener_set_client_func(s->listener, net_stream_listen,
-                                             s, NULL);
-        }
-        object_unref(OBJECT(s->ioc));
-        s->ioc = NULL;
-
-        net_socket_rs_init(&s->rs, net_stream_rs_finalize, false);
-        s->nc.link_down = true;
+    if (net_stream_data_send(ioc, condition, data) == G_SOURCE_REMOVE) {
+        NetStreamState *s = DO_UPCAST(NetStreamState, data, data);
 
-        qapi_event_send_netdev_stream_disconnected(s->nc.name);
+        qapi_event_send_netdev_stream_disconnected(s->data.nc.name);
         net_stream_arm_reconnect(s);
 
         return G_SOURCE_REMOVE;
     }
-    buf = buf1;
-
-    ret = net_fill_rstate(&s->rs, (const uint8_t *)buf, size);
-
-    if (ret == -1) {
-        goto eoc;
-    }
 
     return G_SOURCE_CONTINUE;
 }
 
 static void net_stream_cleanup(NetClientState *nc)
 {
-    NetStreamState *s = DO_UPCAST(NetStreamState, nc, nc);
+    NetStreamState *s = DO_UPCAST(NetStreamState, data.nc, nc);
     if (s->timer_tag) {
         g_source_remove(s->timer_tag);
         s->timer_tag = 0;
@@ -202,28 +79,28 @@ static void net_stream_cleanup(NetClientState *nc)
         qapi_free_SocketAddress(s->addr);
         s->addr = NULL;
     }
-    if (s->ioc) {
-        if (QIO_CHANNEL_SOCKET(s->ioc)->fd != -1) {
-            if (s->ioc_read_tag) {
-                g_source_remove(s->ioc_read_tag);
-                s->ioc_read_tag = 0;
+    if (s->data.ioc) {
+        if (QIO_CHANNEL_SOCKET(s->data.ioc)->fd != -1) {
+            if (s->data.ioc_read_tag) {
+                g_source_remove(s->data.ioc_read_tag);
+                s->data.ioc_read_tag = 0;
             }
-            if (s->ioc_write_tag) {
-                g_source_remove(s->ioc_write_tag);
-                s->ioc_write_tag = 0;
+            if (s->data.ioc_write_tag) {
+                g_source_remove(s->data.ioc_write_tag);
+                s->data.ioc_write_tag = 0;
             }
         }
-        object_unref(OBJECT(s->ioc));
-        s->ioc = NULL;
+        object_unref(OBJECT(s->data.ioc));
+        s->data.ioc = NULL;
     }
-    if (s->listen_ioc) {
-        if (s->listener) {
-            qio_net_listener_disconnect(s->listener);
-            object_unref(OBJECT(s->listener));
-            s->listener = NULL;
+    if (s->data.listen_ioc) {
+        if (s->data.listener) {
+            qio_net_listener_disconnect(s->data.listener);
+            object_unref(OBJECT(s->data.listener));
+            s->data.listener = NULL;
         }
-        object_unref(OBJECT(s->listen_ioc));
-        s->listen_ioc = NULL;
+        object_unref(OBJECT(s->data.listen_ioc));
+        s->data.listen_ioc = NULL;
     }
 }
 
@@ -235,23 +112,13 @@ static NetClientInfo net_stream_info = {
 };
 
 static void net_stream_listen(QIONetListener *listener,
-                              QIOChannelSocket *cioc,
-                              void *opaque)
+                                  QIOChannelSocket *cioc, gpointer data)
 {
-    NetStreamState *s = opaque;
+    NetStreamData *d = data;
     SocketAddress *addr;
     char *uri;
 
-    object_ref(OBJECT(cioc));
-
-    qio_net_listener_set_client_func(s->listener, NULL, s, NULL);
-
-    s->ioc = QIO_CHANNEL(cioc);
-    qio_channel_set_name(s->ioc, "stream-server");
-    s->nc.link_down = false;
-
-    s->ioc_read_tag = qio_channel_add_watch(s->ioc, G_IO_IN, net_stream_send,
-                                            s, NULL);
+    net_stream_data_listen(listener, cioc, data);
 
     if (cioc->localAddr.ss_family == AF_UNIX) {
         addr = qio_channel_socket_get_local_address(cioc, NULL);
@@ -260,22 +127,22 @@ static void net_stream_listen(QIONetListener *listener,
     }
     g_assert(addr != NULL);
     uri = socket_uri(addr);
-    qemu_set_info_str(&s->nc, "%s", uri);
+    qemu_set_info_str(&d->nc, "%s", uri);
     g_free(uri);
-    qapi_event_send_netdev_stream_connected(s->nc.name, addr);
+    qapi_event_send_netdev_stream_connected(d->nc.name, addr);
     qapi_free_SocketAddress(addr);
 }
 
 static void net_stream_server_listening(QIOTask *task, gpointer opaque)
 {
-    NetStreamState *s = opaque;
-    QIOChannelSocket *listen_sioc = QIO_CHANNEL_SOCKET(s->listen_ioc);
+    NetStreamData *d = opaque;
+    QIOChannelSocket *listen_sioc = QIO_CHANNEL_SOCKET(d->listen_ioc);
     SocketAddress *addr;
     int ret;
     Error *err = NULL;
 
     if (qio_task_propagate_error(task, &err)) {
-        qemu_set_info_str(&s->nc, "error: %s", error_get_pretty(err));
+        qemu_set_info_str(&d->nc, "error: %s", error_get_pretty(err));
         error_free(err);
         return;
     }
@@ -284,20 +151,21 @@ static void net_stream_server_listening(QIOTask *task, gpointer opaque)
     g_assert(addr != NULL);
     ret = qemu_socket_try_set_nonblock(listen_sioc->fd);
     if (addr->type == SOCKET_ADDRESS_TYPE_FD && ret < 0) {
-        qemu_set_info_str(&s->nc, "can't use file descriptor %s (errno %d)",
+        qemu_set_info_str(&d->nc, "can't use file descriptor %s (errno %d)",
                           addr->u.fd.str, -ret);
         return;
     }
     g_assert(ret == 0);
     qapi_free_SocketAddress(addr);
 
-    s->nc.link_down = true;
-    s->listener = qio_net_listener_new();
+    d->nc.link_down = true;
+    d->listener = qio_net_listener_new();
 
-    qemu_set_info_str(&s->nc, "listening");
-    net_socket_rs_init(&s->rs, net_stream_rs_finalize, false);
-    qio_net_listener_set_client_func(s->listener, net_stream_listen, s, NULL);
-    qio_net_listener_add(s->listener, listen_sioc);
+    qemu_set_info_str(&d->nc, "listening");
+    net_socket_rs_init(&d->rs, net_stream_data_rs_finalize, false);
+    qio_net_listener_set_client_func(d->listener, d->listen, d,
+                                     NULL);
+    qio_net_listener_add(d->listener, listen_sioc);
 }
 
 static int net_stream_server_init(NetClientState *peer,
@@ -307,16 +175,18 @@ static int net_stream_server_init(NetClientState *peer,
                                   Error **errp)
 {
     NetClientState *nc;
-    NetStreamState *s;
+    NetStreamData *d;
     QIOChannelSocket *listen_sioc = qio_channel_socket_new();
 
     nc = qemu_new_net_client(&net_stream_info, peer, model, name);
-    s = DO_UPCAST(NetStreamState, nc, nc);
-    qemu_set_info_str(&s->nc, "initializing");
+    d = DO_UPCAST(NetStreamData, nc, nc);
+    d->send = net_stream_send;
+    d->listen = net_stream_listen;
+    qemu_set_info_str(&d->nc, "initializing");
 
-    s->listen_ioc = QIO_CHANNEL(listen_sioc);
+    d->listen_ioc = QIO_CHANNEL(listen_sioc);
     qio_channel_socket_listen_async(listen_sioc, addr, 0,
-                                    net_stream_server_listening, s,
+                                    net_stream_server_listening, d,
                                     NULL, NULL);
 
     return 0;
@@ -325,49 +195,23 @@ static int net_stream_server_init(NetClientState *peer,
 static void net_stream_client_connected(QIOTask *task, gpointer opaque)
 {
     NetStreamState *s = opaque;
-    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(s->ioc);
+    NetStreamData *d = &s->data;
+    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(d->ioc);
     SocketAddress *addr;
     gchar *uri;
-    int ret;
-    Error *err = NULL;
 
-    if (qio_task_propagate_error(task, &err)) {
-        qemu_set_info_str(&s->nc, "error: %s", error_get_pretty(err));
-        error_free(err);
-        goto error;
+    if (net_stream_data_client_connected(task, d) == -1) {
+        net_stream_arm_reconnect(s);
+        return;
     }
 
     addr = qio_channel_socket_get_remote_address(sioc, NULL);
     g_assert(addr != NULL);
     uri = socket_uri(addr);
-    qemu_set_info_str(&s->nc, "%s", uri);
+    qemu_set_info_str(&d->nc, "%s", uri);
     g_free(uri);
-
-    ret = qemu_socket_try_set_nonblock(sioc->fd);
-    if (addr->type == SOCKET_ADDRESS_TYPE_FD && ret < 0) {
-        qemu_set_info_str(&s->nc, "can't use file descriptor %s (errno %d)",
-                          addr->u.fd.str, -ret);
-        qapi_free_SocketAddress(addr);
-        goto error;
-    }
-    g_assert(ret == 0);
-
-    net_socket_rs_init(&s->rs, net_stream_rs_finalize, false);
-
-    /* Disable Nagle algorithm on TCP sockets to reduce latency */
-    qio_channel_set_delay(s->ioc, false);
-
-    s->ioc_read_tag = qio_channel_add_watch(s->ioc, G_IO_IN, net_stream_send,
-                                            s, NULL);
-    s->nc.link_down = false;
-    qapi_event_send_netdev_stream_connected(s->nc.name, addr);
+    qapi_event_send_netdev_stream_connected(d->nc.name, addr);
     qapi_free_SocketAddress(addr);
-
-    return;
-error:
-    object_unref(OBJECT(s->ioc));
-    s->ioc = NULL;
-    net_stream_arm_reconnect(s);
 }
 
 static gboolean net_stream_reconnect(gpointer data)
@@ -378,7 +222,7 @@ static gboolean net_stream_reconnect(gpointer data)
     s->timer_tag = 0;
 
     sioc = qio_channel_socket_new();
-    s->ioc = QIO_CHANNEL(sioc);
+    s->data.ioc = QIO_CHANNEL(sioc);
     qio_channel_socket_connect_async(sioc, s->addr,
                                      net_stream_client_connected, s,
                                      NULL, NULL);
@@ -388,7 +232,7 @@ static gboolean net_stream_reconnect(gpointer data)
 static void net_stream_arm_reconnect(NetStreamState *s)
 {
     if (s->reconnect_ms && s->timer_tag == 0) {
-        qemu_set_info_str(&s->nc, "connecting");
+        qemu_set_info_str(&s->data.nc, "connecting");
         s->timer_tag = g_timeout_add(s->reconnect_ms, net_stream_reconnect, s);
     }
 }
@@ -405,11 +249,13 @@ static int net_stream_client_init(NetClientState *peer,
     QIOChannelSocket *sioc = qio_channel_socket_new();
 
     nc = qemu_new_net_client(&net_stream_info, peer, model, name);
-    s = DO_UPCAST(NetStreamState, nc, nc);
-    qemu_set_info_str(&s->nc, "connecting");
+    s = DO_UPCAST(NetStreamState, data.nc, nc);
+    qemu_set_info_str(&s->data.nc, "connecting");
 
-    s->ioc = QIO_CHANNEL(sioc);
-    s->nc.link_down = true;
+    s->data.ioc = QIO_CHANNEL(sioc);
+    s->data.nc.link_down = true;
+    s->data.send = net_stream_send;
+    s->data.listen = net_stream_listen;
 
     s->reconnect_ms = reconnect_ms;
     if (reconnect_ms) {
diff --git a/net/stream_data.c b/net/stream_data.c
new file mode 100644
index 000000000000..5af27e0d1d6a
--- /dev/null
+++ b/net/stream_data.c
@@ -0,0 +1,193 @@
+/*
+ * net stream generic functions
+ *
+ * Copyright Red Hat
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/iov.h"
+#include "qapi/error.h"
+#include "net/net.h"
+#include "io/channel.h"
+#include "io/net-listener.h"
+
+#include "stream_data.h"
+
+static gboolean net_stream_data_writable(QIOChannel *ioc,
+                                         GIOCondition condition, gpointer data)
+{
+    NetStreamData *d = data;
+
+    d->ioc_write_tag = 0;
+
+    qemu_flush_queued_packets(&d->nc);
+
+    return G_SOURCE_REMOVE;
+}
+
+ssize_t net_stream_data_receive(NetStreamData *d, const uint8_t *buf,
+                                size_t size)
+{
+    uint32_t len = htonl(size);
+    struct iovec iov[] = {
+        {
+            .iov_base = &len,
+            .iov_len  = sizeof(len),
+        }, {
+            .iov_base = (void *)buf,
+            .iov_len  = size,
+        },
+    };
+    struct iovec local_iov[2];
+    unsigned int nlocal_iov;
+    size_t remaining;
+    ssize_t ret;
+
+    remaining = iov_size(iov, 2) - d->send_index;
+    nlocal_iov = iov_copy(local_iov, 2, iov, 2, d->send_index, remaining);
+    ret = qio_channel_writev(d->ioc, local_iov, nlocal_iov, NULL);
+    if (ret == QIO_CHANNEL_ERR_BLOCK) {
+        ret = 0; /* handled further down */
+    }
+    if (ret == -1) {
+        d->send_index = 0;
+        return -errno;
+    }
+    if (ret < (ssize_t)remaining) {
+        d->send_index += ret;
+        d->ioc_write_tag = qio_channel_add_watch(d->ioc, G_IO_OUT,
+                                                 net_stream_data_writable, d,
+                                                 NULL);
+        return 0;
+    }
+    d->send_index = 0;
+    return size;
+}
+
+static void net_stream_data_send_completed(NetClientState *nc, ssize_t len)
+{
+    NetStreamData *d = DO_UPCAST(NetStreamData, nc, nc);
+
+    if (!d->ioc_read_tag) {
+        d->ioc_read_tag = qio_channel_add_watch(d->ioc, G_IO_IN, d->send, d,
+                                                NULL);
+    }
+}
+
+void net_stream_data_rs_finalize(SocketReadState *rs)
+{
+    NetStreamData *d = container_of(rs, NetStreamData, rs);
+
+    if (qemu_send_packet_async(&d->nc, rs->buf,
+                               rs->packet_len,
+                               net_stream_data_send_completed) == 0) {
+        if (d->ioc_read_tag) {
+            g_source_remove(d->ioc_read_tag);
+            d->ioc_read_tag = 0;
+        }
+    }
+}
+
+gboolean net_stream_data_send(QIOChannel *ioc, GIOCondition condition,
+                              NetStreamData *d)
+{
+    int size;
+    int ret;
+    QEMU_UNINITIALIZED char buf1[NET_BUFSIZE];
+    const char *buf;
+
+    size = qio_channel_read(d->ioc, buf1, sizeof(buf1), NULL);
+    if (size < 0) {
+        if (errno != EWOULDBLOCK) {
+            goto eoc;
+        }
+    } else if (size == 0) {
+        /* end of connection */
+    eoc:
+        d->ioc_read_tag = 0;
+        if (d->ioc_write_tag) {
+            g_source_remove(d->ioc_write_tag);
+            d->ioc_write_tag = 0;
+        }
+        if (d->listener) {
+            qemu_set_info_str(&d->nc, "listening");
+            qio_net_listener_set_client_func(d->listener,
+                                             d->listen, d, NULL);
+        }
+        object_unref(OBJECT(d->ioc));
+        d->ioc = NULL;
+
+        net_socket_rs_init(&d->rs, net_stream_data_rs_finalize, false);
+        d->nc.link_down = true;
+
+        return G_SOURCE_REMOVE;
+    }
+    buf = buf1;
+
+    ret = net_fill_rstate(&d->rs, (const uint8_t *)buf, size);
+
+    if (ret == -1) {
+        goto eoc;
+    }
+
+    return G_SOURCE_CONTINUE;
+}
+
+void net_stream_data_listen(QIONetListener *listener,
+                            QIOChannelSocket *cioc,
+                            NetStreamData *d)
+{
+    object_ref(OBJECT(cioc));
+
+    qio_net_listener_set_client_func(d->listener, NULL, d, NULL);
+
+    d->ioc = QIO_CHANNEL(cioc);
+    qio_channel_set_name(d->ioc, "stream-server");
+    d->nc.link_down = false;
+
+    d->ioc_read_tag = qio_channel_add_watch(d->ioc, G_IO_IN, d->send, d, NULL);
+}
+
+int net_stream_data_client_connected(QIOTask *task, NetStreamData *d)
+{
+    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(d->ioc);
+    SocketAddress *addr;
+    int ret;
+    Error *err = NULL;
+
+    if (qio_task_propagate_error(task, &err)) {
+        qemu_set_info_str(&d->nc, "error: %s", error_get_pretty(err));
+        error_free(err);
+        goto error;
+    }
+
+    addr = qio_channel_socket_get_remote_address(sioc, NULL);
+    g_assert(addr != NULL);
+
+    ret = qemu_socket_try_set_nonblock(sioc->fd);
+    if (addr->type == SOCKET_ADDRESS_TYPE_FD && ret < 0) {
+        qemu_set_info_str(&d->nc, "can't use file descriptor %s (errno %d)",
+                          addr->u.fd.str, -ret);
+        qapi_free_SocketAddress(addr);
+        goto error;
+    }
+    g_assert(ret == 0);
+    qapi_free_SocketAddress(addr);
+
+    net_socket_rs_init(&d->rs, net_stream_data_rs_finalize, false);
+
+    /* Disable Nagle algorithm on TCP sockets to reduce latency */
+    qio_channel_set_delay(d->ioc, false);
+
+    d->ioc_read_tag = qio_channel_add_watch(d->ioc, G_IO_IN, d->send, d, NULL);
+    d->nc.link_down = false;
+
+    return 0;
+error:
+    object_unref(OBJECT(d->ioc));
+    d->ioc = NULL;
+
+    return -1;
+}
diff --git a/net/stream_data.h b/net/stream_data.h
new file mode 100644
index 000000000000..b868625665ae
--- /dev/null
+++ b/net/stream_data.h
@@ -0,0 +1,31 @@
+/*
+ * net stream generic functions
+ *
+ * Copyright Red Hat
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+typedef struct NetStreamData {
+    NetClientState nc;
+    QIOChannel *ioc;
+    guint ioc_read_tag;
+    guint ioc_write_tag;
+    SocketReadState rs;
+    unsigned int send_index;      /* number of bytes sent*/
+    QIOChannelFunc send;
+    /* server data */
+    QIOChannel *listen_ioc;
+    QIONetListener *listener;
+    QIONetListenerClientFunc listen;
+} NetStreamData;
+
+ssize_t net_stream_data_receive(NetStreamData *d, const uint8_t *buf,
+                                size_t size);
+void net_stream_data_rs_finalize(SocketReadState *rs);
+gboolean net_stream_data_send(QIOChannel *ioc, GIOCondition condition,
+                              NetStreamData *d);
+int net_stream_data_client_connected(QIOTask *task, NetStreamData *d);
+void net_stream_data_listen(QIONetListener *listener,
+                            QIOChannelSocket *cioc,
+                            NetStreamData *d);
-- 
2.49.0


