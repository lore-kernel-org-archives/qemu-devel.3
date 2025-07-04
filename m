Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B798C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjFB-0002qh-HY; Fri, 04 Jul 2025 12:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEs-0001VQ-IC
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:14 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEq-0006cd-8z
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:14 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so9792615e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646371; x=1752251171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eqvd728YfKkBr7d+51LvvdyAE2rDb0O/EGOJp4tzeA4=;
 b=Aodj0EI/1JOnOE8hd6lHHq8nAbpoJoNCMfHaO2qIUdoZVzt4pTHf9QRGisIw3MVxqw
 YaHGZswm2SjyGSQyESqAf4sXdz/uKoqfaEjx8qfPC+HXjIasOAWL6jnsz/lnbhTisAeJ
 74lIBvWP8jFw24KjfQCuKouQV6PhV6k3K5/ilrESHUoLV9t+Jp4TNpLhHyc1vEAhSUIf
 +roIZYw5JH4onipV3govNS4Gm8SKNy+aFDLuOUj6OeEeOCE6DsWLoLfTCexTHF/9V41c
 vKm6PdGqpTqePny/avwSpfewugSQc0P7cOFyYfSgXBsPM89v8MrPLCpwipetwImUTXfZ
 rrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646371; x=1752251171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eqvd728YfKkBr7d+51LvvdyAE2rDb0O/EGOJp4tzeA4=;
 b=qpE/oY6VtYBchp8x7qQIfpiCx5tWXBDTvQU4K5ZKfNgVAZj2OCkiBn4J8votspIdxK
 /laU6rTYVH0aip5smwXqTGxuuZJGcjDGO1CRdfcHnSiXkeAvJES85e81iEVwOdHfA2Vw
 sPtQhKlgVFdv8d1l+/U0u9chBmIY9EgSyiHivy9KW5Fz0jJ/Pz9bmfWR4izusJTeB2du
 B00c4dvq0bDXs5c5DTZkZ6Z6BaZ562WAMSSEklDaQt+4J4f4yiGj4WROPPkmsjzi7mWk
 KO1Sw0jsB1tsUnSDRv3dr2S0zgHR4to9+0HAd3ntzcHfqFzy9QGcKdVFFqylz0C+S00t
 DDeQ==
X-Gm-Message-State: AOJu0YxFgFLAC0sG2LTuY4nAjyhFbjR8io6jKz5KsGYyeHFPOYppO325
 AJs6pHtYzz/8kwqArVWBuyUjqQ2mdNbq2HXISoOZPwb3FJdyIuVhJ90pJspq3/kQ8adqgmQPZLh
 6U1/4
X-Gm-Gg: ASbGncvVzyCyOdkP6cgWV/ZZE34Wnuh2b+Cw+LkLSoW4MPqZwuna9xcIJzXgQfOdVE7
 Cu4oath667lV5gIjfOSI29w5Q6bX/nypuu2mU4wg4U0RC69X1nTqQAWYLHtmXIgRGy5fpanWLaY
 8oj4tTf81f1ZnPu2FcSt7AmkrrwEHmTYIjiPQcW4sPtoPHE2QEBrwU4SP800yDuJaAEy8dwgJld
 OXd5CmTiFpy/maGI+SW2ZHYygl5UKBYe1wbYw6AMi4ZZqpce9+eAjchoKFypmsB0XfnEYG5racy
 5Y2JdPr8l3t6QfpD4w5rhxlER5c6hFvW96nPBnXMXGEv9XPMlSDNnocGvnM0ysmJfGzK
X-Google-Smtp-Source: AGHT+IEdmmT1NF07u+sImoA771a7MIsn04cbmNRFgbq6Xw4aaxUPfEZcE3+NCkE8L4Y0f1y8hasD+A==
X-Received: by 2002:a05:600c:a4b:b0:43e:bdf7:7975 with SMTP id
 5b1f17b1804b1-454b4ebd799mr24171515e9.32.1751646370585; 
 Fri, 04 Jul 2025 09:26:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 071/119] target/arm: Implement SME2 SQCVT, UQCVT, SQCVTU
