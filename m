Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA006CCD187
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 15:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7xfU-0001fM-2j; Sun, 12 Oct 2025 11:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xfP-0001cG-C7; Sun, 12 Oct 2025 11:07:23 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xfL-0001cq-5T; Sun, 12 Oct 2025 11:07:23 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwA3GGAexOtorE6gAA--.61S2;
 Sun, 12 Oct 2025 23:07:10 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDXPOoXxOto33dMAA--.3068S12;
 Sun, 12 Oct 2025 23:07:09 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v3 09/21] hw/arm/smmuv3: Plumb transaction attributes into
 config helpers
Date: Sun, 12 Oct 2025 23:06:49 +0800
Message-Id: <20251012150701.4127034-10-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDXPOoXxOto33dMAA--.3068S12
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQABBWjqskUBYAACsT
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxKw1DJFWDuw4UXr4rury8Zrb_yoW3AFWUpa
 nrGFn8tw4rtFyfZFZxXr4q93W3J3yvgFn8Gry29F9Ykr13Ar17Zr4DK345GryDZry8JFsr
 ZFyIgF45ZrnrA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
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

As a preliminary step towards a multi-security-state configuration
cache, introduce MemTxAttrs and AddressSpace * members to the
SMMUTransCfg struct. The goal is to cache these attributes so that
internal DMA calls (dma_memory_read/write) can use them directly.

To facilitate this, hw/arm/arm-security.h is now included in
smmu-common.h. This is a notable change, as it marks the first time
these Arm CPU-specific security space definitions are used outside of
cpu.h, making them more generally available for device models.

The decode helpers (smmu_get_ste, smmu_get_cd, smmu_find_ste,
smmuv3_get_config) are updated to use these new attributes for memory
accesses. This ensures that reads of SMMU structures from memory, such
as the Stream Table, use the correct security context.

For now, the configuration cache lookup key remains unchanged and is
still based solely on the SMMUDevice pointer. The new attributes are
populated during a cache miss in smmuv3_get_config.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmu-common.c         | 19 ++++++++++++++++++
 hw/arm/smmuv3.c              | 38 ++++++++++++++++++++++--------------
 include/hw/arm/smmu-common.h |  6 ++++++
 3 files changed, 48 insertions(+), 15 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 24db448683..82308f0e33 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -30,6 +30,25 @@
 #include "hw/arm/smmu-common.h"
 #include "smmu-internal.h"
 
+ARMSecuritySpace smmu_get_security_space(SMMUSecSID sec_sid)
+{
+    switch (sec_sid) {
+    case SMMU_SEC_SID_S:
+        return ARMSS_Secure;
+    case SMMU_SEC_SID_NS:
+    default:
+        return ARMSS_NonSecure;
+    }
+}
+
+MemTxAttrs smmu_get_txattrs(SMMUSecSID sec_sid)
+{
+    return (MemTxAttrs) {
+        .secure = sec_sid > SMMU_SEC_SID_NS ? 1 : 0,
+        .space = smmu_get_security_space(sec_sid),
+    };
+}
+
 /* Global state for secure address space availability */
 bool arm_secure_as_available;
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index a87ae36e8b..351bbf1ae9 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -333,14 +333,13 @@ static void smmuv3_init_regs(SMMUv3State *s)
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
@@ -385,8 +384,7 @@ static int smmu_get_cd(SMMUv3State *s, STE *ste, SMMUTransCfg *cfg,
     }
 
     /* TODO: guarantee 64-bit single-copy atomicity */
-    ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf),
-                          MEMTXATTRS_UNSPECIFIED);
+    ret = dma_memory_read(cfg->as, addr, buf, sizeof(*buf), cfg->txattrs);
     if (ret != MEMTX_OK) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Cannot fetch pte at address=0x%"PRIx64"\n", addr);
@@ -639,18 +637,19 @@ bad_ste:
  * @sid: stream ID
  * @ste: returned stream table entry
  * @event: handle to an event info
+ * @cfg: translation configuration cache
  *
  * Supports linear and 2-level stream table
  * Return 0 on success, -EINVAL otherwise
  */
 static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
