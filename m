Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687ACC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBgE-0001Y7-4j; Wed, 14 May 2025 08:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBgC-0001Us-Bm; Wed, 14 May 2025 08:57:48 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBgA-0007lL-17; Wed, 14 May 2025 08:57:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6C9C7121ACE;
 Wed, 14 May 2025 15:56:31 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 18E0D20B846;
 Wed, 14 May 2025 15:56:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.18 14/18] target/arm: Don't assert() for ISB/SB inside IT
 block
Date: Wed, 14 May 2025 15:56:20 +0300
Message-Id: <20250514125640.91677-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.18-20250514114012@cover.tls.msk.ru>
References: <qemu-stable-7.2.18-20250514114012@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

If the guest code has an ISB or SB insn inside an IT block, we
generate incorrect code which trips a TCG assertion:

qemu-system-arm: ../tcg/tcg-op.c:3343: void tcg_gen_goto_tb(unsigned int): Assertion `(tcg_ctx->goto_tb_issue_mask & (1 << idx)) == 0' failed.

This is because we call gen_goto_tb(dc, 1, ...) twice:

 brcond_i32 ZF,$0x0,ne,$L1
 add_i32 pc,pc,$0x4
 goto_tb $0x1
 exit_tb $0x73d948001b81
 set_label $L1
 add_i32 pc,pc,$0x4
 goto_tb $0x1
 exit_tb $0x73d948001b81

Both calls are in arm_tr_tb_stop(), one for the
DISAS_NEXT/DISAS_TOO_MANY handling, and one for the dc->condjump
condition-failed codepath.  The DISAS_NEXT handling doesn't have this
problem because arm_post_translate_insn() does the handling of "emit
the label for the condition-failed conditional execution" and so
arm_tr_tb_stop() doesn't have dc->condjump set.  But for
DISAS_TOO_MANY we don't do that.

Fix the bug by making arm_post_translate_insn() handle the
DISAS_TOO_MANY case.  This only affects the SB and ISB insns when
used in Thumb mode inside an IT block: only these insns specifically
set is_jmp to TOO_MANY, and their A32 encodings are unconditional.

For the major TOO_MANY case (breaking the TB because it would cross a
page boundary) we do that check and set is_jmp to TOO_MANY only after
the call to arm_post_translate_insn(); so arm_post_translate_insn()
sees is_jmp == DISAS_NEXT, and  we emit the correct code for that
situation.

With this fix we generate the somewhat more sensible set of TCG ops:
 brcond_i32 ZF,$0x0,ne,$L1
 set_label $L1
 add_i32 pc,pc,$0x4
 goto_tb $0x1
 exit_tb $0x7c5434001b81

(NB: the TCG optimizer doesn't optimize out the jump-to-next, but
we can't really avoid emitting it because we don't know at the
point we're emitting the handling for the condexec check whether
this insn is going to happen to be a nop for us or not.)

Cc: qemu-stable@nongnu.org
Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2942
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250501125544.727038-1-peter.maydell@linaro.org
(cherry picked from commit 8ed7c0b6488a7f20318d6ba414f1cbcd0ed92afe)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 10dfa11a2b..ed9ed8ed0a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9545,7 +9545,8 @@ static bool arm_check_ss_active(DisasContext *dc)
 
 static void arm_post_translate_insn(DisasContext *dc)
 {
-    if (dc->condjmp && dc->base.is_jmp == DISAS_NEXT) {
+    if (dc->condjmp &&
+        (dc->base.is_jmp == DISAS_NEXT || dc->base.is_jmp == DISAS_TOO_MANY)) {
         if (dc->pc_save != dc->condlabel.pc_save) {
             gen_update_pc(dc, dc->condlabel.pc_save - dc->pc_save);
         }
-- 
2.39.5


