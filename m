Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D028CD3448
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slW5b-0001Vq-5t; Tue, 03 Sep 2024 12:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW5Y-0001JI-JN
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:09:04 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW5V-0002xd-5N
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:09:04 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-374c4d4f219so1818141f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725379739; x=1725984539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QIZtZFtHVcUSbCLhBNB0yt7hebc2R/UctN0rfEP7jDs=;
 b=hc4B7HOFWw+56fhovq5yiRzOlSTcg0bbCW5RErKqU9PObiRIHlPMwZ+3pCn0kYurD9
 jl6cYenH59GWUILseRj4Wpz+rq9hai6ze3zcF2LgaXG0AYYDmylI699pAtC5lJ0mNOce
 RKgAKKAr/8dcu8ZPHxXogZmqzU9QdlaXi9oNnVcI4/FaXH8zi8MrkM+DIbRvlSUF1R4d
 ZU2u+l23prL4KEmiAi6MVy2yNvjV9oSPZuTJx75I25h58+qlvFRkMB3iGQwYROrI6ndm
 cAY722o535Eu4ka/5p43sT5dVpHLgZ6LwiimJx0kELKDCHNRjVBLC0mWX52mYt6fY08a
 4SdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725379739; x=1725984539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QIZtZFtHVcUSbCLhBNB0yt7hebc2R/UctN0rfEP7jDs=;
 b=iMRYqFDdQgaM7yc3bNjsLKKmrzbbwwJHchwdmhx8HA2oHdMgodoju6l7adS7+AacEU
 nJ7gbt1z6a/cap+k/YnJLhUshmQoKoToGyGYxmnlqvJI8bUnfXc8RlKAe+wxweIjXDwC
 SEX089kX5qoL3tDHlgOT9TYBO+NpUUSwXL3ubGJ4YUpHsbrnw0GqJniuuqk9pMABeb/o
 Ohlg0U0lxVKYyY8L3hu9EVHExSpJv8xPFk3EOcyLAK81J3IVOmtruzGsQEdh8gdK+bEU
 g4nIfKFWnakXhvwOyUbsSuKHmrIbEivbmSDGd2Fw0HQh+B/fWDd+Mk38iVV3oAgSpRLW
 pgrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHm/iAahYblfAe5FhPnvteU1U0qRKH6LTfjckNQkYbA/cMo5/rYquEY4rpdd+dFfLeWrNwLieWRPFu@nongnu.org
X-Gm-Message-State: AOJu0Yx4tC0h+PzOGe77KhIAqqqEmCfzQCkgRwkoWRQttJfQsBElHS1r
 r2OqtkXBSeYFxb2fYL88UCvZ6r78aOdVYe2CVqv5yafbwEmZcAqc3eV2mIWePscwMcP3YgA04J5
 /
X-Google-Smtp-Source: AGHT+IFfkMbCV7+CO1DSFSfH8+mt0XLbTsSbd05YRuSLk4EN+aXi10XS1y6sDVeMOsu5owqcJ7xmqg==
X-Received: by 2002:adf:f784:0:b0:374:c69b:5a16 with SMTP id
 ffacd0b85a97d-374f9e47a5cmr2812336f8f.50.1725379739320; 
 Tue, 03 Sep 2024 09:08:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df1066sm175123065e9.18.2024.09.03.09.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:08:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-9.2 44/53] hw/timer: Remove omap_gptimer
Date: Tue,  3 Sep 2024 17:07:42 +0100
Message-Id: <20240903160751.4100218-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903160751.4100218-1-peter.maydell@linaro.org>
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

