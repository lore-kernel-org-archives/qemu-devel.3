Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E73E606A32A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=Ys6fz0nZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3ES-00061z-VU; Mon, 16 Nov 2026 15:23:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3EQ-0005vJ-Ai; Mon, 16 Nov 2026 15:23:14 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3EO-0003eV-Jc; Mon, 16 Nov 2026 15:23:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860372; bh=+E2vT1HGOlmve3KrlDJHOjYXSVaj9LO7zh5tk2Wwplg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ys6fz0nZ7UrXSjbVw1zljAvTmDzetv963DEPDdv+1rF7M9grnlfEImGe1EP1HDAM3
 QfCgWm8X85PEXe1F1FzF+sxkobfkJ4+TUqNqGnCGrusA95+QktBYl1FQ/ElVh0KQtz
 Mk/U0DN3ikx+q+qUfZ1Fk3cQXX89Jof38GSIguHFICgJhSVHZjFj81OyqcEbzVR8ie
 M/GwIMLTuudhW2ClT7vxMJQ2+RYUaidPABm0K4BrfsdNyZ0V4l1B4MfWEEFvpDVPHZ
 qVB76c9IoZuXc+jlhUrvutysozggw3miU3DCRnmFiD2XoVQlG6/db+FD0QlOeWgU+s
 Zyd35+vDhDW0A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CEB731E715F;
 Mon, 16 Nov 2026 23:19:32 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CA69C45FB98;
 Mon, 16 Nov 2026 23:19:32 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 72447B8E20; Mon, 16 Nov 2026 23:19:32 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Tommaso Califano <tcalifano@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 41/59] target/riscv: Fix CPU state access on
 big-endian hosts
Date: Mon, 16 Nov 2026 23:18:45 +0300
Message-ID: <20261116201922.534306-41-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Anton Johansson <anjo@rev.ng>

mstatus and mstatus_hs are uint64_t but accessed through

  tcg_gen_[ld|st]_tl(..., offsetof(mstatus))

which on a big-endian host running riscv32 incorrectly accesses the
top 32 bits rather than the lower bits.

Widen the operations to 64 bit so the lower bits are modified.

Fixes: 284d697c74ef ("target/riscv: Merge m/vsstatus and m/vsstatush into one uint64_t unit")
Reviewed-by: Tommaso Califano <tcalifano@redhat.com>
Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20261023063025.8827-1-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit bf67d56f282c1ee25b67dfda3f8ca54d2bd4648e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index e1e087a36b7..b8df29745b6 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -670,7 +670,7 @@ static TCGv get_address_indexed(DisasContext *ctx, int rs1, TCGv offs)
  */
 static void mark_fs_dirty(DisasContext *ctx)
 {
-    TCGv tmp;
+    TCGv_i64 tmp;
 
     if (!has_ext(ctx, RVF)) {
         return;
@@ -680,15 +680,15 @@ static void mark_fs_dirty(DisasContext *ctx)
         /* Remember the state change for the rest of the TB. */
         ctx->mstatus_fs = EXT_STATUS_DIRTY;
 
-        tmp = tcg_temp_new();
-        tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
-        tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
-        tcg_gen_st_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
+        tmp = tcg_temp_new_i64();
+        tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
+        tcg_gen_ori_i64(tmp, tmp, MSTATUS_FS);
+        tcg_gen_st_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
 
         if (ctx->virt_enabled) {
-            tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
-            tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
-            tcg_gen_st_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
+            tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
+            tcg_gen_ori_i64(tmp, tmp, MSTATUS_FS);
+            tcg_gen_st_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
         }
     }
 }
@@ -703,21 +703,21 @@ static inline void mark_fs_dirty(DisasContext *ctx) { }
  */
 static void mark_vs_dirty(DisasContext *ctx)
 {
-    TCGv tmp;
+    TCGv_i64 tmp;
 
     if (ctx->mstatus_vs != EXT_STATUS_DIRTY) {
         /* Remember the state change for the rest of the TB.  */
         ctx->mstatus_vs = EXT_STATUS_DIRTY;
 
-        tmp = tcg_temp_new();
-        tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
-        tcg_gen_ori_tl(tmp, tmp, MSTATUS_VS);
-        tcg_gen_st_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
+        tmp = tcg_temp_new_i64();
+        tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
+        tcg_gen_ori_i64(tmp, tmp, MSTATUS_VS);
+        tcg_gen_st_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
 
         if (ctx->virt_enabled) {
-            tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
-            tcg_gen_ori_tl(tmp, tmp, MSTATUS_VS);
-            tcg_gen_st_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
+            tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
+            tcg_gen_ori_i64(tmp, tmp, MSTATUS_VS);
+            tcg_gen_st_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
         }
     }
 }
-- 
2.47.3


