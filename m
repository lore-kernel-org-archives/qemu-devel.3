Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32DFE9462A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 02:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpduz-0002RV-9l; Mon, 09 Feb 2026 21:56:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1vpdux-0002QF-2f
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:55:59 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1vpdut-0003wk-Tm
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:55:58 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxScI1noppeUoRAA--.55375S3;
 Tue, 10 Feb 2026 10:55:49 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDxD8Mtnoppm59DAA--.61278S3;
 Tue, 10 Feb 2026 10:55:48 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Jiajie Chen <c@jia.je>
Subject: [PULL 1/7] target/loongarch: Require atomics to be aligned
Date: Tue, 10 Feb 2026 10:30:34 +0800
Message-Id: <20260210023040.3507338-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260210023040.3507338-1-gaosong@loongson.cn>
References: <20260210023040.3507338-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxD8Mtnoppm59DAA--.61278S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jiajie Chen <c@jia.je>

Currently, all atomic instructions in LoongArch require the address to
be aligned.

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/tcg/insn_trans/trans_atomic.c.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
index a1de389e51..b8c962b65a 100644
--- a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
@@ -9,7 +9,7 @@ static bool gen_ll(DisasContext *ctx, arg_rr_i *a, MemOp mop)
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv t0 = make_address_i(ctx, src1, a->imm);
 
-    tcg_gen_qemu_ld_i64(t1, t0, ctx->mem_idx, mop);
+    tcg_gen_qemu_ld_i64(t1, t0, ctx->mem_idx, mop | MO_ALIGN);
     tcg_gen_st_tl(t0, tcg_env, offsetof(CPULoongArchState, lladdr));
     tcg_gen_st_tl(t1, tcg_env, offsetof(CPULoongArchState, llval));
     gen_set_gpr(a->rd, t1, EXT_NONE);
@@ -37,7 +37,7 @@ static bool gen_sc(DisasContext *ctx, arg_rr_i *a, MemOp mop)
     tcg_gen_mov_tl(val, src2);
     /* generate cmpxchg */
     tcg_gen_atomic_cmpxchg_tl(t0, cpu_lladdr, cpu_llval,
-                              val, ctx->mem_idx, mop);
+                              val, ctx->mem_idx, mop | MO_ALIGN);
     tcg_gen_setcond_tl(TCG_COND_EQ, dest, t0, cpu_llval);
     gen_set_label(done);
     gen_set_gpr(a->rd, dest, EXT_NONE);
@@ -63,7 +63,7 @@ static bool gen_am(DisasContext *ctx, arg_rrr *a,
 
     addr = make_address_i(ctx, addr, 0);
 
-    func(dest, addr, val, ctx->mem_idx, mop);
+    func(dest, addr, val, ctx->mem_idx, mop | MO_ALIGN);
     gen_set_gpr(a->rd, dest, EXT_NONE);
 
     return true;
-- 
2.52.0


