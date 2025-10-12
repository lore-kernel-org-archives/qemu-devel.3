Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA36CCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 15:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7xko-00009B-8U; Sun, 12 Oct 2025 11:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xkm-00008r-Fr; Sun, 12 Oct 2025 11:12:56 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xkk-0002RW-2e; Sun, 12 Oct 2025 11:12:56 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAX1V1wxetoQiorAA--.32938S2;
 Sun, 12 Oct 2025 23:12:48 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwC3GuhuxetoNHhMAA--.3096S3;
 Sun, 12 Oct 2025 23:12:46 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v3 13/21] hw/arm/smmuv3: Tag IOTLB cache keys with SEC_SID
Date: Sun, 12 Oct 2025 23:12:44 +0800
Message-Id: <20251012151244.4129572-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwC3GuhuxetoNHhMAA--.3096S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQABBWjqskUBagAAsb
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3ZrykJryxGw4ktw1kXw4xWFg_yoWkuw4UpF
 WxKrn8ur4rJFyfZ3Z7ur4UuFnxZw1qgrWrKrWYgr9Yya4kJ3y8ZF4kC3yUCrWDGr18Grsx
 Z3y2gr45A3W2q3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

To prevent aliasing between secure and non-secure translations for the
same address space, the IOTLB lookup key must incorporate the security
state of the transaction. This commit expands SMMUIOTLBKey with the
SEC_SID, plumbs the new argument through common helpers, and ensures
that secure and non-secure TLB entries are treated as distinct
entities within the cache.

As a final step, this patch ensures the target address space
(target_as) from a cached IOTLB entry is correctly propagated to the
final translation result. Previously, the result defaulted to the
non-secure address space, nullifying the benefits of the
security-aware cache key.

This change provides robust management for secure TLB entries,
preventing TLB pollution between security worlds and allowing for proper
initialization by secure software.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmu-common.c         | 25 ++++++++++++---------
 hw/arm/smmuv3.c              | 42 +++++++++++++++++++++---------------
 hw/arm/trace-events          |  2 +-
 include/hw/arm/smmu-common.h |  9 +++++---
 4 files changed, 47 insertions(+), 31 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index a092bb5a8d..4131a31ae0 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -86,7 +86,7 @@ static guint smmu_iotlb_key_hash(gconstpointer v)
 
     /* Jenkins hash */
     a = b = c = JHASH_INITVAL + sizeof(*key);
-    a += key->asid + key->vmid + key->level + key->tg;
+    a += key->asid + key->vmid + key->level + key->tg + key->sec_sid;
     b += extract64(key->iova, 0, 32);
     c += extract64(key->iova, 32, 32);
 
@@ -102,14 +102,15 @@ static gboolean smmu_iotlb_key_equal(gconstpointer v1, gconstpointer v2)
 
     return (k1->asid == k2->asid) && (k1->iova == k2->iova) &&
            (k1->level == k2->level) && (k1->tg == k2->tg) &&
-           (k1->vmid == k2->vmid);
+           (k1->vmid == k2->vmid) && (k1->sec_sid == k2->sec_sid);
 }
 
 SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
-                                uint8_t tg, uint8_t level)
+                                uint8_t tg, uint8_t level,
+                                SMMUSecSID sec_sid)
 {
     SMMUIOTLBKey key = {.asid = asid, .vmid = vmid, .iova = iova,
-                        .tg = tg, .level = level};
+                        .tg = tg, .level = level, .sec_sid = sec_sid};
 
     return key;
 }
@@ -131,7 +132,7 @@ static SMMUTLBEntry *smmu_iotlb_lookup_all_levels(SMMUState *bs,
         SMMUIOTLBKey key;
 
         key = smmu_get_iotlb_key(cfg->asid, cfg->s2cfg.vmid,
-                                 iova & ~mask, tg, level);
+                                 iova & ~mask, tg, level, cfg->sec_sid);
         entry = g_hash_table_lookup(bs->iotlb, &key);
         if (entry) {
             break;
@@ -195,7 +196,7 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new)
     }
 
     *key = smmu_get_iotlb_key(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
-                              tg, new->level);
+                              tg, new->level, cfg->sec_sid);
     trace_smmu_iotlb_insert(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
                             tg, new->level);
     g_hash_table_insert(bs->iotlb, key, new);
