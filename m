Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0FFD4A5EE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgagL-00057I-CW; Thu, 15 Jan 2026 22:39:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgag4-00050J-Vg
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:39:14 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgag3-0008LQ-KP
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:39:12 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a2ea96930cso10045315ad.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534750; x=1769139550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q7SIDQmcUGJxe8HENT1y7sz0lq6rggxli56KTnwm55A=;
 b=QY4Gr3efSzKLqnb/MA53wGDgy89VXzTFbGd9BF3W8xpu+SvE3dFotM6C3NAM0lfMr2
 DyGktjdH1mmk4zCq07lIycGfgbdbv2by/mz1ZZT8PUr4ftLxre1WBCxFmmUwyWMU8QfR
 ioCsz3Evy8V3CmgTzgPTP/Z8EFBDlJT2URuDF0JJk3x3LiMVkIrF9HasNq6Rl29iig9i
 sW1QFpM8C2HIZ3Hh+KVJU4RPo9J9osmBViAgI8tsVVrh2boJuKgt18EHYfDD9mzisA44
 B80YXlCLNcMQPWzQb2arxdNZSQb8yC59/gWL0rnWXiQ8fYd1LdpVXzBffKFUutWzRuVk
 QedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534750; x=1769139550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q7SIDQmcUGJxe8HENT1y7sz0lq6rggxli56KTnwm55A=;
 b=sXlohSrHMIVU6UPlsrT/DboD2LIcCuZHDZY6YLmYI0yY2GPOaEEF8lxGdjl1H1dJgd
 2XnNhoHyLWQSSnezbpyDExv2DlU3Abtc7sSP3K2C4VVQihCycafcJvcA7vV7xaC6XAyl
 qtLvNC5n+rsoe3sztRFx5f/X2IV8mCW9NPlKBLnOy0Xf0u1Fo1nUksoXLu9+ueT+VSvG
 Ta25R2PLrGrtOdlkfDMIIC5XvnQCT6HFtHDbjj7TPsvPJRYdBp1e126GbobmJC8xgfFO
 uVsSsAr4zSZsDelxFjMPrHBpHDSLmht2hBzzc+sLhUU/hBI9VHX/zMZbgUMl8cE2PRT3
 qNRQ==
X-Gm-Message-State: AOJu0YyGTgH8UzUBy9pnDzPfJ2r4JsS/dc4SYPaymlAI+8D2KsRqTjVb
 w/E3P6aL/1Jjf5wLp8K67US9WN4quGllQ3lsXD3nH2L46GW5Rq2s8SwenPmbo5PAyQ4uCLb5rJ9
 NRsD3XPx8vg==
X-Gm-Gg: AY/fxX4qLTKFVMrKmF52aiuxigUEwoSoeeYwtOFDk/4DO0EaX33PRzYLraNrOVvT0sw
 LcMgSCPZXJc3tWiwsV18BQ0E5Kf2+TAVws9K6Zcozjx8zaKRBGYwfeXz3QQe+KNAiuwYDrl2YnV
 jR04a8ImVoyOcEi7i1yqQrLWG9XIhAZc0uRsub57rvNDa7vCyekPJvF3YYhGVuJBy3jHOMP9Y7t
 2DKJ6HgrZRsyt1tFVI3Zh7uOIH/Viu4wb3/K/S3ciauxNqRKNxl/UuN2z//wyLYj/UhjoRCz+g1
 ok86B0H7Ze2bRLvvc4s3Ea1RNTz1h5eDJZuAv0pFslspdrvXrX50qxpsA4CTV4HCVu39fuQDOZR
 4AZA//rSaB9+PiZbx9X6V6KKU6jiQINahD0BEJBklGe//9NG2R5FAYpP7UY5YgsuMeaFiIBU+h3
 6MTDILPhg2dfzEr5cKQg==
X-Received: by 2002:a17:903:1a0f:b0:2a0:b467:a7cf with SMTP id
 d9443c01a7336-2a71740af3fmr14504505ad.0.1768534750083; 
 Thu, 15 Jan 2026 19:39:10 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ca9d5sm6527975ad.25.2026.01.15.19.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:39:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 45/58] accel/tcg: Drop CONFIG_ATOMIC64 test from
 translator.c
Date: Fri, 16 Jan 2026 14:32:51 +1100
Message-ID: <20260116033305.51162-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translator.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 034f2f359e..f3eddcbb2e 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -352,15 +352,13 @@ static bool translator_ld(CPUArchState *env, DisasContextBase *db,
             return true;
         }
         break;
-#ifdef CONFIG_ATOMIC64
     case 8:
         if (QEMU_IS_ALIGNED(pc, 8)) {
-            uint64_t t = qatomic_read__nocheck((uint64_t *)host);
+            uint64_t t = qatomic_read((uint64_t *)host);
             stq_he_p(dest, t);
             return true;
         }
         break;
-#endif
     }
     /* Unaligned or partial read from the second page is not atomic. */
     memcpy(dest, host, len);
-- 
2.43.0


