Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C01ACA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 12:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGbv3-0006re-QC; Tue, 13 Oct 2026 08:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1xGbuw-0006oN-Ng
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 08:47:44 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1xGbut-0008S7-7P
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 08:47:42 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a02667ccebso20799465e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 05:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1791895657; x=1792500457; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3/6R1147KZfht+1p3T50eqA6qdikqBhR3ABcdY9Uv28=;
 b=cmiQ+k4baz+4FR+QgQZ0cViOK+CbRt562u9J9TeO0ZBegxkWhcvuTQsIa2DyulsUtg
 pp7MHLT3CvtSe9TYXf8w5DzIUrZC+b6E26RPuxGalRR5dsOGuQZNS443Ru0fqH90lFmF
 LK5NcUJawcr6kLNkR6cirTsEOJ4ksMyS7IlMWmzeLszPEgTBh7VSLoqkrIuEI9/MgCpx
 ZvwpQRW3ydpDihDfpnWS9E5RW3CqfH7X9duMCkX5+gz8gUxNxJwPUvKejxjgiz2ovs0J
 gqEA8HDmSi4SYsc3dUK1OVaXDmgSJZHThThq4Bo5Ilb2iZs7ZRW1dKhF4zIct/UxN1Gw
 27vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791895657; x=1792500457;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3/6R1147KZfht+1p3T50eqA6qdikqBhR3ABcdY9Uv28=;
 b=x+MwCYis2sMv02q3TBzCBWU6RHDJ1Hk3U0rA9VNwcOuFinbvjhtaFSFnISfXkt0nAE
 SaVhGWmge0Ma05dIzKbIw4/18iLxYGuX+54b0BgPoFkN61U35x+XcCqiYdJnYPThxxVm
 3PYW9V2GP3/guopevbm7xN4DQNUhdDcwUBlFrs2yv0LHxOE10vRm/j3MJUqT9p8A4aSG
 W5Bc8DATRZxnvJhHMcmbWe+86lYQdLPQOxUilcWo5s/JISy1vxgAk3gd9KtnLFJjerAe
 Vuogww/9Xejj/xE29NwVj7f0IvsTCJnTOpIK41WegXtKAVvhYcxad/WASRc8veYa8lUq
 YuQQ==
X-Gm-Message-State: AFq9FYJJaeFIi8hrTd0gj5YXJTl89LDoI2W+fQ7II/o2mjVCnFVHGBz8
 8RcPhU7sF8xjlCoEjz8Sws6wlU4bo/rpMiEAsDI+7Y83fI4G3tHtHLGRRDEDW816eG62+hJyP57
 VqLmD
X-Gm-Gg: AYBFou1kckVp70Y7nXPu45zsGUagNcYbrKuRyPWm9yLh4MeCbNZ1xZLv2J1j3JOoXv9
 xRFfDjcFKt5GNBqrFYCtDKpwpgxkDi7DivTY24EpwoFc3OcpA6BOH66jrpS3ygP4g+REVV2LglQ
 ARSahtA9xdswFEgb/YjAibk/ivbBywv6OWyNMh4f6pxDueA+UB51WNv+cj5JYgBs5PtvwRp3cA7
 kkJVVXYytJ9/E1CFeKJjKVzyuXDiTQJscmHKjfPn7rtorfRy3NwjrOtY198AuEQFgnE+oeUAl2D
 RJxB2/Rql5MS5QydM2Zie8e/tVrVGJj2rKXGzG6a5VnF4HZc0reJ7WivMAqkSTa3+1GHe0S0RrR
 4ryyitJSwv1KoHT7KzMOn22gM9lsCPWgIlEA+STc0EZaT9SFVOBA8j13a9EyE8YXT/Y3nxzvI0n
 9X/56pXIQm/KcqHPU71z8gUKtR3oOEeQEL16jGbx3XHbN/c6IMJZpT3PsA7CfE8fTfxCu89y1sm
 2QeKEK0ddj0MlV3oezKN3w=
X-Received: by 2002:a05:600c:4fc1:b0:49d:2536:402e with SMTP id
 5b1f17b1804b1-4a19a9cf1e6mr124467255e9.30.1791895657433; 
 Tue, 13 Oct 2026 05:47:37 -0700 (PDT)
