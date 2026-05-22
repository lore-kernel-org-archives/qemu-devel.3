Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E55CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXz4-0000pt-TD; Fri, 22 May 2026 18:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXy2-0007mP-5t
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:43 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxv-0008MG-Sy
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:37 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-369002b26f4so4443067a91.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487414; x=1780092214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XQO5FSbdBVeFLncgubVNkVi+AOHL2NA1zav3K9CsDrM=;
 b=KKsfksAOBkw8kfDlf4nnM4fvIH5VRw8OgWQ+uDc8JOFiRh+/MwQDTCXJoVopMehecz
 BgV3ATgqUD8tbrs4l6Yw+txBqs3YmXCt9eOc4oJGIZfS8cumtWfsEomnZvWApt5bCfpj
 bE8XWz0oXcMCNc3n536Vp7EehzVwtcl0DBOryAn/1y2M/ZR8J0xiHMPzfGT/FXY7hFoX
 VyhBvL6rhBAGz+Cw2m5ac18noVn2zkI1EfsacTdtONVJyx5hB4esA7WvWsCMoC2mPTBl
 HmrEg4mtpVxAVEL00z0VFzhxpN/RI96CyjzEqotVcSG8IEZSvMDUB448wK7sdqvXkPQI
 EomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487414; x=1780092214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XQO5FSbdBVeFLncgubVNkVi+AOHL2NA1zav3K9CsDrM=;
 b=GEuTOUwywKBbp7rV7orChrWAXXBlsOMIoa8sIepC1sMT9D/be7+2HKV2MevIKufVgv
 ugl7ynIzcsRpzyHHoM7Wn3kLj2ibHo5+roEkQWW4kgsGkulqBImuA9lsx5k9n+V4YFFe
 kB3FhZ4BRM+TnPgTRXxuvYGxgh5rRjuP//cTw+3aQaxCKHLwtX34lHel7RxrHMrGcMPS
 67lllaP+asfkJ3diW28F8SWUM/zi4SMxF7LQXuJnLO3fLtam6bAMt2MOf62eu3cPp5bH
 Fh4BKtn6pW6hKkD8A2mYaQFeoSG1Igv8vOcQgDMZ3vftekf1t2eD4eHpxz5/4KsTxr/i
 JfNg==
X-Gm-Message-State: AOJu0Yx0bc39Vz0cv5OiR1+GC+QlRwErgGhTx9ZHBQOU+dyZWrHwDc7G
 1i42LoRJUuVPoHzxLnQuJQDtO2RXyzfWrvUb+wuh9h/xRzMd/fsYfE3xeBSVphG6IbPo3Dn9JOw
 f/O+v
X-Gm-Gg: Acq92OEMMqYQosQhi+U+437HUKLDQsbFTBMw3hL5atzT+XP/s4qOxvj2rPBMb6GQiNS
 /Lm8n7FyMSFyHCa7YktTgMddw0vMj2UWzpr3w4SSU9FRJzVn6SaWBi3bT7XYIjFJdyDGQ818CAF
 f/mlXHv+K9LgbrkLVKTRNVSJkDZkQCGSDm4tbl1YJNQlC1B2no8anFIAIbVHNJ6R8vOM/hE/5UY
 M5LPwdLJgaMZI1vYcnDAvaX3BJ4QcyzwEAfpzqWPE4zbk3eChMjmRqopAyc6uah6RcdXE7NblVA
 Pv8OuBRdjv2EXK6ICmsSsoSE5oejTWr2l2bNYZpoKwwoUKnycNmzDJYn1uTbQivCKhaCDPawddd
 R2D1bh82DUIwqxYpp3aj2Ovj10ZOen4hJN5SeQi7/cm7eTsTqkEohE84tYi+zXdZU3kwlMV0VLc
 7An7nk6kTJ8MZVHlm8JbGIjk4iPEEP
X-Received: by 2002:a17:90b:2585:b0:366:3ac:f730 with SMTP id
 98e67ed59e1d1-36a6788e0abmr4986795a91.25.1779487414337; 
 Fri, 22 May 2026 15:03:34 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6772f486sm1726789a91.2.2026.05.22.15.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:03:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v7 27/64] target/arm: Implement BF1CVT, BF1CVTLT, BF2CVT,
 BF2CVTLT for SVE
Date: Fri, 22 May 2026 15:02:29 -0700
Message-ID: <20260522220306.235200-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
 target/arm/cpu-features.h        |  6 ++++++
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/fp8_helper.c      | 16 ++++++++++++++++
 target/arm/tcg/translate-sve.c   | 23 +++++++++++++++++++++++
 target/arm/tcg/sve.decode        |  6 ++++++
 5 files changed, 52 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index f9c979d20b..fd09bbc5cf 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1643,6 +1643,12 @@ isar_feature_aa64_sme2_or_sve2_faminmax(const ARMISARegisters *id)
     return isar_feature_aa64_sme2_or_sve2(id) && isar_feature_aa64_faminmax(id);
 }
 
