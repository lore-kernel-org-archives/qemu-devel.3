Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1673AC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvCZY-0008G6-9X; Fri, 12 Apr 2024 04:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCZP-00085H-75; Fri, 12 Apr 2024 04:47:44 -0400
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCZH-00053f-K3; Fri, 12 Apr 2024 04:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712911643; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=u4+DkqirLDfgVnFo+QL+8djwBn76H13Ork4i/falbKI=;
 b=aqo8TkoIa3R2pn0huN7txZJxdmKq+0vxlOIXIq45WKbal4GIrghEhLHEsvFE3AqyKjaUTsURMXqHper024dcAfXuOmTn0RZgWJtn1B4GfrJwlqM6MBnj64Yivn5sy6DXgUjMqu0nEirQvgMjKmQKkzVTZul1J6ta7TCsy/vJJzM=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R811e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NqAEn_1712911641; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NqAEn_1712911641) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 16:47:22 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 34/65] target/riscv: Add single-width scaling shift
 instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:37:04 +0800
Message-ID: <20240412073735.76413-35-eric.huang@linux.alibaba.com>
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
 target/riscv/helper.h                         | 17 +++++++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 14 ++++---
 target/riscv/vector_helper.c                  | 24 ++++--------
 target/riscv/vector_internals.h               | 10 +++++
 target/riscv/xtheadvector_helper.c            | 38 +++++++++++++++++++
 5 files changed, 81 insertions(+), 22 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index d45477ee1b..70d3f34a59 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1966,3 +1966,20 @@ DEF_HELPER_6(th_vwsmaccsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vwsmaccus_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vwsmaccus_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vwsmaccus_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(th_vssrl_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vssrl_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vssrl_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vssrl_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vssra_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vssra_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vssra_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vssra_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vssrl_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vssrl_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vssrl_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vssrl_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vssra_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vssra_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vssra_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vssra_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 175516e3a7..d1f523832b 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -1730,18 +1730,20 @@ GEN_OPIVX_WIDEN_TRANS_TH(th_vwsmacc_vx, opivx_widen_check_th)
 GEN_OPIVX_WIDEN_TRANS_TH(th_vwsmaccsu_vx, opivx_widen_check_th)
 GEN_OPIVX_WIDEN_TRANS_TH(th_vwsmaccus_vx, opivx_widen_check_th)
 
+/* Vector Single-Width Scaling Shift Instructions */
+GEN_OPIVV_TRANS_TH(th_vssrl_vv, opivv_check_th)
+GEN_OPIVV_TRANS_TH(th_vssra_vv, opivv_check_th)
+GEN_OPIVX_TRANS_TH(th_vssrl_vx,  opivx_check_th)
+GEN_OPIVX_TRANS_TH(th_vssra_vx,  opivx_check_th)
+GEN_OPIVI_TRANS_TH(th_vssrl_vi, IMM_TRUNC_SEW, th_vssrl_vx, opivx_check_th)
+GEN_OPIVI_TRANS_TH(th_vssra_vi, IMM_TRUNC_SEW, th_vssra_vx, opivx_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vssrl_vv)
-TH_TRANS_STUB(th_vssrl_vx)
-TH_TRANS_STUB(th_vssrl_vi)
-TH_TRANS_STUB(th_vssra_vv)
-TH_TRANS_STUB(th_vssra_vx)
-TH_TRANS_STUB(th_vssra_vi)
 TH_TRANS_STUB(th_vnclipu_vv)
 TH_TRANS_STUB(th_vnclipu_vx)
 TH_TRANS_STUB(th_vnclipu_vi)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index ec11acf487..be1f1bc8e2 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -2581,8 +2581,7 @@ GEN_VEXT_VX_RM(vsmul_vx_w, 4)
 GEN_VEXT_VX_RM(vsmul_vx_d, 8)
 
 /* Vector Single-Width Scaling Shift Instructions */
-static inline uint8_t
-vssrl8(CPURISCVState *env, int vxrm, uint8_t a, uint8_t b)
+uint8_t vssrl8(CPURISCVState *env, int vxrm, uint8_t a, uint8_t b)
 {
     uint8_t round, shift = b & 0x7;
     uint8_t res;
@@ -2591,24 +2590,21 @@ vssrl8(CPURISCVState *env, int vxrm, uint8_t a, uint8_t b)
     res = (a >> shift) + round;
     return res;
 }
-static inline uint16_t
-vssrl16(CPURISCVState *env, int vxrm, uint16_t a, uint16_t b)
+uint16_t vssrl16(CPURISCVState *env, int vxrm, uint16_t a, uint16_t b)
 {
     uint8_t round, shift = b & 0xf;
 
     round = get_round(vxrm, a, shift);
     return (a >> shift) + round;
 }
-static inline uint32_t
-vssrl32(CPURISCVState *env, int vxrm, uint32_t a, uint32_t b)
+uint32_t vssrl32(CPURISCVState *env, int vxrm, uint32_t a, uint32_t b)
 {
     uint8_t round, shift = b & 0x1f;
 
     round = get_round(vxrm, a, shift);
     return (a >> shift) + round;
 }
-static inline uint64_t
-vssrl64(CPURISCVState *env, int vxrm, uint64_t a, uint64_t b)
+uint64_t vssrl64(CPURISCVState *env, int vxrm, uint64_t a, uint64_t b)
 {
     uint8_t round, shift = b & 0x3f;
 
@@ -2633,32 +2629,28 @@ GEN_VEXT_VX_RM(vssrl_vx_h, 2)
 GEN_VEXT_VX_RM(vssrl_vx_w, 4)
 GEN_VEXT_VX_RM(vssrl_vx_d, 8)
 
-static inline int8_t
-vssra8(CPURISCVState *env, int vxrm, int8_t a, int8_t b)
+int8_t vssra8(CPURISCVState *env, int vxrm, int8_t a, int8_t b)
 {
     uint8_t round, shift = b & 0x7;
 
     round = get_round(vxrm, a, shift);
     return (a >> shift) + round;
 }
-static inline int16_t
-vssra16(CPURISCVState *env, int vxrm, int16_t a, int16_t b)
+int16_t vssra16(CPURISCVState *env, int vxrm, int16_t a, int16_t b)
 {
     uint8_t round, shift = b & 0xf;
 
     round = get_round(vxrm, a, shift);
     return (a >> shift) + round;
 }
-static inline int32_t
-vssra32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
+int32_t vssra32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
 {
     uint8_t round, shift = b & 0x1f;
 
     round = get_round(vxrm, a, shift);
     return (a >> shift) + round;
 }
-static inline int64_t
-vssra64(CPURISCVState *env, int vxrm, int64_t a, int64_t b)
+int64_t vssra64(CPURISCVState *env, int vxrm, int64_t a, int64_t b)
 {
     uint8_t round, shift = b & 0x3f;
 
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index 99f69ef8fa..02b5fd49f0 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -316,4 +316,14 @@ int64_t vsmul64(CPURISCVState *env, int vxrm, int64_t a, int64_t b);
 
 uint8_t get_round(int vxrm, uint64_t v, uint8_t shift);
 
+uint8_t vssrl8(CPURISCVState *env, int vxrm, uint8_t a, uint8_t b);
+uint16_t vssrl16(CPURISCVState *env, int vxrm, uint16_t a, uint16_t b);
+uint32_t vssrl32(CPURISCVState *env, int vxrm, uint32_t a, uint32_t b);
+uint64_t vssrl64(CPURISCVState *env, int vxrm, uint64_t a, uint64_t b);
+
+int8_t vssra8(CPURISCVState *env, int vxrm, int8_t a, int8_t b);
+int16_t vssra16(CPURISCVState *env, int vxrm, int16_t a, int16_t b);
+int32_t vssra32(CPURISCVState *env, int vxrm, int32_t a, int32_t b);
+int64_t vssra64(CPURISCVState *env, int vxrm, int64_t a, int64_t b);
+
 #endif /* TARGET_RISCV_VECTOR_INTERNALS_H */
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 1964855d2d..8cd3fd028b 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -2523,3 +2523,41 @@ THCALL(TH_OPIVX3_RM, th_vwsmaccus_vx_w, WOP_SUS_W, H8, H4, vwsmaccus32)
 GEN_TH_VX_RM(th_vwsmaccus_vx_b, 1, 2, clearh_th)
 GEN_TH_VX_RM(th_vwsmaccus_vx_h, 2, 4, clearl_th)
 GEN_TH_VX_RM(th_vwsmaccus_vx_w, 4, 8, clearq_th)
+
+/* Vector Single-Width Scaling Shift Instructions */
+
+THCALL(TH_OPIVV2_RM, th_vssrl_vv_b, OP_UUU_B, H1, H1, H1, vssrl8)
+THCALL(TH_OPIVV2_RM, th_vssrl_vv_h, OP_UUU_H, H2, H2, H2, vssrl16)
+THCALL(TH_OPIVV2_RM, th_vssrl_vv_w, OP_UUU_W, H4, H4, H4, vssrl32)
+THCALL(TH_OPIVV2_RM, th_vssrl_vv_d, OP_UUU_D, H8, H8, H8, vssrl64)
+GEN_TH_VV_RM(th_vssrl_vv_b, 1, 1, clearb_th)
+GEN_TH_VV_RM(th_vssrl_vv_h, 2, 2, clearh_th)
+GEN_TH_VV_RM(th_vssrl_vv_w, 4, 4, clearl_th)
+GEN_TH_VV_RM(th_vssrl_vv_d, 8, 8, clearq_th)
+
+THCALL(TH_OPIVX2_RM, th_vssrl_vx_b, OP_UUU_B, H1, H1, vssrl8)
+THCALL(TH_OPIVX2_RM, th_vssrl_vx_h, OP_UUU_H, H2, H2, vssrl16)
+THCALL(TH_OPIVX2_RM, th_vssrl_vx_w, OP_UUU_W, H4, H4, vssrl32)
+THCALL(TH_OPIVX2_RM, th_vssrl_vx_d, OP_UUU_D, H8, H8, vssrl64)
+GEN_TH_VX_RM(th_vssrl_vx_b, 1, 1, clearb_th)
+GEN_TH_VX_RM(th_vssrl_vx_h, 2, 2, clearh_th)
+GEN_TH_VX_RM(th_vssrl_vx_w, 4, 4, clearl_th)
+GEN_TH_VX_RM(th_vssrl_vx_d, 8, 8, clearq_th)
+
+THCALL(TH_OPIVV2_RM, th_vssra_vv_b, OP_SSS_B, H1, H1, H1, vssra8)
+THCALL(TH_OPIVV2_RM, th_vssra_vv_h, OP_SSS_H, H2, H2, H2, vssra16)
+THCALL(TH_OPIVV2_RM, th_vssra_vv_w, OP_SSS_W, H4, H4, H4, vssra32)
+THCALL(TH_OPIVV2_RM, th_vssra_vv_d, OP_SSS_D, H8, H8, H8, vssra64)
+GEN_TH_VV_RM(th_vssra_vv_b, 1, 1, clearb_th)
+GEN_TH_VV_RM(th_vssra_vv_h, 2, 2, clearh_th)
+GEN_TH_VV_RM(th_vssra_vv_w, 4, 4, clearl_th)
+GEN_TH_VV_RM(th_vssra_vv_d, 8, 8, clearq_th)
+
+THCALL(TH_OPIVX2_RM, th_vssra_vx_b, OP_SSS_B, H1, H1, vssra8)
+THCALL(TH_OPIVX2_RM, th_vssra_vx_h, OP_SSS_H, H2, H2, vssra16)
+THCALL(TH_OPIVX2_RM, th_vssra_vx_w, OP_SSS_W, H4, H4, vssra32)
+THCALL(TH_OPIVX2_RM, th_vssra_vx_d, OP_SSS_D, H8, H8, vssra64)
+GEN_TH_VX_RM(th_vssra_vx_b, 1, 1, clearb_th)
+GEN_TH_VX_RM(th_vssra_vx_h, 2, 2, clearh_th)
+GEN_TH_VX_RM(th_vssra_vx_w, 4, 4, clearl_th)
+GEN_TH_VX_RM(th_vssra_vx_d, 8, 8, clearq_th)
-- 
2.44.0


