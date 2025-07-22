Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6636C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 10:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueA3y-0002Xd-Pa; Tue, 22 Jul 2025 06:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1ueA3r-0002Qj-FV
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 06:17:28 -0400
Received: from air.basealt.ru ([193.43.8.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1ueA3p-0000PT-SN
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 06:17:27 -0400
Received: from boringlust.malta.altlinux.ru (obninsk.basealt.ru
 [217.15.195.17]) (Authenticated sender: rastyoginds)
 by air.basealt.ru (Postfix) with ESMTPSA id 3536723392;
 Tue, 22 Jul 2025 13:17:24 +0300 (MSK)
From: gerben@altlinux.org
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: sdl.qemu@linuxtesting.org
Subject: [PATCH] target/ppc: fix potential shift overflow by using 64-bit
 constant
Date: Tue, 22 Jul 2025 13:16:47 +0300
Message-ID: <20250722101721.16458-1-gerben@altlinux.org>
X-Mailer: git-send-email 2.42.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.43.8.18; envelope-from=gerben@altlinux.org;
 helo=air.basealt.ru
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

From: Denis Rastyogin <gerben@altlinux.org>

Change shift operand from 32-bit literal `1` to 64-bit `1ULL` to avoid undefined behavior
when shifting bits beyond the width of a 32-bit integer.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
---
 target/ppc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 27f90c3cc5..8e69c4cb48 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2998,7 +2998,7 @@ static void gen_fetch_inc_conditional(DisasContext *ctx, MemOp memop,
 
     /* RT = (t != t2 ? t : u = 1<<(s*8-1)) */
     tcg_gen_movcond_tl(cond, cpu_gpr[rD(ctx->opcode)], t, t2, t,
-                       tcg_constant_tl(1 << (memop_size(memop) * 8 - 1)));
+                       tcg_constant_tl(1ULL << (memop_size(memop) * 8 - 1)));
 }
 
 static void gen_ld_atomic(DisasContext *ctx, MemOp memop)
-- 
2.42.2


