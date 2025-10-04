Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58A0CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 20:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v58j8-0007K8-CQ; Sat, 04 Oct 2025 16:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1v58j3-0007JL-St
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 16:19:30 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1v58iz-00081h-Ez
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 16:19:29 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-36d77ae9de5so34104201fa.2
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 13:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759609163; x=1760213963; darn=nongnu.org;
 h=to:cc:date:message-id:subject:mime-version
 :content-transfer-encoding:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Qo7hddKpSdc6MpWwF5YtNaqmI9PS33MydNZ8ZzjevYc=;
 b=VGHBK01dXtjdl6luxlTSw/CNkO+fj/J7m1SmKxPzo34BaXkk6CI2KSt9tSfyDu57J3
 65M9xnsfJJmeJekSNBj4DvTygimsVpR8jEvlcUEd5MnwDx5ysrXDL4l9Y46OTLA+1mSj
 KcDoLAj3A1znY8K71Wt3ebWTXgSRl8m43ePDdUJTDg2Kv9hxYC5Th43vvcw4gQYZ3aVF
 8xU2B9j32Sr0BeFQj9WGGcEn0rbNGG+jztcHED/8KlgSvVlCNcU0dGTx+xN3lUdD3XLL
 eLg4u1BeETikMe8VdUSt9Wl1JaCy5fG5pT6LJprIRO3yBRzvJ5UYHcMpPOHmfFNa11HM
 rCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759609163; x=1760213963;
 h=to:cc:date:message-id:subject:mime-version
 :content-transfer-encoding:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qo7hddKpSdc6MpWwF5YtNaqmI9PS33MydNZ8ZzjevYc=;
 b=qvHflnOY730gnFNdLdnNodGjujxMNXVrdVsanWqXefkt73IJ/VrcVKgSPTMa2kdJHq
 wOJSQR+buxiy1CPgxXWR9ppYW3h98evzT4VQZ2wPIY4Si+mdD++4P2pNVboS2tprIyt7
 NincPesMtj+z+HTM7pHGJSQPnopFYXkFZeCS2H5LJsNyFNGsYD9oQToA+/XlNLoXMRBy
 3Vs9bh6kE6NRYul/WAm+J94OCX2ARSWSldBTgf6r1LCwAG53sXVU7JiQmPqGv5ZEIiBO
 8wRhX7BlZTKmTMaiHSpOv1WhI2GqseqLx6uSRng7kxie7hj4O9euMZrqC3xvHFjnrnIy
 kQAw==
X-Gm-Message-State: AOJu0Yyt5DLwT4MQhWZs917AW5oFIu2OFyf+Tc3/grO+3qBrIU/qXU0u
 dqpfiIH+4N8SWwIishyr76E4XJTq6333jKrRxoHkcHLiI4568+QENQN6mrLLap5YOE/PMK63uQM
 =
X-Gm-Gg: ASbGncswx+NKC4Nox86QD4Rew3SkZQPJ+mgb4ohp5TLs8CMaFVkUO0MlEyGpMXZ7c9b
 z0ngrcrREDEqhisevBYoMz0YufPxDk0xRn1mExZpSb5jIUZwwTmOfAn3nYnWCpEGpKko37D6VSm
 DJ3Dijm21006aITdEXZViwj81joeGwsaGhDTDz0QlsAdIVbZx97bypnjYDfAd5GsZe8x00SWZbd
 OARPfUeEB5QwQa77dlmlJlN/GJq922DTRnGiGiO5MxmRnkm/3+tqB4EkzA/XOCoIq2sFAz80bkp
 v3fJQsXeEPpZ9Bveool3Q+cm44vtlH2h9j5K/omBy6cxHnWeDKk5tYX4eJZ3YZWXiPAcGNcJwRS
 4lu59XS9c1bmx1WUh8YS22Hy9B0bxnAjgyo4KUqgCoGeK9t93vrsntA==
X-Google-Smtp-Source: AGHT+IFmQnlWQWl2OQhtk+OiUUcBSwh8IMzLFBO9I1by351N8N2FkY+4/GQjhFIxJR+z2x5o9JRCZQ==
X-Received: by 2002:a2e:be9c:0:b0:36b:b439:93cc with SMTP id
 38308e7fff4ca-374c389c921mr22620081fa.37.1759609162377; 
 Sat, 04 Oct 2025 13:19:22 -0700 (PDT)
Received: from smtpclient.apple ([2a02:6bf:8080:446::1:2b])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-373ba2a536esm28391881fa.14.2025.10.04.13.19.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 04 Oct 2025 13:19:21 -0700 (PDT)
From: Alexander Gryanko <xpahos@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.2\))
Subject: [PATCH] hw/arm: add pvpanic mmio device for arm
Message-Id: <CC5A0011-CD14-40F9-8023-8BF5F989BCCF@gmail.com>
Date: Sat, 4 Oct 2025 23:19:09 +0300
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-trivial@nongnu.org,
 =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCT0YDRj9C90LrQvg==?= <xpahos@gmail.com>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3776.700.51.11.2)
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=xpahos@gmail.com; helo=mail-lj1-x231.google.com
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
hw/arm/virt.c         | 25 +++++++++++++++++++++++++
include/hw/arm/virt.h |  1 +
2 files changed, 26 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 02209fadcf..1059584b67 100644
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
@@ -276,6 +278,27 @@ static bool ns_el2_virt_timer_present(void)
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
+}
+
static void create_fdt(VirtMachineState *vms)
{
    MachineState *ms = MACHINE(vms);
@@ -2498,6 +2521,8 @@ static void machvirt_init(MachineState *machine)
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
change-id: 20251004-arm-pvpanic-84a7d7b67d8d

Best regards,
-- 
Alexander Gryanko <xpahos@gmail.com>


