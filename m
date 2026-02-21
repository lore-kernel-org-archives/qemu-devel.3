Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DEFEC61DE3
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Feb 2026 10:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtk3f-0000Mp-0z; Sat, 21 Feb 2026 05:17:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtk3d-0000Kr-EI; Sat, 21 Feb 2026 05:17:53 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtk3a-0000em-LN; Sat, 21 Feb 2026 05:17:53 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCHoqhJhplpRa9VBw--.6667S2;
 Sat, 21 Feb 2026 18:17:45 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwCn_epIhplpdE4cAA--.34722S3;
 Sat, 21 Feb 2026 18:17:44 +0800 (CST)
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
Subject: [RFC v4 20/31] hw/arm/smmu: Make CMDQ invalidation security-state
 aware
Date: Sat, 21 Feb 2026 18:17:41 +0800
Message-Id: <20260221101741.2995271-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCn_epIhplpdE4cAA--.34722S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQANBWmYzyUAPQAAsv
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoW3uw17XrW5XFy8XFWUWr45KFg_yoW8XrW3Ko
 WrJrWjgrW8Jr12gFn2vFn3GFW7ZryqyayUWr15Z3ya93ZxtF15tFyxtr4rXa1FyF4UJFWF
 vF95WrZ7XFy5AFyfn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
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

Refactor CMDQ invalidation paths to carry security state and apply
cache invalidation per sec_sid instead of globally. Extend common
IOTLB/config invalidation helpers with sec_sid filtering, while keeping
SMMU_SEC_SID_NUM as the full-invalidate mode.

In smmuv3, propagate sec_sid/ssec through CFGI and TLBI handling, and
gate VMID usage on queue stage-2 capability (including SEL2 for secure
CMDQ). Update tracepoints to include ssec for better observability.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmu-common.c         | 96 ++++++++++++++++++++++++++++++++----
 hw/arm/smmuv3.c              | 67 ++++++++++++++++++-------
 hw/arm/trace-events          |  6 +--
 include/hw/arm/smmu-common.h |  8 +--
 4 files changed, 144 insertions(+), 33 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index bb43430cc3b..5dece2024a4 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -201,7 +201,7 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new)
     uint8_t tg = (new->granule - 10) / 2;
 
     if (g_hash_table_size(bs->iotlb) >= SMMU_IOTLB_MAX_SIZE) {
-        smmu_iotlb_inv_all(bs);
+        smmu_iotlb_inv_all(bs, SMMU_SEC_SID_NUM);
     }
 
     *key = smmu_get_iotlb_key(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
@@ -211,10 +211,23 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new)
     g_hash_table_insert(bs->iotlb, key, new);
 }
 
-void smmu_iotlb_inv_all(SMMUState *s)
+static gboolean smmu_hash_remove_by_sec_sid(gpointer key, gpointer value,
+                                            gpointer user_data)
+{
+    SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
+    SMMUSecSID *sec_sid = (SMMUSecSID *)user_data;
+
+    return SMMU_IOTLB_SEC_SID(*iotlb_key) == *sec_sid;
+}
+
+void smmu_iotlb_inv_all(SMMUState *s, SMMUSecSID sec_sid)
 {
     trace_smmu_iotlb_inv_all();
-    g_hash_table_remove_all(s->iotlb);
+    if (sec_sid == SMMU_SEC_SID_NUM) {
+        g_hash_table_remove_all(s->iotlb);
+        return;
+    }
+    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_sec_sid, &sec_sid);
 }
 
 static gboolean smmu_hash_remove_by_asid_vmid(gpointer key, gpointer value,
@@ -292,6 +305,16 @@ static gboolean smmu_hash_remove_by_vmid_ipa(gpointer key, gpointer value,
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
@@ -307,11 +330,41 @@ smmu_hash_remove_by_sid_range(gpointer key, gpointer value, gpointer user_data)
     return true;
 }
 
-void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range)
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
+    trace_smmu_config_cache_inv(sid);
+    return true;
+}
+
+void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range,
+                                SMMUSecSID sec_sid)
 {
+    SMMUConfigInvRangeInfo info = {
+        .sid_range = sid_range,
+        .sec_sid = sec_sid,
+    };
+
     trace_smmu_configs_inv_sid_range(sid_range.start, sid_range.end);
-    g_hash_table_foreach_remove(s->configs, smmu_hash_remove_by_sid_range,
-                                &sid_range);
+    if (sec_sid == SMMU_SEC_SID_NUM) {
+        g_hash_table_foreach_remove(s->configs, smmu_hash_remove_by_sid_range,
+                                    &sid_range);
+        return;
+    }
+    g_hash_table_foreach_remove(s->configs, smmu_hash_remove_by_sid_range_sec,
+                                &info);
 }
 
 static gboolean smmu_hash_remove_by_sdev(gpointer key, gpointer value,
@@ -327,9 +380,35 @@ static gboolean smmu_hash_remove_by_sdev(gpointer key, gpointer value,
     return true;
 }
 
-void smmu_configs_inv_sdev(SMMUState *s, SMMUDevice *sdev)
+static gboolean smmu_hash_remove_by_sdev_sec(gpointer key, gpointer value,
+                                             gpointer user_data)
 {
-    g_hash_table_foreach_remove(s->configs, smmu_hash_remove_by_sdev, sdev);
+    SMMUConfigKey *config_key = (SMMUConfigKey *)key;
+    SMMUConfigInvSdevInfo *info = (SMMUConfigInvSdevInfo *)user_data;
+
+    if (config_key->sdev != info->sdev) {
+        return false;
+    }
+    if (config_key->sec_sid != info->sec_sid) {
+        return false;
+    }
+    trace_smmu_config_cache_inv(smmu_get_sid(info->sdev));
+    return true;
+}
+
+void smmu_configs_inv_sdev(SMMUState *s, SMMUDevice *sdev,
+                           SMMUSecSID sec_sid)
+{
+    SMMUConfigInvSdevInfo info = {
+        .sdev = sdev,
+        .sec_sid = sec_sid,
+    };
+
+    if (sec_sid == SMMU_SEC_SID_NUM) {
+        g_hash_table_foreach_remove(s->configs, smmu_hash_remove_by_sdev, sdev);
+        return;
+    }
+    g_hash_table_foreach_remove(s->configs, smmu_hash_remove_by_sdev_sec, &info);
 }
 
 void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
@@ -1193,4 +1272,3 @@ static void smmu_base_register_types(void)
 }
 
 type_init(smmu_base_register_types)
