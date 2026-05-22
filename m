Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1358FCD5BB8
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXxe-0007fS-B7; Fri, 22 May 2026 18:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxc-0007di-6P
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:16 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxZ-0007h7-Ba
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:15 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-367c2a39fcfso3680204a91.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487392; x=1780092192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hqxv3/s9g9FpdtmiuZfUp6vXRNrDfUsFtVIgK8Hro8g=;
 b=pdWm+ipCJa5YlkMR8Dw0h+BFBybCqMU6eGkXjJdK+8YsvJqvcRneA4AUjmaFb44AmT
 X5L3muCnGSXUlMN0vVLdVv7ER2kBrB+BjvvVNI5/r/qz0iZ54SNg8AYjgvn+lReJaUVi
 ZPd6LCts37UrTcsqaN2aHGA84H/4+r0xUhdv8wTZOzr3lJW7MudYHQmix2DPEE5zfXsZ
 g+0r8OBrG1R2mKMlkYtgTaCHWo3uMzRLjwFWuaO8w1LLSdsuzEWGWZtqpZ0kSpGAUFcD
 EViHSkcaJyntla/m8jlFxD/UUxtHD/Inm/o2Mz8i/dpD2/1zZE8mQSt5TVR7669uAc2h
 SRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487392; x=1780092192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hqxv3/s9g9FpdtmiuZfUp6vXRNrDfUsFtVIgK8Hro8g=;
 b=bSIjfA9RrGAcycgNViRcCHjS37HJovgrnXyvTAsp1rQ3q9yUtBPSr/1QnmjoG9sXTy
 42dyQK3aJygFAUnS9kp/mmcIsxDsLaD5zuVRcnE0xRyZBmjkhOFHdLWyst8+eYHXTxpT
 Z4s+CD/c0Vp6aGobjjCRKFQAo3JrBubcgTjenOXgN82dUYNFVbhspHSE2vFm4Qt7WNRL
 vy4/ze7qXWE9uf7vo+rqLfbXw0usP+xPMA3LXXRALAtca1eHnRRLLpjtvwl0JuQ/r9mS
 K2pelhkTGB9Ahj+5PZ8ib/K8oNwUPrvEsnbLIUSpQ138JLKQVbz/vdjNJKpFKzht/H2A
 /9NQ==
X-Gm-Message-State: AOJu0YxjsVKQyIwFALwxHYaGjzuyskIDIuzXD8wJl9QRV6B72GOTJy4x
 ttcDxxLRA9zBEaKpQyxyR4/RNrKUHi4Y5KqXO+5EU1SBFuxsz/FZB9Q8eAiChnfvJUFyjI3NS4z
 LCreS
X-Gm-Gg: Acq92OHHgSeNen7o7S3IYSolH/fCrg0dOvDLwRxOTlgMFL0YRoRBaMYWQexuoEBDT63
 m4qUSrR1lAZoVHUX4glsQxhRHblMV7TgZ4v4RqccHSwuTYd28QpCYcksBMWSzVr4BBTcmV67Xyh
 JNYoc01hKRWdchB4m6RD40wFDcd3ZMbk7YQzjAeyjL/WHq5bmBEFC8/8A2oPhrNqjGrWfRcZLet
 L4Ps6XPFIqGY4Tr4z5aE0UWQ8EGTYzMBVurUybnlVUnfq1eRH1U5SmARJdRJMfudcUSjxahyv2D
 NVQ+MsiT8L/H96hbkFwTkAmyB5pWdQIlORiXx7+iSpzBUjB2mlrYKXSMPWPNOD1Ki2lePgleFxz
 3ZMaVimZNc0tC3a3yMHSogbhO5lksiNpeVX8+wUh4eo9kD/bdlaG+F4dIC69LtQu8L9x82MXgsP
 BbdcvWRpuGQfelXw3hsO08Zd7p9K3k
X-Received: by 2002:a17:90b:3807:b0:366:2e1f:393 with SMTP id
 98e67ed59e1d1-36a676291d3mr5724200a91.21.1779487391703; 
 Fri, 22 May 2026 15:03:11 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6772f486sm1726789a91.2.2026.05.22.15.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:03:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v7 03/64] target/arm: Implement FEAT_FAMINMAX for SME
