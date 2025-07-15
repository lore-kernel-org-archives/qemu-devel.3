Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FDAFC83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 00:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubT6L-0001iK-Bs; Mon, 14 Jul 2025 20:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ubT6K-0001ff-Gz
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 20:00:52 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ubT6H-00083g-Uh
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 20:00:52 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7d9eac11358so483920985a.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 17:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752537648; x=1753142448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nx+xC+J/lP71Qi4WUZDurONxg6YN8jBhmpt2oNrZWbI=;
 b=lZPZxq1ki8Uj0xqlqOLC9xuJNxMgVkyAWOLsMBACRNFwoIAniryzJl7VzuwTKigl5Q
 ToUjYU6iWxFYJTgLiInOGnGO8CBYtTgY252pLxqb2bqnUOA4Jy2VIg3tsqKZuRnhQB9i
 jIbwnNpLyC8/Dn50vTcJPOljYfrkOiUohVD055Cp3zWg/v+56+rPdLS6fvCNlMVCvq/i
 JReSKR9W/FkmY+6GgoUQjrgOpH7j0eiVttsvwHMYrUWm5x5OLzBvv/2BlIakCI1t/gaL
 H/OkmDMXL1psDso3a/3K6j2nZ8p6g8tsiWNNMcrdhh1Ytv/jBTN0rnwOKq2GRPT7RujF
 W6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752537648; x=1753142448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nx+xC+J/lP71Qi4WUZDurONxg6YN8jBhmpt2oNrZWbI=;
 b=Hbh4SuWKleVnd2dFuddmjjvvRDBCigxvH43MA/1UXtetRR8FtTsFBnuGCsS7pqaFOV
 hkKlR0594mqE+1NtL4IRbqz9Vs6iHAnaEJNC3Y7GiOA3QEF+OfDH6M/QqeInqsQ6KGIG
 jOGcZcnwt6pTyGiGiicsVuKuf2p7vGmnBVQeuzOG9IowkAwwqAyHrNiPMpaIjzrhhGxB
 gyjwqsXORDmQFLdPtJMcu/rdMzpTXiJT0VNiXAAguh9j1RdEiWFDjYUGX5TG5Zaa33tG
 FqeBwBcaW/30/Oy3x9v2ABfFGFtUUMPE/cH6GCjK5CN9JKrrFPe4IqQU0QXBNCfoLXxg
 +Sew==
X-Gm-Message-State: AOJu0YyXgtu3IlowYVE+eb14JLO1d9ZwEahsxR6jN9ZixzhpaZjCIS3V
 rd58L8d8Fhys6eTjmmUe17tl1POQyEwzrL07ooqtYVX9O69280FA3YtKhynpRw==
X-Gm-Gg: ASbGncuE7sI2jv6vJuOVdNGephUMSxlFcKZZwL+SP6zToTxEDFcX38Qyjd24/PGFIuH
 GAbMHad/5uiCoi1q/xxD+F9T7/f9QmJ0U5lFjQf2b/QX7IfibbbSgWqlGgxN4XSXzje3ReVxj0o
 GM1QNtCKGR8L0MZkYSaQNNlFf+pzMLh9If6qSgBlSwjgqjLx6dW0Ki91697Cnv0jCF/1sqimsJX
 5yq4Q0iegNQ8JLUbJBcH31wsK/ADAD81Tl32sIRcC3XNxLjELvd8ht7ZheJdzt8ELvRSWY2Wovp
 01LwuNG73XmqlA+hqoWOXtBo2Bah+K85lR6ibsuynPw1aW6bJbzkqU4cHTbvjsIvSbUFqdaYG4O
 aOt8/z6Gp064tNi7EVVrbX1AZyxbZVgnztQcxVboet+cR3FsUQl88kpE2Ng==
X-Google-Smtp-Source: AGHT+IGRhblmx1FY8srB8MyrPDAqASX2Jxr7sB47RkjJOqvBnx+J54fznEP/yN1aZ9hJeoQKxhN8Xw==
X-Received: by 2002:a05:620a:1726:b0:7d3:a6bd:93fc with SMTP id
 af79cd13be357-7ddebc935b0mr2096357685a.28.1752537648223; 
 Mon, 14 Jul 2025 17:00:48 -0700 (PDT)
