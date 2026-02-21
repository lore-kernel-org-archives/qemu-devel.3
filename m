Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2CFC61DE1
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Feb 2026 10:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtk4r-0003VR-LL; Sat, 21 Feb 2026 05:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtk4d-0003Bi-4e; Sat, 21 Feb 2026 05:18:57 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtk4b-0003Mt-0g; Sat, 21 Feb 2026 05:18:54 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCnftGIhplp3x9zAA--.745S2;
 Sat, 21 Feb 2026 18:18:48 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDXMO6Ehplpf04cAA--.34422S3;
 Sat, 21 Feb 2026 18:18:45 +0800 (CST)
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
Subject: [RFC v4 26/31] hw/arm/smmuv3: Harden security checks in MMIO handlers
Date: Sat, 21 Feb 2026 18:18:42 +0800
Message-Id: <20260221101842.2996840-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDXMO6Ehplpf04cAA--.34422S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQANBWmYzyUASQAAsb
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxGFykuF15Gw43Aw48Jw1kKrg_yoWrKr47pr
 4kCr15Wr4DKa13Xan3Jw4DA3WFk3ykJrZxCrZxG3yUZayUGrs5JF10ka4YgFyDGryUZws7
 WF4SyrWfur1jy3DanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

This patch hardens the security validation within the main MMIO
dispatcher functions (smmu_read_mmio and smmu_write_mmio).

First, accesses to the secure register space are now correctly gated by
whether the SECURE_IMPL feature is enabled in the model. This prevents
guest software from accessing the secure programming interface when it is
disabled, though some registers are exempt from this check as per the
architecture.

Second, the check for the input stream's security is made more robust.
It now validates not only the legacy MemTxAttrs.secure bit, but also
the .space field. This improves compatibility with Arm security space
handling.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 6fd664a000f..0b8ea922851 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1503,6 +1503,12 @@ static bool smmu_eventq_irq_cfg_writable(SMMUv3State *s, SMMUSecSID sec_sid)
     return (FIELD_EX32(s->bank[sec_sid].irq_ctrl, IRQ_CTRL, EVENTQ_IRQEN) == 0);
 }
 
+/* Check if the SMMU hardware itself implements secure state features */
+static inline bool smmu_hw_secure_implemented(SMMUv3State *s)
+{
+    return FIELD_EX32(s->bank[SMMU_SEC_SID_S].idr[1], S_IDR1, SECURE_IMPL);
+}
+
 static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
 {
     SMMUState *bs = ARM_SMMU(s);
@@ -1795,6 +1801,63 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
     return 0;
 }
 
+/*
+ * Check if a register is exempt from the secure implementation check.
+ *
+ * The SMMU architecture specifies that certain secure registers, such as
+ * the secure Event Queue IRQ configuration registers, must be accessible
+ * even if the full secure hardware is not implemented. This function
+ * identifies those registers.
+ *
+ * Returns true if the register is exempt, false otherwise.
+ */
+static bool is_secure_impl_exempt_reg(hwaddr offset)
+{
+    switch (offset) {
+    case A_S_EVENTQ_IRQ_CFG0:
+    case A_S_EVENTQ_IRQ_CFG1:
+    case A_S_EVENTQ_IRQ_CFG2:
+        return true;
+    default:
+        return false;
+    }
+}
+
+/*
+ * Helper function for Secure register access validation.
+ *
+ * Follow S_IDR1.SECURE_IMPL accessibility rules for SMMU_S_*:
+ *  - SECURE_IMPL == 0: Secure state is not implemented; SMMU_S_* are RAZ/WI to
+ *    all accesses.
+ *  - SECURE_IMPL == 1: Non-secure accesses to SMMU_S_* are RAZ/WI.
+ */
+static bool smmu_check_secure_access(SMMUv3State *s, MemTxAttrs attrs,
+                                     hwaddr offset, bool is_read)
+{
+    /* Check if the access is secure */
+    if (!(attrs.space == ARMSS_Secure ||
+          attrs.secure == 1)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "%s: Non-secure %s attempt at offset 0x%" PRIx64 " (%s)\n",
+            __func__, is_read ? "read" : "write", offset,
+            is_read ? "RAZ" : "WI");
+        return false;
+    }
+
+    /*
+     * Check if the secure state is implemented. Some registers are exempted
+     * from this check.
+     */
+    if (!is_secure_impl_exempt_reg(offset) && !smmu_hw_secure_implemented(s)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "%s: Secure %s attempt at offset 0x%" PRIx64 ". But Secure state "
+            "is not implemented (RES0)\n",
+            __func__, is_read ? "read" : "write", offset);
+        return false;
+    }
+    return true;
+}
+
 static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
                                 uint64_t data, MemTxAttrs attrs,
                                 SMMUSecSID reg_sec_sid)
@@ -2140,6 +2203,18 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
      * the same layout but is mapped starting at 0x8000(SMMU_SECURE_REG_START)
      */
     if (offset >= SMMU_SECURE_REG_START) {
+        if (!smmu_check_secure_access(s, attrs, offset, false)) {
+            trace_smmuv3_write_mmio(offset, data, size, MEMTX_OK);
+            /*
+             * RAZ/WI/RES0 are deterministic register-level behaviors and do not
+             * imply a bus protocol error or abort. Therefore we acknowledge the
+             * MMIO transaction with MEMTX_OK and implement
+             * "Read-As-Zero / Write-Ignored" in the register model, instead of
+             * returning MEMTX_*_ERROR which is reserved for real decode/access
+             * failures.
+             */
+            return MEMTX_OK;
+        }
         reg_sec_sid = SMMU_SEC_SID_S;
     }
 
@@ -2334,6 +2409,11 @@ static MemTxResult smmu_read_mmio(void *opaque, hwaddr offset, uint64_t *data,
     /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
     offset &= ~0x10000;
     if (offset >= SMMU_SECURE_REG_START) {
+        if (!smmu_check_secure_access(s, attrs, offset, true)) {
+            *data = 0;
+            trace_smmuv3_read_mmio(offset, *data, size, MEMTX_OK);
+            return MEMTX_OK;
+        }
         reg_sec_sid = SMMU_SEC_SID_S;
     }
 
-- 
2.34.1


