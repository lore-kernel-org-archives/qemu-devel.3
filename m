Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B930E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL29g-0006WF-0n; Tue, 10 Dec 2024 10:28:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL29a-0006KN-Mh
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:28:04 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL29X-0000It-K2
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:28:01 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3eb4d2b39eeso717746b6e.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844478; x=1734449278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rlF3+b8Ya/xkhDBFRDkErRMqlneQEiaGonizob7aHXQ=;
 b=aqTytw+PRSKYsYDKDhlOujTAHze2HCbUcZra74XJGCAfRChIT3F0eZLuvogkbnyu2C
 4x5fhbd92F1/OsrglGgkgRZWDZB6W0WrsGoRUUscM88drBNDblYc8oOQVQIY5misr0Ku
 /AsmfbzLGYf/jG0a7qQENzTjFgE5qxIQP5gBlls4C7k47rEe7br6ACx2RjsGdToP3CSl
 MNhx2XKEGdad2B6Aor0k8FKieq/RjWcqgiPm330Mvqcl8RltlVWag5ISXCOtzsjUu3vY
 OpBNr6+QrjHLX6D+jDLtSegTkr04wTfkEzglKWhBm5oN5NaZ/Wn5fmOpSm1QJLjo7K06
 5rPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844478; x=1734449278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rlF3+b8Ya/xkhDBFRDkErRMqlneQEiaGonizob7aHXQ=;
 b=BidP5XQa2bl1YWJdHXYiyiuVWDUfJT5As1/WrTQ/SUFzWCQz/7cHYWdRwdTM3xAA9R
 JOLJ7bgCPzdSvPy5l9Q+PyjvWyNazHwjhPD4rkKwCYlwFzLXP423BpO5sV49dYhJLko+
 /8gYED2v1TCz6fOv5tya2heya1ApwzthEl+EpT8Qx+SDcUs3MkGaKSeXf3U6rT9AU3n2
 NWts7ZhMYi6qh20yaBGtq6JFW3esJEB0LNDH3FMvJK4cjNC4ejF5c43uVL8scC5lLOsW
 2jAiB8XC7pqFFE5g8s7CCu8m+bYiJ2eO9q2CTHA8DeYDbOv2NrMAXoSXu6LLdU0mKdwO
 /LQA==
X-Gm-Message-State: AOJu0YxPNOBFi9g9XTiMYTUD/7aaPnF5iabUKRAv+skAJQUjN0c9iU4m
 tvrjF/u/fwqu5OdjvfI5xZ+wkwnvaTt65VPoEo0UndKsuCLHOfYTrjfWBHsQQvFcvrInd9sX6XL
 rBYu9CWvn
X-Gm-Gg: ASbGncvAkc8zupMcUn8Jp6NdtTYwYdo/9ZND8ecXSkn/UgFUsQfkVB/Ua4K+gFgYcYC
 O0dW811OVjIlKl/0Ri9KGe3erVUswc+GNoHc5REBuFoXpG3thxBUJIXUQL1etj7M3vR0ETHnBhD
 iPivsWlPbH9VwjnZtiVc8sxgwz6d/ezEi9EWSYGbQrLNTNTQK8v2KnxNih7Jvfz+0JrkTvxuAbD
 owoEGJjjG9Y9JK3ZlWr4w1e1N8l63LzWuE6NJP6Z7pm120kt6/jbaJQHb6jqg==
X-Google-Smtp-Source: AGHT+IF/gsujM7tlBpGgI34GKQuciHKzalKFCLZW6sR1ugiZ4nH9W9VuFBUWWa9xkebFKCLL3Tl/iw==
X-Received: by 2002:a05:6808:1408:b0:3eb:4b3a:d578 with SMTP id
 5614622812f47-3eb66f52790mr3749172b6e.30.1733844478517; 
 Tue, 10 Dec 2024 07:27:58 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc4a0267esm2785955a34.52.2024.12.10.07.27.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:27:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 40/46] tcg/optimize: Use finish_folding in fold_tcg_ld_memcopy
Date: Tue, 10 Dec 2024 09:23:55 -0600
Message-ID: <20241210152401.1823648-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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
 tcg/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 4cccb3b0cf..46116970f3 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2674,7 +2674,7 @@ static bool fold_tcg_ld_memcopy(OptContext *ctx, TCGOp *op)
     TCGType type;
 
     if (op->args[1] != tcgv_ptr_arg(tcg_env)) {
-        return false;
+        return finish_folding(ctx, op);
     }
 
     type = ctx->type;
-- 
2.43.0


