Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC35BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 08:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se9Ya-0001J4-1B; Wed, 14 Aug 2024 04:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5956f96c7e=ian.brockbank@cirrus.com>)
 id 1se9YI-0000qa-Nq; Wed, 14 Aug 2024 04:40:23 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5956f96c7e=ian.brockbank@cirrus.com>)
 id 1se9YD-0005iJ-8U; Wed, 14 Aug 2024 04:40:17 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47E4fos9021737;
 Wed, 14 Aug 2024 03:40:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 PODMain02222019; bh=sL+ey3cE3vPjAjclDSRNt33eW+0cxYbs7PuO1rgOhWU=; b=
 I4o2h2bbwT1o81Ow7md74fu3AM02e8rWTnsZ4Fm4zpMb6hi2txXlPnfLKlQ0j6b5
 VGFUJvkfIpZ/B+Upeycab3/JxjwgfLIuUbTrbntCbEZPkN8mhyR2jQpGqEjZDCPM
 vGkQI0crG0BChngHu2xad6g1TMUzUu1p90ZxAagoslRJT9QfVnd+8BJa1Gtq0IWC
 KSDmwLiHpKtYW+pIQ3IciBJGKqsGIzsDy6cKx6ZQexQGSX2fGwYkwL4s8sL6PDP3
 kLv6kRHcglU58lOlytDeFmqsYbmgZjtgyWhoNprVp2Q2E8iHOpfrawRTNt6966C4
 i5niDei95xniPrzBzGw5yA==
Received: from ausex02.ad.cirrus.com ([141.131.3.21])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 40x4mhmb5a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Aug 2024 03:40:00 -0500 (CDT)
Received: from ausex01.ad.cirrus.com (141.131.37.95) by ausex02.ad.cirrus.com
 (141.131.37.96) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 14 Aug
 2024 03:39:56 -0500
Received: from EDIN7BQBTG3.ad.cirrus.com (141.131.38.212) by
 anon-ausex01.ad.cirrus.com (141.131.37.95) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 14 Aug 2024 03:39:55 -0500
From: Ian Brockbank <Ian.Brockbank@cirrus.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
CC: Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis
 <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ian Brockbank
 <ian.brockbank@cirrus.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Subject: [PATCH 03/11] hw/intc: Add CLIC device
Date: Wed, 14 Aug 2024 09:27:27 +0100
Message-ID: <20240814083836.12256-4-Ian.Brockbank@cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814083836.12256-1-Ian.Brockbank@cirrus.com>
References: <https://lists.gnu.org/archive/html/qemu-riscv/2024-08/msg00234.html>
 <20240814083836.12256-1-Ian.Brockbank@cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 1OJsQ6tGyOyf5n8ncYd1zwbBNK8t694W
X-Proofpoint-GUID: 1OJsQ6tGyOyf5n8ncYd1zwbBNK8t694W
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=67.231.152.168;
 envelope-from=prvs=5956f96c7e=ian.brockbank@cirrus.com;
 helo=mx0b-001ae601.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Ian Brockbank <ian.brockbank@cirrus.com>

The Core-Local Interrupt Controller (CLIC) provides low-latency,
vectored, pre-emptive interrupts for RISC-V systems.

The CLIC also supports a new Selective Hardware Vectoring feature
that allow users to optimize each interrupt for either faster
response or smaller code size.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Signed-off-by: Ian Brockbank <ian.brockbank@cirrus.com>
---
 hw/intc/Kconfig              |    3 +
 hw/intc/meson.build          |    3 +-
 hw/intc/riscv_clic.c         | 1037 ++++++++++++++++++++++++++++++++++
 hw/riscv/Kconfig             |    1 +
 include/hw/intc/riscv_clic.h |  213 +++++++
 target/riscv/cpu.h           |    2 +
 target/riscv/cpu_bits.h      |   17 +
 7 files changed, 1275 insertions(+), 1 deletion(-)
 create mode 100644 hw/intc/riscv_clic.c
 create mode 100644 include/hw/intc/riscv_clic.h

diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index dd405bdb5d..1cd4c2f58c 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -81,6 +81,9 @@ config SIFIVE_PLIC
     bool
     select MSI_NONBROKEN

+config RISCV_CLIC
+    bool
+
 config GOLDFISH_PIC
     bool

diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index f4d81eb8e4..6e0df09265 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -61,7 +61,8 @@ specific_ss.add(when: 'CONFIG_RISCV_ACLINT', if_true: fil=
es('riscv_aclint.c'))
 specific_ss.add(when: 'CONFIG_RISCV_APLIC', if_true: files('riscv_aplic.c'=
))
 specific_ss.add(when: 'CONFIG_RISCV_IMSIC', if_true: files('riscv_imsic.c'=
))
 specific_ss.add(when: 'CONFIG_SIFIVE_PLIC', if_true: files('sifive_plic.c'=
))
-specific_ss.add(when: 'CONFIG_XICS', if_true: files('xics.c', 'xive2.c'))
+specific_ss.add(when: 'CONFIG_RISCV_CLIC', if_true: files('riscv_clic.c'))
+specific_ss.add(when: 'CONFIG_XICS', if_true: files('xics.c'))
 specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_XICS'],
                if_true: files('xics_kvm.c'))
 specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('xics_spapr.c', 'sp=
apr_xive.c'))
diff --git a/hw/intc/riscv_clic.c b/hw/intc/riscv_clic.c
new file mode 100644
index 0000000000..1800e84dfd
--- /dev/null
+++ b/hw/intc/riscv_clic.c
@@ -0,0 +1,1037 @@
+/*
+ * RISC-V CLIC(Core Local Interrupt Controller) for QEMU.
+ *
+ * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
+ * Copyright (c) 2017-2018 SiFive, Inc.
+ * Copyright (c) 2021 T-Head Semiconductor Co., Ltd. All rights reserved.
+ * Copyright (c) 2024 Cirrus Logic, Inc and
+ *      Cirrus Logic International Semiconductor Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along=
 with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * This implementation follows the CLIC 0.9-stable draft at 14 March 2024,
+ * with the following exceptions and implementation details:
+ *  - the CLIC control registers are memory-mapped as per earlier drafts (=
in
+ *    particular version 0.9-draft, 20 June 2023)
+ *  - the indirect CSR control in 0.9-stable is not implemented
+ *  - the vector table can be either handler addresses (as per the spec)
+      or a jump table where each entry is processed as an instruction,
+      selectable with version number v0.9-jmp
+ *  - each hart is assigned its own CLIC block
+ *  - support for PRV_S and PRV_M is selectable at CLIC instantiation by
+ *    passing in a base address for the given modes; a base address of 0 i=
s
+ *    treated as not supported
+ *  - PRV_S and PRV_U registers are mapped  onto the PRV_M controls with
+ *    appropriate filtering for the access mode
+ *
+ * The implementation has a RISCVCLICState per hart, with a RISCVCLICView
+ * for each mode subsidiary to that. Each view knows its access mode and b=
ase
+ * address, as well as the RISCVCLICState with which it is associated.
+ *
+ * MMIO accesses go through the view, allowing the appropriate permissions=
 to
+ * be enforced when accessing the parent RISCVCLICState for the settings.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "qemu/main-loop.h"
+#include "hw/sysbus.h"
+#include "sysemu/qtest.h"
+#include "target/riscv/cpu.h"
+#include "hw/qdev-properties.h"
+#include "hw/intc/riscv_clic.h"
+
+static const char *modeview_name[] =3D {
+    TYPE_RISCV_CLIC "_prv_u",       /* PRV_U */
+    TYPE_RISCV_CLIC "_prv_s",       /* PRV_S */
+    NULL,                           /* reserved */
+    TYPE_RISCV_CLIC "_prv_m",       /* PRV_M */
+};
+
+/*
+ * The 2-bit trig WARL field specifies the trigger type and polarity for e=
ach
+ * interrupt input. Bit 1, trig[0], is defined as "edge-triggered"
+ * (0: level-triggered, 1: edge-triggered); while bit 2, trig[1], is defin=
ed as
+ * "negative-edge" (0: positive-edge, 1: negative-edge). (Section 3.6)
+ */
+
+static inline TRIG_TYPE
+riscv_clic_get_trigger_type(RISCVCLICState *clic, size_t irq)
+{
+    return get_field(clic->clicintattr[irq], CLIC_INTATTR_TRIG);
+}
+
+static inline bool
+riscv_clic_is_edge_triggered(RISCVCLICState *clic, size_t irq)
+{
+    TRIG_TYPE trig_type =3D riscv_clic_get_trigger_type(clic, irq);
+    return trig_type & CLIC_INTATTR_TRIG_EDGE;
+}
+
+static inline bool
+riscv_clic_is_shv_interrupt(RISCVCLICState *clic, size_t irq)
+{
+    uint32_t shv =3D get_field(clic->clicintattr[irq], CLIC_INTATTR_SHV);
+    return shv && clic->shv_enabled;
+}
+
+static uint8_t
+riscv_clic_get_interrupt_level(RISCVCLICState *clic, uint8_t intctl)
+{
+    int nlbits =3D min(clic->mnlbits, clic->clicintctlbits);
+
+    uint8_t mask_il =3D ((1 << nlbits) - 1) << (8 - nlbits);
+    uint8_t mask_padding =3D (1 << (8 - nlbits)) - 1;
+    /* unused level bits are set to 1 */
+    return (intctl & mask_il) | mask_padding;
+}
+
+static uint8_t
+riscv_clic_get_interrupt_priority(RISCVCLICState *clic, uint8_t intctl)
+{
+    int npbits =3D clic->clicintctlbits - clic->mnlbits;
+    uint8_t mask_priority =3D ((1 << npbits) - 1) << (8 - npbits);
+    uint8_t mask_padding =3D (1 << (8 - npbits)) - 1;
+
+    if (npbits < 0) {
+        return UINT8_MAX;
+    }
+    /* unused priority bits are set to 1 */
+    return (intctl & mask_priority) | mask_padding;
+}
+
+static void
+riscv_clic_intcfg_decode(RISCVCLICState *clic, uint16_t intcfg,
+                         uint8_t *mode, uint8_t *level,
+                         uint8_t *priority)
+{
+    *mode =3D intcfg >> 8;
+    *level =3D riscv_clic_get_interrupt_level(clic, intcfg & 0xff);
+    *priority =3D riscv_clic_get_interrupt_priority(clic, intcfg & 0xff);
+}
+
+static void riscv_clic_next_interrupt(void *opaque)
+{
+    /*
+     * Scan active list for highest priority pending interrupts
+     * comparing against this harts mintstatus register and interrupt
+     * the core if we have a higher priority interrupt to deliver
+     */
+    RISCVCLICState *clic =3D (RISCVCLICState *)opaque;
+    CPUState *cpu =3D cpu_by_arch_id(clic->hartid);
+    CPURISCVState *env =3D cpu ? cpu_env(cpu) : NULL;
+
+    if (!env) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "aclint-swi: invalid hartid: %u", clic->hartid);
+        return;
+    }
+
+    BQL_LOCK_GUARD();
+
+    int il[4] =3D {
+        MAX(get_field(env->mintstatus, MINTSTATUS_UIL),
+            clic->uintthresh & 0xff), /* PRV_U */
+        MAX(get_field(env->mintstatus, MINTSTATUS_SIL),
+            clic->sintthresh & 0xff), /* PRV_S */
+        0,                     /* reserved */
+        MAX(get_field(env->mintstatus, MINTSTATUS_MIL),
+            clic->mintthresh & 0xff)  /* PRV_M */
+    };
+
+    /* Get sorted list of enabled interrupts for this hart */
+    CLICActiveInterrupt *active =3D clic->active_list;
+    size_t active_count =3D clic->active_count;
+    uint8_t mode, level, priority;
+
+    /* Loop through the enabled interrupts sorted by mode+priority+level *=
/
+    while (active_count) {
+        riscv_clic_intcfg_decode(clic, active->intcfg, &mode, &level,
+                                 &priority);
+        if (mode < env->priv || (mode =3D=3D env->priv && level < il[mode]=
)) {
+            /*
+             * No pending interrupts with high enough mode+priority+level
+             * break and clear pending interrupt for this hart
+             */
+            break;
+        }
+        /* Check pending interrupt with high enough mode+priority+level */
+        if (clic->clicintip[active->irq]) {
+            /* Clean vector edge-triggered pending */
+            if (riscv_clic_is_edge_triggered(clic, active->irq) &&
+                riscv_clic_is_shv_interrupt(clic, active->irq)) {
+                clic->clicintip[active->irq] =3D 0;
+            }
+            /* Post pending interrupt for this hart */
+            clic->exccode =3D active->irq |
+                            mode << RISCV_EXCP_CLIC_MODE_SHIFT |
+                            level << RISCV_EXCP_CLIC_LEVEL_SHIFT;
+            qemu_set_irq(clic->cpu_irq, 1);
+            return;
+        }
+        /* Check next enabled interrupt */
+        active_count--;
+        active++;
+    }
+}
+
+/*
+ * Any interrupt i that is not accessible to S-mode or U-Mode
+ * appears as hard-wired zeros in clicintip[i], clicintie[i],
+ * clicintattr[i], and clicintctl[i].(Section 3.9)(Section 3.10)
+ */
+static bool
+riscv_clic_check_visible(RISCVCLICState *clic, int mode, int irq)
+{
+    uint8_t intattr_mode =3D get_field(clic->clicintattr[irq],
+                                     CLIC_INTATTR_MODE);
+
+    if (!clic->prv_s && !clic->prv_u) { /* M */
+        return mode =3D=3D PRV_M;
+    } else if (clic->prv_s && clic->prv_u) { /* M/S/U */
+        switch (clic->nmbits) {
+        case 0:
+            return mode =3D=3D PRV_M;
+        case 1:
+            return (mode =3D=3D PRV_M) || (intattr_mode <=3D PRV_S);
+        case 2:
+            return mode >=3D intattr_mode;
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "clic: nmbits can only be 0 or 1 or 2 for M/S/U hart");
+            exit(1);
+        }
+    } else { /* M/S or M/U */
+        switch (clic->nmbits) {
+        case 0:
+            return mode =3D=3D PRV_M;
+        case 1:
+            return (mode =3D=3D PRV_M) || (intattr_mode <=3D PRV_S);
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "clic: nmbits can only be 0 or 1 for M/S or M/U hart");
+            exit(1);
+        }
+    }
+    return false;
+}
+
+/*
+ * For level-triggered interrupts, software writes to pending bits are
+ * ignored completely. (Section 3.4)
+ */
+static bool
+riscv_clic_validate_intip(RISCVCLICState *clic, int irq)
+{
+    return riscv_clic_is_edge_triggered(clic, irq);
+}
+
+static void
+riscv_clic_update_intip(RISCVCLICState *clic, int irq, uint64_t value)
+{
+    clic->clicintip[irq] =3D !!value;
+    riscv_clic_next_interrupt(clic);
+}
+
+/*
+ * For security purpose, the field can only be set to a privilege
+ * level that is equal mode to or lower than the currently running
+ * privilege level.(Section 3.6)
+ */
+static bool riscv_clic_validate_intattr(RISCVCLICState *clic, uint8_t valu=
e)
+{
+    int mode =3D extract64(value, CLIC_INTATTR_MODE_SHIFT,
+                         CLIC_INTATTR_MODE_WIDTH);
+
+    if (!qtest_enabled()) {
+        CPURISCVState *env =3D cpu_env(current_cpu);
+        if (env->priv < mode) {
+            return false;
+        }
+    }
+    return true;
+}
+
+/*
+ * Work out the effective requested mode based on the number of nmbits.
+ *
+ * priv-modes nmbits mode Interpretation
+ * M            0     xx  M-mode interrupt
+ *
+ * M/U          0     xx  M-mode interrupt
+ * M/U          1     0x  U-mode interrupt
+ * M/U          1     1x  M-mode interrupt
+ *
+ * M/S          0     xx  M-mode interrupt
+ * M/S          1     0x  S-mode interrupt
+ * M/S          1     1x  M-mode interrupt
+ *
+ * M/S/U        0     xx  M-mode interrupt
+ * M/S/U        1     0x  S-mode interrupt
+ * M/S/U        1     1x  M-mode interrupt
+ * M/S/U        2     00  U-mode interrupt
+ * M/S/U        2     01  S-mode interrupt
+ * M/S/U        2     10  Reserved
+ * M/S/U        2     11  M-mode interrupt
+ *
+ * M/S/U        3     xx  Reserved
+ */
+static uint8_t riscv_clic_effective_mode(RISCVCLICState *clic, uint8_t int=
attr)
+{
+    uint8_t mode =3D get_field(intattr, CLIC_INTATTR_MODE);
+
+    switch (clic->nmbits) {
+    case 0:
+        mode =3D PRV_M;
+        break;
+
+    case 1:
+        if (mode <=3D PRV_S) {
+            if (clic->prv_s) {
+                mode =3D PRV_S;
+            } else {
+                assert(clic->prv_u);
+                mode =3D PRV_U;
+            }
+        } else {
+            mode =3D PRV_M;
+        }
+        break;
+
+    case 2:
+        /* no modification required */
+        break;
+
+    default:
+        /* We validate nmbits so this shouldn't be possible */
+        assert(clic->nmbits <=3D 2);
+    }
+
+    return mode;
+}
+
+/* Return target interrupt number */
+static int riscv_clic_get_irq(RISCVCLICState *clic, hwaddr addr)
+{
+    return addr / 4;
+}
+
+/* Encode the priority and IRQ as a single sortable value */
+static inline int riscv_clic_encode_priority(const CLICActiveInterrupt *i)
+{
+    /* Highest mode+level+priority */
+    int priority =3D (i->intcfg & CLIC_INTCFG_MASK) << CLIC_IRQ_BITS;
+    /* Highest irq number */
+    int irq =3D i->irq & CLIC_IRQ_MASK;
+    /* Combined */
+    return priority | irq;
+}
+
+static int riscv_clic_active_compare(const void *a, const void *b)
+{
+    return riscv_clic_encode_priority(b) - riscv_clic_encode_priority(a);
+}
+
+static void
+riscv_clic_update_intie(RISCVCLICState *clic, int mode,
+                        int irq, uint64_t new_intie)
+{
+    CLICActiveInterrupt *active_list =3D clic->active_list;
+
+    uint8_t old_intie =3D clic->clicintie[irq];
+    clic->clicintie[irq] =3D !!new_intie;
+
+    /* Add to or remove from list of active interrupts */
+    if (new_intie && !old_intie) {
+        uint16_t intcfg =3D (mode << CLIC_INTCFG_MODE_SHIFT) |
+                           clic->clicintctl[irq];
+        active_list[clic->active_count].intcfg =3D intcfg;
+        active_list[clic->active_count].irq =3D irq;
+        clic->active_count++;
+    } else if (!new_intie && old_intie) {
+        CLICActiveInterrupt key =3D {
+            (mode << 8) | clic->clicintctl[irq], irq
+        };
+        CLICActiveInterrupt *result =3D bsearch(&key,
+                                              active_list, clic->active_co=
unt,
+                                              sizeof(CLICActiveInterrupt),
+                                              riscv_clic_active_compare);
+        assert(result);
+        size_t elem =3D result - active_list;
+        size_t sz =3D --clic->active_count - elem;
+        memmove(&result[0], &result[1], sz);
+    }
+
+    /* Sort list of active interrupts */
+    qsort(active_list, clic->active_count,
+          sizeof(CLICActiveInterrupt),
+          riscv_clic_active_compare);
+
+    riscv_clic_next_interrupt(clic);
+}
+
+static void
+riscv_clic_hart_write(RISCVCLICState *clic, hwaddr addr,
+                      uint64_t value, unsigned size,
+                      int mode, int irq)
+{
+    int req =3D extract32(addr, 0, 2);
+
+    /* visibility is checked in riscv_clic_write */
+
+    if (irq >=3D clic->num_sources) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "clic: invalid irq %u: 0x%" HWADDR_PRIx "\n", irq, a=
ddr);
+        return;
+    }
+
+    switch (req) {
+    case 0: /* clicintip[i] */
+        if (riscv_clic_validate_intip(clic, irq)) {
+            /*
+             * The actual pending bit is located at bit 0 (i.e., the
+             * least significant bit). In case future extensions expand th=
e bit
+             * field, from FW perspective clicintip[i]=3Dzero means no int=
errupt
+             * pending, and clicintip[i]!=3D0 (not just 1) indicates an
+             * interrupt is pending. (Section 3.4)
+             */
+            if (value !=3D clic->clicintip[irq]) {
+                riscv_clic_update_intip(clic, irq, value);
+            }
+        }
+        /* Handle a 32-bit write */
+        if (size > 1) {
+            unsigned width =3D min(size, 4);
+            unsigned i;
+            for (i =3D 1; i < width; i++) {
+                uint64_t local_value =3D (value >> (i * 8)) & 0xFF;
+                riscv_clic_hart_write(clic, addr + i, local_value,
+                                      1, mode, irq);
+            }
+        }
+        break;
+
+    case 1: /* clicintie[i] */
+        if (clic->clicintie[irq] !=3D value) {
+            riscv_clic_update_intie(clic, mode, irq, value);
+        }
+        break;
+
+    case 2: /* clicintattr[i] */
+        uint8_t field_mode =3D riscv_clic_effective_mode(clic, value);
+        if (PRV_RESERVED =3D=3D field_mode) {
+            field_mode =3D get_field(clic->clicintattr[irq],
+                                   CLIC_INTATTR_MODE);
+        }
+        value =3D set_field(value, CLIC_INTATTR_MODE, field_mode);
+        if (riscv_clic_validate_intattr(clic, value)) {
+            if (clic->clicintattr[irq] !=3D value) {
+                clic->clicintattr[irq] =3D value;
+                riscv_clic_next_interrupt(clic);
+            }
+        }
+        break;
+
+    case 3: /* clicintctl[i] */
+        if (value !=3D clic->clicintctl[irq]) {
+            clic->clicintctl[irq] =3D value;
+            riscv_clic_next_interrupt(clic);
+        }
+        break;
+    }
+}
+
+static uint64_t
+riscv_clic_hart_read(RISCVCLICState *clic, hwaddr addr, unsigned size,
+                     int mode, int irq)
+{
+    int req =3D extract32(addr, 0, 2);
+    int i;
+
+    /* visibility is checked in riscv_clic_read */
+
+    if (irq >=3D clic->num_sources) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "clic: invalid irq %u: 0x%" HWADDR_PRIx "\n", irq, a=
ddr);
+        return 0;
+    }
+
+    switch (req) {
+    case 0: /* clicintip[i] */
+        uint64_t retval =3D clic->clicintip[irq];
+        if (size > 1) {
+            /* Handle a multi-part read */
+            for (i =3D 1; i < size; ++i) {
+                uint64_t subval =3D
+                    (riscv_clic_hart_read(clic, addr + i, 1, mode, irq) & =
0xFF);
+                retval |=3D subval << (i * 8);
+            }
+        }
+        return retval;
+
+    case 1: /* clicintie[i] */
+        return clic->clicintie[irq];
+    case 2: /* clicintattr[i] */
+        /*
+         * clicintattr register layout
+         * Bits Field
+         * 7:6 mode
+         * 5:3 reserved (WPRI 0)
+         * 2:1 trig
+         * 0 shv
+         */
+        uint8_t intattr =3D clic->clicintattr[irq] & CLIC_INTATTR_MASK;
+        int field_mode =3D riscv_clic_effective_mode(clic, intattr);
+        intattr =3D set_field(intattr, CLIC_INTATTR_MODE, field_mode);
+        return intattr;
+
+    case 3: /* clicintctl[i] */
+        /*
+         * The implemented bits are kept left-justified in the most-signif=
icant
+         * bits of each 8-bit clicintctl[i] register, with the lower
+         * unimplemented bits treated as hardwired to 1.(Section 3.7)
+         */
+        return clic->clicintctl[irq] |
+               ((1 << (8 - clic->clicintctlbits)) - 1);
+    }
+
+    return 0;
+}
+
+static void
+riscv_clic_write(void *opaque, hwaddr addr, uint64_t value, unsigned size)
+{
+    RISCVCLICView *clicview =3D opaque;
+    RISCVCLICState *clic =3D clicview->clic;
+    CPUState *cpu =3D cpu_by_arch_id(clic->hartid);
+    CPURISCVState *env =3D cpu ? cpu_env(cpu) : NULL;
+    hwaddr clic_size =3D clic->clic_size;
+    int mode =3D clicview->mode, irq;
+    const char *current_mode_str =3D (PRV_M =3D=3D env->priv) ? "PRV_M" :
+                                   (PRV_S =3D=3D env->priv) ? "PRV_S" :
+                                   (PRV_U =3D=3D env->priv) ? "PRV_U" :
+                                   "unknown";
+    const char *access_mode_str =3D (PRV_M =3D=3D mode) ? "PRV_M" :
+                                  (PRV_S =3D=3D mode) ? "PRV_S" :
+                                  (PRV_U =3D=3D mode) ? "PRV_U" :
+                                  "unknown";
+
+    assert(addr < clic_size);
+
+    if (mode > env->priv) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "clic: invalid write to %s CLIC registers in %s mode=
\n",
+                      access_mode_str, current_mode_str);
+        return;
+    }
+
+    if (addr < CLIC_INTCTL_BASE) {
+        assert(addr % 4 =3D=3D 0);
+        int index =3D addr / 4;
+        switch (index) {
+        case 0: /* cliccfg */
+            {
+                uint8_t mnlbits =3D extract32(value, 0, 4);
+                uint8_t nmbits =3D extract32(value, 4, 2);
+                uint8_t snlbits =3D extract32(value, 16, 4);
+                uint8_t unlbits =3D extract32(value, 24, 4);
+
+                /*
+                 * The 4-bit cliccfg.mnlbits WARL field.
+                 * Valid values are 0=E2=80=948.
+                 */
+                if (mnlbits <=3D 8 && PRV_M =3D=3D mode) {
+                    clic->mnlbits =3D mnlbits;
+                }
+                if (clic->prv_s && snlbits <=3D 8 && mode >=3D PRV_S) {
+                    clic->snlbits =3D snlbits;
+                }
+                if (clic->prv_u && unlbits <=3D 8) {
+                    clic->unlbits =3D unlbits;
+                }
+
+                /*
+                 * The nmbits field - the number of bits for the mode.
+                 * Valid values are given by implemented privileges.
+                 * This is only accessible in PRV_M.
+                 */
+                if (PRV_M =3D=3D mode) {
+                    if (clic->prv_s && clic->prv_u) {
+                        if (nmbits <=3D 2) {
+                            clic->nmbits =3D nmbits;
+                        }
+                    } else if (clic->prv_s || clic->prv_u) {
+                        if (nmbits <=3D 1) {
+                            clic->nmbits =3D nmbits;
+                        }
+                    } else {
+                        if (nmbits =3D=3D 0) {
+                            clic->nmbits =3D 0;
+                        }
+                    }
+                }
+
+                break;
+            }
+        case CLIC_INTTRIG_START ... CLIC_INTTRIG_END: /* clicinttrig */
+            {
+                uint32_t interrupt_number =3D value & CLIC_INTTRIG_IRQN;
+                if (interrupt_number <=3D clic->num_sources) {
+                    value &=3D CLIC_INTTRIG_MASK;
+                    clic->clicinttrig[index - CLIC_INTTRIG_START] =3D valu=
e;
+                    /* TODO: How does this cause the interrupt to trigger?=
 */
+                }
+                break;
+            }
+        case 2: /* mintthresh - only in CLIC spec v0.8 */
+            if (0 =3D=3D strcmp(clic->version, "v0.8")) {
+                clic->mintthresh =3D value;
+                break;
+            }
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "clic: invalid write addr: 0x%" HWADDR_PRIx "\n"=
,
+                          addr);
+            break;
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "clic: invalid write addr: 0x%" HWADDR_PRIx "\n"=
,
+                          addr);
+            return;
+        }
+    } else {
+        addr -=3D CLIC_INTCTL_BASE;
+        irq =3D riscv_clic_get_irq(clic, addr);
+
+        if (riscv_clic_check_visible(clic, mode, irq)) {
+            riscv_clic_hart_write(clic, addr, value, size, mode, irq);
+        }
+    }
+}
+
+static uint64_t
+riscv_clic_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RISCVCLICView *clicview =3D opaque;
+    RISCVCLICState *clic =3D clicview->clic;
+    CPUState *cpu =3D cpu_by_arch_id(clic->hartid);
+    CPURISCVState *env =3D cpu ? cpu_env(cpu) : NULL;
+    hwaddr clic_size =3D clic->clic_size;
+    int mode =3D clicview->mode, irq;
+
+    assert(addr < clic_size);
+
+    if (mode > env->priv) {
+        const char *current_mode_str =3D (PRV_M =3D=3D env->priv) ? "PRV_M=
" :
+                                       (PRV_S =3D=3D env->priv) ? "PRV_S" =
:
+                                       (PRV_U =3D=3D env->priv) ? "PRV_U" =
:
+                                       "unknown";
+        const char *access_mode_str =3D (PRV_M =3D=3D mode) ? "PRV_M" :
+                                      (PRV_S =3D=3D mode) ? "PRV_S" :
+                                      (PRV_U =3D=3D mode) ? "PRV_U" :
+                                      "unknown";
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "clic: invalid write to %s CLIC registers in %s mode=
\n",
+                      access_mode_str, current_mode_str);
+        return 0;
+    }
+
+    if (addr < CLIC_INTCTL_BASE) {
+        assert(addr % 4 =3D=3D 0);
+        int index =3D addr / 4;
+        switch (index) {
+        case 0:
+            /*
+             * cliccfg register layout
+             *
+             * Bits     Field
+             * 31:28    reserved (WPRI 0)
+             * 27:24    unlbits
+             * 23:20    reserved (WPRI 0)
+             * 19:16    snlbits
+             * 15:6     reserved (WPRI 0)
+             *  5:4     nmbits
+             *  3:0     mnlbits
+             */
+            uint64_t cliccfg =3D 0;
+            if (PRV_M =3D=3D mode) {
+                cliccfg =3D clic->mnlbits | (clic->nmbits << 4);
+            }
+            if (clic->prv_s && mode >=3D PRV_S) {
+                cliccfg |=3D clic->snlbits << 16;
+            }
+            if (clic->prv_u && mode >=3D PRV_U) {
+                cliccfg |=3D clic->unlbits << 24;
+            }
+            return cliccfg;
+
+        case CLIC_INTTRIG_START ... CLIC_INTTRIG_END: /* clicinttrig */
+            /*
+             * clicinttrig register layout
+             *
+             * Bits Field
+             * 31 enable
+             * 30:13 reserved (WARL 0)
+             * 12:0 interrupt_number
+             */
+            uint64_t inttrig =3D clic->clicinttrig[index - CLIC_INTTRIG_ST=
ART];
+            return inttrig & CLIC_INTTRIG_MASK;
+
+        case 2: /* mintthresh - only in CLIC spec v0.8 */
+            if (0 =3D=3D strcmp(clic->version, "v0.8")) {
+                return clic->mintthresh;
+                break;
+            }
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "clic: invalid read : 0x%" HWADDR_PRIx "\n",
+                          addr);
+            break;
+
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "clic: invalid read : 0x%" HWADDR_PRIx "\n",
+                          addr);
+            break;
+        }
+    } else {
+        addr -=3D CLIC_INTCTL_BASE;
+        irq =3D riscv_clic_get_irq(clic, addr);
+
+        if (riscv_clic_check_visible(clic, mode, irq)) {
+            return riscv_clic_hart_read(clic, addr, size, mode, irq);
+        }
+    }
+
+    return 0;
+}
+
+static void riscv_clic_set_irq(void *opaque, int id, int level)
+{
+    RISCVCLICState *clic =3D opaque;
+    TRIG_TYPE type;
+
+    type =3D riscv_clic_get_trigger_type(clic, id);
+
+    /*
+     * In general, the edge-triggered interrupt state should be kept in pe=
nding
+     * bit, while the level-triggered interrupt should be kept in the leve=
l
+     * state of the incoming wire.
+     *
+     * For CLIC, model the level-triggered interrupt by read-only pending =
bit.
+     */
+    if (level) {
+        switch (type) {
+        case POSITIVE_LEVEL:
+        case POSITIVE_EDGE:
+            riscv_clic_update_intip(clic, id, level);
+            break;
+        case NEG_LEVEL:
+            riscv_clic_update_intip(clic, id, !level);
+            break;
+        case NEG_EDGE:
+            break;
+        default:
+            /* It's a 2-bit field so this shouldn't be possible */
+            assert(type <=3D 3);
+        }
+    } else {
+        switch (type) {
+        case POSITIVE_LEVEL:
+            riscv_clic_update_intip(clic, id, level);
+            break;
+        case POSITIVE_EDGE:
+            break;
+        case NEG_LEVEL:
+        case NEG_EDGE:
+            riscv_clic_update_intip(clic, id, !level);
+            break;
+        default:
+            /* It's a 2-bit field so this shouldn't be possible */
+            assert(type <=3D 3);
+        }
+    }
+}
+
+static void riscv_clic_cpu_irq_handler(void *opaque, int irq, int level)
+{
+    CPURISCVState *env =3D (CPURISCVState *)opaque;
+    RISCVCLICState *clic =3D env->clic;
+
+    if (level) {
+        env->exccode =3D clic->exccode;
+        cpu_interrupt(env_cpu(env), CPU_INTERRUPT_CLIC);
+    }
+}
+
+static const MemoryRegionOps riscv_clic_ops =3D {
+    .read =3D riscv_clic_read,
+    .write =3D riscv_clic_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 1,
+        .max_access_size =3D 8
+    }
+};
+
+static void riscv_clic_realize(DeviceState *dev, Error **errp)
+{
+    RISCVCLICState *clic =3D RISCV_CLIC(dev);
+    size_t irqs =3D clic->num_sources;
+
+    if (clic->prv_s && clic->prv_u) {
+        clic->nmbits =3D 2;
+    } else if (clic->prv_s || clic->prv_u) {
+        clic->nmbits =3D 1;
+    } else {
+        clic->nmbits =3D 0;
+    }
+
+    clic->clicintip =3D g_new0(uint8_t, irqs);
+    clic->clicintie =3D g_new0(uint8_t, irqs);
+    clic->clicintattr =3D g_new0(uint8_t, irqs);
+    clic->clicintctl =3D g_new0(uint8_t, irqs);
+    clic->active_list =3D g_new0(CLICActiveInterrupt, irqs);
+
+    if (!clic->prv_s) {
+        clic->snlbits =3D 0;
+    }
+    if (!clic->prv_u) {
+        clic->unlbits =3D 0;
+    }
+
+    /* Allocate irqs through gpio, so that we can use qtest */
+    qdev_init_gpio_in(dev, riscv_clic_set_irq, irqs);
+    qdev_init_gpio_out(dev, &clic->cpu_irq, 1);
+
+    assert(cpu_exists(clic->hartid));
+    RISCVCPU *cpu =3D RISCV_CPU(qemu_get_cpu(clic->hartid));
+    qemu_irq irq =3D qemu_allocate_irq(riscv_clic_cpu_irq_handler, &cpu->e=
nv, 1);
+    qdev_connect_gpio_out(dev, 0, irq);
+    cpu->env.clic =3D clic;
+}
+
+static void riscv_clic_view_realize(DeviceState *dev, Error **errp)
+{
+    RISCVCLICView *clicview =3D RISCV_CLIC_VIEW(dev);
+    RISCVCLICState *clic =3D clicview->clic;
+
+    memory_region_init_io(&clicview->mmio, OBJECT(clicview), &riscv_clic_o=
ps,
+                          clicview, TYPE_RISCV_CLIC_VIEW, clic->clic_size)=
;
+    sysbus_init_mmio(SYS_BUS_DEVICE(clicview), &clicview->mmio);
+}
+
+static Property riscv_clic_properties[] =3D {
+    DEFINE_PROP_BOOL("shv-enabled", RISCVCLICState, shv_enabled, true),
+    DEFINE_PROP_BOOL("jump-table", RISCVCLICState, jump_table, false),
+    DEFINE_PROP_UINT8("mnlbits", RISCVCLICState, mnlbits, 8),
+    DEFINE_PROP_UINT8("snlbits", RISCVCLICState, snlbits, 8),
+    DEFINE_PROP_UINT8("unlbits", RISCVCLICState, unlbits, 8),
+    DEFINE_PROP_INT32("hartid", RISCVCLICState, hartid, 0),
+    DEFINE_PROP_UINT32("num-sources", RISCVCLICState, num_sources, 0),
+    DEFINE_PROP_UINT32("clic-size", RISCVCLICState, clic_size, 0),
+    DEFINE_PROP_UINT32("clicintctlbits", RISCVCLICState, clicintctlbits, 0=
),
+    DEFINE_PROP_STRING("version", RISCVCLICState, version),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static Property riscv_clic_view_properties[] =3D {
+    DEFINE_PROP_LINK("clic", RISCVCLICView, clic,
+                     TYPE_RISCV_CLIC, RISCVCLICState *),
+    DEFINE_PROP_UINT8("mode", RISCVCLICView, mode, PRV_U),
+    DEFINE_PROP_UINT64("clicbase", RISCVCLICView, clicbase, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void riscv_clic_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D riscv_clic_realize;
+    device_class_set_props(dc, riscv_clic_properties);
+}
+
+static void riscv_clic_view_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D riscv_clic_view_realize;
+    device_class_set_props(dc, riscv_clic_view_properties);
+}
+
+static const TypeInfo riscv_clic_info =3D {
+    .name          =3D TYPE_RISCV_CLIC,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(RISCVCLICState),
+    .class_init    =3D riscv_clic_class_init,
+};
+
+static const TypeInfo riscv_clic_view_info =3D {
+    .name =3D TYPE_RISCV_CLIC_VIEW,
+    .parent =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(RISCVCLICView),
+    .class_init =3D riscv_clic_view_init,
+};
+
+static void riscv_clic_register_types(void)
+{
+    type_register_static(&riscv_clic_info);
+    type_register_static(&riscv_clic_view_info);
+}
+
+type_init(riscv_clic_register_types)
+
+/*
+ * riscv_clic_view_create:
+ *
+ * @clic: machine-mode CLIC this is an view onto
+ * @clicbase: base address of this view CLIC memory-mapped registers
+ * @mode: the mode of the view - PRV_S or PRV_U
+ *
+ * Returns: the new view
+ */
+static RISCVCLICView *riscv_clic_view_create(RISCVCLICState *clic,
+                                             hwaddr clicbase, int mode)
+{
+    DeviceState *dev =3D qdev_new(TYPE_RISCV_CLIC_VIEW);
+    RISCVCLICView *clicview =3D RISCV_CLIC_VIEW(dev);
+    Object *obj =3D OBJECT(dev);
+    Object *clicobj =3D OBJECT(clic);
+
+    assert(0 !=3D clic);                  /* this should exist */
+    assert(0 !=3D clicbase);              /* this should exist */
+    assert(0 =3D=3D (clicbase & 0xfff));    /* base should be 4KiB-aligned=
 */
+    assert(PRV_M =3D=3D mode || PRV_S =3D=3D mode || PRV_U =3D=3D mode);
+
+    object_property_add_child(clicobj, modeview_name[mode], obj);
+    clicview->clic =3D clic;
+
+    qdev_prop_set_uint8(dev, "mode", mode);
+    qdev_prop_set_uint64(dev, "clicbase", clicbase);
+
+    if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal)) {
+        object_unparent(obj);
+        return NULL;
+    }
+
+    memory_region_init_io(&clicview->mmio, OBJECT(dev), &riscv_clic_ops,
+                          clicview, TYPE_RISCV_CLIC_VIEW, clic->clic_size)=
;
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, clicbase);
+
+    return clicview;
+}
+
+/*
+ * riscv_clic_create:
+ *
+ * @mclicbase: base address of PRV_M CLIC memory-mapped registers
+ * @sclicbase: base address of PRV_S CLIC memory-mapped registers
+ * @uclicbase: base address of PRV_U CLIC memory-mapped registers
+ * @hartid: the HART ID this CLIC is serving
+ * @num_sources: number of interrupts supporting by each aperture
+ * @clicintctlbits: bits are actually implemented in the clicintctl regist=
ers
+ * @version: clic version, such as "v0.9"; append "-jmp" for jump table in=
stead
+ *           of function pointers
+ *
+ * Returns: the device object
+ */
+DeviceState *riscv_clic_create(hwaddr mclicbase, hwaddr sclicbase,
+                               hwaddr uclicbase, uint32_t hartid,
+                               uint32_t num_sources, uint8_t clicintctlbit=
s,
+                               const char *version)
+{
+    DeviceState *dev =3D qdev_new(TYPE_RISCV_CLIC);
+    RISCVCLICState *s =3D RISCV_CLIC(dev);
+    g_autofree char **tokens =3D NULL;
+    char *base_version;
+    bool jump_table =3D false;
+
+    assert(num_sources <=3D CLIC_MAX_IRQ_COUNT);
+    assert(cpu_exists(hartid));
+    assert(clicintctlbits <=3D MAX_CLIC_INTCTLBITS);
+    assert(0 =3D=3D (mclicbase & 0xfff));    /* base should be 4KiB-aligne=
d */
+
+    /* Parse the version */
+    tokens =3D g_strsplit(version, "-", 2);
+    base_version =3D g_strdup(tokens[0]);
+    assert(0 =3D=3D strcmp(base_version, "v0.9"));
+    if (tokens[1]) {
+        assert(0 =3D=3D strcmp(tokens[1], "jmp"));
+        jump_table =3D true;
+    }
+
+    qdev_prop_set_uint32(dev, "hartid", hartid);
+    qdev_prop_set_uint32(dev, "num-sources", num_sources);
+    qdev_prop_set_uint32(dev, "clic-size", num_sources * 4 + CLIC_INTCTL_B=
ASE);
+    qdev_prop_set_uint32(dev, "clicintctlbits", clicintctlbits);
+    qdev_prop_set_string(dev, "version", base_version);
+    qdev_prop_set_bit(dev, "jump-table", jump_table);
+
+    s->prv_m =3D riscv_clic_view_create(s, mclicbase, PRV_M);
+    if (sclicbase) {
+        s->prv_s =3D riscv_clic_view_create(s, sclicbase, PRV_S);
+    }
+    if (uclicbase) {
+        s->prv_u =3D riscv_clic_view_create(s, uclicbase, PRV_U);
+    }
+
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    return dev;
+}
+
+void riscv_clic_get_next_interrupt(void *opaque)
+{
+    RISCVCLICState *clic =3D opaque;
+    riscv_clic_next_interrupt(clic);
+}
+
+bool riscv_clic_shv_interrupt(void *opaque, int irq)
+{
+    RISCVCLICState *clic =3D opaque;
+    return riscv_clic_is_shv_interrupt(clic, irq);
+}
+
+bool riscv_clic_edge_triggered(void *opaque, int irq)
+{
+    RISCVCLICState *clic =3D opaque;
+    return riscv_clic_is_edge_triggered(clic, irq);
+}
+
+bool riscv_clic_use_jump_table(void *opaque)
+{
+    RISCVCLICState *clic =3D opaque;
+    return clic->jump_table;
+}
+
+void riscv_clic_clean_pending(void *opaque, int irq)
+{
+    RISCVCLICState *clic =3D opaque;
+    clic->clicintip[irq] =3D 0;
+}
+
+/*
+ * The new CLIC interrupt-handling mode is encoded as a new state in
+ * the existing WARL xtvec register, where the low two bits are 11.
+ */
+bool riscv_clic_is_clic_mode(CPURISCVState *env)
+{
+    target_ulong xtvec =3D (env->priv =3D=3D PRV_M) ? env->mtvec : env->st=
vec;
+    return env->clic && ((xtvec & XTVEC_MODE) =3D=3D XTVEC_CLIC);
+}
+
+void riscv_clic_decode_exccode(uint32_t exccode, int *mode,
+                               int *il, int *irq)
+{
+    *irq =3D get_field(exccode, RISCV_EXCP_CLIC_IRQ);
+    *mode =3D get_field(exccode, RISCV_EXCP_CLIC_MODE);
+    *il =3D get_field(exccode, RISCV_EXCP_CLIC_LEVEL);
+}
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index a2030e3a6f..18454df8bd 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -47,6 +47,7 @@ config RISCV_VIRT
     select SERIAL
     select RISCV_ACLINT
     select RISCV_APLIC
