Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222DACD379F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slW5Z-0001LG-1V; Tue, 03 Sep 2024 12:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW5U-0000pw-9l
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:09:00 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW5P-0002vk-Ul
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:09:00 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42c7a49152aso36171775e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725379734; x=1725984534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DBc/bJy+JM7lDQDRwxqLPG14xFZM1slW+0SGy2bjs2k=;
 b=Kab+6SPql0RnCcKZUjgmSa0mDb/ukAGx/SNmovemAAX4uadp3IYPiTNOFtL+ymMtQF
 JHvHWTIZnCxHe7OqoTWLgnOxA3RtZoqk62xv0IUPXqVSoYENLRtadgyr1V+dT/Y8FKkC
 AszI+YDfIe7+iEOli7+uBRAGUay54urn+Fw3+uPEe84J9dris+ifq4D2Iw0z1jeGBB3z
 YqYTTzjknCpd4lSoUTjyZeC60DDzgRcwBNlhMln6C5swVkMN2m7arpyMIa8UlLl0ndsa
 y7AL2dbntX6A8y0SExc9B3wBxDUDQpATmvDiSslxo55+KQMvzHwNPW+/Bu23COvEdzlH
 Wgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725379734; x=1725984534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DBc/bJy+JM7lDQDRwxqLPG14xFZM1slW+0SGy2bjs2k=;
 b=ErSNJbmhXRL1F/m64BWGRiNRQ+sO+GGLca91wPiVZINDqq45jJXeW9skXg0KcuBpH+
 Uz0/dUamRvKx3w/iw1tYhrCwFRSYsDK1+dART5+HIEve7bxCqxbFiDy54F5/1yjCtUIr
 3qDM0s6C5yB1m/OghGRNV3t5oO3SfDAXzTQqQvo7iFqay7x8ODl113W0WuLn5prdZDvM
 KLLuzxATGlq9zXSfdZY7eJQmX+EBR8vXziMPu3dW2J58I9DIOiwtSvKmc6ovSgBTEpSv
 J/tRQmpOQ+ohf7x7W6OBpQh4VwA5Pb/l+3joUE4+rAAAd0XgJxZvfOl56YE5Xo5sre+m
 FDsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiHmonX3JeTR+83gTjZOh1ulU+s0tNxhq3tmc6Q+yv2I1i7eT5Fq0plVpf//DQpOqTS0tm25ukCJzF@nongnu.org
X-Gm-Message-State: AOJu0YzH/EBDPTN1ULpggkaNX7ndgKBhBGF1AJjSoYBAoAiwOdvMw+4k
 lmMFml0Y2LCVgBa4aZb2Wi4qNzUQgzOYKqKf9stKCPZsHiuPtHh2U2YX+0qv7ao=
X-Google-Smtp-Source: AGHT+IGVLC7oZTaQNZ1zgMcusgInMSTnHktRIpj32Nj3Yqz6jgtY79H6CRWfklLBGC7/IvlBk873eQ==
X-Received: by 2002:a05:600c:4586:b0:426:61fc:fc1a with SMTP id
 5b1f17b1804b1-42bb01ae2a7mr162606245e9.3.1725379734319; 
 Tue, 03 Sep 2024 09:08:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df1066sm175123065e9.18.2024.09.03.09.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:08:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-9.2 40/53] hw/intc: Remove omap2-intc device
Date: Tue,  3 Sep 2024 17:07:38 +0100
Message-Id: <20240903160751.4100218-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903160751.4100218-1-peter.maydell@linaro.org>
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Remove the OMAP2 specific code from omap_intc.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/omap_intc.c | 276 --------------------------------------------
 1 file changed, 276 deletions(-)

diff --git a/hw/intc/omap_intc.c b/hw/intc/omap_intc.c
index 435c47600fc..c14b22d3819 100644
--- a/hw/intc/omap_intc.c
+++ b/hw/intc/omap_intc.c
@@ -50,8 +50,6 @@ struct OMAPIntcState {
     int level_only;
     uint32_t size;
 
-    uint8_t revision;
-
     /* state */
     uint32_t new_agr[2];
     int sir_intr[2];
@@ -133,26 +131,6 @@ static void omap_set_intr(void *opaque, int irq, int req)
     }
 }
 
