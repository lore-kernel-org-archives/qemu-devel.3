Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD997FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLUZ-0008CB-NT; Mon, 27 Apr 2026 08:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNO-0007m2-N0
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:47:51 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNL-0005TY-2Q
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:47:50 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso75993055e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294066; x=1777898866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A7tGHyLb32WspsEMndxPwKXjqKNvzmk7fqExwgmp0k8=;
 b=Y5i4KPpdksSPPY13Xeu7BO1SIwuoas1QuH+s0Z125YtKfrd1nROprbptmSoYF46OgS
 FKF8LIzpM+2rQdXh3nOXGnpobVzbQvu3YMTeyv+dr1uIgoikhqSDgAjLk2G6k5gA6Un2
 PoAt3Fp01doiRQOBPwPHI9mWAYNn2lXUKKmVxZbrrdylVTCBewkFswbcEgCTwonPRJX/
 XzCFfq5r4Kbpk1l1vxUoaOSLCGJ+Z9ptpQUuEz9D7KY4JAM8rd9l+JebqDllz8GPinj8
 jVUdoV0zKx6LyxHM2dxnzWDqT4b0OLpVl6795Tk8pLwkaH+0G4nu+C5B6KyvqdW8P9Hx
 z0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294066; x=1777898866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A7tGHyLb32WspsEMndxPwKXjqKNvzmk7fqExwgmp0k8=;
 b=TuCPs7YBYFXsqFjuofIifbk3xgZlzu6mpcE/0BSvIg6x9bVerqfwk8i7R1Gw7Tw/Ym
 /0UKi3ppcOVjLxf8ayPFDuv/0AnZZu8oLe6NzDw2jtI/c0f9bk1AMdaAWikeyP6ygswZ
 r2P2AymKbTz7PJ+Oix5VbPdXD8FejU4LZ1AVbPnJ7kKzL2wleYmfMrrYO3XAUs3jFaW9
 hExQGmXc7a7noqCusHgj4FY2aeBhkErHwzE8kLOMN/lViq0kHv589r3p93ccYHKvC6Sd
 kirhUQx/H6C5vJus5eY9Xyf1pBji+g5iSMPjmXn3lyfDA3KBE88Kx44zl7+7FRat91St
 OOsA==
X-Gm-Message-State: AOJu0Yzsx0fAs0N57AxUK1QoLKBjTY6FYdZ74ZFdkzXnUkLOJwlvYVPN
 PdG/WeWBw4Mr0Nmuy6ZZ6MkKVR93gYaqWzTOopiYb7iCtavt8AUjpU9mlQxpHTairiLBcNNTItD
 j+cd/
X-Gm-Gg: AeBDietvKQFYIZ6mV9mCFBTiaMhod61HszXSslXeIikLynwFPt9Qpmoh9GBwUYVJPDq
 DQdAzC1bTTKkTHRBT4ESNdNCk3wcaAKeH5XedAehygM+z8Ysu4z0tPxAEh6dh2s33kuLPiL7ZaC
 DxS+EBAINSCWw7x4BKN//P+c17pHvDWRfGQcaj2mkUnUL0JGNnPNNZedBGu2fk0KeFQGk6+g5/6
 urRj7j1+YrHEwVYw4M6IW6F/tdkQG5ruNGVTzZMrM5diFAez4tjrxjBjnQewjaJBrXNKaV9aMA/
 o5x+Uhy5WU+tuyRBTPF71BrSQquGydukIKaoLdZGlCCPp2nLmOY6p0Esdr7PDlWPNrEJJW6ri7J
 EF4XKmjqZrWVUh5fBAFSiwuoxOV6VratAeOW0ul+GEqL2nTzbeY1QctQaTPwXfEcPvI0hVE/+hb
 Xo03t5QmE9SQNUBx43xTU+gisGfD3ctGRuUOa0wh3bGxcblqJnsgoSZGSeUNQfmAckLLeS8U1xo
 4ChuAgx5id34NizR5PQT/SK50QXIGmTzhQzh1fS7g==
X-Received: by 2002:a05:600c:46cb:b0:488:a723:ea53 with SMTP id
 5b1f17b1804b1-488fb744fbemr616335055e9.7.1777294065563; 
 Mon, 27 Apr 2026 05:47:45 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.47.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:47:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/63] hw/arm/fsl-imx8mm: Adding support for USDHC storage
 controllers
Date: Mon, 27 Apr 2026 13:46:41 +0100
Message-ID: <20260427124738.966578-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Gaurav Sharma <gaurav.sharma_7@nxp.com>

It enables emulation of SD/MMC cards through a virtual SDHCI interface
The emulated SDHCI controller allows guest OS to use emulated storage as
a standard block device.
This will allow running the images such as those generated
by Buildroot.

