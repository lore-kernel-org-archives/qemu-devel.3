Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC90C369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mDu-0005VT-BH; Tue, 15 Apr 2025 15:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m6s-0001IM-8l
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:38:36 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m5e-0004ei-J4
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:37:54 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2240b4de12bso81473215ad.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745784; x=1745350584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DlkvObnbMfL4IGx054IqMAFOevFHTCxsaPqJ2JTdp+M=;
 b=r6K1ilBV7tNBm/YRaYeIpbyWwrcoDmF2Mbsi9H9ZpjEyF3WKei11CkJpKTWw7q9tS7
 XExqEGSNIz/4XTdBu8ekJj+hXjpNPEBlbuhz+K5QdCqvwqPbKvbHCCrvWvkBLhrQof5p
 eVc1GwpYCtHARNWvvBuV+xdMSqlh+2ED/jIejvtQufNVpDpCGx22DqbQh88i6nQN7Smt
 IThhdnvMPn7UqyoP/gR262eSC2S/mFokNkuQhBgKHVFlUWdBWdrCBSwKWwd9+ShQ/ytm
 BsixJT9ae3vNyxlhUge7oHjMSl3+ih1wY3XyrVk/5sermcUwL0Rf2wDNY/fygwkaiEct
 c14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745784; x=1745350584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DlkvObnbMfL4IGx054IqMAFOevFHTCxsaPqJ2JTdp+M=;
 b=DiqXKjFP2uGhU69ba4+qVm0rQZf7enPBw794knu5HG4CWnrvvq3UdaXR2z9UWFlMVl
 EEiYW39YIB+zIc/Mh7KP8LjXvUPFs/JXPWqXxtl4GjIc2YuAjX74U8ld3LvT3+LJKRsj
 v5TnfI7ql1sE4cj3XH3098pKJLVZAUXa1SbhRqnQ9nuVPOJXAoVfa3M+kxLd5YNJW5IV
 Okk5NGWMGdZywJBhFgAZmCyKPWKPvmGxoohNcpN5r12F9GVEHY06w1kesfcwWw2VIMWR
 Eom1wAuiEsD6J4cIBQ1O8PhECP2vFD1BMavQm0OJChnTDlt7cRIuuUAdOZXXqnBeSS2E
 UtQw==
X-Gm-Message-State: AOJu0YyRe14IRlgoFp8CBXbqmS13fy3Sr/Be/0sAVDUQBuFJnfoCteZN
 SwNIchWO5m8jizpTqN5+ZjRgcfwUsAIAVF//sGUm6zIRu0PIBh+RehRi05347y+mab/xenaJFcj
 D
X-Gm-Gg: ASbGncveNQ3+HaIwG470PWkxc0W7UXfAr7i9rzoWnoGma6Rs/728ekULp8P7tDfAr2O
 9yqyiTtjg0noG5G8YkN3vxuvDFWPXU63lB8Gc7iQKlIK+OaUoJ1t7GSVJJdFv2KUYToArCYLFKc
 zLUohrAYFigwIkqpzBEooVx9sKJiYjjQCr0oFE1LpdXNh0qJjGOspKv73g3jACUtTgAIW+bIvqh
 WXPNraBuZEx5yoEIouDHPA0XND3nwoDfmHE5Jl97Uhvm28PNGc5u45zaJPItbBQ5GEH+ni9i0Gz
 /ofNecw/E9PTmw7e+KD95jb9IbfdvKVu4HV6wbUV1PM4JgkT8VMy+XSEsggbs2xTKAm+Se0SINI
 =
X-Google-Smtp-Source: AGHT+IERjW7Vbbi4yJEgE7pDLCmuhJ7hzFt2O1HohqsS7rMCjo7J7/XGhlBUgk362J+CcgIq6yv38Q==
X-Received: by 2002:a17:903:1946:b0:223:fabd:4f76 with SMTP id
 d9443c01a7336-22c319f764amr4945125ad.30.1744745784300; 
 Tue, 15 Apr 2025 12:36:24 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 155/163] tcg: Merge INDEX_op_ld*_{i32,i64}
