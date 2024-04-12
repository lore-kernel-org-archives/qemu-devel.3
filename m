Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B646FC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvCFo-0008EE-If; Fri, 12 Apr 2024 04:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCFk-0008Cu-ND; Fri, 12 Apr 2024 04:27:21 -0400
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCFg-000092-D5; Fri, 12 Apr 2024 04:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712910428; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=B+SstW1PWU92CRSM3sOGN34gzAi70P6R3/YF/ZZWmHI=;
 b=h70SayjaAGtC55PFCxZMsLJqdTkvNN76B4ZZRxGfavt+p99TFxIsx2afpaLYx1qbws7dgAXs/ccbsNcizaO+QT6bNr1VZJJUscKsj6oygfwy3ZURfeS+J9ZsN1svjl+Vtt2rVlxMfBw36DzfPpz1ugQQDhQZt9ipBMgI2DVRFV8=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NfFtd_1712910426; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NfFtd_1712910426) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 16:27:07 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 24/65] target/riscv: Add single-width integer multiply
 instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:36:54 +0800
Message-ID: <20240412073735.76413-25-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.100;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-100.freemail.mail.aliyun.com
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
 target/riscv/helper.h                         | 33 +++++++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 18 ++---
 target/riscv/vector_helper.c                  | 28 ++++----
 target/riscv/vector_internals.h               | 17 +++++
 target/riscv/xtheadvector_helper.c            | 69 +++++++++++++++++++
 5 files changed, 141 insertions(+), 24 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index f3e4ab0f1f..e678dd5385 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1728,3 +1728,36 @@ DEF_HELPER_6(th_vmax_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vmax_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vmax_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vmax_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(th_vmul_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmul_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmul_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmul_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmulh_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmulh_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmulh_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmulh_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmulhu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmulhu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmulhu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmulhu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmulhsu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmulhsu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmulhsu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmulhsu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmul_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmul_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmul_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmul_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmulh_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmulh_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmulh_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmulh_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmulhu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmulhu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmulhu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmulhu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmulhsu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmulhsu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmulhsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmulhsu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index f19a771b61..15f36ba98a 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -1529,20 +1529,22 @@ GEN_OPIVX_TRANS_TH(th_vmin_vx,  opivx_check_th)
 GEN_OPIVX_TRANS_TH(th_vmaxu_vx, opivx_check_th)
 GEN_OPIVX_TRANS_TH(th_vmax_vx,  opivx_check_th)
 
+/* Vector Single-Width Integer Multiply Instructions */
+GEN_OPIVV_GVEC_TRANS_TH(th_vmul_vv,  mul)
+GEN_OPIVV_TRANS_TH(th_vmulh_vv, opivv_check_th)
+GEN_OPIVV_TRANS_TH(th_vmulhu_vv, opivv_check_th)
+GEN_OPIVV_TRANS_TH(th_vmulhsu_vv, opivv_check_th)
+GEN_OPIVX_GVEC_TRANS_TH(th_vmul_vx,  muls)
+GEN_OPIVX_TRANS_TH(th_vmulh_vx, opivx_check_th)
+GEN_OPIVX_TRANS_TH(th_vmulhu_vx, opivx_check_th)
+GEN_OPIVX_TRANS_TH(th_vmulhsu_vx, opivx_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vmul_vv)
-TH_TRANS_STUB(th_vmul_vx)
-TH_TRANS_STUB(th_vmulh_vv)
-TH_TRANS_STUB(th_vmulh_vx)
-TH_TRANS_STUB(th_vmulhu_vv)
-TH_TRANS_STUB(th_vmulhu_vx)
-TH_TRANS_STUB(th_vmulhsu_vv)
-TH_TRANS_STUB(th_vmulhsu_vx)
 TH_TRANS_STUB(th_vdivu_vv)
 TH_TRANS_STUB(th_vdivu_vx)
 TH_TRANS_STUB(th_vdiv_vv)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 9774fc62c3..5aba3f238f 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -647,10 +647,6 @@ GEN_VEXT_ST_WHOLE(vs8r_v, int8_t, ste_b)
  */
 
 /* (TD, T1, T2, TX1, TX2) */
-#define OP_SUS_B int8_t, uint8_t, int8_t, uint8_t, int8_t
-#define OP_SUS_H int16_t, uint16_t, int16_t, uint16_t, int16_t
-#define OP_SUS_W int32_t, uint32_t, int32_t, uint32_t, int32_t
-#define OP_SUS_D int64_t, uint64_t, int64_t, uint64_t, int64_t
 #define WOP_SUS_B int16_t, uint8_t, int8_t, uint16_t, int16_t
 #define WOP_SUS_H int32_t, uint16_t, int16_t, uint32_t, int32_t
 #define WOP_SUS_W int64_t, uint32_t, int32_t, uint64_t, int64_t
@@ -1399,22 +1395,22 @@ GEN_VEXT_VV(vmul_vv_h, 2)
 GEN_VEXT_VV(vmul_vv_w, 4)
 GEN_VEXT_VV(vmul_vv_d, 8)
 
-static int8_t do_mulh_b(int8_t s2, int8_t s1)
+int8_t do_mulh_b(int8_t s2, int8_t s1)
 {
     return (int16_t)s2 * (int16_t)s1 >> 8;
 }
 
-static int16_t do_mulh_h(int16_t s2, int16_t s1)
+int16_t do_mulh_h(int16_t s2, int16_t s1)
 {
     return (int32_t)s2 * (int32_t)s1 >> 16;
 }
 
-static int32_t do_mulh_w(int32_t s2, int32_t s1)
+int32_t do_mulh_w(int32_t s2, int32_t s1)
 {
     return (int64_t)s2 * (int64_t)s1 >> 32;
 }
 
-static int64_t do_mulh_d(int64_t s2, int64_t s1)
+int64_t do_mulh_d(int64_t s2, int64_t s1)
 {
     uint64_t hi_64, lo_64;
 
@@ -1422,22 +1418,22 @@ static int64_t do_mulh_d(int64_t s2, int64_t s1)
     return hi_64;
 }
 
-static uint8_t do_mulhu_b(uint8_t s2, uint8_t s1)
+uint8_t do_mulhu_b(uint8_t s2, uint8_t s1)
 {
     return (uint16_t)s2 * (uint16_t)s1 >> 8;
 }
 
-static uint16_t do_mulhu_h(uint16_t s2, uint16_t s1)
+uint16_t do_mulhu_h(uint16_t s2, uint16_t s1)
 {
     return (uint32_t)s2 * (uint32_t)s1 >> 16;
 }
 
-static uint32_t do_mulhu_w(uint32_t s2, uint32_t s1)
+uint32_t do_mulhu_w(uint32_t s2, uint32_t s1)
 {
     return (uint64_t)s2 * (uint64_t)s1 >> 32;
 }
 
-static uint64_t do_mulhu_d(uint64_t s2, uint64_t s1)
+uint64_t do_mulhu_d(uint64_t s2, uint64_t s1)
 {
     uint64_t hi_64, lo_64;
 
@@ -1445,17 +1441,17 @@ static uint64_t do_mulhu_d(uint64_t s2, uint64_t s1)
     return hi_64;
 }
 
-static int8_t do_mulhsu_b(int8_t s2, uint8_t s1)
+int8_t do_mulhsu_b(int8_t s2, uint8_t s1)
 {
     return (int16_t)s2 * (uint16_t)s1 >> 8;
 }
 
-static int16_t do_mulhsu_h(int16_t s2, uint16_t s1)
+int16_t do_mulhsu_h(int16_t s2, uint16_t s1)
 {
     return (int32_t)s2 * (uint32_t)s1 >> 16;
 }
 
-static int32_t do_mulhsu_w(int32_t s2, uint32_t s1)
+int32_t do_mulhsu_w(int32_t s2, uint32_t s1)
 {
     return (int64_t)s2 * (uint64_t)s1 >> 32;
 }
@@ -1479,7 +1475,7 @@ static int32_t do_mulhsu_w(int32_t s2, uint32_t s1)
  *      HI_P -= (A < 0 ? B : 0)
  */
 
-static int64_t do_mulhsu_d(int64_t s2, uint64_t s1)
+int64_t do_mulhsu_d(int64_t s2, uint64_t s1)
 {
     uint64_t hi_64, lo_64;
 
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index 24e64c37d4..4cbd7f972a 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -142,6 +142,10 @@ void vext_set_elems_1s(void *base, uint32_t is_agnostic, uint32_t cnt,
 #define OP_SSS_H int16_t, int16_t, int16_t, int16_t, int16_t
 #define OP_SSS_W int32_t, int32_t, int32_t, int32_t, int32_t
 #define OP_SSS_D int64_t, int64_t, int64_t, int64_t, int64_t
+#define OP_SUS_B int8_t, uint8_t, int8_t, uint8_t, int8_t
+#define OP_SUS_H int16_t, uint16_t, int16_t, uint16_t, int16_t
+#define OP_SUS_W int32_t, uint32_t, int32_t, uint32_t, int32_t
+#define OP_SUS_D int64_t, uint64_t, int64_t, uint64_t, int64_t
 
 #define OPIVV1(NAME, TD, T2, TX2, HD, HS2, OP)         \
 static void do_##NAME(void *vd, void *vs2, int i)      \
@@ -261,4 +265,17 @@ void probe_pages(CPURISCVState *env, target_ulong addr,
                  target_ulong len, uintptr_t ra,
                  MMUAccessType access_type);
 
+int8_t do_mulh_b(int8_t s2, int8_t s1);
+int16_t do_mulh_h(int16_t s2, int16_t s1);
+int32_t do_mulh_w(int32_t s2, int32_t s1);
+int64_t do_mulh_d(int64_t s2, int64_t s1);
+uint8_t do_mulhu_b(uint8_t s2, uint8_t s1);
+uint16_t do_mulhu_h(uint16_t s2, uint16_t s1);
+uint32_t do_mulhu_w(uint32_t s2, uint32_t s1);
+uint64_t do_mulhu_d(uint64_t s2, uint64_t s1);
+int8_t do_mulhsu_b(int8_t s2, uint8_t s1);
+int16_t do_mulhsu_h(int16_t s2, uint16_t s1);
+int32_t do_mulhsu_w(int32_t s2, uint32_t s1);
+int64_t do_mulhsu_d(int64_t s2, uint64_t s1);
+
 #endif /* TARGET_RISCV_VECTOR_INTERNALS_H */
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index da869e1069..9d8129750c 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -1609,3 +1609,72 @@ GEN_TH_VX(th_vmax_vx_b, 1, 1, clearb_th)
 GEN_TH_VX(th_vmax_vx_h, 2, 2, clearh_th)
 GEN_TH_VX(th_vmax_vx_w, 4, 4, clearl_th)
 GEN_TH_VX(th_vmax_vx_d, 8, 8, clearq_th)
+
+/* Vector Single-Width Integer Multiply Instructions */
+#define TH_MUL(N, M) (N * M)
+THCALL(TH_OPIVV2, th_vmul_vv_b, OP_SSS_B, H1, H1, H1, TH_MUL)
+THCALL(TH_OPIVV2, th_vmul_vv_h, OP_SSS_H, H2, H2, H2, TH_MUL)
+THCALL(TH_OPIVV2, th_vmul_vv_w, OP_SSS_W, H4, H4, H4, TH_MUL)
+THCALL(TH_OPIVV2, th_vmul_vv_d, OP_SSS_D, H8, H8, H8, TH_MUL)
+GEN_TH_VV(th_vmul_vv_b, 1, 1, clearb_th)
+GEN_TH_VV(th_vmul_vv_h, 2, 2, clearh_th)
+GEN_TH_VV(th_vmul_vv_w, 4, 4, clearl_th)
+GEN_TH_VV(th_vmul_vv_d, 8, 8, clearq_th)
+
+THCALL(TH_OPIVV2, th_vmulh_vv_b, OP_SSS_B, H1, H1, H1, do_mulh_b)
+THCALL(TH_OPIVV2, th_vmulh_vv_h, OP_SSS_H, H2, H2, H2, do_mulh_h)
+THCALL(TH_OPIVV2, th_vmulh_vv_w, OP_SSS_W, H4, H4, H4, do_mulh_w)
+THCALL(TH_OPIVV2, th_vmulh_vv_d, OP_SSS_D, H8, H8, H8, do_mulh_d)
+THCALL(TH_OPIVV2, th_vmulhu_vv_b, OP_UUU_B, H1, H1, H1, do_mulhu_b)
+THCALL(TH_OPIVV2, th_vmulhu_vv_h, OP_UUU_H, H2, H2, H2, do_mulhu_h)
+THCALL(TH_OPIVV2, th_vmulhu_vv_w, OP_UUU_W, H4, H4, H4, do_mulhu_w)
+THCALL(TH_OPIVV2, th_vmulhu_vv_d, OP_UUU_D, H8, H8, H8, do_mulhu_d)
+THCALL(TH_OPIVV2, th_vmulhsu_vv_b, OP_SUS_B, H1, H1, H1, do_mulhsu_b)
+THCALL(TH_OPIVV2, th_vmulhsu_vv_h, OP_SUS_H, H2, H2, H2, do_mulhsu_h)
+THCALL(TH_OPIVV2, th_vmulhsu_vv_w, OP_SUS_W, H4, H4, H4, do_mulhsu_w)
+THCALL(TH_OPIVV2, th_vmulhsu_vv_d, OP_SUS_D, H8, H8, H8, do_mulhsu_d)
+GEN_TH_VV(th_vmulh_vv_b, 1, 1, clearb_th)
+GEN_TH_VV(th_vmulh_vv_h, 2, 2, clearh_th)
+GEN_TH_VV(th_vmulh_vv_w, 4, 4, clearl_th)
+GEN_TH_VV(th_vmulh_vv_d, 8, 8, clearq_th)
+GEN_TH_VV(th_vmulhu_vv_b, 1, 1, clearb_th)
+GEN_TH_VV(th_vmulhu_vv_h, 2, 2, clearh_th)
+GEN_TH_VV(th_vmulhu_vv_w, 4, 4, clearl_th)
+GEN_TH_VV(th_vmulhu_vv_d, 8, 8, clearq_th)
+GEN_TH_VV(th_vmulhsu_vv_b, 1, 1, clearb_th)
+GEN_TH_VV(th_vmulhsu_vv_h, 2, 2, clearh_th)
+GEN_TH_VV(th_vmulhsu_vv_w, 4, 4, clearl_th)
+GEN_TH_VV(th_vmulhsu_vv_d, 8, 8, clearq_th)
+
+THCALL(TH_OPIVX2, th_vmul_vx_b, OP_SSS_B, H1, H1, TH_MUL)
+THCALL(TH_OPIVX2, th_vmul_vx_h, OP_SSS_H, H2, H2, TH_MUL)
+THCALL(TH_OPIVX2, th_vmul_vx_w, OP_SSS_W, H4, H4, TH_MUL)
+THCALL(TH_OPIVX2, th_vmul_vx_d, OP_SSS_D, H8, H8, TH_MUL)
+THCALL(TH_OPIVX2, th_vmulh_vx_b, OP_SSS_B, H1, H1, do_mulh_b)
+THCALL(TH_OPIVX2, th_vmulh_vx_h, OP_SSS_H, H2, H2, do_mulh_h)
+THCALL(TH_OPIVX2, th_vmulh_vx_w, OP_SSS_W, H4, H4, do_mulh_w)
+THCALL(TH_OPIVX2, th_vmulh_vx_d, OP_SSS_D, H8, H8, do_mulh_d)
+THCALL(TH_OPIVX2, th_vmulhu_vx_b, OP_UUU_B, H1, H1, do_mulhu_b)
+THCALL(TH_OPIVX2, th_vmulhu_vx_h, OP_UUU_H, H2, H2, do_mulhu_h)
+THCALL(TH_OPIVX2, th_vmulhu_vx_w, OP_UUU_W, H4, H4, do_mulhu_w)
+THCALL(TH_OPIVX2, th_vmulhu_vx_d, OP_UUU_D, H8, H8, do_mulhu_d)
+THCALL(TH_OPIVX2, th_vmulhsu_vx_b, OP_SUS_B, H1, H1, do_mulhsu_b)
+THCALL(TH_OPIVX2, th_vmulhsu_vx_h, OP_SUS_H, H2, H2, do_mulhsu_h)
+THCALL(TH_OPIVX2, th_vmulhsu_vx_w, OP_SUS_W, H4, H4, do_mulhsu_w)
+THCALL(TH_OPIVX2, th_vmulhsu_vx_d, OP_SUS_D, H8, H8, do_mulhsu_d)
+GEN_TH_VX(th_vmul_vx_b, 1, 1, clearb_th)
+GEN_TH_VX(th_vmul_vx_h, 2, 2, clearh_th)
+GEN_TH_VX(th_vmul_vx_w, 4, 4, clearl_th)
+GEN_TH_VX(th_vmul_vx_d, 8, 8, clearq_th)
+GEN_TH_VX(th_vmulh_vx_b, 1, 1, clearb_th)
+GEN_TH_VX(th_vmulh_vx_h, 2, 2, clearh_th)
+GEN_TH_VX(th_vmulh_vx_w, 4, 4, clearl_th)
+GEN_TH_VX(th_vmulh_vx_d, 8, 8, clearq_th)
+GEN_TH_VX(th_vmulhu_vx_b, 1, 1, clearb_th)
+GEN_TH_VX(th_vmulhu_vx_h, 2, 2, clearh_th)
+GEN_TH_VX(th_vmulhu_vx_w, 4, 4, clearl_th)
+GEN_TH_VX(th_vmulhu_vx_d, 8, 8, clearq_th)
+GEN_TH_VX(th_vmulhsu_vx_b, 1, 1, clearb_th)
+GEN_TH_VX(th_vmulhsu_vx_h, 2, 2, clearh_th)
+GEN_TH_VX(th_vmulhsu_vx_w, 4, 4, clearl_th)
+GEN_TH_VX(th_vmulhsu_vx_d, 8, 8, clearq_th)
-- 
2.44.0


