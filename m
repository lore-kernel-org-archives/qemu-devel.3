Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237D1C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L5D-0001Jx-LJ; Sat, 12 Sep 2026 06:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L54-0000Zb-B4
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:34 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L50-0008Po-Fu
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:34 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d747ee1f9bso7245165ad.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209328; x=1789814128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bsS+mu3ApIHTiAf0Klz7Y1dC8MvYFHqWgd9rsoZI5JY=;
 b=VX/LuTp9UB85GuVwihyKzmOF1QiRVZivWodEzz6tHvRRFvRYxK6sVhFJPdB0Yr7Sky
 /56av6OIRRcVVanFs/x120qZtPU/0vghn5bYjSU5AjGIkU2gRWjH0OnxKEgPqKVeZLF2
 JvYjILw4hyXLVqJdkw79o6KdFpisfGux8frfPRradHs9Dl+gkpIKY93am3zkffDlr97D
 3AVzqXuLxjmjYhvXBeqr3WC0NqFVF1Xlj6JzXQomUOhs4ZudDVbR0egQCLXY6vMEwPd+
 K/UbD9vzSpsWBXmSOSaISdiNuppj/uj1+dfwE4m8O0QVJ82pmsr+nW4c3sZdRxGCo0/I
 L5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209328; x=1789814128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bsS+mu3ApIHTiAf0Klz7Y1dC8MvYFHqWgd9rsoZI5JY=;
 b=h+d93dS3+6f2haLxvnl5VvxJMpAcGA0gdqJ603zcfQf8lw2Y+CA1LGPZoWA2tRV2Kn
 Kj47K6Dclkdq6Nu5QM78Ix8YIxtCCRq+TzvIjYLuuzVbqcZ9ZLiLjq55pJB6JibHp5MX
 a9fc6VgG1yyKzSONhaR4VTm8Ge56oyVrtpgQWtFyTIRqCVakqC3U47X9RVvB9sceLkx7
 km31R1N6HL2fwmuBLQh/GqY7dE+uxF2qmw8z8yG/aIevq0xCrxc2X3HY5WTw/MJX+NCt
 B8BoWaeQMUdnVfg8iqdQ7lchJL8Dg/Y6mwSmDsHmb2e8rJPCGqkSzEnamac5McBbJB3O
 uDuA==
X-Gm-Message-State: AFuF++l+ltvdEYoxmIlVStLT9mIYA4RE+d1Qo+Ie3A688RjBZkzba3af
 bx49e1Y6Vbey3OOc8E9xEzZwjFe6YDY7GONY0W0pSRq/oAOTs8wamTQSEMFwj/Vkz+JtEMlft/i
 sCs7EnLo=
X-Gm-Gg: AYBFou1cjPA2TDIa13TXcmWUkqrVnDC9J5YfVaYg4VSvITNnrXbOiMHqmf1GkZQwOzG
 gXirNfcon8UJbrVB1cRHyNd2cMiF2jXBBnvTFseB/+kgMbkvddR/PoVs9Kx65JxbV7XsNo/OGYg
 b6XQkoYRTv1/Q1g0/zC7WJvbpb+OvsBACFOmdQYAjfRHO7YnDvGcxzX5yxlYErlfnM24e7SzBKG
 T+4V8IR+desbYozc/PgDDIFo95PEyDs/+HUg3Luq8DQ6yHqrGUAexYT2IHBAajzau5V/3za2Uad
 7adAUaeD8jqfUUTiL0XPODkC+CadIMGCOgTIxneJTce1ceoxGKgwupQa3yrtIgnd7SyQ3f7/LWZ
 Xmb4RmaluprWogvWbIMKhkbPVVXkGyr7LaiV8XLKn5PJWpJovFym2wU0jZ+Fa6ulhojzBqtOyhS
 7+2IQp2RmgY/5s+ZGxHwrM+/NWMCSdrt5CK7/UCUOmTcPX9Lt+EMJgM6mSrQTDuFgJGXexaoUwT
 5JVP3ensuUY4LZpmQ==
X-Received: by 2002:a17:903:1ac5:b0:2db:539c:b7c7 with SMTP id
 d9443c01a7336-2dd2a46d478mr155214465ad.20.1789209328069; 
 Sat, 12 Sep 2026 03:35:28 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 61/82] tcg: Generic expansion of tcg_gen_sextract_*
Date: Sat, 12 Sep 2026 00:31:05 -1000
Message-ID: <20260912103126.598030-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h   |   4 --
 include/tcg/tcg-op-def2.h.inc |   1 +
 tcg/tcg-op.c                  | 121 +++++++++++-----------------------
 3 files changed, 38 insertions(+), 88 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 0a37a8edb60..7c6421f692c 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -153,8 +153,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
                            unsigned int ofs, unsigned int len);
-void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
-                          unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
@@ -200,8 +198,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
                            unsigned int ofs, unsigned int len);
-void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
-                          unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 24db95e294d..5cbdf39b3e6 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -52,3 +52,4 @@ DEF_RRR(sub)
 DEF_RRR(xor)
 DEF_RRRUU(deposit)
 DEF_RRUU(extract)
+DEF_RRUU(sextract)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index d196c36fc4f..2a31ae17f4d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -244,20 +244,6 @@ static void DNI tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                 tcgv_i64_arg(a3), a4);
 }
 
