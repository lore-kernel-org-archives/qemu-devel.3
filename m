Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE50CEACE9
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfup-0005lO-4w; Tue, 01 Oct 2024 12:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuV-0005W9-K5
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:39 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuQ-00063z-Dj
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:39 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42cbc38a997so34985855e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800773; x=1728405573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B3HhM/XJoCTIECwJrQ/qGNjxK1ifjCoLeoXbylAJo74=;
 b=Y87L8hf2mWiW0RlssYt/oSf1j+FXiDL2R3wOxOkxt12TxxHPKofcEeMHKH4tOOIs0Z
 b/kMWzm04GjcGx6EF2ZMahGvxoP6C4abAioD4ItawPZEbELJxE3taa/aoPNN/Rj4YrZU
 aR6X0rD9Ol/6QsRB2Lsq1CXc+gmQzzHx8tqLlfBFKhtwHxkyUNGZaVa+V45V7sNJZ97n
 WNnhHWv51sUSWEoh1TkjoOe6S0UUCbNblGzH9ZKIuql4BLkPTdj+oB0WFzIuweaSIsAU
 iMa27t1Ux7OFtJWAFpnoOC68EaQ698reQWHTK6mggCNl2briHirIxKkZC8N5Jmgy4Ytq
 83fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800773; x=1728405573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B3HhM/XJoCTIECwJrQ/qGNjxK1ifjCoLeoXbylAJo74=;
 b=lYIBzhlXbuH+bQBBJO1raAldJmxiEkDEwmqilUA1vKqKZfCjy/XT+yZqBJixAheU3r
 3RXbPf3buBWk6++WMrHu8W2BPiI05stt1ptP0R8FJdG+JVrjoUp7Pq7x8FGqZxJgMNW0
 KLGDaksFvfhCKn4dkEKB7FEdIyGrxMb8VN2U8fHqgiMKWgmbJFIEmL6UyIe9DafM1fv4
 OcpiCaL5ysze9i3aLF+bAtdqTvwFLRwlsEA3igpRJBYbT4CN+o5+aKxc+d4WDVKFSFNJ
 qOmApwAsn4bUeClt9CtdLDe/F+Ewz2S9UqC/9qqXhLk/QjuR18vReDpOsP21cWzDQsU4
 ikmg==
X-Gm-Message-State: AOJu0Yxbl29NvayCEnJwO7JyD4ABOGEtLCtrb1DpO39Bjrmhh8bDm28B
 7ClU7bQRPPEdFociUa8omRnFiTWpEPJVcllYGfL3tMui/Czy5tZeBQPdKXCfHG9+jtKE741PnNX
 s
X-Google-Smtp-Source: AGHT+IHJCZ2C0HQQtW81cwr2m4+rzKPvwVu46j69+31Zsm9kNSPP1SAUtw2Cx/E0ftb8W08BwAvK4Q==
X-Received: by 2002:a05:600c:1912:b0:42c:b67b:816b with SMTP id
 5b1f17b1804b1-42f71307004mr26604425e9.1.1727800772838; 
 Tue, 01 Oct 2024 09:39:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/54] hw/pcmcia: Remove pxa2xx pcmcia device
Date: Tue,  1 Oct 2024 17:38:48 +0100
Message-Id: <20241001163918.1275441-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Remove the pxa2xx specific pcmcia device.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240903160751.4100218-21-peter.maydell@linaro.org
---
 include/hw/arm/pxa.h  |   8 --
 hw/pcmcia/pxa2xx.c    | 248 ------------------------------------------
 hw/pcmcia/meson.build |   1 -
 3 files changed, 257 deletions(-)
 delete mode 100644 hw/pcmcia/pxa2xx.c

diff --git a/include/hw/arm/pxa.h b/include/hw/arm/pxa.h
index 944926e514b..5f98536bc69 100644
--- a/include/hw/arm/pxa.h
+++ b/include/hw/arm/pxa.h
@@ -76,12 +76,4 @@ DeviceState *pxa2xx_gpio_init(hwaddr base,
                               ARMCPU *cpu, DeviceState *pic, int lines);
 void pxa2xx_gpio_read_notifier(DeviceState *dev, qemu_irq handler);
 
-/* pxa2xx_pcmcia.c */
-#define TYPE_PXA2XX_PCMCIA "pxa2xx-pcmcia"
-OBJECT_DECLARE_SIMPLE_TYPE(PXA2xxPCMCIAState, PXA2XX_PCMCIA)
-
-int pxa2xx_pcmcia_attach(void *opaque, PCMCIACardState *card);
-int pxa2xx_pcmcia_detach(void *opaque);
-void pxa2xx_pcmcia_set_irq_cb(void *opaque, qemu_irq irq, qemu_irq cd_irq);
-
 #endif /* PXA_H */
