Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F56CD0413
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 21:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcsXY-0006Pr-8A; Mon, 05 Jan 2026 16:55:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vcsXV-0006Jj-AS; Mon, 05 Jan 2026 16:55:01 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vcsXP-0006Ce-1p; Mon, 05 Jan 2026 16:55:01 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A321460143;
 Mon,  5 Jan 2026 21:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285FBC16AAE;
 Mon,  5 Jan 2026 21:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767650091;
 bh=K37RtNJ0zAXsnaRdDGr02sGPgFo/N4q9DUtX8VTIP3Q=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=cqBW9Q5z8t12wBn7ysI3Tz87sHUG34aTNS4us+RtIRF0za3WgLRw7/ET1M8n/3qJK
 iOti7lQka7xTizpC9LRMVKEitVs5UHGDN8wOs4hSeuWtO9bB9qK6Y1nTrDaeUIFxyC
 Z4CWRNl7PLHSyumu97NXLQwjsNvtdMF4tmm/yMTl54igtM9hMSsg4kSr41oRSpBRQ7
 SQd//PD4O+j3e/TcS1T4CYQbdCv7rx7mJSjeaL4d414yK1C8mu3rIHZW5T98gI/AHH
 Tk9OwuMkD3KJSKvrBZo7uM3MwR5FBM81KyMDfeMrVSczfhaUO3ltcKY7aldWXS3CSp
 RWXJpsSG4JDeA==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 05 Jan 2026 13:54:21 -0800
Subject: [PATCH v4 3/6] hw/riscv: implement CBQRI capacity controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-riscv-ssqosid-cbqri-v4-3-9ad7671dde78@kernel.org>
References: <20260105-riscv-ssqosid-cbqri-v4-0-9ad7671dde78@kernel.org>
In-Reply-To: <20260105-riscv-ssqosid-cbqri-v4-0-9ad7671dde78@kernel.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=25955; i=fustini@kernel.org;
 h=from:subject:message-id; bh=gx73Inp2q04OczsXEVLfNjmeBYBWKGfGs8Dc5otLyiw=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWTGGGueTpC6H+rp9/d/ogU3x5nD1y42fElTY6+tyBFf8
 Np/VQFLRykLgxgXg6yYIsumD3kXlniFfl0w/8U2mDmsTCBDGLg4BWAil/gYGa7XW7xb90amdsqN
 mRf3HD3j3Pz+QsqdmTqqfwM2rbJ+48rL8N9129c4DeVfNdPEduz7Z/ZP98u1YymvWo9a/32RtEy
 lpJMPAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
Received-SPF: pass client-ip=172.105.4.254; envelope-from=fustini@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Nicolas Pitre <npitre@baylibre.com>

Implement a capacity controller according to the Capacity and Bandwidth
QoS Register Interface (CBQRI) which supports these capabilities:

  - Number of access types: 2 (code and data)
  - Usage monitoring operations: CONFIG_EVENT, READ_COUNTER
  - Event IDs supported: None, Occupancy
  - Capacity allocation ops: CONFIG_LIMIT, READ_LIMIT, FLUSH_RCID

Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
[fustini: add fields introduced in the ratified spec: cunits, rpfx, p]
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 MAINTAINERS               |   1 +
 hw/riscv/cbqri_capacity.c | 706 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 707 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d1b2b411010..99f4c12f3b92 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -362,6 +362,7 @@ M: Nicolas Pitre <npitre@baylibre.com>
 M: Drew Fustini <fustini@kernel.org>
 L: qemu-riscv@nongnu.org
 S: Supported
+F: hw/riscv/cbqri_capacity.c
 F: include/hw/riscv/cbqri.h
 
 RENESAS RX CPUs
