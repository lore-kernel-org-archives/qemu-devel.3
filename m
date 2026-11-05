Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0B1606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AmcDeEkI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOueI-0001w6-Vi; Thu, 05 Nov 2026 05:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xOueH-0001vD-Ot
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:24:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xOueF-0003ra-7w
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793874286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uxkG8FdSnx716mHQej0cEaVVUjxJkreNf5QXvAI+7pM=;
 b=AmcDeEkIDh3OPyn8L6g4FYopJQicz5GiPHxcKC3k5182ZLwEIZ9SxQ/2Pp/q1vz/TFismv
 y1F9Ek+cgsIxLFqUeFjW+SZuHHr4BxVMoNijaSh5qMYIoX+5cYZ+Zgg+TdwGBSjncEo3MN
 vwOnlR5JtUkXcLCe4Fsvz/PvmGXEYZY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-1HUtS2iZOnOf1vLjPUdQtw-1; Thu,
 05 Nov 2026 05:24:39 -0500
X-MC-Unique: 1HUtS2iZOnOf1vLjPUdQtw-1
X-Mimecast-MFC-AGG-ID: 1HUtS2iZOnOf1vLjPUdQtw_1793874278
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E5D41801214; Thu,  5 Nov 2026 10:24:38 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5053D187C36B; Thu,  5 Nov 2026 10:24:37 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/4] hw: replace 'is_available' with 'targets' in machines
Date: Thu,  5 Nov 2026 10:24:30 +0000
Message-ID: <20261105102432.1131493-3-berrange@redhat.com>
In-Reply-To: <20261105102432.1131493-1-berrange@redhat.com>
References: <20261105102432.1131493-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For every machine which currently has an 'is_available'
callback set on the TypeInfo, set the 'targets' field
on the MachineClass to the equivalent arch list, and
remove 'is_available'.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/arm/aspeed_ast27x0-fc.c  |  3 ++-
 hw/arm/aspeed_ast27x0_evb.c |  5 +++--
 hw/arm/raspi.c              | 21 +++++++++++++--------
 hw/arm/raspi4b.c            |  3 ++-
 hw/arm/virt.c               |  5 +++--
 hw/hexagon/virt.c           |  3 ++-
 hw/m68k/virt.c              |  4 ++--
 hw/or1k/virt.c              |  3 ++-
 hw/riscv/virt.c             |  4 +++-
 9 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 73362b60d2a..ea340c6f1cf 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -22,6 +22,7 @@
 #include "hw/arm/boot.h"
 #include "hw/block/flash.h"
 #include "hw/arm/aspeed_coprocessor.h"
+#include "qemu/base-arch-defs.h"
 
 #define TYPE_AST2700FC MACHINE_TYPE_NAME("ast2700fc")
 OBJECT_DECLARE_SIMPLE_TYPE(Ast2700FCState, AST2700FC);
@@ -226,6 +227,7 @@ static void ast2700fc_class_init(ObjectClass *oc, const void *data)
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->min_cpus = mc->max_cpus = mc->default_cpus = 6;
+    mc->targets = QEMU_ARCH_BIT(SYS_EMU_TARGET_AARCH64);
 }
 
 static const TypeInfo ast2700fc_types[] = {
@@ -234,7 +236,6 @@ static const TypeInfo ast2700fc_types[] = {
         .parent         = TYPE_MACHINE,
         .class_init     = ast2700fc_class_init,
         .instance_size  = sizeof(Ast2700FCState),
-        .is_available   = target_aarch64,
     },
 };
 
diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c
index 460c9ff0d2e..b252edc5103 100644
--- a/hw/arm/aspeed_ast27x0_evb.c
+++ b/hw/arm/aspeed_ast27x0_evb.c
@@ -11,6 +11,7 @@
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/sensor/tmp105.h"
+#include "qemu/base-arch-defs.h"
 
 /* AST2700 evb hardware value */
 /* SCU HW Strap1 */
