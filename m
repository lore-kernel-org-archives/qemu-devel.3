Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7239ECD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 18:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ7nF-0000Jm-Kv; Thu, 21 May 2026 14:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQ7n7-0000HR-Q3
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:06:42 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQ7n5-000281-8N
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:06:41 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dea1272943so3175167a34.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 11:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779386798; x=1779991598; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h/YjkLPN0ai0rp7srfOk+fhrJScHHUdUfM2SVxvqpR4=;
 b=AjimbOAyXm1bJrZWwhNCDZyi6TBuv+Ah+7WqRvCITiAzdprNBTvmrjWHoM+2CPc8mH
 Y5+efjyry7Cj5O+60+cUenJ3Osq2Y6RNo8968WrTNl9RwD+Q3KdLI/vzuozlVHvITfly
 qKDUfZ23MgwchKuIlQiyDfxk0C5gzrvBtz4jym2zooqIxQC8NdbV66S1b2Qm7RaoQx2E
 f7cgjsN/VZ+otgaOUtN1Dep80Z4V652cYqqquilBUi9ESMkEErxA7ZPPNGf3z6ynW/cK
 QSB2uJZcH54yfMmXzT/MnC7hjCpkzI8fEcn82W6L+PedNy52dupAU/k0tyth1EUDu8tf
 vfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386798; x=1779991598;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=h/YjkLPN0ai0rp7srfOk+fhrJScHHUdUfM2SVxvqpR4=;
 b=oiTgjGWBCKP4enZQ4tVLB3tnTaUz6f30jYWm8XT3zY+Z2loaIAcA6HWyrIPNhY2dTn
 ZhSXl1WcGb8O8N2l+9Rr0n/EK6VmIxd4KJJZo/iE55nWMUKMrqIkqDVLsNDWY1hOPgrJ
 EWw7dS/eFmDh6+qS6Fhrwra2tmumzl1DX/s76xp7asaYrA7+3ikrLs+ElgDyW9R51BXo
 OHDdz8XH7V53TAGJ0WeppbUVfaRU996Pi+pl52cgP/fHwu2j9FG4E8LEpIarVIMwJjny
 P3oHXg8gFSE4n0POAaAklgg8tn4+8Fl9d3KjqE+4z1RWSvWz6FRFp4YFcqPHz4QE8yNj
 f8RA==
X-Gm-Message-State: AOJu0YyoHEcgp2snGFX5ps9yn32vr7eL9wHSDuk2jo6oluLr2UUEg++r
 OvuzOjuWdxEnGwTzL3szhL1YKFQjl6ezk4cidbPGsC6U6he/I8XhD7hB
X-Gm-Gg: Acq92OHOXYIwza/9eAok8tdgMxNuc5B9dDgb5NYeKMMS6Zs05mI2S35VGoBZQGNZOzq
 GYLIzEkjXmNJ2ICpZWgVeoioqVHbtjkzH9OEzVmDwqeVdtdLvINzH/gQc93MwOqOPyf0lTTIpv/
 EGzO1fuMSaDXUrtxcUUilDdCd2/PNzoHt7COd2BJJmgqjEWyZQWcq3KrielBsz8E84p23shoP0S
 znFYCRfwInjIWS3fQHgC5ZWfJiZRcj89PCnAoCtfMGbEeFMbp9KlDKVBabubKyPOLTQKH2UO+AV
 kxHTevIC8mJiAtUVFvYSQemFsLj4//xy0V75MPyKkTg75iSPgHgTus/v8d32rGBHLqJLdv1u4+I
 wJaIp8eXmd3uAf/VoECSRLnJev2zd+O7xn3/ofbB9NgxiaCKEkyG+NuNpn/aOESELLDnb46OusN
 YkTiA8rZiJfftjxZvyui6ebacu4xwFaJe2gxVHXrlYII+6TDrRThhopNHQO38LkPX/KUdyUbwru
 5XmtHs1k+yOdqdQse6cDSNaIgrHIebbCERMXh3qBtV5fnHrmH3U0PsK4LyR1jz3WfG32vd15XAf
 ISo=
X-Received: by 2002:a05:6830:20ca:b0:7e5:6d2e:acd9 with SMTP id
 46e09a7af769-7e5fefcbc8dmr80712a34.12.1779386798119; 
 Thu, 21 May 2026 11:06:38 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e5f6ee286fsm903089a34.25.2026.05.21.11.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:06:37 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 21 May 2026 12:06:14 -0600
Subject: [PATCH v13 21/22] target/mips: add Octeon CvmCount RDHWR support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-mips-octeon-missing-insns-v2-v13-21-5a4cb8ec9cd3@gmail.com>
References: <20260521-mips-octeon-missing-insns-v2-v13-0-5a4cb8ec9cd3@gmail.com>
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v13-0-5a4cb8ec9cd3@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Octeon exposes CvmCount through RDHWR register 31. Add the Octeon-only
decode path, enable the corresponding HWREna bit for linux-user, and use
an unsigned mask when checking HWREna so bit 31 is handled safely.

