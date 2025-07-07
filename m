Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49428C8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 08:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYh1Z-0000OU-Jt; Mon, 07 Jul 2025 04:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uYh1M-0000Jw-3P
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 04:16:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uYh1J-0007Vc-MW
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 04:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751876171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hslm4SlPXjGaPdW9DtLidQZHv+Z168xrBO2wVg0jhes=;
 b=KOIZqsjBDTlSL+To0WzNA9Y9WpwR1ukX6p8M5gMrs/XbZL/isS77LdcHA/yhJVJwiXThfp
 r2hDBWevCEE5UsNn4FzikwtcSwIGvOjnA7Miwt/S5zn6vzaN6oxXxl2mlcfYUq69VyJrDi
 zvOznEs13wnsNV2sBlKtPxmoOVVAtHQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-lhoO8OmtPryPUydSgZoACg-1; Mon,
 07 Jul 2025 04:16:08 -0400
X-MC-Unique: lhoO8OmtPryPUydSgZoACg-1
X-Mimecast-MFC-AGG-ID: lhoO8OmtPryPUydSgZoACg_1751876167
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6087A19560BE; Mon,  7 Jul 2025 08:16:07 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.45.225.147])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9B964180045B; Mon,  7 Jul 2025 08:16:02 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Stefan Weil <sw@weilnetz.de>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v3 11/11] net/passt: Implement vhost-user backend support
Date: Mon,  7 Jul 2025 10:15:05 +0200
Message-ID: <20250707081505.127519-12-lvivier@redhat.com>
In-Reply-To: <20250707081505.127519-1-lvivier@redhat.com>
References: <20250707081505.127519-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

This commit adds support for the vhost-user interface to the passt
network backend, enabling high-performance, accelerated networking for
guests using passt.

The passt backend can now operate in a vhost-user mode, where it
communicates with the guest's virtio-net device over a socket pair
using the vhost-user protocol. This offloads the datapath from the
main QEMU loop, significantly improving network performance.

When the vhost-user=on option is used with -netdev passt, the new
vhost initialization path is taken instead of the standard
stream-based connection.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 docs/system/devices/net.rst |  12 +-
 net/passt.c                 | 346 ++++++++++++++++++++++++++++++++++++
 qapi/net.json               |   3 +
 qemu-options.hx             |  12 +-
 4 files changed, 370 insertions(+), 3 deletions(-)

diff --git a/docs/system/devices/net.rst b/docs/system/devices/net.rst
index 255ac9b8d1ed..6cc7dbb34beb 100644
--- a/docs/system/devices/net.rst
+++ b/docs/system/devices/net.rst
@@ -104,7 +104,7 @@ To use the passt backend interface
 
 There is no need to start the daemon as QEMU will do it for you.
 
-passt is started in the socket-based mode.
+By default, passt will be started in the socket-based mode.
 
 .. parsed-literal::
    |qemu_system| [...OPTIONS...] -nic passt
@@ -128,6 +128,16 @@ passt is started in the socket-based mode.
    virtio0: index=0,type=nic,model=virtio-net-pci,macaddr=9a:2b:2c:2d:2e:2f
     \ netdev0: index=0,type=passt,stream,connected to pid 25428
 
+To use the vhost-based interface, add the ``vhost-user=on`` parameter and
+select the virtio-net device:
+
+.. parsed-literal::
+   |qemu_system| [...OPTIONS...] -nic passt,model=virtio,vhost-user=on
+
+   (qemu) info network
+   virtio-net-pci.0: index=0,type=nic,model=virtio-net-pci,macaddr=52:54:00:12:34:56
+    \ #net006: index=0,type=passt,vhost-user,connected to pid 25731
+
 To use socket based passt interface:
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/net/passt.c b/net/passt.c
index 4936825d681c..3f4f28193b87 100644
--- a/net/passt.c
+++ b/net/passt.c
@@ -7,18 +7,75 @@
  */
 #include "qemu/osdep.h"
 #include <glib/gstdio.h>
+#include "qemu/error-report.h"
 #include <gio/gio.h>
 #include "net/net.h"
 #include "clients.h"
 #include "qapi/error.h"
 #include "io/net-listener.h"
