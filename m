Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38E2C61DBE
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 04:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0AY8-0008W2-Cz; Sat, 29 Aug 2026 00:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vae1207@gmail.com>) id 1x08Rm-0004o8-Ki
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 22:05:30 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vae1207@gmail.com>) id 1x08Rl-0007oA-0a
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 22:05:30 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2caced6038eso16916785ad.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 19:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787969127; x=1788573927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OA4bHmPtn+iullfuGa/YjjBRxuLIb477GMmwLjWacJY=;
 b=LniXM8cdudDs7UWINmqPuQkpyhnvnHiH1boQgJhT06n3YqHU/jD686zZIRTcHsKqKa
 nfGUiePoj5NZQ2LTULC8E5ViGcg9TelJIq+DeamP8bMLCOPjqu0jfxJBXN9ngMrVBl/P
 OmOCIimI9eaLOxFnTlpvpgOZqb8vE6wsdCP44w5dvssgZVhXiksUK5Bf/6jon6DqYCGt
 ++Db0WC9oTg8qp9F/lPZfMD1WHXXNiMvg4BCRLXLZiRN/DB0+PZyFutu7Y0q+Id+V9ax
 Ip/F6Muf5XGhLYVlBzvJJE+EVUI7ODlw0ZP8FY8hG3DhMfka1JTrGNxCJIBCa3mYkcdU
 7LNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787969127; x=1788573927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OA4bHmPtn+iullfuGa/YjjBRxuLIb477GMmwLjWacJY=;
 b=EnZjaS34XKvUONEi4K/MIWysCHvJ2JVVqNK4iMbtdefFtVPCh8DCGmSpdyZkMkNWLv
 7Sc0woWZuYRpdFV/O0dgK7tk9n+ZfqLdgb9DQJJajH0kkLCn5uLbrNyMCbQa5xEjGujn
 l6wis3vTAfx+uy4GJ7HWrhOnCt10FBAreSpw0YbDOPC4asYOCqyiQ3rFbQBngGYewrVv
 /1lPKiso5588y1jSXumDQ/7miDNXXYNZ8Rt/p0W5ItHlSo9samjrWkCMhAE5o36rycUG
 Cv6uU68zhqef2q6szm+ar7D99YHcumzw3Adfz0B3dLFUA2FuGXob5sOudfbRz5edd5/V
 ky9g==
X-Gm-Message-State: AFuF++l0fho9lH1RrFKl5/3xZ0LH65c5g1v5XYOfWP42Qv51s/w3xDiV
 mGedTK158MBUmJrKJNUfNwXcvafSs/GWJjCcl6oPs2RzoXy185UYp1P4KCuIAdGM
X-Gm-Gg: AYBFou2tZoMuXQBz+TR/IHGHQQbgR0gffmQlQMARED6p3IekPnb6Sl/L16dnhnJ2hbl
 ESXQ3T4UGERuS7y6DpgaX0ZJYLTN4KzDy3rkCqvFueqfxtmwBiie+Ku+1HpRdOs5w2s/xA78P3m
 fEyLYDQRZgURPJpTwvxjtgZ4YVJI31jQaoSxUIYIQ/use2J2nsPsSJk3IFwg5V/Z9SrI0sjvqRi
 ePCV73eaWYl8AeBq0E3VgxRGgDym93eLx+PJR4v/hEKpdOk/+4zbXqH2WkijFQvIAbXR2BCyPMx
 2XfleI3vuRQxXILOfrRuZqYaZzGLyhjvst1KMl9ev1kiRVz1Ru3hRD8pr6pIejafS47Gf5wU7ow
 k5y4vHsDC30JGNunF77OeNcYL9/6QPJYzbd8PBpiDa0rnvhSadG4Dte77WOymuXk4sM69KFuGby
 Xo1Y6dTBzz2O3g9wKTuRgkmXN7U7wPF2yJrBE0jjo+pkrVA71OCeV7OYfnoNf1uve8/J7lgA==
X-Received: by 2002:a17:903:2cf:b0:2d8:d4d2:d138 with SMTP id
 d9443c01a7336-2d8d4d2dd47mr35785725ad.20.1787969127292; 
 Fri, 28 Aug 2026 19:05:27 -0700 (PDT)
Received: from localhost.localdomain ([180.213.79.228])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d759869aeesm10592695ad.46.2026.08.28.19.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 19:05:26 -0700 (PDT)
From: JunWei Li <vae1207@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chenhuacai@canaan-creative.com,
 JunWei Li <vae1207@gmail.com>
Subject: [PATCH 2/3] hw/riscv: wire up K230 PMU in the SoC
Date: Sat, 29 Aug 2026 10:02:28 +0800
Message-Id: <20260829020229.389742-3-vae1207@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260829020229.389742-1-vae1207@gmail.com>
References: <20260829020229.389742-1-vae1207@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=vae1207@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 29 Aug 2026 00:20:10 -0400
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

Instantiate the PMU device, map its MMIO region at 0x91000000 and connect its interrupt line to the small-core PLIC source 81 (TRM 2.4 interrupt bit 65 + 16). Replace the previous unimplemented PMU window.

Signed-off-by: JunWei Li <vae1207@gmail.com>
---
 hw/riscv/Kconfig        |  1 +
 hw/riscv/k230.c         | 12 +++++++++---
 include/hw/riscv/k230.h |  3 +++
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index de37c08cae..0e61e6be3d 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -162,3 +162,4 @@ config K230
     select SERIAL_MM
     select UNIMP
     select K230_WDT
+    select K230_PMU
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 656f28190c..906a5c1240 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -110,6 +110,7 @@ static void k230_soc_init(Object *obj)
     object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
     object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
     object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
+    object_initialize_child(obj, "k230-pmu", &s->pmu, TYPE_K230_PMU);
 
     qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
@@ -191,6 +192,14 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
         k230_create_uart(sys_mem, DEVICE(s->c908_plic), i);
     }
 
+    /* PMU */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->pmu), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->pmu), 0, memmap[K230_DEV_PMU].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pmu), 0,
+                       qdev_get_gpio_in(DEVICE(s->c908_plic), K230_PMU_IRQ));
+
     /* Watchdog */
     for (int i = 0; i < 2; i++) {
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
@@ -259,9 +268,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("3d-engine", memmap[K230_DEV_3D_ENGINE].base,
                                 memmap[K230_DEV_3D_ENGINE].size);
 
-    create_unimplemented_device("pmu", memmap[K230_DEV_PMU].base,
-                                memmap[K230_DEV_PMU].size);
-
     create_unimplemented_device("rtc", memmap[K230_DEV_RTC].base,
                                 memmap[K230_DEV_RTC].size);
 
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 592e1c26bf..5e4845a274 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -16,6 +16,7 @@
 #define HW_K230_H
 
 #include "hw/core/boards.h"
+#include "hw/misc/k230_pmu.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/watchdog/k230_wdt.h"
 
@@ -37,6 +38,7 @@ typedef struct K230SoCState {
     MemoryRegion bootrom;
 
     DeviceState *c908_plic;
+    K230PmuState pmu;
 } K230SoCState;
 
 #define TYPE_RISCV_K230_MACHINE MACHINE_TYPE_NAME("k230")
@@ -127,6 +129,7 @@ enum {
     K230_UART2_IRQ  = 18,
     K230_UART3_IRQ  = 19,
     K230_UART4_IRQ  = 20,
+    K230_PMU_IRQ    = 81,
     K230_WDT0_IRQ   = 107,
     K230_WDT1_IRQ   = 108,
 };
-- 
2.20.1


