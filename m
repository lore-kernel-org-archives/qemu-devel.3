Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8ACC5DF67
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuYGA-0003VB-I8; Thu, 13 Aug 2026 12:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYFu-0003G8-NJ; Thu, 13 Aug 2026 12:26:10 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYFq-0001B4-O6; Thu, 13 Aug 2026 12:26:08 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwBXWnYb8H1qBSNvAw--.34321S2; 
 Fri, 14 Aug 2026 00:26:03 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8Dw4XUX8H1q5iwjAA--.55915S3;
 Fri, 14 Aug 2026 00:25:59 +0800 (CST)
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
Subject: [RFC v5 16/28] hw/arm/smmuv3: Add access checks for GERROR_IRQ_CFG
 registers
Date: Fri, 14 Aug 2026 00:25:54 +0800
Message-Id: <20260813162558.2808607-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dw4XUX8H1q5iwjAA--.55915S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAGBWp8yc0HpgAAsx
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3WF1rAFWkAF4UtryrZr4DCFg_yoWxJrW8pr
 yxK3sIgr4Uta1IqFZaka1Yyw1ru3s7tF15tryakFnxJw1UCrWYyw40gFWSqwnrWFykWws7
 ta13Kr48urn8Ar7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

Add helpers that separate IRQ_CFG register presence from the runtime
IRQ enable guard. The Non-secure and Secure GERROR_IRQ_CFG register sets
both use SMMU_IDR0.MSI for presence, while writability additionally
requires GERROR_IRQEN to be clear. IRQ_CTRL and IRQ_CTRLACK share one
synchronous backing field in the current model.

Reads return RES0 when the register set is absent. Writes are ignored
when it is absent or GERROR_IRQEN is set. Apply the same checks to all
three GERROR_IRQ_CFG registers and mask reserved bits in CFG0 and CFG2.

Fixes: fae4be38b35d ("hw/arm/smmuv3: Implement MMIO write operations")
Fixes: 10a83cb9887e ("hw/arm/smmuv3: Skeleton")
Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/smmuv3.c | 118 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 116 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 47f0d575817..628911d3f21 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1428,6 +1428,62 @@ smmu_cmdq_stage2_supported(SMMUv3State *s, SMMUSecSID sec_sid)
     return true;
 }
 
