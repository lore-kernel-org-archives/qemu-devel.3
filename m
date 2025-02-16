Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F40C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnrF-000449-FC; Sun, 16 Feb 2025 18:15:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnpi-0000iz-Bq
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:13:56 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnpg-0005Q4-7E
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:13:54 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2f9d3d0f55dso5325537a91.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747630; x=1740352430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+RqV8askuqxEraqBLEZUupQq4Oxzm8ST2nfX4OInbgE=;
 b=gwoYr0nWdHE3Ee4ORrzbnfZ7rJZ0t6KPhgWUtkh6AGNzAqxiC/o7rZEC9cIqA6FW34
 0ophrW+u8WzNLKwaVIYWJdWT7HLTVEJDwLU62KasVbjTvnhcQ97mCkniH2tfnfYLbYWR
 VgdZDihsJ/YKRLW0CEwvpvzeqtbOPNdApewITO49Z9BsnjKDU3ekA5Ed2mapejvGeP1G
 xXW+cyU0c+khBw4tUOyzBN/EDU6+9JaJBjBpmueXFss23aIWrx1+WhMm313lG8ZjJT8j
 nFumpZA/JQ+T8+eL84R7mkQ/rxhtntCojbLOYfM9nJ76zKdqSpANEFrBeb1zkf2lQH5S
 tqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747630; x=1740352430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+RqV8askuqxEraqBLEZUupQq4Oxzm8ST2nfX4OInbgE=;
 b=Af3/g2NgIQD5Jb6tEBqc7T6GNS1FOvDAPEc7kfyryuEuVfersm/cVIZTxgkEgCXlMk
 6vXX2VJEV2Dl0zl5etuT3JhuQHPKDBd/HM5Tr+CD6S78XSKe/xD+9ybXTCVnD5klmL6i
 awCO3wrFKiJlwaEC8xRQh+ljdReBjfMNIV4ZYcZon/F4fGxP7BFg8mp2zsIXm5k85b9h
 KDsGR19lRNIjn60H/vrs9I6UWIRBPg14zlyvurq4IpdDNMLRiAQj8iclFa+Dg6q3U/FV
 sZ9sI/CZQMZPLAYi8K3H0CLF2Ju5bfMRtCvfajG8d7qYWDxBxZ0z4d2jfqXPMAaSQZXg
 pIVA==
X-Gm-Message-State: AOJu0YzuX5mFvohR17Tww14iKeNsmGS9poLNy7PeGZyGZcOcKLUyU3LJ
 tvLqcJqSlxGwfYsdiQgLP1WMobBl2/QBOzy47nBWxA4jIAr6Xged0E2Lf7SZtAOuI3uN/d0o6yY
 T
X-Gm-Gg: ASbGncvNc724uws7401A+IEWaJIL3seXsAuQL2BAVyywvedOaCvoHEaimNVPIE9BQ5h
 CECtMR5vSlAQSOPS8+ba6FNBKdsbJHwXxcrRtXLoL+HwoMOWOShDU84Um3ylowUB79i2H4khnza
 bZQsaHH8AgNmqaIf4dzWl6BAxbymqfjdy+Y6gUt+dbgyEap0rGG0/OnN3AxbXihFpxmGI484SWE
 niYp9oWWUKNHX07n06eVcTkUYwJrKtlPkt6/6x4g9TGl199LW094aEGYM7Qn11IQVPWwgo8CGNN
 G4IBFXNV5mTp4PUBwR0/RZugpfM5OeO7MSeSzR8El4rOCeE=
X-Google-Smtp-Source: AGHT+IGIuhbf+JFteaWU74dzYLEISNacDD/CZjOEL4hzuyFHihX75kEKtteQBOyxnAQUmxG60JuaDQ==
X-Received: by 2002:a17:90b:4ad0:b0:2ee:ab29:1a63 with SMTP id
 98e67ed59e1d1-2fc40d14af1mr11615322a91.3.1739747630325; 
 Sun, 16 Feb 2025 15:13:50 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366882sm60565615ad.95.2025.02.16.15.13.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:13:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 047/162] tcg: Merge INDEX_op_divu2_{i32,i64}
Date: Sun, 16 Feb 2025 15:08:16 -0800
Message-ID: <20250216231012.2808572-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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
 include/tcg/tcg-opc.h  |  3 +--
 tcg/tcg-op.c           | 16 ++++++++--------
 tcg/tcg.c              |  6 ++----
 docs/devel/tcg-ops.rst | 10 ++++++++++
 4 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 36dfbf80ad..61e5e185cc 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -45,6 +45,7 @@ DEF(andc, 1, 2, 0, TCG_OPF_INT)
 DEF(divs, 1, 2, 0, TCG_OPF_INT)
 DEF(divs2, 2, 3, 0, TCG_OPF_INT)
 DEF(divu, 1, 2, 0, TCG_OPF_INT)
+DEF(divu2, 2, 3, 0, TCG_OPF_INT)
 DEF(eqv, 1, 2, 0, TCG_OPF_INT)
 DEF(mul, 1, 2, 0, TCG_OPF_INT)
 DEF(mulsh, 1, 2, 0, TCG_OPF_INT)
