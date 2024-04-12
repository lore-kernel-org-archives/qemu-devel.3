Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AEEC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvCRb-0005O7-UJ; Fri, 12 Apr 2024 04:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCRa-0005Nq-4N; Fri, 12 Apr 2024 04:39:34 -0400
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCRT-0002Kh-Kf; Fri, 12 Apr 2024 04:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712911157; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=3X09Fw7LZBmQAAAQn0XZA0PH23O/oWDyy/6nqPoXjAg=;
 b=rPPYq3QDvY2eMtjwFfEP9GfFtT+H9Onk3o6HmDosg+sAPlQ2PaR4sHKzLnCdmp2btJ1KUu3NPR3o4PKU0oFQ41shJt/dY1SXLm9ZUDz1R4wBvT4407dGPuFzITMi5eMDOLpKDzoVn1kU1DIQV/CPd664OazbD9xchEs0MxznAOc=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R521e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NbF43_1712911155; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NbF43_1712911155) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 16:39:16 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 30/65] target/riscv: Add single-width saturating add and sub
 instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:37:00 +0800
Message-ID: <20240412073735.76413-31-eric.huang@linux.alibaba.com>
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

In this patch, we add single-width saturating add and sub instructions to
show the way we implement XTheadVector fixed-point arithmetic instructions.
The instructions have the same function as RVV1.0. Overall there are only
general differences between XTheadVector and RVV1.0.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         |  33 +++
 .../riscv/insn_trans/trans_xtheadvector.c.inc |  26 +-
 target/riscv/vector_helper.c                  |  32 +--
 target/riscv/vector_internals.h               |  19 ++
 target/riscv/xtheadvector_helper.c            | 231 ++++++++++++++++++
 5 files changed, 315 insertions(+), 26 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index ba548ebdc9..c5156d9939 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1885,3 +1885,36 @@ DEF_HELPER_4(th_vmv_v_x_b, void, ptr, i64, env, i32)
 DEF_HELPER_4(th_vmv_v_x_h, void, ptr, i64, env, i32)
 DEF_HELPER_4(th_vmv_v_x_w, void, ptr, i64, env, i32)
 DEF_HELPER_4(th_vmv_v_x_d, void, ptr, i64, env, i32)
+
+DEF_HELPER_6(th_vsaddu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsaddu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsaddu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsaddu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsadd_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsadd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vssubu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vssubu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vssubu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vssubu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vssub_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vssub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vssub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vssub_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsaddu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsaddu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsaddu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsaddu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsadd_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsadd_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsadd_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsadd_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vssubu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vssubu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vssubu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vssubu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vssub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vssub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vssub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vssub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 6d0ce9f966..e60da5b237 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -1694,22 +1694,28 @@ GEN_OPIVV_TRANS_TH(th_vmerge_vvm, opivv_vadc_check_th)
 GEN_OPIVX_TRANS_TH(th_vmerge_vxm, opivx_vadc_check_th)
 GEN_OPIVI_TRANS_TH(th_vmerge_vim, IMM_SX, th_vmerge_vxm, opivx_vadc_check_th)
 
+/*
+ * Vector Fixed-Point Arithmetic Instructions
+ */
+
+/* Vector Single-Width Saturating Add and Subtract */
+GEN_OPIVV_TRANS_TH(th_vsaddu_vv, opivv_check_th)
+GEN_OPIVV_TRANS_TH(th_vsadd_vv,  opivv_check_th)
+GEN_OPIVV_TRANS_TH(th_vssubu_vv, opivv_check_th)
+GEN_OPIVV_TRANS_TH(th_vssub_vv,  opivv_check_th)
+GEN_OPIVX_TRANS_TH(th_vsaddu_vx,  opivx_check_th)
+GEN_OPIVX_TRANS_TH(th_vsadd_vx,  opivx_check_th)
+GEN_OPIVX_TRANS_TH(th_vssubu_vx,  opivx_check_th)
+GEN_OPIVX_TRANS_TH(th_vssub_vx,  opivx_check_th)
+GEN_OPIVI_TRANS_TH(th_vsaddu_vi, IMM_ZX, th_vsaddu_vx, opivx_check_th)
+GEN_OPIVI_TRANS_TH(th_vsadd_vi, IMM_SX, th_vsadd_vx, opivx_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vsaddu_vv)
-TH_TRANS_STUB(th_vsaddu_vx)
-TH_TRANS_STUB(th_vsaddu_vi)
-TH_TRANS_STUB(th_vsadd_vv)
-TH_TRANS_STUB(th_vsadd_vx)
-TH_TRANS_STUB(th_vsadd_vi)
-TH_TRANS_STUB(th_vssubu_vv)
-TH_TRANS_STUB(th_vssubu_vx)
-TH_TRANS_STUB(th_vssub_vv)
-TH_TRANS_STUB(th_vssub_vx)
 TH_TRANS_STUB(th_vaadd_vv)
 TH_TRANS_STUB(th_vaadd_vx)
 TH_TRANS_STUB(th_vaadd_vi)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 06ca77691d..8664a3d4ef 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -1974,7 +1974,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,     \
                  do_##NAME, ESZ);                               \
 }
 