+/* Check whether the selected IRQ_CFG register set is present. */
+static bool smmu_irq_cfg_present(SMMUv3State *s, SMMUSecSID sec_sid,
+                                 SMMUIrq irq)
+{
+    SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
+
+    switch (irq) {
+    case SMMU_IRQ_GERROR:
+        switch (sec_sid) {
+        case SMMU_SEC_SID_NS:
+        case SMMU_SEC_SID_S:
+            return FIELD_EX32(bank->idr[0], IDR0, MSI);
+        case SMMU_SEC_SID_NUM:
+            g_assert_not_reached();
+        }
+        break;
+    case SMMU_IRQ_EVTQ:
+    case SMMU_IRQ_PRIQ:
+    case SMMU_IRQ_CMD_SYNC:
+        g_assert_not_reached();
+    }
+
+    g_assert_not_reached();
+}
+
+/* Check whether the selected IRQ_CFG register set is writable. */
+static bool smmu_irq_cfg_writable(SMMUv3State *s, SMMUSecSID sec_sid,
+                                  SMMUIrq irq)
+{
+    SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
+    uint32_t irqen;
+
+    if (!smmu_irq_cfg_present(s, sec_sid, irq)) {
+        return false;
+    }
+
+    switch (irq) {
+    case SMMU_IRQ_GERROR:
+        irqen = FIELD_EX32(bank->irq_ctrl, IRQ_CTRL, GERROR_IRQEN);
+        break;
+    case SMMU_IRQ_EVTQ:
+    case SMMU_IRQ_PRIQ:
+    case SMMU_IRQ_CMD_SYNC:
+        g_assert_not_reached();
+    }
+
+    /* IRQ_CTRL and IRQ_CTRLACK share one synchronous backing field. */
+    return irqen == 0;
+}
+
+static bool
+smmu_gerror_irq_cfg_writable(SMMUv3State *s, SMMUSecSID sec_sid)
+{
+    return smmu_irq_cfg_writable(s, sec_sid, SMMU_IRQ_GERROR);
+}
+
 static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
 {
     SMMUState *bs = ARM_SMMU(s);
@@ -1735,7 +1791,14 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
 
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
         bank->strtab_base = data;
@@ -1803,16 +1866,42 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         smmuv3_cmdq_consume(s, &local_err, reg_sec_sid);
         break;
     case A_GERROR_IRQ_CFG0: /* 64b */
+        if (!smmu_gerror_irq_cfg_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "GERROR_IRQ_CFG0 write ignored: "
+                          "register is RO when IRQ enabled\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_GERROR_IRQ_CFG0_RESERVED;
         bank->gerror_irq_cfg0 = deposit64(bank->gerror_irq_cfg0, 0, 32, data);
         break;
     case A_GERROR_IRQ_CFG0 + 4:
+        if (!smmu_gerror_irq_cfg_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "GERROR_IRQ_CFG0 + 4 write ignored: "
+                          "register is RO when IRQ enabled\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_GERROR_IRQ_CFG0_RESERVED >> 32;
         bank->gerror_irq_cfg0 = deposit64(bank->gerror_irq_cfg0, 32, 32, data);
         break;
     case A_GERROR_IRQ_CFG1:
+        if (!smmu_gerror_irq_cfg_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "GERROR_IRQ_CFG1 write ignored: "
+                          "register is RO when IRQ enabled\n");
+            return MEMTX_OK;
+        }
+
         bank->gerror_irq_cfg1 = data;
         break;
     case A_GERROR_IRQ_CFG2:
-        bank->gerror_irq_cfg2 = data;
+        if (!smmu_gerror_irq_cfg_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "GERROR_IRQ_CFG2 write ignored: "
+                          "register is RO when IRQ enabled\n");
+            return MEMTX_OK;
+        }
+
+        bank->gerror_irq_cfg2 = data & SMMU_GERROR_IRQ_CFG2_RESERVED;
         break;
     case A_GBPA:
         /*
@@ -1938,6 +2027,11 @@ static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
 
     switch (offset) {
     case A_GERROR_IRQ_CFG0:
+        if (!smmu_irq_cfg_present(s, reg_sec_sid, SMMU_IRQ_GERROR)) {
+            *data = 0; /* RES0 */
+            return MEMTX_OK;
+        }
+
         *data = bank->gerror_irq_cfg0;
         return MEMTX_OK;
     case A_STRTAB_BASE:
@@ -2006,15 +2100,35 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
         *data = bank->gerrorn;
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG0: /* 64b */
+        if (!smmu_irq_cfg_present(s, reg_sec_sid, SMMU_IRQ_GERROR)) {
+            *data = 0; /* RES0 */
+            return MEMTX_OK;
+        }
+
         *data = extract64(bank->gerror_irq_cfg0, 0, 32);
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG0 + 4:
+        if (!smmu_irq_cfg_present(s, reg_sec_sid, SMMU_IRQ_GERROR)) {
+            *data = 0; /* RES0 */
+            return MEMTX_OK;
+        }
+
         *data = extract64(bank->gerror_irq_cfg0, 32, 32);
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG1:
+        if (!smmu_irq_cfg_present(s, reg_sec_sid, SMMU_IRQ_GERROR)) {
+            *data = 0; /* RES0 */
+            return MEMTX_OK;
+        }
+
         *data = bank->gerror_irq_cfg1;
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG2:
+        if (!smmu_irq_cfg_present(s, reg_sec_sid, SMMU_IRQ_GERROR)) {
+            *data = 0; /* RES0 */
+            return MEMTX_OK;
+        }
+
         *data = bank->gerror_irq_cfg2;
         return MEMTX_OK;
     case A_STRTAB_BASE: /* 64b */
-- 
2.34.1


