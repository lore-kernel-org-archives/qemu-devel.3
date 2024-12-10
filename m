Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC2FE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL262-0004FM-PS; Tue, 10 Dec 2024 10:24:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL261-0004Em-3C
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:21 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL25z-0008Jo-M3
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:20 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3eb441c2f28so648719b6e.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844258; x=1734449058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DUjGCZ5mCdzrBbJa2b2l0l6Tf6jf+A6xYUuc6RIjhKk=;
 b=fCyD/EoRR7L97EzEY0B47sZyNJAyxqFubaGDa0uog7Ji7ON9cFtPPEf/R3uZsdbiBu
 OvvF192hGh/coOS1dekPtR4Bsaqr+XriQCjU2qbv5RxiPe4eF89guAvjL7qGdKeTVTg1
 ooSeOMbX23gl3ReTpPUaJkzd8WxTzH1VfwpREzwEcYjimCuU5Z1P54Gu/sbY6Wka+gao
 /F8XJuSfEuaJAZjTDHLRD0BYVmt/Pdu1vinYWU2ZBh4Q6AaNSwfUxjt456enCb8ZqbIP
 6aMqNirgz3cD+x7WZeJ6TcT8a7dHXs7zvnmxU/ZzVAbeln9Yo44VztRSYMaKxzs8YrMD
 3pUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844258; x=1734449058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DUjGCZ5mCdzrBbJa2b2l0l6Tf6jf+A6xYUuc6RIjhKk=;
 b=LfKz6FIJCxpaCwLV/ZezPn3JFc4gJg7KEERwEC206eC3RvO1Rhho7Eb6mahQLNBOfB
 lS+Vb6k04Ht998IErzvBmHA1Vdg/dGJugyhwfUbi2zalvdJyHH0c4RRsOezh56gjKYdx
 e1Ka8KNXvEtSCs8vx4ICmhVpab92U85hwo7AMxK1tDQUg4ZspKmcr2RHv7kp+awOI8oo
 CnJ3ZSD09duGCymDe72uvFbuBeNX8q4FlYqPyOpYRAfKpE3YFkMr0dTquIeMsQTwhcRb
 d2KRFFpBgEywSvgp71PpXVcKgYOvcMD3Y96BG1v2MkFTocNxmZFpKME7yflRrYQP4ykZ
 68wQ==
X-Gm-Message-State: AOJu0YxOQi2rLfjgx/czPZj3Gn420ub5ZUB/oNKoYvvESg1LFTT1EGd7
 AkckzWRusVXDbEPinXK6BaoSUTjVnk8HQ0QC6iTdmdTQG6OxQvwrCJETnbtK1+pw+lNk5cpGFaI
 ilXAb+pJW
X-Gm-Gg: ASbGncv+3Lu/osI0wcFwXAoYVjRJIbIrK13agL3WllQCG6CEVocswGFk7z3zRwdHdTM
 f2Z+m8WNGhJaCc2xfcPMzrAphv4mp4KXp4LyIrj9lMHvrun0eGS9XsCpcnf+dklC5xzPOcz8wVP
 lJKsjGmpqVep6xuQQwMSaBDlYouR8B3EiWrKd2hkCGC1VKZrE2G0VUfuEpmF8GszLN9wM3Lqxil
 YWAx4qobs4v8Qam7lWbBTwkF52hviXTI28gJtWbzpqLaje8TcP/YVU61Im0Fw==
X-Google-Smtp-Source: AGHT+IHOqkyj/eN+a+/+zNq18fc8vV9BbZdDZdhMK62nyt+/N3dlCcRxjIPe3VJafsyWwk7w3geNqg==
X-Received: by 2002:a05:6808:3b4:b0:3eb:7973:111a with SMTP id
 5614622812f47-3eb797311efmr754187b6e.40.1733844258478; 
 Tue, 10 Dec 2024 07:24:18 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/46] tcg/optimize: Use fold_masks_zs in fold_bswap
Date: Tue, 10 Dec 2024 09:23:23 -0600
Message-ID: <20241210152401.1823648-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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
 tcg/optimize.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 285407ce05..3363ebd48c 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1082,7 +1082,6 @@ static bool fold_masks_zsa(OptContext *ctx, TCGOp *op, uint64_t z_mask,
     return true;
 }
 
-__attribute__((unused))
 static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
                           uint64_t z_mask, uint64_t s_mask)
 {
@@ -1528,10 +1527,8 @@ static bool fold_bswap(OptContext *ctx, TCGOp *op)
         s_mask = 0;
         break;
     }
-    ctx->z_mask = z_mask;
-    ctx->s_mask = s_mask;
 
-    return fold_masks(ctx, op);
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_call(OptContext *ctx, TCGOp *op)
-- 
2.43.0