+    select RISCV_CLIC
     select RISCV_IMSIC
     select SIFIVE_PLIC
     select SIFIVE_TEST
diff --git a/include/hw/intc/riscv_clic.h b/include/hw/intc/riscv_clic.h
new file mode 100644
index 0000000000..b38a576308
--- /dev/null
+++ b/include/hw/intc/riscv_clic.h
@@ -0,0 +1,213 @@
+/*
+ * RISC-V CLIC(Core Local Interrupt Controller) interface.
+ *
+ * Copyright (c) 2021 T-Head Semiconductor Co., Ltd. All rights reserved.
+ * Copyright (c) 2024 Cirrus Logic, Inc
+ *      and Cirrus Logic International Semiconductor Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along=
 with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * This implementation follows the CLIC 0.9-stable draft at 14 March 2024,
+ * with the following exceptions and implementation details:
+ *  - the CLIC control registers are memory-mapped as per earlier drafts (=
in
+ *    particular version 0.9-draft, 20 June 2023)
+ *  - the indirect CSR control in 0.9-stable is not implemented
+ *  - the vector table can be either handler addresses (as per the spec)
+      or a jump table where each entry is processed as an instruction,
+      selectable with version number v0.9-jmp
+ *  - each hart is assigned its own CLIC block
+ *  - if PRV_S and/or PRV_M are supported, they are currently assumed to f=
ollow
+ *    the PRV_M registers; a subsequent update will address this
+ *  - support for PRV_S and PRV_M is selectable at CLIC instantiation
+ *  - PRV_S and PRV_U registers are currently separate from PRV_M; a subse=
quent
+ *    update will turn them into filtered views onto the PRV_M registers
+ *  - each hart is assigned its own CLIC block
+ *  - support for PRV_S and PRV_M is selectable at CLIC instantiation by
+ *    passing in a base address for the given modes; a base address of 0 i=
s
+ *    treated as not supported
+ *  - PRV_S and PRV_U registers are mapped  onto the PRV_M controls with
+ *    appropriate filtering for the access mode
+ *
+ * The implementation has a RISCVCLICState per hart, with a RISCVCLICView
+ * for each mode subsidiary to that. Each view knows its access mode and b=
ase
+ * address, as well as the RISCVCLICState with which it is associated.
+ *
+ * MMIO accesses go through the view, allowing the appropriate permissions=
 to
+ * be enforced when accessing the parent RISCVCLICState for the settings.
+ */
+
+#ifndef RISCV_CLIC_H
+#define RISCV_CLIC_H
+
+#include "hw/irq.h"
+#include "hw/sysbus.h"
+
+#define TYPE_RISCV_CLIC "riscv_clic"
+#define TYPE_RISCV_CLIC_VIEW "riscv_clic_view"
+#define RISCV_CLIC(obj) \
+    OBJECT_CHECK(RISCVCLICState, (obj), TYPE_RISCV_CLIC)
+#define RISCV_CLIC_VIEW(obj) \
+    OBJECT_CHECK(RISCVCLICView, (obj), TYPE_RISCV_CLIC_VIEW)
+
+/*
+ * CLIC per hart active interrupts
+ *
+ * We maintain per hart lists of enabled interrupts sorted by
+ * mode+level+priority. The sorting is done on the configuration path
+ * so that the interrupt delivery fastpath can linear scan enabled
+ * interrupts in priority order.
+ */
+typedef struct CLICActiveInterrupt {
+    uint16_t intcfg;
+    uint16_t irq;
+} CLICActiveInterrupt;
+
+typedef enum TRIG_TYPE {
+    POSITIVE_LEVEL,
+    POSITIVE_EDGE,
+    NEG_LEVEL,
+    NEG_EDGE,
+} TRIG_TYPE;
+
+#define CLIC_INTCTL_BASE        0x1000  /* start offset of intctl register=
s */
+#define MAX_CLIC_INTCTLBITS     8       /* maximum value for intctlbits */
+
+/* maximum of 4096 IRQs */
+#define CLIC_IRQ_BITS           12
+#define CLIC_MAX_IRQ_COUNT      (1 << CLIC_IRQ_BITS)
+#define CLIC_MAX_IRQ            (CLIC_MAX_IRQ_COUNT - 1)
+#define CLIC_IRQ_MASK           CLIC_MAX_IRQ
+
+/*
+ * clicinttrig registers
+ * 31       interrupt_trap_enable
+ * 30       nxti_enable
+ * 29:13    reserved (WARL 0)
+ * 12:0     interrupt_number
+ */
+#define CLIC_INTTRIG_REGS       32      /* inttrig register count */
+#define CLIC_INTTRIG_START      0x10    /* first inttrig register */
+#define CLIC_INTTRIG_END        (CLIC_INTTRIG_START + CLIC_INTTRIG_REGS - =
1)
+#define CLIC_INTTRIG_TRAP_ENA   0x80000000
+#define CLIC_INTTRIG_NXTI_ENA   0x40000000
+#define CLIC_INTTRIG_IRQN       0x00001fff
+#define CLIC_INTTRIG_MASK       (CLIC_INTTRIG_TRAP_ENA | \
+                                 CLIC_INTTRIG_NXTI_ENA | CLIC_INTTRIG_IRQN=
)
+
+/*
+ * We combine the mode and intctl to a number so that higher modes come fi=
rst.
+ * 9:8  machine mode
+ * 7:0  clicintctl
+ */
+#define CLIC_INTCFG_MODE_SHIFT  8
+#define CLIC_INTCFG_MODE        0x300
+#define CLIC_INTCFG_CTL         0xff
+#define CLIC_INTCFG_MASK        (CLIC_INTCFG_MODE | CLIC_INTCFG_CTL)
+
+/*
+ * clicintattr layout
+ * 7:6  mode
+ * 5:3  reserved (WPRI 0)
+ * 2:1  trig
+ * 0    shv
+ */
+#define CLIC_INTATTR_MODE_SHIFT     6
+#define CLIC_INTATTR_MODE_WIDTH     2
+#define CLIC_INTATTR_MODE           0xc0
+#define CLIC_INTATTR_TRIG_SHIFT     1
+#define CLIC_INTATTR_TRIG_WIDTH     2
+#define CLIC_INTATTR_TRIG           0x06
+#define CLIC_INTATTR_SHV            0x01
+#define CLIC_INTATTR_MASK           (CLIC_INTATTR_MODE | CLIC_INTATTR_TRIG=
 | \
