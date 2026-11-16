Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2B9606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=bibt/eSW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3OL-0004aw-J6; Mon, 16 Nov 2026 15:33:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3M7-0000j7-Kd; Mon, 16 Nov 2026 15:31:20 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Lc-0002GU-67; Mon, 16 Nov 2026 15:31:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860765; bh=VZYeQs9fkeLwh05Oo7J7HwmY1T+Ic3dcIVWW9Eu5goE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bibt/eSWHxHKfEsOF5OdMsnOlBJAfFLFi09g9yOeVFwbybP+gYrOhMbkZ0fwIe+JX
 X34aJ1jQ7vBqCFDrbY2ByhUBj5hKhcyIh60RL+XYBdNDnPmlzjjYlyKKpnH97TeWbE
 DUuTNDqcCw03qYuVMlR1UeLpArvVSxwjJ2eISB06do7KrFy03RzCGWB/c8PR1/s7Xx
 xeLnq3GdVS1PzDmRc390wvLEbGOyJ5OF5R9PkXpEcagZ8UXWqTybHBvIAkHw4WWtZQ
 uFeXUyklCVVYu2wyJCd/eiHo1rZKbaUCNPTxPmupru1MghdFDchiv2Chw3qebMX+6E
 fqvj4r2d+dE2A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9AEFF1E71C4;
 Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9876C45FBF0;
 Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 50A2DB8EA4; Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Tommaso Califano <tcalifano@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 47/63] target/riscv: Fix CPU state access on
 big-endian hosts
Date: Mon, 16 Nov 2026 23:25:26 +0300
Message-ID: <20261116202554.535325-47-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
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

diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
index 9684dbe7528..1f6bcb16f78 100644
--- a/target/riscv/tcg/translate.c
+++ b/target/riscv/tcg/translate.c
@@ -684,7 +684,7 @@ static TCGv get_address_indexed(DisasContext *ctx, int rs1, TCGv offs)
  */
 static void mark_fs_dirty(DisasContext *ctx)
 {
-    TCGv tmp;
+    TCGv_i64 tmp;
 
     if (!has_ext(ctx, RVF)) {
         return;
@@ -694,15 +694,15 @@ static void mark_fs_dirty(DisasContext *ctx)
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
@@ -717,21 +717,21 @@ static inline void mark_fs_dirty(DisasContext *ctx) { }
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


