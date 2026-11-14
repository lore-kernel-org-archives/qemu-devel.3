Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AA6606A329
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSGT8-00085X-K5; Sat, 14 Nov 2026 11:19:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGSF-00078v-E1; Sat, 14 Nov 2026 11:18:23 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGS8-0003ET-7d; Sat, 14 Nov 2026 11:18:15 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwCXn1u8ifhqPRoGAg--.42037S2; 
 Sun, 15 Nov 2026 00:18:04 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwOHSyifhq4Nv6AA--.29617S5;
 Sun, 15 Nov 2026 00:17:56 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v6 12/35] hw/arm/smmuv3: Tag IOTLB cache keys with SEC_SID
Date: Sun, 15 Nov 2026 00:17:46 +0800
Message-Id: <20261114161753.3645568-3-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
References: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwOHSyifhq4Nv6AA--.29617S5
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWr3ZUsBdgAAsT
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoWfZw17Zw4fWFWDGw4fCw48JFb_yoW8KFW3uo
 WfG3WYqr48X3W3u3WqkF4xJa42vayDtay5Zw45X3yYg3ZxKrs8tFWxKr4fXF4FqF4UAF40
 9F95JFW8XFyUCr93n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
 J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
 UUUUUUU==
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

To prevent aliasing between translations controlled through the Secure and
Non-secure programming interfaces, the IOTLB lookup key must incorporate
SEC_SID.

This commit:
- expands SMMUIOTLBKey with SEC_SID field for cache key differentiation
- extends SMMUIOTLBPageInvInfo with SEC_SID for invalidation filtering
- updates all IOTLB invalidation helpers (smmu_iotlb_inv_iova,
  smmu_iotlb_inv_ipa, smmu_iotlb_inv_asid_vmid, smmu_iotlb_inv_vmid,
  smmu_iotlb_inv_vmid_s1) to accept and filter by SEC_SID
- plumbs SEC_SID through smmuv3_range_inval for TLB invalidation
- enhances trace events to include SEC_SID for better debugging

This ensures that IOTLB entries decoded through the Secure and Non-secure
programming interfaces are distinct, preventing cache aliasing across
SEC_SID namespaces.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmu-internal.h       |   2 +
 include/hw/arm/smmu-common.h |  32 +++++++---
 hw/arm/smmu-common.c         | 110 +++++++++++++++++++++++------------
 hw/arm/smmuv3.c              |  43 +++++++++-----
 hw/arm/trace-events          |  20 +++----
 5 files changed, 136 insertions(+), 71 deletions(-)

diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
index 004abd58bca..ce68d4b5813 100644
--- a/hw/arm/smmu-internal.h
+++ b/hw/arm/smmu-internal.h
@@ -144,12 +144,14 @@ static inline int pgd_concat_idx(int start_level, int granule_sz,
 
 #define SMMU_IOTLB_ASID(key) ((key).asid)
 #define SMMU_IOTLB_VMID(key) ((key).vmid)
+#define SMMU_IOTLB_SEC_SID(key) ((key).sec_sid)
 
 typedef struct SMMUIOTLBPageInvInfo {
     int asid;
     int vmid;
     uint64_t iova;
     uint64_t mask;
+    SMMUSecSID sec_sid;
 } SMMUIOTLBPageInvInfo;
 
 #endif
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 0c5718ea684..8e971c28093 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -152,6 +152,17 @@ typedef struct SMMUIOTLBKey {
     int vmid;
     uint8_t tg;
     uint8_t level;
+    /*
+     * We currently model one StreamWorld per SEC_SID, giving the approximate
+     * mapping:
+     *
+     *   SMMU_SEC_SID_NS -> NS-EL1
+     *   SMMU_SEC_SID_S  -> Secure
+     *
+     * SEC_SID is not architecturally equivalent to StreamWorld. Extend this
+     * key when additional translation regimes are implemented.
+     */
+    SMMUSecSID sec_sid;
 } SMMUIOTLBKey;
 
 typedef struct SMMUConfigKey {
@@ -250,19 +261,24 @@ SMMUDevice *smmu_find_sdev(SMMUState *s, uint32_t sid);
 #define SMMU_IOTLB_MAX_SIZE 256
 
 SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
-                                SMMUTransTableInfo *tt, hwaddr iova);
-void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
+                                SMMUTransTableInfo *tt, hwaddr iova,
+                                SMMUSecSID sec_sid);
+void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry,
+                       SMMUSecSID sec_sid);
 SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
