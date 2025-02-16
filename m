Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C717C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnyr-0000TS-Fm; Sun, 16 Feb 2025 18:23:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwv-0004bF-KU
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:22 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwo-0006VK-Kq
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:20 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2fc1c80cdc8so4963023a91.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748073; x=1740352873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YV1ZAFowI8H4Sjs3aWsEl+9QvN1RGuzgRm8mryKOzIM=;
 b=xMDhCHTyd3v5QMhMo/KrSjdCCHJb20E6s6cWrhOJ628VD1chQqzxMuMl0Pexv/mpQU
 hRA9Vkhuvdio8zvP3wvtKubszl+cfoYVcOISdvYRMpZuSsxrZ+lGeOSP6+DYbgNzG7Wt
 pDQuJy0AFBaWQ0S+5NyI1Z0hbwvw03kSgbgsFkTgxSb7IvdQ2qvi1Rs5wyorqj6YDk2j
 DQI52FiOPI7Jw40DBsjBrk0cTnSfweDxS0+8EMSkibnTTK94MYJCIefD0ZaxkLdYybtd
 ISS3EgtYOPP+kaH+GPtaoQf00l+QNVns+sa1NCpyQSAhg1n4iS8hjWII9juxxAML/GRC
 YbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748073; x=1740352873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YV1ZAFowI8H4Sjs3aWsEl+9QvN1RGuzgRm8mryKOzIM=;
 b=em0I87fkl5N/CtO1t8faosHV2Irk7GCRQENoYTkwloTYBnP5qrucN46H3kHDQYD4Lz
 JY6hsrYqupFuJATSLQw2y/fZGLF3tYUarUq13aYkENqy7RfxpA9CQV2DSx77Vx1fjEr6
 U9wq+pc/zM/3BUVkFRHqQ68PF85xhYElhTRfYxtVuF8EDzxCczIpXZb+QBgZ4+b3za9f
 t3w2Ki4hqzkTueybchte8zTrFcekh1RlTkxrZx+Pupks6Duhb3f/zsDrBmj7rNnmznAA
 35oZ6jXK5ZEcVQ5T1MBokDAHjEL/X4uQPcn5gpGN/KX2+6doJI0MNFXppklY/sp/iAsH
 DedA==
X-Gm-Message-State: AOJu0YwgEgzK49qYzfZzVqFIplWbcZhIQ7xzSYNADVM3Hfi0TkKPFybR
 KQVu3M8kM5lFOlIn4uwxMnDXo1IyKMhc98MKfC0Kh/Z/PTql7cePJ9S7tvx6gPeCih2IQucNBL7
 2
X-Gm-Gg: ASbGncvxCXOqHcIOx1TRxmdcSLzFl+2t2z57sr5ZAA+UsFpBsM8JzqcoZbJrfsruRQ6
 2BJbHDnozIp4mIdjqp8+zMsRujnjF7EDErR+4Wb1e2BxSGuChxxicgXSvl6lHVGg6WEqwSGtTFD
 ZJ6FLDHfau0jGM0GbNl5aayFJ2kdIa/ys/PBn3yyaW5q6Csltp02ra/t0IZZ4y9WsUgbYATmneW
 /ru5c5mFYlBglOCwCgBG/drgsI8W1z8wqGTZqw+JxOwXCjicmQp7/wBc3oNAXJlpQx9TsFJuDF7
 E7P8YDfIQ5nvbbh9zAJaonixYTllRLp2caRYYrUftI7s4cU=
X-Google-Smtp-Source: AGHT+IF0+InBSj7PNdwnYX1ENEgZFC/p8bSnKwLjYAVAOGvk6TnJw+ZwXfjIP2pI6PrCUjaDXNt28Q==
X-Received: by 2002:a17:90b:3b92:b0:2ea:5dea:eb0a with SMTP id
 98e67ed59e1d1-2fc40d14b07mr12253682a91.4.1739748072650; 
 Sun, 16 Feb 2025 15:21:12 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.21.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:21:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 154/162] tcg: Merge INDEX_op_ld*_{i32,i64}
Date: Sun, 16 Feb 2025 15:10:03 -0800
Message-ID: <20250216231012.2808572-155-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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
index 16f66d5b88..e2d5cfe481 100644
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
@@ -4401,10 +4391,7 @@ liveness_pass_2(TCGContext *s)
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
@@ -5727,20 +5714,13 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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


