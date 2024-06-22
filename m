Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD079C27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 12:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKzWJ-0007yZ-QT; Sat, 22 Jun 2024 08:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzWB-0007oF-Hb
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:55 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzW9-0000Kt-6v
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:55 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3636c572257so2544605f8f.0
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2024 05:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719058012; x=1719662812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zaC8IIbLHsxQsiW8y62vNZ0UWZAgeZUGk/0zUMHijyY=;
 b=Ye0VkwoBdmj+K2q2Pj9tVSqGVx/TJAH9Y4oOWWBRThWOZvQURV2Vkajd1LegSO3SIH
 IRUWZ+9e7ETF98ZXmb3N4By6wM37IOebH4sKM95skbC5vCOBG4Q8Dj0Lr5tBftNQ/2SU
 Tr3ks8WmVqX1il2Q/R4jXWEzSNrW14qOPk8W7VWhS/M6GvWqqXwmcKOwAk1POfYsms4J
 U5HLTy3ey3tMlb6NsYuK8o9bucWIWAi6lnPKX5UR9LCL8ucCtWpUrWTEmLB8dzQaTExj
 TvPL+HoRpLv01i1VPf9vTbcf+Ph+QJQ+G8etJfCv0DX1ge96C3h0AtzrBjo6yp8QFH2J
 /Flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719058012; x=1719662812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zaC8IIbLHsxQsiW8y62vNZ0UWZAgeZUGk/0zUMHijyY=;
 b=R3mM1MCfuO55NzcwkheICOwVUEQe1yLhZcS1wAm2X1zQrLh7eOFjhYOLJUwGhNcbhE
 V7+U4WK3Xpmp4djxbBVgxbhCGsAo+kwvlSemD2DWrvXq9SfFdd9+I90exW3EDBBB4LMG
 YSBAcwaUHMxsUUEapm89iNu7HLsGQhNrs+SS7BdsswBsa71J2RW7sl96RvdMs3cR0s8k
 lX+qvC4BVsXJ1onNz6RXdhEqBp6Fw+V5LJ5w1jydZXLVWTblg6B+0P2IHWDMPmU2ycQo
 vZbmp4hlvBlqy3TfN//8xKAT3qdRYvPnSGWHwWQLZuvcHAXKKGG065rxJVHWt/O2RaH9
 mlGw==
X-Gm-Message-State: AOJu0YytQKabuFX8tIQPfz1/kdRKfUEblCmrdGgTVT21yTkk88e5/SWz
 N+jOiosYRXAVzKO9oKtvvAlMcZhbPAGky6gWT71dJlyX5YHBOifaJPf8Q7/7I3K05GHx6XQE2eN
 afa8=
X-Google-Smtp-Source: AGHT+IGGZx5BStVf/USUskI0NbjEQN/PdTOWbbWZTTyeHFbeXal1l2ys5OlySePbd1EDD1nWEwQoWw==
X-Received: by 2002:adf:e6c9:0:b0:360:712e:3610 with SMTP id
 ffacd0b85a97d-36317c79b42mr10139005f8f.38.1719058011730; 
 Sat, 22 Jun 2024 05:06:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a2f698dsm4393006f8f.70.2024.06.22.05.06.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jun 2024 05:06:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/18] hw/arm/virt: allow creation of a second NonSecure UART
Date: Sat, 22 Jun 2024 13:06:39 +0100
Message-Id: <20240622120643.3797539-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622120643.3797539-1-peter.maydell@linaro.org>
References: <20240622120643.3797539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

For some use-cases, it is helpful to have more than one UART
available to the guest.  If the second UART slot is not already used
for a TrustZone Secure-World-only UART, create it as a NonSecure UART
only when the user provides a serial backend (e.g.  via a second
-serial command line option).

This avoids problems where existing guest software only expects a
single UART, and gets confused by the second UART in the DTB.  The
major example of this is older EDK2 firmware, which will send the
GRUB bootloader output to UART1 and the guest serial output to UART0.
Users who want to use both UARTs with a guest setup including EDK2
are advised to update to EDK2 release edk2-stable202311 or newer.
(The prebuilt EDK2 blobs QEMU upstream provides are new enough.)
The relevant EDK2 changes are the ones described here:
https://bugzilla.tianocore.org/show_bug.cgi?id=4577

Inspired-by: Axel Heider <axel.heider@hensoldt.net>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240610162343.2131524-4-peter.maydell@linaro.org
---
 docs/system/arm/virt.rst |  6 +++++-
 include/hw/arm/virt.h    |  1 +
 hw/arm/virt-acpi-build.c | 12 ++++++++----
 hw/arm/virt.c            | 38 +++++++++++++++++++++++++++++++++++---
 4 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 26fcba00b76..e67e7f0f7c5 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -26,7 +26,7 @@ The virt board supports:
 
 - PCI/PCIe devices
 - Flash memory
