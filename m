Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735EECFB42C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAkA-0005N6-Ns; Sat, 05 Oct 2024 15:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAk7-0005Lm-Bo; Sat, 05 Oct 2024 15:47:07 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAk5-0007ed-IY; Sat, 05 Oct 2024 15:47:07 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cc43454d5so24094545e9.3; 
 Sat, 05 Oct 2024 12:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728157623; x=1728762423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QNoaLfp9Rephm7oujz2od43Jyyd4r2WL4l9Tyqyvzdc=;
 b=f6fYmIvWwUg/UlLzrl6/uiFNF6CklrzOS4N551y6z2ya1nJmL6g9fpimYblJnUcIog
 AjnoovKGla3vCbX8cqLDL7Wvxgcl9+vf4pIUxAiwkALfvZzY9KmgI8y6PmlCpJePXZ1M
 73Gd89/kzbsYCVGunjrbx1hsOGNRNSrDExqubGj1vvAX5A5e2iU1xynxteUCalsn8NyC
 MZdr4ztGoApscxwGMm5Cf6l7oeyUgnpUc2VOT4e2y6kctcz75xWpOw59eJvGLtyKyHmn
 NEj3a5fVK+iNDCm0RhknQuIS8u9BE4hB2BElHsZQngb5FLTusmEhtj9o4Vdfn2Ce4vn1
 uRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728157623; x=1728762423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QNoaLfp9Rephm7oujz2od43Jyyd4r2WL4l9Tyqyvzdc=;
 b=jN+VdpqZPXT77/u+IcUTowmlndvFRxlQCj5en5KF8acHSqTaXmmHzE2lPrh5dPOOz3
 1ndeavb8NmU0l6C4nmZlbmjhLKeHehmrhmg21naD/AvCPcpB6V6uBJIX5x9AazEeWV9y
 MpeDdbxAiUJHakFxzFaCGSuTQaNnGlGG/4fLIDh4tnwr6IqkmYUgqKH5UO+RxujRntcd
 s+iC9FjOdw1vZ/oQOQgEpZEq9xvFHIQwsaoFkxFLcZfHIZ86ssevy823tfqw8C9AQ84H
 9vUsYitUAoQBJBHvbsbKqpS8mL0mmkATLsEg+6JIJ43rMS0iAhdyydR+qSRzi9On+u/x
 NtaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDVGT5aUSUoKPjXYkpsm/+WFkBmgxy7rNA/DeFJ3TcBe4VuzribzBWNal1R/MSv7RbxB65M0kQtS7z@nongnu.org,
 AJvYcCWmzXNGjMoYVUPnC5XmhBxzoIZwkfFukPfqQ+e5LrYk/y43J826r0l0EA6hjLQJmdBInm4zyjYh7No=@nongnu.org
X-Gm-Message-State: AOJu0Ywk8jC/DK98gedA2PNzwCj12HbFj9tEcMQYsAbQBcBEjVQwOfca
 fxWKNIxFz7Ne4rQ0oGUpar8bzSnSRuZY25qJ21BECJTa5d3U/hXq2ynOiw==
X-Google-Smtp-Source: AGHT+IFIstMrZf0lEY79h+aqA4ZH7TB7Oy7zwsEXKJoiJmIih8w6Gr3DWF8WGrmSayee6vzK0PPBWA==
X-Received: by 2002:a05:600c:1907:b0:426:6326:4cec with SMTP id
 5b1f17b1804b1-42f85af412bmr45597975e9.29.1728157622738; 
 Sat, 05 Oct 2024 12:47:02 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a0afc1sm47506775e9.1.2024.10.05.12.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 12:47:02 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Corey Minyard <cminyard@mvista.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 07/23] hw/ppc/e500: Extract ppce500_ccsr.c
Date: Sat,  5 Oct 2024 21:45:47 +0200
Message-ID: <20241005194603.23139-8-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005194603.23139-1-shentey@gmail.com>
References: <20241005194603.23139-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32c.google.com
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
index 34fffcb5be..f1755c8ad8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1382,7 +1382,7 @@ M: Bernhard Beschow <shentey@gmail.com>
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
index 2225533e33..74836ebb64 100644
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
@@ -61,7 +61,6 @@
 #define RAM_SIZES_ALIGN            (64 * MiB)
 
 /* TODO: parameterize */
-#define MPC8544_CCSRBAR_SIZE       0x00100000ULL
 #define MPC8544_MPIC_REGS_OFFSET   0x40000ULL
 #define MPC8544_MSI_REGS_OFFSET   0x41600ULL
 #define MPC8544_SERIAL0_REGS_OFFSET 0x4500ULL
@@ -532,7 +531,7 @@ static int ppce500_load_device_tree(PPCE500MachineState *pms,
     qemu_fdt_setprop_cell(fdt, soc, "#size-cells", 1);
     qemu_fdt_setprop_cells(fdt, soc, "ranges", 0x0,
                            pmc->ccsrbar_base >> 32, pmc->ccsrbar_base,
-                           MPC8544_CCSRBAR_SIZE);
+                           MPC85XX_CCSRBAR_SIZE);
     /* XXX should contain a reasonable value */
     qemu_fdt_setprop_cell(fdt, soc, "bus-frequency", 0);
 
@@ -1264,21 +1263,6 @@ void ppce500_init(MachineState *machine)
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
@@ -1289,7 +1273,6 @@ static const TypeInfo ppce500_info = {
 
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
2.46.2


