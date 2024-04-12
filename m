Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D74C00A94
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 09:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDVo-0002Oy-1q; Fri, 12 Apr 2024 05:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDVj-0002Og-SW; Fri, 12 Apr 2024 05:47:55 -0400
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDVh-0006hx-Ia; Fri, 12 Apr 2024 05:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712915268; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=4hfyZW4/05JjpSrcaJwfhZSpTipmklmzRqInWF/EWcg=;
 b=pjwufuHa2HSW1onxtucc6u/bIDvweAOQ1S09hGTQ8uqUzaL9FshLOenGlmzFRFXmNtrJMjTIgXtG/Na7Z1eVq6cmJb4BVd+MGT82g8i0/oBQ6SxyFM76TZRERUtm7R0YrfiW/lWDzPSHdAMPDBa4A11SnQ7J13qITEWZOCalOco=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4Nsh82_1712915267; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4Nsh82_1712915267) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 17:47:48 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 56/65] target/riscv: Add th.vmfirst.m for XTheadVector
Date: Fri, 12 Apr 2024 15:37:26 +0800
Message-ID: <20240412073735.76413-57-eric.huang@linux.alibaba.com>
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

The instructions have the same function as RVV1.0. Overall there are only
general differences between XTheadVector and RVV1.0.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         |  2 ++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 31 ++++++++++++++++++-
 target/riscv/xtheadvector_helper.c            | 20 ++++++++++++
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 6ddecbbe65..2379a3431d 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -2300,3 +2300,5 @@ DEF_HELPER_6(th_vmornot_mm, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(th_vmxnor_mm, void, ptr, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_4(th_vmpopc_m, tl, ptr, ptr, env, i32)
+
+DEF_HELPER_4(th_vmfirst_m, tl, ptr, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index f8e8b321e4..45554c38fb 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -2471,13 +2471,42 @@ static bool trans_th_vmpopc_m(DisasContext *s, arg_rmr *a)
     return false;
 }
 
+/* vmfirst find-first-set mask bit */
+static bool trans_th_vmfirst_m(DisasContext *s, arg_rmr *a)
+{
+    if (require_xtheadvector(s) &&
+        vext_check_isa_ill(s)) {
+        TCGv_ptr src2, mask;
+        TCGv dst;
+        TCGv_i32 desc;
+        uint32_t data = 0;
+        data = FIELD_DP32(data, VDATA_TH, MLEN, s->mlen);
+        data = FIELD_DP32(data, VDATA_TH, VM, a->vm);
+        data = FIELD_DP32(data, VDATA_TH, LMUL, s->lmul);
+
+        mask = tcg_temp_new_ptr();
+        src2 = tcg_temp_new_ptr();
+        dst = dest_gpr(s, a->rd);
+        desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
+                                          s->cfg_ptr->vlenb, data));
+
+        tcg_gen_addi_ptr(src2, tcg_env, vreg_ofs(s, a->rs2));
+        tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
+
+        gen_helper_th_vmfirst_m(dst, mask, src2, tcg_env, desc);
+        gen_set_gpr(s, a->rd, dst);
+
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
 
-TH_TRANS_STUB(th_vmfirst_m)
 TH_TRANS_STUB(th_vmsbf_m)
 TH_TRANS_STUB(th_vmsif_m)
 TH_TRANS_STUB(th_vmsof_m)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index ba1ab0435d..1860e47f4f 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -3538,3 +3538,23 @@ target_ulong HELPER(th_vmpopc_m)(void *v0, void *vs2, CPURISCVState *env,
     env->vstart = 0;
     return cnt;
 }
+
+/* vmfirst find-first-set mask bit*/
+target_ulong HELPER(th_vmfirst_m)(void *v0, void *vs2, CPURISCVState *env,
+                               uint32_t desc)
+{
+    uint32_t mlen = th_mlen(desc);
+    uint32_t vm = th_vm(desc);
+    uint32_t vl = env->vl;
+    int i;
+
+    for (i = env->vstart; i < vl; i++) {
+        if (vm || th_elem_mask(v0, mlen, i)) {
+            if (th_elem_mask(vs2, mlen, i)) {
+                return i;
+            }
+        }
+    }
+    env->vstart = 0;
+    return -1LL;
+}
-- 
2.44.0