+                                     CLIC_INTATTR_SHV)
+/* The clicintattr value */
+#define CLIC_INTATTR_TRIG_EDGE      0b01    /* trig decode edge-triggered =
*/
+#define CLIC_INTATTR_TRIG_INV       0b10    /* trig decode negative polari=
ty */
+
+/* Forward declaration */
+typedef struct RISCVCLICView RISCVCLICView;
+
+/*
+ * The main CLIC state (PRV_M mode) for a hart.
+ */
+typedef struct RISCVCLICState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+
+    /* Implementation parameters */
+    bool shv_enabled;       /* hardware-vectoring enabled */
+    bool jump_table;        /* vector with jump table, not handler address=
es */
+    int hartid;
+    uint32_t num_sources;
+    uint32_t clic_size;
+    uint32_t clic_mmode_base;
+    uint32_t clicintctlbits;
+    RISCVCLICView *prv_m;    /* our PRV_M view */
+    RISCVCLICView *prv_s;    /* our PRV_S view */
+    RISCVCLICView *prv_u;    /* our PRV_U view */
+    char *version;
+
+    /* Global configuration */
+    uint8_t nmbits;         /* mode bits */
+    uint8_t mnlbits;        /* level bits for M-mode */
+    uint8_t snlbits;        /* level bits for S-mode, if present */
+    uint8_t unlbits;        /* level bits for U-mode, if present */
+    uint32_t clicinttrig[CLIC_INTTRIG_REGS];
+
+    /* Aperture configuration */
+    uint8_t *clicintip;
+    uint8_t *clicintie;
+    uint8_t *clicintattr;
+    uint8_t *clicintctl;
+
+    /* Compatible with v0.8 */
+    uint32_t mintthresh;
+    uint32_t sintthresh;
+    uint32_t uintthresh;
+
+    /* QEMU implementation related fields */
+    uint32_t exccode;
+    CLICActiveInterrupt *active_list;
+    size_t active_count;
+    qemu_irq cpu_irq;
+} RISCVCLICState;
+
+/*
+ * A PRV_S or PRV_U overlay onto the main RISCVCLICState.
+ */
+typedef struct RISCVCLICView {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    RISCVCLICState *clic;       /* the CLIC this is a view onto */
+    MemoryRegion mmio;
+    uint64_t clicbase;
+    uint8_t mode;
+} RISCVCLICView;
+
+DeviceState *riscv_clic_create(hwaddr mclicbase, hwaddr sclicbase,
+                               hwaddr uclicbase, uint32_t hartid,
+                               uint32_t num_sources, uint8_t clicintctlbit=
s,
+                               const char *version);
+
+void riscv_clic_decode_exccode(uint32_t exccode, int *mode, int *il, int *=
irq);
+void riscv_clic_clean_pending(void *opaque, int irq);
+bool riscv_clic_edge_triggered(void *opaque, int irq);
+bool riscv_clic_shv_interrupt(void *opaque, int irq);
+bool riscv_clic_use_jump_table(void *opaque);
+void riscv_clic_get_next_interrupt(void *opaque);
+bool riscv_clic_is_clic_mode(CPURISCVState *env);
+#endif
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 9b5f36ad0a..12aa8cf6b1 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -36,6 +36,7 @@
 typedef struct CPUArchState CPURISCVState;

 #define CPU_RESOLVING_TYPE TYPE_RISCV_CPU
