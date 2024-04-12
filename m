Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38CEC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBw8-00069k-On; Fri, 12 Apr 2024 04:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvBw6-00069W-Ap; Fri, 12 Apr 2024 04:07:02 -0400
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvBw2-0004yV-VT; Fri, 12 Apr 2024 04:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712909213; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=G99+1JUges/zyQw0rpQMt4VPdKw1dFUmH+MQFBw98yk=;
 b=Afqrq3ZDSmRSBQXgZy2eo7L0voucSGsS/wkrfjT/TtG9YEc7xXyHvfR3E44nb/VAlQBCx4ytZ9POSGP5vwBFWjdiZWJ6LNUtzcQBGPtZrf+uOwxcJWJ0hRlEKL5n3c8GEXD/HisMkoqTcRkhrXsmiHk1jnFA2z5CwLp49BGfK2I=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4Nai7w_1712909211; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4Nai7w_1712909211) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 16:06:51 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 14/65] target/riscv: Add unit-stride fault-only-first
 instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:36:44 +0800
Message-ID: <20240412073735.76413-15-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.100;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-100.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

XTheadVector unit-stride fault-only-first instructions diff from RVV1.0 in
the following points:
1. Different mask reg layout.
2. Different vector reg element width.
3. Different tail/masked elements process policy.
4. Different check policy.
The detials of the difference are the same as unit-stride load instructions,
as unit-stride fault-only-first instructions are the he special cases of
unit-stride load operations.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         |  22 ++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc |  57 +++++++--
 target/riscv/vector_helper.c                  |   2 +-
 target/riscv/vector_internals.h               |   5 +
 target/riscv/xtheadvector_helper.c            | 119 ++++++++++++++++++
 5 files changed, 197 insertions(+), 8 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index fd81db2f74..1bf4c38c4b 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1422,3 +1422,25 @@ DEF_HELPER_6(th_vsxe_v_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vsxe_v_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vsxe_v_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vsxe_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(th_vlbff_v_b, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlbff_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlbff_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlbff_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlhff_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlhff_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlhff_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlwff_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlwff_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vleff_v_b, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vleff_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vleff_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vleff_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlbuff_v_b, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlbuff_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlbuff_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlbuff_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlhuff_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlhuff_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlhuff_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlwuff_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlwuff_v_d, void, ptr, ptr, tl, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 68a2a9a0cf..3548a6c2cc 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -582,19 +582,62 @@ GEN_TH_TRANS(th_vsxh_v, 1, rnfvm, st_index_op_th, st_index_check_th)
 GEN_TH_TRANS(th_vsxw_v, 2, rnfvm, st_index_op_th, st_index_check_th)
 GEN_TH_TRANS(th_vsxe_v, 3, rnfvm, st_index_op_th, st_index_check_th)
 
+/*
+ * unit stride fault-only-first load
+ */
+
+/*
+ * This function is almost the copy of ldff_op, except:
+ * 1) different data encoding.
+ * 2) XTheadVector has more insns to handle zero/sign-extended.
+ */
+static bool ldff_op_th(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
+{
+    uint32_t data = 0;
+    gen_helper_ldst_us_th *fn;
+    static gen_helper_ldst_us_th * const fns[7][4] = {
+        { gen_helper_th_vlbff_v_b,  gen_helper_th_vlbff_v_h,
+          gen_helper_th_vlbff_v_w,  gen_helper_th_vlbff_v_d },
+        { NULL,                     gen_helper_th_vlhff_v_h,
+          gen_helper_th_vlhff_v_w,  gen_helper_th_vlhff_v_d },
+        { NULL,                     NULL,
+          gen_helper_th_vlwff_v_w,  gen_helper_th_vlwff_v_d },
+        { gen_helper_th_vleff_v_b,  gen_helper_th_vleff_v_h,
+          gen_helper_th_vleff_v_w,  gen_helper_th_vleff_v_d },
+        { gen_helper_th_vlbuff_v_b, gen_helper_th_vlbuff_v_h,
+          gen_helper_th_vlbuff_v_w, gen_helper_th_vlbuff_v_d },
+        { NULL,                     gen_helper_th_vlhuff_v_h,
+          gen_helper_th_vlhuff_v_w, gen_helper_th_vlhuff_v_d },
+        { NULL,                     NULL,
+          gen_helper_th_vlwuff_v_w, gen_helper_th_vlwuff_v_d }
+    };
+
+    fn =  fns[seq][s->sew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    data = FIELD_DP32(data, VDATA_TH, MLEN, s->mlen);
+    data = FIELD_DP32(data, VDATA_TH, VM, a->vm);
+    data = FIELD_DP32(data, VDATA_TH, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA_TH, NF, a->nf);
+    return ldff_trans(a->rd, a->rs1, data, fn, s);
+}
+
+GEN_TH_TRANS(th_vlbff_v, 0, r2nfvm, ldff_op_th, ld_us_check_th)
+GEN_TH_TRANS(th_vlhff_v, 1, r2nfvm, ldff_op_th, ld_us_check_th)
+GEN_TH_TRANS(th_vlwff_v, 2, r2nfvm, ldff_op_th, ld_us_check_th)
+GEN_TH_TRANS(th_vleff_v, 3, r2nfvm, ldff_op_th, ld_us_check_th)
+GEN_TH_TRANS(th_vlbuff_v, 4, r2nfvm, ldff_op_th, ld_us_check_th)
+GEN_TH_TRANS(th_vlhuff_v, 5, r2nfvm, ldff_op_th, ld_us_check_th)
+GEN_TH_TRANS(th_vlwuff_v, 6, r2nfvm, ldff_op_th, ld_us_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vlbff_v)
-TH_TRANS_STUB(th_vlhff_v)
-TH_TRANS_STUB(th_vlwff_v)
-TH_TRANS_STUB(th_vleff_v)
-TH_TRANS_STUB(th_vlbuff_v)
-TH_TRANS_STUB(th_vlhuff_v)
-TH_TRANS_STUB(th_vlwuff_v)
 TH_TRANS_STUB(th_vamoswapw_v)
 TH_TRANS_STUB(th_vamoaddw_v)
 TH_TRANS_STUB(th_vamoxorw_v)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 49b5027371..695cb7dfec 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -112,7 +112,7 @@ static inline uint32_t vext_max_elems(uint32_t desc, uint32_t log2_esz)
  * and page table walk can't fill the TLB entry. Then the guest
  * software can return here after process the exception or never return.
  */
-static void probe_pages(CPURISCVState *env, target_ulong addr,
+void probe_pages(CPURISCVState *env, target_ulong addr,
                         target_ulong len, uintptr_t ra,
                         MMUAccessType access_type)
 {
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index a692462bf1..ff10cd3806 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -243,4 +243,9 @@ target_ulong idx_b(target_ulong base, uint32_t idx, void *vs2);
 target_ulong idx_h(target_ulong base, uint32_t idx, void *vs2);
 target_ulong idx_w(target_ulong base, uint32_t idx, void *vs2);
 target_ulong idx_d(target_ulong base, uint32_t idx, void *vs2);
+
+void probe_pages(CPURISCVState *env, target_ulong addr,
+                 target_ulong len, uintptr_t ra,
+                 MMUAccessType access_type);
+
 #endif /* TARGET_RISCV_VECTOR_INTERNALS_H */
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 22af4774df..af814688b5 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -542,3 +542,122 @@ GEN_TH_ST_INDEX(th_vsxe_v_b, int8_t,  int8_t,  idx_b, ste_b)
 GEN_TH_ST_INDEX(th_vsxe_v_h, int16_t, int16_t, idx_h, ste_h)
 GEN_TH_ST_INDEX(th_vsxe_v_w, int32_t, int32_t, idx_w, ste_w)
 GEN_TH_ST_INDEX(th_vsxe_v_d, int64_t, int64_t, idx_d, ste_d)
+
+/*
+ * unit-stride fault-only-first load instructions
+ */
+
+/*
+ * This function is almost the copy of vext_ldff, except:
+ * 1) different mask layout
+ * 2) different data encoding
+ * 3) different mask/tail elements process policy
+ */
+static inline void
+th_ldff(void *vd, void *v0, target_ulong base,
+        CPURISCVState *env, uint32_t desc,
+        th_ldst_elem_fn *ldst_elem,
+        clear_fn *clear_elem,
+        uint32_t esz, uint32_t msz, uintptr_t ra)
+{
+    void *host;
+    uint32_t i, k, vl = 0;
+    uint32_t mlen = th_mlen(desc);
+    uint32_t nf = th_nf(desc);
+    uint32_t vm = th_vm(desc);
+    uint32_t vlmax = th_maxsz(desc) / esz;
+    target_ulong addr, offset, remain;
+    int mmu_index = riscv_env_mmu_index(env, false);
+
+    VSTART_CHECK_EARLY_EXIT(env);
+    /* probe every access*/
+    for (i = env->vstart; i < env->vl; i++) {
+        if (!vm && !th_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        addr = adjust_addr(env, base + nf * i * msz);
+        if (i == 0) {
+            probe_pages(env, addr, nf * msz, ra, MMU_DATA_LOAD);
+        } else {
+            /* if it triggers an exception, no need to check watchpoint */
+            remain = nf * msz;
+            while (remain > 0) {
+                offset = -(addr | TARGET_PAGE_MASK);
+                host = tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD, mmu_index);
+                if (host) {
+#ifdef CONFIG_USER_ONLY
+                    if (!page_check_range(addr, offset, PAGE_READ)) {
+                        vl = i;
+                        goto ProbeSuccess;
+                    }
+#else
+                    probe_pages(env, addr, offset, ra, MMU_DATA_LOAD);
+#endif
+                } else {
+                    vl = i;
+                    goto ProbeSuccess;
+                }
+                if (remain <=  offset) {
+                    break;
+                }
+                remain -= offset;
+                addr = adjust_addr(env, addr + offset);
+            }
+        }
+    }
+ProbeSuccess:
+    /* load bytes from guest memory */
+    if (vl != 0) {
+        env->vl = vl;
+    }
+    for (i = env->vstart; i < env->vl; i++) {
+        k = 0;
+        if (!vm && !th_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        while (k < nf) {
+            addr = base + (i * nf + k) * msz;
+            ldst_elem(env, adjust_addr(env, addr), i + k * vlmax, vd, ra);
+            k++;
+        }
+    }
+    env->vstart = 0;
+    /* clear tail elements */
+    if (vl != 0) {
+        return;
+    }
+    for (k = 0; k < nf; k++) {
+        clear_elem(vd, env->vl + k * vlmax, env->vl * esz, vlmax * esz);
+    }
+}
+
+#define GEN_TH_LDFF(NAME, MTYPE, ETYPE, LOAD_FN, CLEAR_FN)       \
+void HELPER(NAME)(void *vd, void *v0, target_ulong base,         \
+                  CPURISCVState *env, uint32_t desc)             \
+{                                                                \
+    th_ldff(vd, v0, base, env, desc, LOAD_FN, CLEAR_FN,          \
+            sizeof(ETYPE), sizeof(MTYPE), GETPC());              \
+}
+
+GEN_TH_LDFF(th_vlbff_v_b,  int8_t,   int8_t,   ldb_b,  clearb_th)
+GEN_TH_LDFF(th_vlbff_v_h,  int8_t,   int16_t,  ldb_h,  clearh_th)
+GEN_TH_LDFF(th_vlbff_v_w,  int8_t,   int32_t,  ldb_w,  clearl_th)
+GEN_TH_LDFF(th_vlbff_v_d,  int8_t,   int64_t,  ldb_d,  clearq_th)
+GEN_TH_LDFF(th_vlhff_v_h,  int16_t,  int16_t,  ldh_h,  clearh_th)
+GEN_TH_LDFF(th_vlhff_v_w,  int16_t,  int32_t,  ldh_w,  clearl_th)
+GEN_TH_LDFF(th_vlhff_v_d,  int16_t,  int64_t,  ldh_d,  clearq_th)
+GEN_TH_LDFF(th_vlwff_v_w,  int32_t,  int32_t,  ldw_w,  clearl_th)
+GEN_TH_LDFF(th_vlwff_v_d,  int32_t,  int64_t,  ldw_d,  clearq_th)
+GEN_TH_LDFF(th_vleff_v_b,  int8_t,   int8_t,   lde_b,  clearb_th)
+GEN_TH_LDFF(th_vleff_v_h,  int16_t,  int16_t,  lde_h,  clearh_th)
+GEN_TH_LDFF(th_vleff_v_w,  int32_t,  int32_t,  lde_w,  clearl_th)
+GEN_TH_LDFF(th_vleff_v_d,  int64_t,  int64_t,  lde_d,  clearq_th)
+GEN_TH_LDFF(th_vlbuff_v_b, uint8_t,  uint8_t,  ldbu_b, clearb_th)
+GEN_TH_LDFF(th_vlbuff_v_h, uint8_t,  uint16_t, ldbu_h, clearh_th)
+GEN_TH_LDFF(th_vlbuff_v_w, uint8_t,  uint32_t, ldbu_w, clearl_th)
+GEN_TH_LDFF(th_vlbuff_v_d, uint8_t,  uint64_t, ldbu_d, clearq_th)
+GEN_TH_LDFF(th_vlhuff_v_h, uint16_t, uint16_t, ldhu_h, clearh_th)
+GEN_TH_LDFF(th_vlhuff_v_w, uint16_t, uint32_t, ldhu_w, clearl_th)
+GEN_TH_LDFF(th_vlhuff_v_d, uint16_t, uint64_t, ldhu_d, clearq_th)
+GEN_TH_LDFF(th_vlwuff_v_w, uint32_t, uint32_t, ldwu_w, clearl_th)
+GEN_TH_LDFF(th_vlwuff_v_d, uint32_t, uint64_t, ldwu_d, clearq_th)
-- 
2.44.0


