Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB73BC7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT85Z-0004sY-9V; Sat, 21 Jun 2025 19:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85V-0004a8-QV
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:33 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85T-0006aK-HP
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:33 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-235ef62066eso39625545ad.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550250; x=1751155050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5GEla+zi8zJhOMGLnJ1oFRvD0YvWJtoWeiKoccxwfsc=;
 b=uEiQgO2wWy6tPHuCE+b1vTUpk06Uwb1NXmHgEggTMYdflYKxkgJ7XQFQMdsly6oF6o
 Orop9hzg/QdrK7RQXJpoL4nIuh+x+cCNwNfTfOq49Py0JAXj58t6T6pk34r5GUVrZd30
 +VFmNKXmmJkW1WVWgsPy05T8zVPPRNjsHena2NKjY9xd7sE79rvICab8B2xfablT315A
 gkyUGdmKCbqxXnf0IbAXEaJFl8AR6AIPJoJh81d693SbGPtupDMdxzlhGml3w5zR4ORG
 2TRSZpZNNl8pCujj0/5mrCs79cM51OZY7zZMiYbnFLYrdjuTuwRHZwiUnqinGmT+Ovxe
 H2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550250; x=1751155050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5GEla+zi8zJhOMGLnJ1oFRvD0YvWJtoWeiKoccxwfsc=;
 b=JbVfHHoCuYmzIbD7mkRN9QlBjZ45nW8gZYlIWxYr7+XXLT0SLFy3NFTkFUQE0kw8bh
 v/8RSiWi9loSwv2P9Hv1g/5TQluCfipnI1A8dYUGxbSXxi2LkiJdQv8zb3RryrBT4e5o
 mhjh8QFNPuenpXskjojqkwunSdtocAlsBdR4RGltRd4GcTfnxpm1ELbcrfw0WFhoWo8h
 +9PuJZJipqmpUJp+7gUgnExvv6qWM8BDoHGAyVh1joSoP2/lVRm65o3RJReamokNi7UT
 vUkis2W/6CYJH4c2wgdEI7KcSj5Dog8/IrQBkrWsMwwq475E49JSCZxrHUtbzB4U5v8Y
 3bLg==
X-Gm-Message-State: AOJu0Yyjp/tG8VNCCk1yPzLJlBhqNs2hCMQ2ygSluIB9VvDMO9tNJmuX
 wISXIlTDw6Yghw3gUqSR8Q+UNVeMflWb06XdTJv065xviX+VGLOnbOGLhBB9yywPp/5IGAxZozO
 2MFcKBsw=
X-Gm-Gg: ASbGncuTUjJ3A1mdBjKHlFbdn2BsBQazr7r7GlLVtZ4YLvDnD9IvQeadcovNga6kJIb
 VKNQUJjIiAbQXhJ8dazV2tw2f65Jrt4ht68IS7VyCXFmeaEqa5DQWw26ZRTIRIMLnWtoYVWwMFg
 DVVCn2+2ievuUDMwoG1EmpeNqfuGk2ECLQ8IbYX1VrkeQp/0FVDNZ2sjsd+42q57mRzozhK7OoZ
 Dh/Sk7cCxqc4oHukzUc8wS+GGZVmQkW6dp/a1esk5Y34+Bf9kkTTPI3zkvQDD9d0TuIYVTs8XaR
 AAtcULDNLP7kz061Z0B7qWPkX7JwTRHBMQx+uNQ5zXoV0SGewnotV8KURlrzL7DK/M+6fQy3yli
 c0y1NqYWz2se6+FtdsNwq
X-Google-Smtp-Source: AGHT+IE/bxn4o0XdxtfswJah42bWKoSesJcwsWjD/B41ynOPlAGA29SBZczD+qxuLrahn0mmzE/lag==
X-Received: by 2002:a17:902:e54a:b0:234:d7b2:2aab with SMTP id
 d9443c01a7336-237d972fa09mr104030995ad.14.1750550249873; 
 Sat, 21 Jun 2025 16:57:29 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f12584cbsm4551790a12.55.2025.06.21.16.57.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:57:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 080/101] target/arm: Implement {ADD, SMIN, SMAX, UMIN,
 UMAX}QV for SVE2p1
