Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0581DE83063
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 08:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnCB4-0006DH-FF; Tue, 03 Feb 2026 03:54:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vnCAb-0005OJ-P4; Tue, 03 Feb 2026 03:54:05 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vnCAX-0003Po-Vb; Tue, 03 Feb 2026 03:54:01 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 3 Feb
 2026 16:52:37 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 3 Feb 2026 16:52:37 +0800
To: <komlodi@google.com>, <nabihestefan@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "open list:All
 patches CC here" <qemu-devel@nongnu.org>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>, Titus Rwantare <titusr@google.com>, "Patrick
 Venture" <venture@google.com>
Subject: [PATCH v2 17/20] hw/i3c: Add Mock target
Date: Tue, 3 Feb 2026 16:52:17 +0800
Message-ID: <20260203085229.1543287-18-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203085229.1543287-1-jamin_lin@aspeedtech.com>
References: <20260203085229.1543287-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Joe Komlodi <komlodi@google.com>

Adds a simple i3c device to be used for testing in lieu of a real
device.

The mock target supports the following features:
- A buffer that users can read and write to.
- CCC support for commonly used CCCs when probing devices on an I3C bus.
- IBI sending upon receiving a user-defined byte.

Signed-off-by: Joe Komlodi <komlodi@google.com>

Reviewed-by: Titus Rwantare <titusr@google.com>
Reviewed-by: Patrick Venture <venture@google.com>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/i3c/mock-i3c-target.h |  52 ++++++
 hw/i3c/mock-i3c-target.c         | 311 +++++++++++++++++++++++++++++++
 hw/i3c/Kconfig                   |  10 +
 hw/i3c/meson.build               |   1 +
 hw/i3c/trace-events              |   9 +
 5 files changed, 383 insertions(+)
 create mode 100644 include/hw/i3c/mock-i3c-target.h
 create mode 100644 hw/i3c/mock-i3c-target.c

