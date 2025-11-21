Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8542CFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdgr-0002zj-2m; Fri, 21 Nov 2025 21:49:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdgn-0002pj-IY; Fri, 21 Nov 2025 21:49:29 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdgQ-0005dv-Dh; Fri, 21 Nov 2025 21:49:25 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0873B16C6DE;
 Fri, 21 Nov 2025 16:51:54 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 60849321955;
 Fri, 21 Nov 2025 16:52:02 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 06/76] target/arm: Fix reads of CNTFRQ_EL0 in
 linux-user mode
Date: Fri, 21 Nov 2025 16:50:44 +0300
Message-ID: <20251121135201.1114964-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In commit bd8e9ddf6f6 ("target/arm: Refactor default generic timer
frequency handling") we changed how we initialized the generic timer
frequency as reported in the CNTFRQ_EL0 register.  As part of that,
we chanegd the linux-user version of the CNTFRQ_EL0 sysreg from
having a constant value set at compile time through the .resetvalue
field to having a reset value which we compute in a .resetfn.

This accidentally broke the reading of CNTFRQ_EL0 in linux-user mode,
because the cpreg is marked as ARM_CP_CONST, which means we translate
it as a read of the compile-time constant value in the .resetvalue
field.  This is now zero, so userspace sees a 0 frequency value.

Fix the bug by dropping the ARM_CP_CONST marking.  This will cause us
to translate the read as a load of the value from the CPU state
struct cp15.c14_cntfrq field, which is where the real frequency value
now lives.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3159
Fixes: bd8e9ddf6f6 ("target/arm: Refactor default generic timer frequency handling")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251013161040.216819-1-peter.maydell@linaro.org
(cherry picked from commit 3f462d79a080060e54e39d31ce10fdf1a20317ef)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e2ef4ea2cc..9e5eb50ff7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2252,7 +2252,7 @@ static uint64_t gt_virt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
 static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     { .name = "CNTFRQ_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 0,
-      .type = ARM_CP_CONST, .access = PL0_R /* no PL1_RW in linux-user */,
+      .access = PL0_R /* no PL1_RW in linux-user */,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_cntfrq),
       .resetfn = arm_gt_cntfrq_reset,
     },
-- 
2.47.3


