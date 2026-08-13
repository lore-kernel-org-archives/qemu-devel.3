Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017AEC5CFCF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuYED-0007yd-34; Thu, 13 Aug 2026 12:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYEA-0007um-Qb; Thu, 13 Aug 2026 12:24:22 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYE8-0000Ww-RF; Thu, 13 Aug 2026 12:24:22 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwCXn3uy731qExtvAw--.34194S2; 
 Fri, 14 Aug 2026 00:24:18 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwjnOq731q3SwjAA--.59176S6;
 Fri, 14 Aug 2026 00:24:15 +0800 (CST)
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
Subject: [RFC v5 04/28] hw/arm/smmuv3: Track SEC_SID in configs and events
Date: Fri, 14 Aug 2026 00:24:09 +0800
Message-Id: <20260813162410.2805113-4-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwjnOq731q3SwjAA--.59176S6
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAGBWp8yc0HkgAAsF
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3GF45JFW3AF4rtryUtryrJFb_yoW3GrW5pr
 1DGrn8Kr1DtF1fZF13Xa18A3W3Xw18KrnxtryqgFyrAw4DAry7XF4DGw1Ykr909rWjv3y2
 vayIgF45ury7A3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

Pass the SEC_SID explicitly to smmuv3_decode_config() so configuration
decoding can be tied to the correct register bank.

Plumb the SEC_SID through tracepoints and queue helpers so diagnostics
and event logs always show which security interface emitted the record.
To support this, the SEC_SID is placed in SMMUEventInfo so the bank is
identified as soon as an event record is built.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/smmuv3-accel.c    |  2 +-
 hw/arm/smmuv3-internal.h |  3 ++-
 hw/arm/smmuv3.c          | 26 +++++++++++++++-----------
 hw/arm/trace-events      |  2 +-
 include/hw/arm/smmuv3.h  |  1 +
 5 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index fa079c8acea..2ce94786829 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -509,7 +509,7 @@ static void smmuv3_accel_event_read(void *opaque)
     if (ret > 0) {
         return; /* EAGAIN/EINTR */
     }
-    smmuv3_propagate_event(s, (Evt *)&buf.vevent);
+    smmuv3_propagate_event(s, (Evt *)&buf.vevent, SMMU_SEC_SID_NS);
 }
 
 static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index a88743ba9cd..202cd533636 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -274,6 +274,7 @@ static inline const char *smmu_event_string(SMMUEventType type)
 
 /*  Encode an event record */
 typedef struct SMMUEventInfo {
+    SMMUSecSID sec_sid;
     SMMUEventType type;
     uint32_t sid;
     bool recorded;
@@ -365,7 +366,7 @@ typedef struct SMMUEventInfo {
 #define EVT_GET_SID(x)   ((x)->word[1])
 
 void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *event);
-void smmuv3_propagate_event(SMMUv3State *s, Evt *evt);
+void smmuv3_propagate_event(SMMUv3State *s, Evt *evt, SMMUSecSID sec_sid);
 int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event);
 
 #define STE_SIZE 6
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 51e970d710a..649050b9347 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -149,9 +149,9 @@ static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in)
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
@@ -175,14 +175,14 @@ static MemTxResult smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
     return MEMTX_OK;
 }
 
