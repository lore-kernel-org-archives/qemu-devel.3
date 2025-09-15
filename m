Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD19CAC58E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 08:03:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy4A1-0007HJ-S7; Mon, 15 Sep 2025 04:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zeff@altlinux.org>)
 id 1uy49s-0007GI-8b; Mon, 15 Sep 2025 04:01:56 -0400
Received: from air.basealt.ru ([193.43.8.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zeff@altlinux.org>)
 id 1uy49h-00061J-2R; Mon, 15 Sep 2025 04:01:54 -0400
Received: from happy.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
 (Authenticated sender: sergeevdv)
 by air.basealt.ru (Postfix) with ESMTPSA id 75E6123338;
 Mon, 15 Sep 2025 11:01:29 +0300 (MSK)
From: Denis Sergeev <zeff@altlinux.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, rathc@linux.ibm.com,
 zeff@altlinux.org
Subject: [PATCH] target/ppc: use MAKE_64BIT_MASK for mcrfs exception clear mask
Date: Mon, 15 Sep 2025 11:01:18 +0300
Message-ID: <20250915080118.29898-1-zeff@altlinux.org>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.43.8.18; envelope-from=zeff@altlinux.org;
 helo=air.basealt.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In gen_mcrfs() the FPSCR nibble mask is computed as:
      `~((0xF << shift) & FP_EX_CLEAR_BITS)`

Here, 0xF is of type int, so the left shift is performed in
32-bit signed arithmetic. For bfa=0 we get shift=28,
and (0xF << 28) = 0xF0000000, which is not representable as a 32-bit
signed int. Static analyzers flag this as a potential integer
overflow.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Sergeev <zeff@altlinux.org>
---
 target/ppc/translate/fp-impl.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/translate/fp-impl.c.inc b/target/ppc/translate/fp-impl.c.inc
index a66b83398b..d01c0b5aba 100644
--- a/target/ppc/translate/fp-impl.c.inc
+++ b/target/ppc/translate/fp-impl.c.inc
@@ -479,7 +479,7 @@ static void gen_mcrfs(DisasContext *ctx)
     tcg_gen_extu_tl_i64(tnew_fpscr, cpu_fpscr);
     /* Only the exception bits (including FX) should be cleared if read */
     tcg_gen_andi_i64(tnew_fpscr, tnew_fpscr,
-                     ~((0xF << shift) & FP_EX_CLEAR_BITS));
+                     ~(MAKE_64BIT_MASK(shift, 4) & FP_EX_CLEAR_BITS));
     /* FEX and VX need to be updated, so don't set fpscr directly */
     tmask = tcg_constant_i32(1 << nibble);
     gen_helper_store_fpscr(tcg_env, tnew_fpscr, tmask);
-- 
2.50.1


