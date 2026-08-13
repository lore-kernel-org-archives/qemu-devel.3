Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0D4C5DF67
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuYGj-000468-2J; Thu, 13 Aug 2026 12:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYGG-0003hx-Tx; Thu, 13 Aug 2026 12:26:34 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYGF-0001Kt-87; Thu, 13 Aug 2026 12:26:32 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwAX+EA08H1qQiRvAw--.16386S2; 
 Fri, 14 Aug 2026 00:26:28 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwBXQw8H1q7SwjAA--.59184S4;
 Fri, 14 Aug 2026 00:26:25 +0800 (CST)
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
Subject: [RFC v5 22/28] hw/arm/smmuv3: Harden security checks in MMIO handlers
Date: Fri, 14 Aug 2026 00:26:21 +0800
Message-Id: <20260813162624.2809349-2-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwBXQw8H1q7SwjAA--.59184S4
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAGBWp8yc0HsAAAsn
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxZryfCFy3AFW3Zr4UZw1DJrb_yoWrWr17pr
 WkCw1YgrWDG3W3AFs3ta1DA3WrK3ykXr13J3sxG34UZayUtw4rXF10k34YgFsrWryUZws7
 Wr4fCr4xCr1jy3DanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

This patch hardens the security validation within the main MMIO
dispatcher functions (smmu_read_mmio and smmu_write_mmio).

First, accesses to the Secure register space are gated by whether
SECURE_IMPL is enabled. When it is disabled, all SMMU_S_* registers are
read-as-zero and write-ignored.

Second, the check for the input stream's security is made more robust.
It now validates not only the legacy MemTxAttrs.secure bit, but also
the .space field. This improves compatibility with Arm security space
handling.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/smmuv3.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index dc3fa618883..e5f0bc18415 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1605,6 +1605,12 @@ static bool smmu_eventq_irq_cfg_writable(SMMUv3State *s, SMMUSecSID sec_sid)
     return smmu_irq_cfg_writable(s, sec_sid, SMMU_IRQ_EVTQ);
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
@@ -1905,6 +1911,38 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
     return 0;
 }
 
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
+    /* Check if the secure state is implemented. */
+    if (!smmu_hw_secure_implemented(s)) {
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
@@ -2272,6 +2310,18 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
      * translate the Secure window to its bank-local register offsets.
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
         offset -= SMMU_SECURE_REG_START;
     }
@@ -2508,6 +2558,11 @@ static MemTxResult smmu_read_mmio(void *opaque, hwaddr offset, uint64_t *data,
     /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
     offset &= ~0x10000;
     if (offset >= SMMU_SECURE_REG_START) {
+        if (!smmu_check_secure_access(s, attrs, offset, true)) {
+            *data = 0;
+            trace_smmuv3_read_mmio(offset, *data, size, MEMTX_OK);
+            return MEMTX_OK;
+        }
         reg_sec_sid = SMMU_SEC_SID_S;
         offset -= SMMU_SECURE_REG_START;
     }
-- 
2.34.1