Date: Sat, 21 Jun 2025 16:50:16 -0700
Message-ID: <20250621235037.74091-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
 target/arm/tcg/helper-sve.h    | 25 ++++++++++++++++++
 target/arm/tcg/sve_helper.c    | 46 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c | 35 ++++++++++++++++++++++++++
 target/arm/tcg/sve.decode      |  7 ++++++
 4 files changed, 113 insertions(+)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 74029c641b..5f5ecc2e0d 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -2928,3 +2928,28 @@ DEF_HELPER_FLAGS_4(sve2_sqshlu_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_sqshlu_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_sqshlu_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_sqshlu_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2p1_addqv_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_addqv_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_addqv_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_addqv_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2p1_smaxqv_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_smaxqv_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_smaxqv_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_smaxqv_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2p1_sminqv_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_sminqv_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_sminqv_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_sminqv_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2p1_umaxqv_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_umaxqv_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_umaxqv_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_umaxqv_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2p1_uminqv_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_uminqv_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_uminqv_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_uminqv_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index dfc3e5cabe..382c471aaa 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -1814,6 +1814,52 @@ DO_VPZ_D(sve_uminv_d, uint64_t, uint64_t, -1, DO_MIN)
 #undef DO_VPZ
 #undef DO_VPZ_D
 
+#define DO_VPQ(NAME, TYPE, H, INIT, OP) \
+void HELPER(NAME)(void *vd, void *vn, void *vg, uint32_t desc)          \
+{                                                                       \
+    TYPE tmp[16 / sizeof(TYPE)] = { [0 ... 16 / sizeof(TYPE) - 1] = INIT }; \
+    TYPE *n = vn; uint16_t *g = vg;                                     \
+    uintptr_t oprsz = simd_oprsz(desc);                                 \
+    uintptr_t nseg = oprsz / 16, nsegelt = 16 / sizeof(TYPE);           \
+    for (uintptr_t s = 0; s < nseg; s++) {                              \
+        uint16_t pg = g[H2(s)];                                         \
+        for (uintptr_t e = 0; e < nsegelt; e++, pg >>= sizeof(TYPE)) {  \
+            if (pg & 1) {                                               \
+                tmp[e] = OP(tmp[H(e)], n[s * nsegelt + H(e)]);          \
+            }                                                           \
+        }                                                               \
+    }                                                                   \
+    memcpy(vd, tmp, 16);                                                \
+    clear_tail(vd, 16, simd_maxsz(desc));                               \
+}
+
+DO_VPQ(sve2p1_addqv_b, uint8_t, H1, 0, DO_ADD)
+DO_VPQ(sve2p1_addqv_h, uint16_t, H2, 0, DO_ADD)
+DO_VPQ(sve2p1_addqv_s, uint32_t, H4, 0, DO_ADD)
+DO_VPQ(sve2p1_addqv_d, uint64_t, H8, 0, DO_ADD)
+
+DO_VPQ(sve2p1_smaxqv_b, int8_t, H1, INT8_MIN, DO_MAX)
+DO_VPQ(sve2p1_smaxqv_h, int16_t, H2, INT16_MIN, DO_MAX)
+DO_VPQ(sve2p1_smaxqv_s, int32_t, H4, INT32_MIN, DO_MAX)
+DO_VPQ(sve2p1_smaxqv_d, int64_t, H8, INT64_MIN, DO_MAX)
+
+DO_VPQ(sve2p1_sminqv_b, int8_t, H1, INT8_MAX, DO_MIN)
+DO_VPQ(sve2p1_sminqv_h, int16_t, H2, INT16_MAX, DO_MIN)
+DO_VPQ(sve2p1_sminqv_s, int32_t, H4, INT32_MAX, DO_MIN)
+DO_VPQ(sve2p1_sminqv_d, int64_t, H8, INT64_MAX, DO_MIN)
+
+DO_VPQ(sve2p1_umaxqv_b, uint8_t, H1, 0, DO_MAX)
+DO_VPQ(sve2p1_umaxqv_h, uint16_t, H2, 0, DO_MAX)
+DO_VPQ(sve2p1_umaxqv_s, uint32_t, H4, 0, DO_MAX)
+DO_VPQ(sve2p1_umaxqv_d, uint64_t, H8, 0, DO_MAX)
+
+DO_VPQ(sve2p1_uminqv_b, uint8_t, H1, -1, DO_MIN)
+DO_VPQ(sve2p1_uminqv_h, uint16_t, H2, -1, DO_MIN)
+DO_VPQ(sve2p1_uminqv_s, uint32_t, H4, -1, DO_MIN)
+DO_VPQ(sve2p1_uminqv_d, uint64_t, H8, -1, DO_MIN)
+
+#undef DO_VPQ
+
 /* Two vector operand, one scalar operand, unpredicated.  */
 #define DO_ZZI(NAME, TYPE, OP)                                       \
 void HELPER(NAME)(void *vd, void *vn, uint64_t s64, uint32_t desc)   \
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index e6e2f342ab..ade4914aba 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -828,6 +828,41 @@ TRANS_FEAT(SXTW, aa64_sve, gen_gvec_ool_arg_zpz,
 TRANS_FEAT(UXTW, aa64_sve, gen_gvec_ool_arg_zpz,
            a->esz == 3 ? gen_helper_sve_uxtw_d : NULL, a, 0)
 
+static gen_helper_gvec_3 * const addqv_fns[4] = {
+    gen_helper_sve2p1_addqv_b, gen_helper_sve2p1_addqv_h,
+    gen_helper_sve2p1_addqv_s, gen_helper_sve2p1_addqv_d,
+};
+TRANS_FEAT(ADDQV, aa64_sme2p1_or_sve2p1,
+           gen_gvec_ool_arg_zpz, addqv_fns[a->esz], a, 0)
+
+static gen_helper_gvec_3 * const smaxqv_fns[4] = {
+    gen_helper_sve2p1_smaxqv_b, gen_helper_sve2p1_smaxqv_h,
+    gen_helper_sve2p1_smaxqv_s, gen_helper_sve2p1_smaxqv_d,
+};
+TRANS_FEAT(SMAXQV, aa64_sme2p1_or_sve2p1,
+           gen_gvec_ool_arg_zpz, smaxqv_fns[a->esz], a, 0)
+
+static gen_helper_gvec_3 * const sminqv_fns[4] = {
+    gen_helper_sve2p1_sminqv_b, gen_helper_sve2p1_sminqv_h,
+    gen_helper_sve2p1_sminqv_s, gen_helper_sve2p1_sminqv_d,
+};
+TRANS_FEAT(SMINQV, aa64_sme2p1_or_sve2p1,
+           gen_gvec_ool_arg_zpz, sminqv_fns[a->esz], a, 0)
+
+static gen_helper_gvec_3 * const umaxqv_fns[4] = {
+    gen_helper_sve2p1_umaxqv_b, gen_helper_sve2p1_umaxqv_h,
+    gen_helper_sve2p1_umaxqv_s, gen_helper_sve2p1_umaxqv_d,
+};
+TRANS_FEAT(UMAXQV, aa64_sme2p1_or_sve2p1,
+           gen_gvec_ool_arg_zpz, umaxqv_fns[a->esz], a, 0)
+
+static gen_helper_gvec_3 * const uminqv_fns[4] = {
+    gen_helper_sve2p1_uminqv_b, gen_helper_sve2p1_uminqv_h,
+    gen_helper_sve2p1_uminqv_s, gen_helper_sve2p1_uminqv_d,
+};
+TRANS_FEAT(UMINQV, aa64_sme2p1_or_sve2p1,
+           gen_gvec_ool_arg_zpz, uminqv_fns[a->esz], a, 0)
+
 /*
  *** SVE Integer Reduction Group
  */
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 13a76f773d..f16764a947 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -340,6 +340,13 @@ UMAXV           00000100 .. 001 001 001 ... ..... .....         @rd_pg_rn
 SMINV           00000100 .. 001 010 001 ... ..... .....         @rd_pg_rn
 UMINV           00000100 .. 001 011 001 ... ..... .....         @rd_pg_rn
 
+# SVE2.1 segment reduction
+ADDQV           00000100 .. 000 101 001 ... ..... .....         @rd_pg_rn
+SMAXQV          00000100 .. 001 100 001 ... ..... .....         @rd_pg_rn
+SMINQV          00000100 .. 001 110 001 ... ..... .....         @rd_pg_rn
+UMAXQV          00000100 .. 001 101 001 ... ..... .....         @rd_pg_rn
+UMINQV          00000100 .. 001 111 001 ... ..... .....         @rd_pg_rn
+
 ### SVE Shift by Immediate - Predicated Group
 
 # SVE bitwise shift by immediate (predicated)
-- 
2.43.0


