Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DA6E7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMK-0008Pn-C8; Thu, 19 Dec 2024 23:11:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM9-0008Nk-5R
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:17 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM7-0006J1-3F
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:16 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2f43d17b0e3so1413250a91.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667873; x=1735272673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C5r1sayG0Y/5s05OtCkYtZE41zRfSkyjZqixbgF1qiw=;
 b=zL+DdcsWJUbuHWxmCQQLBcjyQRLlc1NTgNZLrxcl0ZA2xmIyuL/6gRUuWzVtAVyd9G
 LByucI/7xi+pTrI4ayaPaM1hxBa0EJvqliheeKjUlyU0IwdFl0Sjfid3lvTg8XsF0cKh
 JEtedady+9fmxkTqeX9EltLHE0kfk9edKuBeqyj1T+T2cinaglGq2HCtFKd8YI/uzg0t
 0RqEBAoZA/TTMKbTq3IxUuNEDqsFc9hvxfM2pHOQjgrAW/JgvXevULLAge0f7P1/i9Wq
 PhmA16a/vWB07EfdLJTtWgYpl9N6A5aiU7hTWPBn5S1CQVt78u0SvW4U0fmEjZxA96dp
 tFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667873; x=1735272673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C5r1sayG0Y/5s05OtCkYtZE41zRfSkyjZqixbgF1qiw=;
 b=RJr4A9ttcUKHBW+2oxjR7NDIMqXYOYJWkBpt7USPvVSOaPvGIkIhP8xWaWQyqhetn6
 98pXMAh3Xqz8BX5xvOtVk4fMBLntVajqwrCKVmEhsxeNK53/qKHbiB47v1BcHkC+ypUT
 0MEG3o15H+7uirJQ/3Qhqwf0D6wpN4ylxFdGbzY25mha+Tys8uEBciM7RYLoK5E5hQT3
 F4Spc3DkUaB1QcXcysWI8xe2YmX3HmTSGVfbfKYk2oGvnrprRlc8mV7P8R0twxXsMzXc
 c4C2Q1YISemKHNxsUf4VPkQCN4+SGvHQR549OTQfein8rl8GZrrL1VOmwPgmD1QtjtPG
 ZAqw==
X-Gm-Message-State: AOJu0Yz8/quTRiY1bPONQaec9cHAjv+/bQI5+1UAfF+LuTuaQR6noWD+
 1pMgpo0rmLJ1K4YSU2xtvU6/rm/kcKxmB5gz8BjUci5briV8svAZ8s40EJOnkDCh5NdjZVXVims
 y
X-Gm-Gg: ASbGnct22XFz297YYt62EzQPHH3+KBGUYqYuQhkRad1XFGFtHR6oW7xTm3Q2koxBMmJ
 HIK3ZZW8J+sDAfAWQgTR71goo3WRRBPwYPxFl75y1jCVBleev/gXkE/Ki2qjod5zL+IVj9w3Byd
 1TrmFq48d3L35C/0VmNu7wSutVj+A783zWSAh0d1WJLK7owlLDtV+mSE9fYJ2Dooxe7WxTtOzw2
 J677nD5hHkni4mOeg2l6m02cIfSxo+yjODZt6yn42fjZFkPhJYisuRD1YUgB/M=
X-Google-Smtp-Source: AGHT+IH1ruqrvCtfrE/Hxcn+n/SW6NxmVQi7x47e931cHoPZxLdTssPPdlIS/rsneMhz/tfmoCX31Q==
X-Received: by 2002:a17:90b:51c2:b0:2ee:9e06:7db0 with SMTP id
 98e67ed59e1d1-2f452e1d3f9mr2311897a91.11.1734667873645; 
 Thu, 19 Dec 2024 20:11:13 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 12/51] tcg/optimize: Use fold_and and fold_masks_z in
 fold_deposit
Date: Thu, 19 Dec 2024 20:10:24 -0800
Message-ID: <20241220041104.53105-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Avoid the use of the OptContext slots.  Find TempOptInfo once.
When we fold to and, use fold_and.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index af7111c98c..de32cc0323 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1642,14 +1642,16 @@ static bool fold_ctpop(OptContext *ctx, TCGOp *op)
 
 static bool fold_deposit(OptContext *ctx, TCGOp *op)
 {
+    TempOptInfo *t1 = arg_info(op->args[1]);
+    TempOptInfo *t2 = arg_info(op->args[2]);
+    int ofs = op->args[3];
+    int len = op->args[4];
     TCGOpcode and_opc;
+    uint64_t z_mask;
 
-    if (arg_is_const(op->args[1]) && arg_is_const(op->args[2])) {
-        uint64_t t1 = arg_info(op->args[1])->val;
-        uint64_t t2 = arg_info(op->args[2])->val;
-
-        t1 = deposit64(t1, op->args[3], op->args[4], t2);
-        return tcg_opt_gen_movi(ctx, op, op->args[0], t1);
+    if (t1->is_const && t2->is_const) {
+        return tcg_opt_gen_movi(ctx, op, op->args[0],
+                                deposit64(t1->val, ofs, len, t2->val));
     }
 
     switch (ctx->type) {
@@ -1664,30 +1666,26 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     }
 
     /* Inserting a value into zero at offset 0. */
-    if (arg_is_const_val(op->args[1], 0) && op->args[3] == 0) {
-        uint64_t mask = MAKE_64BIT_MASK(0, op->args[4]);
+    if (t1->is_const && t1->val == 0 && ofs == 0) {
+        uint64_t mask = MAKE_64BIT_MASK(0, len);
 
         op->opc = and_opc;
         op->args[1] = op->args[2];
         op->args[2] = arg_new_constant(ctx, mask);
-        ctx->z_mask = mask & arg_info(op->args[1])->z_mask;
-        return false;
+        return fold_and(ctx, op);
     }
 
     /* Inserting zero into a value. */
-    if (arg_is_const_val(op->args[2], 0)) {
-        uint64_t mask = deposit64(-1, op->args[3], op->args[4], 0);
+    if (t2->is_const && t2->val == 0) {
+        uint64_t mask = deposit64(-1, ofs, len, 0);
 
         op->opc = and_opc;
         op->args[2] = arg_new_constant(ctx, mask);
-        ctx->z_mask = mask & arg_info(op->args[1])->z_mask;
-        return false;
+        return fold_and(ctx, op);
     }
 
-    ctx->z_mask = deposit64(arg_info(op->args[1])->z_mask,
-                            op->args[3], op->args[4],
-                            arg_info(op->args[2])->z_mask);
-    return false;
+    z_mask = deposit64(t1->z_mask, ofs, len, t2->z_mask);
+    return fold_masks_z(ctx, op, z_mask);
 }
 
 static bool fold_divide(OptContext *ctx, TCGOp *op)
-- 
2.43.0