-                         SMMUEventInfo *event)
+                         SMMUEventInfo *event, SMMUTransCfg *cfg)
 {
     dma_addr_t addr, strtab_base;
     uint32_t log2size;
     int strtab_size_shift;
     int ret;
-    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
+    SMMUSecSID sec_sid = cfg->sec_sid;
     SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
 
     trace_smmuv3_find_ste(sid, bank->features, bank->sid_split);
@@ -678,8 +677,8 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
         l2_ste_offset = sid & ((1 << bank->sid_split) - 1);
         l1ptr = (dma_addr_t)(strtab_base + l1_ste_offset * sizeof(l1std));
         /* TODO: guarantee 64-bit single-copy atomicity */
-        ret = dma_memory_read(&address_space_memory, l1ptr, &l1std,
-                              sizeof(l1std), MEMTXATTRS_UNSPECIFIED);
+        ret = dma_memory_read(cfg->as, l1ptr, &l1std, sizeof(l1std),
+                              cfg->txattrs);
         if (ret != MEMTX_OK) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "Could not read L1PTR at 0X%"PRIx64"\n", l1ptr);
@@ -721,7 +720,7 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
         addr = strtab_base + sid * sizeof(*ste);
     }
 
-    if (smmu_get_ste(s, addr, ste, event)) {
+    if (smmu_get_ste(s, addr, ste, event, cfg)) {
         return -EINVAL;
     }
 
@@ -850,7 +849,7 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
     /* ASID defaults to -1 (if s1 is not supported). */
     cfg->asid = -1;
 
-    ret = smmu_find_ste(s, sid, &ste, event);
+    ret = smmu_find_ste(s, sid, &ste, event, cfg);
     if (ret) {
         return ret;
     }
@@ -884,7 +883,8 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
  * decoding under the form of an SMMUTransCfg struct. The hash table is indexed
  * by the SMMUDevice handle.
  */
-static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event)
+static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
+                                       SMMUSecSID sec_sid)
 {
     SMMUv3State *s = sdev->smmu;
     SMMUState *bc = &s->smmu_state;
@@ -904,7 +904,15 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event)
                             100 * sdev->cfg_cache_hits /
                             (sdev->cfg_cache_hits + sdev->cfg_cache_misses));
         cfg = g_new0(SMMUTransCfg, 1);
-        cfg->sec_sid = SMMU_SEC_SID_NS;
+        cfg->sec_sid = sec_sid;
+        cfg->txattrs = smmu_get_txattrs(sec_sid);
+        cfg->as = smmu_get_address_space(sec_sid);
+        if (!cfg->as) {
+            /* Can't get AddressSpace, free cfg and return. */
+            g_free(cfg);
+            cfg = NULL;
+            return cfg;
+        }
 
         if (!smmuv3_decode_config(&sdev->iommu, cfg, event)) {
             g_hash_table_insert(bc->configs, sdev, cfg);
@@ -1086,7 +1094,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         goto epilogue;
     }
 
-    cfg = smmuv3_get_config(sdev, &event);
+    cfg = smmuv3_get_config(sdev, &event, sec_sid);
     if (!cfg) {
         status = SMMU_TRANS_ERROR;
         goto epilogue;
@@ -1168,7 +1176,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
     SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
     SMMUEventInfo eventinfo = {.sec_sid = sec_sid,
                                .inval_ste_allowed = true};
-    SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo);
+    SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo, sec_sid);
     IOMMUTLBEvent event;
     uint8_t granule;
 
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index d54558f94b..c17c7db6e5 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -22,6 +22,7 @@
 #include "hw/sysbus.h"
 #include "hw/pci/pci.h"
 #include "qom/object.h"
+#include "hw/arm/arm-security.h"
 
 #define SMMU_PCI_BUS_MAX                    256
 #define SMMU_PCI_DEVFN_MAX                  256
@@ -47,6 +48,9 @@ typedef enum SMMUSecSID {
     SMMU_SEC_SID_NUM,
 } SMMUSecSID;
 
+MemTxAttrs smmu_get_txattrs(SMMUSecSID sec_sid);
+ARMSecuritySpace smmu_get_security_space(SMMUSecSID sec_sid);
+
 extern AddressSpace __attribute__((weak)) arm_secure_address_space;
 extern bool arm_secure_as_available;
 void smmu_enable_secure_address_space(void);
@@ -150,6 +154,8 @@ typedef struct SMMUTransCfg {
     SMMUTransTableInfo tt[2];
     /* Used by stage-2 only. */
     struct SMMUS2Cfg s2cfg;
+    MemTxAttrs txattrs;        /* cached transaction attributes */
+    AddressSpace *as;          /* cached address space */
 } SMMUTransCfg;
 
 typedef struct SMMUDevice {
-- 
2.34.1


