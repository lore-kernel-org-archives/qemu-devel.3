Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62423606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 03:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTtAq-0007O4-2u; Wed, 18 Nov 2026 22:51:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zakinko@snowrabbit.org>)
 id 1xTtAm-0007NS-NO; Wed, 18 Nov 2026 22:50:56 -0500
Received: from bambi.snowrabbit.org ([182.48.54.220])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zakinko@snowrabbit.org>)
 id 1xTtAj-0003Oy-Kg; Wed, 18 Nov 2026 22:50:56 -0500
Received: by bambi.snowrabbit.org (Postfix, from userid 3001)
 id E17BAC9300; Thu, 19 Nov 2026 12:50:48 +0900 (JST)
From: Showta Ishizaki <zakinko@snowrabbit.org>
Date: Thu, 19 Nov 2026 12:50:45 +0900
Message-ID: <179506024552.1941.3792670534300160146@snowrabbit.org>
Subject: [PATCH] hw/ppc/spapr: Implement H_CLEAR_MOD and H_CLEAR_REF for TCG
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org,
 Showta Ishizaki <zakinko@snowrabbit.org>
Received-SPF: pass client-ip=182.48.54.220;
 envelope-from=zakinko@snowrabbit.org; helo=bambi.snowrabbit.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

The pseries machine advertises hcall-pft, and PAPR makes H_CLEAR_MOD
and H_CLEAR_REF mandatory parts of that function set (14.5.4.1.4 and
14.5.4.1.5 in PAPR v10.60).  Under KVM they are turned on with
kvmppc_enable_clear_ref_mod_hcalls(), but the TCG MMU never registered
them, so a guest gets H_FUNCTION.

Implement both.  They return the second doubleword of the PTE as it
was and clear C or R.  C is cleared with the general PTE update
sequence that h_protect() uses.  R is cleared with the shorter
"Resetting the Reference Bit" sequence instead (Power ISA 2.07 Book
III-S 5.10.1.2), which leaves V set.

Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
---
I hit this running a NetBSD pseries kernel I am working on under TCG.
Its pmap uses H_CLEAR_MOD and H_CLEAR_REF and panics on failure:

  panic: pmap_pte_clear: H_CLEAR_MOD 0x3ac82: -2

With this patch the same kernel boots multi-user and runs an xz
round trip on -cpu power9 and power10 with -smp 2.  The H_Parameter
and H_Not_Found returns are untested.

 hw/ppc/spapr_vhyp_mmu.c | 46 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/hw/ppc/spapr_vhyp_mmu.c b/hw/ppc/spapr_vhyp_mmu.c
index 9cc3aeb2a2..dc2b76b397 100644
--- a/hw/ppc/spapr_vhyp_mmu.c
+++ b/hw/ppc/spapr_vhyp_mmu.c
@@ -266,6 +266,50 @@ static target_ulong h_protect(PowerPCCPU *cpu, SpaprMachineState *spapr,
     return H_SUCCESS;
 }
 
+/* PAPR v10.60 14.5.4.1.4 and 14.5.4.1.5 */
+static target_ulong h_clear_ref_mod(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                                    target_ulong opcode, target_ulong *args)
+{
+    CPUPPCState *env = &cpu->env;
+    target_ulong ptex = args[1];
+    target_ulong bit = opcode == H_CLEAR_MOD ? HPTE64_R_C : HPTE64_R_R;
+    const ppc_hash_pte64_t *hptes;
+    target_ulong v, r;
+
+    if (!ppc_hash64_valid_ptex(cpu, ptex)) {
+        return H_PARAMETER;
+    }
+
+    hptes = ppc_hash64_map_hptes(cpu, ptex, 1);
+    v = ppc_hash64_hpte0(cpu, hptes, 0);
+    r = ppc_hash64_hpte1(cpu, hptes, 0);
+    ppc_hash64_unmap_hptes(cpu, hptes, ptex, 1);
+
+    if ((v & HPTE64_V_VALID) == 0) {
+        return H_NOT_FOUND;
+    }
+
+    args[0] = r;
+    if ((r & bit) == 0) {
+        return H_SUCCESS;
+    }
+
+    if (opcode == H_CLEAR_MOD) {
+        spapr_store_hpte(cpu, ptex,
+                         (v & ~HPTE64_V_VALID) | HPTE64_V_HPTE_DIRTY, 0);
+        ppc_hash64_tlb_flush_hpte(cpu, ptex, v, r);
+        check_tlb_flush(env, true);
+        /* Don't need a memory barrier, due to qemu's global lock */
+        spapr_store_hpte(cpu, ptex, v | HPTE64_V_HPTE_DIRTY, r & ~bit);
+    } else {
+        /* Power ISA 2.07 Book III-S 5.10.1.2, Resetting the Reference Bit */
+        spapr_store_hpte(cpu, ptex, v | HPTE64_V_HPTE_DIRTY, r & ~bit);
+        ppc_hash64_tlb_flush_hpte(cpu, ptex, v, r);
+        check_tlb_flush(env, true);
+    }
+    return H_SUCCESS;
+}
+
 static target_ulong h_read(PowerPCCPU *cpu, SpaprMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
@@ -602,6 +646,8 @@ static void hypercall_register_types(void)
     spapr_register_hypercall(H_REMOVE, h_remove);
     spapr_register_hypercall(H_PROTECT, h_protect);
     spapr_register_hypercall(H_READ, h_read);
+    spapr_register_hypercall(H_CLEAR_MOD, h_clear_ref_mod);
+    spapr_register_hypercall(H_CLEAR_REF, h_clear_ref_mod);
 
     /* hcall-bulk */
     spapr_register_hypercall(H_BULK_REMOVE, h_bulk_remove);
-- 
2.54.0


