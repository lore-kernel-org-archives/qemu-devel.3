Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7033EC61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Jj-0000z6-Fg; Fri, 28 Aug 2026 18:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jh-0000yJ-Mp
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:44:57 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jg-0004Lp-23
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:44:57 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-381b831d535so2710509a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787957095; x=1788561895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XwNZK85bMoLoLObkEGMhYdQROE/xOCTLBXQLC6qU6n4=;
 b=VsQSZUk2e7letJZFa8Q4GTx9GtO/1yUtwWVeMqXvHV0gY/XjvXEiOU5/BQCjHZbeNM
 +v+yntF73lb5v3zgaiff91EdUI3AFLo0sgcCPrfhbkxry3WcyREWRrAo3Gmm/tgduyTw
 p6qHZUkYtffePhPmhLG2eIkPRNrOh2FTwP/+9q6yL39uzyDG6aVQdKxd4iVRuWtnVmGz
 bzrZJmd2n8AN86BT7fiaPyzfj23szpdRK+dZD5Va9UDoOHIDUw5ETLLooHvpxdJicZUh
 SW0JUeMKOw8WEyuHuUTJbbqvvF4MAnUpefBa0BeC+WKWWHfONHjj4HZMrnL2qQFPFfLO
 iCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957095; x=1788561895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XwNZK85bMoLoLObkEGMhYdQROE/xOCTLBXQLC6qU6n4=;
 b=ZVGC2pjuIDIlbEd7IZ2zaMVXgCxio1ZSJ7Ig0wyDwWBEmOLN9SZ5AT4O7HtnUSP//r
 5d1eOKt+EgNQl0pwA6cQotTBqh+Zer1MLgGcn+ScJg66rCXe/5fWBQIebMevf5L5vRgI
 KYzV5hsZNgN0dLIGYEIh5BczcIWdWJH+GTYTVugcQ8v6tCqrxKxGh8kcsZHrYPtSAy3u
 nbAFjMDjw6bv7og08MR19LJHytpC98tu4Eqormqskpo0y0EOmCBqlgg+Q7BUvpnon86I
 McOut4o5E9rVg9hVfV81iUE5XDvdwjyDvWgDvOhDrClYb9Q+t8Gi/wz3+iGvozvIc6/t
 8tYA==
X-Gm-Message-State: AFuF++k4Qm7MvHduCWGL91ZkrUvIQmL9dg7xBS+QiS2ydwcFY4GkD091
 dza7OGyayNq/DTiIMoh2CMmanqZP1KnI4KQo/J0NJSn0keJNOBC71/invr/f4yZw57ZuuFGc2Qx
 vj+rUfhA=
X-Gm-Gg: AYBFou2fMUu15vmLKjCGDDGVrSajLshGFPboWQRzW6wMAXxlUFSlEhyB5VglzpOhlQN
 CMsojWqdKYlKklRQBQnGY58c1AGhNbXCkPfZ3yZ4L9aKVG/qBSbYXq5yf5yYw1EYOv2WaG89oRx
 S3tbbrQaySFPqvRaWVNtRvsqifa7W66gHLGJAhZ+4M0r+4RGtXIdfmpHpt6iKRYkDNPzkXb4nlN
 vamTrS+ci3IK6KrejV303dSfv4VBrNo4YaXv9IcW8RovsGHIsvAV/8XBCQKQDJEcfNyS2Y74Qba
 DRsq0p7dJhfUlFX/jxr3WBm3fx408J5bU7RYpYFT8ax4VE5T+P/EO346LSZMsKvEViKom9cQUCj
 hMY8rM08VAegYCoC8J0mOyMcwedQQ+3Ohk1Qd+kHLpe5Xck5Ga4ZYZl/mlYSw8i+xKk30PguPeg
 0xucECiFgB+lyQUCmmHqTWTEdzSqr/jn/59ynJN24pGcoHa6oDA38+O03t/61shD5lnjUi+surK
 TM2hc0OQgArldDHVcKs
