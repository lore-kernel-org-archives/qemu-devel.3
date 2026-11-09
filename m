Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DFD606A33C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQQzI-0000s9-17; Mon, 09 Nov 2026 10:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.lamprecht@proxmox.com>)
 id 1xQQzC-0000rI-Cn
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 10:08:42 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.lamprecht@proxmox.com>)
 id 1xQQzA-0008D9-Bz
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 10:08:42 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 412DE4787D;
 Mon, 09 Nov 2026 16:08:33 +0100 (CET)
From: Thomas Lamprecht <t.lamprecht@proxmox.com>
To: qemu-devel@nongnu.org
Cc: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH for-11.2 0/2] hw/i386/microvm: fix initrd overwriting firmware
 data with 2 GiB of RAM
Date: Mon,  9 Nov 2026 10:33:41 +0100
Message-ID: <20261109150753.1727674-1-t.lamprecht@proxmox.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1794236912696
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
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A microvm guest booted with -kernel and -initrd and exactly 2 GiB of RAM
can fail to boot, as the initrd ends up on top of the ACPI tables and
other SeaBIOS data. With PCIe enabled, Linux then reports
"AE_NO_ACPI_TABLES" and finds no PCI devices, and kernels that probe
EDD hang. 2047 or 2049 MiB work fine. We hit this with Proxmox VE,
where 2 GiB is the default memory size. Patch 2 explains how microvm's
missing firmware data reservation and a heuristic in linuxboot_dma.bin
combine to cause this.

Patch 1 moves PC_FW_DATA to x86.h so that microvm can use it, patch 2
uses it.

Tested all combinations of TCG and KVM, the Debian 13 and Proxmox VE
kernels, Debian's and a minimal initrd, PCIe on and off, and 1024,
2047, 2048, 2049, 3072 and 4096 MiB of RAM, plus qboot with 2048 MiB.
Every boot found intact ACPI tables, started the initrd and – if the
kernel had the driver – found its virtio-blk disk.

Thomas Lamprecht (2):
  hw/i386: move PC_FW_DATA to x86.h as X86_FW_DATA
  hw/i386/microvm: reserve the firmware data area when loading Linux

 hw/i386/microvm.c     |  2 +-
 hw/i386/pc.c          | 14 ++------------
 include/hw/i386/x86.h | 10 ++++++++++
 3 files changed, 13 insertions(+), 13 deletions(-)


base-commit: f71afb409a87c4ecd0f9d63a5963eb645dfab780
-- 
2.47.3