Date: Tue, 15 Apr 2025 12:25:06 -0700
Message-ID: <20250415192515.232910-156-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    | 19 +++++-------
 tcg/optimize.c           | 27 ++++++++---------
 tcg/tcg-op.c             | 24 +++++++--------
 tcg/tcg.c                | 64 ++++++++++++++--------------------------
 tcg/tci.c                | 43 +++++++++++----------------
 tcg/tci/tcg-target.c.inc | 28 +++++++-----------
 6 files changed, 83 insertions(+), 122 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 30ba15723a..6e8fcefaef 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -57,6 +57,13 @@ DEF(divu2, 2, 3, 0, TCG_OPF_INT)
 DEF(eqv, 1, 2, 0, TCG_OPF_INT)
 DEF(extract, 1, 1, 2, TCG_OPF_INT)
 DEF(extract2, 1, 2, 1, TCG_OPF_INT)
+DEF(ld8u, 1, 1, 1, TCG_OPF_INT)
+DEF(ld8s, 1, 1, 1, TCG_OPF_INT)
+DEF(ld16u, 1, 1, 1, TCG_OPF_INT)
+DEF(ld16s, 1, 1, 1, TCG_OPF_INT)
+DEF(ld32u, 1, 1, 1, TCG_OPF_INT)
+DEF(ld32s, 1, 1, 1, TCG_OPF_INT)
+DEF(ld, 1, 1, 1, TCG_OPF_INT)
 DEF(movcond, 1, 4, 1, TCG_OPF_INT)
 DEF(mul, 1, 2, 0, TCG_OPF_INT)
 DEF(muls2, 2, 2, 0, TCG_OPF_INT)
@@ -93,11 +100,6 @@ DEF(subbi, 1, 2, 0, TCG_OPF_INT | TCG_OPF_CARRY_IN)
 DEF(subbio, 1, 2, 0, TCG_OPF_INT | TCG_OPF_CARRY_IN | TCG_OPF_CARRY_OUT)
 
 /* load/store */
-DEF(ld8u_i32, 1, 1, 1, 0)
-DEF(ld8s_i32, 1, 1, 1, 0)
-DEF(ld16u_i32, 1, 1, 1, 0)
-DEF(ld16s_i32, 1, 1, 1, 0)
-DEF(ld_i32, 1, 1, 1, 0)
 DEF(st8_i32, 0, 2, 1, 0)
 DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
@@ -106,13 +108,6 @@ DEF(brcond2_i32, 0, 4, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(setcond2_i32, 1, 4, 1, 0)
 
 /* load/store */
-DEF(ld8u_i64, 1, 1, 1, 0)
-DEF(ld8s_i64, 1, 1, 1, 0)
-DEF(ld16u_i64, 1, 1, 1, 0)
-DEF(ld16s_i64, 1, 1, 1, 0)
-DEF(ld32u_i64, 1, 1, 1, 0)
-DEF(ld32s_i64, 1, 1, 1, 0)
-DEF(ld_i64, 1, 1, 1, 0)
 DEF(st8_i64, 0, 2, 1, 0)
 DEF(st16_i64, 0, 2, 1, 0)
 DEF(st32_i64, 0, 2, 1, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 0f661a8c0b..1da23755e3 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2868,22 +2868,22 @@ static bool fold_tcg_ld(OptContext *ctx, TCGOp *op)
 
     /* We can't do any folding with a load, but we can record bits. */
     switch (op->opc) {
-    CASE_OP_32_64(ld8s):
+    case INDEX_op_ld8s:
         s_mask = INT8_MIN;
         break;
-    CASE_OP_32_64(ld8u):
+    case INDEX_op_ld8u:
         z_mask = MAKE_64BIT_MASK(0, 8);
         break;
-    CASE_OP_32_64(ld16s):
+    case INDEX_op_ld16s:
         s_mask = INT16_MIN;
         break;
-    CASE_OP_32_64(ld16u):
+    case INDEX_op_ld16u:
         z_mask = MAKE_64BIT_MASK(0, 16);
         break;
-    case INDEX_op_ld32s_i64:
+    case INDEX_op_ld32s:
         s_mask = INT32_MIN;
         break;
-    case INDEX_op_ld32u_i64:
+    case INDEX_op_ld32u:
         z_mask = MAKE_64BIT_MASK(0, 32);
         break;
     default:
@@ -3114,16 +3114,15 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_extrh_i64_i32:
             done = fold_extu(&ctx, op);
             break;
-        CASE_OP_32_64(ld8s):
-        CASE_OP_32_64(ld8u):
-        CASE_OP_32_64(ld16s):
-        CASE_OP_32_64(ld16u):
-        case INDEX_op_ld32s_i64:
-        case INDEX_op_ld32u_i64:
+        case INDEX_op_ld8s:
+        case INDEX_op_ld8u:
+        case INDEX_op_ld16s:
+        case INDEX_op_ld16u:
+        case INDEX_op_ld32s:
+        case INDEX_op_ld32u:
             done = fold_tcg_ld(&ctx, op);
             break;
-        case INDEX_op_ld_i32:
-        case INDEX_op_ld_i64:
+        case INDEX_op_ld:
         case INDEX_op_ld_vec:
             done = fold_tcg_ld_memcopy(&ctx, op);
             break;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b0139ce05d..680f752cf9 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1379,27 +1379,27 @@ void tcg_gen_abs_i32(TCGv_i32 ret, TCGv_i32 a)
 
 void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ldst_op_i32(INDEX_op_ld8u_i32, ret, arg2, offset);
+    tcg_gen_ldst_op_i32(INDEX_op_ld8u, ret, arg2, offset);
 }
 
 void tcg_gen_ld8s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ldst_op_i32(INDEX_op_ld8s_i32, ret, arg2, offset);
+    tcg_gen_ldst_op_i32(INDEX_op_ld8s, ret, arg2, offset);
 }
 
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ldst_op_i32(INDEX_op_ld16u_i32, ret, arg2, offset);
+    tcg_gen_ldst_op_i32(INDEX_op_ld16u, ret, arg2, offset);
 }
 
 void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ldst_op_i32(INDEX_op_ld16s_i32, ret, arg2, offset);
