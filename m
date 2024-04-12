Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AD4C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 09:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDRr-0000ja-Nm; Fri, 12 Apr 2024 05:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDRq-0000jN-69; Fri, 12 Apr 2024 05:43:54 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDRn-00068O-QK; Fri, 12 Apr 2024 05:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712915026; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=SmbjskTSh1OMf/kh1nsuVP/7jRp1dpEJSJw1gknWio8=;
 b=fEYklDcuAJa//ZTN3wi8qFc7tZqkrC115SVMV2wZEYGJaauQgjLoQQvH/f82CLrni3q9/sqLtJ75B1YOOzMa8pus1rPYQyyJsP8ujGvzjGq1y973YOCV8mwgpqsQqE3cXpjQjNvcYMe08h+meWl2xwcYyZl9zTedI1CEnYlI5jA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R651e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4Nu1d9_1712915024; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4Nu1d9_1712915024) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 17:43:45 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 54/65] target/riscv: Add mask-register logical instructions
 for XTheadVector
Date: Fri, 12 Apr 2024 15:37:24 +0800
Message-ID: <20240412073735.76413-55-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.132;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-132.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

In this patch, we add mask-register logical instructions to show the way
we implement XTheadVector mask instructions.
XTheadVector mask-register logical instructions diff from RVV1.0 in the
following points:
1. Different mask reg layout. For mask bit of element i, XTheadVector locates it
   in bit[mlen], while RVV1.0 locates it in bit[i].

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         |  9 ++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 44 +++++++++++++++----
 target/riscv/xtheadvector_helper.c            | 42 ++++++++++++++++++
 3 files changed, 87 insertions(+), 8 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index c39ee9a8e8..7d992ac3b1 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -2289,3 +2289,12 @@ DEF_HELPER_6(th_vfredmin_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_6(th_vfwredsum_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(th_vfwredsum_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_6(th_vmand_mm, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmnand_mm, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmandnot_mm, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmxor_mm, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmor_mm, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmnor_mm, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmornot_mm, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmxnor_mm, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index b71875700b..e9fa7f1ae2 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -2405,20 +2405,48 @@ GEN_OPFVV_TRANS_TH(th_vfredmin_vs, reduction_check_th)
 /* Vector Widening Floating-Point Reduction Instructions */
 GEN_OPFVV_WIDEN_TRANS_TH(th_vfwredsum_vs, reduction_check_th)
 
+/*
+ * Vector Mask Operations
+ */
+
+/* Vector Mask-Register Logical Instructions */
+#define GEN_MM_TRANS_TH(NAME)                                      \
+static bool trans_##NAME(DisasContext *s, arg_r *a)                \
+{                                                                  \
+    if (require_xtheadvector(s) &&                                 \
+        vext_check_isa_ill(s)) {                                   \
+        uint32_t data = 0;                                         \
+        gen_helper_gvec_4_ptr *fn = gen_helper_##NAME;             \
+                                                                   \
+        data = FIELD_DP32(data, VDATA_TH, MLEN, s->mlen);          \
+        data = FIELD_DP32(data, VDATA_TH, LMUL, s->lmul);          \
+        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd),                     \
+                           vreg_ofs(s, 0),                         \
+                           vreg_ofs(s, a->rs1),                    \
+                           vreg_ofs(s, a->rs2), tcg_env,           \
+                           s->cfg_ptr->vlenb,                      \
+                           s->cfg_ptr->vlenb, data, fn);           \
+        finalize_rvv_inst(s);                                      \
+        return true;                                               \
+    }                                                              \
+    return false;                                                  \
+}
+
+GEN_MM_TRANS_TH(th_vmand_mm)
+GEN_MM_TRANS_TH(th_vmnand_mm)
+GEN_MM_TRANS_TH(th_vmandnot_mm)
+GEN_MM_TRANS_TH(th_vmxor_mm)
+GEN_MM_TRANS_TH(th_vmor_mm)
+GEN_MM_TRANS_TH(th_vmnor_mm)
+GEN_MM_TRANS_TH(th_vmornot_mm)
+GEN_MM_TRANS_TH(th_vmxnor_mm)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vmand_mm)
-TH_TRANS_STUB(th_vmnand_mm)
-TH_TRANS_STUB(th_vmandnot_mm)
-TH_TRANS_STUB(th_vmxor_mm)
-TH_TRANS_STUB(th_vmor_mm)
-TH_TRANS_STUB(th_vmnor_mm)
-TH_TRANS_STUB(th_vmornot_mm)
-TH_TRANS_STUB(th_vmxnor_mm)
 TH_TRANS_STUB(th_vmpopc_m)
 TH_TRANS_STUB(th_vmfirst_m)
 TH_TRANS_STUB(th_vmsbf_m)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 8953207630..b3f445eeb5 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -3475,3 +3475,45 @@ static uint64_t fwadd32(uint64_t a, uint32_t b, float_status *s)
 /* Unordered reduce 2*SEW = 2*SEW + sum(promote(SEW)) */
 GEN_TH_FRED(th_vfwredsum_vs_h, uint32_t, uint16_t, H4, H2, fwadd16, clearl_th)
 GEN_TH_FRED(th_vfwredsum_vs_w, uint64_t, uint32_t, H8, H4, fwadd32, clearq_th)
+
+/*
+ * Vector Mask Operations
+ */
+/* Vector Mask-Register Logical Instructions */
+#define GEN_TH_MASK_VV(NAME, OP)                                 \
+void HELPER(NAME)(void *vd, void *v0, void *vs1,                 \
+                  void *vs2, CPURISCVState *env,                 \
+                  uint32_t desc)                                 \
+{                                                                \
+    uint32_t mlen = th_mlen(desc);                               \
+    uint32_t vlmax = (env_archcpu(env)->cfg.vlenb << 3) / mlen;  \
+    uint32_t vl = env->vl;                                       \
+    uint32_t i;                                                  \
+    int a, b;                                                    \
+                                                                 \
+    VSTART_CHECK_EARLY_EXIT(env);                                \
+    for (i = env->vstart; i < vl; i++) {                         \
+        a = th_elem_mask(vs1, mlen, i);                          \
+        b = th_elem_mask(vs2, mlen, i);                          \
+        th_set_elem_mask(vd, mlen, i, OP(b, a));                 \
+    }                                                            \
+    env->vstart = 0;                                             \
+    for (; i < vlmax; i++) {                                     \
+        th_set_elem_mask(vd, mlen, i, 0);                        \
+    }                                                            \
+}
+
+#define TH_NAND(N, M)  (!(N & M))
+#define TH_ANDNOT(N, M)  (N & !M)
+#define TH_NOR(N, M)  (!(N | M))
+#define TH_ORNOT(N, M)  (N | !M)
+#define TH_XNOR(N, M)  (!(N ^ M))
+
+GEN_TH_MASK_VV(th_vmand_mm, TH_AND)
+GEN_TH_MASK_VV(th_vmnand_mm, TH_NAND)
+GEN_TH_MASK_VV(th_vmandnot_mm, TH_ANDNOT)
+GEN_TH_MASK_VV(th_vmxor_mm, TH_XOR)
+GEN_TH_MASK_VV(th_vmor_mm, TH_OR)
+GEN_TH_MASK_VV(th_vmnor_mm, TH_NOR)
+GEN_TH_MASK_VV(th_vmornot_mm, TH_ORNOT)
+GEN_TH_MASK_VV(th_vmxnor_mm, TH_XNOR)
-- 
2.44.0


