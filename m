Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C6CC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhWr-0008J0-9B; Fri, 04 Jul 2025 10:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPE-0002W2-KJ
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:28:52 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPA-0001ML-7h
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:28:48 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2eacb421554so354029fac.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639323; x=1752244123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uNmrtiDmh6GGDdp2GUTxQDgux/FBqGqQX9fXY1bHkWI=;
 b=P2UrMOTM/TwumVqL4EddThz6LNMGPrqtsC6RMpZuDbQzhWtQ6eCxuu1xMRiuXDaIuQ
 Q6ujK2poszLiFlr28ZSDJUqkJaQCKCdFWrA8TWrFbSb8gFyO+TqFCYDXgQm4TqOks1cf
 VeWi/qNqnqMKgjZpuaRCZMr0Musb+elMsKIRBnyKVo9GPUSKzW9zDhZu0ttBL032+HCP
 YzpdLMP3/EA4lqki76eBd9S76ZCQkI+zoTeSB5+dJZHxZJzLI5ZFY8BZZuqKbq9oXwYp
 41MTuc5k4KSlHsUPjU/iWD/T/8qn14iAMgr4oNZ4jmr3jDK3+nQ3qdD5qg4+6vA/uIxj
 F0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639323; x=1752244123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uNmrtiDmh6GGDdp2GUTxQDgux/FBqGqQX9fXY1bHkWI=;
 b=FPgPMFkAcEGtl0/OUbBiPyWLXgssSKIgtLe+IMnU0z9siIsVow6WqRDqYmQANCAEwx
 ZgJmARR2fQ+Jrt53bOtpHnTiILbp/540L9MmdYLDWHzLlBnmMnai1cDBuGrBD5F2SVzP
 UQFg0lEQR1T8tuxgs1HFMMFWNuztH9Gjywh+RASVVUb67Mqt47WrciUQnZh3OYSN8VAY
 P55sav/vy9W/9e1sQLp7VYAikYdNuVwifWuuoriDbPsBndaWjtLl6r6AeYlLxBwZzxKd
 cGZGqVlUQD13gzJ6AD617Ev6R032QriD9XwGhHd2C3Vh9esfdF30tcq95eoJt12OF08Y
 4tNg==
X-Gm-Message-State: AOJu0YwE9K34jMiWvCA1gtNNWEEli6/hRuFshcvxlj585atVMdI5JgX/
 bL+xUCYsBWmN5Ah0rye+C7HS8ZnhGSykNPV8Kme1moL2s82yCWual5Qo2o8qSjbEDLwY2KYjYI7
 2Glpph04=
X-Gm-Gg: ASbGncuN7KXazuM9n0BhCoLfiRDEMJEzz0gXA/yhXIu8qOrN4a/O/+Y2q3/sRv/hy23
 XaBveqPfE0t5wA38xhEVxetX9ra/Ubvxd/O6ifGNFsiMs2GuataBrwhxpy8Q1Wy4d8Nb5ZQQ+v7
 Tk3JV2fs+3MKQvNqeA3PoJvzg3HGrNBd1BulWgs51aAyO3JXGLB81yOkVsgI1aVlWmcAmfPCcKV
 J1iZ5eIa2055VRNtMgo1fhk8kPmWEcYJTrHIWbh/rUV9OHfwsHgxWBHJokPtC1Acmvb7QaMqXf/
 5O7o3RGB9TJZfn3mNoOweetNzEVBvgA6/EOXo5/wu5/qEui80Sy/D7PmCcaWYGeHpncUeJwqFjf
 3EXGYdVEXgHux2zReEK/gny0zr4YyA9trBzcHQUjqw96EABMA
X-Google-Smtp-Source: AGHT+IHXCUUSvanesAK6gz1CPcnFEta/WdkGl9YHW5qHU4aZIlqikbvBvtMbOnluw9tH74WX30pOaA==
X-Received: by 2002:a05:6870:8289:b0:2d6:245:a9b3 with SMTP id
 586e51a60fabf-2f791d8d489mr2681596fac.6.1751639322768; 
 Fri, 04 Jul 2025 07:28:42 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff55633sm531448fac.20.2025.07.04.07.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:28:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 084/108] target/arm: Implement ANDQV, ORQV, EORQV for SVE2p1