-
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index d4c58c0c724..29e862b8ae3 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -959,12 +959,13 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
     return cfg;
 }
 
-static void smmuv3_flush_config(SMMUDevice *sdev)
+/* Flush all config caches when sec_sid == SMMU_SEC_SID_NUM */
+static void smmuv3_flush_config(SMMUDevice *sdev, SMMUSecSID sec_sid)
 {
     SMMUv3State *s = sdev->smmu;
     SMMUState *bc = &s->smmu_state;
 
-    smmu_configs_inv_sdev(bc, sdev);
+    smmu_configs_inv_sdev(bc, sdev, sec_sid);
 }
 
 /* Do translation with TLB lookup. */
@@ -1289,7 +1290,7 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
 }
 
 static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
-                               SMMUSecSID sec_sid)
+                               SMMUSecSID sec_sid, bool use_vmid)
 {
     dma_addr_t end, addr = CMD_ADDR(cmd);
     uint8_t type = CMD_TYPE(cmd);
@@ -1302,10 +1303,8 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
     uint64_t num_pages;
     uint8_t granule;
     int asid = -1;
-    SMMUv3State *smmuv3 = ARM_SMMUV3(s);
 
-    /* Only consider VMID if stage-2 is supported. */
-    if (STAGE2_SUPPORTED(smmuv3)) {
+    if (use_vmid) {
         vmid = CMD_VMID(cmd);
     }
 
@@ -1351,6 +1350,25 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
     }
 }
 
+static inline bool smmu_cmdq_stage2_supported(SMMUv3State *s, SMMUSecSID sec_sid)
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
@@ -1362,6 +1380,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
     AddressSpace *as = smmu_get_address_space(bs, sec_sid);
     /* Secure AddressSpace must be available, assert if not. */
     g_assert(as);
+    bool queue_stage2_supported = smmu_cmdq_stage2_supported(s, sec_sid);
 
     if (!smmuv3_cmdq_enabled(s, sec_sid)) {
         return 0;
@@ -1376,6 +1395,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
     while (!smmuv3_q_empty(q)) {
         uint32_t pending = bank->gerror ^ bank->gerrorn;
         Cmd cmd;
+        SMMUSecSID ssec = SMMU_SEC_SID_NS;
 
         trace_smmuv3_cmdq_consume(sec_sid, Q_PROD(q), Q_CONS(q),
                                   Q_PROD_WRAP(q), Q_CONS_WRAP(q));
@@ -1399,6 +1419,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
+            ssec = SMMU_SEC_SID_S;
         }
 
         type = CMD_TYPE(&cmd);
@@ -1424,12 +1445,12 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
                 break;
             }
 
-            trace_smmuv3_cmdq_cfgi_ste(sid);
+            trace_smmuv3_cmdq_cfgi_ste(ssec, sid);
             if (!smmuv3_accel_install_ste(s, sdev, sid, errp)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
-            smmuv3_flush_config(sdev);
+            smmuv3_flush_config(sdev, ssec);
 
             break;
         }
@@ -1443,12 +1464,12 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
             sid_range.start = sid & ~mask;
             sid_range.end = sid_range.start + mask;
 
