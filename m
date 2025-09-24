Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D461CAC5B0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Lr0-0000r7-1P; Wed, 24 Sep 2025 05:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1v1Lqx-0000bg-0X
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:31:59 -0400
Received: from m204-227.eu.mailgun.net ([161.38.204.227])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1v1Lqs-0005Jz-11
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:31:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt;
 s=email; t=1758706305; x=1758713505; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender; 
 bh=zgVAUJj5Z4q6C9ZqO0rq/kxl0ZQ0bFrXg2qcUVtHtAE=;
 b=XDKEk8wIWhV1zwQwY+X/EnoIK9MuaX1NjM9txJqmmXFrbDOKs7ZBlCUb3nrGeASIl/bj/v8yDez2YC7ckazqJkUEH22WfSDD48WIlU6WMQLn4gPFohVjsPPF8eB4NsZuxS1LMHwKomy+no9E7pppkLXDrVw4/nrezqc1Er1y7Z67r4Fnag0JKbH5CaorzWYogTSVGFmg47eWRtWbAuMtkRl5gSfG9lyRhlXNExrUlRsnXGGM0JWHttgnPbmXh/N8UAh3/+FoXV+yLUEyZcpP63pO3louJ4mhrctfJ1acOIAgJTGKvESGwHeOsQO4cA+Q6ISg0vJ287oaPc5pzLcMVw==
X-Mailgun-Sid: WyJiNjdhNCIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjU0ZWY0Il0=
Received: from fedora (pub082136115007.dh-hfc.datazug.ch [82.136.115.7]) by
 3410bf604baf3b1186e1b7c3ddb9946731989e4e31ae93aebc8156634f8d87f1 with SMTP id
 68d3ba80ccb80735fe678ef9; Wed, 24 Sep 2025 09:31:44 GMT
X-Mailgun-Sending-Ip: 161.38.204.227
From: Alessandro Ratti <alessandro@0x65c.net>
To: berrange@redhat.com
Cc: alessandro.ratti@gmail.com, alessandro@0x65c.net, alex.bennee@linaro.org,
 armbru@redhat.com, mst@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3] virtio: improve virtqueue mapping error messages
Date: Wed, 24 Sep 2025 11:14:04 +0200
Message-ID: <20250924093138.559872-2-alessandro@0x65c.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924093138.559872-1-alessandro@0x65c.net>
References: <aNLIHOwcGB47qbUY@redhat.com>
 <20250924093138.559872-1-alessandro@0x65c.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=161.38.204.227;
 envelope-from=bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net;
 helo=m204-227.eu.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Improve error reporting when virtqueue ring mapping fails by including a
device identifier in the error message.

Introduce a helper qdev_get_printable_name() in qdev-core, which returns
either:

 - the device ID, if explicitly provided (e.g. -device ...,id=foo)
 - the QOM path from qdev_get_dev_path(dev) otherwise
 - "<unknown device>" as a fallback when no identifier is present

This makes it easier to identify which device triggered the error in
multi-device setups or when debugging complex guest configurations.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/230
Buglink: https://bugs.launchpad.net/qemu/+bug/1919021

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
---
 hw/core/qdev.c         | 29 +++++++++++++++++++++++++++++
 hw/virtio/virtio.c     | 15 ++++++++++++---
 include/hw/qdev-core.h |  1 +
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index f600226176..fab42a7270 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -411,6 +411,35 @@ char *qdev_get_dev_path(DeviceState *dev)
     return NULL;
 }
 
+const char *qdev_get_printable_name(DeviceState *vdev)
+{
+    /*
+     * Return device ID if explicity set
+     * (e.g. -device virtio-blk-pci,id=foo)
+     * This allows users to correlate errors with their custom device
+     * names.
+     */
+    if (vdev->id) {
+        return vdev->id;
+    }
+    /*
+     * Fall back to the canonical QOM device path (eg. ID for PCI
+     * devices).
+     * This ensures the device is still uniquely and meaningfully
+     * identified.
+     */
+    const char *path = qdev_get_dev_path(vdev);
+    if (path) {
+        return path;
+    }
+
+    /*
+     * Final fallback: if all else fails, return a placeholder string.
+     * This ensures the error message always contains a valid string.
+     */
+    return "<unknown device>";
+}
+
 void qdev_add_unplug_blocker(DeviceState *dev, Error *reason)
 {
     dev->unplug_blockers = g_slist_prepend(dev->unplug_blockers, reason);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 9a81ad912e..0caea5b8ce 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -256,7 +256,10 @@ void virtio_init_region_cache(VirtIODevice *vdev, int n)
     len = address_space_cache_init(&new->desc, vdev->dma_as,
                                    addr, size, packed);
     if (len < size) {
-        virtio_error(vdev, "Cannot map desc");
+        virtio_error(vdev,
+                "Failed to map descriptor ring for device %s: "
+                "invalid guest physical address or corrupted queue setup",
+                qdev_get_printable_name(DEVICE(vdev)));
         goto err_desc;
     }
 
@@ -264,7 +267,10 @@ void virtio_init_region_cache(VirtIODevice *vdev, int n)
     len = address_space_cache_init(&new->used, vdev->dma_as,
                                    vq->vring.used, size, true);
     if (len < size) {
-        virtio_error(vdev, "Cannot map used");
+        virtio_error(vdev,
+                "Failed to map used ring for device %s: "
+                "possible guest misconfiguration or insufficient memory",
+                qdev_get_printable_name(DEVICE(vdev)));
         goto err_used;
     }
 
@@ -272,7 +278,10 @@ void virtio_init_region_cache(VirtIODevice *vdev, int n)
     len = address_space_cache_init(&new->avail, vdev->dma_as,
                                    vq->vring.avail, size, false);
     if (len < size) {
-        virtio_error(vdev, "Cannot map avail");
+        virtio_error(vdev,
+                "Failed to map avalaible ring for device %s: "
+                "possible queue misconfiguration or overlapping memory region",
+                qdev_get_printable_name(DEVICE(vdev)));
         goto err_avail;
     }
 
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 530f3da702..a7bfb10dc7 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -1064,6 +1064,7 @@ bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp);
 extern bool qdev_hot_removed;
 
 char *qdev_get_dev_path(DeviceState *dev);
+const char *qdev_get_printable_name(DeviceState *dev);
 
 void qbus_set_hotplug_handler(BusState *bus, Object *handler);
 void qbus_set_bus_hotplug_handler(BusState *bus);
-- 
2.39.5


