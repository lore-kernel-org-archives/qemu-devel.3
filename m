Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EA3C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 21:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R0q-0007KV-Gr; Fri, 25 Apr 2025 17:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0n-0007I7-Qw
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:10 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0l-0000VY-4o
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:09 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-736aa9d0f2aso3514932b3a.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618105; x=1746222905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UAtH+1PpQZHkmG6/gQci6ayiz88hBds6rMyA2khGNKQ=;
 b=oitZMBLuW9Khgm+tYKMsvKSv5gK6u1BDs++HGxJayPWws2mSA5kR9RhLdJUyjXAVvx
 qoCJRtCj1lV26nNIqQL/YDkJ4eKcof4Q3AyzIlIWiDAD9Ne7XIzzGKD4x/vA/QrTjRcy
 Vd7zgRZMiQROF//5e6PyYt2PvBfUheAdAu/GSB4dInuUBOo8F7VWPJmhnp0ogoGZShK0
 th+6V+Ndj7TLXJU9mefbb1xcitJ2JartYGF9vqY/x5vjxHYda7TAiKnJ2R9Yyv0ElDsY
 5uqdGDZYrodtXRmOzqFCLIQBwF2z9UUB4ECrVrobpfMvaZtEM1RkpIxYGDyNPdT3SwNw
 NJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618105; x=1746222905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UAtH+1PpQZHkmG6/gQci6ayiz88hBds6rMyA2khGNKQ=;
 b=eb/0leduxQIoXUcB3DVDbFXhRwl1G0SKnwEzVPaY9eSU3OmrNSgvuddSP9F66u/pbc
 2y9oZy23+BMJtVj8F5YMWMNCBZSQHpeymS6rtsIfA32j4KX7zcwPptHP24JsXyoae56M
 IHR7UadVVdFnndwthghj5VSlMoy5yb5FgpuX/lTLT7JnII4KQiyTto0wnF1fGZHBw42a
 1f1Iz5a0ibMw+Fom+Oxv9FI0yqdG2Xxj/wi1DlyyL3z7oONJJKXCktO+n4favw3c/Zet
 zBt/YNNA2dAaPTe8dAsbrJdpBjMnp12mQ7g3FOrBZ8nh/N6tHSOYZvC+UqISvLIN5hms
 n/5A==
X-Gm-Message-State: AOJu0YyKdWUmD7MCumQrurqReTtjVu4H2xVYrm/gIGkSJKU1Ckn7l2Xh
 JJEHeg5hgiAPRWxfDMoeLVqQNAEZftycQTDqLvIVcg7fIB7piNjFOc3CaP/5kMGKaSyZY9T0Pcn
 A
X-Gm-Gg: ASbGncv2Br0J0SsLb7a+j6nyxXqF3a6X6b3kwxORHCYAz8A6HPwzQ33TML6c2emk3ge
 xXU6zVQBmSulMK67U5yEYO6l/BzzbsIETgkz4MUuFfCd6k+pv59STcmNWafcaV7YBguDo8V6vT4
 WHhh4V8w7B60TBk/8jGP6Quk+bvEGoIBeuNcEq6tbDqMfBaPAIQTSusLKSJittc8Vq6t+4zq56D
 Ur1s9NWcfiJHvUc9FTGJ8n7z3y2hH7LXJk298McRxRQCKckpVMR6Isl86ul3CReGhGN0Dqnv3xb
 bqVTHXIy/6+Go6ugdFRYBmCeBipfo86/kV9RE+jvSHAe/6oMYZSp+0JCiSynQROZaBZKyahBGYI
 =
X-Google-Smtp-Source: AGHT+IEeUwJRWPSBnx8EtQ3gRkDtyUYx5WQQorKKmHUfHL4UGIhTGzF+4B3OL9Eln9fT9Fr+YR1KGA==
X-Received: by 2002:a05:6a00:1382:b0:736:6043:69f9 with SMTP id
 d2e1a72fcca58-73fd8977681mr5819114b3a.19.1745618105457; 
 Fri, 25 Apr 2025 14:55:05 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259414b0sm3664392b3a.48.2025.04.25.14.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:55:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 014/159] tcg/optimize: Emit add r, r,
 -1 in fold_setcond_tst_pow2
Date: Fri, 25 Apr 2025 14:52:28 -0700
Message-ID: <20250425215454.886111-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

We canonicalize subtract with constant to add with constant.
Fix this missed instance.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 1f6fdee734..6c7b6af624 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2301,7 +2301,7 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
 
 static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 {
-    TCGOpcode sub_opc, xor_opc, neg_opc, shr_opc;
+    TCGOpcode xor_opc, neg_opc, shr_opc;
     TCGOpcode uext_opc = 0, sext_opc = 0;
     TCGCond cond = op->args[3];
     TCGArg ret, src1, src2;
@@ -2323,7 +2323,6 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 
     switch (ctx->type) {
     case TCG_TYPE_I32:
-        sub_opc = INDEX_op_sub_i32;
         xor_opc = INDEX_op_xor_i32;
         shr_opc = INDEX_op_shr_i32;
         neg_opc = INDEX_op_neg_i32;
@@ -2335,7 +2334,6 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         }
         break;
     case TCG_TYPE_I64:
-        sub_opc = INDEX_op_sub_i64;
         xor_opc = INDEX_op_xor_i64;
         shr_opc = INDEX_op_shr_i64;
         neg_opc = INDEX_op_neg_i64;
@@ -2379,10 +2377,10 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
     }
 
     if (neg && inv) {
-        op2 = opt_insert_after(ctx, op, sub_opc, 3);
+        op2 = opt_insert_after(ctx, op, INDEX_op_add, 3);
         op2->args[0] = ret;
         op2->args[1] = ret;
-        op2->args[2] = arg_new_constant(ctx, 1);
+        op2->args[2] = arg_new_constant(ctx, -1);
     } else if (inv) {
         op2 = opt_insert_after(ctx, op, xor_opc, 3);
         op2->args[0] = ret;
-- 
2.43.0


