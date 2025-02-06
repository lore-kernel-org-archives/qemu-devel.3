Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D93C0219B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg84A-0008Ug-Iy; Thu, 06 Feb 2025 15:01:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83m-0007vq-7b
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:01:19 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83h-0001Ak-Ro
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:01:13 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2f9b91dff71so2092950a91.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 12:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738872059; x=1739476859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qkxX/VEuH0lk4mcloNlmwb8LyjRKWn+RhZVCreY26EE=;
 b=qaimZG1yTk+zrWERt7CZasmrqDYmn9eKFUzlK4+zg/k6JhmxTe8ZqXz7DySx07fXg0
 nrEGU3XAgQEJKne91lJw586T4ocOaVTt5GcgWMZeyGDyOqdOpQ1yLFVlLF7gO7AnRD62
 QWDaZ1Z5fVjYfgvvOsWZsOfEJ2CCll4By8IVwVA/57gKuGIQwLBcXrmQSXQNrwdEA4Z/
 7CuQ97wo5CWK7IkMY6kMmfZlhcaBAdJ6+G7RnXq5ahwR85VWcQi+edTVvkhg7UT7Utep
 UL4+UZnw46AnmKdt2lJsSRA1b8+nzXlA1+JXkclnagu0VmBGJTatrOlT6FsElQe/sVid
 RjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738872059; x=1739476859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qkxX/VEuH0lk4mcloNlmwb8LyjRKWn+RhZVCreY26EE=;
 b=wA9FM5jsk6fYiGZYnEdC8FWWAs8RgrxsZ8Ur+UEbe1YiteLgZDnb101VvVQdmqpP7s
 d9ZiNq4b+/XHIT8M1zSNEi7a7qeKWkbSnl9T/PyGmWYyErYz0JLJoTjM0xdDxsj/TFxv
 vxlyk4Tl4hMOWKbB4DzyS82QLqRkncSRLy1o0MjGpvfG5ORhP5DlBFxwdAclc3EUnRo0
 pymv8H5ioYbHb7+1WMcG9T0abM1f6AhMtFB7ql1R8rigRJ6TT/UqpEDds90IhGCjTzcS
 ZleSCY3z7Gy4BGDccbj/OUKkNiPqj0287L+Y5h9ACbhsh9WY444kvlV2b0Yz4s3JwgwO
 ++0g==
X-Gm-Message-State: AOJu0YzO3zZHHluOfDIbLHaiTIWaoaaj1Yk1wWzlJcGByzgsjbXWF7ba
 YvWedTU3YfkwMxdopIri8i1sWio73az4/DZcLTnxXLoTkagyUQE/v3We/IuvtGrRnaCXzBsx1H8
 S
X-Gm-Gg: ASbGncuFuYT2bjTezw+TWIrl+skSYrYmdA3c2318BTDEm5VFwME2A569dHzlZgi+Atl
 pgdlb987CfmAGt13itClRgwEt/+GvrPL85BPp7D7qbjjlM7KIhir8PThyG+RPQFPce/r4KBG0ac
 4xFrAx/YyZD9kP5gN5MgOZTfb5xdGCvwny2IYCPa16I3RlaQ1t8wmLshdwWa7otp3HcOccgPNGu
 /V2jrCWtUmcETWB6wZ73ybURTh+N5oMrOBJLaP7FbOVvrS1k7XafQOJZAryNCDQDqcwBhunjvjf
 nt1MQZE6J4Z9uJBuaio7uPG2lDrNRxi0soouPHZNY1zQhHE=
X-Google-Smtp-Source: AGHT+IFfr7wlsbDctiNoY+DnprR8Jv5fR1itc20ZK0BTKQ9V1PpvBVZ7nVYqhGZN3bqhNXPOSxAA8A==
X-Received: by 2002:a17:90b:4b8c:b0:2fa:20f4:d27a with SMTP id
 98e67ed59e1d1-2fa23f5330dmr547813a91.7.1738872059081; 
 Thu, 06 Feb 2025 12:00:59 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa09b3ee24sm1808857a91.36.2025.02.06.12.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 12:00:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 57/61] target/arm: Implement SME2 SQRSHR, UQRSHR, SQRSHRN
