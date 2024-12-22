Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7D9E7718D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOm1-000316-MO; Sun, 22 Dec 2024 11:25:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlB-0002YM-RV
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:24:55 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlA-0002wn-Br
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:24:53 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2163dc5155fso30200205ad.0
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884690; x=1735489490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6O0RsWWKqdEinIh2H96IW4WRMj9sIUVKDwhRVVNpMf0=;
 b=FVPh8Iv2Sg8PEu5mfDuiOFlPZ1B8eJe6tsxeIEid1Nc8rvgh3nKuOaBdwHNWABGjcf
 IoLC/fTovAmwz7CGlK+EMZXeTcPX3wppbHArqXepB7e4YmW9yhiZ49wqargXWX13NvDz
 1+n/+uKgXkandK+qbf6RhxCitKrnY0TN87muT/ejOePeFHHDxP1yPJQ01OeHfDKBdz91
 QKHHuygJurbD+QvbD/hDkgMc0kJ+ItUDOjSwyVR3FS/ysoAD744ifPCGhVjrYMtWaQc+
 3jZaBwEXC4kLezGtQn3EFKb9rpnjucL3yMkGCuBYrI13hi4XUgonfoHlhnxgT8MPOk7b
 kBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884690; x=1735489490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6O0RsWWKqdEinIh2H96IW4WRMj9sIUVKDwhRVVNpMf0=;
 b=iyxZ8eGIz6Mk4/Gz50hLron5LnyEWHZIlH/s3Ir9FM5fz2tzoNVvxXfpSYRBQiMoZe
 k8zHHZUEnaQlWgUMHK5Zf4IefaF9C0S6Xuf5dzTMhiaTDnrUHIHXvpJFnH8YDAzKLGA4
 5J2CIDMSHeA6ia5MqCYsvbGY8MCjZU6pAcvpgxD1/8wYbRcutV9RnTlSFbr0hEVQGEZG
 jxq1hXd1W7Uf9Fqnb8l9RPuTygKzIGUuxdTrtIV3HZRRcS0Q1AOb/Tp52T7NRNNcLf7J
 B4SYCD/ae6wG3pf7otCOeGMR80cTAW5ZA2vNXPDE5iBrjEeafkPARznjfYoHY1y1kC6l
 QtAw==
X-Gm-Message-State: AOJu0YwiKubbyqRhxir/1h8APXfkkYuc9+En4UX6AyBPohSamdhjy7zT
 /7qXYYhMsMByFbBBECgYueteCcYG9TbHf+eb57n7097OS3CQxSryuQEhSPvHhbkCMUgj2mEZuNc
 oeLw=
X-Gm-Gg: ASbGncuOrB3WWbfV4xGZd4mpgT6AfzNOwkcZZwgKmY/uTcHhdAxpq4YhFWdfQqbIQxz
 F8Xku/HCWbFVVwOmHgyd6ZGBHaWr0H9D8ftyAPFnnfkDwKkDGCU2/27otZaNY7scQWZHdchAQLE
 vsktLb3wFRAZTUvSNwtMaR635+AN6s8/OIvsV50DrTobr6BEdGJ6JkIK5TSXiclaXlQtrBTy72L
 pItlJCJrTuj8ElXarsU4DuAfxyiGBRiffMKzdjTg6lqwEaRd7VYnKHrkkvXaC4=
X-Google-Smtp-Source: AGHT+IEc6hDUoFWmkxyNVnOD3rodUfLlRVpMHmEJDtXc4ZIywwrVlAFBmoT5a+ZU15MePMWdKEM1nA==
X-Received: by 2002:a17:902:ec82:b0:216:3466:7414 with SMTP id
 d9443c01a7336-219e6f133eamr132772495ad.44.1734884690568; 
 Sun, 22 Dec 2024 08:24:50 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:24:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 04/51] tcg/optimize: Split out fold_masks_zs
Date: Sun, 22 Dec 2024 08:23:59 -0800
Message-ID: <20241222162446.2415717-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


