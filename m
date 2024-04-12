Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B88C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvCBo-0006PX-2K; Fri, 12 Apr 2024 04:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCBm-0006ON-I8; Fri, 12 Apr 2024 04:23:14 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCBj-00084P-61; Fri, 12 Apr 2024 04:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712910185; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=Xw/B1iKhHAB1bZRFrLI7LnGzX6yfajlljeqcaYIlm5M=;
 b=LWxVqu4BO49avhlYIJFtOlq1KXPXVeC0+hwwRQ7RMMaXSfReGd0N5XmlLCOvLIWMA/K9UR7jUDqqTvkF4l6z8a9k8z5rqUwk0CcKLdkizeWq5SnJQ77H1XktERbvSTShlCWxQpRyNnb6ZG7HetmqtWO4TSI/piSk3cFOBMPBsdk=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R421e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NfEHh_1712910183; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NfEHh_1712910183) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 16:23:04 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 22/65] target/riscv: Add integer compare instructions for
 XTheadVector
Date: Fri, 12 Apr 2024 15:36:52 +0800
Message-ID: <20240412073735.76413-23-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.133;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-133.freemail.mail.aliyun.com
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

The instructions have the same function as RVV1.0. Overall there are only
general differences between XTheadVector and RVV1.0.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         |  57 ++++++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc |  69 +++++++---
 target/riscv/xtheadvector_helper.c            | 127 ++++++++++++++++++
 3 files changed, 233 insertions(+), 20 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index d3170ba91f..8f2dec158b 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1638,3 +1638,60 @@ DEF_HELPER_6(th_vnsrl_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vnsra_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vnsra_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vnsra_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(th_vmseq_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmseq_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmseq_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmseq_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmsne_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmsne_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmsne_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmsne_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmsltu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmsltu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmsltu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmsltu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmslt_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmslt_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmslt_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmslt_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmsleu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmsleu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmsleu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmsleu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmsle_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmsle_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmsle_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmsle_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmseq_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmseq_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmseq_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmseq_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmsne_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmsne_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmsne_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmsne_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmsltu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmsltu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmsltu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmsltu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmslt_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmslt_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmslt_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmslt_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmsleu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmsleu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmsleu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmsleu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmsle_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmsle_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmsle_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmsle_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmsgtu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmsgtu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmsgtu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmsgtu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmsgt_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmsgt_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmsgt_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmsgt_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 68810ff0ec..049d9da0a5 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -1470,32 +1470,61 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
 GEN_OPIVI_NARROW_TRANS_TH(th_vnsra_vi, IMM_ZX, th_vnsra_vx)
 GEN_OPIVI_NARROW_TRANS_TH(th_vnsrl_vi, IMM_ZX, th_vnsrl_vx)
 
+/* Vector Integer Comparison Instructions */
+
+/*
+ * For all comparison instructions, an illegal instruction exception is raised
+ * if the destination vector register overlaps a source vector register group
+ * and LMUL > 1.
+ */
+static bool opivv_cmp_check_th(DisasContext *s, arg_rmrr *a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_reg(s, a->rs2, false) &&
+            th_check_reg(s, a->rs1, false) &&
+            ((th_check_overlap_group(a->rd, 1, a->rs1, 1 << s->lmul) &&
+              th_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul)) ||
+             (s->lmul == 0)));
+}
+GEN_OPIVV_TRANS_TH(th_vmseq_vv, opivv_cmp_check_th)
+GEN_OPIVV_TRANS_TH(th_vmsne_vv, opivv_cmp_check_th)
+GEN_OPIVV_TRANS_TH(th_vmsltu_vv, opivv_cmp_check_th)
+GEN_OPIVV_TRANS_TH(th_vmslt_vv, opivv_cmp_check_th)
+GEN_OPIVV_TRANS_TH(th_vmsleu_vv, opivv_cmp_check_th)
+GEN_OPIVV_TRANS_TH(th_vmsle_vv, opivv_cmp_check_th)
+
+static bool opivx_cmp_check_th(DisasContext *s, arg_rmrr *a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_reg(s, a->rs2, false) &&
+            (th_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul) ||
+             (s->lmul == 0)));
+}
+
+GEN_OPIVX_TRANS_TH(th_vmseq_vx, opivx_cmp_check_th)
+GEN_OPIVX_TRANS_TH(th_vmsne_vx, opivx_cmp_check_th)
+GEN_OPIVX_TRANS_TH(th_vmsltu_vx, opivx_cmp_check_th)
+GEN_OPIVX_TRANS_TH(th_vmslt_vx, opivx_cmp_check_th)
+GEN_OPIVX_TRANS_TH(th_vmsleu_vx, opivx_cmp_check_th)
+GEN_OPIVX_TRANS_TH(th_vmsle_vx, opivx_cmp_check_th)
+GEN_OPIVX_TRANS_TH(th_vmsgtu_vx, opivx_cmp_check_th)
+GEN_OPIVX_TRANS_TH(th_vmsgt_vx, opivx_cmp_check_th)
+
+GEN_OPIVI_TRANS_TH(th_vmseq_vi, IMM_SX, th_vmseq_vx, opivx_cmp_check_th)
+GEN_OPIVI_TRANS_TH(th_vmsne_vi, IMM_SX, th_vmsne_vx, opivx_cmp_check_th)
+GEN_OPIVI_TRANS_TH(th_vmsleu_vi, IMM_ZX, th_vmsleu_vx, opivx_cmp_check_th)
+GEN_OPIVI_TRANS_TH(th_vmsle_vi, IMM_SX, th_vmsle_vx, opivx_cmp_check_th)
+GEN_OPIVI_TRANS_TH(th_vmsgtu_vi, IMM_ZX, th_vmsgtu_vx, opivx_cmp_check_th)
+GEN_OPIVI_TRANS_TH(th_vmsgt_vi, IMM_SX, th_vmsgt_vx, opivx_cmp_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vmseq_vv)
-TH_TRANS_STUB(th_vmseq_vx)
-TH_TRANS_STUB(th_vmseq_vi)
-TH_TRANS_STUB(th_vmsne_vv)
-TH_TRANS_STUB(th_vmsne_vx)
-TH_TRANS_STUB(th_vmsne_vi)
-TH_TRANS_STUB(th_vmsltu_vv)
-TH_TRANS_STUB(th_vmsltu_vx)
-TH_TRANS_STUB(th_vmslt_vv)
-TH_TRANS_STUB(th_vmslt_vx)
-TH_TRANS_STUB(th_vmsleu_vv)
-TH_TRANS_STUB(th_vmsleu_vx)
-TH_TRANS_STUB(th_vmsleu_vi)
-TH_TRANS_STUB(th_vmsle_vv)
-TH_TRANS_STUB(th_vmsle_vx)
-TH_TRANS_STUB(th_vmsle_vi)
-TH_TRANS_STUB(th_vmsgtu_vx)
-TH_TRANS_STUB(th_vmsgtu_vi)
-TH_TRANS_STUB(th_vmsgt_vx)
-TH_TRANS_STUB(th_vmsgt_vi)
 TH_TRANS_STUB(th_vminu_vv)
 TH_TRANS_STUB(th_vminu_vx)
 TH_TRANS_STUB(th_vmin_vv)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index f4bd80349d..827650b325 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -1415,3 +1415,130 @@ GEN_TH_SHIFT_VX(th_vnsra_vx_h, int16_t, int32_t, H2, H4, TH_SRL,
                 0x1f, clearh_th)
 GEN_TH_SHIFT_VX(th_vnsra_vx_w, int32_t, int64_t, H4, H8, TH_SRL,
                 0x3f, clearl_th)
