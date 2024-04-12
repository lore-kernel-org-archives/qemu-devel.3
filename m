Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D5CC00A94
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 09:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvD0b-0002ZO-Hc; Fri, 12 Apr 2024 05:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvD0V-0002Yk-Np; Fri, 12 Apr 2024 05:15:40 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvD0M-0001Q4-H5; Fri, 12 Apr 2024 05:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712913319; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=eUWnNkwi46NYpGCTk/QbRjEaR50zY2NyLtuuMrUhs5E=;
 b=SgKW7XKJx7/3pSguqRl0qsInI+znpSMubMFfir2YRuz3gYaS9ZVWwZKhq0T32/mu9DXqKz7J6tgi4FR0FR7GxyvwSGO1u5TdhyKiVdVlQBuUsTMeecL4i+iIzj83ZUF911qZT+RS5uJxttA8FiplfMKiepE29KJ0g+ldQTuFFNk=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R421e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NsVn2_1712913317; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NsVn2_1712913317) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 17:15:18 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 40/65] target/riscv: Add single-width floating-point fused
 multiply-add instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:37:10 +0800
Message-ID: <20240412073735.76413-41-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.133;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-133.freemail.mail.aliyun.com
X-Spam_score_int: -94
X-Spam_score: -9.5
X-Spam_bar: ---------
X-Spam_report: (-9.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01,
 UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
 target/riscv/helper.h                         |  49 +++++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc |  34 ++---
 target/riscv/vector_helper.c                  |  48 +++----
 target/riscv/vector_internals.h               |  25 ++++
 target/riscv/xtheadvector_helper.c            | 125 ++++++++++++++++++
 5 files changed, 241 insertions(+), 40 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 3102b078e4..88e3a18e17 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -2050,3 +2050,52 @@ DEF_HELPER_6(th_vfwmul_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(th_vfwmul_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(th_vfwmul_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(th_vfwmul_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_6(th_vfmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfmacc_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfnmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfnmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfnmacc_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfmsac_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfmsac_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfmsac_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfnmsac_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfnmsac_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfnmsac_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfmadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfmadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfmadd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfnmadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfnmadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfnmadd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfmsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfmsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfmsub_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfnmsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfnmsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfnmsub_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfmacc_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfmacc_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfmacc_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfnmacc_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfnmacc_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfnmacc_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfmsac_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfmsac_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfnmsac_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfnmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfnmsac_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfmadd_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfmadd_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfmadd_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfnmadd_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfnmadd_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfnmadd_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfmsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfmsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfmsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfnmsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfnmsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfnmsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 3d0370f220..af512c489b 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -2019,28 +2019,30 @@ GEN_OPFVF_TRANS_TH(th_vfrdiv_vf,  opfvf_check_th)
 GEN_OPFVV_WIDEN_TRANS_TH(th_vfwmul_vv, opfvv_widen_check_th)
 GEN_OPFVF_WIDEN_TRANS_TH(th_vfwmul_vf)
 
+/* Vector Single-Width Floating-Point Fused Multiply-Add Instructions */
+GEN_OPFVV_TRANS_TH(th_vfmacc_vv, opfvv_check_th)
+GEN_OPFVV_TRANS_TH(th_vfnmacc_vv, opfvv_check_th)
+GEN_OPFVV_TRANS_TH(th_vfmsac_vv, opfvv_check_th)
+GEN_OPFVV_TRANS_TH(th_vfnmsac_vv, opfvv_check_th)
+GEN_OPFVV_TRANS_TH(th_vfmadd_vv, opfvv_check_th)
+GEN_OPFVV_TRANS_TH(th_vfnmadd_vv, opfvv_check_th)
+GEN_OPFVV_TRANS_TH(th_vfmsub_vv, opfvv_check_th)
+GEN_OPFVV_TRANS_TH(th_vfnmsub_vv, opfvv_check_th)
+GEN_OPFVF_TRANS_TH(th_vfmacc_vf, opfvf_check_th)
+GEN_OPFVF_TRANS_TH(th_vfnmacc_vf, opfvf_check_th)
+GEN_OPFVF_TRANS_TH(th_vfmsac_vf, opfvf_check_th)
+GEN_OPFVF_TRANS_TH(th_vfnmsac_vf, opfvf_check_th)
+GEN_OPFVF_TRANS_TH(th_vfmadd_vf, opfvf_check_th)
+GEN_OPFVF_TRANS_TH(th_vfnmadd_vf, opfvf_check_th)
+GEN_OPFVF_TRANS_TH(th_vfmsub_vf, opfvf_check_th)
+GEN_OPFVF_TRANS_TH(th_vfnmsub_vf, opfvf_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vfmacc_vv)
-TH_TRANS_STUB(th_vfnmacc_vv)
-TH_TRANS_STUB(th_vfnmacc_vf)
-TH_TRANS_STUB(th_vfmacc_vf)
-TH_TRANS_STUB(th_vfmsac_vv)
-TH_TRANS_STUB(th_vfmsac_vf)
-TH_TRANS_STUB(th_vfnmsac_vv)
-TH_TRANS_STUB(th_vfnmsac_vf)
-TH_TRANS_STUB(th_vfmadd_vv)
-TH_TRANS_STUB(th_vfmadd_vf)
-TH_TRANS_STUB(th_vfnmadd_vv)
-TH_TRANS_STUB(th_vfnmadd_vf)
-TH_TRANS_STUB(th_vfmsub_vv)
-TH_TRANS_STUB(th_vfmsub_vf)
-TH_TRANS_STUB(th_vfnmsub_vv)
-TH_TRANS_STUB(th_vfnmsub_vf)
 TH_TRANS_STUB(th_vfwmacc_vv)
 TH_TRANS_STUB(th_vfwmacc_vf)
 TH_TRANS_STUB(th_vfwnmacc_vv)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index aa7714d651..165221e08b 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3091,17 +3091,17 @@ static void do_##NAME(void *vd, void *vs1, void *vs2, int i,       \
     *((TD *)vd + HD(i)) = OP(s2, s1, d, &env->fp_status);          \
 }
 
-static uint16_t fmacc16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
+uint16_t fmacc16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
 {
     return float16_muladd(a, b, d, 0, s);
 }
 
-static uint32_t fmacc32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
+uint32_t fmacc32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
 {
     return float32_muladd(a, b, d, 0, s);
 }
 
-static uint64_t fmacc64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
+uint64_t fmacc64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
 {
     return float64_muladd(a, b, d, 0, s);
 }
@@ -3129,19 +3129,19 @@ GEN_VEXT_VF(vfmacc_vf_h, 2)
 GEN_VEXT_VF(vfmacc_vf_w, 4)
 GEN_VEXT_VF(vfmacc_vf_d, 8)
 
-static uint16_t fnmacc16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
+uint16_t fnmacc16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
 {
     return float16_muladd(a, b, d, float_muladd_negate_c |
                                    float_muladd_negate_product, s);
 }
 
-static uint32_t fnmacc32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
+uint32_t fnmacc32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
 {
     return float32_muladd(a, b, d, float_muladd_negate_c |
                                    float_muladd_negate_product, s);
 }
 
-static uint64_t fnmacc64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
+uint64_t fnmacc64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
 {
     return float64_muladd(a, b, d, float_muladd_negate_c |
                                    float_muladd_negate_product, s);
@@ -3160,17 +3160,17 @@ GEN_VEXT_VF(vfnmacc_vf_h, 2)
 GEN_VEXT_VF(vfnmacc_vf_w, 4)
 GEN_VEXT_VF(vfnmacc_vf_d, 8)
 
-static uint16_t fmsac16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
+uint16_t fmsac16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
 {
     return float16_muladd(a, b, d, float_muladd_negate_c, s);
 }
 
-static uint32_t fmsac32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
+uint32_t fmsac32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
 {
     return float32_muladd(a, b, d, float_muladd_negate_c, s);
 }
 
-static uint64_t fmsac64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
+uint64_t fmsac64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
 {
     return float64_muladd(a, b, d, float_muladd_negate_c, s);
 }
@@ -3188,17 +3188,17 @@ GEN_VEXT_VF(vfmsac_vf_h, 2)
 GEN_VEXT_VF(vfmsac_vf_w, 4)
 GEN_VEXT_VF(vfmsac_vf_d, 8)
 
-static uint16_t fnmsac16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
+uint16_t fnmsac16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
 {
     return float16_muladd(a, b, d, float_muladd_negate_product, s);
 }
 
-static uint32_t fnmsac32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
+uint32_t fnmsac32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
 {
     return float32_muladd(a, b, d, float_muladd_negate_product, s);
 }
 
-static uint64_t fnmsac64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
+uint64_t fnmsac64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
 {
     return float64_muladd(a, b, d, float_muladd_negate_product, s);
 }
@@ -3216,17 +3216,17 @@ GEN_VEXT_VF(vfnmsac_vf_h, 2)
 GEN_VEXT_VF(vfnmsac_vf_w, 4)
 GEN_VEXT_VF(vfnmsac_vf_d, 8)
 
-static uint16_t fmadd16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
+uint16_t fmadd16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
 {
     return float16_muladd(d, b, a, 0, s);
 }
 
-static uint32_t fmadd32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
+uint32_t fmadd32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
 {
     return float32_muladd(d, b, a, 0, s);
 }
 
-static uint64_t fmadd64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
+uint64_t fmadd64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
 {
     return float64_muladd(d, b, a, 0, s);
 }
@@ -3244,19 +3244,19 @@ GEN_VEXT_VF(vfmadd_vf_h, 2)
 GEN_VEXT_VF(vfmadd_vf_w, 4)
 GEN_VEXT_VF(vfmadd_vf_d, 8)
 
-static uint16_t fnmadd16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
+uint16_t fnmadd16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
 {
     return float16_muladd(d, b, a, float_muladd_negate_c |
                                    float_muladd_negate_product, s);
 }
 
-static uint32_t fnmadd32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
+uint32_t fnmadd32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
 {
     return float32_muladd(d, b, a, float_muladd_negate_c |
                                    float_muladd_negate_product, s);
 }
 
-static uint64_t fnmadd64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
+uint64_t fnmadd64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
 {
     return float64_muladd(d, b, a, float_muladd_negate_c |
                                    float_muladd_negate_product, s);
@@ -3275,17 +3275,17 @@ GEN_VEXT_VF(vfnmadd_vf_h, 2)
 GEN_VEXT_VF(vfnmadd_vf_w, 4)
 GEN_VEXT_VF(vfnmadd_vf_d, 8)
 
-static uint16_t fmsub16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
+uint16_t fmsub16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
 {
     return float16_muladd(d, b, a, float_muladd_negate_c, s);
 }
 
-static uint32_t fmsub32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
+uint32_t fmsub32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
 {
     return float32_muladd(d, b, a, float_muladd_negate_c, s);
 }
 
-static uint64_t fmsub64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
+uint64_t fmsub64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
 {
     return float64_muladd(d, b, a, float_muladd_negate_c, s);
 }
@@ -3303,17 +3303,17 @@ GEN_VEXT_VF(vfmsub_vf_h, 2)
 GEN_VEXT_VF(vfmsub_vf_w, 4)
 GEN_VEXT_VF(vfmsub_vf_d, 8)
 
-static uint16_t fnmsub16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
+uint16_t fnmsub16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
 {
     return float16_muladd(d, b, a, float_muladd_negate_product, s);
 }
 
-static uint32_t fnmsub32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
+uint32_t fnmsub32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
 {
     return float32_muladd(d, b, a, float_muladd_negate_product, s);
 }
 
-static uint64_t fnmsub64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
+uint64_t fnmsub64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
 {
     return float64_muladd(d, b, a, float_muladd_negate_product, s);
 }
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index 8903a894d7..5733640e0d 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -360,4 +360,29 @@ uint64_t float64_rdiv(uint64_t a, uint64_t b, float_status *s);
 uint32_t vfwmul16(uint16_t a, uint16_t b, float_status *s);
 uint64_t vfwmul32(uint32_t a, uint32_t b, float_status *s);
 
+uint16_t fmacc16(uint16_t a, uint16_t b, uint16_t d, float_status *s);
+uint32_t fmacc32(uint32_t a, uint32_t b, uint32_t d, float_status *s);
+uint64_t fmacc64(uint64_t a, uint64_t b, uint64_t d, float_status *s);
+uint16_t fnmacc16(uint16_t a, uint16_t b, uint16_t d, float_status *s);
+uint32_t fnmacc32(uint32_t a, uint32_t b, uint32_t d, float_status *s);
+uint64_t fnmacc64(uint64_t a, uint64_t b, uint64_t d, float_status *s);
+uint16_t fmsac16(uint16_t a, uint16_t b, uint16_t d, float_status *s);
+uint32_t fmsac32(uint32_t a, uint32_t b, uint32_t d, float_status *s);
+uint64_t fmsac64(uint64_t a, uint64_t b, uint64_t d, float_status *s);
+uint16_t fnmsac16(uint16_t a, uint16_t b, uint16_t d, float_status *s);
+uint32_t fnmsac32(uint32_t a, uint32_t b, uint32_t d, float_status *s);
+uint64_t fnmsac64(uint64_t a, uint64_t b, uint64_t d, float_status *s);
+uint16_t fmadd16(uint16_t a, uint16_t b, uint16_t d, float_status *s);
+uint32_t fmadd32(uint32_t a, uint32_t b, uint32_t d, float_status *s);
+uint64_t fmadd64(uint64_t a, uint64_t b, uint64_t d, float_status *s);
+uint16_t fnmadd16(uint16_t a, uint16_t b, uint16_t d, float_status *s);
+uint32_t fnmadd32(uint32_t a, uint32_t b, uint32_t d, float_status *s);
+uint64_t fnmadd64(uint64_t a, uint64_t b, uint64_t d, float_status *s);
+uint16_t fmsub16(uint16_t a, uint16_t b, uint16_t d, float_status *s);
+uint32_t fmsub32(uint32_t a, uint32_t b, uint32_t d, float_status *s);
+uint64_t fmsub64(uint64_t a, uint64_t b, uint64_t d, float_status *s);
+uint16_t fnmsub16(uint16_t a, uint16_t b, uint16_t d, float_status *s);
+uint32_t fnmsub32(uint32_t a, uint32_t b, uint32_t d, float_status *s);
+uint64_t fnmsub64(uint64_t a, uint64_t b, uint64_t d, float_status *s);
+
 #endif /* TARGET_RISCV_VECTOR_INTERNALS_H */
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index dd01d66933..1d2da6ffb7 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -2779,3 +2779,128 @@ THCALL(TH_OPFVF2, th_vfwmul_vf_h, WOP_UUU_H, H4, H2, vfwmul16)
 THCALL(TH_OPFVF2, th_vfwmul_vf_w, WOP_UUU_W, H8, H4, vfwmul32)
 GEN_TH_VF(th_vfwmul_vf_h, 2, 4, clearl_th)
 GEN_TH_VF(th_vfwmul_vf_w, 4, 8, clearq_th)
+
+/* Vector Single-Width Floating-Point Fused Multiply-Add Instructions */
+#define TH_OPFVV3(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP)    \
+static void do_##NAME(void *vd, void *vs1, void *vs2, int i,       \
+        CPURISCVState *env)                                        \
+{                                                                  \
+    TX1 s1 = *((T1 *)vs1 + HS1(i));                                \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                                \
+    TD d = *((TD *)vd + HD(i));                                    \
+    *((TD *)vd + HD(i)) = OP(s2, s1, d, &env->fp_status);          \
+}
+
+THCALL(TH_OPFVV3, th_vfmacc_vv_h, OP_UUU_H, H2, H2, H2, fmacc16)
+THCALL(TH_OPFVV3, th_vfmacc_vv_w, OP_UUU_W, H4, H4, H4, fmacc32)
+THCALL(TH_OPFVV3, th_vfmacc_vv_d, OP_UUU_D, H8, H8, H8, fmacc64)
+GEN_TH_VV_ENV(th_vfmacc_vv_h, 2, 2, clearh_th)
+GEN_TH_VV_ENV(th_vfmacc_vv_w, 4, 4, clearl_th)
+GEN_TH_VV_ENV(th_vfmacc_vv_d, 8, 8, clearq_th)
+
+#define TH_OPFVF3(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)        \
+static void do_##NAME(void *vd, uint64_t s1, void *vs2, int i,    \
+        CPURISCVState *env)                                       \
+{                                                                 \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                               \
+    TD d = *((TD *)vd + HD(i));                                   \
+    *((TD *)vd + HD(i)) = OP(s2, (TX1)(T1)s1, d, &env->fp_status);\
+}
+
+THCALL(TH_OPFVF3, th_vfmacc_vf_h, OP_UUU_H, H2, H2, fmacc16)
+THCALL(TH_OPFVF3, th_vfmacc_vf_w, OP_UUU_W, H4, H4, fmacc32)
+THCALL(TH_OPFVF3, th_vfmacc_vf_d, OP_UUU_D, H8, H8, fmacc64)
+GEN_TH_VF(th_vfmacc_vf_h, 2, 2, clearh_th)
+GEN_TH_VF(th_vfmacc_vf_w, 4, 4, clearl_th)
+GEN_TH_VF(th_vfmacc_vf_d, 8, 8, clearq_th)
+
+THCALL(TH_OPFVV3, th_vfnmacc_vv_h, OP_UUU_H, H2, H2, H2, fnmacc16)
+THCALL(TH_OPFVV3, th_vfnmacc_vv_w, OP_UUU_W, H4, H4, H4, fnmacc32)
+THCALL(TH_OPFVV3, th_vfnmacc_vv_d, OP_UUU_D, H8, H8, H8, fnmacc64)
+GEN_TH_VV_ENV(th_vfnmacc_vv_h, 2, 2, clearh_th)
+GEN_TH_VV_ENV(th_vfnmacc_vv_w, 4, 4, clearl_th)
+GEN_TH_VV_ENV(th_vfnmacc_vv_d, 8, 8, clearq_th)
+THCALL(TH_OPFVF3, th_vfnmacc_vf_h, OP_UUU_H, H2, H2, fnmacc16)
+THCALL(TH_OPFVF3, th_vfnmacc_vf_w, OP_UUU_W, H4, H4, fnmacc32)
+THCALL(TH_OPFVF3, th_vfnmacc_vf_d, OP_UUU_D, H8, H8, fnmacc64)
+GEN_TH_VF(th_vfnmacc_vf_h, 2, 2, clearh_th)
+GEN_TH_VF(th_vfnmacc_vf_w, 4, 4, clearl_th)
+GEN_TH_VF(th_vfnmacc_vf_d, 8, 8, clearq_th)
+
+THCALL(TH_OPFVV3, th_vfmsac_vv_h, OP_UUU_H, H2, H2, H2, fmsac16)
+THCALL(TH_OPFVV3, th_vfmsac_vv_w, OP_UUU_W, H4, H4, H4, fmsac32)
+THCALL(TH_OPFVV3, th_vfmsac_vv_d, OP_UUU_D, H8, H8, H8, fmsac64)
+GEN_TH_VV_ENV(th_vfmsac_vv_h, 2, 2, clearh_th)
+GEN_TH_VV_ENV(th_vfmsac_vv_w, 4, 4, clearl_th)
+GEN_TH_VV_ENV(th_vfmsac_vv_d, 8, 8, clearq_th)
+THCALL(TH_OPFVF3, th_vfmsac_vf_h, OP_UUU_H, H2, H2, fmsac16)
+THCALL(TH_OPFVF3, th_vfmsac_vf_w, OP_UUU_W, H4, H4, fmsac32)
+THCALL(TH_OPFVF3, th_vfmsac_vf_d, OP_UUU_D, H8, H8, fmsac64)
+GEN_TH_VF(th_vfmsac_vf_h, 2, 2, clearh_th)
+GEN_TH_VF(th_vfmsac_vf_w, 4, 4, clearl_th)
+GEN_TH_VF(th_vfmsac_vf_d, 8, 8, clearq_th)
+
+THCALL(TH_OPFVV3, th_vfnmsac_vv_h, OP_UUU_H, H2, H2, H2, fnmsac16)
+THCALL(TH_OPFVV3, th_vfnmsac_vv_w, OP_UUU_W, H4, H4, H4, fnmsac32)
+THCALL(TH_OPFVV3, th_vfnmsac_vv_d, OP_UUU_D, H8, H8, H8, fnmsac64)
+GEN_TH_VV_ENV(th_vfnmsac_vv_h, 2, 2, clearh_th)
+GEN_TH_VV_ENV(th_vfnmsac_vv_w, 4, 4, clearl_th)
+GEN_TH_VV_ENV(th_vfnmsac_vv_d, 8, 8, clearq_th)
+THCALL(TH_OPFVF3, th_vfnmsac_vf_h, OP_UUU_H, H2, H2, fnmsac16)
+THCALL(TH_OPFVF3, th_vfnmsac_vf_w, OP_UUU_W, H4, H4, fnmsac32)
+THCALL(TH_OPFVF3, th_vfnmsac_vf_d, OP_UUU_D, H8, H8, fnmsac64)
+GEN_TH_VF(th_vfnmsac_vf_h, 2, 2, clearh_th)
+GEN_TH_VF(th_vfnmsac_vf_w, 4, 4, clearl_th)
+GEN_TH_VF(th_vfnmsac_vf_d, 8, 8, clearq_th)
+
+THCALL(TH_OPFVV3, th_vfmadd_vv_h, OP_UUU_H, H2, H2, H2, fmadd16)
+THCALL(TH_OPFVV3, th_vfmadd_vv_w, OP_UUU_W, H4, H4, H4, fmadd32)
+THCALL(TH_OPFVV3, th_vfmadd_vv_d, OP_UUU_D, H8, H8, H8, fmadd64)
+GEN_TH_VV_ENV(th_vfmadd_vv_h, 2, 2, clearh_th)
+GEN_TH_VV_ENV(th_vfmadd_vv_w, 4, 4, clearl_th)
+GEN_TH_VV_ENV(th_vfmadd_vv_d, 8, 8, clearq_th)
+THCALL(TH_OPFVF3, th_vfmadd_vf_h, OP_UUU_H, H2, H2, fmadd16)
+THCALL(TH_OPFVF3, th_vfmadd_vf_w, OP_UUU_W, H4, H4, fmadd32)
+THCALL(TH_OPFVF3, th_vfmadd_vf_d, OP_UUU_D, H8, H8, fmadd64)
+GEN_TH_VF(th_vfmadd_vf_h, 2, 2, clearh_th)
+GEN_TH_VF(th_vfmadd_vf_w, 4, 4, clearl_th)
+GEN_TH_VF(th_vfmadd_vf_d, 8, 8, clearq_th)
+
+THCALL(TH_OPFVV3, th_vfnmadd_vv_h, OP_UUU_H, H2, H2, H2, fnmadd16)
+THCALL(TH_OPFVV3, th_vfnmadd_vv_w, OP_UUU_W, H4, H4, H4, fnmadd32)
+THCALL(TH_OPFVV3, th_vfnmadd_vv_d, OP_UUU_D, H8, H8, H8, fnmadd64)
+GEN_TH_VV_ENV(th_vfnmadd_vv_h, 2, 2, clearh_th)
+GEN_TH_VV_ENV(th_vfnmadd_vv_w, 4, 4, clearl_th)
+GEN_TH_VV_ENV(th_vfnmadd_vv_d, 8, 8, clearq_th)
+THCALL(TH_OPFVF3, th_vfnmadd_vf_h, OP_UUU_H, H2, H2, fnmadd16)
+THCALL(TH_OPFVF3, th_vfnmadd_vf_w, OP_UUU_W, H4, H4, fnmadd32)
+THCALL(TH_OPFVF3, th_vfnmadd_vf_d, OP_UUU_D, H8, H8, fnmadd64)
+GEN_TH_VF(th_vfnmadd_vf_h, 2, 2, clearh_th)
+GEN_TH_VF(th_vfnmadd_vf_w, 4, 4, clearl_th)
+GEN_TH_VF(th_vfnmadd_vf_d, 8, 8, clearq_th)
+
+THCALL(TH_OPFVV3, th_vfmsub_vv_h, OP_UUU_H, H2, H2, H2, fmsub16)
+THCALL(TH_OPFVV3, th_vfmsub_vv_w, OP_UUU_W, H4, H4, H4, fmsub32)
+THCALL(TH_OPFVV3, th_vfmsub_vv_d, OP_UUU_D, H8, H8, H8, fmsub64)
+GEN_TH_VV_ENV(th_vfmsub_vv_h, 2, 2, clearh_th)
+GEN_TH_VV_ENV(th_vfmsub_vv_w, 4, 4, clearl_th)
+GEN_TH_VV_ENV(th_vfmsub_vv_d, 8, 8, clearq_th)
+THCALL(TH_OPFVF3, th_vfmsub_vf_h, OP_UUU_H, H2, H2, fmsub16)
+THCALL(TH_OPFVF3, th_vfmsub_vf_w, OP_UUU_W, H4, H4, fmsub32)
+THCALL(TH_OPFVF3, th_vfmsub_vf_d, OP_UUU_D, H8, H8, fmsub64)
+GEN_TH_VF(th_vfmsub_vf_h, 2, 2, clearh_th)
+GEN_TH_VF(th_vfmsub_vf_w, 4, 4, clearl_th)
+GEN_TH_VF(th_vfmsub_vf_d, 8, 8, clearq_th)
+
+THCALL(TH_OPFVV3, th_vfnmsub_vv_h, OP_UUU_H, H2, H2, H2, fnmsub16)
+THCALL(TH_OPFVV3, th_vfnmsub_vv_w, OP_UUU_W, H4, H4, H4, fnmsub32)
+THCALL(TH_OPFVV3, th_vfnmsub_vv_d, OP_UUU_D, H8, H8, H8, fnmsub64)
+GEN_TH_VV_ENV(th_vfnmsub_vv_h, 2, 2, clearh_th)
+GEN_TH_VV_ENV(th_vfnmsub_vv_w, 4, 4, clearl_th)
+GEN_TH_VV_ENV(th_vfnmsub_vv_d, 8, 8, clearq_th)
+THCALL(TH_OPFVF3, th_vfnmsub_vf_h, OP_UUU_H, H2, H2, fnmsub16)
+THCALL(TH_OPFVF3, th_vfnmsub_vf_w, OP_UUU_W, H4, H4, fnmsub32)
+THCALL(TH_OPFVF3, th_vfnmsub_vf_d, OP_UUU_D, H8, H8, fnmsub64)
+GEN_TH_VF(th_vfnmsub_vf_h, 2, 2, clearh_th)
+GEN_TH_VF(th_vfnmsub_vf_w, 4, 4, clearl_th)
+GEN_TH_VF(th_vfnmsub_vf_d, 8, 8, clearq_th)
-- 
2.44.0


