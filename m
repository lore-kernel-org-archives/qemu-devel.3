Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D080EC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 09:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDEH-0002hM-HA; Fri, 12 Apr 2024 05:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDEB-0002ew-Ab; Fri, 12 Apr 2024 05:29:49 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDE4-0003oK-SS; Fri, 12 Apr 2024 05:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712914176; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=8umZ3OYSUXMZOWPRFyta6L/0drZPcl2rI0y+4M2ZquQ=;
 b=cObjeej2wjWDy8t5YnUYG8eeaEXdIcWpJnvynup2ocp3WvzK+HEEaGkCWdkmE8ZZiK32Sqvh9MEMAYqA07x2brR22+NCjEN0vo7t41Y/3Zyx1m6RaglG9EK6C2KNREYpfUQ22PCNmm9ZK+lwcmzRky913fpvHt6a9d79oPg89AA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4Nsagg_1712914174; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4Nsagg_1712914174) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 17:29:35 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 47/65] target/riscv: Add single-width floating-point/integer
 type-convert instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:37:17 +0800
Message-ID: <20240412073735.76413-48-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.131;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-131.freemail.mail.aliyun.com
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

Compared to RVV1.0, XTheadVector lacks .rtz instructions, which specify the
rounding mode of rounding to zero.
Except of lack of similar instructions, the instructions have the same function
as RVV1.0. Overall there are only general differences between XTheadVector and RVV1.0.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         | 13 ++++++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 10 +++---
 target/riscv/xtheadvector_helper.c            | 33 +++++++++++++++++++
 3 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 886655899e..18640c4a1e 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -2197,3 +2197,16 @@ DEF_HELPER_5(th_vfclass_v_d, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(th_vfmerge_vfm_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(th_vfmerge_vfm_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(th_vfmerge_vfm_d, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_5(th_vfcvt_xu_f_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfcvt_xu_f_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfcvt_xu_f_v_d, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfcvt_x_f_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfcvt_x_f_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfcvt_x_f_v_d, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfcvt_f_xu_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfcvt_f_xu_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfcvt_f_xu_v_d, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfcvt_f_x_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfcvt_f_x_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfcvt_f_x_v_d, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 8e928febb7..27a06c2cac 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -2191,16 +2191,18 @@ static bool trans_th_vfmv_v_f(DisasContext *s, arg_th_vfmv_v_f *a)
     return false;
 }
 
+/* Single-Width Floating-Point/Integer Type-Convert Instructions */
+GEN_OPFV_TRANS_TH(th_vfcvt_xu_f_v, opfv_check_th)
+GEN_OPFV_TRANS_TH(th_vfcvt_x_f_v, opfv_check_th)
+GEN_OPFV_TRANS_TH(th_vfcvt_f_xu_v, opfv_check_th)
+GEN_OPFV_TRANS_TH(th_vfcvt_f_x_v, opfv_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vfcvt_xu_f_v)
-TH_TRANS_STUB(th_vfcvt_x_f_v)
-TH_TRANS_STUB(th_vfcvt_f_xu_v)
-TH_TRANS_STUB(th_vfcvt_f_x_v)
 TH_TRANS_STUB(th_vfwcvt_xu_f_v)
 TH_TRANS_STUB(th_vfwcvt_x_f_v)
 TH_TRANS_STUB(th_vfwcvt_f_xu_v)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index e31e13dff3..7e98c1ead2 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -3205,3 +3205,36 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
 GEN_VFMERGE_VF_TH(th_vfmerge_vfm_h, int16_t, H2, clearh_th)
 GEN_VFMERGE_VF_TH(th_vfmerge_vfm_w, int32_t, H4, clearl_th)
 GEN_VFMERGE_VF_TH(th_vfmerge_vfm_d, int64_t, H8, clearq_th)
+
+/* Single-Width Floating-Point/Integer Type-Convert Instructions */
+/* vfcvt.xu.f.v vd, vs2, vm # Convert float to unsigned integer. */
+THCALL(TH_OPFVV1, th_vfcvt_xu_f_v_h, OP_UU_H, H2, H2, float16_to_uint16)
+THCALL(TH_OPFVV1, th_vfcvt_xu_f_v_w, OP_UU_W, H4, H4, float32_to_uint32)
+THCALL(TH_OPFVV1, th_vfcvt_xu_f_v_d, OP_UU_D, H8, H8, float64_to_uint64)
+GEN_TH_V_ENV(th_vfcvt_xu_f_v_h, 2, 2, clearh_th)
+GEN_TH_V_ENV(th_vfcvt_xu_f_v_w, 4, 4, clearl_th)
+GEN_TH_V_ENV(th_vfcvt_xu_f_v_d, 8, 8, clearq_th)
+
+/* vfcvt.x.f.v vd, vs2, vm # Convert float to signed integer. */
+THCALL(TH_OPFVV1, th_vfcvt_x_f_v_h, OP_UU_H, H2, H2, float16_to_int16)
+THCALL(TH_OPFVV1, th_vfcvt_x_f_v_w, OP_UU_W, H4, H4, float32_to_int32)
+THCALL(TH_OPFVV1, th_vfcvt_x_f_v_d, OP_UU_D, H8, H8, float64_to_int64)
+GEN_TH_V_ENV(th_vfcvt_x_f_v_h, 2, 2, clearh_th)
+GEN_TH_V_ENV(th_vfcvt_x_f_v_w, 4, 4, clearl_th)
+GEN_TH_V_ENV(th_vfcvt_x_f_v_d, 8, 8, clearq_th)
+
+/* vfcvt.f.xu.v vd, vs2, vm # Convert unsigned integer to float. */
+THCALL(TH_OPFVV1, th_vfcvt_f_xu_v_h, OP_UU_H, H2, H2, uint16_to_float16)
+THCALL(TH_OPFVV1, th_vfcvt_f_xu_v_w, OP_UU_W, H4, H4, uint32_to_float32)
+THCALL(TH_OPFVV1, th_vfcvt_f_xu_v_d, OP_UU_D, H8, H8, uint64_to_float64)
+GEN_TH_V_ENV(th_vfcvt_f_xu_v_h, 2, 2, clearh_th)
+GEN_TH_V_ENV(th_vfcvt_f_xu_v_w, 4, 4, clearl_th)
+GEN_TH_V_ENV(th_vfcvt_f_xu_v_d, 8, 8, clearq_th)
+
+/* vfcvt.f.x.v vd, vs2, vm # Convert integer to float. */
+THCALL(TH_OPFVV1, th_vfcvt_f_x_v_h, OP_UU_H, H2, H2, int16_to_float16)
+THCALL(TH_OPFVV1, th_vfcvt_f_x_v_w, OP_UU_W, H4, H4, int32_to_float32)
+THCALL(TH_OPFVV1, th_vfcvt_f_x_v_d, OP_UU_D, H8, H8, int64_to_float64)
+GEN_TH_V_ENV(th_vfcvt_f_x_v_h, 2, 2, clearh_th)
+GEN_TH_V_ENV(th_vfcvt_f_x_v_w, 4, 4, clearl_th)
+GEN_TH_V_ENV(th_vfcvt_f_x_v_d, 8, 8, clearq_th)
-- 
2.44.0


