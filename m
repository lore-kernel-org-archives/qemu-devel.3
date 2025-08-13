Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7C7C87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 10:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1um8kC-0008BZ-WC; Wed, 13 Aug 2025 06:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1um8k8-00085j-Dg
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 06:30:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1um8k3-0007eu-Om
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 06:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755080996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2+MKs/yjc1l0NF8TfNQfWDOWuLEQ1HKvzElZTYlg07g=;
 b=EYw+LwH/PZMyEqYiwOiUBIku7HNi0IburUuMFP/79BajIAAzQVFIyz0f2lVMeXRuVfKFNG
 QvY9k6OQPEdp2UysuKZwKEy3iosOG0n4e70kea6U/oW1lcYJ3w4Iijg37R+AgCQK37o/BY
 nT4v6WYYhjU/ZPN3arJETVz10eqZglY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-bC-CPRsgNYeDQoSla0ObBA-1; Wed,
 13 Aug 2025 06:29:55 -0400
X-MC-Unique: bC-CPRsgNYeDQoSla0ObBA-1
X-Mimecast-MFC-AGG-ID: bC-CPRsgNYeDQoSla0ObBA_1755080994
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 34B0D180035B; Wed, 13 Aug 2025 10:29:54 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 236A219560AB; Wed, 13 Aug 2025 10:29:49 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v5 06/13] virtio-pci: implement support for extended features
Date: Wed, 13 Aug 2025 12:28:19 +0200
Message-ID: <3128f0b58b3edd91c6416b75a720eb43cbe70d16.1755080614.git.pabeni@redhat.com>
In-Reply-To: <cover.1755080613.git.pabeni@redhat.com>
References: <cover.1755080613.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Extend the features configuration space to 128 bits. If the virtio
device supports any extended features, allow the common read/write
operation to access all of it, otherwise keep exposing only the
lower 64 bits.

On migration, save the 128 bit version of the features only if the
upper bits are non zero. Relay on reset to clear all the feature
space before load.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v4 -> v5:
  - add blank line after QEMU_BUILD_BUG_ON()
  - make virtio_pci_select_max() robust vs future feature space increase

v3 -> v4:
  - use new virtio_features macro names
  - move the build bug before vmstate_virtio_pci_modern_state_sub

v2 -> v3:
  - drop the pre_load/post_load trickery and relay on reset zeroing
    the features instead.
  - avoid union usage, just increase guest_features size and use
    SUB_ARRAY.
  - drop unneeded '!!'
  - _array -> _ex

v1 -> v2:
  - use separate VMStateDescription and pre/post load to avoid breaking
    migration
  - clear proxy features on device reset
---
 hw/virtio/virtio-pci.c         | 74 +++++++++++++++++++++++++++++-----
 include/hw/virtio/virtio-pci.h |  2 +-
 2 files changed, 66 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 767216d795..563528ca31 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -109,6 +109,29 @@ static const VMStateDescription vmstate_virtio_pci_modern_queue_state = {
     }
 };
 
