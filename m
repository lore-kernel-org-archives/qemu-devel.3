Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE5BC02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 20:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyXi-00047z-Vt; Mon, 20 Jan 2025 15:38:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyXW-00044Y-4X; Mon, 20 Jan 2025 15:38:30 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyXU-0002aY-5p; Mon, 20 Jan 2025 15:38:29 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d3e6f6cf69so8016296a12.1; 
 Mon, 20 Jan 2025 12:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737405506; x=1738010306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dJh/wjKW7N+k5IBXoYv5hsPWIKX+2pFf2CEXXareyRo=;
 b=cTnHKD9LAf4S+lfsqbf6h5+un9RWErs/Xfzyh7W6CfLes3tHFWQPM5eeqsEessB0Br
 0icxr/LKxutwry1eFOLqf5YTO1RJCrGT20kyI1Ej8I4WbYIh1mf/kL6N+jkvRlfVvttS
 ymAc2m00U6DI96Rlx2jGDEmJObGpr8/V+5Y2IMVLgkWpq5ugjCNjP9B5Xlgqo7c0d/U6
 eot/KPTbdbJZLT5/5PaD86vjkXta8vx4cCWGtMGE2cTwiwEFav15A8WiQ1JB0HUAqElo
 tl5ylZKxmPfmnRTw6cOAP5ZWfKsx+qGabp8MbySo5keWmxJX3lBa+8J9okzcfwOIPXAP
 4tcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737405506; x=1738010306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dJh/wjKW7N+k5IBXoYv5hsPWIKX+2pFf2CEXXareyRo=;
 b=S5mK0m3GHjYoGlu8wna+jZxdI5gWaG48mSSBXkcdQWrR+ll9n0aSggDYwZwKs0B6bo
 MdEMuSwt7GGPrSdVc1/lDcHpCnDEc74FWYdFCaExOn8CRgQ4UJt0sysu+p8Xo/xGrD03
 b886OUVaKtMM0drPIsGa9V31HNarz+nq94duJQovRHmdeTSwETxca4KiH32nM5ENOhad
 6Qi6LjESLX9+M9rXEhtzJFfkG1BKIdUZLZYbTS0T8KOrBR2gLmvqgMvOaelQaHXvYRyu
 4gEZWJzUixqy7vyPt1nu4kHJ7PLmWZChmJFR4AkeX6A7lGMqKIZ1uyk9M+lMcNRoRfUe
 raAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz+M0g9tQpnFKHvfdJHq45CHU+HCzdY/+lj8KwBWGXhNJod5jRvtL2R2F9kqtNotLi8ThE1mddRg==@nongnu.org
X-Gm-Message-State: AOJu0YzvrOjrcwKDP5v1V+0B/RHibaqhwMU+hNzN9q1xIVMot2WdO1yv
 An9s+YP8TNteeO9sBtapoE0PsJdacYiAsbF/gc8VMTvZ5qN5aQ1mZjVbDJHM
X-Gm-Gg: ASbGncs4TxFdvauwuIxfC2fEWQYVxvp26W/4QGdAZpmbkrnLQdPfprRv07Q3peXvCOa
 AkxgHSlZAHvz731veKN7mCQQJUtz45ozwov2leXhCkXUKDmnYRl13MPFzxfuwgQ3ixL5bgHAnFQ
 bal6yKMkQCqTvYgg9rHsUljXyEzAv9vb+gzivmLeremzHdWFduesoSwbGvPeP4BkfMnXxarNM+H
 lBTuMds4zE2Fjdl6/9LsPdZYnv0K9aOlHGB+bNlWcXeLUGU6EBZYk9QozADFuqbpjTJPqsTU0Vy
 APKplCgSX/6tL7HNPFaZifEf5wg9FBCFRqupArd73eviEk2pqneb7vY7pviD
X-Google-Smtp-Source: AGHT+IG0oJGcY0XP+0b3aSAFoCPun5qjE3H2KQpRXBC7N1guHlv9qXlvThhRVP1Ich4eXMHK3eRT1A==
X-Received: by 2002:a05:6402:2341:b0:5d9:f5c4:a227 with SMTP id
 4fb4d7f45d1cf-5db7d3550camr12529766a12.20.1737405505808; 
 Mon, 20 Jan 2025 12:38:25 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-183-181-102.77.183.pool.telefonica.de. [77.183.181.102])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db7364258csm6021077a12.1.2025.01.20.12.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 12:38:24 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 20/21] hw/i2c: Import TCA6416 emulation from Xilinx
Date: Mon, 20 Jan 2025 21:37:47 +0100
Message-ID: <20250120203748.4687-21-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250120203748.4687-1-shentey@gmail.com>
References: <20250120203748.4687-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Xilinx QEMU implements a TCA6416 device model which may be useful for the
broader QEMU community, so upstream it. In the Xilinx fork, the device model
gets compiled whenever CONFIG_CADENCE is true, so have it maintained by the
"hw/*/cadence_*" maintainers.

The code is based on Xilinx QEMU version xilinx_v2024.2 plus the following
modifications:
* Use OBJECT_DECLARE_SIMPLE_TYPE()
* Port from DPRINTF() to trace events
* Follow QEMU conventions for naming of state struct
* Rename type to not contain a ','
* Use DEFINE_TYPES() macro
* Implement under hw/gpio since device is i2c client and gpio provider
* Have dedicated Kconfig switch

Signed-off-by: Bernhard Beschow <shentey@gmail.com>

