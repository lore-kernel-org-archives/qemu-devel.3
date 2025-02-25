Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76729C021B8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 00:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmjEX-0003CM-DZ; Mon, 24 Feb 2025 19:55:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tmjE1-0002vN-90; Mon, 24 Feb 2025 19:55:07 -0500
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tmjDy-0004dn-45; Mon, 24 Feb 2025 19:55:04 -0500
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tmjDw-000HO9-15; Tue, 25 Feb 2025 01:55:00 +0100
Received: from [82.100.198.138] (helo=mail.embedded-brains.de)
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tmjDw-00091Z-1l; Tue, 25 Feb 2025 01:55:00 +0100
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id AAB6F48005D;
 Tue, 25 Feb 2025 01:54:59 +0100 (CET)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id ngYwdGt7t6NC; Tue, 25 Feb 2025 01:54:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 6F20A48005B;
 Tue, 25 Feb 2025 01:54:59 +0100 (CET)
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id CatW4XX5y7G7; Tue, 25 Feb 2025 01:54:59 +0100 (CET)
Received: from zimbra.eb.localhost (unknown [10.10.171.10])
 by mail.embedded-brains.de (Postfix) with ESMTPSA id BC68048005D;
 Tue, 25 Feb 2025 01:54:57 +0100 (CET)
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair23@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Bin Meng <bin.meng@windriver.com>
Subject: [PATCH v2 2/6] hw/riscv: More flexible FDT placement for MPFS
Date: Tue, 25 Feb 2025 01:54:42 +0100
Message-ID: <20250225005446.13894-3-sebastian.huber@embedded-brains.de>
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

If the kernel entry is in the high DRAM area, place the FDT into this
area.

Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/microchip_pfsoc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 9c846f9b5b..f477d2791e 100644
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


