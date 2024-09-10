Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28381EDE9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so50N-0005p6-Io; Tue, 10 Sep 2024 13:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1so50K-0005gE-F7; Tue, 10 Sep 2024 13:50:16 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1so50H-0005oA-4q; Tue, 10 Sep 2024 13:50:16 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 0B3AEC0005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1725990610;
 bh=g9U/+M8BpKrhlYPtfur6st6R1S/cQc6zsYpV1Jr6WxY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=xIxyqHTF2Mm7UyqRU0mpzhKWSjaAk/w3Egs1KESlJYhF3NW+u/CMEeUXvYN6KqjR7
 Dbuy3wVZLawT7f9lRZvWvjqEFd8gtWrp4OT6VRe8nhjuyLey4KUhCgMHliWus2gnYn
 6rWzjGMEA5X+azMujMSmFK6+2ZdPk+5aZeB9a7virROSGRsztGUPD/bK0+fFJ/2t2k
 hZqvoGM8FtFEYsZ116McYjUsG/pnPFQ4/xTpxrrgMiBwDhMe82de6tjgNR5I3+E04T
 FLkLEZbfUNtgkPpyRJW37c5yb1L1grdp1YVzQYSs8ewnQb3JjvrGDB/DontNl+6dHT
 GnqIS4N+4c7tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1725990610;
 bh=g9U/+M8BpKrhlYPtfur6st6R1S/cQc6zsYpV1Jr6WxY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=aMJVj/9fQuAUsPjannUIsPMTJyKXA8P83PfRyqVtSmAEn7kfiel+5YJ8Q8wlaf8tm
 uRch5zIGq34ha5Ymv6NKVP8OODNuVsr/qpMpm+EJUSavKUmEX+mh9OO79h4kx2e8R1
 sxRIXnTniXbOFSFVPMqwP0phYcMIoHqzlgwS8OJOksRHgCKxBd4Wbbkw/FHhPl5/Ko
 0879HPgTEIIGmca2dcEaVQHl9f/OnzYgAF4DaGgLPXFNy5ydi2kbEirPdSCc+8FezZ
 rSPDoRQN+lfaAgD/HZUF70mYts8XfbR8zA9JQQTp+v3DCJk37XSVRgR9I9unS0HOdm
 sapOT2VMkU0oQ==
From: Alexei Filippov <alexei.filippov@syntacore.com>
To: <palmer@dabbelt.com>
CC: <alexei.filippov@syntacore.com>, <alistair.francis@wdc.com>,
 <bmeng.cn@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <liwei1518@gmail.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
Subject: [RFC PATCH 2/2] hw/riscv/sifive_u.c: Add initial HPM support
Date: Tue, 10 Sep 2024 20:47:47 +0300
Message-ID: <20240910174747.148141-3-alexei.filippov@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910174747.148141-1-alexei.filippov@syntacore.com>
References: <20240910174747.148141-1-alexei.filippov@syntacore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=alexei.filippov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Add support of hardware performance monitor into sifive_u machine.
HPM support was made along to [SiFive FU740-C000 manual v1p6] sec. 3.8.
All described events for now counting by the same algorithm. Each event
counting could be implemented separately in read/write call backs, also
events combination are working, but right counting for them should be
implemented separatly.

Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
---
 hw/misc/meson.build            |   1 +
 hw/misc/sifive_u_pmu.c         | 384 +++++++++++++++++++++++++++++++++
 hw/riscv/sifive_u.c            |  14 ++
 include/hw/misc/sifive_u_pmu.h |  24 +++
 target/riscv/cpu.c             |  20 +-
 5 files changed, 442 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/sifive_u_pmu.c
 create mode 100644 include/hw/misc/sifive_u_pmu.h

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 2ca8717be2..ea93a38268 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -34,6 +34,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_aon.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
+specific_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u_pmu.c'))
 
 subdir('macio')
 
