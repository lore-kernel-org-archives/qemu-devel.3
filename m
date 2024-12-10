Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C77E77182
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL26r-0004yI-UO; Tue, 10 Dec 2024 10:25:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26c-0004lP-E4
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:58 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26a-0008Qd-RJ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:58 -0500
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3eb3c143727so1239354b6e.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844296; x=1734449096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=puElikFFzv1lK2CkoPetqFbU1n+Bskb4VdjdC5Y/jYk=;
 b=T4YtC8/jEyAHGxS7iGqnX5s/QTMvFk6fH7QFS83DEd6Y4RVvKuz7/xT9uggyJdI5+i
 6wgtFEdSdDLAy7yjvM+TmF58XvaYItma3vkZvBDo/rlvRteh4ZJN8fq61Qtf/bd8U0aS
 ktyvDzruFNXBe4iPproYj7AFEF+LVqbiW+hKo7G30G0o5OXorqSMzo9312oDaV1EhMGf
 jfucXXlJO0hvO1WbS2bX5DrLGW9j+nuSw2NFJJNzY+nt3MkLWPe5eGHLREL8dENvd0bA
 KyfpBZflVuCYIZ3DzGXj6aBqH+cpa3NhRpbKGD79WnmPfmHHjXQf5sB577tNB3cUMLZF
 T9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844296; x=1734449096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=puElikFFzv1lK2CkoPetqFbU1n+Bskb4VdjdC5Y/jYk=;
 b=grwGW26e53QpDGtvsh2uEuiQ0jetWRu0WIg5WGAZ2yiPZJrZr4MDOjJ/5oI07BK70S
 dgR8MT6tJP2Xw68gse8unR6g4oUrMyOYVYBRV5oYBHWVSE6lNrfZULkdN0iMW7AnukX3
 HnR3uzbK/HA6haeAA3yO5pmeBvVdRJG4u1Aj4wzsE5gOISsoxBGVOpFRaN3I981bKM8D
 L9xwuw0+DY0E8azdNVstGpqp6R1EHD893CfNuI0op5ALYlWVrKZgJWWbJqAXIfO+/iY3
 SI7NWZXNA0tkvhMdcMiBGCjJzrtsQSYmpOvehVNBq6twoweRzZTvZ/f/zLK5wSSs+xDa
 PD1g==
X-Gm-Message-State: AOJu0YxCc59DDuwczOQmvqO3gd2rT3QBjZ4EsAbT0RES7tGtvanq1bVd
 vpJ3zjq5KVKnJTzBpk1iufyt61DBo5EI8VfYpWG5/7rtcL4Am1yYUnWkfXoynrkwqZhuEJyij4w
 8d+4Oed+s
X-Gm-Gg: ASbGncvdsJuW+WdbvmISeLaCSOWUbu5knTu0cnaSPCWDiMi/RvvCTZULlbK0/6NCsb+
 yKQyPPE9nHILXtgEiqNJAOreQ2QfskrIFOY/Q75FHvcaQz86Jl9v1Zc3st0o6+yt6Qudtmjqs6f
 kSeMByzgeBEFLGNwas0vNeTj6cezFAvylRd4TSuUoyCc5b8wKDshOAOpkkzgQowrVrHxgo23olP
 q8UFs0zaobFd4NPMqIViMUBDJ0sUlvRXSdddMPWxYTBtl5CiRIlbci/NfRVUA==
X-Google-Smtp-Source: AGHT+IHY5W3ZwRxsmbCBh3Vupfl1ckxAfGy5rLkLw5qPKYdFhjQRKoQ5Ge+PXcWSC+pj1WWGbOxKsQ==
X-Received: by 2002:a05:6808:1b2b:b0:3e6:22d4:d2c8 with SMTP id
 5614622812f47-3eb6b8c19bfmr2326781b6e.12.1733844295761; 
 Tue, 10 Dec 2024 07:24:55 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 38/46] tcg/optimize: Use finish_folding in fold_sub,
 fold_sub_vec
Date: Tue, 10 Dec 2024 09:23:53 -0600
Message-ID: <20241210152401.1823648-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index bec5a07288..6412d5df37 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2606,12 +2606,15 @@ static bool fold_sub_vec(OptContext *ctx, TCGOp *op)
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
 
@@ -2623,7 +2626,7 @@ static bool fold_sub(OptContext *ctx, TCGOp *op)
                    ? INDEX_op_add_i32 : INDEX_op_add_i64);
         op->args[2] = arg_new_constant(ctx, -val);
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_sub2(OptContext *ctx, TCGOp *op)
-- 
2.43.0


