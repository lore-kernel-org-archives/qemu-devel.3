Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B77EC83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 10:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZoA0-0007vf-MZ; Thu, 10 Jul 2025 06:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uZo9q-0007oH-Np
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:05:39 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uZo9m-0000hw-Lf
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:05:38 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-234c5b57557so8280645ad.3
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 03:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1752141932; x=1752746732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7nfw+bPfIpl8V4ZlasOgxrWuao9m0muQdlCU9LZ2/uE=;
 b=lCgtPqX4SS2cWSUMxLjn8XD0DqU7fAZSo+uHL0qtvuo7q50pb0UhB1N0Pd5JOBkopY
 Z4j3TvprmI/hxwHPZfq88Oi7gi6ak0n2nNVK04UINDu3WHqxAlZwOEe2XdO6h8lL7Xkm
 Rwz0H6KmDU9Ch7kqVyssnr1jPUM9d4SVOk4H1lalN4I0EbN9x1gpWBVc9MUL9e/jOhiT
 QryrsUGfQzA3VPSlVYilgGWWRTTHUeJoXmVU95b4BdUjKIKxfVjIKxLWFMvmzFLOk2mB
 ggvzL2q4gB6E27uRBgWVF2B0vbiulm+FTdD6lb1C5du6bF1FKQpke7OlDSCXc5M/2m9s
 82gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752141932; x=1752746732;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7nfw+bPfIpl8V4ZlasOgxrWuao9m0muQdlCU9LZ2/uE=;
 b=ep2Lt/KepMxcW2ixYalv7+P4xBNSuqH2j3HLj0aJBZm2wkmVCudkIZGEFRe1Muzh4N
 S0c0bnWagkw/i4mR0krw8ARqfSjQj0ICLHH8291Lu9NF5WzVXOmHKEUyZv6Zc7/vOdcP
 dczossyiScGHXVTw3vpNpPm60kERgzNwFbEHy7ZtxLs1BfbIv7AB7VoLVeNuIRbOF010
 GwThMkmd9Lq9ud7KiBqn9ux9EoD4naGztjY7OOaeRcVLMz1coYDkAylmkiGlmg48e2O0
 yeHnjh1SSJinuOHnutSQia6GW0w+PPMAER4zysaWdePnX+7/tS2nS4SuWMXb1DrGiAK7
 UC8Q==
X-Gm-Message-State: AOJu0Yxzyn5nahCXCrL+qEjpuXAHlNOdFKZ4Gidfzdj1/llr2HJgFBpI
 sJsq700ZF/cKOt0blmnca7uSBlX3bIhYcMpJN5avIIFHN+ab/NcmPMBiuFWyrMaupmI42/X6lKm
 KUQZ6
X-Gm-Gg: ASbGncuEG1zXQDpctxqYB+BXkKQUXli2s9DJxQ6XGRsemO5YnaAyuA8EBWMpjU9Tzes
 lqMQeeXsdVAFQK+1xawzPMdWNRjsi0Tv7gE1KJrWUQm+muS5cVVo8obhY4B0g0rbQytJLbrSQ9U
 xfwtFpjAXD1VWeEyO6+CFfrBEg6nXuydpLHfa0joxiDSTXurpm8xAKATJhJK1kb+Hw9YQqPx9Uj
 8psKXjMYtlppA037cOXp93bZlqWs4nhhjpXUkgW8Ho0cpoBmop3TFpzEcxLedVvEKd6IJVUMbNP
 9jS3WGjMVRXB4KaoRyNHRiSX1MvzPRoHe6W1r0sQbkGT+Gw4fY8IQQ00R82+ICRDp1wCPYqRgbj
 5YV0x7uTko6ZNM54=
X-Google-Smtp-Source: AGHT+IFZK0xtLQKJHH/5tgAHxdbZtiEPauKulNx0FQiBf+sPcw3Paw8M05l+SyZw7cXKcEt8mvAmXw==
X-Received: by 2002:a17:903:3bc7:b0:215:8d49:e2a7 with SMTP id
 d9443c01a7336-23de2512c65mr42709615ad.50.1752141931501; 
 Thu, 10 Jul 2025 03:05:31 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([189.110.107.157])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de4285c66sm15916455ad.12.2025.07.10.03.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 03:05:30 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH] riscv: Revert "Generate strided vector loads/stores with tcg
 nodes."