diff --git a/hw/misc/sifive_u_pmu.c b/hw/misc/sifive_u_pmu.c
new file mode 100644
index 0000000000..929a2517cc
--- /dev/null
+++ b/hw/misc/sifive_u_pmu.c
@@ -0,0 +1,384 @@
+/*
+ * RISC-V SiFive U PMU emulation.
+ *
+ * Copyright (c) 2024 Alexei Filippov <alexei.filippov@syntacore.com>.
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
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "target/riscv/cpu.h"
+#include "target/riscv/pmu.h"
+#include "include/hw/misc/sifive_u_pmu.h"
+#include "sysemu/cpu-timers.h"
+#include "sysemu/device_tree.h"
+
+REG32(SIFIVE_U_PMU_MHPMEVENT, 0x323)
+    FIELD(SIFIVE_U_PMU_MHPMEVENT, EVENT_CLASS, 0, 8)
+    FIELD(SIFIVE_U_PMU_MHPMEVENT, EVENT_MASK, 8, 18)
+
+    /*
+     * Support all PMU events  described in
+     * https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b16acba_fu740-c000-manual-v1p6.pdf
+     * FU740-C000 Manual sec. 3.8 "Hardware Performace Monitor", all
+     * events trigger irq by counter overflow, by default all caunters
+     * caunted identically, special behavior, combining events for example,
+     * must be described separately in write/read and trigger irq functions.
+     */
+
+#define SIFIVE_U_PMU_INST { \
+    X(RISCV_SIFIVE_U_EVENT_EXCEPTION_TAKEN,                   0x00001), \
+    X(RISCV_SIFIVE_U_EVENT_INTEGER_LOAD_RETIRED,              0x00002), \
+    X(RISCV_SIFIVE_U_EVENT_INTEGER_STORE_RETIRED,             0x00004), \
+    X(RISCV_SIFIVE_U_EVENT_ATOMIC_MEMORY_RETIRED,             0x00008), \
+    X(RISCV_SIFIVE_U_EVENT_SYSTEM_INSTRUCTION_RETIRED,        0x00010), \
+    X(RISCV_SIFIVE_U_EVENT_INTEGER_ARITHMETIC_RETIRED,        0x00020), \
+    X(RISCV_SIFIVE_U_EVENT_CONDITIONAL_BRANCH_RETIRED,        0x00040), \
+    X(RISCV_SIFIVE_U_EVENT_JAL_INSTRUCTION_RETIRED,           0x00080), \
+    X(RISCV_SIFIVE_U_EVENT_JALR_INSTRUCTION_RETIRED,          0x00100), \
+    X(RISCV_SIFIVE_U_EVENT_INTEGER_MULTIPLICATION_RETIRED,    0x00200), \
+    X(RISCV_SIFIVE_U_EVENT_INTEGER_DIVISION_RETIRED,          0x00400), \
+    X(RISCV_SIFIVE_U_EVENT_FP_LOAD_RETIRED,                   0x00800), \
+    X(RISCV_SIFIVE_U_EVENT_FP_STORE_RETIRED,                  0x01000), \
+    X(RISCV_SIFIVE_U_EVENT_FP_ADDITION_RETIRED,               0x02000), \
+    X(RISCV_SIFIVE_U_EVENT_FP_MULTIPLICATION_RETIRED,         0x04000), \
+    X(RISCV_SIFIVE_U_EVENT_FP_FUSEDMADD_RETIRED,              0x08000), \
+    X(RISCV_SIFIVE_U_EVENT_FP_DIV_SQRT_RETIRED,               0x10000), \
+    X(RISCV_SIFIVE_U_EVENT_OTHER_FP_RETIRED,                  0x20000), }
+
+#define SIFIVE_U_PMU_MICROARCH { \
+    X(RISCV_SIFIVE_U_EVENT_ADDRESSGEN_INTERLOCK,              0x00001), \
+    X(RISCV_SIFIVE_U_EVENT_LONGLAT_INTERLOCK,                 0x00002), \
+    X(RISCV_SIFIVE_U_EVENT_CSR_READ_INTERLOCK,                0x00004), \
+    X(RISCV_SIFIVE_U_EVENT_ICACHE_ITIM_BUSY,                  0x00008), \
+    X(RISCV_SIFIVE_U_EVENT_DCACHE_DTIM_BUSY,                  0x00010), \
+    X(RISCV_SIFIVE_U_EVENT_BRANCH_DIRECTION_MISPREDICTION,    0x00020), \
+    X(RISCV_SIFIVE_U_EVENT_BRANCH_TARGET_MISPREDICTION,       0x00040), \
+    X(RISCV_SIFIVE_U_EVENT_PIPE_FLUSH_CSR_WRITE,              0x00080), \
+    X(RISCV_SIFIVE_U_EVENT_PIPE_FLUSH_OTHER_EVENT,            0x00100), \
+    X(RISCV_SIFIVE_U_EVENT_INTEGER_MULTIPLICATION_INTERLOCK,  0x00200), \
+    X(RISCV_SIFIVE_U_EVENT_FP_INTERLOCK,                      0x00400), }
+
+#define SIFIVE_U_PMU_MEM { \
+    X(RISCV_SIFIVE_U_EVENT_ICACHE_RETIRED,                    0x00001), \
+    X(RISCV_SIFIVE_U_EVENT_DCACHE_MISS_MMIO_ACCESSES,         0x00002), \
+    X(RISCV_SIFIVE_U_EVENT_DCACHE_WRITEBACK,                  0x00004), \
+    X(RISCV_SIFIVE_U_EVENT_INST_TLB_MISS,                     0x00008), \
+    X(RISCV_SIFIVE_U_EVENT_DATA_TLB_MISS,                     0x00010), \
+    X(RISCV_SIFIVE_U_EVENT_UTLB_MISS,                         0x00020), }
+
+#define X(a, b) a = b
+    enum SIFIVE_U_PMU_INST;
+    enum SIFIVE_U_PMU_MEM;
+    enum SIFIVE_U_PMU_MICROARCH;
+#undef X
+
+#define X(a, b) a
+    const uint32_t
+    riscv_sifive_u_pmu_events[RISCV_SIFIVE_U_CLASS_MAX][RISCV_SIFIVE_U_MASK_MAX] = {
+    SIFIVE_U_PMU_INST,
+    SIFIVE_U_PMU_MICROARCH,
+    SIFIVE_U_PMU_MEM,
+    };
+#undef X
+
+void sifive_u_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name)
+{
+    uint32_t fdt_event_mhpmevent_map[10 * 3] = {};
+    uint32_t fdt_event_mhpmctr_map[6 * 4] = {};
+    uint32_t event_idx;
+
+    /*
+     * SBI_PMU_HW_CACHE_REFERENCES: 0x3 -> Instruction cache/ITIM busy |
+     *                                     Data cache/DTIM busy
+     * result: < 0x3 0x0 1801 >
+     */
+    fdt_event_mhpmevent_map[0]  = cpu_to_be32(0x3);
+    fdt_event_mhpmevent_map[1]  = cpu_to_be32(0x0);
+    event_idx = FIELD_DP32(0, SIFIVE_U_PMU_MHPMEVENT, EVENT_MASK,
+                           RISCV_SIFIVE_U_EVENT_ICACHE_ITIM_BUSY |
+                           RISCV_SIFIVE_U_EVENT_DCACHE_DTIM_BUSY);
+    event_idx = FIELD_DP32(event_idx, SIFIVE_U_PMU_MHPMEVENT, EVENT_CLASS,
+                           RISCV_SIFIVE_U_CLASS_MICROARCH);
+    fdt_event_mhpmevent_map[2]  = cpu_to_be32(event_idx);
+
+
+    /*
+     * SBI_PMU_HW_CACHE_MISSES: 0x4 -> Instruction cache miss |
+     *                                 Data cache miss or mem-mapped I/O access
+     * result: < 0x4 0x0 0x302 >
+     */
+    fdt_event_mhpmevent_map[3]  = cpu_to_be32(0x4);
+    fdt_event_mhpmevent_map[4]  = cpu_to_be32(0x0);
+    event_idx = FIELD_DP32(0, SIFIVE_U_PMU_MHPMEVENT, EVENT_MASK,
+                           RISCV_SIFIVE_U_EVENT_ICACHE_RETIRED |
+                           RISCV_SIFIVE_U_EVENT_DCACHE_MISS_MMIO_ACCESSES);
+    event_idx = FIELD_DP32(event_idx, SIFIVE_U_PMU_MHPMEVENT, EVENT_CLASS,
+                           RISCV_SIFIVE_U_CLASS_MEM);
+    fdt_event_mhpmevent_map[5]  = cpu_to_be32(event_idx);
+
+    /*
+     * SBI_PMU_HW_BRANCH_INSTRUCTIONS: 0x5 -> Conditional branch retired
+     * result: < 0x5 0x0 0x4000 >
+     */
+    fdt_event_mhpmevent_map[6]  = cpu_to_be32(0x5);
+    fdt_event_mhpmevent_map[7]  = cpu_to_be32(0x0);
+    event_idx = FIELD_DP32(0, SIFIVE_U_PMU_MHPMEVENT, EVENT_MASK,
+                           RISCV_SIFIVE_U_EVENT_CONDITIONAL_BRANCH_RETIRED);
+    event_idx = FIELD_DP32(event_idx, SIFIVE_U_PMU_MHPMEVENT, EVENT_CLASS,
+                           RISCV_SIFIVE_U_CLASS_INST);
+    fdt_event_mhpmevent_map[8]  = cpu_to_be32(event_idx);
+
+    /*
+     * SBI_PMU_HW_BRANCH_MISSES: 0x6 -> Branch direction misprediction |
+     *                                  Branch/jump target misprediction
+     * result: < 0x6 0x0 0x6001 >
+     */
+    fdt_event_mhpmevent_map[9]  = cpu_to_be32(0x6);
+    fdt_event_mhpmevent_map[10] = cpu_to_be32(0x0);
+    event_idx = FIELD_DP32(0, SIFIVE_U_PMU_MHPMEVENT, EVENT_MASK,
+                           RISCV_SIFIVE_U_EVENT_BRANCH_DIRECTION_MISPREDICTION |
+                           RISCV_SIFIVE_U_EVENT_BRANCH_TARGET_MISPREDICTION);
+    event_idx = FIELD_DP32(event_idx, SIFIVE_U_PMU_MHPMEVENT, EVENT_CLASS,
+                           RISCV_SIFIVE_U_CLASS_MICROARCH);
+    fdt_event_mhpmevent_map[11] = cpu_to_be32(event_idx);
+
+    /*
+     * L1D_READ_MISS: 0x10001 -> Data cache miss or memory-mapped I/O access
+     * result: < 0x10001 0x0 0x202 >
+     */
+    fdt_event_mhpmevent_map[12]  = cpu_to_be32(0x10001);
+    fdt_event_mhpmevent_map[13] = cpu_to_be32(0x0);
+    event_idx = FIELD_DP32(0, SIFIVE_U_PMU_MHPMEVENT, EVENT_MASK,
+                           RISCV_SIFIVE_U_EVENT_DCACHE_MISS_MMIO_ACCESSES);
+    event_idx = FIELD_DP32(event_idx, SIFIVE_U_PMU_MHPMEVENT, EVENT_CLASS,
+                           RISCV_SIFIVE_U_CLASS_MEM);
+    fdt_event_mhpmevent_map[14] = cpu_to_be32(event_idx);
+
+    /*
+     * L1D_WRITE_ACCESS: 0x10002 -> Data cache write back
+     * result: < 0x10002 0x0 0x402 >
+     */
+    fdt_event_mhpmevent_map[15]  = cpu_to_be32(0x10002);
+    fdt_event_mhpmevent_map[16] = cpu_to_be32(0x0);
+    event_idx = FIELD_DP32(0, SIFIVE_U_PMU_MHPMEVENT, EVENT_MASK,
+                           RISCV_SIFIVE_U_EVENT_DCACHE_WRITEBACK);
+    event_idx = FIELD_DP32(event_idx, SIFIVE_U_PMU_MHPMEVENT, EVENT_CLASS,
+                           RISCV_SIFIVE_U_CLASS_MEM);
+    fdt_event_mhpmevent_map[17] = cpu_to_be32(event_idx);
+
+    /*
+     * L1I_READ_ACCESS: 0x10009 -> Instruction cache miss
+     * result: < 0x10009 0x0 0x102 >
+     */
+    fdt_event_mhpmevent_map[18]  = cpu_to_be32(0x10009);
+    fdt_event_mhpmevent_map[19] = cpu_to_be32(0x0);
+    event_idx = FIELD_DP32(0, SIFIVE_U_PMU_MHPMEVENT, EVENT_MASK,
+                           RISCV_SIFIVE_U_EVENT_ICACHE_RETIRED);
+    event_idx = FIELD_DP32(event_idx, SIFIVE_U_PMU_MHPMEVENT, EVENT_CLASS,
+                           RISCV_SIFIVE_U_CLASS_MEM);
+    fdt_event_mhpmevent_map[20] = cpu_to_be32(event_idx);
+
+    /*
+     * LL_READ_MISS: 0x10011 -> UTLB miss
+     * result: < 0x10011 0x0 0x2002 >
+     */
+    fdt_event_mhpmevent_map[21]  = cpu_to_be32(0x10011);
+    fdt_event_mhpmevent_map[22] = cpu_to_be32(0x0);
+    event_idx = FIELD_DP32(0, SIFIVE_U_PMU_MHPMEVENT, EVENT_MASK,
+                           RISCV_SIFIVE_U_EVENT_UTLB_MISS);
+    event_idx = FIELD_DP32(event_idx, SIFIVE_U_PMU_MHPMEVENT, EVENT_CLASS,
+                           RISCV_SIFIVE_U_CLASS_MEM);
+    fdt_event_mhpmevent_map[23] = cpu_to_be32(event_idx);
+
+    /*
+     * DTLB_READ_MISS: 0x10019 -> Data TLB miss
+     * result: < 0x10019 0x0 0x1002 >
+     */
+    fdt_event_mhpmevent_map[24]  = cpu_to_be32(0x10019);
+    fdt_event_mhpmevent_map[25] = cpu_to_be32(0x0);
+    event_idx = FIELD_DP32(0, SIFIVE_U_PMU_MHPMEVENT, EVENT_MASK,
+                           RISCV_SIFIVE_U_EVENT_DATA_TLB_MISS);
+    event_idx = FIELD_DP32(event_idx, SIFIVE_U_PMU_MHPMEVENT, EVENT_CLASS,
+                           RISCV_SIFIVE_U_CLASS_MEM);
+    fdt_event_mhpmevent_map[26] = cpu_to_be32(event_idx);
+
+    /*
+     * DTLB_READ_MISS: 0x10021 -> Data TLB miss
+     * result: < 0x10019 0x0 0x802 >
+     */
+    fdt_event_mhpmevent_map[27]  = cpu_to_be32(0x10021);
+    fdt_event_mhpmevent_map[28] = cpu_to_be32(0x0);
+    event_idx = FIELD_DP32(0, SIFIVE_U_PMU_MHPMEVENT, EVENT_MASK,
+                           RISCV_SIFIVE_U_EVENT_INST_TLB_MISS);
+    event_idx = FIELD_DP32(event_idx, SIFIVE_U_PMU_MHPMEVENT, EVENT_CLASS,
+                           RISCV_SIFIVE_U_CLASS_MEM);
+    fdt_event_mhpmevent_map[29] = cpu_to_be32(event_idx);
+
+    fdt_event_mhpmctr_map[0] = cpu_to_be32(0x00003);
+    fdt_event_mhpmctr_map[1] = cpu_to_be32(0x00006);
+    fdt_event_mhpmctr_map[2] = cpu_to_be32(cmask);
+
+    fdt_event_mhpmctr_map[3] = cpu_to_be32(0x10001);
+    fdt_event_mhpmctr_map[4] = cpu_to_be32(0x10002);
+    fdt_event_mhpmctr_map[5] = cpu_to_be32(cmask);
+
+    fdt_event_mhpmctr_map[6] = cpu_to_be32(0x10009);
+    fdt_event_mhpmctr_map[7] = cpu_to_be32(0x10009);
+    fdt_event_mhpmctr_map[8] = cpu_to_be32(cmask);
+
+    fdt_event_mhpmctr_map[9] = cpu_to_be32(0x10011);
+    fdt_event_mhpmctr_map[10] = cpu_to_be32(0x10011);
+    fdt_event_mhpmctr_map[11] = cpu_to_be32(cmask);
+
+    fdt_event_mhpmctr_map[12] = cpu_to_be32(0x10019);
+    fdt_event_mhpmctr_map[13] = cpu_to_be32(0x10019);
+    fdt_event_mhpmctr_map[14] = cpu_to_be32(cmask);
+
+    fdt_event_mhpmctr_map[15] = cpu_to_be32(0x10021);
+    fdt_event_mhpmctr_map[16] = cpu_to_be32(0x10021);
+    fdt_event_mhpmctr_map[17] = cpu_to_be32(cmask);
+
+    fdt_event_mhpmctr_map[18] = cpu_to_be32(0x1);
+    fdt_event_mhpmctr_map[19] = cpu_to_be32(0x1);
+    fdt_event_mhpmctr_map[20] = cpu_to_be32(cmask | 1 << 0);
+
+    fdt_event_mhpmctr_map[21] = cpu_to_be32(0x2);
+    fdt_event_mhpmctr_map[22] = cpu_to_be32(0x2);
+    fdt_event_mhpmctr_map[23] = cpu_to_be32(cmask | 1 << 2);
+
+   /* This a OpenSBI specific DT property documented in OpenSBI docs */
+    qemu_fdt_setprop(fdt, pmu_name, "riscv,event-to-mhpmevent",
+                     fdt_event_mhpmevent_map, sizeof(fdt_event_mhpmevent_map));
+    qemu_fdt_setprop(fdt, pmu_name, "riscv,event-to-mhpmcounters",
+                     fdt_event_mhpmctr_map, sizeof(fdt_event_mhpmctr_map));
+
+}
+
+bool riscv_sifive_u_supported_events(uint32_t event_idx)
+{
+    uint32_t group = FIELD_EX32(event_idx, SIFIVE_U_PMU_MHPMEVENT, EVENT_CLASS);
+    uint32_t event_mask = FIELD_EX32(event_idx, SIFIVE_U_PMU_MHPMEVENT,
+                                     EVENT_MASK);
+    uint32_t idx = 32 - clz32(event_mask);
+
+    if (group >= RISCV_SIFIVE_U_CLASS_MAX || idx > RISCV_SIFIVE_U_MASK_MAX) {
+        return 0;
+    }
+
+    bool event_match = true;
+    if (!idx) {
+        event_match = false;
+    }
+    while (event_match && idx) {
+        if (!riscv_sifive_u_pmu_events[group][idx - 1]) {
+            event_match = false;
+        }
+        event_mask = event_mask & (~(1 << (idx - 1)));
+        idx = 32 - clz32(event_mask);
+    }
+    return event_match;
+}
+
+static target_ulong get_ticks(bool icnt, bool high_half)
+{
+    int64_t val;
+    target_ulong res;
+
+    if (icnt && icount_enabled()) {
+        val = icount_get_raw();
+    } else {
+        val = cpu_get_host_ticks();
+    }
+
+    if (high_half) {
+        res = val >> 32;
+    } else {
+        res = val;
+    }
+
+    return res;
+}
+
+target_ulong riscv_sifive_u_pmu_ctr_read(PMUCTRState *counter,
+                                         uint32_t event_idx, bool high_half)
+{
+    target_ulong ctrl_val = high_half ? counter->mhpmcounterh_val :
+                                        counter->mhpmcounter_val;
+    uint32_t event_class_field = FIELD_EX32(event_idx,
+                                                SIFIVE_U_PMU_MHPMEVENT,
+                                                EVENT_CLASS);
+    uint32_t event_mask_field = FIELD_EX32(event_idx,
+                                               SIFIVE_U_PMU_MHPMEVENT,
+                                               EVENT_MASK);
+
+    if (event_class_field >= RISCV_SIFIVE_U_CLASS_MAX ||
+        (32 - clz32(event_mask_field)) >= RISCV_SIFIVE_U_MASK_MAX) {
+        return ctrl_val;
+    }
+
+    switch (event_class_field) {
+    /* If we want to handle some events separately */
+
+    /* fall through */
+    default:
+    /* In case we do not want handle it separately */
+        if (riscv_sifive_u_supported_events(event_idx)) {
+                return get_ticks(false, high_half);
+        }
+    /* Did not find event in supported */
+        return ctrl_val;
+    }
+
+    g_assert_not_reached(); /* unreachable */
+    return 0;
+}
+
+void riscv_sifive_u_pmu_ctr_write(PMUCTRState *counter, uint32_t event_idx,
+                             target_ulong val, bool high_half)
+{
+    target_ulong *ctr_prev = high_half ? &counter->mhpmcounterh_prev :
+                                         &counter->mhpmcounter_prev;
+    uint32_t event_class_field = FIELD_EX32(event_idx,
+                                                SIFIVE_U_PMU_MHPMEVENT,
+                                                EVENT_CLASS);
+    uint32_t event_mask_field = FIELD_EX32(event_idx,
+                                               SIFIVE_U_PMU_MHPMEVENT,
+                                               EVENT_MASK);
+
+    if (event_class_field >= RISCV_SIFIVE_U_CLASS_MAX ||
+        (32 - clz32(event_mask_field)) >= RISCV_SIFIVE_U_MASK_MAX) {
+        *ctr_prev = val;
+        return;
+    }
+
+    switch (event_class_field) {
+    /* If we want to handle some events separately */
+
+    /* fall through */
+    default:
+    /* In case we do not want handle it separately */
+        if (riscv_sifive_u_supported_events(event_idx)) {
+            *ctr_prev = get_ticks(false, high_half);
+            return;
+        }
+    /* Did not find event in supported */
+        *ctr_prev = val;
+        return;
+    }
+
+    g_assert_not_reached(); /* unreachable */
+    return;
+}
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index af5f923f54..2771102fbe 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -60,6 +60,7 @@
 #include "sysemu/device_tree.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
