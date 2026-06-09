Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE84CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 04:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWo1G-0004eI-30; Tue, 09 Jun 2026 00:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wWm4Q-0001ct-7f
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 22:20:03 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wWm4M-0003Mk-BY
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 22:20:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=mjiZm8H
 7zEpzjKA3SWMSxWBVTXalb1tx1dYMur3KSYrc+ISLrY80cwPrxo+XcYEpt200IJkRSCdb8
 zko3i1Fkpm7P3CgiXqRTtXI1wrppFQpF/nYQsdvZN8aaGRMrPt8le1aDIOqGYL5L66Ie5i
 x19B3Z8G8w/FRp9HNTg2SlWsz1ghDfRIPwVGDdMWwbhfnmf6molFPIJcAFK5IWQwc0/Od4
 6oGpb6BzR5IQFOLC1KzLOqtC1sFRGIPp/F0yy4t8allBbN2GeESePIGbjU/L3pGYNqY0FA
 Ad/khfGCuRskOx09WcuURsfa/eZCukWrYZePp02Xuo5/rf7mFYR10dA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=P
 JPAShit9jm++v6V4WGKHz1axdgnEFfRDSlf7Vm4TdE=;
 h=date:subject:cc:to:
 from:dkim-signature:dkim-signature; d=mx.catap.net; b=thrQTtEPmiFG37BA
 9PrGM/wQaf6zPXqOtYtuUq2l19/QBhkv5/E/YaYnnpfrnMk0zBeuwZC30h2xddyR5Z0QZT
 GGPwsbFFWaXyaaNeWtRh+TayVCfRreiFf/9JqmCRzyB/IjVMi+wUp9/zVu5fafRWf5KRKh
 NKOZJgGdstif1nj7gF+/6ADj7hcnrnHxM27tABY8C+vp/IAHhRWKIqQoxBuYHgZQ0rIaXF
 bGYmZAmUKt8Z9XGEb7MSAnQHQ7VogoYTACEy0HRx/FIj8Buy8XnGBwQM29++U70Kqga2/R
 9QfQMxsQ2uBVLdDNRTd1p3Q3e1HX3ZWABU8rfcN8c0qr6g==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=uYEalUz3; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=jRK8kdfe;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=PJPAShit
 9jm++v6V4WGKHz1axdgnEFfRDSlf7Vm4TdE=; h=date:subject:cc:to:from;
 d=korins.ky; b=uYEalUz3AUJKW+LX7bxMYph/XXty/6oGuQ1koKRX0J6RIUPsKfG5ca6
 DvTs0GUnXqUwtvefpjiiPEUxwERX8vucprl9Sky9SuWgsxfYtdSyfjXsnEzSM+onAoaeYM
 WQw61goTUKAKqIiLFg5fn24wBcTiFJGvJ1IC7VzirYDpxu+mx/4N4VyP6MIrx1grb9Zx+l
 1pjZnnVBQVO+6d1u+U1XptRs2qif0FluGbfcRv+VQNyNUh4dpeK6sO9gx4pFG/Tj8gLijl
 JvZMNLHGIZYXm9ltbdwZcx1rpemkMQ8xgE5eHEaktEy/vJtP/3+1B4XKEjw3E8k1gskaxT
 YosAmuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=PJPAShit9jm++v6V4WGKHz1axdgnEFfRDSlf7Vm4TdE=; h=date:subject:cc:to:
 from; d=korins.ky; b=jRK8kdfeXcMjtZWqlc2Uf8JY3FUhOmkvx5qb5SuhyYXAZOPdt
 W9ATeGj1ar036k0RlE6Ro16t5pFoUqFcHn0BQ==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id 0eab6f1c
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Tue, 9 Jun 2026 04:19:51 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 345dd43e;
 Tue, 9 Jun 2026 04:19:50 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH] powernv: boot OpenBSD on POWER9
Date: Tue,  9 Jun 2026 04:19:45 +0200
Message-ID: <20260609021945.73632-1-kirill@korins.ky>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 09 Jun 2026 00:24:38 -0400
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

OpenBSD/powernv programs PTCR for LPID 0 with a partition
table size exponent one smaller than QEMU's existing ISA v3.0
interpretation. Try QEMU's existing PATS interpretation first,
then fall back to the OpenBSD LPID 0 form; nonzero LPIDs keep
the old behaviour.

The PSI model now exposes POWER9 IRQ level and pending status
registers, and keeps both updated while delivering through the
existing XIVE LSI source. This lets guests that select the
POWER9 PSI LSI IRQ method continue to receive LPC interrupts.

