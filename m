Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9789FCD5BB9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQY2H-0008Bx-Kp; Fri, 22 May 2026 18:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY1O-0006qi-SF
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:07:17 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY1G-0002q0-PM
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:07:07 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2b4583f0a1aso53730715ad.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487620; x=1780092420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7mCXdAwGQCn7pyKxhre4mAGOBY+eWGwSc3wK5uiJp8Q=;
 b=s5or/yAg0uBo+6X7U6sXrWEq4Bv6JhmT39um29G/c8Vzo9NwFtw4Vb7WU7kGZchWHc
 K+PyAyIcFkLgsP1G75V/dXC3vU3AlBojh4N/rpNBYDgbujsC5sqXR0xA71y9uah5bLix
 fHysVAWiYl1UPYrcMeh6lOa01NtMN4x885mwm1zxc6iKHdeO8Y7v6lJ04YTQCZEX4V6s
 iQ1B/SlCHFjkn4gFCTXUBER+Liq6Qr53NCeU8lXWOHFQ1zIgGn19yHj2J+deQYOkb78+
 OsJ3pDwsTov5uQAzBpzy4KdgDu1Z7+Oun4sItvLMPVZFPD+L9h0Q6aGZl7awjCtLGtOO
 X1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487620; x=1780092420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7mCXdAwGQCn7pyKxhre4mAGOBY+eWGwSc3wK5uiJp8Q=;
 b=Gm/jVjNYD4897hfqYBMtCHI/NFNAaMTXKJP7lIIAd4iAMuEbqlA8S8G+7MnNXQsDc0
 jPuhdBWn9FISq/xjVqq+LS862Cz0IUNWe6uyDPFCsVT9Xdg9tO1Nx1DL7zV3kwgJ5BVH
 gTsWALB0wZkoG9Ljid9UXnrnaOxwRkgpydb2BLklR+Rj3Ot5KoGt4FVKbPLbTYiwLEq2
 B0PnTUU9TbL9pORW65ecD0nyuvXjXQ8/ED189GhnlNhk/fMkTRcjRO5kSA1B/w1k45yt
 R3DIoS4kyl8dkQF40JnEhMSmin/nME55Uw9AM3t20mgGtfaSIVO91plJ5Em7UlEXvzRw
 DRCw==
X-Gm-Message-State: AOJu0Yzjlxj9byGl/DkpoVCVHrME6L3YTWteQtM+hiYtMmTtAB1QpTj/
 nX498nXFO4qVYf/Zp+t3wWmwV5s+uqomBLK9rlo7lUIgTHJRfkB1Ib7bYuxaE6NBysxQRQGB+pp
 obuPu
X-Gm-Gg: Acq92OEPmS1+zqa/yTG1C6WdjMCX6QwZ91xVdW+QpEQq8i5n73WehT1amfOawHRsKxW
 ly412GqKudVFg6KJaugHDafjic1MAKKDBdtzN9Vri0+ck+YwJSxe9mDd8QNDizOBWYa4TkGocMe
 N95qlU/+1EyibuUTAykyFBHoTAzjYJdwoUMn0hsBTYn83wjLxphP8QY4j6L15x4rRFBEFE9ywje
 cUqlvZBy2zQoQyQnT/RRBoJ3c83qfVW264EL3hNJ/ni18RPVYBSwqWtx76dhCVkYpHDd95jM8qf
 RkrLEvN9P2q543gdcxGsITCuOnvSGnQ7cjKnwuyTvhcssuhqce+KY9hM2YvTy09TGX55X9S3KtZ
 7vkTRzlCknOcl/xCRLqs+qYq3y+1lBKR3sbitAm6Wfh967+cP4TOZW2JmdUbX3MPMc083yiifMu
 xJKSdIlnXINLCeKgvIKDGwuW2qNayv
X-Received: by 2002:a17:903:b84:b0:2bc:db35:96c7 with SMTP id
 d9443c01a7336-2beb07ed803mr55232205ad.28.1779487620459; 
 Fri, 22 May 2026 15:07:00 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56b7920sm27835745ad.21.2026.05.22.15.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:07:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v7 56/64] target/arm: Implement FDOT (FP8 to FP16) for AdvSIMD
Date: Fri, 22 May 2026 15:02:58 -0700
Message-ID: <20260522220306.235200-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
 target/arm/tcg/translate-a64.c   |  2 ++
 target/arm/tcg/a64.decode        |  2 ++
 5 files changed, 51 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 17d6acc14d..7bedc293fd 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1610,6 +1610,11 @@ static inline bool isar_feature_aa64_f8dp4(const ARMISARegisters *id)
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
index d2e945a9f5..3f3a39da4e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7414,6 +7414,7 @@ static bool do_f8dot(DisasContext *s, arg_qrrr_e *a,
 }
 
 TRANS_FEAT(FDOT_sb_v, aa64_f8dp4, do_f8dot, a, gen_helper_gvec_fdot_sb)
+TRANS_FEAT(FDOT_hb_v, aa64_f8dp2, do_f8dot, a, gen_helper_gvec_fdot_hb)
 
 static bool do_f8dot_idx(DisasContext *s, arg_qrrx_e *a,
                          gen_helper_gvec_3_ptr *fn)
@@ -7429,6 +7430,7 @@ static bool do_f8dot_idx(DisasContext *s, arg_qrrx_e *a,
 }
 
 TRANS_FEAT(FDOT_sb_vi, aa64_f8dp4, do_f8dot_idx, a, gen_helper_gvec_fdot_idx_sb)
+TRANS_FEAT(FDOT_hb_vi, aa64_f8dp2, do_f8dot_idx, a, gen_helper_gvec_fdot_idx_hb)
 
 static bool do_int3_vector_idx(DisasContext *s, arg_qrrx_e *a,
                                gen_helper_gvec_3 * const fns[2])
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index d78a3d5486..d1254355b6 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1214,6 +1214,7 @@ FMLALL_sb_v     0.00 1110 0.0 rm:5 110001 rn:5 rd:5 \
                 &rxx idxm=0 idxn=%fmlall_idxn
 
 FDOT_sb_v       0.00 1110 000 ..... 11111 1 ..... ..... @qrrr_s
+FDOT_hb_v       0.00 1110 010 ..... 11111 1 ..... ..... @qrrr_h
 
 ### Advanced SIMD scalar x indexed element
 
@@ -1340,6 +1341,7 @@ FMLALL_sb_vi    0 . 10 1111 0 . ... rm:3 1000 . 0 rn:5 rd:5 \
                 &rxx idxm=%hlm4 idxn=%fmlall_idxn
 
 FDOT_sb_vi      0.00 1111 00 . ..... 0000 . 0 ..... .....   @qrrx_s
+FDOT_hb_vi      0.00 1111 01 .. .... 0000 . 0 ..... .....   @qrrx_h
 
 # Floating-point conditional select
 
-- 
2.43.0


