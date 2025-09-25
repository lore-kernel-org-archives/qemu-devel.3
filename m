Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165F5CAC5B1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 16:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1onv-0006K5-7L; Thu, 25 Sep 2025 12:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v1onp-0006IV-Mj; Thu, 25 Sep 2025 12:26:41 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v1oni-0004kw-N0; Thu, 25 Sep 2025 12:26:41 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCHj1M2bdVoozN6Bw--.50399S2;
 Fri, 26 Sep 2025 00:26:30 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDHLestbdVoW_MeAA--.7120S10;
 Fri, 26 Sep 2025 00:26:29 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>, pierrick.bouvier@linaro.org,
 philmd@linaro.org, jean-philippe@linaro.org, smostafa@google.com,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v2 07/14] hw/arm/smmuv3: Make Configuration Cache
 security-state aware
Date: Fri, 26 Sep 2025 00:26:11 +0800
Message-Id: <20250925162618.191242-8-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDHLestbdVoW_MeAA--.7120S10
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAEBWjUSMIHuwAAsK
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoWfJryUKr47Jr4UuFyDXw47Arb_yoW8Gw17to
 WrKr47X3W8WrnruFyvvr1fJa1aqrZYk3y3Kr4Yv3yYganxtF15JFyIyrZxZrn09F45Jr1x
 Ar1fCrWxXF4UAr1rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
 J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
 UUUUUUU==
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

This patch adapts the Configuration Cache (STE/CD caches) to support
multiple security states.

The cache key, previously just the SMMUDevice, is now a composite key
of the SMMUDevice and the security index (sec_idx). This allows for
separate cache entries for the same device when operating in different
security states, preventing aliasing between secure and non-secure
configurations.

The configuration cache invalidation functions have been refactored to
correctly handle multiple security states, ensuring that invalidation
commands operate on the appropriate cache entries.

Finally, checks have been added to the stream table's MMIO read/write
logic to verify if the stream table is writable. This ensures that the
Configuration Cache management is compliant with the architecture.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmu-common.c         | 63 ++++++++++++++++++++++-
 hw/arm/smmuv3.c              | 98 ++++++++++++++++++++++++++++--------
 include/hw/arm/smmu-common.h | 14 ++++++
 3 files changed, 153 insertions(+), 22 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 24db448683..bc13b00f1d 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -30,6 +30,43 @@
 #include "hw/arm/smmu-common.h"
 #include "smmu-internal.h"
 
+/* Configuration Cache Management */
+static guint smmu_config_key_hash(gconstpointer key)
+{
+    const SMMUConfigKey *k = key;
+    return g_direct_hash(k->sdev) ^ (guint)k->sec_idx;
+}
+
+static gboolean smmu_config_key_equal(gconstpointer a, gconstpointer b)
+{
+    const SMMUConfigKey *ka = a;
+    const SMMUConfigKey *kb = b;
+    return ka->sdev == kb->sdev && ka->sec_idx == kb->sec_idx;
+}
+
+SMMUConfigKey smmu_get_config_key(SMMUDevice *sdev, SMMUSecurityIndex sec_idx)
+{
+    SMMUConfigKey key = {.sdev = sdev, .sec_idx = sec_idx};
+    return key;
+}
+
+ARMSecuritySpace smmu_get_security_space(SMMUSecurityIndex sec_idx)
+{
+    switch (sec_idx) {
+    case SMMU_SEC_IDX_S:
+        return ARMSS_Secure;
+    case SMMU_SEC_IDX_NS:
+    default:
+        return ARMSS_NonSecure;
+    }
+}
+
+MemTxAttrs smmu_get_txattrs(SMMUSecurityIndex sec_idx)
+{
+    return (MemTxAttrs) { .secure = sec_idx > SMMU_SEC_IDX_NS ? 1 : 0,
+                          .space = smmu_get_security_space(sec_idx) };
+}
+
 /* Global state for secure address space availability */
 bool arm_secure_as_available;
 
@@ -237,7 +274,8 @@ static gboolean smmu_hash_remove_by_vmid_ipa(gpointer key, gpointer value,
 static gboolean
 smmu_hash_remove_by_sid_range(gpointer key, gpointer value, gpointer user_data)
 {
-    SMMUDevice *sdev = (SMMUDevice *)key;
+    SMMUConfigKey *config_key = (SMMUConfigKey *)key;
+    SMMUDevice *sdev = config_key->sdev;
     uint32_t sid = smmu_get_sid(sdev);
     SMMUSIDRange *sid_range = (SMMUSIDRange *)user_data;
 
@@ -255,6 +293,25 @@ void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range)
                                 &sid_range);
 }
 
