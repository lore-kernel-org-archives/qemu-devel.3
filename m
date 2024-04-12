Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE62C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 09:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDAG-0000RH-IU; Fri, 12 Apr 2024 05:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDAE-0000Qq-Lb; Fri, 12 Apr 2024 05:25:42 -0400
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDAA-0003Og-QJ; Fri, 12 Apr 2024 05:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712913933; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=8jiVqgjUlKLKgH92tksdoxhczfZlcWXYxmxNVCzrspQ=;
 b=H9QNdN0Y5y2HhoDIbFxLy9eSczrfjFWFiS35t+T2hzWX0zk8+sEMKQEoLRv9uk8YTFPg/NNG34osNFEB3BV9oLd4z6N0YIFFuiHN+DnF2046juRj5D62b2xIjhQ4/Q7GEtxI0vJR1HIiH+GG/x068ey2749M7ImWe1/jBaK10Bk=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NsZN6_1712913931; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NsZN6_1712913931) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 17:25:32 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 45/65] target/riscv: Add floating-point compare instructions
 for XTheadVector
Date: Fri, 12 Apr 2024 15:37:15 +0800
Message-ID: <20240412073735.76413-46-eric.huang@linux.alibaba.com>
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

There is no similar instruction in RVV1.0 as th.vmford in XTheadVector.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         | 37 +++++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 49 +++++++---
 target/riscv/vector_helper.c                  | 18 ++--
 target/riscv/vector_internals.h               | 10 ++
 target/riscv/xtheadvector_helper.c            | 96 +++++++++++++++++++
 5 files changed, 189 insertions(+), 21 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 2b9d7fa2b6..5771a4fa8a 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -2152,3 +2152,40 @@ DEF_HELPER_6(th_vfsgnjn_vf_d, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(th_vfsgnjx_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(th_vfsgnjx_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(th_vfsgnjx_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_6(th_vmfeq_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmfeq_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmfeq_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmfne_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmfne_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmfne_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmflt_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmflt_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmflt_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmfle_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmfle_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmfle_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmfeq_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vmfeq_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vmfeq_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vmfne_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vmfne_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vmfne_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vmflt_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vmflt_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vmflt_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vmfle_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vmfle_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vmfle_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vmfgt_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vmfgt_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vmfgt_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vmfge_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vmfge_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vmfge_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vmford_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmford_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmford_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmford_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vmford_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vmford_vf_d, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 1374bad5b9..1e773c673e 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -2106,24 +2106,49 @@ GEN_OPFVF_TRANS_TH(th_vfsgnj_vf, opfvf_check_th)
 GEN_OPFVF_TRANS_TH(th_vfsgnjn_vf, opfvf_check_th)
 GEN_OPFVF_TRANS_TH(th_vfsgnjx_vf, opfvf_check_th)
 
+/* Vector Floating-Point Compare Instructions */
+static bool opfvv_cmp_check_th(DisasContext *s, arg_rmrr *a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_reg(s, a->rs2, false) &&
+            th_check_reg(s, a->rs1, false) &&
+            (s->sew != 0) &&
+            ((th_check_overlap_group(a->rd, 1, a->rs1, 1 << s->lmul) &&
+              th_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul)) ||
+             (s->lmul == 0)));
+}
+
+GEN_OPFVV_TRANS_TH(th_vmfeq_vv, opfvv_cmp_check_th)
+GEN_OPFVV_TRANS_TH(th_vmfne_vv, opfvv_cmp_check_th)
+GEN_OPFVV_TRANS_TH(th_vmflt_vv, opfvv_cmp_check_th)
+GEN_OPFVV_TRANS_TH(th_vmfle_vv, opfvv_cmp_check_th)
+GEN_OPFVV_TRANS_TH(th_vmford_vv, opfvv_cmp_check_th)
+
+static bool opfvf_cmp_check_th(DisasContext *s, arg_rmrr *a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_reg(s, a->rs2, false) &&
+            (s->sew != 0) &&
+            (th_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul) ||
+             (s->lmul == 0)));
+}
+
+GEN_OPFVF_TRANS_TH(th_vmfeq_vf, opfvf_cmp_check_th)
+GEN_OPFVF_TRANS_TH(th_vmfne_vf, opfvf_cmp_check_th)
+GEN_OPFVF_TRANS_TH(th_vmflt_vf, opfvf_cmp_check_th)
+GEN_OPFVF_TRANS_TH(th_vmfle_vf, opfvf_cmp_check_th)
+GEN_OPFVF_TRANS_TH(th_vmfgt_vf, opfvf_cmp_check_th)
+GEN_OPFVF_TRANS_TH(th_vmfge_vf, opfvf_cmp_check_th)
+GEN_OPFVF_TRANS_TH(th_vmford_vf, opfvf_cmp_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vmfeq_vv)
-TH_TRANS_STUB(th_vmfeq_vf)
-TH_TRANS_STUB(th_vmfne_vv)
-TH_TRANS_STUB(th_vmfne_vf)
-TH_TRANS_STUB(th_vmflt_vv)
-TH_TRANS_STUB(th_vmflt_vf)
-TH_TRANS_STUB(th_vmfle_vv)
-TH_TRANS_STUB(th_vmfle_vf)
-TH_TRANS_STUB(th_vmfgt_vf)
-TH_TRANS_STUB(th_vmfge_vf)
-TH_TRANS_STUB(th_vmford_vv)
-TH_TRANS_STUB(th_vmford_vf)
 TH_TRANS_STUB(th_vfclass_v)
 TH_TRANS_STUB(th_vfmerge_vfm)
 TH_TRANS_STUB(th_vfmv_v_f)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index d0ebda5445..c966600d0c 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4050,19 +4050,19 @@ GEN_VEXT_CMP_VF(vmfeq_vf_h, uint16_t, H2, float16_eq_quiet)
 GEN_VEXT_CMP_VF(vmfeq_vf_w, uint32_t, H4, float32_eq_quiet)
 GEN_VEXT_CMP_VF(vmfeq_vf_d, uint64_t, H8, float64_eq_quiet)
 
-static bool vmfne16(uint16_t a, uint16_t b, float_status *s)
+bool vmfne16(uint16_t a, uint16_t b, float_status *s)
 {
     FloatRelation compare = float16_compare_quiet(a, b, s);
     return compare != float_relation_equal;
 }
 
-static bool vmfne32(uint32_t a, uint32_t b, float_status *s)
+bool vmfne32(uint32_t a, uint32_t b, float_status *s)
 {
     FloatRelation compare = float32_compare_quiet(a, b, s);
     return compare != float_relation_equal;
 }
 
-static bool vmfne64(uint64_t a, uint64_t b, float_status *s)
+bool vmfne64(uint64_t a, uint64_t b, float_status *s)
 {
     FloatRelation compare = float64_compare_quiet(a, b, s);
     return compare != float_relation_equal;
@@ -4089,19 +4089,19 @@ GEN_VEXT_CMP_VF(vmfle_vf_h, uint16_t, H2, float16_le)
 GEN_VEXT_CMP_VF(vmfle_vf_w, uint32_t, H4, float32_le)
 GEN_VEXT_CMP_VF(vmfle_vf_d, uint64_t, H8, float64_le)
 
-static bool vmfgt16(uint16_t a, uint16_t b, float_status *s)
+bool vmfgt16(uint16_t a, uint16_t b, float_status *s)
 {
     FloatRelation compare = float16_compare(a, b, s);
     return compare == float_relation_greater;
 }
 
-static bool vmfgt32(uint32_t a, uint32_t b, float_status *s)
+bool vmfgt32(uint32_t a, uint32_t b, float_status *s)
 {
     FloatRelation compare = float32_compare(a, b, s);
     return compare == float_relation_greater;
 }
 
-static bool vmfgt64(uint64_t a, uint64_t b, float_status *s)
+bool vmfgt64(uint64_t a, uint64_t b, float_status *s)
 {
     FloatRelation compare = float64_compare(a, b, s);
     return compare == float_relation_greater;
@@ -4111,21 +4111,21 @@ GEN_VEXT_CMP_VF(vmfgt_vf_h, uint16_t, H2, vmfgt16)
 GEN_VEXT_CMP_VF(vmfgt_vf_w, uint32_t, H4, vmfgt32)
 GEN_VEXT_CMP_VF(vmfgt_vf_d, uint64_t, H8, vmfgt64)
 
-static bool vmfge16(uint16_t a, uint16_t b, float_status *s)
+bool vmfge16(uint16_t a, uint16_t b, float_status *s)
 {
     FloatRelation compare = float16_compare(a, b, s);
     return compare == float_relation_greater ||
            compare == float_relation_equal;
 }
 
-static bool vmfge32(uint32_t a, uint32_t b, float_status *s)
+bool vmfge32(uint32_t a, uint32_t b, float_status *s)
 {
     FloatRelation compare = float32_compare(a, b, s);
     return compare == float_relation_greater ||
            compare == float_relation_equal;
 }
 
-static bool vmfge64(uint64_t a, uint64_t b, float_status *s)
+bool vmfge64(uint64_t a, uint64_t b, float_status *s)
 {
     FloatRelation compare = float64_compare(a, b, s);
     return compare == float_relation_greater ||
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index bcc7d0edd6..b870e15392 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -404,4 +404,14 @@ uint16_t fsgnjx16(uint16_t a, uint16_t b, float_status *s);
 uint32_t fsgnjx32(uint32_t a, uint32_t b, float_status *s);
 uint64_t fsgnjx64(uint64_t a, uint64_t b, float_status *s);
 
+bool vmfne16(uint16_t a, uint16_t b, float_status *s);
+bool vmfne32(uint32_t a, uint32_t b, float_status *s);
+bool vmfne64(uint64_t a, uint64_t b, float_status *s);
+bool vmfgt16(uint16_t a, uint16_t b, float_status *s);
+bool vmfgt32(uint32_t a, uint32_t b, float_status *s);
+bool vmfgt64(uint64_t a, uint64_t b, float_status *s);
+bool vmfge16(uint16_t a, uint16_t b, float_status *s);
+bool vmfge32(uint32_t a, uint32_t b, float_status *s);
+bool vmfge64(uint64_t a, uint64_t b, float_status *s);
+
 #endif /* TARGET_RISCV_VECTOR_INTERNALS_H */
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 38476900a6..603b34a094 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -3051,3 +3051,99 @@ THCALL(TH_OPFVF2, th_vfsgnjx_vf_d, OP_UUU_D, H8, H8, fsgnjx64)
 GEN_TH_VF(th_vfsgnjx_vf_h, 2, 2, clearh_th)
 GEN_TH_VF(th_vfsgnjx_vf_w, 4, 4, clearl_th)
 GEN_TH_VF(th_vfsgnjx_vf_d, 8, 8, clearq_th)
+
+/* Vector Floating-Point Compare Instructions */
+#define GEN_TH_CMP_VV_ENV(NAME, ETYPE, H, DO_OP)              \
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
+        th_set_elem_mask(vd, mlen, i,                         \
+                         DO_OP(s2, s1, &env->fp_status));     \
+    }                                                         \
+    env->vstart = 0;                                          \
+    for (; i < vlmax; i++) {                                  \
+        th_set_elem_mask(vd, mlen, i, 0);                     \
+    }                                                         \
+}
+
+GEN_TH_CMP_VV_ENV(th_vmfeq_vv_h, uint16_t, H2, float16_eq_quiet)
+GEN_TH_CMP_VV_ENV(th_vmfeq_vv_w, uint32_t, H4, float32_eq_quiet)
+GEN_TH_CMP_VV_ENV(th_vmfeq_vv_d, uint64_t, H8, float64_eq_quiet)
+
+#define GEN_TH_CMP_VF(NAME, ETYPE, H, DO_OP)                        \
+void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
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
+                         DO_OP(s2, (ETYPE)s1, &env->fp_status));    \
+    }                                                               \
+    env->vstart = 0;                                                \
+    for (; i < vlmax; i++) {                                        \
+        th_set_elem_mask(vd, mlen, i, 0);                           \
+    }                                                               \
+}
+
+GEN_TH_CMP_VF(th_vmfeq_vf_h, uint16_t, H2, float16_eq_quiet)
+GEN_TH_CMP_VF(th_vmfeq_vf_w, uint32_t, H4, float32_eq_quiet)
+GEN_TH_CMP_VF(th_vmfeq_vf_d, uint64_t, H8, float64_eq_quiet)
+
+GEN_TH_CMP_VV_ENV(th_vmfne_vv_h, uint16_t, H2, vmfne16)
+GEN_TH_CMP_VV_ENV(th_vmfne_vv_w, uint32_t, H4, vmfne32)
+GEN_TH_CMP_VV_ENV(th_vmfne_vv_d, uint64_t, H8, vmfne64)
+GEN_TH_CMP_VF(th_vmfne_vf_h, uint16_t, H2, vmfne16)
+GEN_TH_CMP_VF(th_vmfne_vf_w, uint32_t, H4, vmfne32)
+GEN_TH_CMP_VF(th_vmfne_vf_d, uint64_t, H8, vmfne64)
+
+GEN_TH_CMP_VV_ENV(th_vmflt_vv_h, uint16_t, H2, float16_lt)
+GEN_TH_CMP_VV_ENV(th_vmflt_vv_w, uint32_t, H4, float32_lt)
+GEN_TH_CMP_VV_ENV(th_vmflt_vv_d, uint64_t, H8, float64_lt)
+GEN_TH_CMP_VF(th_vmflt_vf_h, uint16_t, H2, float16_lt)
+GEN_TH_CMP_VF(th_vmflt_vf_w, uint32_t, H4, float32_lt)
+GEN_TH_CMP_VF(th_vmflt_vf_d, uint64_t, H8, float64_lt)
+
+GEN_TH_CMP_VV_ENV(th_vmfle_vv_h, uint16_t, H2, float16_le)
+GEN_TH_CMP_VV_ENV(th_vmfle_vv_w, uint32_t, H4, float32_le)
+GEN_TH_CMP_VV_ENV(th_vmfle_vv_d, uint64_t, H8, float64_le)
+GEN_TH_CMP_VF(th_vmfle_vf_h, uint16_t, H2, float16_le)
+GEN_TH_CMP_VF(th_vmfle_vf_w, uint32_t, H4, float32_le)
+GEN_TH_CMP_VF(th_vmfle_vf_d, uint64_t, H8, float64_le)
+
+GEN_TH_CMP_VF(th_vmfgt_vf_h, uint16_t, H2, vmfgt16)
+GEN_TH_CMP_VF(th_vmfgt_vf_w, uint32_t, H4, vmfgt32)
+GEN_TH_CMP_VF(th_vmfgt_vf_d, uint64_t, H8, vmfgt64)
+
+GEN_TH_CMP_VF(th_vmfge_vf_h, uint16_t, H2, vmfge16)
+GEN_TH_CMP_VF(th_vmfge_vf_w, uint32_t, H4, vmfge32)
+GEN_TH_CMP_VF(th_vmfge_vf_d, uint64_t, H8, vmfge64)
+
+GEN_TH_CMP_VV_ENV(th_vmford_vv_h, uint16_t, H2, !float16_unordered_quiet)
+GEN_TH_CMP_VV_ENV(th_vmford_vv_w, uint32_t, H4, !float32_unordered_quiet)
+GEN_TH_CMP_VV_ENV(th_vmford_vv_d, uint64_t, H8, !float64_unordered_quiet)
+GEN_TH_CMP_VF(th_vmford_vf_h, uint16_t, H2, !float16_unordered_quiet)
+GEN_TH_CMP_VF(th_vmford_vf_w, uint32_t, H4, !float32_unordered_quiet)
+GEN_TH_CMP_VF(th_vmford_vf_d, uint64_t, H8, !float64_unordered_quiet)
-- 
2.44.0


