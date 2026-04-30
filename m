Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FEEFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIFAI-00077S-39; Wed, 29 Apr 2026 20:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIF9y-0006oR-9Z
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:42 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIF9w-0006MO-1V
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:41 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-8296dabef74so325770b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777508499; x=1778113299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHbcnnin4MK7f8Hthy49rChr+1IMITnIhpn+z5yiLjI=;
 b=IfYLS5qgyTjoYXUD3k6pIrIrJXeVsnQ0C3RcwuuDIhOwCIfhiiLqOyd5OQX28y5eBX
 PWhnarq27qA917JENGohq92qYMb8HLj0AhmoOsE6niNrXkG5HluTNp22qvwCyBvpTsmX
 mo29JjftX/XrVyBNnvCrPCSgIWaXa4HEwJ8pilSnl6s7dHa/8Fn7pX2e2tPE8oJ2+V7V
 /R0G1LNFLk4hAuPTOrHCS+p0NFLn4rD0K9OIPIAp/Q8LAzJsfPG5O0fCC9tLWNMiKcox
 +oOTkuB6TY5XNamYUgWDL/5xN3MRYK9Z7yUEPnYLgUQMAmVEGg1bBSFI0QjRf0wkw7xN
 oFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508499; x=1778113299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LHbcnnin4MK7f8Hthy49rChr+1IMITnIhpn+z5yiLjI=;
 b=WFB7xpFp3x2qIV/Yel1Vn02nN8MBdapOS8gJYtFWa7Q/8Jp6DS4+w8f3z9gKg9j8YM
 ifttaV7eKNwWcXcKX5yLn7AfEX4NH6z1NLCTlIGZhQcZm4csuvNvwofTKeB/ciHOFmvE
 WA6OtKE79V7f5GdLdE38F/XrNP+CmHwWuh49ok5Rq/tDd2qxMyPxCFgU7AL/pNoa78P1
 fNjgyc93atiwKkLEQbLOCcBDGUJT9PH1ARBg1CPj8vHlf2Qf1n86rId/GHVt1Q35vSl1
 12SIzpaRk38kFuUf8Ps+xqsR2JRg1+O3Jijpvhq4MBOhlrolGBrG1SEBYE36heyrjEQr
 yDbQ==
X-Gm-Message-State: AOJu0Yw7H3LXhrBe5unmqKcGvmZl8hGt3bt9iBiMnZEjHOqhFuZx/i2g
 3ul4S2Kehacgl4N6vgm6yEQ8STRo6N9bObGaqnGiI9LbJ/KqSS9e+HmePFV6sYtQ19UV2FBQcQW
 Vzpl+HiI=
X-Gm-Gg: AeBDiesiguLffinJu//N81Cd5K4nItA9zzTbgHfu7+HA1oTcfFaDlYxo5AY+yxNU+aw
 JcRi88laUNbfaGG1Ga+lgiiaWAtKE7es4BJBDGnZqAtLnPl/6WydIKfHxR9GBmNOnQYJIlbvw39
 7KX4o96qMux2lvgXQtfAJIXJ2bza8tunihD45CGgz1jO7yC8maw7dW3M40rYNMfxwif+aOD3kud
 Z+/iM2Fjri4X+hm1Nl+STJhTdQYHXcriy/NemPc0TC4I6N6v5vY3FdcqenijtZK+7siBeNWtgVK
 syzBBTNauqjnCts0ItdLuRvP/50cXg8tqPFYMclZItTluOHqEFqFSrfFtWQEWXAM33x3TMCimFY
 ajUp8H6usFFYp6O9c6i4f5b9HOYb/oBrsQfesfwpp9dzPLI7bqYCSuxD3Ck+46TWLxII0NygPDP
 6SFGqJusZMBG1wbE7V9l6xYiaeLlB83Jk/+Zrp8wDt
X-Received: by 2002:a05:6a00:3e09:b0:82f:2a78:6302 with SMTP id
 d2e1a72fcca58-834fdbabe8amr930785b3a.26.1777508498633; 
 Wed, 29 Apr 2026 17:21:38 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed5cd3b8sm3461727b3a.16.2026.04.29.17.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:21:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 21/47] target/arm: Implement BF1CVTL, BF1CVTL2, BF2CVTL,
 BF2CVTL2 for AdvSIMD
Date: Thu, 30 Apr 2026 10:20:20 +1000
Message-ID: <20260430002046.59739-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430002046.59739-1-richard.henderson@linaro.org>
References: <20260430002046.59739-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-fp8.h          |  14 ++++
 target/arm/tcg/helper-fp8-defs.h |   6 ++
 target/arm/tcg/translate-a64.h   |   1 +
 target/arm/tcg/fp8_helper.c      | 138 +++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   |  34 ++++++++
 target/arm/tcg/a64.decode        |   3 +
 target/arm/tcg/meson.build       |   1 +
 7 files changed, 197 insertions(+)
 create mode 100644 target/arm/helper-fp8.h
 create mode 100644 target/arm/tcg/helper-fp8-defs.h
 create mode 100644 target/arm/tcg/fp8_helper.c

