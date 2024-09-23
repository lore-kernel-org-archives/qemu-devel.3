Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDE2CF9C73
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 10:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssg7L-0001gO-3F; Mon, 23 Sep 2024 06:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssg7H-0001UV-RD; Mon, 23 Sep 2024 06:16:29 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssg7F-0003mv-GX; Mon, 23 Sep 2024 06:16:27 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-378c16a4d3eso4517980f8f.1; 
 Mon, 23 Sep 2024 03:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727086583; x=1727691383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2b1mJAwkVVqAYJcuUdgJuHNRFkJj3LrpBoDGSKjYHZA=;
 b=OSrdO7ch1LEW30/yL2y0iCArghKVj1jZtMxi3GkBdiyzSsNtbhWVZXOtlrnbIbEoTx
 eCazVTrCnoAqwejhymQy1S49l7b5dBlMD8dg+NcKqeH5G1F6MyiTQjZDpSdfxoooKY9t
 26Lq1X2zqmkqDiaKyiEJOdF/aIypzu2micxaB/79AWKZvexirVXbOqNljUj5oAjnCg1Q
 4nVdKhsr5Ktce+WSdfNcGRVsSLGa+dQOaUXQ8bOs28Zc6stZDCAQTzCHjFGTvjRrQ0C7
 vE/S4ea2DFSiGT8p1x/SieKv9pmgM5kxsdLyIkDzerQTlqNzYYfiBelLdJsj967fqvDb
 Fb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727086583; x=1727691383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2b1mJAwkVVqAYJcuUdgJuHNRFkJj3LrpBoDGSKjYHZA=;
 b=tUrNKqKm5K0wLDBvrtNFcPCkM/wwcWW+NgadiY4nMMDblvo9qziRK1z1dzyRf2HGq6
 /8p+8no039J9kn9bZuHFV7LEmcD/pxzZvAsEn0egCNb6ce/BF9B4KfwpXgA9qk8nS4Kb
 607Lrvs433o2GLDVUXrZUMWIk1cV11OHVs1RSoeXyWZuwNjxsh7HIedybgSYZEklHOLq
 rGoAWWDO5ZI6kgbU63Snnwn+vK1YCSl1ykOpvtNvGklXL8YytFavqnu/LYoMuP8PtGPj
 szOYcjoEjW0V/S14iX5RUI8ESnC/7dObRFYuabbDNaPWdbudCdzpk8JWdaZ5gw66Hjct
 QCXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUloIsPV1B2vTwCZ8CMNIHU6DCYFhf0y7AJ6VuQBtcywiHaYGaa5oOiQL+LXBqjtgZdv70MVrskOg==@nongnu.org
X-Gm-Message-State: AOJu0YxEwYytDQ6+zWu9QtC01Rg1nODJKO45PmORGNNZ1SoW6On2MFtT
 9omQE3hprXu679yI2sz7/d9luOHUH+62wFwEY4m0QR/DoG6hnt10Q9DNmg==
X-Google-Smtp-Source: AGHT+IEwsyN1pumKjGOTv4B2KqgSQiAAFi1uE0G1PNq3GBcI0UKS4WMIpNB9TzMme6bCpfJFgAl1kQ==
X-Received: by 2002:adf:f64e:0:b0:371:8dd3:27c8 with SMTP id
 ffacd0b85a97d-37a42279eb8mr10265283f8f.23.1727086582703; 
 Mon, 23 Sep 2024 03:16:22 -0700 (PDT)
Received: from archlinux.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610f43e9sm1187655566b.72.2024.09.23.03.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 03:16:22 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 2/3] hw/gpio/gpio_pwr: Split into separate gpio_poweroff and
 gpio_restart devices
Date: Mon, 23 Sep 2024 12:15:53 +0200
Message-ID: <20240923101554.12900-3-shentey@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923101554.12900-1-shentey@gmail.com>
References: <20240923101554.12900-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x430.google.com
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

