Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81151C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 15:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsORH-0005We-Kq; Wed, 12 Mar 2025 11:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tsOR4-0005TZ-Ff
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 11:56:03 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tsOR1-0006Bh-Dn
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 11:55:58 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso73901935e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 08:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1741794951; x=1742399751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cHWlT+6QGuOJhNJ+hFgxDOqJOlxwlR0tU1tgg6QxyE0=;
 b=CMmVQ0SJj4ISKJVUyJ/yHIUJDeDITzx8hSIOsxyWyINgJkHB4b/bzyiJ0FlApipae/
 wlz+MtW+BSo2zts5H6iTnWuKxeya5bB1XtH23hyWPsMgmHJqq8Lv0Gt7ASqS18R5rwch
 V9deyHMPdGQaqtAuoYuh0NdGOLvOBZqlAEAqyLJJfwvYKFRpVThHGABvqrN5Ck4PhPKr
 UU26KnZJU3TwkuXiZmqqV+uBtEozPw5cfH4F/AV1M+PL3En6uOARDyi47ALrT89FIAfw
 R7x4qkIkrTWZXSGnv3S2j+V6wSh9RYsIwGb1SMjIIsJAZW/CenH/idUaFsqLp5xy8W8a
 EuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741794951; x=1742399751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cHWlT+6QGuOJhNJ+hFgxDOqJOlxwlR0tU1tgg6QxyE0=;
 b=TqqqcIeM+YJ73bOAPX/M5Gb9v8ypUik2SG2I6ODVsQZxyRjsG5/EdUr7WruVVhEE5E
 O68NiwDYSKKEqvu2uNDFWIXVOjVs1QRxmAI6D6HY/6wxx19h/LhDsvhIxsLZC1Wq3J/M
 tGQ9tjCr1cABpgSwYRx1ElalkVDcZ8R6sfCMoZw8eCVFVGtsnLO3he/kj2gk2gc771H8
 KG0apka+ifsoXTkslr8AmU166vzM9nBSHGyPajOaTM+cZLzM6chYleTb8aDnV1E6wrks
 a7asEyIktkStK1u6MNPc4tmf8DkkJ/V9jaWVphI7kWfW+yuiwGHFnB0/c2cK2OUa98wh
 qmfQ==
X-Gm-Message-State: AOJu0YxOWMA91Qt1HJBUy1Gz16RyK0FwqvPCLBQp/MlKg3uI6mqA9ekC
 XZOgy5TgxsBgNd+/V1QEY+9J8HbmySUmZB11NvmcR+q6C9KB7/wmrBN6vZYTYxhFu7ttvXXyDoQ
 4DrLNZg==
X-Gm-Gg: ASbGncvEmfZ5A+t7cpeTRc3vIQtAdkKDnEnCSO7i12rLF678bc0ji+9RnVsTPS+AtVb
 G1LONd9HXJs20sMr9MAUw0Y9cc4F9+GtfM2xzhXxLiJ1jiid0NIufVm54tslEBDRbLbmm/dmNh6
 N9PgtLyQZzbBGkA0KnC1Tj8ozb+pYXIXQFHhDHr+TNge+xGUfIMdljREFvDVB2vmTBlalvlFKMR
 S/0SQ5Oi4ljU1MdFYURqFbBj7JDpbYFiqlMrWlsSVynH1VGDahFDQGu7JMVV9GxBawrYgaBDhtl
 +aXE9df4b0ZGBhP5H28baxtCNznftUFH8EP6SCL4TfGvOgkLdoLCvFmOTjcVxsk=
X-Google-Smtp-Source: AGHT+IGDqja6eaRVNzn9jWfrwRanCI906YejVZVwRMuKjn9bf3mMs2IeF8QfuISorwUrTzFuYpQMOw==
X-Received: by 2002:a05:600c:3b24:b0:43d:b85:1831 with SMTP id
 5b1f17b1804b1-43d147ffaa8mr15721845e9.0.1741794951103; 
 Wed, 12 Mar 2025 08:55:51 -0700 (PDT)
