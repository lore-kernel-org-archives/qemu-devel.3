Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1D2C04FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 09:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDZm-0005W6-AO; Fri, 12 Apr 2024 05:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDZj-0005SA-QH; Fri, 12 Apr 2024 05:52:03 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDZg-0007jk-CJ; Fri, 12 Apr 2024 05:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712915511; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=O9JEdbM/55FFdsPIYnErCakBqaPzk+l9txOOWl3u26E=;
 b=QHSrE6e2G7xmW5yPZHmUAkR247KC3itp19M6J7Wjf1wAC2L4hKwRdI59RBCMl/dptDG+gw+9Iz2jdozpXyG6BmXhSLW2e63E0Vu+hFy9mmUzXsLmuxhhd+fGtfk6wC5+kWW76Q8XC8wSEID59lgR79Dx2xHm9z0kSU77xF1bOzw=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R311e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4O-Ryn_1712915510; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4O-Ryn_1712915510) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 17:51:50 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 58/65] target/riscv: Add vector iota instruction for
 XTheadVector
Date: Fri, 12 Apr 2024 15:37:28 +0800
Message-ID: <20240412073735.76413-59-eric.huang@linux.alibaba.com>
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

The instruction has the same function as RVV1.0. Overall there are only
general differences between XTheadVector and RVV1.0.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         |  5 ++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 29 +++++++++++++++++-
 target/riscv/xtheadvector_helper.c            | 30 +++++++++++++++++++
 3 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 90a1ff2601..a1c85e5254 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -2306,3 +2306,8 @@ DEF_HELPER_4(th_vmfirst_m, tl, ptr, ptr, env, i32)
 DEF_HELPER_5(th_vmsbf_m, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(th_vmsif_m, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(th_vmsof_m, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_5(th_viota_m_b, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_viota_m_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_viota_m_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_viota_m_d, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index d41c691c31..93f4ee4a12 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -2534,13 +2534,40 @@ GEN_M_TRANS_TH(th_vmsbf_m)
 GEN_M_TRANS_TH(th_vmsif_m)
 GEN_M_TRANS_TH(th_vmsof_m)
 
+/* Vector Iota Instruction */
+static bool trans_th_viota_m(DisasContext *s, arg_th_viota_m *a)
+{
+    if (require_xtheadvector(s) &&
+        vext_check_isa_ill(s) &&
+        th_check_reg(s, a->rd, false) &&
+        th_check_overlap_group(a->rd, 1 << s->lmul, a->rs2, 1) &&
+        (a->vm != 0 || a->rd != 0) &&
+        s->vstart_eq_zero) {
+        uint32_t data = 0;
+
+        data = FIELD_DP32(data, VDATA_TH, MLEN, s->mlen);
+        data = FIELD_DP32(data, VDATA_TH, VM, a->vm);
+        data = FIELD_DP32(data, VDATA_TH, LMUL, s->lmul);
+        static gen_helper_gvec_3_ptr * const fns[4] = {
+            gen_helper_th_viota_m_b, gen_helper_th_viota_m_h,
+            gen_helper_th_viota_m_w, gen_helper_th_viota_m_d,
+        };
+        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
+                           vreg_ofs(s, a->rs2), tcg_env,
+                           s->cfg_ptr->vlenb,
+                           s->cfg_ptr->vlenb, data, fns[s->sew]);
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
 
-TH_TRANS_STUB(th_viota_m)
 TH_TRANS_STUB(th_vid_v)
 TH_TRANS_STUB(th_vext_x_v)
 TH_TRANS_STUB(th_vmv_s_x)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index d4f1665bf3..b0ddb3b307 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -3622,3 +3622,33 @@ void HELPER(th_vmsof_m)(void *vd, void *v0, void *vs2, CPURISCVState *env,
 {
     vmsetm(vd, v0, vs2, env, desc, ONLY_FIRST);
 }
+
+/* Vector Iota Instruction */
+#define GEN_TH_VIOTA_M(NAME, ETYPE, H, CLEAR_FN)                          \
+void HELPER(NAME)(void *vd, void *v0, void *vs2, CPURISCVState *env,      \
+                  uint32_t desc)                                          \
+{                                                                         \
+    uint32_t mlen = th_mlen(desc);                                        \
+    uint32_t vlmax = (env_archcpu(env)->cfg.vlenb << 3) / mlen;           \
+    uint32_t vm = th_vm(desc);                                            \
+    uint32_t vl = env->vl;                                                \
+    uint32_t sum = 0;                                                     \
+    int i;                                                                \
+                                                                          \
+    for (i = env->vstart; i < vl; i++) {                                  \
+        if (!vm && !th_elem_mask(v0, mlen, i)) {                          \
+            continue;                                                     \
+        }                                                                 \
+        *((ETYPE *)vd + H(i)) = sum;                                      \
+        if (th_elem_mask(vs2, mlen, i)) {                                 \
+            sum++;                                                        \
+        }                                                                 \
+    }                                                                     \
+    env->vstart = 0;                                                      \
+    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+}
+
+GEN_TH_VIOTA_M(th_viota_m_b, uint8_t, H1, clearb_th)
+GEN_TH_VIOTA_M(th_viota_m_h, uint16_t, H2, clearh_th)
+GEN_TH_VIOTA_M(th_viota_m_w, uint32_t, H4, clearl_th)
+GEN_TH_VIOTA_M(th_viota_m_d, uint64_t, H8, clearq_th)
-- 
2.44.0


