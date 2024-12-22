Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A267E7718D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOod-0004yP-Kr; Sun, 22 Dec 2024 11:28:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOoU-0004pf-UT
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:28:20 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOoS-0003in-SE
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:28:18 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-728e1799d95so3905796b3a.2
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884895; x=1735489695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iq5WjGEeXV0oMIGl3lea1fV+HUTEzwYMRPJeFRmjgrU=;
 b=SEMUGdOVr3RfoMZOQmyr5UoqNFgyXGWkmwYOOhcIRmDsKWtvHhLCG5l77ZpdY/DByl
 o2cE2a+RprLEc8UBPFc0tXTSAXdDquEBGnbLn35bgAwG/RIpRBckFGaB34ySIYqlE++i
 Wa45vTCFPYQkLL8Wr7nOnqqMovcUNXUWmM37NudJkCJ+rRSMJGpqSjO0GWhPrIG9DWMU
 drwE+iJ4f6dGGYbQOVD9YqehlT1/8n0d0ADNhSjsvO7siAFsTXr0/tzXfUZp4VkAldyf
 kU2wOg6IiWJyKQm8QAIkhA1jgZgUe4kh3HGa5GSUaj69M+ZOB7bwv1mEN8CwVoqwWRKt
 it/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884895; x=1735489695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iq5WjGEeXV0oMIGl3lea1fV+HUTEzwYMRPJeFRmjgrU=;
 b=bsNKYFUbxrCzlTu3d6OwMepGtWWneua9gG+ayOixKIQZ9LUyswyZCZsYbvx3jBi5YB
 DHhif4+EDl8uE4au5nKYGye90eMMCEA9CBTtOqVVjpmE2lpGE7Omsn9iw1q9OUxQnMUf
 DKCYIZ1AAD5Aw90f06avn0fIatvbgNGtvCi43wQ+GkfYA8rMwHQCtvLDGDfUS1U0SUam
 C3A6s07tdmC2UmCiVyqfOXFImOefRf3Q85Ulc4VHAWg3Zv5lEp5EwAWTDP3O/XOmSu2w
 fIJzxU463MpJpTHi9Bio4QPpNoYV8MbO4LQimSNQrMWJy50LNb/FjfBuvtdSRW00sedV
 v+vw==
X-Gm-Message-State: AOJu0Yybux3odGXwHavOuh1JuvXGjXMXxA4yfFXRZgbg0V+/wjJm+b5N
 55CULUe6mCBYI20sAsF+/gHFDfTqz7XbMHnbwXwNdNnYIZbK+0FhRPLXgOZyFUU+0Ao61rR3fvQ
 J5Mc=
X-Gm-Gg: ASbGncu6he+FqJlkGq3IMl6Kv0r25dRQ/1vwI15GokPhqJm0+FexVjt4fq0+ug/UY/y
 odls66roZDEYbiiUJfm93mqfAsVEO+qfG1Fi2mXiaWXSa0rhh5gLtynwfsRPmiDazYKt6E9BNF3
 xfaMOgHu+Vf58tM3KpySCZzx2eK7rMSXtGJ72QvfrAc/kDOGRYDuKadNTyvYuSePgDVIlGtzWAp
 AMqyUQBcWKIuK2UDXM8DhfDF4DuhbRzLhLAL924Hgrj+SZHdHL9M8UaTXmDtD0=
X-Google-Smtp-Source: AGHT+IGdAnwcm/gSfTwgoBg/sMVBuni0+GnKprII4UdHSUCMJXt7irC0VmxLhH7pjdSmTiAzNtxAMw==
X-Received: by 2002:a05:6a21:3a8e:b0:1e2:5c9:65e0 with SMTP id
 adf61e73a8af0-1e5e07f0218mr18512621637.32.1734884895425; 
 Sun, 22 Dec 2024 08:28:15 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842dcaca43bsm5848808a12.66.2024.12.22.08.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:28:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 42/51] tcg/optimize: Use finish_folding in fold_sub,
 fold_sub_vec
Date: Sun, 22 Dec 2024 08:24:37 -0800
Message-ID: <20241222162446.2415717-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Duplicate fold_sub_vec into fold_sub instead of calling it,
now that fold_sub_vec always returns true.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index e53e6b6969..14d3d6253d 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2603,12 +2603,15 @@ static bool fold_sub_vec(OptContext *ctx, TCGOp *op)
         fold_sub_to_neg(ctx, op)) {
         return true;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_sub(OptContext *ctx, TCGOp *op)
 {
-    if (fold_const2(ctx, op) || fold_sub_vec(ctx, op)) {
+    if (fold_const2(ctx, op) ||
+        fold_xx_to_i(ctx, op, 0) ||
+        fold_xi_to_x(ctx, op, 0) ||
+        fold_sub_to_neg(ctx, op)) {
         return true;
     }
 
@@ -2620,7 +2623,7 @@ static bool fold_sub(OptContext *ctx, TCGOp *op)
                    ? INDEX_op_add_i32 : INDEX_op_add_i64);
         op->args[2] = arg_new_constant(ctx, -val);
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_sub2(OptContext *ctx, TCGOp *op)
-- 
2.43.0


