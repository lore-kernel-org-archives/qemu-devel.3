Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64767C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9Jg-0008C3-BR; Thu, 20 Feb 2025 11:22:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9Jd-00084Y-Mv
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:22:21 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JY-0008Hx-Hn
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:22:20 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-439350f1a0bso7462185e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068535; x=1740673335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dD+2Z65asHuGpqfIVaQkBWugRFu7QutspW4DEkk/CC0=;
 b=Y/R0Ds7TyOp8PrLCc4jLZePDR6Uh4F35yjYonNNcUBPhunC8gsfuBwpRI5C3RMS/af
 R1DaKuUt01mxPrh78YEfaymRY3T5B1zIqh/1GDgSBsuRYsBgzpmQppmbe7hvVvtqzayd
 81otwPxJtOBT+kROdRzLo8KuQy1o5mLqSLCQzV12559iufsEWQopoDzpOcsIzSBbGazo
 Zb6RMR+/Xq5eK1GDd1NK7BKb/3kk+EnLlojoIHcHmtjBWAAJCu4wLiJyCSeujj3ZpTnn
 JYOjBIY3HZOiqS2R2ldYYTOciEPH72vgggKKDwFW2stKbTl/7NiA4E5VQDbPBUc/+X3F
 kU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068535; x=1740673335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dD+2Z65asHuGpqfIVaQkBWugRFu7QutspW4DEkk/CC0=;
 b=YnMurUfY5hKjAREqQg65vJ6SOcCFpTzqjgp28J3Gsljrv3/uLmWBj8eYV1iVs5iP8v
 5U0lA0cqGUhOGZl2bse89A9TvlmXoO3V41S0Ac3JkCofUZQDI+NKPn84lXyQCppTZSL2
 h0oEGqMBBGpl16h5G83r8RuBB07J8Bjb3+eBrq4GR+KcrjWev/Ze9BSn/ag2JZHkbtBg
 Gm8WCLpztx2QS0fKGEdfrWgLwQDIMgUDu1WWwqkmtj7zDhB96N1AU4p/Go5KEUvQpGcd
 HitRUieUsn0eRKgOyLpzgJwpegZCU4PsVqf7R57/EzPLdPBUpwFvuVfReUkrq6h+CtL5
 KaRg==
X-Gm-Message-State: AOJu0YynnFt2neNYjpkxyMtnvSmmCEBgC0K6LHRuMxzQZperbkMVJ6XW
 UVIGHa7CW+dygTHXl3Vpu5RnbWc+ayghKdBWLVGH1Sk9MFGebret4lCQnJ4RC0qYfHNk8Xs5rg4
 p
X-Gm-Gg: ASbGncsUrtyCKwu6ZEbHbY4nEgvKfPPpiuC2iegV2DUqvFfuSTdtK6W8YgtteTcN29F
 f1sr3yFlQDdDCyIusUZBMHWTAg75iXwlmLbLpRNAOjkrVZxEsNERtVNeDY9dezHb0BS/X1nadSf
 p1Tr6yd75BKUlQvTgEpn3r2EegKUfZ+WrNcSY9iyImdDLJgBbVGqgwXJyo3KeUmx654MDRCAG+r
 EbQKX6eBPBNjzc8dJ6kogOwdA92k7SX9fM7cgZAkcM5ZhF9gHmg3xGTh/ia8ZOkkPynW+TA4NjV
 R4k41KyQykYyWvvF10ya0A==
X-Google-Smtp-Source: AGHT+IHfCeKj9m0PxmxMX+65lWV3oxwwYKeyRjWPcFccL71kIqEefoF7/jhh/DXYnD+xkmWrT1LcwA==
X-Received: by 2002:a05:600d:d:b0:439:8439:de7e with SMTP id
 5b1f17b1804b1-439a30e6bf5mr36510965e9.15.1740068535006; 
 Thu, 20 Feb 2025 08:22:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.22.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:22:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/41] hw/arm: Add NPCM845 Evaluation board
Date: Thu, 20 Feb 2025 16:21:21 +0000
Message-ID: <20250220162123.626941-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Hao Wu <wuhaotsh@google.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Hao Wu <wuhaotsh@google.com>
Message-id: 20250219184609.1839281-17-wuhaotsh@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/npcm8xx.h |  21 ++++
 hw/arm/npcm8xx_boards.c  | 253 +++++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build       |   2 +-
 3 files changed, 275 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/npcm8xx_boards.c

