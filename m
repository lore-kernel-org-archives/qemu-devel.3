Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69018CA6017
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF0wp-0005NC-T0; Thu, 08 Oct 2026 23:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xF0w0-0004iR-VR
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:06:13 -0400
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xF0vz-0005oj-7d
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:06:12 -0400
Received: from yuno-loong (unknown
 [IPv6:2409:8900:2684:b82:443b:7baf:6228:2a79])
 by krgm.moe (Postfix) with ESMTPSA id C60FCE004;
 Fri, 09 Oct 2026 08:35:58 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v5 21/23] target/loongarch: translate LVZ guest traps and HVC
Date: Fri,  9 Oct 2026 11:05:17 +0800
Message-ID: <6c1f6c89f9392be3a45963cf0aca0bc7aadceb9f.1791514848.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791514848.git.prcups@krgm.moe>
References: <cover.1791514848.git.prcups@krgm.moe>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.47.186.116; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Raise GSPR when a guest accesses IOCSR, debug, idle and cpucfg resources,
and decode HVC for guest PLV0.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/disas.c                      |  1 +
 target/loongarch/insns.decode                 |  1 +
 target/loongarch/tcg/helper.h                 |  2 +-
 .../tcg/insn_trans/trans_extra.c.inc          |  5 +++
 .../tcg/insn_trans/trans_privileged.c.inc     | 32 +++++++++++++++++++
 target/loongarch/tcg/op_helper.c              |  3 ++
 6 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 6425dea17c..7d47fc0151 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -706,6 +706,7 @@ INSN(gtlbsrch,     empty)
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
diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
index 84eaee208c..be1573af9d 100644
--- a/target/loongarch/tcg/helper.h
+++ b/target/loongarch/tcg/helper.h
@@ -10,7 +10,7 @@ DEF_HELPER_FLAGS_3(asrtgt_d, TCG_CALL_NO_WG, void, env, tl, tl)
 
 DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl)
 DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl)
-DEF_HELPER_FLAGS_2(cpucfg, TCG_CALL_NO_RWG_SE, tl, env, tl)
+DEF_HELPER_FLAGS_2(cpucfg, TCG_CALL_NO_WG_SE, tl, env, tl)
 
 /* Floating-point helper */
 DEF_HELPER_FLAGS_3(fadd_s, TCG_CALL_NO_WG, i64, env, i64, i64)
diff --git a/target/loongarch/tcg/insn_trans/trans_extra.c.inc b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
index 655dce329e..275755a1f0 100644
--- a/target/loongarch/tcg/insn_trans/trans_extra.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
@@ -82,6 +82,11 @@ static bool trans_rdtime_d(DisasContext *ctx, arg_rdtime_d *a)
 
 static bool trans_cpucfg(DisasContext *ctx, arg_cpucfg *a)
 {
+    if (is_guest_mmu_idx(ctx->mem_idx)) {
+        generate_exception(ctx, EXCCODE_GSPR);
+        return true;
+    }
+
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
 
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index ae481aa83f..bd50e91422 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -48,6 +48,7 @@ GEN_FALSE_TRANS(gtlbsrch)
 GEN_FALSE_TRANS(gtlbrd)
 GEN_FALSE_TRANS(gtlbwr)
 GEN_FALSE_TRANS(gtlbfill)
+GEN_FALSE_TRANS(hvcl)
 
 #else
 
@@ -301,6 +302,10 @@ static bool gen_iocsrrd(DisasContext *ctx, arg_rr *a,
     if (check_plv(ctx)) {
         return false;
     }
+    if (is_guest_mmu_idx(ctx->mem_idx)) {
+        generate_exception(ctx, EXCCODE_GSPR);
+        return true;
+    }
     func(dest, tcg_env, src1);
     return true;
 }
@@ -314,6 +319,10 @@ static bool gen_iocsrwr(DisasContext *ctx, arg_rr *a,
     if (check_plv(ctx)) {
         return false;
     }
+    if (is_guest_mmu_idx(ctx->mem_idx)) {
+        generate_exception(ctx, EXCCODE_GSPR);
+        return true;
+    }
     func(tcg_env, addr, val);
     return true;
 }
@@ -584,6 +593,10 @@ static bool trans_dbcl(DisasContext *ctx, arg_dbcl *a)
     if (check_plv(ctx)) {
         return false;
     }
+    if (is_guest_mmu_idx(ctx->mem_idx)) {
+        generate_exception(ctx, EXCCODE_GSPR);
+        return true;
+    }
     generate_exception(ctx, EXCCODE_DBP);
     return true;
 }
@@ -594,9 +607,28 @@ static bool trans_idle(DisasContext *ctx, arg_idle *a)
         return false;
     }
 
+    if (is_guest_mmu_idx(ctx->mem_idx)) {
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
+    if (!avail_LVZ(ctx) || !is_guest_mmu_idx(ctx->mem_idx)) {
+        return false;
+    }
+
+    if (check_plv(ctx)) {
+        return false;
+    }
+
+    generate_exception(ctx, EXCCODE_HVC);
+    return true;
+}
 #endif
diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
index 3035dfa08d..e2fe4b212f 100644
--- a/target/loongarch/tcg/op_helper.c
+++ b/target/loongarch/tcg/op_helper.c
@@ -20,6 +20,9 @@
 /* Exceptions helpers */
 void helper_raise_exception(CPULoongArchState *env, uint32_t exception)
 {
+    if (exception == EXCCODE_GSPR || exception == EXCCODE_HVC) {
+        trigger_vm_exit(env);
+    }
     do_raise_exception(env, exception, GETPC());
 }
 
-- 
2.55.0


