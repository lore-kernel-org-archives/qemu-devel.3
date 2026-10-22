Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714BE606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 20:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vmexit.de header.i=@vmexit.de header.a=rsa-sha256 header.s=mail header.b=WqdaRZ7V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJzJ2-0006xu-Ro; Thu, 22 Oct 2026 16:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ralf@vmexit.de>)
 id 1xJzIy-0006wH-Iy; Thu, 22 Oct 2026 16:22:28 -0400
Received: from vmexit.de ([2a0a:4cc0:c1:d4ba::2] helo=gizmo.vmexit.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ralf@vmexit.de>)
 id 1xJzIw-0006zX-64; Thu, 22 Oct 2026 16:22:28 -0400
From: Ralf Ramsauer <ralf@vmexit.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmexit.de; s=mail;
 t=1792700543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kqwsoktma7Bn9UEwhZdrSXc2/D8sx6TG4M9rY/eSXU4=;
 b=WqdaRZ7V0YKdfyjA0IubOyAAdA2QGKgLsM95w+cB9u3WR2y6C6qM0gOFwxJIkRfHlepdas
 4Po61LR4L08NIRe3LY00uPR7N0evORNtlwtDZbcxMxEUzRFfbh3cBkCEByXx4WfQDU/mgQ
 4Wht4wrGoy/oTXuvvCuKiCIOceUXYyc=
To: qemu-devel@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Ralf Ramsauer <ralf@vmexit.de>,
 Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Bin Meng <bmeng.cn@gmail.com>,
 Lukas Landgraf <lukas.landgraf@st.oth-regensburg.de>
Subject: [PATCH v3 3/4] hw/riscv/sifive_u: derive PLIC contexts from the harts
Date: Thu, 22 Oct 2026 22:22:17 +0200
Message-ID: <f5bffbbaf8272e743f184e9f5681ec5931800e23.1792700406.git.ralf@vmexit.de>
In-Reply-To: <cover.1792700406.git.ralf@vmexit.de>
References: <cover.1792700406.git.ralf@vmexit.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a0a:4cc0:c1:d4ba::2; envelope-from=ralf@vmexit.de;
 helo=gizmo.vmexit.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>

The PLIC device is created from riscv_plic_hart_config_string(), which
gives a hart a supervisor context only if that hart has supervisor mode.
The device tree instead hardcodes the fu540 topology: no supervisor
context for the management hart, one for every other hart.

Both agree as long as the application harts keep the default CPU type.
The board sets no valid_cpu_types, though, and passes machine->cpu_type
on to the U cluster, so -cpu rv64,s=false,u=false builds a PLIC without
any supervisor context while the device tree still advertises one per
application hart.  Contexts are numbered by their position in
'interrupts-extended', so from the second hart on the numbering drifts
apart, as it does on the virt machine.

Ask the harts instead of assuming, like create_fdt_socket_plic() does.
No change for the default CPU type: the E51 management hart has no RVS,
the U54 application harts have.

Signed-off-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/sifive_u.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index b7d5e7b4da..8f50c67a14 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -99,6 +99,7 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
     MachineState *ms = MACHINE(s);
     void *fdt;
     int cpu;
+    RISCVCPU *hart;
     uint32_t *cells, cells_length;
     char *nodename;
     uint32_t plic_phandle, prci_phandle, gpio_phandle, phandle = 1;
@@ -195,18 +196,18 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
     g_free(nodename);
 
     plic_phandle = phandle++;
-    cells_length = ms->smp.cpus * 4 - 2;
-    cells =  g_new0(uint32_t, cells_length);
+    cells = g_new0(uint32_t, ms->smp.cpus * 4 - 2);
+    cells_length = 0;
     for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
         /* cpu 0 is the management hart that does not have S-mode */
-        if (cpu == 0) {
-            cells[0] = cpu_to_be32(intc_phandles[cpu]);
-            cells[1] = cpu_to_be32(IRQ_M_EXT);
-        } else {
-            cells[cpu * 4 - 2] = cpu_to_be32(intc_phandles[cpu]);
-            cells[cpu * 4 - 1] = cpu_to_be32(IRQ_M_EXT);
-            cells[cpu * 4 + 0] = cpu_to_be32(intc_phandles[cpu]);
-            cells[cpu * 4 + 1] = cpu_to_be32(IRQ_S_EXT);
+        hart = cpu ? &s->soc.u_cpus.harts[cpu - 1] : &s->soc.e_cpus.harts[0];
+
+        cells[cells_length++] = cpu_to_be32(intc_phandles[cpu]);
+        cells[cells_length++] = cpu_to_be32(IRQ_M_EXT);
+
+        if (riscv_cpu_has_supervisor_mode(hart)) {
+            cells[cells_length++] = cpu_to_be32(intc_phandles[cpu]);
+            cells[cells_length++] = cpu_to_be32(IRQ_S_EXT);
         }
     }
 
-- 
2.54.0


