Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760A3C88E5A
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a7a-0008RF-Bv; Sat, 12 Sep 2026 22:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7F-0008Nu-U1
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:38:51 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7E-0000xZ-3i
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:38:49 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea50dc3so513216a12.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267127; x=1789871927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=X1afvHDcZIayx+GptUZKRpUaOOUwPjF9JjYvC0M/78Y=;
 b=WlSe66fb+FiyroxM7/FOXtxAQXi3UOurNr6QQCwL1r5NY9BsFv/vSdrVfucjEiDk/K
 WDsINnXlbpl8gdLHqgLmL10KlOM2efNGs8fZWo0EmuC53Hdbo9l7gQV8aowkHOzq1HGu
 Z9czEdGt03+brkAreAVyWv9st6G0/g0ndJYsEbg9wkkxYUbi74ZdfKQBupM+L/NHbPD4
 ekN1zyXbnRvI6OepIsVECEkG8MbLR/lyrqeOXuVOy6bcQOzc4UgpZ5Gb8hOJGjQOSI4O
 E0ipUFXMZgluJyqJBdCgbrtMut7c97MogjnQBWGrUwhBKFVhDG/rS7jN3EgsSl6/7K1b
 x76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267127; x=1789871927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=X1afvHDcZIayx+GptUZKRpUaOOUwPjF9JjYvC0M/78Y=;
 b=UQsU8g+bk97SOjr6zaIiFOKcpbGqVvpUZCi1WAkatEC6Vg4IEgV4LdcWsQG+eWjFqO
 gwN5KbkNhJUNXlwHMt0wvk52ahEo4PEvebjzdYAMTO21+0PF0mRHqmqSUHFUfF4HvfvN
 1KPqIZzMbqg+d05PgkoWhu59O4oCsxUaTLrsajBA6Q0iXiI98yFe5hBH3nan91UqTr6L
 VqfJNPW6hNXcBsQBySVpUyCyl0VpmRyn4/op8qAPfKzC2AqSoV7K8muE3XRejOGgtOta
 0La1P1lwj9xHAzq6vIE+KF9dv+SiXvyoxsdmt2a78ybByx4N4ghi2LGjCEBaC2AVORq7
 wVZg==
X-Gm-Message-State: AFuF++m48Ce/IYRdy0Gz7Dvs0CwpoMv9d7rf8OIgDqPtq/zuYcXtptHU
 GImaQ56ORkWhluTOsHvSmLiGP678lLpV0W1sHIeJQESyHBwGQVZ/Z43+VjZFAfh5aSk0GD1E7Xy
 zXeUlML8=
X-Gm-Gg: AYBFou2iDjIEzjHcWotoe9amHOhCKIAX5VjMubKtzudFMYeQ/kHs4nJW+8mvbEW2Rri
 IwewYJjFfeWluaTIFldCBJh07l869SQmwatK5a1Yb85W/2pfTU+X63De7v5VQ1PBmwuz10Wnt0R
 PA2aSEtWRv0r0Sfl3BUR1Rb5SSwNT/XBL1Jj3LSHRYohxjLaG7O8XvORJMUv3UXXQQ3Q5jjw801
 DdghXpSH2RU40b5whowBETt7UyurSi3oEDIhYMiPlLWd9N88k39ixdb+O/ghnDzYD5+vPk8tVpS
 wtLsozFTy77ruJEXzVpnl5NRevXFaYxNIUVY5Dq+/uXdPU47j+bviUvZ0w4w17+zji/NWTigp6R
 jxckkUVtGeQSZeFanvqJsRB8eLYUNZMlk3vN04ilAB3HnC5PZ4Xi/EvZRjI4YuLxCgtAMiwQrkK
 +k6+ZP36ByvbtD01CAZab6iN9Fs2WEcZkKcQkrvqCdVXhJCDCSTiU3ZpzqanZ281QFmEU/frNRD
 hKuTds=
