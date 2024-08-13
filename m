Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BA9C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 11:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdppZ-00070Z-TM; Tue, 13 Aug 2024 07:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sdppW-0006iY-8F; Tue, 13 Aug 2024 07:36:47 -0400
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sdppU-0002ap-7C; Tue, 13 Aug 2024 07:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1723548999; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=7AK5MBa+OFFOyBHmGkLLwGS+2t3aszxPpZggK7yCWgs=;
 b=LrRYmgrA5NFHmwbp8WXqe56zKaLgaa59cezDGAEvMS6GRIR/RaQ7HQBkcTR0jmQnYJfxyU6c6Z7yOLnpj2BK0j1BAxEl0VHeLao15/fDmJf93qXDrGijbBqmm9Yp8JA1Ja9+j6MiFs5DOMbFt/T+0kmlRzGdNmwlU8pMVmRCa1M=
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WCp.8Wm_1723548997) by smtp.aliyun-inc.com;
 Tue, 13 Aug 2024 19:36:38 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v1 03/15] tcg: Fix register allocation constraints
Date: Tue, 13 Aug 2024 19:34:24 +0800
Message-Id: <20240813113436.831-4-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.124;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-124.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

When allocating registers for input and output, ensure they match
the available registers to avoid allocating illeagal registers.

We should respect RISC-V vector extension's variable-length registers
and LMUL-based register grouping. Coordinate with tcg_target_available_regs
initialization tcg_target_init (behind this commit) to ensure proper
handling of vector register constraints.

Note: While mov_vec doesn't have constraints, dup_vec and other IRs do.
We need to strengthen constraints for all IRs except mov_vec, and this
is sufficient.

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Fixes: 29f5e92502 (tcg: Introduce paired register allocation)
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 tcg/tcg.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 34e3056380..d26b42534d 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -4722,8 +4722,10 @@ static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
         return;
     }
 
-    dup_out_regs = tcg_op_defs[INDEX_op_dup_vec].args_ct[0].regs;
-    dup_in_regs = tcg_op_defs[INDEX_op_dup_vec].args_ct[1].regs;
+    dup_out_regs = tcg_op_defs[INDEX_op_dup_vec].args_ct[0].regs &
+                                    tcg_target_available_regs[ots->type];
+    dup_in_regs = tcg_op_defs[INDEX_op_dup_vec].args_ct[1].regs &
+                                    tcg_target_available_regs[its->type];
 
     /* Allocate the output register now.  */
     if (ots->val_type != TEMP_VAL_REG) {
@@ -4876,7 +4878,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
 
         reg = ts->reg;
         i_preferred_regs = 0;
-        i_required_regs = arg_ct->regs;
+        i_required_regs = arg_ct->regs & tcg_target_available_regs[ts->type];
         allocate_new_reg = false;
         copyto_new_reg = false;
 
@@ -5078,6 +5080,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
 
         /* satisfy the output constraints */
         for(k = 0; k < nb_oargs; k++) {
+            TCGRegSet o_required_regs;
             i = def->args_ct[k].sort_index;
             arg = op->args[i];
             arg_ct = &def->args_ct[i];
@@ -5085,17 +5088,19 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
 
             /* ENV should not be modified.  */
             tcg_debug_assert(!temp_readonly(ts));
+            o_required_regs = arg_ct->regs &
+                              tcg_target_available_regs[ts->type];
 
             switch (arg_ct->pair) {
             case 0: /* not paired */
                 if (arg_ct->oalias && !const_args[arg_ct->alias_index]) {
                     reg = new_args[arg_ct->alias_index];
                 } else if (arg_ct->newreg) {
-                    reg = tcg_reg_alloc(s, arg_ct->regs,
+                    reg = tcg_reg_alloc(s, o_required_regs,
                                         i_allocated_regs | o_allocated_regs,
                                         output_pref(op, k), ts->indirect_base);
                 } else {
-                    reg = tcg_reg_alloc(s, arg_ct->regs, o_allocated_regs,
+                    reg = tcg_reg_alloc(s, o_required_regs, o_allocated_regs,
                                         output_pref(op, k), ts->indirect_base);
                 }
                 break;
@@ -5104,12 +5109,13 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
                 if (arg_ct->oalias) {
                     reg = new_args[arg_ct->alias_index];
                 } else if (arg_ct->newreg) {
-                    reg = tcg_reg_alloc_pair(s, arg_ct->regs,
+                    reg = tcg_reg_alloc_pair(s, o_required_regs,
                                              i_allocated_regs | o_allocated_regs,
                                              output_pref(op, k),
                                              ts->indirect_base);
                 } else {
-                    reg = tcg_reg_alloc_pair(s, arg_ct->regs, o_allocated_regs,
+                    reg = tcg_reg_alloc_pair(s, o_required_regs,
+                                             o_allocated_regs,
                                              output_pref(op, k),
                                              ts->indirect_base);
                 }
-- 
2.43.0


