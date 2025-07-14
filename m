Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25214C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 09:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubFkw-0004Af-04; Mon, 14 Jul 2025 05:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ubFXs-00031M-FQ; Mon, 14 Jul 2025 05:32:30 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ubFXl-00040m-B3; Mon, 14 Jul 2025 05:32:23 -0400
Received: from [157.82.206.39] ([157.82.206.39]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56E9Viad087593
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 14 Jul 2025 18:31:57 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=+8HGDbhAn09FdTQ9BmyGXXC74ug6db6ifTOWovIuvN8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1752485517; v=1;
 b=qpJEdJQ48ygDI4blgZL1+UNUvswKQ3BMii/HDNjNOZsk8W4idsl6Pd6Yw01J3Ahm
 Y4CtDP3THnS10zQqYPYCjqvmmf6xiSJzTuTAMgSGrMMaxbOEK6GDw9cUDKGHwJfJ
 gBUEn7BObvQMJ/wtSNDF6PclILy1Bz+SkwdwG9rqhZm8sTP3ad7YcloRRBvna+PY
 p4B11ad06DZ1SJKIMhFo/3lZarYCwJ4+1sU6JP3yxFuPYihwe1MxtfLKJLVhvWrQ
 a2YzpfsNbudM6cQbzXDm6YGa5cBhTj1k/3/ANwft7pgxiVsyh9aHBY4z/HsEg2az
 kKGimGjvFxvESvipG/sfEA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 14 Jul 2025 18:31:41 +0900
Subject: [PATCH RFC v2] virtio-net: Fix VLAN filter table reset timing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-vlan-v2-1-2d589ba4dcd3@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAHzOdGgC/1WMywrCMBBFf6XM2oSkT3UlCH6AW+liTNN2qiQlq
 cFS8u+G7lyeew9nA68daQ/nbAOnA3myJkF+yECNaAbNqEsMucgr0ciChTcadlRSNFhX2J0kJHV
 2uqfvnnnA/XaFNo0j+cW6dU8HuV//lSCZZFioXjxVj3VZXpwfuCJO/MMW+1otR8WnGdoY4w9iO
 4RMqgAAAA==
X-Change-ID: 20250713-vlan-8c107a65ad91
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, qemu-devel@nongnu.org
Cc: yin31149@gmail.com, eperezma@redhat.com, mst@redhat.com,
 jasowang@redhat.com, virtualization@lists.linux.dev,
 qemu-stable@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
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
---
Not tested.

Konstantin, I would also want you to test this new version. Please also
give it Tested-by, and, if possible, Reviewed-by.
---
Changes in v2:
- Addressed a concern with old drivers that do not properly set
  DRIVER_OK (pointed out by Michael S. Tsirkin).
- Noted that this change does not simply revert commit 06b636a1e2ad
  ("virtio-net: do not reset vlan filtering at set_features") but
  preserves its goal.
- Added Cc: qemu-stable@nongnu.org.
- Link to v1: https://lore.kernel.org/qemu-devel/20250713-vlan-v1-1-a3cf0bcfa644@rsg.ci.i.u-tokyo.ac.jp
---
 hw/net/virtio-net.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 221252e00a50a46033d7ec8d18936e7c8196a6ca..623c11b82e0a7fe1ae0095bf23a285f66322b948 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -998,8 +998,9 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
         vhost_net_save_acked_features(nc->peer);
     }
 
-    if (!virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN)) {
-        memset(n->vlans, 0xff, MAX_VLAN >> 3);
+    if (virtio_has_feature(vdev->guest_features ^ features, VIRTIO_NET_F_CTRL_VLAN)) {
+        bool vlan = virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN);
+        memset(n->vlans, vlan ? 0 : 0xff, MAX_VLAN >> 3);
     }
 
     if (virtio_has_feature(features, VIRTIO_NET_F_STANDBY)) {
@@ -3900,6 +3901,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     n->mac_table.macs = g_malloc0(MAC_TABLE_ENTRIES * ETH_ALEN);
 
     n->vlans = g_malloc0(MAX_VLAN >> 3);
+    memset(n->vlans, 0xff, MAX_VLAN >> 3);
 
     nc = qemu_get_queue(n->nic);
     nc->rxfilter_notify_enabled = 1;
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


