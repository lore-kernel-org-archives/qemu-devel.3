Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB488606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 06:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOrL0-000704-L3; Thu, 05 Nov 2026 01:52:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xOrKx-0006yy-JV; Thu, 05 Nov 2026 01:52:39 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>)
 id 1xOrKt-0000nJ-4A; Thu, 05 Nov 2026 01:52:39 -0500
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8CxutGuJ+xqXI8cAA--.17143S3;
 Thu, 05 Nov 2026 14:52:30 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJCx+c2sJ+xq+oEyAA--.18402S5;
 Thu, 05 Nov 2026 14:52:29 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Xianglai Li <lixianglai@loongson.cn>
Subject: [PULL 07/13] target/loongarch: Fix memory access address with fldle
Date: Thu,  5 Nov 2026 14:53:39 +0800
Message-ID: <20261105065345.966691-8-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105065345.966691-1-maobibo@loongson.cn>
References: <20261105065345.966691-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCx+c2sJ+xq+oEyAA--.18402S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CFy5CFyrGFW8uFyxKrWUJrc_yoW8uw4rpr
 s7Cr4Fya18JF97ArWkX3yFyF9xCa95Ga42gas2yw4SkFs3Xr1jv3W8K3ZakF48Xay8X3W0
 v3Wvyw1jqFW3G3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
 kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2F4iUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With instruction fldle, similar with ldle instruction, address of accessed
memory should come from register rj rather than rj + rk,. The same with
instruction fldgt/fstle/fstgt.

Cc: qemu-stable@nongnu.org
Fixes: 34423c019419 ("target/loongarch: Extract make_address_x() helper")
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Xianglai Li <lixianglai@loongson.cn>
---
 target/loongarch/tcg/insn_trans/trans_fmemory.c.inc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc b/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
index b863ba1dc2..628b33330b 100644
--- a/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
@@ -82,7 +82,7 @@ static bool gen_fload_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
     CHECK_FPE;
 
     gen_helper_asrtgt_d(tcg_env, src1, src2);
-    addr = make_address_x(ctx, src1, src2);
+    addr = make_address_i(ctx, src1, 0);
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
     set_fpr(a->fd, dest);
@@ -100,7 +100,7 @@ static bool gen_fstore_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
     CHECK_FPE;
 
     gen_helper_asrtgt_d(tcg_env, src1, src2);
-    addr = make_address_x(ctx, src1, src2);
+    addr = make_address_i(ctx, src1, 0);
     tcg_gen_qemu_st_tl(src3, addr, ctx->mem_idx, mop);
 
     return true;
@@ -116,7 +116,7 @@ static bool gen_fload_le(DisasContext *ctx, arg_frr *a, MemOp mop)
     CHECK_FPE;
 
     gen_helper_asrtle_d(tcg_env, src1, src2);
-    addr = make_address_x(ctx, src1, src2);
+    addr = make_address_i(ctx, src1, 0);
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
     set_fpr(a->fd, dest);
@@ -134,7 +134,7 @@ static bool gen_fstore_le(DisasContext *ctx, arg_frr *a, MemOp mop)
     CHECK_FPE;
 
     gen_helper_asrtle_d(tcg_env, src1, src2);
-    addr = make_address_x(ctx, src1, src2);
+    addr = make_address_i(ctx, src1, 0);
     tcg_gen_qemu_st_tl(src3, addr, ctx->mem_idx, mop);
 
     return true;
-- 
2.54.0


