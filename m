Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1637BC61DE1
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Feb 2026 10:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtk48-0001vK-B8; Sat, 21 Feb 2026 05:18:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtk42-0001pc-6a; Sat, 21 Feb 2026 05:18:18 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtk40-000203-57; Sat, 21 Feb 2026 05:18:17 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAHXdBlhplpgR9zAA--.3194S2;
 Sat, 21 Feb 2026 18:18:13 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwB3zepihplpd04cAA--.34374S3;
 Sat, 21 Feb 2026 18:18:10 +0800 (CST)
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
Subject: [RFC v4 21/31] hw/arm/smmuv3: Add access checks for GERROR_IRQ_CFG
 registers
Date: Sat, 21 Feb 2026 18:17:49 +0800
Message-Id: <20260221101749.2995372-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwB3zepihplpd04cAA--.34374S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQANBWmYzyUAPwAAst
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxXFW8Gw4UKF15ZF1fAw4xZwb_yoWruw1Dpr
 WIkwnIgrW5ta12qrZxA3Zxtw1rC3s2gF13try3KF9xtw1UurWYva10gFWSq3ZxWFyDG39r
 KF43Kr4fuwn0yw7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
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

Add helper functions smmu_msi_supported() and smmu_gerror_irq_cfg_writable()
to check accessibility of GERROR_IRQ_CFG registers. Reading returns RES0
when MSI is not supported. Writing is ignored when GERROR_IRQEN is set.

Additionally, mask reserved bits on writes using SMMU_GERROR_IRQ_CFG0_RESERVED.

Fixes: fae4be38b35d ("hw/arm/smmuv3: Implement MMIO write operations")
Fixes: 10a83cb9887e ("hw/arm/smmuv3: Skeleton")
Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 29e862b8ae3..eb9c6658a12 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1369,6 +1369,28 @@ static inline bool smmu_cmdq_stage2_supported(SMMUv3State *s, SMMUSecSID sec_sid
     return true;
 }
 
+/* Check if MSI is supported */
+static inline bool smmu_msi_supported(SMMUv3State *s)
+{
+    return FIELD_EX32(s->bank[SMMU_SEC_SID_NS].idr[0], IDR0, MSI);
+}
+
+/* Check if secure GERROR_IRQ_CFGx registers are writable */
+static inline bool smmu_gerror_irq_cfg_writable(SMMUv3State *s, SMMUSecSID sec_sid)
+{
+    if (!smmu_msi_supported(s)) {
+        return false;
+    }
+
+    /*
+     * Only writable if:
+     * - IRQ_CTRL.GERROR_IRQEN == 0 and
+     * - IRQ_CTRLACK.GERROR_IRQEN == 0.
+     * IRQ_CTRL and IRQ_CTRL_ACK are folded into a single backing field here.
+     */
+    return (FIELD_EX32(s->bank[sec_sid].irq_ctrl, IRQ_CTRL, GERROR_IRQEN) == 0);
+}
+
 static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
 {
     SMMUState *bs = ARM_SMMU(s);
@@ -1669,7 +1691,14 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
 
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
@@ -1731,12 +1760,31 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
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
@@ -1858,6 +1906,12 @@ static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
 
     switch (offset) {
     case A_GERROR_IRQ_CFG0:
+        /* SMMU_(*_)GERROR_IRQ_CFG0 BOTH check SMMU_IDR0.MSI */
+        if (!smmu_msi_supported(s)) {
+            *data = 0; /* RES0 */
+            return MEMTX_OK;
+        }
+
         *data = bank->gerror_irq_cfg0;
         return MEMTX_OK;
     case A_STRTAB_BASE:
@@ -1926,15 +1980,35 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
         *data = bank->gerrorn;
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG0: /* 64b */
+        if (!smmu_msi_supported(s)) {
+            *data = 0; /* RES0 */
+            return MEMTX_OK;
+        }
+
         *data = extract64(bank->gerror_irq_cfg0, 0, 32);
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG0 + 4:
+        if (!smmu_msi_supported(s)) {
+            *data = 0; /* RES0 */
+            return MEMTX_OK;
+        }
+
         *data = extract64(bank->gerror_irq_cfg0, 32, 32);
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG1:
+        if (!smmu_msi_supported(s)) {
+            *data = 0; /* RES0 */
+            return MEMTX_OK;
+        }
+
         *data = bank->gerror_irq_cfg1;
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG2:
+        if (!smmu_msi_supported(s)) {
+            *data = 0; /* RES0 */
+            return MEMTX_OK;
+        }
+
         *data = bank->gerror_irq_cfg2;
         return MEMTX_OK;
     case A_STRTAB_BASE: /* 64b */
-- 
2.34.1


