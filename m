Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06318C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pJc-00012S-Ta; Wed, 16 Sep 2026 09:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJQ-00010X-6m
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:32 -0400
Received: from mail-oo2-x13.google.com ([2607:f8b0:4864:31::13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJO-0000Hr-CV
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:31 -0400
Received: by mail-oo2-x13.google.com with SMTP id
 006d021491bc7-6b4bff33d18so494927eaf.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563869; x=1790168669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SyocRgG0UfzspRA+5PY08nnvLtfyxVlX/4MO3LYTw6M=;
 b=PKWpfE6QLxmKXIlbBftiqn2Mvt/zf5Tis4ZTD3OsYAwfRSBskNoS+Lj9/dotxggZdc
 vNn75vcBQmTBxnyYQvOg4YP0z/KoiyK4AYOj8bI23wtOAjt/ABvH177tQmNiB67+umUN
 9PVECYae5NpVjHmWPUqM6NvnJkLUfwINKcS7TBkTrrCHTevN9tliSiqHwf0uq1dNWJUD
 mYz4b6/nuyfVxlWMVNxYtWX2Yt7lsi/7YdyjelxlOCO7mF/5UUOPIFYvJEihf1bsk6Ur
 z2utQ8U92VGatfTJjguhQ2nxrJQOQ/vjkgoJ5t19QfbS8YhvLPK36TvNammFRIJpOGNr
 G1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563869; x=1790168669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SyocRgG0UfzspRA+5PY08nnvLtfyxVlX/4MO3LYTw6M=;
 b=P9+CUZ7jeyX0ZVOYyKYnCytgbEVhAk7vH8xU8JGsLsZjJUCpA0Wqe7rT7Fc8qio/vN
 8utP81+12++lcV3jElYy1EPKbSdbfj0uUDi1c8WK6z/YxkPyB6fArH1dcFzXSF31BMYi
 VPHTQ0PkPYYGoIMPiMYuyjhvill2JOvEVeMIDKSbokAiKND0xSV5XKXTHgQ93oquozk+
 3Xjm0b/oP/j5RlNHL6TaN3VKbo1kRxRRWhnGwPVcUVqI6XxeEYmIElTXiJFvL7maIhIx
 gciihmmgSTA3BbZ1zkuxlMOl10ffBfdrCOnV/XkMYxUyIjuRIJnlFTnwqyW1FVdgwvoR
 PgKQ==
X-Gm-Message-State: AFuF++mr67/9qdPTY+sDqZF/w3dVF0xYjSaRqCcwQZbkol4oA9o+cOE1
 O1kDn0CsEOWJOCWweX14/sjWy+c0Utt5ZyoENe5qLPLRDCvhl9n7KaWFwL6nbyrWzLeVCDSdVI/
 e6YZpiD4=
X-Gm-Gg: AYBFou2LTsfPKXNFBfMr1iRwJmIHbtly5Wd4xTIa/h1gMSOjPEWtmnx+d21Ep5zs1tD
 0ayda7CRkPdvTdLSqAtP0xGNlsyDS44So95PN2wB+XbkBLmpvjyCJfTCMqjuEvD/nEqA95GtiUM
 WgveM+f3PeIxp7dFL7w82mpu3LGYqNUkLMfpCoi2SvwRF0IDByfF+a5YEVdJbfNuHBpLxDMo3rv
 p1K51i3eConed+IPY/EMRzGEIceXWQXhybU21wAcYSWxq6fdBYHdVtNN9/cHGf3QOjedKozAv4f
 njGmJaCtERVJhuQSJKDLHYLEhSxNbe7Rdms8hbu0oYt6WfnCV9tbtLUyvBOPOdD0NDhszbXlDwS
 CtRKZfG6L6v7Xlbzv8qd93L1BPCGpiaohRu6lqHncM6tgj5GSM+nyndDfFkVHqx9vIdObRvC/FR
 lCwvRO/rVfY2zcJsCzlgVMzmHWM84CBsP3xXhhLnEaJnzF+8g4Bn07/JcQeAPSxxMI1SsQsY3Ah
 TYNcZ4=
X-Received: by 2002:a05:6820:1ca3:b0:6b7:8396:f3d1 with SMTP id
 006d021491bc7-6c7d3fec586mr2539593eaf.51.1789563868763; 
 Wed, 16 Sep 2026 06:04:28 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.04.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:04:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/92] tcg: Generic expansion of tcg_gen_add_*
Date: Wed, 16 Sep 2026 03:02:44 -1000
Message-ID: <20260916130409.3382710-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::13;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x13.google.com
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
 include/tcg/tcg-op-common.h  |  5 +++--
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 29 +++++++++++++++++++----------
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e1c87792a69..f1dfa4011b0 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -96,6 +96,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TEXT)(T1);
 #define DEF2(NAME, T1, T2) \
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2);
+#define DEF3(NAME, T1, T2, T3) \
+    QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2, T3);
 
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
index a6072f362e3..9846cb13331 100644
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
     QEMU_ARG_NONNULL static void glue(gen_,NAME)(TCGType, T1);
 #define DEF2(NAME, T1, T2) \
     QEMU_ARG_NONNULL static void glue(gen_,NAME)(TCGType, T1, T2);
+#define DEF3(NAME, T1, T2, T3) \
+    QEMU_ARG_NONNULL static void glue(gen_,NAME)(TCGType, T1, T2, T3);
 
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


