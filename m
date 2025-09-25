Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389F6CAC5B1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 16:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1oog-0006t2-2h; Thu, 25 Sep 2025 12:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v1onw-0006Kx-OT; Thu, 25 Sep 2025 12:26:50 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v1onk-0004kh-UA; Thu, 25 Sep 2025 12:26:47 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwD3jWE0bdVoljN6Bw--.50241S2;
 Fri, 26 Sep 2025 00:26:28 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDHLestbdVoW_MeAA--.7120S8;
 Fri, 26 Sep 2025 00:26:27 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>, pierrick.bouvier@linaro.org,
 philmd@linaro.org, jean-philippe@linaro.org, smostafa@google.com,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v2 05/14] hw/arm/smmuv3: Introduce banked registers for SMMUv3
 state
Date: Fri, 26 Sep 2025 00:26:09 +0800
Message-Id: <20250925162618.191242-6-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDHLestbdVoW_MeAA--.7120S8
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAEBWjUSMIHtwAAsG
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoWDCry3Wr1DZF1DGrWkWw45Jrb_yoWrCw48Co
 WfKF4qqw18Wr1kCFykuF1fJFsxAFZ5K39Iva1FqrsI9FZrJr4UJryIkr43Ca9Igr45XFWD
 Ar4xu3yxXF48AF18n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
 J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
 UUUUUUU==
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

Refactor the SMMUv3 state management by introducing a banked register
structure. This change is foundational for supporting multiple security
states (Non-secure, Secure, etc.) in a clean and scalable way.

A new structure, SMMUv3RegBank, is defined to hold the state for a
single security context. The main SMMUv3State now contains an array of
these structures. This avoids having separate fields for secure and
non-secure registers (e.g., s->cr and s->secure_cr).

The primary benefits of this refactoring are:
- Significant reduction in code duplication for MMIO handlers.
- Improved code readability and long-term maintainability.

Additionally, a new enum SMMUSecurityIndex is introduced to represent
the security state of a stream. This enum will be used as the index for
the register banks in subsequent patches.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3-internal.h     |  33 ++-
 hw/arm/smmuv3.c              | 484 ++++++++++++++++++++---------------
 hw/arm/trace-events          |   6 +-
 include/hw/arm/smmu-common.h |  14 +
 include/hw/arm/smmuv3.h      |  34 ++-
 5 files changed, 336 insertions(+), 235 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 3820157eaa..cf17c405de 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -250,9 +250,9 @@ REG64(S_EVENTQ_IRQ_CFG0,    0x80b0)
 REG32(S_EVENTQ_IRQ_CFG1,    0x80b8)
 REG32(S_EVENTQ_IRQ_CFG2,    0x80bc)
 
-static inline int smmu_enabled(SMMUv3State *s)
+static inline int smmu_enabled(SMMUv3State *s, SMMUSecurityIndex sec_idx)
 {
-    return FIELD_EX32(s->cr[0], CR0, SMMUEN);
+    return FIELD_EX32(s->bank[sec_idx].cr[0], CR0, SMMUEN);
 }
 
 /* Command Queue Entry */
@@ -278,14 +278,16 @@ static inline uint32_t smmuv3_idreg(int regoffset)
     return smmuv3_ids[regoffset / 4];
 }
 
-static inline bool smmuv3_eventq_irq_enabled(SMMUv3State *s)
+static inline bool smmuv3_eventq_irq_enabled(SMMUv3State *s,
+                                             SMMUSecurityIndex sec_idx)
 {
-    return FIELD_EX32(s->irq_ctrl, IRQ_CTRL, EVENTQ_IRQEN);
+    return FIELD_EX32(s->bank[sec_idx].irq_ctrl, IRQ_CTRL, EVENTQ_IRQEN);
 }
 
-static inline bool smmuv3_gerror_irq_enabled(SMMUv3State *s)
+static inline bool smmuv3_gerror_irq_enabled(SMMUv3State *s,
+                                             SMMUSecurityIndex sec_idx)
 {
-    return FIELD_EX32(s->irq_ctrl, IRQ_CTRL, GERROR_IRQEN);
+    return FIELD_EX32(s->bank[sec_idx].irq_ctrl, IRQ_CTRL, GERROR_IRQEN);
 }
 
 /* Queue Handling */
@@ -328,19 +330,23 @@ static inline void queue_cons_incr(SMMUQueue *q)
     q->cons = deposit32(q->cons, 0, q->log2size + 1, q->cons + 1);
 }
 
-static inline bool smmuv3_cmdq_enabled(SMMUv3State *s)
+static inline bool smmuv3_cmdq_enabled(SMMUv3State *s,
+                                       SMMUSecurityIndex sec_idx)
 {
-    return FIELD_EX32(s->cr[0], CR0, CMDQEN);
+    return FIELD_EX32(s->bank[sec_idx].cr[0], CR0, CMDQEN);
 }
 
-static inline bool smmuv3_eventq_enabled(SMMUv3State *s)
+static inline bool smmuv3_eventq_enabled(SMMUv3State *s,
+                                         SMMUSecurityIndex sec_idx)
 {
-    return FIELD_EX32(s->cr[0], CR0, EVENTQEN);
+    return FIELD_EX32(s->bank[sec_idx].cr[0], CR0, EVENTQEN);
 }
 
-static inline void smmu_write_cmdq_err(SMMUv3State *s, uint32_t err_type)
+static inline void smmu_write_cmdq_err(SMMUv3State *s, uint32_t err_type,
+                                       SMMUSecurityIndex sec_idx)
 {
-    s->cmdq.cons = FIELD_DP32(s->cmdq.cons, CMDQ_CONS, ERR, err_type);
+    s->bank[sec_idx].cmdq.cons = FIELD_DP32(s->bank[sec_idx].cmdq.cons,
+                                         CMDQ_CONS, ERR, err_type);
 }
 
 /* Commands */
@@ -511,6 +517,7 @@ typedef struct SMMUEventInfo {
     uint32_t sid;
     bool recorded;
     bool inval_ste_allowed;
+    SMMUSecurityIndex sec_idx;
     union {
         struct {
             uint32_t ssid;
@@ -594,7 +601,7 @@ typedef struct SMMUEventInfo {
             (x)->word[6] = (uint32_t)(addr & 0xffffffff); \
     } while (0)
 
-void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *event);
+void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info);
 
 /* Configuration Data */
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index bcf8af8dc7..2efa39b78c 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -48,14 +48,14 @@
  * @gerror_mask: mask of gerrors to toggle (relevant if @irq is GERROR)
  */
 static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
-                               uint32_t gerror_mask)
+                               uint32_t gerror_mask, SMMUSecurityIndex sec_idx)
 {
 
     bool pulse = false;
 
     switch (irq) {
     case SMMU_IRQ_EVTQ:
-        pulse = smmuv3_eventq_irq_enabled(s);
+        pulse = smmuv3_eventq_irq_enabled(s, sec_idx);
         break;
     case SMMU_IRQ_PRIQ:
         qemu_log_mask(LOG_UNIMP, "PRI not yet supported\n");
@@ -65,17 +65,17 @@ static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
         break;
     case SMMU_IRQ_GERROR:
     {
-        uint32_t pending = s->gerror ^ s->gerrorn;
+        uint32_t pending = s->bank[sec_idx].gerror ^ s->bank[sec_idx].gerrorn;
         uint32_t new_gerrors = ~pending & gerror_mask;
 
         if (!new_gerrors) {
             /* only toggle non pending errors */
             return;
         }
-        s->gerror ^= new_gerrors;
-        trace_smmuv3_write_gerror(new_gerrors, s->gerror);
+        s->bank[sec_idx].gerror ^= new_gerrors;
+        trace_smmuv3_write_gerror(new_gerrors, s->bank[sec_idx].gerror);
 
-        pulse = smmuv3_gerror_irq_enabled(s);
+        pulse = smmuv3_gerror_irq_enabled(s, sec_idx);
         break;
     }
     }
@@ -85,24 +85,25 @@ static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
     }
 }
 
