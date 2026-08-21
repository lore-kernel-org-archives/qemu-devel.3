Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59746C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN11-0000O6-8P; Fri, 21 Aug 2026 07:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0v-0000HJ-A7
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:21 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0s-0007Rq-Ms
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:21 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47fd4531020so510526f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310137; x=1787914937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iFa8vLi3xDZSUcOFrJ8xg6zhIdMmM3lcYUvKuPnGc/k=;
 b=rzJqDbOYc5odThnitrrxPdaP0iYrPQB3aGSkjsgN8M+IrtsmeDAQvXN3tSGQo29V13
 XDDT2TeK4hFAsk+zoXfLVbyG8e3L03KLsDo0PCZIDnie/eewoaA1TEnSpcKeT1/UQKWt
 QvYuWkK3VYObFmD9cnd3sy6x4L+m+PcIVPnvxZ3zDZinUqFXg5bsPzpLwu88S73W89CC
 VkYELuCdQ9Y0VjnWrmR1Q5rNAPfk4OMNi5Lr5jR7WYsMxxoH0Kk43d6hHH9CW9iUZI6D
 poI1B2SYe0JdPsvBP//fl4fsKUexap8SflDgGwr4GGPZ3MHepku2l64T1ugSrdAMuWIH
 YkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310137; x=1787914937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iFa8vLi3xDZSUcOFrJ8xg6zhIdMmM3lcYUvKuPnGc/k=;
 b=mZdPO3aPwYS5Faws8CSTi4YxK4BruRSJ0v4+F5spwNbDiN4tlVKiXJomGWeuaQpuby
 TLSwVpnxR0xhsOiVBvhkWmfwR2QYqi5geEvYVv3cdPLUupiTUaFsF0HYs/J9VP/kkPyq
 Lb7f8vhF1jGEumYQq+i6vA/zMeXPh89QRBi4zv+7fN8czMTEMUSuUA4fUsXllvn9zpTb
 oNTs0rSyCjWN0i9os8RMhLD2GB/4RSyTGYtJ3C4cgYyI4V3KNrtsnzWRHe1iuGq0rETP
 f9gcFeMRlZs4Yr0ISnFBhZ1ah4Dy1cnHdIrVwf1iMvhktm8ljdI0hWCVws1o6w/Tv+jQ
 6Xzw==
X-Gm-Message-State: AOJu0YxHxN0Stst47xk2jD9PvhJYT6o2imU2uSR8rtbaorbFJfR4UgM6
 Uq5BrfkHZJOYtkA8Z7MhO2+dCTcoSN5Z0PNTkqa1NryFQGXM09XxBs32+vXLdmAbg0QYg3FvXj9
 9fwSL
X-Gm-Gg: AR+sD10NVThV5NYVyH2xyksTRP0pjWe12HAHumsrXyTMQxATIULEHicVRMYnzjpLTk/
 vpJEzIA5zxphGcNgwNyprJhWv2+93zHUDDyZJ1pepxsG/A+6zGOkG/cd9Jvs5peMUO+OksZsUIq
 uamBktETOZJa8hMNatXZD3T77TqAViJUL6GMLlp8e/9z/S/+UqgCymqwYu2op3UomQqcGpykZy9
 hjnzIL+TW6YsfWqvbbZeJu88vxcAygpjlwJ1dest6NdS5SXKW/N3s5k+eCwr9Ix9y4Y6hOAie8Z
 lAV9B4M+shiqb8SnAhXwm1Ih8yqLR6LkXGzIS5+vSEOvoaGMYv9IDL/0/mcFX0FyNIeQT+4G50Q
 zTAOx8vuQERA7ozh0AIcs8P0LhVjyJ91wpgbguWuQ1PqjqNp8sFwbznJhgKOCF8UJdE/yLZLCs3
 h6CBSmSKzJ6A4Lm6TxzkD40kPMS1RxWRd6nTvLqzECh/CHyJuW7f59b/8xxHhUHj4i0EjQ6bQJj
 T2qed/P6LxJC39CJPi9Ewb2AHV7Nf5aX/Q+d78xQA44PKBI3LFBzNiIfg0shVFzbwOltaKzAcoX
 GXJy
