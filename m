Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09EA7C00A94
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBsH-0003Mg-51; Fri, 12 Apr 2024 04:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvBsE-0003MT-5k; Fri, 12 Apr 2024 04:03:02 -0400
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvBs8-0004LT-Ro; Fri, 12 Apr 2024 04:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712908969; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=8sS1mGwiVRIv8dgw//97y/0QfMFkwxXjpg1XX23X9IA=;
 b=eyWua9LsQ1jbXoW97xMCleHuccnexcSL6Jyn72d2ZNCvW0WhpIbQeneLc+ZaEx52NxyBWyT4Zlc68vqQxuqdWQy7LxLgPRhw98ba3A7xyoKmGZvYDyxDVyeqPxnsFfajwcl1E4JMY0Zqa3U1zbIteQdT++1nw+afX6FCR/iMqu4=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NagQK_1712908968; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NagQK_1712908968) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 16:02:49 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 12/65] target/riscv: Add indexed load instructions for
 XTheadVector
Date: Fri, 12 Apr 2024 15:36:42 +0800
Message-ID: <20240412073735.76413-13-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.112;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-112.freemail.mail.aliyun.com
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

XTheadVector indexed load instructions diff from RVV1.0 in the following
points:
1. Different mask reg layout.
2. Different access width. XTheadVector has 7 instructions, th.vlx{b,h,w}.v,
   th.vlx{b,h,w}u.v and th.vlxe.v. Their index element width and reg data
   element width are all SEW-bit. The difference between b,h,w,e is memory
   access width. {b,h,w,e} stands for 8/16/32/SEW-bit. Therefore, it leads to
   the difference of zero and sign extend. "u" stands for zero-extened, the
   lack of "u" stands for the other.
   RVV1.0 instructions vlxei{8,16,32,64}.v. {8,16,32,64} are the width of
   index element, while the memory and data reg element width are both SEW-bit.
