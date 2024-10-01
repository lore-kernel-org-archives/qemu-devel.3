Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0855CEACE9
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfw6-0000Pd-Pb; Tue, 01 Oct 2024 12:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuf-0005bK-JM
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:50 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuU-00065b-7Y
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:49 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37ce14ab7eeso2744768f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800777; x=1728405577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mVcG8NFdfTNK/M6SeK1krHsKdIs/Ihl6XsM0mdEgkPk=;
 b=y0xDyRNYwOqxdDq51QGQxj5EZ6El8L6RGp6GAY6QelTyG1utQti/YNrF62UA9u3KeX
 HiJk0iSkVzxzWW+3wOpszmmlldfGP/ZAy63RI4TkWkkCuCSSvjvEKXQr2BvV7xPEyFUV
 vUjmKLP0zA3Wamsb+WAONHL32b1hz9CLA7bmyWf/kXBm8fnoISxDWIjjGzgMLt9tD7gA
 iKnwDUfHkr6Ssk3+6d0C/j1JuiBPqrV9CvtYupvIf/xPIIfE2eRDLMOI9RfHq1uG7rc+
 N/YmmFblW3nACiqLvpk6UL0n5oHOGXPOY7VUP436/Ae/VvJ0uFandSRFyR+iWo8kJ5hV
 U+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800777; x=1728405577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mVcG8NFdfTNK/M6SeK1krHsKdIs/Ihl6XsM0mdEgkPk=;
 b=g4eS+qzmig9mNq0vp/ms8ecZcFSL/XPAiPPqkQpnjBTkmmmA//Dd6e3czU/ums43Xu
 mC4dfti+S2+UNUfoyWFfHmWLxVKiukANulU7O3u141PO7hlRDnQy/14O4CnXk0Oz+maF
 ed2nMqb0dN4FQt36rZwl1FX8u9AlWfMuXLA2nhAXKiZLWkJ4U3STqkZIcvwFG3DPBwWY
 IJ2dV/RJ6i8zzLxe8W9AJVKlzgYywgOWgJH7r+NU9mNFY6GAkZAbtrqkusePu5rYwHNO
 0+LbzPaW2f+4C7UiaWyPolrrMRq9aq4x6niMYLUFHS9HX4zl4DtmZmeGfZW1d4qKjKzX
 lZeA==
X-Gm-Message-State: AOJu0YxBtCUowO/ZtqmMjH7xBYunVQhtTt7xAA2mKeVfh18pmByJrNPO
 FHsOKU7AnVZNw5DQl0PiqxGRuqB4KQh/1igw6KJl/WWR/h7Hw5TlmRxX5NSfbBku2w2OxNUIttX
 0
X-Google-Smtp-Source: AGHT+IGVx7cT5kZGyJHYd843VSxwil5G8nLuK3aThpfxjRjqi+k76qMdchNag4hOIpl0RTiriwMROw==
X-Received: by 2002:adf:9bdd:0:b0:37c:d123:f3bf with SMTP id
 ffacd0b85a97d-37cfb8b5697mr204069f8f.3.1727800776413; 
 Tue, 01 Oct 2024 09:39:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/54] hw/input: Remove tsc2005 touchscreen controller
Date: Tue,  1 Oct 2024 17:38:55 +0100
Message-Id: <20241001163918.1275441-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

Remove the tsc2005 touchscreen controller, which was only used
by the n800 and n810 machines.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20240903160751.4100218-29-peter.maydell@linaro.org
---
 MAINTAINERS                |   1 -
 include/hw/input/tsc2xxx.h |   5 -
 hw/input/tsc2005.c         | 571 -------------------------------------
 hw/input/Kconfig           |   3 -
 hw/input/meson.build       |   1 -
 hw/input/trace-events      |   3 -
 6 files changed, 584 deletions(-)
 delete mode 100644 hw/input/tsc2005.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0ca95c895cf..2569bf47a2c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -875,7 +875,6 @@ M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/input/lm832x.c
-F: hw/input/tsc2005.c
 F: hw/input/tsc210x.c
 F: hw/rtc/twl92230.c
 F: include/hw/input/lm832x.h
diff --git a/include/hw/input/tsc2xxx.h b/include/hw/input/tsc2xxx.h
index 00eca17674e..dcd4fa7faed 100644
--- a/include/hw/input/tsc2xxx.h
+++ b/include/hw/input/tsc2xxx.h
@@ -33,9 +33,4 @@ uint32_t tsc210x_txrx(void *opaque, uint32_t value, int len);
 void tsc210x_set_transform(uWireSlave *chip, const MouseTransformInfo *info);
 void tsc210x_key_event(uWireSlave *chip, int key, int down);
 
