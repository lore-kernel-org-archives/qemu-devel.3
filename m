Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32079C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 09:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDM9-0006Kz-43; Fri, 12 Apr 2024 05:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDM5-0006KG-FI; Fri, 12 Apr 2024 05:37:59 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDLv-0005Mq-RJ; Fri, 12 Apr 2024 05:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712914662; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=rvFeLBFtyFCY3re8IsCpZb6TNRzQPebm4CWct6JZwjo=;
 b=JMEVtv/WeuhtWNlZX6Dens2NTZOKs0rZ68gvo/FJjucFYDC/dpcpUN0B9fNXYdu+7863qhKWqL7+2XdqwxrBy/hq61tOdBDCd6U+kn1xC3s+pdwetd6IiO0TQ7g3JFVAiqIMDeLuv8KYr8XLP246duD+N+BDVWgbEQcgwNMLWQE=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NsdXC_1712914660; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NsdXC_1712914660) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 17:37:41 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 51/65] target/riscv: Add widening integer reduction
 instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:37:21 +0800
Message-ID: <20240412073735.76413-52-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.132;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-132.freemail.mail.aliyun.com
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
 target/riscv/helper.h                            |  7 +++++++
 target/riscv/insn_trans/trans_xtheadvector.c.inc |  6 ++++--
 target/riscv/xtheadvector_helper.c               | 11 +++++++++++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 84d2921945..2cd4a7401f 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -2269,3 +2269,10 @@ DEF_HELPER_6(th_vredxor_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(th_vredxor_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(th_vredxor_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(th_vredxor_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_6(th_vwredsumu_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwredsumu_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwredsumu_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwredsum_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwredsum_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwredsum_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 1fd66353ed..8a1f0e1e74 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -2393,14 +2393,16 @@ GEN_OPIVV_TRANS_TH(th_vredand_vs, reduction_check_th)
 GEN_OPIVV_TRANS_TH(th_vredor_vs, reduction_check_th)
 GEN_OPIVV_TRANS_TH(th_vredxor_vs, reduction_check_th)
 
+/* Vector Widening Integer Reduction Instructions */
+GEN_OPIVV_WIDEN_TRANS_TH(th_vwredsum_vs, reduction_check_th)
+GEN_OPIVV_WIDEN_TRANS_TH(th_vwredsumu_vs, reduction_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vwredsumu_vs)
-TH_TRANS_STUB(th_vwredsum_vs)
 TH_TRANS_STUB(th_vfredsum_vs)
 TH_TRANS_STUB(th_vfredmin_vs)
 TH_TRANS_STUB(th_vfredmax_vs)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index d041a81150..f802b2c5ac 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -3399,3 +3399,14 @@ GEN_TH_RED(th_vredxor_vs_b, int8_t, int8_t, H1, H1, TH_XOR, clearb_th)
 GEN_TH_RED(th_vredxor_vs_h, int16_t, int16_t, H2, H2, TH_XOR, clearh_th)
 GEN_TH_RED(th_vredxor_vs_w, int32_t, int32_t, H4, H4, TH_XOR, clearl_th)
 GEN_TH_RED(th_vredxor_vs_d, int64_t, int64_t, H8, H8, TH_XOR, clearq_th)
+
+/* Vector Widening Integer Reduction Instructions */
+/* signed sum reduction into double-width accumulator */
+GEN_TH_RED(th_vwredsum_vs_b, int16_t, int8_t, H2, H1, TH_ADD, clearh_th)
+GEN_TH_RED(th_vwredsum_vs_h, int32_t, int16_t, H4, H2, TH_ADD, clearl_th)
+GEN_TH_RED(th_vwredsum_vs_w, int64_t, int32_t, H8, H4, TH_ADD, clearq_th)
+
+/* Unsigned sum reduction into double-width accumulator */
+GEN_TH_RED(th_vwredsumu_vs_b, uint16_t, uint8_t, H2, H1, TH_ADD, clearh_th)
+GEN_TH_RED(th_vwredsumu_vs_h, uint32_t, uint16_t, H4, H2, TH_ADD, clearl_th)
+GEN_TH_RED(th_vwredsumu_vs_w, uint64_t, uint32_t, H8, H4, TH_ADD, clearq_th)
-- 
2.44.0


