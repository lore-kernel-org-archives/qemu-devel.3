Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635D8CCD1A4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 20:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9qjL-000629-G3; Fri, 17 Oct 2025 16:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1v9qjI-00060j-Vh
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:07:13 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1v9qjH-0005Or-9t
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:07:12 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8606E64620;
 Fri, 17 Oct 2025 20:07:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25047C113D0;
 Fri, 17 Oct 2025 20:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760731630;
 bh=erZN/NshTxwhl6AGnckApOHX/nZ+XlceH2xHC57E+fI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ntx/6uw6egcI6vJDYS2NPhWrJnh2lxjbGOiQnLSGY+G/9Wmfz+iuca1m2Do/3gsib
 z8Y8f5NuiXJhRv904NDa7Zb1za2d6bMw4XKV9hQRormvdPMwL4tuPt87iykURkN30Y
 TDnfMgeBLv3FtYT3aCVm+HEgD7Z8coVi7v9qOClqeqwMfC8JaQX14fkzr4j1UlfmsD
 YAmLrejkAwp1DxhKSyjfn3iBRdOyEInRJo1TGPX5n+v1KWE3B9cSJj+WwezY0NbgNp
 A7aYwes5R+aWPWrQ2vE5uqiwYC2rZ73ysqX7BC3TauahMwmyoYfRF/9K2H5aA8MeD3
 9aWtY8mXnyKOQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH 08/10] hw/hppa: PCI devices depend on availability of PCI bus
Date: Fri, 17 Oct 2025 22:06:51 +0200
Message-ID: <20251017200653.23337-9-deller@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017200653.23337-1-deller@kernel.org>
References: <20251017200653.23337-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Helge Deller <deller@gmx.de>

Only create the PCI serial ports (DIVA) and PCI network cards when there is
actually a PCI bus. The shortly added 715 machine will not have a PCI bus, so
avoid creating further PCI devices.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index bec5a86f24..b6cdbc74ba 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -387,11 +387,13 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
                         enable_lasi_lan());
     }
 
-    pci_init_nic_devices(pci_bus, mc->default_nic);
+    if (pci_bus) {
+        pci_init_nic_devices(pci_bus, mc->default_nic);
+    }
 
     /* BMC board: HP Diva GSP */
-    dev = qdev_new("diva-gsp");
-    if (!object_property_get_bool(OBJECT(dev), "disable", NULL)) {
+    dev = pci_bus ? qdev_new("diva-gsp") : NULL;
+    if (dev && !object_property_get_bool(OBJECT(dev), "disable", NULL)) {
         pci_dev = pci_new_multifunction(PCI_DEVFN(2, 0), "diva-gsp");
         if (!lasi_dev) {
             /* bind default keyboard/serial to Diva card */
-- 
2.51.0


