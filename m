Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70696C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzCy-00031e-3D; Tue, 11 Mar 2025 08:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCX-0001ew-HI; Tue, 11 Mar 2025 08:59:17 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCT-0007v7-M9; Tue, 11 Mar 2025 08:59:17 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ff615a114bso9408877a91.0; 
 Tue, 11 Mar 2025 05:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741697951; x=1742302751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Js3E974HF75tsKX3gwV22ZPIVLOl+mdYAbePvTKZzbs=;
 b=FIynth60jp2Y3qbvxj0vxcUoau/xLlaQBXVSZqdv5gEilNytGxNGB7P290zngaqaZd
 v5dCsu5fWHh+Iq8IEwU3NxAM+P4Rr//b+vRnUpntX4dqezHHVuUDOSA2p2TjaIRlfXPi
 GhHJf4k2SQUikKFeSfXgyDVb9aEnCeuv37qlCbcV0dvOs5cAiFDLhkH/8exo6XCNGMz1
 KbXttPe2QfF/g7rNDLdEngOrSjX5+b90fj5HXQgsF1gxhHFoYc1DGpXBxqd96VujP52y
 ouxUTW83kz9ld6IkMNOeeR+dBiXM1t57qr0rmYggYf3xbf5vvEY9mr0Hz2zicqjz7iC1
 GJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741697951; x=1742302751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Js3E974HF75tsKX3gwV22ZPIVLOl+mdYAbePvTKZzbs=;
 b=QNPAKUdfPhkTsc4Ui1oBkqmXPEolSd/2KEk8wJBoObNDgfz4Q886cVJO95UeyKLoWO
 FAUKQecQI1u7P3fWCQyXKNBWVSUDz+XBiKTvpN5n0D5Y4LoxCXK1oOPXtkbCixPN5qTr
 HyQkYkx7859x8r5bk7KLrRFgHNSbqJ3dFNVW05vfcNyP+zB/v5ynBRWvPekz5pPUcZD7
 AOL1uf6E23Xa6OmbE/Extr/gJMl5TIvENYUZ8X3BFxiUu3G8IlVx7+JnafrBpWIAxYT+
 obqTheH9AAEsUcaVvSMpbEsBvnJZZgl0rEhgX1DsONZem/xfA64ScDiH3k3b4nCGV8FD
 mscg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWInkRtOjWwdy5j8ZsUp6+WBh2Q6GNNOQd9BFWke+ZkX+NsItHf1l3lQx1qajkc9Sh9XTCSJZFLrg==@nongnu.org
X-Gm-Message-State: AOJu0YyD+jXnZSCMQ3zQJz4DS05uKswJSDtmOn0r3CnG5Jk3/WwVWYc0
 8GwKJAxd4OaXtPN/5JfkDMpvSrWoOVTj71Tm67Rp+QxOr0rRRrGWsnP+9Q==
X-Gm-Gg: ASbGncsq0NmMBEEX5LkUJr46eLnGm0fvtpYUEGkv7YcY9mHwREv7Zdja1+A7lzxjhuk
 t87dcNWPGG6sXOHMSlcjz/0E4yDtGzIC5LNEsULIKUDSI6zaqlS7uA95NPBIvDcsOupH/6oI/uf
 pkdAsFa90sJJlVljgaSzm6E536jIu72hSqlErpHqLmT5I+Xk5Op6fAKHAK5M9TL4hlgQfZJSTnd
 4/LU36kr1REb2ll0EYmrBawUn6daFFGytL2IbQGgFQh0seT8P4MR6u/DYpG6NtlaN2LqTSFY1Q4
 yacCuVOBRX+HpALvdVntrMu3dBF9hWZ6L/9pWDRGTtSWQz3RhG4=
X-Google-Smtp-Source: AGHT+IG/FVJjYyNBQ2uhg6tLvYW64Pd1z+EWw2ar8cLKBeNhYWyWYyu8m7k8ADaUmG20OYIpgpQ0yA==
X-Received: by 2002:a17:90b:1346:b0:2fb:fe21:4841 with SMTP id
 98e67ed59e1d1-3010051f3famr5108789a91.8.1741697950517; 
 Tue, 11 Mar 2025 05:59:10 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.05.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:59:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 12/72] ppc/pnv: Make HOMER memory a RAM region
Date: Tue, 11 Mar 2025 22:57:06 +1000
Message-ID: <20250311125815.903177-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1036.google.com
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

The HOMER is a region of memory used by host and firmware and
microconrollers. It has very little logic by itself, just some BAR
registers. Users of this memory should operate on it rather than
have HOMER implement them with MMIO registers, which is not the
right model.

This change switches the implementation of HOMER from MMIO to RAM,
and moves the OCC register implementation to in-memory structure
accesses performed by the OCC model.

This has the downside that access to unimplemented regions of HOMER
are no longer flagged. Perhaps that could be done by adding a memory
region for HOMER, and ram subregions under that for each implemented
part. But for now this takes the simpler approach.

Note: This brings some data structure definitions from skiboot, which
does not match QEMU coding style but is not changed to make comparisons
and updates simpler.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c               |  89 ++++----
 hw/ppc/pnv_homer.c         | 203 +----------------
 hw/ppc/pnv_occ.c           | 434 ++++++++++++++++++++++++++++++++++++-
 include/hw/ppc/pnv_homer.h |   5 +-
 include/hw/ppc/pnv_occ.h   |   6 +
 roms/SLOF                  |   2 +-
 6 files changed, 495 insertions(+), 244 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 4407b3a1a2..8c0a2d0573 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1555,7 +1555,21 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /* HOMER (must be created before OCC) */
