Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C6ACCA472
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 22:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5XD0-0004FJ-7N; Sun, 05 Oct 2025 18:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1v5XCx-0004Ec-SB
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 18:27:59 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1v5XCu-0002Pu-5q
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 18:27:59 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-36d77de259bso36843871fa.3
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 15:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759703272; x=1760308072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X5uTlnB3NhUwPh8jYQG8VqFwbODJaHhYoBAK9FpIpFM=;
 b=ACm0RTa38sh6U4yv1jkk2kt01nOTZn622JimEKPvmrxRUzDd9jwwhwHtT3fECq7m8r
 qXvsPclSLqjKStuZFprnePMyNH6C0jrTIpFXrFJgzW+GnrgHkLGAIfAvT0HZtzaxEY17
 8fBwG2wsOQcylPPUf3anrUpxtyvQsQ86XYnu0qIJstUd0sn3y61u0LVVlnzp7kbdpDwb
 vNwzr7VSc2k3mUHyrCi6LERpzaLUm7WZf/4Onsoq87dzEFnQk5DSaT6GaBkfbGxthY20
 GQTbBIV3Ao09I/74VAxaEbYQsbs6e7tw+WnQYPnRTC5Nsw/i8Feoactb0NgyXzFzTUYN
 nAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759703272; x=1760308072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X5uTlnB3NhUwPh8jYQG8VqFwbODJaHhYoBAK9FpIpFM=;
 b=FPvMCApTHPPP/YBEl2Snumm86dpbpPV8TeyPQUrB6mL2fampvLYohbf3k0ncMddi2C
 tMPxX3DKuOLag+gWdoBuNrWj8N4I0OpghV54cKpWxNEqI+5MArWvVKZlECynK5ASQjB9
 StIeoDrA0v9QdQ43+z/SC6zOewtpqGo9bI0oo8B7QXNZblqlg5LZmfzyvFfBsEIIf5qb
 5MEoyudxNRdfAskIL4qYBL1lFGtVF9OqNaIc1/b1DPMZIDR6emX4ghz/UQlTHMBAUuBb
 Mrow6JzmXmaNpzn7RbentZ+KD2FWSAb/Z3IaVO7WD+PlRD+96vpF7okg+8CH031Vz7sN
 sOmQ==
X-Gm-Message-State: AOJu0YwyU5rx9VWUO2w3kKIbSTPf28PMazZ+TjphQpykBRGfdqzeDRwh
 xfJxg+Dqql/KhU7G7rqzytBF7WZnCKq70Mnnm0WLT3EEJbeaHNwxnAkpp7pzzcDt9M8=
X-Gm-Gg: ASbGncs6gPrrGq38zSyWzOaIk4UKUqCHcOFxeqK8M2LGhg60SP0QQfb/DvzkXAOrpSB
 Ns8B8phLZBfmlAM445JZcwyLsmcy8X9JIql9sho/sDDtxcpMnuMaf0Ryty0UMXa+3Bui6NPoJ5v
 MpTTJnhUmkh/LpSVKzqCu14x2aWEUN0+GsaNaxPmItdWiCDLwH8vOxymUtSJhMJT0E8eRbDA6tf
 6BCeVVBlBW/dycmD6CopE9qZ4tm3fBHbANTbroT/j/Zy5GNgxwzVV7H6oLBhYG9SKsUmByaVsvd
 y7haIBpuE2WKWBoyUxLb31CTgJJvYhWJhURIb/S5w6grbr0tVwvgrBRoi7Pk6GbwAXO8stX6vc/
 ymWWhXIJEw/TZD/gc2CHZHhNjdWFuIBao/mYe94K0NePYGdYmEhCQ38VXaho=
X-Google-Smtp-Source: AGHT+IEBY5dBcu3MLYDF7IdOYTiO+zF1su8jNk5JgrpgIOiPAVkKHS5J/KRsbuc+pGayULcnQOlhMw==
X-Received: by 2002:a2e:bd0c:0:b0:36b:2a0a:b906 with SMTP id
 38308e7fff4ca-374c36cc018mr30769051fa.12.1759703271919; 
 Sun, 05 Oct 2025 15:27:51 -0700 (PDT)
Received: from xpahos-osx.yandex.net ([2a02:6bf:8080:c37::1:1])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-373ba44441dsm37885831fa.37.2025.10.05.15.27.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Oct 2025 15:27:50 -0700 (PDT)
From: xpahos@gmail.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org,
 Alexander Gryanko <xpahos@gmail.com>
