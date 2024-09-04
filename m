Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EA5CD37B4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 14:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slr8N-0006mt-5W; Wed, 04 Sep 2024 10:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slr8K-0006Q7-Kw
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 10:37:20 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slr8I-0005NL-CZ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 10:37:20 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-374c3400367so3001122f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 07:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725460637; x=1726065437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=reUYcFpvFqro4uRXjaKuE8NgjJEMV1ydTwCE7etUopg=;
 b=ohB9yeVE/IducidJroZnOyLMfhLoEd0yd9YGKWgkgtpr/jteDTa7K89OEkL/F0yIYa
 mLZ3NA3woPUPkEvAary4LS2uq2u11tRwB4MgnRphHJfRI7olppPn9DPtBAQ1FV+2ksis
 8S1FpkQdbXQhywsnt1xJzqRcpMG2UBqlYdhc2gUAA7GKZ/tTy/ZirJLNzzIIdN8cghkW
 ZhDATFueonh/Mnae5Q6GNa0mq67xP+I4K5yoAZH4JJa1kqQErIaaVT9iJ3tqFTLi3NUl
 fxZ/rg41efjQSw6a1RPDXdfgXRwPcHNflcGozXHj5GWC65SBhNeBIRgzVJeg3i8VhCEd
 H3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725460637; x=1726065437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=reUYcFpvFqro4uRXjaKuE8NgjJEMV1ydTwCE7etUopg=;
 b=QkpH4KHNWrajHUTrSYmBwzyzEoAMP+orqotLJqE0omdBVjogRC7HHML/fWkjwMuiAW
 RnbLu57zfuwFyB4nBStNDXdijqD9IT4S1cleJAxhyyzk9XPp5QuOqKeQLu5zQfzYBd4i
 a+XrMNKUeTKTtlYPCvpT222g2aRSLWmNt3FHL5loTNqJiGaH8nn16qFnKtRM/qDaLlBy
 Yo3g87TxEacSA8A+ev5FlUITeUg0lZBuBhejVp59WoEiZwylKk7rdDPc0fsh9tXd5BIZ
 IY8ZcohvoeIvPYMhC+RiyeAWB0LxiIVic+MP6BXiZh/gVQk1LOIRhAU8BUQhl6Lmx+ZR
 9fsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMSv5QUUEPtWnn8w5UygB46X/RT+I3rkq3etkH4oPszW2XqrKt0U8KR1fuKv+cFJ0kaN0q+mHDsGS2@nongnu.org
X-Gm-Message-State: AOJu0YztswKJE/egNBS5sdcwgZJK1oedUbu3KtocFY4eIPGhE26nxPCC
 i/vh6NAYmxgjBcuTUIQpn5ZaG0vVGSyS/eokwuVbjNl/B4R9U3pS7Q5+F3VzxLk=
X-Google-Smtp-Source: AGHT+IGezzOoyhGbkALsLB4HLP7xnCC/1WPV3TWPt9FIxISRPNuzTVhWLXF4ikuxokoMg0/mUTkZIw==
X-Received: by 2002:a5d:6801:0:b0:374:c69b:5a24 with SMTP id
 ffacd0b85a97d-374c69b5b9amr9703472f8f.51.1725460636626; 
 Wed, 04 Sep 2024 07:37:16 -0700 (PDT)
Received: from localhost.localdomain (56.red-95-127-44.staticip.rima-tde.net.
 [95.127.44.56]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374c0f6f4c4sm11715559f8f.44.2024.09.04.07.37.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Sep 2024 07:37:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 07/15] hw/intc: Remove TYPE_ETRAX_FS_PIC device
Date: Wed,  4 Sep 2024 16:35:55 +0200
Message-ID: <20240904143603.52934-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904143603.52934-1-philmd@linaro.org>
References: <20240904143603.52934-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

We just removed the single machine using it (axis-dev88).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/etraxfs_pic.c | 172 ------------------------------------------
 hw/intc/meson.build   |   1 -
 2 files changed, 173 deletions(-)
 delete mode 100644 hw/intc/etraxfs_pic.c

