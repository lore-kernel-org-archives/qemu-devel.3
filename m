Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815D0C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvCLd-0002YV-Vb; Fri, 12 Apr 2024 04:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCLb-0002YB-CR; Fri, 12 Apr 2024 04:33:23 -0400
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCLY-0001Ox-9G; Fri, 12 Apr 2024 04:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712910792; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=1ju8qwYBWtviK5bZttluimjs+DUO08y/3B/TO2LfaVU=;
 b=bqeUpNRrIGfNh7wiDJdsrlDm7NXtpwnNuGNyVnJEm9ioXSCJHg0TMH8Jg7vrXibe4DReiQkI7Eq6zFCz3crwqr36z082eTljrFBwPu5B4qUqF7Ww61dBQelUhC/Sr1TH/YC8WogJtKbtsrNVGwszDTN7FMGdhXiloV8neom7S2E=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4Nasex_1712910791; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4Nasex_1712910791) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 16:33:12 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 27/65] target/riscv: Add single-width integer multiply-add
 instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:36:57 +0800
Message-ID: <20240412073735.76413-28-eric.huang@linux.alibaba.com>
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

The instructions have the same function as RVV1.0. Overall there are only
general differences between XTheadVector and RVV1.0.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         | 33 +++++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 18 ++--
 target/riscv/xtheadvector_helper.c            | 87 +++++++++++++++++++
 3 files changed, 130 insertions(+), 8 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 93e6a3f33d..a6abb48b55 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1813,3 +1813,36 @@ DEF_HELPER_6(th_vwmulu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vwmulsu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vwmulsu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vwmulsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(th_vmacc_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmacc_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vnmsac_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vnmsac_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vnmsac_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vnmsac_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmadd_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmadd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vnmsub_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vnmsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vnmsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vnmsub_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmacc_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmacc_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmacc_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmacc_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vnmsac_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vnmsac_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vnmsac_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vnmsac_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmadd_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmadd_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmadd_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmadd_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vnmsub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vnmsub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vnmsub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vnmsub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 681e967078..d84edd90ca 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -1557,20 +1557,22 @@ GEN_OPIVX_WIDEN_TRANS_TH(th_vwmul_vx, opivx_widen_check_th)
 GEN_OPIVX_WIDEN_TRANS_TH(th_vwmulu_vx, opivx_widen_check_th)
 GEN_OPIVX_WIDEN_TRANS_TH(th_vwmulsu_vx, opivx_widen_check_th)
 
+/* Vector Single-Width Integer Multiply-Add Instructions */
+GEN_OPIVV_TRANS_TH(th_vmacc_vv, opivv_check_th)
+GEN_OPIVV_TRANS_TH(th_vnmsac_vv, opivv_check_th)
+GEN_OPIVV_TRANS_TH(th_vmadd_vv, opivv_check_th)
+GEN_OPIVV_TRANS_TH(th_vnmsub_vv, opivv_check_th)
+GEN_OPIVX_TRANS_TH(th_vmacc_vx, opivx_check_th)
+GEN_OPIVX_TRANS_TH(th_vnmsac_vx, opivx_check_th)
+GEN_OPIVX_TRANS_TH(th_vmadd_vx, opivx_check_th)
+GEN_OPIVX_TRANS_TH(th_vnmsub_vx, opivx_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vmacc_vv)
-TH_TRANS_STUB(th_vmacc_vx)
-TH_TRANS_STUB(th_vnmsac_vv)
-TH_TRANS_STUB(th_vnmsac_vx)
-TH_TRANS_STUB(th_vmadd_vv)
-TH_TRANS_STUB(th_vmadd_vx)
-TH_TRANS_STUB(th_vnmsub_vv)
-TH_TRANS_STUB(th_vnmsub_vx)
 TH_TRANS_STUB(th_vwmaccu_vv)
 TH_TRANS_STUB(th_vwmaccu_vx)
 TH_TRANS_STUB(th_vwmacc_vv)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index b5b1e55452..ccf6eb8a43 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -1791,3 +1791,90 @@ GEN_TH_VX(th_vwmulu_vx_w, 4, 8, clearq_th)
 GEN_TH_VX(th_vwmulsu_vx_b, 1, 2, clearh_th)
 GEN_TH_VX(th_vwmulsu_vx_h, 2, 4, clearl_th)
 GEN_TH_VX(th_vwmulsu_vx_w, 4, 8, clearq_th)
+
+/* Vector Single-Width Integer Multiply-Add Instructions */
+#define TH_OPIVV3(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP)   \
+static void do_##NAME(void *vd, void *vs1, void *vs2, int i)       \
+{                                                                  \
+    TX1 s1 = *((T1 *)vs1 + HS1(i));                                \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                                \
+    TD d = *((TD *)vd + HD(i));                                    \
+    *((TD *)vd + HD(i)) = OP(s2, s1, d);                           \
+}
+#define TH_MACC(N, M, D) (M * N + D)
+#define TH_NMSAC(N, M, D) (-(M * N) + D)
+#define TH_MADD(N, M, D) (M * D + N)
+#define TH_NMSUB(N, M, D) (-(M * D) + N)
+THCALL(TH_OPIVV3, th_vmacc_vv_b, OP_SSS_B, H1, H1, H1, TH_MACC)
+THCALL(TH_OPIVV3, th_vmacc_vv_h, OP_SSS_H, H2, H2, H2, TH_MACC)
+THCALL(TH_OPIVV3, th_vmacc_vv_w, OP_SSS_W, H4, H4, H4, TH_MACC)
+THCALL(TH_OPIVV3, th_vmacc_vv_d, OP_SSS_D, H8, H8, H8, TH_MACC)
+THCALL(TH_OPIVV3, th_vnmsac_vv_b, OP_SSS_B, H1, H1, H1, TH_NMSAC)
+THCALL(TH_OPIVV3, th_vnmsac_vv_h, OP_SSS_H, H2, H2, H2, TH_NMSAC)
+THCALL(TH_OPIVV3, th_vnmsac_vv_w, OP_SSS_W, H4, H4, H4, TH_NMSAC)
+THCALL(TH_OPIVV3, th_vnmsac_vv_d, OP_SSS_D, H8, H8, H8, TH_NMSAC)
+THCALL(TH_OPIVV3, th_vmadd_vv_b, OP_SSS_B, H1, H1, H1, TH_MADD)
+THCALL(TH_OPIVV3, th_vmadd_vv_h, OP_SSS_H, H2, H2, H2, TH_MADD)
+THCALL(TH_OPIVV3, th_vmadd_vv_w, OP_SSS_W, H4, H4, H4, TH_MADD)
+THCALL(TH_OPIVV3, th_vmadd_vv_d, OP_SSS_D, H8, H8, H8, TH_MADD)
+THCALL(TH_OPIVV3, th_vnmsub_vv_b, OP_SSS_B, H1, H1, H1, TH_NMSUB)
+THCALL(TH_OPIVV3, th_vnmsub_vv_h, OP_SSS_H, H2, H2, H2, TH_NMSUB)
+THCALL(TH_OPIVV3, th_vnmsub_vv_w, OP_SSS_W, H4, H4, H4, TH_NMSUB)
+THCALL(TH_OPIVV3, th_vnmsub_vv_d, OP_SSS_D, H8, H8, H8, TH_NMSUB)
+GEN_TH_VV(th_vmacc_vv_b, 1, 1, clearb_th)
+GEN_TH_VV(th_vmacc_vv_h, 2, 2, clearh_th)
+GEN_TH_VV(th_vmacc_vv_w, 4, 4, clearl_th)
+GEN_TH_VV(th_vmacc_vv_d, 8, 8, clearq_th)
+GEN_TH_VV(th_vnmsac_vv_b, 1, 1, clearb_th)
+GEN_TH_VV(th_vnmsac_vv_h, 2, 2, clearh_th)
+GEN_TH_VV(th_vnmsac_vv_w, 4, 4, clearl_th)
+GEN_TH_VV(th_vnmsac_vv_d, 8, 8, clearq_th)
+GEN_TH_VV(th_vmadd_vv_b, 1, 1, clearb_th)
+GEN_TH_VV(th_vmadd_vv_h, 2, 2, clearh_th)
+GEN_TH_VV(th_vmadd_vv_w, 4, 4, clearl_th)
+GEN_TH_VV(th_vmadd_vv_d, 8, 8, clearq_th)
+GEN_TH_VV(th_vnmsub_vv_b, 1, 1, clearb_th)
+GEN_TH_VV(th_vnmsub_vv_h, 2, 2, clearh_th)
+GEN_TH_VV(th_vnmsub_vv_w, 4, 4, clearl_th)
+GEN_TH_VV(th_vnmsub_vv_d, 8, 8, clearq_th)
+
+#define TH_OPIVX3(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)             \
+static void do_##NAME(void *vd, target_long s1, void *vs2, int i)   \
+{                                                                   \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
+    TD d = *((TD *)vd + HD(i));                                     \
+    *((TD *)vd + HD(i)) = OP(s2, (TX1)(T1)s1, d);                   \
+}
+
+THCALL(TH_OPIVX3, th_vmacc_vx_b, OP_SSS_B, H1, H1, TH_MACC)
+THCALL(TH_OPIVX3, th_vmacc_vx_h, OP_SSS_H, H2, H2, TH_MACC)
+THCALL(TH_OPIVX3, th_vmacc_vx_w, OP_SSS_W, H4, H4, TH_MACC)
+THCALL(TH_OPIVX3, th_vmacc_vx_d, OP_SSS_D, H8, H8, TH_MACC)
+THCALL(TH_OPIVX3, th_vnmsac_vx_b, OP_SSS_B, H1, H1, TH_NMSAC)
+THCALL(TH_OPIVX3, th_vnmsac_vx_h, OP_SSS_H, H2, H2, TH_NMSAC)
+THCALL(TH_OPIVX3, th_vnmsac_vx_w, OP_SSS_W, H4, H4, TH_NMSAC)
+THCALL(TH_OPIVX3, th_vnmsac_vx_d, OP_SSS_D, H8, H8, TH_NMSAC)
+THCALL(TH_OPIVX3, th_vmadd_vx_b, OP_SSS_B, H1, H1, TH_MADD)
+THCALL(TH_OPIVX3, th_vmadd_vx_h, OP_SSS_H, H2, H2, TH_MADD)
+THCALL(TH_OPIVX3, th_vmadd_vx_w, OP_SSS_W, H4, H4, TH_MADD)
+THCALL(TH_OPIVX3, th_vmadd_vx_d, OP_SSS_D, H8, H8, TH_MADD)
+THCALL(TH_OPIVX3, th_vnmsub_vx_b, OP_SSS_B, H1, H1, TH_NMSUB)
+THCALL(TH_OPIVX3, th_vnmsub_vx_h, OP_SSS_H, H2, H2, TH_NMSUB)
+THCALL(TH_OPIVX3, th_vnmsub_vx_w, OP_SSS_W, H4, H4, TH_NMSUB)
+THCALL(TH_OPIVX3, th_vnmsub_vx_d, OP_SSS_D, H8, H8, TH_NMSUB)
+GEN_TH_VX(th_vmacc_vx_b, 1, 1, clearb_th)
+GEN_TH_VX(th_vmacc_vx_h, 2, 2, clearh_th)
+GEN_TH_VX(th_vmacc_vx_w, 4, 4, clearl_th)
+GEN_TH_VX(th_vmacc_vx_d, 8, 8, clearq_th)
+GEN_TH_VX(th_vnmsac_vx_b, 1, 1, clearb_th)
+GEN_TH_VX(th_vnmsac_vx_h, 2, 2, clearh_th)
+GEN_TH_VX(th_vnmsac_vx_w, 4, 4, clearl_th)
+GEN_TH_VX(th_vnmsac_vx_d, 8, 8, clearq_th)
+GEN_TH_VX(th_vmadd_vx_b, 1, 1, clearb_th)
+GEN_TH_VX(th_vmadd_vx_h, 2, 2, clearh_th)
+GEN_TH_VX(th_vmadd_vx_w, 4, 4, clearl_th)
+GEN_TH_VX(th_vmadd_vx_d, 8, 8, clearq_th)
+GEN_TH_VX(th_vnmsub_vx_b, 1, 1, clearb_th)
+GEN_TH_VX(th_vnmsub_vx_h, 2, 2, clearh_th)
+GEN_TH_VX(th_vnmsub_vx_w, 4, 4, clearl_th)
+GEN_TH_VX(th_vnmsub_vx_d, 8, 8, clearq_th)
-- 
2.44.0


