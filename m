Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4D8E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMF-0008PU-3f; Thu, 19 Dec 2024 23:11:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM5-0008LS-Ls
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:13 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM4-0006Hk-2j
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:13 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7fd49d85f82so1124696a12.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667871; x=1735272671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kFw3rpA76sVRd/4s7BeQ7vzsn5gYxdrWXruIEcEABL0=;
 b=llCCBWhqGNz1YgPThs3Eczh2dFPXiZXYhzndh2p0HK9ENYmVBPIR65rWm3rkmOqi1+
 xIm2YQIMkEymCaoYs72lEcyLZ2mShflQO1+7z8zBVTyRDi3HYZzqLkec9B+NI6eWna/I
 NVpsLylsfpk+A+wJKGO0WTpDagPYVrE0+B0RoGvvextapPufYEdfQK+a94b38IWVb9Vb
 VLL7GtqVawTXiD6REMCmXyoi6BLR4N2AGYwqTNF2m/pq3TFkp83QXv3MEBRTdeFA9AWk
 UVTVhD0EQgok7Qxyw3GFnz0pigPFon4S/ezNQfoFf356pKypI3LJfR1KRT6iXgTGJ5av
 Llgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667871; x=1735272671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kFw3rpA76sVRd/4s7BeQ7vzsn5gYxdrWXruIEcEABL0=;
 b=HiOIwOdzeE3hOnKCjZlBT36FQT151ugCNKOZ+Q/2fLnj+Uw6jycBDPosWpiFHVnnbf
 wVNlwfftOcyD0JKSWXneLWegML8OSdpsnPKlFdNzCTPvkeHsaXij+CY4jyBmZgT72/FF
 jP2XTmOGTRW5wDj1VUadR48YN7cx673asuIjF52GQA/MXx+EvcBJ4WVntMGEWjnRM4hD
 LA/2vNBBY6TvyPGZfpqgC2rQRAN1PNTqKNar0dhXDdh4zwrvPbvGFB8Ur/jQel2T0/JP
 HkdeGhcDcMkKp3vd4Fqn5yAwbRoDcJbbiRayAzioF2xIO4zXUuNzxswWp90ThEMn4kHN
 DOvQ==
X-Gm-Message-State: AOJu0YwDNBllGR4avAz26wHm63Mz9bp4SwR9+8PIz+zaey8FNc8l1pmh
 ixpcDzYAsmRboGW1G0cy05FJANeMo3Yor2k04ZOkRgUDhym0SzlI7Eoaa4UX5f1YWc/DMc1o+x6
 H
X-Gm-Gg: ASbGncvuscegGQGOunuSnOYeo3iOQ/skVe4xgdRCIegUFkc8+HCkTYfIPye0n2+rWy3
 6t5j8RQuIcKnMwukmv8jEVAhxYGZKnd+XXPAchgDFxRPkGGJTAdqhNs3jZzeqThBd9HSDbM2E0B
 YI0lewlQkKHg0AYT/L7EjhXWgi/ftRBp4gWbSe9TjHAcl2imcb/Mo37GB4jsTni2Cy26s2ge5mA
 WllUnMxgl5Ns4rWbi8rUaYeKWpZYw6X/God8JLmt11UvuGFjQzpcS1eFG21EWw=
X-Google-Smtp-Source: AGHT+IFuOjtu+5gXoQajxKigCrm53l7CmTLwhO0r7AFgG7i3Eab4SmrmkdcSc31XUIhblWsPVDalSw==
X-Received: by 2002:a17:90b:2551:b0:2ee:b0b0:8e02 with SMTP id
 98e67ed59e1d1-2f452eca3bbmr2132026a91.28.1734667870852; 
 Thu, 19 Dec 2024 20:11:10 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 08/51] tcg/optimize: Use fold_masks_zs in fold_andc
Date: Thu, 19 Dec 2024 20:10:20 -0800
Message-ID: <20241220041104.53105-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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
Avoid double inversion of the value of second const operand.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 52c785472f..c73410232b 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1349,7 +1349,8 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
 
 static bool fold_andc(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z1;
+    uint64_t z_mask, s_mask;
+    TempOptInfo *t1, *t2;
 
     if (fold_const2(ctx, op) ||
         fold_xx_to_i(ctx, op, 0) ||
@@ -1358,24 +1359,23 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
         return true;
     }
 
-    z1 = arg_info(op->args[1])->z_mask;
+    t1 = arg_info(op->args[1]);
+    t2 = arg_info(op->args[2]);
+    z_mask = t1->z_mask;
 
     /*
      * Known-zeros does not imply known-ones.  Therefore unless
      * arg2 is constant, we can't infer anything from it.
      */
-    if (arg_is_const(op->args[2])) {
-        uint64_t z2 = ~arg_info(op->args[2])->z_mask;
-        if (fold_affected_mask(ctx, op, z1 & ~z2)) {
+    if (t2->is_const) {
+        if (fold_affected_mask(ctx, op, z_mask & t2->val)) {
             return true;
         }
-        z1 &= z2;
+        z_mask &= ~t2->val;
     }
-    ctx->z_mask = z1;
 
-    ctx->s_mask = arg_info(op->args[1])->s_mask
-                & arg_info(op->args[2])->s_mask;
-    return fold_masks(ctx, op);
+    s_mask = t1->s_mask & t2->s_mask;
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_brcond(OptContext *ctx, TCGOp *op)
-- 
2.43.0