-                                uint8_t tg, uint8_t level);
+                                uint8_t tg, uint8_t level, SMMUSecSID sec_sid);
 SMMUConfigKey smmu_get_config_key(SMMUDevice *sdev, SMMUSecSID sec_sid);
 void smmu_iotlb_inv_all(SMMUState *s);
-void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid);
-void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
-void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid);
+void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid,
+                              SMMUSecSID sec_sid);
+void smmu_iotlb_inv_vmid(SMMUState *s, int vmid, SMMUSecSID sec_sid);
+void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid, SMMUSecSID sec_sid);
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
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 785309b3776..9c172fbb765 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -100,7 +100,7 @@ static guint smmu_iotlb_key_hash(gconstpointer v)
 
     /* Jenkins hash */
     a = b = c = JHASH_INITVAL + sizeof(*key);
-    a += key->asid + key->vmid + key->level + key->tg;
+    a += key->asid + key->vmid + key->level + key->tg + key->sec_sid;
     b += extract64(key->iova, 0, 32);
     c += extract64(key->iova, 32, 32);
 
@@ -116,14 +116,15 @@ static gboolean smmu_iotlb_key_equal(gconstpointer v1, gconstpointer v2)
 
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
@@ -131,7 +132,8 @@ SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
 static SMMUTLBEntry *smmu_iotlb_lookup_all_levels(SMMUState *bs,
                                                   SMMUTransCfg *cfg,
                                                   SMMUTransTableInfo *tt,
-                                                  hwaddr iova)
+                                                  hwaddr iova,
+                                                  SMMUSecSID sec_sid)
 {
     uint8_t tg = (tt->granule_sz - 10) / 2;
     uint8_t inputsize = 64 - tt->tsz;
@@ -145,7 +147,7 @@ static SMMUTLBEntry *smmu_iotlb_lookup_all_levels(SMMUState *bs,
         SMMUIOTLBKey key;
 
         key = smmu_get_iotlb_key(cfg->asid, cfg->s2cfg.vmid,
-                                 iova & ~mask, tg, level);
+                                 iova & ~mask, tg, level, sec_sid);
         entry = g_hash_table_lookup(bs->iotlb, &key);
         if (entry) {
             break;
@@ -161,6 +163,7 @@ static SMMUTLBEntry *smmu_iotlb_lookup_all_levels(SMMUState *bs,
  * @cfg: Configuration of the translation
  * @tt: Translation table info (granule and tsz)
  * @iova: IOVA address to lookup
+ * @sec_sid: StreamID Security state
  *
  * returns a valid entry on success, otherwise NULL.
  * In case of nested translation, tt can be updated to include
@@ -168,11 +171,12 @@ static SMMUTLBEntry *smmu_iotlb_lookup_all_levels(SMMUState *bs,
  * the IOVA granule.
  */
 SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
-                                SMMUTransTableInfo *tt, hwaddr iova)
+                                SMMUTransTableInfo *tt, hwaddr iova,
+                                SMMUSecSID sec_sid)
 {
     SMMUTLBEntry *entry = NULL;
 
-    entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova);
+    entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova, sec_sid);
     /*
      * For nested translation also try the s2 granule, as the TLB will insert
      * it if the size of s2 tlb entry was smaller.
@@ -180,18 +184,20 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
     if (!entry && (cfg->stage == SMMU_NESTED) &&
         (cfg->s2cfg.granule_sz != tt->granule_sz)) {
         tt->granule_sz = cfg->s2cfg.granule_sz;
-        entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova);
+        entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova, sec_sid);
     }
 
     if (entry) {
         cfg->iotlb_hits++;
-        trace_smmu_iotlb_lookup_hit(cfg->asid, cfg->s2cfg.vmid, iova,
+        trace_smmu_iotlb_lookup_hit(sec_sid, cfg->asid,
+                                    cfg->s2cfg.vmid, iova,
                                     cfg->iotlb_hits, cfg->iotlb_misses,
                                     100 * cfg->iotlb_hits /
                                     (cfg->iotlb_hits + cfg->iotlb_misses));
     } else {
         cfg->iotlb_misses++;
-        trace_smmu_iotlb_lookup_miss(cfg->asid, cfg->s2cfg.vmid, iova,
+        trace_smmu_iotlb_lookup_miss(sec_sid, cfg->asid,
+                                     cfg->s2cfg.vmid, iova,
                                      cfg->iotlb_hits, cfg->iotlb_misses,
                                      100 * cfg->iotlb_hits /
                                      (cfg->iotlb_hits + cfg->iotlb_misses));
@@ -199,7 +205,8 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
     return entry;
 }
 
-void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new)
+void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new,
+                       SMMUSecSID sec_sid)
 {
     SMMUIOTLBKey *key = g_new0(SMMUIOTLBKey, 1);
     uint8_t tg = (new->granule - 10) / 2;
@@ -209,9 +216,9 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new)
     }
 
     *key = smmu_get_iotlb_key(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
-                              tg, new->level);
-    trace_smmu_iotlb_insert(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
-                            tg, new->level);
+                              tg, new->level, sec_sid);
+    trace_smmu_iotlb_insert(sec_sid, cfg->asid, cfg->s2cfg.vmid,
+                            new->entry.iova, tg, new->level);
     g_hash_table_insert(bs->iotlb, key, new);
 }
 
@@ -228,26 +235,29 @@ static gboolean smmu_hash_remove_by_asid_vmid(gpointer key, gpointer value,
     SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
 
     return (SMMU_IOTLB_ASID(*iotlb_key) == info->asid) &&
-           (SMMU_IOTLB_VMID(*iotlb_key) == info->vmid);
+           (SMMU_IOTLB_VMID(*iotlb_key) == info->vmid) &&
+           (SMMU_IOTLB_SEC_SID(*iotlb_key) == info->sec_sid);
 }
 
 static gboolean smmu_hash_remove_by_vmid(gpointer key, gpointer value,
                                          gpointer user_data)
 {
-    int vmid = *(int *)user_data;
+    SMMUIOTLBPageInvInfo *info = (SMMUIOTLBPageInvInfo *)user_data;
     SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
 
-    return SMMU_IOTLB_VMID(*iotlb_key) == vmid;
+    return (SMMU_IOTLB_VMID(*iotlb_key) == info->vmid) &&
+           (SMMU_IOTLB_SEC_SID(*iotlb_key) == info->sec_sid);
 }
 
 static gboolean smmu_hash_remove_by_vmid_s1(gpointer key, gpointer value,
                                             gpointer user_data)
 {
-    int vmid = *(int *)user_data;
+    SMMUIOTLBPageInvInfo *info = (SMMUIOTLBPageInvInfo *)user_data;
     SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
 
-    return (SMMU_IOTLB_VMID(*iotlb_key) == vmid) &&
-           (SMMU_IOTLB_ASID(*iotlb_key) >= 0);
+    return (SMMU_IOTLB_VMID(*iotlb_key) == info->vmid) &&
+           (SMMU_IOTLB_ASID(*iotlb_key) >= 0) &&
+           (SMMU_IOTLB_SEC_SID(*iotlb_key) == info->sec_sid);
 }
 
 static gboolean smmu_hash_remove_by_asid_vmid_iova(gpointer key, gpointer value,
@@ -264,6 +274,9 @@ static gboolean smmu_hash_remove_by_asid_vmid_iova(gpointer key, gpointer value,
     if (info->vmid >= 0 && info->vmid != SMMU_IOTLB_VMID(iotlb_key)) {
         return false;
     }
+    if (info->sec_sid != SMMU_IOTLB_SEC_SID(iotlb_key)) {
+        return false;
+    }
     return ((info->iova & ~entry->addr_mask) == entry->iova) ||
            ((entry->iova & ~info->mask) == info->iova);
 }
@@ -283,6 +296,9 @@ static gboolean smmu_hash_remove_by_vmid_ipa(gpointer key, gpointer value,
     if (info->vmid != SMMU_IOTLB_VMID(iotlb_key)) {
         return false;
     }
+    if (info->sec_sid != SMMU_IOTLB_SEC_SID(iotlb_key)) {
+        return false;
+    }
     return ((info->iova & ~entry->addr_mask) == entry->iova) ||
            ((entry->iova & ~info->mask) == info->iova);
 }
@@ -328,13 +344,17 @@ void smmu_configs_inv_sdev(SMMUState *s, SMMUDevice *sdev)
 }
 
 void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
-                         uint8_t tg, uint64_t num_pages, uint8_t ttl)
+                         uint8_t tg, uint64_t num_pages, uint8_t ttl,
+                         SMMUSecSID sec_sid)
 {
     /* if tg is not set we use 4KB range invalidation */
     uint8_t granule = tg ? tg * 2 + 10 : 12;
 
+    trace_smmu_iotlb_inv_iova(sec_sid, asid, iova);
+
     if (ttl && (num_pages == 1) && (asid >= 0)) {
-        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, iova, tg, ttl);
+        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, iova,
+                                              tg, ttl, sec_sid);
 
         if (g_hash_table_remove(s->iotlb, &key)) {
             return;
@@ -348,7 +368,8 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
     SMMUIOTLBPageInvInfo info = {
         .asid = asid, .iova = iova,
         .vmid = vmid,
-        .mask = (num_pages * 1 << granule) - 1};
+        .mask = (num_pages * 1 << granule) - 1,
+        .sec_sid = sec_sid};
 
     g_hash_table_foreach_remove(s->iotlb,
                                 smmu_hash_remove_by_asid_vmid_iova,
@@ -360,13 +381,15 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
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
@@ -376,34 +399,47 @@ void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
     SMMUIOTLBPageInvInfo info = {
         .iova = ipa,
         .vmid = vmid,
-        .mask = (num_pages << granule) - 1};
+        .mask = (num_pages << granule) - 1,
+        .sec_sid = sec_sid};
 
     g_hash_table_foreach_remove(s->iotlb,
                                 smmu_hash_remove_by_vmid_ipa,
                                 &info);
 }
 
