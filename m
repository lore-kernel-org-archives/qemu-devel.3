Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A728C88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1Z-0004oA-Kq; Sat, 12 Sep 2026 06:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1E-0004mB-86
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:36 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1C-0007Ew-G0
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:35 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d90ba1d807so9499445ad.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209093; x=1789813893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5xwW0Lb28rG5ga8WDMmmpMcOZqn2Xho9+epymClznXU=;
 b=NoO+bIjxk2nl2S9q15aaJTC59+x2mlDeMKCoPMUodGADKw+eonrROZaa92ecif6E66
 UhvlioARQrDRJImHUqqeiPUqmIM0YRMu+McTzqogZSertlh2Agz367wnmQinQAQw5RoP
 q0iJU+8fVjQpQYa2BP6P4hSqpmJlHvyzwywhi7CuvJ/7JWekNmPEj+abJDEgMB+bVrPn
 C+gax864dzZHS48wgUqiWWqcUYVht9lA9Abo7m2bqji1kQtohk4+cXCZdJbuBjmhagx9
 kTPtegpmCiwd8SqcY6B0LRsvq/Nu21MtHxHBD8/TbpK4BTGVvIMbTjgLdN2PJkJCj14t
 IiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209093; x=1789813893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5xwW0Lb28rG5ga8WDMmmpMcOZqn2Xho9+epymClznXU=;
 b=jwUePJlK0bJaXz9uKQZwfQ06sUErAJQUY6ZTLXDUWKCqsiypMOe7Ddwdnw14zQWIWy
 +l7QxxMzX6EmzmFI0lsELcj0xeg3cwe2veTnQt1DWmuzk18RBT/1in0GD7R7cuxA5Xnx
 mJu18dcJPVYK8sN8CVho9FaZCuZ0g4qw8uMJbJPBb3YmilqYP7Sm9I1hMCm7cbowREjA
 4HyQ6Gn4rmkiuiV+NHLOexm771TYNJSnxBQUZVzAbsjUSGAenCasxDrG3ovlDs8u8QLk
 B6phpJsWaOPL2jk8DgALsuRIWnWJtMtQkRi3lmhG9xdhtdAng1BZFSHsbghrjpKl1vTI
 6QJA==
X-Gm-Message-State: AFuF++nvIu9LvXDp54vWbys3FZDtRl3ollIioG5+Oz6pcYVvS94h9Twh
 PRepnEJuc4GNUFaXQxo9WB41jn4JiTL3Wpb+YXagnz4aKHwgE60IAsKNs9rdU3fKLim7S5aD6Q1
 B+ZDz
X-Gm-Gg: AYBFou3XZw8+hD6j+SmjQqtuTf3m8wBzwfoO/3vH/c/2g3jvdsTGHzNPK1ckkIsXR/z
 nv88rntrfh+jrxW/ahtMS6U2MlHi0k+l/jh3WD+aNJ22f6AIsp1Vo82mJD8btnr6qgFQOpsA/U8
 eae/6LTVX3HSlsqxGS/Z4fn8yvjIlI0dxUJD0Y6QB7p6FDnEE8PnK3brIcoeVGj8td+lPm7cpww
 dYEoFeAO3YBUx9A0IcSZokpfcXLgDAd4coan3v1RL2rrCnkPi15N5ZZEBpOZBxJvJ3CuA0xq+rq
 JkRLqBxYZxFMB7EQWtKSbxVEf4wgVZWEItyGjd2y7ryngTUIdl+bQkZsylA+5yKXn0Q7cLLaqB1
 oX69+t54dxHYoUv9pgzzq9wzcM7WDN+IvqbA+rY+JC1Vc6excRRzcvArkfl1V4busC9/5H+A75E
 9OiR4+2Bw5vJqZ8Xv092o74tlG33L3DiNy90wtTZRYTnzEt2XdbAr+nj9bRjFupLNrXDLslKtza
 6VTA3A=
X-Received: by 2002:a17:90b:3147:b0:398:ab03:95b2 with SMTP id
 98e67ed59e1d1-39d9bee5d69mr14202802a91.10.1789209092860; 
 Sat, 12 Sep 2026 03:31:32 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/82] tcg: Generic expansion of tcg_gen_movi_*
Date: Sat, 12 Sep 2026 00:30:08 -1000
Message-ID: <20260912103126.598030-5-richard.henderson@linaro.org>
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
 tcg/tcg-op.c                  | 24 ++++++++++++++----------
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 2f5276c8a2c..5fc8b43d083 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -95,13 +95,16 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #define DEF_RR(NAME) \
     void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b);
 
+#define DEF_RI(NAME) \
+    void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TINT b);
+
 #include "tcg-op-def.h.inc"
 
 #undef DEF_RR
+#undef DEF_RI
 
 /* 32 bit ops */
 
-void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg);
 void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
 void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -208,7 +211,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg);
 void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
 void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 86777f54bad..0f8ee5f9976 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -1,3 +1,4 @@
 /* SPDX-License-Identifier: MIT */
 
+DEF_RI(movi)
 DEF_RR(mov)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index eda87960380..8350110ebae 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -327,9 +327,13 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #define DEF_RR(NAME) \
     static void glue(gen_,NAME)(TCGType, TCGTemp *, TCGTemp *);
 
+#define DEF_RI(NAME) \
+    static void glue(gen_,NAME)(TCGType, TCGTemp *, int64_t);
+
 #include "tcg/tcg-op-def2.h.inc"
 
 #undef DEF_RR
+#undef DEF_RI
 
 /*
  * Generic expansions for templated operations.
@@ -344,6 +348,11 @@ static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
     }
 }
 
+static void gen_movi(TCGType type, TCGTemp *dst, int64_t src)
+{
+    gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
+}
+
 /*
  * Templated operations.
  */
@@ -352,9 +361,14 @@ static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
     DNI void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b)             \
     { gen_##NAME(TYPE, TTMP(a), TTMP(b)); }
 
+#define DEF_RI(NAME)                                                    \
+    DNI void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TINT b)             \
+    { gen_##NAME(TYPE, TTMP(a), b); }
+
 #include "tcg/tcg-op-def.h.inc"
 
 #undef DEF_RR
+#undef DEF_RI
 
 /* 32 bit ops */
 
@@ -363,11 +377,6 @@ void tcg_gen_discard_i32(TCGv_i32 arg)
     tcg_gen_op1_i32(INDEX_op_discard, TCG_TYPE_I32, arg);
 }
 
-void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg)
-{
-    tcg_gen_mov_i32(ret, tcg_constant_i32(arg));
-}
-
 void tcg_gen_add_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_op3_i32(INDEX_op_add, ret, arg1, arg2);
@@ -1430,11 +1439,6 @@ void tcg_gen_discard_i64(TCGv_i64 arg)
     tcg_gen_op1_i64(INDEX_op_discard, TCG_TYPE_I64, arg);
 }
 
-void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg)
-{
-    tcg_gen_mov_i64(ret, tcg_constant_i64(arg));
-}
-
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_ld8u, ret, arg2, offset);
-- 
2.53.0


