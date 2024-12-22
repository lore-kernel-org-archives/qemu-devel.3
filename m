Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF70E7718E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOlu-0002vL-IK; Sun, 22 Dec 2024 11:25:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlN-0002aq-Dz
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:07 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlK-0002zi-Ts
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:05 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-216395e151bso22288995ad.0
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884701; x=1735489501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9yQbUQ8bYZFaAZlXpe/VATGLlMOZ864dh+CLTc76xc8=;
 b=MesmPP913zu/CD8VjdCBKRH20knttS4wliGX9ZhMkcnmmWXeoP0OSNiK2XWRnyMo4e
 heGQtrqd1RDzHboI1pl5spv6v7RsEbMjFtOlSpB9QBUNP+eOtwmvyN0J9spLjnMIZB57
 2ws4AaaK0S8nJscAs/A0va/aWqhEzj2oN5EUW+ppI9rtYGt7oWZ1kaNFQtMxuAUEsWUF
 gh3kvSRNGzcciR7qenY2HmXuDisMNKqSfvGzhpXwKPGGKDYEXcXVjamLW74rLR0vjaEZ
 g9Hug3Ka9T5I87rg4E48XUtC3DnEa9osXmpLswhGE1voYExKDmtdOOyEjxHvtJuB7L5E
 uZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884701; x=1735489501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9yQbUQ8bYZFaAZlXpe/VATGLlMOZ864dh+CLTc76xc8=;
 b=SYxaeWr3wORmg8QOwIZoPyRBuxT3+5FpoPI+WMiZ4cvjze5CHOMO6p8LFfFLRo9A0v
 IcFu6a1pOC0plU6wQGkzYSynAmVH8T+p5xV/cZL/Gx4mWmpHpIIEkDW2le3cErdAa0lK
 XH0AKfQyd8c9VhXi08Wo1AMEN3AhaCivjsLeP+Dtc+ECamgRvHKft5T+Sh+CirIzicD+
 eIQhK7apKBYHfhMyioSmacj0ACTGufOqAZ1v7k9ecw78Lw6Y0UFoZ5XvU21HrcUfUHCi
 Lbs7pZv+ar0fibZsxMsOULWiV0te3g+MN8gf7aj3TLM8aH9t99bTHKs6zXU2P8LT5v7j
 LnWw==
X-Gm-Message-State: AOJu0Yw8zOJYT6ranZ5PkLaknHl3Q5xzJznvwdbMXcyXFc8fVvTf1qtx
 hO72WtTOTb5mCf3/oou1gcIDOuXy+xbnI7d/FmrNUMBDOvxEU9opCoILzV6cRCXTvhDVhXokiOH
 oNOY=
X-Gm-Gg: ASbGncuB5KVhS2ODe0bL9Jgeu8SSNFnoq+uCsU4s5c3r+UgLLAUvXXJQCIjz26F/JMU
 u7JjHSOIpoGFftX4D2qSpON/p01RSx2SehirMfYkB+3JmsR6Fo2JJfjcd/elYTThcTCiw9ssOR5
 3lSiMP64lhPYlmk+l+AqhuCEo+NrvXfe+GROZI8YDvII40vcgCmTO4zAwk+xLLVHOg+dLymo1h3
 hVfrm8IzcAfZ3gjLK6gFmpX2CwpVipomjtceXB+PsG2X8vrHrjYUsgSWj5YIo4=
X-Google-Smtp-Source: AGHT+IG0yM5xEekAMP5a2FLMSdPW1XE1in4V5weSGM+scgpxRFOlnc+TtGIdAEi53FszAyVSaorCfQ==
X-Received: by 2002:a17:903:2cc:b0:215:6c5f:d142 with SMTP id
 d9443c01a7336-219e6d5997dmr147840015ad.20.1734884701028; 
 Sun, 22 Dec 2024 08:25:01 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:25:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 21/51] tcg/optimize: Use fold_masks_z in fold_extu
Date: Sun, 22 Dec 2024 08:24:16 -0800
Message-ID: <20241222162446.2415717-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
 tcg/optimize.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index ab8ce1de2a..bdf95d1924 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1834,11 +1834,11 @@ static bool fold_extu(OptContext *ctx, TCGOp *op)
         g_assert_not_reached();
     }
 
-    ctx->z_mask = z_mask;
     if (!type_change && fold_affected_mask(ctx, op, z_mask_old ^ z_mask)) {
         return true;
     }
-    return fold_masks(ctx, op);
+
+    return fold_masks_z(ctx, op, z_mask);
 }
 
 static bool fold_mb(OptContext *ctx, TCGOp *op)
-- 
2.43.0


