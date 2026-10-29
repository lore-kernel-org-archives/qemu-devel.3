Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6602B606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMKzz-0003cl-Pg; Thu, 29 Oct 2026 03:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xMKzw-0003br-Sz; Thu, 29 Oct 2026 03:56:32 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>)
 id 1xMKzu-0004B6-4T; Thu, 29 Oct 2026 03:56:32 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8DxTtMj_OJqGWEaAA--.10553S3;
 Thu, 29 Oct 2026 15:56:20 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJAxFs0i_OJqlSkxAA--.45109S2;
 Thu, 29 Oct 2026 15:56:18 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PATCH] target/loongarch: Fix memory access address with fldle
Date: Thu, 29 Oct 2026 15:57:47 +0800
Message-ID: <20261029075747.73942-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxFs0i_OJqlSkxAA--.45109S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CFy5CFyrGFW8ZrW7tF4DJrc_yoW8uw4kpr
 s7Cr4Fya18JF97ArWkJ3yrtF9xCFZ5G3W2gasFyw4SkFs3Xr12v3W8K3ZakF48Xay8Xw10
 v3Wvyw1jqFW3G3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
 0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
 7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
 C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
 04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
 CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

base-commit: 73294d096cc591e122fde9e63db4739de6d84f2b
-- 
2.54.0


