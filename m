Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659B3C48BEF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag2P-0000i8-Ra; Thu, 15 Feb 2024 13:00:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag26-000059-Kr
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:00:30 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag1x-0002CO-3z
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:00:23 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so1735375a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020012; x=1708624812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qpxuOXpE/IReVLTC/yU2rQlOGnVVc7L2PdtnHDAApI4=;
 b=caVifrBxtaanOdRzfmGMH+SaYh7OnjsskI7CnEhJoH7NCE7vZmgVhER0HKeB0k+5ot
 rkYDJW2l73mXsq3FPjOyhXDjAIr9nKiRNKDaQeBkpq71PAOzbghtU8wr7zd734dKOsmB
 Eecs+Ek2qm5hVEdxEZH/M/cm2OZmuLBXH+g5s1YVSeUvNDSKGfEPtoSR+YGas7z3ty/R
 3jpXobzoyrwe2yzjDi13qQ0t023zHWAAqpBTcQPf8dWHMGggaJ2/rH1UViVj/lFH0Kx6
 krPtBcdyM1sE3RO0biRQ2D5cTM3b1r4Chf2422U0oaP9HG4fq7xcO3mAEkz+0tfr8/Hu
 r5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020012; x=1708624812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qpxuOXpE/IReVLTC/yU2rQlOGnVVc7L2PdtnHDAApI4=;
 b=Hd67/oy5dIsat0vxOiAJDKqaIBHxzt8y4pFpso4l8oSR+uLSeV1UROBGIdfN1dTcdX
 nuRF7znyjwbK4wEBHZdfYVCPNaJ+t/5uVvBiBYOxCqKonM6LQVBvmTeABEdKq7FKONm0
 MatNgA+9Y1a+srN5LAjwRZzlVEnkE4RqKER5yPjfoFy0eUv1/oqaVdtsNxnzUxDvVj+C
 osro0ABGixzqA3Y3Y1SPrmSHxr/11e9wO7Mz7DuSW8glF54QX3dhqon57Ho4LOqHF+FA
 Y7z6x4D7waKugC949qaypaqKM98TrPYvj4YiIV5tKJSb8IHSIIwX+oZ1rHHnMz5BpPdH
 w4yQ==
X-Gm-Message-State: AOJu0YyUMmFBZfUMrxKnxKvARlhFPk7tSk36/QWZ2+GxIEBGf5yQsazc
 BIMJZnA3wn8B1AKejPzbGZmBfuYGedW+MpLqjFWw5BDBAFsX8odMLoPxgQjdG/XDr+bzeNrFNPV
 lXyw=
X-Google-Smtp-Source: AGHT+IHnRLTKDRnm6ptOaZkKuhmO3Z+Ws4HfNlyLjH3zQez9TQ8Kgrh1pulcj3MkB0RCWVmW1DJrtw==
X-Received: by 2002:aa7:c445:0:b0:55f:1728:3b33 with SMTP id
 n5-20020aa7c445000000b0055f17283b33mr1699734edr.40.1708020011889; 
 Thu, 15 Feb 2024 10:00:11 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 x6-20020a056402414600b00563c179b993sm465926eda.11.2024.02.15.10.00.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:00:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 21/56] hw/rx/rx62n: Only call qdev_get_gpio_in() when necessary
Date: Thu, 15 Feb 2024 18:57:15 +0100
Message-ID: <20240215175752.82828-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Instead of filling an array of all the possible IRQs, only call
qdev_get_gpio_in() when an IRQ is used. Remove the array from
RX62NState. Doing so we avoid calling qdev_get_gpio_in() on an
unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240213130341.1793-4-philmd@linaro.org>
---
 include/hw/rx/rx62n.h |  1 -
 hw/rx/rx62n.c         | 16 ++++++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/hw/rx/rx62n.h b/include/hw/rx/rx62n.h
index bcda583ab3..766fe0e435 100644
--- a/include/hw/rx/rx62n.h
+++ b/include/hw/rx/rx62n.h
@@ -67,7 +67,6 @@ struct RX62NState {
     MemoryRegion iomem2;
     MemoryRegion iomem3;
     MemoryRegion c_flash;
-    qemu_irq irq[NR_IRQS];
 
     /* Input Clock (XTAL) frequency */
     uint32_t xtal_freq_hz;
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index d3f61a6837..560f53a58a 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -148,14 +148,11 @@ static void register_icu(RX62NState *s)
         qlist_append_int(trigger_level, levelirq[i]);
     }
     qdev_prop_set_array(DEVICE(icu), "trigger-level", trigger_level);
-
-    for (i = 0; i < NR_IRQS; i++) {
-        s->irq[i] = qdev_get_gpio_in(DEVICE(icu), i);
-    }
     sysbus_realize(icu, &error_abort);
+
     sysbus_connect_irq(icu, 0, qdev_get_gpio_in(DEVICE(&s->cpu), RX_CPU_IRQ));
     sysbus_connect_irq(icu, 1, qdev_get_gpio_in(DEVICE(&s->cpu), RX_CPU_FIR));
-    sysbus_connect_irq(icu, 2, s->irq[SWI]);
+    sysbus_connect_irq(icu, 2, qdev_get_gpio_in(DEVICE(&s->icu), SWI));
     sysbus_mmio_map(icu, 0, RX62N_ICU_BASE);
 }
 
@@ -172,7 +169,8 @@ static void register_tmr(RX62NState *s, int unit)
 
     irqbase = RX62N_TMR_IRQ + TMR_NR_IRQ * unit;
     for (i = 0; i < TMR_NR_IRQ; i++) {
-        sysbus_connect_irq(tmr, i, s->irq[irqbase + i]);
+        sysbus_connect_irq(tmr, i,
+                           qdev_get_gpio_in(DEVICE(&s->icu), irqbase + i));
     }
     sysbus_mmio_map(tmr, 0, RX62N_TMR_BASE + unit * 0x10);
 }
@@ -190,7 +188,8 @@ static void register_cmt(RX62NState *s, int unit)
 
     irqbase = RX62N_CMT_IRQ + CMT_NR_IRQ * unit;
     for (i = 0; i < CMT_NR_IRQ; i++) {
-        sysbus_connect_irq(cmt, i, s->irq[irqbase + i]);
+        sysbus_connect_irq(cmt, i,
+                           qdev_get_gpio_in(DEVICE(&s->icu), irqbase + i));
     }
     sysbus_mmio_map(cmt, 0, RX62N_CMT_BASE + unit * 0x10);
 }
@@ -209,7 +208,8 @@ static void register_sci(RX62NState *s, int unit)
 
     irqbase = RX62N_SCI_IRQ + SCI_NR_IRQ * unit;
     for (i = 0; i < SCI_NR_IRQ; i++) {
-        sysbus_connect_irq(sci, i, s->irq[irqbase + i]);
+        sysbus_connect_irq(sci, i,
+                           qdev_get_gpio_in(DEVICE(&s->icu), irqbase + i));
     }
     sysbus_mmio_map(sci, 0, RX62N_SCI_BASE + unit * 0x08);
 }
-- 
2.41.0


