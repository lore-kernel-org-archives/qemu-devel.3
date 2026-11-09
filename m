Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D419606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQQzL-0000sz-Td; Mon, 09 Nov 2026 10:08:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.lamprecht@proxmox.com>)
 id 1xQQzE-0000rf-Es; Mon, 09 Nov 2026 10:08:44 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.lamprecht@proxmox.com>)
 id 1xQQzA-0008DB-Mc; Mon, 09 Nov 2026 10:08:43 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id A41C945E42;
 Mon, 09 Nov 2026 16:08:33 +0100 (CET)
From: Thomas Lamprecht <t.lamprecht@proxmox.com>
To: qemu-devel@nongnu.org
Cc: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org
Subject: [PATCH for-11.2 2/2] hw/i386/microvm: reserve the firmware data area
 when loading Linux
Date: Mon,  9 Nov 2026 10:33:43 +0100
Message-ID: <20261109150753.1727674-3-t.lamprecht@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109150753.1727674-1-t.lamprecht@proxmox.com>
References: <20261109150753.1727674-1-t.lamprecht@proxmox.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1794236912871
Received-SPF: pass client-ip=94.136.29.106;
 envelope-from=t.lamprecht@proxmox.com; helo=proxmox-new.maurer-it.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
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
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

microvm passes no firmware data size to x86_load_linux(), so QEMU
places the initrd at the very top of RAM below 4G, where SeaBIOS also
places the ACPI tables. Usually linuxboot_dma.bin then moves the initrd
below the memory that the BIOS reports via E801. But it keeps the
initrd in place if it ends in the page of the kernel's initrd_addr_max,
0x7fffffff for x86_64 kernels, taking that as a sign that the kernel's
limit and not the end of RAM decided the placement. With exactly 2 GiB
of RAM, both are the same page, so the initrd overwrites the ACPI
tables and other data that SeaBIOS keeps there. Depending on the initrd
size and the configuration, Linux then finds a corrupted DSDT, with
PCIe enabled reports "AE_NO_ACPI_TABLES" and finds no PCI devices, or
hangs while probing EDD, as the SeaBIOS virtio-blk driver then sends
corrupted requests ("virtio-blk missing headers").

To fix thix reserve the same amount of memory as the PC machines do.
This places the initrd below the firmware data in the first place and
lets linuxboot_dma.bin move it below the BIOS data for 2 GiB of RAM,
too.

Fixes: 8045df14bcca ("microvm/acpi: add minimal acpi support")
Cc: qemu-stable@nongnu.org
Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
---
 hw/i386/microvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 18983a363b..b35facce08 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -330,7 +330,7 @@ static void microvm_memory_init(MicrovmMachineState *mms)
     rom_set_fw(fw_cfg);
 
     if (machine->kernel_filename != NULL) {
-        mmc->x86_load_linux(x86ms, fw_cfg, 0);
+        mmc->x86_load_linux(x86ms, fw_cfg, X86_FW_DATA);
     }
 
     if (mms->option_roms) {
-- 
2.47.3



