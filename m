Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA9AC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raffF-0001rE-F5; Thu, 15 Feb 2024 12:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeU-00085s-M6
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:36:05 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeM-00042F-QH
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:36:02 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-411d715c401so9130975e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018553; x=1708623353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LCg3WUjl9XChO4n77k4Rpa/1Bkv8CUgvWkFZbFL8dFw=;
 b=SFTE9MRZIhmTTy33tCJcHDEdE/a+eSzR4ZMyhKpCcuPmuSmoyxpNxshVa+TzrcxYtq
 siVnj4OfabkT7GVV6dMT4j9xCOZ8qkgKtkzHJlRPR+TkUbn/ijpd4/KAPAChrAZWrNao
 HXJii0S5NvKNQk7BVEQfpsH4vSOKqY6nTkU8Huiv/XoLldSczU7LpXpvxQc6nAsPvU84
 L6fPwDPFbHTIrB/yuzHWVmtIINCap0KKp40LpWBi3L6tb6Ymfd7b+6E1K8bOHqibz/h3
 P3ZoVygZ/xq2WhQynFNxLIkSqYwAq6n4iavIyCyYX4+tlnVmdQXkRg0r6z1act358/mU
 AiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018553; x=1708623353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LCg3WUjl9XChO4n77k4Rpa/1Bkv8CUgvWkFZbFL8dFw=;
 b=aJ3jrp/9+8t3K5EGlcpH+YAI0QfHDeytBtd7bj0PpfawI5K3UQK4Izr0IzByKDwr3/
 j/G7r7/xjSadzgKGTs/pDTmotpboBt7pHKO7m5u/f3BZ8w9l/sqBG8h5UDAuazK0pPHz
 ZsdZSd88CwffKsdBv0hmA3WldGgAmO2RLT6mmrPBHBOlaebVDQxt/zw+jEfHaEGg1N6w
 2g3R2d3G47/MR5OrBl9a6HcCt8/mofxk8P/JNvzSQ7zJ/xWD4zdJFYrRCvex1pduuqSz
 hZG9iL+s45j0dL3+RfiOdCgZLiaqtRX0GwxctRgRRVVYty9+Ba4XEvPgMGTEYwKS5jeV
 LCVg==
X-Gm-Message-State: AOJu0YwcNUKHR1o0ZVPFqhCn0msVi2eyWJmWfOL7vyA0/oiZCaiOCq6d
 tdqqDfChPqSiEN0OZaNO/GriFZ620AZtlz0N+T6ae/kf2v5kPGvq+iC2L/z5kxauZff9V0cl6Ns
 K
X-Google-Smtp-Source: AGHT+IHSxbWSxskXBCYhWEj6Iha1jG4jVfrf9QOlM8khvFsJX08hdAhQ1X4pmAt4QOymI1zh4GaNTA==
X-Received: by 2002:a5d:6dad:0:b0:33b:15fc:22bc with SMTP id
 u13-20020a5d6dad000000b0033b15fc22bcmr2322750wrs.52.1708018553441; 
 Thu, 15 Feb 2024 09:35:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/35] hw/arm/mps3r: Add UARTs
Date: Thu, 15 Feb 2024 17:35:35 +0000
Message-Id: <20240215173538.2430599-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This board has a lot of UARTs: there is one UART per CPU in the
per-CPU peripheral part of the address map, whose interrupts are
connected as per-CPU interrupt lines.  Then there are 4 UARTs in the
normal part of the peripheral space, whose interrupts are shared
peripheral interrupts.

Connect and wire them all up; this involves some OR gates where
multiple overflow interrupts are wired into one GIC input.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240206132931.38376-11-peter.maydell@linaro.org
---
 hw/arm/mps3r.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index 6473f62d677..8c790313790 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -30,10 +30,13 @@
 #include "qapi/qmp/qlist.h"
 #include "exec/address-spaces.h"
 #include "cpu.h"
+#include "sysemu/sysemu.h"
 #include "hw/boards.h"
+#include "hw/or-irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/bsa.h"
+#include "hw/char/cmsdk-apb-uart.h"
 #include "hw/intc/arm_gicv3.h"
 
 /* Define the layout of RAM and ROM in a board */