Reviewed-by: Philippe Mathieu-Daude <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig              |  1 +
 hw/arm/fsl-imx8mm.c         | 25 +++++++++++++++++++++++++
 hw/arm/imx8mm-evk.c         | 17 +++++++++++++++++
 include/hw/arm/fsl-imx8mm.h |  7 +++++++
 4 files changed, 50 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 26dc3e6ed1..74e8c431a2 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -623,6 +623,7 @@ config FSL_IMX8MM
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select IMX
+    select SDHCI
 
 config FSL_IMX8MM_EVK
     bool
diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index 8999bc701e..2a4d4d5e6d 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -180,6 +180,10 @@ static void fsl_imx8mm_init(Object *obj)
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
     }
 
+    for (i = 0; i < FSL_IMX8MM_NUM_USDHCS; i++) {
+        g_autofree char *name = g_strdup_printf("usdhc%d", i + 1);
+        object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDHC);
+    }
 }
 
 static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
@@ -357,6 +361,26 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
                                 fsl_imx8mm_memmap[FSL_IMX8MM_OCRAM].addr,
                                 &s->ocram);
 
+    /* USDHCs */
+    for (i = 0; i < FSL_IMX8MM_NUM_USDHCS; i++) {
+        static const struct {
+            hwaddr addr;
+            unsigned int irq;
+        } usdhc_table[FSL_IMX8MM_NUM_USDHCS] = {
+            { fsl_imx8mm_memmap[FSL_IMX8MM_USDHC1].addr, FSL_IMX8MM_USDHC1_IRQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_USDHC2].addr, FSL_IMX8MM_USDHC2_IRQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_USDHC3].addr, FSL_IMX8MM_USDHC3_IRQ },
+        };
+
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->usdhc[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->usdhc[i]), 0, usdhc_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
+                           qdev_get_gpio_in(gicdev, usdhc_table[i].irq));
+    }
+
     /* SNVS */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->snvs), errp)) {
         return;
@@ -375,6 +399,7 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MM_OCRAM:
         case FSL_IMX8MM_SNVS_HP:
         case FSL_IMX8MM_UART1 ... FSL_IMX8MM_UART4:
+        case FSL_IMX8MM_USDHC1 ... FSL_IMX8MM_USDHC3:
             /* device implemented and treated above */
             break;
 
diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
index 0a8cce8866..dfdf3cd4f8 100644
--- a/hw/arm/imx8mm-evk.c
+++ b/hw/arm/imx8mm-evk.c
@@ -84,6 +84,23 @@ static void imx8mm_evk_init(MachineState *machine)
     memory_region_add_subregion(get_system_memory(), FSL_IMX8MM_RAM_START,
                                 machine->ram);
 
+    for (int i = 0; i < FSL_IMX8MM_NUM_USDHCS; i++) {
+        BusState *bus;
+        DeviceState *carddev;
+        BlockBackend *blk;
+        DriveInfo *di = drive_get(IF_SD, i, 0);
+
+        if (!di) {
+            continue;
+        }
+
+        blk = blk_by_legacy_dinfo(di);
+        bus = qdev_get_child_bus(DEVICE(&s->usdhc[i]), "sd-bus");
+        carddev = qdev_new(TYPE_SD_CARD);
+        qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
+        qdev_realize_and_unref(carddev, bus, &error_fatal);
+    }
+
     if (!qtest_enabled()) {
         arm_load_kernel(&s->cpu[0], machine, &boot_info);
     }
diff --git a/include/hw/arm/fsl-imx8mm.h b/include/hw/arm/fsl-imx8mm.h
index 8a172b89e0..93a30a2f55 100644
--- a/include/hw/arm/fsl-imx8mm.h
+++ b/include/hw/arm/fsl-imx8mm.h
@@ -16,6 +16,7 @@
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mp_analog.h"
 #include "hw/misc/imx8mp_ccm.h"
+#include "hw/sd/sdhci.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
@@ -29,6 +30,7 @@ enum FslImx8mmConfiguration {
     FSL_IMX8MM_NUM_CPUS         = 4,
     FSL_IMX8MM_NUM_IRQS         = 128,
     FSL_IMX8MM_NUM_UARTS        = 4,
+    FSL_IMX8MM_NUM_USDHCS       = 3,
 };
 
 struct FslImx8mmState {
@@ -41,6 +43,7 @@ struct FslImx8mmState {
     IMX7SNVSState      snvs;
     IMXSerialState     uart[FSL_IMX8MM_NUM_UARTS];
     MemoryRegion ocram;
+    SDHCIState         usdhc[FSL_IMX8MM_NUM_USDHCS];
 };
 
 enum FslImx8mmMemoryRegions {
@@ -155,6 +158,10 @@ enum FslImx8mmMemoryRegions {
 };
 
 enum FslImx8mmIrqs {
+    FSL_IMX8MM_USDHC1_IRQ   = 22,
+    FSL_IMX8MM_USDHC2_IRQ   = 23,
+    FSL_IMX8MM_USDHC3_IRQ   = 24,
+
     FSL_IMX8MM_UART1_IRQ    = 26,
     FSL_IMX8MM_UART2_IRQ    = 27,
     FSL_IMX8MM_UART3_IRQ    = 28,
-- 
2.43.0


