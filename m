Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF637C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 17:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubMVQ-0007it-33; Mon, 14 Jul 2025 12:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubLcJ-0005O5-8M; Mon, 14 Jul 2025 12:01:32 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubLcH-0008KT-HV; Mon, 14 Jul 2025 12:01:23 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bgn5q1rc0z6L5M0;
 Mon, 14 Jul 2025 23:57:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 9454C140142;
 Tue, 15 Jul 2025 00:01:18 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Jul 2025 18:01:09 +0200
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <shameerkolothum@gmail.com>
Subject: [RFC PATCH v3 07/15] hw/arm/smmuv3: Implement get_viommu_cap()
 callback
Date: Mon, 14 Jul 2025 16:59:33 +0100
Message-ID: <20250714155941.22176-8-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
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

For accelerated SMMUv3, we need nested parent domain creation. Add the
callback support so that VFIO can create a nested parent.

Since 'accel=on' for SMMUv3 requires the guest SMMUv3 to be configured
in Stage 1 mode, ensure that the 'stage' property is explicitly set to
Stage 1.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/smmuv3-accel.c | 15 +++++++++++++++
 hw/arm/virt.c         | 12 ++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 0b0ddb03e2..66cd4f5ece 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -10,6 +10,7 @@
 #include "qemu/error-report.h"
 
 #include "hw/arm/smmuv3.h"
+#include "hw/iommu.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/vfio/pci.h"
@@ -81,8 +82,22 @@ static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
     }
 }
 
+static uint64_t smmuv3_accel_get_viommu_cap(void *opaque)
+{
+    /*
+     * Accelerated smmuv3 support only allowes Guest S1
+     * configuration. Hence report VIOMMU_CAP_STAGE1
+     * so that VFIO can create nested parent domain.
+     * The real nested support should be reported from host
+     * SMMUv3 and if it doesn't, the nested parent allocation
+     * will fail anyway.
+     */
+    return VIOMMU_CAP_STAGE1;
+}
+
 static const PCIIOMMUOps smmuv3_accel_ops = {
     .get_address_space = smmuv3_accel_find_add_as,
+    .get_viommu_cap = smmuv3_accel_get_viommu_cap,
 };
 
 void smmuv3_accel_init(SMMUv3State *s)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 22393cf39e..fdb47eda6a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3053,6 +3053,18 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                 return;
             }
 
+            if (object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
+                char *stage;
+
+                stage = object_property_get_str(OBJECT(dev), "stage",
+                                                &error_fatal);
+                if (*stage && strcmp("1", stage)) {
+                    error_setg(errp, "Only stage1 is supported for SMMUV3 with "
+                               "accel=on");
+                    return;
+                }
+            }
+
             create_smmuv3_dev_dtb(vms, dev, bus);
         }
     }
-- 
2.34.1


