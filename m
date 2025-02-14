Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB02EC021A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 06:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tip8L-00070J-Su; Fri, 14 Feb 2025 01:25:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tip8I-0006wV-HO
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 01:25:02 -0500
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tip8F-0003AM-H0
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 01:25:02 -0500
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tip8B-000LLW-1z; Fri, 14 Feb 2025 07:24:55 +0100
Received: from [82.100.198.138] (helo=mail.embedded-brains.de)
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tip8A-000N5h-2S; Fri, 14 Feb 2025 07:24:55 +0100
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 18012480160;
 Fri, 14 Feb 2025 07:24:55 +0100 (CET)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id j3ME6lx7NQPl; Fri, 14 Feb 2025 07:24:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id CED05480059;
 Fri, 14 Feb 2025 07:24:54 +0100 (CET)
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id kTMRpxTK2ZgR; Fri, 14 Feb 2025 07:24:54 +0100 (CET)
Received: from zimbra.eb.localhost (unknown [10.10.171.10])
 by mail.embedded-brains.de (Postfix) with ESMTPSA id A598F480160;
 Fri, 14 Feb 2025 07:24:53 +0100 (CET)
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: qemu-devel@nongnu.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Bin Meng <bin.meng@windriver.com>
Subject: [PATCH 2/5] hw/riscv: More flexible FDT placement for MPFS
Date: Fri, 14 Feb 2025 07:24:39 +0100
Message-ID: <20250214062443.9936-3-sebastian.huber@embedded-brains.de>
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

If the kernel entry is in the high DRAM area, place the FDT into this
area.

Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
---
 hw/riscv/microchip_pfsoc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index ec7e2e4226..2ddc3464bb 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -626,8 +626,15 @@ static void microchip_icicle_kit_machine_init(Machin=
eState *machine)
         kernel_entry =3D boot_info.image_low_addr;
=20
         /* Compute the fdt load address in dram */
-        fdt_load_addr =3D riscv_compute_fdt_addr(memmap[MICROCHIP_PFSOC_=
DRAM_LO].base,
-                                               memmap[MICROCHIP_PFSOC_DR=
AM_LO].size,
+        hwaddr kernel_ram_base =3D memmap[MICROCHIP_PFSOC_DRAM_LO].base;
+        hwaddr kernel_ram_size =3D memmap[MICROCHIP_PFSOC_DRAM_LO].size;
+
+        if (kernel_entry - kernel_ram_base >=3D kernel_ram_size) {
+            kernel_ram_base =3D memmap[MICROCHIP_PFSOC_DRAM_HI].base;
+            kernel_ram_size =3D mem_high_size;
+        }
+
+        fdt_load_addr =3D riscv_compute_fdt_addr(kernel_ram_base, kernel=
_ram_size,
                                                machine, &boot_info);
         riscv_load_fdt(fdt_load_addr, machine->fdt);
=20
--=20
2.43.0


