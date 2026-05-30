Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8406CD4F54
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 23:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTSrA-0008Ri-7G; Sat, 30 May 2026 19:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSr8-0008QO-5D
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:12:38 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSr5-0007PO-Pv
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:12:37 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2bf0ddaf50fso16860345ad.1
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 16:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780182754; x=1780787554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nmiRozeaSkxx/AX0Pl05g8NldXlE40mpBTdBsa5MDwg=;
 b=HYX/UDoCQiHlyv8IKoBM1pdzBLh3ZRxu65dGwT/jTDPqjrvAJCKt/VpFd4zLCY2tOR
 g5XXRHK+usDKOpl5je9B0q7owCKC4orNqsIYnit5XntMoSVGEv9KnuAe0aRvnzpEfsyD
 k7PEhdgVqr34VzO4OlEjTblfPmXbtwAtKsuuyZF67qx9BRAeEX4xrr/RwbX8jaIPXPGf
 XIgfAQmSEJGJqwfp+2IzFRQd5t2ge5P6KE4cxkd3nYj5s0IfssnX9YJSy+803eODtPOz
 JxyBfcm6FpHG1mK3qpMFRzVX3RwyPTEraGYDJYDMAqxZb7J3hwyBgAA+14usOxA/Vdun
 4ZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780182754; x=1780787554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nmiRozeaSkxx/AX0Pl05g8NldXlE40mpBTdBsa5MDwg=;
 b=Fsul4ogUJA7C9FbXlTifdi+AE/k9rIs8iAHnzHrv+GOadvWtyp3IRdcZxPOC87VDXl
 R0XcYUyTZAQKKH7Y25pZ9PhGis44UmomiYNeRhTuVrBXfW70Fiwo1Y1fbmUFyc8d+qQG
 b3yG2jrW8vzzBOPozela9tDlAJ9QLUD/r815CRM3uTMWMiRNKlXpf+0TQjKpnO2EsZ/K
 VzzQAZoLdE/R4C23Hq8tr99a8lP429mO5KcObsoIbFp9ws1OlLOPwqFbRb5TnGlmQ9S5
 R6ddE9tCMAcDx/D9PABx1/KZbncHaco/v1Clj9Z0+hSSHXSSDLPnAw8jgGTtQCco5CxG
 /ziw==
X-Gm-Message-State: AOJu0YwGLLSzWK/EvUa5Gr8up8k4v+55FDQe6xRCVSwHODmkGdgOuWcM
 dq2JZEYB3+jR6ncYJcXdVWRyA7TTkGHTovfOyPR5Cnji9cGlqrPh+USWqkS4PsD/x9oMJyjlYqb
 4gnYQEkI=
X-Gm-Gg: Acq92OEGpSE8LNaEl7Rk8bVIfweKgfYREshffHMxqxavpKBRdu+GQXU7QEtPO1uJOSD
 igJspxt67LmF2E4NS3D2FtG+iDusobOGPDNACo0VGvmLNDljf2Xh+HOwKws8pOhJ+8t4un/t3YU
 mWaLiisr0Zk5oXSxyxSW+ChfiDy0NKzdRfZB4XJ2WFNj2xn+QzTrCI/yBbhJ5txczBLxgoSde58
 f5ZXj4R1+lMT4MpYw/XR4e3a9yNULaDRDs4C0oNnsnEGYuzJloJxvtg/UDQf0fqL1joRWi7NfxW
 rrKmYzFTSddueM9XdYrXq5SH/9g+/rwTEqJB8a43vfvkEsIbhKtqMqJteAmz95x8ujoMN+eTCRH
 EFzwp6gVk6SfG1+tn3tFrE6d1s1eFq0HtqJVj1HRKuvSf0DOQnHR9ZtkApknEiOJVhwJi9MY00x
 KK7TJjO8MPKUjQT5rXYVh9qiswz+XcQ6vH1x88kpY=
X-Received: by 2002:a05:6a21:7107:b0:3aa:ec27:e5f7 with SMTP id
 adf61e73a8af0-3b4282ff034mr5401401637.42.1780182754201; 
 Sat, 30 May 2026 16:12:34 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c857729d3d1sm5634356a12.21.2026.05.30.16.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 16:12:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 04/41] target/arm: Implement BF1CVT, BF1CVTLT, BF2CVT,
 BF2CVTLT for SVE
Date: Sat, 30 May 2026 16:11:52 -0700
Message-ID: <20260530231229.400441-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530231229.400441-1-richard.henderson@linaro.org>
References: <20260530231229.400441-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
 target/arm/cpu-features.h        |  6 ++++++
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/fp8_helper.c      | 16 ++++++++++++++++
 target/arm/tcg/translate-sve.c   | 23 +++++++++++++++++++++++
 target/arm/tcg/sve.decode        |  6 ++++++
 5 files changed, 52 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 38a695ded7..70649fe894 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1653,6 +1653,12 @@ isar_feature_aa64_sme2_or_sve2_faminmax(const ARMISARegisters *id)
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
index fb9d379184..0b03afe7a1 100644
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
@@ -4068,6 +4069,28 @@ TRANS_FEAT(FRSQRTE, aa64_sme_or_sve, gen_gvec_fpst_ah_arg_zz,
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


