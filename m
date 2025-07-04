Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E67DC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjGP-0007uk-RW; Fri, 04 Jul 2025 12:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFD-00030R-4M
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:35 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFB-0006sM-4v
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:34 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-453608ed113so12313485e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646392; x=1752251192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VVVUOYWFici2h8tZN2zcUXcpvjVGxn+olwomTA5DCH0=;
 b=iUFmSBC6ibYIEtl249EcMfvU2lJf9+GjNBkm3feT3vMEhEr08iJgUSoOu8NGbqAu1s
 XGcYobS6RykIZgKP2FyVSdIjmTLzVMystp3wACgKzkMEZgZtEukEu8RafYrBkh5Teg0P
 QqYzaBD/B3z1fYGLiBXH7MZ1xoDwkElA0DgRQ3mZko9MqsGtbzGGWHDL6rammBiQf8/b
 GXbsGHOrIrhrZ8AdEmf1Kui3QWm29yyky++8CrHOWTNR1w66URIlLcQGz5YArRZ1xnVI
 NhmoVuoDmJ/rPweZtwVBpHBTyldE+z/PJeaGPeE7bHk6IR7NPNoKNRVqkW22ZtUKUYNo
 wR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646392; x=1752251192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VVVUOYWFici2h8tZN2zcUXcpvjVGxn+olwomTA5DCH0=;
 b=B4LJU4rvlCGYPjEhf6+jCR3eYNPXJDdE3xe7EJXPnQ3kdQyCTpwfZ4BUxhyiz2KLyN
 2gXHyWrGc/yNOvEGG6eUpp63AQ4NJvNtBaMOnuUaCzxi0xU37A3N85TGeG38z/wJ+Si/
 myLeqGThNUyHlqv3wlr9pk37kYnymENfd3wviPoWjC/vqhJ31nsT1Td8ZrfcFbvWJ2aA
 Xf7iRBv2Zil4pTr+ZfTq03+YwyxI0HGxr+/Dib94c7uk8C+W3VNMsfZinH214LgqHfjV
 SMUfpvwW81ufhwlw++ggL9QBquMNpuZu3yvyVXRRQcMW5doa/l7G1Tk8h4AjhC3TQO3Q
 YgZw==
X-Gm-Message-State: AOJu0Ywb2ab1nqUQ26dmMWxFrQ6Flf2nmSBdNRkubRIVPRKQMr3r0qiu
 hV55kRYmv03cRc9DmoMdGQVzolw+8bm5dW0cVKlmewNpu+PPWuNPwptlbp4zYi90jW8BoCZhf01
 11J6w
X-Gm-Gg: ASbGnctvPCeTyLdKUovfHz4zM8+VqwcAKbAg53PzTF0uf9ZtBy3qaQMEzCs1qBwiQfR
 d1rbUYaYLRTVrV5vXzjGsnTlYtXAAHjxNOu+YxRFuyHaDSnVz0VcbyNUNUqtIpboeycoM7m6RaO
 2v+2A2yK08/SEtXmro2t4BIfinpdRCvoC4mVQvh2OLeYF+58T/Xeo6fC3VMiQIP+QCHCtp/48A/
 Q4UX//JDiHpqeq94S6ByfvkfTsj3oXW3bdLNlLUMOeSJWxm12kD3FFwuSpqnD+78pyBLI/EYyh6
 GyXJe1Ea/Deh6cqmnSUZ2v7UCnskQ4GAkiyLg4r5oY8MaDM5q16DhxerUPCPUxKdGK5L
X-Google-Smtp-Source: AGHT+IEQ/Was444msNuBlJrrsPyG30FtYzSPLtH405XVmrW5FRebC8KA7HAY23zz180RqDWDfecbFw==
X-Received: by 2002:a05:600c:468b:b0:453:6146:1182 with SMTP id
 5b1f17b1804b1-454b31198e4mr27301185e9.32.1751646391752; 
 Fri, 04 Jul 2025 09:26:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 093/119] target/arm: Implement {ADD, SMIN, SMAX, UMIN,
 UMAX}QV for SVE2p1
Date: Fri,  4 Jul 2025 17:24:33 +0100
Message-ID: <20250704162501.249138-94-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-82-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 25 ++++++++++++++++++
 target/arm/tcg/sve.decode      |  7 ++++++
 target/arm/tcg/sve_helper.c    | 46 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c | 35 ++++++++++++++++++++++++++
 4 files changed, 113 insertions(+)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 74029c641bb..5f5ecc2e0de 100644
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
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 3517efb31b3..a3221308ad4 100644
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
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 713642d4c89..625734fff9a 100644
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
index 651b4aa3781..2e29dff9895 100644
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
-- 
2.43.0


