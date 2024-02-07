Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D490C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 18:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXmXT-0004nG-9I; Wed, 07 Feb 2024 13:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rXmXP-0004ll-UG
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 13:20:48 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rXmXO-0008EW-6D
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 13:20:47 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 44D4B61A34;
 Wed,  7 Feb 2024 18:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AE3C433F1;
 Wed,  7 Feb 2024 18:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707330044;
 bh=FpOCoPgFYE4MpPAthlIj28nIxN0rYpoircX68gN/zpM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rf0dHE3eXGVyQZcVhHmyp+/z31vguo4Nwi+tplOGCaA1kHyHPvEgBqsSeXBXTt4gY
 tvkPVHLZ0Dsd1sSk8vDZGgyg+vdKaeBYJOz2zlLqYrYMd84L9yHKVpZuy4afrST0Cp
 /qYwXacGKvU8nQtw5LZgqyomM8pgIlAN8ZtWrG7ESrFB2S3Rlim00SG6BKH2Jdm8X9
 TYH4RK4eNbx5Qe8QeY1SLnhsZfZufb59G832YFNNs5aqHt/78iQrvdL/52BkiEG35i
 a6Rc3yd5y9Qfl4yTtOaCAAM+qX5fMYB6RQVIo+Q+YxQ2iZfLroY4fENOVJyygl2c7g
 kdxvDpSW7yYug==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 13/13] hw/hppa/machine: Load 64-bit firmware on 64-bit machines
Date: Wed,  7 Feb 2024 19:20:23 +0100
Message-ID: <20240207182023.36316-14-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207182023.36316-1-deller@kernel.org>
References: <20240207182023.36316-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Helge Deller <deller@gmx.de>

Load the 64-bit SeaBIOS-hppa firmware by default when running on a 64-bit
machine. This will enable us to later support more than 4GB of RAM and is
required that the OS (or PALO bootloader) will start or install a 64-bit kernel
instead of a 32-bit kernel.

Note that SeaBIOS-hppa v16 provides the "-fw_cfg opt/OS64,string=3" option with
which the user can control what the firmware shall report back to the OS:
Support of 32-bit OS, support of a 64-bit OS, or support for both (default).

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index eb78c46ff1..a47baa572d 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -333,6 +333,7 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
+    const char *firmware = machine->firmware;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     DeviceState *dev;
     PCIDevice *pci_dev;
@@ -408,9 +409,13 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
 
     /* Load firmware.  Given that this is not "real" firmware,
        but one explicitly written for the emulation, we might as
-       well load it directly from an ELF image.  */
-    firmware_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
-                                       machine->firmware ?: "hppa-firmware.img");
+       well load it directly from an ELF image. Load the 64-bit
+       firmware on 64-bit machines by default if not specified
+       on command line. */
+    if (!firmware) {
+        firmware = lasi_dev ? "hppa-firmware.img" : "hppa-firmware64.img";
+    }
+    firmware_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware);
     if (firmware_filename == NULL) {
         error_report("no firmware provided");
         exit(1);
-- 
2.43.0


