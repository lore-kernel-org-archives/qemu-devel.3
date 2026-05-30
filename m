Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CBECD6E56
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 23:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTSrD-0008Uw-3w; Sat, 30 May 2026 19:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSr7-0008QH-Uh
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:12:37 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSr4-0007NX-Up
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:12:37 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-36b8d414666so1818830a91.3
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 16:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780182753; x=1780787553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3gYBbtUGELx0hsEbLr99DHr0CBTTSqCEowLfHMa0ccI=;
 b=tLBI/X698ah898Wg3AFFPD6+TRhof4gMt6wR2u2/yE3hKaeOFuhZPwJdNZf3hp+YA4
 pFfyXcPUtZyXcgf51JaKGyoEmJevFna3Q9vghPDd2WwX1ogYQeDgQ6n0NRGS3iwm6LqC
 305BSY6rgD9CsXbW3nh3pahSiGBWPU51w6EbQuIPw4GHC3I07ugb8G1X7SselZyRh5JM
 7xF8q2Sxhq1/cI2BNNQeALlVfpD9lsOWxOBDtsWF6GwJ2p63MZONQqiRu0WFuy6sL3Tx
 EJD3zabRFfz5kWLX/RUH9TNCcyPOVNtKUP+POo9y/bMJ8Nea5HW5TEIJEQLlxiLTypQG
 Y2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780182753; x=1780787553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3gYBbtUGELx0hsEbLr99DHr0CBTTSqCEowLfHMa0ccI=;
 b=hwpryzAuJSn7oE0sspUNxqqtEDlJnLiwW0PcRzO3XeV8pfcxPeclIMS84njUXrQjBy
 UoPC2PeSpQjYzwoWnYKACw4wQPRLTMfejgz1+qzm9BRFo5Sy8l8MQ6fe2ErLAnK0JzyC
 fR+4SiwMkkTK6r7JerIBjL9x/Q+J0CEFNBxB4+hLAc0eBZFrcRH2mMKlrX+YId2YUAq5
 ELHanp3f3XgZ5pyST7yO0WObe1fiZCjo90cDwgLiFWi3Qlp+LtlUQlByvHNqr47eVZbm
 odEcgTMtxoRz9EHk16ITs8h+lQJNhI2jT9+X2RQ3T7kICQVrWFIRYWp9NU/2ACXbIEmP
 ZvLQ==
X-Gm-Message-State: AOJu0Ywy/uRqDkAYNi7+WNPjjraABgpctDiDdsJ6xudxMe0zb/RgP0tf
 3al5GbUaS28NLo00hAySoBSLbVmNLMmId7KHvXjirgBmmAGJDwEjg1JQXgou8zKRRnhuVjUkH8h
 1JVKsaSE=
X-Gm-Gg: Acq92OG3TvADxJb7LNEIJuNHn3TIOzXch69/shI2LBINw5AG+2VSro4zAnGEboyA8zo
 x3WRl6Jsf7Jj2/YWpRO24JuD2EJtF4VLZ1B+4vhT5wZQFfOCkVw6MkLlHtC67Pgr1Ti4HGFUH2+
 LJQsjIDjTUw12hS+TMHZj0YFSoJFrSmAG8VB8BSKG9kh/g6l1t4isr0MZbhPYGKbOSxPuZ7ONk6
 UIlFmf+TU/vVBz0FzCEiAjkmcJcytVBeIDOi0uzKBT6Wc+SNLEwNA8qOY1vVFoxz7Orx3KCsPTt
 xFBjQLlv0RwlWgjdIP0TVJhPj3cbaxdAxQm8L308qjB6v2WmysJDFFoYGXq17GaKUuzwIT0l6da
 kogprp1mjmmvUZCoEa9iOtVZEX/aP6Uhnwnlk4XbNffeSgwx1Pz8Oj4A2wtSU40MohGG2Gk2CoT
 Lqly+80E0m5ohqNixQdz3lqv8BPQAoo9lMNenIt6U=
X-Received: by 2002:a17:90b:3b85:b0:36a:caf1:b20e with SMTP id
 98e67ed59e1d1-36c4ff25b76mr4972520a91.3.1780182753059; 
 Sat, 30 May 2026 16:12:33 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c857729d3d1sm5634356a12.21.2026.05.30.16.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 16:12:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v8 03/41] target/arm: Implement BF1CVTL, BF1CVTL2, BF2CVTL,
 BF2CVTL2 for AdvSIMD
