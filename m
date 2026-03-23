Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A869F483E3
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 18:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4k3K-00077J-Gb; Mon, 23 Mar 2026 14:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w4k3D-00076V-HZ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 14:30:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w4k39-0004lw-Dg
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 14:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774290650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pzxoaEkhB7otps6HMAqJRZ/x1aNDQPiCiN27t8VOevc=;
 b=OFsS5lyFC1uKRFsBy0naKl21fOCNje0emljKqxhv87bsnaDxvphpX3x7WTuF466jxmaqJi
 h3LSCM1WDc1OFGqcgjJpfAbxDW5M1WlJQ17FG+2AuGb5vVSS9ezINsVQoIijX6+WDfNG40
 mcOTdgJKMiudYJqy5CnG81T9Q7rUBqs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-IB3lMAgbNmG_i39ycLDM_w-1; Mon,
 23 Mar 2026 14:30:46 -0400
X-MC-Unique: IB3lMAgbNmG_i39ycLDM_w-1
X-Mimecast-MFC-AGG-ID: IB3lMAgbNmG_i39ycLDM_w_1774290645
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03F8A195608B; Mon, 23 Mar 2026 18:30:45 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.126])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 906A11955F42; Mon, 23 Mar 2026 18:30:41 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 skolothumtho@nvidia.com, nicolinc@nvidia.com, nathanc@nvidia.com
Subject: [PATCH] hw/pci/pci: Enforce pci_setup_iommu_per_bus() is called only
 once per bus
Date: Mon, 23 Mar 2026 19:30:20 +0100
Message-ID: <20260323183024.4069032-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
---
 include/hw/pci/pci.h | 16 +++++++++++++++-
 hw/arm/smmu-common.c |  2 +-
 hw/pci/pci.c         |  9 +++++++--
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 5b179091dee..f2448e941a0 100644
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
index 58c4452b1f5..a3aeb5a8796 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -981,7 +981,7 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
         }
 
         if (s->smmu_per_bus) {
-            pci_setup_iommu_per_bus(pci_bus, s->iommu_ops, s);
+            pci_setup_iommu_per_bus(pci_bus, s->iommu_ops, s, errp);
         } else {
             pci_setup_iommu(pci_bus, s->iommu_ops, s);
         }
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 2c3657d00de..5610193783d 100644
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


