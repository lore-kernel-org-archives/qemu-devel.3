Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B79ECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 16:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snhAX-000468-0F; Mon, 09 Sep 2024 12:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhAS-0003ft-EV
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:23:08 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhAQ-0007o3-0M
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:23:08 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-201d5af11a4so46923945ad.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 09:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725898985; x=1726503785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hUsPG/TbGwoRGhg5jw5hqqGRPpTXNlcc90lCd6MaVz8=;
 b=yILJo0Kx5lJ3EO8KNWFtaHCbeLzu3Db36+tJnSCVVSvDKIJm9makOs2Ta6YXTHJyqv
 Du9ySIYYRn6xkKzmb6A8A7NZfecsJpMs7yrlQO7tzx8richL7A6jhuagE02wljR69Msr
 7qq0mf97z0kKqUuX5kgCqeCN7TYCCca0uMnBnXOQoCuDTG09VGzoQpVZ3nzDR0YNEGiS
 LUyYWTvLXo/DhiFP9AKQ3FJTnynWZGbZgVYmxMXj35ONFmZiN4FnHOWY0RtcmhHiItT9
 0Z40kaya9FoS+53Givu+rUE2eJ3gu4AIf84cCcH+1W2AkejN/mccdT7BzQI1VVN5bFui
 NMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725898985; x=1726503785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hUsPG/TbGwoRGhg5jw5hqqGRPpTXNlcc90lCd6MaVz8=;
 b=ZfBaBIKB55dFDuwBvEBSgBGTkq35h3e+znCUrS6biu9FDat/mcJ3cFHloS9Xwe27v1
 aBeOZNtn4apzSfnqtRv5pfHW4ZGo1ZHbO4F/4xM/Z65qJYaDDibr1A6+pOprXt73zb5M
 vN2lsuKL1LYxD8P6ZZN/eOnI7PsUSHB6eNVWNMSH8KKUdP1V/aSDjUFJ2O42h47thqWc
 /mUUrZ3S0SWgcJ5mwjCmxfMxtoyUILR/WsSIM8cB/Zrxej9pTMtIG7ZupDDtWqR1i8TX
 3nlx6I2SYE8Sny6fWi+jeYeSBSGb7lJfqIy4+iswkZ73yOF/s8sUdHCoB7kdbfveDwbs
 bj0Q==
X-Gm-Message-State: AOJu0Yxz7awMbpMdM7JPpg1U9+GsL0JfSO8kW9gP78/TBHIfHbClXwXr
 7PdpzhakgrG7QEqIdl2p2WUrbnNUZSlqq/6SClrCxzN4YPhqK7OqbsQNFL6ZEbaXMah2OJSSksA
 V
X-Google-Smtp-Source: AGHT+IFJJ7k5wNfrxY2J4AVHnuCejWl87IrH5rH3YsJB3NYXAIed9803ilUA7AWbqyi9WjjPKk4JrQ==
X-Received: by 2002:a17:902:d50a:b0:205:861c:5c3e with SMTP id
 d9443c01a7336-206f054d85amr195039955ad.30.1725898984604; 
 Mon, 09 Sep 2024 09:23:04 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f35d79sm35753305ad.288.2024.09.09.09.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 09:23:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 25/29] target/arm: Convert VQSHL, VQSHLU to gvec
Date: Mon,  9 Sep 2024 09:22:35 -0700
Message-ID: <20240909162240.647173-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909162240.647173-1-richard.henderson@linaro.org>
References: <20240909162240.647173-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
 target/arm/helper.h             |  12 ++++
 target/arm/tcg/translate.h      |   7 ++
 target/arm/tcg/gengvec.c        |  36 +++++++++++
 target/arm/tcg/neon_helper.c    |  33 ++++++++++
 target/arm/tcg/translate-neon.c | 110 +-------------------------------
 target/arm/tcg/neon-dp.decode   |   6 +-
 6 files changed, 94 insertions(+), 110 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index b463be38c5..b40589d329 100644
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
index 45990ae292..7721c627e9 100644
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
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 3abdc57202..f652520b65 100644
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
index 082bfd88ad..739e16e441 100644
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
index a31a78c347..6dd70d1c53 100644
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
diff --git a/target/arm/tcg/neon-dp.decode b/target/arm/tcg/neon-dp.decode
index 788578c8fa..e883c6ab58 100644
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
-- 
2.43.0


