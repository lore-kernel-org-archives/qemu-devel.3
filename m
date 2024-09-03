Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B191CD37A7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slW5D-0007eO-QH; Tue, 03 Sep 2024 12:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW5B-0007Ry-Ur
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:41 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW55-0002pL-Kj
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:41 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42bb6d3e260so46938035e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725379714; x=1725984514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pg5awZIlWa5+7tugwU/FO8CAJe08el6Zg/lK80MSr1U=;
 b=O7Yh790jusj7V9LrIfbfkoBqvAVna35hjAS/9lDtX31nwRL1H4y7yEwkSim0sZgrEJ
 qUsD96lpsCKfvRz+j8PIg8ys5pYftqQv/CxQjCbwTKJc951yzs85ZImbOK3oXCB3zt55
 oMeEWovbD6/qXgrNOLgs7u9KwA0ULKsoSEgYqicvQMv6gdSVS5rG8S94R2tLrwdqnr9P
 3h5WF9x5b6ZGdsBwstFLDV7DaRHn6zXnLxv/8xvTmzXdHoCJLdXiUeJKZzcs0BiEkkgW
 sWdU7uQ/zJ/fMYf/u93HPgSkp1CE9T4cRa+D1fIaL/LkRuTQmx0ZzdIVXbHAMZooHMnZ
 DvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725379714; x=1725984514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pg5awZIlWa5+7tugwU/FO8CAJe08el6Zg/lK80MSr1U=;
 b=rYLDo1VT5V/zfSUVT9LNWxzAtTiEMXHxwLXxGcxcAHOu+/hUJFBrVCvpDObNtZBn+B
 LfBU/sBlva9dDWeGJ+nFH80GYlI1zhfBczYbhjxx+fueUDUdKtlZPAuxUHDVj9WlDKn+
 xn8K6a6JFoL2tHytDix0AzNwfTcmbTiFPfORZXZFmzheI70mNWN2dDKPThUdVxS+H4ZG
 tlLziw9RRE+/eOMxXuNjE7BC1vsJRF9gtq9aZT5MpTCEUPj25V9FFS0rxxXAIEr3T3cD
 WzN3e1GOYhKdM2lPWkZr9VU3d9j/w+C7UNdZXpPb0jke4+eqCzgOQwT2Ps8Q8BYJ3mI2
 9edw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW31Qt6xWr7yd6JWAhl5O0qH3uCtGSfTtJ8DJ4PmoGsFVnWmSMhym5YxIKe3QDj7CAtwVXYs0yzGt4n@nongnu.org
X-Gm-Message-State: AOJu0YyDvcfdJxW64TU7rVFu5bvvXji8HpTYFE4sFgBxcG2YmexoOsZS
 EPFLhSK+HTKkvX8XEoLgpfhkDaab5idYztqjsc9jnq9ukCkrC8HzT6YrSl0GwAo=
X-Google-Smtp-Source: AGHT+IEnT6NrQFditrAFB66A3mCKQBhx/0vZIdnW2BdoSDSC5Y4YAQHUA1Gz1r8xHEuRf+wztAoFHg==
X-Received: by 2002:a05:600c:3503:b0:428:2e9:6573 with SMTP id
 5b1f17b1804b1-42bdc6370a2mr78923175e9.17.1725379714096; 
 Tue, 03 Sep 2024 09:08:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df1066sm175123065e9.18.2024.09.03.09.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:08:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-9.2 26/53] hw/misc: Remove cbus
Date: Tue,  3 Sep 2024 17:07:24 +0100
Message-Id: <20240903160751.4100218-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903160751.4100218-1-peter.maydell@linaro.org>
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The devices in hw/misc/cbus.c were used only by the
now-removed nseries machine types, so they can be removed.

As this is the last use of the CONFIG_NSERIES define we
can remove that from KConfig now.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS            |   2 -
 include/hw/misc/cbus.h |  31 ---
 hw/misc/cbus.c         | 619 -----------------------------------------
 hw/arm/Kconfig         |  14 -
 hw/misc/meson.build    |   1 -
 5 files changed, 667 deletions(-)
 delete mode 100644 include/hw/misc/cbus.h
 delete mode 100644 hw/misc/cbus.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0c1fad7afda..156c1ba992c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -871,12 +871,10 @@ F: hw/display/blizzard.c
 F: hw/input/lm832x.c
 F: hw/input/tsc2005.c
 F: hw/input/tsc210x.c
