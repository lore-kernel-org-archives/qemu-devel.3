Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED649C27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 12:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKzWP-00082d-Dd; Sat, 22 Jun 2024 08:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzWB-0007nz-Gl
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:55 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzW8-0000Kc-Rj
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:54 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3645e9839b3so2111472f8f.3
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2024 05:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719058011; x=1719662811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xCNfvcSWrjHCXWaKRrShOIu0eKkr1O98HL8t2iVY3hU=;
 b=j4I+1UNMTfoJoRxGOwZLPVK1K7Hq9ABR+Ze/E0lvDkVT5YjuIc8Rb/Ga4eNi+sD2g5
 IgOrCxtxLYPaYp8ZtiWIpFfuBqm7dbwTzmj4gr0dcDvTylXGSPOl+FpM9bYnMKH7PW+T
 e5DvipameysDK+WZ4JypFGQnV4Tk0rs4CKVzpQSVP6mK3NbsqGl/zGvzGZ+wtVhroawJ
 mXF56DujZ1uG9dUJ31V2yLDtHFZEHk0zHuzbfP9Yn1HdXETli387kY9p3vUz0dlvkVn2
 cgpYAnXanYZva6CXHwzuWsbov1gJZAPiK4qhN227RlJG8qeVXPuSPgJTUXd+bELQSzg4
 aecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719058011; x=1719662811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xCNfvcSWrjHCXWaKRrShOIu0eKkr1O98HL8t2iVY3hU=;
 b=H4ddmlHgCOyUCi+evcd7EtKxMYtaaqZLNal3goE36R8YDdk714DzaY4sF94lncR8At
 vdtkVUDUL4vQMk9J2NOOXoIeTmUsg7Gim+vtyrhHuPZxUm1P7aa3ATAWuD77+ZqrdNFs
 0pf7VgSsFn/SNoUAPN9XI6pMApzsJ1qAl/IcuzuuAfWJezoYlk79hVzmlPOmnBaeGwtw
 1JlujSn5yfvAgPL1kQM8db8soTAt9Or7l//1ESOsJwWmWvb+wWYtg937Q8x/CubeWyJN
 Kh+JE7ax7kSFOkQzF9pVrX6C/eIwYd4qpD9024qLhsVVWwYyyEkgMPKJRofOmog/wxDs
 eikQ==
X-Gm-Message-State: AOJu0Yx5lMlUGiOn8wFihubr6t9W0KH7Hg1yAmgfxedX5k/VwN1++G7D
 JahmDsGrBhZnGB8xFG6gX/5/2ICjfdC8z4fM9ivNk/OjXfCl6BVh2TjCyDqVnGK99seN/edYt88
 RSm0=
X-Google-Smtp-Source: AGHT+IH7K9kue7XvNSKoeI08u2tDgtv9z8n0Y+Z12kB2XWPxNhJyLTHh5wlATJQScB2un8CbQKqKlA==
X-Received: by 2002:adf:ec8b:0:b0:362:c7b3:764c with SMTP id
 ffacd0b85a97d-366e7a479d4mr217737f8f.48.1719058011308; 
 Sat, 22 Jun 2024 05:06:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a2f698dsm4393006f8f.70.2024.06.22.05.06.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jun 2024 05:06:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/18] hw/arm/virt: Rename VIRT_UART and VIRT_SECURE_UART to
 VIRT_UART[01]
Date: Sat, 22 Jun 2024 13:06:38 +0100
Message-Id: <20240622120643.3797539-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622120643.3797539-1-peter.maydell@linaro.org>
References: <20240622120643.3797539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

