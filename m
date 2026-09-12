Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7983C88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1Z-0004vH-TO; Sat, 12 Sep 2026 06:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1F-0004mY-ND
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:38 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1D-0007FS-WF
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:37 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-39b31b4281eso676875a91.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209095; x=1789813895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/TMoPKyOoUGXlwwqxsVGx7frxJ4ccWV4W0oh6em9FYY=;
 b=eUG+TEdebyFp4uHGwmxjzD0hhFaLut3wTzBMjAy2pT0Y86Aemap6hgvrutnM2G0d20
 7pgE7DkzGOGMwDsEnIZiQY/XgNc5+vzs96qZtWJfs0TZw+bozFPchkUIpIRt6m137Ehn
 mXWx0nXT9TfajiuA0NJAGgkD03jBE+qYUg4J302NECBmNtY45pW8dTwITKvJTYHzmWGW
 WET4NE4NZxOZhwtUSKoGp8/z2H2D1SkNxQr1cD4TyHKyAwAVyGOGKmmFM6zIcyWqjTDX
 XtCcUQCJZwTDCWfvGlXg93Yecu2oZBb7wiwGuPi+RiqJM1c2+1gIJfdCjC3vRKlgdOLQ
 HHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209095; x=1789813895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/TMoPKyOoUGXlwwqxsVGx7frxJ4ccWV4W0oh6em9FYY=;
 b=budSV1BXlKREBfg/WNsgkJecNkZk156wtDWE9TPl9BXD2W3TyGPk/qKJpfB+mVomPv
 CpDwtAs0YY3MfEjeH3LU4aqk0mjqra24lKu0r9U9cjN4boUPCnioYZIu0R1VX8T42dUT
 a3wfxRexsFt6VAx5UozpvUbO7k/wxZb7pNHeG+cznE5dLWAqnZl1kI1U3mJNCi5tXrBb
 8QkILKxlkTU5AMxq8MSgnbSbGCEKdHwcH4IHSbyclGKu0PQWqsFtU0DO/cSsHtpSt5pZ
 +yoqUun/G/zzCnafrrhQbLxcfc3+MVIR0/wyjkSbVmcH+vp0RTuYatXm66q2lZkvaj+z
 6ojw==
X-Gm-Message-State: AFuF++mCDQNCBNx7EVWVGVqq8BxMJGDb0Y2SMWiR0qRKC3LDtBvt/RHL
 iws4no/j7G25Lo6BD2XNzXcyVzXB7Jkq5a1uUDDy2u4kQvbM8k8LOhgSNe/HXCyXjtq6C8CAEd8
 IC0m6
X-Gm-Gg: AYBFou11X8YZFYC56if46O8kyEegcyZsW1WgJ079/x7S1uUWurfsOyogyMpLSxTvKB8
 36D6OCnWFjqL7WRG7Yym6BoZkBOL9+V2rIZlK/GLp+aeokmIsbLK7gxfEssERQzNte2JT1m6cze
 DpLUqAo/BrP0ejqetpDU1OP1JGFtHex9jlXCxXA5EZWr/unZV2yJulHFdXxCNzxqE/2w3ZQVNdW
 9YJ3nuWqVrDr30r89ejVjeiGMnDF5NhMf++gvRDbZxD7U1wWzZe3+LaDIXZCWPWl1ixaKxaFW8A
 oXctTD08Ua+YEf6PPedvSBApv9TcpJ8VjS04w6adX6DhNmCdiyC3oRBp/A0moHsSEdtAdUUCUGB
 WujpBv04snEvOJbQGRbvHCDDrmD2tItt7JmvTrgYHWxkToZR/uty+kuzEOghdM22KKyTnlgKUdE
 JEhFHi7XAWBgjWHcTRhc1Cgh2fgPAYmooE3iyTnzXg5uwJclYzulU11QSuwzZ+txXDKuOzwT29y
 ajneTUbRTdYj3Et+Q==
