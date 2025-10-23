Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23973CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwjY-0004lc-HP; Thu, 23 Oct 2025 10:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjX-0004kq-7R
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:07 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjV-0005Yh-LN
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:07 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4711f3c386eso7068755e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761231364; x=1761836164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Uir+DCzIAMR+d974t4+bUz1BzOrdumPLHshzxJg6y18=;
 b=omHNIL5jwWoKP2Yy6fmPHi+2t1bMg1aHfqaZyxz/h8pOXIGM50OyuWtZcnTznSy8Cq
 den9zjIzc52DT184cI4HsORGQ9wTIkuuGLO8JEGqJDXlxDov6vAalfCHN2WORO5Nkblv
 L4jE2V0MppxeJqJy91eeSl95nWBmwzfLyTQKdKDzFvcakimDFLEkzQjoSAT3h65jFT8W
 kkUiAwnF0ypXAC0zRQTcqEuO+TSj81zQLTmQZgyMCVZouNQ/F5VWIf3yS9SVMkY/RdE3
 gsaveM3vBXqFf9fvF9slOs9FSrBnA5JQ2PeootN1dbRiiKUdgRwid93wsytL721mLmec
 bepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761231364; x=1761836164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uir+DCzIAMR+d974t4+bUz1BzOrdumPLHshzxJg6y18=;
 b=dKqT6sZ/KsqC+zoFw6pK7u3+kHw+qSd5O3fAHOdCiBwCb7uRGDf93piJ+bDa2xpFO7
 Tnwoo0sauYuwhqgkZ0Tlg/cemLNk18/kR/wa984lvUOi+kZJASKDNsF9f9v1Ghshbkf9
 Dw6AMK9mcIbh9ltc9wvP8hQ1CA9+AwtPqyH1o6x4JY+2TVsoSyYzeYRwsXwaya4nqkwu
 Uq4IR5D0Zifp2WONrEPz4ODb9xM8U5D6yRpjWhsCTyTnB8A0axmZinq8vivw0ZxRSlnD
 477iH6Jh2pdPI8I9CYBzfSX8mtgrRVm+hKzWYcFTWnelcPhXRoJhFgl/w6/FEJEZlnmg
 aYUQ==
X-Gm-Message-State: AOJu0YzsjryYxXWCH9ctEFEiJHQIQsxKuKL3LeiZ7yHqtGvTVP8wVe4U
 FKTivarmePIwznGcoQBdUNhhSAIhywzBNZ29zvrnNexF577aDX7dnFzfiAExEDFiNoXveBrfQnA
 +lrSA
X-Gm-Gg: ASbGncvTC32VCkac19aEa4KHl/KXCjtf64Wnp4/Y0j6GW1VNj1kis8GYeAQAun/dI2j
 fEGp+Tdjyc0EU0renK2NicAVZeOqa7XYZ/b2KWjuQ3ffyDPNfvvmmFXgOElo+19jO9ZBfUD+CCf
 mQ7MviXh9lnyrTMxXXEDEKR6NBJeUsIHEebIBsvyEhQBro9gQ69onysIEpam+oRMk83GCxnCIgR
 c+K+ehthdoksStIP+t++Jh97VrkDFqxBUSvZtJvGWsg6v6MSqCdpivC1JChce0D+40sTw0XCuGX
 M8TRgva8LweyBCLYonbtoPXPRDX1vgDwzBMMRa+TKKE4/UmaBW92HHwyo1/15vKWRbqbYbbvoKx
 +AJ57Xp/pw5RpL+Ij/yZ40q3Flz8R6SUUP7cX1q9zmaOcj+UNuJrAtPWzQAD0oS7WdGGGSV+zGu
 KXJMPNQWb7frgBBGiV
X-Google-Smtp-Source: AGHT+IGFH9fqQoz5JcUH9ZqWVsIxK2xPgUeyiXkZk/iYHaU8qxWV//fmaDrJ3pjKff8VfgAipIU3Eg==
X-Received: by 2002:a05:600c:3548:b0:471:131f:85aa with SMTP id
 5b1f17b1804b1-471178a74a2mr148248165e9.13.1761231363677; 
 Thu, 23 Oct 2025 07:56:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898acc63sm4398465f8f.27.2025.10.23.07.56.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 07:56:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/16] target/arm: Use el local indexing mair_el
Date: Thu, 23 Oct 2025 15:55:45 +0100
Message-ID: <20251023145554.2062752-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023145554.2062752-1-peter.maydell@linaro.org>
References: <20251023145554.2062752-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

We already have regime_el() computed to a local.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251014195017.421681-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 54c45fc9feb..5fcf1042726 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2319,7 +2319,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
 
         /* Index into MAIR registers for cache attributes */
         attrindx = extract32(attrs, 2, 3);
-        mair = env->cp15.mair_el[regime_el(mmu_idx)];
+        mair = env->cp15.mair_el[el];
         result->cacheattrs.is_s2_format = false;
         result->cacheattrs.attrs = extract64(mair, attrindx * 8, 8);
 
-- 
2.43.0


