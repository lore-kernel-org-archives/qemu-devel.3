Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C93A60A3811
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LO4aeLS6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR94r-0004dn-Ku; Wed, 11 Nov 2026 09:13:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangyu.yu@linux.alibaba.com>)
 id 1xR94e-0004TY-N6; Wed, 11 Nov 2026 09:13:16 -0500
Received: from [115.124.30.99] (helo=out30-99.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangyu.yu@linux.alibaba.com>)
 id 1xR94T-000244-4q; Wed, 11 Nov 2026 09:13:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1794406351; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=w+J/kLTuWzTk9yoeqly5cLrq5Vu2awfOdNGtSBakk30=;
 b=LO4aeLS6QMv1jSejutHPfiMxL7ApkBibS1S8546KsHayIRsqDe0AE00E5qjVwfybI4A5P4K61x4MN7S5sCH934AVx/95rukGB1GKZVEbvXApQdCJnY2fUh2FSAj/YYiZdbdHYFeZ+cIIZkjSRIEW76wTHEwFX+ZM9om5V0rqghs=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam011083073210;
 MF=fangyu.yu@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0XEZ7P0S_1794406348; 
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com
 fp:SMTPD_---0XEZ7P0S_1794406348 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 11 Nov 2026 22:12:29 +0800
From: fangyu.yu@linux.alibaba.com
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, philmd@oss.qualcomm.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, guoren@kernel.org,
 Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH v2] target/riscv: fix exception PC for WFI
Date: Wed, 11 Nov 2026 22:12:25 +0800
Message-Id: <20261111141225.15652-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.99 (deferred)
Received-SPF: pass client-ip=115.124.30.99;
 envelope-from=fangyu.yu@linux.alibaba.com;
 helo=out30-99.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

trans_wfi() advances env->pc before calling helper_wfi(), which may
raise illegal or virtual-instruction exceptions through GETPC().
With CF_PCREL, restoring the instruction PC uses env->pc's page base.
If the next instruction is in a different page, the exception PC is
restored one page too high. This affects both a WFI ending exactly at
a page boundary and one crossing it.

Keep env->pc pointing at WFI while helper_wfi() can raise an exception,
and pass the instruction length to the helper. Advance env->pc only on
the normal single-step or halt paths.

Fixes: 356c13f94dbf ("target/riscv: Enable PC-relative translation")
Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: GUO Ren (XuanTie) <guoren@kernel.org>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
Changes in v2:
  - Rename helper_wfi()'s insn_len parameter to advance_pc, to clarify
    that it is the amount env->pc advances on the normal path.
  - Add a comment before gen_update_pc() explaining that env->pc is
    deliberately left on the WFI until the exception checks pass, so
    nobody advances the PC in the translator again by mistake.

Link to v1:
  https://lore.kernel.org/qemu-devel/20261109135633.64867-1-fangyu.yu@linux.alibaba.com/
---
 target/riscv/helper.h                              |  2 +-
 target/riscv/tcg/insn_trans/trans_privileged.c.inc | 10 ++++++++--
 target/riscv/tcg/op_helper.c                       |  6 +++++-
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 1cffcad580..b36e3532aa 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -135,7 +135,7 @@ DEF_HELPER_1(mret, tl, env)
 DEF_HELPER_1(dret, tl, env)
 DEF_HELPER_1(mnret, tl, env)
 DEF_HELPER_1(ctr_clear, void, env)
-DEF_HELPER_1(wfi, void, env)
+DEF_HELPER_2(wfi, void, env, i32)
 DEF_HELPER_1(wrs_nto, void, env)
 DEF_HELPER_1(tlb_flush, void, env)
 DEF_HELPER_1(tlb_flush_all, void, env)
diff --git a/target/riscv/tcg/insn_trans/trans_privileged.c.inc b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
index e22df6fbe7..bd1d8f276d 100644
--- a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
@@ -167,8 +167,14 @@ static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
 {
 #ifndef CONFIG_USER_ONLY
     decode_save_opc(ctx, 0);
-    gen_update_pc(ctx, ctx->cur_insn_len);
-    gen_helper_wfi(tcg_env);
+    /*
+     * Deliberately leave env->pc on the WFI: helper_wfi() may raise an
+     * exception, and with CF_PCREL the exception PC is restored from
+     * env->pc's page base. The helper advances env->pc itself only after
+     * all exception checks pass.
+     */
+    gen_update_pc(ctx, 0);
+    gen_helper_wfi(tcg_env, tcg_constant_i32(ctx->cur_insn_len));
     ctx->base.is_jmp = DISAS_NORETURN;
     return true;
 #else
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index f9c79fe6b9..aebf383ed5 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -625,7 +625,7 @@ void HELPER(ctr_clear)(CPURISCVState *env)
     riscv_ctr_clear(env);
 }
 
-void HELPER(wfi)(CPURISCVState *env)
+void HELPER(wfi)(CPURISCVState *env, uint32_t advance_pc)
 {
     CPUState *cs = env_cpu(env);
     bool rvs = riscv_has_ext(env, RVS);
@@ -639,6 +639,10 @@ void HELPER(wfi)(CPURISCVState *env)
                (prv_u || (prv_s && get_field(env->hstatus, HSTATUS_VTW)))) {
         riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
     } else {
+        env->pc += advance_pc;
+        if (env->xl == MXL_RV32) {
+            env->pc = (int32_t)env->pc;
+        }
         if (riscv_cpu_cfg(env)->ext_sdext && !env->debug_mode &&
             (env->dcsr & DCSR_STEP)) {
             return;
-- 
2.50.1


