Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2427FC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvCIF-0000hV-Jn; Fri, 12 Apr 2024 04:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCHe-0000dm-Dm; Fri, 12 Apr 2024 04:29:20 -0400
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCHb-0000RD-RE; Fri, 12 Apr 2024 04:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712910550; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=R2VLeOTOYRd4LZ+wxfRIz5wt9B2uW4e9zZUeCg2zcXI=;
 b=MY+aTmpKunYmnnLHQnNitpMU1GZmo301jrdFJMRKjil9bvKyJi0jSGy96180vKuRa4XFmEVAnQybgLwX256HxAT3pdJhA8zm9UDv/LMLp7TM5goZQ0ksE7gJ1qg0Niqbjc0N2BmyYP0NbnBCIqAl+nixULNLCooVFjUEsWk2eKg=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R381e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NarA3_1712910548; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NarA3_1712910548) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 16:29:09 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 25/65] target/riscv: Add integer divide instructions for
 XTheadVector
Date: Fri, 12 Apr 2024 15:36:55 +0800
Message-ID: <20240412073735.76413-26-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
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
 target/riscv/helper.h                         | 33 +++++++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 18 +++--
 target/riscv/xtheadvector_helper.c            | 74 +++++++++++++++++++
 3 files changed, 117 insertions(+), 8 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index e678dd5385..3d5ad2847e 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1761,3 +1761,36 @@ DEF_HELPER_6(th_vmulhsu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vmulhsu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vmulhsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vmulhsu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(th_vdivu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vdivu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vdivu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vdivu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vdiv_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vdiv_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vdiv_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vdiv_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vremu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vremu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vremu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vremu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vrem_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vrem_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vrem_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vrem_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vdivu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vdivu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vdivu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vdivu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vdiv_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vdiv_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vdiv_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vdiv_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vremu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vremu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vremu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vremu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vrem_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vrem_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vrem_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vrem_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 15f36ba98a..a609b7faf3 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -1539,20 +1539,22 @@ GEN_OPIVX_TRANS_TH(th_vmulh_vx, opivx_check_th)
 GEN_OPIVX_TRANS_TH(th_vmulhu_vx, opivx_check_th)
 GEN_OPIVX_TRANS_TH(th_vmulhsu_vx, opivx_check_th)
 
+/* Vector Integer Divide Instructions */
+GEN_OPIVV_TRANS_TH(th_vdivu_vv, opivv_check_th)
+GEN_OPIVV_TRANS_TH(th_vdiv_vv, opivv_check_th)
+GEN_OPIVV_TRANS_TH(th_vremu_vv, opivv_check_th)
+GEN_OPIVV_TRANS_TH(th_vrem_vv, opivv_check_th)
+GEN_OPIVX_TRANS_TH(th_vdivu_vx, opivx_check_th)
+GEN_OPIVX_TRANS_TH(th_vdiv_vx, opivx_check_th)
+GEN_OPIVX_TRANS_TH(th_vremu_vx, opivx_check_th)
+GEN_OPIVX_TRANS_TH(th_vrem_vx, opivx_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vdivu_vv)
-TH_TRANS_STUB(th_vdivu_vx)
-TH_TRANS_STUB(th_vdiv_vv)
-TH_TRANS_STUB(th_vdiv_vx)
-TH_TRANS_STUB(th_vremu_vv)
-TH_TRANS_STUB(th_vremu_vx)
-TH_TRANS_STUB(th_vrem_vv)
-TH_TRANS_STUB(th_vrem_vx)
 TH_TRANS_STUB(th_vwmulu_vv)
 TH_TRANS_STUB(th_vwmulu_vx)
 TH_TRANS_STUB(th_vwmulsu_vv)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 9d8129750c..4af66b047a 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -1678,3 +1678,77 @@ GEN_TH_VX(th_vmulhsu_vx_b, 1, 1, clearb_th)
 GEN_TH_VX(th_vmulhsu_vx_h, 2, 2, clearh_th)
 GEN_TH_VX(th_vmulhsu_vx_w, 4, 4, clearl_th)
 GEN_TH_VX(th_vmulhsu_vx_d, 8, 8, clearq_th)
+
+/* Vector Integer Divide Instructions */
+#define TH_DIVU(N, M) (unlikely(M == 0) ? (__typeof(N))(-1) : N / M)
+#define TH_REMU(N, M) (unlikely(M == 0) ? N : N % M)
+#define TH_DIV(N, M)  (unlikely(M == 0) ? (__typeof(N))(-1) :\
+        unlikely((N == -N) && (M == (__typeof(N))(-1))) ? N : N / M)
+#define TH_REM(N, M)  (unlikely(M == 0) ? N :\
+        unlikely((N == -N) && (M == (__typeof(N))(-1))) ? 0 : N % M)
+
+THCALL(TH_OPIVV2, th_vdivu_vv_b, OP_UUU_B, H1, H1, H1, TH_DIVU)
+THCALL(TH_OPIVV2, th_vdivu_vv_h, OP_UUU_H, H2, H2, H2, TH_DIVU)
+THCALL(TH_OPIVV2, th_vdivu_vv_w, OP_UUU_W, H4, H4, H4, TH_DIVU)
+THCALL(TH_OPIVV2, th_vdivu_vv_d, OP_UUU_D, H8, H8, H8, TH_DIVU)
+THCALL(TH_OPIVV2, th_vdiv_vv_b, OP_SSS_B, H1, H1, H1, TH_DIV)
+THCALL(TH_OPIVV2, th_vdiv_vv_h, OP_SSS_H, H2, H2, H2, TH_DIV)
+THCALL(TH_OPIVV2, th_vdiv_vv_w, OP_SSS_W, H4, H4, H4, TH_DIV)
+THCALL(TH_OPIVV2, th_vdiv_vv_d, OP_SSS_D, H8, H8, H8, TH_DIV)
+THCALL(TH_OPIVV2, th_vremu_vv_b, OP_UUU_B, H1, H1, H1, TH_REMU)
+THCALL(TH_OPIVV2, th_vremu_vv_h, OP_UUU_H, H2, H2, H2, TH_REMU)
+THCALL(TH_OPIVV2, th_vremu_vv_w, OP_UUU_W, H4, H4, H4, TH_REMU)
+THCALL(TH_OPIVV2, th_vremu_vv_d, OP_UUU_D, H8, H8, H8, TH_REMU)
+THCALL(TH_OPIVV2, th_vrem_vv_b, OP_SSS_B, H1, H1, H1, TH_REM)
+THCALL(TH_OPIVV2, th_vrem_vv_h, OP_SSS_H, H2, H2, H2, TH_REM)
+THCALL(TH_OPIVV2, th_vrem_vv_w, OP_SSS_W, H4, H4, H4, TH_REM)
+THCALL(TH_OPIVV2, th_vrem_vv_d, OP_SSS_D, H8, H8, H8, TH_REM)
+GEN_TH_VV(th_vdivu_vv_b, 1, 1, clearb_th)
+GEN_TH_VV(th_vdivu_vv_h, 2, 2, clearh_th)
+GEN_TH_VV(th_vdivu_vv_w, 4, 4, clearl_th)
+GEN_TH_VV(th_vdivu_vv_d, 8, 8, clearq_th)
+GEN_TH_VV(th_vdiv_vv_b, 1, 1, clearb_th)
+GEN_TH_VV(th_vdiv_vv_h, 2, 2, clearh_th)
+GEN_TH_VV(th_vdiv_vv_w, 4, 4, clearl_th)
+GEN_TH_VV(th_vdiv_vv_d, 8, 8, clearq_th)
+GEN_TH_VV(th_vremu_vv_b, 1, 1, clearb_th)
+GEN_TH_VV(th_vremu_vv_h, 2, 2, clearh_th)
+GEN_TH_VV(th_vremu_vv_w, 4, 4, clearl_th)
+GEN_TH_VV(th_vremu_vv_d, 8, 8, clearq_th)
+GEN_TH_VV(th_vrem_vv_b, 1, 1, clearb_th)
+GEN_TH_VV(th_vrem_vv_h, 2, 2, clearh_th)
+GEN_TH_VV(th_vrem_vv_w, 4, 4, clearl_th)
+GEN_TH_VV(th_vrem_vv_d, 8, 8, clearq_th)
+
+THCALL(TH_OPIVX2, th_vdivu_vx_b, OP_UUU_B, H1, H1, TH_DIVU)
+THCALL(TH_OPIVX2, th_vdivu_vx_h, OP_UUU_H, H2, H2, TH_DIVU)
+THCALL(TH_OPIVX2, th_vdivu_vx_w, OP_UUU_W, H4, H4, TH_DIVU)
+THCALL(TH_OPIVX2, th_vdivu_vx_d, OP_UUU_D, H8, H8, TH_DIVU)
+THCALL(TH_OPIVX2, th_vdiv_vx_b, OP_SSS_B, H1, H1, TH_DIV)
+THCALL(TH_OPIVX2, th_vdiv_vx_h, OP_SSS_H, H2, H2, TH_DIV)
+THCALL(TH_OPIVX2, th_vdiv_vx_w, OP_SSS_W, H4, H4, TH_DIV)
+THCALL(TH_OPIVX2, th_vdiv_vx_d, OP_SSS_D, H8, H8, TH_DIV)
+THCALL(TH_OPIVX2, th_vremu_vx_b, OP_UUU_B, H1, H1, TH_REMU)
+THCALL(TH_OPIVX2, th_vremu_vx_h, OP_UUU_H, H2, H2, TH_REMU)
+THCALL(TH_OPIVX2, th_vremu_vx_w, OP_UUU_W, H4, H4, TH_REMU)
+THCALL(TH_OPIVX2, th_vremu_vx_d, OP_UUU_D, H8, H8, TH_REMU)
+THCALL(TH_OPIVX2, th_vrem_vx_b, OP_SSS_B, H1, H1, TH_REM)
+THCALL(TH_OPIVX2, th_vrem_vx_h, OP_SSS_H, H2, H2, TH_REM)
+THCALL(TH_OPIVX2, th_vrem_vx_w, OP_SSS_W, H4, H4, TH_REM)
+THCALL(TH_OPIVX2, th_vrem_vx_d, OP_SSS_D, H8, H8, TH_REM)
+GEN_TH_VX(th_vdivu_vx_b, 1, 1, clearb_th)
+GEN_TH_VX(th_vdivu_vx_h, 2, 2, clearh_th)
+GEN_TH_VX(th_vdivu_vx_w, 4, 4, clearl_th)
+GEN_TH_VX(th_vdivu_vx_d, 8, 8, clearq_th)
+GEN_TH_VX(th_vdiv_vx_b, 1, 1, clearb_th)
+GEN_TH_VX(th_vdiv_vx_h, 2, 2, clearh_th)
+GEN_TH_VX(th_vdiv_vx_w, 4, 4, clearl_th)
+GEN_TH_VX(th_vdiv_vx_d, 8, 8, clearq_th)
+GEN_TH_VX(th_vremu_vx_b, 1, 1, clearb_th)
+GEN_TH_VX(th_vremu_vx_h, 2, 2, clearh_th)
+GEN_TH_VX(th_vremu_vx_w, 4, 4, clearl_th)
+GEN_TH_VX(th_vremu_vx_d, 8, 8, clearq_th)
+GEN_TH_VX(th_vrem_vx_b, 1, 1, clearb_th)
+GEN_TH_VX(th_vrem_vx_h, 2, 2, clearh_th)
+GEN_TH_VX(th_vrem_vx_w, 4, 4, clearl_th)
+GEN_TH_VX(th_vrem_vx_d, 8, 8, clearq_th)
-- 
2.44.0


