Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F70CCA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 12:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGbv3-0006rO-8k; Tue, 13 Oct 2026 08:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1xGbuy-0006p2-Os
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 08:47:44 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1xGbuv-0008TI-TD
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 08:47:44 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48afe75f055so2699087f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 05:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1791895659; x=1792500459; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5V1ADJWSpqmE/0EppqJvQTXhFh4gYt9LFpGCgzibkxw=;
 b=ZjRIS2ll0LxHGwJc7ueAAoTOy4YPTrJyhisC7gPGemLF78FWxznRcrfNq8zoTuoJ9b
 WsMZZBuBzB0QO0oX/bvnOs6Touv6YvGlEav8MMU3fZJcti6SfwuObVZeaQkTCFDmyC2S
 Go86emwYeDu6uLSYJiIi6hqoyDCKcUoZwXtB3F7akZTk9NakedTwlnefvVciGCNpSs5q
 tBne+JY0+ZJTLu6Z6Pg41jkC/sJr/DyJdHkRBOKfIgkCqePGZ5Oyvn0Q2mzX25GdwlVo
 LU3sHMr6ZIHcYgrGb4BxFbgvNJpjYw3NPApNc5XQqnkYVRJ1A/NIaUHR+bsOHOjBG/CR
 gyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791895659; x=1792500459;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5V1ADJWSpqmE/0EppqJvQTXhFh4gYt9LFpGCgzibkxw=;
 b=kgB30h4k5LPBNai4EArawdlcC4Jt1fRi6CTuKtn4UxDKOGkiZ/bfg4NNhkAGWf47oV
 v55SW7+OpaMnUCVj0TadmpIB+MIrdsFelOw+qRKjv/5mZThtwdiEeb6ojBsScRo0z/cK
 FRCPjdWIJxTvd4/RnKuZ2+gcAH8gCpk67luREWn4euc1b/PeqrQKmgFNM0FDELYbe3gO
 m+0DOlqej5aIgDXUMYIB4gSsharKK+Zk/MKxhXjM26/AphPfVInmYg7cDs3IopTd/0ms
 rlUGk9aXcYlOQMLdMw1cq1yQV7SotrCwmWnnqrTeard18ZussM+jWNyT8ZwZzSYbd7yX
 CGTw==
X-Gm-Message-State: AFq9FYKKhxn89qfhmBnA1JvRAXcvx/BWP9w/Ar/ODCbBBsiuuCa6FVCn
 YPNJ09l/IKOJMc/s82AmAtO+aw3GWP13TiyiHz/HFi18TE0pwJzzdFPkBZxs6Jt9/Qt/LaTyxYU
 Ojwc7
X-Gm-Gg: AYBFou0eLBz/nNmY7a1dMeKsGq+LcgNLozt15gYcg//H/drPFGy/SayUCdqvzOyemYX
 9JjYMC5TxHqRcNspwRaoVOwfQqyTLlJYO5mHJhwf/sdRAP4Iy7Sy/pLkJS/uCGB9xS7ESZ3xf+A
 49IdnjzliXxGGTj3gGHu1okFgfqTtX8eipX1hiuK4PAicdypKQ5Bh7rCpNvYtReZcAcxdl8Mp5S
 A+RfUOX4lmPCdpSuO3FtabxE7vkSZDU4kBlovPPKwZ7+w4d6ow6iuThvopMjnzb9g9tRjz551mc
 /txMO6T8x02157vg+D7xEMTV1gk+gJmBFv7tLlibt2vQLn0n3WrNUHkHR33lCWug78glgkrM3ZB
 3Hgy+DfNeKauIAysnnaS8Cno46+SvuhcBtGBtwmauZFS8e6nn1KN4ih/C4d6tYE5BteWerJQBuh
 89MCN8+qDTJEGOq/ukA/Q99t6GaTqJh9UPnDJ5ZcGR9RILG+6z5f98MmUFK58fuczIu+MusiA06
 cfyRkAhC5UlEwKLnfYKfp0=
X-Received: by 2002:a05:600c:8b65:b0:4a1:742e:3 with SMTP id
 5b1f17b1804b1-4a18e4ca244mr226734305e9.27.1791895659048; 
 Tue, 13 Oct 2026 05:47:39 -0700 (PDT)
