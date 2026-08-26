Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64B2C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 10:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzAus-00027m-BO; Wed, 26 Aug 2026 06:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1wzAua-00020x-80
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:31:18 -0400
Received: from [2a14:640:1:12b5::1] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1wzAuY-0003OT-Jy
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:31:16 -0400
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id 052AB7A17;
 Wed, 26 Aug 2026 16:01:02 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, xianglai li <lixianglai@loongson.cn>,
 SignKirigami <prcups@krgm.moe>, Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v4 13/14] target/loongarch: Translate LVZ guest traps and HVC
Date: Wed, 26 Aug 2026 18:30:17 +0800
Message-ID: <ac951e0b31cc1e90fbb0274becc0877f509f0370.1787739852.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787739852.git.prcups@krgm.moe>
References: <cover.1787739852.git.prcups@krgm.moe>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2a14:640:1:12b5::1 (failed)
Received-SPF: pass client-ip=2a14:640:1:12b5::1; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Raise GSPR when a guest accesses IOCSR, debug or idle resources, and
decode HVC for guest PLV0.

Use the common exception path so trapping instructions do not manufacture
destination values or require a helper named after the exception cause.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/disas.c                      |  1 +
 target/loongarch/insns.decode                 |  1 +
 .../tcg/insn_trans/trans_privileged.c.inc     | 32 +++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 54c35b8d03..82b0bf868f 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -712,6 +712,7 @@ INSN(gtlbsrch,     empty)
 INSN(gtlbrd,       empty)
 INSN(gtlbwr,       empty)
 INSN(gtlbfill,     empty)
+INSN(hvcl,         i)
 INSN(cacop,        cop_r_i)
 INSN(lddir,        rr_i)
 INSN(ldpte,        j_i)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index cbcc30c31f..b40fabe9d7 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -505,6 +505,7 @@ gtlbsrch         0000 01100100 10000 01010 00000 00001    @empty
 gtlbrd           0000 01100100 10000 01011 00000 00001    @empty
 gtlbwr           0000 01100100 10000 01100 00000 00001    @empty
 gtlbfill         0000 01100100 10000 01101 00000 00001    @empty
+hvcl             0000 0000 0010 1011 1 ...............    @i15
 
 iocsrrd_b        0000 01100100 10000 00000 ..... .....    @rr
 iocsrrd_h        0000 01100100 10000 00001 ..... .....    @rr
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index fb6318b438..2dedcadfbb 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -48,6 +48,7 @@ GEN_FALSE_TRANS(gtlbsrch)
 GEN_FALSE_TRANS(gtlbrd)
 GEN_FALSE_TRANS(gtlbwr)
 GEN_FALSE_TRANS(gtlbfill)
+GEN_FALSE_TRANS(hvcl)
 
 #else
 
@@ -347,6 +348,10 @@ static bool gen_iocsrrd(DisasContext *ctx, arg_rr *a,
     if (check_plv(ctx)) {
         return false;
     }
+    if (ctx->guest_mode) {
+        generate_exception(ctx, EXCCODE_GSPR);
+        return true;
+    }
     func(dest, tcg_env, src1);
     return true;
 }
@@ -360,6 +365,10 @@ static bool gen_iocsrwr(DisasContext *ctx, arg_rr *a,
     if (check_plv(ctx)) {
         return false;
     }
+    if (ctx->guest_mode) {
+        generate_exception(ctx, EXCCODE_GSPR);
+        return true;
+    }
     func(tcg_env, addr, val);
     return true;
 }
@@ -624,6 +633,10 @@ static bool trans_dbcl(DisasContext *ctx, arg_dbcl *a)
     if (check_plv(ctx)) {
         return false;
     }
+    if (ctx->guest_mode) {
+        generate_exception(ctx, EXCCODE_GSPR);
+        return true;
+    }
     generate_exception(ctx, EXCCODE_DBP);
     return true;
 }
@@ -634,9 +647,28 @@ static bool trans_idle(DisasContext *ctx, arg_idle *a)
         return false;
     }
 
+    if (ctx->guest_mode) {
+        generate_exception(ctx, EXCCODE_GSPR);
+        return true;
+    }
+
     tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next + 4);
     gen_helper_idle(tcg_env);
     ctx->base.is_jmp = DISAS_NORETURN;
     return true;
 }
+
+static bool trans_hvcl(DisasContext *ctx, arg_hvcl *a)
+{
+    if (!avail_LVZ(ctx) || !ctx->guest_mode) {
+        return false;
+    }
+    if (ctx->plv != MMU_PLV_KERNEL) {
+        generate_exception(ctx, EXCCODE_IPE);
+        return true;
+    }
+
+    generate_exception(ctx, EXCCODE_HVC);
+    return true;
+}
 #endif
-- 
2.55.0


