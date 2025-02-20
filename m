Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC234C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 12:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl5d0-0000Cj-Jh; Thu, 20 Feb 2025 07:26:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.chichkov@yadro.com>)
 id 1tl5cy-0000CN-4F
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 07:26:04 -0500
Received: from mta-03.yadro.com ([89.207.88.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.chichkov@yadro.com>)
 id 1tl5cu-0007Ll-G7
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 07:26:03 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 29606E0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
 t=1740054347; bh=AEiL84VmaeUTvs8PpT0NlIW40l3PgJmXCwYD0whMxCM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=LyWd+GMruPP2pLBpbEs/Zqli/cWGID012B/aRyGMBhENNWtUltE6CW/ca9JJenEu+
 sS23TyD6j/5U6jaRy6DkmU2YUsKBUU1nMWXfzlMwBJ+w28F9qKaq11gy+NwwGpIa+l
 GxrqYiGNSmeACtfbtcof2vfm2eXGFQx57TSIxPUkpFKf/k7s89yLEIx5h8xyUb6RkZ
 9YmD2HQ2xkprNp0CrKtbe0dmDC7+TmrMwlaIpoeKjYQvRFKu9X6ObqdFeVQF0QtijO
 YizW391OwMUlouXsflRIvltRgo7Y4hoa019cPfrAouYM3KhqGJy2q10Xf4QV05DfUL
 17AAzWE3yOvrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
 t=1740054347; bh=AEiL84VmaeUTvs8PpT0NlIW40l3PgJmXCwYD0whMxCM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=oszJOY8FChn4pSVvxomxQ+nJvWfXAUmfhYTc6KVd1s1rYytdQnKlG1T7XTgq7OzO6
 xXnLhm61G8xLD7ktU59w+fmUPdK31QXI9Wj1RQjs+WQCgcQwRNOllnPVKZOtmIN+8v
 hmRouxGnKcweORZIPTdxs/pbSnwxpS5ItgntxShAEa0LfiLIoWNG9iP4a936gYBSao
 3mO7wtEgEL+Ac5LoPigOz1IVnpaX3G8llriCqMMLKX5zMHmi6tDMIbNaTUvh959WHg
 PKztN72WxXwrJJuk1mo/yJVoGupxfS8T5kSKvYBxnuIAEieqpmzHK/vVLjPpMqVODO
 ngLMP4aYpRTsg==
From: Ilya Chichkov <i.chichkov@yadro.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Ilya Chichkov <i.chichkov@yadro.com>
Subject: [RESEND PATCH] hw/sensors: Add temperature SI705x sensor
Date: Thu, 20 Feb 2025 15:15:03 +0300
Message-ID: <20250220121503.12213-1-i.chichkov@yadro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: pass client-ip=89.207.88.253; envelope-from=i.chichkov@yadro.com;
 helo=mta-03.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Add SI705x temperature sensor with I2C interface and allow setting
temperature, VDD status and measurement resolution through properties.
This commit adds support for interfacing with it and implements
functionality for sensor's commands.

Datasheet: https://www.integrated-circuit.com/pdf/502/391/4.pdf
---
 hw/sensor/Kconfig      |   5 +
 hw/sensor/meson.build  |   1 +
 hw/sensor/tmp_si705x.c | 359 +++++++++++++++++++++++++++++++++++++++++
 hw/sensor/trace-events |   9 ++
 hw/sensor/trace.h      |   1 +
 meson.build            |   1 +
 6 files changed, 376 insertions(+)
 create mode 100644 hw/sensor/tmp_si705x.c
 create mode 100644 hw/sensor/trace-events
 create mode 100644 hw/sensor/trace.h

diff --git a/hw/sensor/Kconfig b/hw/sensor/Kconfig
index bc6331b4ab..554ccbc5f6 100644
--- a/hw/sensor/Kconfig
+++ b/hw/sensor/Kconfig
@@ -43,3 +43,8 @@ config ISL_PMBUS_VR
 config MAX31785
     bool
     depends on PMBUS
+
+config SI705X
+    bool
+    depends on I2C
+    default y if I2C_DEVICES
diff --git a/hw/sensor/meson.build b/hw/sensor/meson.build
index 420fdc3359..fba9ccd255 100644
--- a/hw/sensor/meson.build
+++ b/hw/sensor/meson.build
@@ -8,3 +8,4 @@ system_ss.add(when: 'CONFIG_MAX34451', if_true: files('max34451.c'))
 system_ss.add(when: 'CONFIG_LSM303DLHC_MAG', if_true: files('lsm303dlhc_mag.c'))
 system_ss.add(when: 'CONFIG_ISL_PMBUS_VR', if_true: files('isl_pmbus_vr.c'))
 system_ss.add(when: 'CONFIG_MAX31785', if_true: files('max31785.c'))
+system_ss.add(when: 'CONFIG_SI705X', if_true: files('tmp_si705x.c'))
diff --git a/hw/sensor/tmp_si705x.c b/hw/sensor/tmp_si705x.c
new file mode 100644
index 0000000000..3b729974f0
--- /dev/null
+++ b/hw/sensor/tmp_si705x.c
@@ -0,0 +1,359 @@
+/*
+ * SI705X-A20-IM, Board Mount Temperature Sensors.
+ *
+ * https://www.integrated-circuit.com/pdf/502/391/4.pdf
+ *
+ * Copyright (c) 2024 Ilya Chichkov <i.chichkov@yadro.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/i2c/i2c.h"
+#include "qapi/error.h"
+#include "hw/register.h"
+#include "qapi/visitor.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+#define TYPE_SI705X "si705x"
+#define SI705X(obj) OBJECT_CHECK(Si705xState, (obj), TYPE_SI705X)
+
+#define  SI705X_CMD_MEASURE_HOLD_MASTER    0xe3
+#define  SI705X_CMD_MEASURE                0xf3
+#define  SI705X_CMD_RESET                  0xfe
+#define  SI705X_CMD_WRITE_USER_REG         0xe6
+#define  SI705X_CMD_READ_USER_REG          0xe7
+#define  SI705X_CMD_READ_ID_BYTE1_1        0xFA
+#define  SI705X_CMD_READ_ID_BYTE1_2        0x0F
+#define  SI705X_CMD_READ_ID_BYTE2_1        0xFC
+#define  SI705X_CMD_READ_ID_BYTE2_2        0xC9
+#define  SI705X_CMD_READ_FIRMWARE_REV_1    0x84
+#define  SI705X_CMD_READ_FIRMWARE_REV_2    0xB8
+
+#define SI705X_WRITE_MASK   0x81
+
+#define CRC_POLY            0x31
+#define BYTE7               0x80
+#define CRC_SEED            0
+
+#define  SI705X_UR1         0x00
+REG32(SI705X_UR1, 0x00)
+    FIELD(SI705X_UR1, RES0,  0,  1)
+    FIELD(SI705X_UR1, RSVD,  1,  5)
+    FIELD(SI705X_UR1, VDD,   6,  1)
+    FIELD(SI705X_UR1, RES1,  7,  1)
+
+typedef struct Si705xState {
+    /*< private >*/
+    I2CSlave i2c;
+
+    /*< public >*/
+    uint8_t user_reg;
+    uint8_t read_index;
+    uint8_t write_index;
+    uint8_t prev_command;
+    uint8_t command;
+    uint8_t io_buf[5];
+
+    uint8_t temperature[2];
+    uint8_t measurement_resolution;
+    uint8_t vdd_status;
+
+    uint64_t serial_num;
+    uint8_t fw_rev;
+} Si705xState;
+
+static uint8_t temp_sensor_crc(uint8_t *p_data, uint32_t len)
+{
+    uint8_t crc = CRC_SEED;
+
+    for (uint32_t i = 0U; i < len; i++) {
+        crc ^= p_data[i];
+
+        for (uint8_t j = 0U; j < 8; j++) {
+            if ((crc & BYTE7) != 0U) {
+                crc = (crc << 1U) ^ CRC_POLY;
+            } else {
+                crc <<= 1U;
+            }
+        }
+    }
+
+    return crc;
+}
+
+static void si705x_get_temperature(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    Si705xState *s = SI705X(obj);
+
+    int16_t hv = s->temperature[0] << 8;
+    int64_t value = hv | s->temperature[1];
+
+    visit_type_int(v, name, &value, errp);
+}
+
+static void si705x_set_temperature(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    Si705xState *s = SI705X(obj);
+    int64_t temp;
+
+    if (!visit_type_int(v, name, &temp, errp)) {
+        return;
+    }
+
+    /* Apply measurement resolution to set value */
+    temp &= ~((1 << (1 + s->measurement_resolution)) - 1);
+
+    s->temperature[0] = 0xff & (temp >> 8);
+    s->temperature[1] = 0xff & temp;
+}
+
+static void si705x_get_measure_res(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    Si705xState *s = SI705X(obj);
+    int64_t value = s->measurement_resolution;
+    visit_type_int(v, name, &value, errp);
+}
+
+static void si705x_set_measure_res(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    Si705xState *s = SI705X(obj);
+    int64_t temp;
+
+    if (!visit_type_int(v, name, &temp, errp)) {
+        return;
+    }
+
+    s->measurement_resolution = temp & 0x3;
+    s->user_reg |= ((s->measurement_resolution >> 1) << 7);
+    s->user_reg |= (s->measurement_resolution & 0x1);
+}
+
+static void si705x_get_vdds(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    Si705xState *s = SI705X(obj);
+    int64_t value = s->vdd_status;
+    visit_type_int(v, name, &value, errp);
+}
+
+static void si705x_set_vdds(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    Si705xState *s = SI705X(obj);
+    int64_t temp;
+
+    if (!visit_type_int(v, name, &temp, errp)) {
+        return;
+    }
+
+    s->vdd_status = temp & 0x1;
+    s->user_reg |= s->vdd_status << 6;
+}
+
+static void si705x_reset(I2CSlave *i2c)
+{
+    trace_si705x_reset();
+    Si705xState *s = SI705X(i2c);
+
+    s->user_reg = 0x3A;
+    s->read_index = 0;
+    s->write_index = 0;
+    s->command = 0;
+    s->measurement_resolution = 0;
+    s->vdd_status = 0;
+    s->serial_num = 0x37000000;
+    s->fw_rev = 0x20;
+
+    memset(s->io_buf, 0, sizeof(s->io_buf));
+    memset(s->temperature, 0, sizeof(s->temperature));
+}
+
+static void si705x_read(Si705xState *s)
+{
+    switch (s->command) {
+    case SI705X_CMD_MEASURE_HOLD_MASTER:
+    case SI705X_CMD_MEASURE:
+        s->io_buf[0] = s->temperature[0];
+        s->io_buf[1] = s->temperature[1];
+        s->io_buf[2] = temp_sensor_crc(s->io_buf, 2);
+        break;
+    case SI705X_CMD_READ_USER_REG:
+        s->io_buf[0] = s->user_reg;
+        break;
+    case SI705X_CMD_READ_ID_BYTE1_2:
+        if (s->prev_command == SI705X_CMD_READ_ID_BYTE1_1) {
+            s->io_buf[0] = (s->serial_num >> 56) & 0xff;
+            s->io_buf[1] = (s->serial_num >> 48) & 0xff;
+            s->io_buf[2] = (s->serial_num >> 40) & 0xff;
+            s->io_buf[3] = (s->serial_num >> 32) & 0xff;
+        }
+        break;
+    case SI705X_CMD_READ_ID_BYTE2_2:
+        if (s->prev_command == SI705X_CMD_READ_ID_BYTE1_1) {
+            s->io_buf[0] = (s->serial_num >> 24) & 0xff;
+            s->io_buf[1] = (s->serial_num >> 16) & 0xff;
+            s->io_buf[2] = (s->serial_num >> 8) & 0xff;
+            s->io_buf[3] = (s->serial_num >> 0) & 0xff;
+        }
+        break;
+    case SI705X_CMD_READ_FIRMWARE_REV_2:
+        if (s->prev_command == SI705X_CMD_READ_FIRMWARE_REV_1) {
+            s->io_buf[0] = s->fw_rev;
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                    "%s: write to unimplemented register\n", __func__);
+        break;
+    }
+    trace_si705x_read(s->command);
+}
+
+static void si705x_write(Si705xState *s)
+{
+    switch (s->command) {
+    case SI705X_CMD_RESET:
+        si705x_reset(&s->i2c);
+        break;
+    case SI705X_CMD_WRITE_USER_REG:
+        s->user_reg = s->io_buf[0] & SI705X_WRITE_MASK;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                    "%s:  write to unimplemented register\n", __func__);
+        break;
+    }
+}
+
+static uint8_t si705x_rx(I2CSlave *i2c)
+{
+    Si705xState *s = SI705X(i2c);
+
+    if (s->read_index < sizeof(s->io_buf)) {
+        trace_si705x_rx(s->io_buf[s->read_index]);
+        return s->io_buf[s->read_index++];
+    }
+    trace_si705x_rx(0xff);
+    return 0xff;
+}
+
+static int si705x_tx(I2CSlave *i2c, uint8_t data)
+{
+    Si705xState *s = SI705X(i2c);
+    trace_si705x_write(s->write_index, sizeof(s->io_buf), data);
+
+    if (s->write_index == 0) {
+        s->command = data;
+        switch (s->command) {
+        case SI705X_CMD_READ_ID_BYTE1_1:
+        case SI705X_CMD_READ_ID_BYTE2_1:
+        case SI705X_CMD_READ_FIRMWARE_REV_1:
+            s->prev_command = s->command;
+            s->write_index = 0;
+            break;
+        default:
+            s->write_index++;
+            break;
+        }
+    } else {
+        if (s->write_index <= sizeof(s->io_buf)) {
+            s->io_buf[s->write_index - 1] = data;
+        }
+        s->write_index++;
+        si705x_write(s);
+    }
+
+    return 0;
+}
+
+static int si705x_event(I2CSlave *i2c, enum i2c_event event)
+{
+    Si705xState *s = SI705X(i2c);
+    trace_si705x_event(event);
+
+    switch (event) {
+    case I2C_START_RECV:
+        si705x_read(s);
+        break;
+    case I2C_FINISH:
+        s->read_index = 0;
+        s->write_index = 0;
+    default:
+        break;
+    }
+    return 0;
+}
+
+static const VMStateDescription vmstate_si705x = {
+    .name = "SI705X",
+    .version_id = 0,
+    .minimum_version_id = 0,
+};
+
+static void si705x_realize(DeviceState *dev, Error **errp)
+{
+    I2CSlave *i2c = I2C_SLAVE(dev);
+    Si705xState *s = SI705X(i2c);
+
+    si705x_reset(&s->i2c);
+}
+
+static void si705x_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+
+    k->event = si705x_event;
+    k->recv = si705x_rx;
+    k->send = si705x_tx;
+    dc->realize = si705x_realize;
+    dc->vmsd = &vmstate_si705x;
+
+    trace_si705x_init();
+}
+
+static void si705x_initfn(Object *obj)
+{
+    object_property_add(obj, "temperature", "int",
+                        si705x_get_temperature,
+                        si705x_set_temperature, NULL, NULL);
+    object_property_add(obj, "vdds", "int",
+                        si705x_get_vdds,
+                        si705x_set_vdds, NULL, NULL);
+    object_property_add(obj, "resolution", "int",
+                        si705x_get_measure_res,
+                        si705x_set_measure_res, NULL, NULL);
+}
+
+static const TypeInfo si705x_info = {
+    .name          = TYPE_SI705X,
+    .parent        = TYPE_I2C_SLAVE,
+    .instance_size = sizeof(Si705xState),
+    .instance_init = si705x_initfn,
+    .class_init    = si705x_class_init,
+};
+
+static void si705x_register_types(void)
+{
+    type_register_static(&si705x_info);
+}
+
+type_init(si705x_register_types)
diff --git a/hw/sensor/trace-events b/hw/sensor/trace-events
new file mode 100644
index 0000000000..42e19da98e
--- /dev/null
+++ b/hw/sensor/trace-events
@@ -0,0 +1,9 @@
+# See docs/devel/tracing.rst for syntax documentation.
+
+# tmp_si705x.c
+si705x_write(uint8_t index, uint8_t buf_len, uint8_t data) "index: [%d/%d], data: 0x%x"
+si705x_read(uint8_t cmd) "Command: 0x%x"
+si705x_rx(uint8_t data) "Read RX: 0x%x"
+si705x_event(uint8_t event) "Event: 0x%x"
+si705x_init(void)
+si705x_reset(void)
diff --git a/hw/sensor/trace.h b/hw/sensor/trace.h
new file mode 100644
index 0000000000..e4721560b0
--- /dev/null
+++ b/hw/sensor/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_sensor.h"
diff --git a/meson.build b/meson.build
index d0329966f1..385c903253 100644
--- a/meson.build
+++ b/meson.build
@@ -3330,6 +3330,7 @@ if have_system
     'hw/watchdog',
     'hw/xen',
     'hw/gpio',
+    'hw/sensor',
     'migration',
     'net',
     'system',
-- 
2.34.1