The blast radius is probably minimal: the partition table
fallback is limited to bare metal LPID 0 after the original
lookup fails, while the PSI change only touches POWER9 PSI
state and reuses the existing delivery path.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 hw/ppc/pnv_psi.c           | 17 ++++++++---------
 target/ppc/mmu-book3s-v3.c | 33 ++++++++++++++++++++++++++++-----
 2 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index e8701c6100..941540df2d 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -688,6 +688,8 @@ static uint64_t pnv_psi_p9_mmio_read(void *opaque, hwaddr addr, unsigned size)
     case PSIHB9_ESB_CI_BASE:
     case PSIHB9_ESB_NOTIF_ADDR:
     case PSIHB9_IVT_OFFSET:
+    case PSIHB9_IRQ_LEVEL:
+    case PSIHB9_IRQ_STAT:
         val = psi->regs[reg];
         break;
     default:
@@ -817,18 +819,15 @@ static const MemoryRegionOps pnv_psi_p9_xscom_ops = {
 static void pnv_psi_power9_set_irq(void *opaque, int irq, int state)
 {
     PnvPsi *psi = opaque;
-    uint64_t irq_method = psi->regs[PSIHB_REG(PSIHB9_INTERRUPT_CONTROL)];
+    uint64_t irq_bit = PPC_BIT(irq);
 
-    if (irq_method & PSIHB9_IRQ_METHOD) {
-        qemu_log_mask(LOG_GUEST_ERROR, "PSI: LSI IRQ method no supported\n");
-        return;
-    }
-
-    /* Update LSI levels */
+    /* Update LSI levels and pending status */
     if (state) {
-        psi->regs[PSIHB_REG(PSIHB9_IRQ_LEVEL)] |= PPC_BIT(irq);
+        psi->regs[PSIHB_REG(PSIHB9_IRQ_LEVEL)] |= irq_bit;
+        psi->regs[PSIHB_REG(PSIHB9_IRQ_STAT)] |= irq_bit;
     } else {
-        psi->regs[PSIHB_REG(PSIHB9_IRQ_LEVEL)] &= ~PPC_BIT(irq);
+        psi->regs[PSIHB_REG(PSIHB9_IRQ_LEVEL)] &= ~irq_bit;
+        psi->regs[PSIHB_REG(PSIHB9_IRQ_STAT)] &= ~irq_bit;
     }
 
     qemu_set_irq(psi->qirqs[irq], state);
diff --git a/target/ppc/mmu-book3s-v3.c b/target/ppc/mmu-book3s-v3.c
index 3865556310..4babe4c536 100644
--- a/target/ppc/mmu-book3s-v3.c
+++ b/target/ppc/mmu-book3s-v3.c
@@ -23,19 +23,21 @@
 #include "mmu-hash64.h"
 #include "mmu-book3s-v3.h"
 
-bool ppc64_v3_get_pate(PowerPCCPU *cpu, target_ulong lpid, ppc_v3_pate_t *entry)
+static bool ppc64_v3_get_pate_from_size(PowerPCCPU *cpu, target_ulong lpid,
+                                        ppc_v3_pate_t *entry,
+                                        uint64_t table_size)
 {
     uint64_t patb = cpu->env.spr[SPR_PTCR] & PTCR_PATB;
-    uint64_t pats = cpu->env.spr[SPR_PTCR] & PTCR_PATS;
+    uint64_t entries;
 
     /* Check if partition table is properly aligned */
-    if (patb & MAKE_64BIT_MASK(0, pats + 12)) {
+    if (patb & (table_size - 1)) {
         return false;
     }
 
     /* Calculate number of entries */
-    pats = 1ull << (pats + 12 - 4);
-    if (pats <= lpid) {
+    entries = table_size / sizeof(*entry);
+    if (entries <= lpid) {
         return false;
     }
 
@@ -45,3 +47,24 @@ bool ppc64_v3_get_pate(PowerPCCPU *cpu, target_ulong lpid, ppc_v3_pate_t *entry)
     entry->dw1 = ldq_phys(CPU(cpu)->as, patb + 8);
     return true;
 }
+
+bool ppc64_v3_get_pate(PowerPCCPU *cpu, target_ulong lpid, ppc_v3_pate_t *entry)
+{
+    uint64_t pats = cpu->env.spr[SPR_PTCR] & PTCR_PATS;
+
+    /*
+     * Keep the existing ISA v3.0 PATS interpretation first.  OpenBSD/powernv
+     * uses the PATSIZE value it writes to PTCR as one exponent smaller, and it
+     * only needs that interpretation for the bare metal LPID 0 table.
+     */
+    if (ppc64_v3_get_pate_from_size(cpu, lpid, entry, 1ull << (pats + 12))) {
+        return true;
+    }
+
+    if (lpid == 0) {
+        return ppc64_v3_get_pate_from_size(cpu, lpid, entry,
+                                           1ull << (pats + 11));
+    }
+
+    return false;
+}
-- 
2.54.0


