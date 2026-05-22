Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CABCD5BB8
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQY2N-0000SY-EY; Fri, 22 May 2026 18:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY1W-0006sR-4E
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:07:21 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY1K-0002sY-KB
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:07:13 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2be75f658f3so31887705ad.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487623; x=1780092423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yxD8qyzTpD2dsEiaYlHBw8DIPMk7qtwsdNgrErHTZzQ=;
 b=E2oLB2wra3TXzrPZNfQtr+1X1FudcjLDA26nRM9LMTDwC7GN6noRgZ6SSsNaoKZ9Xz
 Dbc+GC2DMXP7bdxqPKc0FP3DIqAliJOymrLAMUBKv5QcWHH6zoiuoxqNiSzrCuvcEXxz
 Ro8Fm4zIqG+KhlA3xwUnU8hA/upq5agUAa+xv2D1iwE+1RAzzpvBQmMF984wr5qnslq3
 1k70UVt4DyFSmzQX1ZR5VlRiwirQGmeXVK13qwJXVAssUs/lf22PmOXHTk4dGBhad5ik
 Sywz0Afb+R/kNhjDm3LXvBOELA+fZY20ItEynq2en5P7NikYcXdnvJY+8Azv+8ITMtGR
 kyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487623; x=1780092423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yxD8qyzTpD2dsEiaYlHBw8DIPMk7qtwsdNgrErHTZzQ=;
 b=PwcA9UF9lamkeT/3s+fjy6kblKuFMWCWqQ84ijl4+650NDhjrfegb0AADRamptkma7
 OJlZjWpePI/ZdJv9bND/HidzFm606Ve8ig4oJsWwr//Zgk5cfi1NWc5+8XrlpbgQnx3q
 fXDW8pzl1V3esuayFi+QAaWvGIBJpMmL2AHjmgl6K9dCu3n1ctQ6mweocz3jCs1NIsqI
 9ELS/vs1CCAlZYsdKtI/R9c+fR/T3QP52+/au3cnih+vkCwmtCiKwAn3ak4BG+nK3fh6
 VqYEXssr15OtGrjcWcxw16pDt0OHouFewhCZHkRPG2KOCCpfCNV0xNw8YxGeUTdHlsQs
 zYew==
X-Gm-Message-State: AOJu0Yyb2Ebp/GBCk9ZROLtDp5B5Nc5D9QjB8buNUCsrZTKP5iUwuWWP
 m2hBAonngHhU/oaWxnhptdNTEYxMeXNn4MRmeeEzVrQFFDm6aWkKKb26Ut25iTQn0YSQdo+p3qj
 Bg1JZ
X-Gm-Gg: Acq92OGjI+omqfg11hh/KONzETgivlejM+vENA1yTeQHGwjPVOjKDtLnyXJewuBnU+k
 /4Hd4o0z4VbLHfVsrQh/babOVlX9iADENhk+zCOQQBLjHEN+V11A8ns9nCcNwoPFvO0k2SJhDFV
 LJ6lPfwTWmvM2h89hIsfw3KwwXWWEUn9OpGR7W23f2iKO54dSSi2WNtbHsSyzRdiwN5ATch32nd
 eLM4dLAdKqFzdw1ckXtLKbJLg4P4+iTcZNvthTnmv/zHkB7zNDelWgFE3N/XRVxyFcAFK0n3dvk
 G1VGBzBnC07in2lsPP5Dxtd6+JhNrTRcPiuv3GX9DFrlIJq1ttn2uHAM/rJVQFwXOfOzbV77Aiu
 g4Bt7vx2UYu3Zd4ndhEWc6xb1+J+Z+DZ0vNJqxPkEHDP4mNYWlW9Yr/4PLo3ianmfzRYz9SJwer
 t2+qPmbAXWvV3tBWTSiK5O2jTZ7D4m
X-Received: by 2002:a17:903:3c24:b0:2bd:e43c:12d0 with SMTP id
 d9443c01a7336-2beb0770e69mr59298415ad.28.1779487622811; 
 Fri, 22 May 2026 15:07:02 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56b7920sm27835745ad.21.2026.05.22.15.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:07:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v7 59/64] target/arm: Implement FMMLA (FP8 to FP32) for AdvSIMD
Date: Fri, 22 May 2026 15:03:01 -0700
Message-ID: <20260522220306.235200-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
 target/arm/cpu-features.h        |  5 +++++
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/fp8_helper.c      | 25 +++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   |  1 +
 target/arm/tcg/a64.decode        |  2 ++
 5 files changed, 35 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 90098c3cbe..67b9d7e982 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1620,6 +1620,11 @@ static inline bool isar_feature_aa64_f8dp2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8DP2);
 }
 
+static inline bool isar_feature_aa64_f8mm8(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8MM8);
+}
+
 /*
  * Combinations of feature tests, for ease of use with TRANS_FEAT.
  */
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 5995d77577..3c74f02022 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -35,3 +35,5 @@ DEF_HELPER_FLAGS_5(gvec_fdot_idx_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env,
 
 DEF_HELPER_FLAGS_5(gvec_fdot_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_fdot_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fmmla_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index a25e0a1d92..9db4ff4c2f 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -806,3 +806,28 @@ void HELPER(gvec_fdot_idx_hb)(void *vd, void *vn, void *vm,
 
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
+
+void HELPER(gvec_fmmla_sb)(void *vd, void *vn, void *vm,
+                           CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, -1);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nseg = oprsz / 16;
+    uint64_t *n = vn;
+    uint64_t *m = vm;
+    float32 *d = vd;
+
+    for (size_t seg = 0; seg < nseg; seg++, d += 4, n += 2, m += 2) {
+        float32 d0 = f8dotadd_s(n[0], m[0], 8, d[H4(0)], &ctx);
+        float32 d1 = f8dotadd_s(n[0], m[1], 8, d[H4(1)], &ctx);
+        float32 d2 = f8dotadd_s(n[1], m[0], 8, d[H4(2)], &ctx);
+        float32 d3 = f8dotadd_s(n[1], m[1], 8, d[H4(3)], &ctx);
+
+        d[H4(0)] = d0;
+        d[H4(1)] = d1;
+        d[H4(2)] = d2;
+        d[H4(3)] = d3;
+    }
+
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3f3a39da4e..c62fd6f4c3 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7415,6 +7415,7 @@ static bool do_f8dot(DisasContext *s, arg_qrrr_e *a,
 
 TRANS_FEAT(FDOT_sb_v, aa64_f8dp4, do_f8dot, a, gen_helper_gvec_fdot_sb)
 TRANS_FEAT(FDOT_hb_v, aa64_f8dp2, do_f8dot, a, gen_helper_gvec_fdot_hb)
+TRANS_FEAT(FMMLA_sb, aa64_f8mm8, do_f8dot, a, gen_helper_gvec_fmmla_sb)
 
 static bool do_f8dot_idx(DisasContext *s, arg_qrrx_e *a,
                          gen_helper_gvec_3_ptr *fn)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index d1254355b6..6404c26540 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1216,6 +1216,8 @@ FMLALL_sb_v     0.00 1110 0.0 rm:5 110001 rn:5 rd:5 \
 FDOT_sb_v       0.00 1110 000 ..... 11111 1 ..... ..... @qrrr_s
 FDOT_hb_v       0.00 1110 010 ..... 11111 1 ..... ..... @qrrr_h
 
+FMMLA_sb        0110 1110 100 ..... 11101 1 ..... ..... @rrr_q1e0
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
-- 
2.43.0