-F: hw/misc/cbus.c
 F: hw/rtc/twl92230.c
 F: include/hw/display/blizzard.h
 F: include/hw/input/lm832x.h
 F: include/hw/input/tsc2xxx.h
-F: include/hw/misc/cbus.h
 
 Raspberry Pi
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/include/hw/misc/cbus.h b/include/hw/misc/cbus.h
deleted file mode 100644
index 5334984020d..00000000000
--- a/include/hw/misc/cbus.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * CBUS three-pin bus and the Retu / Betty / Tahvo / Vilma / Avilma /
- * Hinku / Vinku / Ahne / Pihi chips used in various Nokia platforms.
- * Based on reverse-engineering of a linux driver.
- *
- * Copyright (C) 2008 Nokia Corporation
- * Written by Andrzej Zaborowski
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-
-#ifndef HW_MISC_CBUS_H
-#define HW_MISC_CBUS_H
-
-
-typedef struct {
-    qemu_irq clk;
-    qemu_irq dat;
-    qemu_irq sel;
-} CBus;
-
-CBus *cbus_init(qemu_irq dat_out);
-void cbus_attach(CBus *bus, void *slave_opaque);
-
-void *retu_init(qemu_irq irq, int vilma);
-void *tahvo_init(qemu_irq irq, int betty);
-
-void retu_key_event(void *retu, int state);
-
-#endif
diff --git a/hw/misc/cbus.c b/hw/misc/cbus.c
deleted file mode 100644
index 653e8ddcd5b..00000000000
--- a/hw/misc/cbus.c
+++ /dev/null
@@ -1,619 +0,0 @@
-/*
- * CBUS three-pin bus and the Retu / Betty / Tahvo / Vilma / Avilma /
- * Hinku / Vinku / Ahne / Pihi chips used in various Nokia platforms.
- * Based on reverse-engineering of a linux driver.
- *
- * Copyright (C) 2008 Nokia Corporation
- * Written by Andrzej Zaborowski <andrew@openedhand.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 or
- * (at your option) version 3 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "qemu/osdep.h"
-#include "hw/hw.h"
-#include "hw/irq.h"
-#include "hw/misc/cbus.h"
-#include "sysemu/runstate.h"
-
-//#define DEBUG
-
-typedef struct {
-    void *opaque;
-    void (*io)(void *opaque, int rw, int reg, uint16_t *val);
-    int addr;
-} CBusSlave;
-
-typedef struct {
-    CBus cbus;
-
-    int sel;
-    int dat;
-    int clk;
-    int bit;
-    int dir;
-    uint16_t val;
-    qemu_irq dat_out;
-
-    int addr;
-    int reg;
-    int rw;
-    enum {
-        cbus_address,
-        cbus_value,
-    } cycle;
-
-    CBusSlave *slave[8];
-} CBusPriv;
-
-static void cbus_io(CBusPriv *s)
-{
-    if (s->slave[s->addr])
-        s->slave[s->addr]->io(s->slave[s->addr]->opaque,
-                        s->rw, s->reg, &s->val);
-    else
-        hw_error("%s: bad slave address %i\n", __func__, s->addr);
-}
-
-static void cbus_cycle(CBusPriv *s)
-{
-    switch (s->cycle) {
-    case cbus_address:
-        s->addr = (s->val >> 6) & 7;
-        s->rw =   (s->val >> 5) & 1;
-        s->reg =  (s->val >> 0) & 0x1f;
-
-        s->cycle = cbus_value;
-        s->bit = 15;
-        s->dir = !s->rw;
-        s->val = 0;
-
-        if (s->rw)
-            cbus_io(s);
-        break;
-
-    case cbus_value:
-        if (!s->rw)
-            cbus_io(s);
-
-        s->cycle = cbus_address;
-        s->bit = 8;
-        s->dir = 1;
-        s->val = 0;
-        break;
-    }
-}
-
-static void cbus_clk(void *opaque, int line, int level)
-{
-    CBusPriv *s = (CBusPriv *) opaque;
-
-    if (!s->sel && level && !s->clk) {
-        if (s->dir)
-            s->val |= s->dat << (s->bit --);
-        else
-            qemu_set_irq(s->dat_out, (s->val >> (s->bit --)) & 1);
-
-        if (s->bit < 0)
-            cbus_cycle(s);
-    }
-
-    s->clk = level;
-}
-
-static void cbus_dat(void *opaque, int line, int level)
-{
-    CBusPriv *s = (CBusPriv *) opaque;
-
-    s->dat = level;
-}
-
-static void cbus_sel(void *opaque, int line, int level)
-{
-    CBusPriv *s = (CBusPriv *) opaque;
-
-    if (!level) {
-        s->dir = 1;
-        s->bit = 8;
-        s->val = 0;
-    }
-
-    s->sel = level;
-}
-
-CBus *cbus_init(qemu_irq dat)
-{
-    CBusPriv *s = g_malloc0(sizeof(*s));
-
-    s->dat_out = dat;
-    s->cbus.clk = qemu_allocate_irq(cbus_clk, s, 0);
-    s->cbus.dat = qemu_allocate_irq(cbus_dat, s, 0);
-    s->cbus.sel = qemu_allocate_irq(cbus_sel, s, 0);
-
-    s->sel = 1;
-    s->clk = 0;
-    s->dat = 0;
-
-    return &s->cbus;
-}
-
-void cbus_attach(CBus *bus, void *slave_opaque)
-{
-    CBusSlave *slave = (CBusSlave *) slave_opaque;
-    CBusPriv *s = (CBusPriv *) bus;
-
-    s->slave[slave->addr] = slave;
-}
-
-/* Retu/Vilma */
-typedef struct {
-    uint16_t irqst;
-    uint16_t irqen;
-    uint16_t cc[2];
-    int channel;
-    uint16_t result[16];
-    uint16_t sample;
-    uint16_t status;
-
-    struct {
-        uint16_t cal;
-    } rtc;
-
-    int is_vilma;
-    qemu_irq irq;
-    CBusSlave cbus;
-} CBusRetu;
-
-static void retu_interrupt_update(CBusRetu *s)
-{
-    qemu_set_irq(s->irq, s->irqst & ~s->irqen);
-}
-
-#define RETU_REG_ASICR		0x00	/* (RO) ASIC ID & revision */
-#define RETU_REG_IDR		0x01	/* (T)  Interrupt ID */
-#define RETU_REG_IMR		0x02	/* (RW) Interrupt mask */
-#define RETU_REG_RTCDSR		0x03	/* (RW) RTC seconds register */
-#define RETU_REG_RTCHMR		0x04	/* (RO) RTC hours and minutes reg */
-#define RETU_REG_RTCHMAR	0x05	/* (RW) RTC hours and minutes set reg */
-#define RETU_REG_RTCCALR	0x06	/* (RW) RTC calibration register */
-#define RETU_REG_ADCR		0x08	/* (RW) ADC result register */
-#define RETU_REG_ADCSCR		0x09	/* (RW) ADC sample control register */
-#define RETU_REG_AFCR		0x0a	/* (RW) AFC register */
-#define RETU_REG_ANTIFR		0x0b	/* (RW) AntiF register */
-#define RETU_REG_CALIBR		0x0c	/* (RW) CalibR register*/
-#define RETU_REG_CCR1		0x0d	/* (RW) Common control register 1 */
-#define RETU_REG_CCR2		0x0e	/* (RW) Common control register 2 */
-#define RETU_REG_RCTRL_CLR	0x0f	/* (T)  Regulator clear register */
-#define RETU_REG_RCTRL_SET	0x10	/* (T)  Regulator set register */
-#define RETU_REG_TXCR		0x11	/* (RW) TxC register */
-#define RETU_REG_STATUS		0x16	/* (RO) Status register */
-#define RETU_REG_WATCHDOG	0x17	/* (RW) Watchdog register */
-#define RETU_REG_AUDTXR		0x18	/* (RW) Audio Codec Tx register */
-#define RETU_REG_AUDPAR		0x19	/* (RW) AudioPA register */
-#define RETU_REG_AUDRXR1	0x1a	/* (RW) Audio receive register 1 */
-#define RETU_REG_AUDRXR2	0x1b	/* (RW) Audio receive register 2 */
-#define RETU_REG_SGR1		0x1c	/* (RW) */
-#define RETU_REG_SCR1		0x1d	/* (RW) */
-#define RETU_REG_SGR2		0x1e	/* (RW) */
-#define RETU_REG_SCR2		0x1f	/* (RW) */
-
-/* Retu Interrupt sources */
-enum {
-    retu_int_pwr	= 0,	/* Power button */
-    retu_int_char	= 1,	/* Charger */
-    retu_int_rtcs	= 2,	/* Seconds */
-    retu_int_rtcm	= 3,	/* Minutes */
-    retu_int_rtcd	= 4,	/* Days */
-    retu_int_rtca	= 5,	/* Alarm */
-    retu_int_hook	= 6,	/* Hook */
-    retu_int_head	= 7,	/* Headset */
-    retu_int_adcs	= 8,	/* ADC sample */
-};
-
-/* Retu ADC channel wiring */
-enum {
-    retu_adc_bsi	= 1,	/* BSI */
-    retu_adc_batt_temp	= 2,	/* Battery temperature */
-    retu_adc_chg_volt	= 3,	/* Charger voltage */
-    retu_adc_head_det	= 4,	/* Headset detection */
-    retu_adc_hook_det	= 5,	/* Hook detection */
-    retu_adc_rf_gp	= 6,	/* RF GP */
-    retu_adc_tx_det	= 7,	/* Wideband Tx detection */
-    retu_adc_batt_volt	= 8,	/* Battery voltage */
-    retu_adc_sens	= 10,	/* Light sensor */
-    retu_adc_sens_temp	= 11,	/* Light sensor temperature */
-    retu_adc_bbatt_volt	= 12,	/* Backup battery voltage */
-    retu_adc_self_temp	= 13,	/* RETU temperature */
-};
-
-static inline uint16_t retu_read(CBusRetu *s, int reg)
-{
-#ifdef DEBUG
-    printf("RETU read at %02x\n", reg);
-#endif
-
-    switch (reg) {
-    case RETU_REG_ASICR:
-        return 0x0215 | (s->is_vilma << 7);
-
-    case RETU_REG_IDR:	/* TODO: Or is this ffs(s->irqst)?  */
-        return s->irqst;
-
-    case RETU_REG_IMR:
-        return s->irqen;
-
-    case RETU_REG_RTCDSR:
-    case RETU_REG_RTCHMR:
-    case RETU_REG_RTCHMAR:
-        /* TODO */
-        return 0x0000;
-
-    case RETU_REG_RTCCALR:
-        return s->rtc.cal;
-
-    case RETU_REG_ADCR:
-        return (s->channel << 10) | s->result[s->channel];
-    case RETU_REG_ADCSCR:
-        return s->sample;
-
-    case RETU_REG_AFCR:
-    case RETU_REG_ANTIFR:
-    case RETU_REG_CALIBR:
-        /* TODO */
-        return 0x0000;
-
-    case RETU_REG_CCR1:
-        return s->cc[0];
-    case RETU_REG_CCR2:
-        return s->cc[1];
-
-    case RETU_REG_RCTRL_CLR:
-    case RETU_REG_RCTRL_SET:
-    case RETU_REG_TXCR:
-        /* TODO */
-        return 0x0000;
-
-    case RETU_REG_STATUS:
-        return s->status;
-
-    case RETU_REG_WATCHDOG:
-    case RETU_REG_AUDTXR:
-    case RETU_REG_AUDPAR:
-    case RETU_REG_AUDRXR1:
-    case RETU_REG_AUDRXR2:
-    case RETU_REG_SGR1:
-    case RETU_REG_SCR1:
-    case RETU_REG_SGR2:
-    case RETU_REG_SCR2:
-        /* TODO */
-        return 0x0000;
-
-    default:
-        hw_error("%s: bad register %02x\n", __func__, reg);
-    }
-}
-
-static inline void retu_write(CBusRetu *s, int reg, uint16_t val)
-{
-#ifdef DEBUG
-    printf("RETU write of %04x at %02x\n", val, reg);
-#endif
-
-    switch (reg) {
-    case RETU_REG_IDR:
-        s->irqst ^= val;
-        retu_interrupt_update(s);
-        break;
-
-    case RETU_REG_IMR:
-        s->irqen = val;
-        retu_interrupt_update(s);
-        break;
-
-    case RETU_REG_RTCDSR:
-    case RETU_REG_RTCHMAR:
-        /* TODO */
-        break;
-
-    case RETU_REG_RTCCALR:
-        s->rtc.cal = val;
-        break;
-
-    case RETU_REG_ADCR:
-        s->channel = (val >> 10) & 0xf;
-        s->irqst |= 1 << retu_int_adcs;
-        retu_interrupt_update(s);
-        break;
-    case RETU_REG_ADCSCR:
-        s->sample &= ~val;
-        break;
-
-    case RETU_REG_AFCR:
-    case RETU_REG_ANTIFR:
-    case RETU_REG_CALIBR:
-
-    case RETU_REG_CCR1:
-        s->cc[0] = val;
-        break;
-    case RETU_REG_CCR2:
-        s->cc[1] = val;
-        break;
-
-    case RETU_REG_RCTRL_CLR:
-    case RETU_REG_RCTRL_SET:
-        /* TODO */
-        break;
-
-    case RETU_REG_WATCHDOG:
-        if (val == 0 && (s->cc[0] & 2))
-            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
-        break;
-
-    case RETU_REG_TXCR:
-    case RETU_REG_AUDTXR:
-    case RETU_REG_AUDPAR:
-    case RETU_REG_AUDRXR1:
-    case RETU_REG_AUDRXR2:
-    case RETU_REG_SGR1:
-    case RETU_REG_SCR1:
-    case RETU_REG_SGR2:
-    case RETU_REG_SCR2:
-        /* TODO */
-        break;
-
-    default:
-        hw_error("%s: bad register %02x\n", __func__, reg);
-    }
-}
-
-static void retu_io(void *opaque, int rw, int reg, uint16_t *val)
-{
-    CBusRetu *s = (CBusRetu *) opaque;
-
-    if (rw)
-        *val = retu_read(s, reg);
-    else
-        retu_write(s, reg, *val);
-}
-
-void *retu_init(qemu_irq irq, int vilma)
-{
-    CBusRetu *s = g_malloc0(sizeof(*s));
-
-    s->irq = irq;
-    s->irqen = 0xffff;
-    s->irqst = 0x0000;
-    s->status = 0x0020;
-    s->is_vilma = !!vilma;
-    s->rtc.cal = 0x01;
-    s->result[retu_adc_bsi] = 0x3c2;
-    s->result[retu_adc_batt_temp] = 0x0fc;
-    s->result[retu_adc_chg_volt] = 0x165;
-    s->result[retu_adc_head_det] = 123;
-    s->result[retu_adc_hook_det] = 1023;
-    s->result[retu_adc_rf_gp] = 0x11;
-    s->result[retu_adc_tx_det] = 0x11;
-    s->result[retu_adc_batt_volt] = 0x250;
-    s->result[retu_adc_sens] = 2;
-    s->result[retu_adc_sens_temp] = 0x11;
-    s->result[retu_adc_bbatt_volt] = 0x3d0;
-    s->result[retu_adc_self_temp] = 0x330;
-
-    s->cbus.opaque = s;
-    s->cbus.io = retu_io;
-    s->cbus.addr = 1;
-
-    return &s->cbus;
-}
-
-void retu_key_event(void *retu, int state)
-{
-    CBusSlave *slave = (CBusSlave *) retu;
-    CBusRetu *s = (CBusRetu *) slave->opaque;
-
-    s->irqst |= 1 << retu_int_pwr;
-    retu_interrupt_update(s);
-
-    if (state)
-        s->status &= ~(1 << 5);
-    else
-        s->status |= 1 << 5;
-}
-
-#if 0
-static void retu_head_event(void *retu, int state)
-{
-    CBusSlave *slave = (CBusSlave *) retu;
-    CBusRetu *s = (CBusRetu *) slave->opaque;
-
-    if ((s->cc[0] & 0x500) == 0x500) {	/* TODO: Which bits? */
-        /* TODO: reissue the interrupt every 100ms or so.  */
-        s->irqst |= 1 << retu_int_head;
-        retu_interrupt_update(s);
-    }
-
-    if (state)
-        s->result[retu_adc_head_det] = 50;
-    else
-        s->result[retu_adc_head_det] = 123;
-}
-
-static void retu_hook_event(void *retu, int state)
-{
-    CBusSlave *slave = (CBusSlave *) retu;
-    CBusRetu *s = (CBusRetu *) slave->opaque;
-
-    if ((s->cc[0] & 0x500) == 0x500) {
-        /* TODO: reissue the interrupt every 100ms or so.  */
-        s->irqst |= 1 << retu_int_hook;
-        retu_interrupt_update(s);
-    }
-
-    if (state)
-        s->result[retu_adc_hook_det] = 50;
-    else
-        s->result[retu_adc_hook_det] = 123;
-}
-#endif
-
-/* Tahvo/Betty */
-typedef struct {
-    uint16_t irqst;
-    uint16_t irqen;
-    uint8_t charger;
-    uint8_t backlight;
-    uint16_t usbr;
-    uint16_t power;
-
-    int is_betty;
-    qemu_irq irq;
-    CBusSlave cbus;
-} CBusTahvo;
-
-static void tahvo_interrupt_update(CBusTahvo *s)
-{
-    qemu_set_irq(s->irq, s->irqst & ~s->irqen);
-}
-
-#define TAHVO_REG_ASICR		0x00	/* (RO) ASIC ID & revision */
-#define TAHVO_REG_IDR		0x01	/* (T)  Interrupt ID */
-#define TAHVO_REG_IDSR		0x02	/* (RO) Interrupt status */
-#define TAHVO_REG_IMR		0x03	/* (RW) Interrupt mask */
-#define TAHVO_REG_CHAPWMR	0x04	/* (RW) Charger PWM */
-#define TAHVO_REG_LEDPWMR	0x05	/* (RW) LED PWM */
-#define TAHVO_REG_USBR		0x06	/* (RW) USB control */
-#define TAHVO_REG_RCR		0x07	/* (RW) Some kind of power management */
-#define TAHVO_REG_CCR1		0x08	/* (RW) Common control register 1 */
-#define TAHVO_REG_CCR2		0x09	/* (RW) Common control register 2 */
-#define TAHVO_REG_TESTR1	0x0a	/* (RW) Test register 1 */
-#define TAHVO_REG_TESTR2	0x0b	/* (RW) Test register 2 */
-#define TAHVO_REG_NOPR		0x0c	/* (RW) Number of periods */
-#define TAHVO_REG_FRR		0x0d	/* (RO) FR */
-
-static inline uint16_t tahvo_read(CBusTahvo *s, int reg)
-{
-#ifdef DEBUG
-    printf("TAHVO read at %02x\n", reg);
-#endif
-
-    switch (reg) {
-    case TAHVO_REG_ASICR:
-        return 0x0021 | (s->is_betty ? 0x0b00 : 0x0300);	/* 22 in N810 */
-
-    case TAHVO_REG_IDR:
-    case TAHVO_REG_IDSR:	/* XXX: what does this do?  */
-        return s->irqst;
-
-    case TAHVO_REG_IMR:
-        return s->irqen;
-
-    case TAHVO_REG_CHAPWMR:
-        return s->charger;
-
-    case TAHVO_REG_LEDPWMR:
-        return s->backlight;
-
-    case TAHVO_REG_USBR:
-        return s->usbr;
-
-    case TAHVO_REG_RCR:
-        return s->power;
-
-    case TAHVO_REG_CCR1:
-    case TAHVO_REG_CCR2:
-    case TAHVO_REG_TESTR1:
-    case TAHVO_REG_TESTR2:
-    case TAHVO_REG_NOPR:
-    case TAHVO_REG_FRR:
-        return 0x0000;
-
-    default:
-        hw_error("%s: bad register %02x\n", __func__, reg);
-    }
-}
-
-static inline void tahvo_write(CBusTahvo *s, int reg, uint16_t val)
-{
-#ifdef DEBUG
-    printf("TAHVO write of %04x at %02x\n", val, reg);
-#endif
-
-    switch (reg) {
-    case TAHVO_REG_IDR:
-        s->irqst ^= val;
-        tahvo_interrupt_update(s);
-        break;
-
-    case TAHVO_REG_IMR:
-        s->irqen = val;
-        tahvo_interrupt_update(s);
-        break;
-
-    case TAHVO_REG_CHAPWMR:
-        s->charger = val;
-        break;
-
-    case TAHVO_REG_LEDPWMR:
-        if (s->backlight != (val & 0x7f)) {
-            s->backlight = val & 0x7f;
-            printf("%s: LCD backlight now at %i / 127\n",
-                            __func__, s->backlight);
-        }
-        break;
-
-    case TAHVO_REG_USBR:
-        s->usbr = val;
-        break;
-
-    case TAHVO_REG_RCR:
-        s->power = val;
-        break;
-
-    case TAHVO_REG_CCR1:
-    case TAHVO_REG_CCR2:
-    case TAHVO_REG_TESTR1:
-    case TAHVO_REG_TESTR2:
-    case TAHVO_REG_NOPR:
-    case TAHVO_REG_FRR:
-        break;
-
-    default:
-        hw_error("%s: bad register %02x\n", __func__, reg);
-    }
-}
-
-static void tahvo_io(void *opaque, int rw, int reg, uint16_t *val)
-{
-    CBusTahvo *s = (CBusTahvo *) opaque;
-
-    if (rw)
-        *val = tahvo_read(s, reg);
-    else
-        tahvo_write(s, reg, *val);
-}
-
-void *tahvo_init(qemu_irq irq, int betty)
-{
-    CBusTahvo *s = g_malloc0(sizeof(*s));
-
-    s->irq = irq;
-    s->irqen = 0xffff;
-    s->irqst = 0x0000;
-    s->is_betty = !!betty;
-
-    s->cbus.opaque = s;
-    s->cbus.io = tahvo_io;
-    s->cbus.addr = 2;
-
-    return &s->cbus;
-}
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index d33d59bee90..a70ceff504b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -142,20 +142,6 @@ config OLIMEX_STM32_H405
     depends on TCG && ARM
     select STM32F405_SOC
 
-config NSERIES
-    bool
-    default y
-    depends on TCG && ARM
-    select OMAP
-    select TMP105   # temperature sensor
-    select BLIZZARD # LCD/TV controller
-    select ONENAND
-    select TSC210X  # touchscreen/sensors/audio
-    select TSC2005  # touchscreen/sensors/keypad
-    select LM832X   # GPIO keyboard chip
-    select TWL92230 # energy-management
-    select TUSB6010
-
 config OMAP
     bool
     select FRAMEBUFFER
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 56b94655152..01b77ca200f 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -51,7 +51,6 @@ system_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40-ccu.c'
 system_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40-dramc.c'))
 system_ss.add(when: 'CONFIG_AXP2XX_PMU', if_true: files('axp2xx.c'))
 system_ss.add(when: 'CONFIG_REALVIEW', if_true: files('arm_sysctl.c'))
-system_ss.add(when: 'CONFIG_NSERIES', if_true: files('cbus.c'))
 system_ss.add(when: 'CONFIG_ECCMEMCTL', if_true: files('eccmemctl.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pmu.c', 'exynos4210_clk.c', 'exynos4210_rng.c'))
 system_ss.add(when: 'CONFIG_IMX', if_true: files(
-- 
2.34.1


