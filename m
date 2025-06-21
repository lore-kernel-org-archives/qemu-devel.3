Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE05FC71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT85n-000690-UJ; Sat, 21 Jun 2025 19:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85h-0005zk-Ek
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:45 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85e-0006dA-Ha
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:44 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7406c6dd2b1so2295835b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550261; x=1751155061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eKGRn455B3SVQND86jeqWGYSjfImpxbXLFSHhK6iUBc=;
 b=Ckw5PPLvIsBduZwzQ4rpB2ur8x9kw9a0fYxtZk0vwsCajjGwxyA3n6o8bgvQgcp7kE
 Q3/TsD8tBHi0L6QGZ7JPkS8rm3I6YP3NhvGVeV2tMTGBb45286qHUyeKbcEC2KVGVQBg
 v6Z/7yLwmiCme8RmtgWRlvtcfAxRPS9QqFuU7ER39wSV/Pd7jgbRQajg+FcSQiY4604C
 LpRSbNe5wvCAd6VU04VGkO1mdd3me4KwO1j3dH8hR8Pkd2OGWYVXCMRT8tNLGDYrARqx
 rtEht30Q1CrW7OUEaKrafH8gvvTIY7UOpm+12bIjf5TU4wjIniuixZ6wzT/vBiIRChAR
 EPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550261; x=1751155061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eKGRn455B3SVQND86jeqWGYSjfImpxbXLFSHhK6iUBc=;
 b=ugjR6IOt8OvJ6x+oEwvOpE43tGwuOhsgCCEPe4RkikdelkbWxm7jD7Zn4NDsfYQLn/
 T7juC2t8Hf/D+djl5HqOT6QHIhWlx09G7irQBEqCACwJODcEZrBqtJ44gGsNLweWBlrh
 Pl2zeLdkUijKowGEQiwNB8IG7mPcWOTuYiWlG/JyKk0fWYmGip21U8fz0cgHrA066Ej8
 jpn8lRKZ+p2Qe1OeNutxaFQJ82EomkMxecvwjyJRAVPocs3MCI2OBGNT2MfjbOYG+XYg
 ryf2o1JK0IptPRK1yPN6J8m5IkthmAeJ2vK0ZMEn3H+L2cIpJBx/y7ahItLoGYY3qim4
 KiCA==
X-Gm-Message-State: AOJu0Ywq824Giaz3EMlVDspsTzUXNT8oUaCEIuIj5dUL5V+8N4w3BSCu
 IhoDQZHZsNfZoAdXKqxHIXLRpdnE52Ak0igN4lzO4OUERlVYg9rr3PCop6svrkR5V6xTezb5Hm4
 EibYdEQM=
X-Gm-Gg: ASbGncuzD1W2gHGcZIhfALiKh+udOYo63CXPE0r3noXUD9N8lDUAzfSVMXa7bIpoKY3
 mfTWFyBla7Kz354cHsPDU0Qwc0Chv2YBSI266dbx0T5bimbnbm3znnRkqweHXV2GrsWkMK+xn14
 0C2Tk0tRlwh8cYAC3DpwHmW8HEzFGSR1/xj6elkT9s++E7b3DnlH4gQcLWmnHwsQ0j3xyEM3rlT
 1rJ+b9wPzYmZJ5M8ITdp7XwnudnfP8YgzbUFZIBdXUW/TGIsmTvb3+rSaiTcf1C+be/Aqf4L7gM
 7Y9972CgWfG9H/Vb2IH2qXl7klu6rEgE5OTKNNujAgnfg0toDCtoVUx302/OxXFcDASiL53UsyX
 a6Wp50VsuZ/GvpJnuqyjM
X-Google-Smtp-Source: AGHT+IGtkWrtrXxHA/CipA68CIgtdZZLfNFh1uY1wXhVFNXzZ6bgaBYGKWrKHfjPCedjysk88GLi2w==
X-Received: by 2002:a05:6a21:a34b:b0:215:e02f:1eb8 with SMTP id
 adf61e73a8af0-2202930ed3dmr10840765637.14.1750550260873; 
 Sat, 21 Jun 2025 16:57:40 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f12584cbsm4551790a12.55.2025.06.21.16.57.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:57:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 097/101] target/arm: Implement LUTI2, LUTI4 for SME2/SME2p1
