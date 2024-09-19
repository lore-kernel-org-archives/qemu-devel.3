Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AEDCDD57B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwm-0006JO-1a; Thu, 19 Sep 2024 09:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwV-0005N8-8Z
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:32 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwQ-00013l-Mm
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:29 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42cb8dac900so7634615e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751483; x=1727356283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cTwcqBrt3QmM2OEYUAdbYAQf7QkGQA7HzVCPapnp4q4=;
 b=ix8NYpr9wuRVC2YFIwpSglvovbDrmR2on+SSv2H8hqPg+Fae/KzAJJ6GR2yEwQoFmN
 XKZRh+jv4WVUbyMOxWNllHLEcRDzSHV25Fvd7EuYO5N0jNzhBi+5zFB/XQb6p3Hq6guh
 xJeNgu901KbWvMu3rKr1u4OXGGXC4PaItQEVuLy4SOW4oKvX2cNUdQoAA4aBGV9Mo7xB
 jeQb8fvqjD/RwVcAeRmNuhd8/1s81Xh419HLEiX7ISHRxIIVOnhd/msFz67wt9SE3erq
 VyNw1woqCAEGm+tqGTeCw8pgPXCW+0XZERRgXriN42OZ7/KXJOX92CTQ10K1+919mh81
 yMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751483; x=1727356283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cTwcqBrt3QmM2OEYUAdbYAQf7QkGQA7HzVCPapnp4q4=;
 b=Hp/tKUa/oZe0oIqb7Q/PseGiOYaOIJRPI11PtiZO7ibMWjgtIt7Vk2ZVlUJaxlFpZ5
 4LO4Rop+gEXVTgGGRstgNttQQQ3srjwpn67hDhDRz4ylm8ZZ/JvJgEkw/jvsCG2Oq8TB
 imjkdjTQkFghm9DjL0jfw0Id4UIAjmRQZxIYB2nQ/H6Di3iAYfzov9592so9x8jImd99
 FEiXaZhjlXE93P++MbuL7D1iydxjj38fI2ITrFAKHLVUCRGxvBTt4LNLoOnZfumwaFtW
 DpKgG8/V7o0ZyTQIgwRlRY2N9/2yYJaBm7ZCKjBjG5SVjFKGwqT9fXyQ0X6dLunxMLdd
 OBBw==
X-Gm-Message-State: AOJu0YyqlD4e+3/O6OvTe/4TclDd2WH9Oj/uXW9UjHqJD8obSwJNdYRh
 2dLPua95oLSCZQnwg82WRgmNhdyYhdeXgvYYq6il6LB1h7SPkK/z/+NHb8Ztk5YOasv5hbO+UCK
 f
X-Google-Smtp-Source: AGHT+IG1S6nEQRW3D1NEUJP+K1Zi+HaeHYu6cgy0l4MIKbm2L/mGkFR/lxnnnV1MzB7f+E3z0zc11g==
X-Received: by 2002:a05:600c:3514:b0:42c:df67:1d35 with SMTP id
 5b1f17b1804b1-42cdf671f9emr199227395e9.1.1726751482611; 
 Thu, 19 Sep 2024 06:11:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/38] target/arm: Convert VQSHL, VQSHLU to gvec
