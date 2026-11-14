Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02699606A32D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSGTH-00005s-Ht; Sat, 14 Nov 2026 11:19:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGSE-00078d-5o; Sat, 14 Nov 2026 11:18:22 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGS8-0003ED-90; Sat, 14 Nov 2026 11:18:13 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwDHz1u7ifhqNRoGAg--.42322S2; 
 Sun, 15 Nov 2026 00:18:03 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwOHSyifhq4Nv6AA--.29617S10;
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
Subject: [PATCH v6 17/35] hw/arm/smmuv3: Scope IOTLB invalidation by SEC_SID
Date: Sun, 15 Nov 2026 00:17:51 +0800
Message-Id: <20261114161753.3645568-8-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
References: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwOHSyifhq4Nv6AA--.29617S10
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWr3ZUsBfAABsY
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxKF45XrW5JF4xGr13CrykXwb_yoWfAw18pr
 WUur95Gr15AF93ZasrAw48ua13Xw1DKry5Kr90gF9Yya4kAryUZr4DCw15Ar95Wr15Crsx
 Z3yUWr45ZF17ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

IOTLB invalidation must select the security state represented in the
cache key. Add SEC_SID matching to the invalidation helpers and propagate
the command queue or command-selected state through TLBI handling.

Select stage-2 capability from the issuing command queue when deciding
whether to match VMID, including SEL2 for the Secure command queue.
Preserve full-cache invalidation for operations that require it and
include SEC_SID in the affected invalidation traces.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 include/hw/arm/smmu-common.h |  1 +
 hw/arm/smmu-common.c         | 18 +++++++++++
 hw/arm/smmuv3.c              | 62 +++++++++++++++++++++++++++++-------
 hw/arm/trace-events          |  3 +-
 4 files changed, 71 insertions(+), 13 deletions(-)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 49b86cede47..a21c6061808 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -269,6 +269,7 @@ SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
                                 uint8_t tg, uint8_t level, SMMUSecSID sec_sid);
 SMMUConfigKey smmu_get_config_key(SMMUDevice *sdev, SMMUSecSID sec_sid);
 void smmu_iotlb_inv_all(SMMUState *s);
+void smmu_iotlb_inv_by_sec_sid(SMMUState *s, SMMUSecSID sec_sid);
 void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid,
                               SMMUSecSID sec_sid);
 void smmu_iotlb_inv_vmid(SMMUState *s, int vmid, SMMUSecSID sec_sid);
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index f6ad89208ac..0408fd25b3a 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -222,12 +222,30 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new,
     g_hash_table_insert(bs->iotlb, key, new);
 }
 
+static gboolean smmu_hash_remove_by_sec_sid(gpointer key, gpointer value,
+                                            gpointer user_data)
+{
+    SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
+    SMMUSecSID *sec_sid = (SMMUSecSID *)user_data;
+
+    return SMMU_IOTLB_SEC_SID(*iotlb_key) == *sec_sid;
+}
+
 void smmu_iotlb_inv_all(SMMUState *s)
 {
     trace_smmu_iotlb_inv_all();
     g_hash_table_remove_all(s->iotlb);
 }
 
+void smmu_iotlb_inv_by_sec_sid(SMMUState *s, SMMUSecSID sec_sid)
+{
+    g_assert(sec_sid < SMMU_SEC_SID_NUM);
+
+    trace_smmu_iotlb_inv_by_sec_sid(sec_sid);
+    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_sec_sid,
+                                &sec_sid);
+}
+
 static gboolean smmu_hash_remove_by_asid_vmid(gpointer key, gpointer value,
                                               gpointer user_data)
 {
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 41fa7271d8d..fc5cd46d1a8 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1340,7 +1340,7 @@ static void smmuv3_inv_notifiers_all(SMMUState *s, SMMUSecSID sec_sid)
 }
 
 static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
-                               SMMUSecSID sec_sid)
+                               SMMUSecSID sec_sid, bool use_vmid)
 {
     dma_addr_t end, addr = CMD_ADDR(cmd);
     uint8_t type = CMD_TYPE(cmd);
@@ -1353,10 +1353,8 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
     uint64_t num_pages;
     uint8_t granule;
     int asid = -1;
-    SMMUv3State *smmuv3 = ARM_SMMUV3(s);
 
-    /* Only consider VMID if stage-2 is supported. */
-    if (STAGE2_SUPPORTED(smmuv3)) {
+    if (use_vmid) {
         vmid = CMD_VMID(cmd);
     }
 
@@ -1403,6 +1401,26 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
     }
 }
 
