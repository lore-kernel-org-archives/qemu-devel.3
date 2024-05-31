Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8C5C25B7E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD10C-0004e7-VL; Fri, 31 May 2024 08:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD104-0004XT-E7
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:49 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zl-0003VK-SY
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:48 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4212e341818so5208715e9.2
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157067; x=1717761867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L2rBmJ6yc4PQdG8tqT4WI/SFPoKG10zwGnHUmXUGw/s=;
 b=RNa6Ue4VwwTvzgN1S9EvFaaA0TXiDK9U3oxb3ujICAZuF5Z6sCUzy7sZqZ/bNizcv3
 GsdTza010ydhzPbMC3XeskXup6BlgAJDqN5b6Y3/hsrljOJGj0nuvI47UXkUb4606S+N
 rJ4hNtasAlMCuh31BOMuxC5j7KcXKpvp85Lp8VgxbcSSeOivtDs0yrTuk63f9WMzNoyp
 NQ9ILsEkJ0jGkLO66l1Z7zmYr5tUIDu/tO4612dSW+U0VANAw8PH3u4bQkIoFf33/Pbl
 ctukwgi/gOB8Jwx62VnBuNrpRZ1rFTw4vqpTTFUu9mTL1yWnOFxRiOM1v/vG5ihwAosF
 Q4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157067; x=1717761867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L2rBmJ6yc4PQdG8tqT4WI/SFPoKG10zwGnHUmXUGw/s=;
 b=L2Mi8Hvb+YQvwBoHlfCANLv22VyIToRIMzbIjPK0C0hb0ByJ2t748CuvF9lNF5ZgBM
 MB4uIC7Grqe35mQJm+7XyZfVxDz0ZsdlXIBEg/+GHkSSvslRvVtP8SIaXxL3Z4YbX52t
 IkyDFmjQCs7hUuY8L8RffdPEhvr/LN8lY3lzFDdD7frzBLB/VejEfxFr4948T/f4BHLX
 St0MZHXixjnC6FAIjpL71c/+i49D1zMVNVdU+ykaHtBYM6NxrODDBSJWK/s8r34vOPdZ
 P9VxnKHtMLW/F6qmx4zBTm+/+vuiaiXC0/XkF3IqmeqqPVc0vfogSR0xCjFHKjiUCH9i
 C/9Q==
X-Gm-Message-State: AOJu0YwFbB8h3tUYRZ7HWmrmTYt0QV4f8ID/0o/EwFNBJNVuzEYou/DB
 8wZ+DmhdlaC5U/bGqVjzFyl1UAJHRN5bRbo71h49Cb4jNci2XMxCvcebtxTU4t6lWcZpd69Ea6k
 T
X-Google-Smtp-Source: AGHT+IECLQP2Y5Wlg9jGX8jeO65vGNmFo4P1p55mHSnqzEWWT3Kd4NIhx1gWY21Y6twV8ssp1jKE2A==
X-Received: by 2002:a05:600c:2e4a:b0:41f:c83d:5ba8 with SMTP id
 5b1f17b1804b1-4212e09d949mr12741825e9.32.1717157067526; 
 Fri, 31 May 2024 05:04:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/43] target/arm: Tidy SQDMULH, SQRDMULH (vector)
Date: Fri, 31 May 2024 13:03:53 +0100
Message-Id: <20240531120401.394550-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We already have a gvec helper for the operations, but we aren't
using it on the aa32 neon side.  Create a unified expander for
use by both aa32 and aa64 translators.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240528203044.612851-31-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.h      |  4 ++++
 target/arm/tcg/gengvec.c        | 20 ++++++++++++++++++++
 target/arm/tcg/translate-a64.c  | 23 ++++-------------------
 target/arm/tcg/translate-neon.c | 23 +++--------------------
 4 files changed, 31 insertions(+), 39 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 3b1e68b7794..aba21f730fe 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -539,6 +539,10 @@ void gen_gvec_sri(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
 void gen_gvec_sli(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
                   int64_t shift, uint32_t opr_sz, uint32_t max_sz);
 
+void gen_gvec_sqdmulh_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                         uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_sqrdmulh_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                          uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 void gen_gvec_sqrdmlah_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                           uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 void gen_gvec_sqrdmlsh_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 119826bf284..56a1dc1f755 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -35,6 +35,26 @@ static void gen_gvec_fn3_qc(uint32_t rd_ofs, uint32_t rn_ofs, uint32_t rm_ofs,
                        opr_sz, max_sz, 0, fn);
 }
 
