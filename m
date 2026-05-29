Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EF4CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 12:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSwZW-0001Eo-9l; Fri, 29 May 2026 08:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wSwZC-00010S-BD
 for qemu-devel@nongnu.org; Fri, 29 May 2026 08:44:04 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wSwZ5-0004kb-8B
 for qemu-devel@nongnu.org; Fri, 29 May 2026 08:43:57 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-441209fb77eso8576297f8f.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 05:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1780058627; x=1780663427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1PBygEponuULoC+Eq4LpbLAWoLdlDY8mXLzWm6nlfFo=;
 b=WLEq0eYKMlg9QAlGw0HSwyiHGqGwkJFqnms+Wc+uqyXywQn5HD/rY4hbtfk+8Afnm3
 bvBOE+t3+h3+jUP71esQFU2d4DjCvg1FhbFitbjaWUfqmybrp1qmBHSHXs/1UU0V5ntw
 UmbEa33TXgJsxl5gr7DZLaW/tY6ZmNe4s1ESsugrnXBqG3lRlRNmf3Or7rZuJvZvU+w4
 ZR3V1TXXXa80qAFCjCOkfkADnc193VvJUyGOXqIJSoIw3810cscjIkzoGsVN5Fr7CrqK
 8b9rd2hKw7EzWj6Dqi305XdOwsqNeui85gPvwGaWZ5CZEwY9ZtGXr6Ix21CcXdDOVPS4
 BIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780058627; x=1780663427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1PBygEponuULoC+Eq4LpbLAWoLdlDY8mXLzWm6nlfFo=;
 b=QId1EAGy7ayE6FYpuCssntgnFUcHBU/tCCPkdYKH/fD5vIQ6iqAMvagr2WpbW5Qtpy
 kcCuZTVyDyUH6YFjKzkryGIHqmDpsHOs0x2QBuGwCZHSw6UEFLQ+p/Th4fM2nRkKmrFu
 /nog7XEHRVqpd30gxnDu8JJcPMD876WYgVsTXjWYsF6KpP+bbW2gG3qydyquCfEdDCIq
 f/2wrU0bGGFKRxLJ+0b46oXvhHdRNaMghbCQLcjsWSJ5Sn29wXnYJZ4aC2NLCVfIR7CC
 Oux2lh9ztDt6F0vW4vt1HBfO6ckGUH4bGOLqE02NTxPqwSuY3iyHLDZUzgsgq0B17Zl0
 ISDA==
X-Gm-Message-State: AOJu0Yxt1VnBel6B9zKEeRn/mqXhfa6q1GIFzTFnQQ4ysc1926V3SYUg
 choxrCcxF7zzlIAxliw+7QYG35W1dPLPPJXLhlcR0Aa3UUQKyDRF2realsJFsq25VG9z18JwQHq
 +3o8LD2U=
X-Gm-Gg: Acq92OEAEWeH9X5Xhwe7qaF3WYEv3y0mItg3+oyqA9ApEJBe79e558zGKjeZv3R77w1
 Mqwq1GGZ8WH1ouslGQ1Gg37afY5IyXPHKXGR/Qi/k6yWg+0NuwBghGVCUqGmt9xQzw/NvTAa6Va
 1dMuh0wJA8BjlM5aMH/oP479RXZUbTbMQCmvLdK+gZiqZfw/thWvKjnuhC9I3xuD3wFT13vAynh
 zp19jYgsTEqPeQyJUjsTrbBiVaE8VUQZP+m1o6YUod3OaMQguQrFalkJcLQN0jUhHnmSiUvrL0+
 4GLYdy9S+pRPFQ7jsxvxV8ERnDTXcGNQqIVBh1oHc0LnOJ2D1nbPb5mh2WNTXt7JGbA+IAqPUYX
 SH1SyQaZ5oki+HlKVEjsyOwaSQxVvLTt/RyZCPXt5Ac4JfB+B/+ZE9fnMhBnw65bp+aqX+asNiM
 gjLUB9B2Sz4oMBk3GDb5JxvJCsa6kEZT/evybe/gf0sah7XwzeKsCV7so=
X-Received: by 2002:a05:6000:25ee:b0:44f:69f4:39b5 with SMTP id
 ffacd0b85a97d-45ef139b5camr4114051f8f.29.1780058627205; 
 Fri, 29 May 2026 05:43:47 -0700 (PDT)
