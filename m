Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D97CCD5BB4
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 19:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQVgV-0001sY-CM; Fri, 22 May 2026 15:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQVgP-0001lK-SO
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:37:22 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQVgK-0000aG-5N
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:37:18 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4855e69a4c0so497644b6e.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 12:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779478633; x=1780083433; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F5VL79dCQYDC43sOTluEe9IY1Prd1AvSVeQ9o4BIfdo=;
 b=I8pWYd/W8vdJkJTvhDpT2zR1MDiL71nKhIy8MnhqstaTlTyxSdAoNFJEaT5SpPS3BJ
 Vi/XE37bIIzREhjUPlbM9EC0umQk6Vy5ffROgRsfT/DVsCKOMXyCOuj/iL3ZcG5KuPTD
 T7iDFBZ1SpGm5DlAKDJRRXT9VvrcvGnSrzsn3iNsZhalJ56Ays/1NXLfz0KCXR0lMO45
 GJp9swDHtMUOrHpLuBxFs8Ew5CWxMfGA+LyZb3BjI/AOrwjRYEnn/u6CHFNxs6RzEmUo
 VoRZf+0yFC8v0abCnx1judnjiCesBmu91cNIAZ3RjY8T9a0zn3dBXkneUn4we33kft4R
 v2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779478633; x=1780083433;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F5VL79dCQYDC43sOTluEe9IY1Prd1AvSVeQ9o4BIfdo=;
 b=cuwVCyMw3Vrfvbmo9ithIu++z4i+tGp4eMqXpkK5tOcIoBX8gtOSNue/kSZMMF1AMD
 UWcTHdBC5gvWwIjlzlFNWuMOM50MPFX6N32LepI8U6ijOUcZvo0NAD5kSmzDHSMP+HFP
 OHnn1lhYDHNdWNd+UqcpMLffj+BN7dt3NPf9JFtIMXA/TGcGRqivS2r92eKpSZjsdta2
 01Oze+Z/ro0lc+v2aruD6Uq0TrLKh1DQQRtllOh0yNsEzZg6YNHgYz+2ApR1xtOg+hav
 wvDZSud552hVvvh7tF2CSEVd4mfmcmVQgsSrdLkhG0j6CVBOqyqR1WzCOJN18PcttJ0Z
 /tSg==
X-Gm-Message-State: AOJu0YzKB21PhzHwg/BQ4nmW/T35WptNEX6umVafgWITl80/RvrCy9po
 zclROd+yBGmspGUC6q9kzzpu0i8zKTxKtrPPi2DqixNMRUTc2z0V3ghJ
X-Gm-Gg: Acq92OHkFiqc3/aiv6WWMfHh7M4pLn0+m5siJ8Wy2CxSbYYTgPGoiP7zz9A41FNlif5
 2+9n/n58/q2p0d/eb9Y0XimNKv+Al3tV5EWWf7U0Q/D/oTgMapayL4qvYPyQh5b4L4/0PDvOaGX
 iORA/hF7PfU6/ZmrIHwzFqXR1FJKXJDEyDHHjZ9M4sUS6e9JG2yv0iJRgUl34ksK9RW8oKz3OIf
 L70FW4zOFPytQAeTB+1GrFHXBOnFz9vsNs0Ur21pN24mlg81TOtosI84qq9qMWWfw4A8n+rzpxI
 tl/X+MmCeGtJmm358tohAipK6nnivnxDWVQ3i+rt793HiAE6PqOvNQcC9fIfi9odkohAObrFVgB
 vtJ/yJMAPUREqiEMs+xnmtBHZQz4k4T2Grv2KM359xRjTfUP+cUy1xK1LS8+wygw3H/h8okFl2q
 MBB3ex2jrnHwdseaivQXgxODvA2dkQLEKI124S8pGfd9JE5ojNoXNhIr7zHyFitAI+SxgxYKXyc
 oTOpRqKUTn2S4eg/fKYmqypTrFlV8peOU1Yd4Q8UWWjxtIlS2g8ievTEjwG3ZZy8/ZU
X-Received: by 2002:a05:6808:f8f:b0:46a:7c00:5cd8 with SMTP id
 5614622812f47-4854a243fc5mr2643964b6e.22.1779478633524; 
 Fri, 22 May 2026 12:37:13 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-48554757d5dsm995297b6e.15.2026.05.22.12.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 12:37:13 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 22 May 2026 13:36:52 -0600
Subject: [PATCH v15 21/22] target/mips: add Octeon CvmCount RDHWR support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-mips-octeon-missing-insns-v2-v15-21-f8731a588dc2@gmail.com>
References: <20260522-mips-octeon-missing-insns-v2-v15-0-f8731a588dc2@gmail.com>
In-Reply-To: <20260522-mips-octeon-missing-insns-v2-v15-0-f8731a588dc2@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x232.google.com
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
index 141350e80a..786117813a 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -255,6 +255,7 @@ DEF_HELPER_1(rdhwr_ccres, tl, env)
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
index f3c52d7829..6480c8532a 100644
--- a/tests/tcg/mips/user/isa/octeon/octeon-insns.c
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -330,6 +330,22 @@ static uint64_t octeon_cop2_gfm_mul_reflect_readback(uint64_t value)
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
@@ -358,6 +374,7 @@ int main(void)
                0x0123456789abcdefULL) == 0xf7b3d591e6a2c480ULL);
     assert(octeon_cop2_gfm_mul_reflect_readback(
                0xfedcba9876543210ULL) == 0x084c2a6e195d3b7fULL);
+    assert(octeon_rdhwr31_non_decreasing());
 
     return 0;
 }

-- 
2.54.0


