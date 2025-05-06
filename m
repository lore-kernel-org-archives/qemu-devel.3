Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10416C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 16:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCLNF-00068C-Mf; Tue, 06 May 2025 12:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1uCLNB-0005yj-D5; Tue, 06 May 2025 12:42:25 -0400
Received: from imap4.hz.codethink.co.uk ([188.40.203.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1uCLN8-0003OL-Qe; Tue, 06 May 2025 12:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m/F/gtwzFqgZDUlL/FPX7ZrNzTg0BWxSgcbBBSxcpoQ=; b=AXZ7GugVjTJH0ktSPoOJ6rHH6T
 wgAEHyZ1dWXgErsSJLxm9M+RRgO34AaOmCjjvEC57fTwEHsyRd8csI4gGqMl+pUjsaGWIpnEpLlru
 nf92FHLzwzM7bk7hpal+5p2I2ofiomleMUVC8Zomx5UuznHMmQd5Yl/FeUh6DKMD4yJvZ02n/quZO
 WoLSVWxMx+kEHdvdFX54G3gmySTV+a2u1Z1Dn3r5ng7cO8iPB7UmCo10VnLK4s8o8L3+mrO5aB1wx
 uq70mln1i5J1Reb68R6WhrDP8Iidvo7r86PVzVekiltymRqLHH9fkDXJRhIAHsWgt1dvIGZA38Jf3
 GT09PgVQ==;
Received: from [167.98.27.226] (helo=rainbowdash)
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uCLN0-0078s5-CR; Tue, 06 May 2025 17:42:14 +0100
Received: from ben by rainbowdash with local (Exim 4.98.2)
 (envelope-from <ben@rainbowdash>) id 1uCLN0-00000001ytj-0HMY;
 Tue, 06 May 2025 17:42:14 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, hiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, alistair.francis@wdc.com,
 palmer@dabbelt.com, Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH RFC] target/riscv: Remove tbflag for VILL
Date: Tue,  6 May 2025 17:42:07 +0100
Message-Id: <20250506164207.472410-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=188.40.203.114;
 envelope-from=srv_ts003@codethink.com; helo=imap4.hz.codethink.co.uk
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since the ctx->vill is only really applicable if the LMUL value is
set to an invalid state (4) we can free the tbflag up by just using
the LMUL field.

This was discussed in [1] as part of a way of extending the space in
tbflags to allow our big-endian work to have a bit in there.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

[1] https://mail.gnu.org/archive/html/qemu-devel/2025-04/msg03982.html
---
 target/riscv/cpu.h        | 2 +-
 target/riscv/cpu_helper.c | 7 +++++--
 target/riscv/translate.c  | 5 ++++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 167909c89b..2811d6d3f7 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -635,7 +635,7 @@ FIELD(TB_FLAGS, VS, 5, 2)
 FIELD(TB_FLAGS, LMUL, 7, 3)
 FIELD(TB_FLAGS, SEW, 10, 3)
 FIELD(TB_FLAGS, VL_EQ_VLMAX, 13, 1)
-FIELD(TB_FLAGS, VILL, 14, 1)
+/* VILL replaced by checked of LMUL==4 */
 FIELD(TB_FLAGS, VSTART_EQ_ZERO, 15, 1)
 /* The combination of MXL/SXL/UXL that applies to the current cpu mode. */
 FIELD(TB_FLAGS, XL, 16, 2)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 619c76cc00..290ed7c30b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -38,6 +38,9 @@
 #include "debug.h"
 #include "pmp.h"
 
+/* avoid pulling in the tcg/riscv/tcg-target.c.inc */
+#define VLMUL_RESERVED (4)
+
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
@@ -164,7 +167,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
         uint32_t maxsz = vlmax << vsew;
         bool vl_eq_vlmax = (env->vstart == 0) && (vlmax == env->vl) &&
                            (maxsz >= 8);
-        flags = FIELD_DP32(flags, TB_FLAGS, VILL, env->vill);
+        g_assert(env->vill && lmul != VLMUL_RESERVED);
         flags = FIELD_DP32(flags, TB_FLAGS, SEW, vsew);
         flags = FIELD_DP32(flags, TB_FLAGS, LMUL,
                            FIELD_EX64(env->vtype, VTYPE, VLMUL));
@@ -175,7 +178,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
                            FIELD_EX64(env->vtype, VTYPE, VMA));
         flags = FIELD_DP32(flags, TB_FLAGS, VSTART_EQ_ZERO, env->vstart == 0);
     } else {
-        flags = FIELD_DP32(flags, TB_FLAGS, VILL, 1);
+        flags = FIELD_DP32(flags, TB_FLAGS, LMUL, VLMUL_RESERVED);
     }
 
     if (cpu_get_fcfien(env)) {
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index cef61b5b29..28a6b345f2 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -37,6 +37,9 @@
 
 #include "tcg/tcg-cpu.h"
 
+/* avoid pulling in the tcg/riscv/tcg-target.c.inc */
+#define VLMUL_RESERVED (4)
+
 /* global register indices */
 static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc, cpu_vl, cpu_vstart;
 static TCGv_i64 cpu_fpr[32]; /* assume F and D extensions */
@@ -1274,9 +1277,9 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->misa_ext = env->misa_ext;
     ctx->frm = -1;  /* unknown rounding mode */
     ctx->cfg_ptr = &(cpu->cfg);
-    ctx->vill = FIELD_EX32(tb_flags, TB_FLAGS, VILL);
     ctx->sew = FIELD_EX32(tb_flags, TB_FLAGS, SEW);
     ctx->lmul = sextract32(FIELD_EX32(tb_flags, TB_FLAGS, LMUL), 0, 3);
+    ctx->vill = ctx->lmul == VLMUL_RESERVED;
     ctx->vta = FIELD_EX32(tb_flags, TB_FLAGS, VTA) && cpu->cfg.rvv_ta_all_1s;
     ctx->vma = FIELD_EX32(tb_flags, TB_FLAGS, VMA) && cpu->cfg.rvv_ma_all_1s;
     ctx->cfg_vta_all_1s = cpu->cfg.rvv_ta_all_1s;
-- 
2.37.2.352.g3c44437643


