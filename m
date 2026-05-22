Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF46CCD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQY02-000358-Ei; Fri, 22 May 2026 18:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxv-0007lH-8n
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:37 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxq-0008Jc-PY
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:33 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-36608b2f2dcso5101355a91.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487409; x=1780092209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aPBidG0huP+tkQpCO/vx96Q+KUT3hzX3G7rgmz5YuGU=;
 b=wZ7aFirK2HvUUtH5n+KD/4WyT1ZtQ7tCsL3Ak93TxzpohS8rFOlQjIUW/G6pKIT16D
 enUHGDDq3Qi6IJ58Ul3w7g44KuDBUMdzGF1DqjubWIEX/7jI4q7Orfny5+R5208zp3+K
 XColqwHj31rxArqxOp0w0u8ZpXAa7EjwUXrcFu4zxk2TtRBzRgLnoZ0RtNd1WRplZoXZ
 RNHbRF6qHXxgM/vYwbvOJK0JkBMJXR7G7SwZ9PUd7AjIJh73R4NozrmJc6HQCaPjdfWo
 k2hW1v9Aa2UKO3BhFNRD1pq4f8u8YdleuMvXFkUXpBlmG3h/PQLVIdLsWr0mCdTQu0wR
 anZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487409; x=1780092209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aPBidG0huP+tkQpCO/vx96Q+KUT3hzX3G7rgmz5YuGU=;
 b=AFwQdDliLKLQJhxodWU29D3OxlIjwMQ3e00PHLVCP0oPXKClz0sxQ/wI6Px6j6CRxd
 g8heg1ckj3BzKxvlmDHDgdMl2smS3wBzflGJM+icNAEO5qJ5nHi1nuMVq0DC43Jz3zgC
 vPk/Ee5sqNRV7Jxf65JUaECRI7Hsoh5UhH+X1w9PW6x2knp92ywKks1QPjNg/AIAVvda
 rvnxPavUX+3J6GVpj5yiFIqCS5tj8vkyorPK7kGdnZhKgfznNz0sdgPHxZMgxzdVMgfF
 zmytmtxLyuyzYXqsDvy1rHcDcw5qqRTgZn7j510qJxmOb50Ef5ZswHV7rTPGF7WdLwJ8
 ASdg==
X-Gm-Message-State: AOJu0YxZlFQjmwinwgFoFYs8YbBjFyXrRQApv9KReigodlQvs2RJqPUe
 lTCT7kFUzkWie7Quf6Y5nrL9JP7vV+N3VVQGtaEmW7EP67bbLjU3C61T6NsubVEr7DQkExJy4iM
 RmTGQ
X-Gm-Gg: Acq92OH9rSowQmGOdIkHVWwNnLgER1EIJmhndH7sjjkGeksSLRvJypIdxw28jUvVfyK
 mdaZ64+JWtlGrVkjzom1dtKcTqVg+wUHll2lsQAamVkYINV3fVdkyO46mDvZfC6MtWpeEGePhCG
 jTDfB5ggeV+nUscvgg/nLvxEv84GM0UNIyu4q25+MBw42r1P97tBYXxDKgQfXG9YRMY/I2Funiu
 Hlp8gyH5m4GRgCodwGbqYnYGIO0A8rBelhTgbLc8ccLcz0zmiU6o6ViKZsQ14iCIPlxPRBrADIh
 aJlE96loLunDQG6OoMwNBA/LT8xAaAgERnZMNTPCleacKOXjc8jXVei9ANuHiT5J/2IBU5fIguc
 Spcd11DaYDFabx9DpD9vwYO2eqo69EfhJPfpFs2XfUOFU7KIt23oeqezm9aCSpBHd33TfdMDCHu
 EGU0ozr/jJRfjAGnw+Wmiive6D313m2Rc8E0dRkLSImjkiXpnIag==
X-Received: by 2002:a17:90b:4e84:b0:369:946d:32fa with SMTP id
 98e67ed59e1d1-36a676ee27amr5425077a91.5.1779487408855; 
 Fri, 22 May 2026 15:03:28 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6772f486sm1726789a91.2.2026.05.22.15.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:03:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v7 21/64] target/arm: Implement FSCALE for SME
Date: Fri, 22 May 2026 15:02:23 -0700
Message-ID: <20260522220306.235200-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


