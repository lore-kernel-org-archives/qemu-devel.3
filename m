Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79ACEC28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 06:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttKu4-0000hd-VK; Sat, 15 Mar 2025 02:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKsS-0004hS-KF; Sat, 15 Mar 2025 02:20:10 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKsQ-0003My-4S; Sat, 15 Mar 2025 02:20:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B6EECFF9E1;
 Sat, 15 Mar 2025 09:17:07 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8E6A21CAC4A;
 Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 5DF2E558D9; Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Joelle van Dyne <j@getutm.app>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 21/51] target/arm/hvf: Disable SME feature
Date: Sat, 15 Mar 2025 09:17:27 +0300
Message-Id: <20250315061801.622606-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
References: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Joelle van Dyne <j@getutm.app>

macOS 15.2's Hypervisor.framework exposes SME feature on M4 Macs.
However, QEMU's hvf accelerator code does not properly support it
yet, causing QEMU to fail to start when hvf accelerator is used on
these systems, with the error message:

  qemu-aarch64-softmmu: cannot disable sme4224
  All SME vector lengths are disabled.
  With SME enabled, at least one vector length must be enabled.

Ideally we would have SME support on these hosts; however, until that
point, we must suppress the SME feature in the ID registers, so that
users can at least run non-SME guests.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2665
Signed-off-by: Joelle van Dyne <j@getutm.app>
Message-id: 20250224165735.36792-1-j@getutm.app
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: expanded commit message, comment]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit fd207677a83087454b8afef31651985a1df0d2dd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index ca7ea92774..0089174b36 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -897,6 +897,18 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
     clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar.id_aa64mmfr0);
 
+    /*
+     * Disable SME, which is not properly handled by QEMU hvf yet.
+     * To allow this through we would need to:
+     * - make sure that the SME state is correctly handled in the
+     *   get_registers/put_registers functions
+     * - get the SME-specific CPU properties to work with accelerators
+     *   other than TCG
+     * - fix any assumptions we made that SME implies SVE (since
+     *   on the M4 there is SME but not SVE)
+     */
+    host_isar.id_aa64pfr1 &= ~R_ID_AA64PFR1_SME_MASK;
+
     ahcf->isar = host_isar;
 
     /*
-- 
2.39.5


