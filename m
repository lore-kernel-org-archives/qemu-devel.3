Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23298C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwgCP-0005Bs-Gd; Wed, 19 Aug 2026 09:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1wwgCO-0005Bb-88
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 09:19:20 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1wwgCM-0004rU-7d
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 09:19:19 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so1082219a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 06:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787145557; x=1787750357; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ePfGipNK4v19XZb3CA7EOq8w7Q1IMhBnTuf0QhDiJOM=;
 b=oOZn16O4PkWf9YfLCJQz0JGcq5+qLCxGko4SEKk3NdTp+96ezWMmuzjCMgYeSLwLxm
 7n1Spoxb6b/UXxIk7UlZfhWPj9SrfOe8+9isobDg6PMdHstvfkKGHVs2BFI/+9JBvrGU
 FozNuFlYw1orKqV9exUw0HopQX1N1gUSlonGAstgNdoT9j17LOyJOjQ7g8pAeOnvsonY
 pc6U85LZZEA5ZftjLEZX/3HbGBBqHXg103wIw+lXy3VaeBpNhZCDt2OZJ84BN9m/iVir
 W5YGtf7vKQC77TSDM0sNbPdhrUEWbXm1QX25NXe3UU08WSWe1/yTomGhfg48DtgZQyye
 tHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787145557; x=1787750357;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ePfGipNK4v19XZb3CA7EOq8w7Q1IMhBnTuf0QhDiJOM=;
 b=hFbHwq3o4vgs/r/pgmn4AtAuCdNnHFqrbrUuo2WheLoJMPLZxHbAJemoMlsRioLOWS
 yEZjbWGgpUaG+FlDifQH7Df9FJMiv61//jBfRsbwQV+IXf2adMNb6v/VYtG1dwPfrjs/
 oyUKnjyY9WTsLeX2Mh4tPMbVOKtJJOF5IH5qwrsb9NM/ceq+EvQXoeCvWU+1W4Z8FL/8
 FMhyEpa//HqgxijBEKMypszE11tzKpa5ozmthwZ8f3jcP8vOCOTpPKeUKV4yjL2LmKHO
 XnL4aNYPsVgpdHfmNX4ydlAuHg7q+pz6YZf1m9pPOeGRVB1raajTmRk53zghOl9uCViK
 eKog==
X-Gm-Message-State: AFuF++lT3On41goAWd5VUha5frrRl3vMxOPqLiKtXaOt8TJNUJ7HqzSR
 SANtMBi2Atizt8dmHVx54g6uiSJT6FHuLxjBrf/cMwd/cBhGoCH0/GVrwU5BUv1GNp8ZCw==
X-Gm-Gg: AR+sD11pd+wgbn0EoNLemUhwlz8rq7BVtl7OSN+MWn57hVKj+Waa8Fn0qh8ule8qRmj
 sDNM/ZIlKoUw97rXLEqfhgWv9EcSzSqtJplN0zKvdkpcv/7oH6QQCUCdL9AfO3jv49RtfwZxMWg
 vBYTWpwnHbgLtCI00+9t+CqAALSJ05C12AjSleNCX8PH4GHTJWpQLUt9Wh+yvnq/fJftl+74y9D
 DGrmp7aZI1bpa/0kI541A1bhbgWzNh6XsojqDua04+dCfCXO8Afxz91yxv0VL5RuN+UR10FOLNm
 I+slzZVpbfL2YTF54MJvMYrtmMBhkY5letKHgMCglM6j14OS0daqEBxj5Qctk2kvfF+mig6+rSE
 fnYZ5q4jHivhRCDyrBY2FNArv0Qn28p20BWZzcDNDtWVFaBOnIjo3q/hkHufocnTB8V3BsqpouK
 +/ZgegjgInPwJB/nnIfCLgvXPFAMKn76XcvfJ/IcdYefpYVcA0T2z/A20I4NaIXINCh2sUzG9Dm
 XVhLqmm
X-Received: by 2002:a17:90b:4a8d:b0:38e:ad9d:1161 with SMTP id
 98e67ed59e1d1-39580553dfamr8976336a91.0.1787145556612; 
 Wed, 19 Aug 2026 06:19:16 -0700 (PDT)
Received: from DESKTOP-DFGP8OG.lan ([156.226.169.41])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957fb12145sm2734387a91.4.2026.08.19.06.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 06:19:16 -0700 (PDT)
From: raoyi <rao232328@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 caojunze424 <caojunze424@gmail.com>,
 Bin Meng <bin.meng@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 raoyi <rao232328@gmail.com>