The omap_gptimer device is only in the OMAP2 SoC, which we
are removing.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/omap.h   |   8 -
 hw/timer/omap_gptimer.c | 512 ----------------------------------------
 hw/timer/meson.build    |   1 -
 3 files changed, 521 deletions(-)
 delete mode 100644 hw/timer/omap_gptimer.c

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 0cbbf2fecb5..cced3d28605 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -676,13 +676,6 @@ struct omap_dma_lcd_channel_s {
 # define OMAP24XX_DMA_MS		63	/* Not in OMAP2420 */
 # define OMAP24XX_DMA_EXT_DMAREQ5	64
 
-/* omap[123].c */
-/* OMAP2 gp timer */
-struct omap_gp_timer_s;
-struct omap_gp_timer_s *omap_gp_timer_init(struct omap_target_agent_s *ta,
-                qemu_irq irq, omap_clk fclk, omap_clk iclk);
-void omap_gp_timer_reset(struct omap_gp_timer_s *s);
-
 /* OMAP2 sysctimer */
 struct omap_synctimer_s;
 struct omap_synctimer_s *omap_synctimer_init(struct omap_target_agent_s *ta,
@@ -936,7 +929,6 @@ struct omap_mpu_state_s {
     /* OMAP2-only peripherals */
     struct omap_l4_s *l4;
 
-    struct omap_gp_timer_s *gptimer[12];
     struct omap_synctimer_s *synctimer;
 
     struct omap_mcspi_s *mcspi[2];
diff --git a/hw/timer/omap_gptimer.c b/hw/timer/omap_gptimer.c
deleted file mode 100644
index 34e6af7aff5..00000000000
--- a/hw/timer/omap_gptimer.c
+++ /dev/null
@@ -1,512 +0,0 @@
-/*
- * TI OMAP2 general purpose timers emulation.
- *
- * Copyright (C) 2007-2008 Nokia Corporation
- * Written by Andrzej Zaborowski <andrew@openedhand.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 or
- * (at your option) any later version of the License.
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
-#include "hw/irq.h"
-#include "qemu/timer.h"
-#include "hw/arm/omap.h"
-
-/* GP timers */
-struct omap_gp_timer_s {
-    MemoryRegion iomem;
-    qemu_irq irq;
-    qemu_irq wkup;
-    qemu_irq in;
-    qemu_irq out;
-    omap_clk clk;
-    QEMUTimer *timer;
-    QEMUTimer *match;
-    struct omap_target_agent_s *ta;
-
-    int in_val;
-    int out_val;
-    int64_t time;
-    int64_t rate;
-    int64_t ticks_per_sec;
-
-    int16_t config;
-    int status;
-    int it_ena;
-    int wu_ena;
-    int enable;
-    int inout;
-    int capt2;
-    int pt;
-    enum {
-        gpt_trigger_none, gpt_trigger_overflow, gpt_trigger_both
-    } trigger;
-    enum {
-        gpt_capture_none, gpt_capture_rising,
-        gpt_capture_falling, gpt_capture_both
-    } capture;
-    int scpwm;
-    int ce;
-    int pre;
-    int ptv;
-    int ar;
-    int st;
-    int posted;
-    uint32_t val;
-    uint32_t load_val;
-    uint32_t capture_val[2];
-    uint32_t match_val;
-    int capt_num;
-
-    uint16_t writeh;	/* LSB */
-    uint16_t readh;	/* MSB */
-};
-
-#define GPT_TCAR_IT	(1 << 2)
-#define GPT_OVF_IT	(1 << 1)
-#define GPT_MAT_IT	(1 << 0)
-
-static inline void omap_gp_timer_intr(struct omap_gp_timer_s *timer, int it)
-{
-    if (timer->it_ena & it) {
-        if (!timer->status)
-            qemu_irq_raise(timer->irq);
-
-        timer->status |= it;
-        /* Or are the status bits set even when masked?
-         * i.e. is masking applied before or after the status register?  */
-    }
-
-    if (timer->wu_ena & it)
-        qemu_irq_pulse(timer->wkup);
-}
-
-static inline void omap_gp_timer_out(struct omap_gp_timer_s *timer, int level)
-{
-    if (!timer->inout && timer->out_val != level) {
-        timer->out_val = level;
-        qemu_set_irq(timer->out, level);
-    }
-}
-
-static inline uint32_t omap_gp_timer_read(struct omap_gp_timer_s *timer)
-{
-    uint64_t distance;
-
-    if (timer->st && timer->rate) {
-        distance = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - timer->time;
-        distance = muldiv64(distance, timer->rate, timer->ticks_per_sec);
-
-        if (distance >= 0xffffffff - timer->val)
-            return 0xffffffff;
-        else
-            return timer->val + distance;
-    } else
-        return timer->val;
-}
-
-static inline void omap_gp_timer_sync(struct omap_gp_timer_s *timer)
-{
-    if (timer->st) {
-        timer->val = omap_gp_timer_read(timer);
-        timer->time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    }
-}
-
-static inline void omap_gp_timer_update(struct omap_gp_timer_s *timer)
-{
-    int64_t expires, matches;
-
-    if (timer->st && timer->rate) {
-        expires = muldiv64(0x100000000ll - timer->val,
-                        timer->ticks_per_sec, timer->rate);
-        timer_mod(timer->timer, timer->time + expires);
-
-        if (timer->ce && timer->match_val >= timer->val) {
-            matches = muldiv64(timer->ticks_per_sec,
-                               timer->match_val - timer->val, timer->rate);
-            timer_mod(timer->match, timer->time + matches);
-        } else
-            timer_del(timer->match);
-    } else {
-        timer_del(timer->timer);
-        timer_del(timer->match);
-        omap_gp_timer_out(timer, timer->scpwm);
-    }
-}
-
-static inline void omap_gp_timer_trigger(struct omap_gp_timer_s *timer)
-{
-    if (timer->pt)
-        /* TODO in overflow-and-match mode if the first event to
-         * occur is the match, don't toggle.  */
-        omap_gp_timer_out(timer, !timer->out_val);
-    else
-        /* TODO inverted pulse on timer->out_val == 1?  */
-        qemu_irq_pulse(timer->out);
-}
-
-static void omap_gp_timer_tick(void *opaque)
-{
-    struct omap_gp_timer_s *timer = opaque;
-
-    if (!timer->ar) {
-        timer->st = 0;
-        timer->val = 0;
-    } else {
-        timer->val = timer->load_val;
-        timer->time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    }
-
-    if (timer->trigger == gpt_trigger_overflow ||
-                    timer->trigger == gpt_trigger_both)
-        omap_gp_timer_trigger(timer);
-
-    omap_gp_timer_intr(timer, GPT_OVF_IT);
-    omap_gp_timer_update(timer);
-}
-
-static void omap_gp_timer_match(void *opaque)
-{
-    struct omap_gp_timer_s *timer = opaque;
-
-    if (timer->trigger == gpt_trigger_both)
-        omap_gp_timer_trigger(timer);
-
-    omap_gp_timer_intr(timer, GPT_MAT_IT);
-}
-
-static void omap_gp_timer_input(void *opaque, int line, int on)
-{
-    struct omap_gp_timer_s *s = opaque;
-    int trigger;
-
-    switch (s->capture) {
-    default:
-    case gpt_capture_none:
-        trigger = 0;
-        break;
-    case gpt_capture_rising:
-        trigger = !s->in_val && on;
-        break;
-    case gpt_capture_falling:
-        trigger = s->in_val && !on;
-        break;
-    case gpt_capture_both:
-        trigger = (s->in_val == !on);
-        break;
-    }
-    s->in_val = on;
-
-    if (s->inout && trigger && s->capt_num < 2) {
-        s->capture_val[s->capt_num] = omap_gp_timer_read(s);
-
-        if (s->capt2 == s->capt_num ++)
-            omap_gp_timer_intr(s, GPT_TCAR_IT);
-    }
-}
-
-static void omap_gp_timer_clk_update(void *opaque, int line, int on)
-{
-    struct omap_gp_timer_s *timer = opaque;
-
-    omap_gp_timer_sync(timer);
-    timer->rate = on ? omap_clk_getrate(timer->clk) : 0;
-    omap_gp_timer_update(timer);
-}
-
-static void omap_gp_timer_clk_setup(struct omap_gp_timer_s *timer)
-{
-    omap_clk_adduser(timer->clk,
-                     qemu_allocate_irq(omap_gp_timer_clk_update, timer, 0));
-    timer->rate = omap_clk_getrate(timer->clk);
-}
-
-void omap_gp_timer_reset(struct omap_gp_timer_s *s)
-{
-    s->config = 0x000;
-    s->status = 0;
-    s->it_ena = 0;
-    s->wu_ena = 0;
-    s->inout = 0;
-    s->capt2 = 0;
-    s->capt_num = 0;
-    s->pt = 0;
-    s->trigger = gpt_trigger_none;
-    s->capture = gpt_capture_none;
-    s->scpwm = 0;
-    s->ce = 0;
-    s->pre = 0;
-    s->ptv = 0;
-    s->ar = 0;
-    s->st = 0;
-    s->posted = 1;
-    s->val = 0x00000000;
-    s->load_val = 0x00000000;
-    s->capture_val[0] = 0x00000000;
-    s->capture_val[1] = 0x00000000;
-    s->match_val = 0x00000000;
-    omap_gp_timer_update(s);
-}
-
-static uint32_t omap_gp_timer_readw(void *opaque, hwaddr addr)
-{
-    struct omap_gp_timer_s *s = opaque;
-
-    switch (addr) {
-    case 0x00:	/* TIDR */
-        return 0x21;
-
-    case 0x10:	/* TIOCP_CFG */
-        return s->config;
-
-    case 0x14:	/* TISTAT */
-        /* ??? When's this bit reset? */
-        return 1;						/* RESETDONE */
-
-    case 0x18:	/* TISR */
-        return s->status;
-
-    case 0x1c:	/* TIER */
-        return s->it_ena;
-
-    case 0x20:	/* TWER */
-        return s->wu_ena;
-
-    case 0x24:	/* TCLR */
-        return (s->inout << 14) |
-                (s->capt2 << 13) |
-                (s->pt << 12) |
-                (s->trigger << 10) |
-                (s->capture << 8) |
-                (s->scpwm << 7) |
-                (s->ce << 6) |
-                (s->pre << 5) |
-                (s->ptv << 2) |
-                (s->ar << 1) |
-                (s->st << 0);
-
-    case 0x28:	/* TCRR */
-        return omap_gp_timer_read(s);
-
-    case 0x2c:	/* TLDR */
-        return s->load_val;
-
-    case 0x30:	/* TTGR */
-        return 0xffffffff;
-
-    case 0x34:	/* TWPS */
-        return 0x00000000;	/* No posted writes pending.  */
-
-    case 0x38:	/* TMAR */
-        return s->match_val;
-
-    case 0x3c:	/* TCAR1 */
-        return s->capture_val[0];
-
-    case 0x40:	/* TSICR */
-        return s->posted << 2;
-
-    case 0x44:	/* TCAR2 */
-        return s->capture_val[1];
-    }
-
-    OMAP_BAD_REG(addr);
-    return 0;
-}
-
-static uint32_t omap_gp_timer_readh(void *opaque, hwaddr addr)
-{
-    struct omap_gp_timer_s *s = opaque;
-    uint32_t ret;
-
-    if (addr & 2)
-        return s->readh;
-    else {
-        ret = omap_gp_timer_readw(opaque, addr);
-        s->readh = ret >> 16;
-        return ret & 0xffff;
-    }
-}
-
-static void omap_gp_timer_write(void *opaque, hwaddr addr, uint32_t value)
-{
-    struct omap_gp_timer_s *s = opaque;
-
-    switch (addr) {
-    case 0x00:	/* TIDR */
-    case 0x14:	/* TISTAT */
-    case 0x34:	/* TWPS */
-    case 0x3c:	/* TCAR1 */
-    case 0x44:	/* TCAR2 */
-        OMAP_RO_REG(addr);
-        break;
-
-    case 0x10:	/* TIOCP_CFG */
-        s->config = value & 0x33d;
-        if (((value >> 3) & 3) == 3)				/* IDLEMODE */
-            fprintf(stderr, "%s: illegal IDLEMODE value in TIOCP_CFG\n",
-                            __func__);
-        if (value & 2)						/* SOFTRESET */
-            omap_gp_timer_reset(s);
-        break;
-
-    case 0x18:	/* TISR */
-        if (value & GPT_TCAR_IT)
-            s->capt_num = 0;
-        if (s->status && !(s->status &= ~value))
-            qemu_irq_lower(s->irq);
-        break;
-
-    case 0x1c:	/* TIER */
-        s->it_ena = value & 7;
-        break;
-
-    case 0x20:	/* TWER */
-        s->wu_ena = value & 7;
-        break;
-
-    case 0x24:	/* TCLR */
-        omap_gp_timer_sync(s);
-        s->inout = (value >> 14) & 1;
-        s->capt2 = (value >> 13) & 1;
-        s->pt = (value >> 12) & 1;
-        s->trigger = (value >> 10) & 3;
-        if (s->capture == gpt_capture_none &&
-                        ((value >> 8) & 3) != gpt_capture_none)
-            s->capt_num = 0;
-        s->capture = (value >> 8) & 3;
-        s->scpwm = (value >> 7) & 1;
-        s->ce = (value >> 6) & 1;
-        s->pre = (value >> 5) & 1;
-        s->ptv = (value >> 2) & 7;
-        s->ar = (value >> 1) & 1;
-        s->st = (value >> 0) & 1;
-        if (s->inout && s->trigger != gpt_trigger_none)
-            fprintf(stderr, "%s: GP timer pin must be an output "
-                            "for this trigger mode\n", __func__);
-        if (!s->inout && s->capture != gpt_capture_none)
-            fprintf(stderr, "%s: GP timer pin must be an input "
-                            "for this capture mode\n", __func__);
-        if (s->trigger == gpt_trigger_none)
-            omap_gp_timer_out(s, s->scpwm);
-        /* TODO: make sure this doesn't overflow 32-bits */
-        s->ticks_per_sec = NANOSECONDS_PER_SECOND << (s->pre ? s->ptv + 1 : 0);
-        omap_gp_timer_update(s);
-        break;
-
-    case 0x28:	/* TCRR */
-        s->time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        s->val = value;
-        omap_gp_timer_update(s);
-        break;
-
-    case 0x2c:	/* TLDR */
-        s->load_val = value;
-        break;
-
-    case 0x30:	/* TTGR */
-        s->time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        s->val = s->load_val;
-        omap_gp_timer_update(s);
-        break;
-
-    case 0x38:	/* TMAR */
-        omap_gp_timer_sync(s);
-        s->match_val = value;
-        omap_gp_timer_update(s);
-        break;
-
-    case 0x40:	/* TSICR */
-        s->posted = (value >> 2) & 1;
-        if (value & 2)	/* How much exactly are we supposed to reset? */
-            omap_gp_timer_reset(s);
-        break;
-
-    default:
-        OMAP_BAD_REG(addr);
-    }
-}
-
-static void omap_gp_timer_writeh(void *opaque, hwaddr addr, uint32_t value)
-{
-    struct omap_gp_timer_s *s = opaque;
-
-    if (addr & 2)
-        omap_gp_timer_write(opaque, addr, (value << 16) | s->writeh);
-    else
-        s->writeh = (uint16_t) value;
-}
-
-static uint64_t omap_gp_timer_readfn(void *opaque, hwaddr addr,
-                                     unsigned size)
-{
-    switch (size) {
-    case 1:
-        return omap_badwidth_read32(opaque, addr);
-    case 2:
-        return omap_gp_timer_readh(opaque, addr);
-    case 4:
-        return omap_gp_timer_readw(opaque, addr);
-    default:
-        g_assert_not_reached();
-    }
-}
-
-static void omap_gp_timer_writefn(void *opaque, hwaddr addr,
-                                  uint64_t value, unsigned size)
-{
-    switch (size) {
-    case 1:
-        omap_badwidth_write32(opaque, addr, value);
-        break;
-    case 2:
-        omap_gp_timer_writeh(opaque, addr, value);
-        break;
-    case 4:
-        omap_gp_timer_write(opaque, addr, value);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
-static const MemoryRegionOps omap_gp_timer_ops = {
-    .read = omap_gp_timer_readfn,
-    .write = omap_gp_timer_writefn,
-    .valid.min_access_size = 1,
-    .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-struct omap_gp_timer_s *omap_gp_timer_init(struct omap_target_agent_s *ta,
-                qemu_irq irq, omap_clk fclk, omap_clk iclk)
-{
-    struct omap_gp_timer_s *s = g_new0(struct omap_gp_timer_s, 1);
-
-    s->ta = ta;
-    s->irq = irq;
-    s->clk = fclk;
-    s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, omap_gp_timer_tick, s);
-    s->match = timer_new_ns(QEMU_CLOCK_VIRTUAL, omap_gp_timer_match, s);
-    s->in = qemu_allocate_irq(omap_gp_timer_input, s, 0);
-    omap_gp_timer_reset(s);
-    omap_gp_timer_clk_setup(s);
-
-    memory_region_init_io(&s->iomem, NULL, &omap_gp_timer_ops, s, "omap.gptimer",
-                          omap_l4_region_size(ta, 0));
-    omap_l4_attach(ta, 0, &s->iomem);
-
-    return s;
-}
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
index 3a78636ab45..1292d9530ca 100644
--- a/hw/timer/meson.build
+++ b/hw/timer/meson.build
@@ -22,7 +22,6 @@ system_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_gictimer.c'))
 system_ss.add(when: 'CONFIG_MSF2', if_true: files('mss-timer.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_timer.c'))
 system_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_timer.c'))
-system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_gptimer.c'))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_synctimer.c'))
 system_ss.add(when: 'CONFIG_PXA2XX_TIMER', if_true: files('pxa2xx_timer.c'))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_systmr.c'))
-- 
2.34.1