diff --git a/include/hw/i3c/mock-i3c-target.h b/include/hw/i3c/mock-i3c-target.h
new file mode 100644
index 0000000000..7ac55a3179
--- /dev/null
+++ b/include/hw/i3c/mock-i3c-target.h
@@ -0,0 +1,52 @@
+#ifndef MOCK_I3C_TARGET_H_
+#define MOCK_I3C_TARGET_H_
+
+/*
+ * Mock I3C Device
+ *
+ * Copyright (c) 2025 Google LLC
+ *
+ * The mock I3C device can be thought of as a simple EEPROM. It has a buffer,
+ * and the pointer in the buffer is reset to 0 on an I3C STOP.
+ * To write to the buffer, issue a private write and send data.
+ * To read from the buffer, issue a private read.
+ *
+ * The mock target also supports sending target interrupt IBIs.
+ * To issue an IBI, set the 'ibi-magic-num' property to a non-zero number, and
+ * send that number in a private transaction. The mock target will issue an IBI
+ * after 1 second.
+ *
+ * It also supports a handful of CCCs that are typically used when probing I3C
+ * devices.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/timer.h"
+#include "hw/i3c/i3c.h"
+
+#define TYPE_MOCK_I3C_TARGET "mock-i3c-target"
+OBJECT_DECLARE_SIMPLE_TYPE(MockI3cTargetState, MOCK_I3C_TARGET)
+
+struct MockI3cTargetState {
+    I3CTarget i3c;
+
+    /* General device state */
+    bool can_ibi;
+    QEMUTimer qtimer;
+    size_t p_buf;
+    uint8_t *buf;
+
+    /* For Handing CCCs. */
+    bool in_ccc;
+    I3CCCC curr_ccc;
+    uint8_t ccc_byte_offset;
+
+    struct {
+        uint32_t buf_size;
+        uint8_t ibi_magic;
+    } cfg;
+};
+
+#endif
diff --git a/hw/i3c/mock-i3c-target.c b/hw/i3c/mock-i3c-target.c
new file mode 100644
index 0000000000..e540a6c2f7
--- /dev/null
+++ b/hw/i3c/mock-i3c-target.c
@@ -0,0 +1,311 @@
+/*
+ * Mock I3C Device
+ *
+ * Copyright (c) 2025 Google LLC
+ *
+ * The mock I3C device can be thought of as a simple EEPROM. It has a buffer,
+ * and the pointer in the buffer is reset to 0 on an I3C STOP.
+ * To write to the buffer, issue a private write and send data.
+ * To read from the buffer, issue a private read.
+ *
+ * The mock target also supports sending target interrupt IBIs.
+ * To issue an IBI, set the 'ibi-magic-num' property to a non-zero number, and
+ * send that number in a private transaction. The mock target will issue an IBI
+ * after 1 second.
+ *
+ * It also supports a handful of CCCs that are typically used when probing I3C
+ * devices.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "trace.h"
+#include "hw/i3c/i3c.h"
+#include "hw/i3c/mock-i3c-target.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+
+#ifndef MOCK_I3C_TARGET_DEBUG
+#define MOCK_I3C_TARGET_DEBUG 0
+#endif
+
+#define DB_PRINTF(...) do { \
+        if (MOCK_I3C_TARGET_DEBUG) { \
+            qemu_log("%s: ", __func__); \
+            qemu_log(__VA_ARGS__); \
+        } \
+    } while (0)
+
+#define IBI_DELAY_NS (1 * 1000 * 1000)
+
+static uint32_t mock_i3c_target_rx(I3CTarget *i3c, uint8_t *data,
+                                   uint32_t num_to_read)
+{
+    MockI3cTargetState *s = MOCK_I3C_TARGET(i3c);
+    uint32_t i;
+
+    /* Bounds check. */
+    if (s->p_buf == s->cfg.buf_size) {
+        return 0;
+    }
+
+    for (i = 0; i < num_to_read; i++) {
+        data[i] = s->buf[s->p_buf];
+        trace_mock_i3c_target_rx(data[i]);
+        s->p_buf++;
+        if (s->p_buf == s->cfg.buf_size) {
+            break;
+        }
+    }
+
+    /* Return the number of bytes we're sending to the controller. */
+    return i;
+}
+
+static void mock_i3c_target_ibi_timer_start(MockI3cTargetState *s)
+{
+    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    timer_mod(&s->qtimer, now + IBI_DELAY_NS);
+}
+
+static int mock_i3c_target_tx(I3CTarget *i3c, const uint8_t *data,
+                              uint32_t num_to_send, uint32_t *num_sent)
+{
+    MockI3cTargetState *s = MOCK_I3C_TARGET(i3c);
+    int ret;
+    uint32_t to_write;
+
+    if (s->cfg.ibi_magic && num_to_send == 1 && s->cfg.ibi_magic == *data) {
+        mock_i3c_target_ibi_timer_start(s);
+        return 0;
+    }
+
+    /* Bounds check. */
+    if (num_to_send + s->p_buf > s->cfg.buf_size) {
+        to_write = s->cfg.buf_size - s->p_buf;
+        ret = -1;
+    } else {
+        to_write = num_to_send;
+        ret = 0;
+    }
+    for (uint32_t i = 0; i < to_write; i++) {
+        trace_mock_i3c_target_tx(data[i]);
+        s->buf[s->p_buf] = data[i];
+        s->p_buf++;
+    }
+    return ret;
+}
+
+static int mock_i3c_target_event(I3CTarget *i3c, enum I3CEvent event)
+{
+    MockI3cTargetState *s = MOCK_I3C_TARGET(i3c);
+
+    trace_mock_i3c_target_event(event);
+    if (event == I3C_STOP) {
+        s->in_ccc = false;
+        s->curr_ccc = 0;
+        s->ccc_byte_offset = 0;
+        s->p_buf = 0;
+    }
+
+    return 0;
+}
+
+static int mock_i3c_target_handle_ccc_read(I3CTarget *i3c, uint8_t *data,
+                                           uint32_t num_to_read,
+                                           uint32_t *num_read)
+{
+    MockI3cTargetState *s = MOCK_I3C_TARGET(i3c);
+
+    switch (s->curr_ccc) {
+    case I3C_CCCD_GETMXDS:
+        /* Default data rate for I3C. */
+        while (s->ccc_byte_offset < num_to_read) {
+            if (s->ccc_byte_offset >= 2) {
+                break;
+            }
+            data[s->ccc_byte_offset] = 0;
+            *num_read = s->ccc_byte_offset;
+            s->ccc_byte_offset++;
+        }
+        break;
+    case I3C_CCCD_GETCAPS:
+        /* Support I3C version 1.1.x, no other features. */
+        while (s->ccc_byte_offset < num_to_read) {
+            if (s->ccc_byte_offset >= 2) {
+                break;
+            }
+            if (s->ccc_byte_offset == 0) {
+                data[s->ccc_byte_offset] = 0;
+            } else {
+                data[s->ccc_byte_offset] = 0x01;
+            }
+            *num_read = s->ccc_byte_offset;
+            s->ccc_byte_offset++;
+        }
+        break;
+    case I3C_CCCD_GETMWL:
+    case I3C_CCCD_GETMRL:
+        /* MWL/MRL is MSB first. */
+        while (s->ccc_byte_offset < num_to_read) {
+            if (s->ccc_byte_offset >= 2) {
+                break;
+            }
+            data[s->ccc_byte_offset] = (s->cfg.buf_size &
+                                        (0xff00 >> (s->ccc_byte_offset * 8))) >>
+                                        (8 - (s->ccc_byte_offset * 8));
+            s->ccc_byte_offset++;
+            *num_read = num_to_read;
+        }
+        break;
+    case I3C_CCC_ENTDAA:
+    case I3C_CCCD_GETPID:
+    case I3C_CCCD_GETBCR:
+    case I3C_CCCD_GETDCR:
+        /* Nothing to do. */
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "Unhandled CCC 0x%.2x\n", s->curr_ccc);
+        return -1;
+    }
+
+    trace_mock_i3c_target_handle_ccc_read(*num_read, num_to_read);
+    return 0;
+}
+
+static int mock_i3c_target_handle_ccc_write(I3CTarget *i3c, const uint8_t *data,
+                                            uint32_t num_to_send,
+                                            uint32_t *num_sent)
+{
+    MockI3cTargetState *s = MOCK_I3C_TARGET(i3c);
+
+    if (!s->curr_ccc) {
+        s->in_ccc = true;
+        s->curr_ccc = *data;
+        trace_mock_i3c_target_new_ccc(s->curr_ccc);
+    }
+
+    *num_sent = 1;
+    switch (s->curr_ccc) {
+    case I3C_CCC_ENEC:
+    case I3C_CCCD_ENEC:
+        s->can_ibi = true;
+        break;
+    case I3C_CCC_DISEC:
+    case I3C_CCCD_DISEC:
+        s->can_ibi = false;
+        break;
+    case I3C_CCC_ENTDAA:
+    case I3C_CCC_SETAASA:
+    case I3C_CCC_RSTDAA:
+    case I3C_CCCD_SETDASA:
+    case I3C_CCCD_GETPID:
+    case I3C_CCCD_GETBCR:
+    case I3C_CCCD_GETDCR:
+    case I3C_CCCD_GETMWL:
+    case I3C_CCCD_GETMRL:
+    case I3C_CCCD_GETMXDS:
+    case I3C_CCCD_GETCAPS:
+        /* Nothing to do. */
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "Unhandled CCC 0x%.2x\n", s->curr_ccc);
+        return -1;
+    }
+
+    trace_mock_i3c_target_handle_ccc_write(*num_sent, num_to_send);
+    return 0;
+}
+
+static void mock_i3c_target_do_ibi(MockI3cTargetState *s)
+{
+    if (!s->can_ibi) {
+        DB_PRINTF("IBIs disabled by controller");
+        return;
+    }
+
+    trace_mock_i3c_target_do_ibi(s->i3c.address, true);
+    int nack = i3c_target_send_ibi(&s->i3c, s->i3c.address, /*is_recv=*/true);
+    /* Getting NACKed isn't necessarily an error, just print it out. */
+    if (nack) {
+        DB_PRINTF("NACKed from controller when sending target interrupt.\n");
+    }
+    nack = i3c_target_ibi_finish(&s->i3c, 0x00);
+    if (nack) {
+        DB_PRINTF("NACKed from controller when finishing target interrupt.\n");
+    }
+}
+
+static void mock_i3c_target_timer_elapsed(void *opaque)
+{
+    MockI3cTargetState *s = MOCK_I3C_TARGET(opaque);
+    timer_del(&s->qtimer);
+    mock_i3c_target_do_ibi(s);
+}
+
+static void mock_i3c_target_reset(I3CTarget *i3c)
+{
+    MockI3cTargetState *s = MOCK_I3C_TARGET(i3c);
+    s->can_ibi = false;
+}
+
+static void mock_i3c_target_realize(DeviceState *dev, Error **errp)
+{
+    MockI3cTargetState *s = MOCK_I3C_TARGET(dev);
+    s->buf = g_new0(uint8_t, s->cfg.buf_size);
+    mock_i3c_target_reset(&s->i3c);
+}
+
+static void mock_i3c_target_init(Object *obj)
+{
+    MockI3cTargetState *s = MOCK_I3C_TARGET(obj);
+    s->can_ibi = false;
+
+    /* For IBIs. */
+    timer_init_ns(&s->qtimer, QEMU_CLOCK_VIRTUAL, mock_i3c_target_timer_elapsed,
+                  s);
+}
+
+static const Property remote_i3c_props[] = {
+    /* The size of the internal buffer. */
+    DEFINE_PROP_UINT32("buf-size", MockI3cTargetState, cfg.buf_size, 0x100),
+    /*
+     * If the mock target receives this number, it will issue an IBI after
+     * 1 second. Disabled if the IBI magic number is 0.
+     */
+    DEFINE_PROP_UINT8("ibi-magic-num", MockI3cTargetState, cfg.ibi_magic, 0x00),
+};
+
+static void mock_i3c_target_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    I3CTargetClass *k = I3C_TARGET_CLASS(klass);
+
+    dc->realize = mock_i3c_target_realize;
+    k->event = mock_i3c_target_event;
+    k->recv = mock_i3c_target_rx;
+    k->send = mock_i3c_target_tx;
+    k->handle_ccc_read = mock_i3c_target_handle_ccc_read;
+    k->handle_ccc_write = mock_i3c_target_handle_ccc_write;
+
+    device_class_set_props(dc, remote_i3c_props);
+}
+
+static const TypeInfo mock_i3c_target_info = {
+    .name          = TYPE_MOCK_I3C_TARGET,
+    .parent        = TYPE_I3C_TARGET,
+    .instance_size = sizeof(MockI3cTargetState),
+    .instance_init = mock_i3c_target_init,
+    .class_init    = mock_i3c_target_class_init,
+};
+
+static void mock_i3c_target_register_types(void)
+{
+    type_register_static(&mock_i3c_target_info);
+}
+
+type_init(mock_i3c_target_register_types)
diff --git a/hw/i3c/Kconfig b/hw/i3c/Kconfig
index ecec77d6fc..d5c6d4049b 100644
--- a/hw/i3c/Kconfig
+++ b/hw/i3c/Kconfig
@@ -3,3 +3,13 @@ config I3C
 
 config DW_I3C
     bool
