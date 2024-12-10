Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCF3E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL26U-0004Qz-7Z; Tue, 10 Dec 2024 10:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26Q-0004Ju-7Q
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:46 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26N-0008NN-BS
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:45 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3eb45232717so1258170b6e.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844280; x=1734449080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sQj1vTe/azWkpGgK1LJA2uc6pw6ILza790vF3QBaK8k=;
 b=LFx8NHs5s5on0g7x5aKvzT2t5GNL0dudNBU6njGtUZzxyHHX98B5TQihlBFSFiJS/g
 ZYQu/sHCdr/veRiFi1hUwGJerWR5RsE/eddX5/F6fqj2MJYH3YwR4RZAV89wNN5vflNf
 VbBaR9aoYC+GhYj1dP7CioHj5Yc/K4jZLNDhxwLFTqiGKPfDR/jP08STc+8qTUS3z9Ay
 1B+I+s6j/J70RghoszFfJE9LDWte+tiCt1m9ezyXWfMgAEXp6esqrMoMBp0MN+g6lyD4
 C1s355WHUwLcPqkZLbSgAVxFkvwNZ0bijgBErltSAJMC5JhJobG5P3dFFbTzvGiMbuwC
 TqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844280; x=1734449080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sQj1vTe/azWkpGgK1LJA2uc6pw6ILza790vF3QBaK8k=;
 b=oo2FwZvTwLdV3Is5ugfopMNf1ws4Gq3Y0LLbAk8g3lNmIWSmR8y8S5R7VVRs0UPSp/
 VhtYa5MpevcZYFhAfyYPkKAPtgAvXQ/6UwOt7JXe1uiF+ygRaSYlKLMc7Mq27lJbM3KT
 H1RhJX9zJ9aE2zMKuieQDjp+HjObII+NBjwS2QgxkOiOetLxFf4mmrn25rWyFXSd3Q7V
 36OwUxDjvjsJ0p5AK3Hkq9iDSTn1nRxkXBTAlOA6xATvbHpCEnPIvMlfe0P1OJhbyjRI
 DDkLKDIkox8qPvMkHReaGRTIQr8NqHrbcyNnvAQfXSLaPIA61O88r3w2bFjgH+k/b1XX
 xl8A==
X-Gm-Message-State: AOJu0YyAiHLIYzIP5hGQ7OqS5PKJI/2/6LGf3D5Nc6Go0jSdci+6vWLX
 DryE3DGrxRJaISmhRqo9o/zZSnCLnZbwnEmKZ7mgVqQsqYjSsj3hSGgGWWfn7SR3MEt/YLWETrK
 wfNbl6bUk
X-Gm-Gg: ASbGncuRSLVJvWZWC8SUjjY1TnhLa4e7m/XwysuSGXB4fkTtv8/bE6fMSYRItpbpqkV
 u7aJEWqcRJ9fz/r23f7tQBZ/a6yM5dNFWwl9DYMDYNARVsEOtTGc1xZVI9RMYjxbNMRyrSll6fT
 yqB3Vi5LGFtPe3TbS4zPvjBPLL4otKhSVq+o68OQ7QGbLVTSFy3sH087FxPlnamqAmOjcRPCm2q
 C7T6AS51DIcLrI7wErvZoE2BWbb6KIhAWATSjiDpbkjcIPWm1bsGT4eTKj6wQ==
X-Google-Smtp-Source: AGHT+IEd2EOw+5Zxld5OjgZxavpR5ihQ8znVZXRbqkBQYz7rHpPyfvaT3g7hrgD5CGFGBA1a/kvTDQ==
X-Received: by 2002:a05:6808:130c:b0:3eb:6dd3:12bf with SMTP id
 5614622812f47-3eb6dd315bfmr1738145b6e.28.1733844280149; 
 Tue, 10 Dec 2024 07:24:40 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 25/46] tcg/optimize: Use fold_masks_zs in fold_or
Date: Tue, 10 Dec 2024 09:23:40 -0600
Message-ID: <20241210152401.1823648-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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
 tcg/optimize.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index ae1386c681..3d852b44e4 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2061,17 +2061,19 @@ static bool fold_not(OptContext *ctx, TCGOp *op)
 
 static bool fold_or(OptContext *ctx, TCGOp *op)
 {
+    uint64_t z_mask, s_mask;
+
     if (fold_const2_commutative(ctx, op) ||
         fold_xi_to_x(ctx, op, 0) ||
         fold_xx_to_x(ctx, op)) {
         return true;
     }
 
-    ctx->z_mask = arg_info(op->args[1])->z_mask
-                | arg_info(op->args[2])->z_mask;
-    ctx->s_mask = arg_info(op->args[1])->s_mask
-                & arg_info(op->args[2])->s_mask;
-    return fold_masks(ctx, op);
+    z_mask = arg_info(op->args[1])->z_mask
+           | arg_info(op->args[2])->z_mask;
+    s_mask = arg_info(op->args[1])->s_mask
+           & arg_info(op->args[2])->s_mask;
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_orc(OptContext *ctx, TCGOp *op)
-- 
2.43.0


