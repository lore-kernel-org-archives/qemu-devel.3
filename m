Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD33F47CAA
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 18:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCyG-00013W-TO; Thu, 05 Mar 2026 12:58:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCxp-00008u-3k
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:58:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCxj-0003iP-RY
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772733495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gpm8Qo6MjZ64toQ1ykoHOWrlx1wecGdszkd8HDvGPPM=;
 b=FG4Ftqfv2yOxeK90wxSUfKbDzkkDkS0WNp0mI7FncsOWeRmiSMMlJOm0xXJGSc2RMeSDwy
 Oq12B3c97050H2352q11o8B5EwZAymqPBKXk0qUIPnBHCbe+FDfRiZw1IKrL3zIoybJz2d
 683FAUu8c/ScRkLYmUIVyRKbDUnm5Qs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-TtvGhLEWPEaFk0kSxVvWgw-1; Thu,
 05 Mar 2026 12:58:10 -0500
X-MC-Unique: TtvGhLEWPEaFk0kSxVvWgw-1
X-Mimecast-MFC-AGG-ID: TtvGhLEWPEaFk0kSxVvWgw_1772733489
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15CE61956048; Thu,  5 Mar 2026 17:58:09 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 92FA53003E9E; Thu,  5 Mar 2026 17:58:06 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Titus Rwantare <titusr@google.com>, Patrick Venture <venture@google.com>,
 Jithu Joseph <jithu.joseph@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 19/38] hw/i3c: Add Mock target
Date: Thu,  5 Mar 2026 18:56:52 +0100
Message-ID: <20260305175711.1119025-20-clg@redhat.com>
In-Reply-To: <20260305175711.1119025-1-clg@redhat.com>
References: <20260305175711.1119025-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

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
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
Tested-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260225021158.1586584-19-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/i3c/mock-i3c-target.h |  52 ++++++
 hw/i3c/mock-i3c-target.c         | 298 +++++++++++++++++++++++++++++++
 hw/i3c/Kconfig                   |  10 ++
 hw/i3c/meson.build               |   1 +
 hw/i3c/trace-events              |  10 ++
 5 files changed, 371 insertions(+)
 create mode 100644 include/hw/i3c/mock-i3c-target.h
 create mode 100644 hw/i3c/mock-i3c-target.c

diff --git a/include/hw/i3c/mock-i3c-target.h b/include/hw/i3c/mock-i3c-target.h
new file mode 100644
index 000000000000..8c6003ae8b60
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
+    I3CTarget parent_obj;
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
index 000000000000..875cd7c7d09c
--- /dev/null
+++ b/hw/i3c/mock-i3c-target.c
@@ -0,0 +1,298 @@
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
+        return;
+    }
+
+    trace_mock_i3c_target_do_ibi(s->parent_obj.address, true);
+    int nack = i3c_target_send_ibi(&s->parent_obj, s->parent_obj.address,
+                                   /*is_recv=*/true);
+    /* Getting NACKed isn't necessarily an error, just print it out. */
+    if (nack) {
+        trace_mock_i3c_target_do_ibi_nack("sending");
+    }
+    nack = i3c_target_ibi_finish(&s->parent_obj, 0x00);
+    if (nack) {
+        trace_mock_i3c_target_do_ibi_nack("finishing");
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
+    mock_i3c_target_reset(&s->parent_obj);
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
+static const TypeInfo mock_i3c_target_types[] = {
+    {
+        .name          = TYPE_MOCK_I3C_TARGET,
+        .parent        = TYPE_I3C_TARGET,
+        .instance_size = sizeof(MockI3cTargetState),
+        .instance_init = mock_i3c_target_init,
+        .class_init    = mock_i3c_target_class_init,
+    },
+};
+
+DEFINE_TYPES(mock_i3c_target_types)
+
diff --git a/hw/i3c/Kconfig b/hw/i3c/Kconfig
index ecec77d6fc81..d5c6d4049bc8 100644
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
index 83d75e7d5c15..e614b187123d 100644
--- a/hw/i3c/meson.build
+++ b/hw/i3c/meson.build
@@ -2,4 +2,5 @@ i3c_ss = ss.source_set()
 i3c_ss.add(when: 'CONFIG_I3C', if_true: files('core.c'))
 i3c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i3c.c'))
 i3c_ss.add(when: 'CONFIG_DW_I3C', if_true: files('dw-i3c.c'))
+i3c_ss.add(when: 'CONFIG_MOCK_I3C_TARGET', if_true: files('mock-i3c-target.c'))
 system_ss.add_all(when: 'CONFIG_I3C', if_true: i3c_ss)
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events
index 39f33d9a50bc..9e58edec99ae 100644
--- a/hw/i3c/trace-events
+++ b/hw/i3c/trace-events
@@ -36,3 +36,13 @@ legacy_i2c_recv(uint8_t byte) "Legacy I2C recv 0x%" PRIx8
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
+mock_i3c_target_do_ibi_nack(const char *reason) "NACKed from controller when %s target interrupt"
-- 
2.53.0


