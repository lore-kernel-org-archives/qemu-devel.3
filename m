Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FACC61DE1
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Feb 2026 10:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtk4C-0002B5-VM; Sat, 21 Feb 2026 05:18:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtk49-0001xu-9h; Sat, 21 Feb 2026 05:18:26 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtk47-0002Me-Jh; Sat, 21 Feb 2026 05:18:25 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBXXJhshplpo69VBw--.3951S2;
 Sat, 21 Feb 2026 18:18:20 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwAnge5rhplpeU4cAA--.54989S3;
 Sat, 21 Feb 2026 18:18:19 +0800 (CST)
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
Subject: [RFC v4 22/31] hw/arm/smmuv3: Add access checks for STRTAB_BASE and
 CR2 registers
Date: Sat, 21 Feb 2026 18:18:16 +0800
Message-Id: <20260221101816.2996053-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAnge5rhplpeU4cAA--.54989S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQANBWmYzyUAQQAAsT
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxZFW8JrWfZr1kGrW3GFyDKFg_yoWruFyxpr
 Z7G34agr47tayIgF9xAa1Yyws8GayvgF1UJry3GF97Zw1UJry5XF4rWrWfX3WkXFyUJws7
 Ga1akay3urW8trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

Add access control for SMMU_STRTAB_BASE and SMMU_CR2 registers to
ensure they can only be modified when the SMMU is disabled.

This implements:
- smmuv3_smmu_disabled_stable(): Check whether the SMMU is in a stable
   disabled state (CR0.SMMUEN == 0 and CR0ACK.SMMUEN == 0);
- smmu_strtab_base_writable(): returns true only when IDR1.TABLES_PRESET==0
   and SMMU is completely disabled.

Additionally, mask reserved bits on writes to SMMU_STRTAB_BASE using
SMMU_STRTAB_BASE_RESERVED.

Fixes: fae4be38b35d ("hw/arm/smmuv3: Implement MMIO write operations")
Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index eb9c6658a12..163c07adce4 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1391,6 +1391,36 @@ static inline bool smmu_gerror_irq_cfg_writable(SMMUv3State *s, SMMUSecSID sec_s
     return (FIELD_EX32(s->bank[sec_sid].irq_ctrl, IRQ_CTRL, GERROR_IRQEN) == 0);
 }
 
+static inline int smmuv3_get_cr0ack_smmuen(SMMUv3State *s, SMMUSecSID sec_sid)
+{
+    /*
+     * CR0, CR0ACK, S_CR0 and S_CR0ACK are bit-layout compatible, so we reuse
+     * the CR0 field definitions and only switch banks via sec_sid to reduce
+     * code duplication. Also the other bits in CR0/CR0ACK are relevant here.
+     */
+    return FIELD_EX32(s->bank[sec_sid].cr0ack, CR0, SMMUEN);
+}
+
+/* Check if SMMU is disabled in stable status */
+static inline bool smmuv3_smmu_disabled_stable(SMMUv3State *s, SMMUSecSID sec_sid)
+{
+    int cr0_smmuen = smmu_enabled(s, sec_sid);
+    int cr0ack_smmuen = smmuv3_get_cr0ack_smmuen(s, sec_sid);
+    return (cr0_smmuen == 0 && cr0ack_smmuen == 0);
+}
+
+/* Check if STRTAB_BASE register is writable */
+static bool smmu_strtab_base_writable(SMMUv3State *s, SMMUSecSID sec_sid)
+{
+    /* Use NS bank as it's designed for all security states */
+    if (FIELD_EX32(s->bank[SMMU_SEC_SID_NS].idr[1], IDR1, TABLES_PRESET)) {
+        return false;
+    }
+
+    /* Check SMMUEN conditions for the specific security domain */
+    return smmuv3_smmu_disabled_stable(s, sec_sid);
+}
+
 static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
 {
     SMMUState *bs = ARM_SMMU(s);
@@ -1701,7 +1731,14 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
         bank->gerror_irq_cfg0 = data & SMMU_GERROR_IRQ_CFG0_RESERVED;
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
         bank->cmdq.base = data;
@@ -1746,7 +1783,15 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         bank->cr[1] = data;
         break;
     case A_CR2:
-        bank->cr[2] = data;
+        if (smmuv3_smmu_disabled_stable(s, reg_sec_sid)) {
+            /* Allow write: SMMUEN is 0 in both CR0 and CR0ACK */
+            bank->cr[2] = data;
+        } else {
+            /* CONSTRAINED UNPREDICTABLE behavior: Ignore this write */
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "CR2 write ignored: register is read-only when "
+                          "CR0.SMMUEN or CR0ACK.SMMUEN is set\n");
+        }
         break;
     case A_IRQ_CTRL:
         bank->irq_ctrl = data;
@@ -1802,12 +1847,32 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         }
         break;
     case A_STRTAB_BASE: /* 64b */
+        if (!smmu_strtab_base_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "STRTAB_BASE write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_STRTAB_BASE_RESERVED;
         bank->strtab_base = deposit64(bank->strtab_base, 0, 32, data);
         break;
     case A_STRTAB_BASE + 4:
+        if (!smmu_strtab_base_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "STRTAB_BASE + 4 write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_STRTAB_BASE_RESERVED;
         bank->strtab_base = deposit64(bank->strtab_base, 32, 32, data);
         break;
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
-- 
2.34.1