diff --git a/include/hw/arm/npcm8xx.h b/include/hw/arm/npcm8xx.h
index a32fbb035b5..9812e6fa7ec 100644
--- a/include/hw/arm/npcm8xx.h
+++ b/include/hw/arm/npcm8xx.h
@@ -51,6 +51,27 @@
 
 #define NPCM8XX_NR_PWM_MODULES 3
 
+struct NPCM8xxMachine {
+    MachineState        parent_obj;
+
+    /*
+     * PWM fan splitter. each splitter connects to one PWM output and
+     * multiple MFT inputs.
+     */
+    SplitIRQ            fan_splitter[NPCM8XX_NR_PWM_MODULES *
+                                     NPCM7XX_PWM_PER_MODULE];
+};
+
+
+struct NPCM8xxMachineClass {
+    MachineClass        parent_class;
+
+    const char          *soc_type;
+};
+
+#define TYPE_NPCM8XX_MACHINE MACHINE_TYPE_NAME("npcm8xx")
+OBJECT_DECLARE_TYPE(NPCM8xxMachine, NPCM8xxMachineClass, NPCM8XX_MACHINE)
+
 struct NPCM8xxState {
     DeviceState         parent_obj;
 
diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
new file mode 100644
index 00000000000..19610483f93
--- /dev/null
+++ b/hw/arm/npcm8xx_boards.c
@@ -0,0 +1,253 @@
+/*
+ * Machine definitions for boards featuring an NPCM8xx SoC.
+ *
+ * Copyright 2021 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+
+#include "qemu/osdep.h"
+
+#include "chardev/char.h"
+#include "hw/arm/npcm8xx.h"
+#include "hw/core/cpu.h"
+#include "hw/loader.h"
+#include "hw/qdev-core.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/datadir.h"
+#include "qemu/units.h"
+
+#define NPCM845_EVB_POWER_ON_STRAPS 0x000017ff
+
+static const char npcm8xx_default_bootrom[] = "npcm8xx_bootrom.bin";
+
+static void npcm8xx_load_bootrom(MachineState *machine, NPCM8xxState *soc)
+{
+    const char *bios_name = machine->firmware ?: npcm8xx_default_bootrom;
+    g_autofree char *filename = NULL;
+    int ret;
+
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+    if (!filename) {
+        error_report("Could not find ROM image '%s'", bios_name);
+        if (!machine->kernel_filename) {
+            /* We can't boot without a bootrom or a kernel image. */
+            exit(1);
+        }
+        return;
+    }
+    ret = load_image_mr(filename, machine->ram);
+    if (ret < 0) {
+        error_report("Failed to load ROM image '%s'", filename);
+        exit(1);
+    }
+}
+
+static void npcm8xx_connect_flash(NPCM7xxFIUState *fiu, int cs_no,
+                                  const char *flash_type, DriveInfo *dinfo)
+{
+    DeviceState *flash;
+    qemu_irq flash_cs;
+
+    flash = qdev_new(flash_type);
+    if (dinfo) {
+        qdev_prop_set_drive(flash, "drive", blk_by_legacy_dinfo(dinfo));
+    }
+    qdev_realize_and_unref(flash, BUS(fiu->spi), &error_fatal);
+
+    flash_cs = qdev_get_gpio_in_named(flash, SSI_GPIO_CS, 0);
+    qdev_connect_gpio_out_named(DEVICE(fiu), "cs", cs_no, flash_cs);
+}
+
+static void npcm8xx_connect_dram(NPCM8xxState *soc, MemoryRegion *dram)
+{
+    memory_region_add_subregion(get_system_memory(), NPCM8XX_DRAM_BA, dram);
+
+    object_property_set_link(OBJECT(soc), "dram-mr", OBJECT(dram),
+                             &error_abort);
+}
+
+static NPCM8xxState *npcm8xx_create_soc(MachineState *machine,
+                                        uint32_t hw_straps)
+{
+    NPCM8xxMachineClass *nmc = NPCM8XX_MACHINE_GET_CLASS(machine);
+    Object *obj;
+
+    obj = object_new_with_props(nmc->soc_type, OBJECT(machine), "soc",
+                                &error_abort, NULL);
+    object_property_set_uint(obj, "power-on-straps", hw_straps, &error_abort);
+
+    return NPCM8XX(obj);
+}
+
+static I2CBus *npcm8xx_i2c_get_bus(NPCM8xxState *soc, uint32_t num)
+{
+    g_assert(num < ARRAY_SIZE(soc->smbus));
+    return I2C_BUS(qdev_get_child_bus(DEVICE(&soc->smbus[num]), "i2c-bus"));
+}
+
+static void npcm8xx_init_pwm_splitter(NPCM8xxMachine *machine,
+                                      NPCM8xxState *soc, const int *fan_counts)
+{
+    SplitIRQ *splitters = machine->fan_splitter;
+
+    /*
+     * PWM 0~3 belong to module 0 output 0~3.
+     * PWM 4~7 belong to module 1 output 0~3.
+     */
+    for (int i = 0; i < NPCM8XX_NR_PWM_MODULES; ++i) {
+        for (int j = 0; j < NPCM7XX_PWM_PER_MODULE; ++j) {
+            int splitter_no = i * NPCM7XX_PWM_PER_MODULE + j;
+            DeviceState *splitter;
+
+            if (fan_counts[splitter_no] < 1) {
+                continue;
+            }
+            object_initialize_child(OBJECT(machine), "fan-splitter[*]",
+                                    &splitters[splitter_no], TYPE_SPLIT_IRQ);
+            splitter = DEVICE(&splitters[splitter_no]);
+            qdev_prop_set_uint16(splitter, "num-lines",
+                                 fan_counts[splitter_no]);
+            qdev_realize(splitter, NULL, &error_abort);
+            qdev_connect_gpio_out_named(DEVICE(&soc->pwm[i]), "duty-gpio-out",
+                                        j, qdev_get_gpio_in(splitter, 0));
+        }
+    }
+}
+
+static void npcm8xx_connect_pwm_fan(NPCM8xxState *soc, SplitIRQ *splitter,
+                                    int fan_no, int output_no)
+{
+    DeviceState *fan;
+    int fan_input;
+    qemu_irq fan_duty_gpio;
+
+    g_assert(fan_no >= 0 && fan_no <= NPCM7XX_MFT_MAX_FAN_INPUT);
+    /*
+     * Fan 0~1 belong to module 0 input 0~1.
+     * Fan 2~3 belong to module 1 input 0~1.
+     * ...
+     * Fan 14~15 belong to module 7 input 0~1.
+     * Fan 16~17 belong to module 0 input 2~3.
+     * Fan 18~19 belong to module 1 input 2~3.
+     */
+    if (fan_no < 16) {
+        fan = DEVICE(&soc->mft[fan_no / 2]);
+        fan_input = fan_no % 2;
+    } else {
+        fan = DEVICE(&soc->mft[(fan_no - 16) / 2]);
+        fan_input = fan_no % 2 + 2;
+    }
+
+    /* Connect the Fan to PWM module */
+    fan_duty_gpio = qdev_get_gpio_in_named(fan, "duty", fan_input);
+    qdev_connect_gpio_out(DEVICE(splitter), output_no, fan_duty_gpio);
+}
+
+static void npcm845_evb_i2c_init(NPCM8xxState *soc)
+{
+    /* tmp100 temperature sensor on SVB, tmp105 is compatible */
+    i2c_slave_create_simple(npcm8xx_i2c_get_bus(soc, 6), "tmp105", 0x48);
+}
+
+static void npcm845_evb_fan_init(NPCM8xxMachine *machine, NPCM8xxState *soc)
+{
+    SplitIRQ *splitter = machine->fan_splitter;
+    static const int fan_counts[] = {2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0};
+
+    npcm8xx_init_pwm_splitter(machine, soc, fan_counts);
+    npcm8xx_connect_pwm_fan(soc, &splitter[0], 0x00, 0);
+    npcm8xx_connect_pwm_fan(soc, &splitter[0], 0x01, 1);
+    npcm8xx_connect_pwm_fan(soc, &splitter[1], 0x02, 0);
+    npcm8xx_connect_pwm_fan(soc, &splitter[1], 0x03, 1);
+    npcm8xx_connect_pwm_fan(soc, &splitter[2], 0x04, 0);
+    npcm8xx_connect_pwm_fan(soc, &splitter[2], 0x05, 1);
+    npcm8xx_connect_pwm_fan(soc, &splitter[3], 0x06, 0);
+    npcm8xx_connect_pwm_fan(soc, &splitter[3], 0x07, 1);
+    npcm8xx_connect_pwm_fan(soc, &splitter[4], 0x08, 0);
+    npcm8xx_connect_pwm_fan(soc, &splitter[4], 0x09, 1);
+    npcm8xx_connect_pwm_fan(soc, &splitter[5], 0x0a, 0);
+    npcm8xx_connect_pwm_fan(soc, &splitter[5], 0x0b, 1);
+    npcm8xx_connect_pwm_fan(soc, &splitter[6], 0x0c, 0);
+    npcm8xx_connect_pwm_fan(soc, &splitter[6], 0x0d, 1);
+    npcm8xx_connect_pwm_fan(soc, &splitter[7], 0x0e, 0);
+    npcm8xx_connect_pwm_fan(soc, &splitter[7], 0x0f, 1);
+}
+
+static void npcm845_evb_init(MachineState *machine)
+{
+    NPCM8xxState *soc;
+
+    soc = npcm8xx_create_soc(machine, NPCM845_EVB_POWER_ON_STRAPS);
+    npcm8xx_connect_dram(soc, machine->ram);
+    qdev_realize(DEVICE(soc), NULL, &error_fatal);
+
+    npcm8xx_load_bootrom(machine, soc);
+    npcm8xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0, 0));
+    npcm845_evb_i2c_init(soc);
+    npcm845_evb_fan_init(NPCM8XX_MACHINE(machine), soc);
+    npcm8xx_load_kernel(machine, soc);
+}
+
+static void npcm8xx_set_soc_type(NPCM8xxMachineClass *nmc, const char *type)
+{
+    NPCM8xxClass *sc = NPCM8XX_CLASS(object_class_by_name(type));
+    MachineClass *mc = MACHINE_CLASS(nmc);
+
+    nmc->soc_type = type;
+    mc->default_cpus = mc->min_cpus = mc->max_cpus = sc->num_cpus;
+}
+
+static void npcm8xx_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a9"),
+        NULL
+    };
+
+    mc->no_floppy = 1;
+    mc->no_cdrom = 1;
+    mc->no_parallel = 1;
+    mc->default_ram_id = "ram";
+    mc->valid_cpu_types = valid_cpu_types;
+}
+
+static void npcm845_evb_machine_class_init(ObjectClass *oc, void *data)
+{
+    NPCM8xxMachineClass *nmc = NPCM8XX_MACHINE_CLASS(oc);
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    npcm8xx_set_soc_type(nmc, TYPE_NPCM8XX);
+
+    mc->desc = "Nuvoton NPCM845 Evaluation Board (Cortex-A35)";
+    mc->init = npcm845_evb_init;
+    mc->default_ram_size = 1 * GiB;
+};
+
+static const TypeInfo npcm8xx_machine_types[] = {
+    {
+        .name           = TYPE_NPCM8XX_MACHINE,
+        .parent         = TYPE_MACHINE,
+        .instance_size  = sizeof(NPCM8xxMachine),
+        .class_size     = sizeof(NPCM8xxMachineClass),
+        .class_init     = npcm8xx_machine_class_init,
+        .abstract       = true,
+    }, {
+        .name           = MACHINE_TYPE_NAME("npcm845-evb"),
+        .parent         = TYPE_NPCM8XX_MACHINE,
+        .class_init     = npcm845_evb_machine_class_init,
+    },
+};
+
+DEFINE_TYPES(npcm8xx_machine_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index d7813c089c5..465c757f976 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -12,7 +12,7 @@ arm_ss.add(when: 'CONFIG_MUSICPAL', if_true: files('musicpal.c'))
 arm_ss.add(when: 'CONFIG_NETDUINOPLUS2', if_true: files('netduinoplus2.c'))
 arm_ss.add(when: 'CONFIG_OLIMEX_STM32_H405', if_true: files('olimex-stm32-h405.c'))
 arm_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx.c', 'npcm7xx_boards.c'))
-arm_ss.add(when: 'CONFIG_NPCM8XX', if_true: files('npcm8xx.c'))
+arm_ss.add(when: 'CONFIG_NPCM8XX', if_true: files('npcm8xx.c', 'npcm8xx_boards.c'))
 arm_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview.c'))
 arm_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa-ref.c'))
 arm_ss.add(when: 'CONFIG_STELLARIS', if_true: files('stellaris.c'))
-- 
2.43.0