@@ -314,13 +315,15 @@ void smmu_configs_inv_sdev(SMMUState *s, SMMUDevice *sdev)
 }
 
 void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
-                         uint8_t tg, uint64_t num_pages, uint8_t ttl)
+                         uint8_t tg, uint64_t num_pages, uint8_t ttl,
+                         SMMUSecSID sec_sid)
 {
     /* if tg is not set we use 4KB range invalidation */
     uint8_t granule = tg ? tg * 2 + 10 : 12;
 
     if (ttl && (num_pages == 1) && (asid >= 0)) {
-        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, iova, tg, ttl);
+        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, iova,
+                                              tg, ttl, sec_sid);
 
         if (g_hash_table_remove(s->iotlb, &key)) {
             return;
@@ -346,13 +349,15 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
  * in Stage-1 invalidation ASID = -1, means don't care.
  */
 void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
-                        uint64_t num_pages, uint8_t ttl)
+                        uint64_t num_pages, uint8_t ttl,
+                        SMMUSecSID sec_sid)
 {
     uint8_t granule = tg ? tg * 2 + 10 : 12;
     int asid = -1;
 
    if (ttl && (num_pages == 1)) {
-        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, ipa, tg, ttl);
+        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, ipa,
+                                              tg, ttl, sec_sid);
 
         if (g_hash_table_remove(s->iotlb, &key)) {
             return;
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 3686056d8e..f9395c3821 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1125,6 +1125,7 @@ epilogue:
         entry.perm = cached_entry->entry.perm;
         entry.translated_addr = CACHED_ENTRY_TO_ADDR(cached_entry, addr);
         entry.addr_mask = cached_entry->entry.addr_mask;
+        entry.target_as = cached_entry->entry.target_as;
         trace_smmuv3_translate_success(mr->parent_obj.name, sid, addr,
                                        entry.translated_addr, entry.perm,
                                        cfg->stage);
@@ -1170,15 +1171,16 @@ epilogue:
  * @tg: translation granule (if communicated through range invalidation)
  * @num_pages: number of @granule sized pages (if tg != 0), otherwise 1
  * @stage: Which stage(1 or 2) is used
+ * @sec_sid: security stream ID
  */
 static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
                                IOMMUNotifier *n,
                                int asid, int vmid,
                                dma_addr_t iova, uint8_t tg,
-                               uint64_t num_pages, int stage)
+                               uint64_t num_pages, int stage,
+                               SMMUSecSID sec_sid)
 {
     SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
-    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
     SMMUEventInfo eventinfo = {.sec_sid = sec_sid,
                                .inval_ste_allowed = true};
     SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo, sec_sid);
@@ -1226,7 +1228,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
     }
 
     event.type = IOMMU_NOTIFIER_UNMAP;
-    event.entry.target_as = &address_space_memory;
+    event.entry.target_as = smmu_get_address_space(sec_sid);
     event.entry.iova = iova;
     event.entry.addr_mask = num_pages * (1 << granule) - 1;
     event.entry.perm = IOMMU_NONE;
@@ -1237,7 +1239,8 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
 /* invalidate an asid/vmid/iova range tuple in all mr's */
 static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
                                       dma_addr_t iova, uint8_t tg,
-                                      uint64_t num_pages, int stage)
+                                      uint64_t num_pages, int stage,
+                                      SMMUSecSID sec_sid)
 {
     SMMUDevice *sdev;
 
@@ -1249,12 +1252,14 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
                                         iova, tg, num_pages, stage);
 
         IOMMU_NOTIFIER_FOREACH(n, mr) {
-            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg, num_pages, stage);
+            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg,
+                               num_pages, stage, sec_sid);
         }
     }
 }
 
