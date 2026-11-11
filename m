Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA1E606A324
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N1UyaL+V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRHuX-0006mF-8u; Wed, 11 Nov 2026 18:39:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xRHuP-0006fY-Cb; Wed, 11 Nov 2026 18:39:18 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xRHuL-0004aJ-Jg; Wed, 11 Nov 2026 18:39:17 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4F9A363888;
 Wed, 11 Nov 2026 23:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E5F1F00A0C;
 Wed, 11 Nov 2026 23:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794440352;
 bh=uNpo5OUQHbidQjLVMFiaVG/fKB5+ac3IkqBUX83OaMo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=N1UyaL+V+EMkHC3w2pO7lncqTNBe755+E/IZIddLtytLEgFjLMj3/iZ8O4hxdwlG2
 88Avg56/bgXedMkwQwsSETw0LGHNjO7Bsy3ULtPSLsXp2/2h9s641iSI1LKcHEqF4L
 FaDpG3vvPpPmjPi/NK4Ou2BcIiuY/j8gxBYINv4k38xXb41GOnj49YWkyvVQWCVbpH
 S2WF9wm2ktrrV9s/V011IGNadecsGIJA9oBRJVVSJr2TH5KuKWOPXTpxXbphuHnVR+
 Id7an4hwC7sfT2jVk+MFQjMvXDVkCyAC7ilWDs8k4hVOu+46RwknwzV9Qi9yNg+P6f
 UZQAf/DYqd9Kw==
From: Drew Fustini <fustini@kernel.org>
Date: Wed, 11 Nov 2026 15:38:44 -0800
Subject: [PATCH v8 3/6] hw/riscv: implement CBQRI capacity controller
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261111-riscv-ssqosid-cbqri-v8-3-121f6dcfb573@kernel.org>
References: <20261111-riscv-ssqosid-cbqri-v8-0-121f6dcfb573@kernel.org>
In-Reply-To: <20261111-riscv-ssqosid-cbqri-v8-0-121f6dcfb573@kernel.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Sunil V L <sunilvl@oss.qualcomm.com>, 
 Anup Patel <anup.patel@oss.qualcomm.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
 Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=29329; i=fustini@kernel.org;
 h=from:subject:message-id; bh=NniYNt0YaBnqeyb8ISNjiJrbcAmCrz6mcK+JWLRDG0g=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWR9+TPvvxkfS9G32TMmiu4v4y9sD5mZxNdy4X9Q5qctC
 213lTmu6ShlYRDjYpAVU2TZ9CHvwhKv0K8L5r/YBjOHlQlkCAMXpwBMpLSLkeFZ9cl7c+vzHcpe
 X36q2Zt5Jk/0kRM31yWxDLtZPgvazfIY/vCFBd+TO1TF1prB/zPu/9Nveedypob8LN//gUe0iTn
 AgAsA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
Received-SPF: pass client-ip=172.105.4.254; envelope-from=fustini@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nicolas Pitre <npitre@baylibre.com>

Implement a capacity controller according to the Capacity and Bandwidth
QoS Register Interface (CBQRI) which supports these capabilities:

  - Number of access types: 2 (code and data)
  - Usage monitoring operations: CONFIG_EVENT, READ_COUNTER
  - Event IDs supported: None, Occupancy
  - Capacity allocation ops: CONFIG_LIMIT, READ_LIMIT, FLUSH_RCID

The controller gives the Linux resctrl support for CBQRI a device to
configure and read back capacity block masks per RCID on the virt
machine. Only the register interface is modeled. The configured limits
are not enforced and the monitoring counters are always marked INVALID
because QEMU does not model cache occupancy.

Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
Reviewed-by: Radim Krčmář <radim.krcmar@oss.qualcomm.com>
Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
[fustini: rebase, add fields introduced in the ratified spec]
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 MAINTAINERS               |   1 +
 hw/riscv/cbqri_capacity.c | 771 ++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/cbqri.h  |   8 +
 3 files changed, 780 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2984779ce43a..f230cdbbe1b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -408,6 +408,7 @@ M: Nicolas Pitre <npitre@baylibre.com>
 M: Drew Fustini <fustini@kernel.org>
 L: qemu-riscv@nongnu.org
 S: Supported
