Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BFDC61DE2
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Feb 2026 10:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtk0q-00047V-9z; Sat, 21 Feb 2026 05:15:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtk0j-0003zr-JC; Sat, 21 Feb 2026 05:14:53 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtk0g-0002AS-8S; Sat, 21 Feb 2026 05:14:53 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBHT5uThZlpCqxVBw--.2789S2;
 Sat, 21 Feb 2026 18:14:43 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwB3zuuQhZlpW04cAA--.34568S3;
 Sat, 21 Feb 2026 18:14:41 +0800 (CST)
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
Subject: [RFC v4 10/31] hw/arm/smmu-common: Key configuration cache on
 SMMUDevice and SEC_SID
Date: Sat, 21 Feb 2026 18:14:37 +0800
Message-Id: <20260221101437.2990803-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwB3zuuQhZlpW04cAA--.34568S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQANBWmYzyUAKQAAs7
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxKFW7GFWUZFyUGr45GrWDXFb_yoWxuF43pr
 W8GF95Jr4UGF1fCFsxXFWI9as8Wwn29r1fGryagr9YyFyqyryUAF4DK3yYk3s3CrWkJF47
 ZayIgFyUCr1xJaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
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

Adapt the configuration cache to support multiple security states by
introducing a composite key, SMMUConfigKey. This key combines the
SMMUDevice with SEC_SID, preventing aliasing between Secure and
Non-secure configurations for the same device, also the future Realm and
Root configurations.

The cache lookup, insertion, and invalidation mechanisms are updated
to use this new keying infrastructure. This change is critical for
ensuring correct translation when a device is active in more than one
security world.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Link: https://lore.kernel.org/qemu-devel/a9a840a6-c65f-4352-9a49-ddd1b5483f43@redhat.com/
---
 hw/arm/smmu-common.c         | 45 ++++++++++++++++++++++++++++++++++--
 hw/arm/smmuv3.c              | 13 +++++++----
 include/hw/arm/smmu-common.h |  7 ++++++
 3 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index b320aec8c60..a732303b28b 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -30,6 +30,26 @@
 #include "hw/arm/smmu-common.h"
 #include "smmu-internal.h"
 
+/* Configuration Cache Management */
+static guint smmu_config_key_hash(gconstpointer key)
+{
+    const SMMUConfigKey *k = key;
+    return g_direct_hash(k->sdev) ^ (guint)k->sec_sid;
+}
+
+static gboolean smmu_config_key_equal(gconstpointer a, gconstpointer b)
+{
+    const SMMUConfigKey *ka = a;
+    const SMMUConfigKey *kb = b;
+    return ka->sdev == kb->sdev && ka->sec_sid == kb->sec_sid;
+}
+
+SMMUConfigKey smmu_get_config_key(SMMUDevice *sdev, SMMUSecSID sec_sid)
+{
+    SMMUConfigKey key = {.sdev = sdev, .sec_sid = sec_sid};
+    return key;
+}
+
 ARMSecuritySpace smmu_get_security_space(SMMUSecSID sec_sid)
 {
     switch (sec_sid) {
@@ -265,7 +285,8 @@ static gboolean smmu_hash_remove_by_vmid_ipa(gpointer key, gpointer value,
 static gboolean
 smmu_hash_remove_by_sid_range(gpointer key, gpointer value, gpointer user_data)
 {
-    SMMUDevice *sdev = (SMMUDevice *)key;
+    SMMUConfigKey *config_key = (SMMUConfigKey *)key;
+    SMMUDevice *sdev = config_key->sdev;
     uint32_t sid = smmu_get_sid(sdev);
     SMMUSIDRange *sid_range = (SMMUSIDRange *)user_data;
 
@@ -283,6 +304,24 @@ void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range)
                                 &sid_range);
 }
 
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
@@ -978,7 +1017,9 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
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
index d011357253e..aa1a95a0093 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -904,10 +904,11 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
  *
  * @sdev: SMMUDevice handle
  * @event: output event info
+ * @sec_sid: StreamID Security state
  *
  * The configuration cache contains data resulting from both STE and CD
  * decoding under the form of an SMMUTransCfg struct. The hash table is indexed
- * by the SMMUDevice handle.
+ * by a composite key of the SMMUDevice and the sec_sid.
  */
 static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
                                        SMMUSecSID sec_sid)
@@ -915,8 +916,9 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
     SMMUv3State *s = sdev->smmu;
     SMMUState *bc = &s->smmu_state;
     SMMUTransCfg *cfg;
+    SMMUConfigKey lookup_key = smmu_get_config_key(sdev, sec_sid);
 
-    cfg = g_hash_table_lookup(bc->configs, sdev);
+    cfg = g_hash_table_lookup(bc->configs, &lookup_key);
     if (cfg) {
         sdev->cfg_cache_hits++;
         trace_smmuv3_config_cache_hit(smmu_get_sid(sdev),
@@ -940,7 +942,9 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
         g_assert(cfg->as && cfg->ns_as);
 
         if (!smmuv3_decode_config(&sdev->iommu, cfg, event)) {
-            g_hash_table_insert(bc->configs, sdev, cfg);
+            SMMUConfigKey *persistent_key = g_new(SMMUConfigKey, 1);
+            *persistent_key = lookup_key;
+            g_hash_table_insert(bc->configs, persistent_key, cfg);
         } else {
             g_free(cfg);
             cfg = NULL;
@@ -954,8 +958,7 @@ static void smmuv3_flush_config(SMMUDevice *sdev)
     SMMUv3State *s = sdev->smmu;
     SMMUState *bc = &s->smmu_state;
 
-    trace_smmu_config_cache_inv(smmu_get_sid(sdev));
-    g_hash_table_remove(bc->configs, sdev);
+    smmu_configs_inv_sdev(bc, sdev);
 }
 
 /* Do translation with TLB lookup. */
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 7944e8d1b64..9e44c9f7710 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -162,6 +162,11 @@ typedef struct SMMUIOTLBKey {
     uint8_t level;
 } SMMUIOTLBKey;
 
+typedef struct SMMUConfigKey {
+    SMMUDevice *sdev;
+    SMMUSecSID sec_sid;
+} SMMUConfigKey;
+
 typedef struct SMMUSIDRange {
     uint32_t start;
     uint32_t end;
@@ -250,6 +255,7 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
 void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
 SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
                                 uint8_t tg, uint8_t level);
+SMMUConfigKey smmu_get_config_key(SMMUDevice *sdev, SMMUSecSID sec_sid);
 void smmu_iotlb_inv_all(SMMUState *s);
 void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid);
 void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
@@ -259,6 +265,7 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
 void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
                         uint64_t num_pages, uint8_t ttl);
 void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range);
+void smmu_configs_inv_sdev(SMMUState *s, SMMUDevice *sdev);
 /* Unmap the range of all the notifiers registered to any IOMMU mr */
 void smmu_inv_notifiers_all(SMMUState *s);
 
-- 
2.34.1


