Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393C0606A332
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSGUB-0001Iw-Sl; Sat, 14 Nov 2026 11:20:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGTx-0000b7-6a; Sat, 14 Nov 2026 11:20:08 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGTt-0007R8-Og; Sat, 14 Nov 2026 11:19:59 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwCXj8MoivhqcGIqBg--.60519S2; 
 Sun, 15 Nov 2026 00:19:52 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwS3Ilivhq+9v6AA--.26908S3;
 Sun, 15 Nov 2026 00:19:50 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v6 29/35] hw/arm/smmuv3: Harden security checks in MMIO
 handlers
Date: Sun, 15 Nov 2026 00:19:49 +0800
Message-Id: <20261114161949.3648535-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
References: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwS3Ilivhq+9v6AA--.26908S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWr3ZUsBlAAAsx
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxZryfCFWrKr15CFW3Gr15Arb_yoW5KFW3pr
 WkC34YgrWDG3W3Aa93tw4kAF1fK3ykWrnxJr93G34UuayUtr4rXF18C34YgFnrGFyUZan7
 Wr4fAr4fCw12y3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 hw/arm/smmuv3.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 5c3d8b4bd98..0c367dc5221 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1455,6 +1455,12 @@ static bool smmu_strtab_base_writable(SMMUv3State *s, SMMUSecSID sec_sid)
     return !smmu_enabled(s, sec_sid);
 }
 
+/* Check if the SMMU hardware itself implements Secure state features */
+static inline bool smmu_hw_secure_implemented(SMMUv3State *s)
+{
+    return FIELD_EX32(s->bank[SMMU_SEC_SID_S].idr[1], S_IDR1, SECURE_IMPL);
+}
+
 static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
 {
     SMMUState *bs = ARM_SMMU(s);
@@ -1771,6 +1777,37 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
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
+    /* Check if the access is Secure */
+    if (!(attrs.space == ARMSS_Secure ||
+          attrs.secure == 1)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "%s: Non-secure %s at offset 0x%" PRIx64 "\n",
+            __func__, is_read ? "read" : "write", offset);
+        return false;
+    }
+
+    /* Check if the Secure state is implemented. */
+    if (!smmu_hw_secure_implemented(s)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "%s: Secure %s at offset 0x%" PRIx64
+            ": Secure state is not implemented\n",
+            __func__, is_read ? "read" : "write", offset);
+        return false;
+    }
+    return true;
+}
+
 static bool smmuv3_reg_is_raz_wi(hwaddr offset, SMMUSecSID reg_sec_sid)
 {
     switch (offset) {
@@ -2065,6 +2102,11 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
      * translate the Secure window to its bank-local register offsets.
      */
     if (offset >= SMMU_SECURE_REG_START) {
+        if (!smmu_check_secure_access(s, attrs, offset, false)) {
+            trace_smmuv3_write_mmio(offset, data, size, MEMTX_OK);
+            /* WI */
+            return MEMTX_OK;
+        }
         reg_sec_sid = SMMU_SEC_SID_S;
         offset -= SMMU_SECURE_REG_START;
     }
@@ -2244,6 +2286,12 @@ static MemTxResult smmu_read_mmio(void *opaque, hwaddr offset, uint64_t *data,
     /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
     offset &= ~0x10000;
     if (offset >= SMMU_SECURE_REG_START) {
+        if (!smmu_check_secure_access(s, attrs, offset, true)) {
+            /* RAZ */
+            *data = 0;
+            trace_smmuv3_read_mmio(offset, *data, size, MEMTX_OK);
+            return MEMTX_OK;
+        }
         reg_sec_sid = SMMU_SEC_SID_S;
         offset -= SMMU_SECURE_REG_START;
     }
-- 
2.34.1


