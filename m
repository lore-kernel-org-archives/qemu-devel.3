Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A16CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 16:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1ooy-00079T-8l; Thu, 25 Sep 2025 12:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v1oo6-0006Ro-6p; Thu, 25 Sep 2025 12:27:00 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v1ono-0004lg-Ds; Thu, 25 Sep 2025 12:26:56 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwD3jWE4bdVouTN6Bw--.50242S2;
 Fri, 26 Sep 2025 00:26:32 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDHLestbdVoW_MeAA--.7120S13;
 Fri, 26 Sep 2025 00:26:31 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>, pierrick.bouvier@linaro.org,
 philmd@linaro.org, jean-philippe@linaro.org, smostafa@google.com,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v2 10/14] hw/arm/smmuv3: Add banked support for queues and
 error handling
Date: Fri, 26 Sep 2025 00:26:14 +0800
Message-Id: <20250925162618.191242-11-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDHLestbdVoW_MeAA--.7120S13
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAEBWjUSMIHwQAAsw
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoWfZw17trW7Kw1DXFyxArWDurg_yoW8ZF17Jo
 WrKw4DZw4xWr1ku34q9Fn7JF43AFs3CwsIka4rZa1Du398Ar18Wr97CrW3u3yagr43XFyD
 tw109w4xXF4rArWrn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This commit extends the banked register model to the Command Queue
(CMDQ), Event Queue (EVTQ), and global error handling logic.

By leveraging the banked structure, the SMMUv3 model now supports
separate, parallel queues and error status registers for the Secure and
Non-secure states. This is essential for correctly modeling the
parallel programming interfaces defined by the SMMUv3 architecture.

Additionally, this patch hardens the MMIO implementation by adding
several checks that were incomplete in the previous version.
For instance, writes to the Command Queue registers are now correctly
gated by the IDR1.QUEUES_PRESET bit, ensuring compliance with the
architectural rules for pre-configured queues.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3-internal.h |   2 +
 hw/arm/smmuv3.c          | 374 +++++++++++++++++++++++++++++++++------
 2 files changed, 323 insertions(+), 53 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index af2936cf16..6bff504219 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -517,6 +517,8 @@ typedef struct SMMUEventInfo {
     uint32_t sid;
     bool recorded;
     bool inval_ste_allowed;
+    AddressSpace *as;
+    MemTxAttrs txattrs;
     SMMUSecurityIndex sec_idx;
     union {
         struct {
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 3835b9e79f..53c7eff0e3 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -106,14 +106,15 @@ static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn,
     trace_smmuv3_write_gerrorn(toggled & pending, s->bank[sec_idx].gerrorn);
 }
 
-static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd)
+static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd,
+                                     SMMUSecurityIndex sec_idx)
 {
     dma_addr_t addr = Q_CONS_ENTRY(q);
     MemTxResult ret;
     int i;
 
-    ret = dma_memory_read(&address_space_memory, addr, cmd, sizeof(Cmd),
-                          MEMTXATTRS_UNSPECIFIED);
+    ret = dma_memory_read(smmu_get_address_space(sec_idx), addr, cmd,
+                          sizeof(Cmd), smmu_get_txattrs(sec_idx));
     if (ret != MEMTX_OK) {
         return ret;
     }
@@ -123,7 +124,8 @@ static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd)
     return ret;
 }
 
-static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in)
+static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in,
+                               SMMUSecurityIndex sec_idx)
 {
     dma_addr_t addr = Q_PROD_ENTRY(q);
     MemTxResult ret;
@@ -133,8 +135,8 @@ static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in)
     for (i = 0; i < ARRAY_SIZE(evt.word); i++) {
         cpu_to_le32s(&evt.word[i]);
     }
-    ret = dma_memory_write(&address_space_memory, addr, &evt, sizeof(Evt),
-                           MEMTXATTRS_UNSPECIFIED);
+    ret = dma_memory_write(smmu_get_address_space(sec_idx), addr, &evt,
+                           sizeof(Evt), smmu_get_txattrs(sec_idx));
     if (ret != MEMTX_OK) {
         return ret;
     }
