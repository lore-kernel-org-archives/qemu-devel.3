Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE77C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvCfJ-00053Y-Qd; Fri, 12 Apr 2024 04:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCfH-00052k-IU; Fri, 12 Apr 2024 04:53:43 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCf5-0005zM-Vh; Fri, 12 Apr 2024 04:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712912007; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=RIg6PWSzgeHhBKgFWo9JZiHi0QPSvyckGd64FC9/oh8=;
 b=g+YUsxQ7ROetcFgdA2nNZcpi06h1dT3rWsjz3Cjyr5Nhp/+SnewLaDrkKP2yy24eNQOb0kvSd3FvJepuakWFMUF4UcKVus/TItTTbtA6jVCyLOVcG+ovukeqGxUIY/SdLK1GDQvc/eM21bNjO1BI675xMApEDmE0hfbkAKM4yv0=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4Nc.B4_1712912005; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4Nc.B4_1712912005) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 16:53:26 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 37/65] target/riscv: Add widening floating-point add/sub
 instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:37:07 +0800
Message-ID: <20240412073735.76413-38-eric.huang@linux.alibaba.com>
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
 target/riscv/helper.h                         |  17 ++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 162 +++++++++++++++++-
 target/riscv/vector_helper.c                  |  16 +-
 target/riscv/vector_internals.h               |   9 +
 target/riscv/xtheadvector_helper.c            |  38 ++++
 5 files changed, 226 insertions(+), 16 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 04bd363ac0..21916e9e3c 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -2012,3 +2012,20 @@ DEF_HELPER_6(th_vfsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(th_vfrsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(th_vfrsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(th_vfrsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_6(th_vfwadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfwadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfwsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfwsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfwadd_wv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfwadd_wv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfwsub_wv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfwsub_wv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfwadd_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfwadd_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfwsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfwsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfwadd_wf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfwadd_wf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfwsub_wf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfwsub_wf_w, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index a18c661f24..64d7a7fb76 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -1854,20 +1854,166 @@ GEN_OPFVF_TRANS_TH(th_vfadd_vf,  opfvf_check_th)
 GEN_OPFVF_TRANS_TH(th_vfsub_vf,  opfvf_check_th)
 GEN_OPFVF_TRANS_TH(th_vfrsub_vf,  opfvf_check_th)
 
+/* Vector Widening Floating-Point Add/Subtract Instructions */
+static bool opfvv_widen_check_th(DisasContext *s, arg_rmrr *a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_overlap_mask(s, a->rd, a->vm, true) &&
+            th_check_reg(s, a->rd, true) &&
+            th_check_reg(s, a->rs2, false) &&
+            th_check_reg(s, a->rs1, false) &&
+            th_check_overlap_group(a->rd, 2 << s->lmul, a->rs2,
+                                     1 << s->lmul) &&
+            th_check_overlap_group(a->rd, 2 << s->lmul, a->rs1,
+                                     1 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
+}
+
+/* OPFVV with WIDEN */
+#define GEN_OPFVV_WIDEN_TRANS_TH(NAME, CHECK)                       \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)              \
+{                                                                   \
+    if (CHECK(s, a)) {                                              \
+        uint32_t data = 0;                                          \
+        static gen_helper_gvec_4_ptr * const fns[2] = {             \
+            gen_helper_##NAME##_h, gen_helper_##NAME##_w,           \
+        };                                                          \
+        gen_set_rm(s, RISCV_FRM_DYN);                               \
+                                                                    \
+        data = FIELD_DP32(data, VDATA_TH, MLEN, s->mlen);           \
+        data = FIELD_DP32(data, VDATA_TH, VM, a->vm);               \
+        data = FIELD_DP32(data, VDATA_TH, LMUL, s->lmul);           \
+        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),      \
+                           vreg_ofs(s, a->rs1),                     \
+                           vreg_ofs(s, a->rs2), tcg_env,            \
+                           s->cfg_ptr->vlenb,                       \
+                           s->cfg_ptr->vlenb, data,                 \
+                           fns[s->sew - 1]);                        \
+        finalize_rvv_inst(s);                                       \
+        return true;                                                \
+    }                                                               \
+    return false;                                                   \
+}
+
+GEN_OPFVV_WIDEN_TRANS_TH(th_vfwadd_vv, opfvv_widen_check_th)
+GEN_OPFVV_WIDEN_TRANS_TH(th_vfwsub_vv, opfvv_widen_check_th)
+
+static bool opfvf_widen_check_th(DisasContext *s, arg_rmrr *a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_overlap_mask(s, a->rd, a->vm, true) &&
+            th_check_reg(s, a->rd, true) &&
+            th_check_reg(s, a->rs2, false) &&
+            th_check_overlap_group(a->rd, 2 << s->lmul, a->rs2,
+                                     1 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
+}
+
+/* OPFVF with WIDEN */
+#define GEN_OPFVF_WIDEN_TRANS_TH(NAME)                           \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
+{                                                                \
+    if (opfvf_widen_check_th(s, a)) {                            \
+        uint32_t data = 0;                                       \
+        static gen_helper_opfvf *const fns[2] = {                \
+            gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
+        };                                                       \
+        gen_set_rm(s, RISCV_FRM_DYN);                            \
+        data = FIELD_DP32(data, VDATA_TH, MLEN, s->mlen);        \
+        data = FIELD_DP32(data, VDATA_TH, VM, a->vm);            \
+        data = FIELD_DP32(data, VDATA_TH, LMUL, s->lmul);        \
+        return opfvf_trans(a->rd, a->rs1, a->rs2, data,          \
+                           fns[s->sew - 1], s);                  \
+    }                                                            \
+    return false;                                                \
+}
+
+GEN_OPFVF_WIDEN_TRANS_TH(th_vfwadd_vf)
+GEN_OPFVF_WIDEN_TRANS_TH(th_vfwsub_vf)
+
+static bool opfwv_widen_check_th(DisasContext *s, arg_rmrr *a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_overlap_mask(s, a->rd, a->vm, true) &&
+            th_check_reg(s, a->rd, true) &&
+            th_check_reg(s, a->rs2, true) &&
+            th_check_reg(s, a->rs1, false) &&
+            th_check_overlap_group(a->rd, 2 << s->lmul, a->rs1,
+                                     1 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
+}
+
+/* WIDEN OPFVV with WIDEN */
+#define GEN_OPFWV_WIDEN_TRANS_TH(NAME)                             \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
+{                                                                  \
+    if (opfwv_widen_check_th(s, a)) {                              \
+        uint32_t data = 0;                                         \
+        static gen_helper_gvec_4_ptr * const fns[2] = {            \
+            gen_helper_##NAME##_h, gen_helper_##NAME##_w,          \
+        };                                                         \
+        gen_set_rm(s, RISCV_FRM_DYN);                              \
+                                                                   \
+        data = FIELD_DP32(data, VDATA_TH, MLEN, s->mlen);          \
+        data = FIELD_DP32(data, VDATA_TH, VM, a->vm);              \
+        data = FIELD_DP32(data, VDATA_TH, LMUL, s->lmul);          \
+        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd),                     \
+                           vreg_ofs(s, 0),                         \
+                           vreg_ofs(s, a->rs1),                    \
+                           vreg_ofs(s, a->rs2), tcg_env,           \
+                           s->cfg_ptr->vlenb,                      \
+                           s->cfg_ptr->vlenb, data,                \
+                           fns[s->sew - 1]);                       \
+        finalize_rvv_inst(s);                                      \
+        return true;                                               \
+    }                                                              \
+    return false;                                                  \
+}
+
+GEN_OPFWV_WIDEN_TRANS_TH(th_vfwadd_wv)
+GEN_OPFWV_WIDEN_TRANS_TH(th_vfwsub_wv)
+
+static bool opfwf_widen_check_th(DisasContext *s, arg_rmrr *a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_overlap_mask(s, a->rd, a->vm, true) &&
+            th_check_reg(s, a->rd, true) &&
+            th_check_reg(s, a->rs2, true) &&
+            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
+}
+
+/* WIDEN OPFVF with WIDEN */
+#define GEN_OPFWF_WIDEN_TRANS_TH(NAME)                           \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
+{                                                                \
+    if (opfwf_widen_check_th(s, a)) {                            \
+        uint32_t data = 0;                                       \
+        static gen_helper_opfvf *const fns[2] = {                \
+            gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
+        };                                                       \
+        gen_set_rm(s, RISCV_FRM_DYN);                            \
+        data = FIELD_DP32(data, VDATA_TH, MLEN, s->mlen);        \
+        data = FIELD_DP32(data, VDATA_TH, VM, a->vm);            \
+        data = FIELD_DP32(data, VDATA_TH, LMUL, s->lmul);        \
+        return opfvf_trans(a->rd, a->rs1, a->rs2, data,          \
+                           fns[s->sew - 1], s);                  \
+    }                                                            \
+    return false;                                                \
+}
+
+GEN_OPFWF_WIDEN_TRANS_TH(th_vfwadd_wf)
+GEN_OPFWF_WIDEN_TRANS_TH(th_vfwsub_wf)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vfwadd_vv)
-TH_TRANS_STUB(th_vfwadd_vf)
-TH_TRANS_STUB(th_vfwadd_wv)
-TH_TRANS_STUB(th_vfwadd_wf)
-TH_TRANS_STUB(th_vfwsub_vv)
-TH_TRANS_STUB(th_vfwsub_vf)
-TH_TRANS_STUB(th_vfwsub_wv)
-TH_TRANS_STUB(th_vfwsub_wf)
 TH_TRANS_STUB(th_vfmul_vv)
 TH_TRANS_STUB(th_vfmul_vf)
 TH_TRANS_STUB(th_vfdiv_vv)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 3784096da2..6d0358876a 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -2927,13 +2927,13 @@ GEN_VEXT_VF(vfrsub_vf_w, 4)
 GEN_VEXT_VF(vfrsub_vf_d, 8)
 
 /* Vector Widening Floating-Point Add/Subtract Instructions */
-static uint32_t vfwadd16(uint16_t a, uint16_t b, float_status *s)
+uint32_t vfwadd16(uint16_t a, uint16_t b, float_status *s)
 {
     return float32_add(float16_to_float32(a, true, s),
                        float16_to_float32(b, true, s), s);
 }
 
-static uint64_t vfwadd32(uint32_t a, uint32_t b, float_status *s)
+uint64_t vfwadd32(uint32_t a, uint32_t b, float_status *s)
 {
     return float64_add(float32_to_float64(a, s),
                        float32_to_float64(b, s), s);
@@ -2949,13 +2949,13 @@ RVVCALL(OPFVF2, vfwadd_vf_w, WOP_UUU_W, H8, H4, vfwadd32)
 GEN_VEXT_VF(vfwadd_vf_h, 4)
 GEN_VEXT_VF(vfwadd_vf_w, 8)
 
-static uint32_t vfwsub16(uint16_t a, uint16_t b, float_status *s)
+uint32_t vfwsub16(uint16_t a, uint16_t b, float_status *s)
 {
     return float32_sub(float16_to_float32(a, true, s),
                        float16_to_float32(b, true, s), s);
 }
 
-static uint64_t vfwsub32(uint32_t a, uint32_t b, float_status *s)
+uint64_t vfwsub32(uint32_t a, uint32_t b, float_status *s)
 {
     return float64_sub(float32_to_float64(a, s),
                        float32_to_float64(b, s), s);
@@ -2971,12 +2971,12 @@ RVVCALL(OPFVF2, vfwsub_vf_w, WOP_UUU_W, H8, H4, vfwsub32)
 GEN_VEXT_VF(vfwsub_vf_h, 4)
 GEN_VEXT_VF(vfwsub_vf_w, 8)
 
-static uint32_t vfwaddw16(uint32_t a, uint16_t b, float_status *s)
+uint32_t vfwaddw16(uint32_t a, uint16_t b, float_status *s)
 {
     return float32_add(a, float16_to_float32(b, true, s), s);
 }
 
-static uint64_t vfwaddw32(uint64_t a, uint32_t b, float_status *s)
+uint64_t vfwaddw32(uint64_t a, uint32_t b, float_status *s)
 {
     return float64_add(a, float32_to_float64(b, s), s);
 }
@@ -2990,12 +2990,12 @@ RVVCALL(OPFVF2, vfwadd_wf_w, WOP_WUUU_W, H8, H4, vfwaddw32)
 GEN_VEXT_VF(vfwadd_wf_h, 4)
 GEN_VEXT_VF(vfwadd_wf_w, 8)
 
-static uint32_t vfwsubw16(uint32_t a, uint16_t b, float_status *s)
+uint32_t vfwsubw16(uint32_t a, uint16_t b, float_status *s)
 {
     return float32_sub(a, float16_to_float32(b, true, s), s);
 }
 
-static uint64_t vfwsubw32(uint64_t a, uint32_t b, float_status *s)
+uint64_t vfwsubw32(uint64_t a, uint32_t b, float_status *s)
 {
     return float64_sub(a, float32_to_float64(b, s), s);
 }
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index 5f250ab7ba..0786f5a4e1 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -344,4 +344,13 @@ uint16_t float16_rsub(uint16_t a, uint16_t b, float_status *s);
 uint32_t float32_rsub(uint32_t a, uint32_t b, float_status *s);
 uint64_t float64_rsub(uint64_t a, uint64_t b, float_status *s);
 
+uint32_t vfwadd16(uint16_t a, uint16_t b, float_status *s);
+uint64_t vfwadd32(uint32_t a, uint32_t b, float_status *s);
+uint32_t vfwsub16(uint16_t a, uint16_t b, float_status *s);
+uint64_t vfwsub32(uint32_t a, uint32_t b, float_status *s);
+uint32_t vfwaddw16(uint32_t a, uint16_t b, float_status *s);
+uint64_t vfwaddw32(uint64_t a, uint32_t b, float_status *s);
+uint32_t vfwsubw16(uint32_t a, uint16_t b, float_status *s);
+uint64_t vfwsubw32(uint64_t a, uint32_t b, float_status *s);
+
 #endif /* TARGET_RISCV_VECTOR_INTERNALS_H */
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 60811ca813..cab489a4ae 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -2696,3 +2696,41 @@ THCALL(TH_OPFVF2, th_vfrsub_vf_d, OP_UUU_D, H8, H8, float64_rsub)
 GEN_TH_VF(th_vfrsub_vf_h, 2, 2, clearh_th)
 GEN_TH_VF(th_vfrsub_vf_w, 4, 4, clearl_th)
 GEN_TH_VF(th_vfrsub_vf_d, 8, 8, clearq_th)
+
+/* Vector Widening Floating-Point Add/Subtract Instructions */
+
+THCALL(TH_OPFVV2, th_vfwadd_vv_h, WOP_UUU_H, H4, H2, H2, vfwadd16)
+THCALL(TH_OPFVV2, th_vfwadd_vv_w, WOP_UUU_W, H8, H4, H4, vfwadd32)
+GEN_TH_VV_ENV(th_vfwadd_vv_h, 2, 4, clearl_th)
+GEN_TH_VV_ENV(th_vfwadd_vv_w, 4, 8, clearq_th)
+THCALL(TH_OPFVF2, th_vfwadd_vf_h, WOP_UUU_H, H4, H2, vfwadd16)
+THCALL(TH_OPFVF2, th_vfwadd_vf_w, WOP_UUU_W, H8, H4, vfwadd32)
+GEN_TH_VF(th_vfwadd_vf_h, 2, 4, clearl_th)
+GEN_TH_VF(th_vfwadd_vf_w, 4, 8, clearq_th)
+
+THCALL(TH_OPFVV2, th_vfwsub_vv_h, WOP_UUU_H, H4, H2, H2, vfwsub16)
+THCALL(TH_OPFVV2, th_vfwsub_vv_w, WOP_UUU_W, H8, H4, H4, vfwsub32)
+GEN_TH_VV_ENV(th_vfwsub_vv_h, 2, 4, clearl_th)
+GEN_TH_VV_ENV(th_vfwsub_vv_w, 4, 8, clearq_th)
+THCALL(TH_OPFVF2, th_vfwsub_vf_h, WOP_UUU_H, H4, H2, vfwsub16)
+THCALL(TH_OPFVF2, th_vfwsub_vf_w, WOP_UUU_W, H8, H4, vfwsub32)
+GEN_TH_VF(th_vfwsub_vf_h, 2, 4, clearl_th)
+GEN_TH_VF(th_vfwsub_vf_w, 4, 8, clearq_th)
+
+THCALL(TH_OPFVV2, th_vfwadd_wv_h, WOP_WUUU_H, H4, H2, H2, vfwaddw16)
+THCALL(TH_OPFVV2, th_vfwadd_wv_w, WOP_WUUU_W, H8, H4, H4, vfwaddw32)
+GEN_TH_VV_ENV(th_vfwadd_wv_h, 2, 4, clearl_th)
+GEN_TH_VV_ENV(th_vfwadd_wv_w, 4, 8, clearq_th)
+THCALL(TH_OPFVF2, th_vfwadd_wf_h, WOP_WUUU_H, H4, H2, vfwaddw16)
+THCALL(TH_OPFVF2, th_vfwadd_wf_w, WOP_WUUU_W, H8, H4, vfwaddw32)
+GEN_TH_VF(th_vfwadd_wf_h, 2, 4, clearl_th)
+GEN_TH_VF(th_vfwadd_wf_w, 4, 8, clearq_th)
+
+THCALL(TH_OPFVV2, th_vfwsub_wv_h, WOP_WUUU_H, H4, H2, H2, vfwsubw16)
+THCALL(TH_OPFVV2, th_vfwsub_wv_w, WOP_WUUU_W, H8, H4, H4, vfwsubw32)
+GEN_TH_VV_ENV(th_vfwsub_wv_h, 2, 4, clearl_th)
+GEN_TH_VV_ENV(th_vfwsub_wv_w, 4, 8, clearq_th)
+THCALL(TH_OPFVF2, th_vfwsub_wf_h, WOP_WUUU_H, H4, H2, vfwsubw16)
+THCALL(TH_OPFVF2, th_vfwsub_wf_w, WOP_WUUU_W, H8, H4, vfwsubw32)
+GEN_TH_VF(th_vfwsub_wf_h, 2, 4, clearl_th)
+GEN_TH_VF(th_vfwsub_wf_w, 4, 8, clearq_th)
-- 
2.44.0


