Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DD9C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 10:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDhn-0001lb-JH; Fri, 12 Apr 2024 06:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDhX-0001l7-RB; Fri, 12 Apr 2024 06:00:08 -0400
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDhU-0000pj-NC; Fri, 12 Apr 2024 06:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712915998; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=xqsZ9O48LJGEVsAnRIqoz+CNI7V67QtC0dj8fIpqUF0=;
 b=sob//O4OcEs1bClfwXcZv0UoOs7X3mfQeC2oYHJfP4MO3zLzF1VHWFIzH1ry82rZz+4UYFUokJeT10hQv96y3me+CVljxbhPa6uQ8GjkIIDgzOG/B0F9l3wJ+lq/0D/2/XRqVIkTFT/ikWJWnOA89smmO8jlDVbzvBd48apfSSw=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R541e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4Nu6N3_1712915996; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4Nu6N3_1712915996) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 17:59:57 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 62/65] target/riscv: Add vector slide instructions for
 XTheadVector
Date: Fri, 12 Apr 2024 15:37:32 +0800
Message-ID: <20240412073735.76413-63-eric.huang@linux.alibaba.com>
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
 target/riscv/helper.h                         |  17 +++
 .../riscv/insn_trans/trans_xtheadvector.c.inc |  25 +++-
 target/riscv/xtheadvector_helper.c            | 123 ++++++++++++++++++
 3 files changed, 159 insertions(+), 6 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index fe264621ff..6ce0bcbba7 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -2316,3 +2316,20 @@ DEF_HELPER_4(th_vid_v_b, void, ptr, ptr, env, i32)
 DEF_HELPER_4(th_vid_v_h, void, ptr, ptr, env, i32)
 DEF_HELPER_4(th_vid_v_w, void, ptr, ptr, env, i32)
 DEF_HELPER_4(th_vid_v_d, void, ptr, ptr, env, i32)
+
+DEF_HELPER_6(th_vslideup_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vslideup_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vslideup_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vslideup_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vslidedown_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vslidedown_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vslidedown_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vslidedown_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vslide1up_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vslide1up_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vslide1up_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vslide1up_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vslide1down_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vslide1down_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vslide1down_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vslide1down_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 54ccd933c0..46cfc51690 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -2797,18 +2797,31 @@ static bool trans_th_vfmv_s_f(DisasContext *s, arg_th_vfmv_s_f *a)
     return false;
 }
 
+/* Vector Slide Instructions */
+static bool slideup_check_th(DisasContext *s, arg_rmrr *a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_overlap_mask(s, a->rd, a->vm, true) &&
+            th_check_reg(s, a->rd, false) &&
+            th_check_reg(s, a->rs2, false) &&
+            (a->rd != a->rs2));
+}
+
+GEN_OPIVX_TRANS_TH(th_vslideup_vx, slideup_check_th)
+GEN_OPIVX_TRANS_TH(th_vslide1up_vx, slideup_check_th)
+GEN_OPIVI_TRANS_TH(th_vslideup_vi, IMM_ZX, th_vslideup_vx, slideup_check_th)
+
+GEN_OPIVX_TRANS_TH(th_vslidedown_vx, opivx_check_th)
+GEN_OPIVX_TRANS_TH(th_vslide1down_vx, opivx_check_th)
+GEN_OPIVI_TRANS_TH(th_vslidedown_vi, IMM_ZX, th_vslidedown_vx, opivx_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vslideup_vx)
-TH_TRANS_STUB(th_vslideup_vi)
-TH_TRANS_STUB(th_vslide1up_vx)
-TH_TRANS_STUB(th_vslidedown_vx)
-TH_TRANS_STUB(th_vslidedown_vi)
-TH_TRANS_STUB(th_vslide1down_vx)
 TH_TRANS_STUB(th_vrgather_vv)
 TH_TRANS_STUB(th_vrgather_vx)
 TH_TRANS_STUB(th_vrgather_vi)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 0743d57b12..73a15eb070 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -3678,3 +3678,126 @@ GEN_TH_VID_V(th_vid_v_b, uint8_t, H1, clearb_th)
 GEN_TH_VID_V(th_vid_v_h, uint16_t, H2, clearh_th)
 GEN_TH_VID_V(th_vid_v_w, uint32_t, H4, clearl_th)
 GEN_TH_VID_V(th_vid_v_d, uint64_t, H8, clearq_th)