+/* Remove all cached configs for a specific device, regardless of security. */
+static gboolean smmu_hash_remove_by_sdev(gpointer key, gpointer value,
+                                         gpointer user_data)
+{
+    SMMUConfigKey *config_key = (SMMUConfigKey *)key;
+    SMMUDevice *target = (SMMUDevice *)user_data;
+
+    if (config_key->sdev != target) {
+        return false;
+    }
+    trace_smmu_config_cache_inv(smmu_get_sid(target));
+    return true;
+}
+
+void smmu_configs_inv_sdev(SMMUState *s, SMMUDevice *sdev)
+{
+    g_hash_table_foreach_remove(s->configs, smmu_hash_remove_by_sdev, sdev);
+}
+
 void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
                          uint8_t tg, uint64_t num_pages, uint8_t ttl)
 {
@@ -942,7 +999,9 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, local_err);
         return;
     }
-    s->configs = g_hash_table_new_full(NULL, NULL, NULL, g_free);
+    s->configs = g_hash_table_new_full(smmu_config_key_hash,
+                                       smmu_config_key_equal,
+                                       g_free, g_free);
     s->iotlb = g_hash_table_new_full(smmu_iotlb_key_hash, smmu_iotlb_key_equal,
                                      g_free, g_free);
     s->smmu_pcibus_by_busptr = g_hash_table_new(NULL, NULL);
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 2efa39b78c..eba709ae2b 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -352,14 +352,13 @@ static void smmuv3_init_regs(SMMUv3State *s)
 }
 
 static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
-                        SMMUEventInfo *event)
+                        SMMUEventInfo *event, SMMUTransCfg *cfg)
 {
     int ret, i;
 
     trace_smmuv3_get_ste(addr);
     /* TODO: guarantee 64-bit single-copy atomicity */
-    ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf),
-                          MEMTXATTRS_UNSPECIFIED);
+    ret = dma_memory_read(cfg->as, addr, buf, sizeof(*buf), cfg->txattrs);
     if (ret != MEMTX_OK) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Cannot fetch pte at address=0x%"PRIx64"\n", addr);
@@ -404,8 +403,7 @@ static int smmu_get_cd(SMMUv3State *s, STE *ste, SMMUTransCfg *cfg,
     }
 
     /* TODO: guarantee 64-bit single-copy atomicity */
-    ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf),
-                          MEMTXATTRS_UNSPECIFIED);
+    ret = dma_memory_read(cfg->as, addr, buf, sizeof(*buf), cfg->txattrs);
     if (ret != MEMTX_OK) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Cannot fetch pte at address=0x%"PRIx64"\n", addr);
@@ -699,8 +697,8 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
         l2_ste_offset = sid & ((1 << sid_split) - 1);
         l1ptr = (dma_addr_t)(strtab_base + l1_ste_offset * sizeof(l1std));
         /* TODO: guarantee 64-bit single-copy atomicity */
-        ret = dma_memory_read(&address_space_memory, l1ptr, &l1std,
-                              sizeof(l1std), MEMTXATTRS_UNSPECIFIED);
+        ret = dma_memory_read(cfg->as, l1ptr,
+                              &l1std, sizeof(l1std), cfg->txattrs);
         if (ret != MEMTX_OK) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "Could not read L1PTR at 0X%"PRIx64"\n", l1ptr);
@@ -742,7 +740,7 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
         addr = strtab_base + sid * sizeof(*ste);
     }
 