Received: from paolo-laptop-amd.. ([2a0e:cb01:d3:f100:3f9b:7278:8381:286b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0ac26758sm23583115e9.35.2025.03.12.08.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 08:55:50 -0700 (PDT)
From: Paolo Savini <paolo.savini@embecosm.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Savini <paolo.savini@embecosm.com>,
 Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>,
 Jeremy Bennett <jeremy.bennett@embecosm.com>,
 Craig Blackmore <craig.blackmore@embecosm.com>
Subject: [PATCH 1/1 v2] [RISC-V/RVV] Generate strided vector loads/stores with
 tcg nodes.
Date: Wed, 12 Mar 2025 15:55:47 +0000
Message-ID: <20250312155547.289642-2-paolo.savini@embecosm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312155547.289642-1-paolo.savini@embecosm.com>
References: <20250312155547.289642-1-paolo.savini@embecosm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=paolo.savini@embecosm.com; helo=mail-wm1-x336.google.com
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

This commit improves the performance of QEMU when emulating strided vector
loads and stores by substituting the call for the helper function with the
generation of equivalent TCG operations.

Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 323 ++++++++++++++++++++----
 1 file changed, 273 insertions(+), 50 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index b9883a5d32..7079f758ad 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -802,32 +802,286 @@ GEN_VEXT_TRANS(vlm_v, MO_8, vlm_v, ld_us_mask_op, ld_us_mask_check)
 GEN_VEXT_TRANS(vsm_v, MO_8, vsm_v, st_us_mask_op, st_us_mask_check)
 
 /*
- *** stride load and store
+ * MAXSZ returns the maximum vector size can be operated in bytes,
+ * which is used in GVEC IR when vl_eq_vlmax flag is set to true
+ * to accelerate vector operation.
+ */
+static inline uint32_t MAXSZ(DisasContext *s)
+{
+    int max_sz = s->cfg_ptr->vlenb << 3;
+    return max_sz >> (3 - s->lmul);
+}
+
+static inline uint32_t get_log2(uint32_t a)
+{
+    uint32_t i = 0;
+    for (; a > 0;) {
+        a >>= 1;
+        i++;
+    }
+    return i;
+}
+
+typedef void gen_tl_ldst(TCGv, TCGv_ptr, tcg_target_long);
+
+/*
+ * Simulate the strided load/store main loop:
+ *
+ * for (i = env->vstart; i < env->vl; env->vstart = ++i) {
+ *     k = 0;
+ *     while (k < nf) {
+ *         if (!vm && !vext_elem_mask(v0, i)) {
+ *             vext_set_elems_1s(vd, vma, (i + k * max_elems) * esz,
+ *                               (i + k * max_elems + 1) * esz);
+ *             k++;
+ *             continue;
+ *         }
+ *         target_ulong addr = base + stride * i + (k << log2_esz);
+ *         ldst(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
+ *         k++;
+ *     }
+ * }
+ */
+static void gen_ldst_stride_main_loop(DisasContext *s, TCGv dest, uint32_t rs1,
+                                      uint32_t rs2, uint32_t vm, uint32_t nf,
+                                      gen_tl_ldst *ld_fn, gen_tl_ldst *st_fn,
+                                      bool is_load)
+{
+    TCGv addr = tcg_temp_new();
+    TCGv base = get_gpr(s, rs1, EXT_NONE);
+    TCGv stride = get_gpr(s, rs2, EXT_NONE);
+
+    TCGv i = tcg_temp_new();
+    TCGv i_esz = tcg_temp_new();
+    TCGv k = tcg_temp_new();
+    TCGv k_esz = tcg_temp_new();
+    TCGv k_max = tcg_temp_new();
+    TCGv mask = tcg_temp_new();
+    TCGv mask_offs = tcg_temp_new();
+    TCGv mask_offs_64 = tcg_temp_new();
+    TCGv mask_elem = tcg_temp_new();
+    TCGv mask_offs_rem = tcg_temp_new();
+    TCGv vreg = tcg_temp_new();
+    TCGv dest_offs = tcg_temp_new();
+    TCGv stride_offs = tcg_temp_new();
+
+    uint32_t max_elems = MAXSZ(s) >> s->sew;
+
+    TCGLabel *start = gen_new_label();
+    TCGLabel *end = gen_new_label();
+    TCGLabel *start_k = gen_new_label();
+    TCGLabel *inc_k = gen_new_label();
+    TCGLabel *end_k = gen_new_label();
+
+    MemOp atomicity = MO_ATOM_NONE;
+    if (s->sew == 0) {
+        atomicity = MO_ATOM_NONE;
+    } else {
+        atomicity = MO_ATOM_IFALIGN_PAIR;
+    }
+
+    mark_vs_dirty(s);
+
+    tcg_gen_addi_tl(mask, (TCGv)tcg_env, vreg_ofs(s, 0));
+
+    /* Start of outer loop. */
+    tcg_gen_mov_tl(i, cpu_vstart);
+    gen_set_label(start);
+    tcg_gen_brcond_tl(TCG_COND_GE, i, cpu_vl, end);
+    tcg_gen_shli_tl(i_esz, i, s->sew);
+    /* Start of inner loop. */
+    tcg_gen_movi_tl(k, 0);
+    gen_set_label(start_k);
+    tcg_gen_brcond_tl(TCG_COND_GE, k, tcg_constant_tl(nf), end_k);
+    /*
+     * If we are in mask agnostic regime and the operation is not unmasked we
+     * set the inactive elements to 1.
+     */
+    if (!vm && s->vma) {
+        TCGLabel *active_element = gen_new_label();
+        /* (i + k * max_elems) * esz */
+        tcg_gen_shli_tl(mask_offs, k, get_log2(max_elems << s->sew));
+        tcg_gen_add_tl(mask_offs, mask_offs, i_esz);
+
+        /*
+         * Check whether the i bit of the mask is 0 or 1.
+         *
+         * static inline int vext_elem_mask(void *v0, int index)
+         * {
+         *     int idx = index / 64;
+         *     int pos = index  % 64;
+         *     return (((uint64_t *)v0)[idx] >> pos) & 1;
+         * }
+         */
+        tcg_gen_shri_tl(mask_offs_64, mask_offs, 3);
+        tcg_gen_add_tl(mask_offs_64, mask_offs_64, mask);
+        tcg_gen_ld_i64((TCGv_i64)mask_elem, (TCGv_ptr)mask_offs_64, 0);
+        tcg_gen_rem_tl(mask_offs_rem, mask_offs, tcg_constant_tl(8));
+        tcg_gen_shr_tl(mask_elem, mask_elem, mask_offs_rem);
+        tcg_gen_andi_tl(mask_elem, mask_elem, 1);
+        tcg_gen_brcond_tl(TCG_COND_NE, mask_elem, tcg_constant_tl(0),
+                          active_element);
+        /*
+         * Set masked-off elements in the destination vector register to 1s.
+         * Store instructions simply skip this bit as memory ops access memory
+         * only for active elements.
+         */
+        if (is_load) {
+            tcg_gen_shli_tl(mask_offs, mask_offs, s->sew);
+            tcg_gen_add_tl(mask_offs, mask_offs, dest);
+            st_fn(tcg_constant_tl(-1), (TCGv_ptr)mask_offs, 0);
+        }
+        tcg_gen_br(inc_k);
+        gen_set_label(active_element);
+    }
+    /*
+     * The element is active, calculate the address with stride:
+     * target_ulong addr = base + stride * i + (k << log2_esz);
+     */
+    tcg_gen_mul_tl(stride_offs, stride, i);
+    tcg_gen_shli_tl(k_esz, k, s->sew);
+    tcg_gen_add_tl(stride_offs, stride_offs, k_esz);
+    tcg_gen_add_tl(addr, base, stride_offs);
+    /* Calculate the offset in the dst/src vector register. */
+    tcg_gen_shli_tl(k_max, k, get_log2(max_elems));
+    tcg_gen_add_tl(dest_offs, i, k_max);
+    tcg_gen_shli_tl(dest_offs, dest_offs, s->sew);
+    tcg_gen_add_tl(dest_offs, dest_offs, dest);
+    if (is_load) {
+        tcg_gen_qemu_ld_tl(vreg, addr, s->mem_idx, MO_LE | s->sew | atomicity);
+        st_fn((TCGv)vreg, (TCGv_ptr)dest_offs, 0);
+    } else {
+        ld_fn((TCGv)vreg, (TCGv_ptr)dest_offs, 0);
+        tcg_gen_qemu_st_tl(vreg, addr, s->mem_idx, MO_LE | s->sew | atomicity);
+    }
+    /*
+     * We don't execute the load/store above if the element was inactive.
+     * We jump instead directly to incrementing k and continuing the loop.
+     */
+    if (!vm && s->vma) {
+        gen_set_label(inc_k);
+    }
+    tcg_gen_addi_tl(k, k, 1);
+    tcg_gen_br(start_k);
+    /* End of the inner loop. */
+    gen_set_label(end_k);
+
+    tcg_gen_addi_tl(i, i, 1);
+    tcg_gen_mov_tl(cpu_vstart, i);
+    tcg_gen_br(start);
+
+    /* End of the outer loop. */
+    gen_set_label(end);
+
+    return;
+}
+
+
+/*
+ * Set the tail bytes of the strided loads/stores to 1:
+ *
+ * for (k = 0; k < nf; ++k) {
+ *     cnt = (k * max_elems + vl) * esz;
+ *     tot = (k * max_elems + max_elems) * esz;
+ *     for (i = cnt; i < tot; i += esz) {
+ *         store_1s(-1, vd[vl+i]);
+ *     }
+ * }
  */
-typedef void gen_helper_ldst_stride(TCGv_ptr, TCGv_ptr, TCGv,
-                                    TCGv, TCGv_env, TCGv_i32);
+static void gen_ldst_stride_tail_loop(DisasContext *s, TCGv dest, uint32_t nf,
+                                      gen_tl_ldst *st_fn)
+{
+    TCGv i = tcg_temp_new();
+    TCGv k = tcg_temp_new();
+    TCGv tail_cnt = tcg_temp_new();
+    TCGv tail_tot = tcg_temp_new();
+    TCGv tail_addr = tcg_temp_new();
+
+    TCGLabel *start = gen_new_label();
+    TCGLabel *end = gen_new_label();
+    TCGLabel *start_i = gen_new_label();
+    TCGLabel *end_i = gen_new_label();
+
+    uint32_t max_elems_b = MAXSZ(s);
+    uint32_t esz = 1 << s->sew;
+
+    /* Start of the outer loop. */
+    tcg_gen_movi_tl(k, 0);
+    tcg_gen_shli_tl(tail_cnt, cpu_vl, s->sew);
+    tcg_gen_movi_tl(tail_tot, max_elems_b);
+    tcg_gen_add_tl(tail_addr, dest, tail_cnt);
+    gen_set_label(start);
+    tcg_gen_brcond_tl(TCG_COND_GE, k, tcg_constant_tl(nf), end);
+    /* Start of the inner loop. */
+    tcg_gen_mov_tl(i, tail_cnt);
+    gen_set_label(start_i);
+    tcg_gen_brcond_tl(TCG_COND_GE, i, tail_tot, end_i);
+    /* store_1s(-1, vd[vl+i]); */
+    st_fn(tcg_constant_tl(-1), (TCGv_ptr)tail_addr, 0);
+    tcg_gen_addi_tl(tail_addr, tail_addr, esz);
+    tcg_gen_addi_tl(i, i, esz);
+    tcg_gen_br(start_i);
+    /* End of the inner loop. */
+    gen_set_label(end_i);
+    /* Update the counts */
+    tcg_gen_addi_tl(tail_cnt, tail_cnt, max_elems_b);
+    tcg_gen_addi_tl(tail_tot, tail_cnt, max_elems_b);
+    tcg_gen_addi_tl(k, k, 1);
+    tcg_gen_br(start);
+    /* End of the outer loop. */
+    gen_set_label(end);
+
+    return;
+}
 
 static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
-                              uint32_t data, gen_helper_ldst_stride *fn,
-                              DisasContext *s)
+                              uint32_t data, DisasContext *s, bool is_load)
 {
-    TCGv_ptr dest, mask;
-    TCGv base, stride;
-    TCGv_i32 desc;
+    if (!s->vstart_eq_zero) {
+        return false;
+    }
 
-    dest = tcg_temp_new_ptr();
-    mask = tcg_temp_new_ptr();
-    base = get_gpr(s, rs1, EXT_NONE);
-    stride = get_gpr(s, rs2, EXT_NONE);
-    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
-                                      s->cfg_ptr->vlenb, data));
+    TCGv dest = tcg_temp_new();
 
