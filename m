Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3843CEACE7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfuT-0005OO-MK; Tue, 01 Oct 2024 12:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuP-0005MW-Sp
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:33 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuL-00062A-Mw
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:33 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37cd26c6dd1so4460336f8f.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800768; x=1728405568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IsPZhNIFegAxCcZG/FTVhI93D91jlaEziq4+P1vw8sA=;
 b=cQirRuScTAlTCRF0oXLSPcA6YWbsHjWxSQ19PqbM8Ltpti6lMRktr9fGIIKEXDYOQm
 OWdg8F1RH6Dc8KmgA2ICzWvegmQeXihAPwafnO0JGxEsSgpGPdNQrADSN601RzqIxbtq
 yDlBLzfe2dbBEpRu+9nwURGmNp+zjVmUEs4054X2A4d94PU0V3KthqGgvRjrxQYspJLb
 Cli6PwAgW9Unslf5eWiZ038eJgj0qBBWT79vQHtDgjaURm90SBz1xCKRWL1vzRtryFX+
 7IX4Imk1MFxAzTj8vpnNjwTR0Munsdw88tA6WqI74lDV1X0oxcQlRPz02T0aPRaPDUZ+
 XwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800768; x=1728405568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IsPZhNIFegAxCcZG/FTVhI93D91jlaEziq4+P1vw8sA=;
 b=bNP7iKzIfOtcEeNLJruSZJy9htey6LomYpC/Ix5kQluZbCex4rakNgFU21xpTMFl5s
 G8Z1Lv8fWPLP5LJ1sW2gX5Olqgt1HZXxpYakE4Pc6G8HguEcZNECvuoEV5XypoRyfYSg
 tmaVztuz7DiPP0xf0rCNWnt9VdcHVvnDU/FUASbEFALlDsdwVyIy0FkudL0/TpNwj2dx
 xCMRPMHw43yDdBnIvF6JOxuLTHeRq47jmv6gRz/cZfJJBElcW0+Fq3gaqc6QDIcoQx0s
 dj6EC9osr4dsg7Sc6jQlCJyTbS7wT85XSGkzThVIyYqanCq898wSJE8dxlX2R/HcW4l/
 vSPg==
X-Gm-Message-State: AOJu0Yz74ha++i/2eodfhE/wtp0cPiLz5qNorg4W8Yp/KUjr812kEPYq
 9DLlUaHviCVwJDX3vkyMCoeuNB5sK+pM6HRFHOmtY9dWIAvS38+RLngWKnERZYl2cF3N+6bLs5i
 j
X-Google-Smtp-Source: AGHT+IGJQbcjnHcLxPoYl9FKaDwtJ8Y8tEqaUbX2RvXuxIgi6TRCR+clx8PwEyqOjSjqlm7yC6gHkw==
X-Received: by 2002:adf:e8d2:0:b0:374:c11c:c5ca with SMTP id
 ffacd0b85a97d-37cfba0a75dmr142013f8f.46.1727800768046; 
 Tue, 01 Oct 2024 09:39:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/54] hw/misc: Remove MAINSTONE_FPGA device
Date: Tue,  1 Oct 2024 17:38:39 +0100
Message-Id: <20241001163918.1275441-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

