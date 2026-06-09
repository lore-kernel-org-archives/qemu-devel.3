Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C43CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX28F-00049Y-Iw; Tue, 09 Jun 2026 15:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21j-0003Ul-3E
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:26 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21d-0004Bh-Dv
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:16 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-36dac5d5da0so3137560a91.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781032900; x=1781637700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JFTJG/3Df/4OLk9PUm46YHgtzkra8SUHVf1ZncubBv4=;
 b=kLaqakOi+XV5HwrEnaCJjpEFrYBPI/1alG1NKyOKZXLnxKQjSgxkgCCGMkrA4ggR18
 Jqmlq+bZ9V2dcZon4Djg6x1bhrSufCV7YgU0Fv+lJZiJkXG2slTz5wJRE3rku9CwL7PS
 loVeMLg/Y6uQorX8g4RS70dIc7DQqfNshR+3PtolMziq0DAuxLd0J16JVL2X91wGiS0f
 CdPguKTYric+orlTpa5gPOOcf7zbGe+njxCtohNo1jych2DaZcerbyLLZbrdLxFR9msd
 aH/h5DU6D+MVPQGrzxa2oSX7Zt/l/iRLksctgttnnc1Regj2ZKrP4HQvc3otTUdK03Du
 aXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032900; x=1781637700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JFTJG/3Df/4OLk9PUm46YHgtzkra8SUHVf1ZncubBv4=;
 b=mzWQXd6aoGpvk+0b8GnZ0wQsZ2ZzKZ6HkDkUN4rm1tWQ6VkoCX+9XiT4v17sNYP7gX
 0l5FILZ1udMmV6HwFaTNlvkJftOEYpWuKzcv78BUNhb1bsWwEPMFvhAS21d4rRkGZTY+
 x6MnNPYfN21Ak2aycAWyO7lONpKvddHfkCW1+lj/L0ijGhxrvo9MDBgZ+TpojJ1RTY0v
 A7TRd8QcTN54A/FFvOfOVuNuOjP9F4R5p4BD7C/lhRx8BuC4c54k4owTT58eKZHc00dN
 s+jAAcZv67gSZRoQGc7N+F6EDsV+BDhcK4/seJjK1ZLRYBlnsLWyaRr+1mzu4tFFPUv7
 LyZA==
X-Gm-Message-State: AOJu0YxQC28gXC8Di7SfskmUdqxL5mbRssmFQTgytWDh8cY5Wd062GcR
 dopSsiziqNeAGYt1Um6rF/w0547Mx6L4qvISwcUxqnsvR+C5nJsomyR9ZWinMhZT0pSz/d/ggB0
 9joj+/B4=
X-Gm-Gg: Acq92OGBH/ndhrVeCO7CUrFOXdahpfC0hAr3dE35vEgLaf14Rf9jaXGx+r4saVDhaUT
 y0LpZrfppRAnFfD7aCQyoCR9YRR5L9FG3wqNXrpN7opB5AkHfGEOmq0+KQvDKibqidGJN6rDisv
 rR34PbhAqiRHNjqARKU2iRc9cI1XkrtqASkDRD/OuHQdKNjf41k1FcarZ12wU3WygroEzQFMOVy
 /F61MGJ4XnS74oJbQSuJ3hHDMfSDmgUNaAbIuLaiOOz5KHBp1TAHyURe8H14zsCFZ1aO9/GIJj6
 4dNQX44zWgzJU8qr6E9y6rfnWsAjhVjtLp9OBY0WwiZ3l7eSYr0V0hJ25MMWOUgcq6jB3/Aqg99
 /QXu8TVeT+bhbUr3vL3eBlCjdvK2XSR2FVjbXM9QZbJrH/FIV5gZeyk43DV9Wy5aQ8RMPGwLwC3
 +o6s1JIg2bmJIB+lxLeE6vcHoilPj/h8zKzOctiKk=
X-Received: by 2002:a17:90b:2810:b0:366:2e1f:393 with SMTP id
 98e67ed59e1d1-370f038831dmr22943857a91.21.1781032899916; 
 Tue, 09 Jun 2026 12:21:39 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f88473sm240806095ad.25.2026.06.09.12.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:21:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v10 37/45] target/arm: Implement FDOT (FP8 to FP16) for AdvSIMD
