Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF53C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 17:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubMlk-0002RD-Mb; Mon, 14 Jul 2025 13:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubLdP-0005t2-43; Mon, 14 Jul 2025 12:02:31 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubLdJ-0008SO-P4; Mon, 14 Jul 2025 12:02:30 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bgn7273N3z6L5Ms;
 Mon, 14 Jul 2025 23:58:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 5290214038F;
 Tue, 15 Jul 2025 00:02:22 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Jul 2025 18:02:13 +0200
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <shameerkolothum@gmail.com>
Subject: [RFC PATCH v3 14/15] Read and validate host SMMUv3 feature bits
Date: Mon, 14 Jul 2025 16:59:40 +0100
Message-ID: <20250714155941.22176-15-shameerali.kolothum.thodi@huawei.com>
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

From: Nicolin Chen <nicolinc@nvidia.com>

Not all fields in the SMMU IDR registers are meaningful for userspace.
Only the following fields can be used:

  - IDR0: ST_LEVEL, TERM_MODEL, STALL_MODEL, TTENDIAN, CD2L, ASID16, TTF  
  - IDR1: SIDSIZE, SSIDSIZE  
  - IDR3: BBML, RIL  
  - IDR5: VAX, GRAN64K, GRAN16K, GRAN4K

Use the relevant fields from these to check whether the host and emulated
SMMUv3 features are sufficiently aligned to enable accelerated SMMUv3
support.

To retrieve this information from the host, at least one vfio-pci device
must be assigned with "arm-smmuv3,accel=on" usage. Add a check to enforce
this.

Note:

ATS, PASID, and PRI features are currently not supported. Only devices
that do not require or make use of these features are expected to work.

Also, requiring at least one vfio-pci device to be cold-plugged
complicates hot-unplug and replug scenarios. For example, if all devices
behind the vSMMUv3 are unplugged after the guest boots, and a new device
is later hot-plugged into the same PCI bus, there is no guarantee that
the underlying host SMMUv3 will expose the same feature set as the one
originally used when the vSMMU was initialized.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/smmuv3-accel.c | 103 ++++++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h |   5 ++
 hw/arm/smmuv3.c       |   4 ++
 hw/arm/trace-events   |   2 +-
 4 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 1298b4f6d0..3b2f45bd88 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -23,6 +23,109 @@
 #define SMMU_STE_VALID      (1ULL << 0)
 #define SMMU_STE_CFG_BYPASS (1ULL << 3)
 