+void gen_gvec_sqdmulh_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                         uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static gen_helper_gvec_3_ptr * const fns[2] = {
+        gen_helper_neon_sqdmulh_h, gen_helper_neon_sqdmulh_s
+    };
+    tcg_debug_assert(vece >= 1 && vece <= 2);
+    gen_gvec_fn3_qc(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, fns[vece - 1]);
+}
+
+void gen_gvec_sqrdmulh_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                         uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static gen_helper_gvec_3_ptr * const fns[2] = {
+        gen_helper_neon_sqrdmulh_h, gen_helper_neon_sqrdmulh_s
+    };
+    tcg_debug_assert(vece >= 1 && vece <= 2);
+    gen_gvec_fn3_qc(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, fns[vece - 1]);
+}
+
 void gen_gvec_sqrdmlah_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                           uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
 {
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c4601cde2f7..c673b95ec7a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -724,19 +724,6 @@ static void gen_gvec_op3_fpst(DisasContext *s, bool is_q, int rd, int rn,
                        is_q ? 16 : 8, vec_full_reg_size(s), data, fn);
 }
 
-/* Expand a 3-operand + qc + operation using an out-of-line helper.  */
-static void gen_gvec_op3_qc(DisasContext *s, bool is_q, int rd, int rn,
-                            int rm, gen_helper_gvec_3_ptr *fn)
-{
-    TCGv_ptr qc_ptr = tcg_temp_new_ptr();
-
-    tcg_gen_addi_ptr(qc_ptr, tcg_env, offsetof(CPUARMState, vfp.qc));
-    tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
-                       vec_full_reg_offset(s, rn),
-                       vec_full_reg_offset(s, rm), qc_ptr,
-                       is_q ? 16 : 8, vec_full_reg_size(s), 0, fn);
-}
-
 /* Expand a 4-operand operation using an out-of-line helper.  */
 static void gen_gvec_op4_ool(DisasContext *s, bool is_q, int rd, int rn,
                              int rm, int ra, int data, gen_helper_gvec_4 *fn)
@@ -11007,12 +10994,10 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
 
     switch (opcode) {
     case 0x16: /* SQDMULH, SQRDMULH */
-        {
-            static gen_helper_gvec_3_ptr * const fns[2][2] = {
-                { gen_helper_neon_sqdmulh_h, gen_helper_neon_sqrdmulh_h },
-                { gen_helper_neon_sqdmulh_s, gen_helper_neon_sqrdmulh_s },
-            };
-            gen_gvec_op3_qc(s, is_q, rd, rn, rm, fns[size - 1][u]);
+        if (u) {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sqrdmulh_qc, size);
+        } else {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sqdmulh_qc, size);
         }
         return;
     }
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index f9a8753906a..915c9e56db5 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -937,28 +937,11 @@ DO_SHA2(SHA256SU1, gen_helper_crypto_sha256su1)
     }
 
 #define DO_3SAME_VQDMULH(INSN, FUNC)                                    \
-    WRAP_ENV_FN(gen_##INSN##_tramp16, gen_helper_neon_##FUNC##_s16);    \
-    WRAP_ENV_FN(gen_##INSN##_tramp32, gen_helper_neon_##FUNC##_s32);    \
-    static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
-                                uint32_t rn_ofs, uint32_t rm_ofs,       \
-                                uint32_t oprsz, uint32_t maxsz)         \
-    {                                                                   \
-        static const GVecGen3 ops[2] = {                                \
-            { .fni4 = gen_##INSN##_tramp16 },                           \
-            { .fni4 = gen_##INSN##_tramp32 },                           \
-        };                                                              \
-        tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, oprsz, maxsz, &ops[vece - 1]); \
-    }                                                                   \
     static bool trans_##INSN##_3s(DisasContext *s, arg_3same *a)        \
-    {                                                                   \
-        if (a->size != 1 && a->size != 2) {                             \
-            return false;                                               \
-        }                                                               \
-        return do_3same(s, a, gen_##INSN##_3s);                         \
-    }
+    { return a->size >= 1 && a->size <= 2 && do_3same(s, a, FUNC); }
 
-DO_3SAME_VQDMULH(VQDMULH, qdmulh)
-DO_3SAME_VQDMULH(VQRDMULH, qrdmulh)
+DO_3SAME_VQDMULH(VQDMULH, gen_gvec_sqdmulh_qc)
+DO_3SAME_VQDMULH(VQRDMULH, gen_gvec_sqrdmulh_qc)
 
 #define WRAP_FP_GVEC(WRAPNAME, FPST, FUNC)                              \
     static void WRAPNAME(unsigned vece, uint32_t rd_ofs,                \
-- 
2.34.1


