Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6332A606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=XsdJqlai
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp6S-0004Y2-86; Fri, 27 Nov 2026 01:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp6E-0003bx-Mf; Fri, 27 Nov 2026 01:06:22 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp6C-00009z-KL; Fri, 27 Nov 2026 01:06:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759047; bh=c1G/j69cft6IP7fIVp5DDXyk7lUotw8Jb2Q64vVfGeA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XsdJqlaij1beFxgVmkSr+0k8j7UqsWKxF75nQkhsQWg4Dz+GSLqDGZuILxoxuxKG2
 gik8CDmUH1xtN91rR3Peuqn0uJjpLylb50j8kwV2hcHNzrTqaJ6lAbZUmgltVX/cxj
 dXEzCNUkbelbvFeGf8VZi+r3hieUvojuZQtL7Nhf0VBcyOOH/d6FU/Amq8XUmmMcAT
 fze+uU5ZFwPL9Gk4U49dz/AwgMHNS36G8ccfhWyYasxhViCM85bd/nfTPMYn4XklXc
 J4ltVW/lrBIjGb2YFQh3DalRhMJR52cslt3SLz6KdwJJ+04w6K1ToGqulTJI2ef3KK
 K+P3MP/fXK0KA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0DC331EA356;
 Fri, 27 Nov 2026 08:57:27 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0B8A8469981;
 Fri, 27 Nov 2026 08:57:27 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id F0417CF2FA; Fri, 27 Nov 2026 08:57:26 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 100/152] target/arm: Get HVC UNDEF cases for Secure
 mode right
Date: Fri, 27 Nov 2026 08:53:58 +0300
Message-ID: <20261127055709.39630-37-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

In the pre_hvc helper, we have a "bool secure = false" and a FIXME
comment that we should use the actual Secure state. This is a
signpost to the fact that we're not getting the UNDEF cases right.
Specifically, we get most of them correct but are missing the ones
related to Secure state:

 * For A64: HVC must UNDEF at EL1 if EL2 is not enabled in the
   current Security state

 * For v8 A32/T32, HVC must UNDEF in Secure state, if EL2 is not
   enabled in the current Security state

 * For v7, HVC must UNDEF in Secure state

The v7 requirement is identical to the v8 A32/T32 one, since
there is no Secure EL2 in v7.

This fixes a bug where HVC should have UNDEFed but instead trapped
when in Secure state with Secure EL2 disabled.  The bug is unlikely
to affect real-world code, because only test code puts itself in a
situation where HVC should UNDEF and then executes HVC and requires
it to UNDEF.

This was noticed by Coverity, because the "if (secure && ...)"
check was dead code.

CID: 1689834
Cc: qemu-stable@nongnu.org
Fixes: 35979d71c401 ("target-arm: A64: Emulate the HVC insn")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20261030092815.573973-1-peter.maydell@linaro.org
(cherry picked from commit a1c20b516f0aa70914350fdddeb9b45edd5c7522)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 422cef2163c..ace95bf7aed 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -1293,8 +1293,6 @@ void HELPER(pre_hvc)(CPUARMState *env)
 {
     ARMCPU *cpu = env_archcpu(env);
     int cur_el = arm_current_el(env);
-    /* FIXME: Use actual secure state.  */
-    bool secure = false;
     bool undef;
 
     if (arm_is_psci_call(cpu, EXCP_HVC)) {
@@ -1304,6 +1302,8 @@ void HELPER(pre_hvc)(CPUARMState *env)
         return;
     }
 
+    /* Note that we have already UNDEFed HVC from EL0 at translation time */
+
     if (!arm_feature(env, ARM_FEATURE_EL2)) {
         /* If EL2 doesn't exist, HVC always UNDEFs */
         undef = true;
@@ -1314,12 +1314,19 @@ void HELPER(pre_hvc)(CPUARMState *env)
         undef = env->cp15.hcr_el2 & HCR_HCD;
     }
 
-    /* In ARMv7 and ARMv8/AArch32, HVC is undef in secure state.
-     * For ARMv8/AArch64, HVC is allowed in EL3.
-     * Note that we've already trapped HVC from EL0 at translation
-     * time.
+    /*
+     * In ARMv7 and ARMv8/AArch32, HVC is undef in Secure state if
+     * EL2 is not enabled in the current security state (which is
+     * always for Secure in v7, as Secure EL2 doesn't exist there).
+     *
+     * For ARMv8/AArch64, HVC is undef at EL1 if EL2 is not enabled in
+     * the current security state.
+     *
+     * Because we've already dealt with "EL2 not implemented" above,
+     * arm_is_el2_enabled() is effectively always true here in NonSecure,
+     * and we don't need to explicitly also check for secure/non-secure.
      */
-    if (secure && (!is_a64(env) || cur_el == 1)) {
+    if (!arm_is_el2_enabled(env) && (!is_a64(env) || cur_el == 1)) {
         undef = true;
     }
 
-- 
2.47.3


