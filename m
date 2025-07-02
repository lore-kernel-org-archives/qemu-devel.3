Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D95EC8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwnB-0008Vk-UD; Wed, 02 Jul 2025 08:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjH-0004Hc-DN
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:30 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjA-00024e-BB
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:22 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2ea6dd628a7so3910697fac.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459895; x=1752064695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wz6xzZxhSKloqJDzQ+44S946jMa0r1cEd3Tv4DyvJLs=;
 b=BTZXSwteZupRFYI6eN7R77H1dUoBQPl7HrdL+k6SxrwctAEyMsiLti9FaNFgGtriqw
 TXDcp6x5xaxOpATiv0Z7GYeyfSMgPaqz24UXS/4jmqEXmUMkOKMb7XFHAkgyyNB6DkTK
 Fcb5/ghGQdESAUkxRqxP6SNuvp43pn2o5msfN1ktlFZiabvX9ioq4ohSjoMYNooLeh0n
 HeY0BfIusyPGb7kfnMEJl4z+ueXTMmjUiKnS5svCCDNu9clpsaGZKN8AFSG/uMccN3/L
 sr9V3EI6b1QqhYy5bGnrJHMHbiZLm+F8H9FHEhyXEa7+HsY+EZYHUQ6TOdFLsuaHcNTw
 dvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459895; x=1752064695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wz6xzZxhSKloqJDzQ+44S946jMa0r1cEd3Tv4DyvJLs=;
 b=ZFNdmllnMms8m0TOExnSLjqoqqODuosvHeJbMDrA/HmoICFZ82kwvf6RJdgxmE8SUG
 YACEEsdAg37G9jktxThzW27nyA4rBJ5+YjyCMBkFTzjRAW078bfEA1m7q4uIppH9qEpJ
 Y/bsRHdx/vUXfggmbjtmgBqGamR8ixpTyA8QM+879eo8MHmTEl0MEhhyZvKPXlcZjPRo
 c9U+a+AFcZQWLzXsoNBa2LLd5Q4QFt6F+w6Get6YpcQ64N/dLTPiqFQao9BYMZrsga2a
 ou1jip5SaSWBstEnNgGPrDMqcSW0Oo4G8E/ZBqwQmrRJfYbQGG7+nR3T/9Fj2QvYi+3K
 kMUg==
X-Gm-Message-State: AOJu0Yx662cNXqj7X1UHFZNGmXjp45cI5kkYg8ZN6Xu+r2ijXM8dGoBM
 DhnuNYZvftMN5hzN6AkHHaSrqxGLxA+j/O5MwHDgkhaQbNLkGNE+7p86D0idxMysd2PJD1n1FEH
 +XQD6Ye0=
X-Gm-Gg: ASbGnct/+BzN0GGciwSPmD+OE0h/oq2QX07c6aqupT1EiUu4X9LhoTnhcSkMgFPLVSs
 R4nAPEEv3DWQqlgchTJLK5vokWsV+qbbG1cTrmh/ksuMwMcQ9896Z5wbLzHRvKsLv1FuNqiaClh
 S/9k31+r9/TYy22kJiYcNrWnyXQ6HHndgiREanXJVt34sb+gVjkyGHs6E2Vr9ZvvpqyggDvjCjJ
 2rvFjfQsLnhxgP13cbCg4T+uI0qbiDZHbq59vRwthUjM6ZrMMvIDwbF9jzzy6V/m9vUb56FSBam
 7gPjay1aIYis3cm9d3wWonXOh0VWOppGVARA7O//fEbpXe8arSyCBMpSiKk61DoWvCwL/Q==
X-Google-Smtp-Source: AGHT+IFlaVNVrhu0aP/ncldQR3UNn5fPXasAiUWTm6WTbyvGIHT1NyyrSyli+qwJER+iYcEs07eMAg==
X-Received: by 2002:a05:687c:2f07:b0:2ef:98fc:6f5c with SMTP id
 586e51a60fabf-2f5a8b5a11amr2121726fac.27.1751459893945; 
 Wed, 02 Jul 2025 05:38:13 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 49/97] target/arm: Implement SME2 SQCVT, UQCVT, SQCVTU
Date: Wed,  2 Jul 2025 06:33:22 -0600
Message-ID: <20250702123410.761208-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  20 ++++++
 target/arm/tcg/sme_helper.c    | 116 +++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c |  35 ++++++++++
 target/arm/tcg/sme.decode      |  22 +++++++
 4 files changed, 193 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 6314ad7e01..792b993695 100644
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
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index d69d57c4cb..906d369d37 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1561,6 +1561,64 @@ void HELPER(sme2_fcvt_n)(void *vd, void *vs, float_status *fpst, uint32_t desc)
     }
 }
 
+#define SQCVT2(NAME, TW, TN, HW, HN, SAT)                       \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch;                                       \
+    size_t oprsz = simd_oprsz(desc), n = oprsz / sizeof(TW);    \
+    TW *s0 = vs, *s1 = vs + sizeof(ARMVectorReg);               \
+    TN *d = vd;                                                 \
+    if ((vd - vs) < 2 * sizeof(ARMVectorReg)) {                 \
+        d = (TN *)&scratch;                                     \
+    }                                                           \
+    for (size_t i = 0; i < n; ++i) {                            \
+        d[HN(i)] = SAT(s0[HW(i)]);                              \
+        d[HN(i) + n] = SAT(s1[HW(i)]);                          \
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
+    if ((vd - vs) < 4 * sizeof(ARMVectorReg)) {                 \
+        d = (TN *)&scratch;                                     \
+    }                                                           \
+    for (size_t i = 0; i < n; ++i) {                            \
+        d[HN(i)] = SAT(s0[HW(i)]);                              \
+        d[HN(i) + n] = SAT(s1[HW(i)]);                          \
+        d[HN(i) + 2 * n] = SAT(s2[HW(i)]);                      \
+        d[HN(i) + 3 * n] = SAT(s3[HW(i)]);                      \
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
@@ -1592,6 +1650,64 @@ void HELPER(sme2_fcvtn)(void *vd, void *vs, float_status *fpst, uint32_t desc)
     }
 }
 
+#define SQCVTN2(NAME, TW, TN, HW, HN, SAT)                      \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch;                                       \
+    size_t oprsz = simd_oprsz(desc), n = oprsz / sizeof(TW);    \
+    TW *s0 = vs, *s1 = vs + sizeof(ARMVectorReg);               \
+    TN *d = vd;                                                 \
+    if ((vd - vs) < 2 * sizeof(ARMVectorReg)) {                 \
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
+    if ((vd - vs) < 4 * sizeof(ARMVectorReg)) {                 \
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
index 4fbc61ae27..dd1a6668fb 100644
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
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 9cc25622d4..e005f6e6ed 100644
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
-- 
2.43.0


