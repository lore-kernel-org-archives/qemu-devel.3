Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4058FC88E5A
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a7t-0008Vu-0D; Sat, 12 Sep 2026 22:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7E-0008Np-Av
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:38:49 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7B-0000wu-O8
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:38:47 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccafb74fso1046509a91.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267124; x=1789871924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MVQDaPXv+LKgeCkzDQpUKKRCK0cwdGmgYdDjl9T/qQY=;
 b=SL/uc+zojd8CUUXdc5SQhCHImDqGEqlYgf4/1wMDc2LPd8u1rm+JPIicHNthbDEl2I
 FkTocKixuZ8FIB0xTKH7ODtIjB4D6om7YZldSJIhj0eTsoyIARPeLQ860BL8Dk76fxxU
 MBN29xiT2RDNdKgNGOFhEC1hcTEbJ9qlLksnpDWEr8rytavbqz9qsW3SnicYNTVHsm+I
 PHaqZkxNieI7rGEDDZUm4YYSd/vUIHdySD8yhJn7eTdR4HedHfp4+9x8QyIH4XUwcCsh
 0leEZyOeAmDmeEeZetE4lgeu/5Cuqw7c0zLoG+I5GIvKXEmIMQkZUT7gZa77K/YUBR+J
 BgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267124; x=1789871924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MVQDaPXv+LKgeCkzDQpUKKRCK0cwdGmgYdDjl9T/qQY=;
 b=Hseyg+r6OLDqHfvUJ0ShIhjKYeG6mYTuDKflRoLCgN4DdeDBNdU9lsqwDPx8Kz7uLt
 47NGSb4y8dHom4FREgIw6v9IEFBgmqF+T1EOKPWrAkmrJ/uxuLYFHi3Nt0B8HVc1kJnZ
 4+Dg/qrim2GG2L29O1cGmpA+drI3rEPV0JUtO807qQy1HljoJ7TZyzN4zCbQ7kgCYv7v
 hjsjRe8YhJiZHmzUVe95Fwfr6bvwxSQe/HZN4JfB+pF/uy0zwCVJenemko05KS7U9W3H
 6HtXLUWjn7vHQexshoQuNQfRLqfdc/0cxA7IQNlZkeiGpBTFMIUrkYpy5QgV/BBdG3BZ
 CUPQ==
X-Gm-Message-State: AFuF++kPQ1tFBIt1AmzWKt/VHJZHBInLzX827KnU+LIGD3a2/hzn4rwJ
 BMU7EbwpHPyQD4ExPAZob5au6H3uIS88JjsWPHJjtSBsI5v5IsoRVGUTOV7At3S/ZI8dK7VMEC8
 81hkW
X-Gm-Gg: AYBFou0OAQo1x6+KWPWusGJPj2PHVmESigVLmmcpRVPGYeiVZO8yGQK10dm80oDq7TK
 cqmPeXIkWTGZVmiBsgiCZYclMsUbfetYtYMmXytH2WOK+pWjST+LZuVTU+mHKT+3eV4EAIOyxFJ
 kr1x9bQKW7p5LgKDzmyuBwkIeqLjzHzbjTzvM5Xv8Vx6QCSlppKgosgTx4Ej08XRME+CnsoQdEE
 x272sj0YGIxbeek4FEK6RuLbPdM6Y7IUD/z8SJVvLg9+J7sCyUEcB+xaQ5OYlVjCMvVKC5hDM9F
 WKPBG02rtWWImZ7+5uSutA5bbY0DdRcOciUOuEP0wszxw+PgJ8IOvTJiwAN3Ug1/AWyXdgl8K0L
 Uj3bnYXXW3kRauCUxG22L1aWUQ/NAzmAegJ0GLFp1/5L1f+xRNhHaDxCuJ8wiL/QjnACZe5mCAK
 TUjhP+Crs0JpGK/q9jQ6dRY6c4S2tUYKKXeXU1GOtYMAq90p3tN7PSZqfRJWP8Xqm2Qyty/H6vK
 CN4Rw8=
X-Received: by 2002:a17:90b:3850:b0:398:9be8:ea69 with SMTP id
 98e67ed59e1d1-39d9c36187amr18679006a91.22.1789267124069; 
 Sat, 12 Sep 2026 19:38:44 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.38.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:38:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/86] tcg: Generic expansion of tcg_gen_mov_*
Date: Sat, 12 Sep 2026 16:37:14 -1000
Message-ID: <20260913023837.741866-4-richard.henderson@linaro.org>
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

Begin sharing code in the expansion of operations
for various TCG types.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  | 29 +++++++++++-
 include/tcg/tcg-op-def.h.inc |  3 ++
 tcg/tcg-op.c                 | 91 ++++++++++++++++++++++++++++++------
 3 files changed, 107 insertions(+), 16 deletions(-)
 create mode 100644 include/tcg/tcg-op-def.h.inc

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 1e826b62574..8a42ff1f456 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -88,6 +88,33 @@ void tcg_gen_lookup_and_goto_ptr(void);
 void tcg_gen_plugin_cb(unsigned from);
 void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
