Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EF4C982DD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 10:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7VZp-0003Mc-Qe; Fri, 18 Sep 2026 06:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1x7VZe-0003HO-TB
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 06:12:07 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1x7VZc-0007ZP-0Y
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 06:12:06 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ccead2aecso2850285e9.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 03:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789726323; x=1790331123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BrTqYp3xTMdiXx5R810D5D1IIgmHDRzEewMRTo5le1s=;
 b=Gfa/xYR8PKmYwkQ+unN/KPWaWA8Unq2LNlvyHWqDgQWULCeaclG51OjyCiGBiC9vUC
 znvoS2WobRdNSrlrjDiB0ha52keFnIm9eKVR5V53ddcLWrcBTrSITXt9Ka46UWpU0W9t
 4BU0w+gFoJHJvJzCTMR4VhwoHu8jgib2EFTiXRoTqGqf5wQL8KnvDJDBbcdq82RmfQmk
 aK82La19ZecFarFGKpy+RdKgci8qJmY8p8vG2I1L0GRORTFBlYnmtUN8B4cIjBrGkSEa
 Z1mEgMrPnTH+jaag7rK5xrHXKBioXuUiju38E734+6XTJ29AttWYXmjMLyXCapXJwAJQ
 FQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789726323; x=1790331123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BrTqYp3xTMdiXx5R810D5D1IIgmHDRzEewMRTo5le1s=;
 b=CDvV4JcQpxyT3neJxv0e0Dfp4Km2jy20avsSBdYrrSvR4tr+vSh+NbrDZAqF+Q6i4w
 XtFa4kcDTvK7RbeQ1g1ehKzCMa6qYqVn66w/fcmKSP/FnytT+InJrXsre7Vcs2UQ5VXJ
 P/7ssikBVs8p7EBwpWY1kWkMxF8BpAYAxABFFWHw+4eYatWKEGgUVuYA+4QUGlZDF/wo
 byx/O3n7HsaEJw+CAD4D+jvXbFi+5uCyX5dzhWanI0LFbKkD2S5XaRK/jOYJq22M7fL3
 1S2N04v/coBGaIUQqjkgvaEtb17YJyD7/218SOGXGEMPlp4M+196/ZDHo4ycbA18UYdO
 S5MQ==
X-Gm-Message-State: AFuF++kRHvTyQkpQ1DaCGXsjsoD6YEVkhhwEbeeSiey9S1ez8P/56EMk
 NYR0smU/nKYlZw1Bn2Ub6EQAMyqRROHJYjjRLDoYlIiC8dFknNGuvLzrPD3cFrb7
X-Gm-Gg: AYBFou34QhDiF6brr4+Vi8DYfM/11SYUUVj/ZXNNxeTpa3woeTS+KMX8SOS9TtlBPKH
 5W/eSFNSYN9NInuInfevhGBIcNr5jtaCt0l6CT0YUdIUXYNt0OOKJDTSVnuxOGN5amJc6RVEzJt
 tSOk170lTNabjFsSSeWlMbNZyG75HXAQ79+I9m1TxOQXT6DZ4UMvA8V+ooLPV1vAaDA2CQhriSR
 rxha33lPHDFPyCAe3a9IBysVqlfiedwnBubZUWodOzhp0Gh7yqkAURRZ07yd6cRxiLqESsn6y0f
 FFUu5NVok8HrJe/Ycb1cbtmOOcXcHA4jERAkRRKvKR9TkZzh91g6eJKyxfZl+y3g/O0aabGMYYN
 cZl4UNmZgOrLl3/Ov6BqTtmQKylIJnTh+qXP2eI6Ec7ZyKq2GRoVgmHj0eTEhUgNGWpwvvuYERw
 qAfOpo3WP98CoBN4FjYoQQXiKLNPNcIRC7n1n54XSqPHBeecCaiG6v10HKnG/7aGsxTwHQfTt0g
 AcwVJVSJQ4/+DH60ptF2g==
X-Received: by 2002:a05:600c:4505:b0:49a:a101:4157 with SMTP id
 5b1f17b1804b1-49fc56db92fmr24771595e9.7.1789726322609; 
 Fri, 18 Sep 2026 03:12:02 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com
 ([2001:9e8:dc20:5e84:de9d:56c6:df83:7819])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd225898sm153886245e9.9.2026.09.18.03.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 03:12:02 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Corvin Koehne <C.Koehne@beckhoff.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Yannick Vossen <Y.Vossen@beckhoff.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v8 2/7] hw/arm/xilinx_zynq: Add flash type as machine class
 property
Date: Fri, 18 Sep 2026 12:11:53 +0200
Message-ID: <20260918101158.42101-3-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918101158.42101-1-corvin.koehne@gmail.com>
References: <20260918101158.42101-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm2-x10.google.com
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

From: YannickV <Y.Vossen@beckhoff.com>