X-Received: by 2002:a05:6300:220c:b0:3d2:89db:1688 with SMTP id
 adf61e73a8af0-3db0e0b7955mr10847310637.2.1789267126496; 
 Sat, 12 Sep 2026 19:38:46 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.38.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:38:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/86] tcg: Generic expansion of tcg_gen_discard_*
Date: Sat, 12 Sep 2026 16:37:16 -1000
Message-ID: <20260913023837.741866-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  6 +++---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 33 +++++++++++++--------------------
 3 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index fd603b2de7f..1ef342e6c44 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -92,6 +92,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
  * Construct operations from templates.
  */
 
+#define DEF1(NAME, T1) \
+    void glue(glue(tcg_gen_,NAME),TEXT)(T1);
 #define DEF2(NAME, T1, T2) \
     void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2);
 
@@ -113,6 +115,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #undef TINT
 #undef TCGV
 
+#undef DEF1
 #undef DEF2
 
 /* 32 bit ops */
@@ -197,8 +200,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
-void tcg_gen_discard_i32(TCGv_i32 arg);
-
 void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
@@ -317,7 +318,6 @@ void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_add_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
-void tcg_gen_discard_i64(TCGv_i64 arg);
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 5de7648ed48..6ff97260dc6 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: MIT */
 
+DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 82f15205c36..88f06afafab 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -119,16 +119,6 @@ static void gen_op_tt(TCGOpcode opc, TCGType type, TCGTemp *t0, TCGTemp *t1)
 # define DNI
 #endif
 
-static void DNI tcg_gen_op1_i32(TCGOpcode opc, TCGType type, TCGv_i32 a1)
-{
-    tcg_gen_op1(opc, type, tcgv_i32_arg(a1));
-}
-
-static void DNI tcg_gen_op1_i64(TCGOpcode opc, TCGType type, TCGv_i64 a1)
-{
-    tcg_gen_op1(opc, type, tcgv_i64_arg(a1));
-}
-
 static TCGOp * DNI tcg_gen_op1i(TCGOpcode opc, TCGType type, TCGArg a1)
 {
     return tcg_gen_op1(opc, type, a1);
@@ -324,6 +314,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
  * Forward declarations of generic expansions.
  */
 
+#define DEF1(NAME, T1) \
+    static void glue(gen_,NAME)(TCGType, T1);
 #define DEF2(NAME, T1, T2) \
     static void glue(gen_,NAME)(TCGType, T1, T2);
 
@@ -335,12 +327,17 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef TINT
 #undef TCGV
 
+#undef DEF1
 #undef DEF2
 
 /*
  * Templated operations.
  */
 
+#define DEF1(NAME, T1)                                                  \
+    void glue(glue(tcg_gen_,NAME),TEXT)(T1 a)                           \
+    { gen_##NAME(TYPE, glue(C_,T1)(a)); }
+
 #define DEF2(NAME, T1, T2)                                              \
     void glue(glue(tcg_gen_,NAME),TEXT)(T1 a, T2 b)                     \
     { gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b)); }
@@ -377,6 +374,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef C_int32_t
 #undef C_int64_t
 
+#undef DEF1
 #undef DEF2
 
 /*
@@ -385,6 +383,11 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
  * are of the proper type.
  */
 
+static void gen_discard(TCGType type, TCGTemp *src)
+{
+    tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
+}
+
 static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -399,11 +402,6 @@ static void gen_movi(TCGType type, TCGTemp *dst, int64_t src)
 
 /* 32 bit ops */
 
-void tcg_gen_discard_i32(TCGv_i32 arg)
-{
-    tcg_gen_op1_i32(INDEX_op_discard, TCG_TYPE_I32, arg);
-}
-
 void tcg_gen_add_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_op3_i32(INDEX_op_add, ret, arg1, arg2);
@@ -1461,11 +1459,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 
 /* 64-bit ops */
 
-void tcg_gen_discard_i64(TCGv_i64 arg)
-{
-    tcg_gen_op1_i64(INDEX_op_discard, TCG_TYPE_I64, arg);
-}
-
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_ld8u, ret, arg2, offset);
-- 
2.53.0


