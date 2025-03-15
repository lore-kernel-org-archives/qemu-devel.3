Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43CAC35FF6
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 06:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttL0S-0005r4-0s; Sat, 15 Mar 2025 02:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1ttL05-0005ZN-AI
 for qemu-devel@nongnu.org; Sat, 15 Mar 2025 02:28:06 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1ttL03-0004d4-KN
 for qemu-devel@nongnu.org; Sat, 15 Mar 2025 02:28:00 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6911FFF9CD;
 Sat, 15 Mar 2025 09:17:07 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4066C1CAC36;
 Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 2D30D558B1; Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 01/51] target/arm: Report correct syndrome for
 UNDEFINED CNTPS_*_EL1 from EL2 and NS EL1
Date: Sat, 15 Mar 2025 09:17:07 +0300
Message-Id: <20250315061801.622606-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
References: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The access pseudocode for the CNTPS_TVAL_EL1, CNTPS_CTL_EL1 and
CNTPS_CVAL_EL1 secure timer registers says that they are UNDEFINED
from EL2 or NS EL1.  We incorrectly return CP_ACCESS_TRAP from the
access function in these cases, which means that we report the wrong
syndrome value to the target EL.

Use CP_ACCESS_TRAP_UNCATEGORIZED, which reports the correct syndrome
value for an UNDEFINED instruction.

Cc: qemu-stable@nongnu.org
Fixes: b4d3978c2fd ("target-arm: Add the AArch64 view of the Secure physical timer")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250130182309.717346-2-peter.maydell@linaro.org
(cherry picked from commit b819fd6994243aee6f9613edbbacedce4f511c32)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/helper.c b/target/arm/helper.c
index fcb13fe87e..8a0065ef60 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2652,7 +2652,7 @@ static CPAccessResult gt_stimer_access(CPUARMState *env,
     switch (arm_current_el(env)) {
     case 1:
         if (!arm_is_secure(env)) {
-            return CP_ACCESS_TRAP;
+            return CP_ACCESS_TRAP_UNCATEGORIZED;
         }
         if (!(env->cp15.scr_el3 & SCR_ST)) {
             return CP_ACCESS_TRAP_EL3;
@@ -2660,7 +2660,7 @@ static CPAccessResult gt_stimer_access(CPUARMState *env,
         return CP_ACCESS_OK;
     case 0:
     case 2:
-        return CP_ACCESS_TRAP;
+        return CP_ACCESS_TRAP_UNCATEGORIZED;
     case 3:
         return CP_ACCESS_OK;
     default:
-- 
2.39.5