The MAINSTONE_FPGA device was used only by the 'mainstone' machine
type, so we can remove it now.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240903160751.4100218-12-peter.maydell@linaro.org
---
 MAINTAINERS         |   1 -
 hw/misc/mst_fpga.c  | 269 --------------------------------------------
 hw/misc/meson.build |   1 -
 3 files changed, 271 deletions(-)
 delete mode 100644 hw/misc/mst_fpga.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d7f7b32701..d9dd257843b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -920,7 +920,6 @@ S: Odd Fixes
 F: hw/arm/z2.c
 F: hw/*/pxa2xx*
 F: hw/gpio/max7310.c
-F: hw/misc/mst_fpga.c
 F: hw/adc/max111x.c
 F: include/hw/adc/max111x.h
 F: include/hw/arm/pxa.h
diff --git a/hw/misc/mst_fpga.c b/hw/misc/mst_fpga.c
deleted file mode 100644
index 2d7bfa5ad9e..00000000000
--- a/hw/misc/mst_fpga.c
+++ /dev/null
@@ -1,269 +0,0 @@
-/*
- * PXA270-based Intel Mainstone platforms.
- * FPGA driver
- *
- * Copyright (c) 2007 by Armin Kuster <akuster@kama-aina.net> or
- *                                    <akuster@mvista.com>
- *
- * This code is licensed under the GNU GPL v2.
- *
- * Contributions after 2012-01-13 are licensed under the terms of the
- * GNU GPL, version 2 or (at your option) any later version.
- */
-
-#include "qemu/osdep.h"
-#include "hw/irq.h"
-#include "hw/sysbus.h"
-#include "migration/vmstate.h"
-#include "qemu/module.h"
-#include "qom/object.h"
-
-/* Mainstone FPGA for extern irqs */
-#define FPGA_GPIO_PIN	0
-#define MST_NUM_IRQS	16
-#define MST_LEDDAT1		0x10
-#define MST_LEDDAT2		0x14
-#define MST_LEDCTRL		0x40
-#define MST_GPSWR		0x60
-#define MST_MSCWR1		0x80
-#define MST_MSCWR2		0x84
-#define MST_MSCWR3		0x88
-#define MST_MSCRD		0x90
-#define MST_INTMSKENA	0xc0
-#define MST_INTSETCLR	0xd0
-#define MST_PCMCIA0		0xe0
-#define MST_PCMCIA1		0xe4
-
-#define MST_PCMCIAx_READY	(1 << 10)
-#define MST_PCMCIAx_nCD		(1 << 5)
-
-#define MST_PCMCIA_CD0_IRQ	9
-#define MST_PCMCIA_CD1_IRQ	13
-
-#define TYPE_MAINSTONE_FPGA "mainstone-fpga"
-OBJECT_DECLARE_SIMPLE_TYPE(mst_irq_state, MAINSTONE_FPGA)
-
-struct mst_irq_state {
-    SysBusDevice parent_obj;
-
-    MemoryRegion iomem;
-
-    qemu_irq parent;
-
-    uint32_t prev_level;
-    uint32_t leddat1;
-    uint32_t leddat2;
-    uint32_t ledctrl;
-    uint32_t gpswr;
-    uint32_t mscwr1;
-    uint32_t mscwr2;
-    uint32_t mscwr3;
-    uint32_t mscrd;
-    uint32_t intmskena;
-    uint32_t intsetclr;
-    uint32_t pcmcia0;
-    uint32_t pcmcia1;
-};
-
-static void
-mst_fpga_set_irq(void *opaque, int irq, int level)
-{
-	mst_irq_state *s = (mst_irq_state *)opaque;
-	uint32_t oldint = s->intsetclr & s->intmskena;
-
-	if (level)
-		s->prev_level |= 1u << irq;
-	else
-		s->prev_level &= ~(1u << irq);
-
-	switch(irq) {
-	case MST_PCMCIA_CD0_IRQ:
-		if (level)
-			s->pcmcia0 &= ~MST_PCMCIAx_nCD;
-		else
-			s->pcmcia0 |=  MST_PCMCIAx_nCD;
-		break;
-	case MST_PCMCIA_CD1_IRQ:
-		if (level)
-			s->pcmcia1 &= ~MST_PCMCIAx_nCD;
-		else
-			s->pcmcia1 |=  MST_PCMCIAx_nCD;
-		break;
-	}
-
-	if ((s->intmskena & (1u << irq)) && level)
-		s->intsetclr |= 1u << irq;
-
-	if (oldint != (s->intsetclr & s->intmskena))
-		qemu_set_irq(s->parent, s->intsetclr & s->intmskena);
-}
-
-
-static uint64_t
-mst_fpga_readb(void *opaque, hwaddr addr, unsigned size)
-{
-	mst_irq_state *s = (mst_irq_state *) opaque;
-
-	switch (addr) {
-	case MST_LEDDAT1:
-		return s->leddat1;
-	case MST_LEDDAT2:
-		return s->leddat2;
-	case MST_LEDCTRL:
-		return s->ledctrl;
-	case MST_GPSWR:
-		return s->gpswr;
-	case MST_MSCWR1:
-		return s->mscwr1;
-	case MST_MSCWR2:
-		return s->mscwr2;
-	case MST_MSCWR3:
-		return s->mscwr3;
-	case MST_MSCRD:
-		return s->mscrd;
-	case MST_INTMSKENA:
-		return s->intmskena;
-	case MST_INTSETCLR:
-		return s->intsetclr;
-	case MST_PCMCIA0:
-		return s->pcmcia0;
-	case MST_PCMCIA1:
-		return s->pcmcia1;
-	default:
-		printf("Mainstone - mst_fpga_readb: Bad register offset "
-			"0x" HWADDR_FMT_plx "\n", addr);
-	}
-	return 0;
-}
-
-static void
-mst_fpga_writeb(void *opaque, hwaddr addr, uint64_t value,
-		unsigned size)
-{
-	mst_irq_state *s = (mst_irq_state *) opaque;
-	value &= 0xffffffff;
-
-	switch (addr) {
-	case MST_LEDDAT1:
-		s->leddat1 = value;
-		break;
-	case MST_LEDDAT2:
-		s->leddat2 = value;
-		break;
-	case MST_LEDCTRL:
-		s->ledctrl = value;
-		break;
-	case MST_GPSWR:
-		s->gpswr = value;
-		break;
-	case MST_MSCWR1:
-		s->mscwr1 = value;
-		break;
-	case MST_MSCWR2:
-		s->mscwr2 = value;
-		break;
-	case MST_MSCWR3:
-		s->mscwr3 = value;
-		break;
-	case MST_MSCRD:
-		s->mscrd =  value;
-		break;
-	case MST_INTMSKENA:	/* Mask interrupt */
-		s->intmskena = (value & 0xFEEFF);
-		qemu_set_irq(s->parent, s->intsetclr & s->intmskena);
-		break;
-	case MST_INTSETCLR:	/* clear or set interrupt */
-		s->intsetclr = (value & 0xFEEFF);
-		qemu_set_irq(s->parent, s->intsetclr & s->intmskena);
-		break;
-		/* For PCMCIAx allow the to change only power and reset */
-	case MST_PCMCIA0:
-		s->pcmcia0 = (value & 0x1f) | (s->pcmcia0 & ~0x1f);
-		break;
-	case MST_PCMCIA1:
-		s->pcmcia1 = (value & 0x1f) | (s->pcmcia1 & ~0x1f);
-		break;
-	default:
-		printf("Mainstone - mst_fpga_writeb: Bad register offset "
-			"0x" HWADDR_FMT_plx "\n", addr);
-	}
-}
-
-static const MemoryRegionOps mst_fpga_ops = {
-	.read = mst_fpga_readb,
-	.write = mst_fpga_writeb,
-	.endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-static int mst_fpga_post_load(void *opaque, int version_id)
-{
-	mst_irq_state *s = (mst_irq_state *) opaque;
-
-	qemu_set_irq(s->parent, s->intsetclr & s->intmskena);
-	return 0;
-}
-
-static void mst_fpga_init(Object *obj)
-{
-    DeviceState *dev = DEVICE(obj);
-    mst_irq_state *s = MAINSTONE_FPGA(obj);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-
-    s->pcmcia0 = MST_PCMCIAx_READY | MST_PCMCIAx_nCD;
-    s->pcmcia1 = MST_PCMCIAx_READY | MST_PCMCIAx_nCD;
-
-    sysbus_init_irq(sbd, &s->parent);
-
-    /* alloc the external 16 irqs */
-    qdev_init_gpio_in(dev, mst_fpga_set_irq, MST_NUM_IRQS);
-
-    memory_region_init_io(&s->iomem, obj, &mst_fpga_ops, s,
-                          "fpga", 0x00100000);
-    sysbus_init_mmio(sbd, &s->iomem);
-}
-
-static const VMStateDescription vmstate_mst_fpga_regs = {
-    .name = "mainstone_fpga",
-    .version_id = 0,
-    .minimum_version_id = 0,
-    .post_load = mst_fpga_post_load,
-    .fields = (const VMStateField[]) {
-		VMSTATE_UINT32(prev_level, mst_irq_state),
-		VMSTATE_UINT32(leddat1, mst_irq_state),
-		VMSTATE_UINT32(leddat2, mst_irq_state),
-		VMSTATE_UINT32(ledctrl, mst_irq_state),
-		VMSTATE_UINT32(gpswr, mst_irq_state),
-		VMSTATE_UINT32(mscwr1, mst_irq_state),
-		VMSTATE_UINT32(mscwr2, mst_irq_state),
-		VMSTATE_UINT32(mscwr3, mst_irq_state),
-		VMSTATE_UINT32(mscrd, mst_irq_state),
-		VMSTATE_UINT32(intmskena, mst_irq_state),
-		VMSTATE_UINT32(intsetclr, mst_irq_state),
-		VMSTATE_UINT32(pcmcia0, mst_irq_state),
-		VMSTATE_UINT32(pcmcia1, mst_irq_state),
-		VMSTATE_END_OF_LIST(),
-	},
-};
-
-static void mst_fpga_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->desc = "Mainstone II FPGA";
-    dc->vmsd = &vmstate_mst_fpga_regs;
-}
-
-static const TypeInfo mst_fpga_info = {
-    .name          = TYPE_MAINSTONE_FPGA,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(mst_irq_state),
-    .instance_init = mst_fpga_init,
-    .class_init    = mst_fpga_class_init,
-};
-
-static void mst_fpga_register_types(void)
-{
-    type_register_static(&mst_fpga_info);
-}
-
-type_init(mst_fpga_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 2ca8717be28..56b94655152 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -67,7 +67,6 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx_ccm.c',
   'imx_rngc.c',
 ))
-system_ss.add(when: 'CONFIG_MAINSTONE', if_true: files('mst_fpga.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files(
   'npcm7xx_clk.c',
   'npcm7xx_gcr.c',
-- 
2.34.1


