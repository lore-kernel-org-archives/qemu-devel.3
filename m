Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14954E7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMQ-0008TD-47; Thu, 19 Dec 2024 23:11:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMB-0008Ok-Pm
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:20 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMA-0006Jy-3L
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:19 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-825c6570a80so925244a12.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667876; x=1735272676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7nPSOr42G4L6zld5O7HAmbijFDz7S6mbvQ4Sk1BkFg4=;
 b=M4Vlu4PStqhW/b02tje/lBg6wC/P5EsJIP7d1KTIwa8EmhzOxGR5pwPofKJ9EMI8wu
 YjkgCfYOoVSTqNJieEFq7il+E0dACA25XyY2eofFAKRrGWLqDtZEsYYzEZe5a/YPAnuZ
 uXQF7og/lJRpJPlJq0SpvKX0vVVtNKt8PqiPphUFxwX7u9yes5PGLBtfV+r5KDkvomy9
 iL4rvRyjqDr42/iBKQdScwNp2WgMffCGuaH0T9flRgtN4qtpa8D2ZwXdGrQ+EAVA2wlH
 4v65tckcDfvjHoz4xL8DtlVq52B8R7HVKOzedeB26L/5hGODtEnpCeU6eoEOB9R/Qzd/
 Znrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667876; x=1735272676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7nPSOr42G4L6zld5O7HAmbijFDz7S6mbvQ4Sk1BkFg4=;
 b=sUWh3XIhXPad/WAORql9eqeBA6iBYE23k0yV6IdC8sFvUYO7h3DAIM7f8qdqKenzbx
 wX+CpYzzIRlPaG/nxbBi6juLgnxvS3pBqaYAuwlebN0RgJi9nPEG3vLgNiejcxblSVmG
 zFULjpL/arEhKb+tQ1OqF91mcNavxDwwda3NiJY2/1JaiwjbrlT+XaMyv6/TJITvGIMC
 qyT9Q7B4NqdL8Xvg7SpVn8Hg0ZdKKovP6LuYLm/ZUuXhxukQcZOSt8pUrt3FDB7XGoNx
 ZIO1WnqVKNdFOQ1XU75Tjd0GRvPh+llgKDnTiccCqhPb0YOWKvhyI99utb8DbRdsI8Mg
 1F0Q==
X-Gm-Message-State: AOJu0Yz4uDa8NVSFyzZ/ihJgr8L4xGDLvhArEDuTXqXbkA4k0W3Mwsro
 h2SwFCSZspQFBiQe5k9hGE4efQVCCv8S6juGSqifeMTn0pYkuc+9s8ERB5GFLptp8kjqkgOnjKp
 i
X-Gm-Gg: ASbGncs2pS2jp7DSiaQphK1VsxNrW2fogaNwJ5AiuLUT8U2wqEOrboVA+wyR0zuJ5z3
 Jspqf3ELQrzXAWW174LAYc99TCJwFaQkF/uc4RmXSHRIr3WhRvl+9K2xCuYbTROrZss+h5R/p3Q
 9Z6V5ezd4hrQ1jlOrxRGuTihd15ygIONhuflvKJo/M3wYSS0CWtdGw6mXsUl9HxTqRtEguC/CEi
 S4xjh1iAJ8/tJwtp/qO0SY4dsc+0cjymoRnR50nv/U7lPnxPWMwtQ+RCls311Y=
X-Google-Smtp-Source: AGHT+IF00VMoCH7GEtQJV8kYywar2tKyg/pNEpsrH13Uh9XRPNDDWA/qleDMEggdzxbGu6yIcrofzg==
X-Received: by 2002:a17:90a:d646:b0:2ee:ab29:1a63 with SMTP id
 98e67ed59e1d1-2f452dfccb7mr2109201a91.3.1734667876601; 
 Thu, 19 Dec 2024 20:11:16 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 16/51] tcg/optimize: Use fold_masks_s in fold_eqv
Date: Thu, 19 Dec 2024 20:10:28 -0800
Message-ID: <20241220041104.53105-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

Add fold_masks_s as a trivial wrapper around fold_masks_zs.
Avoid the use of the OptContext slots.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 0232fa852e..56043a02e0 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1091,6 +1091,11 @@ static bool fold_masks_z(OptContext *ctx, TCGOp *op, uint64_t z_mask)
     return fold_masks_zs(ctx, op, z_mask, 0);
 }
 
+static bool fold_masks_s(OptContext *ctx, TCGOp *op, uint64_t s_mask)
+{
+    return fold_masks_zs(ctx, op, -1, s_mask);
+}
+
 static bool fold_masks(OptContext *ctx, TCGOp *op)
 {
     return fold_masks_zs(ctx, op, ctx->z_mask, ctx->s_mask);
@@ -1734,15 +1739,17 @@ static bool fold_dup2(OptContext *ctx, TCGOp *op)
 
 static bool fold_eqv(OptContext *ctx, TCGOp *op)
 {
+    uint64_t s_mask;
+
     if (fold_const2_commutative(ctx, op) ||
         fold_xi_to_x(ctx, op, -1) ||
         fold_xi_to_not(ctx, op, 0)) {
         return true;
     }
 
-    ctx->s_mask = arg_info(op->args[1])->s_mask
-                & arg_info(op->args[2])->s_mask;
-    return false;
+    s_mask = arg_info(op->args[1])->s_mask
+           & arg_info(op->args[2])->s_mask;
+    return fold_masks_s(ctx, op, s_mask);
 }
 
 static bool fold_extract(OptContext *ctx, TCGOp *op)
-- 
2.43.0


