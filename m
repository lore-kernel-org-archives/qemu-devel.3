Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC52CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 10:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMkGQ-0003YP-0S; Tue, 12 May 2026 06:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wMkGM-0003WP-EX
 for qemu-devel@nongnu.org; Tue, 12 May 2026 06:22:55 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wMkGJ-0001zu-GH
 for qemu-devel@nongnu.org; Tue, 12 May 2026 06:22:54 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-44985f4ab0fso3068564f8f.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1778581370; x=1779186170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7by3vB6y9QKB29FL9RI+9FxR9o6JZL1oeICSnYGeLyI=;
 b=HJVXaWTAY10sXEx4NE2p3gBnaPX2DSnT9c7Rxof1+QEp00xWqHBJUcvZZQHZ9pANDw
 z9erS/SNW6O8gc0AdOAQIJBmQW0Sz6SPgYDb5RAN40HKMcnyFlc7UF+l2FYc53t7M0L9
 Xw2A+4fNQtdqyBRcNTiwKmfp2GOMJdALpC/xXli2GAslw6QmeBJfoqZooQkktqgMjiX1
 UR+PpgYQ3LzLIhpZJ/mQNvhrBAsW6Y+UJNiMbjEwCj4rvi78M7OopKgViMUdKIpZ5O1M
 RKHlw9J0aCpv2HnTRVhyFYPdmZ43glL3++So9jKbWRwuOuzD6mieD1pD1lWohD+eU1jN
 wcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778581370; x=1779186170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7by3vB6y9QKB29FL9RI+9FxR9o6JZL1oeICSnYGeLyI=;
 b=DzbYxs+m58Gg/7vrDTiVNFicnuFWOiOHpFLv3kfqzQ1MxNIF/8tk1cLJ4Ffj5apyOe
 9WNaFDh5uuSbd5s1Ee0aZhOjjdQJ0j7tvyxQGpTjfcOzGe7XtBcAuvQowKUgCHg6BVkY
 2EwvlulBW1+zpC0RgEX2ysnaH4Rx+o6Bq4zyAzbzahb97AXukuC2/Y+TAnTG14FR+x2e
 POvCGCLQVHL/M6JpSmuzQNHmHx6oGtOvdmjH4lMAOZSIihL1ESPocCKWiTfsEmzyK+AU
 peGYPeMRq/NSubp3kdHaceKRPetBDpR93UFNarK9Pqv59qVMmcilX4r/JCsDLfKjZmh+
 697A==
X-Gm-Message-State: AOJu0YwWes2qEf/Z6gKxEAOKc5M2ojkg7ZNB1KFsVsk07tcKjo7HhOyx
 pdMXoKOtSpPCuVGCsyF3U4I9G0++hDgTltzvMrLWnzfPrHJ64IcGJ67FqNAjH2/DXiS4QJbe0g2
 bB8JpWh0=
X-Gm-Gg: Acq92OFvOW9u4hL4YaY3xzRBoQgLzEKq9h36ZjZ9C++6sqpPqK/CoMKbtSmWgWrXb4G
 Cg7EskoCal2LtLFB9Phsct6GBc4cOWu/tJOUtMxga3NT/8czUVD2p3YSPvd4v7hlFu/Dsiw/fVk
 9A8pnxtgf5T/TxjbXW+D6mTQUTU4kEGFtH1/KPUB2NEAZXNABvbuQsU4d/bxK4lQG6I4EewS1W6
 tpQAtpE4xquPdMcWJXrLImW7Dsu4AFjfb8DISLVu5SwfgiidpwMMKkwvZrROTD9qkOSgHaTpMsM
 nQtRoJ7EU8qd5xROPYDuEq6R0d3VGx6C0O5McM3b2G0N4qIcsfVykN4piDUBI3dHPLHB4hIF1Nq
 c4xmrta/ZIRZMpIfUj78TvzTzr349J8JOk9RSmcJ5jrtVwbVnRTerVpOSd4+rlwv0p/eVC7SJTk
 L6VI4XSqsagYgsv5mv3ugzB1ZE2w/CCEYEn+oF3TnWceBHKc8POZ6FIQo=
X-Received: by 2002:a05:6000:24c2:b0:45a:e3dd:5869 with SMTP id
 ffacd0b85a97d-45b13e55d7bmr3261030f8f.30.1778581369609; 
 Tue, 12 May 2026 03:22:49 -0700 (PDT)