+
+/*
+ * Vector Permutation Instructions
+ */
+
+/* Vector Slide Instructions */
+#define GEN_TH_VSLIDEUP_VX(NAME, ETYPE, H, CLEAR_FN)                      \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
+                  CPURISCVState *env, uint32_t desc)                      \
+{                                                                         \
+    uint32_t mlen = th_mlen(desc);                                        \
+    uint32_t vlmax = (env_archcpu(env)->cfg.vlenb << 3) / mlen;           \
+    uint32_t vm = th_vm(desc);                                            \
+    uint32_t vl = env->vl;                                                \
+    target_ulong offset = s1, i_min, i;                                   \
+                                                                          \
+    VSTART_CHECK_EARLY_EXIT(env);                                         \
+    i_min = MAX(env->vstart, offset);                                     \
+    for (i = i_min; i < vl; i++) {                                        \
+        if (!vm && !th_elem_mask(v0, mlen, i)) {                          \
+            continue;                                                     \
+        }                                                                 \
+        *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));          \
+    }                                                                     \
+    env->vstart = 0;                                                      \
+    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+}
+
+/* vslideup.vx vd, vs2, rs1, vm # vd[i+rs1] = vs2[i] */
+GEN_TH_VSLIDEUP_VX(th_vslideup_vx_b, uint8_t, H1, clearb_th)
+GEN_TH_VSLIDEUP_VX(th_vslideup_vx_h, uint16_t, H2, clearh_th)
+GEN_TH_VSLIDEUP_VX(th_vslideup_vx_w, uint32_t, H4, clearl_th)
+GEN_TH_VSLIDEUP_VX(th_vslideup_vx_d, uint64_t, H8, clearq_th)
+
+#define GEN_TH_VSLIDEDOWN_VX(NAME, ETYPE, H, CLEAR_FN)                    \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
+                  CPURISCVState *env, uint32_t desc)                      \
+{                                                                         \
+    uint32_t mlen = th_mlen(desc);                                        \
+    uint32_t vlmax = (env_archcpu(env)->cfg.vlenb << 3) / mlen;           \
+    uint32_t vm = th_vm(desc);                                            \
+    uint32_t vl = env->vl;                                                \
+    target_ulong offset = s1, i;                                          \
+                                                                          \
+    VSTART_CHECK_EARLY_EXIT(env);                                         \
+    for (i = env->vstart; i < vl; ++i) {                                  \
+        target_ulong j = i + offset;                                      \
+        if (!vm && !th_elem_mask(v0, mlen, i)) {                          \
+            continue;                                                     \
+        }                                                                 \
+        *((ETYPE *)vd + H(i)) = j >= vlmax ? 0 : *((ETYPE *)vs2 + H(j));  \
+    }                                                                     \
+    env->vstart = 0;                                                      \
+    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+}
+
+/* vslidedown.vx vd, vs2, rs1, vm # vd[i] = vs2[i+rs1] */
+GEN_TH_VSLIDEDOWN_VX(th_vslidedown_vx_b, uint8_t, H1, clearb_th)
+GEN_TH_VSLIDEDOWN_VX(th_vslidedown_vx_h, uint16_t, H2, clearh_th)
+GEN_TH_VSLIDEDOWN_VX(th_vslidedown_vx_w, uint32_t, H4, clearl_th)
+GEN_TH_VSLIDEDOWN_VX(th_vslidedown_vx_d, uint64_t, H8, clearq_th)
+
+#define GEN_TH_VSLIDE1UP_VX(NAME, ETYPE, H, CLEAR_FN)                     \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
+                  CPURISCVState *env, uint32_t desc)                      \
+{                                                                         \
+    uint32_t mlen = th_mlen(desc);                                        \
+    uint32_t vlmax = (env_archcpu(env)->cfg.vlenb << 3) / mlen;           \
+    uint32_t vm = th_vm(desc);                                            \
+    uint32_t vl = env->vl;                                                \
+    uint32_t i;                                                           \
+                                                                          \
+    VSTART_CHECK_EARLY_EXIT(env);                                         \
+    for (i = env->vstart; i < vl; i++) {                                  \
+        if (!vm && !th_elem_mask(v0, mlen, i)) {                          \
+            continue;                                                     \
+        }                                                                 \
+        if (i == 0) {                                                     \
+            *((ETYPE *)vd + H(i)) = s1;                                   \
+        } else {                                                          \
+            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - 1));           \
+        }                                                                 \
+    }                                                                     \
+    env->vstart = 0;                                                      \
+    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+}
+
+/* vslide1up.vx vd, vs2, rs1, vm # vd[0]=x[rs1], vd[i+1] = vs2[i] */
+GEN_TH_VSLIDE1UP_VX(th_vslide1up_vx_b, uint8_t, H1, clearb_th)
+GEN_TH_VSLIDE1UP_VX(th_vslide1up_vx_h, uint16_t, H2, clearh_th)
+GEN_TH_VSLIDE1UP_VX(th_vslide1up_vx_w, uint32_t, H4, clearl_th)
+GEN_TH_VSLIDE1UP_VX(th_vslide1up_vx_d, uint64_t, H8, clearq_th)
+
+#define GEN_TH_VSLIDE1DOWN_VX(NAME, ETYPE, H, CLEAR_FN)                   \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
+                  CPURISCVState *env, uint32_t desc)                      \
+{                                                                         \
+    uint32_t mlen = th_mlen(desc);                                        \
+    uint32_t vlmax = (env_archcpu(env)->cfg.vlenb << 3) / mlen;           \
+    uint32_t vm = th_vm(desc);                                            \
+    uint32_t vl = env->vl;                                                \
+    uint32_t i;                                                           \
+                                                                          \
+    VSTART_CHECK_EARLY_EXIT(env);                                         \
+    for (i = env->vstart; i < vl; i++) {                                  \
+        if (!vm && !th_elem_mask(v0, mlen, i)) {                          \
+            continue;                                                     \
+        }                                                                 \
+        if (i == vl - 1) {                                                \
+            *((ETYPE *)vd + H(i)) = s1;                                   \
+        } else {                                                          \
+            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i + 1));           \
+        }                                                                 \
+    }                                                                     \
+    env->vstart = 0;                                                      \
+    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+}
+
+/* vslide1down.vx vd, vs2, rs1, vm # vd[i] = vs2[i+1], vd[vl-1]=x[rs1] */
+GEN_TH_VSLIDE1DOWN_VX(th_vslide1down_vx_b, uint8_t, H1, clearb_th)
+GEN_TH_VSLIDE1DOWN_VX(th_vslide1down_vx_h, uint16_t, H2, clearh_th)
+GEN_TH_VSLIDE1DOWN_VX(th_vslide1down_vx_w, uint32_t, H4, clearl_th)
+GEN_TH_VSLIDE1DOWN_VX(th_vslide1down_vx_d, uint64_t, H8, clearq_th)
-- 
2.44.0


