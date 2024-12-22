Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FADE7718D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOm2-00031j-KH; Sun, 22 Dec 2024 11:25:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlW-0002dv-Cy
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:18 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlQ-0003C7-1z
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:10 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2166f1e589cso37250775ad.3
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884706; x=1735489506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fmhbhKUJPod0vBWmwZkZZRj8BUKwUG33IfyQB/0gkVY=;
 b=PDRLUG46HnHXGsRbJCauvkMU4MS70Dm7tZL/q/8zxI57QLMF30atzHHdXDgo5/rC1F
 DbOTL2dkT4ZzpDtyDECU+7IRtI8RmlwpAh2wCjmGZI/U/XoZfEspw8qKBs7RAKornsEw
 x9yEVLWxRWiGORroJjaPaZr8qsLMub1+XRQM0cLEEpu02uw7GO5BfFL64awBBf15GlJe
 p5Omvm2pjycN5VZBNLm7k0ysBMVPrXS9Jqo3sKWf7skvJrYwHnIrzuqH6hxtKINltoXw
 R4zyNgCXcwrZVVdIcDWuDKruHlxj/YNVQD+yPvFKDognf0dUOAp7ti8Gh/+bkl6XqVqT
 aYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884706; x=1735489506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fmhbhKUJPod0vBWmwZkZZRj8BUKwUG33IfyQB/0gkVY=;
 b=ioHmNneIMhPngdav6WXXM/mZ8MLxcuRCT5Ly1IR0SjjRHd+FvAzoUVJO/CkuPuZ0SA
 Eiw1GL1SM93SwycE1XiskbdIJLsYcjLN6VWv9pD2TqgN+oyLpJqxN+VyjidVSyBMj1mq
 tFXknzIC5RekGU+wVSboNjpccZL/tyA511v7eEd2HkkJvfN5wT0SzgvYf07klRF5fXqa
 qclFA3c075cF8oRug40TUGEYKFnnu4i/dEn/zQv3abbqx638niw5g9r/zQ7zSHhxWSA3
 ETR6ZOhczaPJR7KW48NyV0YO7+0wZgOAFC+KtLSnTvr9xcyjexf+vIMwsGhlInMzvenC
 isew==
X-Gm-Message-State: AOJu0Yw4jfkWQTq5lASdfZSmBiowHoqVzDo4BC+TxrTqpdnQp9ZwdVK0
 Zw6toHeebOQz5hi63ACHRSfIUgQR6R3mUbo/OdR6d0sXvweDXoIUBlghanziDPOsNmFDwL8MZxJ
 4mT4=
X-Gm-Gg: ASbGncsLNey+KnVtjSknoWQ5vj5/ptNEhAgNksmbLtTJT3uCnTwXtCF6DkVizxbhG/u
 O+1eCnSgS6Jb1/YWXTwgqwpgTnHAAXvJuH95OKVA6j8oHEngaF58uCGBi5fysKsRse4JghMmiPj
 bHGn2yJhnRRG8w9qJLBMQWAVp2eXL09U9Gzy+QxGXyRytOsNtPqUrZs4JTcatLAAT93L5SXX9pM
 8yaOMY7Y4kroRM2l3KUz+33CJKJp2CuqfELUIss+vWNGu9N2DXyaJmHhsTqN4c=
X-Google-Smtp-Source: AGHT+IGrM3ak8uRrtY38pCgKW+7syEDdAgMZA19obxsc1C8xgJy1ARQmFiaIlM/tmp5OjeP+inKjuw==
X-Received: by 2002:a17:902:ebc9:b0:216:7cde:523 with SMTP id
 d9443c01a7336-219e6ed39d6mr156213035ad.32.1734884705910; 
 Sun, 22 Dec 2024 08:25:05 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:25:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 29/51] tcg/optimize: Use fold_masks_zs in fold_orc
Date: Sun, 22 Dec 2024 08:24:24 -0800
Message-ID: <20241222162446.2415717-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Avoid the use of the OptContext slots.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 060d7153f8..c1305e9eab 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2079,6 +2079,8 @@ static bool fold_or(OptContext *ctx, TCGOp *op)
 
 static bool fold_orc(OptContext *ctx, TCGOp *op)
 {
+    uint64_t s_mask;
+
     if (fold_const2(ctx, op) ||
         fold_xx_to_i(ctx, op, -1) ||
         fold_xi_to_x(ctx, op, -1) ||
@@ -2086,9 +2088,9 @@ static bool fold_orc(OptContext *ctx, TCGOp *op)
         return true;
     }
 
-    ctx->s_mask = arg_info(op->args[1])->s_mask
-                & arg_info(op->args[2])->s_mask;
-    return false;
+    s_mask = arg_info(op->args[1])->s_mask
+           & arg_info(op->args[2])->s_mask;
+    return fold_masks_s(ctx, op, s_mask);
 }
 
 static bool fold_qemu_ld(OptContext *ctx, TCGOp *op)
-- 
2.43.0