Date: Thu, 10 Jul 2025 07:05:25 -0300
Message-ID: <20250710100525.372985-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This reverts commit 28c12c1f2f50d7f7f1ebfc587c4777ecd50aac5b.

As reported in [1] this commit is breaking Linux vector code, and
although a simpler reproducer was provided, the fix itself isn't trivial
due to the amount and the nature of the changes. And we really do not
want to keep Linux broken while we work on it.

The revert will fix Linux and will give us time to do a proper fix.

[1] https://mail.gnu.org/archive/html/qemu-devel/2025-07/msg02525.html

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 323 ++++--------------------
 1 file changed, 50 insertions(+), 273 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 610bf9ff30..71f98fb350 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -864,286 +864,32 @@ GEN_VEXT_TRANS(vlm_v, MO_8, vlm_v, ld_us_mask_op, ld_us_mask_check)
 GEN_VEXT_TRANS(vsm_v, MO_8, vsm_v, st_us_mask_op, st_us_mask_check)
 
 /*
- * MAXSZ returns the maximum vector size can be operated in bytes,
- * which is used in GVEC IR when vl_eq_vlmax flag is set to true
- * to accelerate vector operation.
- */
-static inline uint32_t MAXSZ(DisasContext *s)
-{
-    int max_sz = s->cfg_ptr->vlenb << 3;
-    return max_sz >> (3 - s->lmul);
-}
-
-static inline uint32_t get_log2(uint32_t a)
-{
-    uint32_t i = 0;
-    for (; a > 0;) {
-        a >>= 1;
-        i++;
-    }
-    return i;
-}
-
-typedef void gen_tl_ldst(TCGv, TCGv_ptr, tcg_target_long);
-
-/*
- * Simulate the strided load/store main loop:
- *
- * for (i = env->vstart; i < env->vl; env->vstart = ++i) {
- *     k = 0;
- *     while (k < nf) {
- *         if (!vm && !vext_elem_mask(v0, i)) {
- *             vext_set_elems_1s(vd, vma, (i + k * max_elems) * esz,
- *                               (i + k * max_elems + 1) * esz);
- *             k++;
- *             continue;
- *         }
- *         target_ulong addr = base + stride * i + (k << log2_esz);
- *         ldst(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
- *         k++;
- *     }
- * }
- */
-static void gen_ldst_stride_main_loop(DisasContext *s, TCGv dest, uint32_t rs1,
-                                      uint32_t rs2, uint32_t vm, uint32_t nf,
-                                      gen_tl_ldst *ld_fn, gen_tl_ldst *st_fn,
-                                      bool is_load)
-{
-    TCGv addr = tcg_temp_new();
-    TCGv base = get_gpr(s, rs1, EXT_NONE);
-    TCGv stride = get_gpr(s, rs2, EXT_NONE);
-
-    TCGv i = tcg_temp_new();
-    TCGv i_esz = tcg_temp_new();
-    TCGv k = tcg_temp_new();
-    TCGv k_esz = tcg_temp_new();
-    TCGv k_max = tcg_temp_new();
-    TCGv mask = tcg_temp_new();
-    TCGv mask_offs = tcg_temp_new();
-    TCGv mask_offs_64 = tcg_temp_new();
-    TCGv mask_elem = tcg_temp_new();
-    TCGv mask_offs_rem = tcg_temp_new();
-    TCGv vreg = tcg_temp_new();
-    TCGv dest_offs = tcg_temp_new();
-    TCGv stride_offs = tcg_temp_new();
-
-    uint32_t max_elems = MAXSZ(s) >> s->sew;
-
-    TCGLabel *start = gen_new_label();
-    TCGLabel *end = gen_new_label();
-    TCGLabel *start_k = gen_new_label();
-    TCGLabel *inc_k = gen_new_label();
-    TCGLabel *end_k = gen_new_label();
-
-    MemOp atomicity = MO_ATOM_NONE;
-    if (s->sew == 0) {
-        atomicity = MO_ATOM_NONE;
-    } else {
-        atomicity = MO_ATOM_IFALIGN_PAIR;
-    }
-
-    mark_vs_dirty(s);
-
-    tcg_gen_addi_tl(mask, (TCGv)tcg_env, vreg_ofs(s, 0));
-
-    /* Start of outer loop. */
-    tcg_gen_mov_tl(i, cpu_vstart);
-    gen_set_label(start);
-    tcg_gen_brcond_tl(TCG_COND_GE, i, cpu_vl, end);
-    tcg_gen_shli_tl(i_esz, i, s->sew);
-    /* Start of inner loop. */
-    tcg_gen_movi_tl(k, 0);
-    gen_set_label(start_k);
-    tcg_gen_brcond_tl(TCG_COND_GE, k, tcg_constant_tl(nf), end_k);
-    /*
-     * If we are in mask agnostic regime and the operation is not unmasked we
-     * set the inactive elements to 1.
-     */
-    if (!vm && s->vma) {
-        TCGLabel *active_element = gen_new_label();
-        /* (i + k * max_elems) * esz */
-        tcg_gen_shli_tl(mask_offs, k, get_log2(max_elems << s->sew));
-        tcg_gen_add_tl(mask_offs, mask_offs, i_esz);
-
-        /*
-         * Check whether the i bit of the mask is 0 or 1.
-         *
-         * static inline int vext_elem_mask(void *v0, int index)
-         * {
-         *     int idx = index / 64;
-         *     int pos = index  % 64;
-         *     return (((uint64_t *)v0)[idx] >> pos) & 1;
-         * }
-         */
-        tcg_gen_shri_tl(mask_offs_64, mask_offs, 3);
-        tcg_gen_add_tl(mask_offs_64, mask_offs_64, mask);
-        tcg_gen_ld_i64((TCGv_i64)mask_elem, (TCGv_ptr)mask_offs_64, 0);
-        tcg_gen_rem_tl(mask_offs_rem, mask_offs, tcg_constant_tl(8));
-        tcg_gen_shr_tl(mask_elem, mask_elem, mask_offs_rem);
-        tcg_gen_andi_tl(mask_elem, mask_elem, 1);
-        tcg_gen_brcond_tl(TCG_COND_NE, mask_elem, tcg_constant_tl(0),
-                          active_element);
-        /*
-         * Set masked-off elements in the destination vector register to 1s.
-         * Store instructions simply skip this bit as memory ops access memory
-         * only for active elements.
-         */
-        if (is_load) {
-            tcg_gen_shli_tl(mask_offs, mask_offs, s->sew);
-            tcg_gen_add_tl(mask_offs, mask_offs, dest);
-            st_fn(tcg_constant_tl(-1), (TCGv_ptr)mask_offs, 0);
-        }
-        tcg_gen_br(inc_k);
-        gen_set_label(active_element);
-    }
-    /*
-     * The element is active, calculate the address with stride:
-     * target_ulong addr = base + stride * i + (k << log2_esz);
-     */
-    tcg_gen_mul_tl(stride_offs, stride, i);
-    tcg_gen_shli_tl(k_esz, k, s->sew);
-    tcg_gen_add_tl(stride_offs, stride_offs, k_esz);
-    tcg_gen_add_tl(addr, base, stride_offs);
-    /* Calculate the offset in the dst/src vector register. */
-    tcg_gen_shli_tl(k_max, k, get_log2(max_elems));
-    tcg_gen_add_tl(dest_offs, i, k_max);
-    tcg_gen_shli_tl(dest_offs, dest_offs, s->sew);
-    tcg_gen_add_tl(dest_offs, dest_offs, dest);
-    if (is_load) {
-        tcg_gen_qemu_ld_tl(vreg, addr, s->mem_idx, MO_LE | s->sew | atomicity);
-        st_fn((TCGv)vreg, (TCGv_ptr)dest_offs, 0);
-    } else {
-        ld_fn((TCGv)vreg, (TCGv_ptr)dest_offs, 0);
-        tcg_gen_qemu_st_tl(vreg, addr, s->mem_idx, MO_LE | s->sew | atomicity);
-    }
-    /*
-     * We don't execute the load/store above if the element was inactive.
-     * We jump instead directly to incrementing k and continuing the loop.
-     */
-    if (!vm && s->vma) {
-        gen_set_label(inc_k);
-    }
-    tcg_gen_addi_tl(k, k, 1);
-    tcg_gen_br(start_k);
-    /* End of the inner loop. */
-    gen_set_label(end_k);
-
-    tcg_gen_addi_tl(i, i, 1);
-    tcg_gen_mov_tl(cpu_vstart, i);
-    tcg_gen_br(start);
-
-    /* End of the outer loop. */
-    gen_set_label(end);
-
-    return;
-}
-
-
-/*
- * Set the tail bytes of the strided loads/stores to 1:
- *
- * for (k = 0; k < nf; ++k) {
- *     cnt = (k * max_elems + vl) * esz;
- *     tot = (k * max_elems + max_elems) * esz;
- *     for (i = cnt; i < tot; i += esz) {
- *         store_1s(-1, vd[vl+i]);
- *     }
- * }
+ *** stride load and store
  */
