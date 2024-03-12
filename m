Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504C1C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxQu-0007Y6-NO; Tue, 12 Mar 2024 04:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxQV-0006oh-7D
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:24:01 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxQQ-0001He-Pb
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:23:59 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33e9623c3a8so1457697f8f.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 01:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710231833; x=1710836633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1hGuUQy57ryIxbN/Y0vAq6Y8p4QXBEpEzJDzKEkwyAk=;
 b=BjhUfDYtP7lU9fIAfCfByQAH5b1W3x9xippxG0OloPwnHydP7D3h8dNXNCwkumBQIA
 GK+/yzRL+/BMRMCha8Hg983kFaEI0Rdhr13Rl1xnnaxXNBma0ovpoYMIFBBYRN5jANwO
 ggKldzRnsetCXYVXgccocK2D77ihKhCUWVDPBG5wyW8vVoA8l1Qg6AmjGo+YOeL2X24/
 J+eUT+oad4nUccNoJ2xeO6Mh33Ircg/9vqjUYwVktOOmdNrh3onPVRQVBVHkfUE/RSre
 HYtGQ0U7xe98GyHFqp/iDgBJCAHTR3Hf86q0UA9mBw3bFZCfChCIMyeDY9KCwhyVFRdf
 Nojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710231833; x=1710836633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1hGuUQy57ryIxbN/Y0vAq6Y8p4QXBEpEzJDzKEkwyAk=;
 b=MqU8nJsHjOiHgjlifeaLPPlmU0XO0lLTZGurmjirEpaLGf/t5PSjH5GMSqml3K0aDL
 FMVfJf+IYGeyvhoK+bWxl8G//D40oH7E69P6xF0cHXSUjAkETVhc2KSChsYHnBDys2Qf
 v22Ac3oLZphfS7r3I599eG+l8Yv17xShRHYuwfoaECUvA5xBR0VfEIzlm5+CL/82jzp0
 X2toi+rdz2jl13suONHe/gilYucOWym+4VBR8RtM/RLjc6P2SB6WvIhkQa38xpC6YWob
 RzLEJXwTDdUyNjqkWSshJrnmAQSvzbuuSOKqok1B64M4Wo9m4fTYXX/NjwQ3wN6PoxgR
 titQ==
X-Gm-Message-State: AOJu0YwdbMTzuMsjH4ohJCDCpwWiKnt7UoGzE5NRV7FRwIh5GgYtD033
 fmsNCh+9AolrtEU1CNhP+ZfpJa7rnjRgggxr4gHt7Q965y02s9Tb1qGh1cjlK775sraGnFSlTTf
 3
X-Google-Smtp-Source: AGHT+IFruM7m58xhiBa1Ygv1ewavA658LvlFD6g+fBMorecG7a/uKPaHdADwL9AG6IqlAKmYVewuLA==
X-Received: by 2002:a5d:4bc3:0:b0:33e:6064:a3f with SMTP id
 l3-20020a5d4bc3000000b0033e60640a3fmr2170152wrt.29.1710231832915; 
 Tue, 12 Mar 2024 01:23:52 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.139])
 by smtp.gmail.com with ESMTPSA id
 bu29-20020a056000079d00b0033e87564720sm7586064wrb.92.2024.03.12.01.23.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Mar 2024 01:23:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Dmitriy Sharikhin <d.sharikhin@yadro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 11/13] hw/gpio: introduce pcf8574 driver
Date: Tue, 12 Mar 2024 09:22:36 +0100
Message-ID: <20240312082239.69696-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240312082239.69696-1-philmd@linaro.org>
References: <20240312082239.69696-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Dmitriy Sharikhin <d.sharikhin@yadro.com>

NXP PCF8574 and compatible ICs are simple I2C GPIO expanders.
PCF8574 incorporates quasi-bidirectional IO, and simple
communication protocol, when IO read is I2C byte read, and
IO write is I2C byte write. User can think of it as
open-drain port, when line high state is input and line low
state is output.

