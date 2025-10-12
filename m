Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76397CCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 15:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7xlD-0000ZS-02; Sun, 12 Oct 2025 11:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xl9-0000SC-WB; Sun, 12 Oct 2025 11:13:21 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xl7-0002SI-Dn; Sun, 12 Oct 2025 11:13:19 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwA3GGCKxetoaFagAA--.103S2;
 Sun, 12 Oct 2025 23:13:14 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDXO+mIxetoRXhMAA--.1376S3;
 Sun, 12 Oct 2025 23:13:13 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v3 14/21] hw/arm/smmuv3: Add access checks for MMIO registers
Date: Sun, 12 Oct 2025 23:13:03 +0800
Message-Id: <20251012151303.4129730-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDXO+mIxetoRXhMAA--.1376S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQABBWjqskUBbAAAsd
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoW3tw4xXF1kKFy8tr1kJF47urg_yoW8XFWfXo
 WFkr45Zw48Z3Z7C39avFs7X3WkJF4kCw47Aw15XrW2vw4kJr4rXr97GrZ3urya9rW7JrWk
 tw18Zw4fZFWrJFs5n29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
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

The SMMUv3 model was missing checks for register accessibility under
certain conditions. This allowed guest software to write to registers
like STRTAB_BASE when they should be read-only, or read from
GERROR_IRQ_CFG registers when they should be RES0.

This patch fixes this by introducing helper functions, such as the
smmu_(reg_name)_writable pattern, to encapsulate the architectural
access rules. In addition, writes to registers like STRTAB_BASE,
queue bases, and IRQ configurations are now masked to correctly
handle reserved bits.

The MMIO handlers are updated to call these functions before accessing
registers. To purely fix the missing checks without introducing new
functionality, the security context in the MMIO handlers is explicitly
fixed to Non-secure. This ensures that the scope of this patch is
limited to fixing existing Non-secure logic.

If a register is not accessible, the access is now correctly handled
and a guest error is logged, bringing the model's behavior in line with
the specification.

Fixes: fae4be38b35d ("hw/arm/smmuv3: Implement MMIO write operations")
Fixes: 10a83cb9887e ("hw/arm/smmuv3: Skeleton")
Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3.c | 304 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 298 insertions(+), 6 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index f9395c3821..f161dd3eff 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1321,6 +1321,127 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
     }
 }
 