+#include "include/hw/misc/sifive_u_pmu.h"
 
 #include <libfdt.h>
 
@@ -93,6 +94,17 @@ static const MemMapEntry sifive_u_memmap[] = {
 #define OTP_SERIAL          1
 #define GEM_REVISION        0x10070109
 
+static void create_fdt_pmu(MachineState *s)
+{
+    g_autofree char *pmu_name = g_strdup_printf("/pmu");
+    MachineState *ms = MACHINE(s);
+    RISCVCPU *hart = RISCV_CPU(qemu_get_cpu(0));
+
+    qemu_fdt_add_subnode(ms->fdt, pmu_name);
+    qemu_fdt_setprop_string(ms->fdt, pmu_name, "compatible", "riscv,pmu");
+    sifive_u_pmu_generate_fdt_node(ms->fdt, hart->pmu_avail_ctrs, pmu_name);
+}
+
 static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
                        bool is_32_bit)
 {
@@ -499,6 +511,8 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
     qemu_fdt_setprop_string(fdt, "/aliases", "serial0", nodename);
 
     g_free(nodename);
+
+    create_fdt_pmu(ms);
 }
 
 static void sifive_u_machine_reset(void *opaque, int n, int level)
diff --git a/include/hw/misc/sifive_u_pmu.h b/include/hw/misc/sifive_u_pmu.h
new file mode 100644
index 0000000000..8877c2ba46
--- /dev/null
+++ b/include/hw/misc/sifive_u_pmu.h
@@ -0,0 +1,24 @@
+#ifndef RISCV_SIFIVE_U_PMU_H
+#define RISCV_SIFIVE_U_PMU_H
+
+#include "target/riscv/cpu.h"
+#include "qapi/error.h"
+
+/* Maximum events per class */
+#define RISCV_SIFIVE_U_MASK_MAX 18
+
+enum riscv_sifive_u_pmu_classes {
+    RISCV_SIFIVE_U_CLASS_INST = 0x0,
+    RISCV_SIFIVE_U_CLASS_MICROARCH,
+    RISCV_SIFIVE_U_CLASS_MEM,
+    RISCV_SIFIVE_U_CLASS_MAX  = 0x3
+};
+
+bool riscv_sifive_u_supported_events(uint32_t event_idx);
+void riscv_sifive_u_pmu_ctr_write(PMUCTRState *counter, uint32_t event_idx,
+                                    target_ulong val, bool high_half);
+target_ulong riscv_sifive_u_pmu_ctr_read(PMUCTRState *counter,
+                                           uint32_t event_idx, bool high_half);
+void sifive_u_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
+
+#endif /* RISCV_SCR_PMU_H */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a90808a3ba..2ae43c7658 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -38,6 +38,7 @@
 #include "kvm/kvm_riscv.h"
 #include "tcg/tcg-cpu.h"
 #include "tcg/tcg.h"
