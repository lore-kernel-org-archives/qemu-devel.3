Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BACECD6E4C
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 23:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTSrb-0000UZ-Oz; Sat, 30 May 2026 19:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrY-0000Ov-68
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:13:04 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrW-0007cZ-65
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:13:03 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-841513664bbso4972231b3a.1
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 16:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780182781; x=1780787581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EjZound3dcsP9QXbzFXKBLvB4E5pBYThLEA5yZHeMLg=;
 b=AlBBFiJilzWJz05Xuryrmy8sN5tf212LXWFTFd+P4bn+G5lC0FJSq0NkFAs0KZ5D77
 mpf1cJ1fOoQIda14MzReuWvc8CEK/IHcjJEKzLECPv0c7TYDpFvR1EcG/5sid7KeokZA
 PXnyyBprOxwlE+212VnhEnpPZaBM749vk86SUvpL1lQRD0iGbXLpPzdt6xoR9SzqontE
 duWBEie4YRS6JjUJE+MJ42ME0oiLXRJ21vUJOmgzQeACOwkNWUL3o+yMKiCObPOqo15d
 dyQ5N7SYjNyJ/JV/3P+/7elwvDmEMKC9rEksJ6Dm06iQLBt+o0cL6wBRgzjyRw+aozRY
 sjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780182781; x=1780787581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EjZound3dcsP9QXbzFXKBLvB4E5pBYThLEA5yZHeMLg=;
 b=naYWOD0b5KkNOITj0ZVB1MEtLEr1hMIhH2tMZsY/u8+CWe8r0icsALXOYGDapdVUJC
 YY+O/JSOCYgkWXwCe5XRyoGeFCJuLzN5yDbpLKNxDHiWjHFhP2omq8zvb5vs6J7JGl6R
 OCl2QQtm0Raqr3r3trvV2S8Yh0A43aoFvJHs2+CHStxXujJpEtSlpfuxHd2wTwkK+1ua
 Y71HyDqnDLo/xgaAowuen6DHWWs4sMQqPvVb3nYj08DjV/RLeNTtNkwR9yLmvm/kS4pT
 uVROgieeNGMWG7KuNUr8BJ6YAq/s8K7YbTqfCFi/Mp9DzCPmCau4x5KynvyS/eMXpn3J
 rBZw==
X-Gm-Message-State: AOJu0Yxp3HIv6TLd6gHVQTOb4tVR5NeKABfYUX5d4jdzuETI1TFOAD/I
 lb8I+fbORGeFu9ghGPblPxWLrbkwIUxJM2TPPeqTeEopJ9xxwzubETtqoj/7gltXk9CqesSKeV1
 hziX9j1E=
X-Gm-Gg: Acq92OHI4MerhRtMCArDQ5/phDy9Pxww0yebWePgKqiJwojK2+s7sdRPTn2HiQ5KRfc
 hmKd++Iwfh260u4HU5dZJp145MXCEUUNRxJjIn7vKUvord+5XVXTYmJArAcqx+EeWZqq/z/PgZl
 o02EkzZ4UPItbKvkFN1koRQwNfaX5Lx2TLh6AsLxQpbHjtwUh8nucvmGFOVpTLMHWE8FkesTr9i
 wmbPHTrC9uOobC7tk+5Wv5LAryfuQBSqevZOCia6Oetc7U9TEcNmOUT+WXsFGwBFNZY5pNX3je0
 22HDJgjF8adUp7QfiJE675nwCkRiKsQrN7FXvEBuAyjJFexyNXugSWKgVxhpmeBQgRLIuDEVVXp
 8Ra5osLBOnsLdvdtJZefgEOPH7+UT1G/hcqVcOksWDkapmKKEotjHxQuaVZBfO1OWKz1XxJYepY
 BwSNKBY+XNXFJAunEaukODvtPItbJL8a7eZKDfh/8=
X-Received: by 2002:a05:6a20:ae2f:b0:3b3:23b4:6950 with SMTP id
 adf61e73a8af0-3b426abecc2mr4817044637.18.1780182780476; 
 Sat, 30 May 2026 16:13:00 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c857729d3d1sm5634356a12.21.2026.05.30.16.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 16:13:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 33/41] target/arm: Implement FDOT (FP8 to FP16) for AdvSIMD
Date: Sat, 30 May 2026 16:12:21 -0700
Message-ID: <20260530231229.400441-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530231229.400441-1-richard.henderson@linaro.org>
References: <20260530231229.400441-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
index d1d5b22cbf..a25e0a1d92 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -767,3 +767,42 @@ void HELPER(gvec_fdot_idx_sb)(void *vd, void *vn, void *vm,
 
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