-    tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
-    tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
+    uint32_t nf = FIELD_EX32(data, VDATA, NF);
+    uint32_t vm = FIELD_EX32(data, VDATA, VM);
+
+    /* Destination register and mask register */
+    tcg_gen_addi_tl(dest, (TCGv)tcg_env, vreg_ofs(s, vd));
+
+    /*
+     * Select the appropriate load/tore to retrieve data from the vector
+     * register given a specific sew.
+     */
+    static gen_tl_ldst * const ld_fns[4] = {
+        tcg_gen_ld8u_tl, tcg_gen_ld16u_tl,
+        tcg_gen_ld32u_tl, tcg_gen_ld_tl
+    };
+
+    static gen_tl_ldst * const st_fns[4] = {
+        tcg_gen_st8_tl, tcg_gen_st16_tl,
+        tcg_gen_st32_tl, tcg_gen_st_tl
+    };
+
+    gen_tl_ldst *ld_fn = ld_fns[s->sew];
+    gen_tl_ldst *st_fn = st_fns[s->sew];
+
+    if (ld_fn == NULL || st_fn == NULL) {
+        return false;
+    }
 
     mark_vs_dirty(s);
 
-    fn(dest, mask, base, stride, tcg_env, desc);
+    gen_ldst_stride_main_loop(s, dest, rs1, rs2, vm, nf, ld_fn, st_fn, is_load);
+
+    tcg_gen_movi_tl(cpu_vstart, 0);
+
+    /*
+     * Set the tail bytes to 1 if tail agnostic:
+     */
+    if (s->vta != 0 && is_load) {
+        gen_ldst_stride_tail_loop(s, dest, nf, st_fn);
+    }
 
     finalize_rvv_inst(s);
     return true;