Take inspiration from Linux which has separate device tree bindings for the two
GPIO lines. The naming of the two device models matches Linux' compatible
properties.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 MAINTAINERS             |  3 +-
 hw/arm/virt.c           | 32 +++++++++++++------
 hw/gpio/gpio_poweroff.c | 51 ++++++++++++++++++++++++++++++
 hw/gpio/gpio_pwr.c      | 70 -----------------------------------------
 hw/gpio/gpio_restart.c  | 51 ++++++++++++++++++++++++++++++
 hw/arm/Kconfig          |  3 +-
 hw/gpio/Kconfig         |  5 ++-
 hw/gpio/meson.build     |  3 +-
 8 files changed, 134 insertions(+), 84 deletions(-)
 create mode 100644 hw/gpio/gpio_poweroff.c
 delete mode 100644 hw/gpio/gpio_pwr.c
 create mode 100644 hw/gpio/gpio_restart.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e0d3509e8..8c17d68821 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -656,7 +656,8 @@ F: hw/display/pl110*
 F: hw/dma/pl080.c
 F: include/hw/dma/pl080.h
 F: hw/dma/pl330.c
-F: hw/gpio/gpio_pwr.c
+F: hw/gpio/gpio_poweroff.c
+F: hw/gpio/gpio_restart.c
 F: hw/gpio/pl061.c
 F: hw/input/pl050.c
 F: include/hw/input/pl050.h
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 8b2b991d97..1ce1a1ebc1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1032,19 +1032,17 @@ static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
 #define SECURE_GPIO_POWEROFF 0
 #define SECURE_GPIO_RESET    1
 
