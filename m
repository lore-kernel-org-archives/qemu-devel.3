Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB12C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 14:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts0Ms-0006Rm-Jm; Tue, 11 Mar 2025 10:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ts0Mp-00069n-I3; Tue, 11 Mar 2025 10:13:59 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ts0Mn-00079R-9s; Tue, 11 Mar 2025 10:13:59 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZBwf03jm1z6D9Ry;
 Tue, 11 Mar 2025 22:10:48 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 60100140B63;
 Tue, 11 Mar 2025 22:13:55 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Mar 2025 15:13:48 +0100
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [RFC PATCH v2 13/20] hw/arm/smmuv3-accel: Introduce helpers to batch
 and issue cache invalidations
Date: Tue, 11 Mar 2025 14:10:38 +0000
Message-ID: <20250311141045.66620-14-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.203.177.241]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Inroduce an SMMUCommandBatch and some helpers to batch and issue the
commands.  Currently separate out TLBI commands and device cache commands
to avoid some errata on certain versions of SMMUs. Later it should check
IIDR register to detect if underlying SMMU hw has such an erratum.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/smmuv3-accel.c    | 69 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-internal.h | 29 +++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 76134d106a..09be838d22 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -160,6 +160,75 @@ void smmuv3_accel_install_nested_ste(SMMUDevice *sdev, int sid)
                                           nested_data.ste[0]);
 }
 
+/* Update batch->ncmds to the number of execute cmds */
+int smmuv3_accel_issue_cmd_batch(SMMUState *bs, SMMUCommandBatch *batch)
+{
+    SMMUv3AccelState *s_accel = ARM_SMMUV3_ACCEL(bs);
+    uint32_t total = batch->ncmds;
+    IOMMUFDViommu *viommu_core;
+    int ret;
+
+    if (!bs->accel) {
+        return 0;
+    }
+
+    if (!s_accel->viommu) {
+        return 0;
+    }
+    viommu_core = &s_accel->viommu->core;
+    ret = iommufd_backend_invalidate_cache(viommu_core->iommufd,
+                                           viommu_core->viommu_id,
+                                           IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3,
+                                           sizeof(Cmd), &batch->ncmds,
+                                           batch->cmds);
+    if (total != batch->ncmds) {
+        error_report("%s failed: ret=%d, total=%d, done=%d",
+                      __func__, ret, total, batch->ncmds);
+        return ret;
+    }
+
+    batch->ncmds = 0;
+    batch->dev_cache = false;
+    return ret;
+}
+
+int smmuv3_accel_batch_cmds(SMMUState *bs, SMMUDevice *sdev,
+                            SMMUCommandBatch *batch, Cmd *cmd,
+                            uint32_t *cons, bool dev_cache)
+{
+    int ret;
+
+    if (!bs->accel) {
+        return 0;
+    }
+
+    if (sdev) {
+        SMMUv3AccelDevice *accel_dev;
+        accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
+        if (!accel_dev->s1_hwpt) {
+            return 0;
+        }
+    }
+
+    /*
+     * Currently separate out dev_cache and hwpt for safety, which might
+     * not be necessary if underlying HW SMMU does not have the errata.
+     *
+     * TODO check IIDR register values read from hw_info.
+     */
+    if (batch->ncmds && (dev_cache != batch->dev_cache)) {
+        ret = smmuv3_accel_issue_cmd_batch(bs, batch);
+        if (ret) {
+            *cons = batch->cons[batch->ncmds];
+            return ret;
+        }
+    }
+    batch->dev_cache = dev_cache;
+    batch->cmds[batch->ncmds] = *cmd;
+    batch->cons[batch->ncmds++] = *cons;
+    return 0;
+}
+
 static bool
 smmuv3_accel_dev_attach_viommu(SMMUv3AccelDevice *accel_dev,
                                HostIOMMUDeviceIOMMUFD *idev, Error **errp)
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 46c8bcae14..4602ae6728 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -549,13 +549,42 @@ typedef struct CD {
     uint32_t word[16];
 } CD;
 
+/**
+ * SMMUCommandBatch - batch of invalidation commands for smmuv3-accel
+ * @cmds: Pointer to list of commands
+ * @cons: Pointer to list of CONS corresponding to the commands
+ * @ncmds: Total ncmds in the batch
+ * @dev_cache: Issue to a device cache
+ */
+typedef struct SMMUCommandBatch {
+    Cmd *cmds;
+    uint32_t *cons;
+    uint32_t ncmds;
+    bool dev_cache;
+} SMMUCommandBatch;
+
 int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
                   SMMUEventInfo *event);
 void smmuv3_flush_config(SMMUDevice *sdev);
 
 #if defined(CONFIG_ARM_SMMUV3_ACCEL) && defined(CONFIG_IOMMUFD)
+int smmuv3_accel_issue_cmd_batch(SMMUState *bs, SMMUCommandBatch *batch);
+int smmuv3_accel_batch_cmds(SMMUState *bs, SMMUDevice *sdev,
+                            SMMUCommandBatch *batch, Cmd *cmd,
+                            uint32_t *cons, bool dev_cache);
 void smmuv3_accel_install_nested_ste(SMMUDevice *sdev, int sid);
 #else
+static inline int smmuv3_accel_issue_cmd_batch(SMMUState *bs,
+                                               SMMUCommandBatch *batch)
+{
+    return 0;
+}
+static inline int smmuv3_accel_batch_cmds(SMMUState *bs, SMMUDevice *sdev,
+                                          SMMUCommandBatch *batch, Cmd *cmd,
+                                          uint32_t *cons, bool dev_cache)
+{
+    return 0;
+}
 static inline void smmuv3_accel_install_nested_ste(SMMUDevice *sdev, int sid)
 {
 }
-- 
2.34.1


