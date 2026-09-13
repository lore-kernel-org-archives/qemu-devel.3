Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6C8C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a7a-0008R4-BU; Sat, 12 Sep 2026 22:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7I-0008OG-27
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:38:53 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7E-0000xh-SU
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:38:51 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d747ed1368so7875335ad.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267127; x=1789871927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Oc3gZdzZ6V/gKJJcVui/o5p2RYR/bmek+hg7KqMWp18=;
 b=ssjqtijKMgstJzFPTEMhZ9BRc8WJA/Sdo6rnk4MJavruGBLJ1HNUnsYXLyzrSOT806
 XWSZdhNO9OZq4EHLAkJ+YeIztv/HQTq1fSOkn0sh+R1VFIhfVLNHvzERmD0/AwsgIzHo
 f2N6EB4q4KAGda9ymyebkA+o6fmNPhSuEtDPwUv2LnVDlvkHcMqblwVG4Olu3ICUdYGd
 oW7QuttswLBdx6uxIfJPrMe4vLHDYYczz7xCopsy3Gr3WD8sx+7Ecrek7eLYT0EUxO+m
 jVmRXyd85L95Q3dzJGp2nchh8kJofVFetAAadwxWOjAKJnDfErjJ2wGSWwWoaU5GdlE0
 W7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267127; x=1789871927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Oc3gZdzZ6V/gKJJcVui/o5p2RYR/bmek+hg7KqMWp18=;
 b=JdT1LjPQ67ewAIcWcFxGgkrspkI0wlHV5Rn+GTJsoNMAr8G0H54vQKpQLfXEJ1GM3n
 gTMfu6/HNVfyrXf1X1wypsiNbeZFcP6mRY20M6Tfs7CpEBOw52CsiJDdygOCl58p/shr
 EI5AgcP1VyMioRXr5GiDb0kPu9Qh47o6Cht73z3wYRsgkcf+JG8aE/2mdJtDEIDmDwUu
 1dHRLi/agzlkIrrCTN9tyJARtE1wlGWfEQepakOLBL03EUc5gqsw+KQ3/kntpV0JzjX5
 3gwujWY/HDdQf94jmOE1NLXwHdx91FPMOu6erly42llCHDDRbTC1MXgmQyobeojJWOia
 x2Cw==
X-Gm-Message-State: AFuF++l6vhYv1GZqwxEtW/Wlyj2i3xIxTqbWC0fgx85tVfjQomq+qEUJ
 qYahlMBsGFPdocjJdb8odWaSz9MJRX7Lko6QxK9dbmaz6pIBRUY8XzTbed5caimJsr3Fkq4KKRf
 qaCrH
X-Gm-Gg: AYBFou3Zrn21wi48YV8IdXYEQEbG9Mn9AU3L45akCuZLkMm6dFEVKzChgLBBMb39LsB
 4hJxlW0MYuTv+us33NOLaUScfOgV/cwtc7JTLQkR38etIdpopy3s92z611yrp4YR3oR1CCQh/K7
 g0ZDSw8KHWx/2D768onKeTFhqxAixsDBf0MTdGVywr5neMqURgDLLV1T3qfSxH29RUd9q7MDZdd
 pD4sCZIV2Y49ZJ8zaH2TjQG5C642pYxSQyDyYyH4W1konVKhxvXC80k9bNP0cI1o4tQym5Gw9iQ
 VMoDpCbnudkPITuHuO4ky4XWsB78qHuyCi2JN64L/9Dy92Lculz3zTFuXlVM6AJqbQAuMMecuBb
 19fcgruN2BOe8OX0H4+mWkbFbTXLn2xr//bZpUVrqU0BHTjlQR7b3qyw8zHX2mB6s2cHeTg7D2P
 imXL1qhodwA7c3tj1ZRSCDc3KttACU0x+bdscEPR9xbiiv/738Wuev5Q3G4WpePNliHS/uz6K56
 n3gR4o=
X-Received: by 2002:a17:90b:4990:b0:38f:de97:b06 with SMTP id
 98e67ed59e1d1-39dbbe8b896mr9227740a91.5.1789267127450; 
 Sat, 12 Sep 2026 19:38:47 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.38.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:38:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/86] tcg: Generic expansion of tcg_gen_add_*
Date: Sat, 12 Sep 2026 16:37:17 -1000
Message-ID: <20260913023837.741866-7-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  5 +++--
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 29 +++++++++++++++++++----------
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 1ef342e6c44..2933db9f869 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -96,6 +96,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
     void glue(glue(tcg_gen_,NAME),TEXT)(T1);
 #define DEF2(NAME, T1, T2) \
     void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2);
+#define DEF3(NAME, T1, T2, T3) \
+    void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2, T3);
 
 #define TCGV  glue(TCGv,TEXT)
 #define TEXT  _i32
@@ -117,6 +119,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 #undef DEF1
 #undef DEF2
+#undef DEF3
 
 /* 32 bit ops */
 
@@ -210,7 +213,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_add_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -315,7 +317,6 @@ void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_add_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 6ff97260dc6..deb3484fc60 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: MIT */
 
+DEF3(add, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 88f06afafab..243f56493df 100644
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
@@ -318,6 +324,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     static void glue(gen_,NAME)(TCGType, T1);
 #define DEF2(NAME, T1, T2) \
     static void glue(gen_,NAME)(TCGType, T1, T2);
+#define DEF3(NAME, T1, T2, T3) \
+    static void glue(gen_,NAME)(TCGType, T1, T2, T3);
 
 #define TCGV  TCGTemp *
 #define TINT  int64_t
@@ -329,6 +337,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 
 #undef DEF1
 #undef DEF2
+#undef DEF3
 
 /*
  * Templated operations.
@@ -342,6 +351,10 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     void glue(glue(tcg_gen_,NAME),TEXT)(T1 a, T2 b)                     \
     { gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b)); }
 
+#define DEF3(NAME, T1, T2, T3)                                          \
+    void glue(glue(tcg_gen_,NAME),TEXT)(T1 a, T2 b, T3 c)               \
+    { gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b), glue(C_,T3)(c)); }
+
 #define C_TCGv_i32      tcgv_i32_temp
 #define C_TCGv_i64      tcgv_i64_temp
 #define C_int32_t
@@ -376,6 +389,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 
 #undef DEF1
 #undef DEF2
+#undef DEF3
 
 /*
  * Generic expansions for templated operations.
@@ -383,6 +397,11 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
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
@@ -402,11 +421,6 @@ static void gen_movi(TCGType type, TCGTemp *dst, int64_t src)
 
 /* 32 bit ops */
 
-void tcg_gen_add_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_add, ret, arg1, arg2);
-}
-
 void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* some cases can be optimized here */
@@ -1514,11 +1528,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
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


