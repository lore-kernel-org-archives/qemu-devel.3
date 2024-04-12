Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365D0C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvCJl-0001gO-JJ; Fri, 12 Apr 2024 04:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCJj-0001ft-J7; Fri, 12 Apr 2024 04:31:27 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCJf-0000se-4W; Fri, 12 Apr 2024 04:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712910672; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=Cet7U4bxzdatnKI+ukDBeStaMpJT25FiLg6Jf4qTISM=;
 b=saExLYIVHK4SPOfXdP76/8X44lyxVVWX0BvGhL+QGJgoK8xJlCLq6gXEMlqVm3khHWyQwInnrYj65im7X6CLOTvG4WTkdNX7EJGb4MwEiArnupOMHWwSp9zvwZ9v9aoiY9pWDU/KjQYuFiGpDbd2v2TltGYRsMMrsdB14tKx+JE=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R491e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NbCCo_1712910670; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NbCCo_1712910670) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 16:31:10 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 26/65] target/riscv: Add widening integer multiply
 instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:36:56 +0800
Message-ID: <20240412073735.76413-27-eric.huang@linux.alibaba.com>
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

The instructions have the same function as RVV1.0. Overall there are only
general differences between XTheadVector and RVV1.0.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         | 19 +++++++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 14 ++++---
 target/riscv/vector_helper.c                  |  3 --
 target/riscv/vector_internals.h               |  3 ++
 target/riscv/xtheadvector_helper.c            | 39 +++++++++++++++++++
 5 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 3d5ad2847e..93e6a3f33d 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1794,3 +1794,22 @@ DEF_HELPER_6(th_vrem_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vrem_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vrem_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vrem_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(th_vwmul_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwmul_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwmul_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwmulu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwmulu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwmulu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwmulsu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwmulsu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwmulsu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwmul_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwmul_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwmul_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwmulu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwmulu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwmulu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwmulsu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwmulsu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwmulsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index a609b7faf3..681e967078 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -1549,18 +1549,20 @@ GEN_OPIVX_TRANS_TH(th_vdiv_vx, opivx_check_th)
 GEN_OPIVX_TRANS_TH(th_vremu_vx, opivx_check_th)
 GEN_OPIVX_TRANS_TH(th_vrem_vx, opivx_check_th)
 
+/* Vector Widening Integer Multiply Instructions */
+GEN_OPIVV_WIDEN_TRANS_TH(th_vwmul_vv, opivv_widen_check_th)
+GEN_OPIVV_WIDEN_TRANS_TH(th_vwmulu_vv, opivv_widen_check_th)
+GEN_OPIVV_WIDEN_TRANS_TH(th_vwmulsu_vv, opivv_widen_check_th)
+GEN_OPIVX_WIDEN_TRANS_TH(th_vwmul_vx, opivx_widen_check_th)
+GEN_OPIVX_WIDEN_TRANS_TH(th_vwmulu_vx, opivx_widen_check_th)
+GEN_OPIVX_WIDEN_TRANS_TH(th_vwmulsu_vx, opivx_widen_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vwmulu_vv)
-TH_TRANS_STUB(th_vwmulu_vx)
-TH_TRANS_STUB(th_vwmulsu_vv)
-TH_TRANS_STUB(th_vwmulsu_vx)
-TH_TRANS_STUB(th_vwmul_vv)
-TH_TRANS_STUB(th_vwmul_vx)
 TH_TRANS_STUB(th_vmacc_vv)
 TH_TRANS_STUB(th_vmacc_vx)
 TH_TRANS_STUB(th_vnmsac_vv)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 5aba3f238f..b312d67f87 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -647,9 +647,6 @@ GEN_VEXT_ST_WHOLE(vs8r_v, int8_t, ste_b)
  */
 
 /* (TD, T1, T2, TX1, TX2) */
-#define WOP_SUS_B int16_t, uint8_t, int8_t, uint16_t, int16_t
-#define WOP_SUS_H int32_t, uint16_t, int16_t, uint32_t, int32_t
-#define WOP_SUS_W int64_t, uint32_t, int32_t, uint64_t, int64_t
 #define WOP_SSU_B int16_t, int8_t, uint8_t, int16_t, uint16_t
 #define WOP_SSU_H int32_t, int16_t, uint16_t, int32_t, uint32_t
 #define WOP_SSU_W int64_t, int32_t, uint32_t, int64_t, uint64_t
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index 4cbd7f972a..c3d9752e2e 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -249,6 +249,9 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,    \
 #define WOP_WSSS_B  int16_t, int8_t, int16_t, int16_t, int16_t
 #define WOP_WSSS_H  int32_t, int16_t, int32_t, int32_t, int32_t
 #define WOP_WSSS_W  int64_t, int32_t, int64_t, int64_t, int64_t
+#define WOP_SUS_B int16_t, uint8_t, int8_t, uint16_t, int16_t
+#define WOP_SUS_H int32_t, uint16_t, int16_t, uint32_t, int32_t
+#define WOP_SUS_W int64_t, uint32_t, int32_t, uint64_t, int64_t
 
 /* share functions */
 static inline target_ulong adjust_addr(CPURISCVState *env, target_ulong addr)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 4af66b047a..b5b1e55452 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -1752,3 +1752,42 @@ GEN_TH_VX(th_vrem_vx_b, 1, 1, clearb_th)
 GEN_TH_VX(th_vrem_vx_h, 2, 2, clearh_th)
 GEN_TH_VX(th_vrem_vx_w, 4, 4, clearl_th)
 GEN_TH_VX(th_vrem_vx_d, 8, 8, clearq_th)
+
+/* Vector Widening Integer Multiply Instructions */
+THCALL(TH_OPIVV2, th_vwmul_vv_b, WOP_SSS_B, H2, H1, H1, TH_MUL)
+THCALL(TH_OPIVV2, th_vwmul_vv_h, WOP_SSS_H, H4, H2, H2, TH_MUL)
+THCALL(TH_OPIVV2, th_vwmul_vv_w, WOP_SSS_W, H8, H4, H4, TH_MUL)
+THCALL(TH_OPIVV2, th_vwmulu_vv_b, WOP_UUU_B, H2, H1, H1, TH_MUL)
+THCALL(TH_OPIVV2, th_vwmulu_vv_h, WOP_UUU_H, H4, H2, H2, TH_MUL)
+THCALL(TH_OPIVV2, th_vwmulu_vv_w, WOP_UUU_W, H8, H4, H4, TH_MUL)
+THCALL(TH_OPIVV2, th_vwmulsu_vv_b, WOP_SUS_B, H2, H1, H1, TH_MUL)
+THCALL(TH_OPIVV2, th_vwmulsu_vv_h, WOP_SUS_H, H4, H2, H2, TH_MUL)
+THCALL(TH_OPIVV2, th_vwmulsu_vv_w, WOP_SUS_W, H8, H4, H4, TH_MUL)
+GEN_TH_VV(th_vwmul_vv_b, 1, 2, clearh_th)
+GEN_TH_VV(th_vwmul_vv_h, 2, 4, clearl_th)
+GEN_TH_VV(th_vwmul_vv_w, 4, 8, clearq_th)
+GEN_TH_VV(th_vwmulu_vv_b, 1, 2, clearh_th)
+GEN_TH_VV(th_vwmulu_vv_h, 2, 4, clearl_th)
+GEN_TH_VV(th_vwmulu_vv_w, 4, 8, clearq_th)
+GEN_TH_VV(th_vwmulsu_vv_b, 1, 2, clearh_th)
+GEN_TH_VV(th_vwmulsu_vv_h, 2, 4, clearl_th)
+GEN_TH_VV(th_vwmulsu_vv_w, 4, 8, clearq_th)
+
+THCALL(TH_OPIVX2, th_vwmul_vx_b, WOP_SSS_B, H2, H1, TH_MUL)
+THCALL(TH_OPIVX2, th_vwmul_vx_h, WOP_SSS_H, H4, H2, TH_MUL)
+THCALL(TH_OPIVX2, th_vwmul_vx_w, WOP_SSS_W, H8, H4, TH_MUL)
+THCALL(TH_OPIVX2, th_vwmulu_vx_b, WOP_UUU_B, H2, H1, TH_MUL)
+THCALL(TH_OPIVX2, th_vwmulu_vx_h, WOP_UUU_H, H4, H2, TH_MUL)
+THCALL(TH_OPIVX2, th_vwmulu_vx_w, WOP_UUU_W, H8, H4, TH_MUL)
+THCALL(TH_OPIVX2, th_vwmulsu_vx_b, WOP_SUS_B, H2, H1, TH_MUL)
+THCALL(TH_OPIVX2, th_vwmulsu_vx_h, WOP_SUS_H, H4, H2, TH_MUL)
+THCALL(TH_OPIVX2, th_vwmulsu_vx_w, WOP_SUS_W, H8, H4, TH_MUL)
+GEN_TH_VX(th_vwmul_vx_b, 1, 2, clearh_th)
+GEN_TH_VX(th_vwmul_vx_h, 2, 4, clearl_th)
+GEN_TH_VX(th_vwmul_vx_w, 4, 8, clearq_th)
+GEN_TH_VX(th_vwmulu_vx_b, 1, 2, clearh_th)
+GEN_TH_VX(th_vwmulu_vx_h, 2, 4, clearl_th)
+GEN_TH_VX(th_vwmulu_vx_w, 4, 8, clearq_th)
+GEN_TH_VX(th_vwmulsu_vx_b, 1, 2, clearh_th)
+GEN_TH_VX(th_vwmulsu_vx_h, 2, 4, clearl_th)
+GEN_TH_VX(th_vwmulsu_vx_w, 4, 8, clearq_th)
-- 
2.44.0


