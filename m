Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99635C61DE2
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Feb 2026 10:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtk4T-0002lT-P4; Sat, 21 Feb 2026 05:18:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtk4L-0002eG-DZ; Sat, 21 Feb 2026 05:18:39 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtk4G-0002aH-MJ; Sat, 21 Feb 2026 05:18:34 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDHzpp1hplpwq9VBw--.5233S2;
 Sat, 21 Feb 2026 18:18:29 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwCH3+xxhplpek4cAA--.49459S3;
 Sat, 21 Feb 2026 18:18:26 +0800 (CST)
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
Subject: [RFC v4 23/31] hw/arm/smmuv3: Add access checks for CMDQ and EVENTQ
 registers
Date: Sat, 21 Feb 2026 18:18:23 +0800
Message-Id: <20260221101823.2996302-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCH3+xxhplpek4cAA--.49459S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQANBWmYzyUAQwAAsR
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3XFW7Ww18WrykuF1kJw43KFg_yoWfGFy5pr
 Z7GFy3Kr4aq3yIga93Aa1jya1UCw4xKrnFkr98Wwn5Ww1UGr4Dua18Wa4fXas3JF1UJw4k
 GwsxKFW3urW7C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add access control for command queue and event queue related registers
to ensure they can only be modified under proper conditions.

For command queue (CMDQ):
- smmu_cmdq_disabled_stable(): checks CMDQ bit in CR0/CR0ACK
- smmu_cmdq_base_writable(): checks IDR1.QUEUES_PRESET==0 and CMDQ disabled

For event queue (EVTQ):
- smmu_eventq_disabled_stable(): checks EVTQ bit in CR0/CR0ACK
- smmu_eventq_base_writable():checks IDR1.QUEUES_PRESET==0 and EVTQ disabled
- smmu_eventq_irq_cfg_writable(): checks MSI support and EVENTQ_IRQEN state

Additionally, mask reserved bits on writes using SMMU_QUEUE_BASE_RESERVED
for queue base registers and SMMU_EVENTQ_IRQ_CFG0_RESERVED for
EVENTQ_IRQ_CFG0.

Fixes: fae4be38b35d ("hw/arm/smmuv3: Implement MMIO write operations")
Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 154 insertions(+), 3 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 163c07adce4..9c09ea0716e 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1421,6 +1421,73 @@ static bool smmu_strtab_base_writable(SMMUv3State *s, SMMUSecSID sec_sid)
     return smmuv3_smmu_disabled_stable(s, sec_sid);
 }
 
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
+/* Check if CMDQ is disabled in stable status */
+static bool smmu_cmdq_disabled_stable(SMMUv3State *s, SMMUSecSID sec_sid)
+{
+    int cr0_cmdqen = smmuv3_get_cr0_cmdqen(s, sec_sid);
+    int cr0ack_cmdqen = smmuv3_get_cr0ack_cmdqen(s, sec_sid);
+    return (cr0_cmdqen == 0 && cr0ack_cmdqen == 0);
+}
+
+/* Check if CMDQ_BASE register is writable */
+static bool smmu_cmdq_base_writable(SMMUv3State *s, SMMUSecSID sec_sid)
+{
+    /* Use NS bank as it's designed for all security states */
+    if (FIELD_EX32(s->bank[SMMU_SEC_SID_NS].idr[1], IDR1, QUEUES_PRESET)) {
+        return false;
+    }
+
+    return smmu_cmdq_disabled_stable(s, sec_sid);
+}
+
+/* Check if EVENTQ is disabled in stable status */
+static bool smmu_eventq_disabled_stable(SMMUv3State *s, SMMUSecSID sec_sid)
+{
+    int cr0_eventqen = smmuv3_get_cr0_eventqen(s, sec_sid);
+    int cr0ack_eventqen = smmuv3_get_cr0ack_eventqen(s, sec_sid);
+    return (cr0_eventqen == 0 && cr0ack_eventqen == 0);
+}
+
+/* Check if EVENTQ_BASE register is writable */
+static bool smmu_eventq_base_writable(SMMUv3State *s, SMMUSecSID sec_sid)
+{
+    if (FIELD_EX32(s->bank[SMMU_SEC_SID_NS].idr[1], IDR1, QUEUES_PRESET)) {
+        return false;
+    }
+
+    return smmu_eventq_disabled_stable(s, sec_sid);
+}
+
+/* Check if EVENTQ_IRQ_CFGx is writable */
+static bool smmu_eventq_irq_cfg_writable(SMMUv3State *s, SMMUSecSID sec_sid)
+{
+    if (!smmu_msi_supported(s)) {
+        return false;
+    }
+
+    return (FIELD_EX32(s->bank[sec_sid].irq_ctrl, IRQ_CTRL, EVENTQ_IRQEN) == 0);
+}
+
 static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
 {
     SMMUState *bs = ARM_SMMU(s);
@@ -1741,21 +1808,39 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
         bank->strtab_base = data & SMMU_STRTAB_BASE_RESERVED;
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
@@ -1880,6 +1965,13 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         }
         break;
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
@@ -1887,6 +1979,13 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         }
         break;
     case A_CMDQ_BASE + 4: /* 64b */
+        if (!smmu_cmdq_base_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "CMDQ_BASE + 4 write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_QUEUE_BASE_RESERVED;
         bank->cmdq.base = deposit64(bank->cmdq.base, 32, 32, data);
         break;
     case A_CMDQ_PROD:
@@ -1894,9 +1993,22 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         smmuv3_cmdq_consume(s, &local_err, reg_sec_sid);
         break;
     case A_CMDQ_CONS:
+        if (!smmu_cmdq_disabled_stable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "CMDQ_CONS write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
         bank->cmdq.cons = data;
         break;
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
@@ -1904,24 +2016,63 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         }
         break;
     case A_EVENTQ_BASE + 4:
+        if (!smmu_eventq_base_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "EVENTQ_BASE + 4 write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_QUEUE_BASE_RESERVED;
         bank->eventq.base = deposit64(bank->eventq.base, 32, 32, data);
         break;
     case A_EVENTQ_PROD:
+        if (!smmu_eventq_disabled_stable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "EVENTQ_PROD write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
         bank->eventq.prod = data;
         break;
     case A_EVENTQ_CONS:
         bank->eventq.cons = data;
         break;
     case A_EVENTQ_IRQ_CFG0: /* 64b */
+        if (!smmu_eventq_irq_cfg_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "EVENTQ_IRQ_CFG0 write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_EVENTQ_IRQ_CFG0_RESERVED;
         bank->eventq_irq_cfg0 = deposit64(bank->eventq_irq_cfg0, 0, 32, data);
         break;
     case A_EVENTQ_IRQ_CFG0 + 4:
+        if (!smmu_eventq_irq_cfg_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "EVENTQ_IRQ_CFG0+4 write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_EVENTQ_IRQ_CFG0_RESERVED;
         bank->eventq_irq_cfg0 = deposit64(bank->eventq_irq_cfg0, 32, 32, data);
         break;
     case A_EVENTQ_IRQ_CFG1:
+        if (!smmu_eventq_irq_cfg_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "EVENTQ_IRQ_CFG1 write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
         bank->eventq_irq_cfg1 = data;
         break;
     case A_EVENTQ_IRQ_CFG2:
+        if (!smmu_eventq_irq_cfg_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "EVENTQ_IRQ_CFG2 write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
         bank->eventq_irq_cfg2 = data;
         break;
     default:
-- 
2.34.1


