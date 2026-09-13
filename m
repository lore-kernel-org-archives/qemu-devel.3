Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7FBC88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a86-00017u-Oy; Sat, 12 Sep 2026 22:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7a-0008RX-IE
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:12 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7W-00012B-Kj
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:10 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-398e9698a70so2293779a91.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267145; x=1789871945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2DcMgzQawZeN0X/jS3dPuO+FK3dlC+j6rlZepXNXuvE=;
 b=FcFZY+2B1vhXXY8rtc/fRF2ngEWnRQHZlaFImuOlWUh9nQaSN+p9354aDiIgQy7rlH
 EqBmqYV48LHnDHkfut6oBzQ7pGDKcgtrBLjdCbbNBzrbAndMcuUm5aJ/pyVanr7IH7aa
 YGTWKz65RGAWRr2548HqYhV0nRnPdAk15BDDUDgJfIf6Ox1Y9vRFz0MJjI6fWiO2+dd4
 6grkhSdBDDQ5bv8B6Z4sfyuAhZt5AQF51bT5kh3kTYA3jr6H2kes8jlKO5IKz46/0xS5
 dNVTPOnGR0jMcWJSIt3F2Ci+T55O+XdFGXLnCCSHQbVse8XwKc159Ipr+lvcZqfmkiKD
 qOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267145; x=1789871945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2DcMgzQawZeN0X/jS3dPuO+FK3dlC+j6rlZepXNXuvE=;
 b=npO8kkk3vRQg5AC5aHxaby0DWeLuwCxOGSltmpkG4DhjCaV67IJVTW48433S0617Oi
 I/slDz6cfmS/95eMxy2sZT9oFRDAOJDyfE5Fo15cLLK8y1PsxRC9x3QayBQCQgKoHvn1
 1/ibKxy7ozGb0pzvPHr7SwWs1SccUwrreM/zI/CqfqvA7dwuKy6hNY/PazNF0p4SHU8z
 7uHR7MKLXowx7b+tbefcmOsRYy1cLp5C1c5h8wM/jeJc8+OARuSBJtZzqkOotlQ0zuFw
 Bi/+Y4OpOA1SRkGNyFtNTvqSXTvwSaQ5epB+qwjvH/sMf+RRUEQpGCZiwKJFIawFYSx7
 6Wew==
X-Gm-Message-State: AFuF++k5TN87zKZCSTBocAKApcG6f3vCu+Ibo4hsN5X0XKkD88V4i7sg
 vK8Hdo4Y/w1rvAMDHzv4lKV8i7JppDaJPOMjrCTKA7TbmGho+oJ+IbOrK7wCvi9YzKx4qE2gnT0
 qUKlA
X-Gm-Gg: AYBFou1RMzSfYrzSYxBWJCWSP4s5aiXS4BELg69jZU5DKYk8qUKjEYEmMXsp22Jlrm4
 fzB60/hBLEyhVymGeGUUZOBuT+KcP3puZUzm/UR4uru4Vw/ful6srJNTBqal3uamm87ImLIvd+D
 G/FLAmHwxyEvDVrnZ9gjmU6H03fMDAxTfkmHo6VT4Zrp7VDmf7Vps7VyKcQCru3V38KqXXDz8By
 O8a2DXPEhFKllSQe+wI5R/NUQhVQa1jU4afx74oc7cwZmw4Jrn2TVBCKcYtmZbMDyQzu1dBB4cE
 2jA4AP8XO/Q3Bd3KwOFltLv6OcHmdonrjuhdnJY8WwRVYvoQT0WniGWdm8tMsuBGnvS5Ql8SP+3
 WVb8MiYf6ckcWY+ZSj5Rc4UGbcDjz3blYbrxEPlRUvwT+eJnQ8LC8BaHt2dgWbKDrcMX5FypOQO
 Ogh/ooD+fIz9pNgkHmjBCUPGq0G2BxFr8j3CvQ6sdcMo2hm5LWO6dKsN7Xj5pAywDG51Hb+z9T3
 nCjtbY=
