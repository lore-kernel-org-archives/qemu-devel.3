Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB77C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 21:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1BON-0003SZ-Ck; Sat, 05 Apr 2025 17:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1u1BOE-0003RM-Dc; Sat, 05 Apr 2025 17:49:26 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1u1BO8-0004NL-Ho; Sat, 05 Apr 2025 17:49:20 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e5e1a38c1aso4334778a12.2; 
 Sat, 05 Apr 2025 14:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743889754; x=1744494554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E8ZUSX0vQnKDnTWRI/lKtyh5+xAxE0plHkcNE4ORmmM=;
 b=Ir224LIptKR93RMlFOyKCfILGmrRbJoBrKJk+hc6nIarkH1FXxB8pPvXwWWl+0NweX
 4oq2LxJ7PRJ9vcHaXNnYSAbrFRHdWhxplpnw2dQ1mMp3Xals6gaZF2z6D2X6aMCzVAdG
 cc8f/CgYFlXWkW1GZllJHosWWhjC2MiWaE3Xnq/RKwIfpvWXHjVEcT0SBnCmlJ9S/uwb
 a49NBw8dVWsxHokEB0LT1JDoOrxRvaTaN06f+TSDKFffBlv4AMHeIVSdcCmPs5ECqNtQ
 WDigNb/PHMBx4SgHNKHUaXSYMA9RZK1iJUOgdvLdeALZJ9Wqn1rSa/YYvOZLzM+l6sVn
 MM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743889754; x=1744494554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E8ZUSX0vQnKDnTWRI/lKtyh5+xAxE0plHkcNE4ORmmM=;
 b=AZCA8y5ZGmGEkFDCXbjEjAa0oXYLX58O7IvV35oAOvoE5VsffvHgWNRKlvEYfzqCpI
 CoJ8GczRDnwbpmJtb1fZnsSE/TnaR2j2qwGQsg8/nl7eVKwEw9ruCVHRJEPUwziXuXJs
 kTlQ82dcQJvDhENl0/rQ52+8EvNgMsGKaRTNBtA1LuogG3Qe7M8jgdAvUObrCUuT/lxu
 TCgL8Wk9pqwSDHpHnV6n6JaUfM69Drn2zPsgYFwYhmS1a6nOzXT3E4wymUjzo3srq3Y5
 denGwIADDlbplIgLWsl0/aMMGblDSOyOh2oGAaLKyx4UuxS25cMspojRCGLuca3ErPof
 vAdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbviaj43Exf2uWl0OT9FItvUE9iMYbqeYtBakI2zwRikFb8lIVYysAhltT8PYSY7cnbfbGYirUHQ==@nongnu.org
X-Gm-Message-State: AOJu0YzNbkmsGVrlwi6xdcAMQSgNnOaJQer6fDOLGLQ3+Nvx9DOwotAH
 999SZDXi33Kf0w7obdxM3UX2fUMi2x3JDxaqUKmPcYBtIqlmM0nHkKoHsQ==
X-Gm-Gg: ASbGncvX3JdumvUwQ9Sb6SyePWzksn3MGSS7HGp5Jd3m1cCkESz3fPOBY4jleraadNm
 0sxP8zOT2QUcNtkb8H/PzztLy14WMtKoevyXWuU4vZBKPRSBGg9RnKFeglJVtL+l+77MGGdGKYR
 Qt2v6qD73jlY+j682funF3zzP7E3+6NDFQbWHp7ByFH139e0+uyswbzU6bu0t9ZlA1YgtYaVFqQ
 FJEDU7XijIHaRxJ4WgkBmW3hsa2zf/rDt/30m/WqfQGcW7Aor1jrWBHyLhHnXC3KXJo4YJD1/O3
 pWAZZ5YiXQi9Fdezg7sJD9QmXdlFMW1tN3jOHSddWjHmcXdOhvRczYVVH8k7PKxPGNp98LbkFvn
 VT4Hh/h2u8C6kz62oBngOk+MglsotI0wIIfqjG0CZPLClrG6aKV4bnpqXbB5iTSC7e0DQt2ekll
 4=
