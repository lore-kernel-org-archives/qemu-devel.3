Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D39AC79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L58-0000wl-RV; Sat, 12 Sep 2026 06:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L52-0000Ro-BN
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:33 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4y-0008Oz-JW
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:32 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea50dc3so262486a12.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209326; x=1789814126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=B+8V8e7wOs1tD7+FAtuFdqurAMz6XOgd+GHMqukixMM=;
 b=xLT5Cpl/9zAlDEOUc48QOeTe6yU5VWelPFJnZM9WfPqgVpjdUWe5xLqJhC0tITlyBf
 OYLXT14u328E/UUc2sM1/5pak19njB14zX92BhEvjkoxz4Nv4EkjuF+dpO7S+K33CN7o
 zRSIUCH4ser70g9vOCB6fFhbeqxf84EheK05ZpVV53EdnLGSRtHy6fxPTuMa6/NCqlwm
 EJN6fDJ5OwyeRoICeRMydlOfwUZwXYAmzdmY3gdjAHUQjN0IM36MiYyaogN1Yjbu2BNu
 r/IySMxsswD6pssf1PqjC5dFK5YV82IRQkAf51Dnpknk9RAMZR/vLUB5BPQQMBX8XLw5
 6uTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209326; x=1789814126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=B+8V8e7wOs1tD7+FAtuFdqurAMz6XOgd+GHMqukixMM=;
 b=rs3botfeSYOyXiuRFZ4sp1qXMV4gSWa+ZyWbf155mhRPnjtsfjMfa55FJgzXK6ux8Z
 ZpGgIN5BsivQIn4obfMH8yovsMs/cc3UjMwJH5fmrQit8RLoeL/YzAc/oS5BD0ubdhNC
 rsl6fI3kAij745j0egOGUS9RuEjwKAoj+FaBqdetkoZOSJ/Tk9hEQqT/Ty3vXUZePih2
 MnUz+daYNImqWtxsnv23IO8Hw36amJ849ox2OiJw9mKSazkp8OQW+1n7/ua9eisiiuBa
 17TbfJ6ZxSyvMaKCFB4zFnG7nGPLgHRqKKJTc3jc/8NA3B+9+ILxTCo2wexJBE0mstYU
 Inzw==
X-Gm-Message-State: AFuF++loesyL7HszwA2SxPTfUWUwqAjgqE6fhXTXE8MQKJn9kQ9/KKtE
 LUXGy4hJdyU8LR6/YwFZih2SwqkN4c4EluqTVrmbgJbHKwxhSU2NI0GTLtuLbYttKsf0DiChkAw
 OpPKd2cA=
X-Gm-Gg: AYBFou07BMlfTEzaJSH7/jNGC2g1lHLsWYcZazwBTPIzKcDDpqYNRJT8BiGgO6BivJM
 OJwpouDy1XikNcAvH7SGJJopKoixjcSiSI381wupvydwf/EAECOlSezM12h0i8+Ofsvf/66dYNz
 bRPABDngg9exPOZAAbe4k9YQ21cDAqF0VkHmDP6Z8x4HVo2WNCHZK/coOogcuRoU/rjXTpBHCVZ
 8SxDZywlmIyd4TECh7quO6UYUMDEK8M93yyvTPfqxGzrkpCTgyU0DclrPOR0FF4hQbHGndKjhEy
 YSBDqhoTVVXtn93KrXirTcGMqtmWjaSUtSA0Xf6oHHMwg7oTFpFrUEIfGHr0BzM9AWVAx2+oHLf
 K3RO65hWzYzjkXF9Ok4rSKEU8aWFrCDb2FFDB4yAEImvdrbEpv7aSjIFTI+5t4bXxk+7rjkOTXb
 vScKmEM5HSYScditk8Nhjh7WfmYnILZxcihi9hhrKQ5MZGc3ifAkvKIIgc+CDcjmB5EtRYUFlJe
 pxzTbZM
X-Received: by 2002:a05:6a21:4d8c:b0:3d3:ad3c:49aa with SMTP id
 adf61e73a8af0-3db0e451d0fmr4085346637.24.1789209326067; 
 Sat, 12 Sep 2026 03:35:26 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 59/82] tcg: Generic expansion of tcg_gen_deposit_*
Date: Sat, 12 Sep 2026 00:31:03 -1000
Message-ID: <20260912103126.598030-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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
 include/tcg/tcg-op-common.h   |  9 ++---
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 66 +++++++++++++++++++----------------
 3 files changed, 42 insertions(+), 34 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index df7999e92cf..eae8bbd129d 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -126,6 +126,10 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
     void glue(glue(tcg_gen_,NAME),TEXT)(TCGCond a, TCGV b, TCGV c, \
                                         TCGV d, TCGV e, TCGV f);
 
+#define DEF_RRRUU(NAME) \
+    void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b, TCGV c, \
+                                        unsigned d, unsigned e);
+
 #include "tcg-op-def.h.inc"
 
 #undef DEF_R
@@ -139,11 +143,10 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #undef DEF_CRRR
 #undef DEF_CRRI
 #undef DEF_CRRRRR
+#undef DEF_RRRUU
 
 /* 32 bit ops */
 
-void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
-                         unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
                            unsigned int ofs, unsigned int len);
 void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
@@ -193,8 +196,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
-                         unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
                            unsigned int ofs, unsigned int len);
 void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index dd66a2ecd8d..415d10b9fe9 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -50,3 +50,4 @@ DEF_RRR(shl)
 DEF_RRR(shr)
 DEF_RRR(sub)
 DEF_RRR(xor)
+DEF_RRRUU(deposit)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8add0836952..61700f0d620 100644
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
@@ -352,6 +360,10 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     static void glue(gen_,NAME)(TCGType, TCGCond, TCGTemp *, TCGTemp *, \
                                 TCGTemp *, TCGTemp *, TCGTemp *);
 
+#define DEF_RRRUU(NAME) \
+    static void glue(gen_,NAME)(TCGType, TCGTemp *, TCGTemp *, TCGTemp *, \
+                                unsigned, unsigned);
+
 #include "tcg/tcg-op-def2.h.inc"
 
 #undef DEF_R
@@ -365,6 +377,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF_CRRR
 #undef DEF_CRRI
 #undef DEF_CRRRRR
+#undef DEF_RRRUU
 
 static void gen_extrh_i64_i32(TCGTemp *dst, TCGTemp *src);
 static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src);
@@ -575,6 +588,23 @@ static void gen_ctzi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
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
@@ -1032,6 +1062,11 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
                                         TCGV d, TCGV e, TCGV f)         \
     { gen_##NAME(TYPE, a, TTMP(b), TTMP(c), TTMP(d), TTMP(e), TTMP(f)); }
 
+#define DEF_RRRUU(NAME)                                                 \
+    DNI void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b, TCGV c,     \
+                                            unsigned d, unsigned e)     \
+    { gen_##NAME(TYPE, TTMP(a), TTMP(b), TTMP(c), d, e); }
+
 #include "tcg/tcg-op-def.h.inc"
 
 #undef DEF_R
@@ -1045,24 +1080,10 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 #undef DEF_CRRR
 #undef DEF_CRRI
 #undef DEF_CRRRRR
+#undef DEF_RRRUU
 
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
@@ -1810,21 +1831,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
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


