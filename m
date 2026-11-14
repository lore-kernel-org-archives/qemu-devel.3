Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A62E606A331
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSGUO-0002ZP-JX; Sat, 14 Nov 2026 11:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGTm-0000Yd-AR; Sat, 14 Nov 2026 11:19:57 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGTi-0006xE-E7; Sat, 14 Nov 2026 11:19:48 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwAHDcEfivhq4WEqBg--.46267S2; 
 Sun, 15 Nov 2026 00:19:43 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwR3Ydivhq+dv6AA--.34443S3;
 Sun, 15 Nov 2026 00:19:41 +0800 (CST)
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
Subject: [PATCH v6 26/35] hw/arm/smmuv3: Determine register bank from MMIO
 offset
Date: Sun, 15 Nov 2026 00:19:40 +0800
Message-Id: <20261114161940.3648277-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
References: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwR3Ydivhq+dv6AA--.34443S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWr3ZUsBkAAAs1
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxKry8XFyktr47uw18AF4xWFg_yoWxXr45pr
 WkJryFgr1qka1SqFsxJa1UC3WrZwn2gr1ayrnxK34UC3y0yw1xXFW0934furyDuFyUArs5
 WrW5Gr43WrWqy3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Modify the main MMIO handlers to select the target register bank from the
memory-mapped offset.

Offsets in the Secure register window select SMMU_SEC_SID_S and are
normalized by subtracting SMMU_SECURE_REG_START. Other offsets select the
Non-secure bank. Pass the selected SEC_SID to the register access helpers,
where the normalized bank-local offset identifies the register.

Keep bank-specific differences explicit, such as S_IDR5 being unimplemented.
This patch implements Non-secure and Secure bank dispatch and prepares for
later access checks; Realm and Root programming interfaces are not modeled.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmuv3.c | 84 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 70 insertions(+), 14 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 138ca178a1a..54647964c21 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1742,10 +1742,25 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
     return 0;
 }
 
+static bool smmuv3_reg_is_raz_wi(hwaddr offset, SMMUSecSID reg_sec_sid)
+{
+    switch (offset) {
+    case A_IDR5:
+    case A_IIDR:
+    case A_STATUSR:
+    case A_IDREGS ... A_IDREGS + 0x2f:
+        return reg_sec_sid != SMMU_SEC_SID_NS;
+    case A_AIDR:
+        return reg_sec_sid == SMMU_SEC_SID_S;
+    default:
+        return false;
+    }
+}
+
 static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
-                               uint64_t data, MemTxAttrs attrs)
+                                uint64_t data, MemTxAttrs attrs,
+                                SMMUSecSID reg_sec_sid)
 {
-    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
 
     switch (offset) {
@@ -1798,16 +1813,20 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
 }
 
 static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
-                               uint64_t data, MemTxAttrs attrs)
+                               uint64_t data, MemTxAttrs attrs,
+                               SMMUSecSID reg_sec_sid)
 {
     Error *local_err = NULL;
-    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
 
     switch (offset) {
     case A_CR0:
+        if (reg_sec_sid == SMMU_SEC_SID_S) {
+            data &= ~SMMU_S_CR0_RESERVED;
+        }
         bank->cr[0] = data;
-        bank->cr0ack = data & ~SMMU_CR0_RESERVED;
+        bank->cr0ack = data & ~(reg_sec_sid == SMMU_SEC_SID_S ?
+                               SMMU_S_CR0_RESERVED : SMMU_CR0_RESERVED);
         /* in case the command queue has been enabled */
         smmuv3_cmdq_consume(s, &local_err, reg_sec_sid);
         if (local_err) {
@@ -1850,7 +1869,9 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         if (data & R_GBPA_UPDATE_MASK) {
             /* Ignore update bit as write is synchronous. */
             bank->gbpa = data & ~R_GBPA_UPDATE_MASK;
-            smmuv3_accel_attach_gbpa_hwpt(s, &local_err);
+            if (reg_sec_sid == SMMU_SEC_SID_NS) {
+                smmuv3_accel_attach_gbpa_hwpt(s, &local_err);
+            }
         }
         break;
     case A_STRTAB_BASE: /* 64b */
@@ -1991,16 +2012,35 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
     SMMUState *sys = opaque;
     SMMUv3State *s = ARM_SMMUV3(sys);
     MemTxResult r;
+    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
 
     /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
     offset &= ~0x10000;
 
+    /*
+     * Dispatch the Non-secure window directly. After access validation,
+     * translate the Secure window to its bank-local register offsets.
+     */
+    if (offset >= SMMU_SECURE_REG_START) {
+        reg_sec_sid = SMMU_SEC_SID_S;
+        offset -= SMMU_SECURE_REG_START;
+    }
+
+    if (smmuv3_reg_is_raz_wi(offset, reg_sec_sid)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to undefined register: bank=%d "
+                      "offset=0x%" PRIx64 " (WI)\n",
+                      __func__, reg_sec_sid, offset);
+        trace_smmuv3_write_mmio(offset, data, size, MEMTX_OK);
+        return MEMTX_OK;
+    }
+
     switch (size) {
     case 8:
-        r = smmu_writell(s, offset, data, attrs);
+        r = smmu_writell(s, offset, data, attrs, reg_sec_sid);
         break;
     case 4:
-        r = smmu_writel(s, offset, data, attrs);
+        r = smmu_writel(s, offset, data, attrs, reg_sec_sid);
         break;
     default:
         r = MEMTX_ERROR;
@@ -2012,9 +2052,9 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
 }
 
 static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
-                               uint64_t *data, MemTxAttrs attrs)
+                               uint64_t *data, MemTxAttrs attrs,
+                               SMMUSecSID reg_sec_sid)
 {
-    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
 
     switch (offset) {
@@ -2043,9 +2083,9 @@ static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
 }
 
 static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
-                              uint64_t *data, MemTxAttrs attrs)
+                              uint64_t *data, MemTxAttrs attrs,
+                              SMMUSecSID reg_sec_sid)
 {
-    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
 
     switch (offset) {
@@ -2135,6 +2175,7 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
         *data = 0;
         return MEMTX_OK;
     default:
+    unhandled:
         *data = 0;
         qemu_log_mask(LOG_UNIMP,
                       "%s unhandled 32-bit access at 0x%"PRIx64" (RAZ)\n",
@@ -2149,16 +2190,31 @@ static MemTxResult smmu_read_mmio(void *opaque, hwaddr offset, uint64_t *data,
     SMMUState *sys = opaque;
     SMMUv3State *s = ARM_SMMUV3(sys);
     MemTxResult r;
+    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
 
     /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
     offset &= ~0x10000;
+    if (offset >= SMMU_SECURE_REG_START) {
+        reg_sec_sid = SMMU_SEC_SID_S;
+        offset -= SMMU_SECURE_REG_START;
+    }
+
+    if (smmuv3_reg_is_raz_wi(offset, reg_sec_sid)) {
+        *data = 0;
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: read from undefined register: bank=%d "
+                      "offset=0x%" PRIx64 " (RAZ)\n",
+                      __func__, reg_sec_sid, offset);
+        trace_smmuv3_read_mmio(offset, *data, size, MEMTX_OK);
+        return MEMTX_OK;
+    }
 
     switch (size) {
     case 8:
-        r = smmu_readll(s, offset, data, attrs);
+        r = smmu_readll(s, offset, data, attrs, reg_sec_sid);
         break;
     case 4:
-        r = smmu_readl(s, offset, data, attrs);
+        r = smmu_readl(s, offset, data, attrs, reg_sec_sid);
         break;
     default:
         r = MEMTX_ERROR;
-- 
2.34.1


