Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133ADCD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlZJ-0007kJ-I3; Wed, 20 May 2026 14:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlZ4-0007HO-Gl
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:45 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYt-0000Yh-J6
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:42 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-365d8e43759so2814320a91.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301348; x=1779906148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+C8mEcK0Q/wuIBusokIyMGl5OxDZ+zgF0Mzf/nkafIE=;
 b=xuG8KstbNNiVXVpOWUr7KONkWfN7psWfzKeFINiuWbRDdk63GBGwG0ji2tojmls1nq
 1502FrZM2eAnhWNbbL8kDSQfhQFQfEZzdWUta+xQTjV2UQz70O0fxumpcqUHOHL+86Eq
 cvABPSmKFbuZ4Yt7cDXeIynAWPHRmZwNYEwCOWyk+L8YaANrxANL/lWmZzjkfIYUemKW
 8WX/Si8zXXNRlU11eQnbqR5azkWhaBoFOmzGcgIFy40qjXoa1FBVdlb3EFLlo5ag+Ys+
 YRXu0hjNj1s/bvOC1MScEjgXv00uSsrktHS8tRM+td8r53uxno35i1hUbBeWcNf8C01A
 wAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301348; x=1779906148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+C8mEcK0Q/wuIBusokIyMGl5OxDZ+zgF0Mzf/nkafIE=;
 b=ac+MFYj2wF1wMTsCatnv/Tpa2mTvMbZokMgGA8QHgH6XRYCyHRiZ7pXCqrDKJfuUNh
 sIkcxRg8EfrzOOqdV5XtC2UZeXkc7hh64G0RhOFIuKnSgSLazVSG5OiL9dRA0eWyNmYJ
 EUVYIBzj56Rnsga8tkHQua01D2YBQSkbghCMXbkOBVqkRQYi1HRRTwseY3wuR7Nh1HMb
 S++k1MAmQGqyvSOzD5ZNewGp9yboLMOm1ms3vP67MElg30tEd2gXqE7e65hOh9V70k+i
 2Vmk3dzWOScBNoaIXtodpRjpY4sOxkgW5OwMmMO7iZvTmUILK8grd/jWIebhEYXscSwQ
 wcQA==
X-Gm-Message-State: AOJu0YzGcQc7iRUltrP3Ig/TFgTVmCTs5cLM421q2Bfat7Xyn/QwIabt
 VD4Na7BEad9s+e+aOHMXoyQjcCTltG7qgaom0cm0Z8wE3TkxySjCoT7RwjEh1zVk10f+6lNGKNa
 4ybxB7wU=
X-Gm-Gg: Acq92OGwxTJ7fZ6UaXIEcQS0B4gKy0Dv+qDl7itxwKm4uf0JW2KbUtI4DBBKOHYFxU0
 CRZoaZjHtqFJz2goHK3dqd91mwsXBCuPMqJ5saq6VAkiejl0ivPZ7EfUMm5oFlxHB1FueNPllDb
 XehIr9JnpFPPhMZqSW88TEVdq7w/hcia+sAZ6fx+t0hc6CRXlaAKhKWrwxaCGvlP8m+4wdPu3Ba
 F8UIST1ycmYXysdb+XHdOXJEINiGhx6zyGuZgtzarDV3NJzyVQDUgZu+hxzIwFpeQgQhn0MUfSv
 SnuixzHDY1uyloIJK993zPHWj3IWY84utuS8VCwmVEwvMROxCVpxUIsWoeXZxoLS4cEevub8rIe
 dBbdMfw96eWOZ68FqtJpSIRUeZrdckQUjfr/5t76rhq8NajTDGv33v/7ue6Tf8Kl2QwGIKYReL6
 r/CGEM76h6npt1LIcS9omDqKhlk6XP
X-Received: by 2002:a17:90b:2e8f:b0:366:5283:cddf with SMTP id
 98e67ed59e1d1-36a3cc8fc0fmr415494a91.9.1779301348198; 
 Wed, 20 May 2026 11:22:28 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3d210b4esm274764a91.17.2026.05.20.11.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:22:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 20/64] target/arm: Implement FSCALE for SME
