Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693CAC87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 15:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujgY4-0005MS-DF; Wed, 06 Aug 2025 11:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1ujfpX-00010C-S6; Wed, 06 Aug 2025 11:13:39 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1ujfpT-0006E3-BY; Wed, 06 Aug 2025 11:13:26 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwC3vtYOcZNoBCnWBA--.48S2;
 Wed, 06 Aug 2025 23:13:18 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwCXIQnfcJNos_oJAA--.14849S8;
 Wed, 06 Aug 2025 23:13:17 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC 05/11] hw/arm/smmuv3: Support secure event queue and error
 handling
Date: Wed,  6 Aug 2025 23:11:28 +0800
Message-Id: <20250806151134.365755-6-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCXIQnfcJNos_oJAA--.14849S8
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAOBWiSXH8HJgAAsy
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3Zw1DuFW3AryrGryDWF1DGFg_yoWkCryUpr
 WDKwnxKr45GF13Zrn5J34kG3W3W3yFqrZ0krWDCa4fJ3W5CryUXF1kCFyj9wnxGry7Aa1f
 JayI9F4fuw1xX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

Following the implementation of the secure command queue, this commit
introduces the infrastructure for reporting faults and events back to
secure software.

The secure event queue is now enabled, serving as the primary mechanism
for the SMMU to report translation faults and other architected events.

For more critical failures, such as an abort on an event queue write,
the SMMU_S_GERROR registers are also added. Finally, SMMU_S_IRQ_CTRL
is wired up to control interrupt notifications for both the event
queue and these global errors.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3-internal.h | 38 ++++++++++++++-----
 hw/arm/smmuv3.c          | 82 +++++++++++++++++++++++++---------------
 hw/arm/trace-events      |  2 +-
 3 files changed, 81 insertions(+), 41 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 5b2ca00832..720d21652c 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -234,6 +234,8 @@ REG32(S_STRTAB_BASE_CFG,    0x8088)
 REG64(S_CMDQ_BASE,          0x8090)
 REG32(S_CMDQ_PROD,          0x8098)
 REG32(S_CMDQ_CONS,          0x809c)
+    FIELD(S_CMDQ_CONS, ERR,      24, 7)
+
 REG64(S_EVENTQ_BASE,        0x80a0)
 REG32(S_EVENTQ_PROD,        0x80a8)
 REG32(S_EVENTQ_CONS,        0x80ac)
@@ -269,14 +271,22 @@ static inline uint32_t smmuv3_idreg(int regoffset)
     return smmuv3_ids[regoffset / 4];
 }
 
-static inline bool smmuv3_eventq_irq_enabled(SMMUv3State *s)
+static inline bool smmuv3_eventq_irq_enabled(SMMUv3State *s, bool is_secure)
 {
-    return FIELD_EX32(s->irq_ctrl, IRQ_CTRL, EVENTQ_IRQEN);
+    if (is_secure) {
+        return FIELD_EX32(s->secure_irq_ctrl, S_IRQ_CTRL, EVENTQ_IRQEN);
+    } else {
+        return FIELD_EX32(s->irq_ctrl, IRQ_CTRL, EVENTQ_IRQEN);
+    }
 }
 
-static inline bool smmuv3_gerror_irq_enabled(SMMUv3State *s)
+static inline bool smmuv3_gerror_irq_enabled(SMMUv3State *s, bool is_secure)
 {
-    return FIELD_EX32(s->irq_ctrl, IRQ_CTRL, GERROR_IRQEN);
+    if (is_secure) {
+        return FIELD_EX32(s->secure_irq_ctrl, S_IRQ_CTRL, GERROR_IRQEN);
+    } else {
+        return FIELD_EX32(s->irq_ctrl, IRQ_CTRL, GERROR_IRQEN);
+    }
 }
 
 /* Queue Handling */
@@ -328,14 +338,24 @@ static inline bool smmuv3_cmdq_enabled(SMMUv3State *s, bool is_secure)
     }
 }
 
-static inline bool smmuv3_eventq_enabled(SMMUv3State *s)
+static inline bool smmuv3_eventq_enabled(SMMUv3State *s, bool is_secure)
 {
-    return FIELD_EX32(s->cr[0], CR0, EVENTQEN);
+    if (is_secure) {
+        return FIELD_EX32(s->secure_cr[0], S_CR0, EVENTQEN);
+    } else {
+        return FIELD_EX32(s->cr[0], CR0, EVENTQEN);
+    }
 }
 
-static inline void smmu_write_cmdq_err(SMMUv3State *s, uint32_t err_type)
+static inline void smmu_write_cmdq_err(SMMUv3State *s, uint32_t err_type,
+                                       bool is_secure)
 {
-    s->cmdq.cons = FIELD_DP32(s->cmdq.cons, CMDQ_CONS, ERR, err_type);
+    if (is_secure) {
+        s->secure_cmdq.cons = FIELD_DP32(s->secure_cmdq.cons, S_CMDQ_CONS,
+                                         ERR, err_type);
+    } else {
+        s->cmdq.cons = FIELD_DP32(s->cmdq.cons, CMDQ_CONS, ERR, err_type);
+    }
 }
 
 /* Commands */
