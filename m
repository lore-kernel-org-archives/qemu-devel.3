Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C31C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafen-0008T9-Qj; Thu, 15 Feb 2024 12:36:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeO-00082K-1w
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:56 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeI-0003z9-EZ
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:55 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40fb3b5893eso8871175e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018549; x=1708623349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1HuGvjbyaFuNkELSJgH9k4dc4RWkJylBVt2syMO9HNA=;
 b=PDbfHrFkJ2cEGpX65nMmQCxH9kPbXlMy0hV1e7CZEfHJ9fs++4OV1aw1lJzPVbF52s
 XYnqA57EI5F5ZCmk9y6xa7zgftcQmCTXIPN6gkxfMsWQsdtwx1zXkBVQmdUswC1k6JBU
 FFRCtWPlHsgDJ4rwbDEzzEP8RpU8I1LHgtk0SEKffcB34ehE8ERntjl9ncIyz7G0cYrH
 FlX9J7VHKDQlmLv2e+4SkhPeLIXLldHjitth83uvZ3lVITSQVzCLU9upnlkwK+qRvqPd
 VxTx9Yw++bw5kPtKcGY+3vkqbFYarVO7M0QBd4CWUssRJxmJUmdt/mvxSjZwnN7D4N3N
 9Ouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018549; x=1708623349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1HuGvjbyaFuNkELSJgH9k4dc4RWkJylBVt2syMO9HNA=;
 b=ZLMGG43UtxtVAJ1tfuBsJdeJyqhWu9uCEDXSzWKJY8WtUf5mrWZizxTX8BUPpiylXm
 f/KpTnfbBac2qpeP4QB6r+23cG3u7pSGzavmUc1GeQNTBGwCKiZgW7Oi3dzbPXsnsgAR
 ywKI1LwbV+ZgA4WP2ZjvmY681gPv+tdDHILVEnOev+iA8V4gYX0AM+TvoQYerabcNttm
 LOOHT5jYrlEdFC9XLpXlgFvtgkpkoF4qH/F9+38wN0ZmNg1ltDfK9Xg/a/f/D9koWDC2
 VrUMlFhMrjB+XlgLUDtA+dSWIyj4eYy5BTXrUQR/ndjLF5pRNuXDKcL/HLhEcnP65uAj
 5ZLA==
X-Gm-Message-State: AOJu0Yzb35MEFHPkXh3h7H7BlLXf+keYbSng78x/veybiYAfGIm+2eZQ
 GOqYKfIkp561MsbTaqQpzeLTYSU51Glyg+Dv7Zo2biqmuXHO3b0d3R1evBTf1pWA/JU6Xw9LBkO
 D
X-Google-Smtp-Source: AGHT+IGnCL3zf4yfj9MWcjS4RHlMwxe7DO/pDnPS//5SGQcUyuo+1FSZ+Do/XpimeYfuQaycfbD5dw==
X-Received: by 2002:adf:f187:0:b0:33d:82a:14af with SMTP id
 h7-20020adff187000000b0033d082a14afmr1302685wro.64.1708018549159; 
 Thu, 15 Feb 2024 09:35:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/35] hw/arm/stellaris: Add missing QOM 'SoC' parent
Date: Thu, 15 Feb 2024 17:35:25 +0000
Message-Id: <20240215173538.2430599-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

QDev objects created with qdev_new() need to manually add
their parent relationship with object_property_add_child().

Since we don't model the SoC, just use a QOM container.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240213155214.13619-5-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/stellaris.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index d9884286b3f..a2f998bf9e2 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1031,6 +1031,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
      * 400fe000 system control
      */
 
+    Object *soc_container;
     DeviceState *gpio_dev[7], *nvic;
     qemu_irq gpio_in[7][8];
     qemu_irq gpio_out[7][8];
@@ -1052,6 +1053,9 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     flash_size = (((board->dc0 & 0xffff) + 1) << 1) * 1024;
     sram_size = ((board->dc0 >> 18) + 1) * 1024;
 
+    soc_container = object_new("container");
+    object_property_add_child(OBJECT(ms), "soc", soc_container);
+
     /* Flash programming is done via the SCU, so pretend it is ROM.  */
     memory_region_init_rom(flash, NULL, "stellaris.flash", flash_size,
                            &error_fatal);
@@ -1066,6 +1070,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
      * need its sysclk output.
      */
     ssys_dev = qdev_new(TYPE_STELLARIS_SYS);
+    object_property_add_child(soc_container, "sys", OBJECT(ssys_dev));
 
     /*
      * Most devices come preprogrammed with a MAC address in the user data.
@@ -1092,6 +1097,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ssys_dev), &error_fatal);
 
     nvic = qdev_new(TYPE_ARMV7M);
+    object_property_add_child(soc_container, "v7m", OBJECT(nvic));
     qdev_prop_set_uint32(nvic, "num-irq", NUM_IRQ_LINES);
     qdev_prop_set_uint8(nvic, "num-prio-bits", NUM_PRIO_BITS);
     qdev_prop_set_string(nvic, "cpu-type", ms->cpu_type);
@@ -1125,6 +1131,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
 
             dev = qdev_new(TYPE_STELLARIS_GPTM);
             sbd = SYS_BUS_DEVICE(dev);
+            object_property_add_child(soc_container, "gptm[*]", OBJECT(dev));
             qdev_connect_clock_in(dev, "clk",
                                   qdev_get_clock_out(ssys_dev, "SYSCLK"));
             sysbus_realize_and_unref(sbd, &error_fatal);
@@ -1138,7 +1145,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
 
     if (board->dc1 & (1 << 3)) { /* watchdog present */
         dev = qdev_new(TYPE_LUMINARY_WATCHDOG);
-
+        object_property_add_child(soc_container, "wdg", OBJECT(dev));
         qdev_connect_clock_in(dev, "WDOGCLK",
                               qdev_get_clock_out(ssys_dev, "SYSCLK"));
 
@@ -1178,6 +1185,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
             SysBusDevice *sbd;
 
             dev = qdev_new("pl011_luminary");
+            object_property_add_child(soc_container, "uart[*]", OBJECT(dev));
             sbd = SYS_BUS_DEVICE(dev);
             qdev_prop_set_chr(dev, "chardev", serial_hd(i));
             sysbus_realize_and_unref(sbd, &error_fatal);
@@ -1298,6 +1306,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
         DeviceState *enet;
 
         enet = qdev_new("stellaris_enet");
+        object_property_add_child(soc_container, "enet", OBJECT(enet));
         if (nd) {
             qdev_set_nic_properties(enet, nd);
         } else {
-- 
2.34.1