+/*
+ * Construct operations from templates.
+ */
+
+#define DEF2(NAME, T1, T2) \
+    void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2);
+
+#define TCGV  glue(TCGv,TEXT)
+#define TEXT  _i32
+#define TINT  int32_t
+
+#include "tcg-op-def.h.inc"
+
+#undef TEXT
+#undef TINT
+
+#define TEXT  _i64
+#define TINT  int64_t
+
+#include "tcg-op-def.h.inc"
+
+#undef TEXT
+#undef TINT
+#undef TCGV
+
+#undef DEF2
+
 /* 32 bit ops */
 
 void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg);
@@ -172,7 +199,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
 void tcg_gen_discard_i32(TCGv_i32 arg);
-void tcg_gen_mov_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
@@ -294,7 +320,6 @@ void tcg_gen_add_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
 void tcg_gen_discard_i64(TCGv_i64 arg);
-void tcg_gen_mov_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
new file mode 100644
index 00000000000..ebfaf0b8188
--- /dev/null
+++ b/include/tcg/tcg-op-def.h.inc
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: MIT */
+
+DEF2(mov, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b738863ea69..511b34b143c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -104,6 +104,11 @@ TCGOp * NI tcg_gen_op6(TCGOpcode opc, TCGType type, TCGArg a1, TCGArg a2,
     return op;
 }
 
+static void gen_op_tt(TCGOpcode opc, TCGType type, TCGTemp *t0, TCGTemp *t1)
+{
+    tcg_gen_op2(opc, type, temp_arg(t0), temp_arg(t1));
+}
+
 /*
  * With CONFIG_DEBUG_TCG, tcgv_*_tmp via tcgv_*_arg, is an out-of-line
  * assertion check.  Force tail calls to avoid too much code expansion.
@@ -315,6 +320,78 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     tcg_gen_op2(INDEX_op_plugin_mem_cb, 0, tcgv_i64_arg(addr), meminfo);
 }
 
+/*
+ * Forward declarations of generic expansions.
+ */
+
+#define DEF2(NAME, T1, T2) \
+    static void glue(gen_,NAME)(TCGType, T1, T2);
+
+#define TCGV  TCGTemp *
+#define TINT  int64_t
+
+#include "tcg/tcg-op-def.h.inc"
+
+#undef TINT
+#undef TCGV
+
+#undef DEF2
+
+/*
+ * Templated operations.
+ */
+
+#define DEF2(NAME, T1, T2)                                              \
+    void glue(glue(tcg_gen_,NAME),TEXT)(T1 a, T2 b)                     \
+    { gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b)); }
+
+#define C_TCGv_i32      tcgv_i32_temp
+#define C_TCGv_i64      tcgv_i64_temp
+#define C_int32_t
+#define C_int64_t
+
+#define TCGV  glue(TCGv,TEXT)
+#define TEXT  _i32
+#define TINT  int32_t
+#define TYPE  TCG_TYPE_I32
+
+#include "tcg/tcg-op-def.h.inc"
+
+#undef TEXT
+#undef TINT
+#undef TYPE
+
+#define TEXT  _i64
+#define TINT  int64_t
+#define TYPE  TCG_TYPE_I64
+
+#include "tcg/tcg-op-def.h.inc"
+
+#undef TEXT
+#undef TINT
+#undef TCGV
+#undef TYPE
+
+#undef C_TCGv_i32
+#undef C_TCGv_i64
+#undef C_int32_t
+#undef C_int64_t
+
+#undef DEF2
+
+/*
+ * Generic expansions for templated operations.
+ * We have used compiler type checks to ensure all TCGTemp
+ * are of the proper type.
+ */
+
+static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    if (src != dst) {
+        gen_op_tt(INDEX_op_mov, type, dst, src);
+    }
+}
+
 /* 32 bit ops */
 
 void tcg_gen_discard_i32(TCGv_i32 arg)
@@ -322,13 +399,6 @@ void tcg_gen_discard_i32(TCGv_i32 arg)
     tcg_gen_op1_i32(INDEX_op_discard, TCG_TYPE_I32, arg);
 }
 
-void tcg_gen_mov_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    if (ret != arg) {
-        tcg_gen_op2_i32(INDEX_op_mov, ret, arg);
-    }
-}
-
 void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg)
 {
     tcg_gen_mov_i32(ret, tcg_constant_i32(arg));
@@ -1396,13 +1466,6 @@ void tcg_gen_discard_i64(TCGv_i64 arg)
     tcg_gen_op1_i64(INDEX_op_discard, TCG_TYPE_I64, arg);
 }
 
-void tcg_gen_mov_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    if (ret != arg) {
-        tcg_gen_op2_i64(INDEX_op_mov, ret, arg);
-    }
-}
-
 void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg)
 {
     tcg_gen_mov_i64(ret, tcg_constant_i64(arg));
-- 
2.53.0