3. Different tail/masked elements process policy.
4. Different check policy. In RVV1.0, in some situations, the destination
   vector register group can overlap the source vector register group of a
   different element width. While XTheadVector not.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         | 22 +++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 91 +++++++++++++++++--
 target/riscv/vector_helper.c                  |  4 +-
 target/riscv/vector_internals.h               |  4 +
 target/riscv/xtheadvector_helper.c            | 82 +++++++++++++++++
 5 files changed, 194 insertions(+), 9 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index eb31784e18..733071bdc6 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1387,3 +1387,25 @@ DEF_HELPER_5(th_vse_v_w, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(th_vse_v_w_mask, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(th_vse_v_d, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(th_vse_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_6(th_vlxb_v_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vlxb_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vlxb_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vlxb_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vlxh_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vlxh_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vlxh_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vlxw_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vlxw_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vlxe_v_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vlxe_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vlxe_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vlxe_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vlxbu_v_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vlxbu_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vlxbu_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vlxbu_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vlxhu_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vlxhu_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vlxhu_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vlxwu_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vlxwu_v_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 9b88ea2fa4..8148097de3 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -179,6 +179,20 @@ static bool th_check_nf(DisasContext *s, uint32_t vd, uint32_t nf)
     return size <= 8 && vd + size <= 32;
 }
 
+/*
+ * The destination vector register group cannot overlap a source vector register
+ * group of a different element width.
+ *
+ * The overlap check rule is different from RVV1.0. The function
+ * "require_noover" describes the check rule in RVV1.0. In general, in some
+ * situations, the destination vector register group can overlap the source
+ * vector register group of a different element width. While XTheadVector not.
+ */
+static inline bool th_check_overlap_group(int rd, int dlen, int rs, int slen)
+{
+    return ((rd >= rs + slen) || (rs >= rd + dlen));
+}
+
 /*
  * common translation macro
  *
@@ -453,6 +467,76 @@ GEN_TH_TRANS(th_vsh_v, 1, r2nfvm, st_us_op_th, st_us_check_th)
 GEN_TH_TRANS(th_vsw_v, 2, r2nfvm, st_us_op_th, st_us_check_th)
 GEN_TH_TRANS(th_vse_v, 3, r2nfvm, st_us_op_th, st_us_check_th)
 
+/*
+ * index load and store
+ */
+
+#define gen_helper_ldst_index_th gen_helper_ldst_index
+
+/*
+ * This function is almost the copy of ld_index_op, except:
+ * 1) different data encoding
+ * 2) XTheadVector has more insns to handle zero/sign-extended.
+ */
+static bool ld_index_op_th(DisasContext *s, arg_rnfvm *a, uint8_t seq)
+{
+    uint32_t data = 0;
+    gen_helper_ldst_index_th *fn;
+    static gen_helper_ldst_index_th * const fns[7][4] = {
+        { gen_helper_th_vlxb_v_b,  gen_helper_th_vlxb_v_h,
+          gen_helper_th_vlxb_v_w,  gen_helper_th_vlxb_v_d },
+        { NULL,                    gen_helper_th_vlxh_v_h,
+          gen_helper_th_vlxh_v_w,  gen_helper_th_vlxh_v_d },
+        { NULL,                    NULL,
+          gen_helper_th_vlxw_v_w,  gen_helper_th_vlxw_v_d },
+        { gen_helper_th_vlxe_v_b,  gen_helper_th_vlxe_v_h,
+          gen_helper_th_vlxe_v_w,  gen_helper_th_vlxe_v_d },
+        { gen_helper_th_vlxbu_v_b, gen_helper_th_vlxbu_v_h,
+          gen_helper_th_vlxbu_v_w, gen_helper_th_vlxbu_v_d },
+        { NULL,                    gen_helper_th_vlxhu_v_h,
+          gen_helper_th_vlxhu_v_w, gen_helper_th_vlxhu_v_d },
+        { NULL,                    NULL,
+          gen_helper_th_vlxwu_v_w, gen_helper_th_vlxwu_v_d },
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
+    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s);
+}
+
+/*
+ * For vector indexed segment loads, the destination vector register
+ * groups cannot overlap the source vector register group (specified by
+ * `vs2`), else an illegal instruction exception is raised.
+ */
+static bool ld_index_check_th(DisasContext *s, arg_rnfvm* a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_overlap_mask(s, a->rd, a->vm, false) &&
+            th_check_reg(s, a->rd, false) &&
+            th_check_reg(s, a->rs2, false) &&
+            th_check_nf(s, a->rd, a->nf) &&
+            ((a->nf == 1) ||
+            th_check_overlap_group(a->rd, a->nf << s->lmul,
+                                   a->rs2, 1 << s->lmul)));
+}
+
+GEN_TH_TRANS(th_vlxb_v, 0, rnfvm, ld_index_op_th, ld_index_check_th)
+GEN_TH_TRANS(th_vlxh_v, 1, rnfvm, ld_index_op_th, ld_index_check_th)
+GEN_TH_TRANS(th_vlxw_v, 2, rnfvm, ld_index_op_th, ld_index_check_th)
+GEN_TH_TRANS(th_vlxe_v, 3, rnfvm, ld_index_op_th, ld_index_check_th)
+GEN_TH_TRANS(th_vlxbu_v, 4, rnfvm, ld_index_op_th, ld_index_check_th)
+GEN_TH_TRANS(th_vlxhu_v, 5, rnfvm, ld_index_op_th, ld_index_check_th)
+GEN_TH_TRANS(th_vlxwu_v, 6, rnfvm, ld_index_op_th, ld_index_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
@@ -466,13 +550,6 @@ TH_TRANS_STUB(th_vleff_v)
 TH_TRANS_STUB(th_vlbuff_v)
 TH_TRANS_STUB(th_vlhuff_v)
 TH_TRANS_STUB(th_vlwuff_v)
-TH_TRANS_STUB(th_vlxb_v)
-TH_TRANS_STUB(th_vlxh_v)
-TH_TRANS_STUB(th_vlxw_v)
-TH_TRANS_STUB(th_vlxe_v)
-TH_TRANS_STUB(th_vlxbu_v)
-TH_TRANS_STUB(th_vlxhu_v)
-TH_TRANS_STUB(th_vlxwu_v)
 TH_TRANS_STUB(th_vsxb_v)
 TH_TRANS_STUB(th_vsxh_v)
 TH_TRANS_STUB(th_vsxw_v)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 31660226dc..49b5027371 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -360,8 +360,8 @@ typedef target_ulong vext_get_index_addr(target_ulong base,
         uint32_t idx, void *vs2);
 
 #define GEN_VEXT_GET_INDEX_ADDR(NAME, ETYPE, H)        \
-static target_ulong NAME(target_ulong base,            \
-                         uint32_t idx, void *vs2)      \
+target_ulong NAME(target_ulong base,                   \
+                  uint32_t idx, void *vs2)             \
 {                                                      \
     return (base + *((ETYPE *)vs2 + H(idx)));          \
 }
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index 59c93f86bf..a692462bf1 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -239,4 +239,8 @@ static inline target_ulong adjust_addr(CPURISCVState *env, target_ulong addr)
     return (addr & ~env->cur_pmmask) | env->cur_pmbase;
 }
 
+target_ulong idx_b(target_ulong base, uint32_t idx, void *vs2);
+target_ulong idx_h(target_ulong base, uint32_t idx, void *vs2);
+target_ulong idx_w(target_ulong base, uint32_t idx, void *vs2);
+target_ulong idx_d(target_ulong base, uint32_t idx, void *vs2);
 #endif /* TARGET_RISCV_VECTOR_INTERNALS_H */
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 5c05cd5aa6..a9ae157296 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -436,3 +436,85 @@ GEN_TH_ST_US(th_vse_v_b, int8_t,  int8_t , ste_b)
 GEN_TH_ST_US(th_vse_v_h, int16_t, int16_t, ste_h)
 GEN_TH_ST_US(th_vse_v_w, int32_t, int32_t, ste_w)
 GEN_TH_ST_US(th_vse_v_d, int64_t, int64_t, ste_d)
+
+/*
+ * index: access vector element from indexed memory
+ */
+typedef target_ulong th_get_index_addr(target_ulong base,
+        uint32_t idx, void *vs2);
+
+/*
+ * This function is almost the copy of vext_ldst_index, except:
+ * 1) different mask layout
+ * 2) different data encoding
+ * 3) different mask/tail elements process policy
+ */
+static inline void
+th_ldst_index(void *vd, void *v0, target_ulong base,
+              void *vs2, CPURISCVState *env, uint32_t desc,
+              th_get_index_addr get_index_addr,
+              th_ldst_elem_fn *ldst_elem,
+              clear_fn *clear_elem,
+              uint32_t esz, uint32_t msz, uintptr_t ra)
+{
+    uint32_t i, k;
+    uint32_t nf = th_nf(desc);
+    uint32_t vm = th_vm(desc);
+    uint32_t mlen = th_mlen(desc);
+    uint32_t vlmax = th_maxsz(desc) / esz;
+
+    VSTART_CHECK_EARLY_EXIT(env);
+
+    /* load bytes from guest memory */
+    for (i = env->vstart; i < env->vl; env->vstart = ++i) {
+        k = 0;
+        if (!vm && !th_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        while (k < nf) {
+            abi_ptr addr = get_index_addr(base, i, vs2) + k * msz;
+            ldst_elem(env, adjust_addr(env, addr), i + k * vlmax, vd, ra);
+            k++;
+        }
+    }
+    env->vstart = 0;
+    /* clear tail elements */
+    if (clear_elem) {
+        for (k = 0; k < nf; k++) {
+            clear_elem(vd, env->vl + k * vlmax, env->vl * esz, vlmax * esz);
+        }
+    }
+}
+
+/* Similar to GEN_VEXT_LD_INDEX */
+#define GEN_TH_LD_INDEX(NAME, MTYPE, ETYPE, INDEX_FN, LOAD_FN, CLEAR_FN)   \
+void HELPER(NAME)(void *vd, void *v0, target_ulong base,                   \
+                  void *vs2, CPURISCVState *env, uint32_t desc)            \
+{                                                                          \
+    th_ldst_index(vd, v0, base, vs2, env, desc, INDEX_FN,                  \
+                  LOAD_FN, CLEAR_FN, sizeof(ETYPE), sizeof(MTYPE),         \
+                  GETPC());                                                \
+}
+
+GEN_TH_LD_INDEX(th_vlxb_v_b,  int8_t,   int8_t,   idx_b, ldb_b,  clearb_th)
+GEN_TH_LD_INDEX(th_vlxb_v_h,  int8_t,   int16_t,  idx_h, ldb_h,  clearh_th)
+GEN_TH_LD_INDEX(th_vlxb_v_w,  int8_t,   int32_t,  idx_w, ldb_w,  clearl_th)
+GEN_TH_LD_INDEX(th_vlxb_v_d,  int8_t,   int64_t,  idx_d, ldb_d,  clearq_th)
+GEN_TH_LD_INDEX(th_vlxh_v_h,  int16_t,  int16_t,  idx_h, ldh_h,  clearh_th)
+GEN_TH_LD_INDEX(th_vlxh_v_w,  int16_t,  int32_t,  idx_w, ldh_w,  clearl_th)
+GEN_TH_LD_INDEX(th_vlxh_v_d,  int16_t,  int64_t,  idx_d, ldh_d,  clearq_th)
+GEN_TH_LD_INDEX(th_vlxw_v_w,  int32_t,  int32_t,  idx_w, ldw_w,  clearl_th)
+GEN_TH_LD_INDEX(th_vlxw_v_d,  int32_t,  int64_t,  idx_d, ldw_d,  clearq_th)
+GEN_TH_LD_INDEX(th_vlxe_v_b,  int8_t,   int8_t,   idx_b, lde_b,  clearb_th)
+GEN_TH_LD_INDEX(th_vlxe_v_h,  int16_t,  int16_t,  idx_h, lde_h,  clearh_th)
+GEN_TH_LD_INDEX(th_vlxe_v_w,  int32_t,  int32_t,  idx_w, lde_w,  clearl_th)
+GEN_TH_LD_INDEX(th_vlxe_v_d,  int64_t,  int64_t,  idx_d, lde_d,  clearq_th)
+GEN_TH_LD_INDEX(th_vlxbu_v_b, uint8_t,  uint8_t,  idx_b, ldbu_b, clearb_th)
+GEN_TH_LD_INDEX(th_vlxbu_v_h, uint8_t,  uint16_t, idx_h, ldbu_h, clearh_th)
+GEN_TH_LD_INDEX(th_vlxbu_v_w, uint8_t,  uint32_t, idx_w, ldbu_w, clearl_th)
+GEN_TH_LD_INDEX(th_vlxbu_v_d, uint8_t,  uint64_t, idx_d, ldbu_d, clearq_th)
+GEN_TH_LD_INDEX(th_vlxhu_v_h, uint16_t, uint16_t, idx_h, ldhu_h, clearh_th)
+GEN_TH_LD_INDEX(th_vlxhu_v_w, uint16_t, uint32_t, idx_w, ldhu_w, clearl_th)
+GEN_TH_LD_INDEX(th_vlxhu_v_d, uint16_t, uint64_t, idx_d, ldhu_d, clearq_th)
+GEN_TH_LD_INDEX(th_vlxwu_v_w, uint32_t, uint32_t, idx_w, ldwu_w, clearl_th)
+GEN_TH_LD_INDEX(th_vlxwu_v_d, uint32_t, uint64_t, idx_d, ldwu_d, clearq_th)
-- 
2.44.0


