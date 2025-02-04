Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E630C02197
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 09:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfF82-0005OA-Ez; Tue, 04 Feb 2025 04:21:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7n-00054X-6j; Tue, 04 Feb 2025 04:21:43 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7l-00056H-0w; Tue, 04 Feb 2025 04:21:42 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso53300305e9.0; 
 Tue, 04 Feb 2025 01:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738660898; x=1739265698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iNwJL70TvJQ4/pz3SSQlqnGrmJeGd5p37x5US2YKiT0=;
 b=OMNh0UBPv7lTcJYxlk4ST9puvQexomDV0gY99kP1EN50Q+KzubjHP1QItqxr+eAD5N
 XKxyBt3FBQ2Ywu87pOeGJHt1fr+gE+V8dfuxKeYMqA9J/1WJ2wJW1XeNO4f4jTi9+nSH
 s3bs+3JA5MtuIMw20Li7edbm38lnGjfqc9nKpSqxKZ14ISnSJFiw3vOovTfIbaGV547v
 FVZYQ4tqgJ8vwnJGj37P6GZ3O7wlwTT3/ytnj30CKmyjlTCrF40wMvKNtY30Ac7h/R4Q
 UHwKrCLzq2M+VcbOrZLwZUi6lZutSuMZ5NOVt3mWD5eVzWM+JFtDkZOK5nPrwe/CiFmJ
 bbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738660899; x=1739265699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iNwJL70TvJQ4/pz3SSQlqnGrmJeGd5p37x5US2YKiT0=;
 b=ZhWPB3sX17XXtv84hdVkmH67SpfYyZtPZHCzGMovOu0Cv7Oou/ad4RsG1+rujI2uI+
 TRarPwgMpc4wP275f+Awb4xsJCQbNyZTf+CZQArrjH1GxQbxitVXq8/vuEDmyPIY2sEU
 0QWEKqPCcnqiGVmPPMiCf4hoMuZNi8lG7BNLTo7zATXApTa3gmCf9wzV2IS0lSWpRJxd
 dO/kzrj2MSPp2UN9JSqxD5+hgo33boiS8EPBAdhwHkPwe33du3yJy4gWiiy4QB7WG8m9
 UDIH+wLbNF6MFpMdX75WYWfoYuBGm2DEotcgOMfMQpKBrvKtjchm2XRgoNS0tIJfR2lb
 v65A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLLcBcfK8UEHIfs9GdGDjoVVpWRwPo8/IyBfeYzWi2H5PCOpRcby1QuGYEwbm5Y9YGT5S1LIiq+A==@nongnu.org
X-Gm-Message-State: AOJu0YxiOxr3Myl3gxkLYGrENk++k4/oCANFxD2bwSs5acgBUmacXNYw
 QEKW7pzgRKZ7/JANrZjc20hxFbZQ8uivT65IoYA0nLRKSORtMCJ8JzQV8A==
X-Gm-Gg: ASbGncswOe3We/SJoUUxdSDN3gAVOqrjyXYOVPT7dDFmUo6r/KuqYCDYIqems5b51nZ
 8Umds6ZDM+zh4WOR3T11a5VJ+Lh8BUV3Q1zvdV+WrtCEuFfRVo07orzarZGWoVN5fSoezjLut4i
 IhTDTtLaKqGc4vCD4WcUw2tJCPGSF8wjaui/l9Ot8TF+XgTqbIT8C7+bTWQx1pld8RmVYnXTQ/u
 DfnZ6kMgTCBbWDKRGDiTKtcQXRtMJ2lxqYY2pkEdBr/ucyxiTEm5eJ4CJwUcRGre7jC4fOciPMV
 2Y2Ted9El1GB7yJTY6oFGPmPPLBats0vbddkrvvDeE/BCaB3UgJ10AECLEjgPeQ4I6/8sHxRvvW
 QQf9XUnvzpQ==
X-Google-Smtp-Source: AGHT+IFtb+oWD/U78XKV4wfJDY2UyYisq4/9OU29kIwOZfVM5ESVrpLmtZmK5oVLKKlRhP1tKAyn6Q==
X-Received: by 2002:a05:600c:5119:b0:438:a432:7c44 with SMTP id
 5b1f17b1804b1-438dc40b281mr194151655e9.21.1738660898418; 
 Tue, 04 Feb 2025 01:21:38 -0800 (PST)
Received: from Georg-PC.fritz.box
 (p200300faaf0043006a2cae69f03f1c85.dip0.t-ipconnect.de.
 [2003:fa:af00:4300:6a2c:ae69:f03f:1c85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23d42c7sm187233595e9.3.2025.02.04.01.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 01:21:38 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 16/18] hw/arm/fsl-imx8mp: Add boot ROM
Date: Tue,  4 Feb 2025 10:21:10 +0100
Message-ID: <20250204092112.26957-17-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204092112.26957-1-shentey@gmail.com>
References: <20250204092112.26957-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32d.google.com
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
index 94af3d90e4..ee837a3f6e 100644
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
index 14d696957a..6439639110 100644
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


