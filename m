Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1662C88E59
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L5b-0003Di-Hf; Sat, 12 Sep 2026 06:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L5H-0001wu-4V
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:47 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L5D-0008VF-Vf
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:46 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea4ae2dso569055a12.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209342; x=1789814142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=v2ow9fwckZthbz5r2DXkFsS1b9Pk3wQEEzB6yKoQ8nw=;
 b=ogDlXwSjCDC70Fzb7Uu9ufqbS6HabSdQ3NpvnZDOwthz6Ch4uyJnI8qXeDl06csS8n
 mdyaCOMxOTlu0LXNQUPfeIhiUqTDAzQXjucsEAopaZywdyNd4udFT1co7Oj09cbQ/uXu
 LovrRtY4nbivrBqzJLdCNSyC7yrN64Ew28dB9PlhZEoZ/Xhi2M52vG/IdA+ekwoitK/e
 dIBqCuPqVnJzLBbAfFNHMjeVTapNC35swJER8JqXJGn4kPyao76lhCEYxnU7Ok310Lmr
 CtSNUSKkhmg5F567pEc7fZVosMk1V2h37ORkhyncP8XYPhuTy2/qj9vMLbVvqsFsa4ZB
 u2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209342; x=1789814142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=v2ow9fwckZthbz5r2DXkFsS1b9Pk3wQEEzB6yKoQ8nw=;
 b=DK/w8FKC9LTDq3w86fqKeOhF+KmmKZ24Jm3Y9j7ejbqcv7jY7b5TgeKvNlkUJMCafY
 wJU5qmWJcJpnMEj52cA22o91vyMXjRkhv44L6BaohIFAFLoP/wPOsuztuGxNfvPZGAis
 hcajoar7vVjYdp2NavuNL6sXUetkxXv6EIgRmuEbNt7P31PMu9Y4k/OgZ851SRXXCF/4
 YAw8pjxx1E8jkULmO4cwzgFi/S7KqnRyb5/yQPVvAV7MWXJvaLkz9XNaA4Vw2gr7YL1K
 sdKYFkIWvH24yEd7oWcZ3O6UboX/KQhLxXsfKdPP4zxOA5vT+0rbhb+qfr+GqfKrOiaB
 cLPw==
X-Gm-Message-State: AFuF++lV9h5VfKVklx32yaCz2rjtdV4ur8U+PZH9VRCNpb5aYWALM8Yr
 OWfQ7PxKcMDQRsXKCqgWcmXEepQNgw1Rt72LGE5dWnWP8wwzm0Xy+nrR0sBhHbygdlYrSv3pB13
 h3xlnYOE=
X-Gm-Gg: AYBFou1oZFgsSSt+g4P223Gi/z2MQ5xqLvT4etJApq/VD3dpSAc3hSk7tH32VRuAePu
 aZt34xSmwSDtVix/3L/M5C9tcFOWCff40dmbzjNmRsQVFhMkX28zIvmw39R8iy6MLlkjP8ezCL3
 F17/2Dzclc6LUTV9/35GyzYoXjHVKNwlNvTOywNIoT+VFGec/mG8c9BNQ3gdwAR/5/8S+unLUxD
 1Rp6dX/EIlhmUT/b3p6n41OJqIAORVI8/maTwwLrls2truRSJfCHrX2rmNGBh/e0O4puupGNP45
 +LBHdVh5BeBwQJoEqs3p3pl0IH4MyyRfyuG24z4GcNbCgbQHYG6sYPCADnAO+xnD+taNoP32gsm
 Ww4xJbgirTsLE5xXoujOUX3QBweb/ZEch6vA3OxND5mRumm+Y4sE6deMP92oMQnjIv37FsYuK2q
 62eVUBFmYP9YzyY/I6UchHbETz1dy817LJBw9dIcc+411ovA+Se6zotrwcH95TvcyWMADitxfCz
 Nogta8=
X-Received: by 2002:a05:6a21:6b18:b0:3c3:b57b:627d with SMTP id
 adf61e73a8af0-3daed20b6f9mr15383537637.12.1789209342387; 
 Sat, 12 Sep 2026 03:35:42 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 76/82] tcg: Generic expansion of tcg_gen_extract2_*
Date: Sat, 12 Sep 2026 00:31:20 -1000
Message-ID: <20260912103126.598030-77-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h   |  8 ++--
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 84 +++++++++++++----------------------
 3 files changed, 35 insertions(+), 58 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 903949e18b8..489121d478c 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -129,6 +129,9 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #define DEF_RRUU(NAME) \
     void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b, unsigned c, unsigned d);
 
+#define DEF_RRRU(NAME) \
+    void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b, TCGV c, unsigned d);
+
 #define DEF_RRRUU(NAME) \
     void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b, TCGV c, \
                                         unsigned d, unsigned e);
@@ -147,12 +150,11 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #undef DEF_CRRI
 #undef DEF_CRRRRR
 #undef DEF_RRUU
+#undef DEF_RRRU
 #undef DEF_RRRUU
 
 /* 32 bit ops */
 
-void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
-                          unsigned int ofs);
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
@@ -184,8 +186,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
-                          unsigned int ofs);
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 19e1eb38dfb..187cffbdf4d 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -60,6 +60,7 @@ DEF_RRR(umax)
 DEF_RRR(umin)
 DEF_RRR(ussub)
 DEF_RRR(xor)