+    object_property_set_link(OBJECT(&chip8->homer), "chip", OBJECT(chip),
+                             &error_abort);
+    if (!qdev_realize(DEVICE(&chip8->homer), NULL, errp)) {
+        return;
+    }
+    /* Homer Xscom region */
+    pnv_xscom_add_subregion(chip, PNV_XSCOM_PBA_BASE, &chip8->homer.pba_regs);
+    /* Homer RAM region */
+    memory_region_add_subregion(get_system_memory(), chip8->homer.base,
+                                &chip8->homer.mem);
+
     /* Create the simplified OCC model */
+    object_property_set_link(OBJECT(&chip8->occ), "homer",
+                             OBJECT(&chip8->homer), &error_abort);
     if (!qdev_realize(DEVICE(&chip8->occ), NULL, errp)) {
         return;
     }
@@ -1567,19 +1581,6 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(), PNV_OCC_SENSOR_BASE(chip),
                                 &chip8->occ.sram_regs);
 
-    /* HOMER */
-    object_property_set_link(OBJECT(&chip8->homer), "chip", OBJECT(chip),
-                             &error_abort);
-    if (!qdev_realize(DEVICE(&chip8->homer), NULL, errp)) {
-        return;
-    }
-    /* Homer Xscom region */
-    pnv_xscom_add_subregion(chip, PNV_XSCOM_PBA_BASE, &chip8->homer.pba_regs);
-
-    /* Homer mmio region */
-    memory_region_add_subregion(get_system_memory(), PNV_HOMER_BASE(chip),
-                                &chip8->homer.regs);
-
     /* PHB controllers */
     for (i = 0; i < chip8->num_phbs; i++) {
         PnvPHB *phb = chip8->phbs[i];
@@ -1863,18 +1864,6 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     pnv_xscom_add_subregion(chip, PNV9_XSCOM_CHIPTOD_BASE,
                             &chip9->chiptod.xscom_regs);
 
-    /* Create the simplified OCC model */
-    if (!qdev_realize(DEVICE(&chip9->occ), NULL, errp)) {
-        return;
-    }
-    pnv_xscom_add_subregion(chip, PNV9_XSCOM_OCC_BASE, &chip9->occ.xscom_regs);
-    qdev_connect_gpio_out(DEVICE(&chip9->occ), 0, qdev_get_gpio_in(
-                              DEVICE(psi9), PSIHB9_IRQ_OCC));
-
-    /* OCC SRAM model */
-    memory_region_add_subregion(get_system_memory(), PNV9_OCC_SENSOR_BASE(chip),
-                                &chip9->occ.sram_regs);
-
     /* SBE */
     if (!qdev_realize(DEVICE(&chip9->sbe), NULL, errp)) {
         return;
@@ -1886,7 +1875,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     qdev_connect_gpio_out(DEVICE(&chip9->sbe), 0, qdev_get_gpio_in(
                               DEVICE(psi9), PSIHB9_IRQ_PSU));
 
-    /* HOMER */
+    /* HOMER (must be created before OCC) */
     object_property_set_link(OBJECT(&chip9->homer), "chip", OBJECT(chip),
                              &error_abort);
     if (!qdev_realize(DEVICE(&chip9->homer), NULL, errp)) {
@@ -1894,10 +1883,23 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     }
     /* Homer Xscom region */
     pnv_xscom_add_subregion(chip, PNV9_XSCOM_PBA_BASE, &chip9->homer.pba_regs);
+    /* Homer RAM region */
+    memory_region_add_subregion(get_system_memory(), chip9->homer.base,
+                                &chip9->homer.mem);
 
-    /* Homer mmio region */
-    memory_region_add_subregion(get_system_memory(), PNV9_HOMER_BASE(chip),
-                                &chip9->homer.regs);
+    /* Create the simplified OCC model */
+    object_property_set_link(OBJECT(&chip9->occ), "homer",
+                             OBJECT(&chip9->homer), &error_abort);
+    if (!qdev_realize(DEVICE(&chip9->occ), NULL, errp)) {
+        return;
+    }
+    pnv_xscom_add_subregion(chip, PNV9_XSCOM_OCC_BASE, &chip9->occ.xscom_regs);
+    qdev_connect_gpio_out(DEVICE(&chip9->occ), 0, qdev_get_gpio_in(
+                              DEVICE(psi9), PSIHB9_IRQ_OCC));
+
+    /* OCC SRAM model */
+    memory_region_add_subregion(get_system_memory(), PNV9_OCC_SENSOR_BASE(chip),
+                                &chip9->occ.sram_regs);
 
     /* PEC PHBs */
     pnv_chip_power9_pec_realize(chip, &local_err);
@@ -2144,7 +2146,22 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     pnv_xscom_add_subregion(chip, PNV10_XSCOM_CHIPTOD_BASE,
                             &chip10->chiptod.xscom_regs);
 
+    /* HOMER (must be created before OCC) */
+    object_property_set_link(OBJECT(&chip10->homer), "chip", OBJECT(chip),
+                             &error_abort);
+    if (!qdev_realize(DEVICE(&chip10->homer), NULL, errp)) {
+        return;
+    }
+    /* Homer Xscom region */
+    pnv_xscom_add_subregion(chip, PNV10_XSCOM_PBA_BASE,
+                            &chip10->homer.pba_regs);
+    /* Homer RAM region */
+    memory_region_add_subregion(get_system_memory(), chip10->homer.base,
+                                &chip10->homer.mem);
+
     /* Create the simplified OCC model */
+    object_property_set_link(OBJECT(&chip10->occ), "homer",
+                             OBJECT(&chip10->homer), &error_abort);
     if (!qdev_realize(DEVICE(&chip10->occ), NULL, errp)) {
         return;
     }
@@ -2169,20 +2186,6 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     qdev_connect_gpio_out(DEVICE(&chip10->sbe), 0, qdev_get_gpio_in(
                               DEVICE(&chip10->psi), PSIHB9_IRQ_PSU));
 
-    /* HOMER */
-    object_property_set_link(OBJECT(&chip10->homer), "chip", OBJECT(chip),
-                             &error_abort);
-    if (!qdev_realize(DEVICE(&chip10->homer), NULL, errp)) {
-        return;
-    }
-    /* Homer Xscom region */
-    pnv_xscom_add_subregion(chip, PNV10_XSCOM_PBA_BASE,
-                            &chip10->homer.pba_regs);
-
-    /* Homer mmio region */
-    memory_region_add_subregion(get_system_memory(), PNV10_HOMER_BASE(chip),
-                                &chip10->homer.regs);
-
     /* N1 chiplet */
     if (!qdev_realize(DEVICE(&chip10->n1_chiplet), NULL, errp)) {
         return;
diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
index 67a1fd77ba..18a53a80c1 100644
--- a/hw/ppc/pnv_homer.c
+++ b/hw/ppc/pnv_homer.c
@@ -29,101 +29,6 @@
 #include "hw/ppc/pnv_homer.h"
 #include "hw/ppc/pnv_xscom.h"
 
-
-static bool core_max_array(PnvHomer *homer, hwaddr addr)
-{
-    int i;
-    PnvHomerClass *hmrc = PNV_HOMER_GET_CLASS(homer);
-
-    for (i = 0; i <= homer->chip->nr_cores; i++) {
-        if (addr == (hmrc->core_max_base + i)) {
-            return true;
-       }
-    }
-    return false;
-}
-
-/* P8 Pstate table */
-
-#define PNV8_OCC_PSTATE_VERSION          0x1f8001
-#define PNV8_OCC_PSTATE_MIN              0x1f8003
-#define PNV8_OCC_PSTATE_VALID            0x1f8000
-#define PNV8_OCC_PSTATE_THROTTLE         0x1f8002
-#define PNV8_OCC_PSTATE_NOM              0x1f8004
-#define PNV8_OCC_PSTATE_TURBO            0x1f8005
-#define PNV8_OCC_PSTATE_ULTRA_TURBO      0x1f8006
-#define PNV8_OCC_PSTATE_DATA             0x1f8008
-#define PNV8_OCC_PSTATE_ID_ZERO          0x1f8010
-#define PNV8_OCC_PSTATE_ID_ONE           0x1f8018
-#define PNV8_OCC_PSTATE_ID_TWO           0x1f8020
-#define PNV8_OCC_VDD_VOLTAGE_IDENTIFIER  0x1f8012
-#define PNV8_OCC_VCS_VOLTAGE_IDENTIFIER  0x1f8013
-#define PNV8_OCC_PSTATE_ZERO_FREQUENCY   0x1f8014
-#define PNV8_OCC_PSTATE_ONE_FREQUENCY    0x1f801c
-#define PNV8_OCC_PSTATE_TWO_FREQUENCY    0x1f8024
-#define PNV8_CORE_MAX_BASE               0x1f8810
-
-
-static uint64_t pnv_power8_homer_read(void *opaque, hwaddr addr,
-                                      unsigned size)
-{
-    PnvHomer *homer = PNV_HOMER(opaque);
-
-    switch (addr) {
-    case PNV8_OCC_PSTATE_VALID:
-        return 1;
-    case PNV8_OCC_PSTATE_THROTTLE:
-        return 0;
-    case PNV8_OCC_PSTATE_VERSION:
-        return 0x02;
-    case PNV8_OCC_PSTATE_MIN:
-        return -2;
-    case PNV8_OCC_PSTATE_NOM:
-    case PNV8_OCC_PSTATE_TURBO:
-        return -1;
-    case PNV8_OCC_PSTATE_ULTRA_TURBO:
-        return 0;
-    case PNV8_OCC_PSTATE_ID_ZERO:
-        return 0;
-    case PNV8_OCC_VDD_VOLTAGE_IDENTIFIER:
-    case PNV8_OCC_VCS_VOLTAGE_IDENTIFIER:
-        return 1;
-    case PNV8_OCC_PSTATE_DATA:
-        return 0;
-    /* P8 frequency for 0, 1, and 2 pstates */
-    case PNV8_OCC_PSTATE_ZERO_FREQUENCY:
-    case PNV8_OCC_PSTATE_ONE_FREQUENCY:
-    case PNV8_OCC_PSTATE_TWO_FREQUENCY:
-        return 3000;
-    case PNV8_OCC_PSTATE_ID_ONE:
-        return -1;
-    case PNV8_OCC_PSTATE_ID_TWO:
-        return -2;
-    }
-    /* pstate table core max array */
-    if (core_max_array(homer, addr)) {
-        return 1;
-    }
-    return 0;
-}
-
-static void pnv_power8_homer_write(void *opaque, hwaddr addr,
-                                   uint64_t val, unsigned size)
-{
-    /* callback function defined to homer write */
-    return;
-}
-
-static const MemoryRegionOps pnv_power8_homer_ops = {
-    .read = pnv_power8_homer_read,
-    .write = pnv_power8_homer_write,
-    .valid.min_access_size = 1,
-    .valid.max_access_size = 8,
-    .impl.min_access_size = 1,
-    .impl.max_access_size = 8,
-    .endianness = DEVICE_BIG_ENDIAN,
-};
-
 /* P8 PBA BARs */
 #define PBA_BAR0                     0x00
 #define PBA_BAR1                     0x01
@@ -192,8 +97,6 @@ static void pnv_homer_power8_class_init(ObjectClass *klass, void *data)
     homer->size = PNV_HOMER_SIZE;
     homer->pba_size = PNV_XSCOM_PBA_SIZE;
     homer->pba_ops = &pnv_homer_power8_pba_ops;
-    homer->homer_ops = &pnv_power8_homer_ops;
-    homer->core_max_base = PNV8_CORE_MAX_BASE;
 }
 
 static const TypeInfo pnv_homer_power8_type_info = {
@@ -203,96 +106,6 @@ static const TypeInfo pnv_homer_power8_type_info = {
     .class_init    = pnv_homer_power8_class_init,
 };
 
-/* P9 Pstate table */
-
-#define PNV9_OCC_PSTATE_VALID            0xe2000
-#define PNV9_OCC_PSTATE_ID_ZERO          0xe2018
-#define PNV9_OCC_PSTATE_ID_ONE           0xe2020
-#define PNV9_OCC_PSTATE_ID_TWO           0xe2028
-#define PNV9_OCC_PSTATE_DATA             0xe2000
-#define PNV9_OCC_PSTATE_MINOR_VERSION    0xe2008
-#define PNV9_OCC_PSTATE_MIN              0xe2003
-#define PNV9_OCC_PSTATE_NOM              0xe2004
-#define PNV9_OCC_PSTATE_TURBO            0xe2005
-#define PNV9_OCC_PSTATE_ULTRA_TURBO      0xe2818
-#define PNV9_OCC_MAX_PSTATE_ULTRA_TURBO  0xe2006
-#define PNV9_OCC_PSTATE_MAJOR_VERSION    0xe2001
-#define PNV9_OCC_OPAL_RUNTIME_DATA       0xe2b85
-#define PNV9_CHIP_HOMER_IMAGE_POINTER    0x200008
-#define PNV9_CHIP_HOMER_BASE             0x0
-#define PNV9_OCC_PSTATE_ZERO_FREQUENCY   0xe201c
-#define PNV9_OCC_PSTATE_ONE_FREQUENCY    0xe2024
-#define PNV9_OCC_PSTATE_TWO_FREQUENCY    0xe202c
-#define PNV9_OCC_ROLE_MASTER_OR_SLAVE    0xe2002
-#define PNV9_CORE_MAX_BASE               0xe2819
-#define PNV9_DYNAMIC_DATA_STATE          0xe2b80
-
-static uint64_t pnv_power9_homer_read(void *opaque, hwaddr addr,
-                                      unsigned size)
-{
-    PnvHomer *homer = PNV_HOMER(opaque);
-
-    switch (addr) {
-    case PNV9_OCC_PSTATE_VALID:
-        return 1;
-    case PNV9_OCC_MAX_PSTATE_ULTRA_TURBO:
-    case PNV9_OCC_PSTATE_ID_ZERO:
-        return 0;
-    case PNV9_OCC_ROLE_MASTER_OR_SLAVE:
-        if (homer->chip->chip_id == 0) {
-            return 0x1; /* master */
-        } else {
-            return 0x0; /* slave */
-        }
-    case PNV9_OCC_PSTATE_NOM:
-    case PNV9_OCC_PSTATE_TURBO:
-    case PNV9_OCC_PSTATE_ID_ONE:
-    case PNV9_OCC_PSTATE_ULTRA_TURBO:
-    case PNV9_OCC_OPAL_RUNTIME_DATA:
-        return 1;
-    case PNV9_OCC_PSTATE_MIN:
-    case PNV9_OCC_PSTATE_ID_TWO:
-        return 2;
-
-    /* 3000 khz frequency for 0, 1, and 2 pstates */
-    case PNV9_OCC_PSTATE_ZERO_FREQUENCY:
-    case PNV9_OCC_PSTATE_ONE_FREQUENCY:
-    case PNV9_OCC_PSTATE_TWO_FREQUENCY:
-        return 3000;
-    case PNV9_OCC_PSTATE_MAJOR_VERSION:
-        return 0x90;
-    case PNV9_OCC_PSTATE_MINOR_VERSION:
-        return 0x01;
-    case PNV9_CHIP_HOMER_BASE:
-    case PNV9_CHIP_HOMER_IMAGE_POINTER:
-        return 0;
-    case PNV9_DYNAMIC_DATA_STATE:
-        return 0x03; /* active */
-    }
-    /* pstate table core max array */
-    if (core_max_array(homer, addr)) {
-        return 1;
-    }
-    return 0;
-}
-
-static void pnv_power9_homer_write(void *opaque, hwaddr addr,
-                                   uint64_t val, unsigned size)
-{
-    /* callback function defined to homer write */
-    return;
-}
-
-static const MemoryRegionOps pnv_power9_homer_ops = {
-    .read = pnv_power9_homer_read,
-    .write = pnv_power9_homer_write,
-    .valid.min_access_size = 1,
-    .valid.max_access_size = 8,
-    .impl.min_access_size = 1,
-    .impl.max_access_size = 8,
-    .endianness = DEVICE_BIG_ENDIAN,
-};
-
 static uint64_t pnv_homer_power9_pba_read(void *opaque, hwaddr addr,
                                           unsigned size)
 {
@@ -351,8 +164,6 @@ static void pnv_homer_power9_class_init(ObjectClass *klass, void *data)
     homer->size = PNV_HOMER_SIZE;
     homer->pba_size = PNV9_XSCOM_PBA_SIZE;
     homer->pba_ops = &pnv_homer_power9_pba_ops;
-    homer->homer_ops = &pnv_power9_homer_ops;
-    homer->core_max_base = PNV9_CORE_MAX_BASE;
 }
 
 static const TypeInfo pnv_homer_power9_type_info = {
@@ -420,8 +231,6 @@ static void pnv_homer_power10_class_init(ObjectClass *klass, void *data)
     homer->size = PNV_HOMER_SIZE;
     homer->pba_size = PNV10_XSCOM_PBA_SIZE;
     homer->pba_ops = &pnv_homer_power10_pba_ops;
-    homer->homer_ops = &pnv_power9_homer_ops; /* TODO */
-    homer->core_max_base = PNV9_CORE_MAX_BASE;
 }
 
 static const TypeInfo pnv_homer_power10_type_info = {
@@ -435,18 +244,22 @@ static void pnv_homer_realize(DeviceState *dev, Error **errp)
 {
     PnvHomer *homer = PNV_HOMER(dev);
     PnvHomerClass *hmrc = PNV_HOMER_GET_CLASS(homer);
+    char homer_str[32];
 
     assert(homer->chip);
 
     pnv_xscom_region_init(&homer->pba_regs, OBJECT(dev), hmrc->pba_ops,
                           homer, "xscom-pba", hmrc->pba_size);
 
-    /* homer region */
+    /* Homer RAM region */
     homer->base = hmrc->get_base(homer->chip);
 
-    memory_region_init_io(&homer->regs, OBJECT(dev),
-                          hmrc->homer_ops, homer, "homer-main-memory",
-                          hmrc->size);
+    snprintf(homer_str, sizeof(homer_str), "homer-chip%d-memory",
+             homer->chip->chip_id);
+    if (!memory_region_init_ram(&homer->mem, OBJECT(homer),
+                                homer_str, hmrc->size, errp)) {
+        return;
+    }
 }
 
 static const Property pnv_homer_properties[] = {
diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index 5424d87ee9..22b07a415a 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -24,9 +24,13 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/ppc/pnv.h"
+#include "hw/ppc/pnv_chip.h"
 #include "hw/ppc/pnv_xscom.h"
 #include "hw/ppc/pnv_occ.h"
 
+#define P8_HOMER_OPAL_DATA_OFFSET    0x1F8000
+#define P9_HOMER_OPAL_DATA_OFFSET    0x0E2000
+
 #define OCB_OCI_OCCMISC         0x4020
 #define OCB_OCI_OCCMISC_AND     0x4021
 #define OCB_OCI_OCCMISC_OR      0x4022
@@ -166,7 +170,11 @@ const MemoryRegionOps pnv_occ_sram_ops = {
 static void pnv_occ_power8_class_init(ObjectClass *klass, void *data)
 {
     PnvOCCClass *poc = PNV_OCC_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->desc = "PowerNV OCC Controller (POWER8)";
+    poc->opal_shared_memory_offset = P8_HOMER_OPAL_DATA_OFFSET;
+    poc->opal_shared_memory_version = 0x02;
     poc->xscom_size = PNV_XSCOM_OCC_SIZE;
     poc->xscom_ops = &pnv_occ_power8_xscom_ops;
 }
@@ -239,8 +247,11 @@ static void pnv_occ_power9_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->desc = "PowerNV OCC Controller (POWER9)";
+    poc->opal_shared_memory_offset = P9_HOMER_OPAL_DATA_OFFSET;
+    poc->opal_shared_memory_version = 0x90;
     poc->xscom_size = PNV9_XSCOM_OCC_SIZE;
     poc->xscom_ops = &pnv_occ_power9_xscom_ops;
+    assert(!dc->user_creatable);
 }
 
 static const TypeInfo pnv_occ_power9_type_info = {
@@ -263,10 +274,19 @@ static const TypeInfo pnv_occ_power10_type_info = {
     .class_init    = pnv_occ_power10_class_init,
 };
 
+static bool occ_init_homer_memory(PnvOCC *occ, Error **errp);
+
 static void pnv_occ_realize(DeviceState *dev, Error **errp)
 {
     PnvOCC *occ = PNV_OCC(dev);
     PnvOCCClass *poc = PNV_OCC_GET_CLASS(occ);
+    PnvHomer *homer = occ->homer;
+
+    assert(homer);
+
+    if (!occ_init_homer_memory(occ, errp)) {
+        return;
+    }
 
     occ->occmisc = 0;
 
@@ -282,12 +302,16 @@ static void pnv_occ_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_out(dev, &occ->psi_irq, 1);
 }
 
+static const Property pnv_occ_properties[] = {
+    DEFINE_PROP_LINK("homer", PnvOCC, homer, TYPE_PNV_HOMER, PnvHomer *),
+};
+
 static void pnv_occ_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = pnv_occ_realize;
-    dc->desc = "PowerNV OCC Controller";
+    device_class_set_props(dc, pnv_occ_properties);
     dc->user_creatable = false;
 }
 
@@ -309,3 +333,411 @@ static void pnv_occ_register_types(void)
 }
 
 type_init(pnv_occ_register_types);
+
+/* From skiboot/hw/occ.c with tab to space conversion */
+/* OCC Communication Area for PStates */
+
+#define OPAL_DYNAMIC_DATA_OFFSET        0x0B80
+/* relative to HOMER_OPAL_DATA_OFFSET */
+
+#define MAX_PSTATES                     256
+#define MAX_P8_CORES                    12
+#define MAX_P9_CORES                    24
+#define MAX_P10_CORES                   32
+
+#define MAX_OPAL_CMD_DATA_LENGTH        4090
+#define MAX_OCC_RSP_DATA_LENGTH         8698
+
+#define P8_PIR_CORE_MASK                0xFFF8
+#define P9_PIR_QUAD_MASK                0xFFF0
+#define P10_PIR_CHIP_MASK               0x0000
+#define FREQ_MAX_IN_DOMAIN              0
+#define FREQ_MOST_RECENTLY_SET          1
+
+#define u8 uint8_t
+#define s8 int8_t
+#define u16 uint16_t
+#define s16 int16_t
+#define u32 uint32_t
+#define s32 int32_t
+#define u64 uint64_t
+#define s64 int64_t
+#define __be16 uint16_t
+#define __be32 uint32_t
+#define __packed QEMU_PACKED
+
+/**
+ * OCC-OPAL Shared Memory Region
+ *
+ * Reference document :
+ * https://github.com/open-power/docs/blob/master/occ/OCC_OpenPwr_FW_Interfaces.pdf
+ *
+ * Supported layout versions:
+ * - 0x01, 0x02 : P8
+ * https://github.com/open-power/occ/blob/master_p8/src/occ/proc/proc_pstate.h
+ *
+ * - 0x90 : P9
+ * https://github.com/open-power/occ/blob/master/src/occ_405/proc/proc_pstate.h
+ *   In 0x90 the data is separated into :-
+ *   -- Static Data (struct occ_pstate_table): Data is written once by OCC
+ *   -- Dynamic Data (struct occ_dynamic_data): Data is updated at runtime
+ *
+ * struct occ_pstate_table -    Pstate table layout
+ * @valid:                      Indicates if data is valid
+ * @version:                    Layout version [Major/Minor]
+ * @v2.throttle:                Reason for limiting the max pstate
+ * @v9.occ_role:                OCC role (Master/Slave)
+ * @v#.pstate_min:              Minimum pstate ever allowed
+ * @v#.pstate_nom:              Nominal pstate
+ * @v#.pstate_turbo:            Maximum turbo pstate
+ * @v#.pstate_ultra_turbo:      Maximum ultra turbo pstate and the maximum
+ *                              pstate ever allowed
+ * @v#.pstates:                 Pstate-id and frequency list from Pmax to Pmin
+ * @v#.pstates.id:              Pstate-id
+ * @v#.pstates.flags:           Pstate-flag(reserved)
+ * @v2.pstates.vdd:             Voltage Identifier
+ * @v2.pstates.vcs:             Voltage Identifier
+ * @v#.pstates.freq_khz:        Frequency in KHz
+ * @v#.core_max[1..N]:          Max pstate with N active cores
+ * @spare/reserved/pad:         Unused data
+ */
+struct occ_pstate_table {
+    u8 valid;
+    u8 version;
+    union __packed {
+        struct __packed { /* Version 0x01 and 0x02 */
+            u8 throttle;
+            s8 pstate_min;
+            s8 pstate_nom;
+            s8 pstate_turbo;
+            s8 pstate_ultra_turbo;
+            u8 spare;
+            u64 reserved;
+            struct __packed {
+                s8 id;
+                u8 flags;
+                u8 vdd;
+                u8 vcs;
+                __be32 freq_khz;
+            } pstates[MAX_PSTATES];
+            s8 core_max[MAX_P8_CORES];
+            u8 pad[100];
+        } v2;
+        struct __packed { /* Version 0x90 */
+            u8 occ_role;
+            u8 pstate_min;
+            u8 pstate_nom;
+            u8 pstate_turbo;
+            u8 pstate_ultra_turbo;
+            u8 spare;
+            u64 reserved1;
+            u64 reserved2;
+            struct __packed {
+                u8 id;
+                u8 flags;
+                u16 reserved;
+                __be32 freq_khz;
+            } pstates[MAX_PSTATES];
+            u8 core_max[MAX_P9_CORES];
+            u8 pad[56];
+        } v9;
+        struct __packed { /* Version 0xA0 */
+            u8 occ_role;
+            u8 pstate_min;
+            u8 pstate_fixed_freq;
+            u8 pstate_base;
+            u8 pstate_ultra_turbo;
+            u8 pstate_fmax;
+            u8 minor;
+            u8 pstate_bottom_throttle;
+            u8 spare;
+            u8 spare1;
+            u32 reserved_32;
+            u64 reserved_64;
+            struct __packed {
+                u8 id;
+                u8 valid;
+                u16 reserved;
+                __be32 freq_khz;
+            } pstates[MAX_PSTATES];
+            u8 core_max[MAX_P10_CORES];
+            u8 pad[48];
+        } v10;
+    };
+} __packed;
+
+/**
+ * OPAL-OCC Command Response Interface
+ *
+ * OPAL-OCC Command Buffer
+ *
+ * ---------------------------------------------------------------------
+ * | OPAL  |  Cmd    | OPAL |          | Cmd Data | Cmd Data | OPAL    |
+ * | Cmd   | Request | OCC  | Reserved | Length   | Length   | Cmd     |
+ * | Flags |   ID    | Cmd  |          | (MSB)    | (LSB)    | Data... |
+ * ---------------------------------------------------------------------
+ * |  ….OPAL Command Data up to max of Cmd Data Length 4090 bytes      |
+ * |                                                                   |
+ * ---------------------------------------------------------------------
+ *
+ * OPAL Command Flag
+ *
+ * -----------------------------------------------------------------
+ * | Bit 7 | Bit 6 | Bit 5 | Bit 4 | Bit 3 | Bit 2 | Bit 1 | Bit 0 |
+ * | (msb) |       |       |       |       |       |       | (lsb) |
+ * -----------------------------------------------------------------
+ * |Cmd    |       |       |       |       |       |       |       |
+ * |Ready  |       |       |       |       |       |       |       |
+ * -----------------------------------------------------------------
+ *
+ * struct opal_command_buffer - Defines the layout of OPAL command buffer
+ * @flag:                       Provides general status of the command
+ * @request_id:                 Token to identify request
+ * @cmd:                        Command sent
+ * @data_size:                  Command data length
+ * @data:                       Command specific data
+ * @spare:                      Unused byte
+ */
+struct opal_command_buffer {
+    u8 flag;
+    u8 request_id;
+    u8 cmd;
+    u8 spare;
+    __be16 data_size;
+    u8 data[MAX_OPAL_CMD_DATA_LENGTH];
+} __packed;
+
+/**
+ * OPAL-OCC Response Buffer
+ *
+ * ---------------------------------------------------------------------
+ * | OCC   |  Cmd    | OPAL | Response | Rsp Data | Rsp Data | OPAL    |
+ * | Rsp   | Request | OCC  |  Status  | Length   | Length   | Rsp     |
+ * | Flags |   ID    | Cmd  |          | (MSB)    | (LSB)    | Data... |
+ * ---------------------------------------------------------------------
+ * |  ….OPAL Response Data up to max of Rsp Data Length 8698 bytes     |
+ * |                                                                   |
+ * ---------------------------------------------------------------------
+ *
+ * OCC Response Flag
+ *
+ * -----------------------------------------------------------------
+ * | Bit 7 | Bit 6 | Bit 5 | Bit 4 | Bit 3 | Bit 2 | Bit 1 | Bit 0 |
+ * | (msb) |       |       |       |       |       |       | (lsb) |
+ * -----------------------------------------------------------------
+ * |       |       |       |       |       |       |OCC in  | Rsp  |
+ * |       |       |       |       |       |       |progress|Ready |
+ * -----------------------------------------------------------------
+ *
+ * struct occ_response_buffer - Defines the layout of OCC response buffer
+ * @flag:                       Provides general status of the response
+ * @request_id:                 Token to identify request
+ * @cmd:                        Command requested
+ * @status:                     Indicates success/failure status of
+ *                              the command
+ * @data_size:                  Response data length
+ * @data:                       Response specific data
+ */
+struct occ_response_buffer {
+    u8 flag;
+    u8 request_id;
+    u8 cmd;
+    u8 status;
+    __be16 data_size;
+    u8 data[MAX_OCC_RSP_DATA_LENGTH];
+} __packed;
+
+/**
+ * OCC-OPAL Shared Memory Interface Dynamic Data Vx90
+ *
+ * struct occ_dynamic_data -    Contains runtime attributes
+ * @occ_state:                  Current state of OCC
+ * @major_version:              Major version number
+ * @minor_version:              Minor version number (backwards compatible)
+ *                              Version 1 indicates GPU presence populated
+ * @gpus_present:               Bitmask of GPUs present (on systems where GPU
+ *                              presence is detected through APSS)
+ * @cpu_throttle:               Reason for limiting the max pstate
+ * @mem_throttle:               Reason for throttling memory
+ * @quick_pwr_drop:             Indicates if QPD is asserted
+ * @pwr_shifting_ratio:         Indicates the current percentage of power to
+ *                              take away from the CPU vs GPU when shifting
+ *                              power to maintain a power cap. Value of 100
+ *                              means take all power from CPU.
+ * @pwr_cap_type:               Indicates type of power cap in effect
+ * @hard_min_pwr_cap:           Hard minimum system power cap in Watts.
+ *                              Guaranteed unless hardware failure
+ * @max_pwr_cap:                Maximum allowed system power cap in Watts
+ * @cur_pwr_cap:                Current system power cap
+ * @soft_min_pwr_cap:           Soft powercap minimum. OCC may or may not be
+ *                              able to maintain this
+ * @spare/reserved:             Unused data
+ * @cmd:                        Opal Command Buffer
+ * @rsp:                        OCC Response Buffer
+ */
+struct occ_dynamic_data {
+    u8 occ_state;
+    u8 major_version;
+    u8 minor_version;
+    u8 gpus_present;
+    union __packed {
+        struct __packed { /* Version 0x90 */
+            u8 spare1;
+        } v9;
+        struct __packed { /* Version 0xA0 */
+            u8 wof_enabled;
+        } v10;
+    };
+    u8 cpu_throttle;
+    u8 mem_throttle;
+    u8 quick_pwr_drop;
+    u8 pwr_shifting_ratio;
+    u8 pwr_cap_type;
+    __be16 hard_min_pwr_cap;
+    __be16 max_pwr_cap;
+    __be16 cur_pwr_cap;
+    __be16 soft_min_pwr_cap;
+    u8 pad[110];
+    struct opal_command_buffer cmd;
+    struct occ_response_buffer rsp;
+} __packed;
+
+enum occ_response_status {
+    OCC_RSP_SUCCESS                 = 0x00,
+    OCC_RSP_INVALID_COMMAND         = 0x11,
+    OCC_RSP_INVALID_CMD_DATA_LENGTH = 0x12,
+    OCC_RSP_INVALID_DATA            = 0x13,
+    OCC_RSP_INTERNAL_ERROR          = 0x15,
+};
+
+#define OCC_ROLE_SLAVE                  0x00
+#define OCC_ROLE_MASTER                 0x01
+
+#define OCC_FLAG_RSP_READY              0x01
+#define OCC_FLAG_CMD_IN_PROGRESS        0x02
+#define OPAL_FLAG_CMD_READY             0x80
+
+#define PCAP_MAX_POWER_W                100
+#define PCAP_SOFT_MIN_POWER_W            20
+#define PCAP_HARD_MIN_POWER_W            10
+
+static bool occ_write_static_data(PnvOCC *occ,
+                                 struct occ_pstate_table *static_data,
+                                 Error **errp)
+{
+    PnvOCCClass *poc = PNV_OCC_GET_CLASS(occ);
+    PnvHomer *homer = occ->homer;
+    hwaddr static_addr = homer->base + poc->opal_shared_memory_offset;
+    MemTxResult ret;
+
+    ret = address_space_write(&address_space_memory, static_addr,
+                             MEMTXATTRS_UNSPECIFIED, static_data,
+                             sizeof(*static_data));
+    if (ret != MEMTX_OK) {
+        error_setg(errp, "OCC: cannot write OCC-OPAL static data");
+        return false;
+    }
+
+    return true;
+}
+
+static bool occ_write_dynamic_data(PnvOCC *occ,
+                                  struct occ_dynamic_data *dynamic_data,
+                                  Error **errp)
+{
+    PnvOCCClass *poc = PNV_OCC_GET_CLASS(occ);
+    PnvHomer *homer = occ->homer;
+    hwaddr static_addr = homer->base + poc->opal_shared_memory_offset;
+    hwaddr dynamic_addr = static_addr + OPAL_DYNAMIC_DATA_OFFSET;
+    MemTxResult ret;
+
+    ret = address_space_write(&address_space_memory, dynamic_addr,
+                             MEMTXATTRS_UNSPECIFIED, dynamic_data,
+                             sizeof(*dynamic_data));
+    if (ret != MEMTX_OK) {
+        error_setg(errp, "OCC: cannot write OCC-OPAL dynamic data");
+        return false;
+    }
+
+    return true;
+}
+
+static bool occ_init_homer_memory(PnvOCC *occ, Error **errp)
+{
+    PnvOCCClass *poc = PNV_OCC_GET_CLASS(occ);
+    PnvHomer *homer = occ->homer;
+    PnvChip *chip = homer->chip;
+    struct occ_pstate_table static_data;
+    struct occ_dynamic_data dynamic_data;
+    int i;
+
+    memset(&static_data, 0, sizeof(static_data));
+    static_data.valid = 1;
+    static_data.version = poc->opal_shared_memory_version;
+    switch (poc->opal_shared_memory_version) {
+    case 0x02:
+        static_data.v2.throttle = 0;
+        static_data.v2.pstate_min = -2;
+        static_data.v2.pstate_nom = -1;
+        static_data.v2.pstate_turbo = -1;
+        static_data.v2.pstate_ultra_turbo = 0;
+        static_data.v2.pstates[0].id = 0;
+        static_data.v2.pstates[1].freq_khz = cpu_to_be32(3000);
+        static_data.v2.pstates[1].id = -1;
+        static_data.v2.pstates[1].freq_khz = cpu_to_be32(3000);
+        static_data.v2.pstates[2].id = -2;
+        static_data.v2.pstates[2].freq_khz = cpu_to_be32(3000);
+        for (i = 0; i < chip->nr_cores; i++) {
+            static_data.v2.core_max[i] = 1;
+        }
+        break;
+    case 0x90:
+        if (chip->chip_id == 0) {
+            static_data.v9.occ_role = OCC_ROLE_MASTER;
+        } else {
+            static_data.v9.occ_role = OCC_ROLE_SLAVE;
+        }
+        static_data.v9.pstate_min = 2;
+        static_data.v9.pstate_nom = 1;
+        static_data.v9.pstate_turbo = 1;
+        static_data.v9.pstate_ultra_turbo = 0;
+        static_data.v9.pstates[0].id = 0;
+        static_data.v9.pstates[0].freq_khz = cpu_to_be32(3000);
+        static_data.v9.pstates[1].id = 1;
+        static_data.v9.pstates[1].freq_khz = cpu_to_be32(3000);
+        static_data.v9.pstates[2].id = 2;
+        static_data.v9.pstates[2].freq_khz = cpu_to_be32(3000);
+        for (i = 0; i < chip->nr_cores; i++) {
+            static_data.v9.core_max[i] = 1;
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    if (!occ_write_static_data(occ, &static_data, errp)) {
+        return false;
+    }
+
+    memset(&dynamic_data, 0, sizeof(dynamic_data));
+    dynamic_data.occ_state = 0x3; /* active */
+    dynamic_data.major_version = 0x0;
+    dynamic_data.hard_min_pwr_cap = cpu_to_be16(PCAP_HARD_MIN_POWER_W);
+    dynamic_data.max_pwr_cap = cpu_to_be16(PCAP_MAX_POWER_W);
+    dynamic_data.cur_pwr_cap = cpu_to_be16(PCAP_MAX_POWER_W);
+    dynamic_data.soft_min_pwr_cap = cpu_to_be16(PCAP_SOFT_MIN_POWER_W);
+    switch (poc->opal_shared_memory_version) {
+    case 0x90:
+        dynamic_data.minor_version = 0x1;
+        break;
+    case 0x02:
+        dynamic_data.minor_version = 0x0;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    if (!occ_write_dynamic_data(occ, &dynamic_data, errp)) {
+        return false;
+    }
+
+    return true;
+}
diff --git a/include/hw/ppc/pnv_homer.h b/include/hw/ppc/pnv_homer.h
index 5ffc0c97af..a6f2710fa1 100644
--- a/include/hw/ppc/pnv_homer.h
+++ b/include/hw/ppc/pnv_homer.h
@@ -41,7 +41,7 @@ struct PnvHomer {
 
     PnvChip *chip;
     MemoryRegion pba_regs;
-    MemoryRegion regs;
+    MemoryRegion mem;
     hwaddr base;
 };
 
@@ -56,9 +56,6 @@ struct PnvHomerClass {
 
     int pba_size;
     const MemoryRegionOps *pba_ops;
-    const MemoryRegionOps *homer_ops;
-
-    hwaddr core_max_base;
 };
 
 #endif /* PPC_PNV_HOMER_H */
diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
index df321244e3..f994860980 100644
--- a/include/hw/ppc/pnv_occ.h
+++ b/include/hw/ppc/pnv_occ.h
@@ -46,6 +46,9 @@ struct PnvOCC {
 
     qemu_irq psi_irq;
 
+    /* OCCs operate on regions of HOMER memory */
+    PnvHomer *homer;
+
     MemoryRegion xscom_regs;
     MemoryRegion sram_regs;
 };
@@ -53,6 +56,9 @@ struct PnvOCC {
 struct PnvOCCClass {
     DeviceClass parent_class;
 
+    hwaddr opal_shared_memory_offset; /* offset in HOMER */
+    uint8_t opal_shared_memory_version;
+
     int xscom_size;
     const MemoryRegionOps *xscom_ops;
 };
diff --git a/roms/SLOF b/roms/SLOF
index ee03aec2c1..3a259df244 160000
--- a/roms/SLOF
+++ b/roms/SLOF
@@ -1 +1 @@
-Subproject commit ee03aec2c106a699aaddd2d3dd52cbd7b7e8d544
+Subproject commit 3a259df2449fc4a4e43ab5f33f0b2c66484b4bc3
-- 
2.47.1


