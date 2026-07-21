Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8E4C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmFWm-0001zz-5z; Tue, 21 Jul 2026 14:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUo-00011s-19
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:15 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUk-0006ck-2q
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:13 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso9620743a91.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 11:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784659629; x=1785264429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4c42GVS/UTX2L7NnqJ/GB056XfIjiufEO7avanLBis0=;
 b=uHcwTke7FB35Ho5iJOvMOFzzcWLc0Evndp0OTeKoevWtTDdL9qHjPZvosCX5s+serp
 DyI++AASUdiMUD2zVsJz0OZkUJzwWrbhexGe0wihuc5fsz8gvxCCbCIIctmf+gAZqTUa
 6RpVTRgxY0Q4BBo1RD1UF4X5XYOwlO/CNX5QvL/j2ubrWduV4MuNJXhrNaUrlE7eUQCG
 D82OYjA8NdoaTi0FSc/DDOGNV/5g+XneKB5y4l0+uIzpYR6MWvvfTBh+wk6apHboSwqa
 GFeVnK1/KCxXpYbQlDji3MRdQDGz5eIgnpiVQhFnSp5f/YfYVPScCSxRdEAxD9k5JzbZ
 iKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784659629; x=1785264429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4c42GVS/UTX2L7NnqJ/GB056XfIjiufEO7avanLBis0=;
 b=KKEMHvOhGRK1QY5jLLeqBrllYVDpscrw5qbwsU8A8cVkmkoHgB9c5nyOE2UJEQ9m8d
 42WuZNty8XSU6nTj2/gWMgOnC+nlvgOdTedspAxwAZVy20nMH/IPhhRaICk65x5byf6y
 vt6walA4+WEF3aWlNxsU0vQXR6Z38+M/Nm4PNgnDdgcZzbhPfkETJ5Oi02X3cUfVS6xA
 B8bFJ6KEaaDRkrDpFYx2I5GDxk8OVoEMk4jHdP0P9X2OW6qEsW7KOuhzQzD1YUpPUVUy
 PMw/04hJUL7thjrsgDKdRdvbv9WFUSl5+x9YmsJAA6q+/sm0wYSaXf5FZqV6LJhWD8lP
 GdKA==
X-Gm-Message-State: AOJu0Yzo7XM77hKrkqdziLEz4NR6M8qwFl4z/C2CKTla9ELdhFMIRZ86
 kVc09Q4qwQ11VD+A5wGNgWD8X/vV3H0ivlWaSSVKaQGevD2lzqvk/1aJC/CTTX2ozHHCbMbG8/O
 SBIAa
X-Gm-Gg: AR+sD10b1DLYdiKwkXFDA5Uh0LnX30QCdTNjRJ4Wy12MDegLf3hHhi/LmduEfpe7tCT
 OwWaXLbXnT24cwb+PdS45RTmdN9wQcq+mOlepmWAT3+ZdQZyexvJ183G0yzQG5GeWY7zl/0kxFQ
 cwdHbUd709xeydyQlVUr1pDeU6WCOH6f6/O/a8clzU7gVgco0KLUAp/1YrVkZcIgJT9uRUrE6M0
 ZFN+Mf9E+OfBkgE4MElw8sRSeIPJU3LZO/KQImXnf/ur86y6tGJlAzX0fNKFU98+H0uXtGXRVul
 S3Pen7xXuNp8C+ubfTnWSSdDqCRQNQxFEU69x752sa5fvyu4CXT2e6ulSrCihS15OOQdNYEj4+A
 hTIKkov/1QGQ+gNvbSI8xID2gCbNuFBkCAXCg8Ig6JZQ/UDCwIqiJrPZ/Yky9R0EEFqz4vDP1V0
 //lA/cOqs=
X-Received: by 2002:a17:90b:57ee:b0:38d:f096:a1dc with SMTP id
 98e67ed59e1d1-38e4b454a20mr20450143a91.11.1784659628791; 
 Tue, 21 Jul 2026 11:47:08 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce29e340esm41108094c88.5.2026.07.21.11.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 11:47:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 07/20] target/arm: Implement SME BFSCALE
Date: Tue, 21 Jul 2026 11:46:43 -0700
Message-ID: <20260721184656.530230-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721184656.530230-1-richard.henderson@linaro.org>
References: <20260721184656.530230-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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
 target/arm/cpu-features.h        |  5 +++++
 target/arm/tcg/helper-a64-defs.h |  1 +
 target/arm/tcg/translate-sme.c   |  4 ++++
 target/arm/tcg/vec_helper64.c    |  1 +
 target/arm/tcg/sme.decode        | 20 ++++++++++++++++----
 5 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 76859c1f74..b29cd49020 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1872,6 +1872,11 @@ static inline bool isar_feature_aa64_sme_tmop_f8f32(const ARMISARegisters *id)
     return isar_feature_aa64_sme_tmop(id) && isar_feature_aa64_sme_f8f32(id);
 }
 
