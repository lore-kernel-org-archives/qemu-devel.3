Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91F0C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD0zg-0004OM-UQ; Fri, 31 May 2024 08:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0za-0004Jt-62
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:18 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zU-0003P4-AF
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:17 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4202ca70289so9392035e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157046; x=1717761846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PqegyQo/RPlbUwk+IXlJ2qiNk32ktiHn4vLVd6nK/Is=;
 b=wdRfv2ezieD2jhyiizpvaIoOAp3jnh+EyoNLFyH381M8hDGBUqpkOQC2361TfOf7GQ
 1xf76dHLCARkcNIW27pAhGkst2lojT5YE7w+ecr+L5XOM5XVoCQb3y3gQScEmME69fQ0
 oSMiN3/SbAn6Vi0H8VXytX5J6KuKKbabpckfubgjXnmvVTNsSMcZU2xoYcHrDr8y8zHk
 l5J0eFjZ70Lh5pHjSOQrCRoZVfut7TYDdZSfaRgPm0ORjh6UpX8dHxG49kvS531A0H70
 m54cJ2FzNoizyDCI6zSFxw4+3OaEJjOyMcieff3Fl8P5glhn/C24/TFm7QFOgq28JKZb
 gsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157046; x=1717761846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PqegyQo/RPlbUwk+IXlJ2qiNk32ktiHn4vLVd6nK/Is=;
 b=MksTnvn8hyWcCRhpctJJ7eeEDT5cTOVujoUGmSTcwuzuBTJB/g+8KY5B7eVpBd7nll
 dQSoT7QNkLrmHQbxv/CzEqZyx5NI4ZVg/87qI7nWuftzQTqU3If3XjtphJOPf7PFmkGZ
 I03OvYTXv1T6gZoHoOji1us9azTcwK0y62roUj7LHt70+/s1SRCPNUH4zepzKN+X/Ste
 zBHL9MIR5JFdilhK7ZwJTcD5JDZiU58/hL0AXXMDOx1Pro/aebpGoBjL728Bui+Jonla
 e8vjBRaLD1x3Xy8EooeZ135AKQINRISFq53XcuL51gevnMGcu6t/ROjQ2zD8S0TpHWke
 tDPQ==
X-Gm-Message-State: AOJu0Yxl6enm1lmOZRDYRYKdHd1lHXQOXi5ZVeqPZgdH20eV2DWkz50h
 qIp9XsOix/stheZ7OWmeII4BxnB9fegKlikI8y9yxtQ3LmnWrgNyKZKc5xhtnOwlq7Aaq2GmxLF
 g
X-Google-Smtp-Source: AGHT+IFF2Ka9lI5YM1ZVRCAlYcWbUkcXeAe9p4JaOKybRVK36oq5FRHIwDBk/Vn3c4gPnc8wdnSYeg==
X-Received: by 2002:a05:600c:1d1a:b0:41a:1b3f:b465 with SMTP id
 5b1f17b1804b1-4212e0ae724mr13831165e9.26.1717157046413; 
 Fri, 31 May 2024 05:04:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/43] hw/arm/xilinx_zynq: Support up to two CPU cores
Date: Fri, 31 May 2024 13:03:22 +0100
Message-Id: <20240531120401.394550-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Sebastian Huber <sebastian.huber@embedded-brains.de>

