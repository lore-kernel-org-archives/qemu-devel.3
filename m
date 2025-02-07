Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8ABC02196
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 07:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgIiY-00049f-Eb; Fri, 07 Feb 2025 02:24:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tgIiW-000498-E1; Fri, 07 Feb 2025 02:24:00 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tgIiU-0007QK-Ir; Fri, 07 Feb 2025 02:24:00 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 18121E71F9;
 Fri, 07 Feb 2025 10:23:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 579A01B06D1;
 Fri,  7 Feb 2025 10:23:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 5262B52D67; Fri, 07 Feb 2025 10:23:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.16 32/33] target/arm: arm_reset_sve_state() should set
 FPSR, not FPCR
Date: Fri,  7 Feb 2025 10:23:36 +0300
Message-Id: <20250207072343.2109513-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.16-20250207102241@cover.tls.msk.ru>
References: <qemu-stable-7.2.16-20250207102241@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The pseudocode ResetSVEState() does:
    FPSR = ZeroExtend(0x0800009f<31:0>, 64);
but QEMU's arm_reset_sve_state() called vfp_set_fpcr() by accident.

Before the advent of FEAT_AFP, this was only setting a collection of
RES0 bits, which vfp_set_fpsr() would then ignore, so the only effect
was that we didn't actually set the FPSR the way we are supposed to
do.  Once FEAT_AFP is implemented, setting the bottom bits of FPSR
will change the floating point behaviour.

Call vfp_set_fpsr(), as we ought to.

(Note for stable backports: commit 7f2a01e7368f9 moved this function
from sme_helper.c to helper.c, but it had the same bug before the
move too.)

Cc: qemu-stable@nongnu.org
Fixes: f84734b87461 ("target/arm: Implement SMSTART, SMSTOP")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250124162836.2332150-4-peter.maydell@linaro.org
(cherry picked from commit 1edc3d43f20df0d04f8d00b906ba19fed37512a5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(it is in sme_helper.c in 7.2, not in helper.c)

diff --git a/target/arm/sme_helper.c b/target/arm/sme_helper.c
index 98a4840970..fd5625c87e 100644
--- a/target/arm/sme_helper.c
+++ b/target/arm/sme_helper.c
@@ -35,7 +35,7 @@ void arm_reset_sve_state(CPUARMState *env)
     memset(env->vfp.zregs, 0, sizeof(env->vfp.zregs));
     /* Recall that FFR is stored as pregs[16]. */
     memset(env->vfp.pregs, 0, sizeof(env->vfp.pregs));
-    vfp_set_fpcr(env, 0x0800009f);
+    vfp_set_fpsr(env, 0x0800009f);
 }
 
 void helper_set_pstate_sm(CPUARMState *env, uint32_t i)
-- 
2.39.5