X-Received: by 2002:a05:600c:3550:b0:499:8777:ccba with SMTP id
 5b1f17b1804b1-499b830156bmr79609715e9.12.1787310137158; 
 Fri, 21 Aug 2026 04:02:17 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.02.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:02:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/43] target/arm: Implement CPACR.ASEDIS and HCPTR.TASE
Date: Fri, 21 Aug 2026 12:00:38 +0100
Message-ID: <20260821110101.3971391-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

When executing at AArch32, there are optional trap bits for Neon
instructions in CPACR and HCPTR. We don't currently implement these.

Now we have a separate code path for access checks for Neon insns, we
can straightforwardly add the check there.  We need to track the
target EL for Neon-specific trapping in a new TB flag.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1499
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260817123838.1578060-6-peter.maydell@linaro.org
---
 target/arm/cpu.h               |  6 +++
 target/arm/tcg/hflags.c        | 82 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-vfp.c | 16 +++++--
 target/arm/tcg/translate.c     |  1 +
 target/arm/tcg/translate.h     |  1 +
 5 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4f07332543d..afc3fda3b83 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2506,6 +2506,12 @@ FIELD(TBFLAG_A32, NS, 10, 1)
  * This requires an SME trap from AArch32 mode when using NEON.
  */
 FIELD(TBFLAG_A32, SME_TRAP_NONSTREAMING, 11, 1)
