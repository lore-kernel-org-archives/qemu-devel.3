Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE6FC021B3
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 11:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmASf-0000GV-Sl; Sun, 23 Feb 2025 06:47:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASc-0000Bu-99; Sun, 23 Feb 2025 06:47:50 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASZ-0005z6-Bi; Sun, 23 Feb 2025 06:47:49 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-abb7f539c35so689253066b.1; 
 Sun, 23 Feb 2025 03:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740311265; x=1740916065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zJCXNTYJg1OLN/itKBHj71nn16BYDbxjPhFPrcSJlks=;
 b=Bd1WTkJF/mZ/diwwHv2FXtLEdzwe8guIppywTZX/Xbt2v9ijndXtVm0e1OVWI/4kGE
 IpZl5eMIiM3sdgRlDhrySH54fEqL0Nt76AqUxPHzJB/MezkHKF+dkYA/v4/vqDVr4Sn+
 +m5g0ZIo8p2AZBPrS/YWGo1vttJZ1exZVKEBGnlSOQ1HzdEg7E5GgNdXkgEJMMbcbSLj
 JUT6Z4DfFVxrX0dGGK7UuCTGj0h955CelyuHyKDiN+fPmYfKCASOOPRCKm1juDlBK/eF
 klnlgoVi/IkyL/l2DiLzKqlsKbY4w9BmccDK2RAmcXrWHe9T+geDeprXzYzPKyGRlMhd
 m64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740311265; x=1740916065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zJCXNTYJg1OLN/itKBHj71nn16BYDbxjPhFPrcSJlks=;
 b=K3/7FgQpxqgFoyYUKy7MP1Fwdha94JXs96WVhMH+xU3WqdYb3BwC//jYX6ObEXIDDF
 h2i0FfOIq66GK2mZchqlRfca/afy30lRkdUo02sLpoHdJFXK1NTEYBnPOKbC57dXHqe/
 PzV5Rh3T7hVeMfSM4VpIQaWw02AV00NIWj9YkVn56XV1stDb92ApHIWaDsb7QxW+veh9
 KkCS/cQ7lSnN3SjLtFEs1GzGt7iLRHHy5/zf8mcABm6JYTy2Jdjh9Bjw094NlrF7izAJ
 63SeT1We3yCTqFr6+lTDy6tRtfXB4uSVFiLBXTWAibTaIjdG9kfJQMgUkipZbb3vsun7
 /sRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWo082y9Zwe++HyjtRiedOWgR9gj3S6WPwNbgbnk1Jip6+Y6OH8ijZHCj02bXZsVwraqZlfzWjI6Q==@nongnu.org
X-Gm-Message-State: AOJu0YxUvuo5/btoiOxKqi4ceC2hA3PKCM3L0wH+g1z+HyYHQpLRwx/5
 wZUjXidhTMzc/ISFHRDPdJwsszYpCO81AcS/6fZdv1j3Gr4PgmqUOoiHLw==
X-Gm-Gg: ASbGncvqkE+tHlfSuHtrV2SnxUGkM59mwEEKp34kDwCJDjuR9cL58XSkFwGCbX4ymAf
 C3ZWx2H7IpsSEZbJQSSZzwawBfweJMBooJWFTMNAtPGZDMGKbsKZFLPJqqlU9eh2PoZN6oPLC2d
 quzAnRacCY3u6UxgRyzr7OZ2yNnj7ZQfl1qwfMDsQd58QDOYdEz7gZzX2ROL+P0XN1Vc8BEDj9H
 FmDjhYpMwXJW0/Q05sBbGa2IIs4Yzfe5HEm3sp4KOTZPHBbSNpzrgqpcLFh5471+Ol4OAcx6F4u
 dHW4VdMqp0qf0iBlDDsJBWGYj5WrmtSM3FF77hlA7CJAxRiqTKsPc0ug2TFxGgiW+NOW3/6k5c0
 P1WRJj4junsII
X-Google-Smtp-Source: AGHT+IGF2BlyxuhxzStFMF7zv7GXB+qogZOWlfyWhT11IcaxU4l06pwXHJ2ZyDv42fBLP6Ud4AHRwA==
X-Received: by 2002:a17:907:6095:b0:ab7:e73a:f2c8 with SMTP id
 a640c23a62f3a-abc09a97a2cmr866318366b.26.1740311264939; 
 Sun, 23 Feb 2025 03:47:44 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-011-167-038.77.11.pool.telefonica.de. [77.11.167.38])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abba4b9ee98sm1240515466b.167.2025.02.23.03.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 03:47:43 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 16/18] hw/arm/fsl-imx8mp: Add boot ROM
Date: Sun, 23 Feb 2025 12:47:06 +0100
Message-ID: <20250223114708.1780-17-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250223114708.1780-1-shentey@gmail.com>
References: <20250223114708.1780-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62d.google.com
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

