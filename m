Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9E5CEACEA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfuS-0005O3-Hg; Tue, 01 Oct 2024 12:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuP-0005Lv-7S
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:33 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuM-00062V-IB
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:32 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37cfa129074so329719f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800769; x=1728405569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UWAHt89Llm0J4lLGHqjfGDFPlwsKF+8ZikfEYfZxuJ8=;
 b=pKz3O3ybKoTjFgdV293ZBP6j6Ocn/dkWUIVIFmELNYQr5CePrzg9kduxDE3mFsAaZ0
 yOXOIL6Zfa+girR4tP+e+Y3pMvlnjG27/aK2z/bYiLu8OfWNGK5JepnvzWzHm1H5Hoav
 lmES5AE0kQhXuldLwX9r5V1G1/s0df5Vy9HbStEotnv5tfiAdM9B+D/BGnPl/xbcq8yy
 7bmG7TGyxlEX0nviF4y4Zgu2QmtMPa+M/Fo2FPWMNEEOxL5+8uC7VmWwwXy8s9vFlJJ5
 J32qkEWAeYVIx/uxJlAeI6YN6vYxzwROmlawNmZ+oEnqUvEp8Rwm28VTkETb80XSMGgO
 PNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800769; x=1728405569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UWAHt89Llm0J4lLGHqjfGDFPlwsKF+8ZikfEYfZxuJ8=;
 b=hQjHvPC1cg1UWYr9V9ixBYtbI/icZw2DGnOshYFb8ciAAxs4Tn3uDFC5vTwjX8N29F
 0Mq5Q42bBiD9I97aKRwXrbYu8nQscD6kTP4iX1OcOLJukYCn+mSEPi4u3qLaURmLCoph
 IIpxZVYfkzAgAGtDAR7lmubxQKsl2ukoeaApp7FFkqgpEQp/Z/Xo6Ik0kETv2lNMDmjl
 QB6JrTeW/PrehoCNpGqlpPR3Ks1O2VCnvbudy2xYWh/R61FwwUV/tjxdguCxZgLOpJN6
 qJzp5FX/UzuP/8cebeSXU3Mu8JEmfZJ76O9J6BIeREUfed5l29ac/OeAXsWjUFRNdP+E
 1MIg==
X-Gm-Message-State: AOJu0YxmICyx13wyzP8PzLdwl37+xvX7aIW8cd0BoKM1KyA9lfMGLpPx
 VHq3iRbMHbxMSv32q0THwEuBVOpmAu58dJ4P8riMg28flVfJugPhMshGbZkAf3iYp21+EyrVDkQ
 o
X-Google-Smtp-Source: AGHT+IFfl2ltvV4PJl02rBtej8Eopzw3T35QlgzbBCrb1YTIPqKuWDUCtvfWU5fySv630d2Fm+P3Hw==
X-Received: by 2002:a5d:5f4e:0:b0:374:c4c2:fc23 with SMTP id
 ffacd0b85a97d-37cfba182d9mr146538f8f.56.1727800768990; 
 Tue, 01 Oct 2024 09:39:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/54] hw/arm: Remove STRONGARM->PXA2XX dependency
Date: Tue,  1 Oct 2024 17:38:41 +0100
Message-Id: <20241001163918.1275441-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

Currently the STRONGARM KConfig symbol pulls in PXA2XX. Since we've now
removed all the true uses of PXA2XX, we'd like to remove the PXA2XX
symbol too. To permit that, make STRONGARM directly select the things
it truly depends on:
 * pxa25x-timer
 * SSI

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240903160751.4100218-14-peter.maydell@linaro.org
---
 hw/arm/Kconfig       | 4 +++-
 hw/timer/Kconfig     | 3 +++
 hw/timer/meson.build | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index c2452bd7b91..8f6cbf94855 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -175,6 +175,7 @@ config PXA2XX
     select SSI
     select USB_OHCI_SYSBUS
     select PCMCIA
+    select PXA2XX_TIMER
 
 config REALVIEW
     bool
@@ -261,7 +262,8 @@ config STM32VLDISCOVERY
 
 config STRONGARM
     bool
-    select PXA2XX
+    select PXA2XX_TIMER
+    select SSI
 
 config COLLIE
     bool
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index 61fbb62b65c..c96fd5d97ae 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -21,6 +21,9 @@ config ALLWINNER_A10_PIT
     bool
     select PTIMER
 
+config PXA2XX_TIMER
+    bool
+
 config SIFIVE_PWM
     bool
 
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
index 5b6c8b4be9e..c1113eb90b1 100644
--- a/hw/timer/meson.build
+++ b/hw/timer/meson.build
@@ -23,7 +23,7 @@ system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_timer.c'))
 system_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_timer.c'))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_gptimer.c'))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_synctimer.c'))
-system_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx_timer.c'))
+system_ss.add(when: 'CONFIG_PXA2XX_TIMER', if_true: files('pxa2xx_timer.c'))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_systmr.c'))
 system_ss.add(when: 'CONFIG_SH_TIMER', if_true: files('sh_timer.c'))
 system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_timer.c'))
-- 
2.34.1


