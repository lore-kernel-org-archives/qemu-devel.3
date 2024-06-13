Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F360C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 09:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHgh4-0004BF-LQ; Thu, 13 Jun 2024 05:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sHgh2-0004AL-20
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:24:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sHgh0-0005VT-A6
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718270665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r94NMv7Z/JZhX/ECcckkSEZ7FkqSpxYtcu3WDoyIjwk=;
 b=fDIGc57rqjymzdSbhDuSa8WbE7CDYZl3bJgX7Tu/NPNsM341opailTjEO+PdCajNwJffNr
 bfXAN6GllCoYKUeFuyjhBrnvKMYAfsBog8OahTVWJNE6vPjabk6kYFPVdLXA1i1DQqaE34
 oAEfij2kEiBOJL9OmHvLaqnaCjyW630=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-qe1x-bn1OcWeaTiOaBxR_w-1; Thu,
 13 Jun 2024 05:24:21 -0400
X-MC-Unique: qe1x-bn1OcWeaTiOaBxR_w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F09691955E7E; Thu, 13 Jun 2024 09:24:19 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.191])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A654C1956053; Thu, 13 Jun 2024 09:24:15 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, clg@redhat.com, yanghliu@redhat.com,
 zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com
Subject: [PATCH v3 2/7] virtio-iommu: Implement set|unset]_iommu_device()
 callbacks
Date: Thu, 13 Jun 2024 11:20:04 +0200
Message-ID: <20240613092359.847145-3-eric.auger@redhat.com>
In-Reply-To: <20240613092359.847145-1-eric.auger@redhat.com>
References: <20240613092359.847145-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Implement PCIIOMMUOPs [set|unset]_iommu_device() callbacks.
In set(), a VirtioHostIOMMUDevice is allocated which holds
a reference to the HostIOMMUDevice. This object is stored in a hash
table indexed by PCI BDF. The handle to the Host IOMMU device
will allow to retrieve information related to the physical IOMMU.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v2 -> v3:
- include host_iommu_device.h in virtio-iommu.h header
- introduce hiod_destroy() and fix UAF in
  virtio_iommu_unset_iommu_device()
---
 include/hw/virtio/virtio-iommu.h | 10 ++++
 hw/virtio/virtio-iommu.c         | 90 ++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
index 83a52cc446..a5926de947 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -25,6 +25,7 @@
 #include "hw/pci/pci.h"
 #include "qom/object.h"
 #include "qapi/qapi-types-virtio.h"
+#include "sysemu/host_iommu_device.h"
 
 #define TYPE_VIRTIO_IOMMU "virtio-iommu-device"
 #define TYPE_VIRTIO_IOMMU_PCI "virtio-iommu-pci"
@@ -45,6 +46,14 @@ typedef struct IOMMUDevice {
     bool probe_done;
 } IOMMUDevice;
 
+typedef struct VirtioHostIOMMUDevice {
+    void *viommu;
+    PCIBus *bus;
+    uint8_t devfn;
+    HostIOMMUDevice *dev;
+    QLIST_ENTRY(VirtioHostIOMMUDevice) next;
+} VirtioHostIOMMUDevice;
+
 typedef struct IOMMUPciBus {
     PCIBus       *bus;
     IOMMUDevice  *pbdev[]; /* Parent array is sparse, so dynamically alloc */
@@ -57,6 +66,7 @@ struct VirtIOIOMMU {
     struct virtio_iommu_config config;
     uint64_t features;
     GHashTable *as_by_busptr;
+    GHashTable *host_iommu_devices;
     IOMMUPciBus *iommu_pcibus_by_bus_num[PCI_BUS_MAX];
     PCIBus *primary_bus;
     ReservedRegion *prop_resv_regions;
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 1326c6ec41..db842555c8 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -69,6 +69,11 @@ typedef struct VirtIOIOMMUMapping {
     uint32_t flags;
 } VirtIOIOMMUMapping;
 
+struct hiod_key {
+    PCIBus *bus;
+    uint8_t devfn;
+};
+
 static inline uint16_t virtio_iommu_get_bdf(IOMMUDevice *dev)
 {
     return PCI_BUILD_BDF(pci_bus_num(dev->bus), dev->devfn);
@@ -462,8 +467,90 @@ static AddressSpace *virtio_iommu_find_add_as(PCIBus *bus, void *opaque,
     return &sdev->as;
 }
 
+static gboolean hiod_equal(gconstpointer v1, gconstpointer v2)
+{
+    const struct hiod_key *key1 = v1;
+    const struct hiod_key *key2 = v2;
+
+    return (key1->bus == key2->bus) && (key1->devfn == key2->devfn);
+}
+
+static guint hiod_hash(gconstpointer v)
+{
+    const struct hiod_key *key = v;
+    guint value = (guint)(uintptr_t)key->bus;
+
+    return (guint)(value << 8 | key->devfn);
+}
+
+static void hiod_destroy(gpointer v)
+{
+    object_unref(v);
+}
+
+static VirtioHostIOMMUDevice *
+get_host_iommu_device(VirtIOIOMMU *viommu, PCIBus *bus, int devfn) {
+    struct hiod_key key = {
+        .bus = bus,
+        .devfn = devfn,
+    };
+
+    return g_hash_table_lookup(viommu->host_iommu_devices, &key);
+}
+
+static bool virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
+                                          HostIOMMUDevice *hiod, Error **errp)
+{
+    VirtIOIOMMU *viommu = opaque;
+    VirtioHostIOMMUDevice *vhiod;
+    struct hiod_key *new_key;
+
+    assert(hiod);
+
+    vhiod = get_host_iommu_device(viommu, bus, devfn);
+    if (vhiod) {
+        error_setg(errp, "VirtioHostIOMMUDevice already exists");
+        return false;
+    }
+
+    vhiod = g_malloc0(sizeof(VirtioHostIOMMUDevice));
+    vhiod->bus = bus;
+    vhiod->devfn = (uint8_t)devfn;
+    vhiod->viommu = viommu;
+    vhiod->dev = hiod;
+
+    new_key = g_malloc(sizeof(*new_key));
+    new_key->bus = bus;
+    new_key->devfn = devfn;
+
+    object_ref(hiod);
+    g_hash_table_insert(viommu->host_iommu_devices, new_key, vhiod);
+
+    return true;
+}
+
+static void
+virtio_iommu_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
+{
+    VirtIOIOMMU *viommu = opaque;
+    VirtioHostIOMMUDevice *vhiod;
+    struct hiod_key key = {
+        .bus = bus,
+        .devfn = devfn,
+    };
+
+    vhiod = g_hash_table_lookup(viommu->host_iommu_devices, &key);
+    if (!vhiod) {
+        return;
+    }
+
+    g_hash_table_remove(viommu->host_iommu_devices, &key);
+}
+
 static const PCIIOMMUOps virtio_iommu_ops = {
     .get_address_space = virtio_iommu_find_add_as,
+    .set_iommu_device = virtio_iommu_set_iommu_device,
+    .unset_iommu_device = virtio_iommu_unset_iommu_device,
 };
 
 static int virtio_iommu_attach(VirtIOIOMMU *s,
@@ -1357,6 +1444,9 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
 
     s->as_by_busptr = g_hash_table_new_full(NULL, NULL, NULL, g_free);
 
+    s->host_iommu_devices = g_hash_table_new_full(hiod_hash, hiod_equal,
+                                                  g_free, hiod_destroy);
+
     if (s->primary_bus) {
         pci_setup_iommu(s->primary_bus, &virtio_iommu_ops, s);
     } else {
-- 
2.41.0