Received: from localhost.localdomain ([188.111.3.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc4ebbsm4768847f8f.45.2026.10.13.05.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 05:47:37 -0700 (PDT)
From: <alexander.hansen@9elements.com>
To: qemu-devel@nongnu.org
Cc: eblot@meta.com, titusr@google.com, clg@kaod.org,
 Alexander Hansen <alexander.hansen@9elements.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org
Subject: [PATCH v8 4/5] hw/sensor: MAX31790 support
Date: Tue, 13 Oct 2026 14:46:48 +0200
Message-ID: <20261013124649.194808-5-alexander.hansen@9elements.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261013124649.194808-1-alexander.hansen@9elements.com>
References: <20261013124649.194808-1-alexander.hansen@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alexander.hansen@9elements.com; helo=mail-wm1-x32a.google.com
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

From: Alexander Hansen <alexander.hansen@9elements.com>

Product: [1]
Datasheet: [2]

MAX31790 Support:
- fan inputs are reading
- tach reading propertional to pwm setting from linux driver
- fans do not show any fault
- 6 PWM registers influence 6 TACH registers

There is intentional stub behavior in some places and various functions
of the device are currently unsupported.

MAX31790 currently unsupported:
- slave address restriction
- fan dynamics
- spin-up configuration
- fault state / failure possibility
- rate-of-change control
- tach mode
- mixed layouts where number of fans != number of tachs
- see Figure 5.9 in [2] for example of mixed layout

Anyone could expand it in the future for more accurate emulation.

The reason for adding this device is to support Yosemite V4 emulation.

Tested: on yosemite 4 qemu

root@yosemite4:~# ls /sys/class/hwmon/hwmon2/
device	    fan2_fault   fan3_target  fan5_fault   fan6_target  pwm2	     pwm5
fan1_enable  fan2_input   fan4_enable  fan5_input   name	pwm2_enable  pwm5_enable
fan1_fault   fan2_target  fan4_fault   fan5_target  of_node	pwm3	     pwm6
fan1_input   fan3_enable  fan4_input   fan6_enable  power	pwm3_enable  pwm6_enable
fan1_target  fan3_fault   fan4_target  fan6_fault   pwm1	pwm4	     subsystem
fan2_enable  fan3_input   fan5_enable  fan6_input   pwm1_enable  pwm4_enable  uevent
root@yosemite4:~# cat /sys/class/hwmon/hwmon2/fan1_input
4551
root@yosemite4:~# cat /sys/class/hwmon/hwmon2/fan1_enable
1
root@yosemite4:~# cat /sys/class/hwmon/hwmon2/fan1_fault
0
root@yosemite4:~# cat /sys/class/hwmon/hwmon2/fan1_target
2048
root@yosemite4:~# cat /sys/class/hwmon/hwmon2/pwm1
178
root@yosemite4:~# cat /sys/class/hwmon/hwmon2/name
max31790

Trace output:
max31790_realize i2c_addr: 0x20
max31790_realize i2c_addr: 0x2f
max31790_realize i2c_addr: 0x20
max31790_realize i2c_addr: 0x2f
max31790_event i2c_addr: 0x20, event: 0x01
max31790_send i2c_addr: 0x20, data: 0x02
max31790_event i2c_addr: 0x20, event: 0x00
max31790_recv i2c_addr: 0x20, reg_addr: 0x02
max31790_recv_return i2c_addr: 0x20, returns: 0x08
...

References:
[1] https://www.analog.com/en/products/MAX31790.html
[2] https://www.analog.com/media/en/technical-documentation/data-sheets/MAX31790.pdf

Cc: Emmanuel Blot <eblot@meta.com>
Cc: Titus Rwantare <titusr@google.com>
Cc: "Cédric Le Goater" <clg@kaod.org> (maintainer:ASPEED BMCs)
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
Cc: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org
Signed-off-by: Alexander Hansen <alexander.hansen@9elements.com>
---
 MAINTAINERS                              |   1 +
 hw/arm/Kconfig                           |   1 +
 hw/arm/aspeed_ast2600_fby4.c             |   5 +-
 hw/sensor/Kconfig                        |   4 +
 hw/sensor/max31790.c                     | 508 +++++++++++++++++++++++
 hw/sensor/meson.build                    |   1 +
 hw/sensor/trace-events                   |  13 +
 include/hw/sensor/max31790.h             |   7 +
 tests/functional/arm/test_aspeed_fby4.py |  47 +++
 9 files changed, 585 insertions(+), 2 deletions(-)
 create mode 100644 hw/sensor/max31790.c
 create mode 100644 include/hw/sensor/max31790.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1312bbd1bd..870152932c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4119,6 +4119,7 @@ S: Maintained
 F: hw/i2c/pmbus_device.c
 F: hw/sensor/adm1272.c
 F: hw/sensor/isl_pmbus_vr.c
+F: hw/sensor/max31790.c
 F: hw/sensor/max34451.c
 F: include/hw/i2c/pmbus_device.h
 F: include/hw/sensor/isl_pmbus_vr.h
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 4445f16f45..ac7e5096aa 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -545,6 +545,7 @@ config ASPEED_SOC
     select PMBUS
     select MAX31785
     select ADC128D818
+    select MAX31790
     select FSI_APB2OPB_ASPEED
     select AT24C
     select PCI_EXPRESS_ASPEED
diff --git a/hw/arm/aspeed_ast2600_fby4.c b/hw/arm/aspeed_ast2600_fby4.c
index 8c14768030..5e49c2e7ea 100644
--- a/hw/arm/aspeed_ast2600_fby4.c
+++ b/hw/arm/aspeed_ast2600_fby4.c
@@ -12,6 +12,7 @@
 #include "hw/arm/aspeed_soc.h"
 #include "hw/nvram/eeprom_at24c.h"
 #include "hw/i2c/i2c_mux_pca954x.h"
+#include "hw/sensor/max31790.h"
 #include "hw/gpio/pca9552.h"
 #include "hw/sensor/tmp105.h"
 
@@ -166,7 +167,7 @@ static void fby4_i2c_init_fanboard(I2CSlave *fan_mux, size_t eepromSize)
         i2c_slave_create_simple(bus, TYPE_ADC128D818, 0x1f);
 
         /* maxim,max31790 @ 0x20   (pwm) */
-        /* TODO */
+        i2c_slave_create_simple(bus, TYPE_MAX31790, 0x20);
 
         /*
          * ti,tca6424 @ 0x22       (gpio)
@@ -184,7 +185,7 @@ static void fby4_i2c_init_fanboard(I2CSlave *fan_mux, size_t eepromSize)
          */
 
         /* maxim,max31790 @ 0x2f   (pwm) */
-        /* TODO */
+        i2c_slave_create_simple(bus, TYPE_MAX31790, 0x2f);
 
         /* maxim,max11615 @ 0x33   (adc) */
         /* TODO */
diff --git a/hw/sensor/Kconfig b/hw/sensor/Kconfig
index b459ac2240..3eeffd32cd 100644
--- a/hw/sensor/Kconfig
+++ b/hw/sensor/Kconfig
@@ -47,3 +47,7 @@ config ISL_PMBUS_VR
 config MAX31785
     bool
     depends on PMBUS
+
+config MAX31790
+    bool
+    depends on I2C
diff --git a/hw/sensor/max31790.c b/hw/sensor/max31790.c
new file mode 100644
index 0000000000..1aca05f35b
--- /dev/null
+++ b/hw/sensor/max31790.c
@@ -0,0 +1,508 @@
+/*
+ * Maxim MAX31790 PMBus 6-Channel Fan Controller
+ *
+ * Datasheet:
+ * https://www.analog.com/media/en/technical-documentation/data-sheets/MAX31790.pdf
+ *
+ * Copyright 2026 9elements
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/i2c/i2c.h"
+#include "hw/sensor/max31790.h"
+#include "migration/vmstate.h"
+#include "qemu/module.h"
+#include "qom/object.h"
+#include "trace.h"
+
+#define MAX31790_NUM_FANS 6
+#define MAX31790_NUM_TACHS 12
+
+#define MAX31790_REG_GLOBAL_CONFIG 0x00
+#define MAX31790_REG_PWM_FREQ 0x01
+
+/* 0x02 to 0x07: N = 0 .. 5 */
+#define MAX31790_REG_FAN_CONFIG(N) (0x02 + (N))
+
+/* 0x08 to 0x0d: N = 0 .. 5 */
+#define MAX31790_REG_FAN_DYNAMICS(N) (0x08 + (N))
+
+#define MAX31790_REG_FAN_FAULT_STATUS_2 0x10
+#define MAX31790_REG_FAN_FAULT_STATUS_1 0x11
+#define MAX31790_REG_FAN_FAULT_MASK_2 0x12
+#define MAX31790_REG_FAN_FAULT_MASK_1 0x13
+#define MAX31790_REG_FAILED_FAN_OPT 0x14
+
+/* 0x18 to 0x2f: N = 0 .. 11 */
+#define MAX31790_REG_TACH_COUNT_MSB(N) (0x18 + 2 * (N))
+#define MAX31790_REG_TACH_COUNT_LSB(N) (0x19 + 2 * (N))
+
+/* 0x30 to 0x3b: N = 0 .. 5 */
+#define MAX31790_REG_PWM_DUTY_CYCLE_MSB(N) (0x30 + 2 * (N))
+#define MAX31790_REG_PWM_DUTY_CYCLE_LSB(N) (0x31 + 2 * (N))
+
+/* .. reserved registers ... */
+
+/* 0x40 to 0x4b: N = 0 .. 5 */
+#define MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(N) (0x40 + 2 * (N))
+#define MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(N) (0x41 + 2 * (N))
+
+/* ... 'User Byte' registers ... */
+
+/* 0x50 to 0x5b: N = 0 .. 5 */
+#define MAX31790_REG_TACH_TARGET_COUNT_MSB(N) (0x50 + 2 * (N))
+#define MAX31790_REG_TACH_TARGET_COUNT_LSB(N) (0x51 + 2 * (N))
+
+static inline uint8_t lsb16(uint16_t v) { return extract16(v, 0, 8); }
+
+static inline uint8_t msb16(uint16_t v) { return extract16(v, 8, 8); }
+
+struct MAX31790State {
+    I2CSlave i2c;
+
+    uint8_t fan_config[MAX31790_NUM_FANS];
+    uint8_t fan_dynamics[MAX31790_NUM_FANS];
+
+    uint16_t pwm[MAX31790_NUM_FANS];
+    uint16_t tach_target[MAX31790_NUM_FANS];
+
+    /*
+     * Fan speed is measured by counting the number of internal 8192Hz
+     * (fTOSC/4) clock cycles that take place during a select-
+     * able number of tachometer periods. The number of clock
+     * cycles counted (11-bit value) is stored in the associated
+     * TACH Count registers and the desired number of cycles
+     * is stored in the TACH Target Count registers.
+     */
+    uint16_t tach_count[MAX31790_NUM_TACHS];
+
+    /* command buffer */
+    uint8_t len;
+    uint8_t buf[2];
+
+    /* output buffer */
+    uint8_t outlen;
+    uint8_t outbuf[2];
+
+    /* selected register for read/write operation */
+    uint8_t pointer;
+};
+
+OBJECT_DECLARE_SIMPLE_TYPE(MAX31790State, MAX31790)
+
+/* helper function for max31790 register layout */
+static size_t reg16_index(uint8_t pointer, uint8_t base)
+{
+    /* even registers have even base address */
+    /* MSB is always stored at +1 byte offset*/
+    g_assert(pointer >= base);
+    g_assert(base % 2 == 0);
+
+    if (pointer % 2 == 0) {
+        return (pointer - base) / 2;
+    } else {
+        return (pointer - (base + 1)) / 2;
+    }
+}
+
+static void set_outbuf_16(MAX31790State *s, bool even, uint16_t value)
+{
+
+    if (even) {
+        s->outbuf[0] = msb16(value);
+        s->outbuf[1] = lsb16(value);
+    } else {
+        s->outbuf[0] = lsb16(value);
+    }
+}
+
+static void max31790_read(MAX31790State *s)
+{
+    size_t index = 0;
+    const bool even_reg = s->pointer % 2 == 0;
+
+    s->outbuf[0] = 0;
+    s->outbuf[1] = 0;
+
+    switch (s->pointer) {
+    case MAX31790_REG_FAN_CONFIG(0)... MAX31790_REG_FAN_CONFIG(5):
+        index = s->pointer - MAX31790_REG_FAN_CONFIG(0);
+
+        g_assert(index < MAX31790_NUM_FANS);
+
+        s->outbuf[0] = s->fan_config[index];
+        trace_max31790_fan_config_read(s->i2c.address, index, s->outbuf[0]);
+        break;
+    case MAX31790_REG_FAN_DYNAMICS(0)... MAX31790_REG_FAN_DYNAMICS(5):
+        index = s->pointer - MAX31790_REG_FAN_DYNAMICS(0);
+
+        g_assert(index < MAX31790_NUM_FANS);
+
+        s->outbuf[0] = s->fan_dynamics[index];
+        trace_max31790_fan_dynamics_read(s->i2c.address, index, s->outbuf[0]);
+        break;
+    case MAX31790_REG_FAN_FAULT_STATUS_1:
+    case MAX31790_REG_FAN_FAULT_STATUS_2:
+        /* we do not have any fan fault */
+        s->outbuf[0] = 0x00;
+        s->outbuf[1] = 0x00;
+        break;
+    case MAX31790_REG_TACH_COUNT_MSB(0)... MAX31790_REG_TACH_COUNT_LSB(11):
+        index = reg16_index(s->pointer, MAX31790_REG_TACH_COUNT_MSB(0));
+
+        g_assert(index < MAX31790_NUM_TACHS);
+
+        set_outbuf_16(s, even_reg, s->tach_count[index % MAX31790_NUM_TACHS]);
+        break;
+
+    case MAX31790_REG_PWM_DUTY_CYCLE_MSB(0)... MAX31790_REG_PWM_DUTY_CYCLE_LSB(
+        5):
+        index = reg16_index(s->pointer, MAX31790_REG_PWM_DUTY_CYCLE_MSB(0));
+
+        g_assert(index < MAX31790_NUM_FANS);
+
+        set_outbuf_16(s, even_reg, s->pwm[index & MAX31790_NUM_FANS]);
+        break;
+
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(
+        0)... MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(5):
+        index =
+            reg16_index(s->pointer, MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(0));
+
+        g_assert(index < MAX31790_NUM_FANS);
+
+        set_outbuf_16(s, even_reg, s->pwm[index & MAX31790_NUM_FANS]);
+        break;
+
+    case MAX31790_REG_TACH_TARGET_COUNT_MSB(
+        0)... MAX31790_REG_TACH_TARGET_COUNT_LSB(5):
+        index = reg16_index(s->pointer, MAX31790_REG_TACH_TARGET_COUNT_MSB(0));
+
+        g_assert(index < MAX31790_NUM_FANS);
+
+        set_outbuf_16(s, even_reg, s->tach_target[index]);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: read of register %d\n", __func__,
+                      s->pointer);
+        break;
+    }
+}
+
+static uint8_t max31790_get_speed_range(MAX31790State *s, size_t index)
+{
+    g_assert(index < MAX31790_NUM_FANS);
+    const uint16_t value = (s->fan_dynamics[index] >> 5);
+    return (value > 5) ? 32 : 1 << value;
+}
+
+static void max31790_set_rpm(MAX31790State *s, size_t index, uint16_t rpm)
+{
+    trace_max31790_rpm_write(s->i2c.address, index, rpm);
+
+    /*
+     * (see page 11) NP = number of tachometer pulses per revolution.
+     * Most general-purpose brushless DC fans produce two tachometer
+     * pulses per revolution.
+     */
+    const uint64_t sr = max31790_get_speed_range(s, index);
+
+    /* page 11: tach_count = 60 * SR * 8192 / (NP * RPM) */
+
+    /* prevent division by 0 */
+    rpm = (rpm == 0) ? 1 : rpm;
+
+    /* (60 * 8192) / 2 */
+    const uint64_t tach_count_constant = 245760ULL;
+
+    /* simplified, assuming NP = 2 */
+    uint64_t tach_count = (tach_count_constant * sr) / (uint64_t)rpm;
+
+    /* in case of overflow, clamp to the maximum value */
+    if (tach_count > 0x7ff) {
+        tach_count = 0x7ff;
+    }
+
+    g_assert(index < MAX31790_NUM_TACHS);
+
+    /* datasheet: lowest 5 bits are 0 */
+    s->tach_count[index] = (uint16_t)(tach_count << 5);
+
+    trace_max31790_tach_count_reg(s->i2c.address, index, s->tach_count[index]);
+}
+
+static void max31790_pwm_write(MAX31790State *s, size_t index, uint16_t value)
+{
+    trace_max31790_pwm_write(s->i2c.address, index, value);
+
+    g_assert(index < MAX31790_NUM_FANS);
+
+    s->pwm[index % MAX31790_NUM_FANS] = value;
+
+    /* last 7 bits in register are 0 , 9 bits remaining */
+    const uint16_t pwm_real = s->pwm[index % MAX31790_NUM_FANS] >> 7;
+
+    /* maximum value will be 511 */
+
+    /*
+     * This formula has magic values which model the relationship
+     * of PWM input to a fan. Not derived from datasheet.
+     */
+    max31790_set_rpm(s, index, 100 + pwm_real * 20);
+}
+
+static void max31790_write_2_byte(MAX31790State *s)
+{
+    size_t index = 0;
+    const uint8_t value0 = s->buf[0];
+    const uint8_t value1 = s->buf[1];
+
+    switch (s->pointer) {
+    case MAX31790_REG_FAN_CONFIG(0)... MAX31790_REG_FAN_CONFIG(5):
+        break; /* handled by one byte write */
+    case MAX31790_REG_FAN_DYNAMICS(0)... MAX31790_REG_FAN_DYNAMICS(5):
+        break; /* handled by one byte write */
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(0):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(1):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(2):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(3):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(4):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(5):
+        index =
+            reg16_index(s->pointer, MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(0));
+        max31790_pwm_write(s, index, value0 << 8 | value1);
+        break;
+    case MAX31790_REG_TACH_TARGET_COUNT_MSB(0):
+    case MAX31790_REG_TACH_TARGET_COUNT_MSB(1):
+    case MAX31790_REG_TACH_TARGET_COUNT_MSB(2):
+    case MAX31790_REG_TACH_TARGET_COUNT_MSB(3):
+    case MAX31790_REG_TACH_TARGET_COUNT_MSB(4):
+    case MAX31790_REG_TACH_TARGET_COUNT_MSB(5):
+        index = reg16_index(s->pointer, MAX31790_REG_TACH_TARGET_COUNT_MSB(0));
+
+        g_assert(index < MAX31790_NUM_FANS);
+
+        s->tach_target[index] = (value0 << 8) | value1;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: write to register %d\n", __func__,
+                      s->pointer);
+        break;
+    }
+}
+
+static uint16_t reg16_write_byte(uint16_t value, bool is_msb, uint8_t b)
+{
+
+    if (is_msb) {
+        return (b << 8) | (value & 0x00ff);
+    } else {
+        return (value & 0xff00) | (b & 0x00ff);
+    }
+}
+
+static void max31790_write_1_byte(MAX31790State *s)
+{
+    size_t index = 0;
+    uint16_t pwm = 0;
+    const uint8_t value = s->buf[0];
+    const bool is_msb = s->pointer % 2 == 0;
+
+    switch (s->pointer) {
+    case MAX31790_REG_FAN_CONFIG(0)... MAX31790_REG_FAN_CONFIG(5):
+        index = s->pointer - MAX31790_REG_FAN_CONFIG(0);
+
+        g_assert(index < MAX31790_NUM_FANS);
+
+        s->fan_config[index] = value;
+        trace_max31790_fan_config_write(s->i2c.address, index, value);
+        break;
+    case MAX31790_REG_FAN_DYNAMICS(0)... MAX31790_REG_FAN_DYNAMICS(5):
+        index = s->pointer - MAX31790_REG_FAN_DYNAMICS(0);
+
+        g_assert(index < MAX31790_NUM_FANS);
+
+        s->fan_dynamics[index] = value;
+        trace_max31790_fan_dynamics_write(s->i2c.address, index, value);
+        break;
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(
+        0)... MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(5):
+        index =
+            reg16_index(s->pointer, MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(0));
+
+        g_assert(index < MAX31790_NUM_FANS);
+
+        pwm =
+            reg16_write_byte(s->pwm[index & MAX31790_NUM_FANS], is_msb, value);
+
+        max31790_pwm_write(s, index, pwm);
+        break;
+    case MAX31790_REG_TACH_TARGET_COUNT_MSB(
+        0)... MAX31790_REG_TACH_TARGET_COUNT_LSB(5):
+        index = reg16_index(s->pointer, MAX31790_REG_TACH_TARGET_COUNT_MSB(0));
+
+        g_assert(index < MAX31790_NUM_FANS);
+
+        s->tach_target[index] =
+            reg16_write_byte(s->tach_target[index], is_msb, value);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: write to register %d\n", __func__,
+                      s->pointer);
+        break;
+    }
+}
+
+static int max31790_send(I2CSlave *i2c, uint8_t data)
+{
+    MAX31790State *s = MAX31790(i2c);
+
+    trace_max31790_send(s->i2c.address, data);
+
+    if (s->len == 0) {
+        /* first byte is the register pointer for a read / write operation */
+        s->pointer = data;
+        s->len++;
+        return 0;
+    }
+
+    if (s->len > 2) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write too many bytes\n", __func__);
+        return 1; /* NAK */
+    }
+
+    /* second / third byte is the data to write */
+    s->buf[s->len - 1] = data;
+    s->len++;
+
+    if (s->len == 2) {
+        max31790_write_1_byte(s);
+    } else if (s->len == 3) {
+        max31790_write_2_byte(s);
+    }
+
+    return 0;
+}
+
+static uint8_t max31790_recv(I2CSlave *i2c)
+{
+    MAX31790State *s = MAX31790(i2c);
+
+    max31790_read(s);
+    s->len = 0;
+
+    if (s->outlen >= 2) {
+        /* error */
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: guest over read\n", __func__);
+        s->outlen = 0;
+    }
+
+    const uint8_t data = s->outbuf[s->outlen++];
+
+    trace_max31790_recv_return(s->i2c.address, s->pointer, data);
+    return data;
+}
+
+static int max31790_event(I2CSlave *i2c, enum i2c_event event)
+{
+    MAX31790State *s = MAX31790(i2c);
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
+static const VMStateDescription vmstate_max31790 = {
+    .name = TYPE_MAX31790,
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields =
+        (const VMStateField[]){
+            VMSTATE_UINT8(len, MAX31790State),
+            VMSTATE_UINT8_ARRAY(fan_config, MAX31790State, MAX31790_NUM_FANS),
+            VMSTATE_UINT8_ARRAY(fan_dynamics, MAX31790State, MAX31790_NUM_FANS),
+            VMSTATE_UINT16_ARRAY(pwm, MAX31790State, MAX31790_NUM_FANS),
+            VMSTATE_UINT16_ARRAY(tach_target, MAX31790State, MAX31790_NUM_FANS),
+            VMSTATE_UINT16_ARRAY(tach_count, MAX31790State, MAX31790_NUM_TACHS),
+            VMSTATE_UINT8_ARRAY(buf, MAX31790State, 2),
+            VMSTATE_UINT8(outlen, MAX31790State),
+            VMSTATE_UINT8_ARRAY(outbuf, MAX31790State, 2),
+            VMSTATE_UINT8(pointer, MAX31790State),
+            VMSTATE_I2C_SLAVE(i2c, MAX31790State), VMSTATE_END_OF_LIST() }
+};
+
+static void max31790_reset_enter(MAX31790State *s)
+{
+    trace_max31790_reset(s->i2c.address);
+
+    for (int i = 0; i < MAX31790_NUM_FANS; i++) {
+        /* POR-State 0b 0XX0 0000 */
+        s->fan_config[i] = 0x0;
+
+        /* same as POR-State */
+        s->tach_target[i] = 0x3c00;
+
+        /* same as POR-State */
+        s->fan_dynamics[i] = 0x4c;
+    }
+
+    /* this will set both pwm and tach count */
+    for (int i = 0; i < MAX31790_NUM_FANS; i++) {
+        max31790_pwm_write(s, i, 0x4444);
+    }
+}
+
+static void max31790_reset_hold(Object *obj, ResetType type)
+{
+    MAX31790State *s = MAX31790(obj);
+
+    max31790_reset_enter(s);
+}
+
+static void max31790_realize(DeviceState *dev, Error **errp)
+{
+    MAX31790State *s = MAX31790(dev);
+
+    trace_max31790_realize(s->i2c.address);
+}
+
+static void max31790_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->realize = max31790_realize;
+    dc->desc = "Maxim MAX31790 6-Channel Fan Controller";
+    dc->vmsd = &vmstate_max31790;
+    rc->phases.hold = max31790_reset_hold;
+    k->event = max31790_event;
+    k->recv = max31790_recv;
+    k->send = max31790_send;
+}
+
+static const TypeInfo max31790_info = {
+    .name = TYPE_MAX31790,
+    .parent = TYPE_I2C_SLAVE,
+    .instance_size = sizeof(MAX31790State),
+    .class_init = max31790_class_init,
+};
+
+static void max31790_register_types(void)
+{
+    type_register_static(&max31790_info);
+}
+
+type_init(max31790_register_types)
diff --git a/hw/sensor/meson.build b/hw/sensor/meson.build
index fe36c9ef91..f2b6b07a78 100644
--- a/hw/sensor/meson.build
+++ b/hw/sensor/meson.build
@@ -9,3 +9,4 @@ system_ss.add(when: 'CONFIG_MAX34451', if_true: files('max34451.c'))
 system_ss.add(when: 'CONFIG_LSM303DLHC_MAG', if_true: files('lsm303dlhc_mag.c'))
 system_ss.add(when: 'CONFIG_ISL_PMBUS_VR', if_true: files('isl_pmbus_vr.c'))
 system_ss.add(when: 'CONFIG_MAX31785', if_true: files('max31785.c'))