Received: from alexanderarchlinux ([188.111.3.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef35598e5sm3163354f8f.27.2026.05.29.05.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 05:43:46 -0700 (PDT)
From: Alexander Hansen <alexander.hansen@9elements.com>
To: qemu-devel@nongnu.org
Cc: Alexander Hansen <alexander.hansen@9elements.com>,
 Titus Rwantare <titusr@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH v5 4/5] hw/sensor: support MAX11615
Date: Fri, 29 May 2026 14:37:33 +0200
Message-ID: <20260529124237.94087-5-alexander.hansen@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529124237.94087-1-alexander.hansen@9elements.com>
References: <20260529124237.94087-1-alexander.hansen@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alexander.hansen@9elements.com; helo=mail-wr1-x42f.google.com
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
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org> (odd fixer:Overall sensors)
Cc: Paolo Bonzini <pbonzini@redhat.com> (maintainer:Kconfig)
Cc: Peter Maydell <peter.maydell@linaro.org> (supporter:ARM TCG CPUs)
Cc: qemu-devel@nongnu.org (open list:All patches CC here)
Cc: qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Signed-off-by: Alexander Hansen <alexander.hansen@9elements.com>
---
 MAINTAINERS                              |   1 +
 include/hw/sensor/max11615.h             |  20 ++
 hw/arm/aspeed_ast2600_fby4.c             |   8 +-
 hw/sensor/max11615.c                     | 312 +++++++++++++++++++++++
 hw/arm/Kconfig                           |   1 +
 hw/sensor/Kconfig                        |   4 +
 hw/sensor/meson.build                    |   1 +
 hw/sensor/trace-events                   |   8 +
 tests/functional/arm/test_aspeed_fby4.py |   8 +
 9 files changed, 362 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/sensor/max11615.h
 create mode 100644 hw/sensor/max11615.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2a0dbd1cc4..195e3c7927 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3987,6 +3987,7 @@ S: Maintained
 F: hw/i2c/pmbus_device.c
 F: hw/sensor/adm1272.c
 F: hw/sensor/isl_pmbus_vr.c
+F: hw/sensor/max11615.c
 F: hw/sensor/max31790.c
 F: hw/sensor/max34451.c
 F: include/hw/i2c/pmbus_device.h
diff --git a/include/hw/sensor/max11615.h b/include/hw/sensor/max11615.h
new file mode 100644
index 0000000000..0460ee5963
--- /dev/null
+++ b/include/hw/sensor/max11615.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef QEMU_MAX11615_H
+#define QEMU_MAX11615_H
+
+#include "qemu/osdep.h"
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
diff --git a/hw/arm/aspeed_ast2600_fby4.c b/hw/arm/aspeed_ast2600_fby4.c
index 1f391022a2..c55f7ca895 100644
--- a/hw/arm/aspeed_ast2600_fby4.c
+++ b/hw/arm/aspeed_ast2600_fby4.c
@@ -11,6 +11,7 @@
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/nvram/eeprom_at24c.h"
+#include "hw/sensor/max11615.h"
 #include "hw/i2c/i2c_mux_pca954x.h"
 #include "hw/gpio/pca9552.h"
 
@@ -185,7 +186,12 @@ static void fby4_i2c_init_fanboard(I2CSlave *fan_mux, size_t eepromSize)
         i2c_slave_create_simple(bus, "max31790", 0x2f);
 
         /* maxim,max11615 @ 0x33   (adc) */
-        /* TODO */
+        static const uint16_t adc_values[8] = {
+            1922, 1000,
+            1922, 1000,
+            1922, 1000,
+            1922, 1000};
+        max11615_init_with_values(bus, 0x33, adc_values, 8);
 
         at24c_eeprom_init_rom(
             bus, 0x52, eepromSize,
diff --git a/hw/sensor/max11615.c b/hw/sensor/max11615.c
new file mode 100644
index 0000000000..594bc3d290
--- /dev/null
+++ b/hw/sensor/max11615.c
@@ -0,0 +1,312 @@
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
+#include "hw/sensor/max11615.h"
+#include "hw/i2c/i2c.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/osdep.h"
+#include "trace.h"
+
+#define MAX11615_NUM_CHANNELS 8
+
+struct MAX11615State {
+    I2CSlave i2c;
+
+    /* true: single-ended mode, false: differential mode */
+    bool single_ended;
+
+    /*
+     * Output data coding for the MAX11612–MAX11617 is
+     * binary in unipolar mode and two’s complement in bipolar mode
+     */
+    bool bipolar;
+
+    /* The MAX11613/MAX11615/MAX11617 feature a 2.048V internal reference */
+    uint16_t vref;
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
+static void max11615_set_outbuf(MAX11615State *s, uint16_t value)
+{
+    uint8_t msb = value >> 8;
+    uint8_t lsb = value & 0xff;
+    s->outbuf[0] = 0b11110000 | (msb & 0b00001111);
+    s->outbuf[1] = lsb;
+}
+
+static void max11615_read_single_ended(MAX11615State *s)
+{
+    /* Table 3. Channel Selection in Single-Ended Mode */
+    /* read an ADC channel, first 4 bits must be high */
+    uint16_t value = s->channels[s->pointer];
+    /*
+     * In single-ended mode, the MAX11612–MAX11617 always
+     * operates in unipolar mode irrespective of BIP/UNI.
+     */
+    if (value > s->vref) {
+        value = 0xfff;
+    }
+    max11615_set_outbuf(s, value);
+}
+
+static int16_t max11615_differential_value(MAX11615State *s)
+{
+    /* Table 4. Channel Selection in Differential Mode */
+    size_t i1 = s->pointer;
+    size_t i2 = (s->pointer % 2 == 0) ? s->pointer + 1 : s->pointer - 1;
+
+    const int16_t ch1 = s->channels[i1];
+    const int16_t ch2 = s->channels[i2];
+    return ch1 - ch2;
+}
+
+static void max11615_read_differential(MAX11615State *s)
+{
+    const int16_t value = max11615_differential_value(s);
+    uint16_t vu = value;
+
+    /* full-scale transition: Figure 12, Figure 13 */
+    if (s->bipolar) {
+        const uint16_t fs = s->vref / 2;
+        if (value < -fs) {
+            vu = 0b100000000000;
+        }
+        if (value > fs) {
+            vu = 0b011111111111;
+        }
+    } else {
+        /*
+         * A negative differential analog input in unipolar mode causes the
+         * digital output code to be zero
+         */
+        if (value < 0) {
+            vu = 0;
+        }
+    }
+
+    max11615_set_outbuf(s, vu);
+}
+
+static void max11615_read(MAX11615State *s)
+{
+    if (s->single_ended) {
+        max11615_read_single_ended(s);
+    } else {
+        max11615_read_differential(s);
+    }
+}
+
+static void max11615_write_config_byte(MAX11615State *s, uint8_t data)
+{
+    trace_max11615_write_config(s->i2c.address, data);
+
+    uint8_t scan_select = (data >> 5) & 0b11;
+
+    if (scan_select != 0b11) {
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented scan select\n", __func__);
+    }
+
+    uint8_t channel_select = (data >> 1) & 0b1111;
+
+    /* Table 3. Channel Selection */
+    if (channel_select >= MAX11615_NUM_CHANNELS) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid channel select", __func__);
+        channel_select = MAX11615_NUM_CHANNELS - 1;
+    }
+    s->pointer = channel_select;
+    s->single_ended = data & 0x1;
+}
+
+static void max11615_write_setup_byte(MAX11615State *s, uint8_t data)
+{
+    trace_max11615_write_setup(s->i2c.address, data);
+    /* we ignore the setup byte, not implemented */
+
+    /* 1 = no action, 0 = resets the configuration register to default */
+    const bool rst = ((data >> 1) & 0b1) == 0b0;
+
+    if (rst) {
+        s->single_ended = true;
+        s->pointer = 0;
+    }
+
+    s->bipolar = ((data >> 2) & 0b1) == 0b1;
+
+    /* Table 6. Reference Voltage */
+    const uint8_t sel = (data >> 4) & 0b111;
+
+    if (sel == 0b10 || sel == 0b11) {
+        qemu_log_mask(LOG_UNIMP, "%s: unsupported: external vref\n", __func__);
+    }
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
+    if (s->outlen >= 2) {
+        /* MAX11615 supports multichannel scan with wraparound */
+        /* see datasheet page 17 */
+
+        s->outlen = 0;
+
+        s->pointer++;
+        if (s->pointer >= MAX11615_NUM_CHANNELS) {
+            s->pointer = 0;
+        }
+    }
+
+    max11615_read(s);
+
+    const uint8_t data = s->outbuf[s->outlen++];
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
+    .fields =
+        (const VMStateField[]){ VMSTATE_BOOL(single_ended, MAX11615State),
+                                VMSTATE_BOOL(bipolar, MAX11615State),
+                                VMSTATE_UINT16(vref, MAX11615State),
+                                VMSTATE_UINT16_ARRAY(channels, MAX11615State,
+                                                     MAX11615_NUM_CHANNELS),
+                                VMSTATE_UINT8(outlen, MAX11615State),
+                                VMSTATE_UINT8_ARRAY(outbuf, MAX11615State, 2),
+                                VMSTATE_UINT8(pointer, MAX11615State),
+                                VMSTATE_I2C_SLAVE(i2c, MAX11615State),
+                                VMSTATE_END_OF_LIST() }
+};
+
+I2CSlave *max11615_init_with_values(I2CBus *bus, uint8_t address,
+                                    const uint16_t *init_values,
+                                    uint32_t init_values_size)
+{
+    MAX11615State *s;
+
+    s = MAX11615(i2c_slave_new(TYPE_MAX11615, address));
+
+    for (int i = 0; i < MAX11615_NUM_CHANNELS; i++) {
+        /* arbitrary value if there is no data*/
+        s->channels[i] =
+            i < init_values_size ? init_values[i] : 0b0000101011010010;
+    }
+
+    i2c_slave_realize_and_unref(I2C_SLAVE(s), bus, &error_abort);
+
+    return I2C_SLAVE(s);
+}
+
+static void max11615_reset(DeviceState *dev)
+{
+    MAX11615State *s = MAX11615(dev);
+
+    s->single_ended = true;
+    s->bipolar = false;
+    s->vref = 2048;
+    s->pointer = 0;
+    s->outlen = 0;
+
+    for (int i = 0; i < MAX11615_NUM_CHANNELS; i++) {
+        s->channels[i] = 0b0000101011010010;
+    }
+}
+
+static void max11615_realize(DeviceState *dev, Error **errp)
+{
+    MAX11615State *s = MAX11615(dev);
+
+    trace_max11615_realize(s->i2c.address);
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
+    dc->legacy_reset = max11615_reset;
+    k->event = max11615_event;
+    k->recv = max11615_recv;
+    k->send = max11615_send;
+}
+
+static const TypeInfo max11615_info = {
+    .name = TYPE_MAX11615,
+    .parent = TYPE_I2C_SLAVE,
+    .instance_size = sizeof(MAX11615State),
+    .class_size = sizeof(MAX11615Class),
+    .class_init = max11615_class_init,
+};
+
+static void max11615_register_types(void)
+{
+    type_register_static(&max11615_info);
+}
+
+type_init(max11615_register_types)
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
diff --git a/hw/sensor/Kconfig b/hw/sensor/Kconfig
index 767f198e92..441bee7604 100644
--- a/hw/sensor/Kconfig
+++ b/hw/sensor/Kconfig
@@ -47,3 +47,7 @@ config MAX31785
 config MAX31790
     bool
     depends on I2C
+
+config MAX11615
+    bool
+    depends on I2C
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
index 0bde02e676..23e34d8297 100644
--- a/hw/sensor/trace-events
+++ b/hw/sensor/trace-events
@@ -15,3 +15,11 @@ max31790_pwm_write(uint8_t i2c_addr, size_t index, uint16_t value) "i2c_addr: 0x
 max31790_rpm_write(uint8_t i2c_addr, size_t index, uint16_t value) "i2c_addr: 0x%02x, index: %zu, value: 0x%04x"
 max31790_tach_count_reg(uint8_t i2c_addr, size_t index, uint16_t value) "i2c_addr: 0x%02x, index: %zu, value: 0x%04x"
 
+# max11615.c
+max11615_write_setup(uint8_t i2c_addr, uint8_t send) "i2c_addr: 0x%02x, data: 0x%02x"
+max11615_write_config(uint8_t i2c_addr, uint8_t send) "i2c_addr: 0x%02x, data: 0x%02x"
+max11615_recv(uint8_t i2c_addr, uint8_t reg_addr) "i2c_addr: 0x%02x, reg_addr: 0x%02x"
+max11615_recv_return(uint8_t i2c_addr, uint8_t data) "i2c_addr: 0x%02x, returns: 0x%02x"
+max11615_event(uint8_t i2c_addr, uint8_t event) "i2c_addr: 0x%02x, event: 0x%02x"
+max11615_realize(uint8_t i2c_addr) "i2c_addr: 0x%02x"
+
diff --git a/tests/functional/arm/test_aspeed_fby4.py b/tests/functional/arm/test_aspeed_fby4.py
index dc2437a533..4ace4985d2 100755
--- a/tests/functional/arm/test_aspeed_fby4.py
+++ b/tests/functional/arm/test_aspeed_fby4.py
@@ -60,6 +60,14 @@ def do_test_arm_aspeed_openbmc_no_network(self, machine, image, uboot,
         exec_command_and_wait_for_pattern(self,
             "cat /sys/class/hwmon/hwmon2/fan1_input", "10685");
 
+        # MAX11615 test
+        exec_command_and_wait_for_pattern(self,
+            "cat /sys/bus/i2c/devices/30-0033/iio:device*/name", "max11615");
+        exec_command_and_wait_for_pattern(self,
+            "cat /sys/bus/i2c/devices/30-0033/iio:device*/in_voltage0_raw", "4095");
+        exec_command_and_wait_for_pattern(self,
+            "cat /sys/bus/i2c/devices/30-0033/iio:device*/in_voltage_scale", "0.500000000");
+
     def test_arm_ast2600_yosemitev4_openbmc(self):
         image_path = self.uncompress(self.ASSET_YOSEMITE_V4_FLASH)
 
-- 
2.54.0