diff --git a/hw/riscv/cbqri_capacity.c b/hw/riscv/cbqri_capacity.c
new file mode 100644
index 000000000000..9382ba5ee989
--- /dev/null
+++ b/hw/riscv/cbqri_capacity.c
@@ -0,0 +1,706 @@
+/*
+ * RISC-V Capacity and Bandwidth QoS Register Interface
+ * URL: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
+ *
+ * Copyright (c) 2023 BayLibre SAS
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This file contains the Capacity-controller QoS Register Interface.
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
+#include "qemu/bitmap.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/sysbus.h"
+#include "target/riscv/cpu.h"
+#include "hw/riscv/cbqri.h"
+
+/* Encodings of `AT` field */
+enum {
+    CC_AT_DATA = 0,
+    CC_AT_CODE = 1,
+};
+
+/* Capabilities */
+REG64(CC_CAPABILITIES, 0);
+FIELD(CC_CAPABILITIES, VER, 0, 8);
+FIELD(CC_CAPABILITIES, VER_MINOR, 0, 4);
+FIELD(CC_CAPABILITIES, VER_MAJOR, 4, 4);
+FIELD(CC_CAPABILITIES, NCBLKS, 8, 16);
+FIELD(CC_CAPABILITIES, FRCID, 24, 1);
+FIELD(CC_CAPABILITIES, CUNITS, 25, 1);
+FIELD(CC_CAPABILITIES, RPFX, 26,  1);
+FIELD(CC_CAPABILITIES, P, 27, 4);
+
+/* Usage monitoring control */
+REG64(CC_MON_CTL, 8);
+FIELD(CC_MON_CTL, OP, 0, 5);
+FIELD(CC_MON_CTL, AT, 5, 3);
+FIELD(CC_MON_CTL, MCID, 8, 12);
+FIELD(CC_MON_CTL, EVT_ID, 20, 8);
+FIELD(CC_MON_CTL, ATV, 28, 1);
+FIELD(CC_MON_CTL, STATUS, 32, 7);
+FIELD(CC_MON_CTL, BUSY, 39, 1);
+
+/* Usage monitoring operations */
+enum {
+    CC_MON_OP_CONFIG_EVENT = 1,
+    CC_MON_OP_READ_COUNTER = 2,
+};
+
+/* Usage monitoring event ID */
+enum {
+    CC_EVT_ID_None = 0,
+    CC_EVT_ID_Occupancy = 1,
+};
+
+/* CC_MON_CTL.STATUS field encodings */
+enum {
+    CC_MON_CTL_STATUS_SUCCESS = 1,
+    CC_MON_CTL_STATUS_INVAL_OP = 2,
+    CC_MON_CTL_STATUS_INVAL_MCID = 3,
+    CC_MON_CTL_STATUS_INVAL_EVT_ID = 4,
+    CC_MON_CTL_STATUS_INVAL_AT = 5,
+};
+
+/* Monitoring counter value */
+REG64(CC_MON_CTR_VAL, 16);
+FIELD(CC_MON_CTR_VAL, CTR, 0, 63);
+FIELD(CC_MON_CTR_VAL, INVALID, 63, 1);
+
+/* Capacity allocation control */
+REG64(CC_ALLOC_CTL, 24);
+FIELD(CC_ALLOC_CTL, OP, 0, 5);
+FIELD(CC_ALLOC_CTL, AT, 5, 3);
+FIELD(CC_ALLOC_CTL, RCID, 8, 12);
+FIELD(CC_ALLOC_CTL, STATUS, 32, 7);
+FIELD(CC_ALLOC_CTL, BUSY, 39, 1);
+
+/* Capacity allocation operations */
+enum {
+    CC_ALLOC_OP_CONFIG_LIMIT = 1,
+    CC_ALLOC_OP_READ_LIMIT = 2,
+    CC_ALLOC_OP_FLUSH_RCID = 3,
+};
+
+/* CC_ALLOC_CTL.STATUS field encodings */
+enum {
+    CC_ALLOC_STATUS_SUCCESS = 1,
+    CC_ALLOC_STATUS_INVAL_OP = 2,
+    CC_ALLOC_STATUS_INVAL_RCID = 3,
+    CC_ALLOC_STATUS_INVAL_AT = 4,
+    CC_ALLOC_STATUS_INVAL_BLKMASK = 5,
+};
+
+REG64(CC_BLOCK_MASK, 32);
+
+
+typedef struct MonitorCounter {
+    uint64_t ctr_val;
+    int at;
+    int evt_id;
+    bool active;
+} MonitorCounter;
+
+typedef struct RiscvCbqriCapacityState {
+    SysBusDevice parent_obj;
+    MemoryRegion mmio;
+
+    /* cached value of some registers */
+    uint64_t cc_mon_ctl;
+    uint64_t cc_mon_ctr_val;
+    uint64_t cc_alloc_ctl;
+
+    /* monitoring counters */
+    MonitorCounter *mon_counters;
+
+    /* allocation blockmasks (1st one is the CC_BLOCK_MASK register) */
+    uint64_t *alloc_blockmasks;
+
+    /* properties */
+    uint64_t mmio_base;
+    char *target;
+    uint16_t nb_mcids;
+    uint16_t nb_rcids;
+
+    uint16_t ncblks;
+
+    bool supports_at_data;
+    bool supports_at_code;
+
+    bool supports_alloc_op_config_limit;
+    bool supports_alloc_op_read_limit;
+    bool supports_alloc_op_flush_rcid;
+
+    bool supports_mon_op_config_event;
+    bool supports_mon_op_read_counter;
+
+    bool supports_mon_evt_id_none;
+    bool supports_mon_evt_id_occupancy;
+} RiscvCbqriCapacityState;
+
+#define RISCV_CBQRI_CC(obj) \
+    OBJECT_CHECK(RiscvCbqriCapacityState, (obj), TYPE_RISCV_CBQRI_CC)
+
+static inline unsigned int get_bmw(RiscvCbqriCapacityState *cc)
+{
+    unsigned int bmw = ((cc->ncblks + 63) / 64) * 64;
+
+    return bmw;
+}
+
+static inline unsigned int get_slots(RiscvCbqriCapacityState *cc)
+{
+    unsigned int slots = (cc->ncblks + 63) / 64;
+
+    return slots;
+}
+
+static uint64_t get_blockmask_offset(RiscvCbqriCapacityState *cc,
+                                        uint32_t rcid, uint32_t at)
+{
+    /*
+     * Each blockmask is made of one or more uint64_t "slots".
+     *
+     * The first slot (or set of slots when BMW is great than 64)
+     * holds the CC_BLOCK_MASK register content.
+     *
+     * The following slot holds the the CC_CUNITS register content
+     * which has a fixed size of 8 bytes.
+     *
+     * The remaining slots contain the blockmask for each AT per RCID.
+     *
+     * For example, this would be the layout of the slots for a
+     * controller which has AT types Data and Code enabled and
+     * NCBLKS of 16. This results in a BMW of 64 so each blockmask
+     * can fit in 1 slot. The first 6 slots would be:
+     *
+     *   Slot
+     *   [ 0]     register: CC_BLOCK_MASK
+     *   [ 1]     register: CC_CUNITS
+     *   [ 2] RCID= 0 AT=0: cc_block_mask
+     *   [ 3] RCID= 0 AT=1: cc_block_mask
+     *   [ 4] RCID= 1 AT=0: cc_block_mask
+     *   [ 5] RCID= 1 AT=1: cc_block_mask
+     *
+     * This would be the layout for NCBLKS of 100 and AT types Data
+     * and Code. BMW would be 128 so each blockmask takes 2 slots.
+     * The first 11 slots would be:
+     *
+     *   Slot
+     *   [ 0]     register: CC_BLOCK_MASK
+     *   [ 1]     register: CC_BLOCK_MASK
+     *   [ 2]     register: CC_CUNITS
+     *   [ 3] RCID= 0 AT=0: cc_block_mask
+     *   [ 4] RCID= 0 AT=0: cc_block_mask
+     *   [ 5] RCID= 0 AT=1: cc_block_mask
+     *   [ 6] RCID= 0 AT=1: cc_block_mask
+     *   [ 7] RCID= 1 AT=0: cc_block_mask
+     *   [ 8] RCID= 1 AT=0: cc_block_mask
+     *   [ 9] RCID= 1 AT=1: cc_block_mask
+     *   [10] RCID= 1 AT=1: cc_block_mask
+     *
+     */
+    unsigned int nb_ats = 0;
+    nb_ats += !!cc->supports_at_data;
+    nb_ats += !!cc->supports_at_code;
+    nb_ats = MAX(nb_ats, 1);
+    assert(at < nb_ats);
+
+    unsigned int blockmask_offset;
+    unsigned int blockmask_slots = get_slots(cc);
+    blockmask_offset = blockmask_slots * ((rcid * nb_ats) + at);
+
+    /*
+     * Add offset for cc_blockmask register in slot 0 to (blockmask_slots-1)
+     */
+    blockmask_offset += blockmask_slots;
+
+    /*
+     * Add offset to account for cc_cunits register which is always 1 slot
+     */
+    blockmask_offset += 1;
+
+    return blockmask_offset;
+}
+
+static uint64_t *get_blockmask_location(RiscvCbqriCapacityState *cc,
+                                        uint32_t rcid, uint32_t at)
+{
+    assert(cc->alloc_blockmasks != NULL);
+    unsigned int blockmask_offset = get_blockmask_offset(cc, rcid, at);
+    return cc->alloc_blockmasks + blockmask_offset;
+}
+
+static uint32_t alloc_blockmask_config(RiscvCbqriCapacityState *cc,
+                                       uint32_t rcid, uint32_t at,
+                                       bool *busy)
+{
+    unsigned int blockmask_slots = get_slots(cc);
+
+    if ((cc->ncblks % 64) != 0) {
+        /* make sure provided mask isn't too large */
+        uint64_t tail = cc->alloc_blockmasks[blockmask_slots - 1];
+        if ((tail >> (cc->ncblks % 64)) != 0) {
+            return CC_ALLOC_STATUS_INVAL_BLKMASK;
+        }
+    }
+
+    /* for now we only preserve the current CC_BLOCK_MASK register content */
+    memcpy(get_blockmask_location(cc, rcid, at),
+           cc->alloc_blockmasks, blockmask_slots * 8);
+    return CC_ALLOC_STATUS_SUCCESS;
+}
+
+static uint32_t alloc_blockmask_read(RiscvCbqriCapacityState *cc,
+                                     uint32_t rcid, uint32_t at,
+                                     bool *busy)
+{
+    unsigned int blockmask_slots = get_slots(cc);
+
+    memcpy(cc->alloc_blockmasks,
+           get_blockmask_location(cc, rcid, at),
+           blockmask_slots * 8);
+    return CC_ALLOC_STATUS_SUCCESS;
+}
+
+static uint32_t alloc_blockmask_init(RiscvCbqriCapacityState *cc,
+                                     uint32_t rcid, uint32_t at, bool set,
+                                     bool *busy)
+{
+    void *blockmask = get_blockmask_location(cc, rcid, at);
+
+    if (set) {
+        bitmap_fill(blockmask, cc->ncblks);
+    } else {
+        bitmap_zero(blockmask, cc->ncblks);
+    }
+    return CC_ALLOC_STATUS_SUCCESS;
+}
+
+static bool is_valid_at(RiscvCbqriCapacityState *cc, uint32_t at)
+{
+    switch (at) {
+    case CC_AT_DATA:
+        return cc->supports_at_data;
+    case CC_AT_CODE:
+        return cc->supports_at_code;
+    default:
+        return false;
+    }
+}
+
+static void riscv_cbqri_cc_write_mon_ctl(RiscvCbqriCapacityState *cc,
+                                         uint64_t value)
+{
+    if (!cc->supports_mon_op_config_event &&
+        !cc->supports_mon_op_read_counter) {
+        /* monitoring not supported: leave mon_ctl set to 0 */
+        return;
+    }
+
+    /* extract writable fields */
+    uint32_t op = FIELD_EX64(value, CC_MON_CTL, OP);
+    uint32_t at = FIELD_EX64(value, CC_MON_CTL, AT);
+    uint32_t mcid = FIELD_EX64(value, CC_MON_CTL, MCID);
+    uint32_t evt_id = FIELD_EX64(value, CC_MON_CTL, EVT_ID);
+    bool atv = FIELD_EX64(value, CC_MON_CTL, ATV);
+
+    /* extract read-only fields */
+    uint32_t status = FIELD_EX64(cc->cc_mon_ctl, CC_MON_CTL, STATUS);
+    bool busy = FIELD_EX64(cc->cc_mon_ctl, CC_MON_CTL, BUSY);
+
+    if (busy) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: busy flag still set, ignored",
+                      __func__);
+        return;
+    }
+
+    if (!cc->supports_at_data &&
+        !cc->supports_at_code) {
+        /* AT not supported: hardwire to 0 */
+        at = 0;
+        atv = false;
+    }
+
+    if (mcid >= cc->nb_mcids) {
+        status = CC_MON_CTL_STATUS_INVAL_MCID;
+    } else if (op == CC_MON_OP_CONFIG_EVENT &&
+               cc->supports_mon_op_config_event) {
+        if (evt_id == CC_EVT_ID_None &&
+            cc->supports_mon_evt_id_none) {
+            cc->mon_counters[mcid].active = false;
+            status = CC_MON_CTL_STATUS_SUCCESS;
+        } else if (evt_id == CC_EVT_ID_Occupancy &&
+                   cc->supports_mon_evt_id_occupancy) {
+            if (atv && !is_valid_at(cc, at)) {
+                status = CC_MON_CTL_STATUS_INVAL_AT;
+            } else {
+                cc->mon_counters[mcid].ctr_val =
+                    FIELD_DP64(0, CC_MON_CTR_VAL, INVALID, 1);
+                cc->mon_counters[mcid].evt_id = evt_id;
+                cc->mon_counters[mcid].at = atv ? at : -1;
+                cc->mon_counters[mcid].active = true;
+                status = CC_MON_CTL_STATUS_SUCCESS;
+            }
+        } else {
+            status = CC_MON_CTL_STATUS_INVAL_EVT_ID;
+        }
+    } else if (op == CC_MON_OP_READ_COUNTER &&
+               cc->supports_mon_op_read_counter) {
+        cc->cc_mon_ctr_val = cc->mon_counters[mcid].ctr_val;
+        status = CC_MON_CTL_STATUS_SUCCESS;
+    } else {
+        status = CC_MON_CTL_STATUS_INVAL_OP;
+    }
+
+    /* reconstruct updated register value */
+    value = 0;
+    value = FIELD_DP64(value, CC_MON_CTL, OP, op);
+    value = FIELD_DP64(value, CC_MON_CTL, AT, at);
+    value = FIELD_DP64(value, CC_MON_CTL, MCID, mcid);
+    value = FIELD_DP64(value, CC_MON_CTL, EVT_ID, evt_id);
+    value = FIELD_DP64(value, CC_MON_CTL, ATV, atv);
+    value = FIELD_DP64(value, CC_MON_CTL, STATUS, status);
+    value = FIELD_DP64(value, CC_MON_CTL, BUSY, busy);
+    cc->cc_mon_ctl = value;
+}
+
+static void riscv_cbqri_cc_write_alloc_ctl(RiscvCbqriCapacityState *cc,
+                                           uint64_t value)
+{
+    if (cc->ncblks == 0 ||
+        (!cc->supports_alloc_op_config_limit &&
+         !cc->supports_alloc_op_read_limit &&
+         !cc->supports_alloc_op_flush_rcid)) {
+        /* capacity allocation not supported: leave alloc_ctl set to 0 */
+        return;
+    }
+
+    /* extract writable fields */
+    uint32_t op = FIELD_EX64(value, CC_ALLOC_CTL, OP);
+    uint32_t at = FIELD_EX64(value, CC_ALLOC_CTL, AT);
+    uint32_t rcid = FIELD_EX64(value, CC_ALLOC_CTL, RCID);
+
+    /* extract read-only fields */
+    uint32_t status = FIELD_EX64(cc->cc_alloc_ctl, CC_ALLOC_CTL, STATUS);
+    bool busy = FIELD_EX64(cc->cc_alloc_ctl, CC_ALLOC_CTL, BUSY);
+
+    if (busy) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: busy flag still set, ignored",
+                      __func__);
+        return;
+    }
+
+    bool atv = true;
+    if (!cc->supports_at_data &&
+        !cc->supports_at_code) {
+        /* AT not supported: hardwire to 0 */
+        at = 0;
+        atv = false;
+    }
+
+    if (rcid >= cc->nb_rcids) {
+        status = CC_ALLOC_STATUS_INVAL_RCID;
+    } else if (atv && !is_valid_at(cc, at)) {
+        status = CC_ALLOC_STATUS_INVAL_AT;
+    } else if (op == CC_ALLOC_OP_CONFIG_LIMIT &&
+               cc->supports_alloc_op_config_limit) {
+        status = alloc_blockmask_config(cc, rcid, at, &busy);
+    } else if (op == CC_ALLOC_OP_READ_LIMIT &&
+               cc->supports_alloc_op_read_limit) {
+        status = alloc_blockmask_read(cc, rcid, at, &busy);
+    } else if (op == CC_ALLOC_OP_FLUSH_RCID &&
+               cc->supports_alloc_op_flush_rcid) {
+        /*
+         * The flush operation is not allowed to change the configured
+         * capacity block allocation or the capacity unit limit.
+         */
+        status = CC_ALLOC_STATUS_SUCCESS;
+    } else {
+        status = CC_ALLOC_STATUS_INVAL_OP;
+    }
+
+    /* reconstruct updated register value */
+    value = 0;
+    value = FIELD_DP64(value, CC_ALLOC_CTL, OP, op);
+    value = FIELD_DP64(value, CC_ALLOC_CTL, AT, at);
+    value = FIELD_DP64(value, CC_ALLOC_CTL, RCID, rcid);
+    value = FIELD_DP64(value, CC_ALLOC_CTL, STATUS, status);
+    value = FIELD_DP64(value, CC_ALLOC_CTL, BUSY, busy);
+    cc->cc_alloc_ctl = value;
+}
+
+static void riscv_cbqri_cc_write(void *opaque, hwaddr addr,
+                                 uint64_t value, unsigned size)
+{
+    RiscvCbqriCapacityState *cc = opaque;
+
+    assert((addr % 8) == 0);
+    assert(size == 8);
+
+    switch (addr) {
+    case A_CC_CAPABILITIES:
+        /* read-only register */
+        break;
+    case A_CC_MON_CTL:
+        riscv_cbqri_cc_write_mon_ctl(cc, value);
+        break;
+    case A_CC_ALLOC_CTL:
+        riscv_cbqri_cc_write_alloc_ctl(cc, value);
+        break;
+    case A_CC_MON_CTR_VAL:
+        /* read-only register */
+        break;
+    case A_CC_BLOCK_MASK:
+        if (cc->ncblks == 0) {
+            break;
+        }
+        /* fallthrough */
+    default:
+        uint32_t blkmask_slot = (addr - A_CC_BLOCK_MASK) / 8;
+        if (blkmask_slot == get_slots(cc)) {
+            /* this is cc_cunits register */
+            break;
+        } else if (blkmask_slot > get_slots(cc)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: out of bounds (addr=0x%x)",
+                          __func__, (uint32_t)addr);
+            break;
+        }
+        cc->alloc_blockmasks[blkmask_slot] = value;
+    }
+}
+
+static uint64_t riscv_cbqri_cc_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RiscvCbqriCapacityState *cc = opaque;
+    uint64_t value = 0;
+
+    assert((addr % 8) == 0);
+    assert(size == 8);
+    switch (addr) {
+    case A_CC_CAPABILITIES:
+        value = FIELD_DP64(value, CC_CAPABILITIES, VER_MAJOR,
+                           RISCV_CBQRI_VERSION_MAJOR);
+        value = FIELD_DP64(value, CC_CAPABILITIES, VER_MINOR,
+                           RISCV_CBQRI_VERSION_MINOR);
+        value = FIELD_DP64(value, CC_CAPABILITIES, NCBLKS,
+                           cc->ncblks);
+        value = FIELD_DP64(value, CC_CAPABILITIES, FRCID,
+                           cc->supports_alloc_op_flush_rcid);
+        value = FIELD_DP64(value, CC_CAPABILITIES, CUNITS, 0);
+        value = FIELD_DP64(value, CC_CAPABILITIES, RPFX, 0);
+        value = FIELD_DP64(value, CC_CAPABILITIES, P, 0);
+        break;
+    case A_CC_MON_CTL:
+        value = cc->cc_mon_ctl;
+        break;
+    case A_CC_ALLOC_CTL:
+        value = cc->cc_alloc_ctl;
+        break;
+    case A_CC_MON_CTR_VAL:
+        value = cc->cc_mon_ctr_val;
+        break;
+    case A_CC_BLOCK_MASK:
+        if (cc->ncblks == 0) {
+            break;
+        }
+        /* fallthrough */
+    default:
+        unsigned int blkmask_slot = (addr - A_CC_BLOCK_MASK) / 8;
+        if (blkmask_slot == get_slots(cc)) {
+            /*
+             * The cc_cunits register is always the slot following the
+             * last slot of cc_blockmask register. Capacity units are
+             * not supported by this implementation so must return 0.
+             */
+            value = 0;
+            break;
+        } else if (blkmask_slot > get_slots(cc)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: out of bounds (addr=0x%x)",
+                          __func__, (uint32_t)addr);
+            break;
+        }
+        value = cc->alloc_blockmasks[blkmask_slot];
+    }
+
+    return value;
+}
+
+static const MemoryRegionOps riscv_cbqri_cc_ops = {
+    .read = riscv_cbqri_cc_read,
+    .write = riscv_cbqri_cc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+};
+
+static void riscv_cbqri_cc_realize(DeviceState *dev, Error **errp)
+{
+    RiscvCbqriCapacityState *cc = RISCV_CBQRI_CC(dev);
+    unsigned int bmw = get_bmw(cc);
+    /* The size of the CC registers other than bmw is 40 bytes */
+    unsigned int mmio_size = (bmw / 8) + 40;
+
+    if (!cc->mmio_base) {
+        error_setg(errp, "mmio_base property not set");
+        return;
+    }
+
+    assert(cc->mon_counters == NULL);
+    cc->mon_counters = g_new0(MonitorCounter, cc->nb_mcids);
+
+    assert(cc->alloc_blockmasks == NULL);
+    unsigned int blockmasks_size = get_blockmask_offset(cc, cc->nb_rcids, 0);
+    cc->alloc_blockmasks = g_new0(uint64_t, blockmasks_size);
+
+    memory_region_init_io(&cc->mmio, OBJECT(dev), &riscv_cbqri_cc_ops,
+                          cc, TYPE_RISCV_CBQRI_CC".mmio", mmio_size);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &cc->mmio);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, cc->mmio_base);
+}
+
+static void riscv_cbqri_cc_reset(DeviceState *dev)
+{
+    RiscvCbqriCapacityState *cc = RISCV_CBQRI_CC(dev);
+
+    /*
+     * The spec requires that the reset value is 0 for the cc_mon_ctl.BUSY
+     * and cc_alloc_ctl.BUSY fields, and that the reset value is UNSPECIFIED
+     * for all other registers fields.
+     *
+     * Therefore, it is legal to set the entire contents of cc_mon_ctl and
+     * cc_alloc_ctl to 0.
+     */
+    cc->cc_mon_ctl = 0;
+    cc->cc_alloc_ctl = 0;
+
+    /*
+     * The capacity controllers at reset must allocate all available
+     * capacity to RCID value of 0.
+     *
+     * When the capacity controller supports capacity allocation per
+     * access-type, then all available capacity is shared by all the
+     * access-type for RCID=0.
+     *
+     * For unsupported AT values the resource controller behaves as
+     * if AT was 0 (CC_AT_DATA).
+     */
+    alloc_blockmask_init(cc, 0, CC_AT_DATA, 1, NULL);
+    if (cc->supports_at_code) {
+        alloc_blockmask_init(cc, 0, CC_AT_CODE, 1, NULL);
+    }
+}
+
+static Property riscv_cbqri_cc_properties[] = {
+    DEFINE_PROP_UINT64("mmio_base", RiscvCbqriCapacityState, mmio_base, 0),
+    DEFINE_PROP_STRING("target", RiscvCbqriCapacityState, target),
+
+    DEFINE_PROP_UINT16("max_mcids", RiscvCbqriCapacityState, nb_mcids, 256),
+    DEFINE_PROP_UINT16("max_rcids", RiscvCbqriCapacityState, nb_rcids, 64),
+    DEFINE_PROP_UINT16("ncblks", RiscvCbqriCapacityState, ncblks, 16),
+
+    DEFINE_PROP_BOOL("at_data", RiscvCbqriCapacityState,
+                     supports_at_data, true),
+    DEFINE_PROP_BOOL("at_code", RiscvCbqriCapacityState,
+                     supports_at_code, true),
+
+    DEFINE_PROP_BOOL("alloc_op_config_limit", RiscvCbqriCapacityState,
+                     supports_alloc_op_config_limit, true),
+    DEFINE_PROP_BOOL("alloc_op_read_limit", RiscvCbqriCapacityState,
+                     supports_alloc_op_read_limit, true),
+    DEFINE_PROP_BOOL("alloc_op_flush_rcid", RiscvCbqriCapacityState,
+                     supports_alloc_op_flush_rcid, true),
+
+    DEFINE_PROP_BOOL("mon_op_config_event", RiscvCbqriCapacityState,
+                     supports_mon_op_config_event, true),
+    DEFINE_PROP_BOOL("mon_op_read_counter", RiscvCbqriCapacityState,
+                     supports_mon_op_read_counter, true),
+
+    DEFINE_PROP_BOOL("mon_evt_id_none", RiscvCbqriCapacityState,
+                     supports_mon_evt_id_none, true),
+    DEFINE_PROP_BOOL("mon_evt_id_occupancy", RiscvCbqriCapacityState,
+                     supports_mon_evt_id_occupancy, true),
+};
+
+static void riscv_cbqri_cc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->realize = riscv_cbqri_cc_realize;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->desc = "RISC-V CBQRI Capacity Controller";
+    device_class_set_props(dc, riscv_cbqri_cc_properties);
+    dc->legacy_reset = riscv_cbqri_cc_reset;
+    dc->user_creatable = true;
+}
+
+static const TypeInfo riscv_cbqri_cc_info = {
+    .name          = TYPE_RISCV_CBQRI_CC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RiscvCbqriCapacityState),
+    .class_init    = riscv_cbqri_cc_class_init,
+};
+
+static void riscv_cbqri_cc_register_types(void)
+{
+    type_register_static(&riscv_cbqri_cc_info);
+}
+
+DeviceState *riscv_cbqri_cc_create(hwaddr addr,
+                                   const RiscvCbqriCapacityCaps *caps,
+                                   const char *target_name)
+{
+    DeviceState *dev = qdev_new(TYPE_RISCV_CBQRI_CC);
+
+    qdev_prop_set_uint64(dev, "mmio_base", addr);
+    qdev_prop_set_string(dev, "target", target_name);
+    qdev_prop_set_uint16(dev, "max_mcids", caps->nb_mcids);
+    qdev_prop_set_uint16(dev, "max_rcids", caps->nb_rcids);
+    qdev_prop_set_uint16(dev, "ncblks", caps->ncblks);
+
+    qdev_prop_set_bit(dev, "at_data",
+                      caps->supports_at_data);
+    qdev_prop_set_bit(dev, "at_code",
+                      caps->supports_at_code);
+    qdev_prop_set_bit(dev, "alloc_op_config_limit",
+                      caps->supports_alloc_op_config_limit);
+    qdev_prop_set_bit(dev, "alloc_op_read_limit",
+                      caps->supports_alloc_op_read_limit);
+    qdev_prop_set_bit(dev, "alloc_op_flush_rcid",
+                      caps->supports_alloc_op_flush_rcid);
+    qdev_prop_set_bit(dev, "mon_op_config_event",
+                      caps->supports_mon_op_config_event);
+    qdev_prop_set_bit(dev, "mon_op_read_counter",
+                      caps->supports_mon_op_read_counter);
+    qdev_prop_set_bit(dev, "mon_evt_id_none",
+                      caps->supports_mon_evt_id_none);
+    qdev_prop_set_bit(dev, "mon_evt_id_occupancy",
+                      caps->supports_mon_evt_id_occupancy);
+
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    return dev;
+}
+
+type_init(riscv_cbqri_cc_register_types)

-- 
2.43.0


