Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA88C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R4S-00024S-JQ; Fri, 25 Apr 2025 17:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4B-00012I-4J
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:39 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R48-0000oc-LS
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:38 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-225477548e1so32317015ad.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618315; x=1746223115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ALP26Cf++aCjrGudnIR9DFN+C0xgJyP9gZtLYitiicc=;
 b=s4VlVf/jAqv6jrf9RA43F40x5+nrwgyuA5Jyfvs/6VLu8dXVoBFXCFYpWAbIXapoip
 gzkwMVt8Gn9tZkmthRbHZ7wR+c+llz4eabBbGZ/DQy8yjE/GE4zA3Gg1sL3cRHT9NskB
 55kVeEX7RtR/1gcNv7ALv221fBU0XqLuf7hYaE5l9WjhX8dFt/IP1nVQi69yEOAJLEJn
 n4SGgw9AWnbhIaVSAteJmO3Q+TIft7H7emCLBq1Q0P08Eu2M4M35X9WL//J1zb2Ewvej
 FuNKmAOg2wLg1xMrOFQ2hbBe/xbVexLwugJX3BV6L4905470ppE4rBV+hCV4bnQcQ4SM
 8miA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618315; x=1746223115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ALP26Cf++aCjrGudnIR9DFN+C0xgJyP9gZtLYitiicc=;
 b=kU/1HvUWzXV0nAOkgr713fTC26q64/EeKrUDNdVYXPiCVp8zs2BHeYpstCPbmMJKmK
 waUPPTyn18EjOL51v3owjQixMDbiLG9coWWlevgtrZm6AifTR8C3sEewJYPPtt+9BjmN
 8eOAeNF8ePAtxN4jOs1aAIJdrxCtlpBiTR+LgsYX1LaVxeFnCUlQZjKugsmXGt7ma7Iq
 uH1Ski6oJYj/HpQ8qn1Kq81iLzi0mkM+XQqioqFg/48wvhyW9P0T/4GPy7Zy9fajkqxt
 48szaz2vzSN0xtJ9YC7U1oe8k7e9+fde35s825Xqf1q3Z/VAO/F7zfpE2e0+AtSdyUUH
 k3Lw==
X-Gm-Message-State: AOJu0Yyo3LOKhxjUIyEUCdENnMQxR7oSVkU9yg42bT/rpFXWHcGwdQwl
 QYgqQI9IGA4r1/8tTw0mvqipg2Ny2I71VAeRiNCthgW+z750/oC3CxEoLYCee0l9pjKY0n9V0N1
 m
X-Gm-Gg: ASbGnctesBZxLJh/5eddj0wc4J+xKy9ZROypCm65+PGQHtX8VEeZ70bjbov2WPCi4TE
 uZ8IK6bieB3qpz21HIaU9H4TSbuhiK6Q+eQ5vj1IwmexSpNtTnv32hJ9FRxTt7FSQfK0hUzspZ3
 5MpbA7hztuy0gmVxJwXlMpVb7RJNKmB+lu3BgLRSWsKl0+i+AxUDEWmHy5S9zUD6BeofBNsbAze
 7KAfKwX/T4RPeuMTvsr/5f88zyLJzGlSF+hCZCyqqVm0YJM3ytWskvdyySzOJYcnlr6zhZHBnkt
 YIq+kIbhj2MP9eZgHWhBLYvwScoZzGTwhswlBB0HkbzsIN/d8mWt7uMTg9fw7sAhVgSzooMTzqI
 =
X-Google-Smtp-Source: AGHT+IFnqCLgTBdyGX8+QeUuw4gI0Wb9cs3IOTTlWLWwk2WH4xqMYOh5oIFurmfbSgdMVGh99U0vmA==
X-Received: by 2002:a17:903:2287:b0:223:37b8:c213 with SMTP id
 d9443c01a7336-22dbf7487b8mr56675735ad.52.1745618314847; 
 Fri, 25 Apr 2025 14:58:34 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d770d6sm37749595ad.17.2025.04.25.14.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:58:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 050/159] tcg: Merge INDEX_op_div2_{i32,i64}
Date: Fri, 25 Apr 2025 14:53:04 -0700
Message-ID: <20250425215454.886111-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index ef3af4157a..30b7f8ee19 100644
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
@@ -5473,8 +5472,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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


