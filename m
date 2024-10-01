Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2C5CEACE8
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfv2-00069l-W7; Tue, 01 Oct 2024 12:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfub-0005aD-K4
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:45 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuV-000669-CC
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:45 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-37cc9aeb01dso3260215f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800778; x=1728405578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rDko8JRzdDXE1BB18CVDi8OSRkkMjG5VtbF0gUy6/YQ=;
 b=T0NHN7kxC80mo6aq7N9ryMWYr/1TdS9y5SCHNLp+aaon3v0MAGNT39+4nUbZPj69dE
 l3kA4hjCPGSk/nEDhkUipaQ97RSuSLNL6nyurcDzTlMzOhVw0OS8eQaPX18h0XkWdP29
 fBZF4fZHjtv0FpLSlX9DDI/3egeSLOkK4cG3XMFNOijqFfIljeTlLAEjf3eAKpkVDMoG
 UgkOhZMDuYzsgLUXuujg4o5v405ljAMCkxMB+M54SHjj7fDwf4TZQHoEiWjdGXLJjV5f
 pzu343Qh0I8Lm3TMnDKaI5lT8EcngTK6LLjcF7662XHQTr97m+b7PHmv+Ce/ei1/QW77
 h7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800778; x=1728405578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rDko8JRzdDXE1BB18CVDi8OSRkkMjG5VtbF0gUy6/YQ=;
 b=KTLTUob62w8dn/J9BHT5elJSJlx6FHfN/u/bsW+A0+yM5hQVD1EA6eSSIllLWYM0Er
 O5sgOPtmqXd3/FbMGRK99uypoMFT3mks5HfOcoAK/Jd/f7ZzJXSbsP6c8tz5UsyC/g10
 Nk8iU6abtW3YRTZAY9WbMBaud2knCQ5/KdfxSHrlTBciOrTLAWOZus5HN220bln3NA+U
 pvw7kcflIfNyZA73agNQ/Ui472/embDzaBo6UwR8PkVw3mli/NWml7Aeoafy1lNXR+gs
 niBCoZBA6VWSC0kVgN5NbBqfyXkuZgIAdDtWpJdO0+cdye6uXB8lDVMK9wD+roROY2YI
 Ge5A==
X-Gm-Message-State: AOJu0Yw/siK/E4hsivJmb+qp5onTJ7f+jbxoMIYJhhdo6ooNAGoUHysh
 z3y/x6GIWDoeAwAjcd4xUbEYqcHCU7TW1RdaWcMf/c3SqEYPWkjsUqhdGWgE6hYRbQVejy+FmER
 A
X-Google-Smtp-Source: AGHT+IG4pmyEUc2Y934e5GTb2yBD5IMYIZbI89KtwoYJ0SbbCxv8Go5abDRpKM9leC17RMz42kdrDw==
X-Received: by 2002:adf:a38a:0:b0:374:c407:4e07 with SMTP id
 ffacd0b85a97d-37cfba0446amr115939f8f.46.1727800777496; 
 Tue, 01 Oct 2024 09:39:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/54] hw/rtc: Remove twl92230 device
Date: Tue,  1 Oct 2024 17:38:57 +0100
Message-Id: <20241001163918.1275441-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

Remove the TWL92230 RTC device, which was used only by the n800 and n810.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20240903160751.4100218-31-peter.maydell@linaro.org
---
 MAINTAINERS        |   1 -
 hw/rtc/twl92230.c  | 882 ---------------------------------------------
 hw/rtc/Kconfig     |   4 -
 hw/rtc/meson.build |   1 -
 4 files changed, 888 deletions(-)
 delete mode 100644 hw/rtc/twl92230.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a63df2712ed..98314d157c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -875,7 +875,6 @@ M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/input/lm832x.c
-F: hw/rtc/twl92230.c
 F: include/hw/input/lm832x.h
 
 Raspberry Pi
