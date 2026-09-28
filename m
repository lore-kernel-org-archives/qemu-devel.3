Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0951CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBACC-0002Bu-I4; Mon, 28 Sep 2026 08:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kaloz@kernel.org>) id 1xB9ZL-0006Vg-H5
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 07:30:55 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kaloz@kernel.org>) id 1xB9ZI-0001we-Ig
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 07:30:51 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2420C601F7
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 11:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485A41F000FF
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 11:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790595037;
 bh=IAAzLgxiLQ+y2/sMSN2Du/cynTkLmseeh7hD9BG0I8Q=;
 h=From:To:Subject:Date;
 b=Wof1PpoK+F298dyqtMuko0++ZeHlQGojRpkkNP08aB9kFYyFjmRLtpQqLTziXJey9
 BGpauD6MBkzDALpyn+EFPIKFEJoV5fdcNMmJwYQ2ScDZdPExFtX7sCahVcU+QdW+Xo
 9hdBR/vmpEldPLYaqRfoI6MnNYGRvWG0EHC5Yj9tihva4EIF40SwCyeM1gAz/Umqlr
 Xi+39dKA0mlplJ/VRa9IqKvY+DD25E1i0bAdK1xs8lnTmdovumXbMASIeZ/PuK8UVJ
 VDxBS6grbnoKFy3vc7pNePONmeyWf22R6/oFQWNLfk4B5BDbBD47lyWdY/B9952Z/9
 eIelGUgB/wo+Q==
From: Imre Kaloz <kaloz@kernel.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/sparc/sun4m: Limit max_mem to what the memory controllers
 decode
Date: Mon, 28 Sep 2026 13:29:35 +0200
Message-ID: <20260928112935.19447-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=kaloz@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:10:58 -0400
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

The SS-10, SS-20 and SPARCserver 600MP accept -m up to 60 GiB, and the
LX, SS-4, SPARCclassic and Voyager accept 256 MiB, more than any of
these machines could hold. On the SS-10, SS-20 and 600MP, sizes above
the hardware limit fall into three ranges:

- Up to 4 GiB, QEMU maps the RAM, but no real machine could hold it.
- From 4 GiB, the size wraps around in the firmware. QEMU passes it as
  an 8-byte fw_cfg item, but the sparc32 OpenBIOS reads only its low
  32 bits, so -m 5120 boots as if it were -m 1024.
- Above about 56 GiB, the RAM also overlaps the SBus devices, which
  start at 0xe20000000 (TCX).

Set each limit from the real hardware:

- The SS-10 and SS-20 memory controllers (EMC and SMC) decode eight
  SIMM slots as 64 MiB windows from 29 DRAM address bits, 512 MiB in
  total (Sun patent EP0571099).
- The SPARCserver 600MP takes at max 1 GiB, onboard plus expansion
  boards (SPARCsystem 600MP service manual, 800-5318).
- The SS-4 takes at most 160 MiB in its five SIMM slots.
- The LX and SPARCclassic use the microSPARC-I on-chip controller,
  which decodes four 32 MiB banks, 128 MiB.
- The Voyager has 16 MiB onboard and two slots for 16 or 32 MiB cards,
  80 MiB. Its default RAM size becomes 80 MiB, so -M Voyager without
  -m still starts.
- The SPARCbook model gets 128 MiB, the decode limit of its
  microSPARC-I. This keeps QEMU's default -m of 128 MiB working and
  does not describe a real SPARCbook configuration.

Machines without ECC map an empty slot so that accesses to missing RAM
do not fault. It now ends at iommu_base, where memory decode ends on
those machines, rather than at max_mem.

Update the maximum memory sizes in docs/system/target-sparc.rst.

Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 docs/system/target-sparc.rst |  6 ++++--
 hw/sparc/sun4m.c             | 24 ++++++++++++++----------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/docs/system/target-sparc.rst b/docs/system/target-sparc.rst
index 4116cac493..de0acc76dc 100644
--- a/docs/system/target-sparc.rst
+++ b/docs/system/target-sparc.rst
@@ -52,8 +52,10 @@ QEMU emulates the following sun4m peripherals:
 -  CS4231 sound device (only on SS-5, not working yet)
 
 The number of peripherals is fixed in the architecture. Maximum memory