+    tcg_gen_ldst_op_i32(INDEX_op_ld16s, ret, arg2, offset);
 }
 
 void tcg_gen_ld_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ldst_op_i32(INDEX_op_ld_i32, ret, arg2, offset);
+    tcg_gen_ldst_op_i32(INDEX_op_ld, ret, arg2, offset);
 }
 
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
@@ -1463,7 +1463,7 @@ void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg)
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_ld8u_i64, ret, arg2, offset);
+        tcg_gen_ldst_op_i64(INDEX_op_ld8u, ret, arg2, offset);
     } else {
         tcg_gen_ld8u_i32(TCGV_LOW(ret), arg2, offset);
         tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
@@ -1473,7 +1473,7 @@ void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_ld8s_i64, ret, arg2, offset);
+        tcg_gen_ldst_op_i64(INDEX_op_ld8s, ret, arg2, offset);
     } else {
         tcg_gen_ld8s_i32(TCGV_LOW(ret), arg2, offset);
         tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
@@ -1483,7 +1483,7 @@ void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_ld16u_i64, ret, arg2, offset);
+        tcg_gen_ldst_op_i64(INDEX_op_ld16u, ret, arg2, offset);
     } else {
         tcg_gen_ld16u_i32(TCGV_LOW(ret), arg2, offset);
         tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
@@ -1493,7 +1493,7 @@ void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_ld16s_i64, ret, arg2, offset);
+        tcg_gen_ldst_op_i64(INDEX_op_ld16s, ret, arg2, offset);
     } else {
         tcg_gen_ld16s_i32(TCGV_LOW(ret), arg2, offset);
         tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
@@ -1503,7 +1503,7 @@ void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_ld32u_i64, ret, arg2, offset);
+        tcg_gen_ldst_op_i64(INDEX_op_ld32u, ret, arg2, offset);
     } else {
         tcg_gen_ld_i32(TCGV_LOW(ret), arg2, offset);
         tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
@@ -1513,7 +1513,7 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_ld32s_i64, ret, arg2, offset);
+        tcg_gen_ldst_op_i64(INDEX_op_ld32s, ret, arg2, offset);
     } else {
         tcg_gen_ld_i32(TCGV_LOW(ret), arg2, offset);
         tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
@@ -1527,7 +1527,7 @@ void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
      * they cannot be the same temporary -- no chance of overlap.
      */
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_ld_i64, ret, arg2, offset);
+        tcg_gen_ldst_op_i64(INDEX_op_ld, ret, arg2, offset);
     } else if (HOST_BIG_ENDIAN) {
         tcg_gen_ld_i32(TCGV_HIGH(ret), arg2, offset);
         tcg_gen_ld_i32(TCGV_LOW(ret), arg2, offset + 4);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 5e8e8bf791..3f228db0e5 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1184,16 +1184,11 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_extract, TCGOutOpExtract, outop_extract),
     OUTOP(INDEX_op_extract2, TCGOutOpExtract2, outop_extract2),
