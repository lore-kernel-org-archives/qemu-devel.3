Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A9DC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBkf-0007WR-5g; Fri, 12 Apr 2024 03:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvBkP-0007UA-1t; Fri, 12 Apr 2024 03:54:57 -0400
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvBkI-0002Ty-N9; Fri, 12 Apr 2024 03:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712908483; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=NgV908wNRjhZHvhVtL9Oyga1qipXmf9NM0MKKM0NfUk=;
 b=uwfd3hQPkyUqZQWTuRYnzRKszqlzYa0mRgwXXD8xHTisOkFmN7eMHFcbCR/micYHC87AcYChfFxOb8uGfnh0wFEZ0biYDeblrKoejwyVefmh+dUL87CdSxKNLMrk6qSXtEy2fEekvjfjGmPl95HN08pFhwWlh1Y2cXYLsR/tDdg=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R471e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4Nb-5f_1712908482; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4Nb-5f_1712908482) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 15:54:43 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 08/65] target/riscv: Add strided load instructions for
 XTheadVector
Date: Fri, 12 Apr 2024 15:36:38 +0800
Message-ID: <20240412073735.76413-9-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.101;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-101.freemail.mail.aliyun.com
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

In this patch, we add one strided load instructions to show the way
we implement XTheadVector load/store instructions. We use independent
functions to achieve decoupling.

XTheadVector strided load instructions diff from RVV1.0 in the following
points:
1. Different mask reg layout. For mask bit of element i, XTheadVector
   locates it in bit[mlen*i] (mlen = SEW/LMUL), while RVV1.0 locates it
   in bit[i].
2. Different vector reg element width. XTheadVector has 7 instructions,
   th.vls{b,h,w}.v, th.vls{b,h,w}u.v and th.vlse.v. "b/h/w" represents
   byte/halfword, "u" represents unsigned. The insn th.vls{b,h,w}.v
   strided load 8/16/32-bit memory data and sign-extended to SEW-bit vector
   element if SEW > 8/16/32. The insn th.vls{b,h,w}u.v strided load
   8/16/32-bit memory data and zero-extended to SEW-bit vector element
   if SEW > 8/16/32. The insn th.vlse strided load SEW-bit memory data
   to SEW-bit vector element.
   RVV1.0 has 4 instructions, vlse{8,16,32,64}.v. They load 8/16/32/64-bit
   memory data to 8/16/32/64-bit vector element.
   So XTheadVector has more instructions to handle zero/sign-extened.
3. Different tail/masked elements process policy. XTheadVector keep the
   masked element value and clear the tail elements. While RVV1.0 has vta
   and vma to set the processing policy, keeping value or overwrite it with
   1s.
4. Different check policy. XTheadVector does not have fractional lmul, so we
   can use simpler check function

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         |  24 ++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 160 ++++++++++-
 target/riscv/internals.h                      |  12 +
 target/riscv/meson.build                      |   1 +
 target/riscv/vector_helper.c                  |   5 -
 target/riscv/vector_internals.h               |   6 +
 target/riscv/xtheadvector_helper.c            | 271 ++++++++++++++++++
 7 files changed, 467 insertions(+), 12 deletions(-)
 create mode 100644 target/riscv/xtheadvector_helper.c

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 8a63523851..8decfc20cc 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1280,3 +1280,27 @@ DEF_HELPER_4(vgmul_vv, void, ptr, ptr, env, i32)
 DEF_HELPER_5(vsm4k_vi, void, ptr, ptr, i32, env, i32)
 DEF_HELPER_4(vsm4r_vv, void, ptr, ptr, env, i32)
 DEF_HELPER_4(vsm4r_vs, void, ptr, ptr, env, i32)
+
+ /* XTheadVector functions */
+DEF_HELPER_6(th_vlsb_v_b, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vlsb_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vlsb_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vlsb_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vlsh_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vlsh_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vlsh_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vlsw_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vlsw_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vlse_v_b, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vlse_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vlse_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vlse_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vlsbu_v_b, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vlsbu_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vlsbu_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vlsbu_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vlshu_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vlshu_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vlshu_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vlswu_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vlswu_v_d, void, ptr, ptr, tl, tl, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 0461b53893..72481fdd5f 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -116,6 +116,159 @@ static bool trans_th_vsetvli(DisasContext *s, arg_th_vsetvli *a)
     return th_vsetvl(s, a->rd, a->rs1, s2);
 }
 