We're going to make the second UART not always a secure-only device.
Rename the constants VIRT_UART and VIRT_SECURE_UART to VIRT_UART0
and VIRT_UART1 accordingly.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240610162343.2131524-3-peter.maydell@linaro.org
---
 include/hw/arm/virt.h    |  4 ++--
 hw/arm/virt-acpi-build.c | 12 ++++++------
 hw/arm/virt.c            | 14 +++++++-------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index bb486d36b14..1227e7f7f08 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -59,7 +59,7 @@ enum {
     VIRT_GIC_ITS,
     VIRT_GIC_REDIST,
     VIRT_SMMU,
-    VIRT_UART,
+    VIRT_UART0,
     VIRT_MMIO,
     VIRT_RTC,
     VIRT_FW_CFG,
@@ -69,7 +69,7 @@ enum {
     VIRT_PCIE_ECAM,
     VIRT_PLATFORM_BUS,
     VIRT_GPIO,
-    VIRT_SECURE_UART,
+    VIRT_UART1,
     VIRT_SECURE_MEM,
     VIRT_SECURE_GPIO,
     VIRT_PCDIMM_ACPI,
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index c3ccfef026f..eb5796e309b 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -440,10 +440,10 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         .base_addr.width = 32,
         .base_addr.offset = 0,
         .base_addr.size = 3,
-        .base_addr.addr = vms->memmap[VIRT_UART].base,
+        .base_addr.addr = vms->memmap[VIRT_UART0].base,
         .interrupt_type = (1 << 3),/* Bit[3] ARMH GIC interrupt*/
         .pc_interrupt = 0,         /* IRQ */
-        .interrupt = (vms->irqmap[VIRT_UART] + ARM_SPI_BASE),
+        .interrupt = (vms->irqmap[VIRT_UART0] + ARM_SPI_BASE),
         .baud_rate = 3,            /* 9600 */
         .parity = 0,               /* No Parity */
         .stop_bits = 1,            /* 1 Stop bit */
@@ -631,11 +631,11 @@ build_dbg2(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
     /* BaseAddressRegister[] */
     build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 32, 0, 3,
-                     vms->memmap[VIRT_UART].base);
+                     vms->memmap[VIRT_UART0].base);
 
     /* AddressSize[] */
     build_append_int_noprefix(table_data,
-                              vms->memmap[VIRT_UART].size, 4);
+                              vms->memmap[VIRT_UART0].size, 4);
 
     /* NamespaceString[] */
     g_array_append_vals(table_data, name, namespace_length);
@@ -816,8 +816,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
      */
     scope = aml_scope("\\_SB");
     acpi_dsdt_add_cpus(scope, vms);
-    acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
-                       (irqmap[VIRT_UART] + ARM_SPI_BASE));
+    acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0],
+                       (irqmap[VIRT_UART0] + ARM_SPI_BASE));
     if (vmc->acpi_expose_flash) {
         acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
     }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 61a9d47c026..ffb4983885f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -165,11 +165,11 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_GIC_ITS] =            { 0x08080000, 0x00020000 },
     /* This redistributor space allows up to 2*64kB*123 CPUs */
     [VIRT_GIC_REDIST] =         { 0x080A0000, 0x00F60000 },
-    [VIRT_UART] =               { 0x09000000, 0x00001000 },
+    [VIRT_UART0] =              { 0x09000000, 0x00001000 },
     [VIRT_RTC] =                { 0x09010000, 0x00001000 },
     [VIRT_FW_CFG] =             { 0x09020000, 0x00000018 },
     [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
-    [VIRT_SECURE_UART] =        { 0x09040000, 0x00001000 },
+    [VIRT_UART1] =              { 0x09040000, 0x00001000 },
     [VIRT_SMMU] =               { 0x09050000, 0x00020000 },
     [VIRT_PCDIMM_ACPI] =        { 0x09070000, MEMORY_HOTPLUG_IO_LEN },
     [VIRT_ACPI_GED] =           { 0x09080000, ACPI_GED_EVT_SEL_LEN },
@@ -212,11 +212,11 @@ static MemMapEntry extended_memmap[] = {
 };
 
 static const int a15irqmap[] = {
-    [VIRT_UART] = 1,
+    [VIRT_UART0] = 1,
     [VIRT_RTC] = 2,
     [VIRT_PCIE] = 3, /* ... to 6 */
     [VIRT_GPIO] = 7,
-    [VIRT_SECURE_UART] = 8,
+    [VIRT_UART1] = 8,
     [VIRT_ACPI_GED] = 9,
     [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
     [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
@@ -939,7 +939,7 @@ static void create_uart(const VirtMachineState *vms, int uart,
     qemu_fdt_setprop(ms->fdt, nodename, "clock-names",
                          clocknames, sizeof(clocknames));
 
-    if (uart == VIRT_UART) {
+    if (uart == VIRT_UART0) {
         qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
         qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", nodename);
     } else {
@@ -2317,11 +2317,11 @@ static void machvirt_init(MachineState *machine)
 
     fdt_add_pmu_nodes(vms);
 
-    create_uart(vms, VIRT_UART, sysmem, serial_hd(0));
+    create_uart(vms, VIRT_UART0, sysmem, serial_hd(0));
 
     if (vms->secure) {
         create_secure_ram(vms, secure_sysmem, secure_tag_sysmem);
-        create_uart(vms, VIRT_SECURE_UART, secure_sysmem, serial_hd(1));
+        create_uart(vms, VIRT_UART1, secure_sysmem, serial_hd(1));
     }
 
     if (tag_sysmem) {
-- 
2.34.1


