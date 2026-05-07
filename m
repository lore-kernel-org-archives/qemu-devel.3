Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D7ACD37A7
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8OX-0000Ts-Vo; Thu, 07 May 2026 19:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OU-0000Pl-Kh
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:38 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OS-000166-8h
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:38 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dbd23bc684so908807a34.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197475; x=1778802275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TSBFCaQ/FzZ2EJFRAwhSYWznbxEVEf4wc9Dmae+R1i8=;
 b=dEpsVfqPHX63FVyMmxkPGigb1TycGahDCISXW26s7wjjSksFO8ITfK/M5ZCGwRA2mX
 CjrQAi0rdsSwkOc4VYb6UqoOnJNMGNUDKLRPV5ADwh0g2nnETsgHvLhwkGl/4/Pdg5sx
 sj/lRURCsfsw1sO5+DSlDDyd4XFQrVnxhNFRLyl1cp9jOb+Ug62LK4k2ZA2FYc8UkkTo
 M3bl+o7Vs9wM6fMsDKsfNyxK7Kn527WaTQnMmT+H8SyBsYa2y8bD0Ml+oCHSCdimeSUD
 jRf8jdR1QUhrHEish/betPdqZtyrdhw5f1IGuxQ5gC+6Z6TYl6KYXlY5mUSWgk80qRy7
 pIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197475; x=1778802275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TSBFCaQ/FzZ2EJFRAwhSYWznbxEVEf4wc9Dmae+R1i8=;
 b=LsS2PnC4FByaAIS6kdYiG5d6KHi8Vm8H6M/1Q5iWIUtkuievHimd35LnpJwAP4RPz9
 QsxZ+UlCnZicDV/cTLr095Zr/ZJMmLwwEaM/CR2k0YurSqYTOPdgJbYAZ5jOnMaQNzvZ
 /03rlClmkUan8RuyhHFifcGv8yGOAhuyiOdq/P26U+F9WJdte+iE/TI8gWwPGeaxHTVJ
 /E0tJMvOBhPSSvTGQpWEU5EZt2rJm5J1KjU9KrwNRQpZyNkMoIWohFwfl8I4jn6MLr/p
 Uy/PO921MxrNBsINE+9fo4/JlVM5rq3dQkNTPomHkEedzx865KasIPSdZtR+23L/UwkY
 3nLQ==
X-Gm-Message-State: AOJu0YwvOeWMIHGr89TTLjRwOwkxfzk52L77Zd9k3Roei23OlexRyxCB
 bDLqZRoltx6LAfhgBpZm2rr7glp/Mn03F/zSickX88Ejxw8WREPYxpeoxFs3+ypxRXCRTzwo2zk
 8Fg6v
X-Gm-Gg: AeBDiesc40ue12LW8CSEKKGFW0VkCU8jlCNome3x8VMkcznPJOpallkCxjRB5qfM/4A
 +f3sRpTZJAtwFj7odoNRBiTrRlNCDsdG0+InDPq+bsxW+ARaO660Ajr/8Pgg1AbnDyfIKBMj6kM
 v5wj2etuwlCPsa17DyWwC4pVJnj1J+VfcKDPsARHdde30WGlKZ/qJEVrcn3BbHLk9LgvXLBGoh0
 uF/UnalJ7gMvNYpHJYqctnW/aMSVzkjL07lklzKROJmF8HoR9yg68c1bct44Rfzmpndq4WBhKLq
 PrwBlxq/RbJOWzoKzhMMFSLVrmj0qitnsq1q0Mp5FwrqSyCyIJHC80I9rizYEB9saGp0VQoiqdC
 oQR4NSAbP05ZhhPRP0ovK446Hdl7b5Ky69XMQTpE5guVey1LQQO/vEfcdez8lEIJ/xY/LB+vzWp
 zaW+W3z36MDqbWK7ryIbGjfsC8ZMS0QcCjKLmcoUS4iOc99g==
X-Received: by 2002:a05:6830:3592:b0:7db:b5c9:2d87 with SMTP id
 46e09a7af769-7e1def36698mr6491350a34.11.1778197475057; 
 Thu, 07 May 2026 16:44:35 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm84320a34.23.2026.05.07.16.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:44:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 22/60] target/arm: Implement BF1CVTL, BF1CVTL2, BF2CVTL,
 BF2CVTL2 for AdvSIMD
Date: Thu,  7 May 2026 18:43:35 -0500
Message-ID: <20260507234413.643512-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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
 target/arm/tcg/fp8_helper.c      | 126 +++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   |  34 +++++++++
 target/arm/tcg/a64.decode        |   3 +
 target/arm/tcg/meson.build       |   1 +
 7 files changed, 185 insertions(+)
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
index 0000000000..7c8c4d6e06
--- /dev/null
+++ b/target/arm/tcg/fp8_helper.c
@@ -0,0 +1,126 @@
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
+
+static FloatParts64 fp8_invalid_input(uint8_t x, float_status *s)
+{
+    /*
+     * Invalid input format is treated as snan, then one of the uses
+     * will convert to default nan and raise invalid.
+     */
+    float_raise(float_flag_invalid | float_flag_invalid_snan, s);
+    return parts64_default_nan(s);
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
index d2364aa39c..56be383189 100644
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


