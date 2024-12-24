Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A52E7718E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBAU-0003Nk-0o; Tue, 24 Dec 2024 15:06:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBA8-0002q9-Dr
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:52 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBA7-0002bb-07
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:52 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21670dce0a7so73889605ad.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070750; x=1735675550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+KmIKK5m1+rAgUJimrheKhjHg0Yeug9PGMeGHHJk+c=;
 b=DxNMIBTsVmglyud2RYa5k0KvGaynqdLFy5i3nu2C3Cau+wcI+LgJ34k2nVQs3F7Iz7
 OU2+KVNwcySRn5p6Yoj3U8DBpi1TcOuptWyG8UV0+uAKAZPr8+XUDeZwTsrLamFbmOLj
 JeZPVj7YYdSBiBvLHcrlIf1KYg50yKi5LNstCa07TFxSnJh62jkM8NywfBqpGm8ByZEr
 6KY5b1Mspx+qAPNYfRWgpl1eHuWslC9zrpnQbXEo4OBXC+wLTdJER9G96Y3hRKkhchWd
 Nd3hky6HF7kcHxFak0U9JKzOQEXigSSdF5pQnw93iKaIdXs2cnCQ5wpGrXpEj3CjD5vj
 J2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070750; x=1735675550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m+KmIKK5m1+rAgUJimrheKhjHg0Yeug9PGMeGHHJk+c=;
 b=fTz1AXmxhgGYeyj3vKjdWnDFc+UJ3inJyQ8EV739DBgNm0m2FL5RNzkNNiYtBLdZQA
 Smzc6V3qUpAKTUkIp/QEG1BhEw3gPI7J65nztQHyDAzVE911i/Z4SoT0AefHPEYrwQpr
 9RLz3lEFNglEZaq5xWU6m8ilxXw3luwxWZSOyZ7IX6EQYYvZ1NT9aDUeDSA/XKZ8W4ZC
 S4kILD58a9vdIYtGZTk+Sqz4YEKk3O89pMRYXLSKernyZRpYa7/9VMKu9ZCzM38vAHnJ
 bnVQQVUnFvYAGBBRF0nMxcA1UPzJKrNf2sPKcyHTTItbv2YFbejTrowH//SJUF9dDVOS
 BvKQ==
X-Gm-Message-State: AOJu0Yw3NdLLwNagEKr/oe0qjaH685QOKfV1M8aEapFfGWTpA0gbvEas
 ss91WNi09NBbZHNd31KSEF8192CvZ07B5ajVxARIHhoJ5dkWyLh2pC+WyDlPZR/Vc8UB1Ct98UE
 5EVY=
X-Gm-Gg: ASbGncsoJS5+F75B5j3YW/KP7ZEpbTdL7RIupITN9VwVjNz9CMsRT3Xj4cDZ17Fu9gL
 PhAx+ADfMTUejpIWsAd3aFGrAEgHifJDQQ9029F2JEpAzRtWiyx54BV8wa1Wwn5atxfQp4eXHl8
 6rRQDnFSK8wFjw28H8c66fHFMvxOHNWSIvTD39PwHZpBhX8A9oe06pzjdCyAnfRXuS+/M8wOwi5
 WpJg1f2mfgsnkuRubw4S8lTemo7liZyQhy4hiOlp2nokaWV9KU7IxrN/cMrDRg1d/p+IsPCrFq1
 S7xVHKeDAH4BykS0EmDlk4GkMA==
X-Google-Smtp-Source: AGHT+IFRJWjepRfH7p438/NpbwKJARUYpzyzA2UsSXUSYVVCAj13FJJaz5SL/753jpJIAQ9o/HEWEQ==
X-Received: by 2002:a05:6a00:8d8d:b0:725:e05a:c975 with SMTP id
 d2e1a72fcca58-72abdebc11dmr26292281b3a.19.1735070749726; 
 Tue, 24 Dec 2024 12:05:49 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 29/72] tcg/optimize: Use fold_masks_s in fold_nor
Date: Tue, 24 Dec 2024 12:04:38 -0800
Message-ID: <20241224200521.310066-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
index fbaaece152..acff3985f3 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2056,14 +2056,16 @@ static bool fold_neg(OptContext *ctx, TCGOp *op)
 
 static bool fold_nor(OptContext *ctx, TCGOp *op)
 {
+    uint64_t s_mask;
+
     if (fold_const2_commutative(ctx, op) ||
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
 
 static bool fold_not(OptContext *ctx, TCGOp *op)
-- 
2.43.0


