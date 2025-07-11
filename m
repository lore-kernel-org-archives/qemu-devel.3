Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D46C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua95J-0000pX-UY; Fri, 11 Jul 2025 04:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8zD-00084D-El; Fri, 11 Jul 2025 04:20:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8z6-0004MV-FF; Fri, 11 Jul 2025 04:20:02 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D1F011356E4;
 Fri, 11 Jul 2025 11:17:19 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C82E923FA59;
 Fri, 11 Jul 2025 11:17:46 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Corentin GENDRE <cocotroupe20@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 25/39] hw/arm/mps2: Configure the AN500 CPU with 16
 MPU regions
Date: Fri, 11 Jul 2025 11:16:21 +0300
Message-ID: <20250711081745.1785806-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Peter Maydell <peter.maydell@linaro.org>

The AN500 application note documents that it configures the Cortex-M7
CPU to have 16 MPU regions. We weren't doing this in our emulation,
so the CPU had only the default 8 MPU regions. Set the mpu-ns-regions
property to 16 for this board.

This bug doesn't affect any of the other board types we model in
this source file, because they all use either the Cortex-M3 or
Cortex-M4. Those CPUs do not have an RTL configurable number of
MPU regions, and always provide 8 regions if the MPU is built in.

Cc: qemu-stable@nongnu.org
Reported-by: Corentin GENDRE <cocotroupe20@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20250605141801.1083266-1-peter.maydell@linaro.org
(cherry picked from commit cd38e638c43e4d5d3fd65dd4529c2e6153c9c408)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 3f8db0cab6..313c401eb8 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -224,7 +224,11 @@ static void mps2_common_init(MachineState *machine)
     switch (mmc->fpga_type) {
     case FPGA_AN385:
     case FPGA_AN386:
+        qdev_prop_set_uint32(armv7m, "num-irq", 32);
+        break;
     case FPGA_AN500:
+        /* The AN500 configures its Cortex-M7 with 16 MPU regions */
+        qdev_prop_set_uint32(armv7m, "mpu-ns-regions", 16);
         qdev_prop_set_uint32(armv7m, "num-irq", 32);
         break;
     case FPGA_AN511:
-- 
2.47.2