@@ -157,7 +159,7 @@ static MemTxResult smmuv3_write_eventq(SMMUv3State *s, Evt *evt,
         return MEMTX_ERROR;
     }
 
-    r = queue_write(q, evt);
+    r = queue_write(q, evt, sec_idx);
     if (r != MEMTX_OK) {
         return r;
     }
@@ -1025,6 +1027,8 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
          */
         class = ptw_info.is_ipa_descriptor ? SMMU_CLASS_TT : class;
         event->sec_idx = cfg->sec_idx;
+        event->txattrs = cfg->txattrs;
+        event->sec_idx = cfg->sec_idx;
         switch (ptw_info.type) {
         case SMMU_PTW_ERR_WALK_EABT:
             event->type = SMMU_EVT_F_WALK_EABT;
@@ -1376,6 +1380,110 @@ static bool smmu_strtab_base_writable(SMMUv3State *s, SMMUSecurityIndex sec_idx)
     return smmuv3_is_smmu_enabled(s, sec_idx);
 }
 
+static inline int smmuv3_get_cr0_cmdqen(SMMUv3State *s,
+                                        SMMUSecurityIndex sec_idx)
+{
+    return FIELD_EX32(s->bank[sec_idx].cr[0], CR0, CMDQEN);
+}
+
+static inline int smmuv3_get_cr0ack_cmdqen(SMMUv3State *s,
+                                           SMMUSecurityIndex sec_idx)
+{
+    return FIELD_EX32(s->bank[sec_idx].cr0ack, CR0, CMDQEN);
+}
+
+static inline int smmuv3_get_cr0_eventqen(SMMUv3State *s,
+                                          SMMUSecurityIndex sec_idx)
+{
+    return FIELD_EX32(s->bank[sec_idx].cr[0], CR0, EVENTQEN);
+}
+
+static inline int smmuv3_get_cr0ack_eventqen(SMMUv3State *s,
+                                             SMMUSecurityIndex sec_idx)
+{
+    return FIELD_EX32(s->bank[sec_idx].cr0ack, CR0, EVENTQEN);
+}
+
+/* Check if MSI is supported */
+static inline bool smmu_msi_supported(SMMUv3State *s, SMMUSecurityIndex sec_idx)
+{
+    return FIELD_EX32(s->bank[sec_idx].idr[0], IDR0, MSI);
+}
+
+/* Check if secure GERROR_IRQ_CFGx registers are writable */
+static inline bool smmu_gerror_irq_cfg_writable(SMMUv3State *s,
+                                                SMMUSecurityIndex sec_idx)
+{
+    if (!smmu_msi_supported(s, SMMU_SEC_IDX_NS)) {
+        return false;
+    }
+
+    bool ctrl_en = FIELD_EX32(s->bank[sec_idx].irq_ctrl,
+                              IRQ_CTRL, GERROR_IRQEN);
+
+    return !ctrl_en;
+}
+
+/* Check if CMDQEN is disabled */
+static bool smmu_cmdqen_disabled(SMMUv3State *s, SMMUSecurityIndex sec_idx)
+{
+    int cr0_cmdqen = smmuv3_get_cr0_cmdqen(s, sec_idx);
+    int cr0ack_cmdqen = smmuv3_get_cr0ack_cmdqen(s, sec_idx);
+    return (cr0_cmdqen == 0 && cr0ack_cmdqen == 0);
+}
+
+/* Check if CMDQ_BASE register is writable */
+static bool smmu_cmdq_base_writable(SMMUv3State *s, SMMUSecurityIndex sec_idx)
+{
+    /* Check TABLES_PRESET - use NS bank as it's the global setting */
+    if (FIELD_EX32(s->bank[SMMU_SEC_IDX_NS].idr[1], IDR1, QUEUES_PRESET)) {
+        return false;
+    }
+
+    return smmu_cmdqen_disabled(s, sec_idx);
+}
+
+/* Check if EVENTQEN is disabled */
+static bool smmu_eventqen_disabled(SMMUv3State *s, SMMUSecurityIndex sec_idx)
+{
+    int cr0_eventqen = smmuv3_get_cr0_eventqen(s, sec_idx);
+    int cr0ack_eventqen = smmuv3_get_cr0ack_eventqen(s, sec_idx);
+    return (cr0_eventqen == 0 && cr0ack_eventqen == 0);
+}
+
+static bool smmu_idr1_queue_preset(SMMUv3State *s, SMMUSecurityIndex sec_idx)
+{
+    return FIELD_EX32(s->bank[sec_idx].idr[1], IDR1, QUEUES_PRESET);
+}
+
+/* Check if EVENTQ_BASE register is writable */
+static bool smmu_eventq_base_writable(SMMUv3State *s, SMMUSecurityIndex sec_idx)
+{
+    /* Check TABLES_PRESET - use NS bank as it's the global setting */
+    if (smmu_idr1_queue_preset(s, SMMU_SEC_IDX_NS)) {
+        return false;
+    }
+
+    return smmu_eventqen_disabled(s, sec_idx);
+}
+
+static bool smmu_irq_ctl_evtq_irqen_disabled(SMMUv3State *s,
+                                             SMMUSecurityIndex sec_idx)
+{
+    return FIELD_EX32(s->bank[sec_idx].irq_ctrl, IRQ_CTRL, EVENTQ_IRQEN);
+}
+
+/* Check if EVENTQ_IRQ_CFGx is writable */
+static bool smmu_eventq_irq_cfg_writable(SMMUv3State *s,
+                                         SMMUSecurityIndex sec_idx)
+{
+    if (smmu_msi_supported(s, sec_idx)) {
+        return false;
+    }
+
+    return smmu_irq_ctl_evtq_irqen_disabled(s, sec_idx);
+}
+
 static int smmuv3_cmdq_consume(SMMUv3State *s, SMMUSecurityIndex sec_idx)
 {
     SMMUState *bs = ARM_SMMU(s);
@@ -1405,7 +1513,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, SMMUSecurityIndex sec_idx)
             break;
         }
 
