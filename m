Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4411CC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 04:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tns1p-0005ZB-Bp; Thu, 27 Feb 2025 23:31:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jansef.jian@hj-micro.com>)
 id 1tns1d-0005RQ-TA
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 23:31:08 -0500
Received: from mail-m49218.qiye.163.com ([45.254.49.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jansef.jian@hj-micro.com>)
 id 1tns1a-0008Q7-8l
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 23:31:01 -0500
Received: from localhost.localdomain (unknown [219.146.33.230])
 by smtp.qiye.163.com (Hmail) with ESMTP id c761fdbd;
 Fri, 28 Feb 2025 11:15:10 +0800 (GMT+08:00)
From: JianChunfu <jansef.jian@hj-micro.com>
To: eric.auger@redhat.com,
	peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 JianChunfu <jansef.jian@hj-micro.com>
Subject: [PATCH v3] hw/arm/smmu: Introduce smmu_configs_inv_sid_range() helper
Date: Fri, 28 Feb 2025 11:14:38 +0800
Message-ID: <20250228031438.3916-1-jansef.jian@hj-micro.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTE8YVkhISEpDQxoaTBpCSlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJSkJVSk9NVUhIVUlIS1lXWRYaDxIVHRRZQVlLVUtVS1VLWQY+
X-HM-Tid: 0a954a8d061a09d2kunmc761fdbd
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OSI6Fhw5SzIQDQw5KyMeATYL
 SD4KCipVSlVKTE9LTEpJTkpJSUJIVTMWGhIXVREaFQgeHVUREhoVOxMRVhYSGAkUVRgUFkVZV1kS
 C1lBWUlKQlVKT01VSEhVSUhLWVdZCAFZQU1OTUo3Bg++
Received-SPF: pass client-ip=45.254.49.218;
 envelope-from=jansef.jian@hj-micro.com; helo=mail-m49218.qiye.163.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use a similar terminology smmu_hash_remove_by_sid_range() as the one
being used for other hash table matching functions since
smmuv3_invalidate_ste() name is not self explanatory, and introduce a
helper that invokes the g_hash_table_foreach_remove.

No functional change intended.

Signed-off-by: JianChunfu <jansef.jian@hj-micro.com>
---
v3: - Modify the commit msg
    - Rename the trace funtion
v2: - move smmuv3_invalidate_ste() to smmu_hash_remove_by_sid_range()
    - add function smmu_configs_inv_sid_range()
v1: - Rename smmuv3_invalidate_ste to smmuv3_hash_remove_by_sid_range
---
 hw/arm/smmu-common.c         | 21 +++++++++++++++++++++
 hw/arm/smmu-internal.h       |  5 -----
 hw/arm/smmuv3.c              | 19 ++-----------------
 hw/arm/trace-events          |  3 ++-
 include/hw/arm/smmu-common.h |  6 ++++++
 5 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 3f8272875..bad3b3b0b 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -225,6 +225,27 @@ static gboolean smmu_hash_remove_by_vmid_ipa(gpointer key, gpointer value,
            ((entry->iova & ~info->mask) == info->iova);
 }
 
+static gboolean
+smmu_hash_remove_by_sid_range(gpointer key, gpointer value, gpointer user_data)
+{
+    SMMUDevice *sdev = (SMMUDevice *)key;
+    uint32_t sid = smmu_get_sid(sdev);
+    SMMUSIDRange *sid_range = (SMMUSIDRange *)user_data;
+
+    if (sid < sid_range->start || sid > sid_range->end) {
+        return false;
+    }
+    trace_smmu_config_cache_inv(sid);
+    return true;
+}
+
+void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range)
+{
+    trace_smmu_configs_inv_sid_range(sid_range.start, sid_range.end);
+    g_hash_table_foreach_remove(s->configs, smmu_hash_remove_by_sid_range,
+                                &sid_range);
+}
+
 void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
                          uint8_t tg, uint64_t num_pages, uint8_t ttl)
 {
diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
index 843bebb18..d143d296f 100644
--- a/hw/arm/smmu-internal.h
+++ b/hw/arm/smmu-internal.h
@@ -141,9 +141,4 @@ typedef struct SMMUIOTLBPageInvInfo {
     uint64_t mask;
 } SMMUIOTLBPageInvInfo;
 
-typedef struct SMMUSIDRange {
-    uint32_t start;
-    uint32_t end;
-} SMMUSIDRange;
-
 #endif
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 4c49b5a88..1c55bc56d 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -903,7 +903,7 @@ static void smmuv3_flush_config(SMMUDevice *sdev)
     SMMUv3State *s = sdev->smmu;
     SMMUState *bc = &s->smmu_state;
 
-    trace_smmuv3_config_cache_inv(smmu_get_sid(sdev));
+    trace_smmu_config_cache_inv(smmu_get_sid(sdev));
     g_hash_table_remove(bc->configs, sdev);
 }
 
