Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A165C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvCbH-0001Iv-5K; Fri, 12 Apr 2024 04:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCbE-0001Ie-NX; Fri, 12 Apr 2024 04:49:32 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCbB-0005Gb-Ku; Fri, 12 Apr 2024 04:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712911764; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=uHj4HVxobXUy4ZlMB2RX3KERQ7oVvKO031CGOKwBY9o=;
 b=X1MrwWgiW8Mcp0tyTseqOow1PJRcI/VjP2sESjOk5jRE/et+MnI9kguqNS45OeQmA12O0BvGvXVnMzYVo+SuBNI3gk4lHCphtsyLd2soiXsuPMctRa91Rn3KaWyRw4jjoBYw+ZcsKzchB5jGAOdygZTt0txNGC0rcOnugvLB6q4=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4Nohny_1712911763; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4Nohny_1712911763) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 16:49:23 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 35/65] target/riscv: Add narrowing fixed-point clip
 instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:37:05 +0800
Message-ID: <20240412073735.76413-36-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.133;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-133.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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
 target/riscv/helper.h                         | 13 +++++++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 14 +++++----
 target/riscv/vector_helper.c                  | 26 ++++-------------
 target/riscv/vector_internals.h               | 14 +++++++++
 target/riscv/xtheadvector_helper.c            | 29 +++++++++++++++++++
 5 files changed, 70 insertions(+), 26 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 70d3f34a59..6254be771f 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1983,3 +1983,16 @@ DEF_HELPER_6(th_vssra_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vssra_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vssra_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vssra_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(th_vnclip_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vnclip_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vnclip_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vnclipu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vnclipu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vnclipu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vnclipu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vnclipu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vnclipu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vnclip_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vnclip_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vnclip_vx_w, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index d1f523832b..108f3249d0 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -1738,18 +1738,20 @@ GEN_OPIVX_TRANS_TH(th_vssra_vx,  opivx_check_th)
 GEN_OPIVI_TRANS_TH(th_vssrl_vi, IMM_TRUNC_SEW, th_vssrl_vx, opivx_check_th)
 GEN_OPIVI_TRANS_TH(th_vssra_vi, IMM_TRUNC_SEW, th_vssra_vx, opivx_check_th)
 
+/* Vector Narrowing Fixed-Point Clip Instructions */
+GEN_OPIVV_NARROW_TRANS_TH(th_vnclipu_vv)
+GEN_OPIVV_NARROW_TRANS_TH(th_vnclip_vv)
+GEN_OPIVX_NARROW_TRANS_TH(th_vnclipu_vx)
+GEN_OPIVX_NARROW_TRANS_TH(th_vnclip_vx)
+GEN_OPIVI_NARROW_TRANS_TH(th_vnclipu_vi, IMM_ZX, th_vnclipu_vx)
+GEN_OPIVI_NARROW_TRANS_TH(th_vnclip_vi, IMM_ZX, th_vnclip_vx)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vnclipu_vv)
-TH_TRANS_STUB(th_vnclipu_vx)
-TH_TRANS_STUB(th_vnclipu_vi)
-TH_TRANS_STUB(th_vnclip_vv)
-TH_TRANS_STUB(th_vnclip_vx)
-TH_TRANS_STUB(th_vnclip_vi)
 TH_TRANS_STUB(th_vfadd_vv)
 TH_TRANS_STUB(th_vfadd_vf)
 TH_TRANS_STUB(th_vfsub_vv)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index be1f1bc8e2..262cb28824 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -646,14 +646,6 @@ GEN_VEXT_ST_WHOLE(vs8r_v, int8_t, ste_b)
  * Vector Integer Arithmetic Instructions
  */
 
-/* (TD, T1, T2, TX1, TX2) */
-#define NOP_SSS_B int8_t, int8_t, int16_t, int8_t, int16_t
-#define NOP_SSS_H int16_t, int16_t, int32_t, int16_t, int32_t
-#define NOP_SSS_W int32_t, int32_t, int64_t, int32_t, int64_t
-#define NOP_UUU_B uint8_t, uint8_t, uint16_t, uint8_t, uint16_t
-#define NOP_UUU_H uint16_t, uint16_t, uint32_t, uint16_t, uint32_t
-#define NOP_UUU_W uint32_t, uint32_t, uint64_t, uint32_t, uint64_t
-
 #define DO_SUB(N, M) (N - M)
 #define DO_RSUB(N, M) (M - N)
 
@@ -2677,8 +2669,7 @@ GEN_VEXT_VX_RM(vssra_vx_w, 4)
 GEN_VEXT_VX_RM(vssra_vx_d, 8)
 
 /* Vector Narrowing Fixed-Point Clip Instructions */
-static inline int8_t
-vnclip8(CPURISCVState *env, int vxrm, int16_t a, int8_t b)
+int8_t vnclip8(CPURISCVState *env, int vxrm, int16_t a, int8_t b)
 {
     uint8_t round, shift = b & 0xf;
     int16_t res;
@@ -2696,8 +2687,7 @@ vnclip8(CPURISCVState *env, int vxrm, int16_t a, int8_t b)
     }
 }
 