-static TCGOp * DNI tcg_gen_op4ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                     TCGArg a3, TCGArg a4)
-{
-    return tcg_gen_op4(opc, TCG_TYPE_I32,
-                       tcgv_i32_arg(a1), tcgv_i32_arg(a2), a3, a4);
-}
-
-static TCGOp * DNI tcg_gen_op4ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                     TCGArg a3, TCGArg a4)
-{
-    return tcg_gen_op4(opc, TCG_TYPE_I64,
-                       tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3, a4);
-}
-
 static void DNI tcg_gen_op5ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                   TCGv_i32 a3, TCGArg a4, TCGArg a5)
 {
@@ -994,6 +980,43 @@ static void gen_setcondi(TCGType type, TCGCond cond, TCGTemp *dst,
     gen_setcond(type, cond, dst, src1, tcg_constant_internal(type, src2));
 }
 
+static void gen_sextract(TCGType type, TCGTemp *dst, TCGTemp *src,
+                          unsigned int ofs, unsigned int len)
+{
+    int width = tcg_type_size(type) * 8;
+
+    tcg_debug_assert(ofs < width);
+    tcg_debug_assert(len > 0);
+    tcg_debug_assert(len <= width);
+    tcg_debug_assert(ofs + len <= width);
+
+    /* Canonicalize certain special cases, even if extract is supported.  */
+    if (ofs + len == width) {
+        gen_sari(type, dst, src, width - len);
+        return;
+    }
+
+    if (TCG_TARGET_sextract_valid(type, ofs, len)) {
+        gen_op_ttii(INDEX_op_sextract, type, dst, src, ofs, len);
+        return;
+    }
+
+    /* Assume that sign-extension, if available, is cheaper than a shift.  */
+    if (TCG_TARGET_sextract_valid(type, 0, ofs + len)) {
+        gen_op_ttii(INDEX_op_sextract, type, dst, src, 0, ofs + len);
+        gen_sari(type, dst, dst, ofs);
+        return;
+    }
+    if (TCG_TARGET_sextract_valid(type, 0, len)) {
+        gen_shri(type, dst, src, ofs);
+        gen_op_ttii(INDEX_op_sextract, type, dst, dst, 0, len);
+        return;
+    }
+
+    gen_shli(type, dst, src, width - len - ofs);
+    gen_sari(type, dst, dst, width - len);
+}
+
 static void gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
@@ -1157,41 +1180,6 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
     }
 }
 
-void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
-                          unsigned int ofs, unsigned int len)
-{
-    tcg_debug_assert(ofs < 32);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 32);
-    tcg_debug_assert(ofs + len <= 32);
-
-    /* Canonicalize certain special cases, even if extract is supported.  */
-    if (ofs + len == 32) {
-        tcg_gen_sari_i32(ret, arg, 32 - len);
-        return;
-    }
-
-    if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, ofs, len)) {
-        tcg_gen_op4ii_i32(INDEX_op_sextract, ret, arg, ofs, len);
-        return;
-    }
-
-    /* Assume that sign-extension, if available, is cheaper than a shift.  */
-    if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, 0, ofs + len)) {
-        tcg_gen_op4ii_i32(INDEX_op_sextract, ret, arg, 0, ofs + len);
-        tcg_gen_sari_i32(ret, ret, ofs);
-        return;
-    }
-    if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, 0, len)) {
-        tcg_gen_shri_i32(ret, arg, ofs);
-        tcg_gen_op4ii_i32(INDEX_op_sextract, ret, ret, 0, len);
-        return;
-    }
-
-    tcg_gen_shli_i32(ret, arg, 32 - len - ofs);
-    tcg_gen_sari_i32(ret, ret, 32 - len);
-}
-
 /*
  * Extract 32-bits from a 64-bit input, ah:al, starting from ofs.
  * Unlike tcg_gen_extract_i32 above, len is fixed at 32.
@@ -1861,41 +1849,6 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
     }
 }
 
-void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
-                          unsigned int ofs, unsigned int len)
-{
-    tcg_debug_assert(ofs < 64);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 64);
-    tcg_debug_assert(ofs + len <= 64);
-
-    /* Canonicalize certain special cases, even if sextract is supported.  */
-    if (ofs + len == 64) {
-        tcg_gen_sari_i64(ret, arg, 64 - len);
-        return;
-    }
-
-    if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, ofs, len)) {
-        tcg_gen_op4ii_i64(INDEX_op_sextract, ret, arg, ofs, len);
-        return;
-    }
-
-    /* Assume that sign-extension, if available, is cheaper than a shift.  */
-    if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, 0, ofs + len)) {
-        tcg_gen_op4ii_i64(INDEX_op_sextract, ret, arg, 0, ofs + len);
-        tcg_gen_sari_i64(ret, ret, ofs);
-        return;
-    }
-    if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, 0, len)) {
-        tcg_gen_shri_i64(ret, arg, ofs);
-        tcg_gen_op4ii_i64(INDEX_op_sextract, ret, ret, 0, len);
-        return;
-    }
-
-    tcg_gen_shli_i64(ret, arg, 64 - len - ofs);
-    tcg_gen_sari_i64(ret, ret, 64 - len);
-}
-
 /*
  * Extract 64 bits from a 128-bit input, ah:al, starting from ofs.
  * Unlike tcg_gen_extract_i64 above, len is fixed at 64.
-- 
2.53.0


