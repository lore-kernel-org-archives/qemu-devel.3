Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F53C88E5A
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aBD-0003U7-TI; Sat, 12 Sep 2026 22:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aB9-00037a-3l
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:51 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aB7-0001wd-0D
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:50 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-39b31b4281eso1095861a91.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267367; x=1789872167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8nVaRSAq+Xy0i1dSMIilM4fKeLkrvkGh+aTe5+uvrTo=;
 b=KBhstxgPXplgsEmC9dWYlww+joWZUGr1anWrkz7fHtrKIbpYb/2fN/u+EWYEOY9WTd
 qDhE4Bri4DCo4qR4h84/ZtW+ZBD37mqQYMIQBVi7QJI1+ydt2+TL+iSQTj1Rqluw8eoZ
 GcYV5IOIL1hwfB+gaJjXmPJp2vJ8pn50h1xdJ80UKjyjAktoYqvOBflxM+JtcPW2cB67
 JYTZ7lgfLStThJzh/mIif7uf8cCtaXtXKnr8JdybcxGst4tTS5PUh0k/pThB9Gnojtbq
 rnWZpzzrWhUaU+4fsdgr63LsRM6WkcL8ZGG+RK7zeWpHTZTrXvDVCjp2eutV5kcqCzk7
 ts6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267367; x=1789872167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8nVaRSAq+Xy0i1dSMIilM4fKeLkrvkGh+aTe5+uvrTo=;
 b=C4jCd2FPORE8pzfnhiYVlFxoZcxlwDhdFBusfKAT4jKfsvYh3K5ap4Drl1nYD766Ns
 GdxFWRoIY+XU7y2pv/+/x/UfmV2cGEBXO2aoWeXZvbQrqkqlDBE/h991fvC57EbC68y6
 Lqb82PAVMl1ovP9Ll/f1Y5uQvXwQiXH7P4BTP65VDbp5yf66Sxwwo0+Cqj2MWdWg8AAr
 3uOQl5+wSlglbJUG5W3ZaDmQSyQOfaw6N5ctQfJio4Oe4LiC550X+reTk0Mu501x+oTt
 qRh1CjLkcSTYGakjdxOPaKCGxLBV+Ys6zgYt0bbcchyx9A4Ql5h8TY7D2+oHPzcZSR0g
 cQeg==
X-Gm-Message-State: AFuF++nlMm5ZMyYuuvxhkdL5knrdsWJswv+CJU0A9qm6sgex95gT5bMM
 vo2c1TJSMb3pwy0vyaOppKkQkk+d7RbH/iRq+EJmtqfvgMQtixzou2eZP2mEWL9+nLBk78M/ml2
 gqIMY0c0=
X-Gm-Gg: AYBFou3P/n9a8mBEYCG6Idv3UH1fbbwlj9PRoWdcQXmuIlTqQvATZQY/KHeIJ0KiCUH
 JuX0hqkLd8ZvLLhfE2N1nMjc6T98nILgbL2inslL7vlMpYlUzFn8uFHeA+lGmiyzzvPGi/HYkB7
 +MXkkb/abRDqfzHIKSyyfXjsiW+lEs2V3GypfMgsvsIfHLKVhT+2v03u1rFvisclgZBg3UJOfWs
 e25+tl2T31uMx4ixFV+3kiAISNuByUIP9fEl6fPbHfzJQbuFr7atvoWuG+Pks7s0inAqdei/l1s
 6gn3hFgXhh2Jxg09IdoT0roWnO9ezmjQ3DvSVhj+ljlnENzWGSgHG/RWi/LmKx9p6oFhAbrpmzV
 M3O9zkyLvW+vWxcABnS14+9adAIK24p7mt8XJ/LIrERB8Yzgx3gJl1AaO+QVQ43EzWqL+7VtFsL
 6AHiyMOJ9sc4xNeqyYzzGMDzKYJ0l6+/PgiLEEBZc48SAD4AgdxvPhJ1w2EYgPRvD65tUiCGJbA
 m+1Sjg=
X-Received: by 2002:a17:90b:134f:b0:399:1b08:28de with SMTP id
 98e67ed59e1d1-39d9beb0be4mr20886073a91.7.1789267367459; 
 Sat, 12 Sep 2026 19:42:47 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 61/86] tcg: Generic expansion of tcg_gen_sextract_*
Date: Sat, 12 Sep 2026 16:38:12 -1000
Message-ID: <20260913023837.741866-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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
 include/tcg/tcg-op-common.h  |   4 --
 include/tcg/tcg-op-def.h.inc |   1 +
 tcg/tcg-op.c                 | 121 +++++++++++------------------------
 3 files changed, 38 insertions(+), 88 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index f31ad085208..2800aa0dd0e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -134,8 +134,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
                            unsigned int ofs, unsigned int len);
-void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
-                          unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
@@ -181,8 +179,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
                            unsigned int ofs, unsigned int len);
-void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
-                          unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 856338aa0d4..21a941f5458 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -43,6 +43,7 @@ DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF4(setcond, TCGCond, TCGV, TCGV, TCGV)
 DEF4(setcondi, TCGCond, TCGV, TCGV, TINT)
+DEF4(sextract, TCGV, TCGV, unsigned, unsigned)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index e8d07764861..4152e29143d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -244,20 +244,6 @@ static void DNI tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                 tcgv_i64_arg(a3), a4);
 }
 
