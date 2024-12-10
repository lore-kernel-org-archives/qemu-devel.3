Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7755E77182
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL26S-0004Ov-LW; Tue, 10 Dec 2024 10:24:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26G-0004Ip-32
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:36 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26E-0008MC-28
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:35 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3ea36b05654so2929729b6e.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844273; x=1734449073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MseSTAJQd2JO+Oxcl8SX4JBGUGp4lJvsrlQBqePNo2o=;
 b=bYAju5hsSbp5cRMKwLgZ0M+8TuG9BL3wcuPiFmU5jwSr10TwaczF5+AZ3PeODtwkDp
 QMu8LaUeJsqM1X3637fiwEKzzTJRbeP4JHfHpEtc3tH4YHso8rQwAkJQKmlxsoWKC2Xg
 XivKpBDmDHSW/vTtIHC6Kc+sigDz1dmRg/pI8g18RLksCVnRvip4cYEdvYx/uOfJ31y3
 WoxGReNaef3QpGsWByvxtCHH/RpWA4k/XMWwCUm/MPWS9hxxRpqONHKnOc++x4wZc8Go
 3Ngkn6EqzGrqRpVvHyKA4Se6sIdi04nIhZnrKaWLayKB1fMtJ8S1qajDWlY0+HgEPdbT
 QIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844273; x=1734449073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MseSTAJQd2JO+Oxcl8SX4JBGUGp4lJvsrlQBqePNo2o=;
 b=psVpczkI1vH0FLmgXyQCo+tkL4nZI7JINJf+rZwa2Rf6QHVs982doostEwUl24NXTm
 LLYpb22TiAzIt02jRDdI67Ar+NOOgjENusC2qC7X6oIhkf4Vj+FPHD6kEribNl8Hak9l
 FICfDiYy2eVjoDN1yDF+NFMDKBahuayZ08znoMe2PbyO5WLlxJS0x0/KukgbFusc3i5E
 yF158I0Qg9bjKybegHsW3112vs5VzvhISK05qTztDwvHSno7JCX6kGz5vwTCVr7WapxP
 v5xVfM3tVUIbw6KkcAlQrC7+jQpJ9UrGFp910CdmfbUJaryoRzNcYOcnaP/ES7RxCi6e
 4hDw==
X-Gm-Message-State: AOJu0YwtzZonY80llUPI0bYATMVV/FCuX/LHZ7nQ75K4WJvJUpxaeNRz
 9DyeZskBVFi22xPHnYjJsh/gmAZiJXmNxHdVezpCotJLVRDBtmSTexszwTG6dbJl4tXne3duR8+
 d43tWkmfq
X-Gm-Gg: ASbGncszgw6ehZenhrzf8MjGpBWDbZmqSmDyTtFqYSUrokolYZDOJ0fYb0rHrHaRDX2
 Jto6OkzTU89varVVts5Xas5yPKVj3V8WBcFvRZoPCznX79L6/TiRB48zZEnzAk2+sug86EFCip5
 jujG1BJcgKyIv1jY8MSvRYIV6GC6ZhD28EeSYlX6GtpLeXdhGtyxhSqggUlnQFCKbihzs3bi6Ll
 5io/3Vjr1azsMkJWOxsvgKoCxK5wlogqcrastn4vEct2GYgqImDw3Ddftatzw==
X-Google-Smtp-Source: AGHT+IH5IJ92jHVMq1Wkou3qZsJz7WCItVFgV9Ypsiio40fB2E/9Dcf9s50EMRLILiNpWgSh/J0OzA==
X-Received: by 2002:a05:6808:1701:b0:3ea:4be7:254b with SMTP id
 5614622812f47-3eb19df8475mr12068337b6e.28.1733844272929; 
 Tue, 10 Dec 2024 07:24:32 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/46] tcg/optimize: Use fold_masks_zs in fold_movcond
Date: Tue, 10 Dec 2024 09:23:34 -0600
Message-ID: <20241210152401.1823648-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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
 tcg/optimize.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 260e3ea072..6d2d55f053 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1874,6 +1874,7 @@ static bool fold_mov(OptContext *ctx, TCGOp *op)
 
 static bool fold_movcond(OptContext *ctx, TCGOp *op)
 {
+    uint64_t z_mask, s_mask;
     int i;
 
     /* If true and false values are the same, eliminate the cmp. */
@@ -1895,10 +1896,10 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
         return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[4 - i]);
     }
 
-    ctx->z_mask = arg_info(op->args[3])->z_mask
-                | arg_info(op->args[4])->z_mask;
-    ctx->s_mask = arg_info(op->args[3])->s_mask
-                & arg_info(op->args[4])->s_mask;
+    z_mask = arg_info(op->args[3])->z_mask
+           | arg_info(op->args[4])->z_mask;
+    s_mask = arg_info(op->args[3])->s_mask
+           & arg_info(op->args[4])->s_mask;
 
     if (arg_is_const(op->args[3]) && arg_is_const(op->args[4])) {
         uint64_t tv = arg_info(op->args[3])->val;
@@ -1941,7 +1942,7 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
             }
         }
     }
-    return false;
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_mul(OptContext *ctx, TCGOp *op)
-- 
2.43.0