+static int
+smmuv3_accel_host_hw_info(SMMUv3AccelDevice *accel_dev, uint32_t *data_type,
+                          uint32_t data_len, void *data)
+{
+    uint64_t caps;
+
+    if (!accel_dev || !accel_dev->idev) {
+        return -ENOENT;
+    }
+
+    return !iommufd_backend_get_device_info(accel_dev->idev->iommufd,
+                                            accel_dev->idev->devid,
+                                            data_type, data,
+                                            data_len, &caps, NULL);
+}
+
+void smmuv3_accel_init_regs(SMMUv3State *s)
+{
+    SMMUv3AccelState *s_accel = s->s_accel;
+    SMMUv3AccelDevice *accel_dev;
+    uint32_t data_type;
+    uint32_t val;
+    int ret;
+
+    if (s_accel->info.idr[0]) {
+        /* We already got this */
+        return;
+    }
+
+    if (!s_accel->viommu || QLIST_EMPTY(&s_accel->viommu->device_list)) {
+        error_report("For arm-smmuv3,accel=on case, atleast one cold-plugged "
+                     "vfio-pci dev needs to be assigned");
+        goto out_err;
+    }
+
+    accel_dev = QLIST_FIRST(&s_accel->viommu->device_list);
+    ret = smmuv3_accel_host_hw_info(accel_dev, &data_type,
+                                    sizeof(s_accel->info), &s_accel->info);
+    if (ret) {
+        error_report("Failed to get Host SMMU device info");
+        goto out_err;
+    }
+
+    if (data_type != IOMMU_HW_INFO_TYPE_ARM_SMMUV3) {
+        error_report("Wrong data type (%d) for Host SMMU device info",
+                     data_type);
+        goto out_err;
+    }
+
+    trace_smmuv3_accel_host_hw_info(s_accel->info.idr[0], s_accel->info.idr[1],
+                                    s_accel->info.idr[3], s_accel->info.idr[5]);
+    /*
+     * QEMU SMMUv3 supports both linear and 2-level stream tables. If host
+     * SMMUv3 supports only linear stream table, report that to Guest.
+     */
+    val = FIELD_EX32(s_accel->info.idr[0], IDR0, STLEVEL);
+    if (val < FIELD_EX32(s->idr[0], IDR0, STLEVEL)) {
+        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, STLEVEL, val);
+    }
+
+    /*
+     * QEMU SMMUv3 supports little-endian support for translation table walks.
+     * If host SMMUv3 supports only big-endian, report error.
+     */
+    val = FIELD_EX32(s_accel->info.idr[0], IDR0, TTENDIAN);
+    if (val > FIELD_EX32(s->idr[0], IDR0, TTENDIAN)) {
+        error_report("Host SUUMU device translation table walk endianess "
+                     "not supported");
+        goto out_err;
+    }
+
+    /*
+     * QEMU SMMUv3 supports AArch64 Translation table format.
+     * If host SMMUv3 supports only AArch32, report error.
+     */
+    val = FIELD_EX32(s_accel->info.idr[0], IDR0, TTF);
+    if (val < FIELD_EX32(s->idr[0], IDR0, TTF)) {
+        error_report("Host SMMU device Translation table format not supported");
+        goto out_err;
+    }
+
+    /*
+     * QEMU SMMUv3 supports 4K/16K/64K translation granules. If host SMMUv3
+     * does't support any of these, report the supported ones only to Guest.
+     */
+    val = FIELD_EX32(s_accel->info.idr[5], IDR5, GRAN4K);
+    if (val < FIELD_EX32(s->idr[5], IDR5, GRAN4K)) {
+        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, val);
+    }
+    val = FIELD_EX32(s_accel->info.idr[5], IDR5, GRAN16K);
+    if (val < FIELD_EX32(s->idr[5], IDR5, GRAN16K)) {
+        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, val);
+    }
+    val = FIELD_EX32(s_accel->info.idr[5], IDR5, GRAN64K);
+    if (val < FIELD_EX32(s->idr[5], IDR5, GRAN64K)) {
+        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, val);
+    }
+    return;
+
+out_err:
+    exit(1);
+}
+
 static void
 smmuv3_accel_dev_uninstall_nested_ste(SMMUv3AccelDevice *accel_dev, bool abort)
 {
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index d06c9664ba..e1e99598b4 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -49,6 +49,7 @@ typedef struct SMMUv3AccelState {
     MemoryRegion root;
     MemoryRegion sysmem;
     SMMUViommu *viommu;
+    struct iommu_hw_info_arm_smmuv3 info;
 } SMMUv3AccelState;
 
 #if defined(CONFIG_ARM_SMMUV3) && defined(CONFIG_IOMMUFD)
@@ -60,6 +61,7 @@ bool smmuv3_accel_issue_cmd_batch(SMMUState *bs, SMMUCommandBatch *batch);
 void smmuv3_accel_batch_cmd(SMMUState *bs, SMMUDevice *sdev,
                            SMMUCommandBatch *batch, struct Cmd *cmd,
                            uint32_t *cons);
+void smmuv3_accel_init_regs(SMMUv3State *s);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *d)
 {
@@ -83,6 +85,9 @@ static inline void smmuv3_accel_batch_cmd(SMMUState *bs, SMMUDevice *sdev,
 {
     return;
 }
+static inline void smmuv3_accel_init_regs(SMMUv3State *s)
+{
+}
 #endif
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 97ecca0764..100e3c8929 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1894,6 +1894,7 @@ static void smmu_init_irq(SMMUv3State *s, SysBusDevice *dev)
  */
 static void smmu_reset_exit(Object *obj, ResetType type)
 {
+    SMMUState *sys = ARM_SMMU(obj);
     SMMUv3State *s = ARM_SMMUV3(obj);
     SMMUv3Class *c = ARM_SMMUV3_GET_CLASS(s);
 
@@ -1903,6 +1904,9 @@ static void smmu_reset_exit(Object *obj, ResetType type)
     }
 
     smmuv3_init_regs(s);
+    if (sys->accel) {
+        smmuv3_accel_init_regs(s);
+    }
 }
 
 static void smmu_realize(DeviceState *d, Error **errp)
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 7d232ca17c..37ecab10a0 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -70,7 +70,7 @@ smmu_reset_exit(void) ""
 smmuv3_accel_set_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x)"
 smmuv3_accel_unset_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x"
 smmuv3_accel_install_nested_ste(uint32_t sid, uint64_t ste_1, uint64_t ste_0) "sid=%d ste=%"PRIx64":%"PRIx64
-
+smmuv3_accel_host_hw_info(uint32_t idr0, uint32_t idr1, uint32_t idr3, uint32_t idr5) "idr0=0x%x idr1=0x%x idr3=0x%x idr5=0x%x"
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
 strongarm_ssp_read_underrun(void) "SSP rx underrun"
-- 
2.34.1


