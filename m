Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633B6C54FDF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 09:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpNH5-0004ac-RC; Thu, 30 Jul 2026 05:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@ecloud.org>) id 1wpNH4-0004aU-4C
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 05:41:58 -0400
Received: from dog.birch.relay.mailchannels.net ([23.83.209.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@ecloud.org>) id 1wpNH2-0006XT-1t
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 05:41:57 -0400
X-Sender-Id: dreamhost|x-authsender|lists@ecloud.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 39B5B4C0F10
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 09:41:52 +0000 (UTC)
Received: from pdx1-sub0-mail-a238.dreamhost.com
 (100-108-70-151.trex-nlb.outbound.svc.cluster.local [100.108.70.151])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id BBC494C05F2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 09:41:51 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|lists@ecloud.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|lists@ecloud.org
X-MailChannels-Auth-Id: dreamhost
X-Whimsical-Abortive: 4c9637965ba1ade8_1785404511974_4080542544
X-MC-Loop-Signature: 1785404511974:2802692051
X-MC-Ingress-Time: 1785404511974
Received: from pdx1-sub0-mail-a238.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.108.70.151 (trex/8.0.2); Thu, 30 Jul 2026 09:41:51 +0000
Received: from zen (55a42392.bb.online.no [85.164.35.146])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: lists@ecloud.org)
 by pdx1-sub0-mail-a238.dreamhost.com (Postfix) with ESMTPSA id 4h9kk711fmz104L
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 02:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ecloud.org;
 s=dreamhost; t=1785404511;
 bh=WViL1EMWLU+Kff/et70zoHllixe0Hpz9AyIvFg/wGhs=;
 h=Date:From:To:Subject:Content-Type;
 b=czD9Ze9XIIRR3fK4B+BTDaR9hijvqhUl1KeETOZPy6B+Vg0ud548IBH5TSuVrfxm+
 Y7ArCyn7s1da33uURZ2QeEEZHAJc+du1HCOHiOG+kSh7Ca8dSyLTcg3d9JWqTq703o
 cI1/TLKJ4AlCiWVgoeVW7PykS2+Dz/4nWn0OhOFHTwdxvrpzZpdkWZgzgegf6th3Kj
 ZrnF+Z/1ddZJJrscgb3vowonS4BpUpAEDFt1A/XCoiTx9LWgpvUjM2qGSdesdsrUju
 HI+JC1vYRC+R6mh9YTfmkN1iD2OGXZp3ZUG57lmD8cWdpj2wBj+JlWGSnpW7B2lqWm
 UEAOCAhHLTdiw==
Date: Thu, 30 Jul 2026 11:41:47 +0200
From: Shawn Rutledge <lists@ecloud.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/riscv/virt: add dram-base machine property
Message-ID: <amscWwQvYUftUYW8@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=23.83.209.48; envelope-from=lists@ecloud.org;
 helo=dog.birch.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The 'virt' RISC-V machine hardcodes its DRAM base to 0x80000000.
Real-world RISC-V SoCs put DRAM elsewhere (SpacemiT K1 at 0x40000000,
SpacemiT K3 at 0x100000000, etc.), which forces ports that target
those boards to build separate kernels for QEMU testing.

Add a 'dram-base' string property that lets users move VIRT_DRAM up
without rebuilding QEMU.  Values must be 2 MiB-aligned and at or
above the default 0x80000000 to avoid colliding with statically-
placed MMIO regions (PCIE_MMIO ends at 0x80000000).  Lower bases
would also require moving PCIE_MMIO/IMSIC/etc. and are rejected with
an explicit error pointing at the cause.

Example:
  qemu-system-riscv64 -machine virt,dram-base=0x100000000 -m 6G ...
runs OpenSBI at firmware base 0x100000000, matching K3 memory layout.

