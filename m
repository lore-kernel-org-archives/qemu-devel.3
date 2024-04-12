Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D8EC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvCjA-0007XG-Ay; Fri, 12 Apr 2024 04:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCj7-0007WV-GF; Fri, 12 Apr 2024 04:57:41 -0400
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCj4-0006iM-Pf; Fri, 12 Apr 2024 04:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712912250; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=zQtzfvqT8ZVzyxELeDR0sSIiQ6qjRvgIusJJ4q/c0c4=;
 b=pSSuXEXMWiBpvGrtNpy3F27r4I2IwQbxtmetg5ug7YLbtpC/bonKdW85NIeV7b+Y7IKHBmV+JBfpQa1XNi5l6qUxwjMi0z33AxlZSU6FZOZssFvyORipyRsBWWOZCSCvq96SWgOvzS6/XkWK86QhwxPCazKYFVh09JsZSq02wlc=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4Nc0YC_1712912248; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4Nc0YC_1712912248) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 16:57:29 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 39/65] target/riscv: Add widening floating-point multiply
 instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:37:09 +0800
Message-ID: <20240412073735.76413-40-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
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
 target/riscv/helper.h                            |  5 +++++
 target/riscv/insn_trans/trans_xtheadvector.c.inc |  6 ++++--
 target/riscv/vector_helper.c                     |  4 ++--
 target/riscv/vector_internals.h                  |  3 +++
 target/riscv/xtheadvector_helper.c               | 11 +++++++++++
 5 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index f63239676a..3102b078e4 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -2045,3 +2045,8 @@ DEF_HELPER_6(th_vfdiv_vf_d, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(th_vfrdiv_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(th_vfrdiv_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(th_vfrdiv_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_6(th_vfwmul_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfwmul_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfwmul_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfwmul_vf_w, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 940b212f5e..3d0370f220 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -2015,14 +2015,16 @@ GEN_OPFVF_TRANS_TH(th_vfmul_vf,  opfvf_check_th)
 GEN_OPFVF_TRANS_TH(th_vfdiv_vf,  opfvf_check_th)
 GEN_OPFVF_TRANS_TH(th_vfrdiv_vf,  opfvf_check_th)
 
+/* Vector Widening Floating-Point Multiply */
+GEN_OPFVV_WIDEN_TRANS_TH(th_vfwmul_vv, opfvv_widen_check_th)
+GEN_OPFVF_WIDEN_TRANS_TH(th_vfwmul_vf)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vfwmul_vv)
-TH_TRANS_STUB(th_vfwmul_vf)
 TH_TRANS_STUB(th_vfmacc_vv)
 TH_TRANS_STUB(th_vfnmacc_vv)
 TH_TRANS_STUB(th_vfnmacc_vf)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index d65b32c584..aa7714d651 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3059,13 +3059,13 @@ GEN_VEXT_VF(vfrdiv_vf_w, 4)
 GEN_VEXT_VF(vfrdiv_vf_d, 8)
 
 /* Vector Widening Floating-Point Multiply */
-static uint32_t vfwmul16(uint16_t a, uint16_t b, float_status *s)
+uint32_t vfwmul16(uint16_t a, uint16_t b, float_status *s)
 {
     return float32_mul(float16_to_float32(a, true, s),
                        float16_to_float32(b, true, s), s);
 }
 
-static uint64_t vfwmul32(uint32_t a, uint32_t b, float_status *s)
+uint64_t vfwmul32(uint32_t a, uint32_t b, float_status *s)
 {
     return float64_mul(float32_to_float64(a, s),
                        float32_to_float64(b, s), s);
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index 29263c6a53..8903a894d7 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -357,4 +357,7 @@ uint16_t float16_rdiv(uint16_t a, uint16_t b, float_status *s);
 uint32_t float32_rdiv(uint32_t a, uint32_t b, float_status *s);
 uint64_t float64_rdiv(uint64_t a, uint64_t b, float_status *s);
 
+uint32_t vfwmul16(uint16_t a, uint16_t b, float_status *s);
+uint64_t vfwmul32(uint32_t a, uint32_t b, float_status *s);
+
 #endif /* TARGET_RISCV_VECTOR_INTERNALS_H */
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 770f36346f..dd01d66933 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -2768,3 +2768,14 @@ THCALL(TH_OPFVF2, th_vfrdiv_vf_d, OP_UUU_D, H8, H8, float64_rdiv)
 GEN_TH_VF(th_vfrdiv_vf_h, 2, 2, clearh_th)
 GEN_TH_VF(th_vfrdiv_vf_w, 4, 4, clearl_th)
 GEN_TH_VF(th_vfrdiv_vf_d, 8, 8, clearq_th)
+
+/* Vector Widening Floating-Point Multiply */
+
+THCALL(TH_OPFVV2, th_vfwmul_vv_h, WOP_UUU_H, H4, H2, H2, vfwmul16)
+THCALL(TH_OPFVV2, th_vfwmul_vv_w, WOP_UUU_W, H8, H4, H4, vfwmul32)
+GEN_TH_VV_ENV(th_vfwmul_vv_h, 2, 4, clearl_th)
+GEN_TH_VV_ENV(th_vfwmul_vv_w, 4, 8, clearq_th)
+THCALL(TH_OPFVF2, th_vfwmul_vf_h, WOP_UUU_H, H4, H2, vfwmul16)
+THCALL(TH_OPFVF2, th_vfwmul_vf_w, WOP_UUU_W, H8, H4, vfwmul32)
+GEN_TH_VF(th_vfwmul_vf_h, 2, 4, clearl_th)
+GEN_TH_VF(th_vfwmul_vf_w, 4, 8, clearq_th)
-- 
2.44.0


