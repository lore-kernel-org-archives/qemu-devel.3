Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1B2CF9C5B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 03:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssaBp-0006PG-Ny; Sun, 22 Sep 2024 23:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1ssaBo-0006Mp-2y; Sun, 22 Sep 2024 23:56:44 -0400
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1ssaBm-00013E-12; Sun, 22 Sep 2024 23:56:43 -0400
Received: from sslproxy04.your-server.de ([78.46.152.42])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1ssaBh-0004WL-0g; Mon, 23 Sep 2024 05:56:37 +0200
Received: from [82.100.198.138] (helo=mail.embedded-brains.de)
 by sslproxy04.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1ssaBh-0002vG-1n; Mon, 23 Sep 2024 05:56:36 +0200
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 64F4648006F;
 Mon, 23 Sep 2024 05:56:36 +0200 (CEST)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id na2rX6Ff2n7Q; Mon, 23 Sep 2024 05:56:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id BBA7B4801B4;
 Mon, 23 Sep 2024 05:56:35 +0200 (CEST)
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 1gEO8IJpPNGn; Mon, 23 Sep 2024 05:56:35 +0200 (CEST)
Received: from zimbra.eb.localhost (unknown [192.168.96.242])
 by mail.embedded-brains.de (Postfix) with ESMTPSA id 980404801AF;
 Mon, 23 Sep 2024 05:56:35 +0200 (CEST)
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 2/2] hw/arm/xilinx_zynq: Add CPU1 reset
Date: Mon, 23 Sep 2024 05:56:32 +0200
Message-Id: <20240923035632.81304-3-sebastian.huber@embedded-brains.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240923035632.81304-1-sebastian.huber@embedded-brains.de>
References: <20240923035632.81304-1-sebastian.huber@embedded-brains.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: smtp-embedded@poldi-networks.de
X-Virus-Scanned: Clear (ClamAV 1.0.5/27406/Sun Sep 22 10:30:52 2024)
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

After a system reset (SRST), the CPU1 should execute a wfe instruction
and then load the start address from 0xfffffff0:

https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/Starting-Code-on-CPU=
-1

Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
---
 hw/arm/xilinx_zynq.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 37c234f5ab..0ee4a39a28 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -64,6 +64,8 @@ static const int dma_irqs[8] =3D {
=20
 #define BOARD_SETUP_ADDR        0x100
=20
+#define SECONDARY_SETUP_ADDR    0xFFFFFFE8
+
 #define SLCR_LOCK_OFFSET        0x004
 #define SLCR_UNLOCK_OFFSET      0x008
 #define SLCR_ARM_PLL_OFFSET     0x100
@@ -112,6 +114,28 @@ static void zynq_write_board_setup(ARMCPU *cpu,
                        sizeof(board_setup_blob), BOARD_SETUP_ADDR);
 }
=20
+static void zynq_secondary_cpu_reset(ARMCPU *cpu,
+                                     const struct arm_boot_info *info)
+{
+    /*
+     * After a system reset (SRST), the CPU1 should execute a wfe instru=
ction
+     * and then load the start address from 0xfffffff0:
+     *
+     * https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/Starting-Cod=
e-on-CPU-1
+     */
+    uint32_t secondary_setup_blob[] =3D {
+        0xe320f002, /* wfe */
+        0xe51ff004, /* ldr pc, [pc, #-4] */
+        SECONDARY_SETUP_ADDR
+    };
+    for (int n =3D 0; n < ARRAY_SIZE(secondary_setup_blob); n++) {
+        secondary_setup_blob[n] =3D tswap32(secondary_setup_blob[n]);
+    }
+    rom_add_blob_fixed("secondary-setup", secondary_setup_blob,
+                       sizeof(secondary_setup_blob), SECONDARY_SETUP_ADD=
R);
+    cpu_set_pc(CPU(cpu), SECONDARY_SETUP_ADDR);
+}
+
 static struct arm_boot_info zynq_binfo =3D {};
=20
 static void gem_init(uint32_t base, qemu_irq irq)
@@ -378,6 +402,7 @@ static void zynq_init(MachineState *machine)
     zynq_binfo.loader_start =3D 0;
     zynq_binfo.board_setup_addr =3D BOARD_SETUP_ADDR;
     zynq_binfo.write_board_setup =3D zynq_write_board_setup;
+    zynq_binfo.secondary_cpu_reset_hook =3D zynq_secondary_cpu_reset;
=20
     arm_load_kernel(zynq_machine->cpu[0], machine, &zynq_binfo);
 }
--=20
2.35.3


