Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7710EE499D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMGr-0004e1-LU; Wed, 11 Sep 2024 08:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMGp-0004Oz-TR
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:16:28 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMGn-0007Sq-3P
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:16:27 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-374b25263a3so4100943f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726056982; x=1726661782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eFUk37DLyCr0AazZd47pgyzyukkjvKkEOrg0L3PVrdo=;
 b=VdzspjAKwKpvOuNipRivrkzKBce26FSvHwZwRVEWwOo/WRcJMkthCRiv3RJWK+Yo5t
 GYOpBtVRlEegobRiSGjwhZIh+ajMo/wIz6OWS7lD4WvOAEueP0cu08/mqmJv9rJurcJX
 DYB6ANBTmJi1u7MwMNCzDJIyJ4btkXf2pOPi+gXuW0lTJti//fZVTBTekd+RbeI7E7Nr
 EZ1PR+wDjZSu2Q4VN3RwA7ddjwKgvQOjOrNxvm1z4TecxQV2cQVjfNkz312qaRbzJd/Q
 CNDG/XTzG7ZqqpA5j/QWUGLgSvs/lzRsM+qZNZox8ABrlp24gaQcaHw3zuXQ2VNHWMLK
 tTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726056982; x=1726661782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eFUk37DLyCr0AazZd47pgyzyukkjvKkEOrg0L3PVrdo=;
 b=Nw7aCPwt62amsShaESV+VzBWNfBHnzqDHmLB7Kdo3WpB5yVbSidxgZNLJFVnnIPj8z
 DOdStqPlqjouhbsmNP14nToabOu3CeKCzDMfgrsyhpdpLDUFpfbsDh5hRndZfr3KMzbS
 9pCq/Dd9HxqFkO5GlGgByaOh9gkGRL6ScHc/FEW4XTtelpLwcgn4i5KUsJonv+Ckpg5C
 QUHrWFTT65qGozrXgIUsXXErhlltTzxGbftGENB1jBE6UKvYZ7KBxL5vEC/gDQiM1p4i
 Ba4zv2a/TDhd0GSEGQW0siZYsFlbwMimGDIKZNPIiOSoT8ueesIdE7Vnpz7pzKlULfzX
 6DhA==
X-Gm-Message-State: AOJu0YxCVaUsVOm/qR2vQzIE6V80E1HhQi3AlmY4fA315HX28m6gg5oC
 o7lQWtyEGjSxuroouDAKTJRkE6ZQNY7Z3HWFAtXdN17KmYvdArArODens0yfks6bDYISmAMNFPk
 e
X-Google-Smtp-Source: AGHT+IH7PJ58Td38kRCkTIT6buhrPBneFAlGfChbTj7GnwiDQ+/ffgNmo4FBDPqxmHGKwdKzBC6JmQ==
X-Received: by 2002:a05:6000:cc:b0:374:c269:df79 with SMTP id
 ffacd0b85a97d-378949f7e28mr8472637f8f.22.1726056981783; 
 Wed, 11 Sep 2024 05:16:21 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956dddacsm11319445f8f.107.2024.09.11.05.16.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:16:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 17/56] hw/timer: Remove TYPE_ETRAX_FS_TIMER device
Date: Wed, 11 Sep 2024 14:13:42 +0200
Message-ID: <20240911121422.52585-18-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
Message-ID: <20240904143603.52934-12-philmd@linaro.org>
---
 MAINTAINERS                         |   8 -
 hw/timer/etraxfs_timer.c            | 407 ----------------------------
 hw/Kconfig                          |   1 -
 hw/cris/Kconfig                     |   3 -
 hw/timer/meson.build                |   1 -
 scripts/coverity-scan/COMPONENTS.md |   2 +-
 6 files changed, 1 insertion(+), 421 deletions(-)
 delete mode 100644 hw/timer/etraxfs_timer.c
 delete mode 100644 hw/cris/Kconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index 2f505be253..06948c9ec0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -228,7 +228,6 @@ CRIS TCG CPUs
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
 F: target/cris/
-F: hw/cris/
 F: disas/cris.c
 
 Hexagon TCG CPUs
