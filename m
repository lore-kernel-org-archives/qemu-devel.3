Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C810C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 09:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDbg-0006kS-4x; Fri, 12 Apr 2024 05:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDbc-0006jt-Ma; Fri, 12 Apr 2024 05:54:00 -0400
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDba-0007wA-GV; Fri, 12 Apr 2024 05:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712915633; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=hV0nePvd0MXT222s9i5ll/4ZZNClJxJPhYIvyLOz17E=;
 b=UiAuZhCF9XuDzUEIMQMVTvLGcV5B4vQ/f5WPmrZyC44CNYUTg/icFK9ruIx2sbQN9x8gQEx7UNCN0CtEW0x2+EkMoNBVboMFD3XqnlxgztPhNNfo+43hV9bFl3sWabc1FrCNpJPzaOV/tBgIybmAu0gCPscSNzbZimj3i/cedCs=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R911e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4O-Shf_1712915631; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4O-Shf_1712915631) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 17:53:52 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 59/65] target/riscv: Add vector element index instruction for
 XTheadVector
Date: Fri, 12 Apr 2024 15:37:29 +0800
Message-ID: <20240412073735.76413-60-eric.huang@linux.alibaba.com>
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

The instruction has the same function as RVV1.0. Overall there are only
general differences between XTheadVector and RVV1.0.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         |  5 ++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 27 ++++++++++++++++++-
 target/riscv/xtheadvector_helper.c            | 26 ++++++++++++++++++
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index a1c85e5254..fe264621ff 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -2311,3 +2311,8 @@ DEF_HELPER_5(th_viota_m_b, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(th_viota_m_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(th_viota_m_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(th_viota_m_d, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_4(th_vid_v_b, void, ptr, ptr, env, i32)
+DEF_HELPER_4(th_vid_v_h, void, ptr, ptr, env, i32)
+DEF_HELPER_4(th_vid_v_w, void, ptr, ptr, env, i32)
+DEF_HELPER_4(th_vid_v_d, void, ptr, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 93f4ee4a12..9a0ea606ab 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -2562,13 +2562,38 @@ static bool trans_th_viota_m(DisasContext *s, arg_th_viota_m *a)
     return false;
 }
 
+/* Vector Element Index Instruction */
+static bool trans_th_vid_v(DisasContext *s, arg_th_vid_v *a)
+{
+    if (require_xtheadvector(s) &&
+        vext_check_isa_ill(s) &&
+        th_check_reg(s, a->rd, false) &&
+        th_check_overlap_mask(s, a->rd, a->vm, false)) {
+        uint32_t data = 0;
+
+        data = FIELD_DP32(data, VDATA_TH, MLEN, s->mlen);
+        data = FIELD_DP32(data, VDATA_TH, VM, a->vm);
+        data = FIELD_DP32(data, VDATA_TH, LMUL, s->lmul);
+        static gen_helper_gvec_2_ptr * const fns[4] = {
+            gen_helper_th_vid_v_b, gen_helper_th_vid_v_h,
+            gen_helper_th_vid_v_w, gen_helper_th_vid_v_d,
+        };
+        tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
+                           tcg_env, s->cfg_ptr->vlenb,
+                           s->cfg_ptr->vlenb,
+                           data, fns[s->sew]);
+        finalize_rvv_inst(s);
+        return true;
+    }
+    return false;
+}
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vid_v)
 TH_TRANS_STUB(th_vext_x_v)
 TH_TRANS_STUB(th_vmv_s_x)
 TH_TRANS_STUB(th_vfmv_f_s)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index b0ddb3b307..0743d57b12 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -3652,3 +3652,29 @@ GEN_TH_VIOTA_M(th_viota_m_b, uint8_t, H1, clearb_th)
 GEN_TH_VIOTA_M(th_viota_m_h, uint16_t, H2, clearh_th)
 GEN_TH_VIOTA_M(th_viota_m_w, uint32_t, H4, clearl_th)
 GEN_TH_VIOTA_M(th_viota_m_d, uint64_t, H8, clearq_th)
+
+/* Vector Element Index Instruction */
+#define GEN_TH_VID_V(NAME, ETYPE, H, CLEAR_FN)                            \
+void HELPER(NAME)(void *vd, void *v0, CPURISCVState *env, uint32_t desc)  \
+{                                                                         \
+    uint32_t mlen = th_mlen(desc);                                        \
+    uint32_t vlmax = (env_archcpu(env)->cfg.vlenb << 3) / mlen;           \
+    uint32_t vm = th_vm(desc);                                            \
+    uint32_t vl = env->vl;                                                \
+    int i;                                                                \
+                                                                          \
+    VSTART_CHECK_EARLY_EXIT(env);                                         \
+    for (i = env->vstart; i < vl; i++) {                                  \
+        if (!vm && !th_elem_mask(v0, mlen, i)) {                          \
+            continue;                                                     \
+        }                                                                 \
+        *((ETYPE *)vd + H(i)) = i;                                        \
+    }                                                                     \
+    env->vstart = 0;                                                      \
+    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+}
+
+GEN_TH_VID_V(th_vid_v_b, uint8_t, H1, clearb_th)
+GEN_TH_VID_V(th_vid_v_h, uint16_t, H2, clearh_th)
+GEN_TH_VID_V(th_vid_v_w, uint32_t, H4, clearl_th)
+GEN_TH_VID_V(th_vid_v_d, uint64_t, H8, clearq_th)
-- 
2.44.0


