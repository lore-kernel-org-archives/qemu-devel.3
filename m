Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68337C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvCXm-0006hh-9X; Fri, 12 Apr 2024 04:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCXT-0006gJ-Eh; Fri, 12 Apr 2024 04:45:42 -0400
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCXM-0004OV-C4; Fri, 12 Apr 2024 04:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712911521; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=SIUra65AWArhR0rIzfyuRhTsmYOTj+U/GvUEESwKsrM=;
 b=rztchhFveY2WtdZn3CoWcQr+uBKOYmB0EwZ+R4liTQa8E/f2lo7A4rY0AUhcX3pUs1OWI4MQGOeTpr2mm53OMEPHRliJCOJXqEQVHu5bTR84FpRXmh1U5ctQWTpDTfGrhJD1O4oI8ddHg/xkW7MCVWNk2EURIl69uWERQJ8RB78=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NjQr6_1712911520; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NjQr6_1712911520) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 16:45:21 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 33/65] target/riscv: Add widening saturating scaled
 multiply-add instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:37:03 +0800
Message-ID: <20240412073735.76413-34-eric.huang@linux.alibaba.com>
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

There are no instructions similar to these instructions in RVV1.0. So we
implement them by writing their own functions instead of copying code from
RVV1.0.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         |  22 ++
 .../riscv/insn_trans/trans_xtheadvector.c.inc |  16 +-
 target/riscv/vector_helper.c                  |   2 +-
 target/riscv/vector_internals.h               |   2 +
 target/riscv/xtheadvector_helper.c            | 210 ++++++++++++++++++
 5 files changed, 244 insertions(+), 8 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 85962f7253..d45477ee1b 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1944,3 +1944,25 @@ DEF_HELPER_6(th_vsmul_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vsmul_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vsmul_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vsmul_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(th_vwsmaccu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwsmaccu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwsmaccu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwsmacc_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwsmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwsmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwsmaccsu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwsmaccsu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwsmaccsu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwsmaccu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwsmaccu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwsmaccu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwsmacc_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwsmacc_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwsmacc_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwsmaccsu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwsmaccsu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwsmaccsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwsmaccus_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwsmaccus_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwsmaccus_vx_w, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index df653bd1c9..175516e3a7 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -1721,19 +1721,21 @@ GEN_OPIVI_TRANS_TH(th_vaadd_vi, IMM_SX, th_vaadd_vx, opivx_check_th)
 GEN_OPIVV_TRANS_TH(th_vsmul_vv, opivv_check_th)
 GEN_OPIVX_TRANS_TH(th_vsmul_vx, opivx_check_th)
 
+/* Vector Widening Saturating Scaled Multiply-Add */
+GEN_OPIVV_WIDEN_TRANS_TH(th_vwsmaccu_vv, opivv_widen_check_th)
+GEN_OPIVV_WIDEN_TRANS_TH(th_vwsmacc_vv, opivv_widen_check_th)
+GEN_OPIVV_WIDEN_TRANS_TH(th_vwsmaccsu_vv, opivv_widen_check_th)
+GEN_OPIVX_WIDEN_TRANS_TH(th_vwsmaccu_vx, opivx_widen_check_th)
+GEN_OPIVX_WIDEN_TRANS_TH(th_vwsmacc_vx, opivx_widen_check_th)
+GEN_OPIVX_WIDEN_TRANS_TH(th_vwsmaccsu_vx, opivx_widen_check_th)
+GEN_OPIVX_WIDEN_TRANS_TH(th_vwsmaccus_vx, opivx_widen_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vwsmaccu_vv)
-TH_TRANS_STUB(th_vwsmaccu_vx)
-TH_TRANS_STUB(th_vwsmacc_vv)
-TH_TRANS_STUB(th_vwsmacc_vx)
-TH_TRANS_STUB(th_vwsmaccsu_vv)
-TH_TRANS_STUB(th_vwsmaccsu_vx)
-TH_TRANS_STUB(th_vwsmaccus_vx)
 TH_TRANS_STUB(th_vssrl_vv)
 TH_TRANS_STUB(th_vssrl_vx)
 TH_TRANS_STUB(th_vssrl_vi)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 331a9a9c7a..ec11acf487 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -2296,7 +2296,7 @@ GEN_VEXT_VX_RM(vssub_vx_w, 4)
 GEN_VEXT_VX_RM(vssub_vx_d, 8)
 
 /* Vector Single-Width Averaging Add and Subtract */
-static inline uint8_t get_round(int vxrm, uint64_t v, uint8_t shift)
+uint8_t get_round(int vxrm, uint64_t v, uint8_t shift)
 {
     uint8_t d = extract64(v, shift, 1);
     uint8_t d1;
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index c76ff5abac..99f69ef8fa 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -314,4 +314,6 @@ int16_t vsmul16(CPURISCVState *env, int vxrm, int16_t a, int16_t b);
 int32_t vsmul32(CPURISCVState *env, int vxrm, int32_t a, int32_t b);
 int64_t vsmul64(CPURISCVState *env, int vxrm, int64_t a, int64_t b);
 
+uint8_t get_round(int vxrm, uint64_t v, uint8_t shift);
+
 #endif /* TARGET_RISCV_VECTOR_INTERNALS_H */
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index e4acb4d176..1964855d2d 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -2313,3 +2313,213 @@ GEN_TH_VX_RM(th_vsmul_vx_b, 1, 1, clearb_th)
 GEN_TH_VX_RM(th_vsmul_vx_h, 2, 2, clearh_th)
 GEN_TH_VX_RM(th_vsmul_vx_w, 4, 4, clearl_th)
 GEN_TH_VX_RM(th_vsmul_vx_d, 8, 8, clearq_th)
+
+/*
+ * Vector Widening Saturating Scaled Multiply-Add
+ *
+ * RVV1.0 does not have similar instructions
+ */
+
+static inline uint16_t
+vwsmaccu8(CPURISCVState *env, int vxrm, uint8_t a, uint8_t b,
+          uint16_t c)
+{
+    uint8_t round;
+    uint16_t res = (uint16_t)a * b;
+
+    round = get_round(vxrm, res, 4);
+    res   = (res >> 4) + round;
+    return saddu16(env, vxrm, c, res);
+}
+
+static inline uint32_t
+vwsmaccu16(CPURISCVState *env, int vxrm, uint16_t a, uint16_t b,
+           uint32_t c)
+{
+    uint8_t round;
+    uint32_t res = (uint32_t)a * b;
+
+    round = get_round(vxrm, res, 8);
+    res   = (res >> 8) + round;
+    return saddu32(env, vxrm, c, res);
+}
+
+static inline uint64_t
+vwsmaccu32(CPURISCVState *env, int vxrm, uint32_t a, uint32_t b,
+           uint64_t c)
+{
+    uint8_t round;
+    uint64_t res = (uint64_t)a * b;
+
+    round = get_round(vxrm, res, 16);
+    res   = (res >> 16) + round;
+    return saddu64(env, vxrm, c, res);
+}
+
+#define TH_OPIVV3_RM(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP) \
+static inline void                                                 \
+do_##NAME(void *vd, void *vs1, void *vs2, int i,                   \
+          CPURISCVState *env, int vxrm)                            \
+{                                                                  \
+    TX1 s1 = *((T1 *)vs1 + HS1(i));                                \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                                \
+    TD d = *((TD *)vd + HD(i));                                    \
+    *((TD *)vd + HD(i)) = OP(env, vxrm, s2, s1, d);                \
+}
+
+THCALL(TH_OPIVV3_RM, th_vwsmaccu_vv_b, WOP_UUU_B, H2, H1, H1, vwsmaccu8)
+THCALL(TH_OPIVV3_RM, th_vwsmaccu_vv_h, WOP_UUU_H, H4, H2, H2, vwsmaccu16)
+THCALL(TH_OPIVV3_RM, th_vwsmaccu_vv_w, WOP_UUU_W, H8, H4, H4, vwsmaccu32)
+GEN_TH_VV_RM(th_vwsmaccu_vv_b, 1, 2, clearh_th)
+GEN_TH_VV_RM(th_vwsmaccu_vv_h, 2, 4, clearl_th)
+GEN_TH_VV_RM(th_vwsmaccu_vv_w, 4, 8, clearq_th)
+
+#define TH_OPIVX3_RM(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)      \
+static inline void                                                 \
+do_##NAME(void *vd, target_long s1, void *vs2, int i,              \
+          CPURISCVState *env, int vxrm)                            \
+{                                                                  \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                                \
+    TD d = *((TD *)vd + HD(i));                                    \
+    *((TD *)vd + HD(i)) = OP(env, vxrm, s2, (TX1)(T1)s1, d);       \
+}
+
+THCALL(TH_OPIVX3_RM, th_vwsmaccu_vx_b, WOP_UUU_B, H2, H1, vwsmaccu8)
+THCALL(TH_OPIVX3_RM, th_vwsmaccu_vx_h, WOP_UUU_H, H4, H2, vwsmaccu16)
+THCALL(TH_OPIVX3_RM, th_vwsmaccu_vx_w, WOP_UUU_W, H8, H4, vwsmaccu32)
+GEN_TH_VX_RM(th_vwsmaccu_vx_b, 1, 2, clearh_th)
+GEN_TH_VX_RM(th_vwsmaccu_vx_h, 2, 4, clearl_th)
+GEN_TH_VX_RM(th_vwsmaccu_vx_w, 4, 8, clearq_th)
+
+static inline int16_t
+vwsmacc8(CPURISCVState *env, int vxrm, int8_t a, int8_t b, int16_t c)
+{
+    uint8_t round;
+    int16_t res = (int16_t)a * b;
+
+    round = get_round(vxrm, res, 4);
+    res   = (res >> 4) + round;
+    return sadd16(env, vxrm, c, res);
+}
+
+static inline int32_t
+vwsmacc16(CPURISCVState *env, int vxrm, int16_t a, int16_t b, int32_t c)
+{
+    uint8_t round;
+    int32_t res = (int32_t)a * b;
+
+    round = get_round(vxrm, res, 8);
+    res   = (res >> 8) + round;
+    return sadd32(env, vxrm, c, res);
+
+}
+
+static inline int64_t
+vwsmacc32(CPURISCVState *env, int vxrm, int32_t a, int32_t b, int64_t c)
+{
+    uint8_t round;
+    int64_t res = (int64_t)a * b;
+
+    round = get_round(vxrm, res, 16);
+    res   = (res >> 16) + round;
+    return sadd64(env, vxrm, c, res);
+}
+
+THCALL(TH_OPIVV3_RM, th_vwsmacc_vv_b, WOP_SSS_B, H2, H1, H1, vwsmacc8)
+THCALL(TH_OPIVV3_RM, th_vwsmacc_vv_h, WOP_SSS_H, H4, H2, H2, vwsmacc16)
+THCALL(TH_OPIVV3_RM, th_vwsmacc_vv_w, WOP_SSS_W, H8, H4, H4, vwsmacc32)
+GEN_TH_VV_RM(th_vwsmacc_vv_b, 1, 2, clearh_th)
+GEN_TH_VV_RM(th_vwsmacc_vv_h, 2, 4, clearl_th)
+GEN_TH_VV_RM(th_vwsmacc_vv_w, 4, 8, clearq_th)
+THCALL(TH_OPIVX3_RM, th_vwsmacc_vx_b, WOP_SSS_B, H2, H1, vwsmacc8)
+THCALL(TH_OPIVX3_RM, th_vwsmacc_vx_h, WOP_SSS_H, H4, H2, vwsmacc16)
+THCALL(TH_OPIVX3_RM, th_vwsmacc_vx_w, WOP_SSS_W, H8, H4, vwsmacc32)
+GEN_TH_VX_RM(th_vwsmacc_vx_b, 1, 2, clearh_th)
+GEN_TH_VX_RM(th_vwsmacc_vx_h, 2, 4, clearl_th)
+GEN_TH_VX_RM(th_vwsmacc_vx_w, 4, 8, clearq_th)
+
+static inline int16_t
+vwsmaccsu8(CPURISCVState *env, int vxrm, uint8_t a, int8_t b, int16_t c)
+{
+    uint8_t round;
+    int16_t res = a * (int16_t)b;
+
+    round = get_round(vxrm, res, 4);
+    res   = (res >> 4) + round;
+    return ssub16(env, vxrm, c, res);
+}
+
+static inline int32_t
+vwsmaccsu16(CPURISCVState *env, int vxrm, uint16_t a, int16_t b, uint32_t c)
+{
+    uint8_t round;
+    int32_t res = a * (int32_t)b;
+
+    round = get_round(vxrm, res, 8);
+    res   = (res >> 8) + round;
+    return ssub32(env, vxrm, c, res);
+}
+
+static inline int64_t
+vwsmaccsu32(CPURISCVState *env, int vxrm, uint32_t a, int32_t b, int64_t c)
+{
+    uint8_t round;
+    int64_t res = a * (int64_t)b;
+
+    round = get_round(vxrm, res, 16);
+    res   = (res >> 16) + round;
+    return ssub64(env, vxrm, c, res);
+}
+
+THCALL(TH_OPIVV3_RM, th_vwsmaccsu_vv_b, WOP_SSU_B, H2, H1, H1, vwsmaccsu8)
+THCALL(TH_OPIVV3_RM, th_vwsmaccsu_vv_h, WOP_SSU_H, H4, H2, H2, vwsmaccsu16)
+THCALL(TH_OPIVV3_RM, th_vwsmaccsu_vv_w, WOP_SSU_W, H8, H4, H4, vwsmaccsu32)
+GEN_TH_VV_RM(th_vwsmaccsu_vv_b, 1, 2, clearh_th)
+GEN_TH_VV_RM(th_vwsmaccsu_vv_h, 2, 4, clearl_th)
+GEN_TH_VV_RM(th_vwsmaccsu_vv_w, 4, 8, clearq_th)
+THCALL(TH_OPIVX3_RM, th_vwsmaccsu_vx_b, WOP_SSU_B, H2, H1, vwsmaccsu8)
+THCALL(TH_OPIVX3_RM, th_vwsmaccsu_vx_h, WOP_SSU_H, H4, H2, vwsmaccsu16)
+THCALL(TH_OPIVX3_RM, th_vwsmaccsu_vx_w, WOP_SSU_W, H8, H4, vwsmaccsu32)
+GEN_TH_VX_RM(th_vwsmaccsu_vx_b, 1, 2, clearh_th)
+GEN_TH_VX_RM(th_vwsmaccsu_vx_h, 2, 4, clearl_th)
+GEN_TH_VX_RM(th_vwsmaccsu_vx_w, 4, 8, clearq_th)
+
+static inline int16_t
+vwsmaccus8(CPURISCVState *env, int vxrm, int8_t a, uint8_t b, int16_t c)
+{
+    uint8_t round;
+    int16_t res = (int16_t)a * b;
+
+    round = get_round(vxrm, res, 4);
+    res   = (res >> 4) + round;
+    return ssub16(env, vxrm, c, res);
+}
+
+static inline int32_t
+vwsmaccus16(CPURISCVState *env, int vxrm, int16_t a, uint16_t b, int32_t c)
+{
+    uint8_t round;
+    int32_t res = (int32_t)a * b;
+
+    round = get_round(vxrm, res, 8);
+    res   = (res >> 8) + round;
+    return ssub32(env, vxrm, c, res);
+}
+
+static inline int64_t
+vwsmaccus32(CPURISCVState *env, int vxrm, int32_t a, uint32_t b, int64_t c)
+{
+    uint8_t round;
+    int64_t res = (int64_t)a * b;
+
+    round = get_round(vxrm, res, 16);
+    res   = (res >> 16) + round;
+    return ssub64(env, vxrm, c, res);
+}
+
+THCALL(TH_OPIVX3_RM, th_vwsmaccus_vx_b, WOP_SUS_B, H2, H1, vwsmaccus8)
+THCALL(TH_OPIVX3_RM, th_vwsmaccus_vx_h, WOP_SUS_H, H4, H2, vwsmaccus16)
+THCALL(TH_OPIVX3_RM, th_vwsmaccus_vx_w, WOP_SUS_W, H8, H4, vwsmaccus32)
+GEN_TH_VX_RM(th_vwsmaccus_vx_b, 1, 2, clearh_th)
+GEN_TH_VX_RM(th_vwsmaccus_vx_h, 2, 4, clearl_th)
+GEN_TH_VX_RM(th_vwsmaccus_vx_w, 4, 8, clearq_th)
-- 
2.44.0