Received: from user-jcksn.mynetworksettings.com
 ([2600:4040:b51a:4200:2f17:e99b:e0cd:fdf7])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70497d8eee2sm52296276d6.97.2025.07.14.17.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 17:00:47 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v5 01/11] MAX78000: Add MAX78000FTHR Machine
Date: Mon, 14 Jul 2025 20:00:35 -0400
Message-Id: <20250715000045.57332-2-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715000045.57332-1-jcksn@duck.com>
References: <20250715000045.57332-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=jackson88044@gmail.com; helo=mail-qk1-x72b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This patch adds support for the MAX78000FTHR machine.

The MAX78000FTHR contains a MAX78000 and a RISC-V core. This patch
implements only the MAX78000, which is Cortex-M4 based.
Details can be found at:
https://www.analog.com/media/en/technical-documentation/user-guides/max78000-user-guide.pdf

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig                |  10 ++
 hw/arm/max78000_soc.c         | 172 ++++++++++++++++++++++++++++++++++
 hw/arm/max78000fthr.c         |  50 ++++++++++
 hw/arm/meson.build            |   2 +
 include/hw/arm/max78000_soc.h |  35 +++++++
 5 files changed, 269 insertions(+)
 create mode 100644 hw/arm/max78000_soc.c
 create mode 100644 hw/arm/max78000fthr.c
 create mode 100644 include/hw/arm/max78000_soc.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index f543d944c3..ddaafa8faa 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -95,6 +95,12 @@ config INTEGRATOR
     select PL181 # display
     select SMC91C111
 
+config MAX78000FTHR
+    bool
+    default y
+    depends on TCG && ARM
+    select MAX78000_SOC
+
 config MPS3R
     bool
     default y
@@ -357,6 +363,10 @@ config ALLWINNER_R40
     select USB_EHCI_SYSBUS
     select SD
 
+config MAX78000_SOC
+    bool
+    select ARM_V7M
+
 config RASPI
     bool
     default y
diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
new file mode 100644
index 0000000000..9676ada6a2
--- /dev/null
+++ b/hw/arm/max78000_soc.c
@@ -0,0 +1,172 @@
+/*
+ * MAX78000 SOC
+ *
+ * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Implementation based on stm32f205 and Max78000 user guide at
+ * https://www.analog.com/media/en/technical-documentation/user-guides/max78000-user-guide.pdf
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "system/address-spaces.h"
+#include "system/system.h"
+#include "hw/arm/max78000_soc.h"
+#include "hw/qdev-clock.h"
+#include "hw/misc/unimp.h"
+
+static void max78000_soc_initfn(Object *obj)
+{
+    MAX78000State *s = MAX78000_SOC(obj);
+
+    object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
+
+    s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
+}
+
+static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
+{
+    MAX78000State *s = MAX78000_SOC(dev_soc);
+    MemoryRegion *system_memory = get_system_memory();
+    DeviceState *armv7m;
+    Error *err = NULL;
+
+    if (!clock_has_source(s->sysclk)) {
+        error_setg(errp, "sysclk clock must be wired up by the board code");
+        return;
+    }
+
+    memory_region_init_rom(&s->flash, OBJECT(dev_soc), "MAX78000.flash",
+                           FLASH_SIZE, &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->flash);
+
+    memory_region_init_ram(&s->sram, NULL, "MAX78000.sram", SRAM_SIZE,
+                           &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, &s->sram);
+
+    armv7m = DEVICE(&s->armv7m);
+
+    /*
+     * The MAX78000 user guide's Interrupt Vector Table section
+     * suggests that there are 120 IRQs in the text, while only listing
+     * 104 in table 5-1. Implement the more generous of the two.
+     * This has not been tested in hardware.
+     */
+    qdev_prop_set_uint32(armv7m, "num-irq", 120);
+    qdev_prop_set_uint8(armv7m, "num-prio-bits", 3);
+    qdev_prop_set_string(armv7m, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
+    qdev_prop_set_bit(armv7m, "enable-bitband", true);
+    qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
+    object_property_set_link(OBJECT(&s->armv7m), "memory",
+                             OBJECT(system_memory), &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
+        return;
+    }
+
+    create_unimplemented_device("globalControl",        0x40000000, 0x400);
+    create_unimplemented_device("systemInterface",      0x40000400, 0x400);
+    create_unimplemented_device("functionControl",      0x40000800, 0x400);
+    create_unimplemented_device("watchdogTimer0",       0x40003000, 0x400);
+    create_unimplemented_device("dynamicVoltScale",     0x40003c00, 0x40);
+    create_unimplemented_device("SIMO",                 0x40004400, 0x400);
+    create_unimplemented_device("trimSystemInit",       0x40005400, 0x400);
+    create_unimplemented_device("generalCtrlFunc",      0x40005800, 0x400);
+    create_unimplemented_device("wakeupTimer",          0x40006400, 0x400);
+    create_unimplemented_device("powerSequencer",       0x40006800, 0x400);
+    create_unimplemented_device("miscControl",          0x40006c00, 0x400);
+
+    create_unimplemented_device("aes",                  0x40007400, 0x400);
+    create_unimplemented_device("aesKey",               0x40007800, 0x400);
+
+    create_unimplemented_device("gpio0",                0x40008000, 0x1000);
+    create_unimplemented_device("gpio1",                0x40009000, 0x1000);
+
+    create_unimplemented_device("parallelCamInterface", 0x4000e000, 0x1000);
+    create_unimplemented_device("CRC",                  0x4000f000, 0x1000);
+
+    create_unimplemented_device("timer0",               0x40010000, 0x1000);
+    create_unimplemented_device("timer1",               0x40011000, 0x1000);
+    create_unimplemented_device("timer2",               0x40012000, 0x1000);
+    create_unimplemented_device("timer3",               0x40013000, 0x1000);
+
+    create_unimplemented_device("i2c0",                 0x4001d000, 0x1000);
+    create_unimplemented_device("i2c1",                 0x4001e000, 0x1000);
+    create_unimplemented_device("i2c2",                 0x4001f000, 0x1000);
+
+    create_unimplemented_device("standardDMA",          0x40028000, 0x1000);
+    create_unimplemented_device("flashController0",     0x40029000, 0x400);
+
+    create_unimplemented_device("icc0",                 0x4002a000, 0x800);
+    create_unimplemented_device("icc1",                 0x4002a800, 0x800);
+
+    create_unimplemented_device("adc",                  0x40034000, 0x1000);
+    create_unimplemented_device("pulseTrainEngine",     0x4003c000, 0xa0);
+    create_unimplemented_device("oneWireMaster",        0x4003d000, 0x1000);
+    create_unimplemented_device("semaphore",            0x4003e000, 0x1000);
+
+    create_unimplemented_device("uart0",                0x40042000, 0x1000);
+    create_unimplemented_device("uart1",                0x40043000, 0x1000);
+    create_unimplemented_device("uart2",                0x40044000, 0x1000);
+
+    create_unimplemented_device("spi1",                 0x40046000, 0x2000);
+    create_unimplemented_device("trng",                 0x4004d000, 0x1000);
+    create_unimplemented_device("i2s",                  0x40060000, 0x1000);
+    create_unimplemented_device("lowPowerControl",      0x40080000, 0x400);
+    create_unimplemented_device("gpio2",                0x40080400, 0x200);
+    create_unimplemented_device("lowPowerWatchdogTimer",    0x40080800, 0x400);
+    create_unimplemented_device("lowPowerTimer4",       0x40080c00, 0x400);
+
+    create_unimplemented_device("lowPowerTimer5",       0x40081000, 0x400);
+    create_unimplemented_device("lowPowerUART0",        0x40081400, 0x400);
+    create_unimplemented_device("lowPowerComparator",   0x40088000, 0x400);
+
+    create_unimplemented_device("spi0",                 0x400be000, 0x400);
+
+    /*
+     * The MAX78000 user guide's base address map lists the CNN TX FIFO as
+     * beginning at 0x400c0400 and ending at 0x400c0400. Given that CNN_FIFO
+     * is listed as having data accessible up to offset 0x1000, the user
+     * guide is likely incorrect.
+     */
+    create_unimplemented_device("cnnTxFIFO",            0x400c0400, 0x2000);
+
+    create_unimplemented_device("cnnGlobalControl",     0x50000000, 0x10000);
+    create_unimplemented_device("cnnx16quad0",          0x50100000, 0x40000);
+    create_unimplemented_device("cnnx16quad1",          0x50500000, 0x40000);
+    create_unimplemented_device("cnnx16quad2",          0x50900000, 0x40000);
+    create_unimplemented_device("cnnx16quad3",          0x50d00000, 0x40000);
+
+}
+
+static void max78000_soc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = max78000_soc_realize;
+}
+
+static const TypeInfo max78000_soc_info = {
+    .name          = TYPE_MAX78000_SOC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(MAX78000State),
+    .instance_init = max78000_soc_initfn,
+    .class_init    = max78000_soc_class_init,
+};
+
+static void max78000_soc_types(void)
+{
+    type_register_static(&max78000_soc_info);
+}
+
+type_init(max78000_soc_types)
diff --git a/hw/arm/max78000fthr.c b/hw/arm/max78000fthr.c
new file mode 100644
index 0000000000..c4f6b5b1b0
--- /dev/null
+++ b/hw/arm/max78000fthr.c
@@ -0,0 +1,50 @@
+/*
+ * MAX78000FTHR Evaluation Board
+ *
+ * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/boards.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-clock.h"
+#include "qemu/error-report.h"
+#include "hw/arm/max78000_soc.h"
+#include "hw/arm/boot.h"
+
+/* 60MHz is the default, but other clocks can be selected. */
+#define SYSCLK_FRQ 60000000ULL
+static void max78000_init(MachineState *machine)
+{
+    DeviceState *dev;
+    Clock *sysclk;
+
+    sysclk = clock_new(OBJECT(machine), "SYSCLK");
+    clock_set_hz(sysclk, SYSCLK_FRQ);
+
+    dev = qdev_new(TYPE_MAX78000_SOC);
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
+    qdev_connect_clock_in(dev, "sysclk", sysclk);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    armv7m_load_kernel(ARM_CPU(first_cpu),
+                       machine->kernel_filename,
+                       0x00000000, FLASH_SIZE);
+}
+
+static void max78000_machine_init(MachineClass *mc)
+{
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-m4"),
+        NULL
+    };
+
+    mc->desc = "MAX78000FTHR Board (Cortex-M4 / (Unimplemented) RISC-V)";
+    mc->init = max78000_init;
+    mc->valid_cpu_types = valid_cpu_types;
+}
+
+DEFINE_MACHINE("max78000fthr", max78000_machine_init)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index d90be8f4c9..dc68391305 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -27,6 +27,7 @@ arm_common_ss.add(when: 'CONFIG_OMAP', if_true: files('omap1.c'))
 arm_common_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10.c', 'cubieboard.c'))
 arm_common_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3.c', 'orangepi.c'))
 arm_common_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40.c', 'bananapi_m2u.c'))
