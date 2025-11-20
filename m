Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67ED0CF649C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 01:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLt4w-0000Ec-Ui; Wed, 19 Nov 2025 20:03:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vLskk-0004HM-Ga; Wed, 19 Nov 2025 19:42:26 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vLskg-0002SD-O8; Wed, 19 Nov 2025 19:42:26 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 48A426018A;
 Thu, 20 Nov 2025 00:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C08C116B1;
 Thu, 20 Nov 2025 00:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763599340;
 bh=a/phMJ06w7kbWtNJfyhR90v4Vd1lS2+7UQMlmxQexF0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=N/O5Bb982nqGMmg6t03N/r7B2dhxnTI/aTUSd2giDWRHDI1vp2c0TDcoDv4B7nKEE
 jerJFO5/qUp6cY5XHff0nlXA/enzlIj9+kyH3PJLVce3fjmX4BTxWMQaFI+Su1gb6J
 EovBOxjgQyFpfR3i0vU8HwmwPCNQ9mM7CBoYIW0OiR7rSROE3eTp390iD6fC6TBNhF
 8RDJOdn8t82Lxyn5t4w7i7mkysB/g3HKjSB74G4mubcmt57kMU0n+ozkD4eDAR1vfP
 tm3MCHA1McWafyfHs9XLXXPKBhdE5ckftc27sqXVCUtdqy4A4jKMgHrzEN2w1YCjIl
 //Iy5y8PVjduw==
From: Drew Fustini <fustini@kernel.org>
Date: Wed, 19 Nov 2025 16:42:20 -0800
Subject: [PATCH 4/7] hw/riscv: implement CBQRI bandwidth controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-riscv-ssqosid-cbqri-v1-4-3392fc760e48@kernel.org>
References: <20251119-riscv-ssqosid-cbqri-v1-0-3392fc760e48@kernel.org>
In-Reply-To: <20251119-riscv-ssqosid-cbqri-v1-0-3392fc760e48@kernel.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Kumar Patra <atishp@rivosinc.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
 Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=172.105.4.254; envelope-from=fustini@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Nov 2025 20:03:17 -0500
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

From: Nicolas Pitre <npitre@baylibre.com>

Implement a bandwidth controller according to the Capacity and Bandwidth
QoS Register Interface (CBQRI) which supports these capabilities:

  - Number of access types: 2 (code and data)
  - Usage monitoring operations: CONFIG_EVENT, READ_COUNTER
  - Event IDs supported: None, Total read/write byte count, Total
                         read byte count, Total write byte count
  - Bandwidth allocation operations: CONFIG_LIMIT, READ_LIMIT

Link: https://github.com/riscv-non-isa/riscv-cbqri/blob/main/riscv-cbqri.pdf
Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
[fustini: add fields introduced in the ratified spec: rpfx and p]
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 MAINTAINERS                |   1 +
 hw/riscv/cbqri_bandwidth.c | 613 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 614 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 48cca4ac8702..16500c4e8a83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -362,6 +362,7 @@ M: Nicolas Pitre <npitre@baylibre.com>
 M: Drew Fustini <fustini@kernel.org>
 L: qemu-riscv@nongnu.org
 S: Supported
+F: hw/riscv/cbqri_bandwidth.c
 F: hw/riscv/cbqri_capacity.c
 F: include/hw/riscv/cbqri.h
 
