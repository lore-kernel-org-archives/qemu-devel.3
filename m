Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621A2C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pOE-0008RF-DD; Wed, 16 Sep 2026 09:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pN8-0006jZ-MB
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:27 -0400
Received: from mail-oo2-x0e.google.com ([2607:f8b0:4864:31::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pN3-0001Od-VL
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:21 -0400
Received: by mail-oo2-x0e.google.com with SMTP id
 46e09a7af769-7fcb425fb68so549731a34.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564096; x=1790168896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gujLJg/sVv452q6GQHWjQza8ihVHpBwl07DbYlsioeI=;
 b=x7Bt2WCIK4BQXhyaUfZEnLIewWfveDdxZRibgoVB9FjJcvlWPo3NCMOraCQ57LrVsu
 STsbbzPtSn66o0L2OkpPmFTEt+ZzHcewNvXiTSLE3rnzYgpDqIWNe0DumOlf4Yf57Jnb
 pFfrjfUuf008bHPwzJuaoxqp0kzv/eUokKaReuz57E4bOXxXLMxBIBRf6focBqoJVslo
 JPIxKiHKOk6k/v0QddUmukixR3TLRDYpQB9ooMagku2BelMu5g0aekoiH1rS9qNXF4O5
 GWjo4bCfjwa8Twp/JCZIVbQAUD6exMpY3TQmc5vsO4SO633ctKvciii33mRnPMKnlwGf
 sgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564096; x=1790168896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gujLJg/sVv452q6GQHWjQza8ihVHpBwl07DbYlsioeI=;
 b=Rop4HLBvsVfuniK/k3WezOaA5lOFVkueWzD40CGMx0DnhzSuLrecaM0ojWjuCQKHPQ
 rBPvoGMGacpIJ+vP0h0y6tzzuMjFFACx0oeTyoQ9BxipupwaJ0t/vTRkLdwvuq8U5Gi5
 XEraJhRLAXfN1vGEJoTBp2KN+pv8kulM/v2Mt4es4xh2AuTNlzV2t/2r5LFHDdXwaQgp
 t4ee8nQSYDgH6hhSBxcIQOujMG2OO9LkCLvzn0R3uWv4lfbIakz+VBTlWXU+Xk12G+U7
 +9o4YCjSqHstdXrO4eYrs1JvxUBR/FIDVMX9oR9FhNYwy4Rt/GXj3BC3IcB0iX2zDFFD
 JecA==
X-Gm-Message-State: AFuF++kEO1/jH4LA7YHgNnRszjG/rb48RFRIz89Yau/9gkVEumNQ30UW
 IRe+WFq+claS3ynF8xa35Bm4iFnCQoPB7/YlswyNb9gVIhD3HlxoP2Wb5Csyvz/m9dNqU707EYD
 XMXsBTVM=
X-Gm-Gg: AYBFou3p2U8eH7U2t9yDQljLCzCWk8JoRw9aVYmnoFjCs8+UGTK3Rs1G1GHGUYoVwEV
 lkbm0/wkwCxU++ghBq9TRhwonDjCr+pdCUHLtmzIbYYOmwJacKJDeUk4OR/R2m5lQBeUwdXENNP
 oy+ynOgJnZCPMwOKjc2Caa2bFpQFn6mEt6vw9sA1rokD4iUNMFZo63M63EAlGlufdEt1i9lWiUS
 fEUTePx176EWa5bskBG2kxRJhKaF1yu+gPGPEYADU91/LQ+OU03b5+NqbFgYWOOwqNTXbtgxjyp
 em9SYPoMwz/JL3gxkeLmcn6snONbr6H4Uc/gk0IQL0d3LyUmtbsWGyj23FdKqilKez3lPW1FJ7e
 DZ3JfiQ7HxnZFVjdnWycC/bItm6hxaVkOpVD37DJFTlV/YH97w5YdokedmDzUOsmhN8/DfZ7A+8
 Q2nTF4UP+zxBfvyHxzopyHmmQx4GFKcJC8EcLJ0qSRvi3RT1h9WNTThEokHLp5pq2fVGnB8kOtE
 s7qTjIMVVXTmt7btBo=
X-Received: by 2002:a4a:e913:0:b0:6be:139:c031 with SMTP id
 006d021491bc7-6c7d27e0c77mr2350385eaf.39.1789564095906; 
 Wed, 16 Sep 2026 06:08:15 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 42/92] tcg: Generic expansion of tcg_gen_setcond_*
Date: Wed, 16 Sep 2026 03:03:17 -1000
Message-ID: <20260916130409.3382710-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0e.google.com
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
 include/tcg/tcg-op-common.h  |  4 ----
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 42 ++++++++++++++++--------------------
 3 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 006f668aa5f..2df3fe5f6a8 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,8 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
-                         TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
                           TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
@@ -217,8 +215,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
-                         TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
                           TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 63e87c8313b..6ce86d2005a 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -26,6 +26,7 @@ DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
+DEF4(setcond, TCGCond, TCGV, TCGV, TCGV)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 17251a8be93..20a31b8bcb9 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -121,6 +121,12 @@ static TCGOp *gen_op_ttii(TCGOpcode opc, TCGType type,
     return tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), a2, a3);
 }
 
+static TCGOp *gen_op_ttti(TCGOpcode opc, TCGType type,
+                          TCGTemp *t0, TCGTemp *t1, TCGTemp *t2, TCGArg a3)
+{
+    return tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2), a3);
+}
+
 static TCGOp *gen_op_ttttt(TCGOpcode opc, TCGType type,
                            TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
                            TCGTemp *t3, TCGTemp *t4)
@@ -679,6 +685,18 @@ static void gen_sari(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_setcond(TCGType type, TCGCond cond, TCGTemp *dst,
+                        TCGTemp *src1, TCGTemp *src2)
+{
+    if (cond == TCG_COND_ALWAYS) {
+        gen_movi(type, dst, 1);
+    } else if (cond == TCG_COND_NEVER) {
+        gen_movi(type, dst, 0);
+    } else {
+        gen_op_ttti(INDEX_op_setcond, type, dst, src1, src2, cond);
+    }
+}
+
 static void gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
@@ -747,18 +765,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
-                         TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_movi_i32(ret, 1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_movi_i32(ret, 0);
-    } else {
-        tcg_gen_op4i_i32(INDEX_op_setcond, ret, arg1, arg2, cond);
-    }
-}
-
 void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
                           TCGv_i32 arg1, int32_t arg2)
 {
@@ -1537,18 +1543,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
-                         TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_movi_i64(ret, 1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_movi_i64(ret, 0);
-    } else {
-        tcg_gen_op4i_i64(INDEX_op_setcond, ret, arg1, arg2, cond);
-    }
-}
-
 void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
                           TCGv_i64 arg1, int64_t arg2)
 {
-- 
2.53.0


