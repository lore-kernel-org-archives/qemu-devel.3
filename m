Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F531D64060
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 23:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVenA-0001Dd-8R; Tue, 16 Dec 2025 18:49:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vVen0-0001BL-UK
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 18:49:13 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vVemy-0006lo-KN
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 18:49:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=HQ/9L5rNO3zjZ1NHaoFq2/XxX4vXgnW07fih0NsZedM=; b=TuHzuUXJSPFcLpd
 43a7vHcSOTOAIIDGAtmq5Ui74+nyNHPaAQJD5vV0DMT2kjcyF34vVTjP/l4yjTIT3w2hj5guSYnku
 EYsZOtQKqdTLRlcPLJSyL8lfNbUpO8M718luxmxJY1QubgCH5/as17aafDZ6MqBw58ram9T2zzfTP
 dI=;
Date: Wed, 17 Dec 2025 00:51:12 +0100
Subject: [PATCH 07/14] target/riscv: Replace TYPE_RISCV_CPU_BASE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-hw-riscv-cpu-int-v1-7-d24a4048d3aa@rev.ng>
References: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
In-Reply-To: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, philmd@linaro.org, 
 pierrick.bouvier@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

TYPE_RISCV_CPU_BASE is used only to initialize the correct default
machine for 3 machines. Replace it with a runtime check.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/hw/riscv/virt.h         | 11 +++++++++++
 target/riscv/cpu.h              |  6 ------
 hw/riscv/microblaze-v-generic.c |  3 ++-
 hw/riscv/spike.c                |  3 ++-
 hw/riscv/virt.c                 |  2 +-
 5 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 7b4c2c8b7d..3a17641078 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -19,6 +19,7 @@
 #ifndef HW_RISCV_VIRT_H
 #define HW_RISCV_VIRT_H
 
+#include "qemu/target-info.h"
 #include "hw/boards.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/sysbus.h"
@@ -137,6 +138,16 @@ bool virt_is_iommu_sys_enabled(RISCVVirtState *s);
 void virt_acpi_setup(RISCVVirtState *vms);
 uint32_t imsic_num_bits(uint32_t count);
 
+static inline const char *virt_default_cpu_type(void)
+{
+    if (target_riscv64()) {
+        return TYPE_RISCV_CPU_BASE64;
+    } else {
+        return TYPE_RISCV_CPU_BASE32;
+    }
+}
+
+
 /*
  * The virt machine physical address space used by some of the devices
  * namely ACLINT, PLIC, APLIC, and IMSIC depend on number of Sockets,
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 616406f07f..da2bc554d3 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -39,12 +39,6 @@ typedef struct CPUArchState CPURISCVState;
 
 #define CPU_RESOLVING_TYPE TYPE_RISCV_CPU
 
-#if defined(TARGET_RISCV32)
-# define TYPE_RISCV_CPU_BASE            TYPE_RISCV_CPU_BASE32
-#elif defined(TARGET_RISCV64)
-# define TYPE_RISCV_CPU_BASE            TYPE_RISCV_CPU_BASE64
-#endif
-
 /*
  * b0: Whether a instruction always raise a store AMO or not.
  */
diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index 0df276f9fb..0222ff0c06 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -26,6 +26,7 @@
 #include "hw/char/xilinx_uartlite.h"
 #include "hw/misc/unimp.h"
 #include "hw/riscv/machines-qom.h"
+#include "hw/riscv/virt.h"
 
 #define LMB_BRAM_SIZE (128 * KiB)
 #define MEMORY_BASEADDR 0x80000000
@@ -183,7 +184,7 @@ static void mb_v_generic_machine_init(MachineClass *mc)
     mc->init = mb_v_generic_init;
     mc->min_cpus = 1;
     mc->max_cpus = 1;
-    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
+    mc->default_cpu_type = virt_default_cpu_type();
     mc->default_cpus = 1;
 }
 
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 69eb3dfc24..7d1a642a78 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -34,6 +34,7 @@
 #include "hw/riscv/boot.h"
 #include "hw/riscv/numa.h"
 #include "hw/riscv/machines-qom.h"
+#include "hw/riscv/virt.h"
 #include "hw/char/riscv_htif.h"
 #include "hw/intc/riscv_aclint.h"
 #include "chardev/char.h"
@@ -351,7 +352,7 @@ static void spike_machine_class_init(ObjectClass *oc, const void *data)
     mc->init = spike_board_init;
     mc->max_cpus = SPIKE_CPUS_MAX;
     mc->is_default = true;
-    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
+    mc->default_cpu_type = virt_default_cpu_type();
     mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
     mc->get_default_cpu_node_id = riscv_numa_get_default_cpu_node_id;
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index f42fffb223..6f6164e05d 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1922,7 +1922,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     mc->desc = "RISC-V VirtIO board";
     mc->init = virt_machine_init;
     mc->max_cpus = VIRT_CPUS_MAX;
-    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
+    mc->default_cpu_type = virt_default_cpu_type();
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
     mc->pci_allow_0_address = true;

-- 
2.51.0


