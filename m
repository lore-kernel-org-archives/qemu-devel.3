Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B5AC00A94
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBuD-0005PC-8l; Fri, 12 Apr 2024 04:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvBu9-0005Ou-Dp; Fri, 12 Apr 2024 04:05:01 -0400
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvBu5-0004WY-1H; Fri, 12 Apr 2024 04:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712909091; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=9ugy1gHKeOMe5mNFWAUsyeoGXw4JWDzoRj/8nAijsX8=;
 b=Xkp9PBdbFIN9Kr3RuE2DgCdjTrLCZ78cR5VMXvGh317vWsGuiGQlwkP9BzzlEpYTTWYbq3ZXWxTf1P4Bj6uBhNUF0WDfmAf5eAgZCKcVEvXV8cVvSSqFZoM3U0URnrcPwidt7uUKsJPPdk6FmIeZfLlTsBS/urs75qoxkqIojYo=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4Nah7i_1712909089; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4Nah7i_1712909089) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 16:04:50 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 13/65] target/riscv: Add indexed store instructions for
 XTheadVector
Date: Fri, 12 Apr 2024 15:36:43 +0800
Message-ID: <20240412073735.76413-14-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.124;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-124.freemail.mail.aliyun.com
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

XTheadVector indexed store instructions diff from RVV1.0 in the following
points:
1. Different mask reg layout.
2. Different access width. As same as XTheadVector indexed load instructions,
   except store does not need to distinguish between zero and sign extended.
