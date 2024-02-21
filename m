Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26613C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcuRM-00011r-6M; Wed, 21 Feb 2024 16:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rcuRI-0000vT-3W; Wed, 21 Feb 2024 16:47:40 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rcuRG-0007Lq-DB; Wed, 21 Feb 2024 16:47:39 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6C68A4F863;
 Thu, 22 Feb 2024 00:47:46 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 13D7C869E4;
 Thu, 22 Feb 2024 00:47:24 +0300 (MSK)
Received: (nullmailer pid 2339844 invoked by uid 1000);
 Wed, 21 Feb 2024 21:47:23 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Guenter Roeck <linux@roeck-us.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.10 07/33] pci-host: designware: Limit value range of iATU
 viewport register
Date: Thu, 22 Feb 2024 00:46:50 +0300
Message-Id: <20240221214723.2339742-7-mjt@tls.msk.ru>
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

From: Guenter Roeck <linux@roeck-us.net>

The latest version of qemu (v8.2.0-869-g7a1dc45af5) crashes when booting
the mcimx7d-sabre emulation with Linux v5.11 and later.

qemu-system-arm: ../system/memory.c:2750: memory_region_set_alias_offset: Assertion `mr->alias' failed.

Problem is that the Designware PCIe emulation accepts the full value range
for the iATU Viewport Register. However, both hardware and emulation only
support four inbound and four outbound viewports.

The Linux kernel determines the number of supported viewports by writing
0xff into the viewport register and reading the value back. The expected
value when reading the register is the highest supported viewport index.
Match that code by masking the supported viewport value range when the
register is written. With this change, the Linux kernel reports

imx6q-pcie 33800000.pcie: iATU: unroll F, 4 ob, 4 ib, align 0K, limit 4G

as expected and supported.

Fixes: d64e5eabc4c7 ("pci: Add support for Designware IP block")
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Nikita Ostrenkov <n.ostrenkov@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20240129060055.2616989-1-linux@roeck-us.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 8a73152020337a7fbf34daf0a006d4d89ec1494e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index bde3a343a2..c235b9daa3 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -340,6 +340,8 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
         break;
 
     case DESIGNWARE_PCIE_ATU_VIEWPORT:
+        val &= DESIGNWARE_PCIE_ATU_REGION_INBOUND |
+                (DESIGNWARE_PCIE_NUM_VIEWPORTS - 1);
         root->atu_viewport = val;
         break;
 
-- 
2.39.2


