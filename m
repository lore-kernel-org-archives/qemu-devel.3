Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F4FE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOlq-0002td-55; Sun, 22 Dec 2024 11:25:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlE-0002Yx-Sx
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:24:57 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlD-0002xc-BI
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:24:56 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2164b662090so27973705ad.1
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884693; x=1735489493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KyHPZLWqRAnz8460OAnK7qtdUZNjSGM1FWV/QTJHNlw=;
 b=q/qWBLn7NtIvbB/Qui1LzLffg+YCKNNRtM7P6bua3Dhch2QUkc260tUDPfv0hlLp6+
 Agk8w0STzFGUMhebr+SxTEDXGkunKYRB5ufauIEweHLbduVkG5rFoUuK+z7VwjpW/cIp
 UisOUNSKtVIQ4oyPYOu+5fPyNv42RIqx3Qfd7KFNN7V60co8ONiOQVmcghPsQTlszAf2
 kYF4M2dqIwLoq9Yj7i2njm/LAXJphQ03lM6XgWDP2+1qCGtSbCzuDDRSol7P3Lrqmc41
 3yxjffyMvizkXHT0HOV29QY7lv55u6zry0bteZ+blA4mFicobTaRbaoDJnXcuQMxEQtw
 1TDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884693; x=1735489493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KyHPZLWqRAnz8460OAnK7qtdUZNjSGM1FWV/QTJHNlw=;
 b=sZnKyiKpiOssOhKNvCtb0BdDAPp+cswIIjxDMORUm3sfqFYzBWh8q7rHkzQdmxKNKc
 uY16J1LD243NH38omFqfFHM52YmYcuHUnsSbpcYbn+X4W5oM4kF5BHEPVbqIIan0n8sH
 jed3MVSTVqJPv2F7HFaffC7fw1aBHl4O54pkIhYEDY22Nz6SM1KUT5ZBOrfbzeAdtgLV
 ah2Ny0pxppUkQB7HQaNV9WkisfHOw5ksyPJO8YegSJU9JLPLa/3gw5jHpmqcS8Brbygt
 h8p5OU0DGCJ/LPIOFhaViA6c+mliWWAhSYQYZR20IZxS8EaxGB1M/ZmSflrp2XR7pi4D
 3pTw==
X-Gm-Message-State: AOJu0Yw96KlB5XiUQ8t8S/FgT+IslSX3JT1KRyVgZ90J7ykcNXT6aN5j
 Mg7e9/bcg0cL4MFHzPUZ0L4lKtmBxccgfkY+wLO5Sftg/3IUQ2aETfSlSGK9KzGBKwvHUVG/U87
 fguk=
X-Gm-Gg: ASbGncsQA96ZnIzrfZfLISTSupAHTIX88+CoH197oUUJqJjBnlNpVvATTKGtcnrZB4O
 Y2cEwlfgyC+vA6qM7p8oLtP+qgSLFEwQjb0QPjyZDOcYZGk9lwSNHT/jvsEM+qADzer1stXMJEl
 1GY5zxBsHN6+AXv2++5MeQFzZ12PBHNqQrF+snlmaotGW0R0+2mrNwgWSYg9tabetRfMmEIdG0U
 8P6RLq4CNXP/9G5dNKsRseXqsobz7tuVaSvsamUoUh/xK96h9n2nyrtP7rcBjM=
X-Google-Smtp-Source: AGHT+IEI5TS+34zE/LgG719xAA8Jy7YyFmzC8BFSZhLLb96OIO0CU1VoApIGJStJyr4YEVCt9RFJzg==
X-Received: by 2002:a17:903:22c6:b0:216:59ed:1aa3 with SMTP id
 d9443c01a7336-219e6ebc78bmr113506525ad.27.1734884693618; 
 Sun, 22 Dec 2024 08:24:53 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:24:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 09/51] tcg/optimize: Use fold_masks_zs in fold_andc
Date: Sun, 22 Dec 2024 08:24:04 -0800
Message-ID: <20241222162446.2415717-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
index 8119447c89..d13001e53a 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1316,7 +1316,8 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
 
 static bool fold_andc(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z1;
+    uint64_t z_mask, s_mask;
+    TempOptInfo *t1, *t2;
 
     if (fold_const2(ctx, op) ||
         fold_xx_to_i(ctx, op, 0) ||
@@ -1325,24 +1326,23 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
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


