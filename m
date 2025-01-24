Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F1EFC0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 19:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbPkZ-0003Xl-1D; Fri, 24 Jan 2025 14:53:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tbPkX-0003Up-54
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 14:53:53 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tbPkV-0004b2-Gc
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 14:53:52 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id C3089A41D67;
 Fri, 24 Jan 2025 19:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34B7C4CED2;
 Fri, 24 Jan 2025 19:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737748429;
 bh=Th9t3g0zpK9CG7Q/pwb+jyn5riaLFm0lmHOeXZWJFJ0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Dix7xf2v6uLtlsFXMO4E8hIb5zZmqc9UzAXzyjygjI3vr9duXTPmfVFGE7YrBAzm0
 jndZI3v/YkAC9Rcki1FRPVbMcCRo8GU47HjNL8o0Z/kkalyLLZ6Kf1n1lIZAvqpbaC
 hcf2oc6iPiLC9HjCKGKV4UpNRUNb5QglyJLl2/gUfBjzfbrAAaP6JxSNTvJJE/5vFZ
 z9jbi/S5+R8HGGHmVllql919cee9Jai/M39XvtaX74tSo9rLwAz1zbucWL00C/vxKR
 U5KckgxgA+aR3JdXMxhkR1LFI7gTxnG6Wl7je0YJHSwRuk6PmNzPHG0SR5wcY2OrMc
 fWh7cvahJvrVA==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 1/2] hw/hppa: Support up to 256 GiB RAM on 64-bit machines
Date: Fri, 24 Jan 2025 20:53:44 +0100
Message-ID: <20250124195345.15118-2-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250124195345.15118-1-deller@kernel.org>
References: <20250124195345.15118-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.75.193.91; envelope-from=deller@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Allow up to 256 GB RAM, which is the maximum a rp8440 machine (the very
last 64-bit PA-RISC machine) physically supports.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


