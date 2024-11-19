Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F205AD591A6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 06:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDHLp-0000sD-VA; Tue, 19 Nov 2024 01:04:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tDHLn-0000jq-3Z; Tue, 19 Nov 2024 01:04:35 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tDHLk-0004cR-Rq; Tue, 19 Nov 2024 01:04:34 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A4FADA6261;
 Tue, 19 Nov 2024 09:04:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id CBBBB1738D7;
 Tue, 19 Nov 2024 09:04:18 +0300 (MSK)
Received: (nullmailer pid 2368929 invoked by uid 1000);
 Tue, 19 Nov 2024 06:04:18 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.2 59/72] hw/i386/pc: Don't try to init PCI NICs if there
 is no PCI bus
Date: Tue, 19 Nov 2024 09:04:00 +0300
Message-Id: <20241119060418.2368866-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.2-20241118224223@cover.tls.msk.ru>
References: <qemu-stable-9.1.2-20241118224223@cover.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

The 'isapc' machine type has no PCI bus, but pc_nic_init() still
calls pci_init_nic_devices() passing it a NULL bus pointer.  This
causes the clang sanitizer to complain:

$ ./build/clang/qemu-system-i386 -M isapc
../../hw/pci/pci.c:1866:39: runtime error: member access within null pointer of type 'PCIBus' (aka 'struct PCIBus')
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../hw/pci/pci.c:1866:39 in

This is because pci_init_nic_devices() does
 &bus->qbus
which is undefined behaviour on a NULL pointer even though we're not
actually dereferencing the pointer. (We don't actually crash as
a result, so if you aren't running a sanitizer build then there
are no user-visible effects.)

Make pc_nic_init() avoid trying to initialize PCI NICs on a non-PCI
system.

Cc: qemu-stable@nongnu.org
Fixes: 8d39f9ba14d64 ("hw/i386/pc: use qemu_get_nic_info() and pci_init_nic_devices()")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/r/20241105171813.3031969-1-peter.maydell@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit bd0e501e1a4813fa36a4cf9842aaf430323a03c3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 7779c88a91..a527c0df0a 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1245,7 +1245,9 @@ void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
     }
 
     /* Anything remaining should be a PCI NIC */
-    pci_init_nic_devices(pci_bus, mc->default_nic);
+    if (pci_bus) {
+        pci_init_nic_devices(pci_bus, mc->default_nic);
+    }
 
     rom_reset_order_override();
 }
-- 
2.39.5