-            trace_smmuv3_cmdq_cfgi_ste_range(sid_range.start, sid_range.end);
+            trace_smmuv3_cmdq_cfgi_ste_range(ssec, sid_range.start, sid_range.end);
             if (!smmuv3_accel_install_ste_range(s, &sid_range, errp)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
-            smmu_configs_inv_sid_range(bs, sid_range);
+            smmu_configs_inv_sid_range(bs, sid_range, ssec);
             break;
         }
         case SMMU_CMD_CFGI_CD:
@@ -1470,8 +1491,8 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
                 break;
             }
 
-            trace_smmuv3_cmdq_cfgi_cd(sid);
-            smmuv3_flush_config(sdev);
+            trace_smmuv3_cmdq_cfgi_cd(ssec, sid);
+            smmuv3_flush_config(sdev, ssec);
             if (!smmuv3_accel_issue_inv_cmd(s, &cmd, sdev, errp)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
@@ -1492,7 +1513,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
              * VMID is only matched when stage 2 is supported, otherwise set it
              * to -1 as the value used for stage-1 only VMIDs.
              */
-            if (STAGE2_SUPPORTED(s)) {
+            if (queue_stage2_supported) {
                 vmid = CMD_VMID(&cmd);
             }
 
@@ -1518,18 +1539,27 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
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
+            smmu_inv_notifiers_all(&s->smmu_state);
+            smmu_iotlb_inv_all(bs, sec_sid);
+            break;
         }
         case SMMU_CMD_TLBI_NSNH_ALL:
             trace_smmuv3_cmdq_tlbi_nsnh();
             smmu_inv_notifiers_all(&s->smmu_state);
-            smmu_iotlb_inv_all(bs);
+            /*
+             * According to (IHI 0070G.b) 4.4.4.1 CMD_TLBI_NSNH_ALL, Page 194:
+             * "When issuing to the Realm programming interface, even though
+             * this command has NS in its name, it only applies to Realm entries."
+             */
+            smmu_iotlb_inv_all(bs, sec_sid > SMMU_SEC_SID_S ?
+                               sec_sid : SMMU_SEC_SID_NS);
             if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
@@ -1541,7 +1571,8 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
-            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1, SMMU_SEC_SID_NS);
+            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1, sec_sid,
+                               queue_stage2_supported);
             if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
@@ -1570,7 +1601,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
              * As currently only either s1 or s2 are supported
              * we can reuse same function for s2.
              */
-            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2, SMMU_SEC_SID_NS);
+            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2, SMMU_SEC_SID_NS, true);
             break;
         case SMMU_CMD_ATC_INV:
         {
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index ca8485c96af..64f308a8d35 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -51,9 +51,9 @@ smmuv3_translate_success(const char *n, uint16_t sid, uint64_t iova, uint64_t tr
 smmuv3_get_cd(uint64_t addr) "CD addr: 0x%"PRIx64
 smmuv3_decode_cd(uint32_t oas) "oas=%d"
 smmuv3_decode_cd_tt(int i, uint32_t tsz, uint64_t ttb, uint32_t granule_sz, bool had) "TT[%d]:tsz:%d ttb:0x%"PRIx64" granule_sz:%d had:%d"
-smmuv3_cmdq_cfgi_ste(int streamid) "streamid= 0x%x"
-smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%x - end=0x%x"
-smmuv3_cmdq_cfgi_cd(uint32_t sid) "sid=0x%x"
+smmuv3_cmdq_cfgi_ste(int ssec, int streamid) "ssec=%d streamid= 0x%x"
+smmuv3_cmdq_cfgi_ste_range(int ssec, int start, int end) "ssec=%d start=0x%x - end=0x%x"
+smmuv3_cmdq_cfgi_cd(int ssec, uint32_t sid) "ssec=%d sid=0x%x"
 smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache HIT for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
 smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
 smmuv3_range_inval(int sec_sid, int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf, int stage) "sec_sid=%d vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d stage=%d"
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 7d1d0936921..d05cf6ae53b 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -259,7 +259,7 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
 SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
                                 uint8_t tg, uint8_t level, SMMUSecSID sec_sid);
 SMMUConfigKey smmu_get_config_key(SMMUDevice *sdev, SMMUSecSID sec_sid);
-void smmu_iotlb_inv_all(SMMUState *s);
+void smmu_iotlb_inv_all(SMMUState *s, SMMUSecSID sec_sid);
 void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid,
                               SMMUSecSID sec_sid);
 void smmu_iotlb_inv_vmid(SMMUState *s, int vmid, SMMUSecSID sec_sid);
@@ -270,8 +270,10 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
 void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
                         uint64_t num_pages, uint8_t ttl,
                         SMMUSecSID sec_sid);
-void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range);
-void smmu_configs_inv_sdev(SMMUState *s, SMMUDevice *sdev);
+void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range,
+                                SMMUSecSID sec_sid);
+void smmu_configs_inv_sdev(SMMUState *s, SMMUDevice *sdev,
+                           SMMUSecSID sec_sid);
 /* Unmap the range of all the notifiers registered to any IOMMU mr */
 void smmu_inv_notifiers_all(SMMUState *s);
 
-- 
2.34.1


