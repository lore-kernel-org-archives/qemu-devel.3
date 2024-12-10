Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0747E77182
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL26T-0004Pw-IN; Tue, 10 Dec 2024 10:24:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26B-0004He-1Z
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:32 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL266-0008Kg-2O
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:30 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3ea36b05654so2929660b6e.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844265; x=1734449065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=32IXJah6/fuv30HVrLXGx11Ws+Rbap8gqRIF0VsTssU=;
 b=KWFbJCVtF4uwxUHT8/+GIROpYXiLZEa8lgrkP4BbTR3AfNVaByHYeqMC0qjQ/G7Hzr
 HRKuoM1g1cnX6rfEBwyspTD7yIfYQJz8uwXNbJXv4xUSdlAnOOpfOKa61LMb8ZP6zCV1
 8K/jz0BK/YpxCJcVOfLMVjCj22MNV1PHlNwJEq7Fn2yMT0ZtXnwRDQ6om/mJwTptopWK
 OcF6HKFPhvCT3hKfM8cl5tTj8wAC3ubyai8tB9ZFcQm+u9H4JHEGzI4WwcVtgKBF0/Ol
 AGQDDPmuYruZsuh4a0vZWOEOvNlJiI7Ks41m8FQzmKdpTSrA7u//F/g3gofiUO2AACEi
 wy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844265; x=1734449065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=32IXJah6/fuv30HVrLXGx11Ws+Rbap8gqRIF0VsTssU=;
 b=rY+ycZpI6tDNCFyVDQfa+HoBs7lo/nQCsCykdMbWgxplkRbYOTAk8Eoa1OQ9nDbbpu
 82GcvHWyolzsT4OqQQgw3jnTD4UO9t81qgjObwn/OsRl4OIfmjP7AQ9q80BwviPDJHnL
 Lx7qn3w/1NihdFg+oc+F9/uv1i8yWipHSm7PIZK7Cb80HJFrKqbqeyUHX0/Tyteu4LtW
 8KrC0ZJAQl1Ml5kRMzxMMq/mwCDkG8uYdyeQL/FF1dU/jt+kTgj3pIGb2dmkUk7Ea7Lx
 1Gn/bPjWTTjXJGmD3IsGjwZe9HkCv8IALx6NLlp5SsjAdx0hp8kq3ZB1ZKBN1AUMRyxm
 61Cw==
X-Gm-Message-State: AOJu0YyAPXE+AhcOf0FpdOmsZK/NJZHevAGSuiVlmdu54MhB2ePUKFBX
 23GfdeKOD4YzZGwI+8ZzNQOFY+syO6Ic5ZO3rBbPPzM4+gCEGVEONA7lcG+bJiEln5o6nuIQN+5
 a5htDhJ5d
X-Gm-Gg: ASbGnctdXoZWBSDVUdn/XFvibW95UsfLK9fIsrmezfeB6IPIklMYm5ANR0SER+/0vyi
 zYZEY0ya8j+eHNiRY/Sui5ZmH7PzJkGH4r2oFtK0JOKt3Q1xfkpqDyu2++1z4rqrzrZYd+kwwRE
 EAXRu3IR0mjmrdNC2oLdG0rwOab/pECJNnvl+7A2Fx+didXpzUC1j7ptcVImcUj2nu7mHlzrphn
 FDWXHXu4Dc9NqKfs0Mxb9dhxVjuoGBihNFSFpFuuJ6HTS7lIZNF5aQnr/rPHA==
X-Google-Smtp-Source: AGHT+IFmr8D0LI8knnGHv7I4D/9eHuK2kLjt0cbgTxth9nc0UHdhs7E6xtpG67BSgzCb7pCEYll/7Q==
X-Received: by 2002:a05:6808:1701:b0:3ea:4be7:254b with SMTP id
 5614622812f47-3eb19df8475mr12068007b6e.28.1733844265079; 
 Tue, 10 Dec 2024 07:24:25 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/46] tcg/optimize: Use finish_folding in fold_dup, fold_dup2
Date: Tue, 10 Dec 2024 09:23:28 -0600
Message-ID: <20241210152401.1823648-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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
 tcg/optimize.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 59f510b49a..e6dc9f2e28 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1681,7 +1681,7 @@ static bool fold_dup(OptContext *ctx, TCGOp *op)
         t = dup_const(TCGOP_VECE(op), t);
         return tcg_opt_gen_movi(ctx, op, op->args[0], t);
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_dup2(OptContext *ctx, TCGOp *op)
@@ -1696,7 +1696,7 @@ static bool fold_dup2(OptContext *ctx, TCGOp *op)
         op->opc = INDEX_op_dup_vec;
         TCGOP_VECE(op) = MO_32;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_eqv(OptContext *ctx, TCGOp *op)
-- 
2.43.0