+#include "include/hw/misc/sifive_u_pmu.h"
 
 /* RISC-V CPU definitions */
 static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
@@ -477,6 +478,15 @@ static void riscv_max_cpu_init(Object *obj)
 #endif
 }
 
+#ifndef CONFIG_USER_ONLY
+static void riscv_sifive_u_hart_reg_pmu_cb(CPURISCVState *env)
+{
+    env->pmu_vendor_support = riscv_sifive_u_supported_events;
+    env->pmu_ctr_write = riscv_sifive_u_pmu_ctr_write;
+    env->pmu_ctr_read = riscv_sifive_u_pmu_ctr_read;
+}
+#endif
+
 #if defined(TARGET_RISCV64)
 static void rv64_base_cpu_init(Object *obj)
 {
@@ -498,9 +508,12 @@ static void rv64_sifive_u_cpu_init(Object *obj)
     RISCVCPU *cpu = RISCV_CPU(obj);
     CPURISCVState *env = &cpu->env;
     riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
-    env->priv_ver = PRIV_VERSION_1_10_0;
+    env->priv_ver = PRIV_VERSION_1_12_0;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV39);
+    if (!kvm_enabled()) {
+        riscv_sifive_u_hart_reg_pmu_cb(env);
+    }
 #endif
 
     /* inherited from parent obj via riscv_cpu_init() */
@@ -508,6 +521,8 @@ static void rv64_sifive_u_cpu_init(Object *obj)
     cpu->cfg.ext_zicsr = true;
     cpu->cfg.mmu = true;
     cpu->cfg.pmp = true;
+    cpu->cfg.ext_sscofpmf = true;
+    cpu->cfg.pmu_mask = MAKE_64BIT_MASK(3, 2);
 }
 
 static void rv64_sifive_e_cpu_init(Object *obj)
@@ -660,6 +675,9 @@ static void rv32_sifive_u_cpu_init(Object *obj)
     env->priv_ver = PRIV_VERSION_1_10_0;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV32);
+    if (!kvm_enabled()) {
+        riscv_sifive_u_hart_reg_pmu_cb(env);
+    }
 #endif
 
     /* inherited from parent obj via riscv_cpu_init() */
-- 
2.34.1


