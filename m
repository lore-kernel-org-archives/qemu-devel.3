Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A62C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 09:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvD6L-0006YB-T9; Fri, 12 Apr 2024 05:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvD6I-0006XF-PC; Fri, 12 Apr 2024 05:21:39 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvD6D-0002jV-TF; Fri, 12 Apr 2024 05:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712913683; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=9WjpYtFzkDs8TURxFiqDBlqgPLbchnvnBpaXx8gHXeM=;
 b=MjjaNDx/mKHbsEDqbF2o9YQ04jcgU+NzsFOJE436CfBPthtlAgxVoboIjhGkLvbvQ/jJJD4Sdq4hYLrqjFhQAVzuoOWkgJTWh1LVuw1MKCSjuSBbfvir8Sk07FgUwEWQ6dbrK+fx8gQG4bH/nQRqBjxiB7S+31jiZhCgati3T40=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R791e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NotgB_1712913681; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NotgB_1712913681) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 17:21:22 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 43/65] target/riscv: Add floating-point MIN/MAX instructions
 for XTheadVector
Date: Fri, 12 Apr 2024 15:37:13 +0800
Message-ID: <20240412073735.76413-44-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
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
 target/riscv/helper.h                         | 13 +++++++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 10 ++++---
 target/riscv/xtheadvector_helper.c            | 27 +++++++++++++++++++
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 5aa12f3719..86ae984430 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -2120,3 +2120,16 @@ DEF_HELPER_6(th_vfwnmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_5(th_vfsqrt_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(th_vfsqrt_v_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(th_vfsqrt_v_d, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_6(th_vfmin_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfmin_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfmin_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfmax_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfmax_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfmax_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfmin_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfmin_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfmin_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfmax_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfmax_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfmax_vf_d, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index e709444e9f..d3205ce2a0 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -2092,16 +2092,18 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
 
 GEN_OPFV_TRANS_TH(th_vfsqrt_v, opfv_check_th)
 
+/* Vector Floating-Point MIN/MAX Instructions */
+GEN_OPFVV_TRANS_TH(th_vfmin_vv, opfvv_check_th)
+GEN_OPFVV_TRANS_TH(th_vfmax_vv, opfvv_check_th)
+GEN_OPFVF_TRANS_TH(th_vfmin_vf, opfvf_check_th)
+GEN_OPFVF_TRANS_TH(th_vfmax_vf, opfvf_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vfmin_vv)
-TH_TRANS_STUB(th_vfmin_vf)
-TH_TRANS_STUB(th_vfmax_vv)
-TH_TRANS_STUB(th_vfmax_vf)
 TH_TRANS_STUB(th_vfsgnj_vv)
 TH_TRANS_STUB(th_vfsgnj_vf)
 TH_TRANS_STUB(th_vfsgnjn_vv)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 7274e7aedb..5593cace78 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -2983,3 +2983,30 @@ THCALL(TH_OPFVV1, th_vfsqrt_v_d, OP_UU_D, H8, H8, float64_sqrt)
 GEN_TH_V_ENV(th_vfsqrt_v_h, 2, 2, clearh_th)
 GEN_TH_V_ENV(th_vfsqrt_v_w, 4, 4, clearl_th)
 GEN_TH_V_ENV(th_vfsqrt_v_d, 8, 8, clearq_th)
+
+/* Vector Floating-Point MIN/MAX Instructions */
+THCALL(TH_OPFVV2, th_vfmin_vv_h, OP_UUU_H, H2, H2, H2, float16_minnum)
+THCALL(TH_OPFVV2, th_vfmin_vv_w, OP_UUU_W, H4, H4, H4, float32_minnum)
+THCALL(TH_OPFVV2, th_vfmin_vv_d, OP_UUU_D, H8, H8, H8, float64_minnum)
+GEN_TH_VV_ENV(th_vfmin_vv_h, 2, 2, clearh_th)
+GEN_TH_VV_ENV(th_vfmin_vv_w, 4, 4, clearl_th)
+GEN_TH_VV_ENV(th_vfmin_vv_d, 8, 8, clearq_th)
+THCALL(TH_OPFVF2, th_vfmin_vf_h, OP_UUU_H, H2, H2, float16_minnum)
+THCALL(TH_OPFVF2, th_vfmin_vf_w, OP_UUU_W, H4, H4, float32_minnum)
+THCALL(TH_OPFVF2, th_vfmin_vf_d, OP_UUU_D, H8, H8, float64_minnum)
+GEN_TH_VF(th_vfmin_vf_h, 2, 2, clearh_th)
+GEN_TH_VF(th_vfmin_vf_w, 4, 4, clearl_th)
+GEN_TH_VF(th_vfmin_vf_d, 8, 8, clearq_th)
+
+THCALL(TH_OPFVV2, th_vfmax_vv_h, OP_UUU_H, H2, H2, H2, float16_maxnum)
+THCALL(TH_OPFVV2, th_vfmax_vv_w, OP_UUU_W, H4, H4, H4, float32_maxnum)
+THCALL(TH_OPFVV2, th_vfmax_vv_d, OP_UUU_D, H8, H8, H8, float64_maxnum)
+GEN_TH_VV_ENV(th_vfmax_vv_h, 2, 2, clearh_th)
+GEN_TH_VV_ENV(th_vfmax_vv_w, 4, 4, clearl_th)
+GEN_TH_VV_ENV(th_vfmax_vv_d, 8, 8, clearq_th)
+THCALL(TH_OPFVF2, th_vfmax_vf_h, OP_UUU_H, H2, H2, float16_maxnum)
+THCALL(TH_OPFVF2, th_vfmax_vf_w, OP_UUU_W, H4, H4, float32_maxnum)
+THCALL(TH_OPFVF2, th_vfmax_vf_d, OP_UUU_D, H8, H8, float64_maxnum)
+GEN_TH_VF(th_vfmax_vf_h, 2, 2, clearh_th)
+GEN_TH_VF(th_vfmax_vf_w, 4, 4, clearl_th)
+GEN_TH_VF(th_vfmax_vf_d, 8, 8, clearq_th)
-- 
2.44.0


