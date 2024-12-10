Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AECE77182
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL261-0004FA-MQ; Tue, 10 Dec 2024 10:24:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL25z-0004EG-Q5
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:19 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL25y-0008Jd-EL
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:19 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3eb6dc3e850so279455b6e.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844257; x=1734449057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SXs3m28ycLQmx8xtZpOjbDlN5Q+uFA8LPLB8ut2EK6k=;
 b=pOpecITT4smQ8bcNCSYUy+5/pMdpqy4O7EQXA/hmUxZzRrWJdVIwgBSrt+77VRJWrb
 u2WDF8rYOs2DH+zLzUj+h5cspKmmlAwZv83fyx8eSf937b/cY87yVJV5p4a/J9M+HO/4
 e7583Pwy8VSXJ0wYvlNDCtP0Yv33S15lJJANh9Xmctw1s5Tvrh/8KmWLjbpFJscAT9uX
 UV1alZsjKQuOEILhF0BnB5GrV3Qz2wAfCwjCzw1yzRrpLYPDylgb/TicVKG70zRNpd7z
 EHgW1l0+4TGluAnECkMhggGGf4hNuCN+S4vevgCObkK2DYJSDkSXHJd/taW9gj1j+zqw
 otEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844257; x=1734449057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SXs3m28ycLQmx8xtZpOjbDlN5Q+uFA8LPLB8ut2EK6k=;
 b=aPTn8mkTxGFSC36VF41xDE8OzfYTg31qEqqqbMRzc+RRMK1EmN2xoyqoN9TNDK0rmn
 YHDLYhlgJ9tSQXv2BDA7AVi3Ths+59RLt7NtJnAL+PRz4rT9bs8hbffKqz0JRR/VKOyH
 CoRYQU6D32rlOJFFHHkUamoKSHXHuSiRN5uv55w5K7gBy8WQ8Z0HeXriWwe4cxjQZgNW
 SP+bOKw1AAqJtgx3JjIJ1vb6SVd/UKaX/N88XxKZQSES/nqlOlFGd+ONl9xkSj1/vqbC
 DH+BVkTcd5jX+VZXLyyiUM/cwJ06ZXeVGyyKdvbB6B0qU7CXWvJtAlksBlG9sfMmFg4l
 12vA==
X-Gm-Message-State: AOJu0YySM5OGqCDN04F/vnI1zyDQUeOdS4fN8FTs9xfOSyOUbZ07vrv1
 RlYK0Dnj7+erIM9V5lsKWeB/KNp4Oc23HoEC4BX+3cG4tajRg6OXXLxvI+PXjLHvu+tWQfFHItB
 3qXtw0USE
X-Gm-Gg: ASbGncsT0TREBp6SLXnZcmSqrBEjdcf7BBbu2VKOYQTr9di9Cb68TXoeWXOWHxmo6ft
 ZzozJ1zuR7v1UoHv/gnEtUqz8TSYsfIR24JIvGoVqP19YID0zCp/wJIpbS0sN08vbFAFK4rqJqz
 bMYW0Kd2yXmJtgad8lG14zZBUzEQu2W0bEY4QNohz9fzzg1NTwJ6oIRmutipjfmOzgUAz/NEZj9
 g1YdEjnd+LF6BCg8MShR0iXwp8LcpUOpro27anSGfTg7R8Jh8rY5p7YztFwdQ==
X-Google-Smtp-Source: AGHT+IFmEsdhTVhW+tnKvxVgoRBiIfLyr32qc2p2mTC4vvlfgo3+CXQo8LXXkJ8U3KOZmFYe687CUg==
X-Received: by 2002:a05:6808:bc5:b0:3eb:5fbf:1b98 with SMTP id
 5614622812f47-3eb66dea1e3mr3785561b6e.10.1733844257365; 
 Tue, 10 Dec 2024 07:24:17 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/46] tcg/optimize: Use fold_masks_zsa in fold_andc
Date: Tue, 10 Dec 2024 09:23:22 -0600
Message-ID: <20241210152401.1823648-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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
 tcg/optimize.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 000ac0f810..285407ce05 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1339,7 +1339,7 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
 
 static bool fold_andc(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z1;
+    uint64_t z_mask, s_mask, a_mask = -1;
 
     if (fold_const2(ctx, op) ||
         fold_xx_to_i(ctx, op, 0) ||
@@ -1348,7 +1348,7 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
         return true;
     }
 
-    z1 = arg_info(op->args[1])->z_mask;
+    z_mask = arg_info(op->args[1])->z_mask;
 
     /*
      * Known-zeros does not imply known-ones.  Therefore unless
@@ -1356,14 +1356,13 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
      */
     if (arg_is_const(op->args[2])) {
         uint64_t z2 = ~arg_info(op->args[2])->z_mask;
-        ctx->a_mask = z1 & ~z2;
-        z1 &= z2;
+        a_mask = z_mask & ~z2;
+        z_mask &= z2;
     }
-    ctx->z_mask = z1;
 
-    ctx->s_mask = arg_info(op->args[1])->s_mask
-                & arg_info(op->args[2])->s_mask;
-    return fold_masks(ctx, op);
+    s_mask = arg_info(op->args[1])->s_mask
+           & arg_info(op->args[2])->s_mask;
+    return fold_masks_zsa(ctx, op, z_mask, s_mask, a_mask);
 }
 
 static bool fold_brcond(OptContext *ctx, TCGOp *op)
-- 
2.43.0


