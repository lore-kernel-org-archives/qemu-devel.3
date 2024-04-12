Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F82C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvChA-0006AW-0h; Fri, 12 Apr 2024 04:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCh6-00069P-CR; Fri, 12 Apr 2024 04:55:36 -0400
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCh3-0006Oq-T7; Fri, 12 Apr 2024 04:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712912129; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=RhMedefveBKypwSrPdvtto1wZmstSaKCZtiSNPSjXc8=;
 b=XKEFb0fTYu11fWc9MjysrlKA5juvWhiKxR6NxsAUmIP/qQYua/6d913oCxLWfrXA+D2dkU70uwbJJVxUfc8T0lh5uH+ktKD9vUeAMbiOebTHmaOzOi/A6DEq/pFMLZzbsBTOznPpDyviOLIfs1Rfhwb2r5/7rL86ufWVEQ8GtnE=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NgW78_1712912127; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NgW78_1712912127) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 16:55:28 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 38/65] target/riscv: Add single-width floating-point
 multiply/divide instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:37:08 +0800
Message-ID: <20240412073735.76413-39-eric.huang@linux.alibaba.com>
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
 target/riscv/helper.h                         | 16 +++++++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 12 ++++---
 target/riscv/vector_helper.c                  |  6 ++--
 target/riscv/vector_internals.h               |  4 +++
 target/riscv/xtheadvector_helper.c            | 34 +++++++++++++++++++
 5 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 21916e9e3c..f63239676a 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -2029,3 +2029,19 @@ DEF_HELPER_6(th_vfwadd_wf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(th_vfwadd_wf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(th_vfwsub_wf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(th_vfwsub_wf_w, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_6(th_vfmul_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfmul_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfmul_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfdiv_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfdiv_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfdiv_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfmul_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfmul_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfmul_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfdiv_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfdiv_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfdiv_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfrdiv_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfrdiv_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfrdiv_vf_d, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 64d7a7fb76..940b212f5e 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -2008,17 +2008,19 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
 GEN_OPFWF_WIDEN_TRANS_TH(th_vfwadd_wf)
 GEN_OPFWF_WIDEN_TRANS_TH(th_vfwsub_wf)
 
+/* Vector Single-Width Floating-Point Multiply/Divide Instructions */
+GEN_OPFVV_TRANS_TH(th_vfmul_vv, opfvv_check_th)
+GEN_OPFVV_TRANS_TH(th_vfdiv_vv, opfvv_check_th)
+GEN_OPFVF_TRANS_TH(th_vfmul_vf,  opfvf_check_th)
+GEN_OPFVF_TRANS_TH(th_vfdiv_vf,  opfvf_check_th)
+GEN_OPFVF_TRANS_TH(th_vfrdiv_vf,  opfvf_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vfmul_vv)
-TH_TRANS_STUB(th_vfmul_vf)
-TH_TRANS_STUB(th_vfdiv_vv)
-TH_TRANS_STUB(th_vfdiv_vf)
-TH_TRANS_STUB(th_vfrdiv_vf)
 TH_TRANS_STUB(th_vfwmul_vv)
 TH_TRANS_STUB(th_vfwmul_vf)
 TH_TRANS_STUB(th_vfmacc_vv)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 6d0358876a..d65b32c584 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3036,17 +3036,17 @@ GEN_VEXT_VF(vfdiv_vf_h, 2)
 GEN_VEXT_VF(vfdiv_vf_w, 4)
 GEN_VEXT_VF(vfdiv_vf_d, 8)
 
-static uint16_t float16_rdiv(uint16_t a, uint16_t b, float_status *s)
+uint16_t float16_rdiv(uint16_t a, uint16_t b, float_status *s)
 {
     return float16_div(b, a, s);
 }
 
-static uint32_t float32_rdiv(uint32_t a, uint32_t b, float_status *s)
+uint32_t float32_rdiv(uint32_t a, uint32_t b, float_status *s)
 {
     return float32_div(b, a, s);
 }
 
-static uint64_t float64_rdiv(uint64_t a, uint64_t b, float_status *s)
+uint64_t float64_rdiv(uint64_t a, uint64_t b, float_status *s)
 {
     return float64_div(b, a, s);
 }
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index 0786f5a4e1..29263c6a53 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -353,4 +353,8 @@ uint64_t vfwaddw32(uint64_t a, uint32_t b, float_status *s);
 uint32_t vfwsubw16(uint32_t a, uint16_t b, float_status *s);
 uint64_t vfwsubw32(uint64_t a, uint32_t b, float_status *s);
 
+uint16_t float16_rdiv(uint16_t a, uint16_t b, float_status *s);
+uint32_t float32_rdiv(uint32_t a, uint32_t b, float_status *s);
+uint64_t float64_rdiv(uint64_t a, uint64_t b, float_status *s);
+
 #endif /* TARGET_RISCV_VECTOR_INTERNALS_H */
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index cab489a4ae..770f36346f 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -2734,3 +2734,37 @@ THCALL(TH_OPFVF2, th_vfwsub_wf_h, WOP_WUUU_H, H4, H2, vfwsubw16)
 THCALL(TH_OPFVF2, th_vfwsub_wf_w, WOP_WUUU_W, H8, H4, vfwsubw32)
 GEN_TH_VF(th_vfwsub_wf_h, 2, 4, clearl_th)
 GEN_TH_VF(th_vfwsub_wf_w, 4, 8, clearq_th)
+
+/* Vector Single-Width Floating-Point Multiply/Divide Instructions */
+THCALL(TH_OPFVV2, th_vfmul_vv_h, OP_UUU_H, H2, H2, H2, float16_mul)
+THCALL(TH_OPFVV2, th_vfmul_vv_w, OP_UUU_W, H4, H4, H4, float32_mul)
+THCALL(TH_OPFVV2, th_vfmul_vv_d, OP_UUU_D, H8, H8, H8, float64_mul)
+GEN_TH_VV_ENV(th_vfmul_vv_h, 2, 2, clearh_th)
+GEN_TH_VV_ENV(th_vfmul_vv_w, 4, 4, clearl_th)
+GEN_TH_VV_ENV(th_vfmul_vv_d, 8, 8, clearq_th)
+THCALL(TH_OPFVF2, th_vfmul_vf_h, OP_UUU_H, H2, H2, float16_mul)
+THCALL(TH_OPFVF2, th_vfmul_vf_w, OP_UUU_W, H4, H4, float32_mul)
+THCALL(TH_OPFVF2, th_vfmul_vf_d, OP_UUU_D, H8, H8, float64_mul)
+GEN_TH_VF(th_vfmul_vf_h, 2, 2, clearh_th)
+GEN_TH_VF(th_vfmul_vf_w, 4, 4, clearl_th)
+GEN_TH_VF(th_vfmul_vf_d, 8, 8, clearq_th)
+
+THCALL(TH_OPFVV2, th_vfdiv_vv_h, OP_UUU_H, H2, H2, H2, float16_div)
+THCALL(TH_OPFVV2, th_vfdiv_vv_w, OP_UUU_W, H4, H4, H4, float32_div)
+THCALL(TH_OPFVV2, th_vfdiv_vv_d, OP_UUU_D, H8, H8, H8, float64_div)
+GEN_TH_VV_ENV(th_vfdiv_vv_h, 2, 2, clearh_th)
+GEN_TH_VV_ENV(th_vfdiv_vv_w, 4, 4, clearl_th)
+GEN_TH_VV_ENV(th_vfdiv_vv_d, 8, 8, clearq_th)
+THCALL(TH_OPFVF2, th_vfdiv_vf_h, OP_UUU_H, H2, H2, float16_div)
+THCALL(TH_OPFVF2, th_vfdiv_vf_w, OP_UUU_W, H4, H4, float32_div)
+THCALL(TH_OPFVF2, th_vfdiv_vf_d, OP_UUU_D, H8, H8, float64_div)
+GEN_TH_VF(th_vfdiv_vf_h, 2, 2, clearh_th)
+GEN_TH_VF(th_vfdiv_vf_w, 4, 4, clearl_th)
+GEN_TH_VF(th_vfdiv_vf_d, 8, 8, clearq_th)
+
+THCALL(TH_OPFVF2, th_vfrdiv_vf_h, OP_UUU_H, H2, H2, float16_rdiv)
+THCALL(TH_OPFVF2, th_vfrdiv_vf_w, OP_UUU_W, H4, H4, float32_rdiv)
+THCALL(TH_OPFVF2, th_vfrdiv_vf_d, OP_UUU_D, H8, H8, float64_rdiv)
+GEN_TH_VF(th_vfrdiv_vf_h, 2, 2, clearh_th)
+GEN_TH_VF(th_vfrdiv_vf_w, 4, 4, clearl_th)
+GEN_TH_VF(th_vfrdiv_vf_d, 8, 8, clearq_th)
-- 
2.44.0


