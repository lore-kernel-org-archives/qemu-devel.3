Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D7DC5DF67
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuYGA-0003VC-Hv; Thu, 13 Aug 2026 12:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYFu-0003GB-Nl; Thu, 13 Aug 2026 12:26:10 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYFr-0001BV-O6; Thu, 13 Aug 2026 12:26:09 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwCnpq4d8H1qm1HmAA--.5091S2;
 Fri, 14 Aug 2026 00:26:05 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8Dw4XUX8H1q5iwjAA--.55915S6;
 Fri, 14 Aug 2026 00:26:03 +0800 (CST)
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
Subject: [RFC v5 19/28] hw/arm/smmuv3: Determine register bank from MMIO offset
Date: Fri, 14 Aug 2026 00:25:57 +0800
Message-Id: <20260813162558.2808607-4-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dw4XUX8H1q5iwjAA--.55915S6
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAGBWp8yc0HqAABs+
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxAr4rZr4xGFy7Jr43uF15Arb_yoW7Jryfpr
 WkJr1FgF4DKF4SqFs3Ja1DC3WxZwn2gr9Iyrn3Ka4DC3y8tw1xXay0k34furyDuFyUAws8
 WrW5Gr13WF4qy3DanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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
---
 hw/arm/smmuv3.c | 44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index efa78869251..b36bc4a54e0 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1889,9 +1889,9 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
 }
 
 static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
-                               uint64_t data, MemTxAttrs attrs)
+                                uint64_t data, MemTxAttrs attrs,
+                                SMMUSecSID reg_sec_sid)
 {
-    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
 
     switch (offset) {
@@ -1959,10 +1959,10 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
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
@@ -2223,16 +2223,26 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
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
@@ -2244,9 +2254,9 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
 }
 
 static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
-                               uint64_t *data, MemTxAttrs attrs)
+                               uint64_t *data, MemTxAttrs attrs,
+                               SMMUSecSID reg_sec_sid)
 {
-    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
 
     switch (offset) {
@@ -2285,9 +2295,9 @@ static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
 }
 
 static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
-                              uint64_t *data, MemTxAttrs attrs)
+                              uint64_t *data, MemTxAttrs attrs,
+                              SMMUSecSID reg_sec_sid)
 {
-    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
 
     switch (offset) {
@@ -2295,6 +2305,10 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
         *data = smmuv3_idreg(offset - A_IDREGS);
         return MEMTX_OK;
     case A_IDR0 ... A_IDR5:
+        /* IDR5 does not support Secure or Realm state. */
+        if ((reg_sec_sid != SMMU_SEC_SID_NS) && (offset == A_IDR5)) {
+            goto unhandled;
+        }
         *data = bank->idr[(offset - A_IDR0) / 4];
         return MEMTX_OK;
     case A_IIDR:
@@ -2429,6 +2443,7 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
         *data = bank->eventq_irq_cfg2;
         return MEMTX_OK;
     default:
+    unhandled:
         *data = 0;
         qemu_log_mask(LOG_UNIMP,
                       "%s unhandled 32-bit access at 0x%"PRIx64" (RAZ)\n",
@@ -2443,16 +2458,21 @@ static MemTxResult smmu_read_mmio(void *opaque, hwaddr offset, uint64_t *data,
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


