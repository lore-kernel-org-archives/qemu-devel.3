Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2616CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHczb-0003ry-SW; Fri, 16 Oct 2026 04:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karthika.b@cdac.in>)
 id 1xHczG-0003o9-CH; Fri, 16 Oct 2026 04:08:24 -0400
Received: from mailsender.cdac.in ([196.1.113.117]
 helo=mailsender-core1.pune.cdac.in)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karthika.b@cdac.in>)
 id 1xHczA-0005w6-MU; Fri, 16 Oct 2026 04:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cdac.in; s=default;
 t=1792138078; bh=fhREqVjIOaSR1eiA6lBky1Aw8am+YPwicWDTrG5TP9A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bSN+dHDkGmG+SMb+/wZxeOwP8ZTAEUkgiOg6NxbKoIcH33av6QQFiv4T+f/Pp4DsU
 r/bUvH7nrzO2rA07pVNrUQUC1WbXbJ5MrMEUviHsCej2KN25x2j0WXHVlQeg19HwQK
 KSWR2uaqrZWBPPcZyRP5OCOG76nuBYvvspl6b054=
Received: from mscr-int2.pune.cdac.in (mscr-int2.pune.cdac.in [10.208.193.12])
 by mailsender.cdac.in (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 69G87vhZ3825194; Fri, 16 Oct 2026 13:37:58 +0530
Received: from mailgw-cip.pune.cdac.in (mscr-haproxy.pune.cdac.in
 [10.208.193.46])
 by mscr-int2.pune.cdac.in (Postfix) with ESMTP id 79AFF10014455;
 Fri, 16 Oct 2026 13:37:46 +0530 (IST)
X-Auth: karthika.b@cdac.in
Received: from hdg164.tvm.cdac.in (hd_hdg164.tvm.cdac.in [10.176.18.107])
 (Authenticated sender: karthika.b@cdac.in)
 by mailgw-cip.pune.cdac.in (Postfix) with ESMTPSA id 3E31A14E17D2;
 Fri, 16 Oct 2026 13:37:46 +0530 (IST)
From: Karthika B <karthika.b@cdac.in>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, sreenadh@cdac.in, raokk@cdac.in,
 Karthika B <karthika.b@cdac.in>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/7] hw/intc: Add CDAC VEGA PLIC device model
Date: Fri, 16 Oct 2026 13:37:01 +0530
Message-ID: <20261016080709.17331-2-karthika.b@cdac.in>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016080709.17331-1-karthika.b@cdac.in>
References: <385625713.441366.1761727810206@webmail2.cdac.in>
 <20261016080709.17331-1-karthika.b@cdac.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CDAC-PUNE-MailScanner-Information: Please contact the ISP for more
 information
X-CDAC-PUNE-MailScanner-ID: 79AFF10014455.A03F8
X-CDAC-PUNE-MailScanner: Found to be clean
X-CDAC-PUNE-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=-0.999, required 6, ALL_TRUSTED -1.00, URIBL_BLOCKED 0.00)
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
 hw/intc/Kconfig             |   7 +
 hw/intc/meson.build         |   2 +
 hw/intc/vega_plic.c         | 517 ++++++++++++++++++++++++++++++++++++
 include/hw/intc/vega_plic.h |  87 ++++++
 4 files changed, 613 insertions(+)
 create mode 100644 hw/intc/vega_plic.c
 create mode 100644 include/hw/intc/vega_plic.h

diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 636d00b7e8..942ec4d0e5 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -117,3 +117,10 @@ config LOONGARCH_EXTIOI
 
 config LOONGARCH_DINTC
     bool
+
+config VEGA_ACLINT
+    bool
+
+config VEGA_PLIC
+    bool
+    select MSI_NONBROKEN
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index fac2d228f9..4c9eb0e9c4 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -68,6 +68,8 @@ specific_ss.add(when: 'CONFIG_RISCV_APLIC', if_true: files('riscv_aplic.c'))
 specific_ss.add(when: 'CONFIG_RISCV_IMSIC', if_true: files('riscv_imsic.c'))
 specific_ss.add(when: 'CONFIG_SIFIVE_PLIC', if_true: files('sifive_plic.c'))
 specific_ss.add(when: 'CONFIG_XICS', if_true: files('xics.c', 'xive2.c'))