+#include "chardev/char-fe.h"
+#include "net/vhost_net.h"
+#include "hw/virtio/vhost.h"
+#include "hw/virtio/vhost-user.h"
+#include "standard-headers/linux/virtio_net.h"
 #include "stream_data.h"
 
+#ifdef CONFIG_VHOST_USER
+static const int user_feature_bits[] = {
+    VIRTIO_F_NOTIFY_ON_EMPTY,
+    VIRTIO_F_NOTIFICATION_DATA,
+    VIRTIO_RING_F_INDIRECT_DESC,
+    VIRTIO_RING_F_EVENT_IDX,
+
+    VIRTIO_F_ANY_LAYOUT,
+    VIRTIO_F_VERSION_1,
+    VIRTIO_NET_F_CSUM,
+    VIRTIO_NET_F_GUEST_CSUM,
+    VIRTIO_NET_F_GSO,
+    VIRTIO_NET_F_GUEST_TSO4,
+    VIRTIO_NET_F_GUEST_TSO6,
+    VIRTIO_NET_F_GUEST_ECN,
+    VIRTIO_NET_F_GUEST_UFO,
+    VIRTIO_NET_F_HOST_TSO4,
+    VIRTIO_NET_F_HOST_TSO6,
+    VIRTIO_NET_F_HOST_ECN,
+    VIRTIO_NET_F_HOST_UFO,
+    VIRTIO_NET_F_MRG_RXBUF,
+    VIRTIO_NET_F_MTU,
+    VIRTIO_F_IOMMU_PLATFORM,
+    VIRTIO_F_RING_PACKED,
+    VIRTIO_F_RING_RESET,
+    VIRTIO_F_IN_ORDER,
+    VIRTIO_NET_F_RSS,
+    VIRTIO_NET_F_RSC_EXT,
+    VIRTIO_NET_F_HASH_REPORT,
+    VIRTIO_NET_F_GUEST_USO4,
+    VIRTIO_NET_F_GUEST_USO6,
+    VIRTIO_NET_F_HOST_USO,
+
+    /* This bit implies RARP isn't sent by QEMU out of band */
+    VIRTIO_NET_F_GUEST_ANNOUNCE,
+
+    VIRTIO_NET_F_MQ,
+
+    VHOST_INVALID_FEATURE_BIT
+};
+#endif
+
 typedef struct NetPasstState {
     NetStreamData data;
     GPtrArray *args;
     gchar *pidfile;
     pid_t pid;
+#ifdef CONFIG_VHOST_USER
+    /* vhost user */
+    VhostUserState *vhost_user;
+    VHostNetState *vhost_net;
+    CharBackend vhost_chr;
+    guint vhost_watch;
+    uint64_t acked_features;
+    bool started;
+#endif
 } NetPasstState;
 
 static int net_passt_stream_start(NetPasstState *s, Error **errp);
