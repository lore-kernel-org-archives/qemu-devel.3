Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA40FE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMV-0008VK-1o; Thu, 19 Dec 2024 23:11:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMJ-0008QB-NK
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:28 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMI-0006MX-BV
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:27 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7fc99fc2b16so882570a12.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667884; x=1735272684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ubZIvSbsmGCFHv6oeJRswF5HFflaseUD+CX++cK93ls=;
 b=vx7im5Azh6gFryvr2+baTl0wZg6WDN2nA+s/wWU5aZCiymdvnRIvXYZrtmIE70yoCu
 D3ov0bTSTFnBclgJsNB0MEUHHHWAYUvv9A0LHhuf5fFB40on7EBx3TF24jACzh5cLbQz
 rtmW5iueghSQytwelggvdDvU7oojNc3Wj+QvZUXxuPbTFwtz7Zdcf9rbasc7M6TX95ap
 IjK6yjaKwyJAWPuvb4tqT9gC9Lot0AwxgEBF14V16k+oQW0+UaHdV+EEKB/Y6aaC+Ek4
 jpK/Q8NSNoOI6Yp0/CKOEalsaGcAYym+DBq+nO+IMDEQ9X6Y/htsOMnGYpIfTR0hH6gY
 +YBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667884; x=1735272684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ubZIvSbsmGCFHv6oeJRswF5HFflaseUD+CX++cK93ls=;
 b=gM5J6HJmzai7nDXDe0TxMLJs66AiBvH5tO4yf4xO811wzLt44McFHPds9SX69EiVZQ
 UqubHxT5MXS26za1/fqu3J8XJ4bdFtbsIgnwT04iDaIOI077lgBHbR5aDS5MXb0WembD
 qm57mrRbteOc9JqR/oZskPIfo7yfv0hC2AKTZFesiEFHZwGTC5hiaiUlG+odJAvGF9rC
 pFoBSaISu0Dd7eUQK/W3G03ceoY+VZWGEf7/sB+ZLj78ZGBVQkH+VdmT/XJyYGer4zmA
 aszAiy24LPVzlQiCRsQENXeXWjHPWvfpQSi+IZseJiP4oUUKhCZyAUwikcb/gguaJlix
 Ddjg==
X-Gm-Message-State: AOJu0YxEe+lwGB4qKXenYc1r/PRZNLZU5PnsvfXZXyA9CW4wkp/1suKP
 tS6p8ihbdXQVUsMyhploIVFfctpCeZpWToST/EptRBYoPukRIcKTDijLDbx9CSL+9dkEnzBqSH7
 W
X-Gm-Gg: ASbGnctdGIl5VyBwC4fr9sdU9q3VvazmTajMxgwSZwpy34Cp5XDO4hNCORoxNCqi8W1
 +UH+GIGe6L6hcnf8tLOZE5e0w2gLyruDrPXGcEAJFT8pK+fs5XiZuJmmg7UJpNNmiFk7ZNqbfUp
 DPvBEqNq8zMuqErHY2cX75z9uqFOTLLw2I33z7YgEQ/ujrAk7vqVaKDO7CP0+7clDG2McOPfE8j
 j5xjhQTePiF4+FRjldXhN2NrrKJZA1J26EFQk05VH+D9z1tveE5m1SqF5xfM40=
X-Google-Smtp-Source: AGHT+IEoSuBnWYygaaxBt5FZh1ykpzYxPOmAhRrQ5XC0zQhbEvFWj+A47qlpnYfpPQsE7wXUmcFdag==
X-Received: by 2002:a17:90b:2b86:b0:2ee:edae:75e with SMTP id
 98e67ed59e1d1-2f452e0a44dmr2296450a91.13.1734667884228; 
 Thu, 19 Dec 2024 20:11:24 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 27/51] tcg/optimize: Use fold_masks_zs in fold_or
Date: Thu, 19 Dec 2024 20:10:39 -0800
Message-ID: <20241220041104.53105-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 6af23f8512..9b351f0521 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2095,17 +2095,20 @@ static bool fold_not(OptContext *ctx, TCGOp *op)
 
 static bool fold_or(OptContext *ctx, TCGOp *op)
 {
+    uint64_t z_mask, s_mask;
+    TempOptInfo *t1, *t2;
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
+    t1 = arg_info(op->args[1]);
+    t2 = arg_info(op->args[2]);
+    z_mask = t1->z_mask | t2->z_mask;
+    s_mask = t1->s_mask & t2->s_mask;
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_orc(OptContext *ctx, TCGOp *op)
-- 
2.43.0