-void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid)
+void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid,
+                              SMMUSecSID sec_sid)
 {
     SMMUIOTLBPageInvInfo info = {
         .asid = asid,
         .vmid = vmid,
+        .sec_sid = sec_sid,
     };
 
-    trace_smmu_iotlb_inv_asid_vmid(asid, vmid);
+    trace_smmu_iotlb_inv_asid_vmid(sec_sid, asid, vmid);
     g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid_vmid, &info);
 }
 
-void smmu_iotlb_inv_vmid(SMMUState *s, int vmid)
+void smmu_iotlb_inv_vmid(SMMUState *s, int vmid, SMMUSecSID sec_sid)
 {
-    trace_smmu_iotlb_inv_vmid(vmid);
-    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &vmid);
+    SMMUIOTLBPageInvInfo info = {
+        .vmid = vmid,
+        .sec_sid = sec_sid,
+    };
+
+    trace_smmu_iotlb_inv_vmid(sec_sid, vmid);
+    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &info);
 }
 
-void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid)
+void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid, SMMUSecSID sec_sid)
 {
-    trace_smmu_iotlb_inv_vmid_s1(vmid);
-    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid_s1, &vmid);
+    SMMUIOTLBPageInvInfo info = {
+        .vmid = vmid,
+        .sec_sid = sec_sid,
+    };
+
+    trace_smmu_iotlb_inv_vmid_s1(sec_sid, vmid);
+    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid_s1, &info);
 }
 
 /* VMSAv8-64 Translation */