-static void gen_ldst_stride_tail_loop(DisasContext *s, TCGv dest, uint32_t nf,
-                                      gen_tl_ldst *st_fn)
-{
-    TCGv i = tcg_temp_new();
-    TCGv k = tcg_temp_new();
-    TCGv tail_cnt = tcg_temp_new();
-    TCGv tail_tot = tcg_temp_new();
-    TCGv tail_addr = tcg_temp_new();
-
-    TCGLabel *start = gen_new_label();
-    TCGLabel *end = gen_new_label();
-    TCGLabel *start_i = gen_new_label();
-    TCGLabel *end_i = gen_new_label();
-
-    uint32_t max_elems_b = MAXSZ(s);
-    uint32_t esz = 1 << s->sew;
-
-    /* Start of the outer loop. */
-    tcg_gen_movi_tl(k, 0);
-    tcg_gen_shli_tl(tail_cnt, cpu_vl, s->sew);
-    tcg_gen_movi_tl(tail_tot, max_elems_b);
-    tcg_gen_add_tl(tail_addr, dest, tail_cnt);
-    gen_set_label(start);
-    tcg_gen_brcond_tl(TCG_COND_GE, k, tcg_constant_tl(nf), end);
-    /* Start of the inner loop. */
-    tcg_gen_mov_tl(i, tail_cnt);
-    gen_set_label(start_i);
-    tcg_gen_brcond_tl(TCG_COND_GE, i, tail_tot, end_i);
-    /* store_1s(-1, vd[vl+i]); */
-    st_fn(tcg_constant_tl(-1), (TCGv_ptr)tail_addr, 0);
-    tcg_gen_addi_tl(tail_addr, tail_addr, esz);
-    tcg_gen_addi_tl(i, i, esz);
-    tcg_gen_br(start_i);
-    /* End of the inner loop. */
-    gen_set_label(end_i);
-    /* Update the counts */
-    tcg_gen_addi_tl(tail_cnt, tail_cnt, max_elems_b);
-    tcg_gen_addi_tl(tail_tot, tail_cnt, max_elems_b);
-    tcg_gen_addi_tl(k, k, 1);
-    tcg_gen_br(start);
-    /* End of the outer loop. */
-    gen_set_label(end);
-
-    return;
-}
+typedef void gen_helper_ldst_stride(TCGv_ptr, TCGv_ptr, TCGv,
+                                    TCGv, TCGv_env, TCGv_i32);
 
 static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
