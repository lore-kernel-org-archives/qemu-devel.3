Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB97AC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pOB-0008IH-OF; Wed, 16 Sep 2026 09:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNh-0007SV-7y
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:58 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNf-0001Yr-6a
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:56 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccda24a3so704120a91.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564134; x=1790168934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZTPeHB7FGRaEU0nkE10XLLOEMMwe1608YGGgNjyzdZQ=;
 b=LTyKntQtHeeG48WYVckHvU06wigoLIClNBlx/ldsqcNPFLs47pazOlsf4TY813gXdh
 EMDgngva5DnHMBUpMgAxiVKq5vkt/5Wn/Mx86Ua+kwz4C/Lr6MFcLtjDx3owM6kd7W4G
 E/3x7GUBo8ZA8YWHsYJPE6UDqjbgHK6+/B90BEwz3GJWYQ2K+2UT1Jx9vHvXFZyU06TT
 Ozf5Ss0r3/Ya2/H281MZnRRgjo9tQm/KQD8spmZlfMIvWaKXvXUPGWMQZw39CPZbmcjI
 Jn8c3NNyCqP2aVfPEdQ/oXgXyxxKu2MF7jUIUAl8uMnomTvUvOAFyrbfQqa3Gg1tHCPg
 s3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564134; x=1790168934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZTPeHB7FGRaEU0nkE10XLLOEMMwe1608YGGgNjyzdZQ=;
 b=ssXh7QHqBdLpZVfTa6O8Yajben/8A36sqJ4x4cKtFlHTgqLMh1u1YaYQ3vx7EZ6SMg
 ZBAm1Q1MyhTFn5Cy2KMS6jR2DBrdV9RGuVDLQkfKakwhTUeuqJzz059t4uMA8T+BPEgq
 XGjazt+rY8Jd0hG+Mj86YvG9Pc4yGKDp/K4pVCrNcFzk/uVOzZHy3t5GGaS8wz7cNbLC
 1yp3zsEFeyKw1ohABnrIXY45nrXEI0DGTc7tfVpkUlrAt9DNykF7CAM8UySsUWGrC8LB
 kDY6+B3JofgMUu402Tjwpwv+msgeVJuL4vUqVbMkqbtieFYE7TSuFQqtyaZIxmI7xyDt
 r45A==
X-Gm-Message-State: AFuF++k2FSPaNhcrHUFZmBloPX9xX5/ecqJCP7RSrCNiYb75TQSasmjZ
 1u5CVjMHbIvo++QQID4OL03RPUPhUgLqWWB8SFHqjaQzKs5k/it/S6ZzWM9t9ICSEZORjnz64iF
 TwyMtmc0=
X-Gm-Gg: AYBFou3SnrRO3JkpJBNy2Ug5S/Yewx4dJo8+oavLQBXiCpHse1X6+72Avx9kdaHMrbr
 ccxjkoS59bn/9zX9YC386Z0YM+laaCzY7teSDgNu3YFn0BDlk+1X+kLoYB6ab1ZghX05zE6Rn8N
 Js/GYad0W35ZakpoKf4WqTeddN6xwhkYuGJy9URCJADHM8V7iYpmrK6ODjnjtMe85vA0S/7dOLf
 mEgskJPo5gYIAO4JdULszqi+Flb2mtTxQP6pRO4tRKrIThkVB+teAYPgcvsBd6o1wK/VxaaRjaQ
 4R9rc23lVfPKJac0DRQ0CuRvebsbcejNAMqeEkBbP1Uig0/xswfkM14f6I05cHc6xflade3ZubE
 S70SMZiqcXvRZtQNFo1kHDe+sauyfVvze+rTVL9mtEQr0JCs7LWWsZ5pE4h1F1YmSShxilQUn1W
 n3gpjj5vdUUPnHK4Du5IOsTDd5ZOqPi73OFIIDXst/lYn2jvCwtC/FR2CSB/5aHUl+4JlmOAJU/
 mmKKl7RpZEMjrnztw==
X-Received: by 2002:a17:90b:390d:b0:39d:f66e:1720 with SMTP id
 98e67ed59e1d1-39e1e4907e8mr6357269a91.13.1789564133618; 
 Wed, 16 Sep 2026 06:08:53 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 79/92] tcg: Generic expansion of tcg_gen_extract2_*
Date: Wed, 16 Sep 2026 03:03:54 -1000
Message-ID: <20260916130409.3382710-80-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  4 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 69 +++++++++---------------------------
 3 files changed, 18 insertions(+), 56 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index f547dc14365..c60135d2fe4 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,8 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
-                          unsigned int ofs);
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
@@ -164,8 +162,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
-                          unsigned int ofs);
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 48f5acd5dc1..1f6b3e2c464 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -25,6 +25,7 @@ DEF2(ext8u, TCGV, TCGV)
 DEF2(ext16s, TCGV, TCGV)
 DEF2(ext16u, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
+DEF4(extract2, TCGV, TCGV, TCGV, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6d32552391c..88cf2e076e0 100644
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
@@ -788,6 +774,23 @@ static void gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
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
@@ -1238,25 +1241,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
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
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
@@ -1793,25 +1777,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
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


