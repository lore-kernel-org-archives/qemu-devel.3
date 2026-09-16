Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB39C982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6liv-0001qe-Dz; Wed, 16 Sep 2026 05:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1x6liQ-0001HG-C8; Wed, 16 Sep 2026 05:14:06 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1x6liO-000891-16; Wed, 16 Sep 2026 05:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=+VTfntIU9uou9ZfefmBvu3VI8x4/ddAIbRY9yjJncTA=; b=YD83mRhK4zHbP1b
 bj9br60Stla8cZ0e8s34hgqXf4l0013JiSwQdjCTB+pqGDAOnY5fp6+NLWhWJrmZVA5LqGONuupBL
 XQjEL+eEQALaIWOXV2ARK4ztzpUdqmaf5x5yRDRcax0vv3jZwc1T8r6CfXVKBSMzftSewN8GMzSXT
 ac=;
Date: Wed, 16 Sep 2026 11:19:06 +0200
Subject: [PATCH v4 11/12] hw/riscv: Filter for 32- or 64-bit machine types
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-hw-riscv-cpu-int-v4-11-babc367b60f5@rev.ng>
References: <20260916-hw-riscv-cpu-int-v4-0-babc367b60f5@rev.ng>
In-Reply-To: <20260916-hw-riscv-cpu-int-v4-0-babc367b60f5@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789550353; l=7032;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=Cb0MmmPN5MbBMjkSIF4842/I1+vyR0PcWQAnD8NIPVQ=;
 b=5bIyPUdACyQUgj8nknDix0qjIryytZtQp8kKN3FvvLS8ME3fFlkvYdxAYN5Gcf9dtMq60h8KK
 WMM+wx7y4UoAJnXDEJDdIzYcf15SRHKu6nL5mYxPJnaHLQGnxbOCCZz
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Filters for 32- or 64-bit machine types using TypeInfo::is_available,
machines available for both 32-bit and 64-bit (amd-microblaze-v-generic,
sifive-[e|u], spike, virt) leave the field unset.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 hw/riscv/boston-aia.c      | 3 ++-
 hw/riscv/k230.c            | 3 +++
 hw/riscv/microchip_pfsoc.c | 3 +++
 hw/riscv/opentitan.c       | 3 +++
 hw/riscv/shakti_c.c        | 3 +++
 hw/riscv/tt_atlantis.c     | 3 +++
 hw/riscv/xiangshan_kmh.c   | 3 +++
 7 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index b90da096ea..e8371ff1f1 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qemu/units.h"
 
 #include "hw/core/boards.h"
@@ -473,4 +474,4 @@ static void boston_mach_class_init(MachineClass *mc)
     mc->default_cpu_type = TYPE_RISCV_CPU_MIPS_P8700;
 }
 
-DEFINE_MACHINE("boston-aia", boston_mach_class_init)
+DEFINE_MACHINE_WITH_GUARD("boston-aia", boston_mach_class_init, target_riscv64)
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 1e4ca38579..43b6ae6d2f 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -17,6 +17,7 @@
 #include "cpu-qom.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "system/device_tree.h"
 #include "system/system.h"
@@ -420,6 +421,7 @@ static const TypeInfo k230_soc_type_info = {
     .instance_size = sizeof(K230SoCState),
     .instance_init = k230_soc_init,
     .class_init = k230_soc_class_init,
+    .is_available = target_riscv64,
 };
 
 static void k230_soc_register_types(void)
@@ -558,6 +560,7 @@ static const TypeInfo k230_machine_typeinfo = {
     .class_init = k230_machine_class_init,
     .instance_init = k230_machine_instance_init,
     .instance_size = sizeof(K230MachineState),
+    .is_available = target_riscv64,
 };
 
 static void k230_machine_init_register_types(void)
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index edd29626fa..b2991e5a71 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -38,6 +38,7 @@
 #include "qemu/error-report.h"
 #include "qemu/units.h"
 #include "qemu/cutils.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "hw/core/boards.h"
@@ -504,6 +505,7 @@ static const TypeInfo microchip_pfsoc_soc_type_info = {
     .instance_size = sizeof(MicrochipPFSoCState),
     .instance_init = microchip_pfsoc_soc_instance_init,
     .class_init = microchip_pfsoc_soc_class_init,
+    .is_available = target_riscv64,
 };
 
 static void microchip_pfsoc_soc_register_types(void)
