Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4884C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjFS-0004Yx-Ep; Fri, 04 Jul 2025 12:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEx-0001qE-QP
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:20 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEv-0006jC-C4
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:19 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-453608ed113so12311695e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646376; x=1752251176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8iaggyBiQQEYpRRob1rPyeF/le1RxN9aa/NPLvUojUQ=;
 b=EUmGe/LsOiB6bH++m30KV7O9mXcAAYIB/ZY5I6Eg7YimP+L6j7EVXMI43bcx8L5Ib5
 rGpXq5xg3gapA7Ce1bhqaaksiHxFTS0EwptASsJcPhT4dbU4K1Z+DB5WpsKa3PNiabkX
 iwgcQ56Qe31aXGfy8t2LEzNINn8ErH5EH09U6KgqKiePy0InIGeyE4DB6EnND831xioT
 5ESefHmHhZSOR8Te0wJYTsIygVjlpRy5wzKEGlX9bmAbxBGSJ3GiF6PgC67x57rJW17S
 L32JErXf7syV2K5fhslnn31RcwJ7E+kzTZrpBayZvVRLBOhi/8npqKReYMuxEjxI9w9z
 HuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646376; x=1752251176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8iaggyBiQQEYpRRob1rPyeF/le1RxN9aa/NPLvUojUQ=;
 b=UgIcB3NghhVTSNgWrI0ie/tIa7XWxuwwAX/6HEWHkIsxFF40W8U5a3PN2aQiKvEo8x
 9mdlXO+rx4VNVfI+ycmtOnW3T/gWxZdFnfaWx2iZ7Ekm5LIasMBvpqWQt1dB5oD2PLLk
 crN28JwlPXv+607lWHh/nCE2/fksb2hZLf0/cayrEQZGuM9ux3Tl1RqnAGilB8vzEw/s
 g/gB7CqiX6Itk//sg+hmrQ/1hedDhyMHviWgZ60sYuT48reYUtTST4eJ6h6zqjPAXIqe
 71llg6RPIZZU1DXqxkhrtR49TBdaQkKQ0ZCixYIx6Uk3JHQxKwEr4b1wILE3G0wFC0L8
 JVUw==
X-Gm-Message-State: AOJu0YxPQXZ83rjxpmc5kdWd/PgzmKmH/v+okO+Qw7h0vRAwENgub5zx
 8GBJIr+DLqAp8u7jVcLpfSlkWF7i2ZvE1GgRxiR5V5x9myI4YinY02TLnVcWzU3oOTh8B5+z/0x
 rYXJq
X-Gm-Gg: ASbGncsd0uZ/LA39uf8AL5XaZJ42xvIhBMxIBePM1k9z1VkIQzxbdMESFR7qiTG/fro
 w2N+P9QItBcDa8To8MnM1rXibx+/SLjpSFb20whA3DYn+Zfyf6+hRKfbKX5KZmjVnND94QxeQRl
 HhzTT30ydT9fdINAV0jnj2UxoYA7QQoxU1C3rppDQepGb20v7OKNkE6HtgmSRdCnRCGjqrS9y8g
 NGOlETcTBkrgF3kV/5ywj/j7F9924UzL4zdPCVsF17RscF1pUpVd1n21WsImXU04nXAtmAaWNTE
 Dsu524iuF6VWStBXZ/a4VDwJuX06HjBmP1+It6s46waFT6aIwNXDcPfh1CPdy3nrUr+N
X-Google-Smtp-Source: AGHT+IGR0/Rpk/o4q1DYX61KuSqcdev0RrpbnuN+D99CO7FUhXF8q8AB8ARb+T7/RNiyzRx2Q74tCA==
X-Received: by 2002:a05:6000:4908:b0:3a5:2ec5:35a9 with SMTP id
 ffacd0b85a97d-3b4964f4e01mr2986457f8f.3.1751646375898; 
 Fri, 04 Jul 2025 09:26:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 076/119] target/arm: Implement SME2 SQRSHR, UQRSHR, SQRSHRN
