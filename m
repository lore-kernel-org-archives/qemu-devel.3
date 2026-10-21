Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A406606A325
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vmexit.de header.i=@vmexit.de header.a=rsa-sha256 header.s=mail header.b=VAJnNHMd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJd2f-000477-Hk; Wed, 21 Oct 2026 16:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ralf@vmexit.de>)
 id 1xJd2X-00043l-4q; Wed, 21 Oct 2026 16:36:02 -0400
Received: from vmexit.de ([2a0a:4cc0:c1:d4ba::2] helo=gizmo.vmexit.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ralf@vmexit.de>)
 id 1xJd2T-0006FS-Sx; Wed, 21 Oct 2026 16:36:00 -0400
From: Ralf Ramsauer <ralf@vmexit.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmexit.de; s=mail;
 t=1792614954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MVSAu0gfeVzeEMpAMOn+JKLB5yOXFqRUFtqNjzq7UMU=;
 b=VAJnNHMddzVWoU+j6rDr5DhD7oqzAw0CycbPToY4hMA7hRzbgLEamPE+v0RP9UFAXnk5xV
 w6t4ANdXiHIi1AsLSK8pSqDlF7jBq7Zczvn14sxQ4PsJ3rX0XE+fsHwa0tditZ1m35mfQg
 4rdvRI72WWveL53eLyA9QIwgeWwljf4=
To: qemu-devel@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Ralf Ramsauer <ralf@vmexit.de>,
 Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Bin Meng <bmeng.cn@gmail.com>,
 Lukas Landgraf <lukas.landgraf@st.oth-regensburg.de>
Subject: [PATCH v3 4/4] hw/riscv: share the PLIC interrupt cells between boards
Date: Wed, 21 Oct 2026 22:35:50 +0200
Message-ID: <20261021203551.3211170-1-ralf@vmexit.de>
In-Reply-To: <2949aabb-200f-44bd-9b9d-4d0ceaaf77e4@oss.qualcomm.com>
References: <2949aabb-200f-44bd-9b9d-4d0ceaaf77e4@oss.qualcomm.com>
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>

virt and sifive_u now describe a hart's PLIC contexts with the same rule:
a machine context unless the hart runs under KVM, where there is no
M-mode, and a supervisor context if the hart has supervisor mode.
Writing that rule down twice is what let the virt device tree drift away
from riscv_plic_hart_config_string().

This makes the sifive_u device tree ask whether KVM is in use, which it
did not do before.  Its PLIC device already does, so the two now agree.

Signed-off-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
---
Cleanup, not a fix.  Can be dropped, the rest does not depend on it.
1-3 are unchanged since v2 and carry your Reviewed-by.

v3:
 - take has_m_mode as a parameter, the boards keep the accelerator
   considerations and the fdt helper just writes what it is told (Daniel)
 - virt.c uses one has_m_mode local for the allocation and the call

 hw/riscv/fdt-common.c         | 18 ++++++++++++++++++
 hw/riscv/sifive_u.c           | 12 ++++--------
 hw/riscv/virt.c               | 16 ++++++----------
 include/hw/riscv/fdt-common.h |  3 +++
 4 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index ce2dcb43b4..503d818dd0 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -212,6 +212,24 @@ riscv_create_fdt_socket_cpu_sifive(void *fdt, char *clust_name,
                                    phandle, intc_phandles, false, false);
 }
 
+uint32_t riscv_plic_hart_fdt_cells(uint32_t *cells, RISCVCPU *hart,
+                                   uint32_t intc_phandle, bool has_m_mode)
+{
+    uint32_t len = 0;
+
+    if (has_m_mode) {
+        cells[len++] = cpu_to_be32(intc_phandle);
+        cells[len++] = cpu_to_be32(IRQ_M_EXT);
+    }
+
+    if (riscv_cpu_has_supervisor_mode(hart)) {
+        cells[len++] = cpu_to_be32(intc_phandle);
+        cells[len++] = cpu_to_be32(IRQ_S_EXT);
+    }
+
+    return len;
+}
+
 void riscv_create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
                            uint32_t plic_phandle, uint32_t int_cells,
                            uint32_t addr_cells, uint32_t *plic_cells,
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 8f50c67a14..be194f8aec 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -58,6 +58,7 @@
 #include "chardev/char.h"
 #include "net/eth.h"
 #include "system/device_tree.h"