-/* Simplified version with no edge detection */
-static void omap_set_intr_noedge(void *opaque, int irq, int req)
-{
-    OMAPIntcState *ih = opaque;
-    uint32_t rise;
-
-    struct omap_intr_handler_bank_s *bank = &ih->bank[irq >> 5];
-    int n = irq & 31;
-
-    if (req) {
-        rise = ~bank->inputs & (1 << n);
-        if (rise) {
-            bank->irqs |= bank->inputs |= rise;
-            omap_inth_update(ih, 0);
-            omap_inth_update(ih, 1);
-        }
-    } else
-        bank->irqs = (bank->inputs &= ~(1 << n)) | bank->swi;
-}
-
 static uint64_t omap_inth_read(void *opaque, hwaddr addr,
                                unsigned size)
 {
@@ -420,259 +398,6 @@ static const TypeInfo omap_intc_info = {
     .class_init    = omap_intc_class_init,
 };
 
-static uint64_t omap2_inth_read(void *opaque, hwaddr addr,
-                                unsigned size)
-{
-    OMAPIntcState *s = opaque;
-    int offset = addr;
-    int bank_no, line_no;
-    struct omap_intr_handler_bank_s *bank = NULL;
-
-    if ((offset & 0xf80) == 0x80) {
-        bank_no = (offset & 0x60) >> 5;
-        if (bank_no < s->nbanks) {
-            offset &= ~0x60;
-            bank = &s->bank[bank_no];
-        } else {
-            OMAP_BAD_REG(addr);
-            return 0;
-        }
-    }
-
-    switch (offset) {
-    case 0x00:	/* INTC_REVISION */
-        return s->revision;
-
-    case 0x10:	/* INTC_SYSCONFIG */
-        return (s->autoidle >> 2) & 1;
-
-    case 0x14:	/* INTC_SYSSTATUS */
-        return 1;						/* RESETDONE */
-
-    case 0x40:	/* INTC_SIR_IRQ */
-        return s->sir_intr[0];
-
-    case 0x44:	/* INTC_SIR_FIQ */
-        return s->sir_intr[1];
-
-    case 0x48:	/* INTC_CONTROL */
-        return (!s->mask) << 2;					/* GLOBALMASK */
-
-    case 0x4c:	/* INTC_PROTECTION */
-        return 0;
-
-    case 0x50:	/* INTC_IDLE */
-        return s->autoidle & 3;
-
-    /* Per-bank registers */
-    case 0x80:	/* INTC_ITR */
-        return bank->inputs;
-
-    case 0x84:	/* INTC_MIR */
-        return bank->mask;
-
-    case 0x88:	/* INTC_MIR_CLEAR */
-    case 0x8c:	/* INTC_MIR_SET */
-        return 0;
-
-    case 0x90:	/* INTC_ISR_SET */
-        return bank->swi;
-
-    case 0x94:	/* INTC_ISR_CLEAR */
-        return 0;
-
-    case 0x98:	/* INTC_PENDING_IRQ */
-        return bank->irqs & ~bank->mask & ~bank->fiq;
-
-    case 0x9c:	/* INTC_PENDING_FIQ */
-        return bank->irqs & ~bank->mask & bank->fiq;
-
-    /* Per-line registers */
-    case 0x100 ... 0x300:	/* INTC_ILR */
-        bank_no = (offset - 0x100) >> 7;
-        if (bank_no > s->nbanks)
-            break;
-        bank = &s->bank[bank_no];
-        line_no = (offset & 0x7f) >> 2;
-        return (bank->priority[line_no] << 2) |
-                ((bank->fiq >> line_no) & 1);
-    }
-    OMAP_BAD_REG(addr);
-    return 0;
-}
-
-static void omap2_inth_write(void *opaque, hwaddr addr,
-                             uint64_t value, unsigned size)
-{
-    OMAPIntcState *s = opaque;
-    int offset = addr;
-    int bank_no, line_no;
-    struct omap_intr_handler_bank_s *bank = NULL;
-
-    if ((offset & 0xf80) == 0x80) {
-        bank_no = (offset & 0x60) >> 5;
-        if (bank_no < s->nbanks) {
-            offset &= ~0x60;
-            bank = &s->bank[bank_no];
-        } else {
-            OMAP_BAD_REG(addr);
-            return;
-        }
-    }
-
-    switch (offset) {
-    case 0x10:	/* INTC_SYSCONFIG */
-        s->autoidle &= 4;
-        s->autoidle |= (value & 1) << 2;
-        if (value & 2) {                                        /* SOFTRESET */
-            omap_inth_reset(DEVICE(s));
-        }
-        return;
-
-    case 0x48:	/* INTC_CONTROL */
-        s->mask = (value & 4) ? 0 : ~0;				/* GLOBALMASK */
-        if (value & 2) {					/* NEWFIQAGR */
-            qemu_set_irq(s->parent_intr[1], 0);
-            s->new_agr[1] = ~0;
-            omap_inth_update(s, 1);
-        }
-        if (value & 1) {					/* NEWIRQAGR */
-            qemu_set_irq(s->parent_intr[0], 0);
-            s->new_agr[0] = ~0;
-            omap_inth_update(s, 0);
-        }
-        return;
-
-    case 0x4c:	/* INTC_PROTECTION */
-        /* TODO: Make a bitmap (or sizeof(char)map) of access privileges
-         * for every register, see Chapter 3 and 4 for privileged mode.  */
-        if (value & 1)
-            fprintf(stderr, "%s: protection mode enable attempt\n",
-                            __func__);
-        return;
-
-    case 0x50:	/* INTC_IDLE */
-        s->autoidle &= ~3;
-        s->autoidle |= value & 3;
-        return;
-
-    /* Per-bank registers */
-    case 0x84:	/* INTC_MIR */
-        bank->mask = value;
-        omap_inth_update(s, 0);
-        omap_inth_update(s, 1);
-        return;
-
-    case 0x88:	/* INTC_MIR_CLEAR */
-        bank->mask &= ~value;
-        omap_inth_update(s, 0);
-        omap_inth_update(s, 1);
-        return;
-
-    case 0x8c:	/* INTC_MIR_SET */
-        bank->mask |= value;
-        return;
-
-    case 0x90:	/* INTC_ISR_SET */
-        bank->irqs |= bank->swi |= value;
-        omap_inth_update(s, 0);
-        omap_inth_update(s, 1);
-        return;
-
-    case 0x94:	/* INTC_ISR_CLEAR */
-        bank->swi &= ~value;
-        bank->irqs = bank->swi & bank->inputs;
-        return;
-
-    /* Per-line registers */
-    case 0x100 ... 0x300:	/* INTC_ILR */
-        bank_no = (offset - 0x100) >> 7;
-        if (bank_no > s->nbanks)
-            break;
-        bank = &s->bank[bank_no];
-        line_no = (offset & 0x7f) >> 2;
-        bank->priority[line_no] = (value >> 2) & 0x3f;
-        bank->fiq &= ~(1 << line_no);
-        bank->fiq |= (value & 1) << line_no;
-        return;
-
-    case 0x00:	/* INTC_REVISION */
-    case 0x14:	/* INTC_SYSSTATUS */
-    case 0x40:	/* INTC_SIR_IRQ */
-    case 0x44:	/* INTC_SIR_FIQ */
-    case 0x80:	/* INTC_ITR */
-    case 0x98:	/* INTC_PENDING_IRQ */
-    case 0x9c:	/* INTC_PENDING_FIQ */
-        OMAP_RO_REG(addr);
-        return;
-    }
-    OMAP_BAD_REG(addr);
-}
-
-static const MemoryRegionOps omap2_inth_mem_ops = {
-    .read = omap2_inth_read,
-    .write = omap2_inth_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid = {
-        .min_access_size = 4,
-        .max_access_size = 4,
-    },
-};
-
-static void omap2_intc_init(Object *obj)
-{
-    DeviceState *dev = DEVICE(obj);
-    OMAPIntcState *s = OMAP_INTC(obj);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-
-    s->level_only = 1;
-    s->nbanks = 3;
-    sysbus_init_irq(sbd, &s->parent_intr[0]);
-    sysbus_init_irq(sbd, &s->parent_intr[1]);
-    qdev_init_gpio_in(dev, omap_set_intr_noedge, s->nbanks * 32);
-    memory_region_init_io(&s->mmio, obj, &omap2_inth_mem_ops, s,
-                          "omap2-intc", 0x1000);
-    sysbus_init_mmio(sbd, &s->mmio);
-}
-
-static void omap2_intc_realize(DeviceState *dev, Error **errp)
-{
-    OMAPIntcState *s = OMAP_INTC(dev);
-
-    if (!s->iclk) {
-        error_setg(errp, "omap2-intc: iclk not connected");
-        return;
-    }
-    if (!s->fclk) {
-        error_setg(errp, "omap2-intc: fclk not connected");
-        return;
-    }
-}
-
-static Property omap2_intc_properties[] = {
-    DEFINE_PROP_UINT8("revision", OMAPIntcState,
-    revision, 0x21),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void omap2_intc_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->reset = omap_inth_reset;
-    device_class_set_props(dc, omap2_intc_properties);
-    /* Reason: pointer property "iclk", "fclk" */
-    dc->user_creatable = false;
-    dc->realize = omap2_intc_realize;
-}
-
-static const TypeInfo omap2_intc_info = {
-    .name          = "omap2-intc",
-    .parent        = TYPE_OMAP_INTC,
-    .instance_init = omap2_intc_init,
-    .class_init    = omap2_intc_class_init,
-};
-
 static const TypeInfo omap_intc_type_info = {
     .name          = TYPE_OMAP_INTC,
     .parent        = TYPE_SYS_BUS_DEVICE,
@@ -684,7 +409,6 @@ static void omap_intc_register_types(void)
 {
     type_register_static(&omap_intc_type_info);
     type_register_static(&omap_intc_info);
-    type_register_static(&omap2_intc_info);
 }
 
 type_init(omap_intc_register_types)
-- 
2.34.1


