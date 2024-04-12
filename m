Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354CAC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 09:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvD2O-00048e-HX; Fri, 12 Apr 2024 05:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvD2I-000420-E0; Fri, 12 Apr 2024 05:17:33 -0400
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvD2F-0001fL-Bu; Fri, 12 Apr 2024 05:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712913441; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=CV8FBN1HjN58rCyAXJLpnJ7PtVjcdUgIJ+0yhbkx+T8=;
 b=qwzZ6IALP9yyPJsrcv9LcF3C25CMdgLcpQ/yQeXu/HefZ8ffkqby+3LZ3mouyb1EgObfsjA+b5nJdYlLKu1Y0rAUM36OG8hZBTpiYK4Y00yj1SLW3FxDyvjwI17oEKEUWBV0NK5GjdwDOBAQbs1SxUbGWSZXcI7dhv5gGP4n8Hk=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NsWV7_1712913439; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NsWV7_1712913439) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 17:17:19 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 41/65] target/riscv: Add widening floating-point fused mul-add
 instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:37:11 +0800
Message-ID: <20240412073735.76413-42-eric.huang@linux.alibaba.com>
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

The instructions have the same function as RVV1.0. Overall there are only
general differences between XTheadVector and RVV1.0.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         | 17 +++++++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 18 +++++----
 target/riscv/vector_helper.c                  | 16 ++++----
 target/riscv/vector_internals.h               |  9 +++++
 target/riscv/xtheadvector_helper.c            | 38 +++++++++++++++++++
 5 files changed, 82 insertions(+), 16 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 88e3a18e17..12b5e4573a 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -2099,3 +2099,20 @@ DEF_HELPER_6(th_vfmsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(th_vfnmsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(th_vfnmsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(th_vfnmsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_6(th_vfwmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfwmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfwnmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfwnmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfwmsac_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfwmsac_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfwnmsac_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfwnmsac_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfwmacc_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfwmacc_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfwnmacc_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfwnmacc_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfwmsac_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfwmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfwnmsac_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfwnmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index af512c489b..7220b7d607 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -2037,20 +2037,22 @@ GEN_OPFVF_TRANS_TH(th_vfnmadd_vf, opfvf_check_th)
 GEN_OPFVF_TRANS_TH(th_vfmsub_vf, opfvf_check_th)
 GEN_OPFVF_TRANS_TH(th_vfnmsub_vf, opfvf_check_th)
 
+/* Vector Widening Floating-Point Fused Multiply-Add Instructions */
+GEN_OPFVV_WIDEN_TRANS_TH(th_vfwmacc_vv, opfvv_widen_check_th)
+GEN_OPFVV_WIDEN_TRANS_TH(th_vfwnmacc_vv, opfvv_widen_check_th)
+GEN_OPFVV_WIDEN_TRANS_TH(th_vfwmsac_vv, opfvv_widen_check_th)
+GEN_OPFVV_WIDEN_TRANS_TH(th_vfwnmsac_vv, opfvv_widen_check_th)
+GEN_OPFVF_WIDEN_TRANS_TH(th_vfwmacc_vf)
+GEN_OPFVF_WIDEN_TRANS_TH(th_vfwnmacc_vf)
+GEN_OPFVF_WIDEN_TRANS_TH(th_vfwmsac_vf)
+GEN_OPFVF_WIDEN_TRANS_TH(th_vfwnmsac_vf)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vfwmacc_vv)
-TH_TRANS_STUB(th_vfwmacc_vf)
-TH_TRANS_STUB(th_vfwnmacc_vv)
-TH_TRANS_STUB(th_vfwnmacc_vf)
-TH_TRANS_STUB(th_vfwmsac_vv)
-TH_TRANS_STUB(th_vfwmsac_vf)
-TH_TRANS_STUB(th_vfwnmsac_vv)
-TH_TRANS_STUB(th_vfwnmsac_vf)
 TH_TRANS_STUB(th_vfsqrt_v)
 TH_TRANS_STUB(th_vfmin_vv)
 TH_TRANS_STUB(th_vfmin_vf)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 165221e08b..ef89794bdd 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3332,13 +3332,13 @@ GEN_VEXT_VF(vfnmsub_vf_w, 4)
 GEN_VEXT_VF(vfnmsub_vf_d, 8)
 
 /* Vector Widening Floating-Point Fused Multiply-Add Instructions */
-static uint32_t fwmacc16(uint16_t a, uint16_t b, uint32_t d, float_status *s)
+uint32_t fwmacc16(uint16_t a, uint16_t b, uint32_t d, float_status *s)
 {
     return float32_muladd(float16_to_float32(a, true, s),
                           float16_to_float32(b, true, s), d, 0, s);
 }
 
-static uint64_t fwmacc32(uint32_t a, uint32_t b, uint64_t d, float_status *s)
+uint64_t fwmacc32(uint32_t a, uint32_t b, uint64_t d, float_status *s)
 {
     return float64_muladd(float32_to_float64(a, s),
                           float32_to_float64(b, s), d, 0, s);
@@ -3364,7 +3364,7 @@ GEN_VEXT_VV_ENV(vfwmaccbf16_vv, 4)
 RVVCALL(OPFVF3, vfwmaccbf16_vf, WOP_UUU_H, H4, H2, fwmaccbf16)
 GEN_VEXT_VF(vfwmaccbf16_vf, 4)
 
-static uint32_t fwnmacc16(uint16_t a, uint16_t b, uint32_t d, float_status *s)
+uint32_t fwnmacc16(uint16_t a, uint16_t b, uint32_t d, float_status *s)
 {
     return float32_muladd(float16_to_float32(a, true, s),
                           float16_to_float32(b, true, s), d,
@@ -3372,7 +3372,7 @@ static uint32_t fwnmacc16(uint16_t a, uint16_t b, uint32_t d, float_status *s)
                           s);
 }
 
-static uint64_t fwnmacc32(uint32_t a, uint32_t b, uint64_t d, float_status *s)
+uint64_t fwnmacc32(uint32_t a, uint32_t b, uint64_t d, float_status *s)
 {
     return float64_muladd(float32_to_float64(a, s), float32_to_float64(b, s),
                           d, float_muladd_negate_c |
@@ -3388,14 +3388,14 @@ RVVCALL(OPFVF3, vfwnmacc_vf_w, WOP_UUU_W, H8, H4, fwnmacc32)
 GEN_VEXT_VF(vfwnmacc_vf_h, 4)
 GEN_VEXT_VF(vfwnmacc_vf_w, 8)
 
-static uint32_t fwmsac16(uint16_t a, uint16_t b, uint32_t d, float_status *s)
+uint32_t fwmsac16(uint16_t a, uint16_t b, uint32_t d, float_status *s)
 {
     return float32_muladd(float16_to_float32(a, true, s),
                           float16_to_float32(b, true, s), d,
                           float_muladd_negate_c, s);
 }
 
-static uint64_t fwmsac32(uint32_t a, uint32_t b, uint64_t d, float_status *s)
+uint64_t fwmsac32(uint32_t a, uint32_t b, uint64_t d, float_status *s)
 {
     return float64_muladd(float32_to_float64(a, s),
                           float32_to_float64(b, s), d,
@@ -3411,14 +3411,14 @@ RVVCALL(OPFVF3, vfwmsac_vf_w, WOP_UUU_W, H8, H4, fwmsac32)
 GEN_VEXT_VF(vfwmsac_vf_h, 4)
 GEN_VEXT_VF(vfwmsac_vf_w, 8)
 
-static uint32_t fwnmsac16(uint16_t a, uint16_t b, uint32_t d, float_status *s)
+uint32_t fwnmsac16(uint16_t a, uint16_t b, uint32_t d, float_status *s)
 {
     return float32_muladd(float16_to_float32(a, true, s),
                           float16_to_float32(b, true, s), d,
                           float_muladd_negate_product, s);
 }
 
-static uint64_t fwnmsac32(uint32_t a, uint32_t b, uint64_t d, float_status *s)
+uint64_t fwnmsac32(uint32_t a, uint32_t b, uint64_t d, float_status *s)
 {
     return float64_muladd(float32_to_float64(a, s),
                           float32_to_float64(b, s), d,
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index 5733640e0d..535d31007d 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -385,4 +385,13 @@ uint16_t fnmsub16(uint16_t a, uint16_t b, uint16_t d, float_status *s);
 uint32_t fnmsub32(uint32_t a, uint32_t b, uint32_t d, float_status *s);
 uint64_t fnmsub64(uint64_t a, uint64_t b, uint64_t d, float_status *s);
 
+uint32_t fwmacc16(uint16_t a, uint16_t b, uint32_t d, float_status *s);
+uint64_t fwmacc32(uint32_t a, uint32_t b, uint64_t d, float_status *s);
+uint32_t fwnmacc16(uint16_t a, uint16_t b, uint32_t d, float_status *s);
+uint64_t fwnmacc32(uint32_t a, uint32_t b, uint64_t d, float_status *s);
+uint32_t fwmsac16(uint16_t a, uint16_t b, uint32_t d, float_status *s);
+uint64_t fwmsac32(uint32_t a, uint32_t b, uint64_t d, float_status *s);
+uint32_t fwnmsac16(uint16_t a, uint16_t b, uint32_t d, float_status *s);
+uint64_t fwnmsac32(uint32_t a, uint32_t b, uint64_t d, float_status *s);
+
 #endif /* TARGET_RISCV_VECTOR_INTERNALS_H */
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 1d2da6ffb7..ac8e576c49 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -2904,3 +2904,41 @@ THCALL(TH_OPFVF3, th_vfnmsub_vf_d, OP_UUU_D, H8, H8, fnmsub64)
 GEN_TH_VF(th_vfnmsub_vf_h, 2, 2, clearh_th)
 GEN_TH_VF(th_vfnmsub_vf_w, 4, 4, clearl_th)
 GEN_TH_VF(th_vfnmsub_vf_d, 8, 8, clearq_th)
+
+/* Vector Widening Floating-Point Fused Multiply-Add Instructions */
+
+THCALL(TH_OPFVV3, th_vfwmacc_vv_h, WOP_UUU_H, H4, H2, H2, fwmacc16)
+THCALL(TH_OPFVV3, th_vfwmacc_vv_w, WOP_UUU_W, H8, H4, H4, fwmacc32)
+GEN_TH_VV_ENV(th_vfwmacc_vv_h, 2, 4, clearl_th)
+GEN_TH_VV_ENV(th_vfwmacc_vv_w, 4, 8, clearq_th)
+THCALL(TH_OPFVF3, th_vfwmacc_vf_h, WOP_UUU_H, H4, H2, fwmacc16)
+THCALL(TH_OPFVF3, th_vfwmacc_vf_w, WOP_UUU_W, H8, H4, fwmacc32)
+GEN_TH_VF(th_vfwmacc_vf_h, 2, 4, clearl_th)
+GEN_TH_VF(th_vfwmacc_vf_w, 4, 8, clearq_th)
+
+THCALL(TH_OPFVV3, th_vfwnmacc_vv_h, WOP_UUU_H, H4, H2, H2, fwnmacc16)
+THCALL(TH_OPFVV3, th_vfwnmacc_vv_w, WOP_UUU_W, H8, H4, H4, fwnmacc32)
+GEN_TH_VV_ENV(th_vfwnmacc_vv_h, 2, 4, clearl_th)
+GEN_TH_VV_ENV(th_vfwnmacc_vv_w, 4, 8, clearq_th)
+THCALL(TH_OPFVF3, th_vfwnmacc_vf_h, WOP_UUU_H, H4, H2, fwnmacc16)
+THCALL(TH_OPFVF3, th_vfwnmacc_vf_w, WOP_UUU_W, H8, H4, fwnmacc32)
+GEN_TH_VF(th_vfwnmacc_vf_h, 2, 4, clearl_th)
+GEN_TH_VF(th_vfwnmacc_vf_w, 4, 8, clearq_th)
+
+THCALL(TH_OPFVV3, th_vfwmsac_vv_h, WOP_UUU_H, H4, H2, H2, fwmsac16)
+THCALL(TH_OPFVV3, th_vfwmsac_vv_w, WOP_UUU_W, H8, H4, H4, fwmsac32)
+GEN_TH_VV_ENV(th_vfwmsac_vv_h, 2, 4, clearl_th)
+GEN_TH_VV_ENV(th_vfwmsac_vv_w, 4, 8, clearq_th)
+THCALL(TH_OPFVF3, th_vfwmsac_vf_h, WOP_UUU_H, H4, H2, fwmsac16)
+THCALL(TH_OPFVF3, th_vfwmsac_vf_w, WOP_UUU_W, H8, H4, fwmsac32)
+GEN_TH_VF(th_vfwmsac_vf_h, 2, 4, clearl_th)
+GEN_TH_VF(th_vfwmsac_vf_w, 4, 8, clearq_th)
+
+THCALL(TH_OPFVV3, th_vfwnmsac_vv_h, WOP_UUU_H, H4, H2, H2, fwnmsac16)
+THCALL(TH_OPFVV3, th_vfwnmsac_vv_w, WOP_UUU_W, H8, H4, H4, fwnmsac32)
+GEN_TH_VV_ENV(th_vfwnmsac_vv_h, 2, 4, clearl_th)
+GEN_TH_VV_ENV(th_vfwnmsac_vv_w, 4, 8, clearq_th)
+THCALL(TH_OPFVF3, th_vfwnmsac_vf_h, WOP_UUU_H, H4, H2, fwnmsac16)
+THCALL(TH_OPFVF3, th_vfwnmsac_vf_w, WOP_UUU_W, H8, H4, fwnmsac32)
+GEN_TH_VF(th_vfwnmsac_vf_h, 2, 4, clearl_th)
+GEN_TH_VF(th_vfwnmsac_vf_w, 4, 8, clearq_th)
-- 
2.44.0