-static inline int16_t
-vnclip16(CPURISCVState *env, int vxrm, int32_t a, int16_t b)
+int16_t vnclip16(CPURISCVState *env, int vxrm, int32_t a, int16_t b)
 {
     uint8_t round, shift = b & 0x1f;
     int32_t res;
@@ -2715,8 +2705,7 @@ vnclip16(CPURISCVState *env, int vxrm, int32_t a, int16_t b)
     }
 }
 
-static inline int32_t
-vnclip32(CPURISCVState *env, int vxrm, int64_t a, int32_t b)
+int32_t vnclip32(CPURISCVState *env, int vxrm, int64_t a, int32_t b)
 {
     uint8_t round, shift = b & 0x3f;
     int64_t res;
@@ -2748,8 +2737,7 @@ GEN_VEXT_VX_RM(vnclip_wx_b, 1)
 GEN_VEXT_VX_RM(vnclip_wx_h, 2)
 GEN_VEXT_VX_RM(vnclip_wx_w, 4)
 
-static inline uint8_t
-vnclipu8(CPURISCVState *env, int vxrm, uint16_t a, uint8_t b)
+uint8_t vnclipu8(CPURISCVState *env, int vxrm, uint16_t a, uint8_t b)
 {
     uint8_t round, shift = b & 0xf;
     uint16_t res;
@@ -2764,8 +2752,7 @@ vnclipu8(CPURISCVState *env, int vxrm, uint16_t a, uint8_t b)
     }
 }
 
-static inline uint16_t
-vnclipu16(CPURISCVState *env, int vxrm, uint32_t a, uint16_t b)
+uint16_t vnclipu16(CPURISCVState *env, int vxrm, uint32_t a, uint16_t b)
 {
     uint8_t round, shift = b & 0x1f;
     uint32_t res;
@@ -2780,8 +2767,7 @@ vnclipu16(CPURISCVState *env, int vxrm, uint32_t a, uint16_t b)
     }
 }
 
