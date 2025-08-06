Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78F9C87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 16:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujgZR-0001Ou-R9; Wed, 06 Aug 2025 12:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1ujfpy-0001UP-Oa; Wed, 06 Aug 2025 11:13:56 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1ujfpw-0006Hp-RE; Wed, 06 Aug 2025 11:13:54 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwAXHj4tcZNo2CzWBA--.49S2;
 Wed, 06 Aug 2025 23:13:49 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwCXIQnfcJNos_oJAA--.14849S13;
 Wed, 06 Aug 2025 23:13:48 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC 10/11] hw/arm/smmuv3: Differentiate secure TLB entries via keying
Date: Wed,  6 Aug 2025 23:11:33 +0800
Message-Id: <20250806151134.365755-11-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCXIQnfcJNos_oJAA--.14849S13
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAOBWiSXH8HMAAAsk
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxXr4UZr45Gr4fCr1xWw1fCrg_yoWrtw1Dpa
 1IyrWYyr95CF1j9rn3CF42vFnI9w4kWrW7A39xWr90yFyDt348JF4vka1UCF93AryrGrs3
 Z34Ivr4kJr17W3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 06 Aug 2025 11:27:14 -0400
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
state of the transaction. Without this, a secure lookup could incorrectly
hit a non-secure TLB entry and vice versa.

A secure parameter has been added to smmu_get_iotlb_key. This flag
is now part of the key generation, ensuring that secure and non-secure
TLB entries are treated as distinct entities within the cache.

This change is the final major refactoring required to correctly handle
secure transactions, preventing cache pollution between the two security
worlds.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmu-common.c         | 28 ++++++++++++++++++----------
 include/hw/arm/smmu-common.h |  3 ++-
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 80f94a85e7..5abec77a24 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -66,7 +66,7 @@ static guint smmu_iotlb_key_hash(gconstpointer v)
 
     /* Jenkins hash */
     a = b = c = JHASH_INITVAL + sizeof(*key);
-    a += key->asid + key->vmid + key->level + key->tg;
+    a += key->asid + key->vmid + key->level + key->tg + key->secure;
     b += extract64(key->iova, 0, 32);
     c += extract64(key->iova, 32, 32);
 
@@ -82,14 +82,14 @@ static gboolean smmu_iotlb_key_equal(gconstpointer v1, gconstpointer v2)
 
     return (k1->asid == k2->asid) && (k1->iova == k2->iova) &&
            (k1->level == k2->level) && (k1->tg == k2->tg) &&
-           (k1->vmid == k2->vmid);
+           (k1->vmid == k2->vmid) && (k1->secure == k2->secure);
 }
 
 SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
-                                uint8_t tg, uint8_t level)
+                                uint8_t tg, uint8_t level, bool secure)
 {
     SMMUIOTLBKey key = {.asid = asid, .vmid = vmid, .iova = iova,
-                        .tg = tg, .level = level};
+                        .tg = tg, .level = level, .secure = secure};
 
     return key;
 }
@@ -111,7 +111,7 @@ static SMMUTLBEntry *smmu_iotlb_lookup_all_levels(SMMUState *bs,
         SMMUIOTLBKey key;
 
         key = smmu_get_iotlb_key(cfg->asid, cfg->s2cfg.vmid,
-                                 iova & ~mask, tg, level);
+                                 iova & ~mask, tg, level, cfg->secure);
         entry = g_hash_table_lookup(bs->iotlb, &key);
         if (entry) {
             break;
@@ -175,7 +175,7 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new)
     }
 
     *key = smmu_get_iotlb_key(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
-                              tg, new->level);
+                              tg, new->level, cfg->secure);
     trace_smmu_iotlb_insert(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
                             tg, new->level);
     g_hash_table_insert(bs->iotlb, key, new);
@@ -282,9 +282,13 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
     uint8_t granule = tg ? tg * 2 + 10 : 12;
 
     if (ttl && (num_pages == 1) && (asid >= 0)) {
-        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, iova, tg, ttl);
+        SMMUIOTLBKey key_nonsecure = smmu_get_iotlb_key(asid, vmid, iova,
+                                                        tg, ttl, false);
+        SMMUIOTLBKey key_secure = smmu_get_iotlb_key(asid, vmid, iova,
+                                                     tg, ttl, true);
 
-        if (g_hash_table_remove(s->iotlb, &key)) {
+        if (g_hash_table_remove(s->iotlb, &key_nonsecure) ||
+            g_hash_table_remove(s->iotlb, &key_secure)) {
             return;
         }
         /*
@@ -314,9 +318,13 @@ void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
     int asid = -1;
 
    if (ttl && (num_pages == 1)) {
-        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, ipa, tg, ttl);
+        SMMUIOTLBKey key_nonsecure = smmu_get_iotlb_key(asid, vmid, ipa,
+                                                        tg, ttl, false);
+        SMMUIOTLBKey key_secure = smmu_get_iotlb_key(asid, vmid, ipa,
+                                                     tg, ttl, true);
 
-        if (g_hash_table_remove(s->iotlb, &key)) {
+        if (g_hash_table_remove(s->iotlb, &key_nonsecure) ||
+            g_hash_table_remove(s->iotlb, &key_secure)) {
             return;
         }
     }
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index e07a9c35e7..968c2eecbe 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -154,6 +154,7 @@ typedef struct SMMUIOTLBKey {
     int vmid;
     uint8_t tg;
     uint8_t level;
+    bool secure;
 } SMMUIOTLBKey;
 
 typedef struct SMMUConfigKey {
@@ -234,7 +235,7 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
                                 SMMUTransTableInfo *tt, hwaddr iova);
 void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
 SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
-                                uint8_t tg, uint8_t level);
+                                uint8_t tg, uint8_t level, bool secure);
 SMMUConfigKey smmu_get_config_key(SMMUDevice *sdev, bool is_secure);
 void smmu_iotlb_inv_all(SMMUState *s);
 void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid);
-- 
2.34.1