-static inline uint8_t saddu8(CPURISCVState *env, int vxrm, uint8_t a,
+uint8_t saddu8(CPURISCVState *env, int vxrm, uint8_t a,
                              uint8_t b)
 {
     uint8_t res = a + b;
@@ -1985,7 +1985,7 @@ static inline uint8_t saddu8(CPURISCVState *env, int vxrm, uint8_t a,
     return res;
 }
 
-static inline uint16_t saddu16(CPURISCVState *env, int vxrm, uint16_t a,
+uint16_t saddu16(CPURISCVState *env, int vxrm, uint16_t a,
                                uint16_t b)
 {
     uint16_t res = a + b;
@@ -1996,7 +1996,7 @@ static inline uint16_t saddu16(CPURISCVState *env, int vxrm, uint16_t a,
     return res;
 }
 
-static inline uint32_t saddu32(CPURISCVState *env, int vxrm, uint32_t a,
+uint32_t saddu32(CPURISCVState *env, int vxrm, uint32_t a,
                                uint32_t b)
 {
     uint32_t res = a + b;
@@ -2007,7 +2007,7 @@ static inline uint32_t saddu32(CPURISCVState *env, int vxrm, uint32_t a,
     return res;
 }
 
-static inline uint64_t saddu64(CPURISCVState *env, int vxrm, uint64_t a,
+uint64_t saddu64(CPURISCVState *env, int vxrm, uint64_t a,
                                uint64_t b)
 {
     uint64_t res = a + b;
@@ -2111,7 +2111,7 @@ GEN_VEXT_VX_RM(vsaddu_vx_h, 2)
 GEN_VEXT_VX_RM(vsaddu_vx_w, 4)
 GEN_VEXT_VX_RM(vsaddu_vx_d, 8)
 
-static inline int8_t sadd8(CPURISCVState *env, int vxrm, int8_t a, int8_t b)
+int8_t sadd8(CPURISCVState *env, int vxrm, int8_t a, int8_t b)
 {
     int8_t res = a + b;
     if ((res ^ a) & (res ^ b) & INT8_MIN) {
@@ -2121,7 +2121,7 @@ static inline int8_t sadd8(CPURISCVState *env, int vxrm, int8_t a, int8_t b)
     return res;
 }
 
-static inline int16_t sadd16(CPURISCVState *env, int vxrm, int16_t a,
+int16_t sadd16(CPURISCVState *env, int vxrm, int16_t a,
                              int16_t b)
 {
     int16_t res = a + b;
@@ -2132,7 +2132,7 @@ static inline int16_t sadd16(CPURISCVState *env, int vxrm, int16_t a,
     return res;
 }
 
-static inline int32_t sadd32(CPURISCVState *env, int vxrm, int32_t a,
+int32_t sadd32(CPURISCVState *env, int vxrm, int32_t a,
                              int32_t b)
 {
     int32_t res = a + b;
@@ -2143,7 +2143,7 @@ static inline int32_t sadd32(CPURISCVState *env, int vxrm, int32_t a,
     return res;
 }
 
-static inline int64_t sadd64(CPURISCVState *env, int vxrm, int64_t a,
+int64_t sadd64(CPURISCVState *env, int vxrm, int64_t a,
                              int64_t b)
 {
     int64_t res = a + b;
@@ -2172,7 +2172,7 @@ GEN_VEXT_VX_RM(vsadd_vx_h, 2)
 GEN_VEXT_VX_RM(vsadd_vx_w, 4)
 GEN_VEXT_VX_RM(vsadd_vx_d, 8)
 
-static inline uint8_t ssubu8(CPURISCVState *env, int vxrm, uint8_t a,
+uint8_t ssubu8(CPURISCVState *env, int vxrm, uint8_t a,
                              uint8_t b)
 {
     uint8_t res = a - b;
@@ -2183,7 +2183,7 @@ static inline uint8_t ssubu8(CPURISCVState *env, int vxrm, uint8_t a,
     return res;
 }
 
-static inline uint16_t ssubu16(CPURISCVState *env, int vxrm, uint16_t a,
+uint16_t ssubu16(CPURISCVState *env, int vxrm, uint16_t a,
                                uint16_t b)
 {
     uint16_t res = a - b;
@@ -2194,7 +2194,7 @@ static inline uint16_t ssubu16(CPURISCVState *env, int vxrm, uint16_t a,
     return res;
 }
 
-static inline uint32_t ssubu32(CPURISCVState *env, int vxrm, uint32_t a,
+uint32_t ssubu32(CPURISCVState *env, int vxrm, uint32_t a,
                                uint32_t b)
 {
     uint32_t res = a - b;
@@ -2205,7 +2205,7 @@ static inline uint32_t ssubu32(CPURISCVState *env, int vxrm, uint32_t a,
     return res;
 }
 
-static inline uint64_t ssubu64(CPURISCVState *env, int vxrm, uint64_t a,
+uint64_t ssubu64(CPURISCVState *env, int vxrm, uint64_t a,
                                uint64_t b)
 {
     uint64_t res = a - b;
@@ -2234,7 +2234,7 @@ GEN_VEXT_VX_RM(vssubu_vx_h, 2)
 GEN_VEXT_VX_RM(vssubu_vx_w, 4)
 GEN_VEXT_VX_RM(vssubu_vx_d, 8)
 
-static inline int8_t ssub8(CPURISCVState *env, int vxrm, int8_t a, int8_t b)
+int8_t ssub8(CPURISCVState *env, int vxrm, int8_t a, int8_t b)
 {
     int8_t res = a - b;
     if ((res ^ a) & (a ^ b) & INT8_MIN) {
@@ -2244,7 +2244,7 @@ static inline int8_t ssub8(CPURISCVState *env, int vxrm, int8_t a, int8_t b)
     return res;
 }
 
-static inline int16_t ssub16(CPURISCVState *env, int vxrm, int16_t a,
+int16_t ssub16(CPURISCVState *env, int vxrm, int16_t a,
                              int16_t b)
 {
     int16_t res = a - b;
@@ -2255,7 +2255,7 @@ static inline int16_t ssub16(CPURISCVState *env, int vxrm, int16_t a,
     return res;
 }
 
-static inline int32_t ssub32(CPURISCVState *env, int vxrm, int32_t a,
+int32_t ssub32(CPURISCVState *env, int vxrm, int32_t a,
                              int32_t b)
 {
     int32_t res = a - b;
@@ -2266,7 +2266,7 @@ static inline int32_t ssub32(CPURISCVState *env, int vxrm, int32_t a,
     return res;
 }
 
-static inline int64_t ssub64(CPURISCVState *env, int vxrm, int64_t a,
+int64_t ssub64(CPURISCVState *env, int vxrm, int64_t a,
                              int64_t b)
 {
     int64_t res = a - b;
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index e99caa8e2d..a70ebdabe4 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -284,4 +284,23 @@ int16_t do_mulhsu_h(int16_t s2, uint16_t s1);
 int32_t do_mulhsu_w(int32_t s2, uint32_t s1);
 int64_t do_mulhsu_d(int64_t s2, uint64_t s1);
 
+uint8_t saddu8(CPURISCVState *env, int vxrm, uint8_t a, uint8_t b);
+uint16_t saddu16(CPURISCVState *env, int vxrm, uint16_t a, uint16_t b);
+uint32_t saddu32(CPURISCVState *env, int vxrm, uint32_t a, uint32_t b);
+uint64_t saddu64(CPURISCVState *env, int vxrm, uint64_t a, uint64_t b);
+
+int8_t sadd8(CPURISCVState *env, int vxrm, int8_t a, int8_t b);
+int16_t sadd16(CPURISCVState *env, int vxrm, int16_t a, int16_t b);
+int32_t sadd32(CPURISCVState *env, int vxrm, int32_t a, int32_t b);
+int64_t sadd64(CPURISCVState *env, int vxrm, int64_t a, int64_t b);
+
+int8_t ssub8(CPURISCVState *env, int vxrm, int8_t a, int8_t b);
+int16_t ssub16(CPURISCVState *env, int vxrm, int16_t a, int16_t b);
+int32_t ssub32(CPURISCVState *env, int vxrm, int32_t a, int32_t b);
+int64_t ssub64(CPURISCVState *env, int vxrm, int64_t a, int64_t b);
+
+uint8_t ssubu8(CPURISCVState *env, int vxrm, uint8_t a, uint8_t b);
+uint16_t ssubu16(CPURISCVState *env, int vxrm, uint16_t a, uint16_t b);
+uint32_t ssubu32(CPURISCVState *env, int vxrm, uint32_t a, uint32_t b);
+uint64_t ssubu64(CPURISCVState *env, int vxrm, uint64_t a, uint64_t b);
 #endif /* TARGET_RISCV_VECTOR_INTERNALS_H */
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index d8a0e3af90..5e21ab2e07 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -2027,3 +2027,234 @@ GEN_TH_VMERGE_VX(th_vmerge_vxm_b, int8_t,  H1, clearb_th)
 GEN_TH_VMERGE_VX(th_vmerge_vxm_h, int16_t, H2, clearh_th)
 GEN_TH_VMERGE_VX(th_vmerge_vxm_w, int32_t, H4, clearl_th)
 GEN_TH_VMERGE_VX(th_vmerge_vxm_d, int64_t, H8, clearq_th)
+
+/*
+ * Vector Fixed-Point Arithmetic Instructions
+ */
+
+/* Vector Single-Width Saturating Add and Subtract */
+
+/*
+ * As fixed point instructions probably have round mode and saturation,
+ * define common macros for fixed point here.
+ */
+typedef void opivv2_rm_fn_th(void *vd, void *vs1, void *vs2, int i,
+                             CPURISCVState *env, int vxrm);
+
+/*
+ * The functions of fix-point operations below are just the copies of
+ * functions in RVV1.0.
+ * The changes in these functions are:
+ * 1) different desc encoding
+ * 2) different tail/masked element process policy
+ * 3) different mask layout
+ */
+#define TH_OPIVV2_RM(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP)  \
+static inline void                                                  \
+do_##NAME(void *vd, void *vs1, void *vs2, int i,                    \
+          CPURISCVState *env, int vxrm)                             \
+{                                                                   \
+    TX1 s1 = *((T1 *)vs1 + HS1(i));                                 \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
+    *((TD *)vd + HD(i)) = OP(env, vxrm, s2, s1);                    \
+}
+
+static inline void
+th_vv_rm_1(void *vd, void *v0, void *vs1, void *vs2,
+           CPURISCVState *env,
+           uint32_t vl, uint32_t vm, uint32_t mlen, int vxrm,
+           opivv2_rm_fn_th *fn)
+{
+    VSTART_CHECK_EARLY_EXIT(env);
+    for (uint32_t i = env->vstart; i < vl; i++) {
+        if (!vm && !th_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        fn(vd, vs1, vs2, i, env, vxrm);
+    }
+    env->vstart = 0;
+}
+
+static inline void
+th_vv_rm_2(void *vd, void *v0, void *vs1, void *vs2,
+           CPURISCVState *env,
+           uint32_t desc, uint32_t esz, uint32_t dsz,
+           opivv2_rm_fn_th *fn, clear_fn *clearfn)
+{
+    uint32_t vlmax = th_maxsz(desc) / esz;
+    uint32_t mlen = th_mlen(desc);
+    uint32_t vm = th_vm(desc);
+    uint32_t vl = env->vl;
+
+    switch (env->vxrm) {
+    case 0: /* rnu */
+        th_vv_rm_1(vd, v0, vs1, vs2,
+                   env, vl, vm, mlen, 0, fn);
+        break;
+    case 1: /* rne */
+        th_vv_rm_1(vd, v0, vs1, vs2,
+                   env, vl, vm, mlen, 1, fn);
+        break;
+    case 2: /* rdn */
+        th_vv_rm_1(vd, v0, vs1, vs2,
+                   env, vl, vm, mlen, 2, fn);
+        break;
+    default: /* rod */
+        th_vv_rm_1(vd, v0, vs1, vs2,
+                   env, vl, vm, mlen, 3, fn);
+        break;
+    }
+
+    clearfn(vd, vl, vl * dsz,  vlmax * dsz);
+}
+
+/* generate helpers for fixed point instructions with OPIVV format */
+#define GEN_TH_VV_RM(NAME, ESZ, DSZ, CLEAR_FN)                  \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,     \
+                  CPURISCVState *env, uint32_t desc)            \
+{                                                               \
+    th_vv_rm_2(vd, v0, vs1, vs2, env, desc, ESZ, DSZ,           \
+               do_##NAME, CLEAR_FN);                            \
+}
+
+THCALL(TH_OPIVV2_RM, th_vsaddu_vv_b, OP_UUU_B, H1, H1, H1, saddu8)
+THCALL(TH_OPIVV2_RM, th_vsaddu_vv_h, OP_UUU_H, H2, H2, H2, saddu16)
+THCALL(TH_OPIVV2_RM, th_vsaddu_vv_w, OP_UUU_W, H4, H4, H4, saddu32)
+THCALL(TH_OPIVV2_RM, th_vsaddu_vv_d, OP_UUU_D, H8, H8, H8, saddu64)
+GEN_TH_VV_RM(th_vsaddu_vv_b, 1, 1, clearb_th)
+GEN_TH_VV_RM(th_vsaddu_vv_h, 2, 2, clearh_th)
+GEN_TH_VV_RM(th_vsaddu_vv_w, 4, 4, clearl_th)
+GEN_TH_VV_RM(th_vsaddu_vv_d, 8, 8, clearq_th)
+
+typedef void opivx2_rm_fn_th(void *vd, target_long s1, void *vs2, int i,
+                             CPURISCVState *env, int vxrm);
+
+#define TH_OPIVX2_RM(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)       \
+static inline void                                                  \
+do_##NAME(void *vd, target_long s1, void *vs2, int i,               \
+          CPURISCVState *env, int vxrm)                             \
+{                                                                   \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
+    *((TD *)vd + HD(i)) = OP(env, vxrm, s2, (TX1)(T1)s1);           \
+}
+
+static inline void
+th_vx_rm_1(void *vd, void *v0, target_long s1, void *vs2,
+           CPURISCVState *env,
+           uint32_t vl, uint32_t vm, uint32_t mlen, int vxrm,
+           opivx2_rm_fn_th *fn)
+{
+    VSTART_CHECK_EARLY_EXIT(env);
+    for (uint32_t i = env->vstart; i < vl; i++) {
+        if (!vm && !th_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        fn(vd, s1, vs2, i, env, vxrm);
+    }
+    env->vstart = 0;
+}
+
+static inline void
+th_vx_rm_2(void *vd, void *v0, target_long s1, void *vs2,
+           CPURISCVState *env,
+           uint32_t desc, uint32_t esz, uint32_t dsz,
+           opivx2_rm_fn_th *fn, clear_fn *clearfn)
+{
+    uint32_t vlmax = th_maxsz(desc) / esz;
+    uint32_t mlen = th_mlen(desc);
+    uint32_t vm = th_vm(desc);
+    uint32_t vl = env->vl;
+
+    switch (env->vxrm) {
+    case 0: /* rnu */
+        th_vx_rm_1(vd, v0, s1, vs2,
+                   env, vl, vm, mlen, 0, fn);
+        break;
+    case 1: /* rne */
+        th_vx_rm_1(vd, v0, s1, vs2,
+                   env, vl, vm, mlen, 1, fn);
+        break;
+    case 2: /* rdn */
+        th_vx_rm_1(vd, v0, s1, vs2,
+                   env, vl, vm, mlen, 2, fn);
+        break;
+    default: /* rod */
+        th_vx_rm_1(vd, v0, s1, vs2,
+                   env, vl, vm, mlen, 3, fn);
+        break;
+    }
+
+    clearfn(vd, vl, vl * dsz,  vlmax * dsz);
+}
+
+/* generate helpers for fixed point instructions with OPIVX format */
+#define GEN_TH_VX_RM(NAME, ESZ, DSZ, CLEAR_FN)            \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1,    \
+        void *vs2, CPURISCVState *env, uint32_t desc)     \
+{                                                         \
+    th_vx_rm_2(vd, v0, s1, vs2, env, desc, ESZ, DSZ,      \
+               do_##NAME, CLEAR_FN);                      \
+}
+
+THCALL(TH_OPIVX2_RM, th_vsaddu_vx_b, OP_UUU_B, H1, H1, saddu8)
+THCALL(TH_OPIVX2_RM, th_vsaddu_vx_h, OP_UUU_H, H2, H2, saddu16)
+THCALL(TH_OPIVX2_RM, th_vsaddu_vx_w, OP_UUU_W, H4, H4, saddu32)
+THCALL(TH_OPIVX2_RM, th_vsaddu_vx_d, OP_UUU_D, H8, H8, saddu64)
+GEN_TH_VX_RM(th_vsaddu_vx_b, 1, 1, clearb_th)
+GEN_TH_VX_RM(th_vsaddu_vx_h, 2, 2, clearh_th)
+GEN_TH_VX_RM(th_vsaddu_vx_w, 4, 4, clearl_th)
+GEN_TH_VX_RM(th_vsaddu_vx_d, 8, 8, clearq_th)
+
+THCALL(TH_OPIVV2_RM, th_vsadd_vv_b, OP_SSS_B, H1, H1, H1, sadd8)
+THCALL(TH_OPIVV2_RM, th_vsadd_vv_h, OP_SSS_H, H2, H2, H2, sadd16)
+THCALL(TH_OPIVV2_RM, th_vsadd_vv_w, OP_SSS_W, H4, H4, H4, sadd32)
+THCALL(TH_OPIVV2_RM, th_vsadd_vv_d, OP_SSS_D, H8, H8, H8, sadd64)
+GEN_TH_VV_RM(th_vsadd_vv_b, 1, 1, clearb_th)
+GEN_TH_VV_RM(th_vsadd_vv_h, 2, 2, clearh_th)
+GEN_TH_VV_RM(th_vsadd_vv_w, 4, 4, clearl_th)
+GEN_TH_VV_RM(th_vsadd_vv_d, 8, 8, clearq_th)
+
+THCALL(TH_OPIVX2_RM, th_vsadd_vx_b, OP_SSS_B, H1, H1, sadd8)
+THCALL(TH_OPIVX2_RM, th_vsadd_vx_h, OP_SSS_H, H2, H2, sadd16)
+THCALL(TH_OPIVX2_RM, th_vsadd_vx_w, OP_SSS_W, H4, H4, sadd32)
+THCALL(TH_OPIVX2_RM, th_vsadd_vx_d, OP_SSS_D, H8, H8, sadd64)
+GEN_TH_VX_RM(th_vsadd_vx_b, 1, 1, clearb_th)
+GEN_TH_VX_RM(th_vsadd_vx_h, 2, 2, clearh_th)
+GEN_TH_VX_RM(th_vsadd_vx_w, 4, 4, clearl_th)
+GEN_TH_VX_RM(th_vsadd_vx_d, 8, 8, clearq_th)
+
+THCALL(TH_OPIVV2_RM, th_vssubu_vv_b, OP_UUU_B, H1, H1, H1, ssubu8)
+THCALL(TH_OPIVV2_RM, th_vssubu_vv_h, OP_UUU_H, H2, H2, H2, ssubu16)
+THCALL(TH_OPIVV2_RM, th_vssubu_vv_w, OP_UUU_W, H4, H4, H4, ssubu32)
+THCALL(TH_OPIVV2_RM, th_vssubu_vv_d, OP_UUU_D, H8, H8, H8, ssubu64)
+GEN_TH_VV_RM(th_vssubu_vv_b, 1, 1, clearb_th)
+GEN_TH_VV_RM(th_vssubu_vv_h, 2, 2, clearh_th)
+GEN_TH_VV_RM(th_vssubu_vv_w, 4, 4, clearl_th)
+GEN_TH_VV_RM(th_vssubu_vv_d, 8, 8, clearq_th)
+
+THCALL(TH_OPIVX2_RM, th_vssubu_vx_b, OP_UUU_B, H1, H1, ssubu8)
+THCALL(TH_OPIVX2_RM, th_vssubu_vx_h, OP_UUU_H, H2, H2, ssubu16)
+THCALL(TH_OPIVX2_RM, th_vssubu_vx_w, OP_UUU_W, H4, H4, ssubu32)
+THCALL(TH_OPIVX2_RM, th_vssubu_vx_d, OP_UUU_D, H8, H8, ssubu64)
+GEN_TH_VX_RM(th_vssubu_vx_b, 1, 1, clearb_th)
+GEN_TH_VX_RM(th_vssubu_vx_h, 2, 2, clearh_th)
+GEN_TH_VX_RM(th_vssubu_vx_w, 4, 4, clearl_th)
+GEN_TH_VX_RM(th_vssubu_vx_d, 8, 8, clearq_th)
+
+THCALL(TH_OPIVV2_RM, th_vssub_vv_b, OP_SSS_B, H1, H1, H1, ssub8)
+THCALL(TH_OPIVV2_RM, th_vssub_vv_h, OP_SSS_H, H2, H2, H2, ssub16)
+THCALL(TH_OPIVV2_RM, th_vssub_vv_w, OP_SSS_W, H4, H4, H4, ssub32)
+THCALL(TH_OPIVV2_RM, th_vssub_vv_d, OP_SSS_D, H8, H8, H8, ssub64)
+GEN_TH_VV_RM(th_vssub_vv_b, 1, 1, clearb_th)
+GEN_TH_VV_RM(th_vssub_vv_h, 2, 2, clearh_th)
+GEN_TH_VV_RM(th_vssub_vv_w, 4, 4, clearl_th)
+GEN_TH_VV_RM(th_vssub_vv_d, 8, 8, clearq_th)
+
+THCALL(TH_OPIVX2_RM, th_vssub_vx_b, OP_SSS_B, H1, H1, ssub8)
+THCALL(TH_OPIVX2_RM, th_vssub_vx_h, OP_SSS_H, H2, H2, ssub16)
+THCALL(TH_OPIVX2_RM, th_vssub_vx_w, OP_SSS_W, H4, H4, ssub32)
+THCALL(TH_OPIVX2_RM, th_vssub_vx_d, OP_SSS_D, H8, H8, ssub64)
+GEN_TH_VX_RM(th_vssub_vx_b, 1, 1, clearb_th)
+GEN_TH_VX_RM(th_vssub_vx_h, 2, 2, clearh_th)
+GEN_TH_VX_RM(th_vssub_vx_w, 4, 4, clearl_th)
+GEN_TH_VX_RM(th_vssub_vx_d, 8, 8, clearq_th)
-- 
2.44.0