+
+/* Vector Integer Comparison Instructions */
+#define TH_MSEQ(N, M) (N == M)
+#define TH_MSNE(N, M) (N != M)
+#define TH_MSLT(N, M) (N < M)
+#define TH_MSLE(N, M) (N <= M)
+#define TH_MSGT(N, M) (N > M)
+
+#define GEN_TH_CMP_VV(NAME, ETYPE, H, DO_OP)                  \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
+                  CPURISCVState *env, uint32_t desc)          \
+{                                                             \
+    uint32_t mlen = th_mlen(desc);                            \
+    uint32_t vm = th_vm(desc);                                \
+    uint32_t vl = env->vl;                                    \
+    uint32_t vlmax = th_maxsz(desc) / sizeof(ETYPE);          \
+    uint32_t i;                                               \
+                                                              \
+    VSTART_CHECK_EARLY_EXIT(env);                             \
+    for (i = env->vstart; i < vl; i++) {                      \
+        ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
+        if (!vm && !th_elem_mask(v0, mlen, i)) {              \
+            continue;                                         \
+        }                                                     \
+        th_set_elem_mask(vd, mlen, i, DO_OP(s2, s1));         \
+    }                                                         \
+    env->vstart = 0;                                          \
+    for (; i < vlmax; i++) {                                  \
+        th_set_elem_mask(vd, mlen, i, 0);                     \
+    }                                                         \
+}
+
+GEN_TH_CMP_VV(th_vmseq_vv_b, uint8_t,  H1, TH_MSEQ)
+GEN_TH_CMP_VV(th_vmseq_vv_h, uint16_t, H2, TH_MSEQ)
+GEN_TH_CMP_VV(th_vmseq_vv_w, uint32_t, H4, TH_MSEQ)
+GEN_TH_CMP_VV(th_vmseq_vv_d, uint64_t, H8, TH_MSEQ)
+
+GEN_TH_CMP_VV(th_vmsne_vv_b, uint8_t,  H1, TH_MSNE)
+GEN_TH_CMP_VV(th_vmsne_vv_h, uint16_t, H2, TH_MSNE)
+GEN_TH_CMP_VV(th_vmsne_vv_w, uint32_t, H4, TH_MSNE)
+GEN_TH_CMP_VV(th_vmsne_vv_d, uint64_t, H8, TH_MSNE)
+
+GEN_TH_CMP_VV(th_vmsltu_vv_b, uint8_t,  H1, TH_MSLT)
+GEN_TH_CMP_VV(th_vmsltu_vv_h, uint16_t, H2, TH_MSLT)
+GEN_TH_CMP_VV(th_vmsltu_vv_w, uint32_t, H4, TH_MSLT)
+GEN_TH_CMP_VV(th_vmsltu_vv_d, uint64_t, H8, TH_MSLT)
+
+GEN_TH_CMP_VV(th_vmslt_vv_b, int8_t,  H1, TH_MSLT)
+GEN_TH_CMP_VV(th_vmslt_vv_h, int16_t, H2, TH_MSLT)
+GEN_TH_CMP_VV(th_vmslt_vv_w, int32_t, H4, TH_MSLT)
+GEN_TH_CMP_VV(th_vmslt_vv_d, int64_t, H8, TH_MSLT)
+
+GEN_TH_CMP_VV(th_vmsleu_vv_b, uint8_t,  H1, TH_MSLE)
+GEN_TH_CMP_VV(th_vmsleu_vv_h, uint16_t, H2, TH_MSLE)
+GEN_TH_CMP_VV(th_vmsleu_vv_w, uint32_t, H4, TH_MSLE)
+GEN_TH_CMP_VV(th_vmsleu_vv_d, uint64_t, H8, TH_MSLE)
+
+GEN_TH_CMP_VV(th_vmsle_vv_b, int8_t,  H1, TH_MSLE)
+GEN_TH_CMP_VV(th_vmsle_vv_h, int16_t, H2, TH_MSLE)
+GEN_TH_CMP_VV(th_vmsle_vv_w, int32_t, H4, TH_MSLE)
+GEN_TH_CMP_VV(th_vmsle_vv_d, int64_t, H8, TH_MSLE)
+
+#define GEN_TH_CMP_VX(NAME, ETYPE, H, DO_OP)                        \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,   \
+                  CPURISCVState *env, uint32_t desc)                \
+{                                                                   \
+    uint32_t mlen = th_mlen(desc);                                  \
+    uint32_t vm = th_vm(desc);                                      \
+    uint32_t vl = env->vl;                                          \
+    uint32_t vlmax = th_maxsz(desc) / sizeof(ETYPE);                \
+    uint32_t i;                                                     \
+                                                                    \
+    VSTART_CHECK_EARLY_EXIT(env);                                   \
+    for (i = env->vstart; i < vl; i++) {                            \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                          \
+        if (!vm && !th_elem_mask(v0, mlen, i)) {                    \
+            continue;                                               \
+        }                                                           \
+        th_set_elem_mask(vd, mlen, i,                               \
+                DO_OP(s2, (ETYPE)(target_long)s1));                 \
+    }                                                               \
+    env->vstart = 0;                                                \
+    for (; i < vlmax; i++) {                                        \
+        th_set_elem_mask(vd, mlen, i, 0);                           \
+    }                                                               \
+}
+
+GEN_TH_CMP_VX(th_vmseq_vx_b, uint8_t,  H1, TH_MSEQ)
+GEN_TH_CMP_VX(th_vmseq_vx_h, uint16_t, H2, TH_MSEQ)
+GEN_TH_CMP_VX(th_vmseq_vx_w, uint32_t, H4, TH_MSEQ)
+GEN_TH_CMP_VX(th_vmseq_vx_d, uint64_t, H8, TH_MSEQ)
+
+GEN_TH_CMP_VX(th_vmsne_vx_b, uint8_t,  H1, TH_MSNE)
+GEN_TH_CMP_VX(th_vmsne_vx_h, uint16_t, H2, TH_MSNE)
+GEN_TH_CMP_VX(th_vmsne_vx_w, uint32_t, H4, TH_MSNE)
+GEN_TH_CMP_VX(th_vmsne_vx_d, uint64_t, H8, TH_MSNE)
+
+GEN_TH_CMP_VX(th_vmsltu_vx_b, uint8_t,  H1, TH_MSLT)
+GEN_TH_CMP_VX(th_vmsltu_vx_h, uint16_t, H2, TH_MSLT)
+GEN_TH_CMP_VX(th_vmsltu_vx_w, uint32_t, H4, TH_MSLT)
+GEN_TH_CMP_VX(th_vmsltu_vx_d, uint64_t, H8, TH_MSLT)
+
+GEN_TH_CMP_VX(th_vmslt_vx_b, int8_t,  H1, TH_MSLT)
+GEN_TH_CMP_VX(th_vmslt_vx_h, int16_t, H2, TH_MSLT)
+GEN_TH_CMP_VX(th_vmslt_vx_w, int32_t, H4, TH_MSLT)
+GEN_TH_CMP_VX(th_vmslt_vx_d, int64_t, H8, TH_MSLT)
+
+GEN_TH_CMP_VX(th_vmsleu_vx_b, uint8_t,  H1, TH_MSLE)
+GEN_TH_CMP_VX(th_vmsleu_vx_h, uint16_t, H2, TH_MSLE)
+GEN_TH_CMP_VX(th_vmsleu_vx_w, uint32_t, H4, TH_MSLE)
+GEN_TH_CMP_VX(th_vmsleu_vx_d, uint64_t, H8, TH_MSLE)
+
+GEN_TH_CMP_VX(th_vmsle_vx_b, int8_t,  H1, TH_MSLE)
+GEN_TH_CMP_VX(th_vmsle_vx_h, int16_t, H2, TH_MSLE)
+GEN_TH_CMP_VX(th_vmsle_vx_w, int32_t, H4, TH_MSLE)
+GEN_TH_CMP_VX(th_vmsle_vx_d, int64_t, H8, TH_MSLE)
+
+GEN_TH_CMP_VX(th_vmsgtu_vx_b, uint8_t,  H1, TH_MSGT)
+GEN_TH_CMP_VX(th_vmsgtu_vx_h, uint16_t, H2, TH_MSGT)
+GEN_TH_CMP_VX(th_vmsgtu_vx_w, uint32_t, H4, TH_MSGT)
+GEN_TH_CMP_VX(th_vmsgtu_vx_d, uint64_t, H8, TH_MSGT)
+
+GEN_TH_CMP_VX(th_vmsgt_vx_b, int8_t,  H1, TH_MSGT)
+GEN_TH_CMP_VX(th_vmsgt_vx_h, int16_t, H2, TH_MSGT)
+GEN_TH_CMP_VX(th_vmsgt_vx_w, int32_t, H4, TH_MSGT)
+GEN_TH_CMP_VX(th_vmsgt_vx_d, int64_t, H8, TH_MSGT)
-- 
2.44.0