Date: Thu, 19 Sep 2024 14:10:53 +0100
Message-Id: <20240919131106.3362543-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240912024114.1097832-26-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h             |  12 ++++
 target/arm/tcg/translate.h      |   7 ++
 target/arm/tcg/neon-dp.decode   |   6 +-
 target/arm/tcg/gengvec.c        |  36 +++++++++++
 target/arm/tcg/neon_helper.c    |  33 ++++++++++
 target/arm/tcg/translate-neon.c | 110 +-------------------------------
 6 files changed, 94 insertions(+), 110 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index b463be38c52..b40589d329f 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -324,6 +324,18 @@ DEF_HELPER_FLAGS_5(neon_uqrshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32
 DEF_HELPER_FLAGS_5(neon_uqrshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(neon_uqrshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(neon_uqrshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(neon_sqshli_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(neon_sqshli_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(neon_sqshli_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(neon_sqshli_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(neon_uqshli_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(neon_uqshli_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(neon_uqshli_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(neon_uqshli_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(neon_sqshlui_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(neon_sqshlui_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(neon_sqshlui_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(neon_sqshlui_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(gvec_srshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_srshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 45990ae2928..7721c627e9d 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -471,6 +471,13 @@ void gen_neon_sqrshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
 void gen_neon_uqrshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                      uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 
+void gen_neon_sqshli(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                     int64_t c, uint32_t opr_sz, uint32_t max_sz);
+void gen_neon_uqshli(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                     int64_t c, uint32_t opr_sz, uint32_t max_sz);
+void gen_neon_sqshlui(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                      int64_t c, uint32_t opr_sz, uint32_t max_sz);
+
 void gen_gvec_shadd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                     uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 void gen_gvec_uhadd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
diff --git a/target/arm/tcg/neon-dp.decode b/target/arm/tcg/neon-dp.decode
index 788578c8fa1..e883c6ab585 100644
--- a/target/arm/tcg/neon-dp.decode
+++ b/target/arm/tcg/neon-dp.decode
@@ -291,17 +291,17 @@ VSLI_2sh         1111 001 1 1 . ...... .... 0101 . . . 1 .... @2reg_shl_s
 VSLI_2sh         1111 001 1 1 . ...... .... 0101 . . . 1 .... @2reg_shl_h
 VSLI_2sh         1111 001 1 1 . ...... .... 0101 . . . 1 .... @2reg_shl_b
 
-VQSHLU_64_2sh    1111 001 1 1 . ...... .... 0110 . . . 1 .... @2reg_shl_d
+VQSHLU_2sh       1111 001 1 1 . ...... .... 0110 . . . 1 .... @2reg_shl_d
 VQSHLU_2sh       1111 001 1 1 . ...... .... 0110 . . . 1 .... @2reg_shl_s
 VQSHLU_2sh       1111 001 1 1 . ...... .... 0110 . . . 1 .... @2reg_shl_h
 VQSHLU_2sh       1111 001 1 1 . ...... .... 0110 . . . 1 .... @2reg_shl_b
 
-VQSHL_S_64_2sh   1111 001 0 1 . ...... .... 0111 . . . 1 .... @2reg_shl_d
+VQSHL_S_2sh      1111 001 0 1 . ...... .... 0111 . . . 1 .... @2reg_shl_d
 VQSHL_S_2sh      1111 001 0 1 . ...... .... 0111 . . . 1 .... @2reg_shl_s
 VQSHL_S_2sh      1111 001 0 1 . ...... .... 0111 . . . 1 .... @2reg_shl_h
 VQSHL_S_2sh      1111 001 0 1 . ...... .... 0111 . . . 1 .... @2reg_shl_b
 
-VQSHL_U_64_2sh   1111 001 1 1 . ...... .... 0111 . . . 1 .... @2reg_shl_d
+VQSHL_U_2sh      1111 001 1 1 . ...... .... 0111 . . . 1 .... @2reg_shl_d
 VQSHL_U_2sh      1111 001 1 1 . ...... .... 0111 . . . 1 .... @2reg_shl_s
 VQSHL_U_2sh      1111 001 1 1 . ...... .... 0111 . . . 1 .... @2reg_shl_h
 VQSHL_U_2sh      1111 001 1 1 . ...... .... 0111 . . . 1 .... @2reg_shl_b
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 3abdc572022..f652520b652 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -1313,6 +1313,42 @@ void gen_neon_uqrshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                        opr_sz, max_sz, 0, fns[vece]);
 }
 
+void gen_neon_sqshli(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                     int64_t c, uint32_t opr_sz, uint32_t max_sz)
+{
+    static gen_helper_gvec_2_ptr * const fns[] = {
+        gen_helper_neon_sqshli_b, gen_helper_neon_sqshli_h,
+        gen_helper_neon_sqshli_s, gen_helper_neon_sqshli_d,
+    };
+    tcg_debug_assert(vece <= MO_64);
+    tcg_debug_assert(c >= 0 && c <= (8 << vece));
+    tcg_gen_gvec_2_ptr(rd_ofs, rn_ofs, tcg_env, opr_sz, max_sz, c, fns[vece]);
+}
+
+void gen_neon_uqshli(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                     int64_t c, uint32_t opr_sz, uint32_t max_sz)
+{
+    static gen_helper_gvec_2_ptr * const fns[] = {
+        gen_helper_neon_uqshli_b, gen_helper_neon_uqshli_h,
+        gen_helper_neon_uqshli_s, gen_helper_neon_uqshli_d,
+    };
+    tcg_debug_assert(vece <= MO_64);
+    tcg_debug_assert(c >= 0 && c <= (8 << vece));
+    tcg_gen_gvec_2_ptr(rd_ofs, rn_ofs, tcg_env, opr_sz, max_sz, c, fns[vece]);
+}
+
+void gen_neon_sqshlui(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                      int64_t c, uint32_t opr_sz, uint32_t max_sz)
+{
+    static gen_helper_gvec_2_ptr * const fns[] = {
+        gen_helper_neon_sqshlui_b, gen_helper_neon_sqshlui_h,
+        gen_helper_neon_sqshlui_s, gen_helper_neon_sqshlui_d,
+    };
+    tcg_debug_assert(vece <= MO_64);
+    tcg_debug_assert(c >= 0 && c <= (8 << vece));
+    tcg_gen_gvec_2_ptr(rd_ofs, rn_ofs, tcg_env, opr_sz, max_sz, c, fns[vece]);
+}
+
 void gen_uqadd_bhs(TCGv_i64 res, TCGv_i64 qc, TCGv_i64 a, TCGv_i64 b, MemOp esz)
 {
     uint64_t max = MAKE_64BIT_MASK(0, 8 << esz);
diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index 082bfd88adf..739e16e4411 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -141,6 +141,19 @@ void HELPER(name)(void *vd, void *vn, void *vm, void *venv, uint32_t desc) \
     clear_tail(d, opr_sz, simd_maxsz(desc));                    \
 }
 
+#define NEON_GVEC_VOP2i_ENV(name, vtype) \
+void HELPER(name)(void *vd, void *vn, void *venv, uint32_t desc) \
+{                                                               \
+    intptr_t i, opr_sz = simd_oprsz(desc);                      \
+    int imm = simd_data(desc);                                  \
+    vtype *d = vd, *n = vn;                                     \
+    CPUARMState *env = venv;                                    \
+    for (i = 0; i < opr_sz / sizeof(vtype); i++) {              \
+        NEON_FN(d[i], n[i], imm);                               \
+    }                                                           \
+    clear_tail(d, opr_sz, simd_maxsz(desc));                    \
+}
+
 /* Pairwise operations.  */
 /* For 32-bit elements each segment only contains a single element, so
    the elementwise and pairwise operations are the same.  */
@@ -271,22 +284,26 @@ uint64_t HELPER(neon_rshl_u64)(uint64_t val, uint64_t shift)
     (dest = do_uqrshl_bhs(src1, (int8_t)src2, 8, false, env->vfp.qc))
 NEON_VOP_ENV(qshl_u8, neon_u8, 4)
 NEON_GVEC_VOP2_ENV(neon_uqshl_b, uint8_t)
+NEON_GVEC_VOP2i_ENV(neon_uqshli_b, uint8_t)
 #undef NEON_FN
 
 #define NEON_FN(dest, src1, src2) \
     (dest = do_uqrshl_bhs(src1, (int8_t)src2, 16, false, env->vfp.qc))
 NEON_VOP_ENV(qshl_u16, neon_u16, 2)
 NEON_GVEC_VOP2_ENV(neon_uqshl_h, uint16_t)
+NEON_GVEC_VOP2i_ENV(neon_uqshli_h, uint16_t)
 #undef NEON_FN
 
 #define NEON_FN(dest, src1, src2) \
     (dest = do_uqrshl_bhs(src1, (int8_t)src2, 32, false, env->vfp.qc))
 NEON_GVEC_VOP2_ENV(neon_uqshl_s, uint32_t)
+NEON_GVEC_VOP2i_ENV(neon_uqshli_s, uint32_t)
 #undef NEON_FN
 
 #define NEON_FN(dest, src1, src2) \
     (dest = do_uqrshl_d(src1, (int8_t)src2, false, env->vfp.qc))
 NEON_GVEC_VOP2_ENV(neon_uqshl_d, uint64_t)
+NEON_GVEC_VOP2i_ENV(neon_uqshli_d, uint64_t)
 #undef NEON_FN
 
 uint32_t HELPER(neon_qshl_u32)(CPUARMState *env, uint32_t val, uint32_t shift)
@@ -303,22 +320,26 @@ uint64_t HELPER(neon_qshl_u64)(CPUARMState *env, uint64_t val, uint64_t shift)
     (dest = do_sqrshl_bhs(src1, (int8_t)src2, 8, false, env->vfp.qc))
 NEON_VOP_ENV(qshl_s8, neon_s8, 4)
 NEON_GVEC_VOP2_ENV(neon_sqshl_b, int8_t)
+NEON_GVEC_VOP2i_ENV(neon_sqshli_b, int8_t)
 #undef NEON_FN
 
 #define NEON_FN(dest, src1, src2) \
     (dest = do_sqrshl_bhs(src1, (int8_t)src2, 16, false, env->vfp.qc))
 NEON_VOP_ENV(qshl_s16, neon_s16, 2)
 NEON_GVEC_VOP2_ENV(neon_sqshl_h, int16_t)
+NEON_GVEC_VOP2i_ENV(neon_sqshli_h, int16_t)
 #undef NEON_FN
 
 #define NEON_FN(dest, src1, src2) \
     (dest = do_sqrshl_bhs(src1, (int8_t)src2, 32, false, env->vfp.qc))
 NEON_GVEC_VOP2_ENV(neon_sqshl_s, int32_t)
+NEON_GVEC_VOP2i_ENV(neon_sqshli_s, int32_t)
 #undef NEON_FN
 
 #define NEON_FN(dest, src1, src2) \
     (dest = do_sqrshl_d(src1, (int8_t)src2, false, env->vfp.qc))
 NEON_GVEC_VOP2_ENV(neon_sqshl_d, int64_t)
+NEON_GVEC_VOP2i_ENV(neon_sqshli_d, int64_t)
 #undef NEON_FN
 
 uint32_t HELPER(neon_qshl_s32)(CPUARMState *env, uint32_t val, uint32_t shift)
@@ -334,11 +355,13 @@ uint64_t HELPER(neon_qshl_s64)(CPUARMState *env, uint64_t val, uint64_t shift)
 #define NEON_FN(dest, src1, src2) \
     (dest = do_suqrshl_bhs(src1, (int8_t)src2, 8, false, env->vfp.qc))
 NEON_VOP_ENV(qshlu_s8, neon_s8, 4)
+NEON_GVEC_VOP2i_ENV(neon_sqshlui_b, int8_t)
 #undef NEON_FN
 
 #define NEON_FN(dest, src1, src2) \
     (dest = do_suqrshl_bhs(src1, (int8_t)src2, 16, false, env->vfp.qc))
 NEON_VOP_ENV(qshlu_s16, neon_s16, 2)
+NEON_GVEC_VOP2i_ENV(neon_sqshlui_h, int16_t)
 #undef NEON_FN
 
 uint32_t HELPER(neon_qshlu_s32)(CPUARMState *env, uint32_t val, uint32_t shift)
@@ -351,6 +374,16 @@ uint64_t HELPER(neon_qshlu_s64)(CPUARMState *env, uint64_t val, uint64_t shift)
     return do_suqrshl_d(val, (int8_t)shift, false, env->vfp.qc);
 }
 
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_suqrshl_bhs(src1, (int8_t)src2, 32, false, env->vfp.qc))
+NEON_GVEC_VOP2i_ENV(neon_sqshlui_s, int32_t)
+#undef NEON_FN
+
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_suqrshl_d(src1, (int8_t)src2, false, env->vfp.qc))
+NEON_GVEC_VOP2i_ENV(neon_sqshlui_d, int64_t)
+#undef NEON_FN
+
 #define NEON_FN(dest, src1, src2) \
     (dest = do_uqrshl_bhs(src1, (int8_t)src2, 8, true, env->vfp.qc))
 NEON_VOP_ENV(qrshl_u8, neon_u8, 4)
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index a31a78c3478..6dd70d1c539 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -1101,113 +1101,9 @@ DO_2SH(VRSRA_S, gen_gvec_srsra)
 DO_2SH(VRSRA_U, gen_gvec_ursra)
 DO_2SH(VSHR_S, gen_gvec_sshr)
 DO_2SH(VSHR_U, gen_gvec_ushr)
-
-static bool do_2shift_env_64(DisasContext *s, arg_2reg_shift *a,
-                             NeonGenTwo64OpEnvFn *fn)
-{
-    /*
-     * 2-reg-and-shift operations, size == 3 case, where the
-     * function needs to be passed tcg_env.
-     */
-    TCGv_i64 constimm;
-    int pass;
-
-    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
-        return false;
-    }
-
-    /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vm) & 0x10)) {
-        return false;
-    }
-
-    if ((a->vm | a->vd) & a->q) {
-        return false;
-    }
-
-    if (!vfp_access_check(s)) {
-        return true;
-    }
-
-    /*
-     * To avoid excessive duplication of ops we implement shift
-     * by immediate using the variable shift operations.
-     */
-    constimm = tcg_constant_i64(dup_const(a->size, a->shift));
-
-    for (pass = 0; pass < a->q + 1; pass++) {
-        TCGv_i64 tmp = tcg_temp_new_i64();
-
-        read_neon_element64(tmp, a->vm, pass, MO_64);
-        fn(tmp, tcg_env, tmp, constimm);
-        write_neon_element64(tmp, a->vd, pass, MO_64);
-    }
-    return true;
-}
-
-static bool do_2shift_env_32(DisasContext *s, arg_2reg_shift *a,
-                             NeonGenTwoOpEnvFn *fn)
-{
-    /*
-     * 2-reg-and-shift operations, size < 3 case, where the
-     * helper needs to be passed tcg_env.
-     */
-    TCGv_i32 constimm, tmp;
-    int pass;
-
-    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
-        return false;
-    }
-
-    /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vm) & 0x10)) {
-        return false;
-    }
-
-    if ((a->vm | a->vd) & a->q) {
-        return false;
-    }
-
-    if (!vfp_access_check(s)) {
-        return true;
-    }
-
-    /*
-     * To avoid excessive duplication of ops we implement shift
-     * by immediate using the variable shift operations.
-     */
-    constimm = tcg_constant_i32(dup_const(a->size, a->shift));
-    tmp = tcg_temp_new_i32();
-
-    for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
-        read_neon_element32(tmp, a->vm, pass, MO_32);
-        fn(tmp, tcg_env, tmp, constimm);
-        write_neon_element32(tmp, a->vd, pass, MO_32);
-    }
-    return true;
-}
-
-#define DO_2SHIFT_ENV(INSN, FUNC)                                       \
-    static bool trans_##INSN##_64_2sh(DisasContext *s, arg_2reg_shift *a) \
-    {                                                                   \
-        return do_2shift_env_64(s, a, gen_helper_neon_##FUNC##64);      \
-    }                                                                   \
-    static bool trans_##INSN##_2sh(DisasContext *s, arg_2reg_shift *a)  \
-    {                                                                   \
-        static NeonGenTwoOpEnvFn * const fns[] = {                      \
-            gen_helper_neon_##FUNC##8,                                  \
-            gen_helper_neon_##FUNC##16,                                 \
-            gen_helper_neon_##FUNC##32,                                 \
-        };                                                              \
-        assert(a->size < ARRAY_SIZE(fns));                              \
-        return do_2shift_env_32(s, a, fns[a->size]);                    \
-    }
-
-DO_2SHIFT_ENV(VQSHLU, qshlu_s)
-DO_2SHIFT_ENV(VQSHL_U, qshl_u)
-DO_2SHIFT_ENV(VQSHL_S, qshl_s)
+DO_2SH(VQSHLU, gen_neon_sqshlui)
+DO_2SH(VQSHL_U, gen_neon_uqshli)
+DO_2SH(VQSHL_S, gen_neon_sqshli)
 
 static bool do_2shift_narrow_64(DisasContext *s, arg_2reg_shift *a,
                                 NeonGenTwo64OpFn *shiftfn,
-- 
2.34.1