On a real device, the boot ROM contains the very first instructions the CPU
executes. Also, U-Boot calls into the ROM to determine the boot device. While
we're not actually implementing this here, let's create the infrastructure and
add a dummy ROM with all zeros. This allows for implementing a ROM later without
touching the source code and even allows for users to provide their own ROMs.

The imx8mp-boot.rom was created with
`dd if=/dev/zero of=imx8mp-boot.rom bs=1 count=258048`.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 MAINTAINERS                 |   1 +
 include/hw/arm/fsl-imx8mp.h |   1 +
 hw/arm/fsl-imx8mp.c         |  18 ++++++++++++++++++
 pc-bios/imx8mp-boot.rom     | Bin 0 -> 258048 bytes
 pc-bios/meson.build         |   1 +
 5 files changed, 21 insertions(+)
 create mode 100644 pc-bios/imx8mp-boot.rom

diff --git a/MAINTAINERS b/MAINTAINERS
index 2e7fc6fa91..489e426d85 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -831,6 +831,7 @@ F: hw/pci-host/fsl_imx8m_phy.c
 F: include/hw/arm/fsl-imx8mp.h
 F: include/hw/misc/imx8mp_*.h
 F: include/hw/pci-host/fsl_imx8m_phy.h
+F: pc-bios/imx8mp*
 F: docs/system/arm/imx8mp-evk.rst
 
 MPS2 / MPS3
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 5247e972b8..4dbe30f524 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -68,6 +68,7 @@ struct FslImx8mpState {
     DesignwarePCIEHost pcie;
     FslImx8mPciePhyState   pcie_phy;
     OrIRQState         gpt5_gpt6_irq;
+    MemoryRegion       boot_rom;
 
     uint32_t           phy_num;
     bool               phy_connected;
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index f0d5980300..f26cf5984e 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -9,12 +9,14 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/datadir.h"
 #include "exec/address-spaces.h"
 #include "hw/arm/bsa.h"
 #include "hw/arm/fsl-imx8mp.h"
 #include "hw/intc/arm_gicv3.h"
 #include "hw/misc/unimp.h"
 #include "hw/boards.h"
+#include "hw/loader.h"
 #include "system/system.h"
 #include "target/arm/cpu-qom.h"
 #include "qapi/error.h"
@@ -263,6 +265,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     MachineState *ms = MACHINE(qdev_get_machine());
     FslImx8mpState *s = FSL_IMX8MP(dev);
     DeviceState *gicdev = DEVICE(&s->gic);
+    g_autofree char *filename = NULL;
     int i;
 
     if (ms->smp.cpus > FSL_IMX8MP_NUM_CPUS) {
@@ -644,10 +647,25 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcie_phy), 0,
                     fsl_imx8mp_memmap[FSL_IMX8MP_PCIE_PHY1].addr);
 
+    /* ROM memory */
+    if (!memory_region_init_rom(&s->boot_rom, OBJECT(dev),
+                                fsl_imx8mp_memmap[FSL_IMX8MP_BOOT_ROM].name,
+                                fsl_imx8mp_memmap[FSL_IMX8MP_BOOT_ROM].size,
+                                errp)) {
+        return;
+    }
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, "imx8mp-boot.rom");
+    load_image_size(filename, memory_region_get_ram_ptr(&s->boot_rom),
+                    memory_region_size(&s->boot_rom));
+    memory_region_add_subregion(get_system_memory(),
+                                fsl_imx8mp_memmap[FSL_IMX8MP_BOOT_ROM].addr,
+                                &s->boot_rom);
+
     /* Unimplemented devices */
     for (i = 0; i < ARRAY_SIZE(fsl_imx8mp_memmap); i++) {
         switch (i) {
         case FSL_IMX8MP_ANA_PLL:
+        case FSL_IMX8MP_BOOT_ROM:
         case FSL_IMX8MP_CCM:
         case FSL_IMX8MP_GIC_DIST:
         case FSL_IMX8MP_GIC_REDIST:
diff --git a/pc-bios/imx8mp-boot.rom b/pc-bios/imx8mp-boot.rom
new file mode 100644
index 0000000000000000000000000000000000000000..5324b5eed200e723d048f8476e4d96d45622fd4d
GIT binary patch
literal 258048
zcmeIuF#!Mo0K%a4Pi+Q&h(KY$fB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM
z7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*
z1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd
z0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwA
zz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEj
zFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r
z3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@
z0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VK
zfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5
zV8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM
z7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*
z1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd
z0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwA
zz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEj
zFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r
z3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@
z0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VK
zfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5
zV8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM
z7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*
z1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd
z0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>f$Z
E2JkHa0RR91

literal 0
HcmV?d00001

diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 51e95cc903..50506a7895 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -60,6 +60,7 @@ blobs = [
   'efi-virtio.rom',
   'efi-e1000e.rom',
   'efi-vmxnet3.rom',
+  'imx8mp-boot.rom',
   'qemu-nsis.bmp',
   'multiboot.bin',
   'multiboot_dma.bin',
-- 
2.48.1