Date: Fri,  4 Jul 2025 17:24:16 +0100
Message-ID: <20250704162501.249138-77-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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
Message-id: 20250704142112.1018902-65-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  20 ++++++
 target/arm/tcg/sme.decode      |  37 ++++++++++
 target/arm/tcg/sme_helper.c    | 120 +++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c |  33 +++++++++
 4 files changed, 210 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 7e21f1095a2..97428bcd6b8 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -266,3 +266,23 @@ DEF_HELPER_FLAGS_3(sme2_uzp4_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_uzp4_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_uzp4_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_uzp4_q, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sme2_sqrshr_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqrshr_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshru_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshr_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqrshr_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshru_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshr_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqrshr_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshru_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sme2_sqrshrn_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqrshrn_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshrun_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshrn_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqrshrn_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshrun_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshrn_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqrshrn_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshrun_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 81783b4705c..05d513efbab 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -811,3 +811,40 @@ UZP_4           11000001 esz:2 1 10110 111000 ...00 ... 10   \
                 &zz_e zd=%zd_ax4 zn=%zn_ax4
 UZP_4           11000001 001     10111 111000 ...00 ... 10   \
                 &zz_e esz=4 zd=%zd_ax4 zn=%zn_ax4
+
+### SME2 Multi-vector SVE Constructive Binary
+
+&rshr           zd zn shift
+
+%rshr_sh_shift  16:4 !function=rsub_16
+%rshr_sb_shift  16:5 !function=rsub_32
+%rshr_dh_shift  22:1 16:5 !function=rsub_64
+
+@rshr_sh        ........ .... .... ...... ..... zd:5        \
+                &rshr zn=%zn_ax2 shift=%rshr_sh_shift
+@rshr_sb        ........ ... ..... ...... ..... zd:5        \
+                &rshr zn=%zn_ax4 shift=%rshr_sb_shift
+@rshr_dh        ........ ... ..... ...... ..... zd:5        \
+                &rshr zn=%zn_ax4 shift=%rshr_dh_shift
+
+SQRSHR_sh       11000001 1110 .... 110101 ....0 .....       @rshr_sh
+UQRSHR_sh       11000001 1110 .... 110101 ....1 .....       @rshr_sh
+SQRSHRU_sh      11000001 1111 .... 110101 ....0 .....       @rshr_sh
+
+SQRSHR_sb       11000001 011 ..... 110110 ...00 .....       @rshr_sb
+SQRSHR_dh       11000001 1.1 ..... 110110 ...00 .....       @rshr_dh
+UQRSHR_sb       11000001 011 ..... 110110 ...01 .....       @rshr_sb
+UQRSHR_dh       11000001 1.1 ..... 110110 ...01 .....       @rshr_dh
+SQRSHRU_sb      11000001 011 ..... 110110 ...10 .....       @rshr_sb
+SQRSHRU_dh      11000001 1.1 ..... 110110 ...10 .....       @rshr_dh
+
+SQRSHRN_sh      01000101 1011 .... 001010 ....0 .....       @rshr_sh
+UQRSHRN_sh      01000101 1011 .... 001110 ....0 .....       @rshr_sh
+SQRSHRUN_sh     01000101 1011 .... 000010 ....0 .....       @rshr_sh
+
+SQRSHRN_sb      11000001 011 ..... 110111 ...00 .....       @rshr_sb
+SQRSHRN_dh      11000001 1.1 ..... 110111 ...00 .....       @rshr_dh
+UQRSHRN_sb      11000001 011 ..... 110111 ...01 .....       @rshr_sb
+UQRSHRN_dh      11000001 1.1 ..... 110111 ...01 .....       @rshr_dh
+SQRSHRUN_sb     11000001 011 ..... 110111 ...10 .....       @rshr_sb
+SQRSHRUN_dh     11000001 1.1 ..... 110111 ...10 .....       @rshr_dh
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 4a05fff5fe2..2e95fe38cdd 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1626,6 +1626,66 @@ SQCVT4(sme2_sqcvtu_dh, int64_t, uint16_t, H8, H2, do_usat_h)
 
 #undef SQCVT4
 
+#define SQRSHR2(NAME, TW, TN, HW, HN, RSHR, SAT)                \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch;                                       \
+    size_t oprsz = simd_oprsz(desc), n = oprsz / sizeof(TW);    \
+    int shift = simd_data(desc);                                \
+    TW *s0 = vs, *s1 = vs + sizeof(ARMVectorReg);               \
+    TN *d = vd;                                                 \
+    if (vectors_overlap(vd, 1, vs, 2)) {                        \
+        d = (TN *)&scratch;                                     \
+    }                                                           \
+    for (size_t i = 0; i < n; ++i) {                            \
+        d[HN(i)] = SAT(RSHR(s0[HW(i)], shift));                 \
+        d[HN(i + n)] = SAT(RSHR(s1[HW(i)], shift));             \
+    }                                                           \
+    if (d != vd) {                                              \
+        memcpy(vd, d, oprsz);                                   \
+    }                                                           \
+}
+
+SQRSHR2(sme2_sqrshr_sh, int32_t, int16_t, H4, H2, do_srshr, do_ssat_h)
+SQRSHR2(sme2_uqrshr_sh, uint32_t, uint16_t, H4, H2, do_urshr, do_usat_h)
+SQRSHR2(sme2_sqrshru_sh, int32_t, uint16_t, H4, H2, do_srshr, do_usat_h)
+
+#undef SQRSHR2
+
+#define SQRSHR4(NAME, TW, TN, HW, HN, RSHR, SAT)                \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch;                                       \
+    size_t oprsz = simd_oprsz(desc), n = oprsz / sizeof(TW);    \
+    int shift = simd_data(desc);                                \
+    TW *s0 = vs, *s1 = vs + sizeof(ARMVectorReg);               \
+    TW *s2 = vs + 2 * sizeof(ARMVectorReg);                     \
+    TW *s3 = vs + 3 * sizeof(ARMVectorReg);                     \
+    TN *d = vd;                                                 \
+    if (vectors_overlap(vd, 1, vs, 4)) {                        \
+        d = (TN *)&scratch;                                     \
+    }                                                           \
+    for (size_t i = 0; i < n; ++i) {                            \
+        d[HN(i)] = SAT(RSHR(s0[HW(i)], shift));                 \
+        d[HN(i + n)] = SAT(RSHR(s1[HW(i)], shift));             \
+        d[HN(i + 2 * n)] = SAT(RSHR(s2[HW(i)], shift));         \
+        d[HN(i + 3 * n)] = SAT(RSHR(s3[HW(i)], shift));         \
+    }                                                           \
+    if (d != vd) {                                              \
+        memcpy(vd, d, oprsz);                                   \
+    }                                                           \
+}
+
+SQRSHR4(sme2_sqrshr_sb, int32_t, int8_t, H4, H2, do_srshr, do_ssat_b)
+SQRSHR4(sme2_uqrshr_sb, uint32_t, uint8_t, H4, H2, do_urshr, do_usat_b)
+SQRSHR4(sme2_sqrshru_sb, int32_t, uint8_t, H4, H2, do_srshr, do_usat_b)
+
+SQRSHR4(sme2_sqrshr_dh, int64_t, int16_t, H8, H2, do_srshr, do_ssat_h)
+SQRSHR4(sme2_uqrshr_dh, uint64_t, uint16_t, H8, H2, do_urshr, do_usat_h)
+SQRSHR4(sme2_sqrshru_dh, int64_t, uint16_t, H8, H2, do_srshr, do_usat_h)
+
+#undef SQRSHR4
+
 /* Convert and interleave */
 void HELPER(sme2_bfcvtn)(void *vd, void *vs, float_status *fpst, uint32_t desc)
 {
@@ -1715,6 +1775,66 @@ SQCVTN4(sme2_sqcvtun_dh, int64_t, uint16_t, H8, H2, do_usat_h)
 
 #undef SQCVTN4
 
+#define SQRSHRN2(NAME, TW, TN, HW, HN, RSHR, SAT)               \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch;                                       \
+    size_t oprsz = simd_oprsz(desc), n = oprsz / sizeof(TW);    \
+    int shift = simd_data(desc);                                \
+    TW *s0 = vs, *s1 = vs + sizeof(ARMVectorReg);               \
+    TN *d = vd;                                                 \
+    if (vectors_overlap(vd, 1, vs, 2)) {                        \
+        d = (TN *)&scratch;                                     \
+    }                                                           \
+    for (size_t i = 0; i < n; ++i) {                            \
+        d[HN(2 * i + 0)] = SAT(RSHR(s0[HW(i)], shift));         \
+        d[HN(2 * i + 1)] = SAT(RSHR(s1[HW(i)], shift));         \
+    }                                                           \
+    if (d != vd) {                                              \
+        memcpy(vd, d, oprsz);                                   \
+    }                                                           \
+}
+
+SQRSHRN2(sme2_sqrshrn_sh, int32_t, int16_t, H4, H2, do_srshr, do_ssat_h)
+SQRSHRN2(sme2_uqrshrn_sh, uint32_t, uint16_t, H4, H2, do_urshr, do_usat_h)
+SQRSHRN2(sme2_sqrshrun_sh, int32_t, uint16_t, H4, H2, do_srshr, do_usat_h)
+
+#undef SQRSHRN2
+
+#define SQRSHRN4(NAME, TW, TN, HW, HN, RSHR, SAT)               \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch;                                       \
+    size_t oprsz = simd_oprsz(desc), n = oprsz / sizeof(TW);    \
+    int shift = simd_data(desc);                                \
+    TW *s0 = vs, *s1 = vs + sizeof(ARMVectorReg);               \
+    TW *s2 = vs + 2 * sizeof(ARMVectorReg);                     \
+    TW *s3 = vs + 3 * sizeof(ARMVectorReg);                     \
+    TN *d = vd;                                                 \
+    if (vectors_overlap(vd, 1, vs, 4)) {                        \
+        d = (TN *)&scratch;                                     \
+    }                                                           \
+    for (size_t i = 0; i < n; ++i) {                            \
+        d[HN(4 * i + 0)] = SAT(RSHR(s0[HW(i)], shift));         \
+        d[HN(4 * i + 1)] = SAT(RSHR(s1[HW(i)], shift));         \
+        d[HN(4 * i + 2)] = SAT(RSHR(s2[HW(i)], shift));         \
+        d[HN(4 * i + 3)] = SAT(RSHR(s3[HW(i)], shift));         \
+    }                                                           \
+    if (d != vd) {                                              \
+        memcpy(vd, d, oprsz);                                   \
+    }                                                           \
+}
+
+SQRSHRN4(sme2_sqrshrn_sb, int32_t, int8_t, H4, H1, do_srshr, do_ssat_b)
+SQRSHRN4(sme2_uqrshrn_sb, uint32_t, uint8_t, H4, H1, do_urshr, do_usat_b)
+SQRSHRN4(sme2_sqrshrun_sb, int32_t, uint8_t, H4, H1, do_srshr, do_usat_b)
+
+SQRSHRN4(sme2_sqrshrn_dh, int64_t, int16_t, H8, H2, do_srshr, do_ssat_h)
+SQRSHRN4(sme2_uqrshrn_dh, uint64_t, uint16_t, H8, H2, do_urshr, do_usat_h)
+SQRSHRN4(sme2_sqrshrun_dh, int64_t, uint16_t, H8, H2, do_srshr, do_usat_h)
+
+#undef SQRSHRN4
+
 /* Expand and convert */
 void HELPER(sme2_fcvt_w)(void *vd, void *vs, float_status *fpst, uint32_t desc)
 {
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index de9545ee6d9..d413efd20e7 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1474,3 +1474,36 @@ static gen_helper_gvec_2 * const uzp4_fns[] = {
     gen_helper_sme2_uzp4_q,
 };
 TRANS_FEAT(UZP_4, aa64_sme2, do_zipuzp_4, a, uzp4_fns)
+
+static bool do_zz_rshr(DisasContext *s, arg_rshr *a, gen_helper_gvec_2 *fn)
+{
+    if (sve_access_check(s)) {
+        int vl = vec_full_reg_size(s);
+        tcg_gen_gvec_2_ool(vec_full_reg_offset(s, a->zd),
+                           vec_full_reg_offset(s, a->zn),
+                           vl, vl, a->shift, fn);
+    }
+    return true;
+}
+
+TRANS_FEAT(SQRSHR_sh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshr_sh)
+TRANS_FEAT(UQRSHR_sh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_uqrshr_sh)
+TRANS_FEAT(SQRSHRU_sh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshru_sh)
+
+TRANS_FEAT(SQRSHR_sb, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshr_sb)
+TRANS_FEAT(SQRSHR_dh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshr_dh)
+TRANS_FEAT(UQRSHR_sb, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_uqrshr_sb)
+TRANS_FEAT(UQRSHR_dh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_uqrshr_dh)
+TRANS_FEAT(SQRSHRU_sb, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshru_sb)
+TRANS_FEAT(SQRSHRU_dh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshru_dh)
+
+TRANS_FEAT(SQRSHRN_sh, aa64_sme2_or_sve2p1, do_zz_rshr, a, gen_helper_sme2_sqrshrn_sh)
+TRANS_FEAT(UQRSHRN_sh, aa64_sme2_or_sve2p1, do_zz_rshr, a, gen_helper_sme2_uqrshrn_sh)
+TRANS_FEAT(SQRSHRUN_sh, aa64_sme2_or_sve2p1, do_zz_rshr, a, gen_helper_sme2_sqrshrun_sh)
+
+TRANS_FEAT(SQRSHRN_sb, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshrn_sb)
+TRANS_FEAT(SQRSHRN_dh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshrn_dh)
+TRANS_FEAT(UQRSHRN_sb, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_uqrshrn_sb)
+TRANS_FEAT(UQRSHRN_dh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_uqrshrn_dh)
+TRANS_FEAT(SQRSHRUN_sb, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshrun_sb)
+TRANS_FEAT(SQRSHRUN_dh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshrun_dh)
-- 
2.43.0