+#include "system/kvm.h"
 #include "system/runstate.h"
 #include "system/system.h"
 
@@ -201,14 +202,9 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
     for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
         /* cpu 0 is the management hart that does not have S-mode */
         hart = cpu ? &s->soc.u_cpus.harts[cpu - 1] : &s->soc.e_cpus.harts[0];
-
-        cells[cells_length++] = cpu_to_be32(intc_phandles[cpu]);
-        cells[cells_length++] = cpu_to_be32(IRQ_M_EXT);
-
-        if (riscv_cpu_has_supervisor_mode(hart)) {
-            cells[cells_length++] = cpu_to_be32(intc_phandles[cpu]);
-            cells[cells_length++] = cpu_to_be32(IRQ_S_EXT);
-        }
+        cells_length += riscv_plic_hart_fdt_cells(&cells[cells_length], hart,
+                                                  intc_phandles[cpu],
+                                                  !kvm_enabled());
     }
 
     riscv_create_fdt_plic(fdt, memmap[SIFIVE_U_DEV_PLIC].base,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index a2851b506d..ece8ef0070 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -152,24 +152,20 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
     unsigned long plic_addr = s->memmap[VIRT_PLIC].base +
                               (s->memmap[VIRT_PLIC].size * socket);
     bool numa_enabled = riscv_numa_enabled(MACHINE(s));
+    bool has_m_mode = !kvm_enabled();
     uint32_t cells_length;
 
     plic_name = g_strdup_printf("/soc/interrupt-controller@%lx", plic_addr);
 
     plic_cells = g_new0(uint32_t,
-                        s->soc[socket].num_harts * (kvm_enabled() ? 2 : 4));
+                        s->soc[socket].num_harts * (has_m_mode ? 4 : 2));
     cells_length = 0;
 
     for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
-        if (!kvm_enabled()) {
-            plic_cells[cells_length++] = cpu_to_be32(intc_phandles[cpu]);
-            plic_cells[cells_length++] = cpu_to_be32(IRQ_M_EXT);
-        }
-
-        if (riscv_cpu_has_supervisor_mode(&s->soc[socket].harts[cpu])) {
-            plic_cells[cells_length++] = cpu_to_be32(intc_phandles[cpu]);
-            plic_cells[cells_length++] = cpu_to_be32(IRQ_S_EXT);
-        }
+        cells_length += riscv_plic_hart_fdt_cells(&plic_cells[cells_length],
+                                                  &s->soc[socket].harts[cpu],
+                                                  intc_phandles[cpu],
+                                                  has_m_mode);
     }
 
     plic_phandles[socket] = (*phandle)++;
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index eb9db8278d..58e635e9ed 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -93,6 +93,9 @@ void riscv_create_fdt_socket_cpu_sifive(void *fdt, char *clust_name,
                                         int socket_hartid_base,
                                         uint32_t *phandle,
                                         uint32_t *intc_phandles);
+/* Describe one hart's PLIC contexts, returns the number of cells written */
+uint32_t riscv_plic_hart_fdt_cells(uint32_t *cells, RISCVCPU *hart,
+                                   uint32_t intc_phandle, bool has_m_mode);
 void riscv_create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
                            uint32_t plic_phandle, uint32_t int_cells,
                            uint32_t addr_cells, uint32_t *plic_cells,

base-commit: 81ce3a87737aa50716c42db8886082d12783e0a1
prerequisite-patch-id: 70f23581616a275c2b659d655418184163a0c37c
prerequisite-patch-id: e0d267d9d4940408ecf478a14f7cbffd069b9666
prerequisite-patch-id: 0164dcda18a619b9f4a6f84eedcc5fe1e8c92eb9
-- 
2.54.0


