Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BD7CD6E56
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcIY-0007HW-7c; Tue, 02 Jun 2026 23:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcIG-0006rr-Cs
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:25 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcIE-0003kz-0L
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:23 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-84275887a3fso84112b3a.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 20:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780457361; x=1781062161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dd9QfAaWI8PgPbxUzO/B+KRB9MuMDE7ChDPIJdPgstQ=;
 b=izqIIWM1xBv0ewXs9nyLdUO3IWnu21ZamJHfgBrXmVtNX/8KzWtRFkz6hIC8rWaXqJ
 Y3y7EuyMMDfEAqyKRu06UuuZDtQJ+bsXNFWqSU8T2pU1Qxt0gdL5jX5gJywHXTnhNtmb
 S6JHRVwOO9FLmbbCD31JqfIZcZtW8Unhk4IiXnFklt6c2w1nh44jGr6VZPt8ndZ5g9vL
 AArgDhZEVxf3WsQVFQw7eltVopzTWBYvvp5lYlQepVYfjU5kVCM7AQ4YiqqIEIwbqjrK
 mFdFQCZA/9DxCYq8iqdaFeRpG9h/6CGOkbBHFzfRBOSOOE4g8OMSUMKsoOh/vS0zJKM5
 f1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780457361; x=1781062161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dd9QfAaWI8PgPbxUzO/B+KRB9MuMDE7ChDPIJdPgstQ=;
 b=Zx1VGA46jG4CXmmA1DAQNXx30E20gL/zZQTlTwl6nlP8HTfyhRHyojqfVAjOYrrjmR
 LHy7eY603gx/TnBz5khp86ep+xctBSzbIhn92A45T0RX3wkObejZKswiL2EgsMDBgsvT
 Gmno8oFsndS9uDD9awsdXhuzt77vDdDtYKu/ShMNasvIMAUBoOSCrj7kc4iSIpyd8fpL
 Tfwqsz2hPaXtRlX2duVSOTj2l8+4mSPKkWjM+gHjNx2o0dBdW8vl3mdUdQvwRUxcq4ZI
 mM4QXp9t21mbhA0BKs2Hqb2C0DRnH8DyESeRqh173DPoTzD6z+zp2B/903Hoy/nSGkQg
 VdbQ==
X-Gm-Message-State: AOJu0Yym0Y+0Rt7pc0yYtqtKBLF0OK4jU2yq/R58bAUvCgz2AkJO4Wv1
 OOkyUG+D7sluwr7rRK3p54QBeOKhbTF14o+n2Wi+vYoOBPHnb5IG7ZWfgSfTGLFwHqkeeoO7zRt
 SFcuiBdc=
X-Gm-Gg: Acq92OFu5cvIWHmvpMralDbqCgGcf7nNyRqlx7qWb1FTKXn6qHfnqhtQAe34JezFHvp
 WAQDtw7j/kIO2uqJ2AmlH3xbgb3MQJprlK6lomxRnjqGURxtbFfUjPgcfyT6Ojl5vTZzaLG5xu2
 Mbt3eW5ovK8I3yqQ8j3xPboCSaoM7rekO/+BKDgE/yD9KUvEzWg9Lccp55Oe61VM9cvPo6peeMc
 2kLTs8iWOWMr3XDrMBl7B8sP9ojYSARiQNMGK4++oWRndb8CE5ReUJOmHTbV+cY9vQpcSM+7koS
 JAAJdAecLn4XxygseYyKy7gUeUEQHSJ0g9ncRed6EiPlpeMt/moIn4RaJ7qC2FKUFpn9dRgMD2Z
 fopk2ATU2Kavsaf6x+8QdNYYOldQ2QquDNiBphgvbAtY9HNuhWpfffGodHoFlakZKui6Gi6G4nw
 PRDxt3M9aAyYQInEyMzKqKKB7WZeJPxiQP1EEK3o3K9KTtz3bB6w==
X-Received: by 2002:a05:6a00:2d94:b0:837:8342:abe5 with SMTP id
 d2e1a72fcca58-84285cbad82mr997900b3a.18.1780457360001; 
 Tue, 02 Jun 2026 20:29:20 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428222263dsm1477831b3a.2.2026.06.02.20.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 20:29:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 34/45] target/arm: Implement FDOT (FP8 to FP32) for AdvSIMD
Date: Tue,  2 Jun 2026 20:28:43 -0700
Message-ID: <20260603032855.106930-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603032855.106930-1-richard.henderson@linaro.org>
References: <20260603032855.106930-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
 target/arm/cpu-features.h        |  5 ++++
 target/arm/tcg/helper-fp8-defs.h |  3 +++
 target/arm/tcg/fp8_helper.c      | 39 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   | 30 ++++++++++++++++++++++++
 target/arm/tcg/a64.decode        |  4 ++++
 5 files changed, 81 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 5e9eb3405b..4342a2461e 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1610,6 +1610,11 @@ static inline bool isar_feature_aa64_f8fma(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8FMA);
 }
 
