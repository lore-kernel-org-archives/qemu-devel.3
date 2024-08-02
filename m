Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE04BC3DA64
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 03:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZio4-0004CN-EN; Thu, 01 Aug 2024 23:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sZinv-0003kk-4b; Thu, 01 Aug 2024 23:18:08 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sZint-0007j3-3N; Thu, 01 Aug 2024 23:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1722568679; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
 bh=7Dlxi8J3j0quXVha72ma+Iktgh/4KEte5tmFCkiRao8=;
 b=ErWQ2pXi7gyNiVQ/XnosQnsN3kyKgbGNQGwR4rVRuylwIGuHn8rohAlxkXNqWqbtxOIlgWYvJliK2eLH7hqBt3uGuNnd0tlR4ySCi7IEmdiDEwCS6Se86wZQ2NKn8bJ90mLHpFglHEE2RwGBviQXl8k3Yq3g5Ne7KM7NYg5gk9w=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R961e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037067112;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0WBvmM9u_1722568677; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WBvmM9u_1722568677) by smtp.aliyun-inc.com;
 Fri, 02 Aug 2024 11:17:58 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com
Subject: [PATCH v2 3/3] target/riscv: Relax fld alignment requirement
Date: Fri,  2 Aug 2024 11:16:12 +0800
Message-Id: <20240802031612.604-4-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240802031612.604-1-zhiwei_liu@linux.alibaba.com>
References: <20240802031612.604-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.131;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-131.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

According to the risc-v specification:
"FLD and FSD are only guaranteed to execute atomically if the effective
address is naturally aligned and XLEN≥64."

We currently implement fld as MO_ATOM_IFALIGN when XLEN < 64, which does
not violate the rules. But it will hide some problems. So relax it to
MO_ATOM_NONE.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/riscv/insn_trans/trans_rvd.c.inc | 26 ++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_trans/trans_rvd.c.inc
index dbe508c7e0..458d7db745 100644
--- a/target/riscv/insn_trans/trans_rvd.c.inc
+++ b/target/riscv/insn_trans/trans_rvd.c.inc
@@ -48,12 +48,20 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
     REQUIRE_EXT(ctx, RVD);
 
     /*
-     * Zama16b applies to loads and stores of no more than MXLEN bits defined
-     * in the F, D, and Q extensions. Otherwise, it falls through to default
-     * MO_ATOM_IFALIGN.
+     * FLD and FSD are only guaranteed to execute atomically if the effective
+     * address is naturally aligned and XLEN≥64.
      */
-    if ((ctx->misa_mxl_max >= MXL_RV64) && ctx->cfg_ptr->ext_zama16b) {
-        memop |= MO_ATOM_WITHIN16;
+    if (ctx->misa_mxl_max >= MXL_RV64) {
+        /*
+         * Zama16b applies to loads and stores of no more than MXLEN bits
+         * defined in the F, D, and Q extensions. Otherwise, it falls through
+         * to default MO_ATOM_IFALIGN.
+         */
+        if (ctx->cfg_ptr->ext_zama16b) {
+            memop |= MO_ATOM_WITHIN16;
+        }
+    } else {
+        memop |= MO_ATOM_NONE;
     }
 
     decode_save_opc(ctx);
@@ -72,8 +80,12 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
 
-    if ((ctx->misa_mxl_max >= MXL_RV64) && ctx->cfg_ptr->ext_zama16b) {
-        memop |= MO_ATOM_WITHIN16;
+    if (ctx->misa_mxl_max >= MXL_RV64) {
+        if (ctx->cfg_ptr->ext_zama16b) {
+            memop |= MO_ATOM_WITHIN16;
+        }
+    } else {
+        memop |= MO_ATOM_NONE;
     }
 
     decode_save_opc(ctx);
-- 
2.25.1


