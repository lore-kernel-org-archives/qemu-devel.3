Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43413C54E68
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 01:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmkwQ-00076v-LY; Tue, 19 Mar 2024 21:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rmkwN-00076T-Cm
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 21:40:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rmkw9-0001e1-L8
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 21:40:20 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxuvBvPvplrwgbAA--.64991S3;
 Wed, 20 Mar 2024 09:39:59 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxzxNuPvplMvVdAA--.61215S2; 
 Wed, 20 Mar 2024 09:39:58 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, c@jia.je, philmd@linaro.org,
 maobibo@loongson.cn, lixing@loongson.cn
Subject: [PATCH v2] target/loongarch: Fix qemu-loongarch64 hang when executing
 'll.d $t0, $t0, 0'
Date: Wed, 20 Mar 2024 09:39:55 +0800
Message-Id: <20240320013955.1561311-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxzxNuPvplMvVdAA--.61215S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On gen_ll, if a->imm is zero, make_address_x return src1,
but the load to destination may clobber src1. We use a new
destination to fix this problem.

Fixes: c5af6628f4be (target/loongarch: Extract make_address_i() helper)
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/tcg/insn_trans/trans_atomic.c.inc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
index 80c2e286fd..974bc2a70f 100644
--- a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
@@ -5,14 +5,14 @@
 
 static bool gen_ll(DisasContext *ctx, arg_rr_i *a, MemOp mop)
 {
-    TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
+    TCGv t1 = tcg_temp_new();
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv t0 = make_address_i(ctx, src1, a->imm);
 
-    tcg_gen_qemu_ld_i64(dest, t0, ctx->mem_idx, mop);
+    tcg_gen_qemu_ld_i64(t1, t0, ctx->mem_idx, mop);
     tcg_gen_st_tl(t0, tcg_env, offsetof(CPULoongArchState, lladdr));
-    tcg_gen_st_tl(dest, tcg_env, offsetof(CPULoongArchState, llval));
-    gen_set_gpr(a->rd, dest, EXT_NONE);
+    tcg_gen_st_tl(t1, tcg_env, offsetof(CPULoongArchState, llval));
+    gen_set_gpr(a->rd, t1, EXT_NONE);
 
     return true;
 }
-- 
2.25.1


