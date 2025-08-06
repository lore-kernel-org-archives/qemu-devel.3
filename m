Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB6AC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 16:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujgYA-0006Br-6v; Wed, 06 Aug 2025 11:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1ujfpo-00017n-NQ; Wed, 06 Aug 2025 11:13:45 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1ujfpm-0006GD-S2; Wed, 06 Aug 2025 11:13:44 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDn7z8jcZNoxyvWBA--.29S2;
 Wed, 06 Aug 2025 23:13:39 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwCXIQnfcJNos_oJAA--.14849S12;
 Wed, 06 Aug 2025 23:13:36 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC 09/11] hw/arm/smmuv3: Make the configuration cache
 security-state aware
Date: Wed,  6 Aug 2025 23:11:32 +0800
Message-Id: <20250806151134.365755-10-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCXIQnfcJNos_oJAA--.14849S12
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAOBWiSXH8HLgAAs6
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3WF13Cw4fXFWrGw4fAFWrXwb_yoW7ZF18pr
 WUGF98JrW5GF1fZr43ZFZ7uFn8Jws2gr1fGrZIgr9YyFyqyryUAF4qk3yak3s3ArWkJa17
 ZFWIgFyxCr17JrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

Previously, the configuration cache was keyed only by the SMMU device
(sdev). This is insufficient for a model where a single device can
issue both secure and non-secure transactions, as it could lead to
cache lookups returning the wrong configuration (e.g., a secure
transaction hitting a non-secure cache entry).

This commit refactors the configuration cache management. The cache key
is now a composite of the device and its security state
(SMMUDevice *sdev, bool is_secure).

This ensures that lookups correctly differentiate between security
states for the same physical device, guaranteeing that a transaction
always retrieves the appropriate cached configuration. This is a critical
step towards enabling full parallel processing of secure and non-secure
streams.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmu-common.c         | 27 +++++++++++++++++++++++++--
 hw/arm/smmuv3.c              | 13 ++++++++++---
 include/hw/arm/smmu-common.h |  6 ++++++
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 0877248a88..80f94a85e7 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -37,6 +37,26 @@ void smmu_enable_secure_address_space(void)
     arm_secure_as_available = true;
 }
 
+/* Configuration Cache Management */
+static guint smmu_config_key_hash(gconstpointer key)
+{
+    const SMMUConfigKey *k = key;
+    return g_direct_hash(k->sdev) ^ (k->is_secure ? 1 : 0);
+}
+
+static gboolean smmu_config_key_equal(gconstpointer a, gconstpointer b)
+{
+    const SMMUConfigKey *ka = a;
+    const SMMUConfigKey *kb = b;
+    return ka->sdev == kb->sdev && ka->is_secure == kb->is_secure;
+}
+
+SMMUConfigKey smmu_get_config_key(SMMUDevice *sdev, bool is_secure)
+{
+    SMMUConfigKey key = {.sdev = sdev, .is_secure = is_secure};
+    return key;
+}
+
 /* IOTLB Management */
 
 static guint smmu_iotlb_key_hash(gconstpointer v)
@@ -236,7 +256,8 @@ static gboolean smmu_hash_remove_by_vmid_ipa(gpointer key, gpointer value,
 static gboolean
 smmu_hash_remove_by_sid_range(gpointer key, gpointer value, gpointer user_data)
 {
-    SMMUDevice *sdev = (SMMUDevice *)key;
+    SMMUConfigKey *config_key = (SMMUConfigKey *)key;
+    SMMUDevice *sdev = config_key->sdev;
     uint32_t sid = smmu_get_sid(sdev);
     SMMUSIDRange *sid_range = (SMMUSIDRange *)user_data;
 
@@ -943,7 +964,9 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
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
index 5f28e27503..972cbc872f 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -953,8 +953,9 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
     SMMUv3State *s = sdev->smmu;
     SMMUState *bc = &s->smmu_state;
     SMMUTransCfg *cfg;
+    SMMUConfigKey lookup_key = smmu_get_config_key(sdev, is_secure);
 
-    cfg = g_hash_table_lookup(bc->configs, sdev);
+    cfg = g_hash_table_lookup(bc->configs, &lookup_key);
     if (cfg) {
         sdev->cfg_cache_hits++;
         trace_smmuv3_config_cache_hit(smmu_get_sid(sdev),
@@ -971,7 +972,9 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
         cfg->secure = is_secure;
 
         if (!smmuv3_decode_config(&sdev->iommu, cfg, event)) {
-            g_hash_table_insert(bc->configs, sdev, cfg);
+            SMMUConfigKey *persistent_key = g_new(SMMUConfigKey, 1);
+            *persistent_key = smmu_get_config_key(sdev, is_secure);
+            g_hash_table_insert(bc->configs, persistent_key, cfg);
         } else {
             g_free(cfg);
             cfg = NULL;
@@ -984,9 +987,13 @@ static void smmuv3_flush_config(SMMUDevice *sdev)
 {
     SMMUv3State *s = sdev->smmu;
     SMMUState *bc = &s->smmu_state;
+    SMMUConfigKey key_secure = smmu_get_config_key(sdev, true);
+    SMMUConfigKey key_nonsecure = smmu_get_config_key(sdev, false);
 
     trace_smmu_config_cache_inv(smmu_get_sid(sdev));
-    g_hash_table_remove(bc->configs, sdev);
+    /* Remove both secure and non-secure configurations for this device */
+    g_hash_table_remove(bc->configs, &key_secure);
+    g_hash_table_remove(bc->configs, &key_nonsecure);
 }
 
 static void smmuv3_invalidate_all_caches(SMMUv3State *s)
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 597c5ef6c9..e07a9c35e7 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -156,6 +156,11 @@ typedef struct SMMUIOTLBKey {
     uint8_t level;
 } SMMUIOTLBKey;
 
+typedef struct SMMUConfigKey {
+    SMMUDevice *sdev;
+    bool is_secure;
+} SMMUConfigKey;
+
 typedef struct SMMUSIDRange {
     uint32_t start;
     uint32_t end;
@@ -230,6 +235,7 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
 void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
 SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
                                 uint8_t tg, uint8_t level);
+SMMUConfigKey smmu_get_config_key(SMMUDevice *sdev, bool is_secure);
 void smmu_iotlb_inv_all(SMMUState *s);
 void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid);
 void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
-- 
2.34.1


