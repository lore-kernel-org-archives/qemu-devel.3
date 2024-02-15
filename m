Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE0CC48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raff5-0001J5-Bg; Thu, 15 Feb 2024 12:36:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeU-00085w-Mp
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:36:05 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeN-00042b-GC
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:36:02 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33d153254b7so134994f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018554; x=1708623354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/eCmN8a4S9HTnFw9WmZzJZdl0Pjm5LLPh17D1FzvRNI=;
 b=YJzmBahEf4kVq//luuQImdnuRSNPijggQVgTobi7y07rsyrYkw31RjPt7bY0h+7CVx
 NPyTikq/GF0/XqMAjdG7j36xWRkZj4cAth3F8cEdmd3FNfNcg2RJm4/DIQ9fnAsKUELB
 Ey6zyXfbLXdIYjqUDCoqcsLbKFs/B2eB29MvlF/6m6QNuDy+O0bpj5/1avCgd4KLOiKW
 DejsOqqfwjG9l6sra4FGq1kSXIMarTzWH+xY2qEqUyWmSbw0Ezy0e/rZPKMyyntGS+10
 /B4yIoxH/wwFlTK3bibubGEfD9UqoGXnsnvu9+UeNJ7tCDt6E4nyojqnk1l7ZRy+kv8Y
 Y3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018554; x=1708623354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/eCmN8a4S9HTnFw9WmZzJZdl0Pjm5LLPh17D1FzvRNI=;
 b=UmAJa1yZjiHlC/R5PxobE//t3YLXmsAEEY4fJxHGYa5xAjOJKmX7ZDLcNLKo2ASyR2
 6G0a6WPUGbO/bu56JGMbdTRou9+mcWQ0QVqJu//9dF/Q2VAI+nXRPDhFSWAeJTMxu9Em
 aI9GNFwUbk1L5LQjDNzv9STyziA3ef2Y7BC/0CteR+t5la2ep8p6Jhac0aTY1hI3Wyh1
 UktT5TWJfRKDMciTV8oqnZCCFSPvzWeSf6xj5I0DZfiIcx+nsUaPoWVEnUmJ/NMFAVOu
 gzEkir0X2bKVK3xYR4L+hwufWbyRR8SyQTd9osvxnoSiwArnkFsm99aIQL9wjZ3gtf7N
 CNug==
X-Gm-Message-State: AOJu0YxsQAqzwrFCOaniItxUiMsScdJBTu1LUYI9nL7R116tW7bATZuQ
 GsdVTjcgEL55Naia/HTuju87DyWyhNAgSyG8TJP3qpV5NvcAhmn7G3M1ehnMOcRUvfMXN07VImp
 j
X-Google-Smtp-Source: AGHT+IHAV2cgv8znpktj56Ts8LDKb0WgA5XALjOHAGtu71dV2Gts22WAhkVh7NQTLZrhnomefvB30A==
X-Received: by 2002:adf:ef46:0:b0:33a:edaf:13ec with SMTP id
 c6-20020adfef46000000b0033aedaf13ecmr1791117wrp.14.1708018553804; 
 Thu, 15 Feb 2024 09:35:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/35] hw/arm/mps3r: Add GPIO, watchdog, dual-timer, I2C devices
Date: Thu, 15 Feb 2024 17:35:36 +0000
Message-Id: <20240215173538.2430599-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

Add the GPIO, watchdog, dual-timer and I2C devices to the mps3-an536
board.  These are all simple devices that just need to be created and
wired up.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240206132931.38376-12-peter.maydell@linaro.org
---
 hw/arm/mps3r.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index 8c790313790..803ed0ffb5c 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -33,11 +33,16 @@
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
 #include "hw/or-irq.h"
+#include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/bsa.h"
 #include "hw/char/cmsdk-apb-uart.h"
