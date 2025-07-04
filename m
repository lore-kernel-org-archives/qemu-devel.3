Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE508C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhTo-0002D6-P5; Fri, 04 Jul 2025 10:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPC-0002VQ-Th
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:28:52 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhP7-0001KL-Su
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:28:44 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2eb5cbe41e1so851409fac.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639320; x=1752244120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LD9najaMFjOAkiy2y4i6SBLnurGGQSXD1R6zyckM/+g=;
 b=oAWpVrq+JphQA9SvN0Lc1XZyGnc5GPJg8WtKD3CykXNmcAeK5eumVbx9td2OkuHfOH
 3PUhqwQhaEArjWmGbhGRXvgcZPwOefLId4It5hVrAgrpoVpbkv2B9FM3sj3PsPk2feCd
 tgA+vc3eV8bPh4UKqufxR2NljSRYhfbDbJzfmo/a4MKunc2isCVr0i7ac4ZfMU5+BmxO
 SwEMJsDk8KdwlP22DMudMfi0wdjNwVnGItCH40W7zDyCkonsGSloFzpQ/hrVvDPlI+f9
 19uIBB6suE17rPcwLdQuY8rTi3zse3C4RgwRNAV2jtybOBZ/87tB8uwo6AeSngeO/YNY
 SSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639320; x=1752244120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LD9najaMFjOAkiy2y4i6SBLnurGGQSXD1R6zyckM/+g=;
 b=qtqn0CZtshP5Pz6GclgiC7cDum3A7tm5GRusXhwjOut3mqtAy9N8hDwJYwZPeoR3hG
 5Y9/ON4mAZwMM9QBeeOcr/0YmdHXVu8TyLw36y05vSBrIB/datp0XjQZqpvWcKGPgemU
 SgNiXRdtuNJmWatJI0Ajjt/HndLURf9YlDU+sOc0v6sQRJreFT+HqPMdMyEwoCBscGu2
 h7xvh0kAePiE1OzmpDcu1O5wlbkpFirMxH12EJ2OiQaEcS6YoLr51BrVEsS5+7CytZfd
 PtIN1QKF4QrBiQn7z2MSPz+2kJkDvC9G50xToPXFbl9IoCVPPwlFd2Xiz1DbZmk4dciu
 155w==
X-Gm-Message-State: AOJu0Ywwzj26rK18O6pSwD9WUb0polByLFWd4aQGXSlmx4XY8IDABcHV
 p2sot9sB+R8Rp4RtCwASKaSpczGUJNpfD23FMZxKnLdX0a1Un9TSUY8K6ioIdbeMGybGWNW80yq
 6wqonyNA=
X-Gm-Gg: ASbGncvZ88eX1URaIH3mvj1bDZdEzKFdfsQXiDl/Sncvz3d5dkBwVBDbb02Wv1/wIQg
 2AlVI7j03Qk91g6lisNAaPlWmlPdIpLWDq6P7IyEsA3+tSVPfShe5r0QIytNWu47+S4k6jGyyNd
 T08IigMFanxdsC6bKe3U/gQr4uRTcgu2kE+qy8NrRnKM3KVU4rrBqBIBnwdt2Buzp1K1TThIekB
 BgaJtudP8x5/2DKUNUOl1c32xg3PNfLzrbNUGujSAPDpWqQZUWMrraFCHmpSRFcybgOXmpu7pjj
 DYZth0mGCs29l+NrjD5oAESiz94d2dCJD0ZK7m3wJooZVDo49cTZbwdZ5/5y2HwwvO4PfD7rtQZ
 Y5yGMAXpHtaYyKSNGbhHSWOi6eLlfgGbrfRinSzNFEunwOiLJ
X-Google-Smtp-Source: AGHT+IFpxTFNUynWaJPqOoQih/4cluXLlIe4y4FBu54u+gfj5p7xSR3RPC5h+3BHfmJAJ481gEclYA==
X-Received: by 2002:a05:6870:3927:b0:2cb:c780:ac52 with SMTP id
 586e51a60fabf-2f796c3af77mr1675843fac.23.1751639319628; 
 Fri, 04 Jul 2025 07:28:39 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff55633sm531448fac.20.2025.07.04.07.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:28:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 081/108] target/arm: Implement {ADD, SMIN, SMAX, UMIN,
 UMAX}QV for SVE2p1
Date: Fri,  4 Jul 2025 08:20:44 -0600
Message-ID: <20250704142112.1018902-82-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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
index 713642d4c8..625734fff9 100644
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