diff --git a/target/arm/helper-fp8.h b/target/arm/helper-fp8.h
new file mode 100644
index 0000000000..c45211ba22
--- /dev/null
+++ b/target/arm/helper-fp8.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef HELPER_FP8_H
+#define HELPER_FP8_H
+
+#include "exec/helper-proto-common.h"
+#include "exec/helper-gen-common.h"
+
+#define HELPER_H "tcg/helper-fp8-defs.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef HELPER_H
+
+#endif /* HELPER_FP8_H */
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
new file mode 100644
index 0000000000..0caaf63749
--- /dev/null
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -0,0 +1,6 @@
+/*
+ * AArch64 FP8 helper definitions
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+DEF_HELPER_FLAGS_4(advsimd_bfcvtl, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/translate-a64.h b/target/arm/tcg/translate-a64.h
index 9c45f89305..35f8d4f82e 100644
--- a/target/arm/tcg/translate-a64.h
+++ b/target/arm/tcg/translate-a64.h
@@ -25,6 +25,7 @@ TCGv_i64 read_cpu_reg_sp(DisasContext *s, int reg, int sf);
 void write_fp_dreg(DisasContext *s, int reg, TCGv_i64 v);
 bool logic_imm_decode_wmask(uint64_t *result, unsigned int immn,
                             unsigned int imms, unsigned int immr);
+bool fpmr_access_check(DisasContext *s);
 bool sve_access_check(DisasContext *s);
 bool sme_enabled_check(DisasContext *s);
 bool sme_enabled_check_with_svcr(DisasContext *s, unsigned);
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
new file mode 100644
index 0000000000..5566550205
--- /dev/null
+++ b/target/arm/tcg/fp8_helper.c
@@ -0,0 +1,138 @@
+/*
+ * AArch64 FP8 Operations
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "internals.h"
+#include "tcg/tcg-gvec-desc.h"
+#include "fpu/softfloat.h"
+#include "fpu/softfloat-parts.h"
+#include "helper-fp8.h"
+#include "vec_internal.h"
+
+#define HELPER_H "tcg/helper-fp8-defs.h"
+#include "exec/helper-info.c.inc"
+
+typedef enum FPMRType {
+    OFP8_E5M2 = 0,
+    OFP8_E4M3 = 1,
+    Unsupp2 = 2,
+    Unsupp3 = 3,
+    Unsupp4 = 4,
+    Unsupp5 = 5,
+    Unsupp6 = 6,
+    Unsupp7 = 7,
+} FPMRType;
+
+typedef struct FP8Context {
+    float_status stat;
+    ARMFPStatusFlavour fpst;
+    FPMRType f8fmt;
+    int scale;
+    bool high;
+} FP8Context;
+
+static FP8Context fp8_start(CPUARMState *env, uint32_t desc,
+                            FPMRType f8fmt, int scale)
+{
+    ARMFPStatusFlavour fpst = extract32(desc, SIMD_DATA_SHIFT + 2, 4);
+
+    FP8Context ret = {
+        .stat = env->vfp.fp_status[fpst],
+        .fpst = fpst,
+        .f8fmt = f8fmt,
+        .scale = scale,
+        .high = extract32(desc, SIMD_DATA_SHIFT + 1, 1),
+    };
+
+    set_flush_to_zero(0, &ret.stat);
+    set_flush_inputs_to_zero(0, &ret.stat);
+    set_default_nan_mode(true, &ret.stat);
+    set_float_rounding_mode(float_round_nearest_even, &ret.stat);
+
+    return ret;
+}
+
+static void fp8_finish(CPUARMState *env, FP8Context *c)
+{
+    int new_flags = get_float_exception_flags(&c->stat);
+
+    new_flags &= ~float_flag_input_denormal_used;
+    float_raise(new_flags, &env->vfp.fp_status[c->fpst]);
+}
+
+static FP8Context fp8_src_start(CPUARMState *env, uint32_t desc, int scale_mask)
+{
+    bool issrc2 = extract32(desc, SIMD_DATA_SHIFT, 1);
+    uint64_t fpmr = env->vfp.fpmr;
+    FPMRType f8fmt = (issrc2
+                      ? FIELD_EX64(fpmr, FPMR, F8S2)
+                      : FIELD_EX64(fpmr, FPMR, F8S1));
+    int scale;
+
+    scale = fpmr >> (issrc2 ? R_FPMR_LSCALE2_SHIFT : R_FPMR_LSCALE_SHIFT);
+    scale = -(scale & scale_mask);
+
+    return fp8_start(env, desc, f8fmt, scale);
+}
+
+/*
+ * Invalid input format is treated as snan, then the conversion operation
+ * converts to default nan and raises invalid.
+ */
+static void bfloat16_invalid_input(bfloat16 *d, size_t nelem, float_status *s)
+{
+    bfloat16 dnan = bfloat16_default_nan(s);
+
+    for (size_t i = 0; i < nelem; ++i) {
+        d[i] = dnan;
+    }
+    float_raise(float_flag_invalid | float_flag_invalid_snan, s);
+}
+
+static bfloat16 fcvt_fp8e4m3_to_b16(float8_e4m3 x, int scale, float_status *s)
+{
+    FloatParts64 p = float8_e4m3_unpack_canonical(x, s);
+    p = parts64_scalbn(&p, scale, s);
+    return bfloat16_round_pack_canonical(&p, s);
+}
+
+static bfloat16 fcvt_fp8e5m2_to_b16(float8_e5m2 x, int scale, float_status *s)
+{
+    FloatParts64 p = float8_e5m2_unpack_canonical(x, s);
+    p = parts64_scalbn(&p, scale, s);
+    return bfloat16_round_pack_canonical(&p, s);
+}
+
+void HELPER(advsimd_bfcvtl)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_src_start(env, desc, 0x3f);
+    uint8_t *n = vn, scratch[16];
+    bfloat16 *d = vd;
+
+    if (vd == vn) {
+        n = memcpy(scratch, vn, 16);
+    }
+    n += ctx.high * 8;
+
+    switch (ctx.f8fmt) {
+    case OFP8_E5M2:
+        for (int i = 0; i < 8; ++i) {
+            d[H2(i)] = fcvt_fp8e5m2_to_b16(n[H1(i)], ctx.scale, &ctx.stat);
+        }
+        break;
+    case OFP8_E4M3:
+        for (int i = 0; i < 8; ++i) {
+            d[H2(i)] = fcvt_fp8e4m3_to_b16(n[H1(i)], ctx.scale, &ctx.stat);
+        }
+        break;
+    default:
+        bfloat16_invalid_input(d, 8, &ctx.stat);
+        break;
+    }
+
+    fp8_finish(env, &ctx);
+    clear_tail(vd, 16, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ac18ceeeab..085e7e3b95 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -22,6 +22,7 @@
 #include "helper-a64.h"
 #include "helper-sme.h"
 #include "helper-sve.h"
+#include "helper-fp8.h"
 #include "translate.h"
 #include "translate-a64.h"
 #include "tcg/tcg-op.h"
@@ -1457,6 +1458,24 @@ static bool fp_access_check(DisasContext *s)
     return fp_access_check_only(s) && nonstreaming_check(s);
 }
 
