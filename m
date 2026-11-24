Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA61C606A326
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rispop.dev header.i=@rispop.dev header.a=rsa-sha256 header.s=protonmail header.b=iLxscUqF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVknx-00010B-L3; Tue, 24 Nov 2026 02:19:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rishab@rispop.dev>)
 id 1xVknv-0000yk-PU; Tue, 24 Nov 2026 02:19:04 -0500
Received: from mail-244108.protonmail.ch ([109.224.244.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rishab@rispop.dev>)
 id 1xVknt-0006Sz-FV; Tue, 24 Nov 2026 02:19:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rispop.dev;
 s=protonmail; t=1795504732; x=1795763932;
 bh=evzoSijXgzHUfpOxAiWeE8vNQsqZWBqxtxwDlBDJhlM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=iLxscUqFK6QkvYfYT1h5rwa3+9yv4jpOtB4OoTi2JCRRL+w90n68qd3CUkYAvbNSI
 WyhP59J314RhhIiKW2uCcoUOOejkcXzbbVtuPCdrXRDjlcBRc2n3mqz0gyhiQJt8dc
 GR0rDERbUybbqdZGgyIJ5//XnHePRCGkqqoEz9rTF/cLCOAS0QD9CCa+5zAc1wEOuS
 POnsRM4YKNSRANTj2SmGj+MX9mAw1aPrzj80J32V+rVzpTayM86iov7nyf3HS6dejf
 MlmpbMVb7sgCVz4gyYf2RnKatMhQ01SB5i7awNlshH5pcU4Ql6M/q8x0Iy91exPNsf
 RYdIejDUNH/FQ==
X-Pm-Submission-Id: 4jYZ146v3Qz2SccR
From: Rishab Pradeep <rishab@rispop.dev>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, tarun.patanjali@utexas.edu,
 christopher.elwood2024@gmail.com, Rishab Pradeep <rishab@rispop.dev>
Subject: [RFC PATCH 2/2] target/riscv: Check store permission before split
 AMOs with Zicfiss
Date: Tue, 24 Nov 2026 01:18:36 -0600
Message-ID: <20261124071836.208740-3-rishab@rispop.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124071836.208740-1-rishab@rispop.dev>
References: <20261124071836.208740-1-rishab@rispop.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=109.224.244.108; envelope-from=rishab@rispop.dev;
 helo=mail-244108.protonmail.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With Zicfiss enabled, an ordinary AMO or AMOCAS to a shadow-stack page
must raise a store/AMO access fault (cause 7).

When TCG lowers an AMO to a load followed by a store (!CF_PARALLEL),
the load runs first, which goes wrong in two ways:

 - If the PTE's A bit is clear and hardware A/D updates are disabled
   (Svade), the load's page walk fails and raises a load page fault,
   which is promoted to a store page fault (cause 15) instead of
   cause 7.

 - If an earlier ordinary load has installed a TLB entry that permits
   reads for the page, the AMO's load hits it and executes, and only
   the store phase faults.  The cause is then correct, but the load's
   side effects (e.g. a read watchpoint) have already happened.

Add an amo_probe_write helper that does a store-permission lookup at
the normal MMU index before the load, using probe_access_perm(), and
call it from gen_amo, gen_cmpxchg, gen_cmpxchg64 and the amocas.q
translation.  It is emitted only when shadow stacks are enabled and
the TB is not CF_PARALLEL, since the parallel atomic helpers already
look up the store first.

The first lookup uses the full access size, as mmu_lookup() does, so
PMP sees the same range as the real access.  A page-crossing access
adds a second lookup at the pointer_wrap()'d page base for the
remaining bytes.  If the operation requires natural alignment and the
address is misaligned, the probe is skipped so that the real access
raises the address-misaligned exception first.

RISCV_UW2_ALWAYS_STORE_AMO and promote_load_fault() are unchanged;
they still cover load-phase faults that the probe cannot prevent.

Page-crossing Zama16b accesses are probed to match the current
behaviour of the real operation; enforcing the 16-byte granule would
be a separate change.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4840
Co-developed-by: Tarun Patanjali <tarun.patanjali@utexas.edu>
Signed-off-by: Tarun Patanjali <tarun.patanjali@utexas.edu>
Co-developed-by: Chris Elwood <christopher.elwood2024@gmail.com>
Signed-off-by: Chris Elwood <christopher.elwood2024@gmail.com>
Signed-off-by: Rishab Pradeep <rishab@rispop.dev>
---
 target/riscv/helper.h                         |  5 +++
 .../riscv/tcg/insn_trans/trans_rvzacas.c.inc  |  2 +
 target/riscv/tcg/op_helper.c                  | 37 +++++++++++++++++++
 target/riscv/tcg/translate.c                  | 23 ++++++++++++
 4 files changed, 67 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 1cffcad580..f30fc3ad4f 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1387,6 +1387,11 @@ DEF_HELPER_1(ssamoswap_disabled, void, env)
 /* Zalrsc SC write probe */
 DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, tl, tl)
 