X-Received: by 2002:a17:90b:3fcf:b0:398:9be5:b419 with SMTP id
 98e67ed59e1d1-3989be5b4camr4575825a91.20.1787957094495; 
 Fri, 28 Aug 2026 15:44:54 -0700 (PDT)
Received: from stoup (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-398a2f5187fsm427594a91.1.2026.08.28.15.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:44:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH 01/16] tcg: Sort all_outop[] by INDEX name
Date: Fri, 28 Aug 2026 15:44:36 -0700
Message-ID: <20260828224451.1564072-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828224451.1564072-1-richard.henderson@linaro.org>
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
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

Most of the opcodes were already sorted, but then there were
a set at the bottom that were left over from the split
between 32 and 64-bit hosts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 489df0e7386..ecc1f54c1bf 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1158,32 +1158,39 @@ static const TCGOutOpLoad outop_ld = {
 /* Register allocation descriptions for every TCGOpcode. */
 static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
+    /* addc1o is implemented with set_carry + addcio */
+    OUTOP(INDEX_op_addc1o, TCGOutOpBinary, outop_addcio),
     OUTOP(INDEX_op_addci, TCGOutOpAddSubCarry, outop_addci),
     OUTOP(INDEX_op_addcio, TCGOutOpBinary, outop_addcio),
     OUTOP(INDEX_op_addco, TCGOutOpBinary, outop_addco),
-    /* addc1o is implemented with set_carry + addcio */
-    OUTOP(INDEX_op_addc1o, TCGOutOpBinary, outop_addcio),
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_brcond, TCGOutOpBrcond, outop_brcond),
     OUTOP(INDEX_op_bswap16, TCGOutOpBswap, outop_bswap16),
     OUTOP(INDEX_op_bswap32, TCGOutOpBswap, outop_bswap32),
+    OUTOP(INDEX_op_bswap64, TCGOutOpUnary, outop_bswap64),
     OUTOP(INDEX_op_clz, TCGOutOpBinary, outop_clz),
     OUTOP(INDEX_op_ctpop, TCGOutOpUnary, outop_ctpop),
     OUTOP(INDEX_op_ctz, TCGOutOpBinary, outop_ctz),
     OUTOP(INDEX_op_deposit, TCGOutOpDeposit, outop_deposit),
     OUTOP(INDEX_op_divs, TCGOutOpBinary, outop_divs),
-    OUTOP(INDEX_op_divu, TCGOutOpBinary, outop_divu),
     OUTOP(INDEX_op_divs2, TCGOutOpDivRem, outop_divs2),
+    OUTOP(INDEX_op_divu, TCGOutOpBinary, outop_divu),
     OUTOP(INDEX_op_divu2, TCGOutOpDivRem, outop_divu2),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_extract, TCGOutOpExtract, outop_extract),
     OUTOP(INDEX_op_extract2, TCGOutOpExtract2, outop_extract2),
-    OUTOP(INDEX_op_ld8u, TCGOutOpLoad, outop_ld8u),
-    OUTOP(INDEX_op_ld8s, TCGOutOpLoad, outop_ld8s),
-    OUTOP(INDEX_op_ld16u, TCGOutOpLoad, outop_ld16u),
-    OUTOP(INDEX_op_ld16s, TCGOutOpLoad, outop_ld16s),
+    OUTOP(INDEX_op_ext_i32_i64, TCGOutOpUnary, outop_exts_i32_i64),
+    OUTOP(INDEX_op_extrh_i64_i32, TCGOutOpUnary, outop_extrh_i64_i32),
+    OUTOP(INDEX_op_extrl_i64_i32, TCGOutOpUnary, outop_extrl_i64_i32),
+    OUTOP(INDEX_op_extu_i32_i64, TCGOutOpUnary, outop_extu_i32_i64),
     OUTOP(INDEX_op_ld, TCGOutOpLoad, outop_ld),
