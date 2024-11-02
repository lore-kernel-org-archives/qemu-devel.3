Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F04E677FC
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 13:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7E11-0003Gn-U4; Sat, 02 Nov 2024 09:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0f-000354-GR; Sat, 02 Nov 2024 09:17:46 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0d-0001xk-Hz; Sat, 02 Nov 2024 09:17:45 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5cec9609303so751470a12.1; 
 Sat, 02 Nov 2024 06:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730553461; x=1731158261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ru1Gt0W7wGFu8fqeS2mXdTbWG17w7ktdLroVRSgCGnU=;
 b=YijjUyD6ZsELGCJMt1yQehVZcndbnfp75TAh3K9sZGUj3lv3yJuKpmbrD3u+nHc5jt
 iXEpwFXH28nYo4O8rWRoXqHsY0MpUZcNp8IDfUh2zWzOaE6Z0uDZmH55ALYR2gjiO/+7
 qPNVnstW6Ic90+yOzgesK2Ktm8GTY7PDLelv5QQkkIr5eEaWYbidsPhY8R8VNGEYRVkv
 w034p8gGRE53zVtu+/DdI/tPfUVQ2LoYVj7132s+AcnpRwzk1gIHFdPArKMC+lxxOAbA
 konsPztF1RaWKBvG6NS/uAIz6cUe3jS5jyMu/CR55ejM4ZgwTK9l3ORPOC46b6If/N6T
 ApdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730553461; x=1731158261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ru1Gt0W7wGFu8fqeS2mXdTbWG17w7ktdLroVRSgCGnU=;
 b=JANmCsNQ+VKtrpK9RSufXfSPga+DiPF6Jxob+cX+0yDe6JftQVgyz0Vjr05WejCvp/
 gqv12mWc1+9R4ChZsBikaUt8ojpGhk1/b6Rh33ylNTHy33LNE/zezB4vdTQllk38Sk5y
 mL1316BcUisSmg9vKODRnw9zhVWNKk0KiFf00u+yhsBI7GF7tNeCpZlYb0nbJMRLrYR5
 4CP/D4V/zxOEwvu7j3D+sR129FoiIdRvcPjfxpPVr8ynX2LDunem9vqXJHdM4ODPczhG
 iCnpv577OwFhR9X1KHtkspYMxG12JJroO2XUwUw/mMdJvXCpaWf0kQsLR2eqc6PVsvb2
 E2Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwQsV4+cop7HCT0vGZBlKSs9Xgqd8MGstTwe6bU7WhivjkPxwohac6orZwPBw4r0ZL4m6GToKY2RM=@nongnu.org,
 AJvYcCVDnVMD1NTNEO+seF0jKkcKANLIqdEkV9gP3VD6AYgMupiMuGjKwtv+v9CjKt7VmcSXaW6SxZGZK7T7@nongnu.org
X-Gm-Message-State: AOJu0Yzn8/rMwcbvEzJNORqKLZo6roHF3RfoMq3NdE3VYjBLs03+IT5E
 kUYQ4gyQ+CgH4FQy8RWld4WZiWgVrdaLT9Wrob287LGtPUusyHTo6fjoPQ==
X-Google-Smtp-Source: AGHT+IG/Yc5YMoTWuqYnqJ4RBrYXSASOjn6r/l8bn9uUnFX+MCf7ccB+cZc3IhwEIa5/12c9mZ5a1g==
X-Received: by 2002:a17:907:940e:b0:a9a:b70:2a92 with SMTP id
 a640c23a62f3a-a9de5ecc46bmr2647576466b.16.1730553460457; 
 Sat, 02 Nov 2024 06:17:40 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm307859066b.159.2024.11.02.06.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 06:17:39 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v3 08/26] hw/ppc/e500: Extract ppce500_ccsr.c
Date: Sat,  2 Nov 2024 14:16:57 +0100
Message-ID: <20241102131715.548849-9-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102131715.548849-1-shentey@gmail.com>
References: <20241102131715.548849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x529.google.com
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

The device model already has a header file, so extract its implementation into
an accompanying source file like other e500 devices. While at it rename the
header file to reflect the name of the structure defined there.

This commit is also a preparation for the next commit.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 MAINTAINERS                            |  2 +-
 hw/ppc/{e500-ccsr.h => ppce500_ccsr.h} |  8 +++---
 hw/ppc/e500.c                          | 21 ++--------------
 hw/ppc/ppce500_ccsr.c                  | 34 ++++++++++++++++++++++++++
 hw/ppc/meson.build                     |  1 +
 5 files changed, 42 insertions(+), 24 deletions(-)
 rename hw/ppc/{e500-ccsr.h => ppce500_ccsr.h} (71%)
 create mode 100644 hw/ppc/ppce500_ccsr.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e88b5738c..a8f39aeb6f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1391,7 +1391,7 @@ M: Bernhard Beschow <shentey@gmail.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/ppc/e500*
-F: hw/ppc/ppce500_spin.c
+F: hw/ppc/ppce500_*
 F: hw/gpio/mpc8xxx.c
 F: hw/i2c/mpc_i2c.c
 F: hw/net/fsl_etsec/