+static bool virtio_pci_modern_state_features128_needed(void *opaque)
+{
+    VirtIOPCIProxy *proxy = opaque;
+    uint32_t features = 0;
+    int i;
+
+    for (i = 2; i < ARRAY_SIZE(proxy->guest_features); ++i) {
+        features |= proxy->guest_features[i];
+    }
+    return features;
+}
+
+static const VMStateDescription vmstate_virtio_pci_modern_state_features128 = {
+    .name = "virtio_pci/modern_state/features128",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = &virtio_pci_modern_state_features128_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_SUB_ARRAY(guest_features, VirtIOPCIProxy, 2, 2),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool virtio_pci_modern_state_needed(void *opaque)
 {
     VirtIOPCIProxy *proxy = opaque;
@@ -116,6 +139,12 @@ static bool virtio_pci_modern_state_needed(void *opaque)
     return virtio_pci_modern(proxy);
 }
 
+/*
+ * Avoid silently breaking migration should the feature space increase
+ * even more in the (far away) future
+ */
+QEMU_BUILD_BUG_ON(VIRTIO_FEATURES_NU32S != 4);
+
 static const VMStateDescription vmstate_virtio_pci_modern_state_sub = {
     .name = "virtio_pci/modern_state",
     .version_id = 1,
@@ -124,11 +153,15 @@ static const VMStateDescription vmstate_virtio_pci_modern_state_sub = {
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(dfselect, VirtIOPCIProxy),
         VMSTATE_UINT32(gfselect, VirtIOPCIProxy),
-        VMSTATE_UINT32_ARRAY(guest_features, VirtIOPCIProxy, 2),
+        VMSTATE_UINT32_SUB_ARRAY(guest_features, VirtIOPCIProxy, 0, 2),
         VMSTATE_STRUCT_ARRAY(vqs, VirtIOPCIProxy, VIRTIO_QUEUE_MAX, 0,
                              vmstate_virtio_pci_modern_queue_state,
                              VirtIOPCIQueue),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_virtio_pci_modern_state_features128,
+        NULL
     }
 };
 
@@ -1477,6 +1510,17 @@ int virtio_pci_add_shm_cap(VirtIOPCIProxy *proxy,
     return virtio_pci_add_mem_cap(proxy, &cap.cap);
 }
 
+static int virtio_pci_select_max(const VirtIODevice *vdev)
+{
+    int i;
+
+    for (i = VIRTIO_FEATURES_NU64S - 1; i > 0; i--)
+        if (vdev->host_features_ex[i])
+            return (i + 1) * 2;
+
+    return 2;
+}
+
 static uint64_t virtio_pci_common_read(void *opaque, hwaddr addr,
                                        unsigned size)
 {
@@ -1494,18 +1538,21 @@ static uint64_t virtio_pci_common_read(void *opaque, hwaddr addr,
         val = proxy->dfselect;
         break;
     case VIRTIO_PCI_COMMON_DF:
-        if (proxy->dfselect <= 1) {
+        if (proxy->dfselect < virtio_pci_select_max(vdev)) {
             VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
 
-            val = (vdev->host_features & ~vdc->legacy_features) >>
-                (32 * proxy->dfselect);
+            val = vdev->host_features_ex[proxy->dfselect >> 1] >>
+                  (32 * (proxy->dfselect & 1));
+            if (proxy->dfselect <= 1) {
+                val &= (~vdc->legacy_features) >> (32 * proxy->dfselect);
+            }
         }
         break;
     case VIRTIO_PCI_COMMON_GFSELECT:
         val = proxy->gfselect;
         break;
     case VIRTIO_PCI_COMMON_GF:
-        if (proxy->gfselect < ARRAY_SIZE(proxy->guest_features)) {
+        if (proxy->gfselect < virtio_pci_select_max(vdev)) {
             val = proxy->guest_features[proxy->gfselect];
         }
         break;
@@ -1588,11 +1635,18 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
         proxy->gfselect = val;
         break;
     case VIRTIO_PCI_COMMON_GF:
-        if (proxy->gfselect < ARRAY_SIZE(proxy->guest_features)) {
+        if (proxy->gfselect < virtio_pci_select_max(vdev)) {
+            uint64_t features[VIRTIO_FEATURES_NU64S];
+            int i;
+
             proxy->guest_features[proxy->gfselect] = val;
-            virtio_set_features(vdev,
-                                (((uint64_t)proxy->guest_features[1]) << 32) |
-                                proxy->guest_features[0]);
+            virtio_features_clear(features);
+            for (i = 0; i < ARRAY_SIZE(proxy->guest_features); ++i) {
+                uint64_t cur = proxy->guest_features[i];
+
+                features[i >> 1] |= cur << ((i & 1) * 32);
+            }
+            virtio_set_features_ex(vdev, features);
         }
         break;
     case VIRTIO_PCI_COMMON_MSIX:
@@ -2311,6 +2365,8 @@ static void virtio_pci_reset(DeviceState *qdev)
     virtio_bus_reset(bus);
     msix_unuse_all_vectors(&proxy->pci_dev);
 
+    memset(proxy->guest_features, 0, sizeof(proxy->guest_features));
+
     for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
         proxy->vqs[i].enabled = 0;
         proxy->vqs[i].reset = 0;
diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index eab5394898..639752977e 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -158,7 +158,7 @@ struct VirtIOPCIProxy {
     uint32_t nvectors;
     uint32_t dfselect;
     uint32_t gfselect;
-    uint32_t guest_features[2];
+    uint32_t guest_features[VIRTIO_FEATURES_NU32S];
     VirtIOPCIQueue vqs[VIRTIO_QUEUE_MAX];
 
     VirtIOIRQFD *vector_irqfd;
-- 
2.50.1


