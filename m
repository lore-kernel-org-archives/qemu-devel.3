Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE56606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vmexit.de header.i=@vmexit.de header.a=rsa-sha256 header.s=mail header.b=XgRvX+B7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJUBm-00074z-RE; Wed, 21 Oct 2026 07:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ralf@vmexit.de>)
 id 1xJUBg-00073c-0T; Wed, 21 Oct 2026 07:08:52 -0400
Received: from vmexit.de ([2a0a:4cc0:c1:d4ba::2] helo=gizmo.vmexit.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ralf@vmexit.de>)
 id 1xJUBe-0007cZ-4h; Wed, 21 Oct 2026 07:08:51 -0400
From: Ralf Ramsauer <ralf@vmexit.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmexit.de; s=mail;
 t=1792580925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wPeNl4UCxUj5StMAx3q5p/uDeM72iAQcAzJ3eFplrOg=;
 b=XgRvX+B7hIStQ6xUiFaTLV0TQEXi9QwAhmW1LF8ElpEZnKV8ITC8VXVDDAM2Rmd0PaLcTb
 MKshc8PcziPX9sWW89eiQCJbzzG/+EBHUVZ32nfBa0b8cudNkypchkoqLTpee/lw5AMUzQ
 HvBo1N6aWIcqrUH825bjhixQl+k/Jwc=
To: qemu-devel@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Ralf Ramsauer <ralf@vmexit.de>,
 Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Bin Meng <bmeng.cn@gmail.com>,
 Lukas Landgraf <lukas.landgraf@st.oth-regensburg.de>
Subject: [PATCH v2 2/4] hw/riscv/virt: only describe PLIC contexts that exist
Date: Wed, 21 Oct 2026 13:08:35 +0200
Message-ID: <20261021110838.3097959-3-ralf@vmexit.de>
In-Reply-To: <20261021110838.3097959-1-ralf@vmexit.de>
References: <20261021110838.3097959-1-ralf@vmexit.de>
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

The PLIC device is created from the topology string built by
riscv_plic_hart_config_string(), which gives a hart a supervisor context
only if that hart actually has supervisor mode.  The device tree, in
contrast, lists a machine and a supervisor context for every hart,
unconditionally.

The two have disagreed since commit 7d10ff8a4d ("hw/riscv: virt: Use the
PLIC config helper function") taught the device about harts without
S-mode and left the device tree behind.  Boot with

    -cpu rv64,s=false,u=false -smp 4

and the PLIC implements four contexts while the device tree advertises
eight.  Contexts are numbered by their position in 'interrupts-extended',
so a guest that takes its context number from the property gets it wrong
for every hart but the first: hart 1 drives the context of hart 2, and
the upper harts address contexts the PLIC never created.  This is what an
M-mode kernel on the virt machine runs into.

Emit the supervisor entry only for the harts that have supervisor mode.
The KVM case then becomes the same rule, not a separate one: its harts
have no M-mode and always have supervisor mode, so the common loop
describes the single supervisor context per hart that it used to spell
out on its own.

Fixes: 7d10ff8a4d ("hw/riscv: virt: Use the PLIC config helper function")
Signed-off-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
---
v2:
 - ask riscv_cpu_has_supervisor_mode() instead of reading RVS out of the
   hart's CPURISCVState (Daniel)
 - fold the KVM branch into the common loop, it describes the same rule
 - drop the claim about sifive_u from the commit message, patch 3 fixes
   that board rather than leaving it as the good example

 hw/riscv/virt.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d4b501802f..a2851b506d 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -156,23 +156,19 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
 
     plic_name = g_strdup_printf("/soc/interrupt-controller@%lx", plic_addr);
 
-    if (kvm_enabled()) {
-        cells_length = s->soc[socket].num_harts * 2;
-        plic_cells = g_new0(uint32_t, cells_length);
-
-        for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
-            plic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
-            plic_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_S_EXT);
+    plic_cells = g_new0(uint32_t,
+                        s->soc[socket].num_harts * (kvm_enabled() ? 2 : 4));
+    cells_length = 0;
+
+    for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
+        if (!kvm_enabled()) {
+            plic_cells[cells_length++] = cpu_to_be32(intc_phandles[cpu]);
+            plic_cells[cells_length++] = cpu_to_be32(IRQ_M_EXT);
         }
-   } else {
-        cells_length = s->soc[socket].num_harts * 4;
-        plic_cells = g_new0(uint32_t, cells_length);
-
-        for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
-            plic_cells[cpu * 4 + 0] = cpu_to_be32(intc_phandles[cpu]);
-            plic_cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_EXT);
-            plic_cells[cpu * 4 + 2] = cpu_to_be32(intc_phandles[cpu]);
-            plic_cells[cpu * 4 + 3] = cpu_to_be32(IRQ_S_EXT);
+
+        if (riscv_cpu_has_supervisor_mode(&s->soc[socket].harts[cpu])) {
+            plic_cells[cells_length++] = cpu_to_be32(intc_phandles[cpu]);
+            plic_cells[cells_length++] = cpu_to_be32(IRQ_S_EXT);
         }
     }
 
-- 
2.54.0


