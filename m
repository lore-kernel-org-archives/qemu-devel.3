Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B87CCF9FE
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 20:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEZJb-0000jh-Hc; Thu, 30 Oct 2025 16:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEZJF-0000g0-A0
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 16:31:50 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEZIv-0005vd-1x
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 16:31:46 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id AC9BF80A84;
 Thu, 30 Oct 2025 23:31:24 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:861::1:2b])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id HVmKdN0F6Cg0-020dyFVg; Thu, 30 Oct 2025 23:31:24 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761856284;
 bh=NL0jCrX2LP9YnzAQ/IxZiBP2DlF4NfwjD+aDOcx8SOo=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=wfYpv0HcOMnP6JwjN5MLOmaEw6+TMu6K7bP2voPJ84SJ6VGiDM/DKUfTgYraLOlbP
 hm45Uwbf4XtYLWRZ2iQo0peDbs9QVu6sKu55ti9GzcZ8GFHuCJHgOekyNnW29HpSWa
 FXFrrudK05RsP9cpvabsTj83yysL62fjCeV5d6hU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, zhao1.liu@intel.com,
 qemu-devel@nongnu.org, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru, vsementsov@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: [PATCH v9 5/8] virtio-net: support backend-transfer migration
Date: Thu, 30 Oct 2025 23:31:12 +0300
Message-ID: <20251030203116.870742-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251030203116.870742-1-vsementsov@yandex-team.ru>
References: <20251030203116.870742-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Implement backend-transfer support for virtio-net device.

How it works:

1. Use DEFINE_NIC_PROPERTIES_NO_CONNECT(), so that backend
   not being connected during netdev property setting.

2. If we are not in incoming migration, just call
   net_backend_connect() in _realize()

3. If we are in incoming migration, postpone backend connect up
   to pre-incoming. At this point we check migration parameters,
   and if backend-transfer is NOT enabled for this virtio-net
   device, do net_backend_connect(). Otherwise - do noting,
   live backend will come in migration stream.

4. During virtio-load, we get backend state as part of virtio-net
   state

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/net/virtio-net.c            | 157 ++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-net.h |   1 +
 2 files changed, 156 insertions(+), 2 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 17ed0ef919..94e41c225a 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -38,8 +38,10 @@
 #include "qapi/qapi-events-migration.h"
 #include "hw/virtio/virtio-access.h"
 #include "migration/misc.h"
+#include "migration/options.h"
 #include "standard-headers/linux/ethtool.h"
 #include "system/system.h"
+#include "system/runstate.h"
 #include "system/replay.h"
 #include "trace.h"
 #include "monitor/qdev.h"
@@ -3060,7 +3062,17 @@ static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue)
     n->multiqueue = multiqueue;
     virtio_net_change_num_queues(n, max * 2 + 1);
 
-    virtio_net_set_queue_pairs(n);
+    /*
+     * virtio_net_set_multiqueue() called from set_features(0) on early
+     * reset, when peer may wait for incoming (and is not initialized
+     * yet).
+     * Don't worry about it: virtio_net_set_queue_pairs() will be called
+     * later form virtio_net_post_load_device(), and anyway will be
+     * noop for local incoming migration with live backend passing.
+     */
+    if (!n->peers_wait_incoming) {
+        virtio_net_set_queue_pairs(n);
+    }
 }
 
 static int virtio_net_pre_load_queues(VirtIODevice *vdev, uint32_t n)
@@ -3089,6 +3101,17 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
 
     virtio_add_feature_ex(features, VIRTIO_NET_F_MAC);
 
+    if (n->peers_wait_incoming) {
+        /*
+         * Excessive feature set is OK for early initialization when
+         * we wait for local incoming migration: actual guest-negotiated
+         * features will come with migration stream anyway. And we are sure
+         * that we support same host-features as source, because the backend
+         * is the same (the same TAP device, for example).
+         */
+        return;
+    }
+
     if (!peer_has_vnet_hdr(n)) {
         virtio_clear_feature_ex(features, VIRTIO_NET_F_CSUM);
         virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_TSO4);
