Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11294C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvC61-00031O-VB; Fri, 12 Apr 2024 04:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvC5s-00030M-Fl; Fri, 12 Apr 2024 04:17:09 -0400
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvC5q-0006oy-BW; Fri, 12 Apr 2024 04:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712909820; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=j8Bo0/2LIl6dABn/l0mBMsDO09qRupjZeSWwd8wdd4I=;
 b=LtMay7XeoZ1n0yQR6BeIlC4scL9zgnnd3OPkjPwJf2x2pQ7a8uGp/Ie6GFXEdUObT0lt2weTKPmC6ZdCOrf+akt8G/1A9aO/kDWUxE1efvA2j+lv7prCwzBOEm0/5BpUgmcOaaC4agPLyk65NZ6jDY2DPlvZK2A55Onwr3OCs94=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R431e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4Nb6r6_1712909818; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4Nb6r6_1712909818) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 16:16:59 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 19/65] target/riscv: Add bitwise logical instructions for
 XTheadVector
Date: Fri, 12 Apr 2024 15:36:49 +0800
Message-ID: <20240412073735.76413-20-eric.huang@linux.alibaba.com>
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

Add bitwise logical instructions by resuing macros define before,
Therefore, the difference depending on the macros which commited
in other patchs.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         | 25 +++++++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 20 ++++----
 target/riscv/xtheadvector_helper.c            | 51 +++++++++++++++++++
 3 files changed, 87 insertions(+), 9 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 25fb8f81c7..6599b2f2f5 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1575,3 +1575,28 @@ DEF_HELPER_6(th_vmsbc_vxm_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vmsbc_vxm_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vmsbc_vxm_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vmsbc_vxm_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(th_vand_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vand_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vand_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vand_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vor_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vor_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vor_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vor_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vxor_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vxor_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vxor_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vxor_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vand_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vand_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vand_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vand_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vor_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vor_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vor_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vor_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vxor_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vxor_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vxor_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vxor_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index a9e20a6dcb..2b7b2cfe20 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -1314,21 +1314,23 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
 GEN_OPIVI_TRANS_TH(th_vadc_vim, IMM_SX, th_vadc_vxm, opivx_vadc_check_th)
 GEN_OPIVI_TRANS_TH(th_vmadc_vim, IMM_SX, th_vmadc_vxm, opivx_vmadc_check_th)
 
+/* Vector Bitwise Logical Instructions */
+GEN_OPIVV_GVEC_TRANS_TH(th_vand_vv, and)
+GEN_OPIVV_GVEC_TRANS_TH(th_vor_vv,  or)
+GEN_OPIVV_GVEC_TRANS_TH(th_vxor_vv, xor)
+GEN_OPIVX_GVEC_TRANS_TH(th_vand_vx, ands)
+GEN_OPIVX_GVEC_TRANS_TH(th_vor_vx,  ors)
+GEN_OPIVX_GVEC_TRANS_TH(th_vxor_vx, xors)
+GEN_OPIVI_GVEC_TRANS_TH(th_vand_vi, IMM_SX, th_vand_vx, andi)
+GEN_OPIVI_GVEC_TRANS_TH(th_vor_vi, IMM_SX, th_vor_vx,  ori)
+GEN_OPIVI_GVEC_TRANS_TH(th_vxor_vi, IMM_SX, th_vxor_vx, xori)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vand_vv)
-TH_TRANS_STUB(th_vand_vx)
-TH_TRANS_STUB(th_vand_vi)
-TH_TRANS_STUB(th_vor_vv)
-TH_TRANS_STUB(th_vor_vx)
-TH_TRANS_STUB(th_vor_vi)
-TH_TRANS_STUB(th_vxor_vv)
-TH_TRANS_STUB(th_vxor_vx)
-TH_TRANS_STUB(th_vxor_vi)
 TH_TRANS_STUB(th_vsll_vv)
 TH_TRANS_STUB(th_vsll_vx)
 TH_TRANS_STUB(th_vsll_vi)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index e5058d09f6..85fa69dd82 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -1223,3 +1223,54 @@ GEN_TH_VMADC_VXM(th_vmsbc_vxm_b, uint8_t,  H1, TH_MSBC)
 GEN_TH_VMADC_VXM(th_vmsbc_vxm_h, uint16_t, H2, TH_MSBC)
 GEN_TH_VMADC_VXM(th_vmsbc_vxm_w, uint32_t, H4, TH_MSBC)
 GEN_TH_VMADC_VXM(th_vmsbc_vxm_d, uint64_t, H8, TH_MSBC)
+
+/* Vector Bitwise Logical Instructions */
+THCALL(TH_OPIVV2, th_vand_vv_b, OP_SSS_B, H1, H1, H1, TH_AND)
+THCALL(TH_OPIVV2, th_vand_vv_h, OP_SSS_H, H2, H2, H2, TH_AND)
+THCALL(TH_OPIVV2, th_vand_vv_w, OP_SSS_W, H4, H4, H4, TH_AND)
+THCALL(TH_OPIVV2, th_vand_vv_d, OP_SSS_D, H8, H8, H8, TH_AND)
+THCALL(TH_OPIVV2, th_vor_vv_b, OP_SSS_B, H1, H1, H1, TH_OR)
+THCALL(TH_OPIVV2, th_vor_vv_h, OP_SSS_H, H2, H2, H2, TH_OR)
+THCALL(TH_OPIVV2, th_vor_vv_w, OP_SSS_W, H4, H4, H4, TH_OR)
+THCALL(TH_OPIVV2, th_vor_vv_d, OP_SSS_D, H8, H8, H8, TH_OR)
+THCALL(TH_OPIVV2, th_vxor_vv_b, OP_SSS_B, H1, H1, H1, TH_XOR)
+THCALL(TH_OPIVV2, th_vxor_vv_h, OP_SSS_H, H2, H2, H2, TH_XOR)
+THCALL(TH_OPIVV2, th_vxor_vv_w, OP_SSS_W, H4, H4, H4, TH_XOR)
+THCALL(TH_OPIVV2, th_vxor_vv_d, OP_SSS_D, H8, H8, H8, TH_XOR)
+GEN_TH_VV(th_vand_vv_b, 1, 1, clearb_th)
+GEN_TH_VV(th_vand_vv_h, 2, 2, clearh_th)
+GEN_TH_VV(th_vand_vv_w, 4, 4, clearl_th)
+GEN_TH_VV(th_vand_vv_d, 8, 8, clearq_th)
+GEN_TH_VV(th_vor_vv_b, 1, 1, clearb_th)
+GEN_TH_VV(th_vor_vv_h, 2, 2, clearh_th)
+GEN_TH_VV(th_vor_vv_w, 4, 4, clearl_th)
+GEN_TH_VV(th_vor_vv_d, 8, 8, clearq_th)
+GEN_TH_VV(th_vxor_vv_b, 1, 1, clearb_th)
+GEN_TH_VV(th_vxor_vv_h, 2, 2, clearh_th)
+GEN_TH_VV(th_vxor_vv_w, 4, 4, clearl_th)
+GEN_TH_VV(th_vxor_vv_d, 8, 8, clearq_th)
+
+THCALL(TH_OPIVX2, th_vand_vx_b, OP_SSS_B, H1, H1, TH_AND)
+THCALL(TH_OPIVX2, th_vand_vx_h, OP_SSS_H, H2, H2, TH_AND)
+THCALL(TH_OPIVX2, th_vand_vx_w, OP_SSS_W, H4, H4, TH_AND)
+THCALL(TH_OPIVX2, th_vand_vx_d, OP_SSS_D, H8, H8, TH_AND)
+THCALL(TH_OPIVX2, th_vor_vx_b, OP_SSS_B, H1, H1, TH_OR)
+THCALL(TH_OPIVX2, th_vor_vx_h, OP_SSS_H, H2, H2, TH_OR)
+THCALL(TH_OPIVX2, th_vor_vx_w, OP_SSS_W, H4, H4, TH_OR)
+THCALL(TH_OPIVX2, th_vor_vx_d, OP_SSS_D, H8, H8, TH_OR)
+THCALL(TH_OPIVX2, th_vxor_vx_b, OP_SSS_B, H1, H1, TH_XOR)
+THCALL(TH_OPIVX2, th_vxor_vx_h, OP_SSS_H, H2, H2, TH_XOR)
+THCALL(TH_OPIVX2, th_vxor_vx_w, OP_SSS_W, H4, H4, TH_XOR)
+THCALL(TH_OPIVX2, th_vxor_vx_d, OP_SSS_D, H8, H8, TH_XOR)
+GEN_TH_VX(th_vand_vx_b, 1, 1, clearb_th)
+GEN_TH_VX(th_vand_vx_h, 2, 2, clearh_th)
+GEN_TH_VX(th_vand_vx_w, 4, 4, clearl_th)
+GEN_TH_VX(th_vand_vx_d, 8, 8, clearq_th)
+GEN_TH_VX(th_vor_vx_b, 1, 1, clearb_th)
+GEN_TH_VX(th_vor_vx_h, 2, 2, clearh_th)
+GEN_TH_VX(th_vor_vx_w, 4, 4, clearl_th)
+GEN_TH_VX(th_vor_vx_d, 8, 8, clearq_th)
+GEN_TH_VX(th_vxor_vx_b, 1, 1, clearb_th)
+GEN_TH_VX(th_vxor_vx_h, 2, 2, clearh_th)
+GEN_TH_VX(th_vxor_vx_w, 4, 4, clearl_th)
+GEN_TH_VX(th_vxor_vx_d, 8, 8, clearq_th)
-- 
2.44.0


