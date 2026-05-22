Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F8ECD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 05:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQIJX-0003LQ-Un; Fri, 22 May 2026 01:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQIJO-0002za-Ro
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:20:44 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQIJM-0002E8-WD
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:20:42 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4855562f32eso5142b6e.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 22:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779427240; x=1780032040; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ligDnecCtveNInNVdf6mxSKRJEEchFOLQXnvzn95ews=;
 b=GJF0gh+zXKIOMKTY1OmR9H41m9mRZYXe9qLFK4pITsSQXd3boiW4HhSeo5ZJRKVnJk
 zQPylPp75pFkGL3YXNV++0NKWzI7lnqAw4xqAPCNzJJxwtOBIiSV0QAa68JoNZqSchvt
 dFKN53nSXrmKAGNOwcdFAKP7RyXZOQGIOUhZ4LzRP65ZonYQBX1mi2FmBOiyxAoIS16g
 wWi8e/nDkU8R3uNcR+eubHXnqVdeA1R3Bd8uCM7PpnDS7pM1i6td2AtfzSP9I+z3e95Z
 9Fha9QG4v17cgBOa4qgXGwBz/Rx3DbQfsM49rpP23GrpRyiJppRJUDbWr5lbcMSJWQuG
 tA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779427240; x=1780032040;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ligDnecCtveNInNVdf6mxSKRJEEchFOLQXnvzn95ews=;
 b=iICAmg8CX6MVYcQoHBOR8KajwJDk2C/NDp9Kulb0ccg3ljELdNNz9qy04+8y642Xny
 FdwF7GdF3ydFBeIu4jingiglbjsnRIESNdZQdPxvWef9zubWeZGyLAVzezQ/ZAnrRcCB
 5JpWXwy3encdIetQII6Dg/NInj62p7ujAKtDa50IkFcLZgrHFMrOk2ERLnPeDDiKXEPF
 oHuJKYP923CFafvJ+AJvddXEraXT6xB2SRVWtzt2jo4BwplLt2aQEiqr85BQL20ldGaP
 qyITzFvkZnhHWueKpbD3ZxU7CvvUe4k4HsreKS054ueJjXdHJFSwdzDn2vwrXZOhbfRs
 NbTQ==
X-Gm-Message-State: AOJu0YxHRYIIywmgWpRd/jPJq5WN/Lz0KEeYPD1+Llx3WY1MjnNB1dan
 QsTWndDSWvYg76TzITuOtIEWJVcaOOo+NzN1OJ5RxWxzCaqm2yAIuk67
X-Gm-Gg: Acq92OGizwnsK7U9fbwYMPjD1dVT/U3CD6Z/ZDdveGCbUFScH8XLe/+hFLVKRWF+uOT
 cALe/piaO8InvSKSzwgdPVgj+MpLx8dRY4cZnf8cNzNjp91SVqs1mpWTcZhr9GWbdw/hNfaoJf5
 8MtBEiX8xb9wsvF1W6Aif4d8GobOOFcoKgINzF4y3pdpr/61pnUalbPymOwu56tLQRBo2CCMvqn
 J9Ln/P813fRZ0BdTyTWLs9daXuzppxYl0PNcZeb7NMFv2vPpz4gC8nemkU7KnK0lRtTFISqHgr1
 9pBDhYNRoRtvQrqrY8xSEILHZJLsmBl8p/TDyzRTJxcPSPfruWIOx13rfp3gMv667r5L48UqQPm
 NvLuQnfBNSTGcTvBdVpZaXouGqOTPFt+UFvb6vcYIRkMZGQhvkXKEZBCYEEBvduE6d7L5A37IlN
 j+TJmDWSPDY5zkGYmQQxXfnTp76Gv5tWrzktrTDTPPkcvR+xD0h61oYKNkQ543uXiX+l+UN3+cu
 VOOlSwEa2qcAEhMnJlgRC9zEW92pbo+j0pIhoVLMOugbZNU9nrrCUiACcbTcBDCgLtb9gV///on
 gJQ=
X-Received: by 2002:a05:6808:1804:b0:485:3a2c:e78f with SMTP id
 5614622812f47-4854a3fecc3mr1061756b6e.40.1779427239850; 
 Thu, 21 May 2026 22:20:39 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4855476ab77sm59690b6e.17.2026.05.21.22.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 22:20:39 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 21 May 2026 23:20:03 -0600
Subject: [PATCH v14 21/22] target/mips: add Octeon CvmCount RDHWR support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-mips-octeon-missing-insns-v2-v14-21-fbf08e164830@gmail.com>
References: <20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com>
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22f.google.com
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