X-Google-Smtp-Source: AGHT+IH1yvmVv8QmUtXj4B5FvU0hYvFwj4CZzUI41X24nRpK+2zAcV1VRyEFSCEropyFuT2kTTdz/A==
X-Received: by 2002:a05:6402:26ce:b0:5e5:b572:a6d7 with SMTP id
 4fb4d7f45d1cf-5f0b3b61e9dmr4997622a12.6.1743889753552; 
 Sat, 05 Apr 2025 14:49:13 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-1bf0-7700-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1bf0:7700:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f0880a535fsm4382270a12.80.2025.04.05.14.49.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 14:49:11 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-arm@nongnu.org, Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH-for-10.0 2/3] hw/arm/imx8mp-evk: Remove unimplemented
 cpu-idle-states properties from devicetree
Date: Sat,  5 Apr 2025 23:48:59 +0200
Message-ID: <20250405214900.7114-3-shentey@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250405214900.7114-1-shentey@gmail.com>
References: <20250405214900.7114-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52d.google.com
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

From: Guenter Roeck <linux@roeck-us.net>

The cpu-idle-states property causes a hard boot hang. Rather than documenting
the workaround, perform the removal from the devicetree automatically.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
[Bernhard: split patch, update documentation, adapt commit message]
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/system/arm/imx8mp-evk.rst | 12 ++----------
 hw/arm/imx8mp-evk.c            | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index 00527b0cbe..b2f7d29ade 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -35,7 +35,7 @@ Direct Linux Kernel Boot
 
 Probably the easiest way to get started with a whole Linux system on the machine
 is to generate an image with Buildroot. Version 2024.11.1 is tested at the time
-of writing and involves three steps. First run the following commands in the
+of writing and involves two steps. First run the following commands in the
 toplevel directory of the Buildroot source tree:
 
 .. code-block:: bash
@@ -50,14 +50,6 @@ it and resize the SD card image to a power of two:
 
   $ qemu-img resize sdcard.img 256M
 
-Finally, the device tree needs to be patched with the following commands which
-will remove the ``cpu-idle-states`` properties from CPU nodes:
-
-.. code-block:: bash
-
-  $ dtc imx8mp-evk.dtb | sed '/cpu-idle-states/d' > imx8mp-evk-patched.dts
-  $ dtc imx8mp-evk-patched.dts -o imx8mp-evk-patched.dtb
-
 Now that everything is prepared the machine can be started as follows:
 
 .. code-block:: bash
@@ -65,6 +57,6 @@ Now that everything is prepared the machine can be started as follows:
   $ qemu-system-aarch64 -M imx8mp-evk -smp 4 -m 3G \
       -display none -serial null -serial stdio \
       -kernel Image \
-      -dtb imx8mp-evk-patched.dtb \
+      -dtb imx8mp-evk.dtb \
       -append "root=/dev/mmcblk2p2" \
       -drive file=sdcard.img,if=sd,bus=2,format=raw,id=mmcblk2
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index f17d5db466..3bbf2bfbea 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -15,6 +15,19 @@
 #include "system/qtest.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include <libfdt.h>
+
+static void imx8mp_evk_modify_dtb(const struct arm_boot_info *info, void *fdt)
+{
+    int offset;
+
+    /* Remove cpu-idle-states property from CPU nodes */
+    offset = fdt_node_offset_by_compatible(fdt, -1, "arm,cortex-a53");
+    while (offset >= 0) {
+        fdt_nop_property(fdt, offset, "cpu-idle-states");
+        offset = fdt_node_offset_by_compatible(fdt, offset, "arm,cortex-a53");
+    }
+}
 
 static void imx8mp_evk_init(MachineState *machine)
 {
@@ -32,6 +45,7 @@ static void imx8mp_evk_init(MachineState *machine)
         .board_id = -1,
         .ram_size = machine->ram_size,
         .psci_conduit = QEMU_PSCI_CONDUIT_SMC,
+        .modify_dtb = imx8mp_evk_modify_dtb,
     };
 
     s = FSL_IMX8MP(object_new(TYPE_FSL_IMX8MP));
-- 
2.49.0


