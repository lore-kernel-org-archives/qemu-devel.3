Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600A8C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 06:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tip8M-00070c-A7; Fri, 14 Feb 2025 01:25:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tip8J-0006ww-8w
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 01:25:03 -0500
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tip8H-0003Fb-Ac
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 01:25:02 -0500
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tip8G-000LMf-0J; Fri, 14 Feb 2025 07:25:00 +0100
Received: from [82.100.198.138] (helo=mail.embedded-brains.de)
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tip8F-000NZ2-0k; Fri, 14 Feb 2025 07:24:59 +0100
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 85DDB480160;
 Fri, 14 Feb 2025 07:24:59 +0100 (CET)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id n55MAPMUVmrW; Fri, 14 Feb 2025 07:24:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 2B1FC480059;
 Fri, 14 Feb 2025 07:24:59 +0100 (CET)
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id tQwVLSpSr8IX; Fri, 14 Feb 2025 07:24:59 +0100 (CET)
Received: from zimbra.eb.localhost (unknown [10.10.171.10])
 by mail.embedded-brains.de (Postfix) with ESMTPSA id 0F40F480160;
 Fri, 14 Feb 2025 07:24:57 +0100 (CET)
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: qemu-devel@nongnu.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Bin Meng <bin.meng@windriver.com>
Subject: [PATCH 5/5] hw/riscv: Configurable MPFS CLINT timebase freq
Date: Fri, 14 Feb 2025 07:24:42 +0100
Message-ID: <20250214062443.9936-6-sebastian.huber@embedded-brains.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214062443.9936-1-sebastian.huber@embedded-brains.de>
References: <20250214062443.9936-1-sebastian.huber@embedded-brains.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: smtp-embedded@poldi-networks.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27548/Thu Feb 13 10:51:29 2025)
Received-SPF: pass client-ip=85.10.215.148;
 envelope-from=sebastian.huber@embedded-brains.de; helo=dedi548.your-server.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This property enables the setting of the CLINT timebase frequency
through the command line, for example:

  -machine microchip-icicle-kit,clint-timebase-frequency=3D10000000

Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
---
 hw/riscv/microchip_pfsoc.c         | 49 +++++++++++++++++++++++++++---
 include/hw/riscv/microchip_pfsoc.h |  1 +
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 76a2c56419..c83d588962 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -39,6 +39,7 @@
 #include "qemu/units.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
+#include "qapi/visitor.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
@@ -61,9 +62,6 @@
 #define BIOS_FILENAME   "hss.bin"
 #define RESET_VECTOR    0x20220000
=20
-/* CLINT timebase frequency */
-#define CLINT_TIMEBASE_FREQ 1000000
-
 /* GEM version */
 #define GEM_REVISION    0x0107010c
=20
@@ -193,6 +191,7 @@ static void microchip_pfsoc_soc_instance_init(Object =
*obj)
 static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
 {
     MachineState *ms =3D MACHINE(qdev_get_machine());
+    MicrochipIcicleKitState *iks =3D MICROCHIP_ICICLE_KIT_MACHINE(ms);
     MicrochipPFSoCState *s =3D MICROCHIP_PFSOC(dev);
     const MemMapEntry *memmap =3D microchip_pfsoc_memmap;
     MemoryRegion *system_memory =3D get_system_memory();
@@ -253,7 +252,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *=
dev, Error **errp)
         memmap[MICROCHIP_PFSOC_CLINT].base + RISCV_ACLINT_SWI_SIZE,
         RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, ms->smp.cpus,
         RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
-        CLINT_TIMEBASE_FREQ, false);
+        iks->clint_timebase_freq, false);
=20
     /* L2 cache controller */
     create_unimplemented_device("microchip.pfsoc.l2cc",
@@ -665,6 +664,40 @@ static void microchip_icicle_kit_machine_init(Machin=
eState *machine)
     }
 }
=20
+static void microchip_icicle_kit_set_clint_timebase_freq(Object *obj,
+                                                         Visitor *v,
+                                                         const char *nam=
e,
+                                                         void *opaque,
+                                                         Error **errp)
+{
+    MicrochipIcicleKitState *s =3D MICROCHIP_ICICLE_KIT_MACHINE(obj);
+    uint32_t value;
+
+    if (!visit_type_uint32(v, name, &value, errp)) {
+        return;
+    }
+
+    s->clint_timebase_freq =3D value;
+}
+
+static void microchip_icicle_kit_get_clint_timebase_freq(Object *obj,
+                                                         Visitor *v,
+                                                         const char *nam=
e,
+                                                         void *opaque,
+                                                         Error **errp)
+{
+    MicrochipIcicleKitState *s =3D MICROCHIP_ICICLE_KIT_MACHINE(obj);
+    uint32_t value =3D s->clint_timebase_freq;
+
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static void microchip_icicle_kit_machine_instance_init(Object *obj)
+{
+    MicrochipIcicleKitState *m =3D MICROCHIP_ICICLE_KIT_MACHINE(obj);
+    m->clint_timebase_freq =3D 1000000;
+}
+
 static void microchip_icicle_kit_machine_class_init(ObjectClass *oc, voi=
d *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
@@ -685,12 +718,20 @@ static void microchip_icicle_kit_machine_class_init=
(ObjectClass *oc, void *data)
      * See memory_tests() in mss_ddr.c in the HSS source code.
      */
     mc->default_ram_size =3D 1537 * MiB;
+
+    object_class_property_add(oc, "clint-timebase-frequency", "uint32_t"=
,
+                              microchip_icicle_kit_get_clint_timebase_fr=
eq,
+                              microchip_icicle_kit_set_clint_timebase_fr=
eq,
+                              NULL, NULL);
+    object_class_property_set_description(oc, "clint-timebase-frequency"=
,
+                                  "Set CLINT timebase frequency in Hz.")=
;
 }
=20
 static const TypeInfo microchip_icicle_kit_machine_typeinfo =3D {
     .name       =3D MACHINE_TYPE_NAME("microchip-icicle-kit"),
     .parent     =3D TYPE_MACHINE,
     .class_init =3D microchip_icicle_kit_machine_class_init,
+    .instance_init =3D microchip_icicle_kit_machine_instance_init,
     .instance_size =3D sizeof(MicrochipIcicleKitState),
 };
=20
diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microc=
hip_pfsoc.h
index daef086da6..7ca9b976c1 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -67,6 +67,7 @@ typedef struct MicrochipIcicleKitState {
     MachineState parent_obj;
=20
     /*< public >*/
+    uint32_t clint_timebase_freq;
     MicrochipPFSoCState soc;
 } MicrochipIcicleKitState;
=20
--=20
2.43.0