+/* check functions */
+
+/*
+ * There are two rules check here.
+ * 1. Vector register numbers are multiples of LMUL.
+ * 2. For all widening instructions, the destination LMUL value must also be
+ *    a supported LMUL value.
+ *
+ * This function is the combination of require_align and vext_wide_check_common,
+ * except:
+ * 1) In require_align, if LMUL < 0, i.e. fractional LMUL, any vector register
+ *    is allowed, we do not need to check this situation.
+ * 2) In vext_wide_check_common, RVV check all the constraints of widen
+ *    instruction, including SEW < 64, 2*SEW <ELEN and overlap constraints.
+ *    But in th_check_reg, we only check the reg constraint, including lmul < 8
+ *    and destination vector register number is multiples of 2 * LMUL.
+ *    Other widen constraints are checked in other functions.
+ */
+static bool th_check_reg(DisasContext *s, uint32_t reg, bool widen)
+{
+    /*
+     * The destination vector register group results are arranged as if both
+     * SEW and LMUL were at twice their current settings.
+     */
+    int legal = widen ? 2 << s->lmul : 1 << s->lmul;
+
+    return !((s->lmul == 0x3 && widen) || (reg % legal));
+}
+
+/*
+ * There are two rules check here.
+ * 1. The destination vector register group for a masked vector instruction can
+ *    only overlap the source mask register (v0) when LMUL=1.
+ * 2. In widen instructions and some other insturctions, like vslideup.vx,
+ *    there is no need to check whether LMUL=1.
+ *
+ * This function is almost the copy of require_vm, except:
+ * 1) In RVV1.0, destination vector register group cannot overlap source mask
+ *    register even when LMUL=1. So we have to add a check of "(s->lmul == 0)".
+ * 2) When the instruction forbid the mask overlap in all situation, we add
+ *    a arg of "force" to flag the situation.
+ */
+static bool th_check_overlap_mask(DisasContext *s, uint32_t vd, bool vm,
+                                  bool force)
+{
+    return (vm != 0 || vd != 0) || (!force && (s->lmul == 0));
+}
+
+/*
+ * The LMUL setting must be such that LMUL * NFIELDS <= 8.
+ *
+ * This function is almost the copy of require_nf, except that
+ * XTheadVectot does not have fractional LMUL, so we do not need to
+ * max(lmul, 0)
+ * RVV use "size = nf << MAX(lmul, 0)" to let the one segment be loaded
+ * to at least one vector register.
+ */
+static bool th_check_nf(DisasContext *s, uint32_t vd, uint32_t nf)
+{
+    int size = nf << s->lmul;
+    return size <= 8 && vd + size <= 32;
+}
+
+/*
+ * common translation macro
+ *
+ * GEN_TH_TRANS is similar to GEN_VEXT_TRANS
+ * just change the function args
+ */
+#define GEN_TH_TRANS(NAME, SEQ, ARGTYPE, OP, CHECK)        \
+static bool trans_##NAME(DisasContext *s, arg_##ARGTYPE *a)\
+{                                                          \
+    if (CHECK(s, a)) {                                     \
+        return OP(s, a, SEQ);                              \
+    }                                                      \
+    return false;                                          \
+}
+
+/*
+ * stride load and store
+ */
+
+#define gen_helper_ldst_stride_th gen_helper_ldst_stride
+
+/*
+ * This function is almost the copy of ld_stride_op, except:
+ * 1) XTheadVector has more insns to handle zero/sign-extended.
+ * 2) XTheadVector using different data encoding, add MLEN,
+ *    delete VTA and VMA.
+ *
+ *    MLEN = SEW/LMUL. to indicate the mask bit.
+ */
+static bool ld_stride_op_th(DisasContext *s, arg_rnfvm *a, uint8_t seq)
+{
+    uint32_t data = 0;
+    gen_helper_ldst_stride_th *fn;
+    static gen_helper_ldst_stride_th * const fns[7][4] = {
+        { gen_helper_th_vlsb_v_b,  gen_helper_th_vlsb_v_h,
+          gen_helper_th_vlsb_v_w,  gen_helper_th_vlsb_v_d },
+        { NULL,                    gen_helper_th_vlsh_v_h,
+          gen_helper_th_vlsh_v_w,  gen_helper_th_vlsh_v_d },
+        { NULL,                    NULL,
+          gen_helper_th_vlsw_v_w,  gen_helper_th_vlsw_v_d },
+        { gen_helper_th_vlse_v_b,  gen_helper_th_vlse_v_h,
+          gen_helper_th_vlse_v_w,  gen_helper_th_vlse_v_d },
+        { gen_helper_th_vlsbu_v_b, gen_helper_th_vlsbu_v_h,
+          gen_helper_th_vlsbu_v_w, gen_helper_th_vlsbu_v_d },
+        { NULL,                    gen_helper_th_vlshu_v_h,
+          gen_helper_th_vlshu_v_w, gen_helper_th_vlshu_v_d },
+        { NULL,                    NULL,
+          gen_helper_th_vlswu_v_w, gen_helper_th_vlswu_v_d },
+    };
+
+    fn =  fns[seq][s->sew];
+    if (fn == NULL) {
+        return false;
+    }
+    /* Need extra mlen to find the mask bit */
+    data = FIELD_DP32(data, VDATA_TH, MLEN, s->mlen);
+    data = FIELD_DP32(data, VDATA_TH, VM, a->vm);
+    data = FIELD_DP32(data, VDATA_TH, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA_TH, NF, a->nf);
+    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
+}
+
+/*
+ * check function
+ * 1) check overlap mask, XTheadVector can overlap mask reg v0 when
+ *    lmul == 1, while RVV1.0 can not.
+ * 2) check reg, XTheadVector Vector register numbers are multiples
+ *    of integral LMUL, while RVV1.0 has fractional LMUL, which allows
+ *    any vector register.
+ * 3) check nf, the LMUL setting must be such that LMUL * NFIELDS <= 8,
+ *    which is the same as RVV1.0. But we do not need to check fractional
+ *    LMUL.
+ */
+static bool ld_stride_check_th(DisasContext *s, arg_rnfvm* a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_overlap_mask(s, a->rd, a->vm, false) &&
+            th_check_reg(s, a->rd, false) &&
+            th_check_nf(s, a->rd, a->nf));
+}
+
+GEN_TH_TRANS(th_vlsb_v, 0, rnfvm, ld_stride_op_th, ld_stride_check_th)
+GEN_TH_TRANS(th_vlsh_v, 1, rnfvm, ld_stride_op_th, ld_stride_check_th)
+GEN_TH_TRANS(th_vlsw_v, 2, rnfvm, ld_stride_op_th, ld_stride_check_th)
+GEN_TH_TRANS(th_vlse_v, 3, rnfvm, ld_stride_op_th, ld_stride_check_th)
+GEN_TH_TRANS(th_vlsbu_v, 4, rnfvm, ld_stride_op_th, ld_stride_check_th)
+GEN_TH_TRANS(th_vlshu_v, 5, rnfvm, ld_stride_op_th, ld_stride_check_th)
+GEN_TH_TRANS(th_vlswu_v, 6, rnfvm, ld_stride_op_th, ld_stride_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
@@ -140,13 +293,6 @@ TH_TRANS_STUB(th_vsb_v)
 TH_TRANS_STUB(th_vsh_v)
 TH_TRANS_STUB(th_vsw_v)
 TH_TRANS_STUB(th_vse_v)
-TH_TRANS_STUB(th_vlsb_v)
-TH_TRANS_STUB(th_vlsh_v)
-TH_TRANS_STUB(th_vlsw_v)
-TH_TRANS_STUB(th_vlse_v)
-TH_TRANS_STUB(th_vlsbu_v)
-TH_TRANS_STUB(th_vlshu_v)
-TH_TRANS_STUB(th_vlswu_v)
 TH_TRANS_STUB(th_vssb_v)
 TH_TRANS_STUB(th_vssh_v)
 TH_TRANS_STUB(th_vssw_v)
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 8239ae83cc..07e95cd07b 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -65,6 +65,18 @@ FIELD(VDATA, VMA, 6, 1)
 FIELD(VDATA, NF, 7, 4)
 FIELD(VDATA, WD, 7, 1)
 
+/*
+ * XTheadVector need mlen in addition, and does not need
+ * VTA and VMA. So, we redesign the encoding of desc.
+ *
+ * MLEN = SEW/LMUL. to indicate the mask bit.
+ */
+FIELD(VDATA_TH, MLEN, 0, 8)
+FIELD(VDATA_TH, VM, 8, 1)
+FIELD(VDATA_TH, LMUL, 9, 2)
+FIELD(VDATA_TH, NF, 11, 4)
+FIELD(VDATA_TH, WD, 11, 1)
+
 /* float point classify helpers */
 target_ulong fclass_h(uint64_t frs1);
 target_ulong fclass_s(uint64_t frs1);
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 1207ba84ed..a86a836a82 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -18,6 +18,7 @@ riscv_ss.add(files(
   'gdbstub.c',
   'op_helper.c',
   'vector_helper.c',
+  'xtheadvector_helper.c',
   'vector_internals.c',
   'bitmanip_helper.c',
   'translate.c',
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index fa139040f8..31660226dc 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -102,11 +102,6 @@ static inline uint32_t vext_max_elems(uint32_t desc, uint32_t log2_esz)
     return scale < 0 ? vlenb >> -scale : vlenb << scale;
 }
 
-static inline target_ulong adjust_addr(CPURISCVState *env, target_ulong addr)
-{
-    return (addr & ~env->cur_pmmask) | env->cur_pmbase;
-}
-
 /*
  * This function checks watchpoint before real load operation.
  *
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index 9e1e15b575..59c93f86bf 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -233,4 +233,10 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,    \
 #define WOP_UUU_H uint32_t, uint16_t, uint16_t, uint32_t, uint32_t
 #define WOP_UUU_W uint64_t, uint32_t, uint32_t, uint64_t, uint64_t
 
+/* share functions */
+static inline target_ulong adjust_addr(CPURISCVState *env, target_ulong addr)
+{
+    return (addr & ~env->cur_pmmask) | env->cur_pmbase;
+}
+
 #endif /* TARGET_RISCV_VECTOR_INTERNALS_H */
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
new file mode 100644
index 0000000000..7bfd85901e
--- /dev/null
+++ b/target/riscv/xtheadvector_helper.c
@@ -0,0 +1,271 @@
+/*
+ * RISC-V XTheadVector Extension Helpers for QEMU.
+ *
+ * Copyright (c) 2024 Alibaba Group. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/host-utils.h"
+#include "qemu/bitops.h"
+#include "cpu.h"
+#include "exec/memop.h"
+#include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
+#include "exec/helper-proto.h"
+#include "fpu/softfloat.h"
+#include "tcg/tcg-gvec-desc.h"
+#include "internals.h"
+#include "vector_internals.h"
+#include <math.h>
+
+/* Different desc encoding need different parse functions */
+static inline uint32_t th_nf(uint32_t desc)
+{
+    return FIELD_EX32(simd_data(desc), VDATA_TH, NF);
+}
+
+static inline uint32_t th_mlen(uint32_t desc)
+{
+    return FIELD_EX32(simd_data(desc), VDATA_TH, MLEN);
+}
+
+static inline uint32_t th_vm(uint32_t desc)
+{
+    return FIELD_EX32(simd_data(desc), VDATA_TH, VM);
+}
+
+static inline uint32_t th_lmul(uint32_t desc)
+{
+    return FIELD_EX32(simd_data(desc), VDATA_TH, LMUL);
+}
+
+/*
+ * Get vector group length in bytes. Its range is [64, 2048].
+ *
+ * As simd_desc support at most 256, the max vlen is 512 bits.
+ * So vlen in bytes is encoded as maxsz.
+ *
+ * XtheadVector diff from RVV1.0 is that TH not have fractional lmul and emul.
+ */
+static inline uint32_t th_maxsz(uint32_t desc)
+{
+    return simd_maxsz(desc) << th_lmul(desc);
+}
+
+/* XTheadVector need to clear the tail elements */
+#if HOST_BIG_ENDIAN
+static void th_clear(void *tail, uint32_t cnt, uint32_t tot)
+{
+    /*
+     * Split the remaining range to two parts.
+     * The first part is in the last uint64_t unit.
+     * The second part start from the next uint64_t unit.
+     */
+    int part1 = 0, part2 = tot - cnt;
+    if (cnt % 8) {
+        part1 = 8 - (cnt % 8);
+        part2 = tot - cnt - part1;
+        memset(QEMU_ALIGN_PTR_DOWN(tail, 8), 0, part1);
+        memset(QEMU_ALIGN_PTR_UP(tail, 8), 0, part2);
+    } else {
+        memset(tail, 0, part2);
+    }
+}
+#else
+static void th_clear(void *tail, uint32_t cnt, uint32_t tot)
+{
+    memset(tail, 0, tot - cnt);
+}
+#endif
+
+static void clearb_th(void *vd, uint32_t idx, uint32_t cnt, uint32_t tot)
+{
+    int8_t *cur = ((int8_t *)vd + H1(idx));
+    th_clear(cur, cnt, tot);
+}
+
+static void clearh_th(void *vd, uint32_t idx, uint32_t cnt, uint32_t tot)
+{
+    int16_t *cur = ((int16_t *)vd + H2(idx));
+    th_clear(cur, cnt, tot);
+}
+
+static void clearl_th(void *vd, uint32_t idx, uint32_t cnt, uint32_t tot)
+{
+    int32_t *cur = ((int32_t *)vd + H4(idx));
+    th_clear(cur, cnt, tot);
+}
+
+static void clearq_th(void *vd, uint32_t idx, uint32_t cnt, uint32_t tot)
+{
+    int64_t *cur = (int64_t *)vd + idx;
+    th_clear(cur, cnt, tot);
+}
+
+/*
+ * XTheadVector has different mask layout.
+ *
+ * The mask bits for element i are located in
+ * bits [MLEN*i+(MLEN-1) : MLEN*i] of the mask register.
+ *
+ * MLEN = SEW/LMUL
+ */
+static inline int th_elem_mask(void *v0, int mlen, int index)
+{
+    int idx = (index * mlen) / 64;
+    int pos = (index * mlen) % 64;
+    return (((uint64_t *)v0)[idx] >> pos) & 1;
+}
+
+/* elements operations for load and store */
+typedef void th_ldst_elem_fn(CPURISCVState *env, abi_ptr addr,
+                             uint32_t idx, void *vd, uintptr_t retaddr);
+
+/*
+ * GEN_TH_LD_ELEM is almost the copy of to GEN_VEXT_LD_ELEM, except that
+ * we add "MTYPE data" to deal with zero/sign-extended.
+ *
+ * For XTheadVector, mem access width is determined by the instruction,
+ * while the reg element size equals SEW, therefore mem access width may
+ * not equal reg element size. For example, ldb_d means load 8-bit data
+ * and sign-extended to 64-bit vector element.
+ * As for RVV1.0, mem access width always equals reg element size.
+ *
+ * So we need to deal with zero/sign-extended in addition.
+ */
+
+#define GEN_TH_LD_ELEM(NAME, MTYPE, ETYPE, H, LDSUF)       \
+static void NAME(CPURISCVState *env, abi_ptr addr,         \
+                 uint32_t idx, void *vd, uintptr_t retaddr)\
+{                                                          \
+    MTYPE data;                                            \
+    ETYPE *cur = ((ETYPE *)vd + H(idx));                   \
+    data = cpu_##LDSUF##_data_ra(env, addr, retaddr);      \
+    *cur = data;                                           \
+}                                                          \
+
+GEN_TH_LD_ELEM(ldb_b, int8_t,  int8_t,  H1, ldsb)
+GEN_TH_LD_ELEM(ldb_h, int8_t,  int16_t, H2, ldsb)
+GEN_TH_LD_ELEM(ldb_w, int8_t,  int32_t, H4, ldsb)
+GEN_TH_LD_ELEM(ldb_d, int8_t,  int64_t, H8, ldsb)
+GEN_TH_LD_ELEM(ldh_h, int16_t, int16_t, H2, ldsw)
+GEN_TH_LD_ELEM(ldh_w, int16_t, int32_t, H4, ldsw)
+GEN_TH_LD_ELEM(ldh_d, int16_t, int64_t, H8, ldsw)
+GEN_TH_LD_ELEM(ldw_w, int32_t, int32_t, H4, ldl)
+GEN_TH_LD_ELEM(ldw_d, int32_t, int64_t, H8, ldl)
+GEN_TH_LD_ELEM(lde_b, int8_t,  int8_t,  H1, ldsb)
+GEN_TH_LD_ELEM(lde_h, int16_t, int16_t, H2, ldsw)
+GEN_TH_LD_ELEM(lde_w, int32_t, int32_t, H4, ldl)
+GEN_TH_LD_ELEM(lde_d, int64_t, int64_t, H8, ldq)
+GEN_TH_LD_ELEM(ldbu_b, uint8_t,  uint8_t,  H1, ldub)
+GEN_TH_LD_ELEM(ldbu_h, uint8_t,  uint16_t, H2, ldub)
+GEN_TH_LD_ELEM(ldbu_w, uint8_t,  uint32_t, H4, ldub)
+GEN_TH_LD_ELEM(ldbu_d, uint8_t,  uint64_t, H8, ldub)
+GEN_TH_LD_ELEM(ldhu_h, uint16_t, uint16_t, H2, lduw)
+GEN_TH_LD_ELEM(ldhu_w, uint16_t, uint32_t, H4, lduw)
+GEN_TH_LD_ELEM(ldhu_d, uint16_t, uint64_t, H8, lduw)
+GEN_TH_LD_ELEM(ldwu_w, uint32_t, uint32_t, H4, ldl)
+GEN_TH_LD_ELEM(ldwu_d, uint32_t, uint64_t, H8, ldl)
+
+/*
+ * stride: access vector element from strided memory
+ */
+typedef void clear_fn(void *vd, uint32_t idx, uint32_t cnt, uint32_t tot);
+
+/*
+ * This function is almost the copy of vext_ldst_stride, except:
+ * 1) XTheadVector has different mask layout, using th_elem_mask
+ *    to get [MLEN*i] bit
+ * 2) XTheadVector using different data encoding, using th_ functions
+ *    to parse.
+ * 3) XTheadVector keep the masked elements value, while RVV1.0 policy is
+ *    determined by vma.
+ * 4) XTheadVector clear the tail elements, while RVV1.0 policy is to rather
+ *    set all bits 1s or keep it, determined by vta.
+ */
+static void
+th_ldst_stride(void *vd, void *v0, target_ulong base,
+               target_ulong stride, CPURISCVState *env,
+               uint32_t desc, uint32_t vm,
+               th_ldst_elem_fn *ldst_elem, clear_fn *clear_elem,
+               uint32_t esz, uint32_t msz, uintptr_t ra)
+{
+    uint32_t i, k;
+    uint32_t nf = th_nf(desc);
+    uint32_t mlen = th_mlen(desc);
+    uint32_t vlmax = th_maxsz(desc) / esz;
+
+    VSTART_CHECK_EARLY_EXIT(env);
+
+    /* do real access */
+    for (i = env->vstart; i < env->vl; env->vstart = ++i) {
+        k = 0;
+        if (!vm && !th_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        while (k < nf) {
+            target_ulong addr = base + stride * i + k * msz;
+            ldst_elem(env, adjust_addr(env, addr), i + k * vlmax, vd, ra);
+            k++;
+        }
+    }
+    env->vstart = 0;
+    /*
+     * clear tail elements
+     * clear_elem is NULL when store
+     */
+    if (clear_elem) {
+        for (k = 0; k < nf; k++) {
+            clear_elem(vd, env->vl + k * vlmax, env->vl * esz, vlmax * esz);
+        }
+    }
+}
+
+/*
+ * GEN_TH_LD_STRIDE is similar to GEN_VEXT_LD_STRIDE
+ * just change the function args
+ */
+#define GEN_TH_LD_STRIDE(NAME, MTYPE, ETYPE, LOAD_FN, CLEAR_FN)         \
+void HELPER(NAME)(void *vd, void * v0, target_ulong base,               \
+                  target_ulong stride, CPURISCVState *env,              \
+                  uint32_t desc)                                        \
+{                                                                       \
+    uint32_t vm = th_vm(desc);                                          \
+    th_ldst_stride(vd, v0, base, stride, env, desc, vm, LOAD_FN,        \
+                   CLEAR_FN, sizeof(ETYPE), sizeof(MTYPE), GETPC());    \
+}
+
+GEN_TH_LD_STRIDE(th_vlsb_v_b,  int8_t,   int8_t,   ldb_b,  clearb_th)
+GEN_TH_LD_STRIDE(th_vlsb_v_h,  int8_t,   int16_t,  ldb_h,  clearh_th)
+GEN_TH_LD_STRIDE(th_vlsb_v_w,  int8_t,   int32_t,  ldb_w,  clearl_th)
+GEN_TH_LD_STRIDE(th_vlsb_v_d,  int8_t,   int64_t,  ldb_d,  clearq_th)
+GEN_TH_LD_STRIDE(th_vlsh_v_h,  int16_t,  int16_t,  ldh_h,  clearh_th)
+GEN_TH_LD_STRIDE(th_vlsh_v_w,  int16_t,  int32_t,  ldh_w,  clearl_th)
+GEN_TH_LD_STRIDE(th_vlsh_v_d,  int16_t,  int64_t,  ldh_d,  clearq_th)
+GEN_TH_LD_STRIDE(th_vlsw_v_w,  int32_t,  int32_t,  ldw_w,  clearl_th)
+GEN_TH_LD_STRIDE(th_vlsw_v_d,  int32_t,  int64_t,  ldw_d,  clearq_th)
+GEN_TH_LD_STRIDE(th_vlse_v_b,  int8_t,   int8_t,   lde_b,  clearb_th)
+GEN_TH_LD_STRIDE(th_vlse_v_h,  int16_t,  int16_t,  lde_h,  clearh_th)
+GEN_TH_LD_STRIDE(th_vlse_v_w,  int32_t,  int32_t,  lde_w,  clearl_th)
+GEN_TH_LD_STRIDE(th_vlse_v_d,  int64_t,  int64_t,  lde_d,  clearq_th)
+GEN_TH_LD_STRIDE(th_vlsbu_v_b, uint8_t,  uint8_t,  ldbu_b, clearb_th)
+GEN_TH_LD_STRIDE(th_vlsbu_v_h, uint8_t,  uint16_t, ldbu_h, clearh_th)
+GEN_TH_LD_STRIDE(th_vlsbu_v_w, uint8_t,  uint32_t, ldbu_w, clearl_th)
+GEN_TH_LD_STRIDE(th_vlsbu_v_d, uint8_t,  uint64_t, ldbu_d, clearq_th)
+GEN_TH_LD_STRIDE(th_vlshu_v_h, uint16_t, uint16_t, ldhu_h, clearh_th)
+GEN_TH_LD_STRIDE(th_vlshu_v_w, uint16_t, uint32_t, ldhu_w, clearl_th)
+GEN_TH_LD_STRIDE(th_vlshu_v_d, uint16_t, uint64_t, ldhu_d, clearq_th)
+GEN_TH_LD_STRIDE(th_vlswu_v_w, uint32_t, uint32_t, ldwu_w, clearl_th)
+GEN_TH_LD_STRIDE(th_vlswu_v_d, uint32_t, uint64_t, ldwu_d, clearq_th)
-- 
2.44.0