Date: Wed, 20 May 2026 11:21:29 -0700
Message-ID: <20260520182213.872945-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/translate-sme.c | 15 +++++++++++++--
 target/arm/tcg/sme.decode      |  6 ++++++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 1fde3e9231..f9c979d20b 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1622,6 +1622,11 @@ static inline bool isar_feature_aa64_sme2_faminmax(const ARMISARegisters *id)
     return isar_feature_aa64_sme2(id) && isar_feature_aa64_faminmax(id);
 }
 
+static inline bool isar_feature_aa64_sme2_f8cvt(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2(id) && isar_feature_aa64_f8cvt(id);
+}
+
 static inline bool isar_feature_aa64_sve_i8mm(const ARMISARegisters *id)
 {
     return isar_feature_aa64_sve(id) && isar_feature_aa64_sme_sve_i8mm(id);
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index a67501226f..e2d17de165 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -707,9 +707,12 @@ static bool do_z2z_n1_fpst(DisasContext *s, arg_z2z_en *a,
 {
     int esz = a->esz, n, dn, vsz, mofs;
     bool overlap = false;
-    gen_helper_gvec_3_ptr *fn;
+    gen_helper_gvec_3_ptr *fn = fns[esz];
     TCGv_ptr fpst;
 
+    if (fn == NULL) {
+        return false;
+    }
     /* These insns use MO_8 to encode BFloat16. */
     if (esz == MO_8 && !dc_isar_feature(aa64_sme_b16b16, s)) {
         return false;
@@ -719,7 +722,6 @@ static bool do_z2z_n1_fpst(DisasContext *s, arg_z2z_en *a,
     }
 
     fpst = fpstatus_ptr(esz == MO_16 ? FPST_A64_F16 : FPST_A64);
-    fn = fns[esz];
     n = a->n;
     dn = a->zdn;
     mofs = vec_full_reg_offset(s, a->zm);
@@ -831,6 +833,15 @@ static gen_helper_gvec_3_ptr * const f_vector_famin[4] = {
 };
 TRANS_FEAT(FAMIN_nn, aa64_sme2_faminmax, do_z2z_nn_fpst, a, f_vector_famin)
 
+static gen_helper_gvec_3_ptr * const f_vector_fscale[4] = {
+    NULL,
+    gen_helper_gvec_fscale_h,
+    gen_helper_gvec_fscale_s,
+    gen_helper_gvec_fscale_d,
+};
+TRANS_FEAT(FSCALE_n1, aa64_sme2_f8cvt, do_z2z_n1_fpst, a, f_vector_fscale)
+TRANS_FEAT(FSCALE_nn, aa64_sme2_f8cvt, do_z2z_nn_fpst, a, f_vector_fscale)
+
 /* Add/Sub vector Z[m] to each Z[n*N] with result in ZA[d*N]. */
 static bool do_azz_n1(DisasContext *s, arg_azz_n *a, int esz,
                       GVecGen3FnVar *fn)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 9dec7318a4..ee874be1a6 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -250,6 +250,9 @@ ADD_n1         1100000 1 .. 10 .... 1010.0 11000 .... 0    @z2z_4x1
 SQDMULH_n1     1100000 1 .. 10 .... 1010.1 00000 .... 0    @z2z_2x1
 SQDMULH_n1     1100000 1 .. 10 .... 1010.1 00000 .... 0    @z2z_4x1
 
+FSCALE_n1      1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_2x1
+FSCALE_n1      1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_4x1
+
 ### SME2 Multi-vector Multiple Vectors SVE Destructive
 
 %zm_ax2         17:4 !function=times_2
@@ -291,6 +294,9 @@ FAMAX_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 0    @z2z_4x4
 FAMIN_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 1    @z2z_2x2
 FAMIN_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 1    @z2z_4x4
 
+FSCALE_nn      1100000 1 .. 1 ..... 1011.0 01100 .... 0    @z2z_2x2
+FSCALE_nn      1100000 1 .. 1 ..... 1011.0 01100 .... 0    @z2z_4x4
+
 ### SME2 Multi-vector Multiple and Single Array Vectors
 
 &azz_n          n off rv zn zm
-- 
2.43.0


