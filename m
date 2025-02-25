Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792ADC021A4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 00:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmjEV-00039f-Hp; Mon, 24 Feb 2025 19:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tmjE3-0002xz-Gs; Mon, 24 Feb 2025 19:55:07 -0500
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tmjE1-0004pc-QG; Mon, 24 Feb 2025 19:55:07 -0500
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tmjE0-000HOv-0o; Tue, 25 Feb 2025 01:55:04 +0100
Received: from [82.100.198.138] (helo=mail.embedded-brains.de)
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tmjE0-0009WX-1e; Tue, 25 Feb 2025 01:55:04 +0100
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 9E3AD48005B;
 Tue, 25 Feb 2025 01:55:03 +0100 (CET)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id PH40zLJV2LXQ; Tue, 25 Feb 2025 01:55:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 5219948005D;
 Tue, 25 Feb 2025 01:55:03 +0100 (CET)
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id wMxk9Aw15X2c; Tue, 25 Feb 2025 01:55:03 +0100 (CET)
Received: from zimbra.eb.localhost (unknown [10.10.171.10])
 by mail.embedded-brains.de (Postfix) with ESMTPSA id AA7B548005B;
 Tue, 25 Feb 2025 01:55:01 +0100 (CET)
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair23@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Bin Meng <bin.meng@windriver.com>
Subject: [PATCH v2 4/6] hw/riscv: Allow direct start of kernel for MPFS
Date: Tue, 25 Feb 2025 01:54:44 +0100
Message-ID: <20250225005446.13894-5-sebastian.huber@embedded-brains.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225005446.13894-1-sebastian.huber@embedded-brains.de>
References: <20250225005446.13894-1-sebastian.huber@embedded-brains.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: smtp-embedded@poldi-networks.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27559/Mon Feb 24 10:44:14 2025)
Received-SPF: pass client-ip=85.10.215.148;
 envelope-from=sebastian.huber@embedded-brains.de; helo=dedi548.your-server.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Further customize the -bios and -kernel options behaviour for the
microchip-icicle-kit machine.  If "-bios none -kernel filename" is
specified, then do not load a firmware and instead only load and start
the kernel image.

Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
---
 hw/riscv/microchip_pfsoc.c | 57 ++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 17 deletions(-)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 844dc0545c..df902c8667 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -578,29 +578,45 @@ static void microchip_icicle_kit_machine_init(Machi=
neState *machine)
     }
=20
     /*
-     * We follow the following table to select which payload we execute.
+     * We follow the following table to select which firmware we use.
      *
-     *  -bios |    -kernel | payload
-     * -------+------------+--------
-     *      N |          N | HSS
-     *      Y | don't care | HSS
-     *      N |          Y | kernel
-     *
-     * This ensures backwards compatibility with how we used to expose -=
bios
-     * to users but allows them to run through direct kernel booting as =
well.
+     * -bios         | -kernel    | firmware
+     * --------------+------------+--------
+     * none          |          N | error
+     * none          |          Y | kernel
+     * NULL, default |          N | BIOS_FILENAME
+     * NULL, default |          Y | RISCV64_BIOS_BIN
+     * other         | don't care | other
      */
+    if (machine->firmware && !strcmp(machine->firmware, "none")) {
+        if (!machine->kernel_filename) {
+            error_report("for -bios none, a kernel is required");
+            exit(1);
+        }
=20
-    if (machine->kernel_filename) {
-        firmware_name =3D RISCV64_BIOS_BIN;
-        firmware_load_addr =3D memmap[MICROCHIP_PFSOC_DRAM_LO].base;
+        firmware_name =3D NULL;
+        firmware_load_addr =3D RESET_VECTOR;
+    } else if (!machine->firmware || !strcmp(machine->firmware, "default=
")) {
+        if (machine->kernel_filename) {
+            firmware_name =3D RISCV64_BIOS_BIN;
+            firmware_load_addr =3D memmap[MICROCHIP_PFSOC_DRAM_LO].base;
+        } else {
+            firmware_name =3D BIOS_FILENAME;
+            firmware_load_addr =3D RESET_VECTOR;
+        }
     } else {
-        firmware_name =3D BIOS_FILENAME;
+        firmware_name =3D machine->firmware;
         firmware_load_addr =3D RESET_VECTOR;
     }
=20
-    /* Load the firmware */
-    firmware_end_addr =3D riscv_find_and_load_firmware(machine, firmware=
_name,
-                                                     &firmware_load_addr=
, NULL);
+    /* Load the firmware if necessary */
+    if (firmware_name) {
+        const char *filename =3D riscv_find_firmware(firmware_name, NULL=
);
+        firmware_end_addr =3D riscv_load_firmware(filename, &firmware_lo=
ad_addr,
+                                                NULL);
+    } else {
+        firmware_end_addr =3D firmware_load_addr;
+    }
=20
     riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
     if (machine->kernel_filename) {
@@ -638,8 +654,15 @@ static void microchip_icicle_kit_machine_init(Machin=
eState *machine)
             fdt_load_addr =3D 0;
         }
=20
+        hwaddr start_addr;
+        if (firmware_name) {
+            start_addr =3D firmware_load_addr;
+        } else {
+            start_addr =3D kernel_entry;
+        }
+
         /* Load the reset vector */
-        riscv_setup_rom_reset_vec(machine, &s->soc.u_cpus, firmware_load=
_addr,
+        riscv_setup_rom_reset_vec(machine, &s->soc.u_cpus, start_addr,
                                   memmap[MICROCHIP_PFSOC_ENVM_DATA].base=
,
                                   memmap[MICROCHIP_PFSOC_ENVM_DATA].size=
,
                                   kernel_entry, fdt_load_addr);
--=20
2.43.0


