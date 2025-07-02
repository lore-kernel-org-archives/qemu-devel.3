Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EF1C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwqR-0006Zn-Ha; Wed, 02 Jul 2025 08:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwju-0004j9-3n
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:39:03 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjc-0002Db-Gi
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:39:01 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2ef461b9daeso4577910fac.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459922; x=1752064722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sKOpEWjkNlbOPNU7ZTnFk6dbmvwMJhj9M16z1yEkhdg=;
 b=YXVCc0gEsC6QCQR6K6N/OzE/BHyOtwey0VJZGG0Er36jILHoKUyiWhLNvJbG2A0hl+
 HcamBCi/C4Lf3VczaLKJnwqzpY0qUQIMwYQUweRpMRIvysQIrffdVnwGj3Yi1wxh7Skp
 2KuPSr0xTW9tDZoAKz9FulPFiMtzM+pkEjWChzkx7Q/PO82gntgnf+JAXbhC4DTMOUBS
 0EB/bxvZ1uLKXnvlCdXWW5G9k58HYmoTI0c6q7itvj66cZ76bBmA7E9UR1GqDSvoz+S8
 D30t0Lz3lDh7eAqHAB60z0A2pYlKjd8QMU4cGwWCLeJnkmhdFrYgeGWh3uXfKyFSp7Lf
 YpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459922; x=1752064722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sKOpEWjkNlbOPNU7ZTnFk6dbmvwMJhj9M16z1yEkhdg=;
 b=S+3IOmSjmi+sOD6HSguIhcYWAJym/qRDkW0rbuqvO+4Vn/1zp255bUHCobr9h4Qapk
 znYgGi7+zYkQk6KPVdy3V6vmToQRXVu3aeIYIOakLnC33Rfxunho6z/wqoI1D2nYuPwe
 y/D0M7gloGnpAggz/8EJ5VgVGzKfF03Vj9K9nVIuRLW7Z7B+NwL03pbzbei/0FhPsVnY
 1HZQTWHKLgycB+mudzJVNUG1bF5VhPJgIOd/FGWwD6ineuMmIYyTWzKfy5IlFMfXKCV6
 HJQnp36v4mqwsRtoowvj07LfckAAzHCYxBvSr1n9ZQo0dxiQ2KakjBZnCK4/Ou6Vlwmr
 hHdw==
X-Gm-Message-State: AOJu0YwxKxLOpmjpjnJeJfrl8IcGl0xS44agmvBFbmFgNiOWC+bIciho
 IMHJtO3hJcRr9K+zMs2N7YjQX8r9qmbw1QiKtZX1upfVbjsqGVXOW1BwP80UEFt1Yw+1rEveLnb
 MrO8SQhA=
X-Gm-Gg: ASbGncu9wmJqYlNSl5hhOpsTPjekW1lnUTHFQ3T5JN7W6wja3Kun1/dVodP+d2bTrqT
 d6c2pL3IVl1zEdjhvA+6Zs6gdxW9R0/iOjwdeNK/15jblyfYtqktDV7/MMidl5emdyPQTG47beM
 msg0cBqK1VQYx8zJQE4UYoJxoPzUaE8+biBH46obRem0TCeEVlzk+Tk4DhOgDCGbMEK/zZ5ynoF
 t6PK6qzlseHVoz1EDdyzRRJxYPsqxfWk9y7MDz+qbxa9J473tUTu3/mpCWUeGW5Woi0aJ/VwHQr
 GVC4uIm5Y7uR2uXH+z2Gi7kK0ckjeUvabQo8R+AdwzdojNlEFLFokbwTznQpDo63bGdhhw==
X-Google-Smtp-Source: AGHT+IHPmDv0dHvg+Byg2QG+k5zHzVKv4LFd6Xk70JYaH3FwzqnwbvZ0XwSnUtaTJ76k1rodxSELnw==
X-Received: by 2002:a05:6870:f71e:b0:2e9:95cc:b855 with SMTP id
 586e51a60fabf-2f5c7bdcb00mr2095859fac.34.1751459922091; 
 Wed, 02 Jul 2025 05:38:42 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 70/97] target/arm: Implement {ADD, SMIN, SMAX, UMIN,
 UMAX}QV for SVE2p1
Date: Wed,  2 Jul 2025 06:33:43 -0600
Message-ID: <20250702123410.761208-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index f5fbfb751e..cc706db901 100644
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
index 651b4aa378..2e29dff989 100644
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
index 3517efb31b..a3221308ad 100644
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


