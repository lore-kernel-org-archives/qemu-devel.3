Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF44CEACE7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfuv-0005zE-D6; Tue, 01 Oct 2024 12:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfug-0005bP-K4
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:52 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuZ-00068Y-Ob
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:50 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-37cc810ce73so3343519f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800782; x=1728405582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tfg4KrY9qV5phch4jlAxFrVvFBQbI4YOGlV/cP6p8eY=;
 b=vTOBB/UA04gwZqJtSfCWU/V/N+2Znee2Mp1QciErZi+itfiLfmOpUlaEWxT1A7BJaG
 pBSzwEgd2shKzlJ987AAQjpRnnv3xIacOhPJM5rtGsG8ntNS8r1+al7ydbk1SaFNsfVJ
 DAGFrhISLQuQ5dmzGqHqkb4l71Mdl+nGlFu36wKRVl0qKfPLpFJG3160L+QYo99LkgCm
 bGUHOLEhgbkzdLe20aHob/+2B0cwtc4kfAXOC7Anstj3jfV1d23rx9ZvI8oHEWOWssa1
 bFbKyAjZjQ2CMEMe0ieRkmcv5yeXw2YOfmwQ0x5Xr2Y06lntyFHksmfwMObdxJYq25Xe
 2jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800782; x=1728405582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tfg4KrY9qV5phch4jlAxFrVvFBQbI4YOGlV/cP6p8eY=;
 b=va1Mf3SxTop6AJY1kw0d1g1ujbg8eJKxuj5AyxpSLguW9XAJvhEAzZVUn8ViJmcXk3
 u+808EpkHDJ2xsqnJUysuRxYCZ2UL6JxgdOO55dPho1HF7+1i3SgUydHqDwkE5HLJPb+
 30iql3dZ27dH3FxgWxDKpFn/y3pwdU+fdaPib/dmPoEQCZ6aCS1HXWVOkrF7hNKKPoBp
 3msCa3mKc4UMTI+HyO7rTxlHXYfryWy4Gg53/LYdI3OU13pz6ndbY8DfXelGNbt4Pkni
 VxRMtQHqbKEDWyNojy3gbiILX0GHDlqdchO5PpmbTHIq1AsUljiIfwJWEinnwyFvvcf9
 IoLw==
X-Gm-Message-State: AOJu0Ywy4s4UwJbdxLwqs5rjM3UrA2mjgWPIrUpc2Wk9FxNrLl6rATUP
 FL5Mi8ybZLjPvxilvfQY9iwuUpY0hrx1tDW76pJ7vzlEqJrvKbtsQWsFOgdVYIiX0yEBlqarHxU
 Z
X-Google-Smtp-Source: AGHT+IEy5Z7nAbUk6E0LS2M41PrbfipQ4fUpMdZP2d/inxHf55SNY/Gc2Qr+QFqIFvzfYr0wdE7TBw==
X-Received: by 2002:a5d:4a89:0:b0:371:82ec:206f with SMTP id
 ffacd0b85a97d-37cfb8b6274mr144436f8f.16.1727800782129; 
 Tue, 01 Oct 2024 09:39:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/54] hw/gpio: Remove TYPE_OMAP2_GPIO
Date: Tue,  1 Oct 2024 17:39:04 +0100
Message-Id: <20241001163918.1275441-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

