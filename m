Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6670C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 20:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXyk-0001vX-QG; Thu, 18 Apr 2024 16:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxXyh-0001pE-IZ; Thu, 18 Apr 2024 16:03:27 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxXyf-0005TH-Vx; Thu, 18 Apr 2024 16:03:27 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4CE0C5FE18;
 Thu, 18 Apr 2024 23:02:28 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id AC012B93FE;
 Thu, 18 Apr 2024 23:02:25 +0300 (MSK)
Received: (nullmailer pid 952888 invoked by uid 1000);
 Thu, 18 Apr 2024 20:02:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zack Buhman <zack@buhman.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.11 57/59] target/sh4: add missing CHECK_NOT_DELAY_SLOT
Date: Thu, 18 Apr 2024 23:02:17 +0300
Message-Id: <20240418200224.952785-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.11-20240418230159@cover.tls.msk.ru>
References: <qemu-stable-7.2.11-20240418230159@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Zack Buhman <zack@buhman.org>

CHECK_NOT_DELAY_SLOT is correctly applied to the branch-related
instructions, but not to the PC-relative mov* instructions.

I verified the existence of an illegal slot exception on a SH7091 when
any of these instructions are attempted inside a delay slot.

This also matches the behavior described in the SH-4 ISA manual.

Signed-off-by: Zack Buhman <zack@buhman.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240407150705.5965-1-zack@buhman.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewd-by: Yoshinori Sato <ysato@users.sourceforge.jp>
(cherry picked from commit b754cb2dcde26a7bc8a9d17bb6900a0ac0dd38e2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: trivial context (whitespace before comments) fixup)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 7db3468b01..8d6eae7ddf 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -528,6 +528,7 @@ static void _decode_opc(DisasContext * ctx)
 	tcg_gen_movi_i32(REG(B11_8), B7_0s);
 	return;
     case 0x9000:		/* mov.w @(disp,PC),Rn */
+        CHECK_NOT_DELAY_SLOT
 	{
             TCGv addr = tcg_const_i32(ctx->base.pc_next + 4 + B7_0 * 2);
             tcg_gen_qemu_ld_i32(REG(B11_8), addr, ctx->memidx, MO_TESW);
@@ -535,6 +536,7 @@ static void _decode_opc(DisasContext * ctx)
 	}
 	return;
     case 0xd000:		/* mov.l @(disp,PC),Rn */
+        CHECK_NOT_DELAY_SLOT
 	{
             TCGv addr = tcg_const_i32((ctx->base.pc_next + 4 + B7_0 * 4) & ~3);
             tcg_gen_qemu_ld_i32(REG(B11_8), addr, ctx->memidx, MO_TESL);
@@ -1295,6 +1297,7 @@ static void _decode_opc(DisasContext * ctx)
 	}
 	return;
     case 0xc700:		/* mova @(disp,PC),R0 */
+        CHECK_NOT_DELAY_SLOT
         tcg_gen_movi_i32(REG(0), ((ctx->base.pc_next & 0xfffffffc) +
                                   4 + B7_0 * 4) & ~3);
 	return;
-- 
2.39.2


