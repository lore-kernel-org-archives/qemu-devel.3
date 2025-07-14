Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87B1C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 17:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubMh9-0005aE-Ed; Mon, 14 Jul 2025 13:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubLbw-00052o-IO; Mon, 14 Jul 2025 12:01:00 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubLbt-0008HH-CZ; Mon, 14 Jul 2025 12:00:59 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bgn7t5sMHz6M4Wm;
 Mon, 14 Jul 2025 23:59:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 766801402ED;
 Tue, 15 Jul 2025 00:00:51 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Jul 2025 18:00:42 +0200
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <shameerkolothum@gmail.com>
Subject: [RFC PATCH v3 04/15] hw/arm/smmu-common: Introduce
 smmu_iommu_ops_by_type() helper
Date: Mon, 14 Jul 2025 16:59:30 +0100
Message-ID: <20250714155941.22176-5-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.203.177.241]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
From:  Shameer Kolothum via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Allows to retrieve the PCIIOMMUOps based on the SMMU type. This will be
useful when we add support for accelerated SMMUV3 in subsequent patches
as that requires a different set of callbacks for iommu ops.

No special handling is required for now and returns the default ops
in base SMMU Class.

No functional changes intended.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/smmu-common.c         | 17 +++++++++++++++--
 include/hw/arm/smmu-common.h |  1 +
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 0f1a06cec2..3a1080773a 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -934,6 +934,16 @@ void smmu_inv_notifiers_all(SMMUState *s)
     }
 }
 
+static const PCIIOMMUOps *smmu_iommu_ops_by_type(SMMUState *s)
+{
+    SMMUBaseClass *sbc;
+
+    sbc = ARM_SMMU_CLASS(object_class_by_name(TYPE_ARM_SMMU));
+    assert(sbc->iommu_ops);
+
+    return sbc->iommu_ops;
+}
+
 static void smmu_base_realize(DeviceState *dev, Error **errp)
 {
     SMMUState *s = ARM_SMMU(dev);
@@ -962,6 +972,7 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
      */
     if (pci_bus_is_express(pci_bus) && pci_bus_is_root(pci_bus) &&
         object_dynamic_cast(OBJECT(pci_bus)->parent, TYPE_PCI_HOST_BRIDGE)) {
+        const PCIIOMMUOps  *iommu_ops;
         /*
          * This condition matches either the default pcie.0, pxb-pcie, or
          * pxb-cxl. For both pxb-pcie and pxb-cxl, parent_dev will be set.
@@ -974,10 +985,11 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
             }
         }
 
+        iommu_ops = smmu_iommu_ops_by_type(s);
         if (s->smmu_per_bus) {
-            pci_setup_iommu_per_bus(pci_bus, &smmu_ops, s);
+            pci_setup_iommu_per_bus(pci_bus, iommu_ops, s);
         } else {
-            pci_setup_iommu(pci_bus, &smmu_ops, s);
+            pci_setup_iommu(pci_bus, iommu_ops, s);
         }
         return;
     }
@@ -1018,6 +1030,7 @@ static void smmu_base_class_init(ObjectClass *klass, const void *data)
     device_class_set_parent_realize(dc, smmu_base_realize,
                                     &sbc->parent_realize);
     rc->phases.exit = smmu_base_reset_exit;
+    sbc->iommu_ops = &smmu_ops;
 }
 
 static const TypeInfo smmu_base_info = {
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index c6f899e403..eb94623555 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -171,6 +171,7 @@ struct SMMUBaseClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
+    const PCIIOMMUOps *iommu_ops;
 
 };
 
-- 
2.34.1