-                              uint32_t data, DisasContext *s, bool is_load)
+                              uint32_t data, gen_helper_ldst_stride *fn,
+                              DisasContext *s)
 {
-    if (!s->vstart_eq_zero) {
-        return false;
-    }
-
-    TCGv dest = tcg_temp_new();
-
-    uint32_t nf = FIELD_EX32(data, VDATA, NF);
-    uint32_t vm = FIELD_EX32(data, VDATA, VM);
-
-    /* Destination register and mask register */
-    tcg_gen_addi_tl(dest, (TCGv)tcg_env, vreg_ofs(s, vd));
-
-    /*
-     * Select the appropriate load/tore to retrieve data from the vector
-     * register given a specific sew.
-     */
-    static gen_tl_ldst * const ld_fns[4] = {
-        tcg_gen_ld8u_tl, tcg_gen_ld16u_tl,
-        tcg_gen_ld32u_tl, tcg_gen_ld_tl
-    };
-
-    static gen_tl_ldst * const st_fns[4] = {
-        tcg_gen_st8_tl, tcg_gen_st16_tl,
-        tcg_gen_st32_tl, tcg_gen_st_tl
-    };
+    TCGv_ptr dest, mask;
+    TCGv base, stride;
+    TCGv_i32 desc;
 
-    gen_tl_ldst *ld_fn = ld_fns[s->sew];
-    gen_tl_ldst *st_fn = st_fns[s->sew];
+    dest = tcg_temp_new_ptr();
+    mask = tcg_temp_new_ptr();
+    base = get_gpr(s, rs1, EXT_NONE);
+    stride = get_gpr(s, rs2, EXT_NONE);
+    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
+                                      s->cfg_ptr->vlenb, data));
 