-static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
+static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn,
+                                 SMMUSecurityIndex sec_idx)
 {
-    uint32_t pending = s->gerror ^ s->gerrorn;
-    uint32_t toggled = s->gerrorn ^ new_gerrorn;
+    uint32_t pending = s->bank[sec_idx].gerror ^ s->bank[sec_idx].gerrorn;
+    uint32_t toggled = s->bank[sec_idx].gerrorn ^ new_gerrorn;
 
     if (toggled & ~pending) {
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "guest toggles non pending errors = 0x%x\n",
-                      toggled & ~pending);
+                      "guest toggles non pending errors = 0x%x sec_idx=%d\n",
+                      toggled & ~pending, sec_idx);
     }
 
     /*
      * We do not raise any error in case guest toggles bits corresponding
      * to not active IRQs (CONSTRAINED UNPREDICTABLE)
      */
-    s->gerrorn = new_gerrorn;
+    s->bank[sec_idx].gerrorn = new_gerrorn;
 
-    trace_smmuv3_write_gerrorn(toggled & pending, s->gerrorn);
+    trace_smmuv3_write_gerrorn(toggled & pending, s->bank[sec_idx].gerrorn);
 }
 
 static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd)
@@ -142,12 +143,13 @@ static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in)
     return MEMTX_OK;
 }
 
-static MemTxResult smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
+static MemTxResult smmuv3_write_eventq(SMMUv3State *s, Evt *evt,
+                                       SMMUSecurityIndex sec_idx)
 {
-    SMMUQueue *q = &s->eventq;
+    SMMUQueue *q = &s->bank[sec_idx].eventq;
     MemTxResult r;
 
-    if (!smmuv3_eventq_enabled(s)) {
+    if (!smmuv3_eventq_enabled(s, sec_idx)) {
         return MEMTX_ERROR;
     }
 
@@ -161,7 +163,7 @@ static MemTxResult smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
     }
 
     if (!smmuv3_q_empty(q)) {
-        smmuv3_trigger_irq(s, SMMU_IRQ_EVTQ, 0);
+        smmuv3_trigger_irq(s, SMMU_IRQ_EVTQ, 0, sec_idx);
     }
     return MEMTX_OK;
 }
@@ -171,7 +173,7 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
     Evt evt = {};
     MemTxResult r;
 
-    if (!smmuv3_eventq_enabled(s)) {
+    if (!smmuv3_eventq_enabled(s, info->sec_idx)) {
         return;
     }
 
@@ -249,74 +251,104 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
         g_assert_not_reached();
     }
 
-    trace_smmuv3_record_event(smmu_event_string(info->type), info->sid);
-    r = smmuv3_write_eventq(s, &evt);
+    trace_smmuv3_record_event(smmu_event_string(info->type),
+                              info->sid, info->sec_idx);
+    r = smmuv3_write_eventq(s, &evt, info->sec_idx);
     if (r != MEMTX_OK) {
-        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_EVENTQ_ABT_ERR_MASK);
+        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_EVENTQ_ABT_ERR_MASK,
+                           info->sec_idx);
     }
     info->recorded = true;
 }
 
 static void smmuv3_init_regs(SMMUv3State *s)
 {
+    /* Initialize Non-secure bank (SMMU_SEC_IDX_NS) */
     /* Based on sys property, the stages supported in smmu will be advertised.*/
     if (s->stage && !strcmp("2", s->stage)) {
-        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S2P, 1);
+        s->bank[SMMU_SEC_IDX_NS].idr[0] = FIELD_DP32(
+            s->bank[SMMU_SEC_IDX_NS].idr[0], IDR0, S2P, 1);
     } else if (s->stage && !strcmp("nested", s->stage)) {
-        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S1P, 1);
-        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S2P, 1);
+        s->bank[SMMU_SEC_IDX_NS].idr[0] = FIELD_DP32(
+            s->bank[SMMU_SEC_IDX_NS].idr[0], IDR0, S1P, 1);
+        s->bank[SMMU_SEC_IDX_NS].idr[0] = FIELD_DP32(
+            s->bank[SMMU_SEC_IDX_NS].idr[0], IDR0, S2P, 1);
     } else {
-        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S1P, 1);
-    }
-
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, TTF, 2); /* AArch64 PTW only */
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, COHACC, 1); /* IO coherent */
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ASID16, 1); /* 16-bit ASID */
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, VMID16, 1); /* 16-bit VMID */
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, TTENDIAN, 2); /* little endian */
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, STALL_MODEL, 1); /* No stall */
+        s->bank[SMMU_SEC_IDX_NS].idr[0] = FIELD_DP32(
+            s->bank[SMMU_SEC_IDX_NS].idr[0], IDR0, S1P, 1);
+    }
+
+    s->bank[SMMU_SEC_IDX_NS].idr[0] = FIELD_DP32(
+        s->bank[SMMU_SEC_IDX_NS].idr[0], IDR0, TTF, 2); /* AArch64 PTW only */
+    s->bank[SMMU_SEC_IDX_NS].idr[0] = FIELD_DP32(
+        s->bank[SMMU_SEC_IDX_NS].idr[0], IDR0, COHACC, 1); /* IO coherent */
+    s->bank[SMMU_SEC_IDX_NS].idr[0] = FIELD_DP32(
+        s->bank[SMMU_SEC_IDX_NS].idr[0], IDR0, ASID16, 1); /* 16-bit ASID */
+    s->bank[SMMU_SEC_IDX_NS].idr[0] = FIELD_DP32(
+        s->bank[SMMU_SEC_IDX_NS].idr[0], IDR0, VMID16, 1); /* 16-bit VMID */
+    s->bank[SMMU_SEC_IDX_NS].idr[0] = FIELD_DP32(
+        s->bank[SMMU_SEC_IDX_NS].idr[0], IDR0, TTENDIAN, 2); /* little endian */
+    s->bank[SMMU_SEC_IDX_NS].idr[0] = FIELD_DP32(
+        s->bank[SMMU_SEC_IDX_NS].idr[0], IDR0, STALL_MODEL, 1); /* No stall */
     /* terminated transaction will always be aborted/error returned */
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, TERM_MODEL, 1);
+    s->bank[SMMU_SEC_IDX_NS].idr[0] = FIELD_DP32(
+        s->bank[SMMU_SEC_IDX_NS].idr[0], IDR0, TERM_MODEL, 1);
     /* 2-level stream table supported */
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, STLEVEL, 1);
-
-    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SIDSIZE, SMMU_IDR1_SIDSIZE);
-    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, EVENTQS, SMMU_EVENTQS);
-    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, CMDQS,   SMMU_CMDQS);
-
-    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, HAD, 1);
-    if (FIELD_EX32(s->idr[0], IDR0, S2P)) {
+    s->bank[SMMU_SEC_IDX_NS].idr[0] = FIELD_DP32(
+        s->bank[SMMU_SEC_IDX_NS].idr[0], IDR0, STLEVEL, 1);
+
+    s->bank[SMMU_SEC_IDX_NS].idr[1] = FIELD_DP32(
+        s->bank[SMMU_SEC_IDX_NS].idr[1], IDR1, SIDSIZE, SMMU_IDR1_SIDSIZE);
+    s->bank[SMMU_SEC_IDX_NS].idr[1] = FIELD_DP32(
+        s->bank[SMMU_SEC_IDX_NS].idr[1], IDR1, EVENTQS, SMMU_EVENTQS);
+    s->bank[SMMU_SEC_IDX_NS].idr[1] = FIELD_DP32(
+        s->bank[SMMU_SEC_IDX_NS].idr[1], IDR1, CMDQS, SMMU_CMDQS);
+
+    s->bank[SMMU_SEC_IDX_NS].idr[3] = FIELD_DP32(
+        s->bank[SMMU_SEC_IDX_NS].idr[3], IDR3, HAD, 1);
+    if (FIELD_EX32(s->bank[SMMU_SEC_IDX_NS].idr[0], IDR0, S2P)) {
         /* XNX is a stage-2-specific feature */
-        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, XNX, 1);
+        s->bank[SMMU_SEC_IDX_NS].idr[3] = FIELD_DP32(
+            s->bank[SMMU_SEC_IDX_NS].idr[3], IDR3, XNX, 1);
     }
