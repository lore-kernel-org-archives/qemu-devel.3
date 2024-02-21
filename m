Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0E4C54788
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcuST-0005PD-Dd; Wed, 21 Feb 2024 16:48:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rcuSQ-0005Ad-C1; Wed, 21 Feb 2024 16:48:50 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rcuSL-0007XU-Cu; Wed, 21 Feb 2024 16:48:50 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 42EBE4F86F;
 Thu, 22 Feb 2024 00:47:47 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E0545869F0;
 Thu, 22 Feb 2024 00:47:24 +0300 (MSK)
Received: (nullmailer pid 2339880 invoked by uid 1000);
 Wed, 21 Feb 2024 21:47:23 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.10 19/33] linux-user/aarch64: Choose SYNC as the
 preferred MTE mode
Date: Thu, 22 Feb 2024 00:47:02 +0300
Message-Id: <20240221214723.2339742-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.10-20240221121815@cover.tls.msk.ru>
References: <qemu-stable-7.2.10-20240221121815@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

From: Richard Henderson <richard.henderson@linaro.org>

The API does not generate an error for setting ASYNC | SYNC; that merely
constrains the selection vs the per-cpu default.  For qemu linux-user,
choose SYNC as the default.

Cc: qemu-stable@nongnu.org
Reported-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-id: 20240207025210.8837-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 681dfc0d552963d4d598350d26097a692900b408)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/aarch64/target_prctl.h b/linux-user/aarch64/target_prctl.h
index 907c314146..d9f6648e27 100644
--- a/linux-user/aarch64/target_prctl.h
+++ b/linux-user/aarch64/target_prctl.h
@@ -171,21 +171,26 @@ static abi_long do_prctl_set_tagged_addr_ctrl(CPUArchState *env, abi_long arg2)
     env->tagged_addr_enable = arg2 & PR_TAGGED_ADDR_ENABLE;
 
     if (cpu_isar_feature(aa64_mte, cpu)) {
-        switch (arg2 & PR_MTE_TCF_MASK) {
-        case PR_MTE_TCF_NONE:
-        case PR_MTE_TCF_SYNC:
-        case PR_MTE_TCF_ASYNC:
-            break;
-        default:
-            return -EINVAL;
-        }
-
         /*
          * Write PR_MTE_TCF to SCTLR_EL1[TCF0].
-         * Note that the syscall values are consistent with hw.
+         *
+         * The kernel has a per-cpu configuration for the sysadmin,
+         * /sys/devices/system/cpu/cpu<N>/mte_tcf_preferred,
+         * which qemu does not implement.
+         *
+         * Because there is no performance difference between the modes, and
+         * because SYNC is most useful for debugging MTE errors, choose SYNC
+         * as the preferred mode.  With this preference, and the way the API
+         * uses only two bits, there is no way for the program to select
+         * ASYMM mode.
          */
-        env->cp15.sctlr_el[1] =
-            deposit64(env->cp15.sctlr_el[1], 38, 2, arg2 >> PR_MTE_TCF_SHIFT);
+        unsigned tcf = 0;
+        if (arg2 & PR_MTE_TCF_SYNC) {
+            tcf = 1;
+        } else if (arg2 & PR_MTE_TCF_ASYNC) {
+            tcf = 2;
+        }
+        env->cp15.sctlr_el[1] = deposit64(env->cp15.sctlr_el[1], 38, 2, tcf);
 
         /*
          * Write PR_MTE_TAG to GCR_EL1[Exclude].
-- 
2.39.2


