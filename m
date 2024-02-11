Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F84C4829B
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Feb 2024 12:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZ8xo-0006Bt-46; Sun, 11 Feb 2024 07:29:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rZ8xn-0006Bk-6A
 for qemu-devel@nongnu.org; Sun, 11 Feb 2024 07:29:39 -0500
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rZ8xl-0006Gy-Gl
 for qemu-devel@nongnu.org; Sun, 11 Feb 2024 07:29:38 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 65B33CE0D8B;
 Sun, 11 Feb 2024 12:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54177C433C7;
 Sun, 11 Feb 2024 12:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707654575;
 bh=dmm23UrfgEksNR5qCPqYN6vj7hcWMO7WB2mC/roSAbI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gva582P1Z2niQIGtWUDuWy8Glk8SC/7S7LKTIZJ5LF+EieyXx7GhQEokxBQu+eoaU
 +Ld2WbntdDaKxsFt103mSIAZg+dyR6OnOTHY8q/OJdWcEZ4XP5ZtYNb7d3CuFBakw+
 Z6mPVYXuRbmdKKyVsDxgmGz3fkAmAsp5lsv8OVLx/i7ABPJNF3yhheida5gzUo5wTI
 ENEagBK7gjH1l9gvxYIP6gGEEr6Y+ZSF6mAL/ueACLPoscQdaBqiUe2FBitfdtzC9e
 INREGjXEQiTY/c3nGu8wj3H6ljRrkVJ4hV72BFQuk0HeiFMRSV/tZXlj3gYkVyo3I1
 CuKa21lUvTw2g==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sven Schnelle <svens@stackframe.org>, Jason Wang <jasowang@redhat.com>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 12/12] hw/hppa/machine: Load 64-bit firmware on 64-bit machines
Date: Sun, 11 Feb 2024 13:29:09 +0100
Message-ID: <20240211122909.5807-13-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211122909.5807-1-deller@kernel.org>
References: <20240211122909.5807-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=deller@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Acked-by: Richard Henderson <richard.henderson@linaro.org>
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