-    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
-    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);
+    s->bank[SMMU_SEC_IDX_NS].idr[3] = FIELD_DP32(
+        s->bank[SMMU_SEC_IDX_NS].idr[3], IDR3, RIL, 1);
+    s->bank[SMMU_SEC_IDX_NS].idr[3] = FIELD_DP32(
+        s->bank[SMMU_SEC_IDX_NS].idr[3], IDR3, BBML, 2);
 
-    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS); /* 44 bits */
+    /* 44 bits */
+    s->bank[SMMU_SEC_IDX_NS].idr[5] = FIELD_DP32(
+        s->bank[SMMU_SEC_IDX_NS].idr[5], IDR5, OAS, SMMU_IDR5_OAS);
     /* 4K, 16K and 64K granule support */
-    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, 1);
-    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
-    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, 1);
-
-    s->cmdq.base = deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
-    s->cmdq.prod = 0;
-    s->cmdq.cons = 0;
-    s->cmdq.entry_size = sizeof(struct Cmd);
-    s->eventq.base = deposit64(s->eventq.base, 0, 5, SMMU_EVENTQS);
-    s->eventq.prod = 0;
-    s->eventq.cons = 0;
-    s->eventq.entry_size = sizeof(struct Evt);
-
-    s->features = 0;
-    s->sid_split = 0;
+    s->bank[SMMU_SEC_IDX_NS].idr[5] = FIELD_DP32(
+        s->bank[SMMU_SEC_IDX_NS].idr[5], IDR5, GRAN4K, 1);
+    s->bank[SMMU_SEC_IDX_NS].idr[5] = FIELD_DP32(
+        s->bank[SMMU_SEC_IDX_NS].idr[5], IDR5, GRAN16K, 1);
+    s->bank[SMMU_SEC_IDX_NS].idr[5] = FIELD_DP32(
+        s->bank[SMMU_SEC_IDX_NS].idr[5], IDR5, GRAN64K, 1);
+
+    /* Initialize Non-secure command and event queues */
+    s->bank[SMMU_SEC_IDX_NS].cmdq.base =
+        deposit64(s->bank[SMMU_SEC_IDX_NS].cmdq.base, 0, 5, SMMU_CMDQS);
+    s->bank[SMMU_SEC_IDX_NS].cmdq.prod = 0;
+    s->bank[SMMU_SEC_IDX_NS].cmdq.cons = 0;
+    s->bank[SMMU_SEC_IDX_NS].cmdq.entry_size = sizeof(struct Cmd);
+    s->bank[SMMU_SEC_IDX_NS].eventq.base =
+        deposit64(s->bank[SMMU_SEC_IDX_NS].eventq.base, 0, 5, SMMU_EVENTQS);
+    s->bank[SMMU_SEC_IDX_NS].eventq.prod = 0;
+    s->bank[SMMU_SEC_IDX_NS].eventq.cons = 0;
+    s->bank[SMMU_SEC_IDX_NS].eventq.entry_size = sizeof(struct Evt);
+    s->bank[SMMU_SEC_IDX_NS].features = 0;
+    s->bank[SMMU_SEC_IDX_NS].sid_split = 0;
     s->aidr = 0x1;
-    s->cr[0] = 0;
-    s->cr0ack = 0;
-    s->irq_ctrl = 0;
-    s->gerror = 0;
-    s->gerrorn = 0;
+    s->bank[SMMU_SEC_IDX_NS].cr[0] = 0;
+    s->bank[SMMU_SEC_IDX_NS].cr0ack = 0;
+    s->bank[SMMU_SEC_IDX_NS].irq_ctrl = 0;
+    s->bank[SMMU_SEC_IDX_NS].gerror = 0;
+    s->bank[SMMU_SEC_IDX_NS].gerrorn = 0;
     s->statusr = 0;
-    s->gbpa = SMMU_GBPA_RESET_VAL;
+    s->bank[SMMU_SEC_IDX_NS].gbpa = SMMU_GBPA_RESET_VAL;
+
 }
 
 static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
