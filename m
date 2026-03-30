Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF601061B08
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 21:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7K0r-0000mh-Hz; Mon, 30 Mar 2026 17:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7K0q-0000mC-DK
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:19:08 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7K0n-0003i5-IH
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:19:08 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C2C1A6013C;
 Mon, 30 Mar 2026 21:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEC4C4CEF7;
 Mon, 30 Mar 2026 21:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774905544;
 bh=vnvUz445Ezf/ayCp3s3+xZTULkEUm1mH6fmU65wFVRs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RNntecLiKJLF6r3C/Gr+ObyNGpJLj0rdxC4+ZIMxIIiqJuzLwbxxso9GEHSGDOwlA
 eazmYjVjYsA269nQPbe9dPoK6Q+Lfc2KyZABFe7d/PKVs0xdb9eeckaaocQ/PYyCPw
 v7JIVgZMQo+WBQCAEUYpZG0WwaLrg5LY9366Ktmt4BgQKBuAr6ZC/qZoofg8wEu7kD
 9C565EfZz9OBSklWo5IPpRxNWJnf6KKDNj/dGtsJmjodfJ4+hroLax7ux2PKSsEmAq
 obXOWlkt+02g6WtteuoH+B4aJk4Bqfw/1EomhEyfW04LgoZeV7vNogiQl6V/5g4vac
 OOUa1QiyS77+g==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 02/11] hw/hppa: Disable Artist graphics card on 64-bit machines
Date: Mon, 30 Mar 2026 23:18:49 +0200
Message-ID: <20260330211859.19317-3-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330211859.19317-1-deller@kernel.org>
References: <20260330211859.19317-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The original Artist graphics used the GSC bus, was often installed in old
32-bit machines (e.g. 715) and can not be used on 64-bit machines.
This is why this patch makes the artist driver dependend on the Lasi chip,
which was never used in a 64-bit machine.

Note that there exists a variant of Artist for the PCI-bus (Visualize-EG PCI).
It has quite some differences in the registers, and would require that we write
a PCI ROM for it, so that Linux and HP-UX would be able to use it.

Instead, for now, users can simply use a standard VGA or ATI PCI graphics card
on Linux.  This can be enabled on the command line with "-device ati-vga" or
"-device VGA".  If the "-nographic" option is omitted, a PCI OCHI controller
with USB keyboard and USB mouse will be added automatically.

This fixes graphics support on 64-bit hppa machines and allows us to boot up a
64-bit Linux installation with VGA graphics.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 3663bac53b..58e76bee2e 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -384,7 +384,8 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     SysBusDevice *s;
 
     /* Graphics setup. */
-    if (machine->enable_graphics && vga_interface_type != VGA_NONE) {
+    if (lasi_dev && machine->enable_graphics &&
+        vga_interface_type != VGA_NONE) {
         dev = qdev_new("artist");
         s = SYS_BUS_DEVICE(dev);
         bool disabled = object_property_get_bool(OBJECT(dev), "disable", NULL);
-- 
2.53.0