+#include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/intc/arm_gicv3.h"
+#include "hw/misc/unimp.h"
+#include "hw/timer/cmsdk-apb-dualtimer.h"
+#include "hw/watchdog/cmsdk-apb-watchdog.h"
 
 /* Define the layout of RAM and ROM in a board */
 typedef struct RAMInfo {
@@ -97,6 +102,10 @@ struct MPS3RMachineState {
     CMSDKAPBUART uart[MPS3R_CPU_MAX + MPS3R_UART_MAX];
     OrIRQState cpu_uart_oflow[MPS3R_CPU_MAX];
     OrIRQState uart_oflow;
+    CMSDKAPBWatchdog watchdog;
+    CMSDKAPBDualTimer dualtimer;
+    ArmSbconI2CState i2c[5];
+    Clock *clk;
 };
 
 #define TYPE_MPS3R_MACHINE "mps3r"
@@ -329,6 +338,9 @@ static void mps3r_common_init(MachineState *machine)
     MemoryRegion *sysmem = get_system_memory();
     DeviceState *gicdev;
 
+    mms->clk = clock_new(OBJECT(machine), "CLK");
+    clock_set_hz(mms->clk, CLK_FRQ);
+
     for (const RAMInfo *ri = mmc->raminfo; ri->name; ri++) {
         MemoryRegion *mr = mr_for_raminfo(mms, ri);
         memory_region_add_subregion(sysmem, ri->base, mr);
@@ -421,6 +433,53 @@ static void mps3r_common_init(MachineState *machine)
                     qdev_get_gpio_in(gicdev, combirq));
     }
 
+    for (int i = 0; i < 4; i++) {
+        /* CMSDK GPIO controllers */
+        g_autofree char *s = g_strdup_printf("gpio%d", i);
+        create_unimplemented_device(s, 0xe0000000 + i * 0x1000, 0x1000);
+    }
+
+    object_initialize_child(OBJECT(mms), "watchdog", &mms->watchdog,
+                            TYPE_CMSDK_APB_WATCHDOG);
+    qdev_connect_clock_in(DEVICE(&mms->watchdog), "WDOGCLK", mms->clk);
+    sysbus_realize(SYS_BUS_DEVICE(&mms->watchdog), &error_fatal);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&mms->watchdog), 0,
+                       qdev_get_gpio_in(gicdev, 0));
+    sysbus_mmio_map(SYS_BUS_DEVICE(&mms->watchdog), 0, 0xe0100000);
+
+    object_initialize_child(OBJECT(mms), "dualtimer", &mms->dualtimer,
+                            TYPE_CMSDK_APB_DUALTIMER);
+    qdev_connect_clock_in(DEVICE(&mms->dualtimer), "TIMCLK", mms->clk);
+    sysbus_realize(SYS_BUS_DEVICE(&mms->dualtimer), &error_fatal);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&mms->dualtimer), 0,
+                       qdev_get_gpio_in(gicdev, 3));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&mms->dualtimer), 1,
+                       qdev_get_gpio_in(gicdev, 1));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&mms->dualtimer), 2,
+                       qdev_get_gpio_in(gicdev, 2));
+    sysbus_mmio_map(SYS_BUS_DEVICE(&mms->dualtimer), 0, 0xe0101000);
+
+    for (int i = 0; i < ARRAY_SIZE(mms->i2c); i++) {
+        static const hwaddr i2cbase[] = {0xe0102000,    /* Touch */
+                                         0xe0103000,    /* Audio */
+                                         0xe0107000,    /* Shield0 */
+                                         0xe0108000,    /* Shield1 */
+                                         0xe0109000};   /* DDR4 EEPROM */
+        g_autofree char *s = g_strdup_printf("i2c%d", i);
+
+        object_initialize_child(OBJECT(mms), s, &mms->i2c[i],
+                                TYPE_ARM_SBCON_I2C);
+        sysbus_realize(SYS_BUS_DEVICE(&mms->i2c[i]), &error_fatal);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&mms->i2c[i]), 0, i2cbase[i]);
+        if (i != 2 && i != 3) {
+            /*
+             * internal-only bus: mark it full to avoid user-created
+             * i2c devices being plugged into it.
+             */
+            qbus_mark_full(qdev_get_child_bus(DEVICE(&mms->i2c[i]), "i2c"));
+        }
+    }
+
     mms->bootinfo.ram_size = machine->ram_size;
     mms->bootinfo.board_id = -1;
     mms->bootinfo.loader_start = mmc->loader_start;
-- 
2.34.1