Date: Fri,  4 Jul 2025 17:24:11 +0100
Message-ID: <20250704162501.249138-72-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250704142112.1018902-60-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  20 ++++++
 target/arm/tcg/sme.decode      |  22 +++++++
 target/arm/tcg/sme_helper.c    | 116 +++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c |  35 ++++++++++
 4 files changed, 193 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 6314ad7e012..792b9936954 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -221,3 +221,23 @@ DEF_HELPER_FLAGS_4(sme2_fcvt_w, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvtl, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_scvtf, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_ucvtf, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_3(sme2_sqcvt_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqcvt_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqcvtu_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqcvt_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqcvt_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqcvtu_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqcvt_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqcvt_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqcvtu_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sme2_sqcvtn_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqcvtn_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqcvtun_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqcvtn_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqcvtn_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqcvtun_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqcvtn_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqcvtn_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqcvtun_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 9cc25622d4c..e005f6e6ed6 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -726,6 +726,8 @@ SUB_aaz_d       11000001 111 000010 .. 111 ...00 11 ...     @az_4x4_o3
 &zz_n           zd zn n
 @zz_1x2         ........ ... ..... ...... ..... zd:5        \
                 &zz_n n=1 zn=%zn_ax2
+@zz_1x4         ........ ... ..... ...... ..... zd:5        \
+                &zz_n n=1 zn=%zn_ax4
 @zz_2x1         ........ ... ..... ...... zn:5  .....       \
                 &zz_n n=1 zd=%zd_ax2
 @zz_2x2         ........ ... ..... ...... .... . .....      \
@@ -760,3 +762,23 @@ FRINTM          11000001 101 01010 111000 ....0 ....0       @zz_2x2
 FRINTM          11000001 101 11010 111000 ...00 ...00       @zz_4x4
 FRINTA          11000001 101 01100 111000 ....0 ....0       @zz_2x2
 FRINTA          11000001 101 11100 111000 ...00 ...00       @zz_4x4
+
+SQCVT_sh        11000001 001 00011 111000 ....0 .....       @zz_1x2
+UQCVT_sh        11000001 001 00011 111000 ....1 .....       @zz_1x2
+SQCVTU_sh       11000001 011 00011 111000 ....0 .....       @zz_1x2
+
+SQCVT_sb        11000001 001 10011 111000 ...00 .....       @zz_1x4
+UQCVT_sb        11000001 001 10011 111000 ...01 .....       @zz_1x4
+SQCVTU_sb       11000001 011 10011 111000 ...00 .....       @zz_1x4
+
+SQCVT_dh        11000001 101 10011 111000 ...00 .....       @zz_1x4
+UQCVT_dh        11000001 101 10011 111000 ...01 .....       @zz_1x4
+SQCVTU_dh       11000001 111 10011 111000 ...00 .....       @zz_1x4
+
+SQCVTN_sb       11000001 001 10011 111000 ...10 .....       @zz_1x4
+UQCVTN_sb       11000001 001 10011 111000 ...11 .....       @zz_1x4
+SQCVTUN_sb      11000001 011 10011 111000 ...10 .....       @zz_1x4
+
+SQCVTN_dh       11000001 101 10011 111000 ...10 .....       @zz_1x4
+UQCVTN_dh       11000001 101 10011 111000 ...11 .....       @zz_1x4
+SQCVTUN_dh      11000001 111 10011 111000 ...10 .....       @zz_1x4
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index d3841400ee5..094a1e57f3e 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1568,6 +1568,64 @@ void HELPER(sme2_fcvt_n)(void *vd, void *vs, float_status *fpst, uint32_t desc)
     }
 }
 