Date: Thu,  6 Feb 2025 11:57:11 -0800
Message-ID: <20250206195715.2150758-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
 target/arm/tcg/helper-sme.h    | 18 +++++++
 target/arm/tcg/sme_helper.c    | 94 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 29 +++++++++++
 target/arm/tcg/sme.decode      | 33 ++++++++++++
 4 files changed, 174 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 1438a2a5b8..b9e1de63e6 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -263,3 +263,21 @@ DEF_HELPER_FLAGS_3(sme2_uzp4_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_uzp4_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_uzp4_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_uzp4_q, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sme2_sqrshr_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqrshr_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshru_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sme2_sqrshr_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqrshr_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshru_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshr_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqrshr_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshru_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sme2_sqrshrn_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqrshrn_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshrun_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshrn_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqrshrn_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshrun_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index de0fec272d..9a92302b8b 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1590,6 +1590,66 @@ SQCVT4(sme2_sqcvtu_dh, int64_t, uint16_t, H8, H2, do_usat_h)
 
 #undef SQCVT4
 
+#define SQRSHR2(NAME, TW, TN, HW, HN, RSHR, SAT)                \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch __attribute__((uninitialized));        \
+    size_t oprsz = simd_oprsz(desc), n = oprsz / sizeof(TW);    \
+    int shift = simd_data(desc);                                \
+    TW *s0 = vs, *s1 = vs + sizeof(ARMVectorReg);               \
+    TN *d = vd;                                                 \
+    if ((vd - vs) < 2 * sizeof(ARMVectorReg)) {                 \
+        d = (TN *)&scratch;                                     \
+    }                                                           \
+    for (size_t i = 0; i < n; ++i) {                            \
+        d[HN(i)] = SAT(RSHR(s0[HW(i)], shift));                 \
+        d[HN(i) + n] = SAT(RSHR(s1[HW(i)], shift));             \
+    }                                                           \
+    if (d != vd) {                                              \
+        memcpy(vd, d, oprsz);                                   \
+    }                                                           \
+}
+
+SQRSHR2(sme2_sqrshr_sh, int32_t, int16_t, H4, H2, do_srshr, do_ssat_b)
+SQRSHR2(sme2_uqrshr_sh, uint32_t, uint16_t, H4, H2, do_urshr, do_usat_b)
+SQRSHR2(sme2_sqrshru_sh, int32_t, uint16_t, H4, H2, do_srshr, do_usat_b)
+
+#undef SQRSHR2
+
+#define SQRSHR4(NAME, TW, TN, HW, HN, RSHR, SAT)                \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch __attribute__((uninitialized));        \
+    size_t oprsz = simd_oprsz(desc), n = oprsz / sizeof(TW);    \
+    int shift = simd_data(desc);                                \
+    TW *s0 = vs, *s1 = vs + sizeof(ARMVectorReg);               \
+    TW *s2 = vs + 2 * sizeof(ARMVectorReg);                     \
+    TW *s3 = vs + 3 * sizeof(ARMVectorReg);                     \
+    TN *d = vd;                                                 \
+    if ((vd - vs) < 4 * sizeof(ARMVectorReg)) {                 \
+        d = (TN *)&scratch;                                     \
+    }                                                           \
+    for (size_t i = 0; i < n; ++i) {                            \
+        d[HN(i)] = SAT(RSHR(s0[HW(i)], shift));                 \
+        d[HN(i) + n] = SAT(RSHR(s1[HW(i)], shift));             \
+        d[HN(i) + 2 * n] = SAT(RSHR(s2[HW(i)], shift));         \
+        d[HN(i) + 3 * n] = SAT(RSHR(s3[HW(i)], shift));         \
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
@@ -1654,6 +1714,40 @@ SQCVTN4(sme2_sqcvtun_dh, int64_t, uint16_t, H8, H2, do_usat_h)
 
 #undef SQCVTN4
 
+#define SQRSHRN4(NAME, TW, TN, HW, HN, RSHR, SAT)               \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch __attribute__((uninitialized));        \
+    size_t oprsz = simd_oprsz(desc), n = oprsz / sizeof(TW);    \
+    int shift = simd_data(desc);                                \
+    TW *s0 = vs, *s1 = vs + sizeof(ARMVectorReg);               \
+    TW *s2 = vs + 2 * sizeof(ARMVectorReg);                     \
+    TW *s3 = vs + 3 * sizeof(ARMVectorReg);                     \
+    TN *d = vd;                                                 \
+    if ((vd - vs) < 4 * sizeof(ARMVectorReg)) {                 \
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
index 01542e5330..55c3310e9b 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1398,3 +1398,32 @@ static gen_helper_gvec_2 * const uzp4_fns[] = {
     gen_helper_sme2_uzp4_q,
 };
 TRANS_FEAT(UZP_4, aa64_sme2, do_zipuzp_4, a, uzp4_fns)
+
+static bool do_zz_rshr(DisasContext *s, arg_rshr *a, gen_helper_gvec_2 *fn)
+{
+    if (sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        tcg_gen_gvec_2_ool(vec_full_reg_offset(s, a->zd),
+                           vec_full_reg_offset(s, a->zn),
+                           svl, svl, a->shift, fn);
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
+TRANS_FEAT(SQRSHRN_sb, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshrn_sb)
+TRANS_FEAT(SQRSHRN_dh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshrn_dh)
+TRANS_FEAT(UQRSHRN_sb, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_uqrshrn_sb)
+TRANS_FEAT(UQRSHRN_dh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_uqrshrn_dh)
+TRANS_FEAT(SQRSHRUN_sb, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshrun_sb)
+TRANS_FEAT(SQRSHRUN_dh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshrun_dh)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index a43edb625c..b28113a883 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -810,3 +810,36 @@ UZP_4           11000001 esz:2 1 10110 111000 ...00 ... 10   \
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
+SQRSHRN_sb      11000001 011 ..... 110111 ...00 .....       @rshr_sb
+SQRSHRN_dh      11000001 1.1 ..... 110111 ...00 .....       @rshr_dh
+UQRSHRN_sb      11000001 011 ..... 110111 ...01 .....       @rshr_sb
+UQRSHRN_dh      11000001 1.1 ..... 110111 ...01 .....       @rshr_dh
+SQRSHRUN_sb     11000001 011 ..... 110111 ...10 .....       @rshr_sb
+SQRSHRUN_dh     11000001 1.1 ..... 110111 ...10 .....       @rshr_dh
-- 
2.43.0


