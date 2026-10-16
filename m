Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667ABCCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHczb-0003rx-Rz; Fri, 16 Oct 2026 04:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karthika.b@cdac.in>)
 id 1xHczG-0003oA-Cu; Fri, 16 Oct 2026 04:08:24 -0400
Received: from mailsender.cdac.in ([196.1.113.117]
 helo=mailsender-core1.pune.cdac.in)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karthika.b@cdac.in>)
 id 1xHczA-0005wZ-Np; Fri, 16 Oct 2026 04:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cdac.in; s=default;
 t=1792138089; bh=d7C0HqV9r3bcJ9cU7H6GV06qqkPVxW+XZtwdXyCLWks=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JAWRnCUONCmtdTQrx2JbwOVPRmtNofEZKI23maqsAA8SbzvbRcevzrcpYe43rdfR7
 Ox3BIS9td/UH4q+mGdj2t6Y6lMa9Lv1LgxNwrpnnv49GCTpNxMr0UuYFdYX++b8Fbo
 XJOJYztjDrD3zhVvdkNVaeUx2vC+sa36DSiLiBJw=
Received: from mscr-int.pune.cdac.in (mscr-int.pune.cdac.in [10.208.193.2])
 by mailsender.cdac.in (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 69G888PO3825296; Fri, 16 Oct 2026 13:38:09 +0530
Received: from mailgw-cip.pune.cdac.in (mscr-haproxy.pune.cdac.in
 [10.208.193.46])
 by mscr-int.pune.cdac.in (Postfix) with ESMTP id A7AD81000701F;
 Fri, 16 Oct 2026 13:37:47 +0530 (IST)
X-Auth: karthika.b@cdac.in
Received: from hdg164.tvm.cdac.in (hd_hdg164.tvm.cdac.in [10.176.18.107])
 (Authenticated sender: karthika.b@cdac.in)
 by mailgw-cip.pune.cdac.in (Postfix) with ESMTPSA id 6D99114E17D2;
 Fri, 16 Oct 2026 13:37:47 +0530 (IST)
From: Karthika B <karthika.b@cdac.in>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, sreenadh@cdac.in, raokk@cdac.in,
 Karthika B <karthika.b@cdac.in>
Subject: [PATCH 2/7] hw/intc: Add CDAC VEGA ACLINT device model
Date: Fri, 16 Oct 2026 13:37:02 +0530
Message-ID: <20261016080709.17331-3-karthika.b@cdac.in>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016080709.17331-1-karthika.b@cdac.in>
References: <385625713.441366.1761727810206@webmail2.cdac.in>
 <20261016080709.17331-1-karthika.b@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CDAC-PUNE-MailScanner-Information: Please contact the ISP for more
 information
X-CDAC-PUNE-MailScanner-ID: A7AD81000701F.AF7A2
X-CDAC-PUNE-MailScanner: Found to be clean
X-CDAC-PUNE-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=-2.9, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
 BAYES_00 -1.90)
X-CDAC-PUNE-MailScanner-From: karthika.b@cdac.in
Received-SPF: pass client-ip=196.1.113.117; envelope-from=karthika.b@cdac.in;
 helo=mailsender-core1.pune.cdac.in
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Karthika B <karthika.b@cdac.in>
---
 hw/intc/vega_aclint.c         | 668 ++++++++++++++++++++++++++++++++++
 include/hw/intc/vega_aclint.h |  84 +++++
 2 files changed, 752 insertions(+)
 create mode 100644 hw/intc/vega_aclint.c
 create mode 100644 include/hw/intc/vega_aclint.h

