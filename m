Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BEDEC28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 07:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttMBK-0002iw-EJ; Sat, 15 Mar 2025 03:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttMBI-0002fi-8P; Sat, 15 Mar 2025 03:43:40 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttMBG-0004wX-IM; Sat, 15 Mar 2025 03:43:39 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B6185FFB02;
 Sat, 15 Mar 2025 10:41:55 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A4CAE1CACCC;
 Sat, 15 Mar 2025 10:42:49 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 79B32559F0; Sat, 15 Mar 2025 10:42:49 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.10 14/42] hw/intc/arm_gicv3_cpuif: Don't downgrade
 monitor traps for AArch32 EL3
Date: Sat, 15 Mar 2025 10:42:16 +0300
Message-Id: <20250315074249.634718-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-8.2.10-20250315104136@cover.tls.msk.ru>
References: <qemu-stable-8.2.10-20250315104136@cover.tls.msk.ru>
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

In the gicv3_{irq,fiq,irqfiq}_access() functions, there is a check
which downgrades a CP_ACCESS_TRAP_EL3 to CP_ACCESS_TRAP if EL3 is not
AArch64.  This has been there since the GIC was first implemented,
but it isn't right: if we are trapping because of SCR.IRQ or SCR.FIQ
then we definitely want to be going to EL3 (doing
AArch32.TakeMonitorTrapException() in pseudocode terms).  We might
want to not take a trap at all, but we don't ever want to go to the
default target EL, because that would mean, for instance, taking a
trap to Hyp mode if the trapped access was made from Hyp mode.

(This might have been an attempt to work around our failure to
properly implement Monitor Traps.)

Remove the bogus check.

Cc: qemu-stable@nongnu.org
Fixes: 359fbe65e01e ("hw/intc/arm_gicv3: Implement GICv3 CPU interface registers")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250130182309.717346-7-peter.maydell@linaro.org
(cherry picked from commit d04c6c3c000ab3e588a2b91641310aeea89408f7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 8eacf4101c..f2440597ea 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -2099,9 +2099,6 @@ static CPAccessResult gicv3_irqfiq_access(CPUARMState *env,
         }
     }
 
-    if (r == CP_ACCESS_TRAP_EL3 && !arm_el_is_aa64(env, 3)) {
-        r = CP_ACCESS_TRAP;
-    }
     return r;
 }
 
@@ -2164,9 +2161,6 @@ static CPAccessResult gicv3_fiq_access(CPUARMState *env,
         }
     }
 
-    if (r == CP_ACCESS_TRAP_EL3 && !arm_el_is_aa64(env, 3)) {
-        r = CP_ACCESS_TRAP;
-    }
     return r;
 }
 
@@ -2203,9 +2197,6 @@ static CPAccessResult gicv3_irq_access(CPUARMState *env,
         }
     }
 
-    if (r == CP_ACCESS_TRAP_EL3 && !arm_el_is_aa64(env, 3)) {
-        r = CP_ACCESS_TRAP;
-    }
     return r;
 }
 
-- 
2.39.5


