Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C62CF9C5B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 09:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssfPi-0002sz-Nd; Mon, 23 Sep 2024 05:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPZ-0002LO-Qt; Mon, 23 Sep 2024 05:31:17 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPX-0006y9-L2; Mon, 23 Sep 2024 05:31:17 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5356aa9a0afso6216749e87.2; 
 Mon, 23 Sep 2024 02:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727083872; x=1727688672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8dnNWB1tKdPz2ILQ+8Fnny+ubgZlPn6x4nw7p7w7r+Y=;
 b=MVNp+fP7kfwziKFeXvoohG1nLxUlpLh3jTDtcfcIJunZ4lJ7BhYl1DB9w2bKvuVdqy
 j4+fUprMaUNnLsgO8ZikJytoQeNFDIjEose1Vwl9UZkEQLE2HV4nAa0Y3/5cZrnIrILC
 pwaRSig800lmDrTqfuTIx+Q2M3vXXYmw/m44VZlZTY8rsXqB2KxbLYHf3RHYVdm1lfPq
 2gP2dc5JKlPj5nPp31TXvKBqKJd7ZwBxs5V1PkKihwF9V4f9NOIKh8dY8lsLd5nwzL2I
 aC+L7gYgNB5R3vPyklqGFNKl07ayPwffmQKNuTvTmofs7gAYlGMQpAhXM25u3KLLuS4F
 mF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727083872; x=1727688672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8dnNWB1tKdPz2ILQ+8Fnny+ubgZlPn6x4nw7p7w7r+Y=;
 b=H6rorrKGFdOl2FoDqXhGVPj1B1+50fAYCfFWh/wzgM6TT8xoAFwRWgjw/Yo0fPcHmA
 YX3MlzsBZUCFF+NKTxohdVOZFD4H5prULfXL+8e55zK7Yfuwr0ymja3lFnW+N6UlzB+Y
 lOXbqW2HjzfhEr+xxRe0c5NKIQBqn/1n1l6a7FXAmWqSDh6pMhUvDp3RTZCQ8ta4VEOU
 X2msqTIgOrqz1XZkUTjhcKDjroqyu3uB0q9tG8ed93R2/J1OzYSJcM4U1Qrw9CyktouH
 we2PZnlEphMcrNJYFlBruqTx/AmQEjQtTB8VnKTKCUSxI07KewQMhLDSDX69+tk8Iz+b
 ZxUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtjblENNODsRKVrvo+ImqX9Tnsfbtr3U3cHOs8q1geopdUK4ju5gLgyFmaUt/0lT+btYt3LTFrvuVa@nongnu.org,
 AJvYcCVzHxojqMuX/nk/FTYC7+fRw4j8FF4+jnSxoHthziGnOJsSI0CVGqvgt2tQ7/xte37uPDI15ApC4tA=@nongnu.org
X-Gm-Message-State: AOJu0YzaSDvLeMmWbrauIl4SmDUGuD5QpbAzcwx8CBfoUjMMHE8KKaR4
 USeg9cMk0tGv9UvCVnXGqi5zX5uTcDRKZA2UrpJMRfuSZE3RqXgZ74begA==
X-Google-Smtp-Source: AGHT+IHcv1XM/XdU/R0ABNQsgcs+p8SK6GKNTprFTr8urPgVkse5sGszB6o2CksHWFgjIx8imMOsww==
X-Received: by 2002:ac2:4c4d:0:b0:533:45c9:67fe with SMTP id
 2adb3069b0e04-536ac32ef59mr6896874e87.48.1727083871927; 
 Mon, 23 Sep 2024 02:31:11 -0700 (PDT)
Received: from archlinux.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b3f6fsm1188747166b.107.2024.09.23.02.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 02:31:11 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 07/23] hw/ppc/e500: Extract ppce500_ccsr.c
Date: Mon, 23 Sep 2024 11:30:00 +0200
Message-ID: <20240923093016.66437-8-shentey@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923093016.66437-1-shentey@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x12e.google.com
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

The device model already has a header file. Also extract its implementation into
an accompanying source file like other e500 devices.

This commit is also a preparation for the next commit.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 MAINTAINERS           |  2 +-
 hw/ppc/e500-ccsr.h    |  2 ++
 hw/ppc/e500.c         | 17 -----------------
 hw/ppc/ppce500_ccsr.c | 38 ++++++++++++++++++++++++++++++++++++++
 hw/ppc/meson.build    |  1 +
 5 files changed, 42 insertions(+), 18 deletions(-)
 create mode 100644 hw/ppc/ppce500_ccsr.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ffacd60f40..b7c8b7ae72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1433,7 +1433,7 @@ e500
 L: qemu-ppc@nongnu.org
 S: Orphan
 F: hw/ppc/e500*
-F: hw/ppc/ppce500_spin.c
+F: hw/ppc/ppce500_*.c
 F: hw/gpio/mpc8xxx.c
 F: hw/i2c/mpc_i2c.c
 F: hw/net/fsl_etsec/
diff --git a/hw/ppc/e500-ccsr.h b/hw/ppc/e500-ccsr.h
index 249c17be3b..3ab7e72568 100644
--- a/hw/ppc/e500-ccsr.h
+++ b/hw/ppc/e500-ccsr.h
@@ -4,6 +4,8 @@
 #include "hw/sysbus.h"
 #include "qom/object.h"
 
+#define MPC8544_CCSRBAR_SIZE       0x00100000ULL
+
 struct PPCE500CCSRState {
     /*< private >*/
     SysBusDevice parent;
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 2225533e33..4ee4304a8a 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -61,7 +61,6 @@
 #define RAM_SIZES_ALIGN            (64 * MiB)
 
 /* TODO: parameterize */
-#define MPC8544_CCSRBAR_SIZE       0x00100000ULL
 #define MPC8544_MPIC_REGS_OFFSET   0x40000ULL
 #define MPC8544_MSI_REGS_OFFSET   0x41600ULL
 #define MPC8544_SERIAL0_REGS_OFFSET 0x4500ULL
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
index 0000000000..191a9ceec3
--- /dev/null
+++ b/hw/ppc/ppce500_ccsr.c
@@ -0,0 +1,38 @@
+/*
+ * QEMU PowerPC E500 embedded processors CCSR space emulation
+ *
+ * Copyright (C) 2009 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * Author: Yu Liu,     <yu.liu@freescale.com>
+ *
+ * This file is derived from hw/ppc440_bamboo.c,
+ * the copyright for that material belongs to the original owners.
+ *
+ * This is free software; you can redistribute it and/or modify
+ * it under the terms of  the GNU General  Public License as published by
+ * the Free Software Foundation;  either version 2 of the  License, or
+ * (at your option) any later version.
+ */
+
+#include "qemu/osdep.h"
+#include "e500-ccsr.h"
+
+static void e500_ccsr_init(Object *obj)
+{
+    PPCE500CCSRState *ccsr = CCSR(obj);
+
+    memory_region_init(&ccsr->ccsr_space, obj, "e500-ccsr",
+                       MPC8544_CCSRBAR_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(ccsr), &ccsr->ccsr_space);
+}
+
+static const TypeInfo types[] = {
+    {
+        .name          = TYPE_CCSR,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(PPCE500CCSRState),
+        .instance_init = e500_ccsr_init,
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
2.46.1