+static inline bool
+isar_feature_aa64_sme2_or_sve2_f8cvt(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2_or_sve2(id) && isar_feature_aa64_f8cvt(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 0caaf63749..18ff483bb0 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -4,3 +4,4 @@
  */
 
 DEF_HELPER_FLAGS_4(advsimd_bfcvtl, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sve2_bfcvt, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index bb3e8dae5f..c62fb2ffd6 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -122,3 +122,19 @@ void HELPER(advsimd_bfcvtl)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
     fp8_cvt_finish(env, &ctx);
     clear_tail(vd, 16, simd_maxsz(desc));
 }
+
+void HELPER(sve2_bfcvt)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_src_start(env, desc, 0x3f);
+    fp8_input_fn *input_fmt = fp8_input_fmt[ctx.f8fmt];
+    uint8_t *n = vn;
+    uint16_t *d = vd;
+    size_t nelem = simd_oprsz(desc) / 2;
+
+    for (size_t i = 0; i < nelem; ++i) {
+        d[H2(i)] = fcvt_fp8_to_b16(n[H1(2 * i + ctx.high)],
+                                   input_fmt, ctx.scale, &ctx.stat);
+    }
+
+    fp8_cvt_finish(env, &ctx);
+}
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index e08802c816..dc832dfd93 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "helper-sme.h"
 #include "helper-sve.h"
+#include "helper-fp8.h"
 #include "translate.h"
 #include "translate-a64.h"
 #include "tcg/tcg-op.h"
@@ -4067,6 +4068,28 @@ TRANS_FEAT(FRSQRTE, aa64_sme_or_sve, gen_gvec_fpst_ah_arg_zz,
            s->fpcr_ah && dc_isar_feature(aa64_rpres, s) ?
            frsqrte_rpres_fns[a->esz] : frsqrte_fns[a->esz], a, 0)
 
+static bool do_f8cvt(DisasContext *s, arg_rr_esz *a,
+                     gen_helper_gvec_2_ptr *fn, bool issrc2, bool isodd)
+{
+    if (fpmr_access_check(s) && sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_2_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           tcg_env, vsz, vsz,
+                           issrc2 | (isodd << 1) | (FPST_A64 << 2), fn);
+    }
+    return true;
+}
+
+TRANS_FEAT_STREAMING_SME2(BF1CVT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+                          gen_helper_sve2_bfcvt, false, false)
+TRANS_FEAT_STREAMING_SME2(BF2CVT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+                          gen_helper_sve2_bfcvt, true, false)
+TRANS_FEAT_STREAMING_SME2(BF1CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+                          gen_helper_sve2_bfcvt, false, true)
+TRANS_FEAT_STREAMING_SME2(BF2CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+                          gen_helper_sve2_bfcvt, true, true)
+
 /*
  *** SVE Floating Point Compare with Zero Group
  */
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 078a085a79..e7984fa8e0 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -108,6 +108,7 @@
 # Two operand
 @pd_pn          ........ esz:2 .. .... ....... rn:4 . rd:4      &rr_esz
 @rd_rn          ........ esz:2 ...... ...... rn:5 rd:5          &rr_esz
+@rd_rn_e0       ........ .. ...... ...... rn:5 rd:5             &rr_esz esz=0
 @rd_rnx2        ........ ... ..... ...... ..... rd:5            &rr_esz rn=%rn_ax2
 
 # Two operand with governing predicate, flags setting
@@ -1090,6 +1091,11 @@ FMINQV          01100100 .. 010 111 101 ... ..... .....         @rd_pg_rn
 FRECPE          01100101 .. 001 110 001100 ..... .....          @rd_rn
 FRSQRTE         01100101 .. 001 111 001100 ..... .....          @rd_rn
 
+BF1CVT          01100101 00 001 000 001110 ..... .....          @rd_rn_e0
+BF2CVT          01100101 00 001 000 001111 ..... .....          @rd_rn_e0
+BF1CVTLT        01100101 00 001 001 001110 ..... .....          @rd_rn_e0
+BF2CVTLT        01100101 00 001 001 001111 ..... .....          @rd_rn_e0
+
 ### SVE FP Compare with Zero Group
 
 FCMGE_ppz0      01100101 .. 0100 00 001 ... ..... 0 ....        @pd_pg_rn
-- 
2.43.0


