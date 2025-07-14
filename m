Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A941C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 17:00:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubMXF-000262-5j; Mon, 14 Jul 2025 13:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubLcc-0005ST-5e; Mon, 14 Jul 2025 12:01:49 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubLcZ-0008NW-VX; Mon, 14 Jul 2025 12:01:41 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bgn8m0kHGz6M55b;
 Tue, 15 Jul 2025 00:00:24 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id B656414033F;
 Tue, 15 Jul 2025 00:01:36 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Jul 2025 18:01:28 +0200
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <shameerkolothum@gmail.com>
Subject: [RFC PATCH v3 09/15] hw/arm/smmuv3-accel: Support nested STE
 install/uninstall support
Date: Mon, 14 Jul 2025 16:59:35 +0100
Message-ID: <20250714155941.22176-10-shameerali.kolothum.thodi@huawei.com>
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

Allocates a s1 HWPT for the Guest s1 stage and attaches that
to the dev. This will be invoked when Guest issues
SMMU_CMD_CFGI_STE/STE_RANGE.

While at it, we are also exporting both smmu_find_ste() and
smmuv3_flush_config() from smmuv3.c for use here.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/smmuv3-accel.c    | 130 +++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h    |  17 +++++
 hw/arm/smmuv3-internal.h |   4 ++
 hw/arm/smmuv3.c          |   8 ++-
 hw/arm/trace-events      |   1 +
 5 files changed, 157 insertions(+), 3 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index fe90d48675..74bf20cfaf 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -18,9 +18,139 @@
 
 #include "smmuv3-accel.h"
 
+#include "smmuv3-internal.h"
+
 #define SMMU_STE_VALID      (1ULL << 0)
 #define SMMU_STE_CFG_BYPASS (1ULL << 3)
 