+    OUTOP(INDEX_op_ld8s, TCGOutOpLoad, outop_ld8s),
+    OUTOP(INDEX_op_ld8u, TCGOutOpLoad, outop_ld8u),
+    OUTOP(INDEX_op_ld16s, TCGOutOpLoad, outop_ld16s),
+    OUTOP(INDEX_op_ld16u, TCGOutOpLoad, outop_ld16u),
+    OUTOP(INDEX_op_ld32s, TCGOutOpLoad, outop_ld32s),
+    OUTOP(INDEX_op_ld32u, TCGOutOpLoad, outop_ld32u),
     OUTOP(INDEX_op_movcond, TCGOutOpMovcond, outop_movcond),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_muls2, TCGOutOpMul2, outop_muls2),
@@ -1203,7 +1210,9 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_qemu_st2, TCGOutOpQemuLdSt2, outop_qemu_st2),
     OUTOP(INDEX_op_rems, TCGOutOpBinary, outop_rems),
     OUTOP(INDEX_op_remu, TCGOutOpBinary, outop_remu),
+    OUTOP(INDEX_op_revbit8, TCGOutOpUnary, outop_revbit8),
     OUTOP(INDEX_op_revbit32, TCGOutOpBswap, outop_revbit32),
+    OUTOP(INDEX_op_revbit64, TCGOutOpUnary, outop_revbit64),
     OUTOP(INDEX_op_rotl, TCGOutOpBinary, outop_rotl),
     OUTOP(INDEX_op_rotr, TCGOutOpBinary, outop_rotr),
     OUTOP(INDEX_op_sar, TCGOutOpBinary, outop_sar),
@@ -1216,28 +1225,18 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_st, TCGOutOpStore, outop_st),
     OUTOP(INDEX_op_st8, TCGOutOpStore, outop_st8),
     OUTOP(INDEX_op_st16, TCGOutOpStore, outop_st16),
+    OUTOP(INDEX_op_st32, TCGOutOpStore, outop_st),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
+    /* subb1o is implemented with set_borrow + subbio */
+    OUTOP(INDEX_op_subb1o, TCGOutOpAddSubCarry, outop_subbio),
     OUTOP(INDEX_op_subbi, TCGOutOpAddSubCarry, outop_subbi),
     OUTOP(INDEX_op_subbio, TCGOutOpAddSubCarry, outop_subbio),
     OUTOP(INDEX_op_subbo, TCGOutOpAddSubCarry, outop_subbo),
-    /* subb1o is implemented with set_borrow + subbio */
-    OUTOP(INDEX_op_subb1o, TCGOutOpAddSubCarry, outop_subbio),
     OUTOP(INDEX_op_umax, TCGOutOpBinary, outop_umax),
     OUTOP(INDEX_op_umin, TCGOutOpBinary, outop_umin),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
 
     [INDEX_op_goto_ptr] = &outop_goto_ptr,
-
-    OUTOP(INDEX_op_bswap64, TCGOutOpUnary, outop_bswap64),
-    OUTOP(INDEX_op_ext_i32_i64, TCGOutOpUnary, outop_exts_i32_i64),
-    OUTOP(INDEX_op_extu_i32_i64, TCGOutOpUnary, outop_extu_i32_i64),
-    OUTOP(INDEX_op_extrl_i64_i32, TCGOutOpUnary, outop_extrl_i64_i32),
-    OUTOP(INDEX_op_extrh_i64_i32, TCGOutOpUnary, outop_extrh_i64_i32),
-    OUTOP(INDEX_op_ld32u, TCGOutOpLoad, outop_ld32u),
-    OUTOP(INDEX_op_ld32s, TCGOutOpLoad, outop_ld32s),
-    OUTOP(INDEX_op_revbit8, TCGOutOpUnary, outop_revbit8),
-    OUTOP(INDEX_op_revbit64, TCGOutOpUnary, outop_revbit64),
-    OUTOP(INDEX_op_st32, TCGOutOpStore, outop_st),
 };
 
 #undef OUTOP
-- 
2.53.0


