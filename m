Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0358BC87FC9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 15:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugPif-0002Jh-9e; Mon, 28 Jul 2025 11:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ugPid-0002H5-Lz; Mon, 28 Jul 2025 11:24:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ugPib-0000Do-Np; Mon, 28 Jul 2025 11:24:51 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E131713AF74;
 Mon, 28 Jul 2025 18:24:38 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 64F992517CD;
 Mon, 28 Jul 2025 18:24:46 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH for 10.1] hw/pci-host/gpex-acpi: PCI_EXPRESS_GENERIC_BRIDGE:
 select ACPI_PCI instead of imply'ing it
Date: Mon, 28 Jul 2025 18:24:45 +0300
Message-ID: <20250728152445.23917-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Commit af151d50eac24 added dependency on hw/i386/acpi-build.c
(where this function is defined) to hw/pci-host/gpex-acpi.
But acpi-build.c is only built when ACPI_PCI is enabled,
and the build fails at link time if it is not.  So ACPI_PCI
becomes a hard dependency of PCI_EXPRESS_GENERIC_BRIDGE.
Fix it.

Fixes: af151d50eac24 "hw/pci-host/gpex-acpi: Use build_pci_host_bridge_osc_method"
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/pci-host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index 9824fa188d..19b6605c7f 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -54,7 +54,7 @@ config PCI_EXPRESS_Q35
 config PCI_EXPRESS_GENERIC_BRIDGE
     bool
     select PCI_EXPRESS
-    imply ACPI_PCI
+    select ACPI_PCI
 
 config PCI_EXPRESS_XILINX
     bool
-- 
2.47.2


