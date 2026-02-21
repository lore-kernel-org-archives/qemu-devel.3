Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0FDC61DE2
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Feb 2026 10:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtk31-000796-Jf; Sat, 21 Feb 2026 05:17:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtk30-00075p-ER; Sat, 21 Feb 2026 05:17:14 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtk2x-0006Nf-9r; Sat, 21 Feb 2026 05:17:14 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAHXdAihplp6x5zAA--.3190S2;
 Sat, 21 Feb 2026 18:17:06 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwC3DuwdhplpbE4cAA--.34817S3;
 Sat, 21 Feb 2026 18:17:02 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v4 15/31] hw/arm/smmuv3: Tag IOTLB cache keys with SEC_SID
Date: Sat, 21 Feb 2026 18:16:57 +0800
Message-Id: <20260221101657.2994097-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwC3DuwdhplpbE4cAA--.34817S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQANBWmYzyUAMwAAsh
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoW3ZFW7Aw43WF4DtF4rXFyrWFg_yoW8AFWrCo
 WxG3Wjqr48J3W7WFyqkFs7JFy2va4Dtay5Zw4rX3yag3ZxKrn8tFWxtr4fXF4Fgr4UAF40
 vF95ArW8XF1UC3s3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
 J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
 UUUUUUU==
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
state of the transaction.

This commit:
- expands SMMUIOTLBKey with SEC_SID field for cache key differentiation
- extends SMMUIOTLBPageInvInfo with SEC_SID for invalidation filtering
- updates all IOTLB invalidation helpers (smmu_iotlb_inv_iova,
  smmu_iotlb_inv_ipa, smmu_iotlb_inv_asid_vmid, smmu_iotlb_inv_vmid,
  smmu_iotlb_inv_vmid_s1) to accept and filter by SEC_SID
- plumbs SEC_SID through smmuv3_range_inval for TLB invalidation
- enhances trace events to include SEC_SID for better debugging

This ensures that secure and non-secure TLB entries are treated as
distinct entities within the cache, preventing TLB pollution between
different worlds.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmu-common.c         | 80 ++++++++++++++++++++++++------------
 hw/arm/smmu-internal.h       |  2 +
 hw/arm/smmuv3.c              | 36 ++++++++--------
 hw/arm/trace-events          | 12 +++---
 include/hw/arm/smmu-common.h | 16 +++++---
 5 files changed, 92 insertions(+), 54 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 84e71df6767..bb43430cc3b 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -95,7 +95,7 @@ static guint smmu_iotlb_key_hash(gconstpointer v)
 
     /* Jenkins hash */
     a = b = c = JHASH_INITVAL + sizeof(*key);
-    a += key->asid + key->vmid + key->level + key->tg;
+    a += key->asid + key->vmid + key->level + key->tg + key->sec_sid;
     b += extract64(key->iova, 0, 32);
     c += extract64(key->iova, 32, 32);
 
@@ -111,14 +111,15 @@ static gboolean smmu_iotlb_key_equal(gconstpointer v1, gconstpointer v2)
 
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
@@ -140,7 +141,7 @@ static SMMUTLBEntry *smmu_iotlb_lookup_all_levels(SMMUState *bs,
         SMMUIOTLBKey key;
 
         key = smmu_get_iotlb_key(cfg->asid, cfg->s2cfg.vmid,
-                                 iova & ~mask, tg, level);
+                                 iova & ~mask, tg, level, cfg->sec_sid);
         entry = g_hash_table_lookup(bs->iotlb, &key);
         if (entry) {
             break;
@@ -204,7 +205,7 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new)
     }
 
     *key = smmu_get_iotlb_key(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
-                              tg, new->level);
+                              tg, new->level, cfg->sec_sid);
     trace_smmu_iotlb_insert(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
                             tg, new->level);
     g_hash_table_insert(bs->iotlb, key, new);
