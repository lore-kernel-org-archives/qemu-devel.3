Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021B9C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUM9-0008Nu-9c; Thu, 19 Dec 2024 23:11:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM7-0008Md-OH
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:15 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM6-0006Id-9i
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:15 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2efe25558ddso1055759a91.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667873; x=1735272673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wg8rqRAgWRCDilgaz5IPxRaaVO9cOj5AUka7Masx2ag=;
 b=dzUQCSS01mB6O3F2CekUidvje6/ZkNftRophfv8T31HeWLqmx2muuH33XJ3gWgFGHb
 in1/oo/Q4o0/7Nq1HDhNx/IqHc1d/3iMaoV7/5Jhm5L1y4w7FfDVpZFbE39R5pPhpgfd
 LagNBuibreD5xbQokApJ8mf7TbDb9GQE65zWsQ28mm1V7O81LbOKdxCtPDphukYGMMa0
 NBwN5K/tXtl1UxoG89HxuTV6xwMfKrAZDGOI6cBh4Y2jNBJTh8NjHL6gEkQx8uS0MALP
 Sc1r1C7vktSWqbd+hxwrmavrotNWdDu42W30enbOmmguwF67UHtUGXV3FO2XYm435GPC
 wYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667873; x=1735272673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wg8rqRAgWRCDilgaz5IPxRaaVO9cOj5AUka7Masx2ag=;
 b=F/ZEQmzC7bI8aFLKjoBizB1Unflmti/kG/YS80RoZMMXaMbMT47Ud0OtlQm5kXdIHj
 X5fxvYl+1bBhVjV9yAzojHwk4JQSzk84Yi1786aafLRQI4RWn7oZl7b0kDxCdneLvUNR
 CE2Jkh2s/EYR7jHvfm00+fBprKqoR3I++TCIzjJP4tc4NjzHBFklFOLD4TxCdKTTpGJU
 AOUdylbuYHFrJZOrmPYnjZyoaktl5mil1SpTLNp5Xc8zSgjMzJM0scJbZpQJG/DSMZJb
 SRVhYZGwFCfRuO84aWnxHS8ze6Fg9MJMNtbVWC5HPB0R0JvgLSjjwmu+9xWyPmVU0ISv
 08Eg==
X-Gm-Message-State: AOJu0YwHe62WVufPuI3movs4nHkKSMLtphOtV2aTncVoKw6hPkQd7LMT
 5zzVK5T4VnGf6A6fe427CAMnJXOuHtLA3m3iqzzdRL7dIrmszD/E8nngXPNWNq02HnhVQ6LfJ+x
 k
X-Gm-Gg: ASbGnctidfklxkjY5TmGu+99rBMH+UWivMslEh19ttxjd0FxFCM1YrXJqNoKxRV8Fdj
 WHLU/sCi0POBi4ZoIHeBIg4m+7U7sRFmb+1JBlTth2yKwQCftnldaupuKJ7dQFz32P+1AuSNLdh
 SBBZQ7ntdoiqxKZTNKzxLmEGS/GpwwIq0uoPk5MZ37CQ5XMlVFKYbclZEUdYPgxRi2fPVn77VMO
 nf5zu+nTG+W1KjjFi83Alhw71vLUddd0gzzF9J8Wb3sN0Ip/hi2Ep8+r+KySl8=
X-Google-Smtp-Source: AGHT+IGCarUgOP+jfEAYr/9Yazq590U7Uiesh/nSGWqJTj0ogOStCHvfsbTgq93hkI5eoH7w1JduFw==
X-Received: by 2002:a17:90b:51c1:b0:2ee:8031:cdbc with SMTP id
 98e67ed59e1d1-2f452ee634bmr2053664a91.23.1734667872955; 
 Thu, 19 Dec 2024 20:11:12 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 11/51] tcg/optimize: Use fold_masks_z in fold_ctpop
Date: Thu, 19 Dec 2024 20:10:23 -0800
Message-ID: <20241220041104.53105-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Add fold_masks_z as a trivial wrapper around fold_masks_zs.
Avoid the use of the OptContext slots.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 270051acd1..af7111c98c 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1086,6 +1086,11 @@ static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
     return true;
 }
 
+static bool fold_masks_z(OptContext *ctx, TCGOp *op, uint64_t z_mask)
+{
+    return fold_masks_zs(ctx, op, z_mask, 0);
+}
+
 static bool fold_masks(OptContext *ctx, TCGOp *op)
 {
     return fold_masks_zs(ctx, op, ctx->z_mask, ctx->s_mask);
@@ -1616,21 +1621,23 @@ static bool fold_count_zeros(OptContext *ctx, TCGOp *op)
 
 static bool fold_ctpop(OptContext *ctx, TCGOp *op)
 {
+    uint64_t z_mask;
+
     if (fold_const1(ctx, op)) {
         return true;
     }
 
     switch (ctx->type) {
     case TCG_TYPE_I32:
-        ctx->z_mask = 32 | 31;
+        z_mask = 32 | 31;
         break;
     case TCG_TYPE_I64:
-        ctx->z_mask = 64 | 63;
+        z_mask = 64 | 63;
         break;
     default:
         g_assert_not_reached();
     }
-    return false;
+    return fold_masks_z(ctx, op, z_mask);
 }
 
 static bool fold_deposit(OptContext *ctx, TCGOp *op)
-- 
2.43.0