-    OUTOP(INDEX_op_ld8u_i32, TCGOutOpLoad, outop_ld8u),
-    OUTOP(INDEX_op_ld8u_i64, TCGOutOpLoad, outop_ld8u),
-    OUTOP(INDEX_op_ld8s_i32, TCGOutOpLoad, outop_ld8s),
-    OUTOP(INDEX_op_ld8s_i64, TCGOutOpLoad, outop_ld8s),
-    OUTOP(INDEX_op_ld16u_i32, TCGOutOpLoad, outop_ld16u),
-    OUTOP(INDEX_op_ld16u_i64, TCGOutOpLoad, outop_ld16u),
-    OUTOP(INDEX_op_ld16s_i32, TCGOutOpLoad, outop_ld16s),
-    OUTOP(INDEX_op_ld16s_i64, TCGOutOpLoad, outop_ld16s),
-    OUTOP(INDEX_op_ld_i32, TCGOutOpLoad, outop_ld),
-    OUTOP(INDEX_op_ld_i64, TCGOutOpLoad, outop_ld),
+    OUTOP(INDEX_op_ld8u, TCGOutOpLoad, outop_ld8u),
+    OUTOP(INDEX_op_ld8s, TCGOutOpLoad, outop_ld8s),
+    OUTOP(INDEX_op_ld16u, TCGOutOpLoad, outop_ld16u),
+    OUTOP(INDEX_op_ld16s, TCGOutOpLoad, outop_ld16s),
+    OUTOP(INDEX_op_ld, TCGOutOpLoad, outop_ld),
     OUTOP(INDEX_op_movcond, TCGOutOpMovcond, outop_movcond),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_muls2, TCGOutOpMul2, outop_muls2),
@@ -1235,8 +1230,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_extu_i32_i64, TCGOutOpUnary, outop_extu_i32_i64),
     OUTOP(INDEX_op_extrl_i64_i32, TCGOutOpUnary, outop_extrl_i64_i32),
     OUTOP(INDEX_op_extrh_i64_i32, TCGOutOpUnary, outop_extrh_i64_i32),
-    OUTOP(INDEX_op_ld32u_i64, TCGOutOpLoad, outop_ld32u),
-    OUTOP(INDEX_op_ld32s_i64, TCGOutOpLoad, outop_ld32s),
+    OUTOP(INDEX_op_ld32u, TCGOutOpLoad, outop_ld32u),
+    OUTOP(INDEX_op_ld32s, TCGOutOpLoad, outop_ld32s),
 #endif
 };
 
@@ -2443,6 +2438,11 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_brcond:
     case INDEX_op_deposit:
     case INDEX_op_extract:
+    case INDEX_op_ld8u:
+    case INDEX_op_ld8s:
+    case INDEX_op_ld16u:
+    case INDEX_op_ld16s:
+    case INDEX_op_ld:
     case INDEX_op_mov:
     case INDEX_op_movcond:
     case INDEX_op_negsetcond:
@@ -2452,11 +2452,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_xor:
         return has_type;
 
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16s_i32:
-    case INDEX_op_ld_i32:
     case INDEX_op_st8_i32:
     case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
@@ -2466,13 +2461,8 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_setcond2_i32:
         return TCG_TARGET_REG_BITS == 32;
 
-    case INDEX_op_ld8u_i64:
-    case INDEX_op_ld8s_i64:
-    case INDEX_op_ld16u_i64:
-    case INDEX_op_ld16s_i64:
-    case INDEX_op_ld32u_i64:
-    case INDEX_op_ld32s_i64:
-    case INDEX_op_ld_i64:
+    case INDEX_op_ld32u:
+    case INDEX_op_ld32s:
     case INDEX_op_st8_i64:
     case INDEX_op_st16_i64:
     case INDEX_op_st32_i64:
