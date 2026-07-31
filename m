Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1AAC54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 05:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpgFa-0002db-0v; Fri, 31 Jul 2026 01:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeM7-0005u0-JE; Thu, 30 Jul 2026 23:56:19 -0400
Received: from [115.124.30.111] (helo=out30-111.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeM0-0002IS-C5; Thu, 30 Jul 2026 23:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1785470165; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=pE7LnGD3kxaTjc6naK4cdM+8ju7a+qGPqFIRWrBQppU=;
 b=HGT3Gpekuf9ZwfmC9PfXb6PqH1bqVTPdEZ04+VlvqoUElcq43VJdkqLhrFsStATY0lMItQd3G32NJzZPE3y4Rno755ufB4MCA+Vmq2yDQ+UM9H4blt92UpyHXVR/oyp3Y+sJTWEaVN2ipia6qLCnyEm50iIe0wPfnksuuEGpcw4=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=blduan@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0X86jwTV_1785469853; 
Received: from ea134-sw16.eng.xrvm.cn(mailfrom:blduan@linux.alibaba.com
 fp:SMTPD_---0X86jwTV_1785469853 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 31 Jul 2026 11:50:54 +0800
From: Baolong Duan <blduan@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair23@gmail.com, dbarboza@ventanamicro.com,
 cxx194832@alibaba-inc.com, zengxiangyi.zxy@alibaba-inc.com,
 Baolong Duan <blduan@linux.alibaba.com>
Subject: [RFC PATCH v1 08/17] hw/riscv/virt: use MSIs only for a CoVE guest
Date: Fri, 31 Jul 2026 11:50:02 +0800
Message-Id: <20260731035011.4178103-9-blduan@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731035011.4178103-1-blduan@linux.alibaba.com>
References: <20260731035011.4178103-1-blduan@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.111 (deferred)
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=blduan@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 31 Jul 2026 01:57:33 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Interrupts of a CoVE guest can only be delivered as MSIs, so an IMSIC is
mandatory: without one PCIe devices have no interrupt source at all and
their drivers fail to probe.  Select aia=aplic-imsic when no AIA mode has
been requested.

Also stop creating the virtio-mmio transports, which a CoVE guest cannot
use; its devices are attached to the PCIe host bridge instead.

Signed-off-by: Baolong Duan <blduan@linux.alibaba.com>
---
 hw/riscv/virt.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 777859baa2..dbb82bbd21 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1373,6 +1373,16 @@ static void virt_machine_init(MachineState *machine)
         exit(1);
     }
 
+    /*
+     * A CoVE guest can only receive MSIs, so an IMSIC is mandatory: without
+     * it PCIe devices have no interrupt source at all and their drivers fail
+     * to probe.
+     */
+    if (s->cove_vm && s->aia_type == VIRT_AIA_TYPE_NONE) {
+        s->aia_type = VIRT_AIA_TYPE_APLIC_IMSIC;
+        warn_report("CoVE VM: forcing aia=aplic-imsic");
+    }
+
     /* Initialize sockets */
     mmio_irqchip = virtio_irqchip = pcie_irqchip = NULL;
     for (i = 0; i < socket_count; i++) {
@@ -1524,10 +1534,13 @@ static void virt_machine_init(MachineState *machine)
     sifive_test_create(s->memmap[VIRT_TEST].base);
 
     /* VirtIO MMIO devices */
-    for (i = 0; i < VIRTIO_COUNT; i++) {
-        sysbus_create_simple("virtio-mmio",
-            s->memmap[VIRT_VIRTIO].base + i * s->memmap[VIRT_VIRTIO].size,
-            qdev_get_gpio_in(virtio_irqchip, VIRTIO_IRQ + i));
+    /* A CoVE guest has no virtio-mmio transport, see create_fdt_virtio(). */
+    if (!s->cove_vm) {
+        for (i = 0; i < VIRTIO_COUNT; i++) {
+            sysbus_create_simple("virtio-mmio",
+                s->memmap[VIRT_VIRTIO].base + i * s->memmap[VIRT_VIRTIO].size,
+                qdev_get_gpio_in(virtio_irqchip, VIRTIO_IRQ + i));
+        }
     }
 
     gpex_pcie_init(system_memory, pcie_irqchip, s);
-- 
2.34.1