-    if (smmu_get_ste(s, addr, ste, event)) {
+    if (smmu_get_ste(s, addr, ste, event, cfg)) {
         return -EINVAL;
     }
 
@@ -900,18 +898,21 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
  *
  * @sdev: SMMUDevice handle
  * @event: output event info
+ * @sec_idx: security index
  *
  * The configuration cache contains data resulting from both STE and CD
  * decoding under the form of an SMMUTransCfg struct. The hash table is indexed
  * by the SMMUDevice handle.
  */
-static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event)
+static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
+                                       SMMUSecurityIndex sec_idx)
 {
     SMMUv3State *s = sdev->smmu;
     SMMUState *bc = &s->smmu_state;
     SMMUTransCfg *cfg;
+    SMMUConfigKey lookup_key = smmu_get_config_key(sdev, sec_idx);
 
-    cfg = g_hash_table_lookup(bc->configs, sdev);
+    cfg = g_hash_table_lookup(bc->configs, &lookup_key);
     if (cfg) {
         sdev->cfg_cache_hits++;
         trace_smmuv3_config_cache_hit(smmu_get_sid(sdev),
@@ -925,9 +926,14 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event)
                             100 * sdev->cfg_cache_hits /
                             (sdev->cfg_cache_hits + sdev->cfg_cache_misses));
         cfg = g_new0(SMMUTransCfg, 1);
+        cfg->sec_idx = sec_idx;
+        cfg->txattrs = smmu_get_txattrs(sec_idx);
+        cfg->as = smmu_get_address_space(sec_idx);
 
         if (!smmuv3_decode_config(&sdev->iommu, cfg, event)) {
-            g_hash_table_insert(bc->configs, sdev, cfg);
+            SMMUConfigKey *persistent_key = g_new(SMMUConfigKey, 1);
+            *persistent_key = smmu_get_config_key(sdev, sec_idx);
+            g_hash_table_insert(bc->configs, persistent_key, cfg);
         } else {
             g_free(cfg);
             cfg = NULL;
@@ -941,8 +947,8 @@ static void smmuv3_flush_config(SMMUDevice *sdev)
     SMMUv3State *s = sdev->smmu;
     SMMUState *bc = &s->smmu_state;
 
-    trace_smmu_config_cache_inv(smmu_get_sid(sdev));
-    g_hash_table_remove(bc->configs, sdev);
+    /* Remove all security-indexed configs for this device */
+    smmu_configs_inv_sdev(bc, sdev);
 }
 
 /* Do translation with TLB lookup. */
@@ -1102,7 +1108,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         goto epilogue;
     }
 
-    cfg = smmuv3_get_config(sdev, &event);
+    cfg = smmuv3_get_config(sdev, &event, sec_idx);
     if (!cfg) {
         status = SMMU_TRANS_ERROR;
         goto epilogue;
@@ -1182,7 +1188,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
 {
     SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
     SMMUEventInfo eventinfo = {.inval_ste_allowed = true};
-    SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo);
+    SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo, SMMU_SEC_IDX_NS);
     IOMMUTLBEvent event;
     uint8_t granule;
 
@@ -1314,6 +1320,38 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
     }
 }
 
