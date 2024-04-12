Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C418FC04FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvCVP-0005ND-Hn; Fri, 12 Apr 2024 04:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCVM-0005CA-24; Fri, 12 Apr 2024 04:43:29 -0400
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCVJ-0003hP-2N; Fri, 12 Apr 2024 04:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712911400; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=l7qs+t2zYNNda/ugnXokH5TwZNjFnIo1PX/2F8U6sJA=;
 b=oEFIQV0E7yKPCFkGr9H4d67NJmbufmDzi6yRHZ7xZCPgN66+G3x04Yrqs1GhsOZFokoFCwWwBeL6xI2pZ3tp52vjaTfUCdoQ4YeD0e3NLzCPKdnaX6mWChZYGp21O8tbjmynebKySCDoE65hrXpSPxnjAydeG8VJNpW1ci6gmDw=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R671e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NgS2f_1712911398; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NgS2f_1712911398) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 16:43:19 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 32/65] target/riscv: Add single-width fractional mul with
 rounding and saturation for XTheadVector
Date: Fri, 12 Apr 2024 15:37:02 +0800
Message-ID: <20240412073735.76413-33-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
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
 target/riscv/helper.h                         |  9 +++++++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc |  6 ++++--
 target/riscv/vector_helper.c                  |  8 ++++----
 target/riscv/vector_internals.h               |  6 ++++++
 target/riscv/xtheadvector_helper.c            | 19 +++++++++++++++++++
 5 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index aab2979328..85962f7253 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1935,3 +1935,12 @@ DEF_HELPER_6(th_vasub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vasub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vasub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vasub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(th_vsmul_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsmul_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsmul_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsmul_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsmul_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsmul_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsmul_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsmul_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 59da1e4b3f..df653bd1c9 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -1717,14 +1717,16 @@ GEN_OPIVX_TRANS_TH(th_vaadd_vx,  opivx_check_th)
 GEN_OPIVX_TRANS_TH(th_vasub_vx,  opivx_check_th)
 GEN_OPIVI_TRANS_TH(th_vaadd_vi, IMM_SX, th_vaadd_vx, opivx_check_th)
 
+/* Vector Single-Width Fractional Multiply with Rounding and Saturation */
+GEN_OPIVV_TRANS_TH(th_vsmul_vv, opivv_check_th)
+GEN_OPIVX_TRANS_TH(th_vsmul_vx, opivx_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vsmul_vv)
-TH_TRANS_STUB(th_vsmul_vx)
 TH_TRANS_STUB(th_vwsmaccu_vv)
 TH_TRANS_STUB(th_vwsmaccu_vx)
 TH_TRANS_STUB(th_vwsmacc_vv)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index ea1e449174..331a9a9c7a 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -2474,7 +2474,7 @@ GEN_VEXT_VX_RM(vasubu_vx_w, 4)
 GEN_VEXT_VX_RM(vasubu_vx_d, 8)
 
 /* Vector Single-Width Fractional Multiply with Rounding and Saturation */
-static inline int8_t vsmul8(CPURISCVState *env, int vxrm, int8_t a, int8_t b)
+int8_t vsmul8(CPURISCVState *env, int vxrm, int8_t a, int8_t b)
 {
     uint8_t round;
     int16_t res;
@@ -2494,7 +2494,7 @@ static inline int8_t vsmul8(CPURISCVState *env, int vxrm, int8_t a, int8_t b)
     }
 }
 
-static int16_t vsmul16(CPURISCVState *env, int vxrm, int16_t a, int16_t b)
+int16_t vsmul16(CPURISCVState *env, int vxrm, int16_t a, int16_t b)
 {
     uint8_t round;
     int32_t res;
@@ -2514,7 +2514,7 @@ static int16_t vsmul16(CPURISCVState *env, int vxrm, int16_t a, int16_t b)
     }
 }
 