@@ -1210,13 +1209,6 @@ M: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Maintained
 F: hw/avr/arduino.c
 
-CRIS Machines
--------------
-Etrax hardware
-M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
-S: Maintained
-F: hw/*/etraxfs_*.c
-
 HP-PARISC Machines
 ------------------
 HP B160L, HP C3700
diff --git a/hw/timer/etraxfs_timer.c b/hw/timer/etraxfs_timer.c
deleted file mode 100644
index dd6d96b0a1..0000000000
--- a/hw/timer/etraxfs_timer.c
+++ /dev/null
@@ -1,407 +0,0 @@
-/*
- * QEMU ETRAX Timers
- *
- * Copyright (c) 2007 Edgar E. Iglesias, Axis Communications AB.
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
-#include "sysemu/reset.h"
-#include "sysemu/runstate.h"
-#include "migration/vmstate.h"
-#include "qemu/module.h"
-#include "qemu/timer.h"
-#include "hw/irq.h"
-#include "hw/ptimer.h"
-#include "qom/object.h"
-
-#define D(x)
-
-#define RW_TMR0_DIV   0x00
-#define R_TMR0_DATA   0x04
-#define RW_TMR0_CTRL  0x08
-#define RW_TMR1_DIV   0x10
-#define R_TMR1_DATA   0x14
-#define RW_TMR1_CTRL  0x18
-#define R_TIME        0x38
-#define RW_WD_CTRL    0x40
-#define R_WD_STAT     0x44
-#define RW_INTR_MASK  0x48
-#define RW_ACK_INTR   0x4c
-#define R_INTR        0x50
-#define R_MASKED_INTR 0x54
-
-#define TYPE_ETRAX_FS_TIMER "etraxfs-timer"
-typedef struct ETRAXTimerState ETRAXTimerState;
-DECLARE_INSTANCE_CHECKER(ETRAXTimerState, ETRAX_TIMER,
-                         TYPE_ETRAX_FS_TIMER)
-
-struct ETRAXTimerState {
-    SysBusDevice parent_obj;
-
-    MemoryRegion mmio;
-    qemu_irq irq;
-    qemu_irq nmi;
-
-    ptimer_state *ptimer_t0;
-    ptimer_state *ptimer_t1;
-    ptimer_state *ptimer_wd;
-
-    uint32_t wd_hits;
-
-    /* Control registers.  */
-    uint32_t rw_tmr0_div;
-    uint32_t r_tmr0_data;
-    uint32_t rw_tmr0_ctrl;
-
-    uint32_t rw_tmr1_div;
-    uint32_t r_tmr1_data;
-    uint32_t rw_tmr1_ctrl;
-
-    uint32_t rw_wd_ctrl;
-
-    uint32_t rw_intr_mask;
-    uint32_t rw_ack_intr;
-    uint32_t r_intr;
-    uint32_t r_masked_intr;
-};
-
-static const VMStateDescription vmstate_etraxfs = {
-    .name = "etraxfs",
-    .version_id = 0,
-    .minimum_version_id = 0,
-    .fields = (const VMStateField[]) {
-        VMSTATE_PTIMER(ptimer_t0, ETRAXTimerState),
-        VMSTATE_PTIMER(ptimer_t1, ETRAXTimerState),
-        VMSTATE_PTIMER(ptimer_wd, ETRAXTimerState),
-
-        VMSTATE_UINT32(wd_hits, ETRAXTimerState),
-
-        VMSTATE_UINT32(rw_tmr0_div, ETRAXTimerState),
-        VMSTATE_UINT32(r_tmr0_data, ETRAXTimerState),
-        VMSTATE_UINT32(rw_tmr0_ctrl, ETRAXTimerState),
-
-        VMSTATE_UINT32(rw_tmr1_div, ETRAXTimerState),
-        VMSTATE_UINT32(r_tmr1_data, ETRAXTimerState),
-        VMSTATE_UINT32(rw_tmr1_ctrl, ETRAXTimerState),
-
-        VMSTATE_UINT32(rw_wd_ctrl, ETRAXTimerState),
-
-        VMSTATE_UINT32(rw_intr_mask, ETRAXTimerState),
-        VMSTATE_UINT32(rw_ack_intr, ETRAXTimerState),
-        VMSTATE_UINT32(r_intr, ETRAXTimerState),
-        VMSTATE_UINT32(r_masked_intr, ETRAXTimerState),
-
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static uint64_t
-timer_read(void *opaque, hwaddr addr, unsigned int size)
-{
-    ETRAXTimerState *t = opaque;
-    uint32_t r = 0;
-
-    switch (addr) {
-    case R_TMR0_DATA:
-        r = ptimer_get_count(t->ptimer_t0);
-        break;
-    case R_TMR1_DATA:
-        r = ptimer_get_count(t->ptimer_t1);
-        break;
-    case R_TIME:
-        r = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / 10;
-        break;
-    case RW_INTR_MASK:
-        r = t->rw_intr_mask;
-        break;
-    case R_MASKED_INTR:
-        r = t->r_intr & t->rw_intr_mask;
-        break;
-    default:
-        D(printf ("%s %x\n", __func__, addr));
-        break;
-    }
-    return r;
-}
-
-static void update_ctrl(ETRAXTimerState *t, int tnum)
-{
-    unsigned int op;
-    unsigned int freq;
-    unsigned int freq_hz;
-    unsigned int div;
-    uint32_t ctrl;
-
-    ptimer_state *timer;
-
-    if (tnum == 0) {
-        ctrl = t->rw_tmr0_ctrl;
-        div = t->rw_tmr0_div;
-        timer = t->ptimer_t0;
-    } else {
-        ctrl = t->rw_tmr1_ctrl;
-        div = t->rw_tmr1_div;
-        timer = t->ptimer_t1;
-    }
-
-
-    op = ctrl & 3;
-    freq = ctrl >> 2;
-    freq_hz = 32000000;
-
-    switch (freq)
-    {
-    case 0:
-    case 1:
-        D(printf ("extern or disabled timer clock?\n"));
-        break;
-    case 4: freq_hz =  29493000; break;
-    case 5: freq_hz =  32000000; break;
-    case 6: freq_hz =  32768000; break;
-    case 7: freq_hz = 100000000; break;
-    default:
-        abort();
-        break;
-    }
-
-    D(printf ("freq_hz=%d div=%d\n", freq_hz, div));
-    ptimer_transaction_begin(timer);
-    ptimer_set_freq(timer, freq_hz);
-    ptimer_set_limit(timer, div, 0);
-
-    switch (op)
-    {
-        case 0:
-            /* Load.  */
-            ptimer_set_limit(timer, div, 1);
-            break;
-        case 1:
-            /* Hold.  */
-            ptimer_stop(timer);
-            break;
-        case 2:
-            /* Run.  */
-            ptimer_run(timer, 0);
-            break;
-        default:
-            abort();
-            break;
-    }
-    ptimer_transaction_commit(timer);
-}
-
-static void timer_update_irq(ETRAXTimerState *t)
-{
-    t->r_intr &= ~(t->rw_ack_intr);
-    t->r_masked_intr = t->r_intr & t->rw_intr_mask;
-
-    D(printf("%s: masked_intr=%x\n", __func__, t->r_masked_intr));
-    qemu_set_irq(t->irq, !!t->r_masked_intr);
-}
-
-static void timer0_hit(void *opaque)
-{
-    ETRAXTimerState *t = opaque;
-    t->r_intr |= 1;
-    timer_update_irq(t);
-}
-
-static void timer1_hit(void *opaque)
-{
-    ETRAXTimerState *t = opaque;
-    t->r_intr |= 2;
-    timer_update_irq(t);
-}
-
-static void watchdog_hit(void *opaque)
-{
-    ETRAXTimerState *t = opaque;
-    if (t->wd_hits == 0) {
-        /* real hw gives a single tick before resetting but we are
-           a bit friendlier to compensate for our slower execution.  */
-        ptimer_set_count(t->ptimer_wd, 10);
-        ptimer_run(t->ptimer_wd, 1);
-        qemu_irq_raise(t->nmi);
-    }
-    else
-        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-
-    t->wd_hits++;
-}
-
-static inline void timer_watchdog_update(ETRAXTimerState *t, uint32_t value)
-{
-    unsigned int wd_en = t->rw_wd_ctrl & (1 << 8);
-    unsigned int wd_key = t->rw_wd_ctrl >> 9;
-    unsigned int wd_cnt = t->rw_wd_ctrl & 511;
-    unsigned int new_key = value >> 9 & ((1 << 7) - 1);
-    unsigned int new_cmd = (value >> 8) & 1;
-
-    /* If the watchdog is enabled, they written key must match the
-       complement of the previous.  */
-    wd_key = ~wd_key & ((1 << 7) - 1);
-
-    if (wd_en && wd_key != new_key)
-        return;
-
-    D(printf("en=%d new_key=%x oldkey=%x cmd=%d cnt=%d\n", 
-         wd_en, new_key, wd_key, new_cmd, wd_cnt));
-
-    if (t->wd_hits)
-        qemu_irq_lower(t->nmi);
-
-    t->wd_hits = 0;
-
-    ptimer_transaction_begin(t->ptimer_wd);
-    ptimer_set_freq(t->ptimer_wd, 760);
-    if (wd_cnt == 0)
-        wd_cnt = 256;
-    ptimer_set_count(t->ptimer_wd, wd_cnt);
-    if (new_cmd)
-        ptimer_run(t->ptimer_wd, 1);
-    else
-        ptimer_stop(t->ptimer_wd);
-
-    t->rw_wd_ctrl = value;
-    ptimer_transaction_commit(t->ptimer_wd);
-}
-
-static void
-timer_write(void *opaque, hwaddr addr,
-            uint64_t val64, unsigned int size)
-{
-    ETRAXTimerState *t = opaque;
-    uint32_t value = val64;
-
-    switch (addr)
-    {
-        case RW_TMR0_DIV:
-            t->rw_tmr0_div = value;
-            break;
-        case RW_TMR0_CTRL:
-            D(printf ("RW_TMR0_CTRL=%x\n", value));
-            t->rw_tmr0_ctrl = value;
-            update_ctrl(t, 0);
-            break;
-        case RW_TMR1_DIV:
-            t->rw_tmr1_div = value;
-            break;
-        case RW_TMR1_CTRL:
-            D(printf ("RW_TMR1_CTRL=%x\n", value));
-            t->rw_tmr1_ctrl = value;
-            update_ctrl(t, 1);
-            break;
-        case RW_INTR_MASK:
-            D(printf ("RW_INTR_MASK=%x\n", value));
-            t->rw_intr_mask = value;
-            timer_update_irq(t);
-            break;
-        case RW_WD_CTRL:
-            timer_watchdog_update(t, value);
-            break;
-        case RW_ACK_INTR:
-            t->rw_ack_intr = value;
-            timer_update_irq(t);
-            t->rw_ack_intr = 0;
-            break;
-        default:
-            printf("%s " HWADDR_FMT_plx " %x\n", __func__, addr, value);
-            break;
-    }
-}
-
-static const MemoryRegionOps timer_ops = {
-    .read = timer_read,
-    .write = timer_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-    .valid = {
-        .min_access_size = 4,
-        .max_access_size = 4
-    }
-};
-
-static void etraxfs_timer_reset_enter(Object *obj, ResetType type)
-{
-    ETRAXTimerState *t = ETRAX_TIMER(obj);
-
-    ptimer_transaction_begin(t->ptimer_t0);
-    ptimer_stop(t->ptimer_t0);
-    ptimer_transaction_commit(t->ptimer_t0);
-    ptimer_transaction_begin(t->ptimer_t1);
-    ptimer_stop(t->ptimer_t1);
-    ptimer_transaction_commit(t->ptimer_t1);
-    ptimer_transaction_begin(t->ptimer_wd);
-    ptimer_stop(t->ptimer_wd);
-    ptimer_transaction_commit(t->ptimer_wd);
-    t->rw_wd_ctrl = 0;
-    t->r_intr = 0;
-    t->rw_intr_mask = 0;
-}
-
-static void etraxfs_timer_reset_hold(Object *obj, ResetType type)
-{
-    ETRAXTimerState *t = ETRAX_TIMER(obj);
-
-    qemu_irq_lower(t->irq);
-}
-
-static void etraxfs_timer_realize(DeviceState *dev, Error **errp)
-{
-    ETRAXTimerState *t = ETRAX_TIMER(dev);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-
-    t->ptimer_t0 = ptimer_init(timer0_hit, t, PTIMER_POLICY_LEGACY);
-    t->ptimer_t1 = ptimer_init(timer1_hit, t, PTIMER_POLICY_LEGACY);
-    t->ptimer_wd = ptimer_init(watchdog_hit, t, PTIMER_POLICY_LEGACY);
-
-    sysbus_init_irq(sbd, &t->irq);
-    sysbus_init_irq(sbd, &t->nmi);
-
-    memory_region_init_io(&t->mmio, OBJECT(t), &timer_ops, t,
-                          "etraxfs-timer", 0x5c);
-    sysbus_init_mmio(sbd, &t->mmio);
-}
-
-static void etraxfs_timer_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    ResettableClass *rc = RESETTABLE_CLASS(klass);
-
-    dc->realize = etraxfs_timer_realize;
-    dc->vmsd = &vmstate_etraxfs;
-    rc->phases.enter = etraxfs_timer_reset_enter;
-    rc->phases.hold = etraxfs_timer_reset_hold;
-}
-
-static const TypeInfo etraxfs_timer_info = {
-    .name          = TYPE_ETRAX_FS_TIMER,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(ETRAXTimerState),
-    .class_init    = etraxfs_timer_class_init,
-};
-
-static void etraxfs_timer_register_types(void)
-{
-    type_register_static(&etraxfs_timer_info);
-}
-
-type_init(etraxfs_timer_register_types)
diff --git a/hw/Kconfig b/hw/Kconfig
index f7866e76f7..6fdaff1b1b 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -50,7 +50,6 @@ source arm/Kconfig
 source cpu/Kconfig
 source alpha/Kconfig
 source avr/Kconfig
-source cris/Kconfig
 source hppa/Kconfig
 source i386/Kconfig
 source loongarch/Kconfig
diff --git a/hw/cris/Kconfig b/hw/cris/Kconfig
deleted file mode 100644
index 3f0680cf09..0000000000
--- a/hw/cris/Kconfig
+++ /dev/null
@@ -1,3 +0,0 @@
-config ETRAXFS
-   bool
-   select PTIMER
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
index 80427852e0..5b6c8b4be9 100644
--- a/hw/timer/meson.build
+++ b/hw/timer/meson.build
@@ -10,7 +10,6 @@ system_ss.add(when: 'CONFIG_CMSDK_APB_TIMER', if_true: files('cmsdk-apb-timer.c'
 system_ss.add(when: 'CONFIG_RENESAS_TMR', if_true: files('renesas_tmr.c'))
 system_ss.add(when: 'CONFIG_RENESAS_CMT', if_true: files('renesas_cmt.c'))
 system_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic-timer.c'))
-system_ss.add(when: 'CONFIG_ETRAXFS', if_true: files('etraxfs_timer.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_mct.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pwm.c'))
 system_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_gptimer.c'))
diff --git a/scripts/coverity-scan/COMPONENTS.md b/scripts/coverity-scan/COMPONENTS.md
index 5851df5b56..c12ae9e49c 100644
--- a/scripts/coverity-scan/COMPONENTS.md
+++ b/scripts/coverity-scan/COMPONENTS.md
@@ -10,7 +10,7 @@ avr
   ~ .*/qemu((/include)?/hw/avr/.*|/target/avr/.*)
 
 cris
-  ~ .*/qemu(/hw/cris/.*|/target/cris/.*)
+  ~ .*/qemu/target/cris/.*
 
 hexagon-gen (component should be ignored in analysis)
   ~ .*/qemu(/target/hexagon/.*generated.*)
-- 
2.45.2


