Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD035C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua977-0003wY-37; Fri, 11 Jul 2025 04:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8y0-0005Ul-BM; Fri, 11 Jul 2025 04:18:52 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8xx-00042p-UE; Fri, 11 Jul 2025 04:18:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F2AC41356D8;
 Fri, 11 Jul 2025 11:17:18 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E878123FA4D;
 Fri, 11 Jul 2025 11:17:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 13/39] hw/i386/pc_piix: Fix RTC ISA IRQ wiring of
 isapc machine
Date: Fri, 11 Jul 2025 11:16:09 +0300
Message-ID: <20250711081745.1785806-13-mjt@tls.msk.ru>
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

From: Bernhard Beschow <shentey@gmail.com>

Commit 56b1f50e3c10 ("hw/i386/pc: Wire RTC ISA IRQs in south bridges")
attempted to refactor RTC IRQ wiring which was previously done in
pc_basic_device_init() but forgot about the isapc machine. Fix this by
wiring in the code section dedicated exclusively to the isapc machine.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2961
Fixes: 56b1f50e3c10 ("hw/i386/pc: Wire RTC ISA IRQs in south bridges")
cc: qemu-stable
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Message-Id: <20250526203820.1853-1-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 0b006153b7ec66505cb2d231235aa19ca5d2ce37)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 6c91e2d292..7cfa142b11 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -285,6 +285,8 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
         pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
     } else {
+        uint32_t irq;
+
         isa_bus = isa_bus_new(NULL, system_memory, system_io,
                               &error_abort);
         isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
@@ -292,6 +294,9 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         x86ms->rtc = isa_new(TYPE_MC146818_RTC);
         qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
         isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
+        irq = object_property_get_uint(OBJECT(x86ms->rtc), "irq",
+                                       &error_fatal);
+        isa_connect_gpio_out(ISA_DEVICE(x86ms->rtc), 0, irq);
 
         i8257_dma_init(OBJECT(machine), isa_bus, 0);
         pcms->hpet_enabled = false;
-- 
2.47.2


