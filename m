Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83452CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Pv-0005dW-RD; Tue, 07 Oct 2025 10:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Ps-0005bm-A8
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:11:48 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Ph-00026c-KR
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:11:47 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e430494ccso36940285e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846289; x=1760451089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HcGA0MU3t/BPjbWYACikPE9NikWXY3MIgX4mWa0jOjU=;
 b=rE1K/ZlrixAP1UCaVCGlYTayLqe+Jgy3Zc60muNTTY0nlG3G/WipyRcT/uJufFdZ5w
 w3HTTjJO5W0dE+zpOSWyjD1j91qfESLU3MdK4sNpc1YvVrpx3N52QROVgeoqgrdzJ46U
 lmgLhxZKBgcKdKiONQtoOMWnm82V8s681AlrQOgh02TQhfkqlLKXnhSG0h+z7NfTMy6q
 gtw6WJ9Twv8NmsXQPG3tIkKnn18FIuxGoZ22CmmwioIMoMhm+lyOg5GuuojLROj++NmP
 t0cYfPAFwThdHt3/vEnjEUbYH06BRCytXQksXFmUfT2Kp+m3RaEQcvNjYcA6f9zWGgeG
 dIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846289; x=1760451089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HcGA0MU3t/BPjbWYACikPE9NikWXY3MIgX4mWa0jOjU=;
 b=IKizsQznkCHUuDTTwmoLQVKOyYMYymHod7hkYo4r/8FgmIRgsTLTnBLr3c7V7Bq64w
 9Elmvpktss3+tFPeQVWmpL+/mh+K/3DJc5mdW7lM5jlozU4HcXST0WMCALWor/BP7Mzy
 FpqAJcHBcdURElIMKvrJ0Ab0sOl8dFP3tiyeLQQ1MOtI7u/XqgXE5aJAI5iy0IuvnqP7
 /CxHS8Mv/5jcfUMVJoAnOzAOl6orsMf16T1lqPNActERjm2BqAZOePrfcndnlTPS6T9C
 yQtK15yreXqEmfh75Zys3P0o50QJYz8kaHyNtYtr2qacFL0xWL4Fl/KI3w4dwRTfV+SW
 MpcA==
X-Gm-Message-State: AOJu0YxPnp4LDs9fm99PfI9GXcvHkt/jzpeXWRaMFerddUpSlqfkOyOh
 lKvkkne33njRBhydRvpjPOjQPdgZZoyC7GefYjRkGKEetlkvO/jU179XyBTQBZVU+jZwiGqnNbZ
 +MHXI
X-Gm-Gg: ASbGnct+r+76Kqum3ZevnK1pew5pplyUOmlNeTN/6iF4ajmE1W9+lSgQ0THeP0ka8ql
 DpYtnImwA/dQFwAMN4dLGClyZI6YjzqhF+bat12fkRZ9o0DStLpp7OYmQluFtnUGIkj2IYis+19
 cke0YGK88z1gwgdWj+ybvJAsqv9eAdqWjrhYQvZzNoCE22/LBbK/SGBbvSVhOEsoZawq45WmkjC
 l6JaP9DOy+XELGpELXhx+u5z/GuI+zAQ1gzNd1LV1JXPyberFkhzkT9qfijE8pB3/k/0GdlfTiP
 UKPOrmkX6svMfnUzRnPDhcjnVwr8+HWgp4LpR0bVmOX9es4jOryjet2PrUsco5nxNJTsR2UsDrg
 nxdWwceJHSEoyJJ+nmQtVNO17XDBf7CB+5JelS8hwu97vCDosK3Vf7IO6
X-Google-Smtp-Source: AGHT+IFLHBFrkNSjpZGUmf15qMcuDMoo2a2r1frt9u/E8XXdLpTgftuRowTqovkWOjtR7b+D9wlyow==
X-Received: by 2002:a05:600c:8b83:b0:45b:8adf:cf2b with SMTP id
 5b1f17b1804b1-46e71142e6fmr105903785e9.21.1759846288921; 
 Tue, 07 Oct 2025 07:11:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.11.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:11:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/62] hw/arm/xlnx-versal: prepare for FDT creation
Date: Tue,  7 Oct 2025 15:10:23 +0100
Message-ID: <20251007141123.3239867-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Luc Michel <luc.michel@amd.com>

The following commits will move FDT creation logic from the
xlnx-versal-virt machine to the xlnx-versal SoC itself. Prepare this by
passing the FDT handle to the SoC before it is realized.