Signed-off-by: Shawn Rutledge <s@ecloud.org>
---
 hw/riscv/virt.c         | 59 ++++++++++++++++++++++++++++++++++++++++-
 include/hw/riscv/virt.h |  2 ++
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 51bac47a91..6ccc98842f 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
@@ -1307,7 +1308,13 @@ static void virt_machine_init(MachineState *machine)
     int i, base_hartid, hart_count;
     int socket_count = riscv_socket_count(machine);
 
-    s->memmap = virt_memmap;
+    if (s->dram_base) {
+        s->memmap_storage = g_memdup2(virt_memmap, sizeof(virt_memmap));
+        s->memmap_storage[VIRT_DRAM].base = s->dram_base;
+        s->memmap = s->memmap_storage;
+    } else {
+        s->memmap = virt_memmap;
+    }
 
     /* Check socket count limit */
     if (VIRT_SOCKETS_MAX < socket_count) {
@@ -1545,6 +1552,7 @@ static void virt_machine_instance_finalize(Object *obj)
     }
     g_free(s->oem_id);
     g_free(s->oem_table_id);
+    g_free(s->memmap_storage);
 }
 
 static void virt_machine_instance_init(Object *obj)
@@ -1616,6 +1624,46 @@ static void virt_set_aia(Object *obj, const char *val, Error **errp)
     }
 }
 
+static char *virt_get_dram_base(Object *obj, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
+    uint64_t val = s->dram_base ? s->dram_base : virt_memmap[VIRT_DRAM].base;
+
+    return g_strdup_printf("0x%" PRIx64, val);
+}
+
+static void virt_set_dram_base(Object *obj, const char *val, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
+    const char *endptr;
+    uint64_t base;
+
+    if (qemu_strtou64(val, &endptr, 0, &base) < 0 || *endptr != '\0') {
+        error_setg(errp, "Invalid dram-base value '%s'", val);
+        return;
+    }
+    /*
+     * DRAM must clear all statically-placed MMIO regions in virt_memmap[]
+     * (PCIE_MMIO ends at 0x80000000) and be 2 MiB-aligned so a standard
+     * OpenSBI + kernel layout (firmware at base, kernel at base+0x200000)
+     * fits.  Values below the default base would collide with on-board
+     * MMIO and are rejected.
+     */
+    if (base < virt_memmap[VIRT_DRAM].base) {
+        error_setg(errp,
+                   "dram-base 0x%" PRIx64 " is below default 0x%" PRIx64
+                   "; would collide with static MMIO regions",
+                   base, (uint64_t)virt_memmap[VIRT_DRAM].base);
+        return;
+    }
+    if (base & (2 * MiB - 1)) {
+        error_setg(errp, "dram-base 0x%" PRIx64 " must be 2 MiB-aligned",
+                   base);
+        return;
+    }
+    s->dram_base = base;
+}
+
 static bool virt_get_aclint(Object *obj, Error **errp)
 {
     RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
@@ -1744,6 +1792,15 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
 #endif
 
+    object_class_property_add_str(oc, "dram-base", virt_get_dram_base,
+                                  virt_set_dram_base);
+    object_class_property_set_description(oc, "dram-base",
+                                          "Base physical address of DRAM "
+                                          "(default 0x80000000). Must be "
+                                          "2 MiB-aligned and at or above "
+                                          "the default to avoid colliding "
+                                          "with statically-placed MMIO.");
+
     object_class_property_add_bool(oc, "aclint", virt_get_aclint,
                                    virt_set_aclint);
     object_class_property_set_description(oc, "aclint",
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 36a2def410..be8a4ac049 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -61,6 +61,8 @@ struct RISCVVirtState {
     char *oem_table_id;
     OnOffAuto acpi;
     const MemMapEntry *memmap;
+    MemMapEntry *memmap_storage; /* g_malloc'd copy when dram-base override is set */
+    uint64_t dram_base;          /* 0 = use compiled-in default (0x80000000) */
     struct GPEXHost *gpex_host;
     OnOffAuto iommu_sys;
     uint16_t pci_iommu_bdf;
-- 
2.55.0


