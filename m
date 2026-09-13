Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1113C88E64
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aBE-0003W1-Oj; Sat, 12 Sep 2026 22:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aB9-0003Dv-U8
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:52 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aB8-0001wu-0J
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:51 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea4bfb6so456911a12.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267368; x=1789872168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pZy4FFipy8bxOrD2p4v95gJWerVEz7A3S4kKTHj1pmw=;
 b=x9m7dY1EQfVHTEdlctJE9bbU/f+Bp4frYUuToTuI3KxUvY84pvXnZOveJo9TBZnI3f
 Sl9t7VUlKyQNZBuyeX5ng/Er2tQB5vFjMjC8uxGe7IHX46UhBqgfuQKs3C29Pucmwjx7
 +8TjKeDl2uGjCNaEGo+Om5jJx1bgeoHYeSL4LYUSgceRT9kfwTdc5wzC96S4UhYSeVE6
 2CnYNOxwsLJfvCPRBUAPbcoWr5cuSMFpd8gvS+WKGy4dFOkkwk599semwQCvMe1ANvBv
 97OEnSc9yKkEHZX7zX5wuSb/pUMRchaBMaLFrWrsaWOtz3H8YBWo4PZWGvuUFamrvihq
 zQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267368; x=1789872168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pZy4FFipy8bxOrD2p4v95gJWerVEz7A3S4kKTHj1pmw=;
 b=WxWh8wIaiVNL9f/8bEHumhP1drW9roMZ7dcQxe4J8koVEiCdWTY+C81DiC3enJmPlF
 td9ppOADdSMsN9au/hg8/KHupMGEz+QrYSOH3f8kR/ueemmjF+4Ses5ZFMKYkG2zNI/o
 aOea/aCcmFThjlnUHtoF6gVd5OYRcpKMYSJIBj6o2r/rvduJcaJM7rwKSj/ApADbiaTV
 4z22EX2GRXRenKuLWg/XUFph8c8S1fvdhc3/35WMvyf70O8SJs1oFx3TgtFuw5Rdw/OR
 N+ykqhatOebYjwhkONCeuE4OwpTsZOssxk78LFdQadXy0w6TgZxzrKIvQYnPEMoByz/X
 DK8Q==
X-Gm-Message-State: AFuF++lFHWt5CezxGvlreYubLhdP/uv4ItX92vSDG+VtCkK1ZVzUlLx+
 La9XfYpE4QnWxV7DretoS7nW0zkaaHSd8VwDwJG0JEJJCgQeUDtZmMkyPfh+KzrNChOpiNOyE6R
 Hkrt5ZOs=
X-Gm-Gg: AYBFou2ZkrlTHfffYonlnhzCLH5w5+eiq3EMiZaEQBWHWVmlY4oWmVo79+9or7lHoSS
 5OWG9NkcF01/dSx1B10eMUQmigZvqYokfZYtynB0dAVRhuU9WuPq27T2Dp3RubUWgdVgGTOf58T
 G6B4DCgstw6fgLK66jdIRq4fNvd4Bw/GlcEiUmg4E/7mZVlWwNaTaDrSp9gmb/dnhKWSbmC35RN
 /kWoztpi0GTXHG/JbsE08n1XJFDLoq2TuDFBGc8GHs6zovaS1W4SNK3ENCSjMIsN8WfRM/4lgxw
 Vy1uReKFQPHdwRySK8jSOdo81gRQ7o0cZ1HkegXBKpBQuHttx3p5CInDlkIm7ws2CE1/ZZJ2/F1
 /YSNDVp1iDi5OkxZ8eJhZIukGGRssDIi9vOoM8F/CvYohVrvBDelbjm4NfRBEd55mD+d+ulNBLJ
 lKZTB7rBFqwBa5bwsr1zzyiZ6wIKdZFqX1cd5H5x3iEaghfOtpykzLYarf6Z7pdGmyyJBnmNJMm
 x67CGOX
