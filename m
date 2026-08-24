Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783C7C5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNZx-0003KN-Ro; Mon, 24 Aug 2026 01:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYk-0001St-O7
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:29 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYi-0001xn-Bq
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:26 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso3587952a91.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550563; x=1788155363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/8dJDx1ilTYyZ18Kjsv/DFio2MP9Dc526iF16cUqG6E=;
 b=Xwu3dsFn3e89n6qeTXVG9i9xQmfCw1IkIMJPfBNwaSOH2QXfzRM5dkAjp2a0gGNY5j
 NXRJg9el+LQ9yTheCyZLvMKnDkLniiSQUoyt4JpaAuSG4s7iSrYCMnlWe00pf0EB7lEe
 ZgxWHw69MZF01KdxSWbc2++SRYY8VzHuJ95f2sc3uzL9R5u1l/LS1iSH3wFsBKvg0rA+
 +jZ9JEN2dzKgRVOBNJiruuFEjeWlVDAdIg2J6yCURiA3cQgp2phNcvLLn/uJXHO/Yr8s
 O3QwLfAryl6itNl+1QcxaHsCKrIL825RJGjrDtxqFh50ReKNJSXm9IL4gE9cQRabUkid
 ApvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550563; x=1788155363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/8dJDx1ilTYyZ18Kjsv/DFio2MP9Dc526iF16cUqG6E=;
 b=UkAd8CBXagiw5wSblAul32CayadaghfFgkLKTXTCjR5bQXpyvHVN2BY347nNuoHZrh
 U3rBQbt4XDbYs6EU8s63mwI+dBoxssy+dMXka7z8SS2WUMNa4ei04Og4YQE6qljHWuOl
 MP04vPbQMlxutS3lj7BmcIbsfqRWEq0GW6tBszF7/TBEFt/uOLeMct1sWGc5Z9mAn5hK
 vmbBGyNDQzHwFc+2HZ8RhmjIBUG3ImqGhtq6m8RJj5aUnidT6A7paYHPxtimTtBTc+ff
 XXoihMCKFl4m+iiv1FKt02xpCHLESK42kwZraHOcC6Y14dc7hCmz+6YadNhpwYDmkWlX
 bgeg==
X-Gm-Message-State: AFuF++nOmc7t826cmXYVNwDpaw6DMvHzTC45JZtw9yBN4YeUtwjYlQS6
 2wZXyad8wCfYdb+G+JkF0XstdlK/qD4bjsUC4F3Taz88j1rj88TYhu661IMbQw==
X-Gm-Gg: AR+sD11P4s+FqMwNmqaT0JRtPnfrtHBmxixBRLs3I6FwLfTAmwzkME5oJpNyxYeJHh0
 kuEu+AsyQIrbDdLq/N4BB++GqNFdWVEve1KhkA5ctdCq4eWakygf4PdRuYYr7bqyYHaa6g01nZq
 It3fcJrLgeCv/i0AkLNuTxWDWntDWxjGb1C9nPstnx5+6ZH2qe34r44LFWFabv/3na+dZZ7CsC+
 aO5X77anTRASB6ZPyvErmeGfF+7y2b1V5nY6Boz96TNR1mh5PtxweKto5G+yJgi5NkVz11ttD+D
 y+7UPYaXXN12QsbpgjVg6R8SOqOwXHtJVP1jI+rpBT4A8+K9y3JWdA3fPcnvIHX6Sn6abq26vO0
 U/x2vVJ/OyFUYxuAtqYGVLb6O/cWHAOx2jbTvX467m6moTfFF2tkNRn0VYzDrDZbAAB98xftsi/
 pH2z5NBHFVCIYQLxXxQOD+T+E6UdRLpT1d2/f9fTY5rdIS9bAhLS6BfUc0RVAqu9WTOSQltGQDa
 DCAHw==
X-Received: by 2002:a17:90b:560d:b0:38e:9045:bac0 with SMTP id
 98e67ed59e1d1-395deea6acbmr31161319a91.5.1787550562531; 
 Sun, 23 Aug 2026 22:49:22 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:49:22 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 20/96] target/riscv: Support raising misaligned exceptions
 for vector loads/stores
Date: Mon, 24 Aug 2026 15:46:50 +1000
Message-ID: <20260824054806.2790041-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

From: Frank Chang <frank.chang@sifive.com>

When the Zicclsm extension is not enabled, raise misaligned load/store
exceptions for misaligned accesses from vector load/store instructions.