@@ -915,7 +951,7 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
         tt_combined.tsz = tt->tsz;
     }
 
-    cached_entry = smmu_iotlb_lookup(bs, cfg, &tt_combined, addr);
+    cached_entry = smmu_iotlb_lookup(bs, cfg, &tt_combined, addr, sec_sid);
     if (cached_entry) {
         if ((flag & IOMMU_WO) && !(cached_entry->entry.perm &
             cached_entry->parent_perm & IOMMU_WO)) {
@@ -934,7 +970,7 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
             g_free(cached_entry);
             return NULL;
     }
-    smmu_iotlb_insert(bs, cfg, cached_entry);
+    smmu_iotlb_insert(bs, cfg, cached_entry, sec_sid);
     return cached_entry;
 }
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index d4ee63e3aa6..63a77368035 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -633,6 +633,13 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
         goto bad_ste;
     }
 
+    if (smmu_sec_sid_is_secure(sec_sid) && STE_CFG_S1_TRANSLATE(config) &&
+        STE_STRW(ste) != 0) {
+        qemu_log_mask(LOG_UNIMP,
+                      "SMMUv3 Secure StreamWorld is not implemented\n");
+        goto bad_ste;
+    }
+
     if (STAGE2_SUPPORTED(s)) {
         /* VMID is considered even if s2 is disabled. */
         cfg->s2cfg.vmid = STE_S2VMID(ste);
@@ -1314,7 +1321,8 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
     }
 }
 
