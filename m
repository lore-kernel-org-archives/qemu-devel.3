Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18C5C88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aEg-0001zE-Ur; Sat, 12 Sep 2026 22:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aEQ-00014H-0j
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:46:14 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aEN-0002nq-Sa
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:46:13 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-8558c0b26a8so1605712b3a.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267570; x=1789872370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6lW2eN128ACNqnvbI0rS07nLycBakx4eZvKKQdqkEak=;
 b=Pf6yDGgljjN4unTgeJrb/wBzN3ElQLjxm4EiX9M5HL4x+DaVU3sqjIUzMBd2UYkyU3
 aXxNqU3lXkMOYlZ9roC0TOifmeUY/M5wGcBgJWVf8Zpt+KVFNSCMvf7CxlHFSFcsy0hV
 PXlnCaVMMPGbKrlgh8OyEzyU/yrYeDz7QDG/X5RfrQdm2DeA0wtjYpUZqQMO7TEhJ2sX
 fYzlnWXf8vfFlCBqq/MJFks+4xi2cdD0Ic9W59xUgu4h1+Jpu1q0+kzr0y2BTteLJgNj
 ODC4gsRVUM/EcWhZSvGzZnJPI7I2XPz5cqOJy2KBmAsXZ2hGSX1xAFD+B/mSuZ3ZXkuL
 69ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267570; x=1789872370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6lW2eN128ACNqnvbI0rS07nLycBakx4eZvKKQdqkEak=;
 b=pfodWOxtb9aJiT/9ItsUVqbwR/PF/PRr5M26P8vkEjILN7SwXcKzfGIYMSwLuaUtru
 LK0iK7VVqAo/Q9MUZjUYCOGDbQlxdcFlQaQh//qfoRBLQtJGjdRX7G9aYwNtgr6XJu1q
 0CX3FaOxRrh5f3LTl/r9ncMJuGs5c/LVZ05R9t02gmgeFsiGHvnF7PyrV8IQ3WNQ7JBZ
 n6J16BqbCsQPBtKGtQzcb3VJNa88DUpY8MAKsAeKqU8WvXepipW5W/ZY5PHFkmCzh5XZ
 wcdMj/dPzNzGn4WOQi9/pHMEJMu4tnMqYEWQ6DewrG1KkN1XL6xa2zm5YmlN2OzwNDA7
 o0Bg==
X-Gm-Message-State: AFuF++lIsHg2mXy7UnKtmS9180nsU6dBB0BUQjM+JvzNBBDBoab54x3j
 9IcQj9vB8AP2+1WiToJe28C2QHR/SZ9prX/9kssTDgKbgoFNuSP3cXgp2ibxFC6H3+JBSPYrI+F
 3MVqSxDo=
X-Gm-Gg: AYBFou3NUTkotX8vrLh7myKqiGHjoxw/lll39xsqUXWZ+AIj7SQkwO/x+31KGxEal8B
 h1IO3zBLb2D9i7CmPH07SyMZJbeoScvw86xjDeHVDTccJT7sqnROyGWTe0k0q4hBLWSqQcMIkoO
 eR1EBDhCBf4F5/3iYJ+vK/4lUqhQc3mxJ+b60F3PVmXKT8t0atulD4ayH+WD5yVLDW+/GOi4rHN
 QHP+4ipZKwfwjueF9lX2uJQH/9d3GnA1m6UiLh5B1s+Bct535jA3dycWvBPhjLMuUtYFI90m62N
 PcXuPKWqcDOE3yGgFxYHygWyKwLOCcbazAhtPU3HKKBpCeaaDSVltPtJ0NxYEd/uDAaYf3fRiKU
 LwPxV3Av3kc44pILf6bfZXREnDiKFSK/fFeA+omsO6ymkVKV95nyvW+IyH1igZJSVrL29mQJIA/
 FF8NSW4FlRwBxhWAGhRzyGUPdihVF8a9kpTc8xKqUjMT7ztRCgf/PT0Jtlgbkgpuayr+otIGR1+
 O2M4MQ=
