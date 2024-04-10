Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B340CD1297
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSQu-0005bt-Tm; Wed, 10 Apr 2024 03:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSQU-0005J0-Ph; Wed, 10 Apr 2024 03:31:23 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSQR-0005QD-RE; Wed, 10 Apr 2024 03:31:21 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 89AA45D6C3;
 Wed, 10 Apr 2024 10:25:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 2E992B0303;
 Wed, 10 Apr 2024 10:23:10 +0300 (MSK)
Received: (nullmailer pid 4191901 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 83/87] target/arm: Use correct SecuritySpace for
 AArch64 AT ops at EL3
Date: Wed, 10 Apr 2024 10:22:56 +0300
Message-Id: <20240410072303.4191455-83-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

When we do an AT address translation operation, the page table walk
is supposed to be performed in the context of the EL we're doing the
walk for, so for instance an AT S1E2R walk is done for EL2.  In the
pseudocode an EL is passed to AArch64.AT(), which calls
SecurityStateAtEL() to find the security state that we should be
doing the walk with.

In ats_write64() we get this wrong, instead using the current
security space always.  This is fine for AT operations performed from
EL1 and EL2, because there the current security state and the
security state for the lower EL are the same.  But for AT operations
performed from EL3, the current security state is always either
Secure or Root, whereas we want to use the security state defined by
SCR_EL3.{NS,NSE} for the walk. This affects not just guests using
FEAT_RME but also ones where EL3 is Secure state and the EL3 code
is trying to do an AT for a NonSecure EL2 or EL1.

Use arm_security_space_below_el3() to get the SecuritySpace to
pass to do_ats_write() for all AT operations except the
AT S1E3* operations.

Cc: qemu-stable@nongnu.org
Fixes: e1ee56ec2383 ("target/arm: Pass security space rather than flag for AT instructions")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2250
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240405180232.3570066-1-peter.maydell@linaro.org
(cherry picked from commit 19b254e86a900dc5ee332e3ac0baf9c521301abf)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/helper.c b/target/arm/helper.c
index df1646de3a..ca2c6e9732 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3703,6 +3703,8 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
     ARMMMUIdx mmu_idx;
     uint64_t hcr_el2 = arm_hcr_el2_eff(env);
     bool regime_e20 = (hcr_el2 & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE);
+    bool for_el3 = false;
+    ARMSecuritySpace ss;
 
     switch (ri->opc2 & 6) {
     case 0:
@@ -3720,6 +3722,7 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
             break;
         case 6: /* AT S1E3R, AT S1E3W */
             mmu_idx = ARMMMUIdx_E3;
+            for_el3 = true;
             break;
         default:
             g_assert_not_reached();
@@ -3738,8 +3741,8 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
         g_assert_not_reached();
     }
 
-    env->cp15.par_el[1] = do_ats_write(env, value, access_type,
-                                       mmu_idx, arm_security_space(env));
+    ss = for_el3 ? arm_security_space(env) : arm_security_space_below_el3(env);
+    env->cp15.par_el[1] = do_ats_write(env, value, access_type, mmu_idx, ss);
 #else
     /* Handled by hardware accelerator. */
     g_assert_not_reached();
-- 
2.39.2


