Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F728606A327
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSGT4-0007lh-OA; Sat, 14 Nov 2026 11:19:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGSC-00078V-Mh; Sat, 14 Nov 2026 11:18:18 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGS8-0003E9-9K; Sat, 14 Nov 2026 11:18:12 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwDnHKW7ifhqNFoqBg--.64095S2; 
 Sun, 15 Nov 2026 00:18:03 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwOHSyifhq4Nv6AA--.29617S9;
 Sun, 15 Nov 2026 00:18:00 +0800 (CST)
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
Subject: [PATCH v6 16/35] hw/arm/smmuv3: Scope configuration invalidation by
 SEC_SID
Date: Sun, 15 Nov 2026 00:17:50 +0800
Message-Id: <20261114161753.3645568-7-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
References: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwOHSyifhq4Nv6AA--.29617S9
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWr3ZUsBfAAAsZ
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3uryrCryfAw13Wr4kZFW5Wrg_yoWDWw1Upr
 WUWr95Gr48JF93AFsxJay8ua15JwnF9F1rKryagr95A398Ar9rZr4DG3yYkr9rGr17Xrsr
 ZayxWa15ZryxZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

Configuration cache entries are keyed by device and SEC_SID, but command
invalidation must also select the matching security state.

Add SEC_SID-aware configuration cache invalidation helpers and use the
command queue state and command SSec field when processing CFGI commands.
Keep full-cache invalidation available for operations that require it.
Include the issuing and target SEC_SID values in the affected traces.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 include/hw/arm/smmu-common.h |  5 +++
 hw/arm/smmu-common.c         | 82 +++++++++++++++++++++++++++++++++++-
 hw/arm/smmuv3.c              | 18 ++++----
 hw/arm/trace-events          |  9 ++--
 4 files changed, 100 insertions(+), 14 deletions(-)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 8e971c28093..49b86cede47 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -280,7 +280,12 @@ void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
                         uint64_t num_pages, uint8_t ttl,
                         SMMUSecSID sec_sid);
 void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range);
+void smmu_configs_inv_sid_range_by_sec_sid(SMMUState *s,
+                                           SMMUSIDRange sid_range,
+                                           SMMUSecSID sec_sid);
 void smmu_configs_inv_sdev(SMMUState *s, SMMUDevice *sdev);
+void smmu_configs_inv_sdev_by_sec_sid(SMMUState *s, SMMUDevice *sdev,
+                                      SMMUSecSID sec_sid);
 /* Unmap the range of all the notifiers registered to any IOMMU mr */
 void smmu_inv_notifiers_all(SMMUState *s);
 
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 9c172fbb765..f6ad89208ac 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -303,6 +303,16 @@ static gboolean smmu_hash_remove_by_vmid_ipa(gpointer key, gpointer value,
            ((entry->iova & ~info->mask) == info->iova);
 }
 
+typedef struct SMMUConfigInvRangeInfo {
+    SMMUSIDRange sid_range;
+    SMMUSecSID sec_sid;
+} SMMUConfigInvRangeInfo;
+
+typedef struct SMMUConfigInvSdevInfo {
+    SMMUDevice *sdev;
+    SMMUSecSID sec_sid;
+} SMMUConfigInvSdevInfo;
+
 static gboolean
 smmu_hash_remove_by_sid_range(gpointer key, gpointer value, gpointer user_data)
 {
@@ -314,7 +324,26 @@ smmu_hash_remove_by_sid_range(gpointer key, gpointer value, gpointer user_data)
     if (sid < sid_range->start || sid > sid_range->end) {
         return false;
     }
-    trace_smmu_config_cache_inv(sid);
+    trace_smmu_config_cache_inv(config_key->sec_sid, sid);
+    return true;
+}
+
+static gboolean
+smmu_hash_remove_by_sid_range_sec(gpointer key, gpointer value,
+                                  gpointer user_data)
+{
+    SMMUConfigKey *config_key = (SMMUConfigKey *)key;
+    SMMUConfigInvRangeInfo *info = (SMMUConfigInvRangeInfo *)user_data;
+    SMMUDevice *sdev = config_key->sdev;
+    uint32_t sid = smmu_get_sid(sdev);
+
+    if (config_key->sec_sid != info->sec_sid) {
+        return false;
+    }
+    if (sid < info->sid_range.start || sid > info->sid_range.end) {
+        return false;
+    }
+    trace_smmu_config_cache_inv(config_key->sec_sid, sid);
     return true;
 }
 