diff --git a/hw/intc/vega_aclint.c b/hw/intc/vega_aclint.c
new file mode 100644
index 0000000000..2583813a7c
--- /dev/null
+++ b/hw/intc/vega_aclint.c
@@ -0,0 +1,668 @@
+/*
+ * VEGA ACLINT (Advanced Core Local Interruptor) emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2025 C-DAC (Centre for Development of Advanced Computing)
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/core/sysbus.h"
+#include "target/riscv/cpu.h"
+#include "target/riscv/time_helper.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/intc/vega_aclint.h"
+#include "qemu/timer.h"
+#include "hw/core/irq.h"
+#include "migration/vmstate.h"
+
+typedef struct vega_aclint_mtimer_callback {
+    VEGAAclintMTimerState *s;
+    int num;
+} vega_aclint_mtimer_callback;
+
+static uint64_t cpu_vega_read_rtc_raw(uint32_t timebase_freq)
+{
+    return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+        timebase_freq, NANOSECONDS_PER_SECOND);
+}
+
+static uint64_t cpu_vega_read_rtc(void *opaque)
+{
+    VEGAAclintMTimerState *mtimer = opaque;
+    return cpu_vega_read_rtc_raw(mtimer->timebase_freq) + mtimer->time_delta;
+}
+
+/*
+ * Called when timecmp is written to update the QEMU timer or immediately
+ * trigger timer interrupt if mtimecmp <= current timer value.
+ */
+static void vega_aclint_mtimer_write_timecmp(VEGAAclintMTimerState *mtimer,
+                                              RISCVCPU *cpu,
+                                              int hartid,
+                                              uint64_t value)
+{
+    uint32_t timebase_freq = mtimer->timebase_freq;
+    uint64_t next;
+    uint64_t diff;
+
+    uint64_t rtc = cpu_vega_read_rtc(mtimer);
+
+    /* Compute the relative hartid w.r.t the socket */
+    hartid = hartid - mtimer->hartid_base;
+
+    mtimer->timecmp[hartid] = value;
+    if (mtimer->timecmp[hartid] <= rtc) {
+        /*
+         * If we're setting an MTIMECMP value in the "past",
+         * immediately raise the timer interrupt
+         */
+        qemu_irq_raise(mtimer->timer_irqs[hartid]);
+        return;
+    }
+
+    /* otherwise, set up the future timer interrupt */
+    qemu_irq_lower(mtimer->timer_irqs[hartid]);
+    diff = mtimer->timecmp[hartid] - rtc;
+    /* back to ns (note args switched in muldiv64) */
+    uint64_t ns_diff = muldiv64(diff, NANOSECONDS_PER_SECOND, timebase_freq);
+
+    /*
+     * check if ns_diff overflowed and check if the addition would potentially
+     * overflow
+     */
+    if ((NANOSECONDS_PER_SECOND > timebase_freq && ns_diff < diff) ||
+        ns_diff > INT64_MAX) {
+        next = INT64_MAX;
+    } else {
+        /*
+         * as it is very unlikely qemu_clock_get_ns will return a value
+         * greater than INT64_MAX, no additional check is needed for an
+         * unsigned integer overflow.
+         */
+        next = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + ns_diff;
+        /*
+         * if ns_diff is INT64_MAX next may still be outside the range
+         * of a signed integer.
+         */
+        next = MIN(next, INT64_MAX);
+    }
+
+    timer_mod(mtimer->timers[hartid], next);
+}
+
+/*
+ * Callback used when the timer set using timer_mod expires.
+ * Should raise the timer interrupt line
+ */
+static void vega_aclint_mtimer_cb(void *opaque)
+{
+    vega_aclint_mtimer_callback *state = opaque;
+
+    qemu_irq_raise(state->s->timer_irqs[state->num]);
+}
+
+/* CPU read MTIMER register */
+static uint64_t vega_aclint_mtimer_read(void *opaque, hwaddr addr,
+    unsigned size)
+{
+    VEGAAclintMTimerState *mtimer = opaque;
+
+    /* STIMECMP[h] = timecmp_base + 0x10 + h*0x20 — stored in upper timecmp[] */
+    if (addr >= (mtimer->timecmp_base + 0x10) &&
+        addr < (mtimer->timecmp_base + 0x10 + (mtimer->num_harts << 5)) &&
+        ((addr - (mtimer->timecmp_base + 0x10)) % 0x20) < 8) {
+        size_t hartid = mtimer->hartid_base +
+                        ((addr - (mtimer->timecmp_base + 0x10)) >> 5);
+        if (hartid < mtimer->hartid_base + mtimer->num_harts) {
+            uint64_t stimecmp = mtimer->timecmp[hartid + mtimer->num_harts];
+            return (size == 4) ? (stimecmp & 0xFFFFFFFF) : stimecmp;
+        }
+        return 0;
+    }
+    if (addr >= mtimer->timecmp_base &&
+        addr < (mtimer->timecmp_base + (mtimer->num_harts << 5)) &&
+        ((addr - mtimer->timecmp_base) % 0x20) < 8) {
+        size_t hartid = mtimer->hartid_base +
+                        ((addr - mtimer->timecmp_base) >> 5);
+        CPUState *cpu = cpu_by_arch_id(hartid);
+        CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
+        if (!env) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "aclint-mtimer: invalid hartid: %zu", hartid);
+        } else if ((addr & 0x7) == 0) {
+            /* timecmp_lo for RV32/RV64 or timecmp for RV64 */
+            uint64_t timecmp = mtimer->timecmp[hartid];
+            return (size == 4) ? (timecmp & 0xFFFFFFFF) : timecmp;
+        } else if ((addr & 0x7) == 4) {
+            /* timecmp_hi */
+            uint64_t timecmp = mtimer->timecmp[hartid];
+            return (timecmp >> 32) & 0xFFFFFFFF;
+        } else {
+            qemu_log_mask(LOG_UNIMP,
+                          "aclint-mtimer: invalid read: %08x", (uint32_t)addr);
+            return 0;
+        }
+    } else if (addr == mtimer->time_base) {
+        /* time_lo for RV32/RV64 or timecmp for RV64 */
+        uint64_t rtc = cpu_vega_read_rtc(mtimer);
+        return (size == 4) ? (rtc & 0xFFFFFFFF) : rtc;
+    } else if (addr == mtimer->time_base + 4) {
+        /* time_hi */
+        return (cpu_vega_read_rtc(mtimer) >> 32) & 0xFFFFFFFF;
+    }
+
+    qemu_log_mask(LOG_UNIMP,
+                  "aclint-mtimer: invalid read: %08x", (uint32_t)addr);
+    return 0;
+}
+
+/* CPU write MTIMER register */
+static void vega_aclint_mtimer_write(void *opaque, hwaddr addr,
+    uint64_t value, unsigned size)
+{
+    VEGAAclintMTimerState *mtimer = opaque;
+    int i;
+
+    /*
+     * STIMECMP[h] = timecmp_base + 0x10 + h*0x20.
+     * BBL's fdt.c VEGA_CLINT uses hls->timecmp = STIMECMP for sbi_set_timer.
+     * Writing STIMECMP must schedule a timer so MTIME>=STIMECMP fires MIP.STIP.
+     */
+    if (addr >= (mtimer->timecmp_base + 0x10) &&
+        addr < (mtimer->timecmp_base + 0x10 + (mtimer->num_harts << 5)) &&
+        ((addr - (mtimer->timecmp_base + 0x10)) % 0x20) < 8) {
+        size_t hartid = mtimer->hartid_base +
+                        ((addr - (mtimer->timecmp_base + 0x10)) >> 5);
+        if (hartid < mtimer->hartid_base + mtimer->num_harts) {
+            uint64_t stimecmp = value;
+            uint32_t hart_idx = (uint32_t)(hartid - mtimer->hartid_base);
+            mtimer->timecmp[hartid + mtimer->num_harts] = stimecmp;
+            /* Schedule (or cancel) the STIP timer exactly like MTIMECMP */
+            RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(hartid));
+            uint64_t rtc = cpu_vega_read_rtc(mtimer);
+            if (stimecmp <= rtc) {
+                riscv_cpu_update_mip(&cpu->env, MIP_STIP, BOOL_TO_MASK(1));
+            } else {
+                riscv_cpu_update_mip(&cpu->env, MIP_STIP, BOOL_TO_MASK(0));
+                uint64_t diff = stimecmp - rtc;
+                uint64_t ns_diff = muldiv64(diff, NANOSECONDS_PER_SECOND,
+                                             mtimer->timebase_freq);
+                uint64_t next;
+                if ((NANOSECONDS_PER_SECOND > mtimer->timebase_freq &&
+                     ns_diff < diff) || ns_diff > INT64_MAX) {
+                    next = INT64_MAX;
+                } else {
+                    next = MIN(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + ns_diff,
+                               (uint64_t)INT64_MAX);
+                }
+                timer_mod(mtimer->stimecmp_timers[hart_idx], next);
+            }
+        }
+        return;
+    }
+    if (addr >= mtimer->timecmp_base &&
+        addr < (mtimer->timecmp_base + (mtimer->num_harts << 5)) &&
+        ((addr - mtimer->timecmp_base) % 0x20) < 8) {
+        size_t hartid = mtimer->hartid_base +
+                        ((addr - mtimer->timecmp_base) >> 5);
+
+        CPUState *cpu = cpu_by_arch_id(hartid);
+        CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
+        if (!env) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "aclint-mtimer: invalid hartid: %zu", hartid);
+        } else if ((addr & 0x7) == 0) {
+            if (size == 4) {
+                /* timecmp_lo for RV32/RV64 */
+                uint64_t timecmp_hi = mtimer->timecmp[hartid] >> 32;
+                vega_aclint_mtimer_write_timecmp(mtimer, RISCV_CPU(cpu), hartid,
+                    timecmp_hi << 32 | (value & 0xFFFFFFFF));
+            } else {
+                /* timecmp for RV64 */
+                vega_aclint_mtimer_write_timecmp(mtimer, RISCV_CPU(cpu), hartid,
+                                                  value);
+            }
+        } else if ((addr & 0x7) == 4) {
+            if (size == 4) {
+                /* timecmp_hi for RV32/RV64 */
+                uint64_t timecmp_lo = mtimer->timecmp[hartid];
+                vega_aclint_mtimer_write_timecmp(mtimer, RISCV_CPU(cpu), hartid,
+                    value << 32 | (timecmp_lo & 0xFFFFFFFF));
+            } else {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "aclint-mtimer: invalid timecmp_hi write: %08x",
+                              (uint32_t)addr);
+            }
+        } else {
+            qemu_log_mask(LOG_UNIMP,
+                          "aclint-mtimer: invalid timecmp write: %08x",
+                          (uint32_t)addr);
+        }
+        return;
+    } else if (addr == mtimer->time_base || addr == mtimer->time_base + 4) {
+        uint64_t rtc_r = cpu_vega_read_rtc_raw(mtimer->timebase_freq);
+        uint64_t rtc = cpu_vega_read_rtc(mtimer);
+
+        if (addr == mtimer->time_base) {
+            if (size == 4) {
+                /* time_lo for RV32/RV64 */
+                mtimer->time_delta = ((rtc & ~0xFFFFFFFFULL) | value) - rtc_r;
+            } else {
+                /* time for RV64 */
+                mtimer->time_delta = value - rtc_r;
+            }
+        } else {
+            if (size == 4) {
+                /* time_hi for RV32/RV64 */
+                mtimer->time_delta = (value << 32 | (rtc & 0xFFFFFFFF)) - rtc_r;
+            } else {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "aclint-mtimer: invalid time_hi write: %08x",
+                              (uint32_t)addr);
+                return;
+            }
+        }
+
+        /* Check if timer interrupt is triggered for each hart. */
+        for (i = 0; i < mtimer->num_harts; i++) {
+            CPUState *cpu = cpu_by_arch_id(mtimer->hartid_base + i);
+            CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
+            if (!env) {
+                continue;
+            }
+            vega_aclint_mtimer_write_timecmp(mtimer, RISCV_CPU(cpu),
+                                              mtimer->hartid_base + i,
+                                              mtimer->timecmp[i]);
+            riscv_timer_write_timecmp(env, env->stimer, env->stimecmp, 0, MIP_STIP);
+            riscv_timer_write_timecmp(env, env->vstimer, env->vstimecmp,
+                                      env->htimedelta, MIP_VSTIP);
+
+        }
+        return;
+    }
+
+    qemu_log_mask(LOG_UNIMP,
+                  "aclint-mtimer: invalid write: %08x", (uint32_t)addr);
+}
+
+static const MemoryRegionOps vega_aclint_mtimer_ops = {
+    .read = vega_aclint_mtimer_read,
+    .write = vega_aclint_mtimer_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    }
+};
+
+static const Property vega_aclint_mtimer_properties[] = {
+    DEFINE_PROP_UINT32("hartid-base", VEGAAclintMTimerState,
+        hartid_base, 0),
+    DEFINE_PROP_UINT32("num-harts", VEGAAclintMTimerState, num_harts, 1),
+    DEFINE_PROP_UINT32("timecmp-base", VEGAAclintMTimerState,
+        timecmp_base, VEGA_ACLINT_DEFAULT_MTIMECMP),
+    DEFINE_PROP_UINT32("time-base", VEGAAclintMTimerState,
+        time_base, VEGA_ACLINT_DEFAULT_MTIME),
+    DEFINE_PROP_UINT32("aperture-size", VEGAAclintMTimerState,
+        aperture_size, VEGA_ACLINT_DEFAULT_MTIMER_SIZE),
+    DEFINE_PROP_UINT32("timebase-freq", VEGAAclintMTimerState,
+        timebase_freq, 0),
+};
+
+/*
+ * Callback when STIMECMP timer fires: set MIP.STIP.
+ * Reuses the existing vega_aclint_mtimer_callback struct:
+ *   .s  = pointer to VEGAAclintMTimerState
+ *   .num = hart index (relative to hartid_base)
+ */
+static void vega_aclint_stimecmp_cb(void *opaque)
+{
+    vega_aclint_mtimer_callback *cb = opaque;
+    VEGAAclintMTimerState *mtimer = cb->s;
+    int hart_idx = cb->num;
+    size_t hartid = mtimer->hartid_base + hart_idx;
+
+    RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(hartid));
+    uint64_t rtc = cpu_vega_read_rtc(mtimer);
+    uint64_t stimecmp = mtimer->timecmp[hartid + mtimer->num_harts];
+
+    if (rtc >= stimecmp) {
+        riscv_cpu_update_mip(&cpu->env, MIP_STIP, BOOL_TO_MASK(1));
+    }
+    /* else: spurious wakeup, leave STIP cleared */
+}
+
+static void vega_aclint_mtimer_realize(DeviceState *dev, Error **errp)
+{
+    VEGAAclintMTimerState *s = VEGA_ACLINT_MTIMER(dev);
+    int i;
+
+    memory_region_init_io(&s->mmio, OBJECT(dev), &vega_aclint_mtimer_ops,
+                          s, TYPE_VEGA_ACLINT_MTIMER, s->aperture_size);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
+
+    s->timer_irqs = g_new(qemu_irq, s->num_harts);
+    qdev_init_gpio_out(dev, s->timer_irqs, s->num_harts);
+
+    s->timers = g_new0(QEMUTimer *, s->num_harts);
+    /* Allocate 2×num_harts: lower half = MTIMECMP, upper half = STIMECMP */
+    /*
+     * Initialise all MTIMECMP and STIMECMP slots to UINT64_MAX so the
+     * timer interrupt does not fire before software explicitly arms it.
+     * With the default g_new0 (value 0), MTIME >= MTIMECMP is true the
+     * instant the clock starts, causing a continuous timer interrupt storm
+     * that prevents Linux from completing early initialisation.
+     */
+    s->timecmp = g_new(uint64_t, s->num_harts * 2);
+    for (int _i = 0; _i < s->num_harts * 2; _i++) {
+        s->timecmp[_i] = UINT64_MAX;
+    }
+    /* Claim MTIP and STIP on each hart, create STIMECMP timers */
+    s->stimecmp_timers = g_new(QEMUTimer *, s->num_harts);
+    for (i = 0; i < s->num_harts; i++) {
+        RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(s->hartid_base + i));
+        if (riscv_cpu_claim_interrupts(cpu, MIP_MTIP) < 0) {
+            error_report("MTIP already claimed");
+            exit(1);
+        }
+        if (riscv_cpu_claim_interrupts(cpu, MIP_STIP) < 0) {
+            error_report("STIP already claimed");
+            exit(1);
+        }
+        vega_aclint_mtimer_callback *scb = g_new(vega_aclint_mtimer_callback, 1);
+        scb->s   = s;
+        scb->num = i;
+        s->stimecmp_timers[i] = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                              vega_aclint_stimecmp_cb, scb);
+        timer_mod(s->stimecmp_timers[i], INT64_MAX);
+    }
+}
+
+static void vega_aclint_mtimer_reset_enter(Object *obj, ResetType type)
+{
+    /*
+     * According to RISC-V ACLINT spec:
+     *   - On MTIMER device reset, the MTIME register is cleared to zero.
+     *   - On MTIMER device reset, the MTIMECMP registers are in unknown state.
+     */
+    VEGAAclintMTimerState *mtimer = VEGA_ACLINT_MTIMER(obj);
+
+    /*
+     * Clear mtime register by writing to 0 it.
+     * Pending mtime interrupts will also be cleared at the same time.
+     */
+    vega_aclint_mtimer_write(mtimer, mtimer->time_base, 0, 8);
+}
+
+static const VMStateDescription vmstate_vega_mtimer = {
+    .name = "vega_mtimer",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+            VMSTATE_VARRAY_UINT32(timecmp, VEGAAclintMTimerState,
+                                  num_harts, 0,
+                                  vmstate_info_uint64, uint64_t),
+            VMSTATE_END_OF_LIST()
+        }
+};
+
+static void vega_aclint_mtimer_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->realize = vega_aclint_mtimer_realize;
+    device_class_set_props(dc, vega_aclint_mtimer_properties);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    rc->phases.enter = vega_aclint_mtimer_reset_enter;
+    dc->vmsd = &vmstate_vega_mtimer;
+}
+
+static const TypeInfo vega_aclint_mtimer_info = {
+    .name          = TYPE_VEGA_ACLINT_MTIMER,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(VEGAAclintMTimerState),
+    .class_init    = vega_aclint_mtimer_class_init,
+};
+
+/*
+ * Create ACLINT MTIMER device.
+ */
+DeviceState *vega_aclint_mtimer_create(hwaddr addr, hwaddr size,
+    uint32_t hartid_base, uint32_t num_harts,
+    uint32_t timecmp_base, uint32_t time_base, uint32_t timebase_freq,
+    bool provide_rdtime)
+{
+    int i;
+    DeviceState *dev = qdev_new(TYPE_VEGA_ACLINT_MTIMER);
+    VEGAAclintMTimerState *s = VEGA_ACLINT_MTIMER(dev);
+
+    assert(num_harts <= VEGA_ACLINT_MAX_HARTS);
+    assert(!(addr & 0x7));
+    assert(!(timecmp_base & 0x7));
+    assert(!(time_base & 0x7));
+
+    qdev_prop_set_uint32(dev, "hartid-base", hartid_base);
+    qdev_prop_set_uint32(dev, "num-harts", num_harts);
+    qdev_prop_set_uint32(dev, "timecmp-base", timecmp_base);
+    qdev_prop_set_uint32(dev, "time-base", time_base);
+    qdev_prop_set_uint32(dev, "aperture-size", size);
+    qdev_prop_set_uint32(dev, "timebase-freq", timebase_freq);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
+
+    for (i = 0; i < num_harts; i++) {
+        CPUState *cpu = cpu_by_arch_id(hartid_base + i);
+        RISCVCPU *rvcpu = RISCV_CPU(cpu);
+        CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
+        vega_aclint_mtimer_callback *cb =
+            g_new0(vega_aclint_mtimer_callback, 1);
+
+        if (!env) {
+            g_free(cb);
+            continue;
+        }
+        if (provide_rdtime) {
+            riscv_cpu_set_rdtime_fn(env, cpu_vega_read_rtc, dev);
+        }
+
+        cb->s = s;
+        cb->num = i;
+        s->timers[i] = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                  &vega_aclint_mtimer_cb, cb);
+        /*
+         * MTIMECMP initialized to UINT64_MAX in realize(); do NOT reset to 0
+         * here — doing so causes M-mode timer to fire immediately once BBL
+         * enables MTIE after the first sbi_set_timer call.
+         */
+
+        qdev_connect_gpio_out(dev, i,
+                              qdev_get_gpio_in(DEVICE(rvcpu), IRQ_M_TIMER));
+    }
+
+    return dev;
+}
+
+/* CPU read [M|S]SWI register */
+static uint64_t vega_aclint_swi_read(void *opaque, hwaddr addr,
+    unsigned size)
+{
+    VEGAAclintSwiState *swi = opaque;
+
+    if (addr < (swi->num_harts << 4)) {
+        size_t hartid = swi->hartid_base + (addr >> 4);
+        CPUState *cpu = cpu_by_arch_id(hartid);
+        CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
+        if (!env) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "aclint-swi: invalid hartid: %zu", hartid);
+        } else if ((addr & 0x3) == 0) {
+            return (swi->sswi) ? 0 : ((env->mip & MIP_MSIP) > 0);
+        }
+    }
+
+    qemu_log_mask(LOG_UNIMP,
+                  "aclint-swi: invalid read: %08x", (uint32_t)addr);
+    return 0;
+}
+
+/* CPU write [M|S]SWI register */
+static void vega_aclint_swi_write(void *opaque, hwaddr addr, uint64_t value,
+        unsigned size)
+{
+    VEGAAclintSwiState *swi = opaque;
+
+    if (addr < (swi->num_harts << 4)) {
+        size_t hartid = swi->hartid_base + (addr >> 4);
+
+        CPUState *cpu = cpu_by_arch_id(hartid);
+        CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
+        if (!env) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "aclint-swi: invalid hartid: %zu", hartid);
+        } else if ((addr & 0x3) == 0) {
+            if (value & 0x1) {
+                qemu_irq_raise(swi->soft_irqs[hartid - swi->hartid_base]);
+            } else {
+                if (!swi->sswi) {
+                    qemu_irq_lower(swi->soft_irqs[hartid - swi->hartid_base]);
+                }
+            }
+            return;
+        }
+    }
+
+    qemu_log_mask(LOG_UNIMP,
+                  "aclint-swi: invalid write: %08x", (uint32_t)addr);
+}
+
+static const MemoryRegionOps vega_aclint_swi_ops = {
+    .read = vega_aclint_swi_read,
+    .write = vega_aclint_swi_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4
+    }
+};
+
+static const Property vega_aclint_swi_properties[] = {
+    DEFINE_PROP_UINT32("hartid-base", VEGAAclintSwiState, hartid_base, 0),
+    DEFINE_PROP_UINT32("num-harts", VEGAAclintSwiState, num_harts, 1),
+    DEFINE_PROP_UINT32("sswi", VEGAAclintSwiState, sswi, false),
+};
+
+static void vega_aclint_swi_realize(DeviceState *dev, Error **errp)
+{
+    VEGAAclintSwiState *swi = VEGA_ACLINT_SWI(dev);
+    int i;
+
+    memory_region_init_io(&swi->mmio, OBJECT(dev), &vega_aclint_swi_ops, swi,
+                          TYPE_VEGA_ACLINT_SWI, VEGA_ACLINT_SWI_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &swi->mmio);
+
+    swi->soft_irqs = g_new(qemu_irq, swi->num_harts);
+    qdev_init_gpio_out(dev, swi->soft_irqs, swi->num_harts);
+
+    /* Claim software interrupt bits */
+    for (i = 0; i < swi->num_harts; i++) {
+        RISCVCPU *cpu = RISCV_CPU(qemu_get_cpu(swi->hartid_base + i));
+        /* We don't claim mip.SSIP because it is writable by software */
+        if (riscv_cpu_claim_interrupts(cpu, swi->sswi ? 0 : MIP_MSIP) < 0) {
+            error_report("MSIP already claimed");
+            exit(1);
+        }
+    }
+}
+
+static void vega_aclint_swi_reset_enter(Object *obj, ResetType type)
+{
+    /*
+     * According to RISC-V ACLINT spec:
+     *   - On MSWI device reset, each MSIP register is cleared to zero.
+     *
+     * p.s. SSWI device reset does nothing since SETSIP register always reads 0.
+     */
+    VEGAAclintSwiState *swi = VEGA_ACLINT_SWI(obj);
+    int i;
+
+    if (!swi->sswi) {
+        for (i = 0; i < swi->num_harts; i++) {
+            /* Clear MSIP registers by lowering software interrupts. */
+            qemu_irq_lower(swi->soft_irqs[i]);
+        }
+    }
+}
+
+static void vega_aclint_swi_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->realize = vega_aclint_swi_realize;
+    device_class_set_props(dc, vega_aclint_swi_properties);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    rc->phases.enter = vega_aclint_swi_reset_enter;
+}
+
+static const TypeInfo vega_aclint_swi_info = {
+    .name          = TYPE_VEGA_ACLINT_SWI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(VEGAAclintSwiState),
+    .class_init    = vega_aclint_swi_class_init,
+};
+
+/*
+ * Create ACLINT [M|S]SWI device.
+ */
+DeviceState *vega_aclint_swi_create(hwaddr addr, uint32_t hartid_base,
+    uint32_t num_harts, bool sswi)
+{
+    int i;
+    DeviceState *dev = qdev_new(TYPE_VEGA_ACLINT_SWI);
+
+    assert(num_harts <= VEGA_ACLINT_MAX_HARTS);
+    assert(!(addr & 0x3));
+
+    qdev_prop_set_uint32(dev, "hartid-base", hartid_base);
+    qdev_prop_set_uint32(dev, "num-harts", num_harts);
+    qdev_prop_set_uint32(dev, "sswi", sswi ? true : false);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
+
+    for (i = 0; i < num_harts; i++) {
+        CPUState *cpu = cpu_by_arch_id(hartid_base + i);
+        RISCVCPU *rvcpu = RISCV_CPU(cpu);
+
+        qdev_connect_gpio_out(dev, i,
+                              qdev_get_gpio_in(DEVICE(rvcpu),
+                                  (sswi) ? IRQ_S_SOFT : IRQ_M_SOFT));
+    }
+
+    return dev;
+}
+
+static void vega_aclint_register_types(void)
+{
+    type_register_static(&vega_aclint_mtimer_info);
+    type_register_static(&vega_aclint_swi_info);
+}
+
+type_init(vega_aclint_register_types)
diff --git a/include/hw/intc/vega_aclint.h b/include/hw/intc/vega_aclint.h
new file mode 100644
index 0000000000..21bc157ee1
--- /dev/null
+++ b/include/hw/intc/vega_aclint.h
@@ -0,0 +1,84 @@
+/*
+ * VEGA ACLINT (Advanced Core Local Interruptor) interface
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2025 C-DAC (Centre for Development of Advanced Computing)
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_VEGA_ACLINT_H
+#define HW_VEGA_ACLINT_H
+
+#include "hw/core/sysbus.h"
+
+#define TYPE_VEGA_ACLINT_MTIMER "vega.aclint.mtimer"
+
+#define VEGA_ACLINT_MTIMER(obj) \
+    OBJECT_CHECK(VEGAAclintMTimerState, (obj), TYPE_VEGA_ACLINT_MTIMER)
+
+typedef struct VEGAAclintMTimerState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    uint64_t time_delta;
+    uint64_t *timecmp;
+    QEMUTimer **timers;
+    QEMUTimer       **stimecmp_timers;
+
+    /*< public >*/
+    MemoryRegion mmio;
+    uint32_t hartid_base;
+    uint32_t num_harts;
+    uint32_t timecmp_base;
+    uint32_t time_base;
+    uint32_t aperture_size;
+    uint32_t timebase_freq;
+    qemu_irq *timer_irqs;
+} VEGAAclintMTimerState;
+
+DeviceState *vega_aclint_mtimer_create(hwaddr addr, hwaddr size,
+    uint32_t hartid_base, uint32_t num_harts,
+    uint32_t timecmp_base, uint32_t time_base, uint32_t timebase_freq,
+    bool provide_rdtime);
+
+#define TYPE_VEGA_ACLINT_SWI "vega.aclint.swi"
+
+#define VEGA_ACLINT_SWI(obj) \
+    OBJECT_CHECK(VEGAAclintSwiState, (obj), TYPE_VEGA_ACLINT_SWI)
+
+typedef struct VEGAAclintSwiState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion mmio;
+    uint32_t hartid_base;
+    uint32_t num_harts;
+    uint32_t sswi;
+    qemu_irq *soft_irqs;
+} VEGAAclintSwiState;
+
+DeviceState *vega_aclint_swi_create(hwaddr addr, uint32_t hartid_base,
+    uint32_t num_harts, bool sswi);
+
+enum {
+    VEGA_ACLINT_DEFAULT_MTIMECMP      = 0x0,
+    VEGA_ACLINT_DEFAULT_MTIME         = 0x100,
+    VEGA_ACLINT_DEFAULT_MTIMER_SIZE   = 0x8000,
+    VEGA_ACLINT_DEFAULT_TIMEBASE_FREQ = 10000000,
+    VEGA_ACLINT_MAX_HARTS             = 4095,
+    VEGA_ACLINT_SWI_SIZE              = 0x480
+};
+
+#endif
-- 
2.43.0


------------------------------------------------------------------------------------------------------------
[ C-DAC is on Social-Media too. Kindly follow us at:
Facebook: https://www.facebook.com/CDACINDIA & Twitter: @cdacindia ]

This e-mail is for the sole use of the intended recipient(s) and may
contain confidential and privileged information. If you are not the
intended recipient, please contact the sender by reply e-mail and destroy
all copies and the original message. Any unauthorized review, use,
disclosure, dissemination, forwarding, printing or copying of this email
is strictly prohibited and appropriate legal action will be taken.
------------------------------------------------------------------------------------------------------------