@@ -27,6 +84,24 @@ static void net_passt_cleanup(NetClientState *nc)
 {
     NetPasstState *s = DO_UPCAST(NetPasstState, data.nc, nc);
 
+#ifdef CONFIG_VHOST_USER
+    if (s->vhost_net) {
+        vhost_net_cleanup(s->vhost_net);
+        g_free(s->vhost_net);
+        s->vhost_net = NULL;
+    }
+    if (s->vhost_watch) {
+        g_source_remove(s->vhost_watch);
+        s->vhost_watch = 0;
+    }
+    qemu_chr_fe_deinit(&s->vhost_chr, true);
+    if (s->vhost_user) {
+        vhost_user_cleanup(s->vhost_user);
+        g_free(s->vhost_user);
+        s->vhost_user = NULL;
+    }
+#endif
+
     kill(s->pid, SIGTERM);
     g_remove(s->pidfile);
     g_free(s->pidfile);
@@ -60,11 +135,98 @@ static gboolean net_passt_send(QIOChannel *ioc, GIOCondition condition,
     return G_SOURCE_CONTINUE;
 }
 
+#ifdef CONFIG_VHOST_USER
+static int passt_set_vnet_endianness(NetClientState *nc, bool enable)
+{
+    assert(nc->info->type == NET_CLIENT_DRIVER_PASST);
+
+    return 0;
+}
+
+static bool passt_has_vnet_hdr(NetClientState *nc)
+{
+    NetPasstState *s = DO_UPCAST(NetPasstState, data.nc, nc);
+
+    assert(nc->info->type == NET_CLIENT_DRIVER_PASST);
+
+    return s->vhost_user != NULL;
+}
+
+static bool passt_has_ufo(NetClientState *nc)
+{
+    NetPasstState *s = DO_UPCAST(NetPasstState, data.nc, nc);
+
+    assert(nc->info->type == NET_CLIENT_DRIVER_PASST);
+
+    return s->vhost_user != NULL;
+}
+
+static bool passt_check_peer_type(NetClientState *nc, ObjectClass *oc,
+                                             Error **errp)
+{
+    NetPasstState *s = DO_UPCAST(NetPasstState, data.nc, nc);
+    const char *driver = object_class_get_name(oc);
+
+    assert(nc->info->type == NET_CLIENT_DRIVER_PASST);
+
+    if (s->vhost_user == NULL) {
+        return true;
+    }
+
+    if (!g_str_has_prefix(driver, "virtio-net-")) {
+        error_setg(errp, "vhost-user requires frontend driver virtio-net-*");
+        return false;
+    }
+
+    return true;
+}
+
+static struct vhost_net *passt_get_vhost_net(NetClientState *nc)
+{
+    NetPasstState *s = DO_UPCAST(NetPasstState, data.nc, nc);
+
+    assert(nc->info->type == NET_CLIENT_DRIVER_PASST);
+
+    return s->vhost_net;
+}
+
+static uint64_t passt_get_acked_features(NetClientState *nc)
+{
+    NetPasstState *s = DO_UPCAST(NetPasstState, data.nc, nc);
+
+    assert(nc->info->type == NET_CLIENT_DRIVER_PASST);
+
+    return s->acked_features;
+}
+
+static void passt_save_acked_features(NetClientState *nc)
+{
+    NetPasstState *s = DO_UPCAST(NetPasstState, data.nc, nc);
+
+    assert(nc->info->type == NET_CLIENT_DRIVER_PASST);
+
+    if (s->vhost_net) {
+        uint64_t features = vhost_net_get_acked_features(s->vhost_net);
+        if (features) {
+            s->acked_features = features;
+        }
+    }
+}
+#endif
+
 static NetClientInfo net_passt_info = {
     .type = NET_CLIENT_DRIVER_PASST,
     .size = sizeof(NetPasstState),
     .receive = net_passt_receive,
     .cleanup = net_passt_cleanup,
+#ifdef CONFIG_VHOST_USER
+    .has_vnet_hdr = passt_has_vnet_hdr,
+    .has_ufo = passt_has_ufo,
+    .set_vnet_be = passt_set_vnet_endianness,
+    .set_vnet_le = passt_set_vnet_endianness,
+    .check_peer_type = passt_check_peer_type,
+    .get_vhost_net = passt_get_vhost_net,
+#endif
 };
 
 static void net_passt_client_connected(QIOTask *task, gpointer opaque)
@@ -163,6 +325,177 @@ static int net_passt_stream_start(NetPasstState *s, Error **errp)
     return 0;
 }
 
