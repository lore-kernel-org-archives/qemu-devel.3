Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4497CC88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aBS-0004tq-04; Sat, 12 Sep 2026 22:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBN-0004PT-Hg
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:43:05 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBL-00020t-Ib
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:43:05 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d91c22d27dso3725205ad.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267382; x=1789872182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DE0phM+U5+tLCg4/g9SinUSArB4Qfpz3s0E3RDMsl4Y=;
 b=e15BxNSjK8M82wsQ/WZF4MCv1y2ZyZpnhJx/JVYKTrumz5rZaDmwtH4RYCuPaJG58I
 0q6bE6jaCGDfNXkSnZ3gQBvUv9batfCw+IZEJy49y8X19SnZ5DAIjHCjWpO/H5kJYkJr
 yfMsz3QGe42dAtdGFpUdMIivo2sdYAflul2ZEk98nFiIvTenZBbtAImaB04yNAQABbK3
 enfaEU5ND4Hj9efvYxNkAOfqoxmqlV+6KS5zz+gdW2hWywzUUfjnNiaqxagAm/9UfvAc
 v6iuoJuOJozRdoWTNctIoCojjKD/FYUwWRTi77qxrzMoL56aDksjFllrBWWL47CsyOgl
 x2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267382; x=1789872182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DE0phM+U5+tLCg4/g9SinUSArB4Qfpz3s0E3RDMsl4Y=;
 b=Wut16lz2YIf27kVn5emTtpGZ17o9lHPvvnex9sgND/xMjBFXL7oWRR6CYeUtkSj5VH
 dfq+V8wF9Z59j/NNpPbTOC1MK5KLXijlHvIm3L5NZntvsf1+v55INUo8XTu7Dk3zrnMq
 CsfEoddhRbVFlJENAvJ9KFGMUvdGKuS60vyfT/W6Ue5APQ2a4TfiN1Ei4xQ1CZPRkmU4
 pajeI71rplD2GJKX0nxY6+OMfQuxTNsrK3DUFeo9xzFEdDHNNstxDK6MUQZbCYBzKvfl
 KF5sW5m3HOghEikVrZjtgAbH1w4RtnQxRn8z27BC8U7kqBLoHn//kOtsUhYRgSLqrj7K
 RzwQ==
X-Gm-Message-State: AFuF++lBFsQropMif7lPoh76ebIUNzjUAvj6WjYOJVB4SMsCk7tMnxXo
 Gy1lBT2RN4ZjAtbDtzf91vwMmThJFoZQS1sHqsx44DslUoSW9NUv2kEAsSnqQzOGX8f8Yx17xnH
 POyiDS0k=
X-Gm-Gg: AYBFou342Mmc+asWZlP/GlN+Sb4obbI7huE7Z0WZAm0E1ZxFvD6jcrtHRnupu9umUd2
 BJ3sWIZV2thITqWWdethPgUQru/DlUfyamLWez7OB7wGK4z0YON+6jhQUBghi90y45FtX7KBGWr
 y5/zddj7oKtioTV/PdW9iDiqEoYyakfBNOrSDQkUWGn2hFcbTeOf1GulaIqGXWUd51qbLEGO1i0
 hFct9vtvyiztS8z9NBoVp1gpk6Re9z3g6rNLbjk4Fq49asV/WKKVAoACZd0vjX88pIAxgddElxF
 auq+91wfkuDtBK/f/G/OBOxVPx2Sa877gZEPGUTKO9e54eu4+PDybhCJa2l7QmlvUe3nLQxBwpQ
 hqPc8rrktKK8rb0MCacDMhLzf/B4npjUkH/OhBzYlTsZvYMTXCEF+uHZYTHouYOb8mJto0GLxLe
 HG2s65pkyG+1X91PGpfGBGHW3NWxUHnnz6SkKjJB6FZe9svzCat6K892HjetmcHu4PO18FJXLP6
 oPEHbs=
X-Received: by 2002:a17:902:ce0c:b0:2db:479a:5127 with SMTP id
 d9443c01a7336-2dd4bd95335mr87970465ad.19.1789267382096; 
 Sat, 12 Sep 2026 19:43:02 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.43.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:43:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 76/86] tcg: Generic expansion of tcg_gen_extract2_*
Date: Sat, 12 Sep 2026 16:38:27 -1000
Message-ID: <20260913023837.741866-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
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
index f38851a5bf7..c973b002b5e 100644
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
index a350a8185d0..b97c9df548c 100644
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


