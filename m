Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD63CCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 15:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7xml-0002uL-NO; Sun, 12 Oct 2025 11:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xmh-0002kk-RL; Sun, 12 Oct 2025 11:14:55 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xme-0002Yd-SK; Sun, 12 Oct 2025 11:14:55 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCHj5vnxetoSFigAA--.19S2;
 Sun, 12 Oct 2025 23:14:47 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwBHq+jkxetoYXhMAA--.3042S3;
 Sun, 12 Oct 2025 23:14:44 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v3 18/21] hw/arm/smmuv3: Harden security checks in MMIO handlers
Date: Sun, 12 Oct 2025 23:14:37 +0800
Message-Id: <20251012151437.4130770-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwBHq+jkxetoYXhMAA--.3042S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQABBWjqskUBdAAAsF
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxGFykuF15Gw4xWrW5AFWfAFb_yoWrWF45pr
 4vgryYgr4DKF13XF4fJw4DA3WrCayvqrZxCrZxG3yUAayUGr4rJr48Ca4Yqr1DGry7Zws7
 GFySyrWfur1jy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

This patch hardens the security validation within the main MMIO
dispatcher functions (smmu_read_mmio and smmu_write_mmio).

First, accesses to the secure register space are now correctly gated by
whether the SECURE_IMPL feature is enabled in the model. This prevents
guest software from accessing the secure programming interface when it is
disabled, though some registers are exempt from this check as per the
architecture.

Second, the check for the input stream's security is made more robust.
It now validates not only the legacy MemTxAttrs.secure bit, but also
the .space field. This brings the SMMU's handling of security spaces
into full alignment with the PE.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 4ac7a2f3c7..c9c742c80b 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1458,6 +1458,12 @@ static bool smmu_eventq_irq_cfg_writable(SMMUv3State *s, SMMUSecSID sec_sid)
     return smmu_irq_ctl_evtq_irqen_disabled(s, sec_sid);
 }
 
+/* Check if the SMMU hardware itself implements secure state features */
+static inline bool smmu_hw_secure_implemented(SMMUv3State *s)
+{
+    return FIELD_EX32(s->bank[SMMU_SEC_SID_S].idr[1], S_IDR1, SECURE_IMPL);
+}
+
 static int smmuv3_cmdq_consume(SMMUv3State *s, SMMUSecSID sec_sid)
 {
     SMMUState *bs = ARM_SMMU(s);
@@ -1712,6 +1718,55 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, SMMUSecSID sec_sid)
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
+/* Helper function for Secure register access validation */
+static bool smmu_check_secure_access(SMMUv3State *s, MemTxAttrs attrs,
+                                     hwaddr offset, bool is_read)
+{   /* Check if the access is secure */
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
@@ -2058,6 +2113,10 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
      * statement to handle those specific security states.
      */
     if (offset >= SMMU_SECURE_REG_START) {
+        if (!smmu_check_secure_access(s, attrs, offset, false)) {
+            trace_smmuv3_write_mmio(offset, data, size, MEMTX_OK);
+            return MEMTX_OK;
+        }
         reg_sec_sid = SMMU_SEC_SID_S;
     }
 
@@ -2248,6 +2307,11 @@ static MemTxResult smmu_read_mmio(void *opaque, hwaddr offset, uint64_t *data,
     offset &= ~0x10000;
     SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
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