Date: Fri,  4 Jul 2025 08:20:47 -0600
Message-ID: <20250704142112.1018902-85-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 15 ++++++++++++
 target/arm/tcg/sve_helper.c    | 42 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c |  3 +++
 target/arm/tcg/sve.decode      |  5 ++++
 4 files changed, 65 insertions(+)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index ec82d0a4e7..9758613b2d 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -2955,3 +2955,18 @@ DEF_HELPER_FLAGS_4(sve2p1_uminqv_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2p1_uminqv_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_3(pext, TCG_CALL_NO_RWG, void, ptr, i32, i32)
+
+DEF_HELPER_FLAGS_4(sve2p1_orqv_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_orqv_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_orqv_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_orqv_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2p1_eorqv_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_eorqv_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_eorqv_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_eorqv_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2p1_andqv_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_andqv_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_andqv_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_andqv_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 866f85ba30..f47e719fbe 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -123,6 +123,11 @@ static inline uint64_t expand_pred_s(uint8_t byte)
     return word[byte & 0x11];
 }
 
+static inline uint64_t expand_pred_d(uint8_t byte)
+{
+    return -(uint64_t)(byte & 1);
+}
+
 #define LOGICAL_PPPP(NAME, FUNC) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *vg, uint32_t desc)  \
 {                                                                         \
@@ -206,6 +211,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *vg, uint32_t desc) \
 #define DO_EOR(N, M)  (N ^ M)
 #define DO_ORR(N, M)  (N | M)
 #define DO_BIC(N, M)  (N & ~M)
+#define DO_ORC(N, M)  (N | ~M)
 #define DO_ADD(N, M)  (N + M)
 #define DO_SUB(N, M)  (N - M)
 #define DO_MAX(N, M)  ((N) >= (M) ? (N) : (M))
@@ -1900,10 +1906,46 @@ DO_ZZI(sve_umini_d, uint64_t, DO_MIN)
 
 #undef DO_ZZI
 
+#define DO_LOGIC_QV(NAME, SUFF, INIT, VOP, POP)                         \
+void HELPER(NAME ## _ ## SUFF)(void *vd, void *vn, void *vg, uint32_t desc) \
+{                                                                       \
+    unsigned seg = simd_oprsz(desc) / 16;                               \
+    uint64_t r0 = INIT, r1 = INIT;                                      \
+    for (unsigned s = 0; s < seg; s++) {                                \
+        uint64_t p0 = expand_pred_##SUFF(*(uint8_t *)(vg + H1(s * 2))); \
+        uint64_t p1 = expand_pred_##SUFF(*(uint8_t *)(vg + H1(s * 2 + 1))); \
+        uint64_t v0 = *(uint64_t *)(vn + s * 16);                       \
+        uint64_t v1 = *(uint64_t *)(vn + s * 16 + 8);                   \
+        v0 = POP(v0, p0), v1 = POP(v1, p1);                             \
+        r0 = VOP(r0, v0), r1 = VOP(r1, v1);                             \
+    }                                                                   \
+    *(uint64_t *)(vd + 0) = r0;                                         \
+    *(uint64_t *)(vd + 8) = r1;                                         \
+    clear_tail(vd, 16, simd_maxsz(desc));                               \
+}
+
+DO_LOGIC_QV(sve2p1_orqv, b, 0, DO_ORR, DO_AND)
+DO_LOGIC_QV(sve2p1_orqv, h, 0, DO_ORR, DO_AND)
+DO_LOGIC_QV(sve2p1_orqv, s, 0, DO_ORR, DO_AND)
+DO_LOGIC_QV(sve2p1_orqv, d, 0, DO_ORR, DO_AND)
+
+DO_LOGIC_QV(sve2p1_eorqv, b, 0, DO_EOR, DO_AND)
+DO_LOGIC_QV(sve2p1_eorqv, h, 0, DO_EOR, DO_AND)
+DO_LOGIC_QV(sve2p1_eorqv, s, 0, DO_EOR, DO_AND)
+DO_LOGIC_QV(sve2p1_eorqv, d, 0, DO_EOR, DO_AND)
+
+DO_LOGIC_QV(sve2p1_andqv, b, -1, DO_AND, DO_ORC)
+DO_LOGIC_QV(sve2p1_andqv, h, -1, DO_AND, DO_ORC)
+DO_LOGIC_QV(sve2p1_andqv, s, -1, DO_AND, DO_ORC)
+DO_LOGIC_QV(sve2p1_andqv, d, -1, DO_AND, DO_ORC)
+
+#undef DO_LOGIC_QV
+
 #undef DO_AND
 #undef DO_ORR
 #undef DO_EOR
 #undef DO_BIC
+#undef DO_ORC
 #undef DO_ADD
 #undef DO_SUB
 #undef DO_MAX
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 6ad4d1e289..2114b2ecca 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -778,6 +778,9 @@ DO_ZPZ(NOT_zpz, aa64_sve, sve_not_zpz)
 DO_ZPZ(ABS, aa64_sve, sve_abs)
 DO_ZPZ(NEG, aa64_sve, sve_neg)
 DO_ZPZ(RBIT, aa64_sve, sve_rbit)
+DO_ZPZ(ORQV, aa64_sme2p1_or_sve2p1, sve2p1_orqv)
+DO_ZPZ(EORQV, aa64_sme2p1_or_sve2p1, sve2p1_eorqv)
+DO_ZPZ(ANDQV, aa64_sme2p1_or_sve2p1, sve2p1_andqv)
 
 static gen_helper_gvec_3 * const fabs_fns[4] = {
     NULL,                  gen_helper_sve_fabs_h,
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index b762257759..ff740f7b40 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -326,6 +326,11 @@ ORV             00000100 .. 011 000 001 ... ..... .....         @rd_pg_rn
 EORV            00000100 .. 011 001 001 ... ..... .....         @rd_pg_rn
 ANDV            00000100 .. 011 010 001 ... ..... .....         @rd_pg_rn
 
+# SVE2.1 bitwise logical reduction (quadwords)
+ORQV            00000100 .. 011 100 001 ... ..... .....         @rd_pg_rn
+EORQV           00000100 .. 011 101 001 ... ..... .....         @rd_pg_rn
+ANDQV           00000100 .. 011 110 001 ... ..... .....         @rd_pg_rn
+
 # SVE constructive prefix (predicated)
 MOVPRFX_z       00000100 .. 010 000 001 ... ..... .....         @rd_pg_rn
 MOVPRFX_m       00000100 .. 010 001 001 ... ..... .....         @rd_pg_rn
-- 
2.43.0