diff --git a/hw/rtc/twl92230.c b/hw/rtc/twl92230.c
deleted file mode 100644
index efd19a76e61..00000000000
--- a/hw/rtc/twl92230.c
+++ /dev/null
@@ -1,882 +0,0 @@
-/*
- * TI TWL92230C energy-management companion device for the OMAP24xx.
- * Aka. Menelaus (N4200 MENELAUS1_V2.2)
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
-#include "qemu/timer.h"
-#include "hw/i2c/i2c.h"
-#include "hw/irq.h"
-#include "migration/qemu-file-types.h"
-#include "migration/vmstate.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/rtc.h"
-#include "qemu/bcd.h"
-#include "qemu/module.h"
-#include "qom/object.h"
-
-#define VERBOSE 1
-
-#define TYPE_TWL92230 "twl92230"
-OBJECT_DECLARE_SIMPLE_TYPE(MenelausState, TWL92230)
-
-struct MenelausState {
-    I2CSlave parent_obj;
-
-    int firstbyte;
-    uint8_t reg;
-
-    uint8_t vcore[5];
-    uint8_t dcdc[3];
-    uint8_t ldo[8];
-    uint8_t sleep[2];
-    uint8_t osc;
-    uint8_t detect;
-    uint16_t mask;
-    uint16_t status;
-    uint8_t dir;
-    uint8_t inputs;
-    uint8_t outputs;
-    uint8_t bbsms;
-    uint8_t pull[4];
-    uint8_t mmc_ctrl[3];
-    uint8_t mmc_debounce;
-    struct {
-        uint8_t ctrl;
-        uint16_t comp;
-        QEMUTimer *hz_tm;
-        int64_t next;
-        struct tm tm;
-        struct tm new;
-        struct tm alm;
-        int64_t sec_offset;
-        int64_t alm_sec;
-        int next_comp;
-    } rtc;
-    uint16_t rtc_next_vmstate;
-    qemu_irq out[4];
-    uint8_t pwrbtn_state;
-};
-
-static inline void menelaus_update(MenelausState *s)
-{
-    qemu_set_irq(s->out[3], s->status & ~s->mask);
-}
-
-static inline void menelaus_rtc_start(MenelausState *s)
-{
-    s->rtc.next += qemu_clock_get_ms(rtc_clock);
-    timer_mod(s->rtc.hz_tm, s->rtc.next);
-}
-
-static inline void menelaus_rtc_stop(MenelausState *s)
-{
-    timer_del(s->rtc.hz_tm);
-    s->rtc.next -= qemu_clock_get_ms(rtc_clock);
-    if (s->rtc.next < 1)
-        s->rtc.next = 1;
-}
-
-static void menelaus_rtc_update(MenelausState *s)
-{
-    qemu_get_timedate(&s->rtc.tm, s->rtc.sec_offset);
-}
-
-static void menelaus_alm_update(MenelausState *s)
-{
-    if ((s->rtc.ctrl & 3) == 3)
-        s->rtc.alm_sec = qemu_timedate_diff(&s->rtc.alm) - s->rtc.sec_offset;
-}
-
-static void menelaus_rtc_hz(void *opaque)
-{
-    MenelausState *s = (MenelausState *) opaque;
-
-    s->rtc.next_comp --;
-    s->rtc.alm_sec --;
-    s->rtc.next += 1000;
-    timer_mod(s->rtc.hz_tm, s->rtc.next);
-    if ((s->rtc.ctrl >> 3) & 3) {               /* EVERY */
-        menelaus_rtc_update(s);
-        if (((s->rtc.ctrl >> 3) & 3) == 1 && !s->rtc.tm.tm_sec)
-            s->status |= 1 << 8;                /* RTCTMR */
-        else if (((s->rtc.ctrl >> 3) & 3) == 2 && !s->rtc.tm.tm_min)
-            s->status |= 1 << 8;                /* RTCTMR */
-        else if (!s->rtc.tm.tm_hour)
-            s->status |= 1 << 8;                /* RTCTMR */
-    } else
-        s->status |= 1 << 8;                    /* RTCTMR */
-    if ((s->rtc.ctrl >> 1) & 1) {               /* RTC_AL_EN */
-        if (s->rtc.alm_sec == 0)
-            s->status |= 1 << 9;                /* RTCALM */
-        /* TODO: wake-up */
-    }
-    if (s->rtc.next_comp <= 0) {
-        s->rtc.next -= muldiv64((int16_t) s->rtc.comp, 1000, 0x8000);
-        s->rtc.next_comp = 3600;
-    }
-    menelaus_update(s);
-}
-
-static void menelaus_reset(I2CSlave *i2c)
-{
-    MenelausState *s = TWL92230(i2c);
-
-    s->reg = 0x00;
-
-    s->vcore[0] = 0x0c; /* XXX: X-loader needs 0x8c? check!  */
-    s->vcore[1] = 0x05;
-    s->vcore[2] = 0x02;
-    s->vcore[3] = 0x0c;
-    s->vcore[4] = 0x03;
-    s->dcdc[0] = 0x33;  /* Depends on wiring */
-    s->dcdc[1] = 0x03;
-    s->dcdc[2] = 0x00;
-    s->ldo[0] = 0x95;
-    s->ldo[1] = 0x7e;
-    s->ldo[2] = 0x00;
-    s->ldo[3] = 0x00;   /* Depends on wiring */
-    s->ldo[4] = 0x03;   /* Depends on wiring */
-    s->ldo[5] = 0x00;
-    s->ldo[6] = 0x00;
-    s->ldo[7] = 0x00;
-    s->sleep[0] = 0x00;
-    s->sleep[1] = 0x00;
-    s->osc = 0x01;
-    s->detect = 0x09;
-    s->mask = 0x0fff;
-    s->status = 0;
-    s->dir = 0x07;
-    s->outputs = 0x00;
-    s->bbsms = 0x00;
-    s->pull[0] = 0x00;
-    s->pull[1] = 0x00;
-    s->pull[2] = 0x00;
-    s->pull[3] = 0x00;
-    s->mmc_ctrl[0] = 0x03;
-    s->mmc_ctrl[1] = 0xc0;
-    s->mmc_ctrl[2] = 0x00;
-    s->mmc_debounce = 0x05;
-
-    if (s->rtc.ctrl & 1)
-        menelaus_rtc_stop(s);
-    s->rtc.ctrl = 0x00;
-    s->rtc.comp = 0x0000;
-    s->rtc.next = 1000;
-    s->rtc.sec_offset = 0;
-    s->rtc.next_comp = 1800;
-    s->rtc.alm_sec = 1800;
-    s->rtc.alm.tm_sec = 0x00;
-    s->rtc.alm.tm_min = 0x00;
-    s->rtc.alm.tm_hour = 0x00;
-    s->rtc.alm.tm_mday = 0x01;
-    s->rtc.alm.tm_mon = 0x00;
-    s->rtc.alm.tm_year = 2004;
-    menelaus_update(s);
-}
-
-static void menelaus_gpio_set(void *opaque, int line, int level)
-{
-    MenelausState *s = (MenelausState *) opaque;
-
-    if (line < 3) {
-        /* No interrupt generated */
-        s->inputs &= ~(1 << line);
-        s->inputs |= level << line;
-        return;
-    }
-
-    if (!s->pwrbtn_state && level) {
-        s->status |= 1 << 11;               /* PSHBTN */
-        menelaus_update(s);
-    }
-    s->pwrbtn_state = level;
-}
-
-#define MENELAUS_REV            0x01
-#define MENELAUS_VCORE_CTRL1    0x02
-#define MENELAUS_VCORE_CTRL2    0x03
-#define MENELAUS_VCORE_CTRL3    0x04
-#define MENELAUS_VCORE_CTRL4    0x05
-#define MENELAUS_VCORE_CTRL5    0x06
-#define MENELAUS_DCDC_CTRL1     0x07
-#define MENELAUS_DCDC_CTRL2     0x08
-#define MENELAUS_DCDC_CTRL3     0x09
-#define MENELAUS_LDO_CTRL1      0x0a
-#define MENELAUS_LDO_CTRL2      0x0b
-#define MENELAUS_LDO_CTRL3      0x0c
-#define MENELAUS_LDO_CTRL4      0x0d
-#define MENELAUS_LDO_CTRL5      0x0e
-#define MENELAUS_LDO_CTRL6      0x0f
-#define MENELAUS_LDO_CTRL7      0x10
-#define MENELAUS_LDO_CTRL8      0x11
-#define MENELAUS_SLEEP_CTRL1    0x12
-#define MENELAUS_SLEEP_CTRL2    0x13
-#define MENELAUS_DEVICE_OFF     0x14
-#define MENELAUS_OSC_CTRL       0x15
-#define MENELAUS_DETECT_CTRL    0x16
-#define MENELAUS_INT_MASK1      0x17
-#define MENELAUS_INT_MASK2      0x18
-#define MENELAUS_INT_STATUS1    0x19
-#define MENELAUS_INT_STATUS2    0x1a
-#define MENELAUS_INT_ACK1       0x1b
-#define MENELAUS_INT_ACK2       0x1c
-#define MENELAUS_GPIO_CTRL      0x1d
-#define MENELAUS_GPIO_IN        0x1e
-#define MENELAUS_GPIO_OUT       0x1f
-#define MENELAUS_BBSMS          0x20
-#define MENELAUS_RTC_CTRL       0x21
-#define MENELAUS_RTC_UPDATE     0x22
-#define MENELAUS_RTC_SEC        0x23
-#define MENELAUS_RTC_MIN        0x24
-#define MENELAUS_RTC_HR         0x25
-#define MENELAUS_RTC_DAY        0x26
-#define MENELAUS_RTC_MON        0x27
-#define MENELAUS_RTC_YR         0x28
-#define MENELAUS_RTC_WKDAY      0x29
-#define MENELAUS_RTC_AL_SEC     0x2a
-#define MENELAUS_RTC_AL_MIN     0x2b
-#define MENELAUS_RTC_AL_HR      0x2c
-#define MENELAUS_RTC_AL_DAY     0x2d
-#define MENELAUS_RTC_AL_MON     0x2e
-#define MENELAUS_RTC_AL_YR      0x2f
-#define MENELAUS_RTC_COMP_MSB   0x30
-#define MENELAUS_RTC_COMP_LSB   0x31
-#define MENELAUS_S1_PULL_EN     0x32
-#define MENELAUS_S1_PULL_DIR    0x33
-#define MENELAUS_S2_PULL_EN     0x34
-#define MENELAUS_S2_PULL_DIR    0x35
-#define MENELAUS_MCT_CTRL1      0x36
-#define MENELAUS_MCT_CTRL2      0x37
-#define MENELAUS_MCT_CTRL3      0x38
-#define MENELAUS_MCT_PIN_ST     0x39
-#define MENELAUS_DEBOUNCE1      0x3a
-
-static uint8_t menelaus_read(void *opaque, uint8_t addr)
-{
-    MenelausState *s = (MenelausState *) opaque;
-
-    switch (addr) {
-    case MENELAUS_REV:
-        return 0x22;
-
-    case MENELAUS_VCORE_CTRL1 ... MENELAUS_VCORE_CTRL5:
-        return s->vcore[addr - MENELAUS_VCORE_CTRL1];
-
-    case MENELAUS_DCDC_CTRL1 ... MENELAUS_DCDC_CTRL3:
-        return s->dcdc[addr - MENELAUS_DCDC_CTRL1];
-
-    case MENELAUS_LDO_CTRL1 ... MENELAUS_LDO_CTRL8:
-        return s->ldo[addr - MENELAUS_LDO_CTRL1];
-
-    case MENELAUS_SLEEP_CTRL1:
-    case MENELAUS_SLEEP_CTRL2:
-        return s->sleep[addr - MENELAUS_SLEEP_CTRL1];
-
-    case MENELAUS_DEVICE_OFF:
-        return 0;
-
-    case MENELAUS_OSC_CTRL:
-        return s->osc | (1 << 7);           /* CLK32K_GOOD */
-
-    case MENELAUS_DETECT_CTRL:
-        return s->detect;
-
-    case MENELAUS_INT_MASK1:
-        return (s->mask >> 0) & 0xff;
-    case MENELAUS_INT_MASK2:
-        return (s->mask >> 8) & 0xff;
-
-    case MENELAUS_INT_STATUS1:
-        return (s->status >> 0) & 0xff;
-    case MENELAUS_INT_STATUS2:
-        return (s->status >> 8) & 0xff;
-
-    case MENELAUS_INT_ACK1:
-    case MENELAUS_INT_ACK2:
-        return 0;
-
-    case MENELAUS_GPIO_CTRL:
-        return s->dir;
-    case MENELAUS_GPIO_IN:
-        return s->inputs | (~s->dir & s->outputs);
-    case MENELAUS_GPIO_OUT:
-        return s->outputs;
-
-    case MENELAUS_BBSMS:
-        return s->bbsms;
-
-    case MENELAUS_RTC_CTRL:
-        return s->rtc.ctrl;
-    case MENELAUS_RTC_UPDATE:
-        return 0x00;
-    case MENELAUS_RTC_SEC:
-        menelaus_rtc_update(s);
-        return to_bcd(s->rtc.tm.tm_sec);
-    case MENELAUS_RTC_MIN:
-        menelaus_rtc_update(s);
-        return to_bcd(s->rtc.tm.tm_min);
-    case MENELAUS_RTC_HR:
-        menelaus_rtc_update(s);
-        if ((s->rtc.ctrl >> 2) & 1)         /* MODE12_n24 */
-            return to_bcd((s->rtc.tm.tm_hour % 12) + 1) |
-                    (!!(s->rtc.tm.tm_hour >= 12) << 7); /* PM_nAM */
-        else
-            return to_bcd(s->rtc.tm.tm_hour);
-    case MENELAUS_RTC_DAY:
-        menelaus_rtc_update(s);
-        return to_bcd(s->rtc.tm.tm_mday);
-    case MENELAUS_RTC_MON:
-        menelaus_rtc_update(s);
-        return to_bcd(s->rtc.tm.tm_mon + 1);
-    case MENELAUS_RTC_YR:
-        menelaus_rtc_update(s);
-        return to_bcd(s->rtc.tm.tm_year - 2000);
-    case MENELAUS_RTC_WKDAY:
-        menelaus_rtc_update(s);
-        return to_bcd(s->rtc.tm.tm_wday);
-    case MENELAUS_RTC_AL_SEC:
-        return to_bcd(s->rtc.alm.tm_sec);
-    case MENELAUS_RTC_AL_MIN:
-        return to_bcd(s->rtc.alm.tm_min);
-    case MENELAUS_RTC_AL_HR:
-        if ((s->rtc.ctrl >> 2) & 1)         /* MODE12_n24 */
-            return to_bcd((s->rtc.alm.tm_hour % 12) + 1) |
-                    (!!(s->rtc.alm.tm_hour >= 12) << 7);/* AL_PM_nAM */
-        else
-            return to_bcd(s->rtc.alm.tm_hour);
-    case MENELAUS_RTC_AL_DAY:
-        return to_bcd(s->rtc.alm.tm_mday);
-    case MENELAUS_RTC_AL_MON:
-        return to_bcd(s->rtc.alm.tm_mon + 1);
-    case MENELAUS_RTC_AL_YR:
-        return to_bcd(s->rtc.alm.tm_year - 2000);
-    case MENELAUS_RTC_COMP_MSB:
-        return (s->rtc.comp >> 8) & 0xff;
-    case MENELAUS_RTC_COMP_LSB:
-        return (s->rtc.comp >> 0) & 0xff;
-
-    case MENELAUS_S1_PULL_EN:
-        return s->pull[0];
-    case MENELAUS_S1_PULL_DIR:
-        return s->pull[1];
-    case MENELAUS_S2_PULL_EN:
-        return s->pull[2];
-    case MENELAUS_S2_PULL_DIR:
-        return s->pull[3];
-
-    case MENELAUS_MCT_CTRL1 ... MENELAUS_MCT_CTRL3:
-        return s->mmc_ctrl[addr - MENELAUS_MCT_CTRL1];
-    case MENELAUS_MCT_PIN_ST:
-        /* TODO: return the real Card Detect */
-        return 0;
-    case MENELAUS_DEBOUNCE1:
-        return s->mmc_debounce;
-
-    default:
-#ifdef VERBOSE
-        printf("%s: unknown register %02x\n", __func__, addr);
-#endif
-        break;
-    }
-    return 0;
-}
-
-static void menelaus_write(void *opaque, uint8_t addr, uint8_t value)
-{
-    MenelausState *s = (MenelausState *) opaque;
-    int line;
-    struct tm tm;
-
-    switch (addr) {
-    case MENELAUS_VCORE_CTRL1:
-        s->vcore[0] = (value & 0xe) | MIN(value & 0x1f, 0x12);
-        break;
-    case MENELAUS_VCORE_CTRL2:
-        s->vcore[1] = value;
-        break;
-    case MENELAUS_VCORE_CTRL3:
-        s->vcore[2] = MIN(value & 0x1f, 0x12);
-        break;
-    case MENELAUS_VCORE_CTRL4:
-        s->vcore[3] = MIN(value & 0x1f, 0x12);
-        break;
-    case MENELAUS_VCORE_CTRL5:
-        s->vcore[4] = value & 3;
-        /* XXX
-         * auto set to 3 on M_Active, nRESWARM
-         * auto set to 0 on M_WaitOn, M_Backup
-         */
-        break;
-
-    case MENELAUS_DCDC_CTRL1:
-        s->dcdc[0] = value & 0x3f;
-        break;
-    case MENELAUS_DCDC_CTRL2:
-        s->dcdc[1] = value & 0x07;
-        /* XXX
-         * auto set to 3 on M_Active, nRESWARM
-         * auto set to 0 on M_WaitOn, M_Backup
-         */
-        break;
-    case MENELAUS_DCDC_CTRL3:
-        s->dcdc[2] = value & 0x07;
-        break;
-
-    case MENELAUS_LDO_CTRL1:
-        s->ldo[0] = value;
-        break;
-    case MENELAUS_LDO_CTRL2:
-        s->ldo[1] = value & 0x7f;
-        /* XXX
-         * auto set to 0x7e on M_WaitOn, M_Backup
-         */
-        break;
-    case MENELAUS_LDO_CTRL3:
-        s->ldo[2] = value & 3;
-        /* XXX
-         * auto set to 3 on M_Active, nRESWARM
-         * auto set to 0 on M_WaitOn, M_Backup
-         */
-        break;
-    case MENELAUS_LDO_CTRL4:
-        s->ldo[3] = value & 3;
-        /* XXX
-         * auto set to 3 on M_Active, nRESWARM
-         * auto set to 0 on M_WaitOn, M_Backup
-         */
-        break;
-    case MENELAUS_LDO_CTRL5:
-        s->ldo[4] = value & 3;
-        /* XXX
-         * auto set to 3 on M_Active, nRESWARM
-         * auto set to 0 on M_WaitOn, M_Backup
-         */
-        break;
-    case MENELAUS_LDO_CTRL6:
-        s->ldo[5] = value & 3;
-        break;
-    case MENELAUS_LDO_CTRL7:
-        s->ldo[6] = value & 3;
-        break;
-    case MENELAUS_LDO_CTRL8:
-        s->ldo[7] = value & 3;
-        break;
-
-    case MENELAUS_SLEEP_CTRL1:
-    case MENELAUS_SLEEP_CTRL2:
-        s->sleep[addr - MENELAUS_SLEEP_CTRL1] = value;
-        break;
-
-    case MENELAUS_DEVICE_OFF:
-        if (value & 1) {
-            menelaus_reset(I2C_SLAVE(s));
-        }
-        break;
-
-    case MENELAUS_OSC_CTRL:
-        s->osc = value & 7;
-        break;
-
-    case MENELAUS_DETECT_CTRL:
-        s->detect = value & 0x7f;
-        break;
-
-    case MENELAUS_INT_MASK1:
-        s->mask &= 0xf00;
-        s->mask |= value << 0;
-        menelaus_update(s);
-        break;
-    case MENELAUS_INT_MASK2:
-        s->mask &= 0x0ff;
-        s->mask |= value << 8;
-        menelaus_update(s);
-        break;
-
-    case MENELAUS_INT_ACK1:
-        s->status &= ~(((uint16_t) value) << 0);
-        menelaus_update(s);
-        break;
-    case MENELAUS_INT_ACK2:
-        s->status &= ~(((uint16_t) value) << 8);
-        menelaus_update(s);
-        break;
-
-    case MENELAUS_GPIO_CTRL:
-        for (line = 0; line < 3; line ++) {
-            if (((s->dir ^ value) >> line) & 1) {
-                qemu_set_irq(s->out[line],
-                             ((s->outputs & ~s->dir) >> line) & 1);
-            }
-        }
-        s->dir = value & 0x67;
-        break;
-    case MENELAUS_GPIO_OUT:
-        for (line = 0; line < 3; line ++) {
-            if ((((s->outputs ^ value) & ~s->dir) >> line) & 1) {
-                qemu_set_irq(s->out[line], (s->outputs >> line) & 1);
-            }
-        }
-        s->outputs = value & 0x07;
-        break;
-
-    case MENELAUS_BBSMS:
-        s->bbsms = 0x0d;
-        break;
-
-    case MENELAUS_RTC_CTRL:
-        if ((s->rtc.ctrl ^ value) & 1) {    /* RTC_EN */
-            if (value & 1)
-                menelaus_rtc_start(s);
-            else
-                menelaus_rtc_stop(s);
-        }
-        s->rtc.ctrl = value & 0x1f;
-        menelaus_alm_update(s);
-        break;
-    case MENELAUS_RTC_UPDATE:
-        menelaus_rtc_update(s);
-        memcpy(&tm, &s->rtc.tm, sizeof(tm));
-        switch (value & 0xf) {
-        case 0:
-            break;
-        case 1:
-            tm.tm_sec = s->rtc.new.tm_sec;
-            break;
-        case 2:
-            tm.tm_min = s->rtc.new.tm_min;
-            break;
-        case 3:
-            if (s->rtc.new.tm_hour > 23)
-                goto rtc_badness;
-            tm.tm_hour = s->rtc.new.tm_hour;
-            break;
-        case 4:
-            if (s->rtc.new.tm_mday < 1)
-                goto rtc_badness;
-            /* TODO check range */
-            tm.tm_mday = s->rtc.new.tm_mday;
-            break;
-        case 5:
-            if (s->rtc.new.tm_mon < 0 || s->rtc.new.tm_mon > 11)
-                goto rtc_badness;
-            tm.tm_mon = s->rtc.new.tm_mon;
-            break;
-        case 6:
-            tm.tm_year = s->rtc.new.tm_year;
-            break;
-        case 7:
-            /* TODO set .tm_mday instead */
-            tm.tm_wday = s->rtc.new.tm_wday;
-            break;
-        case 8:
-            if (s->rtc.new.tm_hour > 23)
-                goto rtc_badness;
-            if (s->rtc.new.tm_mday < 1)
-                goto rtc_badness;
-            if (s->rtc.new.tm_mon < 0 || s->rtc.new.tm_mon > 11)
-                goto rtc_badness;
-            tm.tm_sec = s->rtc.new.tm_sec;
-            tm.tm_min = s->rtc.new.tm_min;
-            tm.tm_hour = s->rtc.new.tm_hour;
-            tm.tm_mday = s->rtc.new.tm_mday;
-            tm.tm_mon = s->rtc.new.tm_mon;
-            tm.tm_year = s->rtc.new.tm_year;
-            break;
-        rtc_badness:
-        default:
-            fprintf(stderr, "%s: bad RTC_UPDATE value %02x\n",
-                            __func__, value);
-            s->status |= 1 << 10;           /* RTCERR */
-            menelaus_update(s);
-        }
-        s->rtc.sec_offset = qemu_timedate_diff(&tm);
-        break;
-    case MENELAUS_RTC_SEC:
-        s->rtc.tm.tm_sec = from_bcd(value & 0x7f);
-        break;
-    case MENELAUS_RTC_MIN:
-        s->rtc.tm.tm_min = from_bcd(value & 0x7f);
-        break;
-    case MENELAUS_RTC_HR:
-        s->rtc.tm.tm_hour = (s->rtc.ctrl & (1 << 2)) ?  /* MODE12_n24 */
-                MIN(from_bcd(value & 0x3f), 12) + ((value >> 7) ? 11 : -1) :
-                from_bcd(value & 0x3f);
-        break;
-    case MENELAUS_RTC_DAY:
-        s->rtc.tm.tm_mday = from_bcd(value);
-        break;
-    case MENELAUS_RTC_MON:
-        s->rtc.tm.tm_mon = MAX(1, from_bcd(value)) - 1;
-        break;
-    case MENELAUS_RTC_YR:
-        s->rtc.tm.tm_year = 2000 + from_bcd(value);
-        break;
-    case MENELAUS_RTC_WKDAY:
-        s->rtc.tm.tm_mday = from_bcd(value);
-        break;
-    case MENELAUS_RTC_AL_SEC:
-        s->rtc.alm.tm_sec = from_bcd(value & 0x7f);
-        menelaus_alm_update(s);
-        break;
-    case MENELAUS_RTC_AL_MIN:
-        s->rtc.alm.tm_min = from_bcd(value & 0x7f);
-        menelaus_alm_update(s);
-        break;
-    case MENELAUS_RTC_AL_HR:
-        s->rtc.alm.tm_hour = (s->rtc.ctrl & (1 << 2)) ? /* MODE12_n24 */
-                MIN(from_bcd(value & 0x3f), 12) + ((value >> 7) ? 11 : -1) :
-                from_bcd(value & 0x3f);
-        menelaus_alm_update(s);
-        break;
-    case MENELAUS_RTC_AL_DAY:
-        s->rtc.alm.tm_mday = from_bcd(value);
-        menelaus_alm_update(s);
-        break;
-    case MENELAUS_RTC_AL_MON:
-        s->rtc.alm.tm_mon = MAX(1, from_bcd(value)) - 1;
-        menelaus_alm_update(s);
-        break;
-    case MENELAUS_RTC_AL_YR:
-        s->rtc.alm.tm_year = 2000 + from_bcd(value);
-        menelaus_alm_update(s);
-        break;
-    case MENELAUS_RTC_COMP_MSB:
-        s->rtc.comp &= 0xff;
-        s->rtc.comp |= value << 8;
-        break;
-    case MENELAUS_RTC_COMP_LSB:
-        s->rtc.comp &= 0xff << 8;
-        s->rtc.comp |= value;
-        break;
-
-    case MENELAUS_S1_PULL_EN:
-        s->pull[0] = value;
-        break;
-    case MENELAUS_S1_PULL_DIR:
-        s->pull[1] = value & 0x1f;
-        break;
-    case MENELAUS_S2_PULL_EN:
-        s->pull[2] = value;
-        break;
-    case MENELAUS_S2_PULL_DIR:
-        s->pull[3] = value & 0x1f;
-        break;
-
-    case MENELAUS_MCT_CTRL1:
-        s->mmc_ctrl[0] = value & 0x7f;
-        break;
-    case MENELAUS_MCT_CTRL2:
-        s->mmc_ctrl[1] = value;
-        /* TODO update Card Detect interrupts */
-        break;
-    case MENELAUS_MCT_CTRL3:
-        s->mmc_ctrl[2] = value & 0xf;
-        break;
-    case MENELAUS_DEBOUNCE1:
-        s->mmc_debounce = value & 0x3f;
-        break;
-
-    default:
-#ifdef VERBOSE
-        printf("%s: unknown register %02x\n", __func__, addr);
-#endif
-        break;
-    }
-}
-
-static int menelaus_event(I2CSlave *i2c, enum i2c_event event)
-{
-    MenelausState *s = TWL92230(i2c);
-
-    if (event == I2C_START_SEND)
-        s->firstbyte = 1;
-
-    return 0;
-}
-
-static int menelaus_tx(I2CSlave *i2c, uint8_t data)
-{
-    MenelausState *s = TWL92230(i2c);
-
-    /* Interpret register address byte */
-    if (s->firstbyte) {
-        s->reg = data;
-        s->firstbyte = 0;
-    } else
-        menelaus_write(s, s->reg ++, data);
-
-    return 0;
-}
-
-static uint8_t menelaus_rx(I2CSlave *i2c)
-{
-    MenelausState *s = TWL92230(i2c);
-
-    return menelaus_read(s, s->reg ++);
-}
-
-/* Save restore 32 bit int as uint16_t
-   This is a Big hack, but it is how the old state did it.
-   Or we broke compatibility in the state, or we can't use struct tm
- */
-
-static int get_int32_as_uint16(QEMUFile *f, void *pv, size_t size,
-                               const VMStateField *field)
-{
-    int *v = pv;
-    *v = qemu_get_be16(f);
-    return 0;
-}
-
-static int put_int32_as_uint16(QEMUFile *f, void *pv, size_t size,
-                               const VMStateField *field, JSONWriter *vmdesc)
-{
-    int *v = pv;
-    qemu_put_be16(f, *v);
-
-    return 0;
-}
-
-static const VMStateInfo vmstate_hack_int32_as_uint16 = {
-    .name = "int32_as_uint16",
-    .get  = get_int32_as_uint16,
-    .put  = put_int32_as_uint16,
-};
-
-#define VMSTATE_UINT16_HACK(_f, _s)                                  \
-    VMSTATE_SINGLE(_f, _s, 0, vmstate_hack_int32_as_uint16, int32_t)
-
-
-static const VMStateDescription vmstate_menelaus_tm = {
-    .name = "menelaus_tm",
-    .version_id = 0,
-    .minimum_version_id = 0,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT16_HACK(tm_sec, struct tm),
-        VMSTATE_UINT16_HACK(tm_min, struct tm),
-        VMSTATE_UINT16_HACK(tm_hour, struct tm),
-        VMSTATE_UINT16_HACK(tm_mday, struct tm),
-        VMSTATE_UINT16_HACK(tm_min, struct tm),
-        VMSTATE_UINT16_HACK(tm_year, struct tm),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static int menelaus_pre_save(void *opaque)
-{
-    MenelausState *s = opaque;
-    /* Should be <= 1000 */
-    s->rtc_next_vmstate =  s->rtc.next - qemu_clock_get_ms(rtc_clock);
-
-    return 0;
-}
-
-static int menelaus_post_load(void *opaque, int version_id)
-{
-    MenelausState *s = opaque;
-
-    if (s->rtc.ctrl & 1)                    /* RTC_EN */
-        menelaus_rtc_stop(s);
-
-    s->rtc.next = s->rtc_next_vmstate;
-
-    menelaus_alm_update(s);
-    menelaus_update(s);
-    if (s->rtc.ctrl & 1)                    /* RTC_EN */
-        menelaus_rtc_start(s);
-    return 0;
-}
-
-static const VMStateDescription vmstate_menelaus = {
-    .name = "menelaus",
-    .version_id = 0,
-    .minimum_version_id = 0,
-    .pre_save = menelaus_pre_save,
-    .post_load = menelaus_post_load,
-    .fields = (const VMStateField[]) {
-        VMSTATE_INT32(firstbyte, MenelausState),
-        VMSTATE_UINT8(reg, MenelausState),
-        VMSTATE_UINT8_ARRAY(vcore, MenelausState, 5),
-        VMSTATE_UINT8_ARRAY(dcdc, MenelausState, 3),
-        VMSTATE_UINT8_ARRAY(ldo, MenelausState, 8),
-        VMSTATE_UINT8_ARRAY(sleep, MenelausState, 2),
-        VMSTATE_UINT8(osc, MenelausState),
-        VMSTATE_UINT8(detect, MenelausState),
-        VMSTATE_UINT16(mask, MenelausState),
-        VMSTATE_UINT16(status, MenelausState),
-        VMSTATE_UINT8(dir, MenelausState),
-        VMSTATE_UINT8(inputs, MenelausState),
-        VMSTATE_UINT8(outputs, MenelausState),
-        VMSTATE_UINT8(bbsms, MenelausState),
-        VMSTATE_UINT8_ARRAY(pull, MenelausState, 4),
-        VMSTATE_UINT8_ARRAY(mmc_ctrl, MenelausState, 3),
-        VMSTATE_UINT8(mmc_debounce, MenelausState),
-        VMSTATE_UINT8(rtc.ctrl, MenelausState),
-        VMSTATE_UINT16(rtc.comp, MenelausState),
-        VMSTATE_UINT16(rtc_next_vmstate, MenelausState),
-        VMSTATE_STRUCT(rtc.new, MenelausState, 0, vmstate_menelaus_tm,
-                       struct tm),
-        VMSTATE_STRUCT(rtc.alm, MenelausState, 0, vmstate_menelaus_tm,
-                       struct tm),
-        VMSTATE_UINT8(pwrbtn_state, MenelausState),
-        VMSTATE_I2C_SLAVE(parent_obj, MenelausState),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static void twl92230_realize(DeviceState *dev, Error **errp)
-{
-    MenelausState *s = TWL92230(dev);
-
-    s->rtc.hz_tm = timer_new_ms(rtc_clock, menelaus_rtc_hz, s);
-    /* Three output pins plus one interrupt pin.  */
-    qdev_init_gpio_out(dev, s->out, 4);
-
-    /* Three input pins plus one power-button pin.  */
-    qdev_init_gpio_in(dev, menelaus_gpio_set, 4);
-
-    menelaus_reset(I2C_SLAVE(dev));
-}
-
-static void twl92230_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
-
-    dc->realize = twl92230_realize;
-    sc->event = menelaus_event;
-    sc->recv = menelaus_rx;
-    sc->send = menelaus_tx;
-    dc->vmsd = &vmstate_menelaus;
-}
-
-static const TypeInfo twl92230_info = {
-    .name          = TYPE_TWL92230,
-    .parent        = TYPE_I2C_SLAVE,
-    .instance_size = sizeof(MenelausState),
-    .class_init    = twl92230_class_init,
-};
-
-static void twl92230_register_types(void)
-{
-    type_register_static(&twl92230_info);
-}
-
-type_init(twl92230_register_types)
diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
index d0d8dda0840..2fe04ec1d04 100644
--- a/hw/rtc/Kconfig
+++ b/hw/rtc/Kconfig
@@ -14,10 +14,6 @@ config M48T59
 config PL031
     bool
 
-config TWL92230
-    bool
-    depends on I2C
-
 config MC146818RTC
     depends on ISA_BUS
     bool
diff --git a/hw/rtc/meson.build b/hw/rtc/meson.build
index 3ea2affe0b9..8ecc2d792c1 100644
--- a/hw/rtc/meson.build
+++ b/hw/rtc/meson.build
@@ -3,7 +3,6 @@ system_ss.add(when: 'CONFIG_DS1338', if_true: files('ds1338.c'))
 system_ss.add(when: 'CONFIG_M41T80', if_true: files('m41t80.c'))
 system_ss.add(when: 'CONFIG_M48T59', if_true: files('m48t59.c'))
 system_ss.add(when: 'CONFIG_PL031', if_true: files('pl031.c'))
-system_ss.add(when: 'CONFIG_TWL92230', if_true: files('twl92230.c'))
 system_ss.add(when: ['CONFIG_ISA_BUS', 'CONFIG_M48T59'], if_true: files('m48t59-isa.c'))
 system_ss.add(when: 'CONFIG_XLNX_ZYNQMP', if_true: files('xlnx-zynqmp-rtc.c'))
 
-- 
2.34.1


