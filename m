Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAD5C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNYM-0001Fk-De; Mon, 24 Aug 2026 01:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNXz-0001DR-IH
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:48:42 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNXx-0001jT-SJ
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:48:39 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so3268142a91.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550516; x=1788155316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zYwYUcVG2VW3tzoyHfgQKdzE7Y51E+RzfXFNYF+fePE=;
 b=KZByyVRzWUH9AZtJ7XH/4plMfBRE7mtjDkA18n9k1Ut59S2XbxSvdszZyPyNER9UGL
 pAnOFffRTnmChMQcpj56n339qnw5iKhChgyuhJbAdf/c8wp273wPt9C3Eyeh1zamvwf1
 xXdJmApe+MihwX8IqdlCJ1qyq/+A4skjUaYG1sVFQIgtiIa4DJjZ2/aPBQJaQRMEVNUN
 CgCURg+8vniAlicNOzmxzJmreQ3UObTYB/z8gU92ko72ws4+yoravfcXfo4QyR2j9NcQ
 emgcodrZY3lr/o/pJw6yUcxGJvNiYA7BvnblYgJ0SlB8xCyjbG9I5rRx897NJaGJ/R4O
 yX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550516; x=1788155316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zYwYUcVG2VW3tzoyHfgQKdzE7Y51E+RzfXFNYF+fePE=;
 b=mjw4mUpLzA76wmOpKxgzn4aqTuI39zgW/vZIZFwofnhKHuOCUGMCozYiU/zdKF0PRp
 i0AYCUi2u9RQfGHeCHQ2XEDEv0m4j6R8s0rVSKF62jNRgA723JjzI+cMXLGWDz7o+utL
 WvlRPohdSZaZ2cACYBLGbL1z4ORYao/oTWbYrsaruBM/qfeLffycrQlHq/I2uycw7o8F
 P7QuOjpwben9qJoNoy3Fec4zS0fKB+kdMJKiMm/Qi0GDb3Y0LCDZYe/kv3/UAaa9yCuu
 3mxY87Bs/aPehfo2fwjGTeqcwbeLYrnBTg0qOvrOGkIGMuE89yzCb9vo5lPQ2+iOk47b
 sEgQ==
X-Gm-Message-State: AFuF++m9XyNupULS+AXVfUvYAPq3bqRdvcZCCC4s/3sGcrdvctk5F4ku
 uuOq7vtQkHbccgMqytTodPstzmrCmRXVMRDyLaXJEGJcz26aXfTVWDT6YdqkBQ==
X-Gm-Gg: AR+sD13UXf6BsXP5EObwP1Akaxs5OhUtJyMZaPOcy2748ylVTOIDY3vLQ7OsgrZ9v2Y
 9+XD8qKBOWyVBRAkJj9WAArAX/okCDrnmMvE/9VI2fX9c3dca30cY6y7XB5owDXa7+1r9MoUv7w
 xed5VMjb3LC4NEZ3bEbkcpdLSjvUz+HsQ2whi9Li2zfFosLbkNZrr/3fsl3D+HX5kn57m4vJEz3
 4+lu3XM9q1GcbQSsb4GVvrzlWCwDqyrKvnKFLQvArA7rhDKCr7JAJBvdIzyF8luHa7m5ZbwECuz
 jvxqC9tZ32X3DfDBczNcf6tH3jvxtOaK/C9QtXid2vMvckNA26dUfkb5pv0BmZixSAPL29ZCmJV
 0lm25PzBJZ5iS1AqKfROi1AYQDwaFQx2tq2l3N8GyYKBh7UiugN+PrlCHrw6FK+/O03EKAh5cjp
 pyAmQVt5kLn9spKPy0TbTDTH6HSjLpoxMFJv+bT6i3vuGny/lesK0KHV+h/EcytKBlYjXeX+kgT
 PjOH7o=
