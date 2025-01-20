Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C81C02182
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 20:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyXU-00041p-5j; Mon, 20 Jan 2025 15:38:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyXR-000409-Vr; Mon, 20 Jan 2025 15:38:26 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyXQ-0002ZP-3Z; Mon, 20 Jan 2025 15:38:25 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5da12190e75so9961327a12.1; 
 Mon, 20 Jan 2025 12:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737405501; x=1738010301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rP66Lwmrdds6cbXeetmX1aW2fqQVX5oWxwYr0NMorxo=;
 b=heKf5z0V26htFBkKeT3gGHkST4T+2YaJEyIahm1QgDWhn9gt2noBtpCIY68yuxUOP9
 Bj9eF4XaoD6z4UNRw3d0ChO2LyuOdIroz9QQrpQhfPcVf3jYzpeLn4eLqc9o4H23+lwa
 +B59EilQ35eDfHnqLi0/af6m22JVFm7zgy53vMjQgS2Szi6S/KIOh4derLSpWT0jqgd2
 Z6LHy0wU/2uh9YLKS+Jcg9Dx1IESb4fu4bZ/OKOqsqrs3avM4ZxT7vpq+Q8GIKwAF/yu
 dEp+Q/bfO/ZA5/OZj2WKHm2oMh5gJwv2qqJ9W81Qj51LOthsgmBWIRowLokVgX5/fw+R
 RjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737405501; x=1738010301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rP66Lwmrdds6cbXeetmX1aW2fqQVX5oWxwYr0NMorxo=;
 b=xL0D70fnEMrmgqCit0DVsaJVxd7CudOMZflw4EcKq1G9RHb06sclEfZ3fXsQMvLH67
 a/uQsezcbm3gnp7aJ/gVNH6U2SxxDUBNSIeV/K3HuEfnfsBTcIcdHBLRqhLl9yfwCASi
 2N++AlQOSSVys2bWC1mG3NEq6coh4lLXjPp+vrA/NF8OF0JYHlpEy6fwYF0rhda84sVR
 DtCNY3BcOhhklb04D97kKEllBLXvaB+ICTbaHAYpnQyKBLPvZV1zCZudJboa23JNPxLr
 rR5AfmgA/eKuVW6W6C9ioZs0FifAOM1JiGCbSLMoDFERr+C3FKe2MlP7v5GNbcEjSRzA
 9UkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs/EbHTOSieIMCriG1Anjhs5QyI49NtpFFkqIB+DHGwJqdCmSZV4Sr6LCD3xVwFpL56W3bhzOXUA==@nongnu.org
X-Gm-Message-State: AOJu0YzD9198wncUYkRIswUK7tA9OJPkvTXp0fuXxdgtEjv36elUACpl
 vEUPFqF8BiuK0ENp77Xj+Xnv/hcBTUSuXWnq9CFj4e1NWFeNoiI/6HXODtJl
X-Gm-Gg: ASbGncsgAiPaU+jsp74B/GewjUegGknxb1AqOqPT8EQEM1f44kUv4u11ALR1q+hPqOH
 JPAUj6/GWt/Tqwjedy+BgxTbuxEVnoOnEZqi5DUK1Kn+p19NR0srS6v75ha9kUUKEDMcRHLCGDd
 EOrX37UVlN7OinhVK7+RlJaxhFZIZK+1hygBovr910P8QGKcaQDmlvaPkuHpGGTrMhbmBZLp5Ns
 v90/sNjcXK0F9jLWL+5/cpu8mRR+/l0fdrnHQqCStRjxDQP+C9LHZzNKQwOYO1dyZknJc1cyKK6
 gogGH2KQIuX6I+W4mVzytGVr+yhm3I9fkJHtXFNEUi1NvcnFbimw4MixBcWs
X-Google-Smtp-Source: AGHT+IFN4bBqWcyjoAsEbq9tX5cFRRykfGHeQViiXlLddSVpUXs8iKIexu5LN9I/qTkfEv+A19mLvQ==
X-Received: by 2002:a05:6402:5203:b0:5d3:e766:6143 with SMTP id
 4fb4d7f45d1cf-5db7db078a1mr15212833a12.30.1737405501364; 
 Mon, 20 Jan 2025 12:38:21 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-183-181-102.77.183.pool.telefonica.de. [77.183.181.102])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db7364258csm6021077a12.1.2025.01.20.12.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 12:38:20 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 17/21] hw/arm/fsl-imx8mp: Add boot ROM
Date: Mon, 20 Jan 2025 21:37:44 +0100
Message-ID: <20250120203748.4687-18-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250120203748.4687-1-shentey@gmail.com>
References: <20250120203748.4687-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52e.google.com
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
index 76b416831d..d2cdc790ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -830,6 +830,7 @@ F: hw/pci-host/fsl_imx8m_phy.c
 F: include/hw/arm/fsl-imx8mp.h
 F: include/hw/misc/imx8mp_*.h
 F: include/hw/pci-host/fsl_imx8m_phy.h
+F: pc-bios/imx8mp*
 F: docs/system/arm/imx8mp-evk.rst
 
 MPS2 / MPS3
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 1b8a5cbbba..326c4ddf69 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -67,6 +67,7 @@ struct FslImx8mpState {
     DesignwarePCIEHost pcie;
     FslImx8mPciePhyState   pcie_phy;
     OrIRQState         gpt5_gpt6_irq;
+    MemoryRegion       boot_rom;
 
     uint32_t           phy_num;
     bool               phy_connected;
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 5b9781a424..9688e2e962 100644
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
 #include "qapi/qmp/qlist.h"
@@ -266,6 +268,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     MachineState *ms = MACHINE(qdev_get_machine());
     FslImx8mpState *s = FSL_IMX8MP(dev);
     DeviceState *gicdev = DEVICE(&s->gic);
+    g_autofree char *filename = NULL;
     int i;
 
     if (ms->smp.cpus > FSL_IMX8MP_NUM_CPUS) {
@@ -648,10 +651,25 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcie_phy), 0,
                     fsl_imx8mp_memmap[FSL_IMX8MP_PCIE_PHY1].addr);
 
+    /* ROM memory */
+    if (!memory_region_init_ram(&s->boot_rom, OBJECT(dev),
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
index b68b29cc7d..64d3286fdd 100644
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


