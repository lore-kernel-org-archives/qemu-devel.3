Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A183C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 15:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rez44-0003FK-H3; Tue, 27 Feb 2024 10:08:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rez42-0003En-Mj; Tue, 27 Feb 2024 10:08:14 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rez3v-0007v5-He; Tue, 27 Feb 2024 10:08:14 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 99B884E60DB;
 Tue, 27 Feb 2024 16:08:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id HehlKJsIgbOe; Tue, 27 Feb 2024 16:08:03 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AEA7B4E6005; Tue, 27 Feb 2024 16:08:03 +0100 (CET)
Message-Id: <ee0c65b99d2286dcacb7dbd9a833600fbd5573c9.1709045654.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1709045654.git.balaton@eik.bme.hu>
References: <cover.1709045654.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v7 03/10] target/ppc: Add gen_exception_err_nip() function
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org
Date: Tue, 27 Feb 2024 16:08:03 +0100 (CET)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

Add gen_exception_err_nip() that does the same as gen_exception_err()
but takes the nip as a parameter to allow specifying it instead of
using the current instruction address then change gen_exception_err()
to use it.

The gen_exception() and gen_exception_nip() functions are similar so
remove code duplication from those too while at it.

Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/translate.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 28fc7791af..d87aae0cc4 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -296,33 +296,26 @@ static inline void gen_update_nip(DisasContext *ctx, target_ulong nip)
     tcg_gen_movi_tl(cpu_nip, nip);
 }
 
-static void gen_exception_err(DisasContext *ctx, uint32_t excp, uint32_t error)
+static void gen_exception_err_nip(DisasContext *ctx, uint32_t excp,
+                                  uint32_t error, target_ulong nip)
 {
     TCGv_i32 t0, t1;
 
-    /*
-     * These are all synchronous exceptions, we set the PC back to the
-     * faulting instruction
-     */
-    gen_update_nip(ctx, ctx->cia);
+    gen_update_nip(ctx, nip);
     t0 = tcg_constant_i32(excp);
     t1 = tcg_constant_i32(error);
     gen_helper_raise_exception_err(tcg_env, t0, t1);
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
-static void gen_exception(DisasContext *ctx, uint32_t excp)
+static inline void gen_exception_err(DisasContext *ctx, uint32_t excp,
+                                     uint32_t error)
 {
-    TCGv_i32 t0;
-
     /*
      * These are all synchronous exceptions, we set the PC back to the
      * faulting instruction
      */
-    gen_update_nip(ctx, ctx->cia);
-    t0 = tcg_constant_i32(excp);
-    gen_helper_raise_exception(tcg_env, t0);
-    ctx->base.is_jmp = DISAS_NORETURN;
+    gen_exception_err_nip(ctx, excp, error, ctx->cia);
 }
 
 static void gen_exception_nip(DisasContext *ctx, uint32_t excp,
@@ -336,6 +329,15 @@ static void gen_exception_nip(DisasContext *ctx, uint32_t excp,
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
+static inline void gen_exception(DisasContext *ctx, uint32_t excp)
+{
+    /*
+     * These are all synchronous exceptions, we set the PC back to the
+     * faulting instruction
+     */
+    gen_exception_nip(ctx, excp, ctx->cia);
+}
+
 #if !defined(CONFIG_USER_ONLY)
 static void gen_ppc_maybe_interrupt(DisasContext *ctx)
 {
-- 
2.30.9