+static inline bool
+smmu_cmdq_stage2_supported(SMMUv3State *s, SMMUSecSID sec_sid)
+{
+    /* IDR0.S2P: Stage 2 translation supported */
+    bool s2p = STAGE2_SUPPORTED(s);
+    if (!s2p) {
+        return false;
+    }
+
+    /*
+     * For Secure Command queue, Secure stage 2 is additionally gated by SEL2
+     * (SEL2 is 0 if S2P is 0).
+     */
+    if (sec_sid == SMMU_SEC_SID_S) {
+        return FIELD_EX32(s->bank[SMMU_SEC_SID_S].idr[1], S_IDR1, SEL2);
+    }
+
+    return true;
+}
+
 static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
 {
     SMMUState *bs = ARM_SMMU(s);
@@ -1412,6 +1430,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
     SMMUCommandType type = 0;
     MemTxAttrs attrs = smmu_get_txattrs(sec_sid);
     AddressSpace *as = smmu_get_address_space(bs, sec_sid);
+    bool queue_stage2_supported = smmu_cmdq_stage2_supported(s, sec_sid);
 
     if (!smmuv3_cmdq_enabled(s, sec_sid)) {
         return 0;
@@ -1542,7 +1561,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
              * VMID is only matched when stage 2 is supported, otherwise set it
              * to -1 as the value used for stage-1 only VMIDs.
              */
-            if (STAGE2_SUPPORTED(s)) {
+            if (queue_stage2_supported) {
                 vmid = CMD_VMID(&cmd);
             }
 
@@ -1568,30 +1587,49 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
              * If stage-2 is supported, invalidate for this VMID only, otherwise
              * invalidate the whole thing.
              */
-            if (STAGE2_SUPPORTED(s)) {
+            if (queue_stage2_supported) {
                 vmid = CMD_VMID(&cmd);
                 trace_smmuv3_cmdq_tlbi_nh(sec_sid, vmid);
                 smmu_iotlb_inv_vmid_s1(bs, vmid, sec_sid);
                 break;
             }
-            QEMU_FALLTHROUGH;
+            trace_smmuv3_cmdq_tlbi_nh(sec_sid, vmid);
+            smmuv3_inv_notifiers_all(bs, sec_sid);
+            smmu_iotlb_inv_by_sec_sid(bs, sec_sid);
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
+            break;
         }
         case SMMU_CMD_TLBI_NSNH_ALL:
-            trace_smmuv3_cmdq_tlbi_nsnh();
-            smmuv3_inv_notifiers_all(bs, SMMU_SEC_SID_NS);
-            smmu_iotlb_inv_all(bs);
+        {
+            /*
+             * CMD_TLBI_NSNH_ALL targets Non-secure entries when issued from the
+             * Non-secure or Secure Command queue, but Realm entries when issued
+             * from the Realm Command queue.
+             * (IHI 0070G.b) 4.4.4.1 CMD_TLBI_NSNH_ALL, Page 194
+             */
+            SMMUSecSID target_sec_sid = sec_sid > SMMU_SEC_SID_S ?
+                                        sec_sid : SMMU_SEC_SID_NS;
+
+            trace_smmuv3_cmdq_tlbi_nsnh(sec_sid, target_sec_sid);
+            smmuv3_inv_notifiers_all(bs, target_sec_sid);
+            smmu_iotlb_inv_by_sec_sid(bs, target_sec_sid);
             if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
             break;
+        }
         case SMMU_CMD_TLBI_NH_VAA:
         case SMMU_CMD_TLBI_NH_VA:
             if (!STAGE1_SUPPORTED(s)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
-            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1, SMMU_SEC_SID_NS);
+            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1, sec_sid,
+                               queue_stage2_supported);
             if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
@@ -1620,7 +1658,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
              * As currently only either s1 or s2 are supported
              * we can reuse same function for s2.
              */
-            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2, SMMU_SEC_SID_NS);
+            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2, SMMU_SEC_SID_NS, true);
             break;
         case SMMU_CMD_ATC_INV:
         {
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index ea525a81b3f..4130d16fad5 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -19,6 +19,7 @@ smmu_ptw_page_pte(int stage, int level,  uint64_t iova, uint64_t baseaddr, uint6
 smmu_ptw_block_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr, uint64_t pte, uint64_t iova, uint64_t gpa, int bsize_mb) "stage=%d level=%d base@=0x%"PRIx64" pte@=0x%"PRIx64" pte=0x%"PRIx64" iova=0x%"PRIx64" block address = 0x%"PRIx64" block size = %d MiB"
 smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte) "baseaddr=0x%"PRIx64" index=0x%x, pteaddr=0x%"PRIx64", pte=0x%"PRIx64
 smmu_iotlb_inv_all(void) "IOTLB invalidate all"
+smmu_iotlb_inv_by_sec_sid(int sec_sid) "IOTLB invalidate sec_sid=%d"
 smmu_iotlb_inv_asid_vmid(int sec_sid, int asid, int vmid) "IOTLB invalidate sec_sid=%d asid=%d vmid=%d"
 smmu_iotlb_inv_vmid(int sec_sid, int vmid) "IOTLB invalidate sec_sid=%d vmid=%d"
 smmu_iotlb_inv_vmid_s1(int sec_sid, int vmid) "IOTLB invalidate S1 sec_sid=%d vmid=%d"
@@ -60,7 +61,7 @@ smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t p
 smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
 smmuv3_range_inval(int sec_sid, int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf, int stage) "sec_sid=%d vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d stage=%d"
 smmuv3_cmdq_tlbi_nh(int sec_sid, int vmid) "sec_sid=%d vmid=%d"
-smmuv3_cmdq_tlbi_nsnh(void) ""
+smmuv3_cmdq_tlbi_nsnh(int sec_sid, int target_sec_sid) "cmdq_sec_sid=%d target_sec_sid=%d"
 smmuv3_cmdq_tlbi_nh_asid(int sec_sid, int asid) "sec_sid=%d asid=%d"
 smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
 smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
-- 
2.34.1


