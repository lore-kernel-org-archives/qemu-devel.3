Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D5CC52D72
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 07:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZmgY-0003Da-BL; Fri, 02 Aug 2024 03:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sZmgT-0002vp-LP; Fri, 02 Aug 2024 03:26:41 -0400
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sZmgR-0003j9-H8; Fri, 02 Aug 2024 03:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1722583594; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
 bh=xlzdiXK8B41IrEGqINwACSXTyo01TRzc8KDruDLPmlI=;
 b=lZ3cxdm3OTbX37KKEKGyYs1A1xB57WvHXRR7X39vf7rSR3glI2TCCxw+Ioeh+iA8mWxp5WYnkQ/f78ZIWhoXwac/mAmItet3Mr4s1L96nU0aAr65hQUgPbgsY22MfUbQ8qMBVM86RHr8WCCUhyCygGl0Rwk/YAPCWiDxv9rP1PI=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037067112;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0WBwhJWB_1722583592; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WBwhJWB_1722583592) by smtp.aliyun-inc.com;
 Fri, 02 Aug 2024 15:26:34 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org
Subject: [PATCH v3 3/3] target/riscv: Relax fld alignment requirement
Date: Fri,  2 Aug 2024 15:24:17 +0800
Message-Id: <20240802072417.659-4-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240802072417.659-1-zhiwei_liu@linux.alibaba.com>
References: <20240802072417.659-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
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
 target/riscv/insn_trans/trans_rvd.c.inc | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_trans/trans_rvd.c.inc
index 49682292b8..8a46124f98 100644
--- a/target/riscv/insn_trans/trans_rvd.c.inc
+++ b/target/riscv/insn_trans/trans_rvd.c.inc
@@ -48,11 +48,17 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
     REQUIRE_EXT(ctx, RVD);
 
     /*
-     * Zama16b applies to loads and stores of no more than MXLEN bits defined
-     * in the F, D, and Q extensions.
+     * FLD and FSD are only guaranteed to execute atomically if the effective
+     * address is naturally aligned and XLEN≥64. Also, zama16b applies to
+     * loads and stores of no more than MXLEN bits defined in the F, D, and
+     * Q extensions.
      */
-    if ((get_xl_max(ctx) >= MXL_RV64) && ctx->cfg_ptr->ext_zama16b) {
+    if (get_xl_max(ctx) == MXL_RV32) {
+        memop |= MO_ATOM_NONE;
+    } else if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
+    } else {
+        memop |= MO_ATOM_IFALIGN;
     }
 
     decode_save_opc(ctx);
@@ -71,8 +77,12 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
 
-    if ((get_xl_max(ctx) >= MXL_RV64) && ctx->cfg_ptr->ext_zama16b) {
+    if (get_xl_max(ctx) == MXL_RV32) {
+        memop |= MO_ATOM_NONE;
+    } else if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
+    } else {
+        memop |= MO_ATOM_IFALIGN;
     }
 
     decode_save_opc(ctx);
-- 
2.25.1


