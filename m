Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453F4CD4F3D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuHS-0006ti-Lx; Tue, 12 May 2026 17:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuHJ-00063s-5b; Tue, 12 May 2026 17:04:33 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuHH-0000KU-8O; Tue, 12 May 2026 17:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619279; bh=ZpvhcFTgDOJ58EjibxnNPFQRXpWbyZBOdYXSzIq1qlg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JCAm7nEUyN8sdDXdKxkExA+NLRcT4zE00qjklFQCK0inEGquQfRQTam65mZ7zHFOh
 Rz3hpaiRJGdmEG2D8lqgEIsWFNOKKZ7D/8N+a8h57L3UTP1SrtE8gZg+gjq2Npfr4u
 hrviBM2XhwBJXZoRTZ3nTvC0D5oqDOd/qkywofuOYgssGhbuAddRosqPytUUHsd76I
 MwWOriVpK1bL692xPwshFGDJPPDzKOlotqgqcJnCXnrllOYGSB5MUuQe2fbam5bzLQ
 H0qM0DtdT4X3scM4LX9VulGqF2Otj+Jl0I7CuczBakzCq9jxI/RZWurtC6DZ0YUz2M
 aukXYG1UHKzSQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C72C21AA32E;
 Tue, 12 May 2026 23:54:39 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D4C183ABC9F;
 Tue, 12 May 2026 23:54:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, liugan1 <liugan1@lixiang.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 098/107] hw/intc/arm_gicv3: Fix NS write to
 ICC_AP1Rn_EL1 when prebits < 7
Date: Tue, 12 May 2026 23:54:25 +0300
Message-ID: <20260512205437.360850-98-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: liugan1 <liugan1@lixiang.com>

The existing code uses a blanket `regno < 2` check to make
ICC_AP1R0_EL1 and ICC_AP1R1_EL1 writes from Non-secure code WI
(Write Ignore) when EL3 is present. This is intended to prevent
NS code from claiming active interrupts in the Secure priority
range, which could block Secure interrupt delivery.

However, that check assumes prebits=7 (4 APR registers), where the
NS priority range (128..255) maps entirely to AP1R2/AP1R3. Since
commit 39f29e599355 ("hw/intc/arm_gicv3: Use correct number of
priority bits for the CPU", first in 7.1), all QEMU AArch64 CPUs
are initialised with gic_pribits=5 (one APR register), so NS
priorities map to AP1R0 bits [16:31]. Blanket WI of the entire
AP1R0 register prevents NS code from clearing its own NS active
priority bits. Machines using hw_compat_7_0 (e.g. virt-7.0) still
force pribits=8 via force-8-bit-prio and are therefore unaffected.

A concrete consequence observed in virtualisation scenarios: when
a guest VM acknowledges an SPI interrupt but does not perform EOI,
is force-killed and restarted, the new guest's attempt to clear
the residual active state by writing ICC_AP1R0_EL1=0 is silently
ignored. The running priority (RPR) remains stuck at the old
interrupt's priority, preventing all equal-or-lower priority
interrupts (including timer interrupts) from being delivered, and
hanging the guest.

Fix this by computing the exact Secure/NS boundary within the APR
bank based on prebits. For registers entirely in the Secure range,
keep the WI behaviour. For the register that straddles the
boundary, preserve only the Secure bits while allowing NS bits to
be modified. For registers entirely in the NS range, allow full
write access.

The new logic produces identical behaviour to the old code when
prebits=7, preserving existing behaviour for machines that use
force-8-bit-prio.

Fixes: 39f29e599355 ("hw/intc/arm_gicv3: Use correct number of priority bits for the CPU")
Cc: qemu-stable@nongnu.org
Signed-off-by: liugan1 <liugan1@lixiang.com>
Message-id: 20260428083119.1400110-1-gs_liugan@163.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit f35f0f1ca121fb4931fe98570cda3aeb06b7a87f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index de37465bc8..43831cb9a4 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -1870,9 +1870,40 @@ static void icc_ap_write(CPUARMState *env, const ARMCPRegInfo *ri,
      * at a priority outside the Non-secure range (128..255), since this
      * would otherwise allow malicious NS code to block delivery of S interrupts
      * by writing a bad value to these registers.
+     *
+     * The NS priority range (128..255) maps to APR bits starting at
+     * aprbit = 0x80 >> (8 - prebits). Depending on prebits, this boundary
+     * may fall within AP1R0 or AP1R1, so we cannot simply WI the entire
+     * register. Instead we calculate which bits within each register
+     * correspond to the Secure range and preserve those, while allowing
+     * NS code to modify only the NS range bits.
+     *
+     *   prebits=4: num_aprs=1, NS starts at AP1R0[8]
+     *   prebits=5: num_aprs=1, NS starts at AP1R0[16]
+     *   prebits=6: num_aprs=2, NS starts at AP1R1[0]
+     *   prebits=7: num_aprs=4, NS starts at AP1R2[0]
      */
-    if (grp == GICV3_G1NS && regno < 2 && arm_feature(env, ARM_FEATURE_EL3)) {
-        return;
+    if (grp == GICV3_G1NS && arm_feature(env, ARM_FEATURE_EL3)) {
+        int ns_start_bit = 0x80 >> (8 - cs->prebits);
+        int ns_start_regno = ns_start_bit / 32;
+        int ns_start_regbit = ns_start_bit % 32;
+
+        if (regno < ns_start_regno) {
+            /* This entire register is in the Secure range: WI */
+            return;
+        } else if (regno == ns_start_regno && ns_start_regbit > 0) {
+            /*
+             * This register is split: low bits are Secure, high bits are NS.
+             * Preserve the Secure bits (below ns_start_regbit) from the
+             * current value, and take the NS bits (at and above
+             * ns_start_regbit) from the written value.
+             */
+            uint32_t secure_mask = MAKE_64BIT_MASK(0, ns_start_regbit);
+
+            value = (cs->icc_apr[grp][regno] & secure_mask) |
+                    (value & ~secure_mask);
+        }
+        /* else: regno > ns_start_regno, entire register is NS: allow write */
     }
 
     if (cs->nmi_support) {
-- 
2.47.3