+arm_common_ss.add(when: 'CONFIG_MAX78000_SOC', if_true: files('max78000_soc.c'))
 arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2836.c', 'raspi.c'))
 arm_common_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if_true: files('bcm2838.c', 'raspi4b.c'))
 arm_common_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c'))
@@ -71,6 +72,7 @@ arm_ss.add(when: 'CONFIG_XEN', if_true: files(
 arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
 arm_common_ss.add(when: 'CONFIG_COLLIE', if_true: files('collie.c'))
 arm_common_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4_boards.c'))
+arm_common_ss.add(when: 'CONFIG_MAX78000FTHR', if_true: files('max78000fthr.c'))
 arm_common_ss.add(when: 'CONFIG_NETDUINO2', if_true: files('netduino2.c'))
 arm_common_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_peripherals.c'))
 arm_common_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2838_peripherals.c'))
diff --git a/include/hw/arm/max78000_soc.h b/include/hw/arm/max78000_soc.h
new file mode 100644
index 0000000000..97bf4099c9
--- /dev/null
+++ b/include/hw/arm/max78000_soc.h
@@ -0,0 +1,35 @@
+/*
+ * MAX78000 SOC
+ *
+ * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_ARM_MAX78000_SOC_H
+#define HW_ARM_MAX78000_SOC_H
+
+#include "hw/or-irq.h"
+#include "hw/arm/armv7m.h"
+#include "qom/object.h"
+
+#define TYPE_MAX78000_SOC "max78000-soc"
+OBJECT_DECLARE_SIMPLE_TYPE(MAX78000State, MAX78000_SOC)
+
+#define FLASH_BASE_ADDRESS 0x10000000
+#define FLASH_SIZE (512 * 1024)
+#define SRAM_BASE_ADDRESS 0x20000000
+#define SRAM_SIZE (128 * 1024)
+
+struct MAX78000State {
+    SysBusDevice parent_obj;
+
+    ARMv7MState armv7m;
+
+    MemoryRegion sram;
+    MemoryRegion flash;
+
+    Clock *sysclk;
+};
+
+#endif
-- 
2.34.1


