Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9797ED11040
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 13:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7al1-0006P2-VW; Sun, 03 Nov 2024 08:35:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7akr-0006BM-8D; Sun, 03 Nov 2024 08:34:58 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7ako-0001FT-Sv; Sun, 03 Nov 2024 08:34:56 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9a0c40849cso584842266b.3; 
 Sun, 03 Nov 2024 05:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730640892; x=1731245692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VEVYSxDFqm/X/a/RCULnQJR7m3PPQ/OfkGJfqpgzHf8=;
 b=FbGrc8VGNlZ8o9J8MbDS2OhXfOV8KGeeIK4Yq/MiXfgFp1jRLMxwkDVj/YhrVK5b1s
 qP5AzoHC1Y3yUIb3bBWdkhEZIn/qhyH+kRdcRHoIx8JIEa5KqMq/suNJTG+dcjGJaNFY
 wj22O/yZ5StXoc/U9TxK+v5I9Q9tPZEnQSeJldB9PltJAZT+rVgcnMPTVcASbYG8lObi
 4r32DTiGpK0n0UozW28/3u3GJ/5P463yJxdHp0pcH1OtBPYRM288S1/Xzjsr6Wy1Bkbd
 PwcOAiQc/GrC1Ufjah6GUjDUmbQPL7jwKjvSIoKZ7MAcXh/REGQt978Yrq3UFY0KjBb6
 9LBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730640892; x=1731245692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VEVYSxDFqm/X/a/RCULnQJR7m3PPQ/OfkGJfqpgzHf8=;
 b=KeAzLTfLDZxzBAyFCWAIBUO3cnYuL52vGtZYinyIP90vGK6taXl1Qw+BmkA+ydyhnO
 JkZ+sWFUm+HA0grHEYQbcvvd8MZYHVlODv5fpVRg7wwMIl9iN8TJpU3nyQBfhnkTNMC0
 cDYEZqHnabEcP/+cRFaWWLFc3EmXd54Mb26d5Rq1sCnXQ8OzkfgjJ4duaGr9pOotJxy2
 CgxHgM1zWW0UT4DF+AwZpWWYDJ73emIgEhflDwgbRsYii45sK2JnpvUlMsshlrzdHUtb
 n0hRHLqR6onex9TVsAuaKWZ7EB/G0TcL4duqnznUzD0tTI3o6OzDnRydxgFutXBW/Dsy
 4DLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfopgLYOi1VuAZrxKqqO0mbU+6KvKu+7RPk7IHAuJ9Hmh9bk34dLzquHurHJ0cGxwAne8WRRBneOM=@nongnu.org,
 AJvYcCWJDYyMAVt0xUUVMaWEpDqwInCzpyfyVPBNsIc46vonpmwJgv9upPVUFXXnFqerhcVeDp/PeXUIlPDc@nongnu.org
X-Gm-Message-State: AOJu0YwGD2ZnuIwpftxdbHnjPZsAMZc8Ipltu/OioU+uUX5TInn29s3f
 r2p7+1wuwPqvHLNxLMrZbK4gaPOjgNAKHNntxJ5MxFIDkdiZP1Of2EgcOQ==
X-Google-Smtp-Source: AGHT+IG/NkwSbyQcPA7VTBkhc+fgWP5WQMO5A6TN7O2ZRXm7nE4SiheTYHRRNUvoqC+oOJpGzcdTLw==
X-Received: by 2002:a17:907:1c1d:b0:a9a:f53:a5c6 with SMTP id
 a640c23a62f3a-a9e3a7f468fmr1599305666b.65.1730640891928; 
 Sun, 03 Nov 2024 05:34:51 -0800 (PST)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm424328866b.159.2024.11.03.05.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 05:34:51 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <cminyard@mvista.com>,
 Kevin Wolf <kwolf@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-block@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v4 08/26] hw/ppc/e500: Extract ppce500_ccsr.c
Date: Sun,  3 Nov 2024 14:33:54 +0100
Message-ID: <20241103133412.73536-9-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103133412.73536-1-shentey@gmail.com>
References: <20241103133412.73536-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
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
index 0000000000..b1fb4090c0
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
+static const TypeInfo ppce500_ccsr_types[] = {
+    {
+        .name          = TYPE_CCSR,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(PPCE500CCSRState),
+        .instance_init = ppce500_ccsr_init,
+    },
+};
+
+DEFINE_TYPES(ppce500_ccsr_types)
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


