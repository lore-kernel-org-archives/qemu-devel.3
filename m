Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB36CE7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtwT-0001J2-1H; Sun, 15 Dec 2024 14:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwN-0001HW-2F
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:08 -0500
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwF-00012G-4K
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:01 -0500
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-29e91e58584so1787025fac.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289558; x=1734894358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j18ed1KLeCdcC88rHm7RU/Cx4ZNx0nJUwplEJrZ/anY=;
 b=f/Mb444+A9viJfRBp+jcDpMKVKHjU7adk3iwVKsOZfHz1NHbVVXBfRNRJg4aVuigsc
 1T6UrMMZzyc1U/qtuXKaj7jtQeeQAfF4MDX+sRsQogUEnemQSZUISGIO1Y6WMsCRUYN5
 YqaxRNYlXoRxjXPmf/QiGoxL2KBqoQT06BrGSqIQXaua1N5nWYwp0n3IpFzwm2e8mBmL
 +KbBvYcqEKvqkChZCh6NmH7g6OydiF4MEnOto4HsmdW25JB3MwLiE8H4HbleE8ge6FTD
 +NvocIPrXaApobSo4kv7jJEYW/Ne2OyH1sxQgqjV9RZUXLhV8HPgkEkX9XFSY4caoMAg
 NXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289558; x=1734894358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j18ed1KLeCdcC88rHm7RU/Cx4ZNx0nJUwplEJrZ/anY=;
 b=VhHZHp7YL3CFWawcCVdfc8rOTJTIEMQR5ylPG7CnBp445uQEU0Na39b0wmxxl1+NDg
 M1u85Xn2A+BcqzKJyVfQLEtKTtF3QWC5g+1auHLhLyF6px7CWSxI5lkD440trtl72MM0
 z+3oi3hvr+EI/mzZnMwszboLkb0rzvh+ATKd2RVw2M3G6XhBf34VKv1KTm6K7b0DPgWv
 kbTH5O0D25ZcDGPupDIMV2YL/mWKFUwofDXw8ITCNZG8iJjeJ8ZEGIc5pzciyhvHLnqW
 BFJR3KPVJjowjJ4zB+sLXO1Z3cipTNOn6ukDdM2nNzI7jMkjpr4VXk3obnK5tsXPoiaL
 zAtw==
X-Gm-Message-State: AOJu0YxStxg2wNLUuVPOESy1cPJx6H53PLRJqePlpx+tZt0J/ibtzfGd
 99A3R4q2z5ShA0cA3M+vScIQlR/uqTOs7vYa322+L9HLcx7p7SZCouizyPaHuOAHwrGvx2tE70N
 CtvsBDOtf
X-Gm-Gg: ASbGnct6kWq1hN+sD1gcMK1dmlva4BxaFbssSl0exfB12v92HCt6/lHx3TZn3CtTYM8
 BCdMUr5THPE3CAux1IIKVC37Cwjq7JPDpuaLJWr/lXBZXaIkbBdMLQQGo6D+i7lNiTYm+BG0NDh
 EEqSgXHQujeZN0peyQnWbHMfwLuFS10TIxa66wpEt2fiiplfKlPxQDkUmKyxToj2yoxEnmWwUEo
 6SalK03qvTmhXtv113Ys3yTxyQl1u0a/mCfh2J+I9mJOpFDmMISs/C4HfKQXj9fKcFYCTrDTVos
 bvHH3K+EklsA9avN2HzM3jLDyPKN/fnLpLwSkG/CmGw=
X-Google-Smtp-Source: AGHT+IEnu1fhsoN+hB8uYOK3uHOOGAgUoSsBBxW+0ImjhxJjcTeorL4fpLa0joUq1FDtEuVmN6NoOA==
X-Received: by 2002:a05:6870:e0d1:b0:29e:27b6:bea5 with SMTP id
 586e51a60fabf-2a3ac7ce43fmr5789476fac.25.1734289557812; 
 Sun, 15 Dec 2024 11:05:57 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:05:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 13/67] hw/adc: Constify all Property
Date: Sun, 15 Dec 2024 13:04:39 -0600
Message-ID: <20241215190533.3222854-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/adc/aspeed_adc.c  | 2 +-
 hw/adc/npcm7xx_adc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/adc/aspeed_adc.c b/hw/adc/aspeed_adc.c
index 598f2bdf48..f94c6f2be3 100644
--- a/hw/adc/aspeed_adc.c
+++ b/hw/adc/aspeed_adc.c
@@ -286,7 +286,7 @@ static const VMStateDescription vmstate_aspeed_adc_engine = {
     }
 };
 
-static Property aspeed_adc_engine_properties[] = {
+static const Property aspeed_adc_engine_properties[] = {
     DEFINE_PROP_UINT32("engine-id", AspeedADCEngineState, engine_id, 0),
     DEFINE_PROP_UINT32("nr-channels", AspeedADCEngineState, nr_channels, 0),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/adc/npcm7xx_adc.c b/hw/adc/npcm7xx_adc.c
index de8469dae4..1781ff4c0b 100644
--- a/hw/adc/npcm7xx_adc.c
+++ b/hw/adc/npcm7xx_adc.c
@@ -267,7 +267,7 @@ static const VMStateDescription vmstate_npcm7xx_adc = {
     },
 };
 
-static Property npcm7xx_timer_properties[] = {
+static const Property npcm7xx_timer_properties[] = {
     DEFINE_PROP_UINT32("iref", NPCM7xxADCState, iref, NPCM7XX_ADC_DEFAULT_IREF),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.43.0


