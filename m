Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB08CCA470
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 22:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5XYl-0007Ev-EW; Sun, 05 Oct 2025 18:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1v5XYk-0007ER-Jn
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 18:50:30 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1v5XYi-0004cV-MU
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 18:50:30 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-36639c30bb7so39160711fa.3
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 15:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759704626; x=1760309426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X5uTlnB3NhUwPh8jYQG8VqFwbODJaHhYoBAK9FpIpFM=;
 b=K9uSTpBvKdtoYR4Ejn/lJn5iAo5y/hh2jbE1BxaWAUKD9Bxmemnx13sWK2MeK4tMTR
 6Ol0jjaxj375l739rVkouQewPQv1FKFs3KP8wJeMgfe/o2s//Kd2T0z9XZqJ7w57dvyV
 SqHYStEH+FcYx+AM9CL5oNgWmg6N4OW07VVbOwMYGZ/7rk6SeqZ/3XDDAcDMS2/nBRRE
 swu0dcx2K7mClCGii4Zx4lRBYPSHJlwf+DnITi1kKkJwyAsXeshuyjrByGVFiTAx2DCq
 EZ5JAQU9E0s1GzkyDExdGeVA1Bhnh98ZYzZVIsTeZ23UBWOelOjZE6Z2PFevLjeEkadB
 bZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759704626; x=1760309426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X5uTlnB3NhUwPh8jYQG8VqFwbODJaHhYoBAK9FpIpFM=;
 b=n9MO8cxJLNfcqmLKCfjQVKvEQbShBAk1BxpgQLInnAp7JPn26o5wiYms/fvMmzn88l
 lGoOVai+7yKnAzxk1fJJqXv7/VNdj+7kQttN3vTnURMfYgrSsMHrLikrN8aYozPLVAev
 zI44lDaqNN+OD/ntuQe+qDw0cVqDd/5uxZAvu8wydNjeTEyvnDHXMp5J/8XoHAGzWHsK
 lu6souaPsY4RUPkIqSLiW1np6At2OLHGq5ZkN5fzP/6foYTWWOBybbk+swaHfmI9kYCA
 NNKR6V4uw+06qOwGvllZUEZnEeTgfe45H6ZXkqkENXj0w3uw5EJKquFDM5+FIlrI+7vv
 /cEA==
X-Gm-Message-State: AOJu0YwZoNfZNM31RS6XouPRh3Ixi3rkUblIKbZ9j0nJ5JiOeYEXFlPx
 6gJw83cvq3Uqe9R2/WX0gOz1DIPdYQzkT2cu0nXP8qPTrgJMi06VAoeJQ0viBw2z8OTvTg==
X-Gm-Gg: ASbGncu5gAXwL4qTlnbK75cxTeNuKs10B6aPpbaiogFn1vhpFdi5ESSWgSt51IYG3sm
 TJu30kdRBVFvq5yt5xmy9ldSond6ZLvxppu9GUcEFTshhDzwT4OZE/G+FD0Ia4lPFzE8Okq3zdL
 WcnIbcRtpexaIxVHS6XV0Jc6WbkqB/MUUVk1q0E2lbrfitIm95gYNESTtQk02r8DwrikNtr+Obr
 7PnqpbaXJO0S//R+d6AdTC13ZrF4Av8Q3EFUuSscdhqVBLCZgwd/dRbrFHRmOcO5KBODTCPF0YS
 WpH5KTF54OQcKGFa11VJBWBGgRf7rVUFv/QMfrGvWVKIn98qcXxvBhvn9HyNdA7xstgIS9mU0zv
 IBOMUP3+QIvW9zrJBmMmc+gJ66Sw+Gq4eVfh3wuVvagPIdkX4NM+bl+sjTesN
X-Google-Smtp-Source: AGHT+IHay7KzOZh/r4sG251pC2HYHoRVDFj9mAu0PYz3ZujBSnTdqglHE6Y/ohthMgFe93kJX+PWmg==
X-Received: by 2002:a05:651c:235a:10b0:372:80ac:a33a with SMTP id
 38308e7fff4ca-374c381c0efmr27286411fa.28.1759704625935; 
 Sun, 05 Oct 2025 15:50:25 -0700 (PDT)
Received: from xpahos-osx.yandex.net ([2a02:6bf:8080:a74::1:2e])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-373ba4bbb7csm37638971fa.47.2025.10.05.15.50.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Oct 2025 15:50:24 -0700 (PDT)
From: xpahos@gmail.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org,
 Alexander Gryanko <xpahos@gmail.com>
Subject: [PATCH v2] hw/arm: add pvpanic mmio device for arm
Date: Mon,  6 Oct 2025 01:50:16 +0300
Message-Id: <20251005-arm-pvpanic-v1-1-1e473a735212@gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=xpahos@gmail.com; helo=mail-lj1-x22d.google.com
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