-        if (queue_read(q, &cmd) != MEMTX_OK) {
+        if (queue_read(q, &cmd, sec_idx) != MEMTX_OK) {
             cmd_error = SMMU_CERROR_ABT;
             break;
         }
@@ -1430,8 +1538,11 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, SMMUSecurityIndex sec_idx)
             SMMUDevice *sdev = smmu_find_sdev(bs, sid);
 
             if (CMD_SSEC(&cmd)) {
-                cmd_error = SMMU_CERROR_ILL;
-                break;
+                if (sec_idx != SMMU_SEC_IDX_S) {
+                    /* Secure Stream with Non-Secure command */
+                    cmd_error = SMMU_CERROR_ILL;
+                    break;
+                }
             }
 
             if (!sdev) {
@@ -1450,8 +1561,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, SMMUSecurityIndex sec_idx)
             SMMUSIDRange sid_range;
 
             if (CMD_SSEC(&cmd)) {
-                cmd_error = SMMU_CERROR_ILL;
-                break;
+                if (sec_idx != SMMU_SEC_IDX_S) {
+                    cmd_error = SMMU_CERROR_ILL;
+                    break;
+                }
             }
 
             mask = (1ULL << (range + 1)) - 1;
@@ -1469,8 +1582,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, SMMUSecurityIndex sec_idx)
             SMMUDevice *sdev = smmu_find_sdev(bs, sid);
 
             if (CMD_SSEC(&cmd)) {
-                cmd_error = SMMU_CERROR_ILL;
-                break;
+                if (sec_idx != SMMU_SEC_IDX_S) {
+                    cmd_error = SMMU_CERROR_ILL;
+                    break;
+                }
             }
 
             if (!sdev) {
@@ -1624,6 +1739,13 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
         s->bank[reg_sec_idx].strtab_base = data & SMMU_STRTAB_BASE_RESERVED;
         return MEMTX_OK;
     case A_CMDQ_BASE:
+        if (!smmu_cmdq_base_writable(s, reg_sec_idx)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "CMDQ_BASE write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_QUEUE_BASE_RESERVED;
         s->bank[reg_sec_idx].cmdq.base = data;
         s->bank[reg_sec_idx].cmdq.log2size = extract64(
             s->bank[reg_sec_idx].cmdq.base, 0, 5);
@@ -1632,6 +1754,13 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
         }
         return MEMTX_OK;
     case A_EVENTQ_BASE:
+        if (!smmu_eventq_base_writable(s, reg_sec_idx)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "EVENTQ_BASE write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_QUEUE_BASE_RESERVED;
         s->bank[reg_sec_idx].eventq.base = data;
         s->bank[reg_sec_idx].eventq.log2size = extract64(
             s->bank[reg_sec_idx].eventq.base, 0, 5);
@@ -1640,8 +1769,25 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
         }
         return MEMTX_OK;
     case A_EVENTQ_IRQ_CFG0:
+        if (!smmu_eventq_irq_cfg_writable(s, reg_sec_idx)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "EVENTQ_IRQ_CFG0 write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_EVENTQ_IRQ_CFG0_RESERVED;
         s->bank[reg_sec_idx].eventq_irq_cfg0 = data;
         return MEMTX_OK;
+    case A_GERROR_IRQ_CFG0:
+        if (!smmu_gerror_irq_cfg_writable(s, reg_sec_idx)) {
+            /* SMMU_(*_)_IRQ_CTRL.GERROR_IRQEN == 1: IGNORED this write */
+            qemu_log_mask(LOG_GUEST_ERROR, "GERROR_IRQ_CFG0 write ignored: "
+                         "register is RO when IRQ enabled\n");
+            return MEMTX_OK;
+        }
+        s->bank[reg_sec_idx].gerror_irq_cfg0 =
+            data & SMMU_GERROR_IRQ_CFG0_RESERVED;
+        return MEMTX_OK;
     default:
         qemu_log_mask(LOG_UNIMP,
                       "%s Unexpected 64-bit access to 0x%"PRIx64" (WI)\n",
@@ -1666,7 +1812,15 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         s->bank[reg_sec_idx].cr[1] = data;
         return MEMTX_OK;
     case A_CR2:
-        s->bank[reg_sec_idx].cr[2] = data;
+        if (smmuv3_is_smmu_enabled(s, reg_sec_idx)) {
+            /* Allow write: SMMUEN is 0 in both CR0 and CR0ACK */
+            s->bank[reg_sec_idx].cr[2] = data;
+        } else {
+            /* CONSTRAINED UNPREDICTABLE behavior: Ignore this write */
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "CR2 write ignored: register is read-only when "
+                          "CR0.SMMUEN or CR0ACK.SMMUEN is set\n");
+        }
         return MEMTX_OK;
     case A_IRQ_CTRL:
         s->bank[reg_sec_idx].irq_ctrl = data;
@@ -1680,14 +1834,28 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         smmuv3_cmdq_consume(s, reg_sec_idx);
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG0: /* 64b */
-        s->bank[reg_sec_idx].gerror_irq_cfg0 =
-            deposit64(s->bank[reg_sec_idx].gerror_irq_cfg0, 0, 32, data);
-        return MEMTX_OK;
     case A_GERROR_IRQ_CFG0 + 4:
-        s->bank[reg_sec_idx].gerror_irq_cfg0 =
-            deposit64(s->bank[reg_sec_idx].gerror_irq_cfg0, 32, 32, data);
+        if (!smmu_gerror_irq_cfg_writable(s, reg_sec_idx)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "GERROR_IRQ_CFG0 write ignored: "
+                          "register is RO when IRQ enabled\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_GERROR_IRQ_CFG0_RESERVED;
+        if (reg_offset == A_GERROR_IRQ_CFG0) {
+            s->bank[reg_sec_idx].gerror_irq_cfg0 = deposit64(
+                s->bank[reg_sec_idx].gerror_irq_cfg0, 0, 32, data);
+        } else {
+            s->bank[reg_sec_idx].gerror_irq_cfg0 = deposit64(
+                s->bank[reg_sec_idx].gerror_irq_cfg0, 32, 32, data);
+        }
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG1:
+        if (!smmu_gerror_irq_cfg_writable(s, reg_sec_idx)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "GERROR_IRQ_CFG1 write ignored: "
+                          "register is RO when IRQ enabled\n");
+            return MEMTX_OK;
+        }
         s->bank[reg_sec_idx].gerror_irq_cfg1 = data;
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG2:
@@ -1735,60 +1903,106 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         }
         return MEMTX_OK;
     case A_CMDQ_BASE: /* 64b */
-        s->bank[reg_sec_idx].cmdq.base =
-            deposit64(s->bank[reg_sec_idx].cmdq.base, 0, 32, data);
-        s->bank[reg_sec_idx].cmdq.log2size =
-            extract64(s->bank[reg_sec_idx].cmdq.base, 0, 5);
-        if (s->bank[reg_sec_idx].cmdq.log2size > SMMU_CMDQS) {
-            s->bank[reg_sec_idx].cmdq.log2size = SMMU_CMDQS;
-        }
-        return MEMTX_OK;
     case A_CMDQ_BASE + 4: /* 64b */
-        s->bank[reg_sec_idx].cmdq.base =
-            deposit64(s->bank[reg_sec_idx].cmdq.base, 32, 32, data);
-        return MEMTX_OK;
+        if (!smmu_cmdq_base_writable(s, reg_sec_idx)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "CMDQ_BASE write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_QUEUE_BASE_RESERVED;
+        if (reg_offset == A_CMDQ_BASE) {
+            s->bank[reg_sec_idx].cmdq.base = deposit64(
+                s->bank[reg_sec_idx].cmdq.base, 0, 32, data);
+
+            s->bank[reg_sec_idx].cmdq.log2size = extract64(
+                s->bank[reg_sec_idx].cmdq.base, 0, 5);
+            if (s->bank[reg_sec_idx].cmdq.log2size > SMMU_CMDQS) {
+                s->bank[reg_sec_idx].cmdq.log2size = SMMU_CMDQS;
+            }
+        } else {
+            s->bank[reg_sec_idx].cmdq.base = deposit64(
+                s->bank[reg_sec_idx].cmdq.base, 32, 32, data);
+        }
+
         return MEMTX_OK;
     case A_CMDQ_PROD:
         s->bank[reg_sec_idx].cmdq.prod = data;
         smmuv3_cmdq_consume(s, reg_sec_idx);
         return MEMTX_OK;
     case A_CMDQ_CONS:
+        if (!smmu_cmdqen_disabled(s, reg_sec_idx)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "CMDQ_CONS write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
         s->bank[reg_sec_idx].cmdq.cons = data;
         return MEMTX_OK;
     case A_EVENTQ_BASE: /* 64b */
-        s->bank[reg_sec_idx].eventq.base =
-            deposit64(s->bank[reg_sec_idx].eventq.base, 0, 32, data);
-        s->bank[reg_sec_idx].eventq.log2size =
-            extract64(s->bank[reg_sec_idx].eventq.base, 0, 5);
-        if (s->bank[reg_sec_idx].eventq.log2size > SMMU_EVENTQS) {
-            s->bank[reg_sec_idx].eventq.log2size = SMMU_EVENTQS;
-        }
-        s->bank[reg_sec_idx].eventq.cons = data;
-        return MEMTX_OK;
     case A_EVENTQ_BASE + 4:
-        s->bank[reg_sec_idx].eventq.base =
-            deposit64(s->bank[reg_sec_idx].eventq.base, 32, 32, data);
-        return MEMTX_OK;
+        if (!smmu_eventq_base_writable(s, reg_sec_idx)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "EVENTQ_BASE write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_QUEUE_BASE_RESERVED;
+        if (reg_offset == A_EVENTQ_BASE) {
+            s->bank[reg_sec_idx].eventq.base = deposit64(
+                s->bank[reg_sec_idx].eventq.base, 0, 32, data);
+
+            s->bank[reg_sec_idx].eventq.log2size = extract64(
+                s->bank[reg_sec_idx].eventq.base, 0, 5);
+            if (s->bank[reg_sec_idx].eventq.log2size > SMMU_EVENTQS) {
+                s->bank[reg_sec_idx].eventq.log2size = SMMU_EVENTQS;
+            }
+        } else {
+            s->bank[reg_sec_idx].eventq.base = deposit64(
+                s->bank[reg_sec_idx].eventq.base, 32, 32, data);
+        }
         return MEMTX_OK;
     case A_EVENTQ_PROD:
+        if (!smmu_eventqen_disabled(s, reg_sec_idx)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "EVENTQ_PROD write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
         s->bank[reg_sec_idx].eventq.prod = data;
         return MEMTX_OK;
     case A_EVENTQ_CONS:
         s->bank[reg_sec_idx].eventq.cons = data;
         return MEMTX_OK;
     case A_EVENTQ_IRQ_CFG0: /* 64b */
-        s->bank[reg_sec_idx].eventq_irq_cfg0 =
-            deposit64(s->bank[reg_sec_idx].eventq_irq_cfg0, 0, 32, data);
-        return MEMTX_OK;
     case A_EVENTQ_IRQ_CFG0 + 4:
-        s->bank[reg_sec_idx].eventq_irq_cfg0 =
-            deposit64(s->bank[reg_sec_idx].eventq_irq_cfg0, 32, 32, data);
-        return MEMTX_OK;
+        if (!smmu_eventq_irq_cfg_writable(s, reg_sec_idx)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "EVENTQ_IRQ_CFG0 write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_EVENTQ_IRQ_CFG0_RESERVED;
+        if (reg_offset == A_EVENTQ_IRQ_CFG0) {
+            s->bank[reg_sec_idx].eventq_irq_cfg0 = deposit64(
+                s->bank[reg_sec_idx].eventq_irq_cfg0, 0, 32, data);
+        } else {
+            s->bank[reg_sec_idx].eventq_irq_cfg0 = deposit64(
+                s->bank[reg_sec_idx].eventq_irq_cfg0, 32, 32, data);
+        }
         return MEMTX_OK;
     case A_EVENTQ_IRQ_CFG1:
+        if (!smmu_eventq_irq_cfg_writable(s, reg_sec_idx)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "EVENTQ_IRQ_CFG1 write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
         s->bank[reg_sec_idx].eventq_irq_cfg1 = data;
         return MEMTX_OK;
     case A_EVENTQ_IRQ_CFG2:
+        if (!smmu_eventq_irq_cfg_writable(s, reg_sec_idx)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "EVENTQ_IRQ_CFG2 write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
         s->bank[reg_sec_idx].eventq_irq_cfg2 = data;
         return MEMTX_OK;
     case A_S_INIT_ALIAS:
@@ -1848,6 +2062,11 @@ static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
     uint32_t reg_offset = offset & 0xfff;
     switch (reg_offset) {
     case A_GERROR_IRQ_CFG0:
+        /* SMMU_(*_)GERROR_IRQ_CFG0 BOTH check SMMU_IDR0.MSI */
+        if (!smmu_msi_supported(s, SMMU_SEC_IDX_NS)) {
+            *data = 0; /* RES0 */
+            return MEMTX_OK;
+        }
         *data = s->bank[reg_sec_idx].gerror_irq_cfg0;
         return MEMTX_OK;
     case A_STRTAB_BASE:
@@ -1859,6 +2078,13 @@ static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
     case A_EVENTQ_BASE:
         *data = s->bank[reg_sec_idx].eventq.base;
         return MEMTX_OK;
+    case A_EVENTQ_IRQ_CFG0:
+        /* MSI support is depends on the register's security domain */
+        if (!smmu_msi_supported(s, reg_sec_idx)) {
+            *data = 0;
+            return MEMTX_OK;
+        }
+
         *data = s->bank[reg_sec_idx].eventq_irq_cfg0;
         return MEMTX_OK;
     default:
@@ -1917,16 +2143,31 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
         *data = s->bank[reg_sec_idx].gerrorn;
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG0: /* 64b */
-        *data = extract64(s->bank[reg_sec_idx].gerror_irq_cfg0, 0, 32);
-        return MEMTX_OK;
     case A_GERROR_IRQ_CFG0 + 4:
-        *data = extract64(s->bank[reg_sec_idx].gerror_irq_cfg0, 32, 32);
-        return MEMTX_OK;
+        /* SMMU_(*_)GERROR_IRQ_CFG0 BOTH check SMMU_IDR0.MSI */
+        if (!smmu_msi_supported(s, SMMU_SEC_IDX_NS)) {
+            *data = 0; /* RES0 */
+            return MEMTX_OK;
+        }
+
+        if (reg_offset == A_GERROR_IRQ_CFG0) {
+            *data = extract64(s->bank[reg_sec_idx].gerror_irq_cfg0, 0, 32);
+        } else {
+            *data = extract64(s->bank[reg_sec_idx].gerror_irq_cfg0, 32, 32);
+        }
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG1:
+        if (!smmu_msi_supported(s, SMMU_SEC_IDX_NS)) {
+            *data = 0; /* RES0 */
+            return MEMTX_OK;
+        }
         *data = s->bank[reg_sec_idx].gerror_irq_cfg1;
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG2:
+        if (!smmu_msi_supported(s, SMMU_SEC_IDX_NS)) {
+            *data = 0; /* RES0 */
+            return MEMTX_OK;
+        }
         *data = s->bank[reg_sec_idx].gerror_irq_cfg2;
         return MEMTX_OK;
     case A_STRTAB_BASE: /* 64b */
@@ -1962,6 +2203,33 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
     case A_EVENTQ_CONS:
         *data = s->bank[reg_sec_idx].eventq.cons;
         return MEMTX_OK;
+    case A_EVENTQ_IRQ_CFG0:
+    case A_EVENTQ_IRQ_CFG0 + 4:
+        if (!smmu_msi_supported(s, reg_sec_idx)) {
+            *data = 0;
+            return MEMTX_OK;
+        }
+
+        if (reg_offset == A_EVENTQ_IRQ_CFG0) {
+            *data = extract64(s->bank[reg_sec_idx].eventq_irq_cfg0, 0, 32);
+        } else {
+            *data = extract64(s->bank[reg_sec_idx].eventq_irq_cfg0, 32, 32);
+        }
+        return MEMTX_OK;
+    case A_EVENTQ_IRQ_CFG1:
+        if (!smmu_msi_supported(s, reg_sec_idx)) {
+            *data = 0;
+            return MEMTX_OK;
+        }
+        *data = s->bank[reg_sec_idx].eventq_irq_cfg1;
+        return MEMTX_OK;
+    case A_EVENTQ_IRQ_CFG2:
+        if (!smmu_msi_supported(s, reg_sec_idx)) {
+            *data = 0;
+            return MEMTX_OK;
+        }
+        *data = s->bank[reg_sec_idx].eventq_irq_cfg2;
+        return MEMTX_OK;
     case A_S_INIT_ALIAS:
         *data = 0;
         return MEMTX_OK;
-- 
2.34.1


