Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1C0606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=UojPygE/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJsQc-0003fA-6P; Thu, 22 Oct 2026 09:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xJsQF-0003YL-CY; Thu, 22 Oct 2026 09:01:37 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xJsQD-0007fH-EY; Thu, 22 Oct 2026 09:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=jjJ6axivM3BY8K+twFhLDYhd+Jr+0w/wM7P65srGIQc=; b=UojPygE/LNOkaLL
 paPzmJ1+01Up4uYba62sPRYmYpHPJ7F0sayXH/FQBcJJfn6tSSF6SWYO18ckDGwTfBnfByePV+JC7
 NO4H/SJlQXFEkdec45HxhC57qifNgugWDwRP/zWnyQJKJCjKYF23hurE+3hV93/dFgq8ecCFF41k+
 H8=;
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH] target/riscv: Fix CPU state access on big-endian hosts
Date: Thu, 22 Oct 2026 15:06:57 +0200
Message-ID: <20261022130657.6449-1-anjo@rev.ng>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

mstatus and mstatus_hs are uint64_t but accessed through

  tcg_gen_[ld|st]_tl(..., offsetof(mstatus))

which on a big-endian host running riscv32 incorrectly accesses the
top 32 bits rather than the lower bits.

Widen the operations to 64 bit so the lower bits are modified.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/tcg/translate.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
index ede9c2563f..79b0f444ef 100644
--- a/target/riscv/tcg/translate.c
+++ b/target/riscv/tcg/translate.c
@@ -693,7 +693,7 @@ static TCGv get_address_indexed(DisasContext *ctx, int rs1, TCGv offs)
  */
 static void mark_fs_dirty(DisasContext *ctx)
 {
-    TCGv tmp;
+    TCGv_i64 tmp;
 
     if (!has_ext(ctx, RVF)) {
         return;
@@ -703,15 +703,15 @@ static void mark_fs_dirty(DisasContext *ctx)
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
@@ -726,21 +726,21 @@ static inline void mark_fs_dirty(DisasContext *ctx) { }
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
2.52.0