-static inline uint32_t
-vnclipu32(CPURISCVState *env, int vxrm, uint64_t a, uint32_t b)
+uint32_t vnclipu32(CPURISCVState *env, int vxrm, uint64_t a, uint32_t b)
 {
     uint8_t round, shift = b & 0x3f;
     uint64_t res;
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index 02b5fd49f0..a42dc080ec 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -255,6 +255,12 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,    \
 #define WOP_SSU_B int16_t, int8_t, uint8_t, int16_t, uint16_t
 #define WOP_SSU_H int32_t, int16_t, uint16_t, int32_t, uint32_t
 #define WOP_SSU_W int64_t, int32_t, uint32_t, int64_t, uint64_t
+#define NOP_SSS_B int8_t, int8_t, int16_t, int8_t, int16_t
+#define NOP_SSS_H int16_t, int16_t, int32_t, int16_t, int32_t
+#define NOP_SSS_W int32_t, int32_t, int64_t, int32_t, int64_t
+#define NOP_UUU_B uint8_t, uint8_t, uint16_t, uint8_t, uint16_t
+#define NOP_UUU_H uint16_t, uint16_t, uint32_t, uint16_t, uint32_t
+#define NOP_UUU_W uint32_t, uint32_t, uint64_t, uint32_t, uint64_t
 
 /* share functions */
 static inline target_ulong adjust_addr(CPURISCVState *env, target_ulong addr)
@@ -326,4 +332,12 @@ int16_t vssra16(CPURISCVState *env, int vxrm, int16_t a, int16_t b);
 int32_t vssra32(CPURISCVState *env, int vxrm, int32_t a, int32_t b);
 int64_t vssra64(CPURISCVState *env, int vxrm, int64_t a, int64_t b);
 
+int8_t vnclip8(CPURISCVState *env, int vxrm, int16_t a, int8_t b);
+int16_t vnclip16(CPURISCVState *env, int vxrm, int32_t a, int16_t b);
+int32_t vnclip32(CPURISCVState *env, int vxrm, int64_t a, int32_t b);
+
+uint8_t vnclipu8(CPURISCVState *env, int vxrm, uint16_t a, uint8_t b);
+uint16_t vnclipu16(CPURISCVState *env, int vxrm, uint32_t a, uint16_t b);
+uint32_t vnclipu32(CPURISCVState *env, int vxrm, uint64_t a, uint32_t b);
+
 #endif /* TARGET_RISCV_VECTOR_INTERNALS_H */
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 8cd3fd028b..2e97a95392 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -2561,3 +2561,32 @@ GEN_TH_VX_RM(th_vssra_vx_b, 1, 1, clearb_th)
 GEN_TH_VX_RM(th_vssra_vx_h, 2, 2, clearh_th)
 GEN_TH_VX_RM(th_vssra_vx_w, 4, 4, clearl_th)
 GEN_TH_VX_RM(th_vssra_vx_d, 8, 8, clearq_th)
+
+/* Vector Narrowing Fixed-Point Clip Instructions */
+THCALL(TH_OPIVV2_RM, th_vnclip_vv_b, NOP_SSS_B, H1, H2, H1, vnclip8)
+THCALL(TH_OPIVV2_RM, th_vnclip_vv_h, NOP_SSS_H, H2, H4, H2, vnclip16)
+THCALL(TH_OPIVV2_RM, th_vnclip_vv_w, NOP_SSS_W, H4, H8, H4, vnclip32)
+GEN_TH_VV_RM(th_vnclip_vv_b, 1, 1, clearb_th)
+GEN_TH_VV_RM(th_vnclip_vv_h, 2, 2, clearh_th)
+GEN_TH_VV_RM(th_vnclip_vv_w, 4, 4, clearl_th)
+
+THCALL(TH_OPIVX2_RM, th_vnclip_vx_b, NOP_SSS_B, H1, H2, vnclip8)
+THCALL(TH_OPIVX2_RM, th_vnclip_vx_h, NOP_SSS_H, H2, H4, vnclip16)
+THCALL(TH_OPIVX2_RM, th_vnclip_vx_w, NOP_SSS_W, H4, H8, vnclip32)
+GEN_TH_VX_RM(th_vnclip_vx_b, 1, 1, clearb_th)
+GEN_TH_VX_RM(th_vnclip_vx_h, 2, 2, clearh_th)
+GEN_TH_VX_RM(th_vnclip_vx_w, 4, 4, clearl_th)
+
+THCALL(TH_OPIVV2_RM, th_vnclipu_vv_b, NOP_UUU_B, H1, H2, H1, vnclipu8)
+THCALL(TH_OPIVV2_RM, th_vnclipu_vv_h, NOP_UUU_H, H2, H4, H2, vnclipu16)
+THCALL(TH_OPIVV2_RM, th_vnclipu_vv_w, NOP_UUU_W, H4, H8, H4, vnclipu32)
+GEN_TH_VV_RM(th_vnclipu_vv_b, 1, 1, clearb_th)
+GEN_TH_VV_RM(th_vnclipu_vv_h, 2, 2, clearh_th)
+GEN_TH_VV_RM(th_vnclipu_vv_w, 4, 4, clearl_th)
+
+THCALL(TH_OPIVX2_RM, th_vnclipu_vx_b, NOP_UUU_B, H1, H2, vnclipu8)
+THCALL(TH_OPIVX2_RM, th_vnclipu_vx_h, NOP_UUU_H, H2, H4, vnclipu16)
+THCALL(TH_OPIVX2_RM, th_vnclipu_vx_w, NOP_UUU_W, H4, H8, vnclipu32)
+GEN_TH_VX_RM(th_vnclipu_vx_b, 1, 1, clearb_th)
+GEN_TH_VX_RM(th_vnclipu_vx_h, 2, 2, clearh_th)
+GEN_TH_VX_RM(th_vnclipu_vx_w, 4, 4, clearl_th)
-- 
2.44.0


