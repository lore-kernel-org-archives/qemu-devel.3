Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D624BE7718E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBAw-0003yG-EI; Tue, 24 Dec 2024 15:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBAA-0002rq-8Z
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:54 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBA7-0002bq-Uv
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:53 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2166022c5caso50537755ad.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070750; x=1735675550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aEBTSGoKSzGGXaHrfubxIygx65LoU6vieRsyMgqBwp4=;
 b=lFcTcIBQJXQDmu+DRM8Dq/vAGqsOVTeVbv0Zhb8Uka8sudJIjgE5sDpGjUfy5Mh/pQ
 XwA82NceN6g4fBnncYlJeA7euIvjwSH9P5Ys1pVSELos5iA93LIDLN3j9igSzyGmBGkG
 rgnffitgNduvKe1J2XyDv8Ojc61bt5FFg7XZ5NRgyJ2UGUdCvtqm0rNMiidbbxG6Pt06
 Zqm/Fvwn1cCJ6RkVBRN2zi/+0lFyj2pdX/KNNlB3UfzZgh7G0jBYuhysZTOXcSlxKCN7
 SSZqtGeYcSXsbdFtw1THIPqf+svJArd4NknTuKBOlKWdUQ3czuO9d6/kbZLMUnAlE/e/
 aCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070750; x=1735675550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aEBTSGoKSzGGXaHrfubxIygx65LoU6vieRsyMgqBwp4=;
 b=njzQPvXBJKq9aQQulckqunPEluRxWOZILhEu36rmOF8AFrRCdtrCvfwykouthqAey4
 69GdM8CtymvOaykvdxp6kGJ4hXXOui0lcXeVRydES8SJEf+9tFgrbl2BUJkowpvcz8qg
 xRR215XOXCxy+VY1ewieustedXMam95vq+C3C72FWUM2/eQuJFZ08usyRi4TUyIclK8z
 EfnFY0ODMa+WfYFII32jiFmluZ7wWqKtXTsG/EEL0J7OW+lUMH4zQTFNPYZMCSuc4eBZ
 qkY86xj/Dxt2dW5uh73sIeH8km+r2YRhY+N8o9NGjBV9aglvFH7FAWZL1fyLigB9MWEn
 QFTQ==
X-Gm-Message-State: AOJu0YypS5skf5xZBbvK7eHGo+PUpx8zoT3w6wDUj1fu/ZfzX9HtGdRh
 jT6M9fuL6m8iret4mRaJqP7Tme3pvk0Mptf7D1peNPEGqpgWoijE1M3UPIn0JR0DsyDugUUEVvt
 fHdE=
X-Gm-Gg: ASbGnct/aBsdM01/op2KLr+rJm8iDvMcnpP1YQni97Rp7hJk3egczm5WwHJWzvQwNuk
 7OiCjPvUjxaFBZHMmxmj9rOChmjbkJNdU+hwM2yKv2irUT0ylDhapRS1Ny/mnaTb5o/OMf/ileF
 crey4Sxb2ZcSN+uQS2NtIqzCOqZd65FPS3tt+eQ2ghKSalA7xZNR0PU0F9TTM4ZXgwHrUAgdtOG
 cSJJqUB8axjm4PvwXf7WR9seMrejYcYlc1RlvuO8Kex4MrGwhT2Q7CBA3rtY7u0n/6LJ8dygvPF
 sdIXqI41OiNcEwbRad8k/KevGA==
X-Google-Smtp-Source: AGHT+IGc+d3IWpHXxky+T0bKz9oJ1Yyox6Kbhx/t6s26ucXtEpKV8muNXh9wlwmhabZbPvYEfgy1tA==
X-Received: by 2002:a05:6a00:1702:b0:728:9d19:d2ea with SMTP id
 d2e1a72fcca58-72abddb2115mr26199908b3a.13.1735070750645; 
 Tue, 24 Dec 2024 12:05:50 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 30/72] tcg/optimize: Use fold_masks_s in fold_not
Date: Tue, 24 Dec 2024 12:04:39 -0800
Message-ID: <20241224200521.310066-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
 tcg/optimize.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index acff3985f3..4ede218bfc 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2073,12 +2073,7 @@ static bool fold_not(OptContext *ctx, TCGOp *op)
     if (fold_const1(ctx, op)) {
         return true;
     }
-
-    ctx->s_mask = arg_info(op->args[1])->s_mask;
-
-    /* Because of fold_to_not, we want to always return true, via finish. */
-    finish_folding(ctx, op);
-    return true;
+    return fold_masks_s(ctx, op, arg_info(op->args[1])->s_mask);
 }
 
 static bool fold_or(OptContext *ctx, TCGOp *op)
-- 
2.43.0


