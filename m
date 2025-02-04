Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D66FC0218F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 09:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfF7h-0004w9-RZ; Tue, 04 Feb 2025 04:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7f-0004q4-7N; Tue, 04 Feb 2025 04:21:35 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7c-00053v-6V; Tue, 04 Feb 2025 04:21:33 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso36387665e9.0; 
 Tue, 04 Feb 2025 01:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738660890; x=1739265690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ben52V9EK2Yj3sAQzRvzwRHMna24UHQvLAMSDa7JLy0=;
 b=HllkQLxYSdcJZey1v+b6EVBe9FB7dPKK2z6sDUHaM9jwPvo/Odtiqdhz5CJa9TAqwD
 WwDIZHbb44R3k18jHTSyFIoZOoBlG+tH4KpYQcHOfm+hh6RLsSVHU/kt/0hiXzITkSkd
 6RwtdXgtq0muSYadzhYWPuKZxy0IIOjxKkclqwWZw/Vjdnaf3lz/4Z4sdt+SjzQxG5y4
 BgqJemQskir+OooUebtvcfPpDJ+IlDM3eyeOrvdovGjEbLaf/3Zsa1b/QClOuXppVuOB
 CaAkjLmZNQ+ChF/P1+O0gX+kS/bmDycoDgMob4p2hjDH+ZVmvSGBginIr96V39P9GZPr
 lflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738660890; x=1739265690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ben52V9EK2Yj3sAQzRvzwRHMna24UHQvLAMSDa7JLy0=;
 b=orPOzpkPWJGOAkfCvD8nhc6+Rc6nKk/HTOTX+/HnXo/rby4715MiyCEkSG1R+CRtU0
 M7Vlb/REDzO9Xm55yKk69UOrSVaeF1lTXzusxKnyRelo1tTHqJf1xd61+V9B/54xO/2C
 /gE2SJ11mKk7bq9qdY4vHkXPJK0rtyNVMKqH3Nwpsi7YrbDZ6uNDYwxnQgynk/Y+TKVf
 +eWKnuoB47SzuzIKLUjBrMHLtosilHqUqlQcRKBn5Pym1ki1K8Utp3GA7qIPFRANx9hW
 1Rk/N2jbBTgqkFOmrilv2hd8GH4LDrq7YR+G/g9vLhZaIu0XdmM/Jpzm2+rWmpUtSSx6
 Tvyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSwccjRARCXFO2LrhKCUDg/XEoXQlIbi43oHqRY7HRP3pQBfBvgcLYwkuf6gkQeTVOx96Wsumprw==@nongnu.org
X-Gm-Message-State: AOJu0YzlxtX5dYxfQAO5SSqrLmo1ldhOLesFC45EXpATwIcNFzaHgeG/
 V+JxV4EGq1bgVbCpVL+b+zSj0sCGL0eeOe/w136ijheObq3xUlgPg4kz4Q==
X-Gm-Gg: ASbGncsi+O/1LFQpGDQRPD5Qbf0fc7F/zwNq4auQvnRcIJRiJAUkwT9z1ZfRmEkbVg0
 yuNTqHRD1R7kkd3q0U6jpRNCwxshyPO6wxLSfIS/WZ0vHZskHVXPF0Eg00MqQtCoOEWpDSAhYyZ
 4ep1qrFx6CfPT5ITN5omea0iaGHETK1dFu2+lge0LYq/g2EM+kM910m78e9yVY6+Ib4ILFNETOC
 I6MtsOlLR9k1lc9TnlbgIjgGpCCFZi7I0wY3FoDR74G501cfQ/Sw+8CtpytSCWxVGWbvspR90ww
 DE94Ha4wSspGXt8vVIRFLx+hxCv84RkWl+v9iDuK8RolOUx0JdCtEtrL6RICfr9apa0YSOHqmNf
 8afc/lxgwiA==
X-Google-Smtp-Source: AGHT+IF5thYi6ZYgbzI6+Pr3PuCsY3WgMzVF+CW26Yqo+byWOA9K8hZUwhggpxYIkJ7BMgJEGvbdjA==
X-Received: by 2002:a05:600c:3c9f:b0:434:eb73:b0c0 with SMTP id
 5b1f17b1804b1-438dc3af760mr247409225e9.5.1738660889561; 
 Tue, 04 Feb 2025 01:21:29 -0800 (PST)