Subject: [PATCH v5 2/3] hw/riscv: add DesignWare APB timer to K230 board
Date: Wed, 19 Aug 2026 21:18:58 +0800
Message-ID: <20260819131859.9583-3-rao232328@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819131859.9583-1-rao232328@gmail.com>
References: <20260819131859.9583-1-rao232328@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=rao232328@gmail.com; helo=mail-pj1-x102a.google.com
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

Wire up the DesignWare APB timer to the K230 SoC with
num-timers=6 and a 50 MHz clock. Connect timer IRQs
to the PLIC. Remove the previous unimplemented timer stub.

Signed-off-by: raoyi <rao232328@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/riscv/Kconfig        |  1 +
 hw/riscv/k230.c         | 33 ++++++++++++++++++++++++++++++---
 include/hw/riscv/k230.h |  8 ++++++++
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index de37c08cae..c2c01af6ee 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -162,3 +162,4 @@ config K230
     select SERIAL_MM
     select UNIMP
     select K230_WDT
+    select DW_APB_TIMER
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 656f28190c..2e641ffec4 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -24,6 +24,8 @@
 #include "target/riscv/cpu.h"
 #include "hw/core/loader.h"
 #include "hw/core/sysbus.h"
+#include "hw/core/clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/riscv/k230.h"
 #include "hw/riscv/boot.h"
 #include "hw/riscv/machines-qom.h"
@@ -37,6 +39,9 @@
 #define K230_DIRECT_KERNEL_ADDR  0x8200000
 #define K230_DIRECT_DTB_ADDR     0xa000000
 
+#define K230_TIMER_NUM_CHANNELS 6
+#define K230_TIMER_DEFAULT_FREQ 50000000
+
 static const MemMapEntry memmap[] = {
     [K230_DEV_DDRC] =         { 0x00000000,  0x80000000 },
     [K230_DEV_KPU_L2_CACHE] = { 0x80000000,  0x00200000 },
@@ -110,6 +115,19 @@ static void k230_soc_init(Object *obj)
     object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
     object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
     object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
+    object_initialize_child(obj, "dw-apb-timer", &s->timer,
+                            TYPE_DW_APB_TIMER);
+
+    qdev_prop_set_uint32(DEVICE(&s->timer), "num-timers",
+                         K230_TIMER_NUM_CHANNELS);
+
+    Clock *timer_clk = clock_new(OBJECT(s), "timer-clk");
+    clock_set_hz(timer_clk, K230_TIMER_DEFAULT_FREQ);
+    for (int i = 0; i < K230_TIMER_NUM_CHANNELS; i++) {
+        g_autofree char *clock_name = g_strdup_printf("timer[%d]", i);
+
+        qdev_connect_clock_in(DEVICE(&s->timer), clock_name, timer_clk);
+    }
 
     qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
@@ -191,6 +209,18 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
         k230_create_uart(sys_mem, DEVICE(s->c908_plic), i);
     }
 
+    /* Timer */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->timer), 0, memmap[K230_DEV_TIMER].base);
+
+    for (int i = 0; i < K230_TIMER_NUM_CHANNELS; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer), i,
+                           qdev_get_gpio_in(DEVICE(s->c908_plic),
+                                            K230_TIMER0_IRQ + i));
+    }
+
     /* Watchdog */
     for (int i = 0; i < 2; i++) {
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
@@ -283,9 +313,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("iomux", memmap[K230_DEV_IOMUX].base,
                                 memmap[K230_DEV_IOMUX].size);
 
-    create_unimplemented_device("timer", memmap[K230_DEV_TIMER].base,
-                                memmap[K230_DEV_TIMER].size);
-
     create_unimplemented_device("wdt0", memmap[K230_DEV_WDT0].base,
                                 memmap[K230_DEV_WDT0].size);
 
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 592e1c26bf..42a36664eb 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -18,6 +18,7 @@
 #include "hw/core/boards.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/watchdog/k230_wdt.h"
+#include "hw/timer/dw-apb-timer.h"
 
 #define C908_CPU_HARTID   (0)
 
@@ -33,6 +34,7 @@ typedef struct K230SoCState {
     RISCVHartArrayState c908_cpu; /* Small core */
 
     K230WdtState wdt[2];
+    DWAPBTimerState timer;
     MemoryRegion sram;
     MemoryRegion bootrom;
 
@@ -127,6 +129,12 @@ enum {
     K230_UART2_IRQ  = 18,
     K230_UART3_IRQ  = 19,
     K230_UART4_IRQ  = 20,
+    K230_TIMER0_IRQ = 101,
+    K230_TIMER1_IRQ = 102,
+    K230_TIMER2_IRQ = 103,
+    K230_TIMER3_IRQ = 104,
+    K230_TIMER4_IRQ = 105,
+    K230_TIMER5_IRQ = 106,
     K230_WDT0_IRQ   = 107,
     K230_WDT1_IRQ   = 108,
 };
-- 
2.53.0


