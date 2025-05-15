Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F20AC3DA6D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 13:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFYW5-0008M2-QO; Thu, 15 May 2025 09:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFYW3-0008LX-FU
 for qemu-devel@nongnu.org; Thu, 15 May 2025 09:20:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFYW1-0003cf-IG
 for qemu-devel@nongnu.org; Thu, 15 May 2025 09:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747315248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bsPvKqQeupdE8tFJ1vrETwxErtldfRrw89xt2bmiH/w=;
 b=ihKcgBWpwAw8eZcGQvgXidnTzf7PytWHHlH+AtxNBUzAFoyQhxXJ39d3zz9ew2LZ2ilxCK
 H4rBqveloq0TgmP3c1Z/gS50+bwR7kvT5kjakXJ4NNXYFBTTmtfS45dO3zHh0SEYVBXPsI
 DX2k0CHpIATKuM+EXsi4Ej15BSxNdTQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-b5YLguFcPFOxCqgLeUIUOw-1; Thu,
 15 May 2025 09:20:45 -0400
X-MC-Unique: b5YLguFcPFOxCqgLeUIUOw-1
X-Mimecast-MFC-AGG-ID: b5YLguFcPFOxCqgLeUIUOw_1747315244
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BA05180045B; Thu, 15 May 2025 13:20:44 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.27])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B5581956094; Thu, 15 May 2025 13:20:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 3/4] hw/microblaze: Remove the big-endian variants of ml605
 and xlnx-zynqmp-pmu
Date: Thu, 15 May 2025 15:20:18 +0200
Message-ID: <20250515132019.569365-4-thuth@redhat.com>
In-Reply-To: <20250515132019.569365-1-thuth@redhat.com>
References: <20250515132019.569365-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

Both machines were added with little-endian in mind only (the
"endianness" CPU property was hard-wired to "true", see commits
133d23b3ad1 and a88bbb006a52), so the variants that showed up
on the big endian target likely never worked. We deprecated these
non-working machine variants two releases ago, and so far nobody
complained, so it should be fine now to disable them. Hard-wire
the machines to little endian now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/deprecated.rst           |  6 ------
 docs/about/removed-features.rst     |  9 +++++++++
 hw/microblaze/petalogix_ml605_mmu.c | 15 ++++-----------
 hw/microblaze/xlnx-zynqmp-pmu.c     |  7 +------
 4 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 1a1b423030c..8c5fe6fb274 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -293,12 +293,6 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
 better reflects the way this property affects all random data within
 the device tree blob, not just the ``kaslr-seed`` node.
 
-Big-Endian variants of MicroBlaze ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` machines (since 9.2)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-Both ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` were added for little endian
-CPUs. Big endian support is not tested.
-
 Mips ``mipssim`` machine (since 10.0)
 '''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 063284d4f8a..9df5aba0bb6 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1082,6 +1082,15 @@ This machine was removed because PPC 405 CPU have no known users,
 firmware images are not available, OpenWRT dropped support in 2019,
 U-Boot in 2017, and Linux in 2024.
 
+Big-Endian variants of ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` machines (removed in 10.1)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Both the MicroBlaze ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` machines
+were added for little endian CPUs. Big endian support was never tested
+and likely never worked. Starting with QEMU v10.1, the machines are now
+only available as little-endian machines.
+
+
 linux-user mode CPUs
 --------------------
 
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index bea6b689fd1..6e923c49cfc 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -80,8 +80,6 @@ petalogix_ml605_init(MachineState *machine)
     MemoryRegion *phys_lmb_bram = g_new(MemoryRegion, 1);
     MemoryRegion *phys_ram = g_new(MemoryRegion, 1);
     qemu_irq irq[32];
-    EndianMode endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG
-                                              : ENDIAN_MODE_LITTLE;
 
     /* init CPUs */
     cpu = MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
@@ -113,7 +111,7 @@ petalogix_ml605_init(MachineState *machine)
 
 
     dev = qdev_new("xlnx.xps-intc");
-    qdev_prop_set_enum(dev, "endianness", endianness);
+    qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_LITTLE);
     qdev_prop_set_uint32(dev, "kind-of-intr", 1 << TIMER_IRQ);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, INTC_BASEADDR);
@@ -129,7 +127,7 @@ petalogix_ml605_init(MachineState *machine)
 
     /* 2 timers at irq 2 @ 100 Mhz.  */
     dev = qdev_new("xlnx.xps-timer");
-    qdev_prop_set_enum(dev, "endianness", endianness);
+    qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_LITTLE);
     qdev_prop_set_uint32(dev, "one-timer-only", 0);
     qdev_prop_set_uint32(dev, "clock-frequency", 100 * 1000000);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
@@ -177,7 +175,7 @@ petalogix_ml605_init(MachineState *machine)
         SSIBus *spi;
 
         dev = qdev_new("xlnx.xps-spi");
-        qdev_prop_set_enum(dev, "endianness", endianness);
+        qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_LITTLE);
         qdev_prop_set_uint8(dev, "num-ss-bits", NUM_SPI_FLASHES);
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(busdev, &error_fatal);
@@ -218,12 +216,7 @@ petalogix_ml605_init(MachineState *machine)
 
 static void petalogix_ml605_machine_init(MachineClass *mc)
 {
-    if (TARGET_BIG_ENDIAN) {
-        mc->desc = "PetaLogix linux refdesign for xilinx ml605 (big endian)";
-        mc->deprecation_reason = "big endian support is not tested";
-    } else {
-        mc->desc = "PetaLogix linux refdesign for xilinx ml605 (little endian)";
-    }
+    mc->desc = "PetaLogix linux refdesign for xilinx ml605 (little endian)";
     mc->init = petalogix_ml605_init;
 }
 
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index ed40b5f2e05..e909802bb74 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -181,12 +181,7 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
 
 static void xlnx_zynqmp_pmu_machine_init(MachineClass *mc)
 {
-    if (TARGET_BIG_ENDIAN) {
-        mc->desc = "Xilinx ZynqMP PMU machine (big endian)";
-        mc->deprecation_reason = "big endian support is not tested";
-    } else {
-        mc->desc = "Xilinx ZynqMP PMU machine (little endian)";
-    }
+    mc->desc = "Xilinx ZynqMP PMU machine (little endian)";
     mc->init = xlnx_zynqmp_pmu_init;
 }
 
-- 
2.49.0