X-Received: by 2002:a05:6a21:6f88:b0:3bf:6d96:ac40 with SMTP id
 adf61e73a8af0-3daed22bf87mr20658594637.12.1789267570138; 
 Sat, 12 Sep 2026 19:46:10 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba7a9bb56sm17811679eec.31.2026.09.12.19.46.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:46:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 83/86] tcg: Generic expansion of tcg_gen_bswap16_*
Date: Sat, 12 Sep 2026 16:38:34 -1000
Message-ID: <20260913023837.741866-84-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
 include/tcg/tcg-op-common.h  |   2 -
 include/tcg/tcg-op-def.h.inc |   1 +
 tcg/tcg-op.c                 | 129 ++++++++++++-----------------------
 3 files changed, 44 insertions(+), 88 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index ee26d4c9d54..c36ad34b0d2 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -133,7 +133,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, unsigned flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -158,7 +157,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 5e169258ea3..28cfa68db3e 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -10,6 +10,7 @@ DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
 DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
+DEF3(bswap16, TCGV, TCGV, unsigned)
 DEF2(clrsb, TCGV, TCGV)
 DEF3(clz, TCGV, TCGV, TCGV)
 DEF3(clzi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b1b29de74ac..c1b696c8193 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -109,6 +109,12 @@ static void gen_op_tt(TCGOpcode opc, TCGType type, TCGTemp *t0, TCGTemp *t1)
     tcg_gen_op2(opc, type, temp_arg(t0), temp_arg(t1));
 }
 