+#define CPU_INTERRUPT_CLIC CPU_INTERRUPT_TGT_EXT_0

 #if defined(TARGET_RISCV32)
 # define TYPE_RISCV_CPU_BASE            TYPE_RISCV_CPU_BASE32
@@ -465,6 +466,7 @@ struct CPUArchState {
     bool vstime_irq;

     void *clic;       /* clic interrupt controller */
+    uint32_t exccode; /* clic irq encode */

     hwaddr kernel_addr;
     hwaddr fdt_addr;
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index ad45402370..0ed44ec0a8 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -694,6 +694,12 @@ typedef enum RISCVException {
 } RISCVException;

 #define RISCV_EXCP_INT_FLAG                0x80000000
+#define RISCV_EXCP_CLIC                    0x40000000
+#define RISCV_EXCP_CLIC_LEVEL_SHIFT        14
+#define RISCV_EXCP_CLIC_LEVEL              (0xff << RISCV_EXCP_CLIC_LEVEL_=
SHIFT)
+#define RISCV_EXCP_CLIC_MODE_SHIFT         12
+#define RISCV_EXCP_CLIC_MODE               (3 << RISCV_EXCP_CLIC_MODE_SHIF=
T)
+#define RISCV_EXCP_CLIC_IRQ                0x00000fff
 #define RISCV_EXCP_INT_MASK                0x7fffffff

 /* Interrupt causes */