+system_ss.add(when: 'CONFIG_MAX31790', if_true: files('max31790.c'))
diff --git a/hw/sensor/trace-events b/hw/sensor/trace-events
index 5a3630f7bb..2041c91dd9 100644
--- a/hw/sensor/trace-events
+++ b/hw/sensor/trace-events
@@ -12,3 +12,16 @@ adc128d818_reset(const char *id, const char *source) "%s %s"
 tmp105_read(uint8_t dev, uint8_t addr) "device: 0x%02x, addr: 0x%02x"
 tmp105_write(uint8_t dev, uint8_t addr) "device: 0x%02x, addr 0x%02x"
 tmp105_write_shutdown(uint8_t dev) "device: 0x%02x"
+
+# max31790.c
+max31790_send(uint8_t i2c_addr, uint8_t send) "i2c_addr: 0x%02x, data: 0x%02x"
+max31790_recv_return(uint8_t i2c_addr, uint8_t reg_addr, uint8_t data) "i2c_addr: 0x%02x, reg_addr: 0x%02x, returns: 0x%02x"
+max31790_realize(uint8_t i2c_addr) "i2c_addr: 0x%02x"
+max31790_reset(uint8_t i2c_addr) "i2c_addr: 0x%02x"
+max31790_pwm_write(uint8_t i2c_addr, size_t index, uint16_t value) "i2c_addr: 0x%02x, index: %zu, value: 0x%04x"
+max31790_rpm_write(uint8_t i2c_addr, size_t index, uint16_t value) "i2c_addr: 0x%02x, index: %zu, value: 0x%04x"
+max31790_tach_count_reg(uint8_t i2c_addr, size_t index, uint16_t value) "i2c_addr: 0x%02x, index: %zu, value: 0x%04x"
+max31790_fan_dynamics_read(uint8_t i2c_addr, size_t channel, uint8_t value) "i2c_addr: 0x%02x, channel: %zu, value: 0x%02x"
+max31790_fan_dynamics_write(uint8_t i2c_addr, size_t channel, uint8_t value) "i2c_addr: 0x%02x, channel: %zu, value: 0x%02x"
+max31790_fan_config_read(uint8_t i2c_addr, size_t channel, uint8_t value) "i2c_addr: 0x%02x, channel: %zu, value: 0x%02x"
+max31790_fan_config_write(uint8_t i2c_addr, size_t channel, uint8_t value) "i2c_addr: 0x%02x, channel: %zu, value: 0x%02x"
diff --git a/include/hw/sensor/max31790.h b/include/hw/sensor/max31790.h
new file mode 100644
index 0000000000..73b6375ae2
--- /dev/null
+++ b/include/hw/sensor/max31790.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef QEMU_MAX31790_H
+#define QEMU_MAX31790_H
+
+#define TYPE_MAX31790 "max31790"
+
+#endif
diff --git a/tests/functional/arm/test_aspeed_fby4.py b/tests/functional/arm/test_aspeed_fby4.py
index b6af9a21b7..be396f53bc 100755
--- a/tests/functional/arm/test_aspeed_fby4.py
+++ b/tests/functional/arm/test_aspeed_fby4.py
@@ -7,6 +7,7 @@
 from qemu_test import Asset
 from qemu_test import wait_for_console_pattern
 from aspeed import AspeedTest