-static void create_secure_gpio_pwr(char *fdt, DeviceState *pl061_dev,
-                                   uint32_t phandle)
+static void create_secure_gpio_poweroff(char *fdt, DeviceState *pl061_dev,
+                                        uint32_t phandle)
 {
-    DeviceState *gpio_pwr_dev;
+    DeviceState *gpio_poweroff_dev;
 
-    /* gpio-pwr */
-    gpio_pwr_dev = sysbus_create_simple("gpio-pwr", -1, NULL);
+    /* gpio-poweroff */
+    gpio_poweroff_dev = sysbus_create_simple("gpio-poweroff", -1, NULL);
 
-    /* connect secure pl061 to gpio-pwr */
-    qdev_connect_gpio_out(pl061_dev, SECURE_GPIO_RESET,
-                          qdev_get_gpio_in_named(gpio_pwr_dev, "reset", 0));
+    /* connect secure pl061 to gpio-poweroff */
     qdev_connect_gpio_out(pl061_dev, SECURE_GPIO_POWEROFF,
-                          qdev_get_gpio_in_named(gpio_pwr_dev, "shutdown", 0));
+                          qdev_get_gpio_in(gpio_poweroff_dev, 0));
 
     qemu_fdt_add_subnode(fdt, "/gpio-poweroff");
     qemu_fdt_setprop_string(fdt, "/gpio-poweroff", "compatible",
@@ -1054,6 +1052,19 @@ static void create_secure_gpio_pwr(char *fdt, DeviceState *pl061_dev,
     qemu_fdt_setprop_string(fdt, "/gpio-poweroff", "status", "disabled");
     qemu_fdt_setprop_string(fdt, "/gpio-poweroff", "secure-status",
                             "okay");
+}
+
+static void create_secure_gpio_restart(char *fdt, DeviceState *pl061_dev,
+                                       uint32_t phandle)
+{
+    DeviceState *gpio_restart_dev;
+
+    /* gpio-restart */
+    gpio_restart_dev = sysbus_create_simple("gpio-restart", -1, NULL);
+
+    /* connect secure pl061 to gpio-restart */
+    qdev_connect_gpio_out(pl061_dev, SECURE_GPIO_RESET,
+                          qdev_get_gpio_in(gpio_restart_dev, 0));
 
     qemu_fdt_add_subnode(fdt, "/gpio-restart");
     qemu_fdt_setprop_string(fdt, "/gpio-restart", "compatible",
@@ -1112,7 +1123,8 @@ static void create_gpio_devices(const VirtMachineState *vms, int gpio,
     if (gpio == VIRT_GPIO) {
         create_gpio_keys(ms->fdt, pl061_dev, phandle);
     } else {
-        create_secure_gpio_pwr(ms->fdt, pl061_dev, phandle);
+        create_secure_gpio_poweroff(ms->fdt, pl061_dev, phandle);
+        create_secure_gpio_restart(ms->fdt, pl061_dev, phandle);
     }
 }
 
diff --git a/hw/gpio/gpio_poweroff.c b/hw/gpio/gpio_poweroff.c
new file mode 100644
index 0000000000..9c5fd0cc4d
--- /dev/null
+++ b/hw/gpio/gpio_poweroff.c
@@ -0,0 +1,51 @@
+/*
+ * GPIO qemu poweroff controller
+ *
+ * Copyright (c) 2020 Linaro Limited
+ *
+ * Author: Maxim Uvarov <maxim.uvarov@linaro.org>
+ *
+ * Virtual gpio driver which can be used on top of pl061 to reboot qemu virtual
+ * machine. One of use case is gpio driver for secure world application (ARM
+ * Trusted Firmware).
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "sysemu/runstate.h"
+
+#define TYPE_GPIO_POWEROFF "gpio-poweroff"
+OBJECT_DECLARE_SIMPLE_TYPE(GpioPoweroffState, GPIO_POWEROFF)
+
+struct GpioPoweroffState {
+    SysBusDevice parent_obj;
+};
+
+static void gpio_poweroff(void *opaque, int n, int level)
+{
+    if (level) {
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+    }
+}
+
+static void gpio_poweroff_init(Object *obj)
+{
+    DeviceState *dev = DEVICE(obj);
+
+    qdev_init_gpio_in(dev, gpio_poweroff, 1);
+}
+
+static const TypeInfo types[] = {
+    {
+        .name          = TYPE_GPIO_POWEROFF,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(GpioPoweroffState),
+        .instance_init = gpio_poweroff_init,
+    },
+};
+
+DEFINE_TYPES(types)
diff --git a/hw/gpio/gpio_pwr.c b/hw/gpio/gpio_pwr.c
deleted file mode 100644
index dbaf1c70c8..0000000000
--- a/hw/gpio/gpio_pwr.c
+++ /dev/null
@@ -1,70 +0,0 @@
-/*
- * GPIO qemu power controller
- *
- * Copyright (c) 2020 Linaro Limited
- *
- * Author: Maxim Uvarov <maxim.uvarov@linaro.org>
- *
- * Virtual gpio driver which can be used on top of pl061
- * to reboot and shutdown qemu virtual machine. One of use
- * case is gpio driver for secure world application (ARM
- * Trusted Firmware.).
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-/*
- * QEMU interface:
- * two named input GPIO lines:
- *   'reset' : when asserted, trigger system reset
- *   'shutdown' : when asserted, trigger system shutdown
- */
-
-#include "qemu/osdep.h"
-#include "hw/sysbus.h"
-#include "sysemu/runstate.h"
-
-#define TYPE_GPIOPWR "gpio-pwr"
-OBJECT_DECLARE_SIMPLE_TYPE(GPIO_PWR_State, GPIOPWR)
-
-struct GPIO_PWR_State {
-    SysBusDevice parent_obj;
-};
-
-static void gpio_pwr_reset(void *opaque, int n, int level)
-{
-    if (level) {
-        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-    }
-}
-
-static void gpio_pwr_shutdown(void *opaque, int n, int level)
-{
-    if (level) {
-        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
-    }
-}
-
-static void gpio_pwr_init(Object *obj)
-{
-    DeviceState *dev = DEVICE(obj);
-
-    qdev_init_gpio_in_named(dev, gpio_pwr_reset, "reset", 1);
-    qdev_init_gpio_in_named(dev, gpio_pwr_shutdown, "shutdown", 1);
-}
-
-static const TypeInfo gpio_pwr_info = {
-    .name          = TYPE_GPIOPWR,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(GPIO_PWR_State),
-    .instance_init = gpio_pwr_init,
-};
-
-static void gpio_pwr_register_types(void)
-{
-    type_register_static(&gpio_pwr_info);
-}
-
-type_init(gpio_pwr_register_types)
diff --git a/hw/gpio/gpio_restart.c b/hw/gpio/gpio_restart.c
new file mode 100644
index 0000000000..045d8cfda8
--- /dev/null
+++ b/hw/gpio/gpio_restart.c
@@ -0,0 +1,51 @@
+/*
+ * GPIO qemu restart controller
+ *
+ * Copyright (c) 2020 Linaro Limited
+ *
+ * Author: Maxim Uvarov <maxim.uvarov@linaro.org>
+ *
+ * Virtual gpio driver which can be used on top of pl061 to reboot qemu virtual
+ * machine. One of use case is gpio driver for secure world application (ARM
+ * Trusted Firmware).
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "sysemu/runstate.h"
+
+#define TYPE_GPIO_RESTART "gpio-restart"
+OBJECT_DECLARE_SIMPLE_TYPE(GpioRestartState, GPIO_RESTART)
+
+struct GpioRestartState {
+    SysBusDevice parent_obj;
+};
+
+static void gpio_restart(void *opaque, int n, int level)
+{
+    if (level) {
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+    }
+}
+
+static void gpio_restart_init(Object *obj)
+{
+    DeviceState *dev = DEVICE(obj);
+
+    qdev_init_gpio_in(dev, gpio_restart, 1);
+}
+
+static const TypeInfo types[] = {
+    {
+        .name          = TYPE_GPIO_RESTART,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(GpioRestartState),
+        .instance_init = gpio_restart_init,
+    },
+};
+
+DEFINE_TYPES(types)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 1ad60da7aa..2592f8c60b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -23,7 +23,8 @@ config ARM_VIRT
     select PL011 # UART
     select PL031 # RTC
     select PL061 # GPIO
-    select GPIO_PWR
+    select GPIO_POWEROFF
+    select GPIO_RESTART
     select PLATFORM_BUS
     select SMBIOS
     select VIRTIO_MMIO
diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index 19c97cc823..49cb25400c 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -11,7 +11,10 @@ config GPIO_KEY
 config GPIO_MPC8XXX
     bool
 
-config GPIO_PWR
+config GPIO_POWEROFF
+    bool
+
+config GPIO_RESTART
     bool
 
 config SIFIVE_GPIO
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index a7495d196a..0e12f47ce1 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -1,6 +1,7 @@
 system_ss.add(when: 'CONFIG_GPIO_KEY', if_true: files('gpio_key.c'))
 system_ss.add(when: 'CONFIG_GPIO_MPC8XXX', if_true: files('mpc8xxx.c'))
-system_ss.add(when: 'CONFIG_GPIO_PWR', if_true: files('gpio_pwr.c'))
+system_ss.add(when: 'CONFIG_GPIO_POWEROFF', if_true: files('gpio_poweroff.c'))
+system_ss.add(when: 'CONFIG_GPIO_RESTART', if_true: files('gpio_restart.c'))
 system_ss.add(when: 'CONFIG_MAX7310', if_true: files('max7310.c'))
 system_ss.add(when: 'CONFIG_PCA9552', if_true: files('pca9552.c'))
 system_ss.add(when: 'CONFIG_PCA9554', if_true: files('pca9554.c'))
-- 
2.46.1