-size depends on the machine type, for SS-5 it is 256MB and for others
-2047MB.
+size depends on the machine type: 512 MiB for the SS-10 and SS-20,
+256 MiB for the SS-5, 160 MiB for the SS-4, 128 MiB for the LX,
+SPARCclassic and SPARCbook, 80 MiB for the Voyager, and 1 GiB for the
+SPARCserver 600MP.
 
 Since version 0.8.2, QEMU uses OpenBIOS https://www.openbios.org/.
 OpenBIOS is a free (GPL v2) portable firmware implementation. The goal
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 550acdff6d..c586b1c44e 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -840,10 +840,13 @@ static void sun4m_hw_init(MachineState *machine)
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0);
 
-    /* models without ECC don't trap when missing ram is accessed */
+    /*
+     * models without ECC don't trap when missing ram is accessed,
+     * up to the end of memory decode at iommu_base
+     */
     if (!hwdef->ecc_base) {
         empty_slot_init("ecc", machine->ram_size,
-                        hwdef->max_mem - machine->ram_size);
+                        hwdef->iommu_base - machine->ram_size);
     }
 
     prom_init(hwdef->slavio_base, machine->firmware);
@@ -1174,7 +1177,7 @@ static void ss10_class_init(ObjectClass *oc, const void *data)
         .nvram_machine_id = 0x72,
         .machine_id = ss10_id,
         .iommu_version = 0x03000000,
-        .max_mem = 0xf00000000ULL,
+        .max_mem = 0x20000000, /* 512M: EMC has 29 DRAM address bits */
     };
 
     mc->desc = "Sun4m platform, SPARCstation 10";
@@ -1207,7 +1210,7 @@ static void ss600mp_class_init(ObjectClass *oc, const void *data)
         .nvram_machine_id = 0x71,
         .machine_id = ss600mp_id,
         .iommu_version = 0x01000000,
-        .max_mem = 0xf00000000ULL,
+        .max_mem = 0x40000000, /* 1G: onboard plus expansion boards */
     };
 
     mc->desc = "Sun4m platform, SPARCserver 600MP";
@@ -1258,7 +1261,7 @@ static void ss20_class_init(ObjectClass *oc, const void *data)
         .nvram_machine_id = 0x72,
         .machine_id = ss20_id,
         .iommu_version = 0x13000000,
-        .max_mem = 0xf00000000ULL,
+        .max_mem = 0x20000000, /* 512M: SMC has 29 DRAM address bits */
     };
 
     mc->desc = "Sun4m platform, SPARCstation 20";
@@ -1291,11 +1294,12 @@ static void voyager_class_init(ObjectClass *oc, const void *data)
         .nvram_machine_id = 0x80,
         .machine_id = vger_id,
         .iommu_version = 0x05000000,
-        .max_mem = 0x10000000,
+        .max_mem = 0x05000000, /* 80M: 16M onboard plus two 32M cards */
     };
 
     mc->desc = "Sun4m platform, SPARCstation Voyager";
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Fujitsu-MB86904");
+    mc->default_ram_size = 80 * MiB;
     smc->hwdef = &voyager_hwdef;
 }
 
@@ -1324,7 +1328,7 @@ static void ss_lx_class_init(ObjectClass *oc, const void *data)
         .nvram_machine_id = 0x80,
         .machine_id = lx_id,
         .iommu_version = 0x04000000,
-        .max_mem = 0x10000000,
+        .max_mem = 0x08000000, /* 128M: microSPARC-I on-chip controller */
     };
 
     mc->desc = "Sun4m platform, SPARCstation LX";
@@ -1357,7 +1361,7 @@ static void ss4_class_init(ObjectClass *oc, const void *data)
         .nvram_machine_id = 0x80,
         .machine_id = ss4_id,
         .iommu_version = 0x05000000,
-        .max_mem = 0x10000000,
+        .max_mem = 0x0a000000, /* 160M: 5 SIMM slots */
     };
 
     mc->desc = "Sun4m platform, SPARCstation 4";
@@ -1389,7 +1393,7 @@ static void scls_class_init(ObjectClass *oc, const void *data)
         .nvram_machine_id = 0x80,
         .machine_id = scls_id,
         .iommu_version = 0x05000000,
-        .max_mem = 0x10000000,
+        .max_mem = 0x08000000, /* 128M: microSPARC-I on-chip controller */
     };
 
     mc->desc = "Sun4m platform, SPARCClassic";
@@ -1421,7 +1425,7 @@ static void sbook_class_init(ObjectClass *oc, const void *data)
         .nvram_machine_id = 0x80,
         .machine_id = sbook_id,
         .iommu_version = 0x05000000,
-        .max_mem = 0x10000000,
+        .max_mem = 0x08000000, /* 128M: microSPARC-I on-chip controller */
     };
 
     mc->desc = "Sun4m platform, SPARCbook";
-- 
2.47.3


