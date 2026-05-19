Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1DBCD5BAB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 15:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPMDV-0003G2-Sh; Tue, 19 May 2026 11:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wPMDI-0003DT-V6
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:18:32 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wPMDH-0006u7-Fl
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:18:32 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 826306021D;
 Tue, 19 May 2026 15:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012E2C2BCFD;
 Tue, 19 May 2026 15:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779203910;
 bh=ZHZMWK/Y6BLbreJHxxZE96bnmbO8p9Qkj5s5S03gJ4U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LE5DOMOFsJyi0wX60vI4gzKmUPAWDhoTPJGEUVTQIwzU1fcgvsM6QPGEPHH0BjAdN
 ZCo/8DF4yFC0khFyuZbJmi2N3Oy7C7rNLsHzm4LvalFr3DzT8JNhN9fEQK8uEVzouc
 wCNCC5h3OsQaZNPCNgVz2auPs8HQc+U4Q08ckRKur+sWaX28w8h+3/xnY7IZFpe+Fi
 SxPVuw2xOGlgX3X4olKotunfBG1EHL3rsiIlYxugmojRQzbnzqLGcqWU6I0fXZnAUP
 ikgEkpdDJ08cagtIpETc4t+KuXq7glu1g22VYpBNxIsInLbKlHFfU0ZuOciOrdQ4D3
 RTKh0qK51cw9A==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, deller@gmx.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/2] hw/hppa: Move static variable lasi_dev into MachineState
Date: Tue, 19 May 2026 17:18:23 +0200
Message-ID: <20260519151823.13878-3-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519151823.13878-1-deller@kernel.org>
References: <20260519151823.13878-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

From: Helge Deller <deller@gmx.de>

Avoid static variables, so move lasi_dev into the MachineState struct.

Signed-off-by: Helge Deller <deller@gmx.de>
Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/hppa/machine.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 0937d90ed2..d762163ddf 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -44,6 +44,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(HppaMachineState, HPPA_COMMON_MACHINE)
 struct HppaMachineState {
     MachineState parent_obj;
 
+    DeviceState *lasi_dev;
     uint64_t memsplit_addr;
 };
 
@@ -52,8 +53,6 @@ struct HppaMachineState {
 #define HPA_POWER_BUTTON        (FIRMWARE_END - 0x10)
 static hwaddr soft_power_reg;
 
-static DeviceState *lasi_dev;
-
 static void hppa_powerdown_req(Notifier *n, void *opaque)
 {
     uint32_t val;
@@ -399,7 +398,8 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
 {
     const char *kernel_filename = machine->kernel_filename;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
-    DeviceState *dev;
+    HppaMachineState *hpm = HPPA_COMMON_MACHINE(machine);
+    DeviceState *dev, *lasi_dev;
     PCIDevice *pci_dev;
     long size;
     uint64_t kernel_entry = 0;
@@ -408,6 +408,7 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     SysBusDevice *s;
 
     /* Graphics setup. */
+    lasi_dev = hpm->lasi_dev;
     if (lasi_dev && machine->enable_graphics &&
         vga_interface_type != VGA_NONE) {
         dev = qdev_new("artist");
@@ -576,7 +577,8 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
  */
 static void machine_HP_715_init(MachineState *machine)
 {
-    DeviceState *dev;
+    HppaMachineState *hpm = HPPA_COMMON_MACHINE(machine);
+    DeviceState *dev, *lasi_dev;
     MemoryRegion *addr_space = get_system_memory();
     TranslateFn *translate;
     ISABus *isa_bus;
@@ -596,6 +598,7 @@ static void machine_HP_715_init(MachineState *machine)
 
     /* Init Lasi chip */
     lasi_dev = DEVICE(lasi_init());
+    hpm->lasi_dev = lasi_dev;
     memory_region_add_subregion(addr_space, translate(NULL, LASI_HPA_715),
                                 sysbus_mmio_get_region(
                                     SYS_BUS_DEVICE(lasi_dev), 0));
@@ -652,7 +655,8 @@ static void machine_HP_715_init(MachineState *machine)
  */
 static void machine_HP_B160L_init(MachineState *machine)
 {
-    DeviceState *dev, *dino_dev;
+    HppaMachineState *hpm = HPPA_COMMON_MACHINE(machine);
+    DeviceState *dev, *dino_dev, *lasi_dev;
     MemoryRegion *addr_space = get_system_memory();
     TranslateFn *translate;
     ISABus *isa_bus;
@@ -669,6 +673,7 @@ static void machine_HP_B160L_init(MachineState *machine)
 
     /* Init Lasi chip */
     lasi_dev = DEVICE(lasi_init());
+    hpm->lasi_dev = lasi_dev;
     memory_region_add_subregion(addr_space, translate(NULL, LASI_HPA),
                                 sysbus_mmio_get_region(
                                     SYS_BUS_DEVICE(lasi_dev), 0));
-- 
2.54.0