+F: hw/riscv/cbqri_capacity.c
 F: include/hw/riscv/cbqri.h
 
 RISC-V SiFive (Xsf*) extensions
diff --git a/hw/riscv/cbqri_capacity.c b/hw/riscv/cbqri_capacity.c
new file mode 100644
index 000000000000..0c572aa8b02f
--- /dev/null
+++ b/hw/riscv/cbqri_capacity.c
@@ -0,0 +1,771 @@
+/*
+ * RISC-V Capacity and Bandwidth QoS Register Interface
+ * URL: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
+ *
+ * Copyright (c) 2023 BayLibre SAS
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This file contains the Capacity-controller QoS Register Interface.
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
+#include "migration/vmstate.h"
+#include "target/riscv/cpu.h"
+#include "hw/riscv/cbqri.h"
+
+/* Property defaults, shared with riscv_cbqri_cc_caps_init() */
+#define CC_DEFAULT_MAX_MCIDS    256
+#define CC_DEFAULT_MAX_RCIDS    64
+#define CC_DEFAULT_NCBLKS       16
+
+/* Encodings of `AT` field */
+enum {
+    CC_AT_DATA = 0,
+    CC_AT_CODE = 1,
+    CC_NB_ATS,
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
+    RiscvCbqriMonitorCounter *mon_counters;
+
+    /* allocation blockmasks (1st one is the CC_BLOCK_MASK register) */
+    uint64_t *alloc_blockmasks;
+
+    /* properties */
+    uint64_t mmio_base;
+    uint16_t nb_mcids;
+    uint16_t nb_rcids;
+
+    uint16_t ncblks;
+
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
+     * The first slot (or set of slots when BMW is greater than 64)
+     * holds the CC_BLOCK_MASK register content.
+     *
+     * The following slot holds the CC_CUNITS register content
+     * which has a fixed size of 8 bytes.
+     *
+     * The remaining slots contain the blockmask for each AT per RCID.
+     *
+     * For example, this would be the layout of the slots for a
+     * controller with NCBLKS of 16. This results in a BMW of 64 so each
+     * blockmask can fit in 1 slot. The first 6 slots would be:
+     *
+     *   Slot
+     *   [ 0]     register: CC_BLOCK_MASK
+     *   [ 1]     register: CC_CUNITS
+     *   [ 2] RCID= 0 AT=0: cc_block_mask
+     *   [ 3] RCID= 0 AT=1: cc_block_mask
+     *   [ 4] RCID= 1 AT=0: cc_block_mask
+     *   [ 5] RCID= 1 AT=1: cc_block_mask
+     *
+     * This would be the layout for NCBLKS of 100. BMW would be 128 so
+     * each blockmask takes 2 slots. The first 11 slots would be:
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
+     * Blockmasks are indexed by the AT encoding, so each RCID has one
+     * blockmask per AT value whether or not the controller supports the
+     * code access type. is_valid_at() rejects an unsupported AT before a
+     * blockmask is selected.
+     */
+    g_assert(at < CC_NB_ATS);
+
+    unsigned int blockmask_offset;
+    unsigned int blockmask_slots = get_slots(cc);
+    blockmask_offset = blockmask_slots * ((rcid * CC_NB_ATS) + at);
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
+    g_assert(cc->alloc_blockmasks != NULL);
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
+        return true;
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
+                      "%s: busy flag still set, ignored\n",
+                      __func__);
+        return;
+    }
+
+    if (!cc->supports_at_code) {
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
+                /*
+                 * The model does not account for cache occupancy, so the
+                 * counter is marked INVALID and stays that way.
+                 */
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
+                      "%s: busy flag still set, ignored\n",
+                      __func__);
+        return;
+    }
+
+    bool atv = true;
+    if (!cc->supports_at_code) {
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
+    g_assert((addr % 8) == 0);
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
+            /* this is the cc_cunits register */
+            break;
+        } else if (blkmask_slot > get_slots(cc)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: out of bounds (addr=0x%x)\n",
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
+    g_assert((addr % 8) == 0);
+
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
+             * last slot of the cc_blockmask register. Capacity units are
+             * not supported by this implementation so it must return 0.
+             */
+            value = 0;
+            break;
+        } else if (blkmask_slot > get_slots(cc)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: out of bounds (addr=0x%x)\n",
+                          __func__, (uint32_t)addr);
+            break;
+        }
+        value = cc->alloc_blockmasks[blkmask_slot];
+    }
+
+    return value;
+}
+
+static uint64_t riscv_cbqri_cc_read_wrapper(void *opaque, hwaddr addr,
+                                            unsigned size)
+{
+    uint64_t value = riscv_cbqri_cc_read(opaque, QEMU_ALIGN_DOWN(addr, 8), 8);
+    if (size == 4) {
+        if (addr & 0x7) {
+            return value >> 32;
+        } else {
+            return value & MAKE_64BIT_MASK(0, 32);
+        }
+    }
+    return value;
+}
+
+static void riscv_cbqri_cc_write_wrapper(void *opaque, hwaddr addr,
+                                             uint64_t value, unsigned size)
+{
+    hwaddr reg_addr = QEMU_ALIGN_DOWN(addr, 8);
+
+    if (size == 4) {
+        uint64_t reg = riscv_cbqri_cc_read(opaque, reg_addr, 8);
+        if (addr & 0x7) {
+            /*
+             * The upper half of the control registers holds only the
+             * read-only STATUS and BUSY fields. Writing it must not run
+             * the operation held in the lower half again.
+             */
+            if (reg_addr == A_CC_MON_CTL || reg_addr == A_CC_ALLOC_CTL) {
+                return;
+            }
+            value = value << 32 | (reg & MAKE_64BIT_MASK(0, 32));
+        } else {
+            value = value | (reg & MAKE_64BIT_MASK(32, 32));
+        }
+    }
+    riscv_cbqri_cc_write(opaque, reg_addr, value, 8);
+}
+
+static const MemoryRegionOps riscv_cbqri_cc_ops = {
+    .read = riscv_cbqri_cc_read_wrapper,
+    .write = riscv_cbqri_cc_write_wrapper,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 4,
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
+    if (cc->nb_rcids == 0) {
+        error_setg(errp, "max_rcids must be at least 1");
+        return;
+    }
+
+    g_assert(cc->mon_counters == NULL);
+    cc->mon_counters = g_new0(RiscvCbqriMonitorCounter, cc->nb_mcids);
+
+    g_assert(cc->alloc_blockmasks == NULL);
+    unsigned int blockmasks_size = get_blockmask_offset(cc, cc->nb_rcids, 0);
+    cc->alloc_blockmasks = g_new0(uint64_t, blockmasks_size);
+
+    memory_region_init_io(&cc->mmio, OBJECT(dev), &riscv_cbqri_cc_ops,
+                          cc, TYPE_RISCV_CBQRI_CC".mmio", mmio_size);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &cc->mmio);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, cc->mmio_base);
+}
+
+static void riscv_cbqri_cc_reset_hold(Object *obj, ResetType type)
+{
+    RiscvCbqriCapacityState *cc = RISCV_CBQRI_CC(obj);
+    unsigned int i;
+
+    /*
+     * The spec requires that the reset value is 0 for the cc_mon_ctl.BUSY
+     * and cc_alloc_ctl.BUSY fields, and that the reset value is UNSPECIFIED
+     * for all other register fields.
+     *
+     * Therefore, it is legal to set the entire contents of cc_mon_ctl and
+     * cc_alloc_ctl to 0, and to clear every allocation and counter so
+     * that a rebooted guest starts from a known state.
+     */
+    cc->cc_mon_ctl = 0;
+    cc->cc_alloc_ctl = 0;
+    cc->cc_mon_ctr_val = 0;
+    for (i = 0; i < cc->nb_mcids; i++) {
+        cc->mon_counters[i] = (RiscvCbqriMonitorCounter) {
+            .ctr_val = FIELD_DP64(0, CC_MON_CTR_VAL, INVALID, 1),
+        };
+    }
+    memset(cc->alloc_blockmasks, 0,
+           get_blockmask_offset(cc, cc->nb_rcids, 0) * sizeof(uint64_t));
+
+    /*
+     * The capacity controllers at reset must allocate all available
+     * capacity to RCID value of 0.
+     *
+     * When the capacity controller supports capacity allocation per
+     * access type, then all available capacity is shared by all the
+     * access types for RCID=0.
+     *
+     * For unsupported AT values the resource controller behaves as
+     * if AT was 0 (CC_AT_DATA).
+     *
+     * A controller with NCBLKS of 0 does not support capacity
+     * allocation and has nothing to allocate.
+     */
+    if (cc->ncblks == 0) {
+        return;
+    }
+    alloc_blockmask_init(cc, 0, CC_AT_DATA, 1, NULL);
+    if (cc->supports_at_code) {
+        alloc_blockmask_init(cc, 0, CC_AT_CODE, 1, NULL);
+    }
+}
+
+static const Property riscv_cbqri_cc_properties[] = {
+    DEFINE_PROP_UINT64("mmio_base", RiscvCbqriCapacityState, mmio_base, 0),
+
+    DEFINE_PROP_UINT16("max_mcids", RiscvCbqriCapacityState, nb_mcids,
+                       CC_DEFAULT_MAX_MCIDS),
+    DEFINE_PROP_UINT16("max_rcids", RiscvCbqriCapacityState, nb_rcids,
+                       CC_DEFAULT_MAX_RCIDS),
+    DEFINE_PROP_UINT16("ncblks", RiscvCbqriCapacityState, ncblks,
+                       CC_DEFAULT_NCBLKS),
+
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
+static const VMStateDescription vmstate_riscv_cbqri_cc = {
+    .name = "riscv-cbqri-capacity",
+    .unmigratable = 1,
+};
+
+static void riscv_cbqri_cc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->realize = riscv_cbqri_cc_realize;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->desc = "RISC-V CBQRI Capacity Controller";
+    device_class_set_props(dc, riscv_cbqri_cc_properties);
+    rc->phases.hold = riscv_cbqri_cc_reset_hold;
+    dc->vmsd = &vmstate_riscv_cbqri_cc;
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
+void riscv_cbqri_cc_caps_init(RiscvCbqriCapacityCaps *caps)
+{
+    *caps = (RiscvCbqriCapacityCaps) {
+        .nb_mcids = CC_DEFAULT_MAX_MCIDS,
+        .nb_rcids = CC_DEFAULT_MAX_RCIDS,
+        .ncblks = CC_DEFAULT_NCBLKS,
+        .supports_at_code = true,
+        .supports_alloc_op_config_limit = true,
+        .supports_alloc_op_read_limit = true,
+        .supports_alloc_op_flush_rcid = true,
+        .supports_mon_op_config_event = true,
+        .supports_mon_op_read_counter = true,
+        .supports_mon_evt_id_none = true,
+        .supports_mon_evt_id_occupancy = true,
+    };
+}
+
+DeviceState *riscv_cbqri_cc_create(hwaddr addr,
+                                   const RiscvCbqriCapacityCaps *caps)
+{
+    DeviceState *dev = qdev_new(TYPE_RISCV_CBQRI_CC);
+
+    qdev_prop_set_uint64(dev, "mmio_base", addr);
+    qdev_prop_set_uint16(dev, "max_mcids", caps->nb_mcids);
+    qdev_prop_set_uint16(dev, "max_rcids", caps->nb_rcids);
+    qdev_prop_set_uint16(dev, "ncblks", caps->ncblks);
+
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
diff --git a/include/hw/riscv/cbqri.h b/include/hw/riscv/cbqri.h
index 7132e6474fb9..10b64613599f 100644
--- a/include/hw/riscv/cbqri.h
+++ b/include/hw/riscv/cbqri.h
@@ -17,6 +17,14 @@
 #define TYPE_RISCV_CBQRI_CC         "riscv.cbqri.capacity"
 #define TYPE_RISCV_CBQRI_BC         "riscv.cbqri.bandwidth"
 
+/* Monitoring counter, one per MCID in both controllers */
+typedef struct RiscvCbqriMonitorCounter {
+    uint64_t ctr_val;
+    int at;
+    int evt_id;
+    bool active;
+} RiscvCbqriMonitorCounter;
+
 /* Capacity Controller hardware capabilities */
 typedef struct RiscvCbqriCapacityCaps {
     uint16_t nb_mcids;

-- 
2.43.0


