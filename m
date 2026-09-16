Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6ECCC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pNf-0007JE-UB; Wed, 16 Sep 2026 09:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNQ-0006oN-Ud
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:44 -0400
Received: from mail-oo2-x0d.google.com ([2607:f8b0:4864:31::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNO-0001Sv-30
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:40 -0400
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6bcc0c495efso568864eaf.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564116; x=1790168916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=V2A1YfSR2UwdlFtstVbStfy+u0Luf+pJp79dO7M8aJY=;
 b=lHVomeawYSB67+Vj0K5cKqKSY2k7KHiR1rl0rAa5eVKjdQQoFtcciwKOR7izmgmU7A
 0d4nz85uts4h00nAXaNJe19uPZNpuQIGWU/1uHywsQRLJfGb9Xko/MB3dQGAUJxz/XWT
 mEtyPyzNlb+QpqtcSpTxvVUKcyzLZuneBaLqbzuj0Ac6sxQjK/bDLUL/ySadBAVQKVsu
 E69BoUcUu1cSKA32ILcZPovO612/AjhMXhW7w1e8IeL137e2KkBPui8vv8IhF8DoTCGD
 AtVMGVnj/VpQPRXRcgW+Bm1VilocIjZEDt8RuwzEOxlLY4Xy8Hi955lDQOEbCQe0qn+R
 1wDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564116; x=1790168916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=V2A1YfSR2UwdlFtstVbStfy+u0Luf+pJp79dO7M8aJY=;
 b=XgF2Rt6ZoyTcb9QTLTAE9lBRHt1IKEqwWfujkko1KYG1Qz4TihULeTmBxYcC0rmvT8
 vhwcxKy7GzJtSlz3aMCbPlp2gArUt7LysgB06OhMCGUp3mDR2PPcwODvxmBj6+EGjDfl
 J2fBNk+SyRJQuXFKf7Eznmf/pNscR5ODWE3I6sx5p2xqz2mXIxIPRkSG+jvqZzcDN+xX
 PBE2RuNMuEv0yaHEWFtXJBjA6n0AIbO+7DdO2ro57KNmzwlHOuk/FxQhS4ovK9dxi1wM
 BFBBuZkU8l+8+tts0NO0hlTJzDIXvf/gXScJ/oRcgw8uDHWN4I/jUW5icFmgXhjHBfnx
 kpdA==
X-Gm-Message-State: AFuF++kx44MTk/tfWIc+oabn1VwBSDvofcKSDq343UW3nG0MAlaZadNk
 HRgg+gFU+wf4h+jeilVrejcysbyk+cvRhuU35YZxsHyJQvX88YsqfEnKxYOqdMUMAk3AVgaI6O7
 CSvtuLZ8=
X-Gm-Gg: AYBFou11IdWyIeEhE59h3oDybwiuXBY1vNKIAlsxy+U3imP+7UP+JBSWdX4nY6DlAlH
 l2KM8k/mtMiIEeHAexr2phuGmN10dAHdxUjfdC2NDdfPZ9P1d/ZZ3bIGGdxXySS2xR8tisDnB0L
 Ily0KCCcWNyXOElvv2pn/XEXDKGubNavIuUBqMflf7gp8sWRKYnfew09WXfoeP6FNnM0+U69mDf
 e1GB6nqNorhL4cI7ZQJnuR7yvFrJHoOVTK00jpyGCwMz+L2EL21T29nGondM7cBgyCqh0BCzR0o
 zU6UNsLPk0S7NHzolKLxhjJB7Zy17JoGC0jJcHV2RRpUsSUFnMGQRXl7vGeTQiQzWn5ChKV59R1
 +cGcOJ2GhI0c3vBV5TXDNtW0U1P7WDiVtGczvr6T0/DxS7+yNdCearrKPuFkqHwzhJU9BVJBo0m
 4/xgW0sCYk5AQ7ZmhqShtIn1DA/4PyxjsPKvnhNPeQqg8IgxeDpfv3bbtqmJUXItxfK/cGtdB/s
 bAwsEU=
X-Received: by 2002:a4a:ee0c:0:b0:6b7:8415:d78b with SMTP id
 006d021491bc7-6c7d3206a47mr2633439eaf.54.1789564115479; 
 Wed, 16 Sep 2026 06:08:35 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 62/92] tcg: Generic expansion of tcg_gen_deposit_*
Date: Wed, 16 Sep 2026 03:03:37 -1000
Message-ID: <20260916130409.3382710-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 include/tcg/tcg-op-common.h  |  7 ++--
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 66 ++++++++++++++++++++----------------
 3 files changed, 40 insertions(+), 34 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 2b65e996acc..b9118a6df08 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -100,6 +100,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2, T3);
 #define DEF4(NAME, T1, T2, T3, T4) \
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2, T3, T4);
+#define DEF5(NAME, T1, T2, T3, T4, T5) \
+    QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2, T3, T4, T5);
 #define DEF6(NAME, T1, T2, T3, T4, T5, T6) \
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2, T3, T4, T5, T6);
 
@@ -125,12 +127,11 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #undef DEF2
 #undef DEF3
 #undef DEF4
+#undef DEF5
 #undef DEF6
 
 /* 32 bit ops */
 
-void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
-                         unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
                            unsigned int ofs, unsigned int len);
 void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