+
+config I3C_DEVICES
+    # Device group for i3c devices which can reasonably be user-plugged to any
+    # board's i3c bus.
+    bool
+
+config MOCK_I3C_TARGET
+    bool
+    select I3C
+    default y if I3C_DEVICES
diff --git a/hw/i3c/meson.build b/hw/i3c/meson.build
index 83d75e7d5c..e614b18712 100644
--- a/hw/i3c/meson.build
+++ b/hw/i3c/meson.build
@@ -2,4 +2,5 @@ i3c_ss = ss.source_set()
 i3c_ss.add(when: 'CONFIG_I3C', if_true: files('core.c'))
 i3c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i3c.c'))
 i3c_ss.add(when: 'CONFIG_DW_I3C', if_true: files('dw-i3c.c'))
+i3c_ss.add(when: 'CONFIG_MOCK_I3C_TARGET', if_true: files('mock-i3c-target.c'))
 system_ss.add_all(when: 'CONFIG_I3C', if_true: i3c_ss)
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events
index 39f33d9a50..3d6dd4f7dd 100644
--- a/hw/i3c/trace-events
+++ b/hw/i3c/trace-events
@@ -36,3 +36,12 @@ legacy_i2c_recv(uint8_t byte) "Legacy I2C recv 0x%" PRIx8
 legacy_i2c_send(uint8_t byte) "Legacy I2C send 0x%" PRIx8
 legacy_i2c_start_transfer(uint8_t address, bool is_recv) "Legacy I2C START with address 0x%" PRIx8 " is_recv=%d"
 legacy_i2c_end_transfer(void) "Legacy I2C STOP"
+
+# mock-target.c
+mock_i3c_target_rx(uint8_t byte) "I3C mock target read 0x%" PRIx8
+mock_i3c_target_tx(uint8_t byte) "I3C mock target write 0x%" PRIx8
+mock_i3c_target_event(uint8_t event) "I3C mock target event 0x%" PRIx8
+mock_i3c_target_handle_ccc_read(uint32_t num_read, uint32_t num_to_read) "I3C mock target read %" PRId32 "/%" PRId32 " bytes"
+mock_i3c_target_new_ccc(uint8_t ccc) "I3C mock target handle CCC 0x%" PRIx8
+mock_i3c_target_handle_ccc_write(uint32_t num_sent, uint32_t num_to_send) "I3C mock target send %" PRId32 "/%" PRId32 " bytes"
+mock_i3c_target_do_ibi(uint8_t address, bool is_recv) "I3C mock target IBI with address 0x%" PRIx8 " RnW=%d"
-- 
2.43.0