-static TCGOp * DNI tcg_gen_op4ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                     TCGArg a3, TCGArg a4)
-{
-    return tcg_gen_op4(opc, TCG_TYPE_I32,
-                       tcgv_i32_arg(a1), tcgv_i32_arg(a2), a3, a4);
-}
-
-static TCGOp * DNI tcg_gen_op4ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                     TCGArg a3, TCGArg a4)
-{
-    return tcg_gen_op4(opc, TCG_TYPE_I64,
-                       tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3, a4);
-}
-
 static void DNI tcg_gen_op5ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                   TCGv_i32 a3, TCGArg a4, TCGArg a5)
 {
@@ -1041,6 +1027,43 @@ static void gen_setcondi(TCGType type, TCGCond cond, TCGTemp *dst,
     gen_setcond(type, cond, dst, src1, tcg_constant_internal(type, src2));
 }
 
+static void gen_sextract(TCGType type, TCGTemp *dst, TCGTemp *src,
+                         unsigned int ofs, unsigned int len)
+{
+    unsigned width = tcg_type_size(type) * 8;
+
+    tcg_debug_assert(ofs < width);
+    tcg_debug_assert(len > 0);
+    tcg_debug_assert(len <= width);
+    tcg_debug_assert(ofs + len <= width);
+
+    /* Canonicalize certain special cases, even if extract is supported.  */
+    if (ofs + len == width) {
+        gen_sari(type, dst, src, width - len);
+        return;
+    }
+
+    if (TCG_TARGET_sextract_valid(type, ofs, len)) {
+        gen_op_ttii(INDEX_op_sextract, type, dst, src, ofs, len);
+        return;
+    }
+
+    /* Assume that sign-extension, if available, is cheaper than a shift.  */
+    if (TCG_TARGET_sextract_valid(type, 0, ofs + len)) {
+        gen_op_ttii(INDEX_op_sextract, type, dst, src, 0, ofs + len);
+        gen_sari(type, dst, dst, ofs);
+        return;
+    }
+    if (TCG_TARGET_sextract_valid(type, 0, len)) {
+        gen_shri(type, dst, src, ofs);
+        gen_op_ttii(INDEX_op_sextract, type, dst, dst, 0, len);
+        return;
+    }
+
+    gen_shli(type, dst, src, width - len - ofs);
+    gen_sari(type, dst, dst, width - len);
+}
+
 static void gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
@@ -1127,41 +1150,6 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
     }
 }
 
-void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
-                          unsigned int ofs, unsigned int len)
-{
-    tcg_debug_assert(ofs < 32);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 32);
-    tcg_debug_assert(ofs + len <= 32);
-
-    /* Canonicalize certain special cases, even if extract is supported.  */
-    if (ofs + len == 32) {
-        tcg_gen_sari_i32(ret, arg, 32 - len);
-        return;
-    }
-
-    if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, ofs, len)) {
-        tcg_gen_op4ii_i32(INDEX_op_sextract, ret, arg, ofs, len);
-        return;
-    }
-
-    /* Assume that sign-extension, if available, is cheaper than a shift.  */
-    if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, 0, ofs + len)) {
-        tcg_gen_op4ii_i32(INDEX_op_sextract, ret, arg, 0, ofs + len);
-        tcg_gen_sari_i32(ret, ret, ofs);
-        return;
-    }
-    if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, 0, len)) {
-        tcg_gen_shri_i32(ret, arg, ofs);
-        tcg_gen_op4ii_i32(INDEX_op_sextract, ret, ret, 0, len);
-        return;
-    }
-
-    tcg_gen_shli_i32(ret, arg, 32 - len - ofs);
-    tcg_gen_sari_i32(ret, ret, 32 - len);
-}
-
 /*
  * Extract 32-bits from a 64-bit input, ah:al, starting from ofs.
  * Unlike tcg_gen_extract_i32 above, len is fixed at 32.
@@ -1831,41 +1819,6 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
     }
 }
 
-void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
-                          unsigned int ofs, unsigned int len)
-{
-    tcg_debug_assert(ofs < 64);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 64);
-    tcg_debug_assert(ofs + len <= 64);
-
-    /* Canonicalize certain special cases, even if sextract is supported.  */
-    if (ofs + len == 64) {
-        tcg_gen_sari_i64(ret, arg, 64 - len);
-        return;
-    }
-
-    if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, ofs, len)) {
-        tcg_gen_op4ii_i64(INDEX_op_sextract, ret, arg, ofs, len);
-        return;
-    }
-
-    /* Assume that sign-extension, if available, is cheaper than a shift.  */
-    if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, 0, ofs + len)) {
-        tcg_gen_op4ii_i64(INDEX_op_sextract, ret, arg, 0, ofs + len);
-        tcg_gen_sari_i64(ret, ret, ofs);
-        return;
-    }
-    if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, 0, len)) {
-        tcg_gen_shri_i64(ret, arg, ofs);
-        tcg_gen_op4ii_i64(INDEX_op_sextract, ret, ret, 0, len);
-        return;
-    }
-
-    tcg_gen_shli_i64(ret, arg, 64 - len - ofs);
-    tcg_gen_sari_i64(ret, ret, 64 - len);
-}
-
 /*
  * Extract 64 bits from a 128-bit input, ah:al, starting from ofs.
  * Unlike tcg_gen_extract_i64 above, len is fixed at 64.
-- 
2.53.0