-    if (ld_fn == NULL || st_fn == NULL) {
-        return false;
-    }
+    tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
+    tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
 
     mark_vs_dirty(s);
 
-    gen_ldst_stride_main_loop(s, dest, rs1, rs2, vm, nf, ld_fn, st_fn, is_load);
-
-    tcg_gen_movi_tl(cpu_vstart, 0);
-
-    /*
-     * Set the tail bytes to 1 if tail agnostic:
-     */
-    if (s->vta != 0 && is_load) {
-        gen_ldst_stride_tail_loop(s, dest, nf, st_fn);
-    }
+    fn(dest, mask, base, stride, tcg_env, desc);
 
     finalize_rvv_inst(s);
     return true;
@@ -1152,6 +898,16 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
 static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
 {
     uint32_t data = 0;
+    gen_helper_ldst_stride *fn;
+    static gen_helper_ldst_stride * const fns[4] = {
+        gen_helper_vlse8_v, gen_helper_vlse16_v,
+        gen_helper_vlse32_v, gen_helper_vlse64_v
+    };
+
+    fn = fns[eew];
+    if (fn == NULL) {
+        return false;
+    }
 
     uint8_t emul = vext_get_emul(s, eew);
     data = FIELD_DP32(data, VDATA, VM, a->vm);
@@ -1159,7 +915,7 @@ static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     data = FIELD_DP32(data, VDATA, VTA, s->vta);
     data = FIELD_DP32(data, VDATA, VMA, s->vma);
-    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, s, true);
+    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
 }
 
 static bool ld_stride_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
@@ -1177,13 +933,23 @@ GEN_VEXT_TRANS(vlse64_v, MO_64, rnfvm, ld_stride_op, ld_stride_check)
 static bool st_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
 {
     uint32_t data = 0;
+    gen_helper_ldst_stride *fn;
+    static gen_helper_ldst_stride * const fns[4] = {
+        /* masked stride store */
+        gen_helper_vsse8_v,  gen_helper_vsse16_v,
+        gen_helper_vsse32_v,  gen_helper_vsse64_v
+    };
 
     uint8_t emul = vext_get_emul(s, eew);
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, emul);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
+    fn = fns[eew];
+    if (fn == NULL) {
+        return false;
+    }
 
-    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, s, false);
+    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
 }
 
 static bool st_stride_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
@@ -1534,6 +1300,17 @@ GEN_LDST_WHOLE_TRANS(vs8r_v, int8_t, 8, false)
  *** Vector Integer Arithmetic Instructions
  */
 
+/*
+ * MAXSZ returns the maximum vector size can be operated in bytes,
+ * which is used in GVEC IR when vl_eq_vlmax flag is set to true
+ * to accelerate vector operation.
+ */
+static inline uint32_t MAXSZ(DisasContext *s)
+{
+    int max_sz = s->cfg_ptr->vlenb * 8;
+    return max_sz >> (3 - s->lmul);
+}
+
 static bool opivv_check(DisasContext *s, arg_rmrr *a)
 {
     return require_rvv(s) &&
-- 
2.50.0