@@ -325,6 +354,23 @@ void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range)
                                 &sid_range);
 }
 
+void smmu_configs_inv_sid_range_by_sec_sid(SMMUState *s,
+                                           SMMUSIDRange sid_range,
+                                           SMMUSecSID sec_sid)
+{
+    SMMUConfigInvRangeInfo info = {
+        .sid_range = sid_range,
+        .sec_sid = sec_sid,
+    };
+
+    g_assert(sec_sid < SMMU_SEC_SID_NUM);
+
+    trace_smmu_configs_inv_sid_range_by_sec_sid(sec_sid, sid_range.start,
+                                                sid_range.end);
+    g_hash_table_foreach_remove(s->configs, smmu_hash_remove_by_sid_range_sec,
+                                &info);
+}
+
 static gboolean smmu_hash_remove_by_sdev(gpointer key, gpointer value,
                                          gpointer user_data)
 {
@@ -334,7 +380,25 @@ static gboolean smmu_hash_remove_by_sdev(gpointer key, gpointer value,
     if (config_key->sdev != target) {
         return false;
     }
-    trace_smmu_config_cache_inv(smmu_get_sid(target));
+    trace_smmu_config_cache_inv(config_key->sec_sid,
+                                smmu_get_sid(target));
+    return true;
+}
+
+static gboolean smmu_hash_remove_by_sdev_sec(gpointer key, gpointer value,
+                                             gpointer user_data)
+{
+    SMMUConfigKey *config_key = (SMMUConfigKey *)key;
+    SMMUConfigInvSdevInfo *info = (SMMUConfigInvSdevInfo *)user_data;
+
+    if (config_key->sdev != info->sdev) {
+        return false;
+    }
+    if (config_key->sec_sid != info->sec_sid) {
+        return false;
+    }
+    trace_smmu_config_cache_inv(config_key->sec_sid,
+                                smmu_get_sid(info->sdev));
     return true;
 }
 
@@ -343,6 +407,20 @@ void smmu_configs_inv_sdev(SMMUState *s, SMMUDevice *sdev)
     g_hash_table_foreach_remove(s->configs, smmu_hash_remove_by_sdev, sdev);
 }
 
+void smmu_configs_inv_sdev_by_sec_sid(SMMUState *s, SMMUDevice *sdev,
+                                      SMMUSecSID sec_sid)
+{
+    SMMUConfigInvSdevInfo info = {
+        .sdev = sdev,
+        .sec_sid = sec_sid,
+    };
+
+    g_assert(sec_sid < SMMU_SEC_SID_NUM);
+
+    g_hash_table_foreach_remove(s->configs, smmu_hash_remove_by_sdev_sec,
+                                &info);
+}
+
 void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
                          uint8_t tg, uint64_t num_pages, uint8_t ttl,
                          SMMUSecSID sec_sid)
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ce00461210b..41fa7271d8d 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -998,12 +998,13 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
     return cfg;
 }
 
-static void smmuv3_flush_config(SMMUDevice *sdev)
+static void smmuv3_flush_config_by_sec_sid(SMMUDevice *sdev,
+                                           SMMUSecSID sec_sid)
 {
     SMMUv3State *s = sdev->smmu;
     SMMUState *bc = &s->smmu_state;
 
-    smmu_configs_inv_sdev(bc, sdev);
+    smmu_configs_inv_sdev_by_sec_sid(bc, sdev, sec_sid);
 }
 
 /* Do translation with TLB lookup. */
@@ -1472,12 +1473,12 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
                 break;
             }
 
