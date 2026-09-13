Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0D2C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aBB-0003Ie-Im; Sat, 12 Sep 2026 22:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aB7-0002tK-0q
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:49 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aB4-0001vw-Vm
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:48 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d8fb334ddcso11413385ad.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267365; x=1789872165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zjV8dpVScdCxYBKetwPRMlb2nQroKKRtJhfqznhd4nM=;
 b=C0O/XDSNKAtl1igrFMda2+GQWFggJmttQFeAe2S8C7g+9CXLkiSw2QwMNUJLk95N9K
 a5u8IIJqTiqsNAoEBBDyzEJ92+ci1sWlB61UMfOIGGa2CfyXJgEdsXE6nQDfcv17v/9M
 IYikGh82ZrDnHN7ptUuXAg6tHJlNNjr+gE4mw7TsQiScmiw52AWJOaBSlaSAA2CUIPtZ
 Xmo2leoxjFszQ8RvEgRykMAxldPhZ5cff/mrGNzon3fzewvgeoBO4COAWo05TcN7QoDX
 KjZ5U7txykbvnM2atSzRSaMG1wK9W4vMMWPGG56wtJuesUppDg27oJTeLIEYFK0M8I6y
 pU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267365; x=1789872165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zjV8dpVScdCxYBKetwPRMlb2nQroKKRtJhfqznhd4nM=;
 b=b+i3sFe+9qbJlQg1abJRfiQPcYgWx17rA5USPTHE0hyGillgM5ziGyawUqBN9InrUR
 J/iTO2pCIj98V/YQ5LPAOP+W1PCbe5fPG3jh1BCUN0nXy6rqxgHlgesfgJYzgYSOeNQ3
 KbHC3YoI2Lhv7EotbqGmm3HNt6qpMkUBOA+8rNNXdolk7EclJyAZkOaAE31BFdTy56wS
 Ko8LE5UHXVg8dqDe+99LKEFeVsHxMDOvEPAK8q9BgW+7ZS22Be6B7gMcWxyVrxg61Rhk
 NKFRO28qTpxizh4JOTJtPSiJhiC6oZuOH3bKhBSCh/MTiU7fzxx9txVwb+P4NquL8d0Q
 /xlQ==
X-Gm-Message-State: AFuF++mRPyVCFi97RNv79Ao3779YRNnEiHSOP2DZ6pSefiAGfalbLtAN
 XnGPitLhPXpZAm2PI0yqXTne17uD5nnmtcLwhijhaEpBUlGn0W/FeIeSiH0igwWpt0ySikmpXwp
 Oe4YIuOA=
X-Gm-Gg: AYBFou0eO/MpROemLGqJaFmIA64YKr5J9zJKCyrXneo7MIPAICIQgW8hhW53j4w8pNw
 xYElyMHBKmJ034fEZAwlNmLUgnHeGpXpmESrpIIzMfkEZB8jgPEJW8vWJ+DQyHhg8vr0iIljDwf
 TJkdP91xASODLI4iIPRyaN+FQaJp+MnIGWhscygGjPkONA69Iob5tg5bf9ISI0qMdiaYiya4m5/
 7I4wx5wWI8X/qxWAWgthfeCOTVv/Ndt/mgUdk5IY3FEsRQoV8BFA9H/J1sdTqRRUqN/GlHLH4Gx
 xKeYKbcbfPznBhLwHGuC/0La8LpDDXSRXMCUn7dkPcTULYZj+X+z7jwR17jvGNptD9/QQDlz3BH
 vfk2ec29pThDu2GiGQanpeclo+Xst/jBDoCOZG7OLa9Sik5aAaBA6RIXKhsQX+7fUVIT9exj2I7
 2KPoQgcLto7SCQUDiSSJB/IHLK/o6rGM5WGu7HowJiaOflnmUFzrCTiCh4ktaIXedCKJ/HxU5IX
 bW3byg=
X-Received: by 2002:a17:902:d2d0:b0:2c9:bf82:dd11 with SMTP id
 d9443c01a7336-2dd2a1e0f9bmr195553215ad.7.1789267365422; 
 Sat, 12 Sep 2026 19:42:45 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 59/86] tcg: Generic expansion of tcg_gen_deposit_*
Date: Sat, 12 Sep 2026 16:38:10 -1000
Message-ID: <20260913023837.741866-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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
index 97cb28b7100..d3c7e0e12b9 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -100,6 +100,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
     void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2, T3);
 #define DEF4(NAME, T1, T2, T3, T4) \
     void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2, T3, T4);
+#define DEF5(NAME, T1, T2, T3, T4, T5) \
+    void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2, T3, T4, T5);
 #define DEF6(NAME, T1, T2, T3, T4, T5, T6) \
     void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2, T3, T4, T5, T6);
 
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
index 023ab2fa7cb..a6f3b4bfefe 100644
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
     static void glue(gen_,NAME)(TCGType, T1, T2, T3);
 #define DEF4(NAME, T1, T2, T3, T4) \
     static void glue(gen_,NAME)(TCGType, T1, T2, T3, T4);
+#define DEF5(NAME, T1, T2, T3, T4, T5) \
+    static void glue(gen_,NAME)(TCGType, T1, T2, T3, T4, T5);
 #define DEF6(NAME, T1, T2, T3, T4, T5, T6) \
     static void glue(gen_,NAME)(TCGType, T1, T2, T3, T4, T5, T6);
 
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