The Zynq 7000 SoCs contain two Arm Cortex-A9 MPCore (the Zynq 7000S have only
one core).  Add support for up to two simulated cores.

Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
Message-id: 20240524120837.10057-3-sebastian.huber@embedded-brains.de
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: removed unnecessary double-cast]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xilinx_zynq.c | 54 +++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 0abb62f131d..7f7a3d23fbe 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -84,9 +84,12 @@ static const int dma_irqs[8] = {
     0xe3401000 + ARMV7_IMM16(extract32((val), 16, 16)), /* movt r1 ... */ \
     0xe5801000 + (addr)
 
+#define ZYNQ_MAX_CPUS 2
+
 struct ZynqMachineState {
     MachineState parent;
     Clock *ps_clk;
+    ARMCPU *cpu[ZYNQ_MAX_CPUS];
 };
 
 static void zynq_write_board_setup(ARMCPU *cpu,
@@ -176,13 +179,13 @@ static inline int zynq_init_spi_flashes(uint32_t base_addr, qemu_irq irq,
 static void zynq_init(MachineState *machine)
 {
     ZynqMachineState *zynq_machine = ZYNQ_MACHINE(machine);
-    ARMCPU *cpu;
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *ocm_ram = g_new(MemoryRegion, 1);
     DeviceState *dev, *slcr;
     SysBusDevice *busdev;
     qemu_irq pic[64];
     int n;
+    unsigned int smp_cpus = machine->smp.cpus;
 
     /* max 2GB ram */
     if (machine->ram_size > 2 * GiB) {
@@ -190,22 +193,27 @@ static void zynq_init(MachineState *machine)
         exit(EXIT_FAILURE);
     }
 
-    cpu = ARM_CPU(object_new(machine->cpu_type));
+    for (n = 0; n < smp_cpus; n++) {
+        Object *cpuobj = object_new(machine->cpu_type);
 
-    /* By default A9 CPUs have EL3 enabled.  This board does not
-     * currently support EL3 so the CPU EL3 property is disabled before
-     * realization.
-     */
-    if (object_property_find(OBJECT(cpu), "has_el3")) {
-        object_property_set_bool(OBJECT(cpu), "has_el3", false, &error_fatal);
+        /*
+         * By default A9 CPUs have EL3 enabled.  This board does not currently
+         * support EL3 so the CPU EL3 property is disabled before realization.
+         */
+        if (object_property_find(cpuobj, "has_el3")) {
+            object_property_set_bool(cpuobj, "has_el3", false, &error_fatal);
+        }
+
+        object_property_set_int(cpuobj, "midr", ZYNQ_BOARD_MIDR,
+                                &error_fatal);
+        object_property_set_int(cpuobj, "reset-cbar", MPCORE_PERIPHBASE,
+                                &error_fatal);
+
+        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
+
+        zynq_machine->cpu[n] = ARM_CPU(cpuobj);
     }
 
-    object_property_set_int(OBJECT(cpu), "midr", ZYNQ_BOARD_MIDR,
-                            &error_fatal);
-    object_property_set_int(OBJECT(cpu), "reset-cbar", MPCORE_PERIPHBASE,
-                            &error_fatal);
-    qdev_realize(DEVICE(cpu), NULL, &error_fatal);
-
     /* DDR remapped to address zero.  */
     memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
@@ -237,15 +245,19 @@ static void zynq_init(MachineState *machine)
     sysbus_mmio_map(SYS_BUS_DEVICE(slcr), 0, 0xF8000000);
 
     dev = qdev_new(TYPE_A9MPCORE_PRIV);
-    qdev_prop_set_uint32(dev, "num-cpu", 1);
+    qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
+    zynq_binfo.gic_cpu_if_addr = MPCORE_PERIPHBASE + 0x100;
     sysbus_create_varargs("l2x0", MPCORE_PERIPHBASE + 0x2000, NULL);
-    sysbus_connect_irq(busdev, 0,
-                       qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_IRQ));
-    sysbus_connect_irq(busdev, 1,
-                       qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_FIQ));
+    for (n = 0; n < smp_cpus; n++) {
+        DeviceState *cpudev = DEVICE(zynq_machine->cpu[n]);
+        sysbus_connect_irq(busdev, (2 * n) + 0,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
+        sysbus_connect_irq(busdev, (2 * n) + 1,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+    }
 
     for (n = 0; n < 64; n++) {
         pic[n] = qdev_get_gpio_in(dev, n);
@@ -350,7 +362,7 @@ static void zynq_init(MachineState *machine)
     zynq_binfo.board_setup_addr = BOARD_SETUP_ADDR;
     zynq_binfo.write_board_setup = zynq_write_board_setup;
 
-    arm_load_kernel(cpu, machine, &zynq_binfo);
+    arm_load_kernel(zynq_machine->cpu[0], machine, &zynq_binfo);
 }
 
 static void zynq_machine_class_init(ObjectClass *oc, void *data)
@@ -362,7 +374,7 @@ static void zynq_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     mc->desc = "Xilinx Zynq Platform Baseboard for Cortex-A9";
     mc->init = zynq_init;
-    mc->max_cpus = 1;
+    mc->max_cpus = ZYNQ_MAX_CPUS;
     mc->no_sdcard = 1;
     mc->ignore_memory_transaction_failures = true;
     mc->valid_cpu_types = valid_cpu_types;
-- 
2.34.1


