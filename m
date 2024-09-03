Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B35CD379F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slW5T-0000m6-Dv; Tue, 03 Sep 2024 12:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW5R-0000fh-Pq
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:57 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW5N-0002uy-V2
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:57 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42c7bc97423so34587695e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725379732; x=1725984532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=omeNUQBHhD7rQ+2+37oDOhIxxFTSqrGLWgH+yK1kOBw=;
 b=NdayRPweqYqelJCKPwy3qhZ+nEV+XMN5XNYlSz3/sgBdH8rseVd+wSCRsbHn3L4mC4
 Vh9trP8I+28+FHbRp8Lf1PElNZ1xrsX2kz++r0If3LiTOU7vACt67c8G58L+M3HHBRS3
 UEPVpsurO9z6VWHMw/P4JSriL91G8PXBgrdAVOK5E2JR3SIe5IHhxm6zmOWh3tcLDJ5r
 Vvm7aFcvhDNxCBEqUHL/qtJZW88ZR1KXMKpFTq4VDXflUfYKreMkwfJuBE58s1B6z4Sr
 YYofL8giyEkBk19xpLldpXuMUkPQc9cT7cWw9cyun3zI+nZZL/D7TM3rhd1R6aTNKVub
 kA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725379732; x=1725984532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=omeNUQBHhD7rQ+2+37oDOhIxxFTSqrGLWgH+yK1kOBw=;
 b=WRVM4iXlKH7zmC5o2ONxdu7iWUtbJx6hWfK4Z8jzPeEtb28BFb3eELetAPEHj1PiqP
 4Py3RNnfJwmvFJKewk1PNp7zMgqk/njUMOwGhr4PbVrLJtivp5p4nWfBVUz+2TJA3Coi
 TVrkq3cRGO3lsy9zyfeJZVSH98BhMBqERbpqLIyiOkwTutvWhwLqqFWK2WAMzp9fkNDV
 xG/ZJn3lmP5Fm8ZTTk4/8kEByd3t2jXfmuKwh+jcKFIZMRiRxoBN11iWb8TVgrfvKZcI
 0JzM3itj7qFRz9NgcUbOAqOpyOfJH6kbAXbTt8SKzt0IbDNQztvc+B9K5UauLw0X0A63
 m1CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1pmnZcgfnheA1o93FFfsZ0Le50dOhKifNt6KpZwG/sOe6E582FX2HthpqZ39IkTUeQwNykOas9V0l@nongnu.org
X-Gm-Message-State: AOJu0YySaeIZJ/WnIS3AE7fLsO+OajX7LXV6LCPR+sx+fxQJ4zoHje+x
 Uz1FxHcgNN0XoTY9+7MfCZoQfNK/tYYEvWv+zw+anYF8wmjqDerpSHgc+8PM5SOYA0cNbirWEw3
 X
X-Google-Smtp-Source: AGHT+IHsIL9Qvm6C55hswWK2G98s8dFw0w2KGLNYrfRwRj62LK43rTIob0hnMIJF5VT9W1pC9sEgyw==
X-Received: by 2002:a05:600c:1c83:b0:426:59fe:ac27 with SMTP id
 5b1f17b1804b1-42bb01edc2amr146564185e9.26.1725379732243; 
 Tue, 03 Sep 2024 09:08:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df1066sm175123065e9.18.2024.09.03.09.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:08:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-9.2 38/53] hw/gpio: Remove TYPE_OMAP2_GPIO
Date: Tue,  3 Sep 2024 17:07:36 +0100
Message-Id: <20240903160751.4100218-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903160751.4100218-1-peter.maydell@linaro.org>
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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

We've removed the OMAP2 SoC, so we can remove the OMAP2 GPIO
device. (The source file remains, as it also has the model of
the OMAP1 GPIO device.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
index a3341d70f16..0ded1f749bb 100644
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
-    dc->reset = omap2_gpif_reset;
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