X-Received: by 2002:a17:90b:588d:b0:398:bacb:1137 with SMTP id
 98e67ed59e1d1-39d9c3771a8mr14288759a91.19.1789209094678; 
 Sat, 12 Sep 2026 03:31:34 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/82] tcg: Generic expansion of tcg_gen_add_*
Date: Sat, 12 Sep 2026 00:30:10 -1000
Message-ID: <20260912103126.598030-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h   |  6 ++++--
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 30 ++++++++++++++++++++----------
 3 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index c0de3f9f45e..ab0c3f9554c 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -98,6 +98,9 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #define DEF_RR(NAME) \
     void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b);
 
+#define DEF_RRR(NAME) \
+    void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b, TCGV c);
+
 #define DEF_RI(NAME) \
     void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TINT b);
 
@@ -105,6 +108,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 #undef DEF_R
 #undef DEF_RR
+#undef DEF_RRR
 #undef DEF_RI
 
 /* 32 bit ops */
@@ -199,7 +203,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_add_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -304,7 +307,6 @@ void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_add_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 7943746a44a..e36fd296a30 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -3,3 +3,4 @@
 DEF_R(discard)
 DEF_RI(movi)
 DEF_RR(mov)
+DEF_RRR(add)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index d796016ca26..30c84d348c9 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -109,6 +109,12 @@ static void gen_op_tt(TCGOpcode opc, TCGType type, TCGTemp *t0, TCGTemp *t1)
     tcg_gen_op2(opc, type, temp_arg(t0), temp_arg(t1));
 }
 
+static TCGOp *gen_op_ttt(TCGOpcode opc, TCGType type,
+                         TCGTemp *t0, TCGTemp *t1, TCGTemp *t2)
+{
+    return tcg_gen_op3(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2));
+}
+
 /*
  * With CONFIG_DEBUG_TCG, tcgv_*_tmp via tcgv_*_arg, is an out-of-line
  * assertion check.  Force tail calls to avoid too much code expansion.
@@ -320,6 +326,9 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #define DEF_RR(NAME) \
     static void glue(gen_,NAME)(TCGType, TCGTemp *, TCGTemp *);
 
+#define DEF_RRR(NAME) \
+    static void glue(gen_,NAME)(TCGType, TCGTemp *, TCGTemp *, TCGTemp *);
+
 #define DEF_RI(NAME) \
     static void glue(gen_,NAME)(TCGType, TCGTemp *, int64_t);
 
@@ -327,6 +336,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 
 #undef DEF_R
 #undef DEF_RR
+#undef DEF_RRR
 #undef DEF_RI
 
 /*
@@ -335,6 +345,11 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
  * are of the proper type.
  */
 
+static void gen_add(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    gen_op_ttt(INDEX_op_add, type, dst, src1, src2);
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -364,6 +379,10 @@ static void gen_movi(TCGType type, TCGTemp *dst, int64_t src)
     DNI void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b)             \
     { gen_##NAME(TYPE, TTMP(a), TTMP(b)); }
 
+#define DEF_RRR(NAME)                                                   \
+    DNI void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b, TCGV c)     \
+    { gen_##NAME(TYPE, TTMP(a), TTMP(b), TTMP(c)); }
+
 #define DEF_RI(NAME)                                                    \
     DNI void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TINT b)             \
     { gen_##NAME(TYPE, TTMP(a), b); }
@@ -372,15 +391,11 @@ static void gen_movi(TCGType type, TCGTemp *dst, int64_t src)
 
 #undef DEF_R
 #undef DEF_RR
+#undef DEF_RRR
 #undef DEF_RI
 
 /* 32 bit ops */
 
-void tcg_gen_add_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_add, ret, arg1, arg2);
-}
-
 void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* some cases can be optimized here */
@@ -1488,11 +1503,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_add_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_add, ret, arg1, arg2);
-}
-
 void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_sub, ret, arg1, arg2);
-- 
2.53.0