+specific_ss.add(when: 'CONFIG_VEGA_ACLINT', if_true: files('vega_aclint.c'))
+specific_ss.add(when: 'CONFIG_VEGA_PLIC', if_true: files('vega_plic.c'))
 specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_XICS'],
 		if_true: files('xics_kvm.c'))
 specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('xics_spapr.c', 'spapr_xive.c'))
diff --git a/hw/intc/vega_plic.c b/hw/intc/vega_plic.c
new file mode 100644
index 0000000000..7ad58b0023
--- /dev/null
+++ b/hw/intc/vega_plic.c
@@ -0,0 +1,517 @@
+/*
+ * VEGA PLIC (Platform-Level Interrupt Controller) emulation
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
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/error-report.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/intc/vega_plic.h"
+#include "target/riscv/cpu.h"
+#include "migration/vmstate.h"
+#include "hw/core/irq.h"
+#include "system/kvm.h"
+
+static bool addr_between(uint32_t addr, uint32_t base, uint32_t num)
+{
+    return addr >= base && addr - base < num;
+}
+
+static PLICMode char_to_mode(char c)
+{
+    switch (c) {
+    case 'U': return PLICMode_U;
+    case 'S': return PLICMode_S;
+    case 'M': return PLICMode_M;
+    default:
+        error_report("plic: invalid mode '%c'", c);
+        exit(1);
+    }
+}
+
+static uint32_t atomic_set_masked(uint32_t *a, uint32_t mask, uint32_t value)
+{
+    uint32_t old, new, cmp = qatomic_read(a);
+
+    do {
+        old = cmp;
+        new = (old & ~mask) | (value & mask);
+        cmp = qatomic_cmpxchg(a, old, new);
+    } while (old != cmp);
+
+    return old;
+}
+
+static void vega_plic_set_pending(VegaPLICState *plic, int irq, bool level)
+{
+    atomic_set_masked(&plic->pending[irq >> 5], 1 << (irq & 31), -!!level);
+}
+
+static void vega_plic_set_claimed(VegaPLICState *plic, int irq, bool level)
+{
+    atomic_set_masked(&plic->claimed[irq >> 5], 1 << (irq & 31), -!!level);
+}
+
+static uint32_t vega_plic_claimed(VegaPLICState *plic, uint32_t addrid)
+{
+    uint32_t max_irq = 0;
+    uint32_t max_prio = plic->target_priority[addrid];
+    int i, j;
+    int num_irq_in_word = 32;
+
+    for (i = 0; i < plic->bitfield_words; i++) {
+        uint32_t pending_enabled_not_claimed =
+                        (plic->pending[i] & ~plic->claimed[i]) &
+                            plic->enable[addrid * plic->bitfield_words + i];
+
+        if (!pending_enabled_not_claimed) {
+            continue;
+        }
+
+        if (i == (plic->bitfield_words - 1)) {
+            /*
+             * If plic->num_sources is not multiple of 32, num-of-irq in last
+             * word is not 32. Compute the num-of-irq of last word to avoid
+             * out-of-bound access of source_priority array.
+             */
+            num_irq_in_word = plic->num_sources - ((plic->bitfield_words - 1) << 5);
+        }
+
+        for (j = 0; j < num_irq_in_word; j++) {
+            int irq = (i << 5) + j;
+            uint32_t prio = plic->source_priority[irq];
+            int enabled = pending_enabled_not_claimed & (1 << j);
+
+            if (enabled && prio > max_prio) {
+                max_irq = irq;
+                max_prio = prio;
+            }
+        }
+    }
+
+    return max_irq;
+}
+
+static void vega_plic_update(VegaPLICState *plic)
+{
+    int addrid;
+
+    /* raise irq on harts where this irq is enabled */
+    for (addrid = 0; addrid < plic->num_addrs; addrid++) {
+        uint32_t hartid = plic->addr_config[addrid].hartid;
+        PLICMode mode = plic->addr_config[addrid].mode;
+        bool level = !!vega_plic_claimed(plic, addrid);
+
+        switch (mode) {
+        case PLICMode_M:
+            qemu_set_irq(plic->m_external_irqs[hartid - plic->hartid_base], level);
+            break;
+        case PLICMode_S:
+            qemu_set_irq(plic->s_external_irqs[hartid - plic->hartid_base], level);
+            break;
+        default:
+            break;
+        }
+    }
+}
+
+static const uint32_t vega_priority_regs = 0x10;
+static const uint32_t vega_pending_regs = 0x4;
+static const uint32_t vega_enable_reg_size = 0x100;
+
+static uint64_t vega_plic_read(void *opaque, hwaddr addr, unsigned size)
+{
+    VegaPLICState *plic = opaque;
+
+    if (addr_between(addr, plic->priority_base, vega_priority_regs << 2)) {
+        /* Between 0x00 and 0x40 (Write only) */
+        uint32_t irq = (addr >> 2) * 8;
+        uint32_t result = 0;
+
+        for (uint32_t i = 0; i < 8; i++) {
+            if (irq != 0) {
+                result |= (plic->source_priority[irq] & 0xf) << (i * 4);
+            }
+            irq++;
+        }
+        return result;
+    } else if (addr_between(addr, plic->pending_base,
+                            vega_pending_regs << 2)) {
+        /* Between 0x80 and 0x90 (Read only) */
+        uint32_t word = (addr - plic->pending_base) >> 2;
+
+        return plic->pending[word];
+    } else if (addr_between(addr, plic->enable_base, vega_enable_reg_size)) {
+        /* Between 0x100 and 0x200 */
+        uint32_t addrid = (addr - plic->enable_base) / plic->enable_stride;
+        uint32_t wordid = (addr - plic->enable_base -
+                          (addrid * plic->enable_stride)) >> 2;
+
+        if (wordid < plic->bitfield_words) {
+            return plic->enable[addrid * plic->bitfield_words + wordid];
+        }
+    } else if (addr_between(addr, plic->context_base,
+                            plic->num_addrs * plic->context_stride)) {
+        uint32_t addrid = (addr - plic->context_base) / plic->context_stride;
+        uint32_t contextid = (addr & (plic->context_stride - 1));
+
+        if (contextid == 0) {
+            return plic->target_priority[addrid];
+        } else if (contextid == 4) {
+            uint32_t max_irq = vega_plic_claimed(plic, addrid);
+
+            if (max_irq) {
+                vega_plic_set_pending(plic, max_irq, false);
+                vega_plic_set_claimed(plic, max_irq, true);
+            }
+
+            vega_plic_update(plic);
+            return max_irq;
+        }
+    }
+
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: Invalid register read 0x%" HWADDR_PRIx "\n",
+                  __func__, addr);
+    return 0;
+}
+
+static void vega_plic_write(void *opaque, hwaddr addr, uint64_t value,
+                            unsigned size)
+{
+    VegaPLICState *plic = opaque;
+
+    if (addr_between(addr, plic->priority_base, vega_priority_regs << 2)) {
+        /* Between 0x00 and 0x40 (Write only) */
+        uint32_t irq = (addr >> 2) * 8;
+
+        for (uint32_t i = 0; i < 8; i++) {
+            if (irq != 0) {
+                plic->source_priority[irq] = (value >> (i * 4)) & 0xff;
+                vega_plic_update(plic);
+            }
+            irq++;
+        }
+    } else if (addr_between(addr, plic->pending_base,
+                            vega_pending_regs << 2)) {
+        /* Between 0x80 and 0x90 (Read only) */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid pending write: 0x%" HWADDR_PRIx "",
+                      __func__, addr);
+    } else if (addr_between(addr, plic->enable_base, vega_enable_reg_size)) {
+        /* Between 0x100 and 0x200 */
+        uint32_t addrid = (addr - plic->enable_base) / plic->enable_stride;
+        uint32_t wordid = (addr - plic->enable_base -
+                          (addrid * plic->enable_stride)) >> 2;
+
+        if (wordid < plic->bitfield_words) {
+            plic->enable[addrid * plic->bitfield_words + wordid] = value;
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Invalid enable write 0x%" HWADDR_PRIx "\n",
+                          __func__, addr);
+        }
+    } else if (addr_between(addr, plic->context_base,
+                            plic->num_addrs * plic->context_stride)) {
+        uint32_t addrid = (addr - plic->context_base) / plic->context_stride;
+        uint32_t contextid = (addr & (plic->context_stride - 1));
+
+        if (contextid == 0) {
+            if (value <= plic->num_priorities) {
+                plic->target_priority[addrid] = value;
+                vega_plic_update(plic);
+            }
+        } else if (contextid == 4) {
+            if (value < plic->num_sources) {
+                vega_plic_set_claimed(plic, value, false);
+                vega_plic_update(plic);
+            }
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Invalid context write 0x%" HWADDR_PRIx "\n",
+                          __func__, addr);
+        }
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Invalid register write 0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
+    }
+}
+
+static const MemoryRegionOps vega_plic_ops = {
+    .read = vega_plic_read,
+    .write = vega_plic_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4
+    }
+};
+
+static void vega_plic_reset(DeviceState *dev)
+{
+    VegaPLICState *s = VEGA_PLIC(dev);
+    int i;
+
+    memset(s->source_priority, 0, sizeof(uint32_t) * s->num_sources);
+    memset(s->target_priority, 0, sizeof(uint32_t) * s->num_addrs);
+    memset(s->pending, 0, sizeof(uint32_t) * s->bitfield_words);
+    memset(s->claimed, 0, sizeof(uint32_t) * s->bitfield_words);
+    memset(s->enable, 0, sizeof(uint32_t) * s->num_enables);
+
+    for (i = 0; i < s->num_harts; i++) {
+        qemu_set_irq(s->m_external_irqs[i], 0);
+        qemu_set_irq(s->s_external_irqs[i], 0);
+    }
+}
+
+/*
+ * parse PLIC hart/mode address offset config
+ *
+ * "M"              1 hart with M mode
+ * "MS,MS"          2 harts, 0-1 with M and S mode
+ * "M,MS,MS,MS,MS"  5 harts, 0 with M mode, 1-5 with M and S mode
+ */
+static void parse_hart_config(VegaPLICState *plic)
+{
+    int addrid, hartid, modes, m;
+    const char *p;
+    char c;
+
+    /* count and validate hart/mode combinations */
+    addrid = 0, hartid = 0, modes = 0;
+    p = plic->hart_config;
+    while ((c = *p++)) {
+        if (c == ',') {
+            if (modes) {
+                addrid += ctpop8(modes);
+                hartid++;
+                modes = 0;
+            }
+        } else {
+            m = 1 << char_to_mode(c);
+            if (modes == (modes | m)) {
+                error_report("plic: duplicate mode '%c' in config: %s",
+                             c, plic->hart_config);
+                exit(1);
+            }
+            modes |= m;
+        }
+    }
+    if (modes) {
+        addrid += ctpop8(modes);
+        hartid++;
+        modes = 0;
+    }
+
+    plic->num_addrs = addrid;
+    plic->num_harts = hartid;
+
+    /* store hart/mode combinations */
+    plic->addr_config = g_new(PLICAddr, plic->num_addrs);
+    addrid = 0, hartid = plic->hartid_base;
+    p = plic->hart_config;
+    while ((c = *p++)) {
+        if (c == ',') {
+            if (modes) {
+                hartid++;
+                modes = 0;
+            }
+        } else {
+            m = char_to_mode(c);
+            plic->addr_config[addrid].addrid = addrid;
+            plic->addr_config[addrid].hartid = hartid;
+            plic->addr_config[addrid].mode = m;
+            modes |= (1 << m);
+            addrid++;
+        }
+    }
+}
+
+static void vega_plic_irq_request(void *opaque, int irq, int level)
+{
+    VegaPLICState *s = opaque;
+
+    if (level > 0) {
+        vega_plic_set_pending(s, irq, true);
+        vega_plic_update(s);
+    }
+}
+
+static void vega_plic_realize(DeviceState *dev, Error **errp)
+{
+    VegaPLICState *s = VEGA_PLIC(dev);
+    int i;
+
+    memory_region_init_io(&s->mmio, OBJECT(dev), &vega_plic_ops, s,
+                          TYPE_VEGA_PLIC, s->aperture_size);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
+
+    parse_hart_config(s);
+
+    if (!s->num_sources) {
+        error_setg(errp, "plic: invalid number of interrupt sources");
+        return;
+    }
+
+    s->bitfield_words = (s->num_sources + 31) >> 5;
+    s->num_enables = s->bitfield_words * s->num_addrs;
+    s->source_priority = g_new0(uint32_t, s->num_sources);
+    s->target_priority = g_new0(uint32_t, s->num_addrs);
+    s->pending = g_new0(uint32_t, s->bitfield_words);
+    s->claimed = g_new0(uint32_t, s->bitfield_words);
+    s->enable = g_new0(uint32_t, s->num_enables);
+
+    qdev_init_gpio_in(dev, vega_plic_irq_request, s->num_sources);
+
+    s->s_external_irqs = g_malloc(sizeof(qemu_irq) * s->num_harts);
+    qdev_init_gpio_out(dev, s->s_external_irqs, s->num_harts);
+
+    s->m_external_irqs = g_malloc(sizeof(qemu_irq) * s->num_harts);
+    qdev_init_gpio_out(dev, s->m_external_irqs, s->num_harts);
+
+    /*
+     * We can't allow the supervisor to control SEIP as this would allow the
+     * supervisor to clear a pending external interrupt which will result in
+     * lost a interrupt in the case a PLIC is attached. The SEIP bit must be
+     * hardware controlled when a PLIC is attached.
+     */
+    for (i = 0; i < s->num_harts; i++) {
+        RISCVCPU *cpu = RISCV_CPU(qemu_get_cpu(s->hartid_base + i));
+        if (riscv_cpu_claim_interrupts(cpu, MIP_SEIP) < 0) {
+            error_setg(errp, "SEIP already claimed");
+            return;
+        }
+    }
+
+}
+
+static const VMStateDescription vmstate_vega_plic = {
+    .name = "riscv_vega_plic",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+            VMSTATE_VARRAY_UINT32(source_priority, VegaPLICState,
+                                  num_sources, 0,
+                                  vmstate_info_uint32, uint32_t),
+            VMSTATE_VARRAY_UINT32(target_priority, VegaPLICState,
+                                  num_addrs, 0,
+                                  vmstate_info_uint32, uint32_t),
+            VMSTATE_VARRAY_UINT32(pending, VegaPLICState, bitfield_words, 0,
+                                  vmstate_info_uint32, uint32_t),
+            VMSTATE_VARRAY_UINT32(claimed, VegaPLICState, bitfield_words, 0,
+                                  vmstate_info_uint32, uint32_t),
+            VMSTATE_VARRAY_UINT32(enable, VegaPLICState, num_enables, 0,
+                                  vmstate_info_uint32, uint32_t),
+            VMSTATE_END_OF_LIST()
+        }
+};
+
+static const Property vega_plic_properties[] = {
+    DEFINE_PROP_STRING("hart-config", VegaPLICState, hart_config),
+    DEFINE_PROP_UINT32("hartid-base", VegaPLICState, hartid_base, 0),
+    /* number of interrupt sources including interrupt source 0 */
+    DEFINE_PROP_UINT32("num-sources", VegaPLICState, num_sources, 1),
+    DEFINE_PROP_UINT32("num-priorities", VegaPLICState, num_priorities, 0),
+    /* interrupt priority register base starting from source 0 */
+    DEFINE_PROP_UINT32("priority-base", VegaPLICState, priority_base, 0),
+    DEFINE_PROP_UINT32("pending-base", VegaPLICState, pending_base, 0),
+    DEFINE_PROP_UINT32("enable-base", VegaPLICState, enable_base, 0),
+    DEFINE_PROP_UINT32("enable-stride", VegaPLICState, enable_stride, 0),
+    DEFINE_PROP_UINT32("context-base", VegaPLICState, context_base, 0),
+    DEFINE_PROP_UINT32("context-stride", VegaPLICState, context_stride, 0),
+    DEFINE_PROP_UINT32("aperture-size", VegaPLICState, aperture_size, 0),
+};
+
+static void vega_plic_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, vega_plic_reset);
+    device_class_set_props(dc, vega_plic_properties);
+    dc->realize = vega_plic_realize;
+    dc->vmsd = &vmstate_vega_plic;
+}
+
+static const TypeInfo vega_plic_info = {
+    .name          = TYPE_VEGA_PLIC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(VegaPLICState),
+    .class_init    = vega_plic_class_init,
+};
+
+static void vega_plic_register_types(void)
+{
+    type_register_static(&vega_plic_info);
+}
+
+type_init(vega_plic_register_types)
+
+/*
+ * Create PLIC device.
+ */
+DeviceState *vega_plic_create(hwaddr addr, char *hart_config,
+    uint32_t num_harts,
+    uint32_t hartid_base, uint32_t num_sources,
+    uint32_t num_priorities, uint32_t priority_base,
+    uint32_t pending_base, uint32_t enable_base,
+    uint32_t enable_stride, uint32_t context_base,
+    uint32_t context_stride, uint32_t aperture_size)
+{
+    DeviceState *dev = qdev_new(TYPE_VEGA_PLIC);
+    int i;
+    VegaPLICState *plic;
+
+    assert(enable_stride == (enable_stride & -enable_stride));
+    assert(context_stride == (context_stride & -context_stride));
+    qdev_prop_set_string(dev, "hart-config", hart_config);
+    qdev_prop_set_uint32(dev, "hartid-base", hartid_base);
+    qdev_prop_set_uint32(dev, "num-sources", num_sources);
+    qdev_prop_set_uint32(dev, "num-priorities", num_priorities);
+    qdev_prop_set_uint32(dev, "priority-base", priority_base);
+    qdev_prop_set_uint32(dev, "pending-base", pending_base);
+    qdev_prop_set_uint32(dev, "enable-base", enable_base);
+    qdev_prop_set_uint32(dev, "enable-stride", enable_stride);
+    qdev_prop_set_uint32(dev, "context-base", context_base);
+    qdev_prop_set_uint32(dev, "context-stride", context_stride);
+    qdev_prop_set_uint32(dev, "aperture-size", aperture_size);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
+
+    plic = VEGA_PLIC(dev);
+
+    for (i = 0; i < plic->num_addrs; i++) {
+        int cpu_num = plic->addr_config[i].hartid;
+        CPUState *cpu = qemu_get_cpu(cpu_num);
+
+        if (plic->addr_config[i].mode == PLICMode_M) {
+            qdev_connect_gpio_out(dev, cpu_num - hartid_base + num_harts,
+                                  qdev_get_gpio_in(DEVICE(cpu), IRQ_M_EXT));
+        }
+        if (plic->addr_config[i].mode == PLICMode_S) {
+            qdev_connect_gpio_out(dev, cpu_num - hartid_base,
+                                  qdev_get_gpio_in(DEVICE(cpu), IRQ_S_EXT));
+        }
+    }
+
+    return dev;
+}
diff --git a/include/hw/intc/vega_plic.h b/include/hw/intc/vega_plic.h
new file mode 100644
index 0000000000..f26d91a2a3
--- /dev/null
+++ b/include/hw/intc/vega_plic.h
@@ -0,0 +1,87 @@
+/*
+ * VEGA PLIC (Platform-Level Interrupt Controller) interface
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
+#ifndef HW_VEGA_PLIC_H
+#define HW_VEGA_PLIC_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_VEGA_PLIC "riscv.vega.plic"
+
+typedef struct VegaPLICState VegaPLICState;
+DECLARE_INSTANCE_CHECKER(VegaPLICState, VEGA_PLIC,
+                         TYPE_VEGA_PLIC)
+
+typedef enum PLICMode {
+    PLICMode_U,
+    PLICMode_S,
+    PLICMode_M
+} PLICMode;
+
+typedef struct PLICAddr {
+    uint32_t addrid;
+    uint32_t hartid;
+    PLICMode mode;
+} PLICAddr;
+
+struct VegaPLICState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion mmio;
+    uint32_t num_addrs;
+    uint32_t num_harts;
+    uint32_t bitfield_words;
+    uint32_t num_enables;
+    PLICAddr *addr_config;
+    uint32_t *source_priority;
+    uint32_t *target_priority;
+    uint32_t *pending;
+    uint32_t *claimed;
+    uint32_t *enable;
+
+    /* config */
+    char *hart_config;
+    uint32_t hartid_base;
+    uint32_t num_sources;
+    uint32_t num_priorities;
+    uint32_t priority_base;
+    uint32_t pending_base;
+    uint32_t enable_base;
+    uint32_t enable_stride;
+    uint32_t context_base;
+    uint32_t context_stride;
+    uint32_t aperture_size;
+
+    qemu_irq *m_external_irqs;
+    qemu_irq *s_external_irqs;
+};
+
+DeviceState *vega_plic_create(hwaddr addr, char *hart_config,
+    uint32_t num_harts,
+    uint32_t hartid_base, uint32_t num_sources,
+    uint32_t num_priorities, uint32_t priority_base,
+    uint32_t pending_base, uint32_t enable_base,
+    uint32_t enable_stride, uint32_t context_base,
+    uint32_t context_stride, uint32_t aperture_size);
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