@@ -757,6 +759,7 @@ static const TypeInfo microchip_icicle_kit_machine_typeinfo = {
     .class_init = microchip_icicle_kit_machine_class_init,
     .instance_init = microchip_icicle_kit_machine_instance_init,
     .instance_size = sizeof(MicrochipIcicleKitState),
+    .is_available = target_riscv64,
 };
 
 static void microchip_icicle_kit_machine_init_register_types(void)
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 8cd660dd41..c3a563db92 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qemu/target-info.h"
 #include "hw/riscv/opentitan.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -332,11 +333,13 @@ static const TypeInfo open_titan_types[] = {
         .instance_size  = sizeof(LowRISCIbexSoCState),
         .instance_init  = lowrisc_ibex_soc_init,
         .class_init     = lowrisc_ibex_soc_class_init,
+        .is_available   = target_riscv32,
     }, {
         .name           = TYPE_OPENTITAN_MACHINE,
         .parent         = TYPE_MACHINE,
         .instance_size  = sizeof(OpenTitanState),
         .class_init     = opentitan_machine_class_init,
+        .is_available   = target_riscv32,
     }
 };
 
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index 3b6efd25be..76cfe30918 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -21,6 +21,7 @@
 #include "hw/riscv/shakti_c.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/target-info.h"
 #include "hw/intc/sifive_plic.h"
 #include "hw/intc/riscv_aclint.h"
 #include "system/system.h"
@@ -97,6 +98,7 @@ static const TypeInfo shakti_c_machine_type_info = {
     .class_init = shakti_c_machine_class_init,
     .instance_init = shakti_c_machine_instance_init,
     .instance_size = sizeof(ShaktiCMachineState),
+    .is_available = target_riscv64,
 };
 
 static void shakti_c_machine_type_info_register(void)
@@ -186,6 +188,7 @@ static const TypeInfo shakti_c_type_info = {
     .class_init = shakti_c_soc_class_init,
     .instance_init = shakti_c_soc_instance_init,
     .instance_size = sizeof(ShaktiCSoCState),
+    .is_available = target_riscv64,
 };
 
 static void shakti_c_type_info_register(void)
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index b2333e7f6a..f54eb942f3 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -11,6 +11,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/guest-random.h"
+#include "qemu/target-info.h"
 #include "qemu/units.h"
 
 #include "hw/core/boards.h"
@@ -694,11 +695,13 @@ static const TypeInfo tt_atlantis_types[] = {
         .instance_size = sizeof(TTAtlantisSoCState),
         .instance_init = tt_atlantis_soc_init,
         .class_init = tt_atlantis_soc_class_init,
+        .is_available = target_riscv64,
     }, {
         .name       = MACHINE_TYPE_NAME("tt-atlantis"),
         .parent     = TYPE_MACHINE,
         .class_init = tt_atlantis_machine_class_init,
         .instance_size = sizeof(TTAtlantisState),
+        .is_available = target_riscv64,
     },
 };
 
diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
index a234c5f352..f2383c5399 100644
--- a/hw/riscv/xiangshan_kmh.c
+++ b/hw/riscv/xiangshan_kmh.c
@@ -30,6 +30,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "system/address-spaces.h"
 #include "hw/core/boards.h"
@@ -157,6 +158,7 @@ static const TypeInfo xiangshan_kmh_soc_info = {
     .instance_size = sizeof(XiangshanKmhSoCState),
     .instance_init = xiangshan_kmh_soc_instance_init,
     .class_init = xiangshan_kmh_soc_class_init,
+    .is_available = target_riscv64,
 };
 
 static void xiangshan_kmh_soc_register_types(void)
@@ -220,6 +222,7 @@ static const TypeInfo xiangshan_kmh_machine_info = {
     .parent = TYPE_MACHINE,
     .instance_size = sizeof(XiangshanKmhState),
     .class_init = xiangshan_kmh_machine_class_init,
+    .is_available = target_riscv64,
 };
 
 static void xiangshan_kmh_machine_register_types(void)

-- 
2.52.0