-static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
+static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
+                               SMMUSecSID sec_sid)
 {
     dma_addr_t end, addr = CMD_ADDR(cmd);
     uint8_t type = CMD_TYPE(cmd);
@@ -1279,12 +1284,13 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
     }
 
     if (!tg) {
-        trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf, stage);
-        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage);
+        trace_smmuv3_range_inval(sec_sid, vmid, asid, addr,
+                                 tg, 1, ttl, leaf, stage);
+        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage, sec_sid);
         if (stage == SMMU_STAGE_1) {
-            smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
+            smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl, sec_sid);
         } else {
-            smmu_iotlb_inv_ipa(s, vmid, addr, tg, 1, ttl);
+            smmu_iotlb_inv_ipa(s, vmid, addr, tg, 1, ttl, sec_sid);
         }
         return;
     }
@@ -1301,13 +1307,15 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
         uint64_t mask = dma_aligned_pow2_mask(addr, end, 64);
 
         num_pages = (mask + 1) >> granule;
-        trace_smmuv3_range_inval(vmid, asid, addr, tg, num_pages,
-                                 ttl, leaf, stage);
-        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages, stage);
+        trace_smmuv3_range_inval(sec_sid, vmid, asid, addr, tg,
+                                 num_pages, ttl, leaf, stage);
+        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg,
+                                  num_pages, stage, sec_sid);
         if (stage == SMMU_STAGE_1) {
-            smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, num_pages, ttl);
+            smmu_iotlb_inv_iova(s, asid, vmid, addr, tg,
+                                num_pages, ttl, sec_sid);
         } else {
-            smmu_iotlb_inv_ipa(s, vmid, addr, tg, num_pages, ttl);
+            smmu_iotlb_inv_ipa(s, vmid, addr, tg, num_pages, ttl, sec_sid);
         }
         addr += mask + 1;
     }
@@ -1474,7 +1482,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
-            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1);
+            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1, SMMU_SEC_SID_NS);
             break;
         case SMMU_CMD_TLBI_S12_VMALL:
         {
@@ -1499,7 +1507,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
              * As currently only either s1 or s2 are supported
              * we can reuse same function for s2.
              */
-            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2);
+            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2, SMMU_SEC_SID_NS);
             break;
         case SMMU_CMD_TLBI_EL3_ALL:
         case SMMU_CMD_TLBI_EL3_VA:
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index a37e894766..434d6abfc2 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -56,7 +56,7 @@ smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%x - end=0x%x"
 smmuv3_cmdq_cfgi_cd(uint32_t sid) "sid=0x%x"
 smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache HIT for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
 smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
-smmuv3_range_inval(int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf, int stage) "vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d stage=%d"
+smmuv3_range_inval(int sec_sid, int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf, int stage) "sec_sid=%d vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d stage=%d"
 smmuv3_cmdq_tlbi_nh(int vmid) "vmid=%d"
 smmuv3_cmdq_tlbi_nsnh(void) ""
 smmuv3_cmdq_tlbi_nh_asid(int asid) "asid=%d"
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 90a37fe32d..211fc7c2d0 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -183,6 +183,7 @@ typedef struct SMMUIOTLBKey {
     int vmid;
     uint8_t tg;
     uint8_t level;
+    SMMUSecSID sec_sid;
 } SMMUIOTLBKey;
 
 typedef struct SMMUConfigKey {
@@ -264,16 +265,18 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
                                 SMMUTransTableInfo *tt, hwaddr iova);
 void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
 SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
-                                uint8_t tg, uint8_t level);
+                                uint8_t tg, uint8_t level, SMMUSecSID sec_sid);
 SMMUConfigKey smmu_get_config_key(SMMUDevice *sdev, SMMUSecSID sec_sid);
 void smmu_iotlb_inv_all(SMMUState *s);
 void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid);
 void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
 void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid);
 void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
-                         uint8_t tg, uint64_t num_pages, uint8_t ttl);
+                         uint8_t tg, uint64_t num_pages, uint8_t ttl,
+                         SMMUSecSID sec_sid);
 void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
-                        uint64_t num_pages, uint8_t ttl);
+                        uint64_t num_pages, uint8_t ttl,
+                        SMMUSecSID sec_sid);
 void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range);
 void smmu_configs_inv_sdev(SMMUState *s, SMMUDevice *sdev);
 /* Unmap the range of all the notifiers registered to any IOMMU mr */
-- 
2.34.1


