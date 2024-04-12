Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E941AC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 09:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvD4M-00054l-N0; Fri, 12 Apr 2024 05:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvD4E-00053w-UV; Fri, 12 Apr 2024 05:19:31 -0400
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvD4C-0001v7-Dw; Fri, 12 Apr 2024 05:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712913562; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=0QfOz2CtMvPhZVW6CUIxYN/ynScMbPZnTChAkBiscYQ=;
 b=ofTUVBp1wMFDUbdOU7A6X9ygYIEchyCGZXOAB0X1yoO7OkQNvfD50l+Enog51ZLd6yse+AVaco4h0VVaVhpVoFpxXHHgavRrzzV4vTlEzUAF0fnvtEvoz72NieBWGgQB4JG9yWxRCXUX/ANI2aVgjHVfdzYYCw7YlE8sm5vvPto=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R641e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NsXIi_1712913560; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NsXIi_1712913560) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 17:19:21 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 42/65] target/riscv: Add floating-pointing square-root
 instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:37:12 +0800
Message-ID: <20240412073735.76413-43-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
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
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 46 ++++++++++++++++++-
 target/riscv/xtheadvector_helper.c            | 41 +++++++++++++++++
 3 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 12b5e4573a..5aa12f3719 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -2116,3 +2116,7 @@ DEF_HELPER_6(th_vfwmsac_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(th_vfwmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(th_vfwnmsac_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(th_vfwnmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_5(th_vfsqrt_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfsqrt_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfsqrt_v_d, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 7220b7d607..e709444e9f 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -2047,13 +2047,57 @@ GEN_OPFVF_WIDEN_TRANS_TH(th_vfwnmacc_vf)
 GEN_OPFVF_WIDEN_TRANS_TH(th_vfwmsac_vf)
 GEN_OPFVF_WIDEN_TRANS_TH(th_vfwnmsac_vf)
 
+/* Vector Floating-Point Square-Root Instruction */
+
+/*
+ * If the current SEW does not correspond to a supported IEEE floating-point
+ * type, an illegal instruction exception is raised
+ */
+static bool opfv_check_th(DisasContext *s, arg_rmr *a)
+{
+    return require_xtheadvector(s) &&
+           vext_check_isa_ill(s) &&
+           th_check_overlap_mask(s, a->rd, a->vm, false) &&
+           th_check_reg(s, a->rd, false) &&
+           th_check_reg(s, a->rs2, false) &&
+           (s->sew != 0);
+}
+
+#define GEN_OPFV_TRANS_TH(NAME, CHECK)                             \
+static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
+{                                                                  \
+    if (CHECK(s, a)) {                                             \
+        uint32_t data = 0;                                         \
+        static gen_helper_gvec_3_ptr * const fns[3] = {            \
+            gen_helper_##NAME##_h,                                 \
+            gen_helper_##NAME##_w,                                 \
+            gen_helper_##NAME##_d,                                 \
+        };                                                         \
+        gen_set_rm(s, RISCV_FRM_DYN);                              \
+                                                                   \
+        data = FIELD_DP32(data, VDATA_TH, MLEN, s->mlen);          \
+        data = FIELD_DP32(data, VDATA_TH, VM, a->vm);              \
+        data = FIELD_DP32(data, VDATA_TH, LMUL, s->lmul);          \
+        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd),                     \
+                           vreg_ofs(s, 0),                         \
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
+GEN_OPFV_TRANS_TH(th_vfsqrt_v, opfv_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vfsqrt_v)
 TH_TRANS_STUB(th_vfmin_vv)
 TH_TRANS_STUB(th_vfmin_vf)
 TH_TRANS_STUB(th_vfmax_vv)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index ac8e576c49..7274e7aedb 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -2942,3 +2942,44 @@ THCALL(TH_OPFVF3, th_vfwnmsac_vf_h, WOP_UUU_H, H4, H2, fwnmsac16)
 THCALL(TH_OPFVF3, th_vfwnmsac_vf_w, WOP_UUU_W, H8, H4, fwnmsac32)
 GEN_TH_VF(th_vfwnmsac_vf_h, 2, 4, clearl_th)
 GEN_TH_VF(th_vfwnmsac_vf_w, 4, 8, clearq_th)
+
+/* Vector Floating-Point Square-Root Instruction */
+
+#define TH_OPFVV1(NAME, TD, T2, TX2, HD, HS2, OP)        \
+static void do_##NAME(void *vd, void *vs2, int i,      \
+        CPURISCVState *env)                            \
+{                                                      \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                    \
+    *((TD *)vd + HD(i)) = OP(s2, &env->fp_status);     \
+}
+
+#define GEN_TH_V_ENV(NAME, ESZ, DSZ, CLEAR_FN)       \
+void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
+        CPURISCVState *env, uint32_t desc)             \
+{                                                      \
+    uint32_t vlmax = th_maxsz(desc) / ESZ;             \
+    uint32_t mlen = th_mlen(desc);                     \
+    uint32_t vm = th_vm(desc);                         \
+    uint32_t vl = env->vl;                             \
+    uint32_t i;                                        \
+                                                       \
+    VSTART_CHECK_EARLY_EXIT(env);                      \
+    if (vl == 0) {                                     \
+        return;                                        \
+    }                                                  \
+    for (i = env->vstart; i < vl; i++) {               \
+        if (!vm && !th_elem_mask(v0, mlen, i)) {       \
+            continue;                                  \
+        }                                              \
+        do_##NAME(vd, vs2, i, env);                    \
+    }                                                  \
+    env->vstart = 0;                                   \
+    CLEAR_FN(vd, vl, vl * DSZ,  vlmax * DSZ);          \
+}
+
+THCALL(TH_OPFVV1, th_vfsqrt_v_h, OP_UU_H, H2, H2, float16_sqrt)
+THCALL(TH_OPFVV1, th_vfsqrt_v_w, OP_UU_W, H4, H4, float32_sqrt)
+THCALL(TH_OPFVV1, th_vfsqrt_v_d, OP_UU_D, H8, H8, float64_sqrt)
+GEN_TH_V_ENV(th_vfsqrt_v_h, 2, 2, clearh_th)
+GEN_TH_V_ENV(th_vfsqrt_v_w, 4, 4, clearl_th)
+GEN_TH_V_ENV(th_vfsqrt_v_d, 8, 8, clearq_th)
-- 
2.44.0