+#define SQCVT2(NAME, TW, TN, HW, HN, SAT)                       \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch;                                       \
+    size_t oprsz = simd_oprsz(desc), n = oprsz / sizeof(TW);    \
+    TW *s0 = vs, *s1 = vs + sizeof(ARMVectorReg);               \
+    TN *d = vd;                                                 \
+    if (vectors_overlap(vd, 1, vs, 2)) {                        \
+        d = (TN *)&scratch;                                     \
+    }                                                           \
+    for (size_t i = 0; i < n; ++i) {                            \
+        d[HN(i)] = SAT(s0[HW(i)]);                              \
+        d[HN(i + n)] = SAT(s1[HW(i)]);                          \
+    }                                                           \
+    if (d != vd) {                                              \
+        memcpy(vd, d, oprsz);                                   \
+    }                                                           \
+}
+
+SQCVT2(sme2_sqcvt_sh, int32_t, int16_t, H4, H2, do_ssat_h)
+SQCVT2(sme2_uqcvt_sh, uint32_t, uint16_t, H4, H2, do_usat_h)
+SQCVT2(sme2_sqcvtu_sh, int32_t, uint16_t, H4, H2, do_usat_h)
+
+#undef SQCVT2
+
+#define SQCVT4(NAME, TW, TN, HW, HN, SAT)                       \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch;                                       \
+    size_t oprsz = simd_oprsz(desc), n = oprsz / sizeof(TW);    \
+    TW *s0 = vs, *s1 = vs + sizeof(ARMVectorReg);               \
+    TW *s2 = vs + 2 * sizeof(ARMVectorReg);                     \
+    TW *s3 = vs + 3 * sizeof(ARMVectorReg);                     \
+    TN *d = vd;                                                 \
+    if (vectors_overlap(vd, 1, vs, 4)) {                        \
+        d = (TN *)&scratch;                                     \
+    }                                                           \
+    for (size_t i = 0; i < n; ++i) {                            \
+        d[HN(i)] = SAT(s0[HW(i)]);                              \
+        d[HN(i + n)] = SAT(s1[HW(i)]);                          \
+        d[HN(i + 2 * n)] = SAT(s2[HW(i)]);                      \
+        d[HN(i + 3 * n)] = SAT(s3[HW(i)]);                      \
+    }                                                           \
+    if (d != vd) {                                              \
+        memcpy(vd, d, oprsz);                                   \
+    }                                                           \
+}
+
+SQCVT4(sme2_sqcvt_sb, int32_t, int8_t, H4, H2, do_ssat_b)
+SQCVT4(sme2_uqcvt_sb, uint32_t, uint8_t, H4, H2, do_usat_b)
+SQCVT4(sme2_sqcvtu_sb, int32_t, uint8_t, H4, H2, do_usat_b)
+
+SQCVT4(sme2_sqcvt_dh, int64_t, int16_t, H8, H2, do_ssat_h)
+SQCVT4(sme2_uqcvt_dh, uint64_t, uint16_t, H8, H2, do_usat_h)
+SQCVT4(sme2_sqcvtu_dh, int64_t, uint16_t, H8, H2, do_usat_h)
+
+#undef SQCVT4
+
 /* Convert and interleave */
 void HELPER(sme2_bfcvtn)(void *vd, void *vs, float_status *fpst, uint32_t desc)
 {
@@ -1599,6 +1657,64 @@ void HELPER(sme2_fcvtn)(void *vd, void *vs, float_status *fpst, uint32_t desc)
     }
 }
 
