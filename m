Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F9DCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 15:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHk6-0007Pq-Ag; Wed, 27 Aug 2025 11:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHi9-00051z-J5; Wed, 27 Aug 2025 11:05:19 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHi7-0004yK-B8; Wed, 27 Aug 2025 11:05:17 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E63D514C53E;
 Wed, 27 Aug 2025 18:02:57 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D2B20269846;
 Wed, 27 Aug 2025 18:03:24 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Konstantin Shkolnyy <kshk@linux.ibm.com>, Lei Yang <leiyang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 22/59] virtio-net: Fix VLAN filter table reset timing
Date: Wed, 27 Aug 2025 18:02:27 +0300
Message-ID: <20250827150323.2694101-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Problem
-------

The expected initial state of the table depends on feature negotiation:

With VIRTIO_NET_F_CTRL_VLAN:
  The table must be empty in accordance with the specification.
Without VIRTIO_NET_F_CTRL_VLAN:
  The table must be filled to permit all VLAN traffic.

Prior to commit 06b636a1e2ad ("virtio-net: do not reset vlan filtering
at set_features"), virtio_net_set_features() always reset the VLAN
table. That commit changed the behavior to skip table reset when
VIRTIO_NET_F_CTRL_VLAN was negotiated, assuming the table would be
properly cleared during device reset and remain stable.

However, this assumption breaks when a driver renegotiates features:
1. Initial negotiation without VIRTIO_NET_F_CTRL_VLAN (table filled)
2. Renegotiation with VIRTIO_NET_F_CTRL_VLAN (table will not be cleared)

The problem was exacerbated by commit 0caed25cd171 ("virtio: Call
set_features during reset"), which triggered virtio_net_set_features()
during device reset, exposing the bug whenever VIRTIO_NET_F_CTRL_VLAN
was negotiated after a device reset.

Solution
--------

Fix the issue by initializing the table when virtio_net_set_features()
is called to change the VIRTIO_NET_F_CTRL_VLAN bit of
vdev->guest_features.

This approach ensures the correct table state regardless of feature
negotiation sequence by performing initialization in
virtio_net_set_features() as QEMU did prior to commit 06b636a1e2ad
("virtio-net: do not reset vlan filtering at set_features").

This change still preserves the goal of the commit, which was to avoid
resetting the table during migration, by checking whether the
VIRTIO_NET_F_CTRL_VLAN bit of vdev->guest_features is being changed;
vdev->guest_features is set before virtio_net_set_features() gets called
during migration.

It also avoids resetting the table when the driver sets a feature
bitmask with no change for the VIRTIO_NET_F_CTRL_VLAN bit, which makes
the operation idempotent and its semantics cleaner.

Additionally, this change ensures the table is initialized after
feature negotiation and before the DRIVER_OK status bit being set for
compatibility with the Linux driver before commit 50c0ada627f5
("virtio-net: fix race between ndo_open() and virtio_device_ready()"),
which did not ensure to set the DRIVER_OK status bit before modifying
the table.

Fixes: 06b636a1e2ad ("virtio-net: do not reset vlan filtering at set_features")
Cc: qemu-stable@nongnu.org
Reported-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Tested-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Message-Id: <20250727-vlan-v3-1-bbee738619b1@rsg.ci.i.u-tokyo.ac.jp>
Tested-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 6071d13c6a37493a6b26e1609b09a98aa058038a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 5f908e5bca..8a0ea4cff5 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -997,8 +997,9 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
         vhost_net_save_acked_features(nc->peer);
     }
 
-    if (!virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN)) {
-        memset(n->vlans, 0xff, MAX_VLAN >> 3);
+    if (virtio_has_feature(vdev->guest_features ^ features, VIRTIO_NET_F_CTRL_VLAN)) {
+        bool vlan = virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN);
+        memset(n->vlans, vlan ? 0 : 0xff, MAX_VLAN >> 3);
     }
 
     if (virtio_has_feature(features, VIRTIO_NET_F_STANDBY)) {
@@ -3896,6 +3897,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     n->mac_table.macs = g_malloc0(MAC_TABLE_ENTRIES * ETH_ALEN);
 
     n->vlans = g_malloc0(MAX_VLAN >> 3);
+    memset(n->vlans, 0xff, MAX_VLAN >> 3);
 
     nc = qemu_get_queue(n->nic);
     nc->rxfilter_notify_enabled = 1;
@@ -3986,7 +3988,6 @@ static void virtio_net_reset(VirtIODevice *vdev)
     memset(n->mac_table.macs, 0, MAC_TABLE_ENTRIES * ETH_ALEN);
     memcpy(&n->mac[0], &n->nic->conf->macaddr, sizeof(n->mac));
     qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
-    memset(n->vlans, 0, MAX_VLAN >> 3);
 
     /* Flush any async TX */
     for (i = 0;  i < n->max_queue_pairs; i++) {
-- 
2.47.2