3. Different masked elements process policy.
4. Different check policy.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         | 13 +++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 49 +++++++++++++++++--
 target/riscv/xtheadvector_helper.c            | 24 +++++++++
 3 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 733071bdc6..fd81db2f74 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1409,3 +1409,16 @@ DEF_HELPER_6(th_vlxhu_v_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vlxhu_v_d, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vlxwu_v_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vlxwu_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsxb_v_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsxb_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsxb_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsxb_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsxh_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsxh_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsxh_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsxw_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsxw_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsxe_v_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsxe_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsxe_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsxe_v_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 8148097de3..68a2a9a0cf 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -537,6 +537,51 @@ GEN_TH_TRANS(th_vlxbu_v, 4, rnfvm, ld_index_op_th, ld_index_check_th)
 GEN_TH_TRANS(th_vlxhu_v, 5, rnfvm, ld_index_op_th, ld_index_check_th)
 GEN_TH_TRANS(th_vlxwu_v, 6, rnfvm, ld_index_op_th, ld_index_check_th)
 
+/*
+ * This function is almost the copy of st_index_op, except:
+ * 1) different data encoding.
+ */
+static bool st_index_op_th(DisasContext *s, arg_rnfvm *a, uint8_t seq)
+{
+    uint32_t data = 0;
+    gen_helper_ldst_index_th *fn;
+    static gen_helper_ldst_index_th * const fns[4][4] = {
+        { gen_helper_th_vsxb_v_b,  gen_helper_th_vsxb_v_h,
+          gen_helper_th_vsxb_v_w,  gen_helper_th_vsxb_v_d },
+        { NULL,                    gen_helper_th_vsxh_v_h,
+          gen_helper_th_vsxh_v_w,  gen_helper_th_vsxh_v_d },
+        { NULL,                    NULL,
+          gen_helper_th_vsxw_v_w,  gen_helper_th_vsxw_v_d },
+        { gen_helper_th_vsxe_v_b,  gen_helper_th_vsxe_v_h,
+          gen_helper_th_vsxe_v_w,  gen_helper_th_vsxe_v_d }
+    };
+
+    fn =  fns[seq][s->sew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    data = FIELD_DP32(data, VDATA_TH, MLEN, s->mlen);
+    data = FIELD_DP32(data, VDATA_TH, VM, a->vm);
+    data = FIELD_DP32(data, VDATA_TH, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA_TH, NF, a->nf);
+    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s);
+}
+
+static bool st_index_check_th(DisasContext *s, arg_rnfvm* a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_reg(s, a->rd, false) &&
+            th_check_reg(s, a->rs2, false) &&
+            th_check_nf(s, a->rd, a->nf));
+}
+
+GEN_TH_TRANS(th_vsxb_v, 0, rnfvm, st_index_op_th, st_index_check_th)
+GEN_TH_TRANS(th_vsxh_v, 1, rnfvm, st_index_op_th, st_index_check_th)
+GEN_TH_TRANS(th_vsxw_v, 2, rnfvm, st_index_op_th, st_index_check_th)
+GEN_TH_TRANS(th_vsxe_v, 3, rnfvm, st_index_op_th, st_index_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
@@ -550,10 +595,6 @@ TH_TRANS_STUB(th_vleff_v)
 TH_TRANS_STUB(th_vlbuff_v)
 TH_TRANS_STUB(th_vlhuff_v)
 TH_TRANS_STUB(th_vlwuff_v)
-TH_TRANS_STUB(th_vsxb_v)
-TH_TRANS_STUB(th_vsxh_v)
-TH_TRANS_STUB(th_vsxw_v)
-TH_TRANS_STUB(th_vsxe_v)
 TH_TRANS_STUB(th_vamoswapw_v)
 TH_TRANS_STUB(th_vamoaddw_v)
 TH_TRANS_STUB(th_vamoxorw_v)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index a9ae157296..22af4774df 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -518,3 +518,27 @@ GEN_TH_LD_INDEX(th_vlxhu_v_w, uint16_t, uint32_t, idx_w, ldhu_w, clearl_th)
 GEN_TH_LD_INDEX(th_vlxhu_v_d, uint16_t, uint64_t, idx_d, ldhu_d, clearq_th)
 GEN_TH_LD_INDEX(th_vlxwu_v_w, uint32_t, uint32_t, idx_w, ldwu_w, clearl_th)
 GEN_TH_LD_INDEX(th_vlxwu_v_d, uint32_t, uint64_t, idx_d, ldwu_d, clearq_th)
+
+/* Similar to GEN_VEXT_ST_INDEX */
+#define GEN_TH_ST_INDEX(NAME, MTYPE, ETYPE, INDEX_FN, STORE_FN)  \
+void HELPER(NAME)(void *vd, void *v0, target_ulong base,         \
+                  void *vs2, CPURISCVState *env, uint32_t desc)  \
+{                                                                \
+    th_ldst_index(vd, v0, base, vs2, env, desc, INDEX_FN,        \
+                  STORE_FN, NULL, sizeof(ETYPE), sizeof(MTYPE),  \
+                  GETPC());                                      \
+}
+
+GEN_TH_ST_INDEX(th_vsxb_v_b, int8_t,  int8_t,  idx_b, stb_b)
+GEN_TH_ST_INDEX(th_vsxb_v_h, int8_t,  int16_t, idx_h, stb_h)
+GEN_TH_ST_INDEX(th_vsxb_v_w, int8_t,  int32_t, idx_w, stb_w)
+GEN_TH_ST_INDEX(th_vsxb_v_d, int8_t,  int64_t, idx_d, stb_d)
+GEN_TH_ST_INDEX(th_vsxh_v_h, int16_t, int16_t, idx_h, sth_h)
+GEN_TH_ST_INDEX(th_vsxh_v_w, int16_t, int32_t, idx_w, sth_w)
+GEN_TH_ST_INDEX(th_vsxh_v_d, int16_t, int64_t, idx_d, sth_d)
+GEN_TH_ST_INDEX(th_vsxw_v_w, int32_t, int32_t, idx_w, stw_w)
+GEN_TH_ST_INDEX(th_vsxw_v_d, int32_t, int64_t, idx_d, stw_d)
+GEN_TH_ST_INDEX(th_vsxe_v_b, int8_t,  int8_t,  idx_b, ste_b)
+GEN_TH_ST_INDEX(th_vsxe_v_h, int16_t, int16_t, idx_h, ste_h)
+GEN_TH_ST_INDEX(th_vsxe_v_w, int32_t, int32_t, idx_w, ste_w)
+GEN_TH_ST_INDEX(th_vsxe_v_d, int64_t, int64_t, idx_d, ste_d)
-- 
2.44.0