@@ -65,6 +68,7 @@ typedef struct RAMInfo {
 
 #define MPS3R_RAM_MAX 9
 #define MPS3R_CPU_MAX 2
+#define MPS3R_UART_MAX 4 /* shared UART count */
 
 #define PERIPHBASE 0xf0000000
 #define NUM_SPIS 96
@@ -89,6 +93,10 @@ struct MPS3RMachineState {
     MemoryRegion sysmem_alias[MPS3R_CPU_MAX];
     MemoryRegion cpu_ram[MPS3R_CPU_MAX];
     GICv3State gic;
+    /* per-CPU UARTs followed by the shared UARTs */
+    CMSDKAPBUART uart[MPS3R_CPU_MAX + MPS3R_UART_MAX];
+    OrIRQState cpu_uart_oflow[MPS3R_CPU_MAX];
+    OrIRQState uart_oflow;
 };
 
 #define TYPE_MPS3R_MACHINE "mps3r"
@@ -96,6 +104,13 @@ struct MPS3RMachineState {
 
 OBJECT_DECLARE_TYPE(MPS3RMachineState, MPS3RMachineClass, MPS3R_MACHINE)
 
+/*
+ * Main clock frequency CLK in Hz (50MHz). In the image there are also
+ * ACLK, MCLK, GPUCLK and PERIPHCLK at the same frequency; for our
+ * model we just roll them all into one.
+ */
+#define CLK_FRQ 50000000
+
 static const RAMInfo an536_raminfo[] = {
     {
         .name = "ATCM",
@@ -279,11 +294,40 @@ static void create_gic(MPS3RMachineState *mms, MemoryRegion *sysmem)
     }
 }
 
+/*
+ * Create UART uartno, and map it into the MemoryRegion mem at address baseaddr.
+ * The qemu_irq arguments are where we connect the various IRQs from the UART.
+ */
+static void create_uart(MPS3RMachineState *mms, int uartno, MemoryRegion *mem,
+                        hwaddr baseaddr, qemu_irq txirq, qemu_irq rxirq,
+                        qemu_irq txoverirq, qemu_irq rxoverirq,
+                        qemu_irq combirq)
+{
+    g_autofree char *s = g_strdup_printf("uart%d", uartno);
+    SysBusDevice *sbd;
+
+    assert(uartno < ARRAY_SIZE(mms->uart));
+    object_initialize_child(OBJECT(mms), s, &mms->uart[uartno],
+                            TYPE_CMSDK_APB_UART);
+    qdev_prop_set_uint32(DEVICE(&mms->uart[uartno]), "pclk-frq", CLK_FRQ);
+    qdev_prop_set_chr(DEVICE(&mms->uart[uartno]), "chardev", serial_hd(uartno));
+    sbd = SYS_BUS_DEVICE(&mms->uart[uartno]);
+    sysbus_realize(sbd, &error_fatal);
+    memory_region_add_subregion(mem, baseaddr,
+                                sysbus_mmio_get_region(sbd, 0));
+    sysbus_connect_irq(sbd, 0, txirq);
+    sysbus_connect_irq(sbd, 1, rxirq);
+    sysbus_connect_irq(sbd, 2, txoverirq);
+    sysbus_connect_irq(sbd, 3, rxoverirq);
+    sysbus_connect_irq(sbd, 4, combirq);
+}
+
 static void mps3r_common_init(MachineState *machine)
 {
     MPS3RMachineState *mms = MPS3R_MACHINE(machine);
     MPS3RMachineClass *mmc = MPS3R_MACHINE_GET_CLASS(mms);
     MemoryRegion *sysmem = get_system_memory();
+    DeviceState *gicdev;
 
     for (const RAMInfo *ri = mmc->raminfo; ri->name; ri++) {
         MemoryRegion *mr = mr_for_raminfo(mms, ri);
@@ -326,6 +370,56 @@ static void mps3r_common_init(MachineState *machine)
     }
 
     create_gic(mms, sysmem);
+    gicdev = DEVICE(&mms->gic);
+
+    /*
+     * UARTs 0 and 1 are per-CPU; their interrupts are wired to
+     * the relevant CPU's PPI 0..3, aka INTID 16..19
+     */
+    for (int i = 0; i < machine->smp.cpus; i++) {
+        int intidbase = NUM_SPIS + i * GIC_INTERNAL;
+        g_autofree char *s = g_strdup_printf("cpu-uart-oflow-orgate%d", i);
+        DeviceState *orgate;
+
+        /* The two overflow IRQs from the UART are ORed together into PPI 3 */
+        object_initialize_child(OBJECT(mms), s, &mms->cpu_uart_oflow[i],
+                                TYPE_OR_IRQ);
+        orgate = DEVICE(&mms->cpu_uart_oflow[i]);
+        qdev_prop_set_uint32(orgate, "num-lines", 2);
+        qdev_realize(orgate, NULL, &error_fatal);
+        qdev_connect_gpio_out(orgate, 0,
+                              qdev_get_gpio_in(gicdev, intidbase + 19));
+
+        create_uart(mms, i, &mms->cpu_sysmem[i], 0xe7c00000,
+                    qdev_get_gpio_in(gicdev, intidbase + 17), /* tx */
+                    qdev_get_gpio_in(gicdev, intidbase + 16), /* rx */
+                    qdev_get_gpio_in(orgate, 0), /* txover */
+                    qdev_get_gpio_in(orgate, 1), /* rxover */
+                    qdev_get_gpio_in(gicdev, intidbase + 18) /* combined */);
+    }
+    /*
+     * UARTs 2 to 5 are whole-system; all overflow IRQs are ORed
+     * together into IRQ 17
+     */
+    object_initialize_child(OBJECT(mms), "uart-oflow-orgate",
+                            &mms->uart_oflow, TYPE_OR_IRQ);
+    qdev_prop_set_uint32(DEVICE(&mms->uart_oflow), "num-lines",
+                         MPS3R_UART_MAX * 2);
+    qdev_realize(DEVICE(&mms->uart_oflow), NULL, &error_fatal);
+    qdev_connect_gpio_out(DEVICE(&mms->uart_oflow), 0,
+                          qdev_get_gpio_in(gicdev, 17));
+
+    for (int i = 0; i < MPS3R_UART_MAX; i++) {
+        hwaddr baseaddr = 0xe0205000 + i * 0x1000;
+        int rxirq = 5 + i * 2, txirq = 6 + i * 2, combirq = 13 + i;
+
+        create_uart(mms, i + MPS3R_CPU_MAX, sysmem, baseaddr,
+                    qdev_get_gpio_in(gicdev, txirq),
+                    qdev_get_gpio_in(gicdev, rxirq),
+                    qdev_get_gpio_in(DEVICE(&mms->uart_oflow), i * 2),
+                    qdev_get_gpio_in(DEVICE(&mms->uart_oflow), i * 2 + 1),
+                    qdev_get_gpio_in(gicdev, combirq));
+    }
 
     mms->bootinfo.ram_size = machine->ram_size;
     mms->bootinfo.board_id = -1;
-- 
2.34.1