We will skip the host fast-path and fall back to the slow TLB-path to
raise misaligned load/store exceptions for the misaligned accesses when
Zicclsm extension is disabled.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260810055618.1175500-6-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/vector_helper.c            | 65 ++++++++++++++++-----
 target/riscv/tcg/insn_trans/trans_rvv.c.inc | 18 +++++-
 2 files changed, 65 insertions(+), 18 deletions(-)

diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index e321ca2616..e28d8a3d9f 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -199,20 +199,34 @@ static inline void vext_set_elem_mask(void *v0, int index,
     ((uint64_t *)v0)[idx] = deposit64(old, pos, 1, value);
 }
 
+static inline MemOpIdx vext_make_memop_idx(CPURISCVState *env, size_t size)
+{
+    int mmu_idx = riscv_env_mmu_index(env, false);
+    MemOp memop = size_memop(size) | mo_endian_env(env);
+
+    if (!riscv_cpu_cfg(env)->ext_zicclsm) {
+        memop |= MO_ALIGN;
+    }
+
+    return make_memop_idx(memop, mmu_idx);
+}
+
 /* elements operations for load and store */
 typedef void vext_ldst_elem_fn_tlb(CPURISCVState *env, abi_ptr addr,
                                    uint32_t idx, void *vd, uintptr_t retaddr);
 typedef void vext_ldst_elem_fn_host(void *vd, uint32_t idx, void *host);
 
-#define GEN_VEXT_LD_ELEM(NAME, ETYPE, H, LDSUF)             \
+#define GEN_VEXT_TLB_LD_ELEM(NAME, ETYPE, H, LDSUF)         \
 static inline QEMU_ALWAYS_INLINE                            \
 void NAME##_tlb(CPURISCVState *env, abi_ptr addr,           \
                 uint32_t idx, void *vd, uintptr_t retaddr)  \
 {                                                           \
     ETYPE *cur = ((ETYPE *)vd + H(idx));                    \
-    *cur = cpu_##LDSUF##_data_ra(env, addr, retaddr);       \
+    MemOpIdx oi = vext_make_memop_idx(env, sizeof(ETYPE));  \
+    *cur = cpu_##LDSUF##_mmu(env, addr, oi, retaddr);       \
 }                                                           \
-                                                            \
+
+#define GEN_VEXT_HOST_LD_ELEM(NAME, ETYPE, H, LDSUF)        \
 static inline QEMU_ALWAYS_INLINE                            \
 void NAME##_host(void *vd, uint32_t idx, void *host)        \
 {                                                           \
@@ -220,20 +234,27 @@ void NAME##_host(void *vd, uint32_t idx, void *host)        \
     *cur = (ETYPE)LDSUF##_p(host);                          \
 }
 
-GEN_VEXT_LD_ELEM(lde_b, uint8_t,  H1, ldub)
-GEN_VEXT_LD_ELEM(lde_h, uint16_t, H2, lduw_le)
-GEN_VEXT_LD_ELEM(lde_w, uint32_t, H4, ldl_le)
-GEN_VEXT_LD_ELEM(lde_d, uint64_t, H8, ldq_le)
+GEN_VEXT_TLB_LD_ELEM(lde_b, uint8_t,  H1, ldb)
+GEN_VEXT_TLB_LD_ELEM(lde_h, uint16_t, H2, ldw)
+GEN_VEXT_TLB_LD_ELEM(lde_w, uint32_t, H4, ldl)
+GEN_VEXT_TLB_LD_ELEM(lde_d, uint64_t, H8, ldq)
 
-#define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)             \
+GEN_VEXT_HOST_LD_ELEM(lde_b, uint8_t,  H1, ldub)
+GEN_VEXT_HOST_LD_ELEM(lde_h, uint16_t, H2, lduw_le)
+GEN_VEXT_HOST_LD_ELEM(lde_w, uint32_t, H4, ldl_le)
+GEN_VEXT_HOST_LD_ELEM(lde_d, uint64_t, H8, ldq_le)
+
+#define GEN_VEXT_TLB_ST_ELEM(NAME, ETYPE, H, STSUF)         \
 static inline QEMU_ALWAYS_INLINE                            \
 void NAME##_tlb(CPURISCVState *env, abi_ptr addr,           \
                 uint32_t idx, void *vd, uintptr_t retaddr)  \
 {                                                           \
     ETYPE data = *((ETYPE *)vd + H(idx));                   \
-    cpu_##STSUF##_data_ra(env, addr, data, retaddr);        \
+    MemOpIdx oi = vext_make_memop_idx(env, sizeof(ETYPE));  \
+    cpu_##STSUF##_mmu(env, addr, data, oi, retaddr);        \
 }                                                           \