@@ -430,7 +462,7 @@ static bool s2_pgtable_config_valid(uint8_t sl0, uint8_t t0sz, uint8_t gran)
 static int decode_ste_s2_cfg(SMMUv3State *s, SMMUTransCfg *cfg,
                              STE *ste)
 {
-    uint8_t oas = FIELD_EX32(s->idr[5], IDR5, OAS);
+    uint8_t oas = FIELD_EX32(s->bank[SMMU_SEC_IDX_NS].idr[5], IDR5, OAS);
 
     if (STE_S2AA64(ste) == 0x0) {
         qemu_log_mask(LOG_UNIMP,
@@ -548,7 +580,7 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
                       STE *ste, SMMUEventInfo *event)
 {
     uint32_t config;
-    uint8_t oas = FIELD_EX32(s->idr[5], IDR5, OAS);
+    uint8_t oas = FIELD_EX32(s->bank[SMMU_SEC_IDX_NS].idr[5], IDR5, OAS);
     int ret;
 
     if (!STE_VALID(ste)) {
@@ -625,20 +657,25 @@ bad_ste:
  * @sid: stream ID
  * @ste: returned stream table entry
  * @event: handle to an event info
+ * @cfg: translation configuration
  *
  * Supports linear and 2-level stream table
  * Return 0 on success, -EINVAL otherwise
  */
 static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
-                         SMMUEventInfo *event)
+                         SMMUEventInfo *event, SMMUTransCfg *cfg)
 {
-    dma_addr_t addr, strtab_base;
+    dma_addr_t addr;
     uint32_t log2size;
     int strtab_size_shift;
     int ret;
+    uint32_t features = s->bank[cfg->sec_idx].features;
+    dma_addr_t strtab_base = s->bank[cfg->sec_idx].strtab_base;
+    uint8_t sid_split = s->bank[cfg->sec_idx].sid_split;
 
-    trace_smmuv3_find_ste(sid, s->features, s->sid_split);
-    log2size = FIELD_EX32(s->strtab_base_cfg, STRTAB_BASE_CFG, LOG2SIZE);
+    trace_smmuv3_find_ste(sid, features, sid_split, cfg->sec_idx);
+    log2size = FIELD_EX32(s->bank[cfg->sec_idx].strtab_base_cfg,
+                          STRTAB_BASE_CFG, LOG2SIZE);
     /*
      * Check SID range against both guest-configured and implementation limits
      */
@@ -646,7 +683,7 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
         event->type = SMMU_EVT_C_BAD_STREAMID;
         return -EINVAL;
     }
-    if (s->features & SMMU_FEATURE_2LVL_STE) {
+    if (features & SMMU_FEATURE_2LVL_STE) {
         int l1_ste_offset, l2_ste_offset, max_l2_ste, span, i;
         dma_addr_t l1ptr, l2ptr;
         STEDesc l1std;
@@ -655,11 +692,11 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
          * Align strtab base address to table size. For this purpose, assume it
          * is not bounded by SMMU_IDR1_SIDSIZE.
          */
-        strtab_size_shift = MAX(5, (int)log2size - s->sid_split - 1 + 3);
-        strtab_base = s->strtab_base & SMMU_BASE_ADDR_MASK &
+        strtab_size_shift = MAX(5, (int)log2size - sid_split - 1 + 3);
+        strtab_base = strtab_base & SMMU_BASE_ADDR_MASK &
                       ~MAKE_64BIT_MASK(0, strtab_size_shift);
-        l1_ste_offset = sid >> s->sid_split;
-        l2_ste_offset = sid & ((1 << s->sid_split) - 1);
+        l1_ste_offset = sid >> sid_split;
+        l2_ste_offset = sid & ((1 << sid_split) - 1);
         l1ptr = (dma_addr_t)(strtab_base + l1_ste_offset * sizeof(l1std));
         /* TODO: guarantee 64-bit single-copy atomicity */
         ret = dma_memory_read(&address_space_memory, l1ptr, &l1std,
@@ -688,7 +725,7 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
         }
         max_l2_ste = (1 << span) - 1;
         l2ptr = l1std_l2ptr(&l1std);
-        trace_smmuv3_find_ste_2lvl(s->strtab_base, l1ptr, l1_ste_offset,
+        trace_smmuv3_find_ste_2lvl(strtab_base, l1ptr, l1_ste_offset,
                                    l2ptr, l2_ste_offset, max_l2_ste);
         if (l2_ste_offset > max_l2_ste) {
             qemu_log_mask(LOG_GUEST_ERROR,
@@ -700,7 +737,7 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
         addr = l2ptr + l2_ste_offset * sizeof(*ste);
     } else {
         strtab_size_shift = log2size + 5;
-        strtab_base = s->strtab_base & SMMU_BASE_ADDR_MASK &
+        strtab_base = strtab_base & SMMU_BASE_ADDR_MASK &
                       ~MAKE_64BIT_MASK(0, strtab_size_shift);
         addr = strtab_base + sid * sizeof(*ste);
     }
@@ -719,7 +756,7 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
     int i;
     SMMUTranslationStatus status;
     SMMUTLBEntry *entry;
-    uint8_t oas = FIELD_EX32(s->idr[5], IDR5, OAS);
+    uint8_t oas = FIELD_EX32(s->bank[SMMU_SEC_IDX_NS].idr[5], IDR5, OAS);
 
     if (!CD_VALID(cd) || !CD_AARCH64(cd)) {
         goto bad_cd;
@@ -834,7 +871,7 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
     /* ASID defaults to -1 (if s1 is not supported). */
     cfg->asid = -1;
 
-    ret = smmu_find_ste(s, sid, &ste, event);
+    ret = smmu_find_ste(s, sid, &ste, event, cfg);
     if (ret) {
         return ret;
     }
@@ -964,6 +1001,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
          *  - s2 translation => CLASS_IN (input to function)
          */
         class = ptw_info.is_ipa_descriptor ? SMMU_CLASS_TT : class;
+        event->sec_idx = cfg->sec_idx;
         switch (ptw_info.type) {
         case SMMU_PTW_ERR_WALK_EABT:
             event->type = SMMU_EVT_F_WALK_EABT;
@@ -1046,6 +1084,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
                            .inval_ste_allowed = false};
     SMMUTranslationStatus status;
     SMMUTransCfg *cfg = NULL;
+    SMMUSecurityIndex sec_idx = SMMU_SEC_IDX_NS;
     IOMMUTLBEntry entry = {
         .target_as = &address_space_memory,
         .iova = addr,
@@ -1057,12 +1096,9 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
 
     qemu_mutex_lock(&s->mutex);
 
-    if (!smmu_enabled(s)) {
-        if (FIELD_EX32(s->gbpa, GBPA, ABORT)) {
-            status = SMMU_TRANS_ABORT;
-        } else {
-            status = SMMU_TRANS_DISABLE;
-        }
+    if (!smmu_enabled(s, sec_idx)) {
+        bool abort_flag = FIELD_EX32(s->bank[sec_idx].gbpa, GBPA, ABORT);
+        status = abort_flag ? SMMU_TRANS_ABORT : SMMU_TRANS_DISABLE;
         goto epilogue;
     }
 
@@ -1278,14 +1314,14 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
     }
 }
 
-static int smmuv3_cmdq_consume(SMMUv3State *s)
+static int smmuv3_cmdq_consume(SMMUv3State *s, SMMUSecurityIndex sec_idx)
 {
     SMMUState *bs = ARM_SMMU(s);
     SMMUCmdError cmd_error = SMMU_CERROR_NONE;
-    SMMUQueue *q = &s->cmdq;
+    SMMUQueue *q = &s->bank[sec_idx].cmdq;
     SMMUCommandType type = 0;
 
-    if (!smmuv3_cmdq_enabled(s)) {
+    if (!smmuv3_cmdq_enabled(s, sec_idx)) {
         return 0;
     }
     /*
@@ -1296,11 +1332,12 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
      */
 
     while (!smmuv3_q_empty(q)) {
-        uint32_t pending = s->gerror ^ s->gerrorn;
+        uint32_t pending = s->bank[sec_idx].gerror ^ s->bank[sec_idx].gerrorn;
         Cmd cmd;
 
         trace_smmuv3_cmdq_consume(Q_PROD(q), Q_CONS(q),
-                                  Q_PROD_WRAP(q), Q_CONS_WRAP(q));
+                                  Q_PROD_WRAP(q), Q_CONS_WRAP(q),
+                                  sec_idx);
 
         if (FIELD_EX32(pending, GERROR, CMDQ_ERR)) {
             break;
@@ -1319,7 +1356,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
         switch (type) {
         case SMMU_CMD_SYNC:
             if (CMD_SYNC_CS(&cmd) & CMD_SYNC_SIG_IRQ) {
-                smmuv3_trigger_irq(s, SMMU_IRQ_CMD_SYNC, 0);
+                smmuv3_trigger_irq(s, SMMU_IRQ_CMD_SYNC, 0, sec_idx);
             }
             break;
         case SMMU_CMD_PREFETCH_CONFIG:
@@ -1498,8 +1535,9 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
 
     if (cmd_error) {
         trace_smmuv3_cmdq_consume_error(smmu_cmd_string(type), cmd_error);
-        smmu_write_cmdq_err(s, cmd_error);
-        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_CMDQ_ERR_MASK);
+        smmu_write_cmdq_err(s, cmd_error, sec_idx);
+        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR,
+                           R_GERROR_CMDQ_ERR_MASK, sec_idx);
     }
 
     trace_smmuv3_cmdq_consume_out(Q_PROD(q), Q_CONS(q),
@@ -1509,31 +1547,33 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
 }
 
 static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
-                               uint64_t data, MemTxAttrs attrs)
+                               uint64_t data, MemTxAttrs attrs,
+                               SMMUSecurityIndex reg_sec_idx)
 {
-    switch (offset) {
-    case A_GERROR_IRQ_CFG0:
-        s->gerror_irq_cfg0 = data;
-        return MEMTX_OK;
+    uint32_t reg_offset = offset & 0xfff;
+    switch (reg_offset) {
     case A_STRTAB_BASE:
-        s->strtab_base = data;
+        /* Clear reserved bits according to spec */
+        s->bank[reg_sec_idx].strtab_base = data & SMMU_STRTAB_BASE_RESERVED;
         return MEMTX_OK;
     case A_CMDQ_BASE:
-        s->cmdq.base = data;
-        s->cmdq.log2size = extract64(s->cmdq.base, 0, 5);
-        if (s->cmdq.log2size > SMMU_CMDQS) {
-            s->cmdq.log2size = SMMU_CMDQS;
+        s->bank[reg_sec_idx].cmdq.base = data;
+        s->bank[reg_sec_idx].cmdq.log2size = extract64(
+            s->bank[reg_sec_idx].cmdq.base, 0, 5);
+        if (s->bank[reg_sec_idx].cmdq.log2size > SMMU_CMDQS) {
+            s->bank[reg_sec_idx].cmdq.log2size = SMMU_CMDQS;
         }
         return MEMTX_OK;
     case A_EVENTQ_BASE:
-        s->eventq.base = data;
-        s->eventq.log2size = extract64(s->eventq.base, 0, 5);
-        if (s->eventq.log2size > SMMU_EVENTQS) {
-            s->eventq.log2size = SMMU_EVENTQS;
+        s->bank[reg_sec_idx].eventq.base = data;
+        s->bank[reg_sec_idx].eventq.log2size = extract64(
+            s->bank[reg_sec_idx].eventq.base, 0, 5);
+        if (s->bank[reg_sec_idx].eventq.log2size > SMMU_EVENTQS) {
+            s->bank[reg_sec_idx].eventq.log2size = SMMU_EVENTQS;
         }
         return MEMTX_OK;
     case A_EVENTQ_IRQ_CFG0:
-        s->eventq_irq_cfg0 = data;
+        s->bank[reg_sec_idx].eventq_irq_cfg0 = data;
         return MEMTX_OK;
     default:
         qemu_log_mask(LOG_UNIMP,
@@ -1544,43 +1584,47 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
 }
 
 static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
-                               uint64_t data, MemTxAttrs attrs)
+                               uint64_t data, MemTxAttrs attrs,
+                               SMMUSecurityIndex reg_sec_idx)
 {
-    switch (offset) {
+    uint32_t reg_offset = offset & 0xfff;
+    switch (reg_offset) {
     case A_CR0:
-        s->cr[0] = data;
-        s->cr0ack = data & ~SMMU_CR0_RESERVED;
+        s->bank[reg_sec_idx].cr[0] = data;
+        s->bank[reg_sec_idx].cr0ack = data;
         /* in case the command queue has been enabled */
-        smmuv3_cmdq_consume(s);
+        smmuv3_cmdq_consume(s, reg_sec_idx);
         return MEMTX_OK;
     case A_CR1:
-        s->cr[1] = data;
+        s->bank[reg_sec_idx].cr[1] = data;
         return MEMTX_OK;
     case A_CR2:
-        s->cr[2] = data;
+        s->bank[reg_sec_idx].cr[2] = data;
         return MEMTX_OK;
     case A_IRQ_CTRL:
-        s->irq_ctrl = data;
+        s->bank[reg_sec_idx].irq_ctrl = data;
         return MEMTX_OK;
     case A_GERRORN:
-        smmuv3_write_gerrorn(s, data);
+        smmuv3_write_gerrorn(s, data, reg_sec_idx);
         /*
          * By acknowledging the CMDQ_ERR, SW may notify cmds can
          * be processed again
          */
-        smmuv3_cmdq_consume(s);
+        smmuv3_cmdq_consume(s, reg_sec_idx);
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG0: /* 64b */
-        s->gerror_irq_cfg0 = deposit64(s->gerror_irq_cfg0, 0, 32, data);
+        s->bank[reg_sec_idx].gerror_irq_cfg0 =
+            deposit64(s->bank[reg_sec_idx].gerror_irq_cfg0, 0, 32, data);
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG0 + 4:
-        s->gerror_irq_cfg0 = deposit64(s->gerror_irq_cfg0, 32, 32, data);
+        s->bank[reg_sec_idx].gerror_irq_cfg0 =
+            deposit64(s->bank[reg_sec_idx].gerror_irq_cfg0, 32, 32, data);
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG1:
-        s->gerror_irq_cfg1 = data;
+        s->bank[reg_sec_idx].gerror_irq_cfg1 = data;
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG2:
-        s->gerror_irq_cfg2 = data;
+        s->bank[reg_sec_idx].gerror_irq_cfg2 = data;
         return MEMTX_OK;
     case A_GBPA:
         /*
@@ -1589,66 +1633,81 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
          */
         if (data & R_GBPA_UPDATE_MASK) {
             /* Ignore update bit as write is synchronous. */
-            s->gbpa = data & ~R_GBPA_UPDATE_MASK;
+            s->bank[reg_sec_idx].gbpa = data & ~R_GBPA_UPDATE_MASK;
         }
         return MEMTX_OK;
     case A_STRTAB_BASE: /* 64b */
-        s->strtab_base = deposit64(s->strtab_base, 0, 32, data);
+        s->bank[reg_sec_idx].strtab_base =
+            deposit64(s->bank[reg_sec_idx].strtab_base, 0, 32, data);
         return MEMTX_OK;
     case A_STRTAB_BASE + 4:
-        s->strtab_base = deposit64(s->strtab_base, 32, 32, data);
+        s->bank[reg_sec_idx].strtab_base =
+            deposit64(s->bank[reg_sec_idx].strtab_base, 32, 32, data);
         return MEMTX_OK;
     case A_STRTAB_BASE_CFG:
-        s->strtab_base_cfg = data;
+        s->bank[reg_sec_idx].strtab_base_cfg = data;
         if (FIELD_EX32(data, STRTAB_BASE_CFG, FMT) == 1) {
-            s->sid_split = FIELD_EX32(data, STRTAB_BASE_CFG, SPLIT);
-            s->features |= SMMU_FEATURE_2LVL_STE;
+            s->bank[reg_sec_idx].sid_split =
+                FIELD_EX32(data, STRTAB_BASE_CFG, SPLIT);
+            s->bank[reg_sec_idx].features |= SMMU_FEATURE_2LVL_STE;
         }
         return MEMTX_OK;
     case A_CMDQ_BASE: /* 64b */
-        s->cmdq.base = deposit64(s->cmdq.base, 0, 32, data);
-        s->cmdq.log2size = extract64(s->cmdq.base, 0, 5);
-        if (s->cmdq.log2size > SMMU_CMDQS) {
-            s->cmdq.log2size = SMMU_CMDQS;
+        s->bank[reg_sec_idx].cmdq.base =
+            deposit64(s->bank[reg_sec_idx].cmdq.base, 0, 32, data);
+        s->bank[reg_sec_idx].cmdq.log2size =
+            extract64(s->bank[reg_sec_idx].cmdq.base, 0, 5);
+        if (s->bank[reg_sec_idx].cmdq.log2size > SMMU_CMDQS) {
+            s->bank[reg_sec_idx].cmdq.log2size = SMMU_CMDQS;
         }
         return MEMTX_OK;
     case A_CMDQ_BASE + 4: /* 64b */
-        s->cmdq.base = deposit64(s->cmdq.base, 32, 32, data);
+        s->bank[reg_sec_idx].cmdq.base =
+            deposit64(s->bank[reg_sec_idx].cmdq.base, 32, 32, data);
+        return MEMTX_OK;
         return MEMTX_OK;
     case A_CMDQ_PROD:
-        s->cmdq.prod = data;
-        smmuv3_cmdq_consume(s);
+        s->bank[reg_sec_idx].cmdq.prod = data;
+        smmuv3_cmdq_consume(s, reg_sec_idx);
         return MEMTX_OK;
     case A_CMDQ_CONS:
-        s->cmdq.cons = data;
+        s->bank[reg_sec_idx].cmdq.cons = data;
         return MEMTX_OK;
     case A_EVENTQ_BASE: /* 64b */
-        s->eventq.base = deposit64(s->eventq.base, 0, 32, data);
-        s->eventq.log2size = extract64(s->eventq.base, 0, 5);
-        if (s->eventq.log2size > SMMU_EVENTQS) {
-            s->eventq.log2size = SMMU_EVENTQS;
+        s->bank[reg_sec_idx].eventq.base =
+            deposit64(s->bank[reg_sec_idx].eventq.base, 0, 32, data);
+        s->bank[reg_sec_idx].eventq.log2size =
+            extract64(s->bank[reg_sec_idx].eventq.base, 0, 5);
+        if (s->bank[reg_sec_idx].eventq.log2size > SMMU_EVENTQS) {
+            s->bank[reg_sec_idx].eventq.log2size = SMMU_EVENTQS;
         }
+        s->bank[reg_sec_idx].eventq.cons = data;
         return MEMTX_OK;
     case A_EVENTQ_BASE + 4:
-        s->eventq.base = deposit64(s->eventq.base, 32, 32, data);
+        s->bank[reg_sec_idx].eventq.base =
+            deposit64(s->bank[reg_sec_idx].eventq.base, 32, 32, data);
+        return MEMTX_OK;
         return MEMTX_OK;
     case A_EVENTQ_PROD:
-        s->eventq.prod = data;
+        s->bank[reg_sec_idx].eventq.prod = data;
         return MEMTX_OK;
     case A_EVENTQ_CONS:
-        s->eventq.cons = data;
+        s->bank[reg_sec_idx].eventq.cons = data;
         return MEMTX_OK;
     case A_EVENTQ_IRQ_CFG0: /* 64b */
-        s->eventq_irq_cfg0 = deposit64(s->eventq_irq_cfg0, 0, 32, data);
+        s->bank[reg_sec_idx].eventq_irq_cfg0 =
+            deposit64(s->bank[reg_sec_idx].eventq_irq_cfg0, 0, 32, data);
         return MEMTX_OK;
     case A_EVENTQ_IRQ_CFG0 + 4:
-        s->eventq_irq_cfg0 = deposit64(s->eventq_irq_cfg0, 32, 32, data);
+        s->bank[reg_sec_idx].eventq_irq_cfg0 =
+            deposit64(s->bank[reg_sec_idx].eventq_irq_cfg0, 32, 32, data);
+        return MEMTX_OK;
         return MEMTX_OK;
     case A_EVENTQ_IRQ_CFG1:
-        s->eventq_irq_cfg1 = data;
+        s->bank[reg_sec_idx].eventq_irq_cfg1 = data;
         return MEMTX_OK;
     case A_EVENTQ_IRQ_CFG2:
-        s->eventq_irq_cfg2 = data;
+        s->bank[reg_sec_idx].eventq_irq_cfg2 = data;
         return MEMTX_OK;
     default:
         qemu_log_mask(LOG_UNIMP,
@@ -1667,13 +1726,14 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
 
     /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
     offset &= ~0x10000;
+    SMMUSecurityIndex reg_sec_idx = SMMU_SEC_IDX_NS;
 
     switch (size) {
     case 8:
-        r = smmu_writell(s, offset, data, attrs);
+        r = smmu_writell(s, offset, data, attrs, reg_sec_idx);
         break;
     case 4:
-        r = smmu_writel(s, offset, data, attrs);
+        r = smmu_writel(s, offset, data, attrs, reg_sec_idx);
         break;
     default:
         r = MEMTX_ERROR;
@@ -1685,20 +1745,24 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
 }
 
 static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
-                               uint64_t *data, MemTxAttrs attrs)
+                               uint64_t *data, MemTxAttrs attrs,
+                               SMMUSecurityIndex reg_sec_idx)
 {
-    switch (offset) {
+    uint32_t reg_offset = offset & 0xfff;
+    switch (reg_offset) {
     case A_GERROR_IRQ_CFG0:
-        *data = s->gerror_irq_cfg0;
+        *data = s->bank[reg_sec_idx].gerror_irq_cfg0;
         return MEMTX_OK;
     case A_STRTAB_BASE:
-        *data = s->strtab_base;
+        *data = s->bank[reg_sec_idx].strtab_base;
         return MEMTX_OK;
     case A_CMDQ_BASE:
-        *data = s->cmdq.base;
+        *data = s->bank[reg_sec_idx].cmdq.base;
         return MEMTX_OK;
     case A_EVENTQ_BASE:
-        *data = s->eventq.base;
+        *data = s->bank[reg_sec_idx].eventq.base;
+        return MEMTX_OK;
+        *data = s->bank[reg_sec_idx].eventq_irq_cfg0;
         return MEMTX_OK;
     default:
         *data = 0;
@@ -1710,14 +1774,16 @@ static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
 }
 
 static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
-                              uint64_t *data, MemTxAttrs attrs)
+                              uint64_t *data, MemTxAttrs attrs,
+                              SMMUSecurityIndex reg_sec_idx)
 {
-    switch (offset) {
+    uint32_t reg_offset = offset & 0xfff;
+    switch (reg_offset) {
     case A_IDREGS ... A_IDREGS + 0x2f:
         *data = smmuv3_idreg(offset - A_IDREGS);
         return MEMTX_OK;
     case A_IDR0 ... A_IDR5:
-        *data = s->idr[(offset - A_IDR0) / 4];
+        *data = s->bank[reg_sec_idx].idr[(reg_offset - A_IDR0) / 4];
         return MEMTX_OK;
     case A_IIDR:
         *data = s->iidr;
@@ -1726,77 +1792,79 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
         *data = s->aidr;
         return MEMTX_OK;
     case A_CR0:
-        *data = s->cr[0];
+        *data = s->bank[reg_sec_idx].cr[0];
         return MEMTX_OK;
     case A_CR0ACK:
-        *data = s->cr0ack;
+        *data = s->bank[reg_sec_idx].cr0ack;
         return MEMTX_OK;
     case A_CR1:
-        *data = s->cr[1];
+        *data = s->bank[reg_sec_idx].cr[1];
         return MEMTX_OK;
     case A_CR2:
-        *data = s->cr[2];
+        *data = s->bank[reg_sec_idx].cr[2];
         return MEMTX_OK;
     case A_STATUSR:
         *data = s->statusr;
         return MEMTX_OK;
     case A_GBPA:
-        *data = s->gbpa;
+        *data = s->bank[reg_sec_idx].gbpa;
         return MEMTX_OK;
     case A_IRQ_CTRL:
     case A_IRQ_CTRL_ACK:
-        *data = s->irq_ctrl;
+        *data = s->bank[reg_sec_idx].irq_ctrl;
         return MEMTX_OK;
     case A_GERROR:
-        *data = s->gerror;
+        *data = s->bank[reg_sec_idx].gerror;
         return MEMTX_OK;
     case A_GERRORN:
-        *data = s->gerrorn;
+        *data = s->bank[reg_sec_idx].gerrorn;
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG0: /* 64b */
-        *data = extract64(s->gerror_irq_cfg0, 0, 32);
+        *data = extract64(s->bank[reg_sec_idx].gerror_irq_cfg0, 0, 32);
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG0 + 4:
-        *data = extract64(s->gerror_irq_cfg0, 32, 32);
+        *data = extract64(s->bank[reg_sec_idx].gerror_irq_cfg0, 32, 32);
+        return MEMTX_OK;
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG1:
-        *data = s->gerror_irq_cfg1;
+        *data = s->bank[reg_sec_idx].gerror_irq_cfg1;
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG2:
-        *data = s->gerror_irq_cfg2;
+        *data = s->bank[reg_sec_idx].gerror_irq_cfg2;
         return MEMTX_OK;
     case A_STRTAB_BASE: /* 64b */
-        *data = extract64(s->strtab_base, 0, 32);
+        *data = extract64(s->bank[reg_sec_idx].strtab_base, 0, 32);
         return MEMTX_OK;
     case A_STRTAB_BASE + 4: /* 64b */
-        *data = extract64(s->strtab_base, 32, 32);
+        *data = extract64(s->bank[reg_sec_idx].strtab_base, 32, 32);
         return MEMTX_OK;
     case A_STRTAB_BASE_CFG:
-        *data = s->strtab_base_cfg;
+        *data = s->bank[reg_sec_idx].strtab_base_cfg;
         return MEMTX_OK;
     case A_CMDQ_BASE: /* 64b */
-        *data = extract64(s->cmdq.base, 0, 32);
+        *data = extract64(s->bank[reg_sec_idx].cmdq.base, 0, 32);
         return MEMTX_OK;
     case A_CMDQ_BASE + 4:
-        *data = extract64(s->cmdq.base, 32, 32);
+        *data = extract64(s->bank[reg_sec_idx].cmdq.base, 32, 32);
         return MEMTX_OK;
     case A_CMDQ_PROD:
-        *data = s->cmdq.prod;
+        *data = s->bank[reg_sec_idx].cmdq.prod;
         return MEMTX_OK;
     case A_CMDQ_CONS:
-        *data = s->cmdq.cons;
+        *data = s->bank[reg_sec_idx].cmdq.cons;
         return MEMTX_OK;
     case A_EVENTQ_BASE: /* 64b */
-        *data = extract64(s->eventq.base, 0, 32);
+        *data = extract64(s->bank[reg_sec_idx].eventq.base, 0, 32);
         return MEMTX_OK;
     case A_EVENTQ_BASE + 4: /* 64b */
-        *data = extract64(s->eventq.base, 32, 32);
+        *data = extract64(s->bank[reg_sec_idx].eventq.base, 32, 32);
         return MEMTX_OK;
     case A_EVENTQ_PROD:
-        *data = s->eventq.prod;
+        *data = s->bank[reg_sec_idx].eventq.prod;
         return MEMTX_OK;
     case A_EVENTQ_CONS:
-        *data = s->eventq.cons;
+        *data = s->bank[reg_sec_idx].eventq.cons;
+        return MEMTX_OK;
         return MEMTX_OK;
     default:
         *data = 0;
@@ -1816,13 +1884,14 @@ static MemTxResult smmu_read_mmio(void *opaque, hwaddr offset, uint64_t *data,
 
     /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
     offset &= ~0x10000;
+    SMMUSecurityIndex reg_sec_idx = SMMU_SEC_IDX_NS;
 
     switch (size) {
     case 8:
-        r = smmu_readll(s, offset, data, attrs);
+        r = smmu_readll(s, offset, data, attrs, reg_sec_idx);
         break;
     case 4:
-        r = smmu_readl(s, offset, data, attrs);
+        r = smmu_readl(s, offset, data, attrs, reg_sec_idx);
         break;
     default:
         r = MEMTX_ERROR;
@@ -1918,7 +1987,7 @@ static bool smmuv3_gbpa_needed(void *opaque)
     SMMUv3State *s = opaque;
 
     /* Only migrate GBPA if it has different reset value. */
-    return s->gbpa != SMMU_GBPA_RESET_VAL;
+    return s->bank[SMMU_SEC_IDX_NS].gbpa != SMMU_GBPA_RESET_VAL;
 }
 
 static const VMStateDescription vmstate_gbpa = {
@@ -1927,7 +1996,7 @@ static const VMStateDescription vmstate_gbpa = {
     .minimum_version_id = 1,
     .needed = smmuv3_gbpa_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(gbpa, SMMUv3State),
+        VMSTATE_UINT32(bank[SMMU_SEC_IDX_NS].gbpa, SMMUv3State),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -1938,28 +2007,29 @@ static const VMStateDescription vmstate_smmuv3 = {
     .minimum_version_id = 1,
     .priority = MIG_PRI_IOMMU,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(features, SMMUv3State),
+        VMSTATE_UINT32(bank[SMMU_SEC_IDX_NS].features, SMMUv3State),
         VMSTATE_UINT8(sid_size, SMMUv3State),
-        VMSTATE_UINT8(sid_split, SMMUv3State),
+        VMSTATE_UINT8(bank[SMMU_SEC_IDX_NS].sid_split, SMMUv3State),
 
-        VMSTATE_UINT32_ARRAY(cr, SMMUv3State, 3),
-        VMSTATE_UINT32(cr0ack, SMMUv3State),
+        VMSTATE_UINT32_ARRAY(bank[SMMU_SEC_IDX_NS].cr, SMMUv3State, 3),
+        VMSTATE_UINT32(bank[SMMU_SEC_IDX_NS].cr0ack, SMMUv3State),
         VMSTATE_UINT32(statusr, SMMUv3State),
-        VMSTATE_UINT32(irq_ctrl, SMMUv3State),
-        VMSTATE_UINT32(gerror, SMMUv3State),
-        VMSTATE_UINT32(gerrorn, SMMUv3State),
-        VMSTATE_UINT64(gerror_irq_cfg0, SMMUv3State),
-        VMSTATE_UINT32(gerror_irq_cfg1, SMMUv3State),
-        VMSTATE_UINT32(gerror_irq_cfg2, SMMUv3State),
-        VMSTATE_UINT64(strtab_base, SMMUv3State),
-        VMSTATE_UINT32(strtab_base_cfg, SMMUv3State),
-        VMSTATE_UINT64(eventq_irq_cfg0, SMMUv3State),
-        VMSTATE_UINT32(eventq_irq_cfg1, SMMUv3State),
-        VMSTATE_UINT32(eventq_irq_cfg2, SMMUv3State),
-
-        VMSTATE_STRUCT(cmdq, SMMUv3State, 0, vmstate_smmuv3_queue, SMMUQueue),
-        VMSTATE_STRUCT(eventq, SMMUv3State, 0, vmstate_smmuv3_queue, SMMUQueue),
-
+        VMSTATE_UINT32(bank[SMMU_SEC_IDX_NS].irq_ctrl, SMMUv3State),
+        VMSTATE_UINT32(bank[SMMU_SEC_IDX_NS].gerror, SMMUv3State),
+        VMSTATE_UINT32(bank[SMMU_SEC_IDX_NS].gerrorn, SMMUv3State),
+        VMSTATE_UINT64(bank[SMMU_SEC_IDX_NS].gerror_irq_cfg0, SMMUv3State),
+        VMSTATE_UINT32(bank[SMMU_SEC_IDX_NS].gerror_irq_cfg1, SMMUv3State),
+        VMSTATE_UINT32(bank[SMMU_SEC_IDX_NS].gerror_irq_cfg2, SMMUv3State),
+        VMSTATE_UINT64(bank[SMMU_SEC_IDX_NS].strtab_base, SMMUv3State),
+        VMSTATE_UINT32(bank[SMMU_SEC_IDX_NS].strtab_base_cfg, SMMUv3State),
+        VMSTATE_UINT64(bank[SMMU_SEC_IDX_NS].eventq_irq_cfg0, SMMUv3State),
+        VMSTATE_UINT32(bank[SMMU_SEC_IDX_NS].eventq_irq_cfg1, SMMUv3State),
+        VMSTATE_UINT32(bank[SMMU_SEC_IDX_NS].eventq_irq_cfg2, SMMUv3State),
+
+        VMSTATE_STRUCT(bank[SMMU_SEC_IDX_NS].cmdq, SMMUv3State, 0,
+                       vmstate_smmuv3_queue, SMMUQueue),
+        VMSTATE_STRUCT(bank[SMMU_SEC_IDX_NS].eventq, SMMUv3State, 0,
+                       vmstate_smmuv3_queue, SMMUQueue),
         VMSTATE_END_OF_LIST(),
     },
     .subsections = (const VMStateDescription * const []) {
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index f3386bd7ae..80cb4d6b04 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -35,13 +35,13 @@ smmuv3_trigger_irq(int irq) "irq=%d"
 smmuv3_write_gerror(uint32_t toggled, uint32_t gerror) "toggled=0x%x, new GERROR=0x%x"
 smmuv3_write_gerrorn(uint32_t acked, uint32_t gerrorn) "acked=0x%x, new GERRORN=0x%x"
 smmuv3_unhandled_cmd(uint32_t type) "Unhandled command type=%d"
-smmuv3_cmdq_consume(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod=%d cons=%d prod.wrap=%d cons.wrap=%d"
+smmuv3_cmdq_consume(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap, int sec_idx) "prod=%d cons=%d prod.wrap=%d cons.wrap=%d sec_idx=%d"
 smmuv3_cmdq_opcode(const char *opcode) "<--- %s"
 smmuv3_cmdq_consume_out(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod:%d, cons:%d, prod_wrap:%d, cons_wrap:%d "
 smmuv3_cmdq_consume_error(const char *cmd_name, uint8_t cmd_error) "Error on %s command execution: %d"
 smmuv3_write_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
-smmuv3_record_event(const char *type, uint32_t sid) "%s sid=0x%x"
-smmuv3_find_ste(uint16_t sid, uint32_t features, uint16_t sid_split) "sid=0x%x features:0x%x, sid_split:0x%x"
+smmuv3_record_event(const char *type, uint32_t sid, int sec_idx) "%s sid=0x%x sec_idx=%d"
+smmuv3_find_ste(uint16_t sid, uint32_t features, uint16_t sid_split, int sec_idx) "sid=0x%x features:0x%x, sid_split:0x%x sec_idx=%d"
 smmuv3_find_ste_2lvl(uint64_t strtab_base, uint64_t l1ptr, int l1_ste_offset, uint64_t l2ptr, int l2_ste_offset, int max_l2_ste) "strtab_base:0x%"PRIx64" l1ptr:0x%"PRIx64" l1_off:0x%x, l2ptr:0x%"PRIx64" l2_off:0x%x max_l2_ste:%d"
 smmuv3_get_ste(uint64_t addr) "STE addr: 0x%"PRIx64
 smmuv3_translate_disable(const char *n, uint16_t sid, uint64_t addr, bool is_write) "%s sid=0x%x bypass (smmu disabled) iova:0x%"PRIx64" is_write=%d"
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 80d0fecfde..3df82b83eb 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -40,6 +40,19 @@
 #define CACHED_ENTRY_TO_ADDR(ent, addr)      ((ent)->entry.translated_addr + \
                                              ((addr) & (ent)->entry.addr_mask))
 
+/*
+ * SMMU Security state index
+ *
+ * The values of this enumeration are identical to the SEC_SID signal
+ * encoding defined in the ARM SMMUv3 Architecture Specification. It is used
+ * to select the appropriate programming interface for a given transaction.
+ */
+typedef enum SMMUSecurityIndex {
+    SMMU_SEC_IDX_NS = 0,
+    SMMU_SEC_IDX_S = 1,
+    SMMU_SEC_IDX_NUM,
+} SMMUSecurityIndex;
+
 /*
  * Page table walk error types
  */
@@ -116,6 +129,7 @@ typedef struct SMMUTransCfg {
     SMMUTransTableInfo tt[2];
     /* Used by stage-2 only. */
     struct SMMUS2Cfg s2cfg;
+    SMMUSecurityIndex sec_idx; /* cached security index */
 } SMMUTransCfg;
 
 typedef struct SMMUDevice {
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index d183a62766..572f15251e 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -32,19 +32,11 @@ typedef struct SMMUQueue {
      uint8_t log2size;
 } SMMUQueue;
 
-struct SMMUv3State {
-    SMMUState     smmu_state;
-
-    uint32_t features;
-    uint8_t sid_size;
-    uint8_t sid_split;
-
+/* Structure for register bank */
+typedef struct SMMUv3RegBank {
     uint32_t idr[6];
-    uint32_t iidr;
-    uint32_t aidr;
     uint32_t cr[3];
     uint32_t cr0ack;
-    uint32_t statusr;
     uint32_t gbpa;
     uint32_t irq_ctrl;
     uint32_t gerror;
@@ -57,12 +49,28 @@ struct SMMUv3State {
     uint64_t eventq_irq_cfg0;
     uint32_t eventq_irq_cfg1;
     uint32_t eventq_irq_cfg2;
+    uint32_t features;
+    uint8_t sid_split;
 
     SMMUQueue eventq, cmdq;
+} SMMUv3RegBank;
+
+struct SMMUv3State {
+    SMMUState     smmu_state;
+
+    /* Shared (non-banked) registers and state */
+    uint8_t sid_size;
+    uint32_t iidr;
+    uint32_t aidr;
+    uint32_t statusr;
+
+    /* Banked registers for all access */
+    SMMUv3RegBank bank[SMMU_SEC_IDX_NUM];
 
     qemu_irq     irq[4];
     QemuMutex mutex;
     char *stage;
+    bool secure_impl;
 };
 
 typedef enum {
@@ -84,7 +92,9 @@ struct SMMUv3Class {
 #define TYPE_ARM_SMMUV3   "arm-smmuv3"
 OBJECT_DECLARE_TYPE(SMMUv3State, SMMUv3Class, ARM_SMMUV3)
 
-#define STAGE1_SUPPORTED(s)      FIELD_EX32(s->idr[0], IDR0, S1P)
-#define STAGE2_SUPPORTED(s)      FIELD_EX32(s->idr[0], IDR0, S2P)
+#define STAGE1_SUPPORTED(s)    \
+    FIELD_EX32(s->bank[SMMU_SEC_IDX_NS].idr[0], IDR0, S1P)
+#define STAGE2_SUPPORTED(s)    \
+    FIELD_EX32(s->bank[SMMU_SEC_IDX_NS].idr[0], IDR0, S2P)
 
 #endif
-- 
2.34.1