+DEF_RRRU(extract2)
 DEF_RRRUU(deposit)
 DEF_RRUU(deposit_z)
 DEF_RRUU(extract)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 49c187c3784..3fd9d8bb92c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -230,20 +230,6 @@ static void DNI tcg_gen_op4_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                 tcgv_i64_arg(a3), tcgv_i64_arg(a4));
 }
 
-static void DNI tcg_gen_op4i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                 TCGv_i32 a3, TCGArg a4)
-{
-    tcg_gen_op4(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), a4);
-}
-
-static void DNI tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                 TCGv_i64 a3, TCGArg a4)
-{
-    tcg_gen_op4(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), a4);
-}
-
 /* Generic ops.  */
 
 void gen_set_label(TCGLabel *l)
@@ -336,6 +322,10 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     static void glue(gen_,NAME)(TCGType, TCGTemp *, TCGTemp *, \
                                 unsigned, unsigned);
 
+#define DEF_RRRU(NAME) \
+    static void glue(gen_,NAME)(TCGType, TCGTemp *, TCGTemp *, \
+                                TCGTemp *, unsigned);
+
 #define DEF_RRRUU(NAME) \
     static void glue(gen_,NAME)(TCGType, TCGTemp *, TCGTemp *, TCGTemp *, \
                                 unsigned, unsigned);
@@ -354,6 +344,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF_CRRI
 #undef DEF_CRRRRR
 #undef DEF_RRUU
+#undef DEF_RRRU
 #undef DEF_RRRUU
 
 static void gen_extrh_i64_i32(TCGTemp *dst, TCGTemp *src);
@@ -728,6 +719,23 @@ static void gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
     }
 }
 
+static void gen_extract2(TCGType type, TCGTemp *dst, TCGTemp *lo, TCGTemp *hi,
+                         unsigned int ofs)
+{
+    unsigned width = tcg_type_size(type) * 8;
+
+    tcg_debug_assert(ofs <= width);
+    if (ofs == 0) {
+        gen_mov(type, dst, lo);
+    } else if (ofs == width) {
+        gen_mov(type, dst, hi);
+    } else if (lo == hi) {
+        gen_rotri(type, dst, lo, ofs);
+    } else {
+        gen_op_ttti(INDEX_op_extract2, type, dst, lo, hi, ofs);
+    }
+}
+
 static void gen_extrh_i64_i32(TCGTemp *dst, TCGTemp *src)
 {
     gen_op_tt(INDEX_op_extrh_i64_i32, TCG_TYPE_I32, dst, src);
@@ -1232,6 +1240,11 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
                                             unsigned c, unsigned d)     \
     { gen_##NAME(TYPE, TTMP(a), TTMP(b), c, d); }
 
+#define DEF_RRRU(NAME)                                                  \
+    DNI void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b, TCGV c,     \
+                                            unsigned d)                 \
+    { gen_##NAME(TYPE, TTMP(a), TTMP(b), TTMP(c), d); }
+
 #define DEF_RRRUU(NAME)                                                 \
     DNI void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b, TCGV c,     \
                                             unsigned d, unsigned e)     \
@@ -1251,6 +1264,7 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 #undef DEF_CRRI
 #undef DEF_CRRRRR
 #undef DEF_RRUU
+#undef DEF_RRRU
 #undef DEF_RRRUU
 
 static void gen_ext(TCGType type, TCGTemp *dst, TCGTemp *src, MemOp mop)
@@ -1264,27 +1278,6 @@ static void gen_ext(TCGType type, TCGTemp *dst, TCGTemp *src, MemOp mop)
     }
 }
 
-/* 32 bit ops */
-
-/*
- * Extract 32-bits from a 64-bit input, ah:al, starting from ofs.
- * Unlike tcg_gen_extract_i32 above, len is fixed at 32.
- */
-void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
-                          unsigned int ofs)
-{
-    tcg_debug_assert(ofs <= 32);
-    if (ofs == 0) {
-        tcg_gen_mov_i32(ret, al);
-    } else if (ofs == 32) {
-        tcg_gen_mov_i32(ret, ah);
-    } else if (al == ah) {
-        tcg_gen_rotri_i32(ret, al, ofs);
-    } else {
-        tcg_gen_op4i_i32(INDEX_op_extract2, ret, al, ah, ofs);
-    }
-}
-
 void tcg_gen_ext_i32(TCGv_i32 dst, TCGv_i32 src, MemOp mop)
 {
     gen_ext(TCG_TYPE_I32, tcgv_i32_temp(dst), tcgv_i32_temp(src), mop);
@@ -1295,6 +1288,8 @@ void tcg_gen_ext_i64(TCGv_i64 dst, TCGv_i64 src, MemOp mop)
     gen_ext(TCG_TYPE_I64, tcgv_i64_temp(dst), tcgv_i64_temp(src), mop);
 }
 
+/* 32 bit ops */
+
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
@@ -1831,25 +1826,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-/*
- * Extract 64 bits from a 128-bit input, ah:al, starting from ofs.
- * Unlike tcg_gen_extract_i64 above, len is fixed at 64.
- */
-void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
-                          unsigned int ofs)
-{
-    tcg_debug_assert(ofs <= 64);
-    if (ofs == 0) {
-        tcg_gen_mov_i64(ret, al);
-    } else if (ofs == 64) {
-        tcg_gen_mov_i64(ret, ah);
-    } else if (al == ah) {
-        tcg_gen_rotri_i64(ret, al, ofs);
-    } else {
-        tcg_gen_op4i_i64(INDEX_op_extract2, ret, al, ah, ofs);
-    }
-}
-
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
 {
-- 
2.53.0