@@ -3180,6 +3203,18 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
     }
 }
 
+static bool virtio_net_update_host_features(VirtIONet *n, Error **errp)
+{
+    ERRP_GUARD();
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+
+    peer_test_vnet_hdr(n);
+
+    virtio_net_get_features(vdev, &vdev->host_features, errp);
+
+    return !*errp;
+}
+
 static int virtio_net_post_load_device(void *opaque, int version_id)
 {
     VirtIONet *n = opaque;
@@ -3301,6 +3336,9 @@ struct VirtIONetMigTmp {
     uint16_t        curr_queue_pairs_1;
     uint8_t         has_ufo;
     uint32_t        has_vnet_hdr;
+
+    NetClientState *ncs;
+    uint32_t max_queue_pairs;
 };
 
 /* The 2nd and subsequent tx_waiting flags are loaded later than
@@ -3570,6 +3608,57 @@ static const VMStateDescription vhost_user_net_backend_state = {
     }
 };
 
+static bool virtio_net_is_backend_transfer(void *opaque, int version_id)
+{
+    VirtIONet *n = opaque;
+
+    return migrate_backend_transfer(DEVICE(n));
+}
+
+static int virtio_net_nic_pre_save(void *opaque)
+{
+    struct VirtIONetMigTmp *tmp = opaque;
+
+    tmp->ncs = tmp->parent->nic->ncs;
+    tmp->max_queue_pairs = tmp->parent->max_queue_pairs;
+
+    return 0;
+}
+
+static int virtio_net_nic_pre_load(void *opaque)
+{
+    /* Reuse the pointer setup from save */
+    virtio_net_nic_pre_save(opaque);
+
+    return 0;
+}
+
+static int virtio_net_nic_post_load(void *opaque, int version_id)
+{
+    struct VirtIONetMigTmp *tmp = opaque;
+    Error *local_err = NULL;
+
+    if (!virtio_net_update_host_features(tmp->parent, &local_err)) {
+        error_report_err(local_err);
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_virtio_net_nic = {
+    .name      = "virtio-net-nic",
+    .pre_load  = virtio_net_nic_pre_load,
+    .pre_save  = virtio_net_nic_pre_save,
+    .post_load  = virtio_net_nic_post_load,
+    .fields    = (const VMStateField[]) {
+        VMSTATE_VARRAY_UINT32(ncs, struct VirtIONetMigTmp,
+                              max_queue_pairs, 0, vmstate_net_peer_backend,
+                              NetClientState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_virtio_net_device = {
     .name = "virtio-net-device",
     .version_id = VIRTIO_NET_VM_VERSION,
@@ -3602,6 +3691,9 @@ static const VMStateDescription vmstate_virtio_net_device = {
          */
         VMSTATE_BUFFER_UNSAFE(vlans, VirtIONet, 0,
                               sizeof(typeof_field(VirtIONet, vlans))),
+        VMSTATE_WITH_TMP_TEST(VirtIONet, virtio_net_is_backend_transfer,
+                              struct VirtIONetMigTmp,
+                              vmstate_virtio_net_nic),
         VMSTATE_WITH_TMP(VirtIONet, struct VirtIONetMigTmp,
                          vmstate_virtio_net_has_vnet),
         VMSTATE_UINT8(mac_table.multi_overflow, VirtIONet),
@@ -4003,6 +4095,20 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         n->nic->ncs[i].do_not_pad = true;
     }
 
+    if (runstate_check(RUN_STATE_INMIGRATE)) {
+        n->peers_wait_incoming = true;
+    } else {
+        for (i = 0; i < n->max_queue_pairs; i++) {
+            nc = qemu_get_subqueue(n->nic, i);
+            if (!nc->peer) {
+                continue;
+            }
+            if (!net_backend_connect(nc->peer, errp)) {
+                return;
+            }
+        }
+    }
+
     peer_test_vnet_hdr(n);
     if (peer_has_vnet_hdr(n)) {
         n->host_hdr_len = sizeof(struct virtio_net_hdr);
@@ -4176,6 +4282,30 @@ static bool dev_unplug_pending(void *opaque)
     return vdc->primary_unplug_pending(dev);
 }
 
+static bool vhost_user_blk_pre_incoming(void *opaque, Error **errp)
+{
+    VirtIONet *n = opaque;
+    int i;
+
+    if (!virtio_net_is_backend_transfer(opaque, 0) && n->peers_wait_incoming) {
+        for (i = 0; i < n->max_queue_pairs; i++) {
+            NetClientState *nc = qemu_get_subqueue(n->nic, i);
+            if (!nc->peer) {
+                continue;
+            }
+            if (!net_backend_connect(nc->peer, errp)) {
+                return false;
+            }
+        }
+
+        n->peers_wait_incoming = false;
+
+        return virtio_net_update_host_features(n, errp);
+    }
+
+    return true;
+}
+
 static const VMStateDescription vmstate_virtio_net = {
     .name = "virtio-net",
     .minimum_version_id = VIRTIO_NET_VM_VERSION,
@@ -4184,6 +4314,7 @@ static const VMStateDescription vmstate_virtio_net = {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
+    .pre_incoming = vhost_user_blk_pre_incoming,
     .pre_save = virtio_net_pre_save,
     .dev_unplug_pending = dev_unplug_pending,
 };
@@ -4239,7 +4370,7 @@ static const Property virtio_net_properties[] = {
                     VIRTIO_NET_F_RSC_EXT, false),
     DEFINE_PROP_UINT32("rsc_interval", VirtIONet, rsc_timeout,
                        VIRTIO_NET_RSC_DEFAULT_INTERVAL),
-    DEFINE_NIC_PROPERTIES(VirtIONet, nic_conf),
+    DEFINE_NIC_PROPERTIES_NO_CONNECT(VirtIONet, nic_conf),
     DEFINE_PROP_UINT32("x-txtimer", VirtIONet, net_conf.txtimer,
                        TX_TIMER_INTERVAL),
     DEFINE_PROP_INT32("x-txburst", VirtIONet, net_conf.txburst, TX_BURST),
@@ -4314,6 +4445,27 @@ static const Property virtio_net_properties[] = {
                                false),
 };
 
+static bool virtio_net_backend_transfer_support(DeviceState *dev, Error **errp)
+{
+    VirtIONet *n = VIRTIO_NET(dev);
+    NetClientState *nc = qemu_get_queue(n->nic);
+
+    if (!nc->peer) {
+        error_setg(errp, "Device %s has no attached backend",
+                   qdev_get_dev_path(dev));
+        return false;
+    }
+
+    if (!nc->peer->info->backend_vmsd) {
+        error_setg(errp, "Device %s backend is %s, does not support backend"
+                   " transfer", qdev_get_dev_path(dev),
+                   NetClientDriver_str(nc->peer->info->type));
+        return false;
+    }
+
+    return true;
+}
+
 static void virtio_net_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -4321,6 +4473,7 @@ static void virtio_net_class_init(ObjectClass *klass, const void *data)
 
     device_class_set_props(dc, virtio_net_properties);
     dc->vmsd = &vmstate_virtio_net;
+    dc->backend_transfer_support = virtio_net_backend_transfer_support;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     vdc->realize = virtio_net_device_realize;
     vdc->unrealize = virtio_net_device_unrealize;
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index f708355306..7e0e156908 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -231,6 +231,7 @@ struct VirtIONet {
     struct EBPFRSSContext ebpf_rss;
     uint32_t nr_ebpf_rss_fds;
     char **ebpf_rss_fds;
+    bool peers_wait_incoming;
 };
 
 size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
-- 
2.48.1