X-Received: by 2002:a17:90a:c2cf:b0:398:9bd1:3210 with SMTP id
 98e67ed59e1d1-39d9c21d78cmr21167160a91.17.1789267144688; 
 Sat, 12 Sep 2026 19:39:04 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.39.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:39:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 22/86] tcg: Generic expansion of tcg_gen_andi_*
Date: Sat, 12 Sep 2026 16:37:33 -1000
Message-ID: <20260913023837.741866-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
 include/tcg/tcg-op-common.h  |  2 -
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 90 ++++++++++++------------------------
 3 files changed, 31 insertions(+), 62 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 99f4109d865..a932e975f27 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -211,7 +210,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index bfd2cd4b9c8..67056e9f730 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -3,6 +3,7 @@
 DEF3(add, TCGV, TCGV, TCGV)
 DEF3(addi, TCGV, TCGV, TINT)
 DEF3(and, TCGV, TCGV, TCGV)
+DEF3(andi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 34b2ecb2c49..dd1ef7f8c24 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -115,6 +115,12 @@ static TCGOp *gen_op_ttt(TCGOpcode opc, TCGType type,
     return tcg_gen_op3(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2));
 }
 
+static TCGOp *gen_op_ttii(TCGOpcode opc, TCGType type,
+                          TCGTemp *t0, TCGTemp *t1, TCGArg a2, TCGArg a3)
+{
+    return tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), a2, a3);
+}
+
 /*
  * With CONFIG_DEBUG_TCG, tcgv_*_tmp via tcgv_*_arg, is an out-of-line
  * assertion check.  Force tail calls to avoid too much code expansion.
@@ -416,6 +422,30 @@ static void gen_and(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_and, type, dst, src1, src2);
 }
 
+static void gen_andi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    if (src2 == 0) {
+        gen_movi(type, dst, 0);
+    } else if (src2 == -1) {
+        gen_mov(type, dst, src1);
+    } else {
+        /*
+         * Canonicalize on extract, if valid.  This aids x86 with its
+         * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcode
+         * which does not require matching operands.  Other backends can
+         * trivially expand the extract to AND during code generation.
+         */
+        if (is_power_of_2(src2 + 1)) {
+            unsigned len = cto64(src2);
+            if (TCG_TARGET_extract_valid(type, 0, len)) {
+                gen_op_ttii(INDEX_op_extract, type, dst, src1, 0, len);
+                return;
+            }
+        }
+        gen_and(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -519,36 +549,6 @@ static void gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 
 /* 32 bit ops */
 
-void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    /* Some cases can be optimized here.  */
-    switch (arg2) {
-    case 0:
-        tcg_gen_movi_i32(ret, 0);
-        return;
-    case -1:
-        tcg_gen_mov_i32(ret, arg1);
-        return;
-    default:
-        /*
-         * Canonicalize on extract, if valid.  This aids x86 with its
-         * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcode
-         * which does not require matching operands.  Other backends can
-         * trivially expand the extract to AND during code generation.
-         */
-        if (!(arg2 & (arg2 + 1))) {
-            unsigned len = ctz32(~arg2);
-            if (TCG_TARGET_extract_valid(TCG_TYPE_I32, 0, len)) {
-                tcg_gen_extract_i32(ret, arg1, 0, len);
-                return;
-            }
-        }
-        break;
-    }
-
-    tcg_gen_and_i32(ret, arg1, tcg_constant_i32(arg2));
-}
-
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -1527,36 +1527,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    /* Some cases can be optimized here.  */
-    switch (arg2) {
-    case 0:
-        tcg_gen_movi_i64(ret, 0);
-        return;
-    case -1:
-        tcg_gen_mov_i64(ret, arg1);
-        return;
-    default:
-        /*
-         * Canonicalize on extract, if valid.  This aids x86 with its
-         * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcode
-         * which does not require matching operands.  Other backends can
-         * trivially expand the extract to AND during code generation.
-         */
-        if (!(arg2 & (arg2 + 1))) {
-            unsigned len = ctz64(~arg2);
-            if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, len)) {
-                tcg_gen_extract_i64(ret, arg1, 0, len);
-                return;
-            }
-        }
-        break;
-    }
-
-    tcg_gen_and_i64(ret, arg1, tcg_constant_i64(arg2));
-}
-
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* Some cases can be optimized here.  */
-- 
2.53.0


