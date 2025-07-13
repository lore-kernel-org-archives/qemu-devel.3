Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F9FC83F1D
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Jul 2025 11:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uavGu-00071r-43; Sun, 13 Jul 2025 07:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uavGr-00071M-M5
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 07:53:29 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uavGo-00035v-Lg
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 07:53:29 -0400
Received: from [157.82.206.39] ([157.82.206.39]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56DBqs5v008236
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 13 Jul 2025 20:53:04 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=6Nu6gtWRB9pwKQY119OYVqFA5/pvFCpiOh/jk2M0fIE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1752407584; v=1;
 b=cWHWVf/ESado64JOp+fYKbSzSSwxxp9MHbTcrchhqqhZvf3kFibUEOCXZZmHwW/e
 +mvWv7dKBziRCundYD+lAndaMTYn1ZXfcBbYybGtFGojWqCJaEfDUj4qqnFqwN7q
 aX17Mh8KNK1XY2cL+YCzvggu9fqauxhgT3b/tDNT0/4aDKrNXMZRJeRmVXYFET5b
 jGMcDVgECWNn5n01zAQyzavza4N2Mqk49dMkw1USyvSOKCW/EdyxbmzgpCm+xHSD
 u6D8d7tUiJzhRlXlYIGvkjaO8/v4qUjqvpbG24uUSoX3Z4LRp/pF4Msy0x7o/Dch
 dxOWKA700bt9bQsboRSOOA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 13 Jul 2025 20:52:43 +0900
Subject: [PATCH RFC] virtio-net: Fix VLAN filter table initialization
 timing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-vlan-v1-1-a3cf0bcfa644@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAqec2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0Nj3bKcxDxdi2RDA/NEM9PEFEtDJaDSgqLUtMwKsDHRSkFuzkqxtbU
 AE16dolsAAAA=
X-Change-ID: 20250713-vlan-8c107a65ad91
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, qemu-devel@nongnu.org
Cc: yin31149@gmail.com, eperezma@redhat.com, mst@redhat.com,
 jasowang@redhat.com, virtualization@lists.linux.dev,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The VLAN filter table was not being properly initialized when the driver
sets the DRIVER_OK status bit, causing incorrect VLAN filtering behavior
that could allow unintended VLAN packets to pass through. Correct the
table initialization timing to fix the issue.

Problem
-------

The expected initial state of the table depends on feature negotiation:

With VIRTIO_NET_F_CTRL_VLAN:
  The table must be empty in accordance with the specification.
Without VIRTIO_NET_F_CTRL_VLAN:
  The table should be filled to permit all VLAN traffic.

Prior to commit  ("virtio-net: do not reset vlan filtering at
set_features"), virtio_net_set_features() always initialized the VLAN
table. That commit changed the behavior to skip initialization when
VIRTIO_NET_F_CTRL_VLAN was negotiated, assuming the table would be
properly cleared during reset and remain stable.

However, this assumption breaks when a driver renegotiates features:
1. Initial negotiation without VIRTIO_NET_F_CTRL_VLAN (table filled)
2. Renegotiation with VIRTIO_NET_F_CTRL_VLAN (table will not be cleared)

The problem was exacerbated by commit 0caed25cd171 ("virtio: Call
set_features during reset"), which triggered virtio_net_set_features()
during reset, exposing the bug whenever VIRTIO_NET_F_CTRL_VLAN was
negotiated after a reset.

Solution
--------

Fix by moving VLAN table initialization to virtio_net_set_status(),
which sets the DRIVER_OK status bit. This ensures proper table
initialization regardless of feature negotiation sequence.

Fixes: 06b636a1e2ad ("virtio-net: do not reset vlan filtering at set_features")
Reported-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Not tested.

Konstantin, please see if this patch fixes your workload.
---
 hw/net/virtio-net.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 221252e00a50a46033d7ec8d18936e7c8196a6ca..6d2a67471e570e1e9b4b4fb5338d87c30e23ae36 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -389,6 +389,12 @@ static int virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
     int i;
     uint8_t queue_status;
 
+    if ((status & VIRTIO_CONFIG_S_DRIVER_OK) &&
+        !(vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
+        bool vlan = virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_VLAN);
+        memset(n->vlans, vlan ? 0 : 0xff, MAX_VLAN >> 3);
+    }
+
     virtio_net_vnet_endian_status(n, status);
     virtio_net_vhost_status(n, status);
 
@@ -998,10 +1004,6 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
         vhost_net_save_acked_features(nc->peer);
     }
 
-    if (!virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN)) {
-        memset(n->vlans, 0xff, MAX_VLAN >> 3);
-    }
-
     if (virtio_has_feature(features, VIRTIO_NET_F_STANDBY)) {
         qapi_event_send_failover_negotiated(n->netclient_name);
         qatomic_set(&n->failover_primary_hidden, false);
@@ -3990,7 +3992,6 @@ static void virtio_net_reset(VirtIODevice *vdev)
     memset(n->mac_table.macs, 0, MAC_TABLE_ENTRIES * ETH_ALEN);
     memcpy(&n->mac[0], &n->nic->conf->macaddr, sizeof(n->mac));
     qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
-    memset(n->vlans, 0, MAX_VLAN >> 3);
 
     /* Flush any async TX */
     for (i = 0;  i < n->max_queue_pairs; i++) {

---
base-commit: f0737158b483e7ec2b2512145aeab888b85cc1f7
change-id: 20250713-vlan-8c107a65ad91

Best regards,
-- 
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