X-Received: by 2002:a17:90b:5886:b0:395:4de4:92c7 with SMTP id
 98e67ed59e1d1-395dee7d5f6mr30817566a91.3.1787550516240; 
 Sun, 23 Aug 2026 22:48:36 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:48:35 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Tao Ding <dingtao0430@163.com>, Junze Cao <caojunze424@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 06/96] hw/riscv: k230: add gsdma in K230 board
Date: Mon, 24 Aug 2026 15:46:36 +1000
Message-ID: <20260824054806.2790041-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102f.google.com
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

From: Tao Ding <dingtao0430@163.com>

This commit replaces the unimplemented part of GSDMA in K230. And connect the interrupt to plic.

Update K230.rst.

Signed-off-by: Tao Ding <dingtao0430@163.com>
Reviewed-by: Junze Cao <caojunze424@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260808062227.66961-3-dingtao0430@163.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/system/riscv/k230.rst |  1 +
 include/hw/riscv/k230.h    |  3 +++
 hw/riscv/k230.c            | 12 +++++++++---
 hw/riscv/Kconfig           |  1 +
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
index 06a819fbdb..5cbc0b14bc 100644
--- a/docs/system/riscv/k230.rst
+++ b/docs/system/riscv/k230.rst
@@ -21,6 +21,7 @@ The ``k230`` machine supports the following devices:
 * 2 K230 Watchdog Timer
 * 5 UART
 * K230 DDRC CFG and DDR PHY
+* System Direct Memory Access (SDMA)
 
 Boot options
 ------------
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 80ca16338c..8879d56d98 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -19,6 +19,7 @@
 #include "hw/misc/k230_ddr.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/watchdog/k230_wdt.h"
+#include "hw/dma/k230_gsdma.h"
 
 #define C908_CPU_HARTID   (0)
 
@@ -36,6 +37,7 @@ typedef struct K230SoCState {
     K230DDRCfgState ddr_cfg;
     K230DDRPhyState ddr_phy;
     K230WdtState wdt[2];
+    K230GSDMAState gsdma;
     MemoryRegion sram;
     MemoryRegion bootrom;
 
@@ -133,6 +135,7 @@ enum {
     K230_UART4_IRQ  = 20,
     K230_WDT0_IRQ   = 107,
     K230_WDT1_IRQ   = 108,
+    K230_GSDMA_IRQ  = 140,
 };
 
 #define K230_UART_COUNT 5
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 627150b463..49c3b50c57 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -116,6 +116,7 @@ static void k230_soc_init(Object *obj)
     s->ddr_cfg.phy = &s->ddr_phy;
     object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
     object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
+    object_initialize_child(obj, "k230-gsdma", &s->gsdma, TYPE_K230_GSDMA);
 
     qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
@@ -222,6 +223,14 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[1]), 0,
                        qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT1_IRQ));
 
+    /* Gsdma */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gsdma), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gsdma), 0, memmap[K230_DEV_GSDMA].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gsdma), 0,
+                       qdev_get_gpio_in(DEVICE(s->c908_plic), K230_GSDMA_IRQ));
+
     /* unimplemented devices */
     create_unimplemented_device("kpu.l2-cache",
                                 memmap[K230_DEV_KPU_L2_CACHE].base,
@@ -237,9 +246,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
                                 memmap[K230_DEV_AI_2D_ENGINE].base,
                                 memmap[K230_DEV_AI_2D_ENGINE].size);
 
-    create_unimplemented_device("gsdma", memmap[K230_DEV_GSDMA].base,
-                                memmap[K230_DEV_GSDMA].size);
-
     create_unimplemented_device("dma", memmap[K230_DEV_DMA].base,
                                 memmap[K230_DEV_DMA].size);
 
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index de37c08cae..d28ac06043 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -162,3 +162,4 @@ config K230
     select SERIAL_MM
     select UNIMP
     select K230_WDT
+    select K230_GSDMA
-- 
2.54.0