diff --git a/hw/pcmcia/pxa2xx.c b/hw/pcmcia/pxa2xx.c
deleted file mode 100644
index e3111fdf1a1..00000000000
--- a/hw/pcmcia/pxa2xx.c
+++ /dev/null
@@ -1,248 +0,0 @@
-/*
- * Intel XScale PXA255/270 PC Card and CompactFlash Interface.
- *
- * Copyright (c) 2006 Openedhand Ltd.
- * Written by Andrzej Zaborowski <balrog@zabor.org>
- *
- * This code is licensed under the GPLv2.
- *
- * Contributions after 2012-01-13 are licensed under the terms of the
- * GNU GPL, version 2 or (at your option) any later version.
- */
-
-#include "qemu/osdep.h"
-#include "hw/irq.h"
-#include "hw/sysbus.h"
-#include "qapi/error.h"
-#include "qemu/module.h"
-#include "hw/pcmcia.h"
-#include "hw/arm/pxa.h"
-
-struct PXA2xxPCMCIAState {
-    SysBusDevice parent_obj;
-
-    PCMCIASocket slot;
-    MemoryRegion container_mem;
-    MemoryRegion common_iomem;
-    MemoryRegion attr_iomem;
-    MemoryRegion iomem;
-
-    qemu_irq irq;
-    qemu_irq cd_irq;
-
-    PCMCIACardState *card;
-};
-
-static uint64_t pxa2xx_pcmcia_common_read(void *opaque,
-                hwaddr offset, unsigned size)
-{
-    PXA2xxPCMCIAState *s = (PXA2xxPCMCIAState *) opaque;
-    PCMCIACardClass *pcc;
-
-    if (s->slot.attached) {
-        pcc = PCMCIA_CARD_GET_CLASS(s->card);
-        return pcc->common_read(s->card, offset);
-    }
-
-    return 0;
-}
-
-static void pxa2xx_pcmcia_common_write(void *opaque, hwaddr offset,
-                                       uint64_t value, unsigned size)
-{
-    PXA2xxPCMCIAState *s = (PXA2xxPCMCIAState *) opaque;
-    PCMCIACardClass *pcc;
-
-    if (s->slot.attached) {
-        pcc = PCMCIA_CARD_GET_CLASS(s->card);
-        pcc->common_write(s->card, offset, value);
-    }
-}
-
-static uint64_t pxa2xx_pcmcia_attr_read(void *opaque,
-                hwaddr offset, unsigned size)
-{
-    PXA2xxPCMCIAState *s = (PXA2xxPCMCIAState *) opaque;
-    PCMCIACardClass *pcc;
-
-    if (s->slot.attached) {
-        pcc = PCMCIA_CARD_GET_CLASS(s->card);
-        return pcc->attr_read(s->card, offset);
-    }
-
-    return 0;
-}
-
-static void pxa2xx_pcmcia_attr_write(void *opaque, hwaddr offset,
-                                     uint64_t value, unsigned size)
-{
-    PXA2xxPCMCIAState *s = (PXA2xxPCMCIAState *) opaque;
-    PCMCIACardClass *pcc;
-
-    if (s->slot.attached) {
-        pcc = PCMCIA_CARD_GET_CLASS(s->card);
-        pcc->attr_write(s->card, offset, value);
-    }
-}
-
-static uint64_t pxa2xx_pcmcia_io_read(void *opaque,
-                hwaddr offset, unsigned size)
-{
-    PXA2xxPCMCIAState *s = (PXA2xxPCMCIAState *) opaque;
-    PCMCIACardClass *pcc;
-
-    if (s->slot.attached) {
-        pcc = PCMCIA_CARD_GET_CLASS(s->card);
-        return pcc->io_read(s->card, offset);
-    }
-
-    return 0;
-}
-
-static void pxa2xx_pcmcia_io_write(void *opaque, hwaddr offset,
-                                   uint64_t value, unsigned size)
-{
-    PXA2xxPCMCIAState *s = (PXA2xxPCMCIAState *) opaque;
-    PCMCIACardClass *pcc;
-
-    if (s->slot.attached) {
-        pcc = PCMCIA_CARD_GET_CLASS(s->card);
-        pcc->io_write(s->card, offset, value);
-    }
-}
-
-static const MemoryRegionOps pxa2xx_pcmcia_common_ops = {
-    .read = pxa2xx_pcmcia_common_read,
-    .write = pxa2xx_pcmcia_common_write,
-    .endianness = DEVICE_NATIVE_ENDIAN
-};
-
-static const MemoryRegionOps pxa2xx_pcmcia_attr_ops = {
-    .read = pxa2xx_pcmcia_attr_read,
-    .write = pxa2xx_pcmcia_attr_write,
-    .endianness = DEVICE_NATIVE_ENDIAN
-};
-
-static const MemoryRegionOps pxa2xx_pcmcia_io_ops = {
-    .read = pxa2xx_pcmcia_io_read,
-    .write = pxa2xx_pcmcia_io_write,
-    .endianness = DEVICE_NATIVE_ENDIAN
-};
-
-static void pxa2xx_pcmcia_set_irq(void *opaque, int line, int level)
-{
-    PXA2xxPCMCIAState *s = (PXA2xxPCMCIAState *) opaque;
-    if (!s->irq)
-        return;
-
-    qemu_set_irq(s->irq, level);
-}
-
-static void pxa2xx_pcmcia_initfn(Object *obj)
-{
-    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-    PXA2xxPCMCIAState *s = PXA2XX_PCMCIA(obj);
-
-    memory_region_init(&s->container_mem, obj, "container", 0x10000000);
-    sysbus_init_mmio(sbd, &s->container_mem);
-
-    /* Socket I/O Memory Space */
-    memory_region_init_io(&s->iomem, obj, &pxa2xx_pcmcia_io_ops, s,
-                          "pxa2xx-pcmcia-io", 0x04000000);
-    memory_region_add_subregion(&s->container_mem, 0x00000000,
-                                &s->iomem);
-
-    /* Then next 64 MB is reserved */
-
-    /* Socket Attribute Memory Space */
-    memory_region_init_io(&s->attr_iomem, obj, &pxa2xx_pcmcia_attr_ops, s,
-                          "pxa2xx-pcmcia-attribute", 0x04000000);
-    memory_region_add_subregion(&s->container_mem, 0x08000000,
-                                &s->attr_iomem);
-
-    /* Socket Common Memory Space */
-    memory_region_init_io(&s->common_iomem, obj, &pxa2xx_pcmcia_common_ops, s,
-                          "pxa2xx-pcmcia-common", 0x04000000);
-    memory_region_add_subregion(&s->container_mem, 0x0c000000,
-                                &s->common_iomem);
-
-    s->slot.irq = qemu_allocate_irq(pxa2xx_pcmcia_set_irq, s, 0);
-
-    object_property_add_link(obj, "card", TYPE_PCMCIA_CARD,
-                             (Object **)&s->card,
-                             NULL, /* read-only property */
-                             0);
-}
-
-/* Insert a new card into a slot */
-int pxa2xx_pcmcia_attach(void *opaque, PCMCIACardState *card)
-{
-    PXA2xxPCMCIAState *s = (PXA2xxPCMCIAState *) opaque;
-    PCMCIACardClass *pcc;
-
-    if (s->slot.attached) {
-        return -EEXIST;
-    }
-
-    if (s->cd_irq) {
-        qemu_irq_raise(s->cd_irq);
-    }
-
-    s->card = card;
-    pcc = PCMCIA_CARD_GET_CLASS(s->card);
-
-    s->slot.attached = true;
-    s->card->slot = &s->slot;
-    pcc->attach(s->card);
-
-    return 0;
-}
-
-/* Eject card from the slot */
-int pxa2xx_pcmcia_detach(void *opaque)
-{
-    PXA2xxPCMCIAState *s = (PXA2xxPCMCIAState *) opaque;
-    PCMCIACardClass *pcc;
-
-    if (!s->slot.attached) {
-        return -ENOENT;
-    }
-
-    pcc = PCMCIA_CARD_GET_CLASS(s->card);
-    pcc->detach(s->card);
-    s->card->slot = NULL;
-    s->card = NULL;
-
-    s->slot.attached = false;
-
-    if (s->irq) {
-        qemu_irq_lower(s->irq);
-    }
-    if (s->cd_irq) {
-        qemu_irq_lower(s->cd_irq);
-    }
-
-    return 0;
-}
-
-/* Who to notify on card events */
-void pxa2xx_pcmcia_set_irq_cb(void *opaque, qemu_irq irq, qemu_irq cd_irq)
-{
-    PXA2xxPCMCIAState *s = (PXA2xxPCMCIAState *) opaque;
-    s->irq = irq;
-    s->cd_irq = cd_irq;
-}
-
-static const TypeInfo pxa2xx_pcmcia_type_info = {
-    .name = TYPE_PXA2XX_PCMCIA,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(PXA2xxPCMCIAState),
-    .instance_init = pxa2xx_pcmcia_initfn,
-};
-
-static void pxa2xx_pcmcia_register_types(void)
-{
-    type_register_static(&pxa2xx_pcmcia_type_info);
-}
-
-type_init(pxa2xx_pcmcia_register_types)
diff --git a/hw/pcmcia/meson.build b/hw/pcmcia/meson.build
index 04e29c109c0..edcb7f5d263 100644
--- a/hw/pcmcia/meson.build
+++ b/hw/pcmcia/meson.build
@@ -1,2 +1 @@
 system_ss.add(when: 'CONFIG_PCMCIA', if_true: files('pcmcia.c'))
-system_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx.c'))
-- 
2.34.1


