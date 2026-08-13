Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF4CC5CFCF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuYEp-0000Fn-Uu; Thu, 13 Aug 2026 12:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYEk-00007A-4u; Thu, 13 Aug 2026 12:24:59 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYEg-0000gv-8B; Thu, 13 Aug 2026 12:24:57 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwCXK1DT731qQh5vAw--.15404S2; 
 Fri, 14 Aug 2026 00:24:51 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwF3PO731q3ywjAA--.59573S5;
 Fri, 14 Aug 2026 00:24:48 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v5 08/28] hw/arm/smmu-common: Key configuration cache on
 SMMUDevice and SEC_SID
Date: Fri, 14 Aug 2026 00:24:44 +0800
Message-Id: <20260813162446.2806393-3-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwF3PO731q3ywjAA--.59573S5
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAGBWp8yc0HmQAAsO
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxtFWUZr1UCF1xJFW3urWUtwb_yoWxZw4xpr
 W8JF98Gr4UGF1fCFs3XFWxu3Z8Wwn2gF1fGryagr9YyFyqyry8AF4DK3yYk3s7CrWkJF47
 ZayxWFyUCr1xAaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Adapt the configuration cache to distinguish entries decoded through
different SEC_SID-selected programming interfaces by introducing a
composite SMMUConfigKey. The key combines SMMUDevice with SEC_SID,
preventing Secure and Non-secure configuration entries from aliasing in
the cache and leaving the key extensible for a future Realm SEC_SID
namespace.

The cache lookup, insertion, and invalidation mechanisms are updated to
use this new keying infrastructure.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/a9a840a6-c65f-4352-9a49-ddd1b5483f43@redhat.com/
---
 hw/arm/smmu-common.c         | 45 ++++++++++++++++++++++++++++++++++--
 hw/arm/smmuv3.c              | 12 ++++++----
 include/hw/arm/smmu-common.h |  7 ++++++
 3 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 89e1e2826d4..63c36329a98 100644
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
@@ -979,7 +1018,9 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
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
index 3ff2f498a3b..a01175cc672 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -952,7 +952,7 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
  *
  * The configuration cache contains data resulting from both STE and CD
  * decoding under the form of an SMMUTransCfg struct. The hash table is indexed
- * by the SMMUDevice handle.
+ * by a composite key of the SMMUDevice and the sec_sid.
  */
 static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
                                        SMMUSecSID sec_sid)
@@ -960,8 +960,9 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
     SMMUv3State *s = sdev->smmu;
     SMMUState *bc = &s->smmu_state;
     SMMUTransCfg *cfg;
+    SMMUConfigKey lookup_key = smmu_get_config_key(sdev, sec_sid);
 
-    cfg = g_hash_table_lookup(bc->configs, sdev);
+    cfg = g_hash_table_lookup(bc->configs, &lookup_key);
     if (cfg) {
         sdev->cfg_cache_hits++;
         trace_smmuv3_config_cache_hit(smmu_get_sid(sdev),
@@ -977,7 +978,9 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
         cfg = g_new0(SMMUTransCfg, 1);
 
         if (!smmuv3_decode_config(&sdev->iommu, cfg, event, sec_sid)) {
-            g_hash_table_insert(bc->configs, sdev, cfg);
+            SMMUConfigKey *persistent_key = g_new(SMMUConfigKey, 1);
+            *persistent_key = lookup_key;
+            g_hash_table_insert(bc->configs, persistent_key, cfg);
         } else {
             g_free(cfg);
             cfg = NULL;
@@ -991,8 +994,7 @@ static void smmuv3_flush_config(SMMUDevice *sdev)
     SMMUv3State *s = sdev->smmu;
     SMMUState *bc = &s->smmu_state;
 
-    trace_smmu_config_cache_inv(smmu_get_sid(sdev));
-    g_hash_table_remove(bc->configs, sdev);
+    smmu_configs_inv_sdev(bc, sdev);
 }
 
 /* Do translation with TLB lookup. */
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index a31ffcf6e71..bd83648b14c 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -153,6 +153,11 @@ typedef struct SMMUIOTLBKey {
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
@@ -247,6 +252,7 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
 void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
 SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
                                 uint8_t tg, uint8_t level);
+SMMUConfigKey smmu_get_config_key(SMMUDevice *sdev, SMMUSecSID sec_sid);
 void smmu_iotlb_inv_all(SMMUState *s);
 void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid);
 void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
@@ -256,6 +262,7 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
 void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
                         uint64_t num_pages, uint8_t ttl);
 void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range);
+void smmu_configs_inv_sdev(SMMUState *s, SMMUDevice *sdev);
 /* Unmap the range of all the notifiers registered to any IOMMU mr */
 void smmu_inv_notifiers_all(SMMUState *s);
 
-- 
2.34.1


