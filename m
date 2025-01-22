Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9D5C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 18:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tafAO-0001Ek-B3; Wed, 22 Jan 2025 13:09:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tafAI-0001E0-9W
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 13:09:23 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tafAG-0001Hf-Jw
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 13:09:21 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 9DF05A42889;
 Wed, 22 Jan 2025 18:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E421EC4CED3;
 Wed, 22 Jan 2025 18:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737569357;
 bh=nyrSvwvP3M/xDkbHeJbnzvTRT3BD49s5rUgSjhsGlPQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gTXOCYu5JFGsJfgx9sW8jI1jFC7rZwBL1w3Z5KqdVSAcN4Ou/jNpnvJ5zAZKNUKT8
 g0bqIndqXWPQcWdCKe8q/kwFv9Y1A2KiC0VKbEGln4aSQCUZJBq0zG9SsepCyNfBG8
 JcgLd1AJVSTisc2zyDNMVIFnJ5sb+Q0QJcQFnZg3a51WYA5Zda3yIbHrzLQkbgezAL
 1T3xxi6C/jTfVXEQxsqv92gxCoV09K8mUdcuSQ3QYgzAaYjhr3QGEcKPJqlA3TDmr+
 sWRa23b+p6+AiL9v1sKgdLK+WwpHq1cyB5e5swcRib0ixFCfGBjQUVe1LZB0+fmwuv
 Jj144tJ0lR8iw==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 1/2] hw/hppa: Support up to 256 GiB RAM on 64-bit machines
Date: Wed, 22 Jan 2025 19:09:12 +0100
Message-ID: <20250122180913.18667-2-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250122180913.18667-1-deller@kernel.org>
References: <20250122180913.18667-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=deller@kernel.org; helo=nyc.source.kernel.org
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

Allow up to 256 GB RAM, which is the maximum a rp8440 machine (the very
last 64-bit PA-RISC machine) physically supports.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/hppa_hardware.h |  2 ++
 hw/hppa/machine.c       | 26 +++++++++++++++++++-------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
index a9be7bb851..a276240967 100644
--- a/hw/hppa/hppa_hardware.h
+++ b/hw/hppa/hppa_hardware.h
@@ -49,4 +49,6 @@
 #define CPU_HPA_CR_REG  7       /* store CPU HPA in cr7 (SeaBIOS internal) */
 #define PIM_STORAGE_SIZE 600	/* storage size of pdc_pim_toc_struct (64bit) */
 
+#define RAM_MAP_HIGH  0x0100000000  /* memory above 3.75 GB is mapped here */
+
 #endif
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 8230f43e41..4bcc66cd6f 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -283,16 +283,13 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
         cpu[i] = HPPA_CPU(cpu_create(machine->cpu_type));
     }
 
-    /*
-     * For now, treat address layout as if PSW_W is clear.
-     * TODO: create a proper hppa64 board model and load elf64 firmware.
-     */
+    /* Initialize memory */
     if (hppa_is_pa20(&cpu[0]->env)) {
         translate = translate_pa20;
-        ram_max = 0xf0000000;      /* 3.75 GB (limited by 32-bit firmware) */
+        ram_max = 256 * GiB;       /* like HP rp8440 */
     } else {
         translate = translate_pa10;
-        ram_max = 0xf0000000;      /* 3.75 GB (32-bit CPU) */
+        ram_max = FIRMWARE_START;  /* 3.75 GB (32-bit CPU) */
     }
 
     soft_power_reg = translate(NULL, HPA_POWER_BUTTON);
@@ -320,7 +317,22 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
         info_report("Max RAM size limited to %" PRIu64 " MB", ram_max / MiB);
         machine->ram_size = ram_max;
     }
-    memory_region_add_subregion_overlap(addr_space, 0, machine->ram, -1);
+    if (machine->ram_size <= FIRMWARE_START) {
+        /* contiguous memory up to 3.75 GB RAM */
+        memory_region_add_subregion_overlap(addr_space, 0, machine->ram, -1);
+    } else {
+        /* non-contiguous: Memory above 3.75 GB is mapped at RAM_MAP_HIGH */
+        MemoryRegion *mem_region;
+        mem_region = g_new(MemoryRegion, 2);
+        memory_region_init_alias(&mem_region[0], &addr_space->parent_obj,
+                              "LowMem", machine->ram, 0, FIRMWARE_START);
+        memory_region_init_alias(&mem_region[1], &addr_space->parent_obj,
+                              "HighMem", machine->ram, FIRMWARE_START,
+                              machine->ram_size - FIRMWARE_START);
+        memory_region_add_subregion_overlap(addr_space, 0, &mem_region[0], -1);
+        memory_region_add_subregion_overlap(addr_space, RAM_MAP_HIGH,
+                                            &mem_region[1], -1);
+    }
 
     return translate;
 }
-- 
2.47.0


