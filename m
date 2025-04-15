Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1DDC369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4lzN-0000HX-Bq; Tue, 15 Apr 2025 15:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lzB-0007vI-71
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:21 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4ly0-0000kb-Sr
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:16 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-306bf444ba2so5263642a91.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745339; x=1745350139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hEWg/oIMpuBs+3jhlMRcdwUgLS/ueCEQDexTQdwErGg=;
 b=vS8AKPwca14fHNxMAEkTXWBGIBCVOfDZCtbDo4LQb3MvuaA0oMWTJ42G3Z/uOc16J7
 Wa8qnTjC+MaCeP6864hJheyPp8wFSDKNis8s0SI7DkCoT2v6KRxBtVMZNTyljgZpn6Sr
 VCSkzVr2Q94tMM7NimgDrNv7X/Xsg6SFm1F57HMIsAhk70vtTeybOzJylv2TbUSZnzyJ
 D3BYa/wca+WQes9AWhVABdfPwPZ087rAM1xVsqrpZV7DY9mj2rZDsNxAS7F+ivXAGULv
 FlNAvoo8DxndzZNlc0xInmM86bQi6Gyhs0Az5X/3PhbKe61owISih5YTkqt+5L6GQyY0
 HD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745339; x=1745350139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hEWg/oIMpuBs+3jhlMRcdwUgLS/ueCEQDexTQdwErGg=;
 b=O53KFxYaxXPaNPJU086PKoRLSQhy45FmSdEz+K3Ofnc+dP9om+941UiTPHK95ngIXx
 YFtK1w/pwtvAZTGRDb23BzRypAYORt1fXDZ/FDskbVbEelBW2w9IXP3tIjyKJK4ywDBh
 qWlPdV7fu8xZOBcbSHOtqqeLTANlr1QMrhM0YOYBfQkMpznrQPvX3BIF7WBHIWHRBJf/
 mVTIQwWj77DtmZvXMAyhLXMIHaOjmjYykK1ABSNdFPBimTcT3hvq1glvHSBhgIlAoGRL
 MHV+sCThESuda3rmCuGkeU6pLUKsnFig/HRB1fFfy3FyXKi7ZnAykUg0yEPKPl+eiV3U
 v5Xw==
X-Gm-Message-State: AOJu0Yz+KTViVca56g7uzy+Z5BdaAgZ4WNwvNU57sJDof60MFdANYkzI
 6ikvPjkdX3NI4jmGeFBBQB68i0fh8BcRiGOHWORFpguWBYeZAAi/THYMj/Ez7FGh0JqXKa0vBYZ
 A
X-Gm-Gg: ASbGncssniBM3msl/qVq5EAddXJb73PI1S7TeQWpIHdRuOlQKug+jf8YPV58buXngQu
 KU+hIVWxeQutwJAh4IC0OnvYr2c8URIqRdEFALQf81HsdiqGx2TPCBTvScj5rN37m77R/qowzpm
 NiQrWtdYwNO426HOIckUwAaijLsTMkUFjK53vV8rWTAx5QLdVdWA2Eumvsg3zbfzzsVUoPYFttu
 nQanhkoRQTcIVz2v8yPHS4Fpu9YxLWm6kFK4nxLc0bTVTLnOYcZDXo40VYK+h1N+LuxA9AW7wv6
 NKDSusblQyvhdwYSVse65VtpLMs0jztrDvYeJo25CpJgA2/eDUnGd1Y8mqR/e/uzG3KONfqsmg4
 =
X-Google-Smtp-Source: AGHT+IHafz1kcCn6dGcyTWWJdfx9HHaabvVL7Akj4ht9BJxLUrRIH7HzejrWz2ObPlDLB/f4qrw8Ng==
X-Received: by 2002:a17:90b:5403:b0:2ee:94d1:7a89 with SMTP id
 98e67ed59e1d1-3085eecbff5mr546471a91.1.1744745338845; 
 Tue, 15 Apr 2025 12:28:58 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df06a165sm13534812a91.4.2025.04.15.12.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:28:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 048/163] tcg: Merge INDEX_op_divu2_{i32,i64}
Date: Tue, 15 Apr 2025 12:23:19 -0700
Message-ID: <20250415192515.232910-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 1f95c9c3f7..272c59455b 100644
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
@@ -5468,8 +5467,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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


