Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF038C52D73
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 07:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZmfV-0006bS-Jj; Fri, 02 Aug 2024 03:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sZmfS-0006Oz-GK; Fri, 02 Aug 2024 03:25:38 -0400
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sZmfP-0002rR-RH; Fri, 02 Aug 2024 03:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1722583531; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=1wf4HpqwJRrVOsX9aa3s2Lv9sh6eQx/lo2cpXCdYjtY=;
 b=Gy8O3P8MF6RK0wsi10xbI69csYVt6Y2I2Fh24CgLqq0qqbRTzugrRoUvcggjM6sXMNNECfNHwtFEhHrVkDXh+9800oI+gDSzo4gx1IJgphBdcn/ZAhrFgNVgd0T6P8XcA2tWaMzCPWsLhZwlWL4zgmXl7MUbcu5R9TJOzpL7NPE=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033068173054;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0WBwbS2q_1722583529; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WBwbS2q_1722583529) by smtp.aliyun-inc.com;
 Fri, 02 Aug 2024 15:25:30 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org
Subject: [PATCH v3 1/3] target/riscv: Remove redundant insn length check for
 zama16b
Date: Fri,  2 Aug 2024 15:24:15 +0800
Message-Id: <20240802072417.659-2-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240802072417.659-1-zhiwei_liu@linux.alibaba.com>
References: <20240802072417.659-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-97.freemail.mail.aliyun.com
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

Compressed encodings also applies to zama16b.
https://github.com/riscv/riscv-isa-manual/pull/1557

Suggested-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/riscv/insn_trans/trans_rvd.c.inc | 4 ++--
 target/riscv/insn_trans/trans_rvf.c.inc | 4 ++--
 target/riscv/insn_trans/trans_rvi.c.inc | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_trans/trans_rvd.c.inc
index 1f5fac65a2..0ac42c3223 100644
--- a/target/riscv/insn_trans/trans_rvd.c.inc
+++ b/target/riscv/insn_trans/trans_rvd.c.inc
@@ -47,7 +47,7 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
 
-    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len != 2)) {
+    if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
 
@@ -67,7 +67,7 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
 
-    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len != 2)) {
+    if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
 
diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_trans/trans_rvf.c.inc
index f771aa1939..0222a728df 100644
--- a/target/riscv/insn_trans/trans_rvf.c.inc
+++ b/target/riscv/insn_trans/trans_rvf.c.inc
@@ -48,7 +48,7 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
 
-    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len != 2)) {
+    if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
 
@@ -70,7 +70,7 @@ static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
 
-    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len != 2)) {
+    if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
 
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 98e3806d5e..fab5c06719 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -268,7 +268,7 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
 {
     bool out;
 
-    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len != 2)) {
+    if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
     decode_save_opc(ctx);
@@ -369,7 +369,7 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a, MemOp memop)
 
 static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
 {
-    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len != 2)) {
+    if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
     decode_save_opc(ctx);
-- 
2.25.1