-static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
+static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
+                               SMMUSecSID sec_sid)
 {
     dma_addr_t end, addr = CMD_ADDR(cmd);
     uint8_t type = CMD_TYPE(cmd);
@@ -1339,12 +1347,13 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
     }
 
     if (!tg) {
-        trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf, stage);
+        trace_smmuv3_range_inval(sec_sid, vmid, asid, addr,
+                                 tg, 1, ttl, leaf, stage);
         smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage);
         if (stage == SMMU_STAGE_1) {
-            smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
+            smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl, sec_sid);
         } else {
-            smmu_iotlb_inv_ipa(s, vmid, addr, tg, 1, ttl);
+            smmu_iotlb_inv_ipa(s, vmid, addr, tg, 1, ttl, sec_sid);
         }
         return;
     }
@@ -1361,13 +1370,15 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
         uint64_t mask = dma_aligned_pow2_mask(addr, end, 64);
 
         num_pages = (mask + 1) >> granule;
-        trace_smmuv3_range_inval(vmid, asid, addr, tg, num_pages,
-                                 ttl, leaf, stage);
-        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages, stage);
+        trace_smmuv3_range_inval(sec_sid, vmid, asid, addr, tg,
+                                 num_pages, ttl, leaf, stage);
+        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg,
+                                  num_pages, stage);
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
@@ -1518,9 +1529,9 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
                 vmid = CMD_VMID(&cmd);
             }
 
-            trace_smmuv3_cmdq_tlbi_nh_asid(asid);
+            trace_smmuv3_cmdq_tlbi_nh_asid(sec_sid, asid);
             smmu_inv_notifiers_all(&s->smmu_state);
-            smmu_iotlb_inv_asid_vmid(bs, asid, vmid);
+            smmu_iotlb_inv_asid_vmid(bs, asid, vmid, sec_sid);
             if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
@@ -1542,8 +1553,8 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
              */
             if (STAGE2_SUPPORTED(s)) {
                 vmid = CMD_VMID(&cmd);
-                trace_smmuv3_cmdq_tlbi_nh(vmid);
-                smmu_iotlb_inv_vmid_s1(bs, vmid);
+                trace_smmuv3_cmdq_tlbi_nh(sec_sid, vmid);
+                smmu_iotlb_inv_vmid_s1(bs, vmid, sec_sid);
                 break;
             }
             QEMU_FALLTHROUGH;
@@ -1563,7 +1574,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
-            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1);
+            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1, SMMU_SEC_SID_NS);
             if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
@@ -1580,7 +1591,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
 
             trace_smmuv3_cmdq_tlbi_s12_vmid(vmid);
             smmu_inv_notifiers_all(&s->smmu_state);
-            smmu_iotlb_inv_vmid(bs, vmid);
+            smmu_iotlb_inv_vmid(bs, vmid, SMMU_SEC_SID_NS);
             break;
         }
         case SMMU_CMD_TLBI_S2_IPA:
