Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC4CE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBAz-0004L2-Ls; Tue, 24 Dec 2024 15:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBAH-00033V-Bd
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:06:02 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBAF-0002fc-W8
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:06:01 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21654fdd5daso55266095ad.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070759; x=1735675559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KrkS8wtDk9FFk+ALiPIq/W5dXJBRwDqMCYe2mtixhBA=;
 b=t/9xYq5xwkghOjepIImjrfYpyRW5mIwDzW9VzfucK6X85BXlqV07sXtO++55BcItgr
 aGESLnYES/BazxV2DkS3rCJJrqdeUbNG3XX3gcV3nna8BzOvPzvtBhcphek67OshKAWt
 /3Q0rCwlO39rJsZ4gkWgOrUZ1hAU6dgyIrRvQJ0dF+4r2amKRdgweehM5LsGYa5b8+CM
 hMRNXFPMr/NrT29wbnFmtd4BfFKjmZ+6N3PjglviLKSSjlFMLmkAjKCXDN1IMTCy/6lm
 TKtA+pbEEUU+E7mwpsR+wkNBTKB/jun1O5GhI+xq+NEMO4elixqQOmUNjjcQLmEQLaXB
 oOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070759; x=1735675559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KrkS8wtDk9FFk+ALiPIq/W5dXJBRwDqMCYe2mtixhBA=;
 b=pXSlF1hlIGeZxX3gQ8Pbi3/jB5BSk7f+rinSVnRjMwx8FdgQatiJeqP23CJ3TSwvDV
 0QhB028rQvsm6tO0bjifx52acJ72AiAEzjjaYmaPF9cGpWLjjHM4ZOrfiVnYJktzIydu
 25zee0+143wjFn8/e0QXfH3/X94Qxphqz0xb6YZG9aYo7t1GQdQj+vr+nOZZpT5xJCiE
 bCDiTFEOMzu2ZyOA3nk1VCzEcFlsA+/5rrFF2ocbx+J/yyilfFDtheVl3x042G/pMwEx
 i8aklLwMv5nx58+XiIY7OjhrB6wzN1uSH0pCpwcjpDQ8qGsNqHY0fGu07I0dTHL4Cjjt
 tIag==
X-Gm-Message-State: AOJu0Yy0YYgf1nFgsHzukBB1wpHJ62RnJlhTii8/D/xC5ztBSP5lKeRl
 aZdNTTz/Zrf7eVEOxDK3lw5Xpr46wDzCaOSL8ryidSUQftSuWgLwOFZQLMQm4OFzxMxdo304zKe
 MPV0=
X-Gm-Gg: ASbGnct56ucb8/Nssz0xs74t5nX2loOcHAioN1OpiYhdVgpfxiz+6swlJao5U+XreCW
 7skRkoBp7LGFBt0Y1WKVEO5BD8v/A8gPykqywVYmgLsjUJyXxChFpRynEUhXfIn9vPU0leDceYU
 0XKuWA51yd0xBxQxQ6rkP/rGTPyJQRDzsmiim6nq5sZGA5dq9E6pDdIymRiuYhq4zYLQMNMk5GO
 WcpGud/gWrObtSlKALCVUWx+gLV1AgDpLChn/s4hKtuftbjiq3oAAjEUUMRRRz40qUjGX0CGQDQ
 dWbzdOrFjudeJ4TlotOhiu11iQ==
X-Google-Smtp-Source: AGHT+IGG9eWFq7JIjBraoV52uohaYBu3Z6SHgTkBXwPV4eZqafRBFrRqOi5b+pinK4xHTKae2RLILA==
X-Received: by 2002:a05:6a20:9144:b0:1e0:d169:ee4b with SMTP id
 adf61e73a8af0-1e5e045d6c5mr28075812637.12.1735070758676; 
 Tue, 24 Dec 2024 12:05:58 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 39/72] tcg/optimize: Use fold_masks_z in fold_setcond2
Date: Tue, 24 Dec 2024 12:04:48 -0800
Message-ID: <20241224200521.310066-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
 tcg/optimize.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 7e909791e1..c61d0eae4e 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2468,8 +2468,7 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
         return fold_setcond(ctx, op);
     }
 
-    ctx->z_mask = 1;
-    return false;
+    return fold_masks_z(ctx, op, 1);
 
  do_setcond_const:
     return tcg_opt_gen_movi(ctx, op, op->args[0], i);
-- 
2.43.0