@@ -1277,20 +1277,6 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
     }
 }
 
-static gboolean
-smmuv3_invalidate_ste(gpointer key, gpointer value, gpointer user_data)
-{
-    SMMUDevice *sdev = (SMMUDevice *)key;
-    uint32_t sid = smmu_get_sid(sdev);
-    SMMUSIDRange *sid_range = (SMMUSIDRange *)user_data;
-
-    if (sid < sid_range->start || sid > sid_range->end) {
-        return false;
-    }
-    trace_smmuv3_config_cache_inv(sid);
-    return true;
-}
-
 static int smmuv3_cmdq_consume(SMMUv3State *s)
 {
     SMMUState *bs = ARM_SMMU(s);
@@ -1373,8 +1359,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             sid_range.end = sid_range.start + mask;
 
             trace_smmuv3_cmdq_cfgi_ste_range(sid_range.start, sid_range.end);
-            g_hash_table_foreach_remove(bs->configs, smmuv3_invalidate_ste,
-                                        &sid_range);
+            smmu_configs_inv_sid_range(bs, sid_range);
             break;
         }
         case SMMU_CMD_CFGI_CD:
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index c64ad344b..e96f9ae47 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -15,6 +15,8 @@ smmu_iotlb_inv_asid_vmid(int asid, int vmid) "IOTLB invalidate asid=%d vmid=%d"
 smmu_iotlb_inv_vmid(int vmid) "IOTLB invalidate vmid=%d"
 smmu_iotlb_inv_vmid_s1(int vmid) "IOTLB invalidate vmid=%d"
 smmu_iotlb_inv_iova(int asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
+smmu_configs_inv_sid_range(uint32_t start, uint32_t end) "Config cache INV SID range from 0x%x to 0x%x"
+smmu_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
 smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
 smmu_iotlb_lookup_hit(int asid, int vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
 smmu_iotlb_lookup_miss(int asid, int vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
@@ -52,7 +54,6 @@ smmuv3_cmdq_tlbi_nh(int vmid) "vmid=%d"
 smmuv3_cmdq_tlbi_nsnh(void) ""
 smmuv3_cmdq_tlbi_nh_asid(int asid) "asid=%d"
 smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
-smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
 smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
 smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
 smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index e5ad55bba..e5e2d0929 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -142,6 +142,11 @@ typedef struct SMMUIOTLBKey {
     uint8_t level;
 } SMMUIOTLBKey;
 
+typedef struct SMMUSIDRange {
+    uint32_t start;
+    uint32_t end;
+} SMMUSIDRange;
+
 struct SMMUState {
     /* <private> */
     SysBusDevice  dev;
@@ -219,6 +224,7 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
                          uint8_t tg, uint64_t num_pages, uint8_t ttl);
 void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
                         uint64_t num_pages, uint8_t ttl);
+void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range);
 /* Unmap the range of all the notifiers registered to any IOMMU mr */
 void smmu_inv_notifiers_all(SMMUState *s);
 
-- 
2.47.1


