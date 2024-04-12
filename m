Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C199C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvCDo-0007Es-GM; Fri, 12 Apr 2024 04:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCDm-0007DO-SP; Fri, 12 Apr 2024 04:25:18 -0400
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCDg-0008DG-Bm; Fri, 12 Apr 2024 04:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712910306; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=0o5z902MUZqe6fDYphamYfk/0or6RBtEHfsI6q67FOI=;
 b=jQTLn0t5URE3SmiS0vxoKnqVWIKsmsRcgG+dU5uceDTpa+atmrZVHd9wfA2SBY09QWFcbry/iC62t4MIARUAAIWKpQYo/HgdZbm/fZmAqC8nimoNf8H4bt9YLGZsLh2PMh/sw8H6i2LN2UmZMVLRFmza5B2NRasrDGCFY4N7dIs=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NgLXS_1712910304; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NgLXS_1712910304) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 16:25:05 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 23/65] target/riscv: Add integer min/max instructions for
 XTheadVector
Date: Fri, 12 Apr 2024 15:36:53 +0800
Message-ID: <20240412073735.76413-24-eric.huang@linux.alibaba.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
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
 target/riscv/helper.h                         | 33 +++++++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 18 ++---
 target/riscv/xtheadvector_helper.c            | 67 +++++++++++++++++++
 3 files changed, 110 insertions(+), 8 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 8f2dec158b..f3e4ab0f1f 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1695,3 +1695,36 @@ DEF_HELPER_6(th_vmsgt_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vmsgt_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vmsgt_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vmsgt_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(th_vminu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vminu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vminu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vminu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmin_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmin_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmin_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmin_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmaxu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmaxu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmaxu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmaxu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmax_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmax_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmax_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmax_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vminu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vminu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vminu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vminu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmin_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmin_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmin_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmin_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmaxu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmaxu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmaxu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmaxu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmax_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmax_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmax_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmax_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 049d9da0a5..f19a771b61 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -1519,20 +1519,22 @@ GEN_OPIVI_TRANS_TH(th_vmsle_vi, IMM_SX, th_vmsle_vx, opivx_cmp_check_th)
 GEN_OPIVI_TRANS_TH(th_vmsgtu_vi, IMM_ZX, th_vmsgtu_vx, opivx_cmp_check_th)
 GEN_OPIVI_TRANS_TH(th_vmsgt_vi, IMM_SX, th_vmsgt_vx, opivx_cmp_check_th)
 
+/* Vector Integer Min/Max Instructions */
+GEN_OPIVV_GVEC_TRANS_TH(th_vminu_vv, umin)
+GEN_OPIVV_GVEC_TRANS_TH(th_vmin_vv,  smin)
+GEN_OPIVV_GVEC_TRANS_TH(th_vmaxu_vv, umax)
+GEN_OPIVV_GVEC_TRANS_TH(th_vmax_vv,  smax)
+GEN_OPIVX_TRANS_TH(th_vminu_vx, opivx_check_th)
+GEN_OPIVX_TRANS_TH(th_vmin_vx,  opivx_check_th)
+GEN_OPIVX_TRANS_TH(th_vmaxu_vx, opivx_check_th)
+GEN_OPIVX_TRANS_TH(th_vmax_vx,  opivx_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vminu_vv)
-TH_TRANS_STUB(th_vminu_vx)
-TH_TRANS_STUB(th_vmin_vv)
-TH_TRANS_STUB(th_vmin_vx)
-TH_TRANS_STUB(th_vmaxu_vv)
-TH_TRANS_STUB(th_vmaxu_vx)
-TH_TRANS_STUB(th_vmax_vv)
-TH_TRANS_STUB(th_vmax_vx)
 TH_TRANS_STUB(th_vmul_vv)
 TH_TRANS_STUB(th_vmul_vx)
 TH_TRANS_STUB(th_vmulh_vv)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 827650b325..da869e1069 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -1542,3 +1542,70 @@ GEN_TH_CMP_VX(th_vmsgt_vx_b, int8_t,  H1, TH_MSGT)
 GEN_TH_CMP_VX(th_vmsgt_vx_h, int16_t, H2, TH_MSGT)
 GEN_TH_CMP_VX(th_vmsgt_vx_w, int32_t, H4, TH_MSGT)
 GEN_TH_CMP_VX(th_vmsgt_vx_d, int64_t, H8, TH_MSGT)
+
+/* Vector Integer Min/Max Instructions */
+THCALL(TH_OPIVV2, th_vminu_vv_b, OP_UUU_B, H1, H1, H1, TH_MIN)
+THCALL(TH_OPIVV2, th_vminu_vv_h, OP_UUU_H, H2, H2, H2, TH_MIN)
+THCALL(TH_OPIVV2, th_vminu_vv_w, OP_UUU_W, H4, H4, H4, TH_MIN)
+THCALL(TH_OPIVV2, th_vminu_vv_d, OP_UUU_D, H8, H8, H8, TH_MIN)
+THCALL(TH_OPIVV2, th_vmin_vv_b, OP_SSS_B, H1, H1, H1, TH_MIN)
+THCALL(TH_OPIVV2, th_vmin_vv_h, OP_SSS_H, H2, H2, H2, TH_MIN)
+THCALL(TH_OPIVV2, th_vmin_vv_w, OP_SSS_W, H4, H4, H4, TH_MIN)
+THCALL(TH_OPIVV2, th_vmin_vv_d, OP_SSS_D, H8, H8, H8, TH_MIN)
+THCALL(TH_OPIVV2, th_vmaxu_vv_b, OP_UUU_B, H1, H1, H1, TH_MAX)
+THCALL(TH_OPIVV2, th_vmaxu_vv_h, OP_UUU_H, H2, H2, H2, TH_MAX)
+THCALL(TH_OPIVV2, th_vmaxu_vv_w, OP_UUU_W, H4, H4, H4, TH_MAX)
+THCALL(TH_OPIVV2, th_vmaxu_vv_d, OP_UUU_D, H8, H8, H8, TH_MAX)
+THCALL(TH_OPIVV2, th_vmax_vv_b, OP_SSS_B, H1, H1, H1, TH_MAX)
+THCALL(TH_OPIVV2, th_vmax_vv_h, OP_SSS_H, H2, H2, H2, TH_MAX)
+THCALL(TH_OPIVV2, th_vmax_vv_w, OP_SSS_W, H4, H4, H4, TH_MAX)
+THCALL(TH_OPIVV2, th_vmax_vv_d, OP_SSS_D, H8, H8, H8, TH_MAX)
+GEN_TH_VV(th_vminu_vv_b, 1, 1, clearb_th)
+GEN_TH_VV(th_vminu_vv_h, 2, 2, clearh_th)
+GEN_TH_VV(th_vminu_vv_w, 4, 4, clearl_th)
+GEN_TH_VV(th_vminu_vv_d, 8, 8, clearq_th)
+GEN_TH_VV(th_vmin_vv_b, 1, 1, clearb_th)
+GEN_TH_VV(th_vmin_vv_h, 2, 2, clearh_th)
+GEN_TH_VV(th_vmin_vv_w, 4, 4, clearl_th)
+GEN_TH_VV(th_vmin_vv_d, 8, 8, clearq_th)
+GEN_TH_VV(th_vmaxu_vv_b, 1, 1, clearb_th)
+GEN_TH_VV(th_vmaxu_vv_h, 2, 2, clearh_th)
+GEN_TH_VV(th_vmaxu_vv_w, 4, 4, clearl_th)
+GEN_TH_VV(th_vmaxu_vv_d, 8, 8, clearq_th)
+GEN_TH_VV(th_vmax_vv_b, 1, 1, clearb_th)
+GEN_TH_VV(th_vmax_vv_h, 2, 2, clearh_th)
+GEN_TH_VV(th_vmax_vv_w, 4, 4, clearl_th)
+GEN_TH_VV(th_vmax_vv_d, 8, 8, clearq_th)
+
+THCALL(TH_OPIVX2, th_vminu_vx_b, OP_UUU_B, H1, H1, TH_MIN)
+THCALL(TH_OPIVX2, th_vminu_vx_h, OP_UUU_H, H2, H2, TH_MIN)
+THCALL(TH_OPIVX2, th_vminu_vx_w, OP_UUU_W, H4, H4, TH_MIN)
+THCALL(TH_OPIVX2, th_vminu_vx_d, OP_UUU_D, H8, H8, TH_MIN)
+THCALL(TH_OPIVX2, th_vmin_vx_b, OP_SSS_B, H1, H1, TH_MIN)
+THCALL(TH_OPIVX2, th_vmin_vx_h, OP_SSS_H, H2, H2, TH_MIN)
+THCALL(TH_OPIVX2, th_vmin_vx_w, OP_SSS_W, H4, H4, TH_MIN)
+THCALL(TH_OPIVX2, th_vmin_vx_d, OP_SSS_D, H8, H8, TH_MIN)
+THCALL(TH_OPIVX2, th_vmaxu_vx_b, OP_UUU_B, H1, H1, TH_MAX)
+THCALL(TH_OPIVX2, th_vmaxu_vx_h, OP_UUU_H, H2, H2, TH_MAX)
+THCALL(TH_OPIVX2, th_vmaxu_vx_w, OP_UUU_W, H4, H4, TH_MAX)
+THCALL(TH_OPIVX2, th_vmaxu_vx_d, OP_UUU_D, H8, H8, TH_MAX)
+THCALL(TH_OPIVX2, th_vmax_vx_b, OP_SSS_B, H1, H1, TH_MAX)
+THCALL(TH_OPIVX2, th_vmax_vx_h, OP_SSS_H, H2, H2, TH_MAX)
+THCALL(TH_OPIVX2, th_vmax_vx_w, OP_SSS_W, H4, H4, TH_MAX)
+THCALL(TH_OPIVX2, th_vmax_vx_d, OP_SSS_D, H8, H8, TH_MAX)
+GEN_TH_VX(th_vminu_vx_b, 1, 1, clearb_th)
+GEN_TH_VX(th_vminu_vx_h, 2, 2, clearh_th)
+GEN_TH_VX(th_vminu_vx_w, 4, 4, clearl_th)
+GEN_TH_VX(th_vminu_vx_d, 8, 8, clearq_th)
+GEN_TH_VX(th_vmin_vx_b, 1, 1, clearb_th)
+GEN_TH_VX(th_vmin_vx_h, 2, 2, clearh_th)
+GEN_TH_VX(th_vmin_vx_w, 4, 4, clearl_th)
+GEN_TH_VX(th_vmin_vx_d, 8, 8, clearq_th)
+GEN_TH_VX(th_vmaxu_vx_b, 1, 1, clearb_th)
+GEN_TH_VX(th_vmaxu_vx_h, 2, 2, clearh_th)
+GEN_TH_VX(th_vmaxu_vx_w, 4, 4, clearl_th)
+GEN_TH_VX(th_vmaxu_vx_d, 8, 8,  clearq_th)
+GEN_TH_VX(th_vmax_vx_b, 1, 1, clearb_th)
+GEN_TH_VX(th_vmax_vx_h, 2, 2, clearh_th)
+GEN_TH_VX(th_vmax_vx_w, 4, 4, clearl_th)
+GEN_TH_VX(th_vmax_vx_d, 8, 8, clearq_th)
-- 
2.44.0


