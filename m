Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4138FC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 09:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDK6-0005Qv-Hz; Fri, 12 Apr 2024 05:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDK2-0005Ob-8n; Fri, 12 Apr 2024 05:35:50 -0400
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDJz-0005AP-5I; Fri, 12 Apr 2024 05:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712914540; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=wV3RFD3fpfbJlIBfRcdxx9Z+2PDzu0q2P7HqEp2U/PI=;
 b=xkEV1eX+krrI+SYnlULYr1sQbz42gf8p0qaRuDEYzrX6Bc4WVojTLouq4K0HsNsLDuECgTqUyDSxcElSkcHoiCQSxLtIVfhabiHjH429YBIAGQHEyb32GdjhncpVr0/ASnymIQgZupQcj+/CfJyuCTZ1zHadIbLzJ0ikLH/J7eU=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NoyXp_1712914538; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NoyXp_1712914538) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 17:35:39 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 50/65] target/riscv: Add single-width integer reduction
 instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:37:20 +0800
Message-ID: <20240412073735.76413-51-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
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

In this patch, we add single-width integer reduction instructions to show
the way we implement XTheadVector reduction instructions.
XTheadVector single-width integer reduction instructions diff from RVV1.0
in the following points:
1. Different mask reg layout. For mask bit of element i, XTheadVector locates it
   in bit[mlen], while RVV1.0 locates it in bit[i].
2. Different tail elements process policy. XTheadVector clear the tail elements.
   While RVV1.0 has vta to set the processing policy, keeping value or overwrite
   it with 1s.
