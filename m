Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07368CD98CB
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX28q-0005to-Oi; Tue, 09 Jun 2026 15:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX251-0005jm-Lr
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:25:45 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX24w-0005X4-Tb
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:25:42 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2c0c3315c5dso62689075ad.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781033085; x=1781637885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Xz8fr+g8sTOXusmljC0L+Nm4oefyAqFDlrk9++y4e8=;
 b=W3pJZ8PpMJQoBTGbXh1pS07sakq2kpn9In7Vld8IXCQoAqjxORSiig76G8ASOXGRr8
 sayg2g7b+GQrtZRPtQzLjxqE6nBhDQhCQRvoglZemAYjz0nAbpvVkWW0LR5xRVu7qf3M
 neprE0sQRSa5S0Vh1P0yaeObaSp7phQc9gJyZmGx4MDPWu9uutcoHtwkHLzGUVckHIOk
 e4A3py5GNGgv4hR8VY8UZ7c6LvP0qADPZYht583P70xBr+b4EX65AW6jIEpCeIqf1oSD
 FJsXuNVLKS3k9VZiqgeRNYuzaGr4RcJCUTwFR4fwJwayzT3Vkz22AkA08xu4L7DdtvN0
 cUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781033085; x=1781637885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Xz8fr+g8sTOXusmljC0L+Nm4oefyAqFDlrk9++y4e8=;
 b=kpAuuwyR6vI7lQBPfoFbFDwoPiZxN69exBUVKZO7dihwuzukBTDrY3cq33iyzppco9
 Fvvv7pVDVpPI/5QxugjE3VsFJEcX7Qr/tCTlV6saStKQlffqQ//kZAZMkwexTB4bDSze
 pCoyXXcRRCYb8zP2eQxY10M7u/D5UtR4HJm1/dEGkW+CN7ts9GfuGNLmwdkdkc8zKlZ1
 dDMp+KGkVVPzv+k5CVSsmRjV6I+bQKhUSqjXumMe1AtGWGlXVVNUwg7lrGxToTImfO/x
 UPmImzuM1jMwMZ3HZciScuiE3swC8OMxhitMp2V8JGEtOSSXxFB1aCIrQ0s0VxC3eXgQ
 6a6Q==
X-Gm-Message-State: AOJu0YxSBqkk0hgRrik/Pwi8faS3or96Os0izhkYWqDSjkTS84iUAYAS
 hyyeCIAH3Jkw/pU+Z8WzG0pfMPx7CdG3CKDCikH9Hw8trX+MojuOiJNZhZmSMY911YklrMHLYPY
 nI7kf43Q=
X-Gm-Gg: Acq92OETLmSE0+TbhSivZAKQFrCOApswnX/Gl9+cg5s5SKIiJp/AsVflyxssUmfMY1x
 fYMvXMLqD9Kg321uY900WRA/pEiQ3ANQeXL6hY2Tj6QzgDyIvWtsIhzNHaOpC746J58zDVOxZ3n
 W5mBMpnj0FixbMCyNY94e0jxk6Nb0J0QghQTg4q1u979VrPflhUFO1gxWGAW81naURKqSCR5RIp
 CAo4cWzEsiAKXGfMWMt6iVXs8uGn5fdw3SZB8oWeWuBedev5vmEjTy0a4TNf0dzK20UkwawzQXe
 mtUno+wA67nGm6q3CNNFESxIhkoFJdCHmyRUUlT3QGl3Bsm3LHJcbGS2vw9+w8VN3Af6xO7At5Y
 cLh8uNW1YVRwv5QI2U8rOQREKVd19gzOZGX2o/cYR/Qiz7flDb4HvBrZRcVlUlZgbPiI5Mz8tQy
 rbul7YmQJxnp5U9Bm6ge8+t5V5YOeip1e0Mt5Tfpg=