+static TCGOp *gen_op_tti(TCGOpcode opc, TCGType type,
+                         TCGTemp *t0, TCGTemp *t1, TCGArg a2)
+{
+    return tcg_gen_op3(opc, type, temp_arg(t0), temp_arg(t1), a2);
+}
+
 static TCGOp *gen_op_ttt(TCGOpcode opc, TCGType type,
                          TCGTemp *t0, TCGTemp *t1, TCGTemp *t2)
 {
@@ -525,6 +531,43 @@ static void gen_brcondi(TCGType type, TCGCond cond, TCGTemp *src1,
     gen_brcond(type, cond, src1, tcg_constant_internal(type, src2), l);
 }
 
+static void gen_bswap16(TCGType type, TCGTemp *dst,
+                        TCGTemp *src, unsigned flags)
+{
+    /* Only one extension flag may be present. */
+    tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
+
+    if (tcg_op_supported(INDEX_op_bswap16, type, 0)) {
+        gen_op_tti(INDEX_op_bswap16, type, dst, src, flags);
+    } else {
+        TCGTemp *t0 = tcg_temp_new_internal(type, TEMP_EBB);
+        TCGTemp *t1 = tcg_temp_new_internal(type, TEMP_EBB);
+        int width = tcg_type_size(type) * 8;
+
+        if (flags & TCG_BSWAP_IZ) {             /* t0 = ...a */
+            gen_shri(type, t0, src, 8);
+        } else {
+            gen_extract(type, t0, src, 8, 8);
+        }
+
+        if (flags & TCG_BSWAP_OS) {
+            gen_shli(type, t1, src, width - 8); /* t1 = b... */
+            gen_sari(type, t1, t1, width - 16); /* t1 = ssb. */
+        } else if (flags & TCG_BSWAP_OZ) {
+            gen_ext8u(type, t1, src);           /* t1 = ...b */
+            gen_shli(type, t1, t1, 8);          /* t1 = ..b. */
+        } else {
+            gen_shli(type, t1, src, 8);         /* t1 = xab. */
+        }
+
+        gen_or(type, dst, t0, t1);          /* ret = ..ba (OZ) */
+                                            /*     = ssba (OS) */
+                                            /*     = xaba (no flag) */
+        tcg_temp_free_internal(t0);
+        tcg_temp_free_internal(t1);
+    }
+}
+
 static void gen_clrsb(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
@@ -1446,49 +1489,6 @@ static void gen_bitswap_i64(TCGv_i64 ret, TCGv_i64 arg, uint64_t mask)
     tcg_temp_free_i64(t1);
 }
 
-/*
- * bswap16_i32: 16-bit byte swap on the low bits of a 32-bit value.
- *
- * Byte pattern: xxab -> yyba
- *
- * With TCG_BSWAP_IZ, x == zero, else undefined.
- * With TCG_BSWAP_OZ, y == zero, with TCG_BSWAP_OS y == sign, else undefined.
- */
-void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, unsigned flags)
-{
-    /* Only one extension flag may be present. */
-    tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
-
-    if (tcg_op_supported(INDEX_op_bswap16, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3i_i32(INDEX_op_bswap16, ret, arg, flags);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-
-                                            /* arg = ..ab (IZ) xxab (!IZ) */
-        tcg_gen_shri_i32(t0, arg, 8);       /*  t0 = ...a (IZ) .xxa (!IZ) */
-        if (!(flags & TCG_BSWAP_IZ)) {
-            tcg_gen_ext8u_i32(t0, t0);      /*  t0 = ...a */
-        }
-
-        if (flags & TCG_BSWAP_OS) {
-            tcg_gen_shli_i32(t1, arg, 24);  /*  t1 = b... */
-            tcg_gen_sari_i32(t1, t1, 16);   /*  t1 = ssb. */
-        } else if (flags & TCG_BSWAP_OZ) {
-            tcg_gen_ext8u_i32(t1, arg);     /*  t1 = ...b */
-            tcg_gen_shli_i32(t1, t1, 8);    /*  t1 = ..b. */
-        } else {
-            tcg_gen_shli_i32(t1, arg, 8);   /*  t1 = xab. */
-        }
-
-        tcg_gen_or_i32(ret, t0, t1);        /* ret = ..ba (OZ) */
-                                            /*     = ssba (OS) */
-                                            /*     = xaba (no flag) */
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 /*
  * bswap32_i32: 32-bit byte swap on a 32-bit value.
  *
@@ -1647,49 +1647,6 @@ void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg)
     tcg_gen_extract_i64(ret, arg, 0, 32);
 }
 
-/*
- * bswap16_i64: 16-bit byte swap on the low bits of a 64-bit value.
- *
- * Byte pattern: xxxxxxxxab -> yyyyyyyyba
- *
- * With TCG_BSWAP_IZ, x == zero, else undefined.
- * With TCG_BSWAP_OZ, y == zero, with TCG_BSWAP_OS y == sign, else undefined.
- */
-void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags)
-{
-    /* Only one extension flag may be present. */
-    tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
-
-    if (tcg_op_supported(INDEX_op_bswap16, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3i_i64(INDEX_op_bswap16, ret, arg, flags);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-
-                                            /* arg = ......ab or xxxxxxab */
-        tcg_gen_shri_i64(t0, arg, 8);       /*  t0 = .......a or .xxxxxxa */
-        if (!(flags & TCG_BSWAP_IZ)) {
-            tcg_gen_ext8u_i64(t0, t0);      /*  t0 = .......a */
-        }
-
-        if (flags & TCG_BSWAP_OS) {
-            tcg_gen_shli_i64(t1, arg, 56);  /*  t1 = b....... */
-            tcg_gen_sari_i64(t1, t1, 48);   /*  t1 = ssssssb. */
-        } else if (flags & TCG_BSWAP_OZ) {
-            tcg_gen_ext8u_i64(t1, arg);     /*  t1 = .......b */
-            tcg_gen_shli_i64(t1, t1, 8);    /*  t1 = ......b. */
-        } else {
-            tcg_gen_shli_i64(t1, arg, 8);   /*  t1 = xxxxxab. */
-        }
-
-        tcg_gen_or_i64(ret, t0, t1);        /* ret = ......ba (OZ) */
-                                            /*       ssssssba (OS) */
-                                            /*       xxxxxaba (no flag) */
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 /*
  * bswap32_i64: 32-bit byte swap on the low bits of a 64-bit value.
  *
-- 
2.53.0


