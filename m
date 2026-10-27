Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBDC606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 21:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oj+rCg1D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLp5k-0002xe-J7; Tue, 27 Oct 2026 17:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xLp5h-0002xN-Sw
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 17:52:21 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xLp5g-00007b-6c
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 17:52:21 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 87B76600C8;
 Tue, 27 Oct 2026 21:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92031F01825;
 Tue, 27 Oct 2026 21:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793137939;
 bh=M6khnN4p2EYxNVrIWHFbBZ9IyWZpUi0pUO8tKjJnifI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Oj+rCg1D5BNCWnuW2eyN0M0vPPCy3E3DgB+x5IEEjyK7nZhzYdKLCyZOYFhdAfFwS
 /zqii5D0thzfZAOH3eeVK3cNmw/P/inl7/WkQP1y5K5b7YqcbYEuIX6UgZTCqZo6Hk
 vgsf8Qjqp+BpjEr656DkfDJDhm30W56XXxRk1//oZp/DZXSmq6pnTMELne3i0Ob6Hm
 AGIQR5spiq7SvYaia7FKw2vOd6Bu5WhZYyCFmIMP9Y0ho6K+3epbUyXqhZf6pRij5r
 xVpwuS/tD/J/ZfACaioZiU7EKdSOhjQabZqngKzd8atikev62yJvEvZ3DQ/C2GIcDM
 dWXTiEtDj6F/g==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Keith Monahan <keith@techtravels.org>,
 "Kirill A . Korinsky" <kirill@korins.ky>, Helge Deller <deller@gmx.de>
Subject: [PATCH 4/8] target/hppa: Implement local broadcast I/O space
Date: Tue, 27 Oct 2026 22:52:05 +0100
Message-ID: <20261027215209.21150-5-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027215209.21150-1-deller@kernel.org>
References: <20261027215209.21150-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keith Monahan <keith@techtravels.org>

The local broadcast I/O space is used by older operating systems like HP-UX 9.05
to send an interrupt to all CPUs, or to issue a system reset.
Wire it up on the emulated 715 machine to allow HP-UX 9.05 to run.

Signed-off-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 96d57b9b0f..8d378385b2 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -573,6 +573,47 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     cpu[0]->env.kernel_entry = kernel_entry;
 }
 
+/*
+ * Local broadcast I/O space: a write to IO_EIR (offset 0) posts an external
+ * interrupt on all processors, CMD_RESET (5) written to IO_COMMAND (0x30)
+ * resets the system.  HP-UX 9 reboots through the latter.
+ */
+#define HPPA_BROADCAST_HPA      0xfffc0000
+#define HPPA_IO_COMMAND         0x30
+#define HPPA_CMD_RESET          5
+
+static uint64_t hppa_broadcast_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return 0;
+}
+
+static void hppa_broadcast_write(void *opaque, hwaddr addr, uint64_t val,
+                                 unsigned size)
+{
+    unsigned int i;
+
+    switch (addr) {
+    case 0:
+        for (i = 0; i < current_machine->smp.cpus; i++) {
+            hppa_io_eir_ops.write(cpu[i], 0, val, 4);
+        }
+        break;
+    case HPPA_IO_COMMAND:
+        if (val == HPPA_CMD_RESET) {
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        }
+        break;
+    }
+}
+
+static const MemoryRegionOps hppa_broadcast_ops = {
+    .read = hppa_broadcast_read,
+    .write = hppa_broadcast_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
 /*
  * Create HP 715/64 workstation
  */
@@ -597,6 +638,14 @@ static void machine_HP_715_init(MachineState *machine)
     isa_bus = hppa_isa_bus(translate(NULL, IDE_HPA));
     assert(isa_bus);
 
+    /* Local broadcast I/O space */
+    MemoryRegion *dev_mr_bcast = g_new(MemoryRegion, 1);
+    memory_region_init_io(dev_mr_bcast, NULL, &hppa_broadcast_ops, NULL,
+                          "local-broadcast", 0x1000);
+    memory_region_add_subregion(addr_space,
+                                translate(NULL, HPPA_BROADCAST_HPA),
+                                dev_mr_bcast);
+
     /* Init Lasi chip */
     lasi_dev = DEVICE(lasi_init());
     hpm->lasi_dev = lasi_dev;
-- 
2.54.0