+/*
+ * Target EL for a Neon-disabled exception via CPACR.ASEDIS, HCPTR.TASE.
+ * If FPEXC_EL indicates a trap to a lower EL than this, that will
+ * take precedence.
+ */
+FIELD(TBFLAG_A32, NEONEXC_EL, 12, 2)
 
 /*
  * Bit usage when in AArch32 state, for M-profile only.
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 0716ca98fd7..14824e3dff1 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -164,6 +164,86 @@ static bool sme_fa64(CPUARMState *env, int el)
     return true;
 }
 
+static int neon_exception_el(CPUARMState *env, int cur_el)
+{
+    /*
+     * Return the EL to trap to for A32 Neon specific traps
+     * (CPACR.ASEDIS and HCPTR.TASE). In the pseudocode these are
+     * checked in the same function as the more general trap bits that
+     * we handle in fp_exception_el(). Fortunately it is always the
+     * case that if the trap/enable bits specify taking an exception
+     * to different ELs for the Neon-specific insns and the general fp
+     * insns then the trap to the lower of the two ELs has priority,
+     * so we can calculate the two target ELs separately and pick the
+     * right destination later.  Compare AArch32_CheckAdvSIMDOrFPEnabled().
+     *
+     * CPACR doesn't exist before v6, but neither does Neon, so we can
+     * assume that if we're here testing this then the register exists.
+     * HCPTR always exists if EL2 is present.
+     */
+    uint64_t hcr_el2 = arm_hcr_el2_eff(env);
+    bool cpacr_asedis = FIELD_EX64(env->cp15.cpacr_el1, CPACR, ASEDIS);
+    bool hcptr_tase = FIELD_EX64(env->cp15.cptr_el[2], HCPTR, TASE);
+    bool have_aarch32_el3 =
+        arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3);
+
+    if (!arm_feature(env, ARM_FEATURE_NEON_TRAPS)) {
+        /* This CPU doesn't implement the trap bits (Cortex-A8) */
+        return 0;
+    }
+
+    if (arm_feature(env, ARM_FEATURE_EL2) && arm_el_is_aa64(env, 2)) {
+        /*
+         * The AArch64 CPTR_EL2 has no equivalent to HCPTR.TASE; only
+         * an AArch32 EL2 can trap Neon specifically.
+         */
+        hcptr_tase = false;
+    }
+
+    /*
+     * We know we're in AArch32, but if this is EL0 and EL1 is AArch64
+     * then CPACR_EL1 applies rather than CPACR, and it doesn't have
+     * ASEDIS (instead using the same bit for TCPAC).
+     */
+    if (cur_el == 0 && arm_el_is_aa64(env, 1)) {
+        cpacr_asedis = false;
+    }
+
+    /* CPACR is ignored if E2H+TGE are both set */
+    if ((hcr_el2 & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+        cpacr_asedis = false;
+    }
+
+    /*
+     * NSACR.NSASEDIS makes the effective values of HCPTR.TASE and
+     * CPACR.ASEDIS be 1 in NonSecure state. NSACR has no
+     * effect unless EL3 exists and is AArch32.
+     */
+    if (have_aarch32_el3 && cur_el <= 2 && !arm_is_secure_below_el3(env)) {
+        if (FIELD_EX32(env->cp15.nsacr, NSACR, NSASEDIS)) {
+            cpacr_asedis = true;
+            hcptr_tase = true;
+        }
+    }
+
+    if (cpacr_asedis) {
+        if (have_aarch32_el3 && (cur_el == 3 || arm_is_secure_below_el3(env))) {
+            /* Trap from Secure PL0 or PL1 to Secure PL1 */
+            return 3;
+        }
+        if (cur_el <= 1) {
+            /* trap from EL0 or EL1 to EL1 */
+            return 1;
+        }
+    }
+
+    /* HCPTR.TASE traps to EL2, including for execution at EL2 */
+    if (hcptr_tase && cur_el <= 2) {
+        return 2;
+    }
+    return 0;
+}
+
 static CPUARMTBFlags rebuild_hflags_a32(CPUARMState *env, int fp_el,
                                         ARMMMUIdx mmu_idx)
 {
@@ -209,6 +289,8 @@ static CPUARMTBFlags rebuild_hflags_a32(CPUARMState *env, int fp_el,
         DP_TBFLAG_A32(flags, SME_TRAP_NONSTREAMING, 1);
     }
 
+    DP_TBFLAG_A32(flags, NEONEXC_EL, neon_exception_el(env, el));
+
     return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
 }
 
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index 6e944a0322a..4db4b14841d 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -306,15 +306,25 @@ bool vfp_access_check(DisasContext *s)
 
 /*
  * Access check for Neon; this is for instructions which can be
- * trapped by CPACR.ASEDIS and HCPTR.TASE. Support for those traps
- * is optional and we currently do not implement them, so this
- * is identical to a VFP access check for now.
+ * trapped by CPACR.ASEDIS and HCPTR.TASE.
  */
 bool neon_access_check(DisasContext *s)
 {
     if (arm_dc_feature(s, ARM_FEATURE_M)) {
         return vfp_access_check_m(s, false);
     } else {
+        /*
+         * If the Neon-specific trap bits request a trap to a lower EL
+         * than the general FP trap bits, the trap to the lower EL
+         * has priority.
+         */
+        if (s->neon_excp_el &&
+            (!s->fp_excp_el || s->neon_excp_el < s->fp_excp_el)) {
+            uint32_t syn = syn_a32_fp_access_trap(1, 0xe, 1, 0);
+
+            gen_exception_insn_el(s, 0, EXCP_UDEF, syn, s->neon_excp_el);
+            return false;
+        }
         return vfp_access_check_a(s, false, true);
     }
 }
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 1770428d3cc..7306a1389cc 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6403,6 +6403,7 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
         dc->vec_stride = EX_TBFLAG_A32(tb_flags, VECSTRIDE);
         dc->sme_trap_nonstreaming =
             EX_TBFLAG_A32(tb_flags, SME_TRAP_NONSTREAMING);
+        dc->neon_excp_el = EX_TBFLAG_A32(tb_flags, NEONEXC_EL);
     }
     dc->lse2 = false; /* applies only to aarch64 */
     dc->cp_regs = cpu->cp_regs;
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index a3d03159ad9..cce84f29c46 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -88,6 +88,7 @@ typedef struct DisasContext {
     int sve_excp_el; /* SVE exception EL or 0 if enabled */
     int sme_excp_el; /* SME exception EL or 0 if enabled */
     int zt0_excp_el; /* ZT0 exception EL or 0 if enabled */
+    int neon_excp_el; /* A32 Neon exception EL or 0 if enabled */
     int vl;          /* current vector length in bytes */
     int svl;         /* current streaming vector length in bytes */
     int max_svl;     /* maximum implemented streaming vector length */
-- 
2.43.0


