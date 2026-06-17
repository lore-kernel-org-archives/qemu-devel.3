Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B095CD98ED
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 23:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa02A-0004R3-PE; Wed, 17 Jun 2026 19:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1wa022-0004Pd-Pl
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 19:50:54 -0400
Received: from p-east2-cluster1-host1-snip4-1.eps.apple.com ([57.103.76.24]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1wa01x-0003vD-Sj
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 19:50:54 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-11 (Postfix) with ESMTPS id
 BDAF41800CD7; Wed, 17 Jun 2026 23:50:41 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ5JHVoHRQNGD1YCWgZLVxQEFVsHVghdEkoXXS1aDhwTVhUTC1NWXxUXG1wAFxlRTQ5YWwhbBA8fTAxRAkIFVl5KDB0EVAddBV1WUAJaS0IES0VoXAVcHEAXSB1faktWFAQVVkNUBF9QVBFXUAtZAkIPSAVcAFkBRQlLAUMFWgZJCFUHQFoDWBFaF1EeWAVyHVxWUAJaVRIEQAhWUF4IXh9MHA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1781740244; x=1784332244; bh=vqknWSCXo8rTtStPNXeiJWu6Ye6zpoLG396fQ+u8jtI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=MQvWCVR9BLiw7kGJq1jK3jWe5/LfBF2v6vvmBRktTyPOP1/n3TSYcJZom7nFQvpUsBYCORmSppFLpHS9kvRdPYhVXeZnsudtIR6mxrGNr5t8iUYmGLAt8pGyOs1t0gI5LRe0hmlnAcrikY2qzWAHD3bTJGzOPkwPf4N6gtYzndBkh0zpB0F+Qo+DTIgENkrY1aR+z2uFfV45Uqwkg++KZvNXGstB5U6eJDYSr9Xdg6VB7kCKFS0DEnaqgcYkgL/a4seqi1bUPCCxfds62m6wGeFH9AVENdoiiTA+LjfGAj5u5qmYs3JtrfeCNzXQ8cS7s52FCuXWt2OHFKyNmHUyDw==
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-11 (Postfix) with ESMTPSA id
 9AFA41800150; Wed, 17 Jun 2026 23:50:40 +0000 (UTC)
From: Matt Jacobson <mhjacobson@me.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Matt Jacobson <mhjacobson@me.com>
Subject: [PATCH v2 3/5] hw/block: add SWIM2 floppy controller for q800
Date: Wed, 17 Jun 2026 19:50:30 -0400
Message-ID: <20260617235032.21491-4-mhjacobson@me.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617235032.21491-1-mhjacobson@me.com>
References: <20260617235032.21491-1-mhjacobson@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xLjML2NAr8GdfDEJqd6xDHAKPhJ7hr8v
X-Proofpoint-GUID: xLjML2NAr8GdfDEJqd6xDHAKPhJ7hr8v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDIyOCBTYWx0ZWRfX5ndMIWmrTU+o
 uioEamMQx0YmO89e7NgFEeThMHbwGncRWqRYHLHqsuEWuABf/0ZJsTsROhit7QXI70dO7bS/D0R
 rEqqpwixeG1hjPpS+uCHCjx7BYq8HxfZtWafzhGCRL/Z2tkv1eVeJCuuQeDMfd6T7zi8bnvQj+K
 Sn34MBQxWBOp3tgL8gZGod2oOfXSuwhkj4dDTuwgH2hXBizIe6XJystHh2m8d0VdoZbQs3NS3H4
 ISLAeyX6No5SSlIx9Yd9u4Oky+BKIXNWAp0pvOK8U77GdoWKeoT1bd6PSvj/D615RBxXzskp9Lk
 I4N/65ruSnHtndTut0M
Received-SPF: pass client-ip=57.103.76.24; envelope-from=mhjacobson@me.com;
 helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The Quadra 800 contains a SWIM2 floppy controller, which is a
simplified revision of the original SWIM controller.  Implement it
based on publicly available specs; a future commit will connect it
to q800.

Signed-off-by: Matt Jacobson <mhjacobson@me.com>
---
 hw/block/meson.build     |   2 +-
 hw/block/swim2.c         | 722 +++++++++++++++++++++++++++++++++++++++
 hw/block/trace-events    |   9 +
 include/hw/block/swim2.h |  60 ++++
 4 files changed, 792 insertions(+), 1 deletion(-)
 create mode 100644 hw/block/swim2.c
 create mode 100644 include/hw/block/swim2.h

diff --git a/hw/block/meson.build b/hw/block/meson.build
index c4b873a906..733e9ffb47 100644
--- a/hw/block/meson.build
+++ b/hw/block/meson.build
@@ -10,7 +10,7 @@ system_ss.add(when: 'CONFIG_PFLASH_CFI01', if_true: files('pflash_cfi01.c'))
 system_ss.add(when: 'CONFIG_PFLASH_CFI02', if_true: files('pflash_cfi02.c'))
 system_ss.add(when: 'CONFIG_SSI_M25P80', if_true: files('m25p80.c'))
 system_ss.add(when: 'CONFIG_SSI_M25P80', if_true: files('m25p80_sfdp.c'))
-system_ss.add(when: 'CONFIG_SWIM', if_true: files('swim.c', 'sony_superdrive.c'))
+system_ss.add(when: 'CONFIG_SWIM', if_true: files('swim.c', 'swim2.c', 'sony_superdrive.c'))
 system_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xen-block.c'))
 
 system_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
diff --git a/hw/block/swim2.c b/hw/block/swim2.c
new file mode 100644
index 0000000000..f10be40678
--- /dev/null
+++ b/hw/block/swim2.c
@@ -0,0 +1,722 @@
+/*
+ * QEMU Macintosh floppy disk controller emulator (SWIM2)
+ *
+ * Copyright (c) 2025 Matt Jacobson <mhjacobson@me.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include <assert.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev.h"
+#include "hw/core/sysbus.h"
+#include "hw/block/sony_superdrive.h"
+#include "hw/block/swim2.h"
+#include "system/block-backend.h"
+#include "system/blockdev.h"
+#include "trace.h"
+
+#define SWIM2_MMIO_SIZE            0x2000
+#define SWIM2_REG_SHIFT            9
+
+#define SWIM2_FIFO_FLAG_MARK       0x01
+
+#define SWIM2_SETUP_INVERT_WRDATA  BIT(0)
+#define SWIM2_SETUP_3_5_OUTPUT     BIT(1)
+#define SWIM2_SETUP_GCR_MODE       BIT(2)
+#define SWIM2_SETUP_CLOCK_DIV_2    BIT(3)
+#define SWIM2_SETUP_TEST_MODE      BIT(4)
+#define SWIM2_SETUP_IBM_DATA_MODE  BIT(5)
+#define SWIM2_SETUP_GCR_WRITES     BIT(6)
+#define SWIM2_SETUP_RESERVED       BIT(7)
+
+#define SWIM2_MODE_CLR_FIFO        BIT(0)
+#define SWIM2_MODE_ENBL1           BIT(1)
+#define SWIM2_MODE_ENBL2           BIT(2)
+#define SWIM2_MODE_ACTION          BIT(3)
+#define SWIM2_MODE_WRITE           BIT(4)
+#define SWIM2_MODE_SIDE            BIT(5)
+#define SWIM2_MODE_ALWAYS1         BIT(6)
+#define SWIM2_MODE_MOTORON         BIT(7)
+
+#define SWIM2_ERROR_UNDERRUN       BIT(0)
+#define SWIM2_ERROR_MARK_IN_DATA   BIT(1)
+#define SWIM2_ERROR_OVERRUN        BIT(2)
+#define SWIM2_ERROR_SHORT          BIT(3)
+#define SWIM2_ERROR_LONG           BIT(4)
+
+/*
+ * These are shifted versions of the "SWIM offsets" in HardwareEqu.a in the
+ * System 7.1 source.
+ */
+typedef enum {
+    SWIM2_REG_DATA = 0,
+    SWIM2_REG_MARK = 1,
+    SWIM2_REG_ERROR = 2,
+    SWIM2_REG_PARAMETER = 3,
+    SWIM2_REG_PHASE = 4,
+    SWIM2_REG_SETUP = 5,
+    SWIM2_REG_WRITE_ZEROES = 6,
+    SWIM2_REG_WRITE_ONES = 7,
+} SWIM2Register;
+
+#define SWIM2_REG_WRITE_CRC  SWIM2_REG_ERROR
+#define SWIM2_REG_STATUS     SWIM2_REG_WRITE_ZEROES
+#define SWIM2_REG_HANDSHAKE  SWIM2_REG_WRITE_ONES
+
+static const char *const swim2_read_reg_names[] = {
+    [SWIM2_REG_DATA] = "DATA",
+    [SWIM2_REG_MARK] = "MARK",
+    [SWIM2_REG_ERROR] = "ERROR",
+    [SWIM2_REG_PARAMETER] = "PARAM",
+    [SWIM2_REG_PHASE] = "PHASE",
+    [SWIM2_REG_SETUP] = "SETUP",
+    [SWIM2_REG_STATUS] = "STATUS",
+    [SWIM2_REG_HANDSHAKE] = "HANDSHAKE",
+};
+
+static const char *const swim2_write_reg_names[] = {
+    [SWIM2_REG_DATA] = "DATA",
+    [SWIM2_REG_MARK] = "MARK",
+    [SWIM2_REG_WRITE_CRC] = "WRITE_CRC",
+    [SWIM2_REG_PARAMETER] = "PARAM",
+    [SWIM2_REG_PHASE] = "PHASE",
+    [SWIM2_REG_SETUP] = "SETUP",
+    [SWIM2_REG_WRITE_ZEROES] = "WRITE0",
+    [SWIM2_REG_WRITE_ONES] = "WRITE1",
+};
+
+static inline const char *swim2_reg_name(const uint8_t reg,
+                                         const bool write)
+{
+    assert(reg < 8);
+    const char *const *table = write ? swim2_write_reg_names :
+                                       swim2_read_reg_names;
+    return table[reg];
+}
+
+static uint32_t swim2_fifo_pack(const uint8_t data, const bool is_mark)
+{
+    return data | (is_mark ? BIT(8) : 0);
+}
+
+static uint8_t swim2_fifo_data(const uint32_t entry)
+{
+    return entry & 0xff;
+}
+
+static bool swim2_fifo_is_mark(const uint32_t entry)
+{
+    return (entry & BIT(8)) != 0;
+}
+
+static void swim2_set_error(SWIM2State *const ctrl, const uint8_t err)
+{
+    const uint8_t prev = ctrl->error_reg;
+    ctrl->error_reg |= err;
+    trace_swim2_error_set(prev, ctrl->error_reg, err, ctrl->mode_reg,
+                          (ctrl->mode_reg & SWIM2_MODE_WRITE) != 0,
+                          fifo32_num_used(&ctrl->fifo));
+}
+
+static void swim2_fifo_clear(SWIM2State *const ctrl)
+{
+    fifo32_reset(&ctrl->fifo);
+    trace_swim2_fifo_clear();
+}
+
+static bool swim2_fifo_push(SWIM2State *const ctrl, const uint8_t data,
+                            const bool is_mark)
+{
+    if (fifo32_is_full(&ctrl->fifo)) {
+        return false;
+    } else {
+        fifo32_push(&ctrl->fifo, swim2_fifo_pack(data, is_mark));
+        trace_swim2_fifo_push(fifo32_num_used(&ctrl->fifo), data, is_mark);
+        return true;
+    }
+}
+
+static bool swim2_fifo_pop(SWIM2State *const ctrl, uint8_t *const data,
+                           bool *const is_mark)
+{
+    if (fifo32_is_empty(&ctrl->fifo)) {
+        trace_swim2_fifo_pop(fifo32_num_used(&ctrl->fifo), 0, false, false);
+        return false;
+    } else {
+        const uint32_t entry = fifo32_pop(&ctrl->fifo);
+        const uint8_t value = swim2_fifo_data(entry);
+        const bool entry_is_mark = swim2_fifo_is_mark(entry);
+
+        *data = value;
+        if (is_mark) {
+            *is_mark = entry_is_mark;
+        }
+
+        trace_swim2_fifo_pop(fifo32_num_used(&ctrl->fifo), value,
+                             entry_is_mark, true);
+        return true;
+    }
+}
+
+static SonyDrive *swim2_active_drive(SWIM2State *const ctrl)
+{
+    uint8_t selected;
+
+    if (ctrl->mode_reg & SWIM2_MODE_ENBL1) {
+        selected = 0;
+    } else if (ctrl->mode_reg & SWIM2_MODE_ENBL2) {
+        selected = 1;
+    } else {
+        return NULL;
+    }
+
+    if (ctrl->drives[selected]) {
+        return &ctrl->drives[selected]->sony;
+    } else {
+        return NULL;
+    }
+}
+
+static void swim2_apply_drive_lines(SWIM2State *const ctrl)
+{
+    SonyDrive *const active = swim2_active_drive(ctrl);
+
+    for (uint8_t i = 0; i < SWIM2_MAX_FD; i++) {
+        SWIM2Drive *const entry = ctrl->drives[i];
+
+        if (!entry) {
+            continue;
+        }
+
+        SonyDrive *const drive = &entry->sony;
+
+        const uint8_t phases = (ctrl->phase_reg & 0xF) &
+                                    (ctrl->phase_reg >> 4);
+        const bool head = (ctrl->mode_reg & SWIM2_MODE_SIDE);
+        const bool enabled = (drive == active) &&
+                             ((ctrl->mode_reg & SWIM2_MODE_MOTORON) != 0);
+
+        sony_drive_set_inputs(drive, phases, head, enabled);
+    }
+}
+
+static void swim2_fill_fifo_from_drive(SWIM2State *const ctrl)
+{
+    SonyDrive *const drive = swim2_active_drive(ctrl);
+
+    if (!drive) {
+        return;
+    }
+
+    /*
+     * Don't wait for a mark byte if the drive is in GCR mode.
+     * A/UX hits this codepath, because it tries to read in MFM mode before
+     * falling back to GCR.
+     */
+    /* TODO: encapsulate drive->gcr_encode better */
+    if (ctrl->wait_for_mark && drive->gcr_encode) {
+        return;
+    }
+
+    while (!fifo32_is_full(&ctrl->fifo)) {
+        uint8_t data;
+        bool is_mark;
+
+        if (!sony_drive_read_byte(drive, &data, &is_mark)) {
+            break;
+        } else if (!ctrl->wait_for_mark || is_mark) {
+            ctrl->wait_for_mark = false;
+            const bool did_push = swim2_fifo_push(ctrl, data, is_mark);
+            assert(did_push);
+        }
+    }
+}
+
+static void swim2_push_fifo_to_drive(SWIM2State *const ctrl)
+{
+    SonyDrive *const drive = swim2_active_drive(ctrl);
+
+    if (!drive) {
+        /*
+         * The Mac ROM does this to measure how quickly we can spit bytes out
+         * to a drive.  Just consume the FIFO without error.
+         */
+        swim2_fifo_clear(ctrl);
+    } else {
+        uint8_t data;
+        bool is_mark;
+
+        while (swim2_fifo_pop(ctrl, &data, &is_mark)) {
+            if (ctrl->wait_for_mark && is_mark) {
+                ctrl->wait_for_mark = false;
+            } else if (!ctrl->wait_for_mark && !is_mark) {
+                sony_drive_write_byte(drive, data);
+            }
+        }
+    }
+}
+
+static void swim2_update_mode(SWIM2State *const ctrl, const uint8_t mask,
+                              const bool set_bits)
+{
+    const uint8_t prev_mode = ctrl->mode_reg;
+
+    if (set_bits) {
+        ctrl->mode_reg |= mask;
+    } else {
+        ctrl->mode_reg &= ~mask;
+        ctrl->mode_reg |= SWIM2_MODE_ALWAYS1;
+    }
+
+    if (!set_bits) {
+        ctrl->parameter_index = 0;
+    }
+
+    if ((mask & SWIM2_MODE_CLR_FIFO) && set_bits) {
+        swim2_fifo_clear(ctrl);
+    }
+
+    swim2_apply_drive_lines(ctrl);
+
+    const bool prev_action = prev_mode & SWIM2_MODE_ACTION;
+    const bool action = ctrl->mode_reg & SWIM2_MODE_ACTION;
+
+    if (!prev_action && action) {
+        ctrl->did_handshake = false;
+        ctrl->wait_for_mark = !(ctrl->setup_reg & SWIM2_SETUP_GCR_MODE);
+
+        if (ctrl->mode_reg & SWIM2_MODE_WRITE) {
+            swim2_push_fifo_to_drive(ctrl);
+        } else {
+            swim2_fill_fifo_from_drive(ctrl);
+        }
+    }
+}
+
+static void swim2_handle_phase_write(SWIM2State *const ctrl,
+                                     const uint8_t value)
+{
+    ctrl->phase_reg = value;
+    swim2_apply_drive_lines(ctrl);
+}
+
+static void swim2_handle_setup_write(SWIM2State *const ctrl,
+                                     const uint8_t value)
+{
+    ctrl->setup_reg = value;
+}
+
+/*
+ * We don't actually do anything with these parameter values other than store
+ * them.
+ */
+static void swim2_handle_parameter_write(SWIM2State *const ctrl,
+                                         const uint8_t value)
+{
+    ctrl->parameter_data[ctrl->parameter_index] = value;
+    ctrl->parameter_index = (ctrl->parameter_index + 1) & 0x3;
+}
+
+static uint8_t swim2_handle_parameter_read(SWIM2State *const ctrl)
+{
+    uint8_t value;
+
+    /* Return 0 for parameters 1 and 3, as A/UX expects for a SWIM2. */
+    if (ctrl->parameter_index == 1 || ctrl->parameter_index == 3) {
+        value = 0;
+    } else {
+        value = ctrl->parameter_data[ctrl->parameter_index];
+    }
+
+    ctrl->parameter_index = (ctrl->parameter_index + 1) & 0x3;
+    return value;
+}
+
+static uint8_t swim2_handle_handshake_read(SWIM2State *const ctrl)
+{
+    SonyDrive *const drive = swim2_active_drive(ctrl);
+
+    ctrl->did_handshake = true;
+
+    const bool empty = fifo32_is_empty(&ctrl->fifo);
+    const bool full = fifo32_is_full(&ctrl->fifo);
+    const bool error = ctrl->error_reg != 0;
+    const bool sense = drive ? sony_drive_read_sense(drive) : true;
+    const bool mark_next = !empty &&
+                           swim2_fifo_is_mark(fifo32_peek(&ctrl->fifo));
+
+    uint8_t value = 0;
+    if (mark_next) {
+        value |= BIT(0);
+    }
+    /* bit 1: 1 when invalid CRC (i.e., never, for us) */
+    /* bit 2: rddata, not emulated */
+    if (sense) {
+        value |= BIT(3);
+    }
+    /* bit 4: unused */
+    if (error) {
+        value |= BIT(5);
+    }
+
+    if ((ctrl->mode_reg & SWIM2_MODE_WRITE) != 0) {
+        if (empty) {
+            value |= BIT(6);
+        }
+
+        if (!full || error) {
+            value |= BIT(7);
+        }
+    } else {
+        if (full) {
+            value |= BIT(6);
+        }
+
+        if (!empty) {
+            value |= BIT(7);
+        }
+    }
+
+    return value;
+}
+
+static uint64_t swim2_read(void *const opaque, const hwaddr addr,
+                           const unsigned int size)
+{
+    SWIM2State *const ctrl = SWIM2(opaque);
+    const uint8_t reg = (addr >> SWIM2_REG_SHIFT) & 0x7;
+    uint8_t value = 0xff;
+
+    switch (reg) {
+    case SWIM2_REG_DATA: {
+        bool is_mark;
+
+        if (!swim2_fifo_pop(ctrl, &value, &is_mark)) {
+            value = 0xff;
+            swim2_set_error(ctrl, SWIM2_ERROR_OVERRUN);
+        } else {
+            if (is_mark) {
+                swim2_set_error(ctrl, SWIM2_ERROR_MARK_IN_DATA);
+            }
+
+            swim2_fill_fifo_from_drive(ctrl);
+        }
+
+        break;
+    }
+    case SWIM2_REG_MARK: {
+        /*
+         * Allow reading data bytes from here; the specs seem unclear on whether
+         * this is allowed, but the Mac Sony driver does so.
+         */
+
+        if (!ctrl->did_handshake) {
+            /*
+             * The Mac ROM does something weird when reading an MFM disk.
+             * Immediately after setting ACTION, it pulls and discards two bytes
+             * from MARK.  To avoid needing to emulate this with timing,
+             * simply detect the reads that are not preceded by a HANDSHAKE
+             * and give back the garbage they seem to expect.
+             */
+            value = 0xff;
+        } else if (!swim2_fifo_pop(ctrl, &value, NULL)) {
+            value = 0xff;
+            swim2_set_error(ctrl, SWIM2_ERROR_OVERRUN);
+        } else {
+            swim2_fill_fifo_from_drive(ctrl);
+        }
+
+        break;
+    }
+    case SWIM2_REG_ERROR:
+        value = ctrl->error_reg;
+        ctrl->error_reg = 0;
+        break;
+    case SWIM2_REG_PARAMETER:
+        value = swim2_handle_parameter_read(ctrl);
+        break;
+    case SWIM2_REG_PHASE:
+        value = ctrl->phase_reg;
+        break;
+    case SWIM2_REG_SETUP:
+        value = ctrl->setup_reg;
+        break;
+    case SWIM2_REG_STATUS:
+        value = ctrl->mode_reg;
+        break;
+    case SWIM2_REG_HANDSHAKE:
+        value = swim2_handle_handshake_read(ctrl);
+        break;
+    default:
+        value = 0xff;
+        break;
+    }
+
+    trace_swim2_mmio_read(addr, size, reg, swim2_reg_name(reg, false), value,
+                          ctrl->mode_reg, ctrl->setup_reg, ctrl->phase_reg,
+                          fifo32_num_used(&ctrl->fifo));
+    return value;
+}
+
+static void swim2_write(void *const opaque, const hwaddr addr,
+                        const uint64_t data, const unsigned int size)
+{
+    SWIM2State *const ctrl = SWIM2(opaque);
+    const uint8_t reg = (addr >> SWIM2_REG_SHIFT) & 0x7;
+    const uint8_t value = data & 0xff;
+
+    switch (reg) {
+    case SWIM2_REG_DATA:
+        if (!swim2_fifo_push(ctrl, value, 0)) {
+            swim2_set_error(ctrl, SWIM2_ERROR_OVERRUN);
+        } else if ((ctrl->mode_reg & SWIM2_MODE_ACTION)) {
+            swim2_push_fifo_to_drive(ctrl);
+        }
+        break;
+    case SWIM2_REG_MARK:
+        if (!swim2_fifo_push(ctrl, value, SWIM2_FIFO_FLAG_MARK)) {
+            swim2_set_error(ctrl, SWIM2_ERROR_OVERRUN);
+        } else if ((ctrl->mode_reg & SWIM2_MODE_ACTION)) {
+            swim2_push_fifo_to_drive(ctrl);
+        }
+        break;
+    case SWIM2_REG_WRITE_CRC:
+        /* Nothing to do. */
+        break;
+    case SWIM2_REG_PARAMETER:
+        swim2_handle_parameter_write(ctrl, value);
+        break;
+    case SWIM2_REG_PHASE:
+        swim2_handle_phase_write(ctrl, value);
+        break;
+    case SWIM2_REG_SETUP:
+        swim2_handle_setup_write(ctrl, value);
+        break;
+    case SWIM2_REG_WRITE_ZEROES:
+        swim2_update_mode(ctrl, value, false);
+        break;
+    case SWIM2_REG_WRITE_ONES:
+        swim2_update_mode(ctrl, value, true);
+        break;
+    default:
+        break;
+    }
+
+    trace_swim2_mmio_write(addr, size, reg, swim2_reg_name(reg, true), value,
+                           ctrl->mode_reg, ctrl->setup_reg, ctrl->phase_reg,
+                           fifo32_num_used(&ctrl->fifo));
+}
+
+void swim2_set_sel(SWIM2State *ctrl, bool sel)
+{
+    trace_swim2_set_sel(sel);
+    if (sel) {
+        ctrl->mode_reg |= SWIM2_MODE_SIDE;
+    } else {
+        ctrl->mode_reg &= ~SWIM2_MODE_SIDE;
+    }
+    swim2_apply_drive_lines(ctrl);
+}
+
+static const MemoryRegionOps swim2_mmio_ops = {
+    .read = swim2_read,
+    .write = swim2_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void swim2_change_cb(void *const opaque, const bool load,
+                            Error **const errp)
+{
+    SWIM2Drive *const drive = opaque;
+
+    if (!load) {
+        blk_set_perm(drive->conf.blk, 0, BLK_PERM_ALL, &error_abort);
+    } else if (!blkconf_apply_backend_options(&drive->conf,
+                 !blk_supports_write_perm(drive->conf.blk), false, errp)) {
+        return;
+    }
+
+    sony_drive_set_block_backend(&drive->sony, drive->conf.blk);
+}
+
+static void swim2_drive_realize(DeviceState *const dev, Error **const errp)
+{
+    SWIM2Drive *const drive = SWIM2_DRIVE(dev);
+    SWIM2State *const ctrl = SWIM2(dev->parent_bus->parent);
+
+    if (!drive->conf.blk) {
+        drive->conf.blk = blk_new(qemu_get_aio_context(), 0, BLK_PERM_ALL);
+        const int ret = blk_attach_dev(drive->conf.blk, dev);
+        assert(ret == 0);
+    }
+
+    if (drive->unit < 0 || drive->unit >= SWIM2_MAX_FD) {
+        error_setg(errp, "unit %d out of range (0-%d)", drive->unit,
+                   SWIM2_MAX_FD - 1);
+        return;
+    }
+
+    if (ctrl->drives[drive->unit]) {
+        error_setg(errp, "floppy unit %d already in use", drive->unit);
+        return;
+    }
+
+    if (!blkconf_blocksizes(&drive->conf, errp)) {
+        /* errp set by blkconf_blocksizes(). */
+        return;
+    }
+
+    if (drive->conf.logical_block_size  != 512 ||
+        drive->conf.physical_block_size != 512) {
+        error_setg(errp, "physical and logical block size must be 512 for"
+                   " floppy");
+        return;
+    }
+
+    drive->conf.rerror = BLOCKDEV_ON_ERROR_AUTO;
+    drive->conf.werror = BLOCKDEV_ON_ERROR_AUTO;
+
+    if (!blkconf_apply_backend_options(&drive->conf,
+          !blk_supports_write_perm(drive->conf.blk), false, errp)) {
+        /* errp set by blkconf_apply_backend_options(). */
+        return;
+    }
+
+    if (blk_get_on_error(drive->conf.blk, 0) != BLOCKDEV_ON_ERROR_ENOSPC &&
+        blk_get_on_error(drive->conf.blk, 0) != BLOCKDEV_ON_ERROR_REPORT) {
+        error_setg(errp, "SWIM2 doesn't support drive option werror");
+        return;
+    }
+
+    if (blk_get_on_error(drive->conf.blk, 1) != BLOCKDEV_ON_ERROR_REPORT) {
+        error_setg(errp, "SWIM2 doesn't support drive option rerror");
+        return;
+    }
+
+    ctrl->drives[drive->unit] = drive;
+    sony_drive_set_block_backend(&drive->sony, drive->conf.blk);
+
+    static const BlockDevOps swim2_block_ops = {
+        .change_media_cb = swim2_change_cb,
+    };
+    blk_set_dev_ops(drive->conf.blk, &swim2_block_ops, drive);
+}
+
+static void swim2_init(Object *const obj)
+{
+    SWIM2State *const ctrl = SWIM2(obj);
+
+    memory_region_init_io(&ctrl->mmio, obj, &swim2_mmio_ops, ctrl,
+                          "swim2", SWIM2_MMIO_SIZE);
+    sysbus_init_mmio(&ctrl->parent_obj, &ctrl->mmio);
+
+    for (int i = 0; i < SWIM2_MAX_FD; i++) {
+        ctrl->drives[i] = NULL;
+    }
+
+    memset(ctrl->parameter_data, 0, sizeof ctrl->parameter_data);
+    ctrl->parameter_index = 0;
+    ctrl->phase_reg = 0;
+    ctrl->setup_reg = 0;
+    ctrl->mode_reg = SWIM2_MODE_ALWAYS1;
+    ctrl->error_reg = 0;
+    ctrl->wait_for_mark = false;
+    fifo32_create(&ctrl->fifo, 2);
+    swim2_fifo_clear(ctrl);
+}
+
+static void swim2_finalize(Object *const obj)
+{
+    SWIM2State *const ctrl = SWIM2(obj);
+
+    fifo32_destroy(&ctrl->fifo);
+}
+
+static void swim2_realize(DeviceState *const dev, Error **const errp)
+{
+    SWIM2State *const ctrl = SWIM2(dev);
+    ctrl->bus = qbus_new(TYPE_SWIM2_BUS, dev, "SWIM2 dummy bus");
+
+    for (int unit = 0; unit < SWIM2_MAX_FD; unit++) {
+        DriveInfo *const dinfo = drive_get(IF_FLOPPY, 0, unit);
+
+        if (dinfo) {
+            DeviceState *const drive = qdev_new(TYPE_SWIM2_DRIVE);
+            qdev_prop_set_int32(drive, "unit", unit);
+            qdev_prop_set_drive_err(drive, "drive",
+                                    blk_by_legacy_dinfo(dinfo), &error_abort);
+            qdev_realize_and_unref(drive, ctrl->bus, &error_abort);
+        }
+    }
+}
+
+/* TODO: support migration */
+static void swim2_class_init(ObjectClass *const oc, const void *const opaque)
+{
+    DeviceClass *const dc = DEVICE_CLASS(oc);
+    dc->realize = swim2_realize;
+    dc->desc = "Apple Macintosh SWIM2 floppy diskette drive controller";
+}
+
+static void swim2_bus_class_init(ObjectClass *const oc,
+                                 const void *const opaque)
+{
+    BusClass *const bc = BUS_CLASS(oc);
+    bc->max_dev = 2;
+}
+
+/* TODO: support migration */
+static void swim2_drive_class_init(ObjectClass *const oc,
+                                   const void *const opaque)
+{
+    DeviceClass *const dc = DEVICE_CLASS(oc);
+    dc->bus_type = TYPE_SWIM2_BUS;
+    dc->realize = swim2_drive_realize;
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+
+    static const Property swim2_drive_properties[] = {
+        DEFINE_BLOCK_PROPERTIES(SWIM2Drive, conf),
+        DEFINE_PROP_INT32("unit", SWIM2Drive, unit, -1),
+    };
+    device_class_set_props(dc, swim2_drive_properties);
+
+    dc->desc = "Apple Macintosh SuperDrive floppy diskette drive";
+}
+
+static const TypeInfo swim2_info = {
+    .name = TYPE_SWIM2,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(SWIM2State),
+    .instance_init = swim2_init,
+    .instance_finalize = swim2_finalize,
+    .class_init = swim2_class_init,
+};
+
+static const TypeInfo swim2_bus_info = {
+    .name = TYPE_SWIM2_BUS,
+    .parent = TYPE_BUS,
+    .instance_size = 0,
+    .class_init = swim2_bus_class_init,
+};
+
+static const TypeInfo swim2_drive_info = {
+    .name = TYPE_SWIM2_DRIVE,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(SWIM2Drive),
+    .class_init = swim2_drive_class_init,
+};
+
+static void swim2_register_types(void)
+{
+    type_register_static(&swim2_info);
+    type_register_static(&swim2_bus_info);
+    type_register_static(&swim2_drive_info);
+}
+
+type_init(swim2_register_types)
diff --git a/hw/block/trace-events b/hw/block/trace-events
index c9eb62bcaa..92d4bd9f17 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -102,6 +102,15 @@ swim_iwmctrl_write(int reg, const char *name, unsigned size, uint64_t value) "re
 swim_switch_to_ism(void) "switch from IWM to ISM mode"
 swim_switch_to_iwm(void) "switch from ISM to IWM mode"
 
+# swim2.c
+swim2_mmio_read(uint64_t addr, unsigned size, int reg, const char *name, uint64_t value, uint8_t mode, uint8_t setup, uint8_t phase, uint32_t fifo_count) "addr=0x%"PRIx64" size=%u reg=%d [%s] value=0x%"PRIx64" mode=0x%02x setup=0x%02x phase=0x%02x fifo=%u"
+swim2_mmio_write(uint64_t addr, unsigned size, int reg, const char *name, uint64_t value, uint8_t mode, uint8_t setup, uint8_t phase, uint32_t fifo_count) "addr=0x%"PRIx64" size=%u reg=%d [%s] value=0x%"PRIx64" mode=0x%02x setup=0x%02x phase=0x%02x fifo=%u"
+swim2_fifo_push(uint32_t count, uint8_t data, uint8_t flags) "fifo=%u data=0x%02x flags=0x%02x"
+swim2_fifo_pop(uint32_t count, uint8_t data, uint8_t flags, bool success) "fifo=%u data=0x%02x flags=0x%02x success=%d"
+swim2_fifo_clear(void) "clear FIFO"
+swim2_set_sel(bool sel) "set sel=%d"
+swim2_error_set(uint8_t prev, uint8_t curr, uint8_t new_err, uint8_t mode, bool write_mode, uint32_t fifo_count) "prev=0x%02x curr=0x%02x new=0x%02x mode=0x%02x write=%d fifo=%u"
+
 # sony_superdrive.c
 sony_drive_prepare(void *drive, uint8_t track, uint8_t head, uint8_t sector, bool gcr, uint16_t payload_len) "drive=%p track=%"PRIu8" head=%"PRIu8" sector=%"PRIu8" gcr=%d length=%"PRIu16
 sony_drive_persist(void *drive, uint64_t lba) "drive=%p lba=0x%"PRIx64
diff --git a/include/hw/block/swim2.h b/include/hw/block/swim2.h
new file mode 100644
index 0000000000..72be21ea4e
--- /dev/null
+++ b/include/hw/block/swim2.h
@@ -0,0 +1,60 @@
+/*
+ * QEMU Macintosh floppy disk controller emulator (SWIM2)
+ *
+ * Copyright (c) 2025 Matt Jacobson <mhjacobson@me.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_BLOCK_SWIM2_H
+#define HW_BLOCK_SWIM2_H
+
+#include <stdbool.h>
+#include <stdint.h>
+#include "hw/core/qdev.h"
+#include "hw/core/sysbus.h"
+#include "hw/block/block.h"
+#include "hw/block/sony_superdrive.h"
+#include "qemu/fifo32.h"
+#include "qom/object.h"
+
+#define TYPE_SWIM2 "swim2"
+#define TYPE_SWIM2_BUS "swim2-bus"
+#define TYPE_SWIM2_DRIVE "swim2-drive"
+
+OBJECT_DECLARE_SIMPLE_TYPE(SWIM2State, SWIM2)
+OBJECT_DECLARE_SIMPLE_TYPE(SWIM2Drive, SWIM2_DRIVE)
+
+#define SWIM2_MAX_FD 2
+
+struct SWIM2Drive {
+    DeviceState parent_obj;
+
+    BlockConf conf;
+    SonyDrive sony;
+    int32_t unit;
+};
+
+struct SWIM2State {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    BusState *bus;
+
+    SWIM2Drive *drives[SWIM2_MAX_FD];
+
+    uint8_t parameter_data[4];
+    uint8_t parameter_index;
+    uint8_t phase_reg;
+    uint8_t setup_reg;
+    uint8_t mode_reg;
+    uint8_t error_reg;
+    bool did_handshake;
+    bool wait_for_mark;
+
+    Fifo32 fifo;
+};
+
+void swim2_set_sel(SWIM2State *ctrl, bool sel);
+
+#endif /* HW_BLOCK_SWIM2_H */
-- 
2.53.0