@@ -836,16 +1090,6 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
 static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
 {
     uint32_t data = 0;
-    gen_helper_ldst_stride *fn;
-    static gen_helper_ldst_stride * const fns[4] = {
-        gen_helper_vlse8_v, gen_helper_vlse16_v,
-        gen_helper_vlse32_v, gen_helper_vlse64_v
-    };
-
-    fn = fns[eew];
-    if (fn == NULL) {
-        return false;
-    }
 
     uint8_t emul = vext_get_emul(s, eew);
     data = FIELD_DP32(data, VDATA, VM, a->vm);
@@ -853,7 +1097,7 @@ static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     data = FIELD_DP32(data, VDATA, VTA, s->vta);
     data = FIELD_DP32(data, VDATA, VMA, s->vma);
-    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
+    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, s, true);
 }
 
 static bool ld_stride_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
@@ -871,23 +1115,13 @@ GEN_VEXT_TRANS(vlse64_v, MO_64, rnfvm, ld_stride_op, ld_stride_check)
 static bool st_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
 {
     uint32_t data = 0;
-    gen_helper_ldst_stride *fn;
-    static gen_helper_ldst_stride * const fns[4] = {
-        /* masked stride store */
-        gen_helper_vsse8_v,  gen_helper_vsse16_v,
-        gen_helper_vsse32_v,  gen_helper_vsse64_v
-    };
 
     uint8_t emul = vext_get_emul(s, eew);
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, emul);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
-    fn = fns[eew];
-    if (fn == NULL) {
-        return false;
-    }
 
-    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
+    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, s, false);
 }
 
 static bool st_stride_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
@@ -1169,17 +1403,6 @@ GEN_LDST_WHOLE_TRANS(vs8r_v, 8)
  *** Vector Integer Arithmetic Instructions
  */
 
-/*
- * MAXSZ returns the maximum vector size can be operated in bytes,
- * which is used in GVEC IR when vl_eq_vlmax flag is set to true
- * to accelerate vector operation.
- */
-static inline uint32_t MAXSZ(DisasContext *s)
-{
-    int max_sz = s->cfg_ptr->vlenb * 8;
-    return max_sz >> (3 - s->lmul);
-}
-
 static bool opivv_check(DisasContext *s, arg_rmrr *a)
 {
     return require_rvv(s) &&
-- 
2.34.1


