Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A38E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL271-0005Xo-6j; Tue, 10 Dec 2024 10:25:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26Z-0004dx-OM
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:55 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26Y-0008Pw-7Y
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:55 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3eb6b16f1a0so356690b6e.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844293; x=1734449093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e6j+z18e1ipmicFyrrHiUm6WC5c7fg1TYL8oxdMOA9s=;
 b=AnYT/NYUePJsC2Yvsl3MWfx0Zxn67HTHFydc7qujak6PCUDBzApH0snesptB3C1EQV
 87Fo09t8pfF+ItIAbOH9M+7HlUkkNJ4ouF2HaPprON0zzmWt8vg0U3Q9Ai7qGYoUDNjm
 gUYezcwG//tzgwAkFWziTnq+wStY90VkuVZUV1NOr0rnOsUYYQgn3xEk0kQoHMWbF9Jn
 ynmrQoNfK9W9weEJmrBM6TtOMA8u9P2Vzdr4Wg8d9TCEg8btYYA+zulKts1EH7DHW9im
 L8JYqsP7eLKveroTg56k8iFrRTBOvpEwlTs3pifDTcjoKtzpfP/fsWqhtV9PmPjOpQD5
 Uv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844293; x=1734449093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e6j+z18e1ipmicFyrrHiUm6WC5c7fg1TYL8oxdMOA9s=;
 b=DTHMXaEGIet9KkeLh+WmqKTxRTWTwCdhvpaPvyquQeWZCjSDqvj/IU4dPTjb65uOtG
 z78PuagODPQylrjVDbRZBjND8gidAwiTx3dkWvKgyNsYIhZKrvutH13/tHV1lOYwAzQX
 eC4ffyba6AEfM9UyaWxgEo8bmTIf3+EP2Q4U5UhdhWoIXWhN4td5kBZnKO/e4tuc0MNZ
 Avca3Hn3ylv2L8i7OiFH5uWCRvTYeH511FIH4Otp102SuBJgHST6EAfTWxwqIksazseK
 LjR1gQGCuAX5aMc7jd8BN+cwzCtvNBBE4qP0e/qIlQOB0luxA+GXu+hVfX2KHFqU5q7A
 w2vg==
X-Gm-Message-State: AOJu0YzcaWfcdvE/kvOlQdYJuEcUKGDl2VkT3x0I+IPqtchFzp0e5Kn+
 TkxStGVpzEmDy87pn+L/zN4Mjn9B3T5q5/WqsxbcZzk7RVkM8BQ6p4IgY/uOBpxuVXsJwV8SlOT
 vnzB8FqrX
X-Gm-Gg: ASbGncsQiHeQhic/XyRS7YKzbB/7VafM9KJ6gIIWRkQfgXAEnkSEgzos8CAM6bdZwif
 SprHvKRLY670woHD1h04ekBFwUjSMFV4rs6la1PZPI6N7h9/TDnvu2GaGwJpvpaw6lsyZRnJonR
 25aa08nnOIXyMSQl1/klR93L0SXXbLHwet93VIT/VM0PuvwgFOqLb6aSBND3nTdPTBIQaolKFYZ
 ZY2ZmYoics7DG0ztPkF0M8eMyvVevmSyEx0Fbkbva7dWpdbpcM/H08wB7FcrA==
X-Google-Smtp-Source: AGHT+IGC/qqpCbGyFuaO8d4u88IxmA1vgpKKo8jrzafFwZZIJF1m4Z8dr+IRbMpAvQRdsON+FzlQJg==
X-Received: by 2002:a05:6808:1589:b0:3eb:5d13:f688 with SMTP id
 5614622812f47-3eb66f0ac45mr2902915b6e.26.1733844293104; 
 Tue, 10 Dec 2024 07:24:53 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 36/46] tcg/optimize: Use fold_masks_zsa in fold_sextract
Date: Tue, 10 Dec 2024 09:23:51 -0600
Message-ID: <20241210152401.1823648-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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
 tcg/optimize.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index c99e6f79d2..551f96dfaa 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2488,7 +2488,7 @@ static bool fold_cmpsel_vec(OptContext *ctx, TCGOp *op)
 
 static bool fold_sextract(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask, s_mask, s_mask_old;
+    uint64_t z_mask, s_mask, s_mask_old, a_mask = -1;
     int pos = op->args[2];
     int len = op->args[3];
 
@@ -2502,18 +2502,16 @@ static bool fold_sextract(OptContext *ctx, TCGOp *op)
 
     z_mask = arg_info(op->args[1])->z_mask;
     z_mask = sextract64(z_mask, pos, len);
-    ctx->z_mask = z_mask;
 
     s_mask_old = arg_info(op->args[1])->s_mask;
     s_mask = sextract64(s_mask_old, pos, len);
     s_mask |= MAKE_64BIT_MASK(len, 64 - len);
-    ctx->s_mask = s_mask;
 
     if (pos == 0) {
-        ctx->a_mask = s_mask & ~s_mask_old;
+        a_mask = s_mask & ~s_mask_old;
     }
 
-    return fold_masks(ctx, op);
+    return fold_masks_zsa(ctx, op, z_mask, s_mask, a_mask);
 }
 
 static bool fold_shift(OptContext *ctx, TCGOp *op)
-- 
2.43.0