-static int32_t vsmul32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
+int32_t vsmul32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
 {
     uint8_t round;
     int64_t res;
@@ -2534,7 +2534,7 @@ static int32_t vsmul32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
     }
 }
 
-static int64_t vsmul64(CPURISCVState *env, int vxrm, int64_t a, int64_t b)
+int64_t vsmul64(CPURISCVState *env, int vxrm, int64_t a, int64_t b)
 {
     uint8_t round;
     uint64_t hi_64, lo_64;
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index 19f174f4c8..c76ff5abac 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -308,4 +308,10 @@ int32_t aadd32(CPURISCVState *env, int vxrm, int32_t a, int32_t b);
 int64_t aadd64(CPURISCVState *env, int vxrm, int64_t a, int64_t b);
 int32_t asub32(CPURISCVState *env, int vxrm, int32_t a, int32_t b);
 int64_t asub64(CPURISCVState *env, int vxrm, int64_t a, int64_t b);
+
+int8_t vsmul8(CPURISCVState *env, int vxrm, int8_t a, int8_t b);
+int16_t vsmul16(CPURISCVState *env, int vxrm, int16_t a, int16_t b);
+int32_t vsmul32(CPURISCVState *env, int vxrm, int32_t a, int32_t b);
+int64_t vsmul64(CPURISCVState *env, int vxrm, int64_t a, int64_t b);
+
 #endif /* TARGET_RISCV_VECTOR_INTERNALS_H */
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 06ac5940b7..e4acb4d176 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -2294,3 +2294,22 @@ GEN_TH_VX_RM(th_vasub_vx_b, 1, 1, clearb_th)
 GEN_TH_VX_RM(th_vasub_vx_h, 2, 2, clearh_th)
 GEN_TH_VX_RM(th_vasub_vx_w, 4, 4, clearl_th)
 GEN_TH_VX_RM(th_vasub_vx_d, 8, 8, clearq_th)
+
+/* Vector Single-Width Fractional Multiply with Rounding and Saturation */
+THCALL(TH_OPIVV2_RM, th_vsmul_vv_b, OP_SSS_B, H1, H1, H1, vsmul8)
+THCALL(TH_OPIVV2_RM, th_vsmul_vv_h, OP_SSS_H, H2, H2, H2, vsmul16)
+THCALL(TH_OPIVV2_RM, th_vsmul_vv_w, OP_SSS_W, H4, H4, H4, vsmul32)
+THCALL(TH_OPIVV2_RM, th_vsmul_vv_d, OP_SSS_D, H8, H8, H8, vsmul64)
+GEN_TH_VV_RM(th_vsmul_vv_b, 1, 1, clearb_th)
+GEN_TH_VV_RM(th_vsmul_vv_h, 2, 2, clearh_th)
+GEN_TH_VV_RM(th_vsmul_vv_w, 4, 4, clearl_th)
+GEN_TH_VV_RM(th_vsmul_vv_d, 8, 8, clearq_th)
+
+THCALL(TH_OPIVX2_RM, th_vsmul_vx_b, OP_SSS_B, H1, H1, vsmul8)
+THCALL(TH_OPIVX2_RM, th_vsmul_vx_h, OP_SSS_H, H2, H2, vsmul16)
+THCALL(TH_OPIVX2_RM, th_vsmul_vx_w, OP_SSS_W, H4, H4, vsmul32)
+THCALL(TH_OPIVX2_RM, th_vsmul_vx_d, OP_SSS_D, H8, H8, vsmul64)
+GEN_TH_VX_RM(th_vsmul_vx_b, 1, 1, clearb_th)
+GEN_TH_VX_RM(th_vsmul_vx_h, 2, 2, clearh_th)
+GEN_TH_VX_RM(th_vsmul_vx_w, 4, 4, clearl_th)
+GEN_TH_VX_RM(th_vsmul_vx_d, 8, 8, clearq_th)
-- 
2.44.0