For user-mode emulation, return host ticks as a monotonic counter source
suitable for existing Octeon userspace code. In system mode, fall back to
the existing CP0 Count value.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v5 -> v6:
  - New patch.
---
 target/mips/cpu.c                             |  1 +
 target/mips/helper.h                          |  1 +
 target/mips/tcg/op_helper.c                   | 13 ++++++++++++-
 target/mips/tcg/translate.c                   | 11 +++++++++++
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 17 +++++++++++++++++
 5 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index b223b767c9..d72044aef6 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -320,6 +320,7 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
     env->CP0_HWREna |= 0x0000000F;
     if (env->insn_flags & INSN_OCTEON) {
         env->CP0_HWREna |= 0x40000000u;
+        env->CP0_HWREna |= 0x80000000u;
     }
     if (env->CP0_Config1 & (1 << CP0C1_FP)) {
         env->CP0_Status |= (1 << CP0St_CU1);
diff --git a/target/mips/helper.h b/target/mips/helper.h
index 2902dde889..a755cc5ad5 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -277,6 +277,7 @@ DEF_HELPER_1(rdhwr_ccres, tl, env)
 DEF_HELPER_1(rdhwr_performance, tl, env)
 DEF_HELPER_1(rdhwr_xnp, tl, env)
 DEF_HELPER_1(rdhwr_chord, tl, env)
+DEF_HELPER_1(rdhwr_cvmcount, tl, env)
 DEF_HELPER_2(pmon, void, env, int)
 DEF_HELPER_1(wait, void, env)
 
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index 3e586e3049..df1b5c3734 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -25,6 +25,7 @@
 #include "exec/memop.h"
 #include "fpu_helper.h"
 #include "qemu/crc32c.h"
+#include "qemu/timer.h"
 #include <zlib.h>
 
 static inline target_ulong bitswap(target_ulong v)
@@ -209,7 +210,7 @@ target_ulong helper_yield(CPUMIPSState *env, target_ulong arg)
 
 static inline void check_hwrena(CPUMIPSState *env, int reg, uintptr_t pc)
 {
-    if ((env->hflags & MIPS_HFLAG_CP0) || (env->CP0_HWREna & (1 << reg))) {
+    if ((env->hflags & MIPS_HFLAG_CP0) || (env->CP0_HWREna & (1u << reg))) {
         return;
     }
     do_raise_exception(env, EXCP_RI, pc);
@@ -261,6 +262,16 @@ target_ulong helper_rdhwr_chord(CPUMIPSState *env)
     return env->octeon_crypto.chord;
 }
 
+target_ulong helper_rdhwr_cvmcount(CPUMIPSState *env)
+{
+    check_hwrena(env, 31, GETPC());
+#ifdef CONFIG_USER_ONLY
+    return cpu_get_host_ticks();
+#else
+    return (uint32_t)cpu_mips_get_count(env);
+#endif
+}
+
 void helper_pmon(CPUMIPSState *env, int function)
 {
     function /= 2;
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 1f44932882..e3467d1525 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -10933,6 +10933,17 @@ void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel)
         gen_helper_rdhwr_chord(t0, tcg_env);
         gen_store_gpr(t0, rt);
         break;
+    case 31:
+        if (!(ctx->insn_flags & INSN_OCTEON)) {
+            gen_reserved_instruction(ctx);
+            break;
+        }
+        translator_io_start(&ctx->base);
+        gen_helper_rdhwr_cvmcount(t0, tcg_env);
+        gen_store_gpr(t0, rt);
+        gen_save_pc(ctx->base.pc_next + 4);
+        ctx->base.is_jmp = DISAS_EXIT;
+        break;
     default:            /* Invalid */
         MIPS_INVAL("rdhwr");
         gen_reserved_instruction(ctx);
diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index 9ee4b8f990..d41115aab6 100644
--- a/tests/tcg/mips/user/isa/octeon/octeon-insns.c
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -314,6 +314,22 @@ static uint64_t octeon_cop2_gfm_mul_reflect_readback(uint64_t value)
     return rd;
 }
 
+static uint64_t octeon_rdhwr31_non_decreasing(void)
+{
+    uint64_t first, second;
+
+    asm volatile(
+        ".word 0x7c08f83b\n\t" /* rdhwr $8, $31 */
+        ".word 0x7c09f83b\n\t" /* rdhwr $9, $31 */
+        "move %[first], $8\n\t"
+        "move %[second], $9\n\t"
+        : [first] "=r" (first), [second] "=r" (second)
+        :
+        : "$8", "$9");
+
+    return second >= first;
+}
+
 int main(void)
 {
     assert(octeon_baddu(0x123, 0x0f0) == 0x13);
@@ -340,6 +356,7 @@ int main(void)
                0x0123456789abcdefULL) == 0xf7b3d591e6a2c480ULL);
     assert(octeon_cop2_gfm_mul_reflect_readback(
                0xfedcba9876543210ULL) == 0x084c2a6e195d3b7fULL);
+    assert(octeon_rdhwr31_non_decreasing());
 
     return 0;
 }

-- 
2.54.0


