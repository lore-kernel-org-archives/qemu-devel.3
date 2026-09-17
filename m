Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A76C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73qr-0003Sw-TA; Thu, 17 Sep 2026 00:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73ql-00039S-SY
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:35:56 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73qj-0007uz-JH
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:35:55 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39dbdfaef3cso372075a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619752; x=1790224552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=m5/k6tNpPZaN+4lj7F8+I4EwoEAGdTlvqbQMwM20Zh0=;
 b=R9RNr9cVx4WNC1vYUxAS1ODm3IbYd0idpVIaIgbakyul0BTgb3mlH/Bg0/Oui/WUQN
 GfE3SrSCy4jNcC/h77u9D/aj9r9bEf8FvTfEDTpU/1k1VPjmTulSNoJt8ARHW093nj77
 3R9r8TrkUCwgVjp3H2vJ7BiR2SIZiMOhrmrNOPdxVAl8VBxILHdk5roooOgQUUfcZ+tx
 FouqPL1mKgVcvZ+0EuxhLIW6bC81a8mMPI1b1mDjoZoeD11Jj3UdZh28btQYP+CfxijK
 eu5ZOj8Z6BOnp5FUl8EYn2IW3oxcPP3xHx4ZA5rf8l4gu91Gy9dKaLclFKRi2TOztn5O
 OQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619752; x=1790224552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=m5/k6tNpPZaN+4lj7F8+I4EwoEAGdTlvqbQMwM20Zh0=;
 b=cWoe5r9J+Bq3STgmI8lpybeO2sp6AaxhlnzvRZqLztq2BxB0UjirZI+2PR27sW3eiQ
 N7i8RzY45QV62koRvKPPP7uZHwProPMG/M+8W/WsPRoPZo+aXQwL56Pljpl0HMlN9pMU
 ZQgeU7Q9ySgGJWrLTHqKy1wHUN1gAPamQCDt7TQXVntv8OjFIaljjJmkoeabE9ABTVZs
 QRbIg0JqZNQOv1ctKTfePynbF5Xl8ZeR/o2Wsji785WZuWsDGVhkcKzfga0uqP7Zw3e+
 9qXrSpbzLA0n+Oz2x7g2PorHXCcck1S8CuI01rOSiHpOXJSjPXfLEhUofHq1gWdaSvXd
 uYGA==
X-Gm-Message-State: AFuF++m5PpuX1sqqdwX5yio7PtSrAn8Kg1Eav/Cgb5xBiNczLCUwM4WI
 +C6de8Fmjlkvz7ZHcKY+tAfmH4WSr3swoUkIeHrYsRk3PK3+vbI2nxZdCVmBQiVcnJJ7/lpnRSg
 DPAOcmnA=
X-Gm-Gg: AYBFou1eCrt49LzDKhmT/jypE8jBAje31nqOeus19VQC91wQ/XWjp+J4T/2PK81X6hC
 sM/rTtXFsGx00ssYdnthMIJYPkqICIC/e3PGtLWgYI4NB2RmMYr3V8io2eboaTEeiaUUZzRhhgD
 kezd9ET3q3M1OcgoAlbsxrgo0V7IOptViphSd+dVSQopyAM8tV1mz1TvaXcWCg6T3sdgLtwWbCu
 AyoETCKgdn41/1rQYG7KbZP+XikOvXkTS0BsKHFOfDpplCnVz1mk6DDjkGdBAdxi7x1j8OmNZLK
 rkyQV3H8buG3onRLTQfCsLbT0iblGXfVILo0MqYkIjKRiqp+Glho/r5VfkjP0N3B9gsJuGBqxOl
 i5apUyqwxnhah2XG6FVgWzSqGG1pUPPk5lbljDp+5CMLQr16Lyn9Kk2DuTRV2y9BjHVl4HMPirC
 xukJ49+W+HO0gRrxJcFKgIzpSE0kyGQl2u37a6zdPj5uAZ1nOOrpl+BHr0nOjr1tBUgL9+xWnvq
 tRi3IY=
X-Received: by 2002:a17:90b:3c41:b0:39d:fe64:5733 with SMTP id
 98e67ed59e1d1-39e1e5612demr17946438a91.24.1789619752018; 
 Wed, 16 Sep 2026 21:35:52 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13ee7sm10764267c88.8.2026.09.16.21.35.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:35:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 081/101] tcg: Generic expansion of tcg_gen_extract2_*
Date: Wed, 16 Sep 2026 18:28:03 -1000
Message-ID: <20260917042823.542588-82-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
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
index a97c0b2f765..04faf9bb69a 100644
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
@@ -777,6 +763,23 @@ static void gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
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
@@ -1225,25 +1228,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
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
@@ -1780,25 +1764,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
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