+from qemu_test import exec_command_and_wait_for_pattern
 
 
 class YosemiteV4Machine(AspeedTest):
@@ -34,6 +35,52 @@ def do_test_arm_aspeed_openbmc_no_network(self, machine, image, uboot,
         # different from the other machines.
         self.wait_for_console_pattern('yosemite4 login:')
 
+        # perform login
+        exec_command_and_wait_for_pattern(self,
+                                          "root", "Password:");
+
+        exec_command_and_wait_for_pattern(self, "0penBmc", "#");
+
+        # MAX31790 test
+        exec_command_and_wait_for_pattern(self,
+            "cat /sys/class/hwmon/hwmon3/name", "max31790");
+
+        # this initial fan reading value is caused by services
+        # inside the image writing the pwm
+        exec_command_and_wait_for_pattern(self,
+            "cat /sys/class/hwmon/hwmon3/fan1_input", "7281");
+        exec_command_and_wait_for_pattern(self,
+            "cat /sys/class/hwmon/hwmon3/fan1_enable", "1");
+        exec_command_and_wait_for_pattern(self,
+            "cat /sys/class/hwmon/hwmon3/fan1_fault", "0");
+
+        exec_command_and_wait_for_pattern(self,
+            "echo 1 > /sys/class/hwmon/hwmon3/pwm1", "root@yosemite4");
+        exec_command_and_wait_for_pattern(self,
+            "cat /sys/class/hwmon/hwmon3/fan1_input", "0");
+
+        # linux driver pwm write:
+        # >>> hex(int((11 * 511) / 255) << 7)
+        # '0xb00'
+        exec_command_and_wait_for_pattern(self,
+            "echo 11 > /sys/class/hwmon/hwmon3/pwm1", "root@yosemite4");
+        # device emulation logic:
+        # >>> hex(100 + (0xb00 >> 7) * 20)
+        # '0x21c'
+        # register reading value:
+        # >>> hex(int((245760 * 4) / 0x21c) << 5)
+        # '0xe380'
+        # linux driver calculation:
+        # >>> int((60 * 4 * 8192) / (0xe380 >> 4))
+        # 540
+        exec_command_and_wait_for_pattern(self,
+            "cat /sys/class/hwmon/hwmon3/fan1_input", "540");
+
+        exec_command_and_wait_for_pattern(self,
+            "echo 255 > /sys/class/hwmon/hwmon3/pwm1", "root@yosemite4");
+        exec_command_and_wait_for_pattern(self,
+            "cat /sys/class/hwmon/hwmon3/fan1_input", "10347");
+
     def test_arm_ast2600_yosemitev4_openbmc(self):
         image_path = self.uncompress(self.ASSET_YOSEMITE_V4_FLASH)
 
-- 
2.56.0


