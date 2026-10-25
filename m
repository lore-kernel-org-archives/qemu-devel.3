Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6F2606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 17:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL23O-0008UW-Gn; Sun, 25 Oct 2026 13:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL23A-0008Ko-HG; Sun, 25 Oct 2026 13:30:30 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL237-0007Er-DE; Sun, 25 Oct 2026 13:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=X2tcz8FOE36NCw2Pq6qIWC9fOn5tMIbBzHxAdvEFcFY=; b=RTha+zVxQnBptAw91TrSYSnhBk
 VHyOAGAQfl1MEug8ODbCkzrnIE8mdhxmFyvm2UntWSkewsQmYnKPmAxP14xK2O4aG8ikS+T5VpHWt
 lhq4mnCRcHPzB1CKiUn9qCKwqKXUsvg0y6pCmH0Ca/KFRQB8RG0zvEEpRbo66O4k2n22DRUVvN1xP
 JD3qocDqsWfLufY1OoiaCEJQetg0QdQYhnJF5HvCqqQYjcr/82g5PnCTjhA/hnhNRCbsFqjguuA7G
 v04qqz7DTw6mIG4ON6cUFF1XYFt9htInmZshPUEqF7izWCwr7LhmNYosTPJ/3XuWWPyah3GG2S5YD
 exYvPYPA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1gR-00098R-2T; Sun, 25 Oct 2026 18:06:59 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vw-000OzG-1a; Sun, 25 Oct 2026 17:56:08 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 25 Oct 2026 17:55:35 +0100
Subject: [PATCH v2 19/31] hw/timer: add Renesas RX MTU3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-umar-rx-series-v2-19-9e846577cad0@sayyadumar.com>
References: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
In-Reply-To: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=20356;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=q4hYS297c01yFZAB5EE4lcinvjl4I/XiwtYAPrIn0vM=;
 b=C0QQWg0klRXASwT6Qwf2oJbFAET/jrUnUgzWDno33eVrCG1O6VUM8ty1HlCzE+xcdxjIjzen5
 ed6uWmMYn4UC6GrD9/JwCB2fp5yJ/9Vm8x/CsP0KhjY9xFF0YHFYW8M
X-Developer-Key: i=contact@sayyadumar.com; a=ed25519;
 pk=CsAjTLRCB7+pnzmj8902JER4gL8CTzNQFxlMZTl4wDk=
X-Virus-Scanned: Clear (ClamAV 1.4.6/28164/Sun Oct 25 07:24:12 2026)
Received-SPF: pass client-ip=85.10.213.182;
 envelope-from=contact@sayyadumar.com; helo=www675.your-server.de
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the Multi-Function Timer Pulse Unit 3, modelling MTU channels 3
and 4 (the pair sharing base address 0x000C1200).

Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
           (Rev.1.00 R01UH0590EJ0100), Section 17

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 MAINTAINERS                            |   2 +
 configs/devices/rx-softmmu/default.mak |   1 +
 hw/timer/Kconfig                       |   2 +
 hw/timer/meson.build                   |   1 +
 hw/timer/renesas_mtu3.c                | 509 +++++++++++++++++++++++++++++++++
 include/hw/timer/renesas_mtu3.h        |  73 +++++
 6 files changed, 588 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ca1751e30..260d70797b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3083,8 +3083,10 @@ R: Yoshinori Sato <yoshinori.sato@nifty.com>
 S: Orphan
 F: hw/intc/rx_icu.c
 F: hw/rx/
+F: hw/timer/renesas_mtu3.c
 F: include/hw/intc/rx_icu.h
 F: include/hw/rx/
+F: include/hw/timer/renesas_mtu3.h
 
 CAN bus subsystem and hardware
 M: Pavel Pisa <pisa@cmp.felk.cvut.cz>