@@ -746,6 +752,17 @@ typedef enum RISCVException {
 #define SINTSTATUS_SIL                     0x0000ff00 /* sil[15:8] */
 #define SINTSTATUS_UIL                     0x000000ff /* uil[7:0] */

+/* mtvec & stvec */
+#define XTVEC_MODE                         0x03
+#define XTVEC_SUBMODE                      0x3c
+#define XTVEC_FULL_MODE                    (XTVEC_MODE | XTVEC_SUBMODE)
+#define XTVEC_OBASE                        (~XTVEC_MODE)
+#define XTVEC_NBASE                        (~XTVEC_FULL_MODE)
+
+#define XTVEC_CLINT_DIRECT                 0x0
+#define XTVEC_CLINT_VECTORED               0x1
+#define XTVEC_CLIC                         0x3
+
 /* MIE masks */
 #define MIE_SEIE                           (1 << IRQ_S_EXT)
 #define MIE_UEIE                           (1 << IRQ_U_EXT)
--
2.46.0.windows.1
This message and any attachments may contain privileged and confidential in=
formation that is intended solely for the person(s) to whom it is addressed=
. If you are not an intended recipient you must not: read; copy; distribute=
; discuss; take any action in or make any reliance upon the contents of thi=
s message; nor open or read any attachment. If you have received this messa=
ge in error, please notify us as soon as possible on the following telephon=
e number and destroy this message including any attachments. Thank you. Cir=
rus Logic International (UK) Ltd and Cirrus Logic International Semiconduct=
or Ltd are companies registered in Scotland, with registered numbers SC0898=
39 and SC495735 respectively. Our registered office is at 7B Nightingale Wa=
y, Quartermile, Edinburgh, EH3 9EG, UK. Tel: +44 (0)131 272 7000. www.cirru=
s.com

