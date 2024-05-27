Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F7CC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 08:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBVd8-0001Il-GP; Mon, 27 May 2024 04:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBVcH-00010e-95; Mon, 27 May 2024 04:22:02 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBVcF-0000ip-JT; Mon, 27 May 2024 04:22:00 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3565C6A566;
 Mon, 27 May 2024 11:22:13 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 5F6AAD8503;
 Mon, 27 May 2024 11:21:39 +0300 (MSK)
Received: (nullmailer pid 66378 invoked by uid 1000);
 Mon, 27 May 2024 08:21:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.1 09/44] target/arm: Restrict translation disabled
 alignment check to VMSA
Date: Mon, 27 May 2024 11:21:00 +0300
Message-Id: <20240527082138.66217-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.1-20240527112053@cover.tls.msk.ru>
References: <qemu-stable-9.0.1-20240527112053@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

For cpus using PMSA, when the MPU is disabled, the default memory
type is Normal, Non-cachable. This means that it should not
have alignment restrictions enforced.

Cc: qemu-stable@nongnu.org
Fixes: 59754f85ed3 ("target/arm: Do memory type alignment check when translation disabled")
Reported-by: Clément Chigot <chigot@adacore.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Clément Chigot <chigot@adacore.com>
Message-id: 20240422170722.117409-1-richard.henderson@linaro.org
[PMM: trivial comment, commit message tweaks]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 7b19a3554d2df22d29c75319a1dac17615d1b20e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 5da1b0fc1d..f03977b4b0 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -38,8 +38,16 @@ static bool aprofile_require_alignment(CPUARMState *env, int el, uint64_t sctlr)
     }
 
     /*
-     * If translation is disabled, then the default memory type is
-     * Device(-nGnRnE) instead of Normal, which requires that alignment
+     * With PMSA, when the MPU is disabled, all memory types in the
+     * default map are Normal, so don't need aligment enforcing.
+     */
+    if (arm_feature(env, ARM_FEATURE_PMSA)) {
+        return false;
+    }
+
+    /*
+     * With VMSA, if translation is disabled, then the default memory type
+     * is Device(-nGnRnE) instead of Normal, which requires that alignment
      * be enforced.  Since this affects all ram, it is most efficient
      * to handle this during translation.
      */
-- 
2.39.2


