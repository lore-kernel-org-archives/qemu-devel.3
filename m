Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8EEC0218C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 18:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tafAR-0001FS-2P; Wed, 22 Jan 2025 13:09:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tafAN-0001ET-2D
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 13:09:27 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tafAG-0001Hz-PS
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 13:09:26 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id EB3D15C5807;
 Wed, 22 Jan 2025 18:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34068C4CED2;
 Wed, 22 Jan 2025 18:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737569359;
 bh=MzWUDml3Pamg2cGR5MkDCjpAy+lkVpxOz1kL+37m3LM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sj1Uq4THQcQYv76UGD07d+7BrYo0fFmNKK9I1AQwIZXer7Dt9ZqTSXkm2qtKalKY7
 CiJZHZB8HDWUa3tUvEVpbOALrItoUlDcrWbuJIMxDES6T1AueGTuBttiDPkMBmIr9F
 ndXOjZCI4puX8/pn55MoTuWUMmqvcT6KPK0xK6cKoJULp0ApSOgle6QeGilAy8Bu8i
 a22gEJAXhFOcb7os/V2Z+DgUHDeiClNplBv1NrUPtglP/mNpPQJcfrwAIClrdwqJXk
 uEZqSU2rHr8g9CfiwtvdWOfX4+OcStE6ATDGQCE6TtJNyqAtNNjhTqWaC0gxpTfH9u
 gJSu70SKsB5LQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 2/2] hw/hppa: Fix booting Linux kernel with initrd
Date: Wed, 22 Jan 2025 19:09:13 +0100
Message-ID: <20250122180913.18667-3-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250122180913.18667-1-deller@kernel.org>
References: <20250122180913.18667-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Helge Deller <deller@gmx.de>

Commit 20f7b890173b ("hw/hppa: Reset vCPUs calling resettable_reset()")
broke booting the Linux kernel with initrd which may have been provided
on the command line. The problem is, that the mentioned commit zeroes
out initial registers which were preset with addresses for the Linux
kernel and initrd.

Fix it by adding proper variables which are set shortly before starting
the firmware.

Signed-off-by: Helge Deller <deller@gmx.de>
Fixes: 20f7b890173b ("hw/hppa: Reset vCPUs calling resettable_reset()")
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/hppa/machine.c | 48 +++++++++++++++++++----------------------------
 target/hppa/cpu.h |  4 ++++
 2 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 4bcc66cd6f..0dd1908214 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -356,7 +356,6 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     uint64_t kernel_entry = 0, kernel_low, kernel_high;
     MemoryRegion *addr_space = get_system_memory();
     MemoryRegion *rom_region;
-    unsigned int smp_cpus = machine->smp.cpus;
     SysBusDevice *s;
 
     /* SCSI disk setup. */
@@ -482,8 +481,8 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
                       kernel_low, kernel_high, kernel_entry, size / KiB);
 
         if (kernel_cmdline) {
-            cpu[0]->env.gr[24] = 0x4000;
-            pstrcpy_targphys("cmdline", cpu[0]->env.gr[24],
+            cpu[0]->env.cmdline_or_bootorder = 0x4000;
+            pstrcpy_targphys("cmdline", cpu[0]->env.cmdline_or_bootorder,
                              TARGET_PAGE_SIZE, kernel_cmdline);
         }
 
@@ -513,32 +512,22 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
             }
 
             load_image_targphys(initrd_filename, initrd_base, initrd_size);
-            cpu[0]->env.gr[23] = initrd_base;
-            cpu[0]->env.gr[22] = initrd_base + initrd_size;
+            cpu[0]->env.initrd_base = initrd_base;
+            cpu[0]->env.initrd_end  = initrd_base + initrd_size;
         }
     }
 
     if (!kernel_entry) {
         /* When booting via firmware, tell firmware if we want interactive
-         * mode (kernel_entry=1), and to boot from CD (gr[24]='d')
-         * or hard disc * (gr[24]='c').
+         * mode (kernel_entry=1), and to boot from CD (cmdline_or_bootorder='d')
+         * or hard disc (cmdline_or_bootorder='c').
          */
         kernel_entry = machine->boot_config.has_menu ? machine->boot_config.menu : 0;
-        cpu[0]->env.gr[24] = machine->boot_config.order[0];
+        cpu[0]->env.cmdline_or_bootorder = machine->boot_config.order[0];
     }
 
-    /* We jump to the firmware entry routine and pass the
-     * various parameters in registers. After firmware initialization,
-     * firmware will start the Linux kernel with ramdisk and cmdline.
-     */
-    cpu[0]->env.gr[26] = machine->ram_size;
-    cpu[0]->env.gr[25] = kernel_entry;
-
-    /* tell firmware how many SMP CPUs to present in inventory table */
-    cpu[0]->env.gr[21] = smp_cpus;
-
-    /* tell firmware fw_cfg port */
-    cpu[0]->env.gr[19] = FW_CFG_IO_BASE;
+    /* Keep initial kernel_entry for first boot */
+    cpu[0]->env.kernel_entry = kernel_entry;
 }
 
 /*
@@ -675,18 +664,19 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
         cpu[i]->env.gr[5] = CPU_HPA + i * 0x1000;
     }
 
-    /* already initialized by machine_hppa_init()? */
-    if (cpu[0]->env.gr[26] == ms->ram_size) {
-        return;
-    }
-
     cpu[0]->env.gr[26] = ms->ram_size;
-    cpu[0]->env.gr[25] = 0; /* no firmware boot menu */
-    cpu[0]->env.gr[24] = 'c';
-    /* gr22/gr23 unused, no initrd while reboot. */
+    cpu[0]->env.gr[25] = cpu[0]->env.kernel_entry;
+    cpu[0]->env.gr[24] = cpu[0]->env.cmdline_or_bootorder;
+    cpu[0]->env.gr[23] = cpu[0]->env.initrd_base;
+    cpu[0]->env.gr[22] = cpu[0]->env.initrd_end;
     cpu[0]->env.gr[21] = smp_cpus;
-    /* tell firmware fw_cfg port */
     cpu[0]->env.gr[19] = FW_CFG_IO_BASE;
+
+    /* reset static fields to avoid starting Linux kernel & initrd on reboot */
+    cpu[0]->env.kernel_entry = 0;
+    cpu[0]->env.initrd_base = 0;
+    cpu[0]->env.initrd_end = 0;
+    cpu[0]->env.cmdline_or_bootorder = 'c';
 }
 
 static void hppa_nmi(NMIState *n, int cpu_index, Error **errp)
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 083d4f5a56..beea42d105 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -268,6 +268,10 @@ typedef struct CPUArchState {
     struct {} end_reset_fields;
 
     bool is_pa20;
+
+    target_ulong kernel_entry; /* Linux kernel was loaded here */
+    target_ulong cmdline_or_bootorder;
+    target_ulong initrd_base, initrd_end;
 } CPUHPPAState;
 
 /**
-- 
2.47.0


