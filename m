Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D440CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 12:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUkxV-0001pb-A4; Wed, 03 Jun 2026 08:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wUkxT-0001oq-6Y
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 08:44:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wUkxR-0007QB-F1
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 08:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780490667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nJq3Yilomoh4G5pgvKSFT1iRcAg4pY+FxWyDgGLLhzk=;
 b=XYG460jzhSIdJlw50OkOawPNqjGa/MKH1bVGVufdDWcXOW4xt3/hMzTyoZ8BU7b7jvMTZs
 FDe+BPPDPGSvRUQHuOAQPqgjdX8e7YV3AFltIyUuTYkI/G2Pn+OrVikj3qnJpJjkNld8yi
 OQLF/kjrZYYEqzySn79My/nyzX4yL6Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-NTO66vpZMfy8LfZMvBnHfw-1; Wed,
 03 Jun 2026 08:44:24 -0400
X-MC-Unique: NTO66vpZMfy8LfZMvBnHfw-1
X-Mimecast-MFC-AGG-ID: NTO66vpZMfy8LfZMvBnHfw_1780490662
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AAE01956096; Wed,  3 Jun 2026 12:44:22 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.48.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 031E730001A1; Wed,  3 Jun 2026 12:44:18 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 skolothumtho@nvidia.com, nicolinc@nvidia.com, nathanc@nvidia.com
Subject: [PATCH v2] hw/pci/pci: Enforce pci_setup_iommu_per_bus() is called
 only once per bus
Date: Wed,  3 Jun 2026 14:44:13 +0200
Message-ID: <20260603124415.1120808-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Currently it is possible to attach several arm-smmuv3 devices to the
same bus although it is a wrong setup.

Change the prototype of pci_setup_iommu_per_bus to pass an error
handle. This latter is set when iommu_per_bus is already set and
used by the single caller (smmu_base_realize) to report a useful
error to the end-user.

While at it document pci_setup_iommu_per_bus callback in the header.

Fixes: 66d2f665e163 ("hw/arm/virt: Allow user-creatable SMMUv3 dev instantiation")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nathan Chen <nathanc@nvidia.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

---

v1 -> v2:
- in smmu_base_realize, return if pci_setup_iommu_per_bus returns false
  (Philippe)
---
 include/hw/pci/pci.h | 16 +++++++++++++++-
 hw/arm/smmu-common.c |  4 +++-
 hw/pci/pci.c         |  9 +++++++--
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 5b179091de..f2448e941a 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -863,7 +863,21 @@ int pci_iommu_unregister_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
  */
 void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque);
 
-void pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque);
+/**
+ * pci_setup_iommu_per_bus: Initialize specific IOMMU handlers for a PCIBus
+ *
+ * Similar to pci_setup_iommu but enforces that the iommu only protects
+ * @bus downstream end points and no other bus hierarchy
+ *
+ * @bus: the #PCIBus being updated.
+ * @ops: the #PCIIOMMUOps
+ * @opaque: passed to callbacks of the @ops structure.
+ * @errp: error handle
+ *
+ * Returns false on failure with @errp set, true on success
+ */
+bool pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops,
+                             void *opaque, Error **errp);
 
 pcibus_t pci_bar_address(PCIDevice *d,
                          int reg, uint8_t type, pcibus_t size);
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 58c4452b1f..8e40ba603d 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -981,7 +981,9 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
         }
 
         if (s->smmu_per_bus) {
-            pci_setup_iommu_per_bus(pci_bus, s->iommu_ops, s);
+            if (!pci_setup_iommu_per_bus(pci_bus, s->iommu_ops, s, errp)) {
+                return;
+            }
         } else {
             pci_setup_iommu(pci_bus, s->iommu_ops, s);
         }
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 4298adf5a0..6d54524c9b 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -3307,11 +3307,16 @@ void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
  * IOMMU ops are returned, avoiding the use of the parent’s IOMMU when
  * it's not appropriate.
  */
-void pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops,
-                             void *opaque)
+bool pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops,
+                             void *opaque, Error **errp)
 {
+    if (bus->iommu_per_bus) {
+        error_setg(errp, "An iommu is already attached to this bus");
+        return false;
+    }
     pci_setup_iommu(bus, ops, opaque);
     bus->iommu_per_bus = true;
+    return true;
 }
 
 static void pci_dev_get_w64(PCIBus *b, PCIDevice *dev, void *opaque)
-- 
2.53.0


