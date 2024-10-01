Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126A4CEACEB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfuL-0005KD-IJ; Tue, 01 Oct 2024 12:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuH-0005Hn-NE
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:25 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuE-0005zy-J2
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:25 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42cbc22e1c4so42757455e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800761; x=1728405561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6mJeU9grKbssKs+nseNLxjInJk05YSdVXhW2EdyT84E=;
 b=T/ZG/M/FWMoCwUcDrfaGPmChWWyEulROTvoC/f/Qutt8QmpJRMmB2IeOl6ofJYxctD
 S5eCDtXNNf6O3i/SjreW+G32XNZZndqUyK53qduXGB7WIY1x67XkfvhZmQZHfcPs7wfo
 ALom/aEmQvnHmAiSe/lkLFQYd8dFjXWOCnmJjUaS037oX9hlD+GvqtFbFes4+CzD6K/X
 0lyklat5Uld1KCRG43bdZVVgo1XkmC2z2q2JbBr5Tdl2SoshK+KkXm+LvRNf7g5CjLH7
 EUPAwnJATICYPWKWYv6lIcZe61WDZeFIf+J1yuZQGMg7LX1bamc6ZHRmxyPRT0H5H69u
 4u/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800761; x=1728405561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6mJeU9grKbssKs+nseNLxjInJk05YSdVXhW2EdyT84E=;
 b=cFGXBNp//J+ONjiRVBfwwoDXBstY377FsVC7KBHsEGTURJ5UUk/y/4LAeKxwgo2R6n
 nDyMg5KEh9kCnxbUBxaPI9UGUKCyHFyhxEtAa9AkwQQ0grfRjTe+cwd7SO0q5LWuhY93
 yyrNJsm1Tu+f5fP7nz1HADI60RFF9/cvnfd1x82ZJ/mUYpwLNIkCN+LPNMZ+y5RtUl7S
 0nfOLWZ8jyLPziZCubrc3hkXsN3khU1JvAYe0ZMEKeMo1+j8XYNpxaVpD9BBnE7BGJGq
 f3OnxDPHGdvTRMFUgebKWCU73DSJmNf+gfm9jJ3V5QqQ1Zs2Vt/SutQRZJ7uuH+bRjeD
 TTkQ==
X-Gm-Message-State: AOJu0YyRGtNRjB5WssjTVDgzA6XHc2BRzxm7sQjcPEI9UmuIW3IyljIm
 F3N9w6S60VIIsW+0I5PIWlo/2JyfO77c87/bId0YxV+YWvGsYC6clWLr4Dffy/xS5n2SN4qmld3
 J
X-Google-Smtp-Source: AGHT+IHThcTJbgps2A24vKd+852K2eVhFRxZYY0o9SS3EA+3lL7bi90VnlET2hGXfczswtoj/FRz4A==
X-Received: by 2002:a05:6000:4616:b0:37c:d21a:3d61 with SMTP id
 ffacd0b85a97d-37cfba0a3e4mr191528f8f.39.1727800761074; 
 Tue, 01 Oct 2024 09:39:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/54] hw/arm/xlnx: Connect secondary CGEM IRQs
Date: Tue,  1 Oct 2024 17:38:26 +0100
Message-Id: <20241001163918.1275441-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Kinsey Moore <kinsey.moore@oarcorp.com>

The Cadence GEM peripherals as configured for Zynq MPSoC and Versal
platforms have two priority queues with separate interrupt sources for
each. If the interrupt source for the second priority queue is not
connected, they work in polling mode only. This change connects the
second interrupt source for platforms where it is available. This patch
has been tested using the lwIP stack with a Xilinx-supplied driver from
their embeddedsw repository.