-void smmuv3_propagate_event(SMMUv3State *s, Evt *evt)
+void smmuv3_propagate_event(SMMUv3State *s, Evt *evt, SMMUSecSID sec_sid)
 {
     MemTxResult r;
 
-    trace_smmuv3_propagate_event(smmu_event_string(EVT_GET_TYPE(evt)),
+    trace_smmuv3_propagate_event(sec_sid, smmu_event_string(EVT_GET_TYPE(evt)),
                                  EVT_GET_SID(evt));
     QEMU_LOCK_GUARD(&s->mutex);
-    r = smmuv3_write_eventq(s, evt);
+    r = smmuv3_write_eventq(s, sec_sid, evt);
     if (r != MEMTX_OK) {
         smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_EVENTQ_ABT_ERR_MASK);
     }
@@ -191,7 +191,7 @@ void smmuv3_propagate_event(SMMUv3State *s, Evt *evt)
 void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
 {
     Evt evt = {};
-    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
+    SMMUSecSID sec_sid = info->sec_sid;
 
     if (!smmuv3_eventq_enabled(s, sec_sid)) {
         return;
@@ -271,7 +271,7 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
         g_assert_not_reached();
     }
 
-    smmuv3_propagate_event(s, &evt);
+    smmuv3_propagate_event(s, &evt, sec_sid);
     info->recorded = true;
 }
 
@@ -886,12 +886,13 @@ bad_cd:
  * @cfg: output translation configuration which is populated through
  *       the different configuration decoding steps
  * @event: must be zero'ed by the caller
+ * @sec_sid: StreamID Security state
  *
  * return < 0 in case of config decoding error (@event is filled
  * accordingly). Return 0 otherwise.
  */
 static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
-                                SMMUEventInfo *event)
+                                SMMUEventInfo *event, SMMUSecSID sec_sid)
 {
     SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
     uint32_t sid = smmu_get_sid(sdev);
@@ -958,7 +959,7 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event)
                             (sdev->cfg_cache_hits + sdev->cfg_cache_misses));
         cfg = g_new0(SMMUTransCfg, 1);
 
-        if (!smmuv3_decode_config(&sdev->iommu, cfg, event)) {
+        if (!smmuv3_decode_config(&sdev->iommu, cfg, event, SMMU_SEC_SID_NS)) {
             g_hash_table_insert(bc->configs, sdev, cfg);
         } else {
             g_free(cfg);
@@ -1114,7 +1115,8 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
     SMMUEventInfo event = {.type = SMMU_EVT_NONE,
                            .sid = sid,
-                           .inval_ste_allowed = false};
+                           .inval_ste_allowed = false,
+                           .sec_sid = sec_sid};
     SMMUTranslationStatus status;
     SMMUTransCfg *cfg = NULL;
     IOMMUTLBEntry entry = {
@@ -1216,7 +1218,9 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
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
index 1b16f710fed..a166b79c8ef 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -41,7 +41,7 @@ smmuv3_cmdq_opcode(const char *opcode) "<--- %s"
 smmuv3_cmdq_consume_out(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod:%d, cons:%d, prod_wrap:%d, cons_wrap:%d "
 smmuv3_cmdq_consume_error(const char *cmd_name, uint8_t cmd_error) "Error on %s command execution: %d"
 smmuv3_write_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
-smmuv3_propagate_event(const char *type, uint32_t sid) "%s sid=0x%x"
+smmuv3_propagate_event(int sec_sid, const char *type, uint32_t sid) "sec_sid=%d %s sid=0x%x"
 smmuv3_find_ste(uint16_t sid, uint32_t features, uint16_t sid_split) "sid=0x%x features:0x%x, sid_split:0x%x"
 smmuv3_find_ste_2lvl(uint64_t strtab_base, uint64_t l1ptr, int l1_ste_offset, uint64_t l2ptr, int l2_ste_offset, int max_l2_ste) "strtab_base:0x%"PRIx64" l1ptr:0x%"PRIx64" l1_off:0x%x, l2ptr:0x%"PRIx64" l2_off:0x%x max_l2_ste:%d"
 smmuv3_get_ste(uint64_t addr) "STE addr: 0x%"PRIx64
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 45033d26a1b..8cd2edc3412 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -115,6 +115,7 @@ OBJECT_DECLARE_TYPE(SMMUv3State, SMMUv3Class, ARM_SMMUV3)
 
 static inline SMMUv3RegBank *smmuv3_bank(SMMUv3State *s, SMMUSecSID sec_sid)
 {
+    g_assert(sec_sid < SMMU_SEC_SID_NUM);
     return &s->bank[sec_sid];
 }
 
-- 
2.34.1


