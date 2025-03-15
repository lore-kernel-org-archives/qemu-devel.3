Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68889C28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 07:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttMCJ-0004xP-Bn; Sat, 15 Mar 2025 03:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttMC9-0004eP-3E; Sat, 15 Mar 2025 03:44:33 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttMC5-00050K-HU; Sat, 15 Mar 2025 03:44:31 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CF80BFFB08;
 Sat, 15 Mar 2025 10:41:55 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id BE2C21CACD2;
 Sat, 15 Mar 2025 10:42:49 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 87EA7559FC; Sat, 15 Mar 2025 10:42:49 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.10 20/42] vdpa: Fix endian bugs in shadow virtqueue
Date: Sat, 15 Mar 2025 10:42:22 +0300
Message-Id: <20250315074249.634718-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-8.2.10-20250315104136@cover.tls.msk.ru>
References: <qemu-stable-8.2.10-20250315104136@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Konstantin Shkolnyy <kshk@linux.ibm.com>

VDPA didn't work on a big-endian machine due to missing/incorrect
CPU<->LE data format conversions.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Message-Id: <20250212164923.1971538-1-kshk@linux.ibm.com>
Fixes: 10857ec0ad ("vhost: Add VhostShadowVirtqueue")
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 50e9754149066dc91f58405d3378b589098cb408)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index fc5f408f77..ca60167b08 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -165,10 +165,10 @@ static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
         descs[i].len = cpu_to_le32(iovec[n].iov_len);
 
         last = i;
-        i = cpu_to_le16(svq->desc_next[i]);
+        i = svq->desc_next[i];
     }
 
-    svq->free_head = le16_to_cpu(svq->desc_next[last]);
+    svq->free_head = svq->desc_next[last];
     return true;
 }
 
@@ -228,10 +228,12 @@ static void vhost_svq_kick(VhostShadowVirtqueue *svq)
     smp_mb();
 
     if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
-        uint16_t avail_event = *(uint16_t *)(&svq->vring.used->ring[svq->vring.num]);
+        uint16_t avail_event = le16_to_cpu(
+                *(uint16_t *)(&svq->vring.used->ring[svq->vring.num]));
         needs_kick = vring_need_event(avail_event, svq->shadow_avail_idx, svq->shadow_avail_idx - 1);
     } else {
-        needs_kick = !(svq->vring.used->flags & VRING_USED_F_NO_NOTIFY);
+        needs_kick =
+                !(svq->vring.used->flags & cpu_to_le16(VRING_USED_F_NO_NOTIFY));
     }
 
     if (!needs_kick) {
@@ -365,7 +367,7 @@ static bool vhost_svq_more_used(VhostShadowVirtqueue *svq)
         return true;
     }
 
-    svq->shadow_used_idx = cpu_to_le16(*(volatile uint16_t *)used_idx);
+    svq->shadow_used_idx = le16_to_cpu(*(volatile uint16_t *)used_idx);
 
     return svq->last_used_idx != svq->shadow_used_idx;
 }
@@ -383,7 +385,7 @@ static bool vhost_svq_enable_notification(VhostShadowVirtqueue *svq)
 {
     if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
         uint16_t *used_event = (uint16_t *)&svq->vring.avail->ring[svq->vring.num];
-        *used_event = svq->shadow_used_idx;
+        *used_event = cpu_to_le16(svq->shadow_used_idx);
     } else {
         svq->vring.avail->flags &= ~cpu_to_le16(VRING_AVAIL_F_NO_INTERRUPT);
     }
@@ -408,7 +410,7 @@ static uint16_t vhost_svq_last_desc_of_chain(const VhostShadowVirtqueue *svq,
                                              uint16_t num, uint16_t i)
 {
     for (uint16_t j = 0; j < (num - 1); ++j) {
-        i = le16_to_cpu(svq->desc_next[i]);
+        i = svq->desc_next[i];
     }
 
     return i;
@@ -681,7 +683,7 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
     svq->desc_state = g_new0(SVQDescState, svq->vring.num);
     svq->desc_next = g_new0(uint16_t, svq->vring.num);
     for (unsigned i = 0; i < svq->vring.num - 1; i++) {
-        svq->desc_next[i] = cpu_to_le16(i + 1);
+        svq->desc_next[i] = i + 1;
     }
 }
 
-- 
2.39.5


