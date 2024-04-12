Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450E3C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 09:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDXq-0003yI-SI; Fri, 12 Apr 2024 05:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDXh-0003vm-Vd; Fri, 12 Apr 2024 05:50:00 -0400
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDXf-0006xW-RV; Fri, 12 Apr 2024 05:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712915390; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=imXaAcxAeJEThFU0GM/qjKnSob7ed7kgIB3usibiBv8=;
 b=hwZKwu264V2ta7yl8JLorBB7tEh7KMKhlHRUhX459hBX9HowmyA1FyUYG0QM+RmW+mJq/UCAuCCpvSJEB0QGYOpsKJvvXX2WpWE1MzPQzKsB+7FSyW6RxbrOnNc2pvR30G0slVnRDfAD5bOvIGnGB05mkPSENOp4DT6nA2DY6Ms=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R461e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4Nshnm_1712915388; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4Nshnm_1712915388) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 17:49:49 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 57/65] target/riscv: Add set-X-first mask bit instructrions
 for XTheadVector
Date: Fri, 12 Apr 2024 15:37:27 +0800
Message-ID: <20240412073735.76413-58-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.98;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-98.freemail.mail.aliyun.com
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

The instructions have the same function as RVV1.0. Overall there are only
general differences between XTheadVector and RVV1.0.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         |  4 ++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 36 ++++++++++-
 target/riscv/xtheadvector_helper.c            | 64 +++++++++++++++++++
 3 files changed, 101 insertions(+), 3 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 2379a3431d..90a1ff2601 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -2302,3 +2302,7 @@ DEF_HELPER_6(th_vmxnor_mm, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_4(th_vmpopc_m, tl, ptr, ptr, env, i32)
 
 DEF_HELPER_4(th_vmfirst_m, tl, ptr, ptr, env, i32)
+
+DEF_HELPER_5(th_vmsbf_m, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vmsif_m, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vmsof_m, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 45554c38fb..d41c691c31 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -2500,6 +2500,39 @@ static bool trans_th_vmfirst_m(DisasContext *s, arg_rmr *a)
     }
     return false;
 }
+/*
+ * th.vmsbf.m set-before-first mask bit
+ * th.vmsif.m set-including-first mask bit
+ * th.vmsof.m set-only-first mask bit
+ */
+#define GEN_M_TRANS_TH(NAME)                                       \
+static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
+{                                                                  \
+    if (require_xtheadvector(s) &&                                 \
+        vext_check_isa_ill(s) &&                                   \
+        (a->rd != a->rs2) &&                                       \
+        s->vstart_eq_zero) {                                       \
+        uint32_t data = 0;                                         \
+        gen_helper_gvec_3_ptr *fn = gen_helper_##NAME;             \
+                                                                   \
+        data = FIELD_DP32(data, VDATA_TH, MLEN, s->mlen);          \
+        data = FIELD_DP32(data, VDATA_TH, VM, a->vm);              \
+        data = FIELD_DP32(data, VDATA_TH, LMUL, s->lmul);          \
+        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd),                     \
+                           vreg_ofs(s, 0),                         \
+                           vreg_ofs(s, a->rs2),                    \
+                           tcg_env, s->cfg_ptr->vlenb,             \
+                           s->cfg_ptr->vlenb,                      \
+                           data, fn);                              \
+        finalize_rvv_inst(s);                                      \
+        return true;                                               \
+    }                                                              \
+    return false;                                                  \
+}
+
+GEN_M_TRANS_TH(th_vmsbf_m)
+GEN_M_TRANS_TH(th_vmsif_m)
+GEN_M_TRANS_TH(th_vmsof_m)
 
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
@@ -2507,9 +2540,6 @@ static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vmsbf_m)
-TH_TRANS_STUB(th_vmsif_m)
-TH_TRANS_STUB(th_vmsof_m)
 TH_TRANS_STUB(th_viota_m)
 TH_TRANS_STUB(th_vid_v)
 TH_TRANS_STUB(th_vext_x_v)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 1860e47f4f..d4f1665bf3 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -3558,3 +3558,67 @@ target_ulong HELPER(th_vmfirst_m)(void *v0, void *vs2, CPURISCVState *env,
     env->vstart = 0;
     return -1LL;
 }
+
+enum set_mask_type_th {
+    ONLY_FIRST = 1,
+    INCLUDE_FIRST,
+    BEFORE_FIRST,
+};
+
+static void vmsetm(void *vd, void *v0, void *vs2, CPURISCVState *env,
+                   uint32_t desc, enum set_mask_type_th type)
+{
+    uint32_t mlen = th_mlen(desc);
+    uint32_t vlmax = (env_archcpu(env)->cfg.vlenb << 3) / mlen;
+    uint32_t vm = th_vm(desc);
+    uint32_t vl = env->vl;
+    int i;
+    bool first_mask_bit = false;
+
+    for (i = env->vstart; i < vl; i++) {
+        if (!vm && !th_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        /* write a zero to all following active elements */
+        if (first_mask_bit) {
+            th_set_elem_mask(vd, mlen, i, 0);
+            continue;
+        }
+        if (th_elem_mask(vs2, mlen, i)) {
+            first_mask_bit = true;
+            if (type == BEFORE_FIRST) {
+                th_set_elem_mask(vd, mlen, i, 0);
+            } else {
+                th_set_elem_mask(vd, mlen, i, 1);
+            }
+        } else {
+            if (type == ONLY_FIRST) {
+                th_set_elem_mask(vd, mlen, i, 0);
+            } else {
+                th_set_elem_mask(vd, mlen, i, 1);
+            }
+        }
+    }
+    env->vstart = 0;
+    for (; i < vlmax; i++) {
+        th_set_elem_mask(vd, mlen, i, 0);
+    }
+}
+
+void HELPER(th_vmsbf_m)(void *vd, void *v0, void *vs2, CPURISCVState *env,
+                        uint32_t desc)
+{
+    vmsetm(vd, v0, vs2, env, desc, BEFORE_FIRST);
+}
+
+void HELPER(th_vmsif_m)(void *vd, void *v0, void *vs2, CPURISCVState *env,
+                        uint32_t desc)
+{
+    vmsetm(vd, v0, vs2, env, desc, INCLUDE_FIRST);
+}
+
+void HELPER(th_vmsof_m)(void *vd, void *v0, void *vs2, CPURISCVState *env,
+                        uint32_t desc)
+{
+    vmsetm(vd, v0, vs2, env, desc, ONLY_FIRST);
+}
-- 
2.44.0


