Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5CACCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 19:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8l2f-0001dH-KN; Tue, 14 Oct 2025 15:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8l2W-0001a2-O5
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:50:34 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8l2S-0003Pu-8u
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:50:32 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7a16bd4d875so124655b3a.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 12:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760471425; x=1761076225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LZTPxisuBlozaf2cVitU7+jksAc4vzj+QrVyIeBLhAA=;
 b=rMJcjhNz/V9GHpxBqz0mUOKdIBrChROEocSlZR305kZHjZvWGRo/SqE3dCxxNzg+o6
 bfcul+wIyqNrweAZXIRvZ1tKQwo1h1jdgqSM0LBfG/W2AFWN9P9FSBBNwjzxXWRibEuf
 cDlc3iNSW2WhD0bO7zTkjfGvd4+PokRvBRAvZr03XfDkthrroVS/0ivFjc4ZL9iYFYHU
 jVnttCrPyytFUlPfY/v2RXpRe77CQiv3V+Hg8ktbrNpUKHZI8+Gkt/Olu0xsEmCVDe6R
 voQuxSlRonSo2ogen+eGnnmM7YvssVvlo4hDlpvxNqbhFBY/3tj1BaIQbk/w3g2/FhQg
 lqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760471425; x=1761076225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LZTPxisuBlozaf2cVitU7+jksAc4vzj+QrVyIeBLhAA=;
 b=OpMf5I6OtuyyiL/6+kgg0/jwHyVjAGEQVHa/P4WDFxnUunugWcQ36afPTLnOZH/7Rt
 pEnJTZUCkwF63PQ+Y1ckHhsCeNibN1MKlPoo4kjSa0dC4g52l6el1i0d0rO7beBB/OrB
 YHuvUscznztJ1H8r4omXFLl+kcsWfAZ28hgLZj5hfZU75tFKv6Xawfu3QiVyLdR03+eT
 ys5qsZUwHPp0b8EjNCFMJxdW7EselX6M+sxRsadnye9PB8DyyDh8v+oCjM/3qloRLu+7
 mPRdELPexm9GyQVG7YX8g8ieFzAIfL3QO5iQAfqWjkK1a6vFALkqd99g+Xr2oNH9SRZi
 FFpw==
X-Gm-Message-State: AOJu0YxjfHLIE+wJzp9cJkpMCsIjjvs2Nr4SagrloGQjv2569lSl0Vn8
 V4S4WRTBa61Z1z3167r3VYZJlxSgGmlEEh1FF+/p6kHV1maEcDDCjrPgAwghyeKY+QbtikPd+3V
 XQU5JWtA=
X-Gm-Gg: ASbGncuwaVlQ5FxqvZZHZl0W4uNtxLFVcTVd+BcXEPhMO8cfFxJiYuszpgbCUFqlcwP
 /K5uIh5M9wvtgXb78o7JzqFBdqRrpJBP10ufvQJ38i/1H1QeuqxJ7C0zXr7sPV5ZANsCr+AGraT
 Z+6z65r6MrvDY2ENHuEZDcSH5cEz3cA+Bt8S/X8lWMLyuQ8xO1QEd0wEpxEMG4Fw8nkWO9d/Qq0
 u9wVENqIzo1QjyP3XHvq44M8cwBT7YqF9BxJAS9LvwpFbjNxSVdpgMBsgmIldu1lUtDaYW03bcV
 35ztzTQMgY3X6bko1Tfi+KYcMmbytnzGG7RdqK2nOkA6WvLfvhJpeenvyYv+McGQdHgaezyTbLT
 LqVnaNbYXxibjS7U+FksbpKBUjozDrnSWGlIL3zs4SPHt0YHwF4U=
X-Google-Smtp-Source: AGHT+IH/xTYEyE3k6CYI52N0Lb6Dimhu1SAmlR0ypZYBqzgpQTln9z4yS1hidHRmrRCdUr+dpb31qg==
X-Received: by 2002:a05:6a20:4305:b0:324:6e84:d16e with SMTP id
 adf61e73a8af0-32da83e6479mr32108514637.43.1760471424962; 
 Tue, 14 Oct 2025 12:50:24 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992b63a03dsm15918727b3a.19.2025.10.14.12.50.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 12:50:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 6/7] target/arm: Honor param.aie in get_phys_addr_lpae
Date: Tue, 14 Oct 2025 12:50:16 -0700
Message-ID: <20251014195017.421681-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014195017.421681-1-richard.henderson@linaro.org>
References: <20251014195017.421681-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 5fcf104272..23f6616811 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2319,7 +2319,9 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
 
         /* Index into MAIR registers for cache attributes */
         attrindx = extract32(attrs, 2, 3);
-        mair = env->cp15.mair_el[el];
+        mair = (param.aie && extract64(attrs, 59, 1)
+                ? env->cp15.mair2_el[el]
+                : env->cp15.mair_el[el]);
         result->cacheattrs.is_s2_format = false;
         result->cacheattrs.attrs = extract64(mair, attrindx * 8, 8);
 
-- 
2.43.0