+static inline int smmuv3_get_cr0ack_smmuen(SMMUv3State *s, SMMUSecSID sec_sid)
+{
+    return FIELD_EX32(s->bank[sec_sid].cr0ack, CR0, SMMUEN);
+}
+
+static inline bool smmuv3_is_smmu_enabled(SMMUv3State *s, SMMUSecSID sec_sid)
+{
+    int cr0_smmuen = smmu_enabled(s, sec_sid);
+    int cr0ack_smmuen = smmuv3_get_cr0ack_smmuen(s, sec_sid);
+    return (cr0_smmuen == 0 && cr0ack_smmuen == 0);
+}
+
+/* Check if STRTAB_BASE register is writable */
+static bool smmu_strtab_base_writable(SMMUv3State *s, SMMUSecSID sec_sid)
+{
+    /* Check TABLES_PRESET - use NS bank as it's the global setting */
+    if (FIELD_EX32(s->bank[sec_sid].idr[1], IDR1, TABLES_PRESET)) {
+        return false;
+    }
+
+    /* Check SMMUEN conditions for the specific security domain */
+    return smmuv3_is_smmu_enabled(s, sec_sid);
+}
+
+static inline int smmuv3_get_cr0_cmdqen(SMMUv3State *s, SMMUSecSID sec_sid)
+{
+    return FIELD_EX32(s->bank[sec_sid].cr[0], CR0, CMDQEN);
+}
+
+static inline int smmuv3_get_cr0ack_cmdqen(SMMUv3State *s, SMMUSecSID sec_sid)
+{
+    return FIELD_EX32(s->bank[sec_sid].cr0ack, CR0, CMDQEN);
+}
+
+static inline int smmuv3_get_cr0_eventqen(SMMUv3State *s, SMMUSecSID sec_sid)
+{
+    return FIELD_EX32(s->bank[sec_sid].cr[0], CR0, EVENTQEN);
+}
+
+static inline int smmuv3_get_cr0ack_eventqen(SMMUv3State *s, SMMUSecSID sec_sid)
+{
+    return FIELD_EX32(s->bank[sec_sid].cr0ack, CR0, EVENTQEN);
+}
+
+/* Check if MSI is supported */
+static inline bool smmu_msi_supported(SMMUv3State *s, SMMUSecSID sec_sid)
+{
+    return FIELD_EX32(s->bank[sec_sid].idr[0], IDR0, MSI);
+}
+
+/* Check if secure GERROR_IRQ_CFGx registers are writable */
+static inline bool smmu_gerror_irq_cfg_writable(SMMUv3State *s,
+                                                SMMUSecSID sec_sid)
+{
+    if (!smmu_msi_supported(s, sec_sid)) {
+        return false;
+    }
+
+    bool ctrl_en = FIELD_EX32(s->bank[sec_sid].irq_ctrl,
+                              IRQ_CTRL, GERROR_IRQEN);
+    return !ctrl_en;
+}
+
+/* Check if CMDQEN is disabled */
+static bool smmu_cmdqen_disabled(SMMUv3State *s, SMMUSecSID sec_sid)
+{
+    int cr0_cmdqen = smmuv3_get_cr0_cmdqen(s, sec_sid);
+    int cr0ack_cmdqen = smmuv3_get_cr0ack_cmdqen(s, sec_sid);
+    return (cr0_cmdqen == 0 && cr0ack_cmdqen == 0);
+}
+
+/* Check if CMDQ_BASE register is writable */
+static bool smmu_cmdq_base_writable(SMMUv3State *s, SMMUSecSID sec_sid)
+{
+    /* Check TABLES_PRESET - use NS bank as it's the global setting */
+    if (FIELD_EX32(s->bank[sec_sid].idr[1], IDR1, QUEUES_PRESET)) {
+        return false;
+    }
+
+    return smmu_cmdqen_disabled(s, sec_sid);
+}
+
+/* Check if EVENTQEN is disabled */
+static bool smmu_eventqen_disabled(SMMUv3State *s, SMMUSecSID sec_sid)
+{
+    int cr0_eventqen = smmuv3_get_cr0_eventqen(s, sec_sid);
+    int cr0ack_eventqen = smmuv3_get_cr0ack_eventqen(s, sec_sid);
+    return (cr0_eventqen == 0 && cr0ack_eventqen == 0);
+}
+
+static bool smmu_idr1_queue_preset(SMMUv3State *s, SMMUSecSID sec_sid)
+{
+    return FIELD_EX32(s->bank[sec_sid].idr[1], IDR1, QUEUES_PRESET);
+}
+
+/* Check if EVENTQ_BASE register is writable */
+static bool smmu_eventq_base_writable(SMMUv3State *s, SMMUSecSID sec_sid)
+{
+    /* Check TABLES_PRESET - use NS bank as it's the global setting */
+    if (smmu_idr1_queue_preset(s, sec_sid)) {
+        return false;
+    }
+
+    return smmu_eventqen_disabled(s, sec_sid);
+}
+
+static bool smmu_irq_ctl_evtq_irqen_disabled(SMMUv3State *s, SMMUSecSID sec_sid)
+{
+    return FIELD_EX32(s->bank[sec_sid].irq_ctrl, IRQ_CTRL, EVENTQ_IRQEN);
+}
+
+/* Check if EVENTQ_IRQ_CFGx is writable */
+static bool smmu_eventq_irq_cfg_writable(SMMUv3State *s, SMMUSecSID sec_sid)
+{
+    if (smmu_msi_supported(s, sec_sid)) {
+        return false;
+    }
+
+    return smmu_irq_ctl_evtq_irqen_disabled(s, sec_sid);
+}
+
 static int smmuv3_cmdq_consume(SMMUv3State *s)
 {
     SMMUState *bs = ARM_SMMU(s);
@@ -1561,27 +1682,59 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
 
     switch (offset) {
     case A_GERROR_IRQ_CFG0:
-        bank->gerror_irq_cfg0 = data;
+        if (!smmu_gerror_irq_cfg_writable(s, reg_sec_sid)) {
+            /* SMMU_(*_)_IRQ_CTRL.GERROR_IRQEN == 1: IGNORED this write */
+            qemu_log_mask(LOG_GUEST_ERROR, "GERROR_IRQ_CFG0 write ignored: "
+                         "register is RO when IRQ enabled\n");
+            return MEMTX_OK;
+        }
+
+        bank->gerror_irq_cfg0 = data & SMMU_GERROR_IRQ_CFG0_RESERVED;
         return MEMTX_OK;
     case A_STRTAB_BASE:
-        bank->strtab_base = data;
+        if (!smmu_strtab_base_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "STRTAB_BASE write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        /* Clear reserved bits according to spec */
+        bank->strtab_base = data & SMMU_STRTAB_BASE_RESERVED;
         return MEMTX_OK;
     case A_CMDQ_BASE:
-        bank->cmdq.base = data;
+        if (!smmu_cmdq_base_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "CMDQ_BASE write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        bank->cmdq.base = data & SMMU_QUEUE_BASE_RESERVED;
         bank->cmdq.log2size = extract64(bank->cmdq.base, 0, 5);
         if (bank->cmdq.log2size > SMMU_CMDQS) {
             bank->cmdq.log2size = SMMU_CMDQS;
         }
         return MEMTX_OK;
     case A_EVENTQ_BASE:
-        bank->eventq.base = data;
+        if (!smmu_eventq_base_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "EVENTQ_BASE write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        bank->eventq.base = data & SMMU_QUEUE_BASE_RESERVED;
         bank->eventq.log2size = extract64(bank->eventq.base, 0, 5);
         if (bank->eventq.log2size > SMMU_EVENTQS) {
             bank->eventq.log2size = SMMU_EVENTQS;
         }
         return MEMTX_OK;
     case A_EVENTQ_IRQ_CFG0:
-        bank->eventq_irq_cfg0 = data;
+        if (!smmu_eventq_irq_cfg_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "EVENTQ_IRQ_CFG0 write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        bank->eventq_irq_cfg0 = data & SMMU_EVENTQ_IRQ_CFG0_RESERVED;
         return MEMTX_OK;
     default:
         qemu_log_mask(LOG_UNIMP,
@@ -1608,7 +1761,15 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         bank->cr[1] = data;
         return MEMTX_OK;
     case A_CR2:
-        bank->cr[2] = data;
+        if (smmuv3_is_smmu_enabled(s, reg_sec_sid)) {
+            /* Allow write: SMMUEN is 0 in both CR0 and CR0ACK */
+            bank->cr[2] = data;
+        } else {
+            /* CONSTRAINED UNPREDICTABLE behavior: Ignore this write */
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "CR2 write ignored: register is read-only when "
+                          "CR0.SMMUEN or CR0ACK.SMMUEN is set\n");
+        }
         return MEMTX_OK;
     case A_IRQ_CTRL:
         bank->irq_ctrl = data;
@@ -1622,12 +1783,31 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         smmuv3_cmdq_consume(s);
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG0: /* 64b */
+        if (!smmu_gerror_irq_cfg_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "GERROR_IRQ_CFG0 write ignored: "
+                          "register is RO when IRQ enabled\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_GERROR_IRQ_CFG0_RESERVED;
         bank->gerror_irq_cfg0 = deposit64(bank->gerror_irq_cfg0, 0, 32, data);
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG0 + 4:
+        if (!smmu_gerror_irq_cfg_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "GERROR_IRQ_CFG0 + 4 write ignored: "
+                          "register is RO when IRQ enabled\n");
+            return MEMTX_OK;
+        }
+
         bank->gerror_irq_cfg0 = deposit64(bank->gerror_irq_cfg0, 32, 32, data);
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG1:
+        if (!smmu_gerror_irq_cfg_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "GERROR_IRQ_CFG1 write ignored: "
+                          "register is RO when IRQ enabled\n");
+            return MEMTX_OK;
+        }
+
         bank->gerror_irq_cfg1 = data;
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG2:
@@ -1644,12 +1824,32 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         }
         return MEMTX_OK;
     case A_STRTAB_BASE: /* 64b */
+        if (!smmu_strtab_base_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "STRTAB_BASE write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_STRTAB_BASE_RESERVED;
         bank->strtab_base = deposit64(bank->strtab_base, 0, 32, data);
         return MEMTX_OK;
     case A_STRTAB_BASE + 4:
+        if (!smmu_strtab_base_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "STRTAB_BASE + 4 write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_STRTAB_BASE_RESERVED;
         bank->strtab_base = deposit64(bank->strtab_base, 32, 32, data);
         return MEMTX_OK;
     case A_STRTAB_BASE_CFG:
+        if (!smmu_strtab_base_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "STRTAB_BASE_CFG write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
         bank->strtab_base_cfg = data;
         if (FIELD_EX32(data, STRTAB_BASE_CFG, FMT) == 1) {
             bank->sid_split = FIELD_EX32(data, STRTAB_BASE_CFG, SPLIT);
@@ -1657,6 +1857,13 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         }
         return MEMTX_OK;
     case A_CMDQ_BASE: /* 64b */
+        if (!smmu_cmdq_base_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "CMDQ_BASE write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_QUEUE_BASE_RESERVED;
         bank->cmdq.base = deposit64(bank->cmdq.base, 0, 32, data);
         bank->cmdq.log2size = extract64(bank->cmdq.base, 0, 5);
         if (bank->cmdq.log2size > SMMU_CMDQS) {
@@ -1664,6 +1871,13 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         }
         return MEMTX_OK;
     case A_CMDQ_BASE + 4: /* 64b */
+        if (!smmu_cmdq_base_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "CMDQ_BASE + 4 write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_QUEUE_BASE_RESERVED;
         bank->cmdq.base = deposit64(bank->cmdq.base, 32, 32, data);
         return MEMTX_OK;
     case A_CMDQ_PROD:
@@ -1671,9 +1885,22 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         smmuv3_cmdq_consume(s);
         return MEMTX_OK;
     case A_CMDQ_CONS:
+        if (!smmu_cmdqen_disabled(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "CMDQ_CONS write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
         bank->cmdq.cons = data;
         return MEMTX_OK;
     case A_EVENTQ_BASE: /* 64b */
+        if (!smmu_eventq_base_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "EVENTQ_BASE write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_QUEUE_BASE_RESERVED;
         bank->eventq.base = deposit64(bank->eventq.base, 0, 32, data);
         bank->eventq.log2size = extract64(bank->eventq.base, 0, 5);
         if (bank->eventq.log2size > SMMU_EVENTQS) {
@@ -1681,24 +1908,63 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         }
         return MEMTX_OK;
     case A_EVENTQ_BASE + 4:
+        if (!smmu_eventq_base_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "EVENTQ_BASE + 4 write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_QUEUE_BASE_RESERVED;
         bank->eventq.base = deposit64(bank->eventq.base, 32, 32, data);
         return MEMTX_OK;
     case A_EVENTQ_PROD:
+        if (!smmu_eventqen_disabled(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "EVENTQ_PROD write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
         bank->eventq.prod = data;
         return MEMTX_OK;
     case A_EVENTQ_CONS:
         bank->eventq.cons = data;
         return MEMTX_OK;
     case A_EVENTQ_IRQ_CFG0: /* 64b */
+        if (!smmu_eventq_irq_cfg_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "EVENTQ_IRQ_CFG0 write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_EVENTQ_IRQ_CFG0_RESERVED;
         bank->eventq_irq_cfg0 = deposit64(bank->eventq_irq_cfg0, 0, 32, data);
         return MEMTX_OK;
     case A_EVENTQ_IRQ_CFG0 + 4:
+        if (!smmu_eventq_irq_cfg_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "EVENTQ_IRQ_CFG0+4 write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_EVENTQ_IRQ_CFG0_RESERVED;
         bank->eventq_irq_cfg0 = deposit64(bank->eventq_irq_cfg0, 32, 32, data);
         return MEMTX_OK;
     case A_EVENTQ_IRQ_CFG1:
+        if (!smmu_eventq_irq_cfg_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "EVENTQ_IRQ_CFG1 write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
         bank->eventq_irq_cfg1 = data;
         return MEMTX_OK;
     case A_EVENTQ_IRQ_CFG2:
+        if (!smmu_eventq_irq_cfg_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "EVENTQ_IRQ_CFG2 write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
         bank->eventq_irq_cfg2 = data;
         return MEMTX_OK;
     default:
@@ -1743,6 +2009,12 @@ static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
 
     switch (offset) {
     case A_GERROR_IRQ_CFG0:
+        /* SMMU_(*_)GERROR_IRQ_CFG0 BOTH check SMMU_IDR0.MSI */
+        if (!smmu_msi_supported(s, reg_sec_sid)) {
+            *data = 0; /* RES0 */
+            return MEMTX_OK;
+        }
+
         *data = bank->gerror_irq_cfg0;
         return MEMTX_OK;
     case A_STRTAB_BASE:
@@ -1811,15 +2083,35 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
         *data = bank->gerrorn;
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG0: /* 64b */
+        if (!smmu_msi_supported(s, reg_sec_sid)) {
+            *data = 0; /* RES0 */
+            return MEMTX_OK;
+        }
+
         *data = extract64(bank->gerror_irq_cfg0, 0, 32);
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG0 + 4:
+        if (!smmu_msi_supported(s, reg_sec_sid)) {
+            *data = 0; /* RES0 */
+            return MEMTX_OK;
+        }
+
         *data = extract64(bank->gerror_irq_cfg0, 32, 32);
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG1:
+        if (!smmu_msi_supported(s, reg_sec_sid)) {
+            *data = 0; /* RES0 */
+            return MEMTX_OK;
+        }
+
         *data = bank->gerror_irq_cfg1;
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG2:
+        if (!smmu_msi_supported(s, reg_sec_sid)) {
+            *data = 0; /* RES0 */
+            return MEMTX_OK;
+        }
+
         *data = bank->gerror_irq_cfg2;
         return MEMTX_OK;
     case A_STRTAB_BASE: /* 64b */
-- 
2.34.1