-            trace_smmuv3_cmdq_cfgi_ste(sid);
+            trace_smmuv3_cmdq_cfgi_ste(sec_sid, ssec, sid);
             if (!smmuv3_accel_install_ste(s, sdev, sid, errp)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
-            smmuv3_flush_config(sdev);
+            smmuv3_flush_config_by_sec_sid(sdev, ssec);
 
             break;
         }
@@ -1491,12 +1492,13 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
             sid_range.start = sid & ~mask;
             sid_range.end = sid_range.start + mask;
 
-            trace_smmuv3_cmdq_cfgi_ste_range(sid_range.start, sid_range.end);
+            trace_smmuv3_cmdq_cfgi_ste_range(sec_sid, ssec,
+                                             sid_range.start, sid_range.end);
             if (!smmuv3_accel_install_ste_range(s, &sid_range, errp)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
-            smmu_configs_inv_sid_range(bs, sid_range);
+            smmu_configs_inv_sid_range_by_sec_sid(bs, sid_range, ssec);
             break;
         }
         case SMMU_CMD_CFGI_CD:
@@ -1518,8 +1520,8 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
                 break;
             }
 
-            trace_smmuv3_cmdq_cfgi_cd(sid);
-            smmuv3_flush_config(sdev);
+            trace_smmuv3_cmdq_cfgi_cd(sec_sid, ssec, sid);
+            smmuv3_flush_config_by_sec_sid(sdev, ssec);
             if (!smmuv3_accel_issue_inv_cmd(s, &cmd, sdev, errp)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 8a14daa9252..ea525a81b3f 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -24,7 +24,8 @@ smmu_iotlb_inv_vmid(int sec_sid, int vmid) "IOTLB invalidate sec_sid=%d vmid=%d"
 smmu_iotlb_inv_vmid_s1(int sec_sid, int vmid) "IOTLB invalidate S1 sec_sid=%d vmid=%d"
 smmu_iotlb_inv_iova(int sec_sid, int asid, uint64_t addr) "IOTLB invalidate sec_sid=%d asid=%d addr=0x%"PRIx64
 smmu_configs_inv_sid_range(uint32_t start, uint32_t end) "Config cache INV SID range from 0x%x to 0x%x"
-smmu_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
+smmu_configs_inv_sid_range_by_sec_sid(int sec_sid, uint32_t start, uint32_t end) "Config cache INV sec_sid=%d SID range from 0x%x to 0x%x"
+smmu_config_cache_inv(int sec_sid, uint32_t sid) "Config cache INV sec_sid=%d sid=0x%x"
 smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
 smmu_iotlb_lookup_hit(int sec_sid, int asid, int vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT sec_sid=%d asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
 smmu_iotlb_lookup_miss(int sec_sid, int asid, int vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS sec_sid=%d asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
@@ -52,9 +53,9 @@ smmuv3_translate_success(const char *n, uint16_t sid, uint64_t iova, uint64_t tr
 smmuv3_get_cd(uint64_t addr) "CD addr: 0x%"PRIx64
 smmuv3_decode_cd(uint32_t oas) "oas=%d"
 smmuv3_decode_cd_tt(int i, uint32_t tsz, uint64_t ttb, uint32_t granule_sz, bool had) "TT[%d]:tsz:%d ttb:0x%"PRIx64" granule_sz:%d had:%d"
-smmuv3_cmdq_cfgi_ste(int streamid) "streamid= 0x%x"
-smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%x - end=0x%x"
-smmuv3_cmdq_cfgi_cd(uint32_t sid) "sid=0x%x"
+smmuv3_cmdq_cfgi_ste(int sec_sid, int ssec, int streamid) "cmdq_sec_sid=%d ssec=%d streamid=0x%x"
+smmuv3_cmdq_cfgi_ste_range(int sec_sid, int ssec, int start, int end) "cmdq_sec_sid=%d ssec=%d start=0x%x - end=0x%x"
+smmuv3_cmdq_cfgi_cd(int sec_sid, int ssec, uint32_t sid) "cmdq_sec_sid=%d ssec=%d sid=0x%x"
 smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache HIT for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
 smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
 smmuv3_range_inval(int sec_sid, int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf, int stage) "sec_sid=%d vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d stage=%d"
-- 
2.34.1


