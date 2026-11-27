Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACC5606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=fxkDutjQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWoxt-0002vf-P2; Fri, 27 Nov 2026 00:57:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWoxr-0002rj-PO; Fri, 27 Nov 2026 00:57:43 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWoxp-00044f-Sl; Fri, 27 Nov 2026 00:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758877; bh=+ki8ZpVvQwRAyuSiSHSZoEhRK0razRs1XNDolwQ3JxA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fxkDutjQ1YAFcBsAw/6WM/7fFv0D9Uonng18Fm4lY2+dtDyWWecWi2J0Orc8WgieN
 L0CkXFi2p+Up6MAAT5gEhUvKLF95Ho+C9pNg6G0++8e5o6Q8VaHka3AWy7O4gP56Rl
 foean6MlCwvfgqhofb1tWhhjlfatLwDmk5cMs4UKnfWWtAWeJRpRCwtIAHtUl0KIhl
 SCiFeJXl9AE/MLt0Ufr9QUiF7p6SpxHe9glDBT+5iNHSf2p3nWHlGexZso3HOGGKcG
 rjiX2fMQG0pJ3Kp3YN/BIprZfc4eybIKoobJVEzmVbUmopyny+QBxC4LiWnD+OeKNg
 DMIDyQzg7qfzA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9B8F51EA2E8;
 Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 991C2469923;
 Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8A9F4CF252; Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 094/140] target/arm: Get HVC UNDEF cases for
 Secure mode right
Date: Fri, 27 Nov 2026 08:53:20 +0300
Message-ID: <20261127055421.39015-35-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
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
index 325fce7790a..ad55617b2e8 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -1033,8 +1033,6 @@ void HELPER(pre_hvc)(CPUARMState *env)
 {
     ARMCPU *cpu = env_archcpu(env);
     int cur_el = arm_current_el(env);
-    /* FIXME: Use actual secure state.  */
-    bool secure = false;
     bool undef;
 
     if (arm_is_psci_call(cpu, EXCP_HVC)) {
@@ -1044,6 +1042,8 @@ void HELPER(pre_hvc)(CPUARMState *env)
         return;
     }
 
+    /* Note that we have already UNDEFed HVC from EL0 at translation time */
+
     if (!arm_feature(env, ARM_FEATURE_EL2)) {
         /* If EL2 doesn't exist, HVC always UNDEFs */
         undef = true;
@@ -1054,12 +1054,19 @@ void HELPER(pre_hvc)(CPUARMState *env)
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


