Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00548CD8C88
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2026 14:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWE6v-0004M9-Jf; Sun, 07 Jun 2026 10:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wWE6u-0004M0-Er
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 10:04:20 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wWE6s-00086t-VD
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 10:04:20 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0917843688;
 Sun,  7 Jun 2026 14:04:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C2E1F00893;
 Sun,  7 Jun 2026 14:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780841057;
 bh=jX18zqXFA+LNSDjlxcNAVPph0zpvwfV3CNTKM9znobo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BCP9ldpq/Cad+rp8Dys2X92OYmtVQsR+21UTrdZLs9JGKe1TSkajp0OI2duEzQBto
 aRjmFUfoz5U51F14flmvVq3Mlw/71vYIqCNzPPnRVCA20CQg90617g2fw58b5nA3Jh
 tI6tc6U8foDWaE8xZmwymvhhInngFC6OP7I7bMb8vPe6679feNsqYBhCrjN7OueIwS
 GoAnriW3odiCTbSpoY8MCDxTgQDhfdrQ2tzVysUc6BEOW7EHmA/f9cd2AASfOwC2cb
 ScbN5MCuDJVp+qJVx0g2MD6crj2T+sgZjLIscdx40wTT0honNbKh7EXD2m18UBiAiT
 6Y2WSE9wrK19w==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Helge Deller <deller@gmx.de>,
 Matt Turner <mattst88@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 08/10] target/sh4: decode_gusa: recognize add#imm with prior
 mov Rm, Rn
Date: Sun,  7 Jun 2026 16:03:54 +0200
Message-ID: <20260607140356.10702-9-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607140356.10702-1-deller@kernel.org>
References: <20260607140356.10702-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Matt Turner <mattst88@gmail.com>

The gUSA pattern matcher rejected `add #imm, Rn` whenever any prior
`mov Rm, Rn` appeared (mv_src >= 0), forcing a fallback to
cpu_exec_step_atomic for sequences like:

  mov.l  @r2, r3      ; load
  mov    r3, r7       ; save old value (mv_src == ld_dst)
  add    #1, r7       ; increment copy
  mov.l  r7, @r2      ; store

When mv_src == ld_dst the move merely copies the loaded value to
preserve it -- exactly the situation already accepted for the
`add Rm, Rn` form. The immediate form can be handled identically with
tcg_gen_atomic_fetch_add_i32 + tcg_gen_add_i32, so translate it inline
instead of taking the slower single-step atomic fallback.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/sh4/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 5adf650744..d38a6bd352 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1974,7 +1974,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
         break;
 
     case 0x7000 ... 0x700f: /* add #imm,Rn */
-        if (op_dst != B11_8 || mv_src >= 0) {
+        if (op_dst != B11_8 || (mv_src >= 0 && mv_src != ld_dst)) {
             goto fail;
         }
         op_opc = INDEX_op_add;
-- 
2.54.0


