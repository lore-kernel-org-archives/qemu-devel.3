Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79564C4829D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 23:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZg1l-0003Rj-QF; Mon, 12 Feb 2024 18:47:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rZg1k-0003Nt-GV
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 18:47:56 -0500
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rZg1f-0000Ai-3h
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 18:47:56 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id C72FCCE17B9;
 Mon, 12 Feb 2024 23:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9191C433C7;
 Mon, 12 Feb 2024 23:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707781668;
 bh=6vagHqBoZ2ubfTZKUJlBmt9pcsuk146jYOR+LVQKiDI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SUWWxuQROHVEckTClXdTvOu57+6Y1zQAML+UNxakMYpIL7agShrEg4a2MTL2Amxeo
 mtlnV9c3EbGO0EkKA9JJ9gBeHbpyVGFF6eoKAoaCqaMdfZ8lCBcQHdRGCWFQvGXHBO
 YOu78pZ/FtVoUvmd02ZXBWeErtu7kAAz3r+Shf5V/Bm1fKJ3DNQS9BdUdHu8UL4rjp
 KCcr/b23jl8k5KdR0UcW4vQwwd4IvGOQMIBbArrx35lq6nQ0yDwJtOJx3lh8TnCkAS
 TtLS4Fwtbw6QotBwbulSagtaghw8yo/dUJuZq0At4GzI4QZGROJpX8Mzw1P9xRdLP2
 +a9PJO+I6qb8Q==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sven Schnelle <svens@stackframe.org>, Jason Wang <jasowang@redhat.com>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 12/12] hw/hppa/machine: Load 64-bit firmware on 64-bit machines
Date: Tue, 13 Feb 2024 00:47:23 +0100
Message-ID: <20240212234723.222847-13-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212234723.222847-1-deller@kernel.org>
References: <20240212234723.222847-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=deller@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Load the 64-bit SeaBIOS-hppa firmware by default when running on a 64-bit
machine. This will enable us to later support more than 4GB of RAM and is
required that the OS (or PALO bootloader) will start or install a 64-bit kernel
instead of a 32-bit kernel.

Note that SeaBIOS-hppa v16 provides the "-fw_cfg opt/OS64,string=3" option with
which the user can control what the firmware shall report back to the OS:
Support of 32-bit OS, support of a 64-bit OS, or support for both (default).

Wrap firmware loading inside !qtest_enabled() to avoid this warning with
qtest: "qemu-system-hppa: no firmware provided".

Signed-off-by: Helge Deller <deller@gmx.de>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/hppa/machine.c | 52 +++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index eb78c46ff1..5fcaf5884b 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -13,6 +13,7 @@
 #include "qemu/error-report.h"
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/qtest.h"
 #include "sysemu/runstate.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/timer/i8254.h"
@@ -333,6 +334,7 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
+    const char *firmware = machine->firmware;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     DeviceState *dev;
     PCIDevice *pci_dev;
@@ -408,31 +410,37 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
 
     /* Load firmware.  Given that this is not "real" firmware,
        but one explicitly written for the emulation, we might as
-       well load it directly from an ELF image.  */
-    firmware_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
-                                       machine->firmware ?: "hppa-firmware.img");
-    if (firmware_filename == NULL) {
-        error_report("no firmware provided");
-        exit(1);
-    }
+       well load it directly from an ELF image. Load the 64-bit
+       firmware on 64-bit machines by default if not specified
+       on command line. */
+    if (!qtest_enabled()) {
+        if (!firmware) {
+            firmware = lasi_dev ? "hppa-firmware.img" : "hppa-firmware64.img";
+        }
+        firmware_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware);
+        if (firmware_filename == NULL) {
+            error_report("no firmware provided");
+            exit(1);
+        }
 
-    size = load_elf(firmware_filename, NULL, translate, NULL,
-                    &firmware_entry, &firmware_low, &firmware_high, NULL,
-                    true, EM_PARISC, 0, 0);
+        size = load_elf(firmware_filename, NULL, translate, NULL,
+                        &firmware_entry, &firmware_low, &firmware_high, NULL,
+                        true, EM_PARISC, 0, 0);
 
-    if (size < 0) {
-        error_report("could not load firmware '%s'", firmware_filename);
-        exit(1);
-    }
-    qemu_log_mask(CPU_LOG_PAGE, "Firmware loaded at 0x%08" PRIx64
-                  "-0x%08" PRIx64 ", entry at 0x%08" PRIx64 ".\n",
-                  firmware_low, firmware_high, firmware_entry);
-    if (firmware_low < translate(NULL, FIRMWARE_START) ||
-        firmware_high >= translate(NULL, FIRMWARE_END)) {
-        error_report("Firmware overlaps with memory or IO space");
-        exit(1);
+        if (size < 0) {
+            error_report("could not load firmware '%s'", firmware_filename);
+            exit(1);
+        }
+        qemu_log_mask(CPU_LOG_PAGE, "Firmware loaded at 0x%08" PRIx64
+                      "-0x%08" PRIx64 ", entry at 0x%08" PRIx64 ".\n",
+                      firmware_low, firmware_high, firmware_entry);
+        if (firmware_low < translate(NULL, FIRMWARE_START) ||
+            firmware_high >= translate(NULL, FIRMWARE_END)) {
+            error_report("Firmware overlaps with memory or IO space");
+            exit(1);
+        }
+        g_free(firmware_filename);
     }
-    g_free(firmware_filename);
 
     rom_region = g_new(MemoryRegion, 1);
     memory_region_init_ram(rom_region, NULL, "firmware",
-- 
2.43.0


