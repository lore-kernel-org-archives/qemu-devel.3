Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1314BCD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 12:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSwZV-0001CR-Et; Fri, 29 May 2026 08:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wSwZF-00010m-Ai
 for qemu-devel@nongnu.org; Fri, 29 May 2026 08:44:06 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wSwZ9-0004lM-8p
 for qemu-devel@nongnu.org; Fri, 29 May 2026 08:44:00 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-45ef56d9b67so195461f8f.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 05:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1780058632; x=1780663432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C5YfvPix9JRVMLq5pqy0F5KTeMae+z3jj4lvXkKKiEY=;
 b=YjqsjYwR2XzsfnoRevC4+rf/cNndHk/7f1EruLa8KLtaicG/yhGslA9+/ftrg1oM+D
 zdE84rXdbDd/e1zLWA3B3RAVO3igVtcQbZjZZ3TgG8MLRi35r3Y2fulmfU6nyWk1TRdK
 dIQgazleG/2uIrQ8Vwk84eQfQ9w2sFsyCOT+Ut7fkAibJXgqtraHuIi5Io4SkVHH6g42
 fd/XbIn0n/c708svYvMlQmgvfkk0tORrA6io/ihFmaa8Z2LEZ1p4zv8BqJDfIBZ37dTI
 4H1kNY6/UAvZb4WoGb1xVvpCyKT816n0F+cygxU4jJlhN6h517FEADA1j9wquD6ti1Jz
 kAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780058632; x=1780663432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C5YfvPix9JRVMLq5pqy0F5KTeMae+z3jj4lvXkKKiEY=;
 b=CPAmIibkvr8ObEto+j38aPTVWyv5D3eoDKHtKYnqRQVwStfpSru5d0rl5coF7v85RV
 xH/a0J+uzj23fv9LFMlgQ0j3Ddkz5ZURm/MfcmbEZL2MmwTj64Mb4Kc5UviDNzOsYv5O
 HyYJgcjB2seTgUKDsReuGpJvsGa0pA9laYYSUFzZFCiaE0CSVpNiuSKqFU1bRrNoW6sv
 TEXD5z9nUlpLbt8+kUs+9YhCJKJT1lYMlrYealE+vHOU+9ylAMn3zhzjt8BeFfL2bPrR
 x7Dx2ru0kj5UxEZ8n+6psnRDZXL7P/REwQPLRICqOmCieO1DLvpmvkO9J7e7zrdEGO9w
 8FJA==
X-Gm-Message-State: AOJu0YxIJ4aXFg2dENC0LvT1PwbKoEIGunk7k5FfodsSAOhLMEoQ83T7
 AZnvW5nHpxFCZeNP7UrBHagS5Nj5Bs5EAKY2Hn+VBdXgxE1YwLMHfc87kXc1LE94GjrERLYT72J
 mDn8DssE=
X-Gm-Gg: Acq92OFOwP1QtnxERTA/YoSBEUMKNxazF1+hepBawW+OHf4LrBbwudI0GnJEhYmoxMp
 ZwJphB3aphR1oQn8WVJFI7K+uXrEKMPGyMm6nhmHxCNZoVjAMZeIruxclRrDzIP3r3t93Ltv3Zi
 efkUjJey8/VcyhDa5SaoHfOSVKhSwItLxReawzV8+kkYsXTkZn/9WT1r6+63O6eeMDx6mymqv3o
 pDf3LbsIaqdxkeGhHYxcVojPNRpfcwZ78IYz36xs7UeGQIAEHVsvvIfFb0XxiHr/ZKmQyyMIm/n
 ZqeeHvMcODcRPvC7xkstrmpOATecwSMegyLL7wBm22fcw2J3IiIAqgcm4fh+OP4Pc0SK2c956I3
 UtqeqVVSlbwUKfOD0BGQGgdCwmL8YFRHd8+V+C4bERmqsRyDBqg4uFRuNgf8OfdolFZ+yEFvqGe
 NJgmEQTmZG4/+iXgqKueUTuf4cVldhbEGKcAE+Yz3anyiWF57+RsItUI9HhJbv94QyUw==
X-Received: by 2002:a05:6000:481c:b0:43f:e934:50ac with SMTP id
 ffacd0b85a97d-45ef13fd680mr4852362f8f.7.1780058632019; 
 Fri, 29 May 2026 05:43:52 -0700 (PDT)
