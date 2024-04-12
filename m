Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3FAC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 09:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDPu-0008FS-0e; Fri, 12 Apr 2024 05:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDPs-0008Er-78; Fri, 12 Apr 2024 05:41:52 -0400
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDPp-0005vT-IC; Fri, 12 Apr 2024 05:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712914904; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=DvS7ZVmPsoC/yhBHMBdWOLfrIecMJsQ4hrpstrB7mYg=;
 b=sSmcE2jr9QKy4LBmXwCn1UVC3snX/3y4C6sRLk0Ae8EOrmQECBWOTAr9MHR5E9Ns08ECKv5cBaCX2lemCJCRs4tit4RJu4NCKSqR4axeKT3K1nTlIHUafBXh/sKuM/28sBR5PVE+b4qazyEew8g4U2hMLQnKWNnfcGWxLsypHps=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NtLFy_1712914902; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NtLFy_1712914902) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 17:41:43 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 53/65] target/riscv: Add widening floating-point reduction
 instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:37:23 +0800
Message-ID: <20240412073735.76413-54-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.124;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-124.freemail.mail.aliyun.com
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
 target/riscv/helper.h                            |  3 +++
 target/riscv/insn_trans/trans_xtheadvector.c.inc |  4 +++-
 target/riscv/xtheadvector_helper.c               | 16 ++++++++++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 24bb8479a4..c39ee9a8e8 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -2286,3 +2286,6 @@ DEF_HELPER_6(th_vfredmax_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(th_vfredmin_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(th_vfredmin_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(th_vfredmin_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_6(th_vfwredsum_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfwredsum_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index f77d76dc5e..b71875700b 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -2402,13 +2402,15 @@ GEN_OPFVV_TRANS_TH(th_vfredsum_vs, reduction_check_th)
 GEN_OPFVV_TRANS_TH(th_vfredmax_vs, reduction_check_th)
 GEN_OPFVV_TRANS_TH(th_vfredmin_vs, reduction_check_th)
 
+/* Vector Widening Floating-Point Reduction Instructions */
+GEN_OPFVV_WIDEN_TRANS_TH(th_vfwredsum_vs, reduction_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vfwredsum_vs)
 TH_TRANS_STUB(th_vmand_mm)
 TH_TRANS_STUB(th_vmnand_mm)
 TH_TRANS_STUB(th_vmandnot_mm)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 2a241aed65..8953207630 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -3459,3 +3459,19 @@ GEN_TH_FRED(th_vfredmin_vs_w, uint32_t, uint32_t, H4, H4,
             float32_minnum, clearl_th)
 GEN_TH_FRED(th_vfredmin_vs_d, uint64_t, uint64_t, H8, H8,
             float64_minnum, clearq_th)
+
+/* Vector Widening Floating-Point Add functions */
+static uint32_t fwadd16(uint32_t a, uint16_t b, float_status *s)
+{
+    return float32_add(a, float16_to_float32(b, true, s), s);
+}
+
+static uint64_t fwadd32(uint64_t a, uint32_t b, float_status *s)
+{
+    return float64_add(a, float32_to_float64(b, s), s);
+}
+
+/* Vector Widening Floating-Point Reduction Instructions */
+/* Unordered reduce 2*SEW = 2*SEW + sum(promote(SEW)) */
+GEN_TH_FRED(th_vfwredsum_vs_h, uint32_t, uint16_t, H4, H2, fwadd16, clearl_th)
+GEN_TH_FRED(th_vfwredsum_vs_w, uint64_t, uint32_t, H8, H4, fwadd32, clearq_th)
-- 
2.44.0


