Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A840BCD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlZU-0008HL-UA; Wed, 20 May 2026 14:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlZB-0007PE-HK
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:49 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYw-0000bl-ST
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:47 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3664df32e91so5601623a91.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301352; x=1779906152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5kqQua5TfItd1iP0rVbQTk3uLPPAcfM0L2Au+0dg1yc=;
 b=em7f6k6/VIW2+4hp+QffcdZyGhXd8pDZMmKXcMQXIbpndv0fwHnklez7dnRBm6ySYa
 usk7CXI5wgjvcCcbEnQJImuhcTjCMqnKfiYp4UQpdiZ5EGisO/N4uZ0iSZ0lkXROJKZ0
 g1LpADuzErr+eNUD6b8va5i9rRLxDMsBs10q1FSgkDbzNIc05b/zeOJ+P1m3Cky9EEGB
 tCIlKWZqZZShdyg1XRoPhf5L0o+OIu74q10trwGDzkNjAmBEcF/Xx191GqEW9GuucCa5
 gV7oOkScPeMG904fLifQVeIkV73QtA2CIxvVNd7KSiEZYndSERNgL4LXW6K2akVuH3zl
 zS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301352; x=1779906152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5kqQua5TfItd1iP0rVbQTk3uLPPAcfM0L2Au+0dg1yc=;
 b=dmyUQaq6ZmhhaYf4Dg0lwZihh5/+tt/1K8ROUAmSDBHnm8JNc8N42KN7g4n5LlCCFj
 XZXOqHmv3IoxppRIv+t5c4ksbI0VN6+AI9GNwrJ6T7Rmw/ut0Kx1qfWlna9vRdm/YAuu
 GSR0UxPfy1kZWXjwJvP9zUIyvjbk5RSRQ6vXw1ix+lKj005QkgvHal9sJg8h3c0lUQzw
 o8FPBOIkxA1oiEZKhJULj1KT24ZLy2EfnjDq4gppY1ElLhgoFV65AOK1HDXW81cRU6vw
 +ThWVybKqXGPIW4WNF/X7hKGwSDMj67m/tyww0Un1LmcCFREagyprGlr7Rh0eT3iG/10
 Di6A==
X-Gm-Message-State: AOJu0YwcfBMqNm05Tdz+AG2B6/hIgtwDqVAEPHe0K6nR+t/bIpXuHdLr
 7F1CcVB6QHgEHc/VUETuvxL16xblihICIdXbh1GEef1ZfqGDMSlcUjL4DWyawHMkvkdSlpr1PmX
 Pptfzwhk=
X-Gm-Gg: Acq92OHkewqT/8s6flGJljUxzZ/cOoFEmLYchfjuC9KhOAnqvjm53ekYTLFYF7nLKRF
 U4hDEavJBQCBsGxt3REOiG8HUI3V8gvBpDX9VJSvlV/lgCSUSdIxOhefDqo6xQGKK+fWzqr57kY
 JOOI2XnPHSKIM54PFCfPaQVm5WHmsOJ0SBTk8lFYf3gD84+YVWjI6iNIev3dBRYob4Xc04/m8ke
 Dtrao7d/rIXqEi+tbIAtrNQi16+R4UxcTXEI/60GNTQQv9Pdon1DnlZv0vUiJ7pp3wfF/m3dxpm
 NM9XmXD0yMRzQk5tDOrc4x3yC10nfRwtYccC+rWUatMUVD5aPE1uFLOyz8DADZUXUThsihvINVG
 VCRmwvYWqYmo1/75x7+xJNC5SETKCtc+AVBcsQwi9PczT+efmHC8hsK90kyw4zJyTfpHf/T5Rud
 1LZ4+uWO8RJViuHT1s1qmA5z7pmt1E
X-Received: by 2002:a17:90a:501:b0:369:7421:75c3 with SMTP id
 98e67ed59e1d1-3697421c76amr11958432a91.16.1779301351475; 
 Wed, 20 May 2026 11:22:31 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3d210b4esm274764a91.17.2026.05.20.11.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:22:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 24/64] target/arm: Implement BF1CVTL, BF1CVTL2, BF2CVTL,
 BF2CVTL2 for AdvSIMD
Date: Wed, 20 May 2026 11:21:33 -0700
Message-ID: <20260520182213.872945-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 1b751d5918..c1b3d8e340 100644
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


