Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CEDEE499E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMGY-0001ig-AR; Wed, 11 Sep 2024 08:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMGO-0000jL-M3
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:16:03 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMGM-0007Rv-Bh
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:16:00 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a8d0d0aea3cso673119266b.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726056956; x=1726661756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0CfTxtjQXBmzI0CDOG+LMdjpMnlfgUIKoZqJnL/i42k=;
 b=Y93xIz3MmW7rkQglJRHmSR3Ln9rFAN/I8Hg1rR6nWwEmUK5d6Jm+skYsKrrcd4rLuD
 Sq4RDhO6jwIUtMfV7aHq/h6aiWSrdhkWjIWZ7JvIfsC98cPfwGPl5B8vN72+OMDSETqi
 3VSAwWggIzJj96g6uEneo5eJiUnQ6vuazylGpnuPtU1y9kvPNuo1zkYjuBUBic1Ot3J+
 mBdBYiyWxEO51w9bR83kHbRkDu97wzFZZZYZhLbdxDInfBOPCtIp43oGyrQPihdTprnm
 Q1aFQEKI7OzdM+zRRDSulXcqY7ssDz1yBScUL5PpAPCzxvVoD/whh4SJ1KAgEmx9xdn8
 +GEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726056956; x=1726661756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0CfTxtjQXBmzI0CDOG+LMdjpMnlfgUIKoZqJnL/i42k=;
 b=Z4mvpGCIXkPukvn9cxsWywrQ9T+0cGi6Tw/D6vCKQqTl8XZtW7YB5vZ7qiRp40N+cT
 t0G6xjEWBobkcRbTxr9opITSlC+Bno9atXOkHwPuk6pBWP7DFvPVEDjOOYafCSjXWOox
 I0vm1M98BEzL67mxaXeKY+4VheglHVX3bJNcfgyPGbp5+V6zMtm/o7x8P2q3V1/9fu5c
 cLhCS827w0fk6a58G9mc4iu/UTcnQpYXiFpWt7M02eP5de+ekv973nMlteVxSoDEi9ai
 WT9PC7/BxbYlqNKqcXfYjUrubDcpp/jSuWG9gHSmhNc4Mcy5nAdxgKE1KyQvnoEzejdH
 fdiA==
X-Gm-Message-State: AOJu0YxQQPsRf4EPVzMz612tcDsFkovBDdW2/2VEnzzV+4ILPA3KVc1h
 fPivlYKTFtGmbgQbI55+ASSxs4/lYgLf/X2D0TmZ9fk46n4Oell5no/Gsz+Ij5G4VBlJdc2eOm1
 e
X-Google-Smtp-Source: AGHT+IEap6OxGFXEKh1xN9MbxWtP6JGbrVThJKoccc9I4zSR38jL+PaNm9eReF9wfD8nLJktTZ93Sw==
X-Received: by 2002:a17:907:3f27:b0:a7a:b561:3575 with SMTP id
 a640c23a62f3a-a8ffae05028mr423537466b.56.1726056956293; 
 Wed, 11 Sep 2024 05:15:56 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25d5dc74sm605433266b.208.2024.09.11.05.15.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:15:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 13/56] hw/intc: Remove TYPE_ETRAX_FS_PIC device
Date: Wed, 11 Sep 2024 14:13:38 +0200
Message-ID: <20240911121422.52585-14-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

We just removed the single machine using it (axis-dev88).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-ID: <20240904143603.52934-8-philmd@linaro.org>
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


