Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B590C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 17:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVaCn-0004UN-JR; Thu, 01 Feb 2024 11:46:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rVaB4-0002vK-2q
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:39 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rVaAt-0002Qe-Uu
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
 Cc:Content-Type:Content-ID:Content-Description;
 bh=mlzjYpSZjZYD2hYts+UpgvgXir7egBvmFzjPnPYKEbw=; b=npLRH8w1qzNycnHMMtiO+GfrT9
 3yH7QQz4lmqgxO9kkdiu6ZHsus3GtnVUmQB7JxXerXJf7SOXdmeXW9dGYUE8WXv8NPKi8tE1K7WT+
 UCE+/zqshHMuorgrFPD3LGk5hgvd1Xo3kU9Xegt/lGWlk/I4Sgxs1vJ82iYEzVV36/we1hA5XyaD/
 ZpFuJRD74aUsF5KJ3Pxk0eHsfwp8FL17hEtRgepSRdUtntZJt3324p7vnHhji90kSy2Gs2BHW4ndz
 dcxMr5b5HEqYw7XUXku/NcVH9kM4UZbkIZuzIWGtbTTQvneXHxr68RS5iSkjnMIHSf46AwoO2RoT0
 GdH3kTxQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rVaAe-0000000GIcz-3rCU for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:14 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rVaAf-00000003IMS-2fHf for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:13 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/47] hw/hppa: use pci_init_nic_devices()
Date: Thu,  1 Feb 2024 16:43:35 +0000
Message-ID: <20240201164412.785520-11-dwmw2@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201164412.785520-1-dwmw2@infradead.org>
References: <20240201164412.785520-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/hppa/machine.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 9e611620cc..a1045b48cc 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -342,7 +342,6 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     uint64_t kernel_entry = 0, kernel_low, kernel_high;
     MemoryRegion *addr_space = get_system_memory();
     MemoryRegion *rom_region;
-    long i;
     unsigned int smp_cpus = machine->smp.cpus;
     SysBusDevice *s;
 
@@ -368,10 +367,8 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
                         qdev_get_gpio_in(lasi_dev, LASI_IRQ_LAN_HPA));
     }
 
-    for (i = 0; i < nb_nics; i++) {
-        if (!enable_lasi_lan()) {
-            pci_nic_init_nofail(&nd_table[i], pci_bus, mc->default_nic, NULL);
-        }
+    if (!enable_lasi_lan()) {
+        pci_init_nic_devices(pci_bus, mc->default_nic);
     }
 
     /* BMC board: HP Powerbar SP2 Diva (with console only) */
-- 
2.43.0


