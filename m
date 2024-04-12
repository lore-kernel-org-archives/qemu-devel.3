Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B518C00A94
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBqG-0002Ii-Hj; Fri, 12 Apr 2024 04:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvBqE-0002IR-Bo; Fri, 12 Apr 2024 04:00:58 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvBq9-0003xl-VA; Fri, 12 Apr 2024 04:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712908848; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=YNvdgHfN8w2e7L19s+cU3m0HtBGznWrNm16M5aWsr3Y=;
 b=bDGiXxqVAcArqSL2l1J8nTx/GQL61KrJinmzVTfiR9nVLsUp+TirS699LzQSGNPfpGhHyCN5deqGvLAbZAjzwysGGj8VgnAvij9OmFeLkQ/8anTxxPaKLl5scQxeFPe0APIY+7bh418ssMrOPhdbj79Ie7uzKAuJSzMg5O2W+Ig=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4Nf54-_1712908846; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4Nf54-_1712908846) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 16:00:47 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 11/65] target/riscv: Add unit-stride store instructions for
 XTheadVector
Date: Fri, 12 Apr 2024 15:36:41 +0800
Message-ID: <20240412073735.76413-12-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
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

XTheadVector unit-stride store instructions diff from RVV1.0 in the following
points:
1. Different mask reg layout.
2. Different vector reg element width.
3. Different tail/masked elements process policy.
4. Different check policy.