Date: Sat, 21 Jun 2025 16:50:33 -0700
Message-ID: <20250621235037.74091-98-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
List-Id: <qemu-devel.nongnu.org>
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
 target/arm/tcg/helper-sme.h    | 24 ++++++++++++++
 target/arm/tcg/vec_internal.h  | 15 +++++++++
 target/arm/tcg/sme_helper.c    | 59 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sve_helper.c    | 15 ---------
 target/arm/tcg/translate-sme.c | 56 ++++++++++++++++++++++++++++++++
 target/arm/tcg/sme.decode      | 42 ++++++++++++++++++++++++
 6 files changed, 196 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 98cab8d920..d86fdcbd83 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -312,3 +312,27 @@ DEF_HELPER_FLAGS_5(sme2_fclamp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i3
 DEF_HELPER_FLAGS_5(sme2_fclamp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sme2_fclamp_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sme2_bfclamp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_4(sme2_luti2_1b, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_luti2_1h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_luti2_1s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(sme2_luti2_2b, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_luti2_2h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_luti2_2s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(sme2_luti2_4b, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_luti2_4h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_luti2_4s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(sme2_luti4_1b, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_luti4_1h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_luti4_1s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(sme2_luti4_2b, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_luti4_2h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_luti4_2s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(sme2_luti4_4b, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_luti4_4h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_luti4_4s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index 0d806b73c4..14fb688eaa 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -334,4 +334,19 @@ static inline float64 float64_maybe_ah_chs(float64 a, bool fpcr_ah)
 bfloat16 helper_sme2_ah_fmax_b16(bfloat16 a, bfloat16 b, float_status *fpst);
 bfloat16 helper_sme2_ah_fmin_b16(bfloat16 a, bfloat16 b, float_status *fpst);
 
+static inline uint64_t extractn(uint64_t *p, unsigned pos, unsigned len)
+{
+    uint64_t x;
+
+    p += pos / 64;
+    pos = pos % 64;
+
+    x = p[0];
+    if (pos + len > 64) {
+        x = (x >> pos) | (p[1] << (-pos & 63));
+        pos = 0;
+    }
+    return extract64(x, pos, len);
+}
+
 #endif /* TARGET_ARM_VEC_INTERNAL_H */
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 807b160c90..7757085adf 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2020,3 +2020,62 @@ FCLAMP(sme2_fclamp_d, float64, H8)
 FCLAMP(sme2_bfclamp, bfloat16, H2)
 
 #undef FCLAMP
+
+#define DO_LUT_PRIM(SUFF, TYPE, H) \
+static inline void do_lut_##SUFF                                        \
+    (void *zd, uint64_t *indexes, uint32_t *zt0, unsigned elements,	\
+     unsigned segment, unsigned dstride, unsigned isize, unsigned nreg) \
+{                                                                       \
+    for (unsigned r = 0; r < nreg; ++r) {                               \
+        TYPE *dst = zd + dstride * r;                                   \
+        unsigned base = (segment + r) * elements;                       \
+        for (unsigned e = 0; e < elements; ++e) {                       \
+            unsigned index = extractn(indexes, base + e * isize, isize); \
+            dst[H(e)] = zt0[H4(index)];                                 \
+        }                                                               \
+    }                                                                   \
+}
+
+DO_LUT_PRIM(b, uint8_t, H1)
+DO_LUT_PRIM(h, uint16_t, H2)
+DO_LUT_PRIM(s, uint32_t, H4)
+
+#define DO_LUT(ISIZE, NREG, SUFF, TYPE) \
+void helper_sme2_luti##ISIZE##_##NREG##SUFF                             \
+    (void *zd, void *zn, CPUARMState *env, uint32_t desc)               \
+{                                                                       \
+    unsigned vl = simd_oprsz(desc);                                     \
+    unsigned strided = extract32(desc, SIMD_DATA_SHIFT, 1);             \
+    unsigned idx = extract32(desc, SIMD_DATA_SHIFT + 1, 4);             \
+    unsigned dstride = (!strided ? 1 : NREG == 4 ? 4 : 8);              \
+    unsigned segments = sizeof(TYPE) / (ISIZE * NREG);                  \
+    unsigned segment = idx & (segments - 1);                            \
+    ARMVectorReg indexes;                                               \
+    memcpy(&indexes, zn, vl);                                           \
+    do_lut_##SUFF(zd, indexes.d, (uint32_t *)&env->za_state.zt0,        \
+                  vl / sizeof(TYPE), segment * NREG,                    \
+                  dstride * sizeof(ARMVectorReg), ISIZE, NREG);         \
+}
+
+DO_LUT(2,1,b, uint8_t)
+DO_LUT(2,1,h, uint16_t)
+DO_LUT(2,1,s, uint32_t)
+DO_LUT(2,2,b, uint8_t)
+DO_LUT(2,2,h, uint16_t)
+DO_LUT(2,2,s, uint32_t)
+DO_LUT(2,4,b, uint8_t)
+DO_LUT(2,4,h, uint16_t)
+DO_LUT(2,4,s, uint32_t)
+
+DO_LUT(4,1,b, uint8_t)
+DO_LUT(4,1,h, uint16_t)
+DO_LUT(4,1,s, uint32_t)
+DO_LUT(4,2,b, uint8_t)
+DO_LUT(4,2,h, uint16_t)
+DO_LUT(4,2,s, uint32_t)
+DO_LUT(4,4,b, uint8_t)
+DO_LUT(4,4,h, uint16_t)
+DO_LUT(4,4,s, uint32_t)
+
+#undef DO_LUT
+#undef DO_LUT_PRIM
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index e933372ba4..cd1dd22b3c 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -3035,21 +3035,6 @@ void HELPER(sve_rev_d)(void *vd, void *vn, uint32_t desc)
     }
 }
 
-static uint64_t extractn(uint64_t *p, unsigned pos, unsigned len)
-{
-    uint64_t x;
-
-    p += pos / 64;
-    pos = pos % 64;
-
-    x = p[0];
-    if (pos + len > 64) {
-        x = (x >> pos) | (p[1] << (-pos & 63));
-        pos = 0;
-    }
-    return extract64(x, pos, len);
-}
-
 static void depositn(uint64_t *p, unsigned pos, unsigned len, uint64_t val)
 {
     p += pos / 64;
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 4d82666d84..397e328a1b 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1586,3 +1586,59 @@ static bool trans_SEL(DisasContext *s, arg_SEL *a)
     }
     return true;
 }
+
+static bool do_lut(DisasContext *s, arg_lut *a,
+                   gen_helper_gvec_2_ptr *fn, int data)
+{
+    if (sme_sm_enabled_check(s) && sme2_zt0_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        tcg_gen_gvec_2_ptr(vec_full_reg_offset(s, a->zd),
+                           vec_full_reg_offset(s, a->zn),
+                           tcg_env, svl, svl, data, fn);
+    }
+    return true;
+}
+
+TRANS_FEAT(LUTI2_c_1b, aa64_sme2, do_lut, a, gen_helper_sme2_luti2_1b, 0)
+TRANS_FEAT(LUTI2_c_1h, aa64_sme2, do_lut, a, gen_helper_sme2_luti2_1h, 0)
+TRANS_FEAT(LUTI2_c_1s, aa64_sme2, do_lut, a, gen_helper_sme2_luti2_1s, 0)
+
+TRANS_FEAT(LUTI2_c_2b, aa64_sme2, do_lut, a, gen_helper_sme2_luti2_2b, 1)
+TRANS_FEAT(LUTI2_c_2h, aa64_sme2, do_lut, a, gen_helper_sme2_luti2_2h, 1)
+TRANS_FEAT(LUTI2_c_2s, aa64_sme2, do_lut, a, gen_helper_sme2_luti2_2s, 1)
+
+TRANS_FEAT(LUTI2_c_4b, aa64_sme2, do_lut, a, gen_helper_sme2_luti2_4b, 1)
+TRANS_FEAT(LUTI2_c_4h, aa64_sme2, do_lut, a, gen_helper_sme2_luti2_4h, 1)
+TRANS_FEAT(LUTI2_c_4s, aa64_sme2, do_lut, a, gen_helper_sme2_luti2_4s, 1)
+
+TRANS_FEAT(LUTI4_c_1b, aa64_sme2, do_lut, a, gen_helper_sme2_luti4_1b, 0)
+TRANS_FEAT(LUTI4_c_1h, aa64_sme2, do_lut, a, gen_helper_sme2_luti4_1h, 0)
+TRANS_FEAT(LUTI4_c_1s, aa64_sme2, do_lut, a, gen_helper_sme2_luti4_1s, 0)
+
+TRANS_FEAT(LUTI4_c_2b, aa64_sme2, do_lut, a, gen_helper_sme2_luti4_2b, 1)
+TRANS_FEAT(LUTI4_c_2h, aa64_sme2, do_lut, a, gen_helper_sme2_luti4_2h, 1)
+TRANS_FEAT(LUTI4_c_2s, aa64_sme2, do_lut, a, gen_helper_sme2_luti4_2s, 1)
+
+TRANS_FEAT(LUTI4_c_4h, aa64_sme2, do_lut, a, gen_helper_sme2_luti4_4h, 1)
+TRANS_FEAT(LUTI4_c_4s, aa64_sme2, do_lut, a, gen_helper_sme2_luti4_4s, 1)
+
+static bool do_lut_s4(DisasContext *s, arg_lut *a, gen_helper_gvec_2_ptr *fn)
+{
+    return !(a->zd & 0b01100) && do_lut(s, a, fn, 4);
+}
+
+static bool do_lut_s8(DisasContext *s, arg_lut *a, gen_helper_gvec_2_ptr *fn)
+{
+    return !(a->zd & 0b01000) && do_lut(s, a, fn, 8);
+}
+
+TRANS_FEAT(LUTI2_s_2b, aa64_sme2p1, do_lut_s8, a, gen_helper_sme2_luti2_2b)
+TRANS_FEAT(LUTI2_s_2h, aa64_sme2p1, do_lut_s8, a, gen_helper_sme2_luti2_2h)
+
+TRANS_FEAT(LUTI2_s_4b, aa64_sme2p1, do_lut_s4, a, gen_helper_sme2_luti2_4b)
+TRANS_FEAT(LUTI2_s_4h, aa64_sme2p1, do_lut_s4, a, gen_helper_sme2_luti2_4h)
+
+TRANS_FEAT(LUTI4_s_2b, aa64_sme2p1, do_lut_s8, a, gen_helper_sme2_luti4_2b)
+TRANS_FEAT(LUTI4_s_2h, aa64_sme2p1, do_lut_s8, a, gen_helper_sme2_luti4_2h)
+
+TRANS_FEAT(LUTI4_s_4h, aa64_sme2p1, do_lut_s4, a, gen_helper_sme2_luti4_4h)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index d0dce75a0d..9740d74410 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -908,3 +908,45 @@ ZERO_za         11000000 000011 110 .. 0000000000 00.   \
                 &zero_za ngrp=2 nvec=4 rv=%mova_rv off=%off1_x4
 ZERO_za         11000000 000011 111 .. 0000000000 00.   \
                 &zero_za ngrp=4 nvec=4 rv=%mova_rv off=%off1_x4
+
+### SME Lookup Table Read
+
+&lut            zd zn idx
+
+# LUTI2, consecutive
+LUTI2_c_1b      1100 0000 1100 11 idx:4    00 00 zn:5 zd:5      &lut
+LUTI2_c_1h      1100 0000 1100 11 idx:4    01 00 zn:5 zd:5      &lut
+LUTI2_c_1s      1100 0000 1100 11 idx:4    10 00 zn:5 zd:5      &lut
+
+LUTI2_c_2b      1100 0000 1000 11 idx:3  1 00 00 zn:5 .... 0    &lut zd=%zd_ax2
+LUTI2_c_2h      1100 0000 1000 11 idx:3  1 01 00 zn:5 .... 0    &lut zd=%zd_ax2
+LUTI2_c_2s      1100 0000 1000 11 idx:3  1 10 00 zn:5 .... 0    &lut zd=%zd_ax2
+
+LUTI2_c_4b      1100 0000 1000 11 idx:2 10 00 00 zn:5 ... 00    &lut zd=%zd_ax4
+LUTI2_c_4h      1100 0000 1000 11 idx:2 10 01 00 zn:5 ... 00    &lut zd=%zd_ax4
+LUTI2_c_4s      1100 0000 1000 11 idx:2 10 10 00 zn:5 ... 00    &lut zd=%zd_ax4
+
+# LUTI2, strided (must check zd alignment)
+LUTI2_s_2b      1100 0000 1001 11 idx:3  1 00 00 zn:5 zd:5      &lut
+LUTI2_s_2h      1100 0000 1001 11 idx:3  1 01 00 zn:5 zd:5      &lut
+
+LUTI2_s_4b      1100 0000 1001 11 idx:2 10 00 00 zn:5 zd:5      &lut
+LUTI2_s_4h      1100 0000 1001 11 idx:2 10 01 00 zn:5 zd:5      &lut
+
+# LUTI4, consecutive
+LUTI4_c_1b      1100 0000 1100 101 idx:3    00 00 zn:5 zd:5     &lut
+LUTI4_c_1h      1100 0000 1100 101 idx:3    01 00 zn:5 zd:5     &lut
+LUTI4_c_1s      1100 0000 1100 101 idx:3    10 00 zn:5 zd:5     &lut
+
+LUTI4_c_2b      1100 0000 1000 101 idx:2  1 00 00 zn:5 .... 0   &lut zd=%zd_ax2
+LUTI4_c_2h      1100 0000 1000 101 idx:2  1 01 00 zn:5 .... 0   &lut zd=%zd_ax2
+LUTI4_c_2s      1100 0000 1000 101 idx:2  1 10 00 zn:5 .... 0   &lut zd=%zd_ax2
+
+LUTI4_c_4h      1100 0000 1000 101 idx:1 10 01 00 zn:5 ... 00   &lut zd=%zd_ax4
+LUTI4_c_4s      1100 0000 1000 101 idx:1 10 10 00 zn:5 ... 00   &lut zd=%zd_ax4
+
+# LUTI4, strided (must check zd alignment)
+LUTI4_s_2b      1100 0000 1001 101 idx:2  1 00 00 zn:5 zd:5     &lut
+LUTI4_s_2h      1100 0000 1001 101 idx:2  1 01 00 zn:5 zd:5     &lut
+
+LUTI4_s_4h      1100 0000 1001 101 idx:1 10 01 00 zn:5 zd:5     &lut
-- 
2.43.0