@@ -4426,10 +4416,7 @@ liveness_pass_2(TCGContext *s)
             arg_ts = arg_temp(op->args[i]);
             dir_ts = arg_ts->state_ptr;
             if (dir_ts && arg_ts->state == TS_DEAD) {
-                TCGOpcode lopc = (arg_ts->type == TCG_TYPE_I32
-                                  ? INDEX_op_ld_i32
-                                  : INDEX_op_ld_i64);
-                TCGOp *lop = tcg_op_insert_before(s, op, lopc, 3);
+                TCGOp *lop = tcg_op_insert_before(s, op, INDEX_op_ld, 3);
 
                 TCGOP_TYPE(lop) = arg_ts->type;
                 lop->args[0] = temp_arg(dir_ts);
@@ -5761,20 +5748,13 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
-    case INDEX_op_ld32u_i64:
-    case INDEX_op_ld32s_i64:
-        tcg_debug_assert(type == TCG_TYPE_I64);
-        /* fall through */
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8u_i64:
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld8s_i64:
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16u_i64:
-    case INDEX_op_ld16s_i32:
-    case INDEX_op_ld16s_i64:
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld_i64:
+    case INDEX_op_ld8u:
+    case INDEX_op_ld8s:
+    case INDEX_op_ld16u:
+    case INDEX_op_ld16s:
+    case INDEX_op_ld32u:
+    case INDEX_op_ld32s:
+    case INDEX_op_ld:
         {
             const TCGOutOpLoad *out =
                 container_of(all_outop[op->opc], TCGOutOpLoad, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index a18478a07a..890ccbe85b 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -466,31 +466,30 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 
             /* Load/store operations (32 bit). */
 
-        CASE_32_64(ld8u)
+        case INDEX_op_ld8u:
             tci_args_rrs(insn, &r0, &r1, &ofs);
             ptr = (void *)(regs[r1] + ofs);
             regs[r0] = *(uint8_t *)ptr;
             break;
-        CASE_32_64(ld8s)
+        case INDEX_op_ld8s:
             tci_args_rrs(insn, &r0, &r1, &ofs);
             ptr = (void *)(regs[r1] + ofs);
             regs[r0] = *(int8_t *)ptr;
             break;
-        CASE_32_64(ld16u)
+        case INDEX_op_ld16u:
             tci_args_rrs(insn, &r0, &r1, &ofs);
             ptr = (void *)(regs[r1] + ofs);
             regs[r0] = *(uint16_t *)ptr;
             break;
-        CASE_32_64(ld16s)
+        case INDEX_op_ld16s:
             tci_args_rrs(insn, &r0, &r1, &ofs);
             ptr = (void *)(regs[r1] + ofs);
             regs[r0] = *(int16_t *)ptr;
             break;
-        case INDEX_op_ld_i32:
-        CASE_64(ld32u)
+        case INDEX_op_ld:
             tci_args_rrs(insn, &r0, &r1, &ofs);
             ptr = (void *)(regs[r1] + ofs);
-            regs[r0] = *(uint32_t *)ptr;
+            regs[r0] = *(tcg_target_ulong *)ptr;
             break;
         CASE_32_64(st8)
             tci_args_rrs(insn, &r0, &r1, &ofs);
@@ -716,16 +715,16 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 #if TCG_TARGET_REG_BITS == 64
             /* Load/store operations (64 bit). */
 
-        case INDEX_op_ld32s_i64:
+        case INDEX_op_ld32u:
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            regs[r0] = *(uint32_t *)ptr;
+            break;
+        case INDEX_op_ld32s:
             tci_args_rrs(insn, &r0, &r1, &ofs);
             ptr = (void *)(regs[r1] + ofs);
             regs[r0] = *(int32_t *)ptr;
             break;
-        case INDEX_op_ld_i64:
-            tci_args_rrs(insn, &r0, &r1, &ofs);
-            ptr = (void *)(regs[r1] + ofs);
-            regs[r0] = *(uint64_t *)ptr;
-            break;
         case INDEX_op_st_i64:
             tci_args_rrs(insn, &r0, &r1, &ofs);
             ptr = (void *)(regs[r1] + ofs);
@@ -970,18 +969,12 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
         info->fprintf_func(info->stream, "%-12s", op_name);
         break;
 
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8u_i64:
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld8s_i64:
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16u_i64:
-    case INDEX_op_ld16s_i32:
-    case INDEX_op_ld16s_i64:
-    case INDEX_op_ld32u_i64:
-    case INDEX_op_ld32s_i64:
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld_i64:
+    case INDEX_op_ld8u:
+    case INDEX_op_ld8s:
+    case INDEX_op_ld16u:
+    case INDEX_op_ld16s:
+    case INDEX_op_ld32u:
+    case INDEX_op_ld:
     case INDEX_op_st8_i32:
     case INDEX_op_st8_i64:
     case INDEX_op_st16_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 2dcd561b77..d549dc90f5 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -339,18 +339,12 @@ static void tcg_out_ldst(TCGContext *s, TCGOpcode op, TCGReg val,
 static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
                        intptr_t offset)
 {
-    switch (type) {
-    case TCG_TYPE_I32:
-        tcg_out_ldst(s, INDEX_op_ld_i32, val, base, offset);
-        break;
-#if TCG_TARGET_REG_BITS == 64
-    case TCG_TYPE_I64:
-        tcg_out_ldst(s, INDEX_op_ld_i64, val, base, offset);
-        break;
-#endif
-    default:
-        g_assert_not_reached();
+    TCGOpcode op = INDEX_op_ld;
+
+    if (TCG_TARGET_REG_BITS == 64 && type == TCG_TYPE_I32) {
+        op = INDEX_op_ld32u;
     }
+    tcg_out_ldst(s, op, val, base, offset);
 }
 
 static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
@@ -1132,7 +1126,7 @@ static void tcg_out_br(TCGContext *s, TCGLabel *l)
 static void tgen_ld8u(TCGContext *s, TCGType type, TCGReg dest,
                       TCGReg base, ptrdiff_t offset)
 {
-    tcg_out_ldst(s, INDEX_op_ld8u_i32, dest, base, offset);
+    tcg_out_ldst(s, INDEX_op_ld8u, dest, base, offset);
 }
 
 static const TCGOutOpLoad outop_ld8u = {
@@ -1143,7 +1137,7 @@ static const TCGOutOpLoad outop_ld8u = {
 static void tgen_ld8s(TCGContext *s, TCGType type, TCGReg dest,
                       TCGReg base, ptrdiff_t offset)
 {
-    tcg_out_ldst(s, INDEX_op_ld8s_i32, dest, base, offset);
+    tcg_out_ldst(s, INDEX_op_ld8s, dest, base, offset);
 }
 
 static const TCGOutOpLoad outop_ld8s = {
@@ -1154,7 +1148,7 @@ static const TCGOutOpLoad outop_ld8s = {
 static void tgen_ld16u(TCGContext *s, TCGType type, TCGReg dest,
                        TCGReg base, ptrdiff_t offset)
 {
-    tcg_out_ldst(s, INDEX_op_ld16u_i32, dest, base, offset);
+    tcg_out_ldst(s, INDEX_op_ld16u, dest, base, offset);
 }
 
 static const TCGOutOpLoad outop_ld16u = {
@@ -1165,7 +1159,7 @@ static const TCGOutOpLoad outop_ld16u = {
 static void tgen_ld16s(TCGContext *s, TCGType type, TCGReg dest,
                        TCGReg base, ptrdiff_t offset)
 {
-    tcg_out_ldst(s, INDEX_op_ld16s_i32, dest, base, offset);
+    tcg_out_ldst(s, INDEX_op_ld16s, dest, base, offset);
 }
 
 static const TCGOutOpLoad outop_ld16s = {
@@ -1177,7 +1171,7 @@ static const TCGOutOpLoad outop_ld16s = {
 static void tgen_ld32u(TCGContext *s, TCGType type, TCGReg dest,
                        TCGReg base, ptrdiff_t offset)
 {
-    tcg_out_ldst(s, INDEX_op_ld32u_i64, dest, base, offset);
+    tcg_out_ldst(s, INDEX_op_ld32u, dest, base, offset);
 }
 
 static const TCGOutOpLoad outop_ld32u = {
@@ -1188,7 +1182,7 @@ static const TCGOutOpLoad outop_ld32u = {
 static void tgen_ld32s(TCGContext *s, TCGType type, TCGReg dest,
                        TCGReg base, ptrdiff_t offset)
 {
-    tcg_out_ldst(s, INDEX_op_ld32s_i64, dest, base, offset);
+    tcg_out_ldst(s, INDEX_op_ld32s, dest, base, offset);
 }
 
 static const TCGOutOpLoad outop_ld32s = {
-- 
2.43.0