Received: from alexanderarchlinux ([188.111.3.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e6a68ebsm29991198f8f.1.2026.05.12.03.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 03:22:49 -0700 (PDT)
From: Alexander Hansen <alexander.hansen@9elements.com>
To: qemu-devel@nongnu.org
Cc: Alexander Hansen <alexander.hansen@9elements.com>,
 Titus Rwantare <titusr@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH v3 4/5] hw/sensor: support MAX11615
Date: Tue, 12 May 2026 12:20:39 +0200
Message-ID: <20260512102157.176511-5-alexander.hansen@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512102157.176511-1-alexander.hansen@9elements.com>
References: <20260512102157.176511-1-alexander.hansen@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alexander.hansen@9elements.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Product: [1]
Datasheet: [2]

Sensor readings can be provided upon creation of the device. In case no
readings are provided the ADC reads a pre-defined arbitrary value.

root@yosemite4:~# cat /sys/bus/iio/devices/iio:device2/name
max11615
root@yosemite4:~# cat /sys/bus/iio/devices/iio:device2/in_voltage0_raw
1922
root@yosemite4:~# cat /sys/bus/iio/devices/iio:device2/in_voltage_scale
0.500000000

trace:
less /tmp/qemu-trace.log | grep -i max116
max11615_realize i2c_addr: 0x33
max11615_realize i2c_addr: 0x33
max11615_event i2c_addr: 0x33, event: 0x01
max11615_write_setup i2c_addr: 0x33, data: 0xd2
max11615_write_config i2c_addr: 0x33, data: 0x0f
max11615_event i2c_addr: 0x33, event: 0x03
max11615_event i2c_addr: 0x33, event: 0x01
max11615_write_setup i2c_addr: 0x33, data: 0xd2
max11615_write_config i2c_addr: 0x33, data: 0x0f
max11615_event i2c_addr: 0x33, event: 0x03
max11615_event i2c_addr: 0x33, event: 0x01
max11615_write_setup i2c_addr: 0x33, data: 0xd2
max11615_write_config i2c_addr: 0x33, data: 0x61
max11615_event i2c_addr: 0x33, event: 0x03
max11615_event i2c_addr: 0x33, event: 0x00
max11615_recv i2c_addr: 0x33, reg_addr: 0x00
max11615_recv_return i2c_addr: 0x33, returns: 0xfa
max11615_recv i2c_addr: 0x33, reg_addr: 0x00
max11615_recv_return i2c_addr: 0x33, returns: 0xd2
max11615_event i2c_addr: 0x33, event: 0x04
max11615_event i2c_addr: 0x33, event: 0x03

References:
[1] https://www.analog.com/en/products/MAX11615.html
[2] https://www.analog.com/media/en/technical-documentation/data-sheets/MAX11612-MAX11617.pdf

Cc: Titus Rwantare <titusr@google.com>
Cc: "Cédric Le Goater" <clg@kaod.org> (maintainer:ASPEED BMCs)
Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org> (odd fixer:Overall sensors)
Cc: Paolo Bonzini <pbonzini@redhat.com> (maintainer:Kconfig)
Cc: Peter Maydell <peter.maydell@linaro.org> (supporter:ARM TCG CPUs)
Cc: qemu-devel@nongnu.org (open list:All patches CC here)
Cc: qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Signed-off-by: Alexander Hansen <alexander.hansen@9elements.com>
---
 MAINTAINERS                              |   1 +
 hw/arm/Kconfig                           |   1 +
 hw/arm/aspeed_ast2600_fby4.c             |   8 +-
 hw/sensor/Kconfig                        |   4 +
 hw/sensor/max11615.c                     | 202 +++++++++++++++++++++++
 hw/sensor/meson.build                    |   1 +
 hw/sensor/trace-events                   |   8 +
 include/hw/sensor/max11615.h             |  20 +++
 tests/functional/arm/test_aspeed_fby4.py |   8 +
 9 files changed, 252 insertions(+), 1 deletion(-)
 create mode 100644 hw/sensor/max11615.c
 create mode 100644 include/hw/sensor/max11615.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9c991f8e70..a9c88996a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3981,6 +3981,7 @@ S: Maintained
 F: hw/i2c/pmbus_device.c
 F: hw/sensor/adm1272.c
 F: hw/sensor/isl_pmbus_vr.c
+F: hw/sensor/max11615.c
 F: hw/sensor/max31790.c
 F: hw/sensor/max34451.c
 F: include/hw/i2c/pmbus_device.h
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 99864eb878..76a7d327a9 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -553,6 +553,7 @@ config ASPEED_SOC
     select PMBUS
     select MAX31785
     select MAX31790
+    select MAX11615
     select FSI_APB2OPB_ASPEED
     select AT24C
     select PCI_EXPRESS
diff --git a/hw/arm/aspeed_ast2600_fby4.c b/hw/arm/aspeed_ast2600_fby4.c
index a7c2dc09ea..036f5b9e38 100644
--- a/hw/arm/aspeed_ast2600_fby4.c
+++ b/hw/arm/aspeed_ast2600_fby4.c
@@ -12,6 +12,7 @@
 #include "hw/arm/aspeed_soc.h"
 #include "hw/nvram/eeprom_at24c.h"
 #include "hw/sensor/max31790.h"
+#include "hw/sensor/max11615.h"
 #include "hw/i2c/i2c_mux_pca954x.h"
 #include "hw/gpio/pca9552.h"
 
@@ -186,7 +187,12 @@ static void fby4_i2c_init_fanboard(I2CSlave *fan_mux, size_t eepromSize)
         i2c_slave_create_simple(bus, TYPE_MAX31790, 0x2f);
 
         /* maxim,max11615 @ 0x33   (adc) */
-        /* TODO */
+        static const uint16_t adc_values[8] = {
+            0b011110000010, 0b010100011000,
+            0b001000110100, 0b100000101001,
+            0b011110000010, 0b010100011000,
+            0b001000110100, 0b100000101001};
+        max11615_init_with_values(bus, 0x33, adc_values, 8);
 
         at24c_eeprom_init_rom(
             bus, 0x52, eepromSize,
diff --git a/hw/sensor/Kconfig b/hw/sensor/Kconfig
index ece2f2b167..84eede9d84 100644
--- a/hw/sensor/Kconfig
+++ b/hw/sensor/Kconfig
@@ -47,3 +47,7 @@ config MAX31785
 config MAX31790
     bool
     depends on PMBUS
+
+config MAX11615
+    bool
+    depends on I2C
diff --git a/hw/sensor/max11615.c b/hw/sensor/max11615.c
new file mode 100644
index 0000000000..7950e00e33
--- /dev/null
+++ b/hw/sensor/max11615.c
@@ -0,0 +1,202 @@
+/*
+ * Maxim MAX11615 Low-Power 12 bit ADC
+ * Models MAX11612,MAX11613,MAX11614,MAX11615,MAX11616,MAX11617
+ *
+ * Datasheet:
+ * https://www.analog.com/media/en/technical-documentation/data-sheets/MAX11612-MAX11617.pdf
+ *
+ * Copyright 2026 9elements
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/i2c/i2c.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "trace.h"
+#include "hw/sensor/max11615.h"
+
+#define MAX11615_NUM_CHANNELS 8
+
+struct MAX11615State {
+    I2CSlave i2c;
+
+    uint16_t channels[MAX11615_NUM_CHANNELS];
+
+    /* output buffer */
+    uint8_t outlen;
+    uint8_t outbuf[2];
+
+    /* selected channel for read/write operation */
+    uint8_t pointer;
+};
+
+struct MAX11615Class {
+    I2CSlaveClass parent_class;
+};
+
+OBJECT_DECLARE_TYPE(MAX11615State, MAX11615Class, MAX11615)
+
+static void max11615_read(MAX11615State *s)
+{
+    /* read an ADC channel, first 4 bits must be high */
+    uint8_t msb = s->channels[s->pointer] >> 8;
+    uint8_t lsb = s->channels[s->pointer] & 0xff;
+    s->outbuf[0] = 0b11110000 | (msb & 0b00001111);
+    s->outbuf[1] = lsb;
+}
+
+static void max11615_write_config_byte(MAX11615State *s, uint8_t data)
+{
+    trace_max11615_write_config(s->i2c.address, data);
+
+    uint8_t channelSelect = (data >> 1) & 0b1111;
+
+    /* Table 3. Channel Selection (AIN0 ... AIN11) */
+    if (channelSelect > 11) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid channel select", __func__);
+        channelSelect = 11;
+    }
+    s->pointer = channelSelect;
+}
+
+static void max11615_write_setup_byte(MAX11615State *s, uint8_t data)
+{
+    trace_max11615_write_setup(s->i2c.address, data);
+    /* we ignore the setup byte, not implemented */
+}
+
+static int max11615_send(I2CSlave *i2c, uint8_t data)
+{
+    MAX11615State *s = MAX11615(i2c);
+    const uint8_t msb = (data >> 7) & 0b1;
+
+    if (msb) {
+        max11615_write_setup_byte(s, data);
+    } else {
+        max11615_write_config_byte(s, data);
+    }
+
+    s->outlen = 0;
+    return 0;
+}
+
+static uint8_t max11615_recv(I2CSlave *i2c)
+{
+    MAX11615State *s = MAX11615(i2c);
+    trace_max11615_recv(s->i2c.address, s->pointer);
+
+    max11615_read(s);
+
+    if (s->outlen >= 2) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: too many bytes read", __func__);
+        s->outlen = 0;
+    }
+
+    const uint8_t data =  s->outbuf[s->outlen++];
+
+    trace_max11615_recv_return(s->i2c.address, data);
+    return data;
+}
+
+static int max11615_event(I2CSlave *i2c, enum i2c_event event)
+{
+    MAX11615State *s = MAX11615(i2c);
+
+    trace_max11615_event(s->i2c.address, event);
+
+    switch (event) {
+    case I2C_START_RECV:
+        s->outlen = 0;
+        break;
+    default:
+        break;
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_max11615 = {
+    .name = TYPE_MAX11615,
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (const VMStateField[]){
+        VMSTATE_UINT16_ARRAY(channels, MAX11615State, MAX11615_NUM_CHANNELS),
+        VMSTATE_UINT8(outlen, MAX11615State),
+        VMSTATE_UINT8_ARRAY(outbuf, MAX11615State, 2),
+        VMSTATE_UINT8(pointer, MAX11615State),
+        VMSTATE_I2C_SLAVE(i2c, MAX11615State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void max11615_init(Object *obj)
+{
+    /* Nothing to do */
+}
+
+I2CSlave *max11615_init_with_values(I2CBus *bus, uint8_t address,
+    const uint16_t *init_values, uint32_t init_values_size)
+{
+    MAX11615State *s;
+
+    s = MAX11615(i2c_slave_new(TYPE_MAX11615, address));
+
+    for (int i = 0; i < MAX11615_NUM_CHANNELS && i < init_values_size; i++) {
+
+        /* arbitrary value */
+        uint16_t value = 0b0000101011010010;
+
+        if (i < init_values_size) {
+            value = init_values[i];
+        }
+        s->channels[i] = value;
+    }
+
+    i2c_slave_realize_and_unref(I2C_SLAVE(s), bus, &error_abort);
+
+    return I2C_SLAVE(s);
+}
+
+static void max11615_realize(DeviceState *dev, Error **errp)
+{
+    MAX11615State *s = MAX11615(dev);
+
+    trace_max11615_realize(s->i2c.address);
+
+    s->pointer = 0;
+    s->outlen = 0;
+}
+
+static void max11615_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+
+    dc->realize = max11615_realize;
+    dc->desc = "Maxim MAX11615 12-bit ADC";
+    dc->vmsd = &vmstate_max11615;
+    k->event = max11615_event;
+    k->recv = max11615_recv;
+    k->send = max11615_send;
+}
+
+static const TypeInfo max31790_info = {
+    .name = TYPE_MAX11615,
+    .parent = TYPE_I2C_SLAVE,
+    .instance_size = sizeof(MAX11615State),
+    .class_size = sizeof(MAX11615Class),
+    .instance_init = max11615_init,
+    .class_init = max11615_class_init,
+};
+
+static void max31790_register_types(void)
+{
+    type_register_static(&max31790_info);
+}
+
+type_init(max31790_register_types)
diff --git a/hw/sensor/meson.build b/hw/sensor/meson.build
index 4987c3b253..a1e26604fa 100644
--- a/hw/sensor/meson.build
+++ b/hw/sensor/meson.build
@@ -9,3 +9,4 @@ system_ss.add(when: 'CONFIG_LSM303DLHC_MAG', if_true: files('lsm303dlhc_mag.c'))
 system_ss.add(when: 'CONFIG_ISL_PMBUS_VR', if_true: files('isl_pmbus_vr.c'))
 system_ss.add(when: 'CONFIG_MAX31785', if_true: files('max31785.c'))
 system_ss.add(when: 'CONFIG_MAX31790', if_true: files('max31790.c'))
+system_ss.add(when: 'CONFIG_MAX11615', if_true: files('max11615.c'))
diff --git a/hw/sensor/trace-events b/hw/sensor/trace-events
index c15c0a7e93..3fed979e85 100644
--- a/hw/sensor/trace-events
+++ b/hw/sensor/trace-events
@@ -12,3 +12,11 @@ max31790_recv_return(uint8_t i2c_addr, uint8_t data) "i2c_addr: 0x%02x, returns:
 max31790_event(uint8_t i2c_addr, uint8_t event) "i2c_addr: 0x%02x, event: 0x%02x"
 max31790_realize(uint8_t i2c_addr) "i2c_addr: 0x%02x"
 max31790_pwm_write(uint8_t i2c_addr, size_t index, uint16_t value) "i2c_addr: 0x%02x, index: %zu, value: 0x%04x"
+
+# max11615.c
+max11615_write_setup(uint8_t i2c_addr, uint8_t send) "i2c_addr: 0x%02x, data: 0x%02x"
+max11615_write_config(uint8_t i2c_addr, uint8_t send) "i2c_addr: 0x%02x, data: 0x%02x"
+max11615_recv(uint8_t i2c_addr, uint8_t reg_addr) "i2c_addr: 0x%02x, reg_addr: 0x%02x"
+max11615_recv_return(uint8_t i2c_addr, uint8_t data) "i2c_addr: 0x%02x, returns: 0x%02x"
+max11615_event(uint8_t i2c_addr, uint8_t event) "i2c_addr: 0x%02x, event: 0x%02x"
+max11615_realize(uint8_t i2c_addr) "i2c_addr: 0x%02x"
diff --git a/include/hw/sensor/max11615.h b/include/hw/sensor/max11615.h
new file mode 100644
index 0000000000..ccc0c9bc2e
--- /dev/null
+++ b/include/hw/sensor/max11615.h
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#ifndef QEMU_MAX11615_H
+#define QEMU_MAX11615_H
+
+#include <stdint.h>
+#include "hw/i2c/i2c.h"
+
+#define TYPE_MAX11615 "max11615"
+
+/*
+ * Create and realize a MAX11615 ADC with constant caller-supplied readings
+ * @bus: I2C bus to put it on
+ * @address: I2C address
+ * @init_values: array of readings for each ADC channel
+ * @init_values_size: Size of @init_values, can be less than the number of channels
+ */
+I2CSlave *max11615_init_with_values(I2CBus *bus, uint8_t address,
+                                    const uint16_t *init_values, uint32_t init_values_size);
+
+#endif
diff --git a/tests/functional/arm/test_aspeed_fby4.py b/tests/functional/arm/test_aspeed_fby4.py
index d29423add7..319f1a7672 100755
--- a/tests/functional/arm/test_aspeed_fby4.py
+++ b/tests/functional/arm/test_aspeed_fby4.py
@@ -51,6 +51,14 @@ def do_test_arm_aspeed_openbmc_no_network(self, machine, image, uboot,
         exec_command_and_wait_for_pattern(self,
             "cat /sys/class/hwmon/hwmon2/fan1_fault", "0");
 
+        # MAX11615 test
+        exec_command_and_wait_for_pattern(self,
+            "cat /sys/bus/iio/devices/iio:device2/name", "max11615");
+        exec_command_and_wait_for_pattern(self,
+            "cat /sys/bus/iio/devices/iio:device2/in_voltage0_raw", "1922");
+        exec_command_and_wait_for_pattern(self,
+            "cat /sys/bus/iio/devices/iio:device2/in_voltage_scale", "0.500000000");
+
     def test_arm_ast2600_yosemitev4_openbmc(self):
         image_path = self.uncompress(self.ASSET_YOSEMITE_V4_FLASH)
 
-- 
2.54.0


