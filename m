Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD065C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 10:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDlb-0005CJ-HB; Fri, 12 Apr 2024 06:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDlY-0005BE-EJ; Fri, 12 Apr 2024 06:04:17 -0400
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDlT-0001Xq-7H; Fri, 12 Apr 2024 06:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712916241; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=GhcV0+pMQbzlkWNZvNgh0j5WFf6ey4/Uuhz0/c1jvMk=;
 b=kRAufgWd2JYRCNtsGgXsoM38zml8DN0xIFhDUrPmky8U/Zpnbefu4Z0jPyA5gzbu/XGzICaoG30elkWHQfwbWBheWN0Iji7RCpQpYTkps6wgzxaruU8ikJD+sVCLXNqTqDdAjpk+xk/R1KfvqizuZOZXqsXCFgzYiS9NRQFbb1E=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4O-WLF_1712916239; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4O-WLF_1712916239) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 18:04:00 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 64/65] target/riscv: Add vector compress instruction for
 XTheadVector
Date: Fri, 12 Apr 2024 15:37:34 +0800
Message-ID: <20240412073735.76413-65-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.113;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-113.freemail.mail.aliyun.com
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
 target/riscv/helper.h                         |  5 +++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 36 ++++++++++++++++---
 target/riscv/xtheadvector_helper.c            | 27 ++++++++++++++
 3 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index b650e299cf..b46f9fc2c3 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -2342,3 +2342,8 @@ DEF_HELPER_6(th_vrgather_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vrgather_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vrgather_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vrgather_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(th_vcompress_vm_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vcompress_vm_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vcompress_vm_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vcompress_vm_d, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index f6da1ff384..65b595d699 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -2898,10 +2898,36 @@ static bool trans_th_vrgather_vi(DisasContext *s, arg_rmrr *a)
     return true;
 }
 
-#define TH_TRANS_STUB(NAME)                                \
-static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
-{                                                          \
-    return require_xtheadvector(s);                        \
+/* Vector Compress Instruction */
+static bool vcompress_vm_check_th(DisasContext *s, arg_r *a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_reg(s, a->rd, false) &&
+            th_check_reg(s, a->rs2, false) &&
+            th_check_overlap_group(a->rd, 1 << s->lmul, a->rs1, 1) &&
+            (a->rd != a->rs2)) &&
+            s->vstart_eq_zero;
 }
 
-TH_TRANS_STUB(th_vcompress_vm)
+static bool trans_th_vcompress_vm(DisasContext *s, arg_r *a)
+{
+    if (vcompress_vm_check_th(s, a)) {
+        uint32_t data = 0;
+        static gen_helper_gvec_4_ptr * const fns[4] = {
+            gen_helper_th_vcompress_vm_b, gen_helper_th_vcompress_vm_h,
+            gen_helper_th_vcompress_vm_w, gen_helper_th_vcompress_vm_d,
+        };
+
+        data = FIELD_DP32(data, VDATA_TH, MLEN, s->mlen);
+        data = FIELD_DP32(data, VDATA_TH, LMUL, s->lmul);
+        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
+                           vreg_ofs(s, a->rs1), vreg_ofs(s, a->rs2),
+                           tcg_env, s->cfg_ptr->vlenb,
+                           s->cfg_ptr->vlenb, data,
+                           fns[s->sew]);
+        finalize_rvv_inst(s);
+        return true;
+    }
+    return false;
+}
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 2598824bb3..656f83f408 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -3865,3 +3865,30 @@ GEN_TH_VRGATHER_VX(th_vrgather_vx_b, uint8_t, H1, clearb_th)
 GEN_TH_VRGATHER_VX(th_vrgather_vx_h, uint16_t, H2, clearh_th)
 GEN_TH_VRGATHER_VX(th_vrgather_vx_w, uint32_t, H4, clearl_th)
 GEN_TH_VRGATHER_VX(th_vrgather_vx_d, uint64_t, H8, clearq_th)
+
+/* Vector Compress Instruction */
+#define GEN_TH_VCOMPRESS_VM(NAME, ETYPE, H, CLEAR_FN)                     \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
+                  CPURISCVState *env, uint32_t desc)                      \
+{                                                                         \
+    uint32_t mlen = th_mlen(desc);                                        \
+    uint32_t vlmax = (env_archcpu(env)->cfg.vlenb << 3) / mlen;           \
+    uint32_t vl = env->vl;                                                \
+    uint32_t num = 0, i;                                                  \
+                                                                          \
+    for (i = env->vstart; i < vl; i++) {                                  \
+        if (!th_elem_mask(vs1, mlen, i)) {                                \
+            continue;                                                     \
+        }                                                                 \
+        *((ETYPE *)vd + H(num)) = *((ETYPE *)vs2 + H(i));                 \
+        num++;                                                            \
+    }                                                                     \
+    env->vstart = 0;                                                      \
+    CLEAR_FN(vd, num, num * sizeof(ETYPE), vlmax * sizeof(ETYPE));        \
+}
+
+/* Compress into vd elements of vs2 where vs1 is enabled */
+GEN_TH_VCOMPRESS_VM(th_vcompress_vm_b, uint8_t, H1, clearb_th)
+GEN_TH_VCOMPRESS_VM(th_vcompress_vm_h, uint16_t, H2, clearh_th)
+GEN_TH_VCOMPRESS_VM(th_vcompress_vm_w, uint32_t, H4, clearl_th)
+GEN_TH_VCOMPRESS_VM(th_vcompress_vm_d, uint64_t, H8, clearq_th)
-- 
2.44.0


