Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263FAE77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMBNa-0007hU-9X; Fri, 13 Dec 2024 14:31:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMBNA-0006pn-5k
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:30:49 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMBN3-0004GU-VW
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:30:47 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5401bd6cdb7so2088960e87.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734118240; x=1734723040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EPj8YUZTlub03UJXQ+2sMdrVTlxqao7LM7USxZNwFlw=;
 b=T99Y4z9VnyAE44PGM1AduITMpPsCFm0ogYnqBVrmdeWxCIDNBAhgylbngQpyhF9f6N
 kVTE10OObygH4LIDkF0LnKbghZwTJPw4HDqzC1em1YTMOcIPZVE6tepYLafXHhwUhjeC
 usShMEx21U/7Y68o2Gg3qd0LbR45wzcuZH7231nwgb/zWDzZOUZl2eP+HjHVgrVDFX4h
 mHd81exFKc8vRQVBHLae2KQXU4myWdG9+oD1y7mERe57cx2xDFc5bMlN0bHOlD7OnLp3
 FhbcbpraBF91f7yoKy4qP1ty9Tde5887CeB51aIXzirm73Gm3nP5GJwHgMDFXl0gj9av
 Cafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734118240; x=1734723040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EPj8YUZTlub03UJXQ+2sMdrVTlxqao7LM7USxZNwFlw=;
 b=BITwDHuMogDjyrYz9WS2V2Jp5RV+b2MT2UcfJzToSgqMKJAL+OtvgdooI08GSOSRt4
 kYheYXRX3n0mxtOlN3aj4YvMn5Ixe90Kikm19weei761kRqXLuNfaQ394bh7LZE4gznO
 IPHj/SAT23xn54QeW5+U0XNZb+OD7b+vqUGI1OLjF+3APOH7tthDo/yD8blUufL1SMKC
 9vGCxOxqxFK/eu3+OlGA0KtdSI3sQ+vavN7WBwFG5aGPa2XyVavbm0WTuOSXDmNzN2b2
 wpH9j7g8+ysjqD/imWb08vBwGMvzPHS3CVuqXggd2BuILZmGhhmJ6XOkQ1xhesiWfOO5
 gZqw==
X-Gm-Message-State: AOJu0Yw7tBpcgb/xZ2LuvGHdItHNvg7+OyyQOT37LCGPq+hsi30wIlvO
 E3PA2pGdeiuboXU+MVg30uE6q6Koq3RjzdXSKNHzar8wfhjJJG6aRE9WuYbNQokaxQTt0Ru1EGs
 kaoWxJ+P+
X-Gm-Gg: ASbGnctcYm8ed4L9NubvfSZoXq6mi7D4002Zfz4rcftz52BTq31PS0Ru3Aq7VGP1yji
 yGy7vKmsbu4TL+li4hhCYJ2vFG6W/Zbchjd3gISRifFCvPpCamMNWjp55ZNYowkDYuXzGFlb5B9
 xjnqND91eJR6Qn6xKyUwEqAHwvJDbQIbqy1B4qDLzDLHWq1aXUjb/AjDJXT2VTqbs+HGDt3qy1/
 qRGRojbht7ovBQQnSe5GS4M0AJPiFsIgHDTxJ62N1V5oQschf49Lz2JJG+BxQ==
X-Google-Smtp-Source: AGHT+IHb0blAbWg3B1NWm+nS1yJZRxXg8GCv1dyegKmvbvJOfpn+4qUWvzmiE0FhJVmsthORYRvPNA==
X-Received: by 2002:a05:6512:3b2b:b0:540:1d6c:f1c1 with SMTP id
 2adb3069b0e04-5408ad81cc1mr1062721e87.2.1734118239821; 
 Fri, 13 Dec 2024 11:30:39 -0800 (PST)
Received: from stoup.. ([91.209.212.67]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120c01051sm6972e87.156.2024.12.13.11.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:30:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 qemu-arm@nongnu.org (open list:SBSA-REF)
Subject: [PATCH 67/71] hw/watchdog: Constify all Property
Date: Fri, 13 Dec 2024 13:30:01 -0600
Message-ID: <20241213193004.2515684-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213193004.2515684-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213193004.2515684-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/watchdog/sbsa_gwdt.c  | 2 +-
 hw/watchdog/wdt_aspeed.c | 2 +-
 hw/watchdog/wdt_imx2.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index 80f9b36e79..2e25d4b4e9 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -262,7 +262,7 @@ static void wdt_sbsa_gwdt_realize(DeviceState *dev, Error **errp)
                 dev);
 }
 
-static Property wdt_sbsa_gwdt_props[] = {
+static const Property wdt_sbsa_gwdt_props[] = {
     /*
      * Timer frequency in Hz. This must match the frequency used by
      * the CPU's generic timer. Default 62.5Hz matches QEMU's legacy
diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index 39c3f362a8..c95877e5c7 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -288,7 +288,7 @@ static void aspeed_wdt_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
-static Property aspeed_wdt_properties[] = {
+static const Property aspeed_wdt_properties[] = {
     DEFINE_PROP_LINK("scu", AspeedWDTState, scu, TYPE_ASPEED_SCU,
                      AspeedSCUState *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index 8162d58afa..61fbd91ee4 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -281,7 +281,7 @@ static void imx2_wdt_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static Property imx2_wdt_properties[] = {
+static const Property imx2_wdt_properties[] = {
     DEFINE_PROP_BOOL("pretimeout-support", IMX2WdtState, pretimeout_support,
                      false),
     DEFINE_PROP_END_OF_LIST()
-- 
2.43.0


