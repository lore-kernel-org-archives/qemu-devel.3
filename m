Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6066EE7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 13:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJByW-0002xK-DH; Thu, 05 Dec 2024 08:33:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tJBwR-0001Fn-Ei
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:30:54 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tJBwJ-0004rg-Tv
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:30:49 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-723f37dd76cso812543b3a.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 05:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1733405419; x=1734010219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+6bLH7F/RbVb0S8Gq6Hj4WQykM2/sDyBEV7ljMpIlMc=;
 b=Vyc28ub7Z4+LXflB546t9hg46j30UvocGuB3mi1uoeP5VuAf6a+uuF3AXfaDXW4jE1
 yD0MXvWOYz03wXpvyNg90UC50ImV5vMAb+GZgDxaI6DAJG2bvPOmh/LvNFuFKmo4mW14
 nhOWQz8veVSDUK7+eE7NNVftxcHo+rUurWm4DS/KSJeBqw4VoNewGLRFEZJPc1jpj8M5
 uJLKkC2fkEHekJjBrUkQ6dHT2EnqVaU8MagFMk95e5R+sGkO4wa6DA2hVI0sGi+rnMaR
 kyEVEsAeUp2NmcpuEEsCe72Jq34pT4wLPOtezDW6ENmwMsxCMlW9kBuX97zjko4eHB9Y
 UodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733405419; x=1734010219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+6bLH7F/RbVb0S8Gq6Hj4WQykM2/sDyBEV7ljMpIlMc=;
 b=cUQSiAxwXFpPOoSnYFgb7pKiJi8y5Vdm7A4ywHX4eiSEowpyaiXC1RruDgdPoeThD6
 /UbMdulXFZU3Qg8oMrqPCNCdszSCUTvgUboWmSQd0B92xnSlcyQ//4JXgiyT6GX9kUGm
 bcSbdfgTLkiGbtVITRQiM4forl9L2OhVIQyBjL3FEKy8/KmHF7DFDzfjubh+p+QSAGQG
 sIV/Gidf7vwF6SYTS9hhrekYAt5bE/Qx7qv0xQjt+PSEzLrRacHzSeKRTfobukIJQjMU
 rpGgsJlDkl+lRHuEIo2pXBNO/Vd7rzJ3qGoGkPy2072edlCy7HEcgr/SLIAPvaZGKXHP
 9u7A==
X-Gm-Message-State: AOJu0YwBzcqxyXBCZT9aig7UfjcohliwQctrggbasjhL6a+KpMGsYWfg
 vPluFU3UJU6lkKDCoR7qTW6C4Y1C8Dw1Saou/Ua/2iK1IzGHFiUPiW0HYSZ+K0r5qMG/472oAdS
 X
X-Gm-Gg: ASbGnctqOjqxmxSilT/M0F5Tkvy0IZ0nc9Nr5uT2V99VlrRjMkXJ5ON/KziHFCJXyv2
 O7TvUCtK2ru0qcHuUdbN8BSlNB49vWnGgqGyCUyQSGrffuRy7ZB/+O9VuYG8RYOY2jvnXhFmrxP
 bk1t7FXlfRpmisAtqyIWJ0IzQDaDPSY/rAiHVwZHpz7t9MLQNmdg9DHGW8W0a8Tb1q0kMDRaglz
 qGBBc51lEOogqY+FEWo3uNezY22Oay1J3Uqt6LvCbO/aGQRwy8tSn9Lh9eGPXSO7mKLl5awMBAL
X-Google-Smtp-Source: AGHT+IHhxoeA+z+v4s8fZ/XaMqxC7lWrYkebnDPDZkmHwCGOfdw1q8GAwUxrEsveUz2BhhGjeS0WeQ==
X-Received: by 2002:a05:6a00:230b:b0:720:6c6c:52a9 with SMTP id
 d2e1a72fcca58-7257fcc65fbmr16296819b3a.18.1733405419303; 
 Thu, 05 Dec 2024 05:30:19 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a2a8f512sm1250315b3a.126.2024.12.05.05.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 05:30:18 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.0 03/11] hw/riscv/riscv-iommu: add riscv-iommu-hpm file
Date: Thu,  5 Dec 2024 10:29:55 -0300
Message-ID: <20241205133003.184581-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241205133003.184581-1-dbarboza@ventanamicro.com>
References: <20241205133003.184581-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x430.google.com
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

The HPM (Hardware Performance Monitor) support consists of almost 7
hundred lines that would be put on top of the base riscv-iommu
emulation.

To avoid clogging riscv-iommu.c, add a separated riscv-iommu-hpm file
that will contain HPM specific code.

We'll start by adding riscv_iommu_hpmcycle_read(), a helper that will be
called during the riscv_iommu_mmio_read() callback.

This change will have no effect on the existing emulation since we're
not declaring HPM feature support.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/meson.build       |  3 ++-
 hw/riscv/riscv-iommu-hpm.c | 54 ++++++++++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu-hpm.h | 27 +++++++++++++++++++
 hw/riscv/riscv-iommu.c     | 24 ++++++++++++++++-
 hw/riscv/riscv-iommu.h     |  4 +++
 5 files changed, 110 insertions(+), 2 deletions(-)
 create mode 100644 hw/riscv/riscv-iommu-hpm.c
 create mode 100644 hw/riscv/riscv-iommu-hpm.h

diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 3c7e083aca..c22f3a7216 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -10,7 +10,8 @@ riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
 riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
 riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_pfsoc.c'))
 riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
-riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c'))
+riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
+	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-hpm.c'))
 riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
 
 hw_arch += {'riscv': riscv_ss}
diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
new file mode 100644
index 0000000000..5833ab8956
--- /dev/null
+++ b/hw/riscv/riscv-iommu-hpm.c
@@ -0,0 +1,54 @@
+/*
+ * RISC-V IOMMU - Hardware Performance Monitor (HPM) helpers
+ *
+ * Copyright (C) 2022-2023 Rivos Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/timer.h"
+#include "cpu_bits.h"
+#include "riscv-iommu-hpm.h"
+#include "riscv-iommu.h"
+#include "riscv-iommu-bits.h"
+#include "trace.h"
+
+/* For now we assume IOMMU HPM frequency to be 1GHz so 1-cycle is of 1-ns. */
+static inline uint64_t get_cycles(void)
+{
+    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+}
+
+uint64_t riscv_iommu_hpmcycle_read(RISCVIOMMUState *s)
+{
+    const uint64_t cycle = riscv_iommu_reg_get64(
+        s, RISCV_IOMMU_REG_IOHPMCYCLES);
+    const uint32_t inhibit = riscv_iommu_reg_get32(
+        s, RISCV_IOMMU_REG_IOCOUNTINH);
+    const uint64_t ctr_prev = s->hpmcycle_prev;
+    const uint64_t ctr_val = s->hpmcycle_val;
+
+    if (get_field(inhibit, RISCV_IOMMU_IOCOUNTINH_CY)) {
+        /*
+         * Counter should not increment if inhibit bit is set. We can't really
+         * stop the QEMU_CLOCK_VIRTUAL, so we just return the last updated
+         * counter value to indicate that counter was not incremented.
+         */
+        return (ctr_val & RISCV_IOMMU_IOHPMCYCLES_COUNTER) |
+               (cycle & RISCV_IOMMU_IOHPMCYCLES_OVF);
+    }
+
+    return (ctr_val + get_cycles() - ctr_prev) |
+        (cycle & RISCV_IOMMU_IOHPMCYCLES_OVF);
+}
diff --git a/hw/riscv/riscv-iommu-hpm.h b/hw/riscv/riscv-iommu-hpm.h
new file mode 100644
index 0000000000..231c110ff2
--- /dev/null
+++ b/hw/riscv/riscv-iommu-hpm.h
@@ -0,0 +1,27 @@
+/*
+ * RISC-V IOMMU - Hardware Performance Monitor (HPM) helpers
+ *
+ * Copyright (C) 2022-2023 Rivos Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_RISCV_IOMMU_HPM_H
+#define HW_RISCV_IOMMU_HPM_H
+
+#include "qom/object.h"
+#include "hw/riscv/riscv-iommu.h"
+
+uint64_t riscv_iommu_hpmcycle_read(RISCVIOMMUState *s);
+
+#endif
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index e9a0775d6e..01df25418c 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -29,6 +29,7 @@
 #include "cpu_bits.h"
 #include "riscv-iommu.h"
 #include "riscv-iommu-bits.h"
+#include "riscv-iommu-hpm.h"
 #include "trace.h"
 
 #define LIMIT_CACHE_CTX               (1U << 7)
@@ -2052,7 +2053,28 @@ static MemTxResult riscv_iommu_mmio_read(void *opaque, hwaddr addr,
         return MEMTX_ACCESS_ERROR;
     }
 
-    ptr = &s->regs_rw[addr];
+    /* Compute cycle register value. */
+    if ((addr & ~7) == RISCV_IOMMU_REG_IOHPMCYCLES) {
+        val = riscv_iommu_hpmcycle_read(s);
+        ptr = (uint8_t *)&val + (addr & 7);
+    } else if ((addr & ~3) == RISCV_IOMMU_REG_IOCOUNTOVF) {
+        /*
+         * Software can read RISCV_IOMMU_REG_IOCOUNTOVF before timer
+         * callback completes. In which case CY_OF bit in
+         * RISCV_IOMMU_IOHPMCYCLES_OVF would be 0. Here we take the
+         * CY_OF bit state from RISCV_IOMMU_REG_IOHPMCYCLES register as
+         * it's not dependent over the timer callback and is computed
+         * from cycle overflow.
+         */
+        val = ldq_le_p(&s->regs_rw[addr]);
+        val |= (riscv_iommu_hpmcycle_read(s) & RISCV_IOMMU_IOHPMCYCLES_OVF)
+                   ? RISCV_IOMMU_IOCOUNTOVF_CY
+                   : 0;
+        ptr = (uint8_t *)&val + (addr & 3);
+    } else {
+        ptr = &s->regs_rw[addr];
+    }
+
     val = ldn_le_p(ptr, size);
 
     *data = val;
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 2de0cdfc56..380f7e81d1 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -86,6 +86,10 @@ struct RISCVIOMMUState {
 
     QLIST_ENTRY(RISCVIOMMUState) iommus;
     QLIST_HEAD(, RISCVIOMMUSpace) spaces;
+
+    /* HPM cycle counter */
+    uint64_t hpmcycle_val;      /* Current value of cycle register */
+    uint64_t hpmcycle_prev;     /* Saved value of QEMU_CLOCK_VIRTUAL clock */
 };
 
 void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
-- 
2.47.1