Received: from localhost.localdomain ([188.111.3.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc4ebbsm4768847f8f.45.2026.10.13.05.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 05:47:38 -0700 (PDT)
From: <alexander.hansen@9elements.com>
To: qemu-devel@nongnu.org
Cc: eblot@meta.com, titusr@google.com, clg@kaod.org,
 Alexander Hansen <alexander.hansen@9elements.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v8 5/5] hw/sensor: support MAX11615
Date: Tue, 13 Oct 2026 14:46:49 +0200
Message-ID: <20261013124649.194808-6-alexander.hansen@9elements.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261013124649.194808-1-alexander.hansen@9elements.com>
References: <20261013124649.194808-1-alexander.hansen@9elements.com>
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

From: Alexander Hansen <alexander.hansen@9elements.com>

Product: [1]
Datasheet: [2]

The ADC reads a pre-defined arbitrary value.

root@yosemite4:~# cat /sys/bus/iio/devices/iio:device2/name
max11615
root@yosemite4:~# cat /sys/bus/iio/devices/iio:device2/in_voltage0_raw
722
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

Cc: Emmanuel Blot <eblot@meta.com>
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
 hw/arm/Kconfig                           |   1 +
 hw/arm/aspeed_ast2600_fby4.c             |   3 +-
 hw/sensor/Kconfig                        |   4 +
 hw/sensor/max1161x.c                     | 314 +++++++++++++++++++++++
 hw/sensor/meson.build                    |   1 +
 hw/sensor/trace-events                   |   9 +
 include/hw/sensor/max1161x.h             |   7 +
 tests/functional/arm/test_aspeed_fby4.py |   9 +
 9 files changed, 348 insertions(+), 1 deletion(-)
 create mode 100644 hw/sensor/max1161x.c
 create mode 100644 include/hw/sensor/max1161x.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 870152932c..6bd06dd3ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4119,6 +4119,7 @@ S: Maintained
 F: hw/i2c/pmbus_device.c
 F: hw/sensor/adm1272.c
 F: hw/sensor/isl_pmbus_vr.c
+F: hw/sensor/max1161x.c
 F: hw/sensor/max31790.c
 F: hw/sensor/max34451.c
 F: include/hw/i2c/pmbus_device.h
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index ac7e5096aa..25572cfe1b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -546,6 +546,7 @@ config ASPEED_SOC
     select MAX31785
     select ADC128D818
     select MAX31790
+    select MAX1161X
     select FSI_APB2OPB_ASPEED
     select AT24C
     select PCI_EXPRESS_ASPEED
diff --git a/hw/arm/aspeed_ast2600_fby4.c b/hw/arm/aspeed_ast2600_fby4.c
index 5e49c2e7ea..40c25477ee 100644
--- a/hw/arm/aspeed_ast2600_fby4.c
+++ b/hw/arm/aspeed_ast2600_fby4.c
@@ -11,6 +11,7 @@
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/nvram/eeprom_at24c.h"
+#include "hw/sensor/max1161x.h"
 #include "hw/i2c/i2c_mux_pca954x.h"
 #include "hw/sensor/max31790.h"
 #include "hw/gpio/pca9552.h"
@@ -188,7 +189,7 @@ static void fby4_i2c_init_fanboard(I2CSlave *fan_mux, size_t eepromSize)
         i2c_slave_create_simple(bus, TYPE_MAX31790, 0x2f);
 
         /* maxim,max11615 @ 0x33   (adc) */
-        /* TODO */
+        i2c_slave_create_simple(bus, TYPE_MAX11615, 0x33);
 
         at24c_eeprom_init_rom(bus, 0x52, eepromSize, fru_yv4_fanboard_bin,
                               fru_yv4_fanboard_bin_len);
diff --git a/hw/sensor/Kconfig b/hw/sensor/Kconfig
index 3eeffd32cd..c01d18a5fa 100644
--- a/hw/sensor/Kconfig
+++ b/hw/sensor/Kconfig
@@ -51,3 +51,7 @@ config MAX31785
 config MAX31790
     bool
     depends on I2C
+
+config MAX1161X
+    bool
+    depends on I2C
diff --git a/hw/sensor/max1161x.c b/hw/sensor/max1161x.c
new file mode 100644
index 0000000000..69f7da0438
--- /dev/null
+++ b/hw/sensor/max1161x.c
@@ -0,0 +1,314 @@
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
+#include "hw/sensor/max1161x.h"
+#include "hw/i2c/i2c.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
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
+struct MAX1161XClass {
+    I2CSlaveClass parent_class;
+
+    uint8_t channel_select_mask;
+    size_t n_channels;
+};
+
+OBJECT_DECLARE_TYPE(MAX11615State, MAX1161XClass, MAX11615)
+
+static void max1161x_reset(MAX11615State *s)
+{
+    trace_max11615_reset(s->i2c.address);
+
+    s->single_ended = true;
+    s->bipolar = false;
+    s->vref = 2048;
+    s->pointer = 0;
+    s->outlen = 0;
+
+    MAX1161XClass *mc = MAX11615_GET_CLASS(s);
+
+    for (int i = 0; i < mc->n_channels; i++) {
+        s->channels[i] = 0x2d2;
+    }
+}
+
+static void max11615_set_outbuf(MAX11615State *s, uint16_t value)
+{
+    uint8_t msb = value >> 8;
+    uint8_t lsb = value & 0xff;
+    s->outbuf[0] = 0xf0 | (msb & 0xf);
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
+static int16_t max11615_differential_value(const MAX11615State *s)
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
+            vu = 0x800;
+        }
+        if (value > fs) {
+            vu = 0x7ff;
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
+    uint8_t scan_select = (data >> 5) & 0x3;
+
+    if (scan_select != 0x3) {
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented scan select\n", __func__);
+    }
+
+    const MAX1161XClass *mc = MAX11615_GET_CLASS(s);
+
+    uint8_t channel_select = (data >> 1) & mc->channel_select_mask;
+
+    /* Table 3. Channel Selection */
+    if (channel_select >= mc->n_channels) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid channel select\n",
+                      __func__);
+        channel_select = mc->n_channels - 1;
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
+    const bool rst = ((data >> 1) & 0x1) == 0x0;
+
+    if (rst) {
+        max1161x_reset(s);
+    }
+
+    s->bipolar = ((data >> 2) & 0x1) == 0x1;
+
+    /* Table 6. Reference Voltage */
+    const uint8_t sel = (data >> 4) & 0x7;
+
+    if (sel == 0x2 || sel == 0x3) {
+        qemu_log_mask(LOG_UNIMP, "%s: unsupported: external vref\n", __func__);
+    }
+}
+
+static int max11615_send(I2CSlave *i2c, uint8_t data)
+{
+    MAX11615State *s = MAX11615(i2c);
+    const uint8_t msb = (data >> 7) & 0x1;
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
+    MAX1161XClass *mc = MAX11615_GET_CLASS(s);
+
+    if (s->outlen >= 2) {
+        /* MAX11615 supports multichannel scan with wraparound */
+        /* see datasheet page 17 */
+
+        s->outlen = 0;
+
+        s->pointer++;
+        if (s->pointer >= mc->n_channels) {
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
+static void max1161x_reset_hold(Object *obj, ResetType type)
+{
+    MAX11615State *s = MAX11615(obj);
+
+    max1161x_reset(s);
+}
+
+static void max11615_realize(DeviceState *dev, Error **errp)
+{
+    MAX11615State *s = MAX11615(dev);
+
+    trace_max11615_realize(s->i2c.address);
+}
+
+static void max1161x_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    MAX1161XClass *mc = MAX11615_CLASS(klass);
+
+    mc->n_channels = MAX11615_NUM_CHANNELS;
+    /* max11615 can use 3 channel select bits */
+    mc->channel_select_mask = 0x7;
+
+    dc->realize = max11615_realize;
+    dc->desc = "Maxim MAX11615 12-bit ADC";
+    dc->vmsd = &vmstate_max11615;
+    rc->phases.hold = max1161x_reset_hold;
+    k->event = max11615_event;
+    k->recv = max11615_recv;
+    k->send = max11615_send;
+}
+
+static const TypeInfo max11615_info = {
+    .name = TYPE_MAX11615,
+    .parent = TYPE_I2C_SLAVE,
+    .instance_size = sizeof(MAX11615State),
+    .class_size = sizeof(MAX1161XClass),
+    .class_init = max1161x_class_init,
+};
+
+static void max1161x_register_types(void)
+{
+    type_register_static(&max11615_info);
+}
+
+type_init(max1161x_register_types)
diff --git a/hw/sensor/meson.build b/hw/sensor/meson.build
index f2b6b07a78..efc3e6af0c 100644
--- a/hw/sensor/meson.build
+++ b/hw/sensor/meson.build
@@ -10,3 +10,4 @@ system_ss.add(when: 'CONFIG_LSM303DLHC_MAG', if_true: files('lsm303dlhc_mag.c'))
 system_ss.add(when: 'CONFIG_ISL_PMBUS_VR', if_true: files('isl_pmbus_vr.c'))
 system_ss.add(when: 'CONFIG_MAX31785', if_true: files('max31785.c'))
 system_ss.add(when: 'CONFIG_MAX31790', if_true: files('max31790.c'))
+system_ss.add(when: 'CONFIG_MAX1161X', if_true: files('max1161x.c'))
diff --git a/hw/sensor/trace-events b/hw/sensor/trace-events
index 2041c91dd9..b0d46f3f01 100644
--- a/hw/sensor/trace-events
+++ b/hw/sensor/trace-events
@@ -25,3 +25,12 @@ max31790_fan_dynamics_read(uint8_t i2c_addr, size_t channel, uint8_t value) "i2c
 max31790_fan_dynamics_write(uint8_t i2c_addr, size_t channel, uint8_t value) "i2c_addr: 0x%02x, channel: %zu, value: 0x%02x"
 max31790_fan_config_read(uint8_t i2c_addr, size_t channel, uint8_t value) "i2c_addr: 0x%02x, channel: %zu, value: 0x%02x"
 max31790_fan_config_write(uint8_t i2c_addr, size_t channel, uint8_t value) "i2c_addr: 0x%02x, channel: %zu, value: 0x%02x"
+
+# max11615.c
+max11615_write_setup(uint8_t i2c_addr, uint8_t send) "i2c_addr: 0x%02x, data: 0x%02x"
+max11615_write_config(uint8_t i2c_addr, uint8_t send) "i2c_addr: 0x%02x, data: 0x%02x"
+max11615_recv(uint8_t i2c_addr, uint8_t reg_addr) "i2c_addr: 0x%02x, reg_addr: 0x%02x"
+max11615_recv_return(uint8_t i2c_addr, uint8_t data) "i2c_addr: 0x%02x, returns: 0x%02x"
+max11615_event(uint8_t i2c_addr, uint8_t event) "i2c_addr: 0x%02x, event: 0x%02x"
+max11615_realize(uint8_t i2c_addr) "i2c_addr: 0x%02x"
+max11615_reset(uint8_t i2c_addr) "i2c_addr: 0x%02x"
diff --git a/include/hw/sensor/max1161x.h b/include/hw/sensor/max1161x.h
new file mode 100644
index 0000000000..be2e87bff4
--- /dev/null
+++ b/include/hw/sensor/max1161x.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef QEMU_MAX1161X_H
+#define QEMU_MAX1161X_H
+
+#define TYPE_MAX11615 "max11615"
+
+#endif
diff --git a/tests/functional/arm/test_aspeed_fby4.py b/tests/functional/arm/test_aspeed_fby4.py
index be396f53bc..0d81638c82 100755
--- a/tests/functional/arm/test_aspeed_fby4.py
+++ b/tests/functional/arm/test_aspeed_fby4.py
@@ -81,6 +81,15 @@ def do_test_arm_aspeed_openbmc_no_network(self, machine, image, uboot,
         exec_command_and_wait_for_pattern(self,
             "cat /sys/class/hwmon/hwmon3/fan1_input", "10347");
 
+        # MAX11615 test
+        exec_command_and_wait_for_pattern(self,
+            "cat /sys/bus/i2c/devices/30-0033/iio:device*/name", "max11615");
+        # read the value configured in the machine emulation
+        exec_command_and_wait_for_pattern(self,
+            "cat /sys/bus/i2c/devices/30-0033/iio:device*/in_voltage0_raw", "722");
+        exec_command_and_wait_for_pattern(self,
+            "cat /sys/bus/i2c/devices/30-0033/iio:device*/in_voltage_scale", "0.500000000");
+
     def test_arm_ast2600_yosemitev4_openbmc(self):
         image_path = self.uncompress(self.ASSET_YOSEMITE_V4_FLASH)
 
-- 
2.56.0