-/* tsc2005.c */
-void *tsc2005_init(qemu_irq pintdav);
-uint32_t tsc2005_txrx(void *opaque, uint32_t value, int len);
-void tsc2005_set_transform(void *opaque, const MouseTransformInfo *info);
-
 #endif
diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
deleted file mode 100644
index 54a15d24410..00000000000
--- a/hw/input/tsc2005.c
+++ /dev/null
@@ -1,571 +0,0 @@
-/*
- * TI TSC2005 emulator.
- *
- * Copyright (c) 2006 Andrzej Zaborowski  <balrog@zabor.org>
- * Copyright (C) 2008 Nokia Corporation
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
-#include "qemu/log.h"
-#include "qemu/timer.h"
-#include "sysemu/reset.h"
-#include "ui/console.h"
-#include "hw/input/tsc2xxx.h"
-#include "hw/irq.h"
-#include "migration/vmstate.h"
-#include "trace.h"
-
-#define TSC_CUT_RESOLUTION(value, p)  ((value) >> (16 - (p ? 12 : 10)))
-
-typedef struct {
-    qemu_irq pint;  /* Combination of the nPENIRQ and DAV signals */
-    QEMUTimer *timer;
-    uint16_t model;
-
-    int32_t x, y;
-    bool pressure;
-
-    uint8_t reg, state;
-    bool irq, command;
-    uint16_t data, dav;
-
-    bool busy;
-    bool enabled;
-    bool host_mode;
-    int8_t function;
-    int8_t nextfunction;
-    bool precision;
-    bool nextprecision;
-    uint16_t filter;
-    uint8_t pin_func;
-    uint16_t timing[2];
-    uint8_t noise;
-    bool reset;
-    bool pdst;
-    bool pnd0;
-    uint16_t temp_thr[2];
-    uint16_t aux_thr[2];
-
-    int32_t tr[8];
-} TSC2005State;
-
-enum {
-    TSC_MODE_XYZ_SCAN = 0x0,
-    TSC_MODE_XY_SCAN,
-    TSC_MODE_X,
-    TSC_MODE_Y,
-    TSC_MODE_Z,
-    TSC_MODE_AUX,
-    TSC_MODE_TEMP1,
-    TSC_MODE_TEMP2,
-    TSC_MODE_AUX_SCAN,
-    TSC_MODE_X_TEST,
-    TSC_MODE_Y_TEST,
-    TSC_MODE_TS_TEST,
-    TSC_MODE_RESERVED,
-    TSC_MODE_XX_DRV,
-    TSC_MODE_YY_DRV,
-    TSC_MODE_YX_DRV,
-};
-
-static const uint16_t mode_regs[16] = {
-    0xf000, /* X, Y, Z scan */
-    0xc000, /* X, Y scan */
-    0x8000, /* X */
-    0x4000, /* Y */
-    0x3000, /* Z */
-    0x0800, /* AUX */
-    0x0400, /* TEMP1 */
-    0x0200, /* TEMP2 */
-    0x0800, /* AUX scan */
-    0x0040, /* X test */
-    0x0020, /* Y test */
-    0x0080, /* Short-circuit test */
-    0x0000, /* Reserved */
-    0x0000, /* X+, X- drivers */
-    0x0000, /* Y+, Y- drivers */
-    0x0000, /* Y+, X- drivers */
-};
-
-#define X_TRANSFORM(s)      \
-    ((s->y * s->tr[0] - s->x * s->tr[1]) / s->tr[2] + s->tr[3])
-#define Y_TRANSFORM(s)      \
-    ((s->y * s->tr[4] - s->x * s->tr[5]) / s->tr[6] + s->tr[7])
-#define Z1_TRANSFORM(s)     \
-    ((400 - ((s)->x >> 7) + ((s)->pressure << 10)) << 4)
-#define Z2_TRANSFORM(s)     \
-    ((4000 + ((s)->y >> 7) - ((s)->pressure << 10)) << 4)
-
-#define AUX_VAL       (700 << 4)  /* +/- 3 at 12-bit */
-#define TEMP1_VAL     (1264 << 4) /* +/- 5 at 12-bit */
-#define TEMP2_VAL     (1531 << 4) /* +/- 5 at 12-bit */
-
-static uint16_t tsc2005_read(TSC2005State *s, int reg)
-{
-    uint16_t ret;
-
-    switch (reg) {
-    case 0x0: /* X */
-        s->dav &= ~mode_regs[TSC_MODE_X];
-        return TSC_CUT_RESOLUTION(X_TRANSFORM(s), s->precision) +
-                (s->noise & 3);
-    case 0x1: /* Y */
-        s->dav &= ~mode_regs[TSC_MODE_Y];
-        s->noise++;
-        return TSC_CUT_RESOLUTION(Y_TRANSFORM(s), s->precision) ^
-                (s->noise & 3);
-    case 0x2: /* Z1 */
-        s->dav &= 0xdfff;
-        return TSC_CUT_RESOLUTION(Z1_TRANSFORM(s), s->precision) -
-                (s->noise & 3);
-    case 0x3: /* Z2 */
-        s->dav &= 0xefff;
-        return TSC_CUT_RESOLUTION(Z2_TRANSFORM(s), s->precision) |
-                (s->noise & 3);
-
-    case 0x4: /* AUX */
-        s->dav &= ~mode_regs[TSC_MODE_AUX];
-        return TSC_CUT_RESOLUTION(AUX_VAL, s->precision);
-
-    case 0x5: /* TEMP1 */
-        s->dav &= ~mode_regs[TSC_MODE_TEMP1];
-        return TSC_CUT_RESOLUTION(TEMP1_VAL, s->precision) -
-                (s->noise & 5);
-    case 0x6: /* TEMP2 */
-        s->dav &= 0xdfff;
-        s->dav &= ~mode_regs[TSC_MODE_TEMP2];
-        return TSC_CUT_RESOLUTION(TEMP2_VAL, s->precision) ^
-                (s->noise & 3);
-
-    case 0x7: /* Status */
-        ret = s->dav | (s->reset << 7) | (s->pdst << 2) | 0x0;
-        s->dav &= ~(mode_regs[TSC_MODE_X_TEST] | mode_regs[TSC_MODE_Y_TEST] |
-                        mode_regs[TSC_MODE_TS_TEST]);
-        s->reset = true;
-        return ret;
-
-    case 0x8: /* AUX high threshold */
-        return s->aux_thr[1];
-    case 0x9: /* AUX low threshold */
-        return s->aux_thr[0];
-
-    case 0xa: /* TEMP high threshold */
-        return s->temp_thr[1];
-    case 0xb: /* TEMP low threshold */
-        return s->temp_thr[0];
-
-    case 0xc: /* CFR0 */
-        return (s->pressure << 15) | ((!s->busy) << 14) |
-                (s->nextprecision << 13) | s->timing[0];
-    case 0xd: /* CFR1 */
-        return s->timing[1];
-    case 0xe: /* CFR2 */
-        return (s->pin_func << 14) | s->filter;
-
-    case 0xf: /* Function select status */
-        return s->function >= 0 ? 1 << s->function : 0;
-    }
-
-    /* Never gets here */
-    return 0xffff;
-}
-
-static void tsc2005_write(TSC2005State *s, int reg, uint16_t data)
-{
-    switch (reg) {
-    case 0x8:   /* AUX high threshold */
-        s->aux_thr[1] = data;
-        break;
-    case 0x9:   /* AUX low threshold */
-        s->aux_thr[0] = data;
-        break;
-
-    case 0xa:   /* TEMP high threshold */
-        s->temp_thr[1] = data;
-        break;
-    case 0xb:   /* TEMP low threshold */
-        s->temp_thr[0] = data;
-        break;
-
-    case 0xc: /* CFR0 */
-        s->host_mode = (data >> 15) != 0;
-        if (s->enabled != !(data & 0x4000)) {
-            s->enabled = !(data & 0x4000);
-            trace_tsc2005_sense(s->enabled ? "enabled" : "disabled");
-            if (s->busy && !s->enabled) {
-                timer_del(s->timer);
-            }
-            s->busy = s->busy && s->enabled;
-        }
-        s->nextprecision = (data >> 13) & 1;
-        s->timing[0] = data & 0x1fff;
-        if ((s->timing[0] >> 11) == 3) {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "tsc2005_write: illegal conversion clock setting\n");
-        }
-        break;
-    case 0xd: /* CFR1 */
-        s->timing[1] = data & 0xf07;
-        break;
-    case 0xe: /* CFR2 */
-        s->pin_func = (data >> 14) & 3;
-        s->filter = data & 0x3fff;
-        break;
-
-    default:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: write into read-only register 0x%x\n",
-                      __func__, reg);
-    }
-}
-
-/* This handles most of the chip's logic.  */
-static void tsc2005_pin_update(TSC2005State *s)
-{
-    int64_t expires;
-    bool pin_state;
-
-    switch (s->pin_func) {
-    case 0:
-        pin_state = !s->pressure && !!s->dav;
-        break;
-    case 1:
-    case 3:
-    default:
-        pin_state = !s->dav;
-        break;
-    case 2:
-        pin_state = !s->pressure;
-    }
-
-    if (pin_state != s->irq) {
-        s->irq = pin_state;
-        qemu_set_irq(s->pint, s->irq);
-    }
-
-    switch (s->nextfunction) {
-    case TSC_MODE_XYZ_SCAN:
-    case TSC_MODE_XY_SCAN:
-        if (!s->host_mode && s->dav) {
-            s->enabled = false;
-        }
-        if (!s->pressure) {
-            return;
-        }
-        /* Fall through */
-    case TSC_MODE_AUX_SCAN:
-        break;
-
-    case TSC_MODE_X:
-    case TSC_MODE_Y:
-    case TSC_MODE_Z:
-        if (!s->pressure) {
-            return;
-        }
-        /* Fall through */
-    case TSC_MODE_AUX:
-    case TSC_MODE_TEMP1:
-    case TSC_MODE_TEMP2:
-    case TSC_MODE_X_TEST:
-    case TSC_MODE_Y_TEST:
-    case TSC_MODE_TS_TEST:
-        if (s->dav) {
-            s->enabled = false;
-        }
-        break;
-
-    case TSC_MODE_RESERVED:
-    case TSC_MODE_XX_DRV:
-    case TSC_MODE_YY_DRV:
-    case TSC_MODE_YX_DRV:
-    default:
-        return;
-    }
-
-    if (!s->enabled || s->busy) {
-        return;
-    }
-
-    s->busy = true;
-    s->precision = s->nextprecision;
-    s->function = s->nextfunction;
-    s->pdst = !s->pnd0; /* Synchronised on internal clock */
-    expires = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-        (NANOSECONDS_PER_SECOND >> 7);
-    timer_mod(s->timer, expires);
-}
-
-static void tsc2005_reset(TSC2005State *s)
-{
-    s->state = 0;
-    s->pin_func = 0;
-    s->enabled = false;
-    s->busy = false;
-    s->nextprecision = false;
-    s->nextfunction = 0;
-    s->timing[0] = 0;
-    s->timing[1] = 0;
-    s->irq = false;
-    s->dav = 0;
-    s->reset = false;
-    s->pdst = true;
-    s->pnd0 = false;
-    s->function = -1;
-    s->temp_thr[0] = 0x000;
-    s->temp_thr[1] = 0xfff;
-    s->aux_thr[0] = 0x000;
-    s->aux_thr[1] = 0xfff;
-
-    tsc2005_pin_update(s);
-}
-
-static uint8_t tsc2005_txrx_word(void *opaque, uint8_t value)
-{
-    TSC2005State *s = opaque;
-    uint32_t ret = 0;
-
-    switch (s->state++) {
-    case 0:
-        if (value & 0x80) {
-            /* Command */
-            if (value & (1 << 1))
-                tsc2005_reset(s);
-            else {
-                s->nextfunction = (value >> 3) & 0xf;
-                s->nextprecision = (value >> 2) & 1;
-                if (s->enabled != !(value & 1)) {
-                    s->enabled = !(value & 1);
-                    trace_tsc2005_sense(s->enabled ? "enabled" : "disabled");
-                    if (s->busy && !s->enabled) {
-                        timer_del(s->timer);
-                    }
-                    s->busy = s->busy && s->enabled;
-                }
-                tsc2005_pin_update(s);
-            }
-
-            s->state = 0;
-        } else if (value) {
-            /* Data transfer */
-            s->reg = (value >> 3) & 0xf;
-            s->pnd0 = (value >> 1) & 1;
-            s->command = value & 1;
-
-            if (s->command) {
-                /* Read */
-                s->data = tsc2005_read(s, s->reg);
-                tsc2005_pin_update(s);
-            } else
-                s->data = 0;
-        } else
-            s->state = 0;
-        break;
-
-    case 1:
-        if (s->command) {
-            ret = (s->data >> 8) & 0xff;
-        } else {
-            s->data |= value << 8;
-        }
-        break;
-
-    case 2:
-        if (s->command)
-            ret = s->data & 0xff;
-        else {
-            s->data |= value;
-            tsc2005_write(s, s->reg, s->data);
-            tsc2005_pin_update(s);
-        }
-
-        s->state = 0;
-        break;
-    }
-
-    return ret;
-}
-
-uint32_t tsc2005_txrx(void *opaque, uint32_t value, int len)
-{
-    uint32_t ret = 0;
-
-    len &= ~7;
-    while (len > 0) {
-        len -= 8;
-        ret |= tsc2005_txrx_word(opaque, (value >> len) & 0xff) << len;
-    }
-
-    return ret;
-}
-
-static void tsc2005_timer_tick(void *opaque)
-{
-    TSC2005State *s = opaque;
-    unsigned int function = s->function;
-
-    assert(function < ARRAY_SIZE(mode_regs));
-
-    /* Timer ticked -- a set of conversions has been finished.  */
-
-    if (!s->busy) {
-        return;
-    }
-
-    s->busy = false;
-    s->dav |= mode_regs[function];
-    s->function = -1;
-    tsc2005_pin_update(s);
-}
-
-static void tsc2005_touchscreen_event(void *opaque,
-                int x, int y, int z, int buttons_state)
-{
-    TSC2005State *s = opaque;
-    int p = s->pressure;
-
-    if (buttons_state) {
-        s->x = x;
-        s->y = y;
-    }
-    s->pressure = !!buttons_state;
-
-    /*
-     * Note: We would get better responsiveness in the guest by
-     * signaling TS events immediately, but for now we simulate
-     * the first conversion delay for sake of correctness.
-     */
-    if (p != s->pressure) {
-        tsc2005_pin_update(s);
-    }
-}
-
-static int tsc2005_post_load(void *opaque, int version_id)
-{
-    TSC2005State *s = (TSC2005State *) opaque;
-
-    s->busy = timer_pending(s->timer);
-    tsc2005_pin_update(s);
-
-    return 0;
-}
-
-static const VMStateDescription vmstate_tsc2005 = {
-    .name = "tsc2005",
-    .version_id = 2,
-    .minimum_version_id = 2,
-    .post_load = tsc2005_post_load,
-    .fields = (const VMStateField []) {
-        VMSTATE_BOOL(pressure, TSC2005State),
-        VMSTATE_BOOL(irq, TSC2005State),
-        VMSTATE_BOOL(command, TSC2005State),
-        VMSTATE_BOOL(enabled, TSC2005State),
-        VMSTATE_BOOL(host_mode, TSC2005State),
-        VMSTATE_BOOL(reset, TSC2005State),
-        VMSTATE_BOOL(pdst, TSC2005State),
-        VMSTATE_BOOL(pnd0, TSC2005State),
-        VMSTATE_BOOL(precision, TSC2005State),
-        VMSTATE_BOOL(nextprecision, TSC2005State),
-        VMSTATE_UINT8(reg, TSC2005State),
-        VMSTATE_UINT8(state, TSC2005State),
-        VMSTATE_UINT16(data, TSC2005State),
-        VMSTATE_UINT16(dav, TSC2005State),
-        VMSTATE_UINT16(filter, TSC2005State),
-        VMSTATE_INT8(nextfunction, TSC2005State),
-        VMSTATE_INT8(function, TSC2005State),
-        VMSTATE_INT32(x, TSC2005State),
-        VMSTATE_INT32(y, TSC2005State),
-        VMSTATE_TIMER_PTR(timer, TSC2005State),
-        VMSTATE_UINT8(pin_func, TSC2005State),
-        VMSTATE_UINT16_ARRAY(timing, TSC2005State, 2),
-        VMSTATE_UINT8(noise, TSC2005State),
-        VMSTATE_UINT16_ARRAY(temp_thr, TSC2005State, 2),
-        VMSTATE_UINT16_ARRAY(aux_thr, TSC2005State, 2),
-        VMSTATE_INT32_ARRAY(tr, TSC2005State, 8),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-void *tsc2005_init(qemu_irq pintdav)
-{
-    TSC2005State *s;
-
-    s = g_new0(TSC2005State, 1);
-    s->x = 400;
-    s->y = 240;
-    s->pressure = false;
-    s->precision = s->nextprecision = false;
-    s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, tsc2005_timer_tick, s);
-    s->pint = pintdav;
-    s->model = 0x2005;
-
-    s->tr[0] = 0;
-    s->tr[1] = 1;
-    s->tr[2] = 1;
-    s->tr[3] = 0;
-    s->tr[4] = 1;
-    s->tr[5] = 0;
-    s->tr[6] = 1;
-    s->tr[7] = 0;
-
-    tsc2005_reset(s);
-
-    qemu_add_mouse_event_handler(tsc2005_touchscreen_event, s, 1,
-                    "QEMU TSC2005-driven Touchscreen");
-
-    qemu_register_reset((void *) tsc2005_reset, s);
-    vmstate_register(NULL, 0, &vmstate_tsc2005, s);
-
-    return s;
-}
-
-/*
- * Use tslib generated calibration data to generate ADC input values
- * from the touchscreen.  Assuming 12-bit precision was used during
- * tslib calibration.
- */
-void tsc2005_set_transform(void *opaque, const MouseTransformInfo *info)
-{
-    TSC2005State *s = (TSC2005State *) opaque;
-
-    /* This version assumes touchscreen X & Y axis are parallel or
-     * perpendicular to LCD's  X & Y axis in some way.  */
-    if (abs(info->a[0]) > abs(info->a[1])) {
-        s->tr[0] = 0;
-        s->tr[1] = -info->a[6] * info->x;
-        s->tr[2] = info->a[0];
-        s->tr[3] = -info->a[2] / info->a[0];
-        s->tr[4] = info->a[6] * info->y;
-        s->tr[5] = 0;
-        s->tr[6] = info->a[4];
-        s->tr[7] = -info->a[5] / info->a[4];
-    } else {
-        s->tr[0] = info->a[6] * info->y;
-        s->tr[1] = 0;
-        s->tr[2] = info->a[1];
-        s->tr[3] = -info->a[2] / info->a[1];
-        s->tr[4] = 0;
-        s->tr[5] = -info->a[6] * info->x;
-        s->tr[6] = info->a[3];
-        s->tr[7] = -info->a[5] / info->a[3];
-    }
-
-    s->tr[0] >>= 11;
-    s->tr[1] >>= 11;
-    s->tr[3] <<= 4;
-    s->tr[4] >>= 11;
-    s->tr[5] >>= 11;
-    s->tr[7] <<= 4;
-}
diff --git a/hw/input/Kconfig b/hw/input/Kconfig
index acfdba5c4ca..01a64a9aa7e 100644
--- a/hw/input/Kconfig
+++ b/hw/input/Kconfig
@@ -20,9 +20,6 @@ config PS2
 config STELLARIS_GAMEPAD
     bool
 
-config TSC2005
-    bool
-
 config VIRTIO_INPUT
     bool
     default y
diff --git a/hw/input/meson.build b/hw/input/meson.build
index fe60b6e28fc..064d1e47802 100644
--- a/hw/input/meson.build
+++ b/hw/input/meson.build
@@ -5,7 +5,6 @@ system_ss.add(when: 'CONFIG_PCKBD', if_true: files('pckbd.c'))
 system_ss.add(when: 'CONFIG_PL050', if_true: files('pl050.c'))
 system_ss.add(when: 'CONFIG_PS2', if_true: files('ps2.c'))
 system_ss.add(when: 'CONFIG_STELLARIS_GAMEPAD', if_true: files('stellaris_gamepad.c'))
-system_ss.add(when: 'CONFIG_TSC2005', if_true: files('tsc2005.c'))
 
 system_ss.add(when: 'CONFIG_VIRTIO_INPUT', if_true: files('virtio-input.c'))
 system_ss.add(when: 'CONFIG_VIRTIO_INPUT', if_true: files('virtio-input-hid.c'))
diff --git a/hw/input/trace-events b/hw/input/trace-events
index 29001a827d9..1484625565b 100644
--- a/hw/input/trace-events
+++ b/hw/input/trace-events
@@ -46,9 +46,6 @@ ps2_mouse_reset(void *opaque) "%p"
 hid_kbd_queue_full(void) "queue full"
 hid_kbd_queue_empty(void) "queue empty"
 
-# tsc2005.c
-tsc2005_sense(const char *state) "touchscreen sense %s"
-
 # virtio-input.c
 virtio_input_queue_full(void) "queue full"
 
-- 
2.34.1