@@ -73,7 +74,6 @@ DEF(st_i32, 0, 2, 1, 0)
 /* arith */
 DEF(rem_i32, 1, 2, 0, 0)
 DEF(remu_i32, 1, 2, 0, 0)
-DEF(divu2_i32, 2, 3, 0, 0)
 /* shifts/rotates */
 DEF(shl_i32, 1, 2, 0, 0)
 DEF(shr_i32, 1, 2, 0, 0)
@@ -118,7 +118,6 @@ DEF(st_i64, 0, 2, 1, 0)
 /* arith */
 DEF(rem_i64, 1, 2, 0, 0)
 DEF(remu_i64, 1, 2, 0, 0)
-DEF(divu2_i64, 2, 3, 0, 0)
 /* shifts/rotates */
 DEF(shl_i64, 1, 2, 0, 0)
 DEF(shr_i64, 1, 2, 0, 0)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 5511106554..7ed92157de 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -637,10 +637,10 @@ void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
         tcg_gen_op3_i32(INDEX_op_divu, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu2_i32, TCG_TYPE_I32, 0)) {
+    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I32, 0)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 zero = tcg_constant_i32(0);
-        tcg_gen_op5_i32(INDEX_op_divu2_i32, ret, t0, arg1, zero, arg2);
+        tcg_gen_op5_i32(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
         tcg_temp_free_i32(t0);
     } else {
         gen_helper_divu_i32(ret, arg1, arg2);
@@ -657,10 +657,10 @@ void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_mul_i32(t0, t0, arg2);
         tcg_gen_sub_i32(ret, arg1, t0);
         tcg_temp_free_i32(t0);
-    } else if (tcg_op_supported(INDEX_op_divu2_i32, TCG_TYPE_I32, 0)) {
+    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I32, 0)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 zero = tcg_constant_i32(0);
-        tcg_gen_op5_i32(INDEX_op_divu2_i32, t0, ret, arg1, zero, arg2);
+        tcg_gen_op5_i32(INDEX_op_divu2, t0, ret, arg1, zero, arg2);
         tcg_temp_free_i32(t0);
     } else {
         gen_helper_remu_i32(ret, arg1, arg2);
@@ -2005,10 +2005,10 @@ void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
         tcg_gen_op3_i64(INDEX_op_divu, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu2_i64, TCG_TYPE_I64, 0)) {
+    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I64, 0)) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 zero = tcg_constant_i64(0);
-        tcg_gen_op5_i64(INDEX_op_divu2_i64, ret, t0, arg1, zero, arg2);
+        tcg_gen_op5_i64(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
         tcg_temp_free_i64(t0);
     } else {
         gen_helper_divu_i64(ret, arg1, arg2);
@@ -2025,10 +2025,10 @@ void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_mul_i64(t0, t0, arg2);
         tcg_gen_sub_i64(ret, arg1, t0);
         tcg_temp_free_i64(t0);
-    } else if (tcg_op_supported(INDEX_op_divu2_i64, TCG_TYPE_I64, 0)) {
+    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I64, 0)) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 zero = tcg_constant_i64(0);
-        tcg_gen_op5_i64(INDEX_op_divu2_i64, t0, ret, arg1, zero, arg2);
+        tcg_gen_op5_i64(INDEX_op_divu2, t0, ret, arg1, zero, arg2);
         tcg_temp_free_i64(t0);
     } else {
         gen_helper_remu_i64(ret, arg1, arg2);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 43122a97c6..560755bad8 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1029,8 +1029,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_divs, TCGOutOpBinary, outop_divs),
     OUTOP(INDEX_op_divu, TCGOutOpBinary, outop_divu),
     OUTOP(INDEX_op_divs2, TCGOutOpDivRem, outop_divs2),
-    OUTOP(INDEX_op_divu2_i32, TCGOutOpDivRem, outop_divu2),
-    OUTOP(INDEX_op_divu2_i64, TCGOutOpDivRem, outop_divu2),
+    OUTOP(INDEX_op_divu2, TCGOutOpDivRem, outop_divu2),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_mulsh, TCGOutOpBinary, outop_mulsh),
@@ -5459,8 +5458,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         break;
 
     case INDEX_op_divs2:
-    case INDEX_op_divu2_i32:
-    case INDEX_op_divu2_i64:
+    case INDEX_op_divu2:
         {
             const TCGOutOpDivRem *out =
                 container_of(all_outop[op->opc], TCGOutOpDivRem, base);
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 62af390854..8f3b5e91b2 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -307,6 +307,16 @@ Arithmetic
          pass *nh* as a simple sign-extension of *nl*, so the only
          overflow should be *INT_MIN* / -1.
 
+   * - divu2 *q*, *r*, *nl*, *nh*, *d*
+
+     - | *q* = *nh:nl* / *d* (unsigned)
+       | *r* = *nh:nl* % *d*
+       | Undefined behaviour if division by zero, or the double-word
+         numerator divided by the single-word divisor does not fit
+         within the single-word quotient.  The code generator will
+         pass 0 to *nh* to make a simple zero-extension of *nl*,
+         so overflow should never occur.
+
 Logical
 -------
 
-- 
2.43.0


