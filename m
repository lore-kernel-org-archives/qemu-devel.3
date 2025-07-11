Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D2CC83F23
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua960-00028u-5D; Fri, 11 Jul 2025 04:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8xc-0004jM-An; Fri, 11 Jul 2025 04:18:24 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8xa-000428-BJ; Fri, 11 Jul 2025 04:18:24 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D1F3B1356D6;
 Fri, 11 Jul 2025 11:17:18 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id BD7B623FA4B;
 Fri, 11 Jul 2025 11:17:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Guenter Roeck <linux@roeck-us.net>,
 Hao Wu <wuhaotsh@google.com>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 11/39] hw/arm: Add missing psci_conduit to NPCM8XX SoC
 boot info
Date: Fri, 11 Jul 2025 11:16:07 +0300
Message-ID: <20250711081745.1785806-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Guenter Roeck <linux@roeck-us.net>

Without psci_conduit, the Linux kernel crashes almost immediately.

    psci: probing for conduit method from DT.
    Internal error: Oops - Undefined instruction: 0000000002000000 [#1] PREEMPT SMP

Fixes: ae0c4d1a1290 ("hw/arm: Add NPCM8XX SoC")
Cc: qemu-stable@nongnu.org
Cc: Hao Wu <wuhaotsh@google.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20250315142050.3642741-1-linux@roeck-us.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit e6bc01777e5a4b6ecf3414b21a2d7b4846bf4817)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
index f182accc47..e5a1929ed7 100644
--- a/hw/arm/npcm8xx.c
+++ b/hw/arm/npcm8xx.c
@@ -346,6 +346,7 @@ static struct arm_boot_info npcm8xx_binfo = {
     .secure_boot            = false,
     .board_id               = -1,
     .board_setup_addr       = NPCM8XX_BOARD_SETUP_ADDR,
+    .psci_conduit           = QEMU_PSCI_CONDUIT_SMC,
 };
 
 void npcm8xx_load_kernel(MachineState *machine, NPCM8xxState *soc)
-- 
2.47.2