X-Received: by 2002:a05:6a21:a95:b0:3da:6bdd:2c74 with SMTP id
 adf61e73a8af0-3daed306372mr22886209637.10.1789267368367; 
 Sat, 12 Sep 2026 19:42:48 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 62/86] tcg: Generic expansion of tcg_gen_deposit_z_*
Date: Sat, 12 Sep 2026 16:38:13 -1000
Message-ID: <20260913023837.741866-63-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  4 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 70 +++++++++++-------------------------
 3 files changed, 21 insertions(+), 54 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 2800aa0dd0e..572cb53bf67 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,8 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
-                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
@@ -177,8 +175,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
-                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 21a941f5458..3b44db51f55 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -14,6 +14,7 @@ DEF2(ctpop, TCGV, TCGV)
 DEF3(ctz, TCGV, TCGV, TCGV)
 DEF3(ctzi, TCGV, TCGV, TINT)
 DEF5(deposit, TCGV, TCGV, TCGV, unsigned, unsigned)
+DEF4(deposit_z, TCGV, TCGV, unsigned, unsigned)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 4152e29143d..49870f6df73 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -244,20 +244,6 @@ static void DNI tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                 tcgv_i64_arg(a3), a4);
 }
 
-static void DNI tcg_gen_op5ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                  TCGv_i32 a3, TCGArg a4, TCGArg a5)
-{
-    tcg_gen_op5(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), a4, a5);
-}
-
-static void DNI tcg_gen_op5ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                  TCGv_i64 a3, TCGArg a4, TCGArg a5)
-{
-    tcg_gen_op5(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), a4, a5);
-}
-
 /* Generic ops.  */
 
 void gen_set_label(TCGLabel *l)
@@ -642,6 +628,26 @@ static void gen_deposit(TCGType type, TCGTemp *dst, TCGTemp *src1,
     }
 }
 
+static void gen_deposit_z(TCGType type, TCGTemp *dst, TCGTemp *src,
+                          unsigned int ofs, unsigned int len)
+{
+    unsigned width = tcg_type_size(type) * 8;
+
+    tcg_debug_assert(ofs < width);
+    tcg_debug_assert(len > 0);
+    tcg_debug_assert(len <= width);
+    tcg_debug_assert(ofs + len <= width);
+
+    if (ofs + len == width) {
+        gen_shli(type, dst, src, ofs);
+    } else if (ofs == 0) {
+        gen_extract(type, dst, src, 0, len);
+    } else {
+        TCGTemp *zero = tcg_constant_internal(type, 0);
+        gen_op_tttii(INDEX_op_deposit, type, dst, zero, src, ofs, len);
+    }
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -1132,24 +1138,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
-                           unsigned int ofs, unsigned int len)
-{
-    tcg_debug_assert(ofs < 32);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 32);
-    tcg_debug_assert(ofs + len <= 32);
-
-    if (ofs + len == 32) {
-        tcg_gen_shli_i32(ret, arg, ofs);
-    } else if (ofs == 0) {
-        tcg_gen_extract_i32(ret, arg, 0, len);
-    } else {
-        TCGv_i32 zero = tcg_constant_i32(0);
-        tcg_gen_op5ii_i32(INDEX_op_deposit, ret, zero, arg, ofs, len);
-    }
-}
-
 /*
  * Extract 32-bits from a 64-bit input, ah:al, starting from ofs.
  * Unlike tcg_gen_extract_i32 above, len is fixed at 32.
@@ -1801,24 +1789,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
-                           unsigned int ofs, unsigned int len)
-{
-    tcg_debug_assert(ofs < 64);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 64);
-    tcg_debug_assert(ofs + len <= 64);
-
-    if (ofs + len == 64) {
-        tcg_gen_shli_i64(ret, arg, ofs);
-    } else if (ofs == 0) {
-        tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
-    } else {
-        TCGv_i64 zero = tcg_constant_i64(0);
-        tcg_gen_op5ii_i64(INDEX_op_deposit, ret, zero, arg, ofs, len);
-    }
-}
-
 /*
  * Extract 64 bits from a 128-bit input, ah:al, starting from ofs.
  * Unlike tcg_gen_extract_i64 above, len is fixed at 64.
-- 
2.53.0


