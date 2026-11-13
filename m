Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DF8606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmxA-00051L-AJ; Fri, 13 Nov 2026 03:48:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xRmvn-000320-Nl
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:50 -0500
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xRmvl-0007W4-PZ
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:47 -0500
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id 29855780D;
 Fri, 13 Nov 2026 14:16:43 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v6 24/26] target/loongarch: translate LVZ guest traps and HVC
Date: Fri, 13 Nov 2026 16:45:39 +0800
Message-ID: <64b9aa26f961f8e5229da0f511038cd27454050b.1794558695.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794558695.git.prcups@krgm.moe>
References: <cover.1794558695.git.prcups@krgm.moe>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 3010e16608..0e0a3a242a 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -700,6 +700,7 @@ INSN(tlbfill,      empty)
 INSN(tlbclr,       empty)
 INSN(tlbflush,     empty)
 INSN(invtlb,       i_rr)
+INSN(hvcl,         i)
 INSN(cacop,        cop_r_i)
 INSN(lddir,        rr_i)
 INSN(ldpte,        j_i)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 4612af9433..0881f3d018 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -514,6 +514,7 @@ tlbfill          0000 01100100 10000 01101 00000 00000    @empty
 tlbclr           0000 01100100 10000 01000 00000 00000    @empty
 tlbflush         0000 01100100 10000 01001 00000 00000    @empty
 invtlb           0000 01100100 10011 ..... ..... .....    @i_rr
+hvcl             0000 0000 0010 1011 1 ...............    @i15
 cacop            0000 011000 ............ ..... .....     @cop_r_i
 lddir            0000 01100100 00 ........ ..... .....    @rr_ui8
 ldpte            0000 01100100 01 ........ ..... 00000    @j_i
diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
index 63d37a00b0..b47485105a 100644
--- a/target/loongarch/tcg/helper.h
+++ b/target/loongarch/tcg/helper.h
@@ -12,7 +12,7 @@ DEF_HELPER_FLAGS_3(asrtgt_du, TCG_CALL_NO_WG, void, env, tl, tl)
 
 DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl)
 DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl)
-DEF_HELPER_FLAGS_2(cpucfg, TCG_CALL_NO_RWG_SE, tl, env, tl)
+DEF_HELPER_FLAGS_2(cpucfg, TCG_CALL_NO_WG_SE, tl, env, tl)
 
 /* Floating-point helper */
 DEF_HELPER_FLAGS_3(fadd_s, TCG_CALL_NO_WG, i64, env, i64, i64)
diff --git a/target/loongarch/tcg/insn_trans/trans_extra.c.inc b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
index 655dce329e..aea033e054 100644
--- a/target/loongarch/tcg/insn_trans/trans_extra.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
@@ -82,6 +82,11 @@ static bool trans_rdtime_d(DisasContext *ctx, arg_rdtime_d *a)
 
 static bool trans_cpucfg(DisasContext *ctx, arg_cpucfg *a)
 {
+    if (mmu_idx_vm_level(ctx->mem_idx)) {
+        generate_exception(ctx, EXCCODE_GSPR);
+        return true;
+    }
+
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
 
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index 384580c988..3b8f9b9fb8 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -42,6 +42,7 @@ GEN_FALSE_TRANS(idle)
 GEN_FALSE_TRANS(gcsrrd)
 GEN_FALSE_TRANS(gcsrwr)
 GEN_FALSE_TRANS(gcsrxchg)
+GEN_FALSE_TRANS(hvcl)
 
 #else
 
@@ -295,6 +296,10 @@ static bool gen_iocsrrd(DisasContext *ctx, arg_rr *a,
     if (check_plv(ctx)) {
         return false;
     }
+    if (mmu_idx_vm_level(ctx->mem_idx)) {
+        generate_exception(ctx, EXCCODE_GSPR);
+        return true;
+    }
     func(dest, tcg_env, src1);
     return true;
 }
@@ -308,6 +313,10 @@ static bool gen_iocsrwr(DisasContext *ctx, arg_rr *a,
     if (check_plv(ctx)) {
         return false;
     }
+    if (mmu_idx_vm_level(ctx->mem_idx)) {
+        generate_exception(ctx, EXCCODE_GSPR);
+        return true;
+    }
     func(tcg_env, addr, val);
     return true;
 }
@@ -518,6 +527,10 @@ static bool trans_dbcl(DisasContext *ctx, arg_dbcl *a)
     if (check_plv(ctx)) {
         return false;
     }
+    if (mmu_idx_vm_level(ctx->mem_idx)) {
+        generate_exception(ctx, EXCCODE_GSPR);
+        return true;
+    }
     generate_exception(ctx, EXCCODE_DBP);
     return true;
 }
@@ -528,9 +541,28 @@ static bool trans_idle(DisasContext *ctx, arg_idle *a)
         return false;
     }
 
+    if (mmu_idx_vm_level(ctx->mem_idx)) {
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
+    if (!avail_LVZ(ctx) || !mmu_idx_vm_level(ctx->mem_idx)) {
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
index 7b77ac49a6..3b32e04268 100644
--- a/target/loongarch/tcg/op_helper.c
+++ b/target/loongarch/tcg/op_helper.c
@@ -20,6 +20,9 @@
 /* Exceptions helpers */
 void HELPER(raise_exception)(CPULoongArchState *env, uint32_t exception)
 {
+    if (exception == EXCCODE_GSPR || exception == EXCCODE_HVC) {
+        trigger_vm_exit(env);
+    }
     do_raise_exception(env, exception, GETPC());
 }
 
-- 
2.56.0


