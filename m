Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A1FC4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 16:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVaAt-0002rx-KW; Thu, 01 Feb 2024 11:44:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rVaAm-0002pg-Qc
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:20 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rVaAk-0002Tl-7y
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
 Cc:Content-Type:Content-ID:Content-Description;
 bh=3fkwqn/oQ2lTIBRIwv3DeL/yQVsijuQk7CJbx2zLVp8=; b=eMq0A9+n0tUeL8fppCRvG+lUdJ
 U4UX2Zpv1In6Grmzt5aEKij6RhapBwFaoiE9Dhf0ek1kLN3Ag/VMY6VYRHai271TzDcQPADklJ7tZ
 XIB4bDqJug3ETnSzKjPzbgYdQMIHSsNu9cKOx9RR9c2xq9HE8EDyHpP5sGGgz6EBNB53LNuIWvG9M
 V7KePstZo+ApiVudse15L037G8v2FGPKlToCH+SfHpbzXDfWsv/1qf1Z+dp/paMeBxew1hXn6J/mX
 jDxXczK058XhDYpOElLbBr0ilJhNaj4Leiji5EaiOOdY9SGd1WBR26WWUKr2sPb5FL/6hRUHuwE5s
 kMpQhcQg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rVaAf-0000000GIdj-2cKU for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:15 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rVaAg-00000003IOY-33aJ for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:14 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/47] hw/openrisc/openrisc_sim: use qemu_create_nic_device()
Date: Thu,  1 Feb 2024 16:44:04 +0000
Message-ID: <20240201164412.785520-40-dwmw2@infradead.org>
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
 hw/openrisc/openrisc_sim.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 35da123aef..bffd6f721f 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -170,7 +170,7 @@ static void openrisc_create_fdt(Or1ksimState *state,
 
 static void openrisc_sim_net_init(Or1ksimState *state, hwaddr base, hwaddr size,
                                   int num_cpus, OpenRISCCPU *cpus[],
-                                  int irq_pin, NICInfo *nd)
+                                  int irq_pin)
 {
     void *fdt = state->fdt;
     DeviceState *dev;
@@ -178,8 +178,10 @@ static void openrisc_sim_net_init(Or1ksimState *state, hwaddr base, hwaddr size,
     char *nodename;
     int i;
 
-    dev = qdev_new("open_eth");
-    qdev_set_nic_properties(dev, nd);
+    dev = qemu_create_nic_device("open_eth", true, NULL);
+    if (!dev) {
+        return;
+    }
 
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
@@ -313,12 +315,10 @@ static void openrisc_sim_init(MachineState *machine)
     openrisc_create_fdt(state, or1ksim_memmap, smp_cpus, machine->ram_size,
                         machine->kernel_cmdline);
 
-    if (nd_table[0].used) {
-        openrisc_sim_net_init(state, or1ksim_memmap[OR1KSIM_ETHOC].base,
-                              or1ksim_memmap[OR1KSIM_ETHOC].size,
-                              smp_cpus, cpus,
-                              OR1KSIM_ETHOC_IRQ, nd_table);
-    }
+    openrisc_sim_net_init(state, or1ksim_memmap[OR1KSIM_ETHOC].base,
+                          or1ksim_memmap[OR1KSIM_ETHOC].size,
+                          smp_cpus, cpus,
+                          OR1KSIM_ETHOC_IRQ);
 
     if (smp_cpus > 1) {
         openrisc_sim_ompic_init(state, or1ksim_memmap[OR1KSIM_OMPIC].base,
-- 
2.43.0


