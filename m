Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3D9CFC504
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcuR-0000Hs-8z; Fri, 21 Nov 2025 20:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMbvP-0006rA-A5; Fri, 21 Nov 2025 19:56:27 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMbtM-000189-Nx; Fri, 21 Nov 2025 19:56:23 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6E1FE16CA4C;
 Fri, 21 Nov 2025 21:44:22 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2AD52321C88;
 Fri, 21 Nov 2025 21:44:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 17/81] target/hppa: Set FPCR exception flag bits for
 non-trapped exceptions
Date: Fri, 21 Nov 2025 21:43:16 +0300
Message-ID: <20251121184424.1137669-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

In commit ebd394948de4e8 ("target/hppa: Fix FPE exceptions") when
we added the code for setting up the registers correctly on trapping
FP exceptions, we accidentally broke the handling of the flag bits
for non-trapping exceptions.

In update_fr0_op() we incorrectly zero out the flag bits and the C
bit, so any fp operation would clear previously set flag bits. We
also stopped setting the flag bits when the fp operation raises
an exception and the trap is not enabled.

Adjust the code so that we set the Flag bits for every exception that
happened and where the trap is not enabled.  (This is the correct
behaviour for the case where an instruction triggers two exceptions,
one of which traps and one of which does not; that can only happen
for inexact + underflow or inexact + overflow.)

Cc: qemu-stable@nongnu.org
Fixes: ebd394948de4e8 ("target/hppa: Fix FPE exceptions")
Fixes: 6966e0ba1d4a9e ("target/hppa: Fix FPE exceptions") in 10.0.1
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3158
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de>
Message-ID: <20251017085350.895681-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 1a8ffd6172f3d9ad8232189adb879a16ec416f89)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
index 294ce0a970..9ffcda66b8 100644
--- a/target/hppa/fpu_helper.c
+++ b/target/hppa/fpu_helper.c
@@ -95,7 +95,8 @@ static void update_fr0_op(CPUHPPAState *env, uintptr_t ra)
 {
     uint32_t soft_exp = get_float_exception_flags(&env->fp_status);
     uint32_t hard_exp = 0;
-    uint32_t shadow = env->fr0_shadow & 0x3ffffff;
+    uint32_t shadow = env->fr0_shadow;
+    uint32_t to_flag = 0;
     uint32_t fr1 = 0;
 
     if (likely(soft_exp == 0)) {
@@ -123,6 +124,10 @@ static void update_fr0_op(CPUHPPAState *env, uintptr_t ra)
             fr1 |= hard_exp << (R_FPSR_FLAGS_SHIFT - R_FPSR_ENABLES_SHIFT);
         }
     }
+    /* Set the Flag bits for every exception that was not enabled */
+    to_flag = hard_exp & ~shadow;
+    shadow |= to_flag << (R_FPSR_FLAGS_SHIFT - R_FPSR_ENABLES_SHIFT);
+
     env->fr0_shadow = shadow;
     env->fr[0] = (uint64_t)shadow << 32 | fr1;
 
-- 
2.47.3


