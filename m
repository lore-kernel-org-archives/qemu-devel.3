Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07772C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aAs-0001PJ-RK; Sat, 12 Sep 2026 22:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aAq-0001CE-9A
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:32 -0400
Received: from mail-pz2-x16.google.com ([2607:f8b0:4864:3b::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aAm-0001qz-OR
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:30 -0400
Received: by mail-pz2-x16.google.com with SMTP id
 41be03b00d2f7-cc4bdf8abaaso1145196a12.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267347; x=1789872147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zzoTp46Ub+pDVgzx9szqneFACPjrZOdcO/8/caYbuOM=;
 b=EEWNo7b0Gtd8QWh42kAIbrGLz9BccRmdrd0mq4DolYo1CrbBDeBxv7F+DKyJGU+HWt
 9cXkuATFn5mLxyJZNgS0rnSIMPvvfelQZJDNA5DI3JOOOBni4kb0KUlfepLBFcb1o6DD
 05/ANoH37M30gwfYJT8M1RliZHSUlABT722MdMZskQ2BD/yqsAGa7ClMW3NyTbKDAB6J
 NZxljunXWvjxac3OdbIYz+xYuHidFoDrwf4Bm4iD38v1RKsLE8XRPfdUFuGYV7IeC+ty
 M0rTbZyev1ye1BUbvPcesqZbBhsutBZ+fnbZJX/O4p9iIImKV6tLroKkXu2DSrb9A1Lk
 teFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267347; x=1789872147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zzoTp46Ub+pDVgzx9szqneFACPjrZOdcO/8/caYbuOM=;
 b=GEkae/1GtuZ+DIOb45SEjLhEBPNIu+Z5TGuYmgdeAe4F9DPGSk/M47k+YPN+tzMfPv
 LidlhE566qW7tE4ZcjDFu66kRErp3B7NsMOjoF/cLwqmHp32AHTvu7zNODUGJmOet/82
 wvWwaSKZYaCOpIra9VP5wgauH1hG+TL5i8kPxIaGYjI1IDhYc6hTFxjB8bp/543BNrSg
 VsYF8khFTlG8atApEjQUkmu8bn5XET7aglJBMSZL0vK0we2n7oN9uAXsKcrSmc7UIEAB
 VKgkefIc5jnJ+MXITNyDJxesZ293+PUJ5XDQtS1irf1RHEANBOkpjRXAlLwRlObflvNz
 oEfA==
X-Gm-Message-State: AFuF++lMbKoPWWgXeyxCdse6EVEjAplqn7lm9ZGZInBnWK40icw/GFyX
 ugExtOq7UrxLaW06K1SSnr5tEmK0xqWvOjmMlmKB1xAy68FWjs2t5iLr3SzvmeR+i0ixu39Htux
 4UlNxnrE=
X-Gm-Gg: AYBFou0ueQ30VFUXRLFOCCgowVgrIrxjclFQc/BnEEX64pVbCS1AetmS9Z5RpH2irz2
 yNcMhSrOVB/wWXSlnxl0v6V2nCQ5lDW6uaExzEJjFHuAcQSs8+yY30NGlpJipeXaHak/7TtwsUK
 Ez37gG/gCW8yK+Hxthtr9cLlyC28IwtMkk7GYN256anhXRmPaNh/3XWvk6a4vHv14ZDKr9fKO4M
 BRXNCFoc5l2oFHue45fpjPuECaurVcDKNilWJPJVYClISbUYryAMpdNFKokV34KU910dGC40PLq
 WFog+j2hJPklQeF9+GYt5HNj0YFq7ZhisNnPd47cPSgVWxwNXzPXRoWMU+CAMQlacB4pjHDm+zE
 LeygT3cH8IvpcdVQn329V1hskvlmFTvoqFLyD4Jk6zEVMwx8hIjEHpeCC9VqbWgVY8TMRZjDBaF
 JkJF+UI1X+012GTreoVskSnIpdoJ+YszqQFpxqu+Z+ip/ycwnxS+Wx6bcKC36VCfW5DanI7yO2p
 2Kmc58=
X-Received: by 2002:a05:6a20:258e:b0:3cc:2552:ddd7 with SMTP id
 adf61e73a8af0-3daed0fffb2mr22989917637.5.1789267347281; 
 Sat, 12 Sep 2026 19:42:27 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 41/86] tcg: Generic expansion of tcg_gen_negsetcond_*
Date: Sat, 12 Sep 2026 16:37:52 -1000
Message-ID: <20260913023837.741866-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::16;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x16.google.com
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
 include/tcg/tcg-op-common.h  |  4 ----
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 36 ++++++++++++------------------------
 3 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 1727cd719b4..42fa516550e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,8 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
-                            TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
                              TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
@@ -213,8 +211,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
-                            TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
                              TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 42e0fde523a..8bbbf39f13a 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -17,6 +17,7 @@ DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
 DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
+DEF4(negsetcond, TCGCond, TCGV, TCGV, TCGV)
 DEF3(nor, TCGV, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6e1dd23e972..681e78f93a3 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -578,6 +578,18 @@ static void gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
     gen_op_tt(INDEX_op_neg, type, dst, src);
 }
 
+static void gen_negsetcond(TCGType type, TCGCond cond, TCGTemp *dst,
+                           TCGTemp *src1, TCGTemp *src2)
+{
+    if (cond == TCG_COND_ALWAYS) {
+        gen_movi(type, dst, -1);
+    } else if (cond == TCG_COND_NEVER) {
+        gen_movi(type, dst, 0);
+    } else {
+        gen_op_ttti(INDEX_op_negsetcond, type, dst, src1, src2, cond);
+    }
+}
+
 static void gen_nor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_nor, type, 0)) {
@@ -771,18 +783,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
-                            TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_movi_i32(ret, -1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_movi_i32(ret, 0);
-    } else {
-        tcg_gen_op4i_i32(INDEX_op_negsetcond, ret, arg1, arg2, cond);
-    }
-}
-
 void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
                              TCGv_i32 arg1, int32_t arg2)
 {
@@ -1549,18 +1549,6 @@ void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
     tcg_gen_negsetcond_i64(cond, ret, arg1, tcg_constant_i64(arg2));
 }
 
-void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
-                            TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_movi_i64(ret, -1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_movi_i64(ret, 0);
-    } else {
-        tcg_gen_op4i_i64(INDEX_op_negsetcond, ret, arg1, arg2, cond);
-    }
-}
-
 void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 8);
-- 
2.53.0


