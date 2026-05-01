Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AC1CD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkuI-00042b-F0; Fri, 01 May 2026 06:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIku8-0003zy-MB
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIku6-0008Va-Fh
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:28 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so17328365e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777630524; x=1778235324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W4UfCZGlGsslHj81NT0nPwBtEGpVU9AOA4AqrFJUctM=;
 b=kSGYF29dTlUUlIGIWV1Dc1uxnfmlgprqQfDrg86K3lXBg/BnVGTAeXgTHBq2ImghAj
 A7SvhQsGyymeauaj2nJsoHtVAZhZpwHzw8fWe3LmTM8Q7ti/YBvjD2G9bd6nnpo0WZjz
 cBnlic79wwy2giS3a30te6wJZ0nboxpv5lMYYr54Z1x64izZJWWxd0JLPaAO5Er5FUA4
 CT1V09URIzYhda/eO4Tg+bQ68AcbkdC5FX1f3CFuoh5yTSe8L0feVJ/kuIOhTIslZUK+
 yjHsnCl6soxzzW23kQON5U9vIYNqwvX65LIjEtkp/lIH+qUs+ppUBwssrWwEFdOdqvAF
 dpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777630524; x=1778235324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=W4UfCZGlGsslHj81NT0nPwBtEGpVU9AOA4AqrFJUctM=;
 b=h7Eok1kSKZTltF/JLenGtBcghHCQxhVDLIitB8tvpaRyJiu76vPSEZ4QkGtid1XmyR
 2VWaftnypKlOlf6eKabVs7Bxc0WNBdIh7dKyjkOD2Eze4OBfqe1rCwGhUrSYcOb6h4lH
 a6+xMyH6RV7+ho+T6+SHUHxlBIDd7g8z13UU6kTHcpVXuYWL9a27fYuxhpEyCqfqVqQn
 58p6NXDVbOjT0TiYJ9F3avXQUV1Q+f41PsGtMRSzEgjetjBebXZwo0TPMeWsp880/5ZZ
 toQt26k1wmkVa1ny0skiqZQe3QFPelTGNtPaFIkhz3Wp3/fJ612gr21q1ndy9Guiu2h4
 VRHw==
X-Gm-Message-State: AOJu0Yw/XuIjCf1qc/Z2zpS3DslriN9LDQgPHmzg2ILIjqloC33Tdpdr
 Rp4E+e9YBJgcylUizMC43+ohLG/iatrXHZlKlAyy2w3rPUrxsv4IB2CjMJAscsxB7fPnG5XdMy0
 B3PFG
X-Gm-Gg: AeBDievlDEgUwcV3Iw/8CRa+F422/inmo8hZYrTo2mlniEPg7h8OPAjLe0o5k9mskU2
 1e48rKbQMiUexV1aPYsWbJXBh5TdJ7ej2ugDUZC/nmwkFomBKsAlNQia+V/eBu+AOqmzeoKpWOR
 2J0eGdWq5rUdh3rR7x32Cup8CCPBDsM6ikOlZQxM+aMpB6kGBoKwk3yiG3HL1h7B58P22c5Z69j
 zm38TjmDYP18y44B34H99oLi78NLgGEWfTQJfILKKrehbiFi1CMBKRVqVMO/q5MRVPcsJRqcPUa
 MYjJ2cVrjCnmFkeyos6D3dJjlQhzlN2ZgnC9YP+zvmmfNP39hepA/3yKz/Cck0FLx7WtnTZbPDx
 XV3hg2C3UNH+X5VDtRSNXEY/ttrkC3FzvhMy/dtwSI6VeFLbwTo7i0Dqqb/svya0mtBW1z2/uCU
 Po/BZ8vATjMulcWybiCDaX6EnDbherFiuzPUtf3l18pLUfVRkwrPeZJo0PRanyLONNlNlXrLeKa
 52Ke7O7bZLMsQgPVUNlcBtgY/SRkSZkiWY1V4UZVg==
X-Received: by 2002:a05:600c:a401:b0:488:c80c:c236 with SMTP id
 5b1f17b1804b1-48a83f6e3a3mr76497935e9.5.1777630523855; 
 Fri, 01 May 2026 03:15:23 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fede418sm12863335e9.6.2026.05.01.03.15.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 03:15:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/28] hw/intc/arm_gicv3: Fix NS write to ICC_AP1Rn_EL1 when
 prebits < 7
Date: Fri,  1 May 2026 11:14:49 +0100
Message-ID: <20260501101505.3485916-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501101505.3485916-1-peter.maydell@linaro.org>
References: <20260501101505.3485916-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
---
 hw/intc/arm_gicv3_cpuif.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index fcb3922fa0..921d1fdfde 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -1869,9 +1869,40 @@ static void icc_ap_write(CPUARMState *env, const ARMCPRegInfo *ri,
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
2.43.0