diff --git a/configs/devices/rx-softmmu/default.mak b/configs/devices/rx-softmmu/default.mak
index e7caebe197..d99f506125 100644
--- a/configs/devices/rx-softmmu/default.mak
+++ b/configs/devices/rx-softmmu/default.mak
@@ -2,3 +2,4 @@
 
 # Boards are selected by default, uncomment to keep out of the build.
 # CONFIG_RX_GDBSIM=n
+CONFIG_RENESAS_MTU3=y
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index e1b751a54a..4d8a53a30a 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -68,3 +68,5 @@ config AVR_TIMER16
 
 config HEX_QTIMER
     bool
+config RENESAS_MTU3
+    bool
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
index 8323efaf46..c70efba796 100644
--- a/hw/timer/meson.build
+++ b/hw/timer/meson.build
@@ -36,3 +36,4 @@ system_ss.add(when: 'CONFIG_SIFIVE_PWM', if_true: files('sifive_pwm.c'))
 system_ss.add(when: 'CONFIG_AVR_TIMER16', if_true: files('avr_timer16.c'))
 
 system_ss.add(when: 'CONFIG_HEX_QTIMER', if_true: files('qct-qtimer.c'))
+system_ss.add(when: 'CONFIG_RENESAS_MTU3', if_true: files('renesas_mtu3.c'))
diff --git a/hw/timer/renesas_mtu3.c b/hw/timer/renesas_mtu3.c
new file mode 100644
index 0000000000..7dd20843ed
--- /dev/null
+++ b/hw/timer/renesas_mtu3.c
@@ -0,0 +1,509 @@
+/*
+ * Renesas RX65N Multi-Function Timer Pulse Unit 3 (MTU3)
+ *
+ * Models MTU channels 3 and 4 (the pair sharing base address 0x000C1200).
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), Section 17
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/core/irq.h"
+#include "hw/core/registerfields.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/timer/renesas_mtu3.h"
+#include "migration/vmstate.h"
+
+/*
+ * Register offsets from device base (0x000C1200).
+ * MTU3 and MTU4 channel registers are interleaved at the base.
+ * ch[0] = MTU channel 3, ch[1] = MTU channel 4.
+ *
+ * Reference: RX65N Group Hardware Manual Table 17.1
+ */
+#define R_TCR_CH3    0x00   /* 8-bit */
+#define R_TCR_CH4    0x01   /* 8-bit */
+#define R_TMDR1_CH3  0x02   /* 8-bit */
+#define R_TMDR1_CH4  0x03   /* 8-bit */
+#define R_TIORH_CH3  0x04   /* 8-bit */
+#define R_TIORL_CH3  0x05   /* 8-bit */
+#define R_TIORH_CH4  0x06   /* 8-bit */
+#define R_TIORL_CH4  0x07   /* 8-bit */
+#define R_TIER_CH3   0x08   /* 8-bit */
+#define R_TIER_CH4   0x09   /* 8-bit */
+#define R_TCNT_CH3   0x10   /* 16-bit */
+#define R_TCNT_CH4   0x12   /* 16-bit */
+#define R_TGRA_CH3   0x18   /* 16-bit */
+#define R_TGRB_CH3   0x1A   /* 16-bit */
+#define R_TGRA_CH4   0x1C   /* 16-bit */
+#define R_TGRB_CH4   0x1E   /* 16-bit */
+#define R_TGRC_CH3   0x24   /* 16-bit */
+#define R_TGRD_CH3   0x26   /* 16-bit */
+#define R_TGRC_CH4   0x28   /* 16-bit */
+#define R_TGRD_CH4   0x2A   /* 16-bit */
+#define R_TSR_CH3    0x2C   /* 8-bit */
+#define R_TSR_CH4    0x2D   /* 8-bit */
+#define R_TSTRA      0x80   /* 8-bit: Timer Start Register A */
+
+/* TCR register fields */
+#define TCR_TPCS_MASK   0x07   /* bits [2:0]: prescale select */
+#define TCR_CCLR_SHIFT  3
+#define TCR_CCLR_MASK   (0x07 << 3)
+#define TCR_CCLR_NONE   0
+#define TCR_CCLR_TGRA   1      /* clear TCNT on TGRA match */
+#define TCR_CCLR_TGRB   2      /* clear TCNT on TGRB match */
+
+/* TIER register bits */
+#define TIER_TGIEA  (1 << 0)   /* TGRA interrupt enable */
+#define TIER_TGIEB  (1 << 1)   /* TGRB interrupt enable */
+#define TIER_TGIEC  (1 << 2)   /* TGRC interrupt enable */
+#define TIER_TGIED  (1 << 3)   /* TGRD interrupt enable */
+#define TIER_TCIEV  (1 << 4)   /* overflow interrupt enable */
+
+/* TSR register bits */
+#define TSR_TGFA    (1 << 0)   /* TGRA compare match flag */
+#define TSR_TGFB    (1 << 1)   /* TGRB compare match flag */
+#define TSR_TGFC    (1 << 2)   /* TGRC compare match flag */
+#define TSR_TGFD    (1 << 3)   /* TGRD compare match flag */
+#define TSR_TCFV    (1 << 4)   /* overflow flag */
+
+/* TSTRA register bits */
+#define TSTR_STR3   (1 << 6)   /* MTU channel 3 start */
+#define TSTR_STR4   (1 << 7)   /* MTU channel 4 start */
+
+/* Clock prescaler: index = TCR.TPCS[2:0] */
+static const uint16_t prescaler_table[8] = {1, 4, 16, 64, 256, 1024, 1, 1};
+
+static bool chan_is_running(RXMTU3State *s, int ci)
+{
+    return !!(s->tstr & (ci == 0 ? TSTR_STR3 : TSTR_STR4));
+}
+
+static uint16_t chan_read_tcnt(RXMTU3State *s, int ci)
+{
+    struct RXMTU3ChanState *ch = &s->ch[ci];
+    int64_t now, delta;
+    uint16_t prescaler;
+    int64_t elapsed;
+
+    if (!chan_is_running(s, ci)) {
+        return ch->tcnt;
+    }
+
+    prescaler = prescaler_table[ch->tcr & TCR_TPCS_MASK];
+    if (prescaler == 0) {
+        return ch->tcnt;
+    }
+
+    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    delta = now - ch->tick;
+    if (delta <= 0) {
+        return ch->tcnt;
+    }
+
+    ch->div_round += delta;
+    elapsed = ch->div_round / ((int64_t)prescaler * NANOSECONDS_PER_SECOND
+                               / s->input_freq);
+    ch->div_round %= ((int64_t)prescaler * NANOSECONDS_PER_SECOND
+                      / s->input_freq);
+    ch->tick = now;
+    ch->tcnt = (uint16_t)(ch->tcnt + elapsed);
+    return ch->tcnt;
+}
+
+static void chan_mod_timer(RXMTU3State *s, int ci)
+{
+    struct RXMTU3ChanState *ch = &s->ch[ci];
+    uint16_t prescaler;
+    uint32_t diff;
+    int64_t next_ns;
+
+    if (!chan_is_running(s, ci)) {
+        timer_del(&ch->timer);
+        return;
+    }
+
+    prescaler = prescaler_table[ch->tcr & TCR_TPCS_MASK];
+    if (prescaler == 0) {
+        timer_del(&ch->timer);
+        return;
+    }
+
+    /*
+     * Schedule at the nearer of: TGRA compare match or 16-bit overflow.
+     * TGRB/C/D are not separately scheduled here; the event handler checks
+     * all flags once the timer fires.
+     */
+    uint16_t tcnt = chan_read_tcnt(s, ci);
+    uint32_t to_tgra = (ch->tgra >= tcnt) ? (uint32_t)(ch->tgra - tcnt)
+                                           : (uint32_t)(0x10000u - tcnt);
+    uint32_t to_ovf  = (uint32_t)(0x10000u - tcnt);
+    diff = MIN(to_tgra, to_ovf);
+    if (diff == 0) {
+        diff = 0x10000u;
+    }
+
+    next_ns = (int64_t)diff * prescaler
+            * (NANOSECONDS_PER_SECOND / s->input_freq);
+    timer_mod(&ch->timer,
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + next_ns);
+}
+
+static void chan_timer_event(RXMTU3State *s, int ci)
+{
+    struct RXMTU3ChanState *ch = &s->ch[ci];
+    int base = ci * MTU3_CH_NR_IRQ;
+    uint16_t tcnt = chan_read_tcnt(s, ci);
+    uint8_t cclr = (ch->tcr & TCR_CCLR_MASK) >> TCR_CCLR_SHIFT;
+
+    /* TGRA compare match */
+    if (tcnt >= ch->tgra) {
+        ch->tsr |= TSR_TGFA;
+        if (ch->tier & TIER_TGIEA) {
+            qemu_irq_pulse(s->irq[base + MTU3_IRQ_TGIA]);
+        }
+        if (cclr == TCR_CCLR_TGRA) {
+            ch->tcnt = tcnt - ch->tgra;
+            ch->tick = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+            ch->div_round = 0;
+            chan_mod_timer(s, ci);
+            return;
+        }
+    }
+
+    /* TGRB compare match */
+    if (tcnt >= ch->tgrb && ch->tgrb != 0xffff) {
+        ch->tsr |= TSR_TGFB;
+        if (ch->tier & TIER_TGIEB) {
+            qemu_irq_pulse(s->irq[base + MTU3_IRQ_TGIB]);
+        }
+        if (cclr == TCR_CCLR_TGRB) {
+            ch->tcnt = tcnt - ch->tgrb;
+            ch->tick = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+            ch->div_round = 0;
+            chan_mod_timer(s, ci);
+            return;
+        }
+    }
+
+    /* Overflow (TCNT wraps from 0xFFFF) */
+    if (tcnt == 0 || (tcnt >= ch->tgra && ch->tgra == 0xffff)) {
+        ch->tsr |= TSR_TCFV;
+        if (ch->tier & TIER_TCIEV) {
+            qemu_irq_pulse(s->irq[base + MTU3_IRQ_TCIV]);
+        }
+    }
+
+    chan_mod_timer(s, ci);
+}
+
+static void chan0_timer_event(void *opaque)
+{
+    chan_timer_event(opaque, 0);
+}
+
+static void chan1_timer_event(void *opaque)
+{
+    chan_timer_event(opaque, 1);
+}
+
+static uint64_t mtu3_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RXMTU3State *s = opaque;
+
+    switch (addr) {
+    case R_TCR_CH3:
+        return s->ch[0].tcr;
+    case R_TCR_CH4:
+        return s->ch[1].tcr;
+    case R_TMDR1_CH3:
+        return s->ch[0].tmdr1;
+    case R_TMDR1_CH4:
+        return s->ch[1].tmdr1;
+    case R_TIORH_CH3:
+        return s->ch[0].tiorh;
+    case R_TIORL_CH3:
+        return s->ch[0].tiorl;
+    case R_TIORH_CH4:
+        return s->ch[1].tiorh;
+    case R_TIORL_CH4:
+        return s->ch[1].tiorl;
+    case R_TIER_CH3:
+        return s->ch[0].tier;
+    case R_TIER_CH4:
+        return s->ch[1].tier;
+    case R_TCNT_CH3:
+        return chan_read_tcnt(s, 0);
+    case R_TCNT_CH4:
+        return chan_read_tcnt(s, 1);
+    case R_TGRA_CH3:
+        return s->ch[0].tgra;
+    case R_TGRB_CH3:
+        return s->ch[0].tgrb;
+    case R_TGRA_CH4:
+        return s->ch[1].tgra;
+    case R_TGRB_CH4:
+        return s->ch[1].tgrb;
+    case R_TGRC_CH3:
+        return s->ch[0].tgrc;
+    case R_TGRD_CH3:
+        return s->ch[0].tgrd;
+    case R_TGRC_CH4:
+        return s->ch[1].tgrc;
+    case R_TGRD_CH4:
+        return s->ch[1].tgrd;
+    case R_TSR_CH3:
+        return s->ch[0].tsr;
+    case R_TSR_CH4:
+        return s->ch[1].tsr;
+    case R_TSTRA:
+        return s->tstr;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "renesas_mtu3: read 0x%" HWADDR_PRIX " not implemented\n",
+                      addr);
+        return UINT64_MAX;
+    }
+}
+
+static void mtu3_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    RXMTU3State *s = opaque;
+    int ci = -1;
+
+    switch (addr) {
+    case R_TCR_CH3:
+        s->ch[0].tcr = val;
+        chan_mod_timer(s, 0);
+        break;
+    case R_TCR_CH4:
+        s->ch[1].tcr = val;
+        chan_mod_timer(s, 1);
+        break;
+    case R_TMDR1_CH3:
+        s->ch[0].tmdr1 = val;
+        break;
+    case R_TMDR1_CH4:
+        s->ch[1].tmdr1 = val;
+        break;
+    case R_TIORH_CH3:
+        s->ch[0].tiorh = val;
+        break;
+    case R_TIORL_CH3:
+        s->ch[0].tiorl = val;
+        break;
+    case R_TIORH_CH4:
+        s->ch[1].tiorh = val;
+        break;
+    case R_TIORL_CH4:
+        s->ch[1].tiorl = val;
+        break;
+    case R_TIER_CH3:
+        s->ch[0].tier = val;
+        break;
+    case R_TIER_CH4:
+        s->ch[1].tier = val;
+        break;
+    case R_TCNT_CH3:
+        s->ch[0].tcnt = val;
+        s->ch[0].tick = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        s->ch[0].div_round = 0;
+        chan_mod_timer(s, 0);
+        break;
+    case R_TCNT_CH4:
+        s->ch[1].tcnt = val;
+        s->ch[1].tick = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        s->ch[1].div_round = 0;
+        chan_mod_timer(s, 1);
+        break;
+    case R_TGRA_CH3:
+        ci = 0;
+        s->ch[0].tgra = val;
+        break;
+    case R_TGRB_CH3:
+        ci = 0;
+        s->ch[0].tgrb = val;
+        break;
+    case R_TGRA_CH4:
+        ci = 1;
+        s->ch[1].tgra = val;
+        break;
+    case R_TGRB_CH4:
+        ci = 1;
+        s->ch[1].tgrb = val;
+        break;
+    case R_TGRC_CH3:
+        s->ch[0].tgrc = val;
+        break;
+    case R_TGRD_CH3:
+        s->ch[0].tgrd = val;
+        break;
+    case R_TGRC_CH4:
+        s->ch[1].tgrc = val;
+        break;
+    case R_TGRD_CH4:
+        s->ch[1].tgrd = val;
+        break;
+    case R_TSR_CH3:
+        /* W0C: clear flags that are written as 0 */
+        s->ch[0].tsr &= val;
+        break;
+    case R_TSR_CH4:
+        s->ch[1].tsr &= val;
+        break;
+    case R_TSTRA: {
+        uint8_t prev = s->tstr;
+        s->tstr = val & (TSTR_STR3 | TSTR_STR4);
+        for (int i = 0; i < MTU3_NR_CHAN; i++) {
+            uint8_t bit = (i == 0) ? TSTR_STR3 : TSTR_STR4;
+            if ((s->tstr & bit) && !(prev & bit)) {
+                /* Channel just started: latch tick */
+                s->ch[i].tick = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+                s->ch[i].div_round = 0;
+                chan_mod_timer(s, i);
+            } else if (!(s->tstr & bit) && (prev & bit)) {
+                /* Channel stopped: snapshot counter */
+                chan_read_tcnt(s, i);
+                timer_del(&s->ch[i].timer);
+            }
+        }
+        break;
+    }
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas_mtu3: write 0x%" HWADDR_PRIX
+                      " not implemented\n",
+                      addr);
+        break;
+    }
+
+    /* Re-arm timer if a TGR register was updated while channel is running */
+    if (ci >= 0 && chan_is_running(s, ci)) {
+        chan_mod_timer(s, ci);
+    }
+}
+
+static const MemoryRegionOps mtu3_ops = {
+    .read  = mtu3_read,
+    .write = mtu3_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 2,
+    },
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 2,
+    },
+};
+
+static void mtu3_reset(DeviceState *dev)
+{
+    RXMTU3State *s = RXMTU3(dev);
+    int i;
+
+    s->tstr = 0x00;
+    for (i = 0; i < MTU3_NR_CHAN; i++) {
+        s->ch[i].tcr   = 0x00;
+        s->ch[i].tmdr1 = 0x00;
+        s->ch[i].tiorh = 0x00;
+        s->ch[i].tiorl = 0x00;
+        s->ch[i].tier  = 0x00;
+        s->ch[i].tsr   = 0xc0;  /* reset value per HW manual */
+        s->ch[i].tcnt  = 0x0000;
+        s->ch[i].tgra  = 0xffff;
+        s->ch[i].tgrb  = 0xffff;
+        s->ch[i].tgrc  = 0xffff;
+        s->ch[i].tgrd  = 0xffff;
+        s->ch[i].tick  = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        s->ch[i].div_round = 0;
+        timer_del(&s->ch[i].timer);
+    }
+}
+
+static void mtu3_init(Object *obj)
+{
+    SysBusDevice *d = SYS_BUS_DEVICE(obj);
+    RXMTU3State *s = RXMTU3(obj);
+    int i;
+
+    /* 256-byte MMIO covers the interleaved MTU3/MTU4 registers + TSTR */
+    memory_region_init_io(&s->memory, obj, &mtu3_ops, s,
+                          "renesas-mtu3", 0x100);
+    sysbus_init_mmio(d, &s->memory);
+
+    for (i = 0; i < MTU3_NR_IRQ; i++) {
+        sysbus_init_irq(d, &s->irq[i]);
+    }
+
+    timer_init_ns(&s->ch[0].timer, QEMU_CLOCK_VIRTUAL, chan0_timer_event, s);
+    timer_init_ns(&s->ch[1].timer, QEMU_CLOCK_VIRTUAL, chan1_timer_event, s);
+}
+
+static const VMStateDescription vmstate_mtu3_chan = {
+    .name = "renesas-mtu3-chan",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8(tcr,   struct RXMTU3ChanState),
+        VMSTATE_UINT8(tmdr1, struct RXMTU3ChanState),
+        VMSTATE_UINT8(tiorh, struct RXMTU3ChanState),
+        VMSTATE_UINT8(tiorl, struct RXMTU3ChanState),
+        VMSTATE_UINT8(tier,  struct RXMTU3ChanState),
+        VMSTATE_UINT8(tsr,   struct RXMTU3ChanState),
+        VMSTATE_UINT16(tcnt, struct RXMTU3ChanState),
+        VMSTATE_UINT16(tgra, struct RXMTU3ChanState),
+        VMSTATE_UINT16(tgrb, struct RXMTU3ChanState),
+        VMSTATE_UINT16(tgrc, struct RXMTU3ChanState),
+        VMSTATE_UINT16(tgrd, struct RXMTU3ChanState),
+        VMSTATE_INT64(tick,  struct RXMTU3ChanState),
+        VMSTATE_INT64(div_round, struct RXMTU3ChanState),
+        VMSTATE_TIMER(timer, struct RXMTU3ChanState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_mtu3 = {
+    .name = "renesas-mtu3",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8(tstr, RXMTU3State),
+        VMSTATE_STRUCT_ARRAY(ch, RXMTU3State, MTU3_NR_CHAN, 1,
+                             vmstate_mtu3_chan, struct RXMTU3ChanState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const Property mtu3_properties[] = {
+    DEFINE_PROP_UINT64("input-freq", RXMTU3State, input_freq, 0),
+};
+
+static void mtu3_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_mtu3;
+    device_class_set_legacy_reset(dc, mtu3_reset);
+    device_class_set_props(dc, mtu3_properties);
+}
+
+static const TypeInfo mtu3_info = {
+    .name          = TYPE_RENESAS_MTU3,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RXMTU3State),
+    .instance_init = mtu3_init,
+    .class_init    = mtu3_class_init,
+};
+
+static void mtu3_register_types(void)
+{
+    type_register_static(&mtu3_info);
+}
+
+type_init(mtu3_register_types)
diff --git a/include/hw/timer/renesas_mtu3.h b/include/hw/timer/renesas_mtu3.h
new file mode 100644
index 0000000000..8d1b82aec5
--- /dev/null
+++ b/include/hw/timer/renesas_mtu3.h
@@ -0,0 +1,73 @@
+/*
+ * Renesas RX65N Multi-Function Timer Pulse Unit 3 (MTU3)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), Section 17
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_TIMER_RENESAS_MTU3_H
+#define HW_TIMER_RENESAS_MTU3_H
+
+#include "qemu/timer.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RENESAS_MTU3 "renesas-mtu3"
+typedef struct RXMTU3State RXMTU3State;
+DECLARE_INSTANCE_CHECKER(RXMTU3State, RXMTU3, TYPE_RENESAS_MTU3)
+
+/*
+ * This device models MTU3 channels 3 and 4 of the RX65N MTU3 module,
+ * which share base address 0x000C1200 with an interleaved register layout.
+ * ch[0] = MTU channel 3, ch[1] = MTU channel 4.
+ */
+enum {
+    MTU3_NR_CHAN    = 2,
+    MTU3_CH_NR_IRQ = 5,   /* TGIA, TGIB, TGIC, TGID, TCIV per channel */
+    MTU3_NR_IRQ    = MTU3_CH_NR_IRQ * MTU3_NR_CHAN   /* = 10 */
+};
+
+/* IRQ index within the per-channel group */
+enum {
+    MTU3_IRQ_TGIA = 0,
+    MTU3_IRQ_TGIB = 1,
+    MTU3_IRQ_TGIC = 2,
+    MTU3_IRQ_TGID = 3,
+    MTU3_IRQ_TCIV = 4,
+};
+
+struct RXMTU3ChanState {
+    uint8_t  tcr;
+    uint8_t  tmdr1;
+    uint8_t  tiorh;
+    uint8_t  tiorl;
+    uint8_t  tier;
+    uint8_t  tsr;
+    uint16_t tcnt;
+    uint16_t tgra;
+    uint16_t tgrb;
+    uint16_t tgrc;
+    uint16_t tgrd;
+    int64_t  tick;       /* virtual-clock time when tcnt was last latched */
+    int64_t  div_round;  /* fractional cycles accumulator */
+    QEMUTimer timer;
+};
+
+struct RXMTU3State {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion memory;
+    uint64_t input_freq;
+
+    uint8_t tstr; /* Timer Start Register A (offset 0x80) */
+    struct RXMTU3ChanState ch[MTU3_NR_CHAN];
+    qemu_irq irq[MTU3_NR_IRQ];
+};
+
+#endif /* HW_TIMER_RENESAS_MTU3_H */

-- 
2.53.0