The detials of the difference are the same as strided store instruction, as
unit-stride is the special case of strided operations.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         | 26 ++++++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 59 +++++++++++++++++--
 target/riscv/xtheadvector_helper.c            | 31 ++++++++++
 3 files changed, 112 insertions(+), 4 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index f2fa8425b3..eb31784e18 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1361,3 +1361,29 @@ DEF_HELPER_5(th_vlwu_v_w, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(th_vlwu_v_w_mask, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(th_vlwu_v_d, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(th_vlwu_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vsb_v_b, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vsb_v_b_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vsb_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vsb_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vsb_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vsb_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vsb_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vsb_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vsh_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vsh_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vsh_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vsh_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vsh_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vsh_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vsw_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vsw_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vsw_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vsw_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vse_v_b, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vse_v_b_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vse_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vse_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vse_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vse_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vse_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vse_v_d_mask, void, ptr, ptr, tl, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index eb910acf40..9b88ea2fa4 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -398,6 +398,61 @@ GEN_TH_TRANS(th_vlbu_v, 4, r2nfvm, ld_us_op_th, ld_us_check_th)
 GEN_TH_TRANS(th_vlhu_v, 5, r2nfvm, ld_us_op_th, ld_us_check_th)
 GEN_TH_TRANS(th_vlwu_v, 6, r2nfvm, ld_us_op_th, ld_us_check_th)
 
+/*
+ * This function is almost the copy of st_us_op, except:
+ * 1) different data encoding.
+ * 2) XTheadVector has more situations, depending on SEW.
+ */
+static bool st_us_op_th(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
+{
+    uint32_t data = 0;
+    gen_helper_ldst_us_th *fn;
+    static gen_helper_ldst_us_th * const fns[2][4][4] = {
+        /* masked unit stride load and store */
+        { { gen_helper_th_vsb_v_b_mask,  gen_helper_th_vsb_v_h_mask,
+            gen_helper_th_vsb_v_w_mask,  gen_helper_th_vsb_v_d_mask },
+          { NULL,                        gen_helper_th_vsh_v_h_mask,
+            gen_helper_th_vsh_v_w_mask,  gen_helper_th_vsh_v_d_mask },
+          { NULL,                        NULL,
+            gen_helper_th_vsw_v_w_mask,  gen_helper_th_vsw_v_d_mask },
+          { gen_helper_th_vse_v_b_mask,  gen_helper_th_vse_v_h_mask,
+            gen_helper_th_vse_v_w_mask,  gen_helper_th_vse_v_d_mask } },
+        /* unmasked unit stride store */
+        { { gen_helper_th_vsb_v_b,  gen_helper_th_vsb_v_h,
+            gen_helper_th_vsb_v_w,  gen_helper_th_vsb_v_d },
+          { NULL,                   gen_helper_th_vsh_v_h,
+            gen_helper_th_vsh_v_w,  gen_helper_th_vsh_v_d },
+          { NULL,                   NULL,
+            gen_helper_th_vsw_v_w,  gen_helper_th_vsw_v_d },
+          { gen_helper_th_vse_v_b,  gen_helper_th_vse_v_h,
+            gen_helper_th_vse_v_w,  gen_helper_th_vse_v_d } }
+    };
+
+    fn =  fns[a->vm][seq][s->sew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    data = FIELD_DP32(data, VDATA_TH, MLEN, s->mlen);
+    data = FIELD_DP32(data, VDATA_TH, VM, a->vm);
+    data = FIELD_DP32(data, VDATA_TH, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA_TH, NF, a->nf);
+    return ldst_us_trans(a->rd, a->rs1, data, fn, s, true);
+}
+
+static bool st_us_check_th(DisasContext *s, arg_r2nfvm* a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_reg(s, a->rd, false) &&
+            th_check_nf(s, a->rd, a->nf));
+}
+
+GEN_TH_TRANS(th_vsb_v, 0, r2nfvm, st_us_op_th, st_us_check_th)
+GEN_TH_TRANS(th_vsh_v, 1, r2nfvm, st_us_op_th, st_us_check_th)
+GEN_TH_TRANS(th_vsw_v, 2, r2nfvm, st_us_op_th, st_us_check_th)
+GEN_TH_TRANS(th_vse_v, 3, r2nfvm, st_us_op_th, st_us_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
@@ -411,10 +466,6 @@ TH_TRANS_STUB(th_vleff_v)
 TH_TRANS_STUB(th_vlbuff_v)
 TH_TRANS_STUB(th_vlhuff_v)
 TH_TRANS_STUB(th_vlwuff_v)
-TH_TRANS_STUB(th_vsb_v)
-TH_TRANS_STUB(th_vsh_v)
-TH_TRANS_STUB(th_vsw_v)
-TH_TRANS_STUB(th_vse_v)
 TH_TRANS_STUB(th_vlxb_v)
 TH_TRANS_STUB(th_vlxh_v)
 TH_TRANS_STUB(th_vlxw_v)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 7566ab8e31..5c05cd5aa6 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -405,3 +405,34 @@ GEN_TH_LD_US(th_vlhu_v_w, uint16_t, uint32_t, ldhu_w, clearl_th)
 GEN_TH_LD_US(th_vlhu_v_d, uint16_t, uint64_t, ldhu_d, clearq_th)
 GEN_TH_LD_US(th_vlwu_v_w, uint32_t, uint32_t, ldwu_w, clearl_th)
 GEN_TH_LD_US(th_vlwu_v_d, uint32_t, uint64_t, ldwu_d, clearq_th)
+
+/* similar to GEN_GEN_VEXT_ST_US, change the function */
+#define GEN_TH_ST_US(NAME, MTYPE, ETYPE, STORE_FN)                      \
+void HELPER(NAME##_mask)(void *vd, void *v0, target_ulong base,         \
+                         CPURISCVState *env, uint32_t desc)             \
+{                                                                       \
+    uint32_t stride = th_nf(desc) * sizeof(MTYPE);                      \
+    th_ldst_stride(vd, v0, base, stride, env, desc, false, STORE_FN,    \
+                   NULL, sizeof(ETYPE), sizeof(MTYPE), GETPC());        \
+}                                                                       \
+                                                                        \
+void HELPER(NAME)(void *vd, void *v0, target_ulong base,                \
+                  CPURISCVState *env, uint32_t desc)                    \
+{                                                                       \
+    th_ldst_us(vd, base, env, desc, STORE_FN, NULL,                     \
+               sizeof(ETYPE), sizeof(MTYPE), GETPC());                  \
+}
+
+GEN_TH_ST_US(th_vsb_v_b, int8_t,  int8_t , stb_b)
+GEN_TH_ST_US(th_vsb_v_h, int8_t,  int16_t, stb_h)
+GEN_TH_ST_US(th_vsb_v_w, int8_t,  int32_t, stb_w)
+GEN_TH_ST_US(th_vsb_v_d, int8_t,  int64_t, stb_d)
+GEN_TH_ST_US(th_vsh_v_h, int16_t, int16_t, sth_h)
+GEN_TH_ST_US(th_vsh_v_w, int16_t, int32_t, sth_w)
+GEN_TH_ST_US(th_vsh_v_d, int16_t, int64_t, sth_d)
+GEN_TH_ST_US(th_vsw_v_w, int32_t, int32_t, stw_w)
+GEN_TH_ST_US(th_vsw_v_d, int32_t, int64_t, stw_d)
+GEN_TH_ST_US(th_vse_v_b, int8_t,  int8_t , ste_b)
+GEN_TH_ST_US(th_vse_v_h, int16_t, int16_t, ste_h)
+GEN_TH_ST_US(th_vse_v_w, int32_t, int32_t, ste_w)
+GEN_TH_ST_US(th_vse_v_d, int64_t, int64_t, ste_d)
-- 
2.44.0