+/*
+ * Check that FPMR access is enabled, for an indirect reference by a
+ * vector instruction.  See CheckFPMREnabled().
+ */
+bool fpmr_access_check(DisasContext *s)
+{
+    if (s->fpmr_el) {
+        /*
+         * While denied direct access to the FPMR raises SystemRegisterTrap
+         * and targets a specific EL, denied indirect access to the FPMR
+         * results in a simple UNDEFINED to the default exception level.
+         */
+        unallocated_encoding(s);
+        return false;
+    }
+    return true;
+}
+
 /*
  * Return <0 for non-supported element sizes, with MO_16 controlled by
  * FEAT_FP16; return 0 for fp disabled; otherwise return >0 for success.
@@ -10612,6 +10631,21 @@ static bool trans_FCVTL_v(DisasContext *s, arg_qrr_e *a)
     return true;
 }
 
+static bool do_f8cvt(DisasContext *s, arg_qrr_e *a,
+                     gen_helper_gvec_2_ptr *fn, bool issrc2)
+{
+    if (fpmr_access_check(s) && fp_access_check(s)) {
+        tcg_gen_gvec_2_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           tcg_env, 16, vec_full_reg_size(s),
+                           issrc2 | (a->q << 1) | (FPST_A64 << 2), fn);
+    }
+    return true;
+}
+
+TRANS_FEAT(BF1CVTL, aa64_f8cvt, do_f8cvt, a, gen_helper_advsimd_bfcvtl, false)
+TRANS_FEAT(BF2CVTL, aa64_f8cvt, do_f8cvt, a, gen_helper_advsimd_bfcvtl, true)
+
 static bool trans_OK(DisasContext *s, arg_OK *a)
 {
     return true;
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 02c7264cb9..b7aac148f2 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1910,6 +1910,9 @@ URSQRTE_v       0.10 1110 101 00001 11001 0 ..... .....     @qrr_s
 
 FCVTL_v         0.00 1110 0.1 00001 01111 0 ..... .....     @qrr_sd
 
+BF1CVTL         0.10 1110 101 00001 01111 0 ..... .....     @qrr_h
+BF2CVTL         0.10 1110 111 00001 01111 0 ..... .....     @qrr_h
+
 &fcvt_q         rd rn esz q shift
 @fcvtq_h        . q:1 . ...... 001 .... ...... rn:5 rd:5    \
                 &fcvt_q esz=1 shift=%fcvt_f_sh_h
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 02774409e5..f344222202 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -46,6 +46,7 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'sme_helper.c',
   'sve_helper.c',
   'vec_helper64.c',
+  'fp8_helper.c',
 ))
 
 arm_common_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
-- 
2.43.0


