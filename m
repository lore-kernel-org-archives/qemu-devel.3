Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17AEC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 15:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4KZw-0000Zp-Ob; Wed, 09 Sep 2026 11:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=md17063E5F9E=lizhaoxin04@baidu.com>)
 id 1x4KZs-0000ZQ-Cg
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:51:13 -0400
Received: from mx14.baidu.com ([220.181.3.101] helo=outbound.baidu.com)
 by eggs.gnu.org with smtp (Exim 4.90_1)
 (envelope-from <prvs=md17063E5F9E=lizhaoxin04@baidu.com>)
 id 1x4KZm-00022u-N2
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:51:12 -0400
X-MD-Sfrom: lizhaoxin04@baidu.com
X-MD-SrcIP: 172.31.4.16
From: Li Zhaoxin <lizhaoxin04@baidu.com>
To: <qemu-devel@nongnu.org>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Longpeng <longpeng2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li
 Zhaoxin <lizhaoxin04@baidu.com>
Subject: [PATCH] vdpa-dev: implement guest_notifier_mask/pending
Date: Wed, 9 Sep 2026 23:50:42 +0800
Message-ID: <20260909155042.34186-1-lizhaoxin04@baidu.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.127.73.8]
X-ClientProxiedBy: bjhj-exc12.internal.baidu.com (172.31.3.22) To
 bjhj-exc18.internal.baidu.com (172.31.4.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
 s=selector1; t=1788969052;
 bh=eTFcnfnl7oo4atRZW4Qg9NDLjIulJhUCHUVi67e1pF0=;
 h=From:To:CC:Subject:Date:Message-ID:Content-Type;
 b=P/e5mkvrdQw6wdieF10rNNTvUrch+Q+I5Anb186JjEecIX1bHa8lLvfMVvsGE1bx7
 nvmSV+Mamx7V9dXwmeaZ5058Kammg+rYwHSBA4G2ts9gqMaq3Yhj9oNqs6+6Mf/GmK
 hfPzBtNaObKdoUav7jacXbK7lP1LL/TeE5oc9305ri4wFY5KEd15i3eSoKQO2Ux5O5
 XZcChY3cWb16fnIAnUAlyJRHG1MQsJlWxNyiGd+WLJ3mD/06HpKCevkZMExKcP1L3b
 FY/3xDDRXwgZK0JIv8yiaWVcoj0GF0IwRo3KYcd9sN49HJnT/I/YOnE6M9DTs6uVRU
 M2YQD+ZaOydqQ==
Received-SPF: pass client-ip=220.181.3.101;
 envelope-from=prvs=md17063E5F9E=lizhaoxin04@baidu.com; helo=outbound.baidu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Forward guest notifier masking to the vhost layer via
VHOST_SET_VRING_CALL, so the KVM irqfd stays installed across
MSI-X mask/unmask cycles instead of being torn down and re-added
each time.

Signed-off-by: Li Zhaoxin <lizhaoxin04@baidu.com>
---
 hw/virtio/vdpa-dev.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 6dc684ab09..1b75f6afdd 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -267,11 +267,7 @@ static int vhost_vdpa_device_start(VirtIODevice *vdev, Error **errp)
     }
     s->started = true;
 
-    /*
-     * guest_notifier_mask/pending not used yet, so just unmask
-     * everything here. virtio-pci will do the right thing by
-     * enabling/disabling irqfd.
-     */
+    /* Point every vring call fd at its guest notifier. */
     for (i = 0; i < s->dev.nvqs; i++) {
         vhost_virtqueue_mask(&s->dev, vdev, i, false);
     }
@@ -285,6 +281,28 @@ err_host_notifiers:
     return ret;
 }
 
+static void vhost_vdpa_device_guest_notifier_mask(VirtIODevice *vdev, int idx,
+                                                   bool mask)
+{
+    VhostVdpaDevice *s = VHOST_VDPA_DEVICE(vdev);
+
+    if (idx == VIRTIO_CONFIG_IRQ_IDX) {
+        return;
+    }
+    vhost_virtqueue_mask(&s->dev, vdev, idx, mask);
+}
+
+static bool vhost_vdpa_device_guest_notifier_pending(VirtIODevice *vdev,
+                                                    int idx)
+{
+    VhostVdpaDevice *s = VHOST_VDPA_DEVICE(vdev);
+
+    if (idx == VIRTIO_CONFIG_IRQ_IDX) {
+        return false;
+    }
+    return vhost_virtqueue_pending(&s->dev, idx);
+}
+
 static void vhost_vdpa_device_stop(VirtIODevice *vdev)
 {
     VhostVdpaDevice *s = VHOST_VDPA_DEVICE(vdev);
@@ -376,6 +394,8 @@ static void vhost_vdpa_device_class_init(ObjectClass *klass, const void *data)
     vdc->get_features = vhost_vdpa_device_get_features;
     vdc->set_status = vhost_vdpa_device_set_status;
     vdc->get_vhost = vhost_vdpa_device_get_vhost;
+    vdc->guest_notifier_mask = vhost_vdpa_device_guest_notifier_mask;
+    vdc->guest_notifier_pending = vhost_vdpa_device_guest_notifier_pending;
 }
 
 static void vhost_vdpa_device_instance_init(Object *obj)
-- 
2.43.0