-- One PL011 UART
+- Either one or two PL011 UARTs for the NonSecure World
 - An RTC
 - The fw_cfg device that allows a guest to obtain data from QEMU
 - A PL061 GPIO controller
@@ -48,6 +48,10 @@ The virt board supports:
   - A secure flash memory
   - 16MB of secure RAM
 
+The second NonSecure UART only exists if a backend is configured
+explicitly (e.g. with a second -serial command line option) and
+TrustZone emulation is not enabled.
+
 Supported guest CPU types:
 
 - ``cortex-a7`` (32-bit)
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 1227e7f7f08..ab961bb6a9b 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -151,6 +151,7 @@ struct VirtMachineState {
     bool ras;
     bool mte;
     bool dtb_randomness;
+    bool second_ns_uart_present;
     OnOffAuto acpi;
     VirtGICType gic_version;
     VirtIOMMUType iommu;
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index eb5796e309b..b2366f24f96 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -79,11 +79,11 @@ static void acpi_dsdt_add_cpus(Aml *scope, VirtMachineState *vms)
 }
 
 static void acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
-                                           uint32_t uart_irq)
+                               uint32_t uart_irq, int uartidx)
 {
-    Aml *dev = aml_device("COM0");
+    Aml *dev = aml_device("COM%d", uartidx);
     aml_append(dev, aml_name_decl("_HID", aml_string("ARMH0011")));
-    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
+    aml_append(dev, aml_name_decl("_UID", aml_int(uartidx)));
 
     Aml *crs = aml_resource_template();
     aml_append(crs, aml_memory32_fixed(uart_memmap->base,
@@ -817,7 +817,11 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     scope = aml_scope("\\_SB");
     acpi_dsdt_add_cpus(scope, vms);
     acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0],
-                       (irqmap[VIRT_UART0] + ARM_SPI_BASE));
+                       (irqmap[VIRT_UART0] + ARM_SPI_BASE), 0);
+    if (vms->second_ns_uart_present) {
+        acpi_dsdt_add_uart(scope, &memmap[VIRT_UART1],
+                           (irqmap[VIRT_UART1] + ARM_SPI_BASE), 1);
+    }
     if (vmc->acpi_expose_flash) {
         acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
     }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ffb4983885f..85556152563 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -906,7 +906,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
 }
 
 static void create_uart(const VirtMachineState *vms, int uart,
-                        MemoryRegion *mem, Chardev *chr)
+                        MemoryRegion *mem, Chardev *chr, bool secure)
 {
     char *nodename;
     hwaddr base = vms->memmap[uart].base;
@@ -944,6 +944,8 @@ static void create_uart(const VirtMachineState *vms, int uart,
         qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", nodename);
     } else {
         qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial1", nodename);
+    }
+    if (secure) {
         /* Mark as not usable by the normal world */
         qemu_fdt_setprop_string(ms->fdt, nodename, "status", "disabled");
         qemu_fdt_setprop_string(ms->fdt, nodename, "secure-status", "okay");
@@ -2317,11 +2319,41 @@ static void machvirt_init(MachineState *machine)
 
     fdt_add_pmu_nodes(vms);
 
-    create_uart(vms, VIRT_UART0, sysmem, serial_hd(0));
+    /*
+     * The first UART always exists. If the security extensions are
+     * enabled, the second UART also always exists. Otherwise, it only exists
+     * if a backend is configured explicitly via '-serial <backend>'.
+     * This avoids potentially breaking existing user setups that expect
+     * only one NonSecure UART to be present (for instance, older EDK2
+     * binaries).
+     *
+     * The nodes end up in the DTB in reverse order of creation, so we must
+     * create UART0 last to ensure it appears as the first node in the DTB,
+     * for compatibility with guest software that just iterates through the
+     * DTB to find the first UART, as older versions of EDK2 do.
+     * DTB readers that follow the spec, as Linux does, should honour the
+     * aliases node information and /chosen/stdout-path regardless of
+     * the order that nodes appear in the DTB.
+     *
+     * For similar back-compatibility reasons, if UART1 is the secure UART
+     * we create it second (and so it appears first in the DTB), because
+     * that's what QEMU has always done.
+     */
+    if (!vms->secure) {
+        Chardev *serial1 = serial_hd(1);
+
+        if (serial1) {
+            vms->second_ns_uart_present = true;
+            create_uart(vms, VIRT_UART1, sysmem, serial1, false);
+        }
+    }
+    create_uart(vms, VIRT_UART0, sysmem, serial_hd(0), false);
+    if (vms->secure) {
+        create_uart(vms, VIRT_UART1, secure_sysmem, serial_hd(1), true);
+    }
 
     if (vms->secure) {
         create_secure_ram(vms, secure_sysmem, secure_tag_sysmem);
-        create_uart(vms, VIRT_UART1, secure_sysmem, serial_hd(1));
     }
 
     if (tag_sysmem) {
-- 
2.34.1


