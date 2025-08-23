Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09E3CA0EFA
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Aug 2025 21:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upw6F-0004WV-QU; Sat, 23 Aug 2025 17:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upw6C-0004Te-GO
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 17:48:32 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upw69-00054A-MK
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 17:48:32 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 023F8807C8;
 Sun, 24 Aug 2025 00:48:28 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a5d::1:36])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Nmd3dr0GuSw0-GTo45y1a; Sun, 24 Aug 2025 00:48:27 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755985707;
 bh=GftTvKuCJ/20RJKBye2/TezLhjc0gyXvfMSFYxlvOO8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=g3YFHIXSZo+X5vcdph5+hatcE8swRJisd//UZvpUjdAd/WXLkxzgzUY0WdBQYhJ+k
 JDPGwaSHXNIi77Avmy2sCQpKtHl6g3J8AWnRuJpSGZBNywqyhqYPwJA1JtcUro0Gy+
 5phtS+PFSS6Sq/9xOnHOOgTgkMGFToRqhf2K/1Jk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, peterx@redhat.com, mst@redhat.com,
 farosas@suse.de, yc-core@yandex-team.ru
Subject: [RFC 5/7] virtio-net: support local tap migration
Date: Sun, 24 Aug 2025 00:48:19 +0300
Message-ID: <20250823214821.48342-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250823214821.48342-1-vsementsov@yandex-team.ru>
References: <20250823214821.48342-1-vsementsov@yandex-team.ru>
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/net/virtio-net.c            | 100 ++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-net.h |   2 +
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 6b5b5dace3..874e349fee 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -38,6 +38,8 @@
 #include "qapi/qapi-events-migration.h"
 #include "hw/virtio/virtio-access.h"
 #include "migration/misc.h"
+#include "migration/migration.h"
+#include "migration/options.h"
 #include "standard-headers/linux/ethtool.h"
 #include "system/system.h"
 #include "system/replay.h"
@@ -2999,7 +3001,13 @@ static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue)
     n->multiqueue = multiqueue;
     virtio_net_change_num_queues(n, max * 2 + 1);
 
-    virtio_net_set_queue_pairs(n);
+    /*
+     * Called from set_features(0) on reset, when on target we
+     * doesn't have fds yet
+     */
+    if (!n->tap_wait_incoming) {
+        virtio_net_set_queue_pairs(n);
+    }
 }
 
 static int virtio_net_pre_load_queues(VirtIODevice *vdev, uint32_t n)
@@ -3009,6 +3017,19 @@ static int virtio_net_pre_load_queues(VirtIODevice *vdev, uint32_t n)
     return 0;
 }
 
+static int virtio_net_pre_save_device(void *opaque)
+{
+    VirtIONet *n = opaque;
+    int i, r;
+
+    for (i = 0; i < n->curr_queue_pairs; i++) {
+        r = peer_detach(n, i);
+        assert(!r);
+    }
+
+    return 0;
+}
+
 static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
                                         Error **errp)
 {
@@ -3028,6 +3049,11 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
 
     virtio_add_feature(&features, VIRTIO_NET_F_MAC);
 
+    if (n->tap_wait_incoming) {
+        /* Excessive feature set is OK for early initialization */
+        return features;
+    }
+
     if (!peer_has_vnet_hdr(n)) {
         virtio_clear_feature(&features, VIRTIO_NET_F_CSUM);
         virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO4);
@@ -3494,11 +3520,69 @@ static const VMStateDescription vhost_user_net_backend_state = {
     }
 };
 
+static int virtio_net_tap_save(QEMUFile *f, void *pv, size_t size,
+                                     const VMStateField *field,
+                                     JSONWriter *vmdesc)
+{
+    VirtIONet *n = pv;
+    int i;
+
+    for (i = 0; i < n->max_queue_pairs; i++) {
+        NetClientState *nc = qemu_get_subqueue(n->nic, i);
+        assert(nc->peer->info->type == NET_CLIENT_DRIVER_TAP);
+
+        tap_save(nc->peer, f);
+    }
+
+    return 0;
+}
+
+static int virtio_net_tap_load(QEMUFile *f, void *pv, size_t size,
+                                     const VMStateField *field)
+{
+    VirtIONet *n = pv;
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
+    Error *local_err = NULL;
+    int i;
+
+    for (i = 0; i < n->max_queue_pairs; i++) {
+        NetClientState *nc = qemu_get_subqueue(n->nic, i);
+        assert(nc->peer->info->type == NET_CLIENT_DRIVER_TAP);
+
+        tap_load(nc->peer, f);
+    }
+
+    peer_test_vnet_hdr(n);
+    n->tap_wait_incoming = false;
+
+    vdev->host_features = vdc->get_features(vdev, vdev->host_features,
+                                            &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static bool virtio_net_is_tap_local(void *opaque, int version_id)
+{
+    VirtIONet *n = opaque;
+    NetClientState *nc;
+
+    nc = qemu_get_queue(n->nic);
+
+    return migrate_local_tap() && nc->peer &&
+        nc->peer->info->type == NET_CLIENT_DRIVER_TAP;
+}
+
 static const VMStateDescription vmstate_virtio_net_device = {
     .name = "virtio-net-device",
     .version_id = VIRTIO_NET_VM_VERSION,
     .minimum_version_id = VIRTIO_NET_VM_VERSION,
     .post_load = virtio_net_post_load_device,
+    .pre_save = virtio_net_pre_save_device,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(mac, VirtIONet, ETH_ALEN),
         VMSTATE_STRUCT_POINTER(vqs, VirtIONet,
@@ -3525,6 +3609,15 @@ static const VMStateDescription vmstate_virtio_net_device = {
          * but based on the uint.
          */
         VMSTATE_BUFFER_POINTER_UNSAFE(vlans, VirtIONet, 0, MAX_VLAN >> 3),
+        {
+            .name = "tap",
+            .info = &(const VMStateInfo) {
+                .name = "virtio-net vhost-user backend state",
+                .get = virtio_net_tap_load,
+                .put = virtio_net_tap_save,
+            },
+            .field_exists = virtio_net_is_tap_local,
+        },
         VMSTATE_WITH_TMP(VirtIONet, struct VirtIONetMigTmp,
                          vmstate_virtio_net_has_vnet),
         VMSTATE_UINT8(mac_table.multi_overflow, VirtIONet),
@@ -3954,6 +4047,11 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         vhost_net_set_config(get_vhost_net(nc->peer),
             (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE_FRONTEND);
     }
+
+    if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_TAP) {
+        n->tap_wait_incoming = tap_local_incoming(nc->peer);
+    }
+
     QTAILQ_INIT(&n->rsc_chains);
     n->qdev = dev;
 
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 73fdefc0dc..04ae0e4c06 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -231,6 +231,8 @@ struct VirtIONet {
     struct EBPFRSSContext ebpf_rss;
     uint32_t nr_ebpf_rss_fds;
     char **ebpf_rss_fds;
+
+    bool tap_wait_incoming;
 };
 
 size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
-- 
2.48.1


