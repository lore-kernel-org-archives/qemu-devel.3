Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0165C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnqU-0001JK-11; Sun, 16 Feb 2025 18:14:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnph-0000ix-Tv
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:13:54 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnpf-0005Pm-2F
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:13:53 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-220ecbdb4c2so67730025ad.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747629; x=1740352429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Jl1ZfhcgCgzrFG5/5eaCDsJ5cRorT/0gbeNGiEskqDE=;
 b=frBr+cDjyoSwB68CqOZdhLIeE3Ur+hN9hNPS3fdpjQaQBAKYsjZ+12C4t2nh4tfsxQ
 zeUzx/oN4FhOZm8FkosjhxfBDA5+uu3d/KsQ51CuxxH+USajSuz4PE6V4tPs+yAtsfrw
 rDO3SpgY6D9NZncdmMksKCM5N0Uz15Ua8Ikf1c8Twk3SwokpJyVF+b6SAsDL7hEjajFp
 lEK84ImIBKhc72weIrmjOMNofPkMpqQepnlnCKnT9EJtf++j9j2N76thOk1lwvi2bVnx
 /gbwCWF2m1WtpWsAZYV/EZLWy2TBGJ/xy5D+xrQsaVZelB3fYdc6U+sfp/FD5pN6Dcl5
 jq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747629; x=1740352429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jl1ZfhcgCgzrFG5/5eaCDsJ5cRorT/0gbeNGiEskqDE=;
 b=A2ZrlN9SCr4D2e5bDMAmlj7TEBhj2UJhMCsNFtSFKlHF9+BcqUQStol9Na1UPqmONQ
 Uibr5MowqFYGjITTmd/pNJn/xm4kFU+YxQ7F8eCAcAkaiPhux6U22Vf63UYRmid11TEH
 tEqdBslaXvA+oRS4A1enKlamzKaJ2S9o+/GjLRjbwkG7Rz58gupCPyYLss4F2Bsg8iko
 eSqtQMPPDIWUczDlFdlkYRkg44O9Dsj5TTMfP4qIt9uY6MzjGiRi7KA30Q98kS/5QL8K
 xPwaFkIVSaNqV4Lezz201AWaQ5fO7s9766ySyz2rRxaHwN+J0lfqUahmNmqyuPYastie
 YT/w==
X-Gm-Message-State: AOJu0YxOkgwXJ0Ql9nr0yvgzyEMldjKU9B6HapKhL+nOME2oVbdU/RjP
 W2x+IU9+sZqQjZ5k51gwuOU8QJitVdXKRl0IQ+aIcFJr2inXClRt6iAWbhi6hddCZ4MBsBrfwbE
 G
X-Gm-Gg: ASbGncshS7J0tPFqcLLveV+UqTXo8xAZgPkXK62h5Q7f3B3m2ciM6fP4YdstY9p5VDc
 auzbkMX6wG/SSsjabG42CMKu7l2xBjAg6z4TkgZB9t1sjtRwMpt7YF6C7sZ2QpFGUaxNA6bC5Al
 QB/thfWrM69cWzM/OUzdXvTifezUwMkndDWYNYk/H3jzU0dBsQl7jqZckcae6DQr/TE6MxZ5lAH
 TlR3t5N19HApW/8r8l5QULJbW5WRVt7p4KSdOIaqkRSb6XqQUe7ZOgqsaR9GX7rpctTDK/HriL/
 ya7Hb/nuR1uIduo9KTJ5AS8fog9UKO5nXI+VuzuYfkJzXc0=
X-Google-Smtp-Source: AGHT+IETp9rlfimarwnWyyeZn+mydRK454J7J17bJ0C3aDSD0WbOxilBXoRS7hqs5nPG+XcawCsN9A==
X-Received: by 2002:a17:903:1d0:b0:215:6816:6345 with SMTP id
 d9443c01a7336-2211c5501dbmr65102605ad.16.1739747628679; 
 Sun, 16 Feb 2025 15:13:48 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366882sm60565615ad.95.2025.02.16.15.13.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:13:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 045/162] tcg: Merge INDEX_op_div2_{i32,i64}
Date: Sun, 16 Feb 2025 15:08:14 -0800
Message-ID: <20250216231012.2808572-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Rename to INDEX_op_divs2 to emphasize signed inputs,
and mirroring INDEX_op_divu2_*.  Document the opcode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h  |  3 +--
 tcg/tcg-op.c           | 16 ++++++++--------
 tcg/tcg.c              |  6 ++----
 docs/devel/tcg-ops.rst |  9 +++++++++
 4 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 243f002a61..36dfbf80ad 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -43,6 +43,7 @@ DEF(add, 1, 2, 0, TCG_OPF_INT)
 DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
 DEF(divs, 1, 2, 0, TCG_OPF_INT)
+DEF(divs2, 2, 3, 0, TCG_OPF_INT)
 DEF(divu, 1, 2, 0, TCG_OPF_INT)
 DEF(eqv, 1, 2, 0, TCG_OPF_INT)
 DEF(mul, 1, 2, 0, TCG_OPF_INT)