+static inline int smmuv3_get_cr0_smmuen(SMMUv3State *s,
+                                        SMMUSecurityIndex sec_idx)
+{
+    return smmu_enabled(s, sec_idx);
+}
+
+static inline int smmuv3_get_cr0ack_smmuen(SMMUv3State *s,
+                                           SMMUSecurityIndex sec_idx)
+{
+    return FIELD_EX32(s->bank[sec_idx].cr0ack, CR0, SMMUEN);
+}
+
+static inline bool smmuv3_is_smmu_enabled(SMMUv3State *s,
+                                          SMMUSecurityIndex sec_idx)
+{
+    int cr0_smmuen = smmuv3_get_cr0_smmuen(s, sec_idx);
+    int cr0ack_smmuen = smmuv3_get_cr0ack_smmuen(s, sec_idx);
+    return (cr0_smmuen == 0 && cr0ack_smmuen == 0);
+}
+
+/* Check if STRTAB_BASE register is writable */
+static bool smmu_strtab_base_writable(SMMUv3State *s, SMMUSecurityIndex sec_idx)
+{
+    /* Check TABLES_PRESET - use NS bank as it's the global setting */
+    if (FIELD_EX32(s->bank[SMMU_SEC_IDX_NS].idr[1], IDR1, TABLES_PRESET)) {
+        return false;
+    }
+
+    /* Check SMMUEN conditions for the specific security domain */
+    return smmuv3_is_smmu_enabled(s, sec_idx);
+}
+
 static int smmuv3_cmdq_consume(SMMUv3State *s, SMMUSecurityIndex sec_idx)
 {
     SMMUState *bs = ARM_SMMU(s);
@@ -1553,6 +1591,11 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
     uint32_t reg_offset = offset & 0xfff;
     switch (reg_offset) {
     case A_STRTAB_BASE:
+        if (!smmu_strtab_base_writable(s, reg_sec_idx)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "STRTAB_BASE write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
         /* Clear reserved bits according to spec */
         s->bank[reg_sec_idx].strtab_base = data & SMMU_STRTAB_BASE_RESERVED;
         return MEMTX_OK;
@@ -1637,14 +1680,29 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         }
         return MEMTX_OK;
     case A_STRTAB_BASE: /* 64b */
-        s->bank[reg_sec_idx].strtab_base =
-            deposit64(s->bank[reg_sec_idx].strtab_base, 0, 32, data);
-        return MEMTX_OK;
     case A_STRTAB_BASE + 4:
-        s->bank[reg_sec_idx].strtab_base =
-            deposit64(s->bank[reg_sec_idx].strtab_base, 32, 32, data);
+        if (!smmu_strtab_base_writable(s, reg_sec_idx)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "STRTAB_BASE write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_STRTAB_BASE_RESERVED;
+        if (reg_offset == A_STRTAB_BASE) {
+            s->bank[reg_sec_idx].strtab_base = deposit64(
+                s->bank[reg_sec_idx].strtab_base, 0, 32, data);
+        } else {
+            s->bank[reg_sec_idx].strtab_base = deposit64(
+                s->bank[reg_sec_idx].strtab_base, 32, 32, data);
+        }
         return MEMTX_OK;
     case A_STRTAB_BASE_CFG:
+        if (!smmu_strtab_base_writable(s, reg_sec_idx)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "STRTAB_BASE_CFG write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
         s->bank[reg_sec_idx].strtab_base_cfg = data;
         if (FIELD_EX32(data, STRTAB_BASE_CFG, FMT) == 1) {
             s->bank[reg_sec_idx].sid_split =
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index cd61c5e126..ed21db7728 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -22,6 +22,7 @@
 #include "hw/sysbus.h"
 #include "hw/pci/pci.h"
 #include "qom/object.h"
+#include "hw/arm/arm-security.h"
 
 #define SMMU_PCI_BUS_MAX                    256
 #define SMMU_PCI_DEVFN_MAX                  256
@@ -53,6 +54,9 @@ typedef enum SMMUSecurityIndex {
     SMMU_SEC_IDX_NUM,
 } SMMUSecurityIndex;
 
+MemTxAttrs smmu_get_txattrs(SMMUSecurityIndex sec_idx);
+ARMSecuritySpace smmu_get_security_space(SMMUSecurityIndex sec_idx);
+
 extern AddressSpace __attribute__((weak)) arm_secure_address_space;
 extern bool arm_secure_as_available;
 void smmu_enable_secure_address_space(void);
@@ -150,6 +154,8 @@ typedef struct SMMUTransCfg {
     /* Used by stage-2 only. */
     struct SMMUS2Cfg s2cfg;
     SMMUSecurityIndex sec_idx; /* cached security index */
+    MemTxAttrs txattrs;        /* cached transaction attributes */
+    AddressSpace *as;          /* cached address space */
 } SMMUTransCfg;
 
 typedef struct SMMUDevice {
@@ -176,6 +182,11 @@ typedef struct SMMUIOTLBKey {
     uint8_t level;
 } SMMUIOTLBKey;
 
+typedef struct SMMUConfigKey {
+    SMMUDevice *sdev;
+    SMMUSecurityIndex sec_idx;
+} SMMUConfigKey;
+
 typedef struct SMMUSIDRange {
     uint32_t start;
     uint32_t end;
@@ -251,6 +262,7 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
 void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
 SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
                                 uint8_t tg, uint8_t level);
+SMMUConfigKey smmu_get_config_key(SMMUDevice *sdev, SMMUSecurityIndex sec_idx);
 void smmu_iotlb_inv_all(SMMUState *s);
 void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid);
 void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
@@ -260,6 +272,8 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
 void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
                         uint64_t num_pages, uint8_t ttl);
 void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range);
+/* Invalidate all cached configs for a given device across all security idx */
+void smmu_configs_inv_sdev(SMMUState *s, SMMUDevice *sdev);
 /* Unmap the range of all the notifiers registered to any IOMMU mr */
 void smmu_inv_notifiers_all(SMMUState *s);
 
-- 
2.34.1