Subject: [PATCH v2] hw/arm: add pvpanic mmio device for arm
Date: Mon,  6 Oct 2025 01:27:31 +0300
Message-ID: <20251004-add-newline-guest-error-log-v1-1-a61df1599936@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CC5A0011-CD14-40F9-8023-8BF5F989BCCF@gmail.com>
References: <CC5A0011-CD14-40F9-8023-8BF5F989BCCF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251005-arm-pvpanic-8e3e8fd05e95
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759689277; l=3360;
 i=xpahos@gmail.com; s=20251004; h=from:subject:message-id;
 bh=8vahP4rJaiEcZHPpEIyes8fe5YhSlu876t+4bYa3n2I=;
 b=vONAhLi4eVISLyW7o+8CipIPEObfmTUCcqjBA6B8U4KZFyvnayVlS3I/UIOAageN477CuaXAb
 U1enPaZJZw4DFsk1B1Aeo+g+ZNj09r3sdN+WVEP76yahEAJGXt2RxG2
X-Developer-Key: i=xpahos@gmail.com; a=ed25519;
 pk=bsSvP3Tn7PVKgjJT3BMV3jlAwSqreKIM4099C1r51eg=
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=xpahos@gmail.com; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Message-ID: <20251005222731.f_wbZ7pRpijDrRu9TBike1sSs-cYRNzaXDf6KaE97aM@z>

From: Alexander Gryanko <xpahos@gmail.com>

Currently, pvpanic is available in three device types: ISA,
MMIO, and PCI. For early stages of system initialisation
before PCI enumeration, only ISA and MMIO are suitable.
ISA is specific to the x86 platform; only MMIO devices
can be used for ARM. It is not possible to specify a
device as on the x86 platform (-device pvpanic); the
only possible way is to add an MMIO device to the dtb,
which can be implemented by manually adding new functions
to the QEMU code, as was done in the VMApple implementation.

Signed-off-by: Alexander Gryanko <xpahos@gmail.com>
---
 hw/arm/virt.c         | 26 ++++++++++++++++++++++++++
 include/hw/arm/virt.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 02209fadcf..78e466f935 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -39,6 +39,7 @@
 #include "hw/arm/virt.h"
 #include "hw/block/flash.h"
 #include "hw/display/ramfb.h"
+#include "hw/misc/pvpanic.h"
 #include "net/net.h"
 #include "system/device_tree.h"
 #include "system/numa.h"
@@ -182,6 +183,7 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_UART0] =              { 0x09000000, 0x00001000 },
     [VIRT_RTC] =                { 0x09010000, 0x00001000 },
     [VIRT_FW_CFG] =             { 0x09020000, 0x00000018 },
+    [VIRT_PVPANIC] =            { 0x09021000, 0x00000002 },
     [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
     [VIRT_UART1] =              { 0x09040000, 0x00001000 },
     [VIRT_SMMU] =               { 0x09050000, SMMU_IO_LEN },
@@ -276,6 +278,28 @@ static bool ns_el2_virt_timer_present(void)
         arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu);
 }
 
+static void create_pvpanic(VirtMachineState *vms)
+{
+    char *nodename;
+    MachineState *ms = MACHINE(vms);
+    DeviceState *dev = qdev_new(TYPE_PVPANIC_MMIO_DEVICE);
+    SysBusDevice *s = SYS_BUS_DEVICE(dev);
+
+    hwaddr base = vms->memmap[VIRT_PVPANIC].base;
+    hwaddr size = vms->memmap[VIRT_PVPANIC].size;
+
+    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_mmio_map(s, 0, base);
+
+    nodename = g_strdup_printf("/pvpanic@%" PRIx64, base);
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
+                            "qemu,pvpanic-mmio");
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
+                                 2, base, 2, size);
+    g_free(nodename);
+}
+
 static void create_fdt(VirtMachineState *vms)
 {
     MachineState *ms = MACHINE(vms);
@@ -2498,6 +2522,8 @@ static void machvirt_init(MachineState *machine)
     create_pcie(vms);
     create_cxl_host_reg_region(vms);
 
+    create_pvpanic(vms);
+
     if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
         vms->acpi_dev = create_acpi_ged(vms);
     } else {
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index ea2cff05b0..39bf07c9c1 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -81,6 +81,7 @@ enum {
     VIRT_NVDIMM_ACPI,
     VIRT_PVTIME,
     VIRT_ACPI_PCIHP,
+    VIRT_PVPANIC,
     VIRT_LOWMEMMAP_LAST,
 };
 

---
base-commit: bd6aa0d1e59d71218c3eee055bc8d222c6e1a628
change-id: 20251005-arm-pvpanic-8e3e8fd05e95

Best regards,
-- 
Alexander Gryanko <xpahos@gmail.com>


