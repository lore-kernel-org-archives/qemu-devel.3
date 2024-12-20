Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729FDE7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMU-0008VI-VE; Thu, 19 Dec 2024 23:11:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUML-0008Qk-JT
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:30 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMK-0006NU-2C
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:29 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7fdc6e04411so961560a12.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667887; x=1735272687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Owo9Xj6Jzu8SsqWkFVwwmR6pwZl5kA1ujeah6WfrAwM=;
 b=W3liBIQQrdphS1iQ7G7WK8237imhTiAvZS5h1dAHduracyt1eDHNXJr4Vmu2ft+mnO
 5YFVJFnTttbMrR66zCKUkOIHgxt5ebFAIyg6YbwFhbu1ldUPTZFbIQ4yOrPsR6+0PzV+
 O7yKBTM7s/+mFrtn2KzxHZYfqz7L9vopYuivufv1DfsHdbA9YkoPTSIkBZYkdTMTm+91
 dz6q0k0gsKD5egVfaW7DmcYQbjxRJhZ2xQuxGKia/i1svajEhCunx7IwpKdveavgIRVj
 Lwb5T4lyts8uQuuEqVg9INz/REXkIiKs3kkAQX+hcuc2DWje7DhJKnT7T1XOWzQRot5g
 jZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667887; x=1735272687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Owo9Xj6Jzu8SsqWkFVwwmR6pwZl5kA1ujeah6WfrAwM=;
 b=kyvmOAR+QZSclbO+M5b2BbZ70c5tolCc4WCAz0NjHHzHnZ1u9M5uOx2afzwh2p6Few
 umRuv8fToJSCn1dXgewBNPchV9TtUTy47XeCSUVXX1HNZMJSU/23jcLHHvc0rn/u2e+2
 0OrZtXypFHtPbqZVF5xBM3YKRTrsQG/kpOXKUwnhAzRm98787Q2NJEUujiI80Oh/bQ73
 rm3K6TTtMnCtmEMOaeyBzIUdnsD/W9OOwHwiA3ZaeTDt9ONEwWRB3mcM2IsqIzl7wdSH
 YdSjby0JW85Zb4/n9tFI4udHCy59WgktOPiBmG1fcxI89SWH66lYgLxp9EuR1iWBI66q
 ujwg==
X-Gm-Message-State: AOJu0Yw0t7/bCp5Z+SkFW7jAcKREopzXWdprWkAICLESFmNy8cu/BDbV
 RqFILFm/tGucag48sJ3nK9MJcgtVoMVtddYzWiqY5HOQCO86rXlvAeP7PRe1B1fBvvJLBujkTnX
 L
X-Gm-Gg: ASbGnctqDT/iSRrA6fV38QQh2AvSubyNy3ylRe5dPQjcyBd1CNOY5RVaGCGkS7gPUMo
 ShPxI61kty6BosiFriASSb1KFmiIzuOF/ynFxZRBKk0O/yCBKH8NLYUZQpzdz78btN6U1L4I5fm
 VnDoi4+nRho9oMSIP9le2y9FZYm45rSQ0e1BXtCvIqASzQUOW4sdgNL+N2xO5U+utZm7DDimniR
 RvPkQeDpcOT5G8rUgXte0RZBLVt6dur046tx81zbgU5/acezgkOP1WLmHO4ny8=
X-Google-Smtp-Source: AGHT+IHdquqh/0ul/n7Ljpqg7DLtY5opT6KST7qsCXkX3rUUgSQSTmO0KFzWJ4zMlJ+PCZ7s6Zc+Lg==
X-Received: by 2002:a17:90b:2dc2:b0:2ee:bbe0:98cd with SMTP id
 98e67ed59e1d1-2f452def731mr2477881a91.7.1734667886796; 
 Thu, 19 Dec 2024 20:11:26 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 30/51] tcg/optimize: Return true from fold_qemu_st,
 fold_tcg_st
Date: Thu, 19 Dec 2024 20:10:42 -0800
Message-ID: <20241220041104.53105-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

Stores have no output operands, and so need no further work.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index b01929fccf..a5a57bb914 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2160,7 +2160,7 @@ static bool fold_qemu_st(OptContext *ctx, TCGOp *op)
 {
     /* Opcodes that touch guest memory stop the mb optimization.  */
     ctx->prev_mb = NULL;
-    return false;
+    return true;
 }
 
 static bool fold_remainder(OptContext *ctx, TCGOp *op)
@@ -2727,7 +2727,7 @@ static bool fold_tcg_st(OptContext *ctx, TCGOp *op)
 
     if (op->args[1] != tcgv_ptr_arg(tcg_env)) {
         remove_mem_copy_all(ctx);
-        return false;
+        return true;
     }
 
     switch (op->opc) {
@@ -2751,7 +2751,7 @@ static bool fold_tcg_st(OptContext *ctx, TCGOp *op)
         g_assert_not_reached();
     }
     remove_mem_copy_in(ctx, ofs, ofs + lm1);
-    return false;
+    return true;
 }
 
 static bool fold_tcg_st_memcopy(OptContext *ctx, TCGOp *op)
@@ -2761,8 +2761,7 @@ static bool fold_tcg_st_memcopy(OptContext *ctx, TCGOp *op)
     TCGType type;
 
     if (op->args[1] != tcgv_ptr_arg(tcg_env)) {
-        fold_tcg_st(ctx, op);
-        return false;
+        return fold_tcg_st(ctx, op);
     }
 
     src = arg_temp(op->args[0]);
@@ -2784,7 +2783,7 @@ static bool fold_tcg_st_memcopy(OptContext *ctx, TCGOp *op)
     last = ofs + tcg_type_size(type) - 1;
     remove_mem_copy_in(ctx, ofs, last);
     record_mem_copy(ctx, type, src, ofs, last);
-    return false;
+    return true;
 }
 
 static bool fold_xor(OptContext *ctx, TCGOp *op)
-- 
2.43.0