+#ifdef CONFIG_VHOST_USER
+static gboolean passt_vhost_user_watch(void *do_not_use, GIOCondition cond,
+                                       void *opaque)
+{
+    NetPasstState *s = opaque;
+
+    qemu_chr_fe_disconnect(&s->vhost_chr);
+
+    return G_SOURCE_CONTINUE;
+}
+
+static void passt_vhost_user_event(void *opaque, QEMUChrEvent event);
+
+static void chr_closed_bh(void *opaque)
+{
+    NetPasstState *s = opaque;
+
+    passt_save_acked_features(&s->data.nc);
+
+    net_client_set_link(&(NetClientState *){ &s->data.nc }, 1, false);
+
+    qemu_chr_fe_set_handlers(&s->vhost_chr, NULL, NULL, passt_vhost_user_event,
+                             NULL, s, NULL, true);
+}
+
+static void passt_vhost_user_stop(NetPasstState *s)
+{
+    passt_save_acked_features(&s->data.nc);
+    vhost_net_cleanup(s->vhost_net);
+}
+
+static int passt_vhost_user_start(NetPasstState *s, VhostUserState *be)
+{
+    struct vhost_net *net = NULL;
+    VhostNetOptions options;
+
+    options.backend_type = VHOST_BACKEND_TYPE_USER;
+    options.net_backend = &s->data.nc;
+    options.opaque = be;
+    options.busyloop_timeout = 0;
+    options.nvqs = 2;
+    options.feature_bits = user_feature_bits;
+    options.max_tx_queue_size = VIRTQUEUE_MAX_SIZE;
+    options.get_acked_features = passt_get_acked_features;
+    options.save_acked_features = passt_save_acked_features;
+    options.is_vhost_user = true;
+
+    net = vhost_net_init(&options);
+    if (!net) {
+        error_report("failed to init passt vhost_net");
+        goto err;
+    }
+
+    if (s->vhost_net) {
+        vhost_net_cleanup(s->vhost_net);
+        g_free(s->vhost_net);
+    }
+    s->vhost_net = net;
+
+    return 0;
+err:
+    if (net) {
+        vhost_net_cleanup(net);
+        g_free(net);
+    }
+    passt_vhost_user_stop(s);
+    return -1;
+}
+
+static void passt_vhost_user_event(void *opaque, QEMUChrEvent event)
+{
+    NetPasstState *s = opaque;
+    Error *err = NULL;
+
+    switch (event) {
+    case CHR_EVENT_OPENED:
+        if (passt_vhost_user_start(s, s->vhost_user) < 0) {
+            qemu_chr_fe_disconnect(&s->vhost_chr);
+            return;
+        }
+        s->vhost_watch = qemu_chr_fe_add_watch(&s->vhost_chr, G_IO_HUP,
+                                               passt_vhost_user_watch, s);
+        net_client_set_link(&(NetClientState *){ &s->data.nc }, 1, true);
+        s->started = true;
+        break;
+    case CHR_EVENT_CLOSED:
+        if (s->vhost_watch) {
+            AioContext *ctx = qemu_get_current_aio_context();
+
+            g_source_remove(s->vhost_watch);
+            s->vhost_watch = 0;
+            qemu_chr_fe_set_handlers(&s->vhost_chr, NULL, NULL,  NULL, NULL,
+                                     NULL, NULL, false);
+
+            aio_bh_schedule_oneshot(ctx, chr_closed_bh, s);
+        }
+        break;
+    case CHR_EVENT_BREAK:
+    case CHR_EVENT_MUX_IN:
+    case CHR_EVENT_MUX_OUT:
+        /* Ignore */
+        break;
+    }
+
+    if (err) {
+        error_report_err(err);
+    }
+}
+
+static int net_passt_vhost_user_init(NetPasstState *s, Error **errp)
+{
+    Chardev *chr;
+    int sv[2];
+
+    if (socketpair(PF_UNIX, SOCK_STREAM, 0, sv) == -1) {
+        error_setg_errno(errp, errno, "socketpair() failed");
+        return -1;
+    }
+
+    /* connect to passt */
+    qemu_set_info_str(&s->data.nc, "connecting to passt");
+
+    /* create chardev */
+
+    chr = CHARDEV(object_new(TYPE_CHARDEV_SOCKET));
+    if (!chr || qemu_chr_add_client(chr, sv[0]) == -1) {
+        object_unref(OBJECT(chr));
+        error_setg(errp, "Failed to make socket chardev");
+        goto err;
+    }
+
+    s->vhost_user = g_new0(struct VhostUserState, 1);
+    if (!qemu_chr_fe_init(&s->vhost_chr, chr, errp) ||
+        !vhost_user_init(s->vhost_user, &s->vhost_chr, errp)) {
+        goto err;
+    }
+
+    /* start passt */
+    if (net_passt_start_daemon(s, sv[1], errp) == -1) {
+        goto err;
+    }
+
+    do {
+        if (qemu_chr_fe_wait_connected(&s->vhost_chr, errp) < 0) {
+            goto err;
+        }
+
+        qemu_chr_fe_set_handlers(&s->vhost_chr, NULL, NULL,
+                                 passt_vhost_user_event, NULL, s, NULL,
+                                 true);
+    } while (!s->started);
+
+    qemu_set_info_str(&s->data.nc, "vhost-user,connected to pid %d", s->pid);
+
+    close(sv[1]);
+    return 0;
+err:
+    close(sv[0]);
+    close(sv[1]);
+
+    return -1;
+}
+#else
+static int net_passt_vhost_user_init(NetPasstState *s, Error **errp)
+{
+    error_setg(errp, "vhost-user support has not been built");
+
+    return -1;
+}
+#endif
+
 static GPtrArray *net_passt_decode_args(const NetDevPasstOptions *passt,
                                         gchar *pidfile, Error **errp)
 {
@@ -174,6 +507,10 @@ static GPtrArray *net_passt_decode_args(const NetDevPasstOptions *passt,
         g_ptr_array_add(args, g_strdup("passt"));
     }
 
+    if (passt->has_vhost_user && passt->vhost_user) {
+        g_ptr_array_add(args, g_strdup("--vhost-user"));
+    }
+
     /* by default, be quiet */
     if (!passt->has_quiet || passt->quiet) {
         g_ptr_array_add(args, g_strdup("--quiet"));
@@ -232,6 +569,15 @@ int net_init_passt(const Netdev *netdev, const char *name,
     s->args = args;
     s->pidfile = pidfile;
 
+    if (netdev->u.passt.has_vhost_user && netdev->u.passt.vhost_user) {
+        if (net_passt_vhost_user_init(s, errp) == -1) {
+            qemu_del_net_client(nc);
+            return -1;
+        }
+
+        return 0;
+    }
+
     if (net_passt_stream_start(s, errp) == -1) {
         qemu_del_net_client(nc);
         return -1;
diff --git a/qapi/net.json b/qapi/net.json
index 8a8528ba1f47..8e4fee923fdf 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -121,6 +121,8 @@
 #
 # @quiet: don't print informational messages (default, passed as '--quiet')
 #
+# @vhost-user: enable vhost-user
+#
 # @param: parameter to pass to passt command
 #
 # Since: 10.1
@@ -129,6 +131,7 @@
   'data': {
     '*path':               'str',
     '*quiet':              'bool',
+    '*vhost-user':         'bool',
     '*param':             ['String'] },
     'if': 'CONFIG_PASST' }
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 9855657aa48b..5c468e9cd58e 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2797,11 +2797,13 @@ DEFHEADING(Network options:)
 
 DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
 #ifdef CONFIG_PASST
-    "-netdev passt,id=str[,path=file][,quiet=on|off][,param=list]\n"
+    "-netdev passt,id=str[,path=file][,quiet=on|off][,vhost-user=on|off][,param=list]\n"
     "                configure a passt network backend with ID 'str'\n"
     "                if 'path' is not provided 'passt' will be started according to PATH\n"
     "                by default, informational message of passt are not displayed (quiet=on)\n"
     "                to display this message, use 'quiet=off'\n"
+    "                by default, passt will be started in socket-based mode, to enable vhost-mode,\n"
+    "                use 'vhost-user=on'\n"
 #endif
 #ifdef CONFIG_SLIRP
     "-netdev user,id=str[,ipv4=on|off][,net=addr[/mask]][,host=addr]\n"
@@ -3056,6 +3058,12 @@ SRST
         By default, ``quiet=on`` to disable informational message from
         passt. ``quiet=on`` is passed as ``--quiet`` to passt.
 
+    ``vhost-user=on|off``
+        By default, ``vhost-user=off`` and QEMU uses the stream network
+        backend to communicate with passt. If ``vhost-user=on``, passt is
+        started with ``--vhost-user`` and QEMU uses the vhost-user network
+        backend to communicate with passt.
+
     ``param=string``
        ``string`` will be passed to passt has a command line parameter,
        we can have multiple occurences of the ``param`` parameter to
@@ -3065,7 +3073,7 @@ SRST
 
     .. parsed-literal::
 
-        |qemu_system| -nic passt,param=--tcp-ports=10001,param=--tcp-ports=10002,param=--udp-ports=10001
+        |qemu_system| -nic passt,vhost-user=on,param=--tcp-ports=10001,param=--tcp-ports=10002,param=--udp-ports=10001
 
 ``-netdev user,id=id[,option][,option][,...]``
     Configure user mode host network backend which requires no
-- 
2.49.0