@@ -589,7 +609,7 @@ typedef struct SMMUEventInfo {
             (x)->word[6] = (uint32_t)(addr & 0xffffffff); \
     } while (0)
 
-void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *event);
+void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *event, bool is_secure);
 
 /* Configuration Data */
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 0590f0f482..1f05cc983b 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -48,14 +48,14 @@
  * @gerror_mask: mask of gerrors to toggle (relevant if @irq is GERROR)
  */
 static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
-                               uint32_t gerror_mask)
+                               uint32_t gerror_mask, bool is_secure)
 {
 
     bool pulse = false;
 
     switch (irq) {
     case SMMU_IRQ_EVTQ:
-        pulse = smmuv3_eventq_irq_enabled(s);
+        pulse = smmuv3_eventq_irq_enabled(s, is_secure);
         break;
     case SMMU_IRQ_PRIQ:
         qemu_log_mask(LOG_UNIMP, "PRI not yet supported\n");
@@ -65,17 +65,23 @@ static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
         break;
     case SMMU_IRQ_GERROR:
     {
-        uint32_t pending = s->gerror ^ s->gerrorn;
+        uint32_t pending = is_secure ? s->secure_gerror ^ s->secure_gerrorn :
+            s->gerror ^ s->gerrorn;
         uint32_t new_gerrors = ~pending & gerror_mask;
 
         if (!new_gerrors) {
             /* only toggle non pending errors */
             return;
         }
-        s->gerror ^= new_gerrors;
-        trace_smmuv3_write_gerror(new_gerrors, s->gerror);
+        if (is_secure) {
+            s->secure_gerror ^= new_gerrors;
+        } else {
+            s->gerror ^= new_gerrors;
+        }
+        trace_smmuv3_write_gerror(new_gerrors, is_secure ? s->secure_gerror :
+            s->gerror);
 
-        pulse = smmuv3_gerror_irq_enabled(s);
+        pulse = smmuv3_gerror_irq_enabled(s, is_secure);
         break;
     }
     }
@@ -85,24 +91,32 @@ static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
     }
 }
 
-static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
+static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn,
+                                 bool is_secure)
 {
-    uint32_t pending = s->gerror ^ s->gerrorn;
-    uint32_t toggled = s->gerrorn ^ new_gerrorn;
+    uint32_t pending = is_secure ? s->secure_gerror ^ s->secure_gerrorn :
+        s->gerror ^ s->gerrorn;
+    uint32_t toggled = is_secure ? s->secure_gerrorn ^ new_gerrorn :
+        s->gerrorn ^ new_gerrorn;
 
     if (toggled & ~pending) {
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "guest toggles non pending errors = 0x%x\n",
-                      toggled & ~pending);
+                      "guest toggles non pending errors = 0x%x is_secure=%d\n",
+                      toggled & ~pending, is_secure);
     }
 
     /*
      * We do not raise any error in case guest toggles bits corresponding
      * to not active IRQs (CONSTRAINED UNPREDICTABLE)
      */
-    s->gerrorn = new_gerrorn;
+    if (is_secure) {
+        s->secure_gerrorn = new_gerrorn;
+    } else {
+        s->gerrorn = new_gerrorn;
+    }
 
-    trace_smmuv3_write_gerrorn(toggled & pending, s->gerrorn);
+    trace_smmuv3_write_gerrorn(toggled & pending,
+                               is_secure ? s->secure_gerrorn : s->gerrorn);
 }
 
 static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd, bool is_secure)
@@ -125,18 +139,21 @@ static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd, bool is_secure)
     return ret;
 }
 
-static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in)
+static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in, bool is_secure)
 {
     dma_addr_t addr = Q_PROD_ENTRY(q);
     MemTxResult ret;
     Evt evt = *evt_in;
     int i;
+    MemTxAttrs attrs = is_secure ?
+        (MemTxAttrs) { .secure = 1 } :
+        (MemTxAttrs) { .unspecified = true };
 
     for (i = 0; i < ARRAY_SIZE(evt.word); i++) {
         cpu_to_le32s(&evt.word[i]);
     }
     ret = dma_memory_write(&address_space_memory, addr, &evt, sizeof(Evt),
-                           MEMTXATTRS_UNSPECIFIED);
+                           attrs);
     if (ret != MEMTX_OK) {
         return ret;
     }
@@ -145,12 +162,12 @@ static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in)
     return MEMTX_OK;
 }
 