Received: from Georg-PC.fritz.box
 (p200300faaf0043006a2cae69f03f1c85.dip0.t-ipconnect.de.
 [2003:fa:af00:4300:6a2c:ae69:f03f:1c85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23d42c7sm187233595e9.3.2025.02.04.01.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 01:21:28 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 07/18] hw/arm/fsl-imx8mp: Add USDHC storage controllers
Date: Tue,  4 Feb 2025 10:21:01 +0100
Message-ID: <20250204092112.26957-8-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204092112.26957-1-shentey@gmail.com>
References: <20250204092112.26957-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x333.google.com
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

The USDHC emulation allows for running real-world images such as those generated
by Buildroot. Convert the board documentation accordingly instead of running a
Linux kernel with ephemeral storage.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/system/arm/imx8mp-evk.rst | 16 +++++++++++-----
 include/hw/arm/fsl-imx8mp.h    |  7 +++++++
 hw/arm/fsl-imx8mp.c            | 28 ++++++++++++++++++++++++++++
 hw/arm/imx8mp-evk.c            | 18 ++++++++++++++++++
 hw/arm/Kconfig                 |  1 +
 5 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index 8f1237c74e..475c42d76a 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -13,6 +13,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * Up to 4 Cortex-A53 Cores
  * Generic Interrupt Controller (GICv3)
  * 4 UARTs
+ * 3 USDHC Storage Controllers
  * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
 
@@ -27,17 +28,22 @@ Direct Linux Kernel Boot
 
 Probably the easiest way to get started with a whole Linux system on the machine
 is to generate an image with Buildroot. Version 2024.11.1 is tested at the time
-of writing and involves two steps. First run the following commands in the
+of writing and involves three steps. First run the following commands in the
 toplevel directory of the Buildroot source tree:
 
 .. code-block:: bash
 
-  $ echo "BR2_TARGET_ROOTFS_CPIO=y" >> configs/freescale_imx8mpevk_defconfig
   $ make freescale_imx8mpevk_defconfig
   $ make
 
 Once finished successfully there is an ``output/image`` subfolder. Navigate into
-it patch the device tree needs to be patched with the following commands which
+it and resize the SD card image to a power of two:
+
+.. code-block:: bash
+
+  $ qemu-img resize sdcard.img 256M
+
+Finally, the device tree needs to be patched with the following commands which
 will remove the ``cpu-idle-states`` properties from CPU nodes:
 
 .. code-block:: bash
@@ -54,5 +60,5 @@ Now that everything is prepared the newly built image can be run in the QEMU
       -display none -serial null -serial stdio \
       -kernel Image \
       -dtb imx8mp-evk-patched.dtb \
-      -initrd rootfs.cpio \
-      -append "root=/dev/ram"
+      -append "root=/dev/mmcblk2p2" \
+      -drive file=sdcard.img,if=sd,bus=2,format=raw,id=mmcblk2
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 26e24e99a1..349d55ca88 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -15,6 +15,7 @@
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mp_analog.h"
 #include "hw/misc/imx8mp_ccm.h"
+#include "hw/sd/sdhci.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
@@ -28,6 +29,7 @@ enum FslImx8mpConfiguration {
     FSL_IMX8MP_NUM_CPUS         = 4,
     FSL_IMX8MP_NUM_IRQS         = 160,
     FSL_IMX8MP_NUM_UARTS        = 4,
+    FSL_IMX8MP_NUM_USDHCS       = 3,
 };
 
 struct FslImx8mpState {
@@ -39,6 +41,7 @@ struct FslImx8mpState {
     IMX8MPAnalogState  analog;
     IMX7SNVSState      snvs;
     IMXSerialState     uart[FSL_IMX8MP_NUM_UARTS];
+    SDHCIState         usdhc[FSL_IMX8MP_NUM_USDHCS];
 };
 
 enum FslImx8mpMemoryRegions {
@@ -184,6 +187,10 @@ enum FslImx8mpMemoryRegions {
 };
 
 enum FslImx8mpIrqs {
+    FSL_IMX8MP_USDHC1_IRQ   = 22,
+    FSL_IMX8MP_USDHC2_IRQ   = 23,
+    FSL_IMX8MP_USDHC3_IRQ   = 24,
+
     FSL_IMX8MP_UART1_IRQ    = 26,
     FSL_IMX8MP_UART2_IRQ    = 27,
     FSL_IMX8MP_UART3_IRQ    = 28,
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 32ca76c671..3e9fedf988 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -210,6 +210,11 @@ static void fsl_imx8mp_init(Object *obj)
         snprintf(name, NAME_SIZE, "uart%d", i + 1);
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
     }
+
+    for (i = 0; i < FSL_IMX8MP_NUM_USDHCS; i++) {
+        snprintf(name, NAME_SIZE, "usdhc%d", i + 1);
+        object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDHC);
+    }
 }
 
 static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
@@ -350,6 +355,28 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, serial_table[i].irq));
     }
 
+    /* USDHCs */
+    for (i = 0; i < FSL_IMX8MP_NUM_USDHCS; i++) {
+        static const struct {
+            hwaddr addr;
+            unsigned int irq;
+        } usdhc_table[FSL_IMX8MP_NUM_USDHCS] = {
+            { fsl_imx8mp_memmap[FSL_IMX8MP_USDHC1].addr, FSL_IMX8MP_USDHC1_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_USDHC2].addr, FSL_IMX8MP_USDHC2_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_USDHC3].addr, FSL_IMX8MP_USDHC3_IRQ },
+        };
+
+        object_property_set_uint(OBJECT(&s->usdhc[i]), "vendor",
+                                 SDHCI_VENDOR_IMX, &error_abort);
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
@@ -367,6 +394,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_RAM:
         case FSL_IMX8MP_SNVS_HP:
         case FSL_IMX8MP_UART1 ... FSL_IMX8MP_UART4:
+        case FSL_IMX8MP_USDHC1 ... FSL_IMX8MP_USDHC3:
             /* device implemented and treated above */
             break;
 
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index 2756d4c21c..27d9e9e8ee 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -11,6 +11,7 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/fsl-imx8mp.h"
 #include "hw/boards.h"
+#include "hw/qdev-properties.h"
 #include "system/qtest.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -40,6 +41,23 @@ static void imx8mp_evk_init(MachineState *machine)
     memory_region_add_subregion(get_system_memory(), FSL_IMX8MP_RAM_START,
                                 machine->ram);
 
+    for (int i = 0; i < FSL_IMX8MP_NUM_USDHCS; i++) {
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
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 0079c51734..7af8337354 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -583,6 +583,7 @@ config FSL_IMX8MP
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select IMX
+    select SDHCI
     select UNIMP
 
 config FSL_IMX8MP_EVK
-- 
2.48.1


