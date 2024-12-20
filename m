Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621E7E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUM5-0008LL-HY; Thu, 19 Dec 2024 23:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM2-0008Jh-Ua
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:11 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM1-0006GB-8y
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:10 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ef748105deso1061362a91.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667868; x=1735272668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y0pidgR3zAliJqOpHhhNlBry8ChrLsZBHd/pCpZ2Pbk=;
 b=YgUHrzMzInai9xuc6TdAvvukC/5HyxgPOXxBEc6S252TQe1nqjZOo8RhCbUz0doJZu
 iIPAvPCL/jB87RAUMhAux1Kj2nfPPetOUot8Ysaqxk1cTdEgXwzBWUWQaPdGLrsBxQUK
 uHhCEulMlh8m3Lnq9qnfxoz2Jf/mYMPRR5rtw5JgIlxmvt7FyNc7iIhhFx9IzmUTUG7G
 b0E1T0y7Kd0+W4V5iMJWHqWDHQyHKYw4QkMcHR+u3O/fXUYI/5Fm3rFU8FqmK62X0pPa
 /VIOL1eugfebX4wQhwViG6s7+65tuiT6fTyPb9AZ10atP9mtEVDaWYaoD/cxGt6Vr2XN
 JapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667868; x=1735272668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y0pidgR3zAliJqOpHhhNlBry8ChrLsZBHd/pCpZ2Pbk=;
 b=oG3xBoaso61mGxCf/d1akj4xqbeyfrNzWYvAUIbEYAKgPgQkqsOwPG4hnpG7+0cVkr
 ImdSVhJoVunWtQiPX9HGT7Pjrd6vqwM4bo87iFXfs21fUDd4kyf95UoOkgKbzBUQah9C
 TR3wAa9VLgV9ORrjxUAE0SA7Qfhv6ztesiJYdkGVWVUp0QcqpBlNJggWRi0uXWOby60q
 I61pAnZgh3tDm0+1scDjRplLFTpEtOZ5S7pZukd1dYzv2GMbW0sZNIPxspMFN+T9KT82
 /g+pQjmhH4uu/el0OnekMJMNcA146oYuT1Z/AbzKZO02UKHJT9FSk5XjNep6rAbN/gnb
 AIfQ==
X-Gm-Message-State: AOJu0YxONXK+1Z23PEcoImbfWDlNCAxCIaYcTY1YVvyujQhmvObo+A7k
 nbRHKhVJQlDp/Eo4WVE/5Ro0AcoV84/qtu2xpy2aHKo3AqmoxlbTSOnEeadgGJsvqsime+PoVjg
 X
X-Gm-Gg: ASbGncsDnYC6xRSovlgtjm4lm0PNPfUeeNbwjFK3HDlQIprgwhlkZkLVVQxHUak/a82
 coBfU3ZUlW3i/Cwmern6lTLX4tmJBEYRDjMDP6kMCb8+7dZH/ekbvYBJW9Sl9dYBOK6dRNYCYi8
 P8XyGMfAxKszqsQ2zQ2gvw3JU3gOp5LtRThx28VA/Ad9opBQrpEY+mdbCCdnW7Mq3uPa3X+SpwU
 QaKmSexgT3Q0br0sk0UpDDS97+9bFCuIYP/ymUaZ2+hw6Sdgfk8Kvnd6rp2ca4=
X-Google-Smtp-Source: AGHT+IEGzYWomHSTtYnhctPAu7pTbkRtoakLz1wcnx+PxlG0YqFLv5bKbMH3+ukJ/YritMmkej5xVw==
X-Received: by 2002:a17:90b:53c7:b0:2ee:b2e6:4275 with SMTP id
 98e67ed59e1d1-2f452ee7147mr2000231a91.26.1734667868016; 
 Thu, 19 Dec 2024 20:11:08 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/51] tcg/optimize: Split out fold_masks_zs
Date: Thu, 19 Dec 2024 20:10:16 -0800
Message-ID: <20241220041104.53105-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
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

Add a routine to which masks can be passed directly, rather than
storing them into OptContext.  To be used in upcoming patches.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 2aa57afd64..d70127b88d 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1044,10 +1044,14 @@ static bool fold_const2_commutative(OptContext *ctx, TCGOp *op)
     return fold_const2(ctx, op);
 }
 
-static bool fold_masks(OptContext *ctx, TCGOp *op)
+/*
+ * Record "zero" and "sign" masks for the single output of @op.
+ * See TempOptInfo definition of z_mask and s_mask.
+ * If z_mask allows, fold the output to constant zero.
+ */
+static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
+                          uint64_t z_mask, uint64_t s_mask)
 {
-    uint64_t z_mask = ctx->z_mask;
-    uint64_t s_mask = ctx->s_mask;
     const TCGOpDef *def = &tcg_op_defs[op->opc];
     TCGTemp *ts;
     TempOptInfo *ti;
@@ -1080,6 +1084,11 @@ static bool fold_masks(OptContext *ctx, TCGOp *op)
     return true;
 }
 
+static bool fold_masks(OptContext *ctx, TCGOp *op)
+{
+    return fold_masks_zs(ctx, op, ctx->z_mask, ctx->s_mask);
+}
+
 /*
  * An "affected" mask bit is 0 if and only if the result is identical
  * to the first input.  Thus if the entire mask is 0, the operation
-- 
2.43.0