@@ -72,7 +73,6 @@ DEF(st_i32, 0, 2, 1, 0)
 /* arith */
 DEF(rem_i32, 1, 2, 0, 0)
 DEF(remu_i32, 1, 2, 0, 0)
-DEF(div2_i32, 2, 3, 0, 0)
 DEF(divu2_i32, 2, 3, 0, 0)
 /* shifts/rotates */
 DEF(shl_i32, 1, 2, 0, 0)
@@ -118,7 +118,6 @@ DEF(st_i64, 0, 2, 1, 0)
 /* arith */
 DEF(rem_i64, 1, 2, 0, 0)
 DEF(remu_i64, 1, 2, 0, 0)
-DEF(div2_i64, 2, 3, 0, 0)
 DEF(divu2_i64, 2, 3, 0, 0)
 /* shifts/rotates */
 DEF(shl_i64, 1, 2, 0, 0)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index f326c452a4..f95beb8b5d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -603,10 +603,10 @@ void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I32, 0)) {
         tcg_gen_op3_i32(INDEX_op_divs, ret, arg1, arg2);
-    } else if (TCG_TARGET_HAS_div2_i32) {
+    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I32, 0)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         tcg_gen_sari_i32(t0, arg1, 31);
-        tcg_gen_op5_i32(INDEX_op_div2_i32, ret, t0, arg1, t0, arg2);
+        tcg_gen_op5_i32(INDEX_op_divs2, ret, t0, arg1, t0, arg2);
         tcg_temp_free_i32(t0);
     } else {
         gen_helper_div_i32(ret, arg1, arg2);
@@ -623,10 +623,10 @@ void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_mul_i32(t0, t0, arg2);
         tcg_gen_sub_i32(ret, arg1, t0);
         tcg_temp_free_i32(t0);
-    } else if (TCG_TARGET_HAS_div2_i32) {
+    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I32, 0)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         tcg_gen_sari_i32(t0, arg1, 31);
-        tcg_gen_op5_i32(INDEX_op_div2_i32, t0, ret, arg1, t0, arg2);
+        tcg_gen_op5_i32(INDEX_op_divs2, t0, ret, arg1, t0, arg2);
         tcg_temp_free_i32(t0);
     } else {
         gen_helper_rem_i32(ret, arg1, arg2);
@@ -1971,10 +1971,10 @@ void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I64, 0)) {
         tcg_gen_op3_i64(INDEX_op_divs, ret, arg1, arg2);
-    } else if (TCG_TARGET_HAS_div2_i64) {
+    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I64, 0)) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         tcg_gen_sari_i64(t0, arg1, 63);
-        tcg_gen_op5_i64(INDEX_op_div2_i64, ret, t0, arg1, t0, arg2);
+        tcg_gen_op5_i64(INDEX_op_divs2, ret, t0, arg1, t0, arg2);
         tcg_temp_free_i64(t0);
     } else {
         gen_helper_div_i64(ret, arg1, arg2);
@@ -1991,10 +1991,10 @@ void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_mul_i64(t0, t0, arg2);
         tcg_gen_sub_i64(ret, arg1, t0);
         tcg_temp_free_i64(t0);
-    } else if (TCG_TARGET_HAS_div2_i64) {
+    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I64, 0)) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         tcg_gen_sari_i64(t0, arg1, 63);
-        tcg_gen_op5_i64(INDEX_op_div2_i64, t0, ret, arg1, t0, arg2);
+        tcg_gen_op5_i64(INDEX_op_divs2, t0, ret, arg1, t0, arg2);
         tcg_temp_free_i64(t0);
     } else {
         gen_helper_rem_i64(ret, arg1, arg2);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index b6843d5a19..f0d1e60a5d 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1028,8 +1028,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_divs, TCGOutOpBinary, outop_divs),
     OUTOP(INDEX_op_divu, TCGOutOpBinary, outop_divu),
-    OUTOP(INDEX_op_div2_i32, TCGOutOpDivRem, outop_divs2),
-    OUTOP(INDEX_op_div2_i64, TCGOutOpDivRem, outop_divs2),
+    OUTOP(INDEX_op_divs2, TCGOutOpDivRem, outop_divs2),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_mulsh, TCGOutOpBinary, outop_mulsh),
@@ -5461,8 +5460,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
-    case INDEX_op_div2_i32:
-    case INDEX_op_div2_i64:
+    case INDEX_op_divs2:
         {
             const TCGOutOpDivRem *out =
                 container_of(all_outop[op->opc], TCGOutOpDivRem, base);
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 41985be012..62af390854 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -297,6 +297,15 @@ Arithmetic
      - | *t0* = *t1* % *t2* (unsigned)
        | Undefined behavior if division by zero.
 
+   * - divs2 *q*, *r*, *nl*, *nh*, *d*
+
+     - | *q* = *nh:nl* / *d* (signed)
+       | *r* = *nh:nl* % *d*
+       | Undefined behaviour if division by zero, or the double-word
+         numerator divided by the single-word divisor does not fit
+         within the single-word quotient.  The code generator will
+         pass *nh* as a simple sign-extension of *nl*, so the only
+         overflow should be *INT_MIN* / -1.
 
 Logical
 -------
-- 
2.43.0