+static inline bool isar_feature_aa64_sme2_sve_bfscale(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2(id) && isar_feature_aa64_sve_bfscale(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/helper-a64-defs.h b/target/arm/tcg/helper-a64-defs.h
index 0e56e00f45..582d160850 100644
--- a/target/arm/tcg/helper-a64-defs.h
+++ b/target/arm/tcg/helper-a64-defs.h
@@ -152,6 +152,7 @@ DEF_HELPER_FLAGS_5(gvec_famin_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32
 DEF_HELPER_FLAGS_5(gvec_famax_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_famin_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(gvec_fscale_b16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fscale_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fscale_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fscale_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 463754b057..d28574a8cf 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -890,6 +890,10 @@ static gen_helper_gvec_3_ptr * const f_vector_fscale[4] = {
 };
 TRANS_FEAT(FSCALE_n1, aa64_sme2_f8cvt, do_zzz_n1_fpst, a, f_vector_fscale[a->esz])
 TRANS_FEAT(FSCALE_nn, aa64_sme2_f8cvt, do_zzz_nn_fpst, a, f_vector_fscale[a->esz])
+TRANS_FEAT(BFSCALE_n1, aa64_sme2_sve_bfscale, do_zzz_n1_fpst, a,
+           gen_helper_gvec_fscale_b16)
+TRANS_FEAT(BFSCALE_nn, aa64_sme2_sve_bfscale, do_zzz_nn_fpst, a,
+           gen_helper_gvec_fscale_b16)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmul[4] = {
     NULL,
diff --git a/target/arm/tcg/vec_helper64.c b/target/arm/tcg/vec_helper64.c
index d8b25b868e..8879969350 100644
--- a/target/arm/tcg/vec_helper64.c
+++ b/target/arm/tcg/vec_helper64.c
@@ -179,6 +179,7 @@ DO_3OP(gvec_famin_s, float32_famin, float32)
 DO_3OP(gvec_famax_d, float64_famax, float64)
 DO_3OP(gvec_famin_d, float64_famin, float64)
 
+DO_3OP(gvec_fscale_b16, bfloat16_scalbn, int16_t)
 DO_3OP(gvec_fscale_h, float16_scalbn, int16_t)
 DO_3OP(gvec_fscale_s, float32_scalbn, int32_t)
 DO_3OP(gvec_fscale_d, scalbn_d, int64_t)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 60c7cacc10..4e19c42b19 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -287,8 +287,14 @@ ADD_n1         1100000 1 .. 10 .... 1010.0 11000 .... 0    @z2z_4x1
 SQDMULH_n1     1100000 1 .. 10 .... 1010.1 00000 .... 0    @z2z_2x1
 SQDMULH_n1     1100000 1 .. 10 .... 1010.1 00000 .... 0    @z2z_4x1
 
-FSCALE_n1      1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_2x1
-FSCALE_n1      1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_4x1
+{
+  BFSCALE_n1   1100000 1 00 10 .... 1010.0 01100 .... 0    @z2z_2x1_e0
+  FSCALE_n1    1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_2x1
+}
+{
+  BFSCALE_n1   1100000 1 00 10 .... 1010.0 01100 .... 0    @z2z_4x1_e0
+  FSCALE_n1    1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_4x1
+}
 
 FMUL_n1        1100000 1 esz:2 1 zm:4 0 111010 ....0 ....0 \
                &zzz_en n=2 zd=%zd_ax2 zn=%zn_ax2
@@ -365,8 +371,14 @@ FAMAX_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 0    @z2z_4x4
 FAMIN_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 1    @z2z_2x2
 FAMIN_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 1    @z2z_4x4
 
-FSCALE_nn      1100000 1 .. 1 ..... 1011.0 01100 .... 0    @z2z_2x2
-FSCALE_nn      1100000 1 .. 1 ..... 1011.0 01100 .... 0    @z2z_4x4
+{
+  BFSCALE_nn   1100000 1 00 1 ..... 1011.0 01100 .... 0    @z2z_2x2_e0
+  FSCALE_nn    1100000 1 .. 1 ..... 1011.0 01100 .... 0    @z2z_2x2
+}
+{
+  BFSCALE_nn   1100000 1 00 1 ..... 1011.0 01100 .... 0    @z2z_4x4_e0
+  FSCALE_nn    1100000 1 .. 1 ..... 1011.0 01100 .... 0    @z2z_4x4
+}
 
 FMUL_nn        1100000 1 esz:2 1 ....0 111001 ....0 ....0  \
                &zzz_en n=2 zd=%zd_ax2 zn=%zn_ax2 zm=%zm_ax2
-- 
2.43.0