@@ -45,6 +46,7 @@ static void aspeed_machine_ast2700a1_evb_class_init(ObjectClass *oc,
     amc->i2c_init  = ast2700_evb_i2c_init;
     amc->vbootrom = true;
     mc->default_ram_size = 1 * GiB;
+    mc->targets = QEMU_ARCH_BIT(SYS_EMU_TARGET_AARCH64);
     aspeed_machine_class_init_cpus_defaults(mc);
 }
 
@@ -67,6 +69,7 @@ static void aspeed_machine_ast2700a2_evb_class_init(ObjectClass *oc,
     amc->i2c_init  = ast2700_evb_i2c_init;
     amc->vbootrom = true;
     mc->default_ram_size = 2 * GiB;
+    mc->targets = QEMU_ARCH_BIT(SYS_EMU_TARGET_AARCH64);
     aspeed_machine_class_init_cpus_defaults(mc);
 }
 
@@ -75,13 +78,11 @@ static const TypeInfo aspeed_ast27x0_evb_types[] = {
         .name          = MACHINE_TYPE_NAME("ast2700a1-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a1_evb_class_init,
-        .is_available  = target_aarch64,
     },
     {
         .name          = MACHINE_TYPE_NAME("ast2700a2-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a2_evb_class_init,
-        .is_available  = target_aarch64,
     }
 };
 
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index fadbacb2534..b1d2eece2c0 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -25,6 +25,8 @@
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
 #include "qom/object.h"
+#include "qemu/base-arch-defs.h"
+
 
 #define TYPE_RASPI_MACHINE  MACHINE_TYPE_NAME("raspi-common")
 OBJECT_DECLARE_SIMPLE_TYPE(RaspiMachineState, RASPI_MACHINE)
@@ -330,10 +332,15 @@ void raspi_machine_class_common_init(MachineClass *mc,
 };
 
 static void raspi_machine_class_init(MachineClass *mc,
-                                     uint32_t board_rev)
+                                     uint32_t board_rev,
+                                     bool arch64bitonly)
 {
     raspi_machine_class_common_init(mc, board_rev);
     mc->init = raspi_machine_init;
+    mc->targets = QEMU_ARCH_BIT(SYS_EMU_TARGET_AARCH64);
+    if (!arch64bitonly) {
+        mc->targets |= QEMU_ARCH_BIT(SYS_EMU_TARGET_ARM);
+    }
 };
 
 static void raspi0_machine_class_init(ObjectClass *oc, const void *data)
@@ -343,7 +350,7 @@ static void raspi0_machine_class_init(ObjectClass *oc, const void *data)
 
     mc->auto_create_sdcard = true;
     rmc->board_rev = 0x920092; /* Revision 1.2 */
-    raspi_machine_class_init(mc, rmc->board_rev);
+    raspi_machine_class_init(mc, rmc->board_rev, false);
 };
 
 static void raspi1ap_machine_class_init(ObjectClass *oc, const void *data)
@@ -353,7 +360,7 @@ static void raspi1ap_machine_class_init(ObjectClass *oc, const void *data)
 
     mc->auto_create_sdcard = true;
     rmc->board_rev = 0x900021; /* Revision 1.1 */
-    raspi_machine_class_init(mc, rmc->board_rev);
+    raspi_machine_class_init(mc, rmc->board_rev, false);
 };
 
 static void raspi2b_machine_class_init(ObjectClass *oc, const void *data)
@@ -363,7 +370,7 @@ static void raspi2b_machine_class_init(ObjectClass *oc, const void *data)
 
     mc->auto_create_sdcard = true;
     rmc->board_rev = 0xa21041;
-    raspi_machine_class_init(mc, rmc->board_rev);
+    raspi_machine_class_init(mc, rmc->board_rev, false);
 };
 
 static void raspi3ap_machine_class_init(ObjectClass *oc, const void *data)
@@ -373,7 +380,7 @@ static void raspi3ap_machine_class_init(ObjectClass *oc, const void *data)
 
     mc->auto_create_sdcard = true;
     rmc->board_rev = 0x9020e0; /* Revision 1.0 */
