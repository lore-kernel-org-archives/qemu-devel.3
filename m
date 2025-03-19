Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3827C35FF1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 06:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tumgl-0006iM-G3; Wed, 19 Mar 2025 02:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tumgi-0006dK-KE; Wed, 19 Mar 2025 02:14:00 -0400
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tumgg-0001Rc-MT; Wed, 19 Mar 2025 02:14:00 -0400
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tumgd-000AD9-1P; Wed, 19 Mar 2025 07:13:55 +0100
Received: from [82.100.198.138] (helo=mail.embedded-brains.de)
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tumgd-000I7J-0x; Wed, 19 Mar 2025 07:13:55 +0100
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id D6E77480106;
 Wed, 19 Mar 2025 07:13:54 +0100 (CET)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 267qyMjTO4Py; Wed, 19 Mar 2025 07:13:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 88AC64800A8;
 Wed, 19 Mar 2025 07:13:54 +0100 (CET)
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id P0MBitYUNzmu; Wed, 19 Mar 2025 07:13:54 +0100 (CET)
Received: from zimbra.eb.localhost (unknown [10.10.171.10])
 by mail.embedded-brains.de (Postfix) with ESMTPSA id 5AE624800A3;
 Wed, 19 Mar 2025 07:13:53 +0100 (CET)
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, "Alistair Francis" <alistair23@gmail.com>,
 "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>
Subject: [PATCH v3 3/6] hw/riscv: Make FDT optional for MPFS
Date: Wed, 19 Mar 2025 07:13:35 +0100
Message-ID: <20250319061342.26435-4-sebastian.huber@embedded-brains.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319061342.26435-1-sebastian.huber@embedded-brains.de>
References: <20250319061342.26435-1-sebastian.huber@embedded-brains.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: smtp-embedded@poldi-networks.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27581/Tue Mar 18 14:04:32 2025)
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

Real-time kernels such as RTEMS or Zephyr may use a static device tree
built into the kernel image.  Do not require to use the -dtb option if
-kernel is used for the microchip-icicle-kit machine.  Issue a warning
if no device tree is provided by the user since the machine does not
generate one.

Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
---
 hw/riscv/microchip_pfsoc.c | 56 +++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index f477d2791e..844dc0545c 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -516,7 +516,6 @@ static void microchip_icicle_kit_machine_init(Machine=
State *machine)
     uint64_t mem_low_size, mem_high_size;
     hwaddr firmware_load_addr;
     const char *firmware_name;
-    bool kernel_as_payload =3D false;
     target_ulong firmware_end_addr, kernel_start_addr;
     uint64_t kernel_entry;
     uint64_t fdt_load_addr;
@@ -589,25 +588,12 @@ static void microchip_icicle_kit_machine_init(Machi=
neState *machine)
      *
      * This ensures backwards compatibility with how we used to expose -=
bios
      * to users but allows them to run through direct kernel booting as =
well.
-     *
-     * When -kernel is used for direct boot, -dtb must be present to pro=
vide
-     * a valid device tree for the board, as we don't generate device tr=
ee.
      */
=20
-    if (machine->kernel_filename && machine->dtb) {
-        int fdt_size;
-        machine->fdt =3D load_device_tree(machine->dtb, &fdt_size);
-        if (!machine->fdt) {
-            error_report("load_device_tree() failed");
-            exit(1);
-        }
-
+    if (machine->kernel_filename) {
         firmware_name =3D RISCV64_BIOS_BIN;
         firmware_load_addr =3D memmap[MICROCHIP_PFSOC_DRAM_LO].base;
-        kernel_as_payload =3D true;
-    }
-
-    if (!kernel_as_payload) {
+    } else {
         firmware_name =3D BIOS_FILENAME;
         firmware_load_addr =3D RESET_VECTOR;
     }
@@ -617,7 +603,7 @@ static void microchip_icicle_kit_machine_init(Machine=
State *machine)
                                                      &firmware_load_addr=
, NULL);
=20
     riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
-    if (kernel_as_payload) {
+    if (machine->kernel_filename) {
         kernel_start_addr =3D riscv_calc_kernel_start_addr(&boot_info,
                                                          firmware_end_ad=
dr);
=20
@@ -625,19 +611,33 @@ static void microchip_icicle_kit_machine_init(Machi=
neState *machine)
                           true, NULL);
         kernel_entry =3D boot_info.image_low_addr;
=20
-        /* Compute the fdt load address in dram */
-        hwaddr kernel_ram_base =3D memmap[MICROCHIP_PFSOC_DRAM_LO].base;
-        hwaddr kernel_ram_size =3D memmap[MICROCHIP_PFSOC_DRAM_LO].size;
-
-        if (kernel_entry - kernel_ram_base >=3D kernel_ram_size) {
-            kernel_ram_base =3D memmap[MICROCHIP_PFSOC_DRAM_HI].base;
-            kernel_ram_size =3D mem_high_size;
+        if (machine->dtb) {
+            int fdt_size;
+            machine->fdt =3D load_device_tree(machine->dtb, &fdt_size);
+            if (!machine->fdt) {
+                error_report("load_device_tree() failed");
+                exit(1);
+            }
+
+            /* Compute the FDT load address in DRAM */
+            hwaddr kernel_ram_base =3D memmap[MICROCHIP_PFSOC_DRAM_LO].b=
ase;
+            hwaddr kernel_ram_size =3D memmap[MICROCHIP_PFSOC_DRAM_LO].s=
ize;
+
+            if (kernel_entry - kernel_ram_base >=3D kernel_ram_size) {
+                kernel_ram_base =3D memmap[MICROCHIP_PFSOC_DRAM_HI].base=
;
+                kernel_ram_size =3D mem_high_size;
+            }
+
+            fdt_load_addr =3D riscv_compute_fdt_addr(kernel_ram_base, ke=
rnel_ram_size,
+                                                   machine, &boot_info);
+            riscv_load_fdt(fdt_load_addr, machine->fdt);
+        } else {
+            warn_report_once("The QEMU microchip-icicle-kit machine does=
 not "
+                             "generate a device tree, so no device tree =
is "
+                             "being provided to the guest.");
+            fdt_load_addr =3D 0;
         }
=20
-        fdt_load_addr =3D riscv_compute_fdt_addr(kernel_ram_base, kernel=
_ram_size,
-                                               machine, &boot_info);
-        riscv_load_fdt(fdt_load_addr, machine->fdt);
-
         /* Load the reset vector */
         riscv_setup_rom_reset_vec(machine, &s->soc.u_cpus, firmware_load=
_addr,
                                   memmap[MICROCHIP_PFSOC_ENVM_DATA].base=
,
--=20
2.43.0