We've removed the OMAP2 SoC, so we can remove the OMAP2 GPIO
device. (The source file remains, as it also has the model of
the OMAP1 GPIO device.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240903160751.4100218-39-peter.maydell@linaro.org
---
 include/hw/arm/omap.h |   8 -
 hw/gpio/omap_gpio.c   | 557 ------------------------------------------
 2 files changed, 565 deletions(-)

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index e3f50b4ab13..b569580b09e 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -105,17 +105,9 @@ typedef struct Omap1GpioState Omap1GpioState;
 DECLARE_INSTANCE_CHECKER(Omap1GpioState, OMAP1_GPIO,
                          TYPE_OMAP1_GPIO)
 
-#define TYPE_OMAP2_GPIO "omap2-gpio"
-typedef struct Omap2GpioState Omap2GpioState;
-DECLARE_INSTANCE_CHECKER(Omap2GpioState, OMAP2_GPIO,
-                         TYPE_OMAP2_GPIO)
-
 /* TODO: clock framework (see above) */
 void omap_gpio_set_clk(Omap1GpioState *gpio, omap_clk clk);
 
-void omap2_gpio_set_iclk(Omap2GpioState *gpio, omap_clk clk);
-void omap2_gpio_set_fclk(Omap2GpioState *gpio, uint8_t i, omap_clk clk);
-
 /* OMAP2 l4 Interconnect */
 struct omap_l4_s;
 struct omap_l4_region_s {
diff --git a/hw/gpio/omap_gpio.c b/hw/gpio/omap_gpio.c
index 77c90f9a0d3..a47a2167a67 100644
--- a/hw/gpio/omap_gpio.c
+++ b/hw/gpio/omap_gpio.c
@@ -190,408 +190,6 @@ static void omap_gpio_reset(struct omap_gpio_s *s)
     s->pins = ~0;
 }
 
-struct omap2_gpio_s {
-    qemu_irq irq[2];
-    qemu_irq wkup;
-    qemu_irq *handler;
-    MemoryRegion iomem;
-
-    uint8_t revision;
-    uint8_t config[2];
-    uint32_t inputs;
-    uint32_t outputs;
-    uint32_t dir;
-    uint32_t level[2];
-    uint32_t edge[2];
-    uint32_t mask[2];
-    uint32_t wumask;
-    uint32_t ints[2];
-    uint32_t debounce;
-    uint8_t delay;
-};
-
-struct Omap2GpioState {
-    SysBusDevice parent_obj;
-
-    MemoryRegion iomem;
-    int mpu_model;
-    void *iclk;
-    void *fclk[6];
-    int modulecount;
-    struct omap2_gpio_s *modules;
-    qemu_irq *handler;
-    int autoidle;
-    int gpo;
-};
-
-/* General-Purpose Interface of OMAP2/3 */
-static inline void omap2_gpio_module_int_update(struct omap2_gpio_s *s,
-                                                int line)
-{
-    qemu_set_irq(s->irq[line], s->ints[line] & s->mask[line]);
-}
-
-static void omap2_gpio_module_wake(struct omap2_gpio_s *s, int line)
-{
-    if (!(s->config[0] & (1 << 2)))			/* ENAWAKEUP */
-        return;
-    if (!(s->config[0] & (3 << 3)))			/* Force Idle */
-        return;
-    if (!(s->wumask & (1 << line)))
-        return;
-
-    qemu_irq_raise(s->wkup);
-}
-
-static inline void omap2_gpio_module_out_update(struct omap2_gpio_s *s,
-                uint32_t diff)
-{
-    int ln;
-
-    s->outputs ^= diff;
-    diff &= ~s->dir;
-    while ((ln = ctz32(diff)) != 32) {
-        qemu_set_irq(s->handler[ln], (s->outputs >> ln) & 1);
-        diff &= ~(1 << ln);
-    }
-}
-
-static void omap2_gpio_module_level_update(struct omap2_gpio_s *s, int line)
-{
-    s->ints[line] |= s->dir &
-            ((s->inputs & s->level[1]) | (~s->inputs & s->level[0]));
-    omap2_gpio_module_int_update(s, line);
-}
-
-static inline void omap2_gpio_module_int(struct omap2_gpio_s *s, int line)
-{
-    s->ints[0] |= 1 << line;
-    omap2_gpio_module_int_update(s, 0);
-    s->ints[1] |= 1 << line;
-    omap2_gpio_module_int_update(s, 1);
-    omap2_gpio_module_wake(s, line);
-}
-
-static void omap2_gpio_set(void *opaque, int line, int level)
-{
-    Omap2GpioState *p = opaque;
-    struct omap2_gpio_s *s = &p->modules[line >> 5];
-
-    line &= 31;
-    if (level) {
-        if (s->dir & (1 << line) & ((~s->inputs & s->edge[0]) | s->level[1]))
-            omap2_gpio_module_int(s, line);
-        s->inputs |= 1 << line;
-    } else {
-        if (s->dir & (1 << line) & ((s->inputs & s->edge[1]) | s->level[0]))
-            omap2_gpio_module_int(s, line);
-        s->inputs &= ~(1 << line);
-    }
-}
-
-static void omap2_gpio_module_reset(struct omap2_gpio_s *s)
-{
-    s->config[0] = 0;
-    s->config[1] = 2;
-    s->ints[0] = 0;
-    s->ints[1] = 0;
-    s->mask[0] = 0;
-    s->mask[1] = 0;
-    s->wumask = 0;
-    s->dir = ~0;
-    s->level[0] = 0;
-    s->level[1] = 0;
-    s->edge[0] = 0;
-    s->edge[1] = 0;
-    s->debounce = 0;
-    s->delay = 0;
-}
-
-static uint32_t omap2_gpio_module_read(void *opaque, hwaddr addr)
-{
-    struct omap2_gpio_s *s = opaque;
-
-    switch (addr) {
-    case 0x00:	/* GPIO_REVISION */
-        return s->revision;
-
-    case 0x10:	/* GPIO_SYSCONFIG */
-        return s->config[0];
-
-    case 0x14:	/* GPIO_SYSSTATUS */
-        return 0x01;
-
-    case 0x18:	/* GPIO_IRQSTATUS1 */
-        return s->ints[0];
-
-    case 0x1c:	/* GPIO_IRQENABLE1 */
-    case 0x60:	/* GPIO_CLEARIRQENABLE1 */
-    case 0x64:	/* GPIO_SETIRQENABLE1 */
-        return s->mask[0];
-
-    case 0x20:	/* GPIO_WAKEUPENABLE */
-    case 0x80:	/* GPIO_CLEARWKUENA */
-    case 0x84:	/* GPIO_SETWKUENA */
-        return s->wumask;
-
-    case 0x28:	/* GPIO_IRQSTATUS2 */
-        return s->ints[1];
-
-    case 0x2c:	/* GPIO_IRQENABLE2 */
-    case 0x70:	/* GPIO_CLEARIRQENABLE2 */
-    case 0x74:	/* GPIO_SETIREQNEABLE2 */
-        return s->mask[1];
-
-    case 0x30:	/* GPIO_CTRL */
-        return s->config[1];
-
-    case 0x34:	/* GPIO_OE */
-        return s->dir;
-
-    case 0x38:	/* GPIO_DATAIN */
-        return s->inputs;
-
-    case 0x3c:	/* GPIO_DATAOUT */
-    case 0x90:	/* GPIO_CLEARDATAOUT */
-    case 0x94:	/* GPIO_SETDATAOUT */
-        return s->outputs;
-
-    case 0x40:	/* GPIO_LEVELDETECT0 */
-        return s->level[0];
-
-    case 0x44:	/* GPIO_LEVELDETECT1 */
-        return s->level[1];
-
-    case 0x48:	/* GPIO_RISINGDETECT */
-        return s->edge[0];
-
-    case 0x4c:	/* GPIO_FALLINGDETECT */
-        return s->edge[1];
-
-    case 0x50:	/* GPIO_DEBOUNCENABLE */
-        return s->debounce;
-
-    case 0x54:	/* GPIO_DEBOUNCINGTIME */
-        return s->delay;
-    }
-
-    OMAP_BAD_REG(addr);
-    return 0;
-}
-
-static void omap2_gpio_module_write(void *opaque, hwaddr addr,
-                uint32_t value)
-{
-    struct omap2_gpio_s *s = opaque;
-    uint32_t diff;
-    int ln;
-
-    switch (addr) {
-    case 0x00:	/* GPIO_REVISION */
-    case 0x14:	/* GPIO_SYSSTATUS */
-    case 0x38:	/* GPIO_DATAIN */
-        OMAP_RO_REG(addr);
-        break;
-
-    case 0x10:	/* GPIO_SYSCONFIG */
-        if (((value >> 3) & 3) == 3) {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "%s: Illegal IDLEMODE value: 3\n", __func__);
-        }
-        if (value & 2)
-            omap2_gpio_module_reset(s);
-        s->config[0] = value & 0x1d;
-        break;
-
-    case 0x18:	/* GPIO_IRQSTATUS1 */
-        if (s->ints[0] & value) {
-            s->ints[0] &= ~value;
-            omap2_gpio_module_level_update(s, 0);
-        }
-        break;
-
-    case 0x1c:	/* GPIO_IRQENABLE1 */
-        s->mask[0] = value;
-        omap2_gpio_module_int_update(s, 0);
-        break;
-
-    case 0x20:	/* GPIO_WAKEUPENABLE */
-        s->wumask = value;
-        break;
-
-    case 0x28:	/* GPIO_IRQSTATUS2 */
-        if (s->ints[1] & value) {
-            s->ints[1] &= ~value;
-            omap2_gpio_module_level_update(s, 1);
-        }
-        break;
-
-    case 0x2c:	/* GPIO_IRQENABLE2 */
-        s->mask[1] = value;
-        omap2_gpio_module_int_update(s, 1);
-        break;
-
-    case 0x30:	/* GPIO_CTRL */
-        s->config[1] = value & 7;
-        break;
-
-    case 0x34:	/* GPIO_OE */
-        diff = s->outputs & (s->dir ^ value);
-        s->dir = value;
-
-        value = s->outputs & ~s->dir;
-        while ((ln = ctz32(diff)) != 32) {
-            diff &= ~(1 << ln);
-            qemu_set_irq(s->handler[ln], (value >> ln) & 1);
-        }
-
-        omap2_gpio_module_level_update(s, 0);
-        omap2_gpio_module_level_update(s, 1);
-        break;
-
-    case 0x3c:	/* GPIO_DATAOUT */
-        omap2_gpio_module_out_update(s, s->outputs ^ value);
-        break;
-
-    case 0x40:	/* GPIO_LEVELDETECT0 */
-        s->level[0] = value;
-        omap2_gpio_module_level_update(s, 0);
-        omap2_gpio_module_level_update(s, 1);
-        break;
-
-    case 0x44:	/* GPIO_LEVELDETECT1 */
-        s->level[1] = value;
-        omap2_gpio_module_level_update(s, 0);
-        omap2_gpio_module_level_update(s, 1);
-        break;
-
-    case 0x48:	/* GPIO_RISINGDETECT */
-        s->edge[0] = value;
-        break;
-
-    case 0x4c:	/* GPIO_FALLINGDETECT */
-        s->edge[1] = value;
-        break;
-
-    case 0x50:	/* GPIO_DEBOUNCENABLE */
-        s->debounce = value;
-        break;
-
-    case 0x54:	/* GPIO_DEBOUNCINGTIME */
-        s->delay = value;
-        break;
-
-    case 0x60:	/* GPIO_CLEARIRQENABLE1 */
-        s->mask[0] &= ~value;
-        omap2_gpio_module_int_update(s, 0);
-        break;
-
-    case 0x64:	/* GPIO_SETIRQENABLE1 */
-        s->mask[0] |= value;
-        omap2_gpio_module_int_update(s, 0);
-        break;
-
-    case 0x70:	/* GPIO_CLEARIRQENABLE2 */
-        s->mask[1] &= ~value;
-        omap2_gpio_module_int_update(s, 1);
-        break;
-
-    case 0x74:	/* GPIO_SETIREQNEABLE2 */
-        s->mask[1] |= value;
-        omap2_gpio_module_int_update(s, 1);
-        break;
-
-    case 0x80:	/* GPIO_CLEARWKUENA */
-        s->wumask &= ~value;
-        break;
-
-    case 0x84:	/* GPIO_SETWKUENA */
-        s->wumask |= value;
-        break;
-
-    case 0x90:	/* GPIO_CLEARDATAOUT */
-        omap2_gpio_module_out_update(s, s->outputs & value);
-        break;
-
-    case 0x94:	/* GPIO_SETDATAOUT */
-        omap2_gpio_module_out_update(s, ~s->outputs & value);
-        break;
-
-    default:
-        OMAP_BAD_REG(addr);
-        return;
-    }
-}
-
-static uint64_t omap2_gpio_module_readp(void *opaque, hwaddr addr,
-                                        unsigned size)
-{
-    return omap2_gpio_module_read(opaque, addr & ~3) >> ((addr & 3) << 3);
-}
-
-static void omap2_gpio_module_writep(void *opaque, hwaddr addr,
-                                     uint64_t value, unsigned size)
-{
-    uint32_t cur = 0;
-    uint32_t mask = 0xffff;
-
-    if (size == 4) {
-        omap2_gpio_module_write(opaque, addr, value);
-        return;
-    }
-
-    switch (addr & ~3) {
-    case 0x00:	/* GPIO_REVISION */
-    case 0x14:	/* GPIO_SYSSTATUS */
-    case 0x38:	/* GPIO_DATAIN */
-        OMAP_RO_REG(addr);
-        break;
-
-    case 0x10:	/* GPIO_SYSCONFIG */
-    case 0x1c:	/* GPIO_IRQENABLE1 */
-    case 0x20:	/* GPIO_WAKEUPENABLE */
-    case 0x2c:	/* GPIO_IRQENABLE2 */
-    case 0x30:	/* GPIO_CTRL */
-    case 0x34:	/* GPIO_OE */
-    case 0x3c:	/* GPIO_DATAOUT */
-    case 0x40:	/* GPIO_LEVELDETECT0 */
-    case 0x44:	/* GPIO_LEVELDETECT1 */
-    case 0x48:	/* GPIO_RISINGDETECT */
-    case 0x4c:	/* GPIO_FALLINGDETECT */
-    case 0x50:	/* GPIO_DEBOUNCENABLE */
-    case 0x54:	/* GPIO_DEBOUNCINGTIME */
-        cur = omap2_gpio_module_read(opaque, addr & ~3) &
-                ~(mask << ((addr & 3) << 3));
-
-        /* Fall through.  */
-    case 0x18:	/* GPIO_IRQSTATUS1 */
-    case 0x28:	/* GPIO_IRQSTATUS2 */
-    case 0x60:	/* GPIO_CLEARIRQENABLE1 */
-    case 0x64:	/* GPIO_SETIRQENABLE1 */
-    case 0x70:	/* GPIO_CLEARIRQENABLE2 */
-    case 0x74:	/* GPIO_SETIREQNEABLE2 */
-    case 0x80:	/* GPIO_CLEARWKUENA */
-    case 0x84:	/* GPIO_SETWKUENA */
-    case 0x90:	/* GPIO_CLEARDATAOUT */
-    case 0x94:	/* GPIO_SETDATAOUT */
-        value <<= (addr & 3) << 3;
-        omap2_gpio_module_write(opaque, addr, cur | value);
-        break;
-
-    default:
-        OMAP_BAD_REG(addr);
-        return;
-    }
-}
-
-static const MemoryRegionOps omap2_gpio_module_ops = {
-    .read = omap2_gpio_module_readp,
-    .write = omap2_gpio_module_writep,
-    .valid.min_access_size = 1,
-    .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
 static void omap_gpif_reset(DeviceState *dev)
 {
     Omap1GpioState *s = OMAP1_GPIO(dev);
@@ -599,81 +197,6 @@ static void omap_gpif_reset(DeviceState *dev)
     omap_gpio_reset(&s->omap1);
 }
 
-static void omap2_gpif_reset(DeviceState *dev)
-{
-    Omap2GpioState *s = OMAP2_GPIO(dev);
-    int i;
-
-    for (i = 0; i < s->modulecount; i++) {
-        omap2_gpio_module_reset(&s->modules[i]);
-    }
-    s->autoidle = 0;
-    s->gpo = 0;
-}
-
-static uint64_t omap2_gpif_top_read(void *opaque, hwaddr addr, unsigned size)
-{
-    Omap2GpioState *s = opaque;
-
-    switch (addr) {
-    case 0x00:	/* IPGENERICOCPSPL_REVISION */
-        return 0x18;
-
-    case 0x10:	/* IPGENERICOCPSPL_SYSCONFIG */
-        return s->autoidle;
-
-    case 0x14:	/* IPGENERICOCPSPL_SYSSTATUS */
-        return 0x01;
-
-    case 0x18:	/* IPGENERICOCPSPL_IRQSTATUS */
-        return 0x00;
-
-    case 0x40:	/* IPGENERICOCPSPL_GPO */
-        return s->gpo;
-
-    case 0x50:	/* IPGENERICOCPSPL_GPI */
-        return 0x00;
-    }
-
-    OMAP_BAD_REG(addr);
-    return 0;
-}
-
-static void omap2_gpif_top_write(void *opaque, hwaddr addr,
-                                 uint64_t value, unsigned size)
-{
-    Omap2GpioState *s = opaque;
-
-    switch (addr) {
-    case 0x00:	/* IPGENERICOCPSPL_REVISION */
-    case 0x14:	/* IPGENERICOCPSPL_SYSSTATUS */
-    case 0x18:	/* IPGENERICOCPSPL_IRQSTATUS */
-    case 0x50:	/* IPGENERICOCPSPL_GPI */
-        OMAP_RO_REG(addr);
-        break;
-
-    case 0x10:	/* IPGENERICOCPSPL_SYSCONFIG */
-        if (value & (1 << 1))					/* SOFTRESET */
-            omap2_gpif_reset(DEVICE(s));
-        s->autoidle = value & 1;
-        break;
-
-    case 0x40:	/* IPGENERICOCPSPL_GPO */
-        s->gpo = value & 1;
-        break;
-
-    default:
-        OMAP_BAD_REG(addr);
-        return;
-    }
-}
-
-static const MemoryRegionOps omap2_gpif_top_ops = {
-    .read = omap2_gpif_top_read,
-    .write = omap2_gpif_top_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
 static void omap_gpio_init(Object *obj)
 {
     DeviceState *dev = DEVICE(obj);
@@ -697,51 +220,6 @@ static void omap_gpio_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void omap2_gpio_realize(DeviceState *dev, Error **errp)
-{
-    Omap2GpioState *s = OMAP2_GPIO(dev);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    int i;
-
-    if (!s->iclk) {
-        error_setg(errp, "omap2-gpio: iclk not connected");
-        return;
-    }
-
-    s->modulecount = s->mpu_model < omap2430 ? 4
-        : s->mpu_model < omap3430 ? 5
-        : 6;
-
-    if (s->mpu_model < omap3430) {
-        memory_region_init_io(&s->iomem, OBJECT(dev), &omap2_gpif_top_ops, s,
-                              "omap2.gpio", 0x1000);
-        sysbus_init_mmio(sbd, &s->iomem);
-    }
-
-    s->modules = g_new0(struct omap2_gpio_s, s->modulecount);
-    s->handler = g_new0(qemu_irq, s->modulecount * 32);
-    qdev_init_gpio_in(dev, omap2_gpio_set, s->modulecount * 32);
-    qdev_init_gpio_out(dev, s->handler, s->modulecount * 32);
-
-    for (i = 0; i < s->modulecount; i++) {
-        struct omap2_gpio_s *m = &s->modules[i];
-
-        if (!s->fclk[i]) {
-            error_setg(errp, "omap2-gpio: fclk%d not connected", i);
-            return;
-        }
-
-        m->revision = (s->mpu_model < omap3430) ? 0x18 : 0x25;
-        m->handler = &s->handler[i * 32];
-        sysbus_init_irq(sbd, &m->irq[0]); /* mpu irq */
-        sysbus_init_irq(sbd, &m->irq[1]); /* dsp irq */
-        sysbus_init_irq(sbd, &m->wkup);
-        memory_region_init_io(&m->iomem, OBJECT(dev), &omap2_gpio_module_ops, m,
-                              "omap.gpio-module", 0x1000);
-        sysbus_init_mmio(sbd, &m->iomem);
-    }
-}
-
 void omap_gpio_set_clk(Omap1GpioState *gpio, omap_clk clk)
 {
     gpio->clk = clk;
@@ -771,44 +249,9 @@ static const TypeInfo omap_gpio_info = {
     .class_init    = omap_gpio_class_init,
 };
 
-void omap2_gpio_set_iclk(Omap2GpioState *gpio, omap_clk clk)
-{
-    gpio->iclk = clk;
-}
-
-void omap2_gpio_set_fclk(Omap2GpioState *gpio, uint8_t i, omap_clk clk)
-{
-    assert(i <= 5);
-    gpio->fclk[i] = clk;
-}
-
-static Property omap2_gpio_properties[] = {
-    DEFINE_PROP_INT32("mpu_model", Omap2GpioState, mpu_model, 0),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void omap2_gpio_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->realize = omap2_gpio_realize;
-    device_class_set_legacy_reset(dc, omap2_gpif_reset);
-    device_class_set_props(dc, omap2_gpio_properties);
-    /* Reason: pointer properties "iclk", "fclk0", ..., "fclk5" */
-    dc->user_creatable = false;
-}
-
-static const TypeInfo omap2_gpio_info = {
-    .name          = TYPE_OMAP2_GPIO,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(Omap2GpioState),
-    .class_init    = omap2_gpio_class_init,
-};
-
 static void omap_gpio_register_types(void)
 {
     type_register_static(&omap_gpio_info);
-    type_register_static(&omap2_gpio_info);
 }
 
 type_init(omap_gpio_register_types)
-- 
2.34.1