Signed-off-by: Kinsey Moore <kinsey.moore@oarcorp.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h |  1 +
 include/hw/arm/xlnx-zynqmp.h |  1 +
 hw/arm/xlnx-versal.c         | 12 +++++++++++-
 hw/arm/xlnx-zynqmp.c         | 11 ++++++++++-
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 025beb5532d..05ed641b6b6 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -78,6 +78,7 @@ struct Versal {
         struct {
             PL011State uart[XLNX_VERSAL_NR_UARTS];
             CadenceGEMState gem[XLNX_VERSAL_NR_GEMS];
+            OrIRQState gem_irq_orgate[XLNX_VERSAL_NR_GEMS];
             XlnxZDMA adma[XLNX_VERSAL_NR_ADMAS];
             VersalUsb2 usb;
             CanBusState *canbus[XLNX_VERSAL_NR_CANFD];
diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index 48f79480921..c137ac59e85 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -116,6 +116,7 @@ struct XlnxZynqMPState {
     MemoryRegion mr_unimp[XLNX_ZYNQMP_NUM_UNIMP_AREAS];
 
     CadenceGEMState gem[XLNX_ZYNQMP_NUM_GEMS];
+    OrIRQState gem_irq_orgate[XLNX_ZYNQMP_NUM_GEMS];
     CadenceUARTState uart[XLNX_ZYNQMP_NUM_UARTS];
     XlnxZynqMPCANState can[XLNX_ZYNQMP_NUM_CAN];
     SysbusAHCIState sata;
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 50cb0606cbf..3a1e2e29f1c 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -258,14 +258,23 @@ static void versal_create_gems(Versal *s, qemu_irq *pic)
         char *name = g_strdup_printf("gem%d", i);
         DeviceState *dev;
         MemoryRegion *mr;
+        OrIRQState *or_irq;
 
         object_initialize_child(OBJECT(s), name, &s->lpd.iou.gem[i],
                                 TYPE_CADENCE_GEM);
+        or_irq = &s->lpd.iou.gem_irq_orgate[i];
+        object_initialize_child(OBJECT(s), "gem-irq-orgate[*]",
+                                or_irq, TYPE_OR_IRQ);
         dev = DEVICE(&s->lpd.iou.gem[i]);
         qemu_configure_nic_device(dev, true, NULL);
         object_property_set_int(OBJECT(dev), "phy-addr", 23, &error_abort);
         object_property_set_int(OBJECT(dev), "num-priority-queues", 2,
                                 &error_abort);
+        object_property_set_int(OBJECT(or_irq),
+                                "num-lines", 2, &error_fatal);
+        qdev_realize(DEVICE(or_irq), NULL, &error_fatal);
+        qdev_connect_gpio_out(DEVICE(or_irq), 0, pic[irqs[i]]);
+
         object_property_set_link(OBJECT(dev), "dma", OBJECT(&s->mr_ps),
                                  &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
@@ -273,7 +282,8 @@ static void versal_create_gems(Versal *s, qemu_irq *pic)
         mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
         memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
 
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irqs[i]]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(DEVICE(or_irq), 0));
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1, qdev_get_gpio_in(DEVICE(or_irq), 1));
         g_free(name);
     }
 }
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index afeb3f88f81..ab2d50e31bc 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -394,6 +394,8 @@ static void xlnx_zynqmp_init(Object *obj)
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_GEMS; i++) {
         object_initialize_child(obj, "gem[*]", &s->gem[i], TYPE_CADENCE_GEM);
+        object_initialize_child(obj, "gem-irq-orgate[*]",
+                                &s->gem_irq_orgate[i], TYPE_OR_IRQ);
     }
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_UARTS; i++) {
@@ -625,12 +627,19 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
                                 &error_abort);
         object_property_set_int(OBJECT(&s->gem[i]), "num-priority-queues", 2,
                                 &error_abort);
+        object_property_set_int(OBJECT(&s->gem_irq_orgate[i]),
+                                "num-lines", 2, &error_fatal);
+        qdev_realize(DEVICE(&s->gem_irq_orgate[i]), NULL, &error_fatal);
+        qdev_connect_gpio_out(DEVICE(&s->gem_irq_orgate[i]), 0, gic_spi[gem_intr[i]]);
+
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->gem[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem[i]), 0, gem_addr[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem[i]), 0,
-                           gic_spi[gem_intr[i]]);
+                           qdev_get_gpio_in(DEVICE(&s->gem_irq_orgate[i]), 0));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem[i]), 1,
+                           qdev_get_gpio_in(DEVICE(&s->gem_irq_orgate[i]), 1));
     }
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_UARTS; i++) {
-- 
2.34.1


