Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 001FCC61DE1
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Feb 2026 10:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtk4U-0002u0-CL; Sat, 21 Feb 2026 05:18:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtk4O-0002f4-2A; Sat, 21 Feb 2026 05:18:40 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtk4L-0002aj-Hh; Sat, 21 Feb 2026 05:18:39 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwC3vJh6hplpzq9VBw--.4496S2;
 Sat, 21 Feb 2026 18:18:34 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDXLet4hplpfE4cAA--.34240S3;
 Sat, 21 Feb 2026 18:18:32 +0800 (CST)
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
Subject: [RFC v4 24/31] hw/arm/smmuv3: Determine register bank from MMIO offset
Date: Sat, 21 Feb 2026 18:18:29 +0800
Message-Id: <20260221101830.2996354-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDXLet4hplpfE4cAA--.34240S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQANBWmYzyUARQAAsX
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3AryfCry5tr1rCr1UuF1Dtrb_yoWxJr1xpr
 Z8XF1Sgrn8Ka1SqwsxJa1UC3W8Cwn7Kr1akrnxKryDu3yIywn7JayvyryfuryDury7Zrs8
 trW5Gr47WrWqy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

Modify the main MMIO handlers (smmu_write_mmio, smmu_read_mmio)
to determine the security state of the target register based on its
memory-mapped offset.

By checking if the offset is within the secure register space (>=
SMMU_SECURE_REG_START), the handlers can deduce the register's
SEC_SID (reg_sec_sid). This SID is then passed down to the register
access helper functions (smmu_writel, smmu_readl, etc.).

Inside these helpers, the switch statement now operates on a masked,
relative offset:

    uint32_t reg_offset = offset & 0xfff;
    switch (reg_offset) {
        ...
    }

This design leverages a key feature of the SMMU specification: registers
with the same function across different 3 security states
(Non-secure, Secure, Realm) share the same relative offset. This avoids
significant code duplication. The reg_sec_sid passed from the MMIO
handler determines which security bank to operate on, while the masked
offset identifies the specific register within that bank.

It is important to distinguish between the security state of the
register itself and the security state of the access. A
higher-privilege security state is permitted to access registers
belonging to a lower-privilege state, but the reverse is not allowed.
This patch lays the groundwork for enforcing such rules.

For future compatibility with Realm states, the logic in the
else block corresponding to the secure offset check:

    if (offset >= SMMU_SECURE_REG_START) {
        reg_sec_sid = SMMU_SEC_SID_S;
    } else {
        /* Future Realm handling */
    }

will need to be expanded.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3.c | 57 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 18 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 9c09ea0716e..d81485a6a46 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1781,12 +1781,13 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
 }
 
 static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
-                               uint64_t data, MemTxAttrs attrs)
+                                uint64_t data, MemTxAttrs attrs,
+                                SMMUSecSID reg_sec_sid)
 {
-    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
+    uint32_t reg_offset = offset & 0xfff;
 
-    switch (offset) {
+    switch (reg_offset) {
     case A_GERROR_IRQ_CFG0:
         if (!smmu_gerror_irq_cfg_writable(s, reg_sec_sid)) {
             /* SMMU_(*_)_IRQ_CTRL.GERROR_IRQEN == 1: IGNORED this write */
@@ -1851,13 +1852,14 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
 }
 
 static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
-                               uint64_t data, MemTxAttrs attrs)
+                               uint64_t data, MemTxAttrs attrs,
+                               SMMUSecSID reg_sec_sid)
 {
     Error *local_err = NULL;
-    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
+    uint32_t reg_offset = offset & 0xfff;
 
-    switch (offset) {
+    switch (reg_offset) {
     case A_CR0:
         bank->cr[0] = data;
         bank->cr0ack = data & ~SMMU_CR0_RESERVED;
@@ -2094,16 +2096,25 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
     SMMUState *sys = opaque;
     SMMUv3State *s = ARM_SMMUV3(sys);
     MemTxResult r;
+    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
 
     /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
     offset &= ~0x10000;
 
+    /*
+     * Realm and Non-secure share the same page-local offset layout; Secure uses
+     * the same layout but is mapped starting at 0x8000(SMMU_SECURE_REG_START)
+     */
+    if (offset >= SMMU_SECURE_REG_START) {
+        reg_sec_sid = SMMU_SEC_SID_S;
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
@@ -2115,12 +2126,13 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
 }
 
 static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
-                               uint64_t *data, MemTxAttrs attrs)
+                               uint64_t *data, MemTxAttrs attrs,
+                               SMMUSecSID reg_sec_sid)
 {
-    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
+    uint32_t reg_offset = offset & 0xfff;
 
-    switch (offset) {
+    switch (reg_offset) {
     case A_GERROR_IRQ_CFG0:
         /* SMMU_(*_)GERROR_IRQ_CFG0 BOTH check SMMU_IDR0.MSI */
         if (!smmu_msi_supported(s)) {
@@ -2149,17 +2161,22 @@ static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
 }
 
 static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
-                              uint64_t *data, MemTxAttrs attrs)
+                              uint64_t *data, MemTxAttrs attrs,
+                              SMMUSecSID reg_sec_sid)
 {
-    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
+    uint32_t reg_offset = offset & 0xfff;
 
-    switch (offset) {
+    switch (reg_offset) {
     case A_IDREGS ... A_IDREGS + 0x2f:
-        *data = smmuv3_idreg(offset - A_IDREGS);
+        *data = smmuv3_idreg(reg_offset - A_IDREGS);
         return MEMTX_OK;
     case A_IDR0 ... A_IDR5:
-        *data = bank->idr[(offset - A_IDR0) / 4];
+        if (reg_sec_sid == SMMU_SEC_SID_S) {
+            g_assert((reg_offset - A_IDR0) / 4 < 5);
+        }
+
+        *data = bank->idr[(reg_offset - A_IDR0) / 4];
         return MEMTX_OK;
     case A_IIDR:
         *data = s->iidr;
@@ -2275,16 +2292,20 @@ static MemTxResult smmu_read_mmio(void *opaque, hwaddr offset, uint64_t *data,
     SMMUState *sys = opaque;
     SMMUv3State *s = ARM_SMMUV3(sys);
     MemTxResult r;
+    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
 
     /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
     offset &= ~0x10000;
+    if (offset >= SMMU_SECURE_REG_START) {
+        reg_sec_sid = SMMU_SEC_SID_S;
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