Date: Sat, 30 May 2026 16:11:51 -0700
Message-ID: <20260530231229.400441-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530231229.400441-1-richard.henderson@linaro.org>
References: <20260530231229.400441-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-fp8.h          |  14 ++++
 target/arm/tcg/helper-fp8-defs.h |   6 ++
 target/arm/tcg/translate-a64.h   |   1 +
 target/arm/tcg/fp8_helper.c      | 124 +++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   |  34 +++++++++
 target/arm/tcg/a64.decode        |   3 +
 target/arm/tcg/meson.build       |   1 +
 7 files changed, 183 insertions(+)
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
index 0000000000..bb3e8dae5f
--- /dev/null
+++ b/target/arm/tcg/fp8_helper.c
@@ -0,0 +1,124 @@
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
+static void fp8_cvt_finish(CPUARMState *env, FP8Context *c)
+{
+    /* FP8 convert insns don't update FPSR.IDC */
+    int e = get_float_exception_flags(&c->stat);
+    float_raise(e & ~float_flag_input_denormal_used,
+                &env->vfp.fp_status[c->fpst]);
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
+ * Invalid input format: we could take one of the usual set of
+ * CONSTRAINED UNPREDICTABLE options for use of a reserved value,
+ * but choose to take the additional option provided by the FPMR
+ * register specification, of treating the input as if it were an SNaN.
+ *
+ * One of the uses of the input will convert to default nan (because
+ * all fp8 operations use default_nan_mode) and raise invalid (which
+ * the operation might suppress by not updating IOC).
+ */
+static FloatParts64 fp8_invalid_input(uint8_t x, float_status *s)
+{
+    return (FloatParts64){ .cls = float_class_snan };
+}
+
+typedef FloatParts64 fp8_input_fn(uint8_t x, float_status *s);
+
+static fp8_input_fn * const fp8_input_fmt[8] = {
+    [0 ... 7] = fp8_invalid_input,
+    [OFP8_E5M2] = float8_e5m2_unpack_canonical,
+    [OFP8_E4M3] = float8_e4m3_unpack_canonical,
+};
+
+static bfloat16 fcvt_fp8_to_b16(uint8_t x, fp8_input_fn *f8fmt,
+                                int scale, float_status *s)
+{
+    FloatParts64 p = f8fmt(x, s);
+    p = parts64_scalbn(&p, scale, s);
+    return bfloat16_round_pack_canonical(&p, s);
+}
+
+void HELPER(advsimd_bfcvtl)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_src_start(env, desc, 0x3f);
+    fp8_input_fn *input_fmt = fp8_input_fmt[ctx.f8fmt];
+    uint8_t *n = vn, scratch[16];
+    bfloat16 *d = vd;
+
+    if (vd == vn) {
+        n = memcpy(scratch, vn, 16);
+    }
+    n += ctx.high * 8;
+
+    for (size_t i = 0; i < 8; ++i) {
+        d[H2(i)] = fcvt_fp8_to_b16(n[H1(i)], input_fmt, ctx.scale, &ctx.stat);
+    }
+
+    fp8_cvt_finish(env, &ctx);
+    clear_tail(vd, 16, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3c091ccc56..5c6e88e0bc 100644
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
@@ -10695,6 +10714,21 @@ static bool trans_FCVTL_v(DisasContext *s, arg_qrr_e *a)
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
index d8a3269573..e30c7e5ca9 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1921,6 +1921,9 @@ URSQRTE_v       0.10 1110 101 00001 11001 0 ..... .....     @qrr_s
 
 FCVTL_v         0.00 1110 0.1 00001 01111 0 ..... .....     @qrr_sd
 
+BF1CVTL         0.10 1110 101 00001 01111 0 ..... .....     @qrr_h
+BF2CVTL         0.10 1110 111 00001 01111 0 ..... .....     @qrr_h
+
 &fcvt_q         rd rn esz q shift
 @fcvtq_h        . q:1 . ...... 001 .... ...... rn:5 rd:5    \
                 &fcvt_q esz=1 shift=%fcvt_f_sh_h
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 9b859892ed..573e8b5af4 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -41,6 +41,7 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'sme_helper.c',
   'sve_helper.c',
   'vec_helper64.c',
+  'fp8_helper.c',
 ))
 
 arm_common_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
-- 
2.43.0