-static MemTxResult smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
+static MemTxResult smmuv3_write_eventq(SMMUv3State *s, Evt *evt, bool is_secure)
 {
-    SMMUQueue *q = &s->eventq;
+    SMMUQueue *q = is_secure ? &s->secure_eventq : &s->eventq;
     MemTxResult r;
 
-    if (!smmuv3_eventq_enabled(s)) {
+    if (!smmuv3_eventq_enabled(s, is_secure)) {
         return MEMTX_ERROR;
     }
 
@@ -158,23 +175,23 @@ static MemTxResult smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
         return MEMTX_ERROR;
     }
 
-    r = queue_write(q, evt);
+    r = queue_write(q, evt, is_secure);
     if (r != MEMTX_OK) {
         return r;
     }
 
     if (!smmuv3_q_empty(q)) {
-        smmuv3_trigger_irq(s, SMMU_IRQ_EVTQ, 0);
+        smmuv3_trigger_irq(s, SMMU_IRQ_EVTQ, 0, is_secure);
     }
     return MEMTX_OK;
 }
 
-void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
+void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info, bool is_secure)
 {
     Evt evt = {};
     MemTxResult r;
 
-    if (!smmuv3_eventq_enabled(s)) {
+    if (!smmuv3_eventq_enabled(s, is_secure)) {
         return;
     }
 
@@ -252,10 +269,12 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
         g_assert_not_reached();
     }
 
-    trace_smmuv3_record_event(smmu_event_string(info->type), info->sid);
-    r = smmuv3_write_eventq(s, &evt);
+    trace_smmuv3_record_event(smmu_event_string(info->type),
+                              info->sid, is_secure);
+    r = smmuv3_write_eventq(s, &evt, is_secure);
     if (r != MEMTX_OK) {
-        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_EVENTQ_ABT_ERR_MASK);
+        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_EVENTQ_ABT_ERR_MASK,
+                           is_secure);
     }
     info->recorded = true;
 }
@@ -1148,7 +1167,7 @@ epilogue:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s translation failed for iova=0x%"PRIx64" (%s)\n",
                       mr->parent_obj.name, addr, smmu_event_string(event.type));
-        smmuv3_record_event(s, &event);
+        smmuv3_record_event(s, &event, false);
         break;
     }
 
@@ -1358,7 +1377,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, bool is_secure)
         switch (type) {
         case SMMU_CMD_SYNC:
             if (CMD_SYNC_CS(&cmd) & CMD_SYNC_SIG_IRQ) {
-                smmuv3_trigger_irq(s, SMMU_IRQ_CMD_SYNC, 0);
+                smmuv3_trigger_irq(s, SMMU_IRQ_CMD_SYNC, 0, is_secure);
             }
             break;
         case SMMU_CMD_PREFETCH_CONFIG:
@@ -1544,8 +1563,9 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, bool is_secure)
 
     if (cmd_error) {
         trace_smmuv3_cmdq_consume_error(smmu_cmd_string(type), cmd_error);
-        smmu_write_cmdq_err(s, cmd_error);
-        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_CMDQ_ERR_MASK);
+        smmu_write_cmdq_err(s, cmd_error, is_secure);
+        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR,
+                           R_GERROR_CMDQ_ERR_MASK, is_secure);
     }
 
     trace_smmuv3_cmdq_consume_out(Q_PROD(q), Q_CONS(q),
@@ -1731,7 +1751,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         s->irq_ctrl = data;
         return MEMTX_OK;
     case A_GERRORN:
-        smmuv3_write_gerrorn(s, data);
+        smmuv3_write_gerrorn(s, data, false);
         /*
          * By acknowledging the CMDQ_ERR, SW may notify cmds can
          * be processed again
@@ -1848,7 +1868,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         return MEMTX_OK;
     case A_S_GERRORN:
         SMMU_CHECK_SECURE_WRITE("S_GERRORN");
-        smmuv3_write_gerrorn(s, data);
+        smmuv3_write_gerrorn(s, data, true);
         smmuv3_cmdq_consume(s, true);
         return MEMTX_OK;
     case A_S_GERROR_IRQ_CFG0:
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 7d967226ff..7bb0bd0cc5 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -40,7 +40,7 @@ smmuv3_cmdq_opcode(const char *opcode) "<--- %s"
 smmuv3_cmdq_consume_out(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod:%d, cons:%d, prod_wrap:%d, cons_wrap:%d "
 smmuv3_cmdq_consume_error(const char *cmd_name, uint8_t cmd_error) "Error on %s command execution: %d"
 smmuv3_write_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
-smmuv3_record_event(const char *type, uint32_t sid) "%s sid=0x%x"
+smmuv3_record_event(const char *type, uint32_t sid, bool is_secure) "%s sid=0x%x is_secure=%d"
 smmuv3_find_ste(uint16_t sid, uint32_t features, uint16_t sid_split) "sid=0x%x features:0x%x, sid_split:0x%x"
 smmuv3_find_ste_2lvl(uint64_t strtab_base, uint64_t l1ptr, int l1_ste_offset, uint64_t l2ptr, int l2_ste_offset, int max_l2_ste) "strtab_base:0x%"PRIx64" l1ptr:0x%"PRIx64" l1_off:0x%x, l2ptr:0x%"PRIx64" l2_off:0x%x max_l2_ste:%d"
 smmuv3_get_ste(uint64_t addr) "STE addr: 0x%"PRIx64
-- 
2.34.1


