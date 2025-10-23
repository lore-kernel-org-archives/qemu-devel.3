Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D722CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 13:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBvl1-00011j-49; Thu, 23 Oct 2025 09:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vBvkp-0000v7-Mf; Thu, 23 Oct 2025 09:53:24 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vBvkl-0004qI-UA; Thu, 23 Oct 2025 09:53:23 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B697E1614ED;
 Thu, 23 Oct 2025 16:53:04 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C7AC32F4612;
 Thu, 23 Oct 2025 16:53:16 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 1/2] virtio-net: make VirtIONet.vlans an array instead of a
 pointer
Date: Thu, 23 Oct 2025 16:53:09 +0300
Message-ID: <20251023135316.31128-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023135316.31128-1-mjt@tls.msk.ru>
References: <20251023135316.31128-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This field is a fixed-size buffer (number of elements is MAX_VLAN,
known at build time).  There's no need to allocate it dynamically,
it can be made an integral part of VirtIONet structure.

This field is the only user of VMSTATE_BUFFER_POINTER_UNSAFE() macro.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/net/virtio-net.c            | 9 ++++-----
 include/hw/virtio/virtio-net.h | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 33116712eb..17ed0ef919 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -986,7 +986,7 @@ static void virtio_net_set_features(VirtIODevice *vdev,
         virtio_has_feature_ex(vdev->guest_features_ex,
                               VIRTIO_NET_F_CTRL_VLAN)) {
         bool vlan = virtio_has_feature_ex(features, VIRTIO_NET_F_CTRL_VLAN);
-        memset(n->vlans, vlan ? 0 : 0xff, MAX_VLAN >> 3);
+        memset(n->vlans, vlan ? 0 : 0xff, sizeof(n->vlans));
     }
 
     if (virtio_has_feature_ex(features, VIRTIO_NET_F_STANDBY)) {
@@ -3600,7 +3600,8 @@ static const VMStateDescription vmstate_virtio_net_device = {
          * buffer; hold onto your endiannesses; it's actually used as a bitmap
          * but based on the uint.
          */
-        VMSTATE_BUFFER_POINTER_UNSAFE(vlans, VirtIONet, 0, MAX_VLAN >> 3),
+        VMSTATE_BUFFER_UNSAFE(vlans, VirtIONet, 0,
+                              sizeof(typeof_field(VirtIONet, vlans))),
         VMSTATE_WITH_TMP(VirtIONet, struct VirtIONetMigTmp,
                          vmstate_virtio_net_has_vnet),
         VMSTATE_UINT8(mac_table.multi_overflow, VirtIONet),
@@ -4018,8 +4019,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
     n->mac_table.macs = g_malloc0(MAC_TABLE_ENTRIES * ETH_ALEN);
 
-    n->vlans = g_malloc0(MAX_VLAN >> 3);
-    memset(n->vlans, 0xff, MAX_VLAN >> 3);
+    memset(n->vlans, 0xff, sizeof(n->vlans));
 
     nc = qemu_get_queue(n->nic);
     nc->rxfilter_notify_enabled = 1;
@@ -4068,7 +4068,6 @@ static void virtio_net_device_unrealize(DeviceState *dev)
     n->netclient_type = NULL;
 
     g_free(n->mac_table.macs);
-    g_free(n->vlans);
 
     if (n->failover) {
         qobject_unref(n->primary_opts);
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 5b8ab7bda7..f708355306 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -202,7 +202,7 @@ struct VirtIONet {
         uint8_t uni_overflow;
         uint8_t *macs;
     } mac_table;
-    uint32_t *vlans;
+    uint32_t vlans[MAX_VLAN];
     virtio_net_conf net_conf;
     NICConf nic_conf;
     DeviceState *qdev;
-- 
2.47.3


