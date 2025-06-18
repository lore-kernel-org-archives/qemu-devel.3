Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4B9C71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 15:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRvBF-0003RK-MX; Wed, 18 Jun 2025 11:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uRvB0-0003KF-Rw
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 11:58:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uRvAx-0008CX-Mg
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 11:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750262290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XjOKQq/HtHX0Q+fp7uuUuYDKpD2d+b8aaEwEDRrmmLk=;
 b=jQjhBndHd41+OSoCq+US2QHAkmfwr5ddp+c5HINI3/bHYu8v58B478nBUrmpvontbvP+xS
 rudg1vRodwfY8vIBVlTolNwkhm8xQGr4bCRFztwI/JymTRH1joRCCR6TYWmXYiBjcq/uBI
 G7Pe/oKKpEGJciUpsitI8OGZsvXN2Do=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-ZyoSGCBuMoesF1i3SO6ITA-1; Wed,
 18 Jun 2025 11:58:09 -0400
X-MC-Unique: ZyoSGCBuMoesF1i3SO6ITA-1
X-Mimecast-MFC-AGG-ID: ZyoSGCBuMoesF1i3SO6ITA_1750262288
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CBDC1809C8B; Wed, 18 Jun 2025 15:58:08 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.44.33.123])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7419F18003FC; Wed, 18 Jun 2025 15:58:04 +0000 (UTC)
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
Subject: [PATCH v2 10/10] net/passt: Implement vhost-user backend support
Date: Wed, 18 Jun 2025 17:57:18 +0200
Message-ID: <20250618155718.550968-11-lvivier@redhat.com>
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

This commit adds support for the vhost-user interface to the passt
network backend, enabling high-performance, accelerated networking for
guests using passt.

The passt backend can now operate in a vhost-user mode, where it
communicates with the guest's virtio-net device over a socket pair
using the vhost-user protocol. This offloads the datapath from the
main QEMU loop, significantly improving network performance.

The implementation involves:
- Extending NetPasstState to manage the vhost-user connection
  state, including the chardev frontend and the vhost_net
  instance.
- Adding the full vhost-user connection and event handling logic,
  similar to the standalone net/vhost-user.c client.
- Populating the NetClientInfo structure with implementations for
  all the required vhost callbacks that were recently refactored
  (is_vhost_user, get_vhost_net, save_acked_features, etc).

When the vhost-user=on option is used with -netdev passt, the new
vhost initialization path is taken instead of the standard
stream-based connection.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 net/passt.c | 334 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 334 insertions(+)

diff --git a/net/passt.c b/net/passt.c
index ce194b1e02f0..3c6bc0dfe89f 100644
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
@@ -60,11 +135,112 @@ static gboolean net_passt_send(QIOChannel *ioc, GIOCondition condition,
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
+    if (s->vhost_user != NULL) {
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
+static bool passt_is_vhost_user(NetClientState *nc)
+{
+    NetPasstState *s = DO_UPCAST(NetPasstState, data.nc, nc);
+
+    assert(nc->info->type == NET_CLIENT_DRIVER_PASST);
+
+    return s->vhost_user != NULL;
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
+    .is_vhost_user = passt_is_vhost_user,
+    .get_vhost_net = passt_get_vhost_net,
+    .vhost_feature_bits = user_feature_bits,
+    .get_acked_features = passt_get_acked_features,
+    .save_acked_features = passt_save_acked_features,
+    .max_tx_queue_size = VIRTQUEUE_MAX_SIZE,
+#endif
 };
 
 static void net_passt_client_connected(QIOTask *task, gpointer opaque)
@@ -163,13 +339,171 @@ static int net_passt_stream_start(NetPasstState *s, Error **errp)
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
 static int net_passt_vhost_user_init(NetPasstState *s, Error **errp)
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
 {
     error_setg(errp, "vhost-user parameter not yet implemented");
 
     return -1;
 }
+#endif
 
 static GPtrArray *net_passt_decode_args(const NetDevPasstOptions *passt,
                                         gchar *pidfile, Error **errp)
-- 
2.49.0