X-Received: by 2002:a17:902:f60d:b0:2c1:e426:70f4 with SMTP id
 d9443c01a7336-2c1e8481634mr220977135ad.23.1781033085180; 
 Tue, 09 Jun 2026 12:24:45 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164fa00b3sm212247045ad.32.2026.06.09.12.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:24:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v10 43/45] target/arm: Implement FMMLA (FP8 to FP16) for
 AdvSIMD
Date: Tue,  9 Jun 2026 12:21:07 -0700
Message-ID: <20260609192110.752384-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
 target/arm/cpu-features.h        |  5 +++++
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/fp8_helper.c      | 25 +++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   |  1 +
 target/arm/tcg/a64.decode        |  1 +
 5 files changed, 33 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 2b1d1034c0..6d65706186 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1635,6 +1635,11 @@ static inline bool isar_feature_aa64_f8mm8(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8MM8);
 }
 
+static inline bool isar_feature_aa64_f8mm4(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8MM4);
+}
+
 /*
  * Combinations of feature tests, for ease of use with TRANS_FEAT.
  */
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 3c74f02022..e942308af4 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -37,3 +37,4 @@ DEF_HELPER_FLAGS_5(gvec_fdot_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_fdot_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fmmla_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_fmmla_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index b9d4ba3b6a..bd0877071b 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -832,3 +832,28 @@ void HELPER(gvec_fmmla_sb)(void *vd, void *vn, void *vm,
 
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
+
+void HELPER(gvec_fmmla_hb)(void *vd, void *vn, void *vm,
+                           CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, 0xf);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nseg = oprsz / 8;
+    uint32_t *n = vn;
+    uint32_t *m = vm;
+    float16 *d = vd;
+
+    for (size_t seg = 0; seg < nseg; seg++, d += 4, n += 2, m += 2) {
+        float16 d0 = f8dotadd_h(n[H4(0)], m[H4(0)], 4, d[H2(0)], &ctx);
+        float16 d1 = f8dotadd_h(n[H4(0)], m[H4(1)], 4, d[H2(1)], &ctx);
+        float16 d2 = f8dotadd_h(n[H4(1)], m[H4(0)], 4, d[H2(2)], &ctx);
+        float16 d3 = f8dotadd_h(n[H4(1)], m[H4(1)], 4, d[H2(3)], &ctx);
+
+        d[H2(0)] = d0;
+        d[H2(1)] = d1;
+        d[H2(2)] = d2;
+        d[H2(3)] = d3;
+    }
+
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 367f87f05d..126b7b44b8 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7502,6 +7502,7 @@ static bool do_f8dot(DisasContext *s, arg_qrrr_e *a,
 TRANS_FEAT(FDOT_sb_v, aa64_f8dp4, do_f8dot, a, gen_helper_gvec_fdot_sb)
 TRANS_FEAT(FDOT_hb_v, aa64_f8dp2, do_f8dot, a, gen_helper_gvec_fdot_hb)
 TRANS_FEAT(FMMLA_sb, aa64_f8mm8, do_f8dot, a, gen_helper_gvec_fmmla_sb)
+TRANS_FEAT(FMMLA_hb, aa64_f8mm4, do_f8dot, a, gen_helper_gvec_fmmla_hb)
 
 static bool do_f8dot_idx(DisasContext *s, arg_qrrx_e *a,
                          gen_helper_gvec_3_ptr *fn)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 6922e91010..28cd1faf61 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1228,6 +1228,7 @@ FDOT_sb_v       0.00 1110 000 ..... 11111 1 ..... ..... @qrrr_s
 FDOT_hb_v       0.00 1110 010 ..... 11111 1 ..... ..... @qrrr_h
 
 FMMLA_sb        0110 1110 100 ..... 11101 1 ..... ..... @rrr_q1e0
+FMMLA_hb        0110 1110 000 ..... 11101 1 ..... ..... @rrr_q1e0
 
 ### Advanced SIMD scalar x indexed element
 
-- 
2.43.0


