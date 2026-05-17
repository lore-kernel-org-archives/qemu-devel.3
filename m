Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AF8CD4F3C
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPPd-0007vY-Ap; Sat, 16 May 2026 20:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOm-0007E4-Ae
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:36 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOh-00052G-W3
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:27 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c82a6278a4cso836713a12.3
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977821; x=1779582621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+C8mEcK0Q/wuIBusokIyMGl5OxDZ+zgF0Mzf/nkafIE=;
 b=zP9IP3LnFImmXgHeR/J6wvWRWqXhx4qxu+Jzu20JEXLnUDJ6PnO26c5CNrYD/lwGCP
 U7ICHp4fC3UVlT9SAPO9UCI+Ld19yUhbt4ojw72vj3p4quv34Ojf+j/jKM9Tf8wNymZ2
 oPabS5/DwczSkslmogT6rjDwrDeT0JqHX0dAruj0rXCxewuFrPYWpGiZTfrri0xg8r5f
 8Hrxgt6uVXY9Kzi8YuLMOxWqvzT7MGyWD/TKYgBPobEDjZkzFMIdO8SBhfdRzMlp4dId
 tvsF1sCdhfM5pNUhxW+ZMf9IUolz3aOg7+k4T5X4Yw98Gr698fh3wivpY6kIBGcp8YGF
 siHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977821; x=1779582621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+C8mEcK0Q/wuIBusokIyMGl5OxDZ+zgF0Mzf/nkafIE=;
 b=O+Azx2VbPw/r/zaOWpnNKjLdbLeZ9uTnxDzKCQU9imuKdMTBxWTdNj6C0QlYdOcY5R
 edgy1gLN11vNub07TLEZEL7sTvr29TvKDdzkhtQh1T0KiYp2HmE2Gtr3C6tfPCMWzXTg
 p1tgygdrDf/E6o0TKk6OWOVeYAChLYO+zVXYVMSmhTW3P6uj/teBTb9qVbDt/ALmLOyY
 DFRjBSIVpmBaAFpP+JpibkNwA9S7OUMNz1kzU4Y7V68ViqF5hz9MrxRPVXBxYeKqJYIq
 4GXdvPX1e3gdJgQbCUBtU+gK8Cp7OYurultPFRZnBp2MYk3huupfBlaZ9y1/D+Rja7Uq
 pRcA==
X-Gm-Message-State: AOJu0Yzor+hY2UV83mjT5664n1byNwY/k6gJyToLqomtmp6s3mxbtiUe
 rFE7IDbSn5feWdsJ4Mm/Rp6BXTm4l/xGGRtV+bo0rDGeIlrbhGY3OMxKbXlSEEkhEX85FExgByR
 R3k4i
X-Gm-Gg: Acq92OEUru1ja9WLA6bnmmvIIMPBJ9W7Dq0enI45yf0QzLoLs2+0XG5L4Rd4hyVg+mS
 D1rtfl9buFZ49FxfID9ehDmN/4dbXIcf5qlSn1USsKcSUJseoISls3fh92vHoxKzamT5HTCrpFf
 s458goixcGs8yCaFJF9otoe7BxSex22jn8geXrK3ut+LA6MRsztwypxjkzTuzxxLsjI4ixFfp+1
 79ulKij+SS/qS3c8dLzW8juhZwoigkIiZrBypHLqcL8tf4EDzt46uwlD2QMdujlCn8r4Rczy2JK
 Q3A1aue1k4Taw4HW4wtbGTum+fn4feId76q5OPotc1LYxYFL6j5ffVjdEG1q9VrTaQktzsewH5L
 wHZDWJHCE5XZLdyDjfOJgE+WpMXchGAi07w0VTpyjdTZ+GPcNXcw+pzHFpoalNv76zoe75QT4Z1
 H31aUdtuytdHEtoNSCf2/lv1lqRUilTXuSeO3s5R8=
X-Received: by 2002:a05:6a00:2908:b0:82a:6461:6d15 with SMTP id
 d2e1a72fcca58-83f33f166f9mr10266463b3a.46.1778977821098; 
 Sat, 16 May 2026 17:30:21 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19663cfdsm12272745b3a.9.2026.05.16.17.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:30:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 20/63] target/arm: Implement FSCALE for SME
Date: Sat, 16 May 2026 17:29:19 -0700
Message-ID: <20260517003002.321430-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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


