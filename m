Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9750606A32A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQQzH-0000ry-V5; Mon, 09 Nov 2026 10:08:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.lamprecht@proxmox.com>)
 id 1xQQzC-0000rH-Bd
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 10:08:42 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.lamprecht@proxmox.com>)
 id 1xQQzA-0008D8-C2
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 10:08:42 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 855D844FFF;
 Mon, 09 Nov 2026 16:08:33 +0100 (CET)
From: Thomas Lamprecht <t.lamprecht@proxmox.com>
To: qemu-devel@nongnu.org
Cc: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH for-11.2 1/2] hw/i386: move PC_FW_DATA to x86.h as X86_FW_DATA
Date: Mon,  9 Nov 2026 10:33:42 +0100
Message-ID: <20261109150753.1727674-2-t.lamprecht@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109150753.1727674-1-t.lamprecht@proxmox.com>
References: <20261109150753.1727674-1-t.lamprecht@proxmox.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1794236912759
Received-SPF: pass client-ip=94.136.29.106;
 envelope-from=t.lamprecht@proxmox.com; helo=proxmox-new.maurer-it.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The size of the memory that the firmware uses at the top of RAM is
passed to x86_load_linux(), which the microvm machine uses as well.
Move it next to that function, so that microvm, which can be built
without the PC machines, can use it too. No functional change.

Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
---
 hw/i386/pc.c          | 14 ++------------
 include/hw/i386/x86.h | 10 ++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4737eb471c..09ef6d0783 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -185,16 +185,6 @@ const size_t pc_compat_4_2_len = G_N_ELEMENTS(pc_compat_4_2);
 GlobalProperty pc_compat_4_1[] = {};
 const size_t pc_compat_4_1_len = G_N_ELEMENTS(pc_compat_4_1);
 
-/*
- * @PC_FW_DATA:
- * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
- * and other BIOS datastructures.
- *
- * BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K
- * reported to be used at the moment, 32K should be enough for a while.
- */
-#define PC_FW_DATA (0x20000 + 0x8000)
-
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
 {
     GSIState *s;
@@ -576,7 +566,7 @@ void xen_load_linux(PCMachineState *pcms)
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
     rom_set_fw(fw_cfg);
 
-    x86_load_linux(x86ms, fw_cfg, PC_FW_DATA);
+    x86_load_linux(x86ms, fw_cfg, X86_FW_DATA);
     for (i = 0; i < nb_option_roms; i++) {
         assert(!strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
                !strcmp(option_rom[i].name, "pvh.bin") ||
@@ -910,7 +900,7 @@ void pc_memory_init(PCMachineState *pcms,
     }
 
     if (linux_boot) {
-        x86_load_linux(x86ms, fw_cfg, PC_FW_DATA);
+        x86_load_linux(x86ms, fw_cfg, X86_FW_DATA);
     }
 
     for (i = 0; i < nb_option_roms; i++) {
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index abb073ca47..14251d5bb9 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -127,6 +127,16 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
                        MemoryRegion *rom_memory, bool isapc_ram_fw);
 void x86_bios_rom_reload(X86MachineState *x86ms);
 
+/*
+ * @X86_FW_DATA:
+ * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
+ * and other BIOS datastructures.
+ *
+ * BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K
+ * reported to be used at the moment, 32K should be enough for a while.
+ */
+#define X86_FW_DATA (0x20000 + 0x8000)
+
 void x86_load_linux(X86MachineState *x86ms,
                     FWCfgState *fw_cfg,
                     int acpi_data_size);
-- 
2.47.3



