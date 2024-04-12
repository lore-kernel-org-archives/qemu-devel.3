Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAFBC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 09:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvD8J-0007Ro-BW; Fri, 12 Apr 2024 05:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvD8H-0007R2-HV; Fri, 12 Apr 2024 05:23:41 -0400
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvD8D-00034P-5v; Fri, 12 Apr 2024 05:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712913812; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=9i82KizZZ4bGTSXDwbBVXYBSowFXdfzhpZehJOycVaI=;
 b=roNNYeAuIRLspKhVjdT/fbisjBcoz3H46rrLMjtU2DmAU2Rnil8atDZWZWlODXzWXIyI++se1BIVxOcLukRNxBzD3hreBbkryCEkrgSJ5UUanpQrT636O0rl/AnGfTwhg/GefO4oEYB3A6ffuYnfcG7sc4Ie2zm8bkcX7wO16ic=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4Nr1MX_1712913810; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4Nr1MX_1712913810) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 17:23:31 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 44/65] target/riscv: Add floating-point sign-injection
 instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:37:14 +0800
Message-ID: <20240412073735.76413-45-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.113;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-113.freemail.mail.aliyun.com
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
 target/riscv/vector_helper.c                  | 18 ++++----
 target/riscv/vector_internals.h               | 10 +++++
 target/riscv/xtheadvector_helper.c            | 41 +++++++++++++++++++
 5 files changed, 87 insertions(+), 15 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 86ae984430..2b9d7fa2b6 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -2133,3 +2133,22 @@ DEF_HELPER_6(th_vfmin_vf_d, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(th_vfmax_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(th_vfmax_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(th_vfmax_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_6(th_vfsgnj_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfsgnj_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfsgnj_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfsgnjn_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfsgnjn_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfsgnjn_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfsgnjx_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfsgnjx_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfsgnjx_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfsgnj_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfsgnj_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfsgnj_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfsgnjn_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfsgnjn_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfsgnjn_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfsgnjx_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfsgnjx_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfsgnjx_vf_d, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index d3205ce2a0..1374bad5b9 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -2098,18 +2098,20 @@ GEN_OPFVV_TRANS_TH(th_vfmax_vv, opfvv_check_th)
 GEN_OPFVF_TRANS_TH(th_vfmin_vf, opfvf_check_th)
 GEN_OPFVF_TRANS_TH(th_vfmax_vf, opfvf_check_th)
 
+/* Vector Floating-Point Sign-Injection Instructions */
+GEN_OPFVV_TRANS_TH(th_vfsgnj_vv, opfvv_check_th)
+GEN_OPFVV_TRANS_TH(th_vfsgnjn_vv, opfvv_check_th)
+GEN_OPFVV_TRANS_TH(th_vfsgnjx_vv, opfvv_check_th)
+GEN_OPFVF_TRANS_TH(th_vfsgnj_vf, opfvf_check_th)
+GEN_OPFVF_TRANS_TH(th_vfsgnjn_vf, opfvf_check_th)
+GEN_OPFVF_TRANS_TH(th_vfsgnjx_vf, opfvf_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vfsgnj_vv)
-TH_TRANS_STUB(th_vfsgnj_vf)
-TH_TRANS_STUB(th_vfsgnjn_vv)
-TH_TRANS_STUB(th_vfsgnjn_vf)
-TH_TRANS_STUB(th_vfsgnjx_vv)
-TH_TRANS_STUB(th_vfsgnjx_vf)
 TH_TRANS_STUB(th_vmfeq_vv)
 TH_TRANS_STUB(th_vmfeq_vf)
 TH_TRANS_STUB(th_vmfne_vv)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index ef89794bdd..d0ebda5445 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3882,17 +3882,17 @@ GEN_VEXT_VF(vfmax_vf_w, 4)
 GEN_VEXT_VF(vfmax_vf_d, 8)
 
 /* Vector Floating-Point Sign-Injection Instructions */
-static uint16_t fsgnj16(uint16_t a, uint16_t b, float_status *s)
+uint16_t fsgnj16(uint16_t a, uint16_t b, float_status *s)
 {
     return deposit64(b, 0, 15, a);
 }
 
-static uint32_t fsgnj32(uint32_t a, uint32_t b, float_status *s)
+uint32_t fsgnj32(uint32_t a, uint32_t b, float_status *s)
 {
     return deposit64(b, 0, 31, a);
 }
 
-static uint64_t fsgnj64(uint64_t a, uint64_t b, float_status *s)
+uint64_t fsgnj64(uint64_t a, uint64_t b, float_status *s)
 {
     return deposit64(b, 0, 63, a);
 }
@@ -3910,17 +3910,17 @@ GEN_VEXT_VF(vfsgnj_vf_h, 2)
 GEN_VEXT_VF(vfsgnj_vf_w, 4)
 GEN_VEXT_VF(vfsgnj_vf_d, 8)
 
-static uint16_t fsgnjn16(uint16_t a, uint16_t b, float_status *s)
+uint16_t fsgnjn16(uint16_t a, uint16_t b, float_status *s)
 {
     return deposit64(~b, 0, 15, a);
 }
 
-static uint32_t fsgnjn32(uint32_t a, uint32_t b, float_status *s)
+uint32_t fsgnjn32(uint32_t a, uint32_t b, float_status *s)
 {
     return deposit64(~b, 0, 31, a);
 }
 
-static uint64_t fsgnjn64(uint64_t a, uint64_t b, float_status *s)
+uint64_t fsgnjn64(uint64_t a, uint64_t b, float_status *s)
 {
     return deposit64(~b, 0, 63, a);
 }
@@ -3938,17 +3938,17 @@ GEN_VEXT_VF(vfsgnjn_vf_h, 2)
 GEN_VEXT_VF(vfsgnjn_vf_w, 4)
 GEN_VEXT_VF(vfsgnjn_vf_d, 8)
 
-static uint16_t fsgnjx16(uint16_t a, uint16_t b, float_status *s)
+uint16_t fsgnjx16(uint16_t a, uint16_t b, float_status *s)
 {
     return deposit64(b ^ a, 0, 15, a);
 }
 
-static uint32_t fsgnjx32(uint32_t a, uint32_t b, float_status *s)
+uint32_t fsgnjx32(uint32_t a, uint32_t b, float_status *s)
 {
     return deposit64(b ^ a, 0, 31, a);
 }
 
-static uint64_t fsgnjx64(uint64_t a, uint64_t b, float_status *s)
+uint64_t fsgnjx64(uint64_t a, uint64_t b, float_status *s)
 {
     return deposit64(b ^ a, 0, 63, a);
 }
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index 535d31007d..bcc7d0edd6 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -394,4 +394,14 @@ uint64_t fwmsac32(uint32_t a, uint32_t b, uint64_t d, float_status *s);
 uint32_t fwnmsac16(uint16_t a, uint16_t b, uint32_t d, float_status *s);
 uint64_t fwnmsac32(uint32_t a, uint32_t b, uint64_t d, float_status *s);
 
+uint16_t fsgnj16(uint16_t a, uint16_t b, float_status *s);
+uint32_t fsgnj32(uint32_t a, uint32_t b, float_status *s);
+uint64_t fsgnj64(uint64_t a, uint64_t b, float_status *s);
+uint16_t fsgnjn16(uint16_t a, uint16_t b, float_status *s);
+uint32_t fsgnjn32(uint32_t a, uint32_t b, float_status *s);
+uint64_t fsgnjn64(uint64_t a, uint64_t b, float_status *s);
+uint16_t fsgnjx16(uint16_t a, uint16_t b, float_status *s);
+uint32_t fsgnjx32(uint32_t a, uint32_t b, float_status *s);
+uint64_t fsgnjx64(uint64_t a, uint64_t b, float_status *s);
+
 #endif /* TARGET_RISCV_VECTOR_INTERNALS_H */
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 5593cace78..38476900a6 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -3010,3 +3010,44 @@ THCALL(TH_OPFVF2, th_vfmax_vf_d, OP_UUU_D, H8, H8, float64_maxnum)
 GEN_TH_VF(th_vfmax_vf_h, 2, 2, clearh_th)
 GEN_TH_VF(th_vfmax_vf_w, 4, 4, clearl_th)
 GEN_TH_VF(th_vfmax_vf_d, 8, 8, clearq_th)
+
+/* Vector Floating-Point Sign-Injection Instructions */
+
+THCALL(TH_OPFVV2, th_vfsgnj_vv_h, OP_UUU_H, H2, H2, H2, fsgnj16)
+THCALL(TH_OPFVV2, th_vfsgnj_vv_w, OP_UUU_W, H4, H4, H4, fsgnj32)
+THCALL(TH_OPFVV2, th_vfsgnj_vv_d, OP_UUU_D, H8, H8, H8, fsgnj64)
+GEN_TH_VV_ENV(th_vfsgnj_vv_h, 2, 2, clearh_th)
+GEN_TH_VV_ENV(th_vfsgnj_vv_w, 4, 4, clearl_th)
+GEN_TH_VV_ENV(th_vfsgnj_vv_d, 8, 8, clearq_th)
+THCALL(TH_OPFVF2, th_vfsgnj_vf_h, OP_UUU_H, H2, H2, fsgnj16)
+THCALL(TH_OPFVF2, th_vfsgnj_vf_w, OP_UUU_W, H4, H4, fsgnj32)
+THCALL(TH_OPFVF2, th_vfsgnj_vf_d, OP_UUU_D, H8, H8, fsgnj64)
+GEN_TH_VF(th_vfsgnj_vf_h, 2, 2, clearh_th)
+GEN_TH_VF(th_vfsgnj_vf_w, 4, 4, clearl_th)
+GEN_TH_VF(th_vfsgnj_vf_d, 8, 8, clearq_th)
+
+THCALL(TH_OPFVV2, th_vfsgnjn_vv_h, OP_UUU_H, H2, H2, H2, fsgnjn16)
+THCALL(TH_OPFVV2, th_vfsgnjn_vv_w, OP_UUU_W, H4, H4, H4, fsgnjn32)
+THCALL(TH_OPFVV2, th_vfsgnjn_vv_d, OP_UUU_D, H8, H8, H8, fsgnjn64)
+GEN_TH_VV_ENV(th_vfsgnjn_vv_h, 2, 2, clearh_th)
+GEN_TH_VV_ENV(th_vfsgnjn_vv_w, 4, 4, clearl_th)
+GEN_TH_VV_ENV(th_vfsgnjn_vv_d, 8, 8, clearq_th)
+THCALL(TH_OPFVF2, th_vfsgnjn_vf_h, OP_UUU_H, H2, H2, fsgnjn16)
+THCALL(TH_OPFVF2, th_vfsgnjn_vf_w, OP_UUU_W, H4, H4, fsgnjn32)
+THCALL(TH_OPFVF2, th_vfsgnjn_vf_d, OP_UUU_D, H8, H8, fsgnjn64)
+GEN_TH_VF(th_vfsgnjn_vf_h, 2, 2, clearh_th)
+GEN_TH_VF(th_vfsgnjn_vf_w, 4, 4, clearl_th)
+GEN_TH_VF(th_vfsgnjn_vf_d, 8, 8, clearq_th)
+
+THCALL(TH_OPFVV2, th_vfsgnjx_vv_h, OP_UUU_H, H2, H2, H2, fsgnjx16)
+THCALL(TH_OPFVV2, th_vfsgnjx_vv_w, OP_UUU_W, H4, H4, H4, fsgnjx32)
+THCALL(TH_OPFVV2, th_vfsgnjx_vv_d, OP_UUU_D, H8, H8, H8, fsgnjx64)
+GEN_TH_VV_ENV(th_vfsgnjx_vv_h, 2, 2, clearh_th)
+GEN_TH_VV_ENV(th_vfsgnjx_vv_w, 4, 4, clearl_th)
+GEN_TH_VV_ENV(th_vfsgnjx_vv_d, 8, 8, clearq_th)
+THCALL(TH_OPFVF2, th_vfsgnjx_vf_h, OP_UUU_H, H2, H2, fsgnjx16)
+THCALL(TH_OPFVF2, th_vfsgnjx_vf_w, OP_UUU_W, H4, H4, fsgnjx32)
+THCALL(TH_OPFVF2, th_vfsgnjx_vf_d, OP_UUU_D, H8, H8, fsgnjx64)
+GEN_TH_VF(th_vfsgnjx_vf_h, 2, 2, clearh_th)
+GEN_TH_VF(th_vfsgnjx_vf_w, 4, 4, clearl_th)
+GEN_TH_VF(th_vfsgnjx_vf_d, 8, 8, clearq_th)
-- 
2.44.0