Date: Fri, 22 May 2026 15:02:05 -0700
Message-ID: <20260522220306.235200-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Since there is no bfloat16 variant of FAMINMAX,
check for missing function pointer in do_z2z_nn_fpst.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/translate-sme.c | 23 +++++++++++++++++++++--
 target/arm/tcg/sme.decode      |  5 +++++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 21a1f941dd..21b91b1503 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1593,6 +1593,11 @@ static inline bool isar_feature_aa64_sme2_f64f64(const ARMISARegisters *id)
     return isar_feature_aa64_sme2(id) && isar_feature_aa64_sme_f64f64(id);
 }
 
+static inline bool isar_feature_aa64_sme2_faminmax(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2(id) && isar_feature_aa64_faminmax(id);
+}
+
 static inline bool isar_feature_aa64_sve_i8mm(const ARMISARegisters *id)
 {
     return isar_feature_aa64_sve(id) && isar_feature_aa64_sme_sve_i8mm(id);
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 08254b088e..a67501226f 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "helper-a64.h"
 #include "helper-sme.h"
 #include "helper-sve.h"
 #include "translate.h"
@@ -742,9 +743,12 @@ static bool do_z2z_nn_fpst(DisasContext *s, arg_z2z_en *a,
                            gen_helper_gvec_3_ptr * const fns[4])
 {
     int esz = a->esz, n, dn, dm, vsz;
-    gen_helper_gvec_3_ptr *fn;
+    gen_helper_gvec_3_ptr *fn = fns[esz];
     TCGv_ptr fpst;
 
+    if (fn == NULL) {
+        return false;
+    }
     if (esz == MO_8 && !dc_isar_feature(aa64_sme_b16b16, s)) {
         return false;
     }
@@ -753,7 +757,6 @@ static bool do_z2z_nn_fpst(DisasContext *s, arg_z2z_en *a,
     }
 
     fpst = fpstatus_ptr(esz == MO_16 ? FPST_A64_F16 : FPST_A64);
-    fn = fns[esz];
     n = a->n;
     dn = a->zdn;
     dm = a->zm;
@@ -812,6 +815,22 @@ static gen_helper_gvec_3_ptr * const f_vector_fminnm[4] = {
 TRANS_FEAT(FMINNM_n1, aa64_sme2, do_z2z_n1_fpst, a, f_vector_fminnm)
 TRANS_FEAT(FMINNM_nn, aa64_sme2, do_z2z_nn_fpst, a, f_vector_fminnm)
 
+static gen_helper_gvec_3_ptr * const f_vector_famax[4] = {
+    NULL,
+    gen_helper_gvec_famax_h,
+    gen_helper_gvec_famax_s,
+    gen_helper_gvec_famax_d,
+};
+TRANS_FEAT(FAMAX_nn, aa64_sme2_faminmax, do_z2z_nn_fpst, a, f_vector_famax)
+
+static gen_helper_gvec_3_ptr * const f_vector_famin[4] = {
+    NULL,
+    gen_helper_gvec_famin_h,
+    gen_helper_gvec_famin_s,
+    gen_helper_gvec_famin_d,
+};
+TRANS_FEAT(FAMIN_nn, aa64_sme2_faminmax, do_z2z_nn_fpst, a, f_vector_famin)
+
 /* Add/Sub vector Z[m] to each Z[n*N] with result in ZA[d*N]. */
 static bool do_azz_n1(DisasContext *s, arg_azz_n *a, int esz,
                       GVecGen3FnVar *fn)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 6bb9aa2a90..9dec7318a4 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -286,6 +286,11 @@ URSHL_nn       1100000 1 .. 1 ..... 1011.0 10001 .... 1    @z2z_4x4
 SQDMULH_nn     1100000 1 .. 1 ..... 1011.1 00000 .... 0    @z2z_2x2
 SQDMULH_nn     1100000 1 .. 1 ..... 1011.1 00000 .... 0    @z2z_4x4
 
+FAMAX_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 0    @z2z_2x2
+FAMAX_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 0    @z2z_4x4
+FAMIN_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 1    @z2z_2x2
+FAMIN_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 1    @z2z_4x4
+
 ### SME2 Multi-vector Multiple and Single Array Vectors
 
 &azz_n          n off rv zn zm
-- 
2.43.0