@@ -180,8 +181,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
-                         unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
                            unsigned int ofs, unsigned int len);
 void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 57d6f07b907..a2244bedeb2 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -13,6 +13,7 @@ DEF3(clzi, TCGV, TCGV, TINT)
 DEF2(ctpop, TCGV, TCGV)
 DEF3(ctz, TCGV, TCGV, TCGV)
 DEF3(ctzi, TCGV, TCGV, TINT)
+DEF5(deposit, TCGV, TCGV, TCGV, unsigned, unsigned)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index de42f536b80..4cda5496077 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -127,6 +127,14 @@ static TCGOp *gen_op_ttti(TCGOpcode opc, TCGType type,
     return tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2), a3);
 }
 
+static TCGOp *gen_op_tttii(TCGOpcode opc, TCGType type,
+                           TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
+                           TCGArg a3, TCGArg a4)
+{
+    return tcg_gen_op5(opc, type, temp_arg(t0), temp_arg(t1),
+                       temp_arg(t2), a3, a4);
+}
+
 static TCGOp *gen_op_ttttt(TCGOpcode opc, TCGType type,
                            TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
                            TCGTemp *t3, TCGTemp *t4)
@@ -326,6 +334,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     QEMU_ARG_NONNULL static void glue(gen_,NAME)(TCGType, T1, T2, T3);
 #define DEF4(NAME, T1, T2, T3, T4) \
     QEMU_ARG_NONNULL static void glue(gen_,NAME)(TCGType, T1, T2, T3, T4);
+#define DEF5(NAME, T1, T2, T3, T4, T5) \
+    QEMU_ARG_NONNULL static void glue(gen_,NAME)(TCGType, T1, T2, T3, T4, T5);
 #define DEF6(NAME, T1, T2, T3, T4, T5, T6) \
     QEMU_ARG_NONNULL static void glue(gen_,NAME)(TCGType, T1, T2, T3, T4, T5, T6);
 
@@ -341,6 +351,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF2
 #undef DEF3
 #undef DEF4
+#undef DEF5
 #undef DEF6
 
 /*
@@ -364,6 +375,11 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     { gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b),                  \
                  glue(C_,T3)(c), glue(C_,T4)(d)); }
 
+#define DEF5(NAME, T1, T2, T3, T4, T5)                                  \
+    void glue(glue(tcg_gen_,NAME),TEXT)(T1 a, T2 b, T3 c, T4 d, T5 e)   \
+    { gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b), glue(C_,T3)(c),  \
+                 glue(C_,T4)(d), glue(C_,T5)(e)); }
+
 #define DEF6(NAME, T1, T2, T3, T4, T5, T6)                              \
     void glue(glue(tcg_gen_,NAME),TEXT)(T1 a, T2 b, T3 c, T4 d, T5 e, T6 f) \
     { gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b), glue(C_,T3)(c),  \
@@ -375,6 +391,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #define C_int64_t
 #define C_TCGCond
 #define C_TCGLabelPtr
+#define C_unsigned
 
 #define TCGV  glue(TCGv,TEXT)
 #define TEXT  _i32
@@ -404,11 +421,13 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef C_int64_t
 #undef C_TCGCond
 #undef C_TCGLabelPtr
+#undef C_unsigned
 
 #undef DEF1
 #undef DEF2
 #undef DEF3
 #undef DEF4
+#undef DEF5
 #undef DEF6
 
 static void gen_extrh_i64_i32(TCGTemp *dst, TCGTemp *src);
@@ -620,6 +639,23 @@ static void gen_ctzi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     gen_ctz(type, dst, src1, tcg_constant_internal(type, src2));
 }
 
+static void gen_deposit(TCGType type, TCGTemp *dst, TCGTemp *src1,
+                        TCGTemp *src2, unsigned ofs, unsigned len)
+{
+    unsigned width = tcg_type_size(type) * 8;
+
+    tcg_debug_assert(ofs < width);
+    tcg_debug_assert(len > 0);
+    tcg_debug_assert(len <= width);
+    tcg_debug_assert(ofs + len <= width);
+
+    if (len == width) {
+        gen_mov(type, dst, src2);
+    } else {
+        gen_op_tttii(INDEX_op_deposit, type, dst, src1, src2, ofs, len);
+    }
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -1028,21 +1064,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
-                         unsigned int ofs, unsigned int len)
-{
-    tcg_debug_assert(ofs < 32);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 32);
-    tcg_debug_assert(ofs + len <= 32);
-
-    if (len == 32) {
-        tcg_gen_mov_i32(ret, arg2);
-    } else {
-        tcg_gen_op5ii_i32(INDEX_op_deposit, ret, arg1, arg2, ofs, len);
-    }
-}
-
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
                            unsigned int ofs, unsigned int len)
 {
@@ -1790,21 +1811,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
-                         unsigned int ofs, unsigned int len)
-{
-    tcg_debug_assert(ofs < 64);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 64);
-    tcg_debug_assert(ofs + len <= 64);
-
-    if (len == 64) {
-        tcg_gen_mov_i64(ret, arg2);
-    } else {
-        tcg_gen_op5ii_i64(INDEX_op_deposit, ret, arg1, arg2, ofs, len);
-    }
-}
-
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
                            unsigned int ofs, unsigned int len)
 {
-- 
2.53.0