-    raspi_machine_class_init(mc, rmc->board_rev);
+    raspi_machine_class_init(mc, rmc->board_rev, true);
 };
 
 static void raspi3b_machine_class_init(ObjectClass *oc, const void *data)
@@ -383,7 +390,7 @@ static void raspi3b_machine_class_init(ObjectClass *oc, const void *data)
 
     mc->auto_create_sdcard = true;
     rmc->board_rev = 0xa02082;
-    raspi_machine_class_init(mc, rmc->board_rev);
+    raspi_machine_class_init(mc, rmc->board_rev, true);
 };
 
 static const TypeInfo raspi_machine_types[] = {
@@ -403,12 +410,10 @@ static const TypeInfo raspi_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("raspi3ap"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3ap_machine_class_init,
-        .is_available   = target_aarch64,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3b_machine_class_init,
-        .is_available   = target_aarch64,
     }, {
         .name           = TYPE_RASPI_MACHINE,
         .parent         = TYPE_RASPI_BASE_MACHINE,
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 600dfe686f2..92c3f580f96 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -21,6 +21,7 @@
 #include "hw/arm/boot.h"
 #include "qom/object.h"
 #include "hw/arm/bcm2838.h"
+#include "qemu/base-arch-defs.h"
 #include <libfdt.h>
 
 #define TYPE_RASPI4B_MACHINE MACHINE_TYPE_NAME("raspi4b")
@@ -93,6 +94,7 @@ static void raspi4b_machine_class_init(ObjectClass *oc, const void *data)
     raspi_machine_class_common_init(mc, rmc->board_rev);
     mc->auto_create_sdcard = true;
     mc->init = raspi4b_machine_init;
+    mc->targets = QEMU_ARCH_BIT(SYS_EMU_TARGET_AARCH64);
 }
 
 static const TypeInfo raspi4b_machine_type = {
@@ -100,7 +102,6 @@ static const TypeInfo raspi4b_machine_type = {
     .parent         = TYPE_RASPI_BASE_MACHINE,
     .instance_size  = sizeof(Raspi4bMachineState),
     .class_init     = raspi4b_machine_class_init,
-    .is_available   = target_aarch64,
 };
 
 static void raspi4b_machine_register_type(void)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0b11f7e328c..bd38e3262a4 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -94,6 +94,7 @@
 #include "hw/cxl/cxl_host.h"
 #include "qemu/guest-random.h"
 #include "hw/watchdog/sbsa_gwdt.h"
+#include "qemu/base-arch-defs.h"
 
 static GlobalProperty arm_virt_compat_defaults[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
@@ -131,7 +132,6 @@ static void arm_virt_compat_default_set(MachineClass *mc)
         .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
         .parent = TYPE_VIRT_MACHINE, \
         .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
-        .is_available = target_base_arm, \
         .secure = true, \
     }; \
     static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
@@ -4204,6 +4204,8 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     hc->unplug = virt_machine_device_unplug_cb;
     mc->nvdimm_supported = true;
     mc->smp_props.clusters_supported = true;
+    mc->targets = QEMU_ARCH_BIT(SYS_EMU_TARGET_AARCH64) |
+        QEMU_ARCH_BIT(SYS_EMU_TARGET_ARM);
 
     /* Supported caches */
     mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L1D] = true;
@@ -4444,7 +4446,6 @@ static const TypeInfo virt_machine_info = {
          { TYPE_HOTPLUG_HANDLER },
          { }
     },
-    .is_available = target_base_arm,
 };
 
 static void machvirt_machine_init(void)
diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
index d8e91770595..57ef8b5e736 100644
--- a/hw/hexagon/virt.c
+++ b/hw/hexagon/virt.c
@@ -17,6 +17,7 @@
 #include "qemu/units.h"
 #include "machine_cfg_v68n_1024.h.inc"
 #include "system/device_tree.h"
+#include "qemu/base-arch-defs.h"
 
 enum {
     VIRT_UART0,
@@ -115,6 +116,7 @@ static void virt_class_init(ObjectClass *oc, const void *data)
     mc->no_cdrom = 1;
     mc->numa_mem_supported = false;
     mc->default_nic = "virtio-mmio-bus";
+    mc->targets = QEMU_ARCH_BIT(SYS_EMU_TARGET_HEXAGON);
 }
 
 