+static inline bool isar_feature_aa64_f8dp4(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8DP4);
+}
+
 /*
  * Combinations of feature tests, for ease of use with TRANS_FEAT.
  */
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 802a3b430e..ee6f2e9236 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -29,3 +29,6 @@ DEF_HELPER_FLAGS_5(gvec_fmla_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env,
 
 DEF_HELPER_FLAGS_5(gvec_fmla_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_fmla_idx_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fdot_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_fdot_idx_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 2e3eb43799..d1d5b22cbf 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -728,3 +728,42 @@ void HELPER(gvec_fmla_idx_sb)(void *vd, void *vn, void *vm,
 
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
+
+void HELPER(gvec_fdot_sb)(void *vd, void *vn, void *vm,
+                          CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, -1);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 4;
+    uint32_t *n = vn;
+    uint32_t *m = vm;
+    float32 *d = vd;
+
+    for (size_t i = 0; i < nelem; i++) {
+        d[i] = f8dotadd_s(n[i], m[i], 4, d[i], &ctx);
+    }
+
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_fdot_idx_sb)(void *vd, void *vn, void *vm,
+                              CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, -1);
+    size_t idx = simd_data(desc);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 4;
+    uint32_t *n = vn;
+    uint32_t *m = vm;
+    float32 *d = vd;
+    size_t i = 0;
+
+    do {
+        uint32_t e1 = m[i + H4(idx)];
+        do {
+            d[i] = f8dotadd_s(n[i], e1, 4, d[i], &ctx);
+        } while (++i % 4 != 0);
+    } while (i < nelem);
+
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index b58a55895b..960de1aa86 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7486,6 +7486,36 @@ TRANS_FEAT(FMLAL_hb_vi, aa64_f8fma, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_hb)
 TRANS_FEAT(FMLALL_sb_v, aa64_f8fma, do_fmla_fp8, a, gen_helper_gvec_fmla_sb)
 TRANS_FEAT(FMLALL_sb_vi, aa64_f8fma, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_sb)
 
+static bool do_f8dot(DisasContext *s, arg_qrrr_e *a,
+                     gen_helper_gvec_3_ptr *fn)
+{
+    if (fpmr_access_check(s) && fp_access_check(s)) {
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           tcg_env, a->q ? 16 : 8, vec_full_reg_size(s),
+                           0, fn);
+    }
+    return true;
+}
+
+TRANS_FEAT(FDOT_sb_v, aa64_f8dp4, do_f8dot, a, gen_helper_gvec_fdot_sb)
+
+static bool do_f8dot_idx(DisasContext *s, arg_qrrx_e *a,
+                         gen_helper_gvec_3_ptr *fn)
+{
+    if (fpmr_access_check(s) && fp_access_check(s)) {
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           tcg_env, a->q ? 16 : 8, vec_full_reg_size(s),
+                           a->idx, fn);
+    }
+    return true;
+}
+
+TRANS_FEAT(FDOT_sb_vi, aa64_f8dp4, do_f8dot_idx, a, gen_helper_gvec_fdot_idx_sb)
+
 static bool do_int3_vector_idx(DisasContext *s, arg_qrrx_e *a,
                                gen_helper_gvec_3 * const fns[2])
 {
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index ee7391a13c..08c493c11e 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1224,6 +1224,8 @@ FMLAL_hb_v      0 idxn:1 00 1110 110 rm:5 11111 1 rn:5 rd:5 \
 FMLALL_sb_v     0.00 1110 0.0 rm:5 110001 rn:5 rd:5 \
                 &rxx idxm=0 idxn=%fmlall_idxn
 
+FDOT_sb_v       0.00 1110 000 ..... 11111 1 ..... ..... @qrrr_s
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
@@ -1348,6 +1350,8 @@ FMLAL_hb_vi     0 idxn:1 00 1111 11 ... rm:3 0000 . 0 rn:5 rd:5 \
 FMLALL_sb_vi    0 . 10 1111 0 . ... rm:3 1000 . 0 rn:5 rd:5 \
                 &rxx idxm=%hlm4 idxn=%fmlall_idxn
 
+FDOT_sb_vi      0.00 1111 00 . ..... 0000 . 0 ..... .....   @qrrx_s
+
 # Floating-point conditional select
 
 FCSEL           0001 1110 .. 1 rm:5 cond:4 11 rn:5 rd:5     esz=%esz_hsd
-- 
2.43.0