@@ -1592,7 +1603,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
              * As currently only either s1 or s2 are supported
              * we can reuse same function for s2.
              */
-            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2);
+            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2, SMMU_SEC_SID_NS);
             break;
         case SMMU_CMD_ATC_INV:
         {
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 50fe4af07c5..3cbb32e917b 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -19,16 +19,16 @@ smmu_ptw_page_pte(int stage, int level,  uint64_t iova, uint64_t baseaddr, uint6
 smmu_ptw_block_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr, uint64_t pte, uint64_t iova, uint64_t gpa, int bsize_mb) "stage=%d level=%d base@=0x%"PRIx64" pte@=0x%"PRIx64" pte=0x%"PRIx64" iova=0x%"PRIx64" block address = 0x%"PRIx64" block size = %d MiB"
 smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte) "baseaddr=0x%"PRIx64" index=0x%x, pteaddr=0x%"PRIx64", pte=0x%"PRIx64
 smmu_iotlb_inv_all(void) "IOTLB invalidate all"
-smmu_iotlb_inv_asid_vmid(int asid, int vmid) "IOTLB invalidate asid=%d vmid=%d"
-smmu_iotlb_inv_vmid(int vmid) "IOTLB invalidate vmid=%d"
-smmu_iotlb_inv_vmid_s1(int vmid) "IOTLB invalidate vmid=%d"
-smmu_iotlb_inv_iova(int asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
+smmu_iotlb_inv_asid_vmid(int sec_sid, int asid, int vmid) "IOTLB invalidate sec_sid=%d asid=%d vmid=%d"
+smmu_iotlb_inv_vmid(int sec_sid, int vmid) "IOTLB invalidate sec_sid=%d vmid=%d"
+smmu_iotlb_inv_vmid_s1(int sec_sid, int vmid) "IOTLB invalidate S1 sec_sid=%d vmid=%d"
+smmu_iotlb_inv_iova(int sec_sid, int asid, uint64_t addr) "IOTLB invalidate sec_sid=%d asid=%d addr=0x%"PRIx64
 smmu_configs_inv_sid_range(uint32_t start, uint32_t end) "Config cache INV SID range from 0x%x to 0x%x"
 smmu_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
 smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
-smmu_iotlb_lookup_hit(int asid, int vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
-smmu_iotlb_lookup_miss(int asid, int vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
-smmu_iotlb_insert(int asid, int vmid, uint64_t addr, uint8_t tg, uint8_t level) "IOTLB ++ asid=%d vmid=%d addr=0x%"PRIx64" tg=%d level=%d"
+smmu_iotlb_lookup_hit(int sec_sid, int asid, int vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT sec_sid=%d asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
+smmu_iotlb_lookup_miss(int sec_sid, int asid, int vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS sec_sid=%d asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
+smmu_iotlb_insert(int sec_sid, int asid, int vmid, uint64_t addr, uint8_t tg, uint8_t level) "IOTLB ++ sec_sid=%d asid=%d vmid=%d addr=0x%"PRIx64" tg=%d level=%d"
 
 # smmuv3.c
 smmuv3_read_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
@@ -57,10 +57,10 @@ smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%x - end=0x%x"
 smmuv3_cmdq_cfgi_cd(uint32_t sid) "sid=0x%x"
 smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache HIT for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
 smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
-smmuv3_range_inval(int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf, int stage) "vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d stage=%d"
-smmuv3_cmdq_tlbi_nh(int vmid) "vmid=%d"
+smmuv3_range_inval(int sec_sid, int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf, int stage) "sec_sid=%d vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d stage=%d"
+smmuv3_cmdq_tlbi_nh(int sec_sid, int vmid) "sec_sid=%d vmid=%d"
 smmuv3_cmdq_tlbi_nsnh(void) ""
-smmuv3_cmdq_tlbi_nh_asid(int asid) "asid=%d"
+smmuv3_cmdq_tlbi_nh_asid(int sec_sid, int asid) "sec_sid=%d asid=%d"
 smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
 smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
 smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
-- 
2.34.1