+#ifndef CONFIG_USER_ONLY
+/* Zicfiss: store-permission check before the load of a split AMO */
+DEF_HELPER_FLAGS_4(amo_probe_write, TCG_CALL_NO_WG, void, env, tl, tl, tl)
+#endif
+
 /* SiFive Custom int8 Matrix-Multiply */
 DEF_HELPER_5(sf_vqmaccu_4x8x4, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(sf_vqmacc_4x8x4, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/tcg/insn_trans/trans_rvzacas.c.inc b/target/riscv/tcg/insn_trans/trans_rvzacas.c.inc
index 79bca1e957..e7eb4aae33 100644
--- a/target/riscv/tcg/insn_trans/trans_rvzacas.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvzacas.c.inc
@@ -78,6 +78,7 @@ static bool gen_cmpxchg64(DisasContext *ctx, arg_atomic *a, MemOp mop)
 
     mop |= ctx->mo_endianness;
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
+    gen_amo_probe(ctx, src1, mop, true);
     tcg_gen_atomic_cmpxchg_i64(dest, src1, dest, src2, ctx->mem_idx, mop);
 
     gen_set_gpr_pair(ctx, a->rd, dest);
@@ -125,6 +126,7 @@ static bool trans_amocas_q(DisasContext *ctx, arg_amocas_q *a)
     tcg_gen_concat_i64_i128(src2, src2l, src2h);
     tcg_gen_concat_i64_i128(dest, destl, desth);
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
+    gen_amo_probe(ctx, src1, memop, true);
     tcg_gen_atomic_cmpxchg_i128(dest, src1, dest, src2, ctx->mem_idx, memop);
 
     tcg_gen_extr_i128_i64(destl, desth, dest);
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index f9c79fe6b9..49696114ed 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -29,6 +29,10 @@
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/probe.h"
+#ifndef CONFIG_USER_ONLY
+#include "accel/tcg/cpu-ops.h"
+#include "exec/target_page.h"
+#endif
 #include "exec/helper-proto.h"
 #include "exec/tlb-flags.h"
 #include "trace.h"
@@ -300,6 +304,39 @@ void HELPER(sc_probe_write)(CPURISCVState *env, target_ulong addr,
 
 #ifndef CONFIG_USER_ONLY
 
+/*
+ * Check store permission before the load of an AMO that TCG lowers to
+ * load+store.  Needed when the load itself would be allowed (e.g. a
+ * cached read translation on a shadow-stack page) so that the AMO
+ * faults with the store cause before any load side effect.
+ *
+ * The first lookup carries the full size (matching mmu_lookup, so PMP
+ * sees the same range); a page crossing adds a second lookup for the
+ * remaining bytes at the wrapped page base.
+ */
+void HELPER(amo_probe_write)(CPURISCVState *env, target_ulong addr,
+                             target_ulong size, target_ulong strict)
+{
+    uintptr_t ra = GETPC();
+    int mmu_idx = riscv_env_mmu_index(env, false);
+    CPUState *cs = env_cpu(env);
+    vaddr last = addr + size - 1;
+
+    if (strict && (addr & (size - 1))) {
+        return;                 /* the real op raises misaligned first */
+    }
+
+    probe_access_perm(env, addr, size, MMU_DATA_STORE, mmu_idx, ra);
+
+    if ((addr ^ last) & TARGET_PAGE_MASK) {
+        vaddr addr1 = last & TARGET_PAGE_MASK;
+        int size1 = size - (addr1 - addr);  /* before wrapping */
+
+        addr1 = cs->cc->tcg_ops->pointer_wrap(cs, mmu_idx, addr1, addr);
+        probe_access_perm(env, addr1, size1, MMU_DATA_STORE, mmu_idx, ra);
+    }
+}
+
 target_ulong HELPER(sret)(CPURISCVState *env)
 {
     uint64_t mstatus;
diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
index 79b0f444ef..5dffb61d51 100644
--- a/target/riscv/tcg/translate.c
+++ b/target/riscv/tcg/translate.c
@@ -1150,6 +1150,25 @@ static bool gen_unary_per_ol(DisasContext *ctx, arg_r2 *a, DisasExtend ext,
     return gen_unary(ctx, a, ext, f_tl);
 }
 
+/*
+ * Zicfiss: without CF_PARALLEL, TCG lowers AMOs to load+store, so check
+ * store permission up front.  The parallel helpers (atomic_mmu_lookup)
+ * already do the store lookup first.  @strict: the real op enforces
+ * natural alignment.
+ */
+static void gen_amo_probe(DisasContext *ctx, TCGv addr, MemOp mop,
+                          bool strict)
+{
+#ifndef CONFIG_USER_ONLY
+    if (ctx->bcfi_enabled &&
+        !(tb_cflags(ctx->base.tb) & CF_PARALLEL)) {
+        gen_helper_amo_probe_write(tcg_env, addr,
+                                   tcg_constant_tl(memop_size(mop)),
+                                   tcg_constant_tl(strict));
+    }
+#endif
+}
+
 static bool gen_amo(DisasContext *ctx, arg_atomic *a,
                     void(*func)(TCGv, TCGv, TCGv, TCGArg, MemOp),
                     MemOp mop)
@@ -1157,16 +1176,19 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
     TCGv dest = dest_gpr(ctx, a->rd);
     TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
     MemOp size = mop & MO_SIZE;
+    bool strict = true;
 
     mop |= ctx->mo_endianness;
     if (ctx->cfg_ptr->ext_zama16b && size >= MO_32) {
         mop |= MO_ATOM_WITHIN16;
+        strict = false;
     } else {
         mop |= MO_ALIGN;
     }
 
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     src1 = get_address(ctx, a->rs1, 0);
+    gen_amo_probe(ctx, src1, mop, strict);
     func(dest, src1, src2, ctx->mem_idx, mop);
 
     gen_set_gpr(ctx, a->rd, dest);
@@ -1181,6 +1203,7 @@ static bool gen_cmpxchg(DisasContext *ctx, arg_atomic *a, MemOp mop)
 
     mop |= ctx->mo_endianness;
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
+    gen_amo_probe(ctx, src1, mop, true);
     tcg_gen_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx->mem_idx, mop);
 
     gen_set_gpr(ctx, a->rd, dest);
-- 
2.56.0


