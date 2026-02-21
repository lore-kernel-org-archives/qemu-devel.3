Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77843C61DCB
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Feb 2026 10:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtjpo-0005o5-3B; Sat, 21 Feb 2026 05:03:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtjpd-0005kl-D2; Sat, 21 Feb 2026 05:03:25 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtjpa-00056V-9u; Sat, 21 Feb 2026 05:03:25 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwD3TNDkgplpJxdzAA--.3244S2;
 Sat, 21 Feb 2026 18:03:16 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwD3TevcgplpBk4cAA--.34138S9;
 Sat, 21 Feb 2026 18:03:15 +0800 (CST)
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
Subject: [RFC v4 06/31] hw/arm/smmuv3: Track SEC_SID in configs and events
Date: Sat, 21 Feb 2026 18:02:25 +0800
Message-Id: <20260221100250.2976287-7-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwD3TevcgplpBk4cAA--.34138S9
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQANBWmYzyUAIQAAsz
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3XrWkJrW3Kry8XF18WF13CFg_yoW7Cr15pw
 1DGrn8Krn8ta4SvFy3XF4UZa13G397Krn8Kr9Fgr95Aws5CrW7XFs8Ga45ur909ryFyrW2
 vayIgFW5Zryjv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

Cache the SEC_SID inside SMMUTransCfg to keep configuration lookups
tied to the correct register bank.

Plumb the SEC_SID through tracepoints and queue helpers so diagnostics
and event logs always show which security interface emitted the record.
To support this, the SEC_SID is placed in SMMUEventInfo so the bank is
identified as soon as an event record is built.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmuv3-internal.h     |  1 +
 hw/arm/smmuv3.c              | 20 +++++++++++++-------
 hw/arm/trace-events          |  2 +-
 include/hw/arm/smmu-common.h |  1 +
 4 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 866d62257e3..a1071f7b689 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -274,6 +274,7 @@ static inline const char *smmu_event_string(SMMUEventType type)
 
 /*  Encode an event record */
 typedef struct SMMUEventInfo {
+    SMMUSecSID sec_sid;
     SMMUEventType type;
     uint32_t sid;
     bool recorded;
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 2c107724e77..3438adcecd2 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -148,9 +148,9 @@ static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in)
     return MEMTX_OK;
 }
 
-static MemTxResult smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
+static MemTxResult smmuv3_write_eventq(SMMUv3State *s, SMMUSecSID sec_sid,
+                                       Evt *evt)
 {
-    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
     SMMUQueue *q = &bank->eventq;
     MemTxResult r;
@@ -178,7 +178,8 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
 {
     Evt evt = {};
     MemTxResult r;
-    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
+    SMMUSecSID sec_sid = info->sec_sid;
+    g_assert(sec_sid < SMMU_SEC_SID_NUM);
 
     if (!smmuv3_eventq_enabled(s, sec_sid)) {
         return;
@@ -258,8 +259,9 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
         g_assert_not_reached();
     }
 
-    trace_smmuv3_record_event(smmu_event_string(info->type), info->sid);
-    r = smmuv3_write_eventq(s, &evt);
+    trace_smmuv3_record_event(sec_sid, smmu_event_string(info->type),
+                              info->sid);
+    r = smmuv3_write_eventq(s, sec_sid, &evt);
     if (r != MEMTX_OK) {
         smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_EVENTQ_ABT_ERR_MASK);
     }
@@ -917,6 +919,7 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event)
                             100 * sdev->cfg_cache_hits /
                             (sdev->cfg_cache_hits + sdev->cfg_cache_misses));
         cfg = g_new0(SMMUTransCfg, 1);
+        cfg->sec_sid = SMMU_SEC_SID_NS;
 
         if (!smmuv3_decode_config(&sdev->iommu, cfg, event)) {
             g_hash_table_insert(bc->configs, sdev, cfg);
@@ -1074,7 +1077,8 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
     SMMUEventInfo event = {.type = SMMU_EVT_NONE,
                            .sid = sid,
-                           .inval_ste_allowed = false};
+                           .inval_ste_allowed = false,
+                           .sec_sid = sec_sid};
     SMMUTranslationStatus status;
     SMMUTransCfg *cfg = NULL;
     IOMMUTLBEntry entry = {
@@ -1176,7 +1180,9 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
                                uint64_t num_pages, int stage)
 {
     SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
-    SMMUEventInfo eventinfo = {.inval_ste_allowed = true};
+    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
+    SMMUEventInfo eventinfo = {.sec_sid = sec_sid,
+                               .inval_ste_allowed = true};
     SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo);
     IOMMUTLBEvent event;
     uint8_t granule;
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 8135c0c7344..9c2cc131ab4 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -40,7 +40,7 @@ smmuv3_cmdq_opcode(const char *opcode) "<--- %s"
 smmuv3_cmdq_consume_out(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod:%d, cons:%d, prod_wrap:%d, cons_wrap:%d "
 smmuv3_cmdq_consume_error(const char *cmd_name, uint8_t cmd_error) "Error on %s command execution: %d"
 smmuv3_write_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
-smmuv3_record_event(const char *type, uint32_t sid) "%s sid=0x%x"
+smmuv3_record_event(int sec_sid, const char *type, uint32_t sid) "sec_sid=%d %s sid=0x%x"
 smmuv3_find_ste(uint16_t sid, uint32_t features, uint16_t sid_split) "sid=0x%x features:0x%x, sid_split:0x%x"
 smmuv3_find_ste_2lvl(uint64_t strtab_base, uint64_t l1ptr, int l1_ste_offset, uint64_t l2ptr, int l2_ste_offset, int max_l2_ste) "strtab_base:0x%"PRIx64" l1ptr:0x%"PRIx64" l1_off:0x%x, l2ptr:0x%"PRIx64" l2_off:0x%x max_l2_ste:%d"
 smmuv3_get_ste(uint64_t addr) "STE addr: 0x%"PRIx64
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 6ea40f6b074..ae1489717fe 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -107,6 +107,7 @@ typedef struct SMMUS2Cfg {
 typedef struct SMMUTransCfg {
     /* Shared fields between stage-1 and stage-2. */
     SMMUStage stage;           /* translation stage */
+    SMMUSecSID sec_sid;        /* cached sec sid */
     bool disabled;             /* smmu is disabled */
     bool bypassed;             /* translation is bypassed */
     bool aborted;              /* translation is aborted */
-- 
2.34.1