Introduce ZynqMachineClass with qspi_flash_type field to allow
different Zynq-based machines to specify their flash device
type. The base Zynq machine defaults to n25q128.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
---
 hw/arm/xilinx_zynq.c         | 19 ++++++++++++++-----
 include/hw/arm/xilinx_zynq.h |  8 +++++++-
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index c1897ab1cf33..31d5b5e5caa5 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -117,7 +117,8 @@ static void gem_init(uint32_t base, qemu_irq irq)
 }
 
 static inline int zynq_init_spi_flashes(uint32_t base_addr, qemu_irq irq,
-                                        bool is_qspi, int unit0)
+                                        bool is_qspi, int unit0,
+                                        const char *flash_type)
 {
     int unit = unit0;
     DeviceState *dev;
@@ -149,7 +150,8 @@ static inline int zynq_init_spi_flashes(uint32_t base_addr, qemu_irq irq,
 
         for (j = 0; j < num_ss; ++j) {
             DriveInfo *dinfo = drive_get(IF_MTD, 0, unit++);
-            flash_dev = qdev_new("n25q128");
+
+            flash_dev = qdev_new(flash_type);
             if (dinfo) {
                 qdev_prop_set_drive_err(flash_dev, "drive",
                                         blk_by_legacy_dinfo(dinfo),
@@ -201,6 +203,7 @@ static void ddr_ctrl_init(uint32_t base)
 static void zynq_init(MachineState *machine)
 {
     ZynqMachineState *zynq_machine = ZYNQ_MACHINE(machine);
+    ZynqMachineClass *zmc = ZYNQ_MACHINE_GET_CLASS(machine);
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *ocm_ram = g_new(MemoryRegion, 1);
     DeviceState *dev, *slcr;
@@ -280,9 +283,12 @@ static void zynq_init(MachineState *machine)
         pic[n] = qdev_get_gpio_in(dev, n);
     }
 
-    n = zynq_init_spi_flashes(0xE0006000, pic[58 - GIC_INTERNAL], false, 0);
-    n = zynq_init_spi_flashes(0xE0007000, pic[81 - GIC_INTERNAL], false, n);
-    n = zynq_init_spi_flashes(0xE000D000, pic[51 - GIC_INTERNAL], true, n);
+    n = zynq_init_spi_flashes(0xE0006000, pic[58 - GIC_INTERNAL], false, 0,
+                              zmc->qspi_flash_type);
+    n = zynq_init_spi_flashes(0xE0007000, pic[81 - GIC_INTERNAL], false, n,
+                              zmc->qspi_flash_type);
+    n = zynq_init_spi_flashes(0xE000D000, pic[51 - GIC_INTERNAL], true, n,
+                              zmc->qspi_flash_type);
 
     sysbus_create_simple(TYPE_CHIPIDEA, 0xE0002000, pic[53 - GIC_INTERNAL]);
     sysbus_create_simple(TYPE_CHIPIDEA, 0xE0003000, pic[76 - GIC_INTERNAL]);
@@ -458,6 +464,7 @@ static void zynq_machine_class_init(ObjectClass *oc, const void *data)
         NULL
     };
     MachineClass *mc = MACHINE_CLASS(oc);
+    ZynqMachineClass *zmc = ZYNQ_MACHINE_CLASS(oc);
     ObjectProperty *prop;
     mc->desc = "Xilinx Zynq 7000 Platform Baseboard for Cortex-A9";
     mc->init = zynq_init;
@@ -471,11 +478,13 @@ static void zynq_machine_class_init(ObjectClass *oc, const void *data)
                                           "Supported boot modes:"
                                           " jtag qspi sd nor");
     object_property_set_default_str(prop, "qspi");
+    zmc->qspi_flash_type = "n25q128";
 }
 
 static const TypeInfo zynq_machine_type = {
     .name = TYPE_ZYNQ_MACHINE,
     .parent = TYPE_MACHINE,
+    .class_size = sizeof(ZynqMachineClass),
     .class_init = zynq_machine_class_init,
     .instance_size = sizeof(ZynqMachineState),
 };
diff --git a/include/hw/arm/xilinx_zynq.h b/include/hw/arm/xilinx_zynq.h
index 669c516ad150..33a68cdcd15e 100644
--- a/include/hw/arm/xilinx_zynq.h
+++ b/include/hw/arm/xilinx_zynq.h
@@ -12,12 +12,13 @@
 #ifndef QEMU_ARM_ZYNQ_H
 #define QEMU_ARM_ZYNQ_H
 
+#include "hw/core/boards.h"
 #include "target/arm/cpu-qom.h"
 #include "hw/core/qdev-clock.h"
 #include "hw/arm/boot.h"
 
 #define TYPE_ZYNQ_MACHINE MACHINE_TYPE_NAME("xilinx-zynq-a9")
-OBJECT_DECLARE_SIMPLE_TYPE(ZynqMachineState, ZYNQ_MACHINE)
+OBJECT_DECLARE_TYPE(ZynqMachineState, ZynqMachineClass, ZYNQ_MACHINE)
 
 #define ZYNQ_MAX_CPUS 2
 
@@ -29,4 +30,9 @@ struct ZynqMachineState {
     struct arm_boot_info bootinfo;
 };
 
+struct ZynqMachineClass {
+    MachineClass parent_class;
+    const char *qspi_flash_type;
+};
+
 #endif /* QEMU_ARM_ZYNQ_H */
-- 
2.47.3


