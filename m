Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57137C83F21
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 17:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubMZy-00053q-VG; Mon, 14 Jul 2025 13:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubLd2-0005bF-Ur; Mon, 14 Jul 2025 12:02:19 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubLd0-0008QQ-J9; Mon, 14 Jul 2025 12:02:08 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bgn9R1kCCz6L5jt;
 Tue, 15 Jul 2025 00:00:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 277751402FB;
 Tue, 15 Jul 2025 00:02:04 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Jul 2025 18:01:55 +0200
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <shameerkolothum@gmail.com>
Subject: [RFC PATCH v3 12/15] hw/arm/smmuv3-accel: Introduce helpers to batch
 and issue cache invalidations
Date: Mon, 14 Jul 2025 16:59:38 +0100
Message-ID: <20250714155941.22176-13-shameerali.kolothum.thodi@huawei.com>
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

From: Nicolin Chen <nicolinc@nvidia.com>

Helpers will batch the commands and issue at once to host SMMUv3.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/smmuv3-accel.c    | 65 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h    | 16 ++++++++++
 hw/arm/smmuv3-internal.h | 12 ++++++++
 3 files changed, 93 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 04c665ccf5..1298b4f6d0 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -168,6 +168,71 @@ smmuv3_accel_install_nested_ste_range(SMMUState *bs, SMMUSIDRange *range)
     g_hash_table_foreach(bs->configs, smmuv3_accel_ste_range, range);
 }
 
+/* Update batch->ncmds to the number of execute cmds */
+bool smmuv3_accel_issue_cmd_batch(SMMUState *bs, SMMUCommandBatch *batch)
+{
+    SMMUv3State *s = ARM_SMMUV3(bs);
+    SMMUv3AccelState *s_accel = s->s_accel;
+    uint32_t total = batch->ncmds;
+    IOMMUFDViommu *viommu_core;
+    int ret;
+
+    if (!bs->accel) {
+        return true;
+    }
+
+    if (!s_accel->viommu) {
+        return true;
+    }
+
+    viommu_core = &s_accel->viommu->core;
+    ret = iommufd_backend_invalidate_cache(viommu_core->iommufd,
+                                           viommu_core->viommu_id,
+                                           IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3,
+                                           sizeof(Cmd), &batch->ncmds,
+                                           batch->cmds, NULL);
+    if (!ret || total != batch->ncmds) {
+        error_report("%s failed: ret=%d, total=%d, done=%d",
+                      __func__, ret, total, batch->ncmds);
+        return ret;
+    }
+
+    batch->ncmds = 0;
+    return ret;
+}
+
+/*
+ * Note: sdev can be NULL for certain invalidation commands
+ * e.g., SMMU_CMD_TLBI_NH_ASID, SMMU_CMD_TLBI_NH_VA etc.
+ */
+void smmuv3_accel_batch_cmd(SMMUState *bs, SMMUDevice *sdev,
+                           SMMUCommandBatch *batch, Cmd *cmd,
+                           uint32_t *cons)
+{
+    if (!bs->accel) {
+        return;
+    }
+
+   /*
+    * We may end up here for any emulated PCI bridge or root port type
+    * devices. The batching of commands only matters for vfio-pci endpoint
+    * devices with Guest S1 translation enabled. Hence check that, if
+    * sdev is available.
+    */
+    if (sdev) {
+        SMMUv3AccelDevice *accel_dev;
+        accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
+
+        if (!accel_dev->s1_hwpt) {
+            return;
+        }
+    }
+
+    batch->cmds[batch->ncmds] = *cmd;
+    batch->cons[batch->ncmds++] = *cons;
+    return;
+}
+
 static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
                                                 PCIBus *bus, int devfn)
 {
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 21028e60c8..d06c9664ba 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -13,6 +13,7 @@
 #include "hw/arm/smmu-common.h"
 #include "system/iommufd.h"
 #include <linux/iommufd.h>
+#include "smmuv3-internal.h"
 #include CONFIG_DEVICES
 
 typedef struct SMMUS2Hwpt {
@@ -55,6 +56,10 @@ void smmuv3_accel_init(SMMUv3State *s);
 void smmuv3_accel_install_nested_ste(SMMUState *bs, SMMUDevice *sdev, int sid);
 void smmuv3_accel_install_nested_ste_range(SMMUState *bs,
                                            SMMUSIDRange *range);
+bool smmuv3_accel_issue_cmd_batch(SMMUState *bs, SMMUCommandBatch *batch);
+void smmuv3_accel_batch_cmd(SMMUState *bs, SMMUDevice *sdev,
+                           SMMUCommandBatch *batch, struct Cmd *cmd,
+                           uint32_t *cons);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *d)
 {
@@ -67,6 +72,17 @@ static inline void
 smmuv3_accel_install_nested_ste_range(SMMUState *bs, SMMUSIDRange *range)
 {
 }
+static inline bool smmuv3_accel_issue_cmd_batch(SMMUState *bs,
+                                               SMMUCommandBatch *batch)
+{
+    return true;
+}
+static inline void smmuv3_accel_batch_cmd(SMMUState *bs, SMMUDevice *sdev,
+                                          SMMUCommandBatch *batch,
+                                          struct Cmd *cmd, uint32_t *cons)
+{
+    return;
+}
 #endif
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 738061c6ad..8cb6a9238a 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -547,6 +547,18 @@ typedef struct CD {
     uint32_t word[16];
 } CD;
 
+/*
+ * SMMUCommandBatch - batch of invalidation commands for accel smmuv3
+ * @cmds: Pointer to list of commands
+ * @cons: Pointer to list of CONS corresponding to the commands
+ * @ncmds: Number of cmds in the batch
+ */
+typedef struct SMMUCommandBatch {
+    struct Cmd *cmds;
+    uint32_t *cons;
+    uint32_t ncmds;
+} SMMUCommandBatch;
+
 int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
                   SMMUEventInfo *event);
 void smmuv3_flush_config(SMMUDevice *sdev);
-- 
2.34.1