@@ -123,7 +125,6 @@ static const TypeInfo virt_machine_types[] = { {
     .parent = TYPE_HEXAGON_COMMON_MACHINE,
     .instance_size = sizeof(HexagonVirtMachineState),
     .class_init = virt_class_init,
-    .is_available = target_hexagon,
 } };
 
 DEFINE_TYPES(virt_machine_types)
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index e52546e4fab..f35eac74147 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -36,6 +36,7 @@
 #include "hw/intc/goldfish_pic.h"
 #include "hw/virtio/virtio-mmio.h"
 #include "hw/virtio/virtio-blk.h"
+#include "qemu/base-arch-defs.h"
 
 /*
  * 6 goldfish-pic for CPU IRQ #1 to IRQ #6
@@ -320,6 +321,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     mc->no_floppy = 1;
     mc->no_parallel = 1;
     mc->default_ram_id = "m68k_virt.ram";
+    mc->targets = QEMU_ARCH_BIT(SYS_EMU_TARGET_M68K);
 }
 
 static const TypeInfo virt_machine_info = {
@@ -327,7 +329,6 @@ static const TypeInfo virt_machine_info = {
     .parent       = TYPE_MACHINE,
     .abstract     = true,
     .class_init   = virt_machine_class_init,
-    .is_available = target_m68k,
 };
 
 static void virt_machine_register_types(void)
@@ -355,7 +356,6 @@ type_init(virt_machine_register_types)
         .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
         .parent = MACHINE_TYPE_NAME("virt"), \
         .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
-        .is_available = target_m68k, \
     }; \
     static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
     { \
diff --git a/hw/or1k/virt.c b/hw/or1k/virt.c
index a3ff903839b..f5580f3c3da 100644
--- a/hw/or1k/virt.c
+++ b/hw/or1k/virt.c
@@ -28,6 +28,7 @@
 #include "system/system.h"
 #include "system/qtest.h"
 #include "system/reset.h"
+#include "qemu/base-arch-defs.h"
 
 #include <libfdt.h>
 
@@ -552,6 +553,7 @@ static void openrisc_virt_machine_init(ObjectClass *oc, const void *data)
     mc->max_cpus = VIRT_CPUS_MAX;
     mc->is_default = false;
     mc->default_cpu_type = OPENRISC_CPU_TYPE_NAME("or1200");
+    mc->targets = QEMU_ARCH_BIT(SYS_EMU_TARGET_OR1K);
 }
 
 static const TypeInfo or1ksim_machine_typeinfo = {
@@ -559,7 +561,6 @@ static const TypeInfo or1ksim_machine_typeinfo = {
     .parent     = TYPE_MACHINE,
     .class_init = openrisc_virt_machine_init,
     .instance_size = sizeof(OR1KVirtState),
-    .is_available = target_or1k,
 };
 
 static void or1ksim_machine_init_register_types(void)
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 8bc5a7b0728..6b3d6a764f3 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -61,6 +61,7 @@
 #include "qapi/qapi-type-infos-common.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/uefi/var-service-api.h"
+#include "qemu/base-arch-defs.h"
 
 #include "aia.h"
 
@@ -1140,6 +1141,8 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     mc->default_ram_id = "riscv_virt_board.ram";
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
+    mc->targets = QEMU_ARCH_BIT(SYS_EMU_TARGET_RISCV64) |
+        QEMU_ARCH_BIT(SYS_EMU_TARGET_RISCV32);
 
     hc->plug = virt_machine_device_plug_cb;
 
@@ -1195,7 +1198,6 @@ static const TypeInfo virt_machine_typeinfo = {
     .instance_init = virt_machine_instance_init,
     .instance_finalize = virt_machine_instance_finalize,
     .instance_size = sizeof(RISCVVirtState),
-    .is_available = target_base_riscv,
     .interfaces = (const InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
          { }
-- 
2.56.0


