Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF60C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBkl-0000KP-Ak; Wed, 14 May 2025 09:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBid-0007IP-2i; Wed, 14 May 2025 09:00:22 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBiV-0008Ap-Cl; Wed, 14 May 2025 09:00:18 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 11F74121AF2;
 Wed, 14 May 2025 15:57:50 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B23CB20B860;
 Wed, 14 May 2025 15:57:59 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.4 20/34] target/avr: Improve decode of LDS, STS
Date: Wed, 14 May 2025 15:57:42 +0300
Message-Id: <20250514125758.92030-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.4-20250514155748@cover.tls.msk.ru>
References: <qemu-stable-9.2.4-20250514155748@cover.tls.msk.ru>
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

From: Richard Henderson <richard.henderson@linaro.org>

The comment about not being able to define a field with
zero bits is out of date since 94597b6146f3
("decodetree: Allow !function with no input bits").

This fixes the missing load of imm in the disassembler.

Cc: qemu-stable@nongnu.org
Fixes: 9d8caa67a24 ("target/avr: Add support for disassembling via option '-d in_asm'")
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 6b661b7ed7cd02c54a78426d5eb7dd8543b030ed)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/avr/insn.decode b/target/avr/insn.decode
index 482c23ad0c..cc302249db 100644
--- a/target/avr/insn.decode
+++ b/target/avr/insn.decode
@@ -118,11 +118,8 @@ BRBC            1111 01 ....... ...         @op_bit_imm
 @io_rd_imm      .... . .. ..... ....        &rd_imm     rd=%rd imm=%io_imm
 @ldst_d         .. . . .. . rd:5  . ...     &rd_imm     imm=%ldst_d_imm
 
-# The 16-bit immediate is completely in the next word.
-# Fields cannot be defined with no bits, so we cannot play
-# the same trick and append to a zero-bit value.
-# Defer reading the immediate until trans_{LDS,STS}.
-@ldst_s         .... ... rd:5 ....          imm=0
+%ldst_imm       !function=next_word
+@ldst_s         .... ... rd:5 ....          imm=%ldst_imm
 
 MOV             0010 11 . ..... ....        @op_rd_rr
 MOVW            0000 0001 .... ....         &rd_rr      rd=%rd_d rr=%rr_d
diff --git a/target/avr/translate.c b/target/avr/translate.c
index 2d51892115..e8279a18df 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -1577,7 +1577,6 @@ static bool trans_LDS(DisasContext *ctx, arg_LDS *a)
     TCGv Rd = cpu_r[a->rd];
     TCGv addr = tcg_temp_new_i32();
     TCGv H = cpu_rampD;
-    a->imm = next_word(ctx);
 
     tcg_gen_mov_tl(addr, H); /* addr = H:M:L */
     tcg_gen_shli_tl(addr, addr, 16);
@@ -1782,7 +1781,6 @@ static bool trans_STS(DisasContext *ctx, arg_STS *a)
     TCGv Rd = cpu_r[a->rd];
     TCGv addr = tcg_temp_new_i32();
     TCGv H = cpu_rampD;
-    a->imm = next_word(ctx);
 
     tcg_gen_mov_tl(addr, H); /* addr = H:M:L */
     tcg_gen_shli_tl(addr, addr, 16);
-- 
2.39.5