3. Different check policy. XTheadVector does not have fractional lmul, so we can
   use simpler check function.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         | 33 ++++++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 27 +++++--
 target/riscv/xtheadvector_helper.c            | 76 +++++++++++++++++++
 3 files changed, 128 insertions(+), 8 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index c666a5a020..84d2921945 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -2236,3 +2236,36 @@ DEF_HELPER_5(th_vfncvt_f_x_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(th_vfncvt_f_x_v_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(th_vfncvt_f_f_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(th_vfncvt_f_f_v_w, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_6(th_vredsum_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredsum_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredsum_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredsum_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredmaxu_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredmaxu_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredmaxu_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredmaxu_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredmax_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredmax_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredmax_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredmax_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredminu_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredminu_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredminu_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredminu_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredmin_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredmin_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredmin_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredmin_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredand_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredand_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredand_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredand_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredor_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredor_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredor_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredor_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredxor_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredxor_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredxor_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vredxor_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index d2734c007a..1fd66353ed 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -2374,20 +2374,31 @@ GEN_OPFV_NARROW_TRANS_TH(th_vfncvt_f_xu_v)
 GEN_OPFV_NARROW_TRANS_TH(th_vfncvt_f_x_v)
 GEN_OPFV_NARROW_TRANS_TH(th_vfncvt_f_f_v)
 
+/*
+ * Vector Reduction Operations
+ */
+
+/* Vector Single-Width Integer Reduction Instructions */
+static bool reduction_check_th(DisasContext *s, arg_rmrr *a)
+{
+    return vext_check_isa_ill(s) && th_check_reg(s, a->rs2, false);
+}
+
+GEN_OPIVV_TRANS_TH(th_vredsum_vs, reduction_check_th)
+GEN_OPIVV_TRANS_TH(th_vredmaxu_vs, reduction_check_th)
+GEN_OPIVV_TRANS_TH(th_vredmax_vs, reduction_check_th)
+GEN_OPIVV_TRANS_TH(th_vredminu_vs, reduction_check_th)
+GEN_OPIVV_TRANS_TH(th_vredmin_vs, reduction_check_th)
+GEN_OPIVV_TRANS_TH(th_vredand_vs, reduction_check_th)
+GEN_OPIVV_TRANS_TH(th_vredor_vs, reduction_check_th)
+GEN_OPIVV_TRANS_TH(th_vredxor_vs, reduction_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vredsum_vs)
-TH_TRANS_STUB(th_vredand_vs)
-TH_TRANS_STUB(th_vredor_vs)
-TH_TRANS_STUB(th_vredxor_vs)
-TH_TRANS_STUB(th_vredminu_vs)
-TH_TRANS_STUB(th_vredmin_vs)
-TH_TRANS_STUB(th_vredmaxu_vs)
-TH_TRANS_STUB(th_vredmax_vs)
 TH_TRANS_STUB(th_vwredsumu_vs)
 TH_TRANS_STUB(th_vwredsum_vs)
 TH_TRANS_STUB(th_vfredsum_vs)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 3a7512ecd8..d041a81150 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -3323,3 +3323,79 @@ THCALL(TH_OPFVV1, th_vfncvt_f_f_v_h, NOP_UU_H, H2, H4, vfncvtffv16)
 THCALL(TH_OPFVV1, th_vfncvt_f_f_v_w, NOP_UU_W, H4, H8, float64_to_float32)
 GEN_TH_V_ENV(th_vfncvt_f_f_v_h, 2, 2, clearh_th)
 GEN_TH_V_ENV(th_vfncvt_f_f_v_w, 4, 4, clearl_th)
+
+/*
+ * Vector Reduction Operations
+ */
+
+/* Vector Single-Width Integer Reduction Instructions */
+#define GEN_TH_RED(NAME, TD, TS2, HD, HS2, OP, CLEAR_FN)  \
+void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
+        void *vs2, CPURISCVState *env, uint32_t desc)     \
+{                                                         \
+    uint32_t mlen = th_mlen(desc);                        \
+    uint32_t vm = th_vm(desc);                            \
+    uint32_t vl = env->vl;                                \
+    uint32_t i;                                           \
+    uint32_t tot = env_archcpu(env)->cfg.vlenb;           \
+    TD s1 =  *((TD *)vs1 + HD(0));                        \
+                                                          \
+    for (i = env->vstart; i < vl; i++) {                  \
+        TS2 s2 = *((TS2 *)vs2 + HS2(i));                  \
+        if (!vm && !th_elem_mask(v0, mlen, i)) {          \
+            continue;                                     \
+        }                                                 \
+        s1 = OP(s1, (TD)s2);                              \
+    }                                                     \
+    *((TD *)vd + HD(0)) = s1;                             \
+    env->vstart = 0;                                      \
+    CLEAR_FN(vd, 1, sizeof(TD), tot);                     \
+}
+
+/* vd[0] = sum(vs1[0], vs2[*]) */
+GEN_TH_RED(th_vredsum_vs_b, int8_t, int8_t, H1, H1, TH_ADD, clearb_th)
+GEN_TH_RED(th_vredsum_vs_h, int16_t, int16_t, H2, H2, TH_ADD, clearh_th)
+GEN_TH_RED(th_vredsum_vs_w, int32_t, int32_t, H4, H4, TH_ADD, clearl_th)
+GEN_TH_RED(th_vredsum_vs_d, int64_t, int64_t, H8, H8, TH_ADD, clearq_th)
+
+/* vd[0] = maxu(vs1[0], vs2[*]) */
+GEN_TH_RED(th_vredmaxu_vs_b, uint8_t, uint8_t, H1, H1, TH_MAX, clearb_th)
+GEN_TH_RED(th_vredmaxu_vs_h, uint16_t, uint16_t, H2, H2, TH_MAX, clearh_th)
+GEN_TH_RED(th_vredmaxu_vs_w, uint32_t, uint32_t, H4, H4, TH_MAX, clearl_th)
+GEN_TH_RED(th_vredmaxu_vs_d, uint64_t, uint64_t, H8, H8, TH_MAX, clearq_th)
+
+/* vd[0] = max(vs1[0], vs2[*]) */
+GEN_TH_RED(th_vredmax_vs_b, int8_t, int8_t, H1, H1, TH_MAX, clearb_th)
+GEN_TH_RED(th_vredmax_vs_h, int16_t, int16_t, H2, H2, TH_MAX, clearh_th)
+GEN_TH_RED(th_vredmax_vs_w, int32_t, int32_t, H4, H4, TH_MAX, clearl_th)
+GEN_TH_RED(th_vredmax_vs_d, int64_t, int64_t, H8, H8, TH_MAX, clearq_th)
+
+/* vd[0] = minu(vs1[0], vs2[*]) */
+GEN_TH_RED(th_vredminu_vs_b, uint8_t, uint8_t, H1, H1, TH_MIN, clearb_th)
+GEN_TH_RED(th_vredminu_vs_h, uint16_t, uint16_t, H2, H2, TH_MIN, clearh_th)
+GEN_TH_RED(th_vredminu_vs_w, uint32_t, uint32_t, H4, H4, TH_MIN, clearl_th)
+GEN_TH_RED(th_vredminu_vs_d, uint64_t, uint64_t, H8, H8, TH_MIN, clearq_th)
+
+/* vd[0] = min(vs1[0], vs2[*]) */
+GEN_TH_RED(th_vredmin_vs_b, int8_t, int8_t, H1, H1, TH_MIN, clearb_th)
+GEN_TH_RED(th_vredmin_vs_h, int16_t, int16_t, H2, H2, TH_MIN, clearh_th)
+GEN_TH_RED(th_vredmin_vs_w, int32_t, int32_t, H4, H4, TH_MIN, clearl_th)
+GEN_TH_RED(th_vredmin_vs_d, int64_t, int64_t, H8, H8, TH_MIN, clearq_th)
+
+/* vd[0] = and(vs1[0], vs2[*]) */
+GEN_TH_RED(th_vredand_vs_b, int8_t, int8_t, H1, H1, TH_AND, clearb_th)
+GEN_TH_RED(th_vredand_vs_h, int16_t, int16_t, H2, H2, TH_AND, clearh_th)
+GEN_TH_RED(th_vredand_vs_w, int32_t, int32_t, H4, H4, TH_AND, clearl_th)
+GEN_TH_RED(th_vredand_vs_d, int64_t, int64_t, H8, H8, TH_AND, clearq_th)
+
+/* vd[0] = or(vs1[0], vs2[*]) */
+GEN_TH_RED(th_vredor_vs_b, int8_t, int8_t, H1, H1, TH_OR, clearb_th)
+GEN_TH_RED(th_vredor_vs_h, int16_t, int16_t, H2, H2, TH_OR, clearh_th)
+GEN_TH_RED(th_vredor_vs_w, int32_t, int32_t, H4, H4, TH_OR, clearl_th)
+GEN_TH_RED(th_vredor_vs_d, int64_t, int64_t, H8, H8, TH_OR, clearq_th)
+
+/* vd[0] = xor(vs1[0], vs2[*]) */
+GEN_TH_RED(th_vredxor_vs_b, int8_t, int8_t, H1, H1, TH_XOR, clearb_th)
+GEN_TH_RED(th_vredxor_vs_h, int16_t, int16_t, H2, H2, TH_XOR, clearh_th)
+GEN_TH_RED(th_vredxor_vs_w, int32_t, int32_t, H4, H4, TH_XOR, clearl_th)
+GEN_TH_RED(th_vredxor_vs_d, int64_t, int64_t, H8, H8, TH_XOR, clearq_th)
-- 
2.44.0