diff --git a/hw/intc/etraxfs_pic.c b/hw/intc/etraxfs_pic.c
deleted file mode 100644
index bd37d1cca0..0000000000
--- a/hw/intc/etraxfs_pic.c
+++ /dev/null
@@ -1,172 +0,0 @@
-/*
- * QEMU ETRAX Interrupt Controller.
- *
- * Copyright (c) 2008 Edgar E. Iglesias, Axis Communications AB.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#include "qemu/osdep.h"
-#include "hw/sysbus.h"
-#include "qemu/module.h"
-#include "hw/irq.h"
-#include "hw/qdev-properties.h"
-#include "qom/object.h"
-
-#define D(x)
-
-#define R_RW_MASK   0
-#define R_R_VECT    1
-#define R_R_MASKED_VECT 2
-#define R_R_NMI     3
-#define R_R_GURU    4
-#define R_MAX       5
-
-#define TYPE_ETRAX_FS_PIC "etraxfs-pic"
-DECLARE_INSTANCE_CHECKER(struct etrax_pic, ETRAX_FS_PIC,
-                         TYPE_ETRAX_FS_PIC)
-
-struct etrax_pic
-{
-    SysBusDevice parent_obj;
-
-    MemoryRegion mmio;
-    qemu_irq parent_irq;
-    qemu_irq parent_nmi;
-    uint32_t regs[R_MAX];
-};
-
-static void pic_update(struct etrax_pic *fs)
-{   
-    uint32_t vector = 0;
-    int i;
-
-    fs->regs[R_R_MASKED_VECT] = fs->regs[R_R_VECT] & fs->regs[R_RW_MASK];
-
-    /* The ETRAX interrupt controller signals interrupts to the core
-       through an interrupt request wire and an irq vector bus. If 
-       multiple interrupts are simultaneously active it chooses vector 
-       0x30 and lets the sw choose the priorities.  */
-    if (fs->regs[R_R_MASKED_VECT]) {
-        uint32_t mv = fs->regs[R_R_MASKED_VECT];
-        for (i = 0; i < 31; i++) {
-            if (mv & 1) {
-                vector = 0x31 + i;
-                /* Check for multiple interrupts.  */
-                if (mv > 1)
-                    vector = 0x30;
-                break;
-            }
-            mv >>= 1;
-        }
-    }
-
-    qemu_set_irq(fs->parent_irq, vector);
-}
-
-static uint64_t
-pic_read(void *opaque, hwaddr addr, unsigned int size)
-{
-    struct etrax_pic *fs = opaque;
-    uint32_t rval;
-
-    rval = fs->regs[addr >> 2];
-    D(printf("%s %x=%x\n", __func__, addr, rval));
-    return rval;
-}
-
-static void pic_write(void *opaque, hwaddr addr,
-                      uint64_t value, unsigned int size)
-{
-    struct etrax_pic *fs = opaque;
-    D(printf("%s addr=%x val=%x\n", __func__, addr, value));
-
-    if (addr == R_RW_MASK) {
-        fs->regs[R_RW_MASK] = value;
-        pic_update(fs);
-    }
-}
-
-static const MemoryRegionOps pic_ops = {
-    .read = pic_read,
-    .write = pic_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid = {
-        .min_access_size = 4,
-        .max_access_size = 4
-    }
-};
-
-static void nmi_handler(void *opaque, int irq, int level)
-{   
-    struct etrax_pic *fs = (void *)opaque;
-    uint32_t mask;
-
-    mask = 1 << irq;
-    if (level)
-        fs->regs[R_R_NMI] |= mask;
-    else
-        fs->regs[R_R_NMI] &= ~mask;
-
-    qemu_set_irq(fs->parent_nmi, !!fs->regs[R_R_NMI]);
-}
-
-static void irq_handler(void *opaque, int irq, int level)
-{
-    struct etrax_pic *fs = (void *)opaque;
-
-    if (irq >= 30) {
-        nmi_handler(opaque, irq, level);
-        return;
-    }
-
-    irq -= 1;
-    fs->regs[R_R_VECT] &= ~(1 << irq);
-    fs->regs[R_R_VECT] |= (!!level << irq);
-    pic_update(fs);
-}
-
-static void etraxfs_pic_init(Object *obj)
-{
-    DeviceState *dev = DEVICE(obj);
-    struct etrax_pic *s = ETRAX_FS_PIC(obj);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-
-    qdev_init_gpio_in(dev, irq_handler, 32);
-    sysbus_init_irq(sbd, &s->parent_irq);
-    sysbus_init_irq(sbd, &s->parent_nmi);
-
-    memory_region_init_io(&s->mmio, obj, &pic_ops, s,
-                          "etraxfs-pic", R_MAX * 4);
-    sysbus_init_mmio(sbd, &s->mmio);
-}
-
-static const TypeInfo etraxfs_pic_info = {
-    .name          = TYPE_ETRAX_FS_PIC,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(struct etrax_pic),
-    .instance_init = etraxfs_pic_init,
-};
-
-static void etraxfs_pic_register_types(void)
-{
-    type_register_static(&etraxfs_pic_info);
-}
-
-type_init(etraxfs_pic_register_types)
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index f4d81eb8e4..6bfdc4eb33 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -15,7 +15,6 @@ system_ss.add(when: 'CONFIG_ARM_GICV3_TCG', if_true: files(
 system_ss.add(when: 'CONFIG_ALLWINNER_A10_PIC', if_true: files('allwinner-a10-pic.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_vic.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_intc.c'))
-system_ss.add(when: 'CONFIG_ETRAXFS', if_true: files('etraxfs_pic.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_gic.c', 'exynos4210_combiner.c'))
 system_ss.add(when: 'CONFIG_GOLDFISH_PIC', if_true: files('goldfish_pic.c'))
 system_ss.add(when: 'CONFIG_HEATHROW_PIC', if_true: files('heathrow_pic.c'))
-- 
2.45.2