For now the SoC only creates the two clock nodes. The ones from the
xlnx-versal virt machine are renamed with a `old-' prefix and will be
removed once they are not referenced anymore.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-3-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h | 12 ++++++++++++
 hw/arm/xlnx-versal-virt.c    |  9 ++++++---
 hw/arm/xlnx-versal.c         | 24 ++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 1f92e314d6c..f2a62b43552 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -136,8 +136,14 @@ struct Versal {
         OrIRQState apb_irq_orgate;
     } pmc;
 
+    struct {
+        uint32_t clk_25mhz;
+        uint32_t clk_125mhz;
+    } phandle;
+
     struct {
         MemoryRegion *mr_ddr;
+        void *fdt;
     } cfg;
 };
 
@@ -147,6 +153,12 @@ struct VersalClass {
     VersalVersion version;
 };
 
+static inline void versal_set_fdt(Versal *s, void *fdt)
+{
+    g_assert(!qdev_is_realized(DEVICE(s)));
+    s->cfg.fdt = fdt;
+}
+
 /* Memory-map and IRQ definitions. Copied a subset from
  * auto-generated files.  */
 
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index adadbb72902..d1c65afa2ac 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -2,6 +2,7 @@
  * Xilinx Versal Virtual board.
  *
  * Copyright (c) 2018 Xilinx Inc.
+ * Copyright (c) 2025 Advanced Micro Devices, Inc.
  * Written by Edgar E. Iglesias
  *
  * This program is free software; you can redistribute it and/or modify
@@ -697,10 +698,12 @@ static void versal_virt_init(MachineState *machine)
                              &error_abort);
     object_property_set_link(OBJECT(&s->soc), "canbus1", OBJECT(s->canbus[1]),
                              &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     fdt_create(s);
+    versal_set_fdt(&s->soc, s->fdt);
+    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
     create_virtio_regions(s);
+
     fdt_add_gem_nodes(s);
     fdt_add_uart_nodes(s);
     fdt_add_canfd_nodes(s);
@@ -714,8 +717,8 @@ static void versal_virt_init(MachineState *machine)
     fdt_add_efuse_ctrl_node(s);
     fdt_add_efuse_cache_node(s);
     fdt_add_cpu_nodes(s, psci_conduit);
-    fdt_add_clk_node(s, "/clk125", 125000000, s->phandle.clk_125Mhz);
-    fdt_add_clk_node(s, "/clk25", 25000000, s->phandle.clk_25Mhz);
+    fdt_add_clk_node(s, "/old-clk125", 125000000, s->phandle.clk_125Mhz);
+    fdt_add_clk_node(s, "/old-clk25", 25000000, s->phandle.clk_25Mhz);
 
     /* Make the APU cpu address space visible to virtio and other
      * modules unaware of multiple address-spaces.  */
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 4da656318f6..3b596219561 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -24,6 +24,8 @@
 #include "qemu/log.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
+#include "system/device_tree.h"
+#include "hw/arm/fdt.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
@@ -919,11 +921,33 @@ static void versal_unimp(Versal *s)
                                 gpio_in);
 }
 
+static uint32_t fdt_add_clk_node(Versal *s, const char *name,
+                                 unsigned int freq_hz)
+{
+    uint32_t phandle;
+
+    phandle = qemu_fdt_alloc_phandle(s->cfg.fdt);
+
+    qemu_fdt_add_subnode(s->cfg.fdt, name);
+    qemu_fdt_setprop_cell(s->cfg.fdt, name, "phandle", phandle);
+    qemu_fdt_setprop_cell(s->cfg.fdt, name, "clock-frequency", freq_hz);
+    qemu_fdt_setprop_cell(s->cfg.fdt, name, "#clock-cells", 0x0);
+    qemu_fdt_setprop_string(s->cfg.fdt, name, "compatible", "fixed-clock");
+    qemu_fdt_setprop(s->cfg.fdt, name, "u-boot,dm-pre-reloc", NULL, 0);
+
+    return phandle;
+}
+
 static void versal_realize(DeviceState *dev, Error **errp)
 {
     Versal *s = XLNX_VERSAL_BASE(dev);
     qemu_irq pic[XLNX_VERSAL_NR_IRQS];
 
+    g_assert(s->cfg.fdt != NULL);
+
+    s->phandle.clk_25mhz = fdt_add_clk_node(s, "/clk25", 25 * 1000 * 1000);
+    s->phandle.clk_125mhz = fdt_add_clk_node(s, "/clk125", 125 * 1000 * 1000);
+
     versal_create_apu_cpus(s);
     versal_create_apu_gic(s, pic);
     versal_create_rpu_cpus(s);
-- 
2.43.0