@@ -223,26 +224,29 @@ static gboolean smmu_hash_remove_by_asid_vmid(gpointer key, gpointer value,
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
@@ -259,6 +263,9 @@ static gboolean smmu_hash_remove_by_asid_vmid_iova(gpointer key, gpointer value,
     if (info->vmid >= 0 && info->vmid != SMMU_IOTLB_VMID(iotlb_key)) {
         return false;
     }
+    if (info->sec_sid != SMMU_IOTLB_SEC_SID(iotlb_key)) {
+        return false;
+    }
     return ((info->iova & ~entry->addr_mask) == entry->iova) ||
            ((entry->iova & ~info->mask) == info->iova);
 }
@@ -278,6 +285,9 @@ static gboolean smmu_hash_remove_by_vmid_ipa(gpointer key, gpointer value,
     if (info->vmid != SMMU_IOTLB_VMID(iotlb_key)) {
         return false;
     }
+    if (info->sec_sid != SMMU_IOTLB_SEC_SID(iotlb_key)) {
+        return false;
+    }
     return ((info->iova & ~entry->addr_mask) == entry->iova) ||
            ((entry->iova & ~info->mask) == info->iova);
 }
@@ -323,13 +333,15 @@ void smmu_configs_inv_sdev(SMMUState *s, SMMUDevice *sdev)
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
@@ -343,7 +355,8 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
     SMMUIOTLBPageInvInfo info = {
         .asid = asid, .iova = iova,
         .vmid = vmid,
-        .mask = (num_pages * 1 << granule) - 1};
+        .mask = (num_pages * 1 << granule) - 1,
+        .sec_sid = sec_sid};
 
     g_hash_table_foreach_remove(s->iotlb,
                                 smmu_hash_remove_by_asid_vmid_iova,
@@ -355,13 +368,15 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
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
@@ -371,34 +386,47 @@ void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
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
diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
index a0454f720da..5ddd0372d5b 100644
--- a/hw/arm/smmu-internal.h
+++ b/hw/arm/smmu-internal.h
@@ -145,12 +145,14 @@ static inline int pgd_concat_idx(int start_level, int granule_sz,
 
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
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 504161ce06d..4a4de719a7c 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1279,7 +1279,8 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
     }
 }
 
-static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
+static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
+                               SMMUSecSID sec_sid)
 {
     dma_addr_t end, addr = CMD_ADDR(cmd);
     uint8_t type = CMD_TYPE(cmd);
@@ -1304,12 +1305,13 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
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
@@ -1326,13 +1328,15 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
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
@@ -1474,9 +1478,9 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
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
@@ -1498,8 +1502,8 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
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
@@ -1519,7 +1523,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
-            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1);
+            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1, SMMU_SEC_SID_NS);
             if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
@@ -1536,7 +1540,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
 
             trace_smmuv3_cmdq_tlbi_s12_vmid(vmid);
             smmu_inv_notifiers_all(&s->smmu_state);
-            smmu_iotlb_inv_vmid(bs, vmid);
+            smmu_iotlb_inv_vmid(bs, vmid, SMMU_SEC_SID_NS);
             break;
         }
         case SMMU_CMD_TLBI_S2_IPA:
@@ -1548,7 +1552,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
              * As currently only either s1 or s2 are supported
              * we can reuse same function for s2.
              */
-            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2);
+            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2, SMMU_SEC_SID_NS);
             break;
         case SMMU_CMD_ATC_INV:
         {
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 9c2cc131ab4..4e360b3c0d3 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -18,9 +18,9 @@ smmu_ptw_page_pte(int stage, int level,  uint64_t iova, uint64_t baseaddr, uint6
 smmu_ptw_block_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr, uint64_t pte, uint64_t iova, uint64_t gpa, int bsize_mb) "stage=%d level=%d base@=0x%"PRIx64" pte@=0x%"PRIx64" pte=0x%"PRIx64" iova=0x%"PRIx64" block address = 0x%"PRIx64" block size = %d MiB"
 smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte) "baseaddr=0x%"PRIx64" index=0x%x, pteaddr=0x%"PRIx64", pte=0x%"PRIx64
 smmu_iotlb_inv_all(void) "IOTLB invalidate all"
-smmu_iotlb_inv_asid_vmid(int asid, int vmid) "IOTLB invalidate asid=%d vmid=%d"
-smmu_iotlb_inv_vmid(int vmid) "IOTLB invalidate vmid=%d"
-smmu_iotlb_inv_vmid_s1(int vmid) "IOTLB invalidate vmid=%d"
+smmu_iotlb_inv_asid_vmid(int sec_sid, int asid, int vmid) "IOTLB invalidate sec_sid=%d asid=%d vmid=%d"
+smmu_iotlb_inv_vmid(int sec_sid, int vmid) "IOTLB invalidate sec_sid=%d vmid=%d"
+smmu_iotlb_inv_vmid_s1(int sec_sid, int vmid) "IOTLB invalidate S1 sec_sid=%d vmid=%d"
 smmu_iotlb_inv_iova(int asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
 smmu_configs_inv_sid_range(uint32_t start, uint32_t end) "Config cache INV SID range from 0x%x to 0x%x"
 smmu_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
@@ -56,10 +56,10 @@ smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%x - end=0x%x"
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
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index b0a02e12fe6..7d1d0936921 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -162,6 +162,7 @@ typedef struct SMMUIOTLBKey {
     int vmid;
     uint8_t tg;
     uint8_t level;
+    SMMUSecSID sec_sid;
 } SMMUIOTLBKey;
 
 typedef struct SMMUConfigKey {
@@ -256,16 +257,19 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
                                 SMMUTransTableInfo *tt, hwaddr iova);
 void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
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
-- 
2.34.1


