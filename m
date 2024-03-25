Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E96BC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 22:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rosUR-0002cT-EK; Mon, 25 Mar 2024 18:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rosUO-0002bl-Le
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 18:08:20 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rosUM-0002Yg-0j
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 18:08:20 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6029A60F77;
 Mon, 25 Mar 2024 22:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10BBC433F1;
 Mon, 25 Mar 2024 22:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711404487;
 bh=UNyvGaildRDOuM3J5SYmI6rAqLtDnDEhYHPHsjoXqaQ=;
 h=Date:From:To:Subject:From;
 b=mqJo9bwb4b5VC4MLKLWocAK4dutqF2R/rFTHFTqOlFBDwgugnzsP1tp00emokqxWz
 LkKCdfQu8/z8yTRm9yHXfiPxrpJk+dEm8agVgGFokd7iapLUKZQPfDuxD3GF1awPqk
 JgOsrk3gPittV+ahk56O6PbOxvrwZJYNGXB4MmxfEirzSTWzbL3yeF32FDnh+VuQI2
 fOP2klfCq1vF4ekfk9rGP2wTf44yxThdIiYZBGCd5d2jchd6W2APlhLG7p+kf/+P2b
 ZcrA+YQ4DKu2LhRAhRbZni9Ge+NeCZgrmxCLYj+QSQru3omfYwrzcmcItDtcF4M2eL
 x//ymjPQsR7DQ==
Date: Mon, 25 Mar 2024 23:08:03 +0100
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH] target/hppa: Fix diag instructions to set/restore shadow
 registers
Message-ID: <ZgH1w6tF6wo4GJiO@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The 32-bit 7300LC CPU and the 64-bit PCX-W 8500 CPU use different
diag instructions to save or restore the CPU registers to/from
the shadow registers.

Implement those per-CPU architecture diag instructions to fix those
parts of the HP ODE testcases (L2DIAG and WDIAG, section 1) which test
the shadow registers.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 8fd7ba65d8..2c5d58bec9 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -86,6 +86,7 @@ DEF_HELPER_FLAGS_0(read_interval_timer, TCG_CALL_NO_RWG, tl)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(halt, noreturn, env)
 DEF_HELPER_1(reset, noreturn, env)
+DEF_HELPER_1(putshadowregs, void, env)
 DEF_HELPER_1(getshadowregs, void, env)
 DEF_HELPER_1(rfi, void, env)
 DEF_HELPER_1(rfi_r, void, env)
diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
index 4a31748342..3727f4ce8b 100644
--- a/target/hppa/sys_helper.c
+++ b/target/hppa/sys_helper.c
@@ -95,6 +95,17 @@ void HELPER(rfi)(CPUHPPAState *env)
     cpu_hppa_put_psw(env, env->cr[CR_IPSW]);
 }
 
+void HELPER(putshadowregs)(CPUHPPAState *env)
+{
+    env->shadow[0] = env->gr[1];
+    env->shadow[1] = env->gr[8];
+    env->shadow[2] = env->gr[9];
+    env->shadow[3] = env->gr[16];
+    env->shadow[4] = env->gr[17];
+    env->shadow[5] = env->gr[24];
+    env->shadow[6] = env->gr[25];
+}
+
 void HELPER(getshadowregs)(CPUHPPAState *env)
 {
     env->gr[1] = env->shadow[0];
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 99c5c4cbca..40f1cbe7ed 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4533,6 +4533,18 @@ static bool trans_diag(DisasContext *ctx, arg_diag *a)
         gen_helper_diag_console_output(tcg_env);
         return nullify_end(ctx);
     }
+    if ((ctx->is_pa20 && a->i == 0x701840) ||
+        (!ctx->is_pa20 && a->i == 0x1a40)) {
+        /* save shadow registers */
+        nullify_over(ctx);
+        gen_helper_putshadowregs(tcg_env);
+        return nullify_end(ctx);
+    }
+    if ((ctx->is_pa20 && a->i == 0x781840) ||
+        (!ctx->is_pa20 && a->i == 0x1a00)) {
+        /* restore shadow registers */
+        return trans_getshadowregs(ctx, NULL);
+    }
 #endif
     qemu_log_mask(LOG_UNIMP, "DIAG opcode 0x%04x ignored\n", a->i);
     return true;

