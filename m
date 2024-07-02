Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD36C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOVfa-0003mt-UD; Tue, 02 Jul 2024 01:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVfZ-0003T6-0k
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:03:09 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVfT-0007dm-J6
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:03:08 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4255fc43f1cso25869245e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 22:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719896581; x=1720501381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RpqEDb+iBtpvIrsNwMVclKz/Xq4RBNysBjtBSTbDfBY=;
 b=Yg0R9LlMiN2qoJMccT970VzEtaffJS3xqPq1z6XHH56kBxHGYPVAJHJTRkB+73GhdA
 q1CP+qs7L0/vAxIIJwzbZrZWKtMIKxeTDNCzMPG+Y+h8V+fqGyC2byBLk/7r9EQ/eBPg
 jsdDhPcwvWM6VvO7HX/VX9UxslH/IeNuQqKt3PYScYY81SaaVRoDbCXyhNEQHCjmMgK4
 rxAhSm019HmQzVD/WjeNpSI0Xhs8N6gDikciwof7ZCT7MKJBj/ToRr628ET370+f3h4H
 QyqPmjbNnPa+T3B00DUmzIcZEgSFyxdjX4D2nOW2oRpuV2oqeEMDokbbXc7cYEplOAIW
 34uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719896581; x=1720501381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RpqEDb+iBtpvIrsNwMVclKz/Xq4RBNysBjtBSTbDfBY=;
 b=UVoUpjcbqmMygxsAdrG7zU9OyLCMPkOycZ5X6Uz5eE7GbvxrM0s3FMAXc2n03rHsor
 3Qaitz30K2lmloZxyjxQn0mtIVrmeOttzZy6j9zUEUd/fF0taxWUSSfrMYL0jvSEYU3Z
 qMRzPqS9Yuh7baKN1SabBapq7rSg3fdGtIfy5OOcpS58zh73gejsXyBieyXkXPUeRdVc
 87vtB/XxLbO+LJOYWuBqoPdh+INOFoqDYuEyERByaOX2mHXXhzhs/0YWnm+tquuPFS/T
 UwWE/wOX81dVUlf2Tmosp121AUpG4T+qXDCZoFzEbxjphfXdedL9uNu9lbrEm1BpR0PM
 zMQg==
X-Gm-Message-State: AOJu0Yx9zAxgk9j9vwKkSAYwNH406SYIX5mwqpEY99pK9yJHN0zufN6m
 6VFfEFjEKjBuvpN1dFAXz8wAa0/xJqc2rpWN8sx3PGPv/ogKZ+fCPli9E4tv2bLIw60imeWz3Fl
 5
X-Google-Smtp-Source: AGHT+IGQl9U2uYOo9pG0tYiP+/OdBP1FwY+gimlJrVjIf32637oCpjqnxfMdAZztw/LYl3nIyNdh1Q==
X-Received: by 2002:a05:600c:4f52:b0:424:ad14:6b87 with SMTP id
 5b1f17b1804b1-4257a02d548mr50160455e9.4.1719896580776; 
 Mon, 01 Jul 2024 22:03:00 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af5b8e2sm180146955e9.16.2024.07.01.22.02.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Jul 2024 22:03:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/22] hw/ide/macio: switch from using qemu_allocate_irq() to
 qdev input GPIOs
Date: Tue,  2 Jul 2024 07:01:07 +0200
Message-ID: <20240702050112.35907-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702050112.35907-1-philmd@linaro.org>
References: <20240702050112.35907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This prevents the IRQs from being leaked when the macio IDE device is used.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240628160334.653168-1-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/misc/macio/macio.h |  7 +++++--
 hw/ide/macio.c                | 10 ++++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h
index 2b54da6b31..16aa95b876 100644
--- a/include/hw/misc/macio/macio.h
+++ b/include/hw/misc/macio/macio.h
@@ -80,8 +80,6 @@ struct MACIOIDEState {
     uint32_t channel;
     qemu_irq real_ide_irq;
     qemu_irq real_dma_irq;
-    qemu_irq ide_irq;
-    qemu_irq dma_irq;
 
     MemoryRegion mem;
     IDEBus bus;
@@ -92,6 +90,11 @@ struct MACIOIDEState {
     uint32_t irq_reg;
 };
 
+#define MACIO_IDE_PMAC_NIRQS 2
+
+#define MACIO_IDE_PMAC_DMA_IRQ 0
+#define MACIO_IDE_PMAC_IDE_IRQ 1
+
 void macio_ide_init_drives(MACIOIDEState *ide, DriveInfo **hd_table);
 void macio_ide_register_dma(MACIOIDEState *ide);
 
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index aca90d04f0..e84bf2c9f6 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -420,7 +420,8 @@ static void macio_ide_realizefn(DeviceState *dev, Error **errp)
 {
     MACIOIDEState *s = MACIO_IDE(dev);
 
-    ide_bus_init_output_irq(&s->bus, s->ide_irq);
+    ide_bus_init_output_irq(&s->bus,
+                            qdev_get_gpio_in(dev, MACIO_IDE_PMAC_IDE_IRQ));
 
     /* Register DMA callbacks */
     s->dma.ops = &dbdma_ops;
@@ -456,8 +457,8 @@ static void macio_ide_initfn(Object *obj)
     sysbus_init_mmio(d, &s->mem);
     sysbus_init_irq(d, &s->real_ide_irq);
     sysbus_init_irq(d, &s->real_dma_irq);
-    s->dma_irq = qemu_allocate_irq(pmac_ide_irq, s, 0);
-    s->ide_irq = qemu_allocate_irq(pmac_ide_irq, s, 1);
+
+    qdev_init_gpio_in(DEVICE(obj), pmac_ide_irq, MACIO_IDE_PMAC_NIRQS);
 
     object_property_add_link(obj, "dbdma", TYPE_MAC_DBDMA,
                              (Object **) &s->dbdma,
@@ -508,7 +509,8 @@ void macio_ide_init_drives(MACIOIDEState *s, DriveInfo **hd_table)
 
 void macio_ide_register_dma(MACIOIDEState *s)
 {
-    DBDMA_register_channel(s->dbdma, s->channel, s->dma_irq,
+    DBDMA_register_channel(s->dbdma, s->channel,
+                           qdev_get_gpio_in(DEVICE(s), MACIO_IDE_PMAC_DMA_IRQ),
                            pmac_ide_transfer, pmac_ide_flush, s);
 }
 
-- 
2.41.0