-                                                            \
+
+#define GEN_VEXT_HOST_ST_ELEM(NAME, ETYPE, H, STSUF)        \
 static inline QEMU_ALWAYS_INLINE                            \
 void NAME##_host(void *vd, uint32_t idx, void *host)        \
 {                                                           \
@@ -241,10 +262,15 @@ void NAME##_host(void *vd, uint32_t idx, void *host)        \
     STSUF##_p(host, data);                                  \
 }
 
-GEN_VEXT_ST_ELEM(ste_b, uint8_t,  H1, stb)
-GEN_VEXT_ST_ELEM(ste_h, uint16_t, H2, stw_le)
-GEN_VEXT_ST_ELEM(ste_w, uint32_t, H4, stl_le)
-GEN_VEXT_ST_ELEM(ste_d, uint64_t, H8, stq_le)
+GEN_VEXT_TLB_ST_ELEM(ste_b, uint8_t,  H1, stb)
+GEN_VEXT_TLB_ST_ELEM(ste_h, uint16_t, H2, stw)
+GEN_VEXT_TLB_ST_ELEM(ste_w, uint32_t, H4, stl)
+GEN_VEXT_TLB_ST_ELEM(ste_d, uint64_t, H8, stq)
+
+GEN_VEXT_HOST_ST_ELEM(ste_b, uint8_t,  H1, stb)
+GEN_VEXT_HOST_ST_ELEM(ste_h, uint16_t, H2, stw_le)
+GEN_VEXT_HOST_ST_ELEM(ste_w, uint32_t, H4, stl_le)
+GEN_VEXT_HOST_ST_ELEM(ste_d, uint64_t, H8, stq_le)
 
 static inline QEMU_ALWAYS_INLINE void
 vext_continuous_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
@@ -398,7 +424,16 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
     probe_pages(env, addr, size, ra, access_type, mmu_index, &host, &flags,
                 true);
 
-    if (flags == 0) {
+    bool misaligned = addr & (esz - 1);
+
+    /*
+     * Allow the host fast-pash when:
+     *   1. Page permission/pmp/watchpoint are checked and we have a contigous
+     *      host mapping.
+     *   2. Zicclsm is enabled or load/store is not a misaligned access.
+     * Otherwise, we will fall back to the slow TLB-path.
+     */
+    if (flags == 0 && (riscv_cpu_cfg(env)->ext_zicclsm || !misaligned)) {
         if (nf == 1) {
             vext_continuous_ldst_host(env, ldst_host, vd, evl, env->vstart,
                                       host, esz, is_load);
diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
index 23262b1d03..a22e2cae6c 100644
--- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
@@ -1191,26 +1191,38 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
      * Use the helper function if either:
      * - vstart is not 0.
      */
-
     bool use_helper_fn = !s->vstart_eq_zero;
 
     if (!use_helper_fn) {
         uint32_t size = s->cfg_ptr->vlenb * nf;
         TCGv_i64 t8 = tcg_temp_new_i64();
         MemOp atomicity = MO_ATOM_NONE;
+        MemOp alignment = MO_UNALN;
+
+        /*
+         * If Zicclsm is disabled, require alignment based on element size.
+         * Use MO_ALIGN_* based on log2_esz (0 = MO_UNALN, 1 = MO_ALIGN_2, etc).
+         */
+        if (!s->cfg_ptr->ext_zicclsm) {
+            alignment = log2_esz << MO_ASHIFT;
+        }
+
         if (log2_esz == 0) {
             atomicity = MO_ATOM_NONE;
         } else {
             atomicity = MO_ATOM_IFALIGN_PAIR;
         }
+
         for (int i = 0; i < size; i += 8) {
             TCGv addr = get_address(s, rs1, i);
             if (is_load) {
-                tcg_gen_qemu_ld_i64(t8, addr, s->mem_idx, MO_LEUQ | atomicity);
+                tcg_gen_qemu_ld_i64(t8, addr, s->mem_idx,
+                                    MO_LEUQ | atomicity | alignment);
                 tcg_gen_st_i64(t8, tcg_env, vreg_ofs(s, vd) + i);
             } else {
                 tcg_gen_ld_i64(t8, tcg_env, vreg_ofs(s, vd) + i);
-                tcg_gen_qemu_st_i64(t8, addr, s->mem_idx, MO_LEUQ | atomicity);
+                tcg_gen_qemu_st_i64(t8, addr, s->mem_idx,
+                                    MO_LEUQ | atomicity | alignment);
             }
             if (i == size - 8) {
                 tcg_gen_movi_i32(cpu_vstart, 0);
-- 
2.54.0


