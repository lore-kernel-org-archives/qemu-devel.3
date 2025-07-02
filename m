Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D91C8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwUj-0005CW-U5; Wed, 02 Jul 2025 08:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwUF-000513-EP
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:22:57 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwTt-0007E2-5s
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:22:50 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-611b246727cso2197518eaf.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751458944; x=1752063744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7yKEiHZ9hbY/jVbCg1JFWOkif/DEikx+UVyK1VqdZTU=;
 b=aKUumR19qpBK6829uTJtEioqyRF6S0xJArFsC/hTaKxkvK5s1MiLZRshFNLGf2iMug
 uHVq4ZBHtaj/dqfJQJNhc3xMwirUGF32vKIWWdaNV0u41Nt8rMH3/u7H9nRUZlJ+twHG
 ev98wpAtekD1qsVTAneZAy/Cj9WUcWb4pVkVpxMtaPuZbNjLwYk+JPMri7WcyEYJc/gP
 tjjoljxtQYm4a9anHZuf3xzZLt4pAzlDmF2EgLWKtMVMm4wDtWH/sAEz7qTIZhQZQZ83
 i2dP10dn0Uy+9CVtDsGMjI9/3fkAnroMp/GKxUP6IHPUecRGKLbz7YdazqdM/SVaaLk7
 jmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751458944; x=1752063744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7yKEiHZ9hbY/jVbCg1JFWOkif/DEikx+UVyK1VqdZTU=;
 b=irbl/JtRuChKHqucQSXXvr8btSGS9WE0otwJ0HPOZYv9Psa8luob1w6FT/zzOsKwo8
 AlljukmjfaCdbL0wKOLNXuqFmRhGUVVbP/VgdETcZ5lhGqW7dx6XaWtlhiBRr6T8zpZZ
 e4m3piLIRMutn6eEOF+u7X8QZl+FdlP2iu1hZ6tzl59kLBiCziGasCaWAxXDC8zZnCne
 FsstJ05lAh05Uxok7xAwmjYwj+4CzWS/H9B14upvxKv0yovvKaCRsDNuvkhX+RtD2yT/
 4vNdEWHDBvKjot9SyoiVWFfBsUve4uoNq2XnM3IUnfvZRzrDhbi1bJxgUvpx14hnheOc
 XP5Q==
X-Gm-Message-State: AOJu0Yxq6cSwl9ci52qONVLbLEmrX1qnq0T9PNVb4etkDm0ds8ClStqM
 2kfkUQk1LKNEBprlzWr1UrUM2na7o9s3gDp0HNmvfERtbgMEz/VVoQBvm5vTDN18LX4kG7382SY
 x48W5Sx0=
X-Gm-Gg: ASbGncs6t57Jf1iY9sSXgefC8mYviB25JpFKlMRPzZ/oC7mNlHxFxzR99OHYWLL6xNU
 aLCHkOUlkt6efrfEOO3lUI75Cve1wyYtFbjrzoc6S9f3YBp6omlkmSIwbiJpkMtocyNp5PD2zDG
 AT7lOm85u+e31OgMlnxmqNjzhxw7NQhWLp4M1iPUjDxelRO2sn1tfLWZ5XeWSxkQ+YUUTzeElyX
 BMADuQKvzYFj7AbE/cD3fn1UJfB3nUuza0vI6T7UOQ5zmBjO8ybTDxR+ATwFFPEPs6hc0hNP0kh
 ycn0jqxG2RzovDlmDcvJd+y27lSJTDRrHrfxQjNxgajNU6vk3FGsgrdnA5Lgm0e1WvoTdQ==
X-Google-Smtp-Source: AGHT+IGzFuZ7//7IsC5kS8lxo/4KS48URGkcWItgc05ASXlWZc8b+dsrb2s8xC5iFsu4xstngwOjtQ==
X-Received: by 2002:a05:6870:818a:b0:2ef:ac47:798a with SMTP id
 586e51a60fabf-2f5b0aa9a6amr2334709fac.9.1751458944129; 
 Wed, 02 Jul 2025 05:22:24 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1bd3sm3785013fac.28.2025.07.02.05.22.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:22:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org,
	qemu-stable@nongnu.org
Subject: [PATCH v3 07/10] target/arm: Fix PSEL size operands to
 tcg_gen_gvec_ands
Date: Wed,  2 Jul 2025 06:22:10 -0600
Message-ID: <20250702122213.758588-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702122213.758588-1-richard.henderson@linaro.org>
References: <20250702122213.758588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Gvec only operates on size 8 and multiples of 16.
Predicates may be any multiple of 2.
Round up the size using the appropriate function.

Cc: qemu-stable@nongnu.org
Fixes: 598ab0b24c0 ("target/arm: Implement PSEL")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index a0de5b488d..8403034a0e 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7291,6 +7291,7 @@ static bool trans_PSEL(DisasContext *s, arg_psel *a)
     tcg_gen_neg_i64(tmp, tmp);
 
     /* Apply to either copy the source, or write zeros. */
+    pl = size_for_gvec(pl);
     tcg_gen_gvec_ands(MO_64, pred_full_reg_offset(s, a->pd),
                       pred_full_reg_offset(s, a->pn), tmp, pl, pl);
     return true;
-- 
2.43.0