Signed-off-by: Dmitrii Sharikhin <d.sharikhin@yadro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <f1552d822276e878d84c01eba2cf2c7c9ebdde00.camel@yadro.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS               |   6 ++
 include/hw/gpio/pcf8574.h |  15 ++++
 hw/gpio/pcf8574.c         | 162 ++++++++++++++++++++++++++++++++++++++
 hw/gpio/Kconfig           |   4 +
 hw/gpio/meson.build       |   1 +
 5 files changed, 188 insertions(+)
 create mode 100644 include/hw/gpio/pcf8574.h
 create mode 100644 hw/gpio/pcf8574.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d96f855de..72c23e3682 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2503,6 +2503,12 @@ S: Maintained
 F: hw/i2c/i2c_mux_pca954x.c
 F: include/hw/i2c/i2c_mux_pca954x.h
 
+pcf8574
+M: Dmitrii Sharikhin <d.sharikhin@yadro.com>
+S: Maintained
+F: hw/gpio/pcf8574.c
+F: include/gpio/pcf8574.h
+
 Generic Loader
 M: Alistair Francis <alistair@alistair23.me>
 S: Maintained
diff --git a/include/hw/gpio/pcf8574.h b/include/hw/gpio/pcf8574.h
new file mode 100644
index 0000000000..3291d7dbbc
--- /dev/null
+++ b/include/hw/gpio/pcf8574.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/*
+ * NXP PCF8574 8-port I2C GPIO expansion chip.
+ *
+ * Copyright (c) 2024 KNS Group (YADRO).
+ * Written by Dmitrii Sharikhin <d.sharikhin@yadro.com>
+ */
+
+#ifndef _HW_GPIO_PCF8574
+#define _HW_GPIO_PCF8574
+
+#define TYPE_PCF8574 "pcf8574"
+
+#endif /* _HW_GPIO_PCF8574 */
diff --git a/hw/gpio/pcf8574.c b/hw/gpio/pcf8574.c
new file mode 100644
index 0000000000..d37909e2ad
--- /dev/null
+++ b/hw/gpio/pcf8574.c
@@ -0,0 +1,162 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/*
+ * NXP PCF8574 8-port I2C GPIO expansion chip.
+ * Copyright (c) 2024 KNS Group (YADRO).
+ * Written by Dmitrii Sharikhin <d.sharikhin@yadro.com>
+ */
+
+#include "qemu/osdep.h"
+#include "hw/i2c/i2c.h"
+#include "hw/gpio/pcf8574.h"
+#include "hw/irq.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qom/object.h"
+
+/*
+ * PCF8574 and compatible chips incorporate quasi-bidirectional
+ * IO. Electrically it means that device sustain pull-up to line
+ * unless IO port is configured as output _and_ driven low.
+ *
+ * IO access is implemented as simple I2C single-byte read
+ * or write operation. So, to configure line to input user write 1
+ * to corresponding bit. To configure line to output and drive it low
+ * user write 0 to corresponding bit.
+ *
+ * In essence, user can think of quasi-bidirectional IO as
+ * open-drain line, except presence of builtin rising edge acceleration
+ * embedded in PCF8574 IC
+ *
+ * PCF8574 has interrupt request line, which is being pulled down when
+ * port line state differs from last read. Port read operation clears
+ * state and INT line returns to high state via pullup.
+ */
+
+OBJECT_DECLARE_SIMPLE_TYPE(PCF8574State, PCF8574)
+
+#define PORTS_COUNT (8)
+
+struct PCF8574State {
+    I2CSlave parent_obj;
+    uint8_t  lastrq;     /* Last requested state. If changed - assert irq */
+    uint8_t  input;      /* external electrical line state */
+    uint8_t  output;     /* Pull-up (1) or drive low (0) on bit */
+    qemu_irq handler[PORTS_COUNT];
+    qemu_irq intrq;      /* External irq request */
+};
+
+static void pcf8574_reset(DeviceState *dev)
+{
+    PCF8574State *s = PCF8574(dev);
+    s->lastrq = MAKE_64BIT_MASK(0, PORTS_COUNT);
+    s->input  = MAKE_64BIT_MASK(0, PORTS_COUNT);
+    s->output = MAKE_64BIT_MASK(0, PORTS_COUNT);
+}
+
+static inline uint8_t pcf8574_line_state(PCF8574State *s)
+{
+    /* we driving line low or external circuit does that */
+    return s->input & s->output;
+}
+
+static uint8_t pcf8574_rx(I2CSlave *i2c)
+{
+    PCF8574State *s = PCF8574(i2c);
+    uint8_t linestate = pcf8574_line_state(s);
+    if (s->lastrq != linestate) {
+        s->lastrq = linestate;
+        if (s->intrq) {
+            qemu_set_irq(s->intrq, 1);
+        }
+    }
+    return linestate;
+}
+
+static int pcf8574_tx(I2CSlave *i2c, uint8_t data)
+{
+    PCF8574State *s = PCF8574(i2c);
+    uint8_t prev;
+    uint8_t diff;
+    uint8_t actual;
+    int line = 0;
+
+    prev = pcf8574_line_state(s);
+    s->output = data;
+    actual = pcf8574_line_state(s);
+
+    for (diff = (actual ^ prev); diff; diff &= ~(1 << line)) {
+        line = ctz32(diff);
+        if (s->handler[line]) {
+            qemu_set_irq(s->handler[line], (actual >> line) & 1);
+        }
+    }
+
+    if (s->intrq) {
+        qemu_set_irq(s->intrq, actual == s->lastrq);
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_pcf8574 = {
+    .name               = "pcf8574",
+    .version_id         = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_I2C_SLAVE(parent_obj, PCF8574State),
+        VMSTATE_UINT8(lastrq, PCF8574State),
+        VMSTATE_UINT8(input,  PCF8574State),
+        VMSTATE_UINT8(output, PCF8574State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void pcf8574_gpio_set(void *opaque, int line, int level)
+{
+    PCF8574State *s = (PCF8574State *) opaque;
+    assert(line >= 0 && line < ARRAY_SIZE(s->handler));
+
+    if (level) {
+        s->input |=  (1 << line);
+    } else {
+        s->input &= ~(1 << line);
+    }
+
+    if (pcf8574_line_state(s) != s->lastrq && s->intrq) {
+        qemu_set_irq(s->intrq, 0);
+    }
+}
+
+static void pcf8574_realize(DeviceState *dev, Error **errp)
+{
+    PCF8574State *s = PCF8574(dev);
+
+    qdev_init_gpio_in(dev, pcf8574_gpio_set, ARRAY_SIZE(s->handler));
+    qdev_init_gpio_out(dev, s->handler, ARRAY_SIZE(s->handler));
+    qdev_init_gpio_out_named(dev, &s->intrq, "nINT", 1);
+}
+
+static void pcf8574_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass   *dc = DEVICE_CLASS(klass);
+    I2CSlaveClass *k  = I2C_SLAVE_CLASS(klass);
+
+    k->recv     = pcf8574_rx;
+    k->send     = pcf8574_tx;
+    dc->realize = pcf8574_realize;
+    dc->reset   = pcf8574_reset;
+    dc->vmsd    = &vmstate_pcf8574;
+}
+
+static const TypeInfo pcf8574_infos[] = {
+    {
+        .name          = TYPE_PCF8574,
+        .parent        = TYPE_I2C_SLAVE,
+        .instance_size = sizeof(PCF8574State),
+        .class_init    = pcf8574_class_init,
+    }
+};
+
+DEFINE_TYPES(pcf8574_infos);
diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index 712940b8e0..19c97cc823 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -19,3 +19,7 @@ config SIFIVE_GPIO
 
 config STM32L4X5_GPIO
     bool
+
+config PCF8574
+    bool
+    depends on I2C
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 3454b503ae..791e93a97b 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -16,3 +16,4 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
 system_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true: files('stm32l4x5_gpio.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
+system_ss.add(when: 'CONFIG_PCF8574', if_true: files('pcf8574.c'))
-- 
2.41.0


