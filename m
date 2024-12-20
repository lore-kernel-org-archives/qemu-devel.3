Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A842E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMb-00008P-Oh; Thu, 19 Dec 2024 23:11:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMR-0008Th-DM
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:35 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMP-0006Oz-DF
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:35 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7fd2ff40782so1278122a12.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667891; x=1735272691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z99TKxTEO+476nesx2pjqXvWwDVBvcXM5vBpRSH/Ths=;
 b=YHTvwHIk49WuFrORr5yw5HK0/QCnWVo9Z/DV74BdwQdutqOro9R5Z0Zu/zaXE61g9Z
 mDQtRnzTTQgCJjK45lrersxxoFSGDZul12WjyqKZB2DySCPejev0CvE5QHw7mj3YldcU
 CzhxO3lqSclh3zGhmL4cgUGgj81hEuVuOJ+5YDW8iH9LsvOJm4Mx6zjVirQs1ztCMH8E
 frqJWdDftcpu7jfOi4DU/TJD9gkO/vj5hd6GHrWeirEs/XsSvRpOBOM/wMxNPXopB2Ag
 cP0LfV4oNiipxncNoV9eyCWI9qY9NdRmJ+6GkPu3bQJ0ayImvjaNAcUgjCdZ24U33Z6R
 WYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667891; x=1735272691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z99TKxTEO+476nesx2pjqXvWwDVBvcXM5vBpRSH/Ths=;
 b=JKOcuq2Csx7AU81DfPZaTpu1vrnYAEBTpyAci0PhUWcEqebI1/kirlStKrnJI+BUu8
 O/doQ398L4TAfPisN8a7p1Kd4njPEDS1AZP91bCChU0VYYGZsrjVpGrZ+kgMaWzyraIW
 Wa7ruU3g38MHM8eAScQhsieTrpYfflPX6T6jhas8nmnWZsuBE+ASCyrUEsVTI+zsDr+q
 VROH5NhwoN+mSL1u8LwkcmAaa+ucu0yvAjpbc3UxwfNIJ+duThVsyQL5EFhQfGKXrKOo
 zLQ3344+gnlRUA+IRruvw7v/qvFriPQwROWVaHKKKLh4+7lq0v2pUllneS8UxmvOn7CP
 p96A==
X-Gm-Message-State: AOJu0YwltoGcqC6n9eKRd0+KZJmveL0uhR+iLznDgo25rvxlgJQH/N8q
 /X4h+Cp0g7hjVY8jCr6+0LAiAeuHFuS493T3isEEXEyFVRpaI91+r7iT5l+uc8ku9xWlYnSXk9S
 5
X-Gm-Gg: ASbGnctYKbvk/miU7XlYmnxbH/MC9sumMHyV9jlqRGGtvV4uZIJh1OeXh9jFM+kajTh
 oy4Owq47gyR+No3f9pal7oFKKlp1XQZOCyS2XaKbd83i3E8T5z/gJ5LaDRrN6l5fxAsEnbR7OOR
 qKVWMNLvgbCn05jKitJiH2pA1yj/k0cmgNC/qIl2iVjBsUYHuxNcYZhIgw/F1TSXJPeCublSpdm
 L6LiZU8/NWFyBmLHnOcAAYNVXQ5C5RmDuZfkV6lHxKa3Cg0KOjubt0tjQ7uLgM=
X-Google-Smtp-Source: AGHT+IH5HbTnsoPsvkbu0Z/cCRPmWlx0QWpa9AQXTR5X0stO5En8W1J6fFF4tTmTnyMl4xnsKl5pkQ==
X-Received: by 2002:a17:90b:2c84:b0:2ee:d797:40a4 with SMTP id
 98e67ed59e1d1-2f452dfccacmr2654171a91.8.1734667891145; 
 Thu, 19 Dec 2024 20:11:31 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 35/51] tcg/optimize: Fix sign mask in fold_negsetcond
Date: Thu, 19 Dec 2024 20:10:47 -0800
Message-ID: <20241220041104.53105-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

The sign mask is about repetitions, a la clrsb64(), so the lsb
itself can never be a repetition.  Thus ~1 not -1 is correct.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 5bfcb22a0e..63f80efeec 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2403,8 +2403,8 @@ static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
         fold_setcond_tst_pow2(ctx, op, true);
     }
 
-    /* Value is {0,-1} so all bits are repetitions of the sign. */
-    return fold_masks_s(ctx, op, -1);
+    /* Value is {0,-1} so all bits above lsb are repetitions of the lsb. */
+    return fold_masks_s(ctx, op, ~1);
 }
 
 static bool fold_setcond2(OptContext *ctx, TCGOp *op)
-- 
2.43.0