+static void
+smmuv3_accel_dev_uninstall_nested_ste(SMMUv3AccelDevice *accel_dev, bool abort)
+{
+    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
+    SMMUS1Hwpt *s1_hwpt = accel_dev->s1_hwpt;
+    uint32_t hwpt_id;
+
+    if (!s1_hwpt || !accel_dev->viommu) {
+        return;
+    }
+
+    if (abort) {
+        hwpt_id = accel_dev->viommu->abort_hwpt_id;
+    } else {
+        hwpt_id = accel_dev->viommu->bypass_hwpt_id;
+    }
+
+    host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, &error_abort);
+    iommufd_backend_free_id(s1_hwpt->iommufd, s1_hwpt->hwpt_id);
+    accel_dev->s1_hwpt = NULL;
+    g_free(s1_hwpt);
+}
+
+static int
+smmuv3_accel_dev_install_nested_ste(SMMUv3AccelDevice *accel_dev,
+                                    uint32_t data_type, uint32_t data_len,
+                                    void *data)
+{
+    SMMUViommu *viommu = accel_dev->viommu;
+    SMMUS1Hwpt *s1_hwpt = accel_dev->s1_hwpt;
+    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
+    uint32_t flags = 0;
+
+    if (!idev || !viommu) {
+        return -ENOENT;
+    }
+
+    if (s1_hwpt) {
+        smmuv3_accel_dev_uninstall_nested_ste(accel_dev, true);
+    }
+
+    s1_hwpt = g_new0(SMMUS1Hwpt, 1);
+    s1_hwpt->iommufd = idev->iommufd;
+    iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
+                               viommu->core.viommu_id, flags, data_type,
+                               data_len, data, &s1_hwpt->hwpt_id, &error_abort);
+    host_iommu_device_iommufd_attach_hwpt(idev, s1_hwpt->hwpt_id, &error_abort);
+    accel_dev->s1_hwpt = s1_hwpt;
+    return 0;
+}
+
+void smmuv3_accel_install_nested_ste(SMMUState *bs, SMMUDevice *sdev, int sid)
+{
+    SMMUv3AccelDevice *accel_dev;
+    SMMUEventInfo event = {.type = SMMU_EVT_NONE, .sid = sid,
+                           .inval_ste_allowed = true};
+    struct iommu_hwpt_arm_smmuv3 nested_data = {};
+    uint32_t config;
+    STE ste;
+    int ret;
+
+    if (!bs->accel) {
+        return;
+    }
+
+    accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
+    if (!accel_dev->viommu) {
+        return;
+    }
+
+    ret = smmu_find_ste(sdev->smmu, sid, &ste, &event);
+    if (ret) {
+        error_report("failed to find STE for sid 0x%x", sid);
+        return;
+    }
+
+    config = STE_CONFIG(&ste);
+    if (!STE_VALID(&ste) || !STE_CFG_S1_ENABLED(config)) {
+        smmuv3_accel_dev_uninstall_nested_ste(accel_dev, STE_CFG_ABORT(config));
+        smmuv3_flush_config(sdev);
+        return;
+    }
+
+    nested_data.ste[0] = (uint64_t)ste.word[0] | (uint64_t)ste.word[1] << 32;
+    nested_data.ste[1] = (uint64_t)ste.word[2] | (uint64_t)ste.word[3] << 32;
+    /* V | CONFIG | S1FMT | S1CTXPTR | S1CDMAX */
+    nested_data.ste[0] &= 0xf80fffffffffffffULL;
+    /* S1DSS | S1CIR | S1COR | S1CSH | S1STALLD | EATS */
+    nested_data.ste[1] &= 0x380000ffULL;
+    ret = smmuv3_accel_dev_install_nested_ste(accel_dev,
+                                              IOMMU_HWPT_DATA_ARM_SMMUV3,
+                                              sizeof(nested_data),
+                                              &nested_data);
+    if (ret) {
+        error_report("Unable to install nested STE=%16LX:%16LX, sid=0x%x,"
+                      "ret=%d", nested_data.ste[1], nested_data.ste[0],
+                      sid, ret);
+    }
+
+    trace_smmuv3_accel_install_nested_ste(sid, nested_data.ste[1],
+                                          nested_data.ste[0]);
+}
+
+static void
+smmuv3_accel_ste_range(gpointer key, gpointer value, gpointer user_data)
+{
+    SMMUDevice *sdev = (SMMUDevice *)key;
+    uint32_t sid = smmu_get_sid(sdev);
+    SMMUSIDRange *sid_range = (SMMUSIDRange *)user_data;
+
+    if (sid >= sid_range->start && sid <= sid_range->end) {
+        SMMUv3State *s = sdev->smmu;
+        SMMUState *bs = &s->smmu_state;
+
+        smmuv3_accel_install_nested_ste(bs, sdev, sid);
+    }
+}
+
+void
+smmuv3_accel_install_nested_ste_range(SMMUState *bs, SMMUSIDRange *range)
+{
+    if (!bs->accel) {
+        return;
+    }
+
+    g_hash_table_foreach(bs->configs, smmuv3_accel_ste_range, range);
+}
+
 static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
                                                 PCIBus *bus, int devfn)
 {
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 55a6a353fc..06e81b630d 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -29,10 +29,16 @@ typedef struct SMMUViommu {
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
 } SMMUViommu;
 
+typedef struct SMMUS1Hwpt {
+    IOMMUFDBackend *iommufd;
+    uint32_t hwpt_id;
+} SMMUS1Hwpt;
+
 typedef struct SMMUv3AccelDevice {
     SMMUDevice  sdev;
     AddressSpace as_sysmem;
     HostIOMMUDeviceIOMMUFD *idev;
+    SMMUS1Hwpt  *s1_hwpt;
     SMMUViommu *viommu;
     QLIST_ENTRY(SMMUv3AccelDevice) next;
 } SMMUv3AccelDevice;
@@ -45,10 +51,21 @@ typedef struct SMMUv3AccelState {
 
 #if defined(CONFIG_ARM_SMMUV3) && defined(CONFIG_IOMMUFD)
 void smmuv3_accel_init(SMMUv3State *s);
+void smmuv3_accel_install_nested_ste(SMMUState *bs, SMMUDevice *sdev, int sid);
+void smmuv3_accel_install_nested_ste_range(SMMUState *bs,
+                                           SMMUSIDRange *range);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *d)
 {
 }
+static inline void
+smmuv3_accel_install_nested_ste(SMMUState *bs, SMMUDevice *sdev, int sid)
+{
+}
+static inline void
+smmuv3_accel_install_nested_ste_range(SMMUState *bs, SMMUSIDRange *range)
+{
+}
 #endif
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index b6b7399347..738061c6ad 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -547,6 +547,10 @@ typedef struct CD {
     uint32_t word[16];
 } CD;
 
+int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
+                  SMMUEventInfo *event);
+void smmuv3_flush_config(SMMUDevice *sdev);
+
 /* STE fields */
 
 #define STE_VALID(x)   extract32((x)->word[0], 0, 1)
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 2f5a8157dd..c94bfe6564 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -630,8 +630,8 @@ bad_ste:
  * Supports linear and 2-level stream table
  * Return 0 on success, -EINVAL otherwise
  */
-static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
-                         SMMUEventInfo *event)
+int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
+                  SMMUEventInfo *event)
 {
     dma_addr_t addr, strtab_base;
     uint32_t log2size;
@@ -900,7 +900,7 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event)
     return cfg;
 }
 
-static void smmuv3_flush_config(SMMUDevice *sdev)
+void smmuv3_flush_config(SMMUDevice *sdev)
 {
     SMMUv3State *s = sdev->smmu;
     SMMUState *bc = &s->smmu_state;
@@ -1342,6 +1342,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
 
             trace_smmuv3_cmdq_cfgi_ste(sid);
             smmuv3_flush_config(sdev);
+            smmuv3_accel_install_nested_ste(bs, sdev, sid);
 
             break;
         }
@@ -1361,6 +1362,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             sid_range.end = sid_range.start + mask;
 
             trace_smmuv3_cmdq_cfgi_ste_range(sid_range.start, sid_range.end);
+            smmuv3_accel_install_nested_ste_range(bs, &sid_range);
             smmu_configs_inv_sid_range(bs, sid_range);
             break;
         }
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index c4537ca1d6..7d232ca17c 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -69,6 +69,7 @@ smmu_reset_exit(void) ""
 #smmuv3-accel.c
 smmuv3_accel_set_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x)"
 smmuv3_accel_unset_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x"
+smmuv3_accel_install_nested_ste(uint32_t sid, uint64_t ste_1, uint64_t ste_0) "sid=%d ste=%"PRIx64":%"PRIx64
 
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
-- 
2.34.1


