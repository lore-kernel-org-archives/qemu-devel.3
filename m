Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C7E606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 22:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W3UhUFIZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMCRX-0001uH-CU; Wed, 28 Oct 2026 18:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xMCRW-0001u8-Dq
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 18:48:26 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xMCRU-0007cr-Pb
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 18:48:26 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D513B42E9D;
 Wed, 28 Oct 2026 22:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBE11F01825;
 Wed, 28 Oct 2026 22:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793227703;
 bh=18S4xiqd0zh/+ecdsNiuR0/WNpS+taOR9QWxO/S66Jo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=W3UhUFIZdwhgBdrwZjLCHyWCuztDvetbV954De5X8+EEKJh1L9NMeQ+ZKhVwg6tv2
 +T6uvdMWPgu1zl9OA+rvBkYgaLP2WgZGzUC/HYZB1u4SEWYfLYra5cilJ7aM/vOmhR
 qSks4b/0wbRJhXVavLkJz4QP546zdq2csMO5bE3+BJSYJ5hPVT4N6I0KoqHvcXJrDE
 qXG8vx/KhqfjPQH/xSMf49AXi1dggd/tStk2Jlc8hW2ZyXo243pO0OCZY0JNf3TU0r
 BbkW55ZXZbgtMFUlId906VEJkhxnG/IRzMwQuiOB+Ze5eYrs8UPfMIDPuzM8lAo5HR
 f36vgInpm2tOg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Keith Monahan <keith@techtravels.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 3/4] hw/hppa: Add harmony sound card to HP 715 and B160L
 machines
Date: Wed, 28 Oct 2026 23:48:14 +0100
Message-ID: <20261028224815.32502-4-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028224815.32502-1-deller@kernel.org>
References: <20261028224815.32502-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keith Monahan <keith@techtravels.org>

Signed-off-by: Keith Monahan <keith@techtravels.org
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/Kconfig   |  1 +
 hw/hppa/machine.c | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
index 9ede4d1140..d00d7ca040 100644
--- a/hw/hppa/Kconfig
+++ b/hw/hppa/Kconfig
@@ -19,3 +19,4 @@ config HPPA_B160L
     select LSI_SCSI_PCI
     select PARALLEL
     select ARTIST
+    select HARMONY
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index f23936fc5b..940bf2c72e 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -32,6 +32,7 @@
 #include "hw/misc/lasi.h"
 #include "hw/scsi/ncr53c710.h"
 #include "hw/scsi/lasi_ncr710.h"
+#include "hw/audio/harmony.h"
 #include "hppa_hardware.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
@@ -271,6 +272,21 @@ static LasiState *lasi_init(void)
     return LASI_CHIP(dev);
 }
 
+/* Harmony audio, inside the LASI register block at LASI + 0x4000 */
+static void harmony_create(MachineState *machine, hwaddr addr, qemu_irq irq)
+{
+    DeviceState *dev = qdev_new(TYPE_HARMONY);
+
+    if (machine->audiodev) {
+        qdev_prop_set_string(dev, "audiodev", machine->audiodev);
+    }
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
+    memory_region_add_subregion_overlap(get_system_memory(), addr,
+                                        sysbus_mmio_get_region(
+                                            SYS_BUS_DEVICE(dev), 0), 1);
+}
+
 static DinoState *dino_init(MemoryRegion *addr_space)
 {
     DeviceState *dev;
@@ -699,6 +715,9 @@ static void machine_HP_715_init(MachineState *machine)
                                     sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
     }
 
+    harmony_create(machine, translate(NULL, LASI_HPA_715 + LASI_AUDIO),
+                   qdev_get_gpio_in(lasi_dev, LASI_IRQ_AUDIO_HPA));
+
     /* Add NICs, graphics & load firmware */
     machine_HP_common_init_tail(machine, NULL, translate, false);
 }
@@ -778,6 +797,9 @@ static void machine_HP_B160L_init(MachineState *machine)
         lsi53c8xx_handle_legacy_cmdline(dev);
     }
 
+    harmony_create(machine, translate(NULL, LASI_HPA + LASI_AUDIO),
+                   qdev_get_gpio_in(lasi_dev, LASI_IRQ_AUDIO_HPA));
+
     /* Add NICs, graphics & load firmware */
     machine_HP_common_init_tail(machine, pci_bus, translate, false);
 }
@@ -985,6 +1007,7 @@ static void HP_B160L_machine_init_class_init(ObjectClass *oc, const void *data)
     mc->init = machine_HP_B160L_init;
     mc->is_default = true;
     mc->default_ram_size = 512 * MiB;
+    machine_add_audiodev_property(mc);
 }
 
 static void HP_C3700_machine_init_class_init(ObjectClass *oc, const void *data)
@@ -1036,6 +1059,7 @@ static void HP_715_machine_init_class_init(ObjectClass *oc, const void *data)
     mc->default_cpu_type = TYPE_HPPA_CPU_PA_7300LC;
     mc->valid_cpu_types = valid_cpu_types;
     mc->init = machine_HP_715_init;
+    machine_add_audiodev_property(mc);
     /* can only support up to max. 8 CPUs due inventory major numbers */
     mc->max_cpus = MIN_CONST(HPPA_MAX_CPUS, 8);
     mc->default_ram_size = 256 * MiB;
-- 
2.54.0