--
I have a use for TCA6416 emulation. Question: Are Xilinx Zynq maintainers
willing to maintain this device model?
---
 MAINTAINERS          |   1 +
 hw/gpio/tca6416.c    | 122 +++++++++++++++++++++++++++++++++++++++++++
 hw/gpio/Kconfig      |   5 ++
 hw/gpio/meson.build  |   1 +
 hw/gpio/trace-events |   4 ++
 5 files changed, 133 insertions(+)
 create mode 100644 hw/gpio/tca6416.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7531d65429..0cac9c90bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1030,6 +1030,7 @@ S: Maintained
 F: hw/*/xilinx_*
 F: hw/*/cadence_*
 F: hw/misc/zynq_slcr.c
+F: hw/gpio/tca6416.c
 F: hw/adc/zynq-xadc.c
 F: include/hw/misc/zynq_slcr.h
 F: include/hw/adc/zynq-xadc.h
diff --git a/hw/gpio/tca6416.c b/hw/gpio/tca6416.c
new file mode 100644
index 0000000000..81ed7a654d
--- /dev/null
+++ b/hw/gpio/tca6416.c
@@ -0,0 +1,122 @@
+/*
+ * QEMU model of TCA6416 16-Bit I/O Expander
+ *
+ * Copyright (c) 2018 Xilinx Inc.
+ *
+ * Written by Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "hw/i2c/i2c.h"
+#include "trace.h"
+
+#define TYPE_TCA6416 "tca6416"
+OBJECT_DECLARE_SIMPLE_TYPE(Tca6416State, TCA6416)
+
+#define IN_PORT0    0
+#define IN_PORT1    1
+#define OUT_PORT0   2
+#define OUT_PORT1   3
+#define POL_INV0    4
+#define POL_INV1    5
+#define CONF_PORT0  6
+#define CONF_PORT1  7
+#define RMAX (CONF_PORT1 + 1)
+
+enum tca6416_events {
+     ADDR_DONE,
+     ADDRESSING,
+};
+
+struct Tca6416State {
+     I2CSlave i2c;
+
+     uint8_t addr;
+     uint8_t state;
+     uint8_t regs[RMAX];
+};
+
+static uint8_t tca6416_read(I2CSlave *i2c)
+{
+    Tca6416State *s = TCA6416(i2c);
+    uint8_t ret;
+
+    ret = s->regs[s->addr];
+    trace_tca6416_read(ret);
+    return ret;
+}
+
+static int tca6416_write(I2CSlave *i2c, uint8_t data)
+{
+    Tca6416State *s = TCA6416(i2c);
+
+    trace_tca6416_write(data);
+    if (s->state == ADDRESSING) {
+        s->addr = data;
+    } else {
+        s->regs[s->addr] = data;
+    }
+
+    return 0;
+}
+
+static void tca6416_realize(DeviceState *dev, Error **errp)
+{
+    Tca6416State *s = TCA6416(dev);
+
+    s->regs[CONF_PORT0] = 0xFF;
+    s->regs[CONF_PORT1] = 0xFF;
+}
+
+static int tca6416_event(I2CSlave *i2c, enum i2c_event event)
+{
+    Tca6416State *s = TCA6416(i2c);
+
+    switch (event) {
+    case I2C_START_SEND:
+        s->state = ADDRESSING;
+        break;
+    default:
+         s->state = ADDR_DONE;
+    };
+    return 0;
+}
+
+static void tca6416_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+
+    dc->realize = tca6416_realize;
+    k->recv = tca6416_read;
+    k->send = tca6416_write;
+    k->event = tca6416_event;
+}
+
+static const TypeInfo tca6416_types[] = {
+    {
+        .name = TYPE_TCA6416,
+        .parent = TYPE_I2C_SLAVE,
+        .class_init = tca6416_class_init,
+        .instance_size = sizeof(Tca6416State),
+    }
+};
+
+DEFINE_TYPES(tca6416_types)
diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index c423e10f59..a240cf2de2 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -20,5 +20,10 @@ config PCF8574
     bool
     depends on I2C
 
+config TCA6416
+    bool
+    depends on I2C
+    default y if I2C_DEVICES
+
 config ZAURUS_SCOOP
     bool
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 74840619c0..b3ff7c7460 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -18,3 +18,4 @@ system_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true: files('stm32l4x5_gpio.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
 system_ss.add(when: 'CONFIG_PCF8574', if_true: files('pcf8574.c'))
+system_ss.add(when: 'CONFIG_TCA6416', if_true: files('tca6416.c'))
diff --git a/hw/gpio/trace-events b/hw/gpio/trace-events
index cea896b28f..6724f2efb8 100644
--- a/hw/gpio/trace-events
+++ b/hw/gpio/trace-events
@@ -46,3 +46,7 @@ stm32l4x5_gpio_read(char *gpio, uint64_t addr) "GPIO%s addr: 0x%" PRIx64 " "
 stm32l4x5_gpio_write(char *gpio, uint64_t addr, uint64_t data) "GPIO%s addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
 stm32l4x5_gpio_update_idr(char *gpio, uint32_t old_idr, uint32_t new_idr) "GPIO%s from: 0x%x to: 0x%x"
 stm32l4x5_gpio_pins(char *gpio, uint16_t disconnected, uint16_t high) "GPIO%s disconnected pins: 0x%x levels: 0x%x"
+
+# tca6416.c
+tca6416_write(uint8_t value) "0x%02x"
+tca6416_read(uint8_t value) "0x%02x"
-- 
2.48.1