diff --git a/hw/ppc/e500-ccsr.h b/hw/ppc/ppce500_ccsr.h
similarity index 71%
rename from hw/ppc/e500-ccsr.h
rename to hw/ppc/ppce500_ccsr.h
index 249c17be3b..36cbb811ca 100644
--- a/hw/ppc/e500-ccsr.h
+++ b/hw/ppc/ppce500_ccsr.h
@@ -1,13 +1,13 @@
-#ifndef E500_CCSR_H
-#define E500_CCSR_H
+#ifndef PPCE500_CCSR_H
+#define PPCE500_CCSR_H
 
 #include "hw/sysbus.h"
 #include "qom/object.h"
 
+#define MPC85XX_CCSRBAR_SIZE       0x00100000ULL
+
 struct PPCE500CCSRState {
-    /*< private >*/
     SysBusDevice parent;
-    /*< public >*/
 
     MemoryRegion ccsr_space;
 };
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 2849fba524..f640195e62 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -20,7 +20,7 @@
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
 #include "e500.h"
-#include "e500-ccsr.h"
+#include "ppce500_ccsr.h"
 #include "net/net.h"
 #include "qemu/config-file.h"
 #include "hw/block/flash.h"
@@ -59,7 +59,6 @@
 #define RAM_SIZES_ALIGN            (64 * MiB)
 
 /* TODO: parameterize */
-#define MPC8544_CCSRBAR_SIZE       0x00100000ULL
 #define MPC8544_MPIC_REGS_OFFSET   0x40000ULL
 #define MPC8544_MSI_REGS_OFFSET   0x41600ULL
 #define MPC8544_SERIAL0_REGS_OFFSET 0x4500ULL
@@ -530,7 +529,7 @@ static int ppce500_load_device_tree(PPCE500MachineState *pms,
     qemu_fdt_setprop_cell(fdt, soc, "#size-cells", 1);
     qemu_fdt_setprop_cells(fdt, soc, "ranges", 0x0,
                            pmc->ccsrbar_base >> 32, pmc->ccsrbar_base,
-                           MPC8544_CCSRBAR_SIZE);
+                           MPC85XX_CCSRBAR_SIZE);
     /* XXX should contain a reasonable value */
     qemu_fdt_setprop_cell(fdt, soc, "bus-frequency", 0);
 
@@ -1256,21 +1255,6 @@ void ppce500_init(MachineState *machine)
     pms->boot_info.dt_size = dt_size;
 }
 
-static void e500_ccsr_initfn(Object *obj)
-{
-    PPCE500CCSRState *ccsr = CCSR(obj);
-    memory_region_init(&ccsr->ccsr_space, obj, "e500-ccsr",
-                       MPC8544_CCSRBAR_SIZE);
-    sysbus_init_mmio(SYS_BUS_DEVICE(ccsr), &ccsr->ccsr_space);
-}
-
-static const TypeInfo e500_ccsr_info = {
-    .name          = TYPE_CCSR,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(PPCE500CCSRState),
-    .instance_init = e500_ccsr_initfn,
-};
-
 static const TypeInfo ppce500_info = {
     .name          = TYPE_PPCE500_MACHINE,
     .parent        = TYPE_MACHINE,
@@ -1281,7 +1265,6 @@ static const TypeInfo ppce500_info = {
 
 static void e500_register_types(void)
 {
-    type_register_static(&e500_ccsr_info);
     type_register_static(&ppce500_info);
 }
 
diff --git a/hw/ppc/ppce500_ccsr.c b/hw/ppc/ppce500_ccsr.c
new file mode 100644
index 0000000000..5d0e1e0e89
--- /dev/null
+++ b/hw/ppc/ppce500_ccsr.c
@@ -0,0 +1,34 @@
+/*
+ * QEMU PowerPC E500 embedded processors CCSR space emulation
+ *
+ * Copyright (C) 2009 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * Author: Yu Liu,     <yu.liu@freescale.com>
+ *
+ * This is free software; you can redistribute it and/or modify
+ * it under the terms of  the GNU General  Public License as published by
+ * the Free Software Foundation;  either version 2 of the  License, or
+ * (at your option) any later version.
+ */
+
+#include "qemu/osdep.h"
+#include "ppce500_ccsr.h"
+
+static void ppce500_ccsr_init(Object *obj)
+{
+    PPCE500CCSRState *s = CCSR(obj);
+
+    memory_region_init(&s->ccsr_space, obj, "e500-ccsr", MPC85XX_CCSRBAR_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->ccsr_space);
+}
+
+static const TypeInfo types[] = {
+    {
+        .name          = TYPE_CCSR,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(PPCE500CCSRState),
+        .instance_init = ppce500_ccsr_init,
+    },
+};
+
+DEFINE_TYPES(types)
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 7cd9189869..43c746795a 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -81,6 +81,7 @@ ppc_ss.add(when: 'CONFIG_MPC8544DS', if_true: files('mpc8544ds.c'))
 ppc_ss.add(when: 'CONFIG_E500', if_true: files(
   'e500.c',
   'mpc8544_guts.c',
+  'ppce500_ccsr.c',
   'ppce500_spin.c'
 ))
 # PowerPC 440 Xilinx ML507 reference board.
-- 
2.47.0