diff --git a/hw/riscv/cbqri_bandwidth.c b/hw/riscv/cbqri_bandwidth.c
new file mode 100644
index 000000000000..40357a3219d8
--- /dev/null
+++ b/hw/riscv/cbqri_bandwidth.c
@@ -0,0 +1,613 @@
+/*
+ * RISC-V Capacity and Bandwidth QoS Register Interface
+ * URL: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
+ *
+ * Copyright (c) 2023 BayLibre SAS
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This file contains the Bandwidth-controller QoS Register Interface.
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
+#include "hw/qdev-properties.h"
+#include "hw/sysbus.h"
+#include "target/riscv/cpu.h"
+#include "hw/riscv/cbqri.h"
+
+/* Encodings of `AT` field */
+enum {
+    BC_AT_DATA = 0,
+    BC_AT_CODE = 1,
+};
+
+/* Capabilities */
+REG64(BC_CAPABILITIES, 0);
+FIELD(BC_CAPABILITIES, VER, 0, 8);
+FIELD(BC_CAPABILITIES, VER_MINOR, 0, 4);
+FIELD(BC_CAPABILITIES, VER_MAJOR, 4, 4);
+FIELD(BC_CAPABILITIES, NBWBLKS, 8, 16);
+FIELD(BC_CAPABILITIES, RPFX, 24, 1);
+FIELD(BC_CAPABILITIES, P, 25, 4);
+FIELD(BC_CAPABILITIES, MRBWB, 32, 16);
+
+/* Usage monitoring control */
+REG64(BC_MON_CTL, 8);
+FIELD(BC_MON_CTL, OP, 0, 5);
+FIELD(BC_MON_CTL, AT, 5, 3);
+FIELD(BC_MON_CTL, MCID, 8, 12);
+FIELD(BC_MON_CTL, EVT_ID, 20, 8);
+FIELD(BC_MON_CTL, ATV, 28, 1);
+FIELD(BC_MON_CTL, STATUS, 32, 7);
+FIELD(BC_MON_CTL, BUSY, 39, 1);
+
+/* Usage monitoring operations */
+enum {
+    BC_MON_OP_CONFIG_EVENT = 1,
+    BC_MON_OP_READ_COUNTER = 2,
+};
+
+/* Bandwidth monitoring event ID */
+enum {
+    BC_EVT_ID_None = 0,
+    BC_EVT_ID_RDWR_count = 1,
+    BC_EVT_ID_RDONLY_count = 2,
+    BC_EVT_ID_WRONLY_count = 3,
+};
+
+/* BC_MON_CTL.STATUS field encodings */
+enum {
+    BC_MON_CTL_STATUS_SUCCESS = 1,
+    BC_MON_CTL_STATUS_INVAL_OP = 2,
+    BC_MON_CTL_STATUS_INVAL_MCID = 3,
+    BC_MON_CTL_STATUS_INVAL_EVT_ID = 4,
+    BC_MON_CTL_STATUS_INVAL_AT = 5,
+};
+
+/* Monitoring counter value */
+REG64(BC_MON_CTR_VAL, 16);
+FIELD(BC_MON_CTR_VAL, CTR, 0, 62);
+FIELD(BC_MON_CTR_VAL, INVALID, 62, 1);
+FIELD(BC_MON_CTR_VAL, OVF, 63, 1);
+
+/* Bandwidth Allocation control */
+REG64(BC_ALLOC_CTL, 24);
+FIELD(BC_ALLOC_CTL, OP, 0, 5);
+FIELD(BC_ALLOC_CTL, AT, 5, 3);
+FIELD(BC_ALLOC_CTL, RCID, 8, 12);
+FIELD(BC_ALLOC_CTL, STATUS, 32, 7);
+FIELD(BC_ALLOC_CTL, BUSY, 39, 1);
+
+/* Bandwidth allocation operations */
+enum {
+    BC_ALLOC_OP_CONFIG_LIMIT = 1,
+    BC_ALLOC_OP_READ_LIMIT = 2,
+};
+
+/* BC_ALLOC_CTL.STATUS field encodings */
+enum {
+    BC_ALLOC_STATUS_SUCCESS = 1,
+    BC_ALLOC_STATUS_INVAL_OP = 2,
+    BC_ALLOC_STATUS_INVAL_RCID = 3,
+    BC_ALLOC_STATUS_INVAL_AT = 4,
+    BC_ALLOC_STATUS_INVAL_BLKS = 5,
+};
+
+/* Bandwidth allocation */
+REG64(BC_BW_ALLOC, 32);
+FIELD(BC_BW_ALLOC, Rbwb, 0, 16);
+FIELD(BC_BW_ALLOC, Mweight, 20, 8);
+FIELD(BC_BW_ALLOC, sharedAT, 28, 3);
+FIELD(BC_BW_ALLOC, useShared, 31, 1);
+
+
+typedef struct MonitorCounter {
+    uint64_t ctr_val;
+    int at;
+    int evt_id;
+    bool active;
+} MonitorCounter;
+
+typedef struct BandwidthAllocation {
+    uint32_t Rbwb:16;
+    uint32_t Mweight:8;
+    uint32_t sharedAT:3;
+    bool useShared:1;
+} BandwidthAllocation;
+
+typedef struct RiscvCbqriBandwidthState {
+    SysBusDevice parent_obj;
+    MemoryRegion mmio;
+
+    /* cached value of some registers */
+    uint64_t bc_mon_ctl;
+    uint64_t bc_mon_ctr_val;
+    uint64_t bc_alloc_ctl;
+    uint64_t bc_bw_alloc;
+
+    MonitorCounter *mon_counters;
+    BandwidthAllocation *bw_allocations;
+
+    /* properties */
+
+    uint64_t mmio_base;
+    char *target;
+    uint16_t nb_mcids;
+    uint16_t nb_rcids;
+
+    uint16_t nbwblks;
+    uint16_t mrbwb;
+
+    bool rpfx;
+    uint8_t p;
+
+    bool supports_at_data;
+    bool supports_at_code;
+
+    bool supports_alloc_op_config_limit;
+    bool supports_alloc_op_read_limit;
+
+    bool supports_mon_op_config_event;
+    bool supports_mon_op_read_counter;
+
+    bool supports_mon_evt_id_none;
+    bool supports_mon_evt_id_rdwr_count;
+    bool supports_mon_evt_id_rdonly_count;
+    bool supports_mon_evt_id_wronly_count;
+} RiscvCbqriBandwidthState;
+
+#define RISCV_CBQRI_BC(obj) \
+    OBJECT_CHECK(RiscvCbqriBandwidthState, (obj), TYPE_RISCV_CBQRI_BC)
+
+static BandwidthAllocation *get_bw_alloc(RiscvCbqriBandwidthState *bc,
+                                         uint32_t rcid, uint32_t at)
+{
+    /*
+     * All bandwidth allocation records are contiguous to simplify
+     * allocation. The first one is used to hold the BC_BW_ALLOC register
+     * content, followed by respective records for each AT per RCID.
+     */
+
+    unsigned int nb_ats = 0;
+    nb_ats += !!bc->supports_at_data;
+    nb_ats += !!bc->supports_at_code;
+    nb_ats = MAX(nb_ats, 1);
+    assert(at < nb_ats);
+
+    return &bc->bw_allocations[1 + rcid * nb_ats + at];
+}
+
+static uint32_t bandwidth_config(RiscvCbqriBandwidthState *bc,
+                                 uint32_t rcid, uint32_t at,
+                                 bool *busy)
+{
+    BandwidthAllocation *bw_alloc = get_bw_alloc(bc, rcid, at);
+
+    /* for now we only preserve the current BC_BW_ALLOC register content */
+    *bw_alloc = bc->bw_allocations[0];
+    return BC_ALLOC_STATUS_SUCCESS;
+}
+
+static uint32_t bandwidth_read(RiscvCbqriBandwidthState *bc,
+                               uint32_t rcid, uint32_t at,
+                               bool *busy)
+{
+    BandwidthAllocation *bw_alloc = get_bw_alloc(bc, rcid, at);
+
+    /* populate BC_BW_ALLOC register with selected content */
+    bc->bw_allocations[0] = *bw_alloc;
+    return BC_ALLOC_STATUS_SUCCESS;
+}
+
+static bool is_valid_at(RiscvCbqriBandwidthState *bc, uint32_t at)
+{
+    switch (at) {
+    case BC_AT_DATA:
+        return bc->supports_at_data;
+    case BC_AT_CODE:
+        return bc->supports_at_code;
+    default:
+        return false;
+    }
+}
+
+static void riscv_cbqri_bc_write_mon_ctl(RiscvCbqriBandwidthState *bc,
+                                         uint64_t value)
+{
+    if (!bc->supports_mon_op_config_event &&
+        !bc->supports_mon_op_read_counter) {
+        /* monitoring not supported: leave mon_ctl set to 0 */
+        return;
+    }
+
+    /* extract writable fields */
+    uint32_t op = FIELD_EX64(value, BC_MON_CTL, OP);
+    uint32_t at = FIELD_EX64(value, BC_MON_CTL, AT);
+    uint32_t mcid = FIELD_EX64(value, BC_MON_CTL, MCID);
+    uint32_t evt_id = FIELD_EX64(value, BC_MON_CTL, EVT_ID);
+    bool atv = FIELD_EX64(value, BC_MON_CTL, ATV);
+
+    /* extract read-only fields */
+    uint32_t status = FIELD_EX64(bc->bc_mon_ctl, BC_MON_CTL, STATUS);
+    bool busy = FIELD_EX64(bc->bc_mon_ctl, BC_MON_CTL, BUSY);
+
+    if (busy) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: busy flag still set, ignored",
+                      __func__);
+        return;
+    }
+
+    if (!bc->supports_at_data &&
+        !bc->supports_at_code) {
+        /* AT not supported: hardwire to 0 */
+        at = 0;
+        atv = false;
+    }
+
+    if (mcid >= bc->nb_mcids) {
+        status = BC_MON_CTL_STATUS_INVAL_MCID;
+    } else if (op == BC_MON_OP_CONFIG_EVENT &&
+               bc->supports_mon_op_config_event) {
+        if (evt_id == BC_EVT_ID_None &&
+            bc->supports_mon_evt_id_none) {
+            bc->mon_counters[mcid].active = false;
+            status = BC_MON_CTL_STATUS_SUCCESS;
+        } else if ((evt_id == BC_EVT_ID_RDWR_count &&
+                    bc->supports_mon_evt_id_rdwr_count) ||
+                   (evt_id == BC_EVT_ID_RDONLY_count &&
+                    bc->supports_mon_evt_id_rdonly_count) ||
+                   (evt_id == BC_EVT_ID_WRONLY_count &&
+                    bc->supports_mon_evt_id_wronly_count)) {
+            if (atv && !is_valid_at(bc, at)) {
+                status = BC_MON_CTL_STATUS_INVAL_AT;
+            } else {
+                bc->mon_counters[mcid].ctr_val =
+                    FIELD_DP64(0, BC_MON_CTR_VAL, INVALID, 1);
+                bc->mon_counters[mcid].evt_id = evt_id;
+                bc->mon_counters[mcid].at = atv ? at : -1;
+                bc->mon_counters[mcid].active = true;
+                status = BC_MON_CTL_STATUS_SUCCESS;
+            }
+        } else {
+            status = BC_MON_CTL_STATUS_INVAL_EVT_ID;
+        }
+    } else if (op == BC_MON_OP_READ_COUNTER &&
+               bc->supports_mon_op_read_counter) {
+        bc->bc_mon_ctr_val = bc->mon_counters[mcid].ctr_val;
+        status = BC_MON_CTL_STATUS_SUCCESS;
+    } else {
+        status = BC_MON_CTL_STATUS_INVAL_OP;
+    }
+
+    /* reconstruct updated register value */
+    value = 0;
+    value = FIELD_DP64(value, BC_MON_CTL, OP, op);
+    value = FIELD_DP64(value, BC_MON_CTL, AT, at);
+    value = FIELD_DP64(value, BC_MON_CTL, MCID, mcid);
+    value = FIELD_DP64(value, BC_MON_CTL, EVT_ID, evt_id);
+    value = FIELD_DP64(value, BC_MON_CTL, ATV, atv);
+    value = FIELD_DP64(value, BC_MON_CTL, STATUS, status);
+    value = FIELD_DP64(value, BC_MON_CTL, BUSY, busy);
+    bc->bc_mon_ctl = value;
+}
+
+static void riscv_cbqri_bc_write_alloc_ctl(RiscvCbqriBandwidthState *bc,
+                                           uint64_t value)
+{
+    if (bc->nbwblks == 0 ||
+        (!bc->supports_alloc_op_config_limit &&
+         !bc->supports_alloc_op_read_limit)) {
+        /* capacity allocation not supported: leave bc_alloc_ctl set to 0 */
+        return;
+    }
+
+    /* extract writable fields */
+    uint32_t op = FIELD_EX64(value, BC_ALLOC_CTL, OP);
+    uint32_t at = FIELD_EX64(value, BC_ALLOC_CTL, AT);
+    uint32_t rcid = FIELD_EX64(value, BC_ALLOC_CTL, RCID);
+
+    /* extract read-only fields */
+    uint32_t status = FIELD_EX64(bc->bc_alloc_ctl, BC_ALLOC_CTL, STATUS);
+    bool busy = FIELD_EX64(bc->bc_alloc_ctl, BC_ALLOC_CTL, BUSY);
+
+    if (busy) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: busy flag still set, ignored",
+                      __func__);
+        return;
+    }
+
+    bool atv = true;
+    if (!bc->supports_at_data &&
+        !bc->supports_at_code) {
+        /* AT not supported: hardwire to 0 */
+        at = 0;
+        atv = false;
+    }
+
+    if (rcid >= bc->nb_rcids) {
+        status = BC_ALLOC_STATUS_INVAL_RCID;
+    } else if (atv && !is_valid_at(bc, at)) {
+        status = BC_ALLOC_STATUS_INVAL_AT;
+    } else if (op == BC_ALLOC_OP_CONFIG_LIMIT &&
+               bc->supports_alloc_op_config_limit) {
+        status = bandwidth_config(bc, rcid, at, &busy);
+    } else if (op == BC_ALLOC_OP_READ_LIMIT &&
+               bc->supports_alloc_op_read_limit) {
+        status = bandwidth_read(bc, rcid, at, &busy);
+    } else {
+        status = BC_ALLOC_STATUS_INVAL_OP;
+    }
+
+    /* reconstruct updated register value */
+    value = 0;
+    value = FIELD_DP64(value, BC_ALLOC_CTL, OP, op);
+    value = FIELD_DP64(value, BC_ALLOC_CTL, AT, at);
+    value = FIELD_DP64(value, BC_ALLOC_CTL, RCID, rcid);
+    value = FIELD_DP64(value, BC_ALLOC_CTL, STATUS, status);
+    value = FIELD_DP64(value, BC_ALLOC_CTL, BUSY, busy);
+    bc->bc_alloc_ctl = value;
+}
+
+static void riscv_cbqri_bc_write_bw_alloc(RiscvCbqriBandwidthState *bc,
+                                          uint64_t value)
+{
+    if (bc->nbwblks == 0) {
+        /* capacity allocation not supported: leave bw_alloc set to 0 */
+        return;
+    }
+
+    BandwidthAllocation *bc_bw_alloc = &bc->bw_allocations[0];
+
+    /* extract writable fields */
+    bc_bw_alloc->Rbwb = FIELD_EX64(value, BC_BW_ALLOC, Rbwb);
+    bc_bw_alloc->Mweight = FIELD_EX64(value, BC_BW_ALLOC, Mweight);
+    bc_bw_alloc->sharedAT = FIELD_EX64(value, BC_BW_ALLOC, sharedAT);
+    bc_bw_alloc->useShared = FIELD_EX64(value, BC_BW_ALLOC, useShared);
+
+    if (!bc->supports_at_data &&
+        !bc->supports_at_code) {
+        /* AT not supported: hardwire to 0 */
+        bc_bw_alloc->sharedAT = 0;
+        bc_bw_alloc->useShared = false;
+    }
+}
+
+static void riscv_cbqri_bc_write(void *opaque, hwaddr addr,
+                                 uint64_t value, unsigned size)
+{
+    RiscvCbqriBandwidthState *bc = opaque;
+
+    assert((addr % 8) == 0);
+    assert(size == 8);
+
+    switch (addr) {
+    case A_BC_CAPABILITIES:
+        /* read-only register */
+        break;
+    case A_BC_MON_CTL:
+        riscv_cbqri_bc_write_mon_ctl(bc, value);
+        break;
+    case A_BC_MON_CTR_VAL:
+        /* read-only register */
+        break;
+    case A_BC_ALLOC_CTL:
+        riscv_cbqri_bc_write_alloc_ctl(bc, value);
+        break;
+    case A_BC_BW_ALLOC:
+        riscv_cbqri_bc_write_bw_alloc(bc, value);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: out of bounds (addr=0x%x)",
+                      __func__, (uint32_t)addr);
+    }
+}
+
+static uint64_t riscv_cbqri_bc_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RiscvCbqriBandwidthState *bc = opaque;
+    uint64_t value = 0;
+
+    assert((addr % 8) == 0);
+    assert(size == 8);
+
+    switch (addr) {
+    case A_BC_CAPABILITIES:
+        value = FIELD_DP64(value, BC_CAPABILITIES, VER_MAJOR,
+                           RISCV_CBQRI_VERSION_MAJOR);
+        value = FIELD_DP64(value, BC_CAPABILITIES, VER_MINOR,
+                           RISCV_CBQRI_VERSION_MINOR);
+        value = FIELD_DP64(value, BC_CAPABILITIES, RPFX,
+                           bc->rpfx);
+        value = FIELD_DP64(value, BC_CAPABILITIES, P,
+                           bc->p);
+        value = FIELD_DP64(value, BC_CAPABILITIES, NBWBLKS,
+                           bc->nbwblks);
+        value = FIELD_DP64(value, BC_CAPABILITIES, MRBWB,
+                           bc->mrbwb);
+        break;
+    case A_BC_MON_CTL:
+        value = bc->bc_mon_ctl;
+        break;
+    case A_BC_MON_CTR_VAL:
+        value = bc->bc_mon_ctr_val;
+        break;
+    case A_BC_ALLOC_CTL:
+        value = bc->bc_alloc_ctl;
+        break;
+    case A_BC_BW_ALLOC:
+        BandwidthAllocation *bc_bw_alloc = &bc->bw_allocations[0];
+        value = FIELD_DP64(value, BC_BW_ALLOC, Rbwb, bc_bw_alloc->Rbwb);
+        value = FIELD_DP64(value, BC_BW_ALLOC, Mweight, bc_bw_alloc->Mweight);
+        value = FIELD_DP64(value, BC_BW_ALLOC, sharedAT, bc_bw_alloc->sharedAT);
+        value = FIELD_DP64(value, BC_BW_ALLOC, useShared,
+                           bc_bw_alloc->useShared);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: out of bounds (addr=0x%x)",
+                      __func__, (uint32_t)addr);
+    }
+
+    return value;
+}
+
+static const MemoryRegionOps riscv_cbqri_bc_ops = {
+    .read = riscv_cbqri_bc_read,
+    .write = riscv_cbqri_bc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+};
+
+static void riscv_cbqri_bc_realize(DeviceState *dev, Error **errp)
+{
+    RiscvCbqriBandwidthState *bc = RISCV_CBQRI_BC(dev);
+
+    if (!bc->mmio_base) {
+        error_setg(errp, "mmio_base property not set");
+        return;
+    }
+
+    assert(bc->mon_counters == NULL);
+    bc->mon_counters = g_new0(MonitorCounter, bc->nb_mcids);
+
+    assert(bc->bw_allocations == NULL);
+    BandwidthAllocation *bw_alloc_end = get_bw_alloc(bc, bc->nb_rcids, 0);
+    unsigned int bw_alloc_size = bw_alloc_end - bc->bw_allocations;
+    bc->bw_allocations = g_new0(BandwidthAllocation, bw_alloc_size);
+
+    memory_region_init_io(&bc->mmio, OBJECT(dev), &riscv_cbqri_bc_ops,
+                          bc, TYPE_RISCV_CBQRI_BC".mmio", 4 * 1024);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &bc->mmio);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, bc->mmio_base);
+}
+
+static void riscv_cbqri_bc_reset(DeviceState *dev)
+{
+    RiscvCbqriBandwidthState *bc = RISCV_CBQRI_BC(dev);
+
+    bc->bc_mon_ctl = 0;
+    bc->bc_alloc_ctl = 0;
+}
+
+static Property riscv_cbqri_bc_properties[] = {
+    DEFINE_PROP_UINT64("mmio_base", RiscvCbqriBandwidthState, mmio_base, 0),
+    DEFINE_PROP_STRING("target", RiscvCbqriBandwidthState, target),
+
+    DEFINE_PROP_UINT16("max_mcids", RiscvCbqriBandwidthState, nb_mcids, 256),
+    DEFINE_PROP_UINT16("max_rcids", RiscvCbqriBandwidthState, nb_rcids, 64),
+    DEFINE_PROP_UINT16("nbwblks", RiscvCbqriBandwidthState, nbwblks, 1024),
+    DEFINE_PROP_UINT16("mrbwb", RiscvCbqriBandwidthState, mrbwb, 819),
+
+    DEFINE_PROP_BOOL("rpfx", RiscvCbqriBandwidthState, rpfx, true),
+    DEFINE_PROP_UINT8("p", RiscvCbqriBandwidthState, p, 4),
+
+    DEFINE_PROP_BOOL("at_data", RiscvCbqriBandwidthState,
+                     supports_at_data, true),
+    DEFINE_PROP_BOOL("at_code", RiscvCbqriBandwidthState,
+                     supports_at_code, true),
+
+    DEFINE_PROP_BOOL("alloc_op_config_limit", RiscvCbqriBandwidthState,
+                     supports_alloc_op_config_limit, true),
+    DEFINE_PROP_BOOL("alloc_op_read_limit", RiscvCbqriBandwidthState,
+                     supports_alloc_op_read_limit, true),
+
+    DEFINE_PROP_BOOL("mon_op_config_event", RiscvCbqriBandwidthState,
+                     supports_mon_op_config_event, true),
+    DEFINE_PROP_BOOL("mon_op_read_counter", RiscvCbqriBandwidthState,
+                     supports_mon_op_read_counter, true),
+
+    DEFINE_PROP_BOOL("mon_evt_id_none", RiscvCbqriBandwidthState,
+                     supports_mon_evt_id_none, true),
+    DEFINE_PROP_BOOL("mon_evt_id_rdwr_count", RiscvCbqriBandwidthState,
+                     supports_mon_evt_id_rdwr_count, true),
+    DEFINE_PROP_BOOL("mon_evt_id_rdonly_count", RiscvCbqriBandwidthState,
+                     supports_mon_evt_id_rdonly_count, true),
+    DEFINE_PROP_BOOL("mon_evt_id_wronly_count", RiscvCbqriBandwidthState,
+                     supports_mon_evt_id_wronly_count, true),
+};
+
+static void riscv_cbqri_bc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->realize = riscv_cbqri_bc_realize;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->desc = "RISC-V CBQRI Bandwidth Controller";
+    device_class_set_props(dc, riscv_cbqri_bc_properties);
+    dc->legacy_reset = riscv_cbqri_bc_reset;
+    dc->user_creatable = true;
+}
+
+static const TypeInfo riscv_cbqri_bc_info = {
+    .name          = TYPE_RISCV_CBQRI_BC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RiscvCbqriBandwidthState),
+    .class_init    = riscv_cbqri_bc_class_init,
+};
+
+static void riscv_cbqri_bc_register_types(void)
+{
+    type_register_static(&riscv_cbqri_bc_info);
+}
+
+DeviceState *riscv_cbqri_bc_create(hwaddr addr,
+                                   const RiscvCbqriBandwidthCaps *caps,
+                                   const char *target_name)
+{
+    DeviceState *dev = qdev_new(TYPE_RISCV_CBQRI_BC);
+
+    qdev_prop_set_uint64(dev, "mmio_base", addr);
+    qdev_prop_set_string(dev, "target", target_name);
+    qdev_prop_set_uint16(dev, "max_mcids", caps->nb_mcids);
+    qdev_prop_set_uint16(dev, "max_rcids", caps->nb_rcids);
+    qdev_prop_set_uint16(dev, "nbwblks", caps->nbwblks);
+    qdev_prop_set_bit(dev, "rpfx", caps->rpfx);
+    qdev_prop_set_uint8(dev, "p", caps->p);
+
+    qdev_prop_set_bit(dev, "at_data",
+                      caps->supports_at_data);
+    qdev_prop_set_bit(dev, "at_code",
+                      caps->supports_at_code);
+    qdev_prop_set_bit(dev, "alloc_op_config_limit",
+                      caps->supports_alloc_op_config_limit);
+    qdev_prop_set_bit(dev, "alloc_op_read_limit",
+                      caps->supports_alloc_op_read_limit);
+    qdev_prop_set_bit(dev, "mon_op_config_event",
+                      caps->supports_mon_op_config_event);
+    qdev_prop_set_bit(dev, "mon_op_read_counter",
+                      caps->supports_mon_op_read_counter);
+    qdev_prop_set_bit(dev, "mon_evt_id_none",
+                      caps->supports_mon_evt_id_none);
+    qdev_prop_set_bit(dev, "mon_evt_id_rdwr_count",
+                      caps->supports_mon_evt_id_rdwr_count);
+    qdev_prop_set_bit(dev, "mon_evt_id_rdonly_count",
+                      caps->supports_mon_evt_id_rdonly_count);
+    qdev_prop_set_bit(dev, "mon_evt_id_wronly_count",
+                      caps->supports_mon_evt_id_wronly_count);
+
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    return dev;
+}
+
+type_init(riscv_cbqri_bc_register_types)

-- 
2.43.0