+#define SQCVTN2(NAME, TW, TN, HW, HN, SAT)                      \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch;                                       \
+    size_t oprsz = simd_oprsz(desc), n = oprsz / sizeof(TW);    \
+    TW *s0 = vs, *s1 = vs + sizeof(ARMVectorReg);               \
+    TN *d = vd;                                                 \
+    if (vectors_overlap(vd, 1, vs, 2)) {                        \
+        d = (TN *)&scratch;                                     \
+    }                                                           \
+    for (size_t i = 0; i < n; ++i) {                            \
+        d[HN(2 * i + 0)] = SAT(s0[HW(i)]);                      \
+        d[HN(2 * i + 1)] = SAT(s1[HW(i)]);                      \
+    }                                                           \
+    if (d != vd) {                                              \
+        memcpy(vd, d, oprsz);                                   \
+    }                                                           \
+}
+
+SQCVTN2(sme2_sqcvtn_sh, int32_t, int16_t, H4, H2, do_ssat_h)
+SQCVTN2(sme2_uqcvtn_sh, uint32_t, uint16_t, H4, H2, do_usat_h)
+SQCVTN2(sme2_sqcvtun_sh, int32_t, uint16_t, H4, H2, do_usat_h)
+
+#undef SQCVTN2
+
+#define SQCVTN4(NAME, TW, TN, HW, HN, SAT)                      \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch;                                       \
+    size_t oprsz = simd_oprsz(desc), n = oprsz / sizeof(TW);    \
+    TW *s0 = vs, *s1 = vs + sizeof(ARMVectorReg);               \
+    TW *s2 = vs + 2 * sizeof(ARMVectorReg);                     \
+    TW *s3 = vs + 3 * sizeof(ARMVectorReg);                     \
+    TN *d = vd;                                                 \
+    if (vectors_overlap(vd, 1, vs, 4)) {                        \
+        d = (TN *)&scratch;                                     \
+    }                                                           \
+    for (size_t i = 0; i < n; ++i) {                            \
+        d[HN(4 * i + 0)] = SAT(s0[HW(i)]);                      \
+        d[HN(4 * i + 1)] = SAT(s1[HW(i)]);                      \
+        d[HN(4 * i + 2)] = SAT(s2[HW(i)]);                      \
+        d[HN(4 * i + 3)] = SAT(s3[HW(i)]);                      \
+    }                                                           \
+    if (d != vd) {                                              \
+        memcpy(vd, d, oprsz);                                   \
+    }                                                           \
+}
+
+SQCVTN4(sme2_sqcvtn_sb, int32_t, int8_t, H4, H1, do_ssat_b)
+SQCVTN4(sme2_uqcvtn_sb, uint32_t, uint8_t, H4, H1, do_usat_b)
+SQCVTN4(sme2_sqcvtun_sb, int32_t, uint8_t, H4, H1, do_usat_b)
+
+SQCVTN4(sme2_sqcvtn_dh, int64_t, int16_t, H8, H2, do_ssat_h)
+SQCVTN4(sme2_uqcvtn_dh, uint64_t, uint16_t, H8, H2, do_usat_h)
+SQCVTN4(sme2_sqcvtun_dh, int64_t, uint16_t, H8, H2, do_usat_h)
+
+#undef SQCVTN4
+
 /* Expand and convert */
 void HELPER(sme2_fcvt_w)(void *vd, void *vs, float_status *fpst, uint32_t desc)
 {
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 4fbc61ae272..dd1a6668fb5 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1384,3 +1384,38 @@ TRANS_FEAT(FRINTM, aa64_sme2, do_zz_fpst, a, float_round_down,
            FPST_A64, gen_helper_gvec_vrint_rm_s)
 TRANS_FEAT(FRINTA, aa64_sme2, do_zz_fpst, a, float_round_ties_away,
            FPST_A64, gen_helper_gvec_vrint_rm_s)
+
+static bool do_zz(DisasContext *s, arg_zz_n *a, int data,
+                  gen_helper_gvec_2 *fn)
+{
+    if (sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+
+        for (int i = 0, n = a->n; i < n; ++i) {
+            tcg_gen_gvec_2_ool(vec_full_reg_offset(s, a->zd + i),
+                               vec_full_reg_offset(s, a->zn + i),
+                               svl, svl, data, fn);
+        }
+    }
+    return true;
+}
+
+TRANS_FEAT(SQCVT_sh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sqcvt_sh)
+TRANS_FEAT(UQCVT_sh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uqcvt_sh)
+TRANS_FEAT(SQCVTU_sh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sqcvtu_sh)
+
+TRANS_FEAT(SQCVT_sb, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sqcvt_sb)
+TRANS_FEAT(UQCVT_sb, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uqcvt_sb)
+TRANS_FEAT(SQCVTU_sb, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sqcvtu_sb)
+
+TRANS_FEAT(SQCVT_dh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sqcvt_dh)
+TRANS_FEAT(UQCVT_dh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uqcvt_dh)
+TRANS_FEAT(SQCVTU_dh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sqcvtu_dh)
+
+TRANS_FEAT(SQCVTN_sb, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sqcvtn_sb)
+TRANS_FEAT(UQCVTN_sb, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uqcvtn_sb)
+TRANS_FEAT(SQCVTUN_sb, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sqcvtun_sb)
+
+TRANS_FEAT(SQCVTN_dh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sqcvtn_dh)
+TRANS_FEAT(UQCVTN_dh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uqcvtn_dh)
+TRANS_FEAT(SQCVTUN_dh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sqcvtun_dh)
-- 
2.43.0


