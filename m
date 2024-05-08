Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AD4C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lVr-0001BR-4U; Wed, 08 May 2024 13:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s4lVl-0001AR-8l
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:55:25 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s4lVi-00028I-PW
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:55:24 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-51f71e4970bso5512693e87.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715190921; x=1715795721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qfdYiD64f+4cUowLihzuANf2MWyPtIwpg/YL0XZS8FI=;
 b=EJvy0TyWO2YpeOIj5NVBl28w5L+VzHrof9qPZXuqCD6Cas4Jro3nvXE+cCQ9kJFAjh
 lSdNacoHyA/Tq06BVvmniczU6Hmks0KNpmbGcqjzhl5kaNAcifv8VzL/d3I1gmKnr05v
 sjImuQx6hs5N/7foVRMSyiZ6BLSDwLdu8P2s5jzkThvNr+U7PDM1XRfUPTCT8TJEEouw
 eM50pNnNq6G8RoFxXLZW5PgTUG1qosC5nTtuGA1w5IqBh7s2p3mU7KzqNDMs7+12dxHY
 0E/8H7jRXDneS/VmEMAIkD57myx3m4i4G/ITXkLkkrJM2wRYW4ntqDVYOoU05o6ha9YS
 fe9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190921; x=1715795721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qfdYiD64f+4cUowLihzuANf2MWyPtIwpg/YL0XZS8FI=;
 b=Uw+1NK/ZQzADXYKS5fHZZ/aP5Uejm3PFcXYmdGnYl6zwBswbcAzfN+QOHq/5b4I6vG
 ahnDYMwGvqefBkyXUd3d9GBQtqeulgx4LEODsi11yg7/iYDN2DPwF9WPpeNuZwSd/HK9
 sFw/XX9MzbmV9syvt6oZ2d9d0ILe6b696dCxBjJE6Qlo1G2Bhcu4oUAf8DYomazk+8fa
 ITd6N+Xir3to02At+vw85BdGDCkfylaaHkKb7Tri38iB8dVYf94hemvFo6WFjk+qra9z
 M0JvnAvSWy17fLKQtyBq1cClDU/vKcxmLogJ5cfgaiad7XjNoFoTD16bGTKN3UekYKr0
 PVow==
X-Gm-Message-State: AOJu0Yy8mHOJUseQ2Ze29WD43oR8BNeHw70QrpjWr0IyMwkgaiKgvBvo
 xNBe4o51AEPXM2OZqfDIh4JTc7CI2FCwQMuvnZRWYEk3yvd97FlqYrpoQA==
X-Google-Smtp-Source: AGHT+IFzBcCtERbNX/I0rpM/6M46ZdylCG8BoivHzOAXzt2EU0yseZtqA9sYN8P5Vv3jMN01gX96XQ==
X-Received: by 2002:ac2:5e9b:0:b0:51b:1e76:4ea9 with SMTP id
 2adb3069b0e04-5217c372edfmr2795595e87.4.1715190920400; 
 Wed, 08 May 2024 10:55:20 -0700 (PDT)
Received: from archlinux.. (dynamic-077-013-167-103.77.13.pool.telefonica.de.
 [77.13.167.103]) by smtp.gmail.com with ESMTPSA id
 a24-20020a170906671800b00a59c5a129basm4483821ejp.80.2024.05.08.10.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 10:55:19 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 3/6] hw/i386/x86: Don't leak "isa-bios" memory regions
Date: Wed,  8 May 2024 19:55:04 +0200
Message-ID: <20240508175507.22270-4-shentey@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240508175507.22270-1-shentey@gmail.com>
References: <20240508175507.22270-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x12f.google.com
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

Fix the leaking in x86_bios_rom_init() and pc_isa_bios_init() by adding an
"isa_bios" attribute to X86MachineState.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/i386/x86.h | 7 +++++++
 hw/i386/pc_sysfw.c    | 7 +++----
 hw/i386/x86.c         | 9 ++++-----
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index cb07618d19..a07de79167 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -18,6 +18,7 @@
 #define HW_I386_X86_H
 
 #include "exec/hwaddr.h"
+#include "exec/memory.h"
 
 #include "hw/boards.h"
 #include "hw/intc/ioapic.h"
@@ -52,6 +53,12 @@ struct X86MachineState {
     GMappedFile *initrd_mapped_file;
     HotplugHandler *acpi_dev;
 
+    /*
+     * Map the upper 128 KiB of the BIOS just underneath the 1 MiB address
+     * boundary.
+     */
+    MemoryRegion isa_bios;
+
     /* RAM information (sizes, addresses, configuration): */
     ram_addr_t below_4g_mem_size, above_4g_mem_size;
 
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 59c7a81692..82d37cb376 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -40,11 +40,10 @@
 
 #define FLASH_SECTOR_SIZE 4096
 
-static void pc_isa_bios_init(MemoryRegion *rom_memory,
+static void pc_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *rom_memory,
                              MemoryRegion *flash_mem)
 {
     int isa_bios_size;
-    MemoryRegion *isa_bios;
     uint64_t flash_size;
     void *flash_ptr, *isa_bios_ptr;
 
@@ -52,7 +51,6 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
 
     /* map the last 128KB of the BIOS in ISA space */
     isa_bios_size = MIN(flash_size, 128 * KiB);
-    isa_bios = g_malloc(sizeof(*isa_bios));
     memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
                            &error_fatal);
     memory_region_add_subregion_overlap(rom_memory,
@@ -136,6 +134,7 @@ void pc_system_flash_cleanup_unused(PCMachineState *pcms)
 static void pc_system_flash_map(PCMachineState *pcms,
                                 MemoryRegion *rom_memory)
 {
+    X86MachineState *x86ms = X86_MACHINE(pcms);
     hwaddr total_size = 0;
     int i;
     BlockBackend *blk;
@@ -185,7 +184,7 @@ static void pc_system_flash_map(PCMachineState *pcms,
 
         if (i == 0) {
             flash_mem = pflash_cfi01_get_memory(system_flash);
-            pc_isa_bios_init(rom_memory, flash_mem);
+            pc_isa_bios_init(&x86ms->isa_bios, rom_memory, flash_mem);
 
             /* Encrypt the pflash boot ROM */
             if (sev_enabled()) {
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 6d3c72f124..457e8a34a5 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -1133,7 +1133,7 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
 {
     const char *bios_name;
     char *filename;
-    MemoryRegion *bios, *isa_bios;
+    MemoryRegion *bios;
     int bios_size, isa_bios_size;
     ssize_t ret;
 
@@ -1173,14 +1173,13 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
 
     /* map the last 128KB of the BIOS in ISA space */
     isa_bios_size = MIN(bios_size, 128 * KiB);
-    isa_bios = g_malloc(sizeof(*isa_bios));
-    memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
+    memory_region_init_alias(&x86ms->isa_bios, NULL, "isa-bios", bios,
                              bios_size - isa_bios_size, isa_bios_size);
     memory_region_add_subregion_overlap(rom_memory,
                                         0x100000 - isa_bios_size,
-                                        isa_bios,
+                                        &x86ms->isa_bios,
                                         1);
-    memory_region_set_readonly(isa_bios, !isapc_ram_fw);
+    memory_region_set_readonly(&x86ms->isa_bios, !isapc_ram_fw);
 
     /* map all the bios at the top of memory */
     memory_region_add_subregion(rom_memory,
-- 
2.45.0