Received: from alexanderarchlinux ([188.111.3.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef35598e5sm3163354f8f.27.2026.05.29.05.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 05:43:51 -0700 (PDT)
From: Alexander Hansen <alexander.hansen@9elements.com>
To: qemu-devel@nongnu.org
Cc: Alexander Hansen <alexander.hansen@9elements.com>,
 Titus Rwantare <titusr@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH v5 5/5] hw/sensor: support Texas Instruments ADC128D818
Date: Fri, 29 May 2026 14:37:34 +0200
Message-ID: <20260529124237.94087-6-alexander.hansen@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529124237.94087-1-alexander.hansen@9elements.com>
References: <20260529124237.94087-1-alexander.hansen@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alexander.hansen@9elements.com; helo=mail-wr1-x42d.google.com
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

ADC128D818 Support:
- channel readings from pre-set values
- driver can read and write most configuration registers

ADC128D818 currently unsupported:
- slave address restriction
- startup sequence and realistic busy register emulation
- external VREF
- conversion rate
- interrupts
- deep shutdown mode
- individual channel shutdown
- selection between Mode 0,1,2,3
- pseudo-differential input

Anyone could expand it in the future for more accurate emulation.

The reason for adding this device is to support Yosemite V4 emulation.

Tested: on yosemite v4 qemu

initialize the device:
// ti,adc128d818 @ 0x1f    (adc)
// the driver will throw away the last 4 bits, set them 0
uint16_t adc_values1[8] = {
    0b011110000000, 0b010100010000,
    0b001000110000, 0b100000100000,
    0b011110000000, 0b010100010000,
    0b001000110000, 0b100000100000};
adc128d818_init_with_values(bus, 0x1f, adc_values1, 8);

Trace outputs directly after initialization:
adc128d818_realize i2c_addr: 0x1f
adc128d818_realize i2c_addr: 0x1f
adc128d818_event i2c_addr: 0x1f, event: 0x01
adc128d818_send i2c_addr: 0x1f, data: 0x00
adc128d818_send i2c_addr: 0x1f, data: 0x80
adc128d818_write i2c_addr: 0x1f, reg: 0x00 data: 0x80
adc128d818_event i2c_addr: 0x1f, event: 0x03
adc128d818_event i2c_addr: 0x1f, event: 0x01
...

read the values
root@yosemite4:/sys/bus/i2c/devices/30-001f# cat hwmon/hwmon0/in0_min
0
root@yosemite4:/sys/bus/i2c/devices/30-001f# cat hwmon/hwmon0/in0_max
0
root@yosemite4:/sys/bus/i2c/devices/30-001f# cat hwmon/hwmon0/in0_input
75
root@yosemite4:/sys/bus/i2c/devices/30-001f# cat hwmon/hwmon0/name
adc128d818

We initially configured 0b011110000000 for the first channel.
The driver throws away the last 4 bits and does calculation similar to
below:

val = DIV_ROUND_CLOSEST(data->in[index][nr] * data->vref, 4095);

We can check that the calculation is as expected given our configured
value.

((0b011110000000 >> 4) * 2560) / 4095
75.01831501831502

References:
[1] https://www.ti.com/product/ADC128D818
[2] https://www.ti.com/lit/gpn/adc128d818

Cc: Titus Rwantare <titusr@google.com>
Cc: "Cédric Le Goater" <clg@kaod.org> (maintainer:ASPEED BMCs)
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Paolo Bonzini <pbonzini@redhat.com> (maintainer:Kconfig)
Cc: Peter Maydell <peter.maydell@linaro.org> (supporter:ARM TCG CPUs)
Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org> (odd fixer:Overall sensors)
Cc: qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Cc: qemu-devel@nongnu.org (open list:All patches CC here)
Signed-off-by: Alexander Hansen <alexander.hansen@9elements.com>
---
 MAINTAINERS                              |   1 +
 include/hw/sensor/adc128d818.h           |  23 ++
 hw/arm/aspeed_ast2600_fby4.c             |   9 +-
 hw/sensor/adc128d818.c                   | 433 +++++++++++++++++++++++
 hw/arm/Kconfig                           |   1 +
 hw/sensor/Kconfig                        |   4 +
 hw/sensor/meson.build                    |   1 +
 hw/sensor/trace-events                   |   7 +
 tests/functional/arm/test_aspeed_fby4.py |  10 +
 9 files changed, 488 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/sensor/adc128d818.h
 create mode 100644 hw/sensor/adc128d818.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 195e3c7927..470e118f3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3985,6 +3985,7 @@ PMBus
 M: Titus Rwantare <titusr@google.com>
 S: Maintained
 F: hw/i2c/pmbus_device.c
+F: hw/sensor/adc128d818.c
 F: hw/sensor/adm1272.c
 F: hw/sensor/isl_pmbus_vr.c
 F: hw/sensor/max11615.c
diff --git a/include/hw/sensor/adc128d818.h b/include/hw/sensor/adc128d818.h
new file mode 100644
index 0000000000..02d75ca3e1
--- /dev/null
+++ b/include/hw/sensor/adc128d818.h
@@ -0,0 +1,23 @@
+/*  Copyright 2026 9elements */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef QEMU_ADC128D818_H
+#define QEMU_ADC128D818_H
+
+#include "qemu/osdep.h"
+#include "hw/i2c/i2c.h"
+
+#define TYPE_ADC128D818 "adc128d818"
+
+/*
+ * Create and realize a adc128d818 ADC with constant caller-supplied readings
+ * @bus: I2C bus to put it on
+ * @address: I2C address
+ * @init_values: array of readings for each ADC channel
+ * @init_values_size: Size of @init_values, can be less than the number of
+ * channels
+ */
+I2CSlave *adc128d818_init_with_values(I2CBus *bus, uint8_t address,
+                                      const uint16_t *init_values,
+                                      uint32_t init_values_size);
+
+#endif
diff --git a/hw/arm/aspeed_ast2600_fby4.c b/hw/arm/aspeed_ast2600_fby4.c
index c55f7ca895..cfcf689723 100644
--- a/hw/arm/aspeed_ast2600_fby4.c
+++ b/hw/arm/aspeed_ast2600_fby4.c
@@ -12,6 +12,7 @@
 #include "hw/arm/aspeed_soc.h"
 #include "hw/nvram/eeprom_at24c.h"
 #include "hw/sensor/max11615.h"
+#include "hw/sensor/adc128d818.h"
 #include "hw/i2c/i2c_mux_pca954x.h"
 #include "hw/gpio/pca9552.h"
 
@@ -162,7 +163,13 @@ static void fby4_i2c_init_fanboard(I2CSlave *fan_mux, size_t eepromSize)
         I2CBus *bus = pca954x_i2c_get_bus(fan_mux, i);
 
         /* ti,adc128d818 @ 0x1f    (adc) */
-        /* TODO */
+        /* the driver will throw away the last 4 bits, set them 0 */
+        static const uint16_t adc_values1[8] = {
+            0b011110000000, 0b010100010000,
+            0b001000110000, 0b100000100000,
+            0b011110000000, 0b010100010000,
+            0b001000110000, 0b100000100000};
+        adc128d818_init_with_values(bus, 0x1f, adc_values1, 8);
 
         /* maxim,max31790 @ 0x20   (pwm) */
         i2c_slave_create_simple(bus, "max31790", 0x20);
diff --git a/hw/sensor/adc128d818.c b/hw/sensor/adc128d818.c
new file mode 100644
index 0000000000..7ad7c935fc
--- /dev/null
+++ b/hw/sensor/adc128d818.c
@@ -0,0 +1,433 @@
+/*
+ * Texas Instruments ADC128D818 12 bit ADC with temperature sensor
+ * Models ADC128D818
+ *
+ * Product: https://www.ti.com/product/ADC128D818
+ * Datasheet: https://www.ti.com/lit/gpn/adc128d818
+ *
+ * Copyright 2026 9elements
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "hw/sensor/adc128d818.h"
+#include "hw/i2c/i2c.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/osdep.h"
+#include "trace.h"
+
+/* 8 bit, r/w */
+#define REG_CONFIG 0x00
+
+/* 8 bit, readonly */
+#define REG_INTERRUPT_STATUS 0x01
+
+/* 8 bit, r/w */
+#define REG_INTERRUPT_MASK 0x03
+
+/* 8 bit, r/w */
+#define REG_CONVERSION_RATE 0x07
+
+/* 8 bit, r/w */
+#define REG_CHANNEL_DISABLE 0x08
+
+/* 8 bit, write-only */
+#define REG_ONE_SHOT 0x09
+
+/* 8 bit, r/w */
+#define REG_DEEP_SHUTDOWN 0x0a
+
+/* 8 bit, r/w */
+#define REG_ADVANCED_CONFIG 0x0b
+
+/* 8 bit, readonly */
+#define REG_BUSY_STATUS 0x0c
+
+/* 16 bit registers, N = 0..7, readonly */
+#define REG_CHANNEL_READING(N) (0x20 + N)
+
+/* 8 bit registers N = 0..15, r/w */
+#define REG_LIMIT(N) (0x2a + N)
+
+/* 8 bit register, readonly */
+#define REG_MANUFACTURER_ID 0x3e
+
+/* 8 bit register, readonly */
+#define REG_REVISION_ID 0x3f
+
+#define ADC128D818_NUM_CHANNELS 8
+
+struct ADC128D818State {
+    I2CSlave i2c;
+
+    uint8_t config;
+    uint8_t interrupt_status;
+    uint8_t interrupt_mask;
+    uint8_t conversion_rate;
+    uint8_t channel_disable;
+    bool deep_shutdown;
+    uint8_t advanced_config;
+
+    /* channel reading registers, 2 bytes each */
+    uint16_t channels[ADC128D818_NUM_CHANNELS];
+
+    /* high and low limit registers 0x2a - 0x39, one byte each */
+    uint8_t limit[ADC128D818_NUM_CHANNELS * 2];
+
+    /* input buffer */
+    uint8_t len;
+    uint8_t buf[2];
+
+    /* output buffer */
+    uint8_t outlen;
+    uint8_t outbuf[2];
+
+    /* selected channel for read/write operation */
+    uint8_t pointer;
+};
+
+struct ADC128D818Class {
+    I2CSlaveClass parent_class;
+};
+
+OBJECT_DECLARE_TYPE(ADC128D818State, ADC128D818Class, ADC128D818)
+
+static void adc128d818_read(ADC128D818State *s)
+{
+    uint8_t ch_num = 0;
+    switch (s->pointer) {
+    case REG_CONFIG:
+        s->outbuf[0] = s->config;
+        break;
+    case REG_INTERRUPT_STATUS:
+        s->outbuf[0] = s->interrupt_status;
+        break;
+    case REG_INTERRUPT_MASK:
+        s->outbuf[0] = s->interrupt_mask;
+        break;
+    case REG_CONVERSION_RATE:
+        s->outbuf[0] = s->conversion_rate;
+        break;
+    case REG_CHANNEL_DISABLE:
+        s->outbuf[0] = s->channel_disable;
+        break;
+    case REG_ONE_SHOT:
+        /* not marked as readable */
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read of register 0x%02x\n",
+                      __func__, s->pointer);
+        s->outbuf[0] = 0x0;
+        break;
+    case REG_DEEP_SHUTDOWN:
+        s->outbuf[0] = s->deep_shutdown ? 0x1 : 0x0;
+        break;
+    case REG_ADVANCED_CONFIG:
+        s->outbuf[0] = s->advanced_config & 0b111;
+        break;
+    case REG_BUSY_STATUS:
+        /* not implemented */
+        s->outbuf[0] = 0b00000010; /* POR State */
+        break;
+    case REG_CHANNEL_READING(0):
+    case REG_CHANNEL_READING(1):
+    case REG_CHANNEL_READING(2):
+    case REG_CHANNEL_READING(3):
+    case REG_CHANNEL_READING(4):
+    case REG_CHANNEL_READING(5):
+    case REG_CHANNEL_READING(6):
+    case REG_CHANNEL_READING(7):
+        ch_num = s->pointer - REG_CHANNEL_READING(0);
+        /* high byte comes first, driver reads swapped */
+        s->outbuf[0] = (s->channels[ch_num] >> 8) & 0xff;
+        s->outbuf[1] = s->channels[ch_num] & 0xff;
+        break;
+    case REG_LIMIT(0):
+    case REG_LIMIT(1):
+    case REG_LIMIT(2):
+    case REG_LIMIT(3):
+    case REG_LIMIT(4):
+    case REG_LIMIT(5):
+    case REG_LIMIT(6):
+    case REG_LIMIT(7):
+    case REG_LIMIT(8):
+    case REG_LIMIT(9):
+    case REG_LIMIT(10):
+    case REG_LIMIT(11):
+    case REG_LIMIT(12):
+    case REG_LIMIT(13):
+    case REG_LIMIT(14):
+    case REG_LIMIT(15):
+        s->outbuf[0] = s->limit[s->pointer - REG_LIMIT(0)];
+        break;
+    case REG_MANUFACTURER_ID:
+        s->outbuf[0] = 0x1; /* readonly */
+        break;
+    case REG_REVISION_ID:
+        s->outbuf[0] = 0b00001001; /* readonly */
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read of register 0x%02x\n",
+                      __func__, s->pointer);
+        break;
+    }
+}
+
+static void adc128d818_write_advanced_config(ADC128D818State *s, uint8_t data)
+{
+    /*
+     * Note: Whenever the Advanced Configuration Register is programmed,
+     * all of the values in the Channel Reading Registers and
+     * Interrupt Status Registers will return to their default values.
+     */
+
+    s->advanced_config = (data & 0b111);
+
+    s->interrupt_status = 0x0;
+
+    /*
+     *  The channel reading registers do not have a default value.
+     * See 8.6.1 ADC128D818 Internal Registers
+     * To do something sane, just reset the channels to an arbitrary value
+     */
+
+    /* reset channels to a defined state */
+    for (int i = 0; i < ADC128D818_NUM_CHANNELS; i++) {
+
+        /* arbitrary value */
+        s->channels[i] = 0b0000101011010010;
+    }
+}
+
+static void adc128d818_write(ADC128D818State *s, uint8_t data)
+{
+    trace_adc128d818_write(s->i2c.address, s->pointer, data);
+
+    /* which bits in config register are writable */
+    const uint8_t config_w_mask = 0b10001011;
+    const uint8_t config_ro_mask = (uint8_t)~config_w_mask;
+
+    switch (s->pointer) {
+    case REG_CONFIG:
+        s->config = (s->config & config_ro_mask) | (data & config_w_mask);
+        break;
+    case REG_INTERRUPT_MASK:
+        s->interrupt_mask = data;
+        break;
+    case REG_CONVERSION_RATE:
+        s->conversion_rate = data;
+        break;
+    case REG_CHANNEL_DISABLE:
+        s->channel_disable = data;
+        break;
+    case REG_ONE_SHOT:
+        /*
+         * Initiate a single conversion and comparison cycle when
+         * the device is in shutdown mode or deep shutdown mode, after
+         * which the device returns to the respective mode that it was in
+         *
+         */
+        break;
+    case REG_DEEP_SHUTDOWN:
+        s->deep_shutdown = (data & 0x1) != 0;
+        break;
+    case REG_ADVANCED_CONFIG:
+        adc128d818_write_advanced_config(s, data);
+        break;
+    case REG_LIMIT(0):
+    case REG_LIMIT(1):
+    case REG_LIMIT(2):
+    case REG_LIMIT(3):
+    case REG_LIMIT(4):
+    case REG_LIMIT(5):
+    case REG_LIMIT(6):
+    case REG_LIMIT(7):
+    case REG_LIMIT(8):
+    case REG_LIMIT(9):
+    case REG_LIMIT(10):
+    case REG_LIMIT(11):
+    case REG_LIMIT(12):
+    case REG_LIMIT(13):
+    case REG_LIMIT(14):
+    case REG_LIMIT(15):
+        s->limit[s->pointer - REG_LIMIT(0)] = data;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write of register 0x%02x\n",
+                      __func__, s->pointer);
+        break;
+    }
+}
+
+static int adc128d818_send(I2CSlave *i2c, uint8_t data)
+{
+    ADC128D818State *s = ADC128D818(i2c);
+    trace_adc128d818_send(s->i2c.address, data);
+
+    s->outlen = 0;
+
+    if (s->len >= 2) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: wrote too many bytes\n", __func__);
+        return 1;
+    }
+
+    s->buf[s->len] = data;
+
+    if (s->len == 0) {
+        s->pointer = data;
+    } else if (s->len == 1) {
+        adc128d818_write(s, data);
+    }
+
+    s->len++;
+    return 0;
+}
+
+static uint8_t adc128d818_recv(I2CSlave *i2c)
+{
+    ADC128D818State *s = ADC128D818(i2c);
+    trace_adc128d818_recv(s->i2c.address, s->pointer);
+
+    adc128d818_read(s);
+
+    if (s->outlen >= 2) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: too many bytes read\n", __func__);
+        s->outlen = 0;
+    }
+
+    const uint8_t data = s->outbuf[s->outlen++];
+
+    trace_adc128d818_recv_return(s->i2c.address, data);
+    return data;
+}
+
+static int adc128d818_event(I2CSlave *i2c, enum i2c_event event)
+{
+    ADC128D818State *s = ADC128D818(i2c);
+
+    trace_adc128d818_event(s->i2c.address, event);
+
+    switch (event) {
+    case I2C_START_RECV:
+        s->outlen = 0;
+        break;
+    case I2C_START_SEND:
+        s->len = 0;
+        break;
+    default:
+        break;
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_adc128d818 = {
+    .name = TYPE_ADC128D818,
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields =
+        (const VMStateField[]){
+            VMSTATE_UINT8(config, ADC128D818State),
+            VMSTATE_UINT8(interrupt_mask, ADC128D818State),
+            VMSTATE_UINT8(conversion_rate, ADC128D818State),
+            VMSTATE_UINT8(channel_disable, ADC128D818State),
+            VMSTATE_BOOL(deep_shutdown, ADC128D818State),
+            VMSTATE_UINT8(advanced_config, ADC128D818State),
+            VMSTATE_UINT16_ARRAY(channels, ADC128D818State,
+                                 ADC128D818_NUM_CHANNELS),
+            VMSTATE_UINT8_ARRAY(limit, ADC128D818State,
+                                ADC128D818_NUM_CHANNELS * 2),
+            VMSTATE_UINT8(len, ADC128D818State),
+            VMSTATE_UINT8_ARRAY(buf, ADC128D818State, 2),
+            VMSTATE_UINT8(outlen, ADC128D818State),
+            VMSTATE_UINT8_ARRAY(outbuf, ADC128D818State, 2),
+            VMSTATE_UINT8(pointer, ADC128D818State),
+            VMSTATE_I2C_SLAVE(i2c, ADC128D818State), VMSTATE_END_OF_LIST() }
+};
+
+I2CSlave *adc128d818_init_with_values(I2CBus *bus, uint8_t address,
+                                      const uint16_t *init_values,
+                                      uint32_t init_values_size)
+{
+    ADC128D818State *s;
+
+    s = ADC128D818(i2c_slave_new(TYPE_ADC128D818, address));
+
+    for (int i = 0; i < ADC128D818_NUM_CHANNELS; i++) {
+
+        /* arbitrary value */
+        s->channels[i] =
+            i < init_values_size ? init_values[i] : 0b0000101011010010;
+    }
+
+    i2c_slave_realize_and_unref(I2C_SLAVE(s), bus, &error_abort);
+
+    return I2C_SLAVE(s);
+}
+
+static void adc128d818_reset(DeviceState *dev)
+{
+    ADC128D818State *s = ADC128D818(dev);
+
+    s->pointer = 0;
+    s->outlen = 0;
+
+    /* POR-State */
+    s->config = 0b00001000;
+    s->interrupt_status = 0x0;
+    s->interrupt_mask = 0;
+    s->conversion_rate = 0;
+    s->channel_disable = 0;
+    s->deep_shutdown = 0;
+    s->advanced_config = 0;
+
+    /* No POR-State defined in datasheet */
+    for (int i = 0; i < ADC128D818_NUM_CHANNELS * 2; i++) {
+        s->limit[i] = 0;
+    }
+
+    /* reset channels to a defined state */
+    for (int i = 0; i < ADC128D818_NUM_CHANNELS; i++) {
+
+        /* arbitrary value */
+        s->channels[i] = 0b0000101011010010;
+    }
+}
+
+static void adc128d818_realize(DeviceState *dev, Error **errp)
+{
+    ADC128D818State *s = ADC128D818(dev);
+
+    trace_adc128d818_realize(s->i2c.address);
+}
+
+static void adc128d818_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+
+    dc->realize = adc128d818_realize;
+    dc->desc = "Texas Instruments ADC128D818 12-bit ADC with temp sensor";
+    dc->vmsd = &vmstate_adc128d818;
+    dc->legacy_reset = adc128d818_reset;
+    k->event = adc128d818_event;
+    k->recv = adc128d818_recv;
+    k->send = adc128d818_send;
+}
+
+static const TypeInfo adc128d818_info = {
+    .name = TYPE_ADC128D818,
+    .parent = TYPE_I2C_SLAVE,
+    .instance_size = sizeof(ADC128D818State),
+    .class_size = sizeof(ADC128D818Class),
+    .class_init = adc128d818_class_init,
+};
+
+static void adc128d818_register_types(void)
+{
+    type_register_static(&adc128d818_info);
+}
+
+type_init(adc128d818_register_types)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 76a7d327a9..cc89c65e3f 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -554,6 +554,7 @@ config ASPEED_SOC
     select MAX31785
     select MAX31790
     select MAX11615
+    select ADC128D818
     select FSI_APB2OPB_ASPEED
     select AT24C
     select PCI_EXPRESS
diff --git a/hw/sensor/Kconfig b/hw/sensor/Kconfig
index 441bee7604..a640958257 100644
--- a/hw/sensor/Kconfig
+++ b/hw/sensor/Kconfig
@@ -51,3 +51,7 @@ config MAX31790
 config MAX11615
     bool
     depends on I2C
+
+config ADC128D818
+    bool
+    depends on I2C
diff --git a/hw/sensor/meson.build b/hw/sensor/meson.build
index a1e26604fa..defd7647e7 100644
--- a/hw/sensor/meson.build
+++ b/hw/sensor/meson.build
@@ -10,3 +10,4 @@ system_ss.add(when: 'CONFIG_ISL_PMBUS_VR', if_true: files('isl_pmbus_vr.c'))
 system_ss.add(when: 'CONFIG_MAX31785', if_true: files('max31785.c'))
 system_ss.add(when: 'CONFIG_MAX31790', if_true: files('max31790.c'))
 system_ss.add(when: 'CONFIG_MAX11615', if_true: files('max11615.c'))
+system_ss.add(when: 'CONFIG_ADC128D818', if_true: files('adc128d818.c'))
diff --git a/hw/sensor/trace-events b/hw/sensor/trace-events
index 23e34d8297..dc6cf26a0b 100644
--- a/hw/sensor/trace-events
+++ b/hw/sensor/trace-events
@@ -23,3 +23,10 @@ max11615_recv_return(uint8_t i2c_addr, uint8_t data) "i2c_addr: 0x%02x, returns:
 max11615_event(uint8_t i2c_addr, uint8_t event) "i2c_addr: 0x%02x, event: 0x%02x"
 max11615_realize(uint8_t i2c_addr) "i2c_addr: 0x%02x"
 
+# adc128d818.c
+adc128d818_send(uint8_t i2c_addr, uint8_t data) "i2c_addr: 0x%02x, data: 0x%02x"
+adc128d818_write(uint8_t i2c_addr, uint8_t reg, uint8_t data) "i2c_addr: 0x%02x, reg: 0x%02x data: 0x%02x"
+adc128d818_recv(uint8_t i2c_addr, uint8_t reg) "i2c_addr: 0x%02x, reg: 0x%02x"
+adc128d818_recv_return(uint8_t i2c_addr, uint8_t data) "i2c_addr: 0x%02x, returns: 0x%02x"
+adc128d818_event(uint8_t i2c_addr, uint8_t event) "i2c_addr: 0x%02x, event: 0x%02x"
+adc128d818_realize(uint8_t i2c_addr) "i2c_addr: 0x%02x"
diff --git a/tests/functional/arm/test_aspeed_fby4.py b/tests/functional/arm/test_aspeed_fby4.py
index 4ace4985d2..4957d3d89f 100755
--- a/tests/functional/arm/test_aspeed_fby4.py
+++ b/tests/functional/arm/test_aspeed_fby4.py
@@ -68,6 +68,16 @@ def do_test_arm_aspeed_openbmc_no_network(self, machine, image, uboot,
         exec_command_and_wait_for_pattern(self,
             "cat /sys/bus/i2c/devices/30-0033/iio:device*/in_voltage_scale", "0.500000000");
 
+        # ADC128D818 test
+        exec_command_and_wait_for_pattern(self,
+            "cat /sys/bus/i2c/devices/30-001f/hwmon/hwmon0/name", "adc128d818");
+        exec_command_and_wait_for_pattern(self,
+            "cat /sys/bus/i2c/devices/30-001f/hwmon/hwmon0/in0_input", "108");
+        exec_command_and_wait_for_pattern(self,
+            "cat /sys/bus/i2c/devices/30-001f/hwmon/hwmon0/in0_min", "0");
+        exec_command_and_wait_for_pattern(self,
+            "cat /sys/bus/i2c/devices/30-001f/hwmon/hwmon0/in0_max", "0");
+
     def test_arm_ast2600_yosemitev4_openbmc(self):
         image_path = self.uncompress(self.ASSET_YOSEMITE_V4_FLASH)
 
-- 
2.54.0