Date: Tue,  9 Jun 2026 12:21:01 -0700
Message-ID: <20260609192110.752384-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
 target/arm/cpu-features.h        |  5 ++++
 target/arm/tcg/helper-fp8-defs.h |  3 +++
 target/arm/tcg/fp8_helper.c      | 39 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   |  2 ++
 target/arm/tcg/a64.decode        |  2 ++
 5 files changed, 51 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index fbf4decd74..f6184b80de 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1620,6 +1620,11 @@ static inline bool isar_feature_aa64_f8dp4(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8DP4);
 }
 
+static inline bool isar_feature_aa64_f8dp2(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8DP2);
+}
+
 /*
  * Combinations of feature tests, for ease of use with TRANS_FEAT.
  */
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index ee6f2e9236..5995d77577 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -32,3 +32,6 @@ DEF_HELPER_FLAGS_5(gvec_fmla_idx_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env,
 
 DEF_HELPER_FLAGS_5(gvec_fdot_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_fdot_idx_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fdot_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_fdot_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index f54acb03f3..065df24b84 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -768,3 +768,42 @@ void HELPER(gvec_fdot_idx_sb)(void *vd, void *vn, void *vm,
 
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
+
+void HELPER(gvec_fdot_hb)(void *vd, void *vn, void *vm,
+                          CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, 0xf);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 2;
+    uint16_t *n = vn;
+    uint16_t *m = vm;
+    float16 *d = vd;
+
+    for (size_t i = 0; i < nelem; i++) {
+        d[i] = f8dotadd_h(n[i], m[i], 2, d[i], &ctx);
+    }
+
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_fdot_idx_hb)(void *vd, void *vn, void *vm,
+                              CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, 0xf);
+    size_t idx = simd_data(desc);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 2;
+    uint16_t *n = vn;
+    uint16_t *m = vm;
+    float16 *d = vd;
+    size_t i = 0;
+
+    do {
+        uint16_t e1 = m[i + H2(idx)];
+        do {
+            d[i] = f8dotadd_h(n[i], e1, 2, d[i], &ctx);
+        } while (++i % 8 != 0);
+    } while (i < nelem);
+
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 960de1aa86..83d90cfcf4 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7500,6 +7500,7 @@ static bool do_f8dot(DisasContext *s, arg_qrrr_e *a,
 }
 
 TRANS_FEAT(FDOT_sb_v, aa64_f8dp4, do_f8dot, a, gen_helper_gvec_fdot_sb)
+TRANS_FEAT(FDOT_hb_v, aa64_f8dp2, do_f8dot, a, gen_helper_gvec_fdot_hb)
 
 static bool do_f8dot_idx(DisasContext *s, arg_qrrx_e *a,
                          gen_helper_gvec_3_ptr *fn)
@@ -7515,6 +7516,7 @@ static bool do_f8dot_idx(DisasContext *s, arg_qrrx_e *a,
 }
 
 TRANS_FEAT(FDOT_sb_vi, aa64_f8dp4, do_f8dot_idx, a, gen_helper_gvec_fdot_idx_sb)
+TRANS_FEAT(FDOT_hb_vi, aa64_f8dp2, do_f8dot_idx, a, gen_helper_gvec_fdot_idx_hb)
 
 static bool do_int3_vector_idx(DisasContext *s, arg_qrrx_e *a,
                                gen_helper_gvec_3 * const fns[2])
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 08c493c11e..a3e404e7fe 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1225,6 +1225,7 @@ FMLALL_sb_v     0.00 1110 0.0 rm:5 110001 rn:5 rd:5 \
                 &rxx idxm=0 idxn=%fmlall_idxn
 
 FDOT_sb_v       0.00 1110 000 ..... 11111 1 ..... ..... @qrrr_s
+FDOT_hb_v       0.00 1110 010 ..... 11111 1 ..... ..... @qrrr_h
 
 ### Advanced SIMD scalar x indexed element
 
@@ -1351,6 +1352,7 @@ FMLALL_sb_vi    0 . 10 1111 0 . ... rm:3 1000 . 0 rn:5 rd:5 \
                 &rxx idxm=%hlm4 idxn=%fmlall_idxn
 
 FDOT_sb_vi      0.00 1111 00 . ..... 0000 . 0 ..... .....   @qrrx_s
+FDOT_hb_vi      0.00 1111 01 .. .... 0000 . 0 ..... .....   @qrrx_h
 
 # Floating-point conditional select
 
-- 
2.43.0


